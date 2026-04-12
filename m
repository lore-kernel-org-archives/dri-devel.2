Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9858DE937E4
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49C010E2C8;
	Sun, 12 Apr 2026 14:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pp25f2gw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pp25f2gw";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011015.outbound.protection.outlook.com
 [40.107.130.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FCA10E04D
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PTNdyDxO1z5mTAYS7m3bHb9B/CaO143T6t6TqblyUjOwGfwAYYzoK1phtp1zu8L0ABCwaFLjB/3zFCwGbmZfxT62TRZAYXBACaIMdF2EzvHkffF4edJNz7rlGe3CtloqfBSVN9++qNTithVL0FnFh/yLPrT804XeCsuunMEuNCAH4dSV4V8P/57ZNsZP/IB5s6CVs90AZEgfFa/9HUbIX/Gv2/fB9LP9zLAsiIDo+jVbh1vvlsxs+TJl+dT/yXweZd49eIc3/VWkzQml6QmKIPg1cCEU3qdB4ARPEtSuhLtfpf4+ofgdh1wqr+v5uFBfHuzYjPEZoLg+pt2U8NKfZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKDTargh9ZvijKK6q2p02Rx59IbbdRnpgahdNSqHF4A=;
 b=JZ7VM2Rmvu8USPdP1ATodO1OhZZIhR2xrOPTf4k12PT9en2R7Rqk5ynaoSdslEPIfgEkVUCBQlQwLW/bCMtrKjAVOm4Kcdw90v4aSZsvW9AH5nlrqr0Qkx1cqf75+6YBkZD+4z6Cr1MLXuQxYTvBH61VCEFAgAqU6TAHnlyi3a9Mwu7VSQNs4ULS7kQBhldpE/nUOdJvtOBykrjsUeD+B/ox/TirxmvP3J3NeNmmRwPC84DqRP3jJ/E1vPXqDetUJQAMgCHLEB+JLIrutzSvknYg7cZ4t/sez2JcDnvEAit/yGKKN76FBnc/qKj86STSkpZe/nERHQXIJ9Rno3hk2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKDTargh9ZvijKK6q2p02Rx59IbbdRnpgahdNSqHF4A=;
 b=pp25f2gwUmW9a0lPJpkiB0lhaFReZYEuR7dfRl/l9o7E31LElIfnhH3yP/l6O+WpCyHtUP2XTNLqbmbhJw9RaPQxl03UhPWsN8AZr5PDLV+grugoDmoA2oiZ5aVl0uF2fryB+92+owrNzf8uzk+GWKgHXS22+1e5QAjR+7Q3rkw=
Received: from DB3PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:8:1::15) by
 AM0PR08MB5490.eurprd08.prod.outlook.com (2603:10a6:208:184::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:31:06 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::9a) by DB3PR06CA0002.outlook.office365.com
 (2603:10a6:8:1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sun,
 12 Apr 2026 14:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Sun, 12 Apr 2026 14:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxd7E7U2OyWlWiZj7u+igVeHPVDxKqXUHpSbb00okBzKjXnrHT9lmAODgGroa6NrKANWTY6iJe90p+c93Oqxn8ujoF1Lxsu6TRgTidykRqzG+r4vCwZL6sMcx08dTASn3Skb/klvf8CyP4lCY62CkV3dtREHeIY4nHL/6bQxLkLYasY/YaICMZ65abSrRxr7riQJi13+CJbSBgIMKZaMFyt72OoMHyKDKMG4BIVJL9dtPtxp021AsexxfaM1yCGANFDqOKlfbbHNQxtm5AyAJrtZSkvkz+3pTt6i8Jb2jcuTiEPbgrUj/9myFLkPiHDIPjfd30DA2lMIHBoNntIx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKDTargh9ZvijKK6q2p02Rx59IbbdRnpgahdNSqHF4A=;
 b=ynADDKozw1TMJ2qEvcPkXr+X/JlvqDPPNycmh8aFHfDfGQIqGvvLJYbKryX1LBw7n947jy9zuYlUWKAjckuzcTWSXPzwel7OhIoV8Ixi634bPjrIX7s9ZF5GowMKWVEN6fkm1h7/bl0eZLdfc/4luMt5iw7mWds/RQKNgutVKfl7Lihj9cpVnK9X4nGA+6AHDT3PgE/O8JKzPScKywyPDgmKaikSKYm/Cd5jUl5M9JF/adeOJ4A1sL6Lu+DnLsbJJE+GTOf3vWfzFDXXVQCVc1PiUaV3p5zHeEiA6pxRDY12obmN+ZdAV/uviIhzrzm2J00yo6pgWbWzwbpHuY94fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKDTargh9ZvijKK6q2p02Rx59IbbdRnpgahdNSqHF4A=;
 b=pp25f2gwUmW9a0lPJpkiB0lhaFReZYEuR7dfRl/l9o7E31LElIfnhH3yP/l6O+WpCyHtUP2XTNLqbmbhJw9RaPQxl03UhPWsN8AZr5PDLV+grugoDmoA2oiZ5aVl0uF2fryB+92+owrNzf8uzk+GWKgHXS22+1e5QAjR+7Q3rkw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:03 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:03 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] drm/panthor: Store IRQ register base iomem pointer in
 panthor_irq
Date: Sun, 12 Apr 2026 15:29:47 +0100
Message-ID: <20260412142951.2309135-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|DB5PEPF00014B9E:EE_|AM0PR08MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ec16de-b801-4893-c4f2-08de98a021de
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: +S0Pj2VP/AE92ARekuvdRD5OHMUbYPYYqXDB463dPWKTCZ4ahgn6l4BBtXBTUPNJDsDbw2z5+0UbKBw1ZecrGNuMlGwP8vJ1cqeQmblCvWlm74cR4DM2V/oSVkCv/wxpXFkkBj1O0s7RkZ19s8h1nnYpsv/UMUFET/dqqAMSrSB5JrJ5VjAYwJ88JOoA2F3KGkg7aooI1sApMNTyLkCS4bz9U+AJFmMqMUzeAIZjwyLfpjSlvHtYz8YD1b0gMmaelUUWIiRqK5ZxzxhXx3lAFNLlAEObe/ydFv8/uLyeK4qlX7xYz8ZwcHNEvgmqwaHEMicWUs1AsqHk7joWiBTqBzrOGu7jX7dLz/OeJ4+41ChaL2pqS4dgPjwb766qpd37iYruONCH4wfbSnaC9JBLM4RD4wmIj+7SdkJ0ecWfAJba3cHTJTwlRq8tjKVerG+x+FTvzvkYSGCvjbbStK1jAGu72PYLehnjmnJc8c4j1YZg47mOjwk+8D6E3JQb6QewymWJtQXlCdVYRJcL0Bdn64/pH/RUdbK3O+TJJfOTDd5OwRogFvlfMH5McnVJo9xscxerCN6xM35rr7rkhF+lOT84g/h+Ya/hi6Os+8kve9jdqWndLADN+QhRyoTf4iVg3yM/MrMsGUuj1izKeO6w1ZAkuaVK8sBVaKdC1ngszjxJ87cE8V1PHXAaZJRoUPDJZLVlaq0jwoiqW0gXqR7e7iaLwdVKfxgzCFLg25G0r90=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aPQZH2LaplHTqYUaoZxA/2Jm6IZX30dNfkwDqQ7sZpG0oewF8C5bjO3g0fvxB5i9XFTUes3ysLRYsNITU/uJlKCGuse1Sy444pPyHiAbqKkYjt9zoFspQDQyGfiKpuiAb13a8L4DN4YX7m6wp+e1udKS3txBHilKFmT+VB1Llei6dsxnPPCjgGfL2ox9zwH1thUEHwsDBYP0Nuzv9X/xYLKvz2hTuoIG45Mw9LfYpCU7xUDu3ASCpnzazJHOsW/I6lAToLEyZwRSY4ycZDNcqdDwpswMMZPHj7wcdF/w7MnYkyH3cNthHl1ip1JMzRc/JZy2v5jZ2+smXs1S5HBR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10905d3d-63d3-43b3-48cc-08de989ffc84
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|14060799003|35042699022|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CQ3cs8jNAR8A1eEpPS3kS12/MDDY9nJ/rHsPrvwOiQxDeEZrbLHh2CwvNhv78LjIN+kNVo7a46UApIYf7gpygEfwR/8MHKHBXY9+jWQjPVPKf+nb6k+mprN1pAFgq9FLf1AbKXhFsbAkXOuiAeFi9m6CGlZ5yfVDqzVixUQYe9khMQcXYgUXPBEBMF8BOwDeDhVNd13DX4y5Fqpj+Zl53yAq1nIHU8oYcTkwM8CXDAdhmCBLIiPRzwctrrXvNuiTgWNoC7XyJMuruHeThR7DcUcemcuQDMNkJb3i1kX9J3XHXfLJOveqZEBntHV+JaqtUfxANQFnRT7IgrKSENaFQtN2pbutJi6wLvVRNpGHYZT+G2tvMBInzu8lbnirXaiMDMTmsy7JX9L6E4iRJMeS2fhoZUpE1UGSfKb1MCJrxy/goTqTMLvjUXsWZvZ5kT9yUSmf4JG/y2iq+te+Rp8q7Ql0IGB5zW+pHjenJVM1IL1i+LD/YbPtOC/xHTGH8HFH8HHDRWTTAbXocLBglQd0GHKoNmPPOXo9c/PLg94owUeSI06UN/MDYv5nVa3rAhYmDAlFnCIhfk/+2Lv52efG1dNJiwdAaBA41KH3Ci2CksmCUwVtD4NNT/9bOrztjHCI1g5fN9y1rJMme/AfC9j0QjVzqDaZY33NxpXXBOUct+qsp5rrBfRNYGJTV/oDAsojzxjnslwbzQCYDS2lqzrqbJ2mYn/SY4bjSrUReA5HDUJi5m1bLsOP0M99qMO4ZRkBMbyoSwfS23W8jsgQVF7zuA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(14060799003)(35042699022)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bEq7U94HFiW0azhOjIOn7HrsUjbnoj3Cd9hxqf9A9hzs0+3V7iBnBcbNdzrnVHVTvE0bS4dKmzL9QABM8lhXocfaGwRhTxhkinadIas/V+nb2qZW+N60SiBuZoryEcoR6v26aIu4zZcPar2+9YJ11g3ufX0wQv5Ca/WmgPRhGNj/3xNVDn1jHSCfChKs0rtRDXXLMRUZfxQcNU0ZIWVFFom+MTC4uC1fHxrYvb0oJPhnZaF5BkNKUDxEPZOw1vzD85DMEc9c+Qto1tz60SkfsYVN3y/8H69H2B5SETGeMRTLZ7eVMBcsdKTIl7U/Ec3MYMcJ0eS09xb5yt/cS/ylT4qdnNrke4wwiKE9ybTd/AFae0BRop7iWZ2m3J/LvUU+snwm62qjviDw4NYj+EvSPa9OFZV4lUdW/+FPjuVcD7R+jq7Bh9/lOKg7J2pI2XbX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:06.2546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ec16de-b801-4893-c4f2-08de98a021de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5490
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

Update common IRQ handling code to work from an IRQ-local iomem base
instead of referencing block-specific interrupt register offsets.

Store the interrupt base address iomem pointer in struct panthor_irq and
switch the shared IRQ helpers to use generic INT_* offsets from that
local base. This removes the need for each caller to expose absolute IRQ
register addresses while keeping the common IRQ flow unchanged.

No functional change intended.

v2:
- Change IRQ request function to accept an iomem pointer instead of
  computing it from an offset argument.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
 drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
 drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
 8 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 285bf7e4439e..4e4607bca7cc 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -82,6 +82,9 @@ struct panthor_irq {
 	/** @ptdev: Panthor device */
 	struct panthor_device *ptdev;
 
+	/** @iomem: CPU mapping of IRQ base address */
+	void __iomem *iomem;
+
 	/** @irq: IRQ number. */
 	int irq;
 
@@ -488,6 +491,11 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
+#define INT_RAWSTAT 0x0
+#define INT_CLEAR   0x4
+#define INT_MASK    0x8
+#define INT_STAT    0xc
+
 /**
  * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
  * registration function.
@@ -498,14 +506,13 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
  *
  * void (*handler)(struct panthor_device *, u32 status);
  */
-#define PANTHOR_IRQ_HANDLER(__name, __reg_prefix, __handler)					\
+#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
 static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
 {												\
 	struct panthor_irq *pirq = data;							\
-	struct panthor_device *ptdev = pirq->ptdev;						\
 	enum panthor_irq_state old_state;							\
 												\
-	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
+	if (!gpu_read(pirq->iomem, INT_STAT))							\
 		return IRQ_NONE;								\
 												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
@@ -515,7 +522,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
-	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
+	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
 												\
@@ -534,7 +541,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
 		 * covered for.									\
 		 */										\
-		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
+		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
 												\
 		if (!status)									\
 			break;									\
@@ -550,7 +557,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 					   PANTHOR_IRQ_STATE_PROCESSING,			\
 					   PANTHOR_IRQ_STATE_ACTIVE);				\
 		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
-			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
 	}											\
 												\
 	return ret;										\
@@ -560,7 +567,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 {												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
 		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
+		gpu_write(pirq->iomem, INT_MASK, 0);						\
 	}											\
 	synchronize_irq(pirq->irq);								\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
@@ -571,17 +578,18 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 												\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
+	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
 }												\
 												\
 static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 					      struct panthor_irq *pirq,				\
-					      int irq, u32 mask)				\
+					      int irq, u32 mask, void __iomem *iomem)		\
 {												\
 	pirq->ptdev = ptdev;									\
 	pirq->irq = irq;									\
 	pirq->mask = mask;									\
+	pirq->iomem = iomem;									\
 	spin_lock_init(&pirq->mask_lock);							\
 	panthor_ ## __name ## _irq_resume(pirq);						\
 												\
@@ -603,7 +611,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
@@ -617,7 +625,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 
 extern struct workqueue_struct *panthor_cleanup_wq;
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4a0c23e987b6..73ef07a37e22 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1088,7 +1088,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 		trace_gpu_job_irq(ptdev->base.dev, status, duration);
 	}
 }
-PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
+PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
@@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (irq <= 0)
 		return -ENODEV;
 
-	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
+	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
+				      ptdev->iomem + JOB_INT_BASE);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index d523d41e18dd..eeb41aff249b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -15,6 +15,8 @@
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
+#define JOB_INT_BASE					0x1000
+
 #define JOB_INT_RAWSTAT					0x1000
 #define JOB_INT_CLEAR					0x1004
 #define JOB_INT_MASK					0x1008
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 747ac332be64..f00f3d9be240 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -110,7 +110,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->gpu->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
+PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
 
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
@@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
+	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
+				      GPU_INTERRUPTS_MASK,
+				      ptdev->iomem + GPU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 75474b7d7341..3f60c45985a7 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,6 +4,8 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
+#define GPU_CONTROL_BASE				0x0
+
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
@@ -28,6 +30,7 @@
 #define GPU_AS_PRESENT					0x18
 #define GPU_CSF_ID					0x1C
 
+#define GPU_INT_BASE					0x20
 #define GPU_INT_RAWSTAT					0x20
 #define GPU_INT_CLEAR					0x24
 #define GPU_INT_MASK					0x28
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b9f6031e24a4..501dc0ea3ae7 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -584,7 +584,7 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
 
 /* Forward declaration to call helpers within as_enable/disable */
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
-PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
+PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
@@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		return -ENODEV;
 
 	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
-				      panthor_mmu_fault_mask(ptdev, ~0));
+				      panthor_mmu_fault_mask(ptdev, ~0),
+				      ptdev->iomem + MMU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index cc9cf603cec6..de460042651d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -5,6 +5,9 @@
 #define __PANTHOR_MMU_REGS_H__
 
 /* MMU regs */
+
+#define MMU_INT_BASE					0x2000
+
 #define MMU_INT_RAWSTAT					0x2000
 #define MMU_INT_CLEAR					0x2004
 #define MMU_INT_MASK					0x2008
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index aafb0c5c7d23..11c43de1ddd5 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->pwr->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
+PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
 
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
@@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
+	err = panthor_request_pwr_irq(
+		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
+		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);
 	if (err)
 		return err;
 
-- 
2.43.0

