Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E49BF459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727B710E9A9;
	Fri, 10 Apr 2026 16:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rGgNmGlX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rGgNmGlX";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6C510E9A5
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:47:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HBhYdjcSaQCDQQHbWIsOT2vmWA6CluCDE7RoC5/qnyiMgjwMyNw/Yu32pVr5YTqUmOiiLlKKb85TIFw9aOF5T0H4bmEykw78rIligz21/OggLq6ecYAgsviOaBRZE8xWqTWKwHppF/s0fwNbim8fFXc6qlAhTFsr9ihXLgPuxyX7XA12Lnz16bkvAQRn25pUhu45eNwTIh53PT3aOvXrYPTQ8hBpNkeEk7R1MuJCgT9QeL/bfLbsFTP+ShcFWXbuDd/Kn/nOMqBuAY20feha/y85IA3TASzZqZTFsPKHLaAkav5Fd5wkQmnkv3rp+Q4kU5QphwB/2T8JZHQtBCbk4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZZh+teO6vYP5sM3MFuktrMK4KOp/pjvPSnkYBT913E=;
 b=Y3jIx9h2/JfqBHcmQXhRrx2vmYQywmhiPguzNFFB5wyu9Ok1t4A0tnLJEbKrg2Ke7p+YIRGqpU5QlnewjWQyqJxhlS1/43RNJOCoa+xPdxezlInVdnFXbsewQLl4/EHHOCwOSL/d6IKtpmxPDKFIOJABzZJ/vjriJQtxw9ZeMiC7OqurpLeP0aMdrOQt59vddWyiX6mTMqi9DPpzqGxzBloqF/Osv+siDPKBNUGGI0oKL02hZXnR916DjUFQZMqsF0yWzV8LW/QdDT7V5Pc9LgqFSin4Gik7xkfDGZHge2xTVzuaMmiGkp0/+UT5hzXpcDd3hGLUsFcdo/ID2Qy15g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZZh+teO6vYP5sM3MFuktrMK4KOp/pjvPSnkYBT913E=;
 b=rGgNmGlXNYbo8gT/akpwLSrmMVXhOxYvpNvE8/v2RNUPcim9DtmpLy/b/kyYh9EzvP7c/SgD1ppfvBXS7bYKwIBhMo9amCKwkW17xNLWSBb3ejVMtuGnDfidHVR50Zp8ZTpyyqcXEnMo5ihB79beeorAOTvquBezthY+Q4pfRaI=
Received: from DUZPR01CA0182.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::16) by AS2PR08MB9296.eurprd08.prod.outlook.com
 (2603:10a6:20b:598::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:43 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::70) by DUZPR01CA0182.outlook.office365.com
 (2603:10a6:10:4b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Fri, 10 Apr 2026 16:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA/s9QGHBrVoJKET1fdrg0Ire6/QXmSE+OeUOdvtGGVWNck/tnXJ/7UCpP9tELzXhFl0XmzR1EtRYoRvAkPq8lNfkdXDneCkGOKmA0pNG/r3yg3VpsvnZRyxAeiVOC1YPcVgvCufZtJsroXpGQXSu5LSUYGtbOO6j8DZg6yGMDHlipbd+pShTwDbVhocwBuhReqTEKG3QygLyMGll8GEKGZVeKlN6bvGWRCTD421XDlTgT06E968qb/hWv3hxN2v/8ZMUZ11WdkD11vMnhRR9b3cOhQ4e/tK4SxOf4PmrTPXxUu8sHTscxXPOV1zYUCFPOu8dASQYI/CrTDLBO3Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZZh+teO6vYP5sM3MFuktrMK4KOp/pjvPSnkYBT913E=;
 b=W3dbyUHfbZ310HopAjcYMr2elfOpRCNVNCZRcaJ82UKzZ8TNUYpda5RNcrfRdVvyvuKv2zu6kKUI0V5RepNSDvkHc6nzpUfnLrCktlINAupLPlM8PH9Lz5SnwJN7oNPpsBfYOmkUFIHRxInntt/CCYIr0y3HujzashIf6RjSkbyXBv2Yi5QH/yFNXZQpWK8hmICgnhew4Bhnpp7OuwkeFW+v0Hdfi5UBi/53rTYWoz3Vxsr9tV4/vS5hHMavZGp8nlMo62/1EmmUK2CnLGq12s1+2R2zImEfSIFIrCa+hEZkGX6JxB0ayai9Z2iN06wZQD5djfVhHeRuCoNr27Vmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZZh+teO6vYP5sM3MFuktrMK4KOp/pjvPSnkYBT913E=;
 b=rGgNmGlXNYbo8gT/akpwLSrmMVXhOxYvpNvE8/v2RNUPcim9DtmpLy/b/kyYh9EzvP7c/SgD1ppfvBXS7bYKwIBhMo9amCKwkW17xNLWSBb3ejVMtuGnDfidHVR50Zp8ZTpyyqcXEnMo5ihB79beeorAOTvquBezthY+Q4pfRaI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:41 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:41 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] drm/panthor: Localize register access by component
Date: Fri, 10 Apr 2026 17:46:29 +0100
Message-ID: <20260410164637.549145-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::12) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|DB1PEPF00050A01:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: 11363e16-3d74-49b4-55d0-08de9720e2e9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: oj2MsE6/9Fl4U9PY+Iax0JX5f8T5Q4VeNMwVM53ppNT5LrmkC5EJspA8IDFoQzz6zMfpUJ/D14CWmYcFRaa26equQauz6Kqspo9N8gtkIpdW50OicnzxlqLWUiwyQ7V7NTqTD5n8R0WmRXAVHCtPJqI6G7vgfWuPanmu4Fa5FknL7/XOv4vVvLpkwcRbF3ydBYeSra+oRp0GJ9jxBVqiZV4lS3zL5dfCuDAUj79n7l3CncJ/+lqAaL6aRy9aZxytyydm3ddy6jNW09/fen5uXuSUydpILdnZ+DTjgw7O+uL5cFQcqtmsZvJOeMhJbSpjRfylMPZYRqKF4Ycit+DX3M0SyeATZeFAajYBo8nkc45/nHBl3YjFtyEx/3k7OrChJJRUHPWW2tjJ2540DPyzZFe1g9RRwVMssuORPMe+EpfSzcNopNayFLjFKRxguZspJ3EfC0/bu5ggaoWVKlr2E4W7yJECraBcu5b+3zYsYs8F84HpeUMjkia6qvLkq1LUKPh5V3040ZF7hb5D+PqqBWNYSR8fIpEgJOumrMOjtUS1AlifcoM0RtFRMGnBGZr3dGU7GRrFn9whvEV4xSyA+GyX5AXgKqCBb7+dg8WTW56vaSUxXm/XwJi0tBBQtyqRHvnMYuNlpbdeXrYMnJBpIlwn7+aFPR5le5lntyJzZRUOJqn8uwGBqsZRMjPenGsaZKY17miPbPOlUs3EzuRsOc1qWaNtl8JYFRh2cGwlJRk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: YG8rw7/luoz6P6iUMcbq6uaxuIDOJQm8SMr3UeZuA5F6i94Lik3i52/VBsYAOul030g0y/QfQi2ah1k785zcVuY4sknX3NTO4EpowJWraoxSsiQaCl9bOSjYi8UlvHI7muxusM5D3p9PsyJEMGFlcWqzYjjLr8tZ+r6STOe+7k6SyeLOuPTR9b1FiWEu3woMky93CUjb/PGyHIiX/RYATFEfXew6t15bj3bjBfpESxPb5VZ+B+66SpBoSb7W1EArypLH+yhVZHqorE27s1k6L5wuDxbkqvKLvfHPRzIzTy2Fl4y1DihJ9J+xyTwgtj4M6VWEYkLllVihUrJXygcv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49beaef3-d6e7-4975-9cf6-08de9720bd95
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|14060799003|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wnOl8KhYC85R+v8aRWfjJ437x/NC9u4qVN3DTR/PpQcgHjeMq+IwHLEuQlcqK+wFQnk2vwSOa3CyjEafoiXcI7yj+CuStp/CIX48I/wwKr9tQkmtXy8prtpvnIuGz9AChj6F9AGEtxA8wPVVR+3Z9khOP9b/eElysKZSHcFF6fqKTx9mImS4yydwzJZZB91PzuH8TpqZ6EeE/x3w/GlSYDNrvHe+shnMAeJ5nl5lmpPdo3d3x1APmPfCF2x0uKZ7/U95u1fZ1BO+oi47AwcvcUKSRwqLf/rKxrfO8U+QuTSi7nLOIC5E7IfB+9NxuRTJuFhoRzTIcuzRb6DC4dsDN1KfD80HZEPkny+09G5/P4Hf6/aAaPTh/ruZlKOM6na0BmjoQHOMvxbQGCWf2iTp7GM8LYPDcpjLEPYOryEu3WevWNJKK6egrlP3/LtCXvuiBIWkg2pPjI30n1t+WFZeRWcb5yPMGMxxvTFkTvLgB4DhQUt+MO14V00iRwh3FOGy/nOOKsKxQ9Ts0XBSF95DAzdXWyQ+SJS8U5KFC3mJsDa58Yz54AWkDxXvu4eqBBAkqR36pTna7rfwE+zn8BMUbk0bsvkW+dcL22QIkg0bIVDbM4TSDBqC04bbNy/Swm5UaSzkO31o0gBgpqEdpmlyNx22oT8ZZRhNZe88AE19xq0uUJ4sVcmqErHw0yUKYdBPkDtAsige96uBj85+wsl7itfOmxR6wRiQldD+txPW9eUXKYxpGdG0Yb52NXgKTEf40/MOMCJg3z/qJGQemtEyHg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(14060799003)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uYST/agtvg9VNIPSc5fOjHtm4NrxqHhSJNKAB89wQ7fcSnjYDmCBjz0xLkkH5YbxTItz90h38KuIWW5SMZ+k/Ul99ne0p6jP8Ca4hxBgood1auwZceIbKSE3hh9SV6Wj2048bg2igBDbyKSUABJF5vrqX9Dcr6rcAPhag0LXjvR80OWTbJkXDkdnDFz6khCJey8lspW+bZLGaoruePQuQqt+4p4ELeOlVSeCJv9jaWXsJfSIOpwhRfCMg+WbmKubWOfg9k8W6yPR+g66nRv6xK9Bix2LJ4K0anoFXfbCq/k7vHmYmumn8r5K8WFPcd0uMHi5hkdh8YkWpqwpxCUQhC/baVFhJO4vI7M42CMshP9vAyQGyMsw+hOdcnY2Wz5Caa2fwNF4uyFRGRE9DBlMozHT7QP6RysyB/z2yxfFa9K4vHPdVGRUR9jG/Ue5A0IB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:43.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11363e16-3d74-49b4-55d0-08de9720e2e9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
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

Hi all,

This series refactors the panthor register access paths so that each
component uses its own local iomem base instead of relying on the
global device mapping throughout the driver.

Today a number of register definitions and helpers are still expressed
in terms of the full device register space, which makes it easy for one
component to reach into another component's registers.

The series prepares the driver for a cleaner per-component layout in 3
steps:
- make the low-level GPU register helpers operate on an iomem pointer
  rather than a panthor_device pointer
- split register definitions and move cross-component accesses behind
  helpers owned by the relevant component
- convert GPU, PWR, firmware and MMU code to use component-local iomem
  bases, while keeping IRQ handling on a dedicated IRQ-local base.

The end result is that register accesses become more obviously scoped to
the component that owns them, cross-component register accesses are
removed from callers, and the common IRQ helpers no longer depend on
absolute register offsets.

No functional change is intended.

Patch overview:
  1. drm/panthor: Pass an iomem pointer to GPU register access helpers
  2. drm/panthor: Split register definitions by components
  3. drm/panthor: Replace cross-component register accesses with helpers
  4. drm/panthor: Store IRQ register base iomem pointer in panthor_irq
  5. drm/panthor: Use a local iomem base for GPU registers
  6. drm/panthor: Use a local iomem base for PWR registers
  7. drm/panthor: Use a local iomem base for MCU_CONTROL registers
  8. drm/panthor: Use a local iomem base for MMU_AS registers

Karunika Choo (8):
  drm/panthor: Pass an iomem pointer to GPU register access helpers
  drm/panthor: Split register definitions by components
  drm/panthor: Replace cross-component register accesses with helpers
  drm/panthor: Store IRQ register base iomem pointer in panthor_irq
  drm/panthor: Use a local iomem base for GPU registers
  drm/panthor: Use a local iomem base for PWR registers
  drm/panthor: Use a local iomem base for firmware control registers
  drm/panthor: Use a local iomem base for MMU AS registers

 drivers/gpu/drm/panthor/panthor_device.c   |  28 +-
 drivers/gpu/drm/panthor/panthor_device.h   |  92 ++++---
 drivers/gpu/drm/panthor/panthor_drv.c      |   7 +-
 drivers/gpu/drm/panthor/panthor_fw.c       |  41 +--
 drivers/gpu/drm/panthor/panthor_fw.h       |   1 +
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  29 ++
 drivers/gpu/drm/panthor/panthor_gpu.c      | 100 +++++--
 drivers/gpu/drm/panthor/panthor_gpu.h      |   6 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 110 ++++++++
 drivers/gpu/drm/panthor/panthor_heap.c     |   2 +-
 drivers/gpu/drm/panthor/panthor_hw.c       |  50 ++--
 drivers/gpu/drm/panthor/panthor_hw.h       |   2 +-
 drivers/gpu/drm/panthor/panthor_hw_regs.h  |  16 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      |  46 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  69 +++++
 drivers/gpu/drm/panthor/panthor_pwr.c      |  93 ++++---
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  79 ++++++
 drivers/gpu/drm/panthor/panthor_regs.h     | 291 ---------------------
 drivers/gpu/drm/panthor/panthor_sched.c    |   5 +-
 19 files changed, 586 insertions(+), 481 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_fw_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_hw_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_mmu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_pwr_regs.h
 delete mode 100644 drivers/gpu/drm/panthor/panthor_regs.h

--
2.43.0

