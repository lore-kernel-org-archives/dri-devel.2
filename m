Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D76BC61DE1
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B5B10E16F;
	Sun, 30 Aug 2026 19:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k9Z+pPyg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3174C10E16F
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D836D43D1F;
 Sun, 30 Aug 2026 19:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F61F000E9;
 Sun, 30 Aug 2026 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788119859;
 bh=c7Q1bEueBVKo6eLEq4nylVlFjHoFofzqyV6AAXosIVc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k9Z+pPygn2nZvbAlJSTzqj8/W23Aj5cTvq1TZOaUNZ0JyS/mVLC/opvjkBU1YCoT5
 Qlky995gfv/N0+L6pZLJ3pUXvCMx/00aM3bP7Y9m+FxRNHao17z52Eai6i8Iudw1ch
 kmYiOKBGtB3txxFhhUIZLf9Lk3iYaTc5CB4oNOeh8tquSFVrun6N4F9mFLXV6lLLdt
 texgHa7PAi0jNELDtvbx38O84km8EIlnkqpd/okCDeioYon06UBzrIdvLvdQnJPdCc
 kZAh2WxlkZ59kA6BxhTS2HCD6jxXg2rrMskvGIUyzb5lk9AAMirTsSk7dToheZ3b0/
 vtwWdnRaiLmFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] samples: rust_dma: separate driver type from driver
 data
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260830193824.471089-4-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:57:39 +0000
Message-Id: <20260830195739.6E4F61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing generic lifetime parameter on Generic Associated Type (GAT)=
 `Self::Data`.
- [Low] Type mismatch between `&pci::Device<Core<'_>>` and `&pci::Device<Bo=
und>` in struct field initialization.
--

commit e990389a909f2dd12217de05acd654c0fd95ac40
Author: Danilo Krummrich <dakr@kernel.org>

samples: rust_dma: separate driver type from driver data

This commit splits the DmaSampleDriver into a driver type and a separate
DmaSampleData struct for device private data. It updates the associated Data
type to carry a lifetime bound, preparing for future changes to
dma::Coherent.

> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index bd60034ded23a..0fac9d4ae566e 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
[ ... ]
> @@ -67,13 +71,13 @@ unsafe impl kernel::transmute::FromBytes for MyStruct=
 {}
> =20
>  impl pci::Driver for DmaSampleDriver {
>      type IdInfo =3D ();
> -    type Data<'bound> =3D Self;
> +    type Data<'bound> =3D DmaSampleData<'bound>;
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
>      fn probe<'bound>(
>          pdev: &'bound pci::Device<Core<'_>>,
>          _info: Option<&'bound Self::IdInfo>,
> -    ) -> impl PinInit<Self, Error> + 'bound {
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              dev_info!(pdev, "Probe DMA test driver.\n");
> =20
> @@ -94,8 +98,8 @@ fn probe<'bound>(
> =20
>              let sgt =3D SGTable::new(pdev.as_ref(), pages, DataDirection=
::ToDevice, GFP_KERNEL);
> =20
> -            Ok(try_pin_init!(Self {
> -                pdev: pdev.into(),
> +            Ok(try_pin_init!(Self::Data {

[Severity: Low]
Does this code build without explicitly providing the lifetime parameter
for the Generic Associated Type (GAT)?=20

Rust typically requires explicit generic parameters for GATs used in paths,
so using Self::Data here might trigger a missing generics build error.

> +                pdev,

[Severity: Low]
Is there a type mismatch during the struct initialization here?

The probe() function receives pdev as &'bound pci::Device<Core<'_>>, but
the DmaSampleData struct definition expects &'bound pci::Device<Bound>:

struct DmaSampleData<'bound> {
    pdev: &'bound pci::Device<Bound>,
    ...
}

Since implicit Deref coercions do not apply to struct field initializations,
this direct assignment could cause a compilation failure.

>                  ca,
>                  sgt <- sgt,
>              }))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193824.4710=
89-1-dakr@kernel.org?part=3D3
