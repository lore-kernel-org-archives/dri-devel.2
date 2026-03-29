Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC2AFB3CE4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0736710E511;
	Mon, 30 Mar 2026 09:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gL/HC7To";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B873310E0B8
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 12:47:37 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so429859766b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 05:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774788456; cv=none;
 d=google.com; s=arc-20240605;
 b=iMr9TPqRu3TnE8SPaTEZYcNoSZ5fDvhF8Jv/C/cxCT/hJ/xOBWUwoxRaqdHH+LjRwt
 UcWpWahKGV8VGkfz7NE+3wNvMYsIGCOW6/VKGN3YE5ak42PcRjIO5sHUrHcZvvs0GfKW
 +uOJb6w2SY7Kr/F/yBze0cldnPBsLxZmP8SgHgCR5ZM/U0H3+PnpVlepdDVmtsdlRfr8
 JM5EcA1weVpWfHY1RY97b9FrUbaAF28d/noVlPiV006DcgzLTfkAADBYsg/5is+dsEeH
 yb6TZPtqfvz3r+8egdN6oRr2SHkTRLSvNRk2I/72H/ecFTN+yvnEvSJ9u6eN9qfNmJQo
 xAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DGX9MUYR34C6Cld2oVgT0V5k5hgWMn7/mYTRpsu3rY4=;
 fh=yamdC3/PPc+0MFt+AHbabBa11fylHWJWIW5k6ZaqpcU=;
 b=IwU3d6sTsVjEs4QahfwMmcjknRt643BqRDkLn+aAVdYJQ2nOSkXyYn7F1NO868TxVz
 rZbgCyCXVLBs8rNzBv/JaYAfxrvYcv6F4POEV9zjQtI9r7yTprxXHD2Y3JU9G7sboYJC
 LyNUxab4vXcNh8Iz5fYXjLyBjhLp7GsSWHtlSWLQI2CRbQ5mF3dYI1W+X77A/7c4cm9t
 MjyEFFZRDi5T1qaHUxRIucpm4iRk1fb8akpIfUZujyNA9Fw9ZU8kJPaZtBuizHTFg6tc
 JAj65fwS9kZxPs8nrje+cLiyTsLKcyu+xw+8iQ1NxsabwKni6ywUFkg99QlcGGU9gnJf
 w9Vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774788456; x=1775393256; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGX9MUYR34C6Cld2oVgT0V5k5hgWMn7/mYTRpsu3rY4=;
 b=gL/HC7ToCg/E9A83lQX0GkTz37PLoLHjNh4/90I4FmBBTeYYqFjElkP1PEqwj4Z/u1
 ozYL3R2aZft6W11JVZEmvy707WrpK3zDzbp/DQpLh4uSvSpUxVFHjq8dlZN1b2CqUOs7
 EH2FYTIx1iJtJ5IEKluOQVcRW2cnnuTiXJu5yHWIkmrpxKHBk/v72C/LXaFxvFPnquAi
 lT63t89o+Tkai6HKmOuyQoLqRve5+uropEADieB9Uw8I3piEJBO62ZL6OPKXybRJFsF8
 cCcmyUyRh9BJ1u3iQlQlSUlQHsGkO7muVPcVbXxlb+fKXuj73US1ac5lJSNODJJAwSyg
 I7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774788456; x=1775393256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGX9MUYR34C6Cld2oVgT0V5k5hgWMn7/mYTRpsu3rY4=;
 b=FSTrA4XW/gcO3CJu5dY3XR9LsL9obH3WuKaKIlDSu9wLZ+V9mGErrwg+4o/7XrC9W3
 jTRph87Ri8cinz8GcMfiYopt7aDOMJVOOm7uqVZ9EDxbpQQczMpChrKACcVZHwOloFwy
 mjkfw1UYgNxIookQeU/QmZuxeNQvM7B53QhvSEghB5zP17+fNsXyL8mNUbPPuBXV+RgF
 snGQgzvKAHxZyDYa9bVAyxqY/cIHK30yzrkUXEY1OOTWNnScHv9RfnA90mZNOZLVP3Um
 r8BVB4T6EKpfN99/JtxnlmbIQvzAofmKPeanXZ20KLJFUg/YkoTP8Gm58fThHMoaZo/c
 K0qQ==
X-Gm-Message-State: AOJu0YwyMqy3MziiDxKyfJeExZqE2qgWyu7ZfjVr6PIy3GM/6C/vNZYu
 HGnHQJWpVw+W911Dg36C7FzkrSoFKS6WMtnWBAxdLpg0SshtB1G2Z0ZGvwsGIfZwdax6Jhyh3wd
 8Ht4a7C5OgjBLTACb9QOSEQbXPtde4U1JGas=
X-Gm-Gg: ATEYQzwj2J2B6L4olz49CqP/QLa0Ui58rXqYWrFrI8XU+4qb/f4+0Bzqbeo82paHSR6
 rDtJy/MovcMpWobkRXw81G00smhkC3DvBPz8uwK0jDhnrAPemYF4f5jw4SByksLYeDcvfCVdivT
 o/8E66djlRa3juitlMK3N7ofqJzlpoP9s1YLQI0o02ydVDd27zKi6O0+1eOkO7EVUyBwJoOXyvD
 3M0qFWmfrgslMApBopJFua4TXCYT8P4EpJk2Tl2eWv4V/82msaOj+DFH1Mbtw3vKOiL1fDJwY1f
 KtkNb+CVeaUmflEYj9zJvx3sZVstjRQZcjBA5ESPx90Xb6BVH1Q=
X-Received: by 2002:a17:906:6206:b0:b98:4e9b:7e49 with SMTP id
 a640c23a62f3a-b9b507b2d17mr561021866b.33.1774788455854; Sun, 29 Mar 2026
 05:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
In-Reply-To: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Sun, 29 Mar 2026 09:47:24 -0300
X-Gm-Features: AQROBzAGG5Kr9qRoLQ529FDz9laRrdG7NLahT_UYtTEu_vbPFhGEBO5G_I20V_c
Message-ID: <CAJ9xWrKwPgM-jeUJB5vMaU0u-wWp=JVCQ_38u-25J6nc3+WZzg@mail.gmail.com>
Subject: Re: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com
Content-Type: multipart/alternative; boundary="00000000000076751a064e292353"
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:06:21 +0000
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

--00000000000076751a064e292353
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Additional testing:

I tested with amdgpu.dc=3D0 to disable Display Core.

Result:
- system becomes completely unresponsive after resume
- black screen, no input response

This suggests the issue is not limited to Display Core (DC),
but likely affects the core GPU resume path.

With DC enabled:
- partial recovery (corrupted display, EDID failure)

With DC disabled:
- complete failure

This reinforces that the regression is deeper in the amdgpu resume sequence=
.

Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado <
danilomachado2002@gmail.com> escreveu:

> Additional data (resume failure analysis)
>
> Hardware:
> - GPU: AMD Radeon R9 380 (Tonga, GCN 3)
> - CPU: AMD Ryzen 5 5500
> - RAM: 16 GB
> - Display: HDMI
>
> Software:
> - Kernel: 6.8.0-106-generic
> - Driver: amdgpu
> - Display server: X11 (issue reproducible), Wayland (no hard failure)
>
> ---
>
> Summary:
>
> After suspend/resume, HDMI output is not restored and the system may
> freeze under X11.
>
> The issue is reproducible and was not present in Linux 6.3.
>
> ---
>
> Key observation:
>
> During resume, the driver fails to read EDID:
>
>     amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>
> This appears to explain why HDMI output is not restored.
>
> ---
>
> Relevant DRM / AMDGPU log excerpt:
>
> [drm] Display Core v3.2.266 initialized on DCE 10.0
> amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> [drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0
>
> ---
>
> Analysis:
>
> - The failure occurs during display reinitialization after resume
> - EDID read failure prevents proper HDMI modeset
> - This aligns with the observed "no signal" condition
>
> Behavior differences:
>
> - deep sleep:
>   - full GPU/display reinitialization
>   - leads to EDID failure and system instability
>
> - s2idle:
>   - partial resume
>   - avoids full lockup but display may still be inconsistent
>
> This suggests the issue is in the display resume path, possibly involving=
:
>
> - DC state restore
> - HDMI link training
> - DDC/EDID communication
> - atomic modeset reconstruction
>
> ---
>
> Conclusion:
>
> This is likely a regression in the AMDGPU display resume path, where EDID
> read fails after resume, preventing HDMI output from being restored.
>
> ---
>
> Additional notes:
>
> This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the
> transition point identified as a KVM merge commit. While not directly
> related to AMDGPU, it may have indirectly exposed this issue via
> timing/order changes.
>
> ---
>
> If needed, I can provide:
>
> - full journalctl logs
> - full bisect log
> - additional testing (kernel params, debug options)
> ------------------------------
> *De:* Danilo Machado <danilomachado2002@hotmail.com>
> *Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
> *Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Alex Deucher <alexdeucher@gmail.com>;
> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
> *Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
> suspend/resume
>
>
> Hi all,
>
> Thanks again for your feedback.
>
> I took a closer look at the bisect results and system behavior, and I=E2=
=80=99d
> like to provide a more complete and consolidated report.
> ------------------------------
>
> Hardware:
>
>    -
>
>    GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>    -
>
>    CPU: AMD Ryzen 5 5500
>    -
>
>    RAM: 16 GB
>    -
>
>    Display: HDMI
>
> Software:
>
>    -
>
>    Driver: amdgpu
>    -
>
>    Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)
>
> ------------------------------
>
> Summary:
>
> This is a reproducible suspend/resume regression affecting HDMI output.
>
>    -
>
>    Linux 6.3 =E2=86=92 working correctly
>    -
>
>    Linux 6.4+ =E2=86=92 regression present
>
> ------------------------------
>
> Behavior:
>
> After suspend/resume:
>
>    -
>
>    HDMI output does not recover ("no signal")
>    -
>
>    System may freeze under X11
>    -
>
>    Wayland does not show the same hard failure
>
> Additionally:
>
>    -
>
>    Using "deep" sleep:
>    -
>
>       full system lockup after resume
>       -
>
>    Using "s2idle":
>    -
>
>       system resumes without hard lock
>       -
>
>       however, graphical session may return in a partially broken state
>
> ------------------------------
>
> Bisect result:
>
> A full git bisect was performed between Linux 6.3 and 6.4.
>
> First bad commit:
> b3c98052d46948a8d65d2778c7f306ff38366aac
> ("Merge tag 'kvm-x86-vmx-6.4'")
>
> All intermediate commits in that range were consistently tested as GOOD.
> ------------------------------
>
> Analysis:
>
> Although the bisected commit is in KVM and unlikely to directly affect
> AMDGPU, the transition point is consistent and reproducible.
>
> This suggests the regression may be indirectly triggered (e.g. timing or
> ordering changes during resume), rather than caused directly by that merg=
e.
>
> Based on observed behavior, this appears related to the display resume
> path, possibly involving:
>
>    -
>
>    DC state restore after resume
>    -
>
>    HDMI link training
>    -
>
>    EDID re-read
>    -
>
>    atomic modeset state reconstruction
>
> The difference between "deep" and "s2idle" also suggests a failure during
> full GPU/display reinitialization.
> ------------------------------
>
> Conclusion:
>
> This appears to be a latent issue exposed by changes introduced during th=
e
> 6.4 merge window, rather than a direct regression in the bisected commit
> itself.
> ------------------------------
>
> If helpful, I can assist further by:
>
>    -
>
>    providing full bisect logs
>    -
>
>    capturing detailed dmesg/journalctl before and after resume
>    -
>
>    testing patches or debug options
>    -
>
>    narrowing the range further if needed
>
> I really appreciate the work on AMDGPU and would be glad to help within m=
y
> limits to investigate this further.
>
> Thanks again for your time.
>
> Best regards,
> Danilo
> Note: I had some email client configuration issues earlier, which may hav=
e
> caused duplicate messages or formatting problems. These have now been
> resolved =E2=80=94 apologies for any inconvenience.
>
>

--=20
*Danilo Machado*

--00000000000076751a064e292353
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Additional testing:<br><br>I tested with amdgpu.dc=3D0 to disab=
le Display Core.<br><br>Result:<br>- system becomes completely unresponsive=
 after resume<br>- black screen, no input response<br><br>This suggests the=
 issue is not limited to Display Core (DC),<br>but likely affects the core =
GPU resume path.<br><br>With DC enabled:<br>- partial recovery (corrupted d=
isplay, EDID failure)<br><br>With DC disabled:<br>- complete failure<br><br=
>This reinforces that the regression is deeper in the amdgpu resume sequenc=
e.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Da=
nilo Machado &lt;<a href=3D"mailto:danilomachado2002@gmail.com">danilomacha=
do2002@gmail.com</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">Additional data (resume failure analysis)</div><div style=3D"=
font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">Hardware:</div><div style=3D"font-family:&quot;C=
alibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">- GPU: AMD Radeon R9 380 (Tonga, GCN 3)</div><div style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">- CPU: AMD Ryzen 5 5500</div><di=
v style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- RAM: 16 GB</div><div st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- Display: HDMI</div><div sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;=
font-size:12pt;color:rgb(0,0,0)">Software:</div><div style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">- Kernel: 6.8.0-106-generic</div><div style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">- Driver: amdgpu</div><div style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">- Display server: X11 (issue reproduci=
ble), Wayland (no hard failure)</div><div style=3D"font-family:&quot;Calibr=
i&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;col=
or:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)">---</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&q=
uot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div>=
<div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Summary:</div><div sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;=
font-size:12pt;color:rgb(0,0,0)">After suspend/resume, HDMI output is not r=
estored and the system may freeze under X11.</div><div style=3D"font-family=
:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">The issue is reproducible and was not present in Linux 6.3.=
</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-=
family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont=
;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot=
;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:1=
2pt;color:rgb(0,0,0)">Key observation:</div><div style=3D"font-family:&quot=
;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:1=
2pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">During resume, the driver fails to read EDID:</div><div style=3D"=
font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">=C2=A0 =C2=A0 amdgpu 0000:01:00.0: [drm] *ERROR*=
 No EDID read.</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Hel=
vetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><b=
r></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This appears t=
o explain why HDMI output is not restored.</div><div style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">---</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&qu=
ot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Relevant DR=
M / AMDGPU log excerpt:</div><div style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">[drm]=
 Display Core v3.2.266 initialized on DCE 10.0</div><div style=3D"font-fami=
ly:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fon=
t-size:12pt;color:rgb(0,0,0)">amdgpu 0000:01:00.0: [drm] *ERROR* No EDID re=
ad.</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">[drm] Initial=
ized amdgpu 3.57.0 20150101 for 0000:01:00.0</div><div style=3D"font-family=
:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">---</div><div style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Analysis:=
</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- The failure occurs during =
display reinitialization after resume</div><div style=3D"font-family:&quot;=
Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)">- EDID read failure prevents proper HDMI modeset</div>=
<div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- This aligns with the=
 observed &quot;no signal&quot; condition</div><div style=3D"font-family:&q=
uot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&=
quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color=
:rgb(0,0,0)">Behavior differences:</div><div style=3D"font-family:&quot;Cal=
ibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;=
color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">- deep sleep:</div><div style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)">=C2=A0 - full GPU/display reinitialization</div><div style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font=
-size:12pt;color:rgb(0,0,0)">=C2=A0 - leads to EDID failure and system inst=
ability</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div=
><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- s2idle:</div><div s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - partial resume</div=
><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - avoids full =
lockup but display may still be inconsistent</div><div style=3D"font-family=
:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">This suggests the issue is in the display resume path, poss=
ibly involving:</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><=
br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DC state re=
store</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&qu=
ot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- HDMI link=
 training</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetic=
a&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DDC/E=
DID communication</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>- atomic modeset reconstruction</div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)">---</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div=
><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Conclusion:</div><div=
 style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,=
serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">This
 is likely a regression in the AMDGPU display resume path, where EDID=20
read fails after resume, preventing HDMI output from being restored.</div><=
div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibr=
i&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;col=
or:rgb(0,0,0)">Additional notes:</div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)">This
 issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the=20
transition point identified as a KVM merge commit. While not directly=20
related to AMDGPU, it may have indirectly exposed this issue via=20
timing/order changes.</div><div style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetic=
a&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</di=
v><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">If needed, I can provide:</div><=
div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">- full journalctl logs</div><div st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- full bisect log</div><div s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- additional testing (kernel=
 params, debug options)</div><div id=3D"m_3075601443013613040gmail-x_append=
onsend"></div><hr style=3D"display:inline-block;width:98%"><div id=3D"m_307=
5601443013613040gmail-x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, s=
ans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>De:</b> Danilo Mac=
hado &lt;<a href=3D"mailto:danilomachado2002@hotmail.com" target=3D"_blank"=
>danilomachado2002@hotmail.com</a>&gt;<br><b>Enviado:</b> quinta-feira, 26 =
de mar=C3=A7o de 2026 20:38<br><b>Para:</b> <a href=3D"mailto:amd-gfx@lists=
.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a> &lt;<=
a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@l=
ists.freedesktop.org</a>&gt;<br><b>Cc:</b> Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt;; =
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a> &lt;<a href=3D"mailto:dri-devel@lists.freedes=
ktop.org" target=3D"_blank">dri-devel@lists.freedesktop.org</a>&gt;<br><b>A=
ssunto:</b> [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after suspe=
nd/resume</font> <div aria-hidden=3D"true">=C2=A0</div></div><div dir=3D"lt=
r"><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family=
:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)">Hi all,</span></p><p style=3D"margin-top:1em;ma=
rgin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Than=
ks again for your feedback.</span></p><p style=3D"margin-top:1em;margin-bot=
tom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quo=
t;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I took a clo=
ser look at the bisect results and system behavior, and I=E2=80=99d like to=
 provide a more complete and consolidated report.</span></p><hr><p style=3D=
"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">Hardware:</span></p><ul><li style=3D"font-family:&quot;Calibr=
i&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><=
p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">GPU: AMD=
 Radeon R9 380 (Tonga, GCN 3)</p></li><li style=3D"font-family:&quot;Calibr=
i&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><=
p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">CPU: AMD=
 Ryzen 5 5500</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presen=
tation" style=3D"margin-top:1em;margin-bottom:1em">RAM: 16 GB</p></li><li s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;fo=
nt-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top=
:1em;margin-bottom:1em">Display: HDMI</p></li></ul><p style=3D"margin-top:1=
em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>Software:</span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot=
;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"pre=
sentation" style=3D"margin-top:1em;margin-bottom:1em">Driver: amdgpu</p></l=
i><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"mar=
gin-top:1em;margin-bottom:1em">Kernel range tested: 6.3 (good) =E2=86=92 6.=
4 (bad)</p></li></ul><hr><p style=3D"margin-top:1em;margin-bottom:1em"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Summary:</span></p><p sty=
le=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Ca=
libri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">This is a reproducible suspend/resume regression affecti=
ng HDMI output.</span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=
=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Linux 6.3 =E2=
=86=92 working correctly</p></li><li style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p rol=
e=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Linux 6.4+ =
=E2=86=92 regression present</p></li></ul><hr><p style=3D"margin-top:1em;ma=
rgin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Beha=
vior:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">After suspend/resume:</span></p>=
<ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans=
-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"m=
argin-top:1em;margin-bottom:1em">HDMI output does not recover (&quot;no sig=
nal&quot;)</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentat=
ion" style=3D"margin-top:1em;margin-bottom:1em">System may freeze under X11=
</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=
=3D"margin-top:1em;margin-bottom:1em">Wayland does not show the same hard f=
ailure</p></li></ul><p style=3D"margin-top:1em;margin-bottom:1em"><span sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Additionally:</span></p><ul><l=
i style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif=
;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-=
top:1em;margin-bottom:1em">Using &quot;deep&quot; sleep:</p></li><ul><li st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;fon=
t-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:=
1em;margin-bottom:1em">full system lockup after resume</p></li></ul><li sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font=
-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1=
em;margin-bottom:1em">Using &quot;s2idle&quot;:</p></li><ul><li style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12=
pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margi=
n-bottom:1em">system resumes without hard lock</p></li><li style=3D"font-fa=
mily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bot=
tom:1em">however, graphical session may return in a partially broken state<=
/p></li></ul></ul><hr><p style=3D"margin-top:1em;margin-bottom:1em"><span s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Bisect result:</span></p><p =
style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot=
;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:1=
2pt;color:rgb(0,0,0)">A full git bisect was performed between Linux 6.3 and=
 6.4.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">First bad commit:<br>b3c98052d46=
948a8d65d2778c7f306ff38366aac<br>(&quot;Merge tag &#39;kvm-x86-vmx-6.4&#39;=
&quot;)</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">All intermediate commits in that=
 range were consistently tested as GOOD.</span></p><hr><p style=3D"margin-t=
op:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">Analysis:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Although
 the bisected commit is in KVM and unlikely to directly affect AMDGPU,=20
the transition point is consistent and reproducible.</span></p><p style=3D"=
margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&=
quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color=
:rgb(0,0,0)">This
 suggests the regression may be indirectly triggered (e.g. timing or=20
ordering changes during resume), rather than caused directly by that=20
merge.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">Based on observed behavior, this=
 appears related to the display resume path, possibly involving:</span></p>=
<ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans=
-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"m=
argin-top:1em;margin-bottom:1em">DC state restore after resume</p></li><li =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;f=
ont-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-to=
p:1em;margin-bottom:1em">HDMI link training</p></li><li style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color=
:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom=
:1em">EDID re-read</p></li><li style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"p=
resentation" style=3D"margin-top:1em;margin-bottom:1em">atomic modeset stat=
e reconstruction</p></li></ul><p style=3D"margin-top:1em;margin-bottom:1em"=
><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">The difference betwe=
en &quot;deep&quot; and &quot;s2idle&quot; also suggests a failure during f=
ull GPU/display reinitialization.</span></p><hr><p style=3D"margin-top:1em;=
margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Hel=
vetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Co=
nclusion:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This
 appears to be a latent issue exposed by changes introduced during the=20
6.4 merge window, rather than a direct regression in the bisected commit
 itself.</span></p><hr><p style=3D"margin-top:1em;margin-bottom:1em"><span =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,s=
erif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">If helpful, I can assist fu=
rther by:</span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"pres=
entation" style=3D"margin-top:1em;margin-bottom:1em">providing full bisect =
logs</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&q=
uot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" s=
tyle=3D"margin-top:1em;margin-bottom:1em">capturing detailed dmesg/journalc=
tl before and after resume</p></li><li style=3D"font-family:&quot;Calibri&q=
uot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p r=
ole=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">testing pat=
ches or debug options</p></li><li style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=
=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">narrowing the =
range further if needed</p></li></ul><p style=3D"margin-top:1em;margin-bott=
om:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I really appr=
eciate the work on AMDGPU and would be glad to help within my limits to inv=
estigate this further.</span></p><p style=3D"margin-top:1em;margin-bottom:1=
em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Thanks again for =
your time.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Best regards,<br>Danilo</span=
></p><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Note:
 I had some email client configuration issues earlier, which may have=20
caused duplicate messages or formatting problems. These have now been=20
resolved =E2=80=94 apologies for any inconvenience.</div></div><br></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">Danilo Machad=
o</i></div></div>

--00000000000076751a064e292353--
