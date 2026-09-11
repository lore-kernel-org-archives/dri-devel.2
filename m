Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34738C88E6B
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F269D10E9CF;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=est.una.ac.cr header.i=@est.una.ac.cr header.b="VXcnwX7e";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3F210E38F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:11:47 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c253425b253so234384166b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789164706; cv=none;
 d=google.com; s=arc-20260327;
 b=rb975AjK94tjbqHA/OBBlosALX4w9lx9yeYqyxnJSWWeRJX8hLwKMWjVXo0EoK1juK
 zu2io2Nj91Zb0l1qJ4CfbMmzonLfTchCVhYqGHDEt1WaoA1LEVsB+2CPOoGgcytHxSIp
 UmkH5q+B4V8eDQmjYolrEByqmIA9SJgNnEfuMD/d55ZFJBOQH4AVndbsFR+OqLhY5Aov
 tjJHLguHrQ648u3Voevq2TiCN9I8fYHRdbFC7C49oRZJFvvTrEE623PDJ3IfOw8mr1e7
 uBi5tUrt7wIYiaal4cHhWsFwWwwPOCyS3S/a3n/9iMBMwOgUjjUgn/1HvBScYFZ4hZZR
 HgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=jmcmRooIJWZcfOxhhMxU11ULm5mq/IM7NKssWyEliKc=;
 fh=VV0FEYB2pGGJVedsOwKe8LH0NBp1Xb5mXhuo01Owq9w=;
 b=YPNP00uFA/Ltn02nGtP2W2sqV+OEwZhTNb/fsezsS4akyY0TLeOVYTvJxl4vT8LvEM
 smOIb3Vj8Zn1xoVdbrM8XnxO/G2H+6gb+FXv9mB2QWjGw3Lgk9q2pNRHGFj+b475Pfa7
 19oYyy9qgK638OmI7qYsFldo5/W/bOJObHGtu6TuO9BS088CjPipZMOtfj7BMI8fIKSj
 TeU6VgPqM0B/k7hlXZGXNE8U+pQwFRVkSnynveod+M+7JHSRjyyPD5EQk0aHOqdWkMVu
 1CQf5HjvVkXK2LiCv3UzV/oAKXhxzMiF/61pwJQwYvPdmVXgP1boFBMaGIz6gIwJysgl
 VvEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=est.una.ac.cr; s=google; t=1789164706; x=1789769506;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jmcmRooIJWZcfOxhhMxU11ULm5mq/IM7NKssWyEliKc=;
 b=VXcnwX7eSkOw4iJXob04MudGaqFko9Wf7+Itg3RSBLEZdOLVLmbxNm3rtyZDypafMB
 rBwtiUO6eJneDd0bC5PTKUoFQ35aMv0tzKaC3j/1A2xwTxoBLRitTsTO61sjVZ/dEnhP
 SViCas3txSenCSyBLOShL0bVNNv3W82fs2Rw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164706; x=1789769506;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jmcmRooIJWZcfOxhhMxU11ULm5mq/IM7NKssWyEliKc=;
 b=mZ7sdcCZjOnkgVX532irssbtf7KytimLFKJlez1dR4VPuXZPg1jLPKJ/YG4IhiRW6F
 rGYET86dyZbs0GAKuMr6PW+btDSmceeYkLWPBKgncvG1TXX+BgS8Ri0phCC4MU/pkWzv
 EPNO4ExGbg2DmzgMSaJufnj9IYRHUUMBK3fHk0nC5NNfNeZ987FX9Bd4YRhv9hDxQLRk
 eUzrQRAC/zLOO2PNE+gFXIgG2OwNi5B1hF04yEQIHkaLPa1GUnnLstAWUlgguUsov8pf
 099Wld9jWF377+p6g9DcHoYV9hcQd1MiwpG0ikY3xIPxzVLKAn5MVq8n0dE/0abDqWLn
 b7vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBysUHs+mG4/vD1AU7oqPRUZV8SbObX418Qq166RWIUJ7L/RilpmPv0Zfoz/3WxCro/jI1Qn+L0phKE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kaP2Z7u5HMCbQIh6QMBTQT1JYpm8XV/gLuaP1R2nmNijbKxxXc
 F0+RZSLwi12+QztyOj1IDI+8Aj5m/DM0lB7vx4JZeHIP1pd5R3FVn7W0eeEZ9lp81P7RBEfKdxz
 /jTa/Zg2BodN5Zijy6A05hfnCyAHuIHFqDmrD537YhQ==
X-Gm-Gg: AYBFou1O4JhRQMHJaVGpsZaWQLN7VoHFd1Fbwl0M2L9ImU9wAb6mlAibGHcXl0gemP4
 Z78YVbvRzuL/0djHPBTyLOBjksV4TutgrYziwlMR4QuUULZYVjErmBUGMY2DqlLeEil2bCIKn3u
 2e0gGJbPB08GqpgoFQoKrlOm9i/8kri6yNF1fdfChfWHzkxaYTqmx2ItYiVmHiHcvxI8sRh6Nna
 bhai2C3HZVMxwJ2MWtGpcP6k2AOlV5P7u7po0Gd9ansYp4cXPFFiWNvzVVp2arfT0Kvn/+r4why
 D3fpCMmPX3MFtD7kQCWLeFScTDLNdsGwv0mi9HHAvwRbmDvIPdri1gGDaIn3uGqym3IX43Lvyiq
 SbNVApfEDTL0=
X-Received: by 2002:a17:907:1c10:b0:c29:286e:2e3e with SMTP id
 a640c23a62f3a-c29666d5f9dmr280604466b.38.1789164706055; Fri, 11 Sep 2026
 15:11:46 -0700 (PDT)
MIME-Version: 1.0
From: Avalon Vargas Centeno <avalon.vargas.centeno@est.una.ac.cr>
Date: Fri, 11 Sep 2026 16:11:34 -0600
X-Gm-Features: AcwNN1UKz1EzNqNrYibLG4EW7is5QWZ2Va82YNgb4e5YpYrggY_-TnFTnLexsys
Message-ID: <CAGXpr54Bn9Wf24asY2RcXgBNLy1A16=U1mtFx7mKeNK4CCOCYQ@mail.gmail.com>
Subject: [RFC] Dell Inspiron 7441 AUO0BA4 panel backlight: PWM configuration
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 val@packett.cool, bryan.odonoghue@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Hello,

On my Dell Inspiron 14 Plus 7441 (BIOS 2.16.0, aarch64 Linux 7.2.4,
NixOS), the AUO B140QAX01.H / AUO0BA4 panel originally exposed an unusable
dp_aux_backlight with max_brightness 0. GNOME could not adjust brightness.

Panel DPCD bytes at 0x700-0x72f:

  05 9b 91 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 02 00 0a 04 0a 00 1b 00 0d 2f 03 ff ff 03

The capability bits indicate PWM brightness setting rather than AUX
brightness setting. Inspection of the local panel-edp and DP helper code
suggests that this capability combination can leave the AUX backlight
maximum at zero. This is a code-path inference, not a separately verified
generic DRM driver bug.

A privileged GPIO snapshot showed PMK8550 GPIO5 already routed to func3
by firmware, with no Linux PWM provider registered. VREG_EDP_3P3 was enabled.

A local DT overlay enables pmk8550_pwm, configures PMK8550 GPIO5 func3,
adds a pwm-backlight using channel 0 and vreg_edp_3p3, and connects it to
the existing eDP panel. The existing panel enable GPIO is preserved.
The chosen period is 4266537 ns, borrowed from the upstream ThinkPad T14s
LCD setup; it is not a measured Dell firmware period. The brightness curve
is linear with 101 values and default index 80.

Validation status: the overlay compiled and applied, and its connection
was checked in the compiled DTB. Physical brightness adjustment and
suspend/resume have been tested successfully on this laptop. But I have not
measured the PWM waveform or tested other panel variants.

I can provide the small overlay and further test results. I would also
appreciate advice on the correct Dell PWM period and whether the
zero-range AUX backlight
behavior should be handled separately in the display helpers. Thanks
