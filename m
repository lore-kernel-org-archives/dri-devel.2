Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A46CD6E6E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 01:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EFA11A376;
	Fri,  5 Jun 2026 01:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dw0nYiLE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC59E11A376;
 Fri,  5 Jun 2026 01:13:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73D16406CF;
 Fri,  5 Jun 2026 01:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564271F00893;
 Fri,  5 Jun 2026 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780621990;
 bh=gWHLqhI+wYzy8EGu2m2OhaCQQ1UQibBjY3plHDhHMQo=;
 h=From:Date:Subject:To:Cc;
 b=dw0nYiLEwGdTFKIgtF7qNtUHXnkwiclvyM1jrKbQtBHaUllkKlW38Yp15wuyqcVOR
 KEfnwZ/pI0UxbjtzSMQKzDvGhuVvwFc8RZsIYIQmsjZOOeBtbNxk6Tz54fImx5Ha8I
 13vxrPn0fjWrx9kwEnmyU5zGhkCh6ts3LKBPpgQtIgWrPnSnGdrMK09E7lqiBk1oT2
 VIv0iMyqhryU8JYb5DWsux80oXlhgJsl43Z12VqnWhEjkBkH0U81Ph5a9I/g+1jqqP
 eSgLrvtKcVE1d7mGTSmswidvFGwK0qFMgJSA2YjVQcMGQQrgVpzo4wC38F+mK6UkN6
 kWUHE/bTtBj2A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Jun 2026 18:13:02 -0700
Subject: [PATCH] drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNWwrCMBCF4a2UeXZgGksQtyJSknSMI3asib1A6
 d4b9fGDw39WyJyEM5yrFRJPkuWlBfWhgnB3GhmlKwZDxpKlBl3fxWHEmyw4v1t1PbdPVpxdUtG
 I9hhOVBumYDyUyJC4TH8Hl+vfefQPDp9vFbZtB98byG2CAAAA
X-Change-ID: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=nathan@kernel.org;
 h=from:subject:message-id; bh=sOjlaPnjIvyfaTrKJwHTptoARYYEgZJg7PMvExq0/as=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlKSovXuX47/SRW8pd7o/CZtfEqrSr24pPy1bze8afpV
 97iKC/qKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABOZcJ/hD8+pE+tfJL8+Xtss
 erx+1TZ2ebccXg//ghdxJc1X7Q58/cLwh/O9aeT/P6tOO9hn/7mntOuv/cVPvSfmZhWy31z/Oe6
 pNSsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
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

There is a warning when creating the hdmi_frl_status_polling_wq
workqueue because "hdmi_frl_status_polling_workqueue" excceds
WQ_NAME_LEN:

  workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl_status_polling_workque

Shorten the workqueue name to "hdmi_frl_status_polling_wq" like the
structure member to avoid the warning.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1ed697a3a453..f120f75827d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2262,9 +2262,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.hdmi_frl_status_polling_wq =
-			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
+			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
 		if (!adev->dm.hdmi_frl_status_polling_wq)
-			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
+			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
 		adev->dm.hdmi_frl_status_polling_delay_ms = 200;
 		INIT_DELAYED_WORK(&adev->dm.hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
 	}

---
base-commit: 56ae73c92e200e630c2bdf1e98c88b86c8483b37
change-id: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b

Best regards,
--  
Cheers,
Nathan

