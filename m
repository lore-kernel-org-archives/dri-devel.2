Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E9606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oXXniPab;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oXXniPab
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21D310EA15;
	Thu, 26 Nov 2026 20:58:36 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E724C10E44B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:24 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qXDF9fNTnPhZSopy2WgufJw8VseiEss5yTaTyZN/c4AUUVH/za0Bz0qlfiFTISUptWwd1+B22xXKraodFmStRnlPgViuM6Xk6CtCNyr/T+oOMbkJxq/YetydpYc8xBtmHgJiX8c6fToWCU7FbuM0rVPzCjLRtUMDQlThAigfnla9fkB7mDxo6GRf7FZm67CQoWPdPgDqDrQcpeYINF1z/vRXKVTg5Mw9KK6Pt1mQy+LmIHGWbKrMS7s/oS1yW8GHjFsS4iXClNxlWuZNO3SGrht2xePFEKDkQgc9Cl/t8mARBN6fpI3qNno5y++F5ZvYtMzf3lpOkUCl3+t2CpSP/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFyDU3iVkG5tQK6PrhSYuREkoSfwc9YkjcBUhPenKQE=;
 b=s/YBrISG43uSMteIrYmnb5S0IwR/ucAj4YTk2MAnXy0TtWKHBtClVzrZpBxKCvoJ6ySjwws0ws2uCNIXBSAPkoNDDWR7yH4CbsiPuWbamLbDvkEpaT3xSJ4V3tocs4aCcrMRHiZZ0MyIR0GJFVLF/0T0EPEU/EUN14Tit/VW6lp/AhSbmxDOnFMBt52B1eWtZqT0gc9sjKf2gYwp+NijSExSOmheh3NKd+jdYWt45hiI+rqxHuWQGMpByAKpymA+ImNdzQ6nljdPDwSved6GAfFcBRtQ/f3jhGoxSt29CL42oIzAhT1nO4Gsg9PH5/bpiwkYMcSMZUf7TJFDZcZ88A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFyDU3iVkG5tQK6PrhSYuREkoSfwc9YkjcBUhPenKQE=;
 b=oXXniPabZ8X3SXqztPD/BhoHDMR0gI+8yVJFiMfhoRcN0NclZ87CNKXiyoKEC0YowYdhmdYGqwXN7BRHtiyp52hjQhC9ryd2ybZoA3yMLLumqghdFX5YV7uh6BAtJzxNhvity/O7/Rl3PqBaPZHsxMoLfGkbJT5ntyZUcmsraIU=
Received: from GVX0EPF0009E339.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::3db) by DBBPR08MB6106.eurprd08.prod.outlook.com
 (2603:10a6:10:202::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Thu, 26 Nov
 2026 20:58:18 +0000
Received: from WA1PEPF00009B38.eurprd05.prod.outlook.com (2603:10a6:1d8::115)
 by GVX0EPF0009E339.outlook.office365.com (2603:10a6:158:400::3db)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.639.13 via Frontend Transport; Thu, 26 Nov 2026 20:58:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B38.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 20:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk6zpYmXLU7b1/0w3F6uAHaMsSg1p1uFzm34c3Xn+IiO61L8vfMqT/bL10My4vhzTwnrFSqsRZB0XBgj+7kCuFp4gOkV/kSo0HjDiGYQeheEAX3pQ25dhSoPN1G9JS/WD6ZgAtrXzroOxsP/g/XSXN9FGUZmi+Z77Z+NC/t77p808nC1WX1ItLxuaNEGQrljd75EE6rLrzw0suVvDxqDoWp0Ba0TEpAEdOuwWP44zt4buopz6dNcZDYduArAkLHcxxi9kZYwM038b9kL3dFOXFKOXmKs5jxmdYiwD6vqAnxr4iCqKY0VZSPb88Ijix2d58nap7f8gYmgGUAy+M4jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFyDU3iVkG5tQK6PrhSYuREkoSfwc9YkjcBUhPenKQE=;
 b=mclOkwKMie3a7QCVT0GQarm3QLjKb6yXBsCeyFw+UEF+mOA8OZoPYPety2PGSjsOd1YPZzUjUALNdNMSvSmjBvS4Bwp5YbCUlXZzsNf4C8//JqQRu8N3loHojLEnpqs6A37WRsbKAq96lTvqtF98s7trkGZ3ow04f574BT2McyxxrqX/U4oj4j1jEEJgLCIJQX1YC5xRzUDqYu70Vx4Wy/9okTG2hfOHX0XOqRpftu7a57vWU0owK4886HlkauR4NlfbhrSVkjKiqVUy089cMTvhoFKrJ4leEYQFxtm2Fg6+b8ey0cDKhffNU1BSd/tVo5dlVAkNeE4RrPXmvSJayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFyDU3iVkG5tQK6PrhSYuREkoSfwc9YkjcBUhPenKQE=;
 b=oXXniPabZ8X3SXqztPD/BhoHDMR0gI+8yVJFiMfhoRcN0NclZ87CNKXiyoKEC0YowYdhmdYGqwXN7BRHtiyp52hjQhC9ryd2ybZoA3yMLLumqghdFX5YV7uh6BAtJzxNhvity/O7/Rl3PqBaPZHsxMoLfGkbJT5ntyZUcmsraIU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by MA9PR08MB045061.eurprd08.prod.outlook.com (2603:10a6:250:115::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 20:57:43 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 20:57:43 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Thu, 26 Nov 2026 20:57:37 +0000
Subject: [PATCH v8 1/3] drm/panthor: Add perf setup and session management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-panthor-performance-counters-v8-1-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
In-Reply-To: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, rust-for-linux@vger.kernel.org, 
 Mihail Atanassov <mihail.atanassov@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR1P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::19) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|MA9PR08MB045061:EE_|WA1PEPF00009B38:EE_|DBBPR08MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 267b3f5a-7c74-48b8-4064-08df4bfffe78
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261009223027099003|11063799006|22082099003|18002099003|5023799004|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: sHrD+PEipD0kNEzQsRWdNNixvGpW9GL7bycW2ejKpI6AkaFjEDZByEHdPNeH+QmPU73689HvcbQLqh1l9FIa49Z0v+Y7aNdHdAkfoz0md1LKfEe4lviNffu0UmeUQlZgx0d5yx5meBmeShjDgi91IYb/eDO4n/7MVvpoFk1o2tIGcruFqjYDN2LWJ2CD2UnbafREwP73JS9Isg0EJ+YKCUgzgFMCI3YqL8NeDD7PT2D71mpF7k0DG40I92aBRVbmfQ8yNbM8EMrSY+E4xps5UoVxntcgXnn5TUAvbfDd58TGhCT4rMZ0ZMAh3ziqPx9E9A3VqXtHNhowl6PY3UT6SPPFURBxoTTQBw1Kple8WGmC7m2773b8WUlI9G837ezbc4WuBjJ6Awn6wZ+boriDlhz3yRm102Kbr9R48NTZmrtAAivPovzoOkgMsPs81msaGfLFt/XiBKqZUNC17EfOBmsmWXZJMUgOO0l1W6gAiZ8eSLMrb631ixlMRmDX5TwkCNz6y9/eheHDWG3o5bMZ6WbdFrqRs28Z5GYsKjYNSOsbPTt9PH0Ub03eb0GqJHEhthy9PL8lXf/bQUumNBXPRdYdNZcMwJ7yrJNdbDUZXBRRGoOLuMzjIUJoRPsxmXcsUnwvcu8LXxZNN5pvAqiC2ewoZHLZKYlvjf6OGjGAvm5ixklrOvsUk64jEwPVxzHbUFoNq3mEtZ5rJxqU2j+tIw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009223027099003)(11063799006)(22082099003)(18002099003)(5023799004)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: MybquU3LrDSbAUdriqRIpUiZJ8COLkLH+oTVaVE42VX341VUiUBjWTL4R6Y5oF4cbxRK067UVRyND+hGPlmIs2NWCn3fUkwoJJnQKAWqUKXAoDDV3cpyea+gExxPRYLaXj6LbcWDddX5wgTK94vtnJNy2EaMCg/oagqs+O6ggqmnwDz/S49B5UwfD9/CxPcBxcqE1XQsBKbGhmppqoUIGuPh25KasGpQc8Rs+OrkzWTUWS0HKq6S2M0IBU3tmeAfhgx3HP4BLUhAIM1e9IX1Bxd4aSwyBnkQ3QmaBCSI3v7gpKqacZxfK7j83Te2ftZbHOP1JyCrkAaxuT/xJc9FyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB045061
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9414d363-e79b-48cc-4e9c-08df4bffea9e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|14060799003|35042699022|376014|7416014|82310400026|1800799024|921020|261026140227099003|10067099003|261022105027099003|261021135927099003|11063799006|5023799004|56012099006|261021121427099003|261026121527099003|261021123027099003|261028144727099003|261102123227099003|261022075727099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: yc5bxCuvtkr9n2tN+Hm2NQt57LG5RVY4wSi2ZyDwFyURJUI9wI3LgfoKuAbQ9SaV+FSF4iADu1WxUd+WAKlOg+Hq5y7TI0fU0X2G2fYEsoiKQnQgCzJpfWNxWMHA4pcSKZTp5uK6Xhetx0Au00yU34xoardpdc/i27uG4RTJbXrALSTgoLrZgShqbzgwF2K5puJffD7r+by0P7JNbvAf3mQuZdRFlGGROullGRekedXAguT1h2fxD6mhRl1SmnJjalAtWkXkMmiiN0Yhocq2rsRae8szOfEmxnkGQVu1WuebHSbcgbttuphp+fZrdciOM62ee1OpzhvzaJ7mb4D5Qwt5O/qofsy3eaDIdotayELrAgm4l/CxQXm2uYkTRKp4VhV5w+oYqhvXwAuBR80cpDFixi2wYYTNHYrgrAN7riVQQVjEtgc9irt+QswsAZqcubXHjev3FlLWleNhgjHFFWuqZRzMgkdNvAL45AKCNg/0FjnZJN/YpGp8diCBt+YEBi6CMCXqZds6HPE+XqnVpc49jH2CAwNeYkLQ0CYGFIujbJqHyC+b3QlUpYtPlgHVBgvRjyZcQfjUZrT36zigCbLvYa8CN+6Lz1NrTtrIzw5N6DzRlc3lEvFaQzOzGnty4SoUNPyPMPy9DPTFBhDbEOP+siTayCCkoONr9TTEtHynthy6DWpPW8ufTs8DcJsVYvaDL/xDBL60mrgc6hpsajDnNsSCoKyNex5wrXQLzuZvmUbKcDlBdpZO8aXpOIXY
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(14060799003)(35042699022)(376014)(7416014)(82310400026)(1800799024)(921020)(261026140227099003)(10067099003)(261022105027099003)(261021135927099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(261028144727099003)(261102123227099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6i+Ndyc+Ym0J9SvpUCQg59huEO4NeVoHTblSYxVqO60LYWB26Ns3perDH2NbJd9NjnZmBAtxLyx4Zy/m8AV89m1X17hO4Tu1zg16+9ZroTlTpwFgyweZFvDlaJXNgWm9gV9kY642tgMjNK/hCg3bNcpfpP7trX7XPgSRqpCzm2e8OeUljq3AVSVnEF9AHZx+RuhcGjxMgglWhhSCBSMrOlOdQjcv4lzXQ1OFYvUzTQjapSdCuHU8JdmK8MaGbte8hqp0kqak05o3FaL7P3NzksZSiXV9ltkpynemAm+WS8K+dic/An4OrkcqHeT+c28J4kQXaE2T4AlqH4vAQFC0Tei2/ogaCT65+El0o1wgL87zwFCkJFcexhVDy627fADKHv06AdqZPLKUiBVRzLZXSAmlOXh3Zz4/dIKF/b6NEap4LUdGDqspXbu2KpYWaD+W
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:58:16.5730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267b3f5a-7c74-48b8-4064-08df4bfffe78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6106
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

Add the panthor_perf system initialization and unplug code for
subsystem-level handling in subsequent patches, as well as user session
handling.

The user is permitted five primitive operations:
- SESSION_CREATE to create a new session with a static counter set and
  enable mask configuration.
- SESSION_START activates the sample and ensures that only new data is
  presented to the user.
- SESSION_SAMPLE requests a new sample if one is not outstanding, and
  signals completion via the eventfd.
- SESSION_STOP stops the session from the requesting any new samples
- SESSION_DESTROY releases the session handle back to the per-pfile
  pool and stops refcounting any of the user resources on the kernel
  side.

The current implementation allows combining the counter requests from
multiple user sessions, with each session using the operations above to
sample counters and manage their session's lifecycle independently.

Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/Makefile           |   1 +
 drivers/gpu/drm/panthor/panthor_device.c   |   7 +
 drivers/gpu/drm/panthor/panthor_device.h   |  12 +-
 drivers/gpu/drm/panthor/panthor_drv.c      |   9 +
 drivers/gpu/drm/panthor/panthor_fw.c       |   3 +
 drivers/gpu/drm/panthor/panthor_fw.h       |   1 +
 drivers/gpu/drm/panthor/panthor_gpu.c      |   5 +
 drivers/gpu/drm/panthor/panthor_gpu.h      |   2 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |   4 +
 drivers/gpu/drm/panthor/panthor_perf.c     | 897 +++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h     |  31 +
 include/uapi/drm/panthor_drm.h             | 263 +++++++++
 12 files changed, 1234 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index dd15d52a88bac..c65fff290720d 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -10,6 +10,7 @@ panthor-y := \
 	panthor_heap.o \
 	panthor_hw.o \
 	panthor_mmu.o \
+	panthor_perf.o \
 	panthor_pwr.o \
 	panthor_sched.o
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de3505..2877d47c67172 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -24,6 +24,7 @@
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_pwr.h"
 #include "panthor_sched.h"
 
@@ -287,6 +288,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_fw;
 
+	ret = panthor_perf_init(ptdev);
+	if (ret)
+		goto err_unplug_sched;
+
 	panthor_gem_init(ptdev);
 
 	/* Now that everything is initialized, we can enable the reset work. */
@@ -305,6 +310,8 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 err_disable_autosuspend:
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
+
+err_unplug_sched:
 	panthor_sched_unplug(ptdev);
 
 err_unplug_fw:
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..085254a60fc47 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -29,10 +29,11 @@ struct panthor_hw;
 struct panthor_job;
 struct panthor_mmu;
 struct panthor_fw;
-struct panthor_perfcnt;
 struct panthor_pwr;
+struct panthor_perf;
 struct panthor_vm;
 struct panthor_vm_pool;
+struct panthor_perf_pool;
 
 /**
  * struct panthor_soc_data - Panthor SoC Data
@@ -174,6 +175,9 @@ struct panthor_device {
 	/** @pwr: Power control management data. */
 	struct panthor_pwr *pwr;
 
+	/** @perf_info: Performance counter interface information. */
+	struct drm_panthor_perf_info perf_info;
+
 	/** @gpu: GPU management data. */
 	struct panthor_gpu *gpu;
 
@@ -320,6 +324,9 @@ struct panthor_device {
 		atomic_t recovery_needed;
 	} pm;
 
+	/** @perf: Performance counter management data. */
+	struct panthor_perf *perf;
+
 	/** @profile_mask: User-set profiling flags for job accounting. */
 	u32 profile_mask;
 
@@ -374,6 +381,9 @@ struct panthor_file {
 	/** @groups: Scheduling group pool attached to this file. */
 	struct panthor_group_pool *groups;
 
+	/** @sessions: Perf session pool attached to this file. */
+	struct panthor_perf_pool *sessions;
+
 	/** @stats: cycle and timestamp measures for job execution. */
 	struct panthor_gpu_usage stats;
 };
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef42..09cc3f699154a 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -36,6 +36,7 @@
 #include "panthor_gpu.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_sched.h"
 
 /**
@@ -1622,9 +1623,16 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
 	if (ret)
 		goto err_destroy_vm_pool;
 
+	ret = panthor_perf_pool_create(pfile);
+	if (ret)
+		goto err_destroy_group_pool;
+
 	file->driver_priv = pfile;
 	return 0;
 
+err_destroy_group_pool:
+	panthor_group_pool_destroy(pfile);
+
 err_destroy_vm_pool:
 	panthor_vm_pool_destroy(pfile);
 
@@ -1638,6 +1646,7 @@ panthor_postclose(struct drm_device *ddev, struct drm_file *file)
 {
 	struct panthor_file *pfile = file->driver_priv;
 
+	panthor_perf_pool_destroy(pfile);
 	panthor_group_pool_destroy(pfile);
 	panthor_vm_pool_destroy(pfile);
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13bf..c4be719ea05cb 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -25,6 +25,7 @@
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_sched.h"
 #include "panthor_trace.h"
 
@@ -1319,6 +1320,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 		panthor_fw_stop(ptdev);
 	}
 
+	panthor_perf_unplug(ptdev);
+
 	list_for_each_entry(section, &ptdev->fw->sections, node)
 		panthor_kernel_bo_destroy(section->mem);
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825c..534cbe79a4f1a 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -198,6 +198,7 @@ struct panthor_fw_global_control_iface {
 	u32 output_va;
 	u32 group_num;
 	u32 group_stride;
+#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
 	u32 perfcnt_size;
 	u32 instr_features;
 };
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index b8df5663f04e4..526cafaaef8e8 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -512,3 +512,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	drm_err(&ptdev->base, "Coherency not supported by the device");
 	return -ENOTSUPP;
 }
+
+u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev)
+{
+	return gpu_read(ptdev->gpu->iomem, GPU_PRFCNT_FEATURES);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index f615feb056094..46a6ca98cbb1b 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -60,4 +60,6 @@ u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev);
 
+u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 5340966caef37..4c80c9ee79127 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -23,6 +23,7 @@
 #define GPU_TILER_FEATURES				0xC
 #define GPU_MEM_FEATURES				0x10
 #define   GROUPS_L2_COHERENT				BIT(0)
+#define   GPU_MEM_FEATURES_L2_SLICES(x)			((((x) & GENMASK(11, 8)) >> 8) + 1)
 
 #define GPU_MMU_FEATURES				0x14
 #define  GPU_MMU_FEATURES_VA_BITS(x)			((x) & GENMASK(7, 0))
@@ -70,6 +71,9 @@
 #define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
+#define GPU_PRFCNT_FEATURES				0x68
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+
 #define GPU_TIMESTAMP_OFFSET				0x88
 #define GPU_CYCLE_COUNT					0x90
 #define GPU_TIMESTAMP					0x98
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
new file mode 100644
index 0000000000000..a4167bbc33adc
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2023 Collabora Ltd */
+/* Copyright 2025 Arm ltd. */
+
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_managed.h>
+#include <drm/panthor_drm.h>
+#include <drm/drm_print.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
+#include "panthor_perf.h"
+
+/**
+ * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
+ * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
+ * which indicates the same information.
+ */
+#define PANTHOR_PERF_COUNTERS_PER_BLOCK (64)
+
+/**
+ * PANTHOR_HW_COUNTER_SIZE - The size of a hardware counter in the FW ring buffer.
+ */
+#define PANTHOR_HW_COUNTER_SIZE (sizeof(u32))
+
+#define MAX_SESSIONS_PER_FILE 1
+
+#define SESSION_REGISTERED XA_MARK_1
+
+/**
+ * PANTHOR_PERF_EM_BITS - Number of bits in a user-facing enable mask. This must correspond
+ *                        to the maximum number of counters available for selection on the newest
+ *                        Mali GPUs (128 as of the Mali-Gx15).
+ */
+#define PANTHOR_PERF_EM_BITS (2 * BITS_PER_TYPE(u64))
+
+enum panthor_perf_session_state {
+	/** @PANTHOR_PERF_SESSION_STOPPED: The session cannot sample. It starts out stopped. */
+	PANTHOR_PERF_SESSION_STOPPED = 0,
+
+	/** @PANTHOR_PERF_SESSION_STARTING: The session has not yet been started and is in the
+	 *				    process of handling the clearing sample.
+	 */
+	PANTHOR_PERF_SESSION_STARTING,
+
+	/** @PANTHOR_PERF_SESSION_ACTIVE: The session is active and can be used for sampling. */
+	PANTHOR_PERF_SESSION_ACTIVE,
+
+	/** @PANTHOR_PERF_SESSION_STOPPING: The session is currently stopping. After emitting the
+	 *				    next sample, it will transition to inactive.
+	 */
+	PANTHOR_PERF_SESSION_STOPPING,
+
+	/** @PANTHOR_PERF_SESSION_DESTROY: The session is removed from the pool list and its
+	 *				   ID can be re-used.
+	 */
+	PANTHOR_PERF_SESSION_DESTROY,
+};
+
+struct panthor_perf_enable_masks {
+	/**
+	 * @mask: Array of bitmasks indicating the counters userspace requested, where
+	 *        one bit represents a single counter. Used to build the firmware configuration
+	 *        and ensure that userspace clients obtain only the counters they requested.
+	 */
+	DECLARE_BITMAP(mask[DRM_PANTHOR_PERF_BLOCK_MAX], PANTHOR_PERF_EM_BITS);
+};
+
+struct panthor_perf_counter_block {
+	struct drm_panthor_perf_block_header header;
+	u64 counters[];
+};
+
+struct panthor_perf_bo {
+	struct drm_gem_object *obj;
+	void *vaddr;
+};
+
+struct panthor_perf_session {
+	/** @state_lock: Protects session state, sample flags and pending requests. */
+	spinlock_t state_lock;
+
+	/** @state: The current state of the session. */
+	enum panthor_perf_session_state state;
+
+	/** @overflow: The session is affected by a FW ring buffer overflow. */
+	bool overflow;
+
+	/**  @insert_idx: The insert index in the user-visible buffer for the current session. */
+	u64 insert_idx;
+
+	/**
+	 * @accum_idx: Insert index of the populated slot. When this matches @insert_idx,
+	 *             accumulate into that slot; otherwise populate a new slot.
+	 */
+	u64 accum_idx;
+
+	/** @pending_sample: Whether this session has a sample requested on it. */
+	bool pending_sample;
+
+	/** @sample_flags: Accumulated @drm_panthor_perf_sample_flags for the pending sample. */
+	u32 sample_flags;
+
+	/** @sample_start_ns: Sample request time, obtained from a monotonic raw clock. */
+	u64 sample_start_ns;
+
+	/**
+	 * @user_data: Opaque handle passed in when starting a session, requesting a sample (for
+	 *             manual sampling sessions only) and when stopping a session. This handle
+	 *             allows the disambiguation of a sample in the ringbuffer.
+	 */
+	u64 user_data;
+
+	/**
+	 * @eventfd: Event file descriptor context used to signal userspace of a new sample
+	 *           being emitted.
+	 */
+	struct eventfd_ctx *eventfd;
+
+	/**
+	 * @enabled_counters: This session's requested counters. Note that these cannot change
+	 *                    for the lifetime of the session.
+	 */
+	struct panthor_perf_enable_masks enabled_counters;
+
+	/** @ringbuf_slots: Slots in the user-facing ringbuffer. */
+	size_t ringbuf_slots;
+
+	/** @ring_buf: BO and mapping for the userspace ringbuffer. */
+	struct panthor_perf_bo ring_buf;
+
+	/**
+	 * @control_buf: BO and mapping for the insert and extract indices.
+	 */
+	struct panthor_perf_bo control_buf;
+
+	/** @control: The mapped insert and extract indices. */
+	struct drm_panthor_perf_ringbuf_control *control;
+
+	/** @samples: The mapping of the @ring_buf into the kernel's VA space. */
+	u8 *samples;
+
+	/**
+	 * @sessions: The list node tracking all registered sessions.
+	 */
+	struct list_head sessions;
+
+	/**
+	 * @ref: Session reference count. The sample delivery to userspace is asynchronous, meaning
+	 *       the lifetime of the session must extend at least until the sample is exposed to
+	 *       userspace.
+	 */
+	struct kref ref;
+};
+
+struct panthor_perf {
+	/** @info: Pointer to the previously initialized perf info. */
+	struct drm_panthor_perf_info *info;
+
+	/** @op_lock: Serializes high-level session operations. */
+	struct mutex op_lock;
+};
+
+struct panthor_perf_pool {
+	/** @xa: Xarray used to manage session handles. */
+	struct xarray xa;
+
+	/** @next: Next handle to allocate. */
+	u32 next;
+};
+
+static size_t get_annotated_block_size(size_t counters_per_block)
+{
+	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
+}
+
+static size_t session_get_sample_size(const struct drm_panthor_perf_info *const info)
+{
+	const size_t block_size = get_annotated_block_size(info->counters_per_block);
+	const size_t block_nr = info->cshw_blocks + info->fw_blocks +
+		info->tiler_blocks + info->memsys_blocks + info->shader_blocks;
+
+	return info->sample_header_size + (block_size * block_nr);
+}
+
+static void panthor_perf_info_init(struct panthor_device *const ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+		perf_info->counters_per_block = PANTHOR_PERF_COUNTERS_PER_BLOCK;
+	} else {
+		u32 features = panthor_gpu_get_prfcnt_features(ptdev);
+
+		perf_info->counters_per_block = PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(features) /
+			PANTHOR_HW_COUNTER_SIZE;
+	}
+
+	perf_info->sample_header_size = sizeof(struct drm_panthor_perf_sample_header);
+	perf_info->block_header_size = sizeof(struct drm_panthor_perf_block_header);
+
+	if (GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size))
+		perf_info->fw_blocks = 1;
+
+	perf_info->cshw_blocks = 1;
+	perf_info->tiler_blocks = 1;
+	perf_info->memsys_blocks = GPU_MEM_FEATURES_L2_SLICES(ptdev->gpu_info.mem_features);
+	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
+
+	perf_info->sample_size = session_get_sample_size(perf_info);
+}
+
+static void
+panthor_perf_init_em(struct panthor_perf_session *session,
+		     struct drm_panthor_perf_session_create *const create_args)
+{
+	bitmap_from_arr64(session->enabled_counters.mask[DRM_PANTHOR_PERF_BLOCK_FW],
+			  create_args->fw_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(session->enabled_counters.mask[DRM_PANTHOR_PERF_BLOCK_CSHW],
+			  create_args->cshw_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(session->enabled_counters.mask[DRM_PANTHOR_PERF_BLOCK_TILER],
+			  create_args->tiler_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(session->enabled_counters.mask[DRM_PANTHOR_PERF_BLOCK_MEMSYS],
+			  create_args->memsys_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(session->enabled_counters.mask[DRM_PANTHOR_PERF_BLOCK_SHADER],
+			  create_args->shader_enable_mask, PANTHOR_PERF_EM_BITS);
+}
+
+static int
+panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t min_size,
+		    struct panthor_perf_bo *bo)
+{
+	struct drm_device *ddev = file->minor->dev;
+	struct drm_gem_object *obj;
+	struct iosys_map map;
+	int ret;
+
+	if (WARN_ON_ONCE(!bo))
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, handle);
+	if (!obj) {
+		drm_err(ddev, "Could not find handle %d!\n", handle);
+		return -EINVAL;
+	}
+
+	if (obj->size < min_size) {
+		drm_err(ddev,
+			"Perf BO expected min size %lu, passed BO with size %lu\n",
+			min_size, obj->size);
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	ret = drm_gem_vmap(obj, &map);
+	if (ret)
+		goto err_put;
+
+	bo->obj = obj;
+	bo->vaddr = map.vaddr;
+
+	return 0;
+
+err_put:
+	drm_gem_object_put(obj);
+	return ret;
+}
+
+static void panthor_perf_bo_put(struct panthor_perf_bo *bo)
+{
+	if (!bo->obj)
+		return;
+
+	if (bo->vaddr) {
+		struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->vaddr);
+
+		drm_gem_vunmap(bo->obj, &map);
+	}
+
+	drm_gem_object_put(bo->obj);
+
+	memset(bo, 0, sizeof(*bo));
+}
+
+static void session_free(struct kref *ref)
+{
+	struct panthor_perf_session *session = container_of(ref, typeof(*session), ref);
+
+	panthor_perf_bo_put(&session->ring_buf);
+	panthor_perf_bo_put(&session->control_buf);
+
+	eventfd_ctx_put(session->eventfd);
+
+	kfree(session);
+}
+
+static struct panthor_perf_session *
+session_get(struct panthor_perf_session *session)
+{
+	if (session)
+		kref_get(&session->ref);
+
+	return session;
+}
+
+static void session_put(struct panthor_perf_session *session)
+{
+	if (!IS_ERR_OR_NULL(session))
+		kref_put(&session->ref, session_free);
+}
+
+DEFINE_FREE(session_put, struct panthor_perf_session *, session_put(_T));
+
+/**
+ * session_from_handle - Find a session associated with the pool and session_handle.
+ *
+ * @pool: Per-file pool.
+ * @handle: Session handle.
+ *
+ * The reference count of a valid session is increased to ensure it does not disappear
+ * in the window between the XA lock being dropped and the internal session functions
+ * being called.
+ *
+ * Return: valid session pointer or NULL.
+ */
+static struct panthor_perf_session *
+session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
+{
+	struct panthor_perf_session *session = NULL;
+
+	xa_lock(&pool->xa);
+	if (xa_get_mark(&pool->xa, handle, SESSION_REGISTERED))
+		session = session_get(xa_load(&pool->xa, handle));
+	xa_unlock(&pool->xa);
+
+	return session;
+}
+
+#define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
+	static bool session_is_## name(struct panthor_perf_session *session) \
+	{								     \
+		lockdep_assert_held(&session->state_lock);		     \
+									     \
+		return session->state == (_state);			    \
+	}
+
+DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
+DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
+DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
+DEFINE_SESSION_STATE_CHECK(destroy, PANTHOR_PERF_SESSION_DESTROY);
+
+static bool session_has_overflow(struct panthor_perf_session *session)
+{
+	lockdep_assert_held(&session->state_lock);
+
+	return session->overflow;
+}
+
+static void session_set_state(struct panthor_perf_session *session,
+			      enum panthor_perf_session_state state)
+{
+	lockdep_assert_held(&session->state_lock);
+
+	session->state = state;
+}
+
+static u64 session_read_extract_idx(struct panthor_perf_session *session)
+{
+	/* Userspace will update their own extract index to indicate that a sample is consumed
+	 * from the ringbuffer, and we must ensure we read the latest value.
+	 */
+	return smp_load_acquire(&session->control->extract_idx);
+}
+
+static bool session_has_space(struct panthor_perf_session *session, u32 needed)
+{
+	const u64 insert = session->insert_idx;
+	const u64 extract = session_read_extract_idx(session);
+
+	return needed <= session->ringbuf_slots &&
+	       insert - extract <= session->ringbuf_slots - needed;
+}
+
+/**
+ * panthor_perf_init - Initialize the performance counter subsystem.
+ * @ptdev: Panthor device
+ *
+ * The performance counters require the FW interface to be available to setup the
+ * sampling ringbuffers, so this must be called only after FW is initialized.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_init(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf;
+	int ret;
+
+	if (!ptdev)
+		return -EINVAL;
+
+	panthor_perf_info_init(ptdev);
+
+	perf = drmm_kzalloc(&ptdev->base, sizeof(*perf), GFP_KERNEL);
+	if (!perf)
+		return -ENOMEM;
+
+	ret = drmm_mutex_init(&ptdev->base, &perf->op_lock);
+	if (ret)
+		return ret;
+
+	drm_info(&ptdev->base, "Performance counter subsystem initialized");
+
+	perf->info = &ptdev->perf_info;
+	ptdev->perf = perf;
+
+	return ret;
+}
+
+/**
+ * panthor_perf_session_create - Create a user-visible session.
+ *
+ * @file: DRM file associated with the request.
+ * @create_args: Creation arguments passed in via ioctl.
+ * @sid: Session identifier output.
+ *
+ * Creates a new session associated with the session ID returned. When initialized, the
+ * session must explicitly request sampling to start with a successive call to PERF_SESSION_START.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_create(struct drm_file *file,
+				struct drm_panthor_perf_session_create *create_args,
+				unsigned long *sid)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_device *ptdev = pfile->ptdev;
+	struct panthor_perf_bo ringbuffer = {}, control = {};
+	const size_t slots = create_args->sample_slots;
+	struct panthor_perf_pool *pool = pfile->sessions;
+	struct panthor_perf_session *session;
+	size_t user_sample_size;
+	u32 session_id;
+	int ret;
+
+	if (!ptdev->perf)
+		return -EOPNOTSUPP;
+
+	if (!pool)
+		return -EINVAL;
+
+	if (!perfmon_capable())
+		return -EACCES;
+
+	if (create_args->block_set > DRM_PANTHOR_PERF_SET_TERTIARY)
+		return -EINVAL;
+
+	if (slots < 2 || !is_power_of_2(slots))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)ptdev->perf_info.sample_size, slots, &user_sample_size))
+		return -EOVERFLOW;
+
+	ret = xa_alloc_cyclic(&pool->xa, &session_id, NULL, XA_LIMIT(0, MAX_SESSIONS_PER_FILE - 1),
+			      &pool->next, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	session = kzalloc_obj(*session);
+	if (!session) {
+		ret = -ENOMEM;
+		goto cleanup_session_id;
+	}
+
+	ret = panthor_perf_bo_get(file, create_args->ringbuf_handle,
+				  user_sample_size, &ringbuffer);
+	if (ret)
+		goto cleanup_session;
+
+	ret = panthor_perf_bo_get(file, create_args->control_handle,
+				  sizeof(struct drm_panthor_perf_ringbuf_control),
+				  &control);
+	if (ret)
+		goto cleanup_ringbuf;
+
+	session->eventfd = eventfd_ctx_fdget(create_args->fd);
+	if (IS_ERR(session->eventfd)) {
+		drm_err(&ptdev->base, "Invalid eventfd %d!\n", create_args->fd);
+		ret = PTR_ERR_OR_ZERO(session->eventfd) ?: -EINVAL;
+		goto cleanup_control;
+	}
+
+	kref_init(&session->ref);
+	INIT_LIST_HEAD(&session->sessions);
+	spin_lock_init(&session->state_lock);
+	session->control = control.vaddr;
+	*session->control = (struct drm_panthor_perf_ringbuf_control) { 0 };
+	session->samples = ringbuffer.vaddr;
+	panthor_perf_init_em(session, create_args);
+	session->ring_buf = ringbuffer;
+	session->ringbuf_slots = slots;
+	session->control_buf = control;
+	session->accum_idx = U64_MAX;
+
+	xa_lock(&pool->xa);
+	__xa_store(&pool->xa, session_id, session, GFP_NOWAIT);
+	__xa_set_mark(&pool->xa, session_id, SESSION_REGISTERED);
+	xa_unlock(&pool->xa);
+
+	*sid = session_id;
+	return 0;
+
+cleanup_control:
+	panthor_perf_bo_put(&control);
+
+cleanup_ringbuf:
+	panthor_perf_bo_put(&ringbuffer);
+
+cleanup_session:
+	kfree(session);
+
+cleanup_session_id:
+	xa_release(&pool->xa, session_id);
+
+	return ret;
+}
+
+/**
+ * session_try_stop - Transition the session to the STOPPING state.
+ *
+ * @session: Session being stopped.
+ * @user_data: User data to set if the STOPPING state is successfully set.
+ *
+ * Only sessions in a stable ACTIVE state with no pending samples and at least one slot in the user
+ * facing ring buffer can be transition to the transitional STOPPING state. The session gets
+ * transitioned from STOPPING to STOPPED by the worker after emitting a final sample.
+ *
+ * Return:
+ *  - 0 to request a new sample and wait,
+ *  - 1 to skip the re-request and go directly to wait
+ *  - negative error code on invalid transitions or state
+ */
+static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	if (session_is_starting(session))
+		return -EBUSY;
+
+	if (session_is_stopping(session))
+		return 1;
+
+	if (!session_is_active(session))
+		return 0;
+
+	if (session->pending_sample)
+		return -EBUSY;
+
+	if (!session_has_space(session, 1))
+		return -EBUSY;
+
+	session_set_state(session, PANTHOR_PERF_SESSION_STOPPING);
+	session->sample_start_ns = ktime_get_raw_ns();
+	session->user_data = user_data;
+
+	return 1;
+}
+
+static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *session,
+			u64 user_data)
+{
+	int ret;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = session_try_stop(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+/**
+ * session_try_start - Transition the session to the STARTING state.
+ *
+ * @session: Session being started.
+ * @user_data: User data to set if the STARTING state is successfully set.
+ *
+ * Only sessions in a stable STOPPED state and at least two slots in the ring buffer can transition
+ * to ACTIVE. Trying to transition an ACTIVE session to STARTING is considered a no-op. STARTING
+ * gets transitioned to ACTIVE via the worker after a clearing sample.
+ *
+ * Return:
+ *  - 0 to request a new sample and wait,
+ *  - 1 to skip the re-request and go directly to wait
+ *  - negative error code on invalid transitions or state
+ */
+static int session_try_start(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	if (session_is_destroy(session))
+		return -EBADF;
+
+	if (session_is_active(session))
+		return 0;
+
+	if (session_is_stopping(session))
+		return -EBUSY;
+
+	if (session_is_starting(session))
+		return 1;
+
+	if (!session_has_space(session, 2))
+		return -ENOSPC;
+
+	session_set_state(session, PANTHOR_PERF_SESSION_STARTING);
+	session->accum_idx = session->insert_idx - 1;
+	session->sample_flags = 0;
+	session->pending_sample = false;
+	session->overflow = false;
+	session->sample_start_ns = ktime_get_raw_ns();
+	session->user_data = user_data;
+
+	return 1;
+}
+
+static int session_start(struct panthor_perf *perf, struct panthor_perf_session *session,
+			 u64 user_data)
+{
+	int ret;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = session_try_start(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+/**
+ * session_try_sample - Request a manual sample for an ACTIVE session.
+ *
+ * @session: Session requesting a sample.
+ * @user_data: User data to set if the sample request is successful.
+ *
+ * Only sessions in a stable ACTIVE state can request manual samples. Sessions with an overflow
+ * flag will have experienced discontinuities in the counter collection and should instead
+ * stop the session and restart sampling.
+ *
+ * Return:
+ *  - 0 to request a new sample and wait,
+ *  - 1 to skip the re-request and go directly to wait
+ *  - negative error code on invalid transitions or state
+ */
+static int session_try_sample(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	if (!session_is_active(session))
+		return -EINVAL;
+
+	if (session_is_stopping(session))
+		return -EBUSY;
+
+	if (session_has_overflow(session))
+		return -EACCES;
+
+	if (session->pending_sample)
+		return -EBUSY;
+
+	/*
+	 * Must have at least two slots remaining in the ringbuffer to sample: one for
+	 * the current sample, and one for a stop sample, since a stop command should
+	 * always be acknowledged by taking a final sample and stopping the session.
+	 */
+	if (!session_has_space(session, 2))
+		return -ENOSPC;
+
+	session->user_data = user_data;
+	session->sample_start_ns = ktime_get_raw_ns();
+	session->pending_sample = true;
+
+	return 1;
+}
+
+static int session_sample(struct panthor_perf *perf, struct panthor_perf_session *session,
+			  u64 user_data)
+{
+	int ret;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = session_try_sample(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+static int session_try_destroy(struct panthor_perf_session *session)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	if (session_is_active(session))
+		return -EINVAL;
+
+	if (session_is_starting(session) || session_is_stopping(session))
+		return -EBUSY;
+
+	session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
+
+	return 0;
+}
+
+/**
+ * panthor_perf_session_destroy - Destroy the session associated with @handle.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier.
+ *
+ * Only stopped sessions can be destroyed. Other session states return an error.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
+{
+	struct panthor_perf_session *session __free(session_put) = NULL;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+	struct panthor_perf_pool *pool = pfile->sessions;
+	int ret = -EINVAL;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	session = session_from_handle(pool, handle);
+	if (!session)
+		return -EINVAL;
+
+	xa_lock(&pool->xa);
+	if (xa_load(&pool->xa, handle) == session) {
+		ret = session_try_destroy(session);
+		if (!ret)
+			__xa_erase(&pool->xa, handle);
+	}
+	xa_unlock(&pool->xa);
+	if (ret)
+		return ret;
+
+	session_put(session);
+
+	return 0;
+}
+
+/**
+ * panthor_perf_session_start - Start sampling on a stopped session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: Opaque value passed in from userspace.
+ *
+ * A session counts as stopped when it is created or when it is explicitly stopped after being
+ * started. Starting an active session is treated as a no-op.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data)
+{
+	struct panthor_perf_session *session __free(session_put) = NULL;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	return session_start(perf, session, user_data);
+}
+
+/**
+ * panthor_perf_session_stop - Stop sampling on an active session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: An opaque value passed in from userspace.
+ *
+ * A session counts as active when it has been explicitly started via the PERF_SESSION_START
+ * ioctl. Stopping a stopped session is treated as a no-op.
+ *
+ * To ensure data is not lost when sampling is stopping, there must always be at least one slot
+ * available for the final automatic sample, and the stop command will be rejected if there is not.
+ *
+ * The @user_data will always be associated with the final sample.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int handle, u64 user_data)
+{
+	struct panthor_perf_session *session __free(session_put) = NULL;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	return session_stop(perf, session, user_data);
+}
+
+/**
+ * panthor_perf_session_sample - Request a sample on a manual sampling session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: An opaque value passed in from userspace.
+ *
+ * Only an active manual sampler is permitted to request samples directly. Failing to meet either
+ * of these conditions will cause the sampling request to be rejected. Requesting a manual sample
+ * with a full ringbuffer will see the request being rejected.
+ *
+ * The @user_data will always be unambiguously associated one-to-one with the resultant sample.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user_data)
+{
+	struct panthor_perf_session *session __free(session_put) = NULL;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	return session_sample(perf, session, user_data);
+}
+
+/**
+ * panthor_perf_unplug - Terminate the performance counter subsystem.
+ * @ptdev: Panthor device.
+ *
+ * Release the performance counter hardware resources. The control structure is
+ * released with the DRM device.
+ */
+void panthor_perf_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+
+	if (!perf)
+		return;
+
+	ptdev->perf = NULL;
+}
+
+int panthor_perf_pool_create(struct panthor_file *pfile)
+{
+	struct panthor_perf_pool *pool;
+
+	pool = kzalloc_obj(*pool);
+	if (!pool)
+		return -ENOMEM;
+
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	pfile->sessions = pool;
+
+	return 0;
+}
+
+void panthor_perf_pool_destroy(struct panthor_file *pfile)
+{
+	struct panthor_perf_pool *pool = pfile->sessions;
+	struct panthor_perf_session *session;
+	unsigned long handle;
+
+	xa_for_each_marked(&pool->xa, handle, session, SESSION_REGISTERED) {
+		scoped_guard(spinlock_irqsave, &session->state_lock)
+			session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
+		xa_erase(&pool->xa, handle);
+		session_put(session);
+	}
+
+	xa_destroy(&pool->xa);
+	kfree(pool);
+
+	pfile->sessions = NULL;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
new file mode 100644
index 0000000000000..b5da4270e5061
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2025 Collabora Ltd */
+/* Copyright 2025 Arm ltd. */
+
+#ifndef __PANTHOR_PERF_H__
+#define __PANTHOR_PERF_H__
+
+#include <linux/types.h>
+
+struct drm_file;
+struct drm_panthor_perf_session_create;
+struct panthor_device;
+struct panthor_file;
+struct panthor_perf;
+struct panthor_perf_pool;
+
+int panthor_perf_pool_create(struct panthor_file *pfile);
+void panthor_perf_pool_destroy(struct panthor_file *pfile);
+
+int panthor_perf_init(struct panthor_device *ptdev);
+void panthor_perf_unplug(struct panthor_device *ptdev);
+
+int panthor_perf_session_create(struct drm_file *file,
+				struct drm_panthor_perf_session_create *setup_args,
+				unsigned long *sid);
+int panthor_perf_session_destroy(struct panthor_file *pfile, unsigned int handle);
+int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data);
+int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int sid, u64 user_data);
+int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle, u64 user_data);
+
+#endif /* __PANTHOR_PERF_H__ */
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..dfa852aa3690d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -517,6 +517,93 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * struct drm_panthor_perf_info - Performance counter interface information
+ *
+ * Structure grouping all queryable information relating to the performance counter
+ * interfaces.
+ */
+struct drm_panthor_perf_info {
+	/**
+	 * @counters_per_block: The number of 8-byte counters available in a block.
+	 */
+	__u32 counters_per_block;
+
+	/**
+	 * @sample_header_size: The size of the header struct available at the beginning
+	 * of every sample.
+	 */
+	__u32 sample_header_size;
+
+	/**
+	 * @block_header_size: The size of the header struct inline with the counters for a
+	 * single block.
+	 */
+	__u32 block_header_size;
+
+	/**
+	 * @sample_size: The size of a fully annotated sample, starting with a sample header
+	 *               of size @sample_header_size bytes, and all available blocks for the current
+	 *               configuration, each comprised of @counters_per_block 64-bit counters and
+	 *               a block header of @block_header_size bytes.
+	 *
+	 *               The user must use this field to allocate size for the ring buffer. In
+	 *               the case of new blocks being added, an old userspace can always use
+	 *               this field and ignore any blocks it does not know about.
+	 */
+	__u32 sample_size;
+
+	/** @fw_blocks: Number of FW blocks available. */
+	__u32 fw_blocks;
+
+	/** @cshw_blocks: Number of CSHW blocks available. */
+	__u32 cshw_blocks;
+
+	/** @tiler_blocks: Number of tiler blocks available. */
+	__u32 tiler_blocks;
+
+	/** @memsys_blocks: Number of memsys blocks available. */
+	__u32 memsys_blocks;
+
+	/** @shader_blocks: Number of shader core blocks available. */
+	__u32 shader_blocks;
+
+	/** @pad1: MBZ. */
+	__u32 pad1;
+};
+
+/**
+ * enum drm_panthor_perf_block_type - Performance counter supported block types.
+ */
+enum drm_panthor_perf_block_type {
+	/** @DRM_PANTHOR_PERF_BLOCK_METADATA: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_METADATA = 0,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_FW: The FW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_FW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_CSHW: The CSHW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_CSHW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_TILER: The tiler counter block. */
+	DRM_PANTHOR_PERF_BLOCK_TILER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_MEMSYS: A memsys counter block. */
+	DRM_PANTHOR_PERF_BLOCK_MEMSYS,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_SHADER: A shader core counter block. */
+	DRM_PANTHOR_PERF_BLOCK_SHADER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_FIRST: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_FIRST = DRM_PANTHOR_PERF_BLOCK_FW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_LAST: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_LAST = DRM_PANTHOR_PERF_BLOCK_SHADER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_MAX: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_MAX = DRM_PANTHOR_PERF_BLOCK_LAST + 1,
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
@@ -1270,6 +1357,182 @@ struct drm_panthor_bo_query_info {
 	__u32 pad;
 };
 
+/**
+ * struct drm_panthor_perf_block_header - Header present before every block in the
+ * sample ringbuffer.
+ */
+struct drm_panthor_perf_block_header {
+	/** @block_type: Type of the block. */
+	__u8 block_type;
+
+	/** @block_idx: Block index. */
+	__u8 block_idx;
+
+	/** @pad0: MBZ. */
+	__u8 pad0[6];
+};
+
+/**
+ * enum drm_panthor_perf_sample_flags - Sample-wide events that occurred over the sampling
+ * period.
+ */
+enum drm_panthor_perf_sample_flags {
+	/**
+	 * @DRM_PANTHOR_PERF_SAMPLE_OVERFLOW: This sample contains overflows due to the duration
+	 * of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_SAMPLE_OVERFLOW = 1 << 0,
+};
+
+/**
+ * struct drm_panthor_perf_sample_header - Header present before every sample.
+ */
+struct drm_panthor_perf_sample_header {
+	/**
+	 * @timestamp_start_ns: Earliest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_start_ns;
+
+	/**
+	 * @timestamp_end_ns: Latest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_end_ns;
+
+	/** @flags: Current sample flags, combination of drm_panthor_perf_sample_flags. */
+	__u32 flags;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/**
+	 * @user_data: User data provided as part of the command that triggered this sample.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * enum drm_panthor_perf_counter_set - The counter set to be requested from the hardware.
+ *
+ * The hardware supports a single performance counter set at a time, so requesting any set other
+ * than the primary may fail if another process is sampling at the same time.
+ *
+ * If in doubt, the primary counter set has the most commonly used counters and requires no
+ * additional permissions to open.
+ */
+enum drm_panthor_perf_counter_set {
+	/**
+	 * @DRM_PANTHOR_PERF_SET_PRIMARY: The default set configured on the hardware.
+	 *
+	 * This is the only set for which all counters in all blocks are defined.
+	 */
+	DRM_PANTHOR_PERF_SET_PRIMARY,
+
+	/** @DRM_PANTHOR_PERF_SET_SECONDARY: The secondary performance counter set. */
+	DRM_PANTHOR_PERF_SET_SECONDARY,
+
+	/** @DRM_PANTHOR_PERF_SET_TERTIARY: The tertiary performance counter set.*/
+	DRM_PANTHOR_PERF_SET_TERTIARY,
+};
+
+/**
+ * struct drm_panthor_perf_ringbuf_control - Struct used to map in the ring buffer control indices
+ *                                           into memory shared between user and kernel.
+ *
+ */
+struct drm_panthor_perf_ringbuf_control {
+	/**
+	 * @extract_idx: Number of samples consumed or discarded by userspace. Only
+	 *               modifiable by userspace.
+	 */
+	__u64 extract_idx;
+
+	/**
+	 * @insert_idx: Number of samples emitted by the kernel. Only modifiable by
+	 *              the kernel.
+	 */
+	__u64 insert_idx;
+};
+
+/**
+ * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANTHOR_PERF_SESSION_CREATE.
+ */
+struct drm_panthor_perf_session_create {
+	/**
+	 * @block_set: Set of performance counter blocks, member of
+	 *             enum drm_panthor_perf_counter_set.
+	 *
+	 * This is a global configuration and only one set can be active at a time. If
+	 * another client has already requested a counter set, any further requests
+	 * for a different counter set will fail and return an -EBUSY.
+	 *
+	 * If the requested set does not exist, the request will fail and return an -EINVAL.
+	 *
+	 * Some sets have additional requirements to be enabled, and the setup request will
+	 * fail with an -EACCES if these requirements are not satisfied.
+	 */
+	__u32 block_set;
+
+	/** @fd: eventfd for signalling the availability of a new sample. */
+	__u32 fd;
+
+	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
+	__u32 ringbuf_handle;
+
+	/**
+	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
+	 * insert and extract indices for the ringbuffer.
+	 */
+	__u32 control_handle;
+
+	/**
+	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
+	 * a power of 2 and at least 2, to leave space for a sample and the final STOP sample.
+	 *
+	 * If sample_slots * sample_size is smaller than the ringbuf BO, the setup will fail.
+	 */
+	__u32 sample_slots;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/**
+	 * @fw_enable_mask: Bitmask of counters to request from the FW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 fw_enable_mask[2];
+
+	/**
+	 * @cshw_enable_mask: Bitmask of counters to request from the CSHW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 cshw_enable_mask[2];
+
+	/**
+	 * @tiler_enable_mask: Bitmask of counters to request from the tiler counter block. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit
+	 * 0 corresponds to counter 0.
+	 */
+	__u64 tiler_enable_mask[2];
+
+	/**
+	 * @memsys_enable_mask: Bitmask of counters to request from the memsys counter blocks. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 memsys_enable_mask[2];
+
+	/**
+	 * @shader_enable_mask: Bitmask of counters to request from the shader core counter blocks.
+	 * Any bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 * Bit 0 corresponds to counter 0.
+	 */
+	__u64 shader_enable_mask[2];
+};
+
 /**
  * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
  * @__access: Access type. Must be R, W or RW.

-- 
2.43.0

