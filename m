Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD463C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1911010EAC2;
	Wed, 19 Aug 2026 06:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IHfN1OBG";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D6710E4F1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:09:25 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so90646b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787069365; x=1787674165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uN7sYzsQRFtV0+ay6zfSuqHvW15YAK6EgSyyZ0KnPRg=;
 b=IHfN1OBGk/M/oP1TxDLngV0y6Ew2fkKMugepNux5dkuCCgETG6ogg/4OcXW+4kTBCF
 KlkPwJKAfBjs29dDrI0gdo5jbYCrQYY1U1IDAF0MXaS7r6TbYqTtNCdKXn3bwI6HKc0X
 SqdjoLOWu9t+ADALlByB6ZoxXOTfiVgGsGM0cfPark3MEzwm803AkrEWgd9rdJxFfKHe
 0RxIzpur2cZOjxww06KbxIgEo7WayGk4xjr6tlC/1eed+S14YOI0XuQ1957DvUT4vlWw
 smAp5wGFb84SfSJpMfXjaOE1g+2rZ5spIEoOl7/bdFw5oaLOLVEX0yORYpOaRhHU+MaU
 pAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787069365; x=1787674165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uN7sYzsQRFtV0+ay6zfSuqHvW15YAK6EgSyyZ0KnPRg=;
 b=M96eJcy0FJwGG0CqcD3ORbJFJz6GzWdyflfLsIT7/ZtguPQmUfqTs8Z4WoRFJnCVAM
 h3cfvf1PCCXT20A2ReQNg7Dtp0Z0JO8ArHO3N03ITCEngdwMjQSDDwmvjs1zsiYFsyIo
 hdTpilmouLQbDfwHDhKtV+LSnaMzroK0+iilJ5p3x7AlWksDZP1Q7tkKhQZg7/iPGbDb
 BrHaPVpFwORk4tLmGB4nXxpuYpAFWgYaKVlC75Enzgug/hUfjdIaxQ8SFSSVMeJEdPNn
 CTnHC7DoIQxhA4kg+dSD0yGZv9uObPeKXAxLv0sO7bfItPNXZEkH1cVgXBBUJkDUHIBj
 /2Vw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp993AaiYB3dPPS9Skw843o2G+D4oVcfZBW7nV4GM88lWjo2YGZstDhYIWWbbDTHfpnBxJaGcrSw+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXhaVSU6WLJth91GHI0NWL3mAew/Lj2V5QyV6UB0SnFsDRFqze
 OrmGQdDssZhdAeFrMKx5Y6jvXRbHk6z0QpFqZVP528kSoqdXtuLq1lPX
X-Gm-Gg: AR+sD12kdtwooOba8lL44LcMx8kzDZ3y2yvV7n+DvZ3ypQLBaPHgFedIya2Dm46eVwo
 2jptH8n6VWnWA1C9yYgeKyQoAOAFAvQo9uMy7tOOpNNojQY8UvU5bclQtCxDhAsKITCVMta8I5K
 5Putbd0JBQi0E5MS1eNmshQoz7UMK4Kgb+uhGlqkZazkKA3k64LqnYD9dp6OSqpInXDbtVraQ3E
 wMXLNA3zKiiMi/yr3Hl1y9xkTrVeFptlrbJWmRrziw9f2Fl7BZ0fuYZarsIUuWZ6Nm8TSb+1xFs
 k+WrJi/DBpL49VxzOD77U0yrPgp9NSVdV9uOEB0ZY9UY4dvilw39Mv2G+vDdZ5yxd39CwOipUPo
 nQNJpj4JRog4sNTfYDMD0Vzc5LDCpSBZunCZdNL43PR4fMwKHmTm0ubYI/GKl+NlUPFoQIWfVip
 nmSR0lt3gpwQWNMeg5XhcmJ4R7+vC8mBEF6vQTSHX9/tIXXHD4VqxccYIOEeWZhdnWS/TNi4fur
 NhJMAK3gN+S3kp8fbBECGt9ocoGfpLRG0r7LAPxIvUD7t16TnZGyxpJkQ==
X-Received: by 2002:a05:6a00:180b:b0:84a:6726:62f9 with SMTP id
 d2e1a72fcca58-851b880fc71mr11491461b3a.9.1787069365236; 
 Tue, 18 Aug 2026 09:09:25 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1469e2e5esm1007767a12.5.2026.08.18.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:09:24 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1 1/2] drm/ttm: drop stale @ctx kernel-doc entry
Date: Wed, 19 Aug 2026 00:09:13 +0800
Message-ID: <20260818160914.108313-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818160914.108313-1-seanwascoding@gmail.com>
References: <20260818160914.108313-1-seanwascoding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

ttm_bo_alloc_state no longer has a ctx member, but its kernel-doc
comment still documents @ctx. Remove the stale entry so the
documentation matches the struct.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18ded1b..943297b49dc5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -506,7 +506,6 @@ struct ttm_bo_alloc_state {
  *
  * @bo: The buffer to allocate the backing store of
  * @place: The place to attempt allocation in
- * @ctx: ttm_operation_ctx associated with this allocation
  * @force_space: If we should evict buffers to force space
  * @res: On allocation success, the resulting struct ttm_resource.
  * @alloc_state: Object holding allocation state such as charged cgroups.
-- 
2.43.0

