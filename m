Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E8DFB3CE3
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1EC10E487;
	Mon, 30 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItQQDy+R";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D150E10E0C8
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:34:29 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-66ad907833dso6460271a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 09:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774802068; cv=none;
 d=google.com; s=arc-20240605;
 b=RgVrTVyWGHvqljk9EnXBsABNOhIANaOSHE6N4rr0caGGv24DfQLWq+tuxbPmJcguR8
 VVuObuiI2m24NXGF9QjhI6+jD+SeQZ2jQavbH9zhvSJyOuyNqYbaVF/HclGylNgmcrPG
 SB+9Md99q/nI93i3m6SzWIP0MXQQ8ljPC90j5A53goa1VTpO/m4RpLHvHN43ZFQQ9wN6
 4NTTdHeF606C9mx93vRRC5J21iohwoRae+QRk0Qr+u/mKltZ/QEb5JBhSpumiqLEGPMz
 XQQGHe3L0XwJl5RqzG+pzUKsTaJ1BPNKPuxcrCyPfZxZ0p1umyocdlUB+oi+y5W27HCl
 o5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9us+64m1a7ZVGL0jYvGA7XUZkiZjTmrcwNXNZCiR6CY=;
 fh=yamdC3/PPc+0MFt+AHbabBa11fylHWJWIW5k6ZaqpcU=;
 b=DxaNNeSVATXaV5E+D/mfVl5J6GsNK5fbLZU0uUP+KTpl/z8cH6MRkxcgUPNuHLITKu
 CiQRCxMYgV3Q5xkApNghyjChtJ3Hm52eWqmNd6CeCtCN7FcbwTUF4oiSYV667ZgmuwsH
 c5Q43rPMq4lbDRmpxEpMQH+nEvvuQVkKCE3Z+2iDXeFUZqovEQNoiMsJ6nFq6kZHv4eR
 XntW5lpZPps45/X5YS5lhQOmLKK5N7nI7uIoqjW44OMNVh/CIEHt9jjLNdqtiQmGpJOP
 OzanPLwTS5sytAhE/9nvqyrX+1DGAiTbgUPub6o7qfYGEAaIKIkP3Nzg+uEp5srFCneT
 emQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774802068; x=1775406868; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9us+64m1a7ZVGL0jYvGA7XUZkiZjTmrcwNXNZCiR6CY=;
 b=ItQQDy+R1Z5s7a6GT643YhOK/dIc6Bg3d8udQXKFor1J8zagvKkjfk0o1dmQzY/dQT
 4K7G2WNUI35Nwrsrbc7jMRyti96F9RC+3VBnaQZylQJ8ZUduyyLK1qbjWiG00x1KxHCK
 H2XaP9sQur0ILqKzFFPn51lQSakAyT/uujwEnV0e+uT8XCUX0S8LCjouq0C0aedOtOMX
 NbxBoytQWwb0tXBkytjwBBvzpEMP3KeaN0kJTST2pBhBcbnwOEesE0MOXOahzwg8xY8O
 +bbc9XSssKfKDhKQLcXgrjMQqKk/LoGHsKSrZIbxHrAz5WY0Oh1BRtKhHAE5Y1P9N5Pw
 2ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774802068; x=1775406868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9us+64m1a7ZVGL0jYvGA7XUZkiZjTmrcwNXNZCiR6CY=;
 b=T3Xcofwo7m+9JayMe/So63sz6jHJTkPIp+CPnAnH7NtcKZw9D8fYhrnsflsQ3wn/jV
 tSvHhUep55fSFPhHfocwHfxIqdd+3WOzxBkbTJmnrb+09ZI2+Pp8IavLvsH1TTgiD3dH
 5caikvcM9lRO++ahKxCWzfno8utTFvKey0eNR91xiDMrzGdWU1gFyNE8DPakltqCjxjw
 8O/XxkU5yNuBYl54L/5Ly9Y5PQLUvXOHqM98yrGnhY0V+uI25B8sZ5dMc5CnQ2RJUbR2
 WiCODPmhdV6yR+ALaGQHMbCUybd8Eon+GaVqHASNvRPe/jaRY5ca5x41nokFR98vDrRk
 J8ZA==
X-Gm-Message-State: AOJu0YyqYN2J22yDkc+eFq2B3BBRviFHA0Z+paRDXSAMmFxqHogg4Q+T
 va9iHgNo7XAXrUd11w0geCmSsSgRl8vCbENvyrYdwk35lNlxaijZtA3iu3XL/NRF6ADOk9vNfZj
 lKIxosgkWeR1M1+sY/dgV2YYCPC4J5g==
X-Gm-Gg: ATEYQzy5xx2rrMo5QhXyPIEVCrGL+KSmql/hLUGcQt1X2RbY2OPHbEY65nm5e9YDU2b
 oJMky9BIXJvHQ/IfHGu5HTFy3KuSyNwPpT75uN0bKsfUfzIZmBiWNbkeinPwoQz5PGjD2fNiQDJ
 rZ2WORJxv/hTluxweHKROHvzsOhPORGFxny91aL6L/ZI0uWUeltMtsdOSqwBDmqx+etzRugTllL
 aKpjw3WoDKgDWKViEow12d1iepBdkwX6DN1A6/F6/2UFcy0ZVp+yTwfhtluUA72Golu9QUOOSlO
 bKurrWvkzJnjAUykKQ+VmomWI81FZEuIAiMkEfRT
X-Received: by 2002:a05:6402:370f:b0:665:638d:75c1 with SMTP id
 4fb4d7f45d1cf-66b2836522dmr5095761a12.3.1774802067883; Sun, 29 Mar 2026
 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
 <CAJ9xWrKwPgM-jeUJB5vMaU0u-wWp=JVCQ_38u-25J6nc3+WZzg@mail.gmail.com>
 <CAJ9xWrJpvse5i3vSqNRXRarx7DEFSbATD_NG4d7E+5Mza1gA-A@mail.gmail.com>
In-Reply-To: <CAJ9xWrJpvse5i3vSqNRXRarx7DEFSbATD_NG4d7E+5Mza1gA-A@mail.gmail.com>
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Sun, 29 Mar 2026 13:34:16 -0300
X-Gm-Features: AQROBzC7HDmj-InuIagEcVVZUti3JtF6z2CXZ34Gyknkc-fZ8luQ82VA5yppxkY
Message-ID: <CAJ9xWrL79F7bt+=Nbohp-pwDaOOWE8Cazah7kvtOdk5mutAG3Q@mail.gmail.com>
Subject: Re: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com
Content-Type: multipart/alternative; boundary="000000000000cd8cbb064e2c4ed9"
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

--000000000000cd8cbb064e2c4ed9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99d like to provide a final update on this regression affecting AMD=
 Radeon
R9 380 (Tonga), which I bisected earlier between Linux 6.3 (good) and 6.4
(bad).

After further investigation, I was able to isolate the issue more precisely
and identify a reliable workaround.

=F0=9F=94=8D Summary:

After suspend/resume under X11:

   -

   HDMI monitor is physically connected and EDID is valid
   -

   Kernel (DRM) correctly detects the HDMI connector
   -

   However, X11 ends up with an inconsistent display state

Observed behavior:

   -

   HDMI-A-0 is active at correct resolution (1920x1080)
   -

   A phantom output (DVI-D-1) appears as connected
   -

   DVI-D-1 is incorrectly set as primary at 640x480
   -

   Desktop becomes corrupted (missing panels, apps failing, incorrect
   layout)

xrandr example after resume:

HDMI-A-0 connected 1920x1080+0+0
DVI-D-1 connected primary 640x480+1920+116

=F0=9F=A7=A0 Key finding:

The issue is not EDID or link training. EDID is readable and valid.

This appears to be a failure in atomic modeset / connector-to-CRTC mapping
during resume, leading to an incorrect fallback output being selected as
primary.

=F0=9F=92=A1 Workaround (100% reproducible fix):

Running the following immediately restores the system:

xrandr --output DVI-D-1 --off
xrandr --output HDMI-A-0 --primary --mode 1920x1080

This strongly suggests that the correct state exists but is not applied
automatically after resume.

=E2=9A=99=EF=B8=8F Additional observations:

   -

   Wayland does not exhibit the same failure (likely due to dynamic state
   handling)
   -

   Issue reproducible only on 6.4+
   -

   s2idle reduces severity but does not fix the issue
   -

   amdgpu.dc=3D0 makes the system fully unusable after resume

=F0=9F=A7=AA Bisect:

First bad commit:
b3c98052d46948a8d65d2778c7f306ff38366aac (KVM merge)

This likely indicates an indirect trigger (timing/order change during
resume), not a direct amdgpu change.

=F0=9F=93=8E Logs and details available upon request.

=F0=9F=99=8F I=E2=80=99m happy to test patches or provide additional debug =
information.

Thanks for your time and for maintaining amdgpu.

Best regards,
Danilo

Em dom., 29 de mar. de 2026 =C3=A0s 10:35, Danilo Machado <
danilomachado2002@gmail.com> escreveu:

> Also reported on GitLab:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5123
>
> Em dom., 29 de mar. de 2026 =C3=A0s 09:47, Danilo Machado <
> danilomachado2002@gmail.com> escreveu:
>
>> Additional testing:
>>
>> I tested with amdgpu.dc=3D0 to disable Display Core.
>>
>> Result:
>> - system becomes completely unresponsive after resume
>> - black screen, no input response
>>
>> This suggests the issue is not limited to Display Core (DC),
>> but likely affects the core GPU resume path.
>>
>> With DC enabled:
>> - partial recovery (corrupted display, EDID failure)
>>
>> With DC disabled:
>> - complete failure
>>
>> This reinforces that the regression is deeper in the amdgpu resume
>> sequence.
>>
>> Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado <
>> danilomachado2002@gmail.com> escreveu:
>>
>>> Additional data (resume failure analysis)
>>>
>>> Hardware:
>>> - GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>>> - CPU: AMD Ryzen 5 5500
>>> - RAM: 16 GB
>>> - Display: HDMI
>>>
>>> Software:
>>> - Kernel: 6.8.0-106-generic
>>> - Driver: amdgpu
>>> - Display server: X11 (issue reproducible), Wayland (no hard failure)
>>>
>>> ---
>>>
>>> Summary:
>>>
>>> After suspend/resume, HDMI output is not restored and the system may
>>> freeze under X11.
>>>
>>> The issue is reproducible and was not present in Linux 6.3.
>>>
>>> ---
>>>
>>> Key observation:
>>>
>>> During resume, the driver fails to read EDID:
>>>
>>>     amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>>>
>>> This appears to explain why HDMI output is not restored.
>>>
>>> ---
>>>
>>> Relevant DRM / AMDGPU log excerpt:
>>>
>>> [drm] Display Core v3.2.266 initialized on DCE 10.0
>>> amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>>> [drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0
>>>
>>> ---
>>>
>>> Analysis:
>>>
>>> - The failure occurs during display reinitialization after resume
>>> - EDID read failure prevents proper HDMI modeset
>>> - This aligns with the observed "no signal" condition
>>>
>>> Behavior differences:
>>>
>>> - deep sleep:
>>>   - full GPU/display reinitialization
>>>   - leads to EDID failure and system instability
>>>
>>> - s2idle:
>>>   - partial resume
>>>   - avoids full lockup but display may still be inconsistent
>>>
>>> This suggests the issue is in the display resume path, possibly
>>> involving:
>>>
>>> - DC state restore
>>> - HDMI link training
>>> - DDC/EDID communication
>>> - atomic modeset reconstruction
>>>
>>> ---
>>>
>>> Conclusion:
>>>
>>> This is likely a regression in the AMDGPU display resume path, where
>>> EDID read fails after resume, preventing HDMI output from being restore=
d.
>>>
>>> ---
>>>
>>> Additional notes:
>>>
>>> This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with th=
e
>>> transition point identified as a KVM merge commit. While not directly
>>> related to AMDGPU, it may have indirectly exposed this issue via
>>> timing/order changes.
>>>
>>> ---
>>>
>>> If needed, I can provide:
>>>
>>> - full journalctl logs
>>> - full bisect log
>>> - additional testing (kernel params, debug options)
>>> ------------------------------
>>> *De:* Danilo Machado <danilomachado2002@hotmail.com>
>>> *Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
>>> *Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Alex Deucher <alexdeucher@gmail.com>;
>>> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
>>> *Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
>>> suspend/resume
>>>
>>>
>>> Hi all,
>>>
>>> Thanks again for your feedback.
>>>
>>> I took a closer look at the bisect results and system behavior, and I=
=E2=80=99d
>>> like to provide a more complete and consolidated report.
>>> ------------------------------
>>>
>>> Hardware:
>>>
>>>    -
>>>
>>>    GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>>>    -
>>>
>>>    CPU: AMD Ryzen 5 5500
>>>    -
>>>
>>>    RAM: 16 GB
>>>    -
>>>
>>>    Display: HDMI
>>>
>>> Software:
>>>
>>>    -
>>>
>>>    Driver: amdgpu
>>>    -
>>>
>>>    Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)
>>>
>>> ------------------------------
>>>
>>> Summary:
>>>
>>> This is a reproducible suspend/resume regression affecting HDMI output.
>>>
>>>    -
>>>
>>>    Linux 6.3 =E2=86=92 working correctly
>>>    -
>>>
>>>    Linux 6.4+ =E2=86=92 regression present
>>>
>>> ------------------------------
>>>
>>> Behavior:
>>>
>>> After suspend/resume:
>>>
>>>    -
>>>
>>>    HDMI output does not recover ("no signal")
>>>    -
>>>
>>>    System may freeze under X11
>>>    -
>>>
>>>    Wayland does not show the same hard failure
>>>
>>> Additionally:
>>>
>>>    -
>>>
>>>    Using "deep" sleep:
>>>    -
>>>
>>>       full system lockup after resume
>>>       -
>>>
>>>    Using "s2idle":
>>>    -
>>>
>>>       system resumes without hard lock
>>>       -
>>>
>>>       however, graphical session may return in a partially broken state
>>>
>>> ------------------------------
>>>
>>> Bisect result:
>>>
>>> A full git bisect was performed between Linux 6.3 and 6.4.
>>>
>>> First bad commit:
>>> b3c98052d46948a8d65d2778c7f306ff38366aac
>>> ("Merge tag 'kvm-x86-vmx-6.4'")
>>>
>>> All intermediate commits in that range were consistently tested as GOOD=
.
>>> ------------------------------
>>>
>>> Analysis:
>>>
>>> Although the bisected commit is in KVM and unlikely to directly affect
>>> AMDGPU, the transition point is consistent and reproducible.
>>>
>>> This suggests the regression may be indirectly triggered (e.g. timing o=
r
>>> ordering changes during resume), rather than caused directly by that me=
rge.
>>>
>>> Based on observed behavior, this appears related to the display resume
>>> path, possibly involving:
>>>
>>>    -
>>>
>>>    DC state restore after resume
>>>    -
>>>
>>>    HDMI link training
>>>    -
>>>
>>>    EDID re-read
>>>    -
>>>
>>>    atomic modeset state reconstruction
>>>
>>> The difference between "deep" and "s2idle" also suggests a failure
>>> during full GPU/display reinitialization.
>>> ------------------------------
>>>
>>> Conclusion:
>>>
>>> This appears to be a latent issue exposed by changes introduced during
>>> the 6.4 merge window, rather than a direct regression in the bisected
>>> commit itself.
>>> ------------------------------
>>>
>>> If helpful, I can assist further by:
>>>
>>>    -
>>>
>>>    providing full bisect logs
>>>    -
>>>
>>>    capturing detailed dmesg/journalctl before and after resume
>>>    -
>>>
>>>    testing patches or debug options
>>>    -
>>>
>>>    narrowing the range further if needed
>>>
>>> I really appreciate the work on AMDGPU and would be glad to help within
>>> my limits to investigate this further.
>>>
>>> Thanks again for your time.
>>>
>>> Best regards,
>>> Danilo
>>> Note: I had some email client configuration issues earlier, which may
>>> have caused duplicate messages or formatting problems. These have now b=
een
>>> resolved =E2=80=94 apologies for any inconvenience.
>>>
>>>
>>
>> --
>> *Danilo Machado*
>>
>
>
> --
> *Danilo Machado*
>


--=20
*Danilo Machado*

--000000000000cd8cbb064e2c4ed9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif"><p>Hi all,</p><p>I=E2=80=99d like to provide a final update on =
this regression affecting AMD Radeon R9 380 (Tonga), which I bisected earli=
er between Linux 6.3 (good) and 6.4 (bad).</p><p>After further investigatio=
n, I was able to isolate the issue more precisely and identify a reliable w=
orkaround.</p><p>=F0=9F=94=8D Summary:</p><p>After suspend/resume under X11=
:</p><ul><li><p>HDMI monitor is physically connected and EDID is valid</p><=
/li><li><p>Kernel (DRM) correctly detects the HDMI connector</p></li><li><p=
>However, X11 ends up with an inconsistent display state</p></li></ul><p>Ob=
served behavior:</p><ul><li><p>HDMI-A-0 is active at correct resolution (19=
20x1080)</p></li><li><p>A phantom output (DVI-D-1) appears as connected</p>=
</li><li><p>DVI-D-1 is incorrectly set as primary at 640x480</p></li><li><p=
>Desktop becomes corrupted (missing panels, apps failing, incorrect layout)=
</p></li></ul><p>xrandr example after resume:</p><p>HDMI-A-0 connected 1920=
x1080+0+0<br>DVI-D-1 connected primary 640x480+1920+116</p><p>=F0=9F=A7=A0 =
Key finding:</p><p>The issue is not EDID or link training. EDID is readable=
 and valid.</p><p>This appears to be a failure in atomic modeset / connecto=
r-to-CRTC mapping during resume, leading to an incorrect fallback output be=
ing selected as primary.</p><p>=F0=9F=92=A1 Workaround (100% reproducible f=
ix):</p><p>Running the following immediately restores the system:</p><p>xra=
ndr --output DVI-D-1 --off<br>xrandr --output HDMI-A-0 --primary --mode 192=
0x1080</p><p>This strongly suggests that the correct state exists but is no=
t applied automatically after resume.</p><p>=E2=9A=99=EF=B8=8F Additional o=
bservations:</p><ul><li><p>Wayland does not exhibit the same failure (likel=
y due to dynamic state handling)</p></li><li><p>Issue reproducible only on =
6.4+</p></li><li><p>s2idle reduces severity but does not fix the issue</p><=
/li><li><p>amdgpu.dc=3D0 makes the system fully unusable after resume</p></=
li></ul><p>=F0=9F=A7=AA Bisect:</p><p>First bad commit:<br>b3c98052d46948a8=
d65d2778c7f306ff38366aac (KVM merge)</p><p>This likely indicates an indirec=
t trigger (timing/order change during resume), not a direct amdgpu change.<=
/p><p>=F0=9F=93=8E Logs and details available upon request.</p><p>=F0=9F=99=
=8F I=E2=80=99m happy to test patches or provide additional debug informati=
on.</p><p>Thanks for your time and for maintaining amdgpu.</p><p>Best regar=
ds,<br>Danilo</p></div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">Em dom., 29 de mar. de 2026 =
=C3=A0s 10:35, Danilo Machado &lt;<a href=3D"mailto:danilomachado2002@gmail=
.com">danilomachado2002@gmail.com</a>&gt; escreveu:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_de=
fault" style=3D"font-family:verdana,sans-serif">Also reported on GitLab:<br=
><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_items/5123" targe=
t=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-/work_items/5123</a></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">Em dom., 29 de mar. de 2026 =C3=A0s 09:47, Danilo Machado &lt;<a href=
=3D"mailto:danilomachado2002@gmail.com" target=3D"_blank">danilomachado2002=
@gmail.com</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-fa=
mily:verdana,sans-serif">Additional testing:<br><br>I tested with amdgpu.dc=
=3D0 to disable Display Core.<br><br>Result:<br>- system becomes completely=
 unresponsive after resume<br>- black screen, no input response<br><br>This=
 suggests the issue is not limited to Display Core (DC),<br>but likely affe=
cts the core GPU resume path.<br><br>With DC enabled:<br>- partial recovery=
 (corrupted display, EDID failure)<br><br>With DC disabled:<br>- complete f=
ailure<br><br>This reinforces that the regression is deeper in the amdgpu r=
esume sequence.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Mach=
ado &lt;<a href=3D"mailto:danilomachado2002@gmail.com" target=3D"_blank">da=
nilomachado2002@gmail.com</a>&gt; escreveu:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:Cali=
bri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">A=
dditional data (resume failure analysis)</div><div style=3D"font-family:Cal=
ibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
<br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)">Hardware:</div><div style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">- GPU: AMD Radeon R9 380 (Tonga, GCN 3)</div><div style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">- CPU: AMD Ryzen 5 5500</div><div style=3D"font-family:Calibri,Helve=
tica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- RAM: 16 =
GB</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">- Display: HDMI</div><div style=3D"fon=
t-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:=
rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Software:</div><div styl=
e=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">- Kernel: 6.8.0-106-generic</div><div style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">- Driver: amdgpu</div><div style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- Display server:=
 X11 (issue reproducible), Wayland (no hard failure)</div><div style=3D"fon=
t-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:=
rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"f=
ont-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Summary:</div><div sty=
le=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,=
sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">After suspend/r=
esume, HDMI output is not restored and the system may freeze under X11.</di=
v><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,=
Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">The i=
ssue is reproducible and was not present in Linux 6.3.</div><div style=3D"f=
ont-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D=
"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Key observation:</di=
v><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,=
Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Durin=
g resume, the driver fails to read EDID:</div><div style=3D"font-family:Cal=
ibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
<br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 =C2=A0 amdgpu 0000:01:00.0: [=
drm] *ERROR* No EDID read.</div><div style=3D"font-family:Calibri,Helvetica=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div=
 style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">This appears to explain why HDMI output is not res=
tored.</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Em=
ojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">---</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">Relevant DRM / AMDGPU log excerpt:</div><div style=3D"font-family:Ca=
libri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">[drm] Display Core v3.2.266 initial=
ized on DCE 10.0</div><div style=3D"font-family:Calibri,Helvetica,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">amdgpu 0000:01:00.0: [dr=
m] *ERROR* No EDID read.</div><div style=3D"font-family:Calibri,Helvetica,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">[drm] Initialize=
d amdgpu 3.57.0 20150101 for 0000:01:00.0</div><div style=3D"font-family:Ca=
libri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-family:=
Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,E=
mojiFont;font-size:12pt;color:rgb(0,0,0)">Analysis:</div><div style=3D"font=
-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- The failure occurs duri=
ng display reinitialization after resume</div><div style=3D"font-family:Cal=
ibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
- EDID read failure prevents proper HDMI modeset</div><div style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">- This aligns with the observed &quot;no signal&quot; condition</di=
v><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,=
Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Behav=
ior differences:</div><div style=3D"font-family:Calibri,Helvetica,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"=
font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;col=
or:rgb(0,0,0)">- deep sleep:</div><div style=3D"font-family:Calibri,Helveti=
ca,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - ful=
l GPU/display reinitialization</div><div style=3D"font-family:Calibri,Helve=
tica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - l=
eads to EDID failure and system instability</div><div style=3D"font-family:=
Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,E=
mojiFont;font-size:12pt;color:rgb(0,0,0)">- s2idle:</div><div style=3D"font=
-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">=C2=A0 - partial resume</div><div style=3D"font-family:Calibri,H=
elvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0=
 - avoids full lockup but display may still be inconsistent</div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This suggests the=
 issue is in the display resume path, possibly involving:</div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DC state restor=
e</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFo=
nt;font-size:12pt;color:rgb(0,0,0)">- HDMI link training</div><div style=3D=
"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">- DDC/EDID communication</div><div style=3D"font-family:Cal=
ibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
- atomic modeset reconstruction</div><div style=3D"font-family:Calibri,Helv=
etica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div=
><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fon=
t-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-family:Calibri,He=
lvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></d=
iv><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;f=
ont-size:12pt;color:rgb(0,0,0)">Conclusion:</div><div style=3D"font-family:=
Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,E=
mojiFont;font-size:12pt;color:rgb(0,0,0)">This
 is likely a regression in the AMDGPU display resume path, where EDID=20
read fails after resume, preventing HDMI output from being restored.</div><=
div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Hel=
vetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div=
><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fon=
t-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,H=
elvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Additi=
onal notes:</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-=
family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">This
 issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the=20
transition point identified as a KVM merge commit. While not directly=20
related to AMDGPU, it may have indirectly exposed this issue via=20
timing/order changes.</div><div style=3D"font-family:Calibri,Helvetica,sans=
-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div styl=
e=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">---</div><div style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div st=
yle=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:1=
2pt;color:rgb(0,0,0)">If needed, I can provide:</div><div style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- full journalctl logs</div><=
div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)">- full bisect log</div><div style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">- additional testing (kernel params, debug options)</div><div id=3D"m_=
8254164770234675366m_4916195300917595998m_3557920322715242118m_307560144301=
3613040gmail-x_appendonsend"></div><hr style=3D"display:inline-block;width:=
98%"><div id=3D"m_8254164770234675366m_4916195300917595998m_355792032271524=
2118m_3075601443013613040gmail-x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>De:</b> D=
anilo Machado &lt;<a href=3D"mailto:danilomachado2002@hotmail.com" target=
=3D"_blank">danilomachado2002@hotmail.com</a>&gt;<br><b>Enviado:</b> quinta=
-feira, 26 de mar=C3=A7o de 2026 20:38<br><b>Para:</b> <a href=3D"mailto:am=
d-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.or=
g</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank=
">amd-gfx@lists.freedesktop.org</a>&gt;<br><b>Cc:</b> Alex Deucher &lt;<a h=
ref=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.co=
m</a>&gt;; <a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_bl=
ank">dri-devel@lists.freedesktop.org</a> &lt;<a href=3D"mailto:dri-devel@li=
sts.freedesktop.org" target=3D"_blank">dri-devel@lists.freedesktop.org</a>&=
gt;<br><b>Assunto:</b> [REGRESSION][bisected] amdgpu/tonga: HDMI no signal =
after suspend/resume</font> <div aria-hidden=3D"true">=C2=A0</div></div><di=
v dir=3D"ltr"><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"=
font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;col=
or:rgb(0,0,0)">Hi all,</span></p><p style=3D"margin-top:1em;margin-bottom:1=
em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont=
;font-size:12pt;color:rgb(0,0,0)">Thanks again for your feedback.</span></p=
><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:C=
alibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)=
">I took a closer look at the bisect results and system behavior, and I=E2=
=80=99d like to provide a more complete and consolidated report.</span></p>=
<hr><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">Hardware:</span></p><ul><li style=3D"font-family:Calibri,Helvetica,san=
s-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"=
margin-top:1em;margin-bottom:1em">GPU: AMD Radeon R9 380 (Tonga, GCN 3)</p>=
</li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;c=
olor:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bo=
ttom:1em">CPU: AMD Ryzen 5 5500</p></li><li style=3D"font-family:Calibri,He=
lvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation=
" style=3D"margin-top:1em;margin-bottom:1em">RAM: 16 GB</p></li><li style=
=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0=
)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Disp=
lay: HDMI</p></li></ul><p style=3D"margin-top:1em;margin-bottom:1em"><span =
style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size=
:12pt;color:rgb(0,0,0)">Software:</span></p><ul><li style=3D"font-family:Ca=
libri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"pres=
entation" style=3D"margin-top:1em;margin-bottom:1em">Driver: amdgpu</p></li=
><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom=
:1em">Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)</p></li></ul><hr>=
<p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>Summary:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span sty=
le=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)">This is a reproducible suspend/resume regression affec=
ting HDMI output.</span></p><ul><li style=3D"font-family:Calibri,Helvetica,=
sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=
=3D"margin-top:1em;margin-bottom:1em">Linux 6.3 =E2=86=92 working correctly=
</p></li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12=
pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margi=
n-bottom:1em">Linux 6.4+ =E2=86=92 regression present</p></li></ul><hr><p s=
tyle=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Beh=
avior:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">After suspend/resume:</span></p><ul><li style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=
=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">HDMI output do=
es not recover (&quot;no signal&quot;)</p></li><li style=3D"font-family:Cal=
ibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"prese=
ntation" style=3D"margin-top:1em;margin-bottom:1em">System may freeze under=
 X11</p></li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-siz=
e:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;m=
argin-bottom:1em">Wayland does not show the same hard failure</p></li></ul>=
<p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Ca=
libri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>Additionally:</span></p><ul><li style=3D"font-family:Calibri,Helvetica,san=
s-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"=
margin-top:1em;margin-bottom:1em">Using &quot;deep&quot; sleep:</p></li><ul=
><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom=
:1em">full system lockup after resume</p></li></ul><li style=3D"font-family=
:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"p=
resentation" style=3D"margin-top:1em;margin-bottom:1em">Using &quot;s2idle&=
quot;:</p></li><ul><li style=3D"font-family:Calibri,Helvetica,sans-serif;fo=
nt-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top=
:1em;margin-bottom:1em">system resumes without hard lock</p></li><li style=
=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0=
)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">howe=
ver, graphical session may return in a partially broken state</p></li></ul>=
</ul><hr><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-=
family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">Bisect result:</span></p><p style=3D"margin-top:1em;margin-bottom=
:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFo=
nt;font-size:12pt;color:rgb(0,0,0)">A full git bisect was performed between=
 Linux 6.3 and 6.4.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"=
><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)">First bad commit:<br>b3c98052d46948a8d65d277=
8c7f306ff38366aac<br>(&quot;Merge tag &#39;kvm-x86-vmx-6.4&#39;&quot;)</spa=
n></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">All intermediate commits in that range were consistently tested as G=
OOD.</span></p><hr><p style=3D"margin-top:1em;margin-bottom:1em"><span styl=
e=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">Analysis:</span></p><p style=3D"margin-top:1em;margin-b=
ottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Em=
ojiFont;font-size:12pt;color:rgb(0,0,0)">Although
 the bisected commit is in KVM and unlikely to directly affect AMDGPU,=20
the transition point is consistent and reproducible.</span></p><p style=3D"=
margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvet=
ica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This
 suggests the regression may be indirectly triggered (e.g. timing or=20
ordering changes during resume), rather than caused directly by that=20
merge.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">Based on observed behavior, this appears related to the =
display resume path, possibly involving:</span></p><ul><li style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=
=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">DC state resto=
re after resume</p></li><li style=3D"font-family:Calibri,Helvetica,sans-ser=
if;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margi=
n-top:1em;margin-bottom:1em">HDMI link training</p></li><li style=3D"font-f=
amily:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=
=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">EDID re-read</=
p></li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-=
bottom:1em">atomic modeset state reconstruction</p></li></ul><p style=3D"ma=
rgin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetic=
a,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">The differenc=
e between &quot;deep&quot; and &quot;s2idle&quot; also suggests a failure d=
uring full GPU/display reinitialization.</span></p><hr><p style=3D"margin-t=
op:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans=
-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Conclusion:</span><=
/p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family=
:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)">This
 appears to be a latent issue exposed by changes introduced during the=20
6.4 merge window, rather than a direct regression in the bisected commit
 itself.</span></p><hr><p style=3D"margin-top:1em;margin-bottom:1em"><span =
style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size=
:12pt;color:rgb(0,0,0)">If helpful, I can assist further by:</span></p><ul>=
<li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:=
rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:=
1em">providing full bisect logs</p></li><li style=3D"font-family:Calibri,He=
lvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation=
" style=3D"margin-top:1em;margin-bottom:1em">capturing detailed dmesg/journ=
alctl before and after resume</p></li><li style=3D"font-family:Calibri,Helv=
etica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" =
style=3D"margin-top:1em;margin-bottom:1em">testing patches or debug options=
</p></li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12=
pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margi=
n-bottom:1em">narrowing the range further if needed</p></li></ul><p style=
=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,He=
lvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I reall=
y appreciate the work on AMDGPU and would be glad to help within my limits =
to investigate this further.</span></p><p style=3D"margin-top:1em;margin-bo=
ttom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">Thanks again for your time.</span><=
/p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family=
:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)">Best regards,<br>Danilo</span></p><div style=3D"font-family:Calibri,Hel=
vetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Note:
 I had some email client configuration issues earlier, which may have=20
caused duplicate messages or formatting problems. These have now been=20
resolved =E2=80=94 apologies for any inconvenience.</div></div><br></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">Danilo Machad=
o</i></div></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">Danilo Machad=
o</i></div></div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">D=
anilo Machado</i></div></div>

--000000000000cd8cbb064e2c4ed9--
