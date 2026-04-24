Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CEFFF885C
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5840710F6C5;
	Fri, 24 Apr 2026 22:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tP1BbC2/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC2510E40F;
 Fri, 24 Apr 2026 22:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqxk/vm+CMGTB/Avsofh9VmRCySbcaiEPh84CXZH/0GivIotfq7T7UDITiB4nOF9P+u8RJwQg6U/OA2BbypkfM6MWiy1cAN305VTfelnZi6rC/TEo7XnrEpfVml8CrvAO5zaMWtUTKqJq/Ha+Re7x3vniY7JeKFPzhOcRZ74o5mtJLKdxZ6m1P1mc2cCzdEtsSnEYlEUNSgJVHW7NF6teN8NoyqEdd3zHl5aN3UrFflotZMH+t7L/zLyntSe20JJ/XbsxZF/Q/SzbhNcbpqLJuLIaep9bLRUaCVw0oyGn9mu4HnpZvtJEa0NjbL3KYRuOjbuolNBvD++JJmxTTxCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1dXhP0kw2HmJ6HRnglCwoXpRlmaGckEcYiSIx6rfSA=;
 b=eIkiavPHAM25NYbgNZ232e2PodOYkMQPInfHzSj9IHFqNn8DouYKFziJs4/PNhnhjTumGZNtjY21e2qkd9/iBKN/WiPdLci0bAf1DbJQjfOCy662349y0dpIv+exQ0llHVxWGJbGnOgrfk8ebEUxdcdlWROSxkD51IfhJ0rWvRGVdwj7UqB+1w+eYXUQvtefxGF3negM9t5MvKV0HPPiEBR7GaAn9iz5mxc+mh1dwD+nHGLFGBQsGPdwEHh/PlSn0+wV+5xG/16/5uKxZdQtStm9myOhyhu7QYpuHu/4ld5GvSKHdLg3E3f/3lXzVWn/8EcBJWqf27hQc5PE7WlGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1dXhP0kw2HmJ6HRnglCwoXpRlmaGckEcYiSIx6rfSA=;
 b=tP1BbC2/AlkDG9XEtVh4bj55FUC2FsSKrtGFSKizxjNM9OdzwA8NH/BANHlP7AYOFtpgymu+XNd935bf+aZqt6YrgeeyHO5G6Obief94zV0S78lvtMn+ajhlBjcVulL38g4WWfPeCWm9A6E+s9dlCKRCfFhvwNnptiXlrxqhhZs=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 22:10:13 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e7) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:13 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Marta Lofstedt <marta.lofstedt@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/8] backlight: expose the current brightness in the new
 kernel API
Date: Fri, 24 Apr 2026 17:09:47 -0500
Message-ID: <20260424220953.167058-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: f9291a64-ada7-466b-6790-08dea24e426c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lYnKFbeFduNcOigRkilxeKQMDD6JYj3mQ4f/YOY/ifpAoUHf+VnbNfYrrVDba0QjSB7o39AMmeGA3MZq8/ekfk6TtyErJ28lQD0ypjYxzlDxiH8Vro9CVOhu11VaAnhUEow9ygtCpvJM93/LsglMquXq7aJgQCHrMNjxTALymlOP25Se8B1O9Xgbp178ElIko4uCYJY/sxznwnTAYlpNI5cgOWxnxWRJk31rmB0v1T54VRepkwZYbFQ9LyIhztwUCxW5td17EXXeCVgiuNg0Kjp33bo3XBBwmjbhDQwO96cdFKeAfA6KPf7djCEWR9l3hWbdLZVYX7j5pCdS4iLwSMpQxkEuW3FfbVgLxGnULt1eviImr/z8gGjMuCLvF1CA4PbtOyaubbW13kL3OgUDWV/K4p2bT2G+Q2rOpICSEW1AOZwMtVLnsBHP8f92/hgbmqBW6Sl5vD6ngcmSFh8fE4cLiSQSwXY7rlv78AFu+FG0hRFdvkAxocVFDwC7eBX1kanQimmfeVd0nHTjLN9pEY3eQXt+0twcy2wUOnsIxQCStPD+GmUiN4LtxV+8qeeT8h9IeGs0GmWIh26fQoSM22Fucu22hcHsrdm8yqyy1dBLR05iK8A4ClNSuEtCnhe4jSB6X28IujxyfdgsgqgnLv1bQT92rG1nq/t+vTFjrdS8X4mMhv10e8163pkq2lT9sCjXibXAAnI7onx1d1iirAEupD/VlU9+WYWBKOP22CBfKdaDiJeZV4zX9ImfEZhy/YPGLXNr4vNr1sIYqAzzgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i4W+o3vo82vbXLJga2XqZW7MrOIILkyosoLzjla/ZU/Vr5110hJcdN4c6SSpb2146GUoAlbKUVFu4dKbK/LFCX1iJYvPGAZ9TDCqs5/BED4arp1/KUWJkjw17gnN8Veknx/1GRaNwBEfqhZ+6LdyTcUwNwzQcrkNFY4KDIB9FJSQBVj5/M6AhlxpF1aYmSmc8GoFxWyqiicVSBWYWnf7GI0cNb8mC2d7f5Ku1edZg3ltpYO/9XQAktguwJuYiHlDPJGELwb7T8ZYmese1Tbkd8WR5lWYwuS/QkA8Blt6X5yVENrAJPg43axS9jewIhKzzfIV0NvxJP1mKDi7sepXoqcntln0HmgOBS04KUJpzdddo0dAsafVZV1ERk6lV5zZtJu6MDiaOtWU2jF74rXpnGcKsV6WwJYmmc2ZIWF+0xRDjlWMtyOi6TPhQCX9euoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:13.8445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9291a64-ada7-466b-6790-08dea24e426c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

From: Marta Lofstedt <marta.lofstedt@intel.com>

Current brightness needs to be queried from drivers.

Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
v3:
 * Rebase
 * Add description
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/video/backlight/backlight.c | 6 ++++++
 include/linux/backlight.h           | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index c3673bee6d9cf..9bbfc16cf2d74 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -206,6 +206,12 @@ int backlight_device_set_brightness(struct backlight_device *bd,
 }
 EXPORT_SYMBOL(backlight_device_set_brightness);
 
+int backlight_device_get_brightness(struct backlight_device *bd)
+{
+	return bd->props.brightness;
+}
+EXPORT_SYMBOL(backlight_device_get_brightness);
+
 static ssize_t brightness_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7e4fee65fddd9..851570b39d041 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -412,6 +412,7 @@ struct backlight_device *backlight_device_get_by_name(const char *name);
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
 int backlight_device_set_brightness(struct backlight_device *bd,
 				    unsigned long brightness);
+extern int backlight_device_get_brightness(struct backlight_device *bd);
 
 #if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 void backlight_notify_blank(struct backlight_device *bd,
-- 
2.43.0

