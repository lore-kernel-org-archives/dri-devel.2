Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA2EC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB4310EF65;
	Wed,  5 Aug 2026 17:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="B5F9bV8U";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C79C510EF74
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785950966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NejjrKENKzWANlNw/++5ptDBbOGn/cuN0FJaDOx2asU=;
 b=B5F9bV8USZn1jXChpkkVNa6G7o+0ls0Ct/PugA8pmkZEmvtsuWJmwepdzpRwatXzR1dlAx
 QvKQaeRm6qdnHSlN2XWLw12aV3c4RiCV4fud3IB5o8me6SGKOUlI3kuRni9O4HONW4O5Ny
 xMibivX/PB1td3r8axSc9RRNM5QKmy0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-ZMWEtkRaMSWCmOeZcAv15g-1; Wed, 05 Aug 2026 13:29:18 -0400
X-MC-Unique: ZMWEtkRaMSWCmOeZcAv15g-1
X-Mimecast-MFC-AGG-ID: ZMWEtkRaMSWCmOeZcAv15g_1785950957
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930f5da3467so130059185a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 10:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950957; x=1786555757;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0EJjLd2CiUGDjKzo2WpgZtP8C/lKhszyy+rUI8pYGE=;
 b=mVggiilqpSMPVb7Z2EiMGmRUzvglrxC3g1Vbiw2pCgc6DKKpsF70QOfpsMN6gAoWxL
 UroeweDxKIyEQOwYy+AZda98Mrrb3AjU6qAQIGL4qNml3JkKyhe+77zpaiq2G8XlwrMY
 r5Ie0BNaF7ATOWuafEDDkmG/NlQnFdVPEapnX9xhSoVS1RD61IF9MT4X/X8GXjNFeJuY
 9oCZ1BuvCE4RoOKb9+r2YSyJE9pqFUvhSyiwps5SuiCCl9Tvwxe6hM78qolma0BFkxo1
 WsC4MmI7tDV0pb+HeVs1kfRhughbXVHkfOUq4BQ4LNSZrtQcIX/cnUgS3RBA0Ob71FXn
 O/5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrS5eo0fdTa8JW+vdrpn8zqiPsT4Bm8wJDAkkcNn2Rw+1D+iX4JNL/8xNb910+O8yo+Acj0/5tJNkA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPuSOgU3FAO/igyQgqkNXhVJbnFwOW285oF990z4DEuIIQAVZv
 1k31edvz9v5Xdkv5TAIz/gDTbO8V2DDWqraj80xx+x8/A+Z+uRkUuEpCDzX+MuT+MIhQ+Jn8hqp
 9bVlfYZy3rjzTS30bTBinTx9/hS8FJu5PilsfWtPWJntCuR/sx4LoRZH7abMj1NhhpllPRQ==
X-Gm-Gg: AR+sD116xNfakn46BcATNn4hPxt5ltTM66tmBPfcML98kroqf5lK+HLhPJJxs+zcACn
 ofnewPsZe2x3m3/wjXhffVIcbS9wT5+TzTH1dJy2YN1wsad7n+7q6/OJ9OZao+2hQIwyUKYT/Dt
 aYTosYr29GOhybRzd2uzwz8y5/V1ICBIu94TDz02qhVMFOnGTNYCWj7siHnI9lGUxpE3WXofUp+
 98i0e/EbWjRlOmnBtxz2cbMSg/CIPo0RkWLRQQ7vfLg1m1QpNBO4h0XUHSkLHonslEVZtLpwec+
 iLMSb35/cuKCuZspUMITIfixK2EPsfwyNLm7xIikuP0N9wEA9qWa7+AP5QjSLcsj4mP/urno
X-Received: by 2002:a05:620a:f12:b0:915:a111:86ae with SMTP id
 af79cd13be357-9364922a3ecmr742287685a.35.1785950957447; 
 Wed, 05 Aug 2026 10:29:17 -0700 (PDT)
X-Received: by 2002:a05:620a:f12:b0:915:a111:86ae with SMTP id
 af79cd13be357-9364922a3ecmr742282985a.35.1785950956885; 
 Wed, 05 Aug 2026 10:29:16 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a567666sm196142685a.33.2026.08.05.10.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:29:16 -0700 (PDT)
Message-ID: <2de49c1551bef14f30776221c10e43ebf1305ff6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Prevent division-by-zero during
 DisplayPort link training transitions
From: lyude@redhat.com
To: Arjan Filius <iafilius@xs4all.nl>
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Aug 2026 13:29:15 -0400
In-Reply-To: <6BF6102D-CBBC-4C98-8E74-F2AD208A7169@xs4all.nl>
References: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
 <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
 <6BF6102D-CBBC-4C98-8E74-F2AD208A7169@xs4all.nl>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nh0X8tW5E7TQdlSWxIUpntg7jFaF6yuZdye-QW0jyGc_1785950957
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

JFYI - going to try to review/test this ASAP, just been sidetracked
chasing some big runtime PM issues in nouveau atm :S

On Fri, 2026-07-17 at 10:15 +0200, Arjan Filius wrote:
> Hello Lyude,
>=20
> Yes, I did use generative AI to help refine and structure this (old)
> patch.
> It is completely based on work/debug/fixing I had done manually few
> years back.=20
> Generative AI helped me to send the message, but re-used my old
> patched code, brushed up a bit.
> And tested it this week on kernel 7.1.3, but previous tested on
> 6.8.0.x and 6.9.9 kernels.
>=20
> In 2024 i submitted a bug report/fix/workaround (to prevent a full
> lockup every day) on the Freedesktop GitLab under Issue 377:
> https://gitlab.freedesktop.org/drm/nouveau/-/issues/377
>=20
> Back then, my local workaround was a bit less elegant, and had a few
> extra checks/debug statements.
> I had almost forgotten about the issue since my workaround was
> running fine.
> When I recently booted up a clean mainline 7.1.3 kernel and saw the
> system freeze again within a day and every day,=20
> and had to fsck my disks due to it, I remembered the fix I once
> debugged and posted in 2024.=20
> I wanted to see if I could find a cleaner, more elegant solution and
> used AI for it, to see if the patch could be in a nicer place,=20
> but ended up to basically reproduce the fix i had written in 2024
> (without AI).
>=20
>=20
> Regarding the two patches (A and B):=20
> * **Patch B** was the version I compiled and tested locally with the
> `nvkm_warn()` statement
> =C2=A0 so I could verify in `dmesg` that the standby transitions were
> actually triggering the block and being safely bypassed.
> * **Patch A** is the exact same check but silent (without the warning
> logs).
>=20
> To avoid any confusion i repeat my patch, which does not produce any
> logging every time,=20
> but just avoids the lockup referencing null pointers when external
> displays goes to sleep.
>=20
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
> This completely fixes my lenovo T430(NVIDIA NVS 5400M) + 4338 Dock
> and 2 external (multi-input) monitors freeze, proven over some years.
> At the time the nvidia kernel driver on my T430 became an issue wih
> newer kernels, and notice nouveau driver did pretty well too.
>=20
> Hope this claries it.
>=20
> Best regards,
> Arjan Filius
>=20
>=20
> > On 16 Jul 2026, at 22:40, lyude@redhat.com=C2=A0wrote:
> >=20
> > Hi, can you please clarify whether or not you used generative AI
> > for
> > this patch series? If so, this needs to be noted as part of the
> > commit
> > message. Additionally, both of these patches look to be identical
> > except that one prints a message and the other doesn't. You can
> > just
> > send a single version, we will figure out how to handle that part
> > after.
> >=20
> > On Thu, 2026-07-16 at 16:55 +0200, Arjan Filius wrote:
> > > Dear Nouveau Maintainers,
> > > =C2=A0
> > > Please find below a proposed patch to prevent a division-by-zero
> > > kernel oops and subsequent lockup in the Nouveau display
> > > supervisor
> > > engine when DisplayPort links transition to 0 active lanes. This
> > > bug
> > > was observed and patched/tested against the mainline kernel
> > > version
> > > **7.1.3**, but is present in all current upstream code.
> > > =C2=A0
> > > ---
> > > =C2=A0
> > > ### BRIEF EXPLANATION
> > > =C2=A0
> > > During screen sleep transitions or multi-input display switches
> > > (KVM
> > > switching), the active lane count of a DisplayPort link can
> > > temporarily drop to 0 (`ior->dp.nr =3D=3D 0`).=20
> > > =C2=A0
> > > When this occurs, the DisplayPort supervisor function
> > > `nv50_disp_super_2_2_dp` is invoked via modeset interrupts.
> > > Without
> > > an early-exit guard, the function attempts to perform
> > > symbols/hblank
> > > and link rate calculations that divide by `ior->dp.nr`, resulting
> > > in
> > > a kernel division-by-zero math exception, lockup, and system
> > > freeze.
> > > =C2=A0
> > > This patch adds an early-exit check at the beginning of
> > > `nv50_disp_super_2_2_dp` to abort display configuration when the
> > > link
> > > training lanes count is zero.
> > >=20
> > > *=C2=A0=C2=A0 **Tested Kernel Version:** `7.1.3` (mainline stable bra=
nch)
> > >=20
> > > ---
> > >=20
> > > ### EXTREMELY DETAILED TECHNICAL BREAKDOWN
> > >=20
> > > #### 1. Hardware Context
> > > This bug has been consistently reproduced on a Lenovo ThinkPad
> > > T430
> > > (Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset)
> > > connected
> > > to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) with
> > > dual
> > > external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20
> > >=20
> > > #### 2. Root Cause Analysis (Code Level)
> > > Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, when
> > > `ior-
> > > > dp.nr =3D=3D 0`, the driver executes the following lines in
> > > `nv50_disp_super_2_2_dp()`:
> > >=20
> > > *=C2=A0=C2=A0 **Line 1179:** Calculations for horizontal blank symbol=
s:
> > > =C2=A0=C2=A0=C2=A0 ```c
> > > =C2=A0=C2=A0=C2=A0 h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr);
> > > =C2=A0=C2=A0=C2=A0 ```
> > > *=C2=A0=C2=A0 **Line 1185:** Calculations for vertical blank symbols:
> > > =C2=A0=C2=A0=C2=A0 ```c
> > > =C2=A0=C2=A0=C2=A0 v =3D v - ((36 / ior->dp.nr) + 3) - 1;
> > > =C2=A0=C2=A0=C2=A0 ```
> > > *=C2=A0=C2=A0 **Line 1190:** Calculations for active link data rate:
> > > =C2=A0=C2=A0=C2=A0 ```c
> > > =C2=A0=C2=A0=C2=A0 link_data_rate =3D (khz * head->asy.or.depth / 8) =
/ ior->dp.nr;
> > > =C2=A0=C2=A0=C2=A0 ```
> > >=20
> > > In all three instances, the denominator `ior->dp.nr` is `0`,
> > > causing
> > > an immediate kernel math exception in the display workqueue
> > > (`nouveau_display_hpd_work` or `nv50_disp_super`), locking up the
> > > graphics pipeline, freezing the screen, and hanging any reboot
> > > attempts (requiring a physical hard reset).
> > >=20
> > > #### 3. Daily Workday Trigger Scenario
> > > 1.=C2=A0 The T430 (via dock) and a secondary workstation are both
> > > connected to different inputs on the same external monitors.
> > > 2.=C2=A0 The monitors' input sources are switched to the secondary
> > > workstation.
> > > 3.=C2=A0 At the end of the day, the secondary workstation goes to
> > > sleep or
> > > is shut down.
> > > 4.=C2=A0 With no active inputs, the external monitors enter power-
> > > saving
> > > standby mode.
> > > 5.=C2=A0 When the user subsequently wakes up or interacts with the
> > > T430,
> > > the driver attempts a modeset refresh. Since the monitors are
> > > asleep
> > > and inputs are switched away, the lanes count is read as `0`,
> > > triggering the division-by-zero oops.
> > >=20
> > > #### 4. Stack Trace (Oops Log)
> > > ```text
> > > [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
> > > responded,
> > > but no EDID for DP-2
> > > [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
> > > responded,
> > > but no EDID for DP-3
> > > [di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_super
> > > [nouveau]
> > > [di jul 23 10:28:26 2024] RIP:
> > > 0010:nv50_disp_super_2_2_dp+0xa7/0x320
> > > [nouveau]
> > > [di jul 23 10:28:26 2024]=C2=A0 ? nv50_disp_super_2_2_dp+0xa7/0x320
> > > [nouveau]
> > > [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super_2_2+0xf2/0x160
> > > [nouveau]
> > > [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super+0x139/0x280 [nouveau]
> > > ```
> > >=20
> > > #### 5. Verification Proof (Bypass Log)
> > > With the patch applied and running on kernel `7.1.3-custom #2`,
> > > the
> > > screen standby transition was bypassed cleanly. The driver caught
> > > the
> > > lane count of 0, bypassed display configuration, and proceeded to
> > > put
> > > the graphics chip into its low-power runtime suspend state
> > > (`suspended`) without locking up the OS:
> > > ```text
> > > [45162.232371] nouveau 0000:01:00.0: disp: DP link is inactive
> > > (lanes
> > > =3D 0), skipping display configuration.
> > > [45162.232402] nouveau 0000:01:00.0: disp: DP link is inactive
> > > (lanes
> > > =3D 0), skipping display configuration.
> > > [45178.605627] nouveau 0000:01:00.0: timeout
> > > [45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]
> > > [45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout,
> > > 8e061008
> > > [45182.608521] nouveau 0000:01:00.0: timeout
> > > [45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 [nouveau]
> > > ```
> > >=20
> > > ---
> > >=20
> > > Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
> > > ---
> > >=20
> > > ### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:
> > >=20
> > > #### OPTION A: The Silent Production Patch (RECOMMENDED FOR
> > > UPSTREAM)
> > > *Note: Kernel maintainers generally reject warnings or print spam
> > > for
> > > expected hardware sleep/disconnect transitions. A silent return
> > > is
> > > the preferred upstream pattern.*
> > >=20
> > > ```diff
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > index 51c045bdfcbb..ab1bc0898def 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head
> > > *head,
> > > struct nvkm_ior *ior)
> > > =C2=A0{
> > > =C2=A0=09struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
> > > =C2=A0
> > > +=09/* If the DisplayPort link is inactive (0 lanes), skip
> > > configuration */
> > > +=09if (ior->dp.nr =3D=3D 0)
> > > +=09=09return;
> > > +
> > > =C2=A0=09const u32 khz =3D head->asy.hz / 1000;
> > > =C2=A0=09const u32 linkKBps =3D ior->dp.bw * 27000;
> > > =C2=A0=09const u32 symbol =3D 100000;
> > > ```
> > >=20
> > > #### OPTION B: The Warning/Verbose Patch (What was tested
> > > locally)
> > > *Note: Prints warning logs to the kernel buffer for validation
> > > and
> > > troubleshooting.*
> > >=20
> > > ```diff
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > index 51c045bdfcbb..ab1bc0898def 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > @@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_head
> > > *head,
> > > struct nvkm_ior *ior)
> > > =C2=A0{
> > > =C2=A0=09struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
> > > =C2=A0
> > > +=09/* If the DisplayPort link is inactive (0 lanes), skip
> > > configuration */
> > > +=09if (ior->dp.nr =3D=3D 0) {
> > > +=09=09nvkm_warn(subdev, "DP link is inactive (lanes =3D
> > > 0),
> > > skipping display configuration.\n");
> > > +=09=09return;
> > > +=09}
> > > +
> > > =C2=A0=09const u32 khz =3D head->asy.hz / 1000;
> > > =C2=A0=09const u32 linkKBps =3D ior->dp.bw * 27000;
> > > =C2=A0=09const u32 symbol =3D 100000;
> > > ```
> >=20

