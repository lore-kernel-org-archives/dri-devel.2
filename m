Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F8CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2C510E274;
	Thu, 11 Jun 2026 17:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LnsOUic6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9B010E274
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:15:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21D4341B58;
 Thu, 11 Jun 2026 17:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C9C1F00893;
 Thu, 11 Jun 2026 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781198139;
 bh=JLvdfWSCm/54x6keqqqX23HM8ntLWBTzs5SmYTGEFOw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LnsOUic65IMYyuSdcKTt6UP2YGpm+frbZvhqgwgIJTN6HqIvFRxNBhJAVmlhZah7I
 LoN1UC4VQSJD+fUbuGJEXLBHF1Z2DYsXbnAFm+gQNV+Ak5XxgegwAFyZl2cv0CtYNL
 4xxrxxAQvN8s7bUS+ObjoJML4Mbyc6iBOVbV1X2jPshBEEANcJ1tTteJY4DLg/zJed
 WnNFXUZ2v242+Ih+2GJbdAHsxBuGGdklQ+E4ISb5dGJturoTVVBZj6xscmKRVmkcvh
 0V8TlOnpzQqV7zK9Tb8yUV3tko+bUVtJ3VHx+P6IgOeVme5XpoBY6fBnQy4K6c2puo
 5V7/5+B7szUVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:15:37 +0000
Message-Id: <20260611171538.B5C9C1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Resource leak of I/O mapped virtual memory in `IoMem::ioremap` upo=
n `MmioRaw::new_region` failure.
--

commit 341339f8ea263586994f368a12f84cd531475a2a
Author: Gary Guo <gary@garyguo.net>

Update MmioRaw to use the dynamic-sized type Region<SIZE> instead of
representing compile-time known minimum sizes directly. Implement Clone,
Copy, Send, and Sync manually due to raw pointer usage.

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index fc2a3e24f8d5..9e15bc8fde78 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs

[ ... ]

> @@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resourc=
e) -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D MmioRaw::new(addr as usize, size)?;
> -
> +        let io =3D MmioRaw::new_region(addr as usize, size)?;

[Severity: High]
This is a pre-existing issue, but does this early return via the ? operator
leak the mapped I/O virtual memory in IoMem::ioremap()?

If MmioRaw::new_region() fails (for example, if the device's hardware size
is smaller than the statically requested SIZE), the ? operator causes an
early return with an error.

Because the IoMem structure is not yet fully constructed, its Drop
implementation is never invoked. This means bindings::iounmap is bypassed,
abandoning the raw addr pointer and leading to an unrecoverable leak of
vmalloc space.

>          Ok(IoMem { dev, io })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D5
