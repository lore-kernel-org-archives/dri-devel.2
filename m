Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA0606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rETH6i7+;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rETH6i7+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B3610FF00;
	Wed, 18 Nov 2026 17:55:05 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B627410FEDC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:42 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q2CnwvZUsHUygIcsXVy5CGVyFilrCPlo4/12L57/f18OYDAFYrFzFbTCNIaRJ2goZ4kqGFLUxF8Zy1gnqE4d/TcajWQzMynHGd80rv/HSdgATZAspTIMBME01wCj9xlCmAb91ajtDrFdD8dcquDVCcEXF1lEMW+vDjRdUdy8IImQHt7f1qQ5AjLf9iScy/boH/Oou11ki4JjnkvxwFpzrWjPIQeFdevWOd5WYpjpyyk0MiUqD40B54ckZQ80Fdeay5DqjCp4I2Y0KNn2ibCN2SmrhujlgeuND5kZRAWa9B5KB4oWrCbEUpiY45Y4qX58xIXgdCWjQ4OPN84VlYVkuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCLIJIJtEybAX4dINgpMesqj+mtcfEXtr7qHysa+eTk=;
 b=abGFBSTgCeTpz73sUkNFTn52Q4Qu/6jYpcLbBPsMJBvZWz1P6wL9RZm3j6J1CUt63bLLXbvz+JOTPZex1KQXr/uW8ePP/2FQWLTzGhO0n+5boICA7ecA0YgWkZTjd2DjR66L/dKeSv53pEh7sjo3TsPJsZO785+i3igr30XIz9yGjYUHNpw0SlfyXoIg452H4zZujMhVGg8HFTrMizC8whf9NrzFn6OLqmCQEW+ZoigEOHThk7eymskJKyytoN52z+4OhFYLBCK1FuYOmWTmGyFSHCyozsBPHv66J4idGMUYBuohiAm+cSFon1agSTxd7BWCOKKRVv0egxZ44s/zrQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCLIJIJtEybAX4dINgpMesqj+mtcfEXtr7qHysa+eTk=;
 b=rETH6i7+w8RxdYXqJWhPmLxXrL1mT/V9lxTAYZ5ZsdhIwvyIHOLzr54TSlxYP8e3SgxzsvHxymg/cvGoq6bsRP43fxXylh3HnMyyo4iZ4RAxraExrFjr8qxPeqngKANdEpufzgXIYHFBE+3JZhrMe+AiZjUaI+N1Xo16Pj+0ujA=
Received: from AS4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::20)
 by DBBPR08MB10461.eurprd08.prod.outlook.com (2603:10a6:10:535::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:36 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5de:cafe::2f) by AS4P190CA0010.outlook.office365.com
 (2603:10a6:20b:5de::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 17:54:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Wed, 18 Nov 2026 17:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc2+cKBuSPZvIL+d8ACBXVtU84eaHwv10nZiKkp6rK4mCIMENd41lJ2B9MWzPxWdb6qgVqlRkllrOAX2GkE8rmL0CUCvH8sy94BnwTAw13+yXS1Ln/tvos9QUlhzDDzC8e05SvKruqhtog6AqEIIT+iENBZoDqeRq2N0wEM9wpUl3mb8D16dObut5pLskLX6X2HN6dU/F7NxpQoDi5DlJ7AXU8M11bETH2t7SSdOUHf5927PJ9SlK9QQ3oBL2rGTO4SNEr30qL/Hju8y5gkuUkPvEe9EpoqFZW1rV3AY3lhXuktyDNOVIQnzLitFOYdJSr6X9uuVR+BXozLXG+hlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCLIJIJtEybAX4dINgpMesqj+mtcfEXtr7qHysa+eTk=;
 b=aq7wyiKT/pZxQJThKYp81daNsAlxm9vWD+ebzaHg7qEo/vfbsibxM1Oz7RZvjQki1S8o8xP+DQkKRewGCyxWOhPSYvkT79SFShePgov04i7vu7/87DjDEhmVinrzl9YAYOtbp3qSDOTvUXwqsZXMPEY1KzQ36IZ88uWYIwtotRQoyMUXM+1R/IF7jl68qkzLG+jwVTbkEYttaueOlfXUVjd+81OLLibagS2CqSOhvNvbT+73asqrfrJl5pI7xMPQCLUqxjybeqpOSyEVhXzHJHdavlp3KikWScrAKZ8gqXPOfUYFdSoKw8odMnbTFxuNZwTlKlKnLgQ6eSxzHMJFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCLIJIJtEybAX4dINgpMesqj+mtcfEXtr7qHysa+eTk=;
 b=rETH6i7+w8RxdYXqJWhPmLxXrL1mT/V9lxTAYZ5ZsdhIwvyIHOLzr54TSlxYP8e3SgxzsvHxymg/cvGoq6bsRP43fxXylh3HnMyyo4iZ4RAxraExrFjr8qxPeqngKANdEpufzgXIYHFBE+3JZhrMe+AiZjUaI+N1Xo16Pj+0ujA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:02 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:54:02 +0000
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
Subject: [PATCH v3 06/10] drm/panthor: Move register base offsets to the HW
 description
Date: Wed, 18 Nov 2026 17:53:22 +0000
Message-ID: <20261118175332.519657-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|AM7PEPF00000054:EE_|DBBPR08MB10461:EE_
X-MS-Office365-Filtering-Correlation-Id: 433101a8-6446-4553-4adb-08df459d0217
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|260925021911599003|260925021311599003|260925022911599003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: wATj49zeq0i0SMrCYzOLbEmJBUaeMPFEvEcgkunIH/XxDP4H3ibVm02PBI7ihv2Nf+6mQKrW/ilvz92KNtO0P5DEFfB6uS6zcMzU0NRxl7Av7HlHmgw4LszLOTQXbxmoMj/iofYaghZiX3p2sWJ2Onj3eMO1sjR19/Hnjr20z0wKf9iVITZa7RK9E9kKtDSTINMK0ulxNtudTAKBXvr/UXZSeobQobK2Irr1h6lZsMUBh37dBP3ldkBVouFURCFvyqXSBYOboDn8iOpnT3uQ7Kog1jGmeso99FqsJIKlqHAc+JVSMSpbFLG6WZYb1hSA1LYThKJkk6G8J7jwOMmOZhXZBrmO5AsWapR1Gno1DhUeFkXJ1kvIImOJzq/V/LlfwxRz1yLyOubEwpWeoB4HlwxjDk6W6iiBCEa8haIHkfc8HjHXLCRZ3vRpXHseJbN0Jr8owv0WZKyQ+CJDGFvLsO3+4a937jA01/rIOIZbTZy8wQVHmX4txCFR+TCOoZY4TAutSArgAtQMyve5mxgUYxPcVLmPUCdJ/IRmhJAtKFGNU0S9wQgkm3LMdjlr1ojIqNcomJ0XGurcZlVF3HjMaaejS5XJepDDYBBhMU6+AOh2GwnNeXsFyVeHFedC8Us3bHODSKpe4kn1jV65VhnEKTkO9uPCjyq1Q7GYnP8VtOg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(260925021911599003)(260925021311599003)(260925022911599003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Y/MbTPRRkj0EuseiCaV124eCl3y6vgso7M7m302w66QopjIRQS22Dbfm/VbiVXRP9NolvzmJ3R50/V8BwMYQRN1NWsABkkGh/5bO+PyhUpmsNhXFkh+qvYyR894LbGbO7iWW/VkAVrF1dvJ5Zv2ovAbCS/5mx0VzeyshXbYhCWnQtaYbpEZWcD01JOM4s6opyUbFVkXuKYqGIc58p7uJFBBXkeo6nwD+uwILWW7ppAg3ZFWsFvPzenEkicZpjbWqQR+g4i/UH/VGIHyP77RCJTeWheR14cvaZmWuDxMIzMVxOUjZI1TZlNr0gaDt773s5h+oYu0L2383AajTdZfOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b6d82e95-713b-459d-04ff-08df459cee20
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|14060799003|35042699022|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261021121427099003|10067099003|261009223027099003|261102123227099003|261021123027099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: qJFhLG6+a/TU7fFgAua3DYDQuDr86AJcA2CICPF+Pj1Q5sGTjpVAqjdjTP7kfqfym+hWtdCEhj/fBdKM3CJVaGLI1tVTCo5mflY3I7sAtSwm5dZ4Vebck9Wj42dN0tUpac4EscY12TdA0eOk2gxOhyHynUyJLJsRvp2MFf4WdwwIUtiee/KpiKX4FrcUco4rYkWjmiR7OokeHqNWdtXgdj4QXQEpOJ2J78p19852MjwfJjjoAsY5co/S11Dx+I1O7kasSTT3AHlBf8yoQzAUYwNr+NNA4Q8M/0NbSOyBxjDGwpGZTdY79U1CQBW0m3pxobk3y58e1SyI71FtxhSXYWgCUdHy9BPsPjF36/Q3k8vIPsrP7l/shNREirlXeP6wxeEORfGBlK4w7rRUcufl6lcNEkry36/cGGOpYOhgvRJgnT6UA6WhOJb88qQyBQzDip7iiLkYCLnM9eF7iRSQW8dDbwy84V/WUzl7xvOdBeHcl5N3L/rpisrZ3VQ3/voiOlL5fbTz/GrD8pCEFJR9nc+AWt8ZjTduNYP7gGAKf8jKNuvHrrs9I7w7hmc2+3OGIZY6Zu8Gzf+96gIN4+cLZKwDBdCDYvynZXAUkkaJAGDOq1Na66UeKJFkDf+5iggiU5mb97IrbFts06Y1Q43paB5NgjhyEk2Bfa3eg/E3oR9tqokh8u3cBCU3IWl7LgzVAuxvaiXw1PDGwHOhUNuxLA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(14060799003)(35042699022)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261021123027099003)(260925022911599003)(260925021311599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r0lnkSKaWwzUJeOEOsl/sLhzQuWf6tJyGe03ZEvyjKZ32np5io6P2Drl7THQ5Xu/L2BtqbVc6ktbScdalJ3goW6JDOC9pWYKKfMQCulKfcrTSJ5EO8rxReX8lxgsPZDELULgqpEvSoGAaWTQQPihLO7mRAQphQZ4ZEE6Wr2WQpBM8XTSEH0KROdxJ89k1xSKr4pFlndYzGnf4GJu8XM/8QlluQQNN0UGIsNp3hlizcD0cg6hJrEoxn2p4OWhyTn7tSd8cewYri42LXZ1LnjM0LR5EArxSm6b2J1PQAlxFk1nYY9DrWBoLgr/Pb6k3N5+jckxiohPWbx3+eR7kSkA0yJuvPtEeYjeeAWMFVJMs3IwF9F/WqYqXubwdXNwvimHxhMuC62pfrPUhOqMNNysyj2p+chfc28INj0FZC8h/DP0kOIuGhyqjPS7I3ufucRl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:35.6197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433101a8-6446-4553-4adb-08df459d0217
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10461
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

Mali v15 reorders several register regions, including GPU_CONTROL,
MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
fixed base layout across all supported GPUs.

Add per-GPU register base offsets to the panthor hardware description
and switch the GPU, FW and PWR local iomem setup to use those stored
values. With the base addresses now owned by the hardware description,
drop the corresponding fixed base-offset definitions from the register
headers.

This prepares the driver for GPUs with different register layouts
without changing the existing behaviour on currently supported parts.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
v1:
- rebased on drm-misc-next
- use a generic panthor_hw_regbank structure for all register offsets.

 drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
 drivers/gpu/drm/panthor/panthor_gpu.c      |  4 +--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 23 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h       | 29 ++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_pwr.c      |  2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  2 --
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 13efed3a2ea72..679ea1d233d53 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1500,7 +1500,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
-	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index b2e59cfc22b00..a3492f7f913f9 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL_BASE				0x700
-
 #define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index c5c37f22993d6..ab54119314da0 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -159,7 +159,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -176,7 +176,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 		return irq;
 
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
-				  ptdev->iomem + GPU_INT_BASE, "gpu",
+				  gpu->iomem + GPU_INT_BASE, "gpu",
 				  panthor_gpu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index c7581b6d4c5be..60819c4ace428 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
-#define GPU_CONTROL_BASE				0x0
-
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index a26fe42e14f78..f72cff260065e 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -38,6 +38,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.power_changed_off = panthor_gpu_power_changed_off,
 		.power_changed_on = panthor_gpu_power_changed_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+	},
 };
 
 static struct panthor_hw panthor_hw_arch_v14 = {
@@ -46,6 +54,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.l2_power_off = panthor_pwr_l2_power_off,
 		.l2_power_on = panthor_pwr_l2_power_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+		.pwr_control = {
+			.offset = 0x800,
+		},
+	},
 };
 
 static struct panthor_hw_entry panthor_hw_match[] = {
@@ -197,7 +216,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 
 	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
 	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
@@ -223,7 +242,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
-		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 
 		/* Introduced in arch 14.x */
 		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index c4a490bc39de6..0a82152d772ad 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -27,14 +27,39 @@ struct panthor_hw_ops {
 	void (*power_changed_off)(struct panthor_device *ptdev);
 };
 
+/** struct panthor_hw_regbank - Register offset and instance stride information */
+struct panthor_hw_regbank {
+	/** @offset: Register offset relative to &struct panthor_device.iomem */
+	u32 offset;
+
+	/**
+	 * @stride: Register offset between instances, or 0 for non-instanced
+	 * registers
+	 */
+	u32 stride;
+};
+
+/** struct panthor_hw_regs_layout - Hardware register bank layout */
+struct panthor_hw_regs_layout {
+	/** @gpu_control: GPU_CONTROL register bank layout */
+	struct panthor_hw_regbank gpu_control;
+
+	/** @pwr_control: PWR_CONTROL register bank layout */
+	struct panthor_hw_regbank pwr_control;
+
+	/** @mcu_control: MCU_CONTROL register bank layout */
+	struct panthor_hw_regbank mcu_control;
+};
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
-	/** @features: Bitmap containing panthor_hw_feature */
-
 	/** @ops: Panthor HW specific operations */
 	struct panthor_hw_ops ops;
+
+	/** @regs: Hardware register bank layout */
+	struct panthor_hw_regs_layout regs;
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index b1000001325ea..1cfd4b658c81b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -502,7 +502,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
-	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 80d8e1e522298..e1f3153285bd7 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_PWR_REGS_H__
 #define __PANTHOR_PWR_REGS_H__
 
-#define PWR_CONTROL_BASE				0x800
-
 #define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
-- 
2.43.0

