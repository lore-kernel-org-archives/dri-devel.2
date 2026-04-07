Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B4FF512E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 18:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF05E10E123;
	Tue,  7 Apr 2026 18:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="tHEY+zYB";
	dkim-atps=neutral
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C1F10E123
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 18:14:38 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1775585665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=feq8ES3YQ1/zQ0s3FbI4AWqipYG4TX1KWXdGHZ/0KXs=;
 b=tHEY+zYBiq5EBd2a0QRsItglK9ueCBMyXZ4aQK/K2jCP4gq/4x66aEA8hdFi7nGFrRwV4v
 oQRDEcB6TZZgReLfkjsiKgxWCYF2/oWBrsCR06c6K4LogoRsCG54AVi2ZX77etaSJwIe5i
 wBI2VYNQNsuDUCRfVEPk7nentQ+l5Bw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: replace nested min calls with min3
Date: Tue,  7 Apr 2026 20:14:08 +0200
Message-ID: <20260407181407.1052586-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=thorsten.blum@linux.dev;
 h=from:subject; bh=rqGXu1V3NhQOPuwKi1SU5oP6pXLRP6vXtaYb76Ad8jA=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlXPQtuynJOeylmkC6+2tNm9o1tr0+6TKz5cP7bjejMf
 /UZhixHOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAir7Yw/DN1WdDo174pjf3i
 ka3Bsr4e9kYveB4uOzHfiKnzpPaGVm1Ghj+buU6oiXyuvvdyZ30x26qd7odt2bs9DQ/HCzfPdM5
 MZgEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

In dce6_available_bandwidth() and dce8_available_bandwidth(), replace
nested min() calls with min3().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/radeon/cik.c | 2 +-
 drivers/gpu/drm/radeon/si.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 51a3e0fc2f56..a13635443833 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9063,7 +9063,7 @@ static u32 dce8_available_bandwidth(struct dce8_wm_params *wm)
 	u32 data_return_bandwidth = dce8_data_return_bandwidth(wm);
 	u32 dmif_req_bandwidth = dce8_dmif_request_bandwidth(wm);
 
-	return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_bandwidth));
+	return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandwidth);
 }
 
 /**
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 26197aceb001..4681ff28630a 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -2150,7 +2150,7 @@ static u32 dce6_available_bandwidth(struct dce6_wm_params *wm)
 	u32 data_return_bandwidth = dce6_data_return_bandwidth(wm);
 	u32 dmif_req_bandwidth = dce6_dmif_request_bandwidth(wm);
 
-	return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_bandwidth));
+	return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandwidth);
 }
 
 static u32 dce6_average_bandwidth(struct dce6_wm_params *wm)
