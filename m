Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30F60A2616
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HCvStxkz;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HCvStxkz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C1710FEDD;
	Wed, 18 Nov 2026 17:54:40 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D388510FEDD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:26 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V9xDGkHFDUlRyG4J0QbGbMwfSscjxgB1SKGAhj+CCoP6bYTixWyBo9Mh7U6kUaKyGOWC3mAH91DxKlmCfAnbzYqHsCI1gWX074F+2mR0a1VIZ6h1I6Wy3WjKWua2nnZ+dTmY8qstAw+0HCdU15JvLZWb7WWcRLye96VcIGdUaRMvuzstEl0sU1xlwaikH4fn+y99kSjC8ks7wLTAeqAvUIR0bFtm/BJo8o4/WBWFTVLXc/FCjlaKNuAkJojGp43PAuYMdYkd/a3MV+CYHxK4iisM6bUkgxisViNezCsWsnvx6g08TsdfNzZedjzGpB9vlXTa3OMLa3jh9C4oayttAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=gXdtxRZn7Ri3EkFxjDzdINgqbgR6EgnMbFofTxfJHKi6W1o2LQpk2sDXBUUeh7R4geqbNqmofivlNegtyqpcF33vS7YeaqSwahZrRKo0HjJWlzQNf0I+LLHcrfn3u03YwlQlNl9uoFKfTP/jSs6dyr0PZEYBl7nf7DuAzcoDzR263fdYadoVJ5/NeqUXDOpIqXqabmOhrUgOHo+jECLOVL1mp5UMmj8W5PMhFJvlerH8myO+iWwou7BozvIvAYP2nIjM8kMGQJAqnzkCVNY+HGBm670bBpndOZ9k5pT2nE8lYVCsk/IJbIe5zUD6fnCNh2Yh4ZY58sRvQeSiZ43Btg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=HCvStxkz6HNI0RBxlJ8a+YpRFJ35spN0ZhXgozV0A9bE2JMvzPigHTINFM2WLeecxtpWcYrrrgW7ONZ3gE4q8XyGdxjBFurZVzfoDZJD1rpElTq0GugGMFq+/piBg8qv2yiIrrhNtO46lnGTlQ6QmrOhzr4DKfIn6rBl8NkMn1Q=
Received: from PAZP264CA0075.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::20)
 by DU5PR08MB10756.eurprd08.prod.outlook.com (2603:10a6:10:51e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Wed, 18 Nov
 2026 17:54:20 +0000
Received: from MAD0EPF000008BB.eurprd04.prod.outlook.com
 (2603:10a6:102:1fa::4) by PAZP264CA0075.outlook.office365.com
 (2603:10a6:102:1fa::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 17:54:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BB.mail.protection.outlook.com (10.167.241.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex0XRdQaQJlnOFHt4i+cK9+jEFKO3OPsLMxjkGFvqUX4QZ9eYVZZVcu77/K98qip+EKTalOw/XQQQFLTlYAcinGz+Zuy+g6yoUTLlwIyMm4SJ5Mt1gOfl0w1pW3yhMcnP80ZDZide0XQpmG0pJWbG7ohKQzSIZp5/+EqMMfESEOowaOjHBoM7dvlpDIDhPKnwV6bxp2zUwlJHg/7vPqA04IF62oLFZd0UmQArqf2uG/gRj/I2RbHyX1mIL8ylDcwneFUR4RUA524ZLdYjDGrYzbVyoUKaizSv/pkpdU+FoRpipr0PZejgYCXrhlTVrJw6dpY2nq1qsNEAnKpqMhF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=R5Q1eBEIRvxiw3ecoyuZ3ATBLB+iSree1bgWwItUcONxTLojPiKrIVZcj+JPppXwZ9bMFdRbOit+j4DCs3cNULUh/EV4II9tbyIrJc9Im5gBia3tySMydp9sbG4Hbiry7oVBK4DPyt7brd/knr0Ede5Q4p4A2mo3qq48kHxyK22Uf1LpPvyEM8sG4DLxCALXq02H0huBpyHLdReGgameH+9pZ1biacuXw9CVjt8/jsJYksCMdnJjaEDhJKLSlqumYUDFSuOAEsa1hlixtk6ssysKlV3UPh6j38ZVp6vnUY9hBCUiRvofUlI2cGBwP22UAsV9C6j+uI6NHUThrkWPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=HCvStxkz6HNI0RBxlJ8a+YpRFJ35spN0ZhXgozV0A9bE2JMvzPigHTINFM2WLeecxtpWcYrrrgW7ONZ3gE4q8XyGdxjBFurZVzfoDZJD1rpElTq0GugGMFq+/piBg8qv2yiIrrhNtO46lnGTlQ6QmrOhzr4DKfIn6rBl8NkMn1Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AMDPR08MB11410.eurprd08.prod.outlook.com
 (2603:10a6:20b:718::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:53:45 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:45 +0000
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
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 01/10] drm/panthor: Ignore -EOPNOTSUPP for shader-present
 nvmem lookup
Date: Wed, 18 Nov 2026 17:53:17 +0000
Message-ID: <20261118175332.519657-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AMDPR08MB11410:EE_|MAD0EPF000008BB:EE_|DU5PR08MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: fc338b09-900d-4ab7-f13f-08df459cf805
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|261021123027099003|10067099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original: +x7eoc/Di/u1lkGpT7Dr6zKlsBTBdBNXuiIy3qgMyLDxPwlHuUQDMXLjUi2pi6k/lCgkF94t80+hmn3oI2AbwmGfdiKPLUrzTcsHsuFPQ1RbWhsMl37oPKwkM6YjMey/ifyZTdKxtBR7IZxzdcCttJz6W3kIkFs7K/vb2WsQjw042PMt0SYfkEgNOziwQe878S4iV76gVP1wDNBEyKZhlVsiecRGGksX7LezTGb+dqOl+061h0RmxI0J6r/Ot2Cyqek3Gde2RYJ69+m70uP0EZXeVXEGZSMo0d1eRx3Er1GmrUjxteD3ud2jNgMDnlL/xP+YuwKssp89mcZa17zxHQxVgfRmwPmpw0xS9EwC/l33kfhjbfPQTjL27A+K6zVkkg3yyM7RwWaRAPg7eqjW+CzpH4hScViKbe2J1jBvIh8DxceXhMDcRCKHiU8U00kYyU4USyDVeYPIX1dyto/j0zlWGyWs2DaDDcwVawiCW4Izat9Kn1ZQ/wGcQ4ZGJnO6jI9yXuBZIEkNnKpwJ2HopaN9n8OpzilcznEuUu04AfKeeeAEM6PZPIqlIfhQI2kEOcYStDzmUszWCWFJvk1teEYgs81WAtmGjSeZDpm4or5CzNrJucIOwfuTn2i+PQ076tfF1SGCV9QzMhZjr38sSqOZYoYX1988oHj1zTrKSqA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: J2Hac6woGae356uqEETne2T5Rk2H1PN2Z0fG5VcwwcqdG2e5ITDBSmGEZVxYmmxrqg/bYBR2kFD15Vl9SIU7BT072r0nag9GWhw0p60PiAVhCOYGnd5YsE0VEDdwAKowM6hA3o8V7xeFbw4q4coARfOxzSUcZpbhPRbzn9qPY2fCdg0iwguBOeJPJoWxU/zyqKrKsYyYANxFge/k89Y2HEfv4eVFiW6hUYY9hHZeWzLvzbDF5I50sacdB7jHTZxGPbeAzefS8Bu2ufsZkOERW1kuio+rIOaneI/KYpgRhJ0iXhGC5AUon046USzZYcFu0CA8fxG3y3hUPl4d0duATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11410
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d73556cf-2a1b-4528-413e-08df459ce42f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|14060799003|376014|35042699022|1800799024|22082099003|18002099003|11063799006|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: zDd1gclppe35J6psltj2bdj6iCq8JR3wdt6oOScT0IAY/fMSYfBr/M97+/fpNzi+rZrbqia8PsFBmjJCS6Fzvi19o+51DcODZfFkiuH+TUinNzPX4kHY0wJvMpuR8XAk7oscYJQyV0jpicfjiq3GcqRWaDSaO7SZAZfDsBYpopM6rFFyXeoxbWtDadi2Jxx6KcDHoE9LGxD2vvhfLaMdR2HdKDBzjjTJKXbLWyilnEYjg3fSdlBvRK2e2XZrNwjlft1a2m6yacdwWXqdtXPjupyfIarpugEPg8Lc/bzm6xL4IIWOxAUZokDtMEVOzW5ti3Pf5ETDLhnS5SBPDI4dkgtProL8CEuPu7ctV+F2JXjoxu22cf3FuRYYaDNQWYJM8niDTQBEUezRPhZRPGj7C1p1UYiORhn214NtLIHrfL71WAGhrpWaTEvEOdVN2zUSqs9ZDQlMdh1v8/zohFzLFjWQ44VIE2xbqTyySkD5QCvgw7GBvlH4n9Buu96RfhUrEsrkrYeyBmAw1zrrMHNxkeVjXDrKwlrLN6e3/wqtmeZY5E1tRDqbAZvQBvXpDESTQoysPt75SrB6Q8iDKO0kvm0VNMs0kS1GgWTFkOBLjG1nvcDi9HL7V/AmB4TW8HsSOxqvUO7Aeg4pntYasp1FDUGqn+aGrPhJZvBnYMT4PbSlym26sTRYPsA35mOYjIc9eDbZz/15cfIIVhf7sJ2IuQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(14060799003)(376014)(35042699022)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L22aYgg5GEB9AjzfTJ81gry33K2kDQR9lcofBHNKA4nhQPXK31fl4hcqLwJNs+vOXukRB/nBqmVrezNNzwL7eGcSwQ50KB1S1F5w8N7avPTAFrPfxD7DV1tMbFo9ubDxAe3P7BeVG1NB1KngTyheZbjOnXH73aY+Cqcs356gK7jKFN2faglZexiFBi75SY2brmawQYAkC7wweHY00A5MKpRu5VMUIgaZlucSys+n7MdxL7lhBvM0zw9v9vgjKqq7rtCzBvH1DWiGibd5n52t0kv6ptW9tYYtEkWqrMH+HhCfasHeWk7cBLw6NqHbdwLK+PGNQ/P2P3DCxJK4zVjRy9MUN00uidCuBekqXMeDlMNC44MUM0XTZqwkY17a6n7TLMfiPayN8BUTv5SYda0D8R1mtyjxZj7uGV4dy3BU7G9RFtsdl18OGPT9EGH/UARS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:18.6657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc338b09-900d-4ab7-f13f-08df459cf805
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10756
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

When CONFIG_NVMEM is disabled, reading the optional "shader-present"
nvmem cell can return -EOPNOTSUPP.

Treat this the same as the cell being absent so panthor can continue
probing on platforms that do not provide shader-present fuses through
nvmem.

Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from nvmem")
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
v1:
- Picked up R-bs from Boris and Steve
- Added Fixes tag

 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index ea1e222ef1210..34dc4b9d9dc09 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 					      &contents);
 	if (!ret)
 		ptdev->gpu_info.shader_present = contents;
-	else if (ret == -ENOENT)
+	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
 		return 0;
 	else
 		return dev_err_probe(ptdev->base.dev, ret,
-- 
2.43.0

