Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B060A262D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dW8vQf14;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dW8vQf14
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBC510F79B;
	Tue, 10 Nov 2026 15:41:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013036.outbound.protection.outlook.com
 [40.107.162.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849C710F79F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dh9WGlauJPIwlP3XEIszLHsc4FISa501aY+U48RNcCDHwWiAovdfho8OSPsQlCsIizuXI9gZIloQVIe1TNsQ8jDPxu+Mk7Ok+CPquggllCAYcQE9d1gMIrwubLNTIq02Z5p55rJ51UghCv6mKrnKAN2AIFcUMrsafWc+Xk+5XFnC6I01r3xqKrvMsiaecYtE/qQwSDGpuHjkLMWw8siD/U4Cl/8ZqJwhxFibBi2UUiLTUuYN+URWL53jel2FT4DXll30XB/uaRaLcP5V2s5zxwgsbMdqy7QlB2tYkLU86emeMMBOS7KKaOdzGmK1Zti+uRnz1yBn/PKovLwF/AUjeg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZTfdDuPNbcSlz8vslrAKsgW5JBHa0SYTeqwDKe/yFc=;
 b=D63RumOv4OZlcujjk83U+ozuoPnSbWTMfws/V3YcZX8bPxNs8F9lISeP01Gz9C9i9njKONoPn2tuWHLjjSIhDXvobL2pChpkaCBYDAnQ4qwTezAz7R5E1IBEulx2bqd639ErpPKzKW+rcdQ69tl874yBT1jnqvonVdIMR0MXE//7o2vh/1X8+T/z85ZB35IV41ry044jWeqImpLMZ9mRjlAyD6hpT2dAUov7cQSxJNPyWlhLU1w0JQdJEBuasAbArqe868BUei0Eq3TSfKVvmS58s7kIoH0jWy7C7urLSb+vDKlti/lpSSriqnyIjpIORj4qve9dMK12YIWjq4Go0w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZTfdDuPNbcSlz8vslrAKsgW5JBHa0SYTeqwDKe/yFc=;
 b=dW8vQf14lsojMVqvdzpHNoXP3mlb0a0n5Q6C66Lh/YYOvDcRZwDejh7ARI0F1u1uk9WBFmUSPqUvQ0ru9rurHgWaKw7uZASsaXknusY4xrSOlE4+3AmYpk3jaQZva9H2ZJ0Ug9vxDCF9WZtdtuGy9Vn/6u+1uH+dbMfLEw7dvUo=
Received: from DU7P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::29)
 by DB9PR08MB9850.eurprd08.prod.outlook.com (2603:10a6:10:45d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:40:51 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::18) by DU7P191CA0027.outlook.office365.com
 (2603:10a6:10:54e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so64HiuDPpTKOSsP4bgNlge3TvehCR2sjys7aJljFs8ipN3KvEGLOt1+z5MgNrsGY8tsaLGQdW+v56swozgXdu1vMjRJuuMU2o23IavbGD32wwtMTcb8fHLvryiXKAGzeKJt5+8NkKJKjqIVFvD7+gQ8bO4iXxTLShMZ7MXxbNLIsWsGqv4hbzVRS3ET2MuwxXiKEXTHMXmCDHGNVWaXIbXjPp5a6ok10UF80evbecvbXtBCj7rccf3fStJ2zDLbARn9etybTm+fJcSe8ake9bWTN/hHLoyqDmHkdl8ZKERnayF1aSoTWbJ3At/BJKV6h1vF6db3GaW4XJQaxhoTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZTfdDuPNbcSlz8vslrAKsgW5JBHa0SYTeqwDKe/yFc=;
 b=uwC2V3ThBbIGHkYyVcdeVJyjuGMsPLi2hNqQ9HCILHuMnOXKKxZSZhTjQjaXveRSJ9lc9gCH3oaeX7J6oZ8rlhIMCUCuVB4ye9CsAZ2APc3OOWMIiTbsIJ1R6ENoCVr7W8bEMDMUl3VROkmzQ6lBeWikwIjnmtdr3Qgb5PV3bCnueXydA7g4aFu33ccb9TA/wfLMsSjGz8IEJFMv1XNx7spxTtGwlux+DC9paKGiuDwc3Z0QkNKClGdXGJR9WHpMKUhgKVPtNAhY9BoiQ6Iq7Dpv8VBrz8zBMcPKzHi5aiI+9PczN8WcKcbopS0PRggLOLuJBnVH4kDf4M3xFarnlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZTfdDuPNbcSlz8vslrAKsgW5JBHa0SYTeqwDKe/yFc=;
 b=dW8vQf14lsojMVqvdzpHNoXP3mlb0a0n5Q6C66Lh/YYOvDcRZwDejh7ARI0F1u1uk9WBFmUSPqUvQ0ru9rurHgWaKw7uZASsaXknusY4xrSOlE4+3AmYpk3jaQZva9H2ZJ0Ug9vxDCF9WZtdtuGy9Vn/6u+1uH+dbMfLEw7dvUo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:40:18 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:18 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 08/28] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM
 schema
Date: Tue, 10 Nov 2026 15:38:29 +0000
Message-ID: <20261110153907.3241978-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::21) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|DB3PEPF0000885F:EE_|DB9PR08MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad645f4-dc09-43b5-f061-08df3f40ffc6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261026121527099003|56012099006|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: wiyiv9Xb2jAFMJEqaZsyvqnliGC7Ks3cI3Acf5a8cCtRAfPR3M80iUgrJB/wGGVYLvsjVT/fvSy81y4fL3KhDc2ibeGlrWqZi0OPUBYYolHZWpLeb7JknWta+QCiIZH2VjQaVBX/x9F7bM8sbQTFb6Xnphrrns2QOzm2kjOEoRE54rpFIskXYsxrBa1eieLKgxfB9gEQvszJe17t3bIufgS2rkfEOfvTXJYV4oAdB/OQoxMWKYT5PQ0wLT75cxWyfo5PuduJ3/QgVhJVjHMHDsSewH1M1r4r+bycWCyR7CLKPyqoOLi+oMljsk4wSK0r29aFVNRCQsvP74V5io/fCtCjLjLyaj1Q2IqgDo3Ql68PzROZuBzue/W6ZF/vbb5Df6/aW5eyrbVRV9sNX5WvpWGtkspiUR/jypJbVWbnCrPcRrBUFM7sF9i5LRisoPj4wT0mkmh0tyHTs4/RsvJU7X1fvhIV6IBl5MocXM66mr8E9rHE29owLjY4pw1xw43kXZIQIaJU2ANmWQVexelacdPrE7JFkALeEn8iVqg9ErG1A4u5dHWZ3C0viAn0O9Oilivt/aXMXXijgxbJsFSvnN/u0kxpH2rrdGXAfsH/oDU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: y5mbJfeWGhhfb1RRXpubYxgP+Kw1nc7/NvGxVYM2BKPE/0mk7Vw0MnA7X6xNL1ArtHJgV85KbNi9i7W1iKCKUTZyt+vhlj/fF87yicUCdaQ7GCRvDPDbU/bXzFVvMsvF5x7eahgOYembVH88ybusTrRD81RkJRmReVSb+RUiDN/c/7EiDkrHLentoiZkdAYQQ53zoq+5gMqoiyYKK4RUnXEwl1vCyQS7mFPY7rkcNhmhx0goYNFbU+cwvHxWiZmgqxiRV8I8oEYwASp6TrrpeS22Egq+rSfYCPIlWXBlyLK80D2FR0oeTGZZIEEauHJ3fIZwe7SOH18KnxnD5zDu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb005da2-6a27-4808-8168-08df3f40ec11
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|7416014|23010399003|14060799003|376014|35042699022|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: IhrXYTp6kr90q6ZW+6y7UAW077s3ggp79yxHS8VZI4zFoxaIpEXjLaBuVOl7JNqJzzvUSTcSZt4vZiUNAJIaUG7nGvWIY1e3VJ6V2hNV+SYLtFS6azVGWR4+jDH8cdzTNCqx1Eff66sdGMwMycc4VOZR/K0z7o6nOmmZUwprw2d0FtKsxHl8VSLVQg0IIDwWeJKmoVKgM3d9N5QwXRP5/lIOyozm3XRGKGQFcqSKr2D6cbegTsRA9ZT56NzyOdir5NcEZvVJ2UWdeyNXSN3BzBiiYDdug6Pgb9lxnImnRYsdexsePp9hfefJdalmyIljm9c2NE95x8q7oJ/Kb02RbRJNM0DBCYs8GZ+EdcPR+7Y74FRLwsShoL/GYULHVvJOpLyKjV/dYIJXQF/yL2eXAldYO4b/PgUv7H+RGpUc/yvGeBM1EnRSE4DTCQqmGYA/8TaD2YeqxXPoHF/RYYRhQJO+QrwdGBQW3Au8LnH0w4spJvhve82YELDCRwZfaBdnus91rCSRMGzt+s3P3AIuay6AZsU6dF45f5JCSGjIF8wtSF7o1Q3PjnjK81FtIsSWr1LXOlkT8v8Cjv9DhnmeeTGrigunkSNU1uCV35DD2DiZeoDHNH0xnAsTWgLsXkKNzFUYZgreoK7JGUNUwLvVCg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(23010399003)(14060799003)(376014)(35042699022)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x+WVb8nh9ON9I3hlEoHeq+P4yFLFBMTReTcXk6RWHJ4QmBYuuACLYW1/643nOaT1K4WbOjAxndV8In3LZeVRbasy9ajig22qUhptQ1+ZrpTbG3i1qqMHPXlSAnaqmrzDfYdzi8zSurFEoh2daNOTLjc7gnV+rzz0eqVhN29D/sF2kgwLHGn0n1Ji6wC1tSGuiveg9Wuvh1Xm2Zw0jAIRy4T2usvBWr1/FDRTrKQgQzylcPoMc7VPAoCpKbveDegsYNkFJMdMfpcYcFIMMfTUs8+6xdbknn/she1H6Sy+ZlZ7giemgDsDqPZcZ5bgYCzPT32BhSKSvzTGpy03NOHkGKL0iFYitIQA6ipg0qSJBb5b3jmY/pBNhN+Nm4eks4DJB2aP8wR2JUdt6E87Sux/bmX8pPIUY7GPFuH79FrOYVRZGQIlxU05hu4utIfNlcVd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:51.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad645f4-dc09-43b5-f061-08df3f40ffc6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9850
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

Add a separate device-tree schema for Mali 5th-Gen AM GPUs.

AM_GOVERNOR controls GPU frequency. The GPU node does not accept OPP,
cooling or GPU supply properties.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
  separate arm,mali-gen5-am.yaml schema.
- Move the AM GPU example to the new schema and add the interrupt
  binding headers.
- Add the new schema to the Panthor MAINTAINERS entry.

 .../bindings/gpu/arm,mali-gen5-am.yaml        | 90 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
new file mode 100644
index 0000000000000..6349888e1ae2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th Gen AM GPU
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+
+  compatible:
+    const: arm,mali-gen5-am
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Job interrupt
+      - description: MMU interrupt
+      - description: GPU interrupt
+
+  interrupt-names:
+    items:
+      - const: job
+      - const: mmu
+      - const: gpu
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - enum:
+          - coregroup
+          - stacks
+      - const: stacks
+
+  nvmem-cells:
+    items:
+      - description: bitmask of functional shader cores
+
+  nvmem-cell-names:
+    items:
+      - const: shader-present
+
+  power-domains:
+    minItems: 1
+    maxItems: 5
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 5
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@100000 {
+        compatible = "arm,mali-gen5-am";
+        reg = <0x100000 0x480000>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&gpu_clock 0>, <&gpu_clock 1>, <&gpu_clock 2>;
+        clock-names = "core", "coregroup", "stacks";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3aec082b0ab..bdf3cc1044c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2400,6 +2400,7 @@ M:	Liviu Dudau <liviu.dudau@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/
-- 
2.43.0

