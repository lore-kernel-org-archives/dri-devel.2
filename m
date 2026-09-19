Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF72C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B9D10E337;
	Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB08IDPM";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1738D89226
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:26:33 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so1189091b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789856792; x=1790461592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4XdLW6/h6dqj2ofldOtryaRDZTEFxtubsYMu+/kbzlA=;
 b=fB08IDPMjcMrfIKuKmhMrEFg2LxBiJf19sileOHI5MncSX2/P5G2F1pRnloC9JWSmF
 9SbnuO91dn54loR9opOzj5C4iatyFCGKqqmG654jBBsSe9WOqActgAAPJUgeSHTK0iCg
 ZqK2XIdLMZrB/DvJD1bPYHlCjp3CtG8PvrRVGxg40hoLquEUExzOzcnn5NQyKnej8oIv
 l9l782+Xnd/wpKQE6f8CFC5PKeo0+4fqgtqd/OXvSYUeUpGhyNdX2S3pE5voNPLriUnp
 qivRTph2ctCCqFe0Zc58pNj10nDTVGG1cd7UP2fuETo+FFTKuLQViq50E2RvphPsJdZJ
 TrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789856792; x=1790461592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4XdLW6/h6dqj2ofldOtryaRDZTEFxtubsYMu+/kbzlA=;
 b=pifXgeYvK8kMBIz/Hinyvb9h/GBJm98K78V1VPqAVz7E2sBxg3Q5sOMBf4J4JwNuZ7
 vrmTRAlBfgwG2/gO4mRNUQXnUYqqvuYSARRCD8ZEJNEVYNknbst8zGA0Bj14X0msM4e+
 ob+O3ZjBqE53jtLgs0AcXgbSN1X/y/D7+8ZtKMPm5lgwfaB88lrB3YyXtNFySjfkBEKa
 977uBn17w9EHYxOus4xx/utC4N6m+Mti5ubIQis4mQxivePw+wwiAiGwdDuOiA08m3Wf
 Prxipq5HwzzxQG9hAchvD1KA8aa6yL8Y2zEu45zatyhflFRHQshwsPyTW+1PsJbps1FB
 vAzg==
X-Gm-Message-State: AFuF++mAje/RK2F2DPXebyVU0G99KI9DzjocK3iu5bufKCFOCIWaxSAy
 6cnbu3rJGRw6KxHPSj79EyByoS4fOC5IcZt76lS4Gt1mp31B27PStoXt
X-Gm-Gg: AYBFou0g0LtRfvJROs5TAF5st/HQKd3JwyoNZS5tVMzkrbI1K7SVXTGN6sL8gRzG3EH
 EIiKJEWsZ+E9k6rnQ5xlg2X21HZQE5x2rkiAf/8syfQJ4Y0Dk4cAUTUmBWAaDIT4ty9+IsmAWGf
 rsgRJd7jcVcr2zwynUa+e9kQdbfgSv/7PxrTrNPL0KmqIhfxqJKPjSTrFHIG4P1nRErek8AyoL+
 gYW4Mj/xnlJxQwwczfLHhFreIiwyIk92e/upPgNvGt5OSqiDbsqCLsqdYDgtkJ04Y8gy3HY3Cfk
 QuJ0nfAu+6m74f5q2yhxI/ZIDujjT36co1XEEHnIgd8lGP/76AhQ9r4nf0TyauNIi4EzjYLLc8x
 l2YkkwtVlQcKMKVMdtgiiLnQGZOniyg06R8DVsvbEwZHxLZw5pZs7iGGVVemi+tXkpWNGwXdxjZ
 nzsQrvIPMhAQ43WzHG5+6KS38RVLt5ufluNSmCLU4ES+nWVIyiqJoG3f9IDZHwNiiW8utnWP/++
 DhLO8ZUjUZgh9ubg4h4BZvnIpGMpoNOzlWCq4Cv6Ha51jktAj8974NtW+aps6l005tgX8OxTL04
 /GKuw5smJA==
X-Received: by 2002:a05:6a00:c24f:10b0:878:3507:8d6a with SMTP id
 d2e1a72fcca58-87835078e60mr1766414b3a.49.1789856792547; 
 Sat, 19 Sep 2026 15:26:32 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc72aefc0a6sm1360519a12.28.2026.09.19.15.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:26:32 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcus.folkesson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sitronix: st7571: fix hwbuf heap buffer overflow from
 unaligned nlines
Date: Sat, 19 Sep 2026 22:26:31 +0000
Message-ID: <20260919222631.3798442-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In st7571_fb_blit_rect() (drivers/gpu/drm/sitronix/st7571.c), align y1
down and y2 up to multiples of 8 rows before computing nlines so the
byte count written into st7571->hwbuf matches the allocated page-aligned
buffer capacity and cannot overflow st7571->hwbuf.

Fixes: b362de167daf ("drm/sitronix/st7571: split up the driver into a common and an i2c part")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 20954c33eca9..e1e95b360255 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -827,7 +827,8 @@ struct st7571_device *st7571_probe(struct device *dev,
 	st7571->regmap = regmap;
 
 	st7571->hwbuf = devm_kzalloc(st7571->dev,
-				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
+				     (round_up(st7571->nlines, 8) *
+				      st7571->ncols * st7571->bpp) / 8,
 				     GFP_KERNEL);
 	if (!st7571->hwbuf)
 		return ERR_PTR(-ENOMEM);
