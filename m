Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2763CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C210E1BA;
	Wed, 10 Jun 2026 19:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q+Rz8dKj";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C523410E1BA
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:24:50 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e6da33a561so5839973a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781119490; cv=none;
 d=google.com; s=arc-20240605;
 b=fkUnLPisPSHrX1W6aDdkuuESruhtzR1ap4PK+RNVMNxbFuMSTTDElpcabFQPv9PwR9
 6IwP72d6z2+ARpw97he8GELKbFfEkUwd1R8MFqsTrtThHvss7ldeK8B8HIwAPJpg0Ppv
 1sw9JD279O7SZXcVlad908HjMKW2zx0w5q2UkSI/C873mRQ9x4uJyzByNOHPZDFhBzfW
 kbwThLcjEAa2HMASYG3a45YrFwdqjyVmD5zFG/AYN/IPPhs0imt9wK1hPkeCMb6vtAsz
 d/KMmNRF457gWz+08siuL9IKO9flpzq2rHIq2wCy7aB4rBNbBSaSuf0eSlSxaEZvLGqy
 Ea1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
 fh=3maPQvOMukXgxE5VdarUG8ciYI/XUSj2+4xkPiLtZ6k=;
 b=KtB1oxHiGzckWWf6Z2u4lKFtt7bugNS9niDvHmLvGjGaXMxCjSk9yyN0EYhZHV5+1P
 lD6ONMgwYP1dNHzOOjPvjYrUwJX5OymQkAf4y8dGF9BlChQC/7IAJFsUfGAg0zXB9fKh
 rSOKo0CMjqHO++XeweEktB/Xp7La3Sp/5TbIOJ+/PIfGFMNl8CGFvdAI5zPhqof1x6su
 Cexdc1y29qNRBuotvokiidUk7i2GrdEy9Hi8groD7BRL/eXyqYLYg1TpnbEJqRanVhv/
 Zy5DjpgsGOg+wBzyHOc8Gh3u9M8678/RfgfLZCHvtgblOJx57obdygPnTB5MvPAy7TwH
 JMgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781119490; x=1781724290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
 b=q+Rz8dKjOX6PQrVRnaGVQYY62SJA2BQxhHD6pNdWsBu6s0dXPVhIcYamh6TO46PWpZ
 DlsKOlqV09eQzc0lDn425b6xA5twZzPfo9+gOpHR/KA+U0to53szgZFnIXGIJiYe2UHH
 zhkJEbSWIgYMGIdOFAVRJwqCRb7QJl7EF7JKbPHHnGNqXrmhZ1/NkUqpUz0Std+ZJBDO
 OmqcC2y1DPeRJjT+Y8/9VE9UhZ1+fTeOeZxvDAnXzVnOZr+zBxr3dUU6NZrYGXodvCIs
 xPyiEb4GvTydwee5/pO2OUNmeDBZDtfgRPKqbrv4UpVOH3ofVGEeWvH3071YiwSeYlYL
 f/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119490; x=1781724290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
 b=fgm56KlxsJZ8tm0RT073jsyr6i37Pwwx2MKTevit7vflwh5nm9KjC8ZJGY4WVKpmz1
 8fGMaJW29ReV9lZ8x4j5tbHP928XJj0JvlpfjyRIM8RNtq/6+jpFiGsoxVLUF9o685uU
 CDXYArqLmmjnEwGsUpaMnbJtJp7yNM3QL5blPRs4c+2oX1t5dfLEIGQHzDGa1xRvIfeJ
 bqVHKIuCNvZd7wVmQ3VWygEC/W8y07sMBlOkIas18U7uDkRkr9qQH8gIW3dzS4LOAvTR
 nL7AknIRFFQPkjqXBdgv6tMB9geUI1undG/GW2ifJHDvyOqxzg2kCDFIcQxOup6Oc80d
 rSzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DQc2bVlHuewoU/U4EYKZJKEFlGvDGvvAsiEhdCCqup1AKyWJoR2qWMEonfWyqZXgchxArKl/4qM4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYL+w1H0a/qC+sxqijyMM+G2fqvdoJJqt/00Wcue1EKEsCYAlJ
 7IyPugVlmgREKVMeL9VnpLsgppFu6rh9nXomabOXpMoAL5LEW25On4CzZviQPgQ+jwvcvz57fV9
 7gf7lcJsbDGcMlwdz6D/iJyDRmAAllnI=
X-Gm-Gg: Acq92OFEQDjERFzG7U65p3qEfYQlPBMNOBrn6DO1tufV6RqmLmQ2jY1jN6aVB3ZgoRA
 alprtT4ZBFoihsB+eI3tJ70zQ8jNesYmD4ZU5ofxYDyQ7Oc1KOBnjy3NrYlFkk3rRbtOkbklr6z
 Yt272CzeE7t82/He3s2KNnwSsOs7ec/IBVfh3dLTYQxpfpLpH9QTiOrwFMoVP94v/UlLtYaceCf
 /qG9O3tNbijuL+f3TTozjgtB9v2ntSetI4kKz9laHKXWf48cGhv4TKIHyZFnLszIx+DbOlPOJjO
 7IHGKU0UzcXzBjTRfA==
X-Received: by 2002:a05:6820:221b:b0:69e:3c64:7f61 with SMTP id
 006d021491bc7-69e68c06118mr2868355eaf.31.1781119489522; Wed, 10 Jun 2026
 12:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 10 Jun 2026 21:24:38 +0200
X-Gm-Features: AVVi8Cf3u6Xv3TtQDxSRMDkc9Nu5lMT9FCK2mtYagN7OZm9Yts7qmkNi0JB-0eI
Message-ID: <CAMeQTsbqm=pxgjreZcmH39x2ELkipXFzxW0OHG2g+09De2yHYg@mail.gmail.com>
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org
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

On Mon, May 4, 2026 at 5:05=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

Since it touches multiple drivers, perhaps a drm-misc maintainer can take t=
his?

-Patrik

> ---
> Hello,
>
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
.com/)
> and that requires named initializers. But IMHO it's also a nice cleanup
> on its own.
>
> The anonymous union will allow changes like the following:
>
> -       { PCI_DEVICE(0x8086, 0x8108), .driver_data =3D (long) &psb_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr =3D &psb_chip_ops =
},
>
> (together with the respective change in the code when the value is
> used). This gets rid of a bunch of casts and thus slightly improves
> type safety.
>
> Best regards
> Uwe
>
>  drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
>  drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
>  drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
>  drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
>  4 files changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 005ab7f5355f..039da26ef24d 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent);
>   */
>  static const struct pci_device_id pciidlist[] =3D {
>         /* Poulsbo */
> -       { 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_=
ops },
> -       { 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_=
ops },
> +       { PCI_DEVICE(0x8086, 0x8108), .driver_data =3D (long) &psb_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x8109), .driver_data =3D (long) &psb_chip_o=
ps },
>         /* Oak Trail */
> -       { 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> +       { PCI_DEVICE(0x8086, 0x4100), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4101), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4102), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4103), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4104), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4105), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4106), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4107), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4108), .driver_data =3D (long) &oaktrail_c=
hip_ops },
>         /* Cedar Trail */
> -       { 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0, }
> +       { PCI_DEVICE(0x8086, 0x0be0), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be1), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be2), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be3), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be4), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be5), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be6), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be7), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be8), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be9), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bea), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0beb), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bec), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bed), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bee), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bef), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 1ece1ea42f78..f9f7271ddbff 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops =3D {
>  };
>
>  static const struct pci_device_id lsdc_pciid_list[] =3D {
> -       {PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
> -       {PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
> +       { PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data =3D CHIP_LS7A1000 }=
,
> +       { PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data =3D CHIP_LS7A2000 }=
,
>         { }
>  };
>
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag=
200/mgag200_drv.c
> index a32be27c39e8..8ad4ddb60ee6 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
>   */
>
>  static const struct pci_device_id mgag200_pciidlist[] =3D {
> -       { PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_PCI },
> -       { PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_AGP },
> -       { PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_SE_A },
> -       { PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_SE_B },
> -       { PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EV },
> -       { PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_WB },
> -       { PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH },
> -       { PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_ER },
> -       { PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EW3 },
> -       { PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH3 },
> -       { PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH5 },
> -       {0,}
> +       { PCI_VDEVICE(MATROX, 0x0520), .driver_data =3D G200_PCI },
> +       { PCI_VDEVICE(MATROX, 0x0521), .driver_data =3D G200_AGP },
> +       { PCI_VDEVICE(MATROX, 0x0522), .driver_data =3D G200_SE_A },
> +       { PCI_VDEVICE(MATROX, 0x0524), .driver_data =3D G200_SE_B },
> +       { PCI_VDEVICE(MATROX, 0x0530), .driver_data =3D G200_EV },
> +       { PCI_VDEVICE(MATROX, 0x0532), .driver_data =3D G200_WB },
> +       { PCI_VDEVICE(MATROX, 0x0533), .driver_data =3D G200_EH },
> +       { PCI_VDEVICE(MATROX, 0x0534), .driver_data =3D G200_ER },
> +       { PCI_VDEVICE(MATROX, 0x0536), .driver_data =3D G200_EW3 },
> +       { PCI_VDEVICE(MATROX, 0x0538), .driver_data =3D G200_EH3 },
> +       { PCI_VDEVICE(MATROX, 0x053a), .driver_data =3D G200_EH5 },
> +       { }
>  };
>
>  MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.=
c
> index 2bbb1168a3ff..6c3c309b8e4d 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -50,11 +50,16 @@
>  #include "qxl_object.h"
>
>  static const struct pci_device_id pciidlist[] =3D {
> -       { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA <<=
 8,
> -         0xffff00, 0 },
> -       { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER =
<< 8,
> -         0xffff00, 0 },
> -       { 0, 0, 0 },
> +       {
> +               PCI_DEVICE(0x1b36, 0x0100),
> +               .class =3D PCI_CLASS_DISPLAY_VGA << 8,
> +               .class_mask =3D 0xffff00
> +       }, {
> +               PCI_DEVICE(0x1b36, 0x0100),
> +               .class =3D PCI_CLASS_DISPLAY_OTHER << 8,
> +               .class_mask =3D 0xffff00
> +       },
> +       { },
>  };
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --
> 2.47.3
>
