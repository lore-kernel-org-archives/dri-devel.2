Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C75606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hFYQ3fmh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hFYQ3fmh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD6210E31C;
	Wed, 11 Nov 2026 10:33:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3004B10E31C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:33:12 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KJ1K9BTpGOJ6FxKGLpqD5pDcyQ5p4y7G6lopwXulCmQGN7ZHIvSPWCdsBH9MbdNYFEJUYZrP5zdM/Jmv7icjjVWs/wTZEqHbMlafvVsdxmqlZGqrhDyQQPE4wgAoghQ78rwqn/n0O9dlIqmk5gjTR5NAkfBO7VfmGmNh+aKv8K3qE7mtuK9JODPi8Z5JTpTCgMjF+T1sgzSOizsX+ACxpJ2eCanKxTWwleMWrnQxfA77iMsKF/CRactKcoeltvJTxQTcicRNbObHzXa5PrvwTNdqH3K1Hr4KVjEdyxXFunkyb1tZvgil1zPAXQHrOu8pgR3XEpQ6shPmN8zRTH1UMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLD5Umw2/n7ZLB9gd55rw+V16Sg+daLob6armR39Ux8=;
 b=gYQJkzgPE6kKHqQwFKcbN1zfpFztZMVvXBPzIheY5/ng+WSYUCA4udxMhOPo3SsT49XKQwOVDaoIz5BuH6i/QtcYYErhOGrloBkCUnXtIet7QSLobBgKvnY739hYmkHqZ7VPZquqNZ9BmjNnJzikm8ce6Uyt4KfWCFbKbNTMQ+BRiT0RVfpTye6Yo+NWY8X3cOoe8qOJuAUMLu85eSxKU219+SExq8TZYasLlTlE5QwTWAzcJtL9+Rwu+WNNRQNfEnTC7duejlcrZC9JbLErLu/kwFebMSLaaXp4jvZP8f/M/a3YHryhYXxGcsEiINpdhVojrNNJE+fQytbqlsarwQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLD5Umw2/n7ZLB9gd55rw+V16Sg+daLob6armR39Ux8=;
 b=hFYQ3fmhuqP6zPqAKD/kJ4DK5MStnlHKLNW+wFPgixmd0YF5GqXMHJvyxPuf0qlE3tTDm9rMzSMAfSxwcy2kj4EYejbSz17ziSSKZxL/fyZLA0QWYDFAgjKXV90QEgqmHrGg8viYtLTX4bV8RXtDvTFfTYHk7e1JdH5sa836LmQ=
Received: from VI1PR09CA0148.eurprd09.prod.outlook.com (2603:10a6:803:12c::32)
 by PA1PR08MB556523.eurprd08.prod.outlook.com (2603:10a6:102:54f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:33:06 +0000
Received: from ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
 (2603:10a6:803:12c:cafe::68) by VI1PR09CA0148.outlook.office365.com
 (2603:10a6:803:12c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 10:33:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 10:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDlJnXtQUVW7rtI2YBK4zUzYB/ziC5zslnGQ0jS/sIiwIWi7p09i+wS69gUMDZ2wtGEfYhNfkD4JshPm8JJ7fJv8xAR1zWUy6PocXoul2BAZeBt1mGkgcJYm/iL19W6/OQ1R4xD5JGACCTxailo9lTQCtHi+nm43jTOp3O9+e1c7mQwqYjbvo57+QF4S4pvCSekrHULvtuHOr4B/qGCO1dZRZJ5Tn8fGdXAFe6eoxy1KFfkIZs9s0NfPpLLwBA8Nsh0IrkufptHfnUIfrQj9/hQuYllcbmiQwbsS0hL+VLrmUtad4s42sCM1WIjne5Lev9cKA5GhNmY59uVDUPY5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLD5Umw2/n7ZLB9gd55rw+V16Sg+daLob6armR39Ux8=;
 b=Qu2A5qK4ixNTwIEISyqtNafEkS86f5tG6NeqUdZF6aiDoywXLeEENibZfrVk4thnwNfU6eBNdk5KSH6nmEe3qsZnRrbXSbxkSNBrapgoHdD6hKtgWNliqzpFz63lv2M7OL/nsmrtw5dMNqWhGY0YqSjEMFmIbRGjlQCBF8equ1gsKs+uCI7q3QDcw1Etry5t2UQ0QXrtJo1hpVplKVGwe5OMKu4m1Tt22M87QM/a9WgYTQLMN/e1pGdzT2gFU78gStc5RorDidGVvCUEaLypaVPKsjaAIJ2BjjWZIadw3cpSbSO5/j+aU7ZGo70JPWkaZ/PsLqorwzG9gDUSjXoUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLD5Umw2/n7ZLB9gd55rw+V16Sg+daLob6armR39Ux8=;
 b=hFYQ3fmhuqP6zPqAKD/kJ4DK5MStnlHKLNW+wFPgixmd0YF5GqXMHJvyxPuf0qlE3tTDm9rMzSMAfSxwcy2kj4EYejbSz17ziSSKZxL/fyZLA0QWYDFAgjKXV90QEgqmHrGg8viYtLTX4bV8RXtDvTFfTYHk7e1JdH5sa836LmQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AM9PPFA7B418368.eurprd08.prod.outlook.com
 (2603:10a6:20f:fff1::9d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 10:32:32 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:32:32 +0000
Message-ID: <3a63f0dc-9939-4c9f-8050-303cdcaad2d5@arm.com>
Date: Wed, 11 Nov 2026 10:32:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/28] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen
 AM schema
Content-Language: en-GB
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
 <20261110153907.3241978-9-karunika.choo@arm.com>
 <20261111-accelerated-pretty-spoonbill-0afdcc@quoll>
In-Reply-To: <20261111-accelerated-pretty-spoonbill-0afdcc@quoll>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AM9PPFA7B418368:EE_|ZR1PEPF0000E6B7:EE_|PA1PR08MB556523:EE_
X-MS-Office365-Filtering-Correlation-Id: b9166193-aa61-4c60-2f72-08df3fdf2ba6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|22082099003|3023799007|18002099003|10067099003|4143699003|261026140227099003|261102123227099003|11063799006|261026121527099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: ApCVWMHJUU7bk3LPZQEaHSK+pN8lBoWfsUXeb1Pi3XMykZhD075qh38UWizYMOY0TX9djdeBD55sB8eJzPtQxXJPTSPkFG6i/+DDarR2HdxJPemgFYO4UDx+JX14fY1hwl5BvLYBtzYtO6QlmfYoSVk649GE1i8BV+GvxfxEqoEKuGfMyxFF2rw4qStQiPUFDTj1epkOR9M9jYxfHe/bcYuS2OBet0jGSHdLAOXBAb+0Y9kuwqm6m9xc7faqpc5A/tswJD7ceOrWPa+liuIwcbksVGoUHK5Z+/1bfWIzlKFt1KTvViLT4SHR/K/Lg1h6meGdiqp3uSxzB0GBArHG9WfPt1ANrDEjNlUrlEOIk3iJgNOP0SNOXBCBVnxCqG3s2EY3WwlAmwy26Hk6FbW00ho0ZmUDcyR7yWs8z/J9Zt9gcKgoJk3Oiy1bpKfGPv4zrhd+DtzQ4qGEaLTsdXcvqLZ3fqEE2gHDiqNLylYaAtecaZis4VzUI5sgAofYPAdFQqxfC9zmU1DpEnpdA39dryPcsr15aqS3E+tkSO9+RNjsrqMF3NSt4y1EsTEQSo8Nscazm6QtJid1Gp8f3R2PljyvesPdUlmEkXpJzQ6+xlQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(22082099003)(3023799007)(18002099003)(10067099003)(4143699003)(261026140227099003)(261102123227099003)(11063799006)(261026121527099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Z7QmciwX128kkfFBZkYrzJZkxlyAqOGf3MdHalPGDFRrdOk16c0XNilrhZIknQGWw3vWCfwLD5k2z0zkgn9ztPi8dKVI6BjCsh/Sd0O5QU9GzDCRtikRn3QZUd5Y8VETbOhn5xONhK6nHLYPj79Vn2v1uzdPX/KbmmGegLl5tsqyVGtSYuHJLn6MyhL1K6iosmxYG8d+PigKQz1vDwH9bLeptjABQcdeo3RNTFAz7YLAFZRplT7/fStlKu3Yae+avVwYF+JupsZTgNzi3YkjBiSutRsSNnxkfA5xfwsH6vSVWHXcHobMrv/zJgjil6WwbEYEucWQszCXctHUCXOZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PPFA7B418368
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e895a34-774d-4972-f639-08df3fdf17f6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|14060799003|35042699022|376014|18002099003|22082099003|3023799007|13003099007|10067099003|56012099006|11063799006|4143699003|261028144727099003|261009223027099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: bU1MyuqDG0cuHAzv641UWfPnUeW6TarWhWjcyqn1m91M5FnK68RKaBtiutzDkPG5uTduoxiZ//Tk5vp1EEcO9v28uJW7fh8kYrKFkScwVZYlC1wZ9x01vUGf2k+lMMtwzjJrgi1qJRp0G1mgoGDawFNIVe90ydj8IKaNvgVtW88D/CHfR5VzjR4uYAOpjQ0rUtb1TtoRqznQ9i4/zpqtDqN9mTBE458y76PSA1iiDr+XsZTRqDu33NtcAQt929otOVPKj+qqBhcEboiYwDPFHBStVbyqLpALvRmidCHh0Gnf6ZRjPZTAzeLL5HvOmrwevfm/s/iKdvdYiy8j1YkUL1cO/SaEqS9ceXcYmUxXcGxYFWWeqnbm8DLoooZiY4GrrpUzAdgkt+hRDVuYUsc6BMcGNNqI3GSBMHULQrK8FciVDdw0DqOEploNgA1yaGYlPT+YZz+3ngv27sOwyvGc7bo2rx+RRrI1ZIBah6AD90VMll34sAMzUteC8N1f4O+O/JXdhudPIt2/S5AE+cJDTUxCL9Hd2yQLT2yXmXhWS5hs1zyO7StnPs7iMEf6sG0NGnbgZeMr/LK2al8k3sS2WKQUny+PZTNa449xocf22+eBM02NslNUsWX1EuWraAfbpSvIZcl3SrvmZakg7MOcLA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(14060799003)(35042699022)(376014)(18002099003)(22082099003)(3023799007)(13003099007)(10067099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SskzKdBFOXKA4MLMYO/7rmBM+viPAf3cQz6i8Ebv6HGXaNZptBO6eZV44QdmXafnhIZrZ6kcoEMf0ATA6/JnOQjaFBjZXN0NjvlbbBM9kQ4i2uGKSaWzw/e+9Qb/bDQfgCCeErAaqpQdd8uPF6FpsdtzDcrJvYJmgyTXUd9jpO8j+EQhnK2gPbV4UfNWJgWasnhLhySR8OHyrd1HOQNGHFqV5ervAu2p+9Wipv1sFtwZzFM7pLl5ri0/V4yGIh2VsYICGTPcE0qcyQU3C5eVVJvuvNrx45m0Q8NFNeoYaEbDNiB+MxtJBpEDoM14mxEMZ27ZxyqQ1u85+bkmN2IiT/K2PUm9LPVJKKIQXCRo0jAVgIEtpVT5jZ9hMFQFyGM1sALYm8xfe8erFZ69Kof4BvzgUJsetAFjDHLaqgI9NLsN2BRhhy8PVZMnX5t+ryka
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:33:05.1016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9166193-aa61-4c60-2f72-08df3fdf2ba6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B7.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB556523
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

On 11/11/2026 08:33, Krzysztof Kozlowski wrote:
> On Tue, Nov 10, 2026 at 03:38:29PM +0000, Karunika Choo wrote:
>> Add a separate device-tree schema for Mali 5th-Gen AM GPUs.
>>
>> AM_GOVERNOR controls GPU frequency. The GPU node does not accept OPP,
>> cooling or GPU supply properties.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>> ---
>> v2:
>> - Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
>>   separate arm,mali-gen5-am.yaml schema.
>> - Move the AM GPU example to the new schema and add the interrupt
>>   binding headers.
>> - Add the new schema to the Panthor MAINTAINERS entry.
>>
>>  .../bindings/gpu/arm,mali-gen5-am.yaml        | 90 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 91 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>> new file mode 100644
>> index 0000000000000..6349888e1ae2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
>> @@ -0,0 +1,90 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ARM Mali 5th Gen AM GPU
>> +
>> +maintainers:
>> +  - Liviu Dudau <liviu.dudau@arm.com>
>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: '^gpu@[a-f0-9]+$'
> 
> Same comments as last time.

Sorry, do you mean that 'gpu' not generic enough?

>> +
>> +  compatible:
>> +    const: arm,mali-gen5-am
> 
> Same comments as last time. Seems like you just ignore review, so I will
> finish here.
> 

Hi, we are trying to provide initial support for v15. The vendor 
identifiers will be added once there is an available device.

> Respond to review. Dropping from DT patchwork.
> 
> Best regards,
> Krzysztof
> 

