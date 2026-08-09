Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11710C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 18:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7AD10E0B4;
	Sun,  9 Aug 2026 18:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eKZA6PHl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA3510E0B4
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 18:44:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79279410B2;
 Sun,  9 Aug 2026 18:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B9B1F00A3A;
 Sun,  9 Aug 2026 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786301093;
 bh=f2Ph6cWE1E2ebXrfPD+OQ4qq/lXHkSSgmsZrnriYdvU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eKZA6PHlcxnXCYXD7WRjCZhiH8D3t0oWtqA3RmJujmRAJa1avfvDr71jbzy109qjN
 p+d0UsU7tMDA2KeGnZq2Cv5Ql8JdSf77ufhYCN/kgaUlL148Id2ZBYM+XnuJEF//tF
 bkp+/YRGW2QQjwuLY2rRCjaz4nw72Z/YXKb2K6jqDmyNcTVLu5IU2rFKm/tN2Zq6Jm
 D4ZMGLBydolXmGSV6f9/jO2/jb0pSrSXtzdcUiNY4MAUgc5Un2/a4tbvI0n5wNwrSi
 ncRRmY3uxY/zAn3tgxEhBIOb3p67n9sPVzorNWhFy4g8NczMfpkOtxDuVHHHt6w40J
 iLEvs+ID3kfCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/12] virtio: expose device memory buffer occupancy
 over debugfs
To: "Alexander Graf" <graf@amazon.com>
Cc: dri-devel@lists.freedesktop.org, nvdimm@lists.linux.dev
In-Reply-To: <20260809182010.32931-12-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-12-graf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 18:44:52 +0000
Message-Id: <20260809184453.14B9B1F00A3A@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `virtio_dmb_hiwater_set` contains a TOCTOU race with `virtio_dmb=
_inc_used` that can cause the high-water mark to be permanently set lower t=
han the current total usage.
--

--- Patch [11]: [RFC PATCH 11/12] virtio: expose device memory buffer occup=
ancy over debugfs ---
commit 821ee4cbeac917d62e62a95c88f58236d2f6db9c
Author: Alexander Graf <graf@amazon.com>

virtio: expose device memory buffer occupancy over debugfs

This commit adds debugfs files to expose the memory occupancy of virtio
device memory buffers when CONFIG_VIRTIO_DEBUG is enabled. It introduces
counters for total allocated pages, allocation failures, and a high-water
mark to track peak usage.

> diff --git a/drivers/virtio/virtio_dmb.c b/drivers/virtio/virtio_dmb.c
> index 42126f928bc06..fe556d585f244 100644
> --- a/drivers/virtio/virtio_dmb.c
> +++ b/drivers/virtio/virtio_dmb.c

[ ... ]

> +static int virtio_dmb_hiwater_set(void *data, u64 val)
> +{
> +	struct virtio_dmb *dmb =3D data;
> +
> +	/* Restarting the measurement is the only meaningful write. */
> +	if (val)
> +		return -EINVAL;
> +
> +	/*
> +	 * Restart from what is allocated now rather than from zero, so that
> +	 * the file never reports a peak below the occupancy it is read
> +	 * alongside.
> +	 */
> +	atomic_long_set(&dmb->used_hiwater,
> +			atomic_long_read(&dmb->total_used));

[Severity: Medium]
Can this sequence result in the high-water mark being set lower than the
current total usage due to a race condition?

If a write to the debugfs used_pages_hiwater file occurs concurrently with
new allocations, could we see the following sequence:

Thread A reads total_used (e.g., 10) in virtio_dmb_hiwater_set().

Thread B allocates memory in virtio_dmb_inc_used(), increasing both
total_used and used_hiwater (e.g., to 110).

Thread A then blindly overwrites used_hiwater with the stale value (10)
using atomic_long_set().

This seems to contradict the comment above it, leaving used_hiwater
substantially lower than total_used. Is there a way to safely read and
update this to avoid a time-of-check to time-of-use race?

> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_hiwater_fops, virtio_dmb_hiwater_get,
> +			 virtio_dmb_hiwater_set, "%llu\n");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809182010.3293=
1-1-graf@amazon.com?part=3D11
