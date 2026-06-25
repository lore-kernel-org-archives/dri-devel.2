Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3242ACDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8C410F1A4;
	Thu, 25 Jun 2026 08:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BlprPEGY";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AC610F1A4
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:25:21 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5ad4ee80f65so1843048e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782375919; x=1782980719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iJ10iN1VZHR3kKupVafLGHJJtwmSqgOZZgDV+Luo+5Y=;
 b=BlprPEGYhBqHQns4fPPfSyxUBusyoPztzrMGATDX7GeEWFzZYKF0CzesjHS3QzmeoL
 CnPD7i/T7/BK/IGzFajC8mNRJknETd/uNQsYoH+X5Zo80cW+OwluyT799R/hgvJgxlf1
 yaWdW1gM9tnpoSvOMaTPJn9/WGr+mp0MIqDNt7tewxoDZsdvl9XJLdORn1SD/cFExT+h
 qCbf2ut27LlGjjFylOUohLtcCQg14kEKZKyNGOd4G9nuS4fKZZ1fJPwUF35ZO5Vthvr+
 AZAOqKwcDzALX2f0DeppTM1VXanrsntSl4/Q9BpDdQRRP+7nlEfoxMXvqN3hH9TGwEh/
 WA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782375919; x=1782980719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ10iN1VZHR3kKupVafLGHJJtwmSqgOZZgDV+Luo+5Y=;
 b=eQT/0jTum2YsyuTOM24qHsjgDBmJ3cD9JjT1QPjTIeUMAv+xXCnRjfZnrDTAOA4u4f
 YmvovSEotCdQEnPUZV2sXoZL3uoTkaQktDWf8jncDbXRtuRV30lvuI2yjmaxU0vFcPVU
 Saeu9kt+9E0J7C9sjr8BRRjoMYWEegLFv1xVYHtzQLjEHSVMSbMVigFuGBt0A08VPVLr
 79pZ/iTYcNnaECa6rzZ6c8aDZ+9leKoGUNQAzS7PH3Nfw8MBmhoeOBDKqioQD8B1eBYT
 F+xg0rZRl29LEsjRf7Cot5dQgMuStqemlPaEptrNnHMwanE6zzuQGl68yxSEXP0Mb6Y8
 e7IA==
X-Gm-Message-State: AOJu0Yzf7g5SN7r/KoAVoZbiLmuiey3O7beugkFOfl0p5BuxfGUAPa14
 SRJnju2Y3Js/IEATtAGHAVOjvnoFC+EG8WR1bunE6IdXpW1BtLie9uI2
X-Gm-Gg: AfdE7ckkvKOMWE372z9q8VrgKrouhQsS2Atn3mCYays7zv4KhZOwRHrXKHP7rhF7s2j
 B+w3ATdwVvF8P7neOKaxVVR6vpvbNsas/eNESJqMVp+VqMSVOsBWvfM8A1ZxcUasKgQMXs0pWnW
 oYuv9iBYEBzIUO7ZUQUumilTtFabg7xB/h2DyDj3ZjqmVvUWRI+5EJEUk/HO4BHRBO/3GQQuz/C
 oLOA4HlSsBcHUIfbL9vEds7gG2s6XPP6hnxLuDek7twitOJrBtt4yoplAKvVISdJlcegduz2v+T
 suc+sfxtLs/f5oXYQNUH/8JO0uyGV0u6v0yjz2zLDh5Ug2HcxS8EJOPeosxL3h1Lp5cDetUSdSb
 UPMGonSztBpHiFNwHUwgTB48n64Bv0HzjKrNLIQkD73Scc2meT8bEX/SjdcfA/AsWrrHnf8h9bg
 PLcKvDfeb7B3MBqQXxynA7wOegY7oTshHOIIJZ0WHZiF1q
X-Received: by 2002:a05:6512:12c8:b0:5ae:9d23:28a9 with SMTP id
 2adb3069b0e04-5aea1f3182cmr412566e87.21.1782375918968; 
 Thu, 25 Jun 2026 01:25:18 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999af9f3a9sm39064081fa.7.2026.06.25.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:25:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] gpu/drm: bridge: tc358768: Add delay after PLL setup
Date: Thu, 25 Jun 2026 11:25:06 +0300
Message-ID: <20260625082507.57703-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
up, the DSI register sequence runs near immediately. On TF700T this
results in the bridge claiming PLL lock but producing no DSI video output:
the panel powers up, the backlight comes on, but the framebuffer is never
scanned out.

Insert a small settling delay between PLL setup and the rest of the
attach.

---
- switched sleep() > delay() since *_pre_enable() is atomic
---

Svyatoslav Ryhel (1):
  gpu/drm: bridge: tc358768: Add delay after PLL setup

 drivers/gpu/drm/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.53.0

