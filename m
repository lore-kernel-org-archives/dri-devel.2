Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD17C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2150B10E179;
	Sat, 12 Sep 2026 07:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PoQ9YhpY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BEE10E179
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:27:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5732040C0D;
 Sat, 12 Sep 2026 07:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3811F000FF;
 Sat, 12 Sep 2026 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789198054;
 bh=DuQiApmn2yd+pWcGX7c++s+AboLeCJsWLWqpyYXLihw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PoQ9YhpYokQVLUvZdLObv0NRJdN7aAOlkIFUP6C+I9jqeX5eQFt0VO90/fsNpK62g
 agYySm2z8BAjbypo/C9gu1xRLz4PblxMfuaaByeuWkWVr0L1G4H5qOhclJ9Kolj03S
 zHA9zyI8X1p0segnsaYUW3wz1b0UwWTCLmupf5szIH1qJfTsV5E4cGY8hAYW09xKof
 vUBLSSPuxFUgHipmmVK1+BJLb+pl6TnUc5qL63uJs05w5y4VyrophmJY21UAWmh9jl
 p5yXPTSy/Xct4MvOQWIXA1x5qhbW+Z7hCW/daR+DiByhVJjAQ8C1Z+X5nYR3L9dKhU
 JeD2IxotXlpiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] gpu: nova-core: gsp: retain the GSP-RM log
 buffers after unbind
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912071842.622696-3-vladazaharova2018@gmail.com>
References: <20260912071842.622696-1-vladazaharova2018@gmail.com>
 <20260912071842.622696-3-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:27:33 +0000
Message-Id: <20260912072733.ED3811F000FF@smtp.kernel.org>
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
- [Medium] The safely-read `put` pointer is discarded and overwritten by an=
 unsynchronized `put` pointer during the bulk log data copy, undermining th=
e preceding DMA barrier.
--

commit f151b2c49feb508fe7910dc5dccc6fabd8696fdb
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind

This commit adds a gsp_keep_logs module parameter to retain GSP-RM log
buffers in memory and debugfs after the GPU is unbound. This is useful for
debugging probe failures or timeouts. It also moves the log buffer code into
its own file.

[ ... ]

> diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-co=
re/gsp/logbuffer.rs
> new file mode 100644
> index 0000000000000..22c47f1991698
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
Does the bulk copy overwrite the synchronized put pointer with an unsafe re=
ad?

The code reads the put pointer and correctly issues a DMA read barrier.
However, the copy_to_slice operation reads the entire buffer starting from
offset 0, which includes the put pointer.

During a hardware timeout where the GSP is still actively appending to the
log, could this bulk copy capture a newer put pointer that gets paired
with stale log data read earlier in the copy sequence?

If this happens, a userspace parser reading the snapshot might read past the
actually valid data and parse garbage, defeating the purpose of the barrier.

Could the copy_to_slice operation be adjusted to only copy the data region,
or should the safely-read put pointer be explicitly written into the
snapshot after the bulk copy completes?

> +
> +        Ok(snapshot)
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912071842.6226=
96-1-vladazaharova2018@gmail.com?part=3D2
