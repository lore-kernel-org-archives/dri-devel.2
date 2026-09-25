Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07372C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584EE10E205;
	Fri, 25 Sep 2026 08:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTN87C8D";
	dkim-atps=neutral
Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com
 [74.125.228.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADCE10E205
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:21 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so1023818a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 01:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790326700; cv=none;
 d=google.com; s=arc-20260327;
 b=Fwn1MlJU0uVUFrjQIfBEMy7y0XXvnYld6K9nGi9aOCjgQZLa97j53/eoKbtpr7aUec
 kb3ikNdh00B7W1udctmhCRxAU2nBhR1FgQ1JvmQ1mDunmnHIxuyKDku5FXbL1hyAYry2
 NnIYzLFumEqtvUGXuvWvB0dOmFFB6a87UkLOvKTGazwPrvzuUCVdCYYSRXUc8VzYSXz6
 Ai8L8xBV6CPGjeoyPr5ca154Hrr+uOVeSyyUAXrh43PI2bEqWpa8jW+ZPkPe10rFKFhf
 LfcWA8j/g9V4UOLGG9je5PeLLQPpiavkzRZyDzdYt+WcCtezsIOC/4LlJWptdfw6P24O
 uCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ehsnNAs5lqgd+jMHAHbLYiglcHWM9eLT3Pf26YZWoEs=;
 fh=MmvPwxVCA5QSfz6E433qo46Cbm9P1jZyTXpHElYJg2w=;
 b=boWC67Vpxt6Z0qFspnBN3kqCyqyAx739pgDaB5e1RowmioRKNC3mMTvIJ69f0dqspv
 NQMIr5Lw8FLa481yPyCkgvLZ0s7+7a0AkWJGVjToE2KvcD6K+SHgw1L4CncsDFpKyC8J
 j5bISIr6WBQAQl/8G8vTmIzOgel6A8TlViFBLShR8Ar5nZxcxchC3t9k6zZ6Fj4FbeDK
 xgm5X1RptTMak4Gesyhzg4J0GZ2bxbiz86EEfym1QDkxAiUteK/oV6Clx+CwmDEnPhGr
 mVjcBVVQsVV4xgPoZNZ8rLrUcM4z5IT4fTmhoX2wrzzCpqRkYkoGaN+SakmOUzy7OxEE
 cE3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790326700; x=1790931500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ehsnNAs5lqgd+jMHAHbLYiglcHWM9eLT3Pf26YZWoEs=;
 b=jTN87C8DsHjCNhkDisZzObamCh5s5GjbTBYJ3VTc7TiO5T8OJIBdm32l1DfbiVm41X
 b7mqfxHsN7pCw/1uv3+bQs59iSRkJPk4b7DgwEHQ8DVF9L6VD8gNo1np9IOZXnfAamtM
 Na5agkjw51j4hOUsBuWdEKsp2xtqDtgDjcc7G9XKURo0BgaLoMijonFSRTNqmrEJYEiY
 OXCnIv6aNZ4TLPlWXedc4ajldaQfprUzJZoz4woVtfNAumBBMiYJifyGIVwjLxkaRXAT
 veBrJYlMR1Xfv1bpWydO5RdhHobeCLWhW/e9tI9IOR3GHOCd586KfR5NchIKiWyGtcAI
 dKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790326700; x=1790931500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ehsnNAs5lqgd+jMHAHbLYiglcHWM9eLT3Pf26YZWoEs=;
 b=xAsQ2d9WAOpa+Ay3eBGg56prugSHEp0TBpt0hQwzPAHPVBbDcC/IGwNJn6WgdCAI68
 tQ0nVQa2sM58GoE33YKRny+ROuwucXE8ivf+Catc4HegfjCbs/GZ5j00lHF1M50siNvq
 fEWNhee7A5nE79m/RJL+962z270VoKhLeZXtt9lfNfRvTxjWi/D8I92CSiCs4SWdFD+A
 k2Iu+qjtmJm+udchKGtIL8IK4rcnGfrjc7EkvpphazZrgIQbn8acaxdGI4eox9b+HSbk
 a1s5D9vr/J6bE6LCrsNFxxp3OnuJNmKaZjtpor2dIlUd5GbQnt7TpTrHBcXbD9VtnTTm
 A81A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJZI1q/MWE3VeneHaXvsZtWer4J+LaN07ESBTTWQxOdIsq/aw3oMDvAFFrqDkYlTUy3nyorPCozUE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7dRoLntIG6osJHgKjjApK1+p8ienpULj/v2huJLd16idR6jpj
 YQddJxIutTIEbhpt9BMlQfqq3aVrTsZZ1AVxAjymhRNwRlJb3u7JvQ7YWv/P0Fy9VQ5zuvo2Kr7
 WVbN+FpRnj4BwiBj9zxeig0ClJX0xdz0=
X-Gm-Gg: AYBFou1gUPbp4Xgc0Srv7p9+kdZnOxzuDQ2S1MhjYj5tUWCVDUHJ2cIMiPlF6HPq+z+
 vXmSm2WFkf8dzjlTIxlPjT8iDqGKLcoJg5r9vRvPrhxmLGVbcBiqmvcTEFhfHxaihgkPArdo4eb
 Yt4KUFwcAdzxUXDvZHVe6j6otPH1NsR8GRptbwRCJqNjI2LAI6mQgWCuLjiKZ+BSktmP2eGhPcu
 ner8EDM9+ABuDxnfzM4Cih7kBEFHdjeKP+0H+oGoWtQhiF8SMVwpOh9e7UhSkADCt2ZnIS9iRgf
 LB7yRlzjKawj3q7JLoQOv+E+2yRf3ETEDH0mz7v0jExpD6oOWHgvPUY=
X-Received: by 2002:a05:6402:23c7:b0:6a5:f9cc:748b with SMTP id
 4fb4d7f45d1cf-6aac8f41743mr3736862a12.9.1790326699532; Fri, 25 Sep 2026
 01:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-3-maximpedraza@gmail.com>
 <179025038211.3068273.9854294306608483193.robh@kernel.org>
In-Reply-To: <179025038211.3068273.9854294306608483193.robh@kernel.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Fri, 25 Sep 2026 10:58:08 +0200
X-Gm-Features: AclHuK8UoHGNzTIzOHVGCymE1Tu15-rHTqYzXC5JvMhzujI-l5PLt4dMq7Zlh-4
Message-ID: <CAEUXW=Gh6wMk1i=x_KT0eSdkHeHs8Hkxkj4hfsuTRyY6=aphpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: display: add a device tree supplied
 boot logo
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
 Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Rob,

> Documentation/devicetree/bindings/display/boot-logo-clut224.example.dtb: =
chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl=
-[0-9]+$'
> from schema $id: http://devicetree.org/schemas/chosen.yaml

Expected: chosen.yaml only allows framebuffer nodes under /chosen. You
closed pull request 204 until the binding settles, so I will send a new
one for the node as it ends up.

> The base for the series is generally the latest rc1.

Noted.

The binding is going to change, though. Thomas asked for the logo to go
through the DRM splash client [1] rather than fbdev [2], and that client
takes BMP images. Before reworking it, would a BMP in a property be
acceptable to you:

chosen {
logo {
compatible =3D "boot-logo";
image =3D /incbin/("logo.bmp");
logo-position =3D <(-1) (-1)>;
};
};

with memory-region as the alternative to image, exactly one of the two,
or would you rather have the pixels described the way simple-framebuffer
does, with width, height, stride and format? The BMP keeps the kernel
side small, since the client already parses BMP headers, and the header
gives it a size to check against the property length. The raw form is
closer to what DT already describes, at the cost of a second drawing
path in the client.

[1] https://lore.kernel.org/dri-devel/20260510-drm_client_splash-v3-0-a9aee=
9f0b2fc@valla.it/
[2] https://lore.kernel.org/all/64e273d4-2660-437d-8871-e2bfa3c377c9@suse.d=
e/

Max

El jue, 24 sept 2026 a las 13:49, Rob Herring (Arm)
(<robh@kernel.org>) escribi=C3=B3:
>
>
> On Wed, 23 Sep 2026 22:10:30 +0200, Max Pedraza wrote:
> > Embedded products frequently need a product specific boot logo. Today t=
hat
> > means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, whi=
ch
> > bakes it into the kernel image: a change of branding, or a second produ=
ct
> > sharing the same board support package, requires a separate kernel buil=
d,
> > and requalifying that kernel for what is a cosmetic change.
> >
> > Add a binding for a "boot-logo-clut224" node, which carries the logo
> > in the same paletted format the built-in CLUT224 logos already use, plu=
s a
> > few optional properties describing where on the screen it is drawn.
> >
> > The node lives under /chosen because a logo is configuration handed ove=
r by
> > firmware rather than a description of the hardware. Open Firmware, whic=
h
> > the device tree descends from, carried a boot logo in the same spirit a=
s
> > the oem-logo variable under /options, and simple-framebuffer nodes live
> > under /chosen today for the same reason.
> >
> > The palette size is derived from the length of the "clut" property rath=
er
> > than spelled out separately, and "data" holds plain palette indices; th=
e
> > 32 entry offset the frame buffer layer reserves for the console is an
> > implementation detail and is applied by the kernel, not by the binding.
> >
> > "logo-position" takes -1 on an axis to mean centre on that axis rather =
than
> > carrying a separate boolean for it. A boolean can only centre both axes=
 or
> > neither, and next to explicit coordinates it would have to override the=
m
> > silently when a device tree gave both.
> >
> > A rotation turns the logo, not the screen. "logo-position" and
> > "logo-offset" are screen pixels whatever "logo-rotation" says, and a
> > quarter turn only changes how much room the logo takes up. Placing the
> > logo in a frame that turns with it would make the same pair of
> > coordinates mean different places on the same panel, decided by a
> > property that is meant to describe the image.
> >
> > Every coordinate is bounded. The kernel clamps them anyway, since it ca=
nnot
> > trust a device tree, but a value that cannot possibly be meant is worth
> > catching in dtbs_check rather than on the panel.
> >
> > Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> > ---
> >  .../bindings/display/boot-logo-clut224.yaml   | 135 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 136 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/boot-logo=
-clut224.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/boot-logo-clut224.example.dtb: =
chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl=
-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/chosen.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260923201035.=
51007-3-maximpedraza@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>
