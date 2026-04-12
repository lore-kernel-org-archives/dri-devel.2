Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFC4E937E3
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E9710E032;
	Sun, 12 Apr 2026 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qta/eemV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qta/eemV";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013052.outbound.protection.outlook.com
 [52.101.83.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E68E10E2CC
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=azAGPQnhsYdNN7tKS1II/ZuJvbp8bQoTfyIq50sgCQzuIOOCkGqtPXuud77r5P8puDuVRDI4vkMJfcPryImCzhfYYlM1Zifese+MqDB2vz3t3rKPtkVWZOp2/Nfz1DnDItCbSGAyWqdeO+eCFkF4S/06+3ekujkUuNjcoDiqWnC3WMIE/meFLBkGl1vBNfVfopSzOtLqpcIAnnPwijUrQS43MgPTypb2lay41B1vvgY6gu7kWWfMUVIPLcfe66igjc4c+B+y8D1pjF39Atgumdh2r1BnyiFUWHdYUZR74N7PnBdPl0EaCm+0bhny6vrrOP5tSPWUg6ehVnqLycWLKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+0s+iiVfUoRRteHbA04kL/Ap401TRj8edi3l58wzlk=;
 b=W5Oc5g0ti6d5Uue+WOomiatX7FbPr5aoC+pvWKHJ46jg6LEsMQDor2fKeb0pKCzVUpHSnRQuq05cBhajmpnfXMU1fa40bFMSUB3ky0fAviqKTWGPK70ALeRBZpEQGhijg8CnYEqZU+27gstMk7VAGgy7yadCtolMeTq7zNess8QeeJp3UvBNT+WdjvDfLE8JbyRFrktRRqB655gYhkZc40POgVIUhfv9pHC4sovc5XmM+E16JqJznOajxKvh5+tkRqBfNEGbYcdxOD/dW8oif+MSO5heBG5zkaBzbWz9tK98gIl3+euB3HwBJQb4+I6dHgEag3WGsqMrpJ1Y4EwQ3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+0s+iiVfUoRRteHbA04kL/Ap401TRj8edi3l58wzlk=;
 b=qta/eemVKhWRiBaaDJWS2oVy35la1SObMC13hmaQLH3GpDkxLutoSkEF2lAD2dfz5hpDB0iR1VEb9lwX2K3AcOdeUISIU2D2R9FmhOLLm3HK9Oh2K9RPXphoeTbPpMbzHDkug5WN3J08p+lk01AgF09MaOLK7TbPS9XPjULwU48=
Received: from DU2P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::14)
 by PA4PR08MB7620.eurprd08.prod.outlook.com (2603:10a6:102:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sun, 12 Apr
 2026 14:31:09 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com (2603:10a6:10:230::4)
 by DU2P251CA0004.outlook.office365.com (2603:10a6:10:230::14) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47
 via Frontend Transport; Sun, 12 Apr 2026 14:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Sun, 12 Apr 2026 14:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5wI3c7RsCSWbZyR686spOLb1azOV3OFScYx59qF2+WpxuEf1dLJKrw4tqaCollQQ/CplzgFlZwMhE1tLOolIh3gH69EknmnDBKNaD11+lmZGUZqm7Pd4zKCxWw4UUj1di43MhMyb0TjDqtAmiTKVoFDl9379HazWp9IuhjbUI3HtSVaZtpu3EvtKERLLT49cdeWz0PaRmRdPY9XfgDdme++dTFkqKDXkb0zmX3eOgu2+QfO9YUokIgRYoU6CPbCJmf6Bbi5LLLLpjgXx0Rqn0E/mjh3lZDb5fVo5pFzY2s5u2QjsxlVRJPrS4mK1sb42cl7sFvjN3hJaPPZl6heqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+0s+iiVfUoRRteHbA04kL/Ap401TRj8edi3l58wzlk=;
 b=KIbzren238dDTzKs9OPJ2uCaiNoIrNn4s+GFfKoLKVtFezAQ9IL74QddYlwrVMEU6hGSwxJgu4F8srPjtopoD4QugJq4NCRxXzbQcZtLeWds4uFlKnTnm4DNXl+7A+LqF7U6XvmISU7LUfY0UX00w5FmaheJc1X3p+tkZlhpdqYU/pt78+2HWhamRqojeUBSnnZCN/DorlkXbJ6IYQarlKnzG1J+Q0+GJvyY3DroRN7TAZcQ0P1CCssG1n5U+/nPHQ6MibH+R5+883/mZNWBIw8EmFdNj3f+pg9P7YYbwVC8OGiMGPsTccubplVPZ3VdKl+8/8Tv3qhXYGklfpeUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+0s+iiVfUoRRteHbA04kL/Ap401TRj8edi3l58wzlk=;
 b=qta/eemVKhWRiBaaDJWS2oVy35la1SObMC13hmaQLH3GpDkxLutoSkEF2lAD2dfz5hpDB0iR1VEb9lwX2K3AcOdeUISIU2D2R9FmhOLLm3HK9Oh2K9RPXphoeTbPpMbzHDkug5WN3J08p+lk01AgF09MaOLK7TbPS9XPjULwU48=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:06 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:06 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] drm/panthor: Use a local iomem base for PWR registers
Date: Sun, 12 Apr 2026 15:29:49 +0100
Message-ID: <20260412142951.2309135-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::22) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|DU2PEPF00028D0D:EE_|PA4PR08MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: c11db5c8-4e72-4411-6c14-08de98a02362
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: NXrP7Sxxa8fzLqB+dwms9tjE2zk1Xf4vh0Z4kZiaqvASi+teRanYQ9MMeTEGEL+q1BWBQsV25/mD67KIjD3329LW0N3drFEuH7E2ZX91GO4F6qfrrlwhG7gzSW+B6aM6CZM6ZkXsHgfeyCbb76MsRoXA8LR2n/4Uq/Lfi3VFOflXT7wwF++JC+7+tgH9KifDRrAcFlGdr4VZJoaDPDc4Wg7+IRuNV8sQ0s98U+mynqp7jLQxBgGXlt032x1K0NvkOpLWr9xoYnXpO7rjGokh6MC4CikYyZtXBbY0D0CVrZ1ZA4s2yU6NP3Hsx+pQKbT84QKBZ72g/is1ljX151ml/cDgsxyFivbX3Khu7+FKkz0fUTBo2oZC2HvLMjMi65PHUJidInNUrNHcW+o3CITkybrW2INmXthpjvgEyJvReg2ko0xFkeOV6dcVU9TfijENC1K/n92xoWdYPZxTTfzkzfCwJ28nUsYhSszAFyuCDbvQe+AAGENzuMUAEilJik8urJHD2ZJKWZqVEtTlkLp7mFg0Yqorg3+VXKn46B59LNxGaS4bLSulC6ajYeIeIzRlbQOkuFUpo/oydNaaUvV/9BkoNAbnTu+actPQeFP7ax3Ny6zC8S7Jg7x6DrhmjEiChwFjVBgFgqLBGaiFEs7HJEpq0R3tuEtunIe1FfBjQftxz59L6hZ2Jqw5QG1+IgQ+i0McbRBcqvhi1k1OOO8cpOyweWHLQFln7M/hOy57jbM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JzYmPHYNorTSH5wCfw7S7M7ZCtHlPdafvPYzdmyU6Azl27hvPG5vQ7ueV0zYJEmfve2oJ/zMRXMTLOZ16vt95muD7NWL8a64VQByJSbgF3rDHHm3xmxJJx6i6rcv+FTcZwC7+i8dBSDkIgyJm0wsO5JYmvwkRkQI3yVi231XoK5UNaoGlhHC55tdG5Wu1OuKZUdpII/2OWiuRUcBBNnu8zs3B+hZ96n310+bTc6/8ea8HKh1IIXXgHg9auhhvH7bnUJgb73cvEjQQ8Xp53fBvUqGEvzHGkC97JMdK7BHXoDzM5Fjtql2VbGumannyyDSAHfQb4GjVIKai8Vh74mOsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a4de7ec5-40ee-4880-01aa-08de989ffe0f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|82310400026|14060799003|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jykex1IPSNuleQajSVgjYEGKuHS+zvC10ZSxG7k8Ixm5+tt6fOYEiZxK5QS5MgJMyRII0+7Ru/DF4AadJnuz5XH07KFR5AsfnYLHs80UelL8zkouLDd3rwJx9mEg94wrkK3fnbn5jfw/bKllkyAfqhkd8clYBMoriARYP34mYepdntSrHTMLXO5Z6dBYlGwwQ2cdkm618jf4HBDAkjeiMZ5NN6xC9ge48awEtweFg/7zMEd2CUTXc75JzOV2k1KPiSvvHg6tqTzpgukxEf+Ut4GHKMc0Mh7Z9TeXmxfb8W1Pm7LqF1Zh4u93CFzcERBfDEq1HJ9l0dizWDDWpEL3AgsV3uARSfkecrRqvywOgRtMtP3aHslLgXG4ORDrj787DrIn4nyXqn4nT9nRg5cbrDhF+oBOEvEptb49skO8KIkkKVt05XBMpiq4TK1qmqOzLhE0RMenu1CxBDHIdbPtMezZPhug20YpFj4yth15DKTLM5b5zSTi2YorHbhqbMeflJFQtDJRohuVAHM4oJRadwqN4RNFFuXn8sUa3tk/JC2zxA5i5KjmGmVhTfkIawDepHVLUO57A6TrsomI/+PdA/TB0uGAlfGmpAHERAWlkrbIBBcyhFwDi6skiQ0oZkNXSrXcX6Mh+y9fHtZqBno5j5/KNng/8bpTPeRXoXJqoB6aIYsJKloix5UrzasqK9/ogvUTTYZSjnfvgOp210ffZ2T0LmtJF5NAhRKo58O4mgbq411RDfTVdgOZPP2oOvI+bJjBF88xrV9Ggg1ztWUBJg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PORwBzTwW9++uc9PSrigBARy0pKeGnmV8d5OiG/vcsbAfngbsToOyvDOUQ5tMr2DHe4T4sFeT/ytMdAl5PvaYMsbFqTVsg8ylFgGxFHk57Zmv7ga3xnRQdIOOITehM2TFMe7so4cK3gYHZZSMiXG/0ZSzzDoZYCHmNO2C+i33jaatxrRH171N+80EE4r5Uz6Y6uGjyIcMph8M8ET2aBQoV+ZsTNpvSK43lr4OF5J6s1VOam+rp+IjdnGktVWjqfN2sjEDgLYVEBksaygSuDox6RUkk0o9paLJl900Fph8oS3I39rVVEmI88CbcEJ4gF+YvrAbrsV3dmJX+qVQUaqElA4SPKRH1ZEY1fe4WPYUjr19HVanX87mMNaBVyKamXLVliTzfeO4pD+4dMNqYZ6eScL2yNT/WvM3v9ReX4M5gC+pHm3HhblsCbC6kHFootM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:08.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11db5c8-4e72-4411-6c14-08de98a02362
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7620
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

Add a PWR_CONTROL-local iomem pointer to struct panthor_pwr and switch
power controller register accesses to that base.

Keep interrupt register accesses on the IRQ-local iomem base and update
the register definitions so the PWR block can be addressed relative to
its local base. This removes the remaining dependence on the global
device MMIO mapping for PWR register accesses. Update
panthor_gpu_info_init() to also use the correct PWR_CONTROL iomem for
the *_PRESENT registers.

No functional change intended.

v2:
- Update panthor_gpu_info_init() to use block-local iomem pointer.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++-
 drivers/gpu/drm/panthor/panthor_pwr.c      | 79 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_pwr_regs.h | 50 +++++++-------
 3 files changed, 79 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 80aa151d5936..7e315708ca7c 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -221,10 +221,12 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
+		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+
 		/* Introduced in arch 14.x */
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, PWR_L2_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
 	} else {
 		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 11c43de1ddd5..912d44eb231f 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -40,6 +40,9 @@
  * struct panthor_pwr - PWR_CONTROL block management data.
  */
 struct panthor_pwr {
+	/** @iomem: CPU mapping of PWR_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: PWR irq. */
 	struct panthor_irq irq;
 
@@ -55,8 +58,10 @@ struct panthor_pwr {
 
 static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	spin_lock(&ptdev->pwr->reqs_lock);
-	gpu_write(ptdev->iomem, PWR_INT_CLEAR, status);
+	gpu_write(pwr->irq.iomem, INT_CLEAR, status);
 
 	if (unlikely(status & PWR_IRQ_COMMAND_NOT_ALLOWED))
 		drm_err(&ptdev->base, "PWR_IRQ: COMMAND_NOT_ALLOWED");
@@ -74,15 +79,19 @@ PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
 
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	if (args)
-		gpu_write64(ptdev->iomem, PWR_CMDARG, args);
+		gpu_write64(pwr->iomem, PWR_CMDARG, args);
 
-	gpu_write(ptdev->iomem, PWR_COMMAND, command);
+	gpu_write(pwr->iomem, PWR_COMMAND, command);
 }
 
 static bool reset_irq_raised(struct panthor_device *ptdev)
 {
-	return gpu_read(ptdev->iomem, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
+	struct panthor_pwr *pwr = ptdev->pwr;
+
+	return gpu_read(pwr->irq.iomem, INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
 }
 
 static bool reset_pending(struct panthor_device *ptdev)
@@ -92,12 +101,14 @@ static bool reset_pending(struct panthor_device *ptdev)
 
 static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock) {
 		if (reset_pending(ptdev)) {
 			drm_WARN(&ptdev->base, 1, "Reset already pending");
 		} else {
 			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
-			gpu_write(ptdev->iomem, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
+			gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
 			panthor_pwr_write_command(ptdev, reset_cmd, 0);
 		}
 	}
@@ -182,11 +193,12 @@ static u8 get_domain_subdomain(struct panthor_device *ptdev, u32 domain)
 static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32 domain,
 					      u32 timeout_us)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	u32 pwrtrans_reg = get_domain_pwrtrans_reg(domain);
 	u64 val;
 	int ret = 0;
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
+	ret = gpu_read64_poll_timeout(pwr->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
 				      timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
@@ -199,22 +211,25 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
-	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
-	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
-	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
-	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_READY));
-	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PRESENT));
-	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PWRTRANS));
-	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_READY));
-	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT));
-	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PWRTRANS));
-	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_READY));
+	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(pwr->iomem, PWR_STATUS));
+	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PRESENT));
+	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PWRTRANS));
+	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(pwr->iomem, PWR_L2_READY));
+	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PRESENT));
+	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PWRTRANS));
+	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_READY));
+	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
+	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
+	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
 }
 
 static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
 					 u64 mask, u32 timeout_us)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	u32 ready_reg = get_domain_ready_reg(domain);
 	u32 pwr_cmd = PWR_COMMAND_DEF(cmd, domain, get_domain_subdomain(ptdev, domain));
 	u64 expected_val = 0;
@@ -241,12 +256,12 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 		return ret;
 
 	/* domain already in target state, return early */
-	if ((gpu_read64(ptdev->iomem, ready_reg) & mask) == expected_val)
+	if ((gpu_read64(pwr->iomem, ready_reg) & mask) == expected_val)
 		return 0;
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, ready_reg, val, (mask & val) == expected_val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
 				      100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -279,8 +294,9 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
  */
 static int retract_domain(struct panthor_device *ptdev, u32 domain)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_RETRACT, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	u64 val;
@@ -289,7 +305,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	if (drm_WARN_ON(&ptdev->base, domain == PWR_COMMAND_DOMAIN_L2))
 		return -EPERM;
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      !(PWR_STATUS_RETRACT_PENDING & val), 0,
 				      PWR_RETRACT_TIMEOUT_US);
 	if (ret) {
@@ -308,7 +324,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful retraction
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
 				      PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -334,8 +350,9 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
  */
 static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_DELEGATE, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	u64 val;
@@ -364,7 +381,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful delegation
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == delegated_mask,
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -412,7 +429,8 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
  */
 static int panthor_pwr_domain_force_off(struct panthor_device *ptdev, u32 domain)
 {
-	const u64 domain_ready = gpu_read64(ptdev->iomem, get_domain_ready_reg(domain));
+	struct panthor_pwr *pwr = ptdev->pwr;
+	const u64 domain_ready = gpu_read64(pwr->iomem, get_domain_ready_reg(domain));
 	int ret;
 
 	/* Domain already powered down, early exit. */
@@ -456,6 +474,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
+	pwr->iomem = ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
@@ -466,7 +485,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 	err = panthor_request_pwr_irq(
 		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
-		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);
+		ptdev->iomem + GPU_CONTROL_BASE + PWR_INT_BASE);
 	if (err)
 		return err;
 
@@ -475,7 +494,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 {
-	if (!(gpu_read64(ptdev->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
+	if (!(gpu_read64(pwr->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
 		drm_err(&ptdev->base, "RESET_SOFT not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -485,8 +506,9 @@ int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 
 void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 
 	/* Abort if L2 power off constraints are not satisfied */
 	if (!(pwr_status & l2_allow_mask)) {
@@ -512,7 +534,8 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 
 int panthor_pwr_l2_power_on(struct panthor_device *ptdev)
 {
-	const u32 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	struct panthor_pwr *pwr = ptdev->pwr;
+	const u32 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u32 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
 	int ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index ad3e446971db..1fce05c3a96e 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -5,12 +5,8 @@
 #define __PANTHOR_PWR_REGS_H__
 
 #define PWR_CONTROL_BASE				0x800
-#define PWR_CTRL_REG(x)					(PWR_CONTROL_BASE + (x))
 
-#define PWR_INT_RAWSTAT					PWR_CTRL_REG(0x0)
-#define PWR_INT_CLEAR					PWR_CTRL_REG(0x4)
-#define PWR_INT_MASK					PWR_CTRL_REG(0x8)
-#define PWR_INT_STAT					PWR_CTRL_REG(0xc)
+#define PWR_INT_BASE					0x800
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
 #define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
@@ -20,7 +16,7 @@
 #define   PWR_IRQ_COMMAND_NOT_ALLOWED			BIT(30)
 #define   PWR_IRQ_COMMAND_INVALID			BIT(31)
 
-#define PWR_STATUS					PWR_CTRL_REG(0x20)
+#define PWR_STATUS					0x20
 #define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
 #define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
 #define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
@@ -41,7 +37,7 @@
 #define   PWR_STATUS_RETRACT_PENDING			BIT_U64(43)
 #define   PWR_STATUS_INSPECT_PENDING			BIT_U64(44)
 
-#define PWR_COMMAND					PWR_CTRL_REG(0x28)
+#define PWR_COMMAND					0x28
 #define   PWR_COMMAND_POWER_UP				0x10
 #define   PWR_COMMAND_POWER_DOWN			0x11
 #define   PWR_COMMAND_DELEGATE				0x20
@@ -58,26 +54,26 @@
 #define   PWR_COMMAND_DEF(cmd, domain, subdomain)	\
 	(((subdomain) << 16) | ((domain) << 8) | (cmd))
 
-#define PWR_CMDARG					PWR_CTRL_REG(0x30)
+#define PWR_CMDARG					0x30
 
-#define PWR_L2_PRESENT					PWR_CTRL_REG(0x100)
-#define PWR_L2_READY					PWR_CTRL_REG(0x108)
-#define PWR_L2_PWRTRANS					PWR_CTRL_REG(0x110)
-#define PWR_L2_PWRACTIVE				PWR_CTRL_REG(0x118)
-#define PWR_TILER_PRESENT				PWR_CTRL_REG(0x140)
-#define PWR_TILER_READY					PWR_CTRL_REG(0x148)
-#define PWR_TILER_PWRTRANS				PWR_CTRL_REG(0x150)
-#define PWR_TILER_PWRACTIVE				PWR_CTRL_REG(0x158)
-#define PWR_SHADER_PRESENT				PWR_CTRL_REG(0x200)
-#define PWR_SHADER_READY				PWR_CTRL_REG(0x208)
-#define PWR_SHADER_PWRTRANS				PWR_CTRL_REG(0x210)
-#define PWR_SHADER_PWRACTIVE				PWR_CTRL_REG(0x218)
-#define PWR_BASE_PRESENT				PWR_CTRL_REG(0x380)
-#define PWR_BASE_READY					PWR_CTRL_REG(0x388)
-#define PWR_BASE_PWRTRANS				PWR_CTRL_REG(0x390)
-#define PWR_BASE_PWRACTIVE				PWR_CTRL_REG(0x398)
-#define PWR_STACK_PRESENT				PWR_CTRL_REG(0x3c0)
-#define PWR_STACK_READY					PWR_CTRL_REG(0x3c8)
-#define PWR_STACK_PWRTRANS				PWR_CTRL_REG(0x3d0)
+#define PWR_L2_PRESENT					0x100
+#define PWR_L2_READY					0x108
+#define PWR_L2_PWRTRANS					0x110
+#define PWR_L2_PWRACTIVE				0x118
+#define PWR_TILER_PRESENT				0x140
+#define PWR_TILER_READY					0x148
+#define PWR_TILER_PWRTRANS				0x150
+#define PWR_TILER_PWRACTIVE				0x158
+#define PWR_SHADER_PRESENT				0x200
+#define PWR_SHADER_READY				0x208
+#define PWR_SHADER_PWRTRANS				0x210
+#define PWR_SHADER_PWRACTIVE				0x218
+#define PWR_BASE_PRESENT				0x380
+#define PWR_BASE_READY					0x388
+#define PWR_BASE_PWRTRANS				0x390
+#define PWR_BASE_PWRACTIVE				0x398
+#define PWR_STACK_PRESENT				0x3c0
+#define PWR_STACK_READY					0x3c8
+#define PWR_STACK_PWRTRANS				0x3d0
 
 #endif /* __PANTHOR_PWR_REGS_H__ */
-- 
2.43.0

