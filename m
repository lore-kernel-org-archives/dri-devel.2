Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FD0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F0310F0DC;
	Wed,  8 Jul 2026 11:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByJ4o4xo";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A221C10F0DC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:44:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c6b67d5fa1so6352465ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783511043; x=1784115843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4suNiv2yUkpcu0FQfwaTGnjQpQAO2D0FA1sYqxvGsjw=;
 b=ByJ4o4xo6IpxSw8ZL+suSZjX5e99lotpMACwWwjy2LTnFuERJIJHawc5VWvlM1bm2/
 5Py9nNX5tYFW3hUo+es0qFJjKOwquxEyIavWhBn67fkaADzO+w1MLYvUGKsUlZzgk2WW
 PV4IlOAufKNeaKHIAtXoVd1yjSs/DAGlaq92r/vntJInSzamx9jZ4CbfcC+vsdpLuoGs
 +vr6ZyQqGq2VS0SlW1ySusuxkobqNU4UCXAa601Tb1vlGVwBezjctmC+BtsPWFPgx5K/
 9uD20+uDWwInqEdd+NuYwvdvhlxK/MP0UPmxXc3AIc79jvMa4axT8ch+h8Eud287FXjB
 kv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783511043; x=1784115843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4suNiv2yUkpcu0FQfwaTGnjQpQAO2D0FA1sYqxvGsjw=;
 b=AOGvQZzQPDVMlGfX6xFOoQ9kXOUjIG3Z9aAbGvxWxrTMgV/xIvbF8U9fWyPkSJvg2t
 qYbdgCdhHQakuO+yLzk0jMEG+qNkF9Nb2xlGbwABLOeVxTwQf9irry/wrKl9cMNfBC/P
 Oietko5Lcma6pznZYaY46vuX9T3Y55JMoyYnSa3/Winb2RNvrx2beBXLNGhCQS5M3LOY
 5dIe8ULPUdbNo5hSAMnY9wbxpvHdQfhJ5lFYG3DfcFhUtW790tRGosaZTt96Aob+NGdd
 F9F3Q7tGPshmsW5DeAE3hWhIwnofdUnhqbKf6o+dh+5BXuB0MY5Vz2XJ8AHtDHxNPDfA
 iApg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXUiyDFjItZw67Ap+8G0Uza77ZaLzATuRtRrJUkvwr+Cg7lcYfZmLcH4WsAbsM6d/kItlyIEHJe3E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS47gJ79CxgGP97BsV53XvySXYKUDhk7Hx5qIpY3UX+U3RNWOf
 qlzay6lD7GfzDT1qAIMXZbt5ZXvkTES/tkTzaNhfRk4YrFwCao8CWKHl
X-Gm-Gg: AfdE7cnwDi9plvnyxW18hl2B3NJj4i+0cSccsngiRhR2uI4JqGTowqXM0rJ/ft7uMrW
 fEcuVeWJqTH/dq6AVInBLTKJWWmnA4xCHluimVvGfpwjsCDEwxtGmyMvzd90F+yL0bpj6I7dcGe
 4S0U+gj40+5OnhREHorfYI6ajtoAKrbbLO6cMwii+bb29cindTMIwlPhN68WH8flD7lM9tUhdbx
 zgQlreETRI35KtK2zCy98PX1za9OO4zTKcjss8+zvksqkeLZGSI7YOTpxHUMIwXT/ieH22Om7UU
 8UmgMoi3bRQ/OjVDGF4tkBYlbzxF3seT0QsPzbrZKtgZV/G7CCLk67WQsguqdyLu6zRYVwL3PFX
 408GGTjnPzMGju1YkMg4YuJzPYQcsi9iwhcz77MZbzPGE3QnoGufhU+EgirHxavE2Gu1LcqEl3e
 ZvLw==
X-Received: by 2002:a17:903:1b2c:b0:2ca:c01e:8837 with SMTP id
 d9443c01a7336-2ccea444eb7mr22149085ad.24.1783511043079; 
 Wed, 08 Jul 2026 04:44:03 -0700 (PDT)
Received: from lgs.. ([36.255.223.70]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb86bsm26859875ad.11.2026.07.08.04.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 04:44:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] accel/rocket: put IOMMU domain on BO creation failure
Date: Wed,  8 Jul 2026 19:43:54 +0800
Message-ID: <20260708114354.753817-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

rocket_ioctl_create_bo() takes an IOMMU domain reference for each newly
created BO.

The normal GEM object release path drops that reference from
rocket_gem_bo_free(). However, the BO creation error paths free the
object with drm_gem_shmem_object_free(), which bypasses the driver's GEM
.free callback. Those paths therefore release the shmem object without
dropping the IOMMU domain reference.

Drop the domain reference explicitly on the BO creation error path before
freeing the shmem object.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index a5fffa51ff35..438694ba567b 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -127,6 +127,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	mutex_unlock(&rocket_priv->mm_lock);
 
 err:
+	rocket_iommu_domain_put(rkt_obj->domain);
+	rkt_obj->domain = NULL;
 	drm_gem_shmem_object_free(gem_obj);
 
 	return ret;
-- 
2.43.0

