Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B1DC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6BA10F725;
	Fri, 11 Sep 2026 23:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="FZVhEzzj";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCCA10F734
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169355; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V0CFF1SATaZIhwV0XrvzAT3ctb3WJJLHUdm1dIJJ8+3ZI7riDuiAZnfs3jvACo7AXQHmT/KcQTI9YLgijt/Mav0mrJk1DG1sZ97IjIKfoWAenaXBcvjWDqxeRpgP44KZdbEtNTmoHgNf8IFheYGlG+VwCAQXe0EszF32IxHT5c4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169355;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rne2vTyla1RUI4gVDThBMRFsSeWjoijKTX5hYO0ZMA0=; 
 b=dqWiqpbiKzhc5W7SHhyyo1iAtIPBK9pQAY1y3HFLgdJoU7AEVVWDDBUYitoR/7D1sn8qTRR3X4etDpRVaB1hfqX9pLJIzWQXI0lDzYs/2SaJzcUhv2960O/BnBuDASrsl3pIJ1Z9fgIak5mmIMy5q3dTZYNz0XUHD5vuBPQRy0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169355; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=rne2vTyla1RUI4gVDThBMRFsSeWjoijKTX5hYO0ZMA0=;
 b=FZVhEzzjbTB4XDidKATgA2jw5xQa5buDLbrlYzUSvPl+SP71uBC6pWtlcOtH3W/x
 dumKi3oQkbjcHMXsmu8rCTm7TBooth1iSliKtrz/Evj5omfRsB1VBOyXwPl6XhfNEQN
 lrkmEItwVunIeUZnKWnN8hdgq4HwTnok6G9/FHCc=
Received: by mx.zohomail.com with SMTPS id 1789169354718810.8588496957029;
 Fri, 11 Sep 2026 16:29:14 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:14 +0100
Subject: [PATCH v9 13/16] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-13-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ylClgdA4qjN8YjgAXTrojrPeuTeRxcjN/yXHiltT8+A=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6EHonsRbdMDzv+1uILpnvJFCF39Xnb8Przf
 n9GYVvC7WGJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOhAAKCRAOJn5M7lND
 PSexC/99KlQV3vqqYYKz9ZcwTtEnajUtKtzEyl4lHWgrEzQ0qvKcIhKW6Gt7OiAGim8ELGHNW0o
 I+ejxk5H8976RaoRs1MZbkTjxkk4TGOgWMKhvHlBRkkUf3SSLcgCr3krTmHiX4jJx41QgsD4wn9
 DaXmElSoCQHceK4m1OrgFsKbbdRLMOrtgUgrGw9IxLmwTXQO3AI/ww1jZgZtvDRaP7aIYJXkDck
 i49uULUZKYb4TULIHkNJPAzKDqp4iTT3TyuL4n3MGbuBZElhx7EOEZMIiWArIdRPUOf35mxLyle
 8Qs2hTsXnJZYXyLiBOP5aDQRkB7tDyCpxNX1j+Umc05+oLmIbhyhUW0Nw6X6scQmazWONud5WQJ
 a1tdU3Xisap5FN7oUX4EX41PPG/bO9fkvDauWl672Gy/FRhBZW/MSZCGt0csFtSFxzWQRr2pwW8
 II5QM7kJajay3E55dNS0oM4K3wmdJ0unsqTdWbYFfmX4k6tJU5b/rCeE7MoTjTgrtIuOA=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

If the GPU and CPU are fully coherent, then there's no need to flush the
GPU caches after a perfcnt sample is made available.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ffc77121070e..b3f71d7fd82a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 
 void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 {
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	if (pfdev->features.selected_coherency != COHERENCY_ACE)
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	else
+		complete(&pfdev->perfcnt->dump_comp);
 }
 
 static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

-- 
2.55.0

