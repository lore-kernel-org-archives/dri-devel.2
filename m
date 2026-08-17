Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7B5C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA6110E45A;
	Mon, 17 Aug 2026 21:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CU3M5wG1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F28D10E45A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787003349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHPjAdant6tOQFGJyuVUkwr23uGSJGxYlerIeOqc1ls=;
 b=CU3M5wG13HytjWldEEAEkyQBSl7f6Xnqr5ahZi7Zn8rjNbsaUCEzJcefUKKoBcn126GyoA
 7JITSnZT2jAs2gHmiPfJ6XFbJS/a5jZpBGbSTXOs5zM02RuYCq3kVtBmlSFYc+170QOaDO
 MjKV+CJUdMjX58oEmGE/f3NuUZcqK24=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-nqkgfuNTMoWUbvqLKV4wmA-1; Mon, 17 Aug 2026 17:49:08 -0400
X-MC-Unique: nqkgfuNTMoWUbvqLKV4wmA-1
X-Mimecast-MFC-AGG-ID: nqkgfuNTMoWUbvqLKV4wmA_1787003348
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936e393061dso230580785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787003348; x=1787608148;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NpT6IBbEDn6Pvgvg7L8CX+UbCOJ8acjU28kPL1GyDs=;
 b=osjrowtj/d2B/JaNh5v4U2ltfCqOg5QtdkoqZoK9gwUn4qM7vZqROZOX4WauKH6w9H
 eIfluV7hSn5dJsPTBUrLrVlq1vhIc+3xIS9PYCEHd2oDewg81+KQp9Fj7I8nxMZ5ciCq
 eL4y7IjOV6PGb+z4ig0FGxK58dwPc1d8/fQaP8k9kgzOw9ILSEjR3emG8tlnqqAcS0Eq
 aUi0Ce4eIZvGiroEWkbf2Qy0AHJWoPh5aUu+Hs7WLjzKCUgSIIm+FWYKFu0e9tHScOa2
 8YrIh0J7mtBUd2S7R5+DmFFCvKDw6G0jOxBR3G7llMYaCWcVU9eh+oiAzBZmnDifM2Vz
 e5ew==
X-Gm-Message-State: AOJu0YwEWL4JQUBotlcyQmZwhMMX30/kiWeZh+/q+YoiF43b0DMCaew0
 yaEQm8NFsQ5kGMGSZC51G1Y+RVLhncT98V3RKzS/GNE+3pRHpLg/+3UapFbE+eyyei1/Te9eGgM
 Xw5zze13eiGxq1HwkM4MGXiCUdBGuIXfhN7qg01RUVcrsJR462D/drn0wUFc6QVQmiznTSA==
X-Gm-Gg: AR+sD11Spx/CGizVQMbilKu7fjZjqnd/pNUpn9tHIkHvci0Q4jSgDH6u8CWKyWa+lPD
 IhmoY4gu35Arhltpid0GITM27HqWhsHHiTYMxwl6LpQGqod2KyqjC1NayCqZjDu2fzcZWLaDDvL
 EwYdtvbXqG7Xjl5S0sDeC2e0FXRGDvKdCA/FNuitgFoQpISRIsrSvD3JD/WKZ/4RFvR3YJDHPI/
 7I2nCX73GsHBqiUDxhfqt7zdCHfWbPAecBbz+VEy1xp2tXbdVlEZimF8QBgGCW1b6c3w24v1vZi
 IyyosnEgNEo0QKGLgE4gxrEWI7QMvRmR6knYRPF3e9214tNBZG0uzV0sYxqIsO/ZqqHZjN/B
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d854f3ce2mr312378141cf.38.1787003347734; 
 Mon, 17 Aug 2026 14:49:07 -0700 (PDT)
X-Received: by 2002:ac8:5ccf:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52d854f3ce2mr312377741cf.38.1787003347331; 
 Mon, 17 Aug 2026 14:49:07 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db625c90csm24270971cf.27.2026.08.17.14.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:49:06 -0700 (PDT)
Message-ID: <2e606cab65a7c7134ade630b17c52aaa4017dca8.camel@redhat.com>
Subject: Re: [PATCH 2/7] nouveau/gsp: fix HDMI vendor infoframes on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Mon, 17 Aug 2026 17:49:05 -0400
In-Reply-To: <20260814235705.59132-3-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-3-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PqHqTXk0qGp6GJvABP66ecTC83Lab3bFuda6iiidhKk_1787003348
X-Mimecast-Originator: redhat.com
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

On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> The GSP path reuses the GV100 direct-MMIO infoframe writers on every
> chip. On GB20x that is only half right as while the legacy SF AVI
> unit is
> unchanged, the legacy VSI unit at 0x6f0100 was removed, so
> gv100_sor_hdmi_infoframe_vsi() writes into a reserved area and no
> vendor
> infoframe ever reaches the wire. This affects HDMI-VIC signalling
> which
> can impact some 4K modes for legacy HDMI 1.4 sinks.
>=20
> Select the SOR functions per GPU family in r535_sor_new(), keyed on
> the display root class from the RM GPU table and use the new
> generic-infoframe VSI writer on GB20x. Everything else stays on the
> r535 table.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 | 29
> ++++++++++++++++++-
> =C2=A01 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 1155f079b0c3..96febd01da78 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -36,6 +36,8 @@
> =C2=A0
> =C2=A0#include <rm/gpu.h>
> =C2=A0
> +#include <nvif/class.h>
> +
> =C2=A0#include <nvhw/drf.h>
> =C2=A0
> =C2=A0#include "nvrm/disp.h"
> @@ -587,6 +589,16 @@ r535_sor_hdmi =3D {
> =C2=A0=09.audio =3D r535_sor_hdmi_audio,
> =C2=A0};
> =C2=A0
> +static const struct nvkm_ior_func_hdmi
> +gb202_sor_hdmi =3D {
> +=09.ctrl =3D r535_sor_hdmi_ctrl,
> +=09/* The legacy AVI unit is unchanged on GB20x. */
> +=09.infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> +=09.infoframe_vsi =3D gb202_sor_hdmi_infoframe_vsi,
> +=09.audio =3D r535_sor_hdmi_audio,
> +=09.frl_train =3D r535_sor_frl_train,
> +};
> +

This is the right approach, but I think this might make more sense to
move into drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gb202.c and then
reference it back here.

> =C2=A0static const struct nvkm_ior_func
> =C2=A0r535_sor =3D {
> =C2=A0=09.hdmi =3D &r535_sor_hdmi,
> @@ -595,10 +607,25 @@ r535_sor =3D {
> =C2=A0=09.bl =3D &r535_sor_bl,
> =C2=A0};
> =C2=A0
> +static const struct nvkm_ior_func
> +gb202_sor =3D {
> +=09.hdmi =3D &gb202_sor_hdmi,
> +=09.dp =3D &r535_sor_dp,
> +=09.hda =3D &r535_sor_hda,
> +=09.bl =3D &r535_sor_bl,
> +};
> +
> =C2=A0static int
> =C2=A0r535_sor_new(struct nvkm_disp *disp, int id)
> =C2=A0{
> -=09return nvkm_ior_new_(&r535_sor, disp, SOR, id, true/*XXX:
> hda cap*/);
> +=09const struct nvkm_rm_gpu *gpu =3D disp->engine.subdev.device-
> >gsp->rm->gpu;
> +=09const struct nvkm_ior_func *func =3D &r535_sor;
> +
> +=09/* NVD5.0 (GB20x and later) reorganised the SF HDMI packet
> units. */
> +=09if (gpu->disp.class.root >=3D GB202_DISP)
> +=09=09func =3D &gb202_sor;
> +
> +=09return nvkm_ior_new_(func, disp, SOR, id, true/*XXX: hda
> cap*/);
> =C2=A0}
> =C2=A0
> =C2=A0static int

