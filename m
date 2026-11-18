Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7F606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=J0ljBrCT;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=J0ljBrCT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C6110E18C;
	Wed, 18 Nov 2026 10:36:01 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FE710E375
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:35:49 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ays59tgfcp2eLgNQIIDvlP12zQq3i6d5PnELnk+Ld+nVPEWfyy9zRtRizitlF9+WrrpABSRYKQJYLb/4CH8HoYPhuIvyCman0V4azZ0Uq9KmvzfOXu54A5oijns/neJTYKYsetHoKErgGU+ZtWySMVSmJ18t+QA42rYSKJV443VNZVy73N1BgtYXxdxWFCc7V4sRKqL9oLMnXwZBGA416ycaptiVxATzq6pIfMTYACdycXf0HnBEmBKM2Hqf1zem144GLlpXTJ967aAgY9HI5uN6GsK0G0SvMxyxJHWVj9G3bwfqk+/QMyMojstSZFTmv2rtYyjy6D26fqgxhgjSlA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/oIae6BkVX4KeS4B3DqR8471TqCDjkqdv8F6iCMP2s=;
 b=VECAnWqEs6hi5aMjXQi/Xc1MGqask7LM2BprS57p0EYbvtwb4fxLvsDep9oNfUreS3YxwRGxTuMCfPNDu68kH6DZZFyKcLe3yw3Pjrx9MLSysMCLJ79mA2hHxxOcBtnZP0jG2EY2CqM7f/brPS9XlZH0+zcU1bpuw583Px8SrKYjrqP4sMomBjrmSi8J6cNSTcE/NYwR72PQLuD0p088H6kTLPUREBzpz+oHe1C1lUHH6eKjMjtXDjl2R38ZbKttSI1hMsgisLQHabQyBAEgp85JmwSBGNAyRqxid5bWDPBK74I/9XLoeQaq14k9RaRD1iu11ZMJysQMfETaaSZw0g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/oIae6BkVX4KeS4B3DqR8471TqCDjkqdv8F6iCMP2s=;
 b=J0ljBrCTxIpdj4YLKw7h59FYQIHKON4aqj1jDn6Ijnw/GkBT2iIWcaZLoNzCG3/pxxZ0TOisyzy+B7oMywQSd66hB8Ck8seOR8BcvaksuRQW1aPu6sHF+k/pgc12WEBGI2mUCTAInTQcNgdpVi7i9BygcQF0e098F4zVDLiikr4=
Received: from PA7P264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::20)
 by PAVPR08MB9040.eurprd08.prod.outlook.com (2603:10a6:102:32d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:35:43 +0000
Received: from MI3PEPF00008486.eurprd02.prod.outlook.com
 (2603:10a6:102:36c:cafe::69) by PA7P264CA0156.outlook.office365.com
 (2603:10a6:102:36c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 10:35:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008486.mail.protection.outlook.com (10.167.240.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 10:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmjkxZzjmAC6S4rg2m01DMEUA3iMLZr+x4r//D58GuZO8QY8yUrFdMx+fjzF8VwOF589IFTueaJGN+qId5yTQx8V9ZR79iHfHG2CC8O9mKCTLmZ1cXTTHuj6k7o/u2myuCAgLkYyduV5fp7nFsaCs9yblHKlhwA0SJdx+gi9ibOOHOVj5vob/psbc852CehuD/m8IRxh+MRvNeRPKSxmqfQGq/jhmMytAF6ibQ+viteXaPlolORKXyWiA1UW5acEKwU0CYOBS8PhNH1eiO7Hyx26xkDP6k8lmIVLa838DfP5dFBHM5/0idMNcr6efZLUmZYIAL3i9LKilEgmCUPRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/oIae6BkVX4KeS4B3DqR8471TqCDjkqdv8F6iCMP2s=;
 b=Wj8NnWMWVX86SZPVjvfb0J/9t/Neqqa38vGKXq1poZhoJN43J+EbDAxj+52XU6xoc6grfxjnoTsBij2wiDbTIKb+TrUPcHjc0s1nOoie+bsoSGwvaoAtxYCF5/YFyazJO0k7XBPh8ujCBz8Dkj98e+ySSDGXKSMK2CfQwwlea/84VcR7JvIT7svQt962i2lF7AvTY/UiU6v7FqcT0AiBGs9F5FZ+c8cbmkE3XJO3vxmuzJ/b9zHVTlqgYXAjPPIIs4VJGwJg27uNrqFW8qcqe/FFhzf4GzdB0XZ5o6KxV1QDtmpi4bk8JoxahrtIJLblYW3EcmzgCSRehVUHrJLj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/oIae6BkVX4KeS4B3DqR8471TqCDjkqdv8F6iCMP2s=;
 b=J0ljBrCTxIpdj4YLKw7h59FYQIHKON4aqj1jDn6Ijnw/GkBT2iIWcaZLoNzCG3/pxxZ0TOisyzy+B7oMywQSd66hB8Ck8seOR8BcvaksuRQW1aPu6sHF+k/pgc12WEBGI2mUCTAInTQcNgdpVi7i9BygcQF0e098F4zVDLiikr4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by ZR6PR08MB999902.eurprd08.prod.outlook.com
 (2603:10a6:910:d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:35:08 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:35:08 +0000
Message-ID: <90ddbc9b-c2ae-4132-9c89-57c877a79b72@arm.com>
Date: Wed, 18 Nov 2026 10:35:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/28] dt-bindings: gpu: panthor: Document AM system
 bindings
Content-Language: en-GB
From: Karunika Choo <karunika.choo@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-12-karunika.choo@arm.com>
 <20261111-grumpy-carp-of-superiority-eddeb9@quoll>
 <d74eb465-554b-43d6-bbfa-3fb671931462@arm.com>
 <3c6fd46a-8666-408d-8866-f2bb1f293c05@kernel.org>
 <ede42635-1164-4190-b0bb-954125686108@arm.com>
In-Reply-To: <ede42635-1164-4190-b0bb-954125686108@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0287.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::22) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|ZR6PR08MB999902:EE_|MI3PEPF00008486:EE_|PAVPR08MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb2e0be-79b2-4b0f-1989-08df455fb16f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|4143699003|5023799004|56012099006|10067099003|261022113327099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261022075727099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: rAKLyv9G2NzMiXmaU9NZ+ryn3p8HXA8rmRt6ToyngFZ7SLOUU+U/ICI95t0qrttoxKQDuuibtX91WOrZBcmu19FUnlT9CqDZbC2n3pFdDbjpK+6+wCb4Thrs5xJzaHuXGOkTIy2DrhyI/imvnwfABunsY1vx/vu9rqW055p8u/mt+QjLkB6bZaQt/pVRcUeIA7wRwXcmGpUOpJX06wOnXZpROSxIx2rkn12CmmDTgxd4E9UK8Hx/t02mHfwT3o8hlmfKsBVJtogFzBKxGBSOk+M2vrNd+a40Mi1ifWnbdD+Bo6aZUddqVdYKZKBFd6ozxrPcPRqiLNfhV2cqbpAfRd3isziL9tEM3yTkGbVOfwHSoU6W+KHc3i1sQqHSoHUd/s09wIQSnViooTbkL2ydDUASX+5EFSVNPWB1okxr9z86aF4jwUpPy9oQ7fvsmsfDB+UJsXtIFt2xVe0/3vRGkazynLbliRpw9otKgOdunrPe+WRV4oqH/92v/cWQ+nMKUDOfIgePHcQJ9hiCVm3JE5s8BgMonTXwMHTphHOOYEDK1z+LeoXfnqEmTSkQM8gbWX46w0tPw4lsYdVIsYhT0KfK/nt6oh53rtyNmTJbyfc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(261022113327099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261022075727099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: CTD03viI6OEWs2o/9EbwZdAgGv4ch4oqKCNJvbY36KvEKDlMN3vcGbYXesYr9VYoevn0CBo9nV20rjCcKW2urajad+vj3WwNHnAZ4zhW8exG4/CRURytXMWwMfdMBGebS9uBly0uLvpRjpdRpgn7XgNxTIh1kxuAp8mK1OUFBX3xVZg3K3vnoM1cQQPKrI+WJF/Ks9A4kL8ACc7bL2YMjblFJ2WUdLe0WPuP8HVr4cSlVOiDPQdUDOfml2AlT5nDHQtjXbcgDj7RKdiLeTnKc0Af8IWdtY1j2NULe2ewx3ltaQ1AZAspV04qnRnxhZItYRDjnYykBjtJFRCEuE2GTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB999902
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008486.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0ecd3745-2545-4196-5182-08df455f9d96
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|14060799003|1800799024|82310400026|36860700016|376014|7416014|10067099003|5023799004|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261022113327099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: /iH6L49tas0jYZ5Ru9baHOmtLe0hAkvO/rr3psIL301+VzIV9ChNpkigoZHz+QtLcu+2KCnKUtcytTCu6aMMaaVA5DLmZnEdlLl2/83SEuL8JRSTTFrABtpeWced1fqP60VUD6unZhVn0Jl22icfv96BjUipXBPE71gZlCLb49ipFdp6iSIotuOT7Mx4sn6Lr4RREI1AAfX7RFJ9CCGBjtOxFdBWhggolt2Q47UrZtMNhoZRYPL9KEpuUxcISBepiqDZCMG8p99GKE1Wq7Ovt88JrMXMARaE50yAdR0012BDyViZ4xjvaiN01qkm3SmyWjYKr6JhxD7ZdFvIdQ8z3aVzsVijNXrVJYQBY3FMQOxRgb/w2E2hUYowSUOjH1D7z9NgPzTvLzNmH4Gr6lKhpacmk9NAMXvyKdc17zbgt465RcM1Xm1PMKsVHVMkQkbvGh6ljJ4Oi/Qb7K/zHP7gEn82HPZYDxpYyHw2/jz3PzvAb1Yx9hOa7Op7zsWTHRjcY2RAyIuQTrmalo1dS2/MpAciG494S9+ltXpNsBROm7oGNEKwdj7KZI+C5YPaCXL9FngW9eROE962vBGdHkQrXwLBO1lVdATHOnBVdVWASn16J6EiIS0xQuzJ+gLWueTO59FyKNgncJN3eA8MLojrQg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(14060799003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5UCH7rCM2xsFfNKPy0Td7av0AZs07jZWPcEac4jvOX3Gc8da+N3HBn87iEcsTa+GscqfgEi6Gsb2yVGigAQ6qszndxiYv8VwnNkQmkzFbSVNWH0D7PjiY2k0lZ+9U3RdtGAT2udfXRZsPzVM1wfmRSgeMtjuHzXQgCpSbOqXZtk1h5/4RUTnyYjiIb9TzC4Wn96hMKXSGX6/2XL878oC3pKsh2rF6kxxMvdRh16OnrOG3nerjyQ7RVQTisLbhCf2z1J+q7TVWEvIkJPaBn3P31TTnYyYVEpKCah1uzgDL1RwHEyOYnnkuD8uLRi/rZyWxJM2vywSSPUfaK61elurafZ5BUV/f915mSh9q6rmQXdnfMdK1pFL/nLaFZAgo4KntTqxggizWir6yW7knc+n3UcpLHNbZvDu9jLF7v/yKjMmtioQc08Nt8h4hthoiepv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:35:40.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb2e0be-79b2-4b0f-1989-08df455fb16f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008486.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9040
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 14:35, Karunika Choo wrote:
> On 12/11/2026 08:32, Krzysztof Kozlowski wrote:
>> On 11/11/2026 11:43, Karunika Choo wrote:
>>> On 11/11/2026 08:29, Krzysztof Kozlowski wrote:
>>>> On Tue, Nov 10, 2026 at 03:38:32PM +0000, Karunika Choo wrote:
>>>>> Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control and
>>>>> the AM_ASSIGN block for HW resource assignment outside the GPU
>>>>> job submission register window.
>>>>>
>>>>> Document the system node compatible, register and interrupt resources,
>>>>> GPU clock, and assignment properties for HW resource assignment.
>>>>>
>>>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>>>> ---
>>>>> v2:
>>>>> - Add an optional AM_ASSIGN register range. Require this range when the
>>>>>   assignments node is present.
>>>>> - Describe resource-group assignments for AXI buses, partitions, slices
>>>>>   and access windows on partition-capable GPUs.
>>>>> - Allow gpu-arbitration child nodes and the #address-cells, #size-cells
>>>>>   and ranges properties.
>>>>> - Remove the panthor-system node-name restriction.
>>>>> - Remove gpu-supply from the schema and example.
>>>>> - Add an example with assignments for partition-capable GPU with four
>>>>>   resource groups.
>>>>> - Move the MAINTAINERS update to the GPU schema patch.
>>>>>
>>>>>  .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++++++++++++++++
>>>>>  1 file changed, 196 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000..9e0477b8b723a
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>>> @@ -0,0 +1,196 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +# Copyright 2026 ARM Limited. All rights reserved.
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: ARM Mali 5th-Gen GPU System Device
>>>>> +
>>>>> +maintainers:
>>>>> +  - Liviu Dudau <liviu.dudau@arm.com>
>>>>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - const: arm,mali-gen5-am-system
>>>>> +
>>>>> +  reg:
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>
>>>> Why is this flexible? There is no description in the binding which would
>>>> explain oddities in choices of hardware representation.
>>>
>>> I will restore the description that was previously asked to be dropped.
>>
>> Hm, let me open the cover letter to find lore link to previous
>> discussion and check... ah wait, no cover letter!
>>
>>>
>>>>> +
>>>>> +  reg-names:
>>>>> +    minItems: 1
>>>>> +    items:
>>>>> +      - const: system
>>>>> +      - const: assign
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  dma-coherent: true
>>>>> +
>>>>> +  "#address-cells": true
>>>>> +
>>>>> +  "#size-cells": true
>>>>
>>>> Both need to be const or enum.
>>>>
>>>>> +
>>>>> +  ranges: true
>>>>> +
>>>>> +  assignments:
>>>>
>>>> Do not mix nodes with and without bus addressing. That's mess.
>>>
>>> Hi, I was asked to use a more generic DT such that should the
>>
>> By whom?
>>
>>> hardware registers change in the future we can still retain
>>> some compatibility. Is it necessarily a problem?
>>
>> Bindings are not generic, but specific.
> 
> Apologies, this was discussed internally with a Panthor maintainer
> previously. Would the following example DT be more acceptable?
> 
> --8<-------------------------------------------
> panthor_system: gpu-system@68000000 {
> 	compatible = "example-vendor,example-soc-mali-system", "arm,mali-gen5-am-system";
> 	reg = <0x68000000 0x10000>,
> 	      <0x68010000 0x10000>;
> 	reg-names = "system", "assign";
> 	interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> 	clocks = <&mali_gpu_clk>;
> 	dma-coherent;
> 	arm,am-resource-group-bus = <0x1100>;
> 	arm,am-partition-resource-group = <0x3210>;
> 	arm,am-slice-resource-group = <0x33221100>;
> 	arm,am-aw-resource-group = <0x33332222 0x11110000 0x0 0x0>;
> 
> 	panthor_arbitration: gpu-arbitration@68040000 {
> 		...
> 	};
> };
> -->8-------------------------------------------
> 

Hello, thank you for your patience. Would the following layout address
your concern about mixing bus-addressed devices and non-addressed
configuration nodes?

The resource-group and partition configurations are moved into a separate
gpu-assignments node outside the MMIO hierarchy. This node would be
documented in a separate arm,mali-gen5-am-assignments.yaml.

Each entry in the assignment property contains a configuration-node 
phandle followed by the hardware resource-group or partition index.
The example below illustrates the proposed structure.

--8<-------------------------------------------

/* Will be documented in a separate arm,mali-gen5-am-assignments.yaml */
gpu-assignments { 
  compatible = "arm,mali-gen5-am-assignments";

  rg0: resource-group-0 {
    arm,axi-bus = <0>;
    arm,partition-mask = <0x1>;
    arm,slice-mask = <0x3>;
    arm,access-window-mask = <0x3>;
  };

  rg1: resource-group-1 {
    arm,axi-bus = <0>;
    arm,partition-mask = <0x2>;
    arm,slice-mask = <0xc>;
    arm,access-window-mask = <0x4>;
  };

  pc0: partition-0 {
    arm,access-window-mask = <0x3>;
    arm,slice-mask = <0x3>;
  };

  pc1: partition-1 {
    arm,access-window-mask = <0x4>;
    arm,slice-mask = <0x8>;
  };
};

gpu-system@68000000 {
  #address-cells = <1>;
  #size-cells = <1>;

  compatible = "vendor,soc1-mali-system", "arm,mali-gen5-am-system";
  reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
  reg-names = "system", "assign";
  interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
  clocks = <&mali_gpu_clk>;
  arm,resource-assignments = <&rg0 0>, <&rg1 1>;
  dma-coherent;
  ranges;

  gpu-arbitration@68040000 {
    #address-cells = <1>;
    #size-cells = <1>;
    
    compatible = "vendor,soc1-mali-arbitration", "arm,mali-gen5-am-arbitration";
    reg = <0x68040000 0x10000>,
          <0x68050000 0x10000>,
          <0x680C0000 0x10000>,
          <0x680D0000 0x10000>;
    reg-names = "pc0", "pc1", "rg0", "rg1";
    interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
                 <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
                 <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
                 <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
    interrupt-names = "pc0", "pc1", "rg0", "rg1";
    arm,partition-assignments = <&pc0 0>, <&pc1 1>;
    ranges;

    /* access-window 0 */
    gpu@68100000 {
      compatible = "vendor,soc1-mali", "arm,mali-gen5-am";
      reg = <0x68100000 0x480000>;
      interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
      interrupt-names = "job", "mmu", "gpu";
      iommus = <&smmu_700 0x0>, <&smmu_700 0x1>;
      clocks = <&gpu_core_clk>;
    };

    /* access-window 1 */
    gpu@68580000 {
      compatible = "vendor,soc1-mali", "arm,mali-gen5-am";
      reg = <0x68580000 0x480000>;
      interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
      interrupt-names = "job", "mmu", "gpu";
      iommus = <&smmu_700 0x0>, <&smmu_700 0x1>;
      clocks = <&gpu_core_clk>;
    };

    /* access-window 2 */
    gpu@68a00000 {
      compatible = "vendor,soc1-mali", "arm,mali-gen5-am";
      reg = <0x68a00000 0x480000>;
      interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
      interrupt-names = "job", "mmu", "gpu";
      iommus = <&smmu_700 0x0>, <&smmu_700 0x1>;
      clocks = <&gpu_core_clk>;
    };
  };
};
-->8-------------------------------------------

Kind regards,
Karunika

>> ...
>>
>>>>> +patternProperties:
>>>>> +  '^gpu-arbitration@[a-f0-9]+$':
>>>>> +    $ref: arm,mali-gen5-am-arbitration.yaml#
>>>>
>>>> There is no such file. You did not really test it.
>>>
>>> Sorry, this was included from a later patch that
>>> introduces this file. I will move it there in v3.
>>>
>>>>
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - reg-names
>>>>> +  - interrupts
>>>>> +  - clocks
>>>>> +
>>>>> +additionalProperties: false
>>>>
>>>> This goes after allOf: block.
>>>>
>>>>> +
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      required:
>>>>> +        - assignments
>>>>> +    then:
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minItems: 2
>>>>> +        reg-names:
>>>>> +          minItems: 2
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +
>>>>> +    gpu-system@68000000 {
>>>>> +      compatible = "arm,mali-gen5-am-system";
>>>>> +      reg = <0x68000000 0x10000>;
>>>>> +      reg-names = "system";
>>>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +      clocks = <&mali_gpu_clk>;
>>>>> +    };
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +
>>>>> +    gpu-system@68000000 {
>>>>> +      compatible = "arm,mali-gen5-am-system";
>>>>> +      reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
>>>>> +      reg-names = "system", "assign";
>>>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +      clocks = <&mali_gpu_clk>;
>>>>> +
>>>>> +      assignments {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        resource-group@0 {
>>>>> +          reg = <0>;
>>>>> +          arm,axi-bus = <0>;
>>>>> +          arm,partition-mask = <0x1>;
>>>>> +          arm,slice-mask = <0x3>;
>>>>> +          arm,access-window-mask = <0xf>;
>>>>> +        };
>>>>> +
>>>>> +        resource-group@1 {
>>>>> +          reg = <1>;
>>>>> +          arm,axi-bus = <0>;
>>>>> +          arm,partition-mask = <0x2>;
>>>>> +          arm,slice-mask = <0xc>;
>>>>> +          arm,access-window-mask = <0xf0>;
>>>>> +        };
>>>>> +
>>>>> +        resource-group@2 {
>>>>> +          reg = <2>;
>>>>> +          arm,axi-bus = <1>;
>>>>> +          arm,partition-mask = <0x4>;
>>>>> +          arm,slice-mask = <0x30>;
>>>>> +          arm,access-window-mask = <0xf00>;
>>>>> +        };
>>>>> +
>>>>> +        resource-group@3 {
>>>>> +          reg = <3>;
>>>>> +          arm,axi-bus = <1>;
>>>>> +          arm,partition-mask = <0x8>;
>>>>> +          arm,slice-mask = <0xc0>;
>>>>> +          arm,access-window-mask = <0xf000>;
>>>>> +        };
>>>>
>>>> Your example is incomplete.
>>>
>>> Could you clarify what specifically is missing?
>>
>> ll the properties you added in the binding.
>>
>> Best regards,
>> Krzysztof
> Thanks. I'll add that in v3.
> 
> Kind regards,
> Karunika

