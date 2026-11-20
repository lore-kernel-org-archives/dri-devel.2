Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EC606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhB7G6wa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF331128DB;
	Fri, 20 Nov 2026 10:40:48 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 462681128CC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so6016665e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171238; x=1795776038; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRKhJSg7Qs8Ga98wRztXXntzgWjghW1WGjO9rfgcgBM=;
 b=FhB7G6wa/10KAKKGytL+3Zi5q+6KN+CZkBvKY7IV4Xy8ArIE3AxeD+aEMu3Q4/EjhT
 iWYjN8rlBuZyJWwUvm5fHzYEk7nHkK2tP/cFJYyHSKvnVleJxm4hLTjjhsJt2dm8Zaa6
 pu0XtbmXf0EI/2tHJXzRup3QijZsIXBM93m/nEDWoH44XijUHCIvx8xTBVbaJ4aBK+To
 Ti6EuaJVRPoAbEvL8gdaP/XTg/Es9pl4Lm0JLs1bahhnU3SXj08HT4UTcs39qMqAEGCL
 /xvAAsOpKAYtAfL7yp7jEVdRitO7gcBNQNgg8ynvvXD70UhDO5Z3ewz3In1aa4E5mp5q
 wYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171238; x=1795776038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TRKhJSg7Qs8Ga98wRztXXntzgWjghW1WGjO9rfgcgBM=;
 b=XOL5AchZbdDsAOM3gLMuG9hQOmvFj9OEP5Ept4RrdezrMaNGSCjwiMLESAUL8JHbh9
 6h5sQqQUpx6Z4U2RJ/H66mEeYa67uVLzaE+j8Bdk8Z6wxyIbNjVoxXO75AqB5mqhRnN9
 5BqkDE14jHRy7qZ6npRX9CLYVbt68Zpdoo/52OHkgwys1dhANh7DESIPaEXBu3hr2Wfs
 pfAwJGJZVBHj4JaJZNVGUCx5ofNyRv29m5giAza7asYWidLr/llnqTBDTkSCIBEx3a3k
 26NZhO/LZqxiUe8cX52+K/X216C/AwaIjuH3vDIMxTsq3sDocOJ0TaBgdaYCnMFDt2w/
 ++3A==
X-Forwarded-Encrypted: i=1;
 AL+hErG5wM7Wx83bJHQ8+3pz7kKBAcMODRCLoz05bhZsuA9mGffbRQOiEky0ZCzPYj35/M8t6PpFV98wGto=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+yzFCWevjtgVMsbH2GrtCw38HunpWPj6KEB7bjc8t5kVg8YbcR
 isdgzgrUmGHdYDfCLmhl8RpnnpqxtMqoa90h2JP6YFlomGq5yqIoBvpa
X-Gm-Gg: AYBFou3eWhKQI65OrrsJQi+QF1VSs7Uq+i0t3PtVLASOmoIavNgBNLeXOheBLBl3RaR
 bVMNyJZJw7/LO3e3Z2N+yBaOunSKhzv8Ptlm7Ld+SdrTDmx/ILo2j49OhERua2H1lRGZjgqlEKW
 o5xrdxSXq2cZgSiajGthKn0WCvd/XiGHfzESwJo/ycITR+ICE8LRHiD3BWs1vV3Uk3g89k8BxB6
 Xw9ohnz3/Z55oGGfADtl44cPOXnCQSfnC1/r/TFKMf26iwsRvQK9V4+mM2FV/j7jKGYYjUrcVH2
 1tzRXXUa2vbKQzpY/1xEwj+sxuwSlhyrcm9H8UNfvI0Iqtlblgh3b3Zx9mj+0NGGBNs/ISLRS4Q
 PinGIhCbZgDEVi4H6taIMC5vuZYFEWJbzwMV5gFehuB4EF1pjL1WbBcH16KbNbtJee+ZNCY4t7r
 lKmRFX9PPg2ysK6khqllO3v5N1SPehO/xGDesIrQAXYjZVNENwYcRC6lvlp/9aF/7n9erXZOeBw
 s9ag1wxzwyalf6lAjWTMe7v8QfXaAbOCjcZspoWXPfCN32OwA64z3FsUSpJgI9JNBHC8Bo2MDgv
 jGKXW7poPgvAUviDtOHlaSc1KFURkR6gwrmT6Bn3gIrAXUJadFXz+noJuHJB9kq6HUM2ghmMFXR
 ZYAP1hddAHZ8ZuRarBDNNsKMop4VJ624GF+UnQhY7t7pxzozm4U9ELDPGfQkiEaiL8OdeuIyx
X-Received: by 2002:a05:600c:5395:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb8880e599mr55432805e9.8.1795171238555; 
 Fri, 20 Nov 2026 02:40:38 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:37 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:29 +0100
Subject: [PATCH 3/7] drm/etnaviv: Skip cooling requests that keep the clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-3-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

The thermal core does not compare a new cooling state with the current
one. The fair_share governor sets the state on every zone update, and
the step_wise and bang_bang governors and sysfs can repeat a state as
well. Return early in this case instead of programming the same clock
again.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 2a56bdf2510a..0a28e21feb8b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1786,6 +1786,11 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct etnaviv_gpu *gpu = cdev->devdata;
 
 	mutex_lock(&gpu->lock);
+	if (state == gpu->freq_scale) {
+		mutex_unlock(&gpu->lock);
+		return 0;
+	}
+
 	gpu->freq_scale = state;
 	if (!pm_runtime_suspended(gpu->dev))
 		etnaviv_gpu_update_clock(gpu);

-- 
2.56.0

