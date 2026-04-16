Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E48EF8D777
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E669D10E1A4;
	Thu, 16 Apr 2026 20:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nf+DH57O";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033D10E1A4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIAblHAx6Nl2ORRJ+c80cfOIkftPcOUkLTqWfyFFKFHhoGPqJG314YBG7Zfhg60HVNB3iO0yogAHLcpTBkh7dMWLqBt2voYHeFLiAJN9hTLde0l4NRB53CEk8BeiSFiNjp8GRr+kzOt4Z0ofXYQ1QTZzjyTRfafv0FVXopjznS4Mm/aC5+jc6bDI1RAPupEoS0Zx8175rcMnk34+nOHp9x/dyDZIX0NiIokHBFedscwybnoP9vh2Il+bXJamT8rfm7kuOiaFX0mrHeFuwjiuSLTJIhnpZyLiFf4MCNtc30DqNim5Xosd21gOXQT1tpT+aiPth39R2cz50Y8CKxsnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvBls/WDfQUi6o5Hs9yq9ikn5sd08pw9j6nZSSKFV4Y=;
 b=ikeZJiI8ZejwFRYINt3cVMdwRaFR6cEjCx1QS41E+Dtxl0nzGl22/fMc56YOw1ceEL12C0y7eT7mFRIc5xOUvNdcG5dESQQmrezChXQSTsafM8vQRoC1vwCdOXeIhS+GiyAOMEGpBQQnQkalnvBE0FdMQpuQLDjCY5qfRBxMo/we+SIFTXsFEHHP1zcG8TXp6/tXqnFAtj/FuB5BPmKbuUJ4PbNgE6LKnXdG9lC3AnN3mJsTXVySDGUlHhRwlUEZ4GltLWYi1HuT6w4CjBvhQKThjgISzqBkJK1uXulY/0nYPZQg6I9tTTnTIwlK98Ep0SJxoZA/Y+wavkN3+PwPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvBls/WDfQUi6o5Hs9yq9ikn5sd08pw9j6nZSSKFV4Y=;
 b=Nf+DH57OGYkIGfKE4ely+x0++D3z0zamN4j7Mg9YfYmg4GUAOM4DUiYFUQvVegLWIJ4D1DnsXkvvAXY6x8ThOIFs9PPx8riu388reaQegrpeWSxg1a+tGc8a+w705Q2n/zEDI/SdYSZQYHX9xWN3pSQwhxvn5flBEG4Bp8iPhq4=
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Thu, 16 Apr
 2026 20:11:12 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::22) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 20:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 20:11:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 15:11:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 15:11:11 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 15:11:11 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Guard management mailbox channel cleanup
 against NULL pointer
Date: Thu, 16 Apr 2026 13:11:06 -0700
Message-ID: <20260416201106.1046072-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d95305-ec77-4140-9552-08de9bf44e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2Vxdm2W3GkPfZH/kBiRzqeY4nmjF5Oe2cu71kd7lU1XoXApdEJIHmJwvDJHhPzkY0pbq8j087v1BjhtMxVMHMlWGe5pLmBkjSqJkfsP/0cvcjhKElpe0YQSARGYOGqE/wAonMnZSWX7l1Bn2AGmVdr985wXCdqDP3JDYT+DA04FoJVXf1puHcFHJk11b/A1JOY2eEeURJm15vtrpYUp2BGD3gN0bUS+NY2C0gBHfkP4+o1NLsBCSpN/JBPcSLhZ5O/y0F5iVaGBJUDu4XeYoUrhANZyb2x6VEXpdv4udkRR+0o7c1fUsp2xQQdkXOYCKlli57RcLA/BXO5TBIr5hC7TYuocqlMkGxbr4tFuFxmmGHkkJX7MDXS4k1H+3sejgOouNlf/6KCishCgIaoAfDk2MOs20Kpgi4EB4Tg6DKBJu//y1EJDJgO5z+t93ZWT/d3KLu0QhY93z5dP4VOhYBD9L0ppgFPw0tUNSbDTLeoVq+X/U0ZEYwIoVO4XlZ6fXS9PlZfkLj7wDCpz6R6tB8GGROGkye3kYhxMzeGkek66mDo0Me2fq3s5scnhgTd/A+X8ZdaUyhww3UuNTgliaZvt3V6FoeL9Fm1MA5w9ohxL4THhrSgTLXkRy0wyQmPIJymoIeAr/CDjnrKgIPJqbqKRDx5IKqITCauzncyPi6XnFYof9HiavB/HBXLrNS18dXbO4c+0Wblcl+tVD4CghThGwZaOllhMR7mRaszDXsGd3osP0ftYk0QHfja+Ln9VhwRjjRisyeukd339gsponuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YzrcI3b/EsHWQnmVMbWG3lITkehW0+halhSKPOm17PtHybQcZguSYEYsPDhLTiBFJbIUljPzQOnKUVF4dgQHajQnqwQL5h5ew/kJxYwKLnGysqEJIfgyJ0bzxX3JT0xKTlJGpYBKBRZkYzt0V8sBH+c+HY7XAnEVgpvH657pbgyvEUCuRj2t/U2bxKBvR0EKpl6Kd7a7aKso7H3vD5rBsB8ZhSNaBieFpNzJdYtr1XFFhOG97fLoxR0gT7SZNeq5zlOqkKQi+S8pc+oDXH3M2y0VeHzAJIsZqddDPfHQMekeukIwog8gWkPhoUvDwPE/1oxZvoadE5h5swlpZAVsaKwWhynacvcalM9AN9sHUyAiVb2mH1yHYqKpCNgb7s9QGzUgDfBb4X/7MCalSKzahSwsl/REWhEP6I84RDuzZrskCsevq4yj91btdqfOi6Oa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:11:12.4533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d95305-ec77-4140-9552-08de9bf44e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

From: Max Zhen <max.zhen@amd.com>

The management mailbox channel cleanup helpers can be called from
error handling paths when mgmt_chann has already been destroyed.

Add NULL checks to xdna_mailbox_free_channel() and
xdna_mailbox_stop_channel() so the cleanup path safely returns instead
of dereferencing a NULL mailbox channel pointer.

Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 336e5e77f18a..37771bdb24a1 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -496,6 +496,9 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 
 void xdna_mailbox_free_channel(struct mailbox_channel *mb_chann)
 {
+	if (!mb_chann)
+		return;
+
 	destroy_workqueue(mb_chann->work_q);
 	kfree(mb_chann);
 }
@@ -542,6 +545,9 @@ void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 	struct mailbox_msg *mb_msg;
 	unsigned long msg_id;
 
+	if (!mb_chann)
+		return;
+
 	/* Disable an irq and wait. This might sleep. */
 	free_irq(mb_chann->msix_irq, mb_chann);
 
-- 
2.34.1

