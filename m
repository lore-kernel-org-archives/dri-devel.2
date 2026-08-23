Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20868C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD2B10E4AA;
	Sun, 23 Aug 2026 09:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="eW+pI3Mr";
	dkim-atps=neutral
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C76D10E4AA
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:30:03 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4af9abbbe;
 Sun, 23 Aug 2026 17:29:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Runyu Xiao <runyu.xiao@seu.edu.cn>, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] drm/amdgpu: return reserve errors from amdgpu_gfx_kiq_init()
Date: Sun, 23 Aug 2026 17:29:36 +0800
Message-Id: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa02df497e303a1kunm6a20afce1f1049
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk8YVkhNQxhIT0NLHRpPTVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=eW+pI3Mrp1r5JMSqBpNa3D4T4dbvWhTTDQaGT0NyzTgARDKDi68gASyeAnsFWVOylz+9y8Ncfre/p7bit68wZL2gBFcyLDVe3J1sgYEucfMDB1kwxOIxRvJWbxWPelJk/lotEiECsEFmxeYLFfsGvxTstDhkKJQX9vG7GNGcxnA=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=DZCF195lvOLI9A+UGOu/tEfVuLdJBg6brLP10koFIis=;
 h=date:mime-version:subject:message-id:from;
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

amdgpu_gfx_kiq_init() reserves kiq->eop_obj after mapping the buffer.
If amdgpu_bo_reserve() fails, the code still unmaps and unreserves the
BO and then returns success.

Return the reserve error, but keep the kunmap cleanup. Only call
amdgpu_bo_unreserve() on the successful-reservation path.

Fixes: 71c37505e7ea ("drm/amdgpu/gfx: move more common KIQ code to amdgpu_gfx.c")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5aa465231c4..630d0fd9ac13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -241,8 +241,11 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	memset(hpd, 0, hpd_size);
 
 	r = amdgpu_bo_reserve(kiq->eop_obj, true);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
 		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
+		amdgpu_bo_kunmap(kiq->eop_obj);
+		return r;
+	}
 	amdgpu_bo_kunmap(kiq->eop_obj);
 	amdgpu_bo_unreserve(kiq->eop_obj);
 
-- 
2.34.1
