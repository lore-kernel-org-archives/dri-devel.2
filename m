Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE201061B04
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A4310E819;
	Mon, 30 Mar 2026 14:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rl6Iw13O";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF8610E817
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:34:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so54844495e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774881261; x=1775486061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82enXGmzdL38myUs9CoXr/paEg33ghGzuXyVpsOhERs=;
 b=rl6Iw13Ojglp0kj+7DI94DAKtoOvGjObYCvjni3tHSo+B1swfYA9dlknzAL/qoxzMY
 nHETULfWxpzY5wU0Zmf7rHKWBP4LqrDcuH8T9aUpWO++W1TrlEtxAQMBowGd9cD+hDZb
 oiGPLaF7t8hTjMgf3oXXzdxCSnFD2QNyh+9Ytli+GLM2G//KEtrDVCL5r3bNGI8cUsXC
 5pDshCEoBiTf4VWCMHDgp0OlL9z12luRxdu/Vik2zvKrOfHWwJ6ujY2AF7wqon0myfju
 vhZbaNjJ9ZwdEz9k2Sp+ZzTm0loJCgDB379x0A9wO19FuwlhjPQjOlqTN4W36sx0y/Gh
 S/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881261; x=1775486061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82enXGmzdL38myUs9CoXr/paEg33ghGzuXyVpsOhERs=;
 b=sUZ9V1WxuEBAZebdGvl2FZvafevYQymPHTrkcjcFOdMExGGagogAQXZQnoUtZ4cakl
 UCGs6oG7hUfIqpGSfutAI260psLGnGXmZMARyA1gsDswS2nJCqU7LaLJuK/7zydKbjj8
 3wA0F2/P5b/bhWYb+XtVcJ1h3iOFjUyRNOunfTZ9XfAcMBrMNbRDzbQrYoPRGGVYRZou
 OeEDdY0BY7SXnI585YF0w4UiSiBedquc6P5ZgSxKUAwUSZTaFbPCKJDcpRLvK3nzEw4F
 95SSaj1AH5cQ7MsDSx2rnkASL4y2lpxszd8FB400kBwT7LqVMWUZhxKa6Ogw3GJmUPxr
 fnMA==
X-Gm-Message-State: AOJu0Yw6nk3GgkjiNM/ltHfN1vdnx+Ngo5Jo/FRoU6A+szgEd7HDjPT9
 fxvDmCRZZcjJ0CaIrvB1PKaAvhc84uOZrVWgGbspd/Ytv8fWanzZ2f5t
X-Gm-Gg: ATEYQzyJUroMxDKnR9Ke+F+HUtwVy8qpPYn38yN3bgW17qUyFnZbmG0/YUkEZWUIPTr
 qMWQMa5FcxbNTdnLlnO4bQPzBHvVB0MCsJS1Jhx0M9PJZzo6w94E/Bnob01GGhCL2e/7xAZyqAK
 mjigxudFG+WC4AM2152W2EK6WeoEi0CKxWscnEWQlPmYkJNFSA0b4ruHw09OLX/Z4icthyMwvTa
 zGEZ9Rl4Z8TlfY/SaUtVG0XrZItrD1OrHZhoGmW9PZ6uofGfrHgPdlu49WVlfvzW9kIAYw99YHT
 c/V0OKdG1AhI5hVcGqY04r91S3Yf4zXT5Zqv3Ols6Bsn2hVYTdXkTH6lu8YER6hmxYGmzY67s33
 Q+tD0fVRipLuwqeVh/vdPZKWlEtlA0av/QHBW5r38xUP8W1M/MNdCHeA1QGCeyhg1U8HRIsaY4W
 MIjllOs8gnHz7pB48K+9OlUi5jFwMyzs+88YO9PVJ9hM/kIxwbrRfb9cUn1wk7uWz9HesTnNzX
X-Received: by 2002:a05:6000:2f87:b0:43c:faee:86b with SMTP id
 ffacd0b85a97d-43cfaee09a6mr8949016f8f.48.1774881260842; 
 Mon, 30 Mar 2026 07:34:20 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2628sm21411631f8f.6.2026.03.30.07.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:34:20 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com,
 Danilo Machado <danilomachado2002@gmail.com>
Subject: Re: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
Date: Mon, 30 Mar 2026 16:34:19 +0200
Message-ID: <22574187.4csPzL39Zc@timur-hyperion>
In-Reply-To: <CAJ9xWrJaN80e1jzieNBCZ35BRrBNDg53L+jE-z6Zh6tPbDTNTw@mail.gmail.com>
References: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
 <CAJ9xWrL79F7bt+=Nbohp-pwDaOOWE8Cazah7kvtOdk5mutAG3Q@mail.gmail.com>
 <CAJ9xWrJaN80e1jzieNBCZ35BRrBNDg53L+jE-z6Zh6tPbDTNTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Sunday, March 29, 2026 11:36:19=E2=80=AFPM Central European Summer Time =
Danilo=20
Machado wrote:
> Hi all,
>=20
> I would like to share an important update based on further testing.
>=20
> After implementing a temporary workaround, I noticed that the issue is not
> limited to suspend/resume. There is a second trigger that seems to affect
> the same underlying problem.

Hi Danilo,

I responded on the GitLab issue.
I recommend to continue the conversation there.

Best regards,
Timur


> =F0=9F=94=8D Additional trigger identified (DPMS / screen off)
>=20
> Sequence:
>=20
>    1.
>=20
>    System resumes from suspend =E2=86=92 works correctly (login screen ap=
pears)
>    2.
>=20
>    System becomes idle =E2=86=92 screen turns off (DPMS)
>    3.
>=20
>    Upon user interaction (keyboard/mouse), the display fails to wake
>    properly
>=20
> Observed behavior:
>=20
>    -
>=20
>    Black screen or no signal
>    -
>=20
>    System remains responsive (can sometimes type blindly)
>    -
>=20
>    In some cases, session becomes partially corrupted
>=20
> Important detail:
>=20
> This behavior is very similar to what happens after suspend/resume:
>=20
>    -
>=20
>    HDMI link is not properly restored
>    -
>=20
>    Monitor may be misdetected or not reinitialized correctly
>=20
> ------------------------------
> =F0=9F=A7=AA Workaround behavior
>=20
>    -
>=20
>    Disabling the phantom output (DVI-D-1) restores the display immediately
>    -
>=20
>    Forcing HDMI-A-0 as primary also helps reinitialize the session
>    -
>=20
>    Disabling automatic screen-off (DPMS) avoids the issue entirely
>=20
> ------------------------------
> =F0=9F=A7=A0 Interpretation
>=20
> This suggests the problem is not strictly related to suspend, but more
> generally to *display reinitialization after power state transitions*,
> including:
>=20
>    -
>=20
>    suspend/resume (deep)
>    -
>=20
>    screen power off/on (DPMS)
>=20
> Given that both paths trigger similar failures, this may point to issues =
in:
>=20
>    -
>=20
>    EDID re-read after power events
>    -
>=20
>    HDMI link training
>    -
>=20
>    atomic modeset state reconstruction
>    -
>=20
>    DC state restore
>=20
> ------------------------------
> =F0=9F=92=A1 Conclusion
>=20
> The bisected commit may still represent a valid trigger point, but the ro=
ot
> cause appears to be related to how display state is restored after power
> transitions, rather than suspend alone.
> ------------------------------
> =F0=9F=93=8E Additional notes
>=20
>    -
>=20
>    Wayland still does not show the same hard failure
>    -
>=20
>    Issue remains reproducible
>    -
>=20
>    Workarounds are consistent
>=20
> ------------------------------
>=20
> I hope this additional information helps narrow down the issue further.
>=20
> Please let me know if I can assist with more testing.
>=20
> Thanks again for your time and your work.
>=20
> Best regards,
> Danilo
>=20
>=20
> Em dom., 29 de mar. de 2026 =C3=A0s 13:34, Danilo Machado <
>=20
> danilomachado2002@gmail.com> escreveu:
> > Hi all,
> >=20
> > I=E2=80=99d like to provide a final update on this regression affecting=
 AMD Radeon
> > R9 380 (Tonga), which I bisected earlier between Linux 6.3 (good) and 6=
=2E4
> > (bad).
> >=20
> > After further investigation, I was able to isolate the issue more
> > precisely and identify a reliable workaround.
> >=20
> > =F0=9F=94=8D Summary:
> >=20
> > After suspend/resume under X11:
> >    -
> >   =20
> >    HDMI monitor is physically connected and EDID is valid
> >    -
> >   =20
> >    Kernel (DRM) correctly detects the HDMI connector
> >    -
> >   =20
> >    However, X11 ends up with an inconsistent display state
> >=20
> > Observed behavior:
> >    -
> >   =20
> >    HDMI-A-0 is active at correct resolution (1920x1080)
> >    -
> >   =20
> >    A phantom output (DVI-D-1) appears as connected
> >    -
> >   =20
> >    DVI-D-1 is incorrectly set as primary at 640x480
> >    -
> >   =20
> >    Desktop becomes corrupted (missing panels, apps failing, incorrect
> >    layout)
> >=20
> > xrandr example after resume:
> >=20
> > HDMI-A-0 connected 1920x1080+0+0
> > DVI-D-1 connected primary 640x480+1920+116
> >=20
> > =F0=9F=A7=A0 Key finding:
> >=20
> > The issue is not EDID or link training. EDID is readable and valid.
> >=20
> > This appears to be a failure in atomic modeset / connector-to-CRTC mapp=
ing
> > during resume, leading to an incorrect fallback output being selected as
> > primary.
> >=20
> > =F0=9F=92=A1 Workaround (100% reproducible fix):
> >=20
> > Running the following immediately restores the system:
> >=20
> > xrandr --output DVI-D-1 --off
> > xrandr --output HDMI-A-0 --primary --mode 1920x1080
> >=20
> > This strongly suggests that the correct state exists but is not applied
> > automatically after resume.
> >=20
> > =E2=9A=99=EF=B8=8F Additional observations:
> >    -
> >   =20
> >    Wayland does not exhibit the same failure (likely due to dynamic sta=
te
> >    handling)
> >    -
> >   =20
> >    Issue reproducible only on 6.4+
> >    -
> >   =20
> >    s2idle reduces severity but does not fix the issue
> >    -
> >   =20
> >    amdgpu.dc=3D0 makes the system fully unusable after resume
> >=20
> > =F0=9F=A7=AA Bisect:
> >=20
> > First bad commit:
> > b3c98052d46948a8d65d2778c7f306ff38366aac (KVM merge)
> >=20
> > This likely indicates an indirect trigger (timing/order change during
> > resume), not a direct amdgpu change.
> >=20
> > =F0=9F=93=8E Logs and details available upon request.
> >=20
> > =F0=9F=99=8F I=E2=80=99m happy to test patches or provide additional de=
bug information.
> >=20
> > Thanks for your time and for maintaining amdgpu.
> >=20
> > Best regards,
> > Danilo
> >=20
> > Em dom., 29 de mar. de 2026 =C3=A0s 10:35, Danilo Machado <
> >=20
> > danilomachado2002@gmail.com> escreveu:
> >> Also reported on GitLab:
> >> https://gitlab.freedesktop.org/drm/amd/-/work_items/5123
> >>=20
> >> Em dom., 29 de mar. de 2026 =C3=A0s 09:47, Danilo Machado <
> >>=20
> >> danilomachado2002@gmail.com> escreveu:
> >>> Additional testing:
> >>>=20
> >>> I tested with amdgpu.dc=3D0 to disable Display Core.
> >>>=20
> >>> Result:
> >>> - system becomes completely unresponsive after resume
> >>> - black screen, no input response
> >>>=20
> >>> This suggests the issue is not limited to Display Core (DC),
> >>> but likely affects the core GPU resume path.
> >>>=20
> >>> With DC enabled:
> >>> - partial recovery (corrupted display, EDID failure)
> >>>=20
> >>> With DC disabled:
> >>> - complete failure
> >>>=20
> >>> This reinforces that the regression is deeper in the amdgpu resume
> >>> sequence.
> >>>=20
> >>> Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado <
> >>>=20
> >>> danilomachado2002@gmail.com> escreveu:
> >>>> Additional data (resume failure analysis)
> >>>>=20
> >>>> Hardware:
> >>>> - GPU: AMD Radeon R9 380 (Tonga, GCN 3)
> >>>> - CPU: AMD Ryzen 5 5500
> >>>> - RAM: 16 GB
> >>>> - Display: HDMI
> >>>>=20
> >>>> Software:
> >>>> - Kernel: 6.8.0-106-generic
> >>>> - Driver: amdgpu
> >>>> - Display server: X11 (issue reproducible), Wayland (no hard failure)
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Summary:
> >>>>=20
> >>>> After suspend/resume, HDMI output is not restored and the system may
> >>>> freeze under X11.
> >>>>=20
> >>>> The issue is reproducible and was not present in Linux 6.3.
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Key observation:
> >>>>=20
> >>>> During resume, the driver fails to read EDID:
> >>>>     amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> >>>>=20
> >>>> This appears to explain why HDMI output is not restored.
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Relevant DRM / AMDGPU log excerpt:
> >>>>=20
> >>>> [drm] Display Core v3.2.266 initialized on DCE 10.0
> >>>> amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> >>>> [drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Analysis:
> >>>>=20
> >>>> - The failure occurs during display reinitialization after resume
> >>>> - EDID read failure prevents proper HDMI modeset
> >>>> - This aligns with the observed "no signal" condition
> >>>>=20
> >>>> Behavior differences:
> >>>>=20
> >>>> - deep sleep:
> >>>>   - full GPU/display reinitialization
> >>>>   - leads to EDID failure and system instability
> >>>>=20
> >>>> - s2idle:
> >>>>   - partial resume
> >>>>   - avoids full lockup but display may still be inconsistent
> >>>>=20
> >>>> This suggests the issue is in the display resume path, possibly
> >>>> involving:
> >>>>=20
> >>>> - DC state restore
> >>>> - HDMI link training
> >>>> - DDC/EDID communication
> >>>> - atomic modeset reconstruction
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Conclusion:
> >>>>=20
> >>>> This is likely a regression in the AMDGPU display resume path, where
> >>>> EDID read fails after resume, preventing HDMI output from being
> >>>> restored.
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> Additional notes:
> >>>>=20
> >>>> This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with
> >>>> the transition point identified as a KVM merge commit. While not
> >>>> directly
> >>>> related to AMDGPU, it may have indirectly exposed this issue via
> >>>> timing/order changes.
> >>>>=20
> >>>> ---
> >>>>=20
> >>>> If needed, I can provide:
> >>>>=20
> >>>> - full journalctl logs
> >>>> - full bisect log
> >>>> - additional testing (kernel params, debug options)
> >>>> ------------------------------
> >>>> *De:* Danilo Machado <danilomachado2002@hotmail.com>
> >>>> *Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
> >>>> *Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> >>>> *Cc:* Alex Deucher <alexdeucher@gmail.com>;
> >>>> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
> >>>> *Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
> >>>> suspend/resume
> >>>>=20
> >>>>=20
> >>>> Hi all,
> >>>>=20
> >>>> Thanks again for your feedback.
> >>>>=20
> >>>> I took a closer look at the bisect results and system behavior, and =
I=E2=80=99d
> >>>> like to provide a more complete and consolidated report.
> >>>> ------------------------------
> >>>>=20
> >>>> Hardware:
> >>>>    -
> >>>>   =20
> >>>>    GPU: AMD Radeon R9 380 (Tonga, GCN 3)
> >>>>    -
> >>>>   =20
> >>>>    CPU: AMD Ryzen 5 5500
> >>>>    -
> >>>>   =20
> >>>>    RAM: 16 GB
> >>>>    -
> >>>>   =20
> >>>>    Display: HDMI
> >>>>=20
> >>>> Software:
> >>>>    -
> >>>>   =20
> >>>>    Driver: amdgpu
> >>>>    -
> >>>>   =20
> >>>>    Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)
> >>>>=20
> >>>> ------------------------------
> >>>>=20
> >>>> Summary:
> >>>>=20
> >>>> This is a reproducible suspend/resume regression affecting HDMI outp=
ut.
> >>>>=20
> >>>>    -
> >>>>   =20
> >>>>    Linux 6.3 =E2=86=92 working correctly
> >>>>    -
> >>>>   =20
> >>>>    Linux 6.4+ =E2=86=92 regression present
> >>>>=20
> >>>> ------------------------------
> >>>>=20
> >>>> Behavior:
> >>>>=20
> >>>> After suspend/resume:
> >>>>    -
> >>>>   =20
> >>>>    HDMI output does not recover ("no signal")
> >>>>    -
> >>>>   =20
> >>>>    System may freeze under X11
> >>>>    -
> >>>>   =20
> >>>>    Wayland does not show the same hard failure
> >>>>=20
> >>>> Additionally:
> >>>>    -
> >>>>   =20
> >>>>    Using "deep" sleep:
> >>>>    -
> >>>>   =20
> >>>>       full system lockup after resume
> >>>>       -
> >>>>   =20
> >>>>    Using "s2idle":
> >>>>    -
> >>>>   =20
> >>>>       system resumes without hard lock
> >>>>       -
> >>>>      =20
> >>>>       however, graphical session may return in a partially broken st=
ate
> >>>>=20
> >>>> ------------------------------
> >>>>=20
> >>>> Bisect result:
> >>>>=20
> >>>> A full git bisect was performed between Linux 6.3 and 6.4.
> >>>>=20
> >>>> First bad commit:
> >>>> b3c98052d46948a8d65d2778c7f306ff38366aac
> >>>> ("Merge tag 'kvm-x86-vmx-6.4'")
> >>>>=20
> >>>> All intermediate commits in that range were consistently tested as
> >>>> GOOD.
> >>>> ------------------------------
> >>>>=20
> >>>> Analysis:
> >>>>=20
> >>>> Although the bisected commit is in KVM and unlikely to directly affe=
ct
> >>>> AMDGPU, the transition point is consistent and reproducible.
> >>>>=20
> >>>> This suggests the regression may be indirectly triggered (e.g. timing
> >>>> or ordering changes during resume), rather than caused directly by t=
hat
> >>>> merge.
> >>>>=20
> >>>> Based on observed behavior, this appears related to the display resu=
me
> >>>>=20
> >>>> path, possibly involving:
> >>>>    -
> >>>>   =20
> >>>>    DC state restore after resume
> >>>>    -
> >>>>   =20
> >>>>    HDMI link training
> >>>>    -
> >>>>   =20
> >>>>    EDID re-read
> >>>>    -
> >>>>   =20
> >>>>    atomic modeset state reconstruction
> >>>>=20
> >>>> The difference between "deep" and "s2idle" also suggests a failure
> >>>> during full GPU/display reinitialization.
> >>>> ------------------------------
> >>>>=20
> >>>> Conclusion:
> >>>>=20
> >>>> This appears to be a latent issue exposed by changes introduced duri=
ng
> >>>> the 6.4 merge window, rather than a direct regression in the bisected
> >>>> commit itself.
> >>>> ------------------------------
> >>>>=20
> >>>> If helpful, I can assist further by:
> >>>>    -
> >>>>   =20
> >>>>    providing full bisect logs
> >>>>    -
> >>>>   =20
> >>>>    capturing detailed dmesg/journalctl before and after resume
> >>>>    -
> >>>>   =20
> >>>>    testing patches or debug options
> >>>>    -
> >>>>   =20
> >>>>    narrowing the range further if needed
> >>>>=20
> >>>> I really appreciate the work on AMDGPU and would be glad to help wit=
hin
> >>>> my limits to investigate this further.
> >>>>=20
> >>>> Thanks again for your time.
> >>>>=20
> >>>> Best regards,
> >>>> Danilo
> >>>> Note: I had some email client configuration issues earlier, which may
> >>>> have caused duplicate messages or formatting problems. These have now
> >>>> been
> >>>> resolved =E2=80=94 apologies for any inconvenience.
> >>>=20
> >>> --
> >>> *Danilo Machado*
> >>=20
> >> --
> >> *Danilo Machado*
> >=20
> > --
> > *Danilo Machado*




