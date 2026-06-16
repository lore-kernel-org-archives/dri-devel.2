Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF1ACD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE19110E779;
	Tue, 16 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dwfP+s9q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dwfP+s9q";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013043.outbound.protection.outlook.com
 [40.107.162.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE6E10E779;
 Tue, 16 Jun 2026 13:50:19 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EghZYUHsTrxEzsg3FsmENAuwsFPZ4P3pcNwbUHiQy/l1qLN67S3wg8CduEvIJBfUoHAIb6UA+IZcoj40YvRylCEYHe21Bzcd0lZggauheMPcjXwZLBMmhEqzlhPe62rr7fJm0HA2fx4HO8reVH6+1RD/8S30lPm8AF6+AKwKQWyPdXc8RPMuJfx1AzGBA0gm4wMiAxaIY7CRKqS6xkNqPCLNRHTdJ6KgsWh51CPYjmT7B532pe6xnd2j34/x0Zkr572O5RzGzC3UbCDiL2eL/u6Jyhe8lwS2kVJtwxmeT0lWkbmhpH0lNtWEUCOkjGFAyaO5YQ7IueeSxu6USOqSWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKcQVHWzkxChzhp9P6Us6gU/0deTgtTCVlMccp1q2cY=;
 b=oxSbH9ZWcDLvZh/uxVJ3UKHvmCWE/JP9glWAI1YmqjZnyyV9Gv7F+kQsGtsVhWV91lgLqkzP+CGPVlBxBzd/12jTQoct84Ccs01j/4R2NNUqx5dOncvSDeiNWQ19BiL4HW9VrHVE9nhAIx0Wxzll+aYG0aLSnGxF8C8R956Uc7Qe7RhkdzVm0AqHw1mcDCPawOeJFGLaVmYnqgCT/Mme7r3Xa6yF5sWd+cTjJyDVL0kDS3O1sKYfzBvu+HFVltJodSkOsctrHGzUIniNAXBFOnO8tTL+EwAYaMEDsglwFUOsHom8kJ0Q83gWw9Gah9IrOCdCjTYZohjPGli3ETHhzw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKcQVHWzkxChzhp9P6Us6gU/0deTgtTCVlMccp1q2cY=;
 b=dwfP+s9qy+tqnpYaJTMOPQek2NHQQhdntE90vYcyT3DOg73ysGcVfcXqhf67WBOIAfMnmDu0M82wuZCLeWi0rYn/YZV1LNa3bMCiu3vjpCFF17uCu7ofGvi9BYM8b0Orc1QAts1tAOr0zP5pensIvKGkYP590oWUuliw/GK5v0U=
Received: from DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) by VI0PR08MB11516.eurprd08.prod.outlook.com
 (2603:10a6:800:300::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:50:13 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::9) by DUZPR01CA0249.outlook.office365.com
 (2603:10a6:10:4b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 13:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 13:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+zMrkkFCj3rCdUzEH+x8m6TXP1c+3hPDfNsx4Wv47uhdf2wjRBXH4r7EUS3y3N99gDmMfN4Clw5pnRV9CgM4dSGxhMK78haUpvuyPxm/Adc3sAtRqiaGcXX/pwRUkVvkRg8+deR8+FTptWg1eHiyEatBidZneKm4zwGg/btBS+Rk3op/+S2WzUvp7mN5H/mHii6auvdZHVTFtWpWJSBWfGtTlJw5IC+5B6qsUOcihFcY9+WDhWKXTfeurh/MUpHfZvhi7YZBFAcOhlX9aYq4yTQyhHOc9jIpCR8oELuQNNX9ZH+IxHWHS/tow8Lzq2MFQZ4xAW0xJTDGiWqOG/kUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKcQVHWzkxChzhp9P6Us6gU/0deTgtTCVlMccp1q2cY=;
 b=wm+KPYtB7O02AwkWqfil6sjaLNFk/FktcqHUZaAYFACRj4TUvNfmFtwSM5wg9rkcjlivhDs37ie2taEld0woa3YmMnaVQlWXmdH+g/Gg44ws8YL6tFKpx8vewbkwfFnxURdBuHad5v9Dp/vKMffj7bEdvA3xOFbd17BYZA4NQzZyyubUCgP+GKWOEJeD+thskDVlIfQg80byqi6EUYLiCmqQEcUXu1A9SaKH0UEtZBIo930fpmluWEEKyQSbiZ/w5DTHWlRdkmT5MJ00haeHWMsy4sXVfp2VfZH+BnjYWzbVYM79juGkERLMI0nsI1QCbPuczBYNsLLE7h1v4gl1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKcQVHWzkxChzhp9P6Us6gU/0deTgtTCVlMccp1q2cY=;
 b=dwfP+s9qy+tqnpYaJTMOPQek2NHQQhdntE90vYcyT3DOg73ysGcVfcXqhf67WBOIAfMnmDu0M82wuZCLeWi0rYn/YZV1LNa3bMCiu3vjpCFF17uCu7ofGvi9BYM8b0Orc1QAts1tAOr0zP5pensIvKGkYP590oWUuliw/GK5v0U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by GV2PR08MB8169.eurprd08.prod.outlook.com
 (2603:10a6:150:78::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:49:05 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 13:49:05 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: Bence Csokas <bence.csokas@arm.com>, Daniel Kiss <Daniel.Kiss@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH v4] drm: uapi: Add macro for chipset specific event ID region
Date: Tue, 16 Jun 2026 15:48:01 +0200
Message-ID: <20260616134802.636166-2-bence.csokas@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0685.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::8) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|GV2PR08MB8169:EE_|DB3PEPF0000885C:EE_|VI0PR08MB11516:EE_
X-MS-Office365-Filtering-Correlation-Id: d23a2cb9-8f15-4487-31ed-08decbae3007
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: P2l/P+qw1MfVWPvbxj+334507UeaKeE+S3CG+wJb401whdVl5psLF+932RxUAjc6sSqctxPJoZ0Wah7WPwZ3rgFwldx9D68KbQ4D/s/kxMPZGK2GDMaqD00gSvh26U2ZZVZ/Nypruxo3bamJV4L6BGGuZ/iukLEfINoj3i+rfFobT/ee5lCZyq8ljbZA+4LaV7ZNuko7GaqCIuLu1gHQsAsdFRSNOlgSmsYxQY5JjBHaMizIbgx8r1Emn5pXs7c3I4tO8b3xDz0S2M4iqcBzZ9YMw0EFS+U2xCj+nOHmDCEewc8q2UzSAthXJOBx9xPxJKhF+LrcYJBiyd1LLfqtYNDnBMG7szW+jb69ePUALuiSqQWGLvnJMc/4016KZ9SfoYghF+HHo039mji5VpbxzV/cmzdNUPU0y8+lVKX6q8lGkVHDSr7wrcVdOmRTQrzgeTithwdfTx3bP9I0njhTMJ2uZI/D7fBDi6nA5DCafB9VNL/Lz2W+FR/DTnCIFJvWEFU5bGGJL/0QwZXOZ9ufmf8WDmIKtW0wdvfHj+OrJuEsLF5/T2GF2jCpQLyYPIOFyqovfXpOmRQm2lqEoUjFDmQ4kdC4XjJgm+hpVbvko3QGYX/35MFk5u8aDqBI8JcgzJiPRV09i/Uqj4ddLry1+EP4s8BrVIpNfwdEcYe1nGW/d3nV5oeIZjVSBLeqI15pARfoz2bVN4HZbw7ntcuisw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: h5TIAOxfZxzDBwe8V58rzQNv5EVhams/2L1RQfDWnqVm8Uc9dD31B1Cu4oSOy2EMaa0iXr6QDyUfhS3303iYRMiexHGpZliKihYs2hFACzCodBC/aiLA0wyG2E5z/6ditrxU8WRTOCGPIs0lFlpOJtezp8C/wXlJc2rBBwdltpmFIxuC2T/r8XPLJ8ZQsI35ZYp/Ni2o2YtrYfbSQ034MjkxGS1YtdHt+k38PWlZEr6a7ZWI9kQB+3moYFQpejz0rU9DhG9NofIRh3weDr3AWD2RVFd/qKI2olFhYEjifcVtvso6eMk9rMWCFPD7NtubmrEY1P8AezbVcyKc2qbAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8169
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 37d9f197-1fce-46fd-2641-08decbae0812
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|35042699022|36860700016|376014|82310400026|1800799024|14060799003|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: l1nd45wyNLPsl3/uLGt0HfRl51X+QAdqvERm94XBL1aSp589gs2ZzopkBSWUEegG41h7hbjiIHfbdpFqTm0uZBxA6tkfjCSr+u9dFKo1t/3fj9EmfVIqvNDqXPPfVhAK0gcPM0iKuSOSnLUetsSpvNxv9P5NUqirsdWKYdGSDAdSD9zREDoU07YWYKJ6OfLBiiUjxoiG1mw/wmUquVKxzIY7OvWk4dcmw1U+0BHniFGvyeEpRVtbCGNrvLMwhoyx2AwiCmllned0cWD4jgIJf3BKQZ9PMEktePO09/+JG1je9H/JrlFCB/Pxhe+kZOlLbktcwuvWuw1E5sz0NVi+ZOfzUvxS09LoCTnWqjaRzFV2/rMdYGIvmlOrc29+R6lUisZ9i1pweOoR9AcLkBJm2NJ652+OTWl6xmsU0vNWcJhV9qEVuNzGRCliW9fctf/AXRP73m0tRurJx263SxcH+voKFqVDGmane4HPS+TcSPxsQTUL9jWdNi9CUS3ez40WeEYwaKh1gByKnCVhFM3VQiwIPAr4oAuKHFfi9iXzZBVXl8rL2Foqi5w6cT58ZFB6od4XK9DD+thfb1OWFsPEAFvGTgZpJuiFA3RdVwKAXVgNfyB9OP+MVbVDfORYhm9N9NZLXDhsxvwHSULdOEE6IsmdjWq0xowQ66vWdFDnqSBODJC19PzvblqVkKesgR+B3YjN7bZuCh58I54wyLMGTRpH9v2mKEUKJDK/hhHlaB4=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(35042699022)(36860700016)(376014)(82310400026)(1800799024)(14060799003)(23010399003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 976hBA0IGsOT8O123LJdXsOYodPtDvYlevSndZK32NGuGwveqta96+k2F/RIpdsCHIxTQyysktu4lFVMuTxySwM7oGiwttjxZQsJ9JPCselBWFQgVINXhDLLMRUDRo09D93iMkqB6nPFJtojMbtgmFRHs9dTEyCaO+xmT7vUKLMXtJsGRWUg9pBLAdBWBUCPCuhNVZY7dKkems31K6CWNmqlZyRi0uJ/aTdFAbYwX74jCAjbD7r52ag/NCFJhEJmGVr8wdo6j8ZlmAP7C7RI1oZwivs5P9rggWrBhv2JMT6MHLBjoVDeCKlNb9YJMIOuluk++mUKoiXbQsQPpX3g0g128WvmmB3JKNIhiMSkAG6NVcypX+6ItQAYqxaarAQxt3VYt12RJAV8onOw5IINpH4YUa2qOUonpUcKRcrcy3oNQ7AdCDTd/VO5kk5bhWQ+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:50:12.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a2cb9-8f15-4487-31ed-08decbae3007
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11516
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

uapi/drm/drm.h states:

    Event types 0 - 0x7fffffff are generic DRM events, 0x80000000 and
    up are chipset specific.

However, this distinction was not put in the code. To elevate the contract
between the generic DRM framework and the driver from the comment to code,
put this in a macro for clarity and convenience.

Cc: Daniel Kiss <Daniel.Kiss@arm.com>
Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v4:
* Document `_v` parameter
* Also convert DRM_NOUVEAU_EVENT_NVIF

Changes in v2, v3:
* Rebase to master

Link to v1:
https://lore.kernel.org/lkml/20260408163608.361826-2-bence.csokas@arm.com/T/#u

 include/uapi/drm/drm.h         | 9 +++++++++
 include/uapi/drm/exynos_drm.h  | 4 ++--
 include/uapi/drm/nouveau_drm.h | 2 +-
 include/uapi/drm/virtgpu_drm.h | 2 +-
 include/uapi/drm/vmwgfx_drm.h  | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d27..6acb1eee6bd2 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1419,6 +1419,15 @@ struct drm_event {
  * The event payload is a struct drm_event_crtc_sequence.
  */
 #define DRM_EVENT_CRTC_SEQUENCE	0x03
+/**
+ * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
+ * @_v: vendor-specific ID
+ *
+ * These event IDs are reserved for chipset and driver specific events.
+ *
+ * Refer to the chipset driver's header for details and payload struct.
+ */
+#define DRM_EVENT_VENDOR_SPECIFIC(_v) ((_v) | 0x80000000)
 
 struct drm_event_vblank {
 	struct drm_event base;
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index a51aa1c618c1..8d3156fb129c 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -395,8 +395,8 @@ struct drm_exynos_ioctl_ipp_commit {
 		DRM_EXYNOS_IPP_COMMIT, struct drm_exynos_ioctl_ipp_commit)
 
 /* Exynos specific events */
-#define DRM_EXYNOS_G2D_EVENT		0x80000000
-#define DRM_EXYNOS_IPP_EVENT		0x80000002
+#define DRM_EXYNOS_G2D_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x0)
+#define DRM_EXYNOS_IPP_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x2)
 
 struct drm_exynos_g2d_event {
 	struct drm_event	base;
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 1fa82fa6af38..6d9d7ed52d28 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -25,7 +25,7 @@
 #ifndef __NOUVEAU_DRM_H__
 #define __NOUVEAU_DRM_H__
 
-#define DRM_NOUVEAU_EVENT_NVIF                                       0x80000000
+#define DRM_NOUVEAU_EVENT_NVIF DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 #include "drm.h"
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9debb320c34b..03e8a0c7f778 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -224,7 +224,7 @@ struct drm_virtgpu_context_init {
  * effect.  The event size is sizeof(drm_event), since there is no additional
  * payload.
  */
-#define VIRTGPU_EVENT_FENCE_SIGNALED 0x90000000
+#define VIRTGPU_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x10000000)
 
 #define DRM_IOCTL_VIRTGPU_MAP \
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index 7d786a0cc835..5e5878384e60 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -715,7 +715,7 @@ struct drm_vmw_fence_arg {
 /*
  * The event type
  */
-#define DRM_VMW_EVENT_FENCE_SIGNALED 0x80000000
+#define DRM_VMW_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 struct drm_vmw_event_fence {
 	struct drm_event base;

base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.54.0

