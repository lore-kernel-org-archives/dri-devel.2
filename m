Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824A606D74F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MGjI2fkU;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MGjI2fkU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFA510F7CA;
	Tue, 10 Nov 2026 15:42:23 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E0010F7BE
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DwoQFTMRBJ4J2tTctQxv9Nle5XVjVeg3p8EoFTxOjn2VmQLkzh/uHj5FKTJZqmQo65rV9Np11PuO91raJVYs2zWmKzKx64PskeCisYGlxDf1brRgqyKrpOisHmJx6XzA6lrITPKojuVE5E4bFhX042u70G3SfWR+8k5n0apDIUHsVLmvbp6fw+nT+OanVnr8YO/wuupiBir2l6L0rE0SNPcDKut2yEJBIpZumUJKNSz59CJBrqsH2DV3VOPKyd6GxOfP4UIukcS861/Wt2RIHPGC7iQuImYpKgllsP0AVaShARtxmH6KhUv5p28h8z4PE9q9uFyUdOYktPg4Cx4E2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF9QrRj2+soY9xQfmog4ZSFSOp5qhBEyOXOMdi4YdGY=;
 b=ZKYLw0gvE8+okdM9GjP5dZ4+wUJopic2DBtyd71a0iJpQqu3S6ZMA3NJIfKfShKCV0fnMDgzAUfecNPP0Hl3BAASQI2xfnIJ6e5L0rEM9v/9imFzLq+bhloy1AMTMClTh/s7QzVO6CsgF5Hulkru8iB+ui/SMgfnZyuM2U3Zt/FKANiuHG0fvTm0+CNBGlZ6e0DddjodT26Pg0u83i2GapUgTZduxzt3LHet+D33U0OVMaWcxlZPO/4Bllzhj9TeF3+r1zmM99tv3/cR2AoCLUcov9V2lXugrqTVvJyojnUn08a5nGW/isLIJhxYozAgXQG+C6IMnDo4FHYdWWoChA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF9QrRj2+soY9xQfmog4ZSFSOp5qhBEyOXOMdi4YdGY=;
 b=MGjI2fkUyINnkzApYC/pj6S/DUih6h6HRHSNT4TNlmh/VfwBySbvA271y34czL7Mdf7gUYc0F6pDwqzlqGiYHdh89XgLL1Eeb1MEmq3TA+WepEvT3UqzGTpW0p1naOL5e5drx6PYX8i34qQM3B+8QILRCLzUGUlFJir7bK8U3qY=
Received: from DU7P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::15)
 by AM0PR08MB11282.eurprd08.prod.outlook.com (2603:10a6:20b:6fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 15:42:04 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::ab) by DU7P190CA0019.outlook.office365.com
 (2603:10a6:10:550::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:42:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNlED5HAlXi6F6PpHiayMQJ8ddwrTqiUtbaZIULwvLwEuTkpalrBPcWUwC66pw/dJ7TXY8RpUTrHowqX+ZbEsG+FHWygpxjwvHrCeELACHAHIULboaym+EhxqmYhRGB9jDZnAPltuB1QP4jIlChGs34Ai/Vk4VcFdPEHpEKlx5WMmbL6CfMYDSfpkxH4s1DE27tnQjEJQ+ze0FzLn81XNYuCF7Wj3yle9eGGvtGPv76pc1h1KVZtovh+ytJr8+Alf5r+QzVzierD4GcR+A3aMvQBsLDXKMPcIIbUvZA9b1NyTeFWjEh41pZcRijLuH/Q7xDF63ovohsAjrfSpmE5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF9QrRj2+soY9xQfmog4ZSFSOp5qhBEyOXOMdi4YdGY=;
 b=CpQCYxNMQR8QPTjYYPyefjfPHeCu9+gU+oa2Ub3GyrxudCEDOOhpMFSuqV/Pcm5xfr+16OzkrAS8dmscIZ06S47Gxx15RXyZS4uKBHQJvmuKur4BfoddSvbMk4gYiRz2GYSJX25xJWvIX9lJFnNb9+6YZ8S9Z4Qs8AH2vhC8a2YRCoe8soo9ZexUiDBo5gTYmwOJsa6FgF0H3aindTvWResyXqzQGG1OLJ/YDLKvUq4oO/nZe2t0aFI2K+MDXAayYUcR+7GCXePiAacEzN8nSpW7Kk4F9G5jgCs68F7l8Gcze66rCEtiqPKUxsIbbBBEti5lUJ6XZSNc6XfzUCvKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF9QrRj2+soY9xQfmog4ZSFSOp5qhBEyOXOMdi4YdGY=;
 b=MGjI2fkUyINnkzApYC/pj6S/DUih6h6HRHSNT4TNlmh/VfwBySbvA271y34czL7Mdf7gUYc0F6pDwqzlqGiYHdh89XgLL1Eeb1MEmq3TA+WepEvT3UqzGTpW0p1naOL5e5drx6PYX8i34qQM3B+8QILRCLzUGUlFJir7bK8U3qY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:31 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:30 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 25/28] drm/panthor: Route HW component PM through access
 windows
Date: Tue, 10 Nov 2026 15:38:46 +0000
Message-ID: <20261110153907.3241978-26-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|DU2PEPF00028D03:EE_|AM0PR08MB11282:EE_
X-MS-Office365-Filtering-Correlation-Id: da7c64db-7c06-490d-53e6-08df3f412acb
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|261009223327099003|10067099003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: bRqoTBzRoHx1CinO47c8dkok528b96LdvKqP9L5GwTKqI38FtIxCCs0OyXO0GQk/lgzL3kgAdQpUF+pfX/G3xEE0QpXnm3jXv76ofptNIrl34L9hkdgc9Bq2x412bGbpILY6oOHPDgW09FQFHzoZL93zeYv0sajInW5Cwwhxs+9UZXHOvgnwNxniFgDAMcuAkYtetO1ni4kDsBgn8/e32mfCoDh28nPOQfWEUg1xOu36kjEasnePdW7NDx5wKwUSihY89o8sZNBM2fr10TtnhhRYhgWp+ABnC2AZd3tGXExWXWsLplz3+Y9/m1Yv3oXy4hohz9yG+3ao6M/04coIjSV2DHSjLVDjakrpt5mX7z6zsyudgvMn1Dsma8S2kAqtKPPLe9KZPqMYKftvzR/EVNvgAIlI5AD2i2jGwDh7S+hf8bXrb8ZovzyDeIqvdXS9kVJ1oW5iFmuhfMhHhDwitY9Qam9s0l0bN1FvSFUNArJdS+dtwA9rlT+DqL5mAS/OGn1fJTUTt83a7drycD5YiYTvKFM4UkMQebiSGpYR1sBHGzKI0gdxMai8jD3W+qfSEnKEm2FhkeQeueNp6hPkEhXq1dLX6owBIErw5ganFoTzYIE+bjSx/xU3zKDpKV5ctc7qDCE6KokiJ+sdmXqw7m3vgDm3eAqVjOPtgLu6igw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223327099003)(10067099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dyKhe3NG1llwd9NApg2z1JGVISe+pRxqvo/bBjny6Z8+grajBT2WnF03Y/DrMu/0In0aCCxN80wQXSQDgglUe3naE5xVacdTrkKOVp0qp7LcA7dBULglYHTv9LFBRxOm6amXSSOxrzv6s3zIy98/1NA86SYNzTo9v3C0uxMW7NMAJcCiwcI9EgMcIDE2VWEWevyFI0+6rbFtKO0ArFMiQehLadTdG9iF2tDwZtsfgVvtrs2R/udf2cNfQ0pQedn6eNiYSJ1PMz0v//uJAvyw8EY1jMyuP+mf9vDgRXo0rD5FpmL+ccaTDtOeB5xdSlnyft+Olh/RavdlVRi0qMkdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4aa18f0b-3d79-41d4-7834-08df3f411769
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|1800799024|35042699022|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|261009221727099003|261028144727099003|261009223027099003|261009223327099003|261102123227099003|261009220027099003|261009221227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: QfK1ioPsK61YE9aZJ1T8W0eMADvSbuhZPlLtmRbFEZ+Hzk9VTeNMNpz4V0WwMTLW9eKM7MVgOC2t3ymwg+nPVn9BOfg7EIJWMdoVh8RBZKNL0+BPqNtsCWvrVGg+DZ2aS4mwCWL+NNmXqz2suWMAO9HQ2xZJ3qZHuAtjbCL2OaLIy7RRIOtdujNmrwLZY65c4zO9KLAspQIaaPSsmV4RwyuMPZMzdXIJgRzjoOLHA2zdVYOm86x7/OGtE2K1mrU9saN3HI08NlBHWqowRVPSMF4yul7NU+QqP5fc+TKtS4jVAcrb2Vwrwjvg+5UtHC60YRjiqHPtjfUpREHWWw42/0eLJTEq1P3qcJnCtLKXoqixxJLNX/lAGzPCRfAvZC9dYn2UIUTJfVwP6Xq6DpUOJNzDmdGCdMNC0kWZaaBTk0RQ2ohbZPra0gN7rwwUoMYoAHxjGwnEFqWnicb9DPrDXnjZDLbZ0G1Vpgq3z6YzuuWslFSERBC9hgFTowVofY+OfiSiQYMhPzEZ/xlYMlru4K54bmOv3NjpTpR6UJQg1wQpscoxEkFs95cU+gh1+ALwTS00p3Ag3OMIbTAE+lgG3omWC9UGHAKVQrACsZomMI7vGEgr7B86lTBAZ5HE4xUTGi01tiz3mcNiFGZm7N4B09TIP0eZsInwBM2gZ/OFz9+H+3HKTgZrGjkt4tU+c2QTdcgzn46EpWCfolMKJ6Vglw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(1800799024)(35042699022)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(261009221727099003)(261028144727099003)(261009223027099003)(261009223327099003)(261102123227099003)(261009220027099003)(261009221227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tTm748y7YuPXLVXNKRpRbJlNHER89y0jRI+o4l+mwVLhS1Mr6aEiX/sUXrx347KAN7fy1dYPnX8bWiniiWhbre0HP6f5WPI/IRy7hJSXuduHDoGEgJ7LuD/dpJVro9v+ww0dsjSnN5+KrRDHjc4VQcSR/B1XUWGTjHESbggypEKVq+gcZXOgVkxJmjcOZlKMfQeJIx/kSRB6Pw6eISdeW5ncZtlCHAHpVzEpjBcnSAF18i8FEaqDRlME3xVIgnpCmZFnuobUv4QvR7Gwe9/Sdf1j3bwbfN2dV6gistrLO5L8a50COReETkaLgn5fgz7sb4BhD+aJSLGAEwQvE2SFKDZO22pWlQm+Fa2xVUMRW3cu9kGJPRix1ADC+G9JPk6GKEQqj5jkR3OZlgZjKvt30AkB1VpaJLQAiTg/w2VpJLzD2Am+Sp2kbF0Q0KNZJi4C
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:42:03.2174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7c64db-7c06-490d-53e6-08df3f412acb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11282
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make access-window resume and suspend own GPU access when AW support is
present, while keeping the direct HW component PM path for older GPUs.

Defer post-yield cleanup to workqueue context, and make
panthor_device_resume_and_get() ensure that GPU access is obtained
before callers touch hardware.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Align with state lock changes.
- Fix case where autosuspend would not be triggered if tick_work drops
  its PM ref earlier and post_yield_work becomes the last PM ref holder.
- Fix case where post_yield_work could run after FW/MMU was unplugged.
- Wait for AW state transition before retrying runtime resume if -EAGAIN
  was received the first time around.
- Guard panthor_sched_resume against access if scheduler is not
  initialized or already torn down.

 drivers/gpu/drm/panthor/panthor_aw.c     | 146 ++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_aw.h     |   6 +
 drivers/gpu/drm/panthor/panthor_device.c |  10 +-
 drivers/gpu/drm/panthor/panthor_device.h |  28 ++++-
 drivers/gpu/drm/panthor/panthor_sched.c  |   3 +
 5 files changed, 181 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 5ab1d44f0a22e..3b418c816d824 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -81,6 +81,9 @@ struct panthor_aw {
 
 	/** @msg_retry_work: Work to resend messages */
 	struct work_struct msg_retry_work;
+
+	/** @post_yield_work: Work to yield the GPU */
+	struct work_struct post_yield_work;
 };
 
 static bool panthor_aw_is_open(struct panthor_aw *aw)
@@ -114,6 +117,66 @@ static int panthor_aw_state_wait(struct panthor_aw *aw,
 	return panthor_aw_wait_cond(aw, atomic_read(&aw->state) == target, timeout_ms);
 }
 
+static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(
+		aw,
+		(atomic_read(&aw->state) == PANTHOR_AW_STATE_READY ||
+		 atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_GRANTED),
+		timeout_ms);
+}
+
+static void panthor_aw_post_yield_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, post_yield_work);
+	struct panthor_device *ptdev = aw->ptdev;
+	struct device *dev = ptdev->base.dev;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &aw->lock) {
+		/* Something else has progressed the state to READY. */
+		if (atomic_read(&aw->state) != PANTHOR_AW_STATE_SUSPEND_PENDING)
+			return;
+	}
+
+	/*
+	 * Ensure in-progress resume is completed and prevent future RPM suspend
+	 * to keep the clocks turned on when accessing HW registers.
+	 */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	ret = panthor_device_suspend_hw_components(ptdev);
+	if (ret)
+		dev_warn(dev, "Failed to suspend hardware components.");
+
+	scoped_guard(spinlock_irqsave, &aw->lock)
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+
+	/*
+	 * schedule an immediate tick to re-evaluate if there is any additional
+	 * work. This will request access to the GPU again and if the driver has
+	 * gone idle, it will yield GPU access via the runtime suspend path.
+	 */
+	panthor_sched_resume(ptdev);
+
+	pm_runtime_put_autosuspend(dev);
+}
+
+static bool panthor_aw_schedule_post_yield_work(struct panthor_aw *aw)
+{
+	lockdep_assert_held(&aw->lock);
+
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				     PANTHOR_AW_STATE_SUSPEND_PENDING)) {
+		queue_work(aw->wq, &aw->post_yield_work);
+		return true;
+	}
+
+	return false;
+}
+
 static void panthor_aw_msg_retry_work(struct work_struct *work)
 {
 	struct panthor_aw *aw =
@@ -213,7 +276,7 @@ static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
 
 	switch (atomic_read(&aw->state)) {
 	case PANTHOR_AW_STATE_GPU_GRANTED:
-		/* TODO: schedule cleanup */
+		panthor_aw_schedule_post_yield_work(aw);
 		break;
 	case PANTHOR_AW_STATE_GPU_REQUEST:
 		/*
@@ -416,6 +479,7 @@ int panthor_aw_init(struct panthor_device *ptdev)
 	aw->iomem = ptdev->iomem;
 
 	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+	INIT_WORK(&aw->post_yield_work, panthor_aw_post_yield_work);
 
 	init_waitqueue_head(&aw->waitqueue);
 	spin_lock_init(&aw->lock);
@@ -443,6 +507,16 @@ int panthor_aw_init(struct panthor_device *ptdev)
 	return ret;
 }
 
+void panthor_aw_cancel(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	disable_work_sync(&aw->post_yield_work);
+}
+
 void panthor_aw_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_aw *aw = ptdev->aw;
@@ -456,6 +530,7 @@ void panthor_aw_unplug(struct panthor_device *ptdev)
 	}
 
 	disable_work_sync(&aw->msg_retry_work);
+	panthor_aw_cancel(ptdev);
 }
 
 int panthor_aw_resume(struct panthor_device *ptdev)
@@ -463,21 +538,41 @@ int panthor_aw_resume(struct panthor_device *ptdev)
 	struct panthor_aw *aw = ptdev->aw;
 	int ret;
 
+	/* resume hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_resume_hw_components(ptdev);
 
 	panthor_aw_irq_resume(&aw->irq);
 
+again:
 	ret = panthor_aw_request(aw);
+	if (ret)
+		goto err_out;
+
+	ret = panthor_device_resume_hw_components(ptdev);
 	if (ret) {
-		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		/* Yield GPU access if HW components failed to resume */
+		__panthor_aw_suspend(aw);
 		goto err_out;
 	}
 
-	return 0;
+	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_SUSPEND_PENDING:
+		/*
+		 * WINDOW_CLOSED won the race. Suspend components before the
+		 * caller can disable clocks. post_yield_work will transition
+		 * state to READY after this PM transition completes.
+		 */
+		panthor_device_suspend_hw_components(ptdev);
+		ret = -EAGAIN;
+		break;
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+		return 0;
+	default:
+		goto again;
+	}
 
 err_out:
-	panthor_aw_irq_suspend(&aw->irq);
 	return ret;
 }
 
@@ -488,11 +583,50 @@ int panthor_aw_suspend(struct panthor_device *ptdev)
 
 	/* suspend hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_suspend_hw_components(ptdev);
+
+	ret = panthor_device_suspend_hw_components(ptdev);
+	if (ret)
+		goto out_irq_suspend;
 
 	ret = __panthor_aw_suspend(aw);
 
+out_irq_suspend:
 	panthor_aw_irq_suspend(&aw->irq);
 
 	return ret;
 }
+
+int panthor_aw_wait_transition_complete(struct panthor_device *ptdev)
+{
+	/*
+	 * This is only called from panthor_device_resume_and_get. If the error
+	 * condition with which this is called changes in the future, the return
+	 * value needs reconsidering.
+	 */
+	if (!ptdev->aw)
+		return -EAGAIN;
+
+	return panthor_aw_state_wait_transition(
+		ptdev->aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+}
+
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
+{
+	int ret;
+
+	if (!ptdev->aw)
+		return 0;
+
+again:
+	ret = panthor_aw_resume(ptdev);
+	if (ret != -EAGAIN)
+		return ret;
+
+	ret = panthor_aw_state_wait_transition(
+		ptdev->aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+	if (ret)
+		return ret;
+
+	goto again;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index 60d5c8b6c9afc..d1f43c4ba17e5 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -35,8 +35,14 @@ int panthor_aw_init(struct panthor_device *ptdev);
 
 void panthor_aw_unplug(struct panthor_device *ptdev);
 
+void panthor_aw_cancel(struct panthor_device *ptdev);
+
 int panthor_aw_resume(struct panthor_device *ptdev);
 
 int panthor_aw_suspend(struct panthor_device *ptdev);
 
+int panthor_aw_wait_transition_complete(struct panthor_device *ptdev);
+
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index ba5252c27410f..d1ef460577c99 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -92,6 +92,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	mutex_unlock(&ptdev->unplug.lock);
 
+	panthor_aw_cancel(ptdev);
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
@@ -325,6 +326,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	panthor_sched_unplug(ptdev);
 
 err_unplug_fw:
+	panthor_aw_cancel(ptdev);
 	panthor_fw_unplug(ptdev);
 
 err_unplug_mmu:
@@ -577,15 +579,17 @@ int panthor_device_resume(struct device *dev)
 			atomic_set(&ptdev->reset.pending, 0);
 		}
 
-		ret = panthor_device_resume_hw_components(ptdev);
+		ret = panthor_aw_resume(ptdev);
 		if (ret && ptdev->reset.fast) {
 			drm_err(&ptdev->base, "Fast reset failed, trying a slow reset");
 			ptdev->reset.fast = false;
-			ret = panthor_device_resume_hw_components(ptdev);
+			ret = panthor_aw_resume(ptdev);
 		}
 
 		if (!ret)
 			panthor_sched_resume(ptdev);
+		else
+			panthor_aw_suspend(ptdev);
 
 		drm_dev_exit(cookie);
 
@@ -650,7 +654,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_device_suspend_hw_components(ptdev);
+		panthor_aw_suspend(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index e002ebbc88579..af2282240e692 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -20,6 +20,7 @@
 #include <drm/panthor_drm.h>
 
 #include "panthor_device_io.h"
+#include "panthor_aw.h"
 
 struct panthor_aw;
 struct panthor_csf;
@@ -456,7 +457,10 @@ int panthor_device_resume_hw_components(struct panthor_device *ptdev);
 
 static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 {
-	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
+	int ret;
+
+again:
+	ret = pm_runtime_resume_and_get(ptdev->base.dev);
 
 	/* If the resume failed, we need to clear the runtime_error, which
 	 * can done by forcing the RPM state to suspended. If multiple
@@ -470,8 +474,26 @@ static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 	 * succeeded. Given resume errors are not expected, this is probably
 	 * something we can live with.
 	 */
-	if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
-		pm_runtime_set_suspended(ptdev->base.dev);
+	if (ret) {
+		if (atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
+			pm_runtime_set_suspended(ptdev->base.dev);
+
+		if (ret == -EAGAIN) {
+			ret = panthor_aw_wait_transition_complete(ptdev);
+			if (ret)
+				return ret;
+
+			goto again;
+		}
+
+		return ret;
+	}
+
+	ret = panthor_aw_ensure_gpu_access(ptdev);
+	if (ret) {
+		pm_runtime_put_autosuspend(ptdev->base.dev);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 3b2ed4095f80e..729eeb339fa40 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2889,6 +2889,9 @@ void panthor_sched_prepare_for_vm_destruction(struct panthor_device *ptdev)
 
 void panthor_sched_resume(struct panthor_device *ptdev)
 {
+	if (!ptdev->scheduler)
+		return;
+
 	/* Force a tick to re-evaluate after a resume. */
 	sched_queue_delayed_work(ptdev->scheduler, tick, 0);
 }
-- 
2.43.0

