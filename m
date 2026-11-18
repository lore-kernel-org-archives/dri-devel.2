Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C4A4AlGW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C4A4AlGW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708EE10FEF3;
	Wed, 18 Nov 2026 17:55:00 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC4F10FEF5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vXURBG+aUO5cVevQF4F4bPa5wfJrB1rTVTTjyiHt8dCRT7vJDfJL0YJoznStLmxKmebQDMlGMoNi123S35hK4o6fALyvL7+xLm08zB5UuaVAM23xYvFXQ+VB+aLWACUsniKb9wTprI96Dw3PDalZfPhVQV05FDNEKm+Rge8OkDQhUbJX93vDfl29C6oA24eWI/61JTsCrXTRXGDoBOn2TPlAEL96HQCIarjzrQRo6JsqkopB6lUTqOS+ItFz6n/QuKjYs0b8mzEJbFuJZuvTL97wu/pIFP25XonXRkgqXyIZEevrDIqoJeL0wl3oHnpXS54dNCHcduxJbrVJJh7uyg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=mh/GnJITo66JPS7Mgt5SkgY4PTU9PMAAdkvY3nXx3MMTDZmIM2b1kjfPFr8nc+c3TyWRKcn0hr5znxdNjcgpIq4DWnM0LAlawe5zb7VwBL2+Mw8Vi8MWVXS6IaQaL4fV5N9WBS00aG1NDUGJ3Ytgdjx0BOplwlLVuggvbAqw7Avov9B/xgZIRVFB+lhBXTJ0t4xBIoxFw17DGz1HJmek3adhCaZLcSLqzEgcGP8TgVrXyvKOSW+nocrWtUmgvTp2KPIxvRtIurfOfCxR5bpoSXE4V0u5VrxEhBdJptmvovsGiOeYvO1QF3UIM0bUZEebf/qmUHKioFr2CEYVHsU2xw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=C4A4AlGWi7Y+KTgdL1yuR5n5na9i/sdFkxQZqgRCvy5ws7muAvxdD2Oqq7UIBZmtIjkq2qjK0UHHUbUj7V0zbLoQdkUtsIaLhmlGXG+dD2odlDD5SvB2zXW1BZhxYc9ttPiZyfAxMsRjNDBTM4v1IoldDVm8Ehay7uRq8ZS0ICQ=
Received: from GV3PEPF0001DC05.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::267) by PAWPR08MB11413.eurprd08.prod.outlook.com
 (2603:10a6:102:511::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:30 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com (2603:10a6:1d8::16a)
 by GV3PEPF0001DC05.outlook.office365.com (2603:10a6:158:400::267)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.13 via Frontend Transport; Wed, 18 Nov 2026 17:54:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv0g6JVOrTaShgA95OAwi7whPyk+/+BbSQRWlo7j8macqpVLwE32yYAbcbk1TDxUEtpOHpQhEDdxT9BgKCMwnzji+UbJ8dl0pt8+EqRg+8HBLl1HDqeEqdKjzNJCOPI2T5OdAj6XUivYGNKFhTaQeQGA5qTw2CdDzrFcGMdFafrhXnOxYRzy+7Iigauellg4e8NsQzxZY3JyodWtP+JFguDqwdMLvpEkye2LibNERVRw8+SVyOToCN/1ONG7yxN+HZahajndKgvVQtoJ0a4tjKX5Tm22GlQubjHjqVhNZadc8feYMxQLxDfQhjDNFj8ECthTtBCwTt8G4In34W3hNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=Z48ww7luucgIpMDQVtGQGwZfWB7pQbrSLQ+BRvZTLYb2pmkVb52XS1I4HLiQSeKsW/hzTcZdmNQodesKuRqRUVZ0UuixhadA6bjzDhNLS4N8xWX3iabom0Vmh5Ua7qHV4Id6Sw/oM9gB2NOo6NoqX28815TBPVH6t4LYa35qD0XQV03UevmwhXfOjul1hUd76JFoF2oPKM/gxgoVD4za6XhXOX8kY0sF1BJMPKqHBGNXRCQBxHVsA7snxfk6Jk0VH9vyjfBC+g7wjQbHGMDSN9GcKzcHI7NxZrRDrVyUTbWbj9igTFOKtK1HRmnv9WG9KY6YG9xnBZDq79m+2PrALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=C4A4AlGWi7Y+KTgdL1yuR5n5na9i/sdFkxQZqgRCvy5ws7muAvxdD2Oqq7UIBZmtIjkq2qjK0UHHUbUj7V0zbLoQdkUtsIaLhmlGXG+dD2odlDD5SvB2zXW1BZhxYc9ttPiZyfAxMsRjNDBTM4v1IoldDVm8Ehay7uRq8ZS0ICQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:53:55 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:55 +0000
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
Subject: [PATCH v3 04/10] drm/panthor: Parse and store GPU_ID fields
Date: Wed, 18 Nov 2026 17:53:20 +0000
Message-ID: <20261118175332.519657-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0439.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::12) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|WA1PEPF000099D2:EE_|PAWPR08MB11413:EE_
X-MS-Office365-Filtering-Correlation-Id: bb925fa2-cd9d-4bd9-7532-08df459cfe02
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022075727099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: 6g8pRI18cM4gwfYGu/b+MKu61c9dltE1d3JxC+V0Y6GwCkIbgZhLH7mWaUqq4d1Y/MXW2X24DYOALutmsRzL1ZuJvWPaexVyvRRj7Ef9uaJXwwHgdXd64Y25ktD0eawpGyrtNGI+YBaJnQLGS9u4HINZIrBKkehIfUFFfEPqLnlvmuBg3/GwRHKxKX4Ecjf4j84y2f6TF0XZYWKEfASDRFuDM8KX7X2auAyuv4AcE4V27hELoF/e1ke27aUKb6nSiA1ZRLy48t+JMaJQDPNTSmnKy8g25nxlUF1Ze+MkiGgkbdUnuhqbMpqBZrUZppSUxp3mQVV661ic9NFg95Fx4T6dD0bI7BcF8sEKl9jj8lFj+Fa5EU1WEDvY/WFvT1LOayoWCWhFQD851RgOD7QHMCZyLNYD3PK8mkI24TFmt0xpo92ckh7Zc5QyXkUAxB3C4wz7DyylSBjukrGNtompu/79QFdBUZ7ttiTrD7WmX4DMaCjAlWMhBFOQaU/rqkYMvuaQ/+H1+ZN7WsRaApsIZXjbMviAwbYP4Zr1lx8LMFdxFpHAqH9pHjKxrc1aLVmUwQ37bpqPnIYj8pQUREHydFeqVJaB45cc8XMNKBBnmCIKEeZqOJ247DPLIvVQAjpQ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XbiCoBVvXdzXgde5ie49rIpJc0yM5Bm77qN4ejg4nKOqpJ+SvGeeCvt2LI1iYTMc5jJtk/jlHC0po9tcLdK2cjZl3SpgtzUuECCI7eeVfLrS4xHBPM1nZUCjVMO3s47X+yhuGCCfK+Utr6H74uL3ADT5yiNrAwbwnGVhPI/ZIHX4+qeyerq4F71UuSlDsZDQGW9EBhzuOa5srJ9MuxZ+J2Qeu3Y88ALQUReq7HrGce+1nhmNMlK4aIFt99bCLufSHBgBDiTj/9f5zDj4qbG9NVTpVyDpT/u8IzTwhL071EfHtt/7lLImRU8MWDhR8lObjPsGtRyvOlTrbmPCmn8mwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f5d59cc-4015-49f8-a497-08df459ce9ee
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|14060799003|35042699022|6133799003|22082099003|18002099003|261009223027099003|13003099007|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5aJSSZWA3u2wPmIk1jVIMfOr/HoE3DOJ6W51sQEtfHZ/3ht+zbE1iMCMJq4zoxcEZWXzHbNpQqrjMmyMyEHR2LfSkmj8uV2VG1WGdgq9tjXFa5/lyu7hGxjcMy8F9GpMBbjRLLPlDch/tr9D+oKdOF1RN+vJwF2miiQw1hzKibyXbBvI6js5AgdME6f9ACYKQw/NwpreYhD/ALDcp+avXTky2iCzTpy2cCNIo/imqwex+aX/fuEvwVbur/YKOeFi58jrdLXmtv55/KqUFBURwTuHNnPM3T+VjQ3v3Z9mlIP2fTUYo6Nb3djYrzdOSL4lbOx3HYO5VfNX2PIC2qkQAdFsk0R3RG+oLY/7ZRAtRn4u74dlCZXYr07ZNwHnt0matcNYHhXmLNaLErwDIx9dVBTjSTMwbcTQH98STe1WdrT8Kefy7lGU5+ZwL24BTSgkL1rJCo0muXp0pLN0jr7pGPTI5e4FQ4mgFeg4zaLvx6a3nodlwnjz1p3lsa8Es4bmzuMQg2BJKa8y5QYpCAElq6SA16Al8Ny1wQ3e/rQm+PNzGSxRH5NJnnfI317z4OR2pFude0rvZEFlBV8cuxn+Mmt/PkOacgWQTsXovMsLhIxI0QeyvZsuL7mU6c2I8ewcsWWdYTINWE77vSpkIVfHWEXViVxKm7PI//eJqSUhOgA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(14060799003)(35042699022)(6133799003)(22082099003)(18002099003)(261009223027099003)(13003099007)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gvGNEqd1c3ZLXolKT4xNIOsfTbF9UfeNHWAP1ykS0MAG4UR7gm50Qo/m9gw83Mtq9CtRtn0rYlz11qy+vzWXFYKnmlW12gXauO1UyaK7PkRUuL81FSqEwsI1z2XxK2JnO595vm4hTsDZAEM6BTSRToWRn6y29qcOH1lfvO+XcxKitiq96uolI9UrlscXmYG0PrrjB/MSv5PclxAuXfGkmUsXfsfYD09vWj+B6q6THMn1Hab//XzOa14f0JqiCeamgIpGm0zOalJ9B8QA5eSsY23sKXuGT7aODNp6J1vLRhblgK41DTv+Q+TADvvGdBwGy8SJrGtcQXBsgJatb+SFroP/edgSxjP+kBIvYnEMoo/CwrrXGAFbZZmNIw+gVnSNEqTUR/lA/frC0YB10IRv7gjngG0exWP+IckwtRP4BrckDXS3KfXtQhhT0cox5c9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:28.6554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb925fa2-cd9d-4bd9-7532-08df459cfe02
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11413
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
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

