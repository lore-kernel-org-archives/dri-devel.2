Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0F2C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C44510EA68;
	Tue, 22 Sep 2026 20:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="msdiSbcJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="msdiSbcJ";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7744910EB09
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wWeV83Z7dHQ/leBsYr3stzfqVil53UB84cEomJGClN/Zh/lZI6HYJmkMOfcgeSAFeGL/sTqwHc+1BULmxOXV7KA8cigVyhGQvQKQXZjG7hywrAByotyCkB7eaCIML9yWyKWc2MomOT2zAVuLH2CBsAm4d/GEk80+wAyryzreuVFoAsQR8JyZyDs3PrxO/+AY5k1BIggwACHTbTi+allYuq57EADM0YJIWjCjVG1cidyCJumA8eExaJYevaR6fK+fJW19pkiJ4d61lYx4qr86IOcwbFriwUAaATaqhUlnhC6K9KOAaoSFeRx2qjyk0s1cogyPDGzd7xLecIvALtptlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa0IdNOCdxQ+2DOYwzE9yChmhc4pcMRcCeBkhimrxCg=;
 b=AnnCrUwjQX1yF0oSnCV545BHcpA5LmsPwHkI7FYtZnxk1KdvU7TZ16X5vvtKqVw7TYtKcQwbySxNxOKeXecAqqSX5Xd3znKyCzKQH/qyQbWVvAEwiPG3vEgzW3DOEjEHoXKciXFgXnZKGGuAncoYtSvhMdVHEEXqXUs9XWFAJ61Vvyk/7GQC8/QS10PGOOipS6N5f7DX+qtysUo1YBdWU40VWrQ/ajZMkZ6GbwW+sP9f95wvi0AfwlVwr7mblTOSEPCU7yzN1rK5GMjr1+78H9ERfcP96RPDE9uIGBUE8NzO3JwGIOUeYxAZ59m/boYaYpgaC5jE5nhlOZtWCst2FQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa0IdNOCdxQ+2DOYwzE9yChmhc4pcMRcCeBkhimrxCg=;
 b=msdiSbcJkTlzZzTIrRhZR28fgeiM9AV5/uq1EbgZaYy85kmgAOma2pRmLuqmaaELBcA8jqH5Jt1Lyn6LYeC7Qzk02ROZdAXvcHqjrM2WQ0H7ncCpRXLsYPBfilEjgoPmgSEtC1qaPgVunpUkPjki2Hq1FnNXtV6YTjYliCgHWEA=
Received: from MI2PEPF00000B86.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::408)
 by GV1PR08MB7731.eurprd08.prod.outlook.com (2603:10a6:150:52::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Tue, 22 Sep
 2026 20:46:57 +0000
Received: from MI3PEPF00008552.eurprd05.prod.outlook.com (2603:10a6:298:1::86)
 by MI2PEPF00000B86.outlook.office365.com (2603:10a6:298:1::408) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.12 via Frontend Transport; Tue, 22 Sep 2026 20:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008552.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzmLVjHNP4Umpz8fV2Ze6Zc6AhKUfizV1eyVqXzAx5FibEVYIP8RJKvbDlkzKyMUIOGePz/44EYZWgVG6YIauNwwZBGhL4T5graOsAw4d9ukoQ7iNsX7CFbc9+P0P74r+7B/wx3YhHD7OoT5imeaHXI95f6Dm1Zdbeq7J9hXS7AFQCSlhHeid/R4EOlESRxNTkNOldfOiBPyJAhMUG/11Lb6k452bkDg81mafnkqsj868J/JbVW9LyCACydQhcdlL2jge6Bik+cwwOmh2WMs4BT4Wf1azEi4vA57wCI6yt1Hi1N/n9pLyrEhF/eQ2sC5+2Z3eVXXOHqpbFOvwchIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa0IdNOCdxQ+2DOYwzE9yChmhc4pcMRcCeBkhimrxCg=;
 b=JPyzF/eCT6JSEHcjj2A3Tztu6OgFoNK2wBohH9ABIlIgJCLrqExll47BwFp80OnxWx8VZEhZNTAL/bmdDo6ncAPX6+ud5SdCrpYMw9rl08JqEOtWAdfwmVfda9SS8ODg6H1akCYNxS2z3K71TLKTy7FCenk+T0836d6PB+gSKHoNl4XcsFlyJHPs0FlmBJfuWHDqL4ltsxbHE/jgLUwnkJzN46MFux1T3uAMi8MHqVV3ObSCgucnPqmn2B0VZP5vTNzeNzQx1OSTaEaC7NSb33Opx0ynGRxs9tf66K0xQlCaxtca+QwMORdU+pKfPWM1KUBybcdUWglgQ4RlC/flog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa0IdNOCdxQ+2DOYwzE9yChmhc4pcMRcCeBkhimrxCg=;
 b=msdiSbcJkTlzZzTIrRhZR28fgeiM9AV5/uq1EbgZaYy85kmgAOma2pRmLuqmaaELBcA8jqH5Jt1Lyn6LYeC7Qzk02ROZdAXvcHqjrM2WQ0H7ncCpRXLsYPBfilEjgoPmgSEtC1qaPgVunpUkPjki2Hq1FnNXtV6YTjYliCgHWEA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:24 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:24 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 06/27] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Tue, 22 Sep 2026 21:45:00 +0100
Message-ID: <20260922204535.2850094-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::17) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|MI3PEPF00008552:EE_|GV1PR08MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b92b78-63b5-402f-c995-08df18eaa45a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: hjTLgiFcfVcO51acSVoD1ZSNLgljavuPuvNlq6CJHd//vBRTcw0Be2wyJ+WdS7OM20wKvGI6hVVAzC+Ek93m6qnBu3cn7VHr1FLUGmKPt9gSccq6F2YA8oyW99Dr7kcvzXmRnL+KSOPmDN6bsLofKRatagsQ0hIegb8aUXXzFxS2Q4WUeMIo0ujnj9hZ26GubQKShMHeFdCw7fc4Een6cXxF6fTPm5cdSUI1Co6P2qTflnX8/KUzL1ZqhOwtDatNErRWdxDtQhRGrnKSkiwooXcXDDTvAX9n2OJt5dORZkjQ5Q/NU1yquF3WBes/6AfUJCEiQ1bTjoHhT+sIXoaflNXTeTs5YaJEhUdjxZt7CLDgl/EHycrUtJ9GyKyiFXypL4VR2apXWwqr7OTLfYNtGSQDu7WA4K8hNXxOXvmcreQjgaUon4r2Vj+KE1WUCjshAYoZ2N7ZBT2fh4FuV0h8htljD+5wW2OzmnhjP78EiFOJz6+pHAMqbd57fPij3XymxROgJmtQzpSv+bYHQsc7riRDYA/B20fzW1lMhM+q4tJNhQZ/yChTi/AO4CaKw3+9Ip/Z5Vke8P8yAaZRw8VajQUaEJ2O3DB3kyOHS4H0QHtXg/ijTzeibgzHQ37/ML4MpJSgqCPdcXYvIY1Pvf8x3pSy12C/9RMt0JqcBe21krU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: GeyaqwgSvMAKPbzXJZ+G+NJcsKafh1VBaOTy4o79qPUo/F2gcKPPYaguaf48El8WIXkjf8vsGvWX4/n3tXVQPBf19nDkuqh4TX/YwU5O0gLhb2uzKeBhJhdK/cvoY/r0dgWMuPG5QL12VRkXlMOxm1/Al3hEpfCe6Uu6jeFcryrwxeq0luWNsKB4SlrRstjK2yvtA4XyOgq1bRzt0qs4jGNBJJZfIfqmjI9qvwEgP5Nq/DTJO12cbQ2l5B0mM3Gtkw7nkR119eU2VpwMra02SlBz2g+xDsZmDOqxfn+f/xl1bTzaDRxzUsDbPEP8+6leayFhgpWDHAFLfYznge609g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008552.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a474c857-00d8-4c11-109c-08df18ea9105
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|35042699022|23010399003|14060799003|376014|56012099006|11063799006|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: riOtwnfH/DmpQjIBAtoGcOAYTu5E/C5TH+vZ3HWQFhiuJuYdnu4mD310rcQ/RXompi0NY6H+AdoWdNDw4rZHiwAAzoRBfcby4PInZG57rvggHjpHe8OwQmxlcAj8lf7TH2sH9sj709G6024LQrqH17kk3P2HG5B4pjw+M5BIaP/Xqa+D3yEqzym/9b222VRF9IBiOqAuTDgKsjQE2XkxB5byFaHhgXcAsoAFWolQHWL6c5UBbOP0ZGB8jYHn+hpPYGV/izQ3+jLWBMOmzljaBZesoxFlr5dtWggPFaeTXgwlqbIDVfLGkbkUvoTB1zW6ZxB3RydXLZX/+tidIuuVoL+XM+VkOicV/BHfjCqrNKEPr9mUYFSIlTpOpk2FhdGvp3XH8zZq8nmr8A34DrFpKruGE9gfdEvvini740o9ae7g6Zaqho+KUiQ3JQ9k7iD5Ibv6xedR1XcGajcTPmzRBhRygp9vvWilIAGsDxKfyhj2njE79v941NmVYDj4SXfOzEg1T+Aa3SWBIvrwLOenFBhzRIGPPnQ5GPe34NBa4Tx4vHMvt/mM7oXsTfOp9ikXCK7DVoJoNInuJJd1+jyY4HqomQP0AhQLsU2kx9KGk7+6Rbyz0LuyWbbJ5HOVORcooS22iNVFhJ4Ldf7Zk2LUMD9xHtFs10uqJB9zvzJqQUJxs+oSgPE2pO4zyJh5uDysIK9Hqh1gosYzKdmG/2dAeg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(35042699022)(23010399003)(14060799003)(376014)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: usURlouiGta0vN6/k/h70SBq4zpaptOkApvzePEZUOnyMsla4PCsUtcwJAz2Q3kIhhtNKX6NJ6VU0qM/kiBXquLuwW6LJxNyQcA6BtdKG034/Mc3IN3om0Smj0p7FjDCtSPAkfhL1rZazQytqrgSMjdEwmkPtZH3ikOuRXRrCeEDlXfPchX+5QJiaCFNqaVRSTnrnMGe08uysLTxHHsuGUz3Y9qLhHRT6X9fjkzd99bb9JCZQP1fpeyZJ38IbM8i1no3pUBOGnFxgN/4YeLorkNltCC4iQmjqpNW3m7DTSfuibyjGtAP9cgp2FqryedQev04UMiV/W2nNwwMiMQKMfXiSNhNy9WMWKFickNvGIljhKo1x2snE7vebRNd3aqa4V6Ne4oGhN4jigI2eqXwrcKg/pL8JGpXCVsKZGegF66Q92wsJFXlZMrDoaTIzbur
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:56.6831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b92b78-63b5-402f-c995-08df18eaa45a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008552.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7731
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

Move the MMU address-space register layout into the hardware description
by storing the MMU_AS base offset and per-AS stride in the Panthor HW
map.

Use those values to compute the iomem pointer for each AS slot and make
the MMU AS register definitions relative to the per-slot register window
instead of hard-coding the slot offset in every register macro.

This prepares the MMU code for GPUs where the MMU AS register region is
not at a fixed offset while keeping the existing register accesses
scoped to a single AS window.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- align with updated panthor_hw_regbank structure.
- moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
  to retrieve it.

 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
 drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 45 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
 4 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 2ca5a334f5817..13090ff6db7b5 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -44,6 +44,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.mcu_control = {
 			.offset = 0x700,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
@@ -63,6 +67,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.pwr_control = {
 			.offset = 0x800,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 9231c18af94d1..68627f0df7f95 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -48,6 +48,9 @@ struct panthor_hw_regs_layout {
 
 	/** @mcu_control: MCU_CONTROL register bank layout */
 	struct panthor_hw_regbank mcu_control;
+
+	/** @mmu_as_control: MMU_AS_CONTROL register bank layout */
+	struct panthor_hw_regbank mmu_as_control;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d75d575473da4..169550413a1a5 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -35,6 +35,7 @@
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
@@ -49,15 +50,15 @@ struct panthor_vm;
 struct panthor_as_slot {
 	/** @vm: VM bound to this slot. NULL is no VM is bound. */
 	struct panthor_vm *vm;
+
+	/** @iomem: CPU mapping for MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
 };
 
 /**
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
-	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem;
-
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -533,6 +534,11 @@ static void free_pt(void *cookie, void *data, size_t size)
 	kmem_cache_free(pt_cache, data);
 }
 
+static void __iomem *as_iomem(struct panthor_mmu *mmu, u32 as_nr)
+{
+	return mmu->as.slots[as_nr].iomem;
+}
+
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
@@ -542,7 +548,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem(mmu, as_nr), AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -560,7 +566,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(as_iomem(ptdev->mmu, as_nr), AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -609,9 +615,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	panthor_irq_enable_events(&ptdev->mmu->irq,
 				  panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, transtab);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, memattr);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -647,9 +653,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -1808,7 +1814,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1871,8 +1877,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
+		addr = gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -3388,8 +3394,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
+	unsigned long as_present_mask = ptdev->gpu_info.as_present;
+	struct panthor_hw_regbank *regbank = &ptdev->hw->regs.mmu_as_control;
 	struct panthor_mmu *mmu;
 	int ret, irq;
+	u32 as_id;
 
 	panthor_mmu_info_init(ptdev);
 
@@ -3408,7 +3417,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
+		u64 offset = regbank->offset + (regbank->stride * as_id);
+
+		guard(mutex)(&mmu->as.slots_lock);
+		mmu->as.slots[as_id].iomem = ptdev->iomem + offset;
+	}
+
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 4e32ab931949c..9d3747601e698 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -10,13 +10,8 @@
 
 /* AS_COMMAND register commands */
 
-#define MMU_AS_BASE					0x2400
-
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define AS_TRANSTAB					0x0
+#define AS_MEMATTR					0x8
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
 							 ((w) ? BIT(0) : 0) | \
@@ -28,8 +23,8 @@
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
 #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define AS_LOCKADDR					0x10
+#define AS_COMMAND					0x18
 #define   AS_COMMAND_NOP				0
 #define   AS_COMMAND_UPDATE				1
 #define   AS_COMMAND_LOCK				2
@@ -37,16 +32,16 @@
 #define   AS_COMMAND_FLUSH_PT				4
 #define   AS_COMMAND_FLUSH_MEM				5
 #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define AS_FAULTSTATUS					0x1C
 #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define AS_FAULTADDRESS					0x20
+#define AS_STATUS					0x28
 #define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define AS_TRANSCFG					0x30
 #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
 #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
 #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
@@ -64,6 +59,6 @@
 #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
 #define   AS_TRANSCFG_WXN				BIT(35)
 #define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+#define AS_FAULTEXTRA					0x38
 
 #endif /* __PANTHOR_MMU_REGS_H__ */
-- 
2.43.0

