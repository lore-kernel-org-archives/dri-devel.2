Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35ED606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k8JEMHBV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B6910F471;
	Mon,  9 Nov 2026 17:16:16 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088C710F46F;
 Mon,  9 Nov 2026 17:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+9T66Xib9JZvVuTQyu3xwasN3aV+M0hLbJtXMyWyyKQvVXpay8fDSWgOzOTBfjl/hZgysE5SMF2E3lcHTPIjioiLEXPFU4hmg+klMe53yTIfr7N3aTt3N3mwwsRPPLlIKdRuT9lY7En2/18u0payw0dwotVkisrZdEVsaWd3Ym0VtAaFDsSL8hc7+RkIxha9Fvr9wN9s+aNKfzOu57ILCVytCBRAmKRhdYRb2qynJyIHCwkI/MlaDhov/V7ktoPdx75lK0QvDN+YzWjSnDfW1+8qHQOup+7CV8eirClHUfNmEPFfaSpXXw8mKaXaHmNNUVtv+wHpxVClXs81fwaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpBI4TbTN8ohzwqxH6UIWdW/pkv93uRkYhUEHz4SlHI=;
 b=UugaYWTg8DiwWPI+0QrLBdtqKv36ZzLGwtStCPvymwL2RQXruVytAFij9gEFVUDlrqAFjtAWaIeaQNXscv3tNlUu0mjlGI28FPJ4cgzhqa2sVUuINyWW2xWLXGnP8xhMO5vdFirc1IcaUGqH8HbLtY0bJyBVkcCVgAeyrnjNPqQpVEULVZPw8b/PU9OkIFJBgxgtxlH07NCnVQXHU+48XAVYU2Y2ZESSup52omyQC2buYCQX+ENLsuXmXAlfFm9kLdtvasPbWAh1fNs/CA9GnEx+mN328NYHf13LIXYrUJAb/QTtGagBIAEdhKC5dWOysf+xgtydv7hjfEm5BnRcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpBI4TbTN8ohzwqxH6UIWdW/pkv93uRkYhUEHz4SlHI=;
 b=k8JEMHBVQCzCUuIyQmA7fgcoFmLC/vJ6TYmCCUD0dR8TFEfULABDzKG0WJsuDI42VKt2WCaCywhOoLuCAd2Huq1fCKaCMe4SilXuftpoL2+gQJ4Tm/ap+4pRO6TeZmM/9eowODosyHvsziEnae9c2Wkpv1xXLanOzAYtNs1KHHA=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:16:02 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::78) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Mon, 9
 Nov 2026 17:16:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:16:01 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:15:59 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] drm/amdgpu: introduce amdgpu_dev_enter / exit
Date: Mon, 9 Nov 2026 18:13:25 +0100
Message-ID: <20261109171333.4329-6-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1792aafa-90b8-4ed7-51eb-08df3e85212a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|260925021911599003|260925021311599003|260925022911599003|10067099003|261028144727099003|56012099006|11063799006|261021123027099003|261021130227099003|261021121427099003|261021135927099003|261021133027099003|261022113327099003|261022115727099003|261022105027099003|261022075727099003|261009221227099003|261009223027099003|261026135527099003|261026130827099003|261026140227099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: fpLlPD0B8dPtugYANGvY3nFodrFnAZvzPjUtNXm5aZ7Zms/ym+wrlXO2p6b+PrkTsLJqu5E2pzMyXn2hK/MfBlPN4+H+6kmLZ8OZEDF7hvizM8ZeQh+UkWd2ibH/z/7SVKqbs8mUOTInOUV0+ksSe/LbCPEhW2by4Ljg9yLaJ5bTp8wAN8yHklvUEKFU2V2nWJg9R18L5Njd5bWeBrq0EueyJ408gF0Qov64Vrc1uum1ROqGv/ISJmzRmf1uQaW3IKFqZV//h6HoY8JKZKIcxnkymDlJvc0peuDILRl7CMRpw+wCOJXa2ieAeGxRaVsJYrqExnanJNUNeZhJtorc2hC6YfsxkqVrLuiZ+aZQnOh4iRwy5ABI/y+zCPkMY1Rzafcga56DiRv2A0WcDicHLbSDEYeWbXQzz7iJz+2U02NXd/EtuD2fcGuIzQMM/FZtyN8pLNf6JSSZykTf5sRB4dkTyy0MgS+vouwSvY6OyF3vwyxiwK6RtZVL3ZgvXvjnfyGID0d8NTqxCsYCJoPKHZdiwlfRFilkxONjE0+1JyfcKLvH5Xxrx5uoB5G9poDHczQUtivaDO6oA3pgPXcnfOSDRFn3ayHm/SyLj+HQLGP5WGmtnDvf2ITL3432Y0Xat5MfjMqS4MNSj6dOc6yTTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(261028144727099003)(56012099006)(11063799006)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261021133027099003)(261022113327099003)(261022115727099003)(261022105027099003)(261022075727099003)(261009221227099003)(261009223027099003)(261026135527099003)(261026130827099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zw2/viY2WIsPsUZ9OjFjrKQr09LsMqjZocSSYbLqMt6qN5tkXmbLLnARMkDOhAwXJZZYOlDrCMQznH99eYnBVndubdDqTizWT6L/5bdSvhZzaNEZS05sU9GKgC76gtOMwIwvuLBu01gC69sMaxHymyGo4aMvEPq5wYZQsN38l4Aa25rqZTyjKWywPesO2VwZ4JyMMaZjal2TDgbXP6gqWAWOLy7EKYtrBq1sq8PDTjpaBRX8JIxQixuwEAi0OAApHod5Jw9LeBE1oeeqAWbQP5PX+vMO1d3lS8qMxMY2C+KWBKhIYrBZsrzIEQpC6CRJVSwj37YYOM4DeSZKaRvipKxhMgYVzhXl51JQIOXL9URo+dTKb97qSrQnnTIOm221M0aQIqTVRxyy4eR40MbY6fwz1QlcqMjjw8mKjW1hdDStxcmXIhUcLjAe/35pOuG0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:16:01.6535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792aafa-90b8-4ed7-51eb-08df3e85212a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

And use them instead of drm_dev_enter / exit.

Every place that needs the GPU should already call the drm variant.
The amdgpu version also checks for the wedge status of the device.

amdgpu_device_skip_hw_access is not used as it's not meant to be
used outside interrupt handlers and reset handler.

Direct uses of amdgpu_device_is_wedged are still ok for paths where
drm_dev_enter is used like drm ioctls.

As Sashiko bot pointed out in the v3 review, some places should still
use the drm_dev_enter variant:
* amdgpu_job_timedout: this function has to force-finish fences for
  the other rings.
* amdgpu_device_mm_access: accessing memory should be possible for
  wedged devices to allow debugging

Link: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=5
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 18 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c    |  4 ++--
 29 files changed, 112 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cfbb5ab5a2fe..75989767f9b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -50,6 +50,7 @@
 #include <drm/ttm/ttm_placement.h>
 
 #include <drm/amdgpu_drm.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
 
@@ -1387,4 +1388,17 @@ static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
 	return atomic_read(&adev->wedge_status);
 }
 
+static inline bool amdgpu_dev_enter(struct amdgpu_device *adev, int *idx)
+{
+	if (amdgpu_device_is_wedged(adev))
+		return false;
+
+	return drm_dev_enter(adev_to_drm(adev), idx);
+}
+
+static inline void amdgpu_dev_exit(struct amdgpu_device *adev, int idx)
+{
+	drm_dev_exit(idx);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2b318ccc9aa6..ab3b62379e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -428,9 +428,9 @@ void amdgpu_ctx_fini(struct kref *ref)
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (adev->pm.stable_pstate_ctx == ctx) {
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		}
 		adev->pm.stable_pstate_ctx = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7335f9c4d86f..a66e504f7023 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3025,12 +3025,18 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
+	int idx;
 
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
 
+	if (!amdgpu_dev_enter(adev, &idx))
+		return;
+
 	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
 		adev->gfx.gfx_off_state = true;
+
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f..4c3aa4e4d4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3030,13 +3030,13 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 	struct drm_device *dev = file_priv->minor->dev;
 	int idx;
 
-	if (fpriv && drm_dev_enter(dev, &idx)) {
+	if (fpriv && amdgpu_dev_enter(drm_to_adev(dev), &idx)) {
 		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(drm_to_adev(dev), idx);
 	}
 
 	return drm_release(inode, filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..62e98e50bf35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -318,7 +318,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	if (!adev->gart.ptr)
 		return;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
@@ -335,7 +335,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	}
 	amdgpu_gart_invalidate_tlb(adev);
 
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
@@ -359,7 +359,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 	unsigned i, j, t;
 	int idx;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
@@ -371,7 +371,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
@@ -400,7 +400,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 	/* The SYSTEM flag indicates the pages aren't in VRAM. */
 	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	page_base = pa;
@@ -411,7 +411,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 		}
 	}
 
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
@@ -440,7 +440,7 @@ void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
 	if (!adev->gart.ptr)
 		return;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
@@ -455,7 +455,7 @@ void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9b4c76f198f2..700e4da9cab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -128,12 +128,12 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	if (drm_dev_enter(ddev, &idx)) {
+	if (amdgpu_dev_enter(drm_to_adev(ddev), &idx)) {
 		pm_runtime_get_noresume(ddev->dev);
 
 		ret = amdgpu_bo_fault_reserve_notify(bo);
 		if (ret) {
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(drm_to_adev(ddev), idx);
 			goto unlock;
 		}
 
@@ -141,7 +141,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 					       TTM_BO_VM_NUM_PREFAULT);
 
 		pm_runtime_put_noidle(ddev->dev);
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(drm_to_adev(ddev), idx);
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 53fa9fa83ae7..94a77bf14c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -728,9 +728,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	struct dma_fence *fence;
 	struct amdgpu_job *job;
-	int r;
+	int r, idx;
 
-	if (amdgpu_device_is_wedged(adev))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
@@ -742,8 +742,10 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
 		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
+		if (!down_read_trylock(&adev->reset_domain->sem)) {
+			amdgpu_dev_exit(adev, idx);
 			return;
+		}
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
@@ -756,6 +758,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
 						   flush_type);
 		up_read(&adev->reset_domain->sem);
+		amdgpu_dev_exit(adev, idx);
 		return;
 	}
 
@@ -782,11 +785,13 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
+	amdgpu_dev_exit(adev, idx);
 
 	return;
 
 error_alloc:
 	mutex_unlock(&adev->mman.default_entity.lock);
+	amdgpu_dev_exit(adev, idx);
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
@@ -947,6 +952,9 @@ int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
 	unsigned long pending = 0;
 	int xcc, r = 0, err;
 
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
 	 * this while one is ongoing.
@@ -1283,7 +1291,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return;
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
@@ -1315,7 +1323,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6aa895f63aea..e0c1a876d76a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1144,12 +1144,12 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_fini(adev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 			arch_phys_wc_del(adev->gmc.vram_mtrr);
 			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
 		}
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 01dca6858833..a0fbb9af818f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -5109,7 +5109,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 		return -EBUSY;
 	}
 
-	if (!drm_dev_enter(ddev, &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return -ENODEV;
 
 	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQUIRED,
@@ -5142,7 +5142,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 		count = ret;
 	}
 
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 	return count;
 }
 
@@ -5150,19 +5150,19 @@ int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
 {
 	int idx;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
+	if (!amdgpu_dev_enter(psp->adev, &idx))
 		return -ENODEV;
 
 	if (!bin_size || bin_size > PSP_1_MEG) {
 		dev_err(psp->adev->dev, "PSP firmware is invalid\n");
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(psp->adev, idx);
 		return -EINVAL;
 	}
 
 	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
 	memcpy(psp->fw_pri_buf, start_addr, bin_size);
 
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(psp->adev, idx);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9c3efc27b363..5209143e7c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1624,7 +1624,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (!adev->mman.sdma_access_ptr)
 		return -EACCES;
 
-	if (!adev->mman.buffer_funcs_enabled || !drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!adev->mman.buffer_funcs_enabled || !amdgpu_dev_enter(adev, &idx))
 		return -ENODEV;
 
 	if (write)
@@ -1660,7 +1660,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (!(r || write))
 		memcpy(buf, adev->mman.sdma_access_ptr, len);
 out:
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index cd35ff7ca864..8668684e8e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -456,14 +456,14 @@ int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev)
 		if (!adev->uvd.inst[j].saved_bo)
 			return -ENOMEM;
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
 			if (amdgpu_ras_intr_triggered())
 				memset(adev->uvd.inst[j].saved_bo, 0, size);
 			else
 				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
 
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		}
 	}
 
@@ -495,9 +495,9 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 		ptr = adev->uvd.inst[i].cpu_addr;
 
 		if (adev->uvd.inst[i].saved_bo != NULL) {
-			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			if (amdgpu_dev_enter(adev, &idx)) {
 				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 			}
 			kvfree(adev->uvd.inst[i].saved_bo);
 			adev->uvd.inst[i].saved_bo = NULL;
@@ -508,10 +508,10 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+				if (amdgpu_dev_enter(adev, &idx)) {
 					memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
-					drm_dev_exit(idx);
+					amdgpu_dev_exit(adev, idx);
 				}
 				size -= le32_to_cpu(hdr->ucode_size_bytes);
 				ptr += le32_to_cpu(hdr->ucode_size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 3952af9ae115..b583c4d41a1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -337,11 +337,11 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
 	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		memset_io(adev->vce.cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo));
 		memcpy_toio(adev->vce.cpu_addr, adev->vce.fw->data + offset,
 			    adev->vce.fw->size - offset);
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..c286df7c6faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -332,9 +332,9 @@ static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu_device *adev, int i)
 	if (!adev->vcn.inst[i].saved_bo)
 		return -ENOMEM;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	return 0;
@@ -383,9 +383,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
 	ptr = adev->vcn.inst[i].cpu_addr;
 
 	if (adev->vcn.inst[i].saved_bo != NULL) {
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		}
 		kvfree(adev->vcn.inst[i].saved_bo);
 		adev->vcn.inst[i].saved_bo = NULL;
@@ -396,11 +396,11 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
 		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			if (amdgpu_dev_enter(adev, &idx)) {
 				memcpy_toio(adev->vcn.inst[i].cpu_addr,
 					    adev->vcn.inst[i].fw->data + offset,
 					    le32_to_cpu(hdr->ucode_size_bytes));
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 			}
 			size -= le32_to_cpu(hdr->ucode_size_bytes);
 			ptr += le32_to_cpu(hdr->ucode_size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea8688061237..01f00d55ad6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1035,7 +1035,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (list_empty(&vm->kernel.needs_update))
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return -ENODEV;
 
 	memset(&params, 0, sizeof(params));
@@ -1069,7 +1069,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		amdgpu_vm_bo_idle(entry);
 
 error:
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 	return r;
 }
 
@@ -1170,12 +1170,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_res_cursor cursor;
 	int r, idx;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return -ENODEV;
 
 	tlb_cb = kmalloc_obj(*tlb_cb);
 	if (!tlb_cb) {
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 		return -ENOMEM;
 	}
 
@@ -1287,7 +1287,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 error_free:
 	kfree(tlb_cb);
 	amdgpu_vm_end_critical(&params);
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..9d1fbddcdd7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -387,7 +387,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!amdgpu_dev_enter(adev, &idx))
 		return -ENODEV;
 
 	r = vm->update_funcs->map_table(vmbo);
@@ -429,7 +429,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm->update_funcs->commit(&params, &vm->last_update);
 exit:
-	drm_dev_exit(idx);
+	amdgpu_dev_exit(adev, idx);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bd3bb3bfb668..4d51e9c534f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -547,20 +547,20 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			return -ENOMEM;
 		}
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
 				vfree(buf);
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 				return ret;
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
 			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		} else {
 			vfree(buf);
 			return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f9a3fbfc0634..43bb89d4fa33 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -635,20 +635,20 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 			return -ENOMEM;
 		}
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
 				vfree(buf);
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 				return ret;
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
 			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		} else {
 			vfree(buf);
 			return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 888c747d6c5c..1c8476fb387d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -494,20 +494,20 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 			return -ENOMEM;
 		}
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v14_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
 				vfree(buf);
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 				return ret;
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
 			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		} else {
 			vfree(buf);
 			return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index 029d4f4b0961..739fba7a4751 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -483,20 +483,20 @@ static int psp_v15_0_3_memory_training(struct psp_context *psp, uint32_t ops)
 			return -ENOMEM;
 		}
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v15_0_3_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
 				vfree(buf);
-				drm_dev_exit(idx);
+				amdgpu_dev_exit(adev, idx);
 				return ret;
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
 			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		} else {
 			vfree(buf);
 			return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe47..e67f53f36f51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -566,14 +566,14 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
 			void *ptr = adev->vce.cpu_addr;
 
 			memcpy_fromio(adev->vce.saved_bo, ptr, size);
 		}
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	/*
@@ -616,12 +616,12 @@ static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (amdgpu_dev_enter(adev, &idx)) {
 			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
 			void *ptr = adev->vce.cpu_addr;
 
 			memcpy_toio(ptr, adev->vce.saved_bo, size);
-			drm_dev_exit(idx);
+			amdgpu_dev_exit(adev, idx);
 		}
 	} else {
 		r = amdgpu_vce_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913a..2e4b8b025b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -255,9 +255,9 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		fw_shared->present_flag_0 = 0;
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	amdgpu_virt_free_mm_table(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 10ef5616b2f5..c10c3a672d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -421,14 +421,14 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_fw_shared *fw_shared;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 			fw_shared->present_flag_0 = 0;
 		}
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0f4f4d66e2e4..6189c096e32f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -326,7 +326,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_fw_shared *fw_shared;
 
@@ -337,7 +337,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sw_ring.is_enabled = false;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da..3f0185eac593 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn4_fw_shared *fw_shared;
 
@@ -289,7 +289,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sq.is_enabled = 0;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c319..ebc4729669c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -296,7 +296,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn4_fw_shared *fw_shared;
 
@@ -304,7 +304,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->present_flag_0 = 0;
 			fw_shared->sq.is_enabled = cpu_to_le32(false);
 		}
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07f..3797038d9f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -248,7 +248,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn4_fw_shared *fw_shared;
 
@@ -260,7 +260,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sq.is_enabled = 0;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046..5d6c3759fa72 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -214,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn5_fw_shared *fw_shared;
 
@@ -226,7 +226,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sq.is_enabled = 0;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d..270fb2ab42dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -259,7 +259,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn5_fw_shared *fw_shared;
 
@@ -268,7 +268,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sq.is_enabled = 0;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08c..3565772288b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -179,7 +179,7 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r, idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (amdgpu_dev_enter(adev, &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			struct amdgpu_vcn5_fw_shared *fw_shared;
 
@@ -188,7 +188,7 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
 			fw_shared->sq.is_enabled = 0;
 		}
 
-		drm_dev_exit(idx);
+		amdgpu_dev_exit(adev, idx);
 	}
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.43.0

