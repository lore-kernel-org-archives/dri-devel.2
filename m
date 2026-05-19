Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B3CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3921310E558;
	Tue, 19 May 2026 14:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mpzR+jZd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mpzR+jZd";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D61A10E558
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:11:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JdK79mxR/Zvxk8FrbV2rieqvvRtIce3gQ4LpbO4W6F//9UhzFIsLIq5SSgQQjfiqH8URNABOBzy8uDQFvKAXjvhy7ZlvXLyU8YKjm8Rd6CsOtw6zEh2c0tgBoOl6E6DSJpak2GeAAkaF7yEMpyGzToBjzYVUR8RGsDn3HcCPe2E2Zpy5fD8kB0F0IV8NbYhFoon+UctkqXBUIywc8l8CXPRLFYpZQ/aH6AeW3xh6SvXtc02coCWnBJc/d3tUiy77pTQSvdIFWJCqwmDEu59zl5trO6coyeCWhZ2k+XRy1TJp1zRSkKe2nGJ/ejTMMT2BTHQnOt/ViXRgvn40u5vHdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVeHNoDWn7iWUy6TuALWxxk4E8VGQG2H5OUTDtMjpHM=;
 b=xuTz80wEcLnxVW4QijeWH94VtYrUCNyziowzGQoN++dFBSHMThoLcPDq8V/Xcaj7A7mYWNcp6MG8msw1Zb/IgQ3cwxVuHNVT596BqbK4yLDWj3zkBrbgCyqjc+0Ik2TZKDjrRLJbxauPItad09vEFjBM3o6tjxf/dmwtDDMOG/SfwonZ61amV2/IHBLGZ2HWo7KbkDoTX8yIzg0CF5vC2FVveqhScry+HeRi64KxKOltD4Q0rKUgpsD9RhJtlOml/3qbrYuAXOB3p6U22Upd6YW0uOK1Q5UpMx2j/MeM5fg2UKISK/Y96R26RXHwY5Ff9PHenEWW+ttrQvUnimkhNw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVeHNoDWn7iWUy6TuALWxxk4E8VGQG2H5OUTDtMjpHM=;
 b=mpzR+jZd2yS+YtOAQ7sPPpH/Aw8N5ifmrFJNa3hgbLEybsYtU34oyXXJbCIq2OuirawukqfxDPaXpM3vUPEnY8qpil27fZrn2q0CMBlNADHP0l2+NHwPOPIr9d/3NP7FnIIj0CmeMqSLV1qLj0sqlTwk9c/+hekpxN2biRyXVbw=
Received: from AS8PR04CA0203.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::28)
 by DU2PR08MB10016.eurprd08.prod.outlook.com (2603:10a6:10:49e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 14:10:55 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::36) by AS8PR04CA0203.outlook.office365.com
 (2603:10a6:20b:2f3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 14:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 14:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHjj7aZXuuYiqaV6YR7zHoZnaZOjMM+obpbtkfvyHV71x1KTP/bod42b6Y6ZqrDUPceSWXm7NP6wcu9jFsSrRsPy5ZPiFJfdmqQuEKsfZdjfNyixkhBQwWFzDQsutY6o/iVpAmZJVIOwZOIUpZiJdiEbeR/ffQ0s1P3EatcSfc5l71gSxf01wK866I/t+R+kMb34CqLARW2fdyAT89IN3dXZFZCRdcD8PTXdxWYamOy6XqzE1EMgYwwa9fuCDmuS37e5Vlg3mYEUvYtEhWkCo6aZtrJnEuhgqq35lgqo9NrH6V6Qc2bL1UB6t4VRYOnGtzcjE3HCix2chG+0AsBOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVeHNoDWn7iWUy6TuALWxxk4E8VGQG2H5OUTDtMjpHM=;
 b=PpEibO+YSzXA+gHX0l/Z3cWDBHXIMt4aMHErsSj8I/4F7O57eZ0nuiVwczzVWjHZwbvCJP+4MhpIhfPcLNNl5yIxgOcFeauuVW//it9xeuVedCuPY/Ud7u9SRVfe2ZC91r0Hj3i5qc0HADD+WjpOKSkeg06nRy7GK1wwsz3YOrrt/uA0EgbcYj4XyV7VseGG7QMp/7tNwUiEldM0t17mT27lMtk0zwBLB3FTrIJWDRZeL52S+vD4Rq4smaaikisEfL+CNngMiXAB+mYKYPWKf7+85vrJQl/NIR5AMHw9adJp26CL066+PbUNsSfDXym6jvt5pqnj7Ryyq+2p52XN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVeHNoDWn7iWUy6TuALWxxk4E8VGQG2H5OUTDtMjpHM=;
 b=mpzR+jZd2yS+YtOAQ7sPPpH/Aw8N5ifmrFJNa3hgbLEybsYtU34oyXXJbCIq2OuirawukqfxDPaXpM3vUPEnY8qpil27fZrn2q0CMBlNADHP0l2+NHwPOPIr9d/3NP7FnIIj0CmeMqSLV1qLj0sqlTwk9c/+hekpxN2biRyXVbw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAWPR08MB10209.eurprd08.prod.outlook.com
 (2603:10a6:102:365::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:09:52 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 14:09:51 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Bence Csokas <bence.csokas@arm.com>, Daniel Kiss <Daniel.Kiss@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH resend] drm: uapi: Add macro for chipset specific event ID
 region
Date: Tue, 19 May 2026 16:05:48 +0200
Message-ID: <20260519140548.28853-2-bence.csokas@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0429.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::20) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|PAWPR08MB10209:EE_|AM3PEPF00009BA0:EE_|DU2PR08MB10016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d052d74-22fc-4d67-b97e-08deb5b0714b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: qgAEJ3H48+RUPReafObFRdlLEefTb+XjCOAgo53lndZkuFEeztzustG/f6utv00eR5ToJO9et1ik5s+CrFUSylgRUojdNyDNNhYbYjDuPlxFn3MHLubL9p0hwpUwshayQNtNxs9kvFNEm9LflIGxq3RK8oj2ELJIxYLM9vAu3WpPFnyMe41zv29UTufCLe6yzj+R4xjH23EU6VkXKS+EXq3o65GzxQUjrfy2pcoG1Oe9/75+hZw7njUuhYffMDm0nFMH1YzkkqwBDAxtAVl+f74FYwVDBgo5JJuMIEPD4cWNVxAYTGeBOz4SsFGpdz+offbhfrIbAv9wDnRYFBuSgIue/Mkj8M1iDXVd4e8duV9QZHRJXdFaeMS9QFEXo/H+h2MCe2DYoQVHIj7aYkApUNXBPtzSuBgBtoQSB4ECs0BSmRL+iZ86qjrvojgWUCbrJmbcQokHeOMZVxImqZiX7JIvCWmZUHzh7Uto5N/LZSPBeoOcOZO7bDsE/H9BWfThM4Mzl9iUwuOFworiFkjfMQm5hdE+8F/rLYEAqgUIeUl7ZvO3nFkHbEVOVk4LR8XBrl+dd7/w3/dOzoTvEkAdCqZtVYY/TJ61ujUBj7d7pAM9d3iGT8W9ZEkb7Wr8jLYG/o+D0hdwgEHjGj1+oW+A7A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: B3rm3+dYcTb7Sr1D9CcDuOuIuwlcFRbRLYb/5YQxdYVtPlwQ3K4N5TrWdoLW+088lwYfGDl9abFqHkkPDxbe1zz4/sIzT0CZv9LdbKRzgRX4em7VyvgIRVo6xfM9LlBP4OD/uBXEOcUtqRNjnXzlaOl0JGrRwC1JNFSgnbFv5RA0pHsEsS+TQuuHXm7XmOh63eDfTMo2vkaekDOoNfc5E2TfbZTpkVPtC4jRpCEvZUnKIplBvr4r+flUOFL3R+kv+KtjutLW66P7UXifQkmbkM5ndtkLljQP/pYFIWiMBgcAuOmUtjTPRpVsNyADLCmJT/pwdBwKqruy4t1FWwWnNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10209
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0deef6e9-25e3-4ec8-3707-08deb5b04b52
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|36860700016|82310400026|35042699022|7416014|376014|18002099003|56012099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: Wcw3uWByz4ogflU3tLofQ0ImXot6OQHHy19kFzqyGcY/pH7bpeQXH3VvqR1NDcGUWkA4DiY4CE8U8AhBCQcT3fTmO5IkmWs6rczenHamEzloC+Mi2jSQ2MkOzj5a2XeKsetD3WzhkFpdPLJy9E2YQQGw121IlnKZNib4wMMScbmbEAKJbCnTYOoiNMHqzgaGgIVl+8ji5tOfTDtPUz7HReAsWvKOt89kIUKfY9XSJ1BOyg6fcD/dMDOXW2x3TDeurhzKZ1QHwBCWRMsRahTq3h+UEyCnDJbQuaOBeU+5wNKvh4HCkM37V9GgCmvwJbEbHt8oazSGoSJbKhbVQ5WDZVLpqsKYk2zsP9u1deg3MVc+bOfp1a8/mVeWS+YK6iqgTUHZohuW2RHC2GTHoGiwrv1EyK+QVepQhb5KEO4HpWHU6wggqDNz3DHOfERsuGoD5vb2iViZbfJto04JN8IIoIUm0UULKzU5hWiVaGSjDMOPIRyTYA8ytl1q2bRMkL1PffYjtJEYoGQbRiwGuJRz2cAwMhUVRPN4oZ9A3iHqAosR1US+4Rh0CJ1jEAuFQksF3abrSz++tqn9yGrNXAkDBgUiVKIUJra8NgjL41fPdXEJC0UjwaH1cjLrkS3sPv0A6DXsDLO3Q7IVx/O9krNtk6X7QPtiild0TK3A86FdKCAAAwEF6nDeNNujr4U9z88D
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(36860700016)(82310400026)(35042699022)(7416014)(376014)(18002099003)(56012099003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bAeWsYVvkBUpKs4uY+pQ/CLuH+t0N0zXNwszdLkfqDxJHhnvKhwHj9/ANhwLAwLECWRsnR8Qu0C5KaKMDfoQxt9NS6oUb7bzIjN5Uje9UjMvXEaKvsBYrg4e2gMS6UntRBxQ/Zk3sb4JZO3Bg8kMO8xQ97/cNHqwuNm14H/Uq6zShFOrPOuuUnrvqKCKHQBohBI9Pf9ZN3lTbwkK+8dKwOlzghNJJkQ+2fGQK8mr6uNb0TRThuvkr6YcQXSVz2OqF0Dq+ANRYRFHnlm61lmiyw/kn8CzKwRzbk2nDgm1ZNgIRjceL04l7UFUQBc1rs5I5TxPRARmZspI3xRyyEktUAY4GgUIv+QExSopUvWgNqNWhjQmm9jah8hGp2XtPlFxG/qlX47/vd+7+N5UbolXQRJJ3iiY6KU1DMbnWDna98hwht/mU+tCiDGFWK+DKXfu
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:10:55.1925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d052d74-22fc-4d67-b97e-08deb5b0714b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10016
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
Link to v1:
https://lore.kernel.org/lkml/20260408163608.361826-2-bence.csokas@arm.com

 include/uapi/drm/drm.h         | 8 ++++++++
 include/uapi/drm/exynos_drm.h  | 4 ++--
 include/uapi/drm/virtgpu_drm.h | 2 +-
 include/uapi/drm/vmwgfx_drm.h  | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d27..aa745e643ef4 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1419,6 +1419,14 @@ struct drm_event {
  * The event payload is a struct drm_event_crtc_sequence.
  */
 #define DRM_EVENT_CRTC_SEQUENCE	0x03
+/**
+ * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
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

base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.54.0

