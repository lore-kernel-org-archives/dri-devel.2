Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDFCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E31C10ECC6;
	Tue, 23 Jun 2026 21:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qdry8hfz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539E210ECC6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:11:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A271B60008;
 Tue, 23 Jun 2026 21:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ACD1F000E9;
 Tue, 23 Jun 2026 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782249071;
 bh=XyIAzgPBzZsEl3IkHGIFkU/IFI5HXBjvscWs448WQ1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qdry8hfzp+PZEXGSrOPXI3ywmdtgeaKyORtgF0qxRNhxK6r6wXOPc4NRMUzd0Cqk/
 rjzQIuhNqzId9rePccdHErUVtefHS6cQAHBVjwfvHyi/URcLD9rRNiDQApvE/xLvw9
 LLsFV0lhH7Glwo39kwpqaQ4pRyDqEA2RUKm6HtOC8bo8WMYw7TAjukyw8Tm7wEd/Sg
 Ktt89DKs0y45+Mwojtx44bQYUlHfRfsfa2F9PzH71WfX2BoIfb1wkLrQ2MzVeUBxD8
 sHLTZPdg/kvKloEKKJULYKLiHY/z3ZPHUNuZBswVwlB2XYs19hcA7mOgJuq4EHhQpz
 Mv0F7RQLB1LnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] gpu: nova-core: gsp: make unload take
 GspBootContext
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260622-nova-bootcontext-v2-6-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
 <20260622-nova-bootcontext-v2-6-0ddeafc06f5d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:11:10 +0000
Message-Id: <20260623211111.32ACD1F000E9@smtp.kernel.org>
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
- [Low] Early failures in `GspHal::boot` return a dummy `EAGAIN` error for =
the unload bundle, triggering misleading warnings in `Gsp::boot`.
--

commit 59b7c0f9ed708bf2f09f8548faf948cfa1adfc96
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: make unload take GspBootContext

This patch refactors Gsp::unload to accept GspBootContext instead of
individual resource arguments. This reflects that the resources required
to boot the GSP are also needed for unloading it.

> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 3f11eaec26c78..336ad23c96f9b 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
[ ... ]
> @@ -102,7 +100,7 @@ pub(crate) fn boot(
>                  dev_err!(dev, "GSP boot failed with error {:?}\n", e);
> =20
>                  // Ignore errors during unload; we will return the error=
 that happened during boot.
> -                let _ =3D self.unload(dev, bar, gsp_falcon, ctx.sec2_fal=
con, unload_bundle);
> +                let _ =3D self.unload(ctx, unload_bundle);

[Severity: Low]
If an early operation in the HAL boot paths fails before unload_bundle is
properly initialized (such as Vbios::new() failing in Tu102::boot(), or
missing fsp in Gh100::boot()), does unload_bundle retain a dummy
Err(EAGAIN) value?

If so, does this cause the inspect_err() on unload_bundle to unconditionally
trigger and log misleading warnings that falsely claim the GPU will need a
reset even for these early initialization failures?

> =20
>                  Err(e)
>              }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-nova-bootc=
ontext-v2-0-0ddeafc06f5d@nvidia.com?part=3D6
