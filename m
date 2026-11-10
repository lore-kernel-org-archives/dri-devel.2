Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF360A3822
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=k7gji7He;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=k7gji7He
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B634910F7A3;
	Tue, 10 Nov 2026 15:41:47 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAB310F7A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:36 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Kovz9WUcIAHuqemApG0G8zVaEP2LGZ5YZ5Yp+qyEJsk9wzOSQcWeMQt8JP+x2UqT/k35gPiJiY+T2U9KXdyUcqp06jCwWVI+VUZy6TURcmO+RLR96S8QW4B6WnkTYr/u1aKnQ+cncxctZGFyhWDmaxMYXb188k17Cg7cXwfe9KYZKqw7N0KjQVQAqX4/3Gu5hFvRGdPJbm6mTLdZXV/r7O9N6YvajcWysCb63TWbZcljKWuwmTirvcrr+dUxg+lc9Mao3Sz/sA1FvZJ9lLCMQ+F0+AZ3uFBJclyVefNfyoeZYyAIqZrkRQ52SPLCOF41aAntqaiz6OADaCKYIGc5Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo+OlT5Z6Zi0gN6S/Iso5u/Q3onwUZvyr14jU17OCi4=;
 b=i1tgRFg5H5VF6KbL9r7WGl1r4ubJb+Wde09lhMSDSyw1wyvIS8FiPuZ+GMOXj+WianQXWu2LMBab3x2/ylQoZZ1QRrUMZUskFbA014Tx7OFz2jYK6r779o/XGilJgApibaGfdWwqiVzP+xXMY2JtD8Y4bppdGDSps+fpmRLj3flItvsL5sYgFGfp7V1j4lXMj52YtPQUWWjBnhAPpp0o51mn267XKP0X0NiGqhI/6wSxy8+jFL96LJwfrMgCIgQj2iz02EvdSIT/WIO5QAvinYxZjl77L8SZO8uIER1Bn7YGZqhzpRsd0hu30q7hnt31ru4xEsU87sfY39pcUV3Wrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo+OlT5Z6Zi0gN6S/Iso5u/Q3onwUZvyr14jU17OCi4=;
 b=k7gji7HenIMLlDrCtDb8Ieny/8UbBl7YnnCf89q84QffNRaiyk9k7Y+TaPN13RK5fNBMSpU+LvLGjvav7HvI/uD0yx7/AsKzW+S2wezFRVfQwRNBrLEyekPa4RjJNNAOR4yl7G+UUGzU2TYczx5ueAtSb1fTNJyp9rpEtbCfK3I=
Received: from PAZP264CA0235.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::16)
 by WA4PR08MB661891.eurprd08.prod.outlook.com (2603:10a6:1d0:39::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:41:31 +0000
Received: from MI3PEPF0000849C.eurprd03.prod.outlook.com
 (2603:10a6:102:238:cafe::57) by PAZP264CA0235.outlook.office365.com
 (2603:10a6:102:238::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000849C.mail.protection.outlook.com (10.167.240.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF56XsINwv2NVcyQtaxa1901xqcU9sNwZuZq8I6emapMgPvOqVZbrTgDQOmc7m+DOWJoV+2P8uU91JCuxE3hmuLPY889ztisCdKdGw80Tet9OYQ1UWKVuC5zvWjHonnb1BQcn/HAZvBB2qzy10nu66Du65PxTKvHinR5qiUvUwZSErAzu/9dyG+yeZSG1qwUqw2WNiumdo2lWuAhRZt029JaXxfoQalU0zcC7+5Za/v2uHZtZRB6b8+2oN1DR4j2ptJafJvSMM5DmVYpK7ljJHLRN3hHSdscQN4BznpViAyI1XK7dk45P6fpeq4S1EOZq95m12+zI1mz15wQvY3kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo+OlT5Z6Zi0gN6S/Iso5u/Q3onwUZvyr14jU17OCi4=;
 b=hRari2L9PNsLRKNlljE93XwT9KXkeXFRnvMfg8eLZR9IUHlvYM3s2EL+gOKAdzLEiIcNHvTX71dBa7idGcjZJfNUDGqXPxEf5ZNk7zEvQCDUZPFjm9NCN302C8tL5BcoaGUwBQOsmnV78AhN54UdxHTMVJZhSkrk2bBXY/pp4VroEj8hQdnmysAAdqOt6FUe3iJbBunm1vijRg8ZWyGKjKP4luX9sf0mjJ/Szz0RsIayrWqx31tWu+f4VWCzdfE0WwA0irUKQv/pd6qaKYCi8ltMbUNhFdeSNFsu6RMqxaH2EdKYdvWTjOyhZiDHfPod4L4GcBClxFOSrxA8ahdc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo+OlT5Z6Zi0gN6S/Iso5u/Q3onwUZvyr14jU17OCi4=;
 b=k7gji7HenIMLlDrCtDb8Ieny/8UbBl7YnnCf89q84QffNRaiyk9k7Y+TaPN13RK5fNBMSpU+LvLGjvav7HvI/uD0yx7/AsKzW+S2wezFRVfQwRNBrLEyekPa4RjJNNAOR4yl7G+UUGzU2TYczx5ueAtSb1fTNJyp9rpEtbCfK3I=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:57 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:56 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 16/28] drm/panthor: Add AM_RESOURCE_GROUP support
Date: Tue, 10 Nov 2026 15:38:37 +0000
Message-ID: <20261110153907.3241978-17-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0417.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::8) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MI3PEPF0000849C:EE_|WA4PR08MB661891:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a7180b-f8f9-48a1-e36f-08df3f41172d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261022105027099003|261102123227099003|261026121527099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261021123027099003|261009221227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: aAqOg9SYLGjtj3W84YAr6UCOeiXd6DcvumjSgfWqJVMfrK8pTanuhbsksAgY9gEKazr3cKkll8k4qr6kn3oXtE8Qcw0fKmE+w2og/cEteEs/2DZYY48bzmRcHvgoUdjKZ/t5nCfsMy6LPYwOrgOFBS3Nfx0JJKcSU4Z0ZN3P44F1kytdP3IvHjato7lC4ZX66DdxHArRRRd5pHLDvzj5I54Th0YW4XjF4dNyUn3FWQsAmVy7LkQbLr2o0KY8oyPVXyJqddyKrEsIAtw33nL5uRvZhmxY12QwnhCJRGnKleoeKBH02O21VCqDiDMWiZIWEjvHpmS6RXAT71uiZphJys8bhqz1xvD3ew2DubCeYPzK2ajHuRXzRlSmhg5FAyI20U7uZ6/sB50MvEOu7WD+QKXAC2IF6PcxT+kh3ZQayjy7Pwt/ueaDJuj/Joz1fC9hPzXwTuW6UqDqWBJ0ag9ryFaHbUNQpOVDjOpUAf8CAZ7L3XRj01OpXAdUChNkfixMDnybXzqkBGdUTCGOt++GEOqF+r7hJWbR0+uzJchnjVGAvT4NYRE+BNUUkI+abmnwsySOTtB7iJLSBwEX1PwUVKN01xAfE6Cd1Ql91JgcWHGk1AyqJ87E2GIC74WnLIbm
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261021123027099003)(261009221227099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: hNVxBNrL8Tc7MeQN5ZlJsgv6085wuFJgLmFgE8qBDHDAWjacoFfz2oU8csMwHlN+6sGae/HpmFdyTORQr6qS3jrd10JnuO9o6Gj1q2mFaZ/POImxhbASf+PVwaBFTFg21GlqjjbRCcTwchQxouJscAzrd589W0tQ4uQ9i9KdRi6k4k3uP0ywVjWXJdmUEL5yIRApK2SkdR0UCDtgwMYbnqID5zzX2mr5umXc2T6l7B00BOmbVgMCwbnVDFjRF9GLxP7qgl2lDQWw0MYdVKgeyTCX6lcrPSxyORb2jSBfRTF5AiwGgash4IRqP1rckf00NY37fxrcZa+vjrsaTQxzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000849C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 99a3fc36-558c-4153-540c-08df3f4102f3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|14060799003|23010399003|35042699022|376014|18002099003|6133799003|22082099003|3023799007|13003099007|10067099003|56012099006|261021123027099003|11063799006|261102123227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261009221227099003|261021121427099003|261009223027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: yGaYYECwfxuF61wnU9NVUGaJCwaSdk+Bov56OX9FnMT8JQw8N/1f1Wk3DAxSXO3/YCQrG1/ADQJlCt0S33VHAd1YC5s6kN4uYXCpoZvAb+M2mhxi5gZANTMDk+w6i9PYkdpzA4HJ3N/UHU89by3pxkv8+g2jPSu5OQe1kC5y/BfrHjFJAZRMOkCKUKlwN4QTpYqXqLPS4frsZMhyIAGiGRjf/ZxQSAIopFTSqV756MFW/r5uwrFCboH4KBejZbX04O0VMOkGHeAWKO3+h7VmdFxsvAT/lIlNS9xaYuX4hajKVkMC89i+a7iyUjsC4Bwl7VWAnWYZz1turXNyPRfd4Mxjc6zHRka5mu/KJHjG7cG2IMEHUtFdSUa+6EQSRHEwhXnrSCOQjjju4E0Ay7TreBupjKmfq3T+xz56dLrSOiJ+aBsmYyHAc/CH36krwMwVkAA5JosyFgwGmkuKxlg+EqV1C6jAn8hcicSVn1Hn7c0RIcAmxmyIkLz6GtwMa7Xa6Ki6O/9+qfFayO8azPYaQWd2zkMTDjDBLai8Y90hLKGRu0pNo9W5HXE5UE8a9cmxO154+OVHjdoHFwct0x75Ghyvi00DQb1TRdhHCfsXaKzxBkpoKNxhdgZFY3IwQAJOty+G8rnRwZ0gZ7Xny+Dp+A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(14060799003)(23010399003)(35042699022)(376014)(18002099003)(6133799003)(22082099003)(3023799007)(13003099007)(10067099003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009221227099003)(261021121427099003)(261009223027099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FsIOE8Wh7HFAYKmztN8kk0ODdwEz7zAonF/ni4gXxHsk6qDBZVV0JGvIS3Sm+foLr+8NTodabaXSo9kiy7gTnPsiIFqzLoU0ZGnbxXHR6w+7zGmVMchDITeDWwGrM+LYQgk4dLZjmFs4fMMKnCCq8Q93I94+EzCpo7Q8eG//ULPA8ci7pztRi1N3GdtUFOUBzY5LlTKgCzLFcnjuW1Kdanpa/vieDEFnTeHdentmAL/Wcf3hWF9reMxBYJfXUXid6qx+enBZTUT5M83YVQOtjq8O6Mugzw4k7j+kKHtjFAaoWNy9OJ9EVHZ7Qo+K4EFyURPkeNIjUcb41aKXaSpCqRxxgubX/iWmUi+NzreqosqE8Qr6kPJc4jYQTPuXysrEL6uxEPJFl9iLAj3oKWc3/XHuUOWTohCc0YxdaUGYPZk4aozoDTA8C2ydgCr8/kiB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:30.2112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a7180b-f8f9-48a1-e36f-08df3f41172d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR08MB661891
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

Add resource-group probing for the arbitration device, including MMIO
resources, IRQ handling, per-AW AM message helpers, handshake
negotiation, and retry work for deferred outgoing messages.

Hook resource groups into arbitration init, teardown, and runtime PM.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Revert child node parsing from v1.
- Tighten protocol validation and reject incompatible messages.
- Drain pending messages on suspend.
- Fixes the following issues raised by sashiko:
  - Simplify and clean up rutnime PM handling and termination paths.
  - change message retry work to delayed work.
  - Add irq_lock to prevent MMIO access as a result of shared IRQ while
    GPU is powered off.
  - Fix irq number storage.
  - Add check for allocation failure from devm_kasprintf
- Link: https://lore.kernel.org/all/20260922205638.7B1DE1F000FF@smtp.kernel.org/
v1:
- Updated DT structure and accompanying parsing to handle child nodes
  instead of named platform resources.
- Hold runtime PM reference during message retries.
- Fix suspend resume ordering.

 drivers/gpu/drm/panthor/arbitration/Makefile  |   3 +-
 .../panthor/arbitration/panthor_arbitration.h |   5 +
 .../arbitration/panthor_arbitration_drv.c     |  15 +
 .../arbitration/panthor_resource_group.c      | 373 ++++++++++++++++++
 .../arbitration/panthor_resource_group.h      |  20 +
 5 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h

diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index b0b6b2e3edf8d..2d2684321d978 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,7 +4,8 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
-	panthor_partition_control.o
+	panthor_partition_control.o \
+	panthor_resource_group.o
 
 INCLUDES = \
 	-I$(src)/..
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index fc3610aefae29..9612bfc6c4417 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -9,8 +9,10 @@
 
 struct device;
 struct panthor_partition_control;
+struct panthor_resource_group;
 
 #define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_RG_COUNT			1
 #define AM_ARB_MAX_AW_COUNT			16
 
 /**
@@ -22,6 +24,9 @@ struct panthor_arbitration {
 
 	/** @pc: Pointer array to partition control data */
 	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
+
+	/** @rg: Pointer array to resource group data */
+	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
 };
 
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index a27d24c3679fa..0e8ffd3c1e6da 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -12,6 +12,7 @@
 
 #include "panthor_arbitration.h"
 #include "panthor_partition_control.h"
+#include "panthor_resource_group.h"
 
 #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
 
@@ -20,6 +21,10 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = panthor_resource_group_suspend(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_partition_control_suspend(adev);
 	if (ret)
 		return ret;
@@ -36,6 +41,10 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_resource_group_resume(adev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -66,6 +75,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term;
 
+	ret = panthor_resource_group_init(adev);
+	if (ret)
+		goto err_term;
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		goto err_depopulate;
@@ -81,6 +94,7 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	of_platform_depopulate(dev);
 
 err_term:
+	panthor_resource_group_term(adev);
 	panthor_partition_control_term(adev);
 	pm_runtime_put_sync_suspend(dev);
 
@@ -106,6 +120,7 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 	pm_runtime_disable(adev->dev);
 
 	panthor_partition_control_term(adev);
+	panthor_resource_group_term(adev);
 
 	if (ret >= 0)
 		pm_runtime_put_noidle(adev->dev);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
new file mode 100644
index 0000000000000..e413cfd9e6d25
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/workqueue.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_arbitration.h"
+#include "panthor_device_io.h"
+#include "panthor_resource_group.h"
+
+#define AM_RG_IRQ_RAWSTAT			0x80
+#define AM_RG_IRQ_CLEAR				0x84
+#define AM_RG_IRQ_MASK				0x88
+#define AM_RG_IRQ_STATUS			0x8C
+#define   AM_RG_MESSAGE_MASK			GENMASK(15, 0)
+
+#define AM_RG_AW_MESSAGE(n)			(0x100 + (n) * 0x20)
+
+#define AM_RG_RETRY_DELAY_US			10
+
+struct rg_aw_data {
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+};
+
+struct panthor_resource_group {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Resource name */
+	char *name;
+
+	/** @iomem: CPU mapping of the partition control IOMEM region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ number */
+	int irq;
+
+	/** @irq_lock: Lock protecting IRQ state. */
+	spinlock_t irq_lock;
+
+	/** @irq_suspended: Flag indicating if IRQ was suspended. */
+	bool irq_suspended;
+
+	/** @aw_data: Data for each access window */
+	struct rg_aw_data aw_data[AM_ARB_MAX_AW_COUNT];
+
+	/** @wq: Resource group workqueue */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to retry sending pending messages */
+	struct delayed_work msg_retry_work;
+};
+
+static void rg_retry_messages(struct work_struct *work)
+{
+	struct panthor_resource_group *rg = container_of(
+		work, struct panthor_resource_group, msg_retry_work.work);
+	bool retry = false;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(rg->dev);
+	if (ret) {
+		dev_warn(rg->dev, "Failed to resume to retry messages");
+		return;
+	}
+
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++) {
+		struct panthor_am_msg *msg = &rg->aw_data[aw_id].msg;
+		int ret;
+
+		ret = panthor_am_msg_retry(msg);
+		if (ret == -EBUSY || ret == -EAGAIN)
+			retry = true;
+
+		if (ret == -EINVAL)
+			dev_warn(rg->dev, "AW%u send FIFO unexpectedly empty", aw_id);
+	}
+
+	if (retry)
+		mod_delayed_work(rg->wq, &rg->msg_retry_work,
+				 usecs_to_jiffies(AM_RG_RETRY_DELAY_US));
+
+	pm_runtime_put_autosuspend(rg->dev);
+}
+
+static void rg_send_msg(struct panthor_resource_group *rg, u8 aw_id,
+			u64 message)
+{
+	int ret;
+
+	ret = panthor_am_msg_send(&rg->aw_data[aw_id].msg, message);
+	if (ret == -ENOSPC)
+		dev_err(rg->dev, "AW%u send FIFO is full", aw_id);
+
+	if (ret == -EBUSY) {
+		dev_dbg(rg->dev, "AW%u has pending messages, scheduling retry work", aw_id);
+		mod_delayed_work(rg->wq, &rg->msg_retry_work,
+				 usecs_to_jiffies(AM_RG_RETRY_DELAY_US));
+	}
+}
+
+static void rg_send_init_msg(struct panthor_resource_group *rg, u8 aw_id,
+			     u8 ack, u8 version)
+{
+	u64 message = ARB_VM_INIT_MAKE(ack, version);
+
+	rg_send_msg(rg, aw_id, message);
+}
+
+static void rg_respond_to_handshake(struct panthor_resource_group *rg,
+				    u8 aw_id, u64 message)
+{
+	struct rg_aw_data *aw_data = &rg->aw_data[aw_id];
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	u8 reply_version = AM_MSG_CURRENT_VERSION;
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw_data->msg, version, acked,
+					      &reply_version);
+	if (ret == -EOPNOTSUPP)
+		dev_warn(rg->dev,
+			 "AW%u protocol version (%u) not supported (min: %u, max: %u)",
+			 aw_id, version, AM_MSG_MIN_SUPPORTED_VERSION,
+			 AM_MSG_CURRENT_VERSION);
+
+	/* AW initiated the handshake, reply with supported version */
+	if (!acked)
+		rg_send_init_msg(rg, aw_id, 1, reply_version);
+}
+
+static void rg_handshake_init(struct panthor_resource_group *rg)
+{
+	for (u8 aw_id = 0; aw_id < AM_ARB_MAX_AW_COUNT; aw_id++)
+		rg_send_init_msg(rg, aw_id, 0, AM_MSG_CURRENT_VERSION);
+}
+
+static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
+			      u64 message)
+{
+	struct rg_aw_data *aw_data = &rg->aw_data[aw_id];
+	u8 msg_id = AM_MSG_ID_GET(message);
+
+	if (!msg_id)
+		return;
+
+	if (msg_id == VM_ARB_INIT) {
+		rg_respond_to_handshake(rg, aw_id, message);
+		return;
+	}
+
+	if (!panthor_am_msg_supported(&aw_data->msg)) {
+		dev_warn_ratelimited(
+			rg->dev, "Unsupported AW%u (message protocol)", aw_id);
+		return;
+	}
+
+	switch (msg_id) {
+	case VM_ARB_GPU_REQUEST:
+		/* TODO: on_request */
+		break;
+	case VM_ARB_GPU_STOPPED:
+		/* TODO: on_idle */
+		break;
+	default:
+		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
+		break;
+	}
+}
+
+static irqreturn_t rg_irq_raw_handler(int irq, void *data)
+{
+	struct panthor_resource_group *rg = data;
+	unsigned long message_mask;
+	u32 status;
+	u8 aw_id;
+
+	scoped_guard(spinlock_irqsave, &rg->irq_lock) {
+		if (rg->irq_suspended)
+			return IRQ_NONE;
+	}
+
+	status = gpu_read(rg->iomem, AM_RG_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	message_mask = status;
+	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
+		u64 message = panthor_am_msg_read(&rg->aw_data[aw_id].msg);
+
+		rg_handle_message(rg, aw_id, message);
+	}
+
+	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void rg_drain_pending_messages(struct panthor_resource_group *rg)
+{
+	unsigned long message_mask;
+	u8 aw_id;
+
+	if (pm_runtime_status_suspended(rg->dev))
+		return;
+
+	message_mask = gpu_read(rg->iomem, AM_RG_IRQ_RAWSTAT) & AM_RG_MESSAGE_MASK;
+
+	for_each_set_bit(aw_id, &message_mask, AM_ARB_MAX_AW_COUNT) {
+		u64 message = panthor_am_msg_read(&rg->aw_data[aw_id].msg);
+
+		rg_handle_message(rg, aw_id, message);
+	}
+
+	gpu_write(rg->iomem, AM_RG_IRQ_CLEAR, message_mask);
+}
+
+static void rg_irq_suspend(struct panthor_resource_group *rg)
+{
+	scoped_guard(spinlock_irqsave, &rg->irq_lock) {
+		rg->irq_suspended = true;
+
+		if (!pm_runtime_status_suspended(rg->dev))
+			gpu_write(rg->iomem, AM_RG_IRQ_MASK, 0);
+	}
+
+	synchronize_irq(rg->irq);
+}
+
+static void rg_irq_resume(struct panthor_resource_group *rg)
+{
+	guard(spinlock_irqsave)(&rg->irq_lock);
+	rg->irq_suspended = false;
+	gpu_write(rg->iomem, AM_RG_IRQ_MASK, AM_RG_MESSAGE_MASK);
+}
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_suspend(rg);
+		rg_drain_pending_messages(rg);
+	}
+
+	return 0;
+}
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		rg_irq_resume(rg);
+	}
+
+	return 0;
+}
+
+void panthor_resource_group_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		struct panthor_resource_group *rg = adev->rg[i];
+
+		if (!rg)
+			continue;
+
+		disable_delayed_work_sync(&rg->msg_retry_work);
+		rg_irq_suspend(rg);
+	}
+}
+
+static int resource_group_init(struct panthor_arbitration *adev, int i)
+{
+	struct panthor_resource_group *rg;
+	struct device *dev = adev->dev;
+	struct irq_data *irqdata;
+	struct resource *res;
+	void __iomem *iomem;
+	u32 irq_flags = 0;
+	char *name;
+	int irq;
+	int ret;
+
+	if (adev->rg[i])
+		return dev_warn_probe(dev, -ENODEV,
+				      "resource-group %u already present", i);
+
+	rg = devm_kzalloc(dev, sizeof(*rg), GFP_KERNEL);
+	if (!rg)
+		return -ENOMEM;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "rg%d", i);
+	if (!name)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(to_platform_device(dev),
+					   IORESOURCE_MEM, name);
+	if (!res)
+		return -ENODEV;
+
+	iomem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(iomem))
+		return dev_err_probe(dev, PTR_ERR(iomem), "%s: Failed to ioremap", name);
+
+	rg->name = name;
+	rg->dev = dev;
+	rg->iomem = iomem;
+
+	spin_lock_init(&rg->irq_lock);
+	rg->irq_suspended = true;
+
+	rg->wq = devm_alloc_ordered_workqueue(dev, "panthor-%s-wq", WQ_FREEZABLE, name);
+	if (!rg->wq)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&rg->msg_retry_work, rg_retry_messages);
+
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
+		panthor_am_msg_init(&rg->aw_data[i].msg,
+				    rg->iomem + AM_RG_AW_MESSAGE(i));
+
+	irq = platform_get_irq_byname(to_platform_device(dev), name);
+	if (irq < 0)
+		return irq;
+
+	rg->irq = irq;
+
+	irqdata = irq_get_irq_data(irq);
+	if (irqdata)
+		irq_flags = irqd_get_trigger_type(irqdata);
+
+	ret = devm_request_irq(
+		dev, irq, rg_irq_raw_handler, irq_flags | IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), rg);
+	if (ret)
+		return ret;
+
+	adev->rg[i] = rg;
+
+	rg_irq_resume(rg);
+
+	rg_handshake_init(rg);
+
+	return 0;
+}
+
+int panthor_resource_group_init(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_RG_COUNT; i++) {
+		int ret = resource_group_init(adev, i);
+
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
new file mode 100644
index 0000000000000..b8633abdd8eb8
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_RESOURCE_GROUP_H__
+#define __PANTHOR_RESOURCE_GROUP_H__
+
+#include <linux/types.h>
+
+struct device;
+struct panthor_arbitration;
+
+int panthor_resource_group_init(struct panthor_arbitration *adev);
+
+void panthor_resource_group_term(struct panthor_arbitration *adev);
+
+int panthor_resource_group_suspend(struct panthor_arbitration *adev);
+
+int panthor_resource_group_resume(struct panthor_arbitration *adev);
+
+#endif
-- 
2.43.0

