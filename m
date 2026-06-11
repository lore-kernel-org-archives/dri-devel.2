Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01C7CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECF810ECC8;
	Thu, 11 Jun 2026 05:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUF/1cuv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3554310ECC8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ0j6zNXMyu0sNPnVJEyq9TD+6G6P4DNi+JfUNCxagt3T6hQKeSmpliy3me6m0dlb0+o8yf2/q8Hs2G8DkoeNjzGmyrcdKujnjcCZShW/oa+pAdBIW5cfxbmtBEx012NCfaG7uzMGBDjfPj5YNJcsr9Acdu8Ea2+CyJM4OzPBFb47BrZQgbvcBowWA5qMKyP3y2GOYnLkuEbjjaSsyr4SJyWxHjtDmtaABLj3YHXEgNRXA5WoXnYENeZBFRqV4y5RyKxBx0Nqddao9unQa4LsanRTP5bFg30UjpEtDb+MKBJAeOWqjJTZN2xCX6dJ7/FvhsZvNNDgI5RQivJPwItBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCv9HvpbItZ6ERQSp8RfADk+/q4lAqyuIqME8CMnfV8=;
 b=CeEW/OF9hvOwEBT2WOXYUWEawIVn5zCdb9jYRlRiz+ROChRByWerNIApZ0FeMf6Qbv3F57Sv7Xphq6G1d9gCPtG0vATssy2mO0GIAk3zNSqIE49fVY0e9xQ5dtlieuk/pjs1cg1lJ8ej/IZqRVi562hiM6uaJxoJ+nh2ARYHY3w3Z3fIijOh753xxysr3zt29D2CMm91DArbqp+A1M80F+fK6cmuW5wXIGVd+U4echHMKA0yFfAInA8636Y6d4FaBW9fdSUblBuBr+wDnGcpUA9NitTiWrbaVe8Q70ZvMBl5WFFKfx03flV9kyfTKWhTWXAsenFfSA4oAwfoWlJB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCv9HvpbItZ6ERQSp8RfADk+/q4lAqyuIqME8CMnfV8=;
 b=yUF/1cuveY9KUZ39zsoXCECnh3r5w6J2EeOn/opTpl96+UGK/o4VOxrsX6oYHzL0hD20IxxSg83fe52dqWN+UBLZBkNYOd+f1XTfxPWU4JLj4kqxag6xXqflMAK+5cd1vVz8QjT3t6Oi0t0UIJIPPkWbEJz1y15rZGQ3WPt/ac0=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 05:52:07 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::74) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 05:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 05:52:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 00:52:05 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 00:52:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V3 2/3] accel/amdxdna: Fix notifier_wq lifetime race during
 device removal
Date: Wed, 10 Jun 2026 22:51:49 -0700
Message-ID: <20260611055150.3070216-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611055150.3070216-1-lizhi.hou@amd.com>
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 95230c6c-1eb7-4767-2054-08dec77d9248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tjj2e2yvpoBzHSchbIv5ErKKl261tlJWDx0J6GDAIkbWz/MBikgBR92poB10eE6inggNe2NY31QSoXC1bKfTac5fWO9w1l86Q2ad72L71MoCU99yhatoCAG/smuIA4mvmBuBBp6ts/mPm3O1OKOZcpthlCHrrTKZJXf203ahdouj1yl0GF6tXa7xDgYbpiXoCIKu1/h08MUEQdf3L22OQeJiC8kCokSuuTfsMvr79SoQ7w39s1XhlMoyXVGmUP9ROb95P5JZ8cD//A9povrWzC/ZjbGshqlMlfCVcBFKaolysQ1oWNMHfGGtw/gsUO0mUyflp21TTT07M6vG6FI4dZG0p4SjhdslXtSDGmT8PNONll2ACVM8pzKEyVEVJdaKlK7fJTpDbvoVQ8lNUI9PsJvNVRN2HXwGmeEMsAv7xbTIakE0oeSolCtemJoYmCvSF0qHQxJt4XLNQSgqCJGdYpp8EOEs7vCmzUQh0I064DgOu0OCjJuIm9P5uyAn2vNaSKycVz9iNQ8UxN9M7k7vdUDRC6+AA3Z4wvGkL9VMn4m1aN8NCbIkfqgycrh3eJVi/lbroi1nioxwo19tpiJKCN3BadCRNRf/O74mTpv6+ESy5HAaKidy2Sjw3nP0Sz468vAPjSemwCSAbXZB7t6yqnkSjgcFaZgpuWeqNCgJ2LZRPZxWsCadX57Y1OI73JDFaZu1wvXuMcPF4HVmLSpItF7ZDs5J/I0JWdkVcH8o1YU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MjYunlJ8K++Cd7EJoTCyTVOSyyvUIC16tLqaDiTc3LlQDd8EcaTDYK/2mcDkfCCs/M2T1xB/TClm7EGnMTJgPrHBV3lT7pb7TXaGsWWsOC7LlkCuy5yXxpgcWt8FMqfuCeLSnJpiY3brCKgFc78UcUtZ+xbpdHo1Eq06J4yXmqtj84no2wG9MEiFOgVcy3wsEUDeYKZEoXHCO1nvigxkaEU+ip22vg4Vmq48qRw86co+SQTZ4LmXLB7PAZCEfU9QP4EinmtLXZpCB2gZb5VEHHVtZ+r/JQmOQlS7pySGBVBES6A3ia0NjcggTPW4rsRNSVy424NaxvjLP6dKGS7jyYAAmj4tcZI1m3oqLKor6Jmky1H7OhK5awbPEUr1I7twF6nuujcMZ9SMGAGaRziM4vDNoELssJlRCFtUlmtZB4AEzr8+u7+hKvq1UZaTfvbm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 05:52:07.0875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95230c6c-1eb7-4767-2054-08dec77d9248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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

amdxdna_remove() destroys notifier_wq. If amdxdna_gem_obj_free() is
called after device removal, it may attempt to flush notifier_wq,
resulting in a use-after-free.

Fix the race by allocating notifier_wq with
drmm_alloc_ordered_workqueue(), so its lifetime is managed by DRM and
remains valid until all managed resources are released.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 470bf4fc744b..b943c06a451e 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -389,9 +389,9 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	xdna->notifier_wq = alloc_ordered_workqueue("notifier_wq", WQ_MEM_RECLAIM);
-	if (!xdna->notifier_wq) {
-		ret = -ENOMEM;
+	xdna->notifier_wq = drmm_alloc_ordered_workqueue(ddev, "notifier_wq", WQ_MEM_RECLAIM);
+	if (IS_ERR(xdna->notifier_wq)) {
+		ret = PTR_ERR(xdna->notifier_wq);
 		goto iommu_fini;
 	}
 
@@ -400,7 +400,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_unlock(&xdna->dev_lock);
 	if (ret) {
 		XDNA_ERR(xdna, "Hardware init failed, ret %d", ret);
-		goto destroy_notifier_wq;
+		goto iommu_fini;
 	}
 
 	ret = amdxdna_sysfs_init(xdna);
@@ -424,8 +424,6 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_lock(&xdna->dev_lock);
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
-destroy_notifier_wq:
-	destroy_workqueue(xdna->notifier_wq);
 iommu_fini:
 	amdxdna_iommu_fini(xdna);
 	return ret;
@@ -436,8 +434,6 @@ static void amdxdna_remove(struct pci_dev *pdev)
 	struct amdxdna_dev *xdna = pci_get_drvdata(pdev);
 	struct amdxdna_client *client;
 
-	destroy_workqueue(xdna->notifier_wq);
-
 	drm_dev_unplug(&xdna->ddev);
 	amdxdna_sysfs_fini(xdna);
 
-- 
2.34.1

