Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265E606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ib5cxLOa;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ib5cxLOa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82F8112447;
	Thu, 22 Oct 2026 09:41:16 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013044.outbound.protection.outlook.com
 [40.107.162.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A9C10E259
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 15:05:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VnXM9DE1DNIxaxwkRnHoqpOGYXG9+cskjmURX011mZ+QisZLxPq82SY21jm3IcOH8wDSIu9l6kygwvGuBCXEHKcJYKgDq8bwHAPF/XSMVonFGWhy9ROAdG1HaMK13cUhPpe8GOtY1MPhBPyeApLIh7Ih+a31Q1r/VJsBzAHreJnc3/dez7RS/Az9YlO4fMFP47aMJ+iXoQJUbaQ/p+mjXv0MyXH5Z0r2jw4M1G7OciihkUTj+CM9TACBMH24eohKB354J9c/jDyQqO1Ih8vrW1TZm84SyLESEs/IH6XnRDzxMO6vKp9tW6idpFTHtZS7qQAilQgPY7Il0tZ/PgWhoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKFlSosqAUiHOmyO5Bi8/8hAtwGQCcow4Fy0km7Sisc=;
 b=GkC9xD3oHEXTiAc3bbuVyXpNknkbuZ1gc6vW/4t5aS8XkiJU4HBREwdCe65JHfngwyvNO2/cn5tioyb9q2zQWuQmr/IFaJpRbbseB7QoarEK9mLNHNvG6PWCN5haQ+lnwZnQkC66WviiMRRJMJD409JoxviSQwin0a7FT7Gzad/FFk6kDCftOHMMfd9fS47fe4y3yhKRrVeygEukrNgWIel4umCwLOiGnRYvVbrv/un6YpW/BpR/WqEIcEKZ07O6jCnx3gKjubGvzWX7rfOwQqmE3GAiTTwvPNMaou/ZkI4JalZFQAo5kJWiJNM8NOIJhkgNtDs+Ib14eaHyMIPlog==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKFlSosqAUiHOmyO5Bi8/8hAtwGQCcow4Fy0km7Sisc=;
 b=ib5cxLOa1leT47+1U54l4C2VTGxX/m/pxZcqBON2VX/H7TsPhAOVJoOw3L6K9VQqv+S4AiSoJw3IRH7C5QgPqje6mcQgnA/ZCzopVf0+nD4/ZbvUiafR1kuP7LfIX7+duZ1QzC7VWPo2v+oDdyYNian2CeVH9UrdLdMvub1juIo=
Received: from AM0P309CA0025.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::10)
 by PA6PR08MB10441.eurprd08.prod.outlook.com (2603:10a6:102:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:04:55 +0000
Received: from AM7PEPF00000050.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28f:cafe::a1) by AM0P309CA0025.outlook.office365.com
 (2603:10a6:20b:28f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.2 via Frontend Transport; Wed, 21
 Oct 2026 15:04:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000050.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.0
 via Frontend Transport; Wed, 21 Oct 2026 15:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD1K+scAbKcKxpreieoBYEWHnhQxSJjrCuHXCM0WydQiRC/FU3DNzfAxvaVi7YNIDmGAkeCkUk1Z5ghzql2a14a8kh43g5A4lwNL2QABm7dU0Lbh6ptUbkEfeaT8y7g3TWwwwYTjt9y8MEqyhC7Ix3u2EDGtP2Qkp4KIBQSfcfsy9EQ2jKzvj+pHf4fJvQyb0O1xOmURnXUEIxWo+n+NmIjkpQccD/FOOR0rdplFb0/YtMY47E8Y2qkIBLIze4gnCzpfDeWhwkMWwhR5Pfi714PLVB9oKkgDo3Xg6bNy8H+bVavZeho6hEU8GSS9rA5eWjm60QTYDEB8gQY6gqS0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKFlSosqAUiHOmyO5Bi8/8hAtwGQCcow4Fy0km7Sisc=;
 b=mizzcnIZ/mqNCoQ1RC5lAu+x+rEvICjififii7+bTYyf9eiaeart9M32CMO3oygz88Dt9bSlUTuV2RVksh4QaGEuZmJCS+D1NwpZ+0ieTD+a/lg06XsWPu9qzs8CSKYUiL/8PA6qflz6RvSFG5aRwGp84IOqlZXaaDurtR1X8qrj1DskO74SMhzu8rtLUtBCqFO16gRXayjB2HJ8L2stBIWgA72HWLaz2s6kT+z7+uGL5NeWQZ+jws/xrXPKIrvT1T3YPIIjtxMP9xlnVFNrPLk3AtytxwhHtK1XX2rs/BEBfVrkFg/FvniXuPF6azHZP89m9NZ6UTIal1q0hCSBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKFlSosqAUiHOmyO5Bi8/8hAtwGQCcow4Fy0km7Sisc=;
 b=ib5cxLOa1leT47+1U54l4C2VTGxX/m/pxZcqBON2VX/H7TsPhAOVJoOw3L6K9VQqv+S4AiSoJw3IRH7C5QgPqje6mcQgnA/ZCzopVf0+nD4/ZbvUiafR1kuP7LfIX7+duZ1QzC7VWPo2v+oDdyYNian2CeVH9UrdLdMvub1juIo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB9150.eurprd08.prod.outlook.com (2603:10a6:20b:57a::10)
 by PAWPR08MB10306.eurprd08.prod.outlook.com (2603:10a6:102:358::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:04:20 +0000
Received: from AS2PR08MB9150.eurprd08.prod.outlook.com
 ([fe80::5a32:a224:15e7:6462]) by AS2PR08MB9150.eurprd08.prod.outlook.com
 ([fe80::5a32:a224:15e7:6462%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:04:20 +0000
From: Avi Shif <avi.shif@arm.com>
To: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: liviu.dudau@arm.com, Lisa.wu@arm.com, rosen.zhelev@arm.com,
 Avi Shif <avi.shif@arm.com>
Subject: [PATCH] drm/fourcc: Add MSB-aligned 12- and 14-bit formats
Date: Wed, 21 Oct 2026 18:03:48 +0300
Message-ID: <20261021150348.1634126-1-avi.shif@arm.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To AS2PR08MB9150.eurprd08.prod.outlook.com
 (2603:10a6:20b:57a::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS2PR08MB9150:EE_|PAWPR08MB10306:EE_|AM7PEPF00000050:EE_|PA6PR08MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6490eccf-c144-4d59-5f02-08df2f84aa1a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: kKVGzGqg4NmjKL7ZV0m5nqfr2ThwjOggFSMriCKyMAEQUcGAAYlyKgAwR5IgQ5cmzi3mVFXNJB3oxn/ehQoXn95+l9UQ+KZtyAyYDE6V2JQFBm0vMVDVq2rSgCOPD+DmkJLYT++2NukCZUcGT2WcgieT3bsrc643a9n4F/1jUUzJ6TUAFg86yPGAjpDE5FUQr1QUuFSFKqTXosO+9FkmusFdDvlz5CKrsje3lU1grPR517KudJRBnLyI7DBQl2FQYBlTPHl4lAUOHy1nbn/Z8M0fU5Od2hEX9rpLgZL6MKIj3KtPI2zTTDMvnP6Sgf7dMqGSCfjFxtaH7s/pYSLIqRh2eJbAg7uEGAdfxhd151KEipAKfixIJZy+uvco4Z6pGPgMaNTErYvcpXNV7N/KvC43DRQfULQN1ed9ewPRW4cmsh5CvTpjGjkPPfM3WZBasl9mtq+HWx65jrDheP5UqGXWW2OAvU4a8Pr5Emwc/Gd7XsIA8bD9G4FN6O8Kxr6p1RTkSwMw5/P+C1dkSrE8EQAhr44267kCGbYdafeAgy4yy8wxR0T0dOY+HVI8UfyGuzfsY/g6xfKfLSOfamHGAMzj53HBJgZvsXwHo8wlkChlRwOpcAgvleqsTjnDqsm8r+Y7ALWc2rx7njlULNRqciyW6pUnJbPf7/qMXipWOpM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS2PR08MB9150.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: E1Fh87jYnfmG9kzXJzlFAvU6YL4JWapgQAqj95O7QICEHrSAf/KnJrEGVnJ9kl7AgAGgkwk1emaIQKh+t0Jk4RMbfubS5GIQQHqtyrRVH+HtBaIr430iMFDcaVZ4NRmTwakyxmJXulRxqwBE4dc8XqgqTPosbs6XriNN8yU6DImuR8Kqaj62ICd39FEmrklehPv2PASy3nlNir7JaFEOo3xQ/IF2rXKJtnzTVzWREcb2z6VTGsW8pnjjOgi81CDe+JdGPV3VH9Eiza5qjaKFQelUyIr4MNRgby1cZfvASrsvUc+FJfYz5l9/8vMmT7yCj+bvjuVGzo6ZvFX1qxv1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10306
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000050.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e15b0f6-445a-4f62-c1de-08df2f849561
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|376014|36860700016|14060799003|23010399003|6133799003|18002099003|10067099003|11063799006|56012099006|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: VwOQzbeB3nI9EBEYllZMZV6Mnlnm97H6TYndovlCZ/zgdSThTp6DyxCWvXlgvmRj07j3vC9kv5QFJRobNzAqxtQtR9Hhs4vBNYJZgz1+RE0rwxzuDBMnH4AzmGFu6jrHBCcrqZXXJG/1Bjug+gMaFuVg9yLmrOyu7pKAoY+HPZYSltpisdR/qX184/6nzZySgiLebnUFHCcjnoLnvnCSqJkur1uY585wvRyXJsh2ieL6H/iTPNhzgfCsNoFpDEnGN0aPFpP8tgHIiHgzkae4BDLaiGxol/+uLa/7nPCyq/zY8c9SdI+BmBAElSgylf+G6i6QW344NMjoNFRRt/rrSw1F3Pl9TajKbc13juzVFXzUO0dBuqzm0O+idf4Yb6C6L10IobiauRlBI5T6sXQy9v5yUybGUU2T1/T+PLnTpA54nJedYGcr0MtMDza6LLTdy3SYADP/CkSyhe9GYkPTy19ofa/Cptgmt5GVuGZ5ChOmL0OwaCgpHhiZC40EtVTo+XvQAmpOT1eMOZ9ucc2/4qVxMgAG91gfUkbaoHU15P6SPgze2aC3S0vB79W84yVEkh1M2/WMexm05AP7VmcXHEfcpu/LuwkXBmdEJRsJUrfQ2zV+1f9KhiqLIS8ePMziF/fR2Kf5UX6wHEci8MFjrf6HnpK078ZsRXJGJIj+tLXhFTHnnNei/5gLv78zS5ir0q9HIPFV0mVRepSUVzQ5Uw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(376014)(36860700016)(14060799003)(23010399003)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xqrKSDLhHFAUQZcyzvuuWGvDiX5zFbhKPay34gZdWY9zQP+EhsDe2Cw/g8mSvVacL6CJlprmfaCCv5KDNzDmY6AyzmIjRdgeSxnUCVYQb/lwdlQ3/0lpadpoCmcEKvzBQBV+Jfhshg9xBuDP1wx/Am9QT7+B9oBK8bFBW885LmpRgHHBSQETXuJmEwwEQaWOPi/ZeuhEHRACRw4QHX8a9Nxpe5RyV42gKL2GjOk0sKCRFf9GVLWEOaFJwBbNxUA6B7fE2AHz1mcN0Evg/uEKcJqJ74xYBviuoAfxvTsQRHT4Mb8KnvflV3Lk4zcoDtRanDvMRL9wb0NihfTFyR6dzU8eHvXCsf4Kq6v+usiZnrP8bfOt2j4/NhtUzRr/duHBC2KQ+yykrWJKZjknCGHJgtv3hNSOJhU9JbuyHI1lMwwkUA4B3q1EpZdI/k4iTbp9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:04:54.4958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6490eccf-c144-4d59-5f02-08df2f84aa1a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000050.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10441
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define padded 12- and 14-bit RGB formats and add their format
metadata. Each component occupies a 16-bit word, with the unused
bits in the least significant positions.

Add P212, P014 and P214 for two-plane YCbCr buffers, including
their plane sizes and chroma subsampling metadata.

Due to collisions with existing DRM FourCC codes, the codes for
four-component formats indicate the total number of color bits
per pixel rather than the number of bits per component
(e.g., '3', '6' and '4', '2').

Signed-off-by: Avi Shif <avi.shif@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 23 ++++++++++++++++++++++-
 include/uapi/drm/drm_fourcc.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 60cd02b7ea64..608e2d411dfe 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -255,6 +255,16 @@ const struct drm_format_info *__drm_format_info(u32 fo=
rmat)
                { .format =3D DRM_FORMAT_ARGB16161616F,   .depth =3D 0,  .n=
um_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha=
 =3D true },
                { .format =3D DRM_FORMAT_ABGR16161616F,   .depth =3D 0,  .n=
um_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha=
 =3D true },
                { .format =3D DRM_FORMAT_AXBXGXRX106106106106, .depth =3D 0=
, .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_a=
lpha =3D true },
+               { .format =3D DRM_FORMAT_RX124,           .depth =3D 0, .nu=
m_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
+               { .format =3D DRM_FORMAT_GXRX124124,      .depth =3D 0, .nu=
m_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
+               { .format =3D DRM_FORMAT_AXBXGXRX124124124124, .depth =3D 0=
,
+                 .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vs=
ub =3D 1,
+                 .has_alpha =3D true },
+               { .format =3D DRM_FORMAT_RX142,           .depth =3D 0, .nu=
m_planes =3D 1, .cpp =3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
+               { .format =3D DRM_FORMAT_GXRX142142,      .depth =3D 0, .nu=
m_planes =3D 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
+               { .format =3D DRM_FORMAT_AXBXGXRX142142142142, .depth =3D 0=
,
+                 .num_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vs=
ub =3D 1,
+                 .has_alpha =3D true },
                { .format =3D DRM_FORMAT_XRGB16161616,    .depth =3D 0,  .n=
um_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
                { .format =3D DRM_FORMAT_XBGR16161616,    .depth =3D 0,  .n=
um_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
                { .format =3D DRM_FORMAT_ARGB16161616,    .depth =3D 0,  .n=
um_planes =3D 1, .cpp =3D { 8, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha=
 =3D true },
@@ -316,7 +326,10 @@ const struct drm_format_info *__drm_format_info(u32 fo=
rmat)
                  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
                { .format =3D DRM_FORMAT_P012,            .depth =3D 0,  .n=
um_planes =3D 2,
                  .char_per_block =3D { 2, 4, 0 }, .block_w =3D { 1, 1, 0 }=
, .block_h =3D { 1, 1, 0 },
-                  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
+                 .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
+               { .format =3D DRM_FORMAT_P014,            .depth =3D 0,  .n=
um_planes =3D 2,
+                 .char_per_block =3D { 2, 4, 0 }, .block_w =3D { 1, 1, 0 }=
, .block_h =3D { 1, 1, 0 },
+                 .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
                { .format =3D DRM_FORMAT_P016,            .depth =3D 0,  .n=
um_planes =3D 2,
                  .char_per_block =3D { 2, 4, 0 }, .block_w =3D { 1, 1, 0 }=
, .block_h =3D { 1, 1, 0 },
                  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
@@ -324,6 +337,14 @@ const struct drm_format_info *__drm_format_info(u32 fo=
rmat)
                  .num_planes =3D 2, .char_per_block =3D { 2, 4, 0 },
                  .block_w =3D { 1, 1, 0 }, .block_h =3D { 1, 1, 0 }, .hsub=
 =3D 2,
                  .vsub =3D 1, .is_yuv =3D true },
+               { .format =3D DRM_FORMAT_P212,            .depth =3D 0,
+                 .num_planes =3D 2, .char_per_block =3D { 2, 4, 0 },
+                 .block_w =3D { 1, 1, 0 }, .block_h =3D { 1, 1, 0 }, .hsub=
 =3D 2,
+                 .vsub =3D 1, .is_yuv =3D true },
+               { .format =3D DRM_FORMAT_P214,            .depth =3D 0,
+                 .num_planes =3D 2, .char_per_block =3D { 2, 4, 0 },
+                 .block_w =3D { 1, 1, 0 }, .block_h =3D { 1, 1, 0 }, .hsub=
 =3D 2,
+                 .vsub =3D 1, .is_yuv =3D true },
                { .format =3D DRM_FORMAT_VUY101010,       .depth =3D 0,
                  .num_planes =3D 1, .cpp =3D { 0, 0, 0 }, .hsub =3D 1, .vs=
ub =3D 1,
                  .is_yuv =3D true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 0bb049f91524..efd8bc81e91a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -234,6 +234,16 @@ extern "C" {
  */
 #define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /*=
 [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */

+/* 12-bit components in 16-bit words, with 4 LSBs unused per component */
+#define DRM_FORMAT_RX124       fourcc_code('R', '0', '1', '2') /* [15:0] R=
:x 12:4 little endian */
+#define DRM_FORMAT_GXRX124124  fourcc_code('G', 'R', '1', '2') /* [31:0] G=
:x:R:x 12:4:12:4 little endian */
+#define DRM_FORMAT_AXBXGXRX124124124124 fourcc_code('A', 'B', '3', '6') /*=
 [63:0] A:x:B:x:G:x:R:x 12:4:12:4:12:4:12:4 little endian */
+
+/* 14-bit components in 16-bit words, with 2 LSBs unused per component */
+#define DRM_FORMAT_RX142       fourcc_code('R', '0', '1', '4') /* [15:0] R=
:x 14:2 little endian */
+#define DRM_FORMAT_GXRX142142  fourcc_code('G', 'R', '1', '4') /* [31:0] G=
:x:R:x 14:2:14:2 little endian */
+#define DRM_FORMAT_AXBXGXRX142142142142 fourcc_code('A', 'B', '4', '2') /*=
 [63:0] A:x:B:x:G:x:R:x 14:2:14:2:14:2:14:2 little endian */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV                fourcc_code('Y', 'U', 'Y', 'V') /* =
[31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU                fourcc_code('Y', 'V', 'Y', 'U') /* =
[31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
@@ -334,6 +344,20 @@ extern "C" {
  */
 #define DRM_FORMAT_P210                fourcc_code('P', '2', '1', '0') /* =
2x1 subsampled Cr:Cb plane, 10 bit per channel */

+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P212                fourcc_code('P', '2', '1', '2') /* =
2x1 subsampled Cr:Cb plane 12 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [14:2] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [14:2:14:2] little endian
+ */
+#define DRM_FORMAT_P214                fourcc_code('P', '2', '1', '4') /* =
2x1 subsampled Cr:Cb plane 14 bits per channel */
+
 /*
  * 2 plane YCbCr MSB aligned
  * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
@@ -348,6 +372,13 @@ extern "C" {
  */
 #define DRM_FORMAT_P012                fourcc_code('P', '0', '1', '2') /* =
2x2 subsampled Cr:Cb plane 12 bits per channel */

+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [14:2] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [14:2:14:2] little endian
+ */
+#define DRM_FORMAT_P014                fourcc_code('P', '0', '1', '4') /* =
2x2 subsampled Cr:Cb plane 14 bits per channel */
+
 /*
  * 2 plane YCbCr MSB aligned
  * index 0 =3D Y plane, [15:0] Y little endian
--
2.55.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
