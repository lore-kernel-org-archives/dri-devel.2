Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689DBC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73AF10EB92;
	Tue, 22 Sep 2026 20:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="q2/s6ufO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q2/s6ufO";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013059.outbound.protection.outlook.com
 [40.107.162.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E2810EB92
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UHEnbistQpyMKghEeVCKRnuaFh7Y0YnxSRf3PNhlmypY8et9skr24uYaV+7uyyB+LMnLL8ywbVl7SgR/2lXINz98hin7EcYvgX4+Kv1mlWPtjddhdGUr6pehbZMVG1SAqLrjvfdzpqUcwln4Uzep6ZlYPQxc9BSGtpcmdI+7AapVUUivBtjUCEku5Y/MNtoKCqmaA3aojb+rxaJH8gOWi701/RuZEmWo+TrrzqdVE7TgmJdVn3ZQt9VqOVREzP5ktSMoabdPQM4rRgmqdGg52X3s8M+r01qBrJ/H8MRhAAP3UVXAwWgfmqIU174iLZtKcST55dOC2Ikk8GoE4N4v5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgYLdhxSNAUXmnGRjlvqE1NRyFA10B/pIWB3noQBNC8=;
 b=cNrUcz6ZuYYHncF/szs73ppauOoCEk3gOt2r8AC2mcCaPGWbv63NkHaSrK341qfG4WesRwXS35x4Fwe0zs5+hrqYXdA6D3zHWSlQSXF0uEQxlHRFFR045Joux0a8j4ZKL6rJdgqWImW1V0pYn7Q/Pm+904FzqOI9cPvhBm6os4vSFXdNenr98trMvProk2O4GQOXehhVeY7TdIIpAH+OZWg/hiP5yQ4h1NPH2WIrKohMyHq7khNcQx5Y/HZjCrwKMiPGatr2jp8KAiZg+nk+xSna9nYr0Xo+r1f5hJBd8cueT55p2imQFZLWEWg9F/J//UL5oQOXCY4G7djQ6lz8jg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgYLdhxSNAUXmnGRjlvqE1NRyFA10B/pIWB3noQBNC8=;
 b=q2/s6ufOryfYg/1JDq7TcuZjmawaGuhUz7MT+jbV576ygg4l2UaKmg1juWRH0UlnxJsJyrcTZRmblx9THObuGMF/rgB+JizZSJmy9TEgOtaoG8TKySu+AU97/AXvg3oT1WdHou91mLxq/dXvFWp18ZVQMJj0aDdASX2B0TkUobQ=
Received: from DUZPR01CA0279.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::28) by PA4PR08MB6253.eurprd08.prod.outlook.com
 (2603:10a6:102:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:30 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::36) by DUZPR01CA0279.outlook.office365.com
 (2603:10a6:10:4b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 22 Sep 2026 20:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLR09FFhxuL97frqwg7hdSjoOJjuTBnrSSIFAdNk7k9C+hINXTOoPh8Omn1u2OIi0Sy++TFZn4Tr2ohH+LivOCBhw1yT0Mzh+E7ccu3UquySwLfLllfwhjVZzXan2jPTjtjHWFILbhx2njIK3K6xsteeBXSi1XpP8VC8JOrL1bVhUokAfxMuYg+3wWw49E20WyidDpqQ0zPKTPhTo5R5ot9qhcrXUrdKZL/6GuIxukCHXxw/XKKz5OBEtk6cZtClJMAWq1hfI/06dvaqWzKhwG8EutOmJYLGTtJAMi9LCnxeR9+YYGDkl+/FChCsKMIvBsIM1VCdAQHUTuKNo9bpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgYLdhxSNAUXmnGRjlvqE1NRyFA10B/pIWB3noQBNC8=;
 b=oY9Eh0LIYUZ1MsJ6jyUouaeOQ5NR3WKNl19l/B19cWwl73S3J9iJcLdPKmXuAFwq9NDcyrVNMF+Sgr94XzQtzv22PzLgB4G6hLzIaGAxX9V8bJ4gt0R7xJ6BbdwJS4c1cWo23Z0AcfT5t5M8CMc9vtrjdYpR7uQPud0xS0m9+lTdMJd348otqd51lfOlwa6wtzanhAp/mtSCKFtxShRkZFr2HQrIqPnkdndtzxOCFZzqliXooPhlumGc+HodXet/CRaLJVLN3J3bBDcNJyfzORT3gkSDrbU5now48dX9BolSbISOvcDP58G6js8SOC+JeuAsdhFgnsnv/dCaVkeQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgYLdhxSNAUXmnGRjlvqE1NRyFA10B/pIWB3noQBNC8=;
 b=q2/s6ufOryfYg/1JDq7TcuZjmawaGuhUz7MT+jbV576ygg4l2UaKmg1juWRH0UlnxJsJyrcTZRmblx9THObuGMF/rgB+JizZSJmy9TEgOtaoG8TKySu+AU97/AXvg3oT1WdHou91mLxq/dXvFWp18ZVQMJj0aDdASX2B0TkUobQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:58 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:57 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 14/27] drm/panthor: Add AM message helpers
Date: Tue, 22 Sep 2026 21:45:08 +0100
Message-ID: <20260922204535.2850094-15-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|DU2PEPF00028D01:EE_|PA4PR08MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e5ea2b-bd2e-49a2-4633-08df18eab814
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: FBH+WEctHoDEEgv0DGIj1FOLAjz042nEisJqqGAmZX2Bk12L/wcPBK/DTH+zvtYt3uenYfG6aA0QOvnATgQhYtJRd42vh9ZkRpGN/1uF3TM3OCFDmTZ3OQCQxmnDMO25k1IP8asQSHv12EXjMvnlENPNkk1oqR1vktsispmnyTuvot8bMqoM2ccU9x96/UDTqpSwhCbcXAJGgm/anm/Vm/4oZjr3Hr/PSz3oQHTXH/n6d1ERdG7hWdH6jC+ctzRkEm2cFP0TKXF7ZObevrGW6AxblykGpqaUFinma0lOFZbfQAIqlsuP7g6qrGTqYnd95qXr0Sfu+j9ctUpTN6Z8mHJ8v2RHDLTGRGRqcmr9PlLxlXqV7Z9uLNDbIdQ3vQoAeRF9yv1qsge6Y80qn+YAEO/8QR/7iPr8MQukp2POuseM5hqJB+TK3m8fqA29fiBoK72L1mvLCGi8BJdnWrCz4r7b8iDVu9yOmbv/QAIwH3QL0wOdQvvK60t1p6u6iUI9v/WIPNuN9fO7eN2LD5sMm0WyOIEeHJKNJxFe5fNc9UwihlL23u7Ca8o8rS1G01PDRbrRiwEAtnbTTydaySvXvWNOLtvE1y91hiwG2P1b8izSCVwEbKEgvRYE5Vw9Qad35rv2eDjwRKSBeGLJZJyzDmTsam1ZYf47lZQazjupxw0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Gf5/Lc3RQJYB7ewKX2+hILUn5kw/iZf5lj7Mwl5sL95eh8O8bdE5gvw9o2oxjAH6Huu0iYgd/Aj2uYLhoQOpunNO7Ik0eNCpsF+kLVj7fDP6qfLsObAfnorZ8SOApRkSeV0Jb7zvVWm5Q/zZ4PEXeZZLRGwo/8qxlUdS975pY/hJ9Wd1+HVY5Z2E70sDF769e6N0wxlubCic81bOHfZrqZP5ZuL2btwLfKZmJ/YbmodkwESLTlnOelpka2anDMriEzBnihLynx4euFiqJsVuaqh4TIM4oS8TWyiDn6VhM/gNxYGDGZuFrOuy//5RoT1jThJQUOVNe2tJvdUwqiy61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 000fa311-be3c-4852-32ad-08df18eaa4dd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|14060799003|36860700016|35042699022|1800799024|10067099003|11063799006|5023799004|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: VlMeWd4BakgCSQCu1lfMAuIPaQYKT1Y4M3Qs8ispTAKVGuxQHMLg+SVPaDuoYQSfnTEMgVGXYd5groLLB5kNZZrK8Yo223lXwSFkK2r6Np72vsmNJ/WjN0rK3sl7y59gjD46IRoOm4l1Wlchnsjda1NsBwFfqKLBY7KRxIQXQLQG/ospS23ezPkb3R1at7Luagim23p8pRzPwJ3Z9qOh1T392gtqYTwP6qaAYZ1a2EyfcApX8z0iT4y7b1aSNBiuOr/lj+HZIYHWmxANSHs8y4Z+Ov4WszCqVXiT0xgrozby2s2kM14+Q893agR+oxMHJLwCcO3QzCb7Y+gNO8BOfx0QwqjpEimWTTauhnYpd8KYcXA7QdC2fP2tEQ+wX1uA7rj1z8JX0cley0onfvAyB4/b294JKIio1Ky77dH74Zq8OLHa0DpfhyGe+/urZc5Va8JDJQkYmNIqq4n0Xj8q233yvG60nuayxtZhGEUk7NF3fB3hp8sXu1J8zDAQTuVhMX0UQj2TXRkjQTR8NcpxFC3Sq1XjxOY1EyWl9WRF7vQDMbAkYvMmvsz7bTbmLtAlVHR5FNskwMfeDpYefbsDcfbO98gJHnSckGGETD/I05IrzW1TlsUVGsQTz6ZP5IXC9v7uuuk1NSvmhj06VaRN9F2VqNHKopswhH6V8xXe16spY3/bbn5h2WlU2fihUwDbtHRpm0ziJjsm2Jg9SebDnQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(14060799003)(36860700016)(35042699022)(1800799024)(10067099003)(11063799006)(5023799004)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gy2qGMwaWMaw/KvH0ds40nzmlgl9chqkhnedDhLZAxIPLMTWD9HfZBdVw7V7DfcVMOqbEsLWFc1voFrGuwCZIpaf619wBN0Aq1bh11iNWzCKdBMt4pz+CjLbdeNHTWkBWYbXS/SQxGUUq3TZe1pX41GFMY+Vul1looXtaCwYWY6/GvIPmpvYItM9Jf4B24R5DyAztGVWvrHZO6feApLY663L2wVNnD9ZFQNa1VqTuMYT/4T95jJyn0bGMVadwkILCDIGBSSQqVNCoY78AVAGrEjaVMvWlHUD6fLsvbK6ahudcnkpx7HDtasR4+niYJeELcvbHjTBTUI1OpmPSeStN7U/LPUCdDiWjyQowfzKLtmIS7rvNBlQmK7bjs9SkqtyiZL08/bLbvrLNkNOYythEiIwsQqcyLcXMPI2Vm0GgwxdDfMpgbAp1AKMzs9V2wYG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:29.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e5ea2b-bd2e-49a2-4633-08df18eab814
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6253
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

Add a shared helper layer for the AM_MESSAGE registers used by v15 GPUs
to coordinate between access windows to enable virtualisation of the
GPU.

The helper defines message IDs, register accessors, version negotiation,
and FIFO-backed sending. Outgoing messages are serialized with a
spinlock, written in the required register order, and queued for later
retry when the hardware outgoing slot is busy.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Raises minimum/current protocol support to v2. (v1 was for G78AE)
- Removes ARB_VM_GPU_STOP.
- Return -ENOSPC instead of -ENOMEM on full outgoing FIFO.

 drivers/gpu/drm/panthor/panthor_am_msg.h | 159 +++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h

diff --git a/drivers/gpu/drm/panthor/panthor_am_msg.h b/drivers/gpu/drm/panthor/panthor_am_msg.h
new file mode 100644
index 0000000000000..fc1e3f1051fe5
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_am_msg.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AM_H__
+#define __PANTHOR_AM_H__
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/kfifo.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+/* Protocol versioning */
+#define ARB_VM_PROTOCOL_V1			0x1
+#define ARB_VM_PROTOCOL_V2			0x2
+
+#define AM_MSG_MIN_SUPPORTED_VERSION		ARB_VM_PROTOCOL_V2
+#define AM_MSG_CURRENT_VERSION			ARB_VM_PROTOCOL_V2
+
+#define AM_INCOMING_MESSAGE0			0x0
+#define AM_INCOMING_MESSAGE1			0x4
+#define AM_OUTGOING_MESSAGE_STATUS		0x8
+#define AM_OUTGOING_MESSAGE0			0xc
+#define AM_OUTGOING_MESSAGE1			0x10
+
+/* Arbiter to VM message IDs */
+#define ARB_VM_INIT				0x04
+
+/* VM to Arbiter message IDs */
+#define VM_ARB_INIT				0x05
+#define VM_ARB_GPU_REQUEST			0x08
+#define VM_ARB_GPU_STOPPED			0x09
+
+#define AM_MSG_ID_MASK				GENMASK(7, 0)
+#define AM_MSG_ACK_MASK				BIT(8)
+#define AM_MSG_VERSION_MASK			GENMASK(15, 9)
+
+#define AM_MSG_ID_GET(x)			FIELD_GET(AM_MSG_ID_MASK, x)
+#define AM_MSG_ACK_GET(x)			FIELD_GET(AM_MSG_ACK_MASK, x)
+#define AM_MSG_VERSION_GET(x)			FIELD_GET(AM_MSG_VERSION_MASK, x)
+
+#define AM_MSG_INIT_MAKE(_id, _ack, _version) \
+	((_id) | FIELD_PREP(AM_MSG_ACK_MASK, _ack) | FIELD_PREP(AM_MSG_VERSION_MASK, _version))
+
+#define ARB_VM_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(ARB_VM_INIT, _ack, _version)
+#define VM_ARB_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(VM_ARB_INIT, _ack, _version)
+
+#define AM_MSG_DEFAULT_FIFO_SIZE		4
+
+struct panthor_am_msg {
+	/** @iomem: CPU mapping of the AM_MESSAGE registers */
+	void __iomem *iomem;
+
+	/** @lock: Lock for send_fifo and outgoing message register */
+	spinlock_t lock;
+
+	/** @send_fifo: FIFO to queue of messages to send */
+	DECLARE_KFIFO(send_fifo, u64, AM_MSG_DEFAULT_FIFO_SIZE);
+
+	/** @version: Protocol version */
+	u8 version;
+};
+
+static inline void panthor_am_msg_init(struct panthor_am_msg *msg,
+				       void __iomem *iomem)
+{
+	spin_lock_init(&msg->lock);
+	INIT_KFIFO(msg->send_fifo);
+	msg->iomem = iomem;
+}
+
+static inline bool panthor_am_msg_pending(struct panthor_am_msg *msg)
+{
+	return !!gpu_read(msg->iomem, AM_OUTGOING_MESSAGE_STATUS);
+}
+
+static inline u64 panthor_am_msg_read(struct panthor_am_msg *msg)
+{
+	return gpu_read64(msg->iomem, AM_INCOMING_MESSAGE0);
+}
+
+static inline void panthor_am_msg_write(struct panthor_am_msg *msg, u64 message)
+{
+	lockdep_assert_held(&msg->lock);
+
+	/*
+	 * Registers must be written in this exact order to prevent interrupts
+	 * being raised before the complete message is written.
+	 */
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE0, lower_32_bits(message));
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE1, upper_32_bits(message));
+}
+
+static inline int panthor_am_msg_retry(struct panthor_am_msg *msg)
+{
+	u64 message;
+
+	guard(spinlock_irqsave)(&msg->lock);
+
+	if (kfifo_is_empty(&msg->send_fifo))
+		return 0;
+
+	if (panthor_am_msg_pending(msg))
+		return -EBUSY;
+
+	/* FIFO should never be empty at this point */
+	if (!kfifo_get(&msg->send_fifo, &message))
+		return -EINVAL;
+
+	panthor_am_msg_write(msg, message);
+
+	/* There are still messages in the FIFO, notify caller to retry again */
+	if (!kfifo_is_empty(&msg->send_fifo))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static inline int panthor_am_msg_send(struct panthor_am_msg *msg, u64 message)
+{
+	guard(spinlock_irqsave)(&msg->lock);
+
+	/*
+	 * If there already is a pending message in the FIFO or the outgoing
+	 * message is still not read by the receipient, add to the FIFO.
+	 */
+	if (!kfifo_is_empty(&msg->send_fifo) || panthor_am_msg_pending(msg)) {
+		if (!kfifo_put(&msg->send_fifo, message))
+			return -ENOSPC;
+
+		/*
+		 * return -EBUSY to indicate to the caller to schedule work to
+		 * retry sending messages in the FIFO.
+		 */
+		return -EBUSY;
+	}
+
+	/* We are free to write to AM_OUTGOING_MESSAGE */
+	panthor_am_msg_write(msg, message);
+
+	return 0;
+}
+
+static inline int panthor_am_msg_version_validate(struct panthor_am_msg *msg,
+						  u8 version)
+{
+	if (version < AM_MSG_MIN_SUPPORTED_VERSION) {
+		msg->version = AM_MSG_MIN_SUPPORTED_VERSION;
+		return -EOPNOTSUPP;
+	}
+
+	msg->version = min(version, AM_MSG_CURRENT_VERSION);
+
+	return 0;
+}
+
+#endif
-- 
2.43.0

