Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E19FB3CE0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C5310E509;
	Mon, 30 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8R9002g";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51AE10E4AC
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 13:35:51 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso685158a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 06:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774791350; cv=none;
 d=google.com; s=arc-20240605;
 b=QDxCc3WpywqTWtmPEtzllmqAMwQ4Vre2X7KvhaozUH1GqSEFNJdUO4nxbcUKxZ8voW
 BqSMZ8aecObfoK24QqscgnOYzdu3x1lW9dQ05oPuqpgbH+hXM7TLSxwrpmFg1RYZx6bl
 U5W7QBj0q5DvCBa++1wYQ49jsL7KsV4hdknkDDmbt+GTbsHF/AL21s1uCQOSi6tpT1ll
 WTJBefMyJl6cQ+VJgOJtU1iCIZvTdZcn+kk0KH7PKGf/tXZH09QtzmlXm15FuAU1Tt5+
 QasVA5OFO9RlfFOQdp3BiRdM7kso0vB2pY06GCECT1z4xUKaLI4ZlYaguvspjBFk3ky7
 CfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KBimNOyyWmflm/yJrCCqVjAKUcR9XeVxYXDj2sfNK0w=;
 fh=yamdC3/PPc+0MFt+AHbabBa11fylHWJWIW5k6ZaqpcU=;
 b=advYCCDI1cfkGjpf7WMjQIDAV8QPLZGbUNSVCis1ynuUAaV6gMe0W4acFbqG1i5gZN
 eNe1JLmVnsj/dcI1cR5ydEeVdo3s7kMuMxHiJDQCFYFhJWhCHH8DBDQKG6u4S2lqPNsj
 bHjCmVE7W8+qaoSuYCGvo172xmZqhoDIDkdg4CNR/6A5KE5HW463dTxB+McPR1KAYZda
 52kTpHEdvOJOO1j29VyUloRIgwgrGtG9C8BseXYNXGBCfkzq8bQhZzj7mlKEIVNePgwD
 a7mnqg9zgD5u4bztHWg7RPb4InjmzugYMUDBJqjwz5IcbuHvZP/Vkb3XYtYKRow3RdRA
 UkZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774791350; x=1775396150; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KBimNOyyWmflm/yJrCCqVjAKUcR9XeVxYXDj2sfNK0w=;
 b=S8R9002gUvwU6N6I7xvenLN8nOMu1gHyuPBgU4CD0uGiLVBFUxBW/Up/npNEFv18dY
 g2ziUzRExRjPEniC7AHGmG2BKQUyKDmzTL9S8sQhfj+RKTiDF7dRgrNf0KWXcP2e0g3Q
 MFcteV0VGGIdTHLXosSRqqTELXgJ2xGscINscpZbf0hDnUHREmSMW1RZnpL0dWr6+V2j
 HxqFJN20Ew5OFLoSH+sKDQpyvQfdfpQd+KzyJefK/oex8qqrSt9+6oI3gYJ9/2K9yj+z
 DGVXzNxL/gq2TOnZQt/djySAHsbVs9KbvwD2/ir/GcJHuBhHMJ0FdR0YZ9Tf/kyqPjGO
 ZLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774791350; x=1775396150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBimNOyyWmflm/yJrCCqVjAKUcR9XeVxYXDj2sfNK0w=;
 b=NPw/XOAkfY/6hfCQL7bYC4lCOXAldSI6Ny/K3idQ74cptEsSq1r3HOascn+CRBbANf
 96/BrrkyfuyiBd5zk7ZttDLonu36gw0Pa5MhhdSJyRw/rwo/iKPavZ9zIDlwJoQYkilz
 Fh09OwupFvm4AmFmxAN9z6oe7tmjx5SBAqXI0W+c5lyzHILhXOmLn7Sbv0hPEs3LJ3CS
 I6tupgoxV0gnmdtoSqFLbCpRMGqonCGlbLjE8ZZMyqwDJpjoFcM6lJO+zzsiMXQHn8tp
 0wRErwIAJ2+NwjDptk9g0WZYLSaOcEmXxx4NmhUqkT3abkB3drh6FPnKnH7+5nRwk4/1
 1Kbw==
X-Gm-Message-State: AOJu0YzKvI7GavoVPheJjmSA4WVqLTN4+/BTo8yK8gporjCjNgdlEFcm
 5KmmSqitigvvL59mIC7pAzPfsZI1vX0pJXxr+ROfzuEfPZndpw1RJv08zDvsFjMKWIXcvL0u4Nx
 T/xEpsqccH7JcmBh19FWvfLbjjHL9qAof
X-Gm-Gg: ATEYQzxuSwL270fZBCXlyPCi6uE2/Nv70J3W5GWx6r07i4Zx+whxbuEoF/esFY58fY7
 nitwxsLW1DYIOxYaMVJ5ljuoGe6EeV8HbYKm2h4qDx11U+3JBkL42g67ZzabhxxKrNGO2JEvb5D
 bfGBkpfHTkfwIEhmdmJpEk+xg18at6JRsPAifU3WOHj46AlrUpjlqV0xqMSNBxTGLgWFhFPwMzw
 bXcZCVgLzQYIoMZX97FIexDcY8toDDsaD84IntuZpDDGdcojqQgRd1sot0zFEWDPugYjxU7iezC
 1SJOScL9Gh7t9yO74FL8OU+Fy6HFiNLSIBgfeSYd
X-Received: by 2002:a05:6402:370b:b0:662:e479:e883 with SMTP id
 4fb4d7f45d1cf-66b2836b29amr5041859a12.5.1774791349857; Sun, 29 Mar 2026
 06:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
 <CAJ9xWrKwPgM-jeUJB5vMaU0u-wWp=JVCQ_38u-25J6nc3+WZzg@mail.gmail.com>
In-Reply-To: <CAJ9xWrKwPgM-jeUJB5vMaU0u-wWp=JVCQ_38u-25J6nc3+WZzg@mail.gmail.com>
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Sun, 29 Mar 2026 10:35:38 -0300
X-Gm-Features: AQROBzC2Z4evVHUdLZl78n3lxs1o3dr_2CwGixk6q6DQn9KwK4jSAn2L8C10jQ4
Message-ID: <CAJ9xWrJpvse5i3vSqNRXRarx7DEFSbATD_NG4d7E+5Mza1gA-A@mail.gmail.com>
Subject: Re: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com
Content-Type: multipart/alternative; boundary="000000000000f57161064e29cf1e"
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

--000000000000f57161064e29cf1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also reported on GitLab:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Em dom., 29 de mar. de 2026 =C3=A0s 09:47, Danilo Machado <
danilomachado2002@gmail.com> escreveu:

> Additional testing:
>
> I tested with amdgpu.dc=3D0 to disable Display Core.
>
> Result:
> - system becomes completely unresponsive after resume
> - black screen, no input response
>
> This suggests the issue is not limited to Display Core (DC),
> but likely affects the core GPU resume path.
>
> With DC enabled:
> - partial recovery (corrupted display, EDID failure)
>
> With DC disabled:
> - complete failure
>
> This reinforces that the regression is deeper in the amdgpu resume
> sequence.
>
> Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado <
> danilomachado2002@gmail.com> escreveu:
>
>> Additional data (resume failure analysis)
>>
>> Hardware:
>> - GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>> - CPU: AMD Ryzen 5 5500
>> - RAM: 16 GB
>> - Display: HDMI
>>
>> Software:
>> - Kernel: 6.8.0-106-generic
>> - Driver: amdgpu
>> - Display server: X11 (issue reproducible), Wayland (no hard failure)
>>
>> ---
>>
>> Summary:
>>
>> After suspend/resume, HDMI output is not restored and the system may
>> freeze under X11.
>>
>> The issue is reproducible and was not present in Linux 6.3.
>>
>> ---
>>
>> Key observation:
>>
>> During resume, the driver fails to read EDID:
>>
>>     amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>>
>> This appears to explain why HDMI output is not restored.
>>
>> ---
>>
>> Relevant DRM / AMDGPU log excerpt:
>>
>> [drm] Display Core v3.2.266 initialized on DCE 10.0
>> amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>> [drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0
>>
>> ---
>>
>> Analysis:
>>
>> - The failure occurs during display reinitialization after resume
>> - EDID read failure prevents proper HDMI modeset
>> - This aligns with the observed "no signal" condition
>>
>> Behavior differences:
>>
>> - deep sleep:
>>   - full GPU/display reinitialization
>>   - leads to EDID failure and system instability
>>
>> - s2idle:
>>   - partial resume
>>   - avoids full lockup but display may still be inconsistent
>>
>> This suggests the issue is in the display resume path, possibly involvin=
g:
>>
>> - DC state restore
>> - HDMI link training
>> - DDC/EDID communication
>> - atomic modeset reconstruction
>>
>> ---
>>
>> Conclusion:
>>
>> This is likely a regression in the AMDGPU display resume path, where EDI=
D
>> read fails after resume, preventing HDMI output from being restored.
>>
>> ---
>>
>> Additional notes:
>>
>> This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the
>> transition point identified as a KVM merge commit. While not directly
>> related to AMDGPU, it may have indirectly exposed this issue via
>> timing/order changes.
>>
>> ---
>>
>> If needed, I can provide:
>>
>> - full journalctl logs
>> - full bisect log
>> - additional testing (kernel params, debug options)
>> ------------------------------
>> *De:* Danilo Machado <danilomachado2002@hotmail.com>
>> *Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
>> *Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Alex Deucher <alexdeucher@gmail.com>;
>> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
>> *Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
>> suspend/resume
>>
>>
>> Hi all,
>>
>> Thanks again for your feedback.
>>
>> I took a closer look at the bisect results and system behavior, and I=E2=
=80=99d
>> like to provide a more complete and consolidated report.
>> ------------------------------
>>
>> Hardware:
>>
>>    -
>>
>>    GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>>    -
>>
>>    CPU: AMD Ryzen 5 5500
>>    -
>>
>>    RAM: 16 GB
>>    -
>>
>>    Display: HDMI
>>
>> Software:
>>
>>    -
>>
>>    Driver: amdgpu
>>    -
>>
>>    Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)
>>
>> ------------------------------
>>
>> Summary:
>>
>> This is a reproducible suspend/resume regression affecting HDMI output.
>>
>>    -
>>
>>    Linux 6.3 =E2=86=92 working correctly
>>    -
>>
>>    Linux 6.4+ =E2=86=92 regression present
>>
>> ------------------------------
>>
>> Behavior:
>>
>> After suspend/resume:
>>
>>    -
>>
>>    HDMI output does not recover ("no signal")
>>    -
>>
>>    System may freeze under X11
>>    -
>>
>>    Wayland does not show the same hard failure
>>
>> Additionally:
>>
>>    -
>>
>>    Using "deep" sleep:
>>    -
>>
>>       full system lockup after resume
>>       -
>>
>>    Using "s2idle":
>>    -
>>
>>       system resumes without hard lock
>>       -
>>
>>       however, graphical session may return in a partially broken state
>>
>> ------------------------------
>>
>> Bisect result:
>>
>> A full git bisect was performed between Linux 6.3 and 6.4.
>>
>> First bad commit:
>> b3c98052d46948a8d65d2778c7f306ff38366aac
>> ("Merge tag 'kvm-x86-vmx-6.4'")
>>
>> All intermediate commits in that range were consistently tested as GOOD.
>> ------------------------------
>>
>> Analysis:
>>
>> Although the bisected commit is in KVM and unlikely to directly affect
>> AMDGPU, the transition point is consistent and reproducible.
>>
>> This suggests the regression may be indirectly triggered (e.g. timing or
>> ordering changes during resume), rather than caused directly by that mer=
ge.
>>
>> Based on observed behavior, this appears related to the display resume
>> path, possibly involving:
>>
>>    -
>>
>>    DC state restore after resume
>>    -
>>
>>    HDMI link training
>>    -
>>
>>    EDID re-read
>>    -
>>
>>    atomic modeset state reconstruction
>>
>> The difference between "deep" and "s2idle" also suggests a failure durin=
g
>> full GPU/display reinitialization.
>> ------------------------------
>>
>> Conclusion:
>>
>> This appears to be a latent issue exposed by changes introduced during
>> the 6.4 merge window, rather than a direct regression in the bisected
>> commit itself.
>> ------------------------------
>>
>> If helpful, I can assist further by:
>>
>>    -
>>
>>    providing full bisect logs
>>    -
>>
>>    capturing detailed dmesg/journalctl before and after resume
>>    -
>>
>>    testing patches or debug options
>>    -
>>
>>    narrowing the range further if needed
>>
>> I really appreciate the work on AMDGPU and would be glad to help within
>> my limits to investigate this further.
>>
>> Thanks again for your time.
>>
>> Best regards,
>> Danilo
>> Note: I had some email client configuration issues earlier, which may
>> have caused duplicate messages or formatting problems. These have now be=
en
>> resolved =E2=80=94 apologies for any inconvenience.
>>
>>
>
> --
> *Danilo Machado*
>


--=20
*Danilo Machado*

--000000000000f57161064e29cf1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Also reported on GitLab:<br><a href=3D"https://gitlab.freedeskt=
op.org/drm/amd/-/work_items/5123" target=3D"_blank">https://gitlab.freedesk=
top.org/drm/amd/-/work_items/5123</a></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">Em dom., 29 de mar. de 2026 =C3=
=A0s 09:47, Danilo Machado &lt;<a href=3D"mailto:danilomachado2002@gmail.co=
m" target=3D"_blank">danilomachado2002@gmail.com</a>&gt; escreveu:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_default" style=3D"font-family:verdana,sans-serif">Additional t=
esting:<br><br>I tested with amdgpu.dc=3D0 to disable Display Core.<br><br>=
Result:<br>- system becomes completely unresponsive after resume<br>- black=
 screen, no input response<br><br>This suggests the issue is not limited to=
 Display Core (DC),<br>but likely affects the core GPU resume path.<br><br>=
With DC enabled:<br>- partial recovery (corrupted display, EDID failure)<br=
><br>With DC disabled:<br>- complete failure<br><br>This reinforces that th=
e regression is deeper in the amdgpu resume sequence.</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Em sex., 27 de m=
ar. de 2026 =C3=A0s 21:14, Danilo Machado &lt;<a href=3D"mailto:danilomacha=
do2002@gmail.com" target=3D"_blank">danilomachado2002@gmail.com</a>&gt; esc=
reveu:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Additional da=
ta (resume failure analysis)</div><div style=3D"font-family:&quot;Calibri&q=
uot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:=
rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;H=
elvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
Hardware:</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetic=
a&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- GPU: =
AMD Radeon R9 380 (Tonga, GCN 3)</div><div style=3D"font-family:&quot;Calib=
ri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">- CPU: AMD Ryzen 5 5500</div><div style=3D"font-family:&quo=
t;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:=
12pt;color:rgb(0,0,0)">- RAM: 16 GB</div><div style=3D"font-family:&quot;Ca=
libri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">- Display: HDMI</div><div style=3D"font-family:&quot;Cal=
ibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;=
color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">Software:</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">-=
 Kernel: 6.8.0-106-generic</div><div style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">- Driver: amdgpu</div><div style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">- Display server: X11 (issue reproducible), Wayland (no hard fail=
ure)</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quo=
t;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><d=
iv style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=3D"f=
ont-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoji=
Font;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">Summary:</div><div style=3D"font-family:&quot;Cal=
ibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;=
color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">After suspend/resume, HDMI output is not restored and the system may =
freeze under X11.</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&qu=
ot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">The issue i=
s reproducible and was not present in Linux 6.3.</div><div style=3D"font-fa=
mily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;f=
ont-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;C=
alibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">---</div><div style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Key o=
bservation:</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br><=
/div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">During resume, th=
e driver fails to read EDID:</div><div style=3D"font-family:&quot;Calibri&q=
uot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:=
rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;H=
elvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
=C2=A0 =C2=A0 amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.</div><div st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-=
family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont=
;font-size:12pt;color:rgb(0,0,0)">This appears to explain why HDMI output i=
s not restored.</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><=
br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div=
 style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,=
serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">Relevant DRM / AMDGPU log excerpt:</di=
v><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">[drm] Display Core v3.2.266 init=
ialized on DCE 10.0</div><div style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)">amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.</div><div style=3D"font=
-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">[drm] Initialized amdgpu 3.57.0 20150101=
 for 0000:01:00.0</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&qu=
ot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><d=
iv style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"=
font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)">Analysis:</div><div style=3D"font-fa=
mily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;f=
ont-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;C=
alibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">- The failure occurs during display reinitialization af=
ter resume</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helveti=
ca&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- EDID=
 read failure prevents proper HDMI modeset</div><div style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">- This aligns with the observed &quot;no signal&q=
uot; condition</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Hel=
vetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><b=
r></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Behavior diffe=
rences:</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div=
><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- deep sleep:</div><d=
iv style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - full GPU/displa=
y reinitialization</div><div style=3D"font-family:&quot;Calibri&quot;,&quot=
;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)=
">=C2=A0 - leads to EDID failure and system instability</div><div style=3D"=
font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">- s2idle:</div><div style=3D"font-family:&quot;C=
alibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">=C2=A0 - partial resume</div><div style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">=C2=A0 - avoids full lockup but display may stil=
l be inconsistent</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
><br></div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&qu=
ot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This sugges=
ts the issue is in the display resume path, possibly involving:</div><div s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font=
-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">- DC state restore</div><div style=3D"fo=
nt-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiF=
ont;font-size:12pt;color:rgb(0,0,0)">- HDMI link training</div><div style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DDC/EDID communication</div><d=
iv style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- atomic modeset reconst=
ruction</div><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div=
><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)">Conclusion:</div><div style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">This
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
 params, debug options)</div><div id=3D"m_4916195300917595998m_355792032271=
5242118m_3075601443013613040gmail-x_appendonsend"></div><hr style=3D"displa=
y:inline-block;width:98%"><div id=3D"m_4916195300917595998m_355792032271524=
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
font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)">Hi all,</span></p><p style=3D"margin=
-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">Thanks again for your feedback.</span></p><p style=3D"margin-top:1em=
;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I=
 took a closer look at the bisect results and system behavior, and I=E2=80=
=99d like to provide a more complete and consolidated report.</span></p><hr=
><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">Hardware:</span></p><ul><li style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:r=
gb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1=
em">GPU: AMD Radeon R9 380 (Tonga, GCN 3)</p></li><li style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:r=
gb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1=
em">CPU: AMD Ryzen 5 5500</p></li><li style=3D"font-family:&quot;Calibri&qu=
ot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p ro=
le=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">RAM: 16 GB</=
p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=
=3D"margin-top:1em;margin-bottom:1em">Display: HDMI</p></li></ul><p style=
=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Cali=
bri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;c=
olor:rgb(0,0,0)">Software:</span></p><ul><li style=3D"font-family:&quot;Cal=
ibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)=
"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Drive=
r: amdgpu</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentati=
on" style=3D"margin-top:1em;margin-bottom:1em">Kernel range tested: 6.3 (go=
od) =E2=86=92 6.4 (bad)</p></li></ul><hr><p style=3D"margin-top:1em;margin-=
bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Summary:<=
/span></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font=
-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">This is a reproducible suspend/resume re=
gression affecting HDMI output.</span></p><ul><li style=3D"font-family:&quo=
t;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0=
,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">=
Linux 6.3 =E2=86=92 working correctly</p></li><li style=3D"font-family:&quo=
t;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0=
,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">=
Linux 6.4+ =E2=86=92 regression present</p></li></ul><hr><p style=3D"margin=
-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,=
&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">Behavior:</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><s=
pan style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">After suspend/resume:</=
span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&q=
uot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" s=
tyle=3D"margin-top:1em;margin-bottom:1em">HDMI output does not recover (&qu=
ot;no signal&quot;)</p></li><li style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"=
presentation" style=3D"margin-top:1em;margin-bottom:1em">System may freeze =
under X11</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentati=
on" style=3D"margin-top:1em;margin-bottom:1em">Wayland does not show the sa=
me hard failure</p></li></ul><p style=3D"margin-top:1em;margin-bottom:1em">=
<span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Additionally:</span><=
/p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=
=3D"margin-top:1em;margin-bottom:1em">Using &quot;deep&quot; sleep:</p></li=
><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,san=
s-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"=
margin-top:1em;margin-bottom:1em">full system lockup after resume</p></li><=
/ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans=
-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"m=
argin-top:1em;margin-bottom:1em">Using &quot;s2idle&quot;:</p></li><ul><li =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;f=
ont-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-to=
p:1em;margin-bottom:1em">system resumes without hard lock</p></li><li style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em=
;margin-bottom:1em">however, graphical session may return in a partially br=
oken state</p></li></ul></ul><hr><p style=3D"margin-top:1em;margin-bottom:1=
em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Bisect result:</s=
pan></p><p style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;=
font-size:12pt;color:rgb(0,0,0)">A full git bisect was performed between Li=
nux 6.3 and 6.4.</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><s=
pan style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">First bad commit:<br>b3=
c98052d46948a8d65d2778c7f306ff38366aac<br>(&quot;Merge tag &#39;kvm-x86-vmx=
-6.4&#39;&quot;)</span></p><p style=3D"margin-top:1em;margin-bottom:1em"><s=
pan style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">All intermediate commit=
s in that range were consistently tested as GOOD.</span></p><hr><p style=3D=
"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">Analysis:</span></p><p style=3D"margin-top:1em;margin-bottom:=
1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Although
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
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">Danilo Machad=
o</i></div></div>

--000000000000f57161064e29cf1e--
