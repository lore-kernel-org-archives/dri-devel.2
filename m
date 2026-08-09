Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AFEC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2A510E648;
	Mon, 10 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LtITbrJ7";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9771910E115
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:47 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso660776a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265387; x=1786870187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82v9sYNKKB3ALGXPfLnFRe1IYhxbaPWojRznailPiqg=;
 b=LtITbrJ7uDzMBhMHq5qSzDiSmVbZxEx/PeTs/um62OKtaT4ku0N/L/cBHKz3n4ucKB
 zShY/ewK0MaIvLW66xX5E1bAY6OQzZXentwilPq/tQLhDIxz4gzpwoRwUfzHfaHl1wtL
 RZiw5rIMt7ia32EAdMzMGEZXWxXgAHHuM+ZXXQW4A7mw/D6PO2wADx2+huukpxbq63Rx
 ClnvKCx4VtqbbLMBuODjiJgGaXIYvpg//pGiBDpqU6mX33XG9QPsOMHhsU/vftlTWBos
 VWhFY/MG9hLO04AT6agTsEAKN+y1vT5fBFotkk9MIR5t88Rf6yGAQx4328y2uong5unD
 wFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265387; x=1786870187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82v9sYNKKB3ALGXPfLnFRe1IYhxbaPWojRznailPiqg=;
 b=ia2Hkvy/8ofEDocj3SEX2+YDhnjQwunN1RLij4OcZ12z/usbFjnr4KLHwmeRRSwNWC
 SVqlzu1m9XjLF5Suoh4iXL/J6uXdZeQXinAwzKvnlcd3GDIeQv8Kss+WvC3nIL4QVsX9
 JSY/1UITqFBisXDqAJ+yifd0A4ModhSaqoR0xPZJuRxiBSd8NUootach/+83+QXHNTJI
 k0j0CIy6hCCWB7MjeZNBpa56cT/+83pCBAvum9zZfuS4IGkPCZ/pIyl1A/zBJMgnH/00
 Fqhk9Yos7aQxcgTOh2HuVS6KWXcnyIWZ8oz+UigvAiNe2YSJVnB3duQo84uBKLRTpalm
 7oYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxcPSTRiGJrA4wbw6eRH8yuzoA8ZrTi47r40j2HB6cOh1V4OQBZnF5P4X1nws7Ivlw0Ed2UnLZTiQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5ATYm+Y5WCO+8tKOEVcK4PgblMRlTNLobjE2MVLrNjB81lSXq
 8e/+H58nzIXtLZ2UjhCIgrTU9+v7h5Gr/awSS/97YhJnqi3dUGA7TAig
X-Gm-Gg: AR+sD10+mcm52Zfv1Ewkw8kxKHPBfTWDflKJ5dcicQMDpvIjGdKZwE7aQfkfFVpwhnM
 8jlBt28brSumiZHYlo4XjvZa0FovQ5lKOidLk1HjnL/GB9RQOT446iuuy2zh1vnYvbyGtpdLCcS
 lg57fxTdKp9AZ1WcO6oDfojpnskXn46W8NjqRc8I5HjXW8qMeCxftFxjPH1uZ6b/lUBs5rM3kbK
 RRaRKOiq1tgOPYBhHD5IrT0bFuyiHCPU7CH8jsmce1X48uvZFigZ75C+AuuMXLvlLoeLTdXz9st
 YV6+EjXWnXCP6EBkhgsSo+VyXDX2OQ45z8ZqO7HBMOwFCFwYT5/qu1VuBGvWluFm/g1RdWsaAOM
 Her7g4ewdXGMas/rs9XBYpUUr3OEaoXLzdh4ptjimvi5++B+q4mkY9qIFSUW7s4wNRZyGFgmw5a
 boZ0lq30oEY5lVLjXXOmUzZ7jdJs26mjKFGnlon9qztvG2r+0UyEBCpx0EcJ9GRWQf3FZV+p+xn
 N4g7jgcirw=
X-Received: by 2002:a05:6a21:600f:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3cb85e2b72fmr40290617637.10.1786265386693; 
 Sun, 09 Aug 2026 01:49:46 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:46 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 3/6] drm/amdgpu/aca: Fix inverted validation logic and list
 cleanup
Date: Sun,  9 Aug 2026 08:47:32 +0000
Message-ID: <20260809084735.9743-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
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

Additionally, modify remove_aca_handle() to unlink handle->node
under mgr->lock using list_del_init() prior to calling
aca_fini_error_cache(). Standard list_del() leaves node pointers
poisoned, causing !list_empty() in aca_handle_is_valid() to evaluate
to true for removed handles. Unlinking under lock first prevents
concurrent list traversals from racing on node pointers and stops
background queries from referencing destroyed error cache mutexes during
handle teardown.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..c35f6be2ef77 100644
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
@@ -716,9 +713,13 @@ static void remove_aca_handle(struct aca_handle *handle)
 {
 	struct aca_handle_manager *mgr = handle->mgr;
 
-	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	mutex_lock(&mgr->lock);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
+	mutex_unlock(&mgr->lock);
+	aca_fini_error_cache(handle);
+	kfree(handle);
+
 }
 
 static void remove_aca_sysfs(struct aca_handle *handle)
-- 
2.54.0

