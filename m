Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CF8CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C013410E691;
	Mon, 22 Jun 2026 12:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bkVrDN0u";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5257010E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:26:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49230a567a9so20846205e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782131204; x=1782736004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryUqsYaYiUG7hvMOUXdrHSbBnPD3a8NKDYS5e2rhFwc=;
 b=bkVrDN0uHSPkPvc9fOQpKeS7n8EyxFJBUXBoih7nCqnjTrBwHqSJcykKXawOkCWfx1
 Lz7VjoNeB9TNeFXAyIfrjYlXDuhs3j7OjdIFjCNiTpWH1DXnqiqfJA7RuqdJWgYYzsZV
 uHigrepbxOLZvPR2pTCi7g8tEHfhbja7/Pu7cFPc8feLDe7u5F9ayFQlBT3YhnO1mPWl
 5KINcVrRZI8MFMCwY5fnZ8at8x6mgq+Y1zCs1fSZZ/VahLg3VkXolgXYrfcCJEUCf3Xe
 qX5Lqqf3+GIwhEbBr7qEW/xMTVU5VezHmgqnOoMzRz1NnmWA/22qaNO4Hr+8/bRproK6
 jxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131204; x=1782736004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ryUqsYaYiUG7hvMOUXdrHSbBnPD3a8NKDYS5e2rhFwc=;
 b=Y9fHTDX2WsZEBcEQ8nTStppr0tLxuUPCk5FN93viEVy2GQSpIVMhwICjZEYiYfeWd+
 /Rd06fEszpFj7SzyjBayxS3t/RKAyf3IyHoyugtRwquVs/HjYTPau/qgOHKrWxfc2f4z
 fjhxFmfGNbguis/7B0J932JOaQcEt+/tSKUl7AM7Lwpx/kQp8e10zyiiUOiLCPIs+jn1
 hmif11zT+lYEVFJWphpOz6ChtZXr5REpgrbyxj41y+5fMbxpqcjbg40Yzmbnczsvf6vt
 boh8oSgbbRcqCVVcBVlVHnxx4AfsiPi0Ytk61p5OBO5Qf/B7nIJE3L3Z2o2BCPVVQB3l
 cwlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ska5tU/e/IZWm1oItnQzXgSwkiAHvWGerCpRQmyMbLg0zXaVqoserSMk8RfwaU2+vHLV1t8yaUso=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpEO0661RlakuF5vcxnWdHKCX/W06cdfs7dzZRPK8Z9hgGcOhD
 1mp3W5Pp02rwrdgAVFlpnWc34bzJhm7pBcuOJM5UgPIHdQkhKpt9v9Xp
X-Gm-Gg: AfdE7ckzF/B/3WUBwhGvIe61PGJu5sGMZ5aZ6Vsn/KHQXKdcDFhyvsJgaaX1LFkWKiB
 IqRHdfr88OuBOlzmaqtxElfbf3MOOTn8RBFfp14d4EYkcwx1AgZ6s16Zz8wg8guKHplCJlOV8jk
 nBuVGZJ2KRcHN/UAm9arsI5YAjIU921NKlACd7tgLXt3nL/kF4avGBeuRgIiscCSvJSENKSdYjp
 0fSYUCsgWUTs1mPiSXgO6W4bbbB//sHIvx6GccnBOAJrEsg20O4ISaY/0TmrNQRWMmWNYnH8J92
 6PeXAdA8jtxUvuwZhnz8xX0oJ4/GyJYnHjon9EEUWeSA9xTXSnA/r0AvZ3s0uV6tH/tC4CHfr+9
 2kJoBmysmbnr03UisjkSqyL/3E5+EkZuW6w5s7HYvS4V0gDZs/NnRe0wZhRJTAOV2ebF85d0fPT
 V4PoZN1NWawhQfLQE19Ymoms7vhsA=
X-Received: by 2002:a05:600c:5289:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-49240e81ac2mr235360185e9.22.1782131203649; 
 Mon, 22 Jun 2026 05:26:43 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:26:43 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 2/3] drm/ssd130x: hoist column and row addresses out of
 repeated division
Date: Mon, 22 Jun 2026 15:26:03 +0300
Message-ID: <20260622122604.32500-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622122604.32500-1-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
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

The ssd132x_update_rect had to calculate the column address twice in
the same function by dividing the byte address and the segment_width.
Optimize this by hoisting the result into a col variable.

Renamed the "y" variable to "row" to match the change made in the x
axis.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 77aa5585a46c..fee35496a324 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -835,9 +835,9 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 			       struct drm_rect *rect, u8 *buf,
 			       u8 *data_array)
 {
-	unsigned int x = rect->x1;
-	unsigned int y = rect->y1;
 	unsigned int segment_width = SSD132X_SEGMENT_WIDTH;
+	unsigned int col = rect->x1 / segment_width;
+	unsigned int row = rect->y1;
 	unsigned int width = drm_rect_width(rect);
 	unsigned int height = drm_rect_height(rect);
 	unsigned int columns = DIV_ROUND_UP(width, segment_width);
@@ -847,7 +847,7 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	unsigned int i, j;
 	int ret;
 
-	drm_WARN_ONCE(drm, x % segment_width != 0, "x must be aligned to screen segment\n");
+	drm_WARN_ONCE(drm, rect->x1 % segment_width != 0, "x must be aligned to screen segment\n");
 
 	/*
 	 * The screen is divided in Segment and Common outputs, where
@@ -864,13 +864,12 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width,
-				x / segment_width + columns - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, col, col + columns - 1);
 	if (ret < 0)
 		return ret;
 
 	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, y + rows - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, row, row + rows - 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

