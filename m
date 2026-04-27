Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B86FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE12910E80A;
	Mon, 27 Apr 2026 16:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hmpBgJ0U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hmpBgJ0U";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A691110E80A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:01:07 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DQvIdyRQPqVlcZEK9ABq+BjUkZFYvSQ4HeNAgKZjLRK46GFbg0ILnwW8g3oUqNG5CXNps//3inFrIivYYa/QS0jg/oyJM8kNvusmVgpaD3kYg3wceqlaF6NBZ600qkQBWJ6OlAQOGGSBHE3eXfyuejSY4Nx2KO46rc5ZSQl3BdTyRBx69sIL5UIMyXa2qkn9uzT1KaqO4rjNls2BDKEAAJUJx0CXu0RlUER69By038r9QWhCGzuleE9JP5iY8elRQ/1EU2eim+BcBHEn86CeJu2HBV/I6MboTKhawtNKStBBZxc6gl1/q8SK/RQ3koZvGgiz6pk/b9kDgEaP04A46A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j8qFuUDuj7mI3iEKQ6YdzsRm/bgu1CF2lLizWYBrfg=;
 b=rX3Kds4TZFQWJf39aVUrXJFllZam3fUIjM8tK3RWfUUr+6fRAOC0LDUihVKnh9y99dvtXtmONUQKzg1lAeNfMXevMMqPPxv0JekSq2z/3GEr1pn0ywkvgwzV/zBRUwo2ZAWyZOCfT4DZBCTrI70jvf+lXW+W8beEw9lT2JLDSc/0SFqpR2oVztOADeuHfqY8popQAT0L5VZ1XpnnwdeFYv1aLU+zVnY1psIzJiDN+4JseizoRvtk9jxGoq+f1sRHBdCT7oZH2r/C1EDu1W6dOv5Eb77tKQAxdV/XyqQjJQqzavv9GCD23JENbq7IT3dMjZlfGXAABshblTK2KKjxew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j8qFuUDuj7mI3iEKQ6YdzsRm/bgu1CF2lLizWYBrfg=;
 b=hmpBgJ0U0i+FBvq1TlQpu/i5qcFskkeKTqPyxcnh8L3yvt6/k8w96yLXMwz3+gZBbQRN8fNQz3rQrQGN2xIVCiXeLuqCjugXQuun/hU2xbk3p6R3CMzpGeTbl6uRh0RdKUifP0/twWZ5dLrsHy0+AEOKgTNebG8n8L0Pei2S4n8=
Received: from CWLP265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::15)
 by GV1PR08MB8034.eurprd08.prod.outlook.com (2603:10a6:150:99::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:55 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::a9) by CWLP265CA0497.outlook.office365.com
 (2603:10a6:400:18b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCTxwwGVSN9ezusyE/PNxtuRaK7LvFen3l+JXaKFvN+qtTPLpxkOMHpO8aVBsgHOSUrOYSo4PWOIlKX0NZeYToMVF+SdPeHRit5XjSQC6vxgcO6XGI6cAaBWpHogeka9Y+UvCMhXYcUmB0LSCUuCk3qRaFez6Qbkoc4ODjLwYjYNZflQ1k9mdPOmAUFTBSumfQ9aKv2aLVkQioMLTVL8qxy2obJYX4LLT38xi1F7EzE3JBAh+Ei6FoSIvFrvtPfaSga+b0ZFYvRG3fpDtolfzDUJ70ZI0gMAOS2FT0AOHKORt+KDjRi65D/U4R3TCbQStJg0b1gBA6haesmqjMmxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j8qFuUDuj7mI3iEKQ6YdzsRm/bgu1CF2lLizWYBrfg=;
 b=DnRhIArpLDmjFjGwIZI/hvJp8W+aJpXJEYR7dX3pXVNVTVpAtYBqLWMZT/qBATxTI7GRhLHXvfAiDCi9d1YofzRuIp6sBrwdn7QAz1DpTZ9pnrJp0Mopq0LhkGKVrbllVeR+q9rQrVXaCNu54dP1d/tiCWAwkTKFVRvAtklgmnAGqzsxlyQ2NkpRWWr4NnmmhiuPG9IL1oe4acTLEtcS45/OGwnK053gwstZOXowuCiW2HB1r5LtHhmRD+UgB3CAPNjrhCAQDFQGQIY+Yx+O1aFL7UkCW5eYGgAI60h0oqYMRbWnlmsc6O+HbA1YjuXS8DDVgeeaUra8h7vnouMADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j8qFuUDuj7mI3iEKQ6YdzsRm/bgu1CF2lLizWYBrfg=;
 b=hmpBgJ0U0i+FBvq1TlQpu/i5qcFskkeKTqPyxcnh8L3yvt6/k8w96yLXMwz3+gZBbQRN8fNQz3rQrQGN2xIVCiXeLuqCjugXQuun/hU2xbk3p6R3CMzpGeTbl6uRh0RdKUifP0/twWZ5dLrsHy0+AEOKgTNebG8n8L0Pei2S4n8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:52 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:52 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] drm/panthor: Use a local iomem base for MMU AS
 registers
Date: Mon, 27 Apr 2026 16:59:34 +0100
Message-ID: <20260427155934.416502-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|AM3PEPF0000A793:EE_|GV1PR08MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 374112ed-fa52-4a19-dfb7-08dea47629dc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: eJf0uIkJiwn8nX0F6aqIEZC71bzgrGeKX21d5fOsJ13UzYGnA1KUuBweOyAtcIrYScV80uJx5QppqGMgAc4kWa8uFyHCwbm9sUn7ROPGJcKd0+qohRj2avv6YFbCCiL5wN0Ff3/0/UXlDo1XVtrpZwnsu5hBjkRUEbhwn3faDMSQXgM1vFvvWucw6Z+OaZjkGdTQGkruH/1KntKp+1KucCQPCk2tMEWRbcLnUr/ZpUayyUsHR/WBCTfssbKtTxQpNEm6X/ws8WLStGpUQFnOpUiqI2JUXsHpZBJY3VIq0ng36dBGj5IiFM7rYpQR+HcKzni/gNa9e41aZr/aMW22VbTW7BEZN0s3LG7774igYvFTmEWYntTWm/D9ycRXcLCdZ34hHDqIRdVwpNJXXHru8nzgaabrmouBabY5R+e2+3Wml3mND3CA4SIGv1S47CNt4DGU7SWQ/grZlyfrcJb0owo8z9EdHfX5JhA+dJmMZoVIUJ/yywFBJzCgprwED1EQoW3lLKvhxhhoV3azrMKEfV0B12zqbOOTDBoY4xzy53PP0OpjxwKUKCLyiOzQQk8gk3wOGhTQLeyziQj/DmtcTa6hSkKKSJ9MlwhWzJdC9GNsAVNaSecuz+Ji7F4afyWPjfDI1Y8MwpPbXVZ5Tam7a+6szSlR/Kr6vq3DMFJk8pc8JbkizyuwGen19tK+J8q4xBZ5DesicMwKLkqbbOiAPtjraVByl2UnW1ZE4cqLuzc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bKX/Ws0SoLF3mpZ3EA2PgXSsQqPQdn8/mljrDyE7l8bWtolIActgc6sZAy8R1lmT4ZGDuLp0dESVplqjHWJPMKs74WzQviqUSjBLCq2y2drrubMzQCz7FE9q2fKVNQyXC6nyXMonDA0ocSl+MztuoRioxKbaPEEObkHt+0IUmVlr6dFPUMBW7mcr36HGEA9yzk9OcXvQTDlKzLKaQPtfjNyt5DOT/3xCed4ly4wuNk8/+s6SYu0UuCTawoB2BLA/z6OkcbnbP65N0QND+ra+xG1wtBPQZbSRSLS5NTZFSiVUNDghUBYueh8gF8JsUs8WLGHUZvZlrOCYn3pFtPcdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbd8edcc-e2b6-4bff-e6e4-08dea476048a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|35042699022|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q9M1bFE4DZoURaQNuIKJheWA3IXqIKPgZc8ADJYQp4xDeaPiZlyOhYTvQcnsgVjv0rky74kykKon16yITaoiYiiPkiaA3sH/UghlCILAzWgIVyPyFnREJuzRelbdipooIK39KHOKovN2UcdGNsCw3PVyLQH0xsYqpxyiDISQRxluHnr1ppsYJWWBF1J5l/05Tp+h6avdIV2uHMN7yrKi6b/vj45c5fZFPeZwvPiUq9TiFOy+YwEE2YjNmctR7KjoRucH2Tt/EIDBTjt3tUYgWIqKN5Q3Vs0GQr76zo3TbtucYV0/g4riThsMtY8elYdrIYRCePLiMF6CHxYwK2uoofKuHX+6CXTVx6BUDjRvBTl0ppxUVeNSFuWLQ3VEYP2TwaK0jIrhxpPcTe56Nlno2qo4Kwp2R5idq6e97qONnwPRrzhH6c+2nNKIc/6DVshHF5xnuJRa7c13LuuL0S2Ju9CDLmzMA2cgZxdXsHFYPLZdzfqrYpOnrEvbbMPP6IvYS/4LH2YXJK/S0qMjZXwF1n39tzbJ+4gHN/hxYSHbw2DKwEg6wTwjdyxt9naa+PmR0uxZ2PJE1+wAF8cTnpNqVqstHEBzE/ETdePKBRVRMmXj+CR5iyEIgwxQE+RXwDTJV1Mna0xOCZg28ZQKc8bqO5tKlDFg80h0wN0GdqlyaK7Nii8SvhBIFE1FyDFWgOMx40hKn022QC6US26byXwIo3AWzqLkZ6Rf4PHY3YoJZapMC9DI//AcILsJz37UBIogSxn0/KQOEnAziCUNeajwAA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(35042699022)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bVVOunwxwBKgwumNDwco/KgY8ttr3aziJRY0U9BJgO1DA5aRipW+iTH/UfVT5VjBVpzDqH18p+ymUF3+E6XDx5T9chHNoP+DioGO28iTdag5YMjV7Z/uAkd3nW3WMiyeC1CAQcAMaJ9bFZQzpTB5MpXXGsaQS/5HJpOaiPboGI81EU7dS9xvoyy6hXBHs9EqfUhS2aBW08YN6i76RlPCJTgk4daGf6sdpQs79c17iu8PTFEcZlu2+clceuS5duAgMGQfpw36hPpGcz0+58gP0n2dnbPVS0vdv7I4P7WxZ3wHa/lSxSqYNMSbTQ5QYqkH+JNpGE+TU4Cs/itx6nJUOhLVhtCu0JtnNmkg5ZPE0gDS/M1yg4kSoPPqq4FFEOTQ5Hgyy2iyEGuvSUGAkU7JSQq2UWIdb6ojsRLS/6bvOIz9qDWzLhHz3bnHKYRgtc0R
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:54.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374112ed-fa52-4a19-dfb7-08dea47629dc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8034
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

Add an MMU_AS_CONTROL local iomem pointer to struct panthor_mmu and
switch AS register accesses to that base.

Interrupt accesses remain routed through the IRQ-local iomem base, while
the MMU register definitions are adjusted so AS registers are expressed
relative to the local MMU AS window. This completes the conversion away
from using the global device mapping for MMU AS register accesses.

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
 drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 10 ++-----
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 64d53e7cb763..a7ee14986849 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -55,6 +55,9 @@ struct panthor_as_slot {
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
+	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -517,13 +520,14 @@ static void free_pt(void *cookie, void *data, size_t size)
 
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	int ret;
 	u32 val;
 
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -541,7 +545,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -589,12 +593,14 @@ PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
+
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
 				      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
+	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -602,6 +608,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 				  bool recycle_slot)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
 	int ret;
 
@@ -629,9 +636,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
+	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -784,7 +791,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 	 */
 	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
 	if (ptdev->mmu->as.faulty_mask & fault_mask) {
-		gpu_write(ptdev->iomem, MMU_INT_CLEAR, fault_mask);
+		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
 		ptdev->mmu->as.faulty_mask &= ~fault_mask;
 	}
 
@@ -1731,7 +1738,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1780,6 +1787,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
+	struct panthor_mmu *mmu = ptdev->mmu;
 	bool has_unhandled_faults = false;
 
 	status = panthor_mmu_fault_mask(ptdev, status);
@@ -1792,8 +1800,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(ptdev->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(ptdev->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
+		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -1824,7 +1832,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		 * Note that COMPLETED irqs are never cleared, but this is fine
 		 * because they are always masked.
 		 */
-		gpu_write(ptdev->iomem, MMU_INT_CLEAR, mask);
+		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
 		if (ptdev->mmu->as.slots[as].vm)
 			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
@@ -3240,6 +3248,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index de460042651d..4e32ab931949 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -8,16 +8,12 @@
 
 #define MMU_INT_BASE					0x2000
 
-#define MMU_INT_RAWSTAT					0x2000
-#define MMU_INT_CLEAR					0x2004
-#define MMU_INT_MASK					0x2008
-#define MMU_INT_STAT					0x200c
-
 /* AS_COMMAND register commands */
 
-#define MMU_BASE					0x2400
+#define MMU_AS_BASE					0x2400
+
 #define MMU_AS_SHIFT					6
-#define MMU_AS(as)					(MMU_BASE + ((as) << MMU_AS_SHIFT))
+#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
 
 #define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
 #define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
-- 
2.43.0

