Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC0606A68D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzvtsKQb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056510EC41;
	Mon, 23 Nov 2026 17:10:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD2810EC41
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:10:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2E3D43369
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE9F1F000C4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795453823;
 bh=RySVhyUKxOIkkYeUQanX9OHNKWehuVaDXaE4dthCSVE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=FzvtsKQbLo1q8aCg84wdufyXbujk1cDouJajmBckUg1IpyaIua59SUtz3lYeyZc4b
 YpRRtsLhZCVfxw/cif3HbNB+XBQWzApUGeSnuYWNWd9rGK3QqACnW8BZscfcSDo4zb
 Az4GKL2vLxhzCMRJV67Kxsi9gDAcQaopKHTYtveM1GTv/r57NPTDGwGib7E0RjorVA
 delH5gChDKyN/NHhd0K0zQfWTl+Q1tfdY7NFcEHmEs7DzqSM/zmKLMcYVC73UUIsm+
 8jMt996vPsRajxaX3L/8D3ro3bZkbDsny99Q+vYsKGxCdBjNzzeV3Ofk0pVa1Pktyb
 ej+7jwUN+n1FA==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b8627e0eb2so4587378a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:10:23 -0800 (PST)
X-Gm-Message-State: APuU4Z/wtoKPsadXE9XMlIbWczudBvzQNQtl78Ryny7OcbJLNA8DfwL/
 3XROo5SQZUt7mONiYFykoLX1Hwx8B6vSp8sR5c5P/87jc1kGaBKJaCq95F7z56CSOe0W5i7c9uT
 tcJ0S7R+WNYk5FTYfWUH8L8WO/VpPLA==
X-Received: by 2002:aa7:c717:0:b0:6b5:8200:5008 with SMTP id
 4fb4d7f45d1cf-6ba37ec67b3mr6296136a12.45.1795453822178; Mon, 23 Nov 2026
 09:10:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
 <20261120-ethosu-fixes-v5-14-52d459acdb84@kernel.org>
 <sashiko-outbox-225427@kernel.org>
In-Reply-To: <sashiko-outbox-225427@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Nov 2026 11:10:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLgK_Hut5d641FHCdKQJ6VCXzrMc6+6Gjmk4fYNs3Mgg@mail.gmail.com>
X-Gm-Features: Aa3M54pgSsvJCdw8I0iETcFDtx1WDDEEUPRNbfI62x-L0NF1z7vlODvndshvKMM
Message-ID: <CAL_JsqKLgK_Hut5d641FHCdKQJ6VCXzrMc6+6Gjmk4fYNs3Mgg@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] accel: ethosu: Validate OFM transpose
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 9:07=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Critical] accel: ethosu: missing NHCWB16 format check when OFM
>   transpose is set
> --
>
> commit 819bad25b9dbcbe54db35bf0c5afd5f5f47c3c99
> Author: Rob Herring (Arm) <robh@kernel.org>
>
> accel: ethosu: Validate OFM transpose
>
> This commit adds validation for Ethos-U85 output feature map (OFM)
> transpose encodings and permutes the OFM dimensions before validating
> tile and stride accesses.
>
> > diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/e=
thosu_gem.c
> > index 0ab73b99c458c..b8f840ab1ceed 100644
> > --- a/drivers/accel/ethosu/ethosu_gem.c
> > +++ b/drivers/accel/ethosu/ethosu_gem.c
>
> [ ... ]
>
> > @@ -1029,8 +1083,19 @@ static int ethosu_gem_cmdstream_copy_and_validat=
e(struct drm_device *ddev,
> >               case NPU_SET_OFM_PRECISION:
> >                       if (((param >> 6) & 0x3) > 1)
> >                               return -EINVAL;
> > -                     if (!ethosu_is_u65(edev) && (param & GENMASK(13, =
11)))
> > -                             return -EINVAL;
> > +                     if (!ethosu_is_u65(edev)) {
> > +                             u32 transpose =3D FIELD_GET(NPU_OFM_TRANS=
POSE_MASK, param);
> > +
> > +                             switch (transpose) {
> > +                             case 4:
> > +                             case 5:
> > +                                     return -EINVAL;
> > +                             }
> > +                             if (transpose && ((param >> 1) & 0x3) =3D=
=3D 3)
> > +                                     return -EINVAL;
> > +                             if ((param >> 14) =3D=3D 2 && transpose)
> > +                                     return -EINVAL;
> > +                     }
> >                       st.ofm.precision =3D param;
> >                       break;
> >               case NPU_SET_OFM_REGION:
>
> [Severity: Critical]
> Should NPU_SET_OFM_PRECISION also reject a non-zero transpose when the
> activation format is NHCWB16 (((param >> 6) & 0x3) =3D=3D 1)?
>
> OFM transposition on U85 is only valid with the linear NHWC format.  If
> NHCWB16 is combined with a non-zero transpose, feat_matrix_validate() onl=
y
> requires NPU_SET_OFM_STRIDE_C to be set, and feat_matrix_length() compute=
s
> the NHCWB16 brick offset on the coordinates already permuted by
> feat_matrix_permute() while ignoring fm->stride_x.  That can underestimat=
e
> info->region_size[fm->region] and allow out-of-bounds NPU DMA writes past
> the end of the GEM buffer.

Incorrect. See U85 TRM, =C2=A73.6.5, pp. 191=E2=80=93192
(https://documentation-service.arm.com/static/67b5ba01ce2747241fce860f#page=
=3D192)
explicitly supports NHCWB16 with transpose. It requires block-width
multiples of 16 for HCW/CHW and block-height multiples of 16 for
CWH/WCH.

Rob
