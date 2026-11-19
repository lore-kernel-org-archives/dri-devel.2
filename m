Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD260A3806
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lA6yWNSy;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lA6yWNSy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C781125DF;
	Thu, 19 Nov 2026 15:47:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8185B1125B8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JvqxQfm0sSJias20U1HdK6dwB7WaQHleGqc9Oo93vfa7U2caQ5ThCg94DheZbRcHaPpnQYWPf55EJwcYd2fJlFaOPMRNJIF2m9VfrQOkzqnBLSOr2USvigx66Jj+8fwrFnfenCdi1dUHwUDAZIH++QfgtAXIbBPMWGLY0bsoWNy4dcy3MGY2hCLRwc9Q0dwtC2BVazB1qwTMUC0NoQuPMt0q/tXh0ku7fCUgjHppQTILDkSDDPBNi25QKKBuVQGH2Ua6dk5OeH5ioP+7HUO8o2v3rI46VCX41NOWC88EgQqUhuMXRIXp23HwRhJt0vdIV5qJewYHcs0huOiwjp3ryA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=oki/LQCEbBV8DpeuJh+KfM+XPb5MgitoN0DA6yYfLy4mPjZRWEPG8UssnJOzmKv2Gcp5ZAoSzYPJ0rqUGQaUYIpaq7DmRw6t8J2YU4s2mvKhghOeN4s1N/KwV4zUs07o/j7tzdfWgU50zeZOLe4B9/vUuNFfBm2DSo6Wsw1MRq0LDDoit/mkA+dJxudCaMXN0R/vu0Ry1fuZhD1vNeybYBFywHd7CzgUXLjpmxey0yIYfiN8ibzRz85nH/B2QrJqloSsSZ5v2R1IMtoEwDUTXB+EIDX3V5X7TFAYoehFxZzTGgrnUIywWdJKgfIqJJo8yR43aqluc4H0MwlrR7H29w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=lA6yWNSyPawpGtRP3gb6ZrIvlZ08fMutBY/O5egPo1USD3TvshWnu9gPm+6JCyRuizA2/zx4xBNY7aUN3slwfp3Q2FlFgrWZrE+gViV6kOEYaAGX2rKWtdtLMpdizzD2Ok23jsdS+wOSApAfK/xHojNhyjZ1cG7kO1ZDZaZsI+o=
Received: from DU2P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::14)
 by GV2PR08MB11489.eurprd08.prod.outlook.com (2603:10a6:150:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:47:01 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::33) by DU2P251CA0004.outlook.office365.com
 (2603:10a6:10:230::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 15:47:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 19 Nov 2026 15:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDHzD7pp1le2SDqH5hH3DBH9aDk5RF/fU8pos7mPbtkve3ZGowArl8Ypx0lFfkkNK96NJ4u8/sCO6Ub+qFs8V2Egel12CzUqAL+RJDjFWCTh/rb/wY237H6vEZhSROihn/XO3lFP/zdDc6hoLR1Me+QUc7rU9D6vCuBvufUxWi1IEGDACvcY4YUPgleVECB1k7fVjrqDyFJobIBEq8hYhIvD/m3qTPaKEllP7Z0KUr5bdvPf1/r81BEVMaSNFvOYbtv8Zu9CzRRA1TVvu6gghrERVPyCzZRc8QcnWzgLW7q7lICRA2K+PXeebG3uqGFP1JMX5vVhWkl74Zz2EZKpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=MzTKS0RyIOk4T9sYnOhrPaRbvGLHLYLMHIs13t49LS056dyr4ik96S3u9pdq0VUPpWhkk0AJk69u+abYcAXWRRFmV0UvA9jm2AaWtOkL00Eq0KHy3rb0dsxlSUEiz7RYqWMT2wzyNepeTCPKM7xLZ2vCwLCwB0T97daCRDQBKBLHYhlgIk30VPm4m6iQKX8QiPedwJxsmxMCL2STt2Jmhri0+3wAE2fKlm0ePwGnLEg8oYUeMcBZcuOIQKqkFR5MMn3MjIYOQBF7iFO8pVb8Awu48t2OnmITHQaOvfPHcTBN6kxX5uBeaeI3qEc6ZlyECIo90ov77Jc+NYkdv9+bEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=lA6yWNSyPawpGtRP3gb6ZrIvlZ08fMutBY/O5egPo1USD3TvshWnu9gPm+6JCyRuizA2/zx4xBNY7aUN3slwfp3Q2FlFgrWZrE+gViV6kOEYaAGX2rKWtdtLMpdizzD2Ok23jsdS+wOSApAfK/xHojNhyjZ1cG7kO1ZDZaZsI+o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:27 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:27 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 4/9] drm/panthor: Parse and store GPU_ID fields
Date: Thu, 19 Nov 2026 15:45:54 +0000
Message-ID: <20261119154604.2519184-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0691.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::19) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|DU2PEPF00028CFF:EE_|GV2PR08MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5a8184-8a6f-4d13-a77b-08df465459e0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261022075727099003|261021121427099003|261102123227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: xVf06Tc/QiQK+BOm6gHU9XcTXr118J4KlyoSk53rPR1l/6pGE8JuETVoHiMT6/FjI+jZ+ft05z+9/KnQzhm5HOJhWlQy0KvrG86Reo9W4vKlfmiJd5HrogQIy+nFcwVoNTHnGIuO1dY1BSgYJ6Jws6zLbOspUcAVM5KKBCJCtjr4zXgTsrlg1Yd47sxKYOxeCVzlTIzGlphDOYGZ9a5xjskuG3uQxxCF2suXVtrXDHGPrQc9nY9kR+2KYowUJsmQAFzkke643/dXi9iEP6eLL0WsQWwD7z/vrWg8KT1o/kOuqZsNn7xqTsmKVbGLRHP6FVbSWFvUzJng3c0PXef9bc+0sNWEh6TOb9Q905ERWBlJ5SfEFZn26QobKLQUs55H+QwP3Og3HJqPrfTFTwNAeHF68Y0sNVKD32x1IRqCp/kh4RZgOUfvFkXdGPfApNhq9k69ZE9rDDkb7wl5+sW4/kEvbZDMVyD5w0EQLIQSDuz0WVci99NZRAEjXQ9XUiRp2N9IcYAjb7G4Lif6p1AujmyNwhJ623aTHfEeIEaJjdliTcc6jjc0SnY2m6gkmfHY9slCENwtucQjs1KMaMWpxlYQaIrm1VSsO9cNxIMa0w0FZqq7aKxVHKZEhC4nmWs4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261102123227099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aYqJ4mhl58s9BF79bz4L7vwJyq+3jLn+jHgXVR58YqVE7ysiGJJpRKK0HT2TUsJfwfUcWlvf+fxScpgU29rngQHLs02d5r6b84NQ3dIugvHFYZq2ZzGib3iZb7O+BfgC07ZVnf35ez9bbohtvh7WPH+3Bs55I6bg6h9X/AIrx6uz1vBsOA19GliBPSmtTSn3whAAb90A0SvpqTq3DgzqjbEyVwdxXk+UEMN7hNwbpDqz5htk3RUCnyKSJTyjim5keli0+zTsecyrTUIlwhpVL8fQBFEWuPna0BIFiaN0JnzfRIPI7Hlekf755v58WqiJTjezbw3M9SaRMdE1V9D/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d80b29d1-99ac-42b2-855b-08df465445c3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|376014|35042699022|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: /bFsa1ku5XqYbjU+kgx7lAjh8ap6/eV6SfMiLWpSASnA/NwmgiQdNC15mEvwesbq+d1Y1ynS4Slv+/1BcAk2dqZYodk1VZlk9tJ+C3Id1VRDPeNU0Qsl/M297xZtkHZijBkfqGqlVB3VBsiq9g9cgmmlWRrYk6gUT7Yq07KSJQdrURABEQJ3jdJA9PScr2TLVewyZp457/YG/ghXDf5JuRRm5OeGT/kiMPMr82aFT1DTAyxwmfzxCPh8b/yT3wlyvfBi9Tx5kvd3bRZ9Gn5Q3fvmCRzwYb7tk2u/uU0vk31sMWfW+9oDa3QN3Xgv7v9DfGBjrmJp6gxW+8NceQYqhdL8DCaINtKxzG13JUlDwEAuwmUTqIug5UVkDlYCU1HXzC+r4H19imhrhomKp1WuWuVGM/LUJ6LJL9Tj/2YQGdNAiwcO3r2c4FbpKSBTcsFtNfV2MmyyKIlbD5VsEwlHjPK97YGMX7wCGMB9safTa+sqljzNmT0IzvgBjefS4k1EEplnbZA5z2g0xfvzBwgw903UevN3OKEpZGMelorAVUwzXU66+d9E/Nk1nuhgcfr6HAVapwJAHikrgJYPV814Lf2t39wQWTTOjDT47g5sheW/uLIPmnn2P6LqHTMezVyOcPUDFZsNX6M6AdFoQm7l3mdmbu+wZ9MuP820rBg2F2A=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(376014)(35042699022)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hH91FK5z8WnNJgCv7ud5D3NrciJb5Lld91/FMVjuPKSulFbOriyCt0yqn6Zibm//NqNMmiUXckOdGbjdjPZgOi/68QqO52RTU/qCS4wurm9C8mnmcfgNHtyvvN/m53IB6CxbpeCg/v/lhc5ZVx93Xc6xCr7SG+qHw2n97RTz6k3JFXdELuHM/mQe7qNuUFiIPQ85oEYAIUwMLXSo2P8Um82GgwvRL6D8/TDgLF7h1XgMlMnV1qvb+YoenH1uPwDdeBhsahw2Q+tT+I8j65aHOXmuaNOugiWn1Zi3+Vtl/XMn2NxU2IwJuVGrqWUgAfE4ZHwgfjPuMQOO6nIePwkVgqykHFMJClKanpKKWwcPGLC780BVX/ACYJ3YDM4fEKSJbFnwhu+DD/RY/ri1krPgs64b31ik0Za5EN72lb6Z42lwCNEUpLr+14Fg5OLhrS7w
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:00.7919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5a8184-8a6f-4d13-a77b-08df465459e0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11489
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

Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
layout changes.

Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
once during hardware initialization. Convert existing users to consume
the cached fields instead of extracting them repeatedly from the raw
register value.

This centralizes GPU_ID decoding and makes it easier to support both the
existing and v15 formats.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
- Avoid modifying the printed id field for existing GPUs.
- Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
v1:
- changed struct panthor_gpu_id into a flat structure instead of
  inconsistent groupings.

 drivers/gpu/drm/panthor/panthor_device.h | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++--
 drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_hw.c     | 24 ++++++++++++++------
 drivers/gpu/drm/panthor/panthor_hw.h     |  4 ++--
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4add31b12cfd7..f0a96ff0f13da 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -111,6 +111,32 @@ struct panthor_irq {
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
@@ -170,6 +196,9 @@ struct panthor_device {
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
index b8df5663f04e4..c5c37f22993d6 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -74,7 +74,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	if (!data || !data->asn_hash_enable)
 		return;
 
-	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+	if (ptdev->gpu_id.arch_major < 11) {
 		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 34dc4b9d9dc09..854874a9f322a 100644
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
@@ -245,9 +245,9 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
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
index f770dc40e6216..c4a490bc39de6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -58,12 +58,12 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
 
 static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 {
-	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
+	return ptdev->gpu_id.arch_major >= 14;
 }
 
 static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 {
-	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
+	return (ptdev->gpu_id.arch_major >= 14 &&
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
-- 
2.43.0

