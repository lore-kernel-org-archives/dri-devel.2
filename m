Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC3DC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CD510E06A;
	Wed, 23 Sep 2026 05:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QIhajE0f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18AC510E06A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:05:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 853CE4139D;
 Wed, 23 Sep 2026 05:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250941F000FF;
 Wed, 23 Sep 2026 05:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790139926;
 bh=ZTXzDQjWvgWBqoEIMVjcMuPVDwtjpHxtuerbSQxW8tk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QIhajE0fZXu4HqskubilYAyIzUqqGuFw00fA0ZLcf+FdsSDvgGzJiPBluTq9ovkz7
 x0c0BjMv+K5Hv64xISv2jg8NomvbapxgAg2h7pvAQ5eUnLCRp6cQnDNtCm5zfORU0j
 N1Uc5a7wUUeBCsfa6cpn+2YPrTE/RQrIsFGt2TGBZwWBWPVKhb6vr7sHClR/Xlo1ns
 EMtFQ5fJMFb+RTdd47aHckMTTQ2EIpLcLY5UtXSlnamfdPzRqSWwU43WTipjYaQgyC
 u3ZwLFHbXgvrYAUz43dbXzkOV3aOusoq3+uVGkoTrn8CnLvV51JBIOs74uL5vNNorv
 wcUEl4rNrlA9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] gpu: nova-core: gsp: retain the GSP-RM log
 buffers after unbind
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260923045551.229259-3-vladazaharova2018@gmail.com>
References: <20260923045551.229259-1-vladazaharova2018@gmail.com>
 <20260923045551.229259-3-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 05:05:25 +0000
Message-Id: <20260923050526.250941F000FF@smtp.kernel.org>
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
- [Medium] gpu: nova-core: unordered put pointer in log buffer snapshot
--

commit e3a18fe9cea338c661ee3d185d004b01a5ff3d7d
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind

This commit adds a gsp_keep_logs module parameter to retain GSP-RM log
buffers after GPU unbind or probe failure. It creates copies of the
buffers in memory owned by the module and exposes them through debugfs,
moving the buffer logic to a separate logbuffer.rs file.

> diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-co=
re/gsp/logbuffer.rs
> new file mode 100644
> index 0000000000000..b1f912fb3fae1
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
[ ... ]
> +    fn snapshot(&self) -> Result<VVec<u8>> {
> +        // Offset 0 holds the "put" pointer, which the GSP advances as i=
t appends entries. It is
> +        // still zero if nothing was ever logged, which is all that is t=
ested here: a buffer that
> +        // was written to is copied whole, and making sense of "put" is =
left to the decoder.
> +        let put =3D io_project!(self.0, [build: ..size_of::<u64>()]).try=
_cast::<u64>()?;
> +        if put.read_val() =3D=3D 0 {
> +            return Ok(VVec::new());
> +        }
> +
> +        // ORDERING: LOAD->LOAD ordering needed to order the "put" read =
before the data read. The
> +        // GSP has normally been stopped by the time this runs, but a bo=
ot that timed out can leave
> +        // it still appending.
> +        dma_mb(Read);
> +
> +        let mut snapshot =3D VVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
> +        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);

[Severity: Medium]
Since copy_to_slice() reads the entire buffer, including the put pointer at
offset 0, and has no internal read ordering guarantees, can the read of the
put pointer inside copy_to_slice() be reordered after the data reads?

If the GSP is still appending data concurrently (e.g. after a boot timeout),
the snapshot might capture a newer put pointer but stale log data. This cou=
ld
cause the log parser to read garbage or fail, defeating the purpose of the
explicit dma_mb(Read) barrier.

> +
> +        Ok(snapshot)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923045551.2292=
59-1-vladazaharova2018@gmail.com?part=3D2
