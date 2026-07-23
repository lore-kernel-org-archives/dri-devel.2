Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEE6C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D77410F184;
	Thu, 23 Jul 2026 17:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fHWGom5G";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0970110E366
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:49:24 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so718135b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828963; x=1785433763; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sIFLg1zYJZMoKAp4r00Jfyq94TfQcukLRikqEzkbTLo=;
 b=fHWGom5Gmtlrk8LrV0vM4OeLaNb1/yRYPqWIE8oxmYWKmy8/IWGwgfXa1w41Ch5RHk
 4dy5gy7szhHE5dQbURmyLC+wkGckOcpYizkkE9pe++n00ixosHyupQxkUY4thK+uRxVX
 +0ScDQ+S1E0roJqtiJUhETsZOUrjuX9x6zvgeKCdiRHF+t6pjiKUYYQNXgYWvIUe1rSf
 v0A3fSZ8UK6cUiiS11Q5N+H3Obtb0nF0sFaPm5GxKJc38z2ay8ks+oC9zAIz7KZl5hbl
 P9nYX2ii5t5lKjEyuO9fDYXHhAAHQRkbX38SKvpeOOp77pXv2FKfHFKnLc+4anqYCR7T
 SHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828963; x=1785433763;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sIFLg1zYJZMoKAp4r00Jfyq94TfQcukLRikqEzkbTLo=;
 b=bspcp+D8OLes+WfPuIqsAo/aYByhYXKAaS+RhGTLIoKRuyxagOheF5QW8hsIHJHRst
 Yz+5E2bAwtpZlH2Gzn6ByIvREdlMPHTQTNdAm9ixN7dj2vVD3oqVfK62O848Zeqgeh0C
 Yficgb0ek2iLffnUrwEZwfqq71CuV2tLgO17QF4WET54ItBaIdmBEu9CwOHC/BKqSzzr
 N4r33uACBMMcvV4IK/nc95ZIPlvL24gs+gMwzBeDebKWEzhk7Y+eOgCxPY3eTZqOprd7
 Ef3f2Uepp4nrFeMWdG39X3zJl1p4cr4ALFVz68avapvzGcvGHf+6y2UH15A//N5LcS4p
 ib1w==
X-Gm-Message-State: AOJu0YwzsrD3SKnjdcUPKFhEQMEUHwahzLxxn8iK7p558goamvOxaRZ/
 lOK/f+ALkGqQWnr180LosBNz8J+fpYYN44UUWkOhNHNHvjkVDbBqsJhq
X-Gm-Gg: AR+sD136WnsUZHgDPrFTZllTomj+kH4YF8pQm6OyJjzAm6Wp+mbcwOXXB856XGxUxBW
 0XfGVVzYRmcRLkr6yPwoec51rzmG1gjlIwhMwwaKdDwjV0RYJLAE8+77Dt7+kOX4WKGgCGtsDP7
 bx7CvCh6CMMUbrO1JtYdx4KqFh1JONz+Xfjz+FbHY9tTr9pryCKJmAlLrPGOQM/BLLq9B2GrI7m
 P2Hp5Q5AXqttVqHk3G6UuDHyBmvLaSwW9A5dDoYrIXJ/m2TQHCv3ZV8d/nuIckcIT9+DrAsZFUE
 lC5hN6yKVwugZkUOvknvnA68ORx4osTDu7d0K4KThzowIM2oRVVDFo+dfpXlB1ZKQvcDg2UxsJ3
 USZV+iLjo7P/JUq6aUmf0P3aZWNs4nFQwFDaxSh/SVQhZl+SWYRS7n5xdta/yb1l6pLiLr7fYps
 iRoU7t7uobQcDrGQcrley/wUp6acZvRdyXOTIHbOh6f+2Cyvpm9iCf8N5iumw=
X-Received: by 2002:a05:6a00:3d12:b0:845:d6a5:716b with SMTP id
 d2e1a72fcca58-84e2b8bf867mr4669228b3a.23.1784828963497; 
 Thu, 23 Jul 2026 10:49:23 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175f31b3sm3493036b3a.54.2026.07.23.10.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:49:23 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:49:02 -0700
Subject: [PATCH v3] drm/gpusvm: Zero HMM PFNs before scanning ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA1UYmoC/x3LMQqAMAxA0auUzAY0glKvIg5iomawlgZFKN7d4
 vj4/AwmScVgcBmS3Gp6hoK2crDsc9gElYuBaurqnlrkdOAWL7sPXPURQ/Y9M88dUeOhbDHJH8o
 1Tu/7Ab0vemJiAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, 
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828962; l=1598;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=exTnfBbobbuTKp1u2b5AtcOE9fa31gkGpbomdGBMpI4=;
 b=ndvajkSdPCoDMCJTXGf2I8MdXQUSYNj4q4sKROa4o5f9YHhrv0ejfGLg9Y1MTB278wnpXqOLY
 I0x6IvfsVSqCCoDKy59Y5h827Xrt++JRfwDHNHXduAWhf2J16fAQDNa
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=
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

drm_gpusvm_check_pages() asks HMM to report the current CPU page-table
state without faulting missing entries by leaving default_flags set to
zero. The HMM PFN array is still caller-owned input/output state, and the
framework may preserve input bits while filling entries. It is not safe for
the caller to hand HMM an uninitialized array and then treat entries
without HMM_PFN_VALID as an authoritative unpopulated result.

Use kvcalloc() for the temporary PFN array so entries that are not reported
as valid start from the documented zero state. This prevents random stack
or heap contents from being interpreted as HMM PFN flags or PFN values
during the scan.

Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b946f920b7a0..52573626387c 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm *gpusvm,
 
 	mmap_assert_locked(gpusvm->mm);
 
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return false;
 

---
base-commit: baa47c6547b94a164b70924e53d2bcf16f483e6c
change-id: 20260723-drm-gpusvm-fixes-d97ddda62219

Best regards,
-- 
Stanislav Kinsburskii <skinsburskii@gmail.com>

