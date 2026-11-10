Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E360A6F4F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mP6Lcxse;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mP6Lcxse
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48E810F79F;
	Tue, 10 Nov 2026 15:41:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C994210F79F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TgyECX9/ItnGsZPkHqbkfjLgCm/PabhFWANsqA0r+dZ6mSUNaaWHp6cC9YHp/djh3igZXC1rrQPbR3PwMYauR9a+D4tU/izMD8538DdF6KFNNFXmhjI7EWcGOtBjXXTyO/TYrLPhASCck0ZYqC8QFJ7/+QgBD+lu1LzX0FjqxsDZxvbH2kQlJH5DT+89KT9qh4lcateBRT62lVBu4QCgyfE2dnTfiylkH2ihLTY6OCqI9LbCKPB4xygXakxlPaPBRaP6Vy7Q+oVPkOv1xcTeE6SKErNt5HrYPvzc93vH9m+3zMINe92uUBHKcB1yrtPfl4+07ozp8bCrRuaIo6R20w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J1Tf5qPkWyn8nbEdFWlXWs9vzAKrxrRr2BmQ5ED81w=;
 b=ZsbLPeX8WlPiO96FAwn/PVTxdlq6HUlZIH5d1LKgN8hhgC6LaDi/tdQ0tA4xuzXSQRZu60ZZvkmvnVV5WyNDzRsE8TB4IfXLSn/oKGLfzL6AvjWaivhqB2ZCEbb6srcm0WY2CXrSBIaTgOxAhliNSlTIaeQD1ONsrnkgaK/fxsKNA7YGT/O83ktF1X6aZQU2eKZDVcHB6VuH9T+JoCZj/enkybZ6Gec4rqLnFUIbKTtmFUD8saTrdXxM90iSoSgVIoZAbJDHlh6CPwAviFGCaQLcsctCV0aCjgivFa/6abV9P34uivljJamup0at/U+HuIrqJ/lVX5T/CXLVKKQ0gg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J1Tf5qPkWyn8nbEdFWlXWs9vzAKrxrRr2BmQ5ED81w=;
 b=mP6LcxseNNsEpGMK0gcImB6HKOjtLYeHBDVNxoOzTNGXvYmxzoVBPB4ZToqmPNAR0KNQBtn1+MY3EisLvWaoQxxXxxMP9AgjzNblUAfNXUGVnzIfs4MdEa20yeVCEBdr8tCTx2jqxxx7Vs3C78TtYYPAn0wV6KMvLEnguOBRn2g=
Received: from FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:98::17)
 by DB9PR08MB9561.eurprd08.prod.outlook.com (2603:10a6:10:452::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:40:59 +0000
Received: from MI3PEPF0000855F.eurprd05.prod.outlook.com
 (2603:10a6:d10:98:cafe::4b) by FR2P281CA0145.outlook.office365.com
 (2603:10a6:d10:98::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855F.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYOxvu2Jc1E7mCeLHQLBKTdTIrq/ZuIdPVUFdUp7lMEJFbDPCyHOQj63lmuVpUt2ZbiBPzvQzfrjTHUC5MtXjMu3H8tgFZi5Eo/7NSnOkbJR66HzbuS0yAYEA5AvrI6QafM05Zj/MQq1Rd5g0/GsPO4yl6Ay/6M5q1U/6KtuvmgXg8taBmpCm/hG07GGmsxKxH9yLn+++BCOW4U/qK7Go7p/+p+44zGibrRlqgPqJ14u2BPQG7Wuf/0OpXTalKTZEdN5QfZEAHH/f45snHO6S7aqHMu/jrkFj/Nvs9D2EcNxZjXUAj9npvuSI/frmdv668yVDyiHbRBXtR/29UqnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J1Tf5qPkWyn8nbEdFWlXWs9vzAKrxrRr2BmQ5ED81w=;
 b=v8v8CoatIlVNkn3QxhEGSsicSHINYHQIFeC+T8LrqEoZp/ZV8yCVOsC9CLkSLyJyrKlF1MqESX8dj9peTDPuhVmOrfWMm1b6UuUbUfxrII19rSx8A3xDoYcijXMw4HS3wKjTIbFGc3qGcvac0plCGPvnbreEr5c/P7Xfjb6iR+HKAMcCzdOMM2u4mEDuknK1Vrhon5VTnxwgbgrisof7TLcISM3KKop/TQu5Krfgij6Y0HuTWYf3k7jY+L8P4nJeoahq28egerJ3iniJ0i72f3iVsrBkqvosdUDcUgcUFPJPMvEuF2UJ+AfQFzPgaC+xCW9H5tWxaWzn4AysGvjyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J1Tf5qPkWyn8nbEdFWlXWs9vzAKrxrRr2BmQ5ED81w=;
 b=mP6LcxseNNsEpGMK0gcImB6HKOjtLYeHBDVNxoOzTNGXvYmxzoVBPB4ZToqmPNAR0KNQBtn1+MY3EisLvWaoQxxXxxMP9AgjzNblUAfNXUGVnzIfs4MdEa20yeVCEBdr8tCTx2jqxxx7Vs3C78TtYYPAn0wV6KMvLEnguOBRn2g=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:40:26 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:26 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 10/28] drm/panthor: Skip devfreq when no OPP table is
 present
Date: Tue, 10 Nov 2026 15:38:31 +0000
Message-ID: <20261110153907.3241978-11-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|MI3PEPF0000855F:EE_|DB9PR08MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7286f610-898d-4f78-89cf-08df3f410460
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|261102123227099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: ppSemDitfrbzzYcMQbgYlt3MPoeHp8TMSWzgYKe6B/wI2OeQmmch+aCdqYaTIxcQG0wzxGsQAZ346QOcubmHTT5i4jqOy4CXtUNmZEpxMNX2LMl1x+ITIUHxiTAEMB10yV8z1Dho2xN8e+9wSmN5Xe1r5K4vHcqtGr0aJIDaG8AxSTFH8WAgH1QGvlnhkqHOLmCtkzJDOvYCe64E++kg64bpUJs8sZf45Wnik0ON+ie9uEHo3u0Lk5vGOS1R7cmbumtxGOqbNec2E7SQzpFf2Hgje3UCxZ2EM3hFAGl6TTb9M3xN+E3bExF2w0I8aF2ssO2e5yA8KS1GUDpyHgR7hu+TJ0FmC0v5tAz4Uf06mIXu+EUYoyvmDx2D/FwdmItPY6cFI2CuP8Ya932y0HniN0wJZz1h1cVLHjw1a/wwV5+Nu47pOOvM4pGlHmc9SPToDRH+JCFG+XabZbqGUdw0ZYhSZwqynoUsVCpNii1FjinzeWZY4pzwdxb1YXWvvfhBfVrPxo8b/Gdx+8Irg2NQadPAPQdcZh8crggoQSEUwuBqYy6bqPxuY7zxGwfgclnQkUSwy/sUjLOLnBOvIY0wXsiSxa/REy2okXMhwiIOmeUgjxnBxfpKxvMmQX7hU6KaH0XMUjlhkPqzpVAb24dFIA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: EfJoDZ+5rX5fozpSRDQ1/HlUkaj2WMMssHH7Y2dL7cnvl/pQsrW31CGAf+VXfte0XiGQswM0OGqXkNjuDuCytme6Qx/yRFYnGSVOxAQFyuXAruSpSGr6Xv0tfpdpinmLhAWak47IDE5klE+sQ46fcyzGRX8ArHm5/o7uzlevKU+D7ENYSscKWUmASkYcyBeNyUJAlgBFAsdVz9m+FSizfWQsBDVuZHjp3tOsEU1srsWnZpoaR7egwqZQflcKZMHtj0RHOhLGmKmuwckWMkUMozPmIsB6XWideZVQHARua97J+acqNT7wu1iIWy5cQJB5K+C+sp0fps7g7fkrSeegbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 236f0302-9c02-453c-d1d4-08df3f40f0cb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|35042699022|23010399003|1800799024|36860700016|82310400026|261028144727099003|11063799006|261009223027099003|261021121427099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|261022105027099003|56012099006|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7AJjGW5L+EXPY6uveaKKSNxVPI1th2r/mg/wsuPYsdK95P3FwHWfGmNvguoN+5yfKiE1jDCcBDBf02jnvautaaRvI20xh97MJvo5C8fGQgt0BJHthkM2d+Ewm24GImtP5a5UU6AldwVWz8c3HvnykkZyL5xHurZnI8LKyuNx70sCB7H4v3+p5vlaUr9rEOT/6E6qm60+bsCER7kzXf5FESv/BGrB0AMHw4Fs4d5/xAFBhY1G6cSUsJ7UIDo+Kvl1/MsQ90/8o2xrH+vbX03drRuLqBP68wWl7/a5vb3rITZA+iBiPX7O1NAHMO3qqGTIUO9JcgiYfC1syNUogQESSlJZD432Xma9jUBkEqXLZXoVTKabAgR59sJ+e5zq8QjzEPT4qiFG8aU5kOIPYVdoGqcETiZEusx3JaLKkIhnnFK2fQJcXS5FtAN1M8O0RQsa2citWxbU5zjnYOKQtV0Z/Jw0Uc7n9foNsSF5OSQ23d96Pd87kBWmdee+5HSBd70qnu4LhByccJMkEcuOO2w9/tPb2W0/ZpnQAV9/GDznSz7w7O6pZRWPMyGvv0X69geP2+ya702PoMn/K4i2t8ofMwl3Hl3IvBhZ28tXMUMz2pdFvLoMcns80lYWDuzhYjUELLSTK45YvzqUUYSsqQdFLXGZWCY3T5blm16pAMIptj8SDyB0AkZ8WE5qNwLgM6AY
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(35042699022)(23010399003)(1800799024)(36860700016)(82310400026)(261028144727099003)(11063799006)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261022105027099003)(56012099006)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0RGuxF0sATpRie2wLqaYj1WVCGxjwR+XRhu5DS5HBH58RI0iBUT3n/b2/OE9wapjzW0sSyl3RKHI4qYChvGDVk/hBd66tTweLjjud5tiL2IEK2JqpD+DMiFTVfr0TKJkqC9da9eIQBNEKDlY0XQEGaeLIVLjaY1WJMINIZFwp8S4K8Jy6G2kyXCTLQL+pBUtmy78iPa9/UI8O19cFplSGANoP9SeUzsPAuvZBdSUh5aaX3O4LAu5VvYuGjj7gZwUzqIGuwXxPwNPk8SpqDrm0u+DBaDtTJD1g8aZU3Pua6eht9yqrqcFbIGpAaPDMUeuBeq5BExz9+NSFcH16j0wY+7ONjb8Hzw26X3Qkwupwn6WEJ3GLfju/v+V7ZGtvyOkvaTku7y1WowvaUca88fbvIH6+ybkJfNq57CNPK+n0fLVSQu62gztDKLDWGsHy5R/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:58.7017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7286f610-898d-4f78-89cf-08df3f410460
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9561
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

Make panthor_devfreq_init() return early when dev_pm_opp_get_opp_table()
returns -ENODEV, and guard the devfreq helper paths against a missing
devfreq instance. Also make it so that frequency can be queried even if
the devfreq instance is missing.

This keeps devfreq enabled for existing platforms while allowing v15 AM
systems to probe without a local devfreq setup.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Directly call functions instead of storing function pointers.
- Picked up R-b from Liviu
v1:
- Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
  of direct DT-property check.
- Support frequency query without devfreq.

 drivers/gpu/drm/panthor/panthor_devfreq.c | 29 +++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_hw.h      |  6 +++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4afe..d1814b5197221 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -12,6 +12,7 @@
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_hw.h"
 
 /**
  * struct panthor_devfreq - Device frequency management
@@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	 */
 	table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR_OR_NULL(table)) {
+		/*
+		 * On v15 GPUs, frequency scaling is handled outside of panthor
+		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
+		 * an OPP table. In such cases, do not initialize devfreq for
+		 * panthor.
+		 */
+		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
+		    PTR_ERR(table) == -ENODEV) {
+			drmm_kfree(&ptdev->base, pdevfreq);
+			ptdev->devfreq = NULL;
+			return 0;
+		}
+
 		ret = devm_pm_opp_set_regulators(dev, reg_names);
 		if (ret && ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
@@ -267,7 +281,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	panthor_devfreq_reset(pdevfreq);
@@ -279,7 +293,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
@@ -290,7 +304,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -306,7 +320,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -323,10 +337,11 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	unsigned long freq = 0;
 	int ret;
 
-	if (!pdevfreq->devfreq)
-		return 0;
+	if (!pdevfreq || !pdevfreq->devfreq)
+		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
+	else
+		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 
-	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
 		return 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index fe31c1088af5a..dee641c698661 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -108,4 +108,10 @@ static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
 	return ptdev->gpu_info.l2_features;
 }
 
+static inline bool panthor_hw_is_gen5_am(struct device *dev)
+{
+	return device_property_match_string(dev, "compatible",
+					    "arm,mali-gen5-am") >= 0;
+}
+
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

