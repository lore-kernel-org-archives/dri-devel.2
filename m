Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A9606D753
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Tbe+6ZGV;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Tbe+6ZGV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B0B10F7CC;
	Tue, 10 Nov 2026 15:42:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013048.outbound.protection.outlook.com
 [52.101.83.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB4010F7C4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bRVyhtXLUIP1VEqBcqW1yUmGF4RU7GwPcnDGF9glutEMy3DLQM1kVfFNADfw0wLonubevC8eLKR3t4i6to7UJb+ZuNLLoapM8Ay2Fiz7QH/D2dbFDJ2VGxaanP5ZD+TG8+EUXq4Y9Pdx+YIyTuQT0R7u/lv/QjbeytqEptEZv95n7uKk+KEZFdcgM92tTl6PRpLWzCPzLAAc3yE56qyTDA36iXNOiHzIxrQeWVxfWRXFgq6s7BaQk70cP/8vNWJMuPOvKYcOWvp2tT+jrXPIQjplpwmEuTCNIRS3CQGWDHmi+OCrcCQMwFLFzrp8QQ4dX8DrxtmgMXfXL/dztJceBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUbGfwTN/BASertJHJsILMTXNCU1wEvDLnImF3t2n8I=;
 b=vPd+Lg9gxhkiGo2zKBfvpSujNaOzxLDPmP2YHqPnrucwkzQHQRQgk7AVLEYzgBDwLpO17kwbMYo3K1PR4dFWb/8Of40zjrbvPY7xTxpVLK8zvRCkI+bKqMG6YaDugB6SR4iUCu1fYtZX3Qmt57yRPDyO+sK98kmC74RT/MY/EHEc4ypT/oVbJV33WB9lFolHVL6dV7gK+ouKfpA1l6v8TgNzsTJKfIf047X2PPfJakvdFHvSmwDKx5E1GV9tncDvC1JVGv1rkyiFT0u9UQgIIX4Nlji9w68WHli/c+ilnDOthzhCXN/w2kMFDIxHIBkV7P3aBDUjK/AcWsO3edrAWQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbGfwTN/BASertJHJsILMTXNCU1wEvDLnImF3t2n8I=;
 b=Tbe+6ZGVNhUvElSV3aJIqsxVhfQcexXYwSkDI5b9L9cyFxULxUWDwwyddYjEaW4UwH7+IImdmux/IvZ7/ILFVMVL/rPeJB09RJrL5YpH30AycxtpYU9cBqWTBa91yCkEXPiwiDiy72tQPTczd2SfdeVbi4j7M7QtL9yWRkV2+XE=
Received: from OS6P279CA0038.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::11)
 by AS8PR08MB6408.eurprd08.prod.outlook.com (2603:10a6:20b:33a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:42:15 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:e10:32:cafe::2d) by OS6P279CA0038.outlook.office365.com
 (2603:10a6:e10:32::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:42:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVCP1hDk9c3aJf7UzdGulIBP6YKboOmtl3BL0FREo7eacV+fL/XizYDZwO08YDPy5NolHhf7vz+5icNUZRX5J6DJwnPth2dhnlZc2kk+IrjmFPjAzXuHFtljzIrgifpw0KoW7KZTSU+R9xom0ui5pvxSYFqdOqnKfTCWcfXpCW4xuTSoY3pCUsVMmzH8NMq+NLUdlEQ2g7Pfnng99ebaIHnVXxQxpy+oV285bd6mTDMO380Gs9fjjsDhxnEh04eNucqkoXuy1hwKg5wVsws6vnWDncJpTsc0SUpcs1qLydHF0rT7H49L7GrJ6tDgctWqw5v7tTnTPU/fgx9SsRFdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUbGfwTN/BASertJHJsILMTXNCU1wEvDLnImF3t2n8I=;
 b=rBhkLNVrEM7clUIoBNQeaEpUd+yFepYLImeUmJeiFoQ9A9YQ/7zP+oQrT5C2UxCS6875SUGh+fdmVrcBWsY/GMgt17YfkATSAY0BdeZpR9hyTpIDjqtRzJpVFMoZG/aNHec5sHWKupnPj43xz7vo6233K1buOSN1aUvlZRXhfhkJ7/RgkHeR++7rn8J2sEtYOb8sdtqBnq+zG3vuy0hu0ZMBjzNIfp6Z7LpBeJu5uRAxEhcbC7bur0DEPozu3a5zd0MglBU4E1YKLOw7knAIIMfnZehksCwcITgdYzQpWOusCJWj4eqxAR6Yb3DGN8fl/HvSpO0j3vXfBC/7bD3WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUbGfwTN/BASertJHJsILMTXNCU1wEvDLnImF3t2n8I=;
 b=Tbe+6ZGVNhUvElSV3aJIqsxVhfQcexXYwSkDI5b9L9cyFxULxUWDwwyddYjEaW4UwH7+IImdmux/IvZ7/ILFVMVL/rPeJB09RJrL5YpH30AycxtpYU9cBqWTBa91yCkEXPiwiDiy72tQPTczd2SfdeVbi4j7M7QtL9yWRkV2+XE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:40 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:40 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 27/28] drm/panthor: Prevent missed post-yield cleanup due
 to reset
Date: Tue, 10 Nov 2026 15:38:48 +0000
Message-ID: <20261110153907.3241978-28-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|CPH1EPF00000520:EE_|AS8PR08MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: c0902cc8-f571-46bd-9778-08df3f413162
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: k15zS1R2Vv9OZ5A/MozBHAD+NK8quzdgslr2HYa6mNP3KmUxUr30MFD8Etf9E81kkFGfFjlvq8JhKTOebuurVjYvjS+2/GffsEBSZ2cvNMx1DMZtowgAUz8TrE9XfZQcV32GVY1PyKBV6uPuP76WHUUdji1+YP+ygqMrspXBsLdVS4QlOPlcBJwd61fadacE6f9LyLwUCLUfC7DhDMAuPiNSbrAK2wAQy2rQ6Dv02u9/w2a8us8X/uuLBOp30Lkxuv0YZMfpaWG5A7dg82Ps0SBWRa9WOOF+1pLWodtbcKPQyPMDIfJcc0ol/rdNN9amXOJFSpcuIkxr5HRWo/+qW0Zn6+fx1LYxmopGmhj9yhBOOG7b9SWOeYOW70MXlZrVOil7QFqdOmTMM1Ox12F5GsX24YjFVzN67ZID6qwmUBuUdY5+crFCB2d7idLIJyO8rSsPlFPCTW08wzuy2Y+9IkMFa4h7q/dCk2TyqF9kWLAZco1sgLysv39jldpCVUmhRNCqkpYeNLKihFT/M/AljM6qu1ZXR+dggmfyp21DQyXfzdnSLq+Dgqz0aqR0nIfiLoLayo0Tb3vDdfg3CvUN40eiQZuIANrPEfktgiE0YPv70uo/hSuWzXvhBUoUhF4dkFM/Ewqi2b1fqSDjXCBJaxG/RjPT5hUT9ypHaHl7ae8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NPcKlTSbTtXH7QUO6LCvBFlU5Dm0OMCU/HwjuSuQqp7Jjye1bKuR98I85sxD4FTHVI0irGqu+dICEFsqBRn/0SqnozJokCjXWwm+NKTy0Z6kOYZse+EXGRYsiZSnqQN+rHBXjgW7IAeQPL2ILMeH2/3+g3kgsPXrbfLmpPxoiE2evasIbTfFQ9duiXAc5uVmD1zvpXUDy48l2AVZQKTgwVXehRQrhGXztM4ghPkuLtDXo7BhTd4fAfjcJ+G1ceyEm93cGe8fd9csivtxS6OSHrwm1KYOHryI2JWUrccBc38TnhlG9eemkph/VB135bwpPD92cRv1Tf7Bn2Kie6j62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d1e5b87-d1ee-45c1-84df-08df3f411cfd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|14060799003|376014|1800799024|35042699022|18002099003|22082099003|6133799003|11063799006|56012099006|261026140227099003|261102123227099003|261009223027099003|261026121527099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: MIFlDOMuFvIuqurCmCoko+arhYEfelCbE4K8koZeKDpYy20rsu+/OFU38NTq/oqDxlCYPU03Btl7fLupzmf9nZBq1akk1FriB/7iSORL1itVpb/wAJtULpsnwvs6K+MGD+M8FWKGX+uYxPQTGk11jf2JZXqWNoM+AW171rAiTKpaU24xBk9oFNhElfMHyBqHCKr9OdN6Q/rHbGaYZ3w+6fk7MkBTZSlTOCl9ANEJ/ASr0IBxhgfm88hWEP63Jo0bLruW3dSonFjvz3uMrs3kxotKzmIbI4T7QLBUuNUbBHCheUYS1SRKMjmIaEWFnjLmaGab41KFtF7qdNoksSEOmKXcL+w0KpZ0Of9hPmfgLNQc9hG0n+DQO9pAI7pgApqJzg+Q0Ck4Zm0CIxjpbMqUtynfheuHbgQCwqUXmGozEWV2+ZQ08sEJfHQ7Ybv8a8O8GBG2P4BLa1h5P1ow5G51PMqHign1Xe2P0Rr2E02dHwDf4ijw08EKk82dCIj26NY3FKDd5NQan6rlB0tYuuO+PJ3TOEH51r3Do+JOzk1qljzBKq3ELkQG5t0cYC3c1Iybd+ZEl9c76/XMnsyfjZzI0SIDoDn8N2dSFUjFcvaInQ/IbNxyyp5LIeBIzUWiryvyHAmF3aEKGdYvUWTk9FRvztBZNWCtt5MiJrazcvSRcsDWQ5oAmesKKDbhwa6tprWsr/hEAqi0/1dejN1FoVVoUQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(14060799003)(376014)(1800799024)(35042699022)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261009223027099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NC4DjLMqMOjjJQ96pz7dMZ6TrjEuQReLs4tAzad8Ts1bR7/BRoxONcD69g/4c2DrXxiGlajO1+aGubfAowenICEp0QJqHPbQSfVcVQZkfWPF5l2ACbYWY4kTJCWLnU9ywaUkrJj/mdbroUzAkZQGXoo0uT8TnuPr8llgjmohG/H0eZcUMBRHfbS7tGO7hfvrV9AujA38YtzT0ZLQFwZkGCiTFKHllhbWlQLHHXii/xyGdFoxxgq3T4U5G8it5jGYFi8WFoCRdCsVf2YYa66qLBiZA87bDlMg8MLVZUZIs9lNztbwpjfe/w/XFosUG03NkVIMi6h2q8tr5hjFKqCra4dEz+Z9GUFeiZmoNy6jW2Bwjt5qjK0FD8p0n9I6h2iFtrd9e7lZCa8aCaaABo40fLKvlpcxfHcs+JTMSRz79Id4W9XSEnMKxOjthhVCdxX7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:42:14.2234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0902cc8-f571-46bd-9778-08df3f413162
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6408
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

GPU resets can generate access-window events that trigger normal
post-yield cleanup. Firmware can also yield GPU access during reset.

Add a RESET_ACTIVE access-window state. Enter this state only from
GPU_GRANTED. Ignore window-open and window-close events while reset
is active. Use the hardware window status to check GPU access
during reset.

After reset, schedule post-yield cleanup if the hardware window
is closed.

Abort reset preparation when the access window is not GPU_GRANTED.
Suppress firmware restart errors when GPU access has been lost.

Clear pending PWR_IRQ_RESET_COMPLETED flags on resume to prevent
blocking future legitimate resets from executing.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Return state transition outcome from panthor_aw_pre_reset to allow
  reset worker to bail the reset early.
- Make unplug decision due to reset failure before drm_dev_exit()
- Make panthor_aw_has_gpu-access check HW window status if in
  RESET_ACTIVE state to allow waiters to bail during reset if WINDOW was
  closed.
- Defensively clear PWR_IRQ_RESET_COMPLETED on resume to prevent state
  de-sync.

 drivers/gpu/drm/panthor/panthor_aw.c     | 50 +++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_aw.h     |  7 ++++
 drivers/gpu/drm/panthor/panthor_device.c | 13 ++++++
 drivers/gpu/drm/panthor/panthor_pwr.c    |  7 ++++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index f344a2aa32979..f7fcf51c2c632 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -275,6 +275,9 @@ static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
 		return;
 
 	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_RESET_ACTIVE:
+		/* Ignore this WINDOW_CLOSED as part of reset operation. */
+		return;
 	case PANTHOR_AW_STATE_GPU_GRANTED:
 		panthor_aw_schedule_post_yield_work(aw);
 		break;
@@ -302,6 +305,9 @@ static void panthor_aw_handle_window_opened(struct panthor_aw *aw)
 		return;
 
 	switch (atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_RESET_ACTIVE:
+		/* Ignore this WINDOW_OPENED as part of reset operation. */
+		return;
 	case PANTHOR_AW_STATE_GPU_GRANTED:
 	case PANTHOR_AW_STATE_SUSPEND_PENDING:
 	case PANTHOR_AW_STATE_INIT:
@@ -388,6 +394,7 @@ static int panthor_aw_request(struct panthor_aw *aw)
 		switch (state) {
 		case PANTHOR_AW_STATE_GPU_GRANTED:
 			return 0;
+		case PANTHOR_AW_STATE_RESET_ACTIVE:
 		case PANTHOR_AW_STATE_SUSPEND_PENDING:
 			return -EAGAIN;
 		case PANTHOR_AW_STATE_INIT:
@@ -637,5 +644,46 @@ bool panthor_aw_has_gpu_access(struct panthor_device *ptdev)
 	if (!ptdev->aw)
 		return true;
 
-	return (atomic_read(&ptdev->aw->state) == PANTHOR_AW_STATE_GPU_GRANTED);
+	switch (atomic_read(&ptdev->aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+		return true;
+	case PANTHOR_AW_STATE_RESET_ACTIVE:
+		return panthor_aw_is_open(ptdev->aw);
+	default:
+		break;
+	}
+
+	return false;
+}
+
+int panthor_aw_pre_reset(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return 0;
+
+	guard(spinlock_irqsave)(&aw->lock);
+
+	if (!panthor_aw_state_try_set(ptdev->aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				      PANTHOR_AW_STATE_RESET_ACTIVE))
+		return -EAGAIN;
+
+	return 0;
+}
+
+void panthor_aw_post_reset(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	guard(spinlock_irqsave)(&aw->lock);
+
+	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_RESET_ACTIVE,
+				 PANTHOR_AW_STATE_GPU_GRANTED);
+
+	if (!panthor_aw_is_open(aw))
+		panthor_aw_schedule_post_yield_work(aw);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index 29b32f3d810fd..dde9c8e8742ff 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -24,6 +24,9 @@ enum panthor_aw_state {
 	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
 	PANTHOR_AW_STATE_GPU_GRANTED,
 
+	/** @PANTHOR_AW_STATE_RESET_ACTIVE: AW is being reset. */
+	PANTHOR_AW_STATE_RESET_ACTIVE,
+
 	/** @PANTHOR_AW_STATE_YIELDING: Stopped GPU access, pending close. */
 	PANTHOR_AW_STATE_YIELDING,
 
@@ -47,4 +50,8 @@ int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
 
 bool panthor_aw_has_gpu_access(struct panthor_device *ptdev);
 
+int panthor_aw_pre_reset(struct panthor_device *ptdev);
+
+void panthor_aw_post_reset(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index d1ef460577c99..d4a67277fe6fa 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -140,14 +140,27 @@ static void panthor_device_reset_work(struct work_struct *work)
 		return;
 
 	panthor_sched_pre_reset(ptdev);
+	if (panthor_aw_pre_reset(ptdev) == -EAGAIN) {
+		atomic_set(&ptdev->reset.pending, 0);
+		panthor_sched_post_reset(ptdev, false);
+		goto out_dev_exit;
+	}
 	panthor_fw_pre_reset(ptdev, true);
 	panthor_mmu_pre_reset(ptdev);
+
 	panthor_hw_soft_reset(ptdev);
+
 	panthor_hw_l2_power_on(ptdev);
 	panthor_mmu_post_reset(ptdev);
 	ret = panthor_fw_post_reset(ptdev);
+	if (ret && !panthor_aw_has_gpu_access(ptdev))
+		ret = 0;
+
+	panthor_aw_post_reset(ptdev);
 	atomic_set(&ptdev->reset.pending, 0);
 	panthor_sched_post_reset(ptdev, ret != 0);
+
+out_dev_exit:
 	drm_dev_exit(cookie);
 
 	if (ret) {
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 66a2c54b070dc..eef400c4bc6fb 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -113,6 +113,9 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 		if (reset_pending(ptdev)) {
 			drm_WARN(&ptdev->base, 1, "Reset already pending");
 		} else {
+			if (!panthor_aw_has_gpu_access(ptdev))
+				return 0;
+
 			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
 			gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
 			panthor_pwr_write_command(ptdev, reset_cmd, 0);
@@ -622,5 +625,9 @@ void panthor_pwr_resume(struct panthor_device *ptdev)
 	if (!ptdev->pwr)
 		return;
 
+	/* clear any pending resets on resume to prevent blocking future resets */
+	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock)
+		ptdev->pwr->pending_reqs &= ~PWR_IRQ_RESET_COMPLETED;
+
 	panthor_irq_resume(&ptdev->pwr->irq);
 }
-- 
2.43.0

