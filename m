Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5EACD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7330210EA75;
	Sun,  7 Jun 2026 14:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o1Txqgk0";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E96E10E7C9
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 14:49:05 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-59eb501bcf0so926197e0c.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780757344; x=1781362144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:user-agent
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6b3/9+sKE91/xLaDS2FBfrL5fkMs4QYpx1KVanXFHVY=;
 b=o1Txqgk0wMA3n1qaGkvG82Itn8kzbra6eQIvg+gmr+zfetdd9XpiT/vVK3Xb1ZwSCT
 PZ7uGJ6Oat1nBVTqr+1Zz9YAvTHF3knC8Q28tWzL3dKTOZ1FZ3Y5uVNbY1Rt6CG4cKO8
 Lix47STDOuRZpmfPT0CbLQmjbn1qsYQ5O4G9ojMS5ndxzR89nhD06axEAd0FC/zHwgzw
 18f812XHr5TFSgmUkfmiiTNB8xfsG7/Xjpnqw2GJUIC4t8TRF4SaEKISn5qiH7ISRNnE
 moLjMKHb+tXYzNORgxvjxS5A7wuBAROAqQR5vCGCshV25L4wOPsqb4bZM8bqDia80K1L
 bMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780757344; x=1781362144;
 h=content-transfer-encoding:mime-version:message-id:user-agent
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6b3/9+sKE91/xLaDS2FBfrL5fkMs4QYpx1KVanXFHVY=;
 b=Y/bCT4GXXEV6bmLw2Iv7aMeHMLUfp4zFvgYBlxIZYt25k3U677PXvTsGmwC4E/u0P4
 fP5nzhxJXi0w3N+9btWHSS6blDP0iymTgqL2LRxuxYBRHEAEgVt/YtHhMONPHQ7M6CS4
 vJdpJZq0vTMaeHo+yXOAlr+BGnV7zroue8znEt6HgaWRZ+UBWjODQFMcx2/sJlmA9GcW
 bB/n6K0BKoSBc30RvDf7gUB0FBdOU1SYxVS5wgoKmAyhXP4OtTmVaaE3R7CqPLf/udao
 DTrHHSBDsAa0TEPUrvMe9pn6TKfIj0/uWsU9+nrICs80Ip/YLHw7Y6UVHRwnZLFnGmFO
 S6LA==
X-Gm-Message-State: AOJu0Yw7GPd5fRCio6M4OrVLC9I3/GSJ69+1gMgZKYZgtZOEI9MJ+hyL
 MNLmhByK2PQCMP37cTssd5/vBHY3i7pCdqXmk8cB+wmfHwjRuqvPhhhLM7B2Jw==
X-Gm-Gg: Acq92OFUe67m2LP1MhQzLot/BDUIgk75WVqHi7r5/eR9MuvCPsG7YqqCquiuWwy1cJQ
 R4ORp5hfdO9QEvT5VjjeA9b2a9Qg5sLBVuOBili0/3tKqBvRe6sK9v/Ee2ZeKAJBhIUj1+bRLHa
 Cw2ouSB2quTB1fa5z9gKuxidoVjERxliJJ4VkD7pIvgkMbTrENdWpcoPxtG0PWHc8R1W4UGsLpX
 0gY//YqPyZvC09GvF1wRLb+T/yf4gz/+631tXxGtpgENJlKEQGFfIu4OEWJEOARMwhKto8Onq3D
 6+CGXJUMq5m5+FcTUlKFvvIWSklZSt+ZNST1L3NRCdixpPFxwkx6bBG6qoVPz9F6GcyW42byAbc
 iUKRQLDOOW7V5sMe1pLTyj4Zd4M0tUq6KhHZUhERWVkiMevkuD95EHCPg5PphwsonV9RorLh6nN
 Cy02oOlpx0WeS4M3ZUqSOIqGzzkUVezHjwCslsqy74hyAKzE43HtywF+pyaM4=
X-Received: by 2002:a05:6122:6606:b0:5a3:5938:6935 with SMTP id
 71dfb90a1353d-5ac4dcf10e2mr3736068e0c.6.1780757343531; 
 Sat, 06 Jun 2026 07:49:03 -0700 (PDT)
Received: from ehlo.thunderbird.net ([152.250.14.125])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6dc44d233sm10169751e0c.10.2026.06.06.07.49.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2026 07:49:03 -0700 (PDT)
Date: Sat, 06 Jun 2026 11:49:01 -0300
From: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: =?US-ASCII?Q?No_display_initialisation_when_using_DRM=5F?=
 =?US-ASCII?Q?CLIENT=5FLOG_instead_of_DRM=5FFBDEV=5FEMULATION?=
User-Agent: K-9 Mail for Android
Message-ID: <82F211E7-560D-473D-8C1E-061AE85ADBD6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----5VTUTD0JVBUSSDSHUG47TZ89L9DTYJ
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

------5VTUTD0JVBUSSDSHUG47TZ89L9DTYJ
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I replaced DRM_FBDEV_EMULATION with DRM_CLIENT_LOG (DRM_CLIENT_DEFAULT=3D"=
log") on a kernel with DRM_PANIC enabled, using kmscon as the userspace ter=
minal=2E Nothing initialises the display after the native driver loads=2E

The result is a blank screen, no output at all from boot=2E DRM_CLIENT_LOG=
 (boot logs don't show up at all) and DRM_PANIC (forced a panic to try this=
 out) also don't work, since neither can render without an initialised disp=
lay=2E

This can be verified by checking "/sys/class/drm/card0-*/status" (all outp=
uts show "unknown") and "/sys/class/drm/card0-*/modes" (empty) after boot=
=2E
Writing "detect" to "/sys/class/drm/card0-HDMI-A-1/status" (or any output =
for that matter) resolves the issue, the connector is probed, modes are pop=
ulated, and kmscon can be started correctly=2E This suggests DRM_FBDEV_EMUL=
ATION previously triggered some display initialisation/probing during boot =
that is not happening with DRM_CLIENT_LOG=2E

I can't say if SIMPLEDRM (and SIMPLEFB) are affected, the result in my sys=
tem is a immediate blank screen and no signal, I don't know if its because =
the main graphics driver initialise very quickly during boot or if SIMPLEDR=
M is also affected=2E

Hardware: AMD RX 6600 XT (Navi23/AMDGPU), although I believe this affects =
any driver=2E
Kernel version: 7=2E0=2E11-gentoo
Config diff:

2849a2850
> # CONFIG_VGA_SWITCHEROO is not set
2874,2879c2875,2878
< CONFIG_DRM_FBDEV_EMULATION=3Dy
< CONFIG_DRM_FBDEV_OVERALLOC=3D100
< # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
< # CONFIG_DRM_CLIENT_LOG is not set
< CONFIG_DRM_CLIENT_DEFAULT_FBDEV=3Dy
< CONFIG_DRM_CLIENT_DEFAULT=3D"fbdev"
---
> # CONFIG_DRM_FBDEV_EMULATION is not set
> CONFIG_DRM_CLIENT_LOG=3Dy
> CONFIG_DRM_CLIENT_DEFAULT_LOG=3Dy
> CONFIG_DRM_CLIENT_DEFAULT=3D"log"
2978,2986d2976
< CONFIG_FB_CORE=3Dy
< # CONFIG_FB_DEVICE is not set
< CONFIG_FB_SYS_FILLRECT=3Dy
< CONFIG_FB_SYS_COPYAREA=3Dy
< CONFIG_FB_SYS_IMAGEBLIT=3Dy
< CONFIG_FB_SYSMEM_FOPS=3Dy
< CONFIG_FB_DEFERRED_IO=3Dy
< CONFIG_FB_SYSMEM_HELPERS=3Dy
< CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy
3021,3024d3010
< CONFIG_FRAMEBUFFER_CONSOLE=3Dy
< # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
< CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
< # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
3027d3012
< # CONFIG_LOGO is not set
4473d4457
< # CONFIG_FONT_SUN8x16 is not set



Guilherme B=2E
------5VTUTD0JVBUSSDSHUG47TZ89L9DTYJ
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><body><div dir=3D"auto">Hi!<br><br>I replaced DRM_FBDE=
V_EMULATION with DRM_CLIENT_LOG (DRM_CLIENT_DEFAULT=3D"log") on a kernel wi=
th DRM_PANIC enabled, using kmscon as the userspace terminal=2E Nothing ini=
tialises the display after the native driver loads=2E<br><br>The result is =
a blank screen, no output at all from boot=2E DRM_CLIENT_LOG (boot logs don=
't show up at all) and DRM_PANIC (forced a panic to try this out) also don'=
t work, since neither can render without an initialised display=2E<br><br>T=
his can be verified by checking "/sys/class/drm/card0-*/status" (all output=
s show "unknown") and "/sys/class/drm/card0-*/modes" (empty) after boot=2E<=
br>Writing "detect" to "/sys/class/drm/card0-HDMI-A-1/status" (or any outpu=
t for that matter) resolves the issue, the connector is probed, modes are p=
opulated, and kmscon can be started correctly=2E This suggests DRM_FBDEV_EM=
ULATION previously triggered some display initialisation/probing during boo=
t that is not happening with DRM_CLIENT_LOG=2E<br><br>I can't say if SIMPLE=
DRM (and SIMPLEFB) are affected, the result in my system is a immediate bla=
nk screen and no signal, I don't know if its because the main graphics driv=
er initialise very quickly during boot or if SIMPLEDRM is also affected=2E<=
br><br>Hardware: AMD RX 6600 XT (Navi23/AMDGPU), although I believe this af=
fects any driver=2E<br>Kernel version: 7=2E0=2E11-gentoo<br>Config diff:<br=
><br>2849a2850<br>&gt; # CONFIG_VGA_SWITCHEROO is not set<br>2874,2879c2875=
,2878<br>&lt; CONFIG_DRM_FBDEV_EMULATION=3Dy<br>&lt; CONFIG_DRM_FBDEV_OVERA=
LLOC=3D100<br>&lt; # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set<br>&lt; # C=
ONFIG_DRM_CLIENT_LOG is not set<br>&lt; CONFIG_DRM_CLIENT_DEFAULT_FBDEV=3Dy=
<br>&lt; CONFIG_DRM_CLIENT_DEFAULT=3D"fbdev"<hr>&gt; # CONFIG_DRM_FBDEV_EMU=
LATION is not set<br>&gt; CONFIG_DRM_CLIENT_LOG=3Dy<br>&gt; CONFIG_DRM_CLIE=
NT_DEFAULT_LOG=3Dy<br>&gt; CONFIG_DRM_CLIENT_DEFAULT=3D"log"<br>2978,2986d2=
976<br>&lt; CONFIG_FB_CORE=3Dy<br>&lt; # CONFIG_FB_DEVICE is not set<br>&lt=
; CONFIG_FB_SYS_FILLRECT=3Dy<br>&lt; CONFIG_FB_SYS_COPYAREA=3Dy<br>&lt; CON=
FIG_FB_SYS_IMAGEBLIT=3Dy<br>&lt; CONFIG_FB_SYSMEM_FOPS=3Dy<br>&lt; CONFIG_F=
B_DEFERRED_IO=3Dy<br>&lt; CONFIG_FB_SYSMEM_HELPERS=3Dy<br>&lt; CONFIG_FB_SY=
SMEM_HELPERS_DEFERRED=3Dy<br>3021,3024d3010<br>&lt; CONFIG_FRAMEBUFFER_CONS=
OLE=3Dy<br>&lt; # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set=
<br>&lt; CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy<br>&lt; # CONFIG_FRA=
MEBUFFER_CONSOLE_ROTATION is not set<br>3027d3012<br>&lt; # CONFIG_LOGO is =
not set<br>4473d4457<br>&lt; # CONFIG_FONT_SUN8x16 is not set<br><br><br></=
div><div dir=3D"auto">Guilherme B=2E</div></body></html>
------5VTUTD0JVBUSSDSHUG47TZ89L9DTYJ--
