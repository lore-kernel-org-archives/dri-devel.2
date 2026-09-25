Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77CBC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D66C10E879;
	Mon, 28 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hzS7QWwX";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436D310E281
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:48:13 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so491620f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340492; x=1790945292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ffo4dEA6Q9fxFokWBQKy0RohhC70c67r7S94vQ6TDSE=;
 b=hzS7QWwXeMhuChthlbR9vsw7vmVJld/5pRvivG+R8zSw0WBFUP0Ey0mZqRb1kcyzKv
 7a24w0j4TEEpKIcdMHbjmovbDySDuKmb3L1YtZJPSUDE3giKYq6FXthhdIya8C4ELEHN
 HWeXm8+WhCfAm6lazCtJZOrU4pY+m2dC+5myfsKGOYK+v3fr1kC2eBClhfbXbc9/u6R7
 NOWFo/ZHOJ/yhEwDGSL4Xla4SDvQffW2cy28sQUz9DaBYLVZhWSGgJ/YabKW3iui08Mr
 dRHUUTr/Tjs1uiEzKhB6QcwJ30sVx2ByRZMkMEiH/zxPo9V6CMEhhOXVUHTRAUAkw+3A
 N+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340492; x=1790945292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffo4dEA6Q9fxFokWBQKy0RohhC70c67r7S94vQ6TDSE=;
 b=kYgyyTHKyOzLH1qd+c6SYXzSkzP8eP/rYJ2RrvSj36UdQkDl5+Wj5sI8Rqpn8ksTeR
 Z1zDRix6tARsDfVasnnf/ZOS0QvkmI/evNVzNc32w3drm4mMIGusqkaP02s2Xlk/sYMf
 C6oCEo1FRCE9zUccZpXMTGHfC0T9qY8pJWo2ZaSIL6MNxKmiDV2CMryOt7iqRlQaCQb6
 hI8ltbr8wsHB9vs/GAANMYxt7MPHWB8aLnfvxlXN3AZkLAhNg3e6r0CrKboCqcdzrGPZ
 TPDTKbc3ccnsve5Iqrn2gy8/X2yy8x3uFXtP9+VtoENdNYaOl+eGeFjVZBdjGXLuSUP1
 OpJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi/NPKSiCAZGPFDU8/uEEtA8Tcp80LFVtQSMXMfxEGyE5w3gyNqPfwzWMY/IW0SgBslyJxDe+ObXo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAkfsSkNFTZM7v/ZgQ/CzOTT0XDFdDvcJstpe1k7hYk1dT1ECe
 3mTqjx6rV/rdRLRt8+kf8y5GhWFTHnXnRpU4megoZ7rkOmX4lTuqnpRW
X-Gm-Gg: AYBFou0DYdmCrDc7ZkAI78dErEi3emsPkLCoaSvRkpbGSkvvaify3qhvHZJIZ36lx1+
 b1dkf6TumuWNBXaouBY1TEk33I3IOayxOSRXaEW4qaVXxjoOyzHMpial4+iCww8git2MogRwTPe
 GfXrT/Fc9ccYX9Xk8BTdvoTjHp2FzdzR9TcTOOI+ncZ3xLGC2eu7+l0uBSLR90qs+IscxGIJ2GR
 Md0X3KFNhc7bvzNO0kZsgtlNTwvgib10+/nK9aPN23PpN9V8jPwk0gSbm3IJWIBX6dqC1YlffLa
 NE2rGcUBqCTvxckZTRfqTzdxQn1blyaEv/q5/eILfmljdc5bR9mH3r54enlMe7ca2BQ7XgbAqe9
 i3BiXQe+Ja6an0b0QISqD2Dif2La7onByyrq2CI8Ie22T2pjwYoUUWuypuQNv0AejO1oQz4L7Ut
 nY25xxvxWy3MgW2IYDTK6UUMPYk5peFWK66P/ShujBHELl2+WjcUsKeMWKwbnxSLyunsZjZA==
X-Received: by 2002:a05:600c:3b96:b0:49f:ce78:3569 with SMTP id
 5b1f17b1804b1-49fe66fa7f5mr115684375e9.26.1790340491574; 
 Fri, 25 Sep 2026 05:48:11 -0700 (PDT)
Received: from fedora ([2a02:587:200f:d100:bf67:f785:caad:e278])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm6670499f8f.21.2026.09.25.05.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:48:11 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mail@taterr.org
Subject: [PATCH 2/2] accel/habanalabs: Replace create_singlethread_workqueue
 with alloc_ordered_workqueue
Date: Fri, 25 Sep 2026 15:48:04 +0300
Message-ID: <20260925124804.58808-3-mail@taterr.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925124804.58808-1-mail@taterr.org>
References: <20260925124804.58808-1-mail@taterr.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the command, event, and reset

workqueues.

Use the %s format string specifier to satisfy the API

requirements for variable workqueue names. WQ_MEM_RECLAIM is

added to ensure hardware events are processed under memory

pressure.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/accel/habanalabs/common/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31..cfccaf7a584f 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -902,7 +902,7 @@ static int device_early_init(struct hl_device *hdev)
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
 		snprintf(workq_name, 32, "hl%u-free-jobs-%u", hdev->cdev_idx, (u32) i);
-		hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
+		hdev->cq_wq[i] = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM, workq_name);
 		if (hdev->cq_wq[i] == NULL) {
 			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
 			rc = -ENOMEM;
@@ -911,7 +911,7 @@ static int device_early_init(struct hl_device *hdev)
 	}
 
 	snprintf(workq_name, 32, "hl%u-events", hdev->cdev_idx);
-	hdev->eq_wq = create_singlethread_workqueue(workq_name);
+	hdev->eq_wq = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM, workq_name);
 	if (hdev->eq_wq == NULL) {
 		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
 		rc = -ENOMEM;
@@ -957,7 +957,7 @@ static int device_early_init(struct hl_device *hdev)
 	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
 
 	snprintf(workq_name, 32, "hl%u_device_reset", hdev->cdev_idx);
-	hdev->reset_wq = create_singlethread_workqueue(workq_name);
+	hdev->reset_wq = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM, workq_name);
 	if (!hdev->reset_wq) {
 		rc = -ENOMEM;
 		dev_err(hdev->dev, "Failed to create device reset WQ\n");
-- 
2.55.0

