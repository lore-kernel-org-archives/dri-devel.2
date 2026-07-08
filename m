Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA47C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B5710F455;
	Thu,  9 Jul 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4lvTj2M";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2A910E420
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:20:04 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so2560525ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783480804; x=1784085604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V00ddkGI/KEE26qqT+p1sjeQx+QG7PWUpGKZprTz5GY=;
 b=O4lvTj2MhBaQxvPGR2SN7jKgWRA6CwDOzVDkXMbO5WiJN2e6oHbCzMBHUlxDfyRxlV
 NW89ScIFyZEOMzNID3TEZ0laX2cqkKKMv41z2rzZVunwiEex92f82q7bnKxcILE44Nil
 IeMzfBQxNfS7xgx2mCe9pQXV6i1XWPkrhAHEsYKDxm/YXUW268fFqgjZWaJaVgjc4/Ix
 vC0uvCcpxb05kNMcUQVsHnqoIiISfsXkDW4mnzgiNpbFlX29aMUAiRgpGqYWOYuadpVT
 EFbjGgkULG3ehI9x/n7f4mnUH5/oOINe3yLer8o+ZXIN6IsLwzZy6xARymKndONqJTJh
 ZF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783480804; x=1784085604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V00ddkGI/KEE26qqT+p1sjeQx+QG7PWUpGKZprTz5GY=;
 b=BGaXcbOEMFQLlDPU59KlbLTaYYJDDJRjj21gvu/l/bO5SFMjEkOtYwUBheOm+NN7IU
 m+K+UonKg+aIQkQeFlSj5wyak7FkvHFcDc6UxsMKGlJQES9oOCdvnCdgL8Y2O4nWTtz4
 QBVs7bR2bb/f4RITy8BuIco3P99BOXwstYdXJHNTe1vtBhWT3zM1Lxi2QCdzlT0MogL7
 YxsYmmdGoobMH8ZjOU6ty+d5itVljHPSUsBllvfd4kfa5hsMKQn/J0MswMhsEY6CW6Nn
 13Mp3Hbo9+n9LEP/l4RRivRPOdTeaeXhbpKCBL2nyehJANGz81Zbqz9CkIVaBeql04lu
 9JlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFnL5jHSmxCRk+jpbQsEPtKPHkgV8PQ2vJtn9ENh9Dc4ysY+JqXH93RGBs13kpANq2Nsphos4QQ8g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDeOz/RVO3yaoTjIBXKpEzX3d9d7q8l4ONFs9wT2HkKfHk92ra
 2TfxSRRHXbvxf1hodSgrjxVRqddUyaev92KMHK88oHH30nPOBKc48oPP
X-Gm-Gg: AfdE7cm0QMrT4lUIQZISK3FpjL3zfASUxCJ3CH0mpOHP+cuZmmgk3YoLPOcrf6i1iXJ
 nLgebcWDGWuVxD4faN7pSjE8rtSl7EXUcEU59X0EE6CuZAoPlcYRYoWxZkUisJuDLXwPiHCpIXR
 QzBEKGOafInASzhW13yOudlg/J1IfSsDwzlk8TES1GWhFbhtvUHNQJrQ8usMmUahkQjgn0ATNC6
 QOV2O7AxCUST+M5F0fSG1RJ2b+Zi0SP/cfgaX5xuNjNS1GlNgLrOZYVZiWc25NyT+uCAEUlySJP
 PBTpx7h8eAIhZVxCl0Lg1VDSSDU78IUDAvzR5jzP5a4YdsfOAhekKqHr+zg5IWQAIBMxF5w52nX
 sgIPVYENw66JCPDyXgrizZDZGxnRdIIoNeBbwnR72FS0sf1zJ6OP8q9LLEBEAQGc4LfQRqvvldy
 IkNqILVKfbnCgm0YK/dTvvK/HG0ol8kIPBelzZUvDDjyz3
X-Received: by 2002:a17:903:2447:b0:2ca:619f:9733 with SMTP id
 d9443c01a7336-2ccea3c0f1bmr7181735ad.17.1783480803608; 
 Tue, 07 Jul 2026 20:20:03 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([49.216.173.166])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e914sm20421655ad.50.2026.07.07.20.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 20:20:03 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hao-Qun Huang <alvinhuang0603@gmail.com>
Subject: [PATCH] accel/qaic: reject BO sizes that overflow page count
Date: Wed,  8 Jul 2026 11:19:59 +0800
Message-ID: <20260708031959.966009-1-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

create_sgt() receives the BO size as a u64 but stores the number of
pages in an int. qaic_create_bo_ioctl() page-aligns the user-supplied
size without an upper bound, so DIV_ROUND_UP(size, PAGE_SIZE) can exceed
INT_MAX and truncate when assigned to nr_pages.

When the page count wraps to a small positive value (for example a BO
larger than 16 TiB on a 4 KiB page kernel), create_sgt() succeeds after
allocating only a handful of pages while the GEM object still records
the full size, so the request never fails with -ENOMEM. The temporary
pages array and the allocation loop both use the truncated count, so the
backing SG table ends up smaller than obj->size. Later slice operations
validate against obj->size and then clone ranges from this short sgt.

Compute the page count as a u64 and reject sizes that do not fit in
nr_pages before the narrowing conversion.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
 drivers/accel/qaic/qaic_data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index ef0351b6dc9b..4d55531bf1c9 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -15,6 +15,7 @@
 #include <linux/math64.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
+#include <linux/overflow.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
@@ -455,7 +456,12 @@ static int create_sgt(struct qaic_device *qdev, struct sg_table **sgt_out, u64 s
 	int order;

 	if (size) {
-		nr_pages = DIV_ROUND_UP(size, PAGE_SIZE);
+		u64 nr_pages_u64 = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
+
+		if (overflows_type(nr_pages_u64, int))
+			return -E2BIG;
+
+		nr_pages = nr_pages_u64;
 		/*
 		 * calculate how much extra we are going to allocate, to remove
 		 * later
--
2.43.0
