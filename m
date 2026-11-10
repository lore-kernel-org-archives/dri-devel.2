Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A44606D74E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oRog6ggn;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oRog6ggn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BC910F7C4;
	Tue, 10 Nov 2026 15:42:33 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C9210F7C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q7+9peeVxLirnkfC6y3SkYjQzoHD1yKIBjIPEDGxjwLTwt9diwHtLVG1xw1jIKW10UZgJbQrtNa/BHuHml1rFqgivlUCUxzFxGBSwqQcZKN346bt7bFhv+658oK3opXN+HVrDjLEPUBLYeN+sYvwJa1HXFWuK5LIukyO+Ym+BRXw9BKv0IbfGHYkIHjsA6w+j+q0Dmy4noDHpc93WQ7lXaXZQG+Z5z2xJuAiUchqIuOfh8X4H4s5/N8qCU4388UyYhLetpxoTse8HYqVNPRokkhQo2wW6MLNuUbXWN9mRbrcH7tuorTxJrxMl/jsSbbyKPHmKoCQ1V+1HyJbF4Osdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E17IqINVkHbc4xGwI1j8S23SSyo46XlKmEFl9Kt4OCc=;
 b=jLhewdCIdFmTLYpZDCBiYCCpXvrmspojobvqZg7C5eVhDqJYPIYF3cGwpD6v0oXCPlq7zzxVKlC7w8jerjFEUMTyjmt+MH8L5rS7CpJ0iKTj7g1g7BTkA4FPMK8RzR8cqxSsWnUIBqgMR7TCaqeS6lKDcE0XiZTXroFrv1g3ng2UIakMTJiZR6CvSvE4mRYVxg0W53ZZjfcspn8keuxMoJmFD2kvj3B3JUNn+dynAFmm29P4xQ7mBcma8h8lMXX5pfPuTpdJQdUAXFfkGvF6p0Pxni2GBQfWDCgV959Y6cOjI2rzSBgXxS+tuT2dfWd+eV7jr4WiL3iMjOwXQgwjdQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17IqINVkHbc4xGwI1j8S23SSyo46XlKmEFl9Kt4OCc=;
 b=oRog6ggn3jwk9UG0iGbmaucaLgAeVGssvhIZ0d2mdmVmUlt8g3wCVCRzP1mua1SRyPiBphqOFMNAFFUZYtAEfNESAG4cl05wRAHjNBPgZyxtl3W/euyd71W5L5zvvaCzvkS1lENDBuuJkk+bHAJLoajJs9s+v3vinYGrK80JCtA=
Received: from AS9PR06CA0589.eurprd06.prod.outlook.com (2603:10a6:20b:486::27)
 by DB9PR08MB7868.eurprd08.prod.outlook.com (2603:10a6:10:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:42:16 +0000
Received: from AM1PEPF000C1ADA.eurprd02.prod.outlook.com
 (2603:10a6:20b:486:cafe::ae) by AS9PR06CA0589.outlook.office365.com
 (2603:10a6:20b:486::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 15:42:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1ADA.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxIi5KJl/yfwXdy7vIv9xgqTecMhYZSTyyw3f0/2+LrbuqlxM4SMJqXPprl4zfRkgvEwFBn9190Ntb5oU36+pd4CFhSaGrFe4ROat6xJ5iaLwpj/6qhaDvTVz+7B7ttlmz7LmCcO1kpGUK+5REGIbsiTFk6RrIplaJjyTpSDj0l631rcYLFNRDLG/rkSpPM9M/0BJJE1fCx7BUFYIkxIxj3mw2rjVPzQqDrTVKMTl2UyreUPx4ZwZKLRnOgX06Tr8hdhakujPuSfTYNAubqQJFF4kNFX1nPYD4q24LFacvhwTloyTcoLX2ValYVmJpnjqPgmFheiYh3Uontd4168/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E17IqINVkHbc4xGwI1j8S23SSyo46XlKmEFl9Kt4OCc=;
 b=FP/ZHijoJ7opa8d83P/n1rfOdZmGfpXEfF32QT0c2jZLpqksJGbKCLaik2XO4q8iHxAPWB8F0uNOjmM3OhM6vVbg2vUap6KMd26O9GRcAk2LnHp/Ss7crCdAiC4UZqUikIqZcP22I1P+jgAKgMyqosDcLmnULNSCs0Npdg9OLud7GgwXGMHqgjd+wmUCf55MMWFqhEYjctClHksjIY/ajf3YLbVjF1tZTSNILjVS04FRPJJojEpjy2M28Cooa4QOFc/uPX0iZhWHpHoRAKxVsa9CqMRrRJ57QLn1CP0sTyaVJQW2DpTuwY6YX3e7/UzihfyaAJlHw8y+mBhR+T+yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17IqINVkHbc4xGwI1j8S23SSyo46XlKmEFl9Kt4OCc=;
 b=oRog6ggn3jwk9UG0iGbmaucaLgAeVGssvhIZ0d2mdmVmUlt8g3wCVCRzP1mua1SRyPiBphqOFMNAFFUZYtAEfNESAG4cl05wRAHjNBPgZyxtl3W/euyd71W5L5zvvaCzvkS1lENDBuuJkk+bHAJLoajJs9s+v3vinYGrK80JCtA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:43 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:43 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 28/28] drm/panthor: Reset partitions before starting
 arbitration
Date: Tue, 10 Nov 2026 15:38:49 +0000
Message-ID: <20261110153907.3241978-29-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|AM1PEPF000C1ADA:EE_|DB9PR08MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: d1de5ff3-eb56-49eb-df72-08df3f41327c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: wGUSedvaUEUZFMExgrHBYqEcXDySwoJxr16Q5vnGHpuXjHaSS770zDNt0LWuJObcmQwoqxNWzh9rE9SEvJ38/90GVuOEzqYJbz4WBeXCj4vgPdpk90DdElYl7zz+6rWPlPQEHgXCnKpt5NQVPtr+NdtVyh1Fp7snuLtM/0WoAdMLi3A/kwZcHR+dJw5+Pwy2L9DB45GpPJ2MywMfdOynuNvvEdj0EDtK8833RvLuh1MZsfD/QimPNtRtEWNQohGUmTYHOPBIWKkagmuYxH8cA1A5fre51NayzY3yGpc/OlZrNquWuQgwC2oIXrMfV7Z7z3+nUeGeszNwbhsmebKUVPxeG670AubBNxfTR7adqCLCENkosF2Fh5otemaLu2Q6U2PBuBss23I4gjciNgytM07xf9GkGeBiDAQrSIdmV4n86iAvnKXq29b5Iw0aV5HpiZFb868IsNAYnkbXAnVIUfALiJALay2z2ZJL4rJCg+lzAO87KZt+VexQYS78rGSs3+32AJbCNeiJjY30rHv+/8n1EfvwzN6m3vsyxF9wwWeWJdK1OA3BtK3t8hPkfiRjBNJUWwYRtaRHXt9B+H7+rUWjTyoFp/QrIit27LDA23P6PfH5mEvfUv010xE7VKjXYhARZBS399Ulb6OBO3jgPnIKcxaGuDWMGcp/vrbMPKU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 2bnOPbmo7cSWRYFqmgGvOgesTsMpyUTZKACsE+0jdJmfEyrkIUaikZkmpiBKx1XdWh25CyJUZT9U+Fy97mKhx9rYaBbj1prtuhvHlSwhGcBX7fgU/8T6jF2UdhynP7XqV9Zrx88G+r4XDqNZYed7R0tylS2OkOwSYPRtOlofdcTIlLWs3wlsX4+H4t69ZzpK4FQs8kU9F8+5ZU+a02ElRsEfoKJOnUqA6We4B3DZT0U57HL8eb4ghCyraREiy7H9QYF7UMb6c2Wj8n8wwe5EWUYXsSx5FZBXEdTd2u+IgH2DB/u90AeC/wTcDoOgojSSKiLwq8w2h1epruGO5v1J+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000C1ADA.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7695aeac-c54e-4386-f98b-08df3f411ef5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|36860700016|23010399003|35042699022|376014|22082099003|18002099003|6133799003|10067099003|11063799006|261028144727099003|261026121527099003|261009223027099003|261022075727099003|261021121427099003|261022105027099003|261026140227099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info: 73YacMOUobyjY6i0Y34U+IDovNPBkOfMnxj+30CYeY5+vHr2yU3ERzoW2aOcC6NmJZXUq6YwD3j7O1/ZIHIkrmKI52WxSIoab0SgeVgBBbKqIk0klzOQchMCbWC1TcLRiLBQH981x2P3Kyd7g8oU4LA0lGNMhBigWyM7MJgBZWeDloXF4SCplXf/RS3shcbKMakwFmi2cCOfNUDU2pWg8mNo77Am6yhpafg3KHt1+lq5THNaVaAHLxS3SE/fyXEtDe5ky+gtlXE3goFocU+8SeSBA5X2ywXJE/RFGTjhEx84uC1h27rRqbsMx/rGjpI3y0Gyse5eqsepH4OkMhAt3YsgwvHp2aldJpWdmV1RuBkCk4gq+uLNSFJxGLNX+hQlV04MCunNL/kFNCJLoOvInWklDjyO9ZGXXKaf8EXgxTxLsDG/Ioq03wznt8vMAAMO2EN8uiBdT5sw/12gxCKSBIE4rooytMVm/kDKb6iV0L77AF9Y0KRoZnPfsSDhpPSZEUAozv9n4zSmFmOtLX+sCfFZpc8yi/GR7b7VYb5IZMys3Pc30rD2VnXZmLWTIYjHP3sHb1OXaOZbN3HKIOhdQi2ku6sFfIQBkbaXXSCdDExaYcbigvPvbHqwkTGnJ6yxCgp/h8xf96Dbyzus0o16PMDNgcmMGGXWZTQm6wVVmKdINqG6ywzthabKW+QaQW7i0ivB+hrM35CPOoJQqt7Byw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(36860700016)(23010399003)(35042699022)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261009223027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026140227099003)(56012099006)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VNqHEgzrj+Q4DzKBu/M59rGMFR0WZbBJjPEipVZk2CYqXsyCtpJ8mIRQCpPk9bS/14TO+5zNLGA3wOybNifuVqPJAwA7/0D8OxuaQkAa5b2IrsWGlvuYpw59Xp9/dc1T3wkYcwk5ABmrizMCcs+IiOjystXyVMIOHFN3rg9Gc708+fngTPl7C3gyd02yEg0+XJcxeTpAmoMrRy41TNuhp/QZJssXEBHKP3G5MeIZ1ip3EerH/n7w8gZLalgrk8N+dfLQpDRfKXMqICCESUqGlaPyv4mjJV4P9tZnXiAMfYG6FHpzyhV6lJgLmJZ1JQUbNN9B0HaUomL1ygp3eatjG3v/k0UU4XbJM37gFpTK824TO3MARADOaLetC7RZMjQFpixMcp04azDDzwozga1dtvr6TzW1D8zDOhkNjVSpE+wy+l91YjeCNxGLrEiJlwZE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:42:16.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de5ff3-eb56-49eb-df72-08df3f41327c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1ADA.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7868
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

A partition may still have an open access window when the arbiter
starts (typically from restarting the driver), while its software state
assumes no active window. Starting arbitration in this state can leave
software out of sync with the hardware.

Recover each partition to RESET before enabling its interrupts. Allow
open windows to yield, fall back to forced close if necessary, and bound
recovery attempts so failure aborts initialization.

Keep partition interrupts masked during recovery and clean up before
normal operation begins.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../arbitration/panthor_partition_control.c   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index 3b472403f49d1..2c0f8dc0b3bfb 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -43,6 +43,7 @@
 
 #define PART_REG_POLL_SLEEP_US			10
 #define PART_STATE_TRANSITION_TIMEOUT_US	5000000
+#define PART_ENSURE_RESET_RETRY_COUNT		3
 
 /** struct panthor_partition_cmd - Partition command data */
 struct panthor_partition_cmd {
@@ -368,6 +369,54 @@ void panthor_partition_control_term(struct panthor_arbitration *adev)
 	}
 }
 
+static int partition_ensure_reset(struct panthor_partition_control *pc)
+{
+	int ret = 0;
+	int count = 0;
+
+again:
+	if ((count >= PART_ENSURE_RESET_RETRY_COUNT) &&
+	    (partition_state_get(pc) != PART_STATE_RESET))
+		return -ETIMEDOUT;
+
+	count++;
+
+	switch (partition_state_get(pc)) {
+	case PART_STATE_RESET:
+		/* clear any remnants of this operation */
+		gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_CONTROL_IRQ_MASK);
+		pc->closing = false;
+		pc->last_cmd.aw_id = AW_UNASSIGNED;
+		pc->last_cmd.cmd = 0;
+		return 0;
+	case PART_STATE_WINDOW_OPENING:
+		ret = partition_state_wait(pc, PART_STATE_WINDOW_OPEN);
+		fallthrough;
+	case PART_STATE_WINDOW_OPEN:
+		/*
+		 * Window was left open likely due to arbiter restart. Send
+		 * YIELD_NOW to current AW and wait for it to yield GPU access.
+		 * On timeout, forcibly close the window.
+		 */
+		if (!ret)
+			ret = yield_now(pc);
+		else
+			ret = window_close(pc);
+
+		/* state changed, reevaluate state */
+		if (ret == -EAGAIN) {
+			ret = 0;
+			goto again;
+		}
+		fallthrough;
+	case PART_STATE_WINDOW_CLOSED:
+		ret = partition_state_wait(pc, PART_STATE_RESET);
+		goto again;
+	}
+
+	return -EINVAL;
+}
+
 static int partition_control_init(struct panthor_arbitration *adev, int i)
 {
 	struct panthor_partition_control *pc;
@@ -407,6 +456,7 @@ static int partition_control_init(struct panthor_arbitration *adev, int i)
 
 	spin_lock_init(&pc->irq_lock);
 	pc->irq_suspended = true;
+	gpu_write(pc->iomem, AM_PART_IRQ_MASK, 0);
 
 	spin_lock_init(&pc->lock);
 	pc->current_aw = AW_UNASSIGNED;
@@ -429,6 +479,10 @@ static int partition_control_init(struct panthor_arbitration *adev, int i)
 
 	adev->pc[i] = pc;
 
+	ret = partition_ensure_reset(pc);
+	if (ret)
+		return ret;
+
 	partition_irq_resume(pc);
 
 	return 0;
-- 
2.43.0

