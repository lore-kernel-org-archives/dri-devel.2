Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95947CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BE410EF7D;
	Wed, 20 May 2026 09:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TunhrEnl";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B9110EF7D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:26:41 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490229aa522so12898735e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779269200; x=1779874000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bCzspFC4iU1ErByw0rXOAxKL/qHlXFlidyuZgRUC4+M=;
 b=TunhrEnlN4TBLZDRNGPULlBJBnWbO3xf2DsV33k97WLDMBaKZ4TBr1dJ7eu2o/mOJl
 MiMw+d+FQwxYqFIb2C1k099/jEZa79oVGlDfWVsAC7stOzTCXWkr54bCnMvj2i7GIV+z
 7iE8Iet7XFl8JLgtJRIQLi03XEUaooJJOTZdyiMomIdynKgytqCaGWkqtcve2SNx+1VB
 ptwj4fxuMiOAVuAmso6Y+X/YKd6mf+og5gWyJb/gZkBfZuRrm2FK0+AjjwQneGCJp6DD
 /EC4tguvwGSbG0q13g8FNHv+c+S9J9YUqnRo13DrvGOoTxXBHNdBf2H2G9cF4I+fF+Ov
 zAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779269200; x=1779874000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCzspFC4iU1ErByw0rXOAxKL/qHlXFlidyuZgRUC4+M=;
 b=pLxwgCq0dWr6Pc10rZdrrxtYwIBpZ/uMpDfXhJIyLoWMM42pRz12fWOnjeyV1gsH2G
 kQCoJDjhKpOfTDOmW7RoVH8smR/Me73vqGnXHHrmWgK0eKGNK8WRgN4hrhe1FA19hRf3
 qitOKtGH/Uf2dSkQEeEYGWt/zozHKMvV5TxF7alH4pnCFrll+le2CJ2m+fPdTil3/c1o
 96Gs0H3CHsA2aTAMhS9SOyLh0mGD12DI21+7VY7kMOdHUe2E3b/cos0GOXauYWDG1+fC
 X6XfgMDrb75bAe7ERNuMR3i0IbmHKeCQDbD7H0B4C9r7y4WO0jcAqdDU9YnohcIlc6FE
 SCbw==
X-Gm-Message-State: AOJu0Yxa+86WBVRsRCqVM197c2wJ4LWakdh6BM5m5389t8/Wtg4EiGR6
 0uILBRgXezfbz5e1dyfd5ilXYAUrVo6j9dngx/ibDa97TBkxjMXBYl1u
X-Gm-Gg: Acq92OHaJU97DawY/y7st31eDbrEXOTXlJs6hokpQANpZkfUeyqiUkXhpeuuBSUftBN
 7b0s3xSF8i4zQYyHmV6PVMYF+2rb8q4GC/vjCdJiJW9/pecKy9hHnXIy1gCOnUvJeyZSvxhyCKv
 sK1yNUxIAXfCnbkRhGzqhTvz0njIwpqfJHFvs9XTb7Tk1J0aexIsAYAiXKEDRum00VR3qmmzSpZ
 x0yuY6Vey//etORip92A+r2lzxxnASBNCF8UL+NTRqCoLoGEHejOHFCMBsgHVJTemsvLpy0hllA
 fSbrF6Pi6HuQhBVede2iGoKhn5kCqsr6mfY8G23ZTORkovkfjFs9JtAmNt0lu3kol+xf2pr01cT
 VqbI3/ZY2iw4SJEbpy8IpLdt1ciz9+eFCUduGugeg5c/6PxX+FR1go/sGlbNXdm3MbDq9PKm+GV
 HL1FIWgxEWJENo
X-Received: by 2002:a05:600c:5297:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48fe61ed375mr346315465e9.21.1779269199972; 
 Wed, 20 May 2026 02:26:39 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49031731733sm7960805e9.0.2026.05.20.02.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:26:39 -0700 (PDT)
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
Subject: [PATCH v1 0/1] gpu/drm: bridge: tc358768: Add delay after PLL setup
Date: Wed, 20 May 2026 12:26:27 +0300
Message-ID: <20260520092628.47539-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Svyatoslav Ryhel (1):
  gpu/drm: bridge: tc358768: Add delay after PLL setup

 drivers/gpu/drm/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.51.0

