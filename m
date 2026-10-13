Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590A3CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7DC11213E;
	Thu, 15 Oct 2026 07:56:38 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013056.outbound.protection.outlook.com
 [40.107.162.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F81D10F673
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:32:47 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C26tp7wp0SYmsZpfVbbEiiW6SNLy8lGqsy3AynA8iCDVN5HJQwMz7K9WB+4uIp4xHmpHik+QS9vp6tNDiaJZGanjO68CRI4JhsSaPICkfXsiOLXOXMbFnjUbFSKSaSaIAj8UsfakeNh4+qzvfT15Elf3abC8Eev7mIBaqCjwGde40mtzWoWk+7pkUBTk9Xj8S33JVnRDpLgOZ6aLHrn7uONZe/Q5Q9GPMa0bQ0BiI89tRocSRNVRX6RTJlyvlgvcmvStoHhbDN9hzPz00UoeiVm3q03lc9XXmh3n8U9ut0Lc6Tpx31CgNR8mhrZfIgqu4zaEhLqbWVr/8L20HyL8WA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amvRO68a1SfY+FnZjIsi6PwFFtcovP2rT9w4D/vi0Y4=;
 b=eei1ufnVweeE1lKI5M7bDY7HdkyyJRCWFga7G96VrO0zgSHNYVBN8E/wuxF+0KZLTGx+TsN0fYLi1hLr1nF+WXKKamIGvHEYnFdsXXsel5rzB48F+Fq5+xGp81v7wHgDfP/2Q/rlTVQa5DBuHN67GmD3pNkfco5xEyS2s59AYZOWvSuX4Ktc6lyMw//sc+f552JDfRLheX9iZRi8q5IReXu1CT9bVC6Ag9iv3TH0jmxcs/+icSlfQiqxwtpzjlZXCEVI8yh6y9d44BjKCS5C7fXEEGFg3HMue3+qhSZ/DIpq45Oa5kJHEflxFC4ueitdcZJZ5ihfpLMS9MN/0I/h2g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amvRO68a1SfY+FnZjIsi6PwFFtcovP2rT9w4D/vi0Y4=;
 b=nGSd9AXK/XF+OqbSeUd4VdU2arXQku67vfSyD1Y3Fior/Ndf67RhIlg9b3aL14b1iTstfc2rgWWlinNyS0ahbXcMMwEq3IhGsLja2RytrEa5DGKV/aaunXOgO+0sQWrkW7M9br96oEUnDZuSGSV6c0hVBRmm6eJtDg2xk7vg6+Q=
Received: from AS9PR06CA0712.eurprd06.prod.outlook.com (2603:10a6:20b:49f::18)
 by PAVPR08MB8990.eurprd08.prod.outlook.com (2603:10a6:102:326::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 13 Oct
 2026 09:32:38 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:20b:49f:cafe::1c) by AS9PR06CA0712.outlook.office365.com
 (2603:10a6:20b:49f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 09:32:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 09:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr35NtUTdrXgkbhrdaNTTyZcdwEPFzxGJFN9snHAQCN8PyDvAn8irUrFm/O+g1imgpuex3f50jGCC5oPOauSpN0JbPa3L7pSP9f7omYzmUUXEYque//f3dp09FESxU4nh34uE+wNdcmDnztHPY/R90qAgqTlzsYac5tHidQseBtvOM2bXZQa8ftT/obLFcGTwUi9HHhe5gaWhJCkRLCegtF/51Sg0eelD88jMpM22YRFXMyMrZQeTpFWUK0IpP5stxFfMQb1ZrEjufNdpMRWWgEjLjtIdJtFRDXGIVxm32PzDhPTt95+tlZ/vea55XyMfV3YNLs9zZI1oTA3Ap7mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amvRO68a1SfY+FnZjIsi6PwFFtcovP2rT9w4D/vi0Y4=;
 b=SaSUzOU+isJPt9SbI6m/yjnTvP8qmRit9SH51o/pZTUTWrmURV6rqd4LcQcRA1w1LCsSIkxsGrgpYiWAHmsy1PUUop33Udusgt1uRfxjNgUaK0bWu7EjeOY3IFbBK4H1Nr1pDhCMbEtVrqFMxLmP4hokf9XF1kY3U9CeZQdGuHdmyzOLxfjovmqn45gXPKE2x9OWrxrOhYySWCpZG+AYAhR5VH5n0xg9F4sqH46wk6jqpbeSX3+XFt6KnatssVQfDLtxqHB24UehJpgKsam2Ino105QEGOdWtc4gPePIIOF7RHIUd5NczgLSjjBf6txN0Bd5vhfgLbHocnF7iPK2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amvRO68a1SfY+FnZjIsi6PwFFtcovP2rT9w4D/vi0Y4=;
 b=nGSd9AXK/XF+OqbSeUd4VdU2arXQku67vfSyD1Y3Fior/Ndf67RhIlg9b3aL14b1iTstfc2rgWWlinNyS0ahbXcMMwEq3IhGsLja2RytrEa5DGKV/aaunXOgO+0sQWrkW7M9br96oEUnDZuSGSV6c0hVBRmm6eJtDg2xk7vg6+Q=
Received: from BE1P281CA0069.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:26::10)
 by AS2PR08MB9739.eurprd08.prod.outlook.com (2603:10a6:20b:605::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:32:03 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:26:cafe::17) by BE1P281CA0069.outlook.office365.com
 (2603:10a6:b10:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 09:32:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 172.205.89.229) smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:32:02 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 13 Oct
 2026 09:32:01 +0000
Received: from e144443.oslo.arm.com (10.42.65.142) by mail.arm.com
 (10.240.25.137) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Tue, 13 Oct 2026 09:32:01 +0000
From: Erik Faye-Lund <erik.faye-lund@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Karunika Choo <karunika.choo@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>
CC: Erik Faye-Lund <erik.faye-lund@arm.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] odrm/panthor: fix immortalis condition
Date: Tue, 13 Oct 2026 11:31:50 +0200
Message-ID: <20261013093150.4186117-1-erik.faye-lund@arm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|AS2PR08MB9739:EE_|DB1PEPF000509F5:EE_|PAVPR08MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3cac21-eec7-4763-42e7-08df290cebd5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|921020|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: IKAdkx9pcerBCk8ZJ74wr5jodiYrh+A30fAQTcHGSZxrB8t0zFE0xa2Oyxu0p8zxVpQ2ZeltyW91kH25NJ2+iZadVb7Qb0wKis+ixgkqdZOQyzejVF4YnAYJqRCHCz3pixDTWslZo/dcdelYGcuPr7LDu+6ntPR3e0GxYfLvRxSDILoQCZWtTYXYQdjv8kdDoxkS8bCb6jt5csd38+McdIMaCX9+xf1IMIqbVqKqNRWZqauhq2KpC4i4b6YSuVQmz96y9Pn4IFTJ2miU0ytE4uwCxILtWZLC2CFpDIxnVg6X2QA8w9wlx80MQCSS9fEORyRFDV26mdfpXjQ7CT26nIK4dWR3Do57k1zJS7DPrevgWqUHFFbML8p1HSVuetCDLj/pxF9JdS/2Q8UsPGu4Kv97imTl3JlHqGVSwiAXD5sumaTUeZ52nw8cyK/12mbzJMoN+grHwHFWB0Xh3GqMvgdoBY6djwPEwpwgTIvhusIqH+HTAT2F6zzw4+cQM9vG785CqDms2l96olVuDmAleuMdvh10e9/PUsix4CWXIuQ3GBnmMLBZRkuq2+4hPRSk4G6uY/xWszXFxYNep591qie3Q1DRrdk+P+lRiTRmpZbb2fqDeRbjsSWVK6ZbgUvI+9qcEO8NHKkpOwLfsQTGUDBak4ySU7g/iNtDtjYqQOqh2Zm2zmRpq6RQeUJraGcqVtYFf4gbFWjJTQBJ8EcT8Oc88a2EH2PtuIG2SzL+DlMz7aJscnapGthuC5XizXYc
X-Forefront-Antispam-Report-Untrusted: CIP:172.205.89.229; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(921020)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4jCUBqrp4bFZnM/nJYde9fOdh/koiUOaY/9QAuysALOwBgO1kMtTOtdU/rxXkfv3o/DDG9sQd6dVFNA7CA+eCI7Zzg57OPwouh+ZLSpZRbzDZ1H5CtxX3Xli2kauwJbqTu8i+HCzI/ZaHTJ2ccOJW7qTRWBDFA31GwKa2W337w4VcpIs+sD7PThg/OOeJ3Szp35oczfLFRQFOqeAIsDoamXIa3MA+EHaNVKQrd3ZUwsqon9ceL+L9Q2XFw0tJxBycUF/iafzeBTR/Y5k87efE9Rqv2ISmx6+OswQF/kx/RX2aIu01H8uEZgXSqSKKyteoe509KUJM5vP314KTwOByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9739
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4754f2c0-9d24-486a-3b83-08df290cd6bb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|35042699022|14060799003|1800799024|13003099007|18002099003|261009223027099003|6133799003|56012099006|11063799006|10067099003|261009221227099003|921020;
X-Microsoft-Antispam-Message-Info: qBDTkEOYasfdyQPKkqqUPDgD1FGM3XMEigOJhsJU1w7LJZR2B+V81y2OTawgmjiCNlTHRIRXmhleoGc1HphMENJQ2k7PaqW4u7vhgDW17Wap7zvcWKuBmfNdP/NmUjQ7I/U5aMQiIAqUolWqGeFLsQmvXarsezcDHbF1tnuBzC4Jw42Tj9lKBc+QBwojkr08NCivnRFEodymoQANSGr1sJCYpLavtsmpLs1J+lF7TUv8E0X22KzGx3kS/q05UTGAvRwCbYPiqAFdKs1MLejhFFUSrP1h1rRIsS5Ws4qxH21RCOVHF/X2QV5emRXkbkd5Arfo75ulKXyrDNgxnYquobGJ+9wRU6GWkUpVFjEnM6JGqxiKC4WfRAo6pbhdVSAWMlhy9a45F3uRpJ8JZcfiD0gyQHYjHiYeJbW5DGj57PkBQ5qPGsTR5LHJyNtj8ZgU/d+UROhxkHG9k4tJTuqkThY/jrTHdhSFm2nNwixRFJb6HvOZm4Har5JK8f2BZ4abSxgQXuh4/MpibL5USKsRHQiBIgYhutWxJ5vJ8pU7cdgFMKmQPwx65OS6XjNPAu6XRY2JjBZgaHjmjxKVSJSrqzyrSv8FLjRkRH0kOMAFw5EyCs90O9CeYzr9rdYlDC9f38Vu+MOmvY1VDhoTcey05EOT33JyVZYPAKW639LmCEzIFGHzIrlcdXlmeOGmHHV5YEejr+65mho/6JsowPYrnYBEJrwoGCJ8P2+WIEC1S1Xk6e0215liCNCe/nrOtWe9
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(35042699022)(14060799003)(1800799024)(13003099007)(18002099003)(261009223027099003)(6133799003)(56012099006)(11063799006)(10067099003)(261009221227099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mLiG7EMtKL2Sl3WZSlxvzbdAMYAKKMkDpAcehPIpgxmIO1nmUGWvo9sMDSps/Lz0JR6nX+FRjg+sJoYgGbG3RSt5UDcNvwQyT57PBVnMcL5jrMnr/Z4Gt0qR+cOaCQ/JuBB49VwatHGK9GhQYNEvyosQ6f/R7q/jNuFkBVa55XLIUdqqbj5kVLLP2gk0HGCH3z1N1htM22ZFAM1BKuAoWw2T6/ak//n+Jw7SL/AG1HJVrr/ZGe2BHJCjBM3sbCBGQOQKT5G4BLv/qnIiwL9j311csd+l1adZjHft2ckN62VlyXBpr4E4BFeB3c/Qsl5Z9NwamyyizgL68/NY4YgmsQpAQ6r0Bl2yyOetbkuD00QP5iHptip77hRWZjV61wLNc40chsHujxAZ66FyLjzUF8Peu8EVpIBkNCQi6XHPFoBFrB2Yjq24jFMjs73yg9FV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:32:38.1853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cac21-eec7-4763-42e7-08df290cebd5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8990
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Exactly 10 cores is also valid for an Immortalis configuration,
according to the public documentation:

https://support.arm.com/compute-ip/immortalis-g715

So let's report this G715 with 10 cores as Immortalis as well, as long
as it supports the ray-intersection feature. This matches what we do for
more recent GPUs as well.

Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GPUs")
---
 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 7e315708ca7c..ea1e222ef121 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -136,7 +136,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 	case GPU_PROD_ID_MAKE(10, 7):
 		return "Mali-G610";
 	case GPU_PROD_ID_MAKE(11, 2):
-		if (shader_core_count > 10 && ray_intersection)
+		if (shader_core_count >= 10 && ray_intersection)
 			return "Mali-G715-Immortalis";
 		else if (shader_core_count >= 7)
 			return "Mali-G715";
-- 
2.47.3

