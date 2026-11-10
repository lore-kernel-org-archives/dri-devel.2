Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4060A2621
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C3diJZdQ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=C3diJZdQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65910F7C0;
	Tue, 10 Nov 2026 15:42:12 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7CD10F7C6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d+fXHjdpsGDkALYCnRQ7LiHQ0RGOhGQ5KGfZ096vKCF2cB6I0HA9zXzzMjWKaicv8jBtKoJC4V/MGjBxvFODjPiX5hD9ERCxh2XNlsL/nnbLkh+XOGXJYTfiGqrMGoi4SCx6XJqGQwsLNYyaLPs0X2nHNnHwod97lllwAVJlrMCiGyT1STBkndMPer5MqNl6mp1GbahAv9DVs83qoz3pXeywERulhuHO295IoqLu/fyFsONeBCaVaby/9KuApFn/D7kvD9wTYkaHoOZDNgDmHAiVpcDuSkrKpzr/H7riszcTH0tCePkgNvddpSU3MqnEv/HzEO/eLpPgwz4Vwa9ibg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gjK3qa3SABiXjRo7jSS8bV5JYBVpcBu3PcxBAD+r4Q=;
 b=iz57rL82Ht6PvSLaxdqFhAGly0Jtvm/zMTSc++4ZJWXObduA+5Z6MdBv8hNYj2lQEF3ehSmesfU9wtyH++j3MXoA5v5c5BkvpzNjQdFtqMjJohS17UWi6aeTYJy/5vlOP6x0TEZGOCVjiX4zYyPT949iWMw3VUQHukThe5QZ8d3QzyWK0LzDVQU4XPO8G3cFPUAhg2cC3dIl+BGe4JLYWAY3dy2Am/7KpBvp5LCbyjkx+GJOC3oX+5J7ha8FRM8wavJrsYY8ZUNxaI1vPJnqXyowxfYKLY4vuEPKjLYhWtxHVuGuZgQfNFAEyRKo4ziMr8fcJ4X7OLwczk4XV3/ggQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gjK3qa3SABiXjRo7jSS8bV5JYBVpcBu3PcxBAD+r4Q=;
 b=C3diJZdQ6FY7zcaL72Xr78HhxpMA01knZYCZWpwY3m16PgAG7WWy2y/W6u8tL1zml/POKVoPO7VfA/e/xmtgOTYZrh8HnLSkHStshlxx1oUS4uvMvDySxE9GMb1DnRAUklADgc5YB9pcrhX99Fgt+g4+8SlelIF5f0fK/bDNF40=
Received: from DU7P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::30)
 by PAWPR08MB8839.eurprd08.prod.outlook.com (2603:10a6:102:338::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 15:41:54 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::2) by DU7P250CA0003.outlook.office365.com
 (2603:10a6:10:54f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6ZSkMcZWjV8kgXQ8nY3a9vbdh4w2RwQ/Iox58PJCKPPr2+lAWGQTGdO5n6V8sXfSi8S7qIkrPXojOD3x4rZqRzDTiXmdeFRfJ9j1rFcJOBrJEHswTuBCDr3uvI6ztlNYN+wnJcFu6dXnIUAHOrgo3bLT4OFhWdUUlhSQ+oRFKkvXVfalythlXb0FUYOwNAVYnrcqzGpuFjCnQCxGHsQniFWQqJRBYBMqHd8Ax62IKzWWCLFqo+uSdA8oo26ecrdqMwmD36PCQpqJuZ5453S1IStoFWjO9j0IJFkh7i/gCTtCEYSbffR8o0Saw2dtTioMuoc4wZagrWGu3zOerAiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gjK3qa3SABiXjRo7jSS8bV5JYBVpcBu3PcxBAD+r4Q=;
 b=mKfJxaxk+0bcpaUSFzQTAP67XgH6Kv+l2Nbw7OGtWIfkUGSyb/3hy1Ru7loxhqLH3wRqm8aFoMtDXmd2OvpM2dQ2XR8yB2123VaHeB/ozI3HXUKz8krNSNeVZVUU2O8JjE0orFxU2wY4zTXbYasdChabaf0b+aPymdEmyHXFYScyxDQnvmd6zWTDvB5XJCPz6FoyKoVyzNa251x8e7PUpLNtY6FHHzH8yPw5pKD3Rw1w2ai91tDwqyKE+P6VrDjSGRpCHyQhzi95SXG8u/QS4C6Rw5aHtE698eNVgB5sQAM8cloCwswiXyQ26tDHrbSLin1mZQOsCL41Eo+fWYDl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gjK3qa3SABiXjRo7jSS8bV5JYBVpcBu3PcxBAD+r4Q=;
 b=C3diJZdQ6FY7zcaL72Xr78HhxpMA01knZYCZWpwY3m16PgAG7WWy2y/W6u8tL1zml/POKVoPO7VfA/e/xmtgOTYZrh8HnLSkHStshlxx1oUS4uvMvDySxE9GMb1DnRAUklADgc5YB9pcrhX99Fgt+g4+8SlelIF5f0fK/bDNF40=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:19 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:19 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 22/28] drm/panthor: Add access-window support
Date: Tue, 10 Nov 2026 15:38:43 +0000
Message-ID: <20261110153907.3241978-23-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|DU2PEPF00028D10:EE_|PAWPR08MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff8d45d-5721-4ef5-5e3c-08df3f41250a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|3023799007|10067099003|261009223027099003|261009221227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261022113327099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: HTmXsOpPYnkMaWCI9PdUmaGkawe4sHgR1SzQ93oQZz4hqzw9S2D7ctECB2qfu7dJ7U0okjEQ6CCxB3JxBZsY5tSITmHrSY4ihMMP4Iw2TW6bw3TNCobKSXX2p7mqZ5wHiHz8wB2K9sZe6T9xto9DI0l+mP9EUW8pLVGqHCPuzbSynMgvZy9+0Kos+iWJKgt30C69KUFJj+bfGKlobrI+GzlOWryn34mS+eaGEdqOZZpLt9w7qfOrheEl8BJIwJ4bh9jUujf7zMd8jNTNKj27azOVMi7DnSWiDjabIBCza2/9Qr/FFXz1uozbNTAStgH/M0ZZDOXxaXuquaYXLl0FenO4AxhhqZluGWLisTfK8BBipfdezAyGLsqeyNtroYUcEvxZDukaFIlLWphMUsMspQ6BEIVc+d+jdM/mKScWF7Zzc81P6TmFdlsqI96GS8zkGtirLs2S4Txr770X2SC97ZEQaOxll6P45ME4Jl820ogJerd4e3fY4j2dbAPvjhrVNVJnnZUEm4Rm/6YmuUZoFaDrUY92WWF3w/5TO6fBr1NMWD58h8spf8pwcG66RHtRo3aGBbhKjKDuV0SiWKN2006kZK9M4lWQU3Fsqk50hhZK9AufD4r4ojpstnk+RBRu5GXSzrtq3CzMMsVhVpmMZ0/Rh5ntFVHkf8beewFkSoc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261009223027099003)(261009221227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261022113327099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jdX41KFO2GRlsi0yAKy8Q0Fyo+TJtdaU4PxapMSmziPv+lyz/xQA4JUq6tHdJTd+YD9+1ae/0SciU8TbGF/TCRoxNxHoAioo7HlyrK3/Zn343oMR84omeRNVNQ7YGUPpjSJpRPgS5PUs5k7asb6sbJNVm/oJW82Md6lQ8SefbanUcvEpzefP4oo06kgmg2HTOb/7JsCXOQbVMkJQl2t/RnUToLRLSurE3qin3mCZhXD4BqMgtW/HdbJ/TCetm/NpGx/dmMYAaPUR9l5WiDhUDtc+345I7Ytc30WHLgeeqb4EHjynm6hWrfWxqSdyoMkGw0A6gaGMgHa0XkO8zeF0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2d99e68a-0eab-48ac-47eb-08df3f411099
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|23010399003|376014|82310400026|36860700016|14060799003|261022113327099003|261026140227099003|261022075727099003|261028144727099003|11063799006|56012099006|261021121427099003|261022105027099003|261009221227099003|261021123027099003|261026121527099003|261009223027099003|261102123227099003|22082099003|18002099003|6133799003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: i5qXQcpcOBQtTYhxGjM9B7BB6e3RVbpU/L3/NBU0W5KcblY7kDQeSFA9W8AL4Fmkj+121Iqc0X/ZBoOaG0HA2fsr/YPlR9WurIHTt3i90kGCDpVHMfLYo0mHOkPQjgcE4iESGjCxh3PU7540MeHf2pRm189FTfI7lDdwevetlIv19RY3ZRYbXjrWpsXBk/FNunXL+9hqPsay8XFUKal9+8bH77bHMqedkfvmCh/dy+eRj6MjZEnevstFEleMKq3vV7OUSBMktndcCLz+7kziAnqOoZflwwk+T5TQ17osn9XdxeXmIBBNmFgm8CJ4igTRgAtGbr/UsgVXDb16o6GGwkVY3VQcz0m0JHdveiz46JN4VWdoUceI5s+lgC8tbBf48R8DH5e0fdPO603XGpc2/caauUuvYXNNiB07PJIwpN0CTjufTB8tDXTij3gLs0QMbItWVB+u8n3gst3HkEM5rMDw7ls0AFt0QgtcYoxZokl5rnIo70wWHvJs278I8whJ4/TehoN/GCX8DX1HQAI+CxjhDc+us7U1VpJF2oLA9BzyONLdDhl4YG6rmmlfChwBMHFoREuCCgYHFWsBXuW5N+1O4/TJrurNKB2gKv8VT3D4bU1YrMtW5uZw6NSJ4XnYfSlZuoP6HmTwG9YTAZPwJcV4STFyy/u3JOvrmSmBBLE2d4Ew7YjA2evFs1t/2BomQg9c7IF/RUvUQogy54K/ew==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(14060799003)(261022113327099003)(261026140227099003)(261022075727099003)(261028144727099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009221227099003)(261021123027099003)(261026121527099003)(261009223027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uu7OC5HOFpGTW1CNNfTU1jLuxs3IMYej/jsZqDEIxa5d6SxFIAP2gZt1TVk175C4fdUI89M1/sP+GpVaA+/x8D7aXwdCc6tEI9s3s2LQo1rDxuZBv5dLLFAODdEYiX3bjIyI2t2i8WifWb9Zo9/iC3JoIMBXbLKibYafXYXw6iY8iDG2SpxqF/G6DJFEZJ2Gh9Tpbn4XpAdjEvoWi5EEAqlRTx4aSfzpxNcINjFSTrXzNDUVGkwfBOcJE56qAGVfM19VYTJNRmZrpRRZMKbrEZibNjS1YMnIyPwCNwYBStolur1mp4j78H8nQ4j+4LukwQqgX1X21xlsmcvCJrnhgcGkRIEGEFlo97GuGwoDZO82egbuTIukJcvBz6BZQ1xg9rZ7Y0O/HVFSe4RsRsdYqL5xSo0UYmpLnvM+GMF6cYu3EMbxvSM4uYUIBVs0OUCv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:53.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff8d45d-5721-4ef5-5e3c-08df3f41250a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8839
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

Add the VM-side access-window component for Mali v15 GPUs.

Negotiate the AM message version, request GPU access from the
arbiter, and wait for the window-open interrupt. Yield GPU access
during suspend.

Keep hardware binding in panthor_hw_init(). Call
panthor_hw_info_init() to read GPU information after
panthor_aw_init() obtains GPU access.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Introduce spinlock to protect and serialize state acquisition and
  updates.
- Make panthor_aw_request recheck states after wait to handle unexpected
  state transitions and prevent timing out waiting on an invalid state.
- Tighten protocol version checks and reject sending GPU_REQUEST to
  incompatible arbiter.
- Handle lost GPU_REQUEST message if arbiter was restarted
- Add WINDOW_CLOSED and WINDOW_OPENED handling.
- Fix indentation for IRQ_NONE return in the IRQ raw handler.
- clean up IRQ state during failed initialization and termination.
- Handle yielding of the GPU during termination.
- Split GPU_STOPPED state into YIELDING and SUSPEND_PENDING. Removed old
  GPU_STOP state as we no longer support the ARB_VM_GPU_STOP message.
v1:
- Adapt AW IRQ handling to the updated IRQ locking/state interfaces and
  reuse panthor_irq_suspend().
- Handle -ENOSPC from AM message sending when the outgoing FIFO is full.

 drivers/gpu/drm/panthor/Makefile         |   1 +
 drivers/gpu/drm/panthor/panthor_aw.c     | 498 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h     |  42 ++
 drivers/gpu/drm/panthor/panthor_device.c |  15 +-
 drivers/gpu/drm/panthor/panthor_device.h |   4 +
 drivers/gpu/drm/panthor/panthor_hw.c     |   8 +-
 drivers/gpu/drm/panthor/panthor_hw.h     |   2 +
 7 files changed, 563 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 5d4d0ae64952e..aa48212653dc3 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0 or MIT
 
 panthor-y := \
+	panthor_aw.o \
 	panthor_devfreq.o \
 	panthor_device.o \
 	panthor_drv.o \
diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
new file mode 100644
index 0000000000000..5ab1d44f0a22e
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+#include <drm/drm_drv.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_aw.h"
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_hw.h"
+#include "panthor_sched.h"
+
+#include "panthor_trace.h"
+
+#define WINDOW_CONTROL_BASE				0x0
+#define WINDOW_CONTROL_SIZE				0x1000
+
+#define WINDOW_STATUS					0x43c
+#define   WINDOW_STATUS_IRQ_WINDOW_CONTROL		BIT(0)
+#define   WINDOW_STATUS_IRQ_GPU_CONTROL			BIT(1)
+#define   WINDOW_STATUS_IRQ_GPU_POWER			BIT(2)
+#define   WINDOW_STATUS_IRQ_JOB_CONTROL			BIT(3)
+#define   WINDOW_STATUS_IRQ_MMU_CONTROL			BIT(4)
+#define   WINDOW_STATUS_WINDOW_OPEN			BIT(31)
+
+#define WINDOW_INT_BASE					0x440
+#define   WINDOW_IRQ_MESSAGE				BIT(0)
+#define   WINDOW_IRQ_INVALID_ACCESS			BIT(1)
+#define   WINDOW_IRQ_WINDOW_OPENING			BIT(2)
+#define   WINDOW_IRQ_WINDOW_OPENED			BIT(3)
+#define   WINDOW_IRQ_WINDOW_CLOSED			BIT(4)
+
+#define WINDOW_MESSAGE_BASE				0x460
+
+#define WINDOW_IRQ_MASK \
+	(WINDOW_IRQ_MESSAGE | WINDOW_IRQ_WINDOW_OPENED | WINDOW_IRQ_WINDOW_CLOSED)
+
+#define PANTHOR_AW_HANDSHAKE_TIMEOUT_MS			(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+
+#define panthor_aw_wait_cond(_aw, _cond, _timeout_ms)				\
+({										\
+	int __ret = 0;								\
+	if (!wait_event_timeout((_aw)->waitqueue, _cond,			\
+				msecs_to_jiffies(_timeout_ms)))			\
+		if (!(_cond))							\
+			__ret = -ETIMEDOUT;					\
+	__ret;									\
+})
+
+struct panthor_aw {
+	/** @ptdev: Pointer to Panthor device */
+	struct panthor_device *ptdev;
+
+	/** @iomem: CPU mapping of WINDOW_CONTROL iomem region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ data */
+	struct panthor_irq irq;
+
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @lock: Protects @state */
+	spinlock_t lock;
+
+	/** @state: Current state of the AW */
+	atomic_t state;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to resend messages */
+	struct work_struct msg_retry_work;
+};
+
+static bool panthor_aw_is_open(struct panthor_aw *aw)
+{
+	return gpu_read(aw->iomem, WINDOW_STATUS) & WINDOW_STATUS_WINDOW_OPEN;
+}
+
+static void panthor_aw_state_set(struct panthor_aw *aw, enum panthor_aw_state new)
+{
+	atomic_set(&aw->state, new);
+
+	wake_up_all(&aw->waitqueue);
+}
+
+static bool panthor_aw_state_try_set(struct panthor_aw *aw,
+				     enum panthor_aw_state expected,
+				     enum panthor_aw_state new)
+{
+	int old_state = atomic_cmpxchg(&aw->state, expected, new);
+	bool res = (old_state == expected);
+
+	if (res)
+		wake_up_all(&aw->waitqueue);
+
+	return res;
+}
+
+static int panthor_aw_state_wait(struct panthor_aw *aw,
+				 enum panthor_aw_state target, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(aw, atomic_read(&aw->state) == target, timeout_ms);
+}
+
+static void panthor_aw_msg_retry_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, msg_retry_work);
+	struct panthor_am_msg *msg = &aw->msg;
+	int ret;
+
+	ret = panthor_am_msg_retry(msg);
+	if (ret == -EINVAL)
+		drm_warn(&aw->ptdev->base, "Send FIFO unexpectedly empty");
+
+	if (ret == -EBUSY || ret == -EAGAIN)
+		queue_work(aw->wq, &aw->msg_retry_work);
+}
+
+static void panthor_aw_send_msg(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	int ret;
+
+	ret = panthor_am_msg_send(&aw->msg, message);
+	if (ret == -ENOSPC)
+		drm_err(&ptdev->base, "Send FIFO is full");
+
+	if (ret == -EBUSY) {
+		drm_dbg(&ptdev->base, "Pending messages, scheduling retry work");
+		queue_work(aw->wq, &aw->msg_retry_work);
+	}
+}
+
+static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	u8 reply_version = AM_MSG_CURRENT_VERSION;
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw->msg, version, acked,
+					      &reply_version);
+	if (ret == -EOPNOTSUPP)
+		drm_warn(&ptdev->base,
+			 "Msg protocol version less than minimum supported (%u < %u)",
+			 version, AM_MSG_MIN_SUPPORTED_VERSION);
+
+	if (!acked) {
+		u64 reply = VM_ARB_INIT_MAKE(1, reply_version);
+
+		panthor_aw_send_msg(aw, reply);
+
+		guard(spinlock_irqsave)(&aw->lock);
+
+		/*
+		 * If state is GPU_REQUEST, arbiter previously completed
+		 * handshake, New INIT could mean that the arbiter was restarted
+		 * and we need to resend GPU_REQUEST.
+		 */
+		if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_REQUEST) {
+			panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
+			return;
+		}
+	}
+
+	scoped_guard(spinlock_irqsave, &aw->lock)
+		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_INIT,
+					 PANTHOR_AW_STATE_READY);
+}
+
+static void panthor_aw_handshake_init(struct panthor_aw *aw)
+{
+	u64 message = VM_ARB_INIT_MAKE(0, AM_MSG_CURRENT_VERSION);
+
+	panthor_aw_send_msg(aw, message);
+}
+
+static void panthor_aw_handle_message(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	const u64 message = panthor_am_msg_read(&aw->msg);
+	const u8 msg_id = AM_MSG_ID_GET(message);
+
+	/* currently only support ARB_VM_INIT */
+	if (msg_id == ARB_VM_INIT)
+		panthor_aw_handshake_handle(aw, message);
+	else
+		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
+}
+
+static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+
+	guard(spinlock_irqsave)(&aw->lock);
+
+	if (panthor_aw_is_open(aw))
+		return;
+
+	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+		/* TODO: schedule cleanup */
+		break;
+	case PANTHOR_AW_STATE_GPU_REQUEST:
+		/*
+		 * Window may have been closed immediately after opening.
+		 * Setting state back to READY will prevent WINDOW_OPENED from
+		 * mistakenly transitioning the state to GRANTED.
+		 */
+	case PANTHOR_AW_STATE_YIELDING:
+		/* Triggered from messaged-based yield. Unblock its wait */
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+		break;
+	default:
+		drm_warn(&ptdev->base, "Unexpected WINDOW_CLOSED received");
+		break;
+	}
+}
+
+static void panthor_aw_handle_window_opened(struct panthor_aw *aw)
+{
+	guard(spinlock_irqsave)(&aw->lock);
+
+	if (!panthor_aw_is_open(aw))
+		return;
+
+	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+	case PANTHOR_AW_STATE_SUSPEND_PENDING:
+	case PANTHOR_AW_STATE_INIT:
+		break;
+	case PANTHOR_AW_STATE_GPU_REQUEST:
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_GPU_GRANTED);
+		break;
+	default:
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_YIELDING);
+		panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
+	}
+}
+
+static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
+{
+	struct panthor_irq *pirq = data;
+	struct panthor_device *ptdev = pirq->ptdev;
+	struct panthor_aw *aw = ptdev->aw;
+	u32 status;
+
+	scoped_guard(spinlock_irqsave, &pirq->lock) {
+		if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
+			return IRQ_NONE;
+	}
+
+	status = gpu_read(pirq->iomem, INT_STAT);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & WINDOW_IRQ_MESSAGE)
+		panthor_aw_handle_message(aw);
+
+	if (status & WINDOW_IRQ_WINDOW_CLOSED)
+		panthor_aw_handle_window_closed(aw);
+
+	if (status & WINDOW_IRQ_WINDOW_OPENED)
+		panthor_aw_handle_window_opened(aw);
+
+	gpu_write(pirq->iomem, INT_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void panthor_aw_irq_suspend(struct panthor_irq *pirq)
+{
+	panthor_irq_suspend(pirq);
+}
+
+static void panthor_aw_irq_resume(struct panthor_irq *pirq)
+{
+	guard(spinlock_irqsave)(&pirq->lock);
+
+	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);
+}
+
+static int panthor_request_aw_irq(struct panthor_device *ptdev,
+				  struct panthor_irq *pirq, int irq,
+				  void __iomem *iomem)
+{
+	pirq->ptdev = ptdev;
+	pirq->irq = irq;
+	pirq->mask = 0;
+	pirq->iomem = iomem;
+	spin_lock_init(&pirq->lock);
+	pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;
+
+	gpu_write(pirq->iomem, INT_MASK, 0);
+	return devm_request_irq(ptdev->base.dev, irq, panthor_aw_irq_raw_hander,
+				IRQF_SHARED, "panthor-aw", pirq);
+}
+
+static int panthor_aw_request(struct panthor_aw *aw)
+{
+	enum panthor_aw_state state;
+	u32 timeout_ms;
+	int ret;
+
+again:
+	scoped_guard(spinlock_irqsave, &aw->lock) {
+		state = atomic_read(&aw->state);
+
+		switch (state) {
+		case PANTHOR_AW_STATE_GPU_GRANTED:
+			return 0;
+		case PANTHOR_AW_STATE_SUSPEND_PENDING:
+			return -EAGAIN;
+		case PANTHOR_AW_STATE_INIT:
+			panthor_aw_handshake_init(aw);
+			timeout_ms = PANTHOR_AW_HANDSHAKE_TIMEOUT_MS;
+			break;
+		case PANTHOR_AW_STATE_READY:
+			if (!panthor_am_msg_supported(&aw->msg)) {
+				drm_err(&aw->ptdev->base,
+					"unsupported protocol version 0x%x. MIN: 0x%x CUR: 0x%x",
+					aw->msg.version,
+					AM_MSG_MIN_SUPPORTED_VERSION,
+					AM_MSG_CURRENT_VERSION);
+				return -EOPNOTSUPP;
+			}
+
+			panthor_aw_state_set(aw, PANTHOR_AW_STATE_GPU_REQUEST);
+			panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
+			fallthrough;
+		case PANTHOR_AW_STATE_GPU_REQUEST:
+			timeout_ms = PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS;
+			break;
+		case PANTHOR_AW_STATE_YIELDING:
+			timeout_ms = PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS;
+			break;
+		}
+
+		state = atomic_read(&aw->state);
+	}
+
+	ret = panthor_aw_wait_cond(aw, atomic_read(&aw->state) != state, timeout_ms);
+	if (ret) {
+		scoped_guard(spinlock_irqsave, &aw->lock) {
+			switch (atomic_read(&aw->state)) {
+			case PANTHOR_AW_STATE_GPU_GRANTED:
+				return 0;
+			case PANTHOR_AW_STATE_GPU_REQUEST:
+				panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+				break;
+			default:
+				break;
+			}
+		}
+
+		return ret;
+	}
+
+	goto again;
+}
+
+static int __panthor_aw_suspend(struct panthor_aw *aw)
+{
+	scoped_guard(spinlock_irqsave, &aw->lock) {
+		switch (atomic_read(&aw->state)) {
+		case PANTHOR_AW_STATE_READY:
+			return 0;
+		case PANTHOR_AW_STATE_SUSPEND_PENDING:
+			return 0;
+		case PANTHOR_AW_STATE_GPU_GRANTED:
+			panthor_aw_state_set(aw, PANTHOR_AW_STATE_YIELDING);
+			panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
+				     PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+}
+
+int panthor_aw_init(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw;
+	int irq;
+	int ret;
+
+	if (!panthor_hw_has_gpu_discover(ptdev))
+		return 0;
+
+	aw = drmm_kzalloc(&ptdev->base, sizeof(*aw), GFP_KERNEL);
+	if (!aw)
+		return -ENOMEM;
+
+	aw->wq = drmm_alloc_ordered_workqueue(&ptdev->base, "panthor-aw-wq", 0);
+	if (IS_ERR(aw->wq))
+		return PTR_ERR(aw->wq);
+
+	aw->ptdev = ptdev;
+	aw->iomem = ptdev->iomem;
+
+	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+
+	init_waitqueue_head(&aw->waitqueue);
+	spin_lock_init(&aw->lock);
+	atomic_set(&aw->state, PANTHOR_AW_STATE_INIT);
+
+	panthor_am_msg_init(&aw->msg, aw->iomem + WINDOW_MESSAGE_BASE);
+
+	ptdev->aw = aw;
+
+	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "gpu");
+	if (irq < 0)
+		return irq;
+
+	ret = panthor_request_aw_irq(ptdev, &aw->irq, irq, aw->iomem + WINDOW_INT_BASE);
+	if (ret)
+		return ret;
+
+	panthor_irq_enable_events(&aw->irq, WINDOW_IRQ_MASK);
+	panthor_aw_irq_resume(&aw->irq);
+
+	ret = panthor_aw_request(aw);
+	if (ret)
+		panthor_aw_unplug(ptdev);
+
+	return ret;
+}
+
+void panthor_aw_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
+		__panthor_aw_suspend(aw);
+		panthor_aw_irq_suspend(&aw->irq);
+	}
+
+	disable_work_sync(&aw->msg_retry_work);
+}
+
+int panthor_aw_resume(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret;
+
+	if (!aw)
+		return 0;
+
+	panthor_aw_irq_resume(&aw->irq);
+
+	ret = panthor_aw_request(aw);
+	if (ret) {
+		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	panthor_aw_irq_suspend(&aw->irq);
+	return ret;
+}
+
+int panthor_aw_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret = 0;
+
+	/* suspend hw components directly if AW is not supported */
+	if (!aw)
+		return 0;
+
+	ret = __panthor_aw_suspend(aw);
+
+	panthor_aw_irq_suspend(&aw->irq);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
new file mode 100644
index 0000000000000..60d5c8b6c9afc
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AW_H__
+#define __PANTHOR_AW_H__
+
+#include <linux/types.h>
+
+struct panthor_device;
+
+/**
+ * enum panthor_aw_state - Enumeration of possible Access Window states
+ */
+enum panthor_aw_state {
+	/** @PANTHOR_AW_STATE_INIT: Initial state, prior to handshake. */
+	PANTHOR_AW_STATE_INIT = 0,
+
+	/** @PANTHOR_AW_STATE_READY: Handshake with Resource Group completed. */
+	PANTHOR_AW_STATE_READY,
+
+	/** @PANTHOR_AW_STATE_GPU_REQUEST: AW requested for GPU access. */
+	PANTHOR_AW_STATE_GPU_REQUEST,
+
+	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
+	PANTHOR_AW_STATE_GPU_GRANTED,
+
+	/** @PANTHOR_AW_STATE_YIELDING: Stopped GPU access, pending close. */
+	PANTHOR_AW_STATE_YIELDING,
+
+	/** @PANTHOR_AW_STATE_SUSPEND_PENDING: AW closed, pending host cleanup. */
+	PANTHOR_AW_STATE_SUSPEND_PENDING,
+};
+
+int panthor_aw_init(struct panthor_device *ptdev);
+
+void panthor_aw_unplug(struct panthor_device *ptdev);
+
+int panthor_aw_resume(struct panthor_device *ptdev);
+
+int panthor_aw_suspend(struct panthor_device *ptdev);
+
+#endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de3505..98c0dd3ce7bcb 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -16,6 +16,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -100,6 +101,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_gem_shrinker_unplug(ptdev);
 	panthor_gpu_unplug(ptdev);
 	panthor_pwr_unplug(ptdev);
+	panthor_aw_unplug(ptdev);
 
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
@@ -259,10 +261,18 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = panthor_pwr_init(ptdev);
+	ret = panthor_aw_init(ptdev);
 	if (ret)
 		goto err_rpm_put;
 
+	ret = panthor_hw_info_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
+	ret = panthor_pwr_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
 	ret = panthor_gpu_init(ptdev);
 	if (ret)
 		goto err_unplug_pwr;
@@ -322,6 +332,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 err_unplug_pwr:
 	panthor_pwr_unplug(ptdev);
 
+err_unplug_aw:
+	panthor_aw_unplug(ptdev);
+
 err_rpm_put:
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f0a96ff0f13da..ede630ddce3e1 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -21,6 +21,7 @@
 
 #include "panthor_device_io.h"
 
+struct panthor_aw;
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -202,6 +203,9 @@ struct panthor_device {
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
+	/** @aw: AW-specific data */
+	struct panthor_aw *aw;
+
 	/** @pwr: Power control management data. */
 	struct panthor_pwr *pwr;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index e8e899c638128..7d40091c1e95a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -353,7 +353,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	return overload_shader_present(ptdev);
 }
 
-static int panthor_hw_info_init(struct panthor_device *ptdev)
+int panthor_hw_info_init(struct panthor_device *ptdev)
 {
 	u64 l2_features;
 	u32 prod_id, major, minor, status;
@@ -471,9 +471,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	ret = panthor_hw_bind_device(ptdev);
-	if (ret)
-		return ret;
-
-	return panthor_hw_info_init(ptdev);
+	return panthor_hw_bind_device(ptdev);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index dee641c698661..6ca20701f96e1 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -66,6 +66,8 @@ struct panthor_hw {
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
+int panthor_hw_info_init(struct panthor_device *ptdev);
+
 int panthor_hw_power_status_register(void);
 void panthor_hw_power_status_unregister(void);
 
-- 
2.43.0

