Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B48606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DHL/VRqc;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DHL/VRqc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B603110EC7B;
	Wed, 18 Nov 2026 17:55:04 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013024.outbound.protection.outlook.com
 [40.107.162.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C84610FEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GXQqE76o+ofuSRXZAx7nIM1isdlg3WuEo74mq45mSXcTe1/8BnfWFX+qrS9fWfnX5vQoO6iCZRMFDRxXH6RM8na0AwfymEGQz7pOOxIOZaguoCCEduAAaKSWGPVRHTNyO647oSsDote9UhKT52jcWPPx/K9dWPMHNusEtcS5ATYFuHaEpkUlykbkYZFZbwHBAi6VG6FpZAKj1rPj+N0ZZ7UxQklin2MbiR81HJN1QAHSTDP7XE9P7RgXJMlVe6Hv5OQCkD8UZdmoA7OmUJ4P0AxJIjB7pVANMXjifUt1t4HwcC+LlvWAjzMIwnRl6UahRGfCfbmgdMquc385q2jLTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsSmCOAy09mvOC9FzJc7X+TVu0YFhnMNnHenZWPmSfo=;
 b=rpfFm+NnQAAjm35Q9iribtc86qkLQRutmZ5jzIUy8zejfTYPZHI/XFAulI7IdqxL7uGEpsYa0N26d1xST3tEcrzZp1eGD5OPVulPONL4ziWokkQAwTNg7wGewypH5FDpAZValYN26Bi8j7z4Gml7stzHa/nqbbHt5HHLVkcAVIfuIM6G9+BUB3ocXtGRReMQDgFZerdy5p/qSOx+e+4vDYh+NYBHCJ8O6knn1RSRoHmB8QZMUb8iH6gxajl8+8M9fzOV9GAcBMT75bmThL8SH/6KOAuoK6IhDUJSqGCGRLi3wKDq4cv4Vk4H2iVHaJ0holimL3vBxp5wb6hcSt55Cw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsSmCOAy09mvOC9FzJc7X+TVu0YFhnMNnHenZWPmSfo=;
 b=DHL/VRqctYcDVV97xjhJSIdmW7t13K7XBRxsV08KUHoB4xgGWo5uNi4L4iafQ3OVrtKburbwKChkC9tT5vOraYq6JSWymIJLBfzcyew8KnSivAnPtdGaqz8Oo9ly/ib90KveO8c3YHp1tLa0btczS7PDeQd4em3bt3/58P7BhPg=
Received: from VIUP296CA0113.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:350::6)
 by AS2PR08MB8904.eurprd08.prod.outlook.com (2603:10a6:20b:5f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:39 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:800:350:cafe::39) by VIUP296CA0113.outlook.office365.com
 (2603:10a6:800:350::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 17:54:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPRfF7wh1m0f4ZImbNVzpfbLpHV3hJzUS8swT6AWJ3SExsLanPCuL4cuFQLRcaDLuuq0cna+TmhmGUesD7r/M5VgTrsVV8Wvzs4ZNZsNHxdQ8ATEJLt1dWq+6ZNaJqVf0D54gRyEqtlh+PDe2A/TYywpe/J1+S0LCk7gX2vxAgceMWOI+C85sp9E3f4smjSfYuucbosjU5NT+gYVnkinEy/cU5Tf+OPAIORwqUchXlQgk0uI7uGODBfVbU5nvf/dDnwgpguHp6Fzd4dF4sFyHh8FNzHBYFiRMXc2YPd0bA82BHLSLf2ecFAcSjFSvVyuuol4OOWJj41VP3J2JNwLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsSmCOAy09mvOC9FzJc7X+TVu0YFhnMNnHenZWPmSfo=;
 b=nDsy/CbEdklKzvkk8/OuVWCOlIJMH2DpnCzlwUQic+cZA9VXcLCeOca6hj0CkjgRps/OuYtxH8hlZ4UAbgIedMc4YpgkLDJKxcTQxfChKyXtz2/1W9vkS8F1vSUuokH+ie5kAjf5wv4P+XQUSyFibHAeH3cEQ7uq2jF8pRgObEjEKiWTPhS/w568LomvIH6QWMibqDsJWu9vDWa98fWKmPoBdrN5RxoSNoiv5uYgSD9AMPxH9h58bfJIvQ5TKA8UrihqrLehFsiuSVP0NwtNG9E+r0o6ZyajXfd3vaOVcRT709/c9LQ1UhbDxsnM9JCJmcpZgBXf+dO0HljP2CqW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsSmCOAy09mvOC9FzJc7X+TVu0YFhnMNnHenZWPmSfo=;
 b=DHL/VRqctYcDVV97xjhJSIdmW7t13K7XBRxsV08KUHoB4xgGWo5uNi4L4iafQ3OVrtKburbwKChkC9tT5vOraYq6JSWymIJLBfzcyew8KnSivAnPtdGaqz8Oo9ly/ib90KveO8c3YHp1tLa0btczS7PDeQd4em3bt3/58P7BhPg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:05 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:54:05 +0000
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
Subject: [PATCH v3 07/10] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Wed, 18 Nov 2026 17:53:23 +0000
Message-ID: <20261118175332.519657-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0413.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::22) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|MI3PEPF00008491:EE_|AS2PR08MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 2781404f-c289-4e20-c2d4-08df459d040a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: JWoxxpp6JZk7OHPdSPJ8O3aQyYV+3YWXis9y64rybq4GwK5bV9BmEGV1yZ0A8LhoE7gzOASEgB9Rt6W9J890ic9F6wS3LiG8rKkmHlHOOm7k/GWwHuHAeyqTF9Q/kL1eb8OQ4/0ZHQD0teW+WNdhtI6U2U7TXY9wOoJao/P79V/7WymEN62gVq3mGC/KHg41aNAdpY5sMrnqLWTdGpBGowHlVXlLe/TA0YRZBemuIJ9Rz8hQXAKAJtpPA2cmMpw8dNKtTkDe+QheX2sKFHRpnGQTF4oFldjLPbxIJTxLcry/Xth9qxX2vcm79zm3Yyh3VxqDwKCVnmE6WEmi0sLra/cwMRIJvcYiaF6A0745nLr9n6d03fEOfPLnN78eWm+q3m0hBc6jS10IGit0e5G7m3oIBQRfWElDNPZt7YEZ0E8EsPvihiWjY1Al4KF4LtFUoqpE0N9TQMrBcumrSdV0RwmVUidRyAdl/1ArfkAw4QfryBjqUxIVEznwDl6qHwpySBYugIKZT3GL1lFfQCoXz/5vEzwxrjA+KfXwqkcoi3hxeQp/Lvgtwavo5uv+t9r7ReIhJLguxZ0U1QdI+sBjMrkmRjmDYPSU4AqMpK+Mulgw+oT5gcVuOhqWOD+fqal/
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 2NK5TPx5AkrF15X/1XoBLu7zMcA+iTS/PTYnOUF0NakDSOrqbk3WF4lNDjf6SRAfkW8oaKRq9KBKKU+/qmJGTFkAana6pTz6p0qN2gc9rHppy3vIWhkwEOtnLCBzBTcCqo50FqQeeOj/V/CPvw0F5JQqoTzJA2ByVuMOGVL78krwS668YX+XtucIK0uwsC9OYqb3KZr+7RXs1bRXwe1pvVthtKieGwENJSCAIUq50C+f5bG0XvXD/A6aQnOuXQZq5pk6r3HhX3LorKSnW+SmmBU2zmtQ4QyoJ7uMlghLKRoWymFZVnZ/TGTNCtS3tT6BaoDwkhyTvvQQUxviSopjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8436baec-48be-4fbb-71e3-08df459cf012
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|14060799003|35042699022|1800799024|22082099003|18002099003|261009223027099003|3023799007|13003099007|11063799006|261026140227099003|56012099006|261021123027099003|10067099003|261026121527099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ph7bLSXNlfq4gH8EKLS7KnE/qE6n8ArOP/HjlLPUBWmNhCr6fCyNiHbJCPuNWsP7krUeJUj6FHrGDGRvpdwC4egB6Uqiq+2djGjoumQiDqU3MURQHGRkX5SQO8NBbXigcQVanQ2TxH8PfKbhKgPAhx8bcKYQVrST4jJLjtuGhdOcZRVH5iX5NEDGyowDXAxlm7qZ9jLn+jTne/MTv1EF5JwO1l1gyhTVSXDQXW7Nf+hjDf7Qdv9H/eQ+zcCJ45+yJQJQe6vEowAs3B1m/3uU7m87m3VE4LPoPiVdLydiIDoW3ECepPq7OADykgR3CCE9Lx6nIiiLNX/Vet3QUzOF1kLqadI9x1rOZb5ndzl4ckgpsKD8WrjlMlFHsqNrxQfP3SsvLdTBiuRb8i4Op4cd+Mz+drTnq+UybHTNLGihtqkLSPKWRgx4jODOMSU8LU8YR8z5E39S+EEW2+Fgx0ZcXF59k096RNFu7BqaLZeBa2eG9Guic2BN7n93T0x6trkED++Es0xB1epMvBxrttnhr4vhKAeWh0X1veqo3qhH8j5tpSyDjrKGoOc4J32f1wjNRyHcIYZlEk4NRu5iZmeNbSX61LygMbxuNRkx0BhrI3qDFeIMmgV1OjI0fH5T7OQWobXC6+Vw+CAM85wEQ8OlYohQz3YJHWwk+q1eUNiIlB4=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(14060799003)(35042699022)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(13003099007)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(10067099003)(261026121527099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +E8Qat2q2hdAPxLVSI/feA8SCxprERpAac2/fqZxKAO7mdD0ow1b8y8YnDYa06VVlWV8nm2vudNi9wp2VBpuM92c3V4ZazuTYdKJLHbXyszDlYW3HEh/6/rS79JgygnEYg436nlURsMJsxziqN0/r2IMbzGp8gzjeq3dsfzY7n4NZFbsV1lkcS5HhOvc6Vbr/sUHzydUZYQGVc40nBKkf4+pBCva7yuz0nhQU3HNn0CTwg/8rbMq2y6jdSNHMlRJWPTcfYIgEsz7KlnIOGOF9KXmIdqT3NKVrPRjnRVsmK7OrQXq34NX2tbzZUmwj+/E1XPaPLnjtbK5mh1F5cQgXLO1M8UaDlcPWcEuy/BOCD1/J/dNZY86KJ1enL2x/oJ7sgfk3MYggxslWP37qCquzN4qWDWSJ9uP+dXC0KjA68VdkDmLCoj7ab/4P9qsJNOD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:38.7964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2781404f-c289-4e20-c2d4-08df459d040a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8904
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

Move the MMU address-space register layout into the hardware description
by storing the MMU_AS base offset and per-AS stride in the Panthor HW
map.

Use those values to compute the iomem pointer for each AS slot and make
the MMU AS register definitions relative to the per-slot register window
instead of hard-coding the slot offset in every register macro.

This prepares the MMU code for GPUs where the MMU AS register region is
not at a fixed offset while keeping the existing register accesses
scoped to a single AS window.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
- Avoid enabling all AS IRQs on init and replace with explicit IRQ clear
  to preserve init behaviour. AS IRQs are enabled as part of
  panthor_mmu_as_enable(). This also prevents accessing NULL iomem
  pointers for initialized AS during init per sashiko's comment.
- Link: https://lore.kernel.org/all/20260922210016.0C0961F000FF@smtp.kernel.org/
v1:
- align with updated panthor_hw_regbank structure.
- moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
  to retrieve it.

 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
 drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 47 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index f72cff260065e..6a8645bda1e7d 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -45,6 +45,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.mcu_control = {
 			.offset = 0x700,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
@@ -64,6 +68,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.pwr_control = {
 			.offset = 0x800,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 0a82152d772ad..4cb603a3acef6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -49,6 +49,9 @@ struct panthor_hw_regs_layout {
 
 	/** @mcu_control: MCU_CONTROL register bank layout */
 	struct panthor_hw_regbank mcu_control;
+
+	/** @mmu_as_control: MMU_AS_CONTROL register bank layout */
+	struct panthor_hw_regbank mmu_as_control;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d1c29eec46f21..718160c0779ae 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -35,6 +35,7 @@
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
@@ -49,15 +50,15 @@ struct panthor_vm;
 struct panthor_as_slot {
 	/** @vm: VM bound to this slot. NULL is no VM is bound. */
 	struct panthor_vm *vm;
+
+	/** @iomem: CPU mapping for MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
 };
 
 /**
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
-	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem;
-
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -533,6 +534,11 @@ static void free_pt(void *cookie, void *data, size_t size)
 	kmem_cache_free(pt_cache, data);
 }
 
+static void __iomem *as_iomem(struct panthor_mmu *mmu, u32 as_nr)
+{
+	return mmu->as.slots[as_nr].iomem;
+}
+
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
@@ -542,7 +548,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem(mmu, as_nr), AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -560,7 +566,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(as_iomem(ptdev->mmu, as_nr), AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -603,9 +609,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 
 	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, transtab);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, memattr);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -627,9 +633,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 			return ret;
 	}
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	ret = as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 	if (ret)
@@ -1799,7 +1805,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1861,8 +1867,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
+		addr = gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -3429,8 +3435,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
+	unsigned long as_present_mask = ptdev->gpu_info.as_present;
+	struct panthor_hw_regbank *regbank = &ptdev->hw->regs.mmu_as_control;
 	struct panthor_mmu *mmu;
 	int ret, irq;
+	u32 as_id;
 
 	panthor_mmu_info_init(ptdev);
 
@@ -3449,7 +3458,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
+		u64 offset = regbank->offset + (regbank->stride * as_id);
+
+		guard(mutex)(&mmu->as.slots_lock);
+		mmu->as.slots[as_id].iomem = ptdev->iomem + offset;
+	}
+
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
@@ -3479,7 +3494,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	panthor_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
+	gpu_write(mmu->irq.iomem, INT_CLEAR, panthor_mmu_fault_mask(ptdev, ~0));
 	panthor_irq_resume(&mmu->irq);
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 1ec7f5ef2b196..82661283b46ab 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -11,13 +11,8 @@
 
 /* AS_COMMAND register commands */
 
-#define MMU_AS_BASE					0x2400
-
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define AS_TRANSTAB					0x0
+#define AS_MEMATTR					0x8
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
 							 ((w) ? BIT(0) : 0) | \
@@ -29,8 +24,8 @@
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
 #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define AS_LOCKADDR					0x10
+#define AS_COMMAND					0x18
 #define   AS_COMMAND_NOP				0
 #define   AS_COMMAND_UPDATE				1
 #define   AS_COMMAND_LOCK				2
@@ -38,16 +33,16 @@
 #define   AS_COMMAND_FLUSH_PT				4
 #define   AS_COMMAND_FLUSH_MEM				5
 #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define AS_FAULTSTATUS					0x1C
 #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define AS_FAULTADDRESS					0x20
+#define AS_STATUS					0x28
 #define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define AS_TRANSCFG					0x30
 #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
 #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
 #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
@@ -65,6 +60,6 @@
 #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
 #define   AS_TRANSCFG_WXN				BIT(35)
 #define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+#define AS_FAULTEXTRA					0x38
 
 #endif /* __PANTHOR_MMU_REGS_H__ */
-- 
2.43.0

