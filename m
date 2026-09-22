Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA6C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C5C10E782;
	Tue, 22 Sep 2026 20:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rJxPGo9M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rJxPGo9M";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6539D10EE64
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:11 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=elQbbMOO5Fs6la0rk8dnQtbt7zklQTPbVqgb54OVpWSAR9hqlxR2hZYUtVjH4p5oVxNMS4Q6fkW7LQIIqlIXUSuoSF3nucC8cHRQWca5oJDAVrPDYEyrEcS13wD7pxx5OI+oKOPz0PJulgx/lW/7vNoehNxaoVl3+MWwYdbxsvbvj4g5Si1f//8hZqk3G3v/f0rxyc5tbuwyC5KN8So0875QDqw5TqqlEtCmb5PoFQGTuYuhWImFmhqkkHEd99J2KM38Yz10GpEZF3O5UM574ORpc47IxMU1yu4Tgs+vVj92i+J2X+iwqw8RsPChj8NbGs7JOogBuSNAX/yKgHEW3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7XIj6UgR9genQilsHXaROT2459uobPhBSmMHHrzV5U=;
 b=KRWCdc+HuSyi0VYuSoiiIk8WthfLQiWBFK+y+lPz/hdEd+wE3sYHW+lWTvIj0lacdxzIJ3gen4kJd5/5Kb6B65nKEzboEKS1dlAfrJJgTGjHuaiNC6nUElpLx4OkwBvGNuhDte31FjVXie9tkp7QGOJv5yPU2EBPy3TtCkbEqAyA29qmpFK8C9bcCEVMj0CxZSsCsz2hZ7fwMcNMrW2yWs3px4zDBT85IhTaTjkykCl3awRBXT+k8zIXX04KbOuuJTKJKOfjNNZ654fxtFE25QCGn6vDBvjTlsmGD1zOVC6t04LC+I3aDB7d3qTwaB9uyu683ZCXQyAMjmgiApoW5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7XIj6UgR9genQilsHXaROT2459uobPhBSmMHHrzV5U=;
 b=rJxPGo9MVuKAod3L7TB4/X+28cI0pNt24i3vuBjWKFfQnxYcxCRg9BoeBLX5g6AkFOvv8DAbgYInziEbxzeeXBdAexEmRYdBoYCWcDMbrHUEspLx9ngcAm1sDR91zE8ujDhTHVcjUF4wPLFsNTQAjbxe/Dfi+QAmxJHQ7Mdyays=
Received: from DUZPR01CA0344.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::9) by PAXPR08MB6527.eurprd08.prod.outlook.com
 (2603:10a6:102:156::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Tue, 22 Sep
 2026 20:48:02 +0000
Received: from MA3PEPF00000406.eurprd04.prod.outlook.com
 (2603:10a6:10:4b8:cafe::3d) by DUZPR01CA0344.outlook.office365.com
 (2603:10a6:10:4b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000406.mail.protection.outlook.com (10.167.241.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYleMGpN7wCVHq4MlCxMk0lZUWDKbP6RXA0HkY4AugXv/ccVi+EdV4R8nu55zrdSsSMB+4j+CvxOmyq5G3QfBaPR5jnOBZWDLZZJrCp/3bmY3LnyIwm9/0qyeXWwFyWD83mrOUJvb58o2sD2blzakyf6tq+yIIo4tGgeGGMpwvEyi+I/7wJ946Tq5/Vsn9PDi0bbjxpAXw8+7zBRfISDdC4HcEm6U47DSQXBeOVs/qsjKipL2mXtKMuRa/sHRjgpiIuQ1uAaodAnZs0uOASe+VQa4GExNgxkIiYnd3x9Fso8O+wwBqj6bZrzSCXo6I4YjfQcKDEU/GBCAGNIWbRWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7XIj6UgR9genQilsHXaROT2459uobPhBSmMHHrzV5U=;
 b=DstSY9carExd89OoHcDDgbePu19vTNhUzN9Oo3V6tEn24IpY4N5sdbl3QBwfR+NqpdnVkdacSDQJsGVKgHfbJbmQj1AU2U2pzPInNE/ljkch53b5AEaaxai7kkrfyZ7yUEAGc5F3mHGBNkLuoMM9CzYI9yICwy8fsdwQXssqW0xNjLLOgspgSMh00fjTTHtZPHebzPVwNgxw2adH0PKr/MFCgNrC1y+31n6H35XsGg9uUB/vyF0sadOJufeAhHuMFOR/zhriGh1huOe4ze3EhSRfDAiBCWsxZl3B1T960BkL7PtTAomgZjCPGINFeFfK1hX38wbnVyju4DBBujCHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7XIj6UgR9genQilsHXaROT2459uobPhBSmMHHrzV5U=;
 b=rJxPGo9MVuKAod3L7TB4/X+28cI0pNt24i3vuBjWKFfQnxYcxCRg9BoeBLX5g6AkFOvv8DAbgYInziEbxzeeXBdAexEmRYdBoYCWcDMbrHUEspLx9ngcAm1sDR91zE8ujDhTHVcjUF4wPLFsNTQAjbxe/Dfi+QAmxJHQ7Mdyays=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:29 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:28 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 22/27] drm/panthor: Add access-window support
Date: Tue, 22 Sep 2026 21:45:16 +0100
Message-ID: <20260922204535.2850094-23-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0540.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|MA3PEPF00000406:EE_|PAXPR08MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fd19a5-5412-437c-5351-08df18eacb38
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: /kznXf5YQs125UjRpDJYLuWC8QuJUzi6xqSwaf/94tAGZHgXmvv65hMqDBOcCY09ZjoDi44etdeIygye7SilixwsYLr2i2Su6rEZ2YKjFHwI2+L8LfVvU0fBmGFPEEP4lpeVqBgLSHaYcWORQA6L7o3hBjHkKwVFn63/Q0vjzq9lc+Z3KqyAwrc38N2AvQ706SdLaWXxTKfHjkWyD3uNRGVS8iMLKaTqp+Kq4ukbg68nT/bVDERfcdygpCRXtTkyYjnLs12k7OWWjhH1HkZpRZpxoILRgD63ZLz1q28A45T4SeWrSCuoVCKvNu8eAMjRcbpA1M6q0I9fURwXmbKjXfkWIdUTKAJJT4l06d4PIXM54KE44SxFS1TuEvg6pjxHrqBhKdZCj1gaUv7ij0osqUepgJKlCbYlbXHXG+A2fz3mTiD7u/QiOZK+V2Oj40y3nyfRg2LixqDhHLTxqeyqd5IRjGaQNm8mg+N0QaQRpaEGGLB3uFk3tY2aMFdrGytUIDz1hqUNoGFL6g4QwN8JlgLXcBOazSKFg3O8FbbjTNHRKID82Tnp0gw/q6Bxd/ynnPv49HV4GR/LQ8L7JrxEOzmCIGXXQZ7GDnIuLlFl2m4NBFLSNef6dMJvsbK034c9btPf3IyhlSNhA4qIB+xS690/+vZoH2hZktGD1p17uPE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fUh/B5MuK/xBJhQhYTi4TVtmgKHLQAWQLIHyjcxbgqUgXfBts9hpskiot0zyIT/tvOaNDzIbExsBvm4tMY4e+C1f1E3RdO/98x9PwcnhzzItymaZ8RmEvIKvRaG3VVPVVig8FXmY66OivN/FlAZwwC8Bl0bhbdFYgzEXGM+dMk6rtDNx2irpXd92XoQ4ScTL1C8uHnZb7uj4tz1lSuAW2NViS3anaR2fEST+B95ny3l02LgxcJD5XjIv21DtwGe3e6KTq2odECWi0b9SXe4gXisjcpPAr95mDmeisu7PgJieD+nBop8BaFIM34NmfbSvNZFp9axTd4zbhdfpmPbtlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MA3PEPF00000406.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c14c91ae-4a16-4651-4ecc-08df18eab6c0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|36860700016|23010399003|376014|1800799024|11063799006|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KgYMDVVMtLsaxQ6SX2Iobr+DOyHXx3QPDdAn3/O5jDn8vfyd4OYhOd514XPGPg9yUu/ViheQnbMKfnEB9ATe+8BeWdu1UQmiXZaBhCjiTTEpJQ9A4q/bX56OxtE2Y5y+quR3HfPTKX3szKhUbmJRPuhWZH6NmSSpH3AHnF76tFGBZ9pzRT3nvHKtrCTMF9AKr5Z4AxF4GqGHGUPsOgk2KQ8FhMd9+SfT7pjMw5V26YnndOfuWRVPAnbPAR8lqa3jxsf4dLeJZ0h82+AjZ4HCbXqKzMtONszWsGRMfkqSHRvkEsGMf4G17kdUUp36CVdJSG2uG1L0oHfNIwmO4+ZyMKeCfdhva+4EbW+3axhO/Pb15wKwypVkG0ohnFYW5umBT97sJidew4ui9Kx2PPpVY+N1mFoMixCS8MjvO5KnsG3KgLpsVWuItPaapXFVzF4p5NuZMmHi7j8UAKkSivaCqE5egN9NMnZVbQNWJxRnijdW63NMEzwa9IkI4WS6oZklyNwEyXKvY7HY/aC5Js7cgHLCSK1fV5QERo0c3HOd/n1S6e4OSnxcgDroDAMlcKpPW+99ga28svASd+EFasyHVLIAeHgtmfym+RsGhUuuE4v3iSr8zuBs6BCJ/UDyZEcz6Xh483xBAqoMCEP13t4LVuHSj4F5iBARH6qLsLuJnzX9aoSvpJ11Z+sy4vfu2T3/L+XDnG0ymO+HOOqDsBZEoQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700016)(23010399003)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w92lyoeaphdnQgh9iiV7cuLcWwLEQCNRATRicnpNvlY5/ewsk72s4lRhakqufZyG93UIX/sNOAMj2Qr2fH0PlhoLZA9sUV4L9rENe0GsBaYGyxiYdVNR2AqMhNFVtePunbyXa8N6fkCT52zNWjvHCSox7NvI8aAynvx/RdIP1nG632MK0IlXvdHug+pJQ/SPbm99UYSugJQUKTMruxFW9uNIo8cy1oeHGK525LFXHuJLyutaSNHywh4ApQU+2+P7M0qypmtqOf977cLyRYQWclsacOIjjlphlLM4SYsLtpEbGF3za2dySMNpyPVK9d6eY5roW6AHttGtVa5GA7vZkCZgvtVsnm8Rj6b4Fnf8SfGp0t9zgIi/4OPKWLsbzo0alo7KXvCYL/WL50yk6yiQjRrlmLDcIiUkVUbEbOTuI6oUOzeAoN64JcrSBmdmC2vc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:01.8889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fd19a5-5412-437c-5351-08df18eacb38
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000406.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6527
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

Add the VM-side access-window component for v15 GPUs. The new code
handles AM message handshakes, requests GPU access from the arbiter,
waits for the window-open interrupt, and yields access on suspend.

Split panthor_hw_init into bind device and initialize gpu_info after
panthor_aw has ensured GPU access.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Adapt AW IRQ handling to the updated IRQ locking/state interfaces and
  reuse panthor_irq_suspend().
- Handle -ENOSPC from AM message sending when the outgoing FIFO is full.

 drivers/gpu/drm/panthor/Makefile         |   1 +
 drivers/gpu/drm/panthor/panthor_aw.c     | 416 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h     |  42 +++
 drivers/gpu/drm/panthor/panthor_device.c |  15 +-
 drivers/gpu/drm/panthor/panthor_device.h |   4 +
 drivers/gpu/drm/panthor/panthor_hw.c     |   8 +-
 drivers/gpu/drm/panthor/panthor_hw.h     |   2 +
 7 files changed, 481 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 5d4d0ae64952e..aa48212653dc3 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0 or MIT
 
 panthor-y := \
+	panthor_aw.o \
 	panthor_devfreq.o \
 	panthor_device.o \
 	panthor_drv.o \
diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
new file mode 100644
index 0000000000000..848fd64eb51b5
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/platform_device.h>
+
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+#include <drm/drm_drv.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_aw.h"
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_hw.h"
+#include "panthor_sched.h"
+
+#include "panthor_trace.h"
+
+#define WINDOW_CONTROL_BASE				0x0
+#define WINDOW_CONTROL_SIZE				0x1000
+
+#define WINDOW_STATUS					0x43c
+#define   WINDOW_STATUS_IRQ_WINDOW_CONTROL		BIT(0)
+#define   WINDOW_STATUS_IRQ_GPU_CONTROL			BIT(1)
+#define   WINDOW_STATUS_IRQ_GPU_POWER			BIT(2)
+#define   WINDOW_STATUS_IRQ_JOB_CONTROL			BIT(3)
+#define   WINDOW_STATUS_IRQ_MMU_CONTROL			BIT(4)
+#define   WINDOW_STATUS_WINDOW_OPEN			BIT(31)
+
+#define WINDOW_INT_BASE					0x440
+#define   WINDOW_IRQ_MESSAGE				BIT(0)
+#define   WINDOW_IRQ_INVALID_ACCESS			BIT(1)
+#define   WINDOW_IRQ_WINDOW_OPENING			BIT(2)
+#define   WINDOW_IRQ_WINDOW_OPENED			BIT(3)
+#define   WINDOW_IRQ_WINDOW_CLOSED			BIT(4)
+
+#define WINDOW_MESSAGE_BASE				0x460
+
+#define WINDOW_IRQ_MASK \
+	(WINDOW_IRQ_MESSAGE | WINDOW_IRQ_WINDOW_OPENED | WINDOW_IRQ_WINDOW_CLOSED)
+
+#define PANTHOR_AW_HANDSHAKE_TIMEOUT_MS			(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+
+#define panthor_aw_wait_cond(_aw, _cond, _timeout_ms)				\
+({										\
+	int __ret = 0;								\
+	if (!wait_event_timeout((_aw)->waitqueue, _cond,			\
+				msecs_to_jiffies(_timeout_ms)))			\
+		if (!(_cond))							\
+			__ret = -ETIMEDOUT;					\
+	__ret;									\
+})
+
+struct panthor_aw {
+	/** @ptdev: Pointer to Panthor device */
+	struct panthor_device *ptdev;
+
+	/** @iomem: CPU mapping of WINDOW_CONTROL iomem region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ data */
+	struct panthor_irq irq;
+
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @state: Current state of the AW */
+	atomic_t state;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to resend messages */
+	struct work_struct msg_retry_work;
+};
+
+static bool panthor_aw_is_open(struct panthor_aw *aw)
+{
+	return gpu_read(aw->iomem, WINDOW_STATUS) & WINDOW_STATUS_WINDOW_OPEN;
+}
+
+static void panthor_aw_state_set(struct panthor_aw *aw, enum aw_states new)
+{
+	atomic_set(&aw->state, new);
+
+	wake_up_all(&aw->waitqueue);
+}
+
+static bool panthor_aw_state_try_set(struct panthor_aw *aw,
+				     enum aw_states expected,
+				     enum aw_states new)
+{
+	int old_state = atomic_cmpxchg(&aw->state, expected, new);
+	bool res = (old_state == expected);
+
+	if (res)
+		wake_up_all(&aw->waitqueue);
+
+	return res;
+}
+
+static int panthor_aw_state_wait(struct panthor_aw *aw, enum aw_states target, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(aw, atomic_read(&aw->state) == target, timeout_ms);
+}
+
+static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(
+		aw,
+		(atomic_read(&aw->state) == PANTHOR_AW_STATE_READY ||
+		 atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_GRANTED),
+		timeout_ms);
+}
+
+static void panthor_aw_msg_retry_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, msg_retry_work);
+	struct panthor_am_msg *msg = &aw->msg;
+	int ret;
+
+	ret = panthor_am_msg_retry(msg);
+	if (ret == -EINVAL)
+		drm_warn(&aw->ptdev->base, "Send FIFO unexpectedly empty");
+
+	if (ret == -EBUSY || ret == -EAGAIN)
+		queue_work(aw->wq, &aw->msg_retry_work);
+}
+
+static void panthor_aw_send_msg(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	int ret;
+
+	ret = panthor_am_msg_send(&aw->msg, message);
+	if (ret == -ENOSPC)
+		drm_err(&ptdev->base, "Send FIFO is full");
+
+	if (ret == -EBUSY) {
+		drm_dbg(&ptdev->base, "Pending messages, scheduling retry work");
+		queue_work(aw->wq, &aw->msg_retry_work);
+	}
+}
+
+static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw->msg, version);
+	if (ret == -EOPNOTSUPP)
+		drm_warn(&ptdev->base,
+			 "Msg protocol version less than minimum supported (%u < %u)",
+			 version, AM_MSG_MIN_SUPPORTED_VERSION);
+
+	if (!acked) {
+		u64 reply = VM_ARB_INIT_MAKE(1, aw->msg.version);
+
+		panthor_aw_send_msg(aw, reply);
+
+		/* TODO: Handle AW restart */
+	}
+
+	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_INIT, PANTHOR_AW_STATE_READY);
+}
+
+static void panthor_aw_handshake_init(struct panthor_aw *aw)
+{
+	u64 message = VM_ARB_INIT_MAKE(0, AM_MSG_CURRENT_VERSION);
+
+	panthor_aw_send_msg(aw, message);
+}
+
+static void panthor_aw_handle_message(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	const u64 message = panthor_am_msg_read(&aw->msg);
+	const u8 msg_id = AM_MSG_ID_GET(message);
+
+	/* currently only support ARB_VM_INIT */
+	if (msg_id == ARB_VM_INIT)
+		panthor_aw_handshake_handle(aw, message);
+	else
+		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
+}
+
+
+static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
+{
+	struct panthor_irq *pirq = data;
+	struct panthor_device *ptdev = pirq->ptdev;
+	struct panthor_aw *aw = ptdev->aw;
+	u32 status;
+
+	scoped_guard(spinlock_irqsave, &pirq->lock) {
+		if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
+		return IRQ_NONE;
+	}
+
+	status = gpu_read(pirq->iomem, INT_STAT);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & WINDOW_IRQ_MESSAGE)
+		panthor_aw_handle_message(aw);
+
+	/* TODO: handle WINDOW_CLOSED*/
+
+	if ((status & WINDOW_IRQ_WINDOW_OPENED) && panthor_aw_is_open(aw))
+		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+					 PANTHOR_AW_STATE_GPU_GRANTED);
+
+	gpu_write(pirq->iomem, INT_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void panthor_aw_irq_suspend(struct panthor_irq *pirq)
+{
+	panthor_irq_suspend(pirq);
+}
+
+static void panthor_aw_irq_resume(struct panthor_irq *pirq)
+{
+	guard(spinlock_irqsave)(&pirq->lock);
+
+	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);
+}
+
+static int panthor_request_aw_irq(struct panthor_device *ptdev,
+				  struct panthor_irq *pirq, int irq, u32 mask,
+				  void __iomem *iomem)
+{
+	int ret;
+
+	pirq->ptdev = ptdev;
+	pirq->irq = irq;
+	pirq->mask = mask;
+	pirq->iomem = iomem;
+	spin_lock_init(&pirq->lock);
+
+	ret = devm_request_irq(ptdev->base.dev, irq, panthor_aw_irq_raw_hander,
+			       IRQF_SHARED, "panthor-aw", pirq);
+	if (ret)
+		return ret;
+
+	panthor_aw_irq_resume(pirq);
+
+	return 0;
+}
+
+static int panthor_aw_request(struct panthor_aw *aw)
+{
+	int ret;
+
+again:
+	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+		return 0;
+
+	case PANTHOR_AW_STATE_READY:
+		break;
+
+	case PANTHOR_AW_STATE_INIT:
+		panthor_aw_handshake_init(aw);
+		ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
+					    PANTHOR_AW_HANDSHAKE_TIMEOUT_MS);
+		if (ret)
+			return ret;
+		goto again;
+	default:
+		ret = panthor_aw_state_wait_transition(
+			aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+		if (ret)
+			return ret;
+		goto again;
+	}
+
+	if (!panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_READY,
+				      PANTHOR_AW_STATE_GPU_REQUEST))
+		goto again;
+
+	panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
+
+	/* Wait for GPU to be granted */
+	ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				    PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
+	if (ret) {
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_aw_yield(struct panthor_aw *aw)
+{
+	panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
+
+	return panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
+				     PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+}
+
+int panthor_aw_init(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw;
+	int irq;
+	int ret;
+
+	if (!panthor_hw_has_gpu_discover(ptdev))
+		return 0;
+
+	aw = drmm_kzalloc(&ptdev->base, sizeof(*aw), GFP_KERNEL);
+	if (!aw)
+		return -ENOMEM;
+
+	aw->wq = drmm_alloc_ordered_workqueue(&ptdev->base, "panthor-aw-wq", 0);
+	if (!aw->wq)
+		return -ENOMEM;
+
+	aw->ptdev = ptdev;
+	aw->iomem = ptdev->iomem;
+
+	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+
+	init_waitqueue_head(&aw->waitqueue);
+	atomic_set(&aw->state, PANTHOR_AW_STATE_INIT);
+
+	panthor_am_msg_init(&aw->msg, aw->iomem + WINDOW_MESSAGE_BASE);
+
+	ptdev->aw = aw;
+
+	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "gpu");
+	if (irq < 0)
+		return irq;
+
+	ret = panthor_request_aw_irq(ptdev, &aw->irq, irq, WINDOW_IRQ_MASK,
+				     aw->iomem + WINDOW_INT_BASE);
+	if (ret)
+		return ret;
+
+	ret = panthor_aw_request(aw);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void panthor_aw_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	disable_work_sync(&aw->msg_retry_work);
+
+	panthor_aw_irq_suspend(&aw->irq);
+}
+
+int panthor_aw_resume(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret;
+
+	if (!aw)
+		return 0;
+
+	panthor_aw_irq_resume(&aw->irq);
+
+	ret = panthor_aw_request(aw);
+	if (ret) {
+		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	panthor_aw_irq_suspend(&aw->irq);
+	return ret;
+}
+
+int panthor_aw_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret = 0;
+
+	/* suspend hw components directly if AW is not supported */
+	if (!aw)
+		return 0;
+
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_READY)
+		goto out_irq_suspend;
+
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+		PANTHOR_AW_STATE_GPU_STOPPED))
+		ret = panthor_aw_yield(aw);
+	else
+		ret = panthor_aw_state_wait(
+			aw, PANTHOR_AW_STATE_READY,
+			PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+
+out_irq_suspend:
+	panthor_aw_irq_suspend(&aw->irq);
+	return ret;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
new file mode 100644
index 0000000000000..c2b89caa87c48
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AW_H__
+#define __PANTHOR_AW_H__
+
+#include <linux/types.h>
+
+struct panthor_device;
+
+/**
+ * enum aw_states - Enumeration of possible Access Window states
+ */
+enum aw_states {
+	/** @PANTHOR_AW_STATE_INIT: Initial state, prior to handshake. */
+	PANTHOR_AW_STATE_INIT = 0,
+
+	/** @PANTHOR_AW_STATE_READY: Handshake with Resource Group completed. */
+	PANTHOR_AW_STATE_READY,
+
+	/** @PANTHOR_AW_STATE_GPU_REQUEST: AW requested for GPU access. */
+	PANTHOR_AW_STATE_GPU_REQUEST,
+
+	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
+	PANTHOR_AW_STATE_GPU_GRANTED,
+
+	/** @PANTHOR_AW_STATE_GPU_STOP: AW is requested to stop GPU access. */
+	PANTHOR_AW_STATE_GPU_STOP,
+
+	/** @PANTHOR_AW_STATE_GPU_STOPPED: AW has stopped GPU access. */
+	PANTHOR_AW_STATE_GPU_STOPPED,
+};
+
+int panthor_aw_init(struct panthor_device *ptdev);
+
+void panthor_aw_unplug(struct panthor_device *ptdev);
+
+int panthor_aw_resume(struct panthor_device *ptdev);
+
+int panthor_aw_suspend(struct panthor_device *ptdev);
+
+#endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de3505..98c0dd3ce7bcb 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -16,6 +16,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -100,6 +101,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_gem_shrinker_unplug(ptdev);
 	panthor_gpu_unplug(ptdev);
 	panthor_pwr_unplug(ptdev);
+	panthor_aw_unplug(ptdev);
 
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
@@ -259,10 +261,18 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = panthor_pwr_init(ptdev);
+	ret = panthor_aw_init(ptdev);
 	if (ret)
 		goto err_rpm_put;
 
+	ret = panthor_hw_info_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
+	ret = panthor_pwr_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
 	ret = panthor_gpu_init(ptdev);
 	if (ret)
 		goto err_unplug_pwr;
@@ -322,6 +332,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 err_unplug_pwr:
 	panthor_pwr_unplug(ptdev);
 
+err_unplug_aw:
+	panthor_aw_unplug(ptdev);
+
 err_rpm_put:
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index ba93a100ceda2..960e06236fc03 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -20,6 +20,7 @@
 
 #include "panthor_device_io.h"
 
+struct panthor_aw;
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -201,6 +202,9 @@ struct panthor_device {
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
+	/** @aw: AW-specific data */
+	struct panthor_aw *aw;
+
 	/** @pwr: Power control management data. */
 	struct panthor_pwr *pwr;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 9d539f5f80158..0bbd102fa1890 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -350,7 +350,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	return overload_shader_present(ptdev);
 }
 
-static int panthor_hw_info_init(struct panthor_device *ptdev)
+int panthor_hw_info_init(struct panthor_device *ptdev)
 {
 	u64 l2_features;
 	u32 major, minor, status;
@@ -463,9 +463,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	ret = panthor_hw_bind_device(ptdev);
-	if (ret)
-		return ret;
-
-	return panthor_hw_info_init(ptdev);
+	return panthor_hw_bind_device(ptdev);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index e5bcb908068cb..8972b510287a4 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -65,6 +65,8 @@ struct panthor_hw {
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
+int panthor_hw_info_init(struct panthor_device *ptdev);
+
 int panthor_hw_power_status_register(void);
 void panthor_hw_power_status_unregister(void);
 
-- 
2.43.0

