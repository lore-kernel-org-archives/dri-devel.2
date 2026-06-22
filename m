Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18E7CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5164910E68D;
	Mon, 22 Jun 2026 12:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="smN7OqeO";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3F310E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:26:47 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so45841535e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782131205; x=1782736005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEYmqR5PaLPSkckh5kVnG7V4jFZqQSoXCRRC01O6faM=;
 b=smN7OqeOBaZ7lKjtl9I9c/uWU21TMztwQeWlNh2ym3n5gKLzU32IuGrkHGOgSTpdCb
 qeBcePmpq/zjwcRzGHTFECpgefXiV2x6YiYcNQ4mD2xFPEYCRJ7qULSKOyCkcwbzHfAC
 0G5VuNDSbwpI7UbFfjtOFmK27Oy1tr9yLcVs8Hh3gK8v8h1bKWVakI6kSwp+G9frvqXQ
 w6Vdu7JKYR5TklvfCtee8w+b1qWu9jSkB1uXRmkKy/Esypgq8stQr0sK+37ghNzhsML4
 1qsJefenDlGBgHNJCeCRIa7NlJ+1+bpKBbRMEZ+TzQgfQxNFeAb/P1Bm4bXheAcJYO0Q
 Pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131205; x=1782736005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEYmqR5PaLPSkckh5kVnG7V4jFZqQSoXCRRC01O6faM=;
 b=laADpUYcIYhEHOs/YVgrC+3XoMi8ftmr2tixscYngdVP1C33gx3iMkPAwGpRWM2v1D
 CtXwIR5BH3Z61IcHL5975BCXOHcSWZnuNfMZxaNLVRDXU9LOAsdeSzKo27y8k4l+riVV
 RoNJAk25e6uBz5M2W7DpiliklUhSOd0DwtJLDMLdJJwaX71BC8Qg8WGaaCPMakygy8FT
 Xy46aMQLV3ACSnY/J+SybUN7xEu/DMMR62J1QtClsbXxp8/CC1UHro2pL/htyGR+5kaN
 +sf8Nuw2zM/Rhdwyiqtag5LrEjC1XkThsFsRm4E++hcaijlxohZ5KeVHgyoSkL0KzYEH
 ZWSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QT0HtQJ9GTXFUVlWMyd5nUV8+W60TNj/pY1NPUIjhOO6bfetEMzmspynZizV9N+U3pFmxKIttuYM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZj6U7ViCYP71KcUDP1NB5JyQ/ScSJabqN6531TwCSHgxEMOkv
 37Rn5ClLJ0rzBkCJ9UP+FOw8F1UXXfBfJAycDgbNhoAJ6k4QlS/p5vD4
X-Gm-Gg: AfdE7cmsUqj9Pd8CY4YwABStwS2RVY1Mnwdr7YcrbU3B8to9RP5QY473td0IzdtvHCE
 Vo+uBJlHSH/FdWo3y0kfCZ/8T0y+29NtkHSi5ABZ/L4UOHFFOzVuoq80oLZeCPBn0gbQ3L+1cSt
 A+qzSpanR4p2AOJ9FF8v0qLLq7Bk4v6fGXaoin05KwgIQXUwh3uV+9FKMQ3DgNoy6pPzYd43LyQ
 uWlgPbFYnwHfxoiYCkvpjfcYLdmIf1r639XF/Acb+CLlfc0fJqh4FN9GAAjTHhzTfjgfvrSALFa
 IIlawQLNVc5149a4/KoJnr3mMqSiXFaWm2aD9LGD9t1n3XChUW9O+BjoCVuFFfHXosLIbRHWKsy
 Pyyf1WFdHvZEZKYyNPRYVlckKqJs5jzy7Gpx0DP5mWeyOGbsWd7zTAu889XJNu6O0KDrETLhNT7
 bWVsxDcBy4x62rKUl/H2VaT9w4aCs=
X-Received: by 2002:a05:600c:b8d:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-4924258f73amr192805355e9.33.1782131205319; 
 Mon, 22 Jun 2026 05:26:45 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:26:44 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 3/3] drm/ssd130x: fix column and row end address in partial
 updates in ssd133x
Date: Mon, 22 Jun 2026 15:26:04 +0300
Message-ID: <20260622122604.32500-4-amit.barzilai22@gmail.com>
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

On partial screen updates, SSD133X controllers expect to get the
rectangle addresses as arguments of the "Set Column Address" and "Set
Row Address" commands. Each command expects the start address and end
address of the row/column in absolute format, however the end
addresses were being sent in a relative format (relative to the start
address).

The relative end addresses work only when the start address is 0. In
those situations, there is no value difference between relative and
absolute addresses.

Fixes: b4299c936d8fd ("drm/ssd130x: Add support for the SSD133x OLED controller family")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index fee35496a324..4e4b879d8b24 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -915,12 +915,12 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_COL_RANGE, x, columns - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_COL_RANGE, x, x + columns - 1);
 	if (ret < 0)
 		return ret;
 
 	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_ROW_RANGE, y, rows - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_ROW_RANGE, y, y + rows - 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

