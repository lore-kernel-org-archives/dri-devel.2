Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315C606A329
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=EK99c5Ew;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=EK99c5Ew
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D7C10F7B4;
	Tue, 24 Nov 2026 16:21:42 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E503410F66C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:05 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iNZRV4ZR1Dv9w749lHg53hx1919IxgzBySQO6Z6Hpvzcw9uB93aJxE5vLwSxJIvWHx5HlO6yI7s+3cNOKfnQWWrRl7K8At8dj70uQ8VUbRSQN5SzS/wHga2h8SSR3Q3lZWnC94+RElppj66sx9Nu5SNxpY0gUVxu3VSHzZIZmOZGczOaTIuXx/sa7E81ApskQ0Xr1t6DSmcuNhgs65w0FKnokrT0uYmSN9BcjAqriq9kZ/sSma03wkof9LFmjJyUeBxia2p0AqRK7FJh0I5hOT2CAPhYUEP+H1tJt2qxN3tHbHFBg5j+qmEEU3raEiwWxlnOhlshHJRuR4JuM6BTsA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx16p5tHllw+e9g4wn8tWYfJP+mdEHzPniBebzjt2aI=;
 b=Rcg4O/CSXJXzDFSh4JGx/A7N+LdGEmFE3+Ea7S6waVYSRZGo77BaQ/YqvWMmKPMwCUpihcBfL/FUxXq4G1VHooCqS1vMhQRNf2whhFryhBZd43jooJkaecJ9hilswmdUd3n+c9x4ta3eR33k3gYVGDCTdKp4zBtI9PMDXfwuvhMC71lX5UOVVDAkqTsGTEyYSsYx9+9sl6RN+WHar0hrtJorhJSimdMWGHfaJ8xUdDktWwyythsQak71Pqdb24zLf3q5Wb6OX1E7r82MNjG3QRDinr0/R66GvXTqG+t3bWMEXGAjApU/pmzezor0oOgTkHxktji5ofnNye8nCa2Wow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx16p5tHllw+e9g4wn8tWYfJP+mdEHzPniBebzjt2aI=;
 b=EK99c5EwpPKDS/MmDxuQoR9kt9OUpOX9oX9lIEUGpei3zHYC34VM3qXCYzFFZJhDeIqsW94j8JVIVC4js1Zz2242+2tqNpt/6YKaYN9YTpmZg/KCnm/5ZY/B/INkXqyqHKo+QNg2Pahv+3nm3PAHqG2eH8pTpsLWJtrDy2nlTgg=
Received: from AM8P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::20)
 by VE1PR08MB5726.eurprd08.prod.outlook.com (2603:10a6:800:1b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:21:00 +0000
Received: from ZR1PEPF0000E45E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::76) by AM8P251CA0015.outlook.office365.com
 (2603:10a6:20b:21b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.15 via Frontend Transport; Tue,
 24 Nov 2026 16:21:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E45E.mail.protection.outlook.com (10.167.241.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCoYxfWx6GjD2dAXh5L6IRUgSiYZsVeZ0p7VZOKtrN0jkyw2xWb3fxm6ZsaJTaqGqyipLz92CL4W4ZcrsttUSUREuRrMgjlreFkQBvtxAcs0BcX4p3OCqgcFhNL71/jKOQiZj88vBliHjiHrXW1YmGbSIwmMSXFkWswzsprxrGiZES6iwugNN/7C39JPeZY1Zism2Xi1SYdQN1lBlDXBLmsLOsn0ZjZDk88kBHHhpblCojHq/xTqF+UNxjOJPL6A9V0guyjibjsI2/Mb/VKrwMUqqTU9ar4Vor0h4DL7ivoWTe0Tgevs1TaRwJG4x8HnvMPyq41hU6gyeq4S1J+RfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx16p5tHllw+e9g4wn8tWYfJP+mdEHzPniBebzjt2aI=;
 b=NdegKyx3etkULoShlJpldaufBQ1Vs0LZLlLXQ14yKTjT2quB7Necc3B1oMZy/zzs4LmjVHX6JUqwhS8DpDw1bgn3j7Pa4ctudlVw3n/S9Y622qA6CKTZ4bu3xmwAgFMNnU42i8wv8YJ4qbKaKNoclsb2gqA0ENVKscQwFD3RKMluUqMSppg60oNC4SGzLW10KAlARlZQBHdRHlpyqMH/bV1Zs0/fOlyXADG9sufJ+u3PXnpn3bETxxOtliN6GIzQe+A/ubOg3AAFYED0Z1aNRE3Q+1x6RdcO0p+5P8qptaSwYOddU5wcqpkqWL3xqnfnqIEWX97T7Mgc8iIvwruBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx16p5tHllw+e9g4wn8tWYfJP+mdEHzPniBebzjt2aI=;
 b=EK99c5EwpPKDS/MmDxuQoR9kt9OUpOX9oX9lIEUGpei3zHYC34VM3qXCYzFFZJhDeIqsW94j8JVIVC4js1Zz2242+2tqNpt/6YKaYN9YTpmZg/KCnm/5ZY/B/INkXqyqHKo+QNg2Pahv+3nm3PAHqG2eH8pTpsLWJtrDy2nlTgg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by PA6PR08MB10858.eurprd08.prod.outlook.com (2603:10a6:102:3d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:25 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:25 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 8/9] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM
 schema
Date: Tue, 24 Nov 2026 16:19:46 +0000
Message-ID: <20261124161952.1053586-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAYP264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::18) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|PA6PR08MB10858:EE_|ZR1PEPF0000E45E:EE_|VE1PR08MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 78540cd5-45f5-429c-3891-08df4a46ed3e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|3023799007|56012099006|261021121427099003|261102123227099003|11063799006|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261026121527099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 9LynAic/k2K+2bQL3NbYEhAB5Cdrcuo5P4petn4jV3wqs66CSkmpuMTspA8XJNMOSKAdmTfThFT+08nD9zx9axei+5mS+zI9eojOtQmGmNsEZotjp/7vlH+HPBngEgj+XIQ7pzkgIpG6fN0YSZBQoCA989JSd5GHiIHFEZKcIvelv0cPViWnAUAT4hsuIQvWgw1MaW46ycAIaDW3AjYekxuw0K5Wo5Ew9Ak3YXBYTygrnQjOp4cKjNoc6lGYLHVoZfru+S/p/Vsey99qKXKdQlSYCRMZIeSeeqTxwTIvG3A62l+DFeT2aoJTezHUhrMn7KbetXJ5eX3n6uBnJo1Af8fW8ngtxPlRuG0dLi64S1axStxrxfEGDKgnKiugzow4WgY1a3bdNC0G/995/Cwf9ETv07+gjjwETujRQOeazpBwl9qdGo80DOhpQbQLUI8aJbHJgIxWd9GVronP6yYFkE69RVUoKfQ11B05deUdGXQlQncMkmv0KJSXtt7kjUXXBIk5Dr42RaaNi30L2Q+Lm2vF+3g0AuEAii6fof/6PqqGlTTX219FXZSxPLgNlAeoO8MVZ203+nvssnLecc34yDZTj8Lp3EWwsDXxKD60g3M=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(261021121427099003)(261102123227099003)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261026121527099003)(10067099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bqOiMlkJ3/GHjRMUW4YhdY/n8KBH5BkxCmrmf6gieqw2Mb8n3qUtHF+FeoyOMkIpjIJuVnQOxdANOqOUxCeAU6jY1gDjtAImjwhmPyJ8gp7lLjantATBLAVodhrfKX5F5OU0TeUGawEWJcVT46+zYTvYbmFN2g5XU+XqGhES3JnFb/bQmmH3afJ5iEGXerUintiHydYDdhRJ2PnmoypPGRaK/35qZUT3Yu668FMQUA3bYn0GQrbnpddTkVwcTwHUpbmueAJav9tDVbRS3EZlzSzZlvq0Jk6HKHzoXCwp2ZRWUFJGAUyVPheG0XD4nJGemMgCP/yT/9isWIdpP06eoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10858
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 653690e7-dbce-4c77-1d69-08df4a46d88f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|36860700016|7416014|376014|35042699022|1800799024|82310400026|10067099003|261022075727099003|11063799006|56012099006|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: 3QxVBCd0GKWj0fCjZCEH9mQaIqxHFVVZ8Vd9LELphBeXr6YnEIhVj+NcR2HAGEsU7XtGK1eg8OUeJp+/b6mH0Z6kKFHtaryFQPMzgZpPqQtk8S32Uy21e10VpUDK13SMd456OlSwBI99QjoCAyhyjbxqmCg8LUq2i8mvf+9e5QQpYUZSopJZuOOBWCsiYQWdcEq68CcDhtap2BV/V7T0WCjttV8sUL0SyqLhu36I3F0fU2cczpNNmjwXfPvv/xmDuDq7UfNVYBKf4ZoRrSH1e/ijpVx9J/3oyX1JM7RG0AaBhkSjoLp1liRL5K+3cnJqbl8EQi7tG7pNwdD2nS2dU/m3NS4Uao6Ey7+9w6XoQCeI/n/OmmmkL8MzTRwWQLc9vYJJyMxQK0SrGzAhoMVvHw5wrTGSSs195IZRk3YZhVSAe57RD6JGFYsdC36c+NcMhGZzVP6Otbzz7KfVXvODVhAez4dlcVWPhNSlKRVsfmpTcosqO843TyLD0X/DZdb0mPqSA2snGYtHOhOspsmi6aAAtkZ+HMwj8QDZAox1iMF36d1s+q5tkHnwALob4mI96cYeW9H0Aln/UVG3eNBb5598eXbaaX75diqKwscmQtm5a7g/HG6tnhSF8JDYuhaH33a6sR3wLR4wb0acHxfaag==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(36860700016)(7416014)(376014)(35042699022)(1800799024)(82310400026)(10067099003)(261022075727099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tHm+l2EygL3LJdc6loEDbJJvmGCM5mFcwNUIefS3TBaeWITxTZ5wKzK8TpJm2PmQ6NDeJy+UJcnEdrLp2S6PoBRZgeesdIpu7CTfgSmRXGwvgnIH5FNdggC4hdmJUPd9VYtKidhGvXyOlrvX0EegSvUWeG8F9JBRHysrm35qbENuUhgkpvQ/mm+fYgIBJamopPzX4/5QGm08c8eIpWEsC3h6lQRVmtyggLFiHC1tzndtEOrApqBKrbopjcf2cOHtKNAYWcQ8+qVg7yxCLNEVpJ86KJvYXH4osBGEyM6serVIUnK6SIXn2u/nGmY5hu4YovsbkeibBO0+W33k4WAuebfRQBWKl6hcwYxryz0HDrhp14hA9FlKsQ8yWk/bL9nmN1WXyE+bB8/sDe7Q3G6c4LGLmMS837/DvtmG8Ya3x43sKCN5c1Wo3ruiT33IL/6t
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:59.6809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78540cd5-45f5-429c-3891-08df4a46ed3e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5726
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

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v5:
- Removed nvmem-cells, nvmem-cell-names, power-domains and
  power-domain-names. Add them when an integration needs them.
- Require a single unnamed GPU clock and drop clock-names.
v4:
- Pick up Ack from Boris
v3:
- Drop the $nodename constraint from the AM GPU binding.
- Require the arm,zena-css-mali integration compatible followed by
  the arm,mali-gen5-am fallback.
- Update the binding example to use the new compatible, three-cell
  interrupt specifiers, and a single GPU clock.
v2:
- Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
  separate arm,mali-gen5-am.yaml schema.
- Move the AM GPU example to the new schema and add the interrupt
  binding headers.
- Add the new schema to the Panthor MAINTAINERS entry.

 .../bindings/gpu/arm,mali-gen5-am.yaml        | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
new file mode 100644
index 0000000000000..d955476c99774
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
@@ -0,0 +1,63 @@
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
+  compatible:
+    items:
+      - enum:
+          - arm,zena-css-mali
+      - const: arm,mali-gen5-am
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
+    maxItems: 1
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
+        compatible = "arm,zena-css-mali", "arm,mali-gen5-am";
+        reg = <0x100000 0x480000>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&gpu_clk>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index bcade5bfbafe9..93ee837af9958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2404,6 +2404,7 @@ R:	Chris Diamand <chris.diamand@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/
--
2.43.0

