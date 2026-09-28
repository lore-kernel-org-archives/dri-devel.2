Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA33CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACD310ED90;
	Tue, 29 Sep 2026 08:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjBXjQSk";
	dkim-atps=neutral
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A5410EAF0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:15:45 +0000 (UTC)
Received: by mail-oi2-f7.google.com with SMTP id
 5614622812f47-4b39374fab5so1125285b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612145; cv=none;
 d=google.com; s=arc-20260327;
 b=AyKZui0MMPx3j2jfly5qEGQKRiSyrBytoZOfU1cVhb58XDNrMSImytvSNCedPN3reA
 upucu75Bq5plWBghZ4V4dn4xMBJDMrt5NtkwX8XBSawjJx8D8N0aEAGykYr0n4CVnoGW
 6gpfUKvVtIeb8OKKiSeXtlohTSre5Pfj/IxBhxJnv2jdhLaZPUE9hsOkZkYIYLrh8Sd4
 8TwBqFagjoR0oicgWMxHI6QkKhiezsHjWoF729Dt+Zw2NgLjK5VdTdA2OO67swrnDTj9
 jhmyhKvcv1DpQnoZJsdBULs1hjTuqZvlxMIuhLx7lqP6oWBbgR7eWLFja/CV1tOTrmdE
 f9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
 fh=8N5FwqwpnvsIhHErqQPk5Kbx2pHjnZGhTYF+V1c78yw=;
 b=roLgj3Dx/G3/WmvnyHTFFpK2Cy5aUvP81ymPPtvbxshdGm+v/LyJgKzndARdcmd5PQ
 l+JICMRDb0Dyr/NffoMjW0q5sHH0mAINxvE2Ih1+ut+dHoRrEORMERl7wv9XXdZWOMkg
 N9KtZ1wgvPE2YygzC0GGyGxSrx2U4VcvWGZDwXi9x98z8HPhhxuxl/0wkW57t6CyGM6B
 96cgE+lXzYsd+V+opPmdx1oqNcVEgiVr0rBj60etWvrFFYQqeZy/Hq3T04YJma6hyeWe
 QuKNIuXJYjywGAe0fgXwQRQ34052hllx+3bUAEmssqNHstQVFf2dj50Mc9uVSUQw1YVT
 gdcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790612145; x=1791216945; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
 b=kjBXjQSkdUJiWvzL8y+m/4RZvPuI3SfJRF4ToIplS7c8vLzjL5QDadHZOxAET4htAA
 rMIibTIvMwyBY1NBltwuhvVKN8DlF2yTN7Cp2TvODksFtnbtAxASjscn9xYhDGtMrBsI
 TR1lPgCq3veB1jAnH7weUMway8bdMwQsOUALi1QkdI5FTGWo0UFiPK8flkki4aiNZ9i0
 Y8wc5N/GEdQwI3PefL+rT8Af6l50qmgMYvmOwPv4zQkk9DyN7wjufidSTfjqqP6/Y7Bf
 fKKVocB8TWKnWRzT/KJNf/dPnelfIW5NY4T1BAB54uCtDHn2pcU3zdcrYa7cR6OAeURi
 S21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612145; x=1791216945;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
 b=KGAMFgP7ZNTot8NxifCyFxvAakGj8upQGHQJTYDhFohu75yT2KI99bq1Pahd8VBVAQ
 7YGbvZdNnntYTb1igpn2GFoVBKnfopyYVlDXaQdDcvhQDFk9r2bpvlKZosPN8lXcvdsP
 Tj0ikxAdKm/1e1L+1QD+/Oz/ZZQWKNidZ456B9Rym2lPdlxfbm0/f4LjrQtkfFhIHcca
 bahPAAWjWQ8mUeg7QOEJI4Q9pjgu4N4bieHnclVrsvKI+YXiTDSIavb9WCA1+t5cE+2N
 1D9Os46e0iOsjH8Gr04XboTh5c4NYCx6ek6l0GON2IfMt2Q8EB/o2TPl0i2C7wY7kJBB
 ID4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYW5m+elyLZRwbH9IFgBHPO0lAe/Vx2MDmUsb8UxA+p+W/OEv9MavHY8FBZT4PD7UTNLOEBdxdUZk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0fICCFoGPQCivEMERqUU5inLKk8DW1/9iiRXNPGsxdo4Z5obo
 1rca9eNHTBQy7glCmBVNyzJGbeh8it6s4lMAZ163R6GLUVcCObFoAiGV9OojhuZegWYS7raUhnm
 XUVpocETBXj/DKcX1zY+lKGpbZwZb4JI=
X-Gm-Gg: AYBFou3fYp+PapDK8pDM8YfJeBQq53TKtJSxEyzpucmO506lRd+Xd+FgXwjXjWxAIfp
 c5vCXNMA8aX+C1mEkG56izyUVVhN2x05C9O9jz5WxV30IEGQD9GtxC+1M98dH+uDuaIMVx4DGrz
 3yrzMH+YBDuc0DuzJahRPgvkQmAC9B1KO5zsTrzel2nqzMWY9n19AbyYzyQj65hEILoHibu7cGX
 gjmAwVizRvj6PMlARoqL6MXnnKgxyYQ0qv767ukIGtoFHa0N8Y1aIFJ9D5wKSF4ORtaJG+G2njB
 ZclEUblZvYZegMkTJRThnfLqHVy08Dac2GEvqfqBj2CoBxx7zVuZAy+TwnikvN/i6cADZ+VSF3l
 w8dHYZsf2cA==
X-Received: by 2002:a05:6808:198e:b0:4d6:90f4:48ba with SMTP id
 5614622812f47-4d72ac45eacmr14395634b6e.44.1790612144676; Mon, 28 Sep 2026
 09:15:44 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 18:15:44 +0200
X-Gm-Features: AclHuK9iPdog26wVV94AzoDOB6Ecnbo54mNzfsBz7HWPWdsxEbSKehYuy5Lt6Js
Message-ID: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Subject: [PATCH v2 0/2] HID: picolcd: Fix output-request and framebuffer
 locking
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
 linux-rt-devel@lists.linux.dev, deller@gmx.de, simona@ffwll.ch, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0
