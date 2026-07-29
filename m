Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A5CC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6960610E170;
	Wed, 29 Jul 2026 05:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sVs4oC/Y";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8D310E170
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:31:17 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51c2a76536bso5214301cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785303076; x=1785907876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ajJ4gb5K+FqgyR1CXk8w+2a0cfOTWEXUH5BdVR+3LEY=;
 b=sVs4oC/YTgWEJct/zzAH8fHCGooFkbparGBOfXagjW5P/93s9u76058ppnouNHqSGf
 57jnL2kKK2joq82paJtjGgFu0QLiCnMLwRnHiFKUO3/R6xmzbgcTpO/uzS51dRo/IMwB
 k4rBYHwleOuizozed+uXpJUK9t9yJ92e3BROBbDp00s0G4p4Av7PtQGvlE2GZ+v+1GDf
 v2YfzCSJz01q84xMhCqpYgHIhSZ7HPeKvkf4Hdz8eTkTPhr4o1RRAOOUpkUB2EiP2+aI
 vj5v8ojUwTFgwG6iOYG9TBYgwziTQPqpDNySumStkMbW+D0Lk42x0jfoCBfsxMYyHtpA
 +wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785303076; x=1785907876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajJ4gb5K+FqgyR1CXk8w+2a0cfOTWEXUH5BdVR+3LEY=;
 b=Xy0vpaCtdXTohmYlt2RS2WCPUywALlyEbDobyAEm0oZfBIN2HIwJdpk5YC2GrXTojK
 vPVa6Svg69Ez7pjezNXKZxouw+LNvR0k2jfH7YFRtyolEcZNKDgr5tsqBS8s8pZz8Lul
 wTzNZNJ+F+sllrbqdzCvEvT9AQ5rL3eHZisVhdSlbz2B4z92XDSWaGp9Ywna+vTxMTJN
 MDuAdWIC5d+RwM0FZeDawRsk/gjmza55G5fJYVrrxxA+38KUQ4I87QjMJwAMAscPgGIs
 9sXdjn1+LYTfZRW5Z2ufUGg8o9lzv1xYYqcZuqKxpk4X2laYZK6j99clgH9iWzrd978L
 CNKQ==
X-Gm-Message-State: AOJu0Yxxa8vFZycmPiRywUtuM0uVa9+4jsI9FEf99bb5jFapLGIDaxiq
 +iHn5bhAPtREVNJp4uEOfK/DQXR8vRCfXyiIxz3szpJt9N2c9f/0xVRH
X-Gm-Gg: AR+sD11K/IAzXBT5zGOAIsEp6V6v2KEZwoF5Y7/D4Q+BPLEwg6jrZrBmJUDlEM5Kd+c
 4bS4SrpI6CKjEBZQpN5UwUkVXhexX9z5TxKntWPFN8FjW8E5BZGZKbMoIU1INQvNOoPvjKI0HQG
 rFrnJMNeNwbp/0rVXQE+RYutuYh4tPUebQorXGQYXvIGIJfvdoqp7F1mJWtyoVG/Xp/rhbfJvY8
 PGDLQHdwktPyiDTUUiuYIedtU0HhpGgLGYasUDTqp9W40LGaQEvfECaT1+/VJdkDV1M9hjKQ4mb
 JVR8RCk6swI/bEiZtmty/bBExym6v9xBihfW2LqBXQjK1RnqXPMQvuTDJsxUezSVwxHuqpcmBu7
 kaGbfipxNyMBjhWgXvGeW2HFl8yjciFLxS+W0V5I8kctdBKdzOK1qc3Ka7+Uq6VsKtCCeuJgAc5
 QvGCMeZgBsqq6sx1f7rCogzsTOCJNLDLE+liY4auhYIrl+3phi7Xcw9wqRmng=
X-Received: by 2002:a05:622a:130f:b0:51c:f04:4aa9 with SMTP id
 d75a77b69052e-529d7106b58mr51995491cf.32.1785303076548; 
 Tue, 28 Jul 2026 22:31:16 -0700 (PDT)
Received: from thinker ([65.195.2.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2b1a1ddsm12592861cf.5.2026.07.28.22.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:31:16 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 0/2] drm/ssd130x: Wire up ssd133x backlight/dimming
Date: Wed, 29 Jul 2026 08:30:52 +0300
Message-ID: <20260729053054.29374-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The ssd130x backlight controller adjusts brightness by writing the panel's
contrast, but ssd130x_update_bl() writes the single global SSD13XX_CONTRAST
(0x81) command that only the SSD130x and SSD132x families expose.  SSD133x
has no such command: brightness is controlled through three per-channel
contrast registers (CONTRAST_A/B/C) that form a white-balance calibration
and must be scaled together.  As a result the backlight device registered
for an ssd133x panel had no effect.

This series adds ssd133x dimming:

  - Patch 1 extracts the ssd133x_init() contrast magic values into
    ssd133x_set_contrast(), which scales the per-channel calibration by a
    requested brightness so the white point is preserved while dimming.

  - Patch 2 makes backlight_ops.update_status a per-family choice, so
    ssd133x uses a handler that drives the three channels while SSD130x and
    SSD132x keep the existing single-register path.

Note patch 1 changes the ssd133x power-on brightness: it previously booted
at the unscaled (full) calibration and ignored the contrast field, and now
honours the shared default contrast of 127, i.e. half of MAX_CONTRAST.
This is intentional and matches ssd130x, whose contrast register also
defaults to mid-scale, so all families now power on at ~50%.

WARNING - NOT TESTED ON HARDWARE: this series is compile-tested only.  I do
not have an ssd133x panel, so the runtime behaviour -- in particular the
ssd133x contrast scaling and the new per-family backlight update -- is
unverified.  It is posted now so that dependent work (ssd1351 support) can
be based on it.  Review and testing by anyone with the hardware is welcome.

Amit Barzilai (2):
  drm/ssd130x: Scale ssd133x per-channel contrast by brightness on init
  drm/ssd130x: Add per-family update backlight logic

 drivers/gpu/drm/solomon/ssd130x.c | 67 +++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

-- 
2.55.0

