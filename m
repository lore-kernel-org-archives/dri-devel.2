Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C02C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D9110E3AD;
	Tue, 21 Jul 2026 16:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="fOiCpPZC";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E689010E3AD
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:49:57 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-92e622cc874so860224385a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784652596; cv=none;
 d=google.com; s=arc-20260327;
 b=FdH6q3pPo8O/j+Al0KvCrg8ZOEKolokDi1pZeV0p3vH7dqTIdDELG7UrKHh8rSgNfT
 jELw9VzCJ2pIzsuVRxRB3+nY656ADLffPo+MG88cWlP0ICKKXhJICL3V2x43hx/vSGRy
 jvZ4y3P9I4DI7bgL1K2w4cocM60HRZms4S0iHalGeq05njWElsN0fDBZ8MWKtyJ7jv8J
 cdO/HjQN+0ULSlYSmqrtd028Yi09XZaunMgpoUUJ/ihvPcaaIXumeC2bY1rUOsrbMxkd
 fuo/7lR5s2fkTN+8iVdc7jB7nj0BfjGWSphJ6SzWB2UWuCkMsAp02m9C9wk079DWLro2
 CpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a1l+lsosBttUGYTYNv9pqCSwV7Oru+pHIMQWCpmd+kA=;
 fh=8mqSQQhEQMNDvZQL4RF+dzwq/eDqszvVNTbDhbEySB8=;
 b=kH99N+LwveVF6h0y/V2Qk9C3dBmAxCTDDP6HZBNvXxdDamhB/isf+zv0DClfbnrbOU
 iIDD3vFTWHIFJZx/h11AZy430wQeg8eUIG7apL5gDTJTOAJTg7c9qz9/fCIdSnDk9qT8
 THDqXBnh9InSnpgKX+U+nC38supcouZYCPwxEboDuON/1wdKcgj2NiAXA7WylSQoqjHl
 zSQc46tWBhc0TU9I/HpKu62BJPa9tYrZI/piW7eLUkXgSVjzeGHCPSOwYcwFb/+8HQit
 yXF8UQAvQc6hNq5uAwFc7ZIF9UPZMCEFD+qpeEmHmRCoAzltaa9dYsbbDjKHpQsmJWHd
 azYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1784652596;
 x=1785257396; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a1l+lsosBttUGYTYNv9pqCSwV7Oru+pHIMQWCpmd+kA=;
 b=fOiCpPZCOhKNy2OPv+U51zIRfXN5Vt2iD+aDeA9yJ1x9mlMKKPTgAfTirWSopZmp1c
 lbiNzCSKEIoXqayAQabMqXZIaH1qNprJLMSh7zbPsiUnQRlCffmX/HV+wZby6X9ExxAk
 wV3QMup6XXyiErVSsil7Oh4qcRw4QAhkRiO5gHUQoCb0ltgCwohTCyzN15U2x0h+DZNP
 +P0TS8mPoF/COi8fyLuTIMTluZMGoMVHoyqmcDm5TsK8j5ptPxnkfcg0wzUNKC+vMoOZ
 aWtBLuMoLeVP1qftmM2DOa+kk6783SCmeO9oCoAi8Wv/ujokCP3w++RdkK6TJY2o1+M5
 L6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784652596; x=1785257396;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a1l+lsosBttUGYTYNv9pqCSwV7Oru+pHIMQWCpmd+kA=;
 b=LXX629cAllBvlZlQvi34WUxi05JGV+J0TlC/aktkKSweRzGIaU09nlSDFd/z2GGO57
 jvvvbN1XDZYFRD49RLJRihAUneTrGKPOM18eX0r0XiDhsT1vJkXlDfnLAiVrCY9kfIoJ
 GlevGrrW4ZJZAXt5OC6Sk2Fh8LtE61KegYMWoZ/OQYu7u00YB7KRWdu47KL2vxboeNPm
 U2qAUnyZQIJxhf4xO0iveQcqWN4e4dQ9deZ36DEHAl+pjQs7u58goUAmF+gvyz8FZP47
 8Fr56kwOQ6ddLC/d+ZnpDlySoOV8/6EZzUAIWpqvyWtd4U3zpz0zntA/aS89itzIRHBA
 1QeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp2hLE6x7UnWhrwOT+jmKH7bjWeqluiC1RoLPkVAPND2xm8gPoSBx8qSLJuqj3Xo2yaHoQYgGr35k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/L3qeTU0TC24Kq91phNoWoVEb1rG9V1DtIRT/yjF5RPXxOYBF
 n2ji/wzzRRfj9K5ZYiDSYlft6YEpMWhfbok0M4rC+GK6vqFgrmaFmC6a9YLV2uzLq8UWnrbevvD
 WmWCXioJec5LYyPHraoaJEFqu7Pw5p3AlVUt03qaXoQ==
X-Gm-Gg: AfdE7ckc/1LKPdqlroflbZyq9aZ6qKLM2lvBeY7UnCx2aF9hFaWCJVe7O/MotfgAZ/I
 A2SFGizelAc6PpJ+V0ld2SuQRcHLFwWAkcoLMhLot75P9zGatM407DZq+1PuZfRKXHNcyTSUnfT
 qP6wiXfzneURyd6lA0UUynb3qTNi0R40zRvf6Hbm7mwcJOhwac+PTU6ZLwGCHHhPhELaUNueywo
 ctIJ5sPMiILUUZv7igi5iv90rpHImA5Yt8ORPZBn6/LmWPCjsGYSiYMeIR+
X-Received: by 2002:a05:620a:4505:b0:915:75ba:1797 with SMTP id
 af79cd13be357-930b3f10df1mr2043049285a.29.1784652595719; Tue, 21 Jul 2026
 09:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260720231450.485221-1-robh@kernel.org>
 <20260720231450.485221-2-robh@kernel.org>
In-Reply-To: <20260720231450.485221-2-robh@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 21 Jul 2026 18:49:44 +0200
X-Gm-Features: AUfX_mwW1igaUqYhOS2J-ZUURKe0AmaqfqKej2sQ1_rqlrDlORZRj7LqSy-nPP0
Message-ID: <CAPsqS2Q-_V2WLg96Mz5pFWoWs5f=24DABzs6tdTfyqy=PgbroQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel: ethosu: Handle U85 internal chaining buffer
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Jul 21, 2026 at 1:14=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The Ethos-U85 supports an internal chaining buffer as temporary storage
> between some operations. When chaining is activated, the IFM/OFM region
> setting selects a chaining buffer rather than a region, and the IFM/OFM
> base addresses don't matter. In this case, the feature matrix size
> calculations should be skipped. Otherwise, the command stream will be
> intermittently rejected depending on prior feature matrix base
> addresses.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

> ---
>  drivers/accel/ethosu/ethosu_gem.c | 35 +++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 1daff32610c7..d50fed64d4d9 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -192,7 +192,15 @@ static u64 dma_length(struct ethosu_validated_cmdstr=
eam_info *info,
>         return len;
>  }
>
> -static u64 feat_matrix_length(struct ethosu_validated_cmdstream_info *in=
fo,
> +static bool feat_matrix_chained(struct ethosu_device *edev, struct feat_=
matrix *fm)
> +{
> +       u32 storage =3D fm->precision >> 14;
> +
> +       return !ethosu_is_u65(edev) && storage =3D=3D 2;
> +}
> +
> +static u64 feat_matrix_length(struct ethosu_device *edev,
> +                             struct ethosu_validated_cmdstream_info *inf=
o,
>                               struct feat_matrix *fm,
>                               u32 x, u32 y, u32 c, bool ofm)
>  {
> @@ -203,6 +211,9 @@ static u64 feat_matrix_length(struct ethosu_validated=
_cmdstream_info *info,
>         if (fm->region < 0)
>                 return U64_MAX;
>
> +       if (feat_matrix_chained(edev, fm))
> +               return 0;
> +
>         switch (storage) {
>         case 0:
>                 if (x >=3D fm->width0 + 1) {
> @@ -223,6 +234,8 @@ static u64 feat_matrix_length(struct ethosu_validated=
_cmdstream_info *info,
>                         tile =3D 1;
>                 }
>                 break;
> +       default:
> +               return U64_MAX;
>         }
>         if (fm->base[tile] =3D=3D U64_MAX)
>                 return U64_MAX;
> @@ -251,6 +264,7 @@ static int calc_sizes(struct drm_device *ddev,
>                       u16 op, struct cmd_state *st,
>                       bool ifm, bool ifm2, bool weight, bool scale)
>  {
> +       struct ethosu_device *edev =3D to_ethosu_device(ddev);
>         u64 len;
>
>         if (ifm) {
> @@ -268,7 +282,7 @@ static int calc_sizes(struct drm_device *ddev,
>                 if (ifm_height < 0 || ifm_width < 0)
>                         return -EINVAL;
>
> -               len =3D feat_matrix_length(info, &st->ifm, ifm_width,
> +               len =3D feat_matrix_length(edev, info, &st->ifm, ifm_widt=
h,
>                                          ifm_height, st->ifm.depth, false=
);
>                 dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
>                         op, st->ifm.region, st->ifm.base[0], len);
> @@ -277,7 +291,7 @@ static int calc_sizes(struct drm_device *ddev,
>         }
>
>         if (ifm2) {
> -               len =3D feat_matrix_length(info, &st->ifm2, st->ifm.depth=
,
> +               len =3D feat_matrix_length(edev, info, &st->ifm2, st->ifm=
.depth,
>                                          0, st->ofm.depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
>                         op, st->ifm2.region, st->ifm2.base[0], len);
> @@ -309,13 +323,14 @@ static int calc_sizes(struct drm_device *ddev,
>                             st->scale[0].base + st->scale[0].length);
>         }
>
> -       len =3D feat_matrix_length(info, &st->ofm, st->ofm.width,
> +       len =3D feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
>                                  st->ofm.height[2], st->ofm.depth, true);
>         dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
>                 op, st->ofm.region, st->ofm.base[0], len);
>         if (len =3D=3D U64_MAX)
>                 return -EINVAL;
> -       info->output_region[st->ofm.region] =3D true;
> +       if (!feat_matrix_chained(edev, &st->ofm))
> +               info->output_region[st->ofm.region] =3D true;
>
>         return 0;
>  }
> @@ -325,6 +340,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>                                u16 op, struct cmd_state *st,
>                                bool ifm, bool ifm2)
>  {
> +       struct ethosu_device *edev =3D to_ethosu_device(ddev);
>         u32 height, width, depth;
>         u64 len;
>
> @@ -333,7 +349,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>                 width =3D st->ifm.broadcast & 0x2 ? 0 : st->ofm.width;
>                 depth =3D st->ifm.broadcast & 0x4 ? 0 : st->ofm.depth;
>
> -               len =3D feat_matrix_length(info, &st->ifm, width,
> +               len =3D feat_matrix_length(edev, info, &st->ifm, width,
>                                          height, depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM:%d:0x%llx-0x%llx\n",
>                         op, st->ifm.region, st->ifm.base[0], len);
> @@ -346,7 +362,7 @@ static int calc_sizes_elemwise(struct drm_device *dde=
v,
>                 width =3D st->ifm2.broadcast & 0x2 ? 0 : st->ofm.width;
>                 depth =3D st->ifm2.broadcast & 0x4 ? 0 : st->ofm.depth;
>
> -               len =3D feat_matrix_length(info, &st->ifm2, width,
> +               len =3D feat_matrix_length(edev, info, &st->ifm2, width,
>                                          height, depth, false);
>                 dev_dbg(ddev->dev, "op %d: IFM2:%d:0x%llx-0x%llx\n",
>                         op, st->ifm2.region, st->ifm2.base[0], len);
> @@ -354,13 +370,14 @@ static int calc_sizes_elemwise(struct drm_device *d=
dev,
>                         return -EINVAL;
>         }
>
> -       len =3D feat_matrix_length(info, &st->ofm, st->ofm.width,
> +       len =3D feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
>                                  st->ofm.height[2], st->ofm.depth, true);
>         dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
>                 op, st->ofm.region, st->ofm.base[0], len);
>         if (len =3D=3D U64_MAX)
>                 return -EINVAL;
> -       info->output_region[st->ofm.region] =3D true;
> +       if (!feat_matrix_chained(edev, &st->ofm))
> +               info->output_region[st->ofm.region] =3D true;
>
>         return 0;
>  }
> --
> 2.53.0
>
