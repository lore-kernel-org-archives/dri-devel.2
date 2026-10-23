Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB360A3810
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HDLwcxHU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08681112C3E;
	Fri, 23 Oct 2026 17:18:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170F110E083
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792775876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pRICZANxgfq97YL5dhnI91hN1aXNGe6FBMnIPshQwkA=;
 b=HDLwcxHUyFu/nCfLCL/Gz9v2TmrYI3pu5leBpcypXvXp7rbg7jJf/WJk6FmtKOXUrqrwBm
 4OTK9JwktfbbgGpr/y9+uHBlgKdO8KCrk4wgOa1q1xTqL0vxnRlo087KtMlJ6kaxLnrUoq
 UcLYWrkAkX4Gx5+VKx8eh3HtnAO2lrE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-pO3EYqfeP-WfjSc1PKdPVg-1; Fri, 23 Oct 2026 13:17:52 -0400
X-MC-Unique: pO3EYqfeP-WfjSc1PKdPVg-1
X-Mimecast-MFC-AGG-ID: pO3EYqfeP-WfjSc1PKdPVg_1792775872
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-536347602faso21795781cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775872; x=1793380672;
 h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
 :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A2xas3RJStuIMPrYKXWjc0GItmVGtoA0BoFVkt/CYAU=;
 b=rOAIsNLNW+O2zcywy7Ev2Fbh/5sRHuknwTV4ypSZYzOuObIOKBM8DCW7jOuonRKbj1
 BFQRbyB2ujPIu+m0oq6ScOSAU+KFhf302r0/XGhDD9fHEGr4Pl614VKCini9YZ/dOJs9
 3cBVklrZ8nVfh/40DaKjinbL+z1sDK1hgmREAJW6uJ8gs3jSdi73rjzTxVmYKvt47wbb
 1s0BMXgHsK23EdE7Ld8WMkUvABYjTUpwx0QsSFhR/zR+UuWWWrs3X4DQrMNMTKKHI3bE
 lrNCfT4v3UofYjpCWGXhvKe/KHv2/OjCPBNbwCLIjYShPnCAU7q+Hl/bQBlpmP4yp//a
 Dz/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVwHp61BbrkgjdJiLC6fF2OQX1CBJIcZQ72o5dPSFyQ9Pn67oYa7lzwsWBG8VV97cf6qEMglIje3E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLs3sK3QNIWJ83ipkLU/mpGWOft0DjkJjNXtcG/IdynsbtGgluC
 bcb/dGlooaM6JELxU1aODpc/aJ2Bp0+qA8aTqbkjHvt4hbMtkvgP3KqfbzXt9oIz8Yk4D9KRY33
 +skZxuBot2t/jhDrTZN2Z2p8jzSxCPCGeuUWJcRxVivhzdbnSFxvKzhGXPupjinkJazDmhg==
X-Gm-Gg: AYBFou3ixgDMC3TqLCSSd5ugrB3Zmf3hmpgNP5PUJ120xJ47bpDe5ukXewOd7nBWMiU
 el3xBrE7u3mry8wUspb9o7xY3M+nkhGyFioSHqm5fmwE8Ip7hDMpcQCYI3M/KnR4rMZeJBKWaPk
 aPc5Qkk3SzuF6ICgcDqfCTVbVAIHCNqg3Fvdauld/zim5ZtpP/kcS6FK2RujwTDW6QvEu5+HmSc
 59Q7yjuG+uGeIq6GfoSxLnRddva+WQCxhIi8RBK3n9uiZSdfrKX0ACuiGdQ5R4jCEJQKOSur0XJ
 32OF+8VeQ0m8XG1SHTs7eLd49TSGmG3s4cNjfzP4ac9+3UQxDZW23zPWFc2D+eQO3aMX6Ro=
X-Received: by 2002:a05:622a:4118:b0:536:6516:2d74 with SMTP id
 d75a77b69052e-536c2652afdmr41858321cf.52.1792775871419; 
 Fri, 23 Oct 2026 10:17:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4118:b0:536:6516:2d74 with SMTP id
 d75a77b69052e-536c2652afdmr41857771cf.52.1792775870711; 
 Fri, 23 Oct 2026 10:17:50 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53836c4c71fsm2268251cf.25.2026.10.23.10.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:17:50 -0700 (PDT)
Message-ID: <3c9ad85d1a773ab44ddfd0c101e2127e58e962fb.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Prevent division-by-zero during
 DisplayPort link training transitions
From: lyude@redhat.com
To: Arjan Filius <iafilius@xs4all.nl>
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 13:17:49 -0400
In-Reply-To: <32FD1A55-E5FA-40E5-BB7E-7A7524CB8AF9@xs4all.nl>
References: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
 <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
 <6BF6102D-CBBC-4C98-8E74-F2AD208A7169@xs4all.nl>
 <2de49c1551bef14f30776221c10e43ebf1305ff6.camel@redhat.com>
 <32FD1A55-E5FA-40E5-BB7E-7A7524CB8AF9@xs4all.nl>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4gtHdb8IfbuCFRYS1dCbrtSkZxJ4oLtMZ33gEX4GdT0_1792775872
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="=-7b40JqUyUNzA3oQ/x6Tu"
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
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-7b40JqUyUNzA3oQ/x6Tu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-10-18 at 13:01 +0200, Arjan Filius wrote:
> Hi Lyude,
> Just a friendly gentle ping on this patch whenever you have a chance
> to take a look.
> No rush if you're still swamped with runtime PM work, but wanted to
> check in to see if you need anything else from my side (or if you'd
> prefer me to resend it as a standalone [PATCH v2] formatted with git-
> format-patch).
> Thanks again for your time!

I will try to review this asap, unfortunately I am quite swamped and in
the middle of moving - so I need to focus on the stuff that's assigned
on my plate this week.

I think the one thing that would be appreciated is if you could re-add
the old commit message you had before generating the new one with an
LLM - it was easier to read IMO.

> Best regards,
> Arjan Filius
>=20
> > On 5 Aug 2026, at 19:29, lyude@redhat.com wrote:
> >=20
> > JFYI - going to try to review/test this ASAP, just been sidetracked
> > chasing some big runtime PM issues in nouveau atm :S
> >=20
> > On Fri, 2026-07-17 at 10:15 +0200, Arjan Filius wrote:
> > > Hello Lyude,
> > >=20
> > > Yes, I did use generative AI to help refine and structure this
> > > (old)
> > > patch.
> > > It is completely based on work/debug/fixing I had done manually
> > > few
> > > years back.=20
> > > Generative AI helped me to send the message, but re-used my old
> > > patched code, brushed up a bit.
> > > And tested it this week on kernel 7.1.3, but previous tested on
> > > 6.8.0.x and 6.9.9 kernels.
> > >=20
> > > In 2024 i submitted a bug report/fix/workaround (to prevent a
> > > full
> > > lockup every day) on the Freedesktop GitLab under Issue 377:
> > > https://gitlab.freedesktop.org/drm/nouveau/-/issues/377
> > >=20
> > > Back then, my local workaround was a bit less elegant, and had a
> > > few
> > > extra checks/debug statements.
> > > I had almost forgotten about the issue since my workaround was
> > > running fine.
> > > When I recently booted up a clean mainline 7.1.3 kernel and saw
> > > the
> > > system freeze again within a day and every day,=20
> > > and had to fsck my disks due to it, I remembered the fix I once
> > > debugged and posted in 2024.=20
> > > I wanted to see if I could find a cleaner, more elegant solution
> > > and
> > > used AI for it, to see if the patch could be in a nicer place,=20
> > > but ended up to basically reproduce the fix i had written in 2024
> > > (without AI).
> > >=20
> > >=20
> > > Regarding the two patches (A and B):=20
> > > * **Patch B** was the version I compiled and tested locally with
> > > the
> > > `nvkm_warn()` statement
> > > =C2=A0 so I could verify in `dmesg` that the standby transitions were
> > > actually triggering the block and being safely bypassed.
> > > * **Patch A** is the exact same check but silent (without the
> > > warning
> > > logs).
> > >=20
> > > To avoid any confusion i repeat my patch, which does not produce
> > > any
> > > logging every time,=20
> > > but just avoids the lockup referencing null pointers when
> > > external
> > > displays goes to sleep.
> > >=20
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
> > > =C2=A0 struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
> > > =C2=A0
> > > + /* If the DisplayPort link is inactive (0 lanes), skip
> > > configuration */
> > > + if (ior->dp.nr =3D=3D 0)
> > > + return;
> > > +
> > > =C2=A0 const u32 khz =3D head->asy.hz / 1000;
> > > =C2=A0 const u32 linkKBps =3D ior->dp.bw * 27000;
> > > =C2=A0 const u32 symbol =3D 100000;
> > > ```
> > >=20
> > > This completely fixes my lenovo T430(NVIDIA NVS 5400M) + 4338
> > > Dock
> > > and 2 external (multi-input) monitors freeze, proven over some
> > > years.
> > > At the time the nvidia kernel driver on my T430 became an issue
> > > wih
> > > newer kernels, and notice nouveau driver did pretty well too.
> > >=20
> > > Hope this claries it.
> > >=20
> > > Best regards,
> > > Arjan Filius
> > >=20
> > >=20
> > > > On 16 Jul 2026, at 22:40, lyude@redhat.com=C2=A0wrote:
> > > >=20
> > > > Hi, can you please clarify whether or not you used generative
> > > > AI
> > > > for
> > > > this patch series? If so, this needs to be noted as part of the
> > > > commit
> > > > message. Additionally, both of these patches look to be
> > > > identical
> > > > except that one prints a message and the other doesn't. You can
> > > > just
> > > > send a single version, we will figure out how to handle that
> > > > part
> > > > after.
> > > >=20
> > > > On Thu, 2026-07-16 at 16:55 +0200, Arjan Filius wrote:
> > > > > Dear Nouveau Maintainers,
> > > > > =C2=A0
> > > > > Please find below a proposed patch to prevent a division-by-
> > > > > zero
> > > > > kernel oops and subsequent lockup in the Nouveau display
> > > > > supervisor
> > > > > engine when DisplayPort links transition to 0 active lanes.
> > > > > This
> > > > > bug
> > > > > was observed and patched/tested against the mainline kernel
> > > > > version
> > > > > **7.1.3**, but is present in all current upstream code.
> > > > > =C2=A0
> > > > > ---
> > > > > =C2=A0
> > > > > ### BRIEF EXPLANATION
> > > > > =C2=A0
> > > > > During screen sleep transitions or multi-input display
> > > > > switches
> > > > > (KVM
> > > > > switching), the active lane count of a DisplayPort link can
> > > > > temporarily drop to 0 (`ior->dp.nr =3D=3D 0`).=20
> > > > > =C2=A0
> > > > > When this occurs, the DisplayPort supervisor function
> > > > > `nv50_disp_super_2_2_dp` is invoked via modeset interrupts.
> > > > > Without
> > > > > an early-exit guard, the function attempts to perform
> > > > > symbols/hblank
> > > > > and link rate calculations that divide by `ior->dp.nr`,
> > > > > resulting
> > > > > in
> > > > > a kernel division-by-zero math exception, lockup, and system
> > > > > freeze.
> > > > > =C2=A0
> > > > > This patch adds an early-exit check at the beginning of
> > > > > `nv50_disp_super_2_2_dp` to abort display configuration when
> > > > > the
> > > > > link
> > > > > training lanes count is zero.
> > > > >=20
> > > > > *=C2=A0=C2=A0 **Tested Kernel Version:** `7.1.3` (mainline stable
> > > > > branch)
> > > > >=20
> > > > > ---
> > > > >=20
> > > > > ### EXTREMELY DETAILED TECHNICAL BREAKDOWN
> > > > >=20
> > > > > #### 1. Hardware Context
> > > > > This bug has been consistently reproduced on a Lenovo
> > > > > ThinkPad
> > > > > T430
> > > > > (Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset)
> > > > > connected
> > > > > to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338)
> > > > > with
> > > > > dual
> > > > > external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20
> > > > >=20
> > > > > #### 2. Root Cause Analysis (Code Level)
> > > > > Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`,
> > > > > when
> > > > > `ior-
> > > > > > dp.nr =3D=3D 0`, the driver executes the following lines in
> > > > > `nv50_disp_super_2_2_dp()`:
> > > > >=20
> > > > > *=C2=A0=C2=A0 **Line 1179:** Calculations for horizontal blank sy=
mbols:
> > > > > =C2=A0=C2=A0=C2=A0 ```c
> > > > > =C2=A0=C2=A0=C2=A0 h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr)=
;
> > > > > =C2=A0=C2=A0=C2=A0 ```
> > > > > *=C2=A0=C2=A0 **Line 1185:** Calculations for vertical blank symb=
ols:
> > > > > =C2=A0=C2=A0=C2=A0 ```c
> > > > > =C2=A0=C2=A0=C2=A0 v =3D v - ((36 / ior->dp.nr) + 3) - 1;
> > > > > =C2=A0=C2=A0=C2=A0 ```
> > > > > *=C2=A0=C2=A0 **Line 1190:** Calculations for active link data ra=
te:
> > > > > =C2=A0=C2=A0=C2=A0 ```c
> > > > > =C2=A0=C2=A0=C2=A0 link_data_rate =3D (khz * head->asy.or.depth /=
 8) / ior-
> > > > > >dp.nr;
> > > > > =C2=A0=C2=A0=C2=A0 ```
> > > > >=20
> > > > > In all three instances, the denominator `ior->dp.nr` is `0`,
> > > > > causing
> > > > > an immediate kernel math exception in the display workqueue
> > > > > (`nouveau_display_hpd_work` or `nv50_disp_super`), locking up
> > > > > the
> > > > > graphics pipeline, freezing the screen, and hanging any
> > > > > reboot
> > > > > attempts (requiring a physical hard reset).
> > > > >=20
> > > > > #### 3. Daily Workday Trigger Scenario
> > > > > 1.=C2=A0 The T430 (via dock) and a secondary workstation are both
> > > > > connected to different inputs on the same external monitors.
> > > > > 2.=C2=A0 The monitors' input sources are switched to the secondar=
y
> > > > > workstation.
> > > > > 3.=C2=A0 At the end of the day, the secondary workstation goes to
> > > > > sleep or
> > > > > is shut down.
> > > > > 4.=C2=A0 With no active inputs, the external monitors enter power=
-
> > > > > saving
> > > > > standby mode.
> > > > > 5.=C2=A0 When the user subsequently wakes up or interacts with th=
e
> > > > > T430,
> > > > > the driver attempts a modeset refresh. Since the monitors are
> > > > > asleep
> > > > > and inputs are switched away, the lanes count is read as `0`,
> > > > > triggering the division-by-zero oops.
> > > > >=20
> > > > > #### 4. Stack Trace (Oops Log)
> > > > > ```text
> > > > > [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
> > > > > responded,
> > > > > but no EDID for DP-2
> > > > > [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
> > > > > responded,
> > > > > but no EDID for DP-3
> > > > > [di jul 23 10:28:26 2024] Workqueue: nvkm-disp
> > > > > nv50_disp_super
> > > > > [nouveau]
> > > > > [di jul 23 10:28:26 2024] RIP:
> > > > > 0010:nv50_disp_super_2_2_dp+0xa7/0x320
> > > > > [nouveau]
> > > > > [di jul 23 10:28:26 2024]=C2=A0 ?
> > > > > nv50_disp_super_2_2_dp+0xa7/0x320
> > > > > [nouveau]
> > > > > [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super_2_2+0xf2/0x160
> > > > > [nouveau]
> > > > > [di jul 23 10:28:26 2024]=C2=A0 nv50_disp_super+0x139/0x280
> > > > > [nouveau]
> > > > > ```
> > > > >=20
> > > > > #### 5. Verification Proof (Bypass Log)
> > > > > With the patch applied and running on kernel `7.1.3-custom
> > > > > #2`,
> > > > > the
> > > > > screen standby transition was bypassed cleanly. The driver
> > > > > caught
> > > > > the
> > > > > lane count of 0, bypassed display configuration, and
> > > > > proceeded to
> > > > > put
> > > > > the graphics chip into its low-power runtime suspend state
> > > > > (`suspended`) without locking up the OS:
> > > > > ```text
> > > > > [45162.232371] nouveau 0000:01:00.0: disp: DP link is
> > > > > inactive
> > > > > (lanes
> > > > > =3D 0), skipping display configuration.
> > > > > [45162.232402] nouveau 0000:01:00.0: disp: DP link is
> > > > > inactive
> > > > > (lanes
> > > > > =3D 0), skipping display configuration.
> > > > > [45178.605627] nouveau 0000:01:00.0: timeout
> > > > > [45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0
> > > > > [nouveau]
> > > > > [45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout,
> > > > > 8e061008
> > > > > [45182.608521] nouveau 0000:01:00.0: timeout
> > > > > [45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190
> > > > > [nouveau]
> > > > > ```
> > > > >=20
> > > > > ---
> > > > >=20
> > > > > Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
> > > > > ---
> > > > >=20
> > > > > ### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:
> > > > >=20
> > > > > #### OPTION A: The Silent Production Patch (RECOMMENDED FOR
> > > > > UPSTREAM)
> > > > > *Note: Kernel maintainers generally reject warnings or print
> > > > > spam
> > > > > for
> > > > > expected hardware sleep/disconnect transitions. A silent
> > > > > return
> > > > > is
> > > > > the preferred upstream pattern.*
> > > > >=20
> > > > > ```diff
> > > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > index 51c045bdfcbb..ab1bc0898def 100644
> > > > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct
> > > > > nvkm_head
> > > > > *head,
> > > > > struct nvkm_ior *ior)
> > > > > =C2=A0{
> > > > > =C2=A0 struct nvkm_subdev *subdev =3D &head->disp-
> > > > > >engine.subdev;
> > > > > =C2=A0
> > > > > + /* If the DisplayPort link is inactive (0 lanes),
> > > > > skip
> > > > > configuration */
> > > > > + if (ior->dp.nr =3D=3D 0)
> > > > > + return;
> > > > > +
> > > > > =C2=A0 const u32 khz =3D head->asy.hz / 1000;
> > > > > =C2=A0 const u32 linkKBps =3D ior->dp.bw * 27000;
> > > > > =C2=A0 const u32 symbol =3D 100000;
> > > > > ```
> > > > >=20
> > > > > #### OPTION B: The Warning/Verbose Patch (What was tested
> > > > > locally)
> > > > > *Note: Prints warning logs to the kernel buffer for
> > > > > validation
> > > > > and
> > > > > troubleshooting.*
> > > > >=20
> > > > > ```diff
> > > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > index 51c045bdfcbb..ab1bc0898def 100644
> > > > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
> > > > > @@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct
> > > > > nvkm_head
> > > > > *head,
> > > > > struct nvkm_ior *ior)
> > > > > =C2=A0{
> > > > > =C2=A0 struct nvkm_subdev *subdev =3D &head->disp-
> > > > > >engine.subdev;
> > > > > =C2=A0
> > > > > + /* If the DisplayPort link is inactive (0 lanes),
> > > > > skip
> > > > > configuration */
> > > > > + if (ior->dp.nr =3D=3D 0) {
> > > > > + nvkm_warn(subdev, "DP link is inactive (lanes
> > > > > =3D
> > > > > 0),
> > > > > skipping display configuration.\n");
> > > > > + return;
> > > > > + }
> > > > > +
> > > > > =C2=A0 const u32 khz =3D head->asy.hz / 1000;
> > > > > =C2=A0 const u32 linkKBps =3D ior->dp.bw * 27000;
> > > > > =C2=A0 const u32 symbol =3D 100000;
> > > > > ```
> > > >=20
> >=20
>=20

--=-7b40JqUyUNzA3oQ/x6Tu
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-mode:=
 space; line-break: after-white-space;"><div>On Sun, 2026-10-18 at 13:01 +0=
200, Arjan Filius wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0=
 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div data-index=3D=
"4" data-line-number=3D"5" data-line-start=3D"5" data-line-end=3D"5" class=
=3D"code-line" style=3D"white-space: pre-wrap; border-color: color(srgb 0.8=
 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border-style: =
solid; color: rgb(64, 64, 64); font-family: monospace; font-size: 11.008px;=
 font-variant-ligatures: normal; background-color: rgb(255, 255, 255); disp=
lay: flex; min-height: 1.2rem;"><div class=3D"line-content" style=3D"--tw-b=
order-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-tra=
nslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: =
1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scr=
oll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradien=
t-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed=
-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fracti=
on: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-colo=
r: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-c=
olored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-gr=
ayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ;=
 --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw=
-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: =
; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-c=
ontain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 =
/ 0.05); box-sizing: border-box; border-width: 0px; border-style: solid; fl=
ex: 1 1 0%; word-break: break-word;"><span class=3D"mtk1" style=3D"--tw-bor=
der-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-trans=
late-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1;=
 --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scrol=
l-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-=
via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-z=
ero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction=
: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color:=
 #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 =
#0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-col=
ored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-gray=
scale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; -=
-tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-b=
ackdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; =
--tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-con=
tain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / =
0.05); box-sizing: border-box; border-width: 0px; border-style: solid;">Hi =
Lyude,</span></div></div><div data-index=3D"5" data-line-number=3D"6" data-=
line-start=3D"6" data-line-end=3D"6" class=3D"code-line" style=3D"white-spa=
ce: pre-wrap; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: bor=
der-box; border-width: 0px; border-style: solid; color: rgb(64, 64, 64); fo=
nt-family: monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: 1.2rem;"><=
div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; --tw-border-s=
pacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw=
-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ;=
 --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; -=
-tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-t=
o-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; -=
-tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-rin=
g-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 =
128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0=
000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; -=
-tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --t=
w-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdro=
p-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdr=
op-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-ba=
ckdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-con=
tain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-styl=
e: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; =
border-width: 0px; border-style: solid; flex: 1 1 0%; word-break: break-wor=
d;"><span class=3D"mtk1" style=3D"--tw-border-spacing-x: 0; --tw-border-spa=
cing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-s=
kew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; -=
-tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --t=
w-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-=
position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --t=
w-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-=
offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 12=
8 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #000=
0; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --t=
w-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-=
invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-=
blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop=
-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-back=
drop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-conta=
in-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style:=
 ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; bo=
rder-width: 0px; border-style: solid;"></span></div></div><div data-index=
=3D"6" data-line-number=3D"7" data-line-start=3D"7" data-line-end=3D"7" cla=
ss=3D"code-line" style=3D"white-space: pre-wrap; border-color: color(srgb 0=
.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border-style=
: solid; color: rgb(64, 64, 64); font-family: monospace; font-size: 11.008p=
x; font-variant-ligatures: normal; background-color: rgb(255, 255, 255); di=
splay: flex; min-height: 1.2rem;"><div class=3D"line-content" style=3D"--tw=
-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-t=
ranslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x=
: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-s=
croll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradi=
ent-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slash=
ed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-frac=
tion: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-co=
lor: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: =
0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow=
-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-=
grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia:=
 ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --=
tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate=
: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate=
: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw=
-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.=
8 / 0.05); box-sizing: border-box; border-width: 0px; border-style: solid; =
flex: 1 1 0%; word-break: break-word;"><span class=3D"mtk1" style=3D"--tw-b=
order-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-tra=
nslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: =
1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scr=
oll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradien=
t-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed=
-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fracti=
on: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-colo=
r: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-c=
olored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-gr=
ayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ;=
 --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw=
-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: =
; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-c=
ontain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 =
/ 0.05); box-sizing: border-box; border-width: 0px; border-style: solid;">J=
ust a friendly gentle ping on this patch whenever you have a chance to take=
 a look.</span></div></div><div data-index=3D"7" data-line-number=3D"8" dat=
a-line-start=3D"8" data-line-end=3D"8" class=3D"code-line" style=3D"white-s=
pace: pre-wrap; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: b=
order-box; border-width: 0px; border-style: solid; color: rgb(64, 64, 64); =
font-family: monospace; font-size: 11.008px; font-variant-ligatures: normal=
; background-color: rgb(255, 255, 255); display: flex; min-height: 1.2rem;"=
><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; --tw-border=
-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --=
tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x:=
 ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity;=
 --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient=
-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ;=
 --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-r=
ing-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(6=
7 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 =
#0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ;=
 --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; -=
-tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backd=
rop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-back=
drop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-=
backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-c=
ontain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-st=
yle: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box=
; border-width: 0px; border-style: solid; flex: 1 1 0%; word-break: break-w=
ord;"><span class=3D"mtk1" style=3D"--tw-border-spacing-x: 0; --tw-border-s=
pacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw=
-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ;=
 --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; -=
-tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-t=
o-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; -=
-tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-rin=
g-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 =
128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0=
000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; -=
-tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --t=
w-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdro=
p-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdr=
op-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-ba=
ckdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-con=
tain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-styl=
e: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; =
border-width: 0px; border-style: solid;"></span></div></div><div data-index=
=3D"8" data-line-number=3D"9" data-line-start=3D"9" data-line-end=3D"9" cla=
ss=3D"code-line" style=3D"white-space: pre-wrap; border-color: color(srgb 0=
.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border-style=
: solid; color: rgb(64, 64, 64); font-family: monospace; font-size: 11.008p=
x; font-variant-ligatures: normal; background-color: rgb(255, 255, 255); di=
splay: flex; min-height: 1.2rem;"><div class=3D"line-content" style=3D"--tw=
-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-t=
ranslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x=
: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-s=
croll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradi=
ent-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slash=
ed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-frac=
tion: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-co=
lor: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: =
0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow=
-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-=
grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia:=
 ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --=
tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate=
: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate=
: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw=
-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.=
8 / 0.05); box-sizing: border-box; border-width: 0px; border-style: solid; =
flex: 1 1 0%; word-break: break-word;"><span class=3D"mtk1" style=3D"--tw-b=
order-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-tra=
nslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: =
1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scr=
oll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradien=
t-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed=
-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fracti=
on: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-colo=
r: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-c=
olored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-gr=
ayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ;=
 --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw=
-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: =
; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-c=
ontain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 =
/ 0.05); box-sizing: border-box; border-width: 0px; border-style: solid;">N=
o rush if you're still swamped with runtime PM work, but wanted to check in=
 to see if you need anything else from my side (or if you'd prefer me to re=
send it as a standalone [PATCH v2] formatted with git-format-patch).</span>=
</div></div><div data-index=3D"9" data-line-number=3D"10" data-line-start=
=3D"10" data-line-end=3D"10" class=3D"code-line" style=3D"white-space: pre-=
wrap; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box;=
 border-width: 0px; border-style: solid; color: rgb(64, 64, 64); font-famil=
y: monospace; font-size: 11.008px; font-variant-ligatures: normal; backgrou=
nd-color: rgb(255, 255, 255); display: flex; min-height: 1.2rem;"><div clas=
s=3D"line-content" style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y=
: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x:=
 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pa=
n-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-grad=
ient-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-positi=
on: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-nume=
ric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset=
-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 =
/ .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --t=
w-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brig=
htness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert=
: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: =
; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grays=
cale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-o=
pacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-siz=
e: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; bor=
der-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-w=
idth: 0px; border-style: solid; flex: 1 1 0%; word-break: break-word;"><spa=
n class=3D"mtk1" style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: =
0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0=
; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-=
y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradie=
nt-from-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position=
: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeri=
c-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-w=
idth: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / =
.5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-=
shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-bright=
ness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: =
; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-graysca=
le: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opa=
city: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size:=
 ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; borde=
r-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-wid=
th: 0px; border-style: solid;"></span></div></div><div data-index=3D"10" da=
ta-line-number=3D"11" data-line-start=3D"11" data-line-end=3D"11" class=3D"=
code-line" style=3D"white-space: pre-wrap; border-color: color(srgb 0.8 0.8=
 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border-style: soli=
d; color: rgb(64, 64, 64); font-family: monospace; font-size: 11.008px; fon=
t-variant-ligatures: normal; background-color: rgb(255, 255, 255); display:=
 flex; min-height: 1.2rem;"><div class=3D"line-content" style=3D"--tw-borde=
r-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-transla=
te-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; -=
-tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-=
snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-vi=
a-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zer=
o: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: =
; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #=
fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0=
000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-color=
ed: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-graysc=
ale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --t=
w-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-bac=
kdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --=
tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --=
tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-conta=
in-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.=
05); box-sizing: border-box; border-width: 0px; border-style: solid; flex: =
1 1 0%; word-break: break-word;"><span class=3D"mtk1" style=3D"--tw-border-=
spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate=
-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --t=
w-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-sn=
ap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-=
position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero:=
 ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #ff=
f; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #000=
0; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored=
: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscal=
e: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-=
drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backd=
rop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw=
-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw=
-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain=
-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05=
); box-sizing: border-box; border-width: 0px; border-style: solid;">Thanks =
again for your time!</span></div></div><div data-index=3D"11" data-line-num=
ber=3D"12" data-line-start=3D"12" data-line-end=3D"12" class=3D"code-line" =
style=3D"white-space: pre-wrap; border-color: color(srgb 0.8 0.8 0.8 / 0.05=
); box-sizing: border-box; border-width: 0px; border-style: solid; color: r=
gb(64, 64, 64); font-family: monospace; font-size: 11.008px; font-variant-l=
igatures: normal; background-color: rgb(255, 255, 255); display: flex; min-=
height: 1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x=
: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --=
tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y=
: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strict=
ness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-position:=
 ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-n=
umeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring=
-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-r=
ing-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-r=
ing-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #00=
00; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw=
-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shad=
ow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contr=
ast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop=
-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop=
-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ;=
 --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-si=
zing: border-box; border-width: 0px; border-style: solid; flex: 1 1 0%; wor=
d-break: break-word;"><span class=3D"mtk1" style=3D"--tw-border-spacing-x: =
0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw=
-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: =
1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictne=
ss: proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ;=
 --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-num=
eric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-i=
nset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-rin=
g-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; --tw-rin=
g-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000=
; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-h=
ue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow=
: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contras=
t: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-i=
nvert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-s=
epia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; -=
-tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizi=
ng: border-box; border-width: 0px; border-style: solid;"></span></div></div=
></blockquote><div><br></div><div>I will try to review this asap, unfortuna=
tely I am quite swamped and in the middle of moving - so I need to focus on=
 the stuff that's assigned on my plate this week.</div><div><br></div><div>=
I think the one thing that would be appreciated is if you could re-add the =
old commit message you had before generating the new one with an LLM - it w=
as easier to read IMO.</div><div><br></div><blockquote type=3D"cite" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div=
 data-index=3D"12" data-line-number=3D"13" data-line-start=3D"13" data-line=
-end=3D"13" class=3D"code-line" style=3D"white-space: pre-wrap; border-colo=
r: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0p=
x; border-style: solid; color: rgb(64, 64, 64); font-family: monospace; fon=
t-size: 11.008px; font-variant-ligatures: normal; background-color: rgb(255=
, 255, 255); display: flex; min-height: 1.2rem;"><div class=3D"line-content=
" style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-transla=
te-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: =
0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch=
-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-positio=
n: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordina=
l: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --=
tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw=
-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-=
offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #00=
00; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-co=
ntrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate=
: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-b=
rightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-back=
drop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-ba=
ckdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain=
-layout: ; --tw-contain-paint: ; --tw-contain-style: ; border-color: color(=
srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border=
-style: solid; flex: 1 1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate=
-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0;=
 --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-z=
oom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-position:=
 ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal:=
 ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw=
-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-r=
ing-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-of=
fset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000=
; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-cont=
rast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: =
; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-bri=
ghtness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdr=
op-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-back=
drop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-l=
ayout: ; --tw-contain-paint: ; --tw-contain-style: ; border-color: color(sr=
gb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; border-s=
tyle: solid;">Best regards,</span></div></div><div data-index=3D"13" data-l=
ine-number=3D"14" data-line-start=3D"14" data-line-end=3D"14" class=3D"code=
-line" style=3D"white-space: pre-wrap; border-color: color(srgb 0.8 0.8 0.8=
 / 0.05); box-sizing: border-box; border-width: 0px; border-style: solid; c=
olor: rgb(64, 64, 64); font-family: monospace; font-size: 11.008px; font-va=
riant-ligatures: normal; background-color: rgb(255, 255, 255); display: fle=
x; min-height: 1.2rem;"><div class=3D"line-content" style=3D"--tw-border-sp=
acing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y=
: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-=
scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap=
-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-po=
sition: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ;=
 --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --=
tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff;=
 --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000;=
 --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: =
0 0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale:=
 ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-dr=
op-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdro=
p-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-b=
ackdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-b=
ackdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-p=
aint: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05);=
 box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 1 =
0%; word-break: break-word;"><span class=3D"mtk1" style=3D"--tw-border-spac=
ing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: =
0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-sc=
ale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-s=
trictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-posi=
tion: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; -=
-tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw=
-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; -=
-tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 0 #0000; -=
-tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 =
0 #0000; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ;=
 --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop=
-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-=
contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-bac=
kdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-bac=
kdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-pai=
nt: ; --tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); b=
ox-sizing: border-box; border-width: 0px; border-style: solid;">Arjan Filiu=
s</span></div></div><div><br><blockquote type=3D"cite" style=3D"margin:0 0 =
0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div>On 5 Aug 2026,=
 at 19:29, lyude@redhat.com wrote:</div><div><br class=3D"Apple-interchange=
-newline"></div><div><div>JFYI - going to try to review/test this ASAP, jus=
t been sidetracked<br>chasing some big runtime PM issues in nouveau atm :S<=
br><br>On Fri, 2026-07-17 at 10:15 +0200, Arjan Filius wrote:<br><blockquot=
e type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;p=
adding-left:1ex"><div>Hello Lyude,<br><br>Yes, I did use generative AI to h=
elp refine and structure this (old)<br>patch.<br>It is completely based on =
work/debug/fixing I had done manually few<br>years back. <br>Generative AI =
helped me to send the message, but re-used my old<br>patched code, brushed =
up a bit.<br>And tested it this week on kernel 7.1.3, but previous tested o=
n<br>6.8.0.x and 6.9.9 kernels.<br><br>In 2024 i submitted a bug report/fix=
/workaround (to prevent a full<br>lockup every day) on the Freedesktop GitL=
ab under Issue 377:<br>https://gitlab.freedesktop.org/drm/nouveau/-/issues/=
377<br><br>Back then, my local workaround was a bit less elegant, and had a=
 few<br>extra checks/debug statements.<br>I had almost forgotten about the =
issue since my workaround was<br>running fine.<br>When I recently booted up=
 a clean mainline 7.1.3 kernel and saw the<br>system freeze again within a =
day and every day, <br>and had to fsck my disks due to it, I remembered the=
 fix I once<br>debugged and posted in 2024. <br>I wanted to see if I could =
find a cleaner, more elegant solution and<br>used AI for it, to see if the =
patch could be in a nicer place, <br>but ended up to basically reproduce th=
e fix i had written in 2024<br>(without AI).<br><br><br>Regarding the two p=
atches (A and B): <br>* **Patch B** was the version I compiled and tested l=
ocally with the<br>`nvkm_warn()` statement<br>&nbsp; so I could verify in `=
dmesg` that the standby transitions were<br>actually triggering the block a=
nd being safely bypassed.<br>* **Patch A** is the exact same check but sile=
nt (without the warning<br>logs).<br><br>To avoid any confusion i repeat my=
 patch, which does not produce any<br>logging every time, <br>but just avoi=
ds the lockup referencing null pointers when external<br>displays goes to s=
leep.<br><br><br>```diff<br>diff --git a/drivers/gpu/drm/nouveau/nvkm/engin=
e/disp/nv50.c<br>b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>index=
 51c045bdfcbb..ab1bc0898def 100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/en=
gine/disp/nv50.c<br>+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<b=
r>@@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head,<br>=
struct nvkm_ior *ior)<br>&nbsp;{<br>&nbsp;<span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">=09</span>struct nvkm_subdev *subdev =3D &amp;head-=
&gt;disp-&gt;engine.subdev;<br>&nbsp;<br>+<span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">=09</span>/* If the DisplayPort link is inactive (0=
 lanes), skip<br>configuration */<br>+<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">=09</span>if (ior-&gt;dp.nr =3D=3D 0)<br>+<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">=09</span><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">=09</span>return;<br>+<br>&nbsp;<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>const u32 khz=
 =3D head-&gt;asy.hz / 1000;<br>&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">=09</span>const u32 linkKBps =3D ior-&gt;dp.bw * 27000=
;<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</sp=
an>const u32 symbol =3D 100000;<br>```<br><br>This completely fixes my leno=
vo T430(NVIDIA NVS 5400M) + 4338 Dock<br>and 2 external (multi-input) monit=
ors freeze, proven over some years.<br>At the time the nvidia kernel driver=
 on my T430 became an issue wih<br>newer kernels, and notice nouveau driver=
 did pretty well too.<br><br>Hope this claries it.<br><br>Best regards,<br>=
Arjan Filius<br><br><br></div><blockquote type=3D"cite" style=3D"margin:0 0=
 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div>On 16 Jul 202=
6, at 22:40, lyude@redhat.com&nbsp;wrote:<br><br>Hi, can you please clarify=
 whether or not you used generative AI<br>for<br>this patch series? If so, =
this needs to be noted as part of the<br>commit<br>message. Additionally, b=
oth of these patches look to be identical<br>except that one prints a messa=
ge and the other doesn't. You can<br>just<br>send a single version, we will=
 figure out how to handle that part<br>after.<br><br>On Thu, 2026-07-16 at =
16:55 +0200, Arjan Filius wrote:<br></div><blockquote type=3D"cite" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div=
>Dear Nouveau Maintainers,<br>&nbsp;<br>Please find below a proposed patch =
to prevent a division-by-zero<br>kernel oops and subsequent lockup in the N=
ouveau display<br>supervisor<br>engine when DisplayPort links transition to=
 0 active lanes. This<br>bug<br>was observed and patched/tested against the=
 mainline kernel<br>version<br>**7.1.3**, but is present in all current ups=
tream code.<br>&nbsp;<br>---<br>&nbsp;<br>### BRIEF EXPLANATION<br>&nbsp;<b=
r>During screen sleep transitions or multi-input display switches<br>(KVM<b=
r>switching), the active lane count of a DisplayPort link can<br>temporaril=
y drop to 0 (`ior-&gt;dp.nr =3D=3D 0`). <br>&nbsp;<br>When this occurs, the=
 DisplayPort supervisor function<br>`nv50_disp_super_2_2_dp` is invoked via=
 modeset interrupts.<br>Without<br>an early-exit guard, the function attemp=
ts to perform<br>symbols/hblank<br>and link rate calculations that divide b=
y `ior-&gt;dp.nr`, resulting<br>in<br>a kernel division-by-zero math except=
ion, lockup, and system<br>freeze.<br>&nbsp;<br>This patch adds an early-ex=
it check at the beginning of<br>`nv50_disp_super_2_2_dp` to abort display c=
onfiguration when the<br>link<br>training lanes count is zero.<br><br>*&nbs=
p;&nbsp; **Tested Kernel Version:** `7.1.3` (mainline stable branch)<br><br=
>---<br><br>### EXTREMELY DETAILED TECHNICAL BREAKDOWN<br><br>#### 1. Hardw=
are Context<br>This bug has been consistently reproduced on a Lenovo ThinkP=
ad<br>T430<br>(Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset)<b=
r>connected<br>to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) wi=
th<br>dual<br>external monitors on dock DisplayPorts (`DP-2` and `DP-3`). <=
br><br>#### 2. Root Cause Analysis (Code Level)<br>Inside `drivers/gpu/drm/=
nouveau/nvkm/engine/disp/nv50.c`, when<br>`ior-<br></div><blockquote type=
=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding=
-left:1ex"><div>dp.nr =3D=3D 0`, the driver executes the following lines in=
<br></div></blockquote><div>`nv50_disp_super_2_2_dp()`:<br><br>*&nbsp;&nbsp=
; **Line 1179:** Calculations for horizontal blank symbols:<br>&nbsp;&nbsp;=
&nbsp; ```c<br>&nbsp;&nbsp;&nbsp; h =3D h - (3 * ior-&gt;dp.ef) - (12 / ior=
-&gt;dp.nr);<br>&nbsp;&nbsp;&nbsp; ```<br>*&nbsp;&nbsp; **Line 1185:** Calc=
ulations for vertical blank symbols:<br>&nbsp;&nbsp;&nbsp; ```c<br>&nbsp;&n=
bsp;&nbsp; v =3D v - ((36 / ior-&gt;dp.nr) + 3) - 1;<br>&nbsp;&nbsp;&nbsp; =
```<br>*&nbsp;&nbsp; **Line 1190:** Calculations for active link data rate:=
<br>&nbsp;&nbsp;&nbsp; ```c<br>&nbsp;&nbsp;&nbsp; link_data_rate =3D (khz *=
 head-&gt;asy.or.depth / 8) / ior-&gt;dp.nr;<br>&nbsp;&nbsp;&nbsp; ```<br><=
br>In all three instances, the denominator `ior-&gt;dp.nr` is `0`,<br>causi=
ng<br>an immediate kernel math exception in the display workqueue<br>(`nouv=
eau_display_hpd_work` or `nv50_disp_super`), locking up the<br>graphics pip=
eline, freezing the screen, and hanging any reboot<br>attempts (requiring a=
 physical hard reset).<br><br>#### 3. Daily Workday Trigger Scenario<br>1.&=
nbsp; The T430 (via dock) and a secondary workstation are both<br>connected=
 to different inputs on the same external monitors.<br>2.&nbsp; The monitor=
s' input sources are switched to the secondary<br>workstation.<br>3.&nbsp; =
At the end of the day, the secondary workstation goes to<br>sleep or<br>is =
shut down.<br>4.&nbsp; With no active inputs, the external monitors enter p=
ower-<br>saving<br>standby mode.<br>5.&nbsp; When the user subsequently wak=
es up or interacts with the<br>T430,<br>the driver attempts a modeset refre=
sh. Since the monitors are<br>asleep<br>and inputs are switched away, the l=
anes count is read as `0`,<br>triggering the division-by-zero oops.<br><br>=
#### 4. Stack Trace (Oops Log)<br>```text<br>[di jul 23 10:28:25 2024] nouv=
eau 0000:01:00.0: DRM: DDC<br>responded,<br>but no EDID for DP-2<br>[di jul=
 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC<br>responded,<br>but no E=
DID for DP-3<br>[di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_su=
per<br>[nouveau]<br>[di jul 23 10:28:26 2024] RIP:<br>0010:nv50_disp_super_=
2_2_dp+0xa7/0x320<br>[nouveau]<br>[di jul 23 10:28:26 2024]&nbsp; ? nv50_di=
sp_super_2_2_dp+0xa7/0x320<br>[nouveau]<br>[di jul 23 10:28:26 2024]&nbsp; =
nv50_disp_super_2_2+0xf2/0x160<br>[nouveau]<br>[di jul 23 10:28:26 2024]&nb=
sp; nv50_disp_super+0x139/0x280 [nouveau]<br>```<br><br>#### 5. Verificatio=
n Proof (Bypass Log)<br>With the patch applied and running on kernel `7.1.3=
-custom #2`,<br>the<br>screen standby transition was bypassed cleanly. The =
driver caught<br>the<br>lane count of 0, bypassed display configuration, an=
d proceeded to<br>put<br>the graphics chip into its low-power runtime suspe=
nd state<br>(`suspended`) without locking up the OS:<br>```text<br>[45162.2=
32371] nouveau 0000:01:00.0: disp: DP link is inactive<br>(lanes<br>=3D 0),=
 skipping display configuration.<br>[45162.232402] nouveau 0000:01:00.0: di=
sp: DP link is inactive<br>(lanes<br>=3D 0), skipping display configuration=
.<br>[45178.605627] nouveau 0000:01:00.0: timeout<br>[45178.605629] WARNING=
: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]<br>[45180.608524] nouveau 0000:=
01:00.0: disp: ch 1 fini timeout,<br>8e061008<br>[45182.608521] nouveau 000=
0:01:00.0: timeout<br>[45182.608523] WARNING: nv50_disp_core_fini+0x143/0x1=
90 [nouveau]<br>```<br><br>---<br><br>Signed-off-by: Arjan Filius &lt;iafil=
ius@xs4all.nl&gt;<br>---<br><br>### CHOOSE ONE OF THE PATCH OPTIONS BELOW T=
O APPEND:<br><br>#### OPTION A: The Silent Production Patch (RECOMMENDED FO=
R<br>UPSTREAM)<br>*Note: Kernel maintainers generally reject warnings or pr=
int spam<br>for<br>expected hardware sleep/disconnect transitions. A silent=
 return<br>is<br>the preferred upstream pattern.*<br><br>```diff<br>diff --=
git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>b/drivers/gpu/drm/=
nouveau/nvkm/engine/disp/nv50.c<br>index 51c045bdfcbb..ab1bc0898def 100644<=
br>--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>+++ b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/nv50.c<br>@@ -1157,6 +1157,10 @@ nv50_disp_=
super_2_2_dp(struct nvkm_head<br>*head,<br>struct nvkm_ior *ior)<br>&nbsp;{=
<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</spa=
n>struct nvkm_subdev *subdev =3D &amp;head-&gt;disp-&gt;engine.subdev;<br>&=
nbsp;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</spa=
n>/* If the DisplayPort link is inactive (0 lanes), skip<br>configuration *=
/<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>if=
 (ior-&gt;dp.nr =3D=3D 0)<br>+<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">=09</span><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">=09</span>return;<br>+<br>&nbsp;<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">=09</span>const u32 khz =3D head-&gt;asy.hz / 1000;<br>&n=
bsp;<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>cons=
t u32 linkKBps =3D ior-&gt;dp.bw * 27000;<br>&nbsp;<span class=3D"Apple-tab=
-span" style=3D"white-space:pre">=09</span>const u32 symbol =3D 100000;<br>=
```<br><br>#### OPTION B: The Warning/Verbose Patch (What was tested<br>loc=
ally)<br>*Note: Prints warning logs to the kernel buffer for validation<br>=
and<br>troubleshooting.*<br><br>```diff<br>diff --git a/drivers/gpu/drm/nou=
veau/nvkm/engine/disp/nv50.c<br>b/drivers/gpu/drm/nouveau/nvkm/engine/disp/=
nv50.c<br>index 51c045bdfcbb..ab1bc0898def 100644<br>--- a/drivers/gpu/drm/=
nouveau/nvkm/engine/disp/nv50.c<br>+++ b/drivers/gpu/drm/nouveau/nvkm/engin=
e/disp/nv50.c<br>@@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_=
head<br>*head,<br>struct nvkm_ior *ior)<br>&nbsp;{<br>&nbsp;<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">=09</span>struct nvkm_subdev *sub=
dev =3D &amp;head-&gt;disp-&gt;engine.subdev;<br>&nbsp;<br>+<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">=09</span>/* If the DisplayPort l=
ink is inactive (0 lanes), skip<br>configuration */<br>+<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">=09</span>if (ior-&gt;dp.nr =3D=3D 0)=
 {<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>nvkm_warn=
(subdev, "DP link is inactive (lanes =3D<br>0),<br>skipping display configu=
ration.\n");<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
=09</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</spa=
n>return;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09<=
/span>}<br>+<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">=09</span>const u32 khz =3D head-&gt;asy.hz / 1000;<br>&nbsp;<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>const u32 linkKBps=
 =3D ior-&gt;dp.bw * 27000;<br>&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">=09</span>const u32 symbol =3D 100000;<br>```<br></div=
></blockquote><div><br></div></blockquote></blockquote><br></div></div></bl=
ockquote></div><div><br></div></blockquote><div><br></div><div><span></span=
></div></body></html>

--=-7b40JqUyUNzA3oQ/x6Tu--

