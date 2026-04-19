Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D4EEA7189
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 07:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F20610E11D;
	Sun, 19 Apr 2026 07:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o/I9EgHd";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326B610E10A
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 07:19:58 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36146ae9dd4so1301683a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776583197; x=1777187997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NubENbVnw4RB0klzgk0+GOCS1Cv2Xg/qv0QNTz0zlFs=;
 b=o/I9EgHd1BVjoDS4gSBLpiE1Bja8wZuhZ80PLjdpCpJlGJycHQW8jgD+U+j5aosiFx
 goUDs/ANl6g/TYuhKLVz1+yqQtq5Qxwbv5BuJLZLpjWyz5yNEhCDkt+ylFH2ehzUKQlm
 IYVVqjxdOnEwAnLngbxA+ZsyMVNbs9P3LsO8yBo6wrQhZ/wbGMOh4GyemBH+LAE6dNoV
 NN8M4wsQi2XiWu+3JfkgyoB4K61pS0nU/FPHn7YWGIf0yr4J6mvhd4DdQjc5jHiUZyad
 uqPOewvIUZslJO7uVseTIEGsbHFRb1TuSaLxYorQZlwZzHUzJN5Aizw6BFvKSfpTDFHl
 pwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776583197; x=1777187997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NubENbVnw4RB0klzgk0+GOCS1Cv2Xg/qv0QNTz0zlFs=;
 b=k/6lNPRdNtszsdFj6a4zai5FPndtZhUhww/w4m0pOz/sVVLkds6F+XVPECKmGbwKWO
 Nq6F6wuX/myTtgj4cGsKbFsdvZS4T8cOMY9Gx+sTfK0qxtfFm3VwniVkcP/YRq8mTrlj
 vJaXezjPrTcQ7p41FiFrgxLFcFBgetPzYHj79BggV48JZG4y7itGiKXCPkYYHuihDilN
 8EXl8sYmrR2uaYnAwG//7fS+laNAwNv8efZ8Dj+gzkh4GV4Ehan6Je/fCkuz34oilSKR
 PKDc5jyo/vfZ+byqYKxXOlD0+kd60C0S5UgRySTISblIRklStrWPE4HC0H4FabJfRnbA
 KA+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DJDaFtb+AyImHDpZ9u99rVaeP2bTKrpRwbmEK6N/rVfolOgYDLBKVJp6fjEfFWNpVW7we9M24uUo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze4KUp8WfQpjitgoTcOkoJDvE/nqgMTmvb2XrwCicwgQ3rY6Xg
 Fe8/n/YKnAQR1sWRViNy0goXIl72YvtRLMXJ6ELkCMjUs7HQsat8Jn/k
X-Gm-Gg: AeBDievLKKh8OeJqr3i/OBCcoE9P4fcAV0yCH/CuycmVYgneHXuzC6ieqm3Wbh+Myl6
 Yggi0wLvtX/yC2US8R7oP2s0IjsiLn8sezGDRJq7HwDvu1MqlqUZgwbYcSiMnCREW9WhliMqctC
 3nsZCVqiApqKAbnZVKgDCmCjhzVRq2eRycLhwEP/Ung2MgkN8LFiQnbZ8Cfr/FkW7oLRm21RqSw
 iRJtKkZZSTlvfOnE18XjoYAc9wrJY1cw0ZpH61LdyP9qfV6L3/gkjVqVtbLPeiNO6uhp3ezDw9l
 NzPF08g5NNbaYp9p7FrcTntb7Smqepsp/GO7R1fmeo9j19/l2UC7N2821CcvYNPAw2oTcPosd5k
 IBhKYi6qAyhI7IgVwTGHjdGM6A60vrCTUxm2KkUWzr7tZmzRxcQWpESX/usQ0BWLpt4xUPbGLsB
 LjsTnrjy9evNxKCP02G/hvjCXCsyziiZbQZGCp
X-Received: by 2002:a17:90b:5288:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-3614048b1aemr11300754a91.21.1776583197605; 
 Sun, 19 Apr 2026 00:19:57 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614198f775sm7730486a91.16.2026.04.19.00.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 00:19:57 -0700 (PDT)
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
Subject: [PATCH v1 1/2] accel/rocket: Fix prep_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
Date: Sun, 19 Apr 2026 16:17:15 +0900
Message-ID: <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
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

rocket_ioctl_prep_bo() returns this 'long' result from an int-typed
ioctl handler, so positive values reach userspace as bogus errors.
Explicitly set ret to 0 on the success path.

Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index b6a385d2e..c80847192 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -145,6 +145,8 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void *data, struct drm_file *fi
 	ret = dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE, true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
 	shmem_obj = &to_rocket_bo(gem_obj)->base;
 
-- 
2.43.0

