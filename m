Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE576CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 17:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C715F113266;
	Fri,  5 Jun 2026 17:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBGBmIGB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A085113266
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 17:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5GVl9CwZ1euHiJGWepvdAG6OJNNBWec0Z8x/IEH7J4SdVfvNStyD+5hgOcUs8M9JYbOSfSUXJkLcFiRNvP9fDcRolTcgO5avOl+xL8ih1kI/1JOhdsSlkt3YpswYhik++YB4bgAdhAnpuxARScd/tmWQ1cTUZzsthMOjycW/oMpNXo+XeDZ6SMhngNfWcubA5a2GwrKVGZMJEodporiQm9zFXROFR274EbTBw0I+AIvjg0RxfrpVprqYgWK4LWDST0zXyXt3oO73NMLDjKlF1MpMKQ6P7vS9NknWWvYkaX8IO5jPzjox11+DGWEHCWuuXHcfjykFatgEk6o0Q4B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FT6wENGFW3qBPdc8IlpiQEcdpoYdjunN/I9i0wmufs=;
 b=wL4D06oF8qk4bQvdw6C4l2CGfCvrGaJIbFA2BGLLMcaSwhur7SvT4yGpqEZQ4df6D+gcBwuPsd6pk1UknTcC7EaXp+tFK8pKGvRvZlhGjnZy+ombPmbbtTiySI8bd9plK866f/gNV7Zooz7buXTgBLSjU3BwXmcO/T7DksMKSMA7KHFyRuus6w/LU/zwJALyFQo/jdUHXtb3ru/ZlpJmCO53RxUXLsLjmnsqHIGdUStbW69tnOcbry2fT7osciOf0eP9iRdkFgY2rY5qs0Wi8mQ5LZ9oOvnKYjVzwkjG1A/EILIn8cSTiqHRZs9PLZi/QzySiOXlbDvm3gQq2SMTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FT6wENGFW3qBPdc8IlpiQEcdpoYdjunN/I9i0wmufs=;
 b=XBGBmIGBQQxVdvt+AaykQypshevkdq5f6EOrzKDjU3VkveOLz2ErHo94AZQ7+Tuvjx3e7EMb5oyIZTyRW74bQ/zqxS6fQ41xFDW4aBlqJHjuTeGHFJKH7GNgYUD828Tzq6kFICID+gC86WuQJwhlQUnVB04iChaDx1HUp+mQCfM=
Received: from DS7P220CA0123.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::19) by
 CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 17:53:55 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:25f:cafe::96) by DS7P220CA0123.outlook.office365.com
 (2603:10b6:8:25f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 17:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 17:53:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 12:53:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 12:53:53 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 12:53:53 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix amdxdna_client lifetime race during
 device removal
Date: Fri, 5 Jun 2026 10:53:51 -0700
Message-ID: <20260605175351.2496830-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c84a85-68df-43ac-6a8c-08dec32b68f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: f+FF7dHjv0l1H6uq6PPdKqz46deHrdVILbHwW+MKhnLvM6m8EaWdQg2wbrvAdrIg+5k9LcuVKsCGOStrDQ95sf0lXXPd6jMNAF+Sg/i0S9eJoxHSYRFijWnGP50egqtdqT4c88/5Ezyxwm+3Kq8a7lTOkH3tZKNR8HiqYQi8GBPRzk7R9VHsVRe/geAmOLNspGsXdWUg28ZJ8ssTrQtl9+M3Tme6CeigYjrSDRYqjvQUdpI3XraaJfxEstuQxHNiBS3dg8JTEevc4h73p8MeYIED6KyJoBAEHwY7fFgo/73LI50G8STHkSUkwffTBNZOrrvs6+YnR3a+0/dtugwq+bLyFxqwRuHjMZNsbBDn4GOtC4NxKrTNXYW6A90r6qowLt+jGQGd3JpEGTpLjZOhk9285SWRhe+xNPBZP7dx30hmEwX5/QKvI+oXt0h2cWp+bZExRZdiVplsUnsDgS1IVJWvL5KRqfeP/xXTslB9T0WHFYRefQuQdeqr+OH5rplQTmbO0anFJUZUKVEWDu3Qsc2TRwscOrYxa9aybvAYQYQ0yhcnXWPMIn0xS583zLaiya7agAR2yk3vo4x/beuLM2Im4FT8hCJOaQ5JNHGbZgBsD1SKK9a522xesyvxA8eZnS2XTuez491sZoLKJLasXYqIl5O4G5i355H0DZrjF9oicF9OSJdLoPLD9IJaczSfVLr2YSp9j7JqiBydzqCqTwu/HGoCg5j8QxeTIg/+WW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WSRZYrQnYeWa+O4KIu7TvkEuJa69svG1QcARxbjWUkxfuSbssAahq9zNJE5IesvnHgUQzFmkayAODnasvAzSiLQR3ztXzf8aTpbV1LoFIR2IJPpfWNFNmNbY5S+9Uxl8y5X4dDKnTpjPia5VpYbZ0A7zSHSE0NPckkPt7E+hW4866AuVfawyN9SwZlFgOYLh+auDW+Kpk/ilJb0XRSLO5aNUzJiJ3uuxZFT+1qQ9sZ3gv6ngHdur34vei6Bjznrv6G9eR5nhS9D51OwgR1G+g3v/t+2enJZdqHSy97AASmILvfTjjtMUrdR8OFMjboIWC8X5rdEuA2afgGALK7oOWfCRvOHF6lwcrCaACm/cqlgXvkmqyOEAyvMr7jYqHmO+p0JeHtGhsMl8jkkL6FZu32p4opHolCSl6suzlzez8ojiW+juTFSoYZG63AMvm6nb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:53:54.4504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c84a85-68df-43ac-6a8c-08dec32b68f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

In amdxdna_remove(), all amdxdna_client structures are freed after
calling drm_dev_unplug(). However, drm_dev_unplug() does not force
existing file descriptors to be closed, so amdxdna_drm_close() may be
called after amdxdna_remove() has completed.

As a result, accessing client->pid for debug output in
amdxdna_drm_close() can lead to a use-after-free, since the access is
not protected by drm_dev_enter().

Fix this by decoupling hardware teardown from client cleanup.
amdxdna_remove() only performs hardware-related cleanup, while
per-client resources are released from amdxdna_drm_close() when the
corresponding file is closed.

Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 65489bb3f2b0..953f4807c739 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -174,18 +174,12 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
 {
 	struct amdxdna_client *client = filp->driver_priv;
 	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
-	int idx;
 
 	XDNA_DBG(xdna, "closing pid %d", client->pid);
 
-	if (!drm_dev_enter(&xdna->ddev, &idx))
-		return;
-
 	mutex_lock(&xdna->dev_lock);
 	amdxdna_client_cleanup(client);
 	mutex_unlock(&xdna->dev_lock);
-
-	drm_dev_exit(idx);
 }
 
 static int amdxdna_drm_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
@@ -443,14 +437,8 @@ static void amdxdna_remove(struct pci_dev *pdev)
 	amdxdna_sysfs_fini(xdna);
 
 	mutex_lock(&xdna->dev_lock);
-	client = list_first_entry_or_null(&xdna->client_list,
-					  struct amdxdna_client, node);
-	while (client) {
-		amdxdna_client_cleanup(client);
-
-		client = list_first_entry_or_null(&xdna->client_list,
-						  struct amdxdna_client, node);
-	}
+	list_for_each_entry(client, &xdna->client_list, node)
+		amdxdna_hwctx_remove_all(client);
 
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
-- 
2.34.1

