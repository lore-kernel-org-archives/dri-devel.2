Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209D606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LtZ5O7aZ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LtZ5O7aZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5804E1125B1;
	Thu, 19 Nov 2026 15:47:43 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346FE1125B1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KQ/8tNM6B+fIZffWZkfS003cjmnhVD6SU8ihq66ienqPOomr5h7n5nU6JMuseHPTIpekM4OUKNfS1Qk4G7b0hKgxUcxCmJOKaJY2OTNwCTbTAtpVtvZOV6+Z2gX3VGT8l20YHZIKLTkkOcVA4sSxCRJQbRg7N6EDqIjVWbVb3bEGFS3KrhdRF3ilFmM3iMO9F9J0rn9g4JLL47/vBL9Bw5m8fnU6lPt7BdvyKX4IKXdE8YiOdMvdCex9ViFo1qb9gTLeiFkqueQ/r92kEpOTm8RYMWVPl95R35/0frCgL2Pn222cKJTruyojz+72IGowOw5IXZrNxQK1PxOza2nX8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsXH1ug/R+sHOhZDUsL9qVc7HTLAHNmKDOXx/c7lP74=;
 b=EYoVLPD6tvtZT53r87DfpkVnZ0D024c9o93Ks6i61SKWpQJ+/U7Ur1etHTd3tZTD6AoMA4JHauEz1JNlH01zApXRb/MvVG6wI5u4C6jFPbhS8BCUQ6aPtxPYjTOPgai6AHWc/sc7CBw0Ms08Hz5yshbYoJdZRr++x7fMqyShBgbH0v4Wf5XwuAqRcUsFKHbRsC9Og/mtgZGGwh4e2+UQKUDJGSzjPN75vKWFWIMomJWez2Ia/clNWvScq9TFDzENT442qikBI5VJ/DlcI21cIiku9ztPU14o4abIcMpRKr6I0n5cTBaG6n1tMbKYkKHxR4gac9odaZ89EbufU/q56A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsXH1ug/R+sHOhZDUsL9qVc7HTLAHNmKDOXx/c7lP74=;
 b=LtZ5O7aZEY54VMnR7HbelxbSIlD3UO2CAmcOOQOGtlhT1OVo4TRGu6sZmhqAb6d/kjBxkz3eh/UO6mVd6ZPSPbM4XuN3haZPZdflEBC4qO6CyMNeXfNXK33Yki+y8yctz0fVpWvO2yu8QRoGMRmVwCY6PhZtiHPIV497VT1Ej3g=
Received: from PA7P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::19)
 by DBAPR08MB5608.eurprd08.prod.outlook.com (2603:10a6:10:1a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:47:24 +0000
Received: from MI3PEPF00008495.eurprd03.prod.outlook.com
 (2603:10a6:102:2d3:cafe::a9) by PA7P264CA0015.outlook.office365.com
 (2603:10a6:102:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 15:47:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008495.mail.protection.outlook.com (10.167.240.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycqJ9mWX2GGIZKX+3ekR1YVi0I5ftZPFMeqbBqOtwJB1IzLBAgHnuwKxY79fBdXCdlqgEBh2QbK1DrfkyuaSILm2eaHg2Oqhx7lngMMIWVhSh3GWS4HjU5u75P8ZIhAiwRR/aLdxbEObf+pSq4enGDQvU52mzQk4p5iNoRTOfbLFzZ7DkItVjMf6yPwL9JanHWpHblZ1WxwkEL2z9SzcE+Wr+kzL8Gmq8M09RGur70ojn4zwrlfDZT+k/i0MtrF41X+wJ9iTjb/DKXkX7HP/4GAhpZNnrdNzDHqXqXsWK5q01Gp/grDxWZVIT+Ktg38vVV3lz7aXVsqQplm1EXPjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsXH1ug/R+sHOhZDUsL9qVc7HTLAHNmKDOXx/c7lP74=;
 b=XOxsaulHVTV8R47u8yjDthzEMmbwJiMTytKuyS75x03UEUQ68KBmX0uUb08iJwD3GP+oM86CA56bhqu279CsBRkQFYIBXI/eGs8x46Q24zXSY6Cx+vSUwD6/YBFxk99xAa65zKR1b3fLwa2Ld5IFVGzZGr1k6BI17NQS6h67ceZ/9fJJIc1j0MJQoAYhFYK24JDAS4SrAwf2xYaVkz3ge4AdtTIBH7Wt4SwnA9dnPt22ZMjLB6UGo2fgqUk4YXXvTOEUGxF6dPopk5Wht5DjEyXpVxgzcKoMKKRMrAdNdzt58I5hFDrUn2BHMBo2tMqQ7ewEcx6lXVH6AAC3iFkD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsXH1ug/R+sHOhZDUsL9qVc7HTLAHNmKDOXx/c7lP74=;
 b=LtZ5O7aZEY54VMnR7HbelxbSIlD3UO2CAmcOOQOGtlhT1OVo4TRGu6sZmhqAb6d/kjBxkz3eh/UO6mVd6ZPSPbM4XuN3haZPZdflEBC4qO6CyMNeXfNXK33Yki+y8yctz0fVpWvO2yu8QRoGMRmVwCY6PhZtiHPIV497VT1Ej3g=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:36 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:36 +0000
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
Subject: [PATCH v4 7/9] drm/panthor: Skip devfreq when explicitly disabled
Date: Thu, 19 Nov 2026 15:45:57 +0000
Message-ID: <20261119154604.2519184-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|MI3PEPF00008495:EE_|DBAPR08MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a20a20-16a2-4426-4da6-08df465467ae
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: 1XqsOGVYyhZ6y/e7zUNJM0lwazsAiz7vkd57XKWXC+nDbgWBvOLj5inXq/U0/OdYzIn2nmPw2OUjHppjk2xnUVpxexYqxvdHytKNgrsKJI8M8wF8eurbCmCNTyahByM1L6JOGmdFoQkJA8mydkQXZem+zsPSPBfUQEvfdnD1AGJR5e3RL6IwCz60/4D1NnSeSIHXuYQURwCPFrR4wMG9mTIjcCctZOQ0SS6Al0gsuHi5/M4O5y61og4+yd/UJ+hYdQWpb/9WWcBOmzvLzw1xd4j8LcFuBB4oaY80NLduJEDjT4zjcyFZuSECYqYVDEdnSQYMHWVPzXAykBtmW7yLEcsHlw95Ta4YWasii57lKMTEsQXS+xBFSLYl/tWaFSQj2ijy/3uZILymzESehey7Lf2ackhvt7VLJxH5RzUvvQJJTWL1yFNblRNu9hidKXLBQcW8GKoOLr1Y7FnuNoDFzEkaG0CobFpSI0MmLkHy8sgQ08uagqNIJUcUuLzB+FhzievbsOyPcJkiagQIAAA86omAfWwGJXis2VxDyTP1H7LtCA42zIaJg7JlxrbUFnL2OUzokljW/o7pieIcn2ujOga6SnbYoo8KR6imVflkej4r8VOZVeWETgTXA9LvsBJM4M8rR/JrwFcPfrEnu9pBtiIfFj/jBOVqaQSYkERgIHA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: tFW7f7PJEv0D9rJ5SOyWEzXim9SWIn26+Tv1JNGgqUBptCnr0REoH6fchdyN+l5qg3L6RlDEbAXwcMon0cs3OxpktZy8a0RSBibNNQw2+cNvI1btVS2wjHAVtHooC+WdXixG2JTyWBbYgBwfGcWx5K0aQMrlYVl9ruOl0PhV4Ok6nUWYfMFbjlK290gzjw3dKB5k0rEKM4Iyaf1L7fsHFWD6H9cx9QcJksauv/elcfZduburtw6TzZdIcwqnU0a5ZvPflpORZIp9Z8HtxJKM7Kx8qUdwrgqm+nSgjGOBo3sh9nssCzHLbuRT1GqkmmZQ2yHIm1n6Mx//xn32JwLS2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008495.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f4922dc4-b0e2-4de8-fc6d-08df46544b0d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|376014|35042699022|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rD0NP3WFwVl9vyw+LrPQ7RG7hmbzGRLbwtTUMu/JBfTxsGGhO/G1YQhhhufXeUxQ95uCi7tBf6jXS4yTcgggf32y9mfgn/eToPq8MAfG2IOBetv7EtbjlRktjZqlZzD36PUxqPl8iv85NYaK2FpvhGKgyQOmVZUVPlGwbYou27coWdJ1z/5brBZVJlfxSxqa0InLCwX2btsLbdyrgLZXUQtUC8cLrtjQbE3eI4QqB69JegOJ9PIHaV0bSMxww8qHicciUHGnc8r5BJkb1EWek/k/ypk+FK4/yLMFEOzSKSugXiM3u2RRoWmgg6A7ui+3qX7PiWmuGgnTK9GJ6BIQ52p0VW8NW3CsQohYr3O4ruZ/Xed73VEBCKFgbOk95gBTYppcIMjYG+JLvzyTrQQ5tRluyzn+2f+EYxxwIfedyiQmwXPfXmUDKJerTo1hzw0qpcYHfbPB/71YkUqlKw36Odm7+Dkb+zm0EvPFN3ZMbdPO6ArlD5jhljwRmWUREUXHuGCxrwEdpWkEilxdtdLenqVqKosijfkkLP9Ls7ubVYrlL+0uED8mxMlO8QNsQpmiuy2PhY7vD9ZiF4ULG6+Ws2WoZ84J2acwOtAi/UK+VFf3W3O4yPA2BOUFihsUoMwAPTEu8uEoNtFjMUGAv69zpJKB0/J/Nl877S5sEPjJudyl9hBszKWzB+GCtQWblIV9/NoNO0XeTSbSNNaKPUugzA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(376014)(35042699022)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EzpYPSM5mmLsRBXNWJfgvUMY9KnpbPYWJ3/GUeSswrig0vE7rUgmi2UB6pCZAUgBiZb2+Vao9BGE/0Hv+LCSBfpGgSniBL/HWya+rePvWJYHzmdPi2yEskBQsraJMMRpRWD/fMczNt2aYTqAYOyW5lDV6m691c5g4waTW8qVHS3JpfaFbVRpZsi9Ca5EONjhSAN4j4ZGiNWVZrE0QOEUo8Qs9N7PNBXYWZcmy1gG3vZcxjbuq7QDD0leIV6XsL4jsqKNCe99tpdyj973/GzCZnikORRsBAsCxSyBA7uehPPnwU8aobuJP47x4MF0puVlfJCjn21MeGQuN3B0VGQSFUdLNpRCkfU7/kEfsjIzcSvq3oVr3Djya8y1/6TMdmCo/LeZgYUGObLzBNoWHMbqTdY3CbTkYeRFr9TYOrGgkWZeoAQNwNLDkXT24/P/BA2I
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:23.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a20a20-16a2-4426-4da6-08df465467ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008495.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5608
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

On Mali v15 AM systems, frequency scaling is handled outside panthor by
the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

Add generic devfreq_disabled field to panthor_soc_data to allow
disabling of devfreq for other use GPUs and make panthor_devfreq_init()
return early when this flag is set. Ensure frequency can be queried
without devfreq instance and omit drm-maxfreq-panthor from fdinfo when
the maximum frequency is unknown.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Use panthor_soc_data flags instead of compatible to allow earlier GPUs
  to also disable devfreq. Resetting R-bs as a result.
v3:
- Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
  is unknown, as on AM systems without an OPP table.
v2:
- Directly call functions instead of storing function pointers.
- Picked up R-b from Liviu
v1:
- Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
  of direct DT-property check.
- Support frequency query without devfreq.

 drivers/gpu/drm/panthor/panthor_devfreq.c |  9 +++++++--
 drivers/gpu/drm/panthor/panthor_device.h  |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c     |  5 ++++-
 drivers/gpu/drm/panthor/panthor_hw.h      | 10 ++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4afe..8b215e24b02c3 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -12,6 +12,7 @@
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_hw.h"
 
 /**
  * struct panthor_devfreq - Device frequency management
@@ -154,6 +155,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	ptdev->devfreq = pdevfreq;
 
+	if (panthor_hw_is_devfreq_disabled(ptdev))
+		return 0;
+
 	/*
 	 * The power domain associated with the GPU may have already added an
 	 * OPP table, complete with OPPs, as part of the platform bus
@@ -324,9 +328,10 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	int ret;
 
 	if (!pdevfreq->devfreq)
-		return 0;
+		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
+	else
+		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 
-	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
 		return 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f0a96ff0f13da..31f9341b5aeda 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -45,6 +45,9 @@ struct panthor_soc_data {
 
 	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
 	u32 asn_hash[3];
+
+	/** @devfreq_disabled: True if devfreq is handled external to Panthor */
+	bool devfreq_disabled;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef42..b4d3d339b04b4 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1715,7 +1715,10 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)
 		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
 
-	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+	/* Omit the maximum frequency when it is unknown */
+	if (ptdev->fast_rate)
+		drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+
 	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
 		   panthor_devfreq_get_freq(ptdev));
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 4cb603a3acef6..f93a6b16df2af 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -95,4 +95,14 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
+static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
+{
+	const struct panthor_soc_data *data = ptdev->soc_data;
+
+	if (!data)
+		return false;
+
+	return data->devfreq_disabled;
+}
+
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

