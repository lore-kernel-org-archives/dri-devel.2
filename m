Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FBEC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C14210E2E9;
	Tue, 22 Sep 2026 20:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="UAK7PgFX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UAK7PgFX";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4C210E2E9
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:46:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gDU66RCMzrFrEFMD7kZRAwVCTk/7Ho4QV3v1JAVcivwKi78RGT/WoAwkmstRfAVMFSAL0k4ymqBkRljDlKovww9+o2Fb/RzHnVLyoK5OknJM2vwyYSCsrUNtOKiUibnvtwMdIGRJNYkyhPXpMt92iq4IQqeXYiE+WrYh1GKpJqvX6LPyUzlO8G9UgHktgtYU5CDyy8d6SAQsRBu3cWsjJHeHmdz6vsXjfBRFVtVTiGeAypokNAF7XeDv698zzKy9m2k2EqId+fr4f8B91ry0jo1wC5KVJTeuw4NPXV/ocVKaPStuD5AvPVmB6r51ISTI2g7ipnaq8DsTkqMesEkilA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGav47lB3rxBs9sbX+pcOifYQnZe+zp2A1/NHM1WpGw=;
 b=o7aeoOdLnkFIh51wT0dD+sBFpN4x4ngN1HMFKkbwsHf1TQCmSKq23KuzLY3gSb7R9XG0WrK8f+kxNRurc2mXemQA7e0CXEktFODxniyEiDzLw63xD8uVF9OgQViGbq/4LI493IVvt4jIYNb7vmqx9aaiHF6gqV5N2DWhUpLg6Kn9lcIaZuSDWL4SNqslQtWT455S9PeAhjHEEWbukml6ek+tbvOAaGWMF1pt4Vnyy1gNFGN+byZ8eh6KaNvz3fagJcVM3S5jqhbqxodwP2xVMGv4532BirSFgcKblWlXQP19FkGU1uZMNsENBs9BpIkua1lavGzsqZ3dNov2lNVXiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGav47lB3rxBs9sbX+pcOifYQnZe+zp2A1/NHM1WpGw=;
 b=UAK7PgFXYAYFstOQION13YHZxFvpNmrJ2xwrZpTB9uofIG+BDxqLRn6by4iWowzfCLVofc5q0Y+TuWjTXwx7lPsWO8RjDObX8EExU3b+MLxAvEofPRJw6qU2jAwYQByjeD4fZNNauGAjEV0JcwLouWtJgizN/kbpQykiLnHKa5c=
Received: from ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::11)
 by DB4PR08MB8200.eurprd08.prod.outlook.com (2603:10a6:10:380::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:47 +0000
Received: from ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
 (2603:10a6:910:40:cafe::99) by ZR0P278CA0132.outlook.office365.com
 (2603:10a6:910:40::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 20:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUG/+kNX5GmQMV1vkv5YsXxqvESHDADXZLUROdhLifxtkdVVKXeFWsq9td3KdYh1KPzOO4rD2p2LlVXwWWKgWUQ0izRi9Ylm6d9Hs5DXGyldxivYjt8rdQ4m5LCTksP7IpcebYrlryK023feONk0nLXL4oFGfVxrr+l4tVivGbEhf28tQGMpWKyPX0z3wcrKfzu+yh0T5O5QKpfy8fwo2WR69CHN8RkKIj4ztsK9nxllk5WyFZtbl3UIJflaBX2AlCm7dWoq5TS1KzeZr46dSkObEbrEgDP+LTu/3QaUXhoHakZcmkwaZ1ih8QRhcZle2BD9V7OV+MHIIWUXqvlBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGav47lB3rxBs9sbX+pcOifYQnZe+zp2A1/NHM1WpGw=;
 b=PaSFcJv2Puwr800y3gftDqbmhbEF77Wc+E3X/uAS3wqqU4ROaCeiKdWIDx5f1k2GYASoHoDixvldM2fxCeYtLqxJsJB30vUisM4xjPDO2D8N0Rmf137J4wKmR6XZKJecdV+XKMIYJqFcYKEiqcu+b3HiGlUUUDUf3vW8HMwZlVyJG2M2LPid33fb+txiB40CPCHTBDwqjtJyZtWpl9WfncJgFnYzRPylNbmDFs4yN9OFyMKO86kTgnllN82of3EjAr0rL8Kd8s5/Ppp5U3bnQHQjALRmiuC3siRo0Y81Ygjd1qj4sfOQA0lccVxlHs2jytaQpEF2+jmp7A8LD4dw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGav47lB3rxBs9sbX+pcOifYQnZe+zp2A1/NHM1WpGw=;
 b=UAK7PgFXYAYFstOQION13YHZxFvpNmrJ2xwrZpTB9uofIG+BDxqLRn6by4iWowzfCLVofc5q0Y+TuWjTXwx7lPsWO8RjDObX8EExU3b+MLxAvEofPRJw6qU2jAwYQByjeD4fZNNauGAjEV0JcwLouWtJgizN/kbpQykiLnHKa5c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:10 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:10 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 03/27] drm/panthor: Parse and store GPU_ID fields
Date: Tue, 22 Sep 2026 21:44:57 +0100
Message-ID: <20260922204535.2850094-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0416.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::7) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|ZR1PEPF0000E6B6:EE_|DB4PR08MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 3406434a-b624-482a-1e20-08df18ea9dfe
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 7jfGMx0lV3dzenuUDfNPvJE+BpO9JXnqoH07N8tVkavZ9BsMUEnPLNNtIopaNZVHqWlz/sC15XoMYk4rHVNJPgQUMl0gc6efl8UVnffslc5Odiy0biB05b+zLuciiaU8mw3vVg9cIayPy6zOaWefABG2Q8/3HngAXixafZPJ81/FjNdNrfCqsvMIatbX4BTanuN2bj78hty0SyA3THGSzbzpCeyHAKW38upaV+NXiE03/a7APlmkt3PRArBldbWaSy9NglbJiz3nJDx43T7Ay9ruLQrrhEmMzMSZttlkCoDzzxA/WYeHFYuka08DL7rsYqejtvo7Zbyy9c/vGHRFxp+3jc1n6Ucm/7D23YQFxjfxntv20bVMKXb4ZxJtWxWhCVHMNZBifDMtp/vrHp36lyhuLvxj3CWrk+Tll844DyFi2zG9UjHL/y0gSI4/MmWOVkkdVCHaLit4azCuHMoQIvWpKpeq4T+0ke56oNhvhabXxOlFAbMT9Y9W8mz1PlAlW1OyT/EYbsgTbQuMrtoyPDrElh62kDW+C8XlmMCmWPzYEXCqFw7mT20Y1DL5YYrNHLCZUdUE+U6YTge0iBwJaI1zhmN1Ic9pfm4yjNL9oE8dYqy6U983CpiVFEOFZ4FbX7N9fRikYUfcVx5wOPulCuobRBRaVo8x7pELs/VmHCY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: s+sZEbJW6EU10IduJ3ZH5ArqnIl4sBX35+mSWx/voV22imJwLeFwv4Cy9B0SJp1e6lKXlDgDlbCPkSB4pwyca4Oxs+xrUiFz9zXEgU15FtG14kNP1GzFtXet92Tk2jDMrdeBaJQashWjHvN26KON61LLD4zd5hL/Re1oCB1vR+7Q6EuQWmd6EZcOD0t9v0Xbv6euxbxlRqzZpad4EcKPrYIN/i8KnGzevvg+iWAlYDSCnKifi5AxKYBlTEHtbHRMCJ72FbUY8rzikF1Jj2mKS9VdkNxnUADZwW977AeXgztm21ao6zUavoLkFLrGBYBXtZfdCjr5k1FkuxxX8sYGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 32749f9c-1c53-462a-0af4-08df18ea88a3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|14060799003|36860700016|35042699022|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: OcvQfEM1FU/wGJ6N3LbFxcQqWUmP8ZWYgu/StP8QN06cfbl1IA+vwpg3CpaQY2WRjOsYJ8fRQOOhkp7idJ1HZMXSe42uif2HTxY2IfE2Cwl3Ag4Lp/3+v7qK+2hHVxdMIc4r8oe6I5cdVGgH/pVTT12TniVYkJ6lvxTeC+nYN2a4suwTp5dHpsTFpYdr5932Ds0K79XnT7RcLt5/MHbRqltl46VYDqYJTto2yp0Ip9+jJmlfhSXQa5P+5dF/rWJCdoYRgs1Qf/4BfwfmVcAV/TBZoBbaxOzkS0lzir4Tksj2zd08q/lJkwzfeMEX5Ggg2XQ3n0SQ+7Krvmkpp9P7VQaUdhGtlSWdFbOYCoY+912cjHjwKBKL+a6ZXALUr+AKCcK9xOZK8tuPjmebiPYAi26LhqBvzw9jb4SIcsG5GjGnADChGyhQKt7cbfhGNdbD9QGFd8xbuHdsrz5kbcROPFdZyy8+c7sM5ikfcyRrJDl+VZJQcIV/2pxJ+4ei9lbcTxzZVjTjsSYsyzYoSh7+IKVPGBnicLrqSAwv7vfk/XJREj6M4ugAPN260XxS/i3VbKCyMlRd0/9V2mRDViTZTyXSMSbNvtS5nKTYpi/ygTXQBsiTmO/HGzYLpfe/pTBPPZYaygl97/Xmrl4TrZD0t12GRbmQjFN2D05wGBQp7wb00sKAYJMuXoeJ4AQ+UCfwlsc4gzBgkT8CYbW16qlqaw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(14060799003)(36860700016)(35042699022)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XqmJLSzaVKtbxATwdmPRB2BmTO8k4yROa2bnSCRRthryHPV0CfJ3t7+w4Waqbv+4dhBlo3FQhkSvAD2wUfFWZfiaYG9BdrFP/z7W+yv970cNNMSXOmz2x4ErjlGTHbHjNaZ8KkhZBZgyu6sYFrN8kC3KyJb1lKf1zw7qvyTC3u0XfPuLxWqQLR8dyTdGdqtAR2BgbpZYPbJI1mHDpbuFLhDWTywPOHQ233H+CGkeq39I68L37nCMnaf5t5Jydr+UvGcpIxeqW3+UkNflljfkkd2l3r1H6G3KlNUPIsdaeGUe1iF+ASSnnLrteVqKiDamFi0K69ux5t3OeaBrUklTlFhO5yYkBogBUekBQKeV5pijOWHB4bbSSsXfN8K3X6Cdh9n/B7rtupyoyJQ2jghE82PcLLtNRdw3zHKJOy6tHHevc9hz75xaHY5SXaaziMjY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:46.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3406434a-b624-482a-1e20-08df18ea9dfe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8200
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

Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
layout changes.

Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
once during hardware initialization. Convert existing users to consume
the cached fields instead of extracting them repeatedly from the raw
register value.

This centralizes GPU_ID decoding and makes it easier to support both the
existing and v15 formats.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- changed struct panthor_gpu_id into a flat structure instead of
  inconsistent groupings.

 drivers/gpu/drm/panthor/panthor_device.h | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++--
 drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_hw.c     | 26 ++++++++++++++-------
 drivers/gpu/drm/panthor/panthor_hw.h     |  3 +--
 5 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 54031c5252473..ba93a100ceda2 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -110,6 +110,32 @@ struct panthor_irq {
 	enum panthor_irq_state state;
 };
 
+/**
+ * struct panthor_gpu_id - Parsed GPU_ID fields
+ */
+struct panthor_gpu_id {
+	/** @arch_major: Architecture major revision */
+	u8 arch_major;
+
+	/** @arch_minor: Architecture minor revision */
+	u8 arch_minor;
+
+	/** @arch_rev: Architecture patch revision */
+	u8 arch_rev;
+
+	/** @prod_major: Product identifier */
+	u8 prod_major;
+
+	/** @ver_major: Major release version number */
+	u8 ver_major;
+
+	/** @ver_minor: Minor release version number */
+	u8 ver_minor;
+
+	/** @ver_status: Status of GPU release */
+	u8 ver_status;
+};
+
 /**
  * enum panthor_device_profiling_mode - Profiling state
  */
@@ -169,6 +195,9 @@ struct panthor_device {
 	/** @mmu_info: MMU info */
 	struct drm_panthor_mmu_info mmu_info;
 
+	/** @gpu_id: Parsed GPU_ID fields */
+	struct panthor_gpu_id gpu_id;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13bf..13efed3a2ea72 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -809,8 +809,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
 	int ret;
 
 	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
-		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
-		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
+		 (u32)ptdev->gpu_id.arch_major,
+		 (u32)ptdev->gpu_id.arch_minor,
 		 CSF_FW_NAME);
 
 	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101ed..ade2646e2caf6 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -73,7 +73,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	if (!data || !data->asn_hash_enable)
 		return;
 
-	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+	if (ptdev->gpu_id.arch_major < 11) {
 		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 4c96573b649a1..2143e57d48106 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -119,9 +119,9 @@ void panthor_hw_power_status_unregister(void)
 
 static char *get_gpu_model_name(struct panthor_device *ptdev)
 {
-	const u32 gpu_id = ptdev->gpu_info.gpu_id;
-	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
-						GPU_PROD_MAJOR(gpu_id));
+	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
+	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch_major,
+						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
@@ -245,13 +245,13 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	major = ptdev->gpu_id.ver_major;
+	minor = ptdev->gpu_id.ver_minor;
+	status = ptdev->gpu_id.ver_status;
 
 	drm_info(&ptdev->base,
 		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
+		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
 		 major, minor, status);
 
 	drm_info(&ptdev->base,
@@ -273,7 +273,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 static int panthor_hw_bind_device(struct panthor_device *ptdev)
 {
 	struct panthor_hw *hdev = NULL;
-	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	const u32 arch_major = ptdev->gpu_id.arch_major;
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
@@ -295,10 +295,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
+	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
 	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+
 	if (!ptdev->gpu_info.gpu_id)
 		return -ENXIO;
 
+	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
+	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f797663893b2d..bdda3b10e660a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -5,7 +5,6 @@
 #define __PANTHOR_HW_H__
 
 #include "panthor_device.h"
-#include "panthor_gpu_regs.h"
 
 /**
  * struct panthor_hw_ops - HW operations that are specific to a GPU
@@ -58,7 +57,7 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
 
 static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 {
-	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
+	return ptdev->gpu_id.arch_major >= 14;
 }
 
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

