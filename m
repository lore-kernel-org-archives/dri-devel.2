Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3134210F3DD9
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 10:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B5910E3D1;
	Sat, 28 Mar 2026 10:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOsL4ouK";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F97B10EFD0
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 00:14:45 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b9961e4f71bso425924166b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774656883; cv=none;
 d=google.com; s=arc-20240605;
 b=lLXaNxSmbpcJKqg/+sALbkm7xSr4kaHe8g9NRTSzsv1VmOmw6JZZ78ngaelloKe9PM
 O4cWp3L0D01erjlciVCtU1tALHMm1uwWvCA6lvidpYv5eLAxhJIQIABJZb+rgUPvhZUC
 tyHxXFxuAqra1l9rl3SeJPTs1JdQ0lbzx270R+QVjk7SSDL+gx+GWrPDprJDDefV1l7W
 ihFu+g+n3THMsSeIJO/0rWMebUXm06+i5zZZDDk1UzCcFogsFOLZq/Avtf/XQK8PMuRI
 EVY3QpXNBNf71EWcWQbIfOxdgwpv0Cw8s3FZ6gKZ8uYQu2WmjVxf8dtbMbiOyI1+KuIc
 5tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=V6Is6OvXOa24h0dQSCMHCx6aMAsvs9pMXPSn3DPBr04=;
 fh=yamdC3/PPc+0MFt+AHbabBa11fylHWJWIW5k6ZaqpcU=;
 b=Wsgi2UWXjiONCN90NFwn+srqwJLOJsexUGHDT7SCcqayRzyd2tr+aqhPeBJSMXHQ36
 md79tEvDPX8AQKfk0CmT8+xgiIJQBGIG95ToK99STW5dn7AuQ5QE/MRBhc00qOF/PohG
 xq9QFoQHUX4+lZ187+WuRlxl4we1cXKvYwZ//QHGT5mrvSYfSbu+Dn84QuABClUBFyKp
 8QmJ+Gha3NVqkedIzCIg5isCy1s4RDvvmzJvIU1+95IezD9MR3UdyN20fsGRSRLAh2dG
 1GjEgK6dGDSp0sKDVhEJi0XY2oVN+q0/2XNmvGmdk1kNXwEdvGXf+XrzE39/avM7pybE
 0ckQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774656883; x=1775261683; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V6Is6OvXOa24h0dQSCMHCx6aMAsvs9pMXPSn3DPBr04=;
 b=kOsL4ouKeQbQ6NZ8bcHjlDP07EXaqukWqI9NNISHggIOPo06v4FesUlDSn5YTc5MjA
 h0A8MWSgsLFqd3U9uz//kaTwm4iG+xLlri4ct//dr9zU+JIsMPyibK9ek4dtO/smKBAy
 2+8a08PqddLZXvlkSLnjAsYjWYnSjjv9UjmrO7BxihgzuxVf6VREYehX/BYG2rBf83by
 SKZf2C95vt9MYhiouDTdfljoL0/batgnnS0lyQGOWNTk/Ua8vrTgvFLXs+Ui+NZeOHh3
 jA2yasazYU5x20RvPo1f/P3GKI5xmZMcsQ84w18e3ZYM0y2EX8/+BwadepiMQLTud9gE
 rvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774656883; x=1775261683;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V6Is6OvXOa24h0dQSCMHCx6aMAsvs9pMXPSn3DPBr04=;
 b=mdppT+HjXDX/rY2D5xboXQ++TVgUaMLvMm1F5kC002wwiAcqf8gdztPrGDV7h6W1Cr
 b37HsmkdKk1D4elssciD3zv2di0+1+7dYLY0Jh2Y7fU7M6hdJiEN4wtVybDT8GoAkvWf
 lhgiPnszP5ieJNhoMSL40MzMsCpR0GQHDNkF3Ag3U2nLMy5pVDyWsMdwtXBygihAKXpF
 LoQiiS/iCglWV3BiAch+0TtHApcM7TeANDsALhdoqCMhJqhlsOm1JRs19foqNkRvCnY6
 DQL379CNJs4zWLOzegDEVECANWGWVV00NcFix1SB86sog0SnS67W97GDB0UpE9dDLcZR
 AmVg==
X-Gm-Message-State: AOJu0YzESSRSEDD16jwV2jLIKx2e/D9xDhsyttMnvDQ2VR6zyRTkccak
 O4mbXvwrzMIRfsOBqZ8HdRkVEtjnVw8CtRrDit+AYKYAg3bVYdTK7XfwF2XxleFGmfRAH/lHSI9
 ThmjmcLVd49S87Ldsaqfk1UJR8jDTTw==
X-Gm-Gg: ATEYQzy0t6Ij3Wd0RGmTQRNcP/FODky14X8JbFrULZKX8vpEZ3iHRA0xQO0z/NJCY9B
 3mNrP1R4iJJ3raI02VPTVtOYVjfQczWsN42uPm/2ylr/UdXDNppL8X67uI+bZt73OH00SPaQ0jM
 PsVMzVU14+rRj21edZiPPhALw/yMX3j5YvRDnj2sJVjtkR3K3ItLnDgdE9FnH9BEDnVb7nyT7BW
 caysTBCYReUqRVK2yo0LLk+kchkC1HvgrGMcVKcWCCG0pn7n9NyUUuPpCSnXpcuDe7GAZnk87w7
 h6iOlavzJI4BZKCjZh6MYBcWwFBRGZ2dHCIpnz7k
X-Received: by 2002:a17:906:d015:b0:b9b:3d5e:34d6 with SMTP id
 a640c23a62f3a-b9b503560eemr164559266b.14.1774656883131; Fri, 27 Mar 2026
 17:14:43 -0700 (PDT)
MIME-Version: 1.0
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Fri, 27 Mar 2026 21:14:31 -0300
X-Gm-Features: AQROBzAN9V0b4IEI65GNQhDwyn1WvhHtFMDsH76fwW4meVNDcjl4w4bXOjUQjh0
Message-ID: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
Subject: RE: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com
Content-Type: multipart/alternative; boundary="0000000000001e08c4064e0a8136"
X-Mailman-Approved-At: Sat, 28 Mar 2026 10:16:18 +0000
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

--0000000000001e08c4064e0a8136
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Additional data (resume failure analysis)

Hardware:
- GPU: AMD Radeon R9 380 (Tonga, GCN 3)
- CPU: AMD Ryzen 5 5500
- RAM: 16 GB
- Display: HDMI

Software:
- Kernel: 6.8.0-106-generic
- Driver: amdgpu
- Display server: X11 (issue reproducible), Wayland (no hard failure)

---

Summary:

After suspend/resume, HDMI output is not restored and the system may freeze
under X11.

The issue is reproducible and was not present in Linux 6.3.

---

Key observation:

During resume, the driver fails to read EDID:

    amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.

This appears to explain why HDMI output is not restored.

---

Relevant DRM / AMDGPU log excerpt:

[drm] Display Core v3.2.266 initialized on DCE 10.0
amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
[drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0

---

Analysis:

- The failure occurs during display reinitialization after resume
- EDID read failure prevents proper HDMI modeset
- This aligns with the observed "no signal" condition

Behavior differences:

- deep sleep:
  - full GPU/display reinitialization
  - leads to EDID failure and system instability

- s2idle:
  - partial resume
  - avoids full lockup but display may still be inconsistent

This suggests the issue is in the display resume path, possibly involving:

- DC state restore
- HDMI link training
- DDC/EDID communication
- atomic modeset reconstruction

---

Conclusion:

This is likely a regression in the AMDGPU display resume path, where EDID
read fails after resume, preventing HDMI output from being restored.

---

Additional notes:

This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the
transition point identified as a KVM merge commit. While not directly
related to AMDGPU, it may have indirectly exposed this issue via
timing/order changes.

---

If needed, I can provide:

- full journalctl logs
- full bisect log
- additional testing (kernel params, debug options)
------------------------------
*De:* Danilo Machado <danilomachado2002@hotmail.com>
*Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
*Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
*Cc:* Alex Deucher <alexdeucher@gmail.com>; dri-devel@lists.freedesktop.org
<dri-devel@lists.freedesktop.org>
*Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
suspend/resume


Hi all,

Thanks again for your feedback.

I took a closer look at the bisect results and system behavior, and I=E2=80=
=99d
like to provide a more complete and consolidated report.
------------------------------

Hardware:

   -

   GPU: AMD Radeon R9 380 (Tonga, GCN 3)
   -

   CPU: AMD Ryzen 5 5500
   -

   RAM: 16 GB
   -

   Display: HDMI

Software:

   -

   Driver: amdgpu
   -

   Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)

------------------------------

Summary:

This is a reproducible suspend/resume regression affecting HDMI output.

   -

   Linux 6.3 =E2=86=92 working correctly
   -

   Linux 6.4+ =E2=86=92 regression present

------------------------------

Behavior:

After suspend/resume:

   -

   HDMI output does not recover ("no signal")
   -

   System may freeze under X11
   -

   Wayland does not show the same hard failure

Additionally:

   -

   Using "deep" sleep:
   -

      full system lockup after resume
      -

   Using "s2idle":
   -

      system resumes without hard lock
      -

      however, graphical session may return in a partially broken state

------------------------------

Bisect result:

A full git bisect was performed between Linux 6.3 and 6.4.

First bad commit:
b3c98052d46948a8d65d2778c7f306ff38366aac
("Merge tag 'kvm-x86-vmx-6.4'")

All intermediate commits in that range were consistently tested as GOOD.
------------------------------

Analysis:

Although the bisected commit is in KVM and unlikely to directly affect
AMDGPU, the transition point is consistent and reproducible.

This suggests the regression may be indirectly triggered (e.g. timing or
ordering changes during resume), rather than caused directly by that merge.

Based on observed behavior, this appears related to the display resume
path, possibly involving:

   -

   DC state restore after resume
   -

   HDMI link training
   -

   EDID re-read
   -

   atomic modeset state reconstruction

The difference between "deep" and "s2idle" also suggests a failure during
full GPU/display reinitialization.
------------------------------

Conclusion:

This appears to be a latent issue exposed by changes introduced during the
6.4 merge window, rather than a direct regression in the bisected commit
itself.
------------------------------

If helpful, I can assist further by:

   -

   providing full bisect logs
   -

   capturing detailed dmesg/journalctl before and after resume
   -

   testing patches or debug options
   -

   narrowing the range further if needed

I really appreciate the work on AMDGPU and would be glad to help within my
limits to investigate this further.

Thanks again for your time.

Best regards,
Danilo
Note: I had some email client configuration issues earlier, which may have
caused duplicate messages or formatting problems. These have now been
resolved =E2=80=94 apologies for any inconvenience.

--0000000000001e08c4064e0a8136
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:&quot;Calibri&quot;,&quot;Helvet=
ica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Addit=
ional data (resume failure analysis)</div><div class=3D"gmail-x_elementToPr=
oof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=
=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>Hardware:</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">- GPU: AMD Radeon R9 380 (Tonga, GCN 3)</div><di=
v class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;=
,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">- CPU: AMD Ryzen 5 5500</div><div class=3D"gmail-x_elementToProof" =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,s=
erif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- RAM: 16 GB</div><div clas=
s=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot=
;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)=
">- Display: HDMI</div><div class=3D"gmail-x_elementToProof" style=3D"font-=
family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont=
;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementTo=
Proof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Software:</div><div =
class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">- Kernel: 6.8.0-106-generic</div><div class=3D"gmail-x_elementToProof=
" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- Driver: amdgpu</div><di=
v class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;=
,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">- Display server: X11 (issue reproducible), Wayland (no hard failur=
e)</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Ca=
libri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div class=3D"gmail-x_elem=
entToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,=
sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div =
class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">Summary:</div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToPro=
of" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">After suspend/resume, H=
DMI output is not restored and the system may freeze under X11.</div><div c=
lass=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">The issue is reproducible and was not present in =
Linux 6.3.</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:=
&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,s=
erif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div class=3D"gmai=
l-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetic=
a&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></d=
iv><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;colo=
r:rgb(0,0,0)">Key observation:</div><div class=3D"gmail-x_elementToProof" s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmai=
l-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetic=
a&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">During =
resume, the driver fails to read EDID:</div><div class=3D"gmail-x_elementTo=
Proof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=
=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>=C2=A0 =C2=A0 amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.</div><div c=
lass=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)">This appears to explain why HDMI output is not re=
stored.</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size=
:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div class=3D"gmail-x=
_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&q=
uot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div>=
<div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&qu=
ot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">Relevant DRM / AMDGPU log excerpt:</div><div class=3D"gmail-x_el=
ementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><di=
v class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;=
,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">[drm] Display Core v3.2.266 initialized on DCE 10.0</div><div class=
=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.</div><div class=3D"gmail-=
x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&=
quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">[drm] Ini=
tialized amdgpu 3.57.0 20150101 for 0000:01:00.0</div><div class=3D"gmail-x=
_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&q=
uot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div>=
<div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&qu=
ot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">---</div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToPro=
of" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Analysis:</div><div cla=
ss=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size=
:12pt;color:rgb(0,0,0)">- The failure occurs during display reinitializatio=
n after resume</div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)">- EDID read failure prevents proper HDMI mod=
eset</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;=
Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)">- This aligns with the observed &quot;no signal&quot; =
condition</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&=
quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-si=
ze:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Behavior differences:</div><=
div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)">- deep sleep:</div><div class=3D"gmail-x_ele=
mentToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - full =
GPU/display reinitialization</div><div class=3D"gmail-x_elementToProof" sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,seri=
f,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - leads to EDID failure=
 and system instability</div><div class=3D"gmail-x_elementToProof" style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_ele=
mentToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- s2idle:</div=
><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&q=
uot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:=
rgb(0,0,0)">=C2=A0 - partial resume</div><div class=3D"gmail-x_elementToPro=
of" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - avoids full lo=
ckup but display may still be inconsistent</div><div class=3D"gmail-x_eleme=
ntToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div c=
lass=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">This suggests the issue is in the display resume path, possibly involv=
ing:</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;=
Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DC state restore</div><div cla=
ss=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quo=
t;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0=
)">- HDMI link training</div><div class=3D"gmail-x_elementToProof" style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">- DDC/EDID communication</div><div =
class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">- atomic modeset reconstruction</div><div class=3D"gmail-x_elementToP=
roof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=
=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"=
>---</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;=
Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12=
pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">Conclusion:</div><div class=3D"g=
mail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br>=
</div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Cali=
bri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;c=
olor:rgb(0,0,0)">This
 is likely a regression in the AMDGPU display resume path, where EDID=20
read fails after resume, preventing HDMI output from being restored.</div><=
div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)">---</div><div class=3D"gmail-x_elementToProo=
f" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"=
gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helv=
etica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Add=
itional notes:</div><div class=3D"gmail-x_elementToProof" style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;fo=
nt-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_elementToPro=
of" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This
 issue was bisected between Linux 6.3 (good) and 6.4 (bad), with the=20
transition point identified as a KVM merge commit. While not directly=20
related to AMDGPU, it may have indirectly exposed this issue via=20
timing/order changes.</div><div class=3D"gmail-x_elementToProof" style=3D"f=
ont-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emoji=
Font;font-size:12pt;color:rgb(0,0,0)"><br></div><div class=3D"gmail-x_eleme=
ntToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div cl=
ass=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)"><br></div><div class=3D"gmail-x_elementToProof" style=3D"font-family:&q=
uot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">If needed, I can provide:</div><div class=3D"gmail=
-x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica=
&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></di=
v><div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&=
quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color=
:rgb(0,0,0)">- full journalctl logs</div><div class=3D"gmail-x_elementToPro=
of" style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- full bisect log</div>=
<div class=3D"gmail-x_elementToProof" style=3D"font-family:&quot;Calibri&qu=
ot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">- additional testing (kernel params, debug options)</div><div id=
=3D"gmail-x_appendonsend"></div><hr tabindex=3D"-1" style=3D"display:inline=
-block;width:98%"><div id=3D"gmail-x_divRplyFwdMsg" dir=3D"ltr"><font face=
=3D"Calibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>De:<=
/b> Danilo Machado &lt;<a href=3D"mailto:danilomachado2002@hotmail.com">dan=
ilomachado2002@hotmail.com</a>&gt;<br><b>Enviado:</b> quinta-feira, 26 de m=
ar=C3=A7o de 2026 20:38<br><b>Para:</b> <a href=3D"mailto:amd-gfx@lists.fre=
edesktop.org">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-g=
fx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;<br><b>Cc:</=
b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gm=
ail.com</a>&gt;; <a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-dev=
el@lists.freedesktop.org</a> &lt;<a href=3D"mailto:dri-devel@lists.freedesk=
top.org">dri-devel@lists.freedesktop.org</a>&gt;<br><b>Assunto:</b> [REGRES=
SION][bisected] amdgpu/tonga: HDMI no signal after suspend/resume</font> <d=
iv aria-hidden=3D"true">=C2=A0</div></div><div dir=3D"ltr"><p class=3D"gmai=
l-x_x_elementToProof" style=3D"margin-top:1em;margin-bottom:1em"><span styl=
e=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif=
,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Hi all,</span></p><p class=3D"g=
mail-x_x_elementToProof" style=3D"margin-top:1em;margin-bottom:1em"><span s=
tyle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Thanks again for your feedba=
ck.</span></p><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:1em=
;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;He=
lvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I=
 took a closer look at the bisect results and system behavior, and I=E2=80=
=99d like to provide a more complete and consolidated report.</span></p><hr=
><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:1em;margin-botto=
m:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Hardware:</spa=
n></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot=
;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_element=
ToProof" role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">G=
PU: AMD Radeon R9 380 (Tonga, GCN 3)</p></li><li style=3D"font-family:&quot=
;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,=
0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentation" style=3D"=
margin-top:1em;margin-bottom:1em">CPU: AMD Ryzen 5 5500</p></li><li style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"pr=
esentation" style=3D"margin-top:1em;margin-bottom:1em">RAM: 16 GB</p></li><=
li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-seri=
f;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" ro=
le=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Display: HDM=
I</p></li></ul><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:1e=
m;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;H=
elvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=
Software:</span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;=
Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gma=
il-x_x_elementToProof" role=3D"presentation" style=3D"margin-top:1em;margin=
-bottom:1em">Driver: amdgpu</p></li><li style=3D"font-family:&quot;Calibri&=
quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p =
class=3D"gmail-x_x_elementToProof" role=3D"presentation" style=3D"margin-to=
p:1em;margin-bottom:1em">Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad=
)</p></li></ul><hr><p class=3D"gmail-x_x_elementToProof" style=3D"margin-to=
p:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,=
0)">Summary:</span></p><p class=3D"gmail-x_x_elementToProof" style=3D"margi=
n-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;=
,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">This is a reproducible suspend/resume regression affecting HDMI out=
put.</span></p><ul><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_=
x_elementToProof" role=3D"presentation" style=3D"margin-top:1em;margin-bott=
om:1em">Linux 6.3 =E2=86=92 working correctly</p></li><li style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;col=
or:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentation" =
style=3D"margin-top:1em;margin-bottom:1em">Linux 6.4+ =E2=86=92 regression =
present</p></li></ul><hr><p class=3D"gmail-x_x_elementToProof" style=3D"mar=
gin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quo=
t;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rg=
b(0,0,0)">Behavior:</span></p><p class=3D"gmail-x_x_elementToProof" style=
=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Cali=
bri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;c=
olor:rgb(0,0,0)">After suspend/resume:</span></p><ul><li style=3D"font-fami=
ly:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;colo=
r:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentation" s=
tyle=3D"margin-top:1em;margin-bottom:1em">HDMI output does not recover (&qu=
ot;no signal&quot;)</p></li><li style=3D"font-family:&quot;Calibri&quot;,&q=
uot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D=
"gmail-x_x_elementToProof" role=3D"presentation" style=3D"margin-top:1em;ma=
rgin-bottom:1em">System may freeze under X11</p></li><li style=3D"font-fami=
ly:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;colo=
r:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentation" s=
tyle=3D"margin-top:1em;margin-bottom:1em">Wayland does not show the same ha=
rd failure</p></li></ul><p class=3D"gmail-x_x_elementToProof" style=3D"marg=
in-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb=
(0,0,0)">Additionally:</span></p><ul><li style=3D"font-family:&quot;Calibri=
&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p=
 class=3D"gmail-x_x_elementToProof" role=3D"presentation" style=3D"margin-t=
op:1em;margin-bottom:1em">Using &quot;deep&quot; sleep:</p></li><ul><li sty=
le=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font=
-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"=
presentation" style=3D"margin-top:1em;margin-bottom:1em">full system lockup=
 after resume</p></li></ul><li style=3D"font-family:&quot;Calibri&quot;,&qu=
ot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"=
gmail-x_x_elementToProof" role=3D"presentation" style=3D"margin-top:1em;mar=
gin-bottom:1em">Using &quot;s2idle&quot;:</p></li><ul><li style=3D"font-fam=
ily:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;col=
or:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentation" =
style=3D"margin-top:1em;margin-bottom:1em">system resumes without hard lock=
</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;=
,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementT=
oProof" role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">ho=
wever, graphical session may return in a partially broken state</p></li></u=
l></ul><hr><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:1em;ma=
rgin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helve=
tica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Bise=
ct result:</span></p><p class=3D"gmail-x_x_elementToProof" style=3D"margin-=
top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&=
quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,=
0,0)">A full git bisect was performed between Linux 6.3 and 6.4.</span></p>=
<p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:1em;margin-bottom=
:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,=
sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">First bad commi=
t:<br>b3c98052d46948a8d65d2778c7f306ff38366aac<br>(&quot;Merge tag &#39;kvm=
-x86-vmx-6.4&#39;&quot;)</span></p><p class=3D"gmail-x_x_elementToProof" st=
yle=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;C=
alibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12p=
t;color:rgb(0,0,0)">All intermediate commits in that range were consistentl=
y tested as GOOD.</span></p><hr><p class=3D"gmail-x_x_elementToProof" style=
=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Cali=
bri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;c=
olor:rgb(0,0,0)">Analysis:</span></p><p class=3D"gmail-x_x_elementToProof" =
style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot=
;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:1=
2pt;color:rgb(0,0,0)">Although
 the bisected commit is in KVM and unlikely to directly affect AMDGPU,=20
the transition point is consistent and reproducible.</span></p><p class=3D"=
gmail-x_x_elementToProof" style=3D"margin-top:1em;margin-bottom:1em"><span =
style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,s=
erif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This
 suggests the regression may be indirectly triggered (e.g. timing or=20
ordering changes during resume), rather than caused directly by that=20
merge.</span></p><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:=
1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)=
">Based on observed behavior, this appears related to the display resume pa=
th, possibly involving:</span></p><ul><li style=3D"font-family:&quot;Calibr=
i&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><=
p class=3D"gmail-x_x_elementToProof" role=3D"presentation" style=3D"margin-=
top:1em;margin-bottom:1em">DC state restore after resume</p></li><li style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"pr=
esentation" style=3D"margin-top:1em;margin-bottom:1em">HDMI link training</=
p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,s=
ans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToP=
roof" role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">EDID=
 re-read</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helveti=
ca&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_=
elementToProof" role=3D"presentation" style=3D"margin-top:1em;margin-bottom=
:1em">atomic modeset state reconstruction</p></li></ul><p class=3D"gmail-x_=
x_elementToProof" style=3D"margin-top:1em;margin-bottom:1em"><span style=3D=
"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">The difference between &quot;deep&q=
uot; and &quot;s2idle&quot; also suggests a failure during full GPU/display=
 reinitialization.</span></p><hr><p class=3D"gmail-x_x_elementToProof" styl=
e=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Cal=
ibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;=
color:rgb(0,0,0)">Conclusion:</span></p><p class=3D"gmail-x_x_elementToProo=
f" style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&q=
uot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">This
 appears to be a latent issue exposed by changes introduced during the=20
6.4 merge window, rather than a direct regression in the bisected commit
 itself.</span></p><hr><p class=3D"gmail-x_x_elementToProof" style=3D"margi=
n-top:1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;=
,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)">If helpful, I can assist further by:</span></p><ul><li style=3D"fon=
t-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-size:12p=
t;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"presentat=
ion" style=3D"margin-top:1em;margin-bottom:1em">providing full bisect logs<=
/p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,=
sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementTo=
Proof" role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">cap=
turing detailed dmesg/journalctl before and after resume</p></li><li style=
=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><p class=3D"gmail-x_x_elementToProof" role=3D"pr=
esentation" style=3D"margin-top:1em;margin-bottom:1em">testing patches or d=
ebug options</p></li><li style=3D"font-family:&quot;Calibri&quot;,&quot;Hel=
vetica&quot;,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p class=3D"gmail-=
x_x_elementToProof" role=3D"presentation" style=3D"margin-top:1em;margin-bo=
ttom:1em">narrowing the range further if needed</p></li></ul><p class=3D"gm=
ail-x_x_elementToProof" style=3D"margin-top:1em;margin-bottom:1em"><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">I really appreciate the work =
on AMDGPU and would be glad to help within my limits to investigate this fu=
rther.</span></p><p class=3D"gmail-x_x_elementToProof" style=3D"margin-top:=
1em;margin-bottom:1em"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;Helvetica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)=
">Thanks again for your time.</span></p><p class=3D"gmail-x_x_elementToProo=
f" style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:&q=
uot;Calibri&quot;,&quot;Helvetica&quot;,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">Best regards,<br>Danilo</span></p><div class=3D"gm=
ail-x_x_elementToProof" style=3D"font-family:&quot;Calibri&quot;,&quot;Helv=
etica&quot;,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Not=
e:
 I had some email client configuration issues earlier, which may have=20
caused duplicate messages or formatting problems. These have now been=20
resolved =E2=80=94 apologies for any inconvenience.</div></div><br></div>

--0000000000001e08c4064e0a8136--
