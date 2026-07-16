Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B688C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD0910F3FE;
	Thu, 16 Jul 2026 20:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U+D+1I41";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48D210F3E0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784234436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XrjZT/Iz0BFH24w3hnw1dhyD5W6CdMQ8puWnqaztS9E=;
 b=U+D+1I417grVDayeiKPxi7hrcteY3ZpWnNT7O0rnCeQKpEU3g7uihMdvbPLpyVev22Txij
 7g2pPJPVCt0IjP86r2gO7OflNX0J1oQcqyTu3x9Tq2uekDquaDCnzMYpUdreFu6M5EJl7+
 2cGOS745G2528BkiGnOxa95IgDQh+/8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Fxdr_Js1N3ec4gO561JLDg-1; Thu, 16 Jul 2026 16:40:32 -0400
X-MC-Unique: Fxdr_Js1N3ec4gO561JLDg-1
X-Mimecast-MFC-AGG-ID: Fxdr_Js1N3ec4gO561JLDg_1784234432
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso80192731cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784234432; x=1784839232;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O5d6Dsz72G+wI4rBRnHzICgsrc1S97mJgQumeACQ5SI=;
 b=Zoozy7Objs8TT0UFy99vXE3/NSgO1UB9EdeJh7R4pQi0enmDPFex8SmBCVirKeVXs8
 CIEToRFs7x2+acxSro8m+jqnlx7VyfIoSPtE+ouOPVIzDr6RYvx7itdl0E13MVWNwdSw
 YItN44nlhe/fiAeyeQPMGaoXzWxvV8wlmq1wMEXJ+YvHEggmJNTVlISEcRyNaO8sAhPS
 j2MCjPwukVY4s2l8gGGi2INFn4hy3EvRaFTcclHKCiIFe3s3Od33xQVgz8CvPt2JPXb/
 Bdj/zjGe3jBnjiEC8C/7eo/HF16YJYGIV0NoF5VqqsxlGzFVbCJAoMyzSz7CBGjnS6RS
 aAfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvoRJr/kRxRIkE7LFrmIV++2Xe3CUEaw4J7K7WvdgcZJX1Mh4h104L480eBMoA463/0IglFhykiuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2C+5k6IGg2WpMOe0VS+mR7HhBytwBjAv0pkoEUN6xRH5wsTUe
 paMl/pjKjjA3IDN6cmDCwWTh1qFCtkYY9MFYlJrQ6GshN6IIpq20zbBH5wX+MRsvUJqKf+gL8tv
 fYSog2b8GxFlUYnUbWBWX2yNVqg4WKu/8+W8kDowZOp7w70mh4zla06hAwLkZrokZLcCtXw==
X-Gm-Gg: AfdE7ck0YPcD5CscYYmnr3YugdPln6myiD2TMQQSjN2N0gA8UiQbc/PheAzwm4f10Dk
 o5z+7/tYuoq2zXxFxgU1IX7M2opsy14Ol12OO09kIwhaSOX6dP15LSvyGNeVw11VEvWm3H8f22C
 /OiLPr2d+kZ+UUZtd/hU5TfijiZg9NP5m2I2xoRmvH4HvI5CFngKxpb6T1Mmle0DZHrDkNTY86d
 IkG9ieFEaNtrIBt6vT3HgcNvrdh/EVEHdOZ53lZbnU35PAXSfk5xxupw5oknXYX4UXzJ9boICuw
 wSmNm3ashEtG/VSofFct6i4Ev+HiQ61oGCvj1FdLcB49E2ZjiqHltF2jj+Yu4P3IuUJ9SmwJ
X-Received: by 2002:a05:622a:251:b0:517:812c:ae29 with SMTP id
 d75a77b69052e-51e42453f12mr134213921cf.53.1784234432165; 
 Thu, 16 Jul 2026 13:40:32 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:517:812c:ae29 with SMTP id
 d75a77b69052e-51e42453f12mr134213541cf.53.1784234431629; 
 Thu, 16 Jul 2026 13:40:31 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caab6e9f4sm166614571cf.2.2026.07.16.13.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:40:30 -0700 (PDT)
Message-ID: <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Prevent division-by-zero during
 DisplayPort link training transitions
From: lyude@redhat.com
To: Arjan Filius <iafilius@xs4all.nl>, Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 16:40:30 -0400
In-Reply-To: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
References: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZsaR9NvDE2yMOjI7qRFpaDsMQ39wb8qH6QqaUjP8uc_1784234432
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

Hi, can you please clarify whether or not you used generative AI for
this patch series? If so, this needs to be noted as part of the commit
message. Additionally, both of these patches look to be identical
except that one prints a message and the other doesn't. You can just
send a single version, we will figure out how to handle that part
after.

On Thu, 2026-07-16 at 16:55 +0200, Arjan Filius wrote:
> Dear Nouveau Maintainers,
> =C2=A0
> Please find below a proposed patch to prevent a division-by-zero
> kernel oops and subsequent lockup in the Nouveau display supervisor
> engine when DisplayPort links transition to 0 active lanes. This bug
> was observed and patched/tested against the mainline kernel version
> **7.1.3**, but is present in all current upstream code.
> =C2=A0
> ---
> =C2=A0
> ### BRIEF EXPLANATION
> =C2=A0
> During screen sleep transitions or multi-input display switches (KVM
> switching), the active lane count of a DisplayPort link can
> temporarily drop to 0 (`ior->dp.nr =3D=3D 0`).=20
> =C2=A0
> When this occurs, the DisplayPort supervisor function
> `nv50_disp_super_2_2_dp` is invoked via modeset interrupts. Without
> an early-exit guard, the function attempts to perform symbols/hblank
> and link rate calculations that divide by `ior->dp.nr`, resulting in
> a kernel division-by-zero math exception, lockup, and system freeze.
> =C2=A0
> This patch adds an early-exit check at the beginning of
> `nv50_disp_super_2_2_dp` to abort display configuration when the link
> training lanes count is zero.
>=20
> *=C2=A0=C2=A0 **Tested Kernel Version:** `7.1.3` (mainline stable branch)
>=20
> ---
>=20
> ### EXTREMELY DETAILED TECHNICAL BREAKDOWN
>=20
> #### 1. Hardware Context
> This bug has been consistently reproduced on a Lenovo ThinkPad T430
> (Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset) connected
> to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) with dual
> external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20
>=20
> #### 2. Root Cause Analysis (Code Level)
> Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, when `ior-
> >dp.nr =3D=3D 0`, the driver executes the following lines in
> `nv50_disp_super_2_2_dp()`:
>=20
> *=C2=A0=C2=A0 **Line 1179:** Calculations for horizontal blank symbols:
> =C2=A0=C2=A0=C2=A0 ```c
> =C2=A0=C2=A0=C2=A0 h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr);
> =C2=A0=C2=A0=C2=A0 ```
> *=C2=A0=C2=A0 **Line 1185:** Calculations for vertical blank symbols:
> =C2=A0=C2=A0=C2=A0 ```c
> =C2=A0=C2=A0=C2=A0 v =3D v - ((36 / ior->dp.nr) + 3) - 1;
> =C2=A0=C2=A0=C2=A0 ```
> *=C2=A0=C2=A0 **Line 1190:** Calculations for active link data rate:
> =C2=A0=C2=A0=C2=A0 ```c
> =C2=A0=C2=A0=C2=A0 link_data_rate =3D (khz * head->asy.or.depth / 8) / io=
r->dp.nr;
> =C2=A0=C2=A0=C2=A0 ```
>=20
> In all three instances, the denominator `ior->dp.nr` is `0`, causing
> an immediate kernel math exception in the display workqueue
> (`nouveau_display_hpd_work` or `nv50_disp_super`), locking up the
> graphics pipeline, freezing the screen, and hanging any reboot
> attempts (requiring a physical hard reset).
>=20
> #### 3. Daily Workday Trigger Scenario
> 1.=C2=A0 The T430 (via dock) and a secondary workstation are both
> connected to different inputs on the same external monitors.
> 2.=C2=A0 The monitors' input sources are switched to the secondary
> workstation.
> 3.=C2=A0 At the end of the day, the secondary workstation goes to sleep o=
r
> is shut down.
> 4.=C2=A0 With no active inputs, the external monitors enter power-saving
> standby mode.
> 5.=C2=A0 When the user subsequently wakes up or interacts with the T430,
> the driver attempts a modeset refresh. Since the monitors are asleep
> and inputs are switched away, the lanes count is read as `0`,
> triggering the division-by-zero oops.
>=20
> #### 4. Stack Trace (Oops Log)
> ```text
> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded,
> but no EDID for DP-2
> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded,
> but no EDID for DP-3
> [di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_super
> [nouveau]
> [di jul 23 10:28:26 2024] RIP: 0010:nv50_disp_super_2_2_dp+0xa7/0x320
> [nouveau]
> [di jul 23 10:28:26 2024]=C2=A0 ? nv50_disp_super_2_2_dp+0xa7/0x320
> [nouveau]
> [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super_2_2+0xf2/0x160 [nouveau]
> [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super+0x139/0x280 [nouveau]
> ```
>=20
> #### 5. Verification Proof (Bypass Log)
> With the patch applied and running on kernel `7.1.3-custom #2`, the
> screen standby transition was bypassed cleanly. The driver caught the
> lane count of 0, bypassed display configuration, and proceeded to put
> the graphics chip into its low-power runtime suspend state
> (`suspended`) without locking up the OS:
> ```text
> [45162.232371] nouveau 0000:01:00.0: disp: DP link is inactive (lanes
> =3D 0), skipping display configuration.
> [45162.232402] nouveau 0000:01:00.0: disp: DP link is inactive (lanes
> =3D 0), skipping display configuration.
> [45178.605627] nouveau 0000:01:00.0: timeout
> [45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]
> [45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout,
> 8e061008
> [45182.608521] nouveau 0000:01:00.0: timeout
> [45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 [nouveau]
> ```
>=20
> ---
>=20
> Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
> ---
>=20
> ### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:
>=20
> #### OPTION A: The Silent Production Patch (RECOMMENDED FOR UPSTREAM)
> *Note: Kernel maintainers generally reject warnings or print spam for
> expected hardware sleep/disconnect transitions. A silent return is
> the preferred upstream pattern.*
>=20
> ```diff
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> index 51c045bdfcbb..ab1bc0898def 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head,
> struct nvkm_ior *ior)
> =C2=A0{
> =C2=A0=09struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
> =C2=A0
> +=09/* If the DisplayPort link is inactive (0 lanes), skip
> configuration */
> +=09if (ior->dp.nr =3D=3D 0)
> +=09=09return;
> +
> =C2=A0=09const u32 khz =3D head->asy.hz / 1000;
> =C2=A0=09const u32 linkKBps =3D ior->dp.bw * 27000;
> =C2=A0=09const u32 symbol =3D 100000;
> ```
>=20
> #### OPTION B: The Warning/Verbose Patch (What was tested locally)
> *Note: Prints warning logs to the kernel buffer for validation and
> troubleshooting.*
>=20
> ```diff
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> index 51c045bdfcbb..ab1bc0898def 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> @@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head,
> struct nvkm_ior *ior)
> =C2=A0{
> =C2=A0=09struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
> =C2=A0
> +=09/* If the DisplayPort link is inactive (0 lanes), skip
> configuration */
> +=09if (ior->dp.nr =3D=3D 0) {
> +=09=09nvkm_warn(subdev, "DP link is inactive (lanes =3D 0),
> skipping display configuration.\n");
> +=09=09return;
> +=09}
> +
> =C2=A0=09const u32 khz =3D head->asy.hz / 1000;
> =C2=A0=09const u32 linkKBps =3D ior->dp.bw * 27000;
> =C2=A0=09const u32 symbol =3D 100000;
> ```

