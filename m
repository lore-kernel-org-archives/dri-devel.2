Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF96EFB3CE4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB9E10E536;
	Mon, 30 Mar 2026 09:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hB1GNtbL";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3667810E059
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 21:36:33 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-66a87eb232bso6236465a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 14:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774820192; cv=none;
 d=google.com; s=arc-20240605;
 b=bWEIl2LhLC35GgGC5UisR1yxMRCmuu1abpb7snFYUXDR1LhAXkeqleOpZXiKho2MkE
 y7SEhq3F3mWMtb2QDpn/4ssDEy4gDibnvlkVv+bNgCPfr8fYvizKZeweHKYQpMyw0ohc
 Q1nBHN+jEZPYGyhgdyCaf1mIpDJWJEysj44vuWlfjLz8TgV59zXbsZb650RhjC/ZqlTQ
 z/0wHpaWuPn1LKJtkRZMTP2uLZvI5Vo13cVNSnnuPodQphSDxXumih2lmpmCUxiOk3Ae
 5HKWPvVA0hlrzBZTSlC/va7ll9Y9UiCosDrEg+ZrDm2pmk79K8YWhUHvaYqzcSSGtVZI
 tBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zay8xFzNvmYD/HoLT2KcZlsdyAQAmv8fpPsqloIBjvg=;
 fh=yamdC3/PPc+0MFt+AHbabBa11fylHWJWIW5k6ZaqpcU=;
 b=ZHBhcubUZ/+ZhWLLgv7Vov/o46mgWc+Yi2b6/KEBx4GQFuQ5hs1+BekIfrLKsfWKjq
 iTcJg1DHEOBe4+3zo4fOwrLOWjriBA89G46zjrV7BTz6FHjEmTR9AHwKG7+eKPay5ofR
 nUW547YhJkIq6rhJ153fXSmRT08tA2KgVKDjKrogkdoIbpdVXIPavStnUDu+DAqz7Wq4
 E5qIPBxJAlAHT8h+HFpgSGPZV8vmENJBtSOY5KzeZ73cI8JNDfG6fMKLR0ClCLSLflSi
 YOz5cHGqmpO2JtCZX6hJfHMv2B9V81YNx5Lp36YDQ3yy37/LCr9T47PFl9FQLOr1/+PJ
 zi3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774820192; x=1775424992; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zay8xFzNvmYD/HoLT2KcZlsdyAQAmv8fpPsqloIBjvg=;
 b=hB1GNtbLKMqE+3a0GfLggZu3z2KTWagSLxYk32VgRT4TL3HQUX8HYTK2w5bk7bfxod
 sqmOVjGWfr7VFhrp72pNnEeYPPjh+Fp2GQrWOXG2jSAFVCvBN7Z5b7TDnk2pGLUuZ+Rc
 qZQrY8xugJoyR3Lb97h9Gh8vCnoOyxd1O9KKcBss0pqW7zlwxhH1iGoDHIwNtdDTcnb/
 BFOl3A2XXhdyXMlIiexK5cTAPHsI3UVWDlgSvGtnP0XdopjX39whtK3ktI9uUD9W58Su
 N+5k3jtOgR0+SGcncV+lIc8tqciFJLoY7b7rurjb2EFJIPZP2gUbK+FCu3ax9GA5YucD
 LOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774820192; x=1775424992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zay8xFzNvmYD/HoLT2KcZlsdyAQAmv8fpPsqloIBjvg=;
 b=HHwfWOk6EwZidzggpR5/UMJQb+FnDUNjPHbG1zlkWBbafHXItH6hhq4TPVrhg3ezrr
 NmKOXwMSe7a2GD0TlkkodgKUfjPyYrNn9Mfu5k1vL5ZNOai3bEzFh4yWUbXcOgjFmkeM
 uDQ9V7zkuT0+byzzw5sO3B3YWR7yxnSJRYP/WANeFsNnlZVXeAFEZPsx+klYQcqljZsu
 55sg4ieuuqJS5rtioaGoV0GsEWrw5fP1CT/hZIntE8wYJsZtdc0WQi0o9VMDWbJNaHky
 +WOnnTBj/6MfE0X/Y6KHYddHZnDJRpyFLCPWKTvS1qCpdr5YCmj0Ll3FsVV4ydt5wx4n
 MzGQ==
X-Gm-Message-State: AOJu0YzfAUyHRO16ihPqgPxit4WoGjfZo2LcPybAfn4CG0W5hlOz/t5D
 kQafwS7V47Z+gsfyu5bcQmpknhZ0o9YI7OV0ii+w2ohT/ZOCmd0PNXiSJqDoa+CF49ks+zNg58Y
 wYJk7I01+CZe+NOBQXbI1AKzh6sPblg==
X-Gm-Gg: ATEYQzxwGQzs4IL05CTwzqGwUVArvAU4iidDSWRbjR9iAYB0gigADz5qNKTew1ku6Ja
 TLUodTjqlr/xuoi/h2fYULsYo8iw75QySWDjj/stljohMTDhXaj3yO0ql8FAasaNZOrlhlpz4R6
 UJWVRpqHN4hBm0xcebTpTVqQ5CMykg7j1Se2ucqN8ySGy1TGDgY/JAkwNaCt1GhgYd4QqNF14Hm
 3gBqTU52ookL67kPeGKqUErDF+8qBpOEqEbsn8L6R2RTS9V8W9noPaZ+lI10A056WvBAM3/mI5t
 SIO6uG66M8L6oz1XnPF5w/9WhVO7ytAyPwDgmXy0
X-Received: by 2002:a17:907:c70f:b0:b98:2df5:9be3 with SMTP id
 a640c23a62f3a-b9b50301c19mr574924266b.11.1774820191176; Sun, 29 Mar 2026
 14:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ9xWrKayFgruqhU8bs-2E2g52sed6VjOhNoq8aqhw+uxfSGVg@mail.gmail.com>
 <CAJ9xWrKwPgM-jeUJB5vMaU0u-wWp=JVCQ_38u-25J6nc3+WZzg@mail.gmail.com>
 <CAJ9xWrJpvse5i3vSqNRXRarx7DEFSbATD_NG4d7E+5Mza1gA-A@mail.gmail.com>
 <CAJ9xWrL79F7bt+=Nbohp-pwDaOOWE8Cazah7kvtOdk5mutAG3Q@mail.gmail.com>
In-Reply-To: <CAJ9xWrL79F7bt+=Nbohp-pwDaOOWE8Cazah7kvtOdk5mutAG3Q@mail.gmail.com>
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Sun, 29 Mar 2026 18:36:19 -0300
X-Gm-Features: AQROBzBrq7L50_3MZ2VJrmefFMr7kHePU0ZBnSmm-dxFlFsmqCpIE2UaY0JW50M
Message-ID: <CAJ9xWrJaN80e1jzieNBCZ35BRrBNDg53L+jE-z6Zh6tPbDTNTw@mail.gmail.com>
Subject: Re: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexdeucher@gmail.com
Content-Type: multipart/alternative; boundary="000000000000090ca7064e308705"
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

--000000000000090ca7064e308705
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I would like to share an important update based on further testing.

After implementing a temporary workaround, I noticed that the issue is not
limited to suspend/resume. There is a second trigger that seems to affect
the same underlying problem.
=F0=9F=94=8D Additional trigger identified (DPMS / screen off)

Sequence:

   1.

   System resumes from suspend =E2=86=92 works correctly (login screen appe=
ars)
   2.

   System becomes idle =E2=86=92 screen turns off (DPMS)
   3.

   Upon user interaction (keyboard/mouse), the display fails to wake
   properly

Observed behavior:

   -

   Black screen or no signal
   -

   System remains responsive (can sometimes type blindly)
   -

   In some cases, session becomes partially corrupted

Important detail:

This behavior is very similar to what happens after suspend/resume:

   -

   HDMI link is not properly restored
   -

   Monitor may be misdetected or not reinitialized correctly

------------------------------
=F0=9F=A7=AA Workaround behavior

   -

   Disabling the phantom output (DVI-D-1) restores the display immediately
   -

   Forcing HDMI-A-0 as primary also helps reinitialize the session
   -

   Disabling automatic screen-off (DPMS) avoids the issue entirely

------------------------------
=F0=9F=A7=A0 Interpretation

This suggests the problem is not strictly related to suspend, but more
generally to *display reinitialization after power state transitions*,
including:

   -

   suspend/resume (deep)
   -

   screen power off/on (DPMS)

Given that both paths trigger similar failures, this may point to issues in=
:

   -

   EDID re-read after power events
   -

   HDMI link training
   -

   atomic modeset state reconstruction
   -

   DC state restore

------------------------------
=F0=9F=92=A1 Conclusion

The bisected commit may still represent a valid trigger point, but the root
cause appears to be related to how display state is restored after power
transitions, rather than suspend alone.
------------------------------
=F0=9F=93=8E Additional notes

   -

   Wayland still does not show the same hard failure
   -

   Issue remains reproducible
   -

   Workarounds are consistent

------------------------------

I hope this additional information helps narrow down the issue further.

Please let me know if I can assist with more testing.

Thanks again for your time and your work.

Best regards,
Danilo


Em dom., 29 de mar. de 2026 =C3=A0s 13:34, Danilo Machado <
danilomachado2002@gmail.com> escreveu:

> Hi all,
>
> I=E2=80=99d like to provide a final update on this regression affecting A=
MD Radeon
> R9 380 (Tonga), which I bisected earlier between Linux 6.3 (good) and 6.4
> (bad).
>
> After further investigation, I was able to isolate the issue more
> precisely and identify a reliable workaround.
>
> =F0=9F=94=8D Summary:
>
> After suspend/resume under X11:
>
>    -
>
>    HDMI monitor is physically connected and EDID is valid
>    -
>
>    Kernel (DRM) correctly detects the HDMI connector
>    -
>
>    However, X11 ends up with an inconsistent display state
>
> Observed behavior:
>
>    -
>
>    HDMI-A-0 is active at correct resolution (1920x1080)
>    -
>
>    A phantom output (DVI-D-1) appears as connected
>    -
>
>    DVI-D-1 is incorrectly set as primary at 640x480
>    -
>
>    Desktop becomes corrupted (missing panels, apps failing, incorrect
>    layout)
>
> xrandr example after resume:
>
> HDMI-A-0 connected 1920x1080+0+0
> DVI-D-1 connected primary 640x480+1920+116
>
> =F0=9F=A7=A0 Key finding:
>
> The issue is not EDID or link training. EDID is readable and valid.
>
> This appears to be a failure in atomic modeset / connector-to-CRTC mappin=
g
> during resume, leading to an incorrect fallback output being selected as
> primary.
>
> =F0=9F=92=A1 Workaround (100% reproducible fix):
>
> Running the following immediately restores the system:
>
> xrandr --output DVI-D-1 --off
> xrandr --output HDMI-A-0 --primary --mode 1920x1080
>
> This strongly suggests that the correct state exists but is not applied
> automatically after resume.
>
> =E2=9A=99=EF=B8=8F Additional observations:
>
>    -
>
>    Wayland does not exhibit the same failure (likely due to dynamic state
>    handling)
>    -
>
>    Issue reproducible only on 6.4+
>    -
>
>    s2idle reduces severity but does not fix the issue
>    -
>
>    amdgpu.dc=3D0 makes the system fully unusable after resume
>
> =F0=9F=A7=AA Bisect:
>
> First bad commit:
> b3c98052d46948a8d65d2778c7f306ff38366aac (KVM merge)
>
> This likely indicates an indirect trigger (timing/order change during
> resume), not a direct amdgpu change.
>
> =F0=9F=93=8E Logs and details available upon request.
>
> =F0=9F=99=8F I=E2=80=99m happy to test patches or provide additional debu=
g information.
>
> Thanks for your time and for maintaining amdgpu.
>
> Best regards,
> Danilo
>
> Em dom., 29 de mar. de 2026 =C3=A0s 10:35, Danilo Machado <
> danilomachado2002@gmail.com> escreveu:
>
>> Also reported on GitLab:
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/5123
>>
>> Em dom., 29 de mar. de 2026 =C3=A0s 09:47, Danilo Machado <
>> danilomachado2002@gmail.com> escreveu:
>>
>>> Additional testing:
>>>
>>> I tested with amdgpu.dc=3D0 to disable Display Core.
>>>
>>> Result:
>>> - system becomes completely unresponsive after resume
>>> - black screen, no input response
>>>
>>> This suggests the issue is not limited to Display Core (DC),
>>> but likely affects the core GPU resume path.
>>>
>>> With DC enabled:
>>> - partial recovery (corrupted display, EDID failure)
>>>
>>> With DC disabled:
>>> - complete failure
>>>
>>> This reinforces that the regression is deeper in the amdgpu resume
>>> sequence.
>>>
>>> Em sex., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado <
>>> danilomachado2002@gmail.com> escreveu:
>>>
>>>> Additional data (resume failure analysis)
>>>>
>>>> Hardware:
>>>> - GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>>>> - CPU: AMD Ryzen 5 5500
>>>> - RAM: 16 GB
>>>> - Display: HDMI
>>>>
>>>> Software:
>>>> - Kernel: 6.8.0-106-generic
>>>> - Driver: amdgpu
>>>> - Display server: X11 (issue reproducible), Wayland (no hard failure)
>>>>
>>>> ---
>>>>
>>>> Summary:
>>>>
>>>> After suspend/resume, HDMI output is not restored and the system may
>>>> freeze under X11.
>>>>
>>>> The issue is reproducible and was not present in Linux 6.3.
>>>>
>>>> ---
>>>>
>>>> Key observation:
>>>>
>>>> During resume, the driver fails to read EDID:
>>>>
>>>>     amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>>>>
>>>> This appears to explain why HDMI output is not restored.
>>>>
>>>> ---
>>>>
>>>> Relevant DRM / AMDGPU log excerpt:
>>>>
>>>> [drm] Display Core v3.2.266 initialized on DCE 10.0
>>>> amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
>>>> [drm] Initialized amdgpu 3.57.0 20150101 for 0000:01:00.0
>>>>
>>>> ---
>>>>
>>>> Analysis:
>>>>
>>>> - The failure occurs during display reinitialization after resume
>>>> - EDID read failure prevents proper HDMI modeset
>>>> - This aligns with the observed "no signal" condition
>>>>
>>>> Behavior differences:
>>>>
>>>> - deep sleep:
>>>>   - full GPU/display reinitialization
>>>>   - leads to EDID failure and system instability
>>>>
>>>> - s2idle:
>>>>   - partial resume
>>>>   - avoids full lockup but display may still be inconsistent
>>>>
>>>> This suggests the issue is in the display resume path, possibly
>>>> involving:
>>>>
>>>> - DC state restore
>>>> - HDMI link training
>>>> - DDC/EDID communication
>>>> - atomic modeset reconstruction
>>>>
>>>> ---
>>>>
>>>> Conclusion:
>>>>
>>>> This is likely a regression in the AMDGPU display resume path, where
>>>> EDID read fails after resume, preventing HDMI output from being restor=
ed.
>>>>
>>>> ---
>>>>
>>>> Additional notes:
>>>>
>>>> This issue was bisected between Linux 6.3 (good) and 6.4 (bad), with
>>>> the transition point identified as a KVM merge commit. While not direc=
tly
>>>> related to AMDGPU, it may have indirectly exposed this issue via
>>>> timing/order changes.
>>>>
>>>> ---
>>>>
>>>> If needed, I can provide:
>>>>
>>>> - full journalctl logs
>>>> - full bisect log
>>>> - additional testing (kernel params, debug options)
>>>> ------------------------------
>>>> *De:* Danilo Machado <danilomachado2002@hotmail.com>
>>>> *Enviado:* quinta-feira, 26 de mar=C3=A7o de 2026 20:38
>>>> *Para:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Alex Deucher <alexdeucher@gmail.com>;
>>>> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
>>>> *Assunto:* [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
>>>> suspend/resume
>>>>
>>>>
>>>> Hi all,
>>>>
>>>> Thanks again for your feedback.
>>>>
>>>> I took a closer look at the bisect results and system behavior, and I=
=E2=80=99d
>>>> like to provide a more complete and consolidated report.
>>>> ------------------------------
>>>>
>>>> Hardware:
>>>>
>>>>    -
>>>>
>>>>    GPU: AMD Radeon R9 380 (Tonga, GCN 3)
>>>>    -
>>>>
>>>>    CPU: AMD Ryzen 5 5500
>>>>    -
>>>>
>>>>    RAM: 16 GB
>>>>    -
>>>>
>>>>    Display: HDMI
>>>>
>>>> Software:
>>>>
>>>>    -
>>>>
>>>>    Driver: amdgpu
>>>>    -
>>>>
>>>>    Kernel range tested: 6.3 (good) =E2=86=92 6.4 (bad)
>>>>
>>>> ------------------------------
>>>>
>>>> Summary:
>>>>
>>>> This is a reproducible suspend/resume regression affecting HDMI output=
.
>>>>
>>>>    -
>>>>
>>>>    Linux 6.3 =E2=86=92 working correctly
>>>>    -
>>>>
>>>>    Linux 6.4+ =E2=86=92 regression present
>>>>
>>>> ------------------------------
>>>>
>>>> Behavior:
>>>>
>>>> After suspend/resume:
>>>>
>>>>    -
>>>>
>>>>    HDMI output does not recover ("no signal")
>>>>    -
>>>>
>>>>    System may freeze under X11
>>>>    -
>>>>
>>>>    Wayland does not show the same hard failure
>>>>
>>>> Additionally:
>>>>
>>>>    -
>>>>
>>>>    Using "deep" sleep:
>>>>    -
>>>>
>>>>       full system lockup after resume
>>>>       -
>>>>
>>>>    Using "s2idle":
>>>>    -
>>>>
>>>>       system resumes without hard lock
>>>>       -
>>>>
>>>>       however, graphical session may return in a partially broken stat=
e
>>>>
>>>> ------------------------------
>>>>
>>>> Bisect result:
>>>>
>>>> A full git bisect was performed between Linux 6.3 and 6.4.
>>>>
>>>> First bad commit:
>>>> b3c98052d46948a8d65d2778c7f306ff38366aac
>>>> ("Merge tag 'kvm-x86-vmx-6.4'")
>>>>
>>>> All intermediate commits in that range were consistently tested as GOO=
D.
>>>> ------------------------------
>>>>
>>>> Analysis:
>>>>
>>>> Although the bisected commit is in KVM and unlikely to directly affect
>>>> AMDGPU, the transition point is consistent and reproducible.
>>>>
>>>> This suggests the regression may be indirectly triggered (e.g. timing
>>>> or ordering changes during resume), rather than caused directly by tha=
t
>>>> merge.
>>>>
>>>> Based on observed behavior, this appears related to the display resume
>>>> path, possibly involving:
>>>>
>>>>    -
>>>>
>>>>    DC state restore after resume
>>>>    -
>>>>
>>>>    HDMI link training
>>>>    -
>>>>
>>>>    EDID re-read
>>>>    -
>>>>
>>>>    atomic modeset state reconstruction
>>>>
>>>> The difference between "deep" and "s2idle" also suggests a failure
>>>> during full GPU/display reinitialization.
>>>> ------------------------------
>>>>
>>>> Conclusion:
>>>>
>>>> This appears to be a latent issue exposed by changes introduced during
>>>> the 6.4 merge window, rather than a direct regression in the bisected
>>>> commit itself.
>>>> ------------------------------
>>>>
>>>> If helpful, I can assist further by:
>>>>
>>>>    -
>>>>
>>>>    providing full bisect logs
>>>>    -
>>>>
>>>>    capturing detailed dmesg/journalctl before and after resume
>>>>    -
>>>>
>>>>    testing patches or debug options
>>>>    -
>>>>
>>>>    narrowing the range further if needed
>>>>
>>>> I really appreciate the work on AMDGPU and would be glad to help withi=
n
>>>> my limits to investigate this further.
>>>>
>>>> Thanks again for your time.
>>>>
>>>> Best regards,
>>>> Danilo
>>>> Note: I had some email client configuration issues earlier, which may
>>>> have caused duplicate messages or formatting problems. These have now =
been
>>>> resolved =E2=80=94 apologies for any inconvenience.
>>>>
>>>>
>>>
>>> --
>>> *Danilo Machado*
>>>
>>
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

--000000000000090ca7064e308705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif"><p>Hi all,</p><p>I would like to share an important update base=
d on further testing.</p><p>After implementing a temporary workaround, I no=
ticed that the issue is not limited to suspend/resume. There is a second tr=
igger that seems to affect the same underlying problem.</p><h3>=F0=9F=94=8D=
 Additional trigger identified (DPMS / screen off)</h3><p>Sequence:</p><ol>=
<li><p>System resumes from suspend =E2=86=92 works correctly (login screen =
appears)</p></li><li><p>System becomes idle =E2=86=92 screen turns off (DPM=
S)</p></li><li><p>Upon user interaction (keyboard/mouse), the display fails=
 to wake properly</p></li></ol><h3>Observed behavior:</h3><ul><li><p>Black =
screen or no signal</p></li><li><p>System remains responsive (can sometimes=
 type blindly)</p></li><li><p>In some cases, session becomes partially corr=
upted</p></li></ul><h3>Important detail:</h3><p>This behavior is very simil=
ar to what happens after suspend/resume:</p><ul><li><p>HDMI link is not pro=
perly restored</p></li><li><p>Monitor may be misdetected or not reinitializ=
ed correctly</p></li></ul><hr><h3>=F0=9F=A7=AA Workaround behavior</h3><ul>=
<li><p>Disabling the phantom output (DVI-D-1) restores the display immediat=
ely</p></li><li><p>Forcing HDMI-A-0 as primary also helps reinitialize the =
session</p></li><li><p>Disabling automatic screen-off (DPMS) avoids the iss=
ue entirely</p></li></ul><hr><h3>=F0=9F=A7=A0 Interpretation</h3><p>This su=
ggests the problem is not strictly related to suspend, but more generally t=
o <strong>display reinitialization after power state transitions</strong>, =
including:</p><ul><li><p>suspend/resume (deep)</p></li><li><p>screen power =
off/on (DPMS)</p></li></ul><p>Given that both paths trigger similar failure=
s, this may point to issues in:</p><ul><li><p>EDID re-read after power even=
ts</p></li><li><p>HDMI link training</p></li><li><p>atomic modeset state re=
construction</p></li><li><p>DC state restore</p></li></ul><hr><h3>=F0=9F=92=
=A1 Conclusion</h3><p>The bisected commit may still represent a valid trigg=
er point, but the root cause appears to be related to how display state is =
restored after power transitions, rather than suspend alone.</p><hr><h3>=F0=
=9F=93=8E Additional notes</h3><ul><li><p>Wayland still does not show the s=
ame hard failure</p></li><li><p>Issue remains reproducible</p></li><li><p>W=
orkarounds are consistent</p></li></ul><hr><p>I hope this additional inform=
ation helps narrow down the issue further.</p><p>Please let me know if I ca=
n assist with more testing.</p><p>Thanks again for your time and your work.=
</p><p>Best regards,<br>Danilo</p><br></div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Em dom., =
29 de mar. de 2026 =C3=A0s 13:34, Danilo Machado &lt;<a href=3D"mailto:dani=
lomachado2002@gmail.com">danilomachado2002@gmail.com</a>&gt; escreveu:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><p>Hi al=
l,</p><p>I=E2=80=99d like to provide a final update on this regression affe=
cting AMD Radeon R9 380 (Tonga), which I bisected earlier between Linux 6.3=
 (good) and 6.4 (bad).</p><p>After further investigation, I was able to iso=
late the issue more precisely and identify a reliable workaround.</p><p>=F0=
=9F=94=8D Summary:</p><p>After suspend/resume under X11:</p><ul><li><p>HDMI=
 monitor is physically connected and EDID is valid</p></li><li><p>Kernel (D=
RM) correctly detects the HDMI connector</p></li><li><p>However, X11 ends u=
p with an inconsistent display state</p></li></ul><p>Observed behavior:</p>=
<ul><li><p>HDMI-A-0 is active at correct resolution (1920x1080)</p></li><li=
><p>A phantom output (DVI-D-1) appears as connected</p></li><li><p>DVI-D-1 =
is incorrectly set as primary at 640x480</p></li><li><p>Desktop becomes cor=
rupted (missing panels, apps failing, incorrect layout)</p></li></ul><p>xra=
ndr example after resume:</p><p>HDMI-A-0 connected 1920x1080+0+0<br>DVI-D-1=
 connected primary 640x480+1920+116</p><p>=F0=9F=A7=A0 Key finding:</p><p>T=
he issue is not EDID or link training. EDID is readable and valid.</p><p>Th=
is appears to be a failure in atomic modeset / connector-to-CRTC mapping du=
ring resume, leading to an incorrect fallback output being selected as prim=
ary.</p><p>=F0=9F=92=A1 Workaround (100% reproducible fix):</p><p>Running t=
he following immediately restores the system:</p><p>xrandr --output DVI-D-1=
 --off<br>xrandr --output HDMI-A-0 --primary --mode 1920x1080</p><p>This st=
rongly suggests that the correct state exists but is not applied automatica=
lly after resume.</p><p>=E2=9A=99=EF=B8=8F Additional observations:</p><ul>=
<li><p>Wayland does not exhibit the same failure (likely due to dynamic sta=
te handling)</p></li><li><p>Issue reproducible only on 6.4+</p></li><li><p>=
s2idle reduces severity but does not fix the issue</p></li><li><p>amdgpu.dc=
=3D0 makes the system fully unusable after resume</p></li></ul><p>=F0=9F=A7=
=AA Bisect:</p><p>First bad commit:<br>b3c98052d46948a8d65d2778c7f306ff3836=
6aac (KVM merge)</p><p>This likely indicates an indirect trigger (timing/or=
der change during resume), not a direct amdgpu change.</p><p>=F0=9F=93=8E L=
ogs and details available upon request.</p><p>=F0=9F=99=8F I=E2=80=99m happ=
y to test patches or provide additional debug information.</p><p>Thanks for=
 your time and for maintaining amdgpu.</p><p>Best regards,<br>Danilo</p></d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">Em dom., 29 de mar. de 2026 =C3=A0s 10:35, Danilo Machado &lt;<a href=3D=
"mailto:danilomachado2002@gmail.com" target=3D"_blank">danilomachado2002@gm=
ail.com</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-fami=
ly:verdana,sans-serif">Also reported on GitLab:<br><a href=3D"https://gitla=
b.freedesktop.org/drm/amd/-/work_items/5123" target=3D"_blank">https://gitl=
ab.freedesktop.org/drm/amd/-/work_items/5123</a></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Em dom., 29 de mar. =
de 2026 =C3=A0s 09:47, Danilo Machado &lt;<a href=3D"mailto:danilomachado20=
02@gmail.com" target=3D"_blank">danilomachado2002@gmail.com</a>&gt; escreve=
u:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">A=
dditional testing:<br><br>I tested with amdgpu.dc=3D0 to disable Display Co=
re.<br><br>Result:<br>- system becomes completely unresponsive after resume=
<br>- black screen, no input response<br><br>This suggests the issue is not=
 limited to Display Core (DC),<br>but likely affects the core GPU resume pa=
th.<br><br>With DC enabled:<br>- partial recovery (corrupted display, EDID =
failure)<br><br>With DC disabled:<br>- complete failure<br><br>This reinfor=
ces that the regression is deeper in the amdgpu resume sequence.</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Em se=
x., 27 de mar. de 2026 =C3=A0s 21:14, Danilo Machado &lt;<a href=3D"mailto:=
danilomachado2002@gmail.com" target=3D"_blank">danilomachado2002@gmail.com<=
/a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div style=3D"font-family:Calibri,Helvetica,sans-serif,s=
erif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Additional data (resume fai=
lure analysis)</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,=
serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"fo=
nt-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color=
:rgb(0,0,0)">Hardware:</div><div style=3D"font-family:Calibri,Helvetica,san=
s-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- GPU: AMD Radeon =
R9 380 (Tonga, GCN 3)</div><div style=3D"font-family:Calibri,Helvetica,sans=
-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- CPU: AMD Ryzen 5 =
5500</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emoj=
iFont;font-size:12pt;color:rgb(0,0,0)">- RAM: 16 GB</div><div style=3D"font=
-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">- Display: HDMI</div><div style=3D"font-family:Calibri,Helvetica=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div=
 style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">Software:</div><div style=3D"font-family:Calibri,H=
elvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- Kern=
el: 6.8.0-106-generic</div><div style=3D"font-family:Calibri,Helvetica,sans=
-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- Driver: amdgpu</d=
iv><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;f=
ont-size:12pt;color:rgb(0,0,0)">- Display server: X11 (issue reproducible),=
 Wayland (no hard failure)</div><div style=3D"font-family:Calibri,Helvetica=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div=
 style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-siz=
e:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-family:Calibri,Helveti=
ca,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><d=
iv style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">Summary:</div><div style=3D"font-family:Calibri,=
Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br><=
/div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont=
;font-size:12pt;color:rgb(0,0,0)">After suspend/resume, HDMI output is not =
restored and the system may freeze under X11.</div><div style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif=
,EmojiFont;font-size:12pt;color:rgb(0,0,0)">The issue is reproducible and w=
as not present in Linux 6.3.</div><div style=3D"font-family:Calibri,Helveti=
ca,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><d=
iv style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">---</div><div style=3D"font-family:Calibri,Helve=
tica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div>=
<div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font=
-size:12pt;color:rgb(0,0,0)">Key observation:</div><div style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif=
,EmojiFont;font-size:12pt;color:rgb(0,0,0)">During resume, the driver fails=
 to read EDID:</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,=
serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"fo=
nt-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color=
:rgb(0,0,0)">=C2=A0 =C2=A0 amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.=
</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Cali=
bri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">T=
his appears to explain why HDMI output is not restored.</div><div style=3D"=
font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;col=
or:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">---</div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Relevant DRM / AM=
DGPU log excerpt:</div><div style=3D"font-family:Calibri,Helvetica,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D=
"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">[drm] Display Core v3.2.266 initialized on DCE 10.0</div><d=
iv style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.=
</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">[drm] Initialized amdgpu 3.57.0 20150101=
 for 0000:01:00.0</div><div style=3D"font-family:Calibri,Helvetica,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D=
"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;co=
lor:rgb(0,0,0)">---</div><div style=3D"font-family:Calibri,Helvetica,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">Analysis:</div><div style=3D"font-family:Calibri,Helveti=
ca,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><d=
iv style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-s=
ize:12pt;color:rgb(0,0,0)">- The failure occurs during display reinitializa=
tion after resume</div><div style=3D"font-family:Calibri,Helvetica,sans-ser=
if,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- EDID read failure pre=
vents proper HDMI modeset</div><div style=3D"font-family:Calibri,Helvetica,=
sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- This aligns w=
ith the observed &quot;no signal&quot; condition</div><div style=3D"font-fa=
mily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(=
0,0,0)"><br></div><div style=3D"font-family:Calibri,Helvetica,sans-serif,se=
rif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Behavior differences:</div><=
div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-=
size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-family:Calibri,Hel=
vetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- deep s=
leep:</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - full GPU/display reinitial=
ization</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,E=
mojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - leads to EDID failure an=
d system instability</div><div style=3D"font-family:Calibri,Helvetica,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">- s2idle:</div><div style=3D"font-family:Calibri,Helveti=
ca,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - par=
tial resume</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,ser=
if,EmojiFont;font-size:12pt;color:rgb(0,0,0)">=C2=A0 - avoids full lockup b=
ut display may still be inconsistent</div><div style=3D"font-family:Calibri=
,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br>=
</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">This suggests the issue is in the displa=
y resume path, possibly involving:</div><div style=3D"font-family:Calibri,H=
elvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></=
div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;=
font-size:12pt;color:rgb(0,0,0)">- DC state restore</div><div style=3D"font=
-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:r=
gb(0,0,0)">- HDMI link training</div><div style=3D"font-family:Calibri,Helv=
etica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- DDC/EDI=
D communication</div><div style=3D"font-family:Calibri,Helvetica,sans-serif=
,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">- atomic modeset reconstr=
uction</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Em=
ojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-famil=
y:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0=
,0)">---</div><div style=3D"font-family:Calibri,Helvetica,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0=
,0,0)">Conclusion:</div><div style=3D"font-family:Calibri,Helvetica,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)"><br></div><div style=
=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt=
;color:rgb(0,0,0)">This
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
872166646969592048m_8254164770234675366m_4916195300917595998m_3557920322715=
242118m_3075601443013613040gmail-x_appendonsend"></div><hr style=3D"display=
:inline-block;width:98%"><div id=3D"m_872166646969592048m_82541647702346753=
66m_4916195300917595998m_3557920322715242118m_3075601443013613040gmail-x_di=
vRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" color=3D"#00000=
0" style=3D"font-size:11pt"><b>De:</b> Danilo Machado &lt;<a href=3D"mailto=
:danilomachado2002@hotmail.com" target=3D"_blank">danilomachado2002@hotmail=
.com</a>&gt;<br><b>Enviado:</b> quinta-feira, 26 de mar=C3=A7o de 2026 20:3=
8<br><b>Para:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=
=3D"_blank">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx=
@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>=
&gt;<br><b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com=
" target=3D"_blank">alexdeucher@gmail.com</a>&gt;; <a href=3D"mailto:dri-de=
vel@lists.freedesktop.org" target=3D"_blank">dri-devel@lists.freedesktop.or=
g</a> &lt;<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_bla=
nk">dri-devel@lists.freedesktop.org</a>&gt;<br><b>Assunto:</b> [REGRESSION]=
[bisected] amdgpu/tonga: HDMI no signal after suspend/resume</font> <div ar=
ia-hidden=3D"true">=C2=A0</div></div><div dir=3D"ltr"><p style=3D"margin-to=
p:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-=
serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Hi all,</span></p><p=
 style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">T=
hanks again for your feedback.</span></p><p style=3D"margin-top:1em;margin-=
bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,E=
mojiFont;font-size:12pt;color:rgb(0,0,0)">I took a closer look at the bisec=
t results and system behavior, and I=E2=80=99d like to provide a more compl=
ete and consolidated report.</span></p><hr><p style=3D"margin-top:1em;margi=
n-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif=
,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Hardware:</span></p><ul><li sty=
le=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0=
,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">GP=
U: AMD Radeon R9 380 (Tonga, GCN 3)</p></li><li style=3D"font-family:Calibr=
i,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presenta=
tion" style=3D"margin-top:1em;margin-bottom:1em">CPU: AMD Ryzen 5 5500</p><=
/li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bot=
tom:1em">RAM: 16 GB</p></li><li style=3D"font-family:Calibri,Helvetica,sans=
-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"m=
argin-top:1em;margin-bottom:1em">Display: HDMI</p></li></ul><p style=3D"mar=
gin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica=
,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Software:</spa=
n></p><ul><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:1=
2pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;marg=
in-bottom:1em">Driver: amdgpu</p></li><li style=3D"font-family:Calibri,Helv=
etica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" =
style=3D"margin-top:1em;margin-bottom:1em">Kernel range tested: 6.3 (good) =
=E2=86=92 6.4 (bad)</p></li></ul><hr><p style=3D"margin-top:1em;margin-bott=
om:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emoji=
Font;font-size:12pt;color:rgb(0,0,0)">Summary:</span></p><p style=3D"margin=
-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sa=
ns-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">This is a reprodu=
cible suspend/resume regression affecting HDMI output.</span></p><ul><li st=
yle=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,=
0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">L=
inux 6.3 =E2=86=92 working correctly</p></li><li style=3D"font-family:Calib=
ri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"present=
ation" style=3D"margin-top:1em;margin-bottom:1em">Linux 6.4+ =E2=86=92 regr=
ession present</p></li></ul><hr><p style=3D"margin-top:1em;margin-bottom:1e=
m"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFont;=
font-size:12pt;color:rgb(0,0,0)">Behavior:</span></p><p style=3D"margin-top=
:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-s=
erif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">After suspend/resume:=
</span></p><ul><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em=
;margin-bottom:1em">HDMI output does not recover (&quot;no signal&quot;)</p=
></li><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;=
color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;margin-b=
ottom:1em">System may freeze under X11</p></li><li style=3D"font-family:Cal=
ibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"prese=
ntation" style=3D"margin-top:1em;margin-bottom:1em">Wayland does not show t=
he same hard failure</p></li></ul><p style=3D"margin-top:1em;margin-bottom:=
1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,EmojiFon=
t;font-size:12pt;color:rgb(0,0,0)">Additionally:</span></p><ul><li style=3D=
"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<p role=3D"presentation" style=3D"margin-top:1em;margin-bottom:1em">Using &=
quot;deep&quot; sleep:</p></li><ul><li style=3D"font-family:Calibri,Helveti=
ca,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" sty=
le=3D"margin-top:1em;margin-bottom:1em">full system lockup after resume</p>=
</li></ul><li style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:1=
2pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margin-top:1em;marg=
in-bottom:1em">Using &quot;s2idle&quot;:</p></li><ul><li style=3D"font-fami=
ly:Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><p role=3D=
"presentation" style=3D"margin-top:1em;margin-bottom:1em">system resumes wi=
thout hard lock</p></li><li style=3D"font-family:Calibri,Helvetica,sans-ser=
if;font-size:12pt;color:rgb(0,0,0)"><p role=3D"presentation" style=3D"margi=
n-top:1em;margin-bottom:1em">however, graphical session may return in a par=
tially broken state</p></li></ul></ul><hr><p style=3D"margin-top:1em;margin=
-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,=
EmojiFont;font-size:12pt;color:rgb(0,0,0)">Bisect result:</span></p><p styl=
e=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,H=
elvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">A full=
 git bisect was performed between Linux 6.3 and 6.4.</span></p><p style=3D"=
margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvet=
ica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">First bad c=
ommit:<br>b3c98052d46948a8d65d2778c7f306ff38366aac<br>(&quot;Merge tag &#39=
;kvm-x86-vmx-6.4&#39;&quot;)</span></p><p style=3D"margin-top:1em;margin-bo=
ttom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-serif,serif,Emo=
jiFont;font-size:12pt;color:rgb(0,0,0)">All intermediate commits in that ra=
nge were consistently tested as GOOD.</span></p><hr><p style=3D"margin-top:=
1em;margin-bottom:1em"><span style=3D"font-family:Calibri,Helvetica,sans-se=
rif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">Analysis:</span></p><p=
 style=3D"margin-top:1em;margin-bottom:1em"><span style=3D"font-family:Cali=
bri,Helvetica,sans-serif,serif,EmojiFont;font-size:12pt;color:rgb(0,0,0)">A=
lthough
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
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><i style=3D"background-color:rgb(255,255,255)">Danilo Machad=
o</i></div></div>

--000000000000090ca7064e308705--
