Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D660A6F72
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=cWmaI2WO;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=cWmaI2WO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E1410E05D;
	Tue, 10 Nov 2026 15:41:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0827D10F7AB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:26 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=twPVBz8mjS7qWPER4PXhlerSb4+6wMgG3uz6UYCsUjsGoZxxWV9N6EPTyOBEB4Vh9W6b3tNn+Ez7s5Gchu/H4/AbMOa+XAF36GMMwCW5mlgaHcWUur4TEPtJQu3eTXIfzRDQsGyeO6ufC1+lBRvDW9atPIQwy5KtUZp2LVjTwyHTbiu/hFe7rcWHfLHr1xVlDygLNLso/4Yxlote/ELXvTouYGYXsV5msdzW+JDwb6X/jrrSU5jBMHlBAffAGpNtyadEm5p2bNeTqpxS+L5SvLeVkHARpxD0sMtXMloRYyG5/uRjCHc6n0OCySR9Y8/FS/wIaxe2EAFAcEgN5nwMSw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPe9+0BZUtD/0aRSK2RoG13yuFMpVmWCIdgFGzMfoaU=;
 b=YL6x5bTy0s0E12RyvT0BIjukmcgZQlvinzeeclTIuWKbFIaW9DkPsQXrTxjsFyEX+rJY/hRKWV4aB5crJHDF2J3nXyOylil8WjBQb4qDI2+Jkxttvx4Z/TCT7DRbOJwUYUtG/fLapOcAUBqlt/gptNzGupJMH2Y6J6m6maV2fV9HLGXNVEfX8+seL1XJs7jBBdS4pZmoizqqdlLHkJgQuOR2n/HXwgx3HctYlMpet2jT+M8Oei7VxVLGupkPQF8S3JZGRoXgKfZh0CQa/IbQmx461bctoaVPju7Wx2SwA0aZ7m8OsPshZLS5ATHfqBCMw7XOCK32Rb55ZUsv7V6tRA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPe9+0BZUtD/0aRSK2RoG13yuFMpVmWCIdgFGzMfoaU=;
 b=cWmaI2WOmgnKKyyIQ2ZNJgAPOf4CVX2jUhdK+bVFgDLUPI0Y1s5gZGDm4dY+W4N7cbwaIJ+KHwCmL5LqJ9vYDCKBsvWM7yKLIrewOG1epiSZwfuUZeirM58t3ICel7Efe6+pVXsyqWIlm0g2GNu1rcB9bUsPXHNtk/hbVnmxRuA=
Received: from PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::10)
 by AM9PR08MB6212.eurprd08.prod.outlook.com (2603:10a6:20b:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:22 +0000
Received: from MI3PEPF00008554.eurprd05.prod.outlook.com
 (2603:10a6:102:348:cafe::27) by PA7P264CA0091.outlook.office365.com
 (2603:10a6:102:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008554.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0ELq5ZCqrRVtOmo6S02wWcbNV6HZWMMxcjKGSfPQcBqfhWrxGuaO29jaoJCf1NAuViltvr4Ztw0x72kuGmHsC4Hk+bs4EBarexXtgQ1ojdjLW1dXIXTyULT2lbHCAfoTdENWdSxKMkZ79gMaMPhzUHF4OY5lxOl8tCPuiDCuLrHHj9BbdZ7Z7g3KswzIOsenpIYKB2do9kJZgwaB0v5R2BvW3ba+tmreJViUBetgdHcajFIs493Irkwzd0TnJqiwp2rVdgDnIixGWVa5w479KcBcceFgtlu4oTC8ZShCrKg7Xj7mRaQRgM3oN/kj6l2Rzp6UF4cbqcCg/X/8h3qbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPe9+0BZUtD/0aRSK2RoG13yuFMpVmWCIdgFGzMfoaU=;
 b=pFCaA8VdBG1oDQvGlOTux6HgrcYdHoJz30YSmWIHMkIGOaP0MQe+jwmIPbwJzi4LSgfJ/+UVVo5ZvpI7LD+a1YvGXOWGaKna5uBaaCOQRWTmFCrYA4cAu1P+NUETmHPpqxYeFx4wLls9zU9F8ToR68yUUEsw/aaeP9vf3RWqG8xhJnuf+uf36Bq7jSNdTJSQGVOf29GSOcdKAdmeVHGieO1qAWh6qNkZoGwRf0wnqlds6cTwBaP4LU7MC2NHpPeZqFWWMUAzJMTYWnVcnquvLI4Jp1ch2BqiiBq6rP7SR6WNgGukZbC6OVFPyaerJMxIOke82wB9sYiIX0Ly/EsDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPe9+0BZUtD/0aRSK2RoG13yuFMpVmWCIdgFGzMfoaU=;
 b=cWmaI2WOmgnKKyyIQ2ZNJgAPOf4CVX2jUhdK+bVFgDLUPI0Y1s5gZGDm4dY+W4N7cbwaIJ+KHwCmL5LqJ9vYDCKBsvWM7yKLIrewOG1epiSZwfuUZeirM58t3ICel7Efe6+pVXsyqWIlm0g2GNu1rcB9bUsPXHNtk/hbVnmxRuA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:47 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:47 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 14/28] drm/panthor: Add AM_PARTITION_CONTROL support
Date: Tue, 10 Nov 2026 15:38:35 +0000
Message-ID: <20261110153907.3241978-15-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MI3PEPF00008554:EE_|AM9PR08MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cbc893-8bac-43ad-7791-08df3f4111d4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261022105027099003|261102123227099003|261026121527099003|261009220027099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261021123027099003|261009221227099003|261022075727099003|261009223027099003|261009223327099003|261009221727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: cGw1UHuelqHjXtxNNrSWyFgBCVjzU7I91GTq7CV8aMcjZaB97Lc9qHTbyVeR5uf4RF2LCA6NN5xCMnPU4KllAsCdSy+h9yd5DgvUTY8sJKMACe/8bKwloWwfLefFNOegA8egkqQSD14z5yQatxi/yOkitQojw5pQ5CU4h7mvNB6rXYdbXGQTQ7Qt1xFoV0nTnnykFp+Mdv177GmUSTWEAAT8pgImgzaUqeuXn2rhJWpIk3UBv7/LIkzY6f82gU2qEu5H6EmJFNDVQjTt6sJs1TCf9/lYjKmKqnjmA2N7bSU+1j64kt8+CnVi9G3IRpvtYcgjR7jZCBd048rBv9mge8FHN2pGtrfC4wMNclMwkSd2cZNKaEFvOkpOFcRlzFd0NWrOfueCXHn0aNoMsj9YI8ui9c3JEXb8b0T6PxWz0Bi4DnY64IAAjuIkhoe+2dEap74c51/DdngqLHyPLhVxOoFGOMRpW4Jw0gH+VPZT5JzMc+QmDbkPZktG7Uc+XZt1JHOOYgN6NxLC7biVsqCWzhvYYWlgmXRTlCCzJsGQyWDKJV7Wd2SHY4Uazmunc+F+gmRvYqiSFaolLehKOQDAFcjS4k5pOPiFgiCVFhVclaTrzdUYHxsj3MQrW4LKBktg
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(261009220027099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261021123027099003)(261009221227099003)(261022075727099003)(261009223027099003)(261009223327099003)(261009221727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZGux+VFeQgBKyRe0/CQR07pJQvI/j4MwdiJeDtLsKMz5jAIIVOKSJjLmWCQ0cHOi25eaR0UKM80RwasfR81/t6VHiczaulFa0G0Q6wA9yyLWZ9UfuOUy3mmjeqIeCPIhWIiKF1p3x9XlM4tyEB56IFoUNog7pMyjx2h6fLVjRDv2ImE9YGx/2UWYHzI3thkBqRCdg/NqEx0BPU7w9kCLFO0WbtFavp5GGHnWW0KxNl7jDH8Vii1Pkx1agM/e+JrGHUVZOWGJFG/D/pkwH698wZbcNwPMqjRu2uTjPSjTjBggEVW868EsGYDadrKKTOfDiaZEDJPRAfsI15V83+Kx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0773ea63-5968-44b0-9132-08df3f40fdbb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|23010399003|1800799024|82310400026|14060799003|36860700016|3023799007|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261009221227099003|261009223027099003|261009223327099003|261009221727099003|261009220027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261022113327099003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 89Qel6Q9tfeQKTXlAhQGy1/4lZC0r+bjf9q/G4CEetwecoTLNfuyqLcFbM45smIW+cR4G7NcIzY5NHalOPhcyG+g1mItL8ygDMipGYMUff4gMaJBvVsJEce691ZQu2qSPs4cwMR1KeRlyLamMu631Gr0YLF/zT34qG/r1nuCpZpGQ6wUMCpHzNnZC+0EefBTkiUYRpQigv5A0FeXE0hXbkZXvvQMCpUUZ04vxs4RYdXlRbNcbJxyh3AeefealNWHGKRFboCq6YvFb93FRtEx1lAOfRFwOIVAejw8dy+frr6KuVM1e8t67xo4FlAWE5TkVUAPDs2rDU2trkv1u3fNh/mpreF7gjwC0saw9tdZUzTWUQjMwvG5eZm8miXNmDqqKbCL4Lbg/AMDHTZQvAv/fPgLbSu8RV02a6y05XJaUIEMkvLNMKqscEFohjWM5ft2Wj8+dxC1OXru+M4+eWIXAQzyowc9P1RQK6fhc3iGbI76tfE/+Kx5fIdrvJh5hbdk23CXCJ19iAWEMjR6GDyKq1VR0FPSLT+IWmSs4dn6++HICErZ/cvqUWBqSg/owqBS1m5pmsRL22rYbW1OyxX5+Clzn6mX8VpxEiE45M6Vr8qolOzKfEb9bDABqivzFx/qgHi2Csa8k5WYO5TTJ5GmUBZ7Fy2goEg8C9frI6oIDzU=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(23010399003)(1800799024)(82310400026)(14060799003)(36860700016)(3023799007)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009221727099003)(261009220027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261022113327099003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sKoJWNN9L3zw4JcsyOIf3jQiJCu11IkKD5upN11sSc9jKK79poEB1bP2QSoEqkR8u2gATZnqdiC3BNT5t4crypej7OgZ4oj6uZhb+NccwhY01ueq07wBJHEd5IqhsXU4NDV5ttP2tUBfjOIBFzAhDwYaTy0Y+zufX72KkfjHM/f4yn5iRBENezBh9d1CRzuAidbcQyTZTg+bntm2aGxRT+pKMaqy0gWW99eJtc96hLPKDFNzAXNc//+Ph2lcsvqPEwg2AsfIWuklepga8rP660/I23Tm3UruG3/XH/PRSlBhgZphHPbYEjw+X+AmFV+fGFn8RqPyb2Va4VfM3+N07nmGE+S39kMJtRpalmkED4jAUqxm9TP+L+XEhz1g5UHI5qK3lgpwGDCR3gki7ysLX5Te0774mnqfM4ev0hgA/0IKBV3OpRT3ONE2ZBaOk4K9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:21.2420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cbc893-8bac-43ad-7791-08df3f4111d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6212
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

Mali v15 AM GPUs expose AM_PARTITION_CONTROL blocks to manage partition
access windows.

Add a Panthor arbitration platform driver and connect it to Kconfig and
the build system.

Get partition-control register ranges and interrupts from named
resources of the arbitration device. Use pcN names to identify
partition-control blocks.

Provide helpers to open, close and yield access windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Revert child node discovery changes from v1 for register and
  interrupts.
- Fixes the following issues raised by sashiko:
  - Use DEV_PM_OPS and MODULE_DEVICE_TABLE macros
  - Change %llx to %pa for res.start
  - Simplify and clean up runtime PM handling.
  - Relax read_poll_timeout due to longer timeouts
  - Extend pc->lock to state checks to serialize against state changes
    triggered by partition commands.
  - Remove implicit close during window_open.
  - CLOSE_WINDOW during termination only when runtime PM is available.
  - Add irq_lock to prevent MMIO access as a result of shared IRQ  while
    GPU is powered off.
  - Add check for allocation failure from devm_kasprintf.
- Link: https://lore.kernel.org/all/20260922205802.1AC3E1F000FF@smtp.kernel.org/
v1:
- Updated DT structure and accompanying parsing to handle child nodes
  instead of named platform resources.
- Add child device population/depopulation.
- Remove blocking waits on partition open, close and yield operations.
- Adds YIELD_IDLE helper.

 drivers/gpu/drm/panthor/Kconfig               |  10 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  13 +
 .../panthor/arbitration/panthor_arbitration.h |  27 ++
 .../arbitration/panthor_arbitration_drv.c     | 142 +++++++
 .../arbitration/panthor_partition_control.c   | 379 ++++++++++++++++++
 .../arbitration/panthor_partition_control.h   |  29 ++
 7 files changed, 601 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index e17c93035e8b7..04b11b933290e 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -30,3 +30,13 @@ config DRM_PANTHOR_SYSTEM
 	  AM GPUs. This block provides GPU-wide control outside the main GPU
 	  register window, including reset handling and management of shared
 	  clock and regulator resources.
+
+config DRM_PANTHOR_ARBITRATION
+	tristate "HW-assisted virtualization for Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  Enable support for the arbitration blocks found on Arm Mali 5th Gen
+	  AM GPUs. These blocks manage partition controls, resource groups and
+	  access-window scheduling, allowing multiple access windows to share
+	  GPU resources under hardware-assisted arbitration.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 488a5e03efbc4..5d4d0ae64952e 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -15,5 +15,6 @@ panthor-y := \
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
 obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
+obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += arbitration/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
new file mode 100644
index 0000000000000..b0b6b2e3edf8d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+# Copyright 2026 ARM Limited. All rights reserved.
+
+obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
+panthor_arbitration-y := \
+	panthor_arbitration_drv.o \
+	panthor_partition_control.o
+
+INCLUDES = \
+	-I$(src)/..
+
+ccflags-y += $(INCLUDES)
+subdir-ccflags-y += $(INCLUDES)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
new file mode 100644
index 0000000000000..fc3610aefae29
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_H__
+#define __PANTHOR_ARBITRATION_H__
+
+#include <linux/ioport.h>
+#include <linux/fwnode.h>
+
+struct device;
+struct panthor_partition_control;
+
+#define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_AW_COUNT			16
+
+/**
+ * struct panthor_arbitration - Arbitration device
+ */
+struct panthor_arbitration {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @pc: Pointer array to partition control data */
+	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
+};
+
+#endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
new file mode 100644
index 0000000000000..a27d24c3679fa
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_partition_control.h"
+
+#define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
+
+static int panthor_arbitration_runtime_suspend(struct device *dev)
+{
+	struct panthor_arbitration *adev = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = panthor_partition_control_suspend(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int panthor_arbitration_runtime_resume(struct device *dev)
+{
+	struct panthor_arbitration *adev = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = panthor_partition_control_resume(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int panthor_arbitration_probe(struct platform_device *pdev)
+{
+	struct panthor_arbitration *adev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (!pdev)
+		return -EINVAL;
+
+	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->dev = dev;
+
+	dev_set_drvdata(dev, adev);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto err_disable_pm;
+
+	ret = panthor_partition_control_init(adev);
+	if (ret)
+		goto err_term;
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_depopulate;
+
+	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_depopulate:
+	of_platform_depopulate(dev);
+
+err_term:
+	panthor_partition_control_term(adev);
+	pm_runtime_put_sync_suspend(dev);
+
+err_disable_pm:
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static void panthor_arbitration_remove(struct platform_device *pdev)
+{
+	struct panthor_arbitration *adev = platform_get_drvdata(pdev);
+	int ret;
+
+	if (!adev)
+		return;
+
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
+		dev_warn(adev->dev, "failed to resume during remove: %d", ret);
+
+	of_platform_depopulate(adev->dev);
+
+	pm_runtime_disable(adev->dev);
+
+	panthor_partition_control_term(adev);
+
+	if (ret >= 0)
+		pm_runtime_put_noidle(adev->dev);
+
+	pm_runtime_dont_use_autosuspend(adev->dev);
+	pm_runtime_set_suspended(adev->dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(panthor_arbitration_pm_ops,
+				 panthor_arbitration_runtime_suspend,
+				 panthor_arbitration_runtime_resume,
+				 NULL);
+
+static const struct of_device_id panthor_arbitration_of_match[] = {
+	{ .compatible = "arm,mali-gen5-am-arbitration" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, panthor_arbitration_of_match);
+
+static struct platform_driver panthor_arbitration_driver = {
+	.probe = panthor_arbitration_probe,
+	.remove = panthor_arbitration_remove,
+	.driver = {
+		.name = "panthor-arbitration",
+		.of_match_table = panthor_arbitration_of_match,
+		.pm = pm_ptr(&panthor_arbitration_pm_ops),
+	},
+};
+
+module_platform_driver(panthor_arbitration_driver);
+
+MODULE_AUTHOR("ARM Ltd.");
+MODULE_DESCRIPTION("Panthor HW-assisted virtualization Driver");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
new file mode 100644
index 0000000000000..330d0bf5fd375
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_device_io.h"
+#include "panthor_partition_control.h"
+
+#define AM_PART_IRQ_RAWSTAT			0x40
+#define AM_PART_IRQ_CLEAR			0x44
+#define AM_PART_IRQ_MASK			0x48
+#define AM_PART_IRQ_STATUS			0x4C
+#define   PART_RESET_DONE			BIT(3)
+#define   PART_INVALID_COMMAND			BIT(6)
+
+#define AM_PART_STATE				0x60
+#define   AM_PART_STATE_GET(x)			FIELD_GET(GENMASK(11, 8), x)
+#define     PART_STATE_RESET			0
+#define     PART_STATE_WINDOW_OPENING		1
+#define     PART_STATE_WINDOW_OPEN		7
+#define     PART_STATE_WINDOW_CLOSED		8
+#define   AM_PART_STATE_WINDOW_GET(x)		FIELD_GET(GENMASK(15, 12), x)
+
+#define AM_PART_COMMAND				0x100
+#define   AM_PART_SET_COMMAND(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define     PART_CMD_YIELD_IDLE			0x10
+#define     PART_CMD_YIELD_NOW			0x11
+#define     PART_CMD_CLOSE_WINDOW		0x20
+#define     PART_CMD_OPEN_WINDOW		0x21
+#define   AM_PART_SET_WINDOW(x)			FIELD_PREP(GENMASK(11, 8), x)
+
+#define AW_UNASSIGNED				-1
+
+#define PART_CONTROL_IRQ_MASK \
+	(PART_RESET_DONE | PART_INVALID_COMMAND)
+
+#define PART_REG_POLL_SLEEP_US			10
+#define PART_STATE_TRANSITION_TIMEOUT_US	5000000
+
+/**
+ * struct panthor_partition_control - Partition control data
+ */
+struct panthor_partition_control {
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
+	/** @lock: Proctects partition control state data */
+	spinlock_t lock;
+
+	/** @current_aw: currently open access window */
+	int current_aw;
+
+	/** @closing: synchronous closing of the partition */
+	bool closing;
+};
+
+static void partition_irq_suspend(struct panthor_partition_control *pc)
+{
+	scoped_guard(spinlock_irqsave, &pc->irq_lock) {
+		pc->irq_suspended = true;
+
+		if (!pm_runtime_status_suspended(pc->dev))
+			gpu_write(pc->iomem, AM_PART_IRQ_MASK, 0);
+	}
+	synchronize_irq(pc->irq);
+}
+
+static void partition_irq_resume(struct panthor_partition_control *pc)
+{
+	guard(spinlock_irqsave)(&pc->irq_lock);
+	pc->irq_suspended = false;
+	gpu_write(pc->iomem, AM_PART_IRQ_MASK, PART_CONTROL_IRQ_MASK);
+}
+
+static u32 partition_state_get(struct panthor_partition_control *pc)
+{
+	const u32 state = gpu_read(pc->iomem, AM_PART_STATE);
+
+	return AM_PART_STATE_GET(state);
+}
+
+static u8 partition_aw_get(struct panthor_partition_control *pc)
+{
+	const u32 state = gpu_read(pc->iomem, AM_PART_STATE);
+
+	return AM_PART_STATE_WINDOW_GET(state);
+}
+
+static int partition_state_wait(struct panthor_partition_control *pc, u32 state)
+{
+	u32 partition_state;
+
+	return read_poll_timeout(partition_state_get, partition_state,
+				 partition_state == state,
+				 PART_REG_POLL_SLEEP_US,
+				 PART_STATE_TRANSITION_TIMEOUT_US,
+				 false, pc);
+}
+
+static int yield_now(struct panthor_partition_control *pc)
+{
+	guard(spinlock_irqsave)(&pc->lock);
+
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 0;
+
+	if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN)
+		return -EAGAIN;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
+
+	return 0;
+}
+
+static int yield_idle(struct panthor_partition_control *pc)
+{
+	guard(spinlock_irqsave)(&pc->lock);
+
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 0;
+
+	if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN)
+		return -EAGAIN;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
+
+	return 0;
+}
+
+static int window_close(struct panthor_partition_control *pc)
+{
+	guard(spinlock_irqsave)(&pc->lock);
+
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 0;
+
+	if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN)
+		return -EAGAIN;
+
+	pc->closing = true;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
+
+	return 0;
+}
+
+static int window_open(struct panthor_partition_control *pc, u8 aw_id)
+{
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	guard(spinlock_irqsave)(&pc->lock);
+
+	if (partition_state_get(pc) == PART_STATE_WINDOW_OPEN) {
+		u8 cur_aw = partition_aw_get(pc);
+
+		if (cur_aw == aw_id)
+			return 0;
+
+		dev_warn(pc->dev,
+			 "%s: OPEN_WINDOW(%u): Already opened for aw=%u, state=%u. Closing...",
+			 pc->name, aw_id, cur_aw, partition_state_get(pc));
+
+		return -EBUSY;
+	}
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id));
+
+	pc->current_aw = aw_id;
+
+	return 0;
+}
+
+static void partition_handle_reset_done(struct panthor_partition_control *pc)
+{
+	scoped_guard(spinlock_irqsave, &pc->lock) {
+		pc->current_aw = AW_UNASSIGNED;
+
+		/* RESET_DONE from CLOSE_WINDOW */
+		if (pc->closing)
+			pc->closing = false;
+	}
+}
+
+static irqreturn_t partition_irq_raw_handler(int irq, void *data)
+{
+	struct panthor_partition_control *pc = data;
+	u32 status;
+
+	scoped_guard(spinlock_irqsave, &pc->irq_lock) {
+		if (pc->irq_suspended)
+			return IRQ_NONE;
+	}
+
+	status = gpu_read(pc->iomem, AM_PART_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & PART_RESET_DONE)
+		partition_handle_reset_done(pc);
+
+	if (status & PART_INVALID_COMMAND)
+		dev_warn(pc->dev, "%s: Invalid command", pc->name);
+
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+int panthor_partition_control_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		partition_irq_suspend(pc);
+	}
+
+	return 0;
+}
+
+int panthor_partition_control_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		partition_irq_resume(pc);
+	}
+
+	return 0;
+}
+
+void panthor_partition_control_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		partition_irq_suspend(pc);
+
+		if (!pm_runtime_status_suspended(pc->dev))
+			if (!WARN_ON(window_close(pc) < 0))
+				WARN_ON(partition_state_wait(pc, PART_STATE_RESET));
+	}
+}
+
+static int partition_control_init(struct panthor_arbitration *adev, int i)
+{
+	struct panthor_partition_control *pc;
+	struct device *dev = adev->dev;
+	struct irq_data *irqdata;
+	struct resource *res;
+	void __iomem *iomem;
+	u32 irq_flags = 0;
+	char *name;
+	int irq;
+	int ret;
+
+	if (adev->pc[i])
+		return dev_warn_probe(dev, -ENODEV,
+				      "partition %u already present", i);
+
+	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "pc%d", i);
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
+	pc->name = name;
+	pc->dev = dev;
+	pc->iomem = iomem;
+
+	spin_lock_init(&pc->irq_lock);
+	pc->irq_suspended = true;
+
+	spin_lock_init(&pc->lock);
+	pc->current_aw = AW_UNASSIGNED;
+
+	irq = platform_get_irq_byname(to_platform_device(dev), name);
+	if (irq < 0)
+		return irq;
+
+	pc->irq = irq;
+
+	irqdata = irq_get_irq_data(irq);
+	if (irqdata)
+		irq_flags = irqd_get_trigger_type(irqdata);
+
+	ret = devm_request_irq(
+		dev, irq, partition_irq_raw_handler, irq_flags | IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
+	if (ret)
+		return ret;
+
+	adev->pc[i] = pc;
+
+	partition_irq_resume(pc);
+
+	return 0;
+}
+
+int panthor_partition_control_init(struct panthor_arbitration *adev)
+{
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		int ret = partition_control_init(adev, i);
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
+
+int panthor_partition_control_open_window(struct panthor_partition_control *pc, u8 aw_id)
+{
+	return window_open(pc, aw_id);
+}
+
+int panthor_partition_control_close_window(struct panthor_partition_control *pc)
+{
+	return window_close(pc);
+}
+
+int panthor_partition_control_yield_now(struct panthor_partition_control *pc)
+{
+	return yield_now(pc);
+}
+
+int panthor_partition_control_yield_idle(struct panthor_partition_control *pc)
+{
+	return yield_idle(pc);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
new file mode 100644
index 0000000000000..9a688d7bbdb1f
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_PARTITION_CONTROL_H__
+#define __PANTHOR_PARTITION_CONTROL_H__
+
+#include <linux/types.h>
+
+struct device;
+struct panthor_arbitration;
+struct panthor_partition_control;
+
+int panthor_partition_control_init(struct panthor_arbitration *adev);
+
+void panthor_partition_control_term(struct panthor_arbitration *adev);
+
+int panthor_partition_control_suspend(struct panthor_arbitration *adev);
+
+int panthor_partition_control_resume(struct panthor_arbitration *adev);
+
+int panthor_partition_control_open_window(struct panthor_partition_control *pc, u8 aw_id);
+
+int panthor_partition_control_close_window(struct panthor_partition_control *pc);
+
+int panthor_partition_control_yield_now(struct panthor_partition_control *pc);
+
+int panthor_partition_control_yield_idle(struct panthor_partition_control *pc);
+
+#endif
-- 
2.43.0

