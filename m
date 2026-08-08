Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C49FC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88D910E68F;
	Mon, 10 Aug 2026 06:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFN08+O1";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9D810E08D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:25 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so716590a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228224; x=1786833024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0T8hsbR8l/QSpKtJo+gqmSKNs2cFgYd9YKdYEYcvNTs=;
 b=AFN08+O1HJl9tSi3CbGwH+A0jMCfsV3L95ZTjWqVhga+6Gc1eHblxReVRVvoV9IJQ7
 EpYTGwf3iLYOMSc5cbQ5vjyIIJvbe9fXuzqdHx0+1Kjzq1BT1Pp0q4ABgcUr/88yHCYL
 wA9f1sNlUaEJfWL6SSqm+VDNT8yM4PAZBWruLC0VDb7ovf/YxGrZEsYIWSQBEqWUN0Ba
 4mfL+LHmcaJprU0X0hslJ3NoS+0yj2mkiNx8sf+1MKlXmTGFIC5r3rEmkjZKGp9YW6x/
 DuO16TKmQprHnF2SyEoNtQoildLFtroGeeEHUxiG5qHt7t/boh1QSWMRBXfAn8/Nzp9P
 q4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228224; x=1786833024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0T8hsbR8l/QSpKtJo+gqmSKNs2cFgYd9YKdYEYcvNTs=;
 b=NtQPAfSE+FGgQI76U/CJRW+kHuVeJAuLppw6UQNfOumleCfgpuRyO9F0V2bafeLEa/
 5jL0LZAecGsQPYshlc/UzFRGPokK4mMtRfcWMGqhkKtEPNe17ZuxNhWACPaRL/HPEO1T
 9Cs3rNvDE76GCi9qbCOlC1QNdoOqXtqwxU1C7YmQMTiPmLdvyrUK2/A0puV0rNHwokd1
 tqatAF27KV7ztYt3n3VfNiOwKNkC7aJjN/UBSqV1u4GSJzgnPjYfx/hUW1/Jh5c0wzOk
 z0WZaUcrGj8Zu4hZnL6VGuGtF2Cce4QbNoCX0yD56wcmUAXlyO6pLtUrue3WudXNmFeH
 7jEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnSMMrv1k7FuNx7gbeIJ+gSM1doMIMDmjsUJTzkat5acdqr7Thiyv7XcRgNl4tcarQxvaf0qStP/M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvMXwS1qL7oH5+KbTOoPlJKTlIKogwZwSAIt7htQYTh2LPR4yS
 CSBPlB36Oy98f8UL+8dGvdjRKWD1j4DGXnF1/8thkPzWVSmFLUUE+pWW
X-Gm-Gg: AR+sD11xNr4X4JwWp9XVe7Mkhrzr8y/ru/tC7wKmIShsHkXYHKfWPjOTanV+BnQDFxI
 B2cA4gCuUNhoX+GbpEw5FDApd+Uuaq2BmTGxRz726f7Xb2zqN2bJU+K/2ocG/qxDhdDMZRJeSo9
 YaIOVoNCDV0uDa4nS8pELlXM4Dw0nrljKNU3S53SwwuRvyP4HXIqFuSGoXEG+o1IEjMKTICuTAD
 l7mYRWTPjOZ0oFKJnP7JHLiUc+NLa68HLwHH5TPbfeea5dUj06synmqOtbPvkFhgwj4bt8kd8yv
 WAFpUKJAwvUIS2yeBZ7wkplKXyb/k7Fu7ChfOn6Dq76Ms7vdgBk6yTVQ0DRU8TFOhb3FHx+rd5R
 tAp3sl+P4Bf/eeD2E60Y1MDuryUo3OOyT24saDy5lIPBTu0hP3z8G1xD+l/ganIhLzyCrNwVxgu
 yCtn9uHISp+wG5tFmNRrWKzLDPwSKVAeEt4fib2aECYcxONPtRBb52QGNLJWnPG9vp/3DfYWhI7
 2/I3HV61t6j/l0HX3W1aA==
X-Received: by 2002:a05:6a20:728c:b0:3c0:b4f8:bbfb with SMTP id
 adf61e73a8af0-3cbc03b5531mr13804904637.22.1786228224701; 
 Sat, 08 Aug 2026 15:30:24 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:24 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 5/5] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sat,  8 Aug 2026 22:27:42 +0000
Message-ID: <20260808222742.2859-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index f22b58c559b6..c2fe98b83eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

