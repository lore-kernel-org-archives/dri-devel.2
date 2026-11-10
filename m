Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D8606D746
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A5gufc6M;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A5gufc6M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD58A8913D;
	Tue, 10 Nov 2026 15:42:14 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1634310F7BF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=frajuOy8VKVzGMsEn6WpYHTPgwM+9cWLuI+SOWnooT3oRnfwBmi3fl2af/t2Q2Y3bZjVJ26VZ7IiEqKdnwx7i9hQQ8V2qnE0LmuD25EfnYsfrB6CegxMn97QN7TD7Fef16gpFxZ2oqLfiR/QjizWQAMvuYSHXi/M/Xfaw4tktdsvrxp1X7hW86qwMYStZ6AIb1pR8LNy/q7ZNozu9I61lM8mye7h5kC89J7KlzLt6GrtI8+QRbXIzQdmos5kCX+BCyVssBAW0HepRcrHZ1LltIIoQ85h5BHtXIg8nuR2yf0jG9SrW6hi+hM3IXkkCEDPW4Xq4iarx2i6jYdnvq2vQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmkF7S2X54EQ5Pacec3Crwd7OqkRIwQwlBzszhSe7Vw=;
 b=dLMf7rMIrSVnip8EOSHZINN+kd8qCwf9k0l21bsgQXkltw0R0N9a7KN8Cm3kSb2+8kIMEe04v4RZvctP/vBb5LvGOTQyESzh7vdldapf3IOULxNp1zDLnox4GDOpvuoEwN+9YZWFOJepmVKrYpOCpHfk/4ZONlDAmrQXr0Y01CdEMTNyxzcI03kWIjoxYtDyC7JUMVJa24X7ngFz6FMWUzcFBO6Q/xtjwThZyGxD0JjLUNxRLDhEM10DPmHDKlbxZHDMwwD4BRI7Zch09/YDHTAvWEWB64b9F06t09bgzo7R1sct90H+yTmHZ3eDwuRNry9JPy0KM3D9W8vXDIU/4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmkF7S2X54EQ5Pacec3Crwd7OqkRIwQwlBzszhSe7Vw=;
 b=A5gufc6MjGwDjKyvGOTdw3ER6bt2UUBq+/O9+d1eZ1ajlF32mDWTc+LV00J2Cpyfdt70+hx0zQm4c9PDs80z+7OwxjwtrdrWS8ZLo0XqR8hgSRhiqFsWoOXbdlKA2Ibj2HaEhqkqn7a1xr3tdWoqqtV9/KmpUDSOplS837CC90Q=
Received: from GV3P280CA0041.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::19) by
 GVXPR08MB10575.eurprd08.prod.outlook.com (2603:10a6:150:15a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:41:41 +0000
Received: from WA1PEPF000099D1.eurprd04.prod.outlook.com
 (2603:10a6:150:9:cafe::a1) by GV3P280CA0041.outlook.office365.com
 (2603:10a6:150:9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 15:41:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099D1.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUmXXnM9PkkbEe9IUpBUbd4TbshqjctGWyHGStkkaJxZfavLX64ezxYEz8hQ1GJ5t3vx5hP4HN53cBBa0+zuOXHtWxZ90NmPYqDK1BkVvaA3vjk9LRVskHsNTj/Ur25CyzpAh7BI0nbBmmiDjsxLc8rfBUBug+3t/pYvGv3ozUxSie0lvemb6qJbyH8N7rBGCx/2mh2pTgmUKKWiFfRxCCmsa2SVKeK4TnCQh6ARIMXlUU3VT3Z4mWYI9ZajQ1f/V9A4uajwMYxhop0si1rfEboWRAoeOBV7xwbsP6dEu5CUXTE2Gnxaw4KSAnTOkAkUy3owh8x8zRr91k1IIdgYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmkF7S2X54EQ5Pacec3Crwd7OqkRIwQwlBzszhSe7Vw=;
 b=u1zlCGHMWXl/CQnRK1wB5KdRlW0jUv4w9w4hJriAlrjJLmJlw8/Wdb9t0MnQOIRiymTNcZWprhCeaBXsE9SMsGxQs6p0fkDtnKyuq2UL2ipG4hZJ0qdtfXV3zFdwN1qrx5QzUzJwdgCoHY35lSLHvI9U04qr52iaoxp+wYLzoSloM37hqHt1HPlhzzAok92XIbQCHLSPtONpo6i8cMwoD8wuew80qy7kDv9XNiizZjW4UpumIt3u9FuOEsj1z7l9Td7vuTPqwLAdSjb2x9Zv25cFFgxerOxY7+oPdBDv4jTd9FTUpFue3uCMW19p5Qg0BtIEJEBovVN4RyLbUO7Iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmkF7S2X54EQ5Pacec3Crwd7OqkRIwQwlBzszhSe7Vw=;
 b=A5gufc6MjGwDjKyvGOTdw3ER6bt2UUBq+/O9+d1eZ1ajlF32mDWTc+LV00J2Cpyfdt70+hx0zQm4c9PDs80z+7OwxjwtrdrWS8ZLo0XqR8hgSRhiqFsWoOXbdlKA2Ibj2HaEhqkqn7a1xr3tdWoqqtV9/KmpUDSOplS837CC90Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:07 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:07 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 19/28] drm/panthor: Add AW assignment tracking
Date: Tue, 10 Nov 2026 15:38:40 +0000
Message-ID: <20261110153907.3241978-20-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::13) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|WA1PEPF000099D1:EE_|GVXPR08MB10575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9be522-b747-4098-4216-08df3f411d19
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261102123227099003|261026121527099003|261022113327099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: RcCzW7L+Z62lCSowMqZwYWuvTIjxeBNAOASma0OdIF14+KzytFM63VYQ3KYwSKMwMHEZUxZYV7kQmq3HF9eqMK/+rJ1QNQqeN7J43gA+1ead/i2gcsweSmby8ICgzHsrupR6y64Skmneuy0RNhTLibRO8sc1OwsEs+QAtJnHQ8Z1ENfF5anG3jZKj2lY3XuENDkc1da9ZK7SIgH0QKjsR9b75OZ0LllKqrLrFgm7YEhxyb3WBe2wo8ej5aqTke/dxPi0sIaTL9LE0gwSGP7wmG5s6f+3FZ30C0ptKx1ZE3cczxQdIYDRI01RqQzj/Oarc5oct4h6d74IY6LeN85mbBhe5J41lqN3RoNhALfIrMq5RujJhbX/EOQZPHaCez1kpETRSb9QNhhLqMl96f850GjhE1eMGuNL+MnAqVd4E3q/jILwJ8KbeYIZ+5O/pv+mWcrDQwt1shnAHQ9vOnB2TtJu/5JzMERvkzVQEEf/MaXmgjJhwsZWQ1hyIwSb8Pw81r83wPdFzN2hr1AoM8AyzmCus3LzVdp8WNbp0DxoDpd0TdB5LrpWpV3BreWhpVqb1uxtvyt1rp4GromUWxHffm7P4mLUYXloIYjViw+bZhgUdlb94v6YTj9jvOy2xr2zxbmzImbrIL89HPB61FKqd/lv1kkmagLiPskog2TYRz0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lBx7NQlYdVM9SmXqwkRCSC5JJHIk3L5F8Qjt2yCmiJpVqRSSEktDlXjkWuLb+y4MWaDX4teDf2eTtJc/K42p+cJcuhYZ/zUv9IfrB+CyXN1U/JTM5p9NACs0qlsVQM0Vb8EEjKAZMnzMF8DDshXn36/65nP0OzHwyraX8HeQw9W5KCRj+O0TSzm61hE8wskwNt/nndpgjj+YTvgXOQOrDJSM9hmOd0q99YzUrIYGaDusMO8NmscVU/4y87JwuiVa9JKhUAgHQitniVgmk+KLkRpUTPqCSc7sgNK+fqpZqMglC4JWMMmqYTlOgq8jjlNCjWae57fMkukbe8lAIeLg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099D1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e9a2212-8827-492a-cc98-08df3f4109b3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|23010399003|14060799003|1800799024|36860700016|82310400026|261009223027099003|11063799006|261021121427099003|56012099006|261022075727099003|261021123027099003|261102123227099003|261022113327099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: E3afNxbRQSkV/0MozTQ615ZxDt5lWcWIR4BAM2ueBzuOPKwm5v5eG0HjyJmjb70cxjYuvHx8eLcGm+F4uEkwvft3wYG+H/AsCPN5H54p6XilKyLVaw8e/js7VeMOYc4oxX6ua2qSNqZMMswlp0Sblym48VVV8dMIlAEkhMrhWsxwoe+eUGs2BQavLxkHaNpOA6gjUBBQfTVj/rqYbRHkYACy5yfjA5rF7LAAfQ0KOQUlhISruRUQ18Td/sa1kP/TQQGEIzrXkUhcyf4BpMYPDD97iihOJ3l58mVlUnBAnS1OEBoG88LRW09OluhTddKUGTa66MY4L7yWMzZDWpjxbmJrF4BZNr5mDvJ97TwegFEglkUS63yq36LRKwdw64NT8uSrizCAUaQ6lssmddjXSz5YSbo9QKg/+xGJM+K/0BqB45/nS7RyKGDThzZgh4tDPO5MZWu5JfGW9Y9V+rszdV5Zs0rwiGEjsYWXPaD7KdSyzwYvCaEd5sjOAsEMPpP2Cz81+dfmbE5hZIunHOzucggC8pxCYCJOnLWVa9q62tyfPV1h0+j6pjt7ZQaZ3dsGhcZOKyJKPEw6koWKCGJLbV+XxBIWHFj5dRATiStozQ4wxPdUhyg4Im1aPrnWvSJEHlAmVsECZAwvlfJ/q8sIjEID6MKx+Elyamrngj1pPxyoMZiykeEKw9GyIdGK11BG6Ki/XyHnTPM6YJIOgC2MuA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(23010399003)(14060799003)(1800799024)(36860700016)(82310400026)(261009223027099003)(11063799006)(261021121427099003)(56012099006)(261022075727099003)(261021123027099003)(261102123227099003)(261022113327099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DpJKaZ6NecqjhjLyzsvoMkqMG6UjZHiMar6AbT/vdfU5as54OD0oPCHpJYIM5p4ovndjFLq7VRxEfcZq5YeGT6JkYH5j+LfnJv3dWaNPKOsr/C+Xnv4D9oas4mCNo8jyKHZchGEA7llw1sBGxGajUcKNZlFYJdBHPXVs927uB/3SV1RFsws9f4OZWdYk/GwmA90nSAmyZXZKYaSi64J4ozMG8K/0sD9shJh2o+tmz5ByRkE89sbz6vxGeJJ1f8f6eP5HJMOwZqPkxurw8e/mSH2mh2YmuP5loU8Q9TnZjyfBZ1s5xXZ7IDpaRusSgLPw6jJLvooZFdTt8WXTfwyOKfKA9Ld3tP3KDySoJPXEbmS+Kd1KpbsWs49Ga17hwDymmPZlwHRsOB8a+hle6o9h9qGyEp3JUpaBcsvSCoeT+KlllhEKaH1cPNibW+1ipugG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:40.1407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9be522-b747-4098-4216-08df3f411d19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10575
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

Track the scheduler assigned to each access window. Initialize
assignments from the access-window masks in partition child DT nodes.

Use the AW mapping to route request, idle and stopped events to the
assigned scheduler. Use the scheduler ID to select the partition for
grant, stop and close commands.

Record requests from unassigned access windows and forward them after
assignment. Keep schedulers disabled while they have no assigned access
windows. Assign all AWs to partition 0 if DT property is not set or is
zero.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Assign AWs to pc0 by default if no arm,access-window-mask is 0 or not
  set.
- Introduce assignment_lock to protect assignments allowing serialized
  lookup without the need for READ_ONCE or WRITE_ONCE.
- Add pending_aw_request_mask to track and replay pending requests
  arriving before AW assignments are initialized.

 .../panthor/arbitration/panthor_arbitration.h |  23 ++
 .../arbitration/panthor_arbitration_drv.c     | 244 +++++++++++++++++-
 .../arbitration/panthor_arbitration_sched.c   |   2 +
 .../arbitration/panthor_arbitration_sched.h   |   3 +
 4 files changed, 260 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 1350a5982a93b..9a6c251d962de 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -4,9 +4,11 @@
 #ifndef __PANTHOR_ARBITRATION_H__
 #define __PANTHOR_ARBITRATION_H__
 
+#include <linux/bits.h>
 #include <linux/ioport.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 struct device;
 struct panthor_arbitration_sched;
@@ -16,6 +18,12 @@ struct panthor_resource_group;
 #define AM_ARB_MAX_PC_COUNT			1
 #define AM_ARB_MAX_RG_COUNT			1
 #define AM_ARB_MAX_AW_COUNT			16
+#define AM_ARB_MAX_AW_MASK			GENMASK(AM_ARB_MAX_AW_COUNT - 1, 0)
+
+struct panthor_arbitration_dt_info {
+	/** @default_aw_masks: Default per-partition AW assignments */
+	u32 default_aw_masks[AM_ARB_MAX_PC_COUNT];
+};
 
 /**
  * struct panthor_arbitration - Arbitration device
@@ -32,6 +40,21 @@ struct panthor_arbitration {
 
 	/** @sched: Pointer to scheduler data. 1 sched per partition */
 	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
+
+	/** @dt_info: Properties parsed from the device tree */
+	struct panthor_arbitration_dt_info dt_info;
+
+	/** @assignment_lock: Protects assignments */
+	spinlock_t assignment_lock;
+
+	/** @aw_sched_map: Tracks assignment of AW to sched instance */
+	s8 aw_sched_map[AM_ARB_MAX_AW_COUNT];
+
+	/**
+	 * @pending_aw_request_mask: Bitmap of unassigned AWs with pending
+	 * requests
+	 */
+	DECLARE_BITMAP(pending_aw_request_mask, AM_ARB_MAX_AW_COUNT);
 };
 
 /* AW to Arbiter events */
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 48016d0d88557..6479a7602868c 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2026 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/types.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
@@ -17,6 +19,28 @@
 
 #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
 
+#define DT_ASSIGNED_AW				"arm,access-window-mask"
+
+static int to_assigned_sched_idx(struct panthor_arbitration *adev, u8 aw_id)
+{
+	int idx = -1;
+
+	lockdep_assert_held(&adev->assignment_lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT) {
+		dev_err(adev->dev, "Invalid AW ID (%u)", aw_id);
+		return -EINVAL;
+	}
+
+	idx = adev->aw_sched_map[aw_id];
+	if (idx < 0 || idx >= AM_ARB_MAX_PC_COUNT || !adev->sched[idx]) {
+		dev_warn_ratelimited(adev->dev, "AW%u not assigned to any sched", aw_id);
+		return -ENOENT;
+	}
+
+	return idx;
+};
+
 static int panthor_arbitration_runtime_suspend(struct device *dev)
 {
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
@@ -57,42 +81,226 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static u32 arbitration_get_sched_aw_mask(struct panthor_arbitration *adev,
+					 u8 sched_id)
+{
+	u32 aw_mask = 0;
+
+	lockdep_assert_held(&adev->assignment_lock);
+
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++) {
+		if (adev->aw_sched_map[i] == sched_id)
+			aw_mask |= BIT(i);
+	}
+
+	return aw_mask;
+}
+
+static int arbitration_dt_parse_assigned_aw(struct panthor_arbitration *adev)
+{
+	struct panthor_arbitration_dt_info *dt_info = &adev->dt_info;
+	struct device *dev = adev->dev;
+	struct fwnode_handle *partitions __free(fwnode_handle) = NULL;
+	u32 seen_mask = 0;
+	u8 seen_partitions = 0;
+	int ret;
+
+	partitions = device_get_named_child_node(dev, "partitions");
+	if (!partitions)
+		return 0;
+
+	fwnode_for_each_child_node_scoped(partitions, child) {
+		u32 pc_id;
+
+		if (!fwnode_name_eq(child, "partition"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &pc_id);
+		if (ret) {
+			dev_warn(dev, "Missing or invalid 'reg'");
+			continue;
+		}
+
+		if (pc_id >= AM_ARB_MAX_PC_COUNT) {
+			dev_warn(dev,
+				 "partition %u >= %u not supported",
+				 pc_id, AM_ARB_MAX_PC_COUNT);
+			continue;
+		}
+
+		if (BIT(pc_id) & seen_partitions) {
+			dev_warn(dev, "partition %u already present",
+				 pc_id);
+			continue;
+		}
+
+		seen_partitions |= BIT(pc_id);
+
+		if (!fwnode_property_present(child, DT_ASSIGNED_AW))
+			continue;
+
+		ret = fwnode_property_read_u32(child, DT_ASSIGNED_AW,
+					       &dt_info->default_aw_masks[pc_id]);
+		if (ret)
+			continue;
+	}
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		u32 aw_mask = dt_info->default_aw_masks[i];
+
+		if (aw_mask & ~GENMASK(AM_ARB_MAX_AW_COUNT - 1, 0))
+			return dev_err_probe(dev, -EINVAL, "%s[%d] entry exceeds max AW count",
+					     DT_ASSIGNED_AW, i);
+
+		if (aw_mask & seen_mask)
+			return dev_err_probe(dev, -EINVAL, "%s entries overlap",
+					     DT_ASSIGNED_AW);
+
+		seen_mask |= aw_mask;
+	}
+
+	return 0;
+}
+
+static int arbitration_dt_parse_properties(struct panthor_arbitration *adev)
+{
+	return arbitration_dt_parse_assigned_aw(adev);
+}
+
+static int arbitration_sched_try_start(struct panthor_arbitration *adev, u8 sched_id)
+{
+	struct panthor_arbitration_sched *sched;
+	u32 aw_mask;
+
+	if (!adev->sched[sched_id])
+		return -EINVAL;
+
+	sched = adev->sched[sched_id];
+
+	scoped_guard(spinlock_irqsave, &adev->assignment_lock)
+		aw_mask = arbitration_get_sched_aw_mask(adev, sched_id);
+
+	if (aw_mask)
+		panthor_arbitration_sched_disable_clear(sched, ARB_SCHED_DISABLE_RESOURCE);
+	else
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_RESOURCE);
+
+	return panthor_arbitration_sched_start(sched);
+}
+
+static void arbitration_retry_pending_requests(struct panthor_arbitration *adev, u32 mask)
+{
+	unsigned long aw_mask = mask;
+	u8 aw_id;
+
+	for_each_set_bit(aw_id, &aw_mask, AM_ARB_MAX_AW_COUNT) {
+		int ret;
+
+		if (!test_and_clear_bit(aw_id, adev->pending_aw_request_mask))
+			continue;
+
+		ret = panthor_arbitration_on_request(adev, aw_id);
+		if (ret && ret != -EEXIST)
+			set_bit(aw_id, adev->pending_aw_request_mask);
+	}
+}
+
+static int arbitration_resource_init(struct panthor_arbitration *adev)
+{
+	struct panthor_arbitration_dt_info *dt_info = &adev->dt_info;
+
+	/*
+	 * If arm,access-window-mask is not defined or set to 0, assign AWs to
+	 * PC0 by default.
+	 */
+	if (!dt_info->default_aw_masks[0])
+		dt_info->default_aw_masks[0] = AM_ARB_MAX_AW_MASK;
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		unsigned long pc_aw_mask = dt_info->default_aw_masks[i];
+		u8 aw_id;
+		int ret;
+
+		if (!adev->pc[i] || !adev->sched[i])
+			continue;
+
+		scoped_guard(spinlock_irqsave, &adev->assignment_lock) {
+			for_each_set_bit(aw_id, &pc_aw_mask, AM_ARB_MAX_AW_COUNT)
+				adev->aw_sched_map[aw_id] = i;
+		}
+
+		ret = arbitration_sched_try_start(adev, i);
+		if (ret)
+			return ret;
+	}
+
+	arbitration_retry_pending_requests(adev, AM_ARB_MAX_AW_MASK);
+
+	return 0;
+}
+
 /* AW to Arbiter events */
 int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
+	int idx;
+
+	guard(spinlock_irqsave)(&adev->assignment_lock);
+
+	idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx == -ENOENT) {
+		set_bit(aw_id, adev->pending_aw_request_mask);
+
+		return 0;
+	} else if (idx < 0) {
+		return idx;
+	}
+
+	return panthor_arbitration_sched_on_request(adev->sched[idx], aw_id);
 }
 
 int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_idle(adev->sched[0], aw_id);
+	int idx;
+
+	guard(spinlock_irqsave)(&adev->assignment_lock);
+
+	idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_arbitration_sched_on_idle(adev->sched[idx], aw_id);
 }
 
 int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_stopped(adev->sched[0], aw_id);
+	int idx;
+
+	guard(spinlock_irqsave)(&adev->assignment_lock);
+
+	idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_arbitration_sched_on_stopped(adev->sched[idx], aw_id);
 }
 
 /* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_open_window(adev->pc[0], aw_id);
+	return panthor_partition_control_open_window(adev->pc[sched_id], aw_id);
 }
 
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_yield_now(adev->pc[0]);
+	return panthor_partition_control_yield_now(adev->pc[sched_id]);
 }
 
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_close_window(adev->pc[0]);
+	return panthor_partition_control_close_window(adev->pc[sched_id]);
 }
 
 static int panthor_arbitration_probe(struct platform_device *pdev)
@@ -110,8 +318,16 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 	adev->dev = dev;
 
+	spin_lock_init(&adev->assignment_lock);
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
+		adev->aw_sched_map[i] = -1;
+
 	dev_set_drvdata(dev, adev);
 
+	ret = arbitration_dt_parse_properties(adev);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -130,6 +346,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term;
 
+	ret = arbitration_resource_init(adev);
+	if (ret)
+		goto err_term;
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		goto err_depopulate;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index 23768739e9ef5..95a7685a5b3d6 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -662,6 +662,8 @@ static int arbitration_sched_init(struct panthor_arbitration *adev, int i)
 	INIT_KFIFO(sched->queue);
 	sched->active_aw_id = -1;
 	sched->phase = ARB_SCHED_PHASE_IDLE;
+	/* Scheduler is disabled until its resources are configured */
+	sched->disabled = BIT(ARB_SCHED_DISABLE_RESOURCE);
 
 	hrtimer_setup(&sched->grant_timer.timer,
 		      panthor_arbitration_sched_on_grant_timeout,
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
index 4d0f72838d218..187124ac39a5e 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -15,6 +15,9 @@ enum panthor_arb_sched_disable_reason {
 
 	/** @ARB_SCHED_DISABLE_TERM: scheduler disabled for termination */
 	ARB_SCHED_DISABLE_TERM,
+
+	/** @ARB_SCHED_DISABLE_RESOURCE: No resource assigned. scheduler disabled. */
+	ARB_SCHED_DISABLE_RESOURCE,
 };
 
 int panthor_arbitration_sched_init(struct panthor_arbitration *adev);
-- 
2.43.0

