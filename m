Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB10BCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF5C10EA02;
	Mon,  1 Jun 2026 22:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.b="h5kK4Cmy";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754A6113263;
 Mon,  1 Jun 2026 12:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMIvsVJF+up/pwDyptf9ehh1Wwnh3FRD20gDBVZwU0iMVZ4bzPLAcjldfWb1F/B60rdvdYJLHogrNkDQQJw6D/J+e5+fE5ECeY0tbCKZcsq9nC5ekEDFPN72QDDw1JZBXJMesgs5nKNjYNAeI8aJ6fnVfLAE7XEYtVqKBbiRdKP1yWa42sEK79WQGqdj6V3zgEdIcsoiWzi52RJF1Qae55prhmCvexQnqcfrHin9YbMZIPZKv/CsgcL5FpGdlcJNpBWHij7A+7A8ejVbvCWYAWx6I1nSAs3vrx6kEdE9C1TyIRC9Ft9f7OcFA/aDz6DvlIuvR1UGO5MishoHVTEMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykjOQs1RkIj+phL9goBKIzAWf5pkbllLyd69kthKiPM=;
 b=SdaIen7FEpD+c5o5dZohqnLK28ItZCSN5lepR+uGEkpTvtOBRerUJf/m9y3DrvDw6kNOhisww6dsukGPf5rfWX5OYtaNsPvJZIvYQkuo+sHrs0Z9vVAsedHxy2mWm30RO/KvSypcmIQNYyEHeG0/A21c1PE2oR2Xx8GSz97wcnvQTDMIu2RQ4VcUDx8fWpIGjh/CKNEl9Wftqysje8hO0fA/NfvDCfS8GprLp029GCrw7WLfQ4pPQJ9wlcDODAOLsDs2CWEsG92v2VdS0bgjYQiQlzaoktd5Kr6dydDtOq/kcLmFkEEKP7J3GvOope0OXA1gWT7MvWGyYMaHt4FyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=anholt.net smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykjOQs1RkIj+phL9goBKIzAWf5pkbllLyd69kthKiPM=;
 b=h5kK4CmylzYnj69WW3QKrSyCE0kgshs75ww5jn+wvE+1YG/5dvW/Hgw7cHj07S/sIrfZPn/AVNkUrv+PX5tp52+aYu9ksE+/WrSuHavMJDHnS0u80uiewxVWEsYRrX8SB7l7rp6AooFYrCEGST4Ue6RPuDp5EnrpAmJaWrEPrkg=
Received: from DB9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::9) by GVXPR02MB10808.eurprd02.prod.outlook.com
 (2603:10a6:150:153::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 12:04:27 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::a0) by DB9PR01CA0004.outlook.office365.com
 (2603:10a6:10:1d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 12:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 1 Jun 2026 12:04:27 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 1 Jun
 2026 14:04:26 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 1 Jun
 2026 14:04:26 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 1 Jun 2026 14:04:26 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com
 [10.133.4.142])
 by se-intmail02x.se.axis.com (Postfix) with ESMTP id D94B11247;
 Mon,  1 Jun 2026 14:04:25 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
 id C5B1B803B117; Mon,  1 Jun 2026 14:04:25 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 1 Jun 2026 14:03:59 +0200
Subject: [PATCH] drm/lima: call drm_mm_init() with a valid allocation range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260601-lima-alloc-fix-v1-1-16d3f3b7b780@axis.com>
X-B4-Tracking: v=1; b=H4sIAC51HWoC/x2MQQqAIBAAvxJ7bsEsJftKdBDbasEsFCIQ/550n
 IGZDIkiU4KpyRDp4cRXqNC1DbjDhp2Q18oghdRCSYOeT4vW+8vhxi9Kt6pBjJseTA81uiNV/Q/
 npZQPAuCFKWAAAAA=
To: Qiang Yu <yuq825@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>, Erico Nunes
 <nunes.erico@gmail.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andreas Baierl <ichgeh@imkreisrum.de>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>
CC: Rob Herring <robh@kerrnel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-samsung-soc@vger.kernel.org>, <lima@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>, Henrik Grimler
 <henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=dajP+FyTShQGGGSqSjHTeCBkeDHJKL4g9ZfU2tC16kY=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqHXVDzi4owxugdwNeALyJMVQfOGpont7T/SsgC
 appy3h41ZqJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCah11QwAKCRCwB25JC3Fh
 a3dEB/9ez9HOuhICNM4o/MyCF9o+/NTAq/3KGMH33YugDXkVy/5kTULOUgvZKF1njwBa7l0+LT/
 mEv201CYmfJw2SflypmP860ErBTCmYAO5lAfJhPWkooIPtgCcYmFdiVBPcX3+UlyI+RSYuqHpfU
 Tp6sjHByH7fepSxLIUvFE045MFpt+eE/kLYxGS8BZ53VbYU9JGyfIUhemtF4uHGcqKKxAhkqLlB
 7fnky6qCm5ggM4yqcK94K8mDJSZqqljXOkQfFTISwj0w+aTfZT9JsoaaYY9JDaulyFarpqZxGTF
 eO8uAdGdP/NJUsO3/wS57kfl7YFRu08ijYhtVPMiKfWSGLYu
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|GVXPR02MB10808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc66b5e-e02d-4e7e-b8bf-08debfd5eddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099006|18002099003|921020|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: iUx1MglEwNy5UlMtunjSaUzP8LWT1M9+e1kjd3k2RWdqmVFh3FxYtDS65fqTruSA0Q4aZJ+/RNqJ2UQEvdsIxDcVjBnuVClc3Nvp5sainkyVq7Gr7kkyq+YQcr4UsfbKo6vY81o6lLLuLrx3K4ow3HbHnJiDyXOb9epy68i5/634bzyXk87tTY79unHTiBT6w+73Mb4moJH/UkCJyPsjlVle8PwFBEYBqYMEm9g1/GV1DFYnK+aQdjNQnUS5TrBfwAKtAR+ZYy1aVtprFM3/X37ce7kcrNEkowmlKTImx/hYfXiHuar2Em3J+h/gnWFjRCdtkMg2RfP5itA2WzuC4I7N5PQgZVqFW7roXnN8LIEAfq1WeekPDjEeQ5NtPIveUcqrwU15cUGzUsomJfjS0OkjUhzdS7qtnwA7cXM8FAoN854bT3ueULraQhp8kQrHLsqY3MAATmiK522Rv3nWQb8cG3jMt4zij1q5xGgFGc1vQ+QgeCqjl1So0e0xRH6eE8Fpzouu+qlssBVURWdNujxMuuvMlUefyzWhRxe4s/OMgD81bkwVd+jkTEoNfxh0ygwUEMPcsZG/xnF8Adn9eXnTyXUnKAEm4x+Z3ItEvIi966VeVAmzTPjBK55uf8qodjnr+pYpgeaAXK3nj0z3eeErY2AY9cQfXSJo5sDeE5MqNQdAuzA8IYQfMSaLMhalWQD6r18j84c+vAKy+dOVSnGiPt41uet5dXKNRbdttP1hyyrhStDznaSuVrhgN4iM51ZakL5ITXfWbSBXG2Wl2w==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099006)(18002099003)(921020)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Ljs9hd1suIWkT4ZdMittnIbrh9MiKldnGWSE5nXytooItHUR5Zn2gzH8PxEE1PO0z6EtQOnoB7cHiGR1zPZILdhMhVcfWNaclangM/q7qQko7/D/ETJy8fCAG+JVNiFE2JAoaW32VWio91E2fmj/mLnU98cmKSHpaJbJxzVnW3DxEohrMOBFryTHrd7999Tcppvr4JzlLHRCputwJ3/YvaFX/PlzkoZOSDGff0X/v/XovWR7ZJBR6kSPN7WGLfREXKt4i+w72qy+aH6HqBypPT5qs8mQ5kvopsyw1HGF4hgnaBZiDve+DKdaSPvbWuHHUFqlqJpyxvuWBwHSx1H+3iV66B4rGAf8x+pxmH46pioG80YxWSf4D/xg8Q+6y1zgz7qH5gK2x+3PHsj52HgvKHl/IF1EsXernjAIYz3UBDK+lsJo8BKKKW0xCera6YK
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:04:27.2286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc66b5e-e02d-4e7e-b8bf-08debfd5eddc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10808
X-Mailman-Approved-At: Mon, 01 Jun 2026 22:12:59 +0000
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

lima_vm_create() is currently run before va_start and va_end are set up,
meaning they are both 0. lima_vm_create() runs drm_mm_init() with them
as arguments for the allocator, and if DRM_DEBUG_MM is enabled the
DRM_MM_BUG_ON check in drm_mm_init then fires, as seen here on
exynos4412-odroid-u2:

[    1.736297] ------------[ cut here ]------------
[    1.740370] kernel BUG at drivers/gpu/drm/drm_mm.c:931!
[    1.745574] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.750697] Modules linked in:
[    1.753734] CPU: 0 UID: 0 PID: 41 Comm: kworker/u16:1 Not tainted 7.0.10-postmarketos-exynos4 #11 PREEMPT
[    1.763372] Hardware name: Samsung Exynos (Flattened Device Tree)
[    1.769446] Workqueue: events_unbound deferred_probe_work_func
[    1.775261] PC is at drm_mm_init+0x9c/0xa4
[    1.779339] LR is at lima_vm_create+0x144/0x17c
[ ... ]

Fix the issue by moving the lima_vm_create() call after va_start and
va_end are set up.

Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
This is a low priority fix and can wait for v7.2, it does not cause
any real issues as far as I have seen: drm_mm_init() is re-run some
seconds after first run with correct parameters.
---
 drivers/gpu/drm/lima/lima_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 0bf7105c8748..7c873e62c16d 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -368,12 +368,6 @@ int lima_device_init(struct lima_device *ldev)
 	if (err)
 		goto err_out0;
 
-	ldev->empty_vm = lima_vm_create(ldev);
-	if (!ldev->empty_vm) {
-		err = -ENOMEM;
-		goto err_out1;
-	}
-
 	ldev->va_start = 0;
 	if (ldev->id == lima_gpu_mali450) {
 		ldev->va_end = LIMA_VA_RESERVE_START;
@@ -387,6 +381,12 @@ int lima_device_init(struct lima_device *ldev)
 	} else
 		ldev->va_end = LIMA_VA_RESERVE_END;
 
+	ldev->empty_vm = lima_vm_create(ldev);
+	if (!ldev->empty_vm) {
+		err = -ENOMEM;
+		goto err_out1;
+	}
+
 	ldev->iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ldev->iomem)) {
 		dev_err(ldev->dev, "fail to ioremap iomem\n");

---
base-commit: c453c60fdba437f69209e027b418c4a24143605a
change-id: 20260529-lima-alloc-fix-2cd5408f6493

Best regards,
-- 
Henrik Grimler <henrik.grimler@axis.com>

