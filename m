Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A98606D755
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TbQMdmjC;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TbQMdmjC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC9310F7C2;
	Tue, 10 Nov 2026 15:42:16 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDA68913D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=x9s3DJNvC6oNQCLBVBPlprRxQg4aZG06sMsRcOZDkl7e6beLw0nCRdPN0KFo8hB/Lc9m7KAmWowHvFfuQlrUEt+jeJACCA4V7L7oI139N/i2BNsF4niulVOyk2d21G8GCfwysvwEz6cdzXZIQ3YR8/rFRaaZawtV/H89Enr5NpvAwOREMjSbpGLzFn+I3NHLY4FHBjV/YDuk6fKyp6NF0i17a4bQUXOlbvNuGGlRe+wsBEahGWqcQ4s/TOP83/fvmEkqdTJ7iZNk8GuncP0eBwWxuXEcXQUKC/M/1VUt+Z0cA0dGY9GnboRQ39tslJVaHTkGLzVBVzYutF5eXIOLPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1agCI6+JYbqut7XzBWGtWVKYQgSGIM/cDAl+za5VUs=;
 b=SLbImELYl/Fm6iS/sZOLjLwT0IjUKMyz/7K0HxHtUH7w1mUrRW9fBZE/kiuKXHwk88S6riFL0Ig7A1gzobfIAjrRab0vYdPq0D+vlKhhOEXA4tEdISQz6tYZjal6T7KeCnweWjvuUwFBqCZSjbP4BFjOSRdqFYu6OR49NG1Sib2JzRVcN7RS7ZPxHZeWb4Gp3Vu9zJbu4fMslr9jNp+ccM37iMFCxJKD4Kw6APh/9JL94prOt0ORwKtrPn1rq2BYVjfFjLPoMwKI8HcvEzDx9oJjnBjMEfkxlGSLVV56twc0uV//beJQj/ihQqXGS6+L7w4fmJVrD6KktK5y8a2FTQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1agCI6+JYbqut7XzBWGtWVKYQgSGIM/cDAl+za5VUs=;
 b=TbQMdmjCnT1uaHgUlZFZ9CguyuulrOqcBh1SmQBnyPL6eptp3S7ji6Isy+4JNkzH+sPMJsK/mpNX+P0v3nKXidvyBsrOFjnziz4g390Y4lGVC5OKFK9DRQPY2bIOvAA4GPsh6xTVetdtfMIgVOK3ftst5Pw2Tslzwcay9DavSgU=
Received: from AM9P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::30)
 by AM0PR08MB079718.eurprd08.prod.outlook.com (2603:10a6:20b:80b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:59 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::1d) by AM9P192CA0025.outlook.office365.com
 (2603:10a6:20b:21d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 15:41:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiDgGScHDqbyTm/rnOVcA2U6uu7ndFif7zCvKqseqIXSupOLTUP3YQN/s1denvY7o847hXXpieTI46KMYCVWM9hhhTcVpdoBudHqM/1kRGnjRB16Havyc/1SxYobPGFwEFZo/au4rGvg3BjWJPTDgsZV7B5egPAM/JoFVjktBLciL1GQ7AwS+zlIS0bN8VlXEJ9mQ+Bh5kc57MkHr9fa0+W4DUv0cn3Kw3XaM/Dqzp/Zx+GSXBj8RqlF7I3uN+L1xLAnGLuyvYO+Rw6+etLzOfQ21TTAPwWZHjIzFmhtUZdcMmGYVRdtRUo9k4azS+vMykvU2GkEYKITFfVEu8Gy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1agCI6+JYbqut7XzBWGtWVKYQgSGIM/cDAl+za5VUs=;
 b=V00eD+KpUxF1cIba14+UxLoPLZgx1pdlPoPVoC5ESqVhikPVB6vgxxFM6LzLAKGG64SnyabGoN7N05a6/oiamKRkUi7bkkv5BNPXdX+WsoA8h7jAqsSotd2h0ols6vD4jQBCy4AFYpYR1LPFhfsFgvyEziLmve6cpjfczod0phc/3z4zJfs8IzDJVs9VXaEqdpy30ImMCf3nUD9TdnFOsylBjr99cAEghE552E/sw6jGSg5/rRkLQDs/9zJZIGys5XPPD0KJG6CfDcGyNSvvCzh1RSrwVdD0wICcBbPucAV4hOXrB6ppjlgQEeq2sfFpQ7xKyQelED/jatoXoDiXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1agCI6+JYbqut7XzBWGtWVKYQgSGIM/cDAl+za5VUs=;
 b=TbQMdmjCnT1uaHgUlZFZ9CguyuulrOqcBh1SmQBnyPL6eptp3S7ji6Isy+4JNkzH+sPMJsK/mpNX+P0v3nKXidvyBsrOFjnziz4g390Y4lGVC5OKFK9DRQPY2bIOvAA4GPsh6xTVetdtfMIgVOK3ftst5Pw2Tslzwcay9DavSgU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:26 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:26 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 24/28] drm/panthor: Quiesce scheduler tick during system
 suspend
Date: Tue, 10 Nov 2026 15:38:45 +0000
Message-ID: <20261110153907.3241978-25-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0573.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::6) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|AMS1EPF00000092:EE_|AM0PR08MB079718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0313f38d-9548-4c8c-99f0-08df3f41282d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 6rfoPlK5IYf78C/XWwQBhvb/sRwSu4UoyFZ1VrAOtbYdxYfw6lcdvvH8VbmKTH9UCMaS9UGj6G+dOuAfVluENG+7GmB7HtT0XRk+RBEN15nj7+h2+MV7SrM8bZZWCBl1kulvJbHWD2+fYDiP/nDGOieMEtJ50O++AcPuPZHdyK4vgILT5GJQlVkWzD21MS+W8nv/MpAsTiPqlPoLSFk+otyhE40C0yR+G78VSj6SMMMTnbT0CTnNwJIIGzd+8pd6NNX3GaghUYCRnZABK8K6P388VHwSrDNHnaJg7ufjTqrKOjnNz7tRKWyydcUVtEzcWrS1ZLXH8mTU7GxxxAF2SkQPI3WctSwIhTucFz7gWDW+u4E9go/XYgpNAcyDLhsVyG2uKWpH7Gwa3w9MUf0LAs6X3nlLYhGnLa52HaeYFbQGWbjNSm9y2F4W6RNeGra1em1gGk20qT9FYfdSmrEq/CDgRZeZTAXwcZvClBCjMiqj6OEft7DR2JU4QBwoprJE41pMLOhEmYioocMCMPVtf8Q3hgm0F8Hfq6C2HttHikR0bMHEF+9bMDv2NtYMmZwKrQ4/Ufiao5x7KjS67ayZwi+/ez2GNZffQW5/+I+7JeSWKOdVp1VXCrDxwYOaVnkRBVBt5+G3sf6SDrBlCUOzte6PvJKDYqBJ3az2aL2xywE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: me4BxHGZc7U2JEFKNf92g8VjnggdgmmKXMb/KMv+T8YK7B4muHWtSRF+MMgi2jQ/nqjabG0Y72Xer/hcL4a633FcIlF1+D81xN1GIv9mS2BYH5YsXxjFZMaD7FPgRVD5aDYpcsTXU14j0oK3AEQiFWtQk0FRod+N0a4nT0QfGn1/Mx2x8Zo7s79Ra+Qz1Hrvg0CxkilzfTHSf5TpnMqb5iQA8sSF1WLN8yrL0mPtWd5zDapEJpfZJ6tKFY7koyY63kAB+rjpy99LPtR+CzgWFtFS00TlIgIvU+xCivH3GasdFgtsW1vifLpKhpRi+Tz1bZchDRlKztHRzFjo8bwTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cd0057f1-9f34-43f5-1dbe-08df3f411473
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|35042699022|14060799003|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261022105027099003|261102123227099003|261026140227099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: +37IGUhJr6WrIHc8IJA1EL8ze20ptABanmkcrJpwdFde7r7tmPsGmn7b+pG9W9z6pxuv270hjWcH2pVNGTXYJGzkZ0rzhz2zDdfoy6oxuStNIjAS1wHk0NietA9csZcCChi4UqASLR2UjcnPxCb0R/etXeJSNoWiPK3m2xnDc8xHIJKQwWKl2oeoLuBbdGUa6uSldq1QRMRqtFPlmuHWx2iqm9AQl9EBfmG8hqoSDfci5wRpU1xwHToe20bMcv1gek21mvw3EjLh2a0ycq25JeqJZE4Sq7ebMOOUhEQWhvRQ8Jt3xn3f9kgd+QoYIY78HmID6/shwETVtObwLsTUYkXVsts8R6umF6aKxUEwqAVYW4nhrLQ+0Y3YKaCre5bF8i/2/kxa4RTqlIdZkMHwj6g5rw6rwUjoCUSWV6iMNxszlL7Cb8PVPnZhx4uxBMrbrDPQ7DQKhzqMX2YlwMpX16N2WTmxaR1ye/qzEEAlKA531OIaFJqJVOjbdOFnuNuwPtRMAQQV6hO6wJaheLvSE/goB4FluRlWa0xeZpZfukH95sWCItOS+64/LXjxaZ0ncoHY1+LH1R73FBQN3t4qmjvBQLHuyPFCKDzbR7zqKzdAnvlaXbbkOghBLofbl2fhKYvTqGGAJJjpqmWO9s35mcuIO+pmd+NBjTEpJegfWOroPro5pK/kgxCx8FKmaiYOxtoOdDZjEmSo8ZjdJ4gXHQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(35042699022)(14060799003)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261022105027099003)(261102123227099003)(261026140227099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rT8yBdWgVk8SlN5hHbYzJbCd8y3YNaRgD9cmCS5k+OJ0iJ+AEOvIgEYgh+IdLan+e+osXQ73KUkoajOm6qKbqvWpcU5fnKVT93D0wRzUTcLpl6Eqo4RknJBa+yb+e+Ht4p3o82Q+PfJ4QmCeX2Yxm8MftMe/PvryNuwdOf71rG492UmgJbaI677PeX4t+ExOXkc1E72DnJsAqLxRIMpfbwtmcNgGudS537498p2C74/iafqdl3GW2lBjia+eEhFTuF2GEdy8s4zH7d2sfF+O+5CY+5/qX6uYWonxgfN81c+J3SzkmUc/YEQgHzCyENmro8/7xHiPEEIHtZVB1/emmQRWHrnc9Iny2qkYPvputRCK/vv9Uw4VJj2Ryz8Zq5vQIEaRUsmlPvGdPkQOH+31Yr8n58ir2u7zDkyDTb+HDHgbUP45YzhYEve04U9SRiN3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:58.8482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0313f38d-9548-4c8c-99f0-08df3f41282d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB079718
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

A scheduler tick can run during forced system suspend and access GPU
registers after the clocks have been disabled.

Add system suspend callbacks that disable and drain tick work before
forced suspend. Re-enable and queue a fresh tick after forced resume or
when suspend fails.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++----
 drivers/gpu/drm/panthor/panthor_sched.c  | 15 ++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.h  |  2 ++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 2ccd8ad6318d1..ba5252c27410f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -662,3 +662,29 @@ int panthor_device_suspend(struct device *dev)
 	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
 	return 0;
 }
+
+int panthor_device_system_suspend(struct device *dev)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+	int ret;
+
+	panthor_sched_pre_suspend(ptdev);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		panthor_sched_post_resume(ptdev);
+
+	return ret;
+}
+
+int panthor_device_system_resume(struct device *dev)
+{
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+
+	panthor_sched_post_resume(ptdev);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 025efb91c1a38..e002ebbc88579 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -448,6 +448,9 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
+int panthor_device_system_resume(struct device *dev);
+int panthor_device_system_suspend(struct device *dev);
+
 int panthor_device_suspend_hw_components(struct panthor_device *ptdev);
 int panthor_device_resume_hw_components(struct panthor_device *ptdev);
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e9b71ff5ee53f..b92d600dc4764 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1888,10 +1888,10 @@ static const struct of_device_id dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
-static DEFINE_RUNTIME_DEV_PM_OPS(panthor_pm_ops,
-				 panthor_device_suspend,
-				 panthor_device_resume,
-				 NULL);
+static const struct dev_pm_ops panthor_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(panthor_device_system_suspend, panthor_device_system_resume)
+	RUNTIME_PM_OPS(panthor_device_suspend, panthor_device_resume, NULL)
+};
 
 static struct platform_driver panthor_driver = {
 	.probe = panthor_probe,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a343c5180e01e..3b2ed4095f80e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -4047,6 +4047,21 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
 				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
 }
 
+void panthor_sched_pre_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	disable_delayed_work_sync(&sched->tick_work);
+}
+
+void panthor_sched_post_resume(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	enable_delayed_work(&sched->tick_work);
+	panthor_sched_resume(ptdev);
+}
+
 void panthor_sched_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index d87cbdba4d40b..af7ca62125ae8 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -49,6 +49,8 @@ void panthor_sched_pre_reset(struct panthor_device *ptdev);
 void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed);
 void panthor_sched_suspend(struct panthor_device *ptdev);
 void panthor_sched_resume(struct panthor_device *ptdev);
+void panthor_sched_pre_suspend(struct panthor_device *ptdev);
+void panthor_sched_post_resume(struct panthor_device *ptdev);
 
 void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_prepare_for_vm_destruction(struct panthor_device *ptdev);
-- 
2.43.0

