Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C4DC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF54710F13A;
	Fri, 31 Jul 2026 03:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IxvCEj4R";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DA410F13A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 03:50:18 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8484f229529so492294b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785469818; x=1786074618; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SP2p4oQbLVrToqKl45YEGYGmM0iFaNqyMxLU5hqijXA=;
 b=IxvCEj4RpCCXf0LpSVuSNBBFCsiMD+xlj+dtn/HB0hgXZ25Nuer91d8HreR1A1yJxk
 VxQshlCP1/UHsce9oGkWsBeJOTITpVXY/dfLIIuDKaUZUago1vdq6UCBaGtqNJWfZY1B
 i76hR70Kka6qnB+STVTDWSHgmwkSNRuKgiWuhUPbRnzPuVlIcv2T3bp3Wsq1EylhFUvy
 1uJVpagJVsT+JsyBMYvwTKskMNgb1XHCP8d836SONceZuArNVDqdFZPr6S8Jk3FN0gkb
 sjL8OhvfVDflm4L+qRpe1LDZzw7wXWZ8bg5LkzeU9e7tbGYWNNkbgOpxlDJ9NkpollJh
 8A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785469818; x=1786074618;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SP2p4oQbLVrToqKl45YEGYGmM0iFaNqyMxLU5hqijXA=;
 b=eIZSQ0OCM0ANCslTiNlHHq9/mRsLfdQaAK4eusvbzEMM6qMHj1zqKpz9Qpn0fyITvL
 KkLIiCxiL3/ORl+rn+rcqL3B/KTxz+T0tvhWi6IWQjxpGue3pL8cRaVOHBHGWg+ouQ87
 Gkgvk6mBtRnNl9gePmcw7WNeZRMVAa0V80it+J8v6fNSyReohVFJdVgkYpECWsvyPIVg
 bZZHZM4rZtjS79kyb49ZfSXvES7LURvkX7MBYh7HVCl2ng/AYQOGWmiFwfp2bEIqJUQY
 cDh6+auzl99ww1tRFYmcdCm/V8KCxxknjxH1YnYBBHnejqxqm3dudFxym/1hDBHxrqM3
 wKcw==
X-Gm-Message-State: AOJu0YyO4R5tkeDT2Z+sZVzMfBKOeesvno48ivLsFvlZbUVrFoj3XhDR
 UFGuPW+XeLEhhzIiXU01Ji68HoOheEPCY283zo2dxa4oS5judpuHXeK9
X-Gm-Gg: AR+sD134uKWMmw2IXstpLZ8vfK2aM1+43MhRuvIf7fctFMqjcHXokPGXHqqjQw+hf7A
 UO9M5tuLmkC8a0a+HH2AahIUyERS3RTyHBzHfSeSsRw+XzfztiKuAbV4lmMaWmGfCfjFZjh3K7S
 LB6hAdCkaoHRfg/zIdn1LfrPKglfxgGWMXENIHUhLA3u6y5n1WRkB02HZ+trKuMsTCLY77IBSwa
 1oXpTX4Z5xzSoEJFk034CGvaekrSxlYSQQe+K+v+vcZ56rci4uLzuiaTR+falc5/XU7FOVFwFns
 00Ai4De4HUiyrLHN4NqJDNB8XDJazFDEXs9Rvd/vOfYM9A3dh5ma8jfZXlRb6JEKpCQXlqvNkKe
 0+dlJNdGY7c0ABNT6bqxgTYQPXx0RbLn34W+FPf4wbdLInSLYgm9useBumSf+aVgZUc2v1fUcHs
 MGI3f3dQ6LcFsRxPGI4py5w/95ZkhMp/+tD1kjxjMDdLq1VbWY6LOb/Maod2S8NSjbjIE0Rjvem
 NQFGNVqlIJ4LBPbeiKBervL8iw3RT0WKIUmCjLDt9txAHTA
X-Received: by 2002:a05:6a00:428e:b0:848:5eae:3695 with SMTP id
 d2e1a72fcca58-84ed6f5882amr302462b3a.78.1785469817795; 
 Thu, 30 Jul 2026 20:50:17 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57cdc73sm175536b3a.17.2026.07.30.20.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 20:50:17 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH 0/3] drm/tiny: ssd16xx: fixes from testing SSD1677 on a
 PIXPAPER 4.26m
Date: Fri, 31 Jul 2026 11:50:11 +0800
Message-Id: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMbbGoC/x3MPQqAMAxA4atIZgPWX+pVxEHaVLNoSEAK4t0tj
 t/w3gNGymQwVw8o3Wx8nQWuriAc27kTciyGtmnHZuocmkU35ozCWTYhRRUeMHjyfUx9mHyC0op
 S4vx/l/V9P94+RH9nAAAA
X-Change-ID: 20260731-ssd16xx-pixpaper-rpi5-c9e94df4c79f
To: Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Wig Cheng <onlywig@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785469814; l=1995;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=8kkPzgvCPy0HbIXHh13+5LOd7vBmd4heePR5dBZWLFM=;
 b=91Bja9OFXGixZuGsXrJSI1tIbetnBlqLYx42cW32s7+EySbBeKHjsjuKq2rKHfz9EkAabLW5w
 3a+2BxSQNjaBgLsebQWfowsfd8JVooRTOtKgGoE8bERT6GVWFj74TEN
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

These come out of testing Devarsh's staged SSD1677 support on a Mayqueen
PIXPAPER 4.26m (800x480, SSD1677) driven from a Raspberry Pi 5. They apply
on top of his ssd16xx_7_2 branch [1]; that work is not on the list yet, so
the base here is the staged branch rather than a posted series.

The full test report, including the issues these patches do not address,
is in the thread at [2].

1/3 removes skip_data_entry_mode for SSD1677. With 0x11 never sent, the
reversed RAM window that fb_dirty() programs for 90/180 has no matching
decrement mode, and rotation 180 draws nothing at all while every call
reports success.

2/3 adds an x_mirror flag for panels whose RAM X is scanned in reverse,
which this panel needs - without it the image comes out horizontally
mirrored. Its only user is the pixpaper entry, which is being dropped from
V2, so please take it or leave it as suits; otherwise I will carry it in
the panel series.

3/3 makes a runtime rotation change that has no matching mode fail with
-EINVAL rather than silently corrupting the display. It is a stopgap - the
runtime path itself is still missing the mode swap that probe() does, and
I am happy to look at that as a follow-up.

All three tested on the panel above.

[1] https://github.com/devarsht/linux-next/commits/ssd16xx_7_2/
[2] https://lore.kernel.org/all/8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com/

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
LiangCheng Wang (3):
      drm/tiny: ssd16xx: send data entry mode on SSD1677
      drm/tiny: ssd16xx: support panels whose RAM X order is reversed
      drm/tiny: ssd16xx: reject rotation changes without a matching mode

 drivers/gpu/drm/tiny/ssd16xx.c | 58 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)
---
base-commit: db06284c5dcc505ca3687621595c1faa59cbee27
change-id: 20260731-ssd16xx-pixpaper-rpi5-c9e94df4c79f

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>

