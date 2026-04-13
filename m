Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C458F531C2
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879AC10E444;
	Mon, 13 Apr 2026 18:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OEGx3Gm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1804A10E444
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcW+bxlozvQA9YHfxcbrEZcce2sGB8T8i5vdLpXUtT5biL37CzOxl13gRFWxpbP+iUBW5k9bkYk2O76+9zGiBMo66qjxXqv0WKNmcu+IR2lDk4AhKqJzl+nPnhyBLrDnj/AuaB/ngPvx1UWDGV5LwcbRkixrQ5YMpv7LRPTIniuicGnCRdHAYcTuvPUfBP2f/hNlJ0+/ydyqFdjW7kvVr1po2DoEbKpFMHJ7OKJjVJ9MdSXv7pHGHDlIiHWnD9Q+HojO+DwM+sv7Jxl4QQoNqOFtRsbVK0uPGV9p8qNjwqla1p7z3tJsvwDdrQHC6++8rF8MVzY/ekfvsGHfEar1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7GkJwlpQGK63K6d2Zv7Gb/BIElZg+IJCgNIMFrBHd8=;
 b=ATs+PNl2I0yzsI7otrCYRrymifhEqbjiEDG9DqDgfRZq27PjbH/Ir7RsLlv29OeIE4hKKf8jWhKM6U6y4Rux7q+99pxo0JDgVHQZ7rkiCny+R+kVPNAhPJoC5u31JwdNYA1QrZQyV01P8Y+SNQZRmVoYaBfD7Ko9XNQpRzP6y4GipldjmXiw2LBvClLnSM59nkf3S0LC229frYUG/YDIetxbSdgHNjWOAQVzXRlFdZ7ZDBQ6reGqmtNvsHNqs4q0XnYkCAZL0Rv7NcganrP56RCZl/RaZ0C6fCh3EtIcklaH2cmEJzk3T4hVYS8JPk1ri6PzVVLVO+uMYbR6Xs2CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7GkJwlpQGK63K6d2Zv7Gb/BIElZg+IJCgNIMFrBHd8=;
 b=3OEGx3GmbbhUjQOI6K9lAGs8tLmTIQH/TkSAqXxHcAOsHq+g/RJKTRNecCjCw4M6bMy0B9LCDpUVv5BFFI0hD34AK/EaQcWs8CnKaH164uZ5x5M+NVKkD1DhvbhjGn7yOl+e8+qOsNEYmR3a4SYUHeRumHYIgb6YD4BX7y2bceg=
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 18:18:46 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::e3) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 18:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 18:18:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 13:18:45 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 13:18:45 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix order of canceled mailbox messages
Date: Mon, 13 Apr 2026 11:18:43 -0700
Message-ID: <20260413181843.670796-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: bc16ff78-5dbd-4502-5a74-08de99891a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fn3O1K0bVrdNavflWdQ4/FDONNLjGQdxyXlYk91Jy6Rnl/cmOsP+tLZu984cOaQoLzgfJdWmGF3fJJrbp7zDKtcgkcGiyah3NJtpIgO5o968QmRrB55N6eZYupMKzaPBlnfjrMT+/wisqrR3ddcUpRf9yLgTLxDvZ0eRXsUCF4IWggfomoZ6m91uOhwSnoMp/WunmdVV2aTcvLXzbkwyjdF9Xssfj4zGVu6t2i3kYOl7I+pcsRY96Hea+bVelL0ySjryGYDCcG9W8oPt1rr31XnnXMd5v6fM8AsFzJ/ua+4fwEftndkFtfkJG32QY3ZIIWMEN8w66IEytvH77a5ebZT1WNHPuscw4W2Z3qkLetSedZUcrpbFz2Y0V9qrABy49qAkJh47ah+LAX/aRt9eyi0Y6b3ohLSgTCACXvWblAjflcS0vpPsvs14EpSqS7rBnLSllWoIXZcbpldM/Er4rlWqrDNxKNpDMlfCfhntaTpuutUV7J9RstmekjrkrqIdOEDrHbQ8L/KttybDK0AEzThROwlczL2z4FxOYyklzt3OunZs9Dn0KQ/bQIBlXnah4Xd92mbUe+e2sHKeivZjUfJIEYXZYsVBYq5APMqRhAQkGX7R2cGkxCHB6RT21WLK2FwPShMK1/lDJ/sKxN91TzNcVqug/t7GmoIh96GLWUwQlh9NHKsYJhOY/2l8s7gZAwOwMURzzlTamjThi9p1qB0t65JfkvM97HuMRSC5cSIbmvrKdRjpqMniaFl6uexr3wpkBzvWEH61y0xHUTXZAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V0kWZqwiZIq+m35J21wQO6ShdqWvYPMvaEEmtkC/Oz0E737HOSe69mIQgtl5slWkn02AlR+uekdMuV+oarRr7y6vD7sX84JjgRB9qay/PnouAfeEJFOeqMH7RtLVXJfBhsAagvGsgkxVSBnExmbKm/qH3YWn7qPKycs3ZnmS8YVyZZez+pJT+OSLFa0bRBF3soHCiaj4akZVAIAwguBMM1nzTvmG1pmhx/3PX4gJ4zKNMgL6gtOqJXhkI3DfnL66eFtyrQ3/AXpdoFzUJkWVzsWOnnL6LU25MAoSyGgySy6mxfO75UyX0knJYzQLuAm1GQ7OcmOawriJbfbqpSBTec0GcdKvHItkQZLq6W1h3PMw/Q1/WT+nA8QVQZ/ZNAvczlwxAY5QuiW+55QIv5A6eiQJvN7a8wH30DJG1pqw//mAaKqHmh0Q3/l7UKFNdTtq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:18:46.3937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc16ff78-5dbd-4502-5a74-08de99891a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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

Mailbox message IDs are allocated cyclically. When destroying a mailbox
channel, pending messages are canceled starting from message ID 0. This
results in an incorrect cancellation order when the ID of the last posted
message wraps around and is smaller than the ID of the first posted
message.

Fix this by canceling pending messages starting from the next available
message ID, ensuring the correct ordering across wraparound.

Fixes: a37d78470bcc ("accel/amdxdna: Replace idr api with xarray")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 84a7e92562ad..336e5e77f18a 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -549,7 +549,9 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 	drain_workqueue(mb_chann->work_q);
 
 	/* We can clean up and release resources */
-	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
+	xa_for_each_start(&mb_chann->chan_xa, msg_id, mb_msg, mb_chann->next_msgid)
+		mailbox_release_msg(mb_chann, mb_msg);
+	xa_for_each_range(&mb_chann->chan_xa, msg_id, mb_msg, 0, mb_chann->next_msgid - 1)
 		mailbox_release_msg(mb_chann, mb_msg);
 	xa_destroy(&mb_chann->chan_xa);
 
-- 
2.34.1

