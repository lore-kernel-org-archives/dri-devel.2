Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5D3C44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B551210F1EB;
	Thu, 16 Jul 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjUtYql7";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D60510E0E0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:45:16 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ceae1ed204so18232875ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784065516; x=1784670316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=76ycW+rBxOZYacJ1Dbj+MtJGsoesj/kofKqPC3AXyqE=;
 b=DjUtYql7HCRwn7/CEQpU4n/PCycgq3HpOS0lJ7Ont5F4TQ/vr+c3DkCu8RApWL8psX
 uB1+oU88VGlFV1X0nd68zM9Spho3OQiL6GbP9hSYmmvkm293jdqjvi/Q+KmnMfsXLnvq
 Kzv970wah9rhIy9QXkNbcFVN+/PcnJ8qTM/OMdyQa7Gw7DGh5ZFMdU8FdoRHzzvpzs3r
 N62PYE4HeHQlr3znJJF5q/lW0HGxKKI5ZxgfLcDMY5n2VooBr54MMzvA8nNeTAElDowf
 2G9VS2Z6iRMzWz5fp14sm+e/00a5mLFshVWbRYePAgyYx7p3hWf9MLQIWZegnYZQtuac
 LlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784065516; x=1784670316;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=76ycW+rBxOZYacJ1Dbj+MtJGsoesj/kofKqPC3AXyqE=;
 b=HHRj6pA9Ki38hrZdyY2G0CQoM1KMhUb/Dp/xl6jbO6acUPi502wO/PsdukiSfEZr6A
 sNuHkVmdgoR6uM/kPX0eqmrbp+OIG4PnIi3bu2HtymkZa/1cpy7ublHHiWE2XlHyzDJH
 YFpWPVy5OB93sEPzzLawoQu6LBKTlryvnuGW1ih4cE/fOORQ1pXWBI/jtPtbmJcVSWeY
 NYM2mzoiFdfy9AAZI+XuvKF7+uR2jlvQ7QfWV/ZisN2AqG6VEinK4zeWcw3EW6f+F5OX
 6rbYqzjM1LS00bIRj6mmtmDwZ//irWwuDcwsENPWVXbiwncdV91DmsFcgWH5OCvB4WdY
 tYhw==
X-Gm-Message-State: AOJu0YygUrpKG4N+xeRHfHHoU3tRDoDHbTyKGzcV1qfxmKgogoWngkgB
 bMv8INSfiY6hbOoOvhxb9wK3hUIWgm1lFVmqJVb1JFbDFcmHLGWXgGfJ
X-Gm-Gg: AfdE7cnTF+T9wxQu8aTHck4ibCFnntZ+zp9juM6fMqhZziiAAwWkJ9MI6AXf+T2M4Fy
 gPONvk/9Q81DT+NXe6ay0cq6AwwqXbwFQWV8FOz/0hd+qpORRdWa3BwboBfv2oSJ6sFjc2tgxXk
 QK9P+zP/CJ+gdZ2P+9f76Z1SD9QTjFXzSzzilj29NRxnGgbMNsRe5J+9RUDtsPTR4vOjYpZlg5Q
 A8Zkx9P7s9ioeW5BKZXo/lPwPRF1FqYFYr1zslvBHGnWHVfAi8y36GOaKJnF7GhC2ow08uO1cn1
 6UMy5C89Sk1mJ6yzlG3cZ1wqnbejoR4IoxAfyiXfn7l7oQDyo1fVurLEcBwMGBgHlab2RP/5BDi
 A7HvUifEPXDX5u9dbxs3pJ+Y2+OHclx2Xv2csB/yyXwBL4Gc3Y6eTI44LeoBAdELFsQyjrpk3PY
 01cB48JGOsIc0s98EmZWwszEz9P+g2OIohODwu87jjAluOj+1TZkOgbBBq8hE=
X-Received: by 2002:a17:903:124c:b0:2ca:3e3f:4956 with SMTP id
 d9443c01a7336-2ce9f184054mr145126485ad.44.1784065515909; 
 Tue, 14 Jul 2026 14:45:15 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e284sm123142975ad.40.2026.07.14.14.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:45:15 -0700 (PDT)
Subject: [PATCH] drm/gpusvm: Fix mm reference leak in range eviction
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Date: Tue, 14 Jul 2026 14:45:14 -0700
Message-ID: <178406551216.1092539.5238081578161393168.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

drm_gpusvm_range_evict() pins gpusvm->mm with mmget_not_zero() before
allocating the temporary HMM PFN array. If that allocation fails, the
function returns -ENOMEM directly and leaks the mm reference.

Route the allocation failure through the common mmput() path after
initializing err to -ENOMEM. This preserves the returned error while
balancing the mm reference acquired by mmget_not_zero().

Fixes: 99624bdff8670 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 76e8a0028c7f..1a8bb83bd28d 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1715,7 +1715,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
 					       drm_gpusvm_range_end(range));
-	int err = 0;
+	int err = -ENOMEM;
 	struct mm_struct *mm = gpusvm->mm;
 
 	if (!mmget_not_zero(mm))
@@ -1723,12 +1723,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
-		return -ENOMEM;
+		goto put_mm;
 
 	hmm_range.hmm_pfns = pfns;
 	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 
 	kvfree(pfns);
+put_mm:
 	mmput(mm);
 
 	return err == -EBUSY ? -ETIME : err;


