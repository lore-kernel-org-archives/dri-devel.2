Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6294FC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38BE10E907;
	Mon,  7 Sep 2026 20:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ODzSJp3X";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CA310E908
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812291; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HsSESzIReyq8ohGsCaKzZrhVmJwLEXr2ANOLQ3GNpPJkEihi8LLo1pahexliMX9onj26bBeQQdpFOTvCGkaiJq16/Jst/mGM71bvVgnpMcvPJiGq15V1YXns9mOHTWv6lL6sDxuAFDU+0xdv41KV4u7APn4NzeBrFyuf01G8zYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812291;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GiNAk1ddULmDOvtto/fkJvNwC9OGSrBfiGgPyvguuH0=; 
 b=hcelYD4J3cRqES7P0DMZoHlrGR5G20PQGNzSMjkUNNiHJARpVoWA0+Ev0/5otyGFrgdNonA63lHs59X7LgR60J/zStNsamPSMZmu2pYVxTCe4BRBQI8t/PnkEs76VvbABdK+TJPSKSCOEOjuSoAZg2Ut0iG3pCPiFbzLnzLSvHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812291; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=GiNAk1ddULmDOvtto/fkJvNwC9OGSrBfiGgPyvguuH0=;
 b=ODzSJp3XyuPT6iipXL7WtbnPP3Vner73f3nlKb/wlOCv62gVieaJSM2HNVl04JIy
 It/yc3f04pAgz+XZdV4drB+1gYTlkiFfi9x+mKCcFyyyimpYTd/o0fbpgC9cao3Lzw+
 cmt1r9fwyWi8ogrpJc/TeH+zK7aWy8Lwj2wdoYWg=
Received: by mx.zohomail.com with SMTPS id 1788812289723366.9762585632135;
 Mon, 7 Sep 2026 13:18:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:25 +0100
Subject: [PATCH v8 16/16] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-16-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=fcINJblJRb432SfE3VmHwqT0pqshFhBkvIiNxSLnr6s=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuMjIWVkrqvWdN8Cru2QMhlsN+QjHzTfzIIr
 +pKdzEdXCGJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8bjAAKCRAOJn5M7lND
 PXPMC/9xkqRLGYZ1vg0t6bsCK7x1Q5AHKkFpkXG4jrl8j0JxKUX65dDN9/mSjBGcYJlbs0L3yLy
 +uh+czRcVcojFWpr9ibBflRh8hK+Yqltc+7TMUxRmW8I7TRQRJSaJ9absc6WAksrlRYl7M9j27S
 M6TzcuUxPE3KjycLtSJHqy50e1yxpoE4Pt5gmt9rsYC3qbMSY8ZnNlMZABhzEjp5OtLJ144wY+/
 QbaKDBF9BWccq8fPc4RMFtUN92DF1ajKcoFveWwRvNA7MwR5NLQUtZyf2SrZvBFrMtZM0IKpkpx
 N4chlfl3iZpJrwg0aSbgQP86cn1mVga1pUZKDiSpm1Yyi9C9qaBZMqHvAfUk8cT89GJJUm7VJzU
 0Ttmxt7Lq+urlmmqlojMNhKSrDtP8bbLDuBrQFVMn04NaRynDNOSNoGwoGhZyFdhJkQQRM7Z6IT
 vTNphLb00qTsyQ5YNnLmMvo2g8XwKH3bmLZEgtgvvtbrgpXUJFTp1XXRmKKMIFAfDNmQ4=
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

Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 571a26b84126..de9b1c115181 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req state field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,

-- 
2.55.0

