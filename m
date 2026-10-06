Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87765CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB94010F222;
	Tue,  6 Oct 2026 07:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JmtfK5pp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC08D10F21E;
 Tue,  6 Oct 2026 07:35:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E5B94114E;
 Tue,  6 Oct 2026 07:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F05E1F000FF;
 Tue,  6 Oct 2026 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791272132;
 bh=PbJj10g8RXmT0WH9I/070gv9/ui69tpZnPuIzzA9ER0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JmtfK5ppc6oY76vmJ4FMJh2ufra09XYY8DcW8mXoUs52ME7XBbXRZNegpP543ZnIO
 3XfODoBNkQFDX5xvOc9NNRjN5wqusCZf1uUsADp4+r69gaFWKs7cU00ZOCjrK/gg5t
 4l6x25g/9Le9n/10iupgP0lCVtuk84ch80Fb25ctU1kXdKtIJbJFxy2/Ux7sQHNIDE
 UIl5phHQ04o+t0J8txNuJZx86ImFdRVsQxbwFwfqV/w4eQsjzibYCujYZbOjqBns6Q
 8x8CMys9V2wMuEBAuNqSL3elRVllxPD/HJRgm18coCSWE7aXh00fR4N12ia9J4RDx8
 mwmIEKUCo7a9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] gpu/buddy: search lower orders in contiguous
 try-harder fallback
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261006072643.211568-2-arunpravin.paneerselvam@amd.com>
References: <20261006072643.211568-1-arunpravin.paneerselvam@amd.com>
 <20261006072643.211568-2-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 07:35:31 +0000
Message-Id: <20261006073532.2F05E1F000FF@smtp.kernel.org>
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
- [High] gpu/buddy: exhaustive anchor search in __alloc_contig_try_harder c=
auses spinlock lockup
--

commit 7497fb4969675f5a56fcaeefb846b3d3c4a2cff7
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: search lower orders in contiguous try-harder fallback

This commit modifies __alloc_contig_try_harder() to descend from the size
order down to min_order. This allows the allocator to build a span from
adjacent lower-order blocks when a single buddy order is empty.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index d8e7b79907157..239249362c9ea 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -1775,6 +1776,12 @@ static int __alloc_contig_try_harder(struct gpu_bu=
ddy *mm,
>  		iter =3D rb_prev(iter);
>  	}
> =20
> +next_order:
> +	if (order > min_order) {
> +		order--;
> +		goto retry_order;
> +	}
> +

[Severity: High]
Could this exhaustive anchor search cause a spinlock lockup?

By descending down to min_order (which can be 0), a large contiguous
allocation request under fragmented memory might test up to millions of
order-0 blocks. Because this fallback iterates over all free blocks of a
given order while holding the allocator spinlock, could executing this
many rbtree operations and function calls lead to latency spikes or
watchdog soft lockups?

If untrusted userspace graphics APIs create fragmented VRAM and then
request large contiguous buffer objects (e.g., via
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS), it appears this path could be
triggered, potentially causing a denial of service. Checking many smaller
anchors instead of only checking anchors sized for the allocation request
increases the worst-case iterations by orders of magnitude.

>  	return -ENOSPC;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006072643.2115=
68-1-arunpravin.paneerselvam@amd.com?part=3D2
