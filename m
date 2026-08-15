Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C275AC5DF6A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0741510E16F;
	Sat, 15 Aug 2026 18:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="iyqNM1eM";
	dkim-atps=neutral
X-Greylist: delayed 1300 seconds by postgrey-1.36 at gabe;
 Sat, 15 Aug 2026 18:22:27 UTC
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D218310E16F;
 Sat, 15 Aug 2026 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=n1XUA6JsCg5ABZi9kKk3iM45wBqRvOp8op6pAdXLI28=; b=iyqNM1eMfrbS8MXy
 wzCoXp1moYc6SAFGA5OqCq9NmV2sV5xyy+9tvhLv7hIDfPoU0KxRF3vzjhhPrUUPJc20YXscN/GNb
 Wt6JprThDs15388O+ZECo4ihLLteAgJtSZV3miVK4kY+Hlz0GA72AOy+oLKbHQIWMzVrFtL4q20zC
 JyBH94+Hat7RuN3LkCYPYKt5Ki+RzKOE6ODk6y02nJrvWXuZlRkkOC34zGgZcGJA4V1bnZvYqGJP/
 fVRsYPXtrMmu7TA6CVNd+HuVSSZ/rE28cSQVhNlthGR7RXoemTzvWuvTBBCyBWa50q6eELyP7Hy11
 iSqsefyFV7OqML+tkQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <linux@treblig.org>) id 1wvIga-00000002HFi-2Tm5;
 Sat, 15 Aug 2026 18:00:48 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/4] drm/amdgpu: Remove is_idle
Date: Sat, 15 Aug 2026 19:00:33 +0100
Message-ID: <20260815180033.8958-5-linux@treblig.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815180033.8958-1-linux@treblig.org>
References: <20260815180033.8958-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove the actual is_idle member, since it's never read/called and
the previous patches have remove all the assignments.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 6d0c74ebdb58..e3baef809cd1 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -437,7 +437,6 @@ enum amd_dpm_forced_level;
  * @suspend: handles IP specific hw/sw changes for suspend
  * @resume: handles IP specific hw/sw changes for resume
  * @complete: handles IP specific changes after resume
- * @is_idle: returns current IP block idle status
  * @wait_for_idle: poll for idle
  * @soft_reset: soft reset the IP block
  * @set_clockgating_state: enable/disable cg for the IP block
@@ -466,7 +465,6 @@ struct amd_ip_funcs {
 	int (*suspend)(struct amdgpu_ip_block *ip_block);
 	int (*resume)(struct amdgpu_ip_block *ip_block);
 	void (*complete)(struct amdgpu_ip_block *ip_block);
-	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
-- 
2.55.0

