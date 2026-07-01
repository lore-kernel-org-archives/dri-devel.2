Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AFEC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA8D10F1CD;
	Thu,  2 Jul 2026 07:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T88xT4US";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jMlyio/b";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04EB10EE07
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:15:43 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uUXJ2535139; Wed, 1 Jul 2026 01:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2XOXndb/e0ZkBy4LNF/NiNIQJiJfZJADopLl+0bDH
 kU=; b=T88xT4USmYkSwofjS59qYCvBmWcAGcFgcgLTmfgTVkAPSlEl39zNIp6/Z
 6FEjfJO+46fkh5MbJCC949gh0+PAk+L6fET2+A9nyua2BleAJ/Cz2VsoyZxsMjQu
 drO/BDFFJ3II/WHLgvqLxhGaK3f9tcATxpeSPUAZbEZCv4tamo6z2/CKSSOp/tl1
 FZgT48I/tkDt4MUE2/2EoMaIMBNIZj3NAXVk7F2/hWVihHuL/8qUkvYnYBgcZ2zR
 H/2CmPgY9nj+89FdLQpv/c0IQEIOyTigTkGOGkk6jtcVbyaKuOCtsDHuu9EiW/a9
 jOVKgbaIkWGf5FUoEf/W5q7oFTSiQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvwtcc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 01:25:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzw+cfGw7V3a2Z8oqgtYo28d9xlxtSig7MTVL2MFRAUPcN33zB9cRPcR6YKvhjBffMkLr+iigEeebmd1tdqkYSGYxJoxrtdHnAHAISSy3icAhrevvZgwiGWwO18pgcc+boFQITFmiWKFZ4KXNaDqiR/jHCWFCSN00XEdj9qzoGlY1BIr18LhAcgRWpIF0OjQxpifCn5ImJSpgb1WRTqxeaclVjHvb5WI2S1sNU99DitWMys1dREWwH+N+rhx4xJHypcHhUbMHQDTuBQz/O8fCGQeatuGykt41mT8+MyXPw2IrnCDTKL++k66xHR0DYKDfD5fpjCvdVKjKiau8W48DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XOXndb/e0ZkBy4LNF/NiNIQJiJfZJADopLl+0bDHkU=;
 b=saO/XB6PKIDdiKYDKDd5o6t1/b3mGxVb/2VpOgyfA/7p74KpEmKmQ5FGXvpEAO7j0sSPXyobA1PtOmp+BUH7fba+/a528Yy8+eO4kRpKXUfYRJ48c09n2zgJ0ryQ3QDz4sjHfowIqs4bDtFYPfjmZPMWkomh8NUNr9eBFGB8Aok01vGwU32up0b55eBvtElgJ6NArjyyewC42vO2e5RabE/f4zNh7u7NIfGZVB+rwDEoLkEv/N0XP9d6b6A/N5jwBxC750I5H7eZrS/tXCiTTvt/HOPH4ZouF9sZFlbpaKiTnN/vnbf/rzAgcydSn5aRPYVtpXH+ydyZKkYOPPKNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XOXndb/e0ZkBy4LNF/NiNIQJiJfZJADopLl+0bDHkU=;
 b=jMlyio/bXw5EnPoGstRDSBkjhBpb7ni4Txhyr2asX0EGfT8IPPBRMEXDYBOc/b7yYJjwgIrvx8YMljUG1XPW4d1YEdipQ+tsbS8zopgDYBJfRFF9gm4A0W46LMbrgwa0mKsDmZ8TLHv7FDRZ99K06fJia+iELR+HGOksybWkOEU=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:25:25 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::25) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:25:23 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:25:20 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:25:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 01:25:20 -0500
Received: from a1257480.dhcp.ti.com (a1257480.dhcp.ti.com [172.24.231.175])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6616PA6M710280;
 Wed, 1 Jul 2026 01:25:17 -0500
From: Jaspinder Budhal <j-budhal@ti.com>
To: <ogabbay@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <j-budhal@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 1/2] Documentation: accel: Add NPAC client driver
 documentation
Date: Wed, 1 Jul 2026 11:55:04 +0530
Message-ID: <20260701062505.1091840-2-j-budhal@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701062505.1091840-1-j-budhal@ti.com>
References: <20260701062505.1091840-1-j-budhal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|BN0PR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: b40c4a78-2cd1-4e1e-6b14-08ded7398876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|13003099007|6133799003|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: qpPlI6zeEH8mzthKzZeGH68fIm3Pjg4OCkoRoZMmcnelJk9Kzl3iH+99cHR18WBd9IC6vxzno71BUsIH7XtQix9WZvIEeD8WXpD0djMi9hS85ESQkRkMbDQ6RRsWAPcMPg6gMq4MmIdSvEgNXwDzuD7AIx8RfM5ezLOBvxHw5ejZdq2GKwztPYqro+Nq6Nkx7jf05j32EaQa5uZaM5RmUQr+Yv8vDdq/rtai8KL9scBIOq/5ayQ2Pcfom9e/9oNMfUKhawRu8i7JZ5AGlWi7eJBXpnopbfszvCYYiUjWNuWiTmQq9Eo2vez0eR7gnTVwDFBCUbx5Xaw3QUd3C3K7zINbWkX86vFjEghStJz/Bp3pY9G0Z2e4n0qpVrJ+izf7JSJsDo9YtAvzcCBd0k8m9Wgpv5Ut0txMIZ3yb1/lRExli9wz7lpI3/cxn/PbrQkU8kvL3jjLMM8VZ0ZOip3MRpl0/GhdLOYZan7Cdi7nAq30Z6PwroaUWSjfsULI2zb8gwHZ9J/9NXTxBmP71jwEjFgZPsp4bmuA00sdOYYNEzeH86/lpKHBGTwnaTPF8GwTuGhwVXKxqOu+ePHZkKJZQgnlMztwf+0oVGcqLXNj8xIY+CrPRlaT6fK4rAzwwXo4f6cwDHc2y00HwA+A2xLfqw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(13003099007)(6133799003)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k2gbqyTlKx65xgkWF5ocggisnShd7D9FOQa9c9M5vQFm8jIiY6/r8cWd7pV68do1YyQ1/1tXeitZIBXTc+avZHNOTV+dc+Z82w2CCFg5peNPc1ubQOUOvm1CB3SCnsOFNOis+67v0HYDcJzys/EqDKXV58PwFYr+6PRs3quiT15Eypi6QmCF7OzXVABHDAo/Yrii5QDN/I50QNwyiHkh1Bc2LtiMMsg0aiafyd1xE2Sm6r/X4CHiwkL4BykSNyk3unLX1lUdgW9hUwEKH4cbnrquLXScYRHzw7f1IFUlb7AFjzwEQ9gOu6jwo1pncToBhsb4lpooV3H8nWljrA9ZRSusvM+xwyo4B/NMtPBwfMJz7grmCwN5sqmnsDISj3C9HM0HbMeKBXZtZebxE2lCThDUk0a1v1VdbXMhjt2/LSrtPmWNp3pHZlYq/YeYnTHE
X-Exchange-RoutingPolicyChecked: NGU7qh3nTNLSxYrGV4xpkhWja5YvQQziR1j/zkF+e2wqIbSbYyQTeO8OPytSCA+CYXY46Ak9KyQWOCJdZX47KP20wg1XlHLZv1R8fOKfVP0mbW1CY/kSxKfQKBA2jsMrO/25RQqgfjheMVWolcQpkWUaC5KvxkkyTQuw1bpCqpw9pt85de0EsZFNZ9V3aZ986IiYIDBLwxeH9B/iL+cq8yofegNxbpiKRLykE89zAu5fDgQaqKnFq17rhfeC0yZRIORgBo4rIFkM0saWO5FeneS9U/33tjTP9i/hLZmRjMJo5xRJ7E4pWetXSUh8N6Nmv1311ifAJC4d2t4mKMbYTw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:25:23.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c4a78-2cd1-4e1e-6b14-08ded7398876
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a44b2d9 cx=c_pps
 a=EUTAWq9+kh0QDJjqgNTvsw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=8pif782wAAAA:8
 a=23GqUWE8kzSqVje7P-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfX9DrmR65J/oVR
 F9IbDMy9wtMuB192WlfHrdhGbM9cE7ZDa+d2eJr0yv8NzCz4vnX0RT17gzPnzSr0i3TEMIju5/P
 byxDX93roGt1c5Ge5t7B4MBacIFDyXM=
X-Proofpoint-GUID: Sqyrz9BZ4v6QDAAD_Op7RS2TAHpeUWAk
X-Proofpoint-ORIG-GUID: Sqyrz9BZ4v6QDAAD_Op7RS2TAHpeUWAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfX5eZV17LIhGTI
 CCGOHYrfL6Iko7tdJi6Xk7wrSoLQbQv0VZxmY9wWfS6FCYFFuVlkoRUEoajMm1dz4/sqN3B0u5/
 jUM0tOcnY+Vdyax/b0F5XA0xFBt3fg8qMegL/HYgfgJNh1vKLK7jZ+Q88If978EzjclyxocB613
 xilSkazCiHTbez1GQe7vYgi6jt+B85Cq/rDhUN6/heUXhOATorVVMozTH/EMsrtIGKJCStG3JZN
 c+Bow/je0oBlk7g60QrAytUtdG+L+RSb4ry2V7DQLpsnGYFMsR7SPy2jv90ltWyQEHZwusgFMcs
 dGI6QUaZHpwEK4DqJwBpP/KLFEHXNvSlSJjz5+7UvDjk7SRQ0YXykwoMQEkRdt279X08ZkloDr+
 /QJgi27a2u0ZH9LDhs5F2g19kyCyvJR/GRxVzp8YORhUhsw4EXI/1gs+dBw9BEmse4wN6FjOY6E
 5vdZJ34/mf+x7EXysWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010064
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

NPAC (Network Packet ACcelerator) is a hardware accelerator present on
TI's TDA5 family of SoCs, designed to offload network packet processing
tasks from various hosts. It can be used to implement various packet
processing use cases such as ACL (Access Control List) rule enforcement,
reducing host CPU load.

This is an RFC patch for getting feedback on the initial implementation.

See the TDA54 SoC datasheet for hardware details:
https://www.ti.com/lit/ds/symlink/tda54-q1.pdf

Signed-off-by: Jaspinder Budhal <j-budhal@ti.com>
---
 Documentation/accel/npac.rst | 142 +++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/accel/npac.rst

diff --git a/Documentation/accel/npac.rst b/Documentation/accel/npac.rst
new file mode 100644
index 000000000000..fba6ddd0cfd2
--- /dev/null
+++ b/Documentation/accel/npac.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+====================================================
+Texas Instruments NPAC (Network Packet ACcelerator)
+====================================================
+
+Overview
+========
+
+NPAC (Network Packet ACcelerator) is a hardware accelerator available
+on Texas Instruments SoCs in the TDA5 family that provides network packet
+processing acceleration [0]_.
+
+The NPAC Host Driver runs on a dedicated remote processor and manages
+NPAC hardware.
+
+The NPAC client driver provides offloading support for ethernet-related tasks
+and communicates with the NPAC Host Driver over RPMsg (Remote Processor
+Messaging).
+
+The driver exposes /dev/accel/accel* as the userspace interface for accelerator
+configuration and management operations.
+
+The NPAC Host Driver supports ACL (Access Control
+List) [1]_ rule offload. ACL configuration requests are sent by the client
+driver to the NPAC Host Driver.
+
+Communication Model
+-------------------
+
+The NPAC client driver registers with the RPMsg subsystem during driver
+initialization.
+
+When the NPAC host driver announces the NPAC RPMsg service endpoint, the
+RPMsg core matches the announced service against the registered NPAC client
+driver and invokes the driver probe callback.
+
+Offload command received from userspace are formatted into RPMsgs and sent
+to the NPAC Host Driver.
+
+NPAC Host Driver responses are received through RPMsg callbacks.
+
+ACL Rule Offload
+----------------
+
+ACL (Access Control List) rules are packet filtering policies that define how
+network traffic should be handled — for example, dropping packets from a
+blacklisted source IP or allowing traffic only from trusted MAC addresses.
+
+In the standard Linux networking stack, ACL enforcement is handled in software
+by the netfilter subsystem. Each packet is inspected against the configured
+ruleset on the host CPU. On embedded SoCs in the TDA5 family such as TDA54,
+the per-packet overhead of software-based ACL enforcement accumulates under
+high traffic rates, increasing CPU utilization and reducing the processing
+capacity available for other system functions.
+
+The NPAC client driver offloads rules from Linux to NPAC hardware.
+Once a rule is programmed, matching packets are handled entirely by NPAC,
+reducing CPU load.
+
+For example, a rule to drop all packets from a specific source IP or to
+allow packets from a trusted source is offloaded to NPAC. Instead of the
+host parsing each packet and applying the ACL rules, NPAC enforces the
+rule directly in hardware.
+
+Userspace Interface
+-------------------
+
+The driver exposes /dev/accel/accel* as the userspace control interface for ACL
+rule management operations.
+
+The interface uses IOCTL-based request handling for accelerator configuration
+and rule management operations.
+
+IOCTL Commands
+~~~~~~~~~~~~~~
+
+DRM_IOCTL_NPAC_ACL_ADD_RULE
+
+  This IOCTL allows userspace to add an ACL rule to the accelerator. The
+  call will forward the rule to the NPAC host driver for hardware programming.
+  The NPAC Host Driver is responsible for validating the rule and applying it to
+  the NPAC hardware.
+
+DRM_IOCTL_NPAC_ACL_DELETE_RULE
+
+  This IOCTL allows userspace to remove an ACL rule from the accelerator.
+  The call will forward the deletion request to the NPAC host driver, which
+  will remove the rule from the NPAC hardware.
+
+Driver Lifecycle
+----------------
+
+The driver lifecycle is coordinated through the RPMsg framework.
+
+Probe Flow
+~~~~~~~~~~
+
+1. The NPAC client driver registers with the RPMsg subsystem
+
+2. NPAC host driver initializes on the remote processor
+
+3. NPAC Host Driver announces its RPMsg service endpoint
+
+4. The RPMsg subsystem in Linux matches the announced service against
+   the registered NPAC client driver
+
+5. The RPMsg subsystem invokes the driver probe callback
+
+6. Driver communication resources are initialized
+
+7. /dev/accel/accel* becomes available to userspace
+
+Request Flow
+~~~~~~~~~~~~
+
+1. Userspace submits an ACL configuration request through /dev/accel/accel*
+
+2. The request is forwarded to the NPAC host driver using RPMsg
+
+3. The NPAC Host Driver validates the request and performs the required hardware
+   programming operations
+
+4. NPAC Host Driver responses are received by the Linux driver through the RPMsg
+   callback.
+
+RPMsg Integration
+-----------------
+
+The driver integrates with the Linux RPMsg subsystem for communication with
+the NPAC host driver processor.
+
+RPMsg is used as the transport mechanism for:
+
+- Accelerator configuration requests
+- NPAC Host Driver responses
+
+References
+----------
+
+.. [0] https://www.ti.com/lit/ds/symlink/tda54-q1.pdf
+.. [1] https://en.wikipedia.org/wiki/Access-control_list#Networking_ACLs
-- 
2.34.1

