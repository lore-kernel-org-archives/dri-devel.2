Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96410FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0575510E802;
	Mon, 27 Apr 2026 16:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SzvsRuEG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SzvsRuEG";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA5E10E804
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ExRmlUTwC0VRpeClr7X0NcOjbBl5WEjsBSt18rlZPStfr6ZT7mfQAwzkb95gToSN9nq+gqu28lMShW8VPRgOCW40WJoliKy9K/CPIa4dGHl6lUitZPuuog9NwzbycNs2jtVYCVTNqwU+7ZqU+lfis8Cgbf2hOON7k7tk+IZqkAIBGbbToBDev2u/pbm9oFTtrupAJQYy/iILV5aDvj7r6PUpPZpGUV6QNeaSV1txyaBKtSMDfc1b+4l0QWKp0jrv+Kh3XUnrRuvW1tTTFgxTqgDT9LFbpbHOFGoyMr/4o31aOpf6Z/T0XVgOfjgQG72cC8KsgqyHxEdzOrkxENmq3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQKpej1q4s1o6D4CU7k3VpkRh7HvzTODmjKoInCQ+Mw=;
 b=RJDl04GXkYrtdz3TaUCRzfqBc3a90GNgJMV4TO8dLNe9PIQ/cXl57j2RmgcmOS5ZGpchE9/nc/eK9qmhJ193MRAv42u6UkEDNDugbvXLRiEu3IVXYTjL27MRUTgEfptMNM3dLy+DVFx9mJQxjHSBKG70nWOW4PDKbUirpVd0nXcGTKwZjfeiPHUvhHSSpRZLjfUGldrcz0qmn/mQ2Hh2jAQc4Zyb0TQ0cAneOemEbK3iCve/OohCTl5mqvljhfH41mrSsu+fppibp7JNwZHYLQbrbsLaLUJUFI+Q3lbvL1+b6zRZ3dsbLO9wWhVx/1VdLb27sK9BP7RIoRFbJyyO1Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQKpej1q4s1o6D4CU7k3VpkRh7HvzTODmjKoInCQ+Mw=;
 b=SzvsRuEGy6fv4Nn748zxEucJxlyT9WFbD+466iPqrCk6aMSyFyfniHEwSwQOtXvzk3M71kdfgdrSuxpoEEgsme34MSkispw/5MGfDjnfH0VYWczampHVqLvzUFxXncMGaYW1k+Sipt7NiapsHOBENj1oW8EAE6Qa4hXN2l7XurY=
Received: from DB9PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:10:1d9::22)
 by PAVPR08MB8848.eurprd08.prod.outlook.com (2603:10a6:102:321::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:53 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::5e) by DB9PR02CA0017.outlook.office365.com
 (2603:10a6:10:1d9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48
 via Frontend Transport; Mon, 27 Apr 2026 16:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL4jfrc+BTagPzKXi4oyUHngP5zCXc2oIfh25BemPaNvcsG6pbCv8UnjV/6vCIssE8KaWGnh32lmCR7FXMyu35jIjO+PIQ/XSPfWkLpF+DaU4jsZsvNTXDXBMnvsIY1IDe319Nj9adym0KYHncaY572TnxBRRuiJyQo2hZXjWZaZG6xoDW0cCemld9SJjM7KO948h3sfNXg1LBk32w4a9GLc+5CJvAGVE6EznXbhEa37NrKXcN43NdYOGrRhfQbImru+trctQHmdstXBil1KUfkyZ+ZAhoVnKYgBEOZk6zBZnEXrZ6z/1AJpCatADCgjpcjPsuFx8gI9gbH4dSzdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQKpej1q4s1o6D4CU7k3VpkRh7HvzTODmjKoInCQ+Mw=;
 b=HP7hjl3jybKGQt9SqPgtC5FLipuD4rL+WpqsZY8ns0X/U6N43tcqHuIqWrUgNEra4rOWfRpUseiIv6p3Ghr/va8grWaCZ2OYoTYHHPkQMyFWUSxNvJ7wWkP8lJg2lkvJaAsLwKQgbfWibZ8wji1PvShqGBkwdgOZJmUJNklvgcf/ka0Yo0RlVPRXJiakiyqBov/08FB6J8qCBrUHlAj5g6sU3LPKzsCveAIXULxNqh8P5Nmovo1fdAG4nmpUlcqwfdUbHmpOkATZA7v6SjVZIGk+RV8UfR1f1H0UDS3skCY8+joWkOvkLJtyjYDN0srHbszmYEZ4o6hfMI7UoGf1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQKpej1q4s1o6D4CU7k3VpkRh7HvzTODmjKoInCQ+Mw=;
 b=SzvsRuEGy6fv4Nn748zxEucJxlyT9WFbD+466iPqrCk6aMSyFyfniHEwSwQOtXvzk3M71kdfgdrSuxpoEEgsme34MSkispw/5MGfDjnfH0VYWczampHVqLvzUFxXncMGaYW1k+Sipt7NiapsHOBENj1oW8EAE6Qa4hXN2l7XurY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:51 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:51 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] drm/panthor: Use a local iomem base for firmware
 control registers
Date: Mon, 27 Apr 2026 16:59:33 +0100
Message-ID: <20260427155934.416502-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|DB1PEPF00050A01:EE_|PAVPR08MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 80693c2e-3d08-49f4-bb0e-08dea476290e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|11006099003;
X-Microsoft-Antispam-Message-Info-Original: 7it+8SgVQyrgDtM9DFp4JxhwvhwzKIcKcliwMfG2JTf8JUo8ZQ6iBnuizZTI4PZsFywnDjKZIsW6/jRzBO8nEkmaQdrabBBlfgdErlYb5DwbYzdIVOooxoQqSESev1EJzh451h4uh/kutHwMEt1pax+YsFQDnHQo/bRJaFpVTQjMdvSI6NYoD9l3mmFB1iaLbgLro5SRH2q92cAjToc+q+x+U5gsGNZSU5FTBEVjNHk4jPrPRGT12hh+KAJhqYEPZCRCTk+04wvvLdk9im03ripaJc7dLG37R7xbFIA7rSukS7DTvST2Iag3ds6JqFQj/AyyzsMzG2vgemIWaFMO8niea8PAl04jllb7rD8T2mSvEtdCHMzPCODzPWUjeslcVeXEnrszPFhV+t2rSabPYJWLcG9xsh9IaRLHc0T88RZ5vAU7h+3Fu9mWeL1iLoAD0eg3cCEI/QnIrmDnOSW1hh3Oe41uH2U2o9ChbXrvQLYSHPFdOlFcygpGOeLuqLLSpL9YCCT1bTLodUCpYdyMh5eVI084YF4wwl81em+ifw90lYXBqd4yx6ZuhljQKq8oIr6lsQl/14h1y6JYu5odTUsoDHOFmhdmjnyNt00jcFZDZKuUejV9eZn/InZ4PEwP8oafqNvPsxX1k1oB7jPYezGcj+DP2zw4BehlHGRQTvlP73Y/ghCJj0cFq127dnYR0NAC0HknYzzVj/+msKSUsWxboqICsx+X+QdOr34ZfTI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: c0XtQXfnlBp1WokS1GZEECMxF6h2of2CToUIrjxrmmgt7Gw/XjXLlOffRdOjy5T1WmO1diUVHwvlJf+vdbPhiBfDtj07Rj4FW66sBrLWbDMFz5WtkRYASjhxzDHtkCp13GOD+KxSrk6s78haKfBHWXoWwu/NoCP8Qq+LSOwXLVac0ZLiYM8ToaDRCGTv/9GIHfj5Z125SktlQaYg5f22nRwKEZFAV9c24JTPN/O1ufh9QhfdSBlMJdUEeS4wpEFT8LRN9k/4Ir0gslqw3D2BOi1UXD+vCIa+UolDIrXeKi/P/LyKEq/SwoY0S0Mqr69ISqht7Ok/6xRDeUiRFCV8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 28af4a95-f43f-4e4c-5abc-08dea47603b9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|35042699022|14060799003|376014|1800799024|56012099003|22082099003|18002099003|11006099003;
X-Microsoft-Antispam-Message-Info: bLgQIVNFsLqk29Ub1NvL4xifL1T3EHEUOuBWB78jZ/bxtfCAvl1QXpvnBKWWnOTHa6LKwEYu+H5wYkkctdd7imwbvjOql7pFIcjvXyiLta6qtaMJ3bDw0u8lhB9rdMMGSVaqyHmKUubcparwC2prBOTM1JcPfP0tANDUx6kfLmxqQlbKb8eGHpvr0yXMUyoftHkxhZdoXSgijiMg/uLkkS759T8FMY4QhYXWLafXgSd2N3dXTF2eHT2oOciQEhDb88Hsb5XqoFksn4h7gKclRRz6HzF2kXtqc2TjU8tuFUx/l8cSdKrlOETWU0YRtCLbDmPCd4l0y4pug4z3p/toSyHADvtQdnV+7X0dGdRfzaKUayDXufr2/g4CuCcBv7g1ntIWFeoHcxkK+56W2+mCijrbe0VDC4arSnQGM4jtPicUW1+bWK0AZ2xKjidwnxCzrfCfxYrz4wJZdxsVc00nb0Qrw+V46lKdT/kpH/vNP4Qy4Ap0JiNKzD8WRPioXvxF/LhQhPV5mFDJRbXyZAKqQQO9lot0XSuUT9X4nu8Wvmf8sj4WKopf2zH0W9WCUMNqZswyI7Vled6xjlb/RAmHstjZ+MyL1SneZzvA/EaWK/bPPLrgcmR16X+AUlmOMGGDrNfplm9eQOLnZFYGmZSH6TYyqM/WmRPq8oRzVyQ3v5vibf/MMOSs/dw4Fyexp/RbYNQ7oAkQ5DoNGe4uxb5ik6s5QTys8ctUYkdvaZySvzsnhhaUoF/yXeSVOzSgrVCbKKMqCA0tOxhdqQ4pOBdu+g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(35042699022)(14060799003)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iArhtU5GGw/nmZgZzeWFkRK5fnSVukIG4WZMUTicY9wPUqtxWxyPweIgpYuTmtlyGdRDL0Bn9IdQIfFFKVagvYN6bESycT1xOEm0moy9E5eBSB0Nhz/Rpnez4d1QeykVp5ebZVeQHZJY+C+IJszKhP+vzn5v7bZYKIRQ2yT9KZ1Uh37PKiaCAp1EZUm1aZaLqr2MYb1bSGT7dDVUcCL8sk6y6PF82XpdNJrPthi6Qxo14yeWRNF3Q3m3RgeJMRztJNZNwBpFIxyGrG9FCSyD1kjbuf/hPl/ZGSSvA1LPnaOb11CojzrANMXxA65jdXntNwc2NKLeqLiA+hhau3laY/h+Z9ClarHiu3303bcBZYpSAm7B8LJO0SwC5+fL31cXD8JjEuWjwWWt58M2m0yDCox5AGhSVWXweQVeXjhBAokQqGx5XOY6O4tlLvwaNB0G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:53.3906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80693c2e-3d08-49f4-bb0e-08dea476290e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8848
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

Add an MCU_CONTROL-local iomem pointer to struct panthor_fw and use it
for firmware control and status register accesses.

Job interrupt accesses continue to go through the IRQ-local base, while
doorbell writes stay on the device-wide mapping because they live
outside the MCU control window. This keeps firmware register accesses
scoped to the component that owns them.

No functional change intended.

v3:
- Pick up R-bs from Liviu and Steve
v2:
- Pick up Ack from Boris.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c      | 20 +++++++++++++-------
 drivers/gpu/drm/panthor/panthor_fw_regs.h | 11 ++++-------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 73ef07a37e22..986151681b24 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -234,6 +234,9 @@ struct panthor_fw_iface {
  * struct panthor_fw - Firmware management
  */
 struct panthor_fw {
+	/** @iomem: CPU mapping of MCU_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @vm: MCU VM. */
 	struct panthor_vm *vm;
 
@@ -1069,7 +1072,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 	if (tracepoint_enabled(gpu_job_irq))
 		start = ktime_get_ns();
 
-	gpu_write(ptdev->iomem, JOB_INT_CLEAR, status);
+	gpu_write(ptdev->fw->irq.iomem, INT_CLEAR, status);
 
 	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
 		ptdev->fw->booted = true;
@@ -1092,18 +1095,19 @@ PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	bool timedout = false;
 
 	ptdev->fw->booted = false;
 	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
 	panthor_job_irq_resume(&ptdev->fw->irq);
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
 				ptdev->fw->booted,
 				msecs_to_jiffies(1000))) {
 		if (!ptdev->fw->booted &&
-		    !(gpu_read(ptdev->iomem, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
+		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
 
@@ -1114,7 +1118,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 			[MCU_STATUS_HALT] = "halt",
 			[MCU_STATUS_FATAL] = "fatal",
 		};
-		u32 status = gpu_read(ptdev->iomem, MCU_STATUS);
+		u32 status = gpu_read(fw->iomem, MCU_STATUS);
 
 		drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
 			status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
@@ -1126,10 +1130,11 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 
 static void panthor_fw_stop(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	u32 status;
 
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
-	if (gpu_read_poll_timeout(ptdev->iomem, MCU_STATUS, status,
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
+	if (gpu_read_poll_timeout(fw->iomem, MCU_STATUS, status,
 				  status == MCU_STATUS_DISABLED, 10, 100000))
 		drm_err(&ptdev->base, "Failed to stop MCU");
 }
@@ -1139,7 +1144,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	bool halted;
 
-	halted = gpu_read(ptdev->iomem, MCU_STATUS) == MCU_STATUS_HALT;
+	halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
@@ -1461,6 +1466,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
+	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index eeb41aff249b..b2e59cfc22b0 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,23 +4,20 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL					0x700
+#define MCU_CONTROL_BASE				0x700
+
+#define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
 #define   MCU_CONTROL_DISABLE				0
 
-#define MCU_STATUS					0x704
+#define MCU_STATUS					0x4
 #define   MCU_STATUS_DISABLED				0
 #define   MCU_STATUS_ENABLED				1
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
 #define JOB_INT_BASE					0x1000
-
-#define JOB_INT_RAWSTAT					0x1000
-#define JOB_INT_CLEAR					0x1004
-#define JOB_INT_MASK					0x1008
-#define JOB_INT_STAT					0x100c
 #define   JOB_INT_GLOBAL_IF				BIT(31)
 #define   JOB_INT_CSG_IF(x)				BIT(x)
 
-- 
2.43.0

