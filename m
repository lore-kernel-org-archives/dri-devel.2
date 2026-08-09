Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C910AC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0ABA10E681;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VL5J7qE3";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D232E10E0CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso7671235ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252401; x=1786857201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqhs7Zhem08+gKWpC13qqFjQ+/RUK8tqoU89vwfPtBM=;
 b=VL5J7qE3qxFHU6hRo12QC3WduaqsVFW1092Adb+6YaljE5Py95gMBziYJoJqo28z37
 4Kc92fod4vocr9Kiv7aSkKbiLAx/YewZH3703hxNlSKmweNg/ScobbxV2ZwyJ/PC6Xv/
 6Sm5lEZLsaMgaqldHory4vXpleo287di153HXaAoIT/KQx8jmx6k5xupGQ6frGi/ItjM
 hzN6foZg1oeDEcTFOIThDXi44HTL3tA5KR4g0GzL8U5I+RSmceJVJWkYTfWw7LgPNN1u
 7dB982gr40nakYYPyVlMRnWLvNZruvPaJTRVT2eovoh/pbiIbVwN9h5HZzyplrwGuUjh
 CWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252401; x=1786857201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mqhs7Zhem08+gKWpC13qqFjQ+/RUK8tqoU89vwfPtBM=;
 b=HZNZ7kwbSKe9li95vlZA+TQA5q4HXEhk5w8rgqdtWtpZAgNnxjrz5b8hx1FLKBBjS9
 rW0Iq9ONa9k+OO21WGv8jdKUklAa6WynfRNce+l7LSI5/wxKuDWH/vs4CYerjkx4Z8AJ
 gqyaZzRuHUGS5bVZl+DHTLNrRhIWBcvtgasPak9pU/CAcbIc8j1SCD9I4xtpbzPqeQIE
 /YZ6ZBXK+nWfUdyCUbiZx9UnSs4HVH8ew1ZS8kPFTOF6/DcDOXssZOVirr29nQPAcF34
 F8zVmBWVyHyyHOWvcPRJubg1+OQ0mPev9hYYEYfl6lhl0eEjtNd6vEmPGq66AiwTEP24
 xw5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUk8jnKUiqFMy3en1If3UwK4bZldk17BZijlXtaLHr0wb8xk0qr7331x5F1iqlt99FUF5OEfxxTJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH5NjJDRKgaMg5lOsejO9sC9luGn5ak9jGfFO53DkekybISW+S
 fMk+na2a/4hGTVeqS26Ny3jCthaN0tZS8mOBBiEcFpAx5xQs1GwbQTXn
X-Gm-Gg: AR+sD10ogTbXcaU6q41PgoXVCFcttcYPQUV+W2bZjYpxIWoNmLAgfUqkTqXEsYjiCzJ
 QWa5gNYuTFMI8BM9VL1ki6r8aOqnWpRRqbOs3nI3WMrUvCqoVMyvYkxYbphyMnMlrVRiYHAWqZe
 kXwJM/JTjt6eIwT/YAHKiEz9YM3yGhRvKV5yCD+2I2JV+ULjmg+Et/7qYXhqw8Ats3FZVo4Eh1F
 BTQWWhnKMGtxOYRmb8GJOOHpw7nucDpVu3QJlncibOqLl5Kl39GuydH15qriHPSibZidsThrlD9
 XLFjmIvJEq17IliUW5ETAqLasL1Co83PQrtn4oNkatfmxu9weXe7uYwT5IF1p7JcxVhhsvnjwcp
 +W29D0/VH/Glt2291UTHmFW/oDOfpX6bUTjLlc/Tk9TfwCZNyhF4UPpRJbPPnaNuXlOBVRgC/qH
 v0vuhTji/UikWLhkNMEPqCcqnXL/w62umBuWx9onQ5pK038HysrhptUp9lDAN5N7qGrwx7h42ZH
 78n9dMDAKUfguEFxzZJ5ZY=
X-Received: by 2002:a05:6a20:9e0e:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3cb85efa4f9mr43331123637.21.1786252401232; 
 Sat, 08 Aug 2026 22:13:21 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:20 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 3/6] drm/amdgpu/aca: Fix inverted validation logic and list
 cleanup
Date: Sun,  9 Aug 2026 05:11:57 +0000
Message-ID: <20260809051200.3276-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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

aca_handle_is_valid() returned false if !list_empty(&handle->node)
evaluated to true. Because active registered handles have non-empty
nodes in the handle list, valid handles evaluated as invalid.
Consequently, amdgpu_aca_get_error_data() returned -EOPNOTSUPP
whenever aca_handle_is_valid() evaluated to true.

Fix the logic in aca_handle_is_valid() to verify that the handle is
non-NULL, contains a valid mask, and is currently registered in the
list. Update amdgpu_aca_get_error_data() to check for invalid
handles and return 0 instead of -EOPNOTSUPP so non-ACA blocks in
global RAS queries pass through safely without breaking error
telemetry.

Additionally, update remove_aca_handle() to use list_del_init()
instead of list_del(). Standard list_del() leaves node pointers
poisoned, which causes !list_empty() in aca_handle_is_valid() to
evaluate to true for removed handles, leading to a potential
use-after-free during device teardown.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..06cb3ad1ce62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
-		return -EOPNOTSUPP;
+	if (!aca_handle_is_valid(handle))
+		return 0;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
@@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *handle)
 	struct aca_handle_manager *mgr = handle->mgr;
 
 	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
 }
 
-- 
2.54.0

