Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E1BEA7189
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 07:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A127510E10A;
	Sun, 19 Apr 2026 07:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0Bxz+De";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7160110E10A
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 07:20:01 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so2003575a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776583201; x=1777188001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0uptcA/nPT9b5VoNX/H/wV7A62sl2YDH38WqrqI4Qc=;
 b=P0Bxz+DepLBejsAkQocULAPLdsTg122cS9fyqf6XUVTedJFLnbFJmPvHnlz7tQ2SdS
 BMrzOFi3FZ5kGbwaVX0Ub4I/Gc2Q2f43qe2CvWVsW2f7pddLQ8O57P3sj5sO605F7oV5
 0izcOViqPv5hNfJQK2R/cNcV88EMvnf3GPYLzR7Fb347h24O5sF823/Fxbleab0/OSX7
 7anYOhvg17pz1CRKSnJrpG0f4CjZotJWdH6Il7TSZpGonhG2KBNC0Vwph+UoVCxMymSH
 JBD9nXZFY8DloCaaF8kvpba1fIPfbH1EiuB489pFcTWLcMEm7I5B7pBIAx1bbZlssgCB
 UAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776583201; x=1777188001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W0uptcA/nPT9b5VoNX/H/wV7A62sl2YDH38WqrqI4Qc=;
 b=CDPlY1paBjP/VAmv4ml10zGqV3cfzFaxwHaQDtX6j77xbrcvuA9PMDxdBYJfNndY4M
 oTvxsmoeFA9TqLKPXIPxxqya095cFeIP8Yh6PwHffjoxHTjTg/cEw4O2BJWrdpbw3Anz
 UUkbUmu2/a13mxkUyMDwL0IURLP1Ira11sIUueNC437stcU6g+YPwydIqHlYCxwU6nxO
 vfud6jNxuay+MbaJmkaViS84k08WleQy+9qSwcp4rMZvT0Wb+DnIfNUzejAkd4/KKKq2
 AoPb6olIkfOiqKntvURZOR7iB9WGu+bD4IZBBBfRpKTeS7aXfN5X3kpSHo0XaLsMlHVG
 z/jA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WWJXfSlUOqRhpjte7Bl4l6KLDNcxNPrMxJwR6GBSs8MleS3eciRJlXVvb86LlXM3pvS7kUfnKLy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjiwFj8NxgEC7iTWA0PeYWZRGXIHCq7tpv0s4hlwOGd4CJ+zbw
 DL+RHIkjyycWK9EHCI/lE+z/KHEKzikahz5HtUURIWAFntP0PPMbgZ75
X-Gm-Gg: AeBDievKMZJ7V6dXKNK7PvJPDnyDozrfKSDOZDleEmbNjZE8MZGQEwbYFLi9S/z5sX6
 cPXz5/79y6e8yV0XQolh9nj754qH3eKYHNeb3vMdUuD8ePnW9ryGV/6394TNo7k6ymxAtg37Ti2
 5N0mC+dQdmTS7SrT0KTqa/Ea2HMG5TAF8F6is9CXhjdfSf/bidcQkj/BN/6u5UHV8EeNPOzWTCU
 8+SJe41KtLCT6gGq7D5XBSRnzXOmkxQzyjlTisQHuiuAeqx6Mp9G+NkUbGXKLZDDTzgHNSG4WTE
 ptpT64jRz6bYpXERKP6SOXvt7XKPPWqkfOzdml5A3TiuUyuGuc74bGTTu/4NCPun+WzNk6+Cqyg
 9eKZ/NdTyRXzsru8qSTaesZbO1/uKg8T4n932LdpFqnIPplFzvlI9ZxPhjr3NaMrexnbMqVojvP
 egKSocmGYotkfGvJ3eIgaI+f/tc2X/nFWXxSnz
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id
 98e67ed59e1d1-361403b18c9mr9692965a91.3.1776583200994; 
 Sun, 19 Apr 2026 00:20:00 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614198f775sm7730486a91.16.2026.04.19.00.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 00:20:00 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
Date: Sun, 19 Apr 2026 16:17:16 +0900
Message-ID: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776581974.git.gye976@gmail.com>
References: <cover.1776581974.git.gye976@gmail.com>
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

dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
on success, 0 on timeout, and -errno on failure.

panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
ioctl handler, so positive values reach userspace as bogus errors.
Explicitly set ret to 0 on the success path.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3d0bdba2a..784e36d72 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
 				    true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
 	drm_gem_object_put(gem_obj);
 
-- 
2.43.0

