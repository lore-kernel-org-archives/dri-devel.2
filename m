Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B71CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B4410E162;
	Sun, 11 Oct 2026 17:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="BhsG1eDb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BhsG1eDb";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013041.outbound.protection.outlook.com
 [52.101.83.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C1810E135
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ksy1swrWk+aME2sTQJTOeFHYwWSdsyK4fQ9cnCedKs7Ok9EN4zOd62HBQzJ32+hIUJzbZBl0F79swvf1UhyZSeePiOh+qpNw+Hzgr+DGNWyM0gXOX+t7Eq5gt87IDiAwhEa5z7zayIhpL2Xg7jhihb9jwFY0uacfsWjtofOOgi+aZtExVA+IKVyA5pxB2cD4docnwXWnupkJIc6WYNK4uBc698UeHPWhgdMYsCF3QscJbWMV7BSPT3edChPtuTWd3Ge5J6zO4mBfMHbTRErEParhcBbe7hf5dzjEr8vvnRz/PPaY1KFD/W9OzhXa9f2NWQ/87N1TAdmM3eX1vP6vEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD6mmlmtSv6c+JteR55aurq7xg1oxCWMciNPAB2gOoY=;
 b=t7WdNmJia/9vg/R24Yy9ef/QirEsJxUPdb1MWNnv4Oz0OEzLRLuuisYqXPTmIwbyD207rK7aMVME2FD3+TfVBiD7jlXinCjjz3GKERTxB5y0qq73rx+xYl2Q+TiLRD+pRyXY6KUX0MObyjV3J4KkmebmrCjiFP2TXLD9SsvkMKpgpTb1lFq2/Lgn6xoom9rEWLxsb7RsLlt9O5niGXM86//w+EuFXJYhFTtT+CBztUhLmH9UCnKzTZqdeWBYXHboYGiOM6NkmUYuIi7n5HnzxbobUDEyDLgRjXxvKpugUQObZBLX3fMf8G68jYJ1E5RAH78h6fl6QKxH/uaWZCaPtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD6mmlmtSv6c+JteR55aurq7xg1oxCWMciNPAB2gOoY=;
 b=BhsG1eDbb/wNyKWPUeA0PPNDiS0TjtroMkx2NnCxZa0VjjhNNIDqUVhIYjfnm+beMkwSkuBbexmPAGL08OZVmqK9Bnhy589AahVjF2ECZA9+beBkG2b3SZa7NCY1Eome0SpIm3I9LAE0Vg7P+65NXxySW0qrgbTncDV0QwDI+B4=
Received: from DB9PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:10:1d9::28)
 by MI9PR08MB755481.eurprd08.prod.outlook.com (2603:10a6:290:86::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:18 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::72) by DB9PR02CA0023.outlook.office365.com
 (2603:10a6:10:1d9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6 via
 Frontend Transport; Sun, 11 Oct 2026 17:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nif2ZAs0wBSaux0oyabdwvlydqg2i+nH/wtMga+EOd7mr96V0fheDKGSyU6i4siOiTiDaGTwrydMZKMbNnmV5092PmdIIHTFQ8NJA+SqNhGn3lE7tA4qHGzADHIQt7q1v5SYws0FUlSwL3aUrXvuxmHRrqJTxBKA7vzGaC0jFGWujLGumo7KhLGLRgczXPJBCjUWzI0OW1toOnWivyZ0hQ1pjYdLwAHpDhbgNfacwrez3veX6O7/PgjmrHaSy4E1+7Lm8zmDpVu8I0QHAXv3OsMjXJX4iOxj0f3MgE9enDkZnIE1RTtaNJ1BzpsdYK7QNOess18vQBpkKGouSTf+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD6mmlmtSv6c+JteR55aurq7xg1oxCWMciNPAB2gOoY=;
 b=CDi/vSxB/jXS314mnJm5xpB2oLXVUmm7hLtnr1nTkGuklc1BJP+zTzUeqnkCMzNJb22gL8oFi8lpHPQoNTaA/ZbtvbA66n9yfYkYDiBvJLTl267tHrdDgRV6Fn/ntMv5w3L2Z9rbogb6/AEpDVqRFEklZ3JzEqssRnow7wAgFghd1CHcPZs8PEus+zdlFBKD9ZsBp6EyF+6Hj2GVxj4iKupiNwWH0JIl8JrSHCOZK38fQoTxicdMWwd0R3ct2P4xxC4IhjAIxZdBQrcwIYf8YLSU6vClzKNTomvvMiIbSuwb7uPKMOsAGro3E3drv7lpHE7ja7L/m8xHz3QvlDa4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD6mmlmtSv6c+JteR55aurq7xg1oxCWMciNPAB2gOoY=;
 b=BhsG1eDbb/wNyKWPUeA0PPNDiS0TjtroMkx2NnCxZa0VjjhNNIDqUVhIYjfnm+beMkwSkuBbexmPAGL08OZVmqK9Bnhy589AahVjF2ECZA9+beBkG2b3SZa7NCY1Eome0SpIm3I9LAE0Vg7P+65NXxySW0qrgbTncDV0QwDI+B4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:44 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:44 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:51 +0100
Subject: [PATCH v7 4/8] drm/panthor: Add panthor perf initialization and
 termination
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-4-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|DU6PEPF0000A7E2:EE_|MI9PR08MB755481:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c22b20-0264-4349-1dcc-08df27beb694
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: hlnfoGI4sCty7iE5nRYWb03PH3mkhMKmJWQem+bfdCLRDuFn1I2H6hCPe8GIpMojkvtETRtvYmO4xemf8i8XGKWbwUDLinTVoQAKFVKZl4kCBfA+tyopN2h6DFHjQkK/3mEXyHc7IpkOqmKx1AG6FaZtXxHw/7BlBfM32enStd1+bfqJxi1CClyXwKF/Z6f4KQ71Eeke9fF7mcQixrTzbZ/PhhjD2Y/rch47mVBUBYtPAqtFovC1/31EYp0qEcp/iLzgkY1k3rvaHwU3IqG4GORRRxgrS8nfCYEJtmTSPaCCbkTg+xVwpkwdLB8ypwuxNHKiiAH8WQEM6txjCncwkqy5MSq4qQBeyCxGMFoJt4Fnp0R/0q11oYNwWxrCSCfySrqH9HVqcdGWWorCJfNZV+CvdP6xwzGPSUzOG7VWYvOecs/O50X2K28cTNLhIkdVPQgj4/eDHro3p4L3crqzTfc79pnBGsAtvQZNLMrRnss3JgWvXZzufHjWkRSJ1gIomn28VkhZTJvnxSXtXUVsb3DkKEK3NTneo1pflm8fAfEt9xO+sdc6BDmj+xwSN51Q8OpxGxWQZ5BQyqJX+jOs0qWDFWfHLC7NdX847RyNYn5F64A8bbaTp6/SXCR2c+eHGsfY9q5l3JKuOc6NNdp10F9wzrqqitUQXM0apfBVhBURH6A/GvbVD2U1PEZcJrQdh3Qpb6JjNVKDn0NJqSrXMQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: s7UNe1graTp6Q3W7iykcYpG2N70Tove8R6IbgAeP8XvvbHF02TeCte0uUeSDpWyScCUXCp6MoVIRi3sCD2DXAlklCyiOWRyTVjxDtfYwrWn6IW/Z2Bn9hvx0TfKPbMSpZzKgY1vRMIEx8gP4mv9/qVKuBJgOlfAgjAm6c8bklwTn+9bjbsGPp+M4gY4xlQvkhbt68+kh7navDMIQdbJ2eyfOnPuEQoFckTkT4a4u2hG4GPFyNOLcHltrsCa5FQQ10iFAEZK6JPchCK4+dgUNSABHTlf2E0X3H6fZnNW+aVeIZ1xkxjMSXRDNgQMxqPeL5FN7OFQaXjmUi/d3ClhvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 97a9edab-b024-42cd-3be3-08df27bea2e6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|7416014|82310400026|36860700016|1800799024|14060799003|23010399003|6133799003|10067099003|18002099003|22082099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: r9Jm090yTjVLeZxFZhTtNIuW++FTi3pwuy2FSXybobpRPQjJSMgA8dlxJ+njfrqFDTdAEnunSRH6b7DAWG3Bd6R+JM08UvUi1fNGBPxAb0aYE1tP8BIlaoVSCjuEJReH5jkf1w41VK5LN7yC4cLjIm3m5yf44jTgxNmnp7B5LVs0mH6Lsy91ect7QspZm6HfefoJIkKZijz2cx1p4+JSL7DK5tLUy0Oo1AMqyX32dH6K5i/QiEURLWlX1+H2U8O0g7n2Oy6hADVCwQA+B9KjGNGClu1nwhusYjVFyLUZo/kgCwqQ/y6Y0eIcTRPoy+FoSgntmY8H0nqgN+XyX/frv/lC75mNr3QABt5mpmLkO7BfigNdHnRiuKtq4vzsS6hJWZ65RMcG69BrAS72/1HJPfheL+DGtMAxZOr2TL6CJqlTUILtvxdexXMs4g0dgxn+jBRz7fDarL8qNZbJS4aWyE4JTGpVFbpEIQT+KMKpLwH8jYv5agRrQ0nHflmG4bxVDnwIq3QGwr8oHqR65s/RhzGRYSI/ZLG/yPw07JQs0UMcUtqPrzeir+OApBCvdbwiU8frVNdbaabv/1lIaekfXth0HImcpVHJBgI+CN2ObI5xhjyTm4JbcN1U7xTF0tuHtDggmOpcLhNIE1l1ycsWsZ0xb3t7e6Ae6oEd8HlMsq9h34NfxzerjQu78eenXOFqxHcFKS8Q+Zw/EzlcAPsCf7dPpPM2XHPqZ96fP2SZTytYuS8Ze2QRMVrMeNkcP6p2
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(7416014)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T52DKJ0J5bUUDOssz042ESbSz5zhwpdI/YgTYTXAIK55iPf6i44Un0gNC1fR5vcS0kS1bg/7eNElscWkCaT0OaaWbM4277gCcURQRfYlU9cDc85tNfbl2hFOH37qaZl21pcziXR8sXFI/Lt2mz8Fnqi9g0smWc7tG/u2DUgDxtv7AqNYQY/ZhZkR3E/Lcu8daJUpGEo5+FyycRc0fSiTXgChUyLKJ/VbhtnByietiTczTR3WjrKCuPn4zsPd9vaHW4efXCeUemrGGTsnsEXsrj5m5BrXYb6IBM0Nv21Oxrassq8+TX3bKevlahTciPUsCsyA/4MtabcuybFE+rCWDvEwFlDe3DqGimiK4tvnrCO0BhcKtX3dxp8lVo0oxqqPW5hefHy0NzQE+5p9GJC/QhQSEet8aaewrF/BU3rz2poj/tk7ykB3oUzfI/2HTfIg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:16.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c22b20-0264-4349-1dcc-08df27beb694
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB755481
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

Added the panthor_perf system initialization and unplug code for
subsystem-level handling in subsequent patches. Userspace session
handling is done at the pfile level, via a pool of sessions.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  2 +
 drivers/gpu/drm/panthor/panthor_device.h |  9 +++-
 drivers/gpu/drm/panthor/panthor_drv.c    |  9 ++++
 drivers/gpu/drm/panthor/panthor_perf.c   | 85 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   |  6 +++
 5 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 2877d47c6717..535383ef629f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -95,6 +95,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
+	panthor_perf_unplug(ptdev);
 	panthor_sched_unplug(ptdev);
 	panthor_fw_unplug(ptdev);
 	panthor_mmu_unplug(ptdev);
@@ -310,6 +311,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 err_disable_autosuspend:
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
+	panthor_perf_unplug(ptdev);
 
 err_unplug_sched:
 	panthor_sched_unplug(ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index d93b182a3d9b..085254a60fc4 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -29,10 +29,11 @@ struct panthor_hw;
 struct panthor_job;
 struct panthor_mmu;
 struct panthor_fw;
-struct panthor_perfcnt;
 struct panthor_pwr;
+struct panthor_perf;
 struct panthor_vm;
 struct panthor_vm_pool;
+struct panthor_perf_pool;
 
 /**
  * struct panthor_soc_data - Panthor SoC Data
@@ -323,6 +324,9 @@ struct panthor_device {
 		atomic_t recovery_needed;
 	} pm;
 
+	/** @perf: Performance counter management data. */
+	struct panthor_perf *perf;
+
 	/** @profile_mask: User-set profiling flags for job accounting. */
 	u32 profile_mask;
 
@@ -377,6 +381,9 @@ struct panthor_file {
 	/** @groups: Scheduling group pool attached to this file. */
 	struct panthor_group_pool *groups;
 
+	/** @sessions: Perf session pool attached to this file. */
+	struct panthor_perf_pool *sessions;
+
 	/** @stats: cycle and timestamp measures for job execution. */
 	struct panthor_gpu_usage stats;
 };
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b6b55b0f2ff5..3e62142d7ebd 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -37,6 +37,7 @@
 #include "panthor_gpu.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_sched.h"
 
 /**
@@ -1635,9 +1636,16 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 	if (ret)
 		goto err_destroy_vm_pool;
 
+	ret = panthor_perf_pool_create(pfile);
+	if (ret)
+		goto err_destroy_group_pool;
+
 	file->driver_priv = pfile;
 	return 0;
 
+err_destroy_group_pool:
+	panthor_group_pool_destroy(pfile);
+
 err_destroy_vm_pool:
 	panthor_vm_pool_destroy(pfile);
 
@@ -1651,6 +1659,7 @@ panthor_postclose(struct drm_device *ddev, struct drm_file *file)
 {
 	struct panthor_file *pfile = file->driver_priv;
 
+	panthor_perf_pool_destroy(pfile);
 	panthor_group_pool_destroy(pfile);
 	panthor_vm_pool_destroy(pfile);
 
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index cbfe1ca5872d..ba466e22c50d 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -3,7 +3,9 @@
 /* Copyright 2025 Arm ltd. */
 
 #include <linux/bitops.h>
+#include <drm/drm_managed.h>
 #include <drm/panthor_drm.h>
+#include <drm/drm_print.h>
 
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -23,11 +25,26 @@
  */
 #define PANTHOR_HW_COUNTER_SIZE (sizeof(u32))
 
+#define MAX_SESSIONS_PER_FILE 1
+
 struct panthor_perf_counter_block {
 	struct drm_panthor_perf_block_header header;
 	u64 counters[];
 };
 
+struct panthor_perf {
+	/** @info: Pointer to the previously initialized perf info. */
+	struct drm_panthor_perf_info *info;
+};
+
+struct panthor_perf_pool {
+	/** @session_range: The number of sessions supported at a time. */
+	struct xa_limit session_range;
+
+	/** @xa: Xarray used to manage session handles. */
+	struct xarray xa;
+};
+
 static size_t get_annotated_block_size(size_t counters_per_block)
 {
 	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
@@ -74,14 +91,82 @@ static void panthor_perf_info_init(struct panthor_device *const ptdev)
  * panthor_perf_init - Initialize the performance counter subsystem.
  * @ptdev: Panthor device
  *
+ * The performance counters require the FW interface to be available to setup the
+ * sampling ringbuffers, so this must be called only after FW is initialized.
+ *
  * Return: 0 on success, negative error code on failure.
  */
 int panthor_perf_init(struct panthor_device *ptdev)
 {
+	struct panthor_perf *perf;
+	int ret = 0;
+
 	if (!ptdev)
 		return -EINVAL;
 
 	panthor_perf_info_init(ptdev);
 
+	perf = drmm_kzalloc(&ptdev->base, sizeof(*perf), GFP_KERNEL);
+	if (!perf)
+		return -ENOMEM;
+
+	drm_info(&ptdev->base, "Performance counter subsystem initialized");
+
+	perf->info = &ptdev->perf_info;
+	ptdev->perf = perf;
+
+	return ret;
+}
+
+/**
+ * panthor_perf_unplug - Terminate the performance counter subsystem.
+ * @ptdev: Panthor device.
+ *
+ * Release the performance counter hardware resources. The control structure is
+ * released with the DRM device.
+ */
+void panthor_perf_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+
+	if (!perf)
+		return;
+
+	ptdev->perf = NULL;
+}
+
+int panthor_perf_pool_create(struct panthor_file *pfile)
+{
+	struct panthor_perf_pool *pool;
+
+	pool = kzalloc_obj(*pool);
+	if (!pool)
+		return -ENOMEM;
+
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+
+	pool->session_range.min = 0;
+	pool->session_range.max = MAX_SESSIONS_PER_FILE - 1;
+
+	pfile->sessions = pool;
+
 	return 0;
 }
+
+void panthor_perf_pool_destroy(struct panthor_file *pfile)
+{
+	struct panthor_perf_pool *pool = pfile->sessions;
+
+	if (IS_ERR_OR_NULL(pool))
+		return;
+
+	if (!xa_empty(&pool->xa)) {
+		drm_err(&pfile->ptdev->base,
+			"Performance counter sessions active when unplugging the driver!");
+	}
+
+	xa_destroy(&pool->xa);
+	kfree(pool);
+
+	pfile->sessions = NULL;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index 3c32c24c164c..ad01fc88f18f 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -8,8 +8,14 @@
 #include <linux/types.h>
 
 struct panthor_device;
+struct panthor_file;
+struct panthor_perf_pool;
+
+int panthor_perf_pool_create(struct panthor_file *pfile);
+void panthor_perf_pool_destroy(struct panthor_file *pfile);
 
 int panthor_perf_init(struct panthor_device *ptdev);
+void panthor_perf_unplug(struct panthor_device *ptdev);
 
 #endif /* __PANTHOR_PERF_H__ */
 

-- 
2.43.0

