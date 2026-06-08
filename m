Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C870CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF31710F69F;
	Mon,  8 Jun 2026 16:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSJzQpjZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744F110F69F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEc1EWr2/exEyB9QapeqJPBBDZ5C+Fg+OqsaY88TlGIB/OAKBr1pbsJpHemKau1dN/MFWGpnbkoJx1WT8WQnjkxOhheV+lkwwCEmtTwipYpM70q0Do5IG5imPNYnFWl+eB6/NFwRJrwCNnh2cz6vuBT85W5FDYfBLWhw3+1/FtIZ4e/TH+JzUP3e13HosJE8VZGn+gMWFgxFndwSX+h02elhznica5P62EMwl7QtHUni3WW93TRPQT4RiToLMKGisS5YT5o0XeF39BdhtbSm/N7FURsSmlHKg2OhbCSirg5pDrrHBI5sHgD8xlhDJGEpEJn/co1FIdStSH1vSsGvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROaRJ3rg6InXNxsyq34ufQGoJxZ7Rv6Zfa/47DYYFR0=;
 b=IyRKv/3lt2KdzpZxg92bkkL1pJ5FHOvHbqUH42IAYhQC3Ft8fn4hKDwtxpu2Lkau0Zbhs2pKmum7b0+Lnz8kSJqA4+j7PQgUrHUs+Qn3GJGZ2VUX5DiKNv+Hh188jHS/RZGx6uz1pbOpKN2ZG56peFfHK8VBUI99WyQ00mFrQ7NN/YMOFgD4FD9GD2I7kXeTCuZhqZPJwn9onvhzlRCPvUZ+xJs9DnTdzkjBm1uY4DsCv215OugGIEM9i/uCsbT+8oF7Mja80j/DoImy2nxJQEIHseOubVEXEsgLGRwOFDn6O6EscbvX+aGgOera4oJqPcyOSisXAG2iN/qWPY7Lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROaRJ3rg6InXNxsyq34ufQGoJxZ7Rv6Zfa/47DYYFR0=;
 b=NSJzQpjZQBPoJq+8hrPbQrHuHQqNJuWEZVlo/RN8HkelM/42rHeOym1xftuwYNt+jHRmh8FMqYSZMF16V/PnI14U/JuxIVoeKawY4qUdIjdu9Ji6rjG4RgmsKgZ/NpktZmVWILBVrkaBVgPGoz5JHYO7kLWxhabdgzpJc9Dd8LA=
Received: from CY8PR22CA0010.namprd22.prod.outlook.com (2603:10b6:930:45::11)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:14:42 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:930:45:cafe::90) by CY8PR22CA0010.outlook.office365.com
 (2603:10b6:930:45::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 16:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Mon, 8 Jun 2026 16:14:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 11:14:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 11:14:40 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 11:14:39 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2 3/3] accel/amdxdna: Fix amdxdna_client race in
 amdxdna_show_fdinfo()
Date: Mon, 8 Jun 2026 09:14:18 -0700
Message-ID: <20260608161418.2748988-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608161418.2748988-1-lizhi.hou@amd.com>
References: <20260608161418.2748988-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a78d3bd-b86a-4a69-912c-08dec5790c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Txag49FrlRPUSkSeSFrPkhDXw8/QpNskVRIA58yK2Ywe1ZeXdjmno4wl86SeRpWIRijxu3CxKgv3ErU0sGY1h4m+fbr6AFOM5twPiCdmxI4YG06AFY0YEKwM4As5y0FPKiNXpnniZFmPGYhLIFstHdLbdZNW2cJlpxnGBK9zqRfZrWaKptr5WgkmSoZwMmzeLbisHaWrxcrel1qz0FXaEDO2F3uLIOL5Tx5AI1rQOAegU/wutt0DdnY/gvKlxYqozo5pidQCZ/doFsn/sj4Rb+lLf5o4RWUFtOwyHqnHsSrlT23KLmQ7OvUA5/P91BvnAkwdwcNpVlKb0RgTMx9OBcPI06PqSIF8teMlGXS2jmf6+hkJFbXqyep4ClyACKK+bEw0dgkVvsf0yQSLIH4CIdgdAFUNwAnTa2paIVg8tf7N5W0Jfl5buiy+uF3H6mqawL4LsfbjXHGCKaesD3XqzqH0PwOB00xga5Y2XGNukDEh2pcKfcQtfViKTmCf1FHWhWmcFdXW7ZcTPW2nF886exARlp5a7vtlcil3Vf0n7Vg9p6/P1rtmRLyz1JZxXGltm5TMbx6mUVhSto7IjvKnyBO3ifvfs+cl5wy4VNOd59cLR4A4jZRH6GqKoOaDs0p0Cgogvibwotxu+mGTneg68SsyLzXHUdT4sM5ZG0FlMO5c0ydtKmOW5FlY/QbzbooMF423J6/EbjVHtBJFFwj83S/kR+D1xVeK6sqJ0DjufpA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cE3wO+XO/YAhoaQu8xqvEeY6kUhpfI+3Ab2VmVha8oK8zEkDNcgLjIbocERxYWjxXDRPTFFVaLCSVsAd4uGq/YQWDn/MpmmQi9SW8q60BjC/FzHRdJT//yFnbxKnNI+AIHHzcrVLF+tP4TkCsycih6vpk1JYo/VT8N0iZjd8hMe/uegvZ62CAt2GzCjaGiPAvKQ2aq1ZrVZ9z9XYZY2XfRQ7qjVgwPP6rM7oT70I9xW8XjWqzhdOeCC3pWLsTyqb5s4W50lDaot6j4Ox47KNdutf8XnnMbjmiAStuuIRCPx+oT9u+Ey7v1inXgbDhnbDSs88iQxLctEdbxFuFA3PMrBkuwrlQvelrDKf6Edy+6p2mI+48Zi2+KYJtbuuCIzy25noTI6d5PGQYgUWVZmbFCEsrZq3QN4Gn8oMTPXn2ANGq2jnNTm8b3UfRBfYVP1T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:14:41.8345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a78d3bd-b86a-4a69-912c-08dec5790c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

amdxdna_show_fdinfo() can be called after drm_dev_unplug() during device
removal. In that case, the show_fdinfo path may access amdxdna_client
after it has been freed, leading to a use-after-free.

Guard the show_fdinfo path with drm_dev_enter()/drm_dev_exit() and return
if the device is already unplugged.

Fixes: e0169d0c690f ("accel/amdxdna: Expose per-client BO memory usage via fdinfo")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index c18ddad9f645..e6b541db3898 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -296,6 +296,10 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
 	struct amdxdna_client *client = filp->driver_priv;
 	size_t heap_usage, external_usage, internal_usage;
 	char *drv_name = filp->minor->dev->driver->name;
+	int idx;
+
+	if (!drm_dev_enter(filp->minor->dev, &idx))
+		return;
 
 	mutex_lock(&client->mm_lock);
 
@@ -320,6 +324,8 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
 	 * drm-shared-memory counts BO shared with other processes/devices.
 	 */
 	drm_show_memory_stats(p, filp);
+
+	drm_dev_exit(idx);
 }
 
 static const struct file_operations amdxdna_fops = {
-- 
2.34.1

