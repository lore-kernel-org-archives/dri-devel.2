Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF11606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=W47d+e9q;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=W47d+e9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF43310FACC;
	Wed, 11 Nov 2026 10:45:23 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E61C10FA9B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:44:15 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Yt4PeYkaWdx60AmbCAnVh/Xh2ZELgYF3vMm5HxzTetqDRtt0+/x6M5JRMYq7NG+ln8sQM58YvbgHNi8NH16x5G7tzqJEy0lyAb4rh6HOXUbElN5hO8VhxoWD0J860b/xmfHfgXQ8fU5M/A8Yr2xog42XAciSNBd+XgUZdf/ae3imHNM+RD2PWbs1HE/p9VXkIZvNctPGDYtlmTgCJDBQxOSjCKC2xh+Hg3jl/MRjyO+VZK4VrSyG2SAdPezbIuFHiGrPJbXF8qCQD33cFk2Os8b2lVPgQBhKG1bKTkI++lg7PB/rM8GmSy2jOT2il7OGnOSGpv45RQPKgIuA6mR5Yw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ2D1k1l2XrR8zkES2IX3jXbb6mAV076DEstoQye6Js=;
 b=w2m252gyQ128LduxeKveKOOxudfjcMTZ8xWRDxiXt+5qVQ9FeNah4HqSsYMceVJZNpArjTMzzbnP/hJ6l+Y+lxznAvi4YOoDE2P+BOuKegZJuVrajCjvoCOMxQFipZEDRT5nG7dPOXXV0+mYOWmLnc973uaWNqwVnuU0IeMF/pb6aAVG0VFi2vLPQwEr/IeroTx/qe22KUDyrNHHgJqyIX8ZjHQOw4mvUayG1ZDEmgeNoPKLwnkxFDQlbs+Y9usDGS3ipX6hCeoDpeijuwPM9ziyeaR2BNTlnUXqJlNbdSJ01GFtCNp0GNAl0ZP7bEMDD0q42vDcIfdb6Mw5a1HyUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ2D1k1l2XrR8zkES2IX3jXbb6mAV076DEstoQye6Js=;
 b=W47d+e9qyL1d8/2fcC+UUHzawoZwXvgPyAbBNKgmia+ksNRyxeIAY9DnJi/liOIpspjJEcHyPVY/BxpqG6kjl9K0MaKuY8YJXzF3xqlFiF13S/JYTyAmbpUapAI5d/TUYGq1CI/SqFottuys0UU68rQjQBIva3GHngzCm2rOeG0=
Received: from PR3P193CA0014.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::19)
 by FRZPR08MB11901.eurprd08.prod.outlook.com (2603:10a6:d10:1cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:44:12 +0000
Received: from MAD0EPF000008C7.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::23) by PR3P193CA0014.outlook.office365.com
 (2603:10a6:102:50::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 10:44:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 10:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMHdIi3FnukrFyUW0UkwrytEJSRiF2NOWDtuw4P9f2SdlPdDNDvzyfwPP8K6CBKoKgDq2dk/ZhEJwrTV3/SSBynrZu7YIq6xBuYwsv96jwYPZ6jtNELms79ITIDlufzlAxWxorslw9Tr+1Qma6qitfnc2q/aRkspK7G4awT/w0b1rps3qzVzA6ittjzdCFfl0GY3014Dl5qafiNYbkCq3j+rODSVjwUnnxhOtVEnqwtYehLJDKnVBWYESveQBWq+HyPfu+nbWg640qk7SqHw9lCWgqIHicIS2qZ129xy70znrbRQvVq2VOFF/zU/d25CqNLKYLpLgSPgZ/bkCLvCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ2D1k1l2XrR8zkES2IX3jXbb6mAV076DEstoQye6Js=;
 b=lIGZXBEJrigLwbS6GQjudFJr6I3yLYJXgt4Sw6p55E4BdU45rOBcUUtYf7qPZvhCuJcdmwvbKH0ZKp9VH2MqyogISMHv9P0W6LU9Fh6zr1NwykINAD7f9ATYu6FTP9FLCEX4BGxe5vqWr8eaW2ufY3Ck4kwxP0imxghQOuzyJhKgaGeKITVc7GVqkGDLkQtfuts61q5MSFuUUvT7ccFHjCkzL3iJTW+b7dyJgRl4o27cU54X4HwHfpzw2et0rJR8FufQvnJj77HWOgyEENqg65fAOmbD/KS2eQBVmuZ/rHLFPFYb5YZSFQ5WhJxdv+RSiFRrOj8e2L9dpcH32qKDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ2D1k1l2XrR8zkES2IX3jXbb6mAV076DEstoQye6Js=;
 b=W47d+e9qyL1d8/2fcC+UUHzawoZwXvgPyAbBNKgmia+ksNRyxeIAY9DnJi/liOIpspjJEcHyPVY/BxpqG6kjl9K0MaKuY8YJXzF3xqlFiF13S/JYTyAmbpUapAI5d/TUYGq1CI/SqFottuys0UU68rQjQBIva3GHngzCm2rOeG0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by PA4PR08MB6128.eurprd08.prod.outlook.com
 (2603:10a6:102:f2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:43:34 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:43:34 +0000
Message-ID: <d74eb465-554b-43d6-bbfa-3fb671931462@arm.com>
Date: Wed, 11 Nov 2026 10:43:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/28] dt-bindings: gpu: panthor: Document AM system
 bindings
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
 <20261110153907.3241978-12-karunika.choo@arm.com>
 <20261111-grumpy-carp-of-superiority-eddeb9@quoll>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <20261111-grumpy-carp-of-superiority-eddeb9@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::12) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|PA4PR08MB6128:EE_|MAD0EPF000008C7:EE_|FRZPR08MB11901:EE_
X-MS-Office365-Filtering-Correlation-Id: d5004e33-4854-4a0f-51f4-08df3fe0b8de
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|10067099003|5023799004|11063799006|56012099006|261022075727099003|261022105027099003|261022113327099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: buNzWzY09LrqKvp8xWvwjLLZ9R/RZX63f+BI03eFU2gq6S01GNwk+2zOcmNK/oM5kEa0hBVOh1Gi00gYxJ4UgAXPFs7tCIdtW/IKJlmyP57oTNvP4ZqkbeIJnE2wFzedEEcFMGMeYLPJAE8JTGXZyKebNMNiJZAR5eK+keMjdGybJ3cAJhxHWXV6JjPMK5RkpBE6A4GcYCVzmlWckVgO78BKgSWDhtRCcrbSb6KhCB3EnhKnz69U1CYvBz1zPlIeYWShjjv8IYroXyI5/UgOUG/l2JMdRLzYCWy/aZfEvU50o0Bcl5Oz1BBzC7H7YDWxn301A6uwLXoUDt3diZUfKuUYdlcIMXO7H/84US42u0xjBBTkFOL0JHERS5yO3vPcmwk4/CyUQeXnUjsr7gcyCBdJmqqdCyxjry7CGuNcIaq+wUTXIhxk3uy9vytWVG48fFCCZ7GQjcjgmil3VNYaVbmJl2ZeEJxO1RqtaxvWI4i/szHzTG1/wpdhGPfEu3Krp7Lq5ZHr63OgxRP7GCmJO3tnupQpBL8eOWCwWZ5qY/LBR/hecuDqJVwKV+W26lWeiL/EsCCZhDA40pEQWUwalvK86MxEqmcVCEL+t3nkM+o=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261022113327099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: WcG6i/hUZ4xTIMXN9gEwWjsCJc1ueXrs8Naw2MGYFcrZZCr/7YQeM1vkMoqGdl3K3lef3WnhmXwEPJ+ApMMG79Usf9Aox8Fgfgb0agkNuiBQR+cpfim0AUITTK3KjJ4poG8SqIWhvLFzMF0TzN9SmFr9OMjCuc0/+5jCyGzFO6t1kX+O9l5FccpRa7J3Mj1+zVrx94b2DAdxVJNSQucrDivRnf4ZJlCcptucS36M9QsgDZ7tpg/U+d674LJ6xHRerm/4FLflZKML8IqFkX96PHYzotLL8omBpy3SygMXOsoX0FLU03TjrV2iFusqfb+j2hBYju2UNkUgMxLEye01cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6128
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d048b315-8250-408e-d5a7-08df3fe0a2d8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|376014|14060799003|7416014|1800799024|23010399003|82310400026|261102123227099003|261022105027099003|11063799006|5023799004|4143699003|56012099006|261021121427099003|10067099003|261022075727099003|261022113327099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: nggzdBrkt/eMP3t6NTiwyM6PskPUoqP5Bx63+zvyTF1wPILlhgaGeqGzn3p12T8l1jjnzMxTn8738z6/uXs560kgKrQGPCWFR/7M/7yrvYe99aPWxOFVu9ERNDaOcMzvXzLwo6+6PLH1XOrGaUIOiHSOZ/ZFQY7mYxgbvy+WFpOvO2S9cSl7NqlpYhBoW664VVm2PHR8HZevJ4aOJuddDapeHXOfSzEN3/Y4gVWAYbyV7/2eih/7TfeyHR0RHcPgykDrmLfBnDwPbjZnmgqA8UAUD3XAt9uRls7/cbo9aBbpNlTx7XbPj3ORSpMLWfcBwiJsyjbhk8tCsqlcJPTi/0RnNSBKCow7CQsbeW9RT4aKRXtu4n4h9uWO5yPAB0SRnyb7S4SzNcvQf/KXmjtUxrGiJXHjs2by/O7NUOcRdCa0ZwgoIdPbd8jlEx/vtQtFQj7DsTsgvdwte55R7zv1kcOSo0Z+g0NiIVw5YNmuU99cwcAfab85Z6Fr3yPXBxAvYfse0X5+aUm3ZT1vfaTAZRbN0Ug6WcHc1XB5J2yzjG/k9uEhyMGbo6dJjPJ6zAUFU1N+R7xanBmZDs3wwnHuAqwTRw2UnmRZRqcvfhVwZjmztLWa/15k8CEdUrQDyHn26a+KtgYme+xl6xILb971iQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(376014)(14060799003)(7416014)(1800799024)(23010399003)(82310400026)(261102123227099003)(261022105027099003)(11063799006)(5023799004)(4143699003)(56012099006)(261021121427099003)(10067099003)(261022075727099003)(261022113327099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zTSF4aQEhe3B7W0DpL1hYxXB+VBBXJQMJEypMySy2ZSG/rHQfU4/eGW3PY2oogll+gg8wDHHtPqpUhHiG3aWZxWm+jTb9A+Z5iUlGl29iRvon96Jpz/HuugZ5u2PjY652eBmDFPiRt96AB90bv/V+1yPhrABoYkFwBQMgJjx4fdMd2eqDzeXSq0/qinPvuST+CTGRrBOJUegiFv+JPeYjyyD0GvMl5OLro4XsXTAUG5GIMYL8cuGxDpGBBeohvYi4rGvG2T+jqglNJFsFLm88KUf88klZoJFWqJONPjOw/zgbJ/WMlfCBwMoM+N/BUo4uY8N+Fk1aucdvrZ8GnKitrn8o7j/0RwsuSnR/5Pp/8X0Km31jx+wRxCKa7vBWdGCVyNRla+G5RgJRtfP6oubWGb4aUztGrjuAk9BIHilbe0KyE3L+DOUZJvpAVABsCW7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:44:11.4881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5004e33-4854-4a0f-51f4-08df3fe0b8de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11901
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

On 11/11/2026 08:29, Krzysztof Kozlowski wrote:
> On Tue, Nov 10, 2026 at 03:38:32PM +0000, Karunika Choo wrote:
>> Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control and
>> the AM_ASSIGN block for HW resource assignment outside the GPU
>> job submission register window.
>>
>> Document the system node compatible, register and interrupt resources,
>> GPU clock, and assignment properties for HW resource assignment.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>> ---
>> v2:
>> - Add an optional AM_ASSIGN register range. Require this range when the
>>   assignments node is present.
>> - Describe resource-group assignments for AXI buses, partitions, slices
>>   and access windows on partition-capable GPUs.
>> - Allow gpu-arbitration child nodes and the #address-cells, #size-cells
>>   and ranges properties.
>> - Remove the panthor-system node-name restriction.
>> - Remove gpu-supply from the schema and example.
>> - Add an example with assignments for partition-capable GPU with four
>>   resource groups.
>> - Move the MAINTAINERS update to the GPU schema patch.
>>
>>  .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++++++++++++++++
>>  1 file changed, 196 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>> new file mode 100644
>> index 0000000000000..9e0477b8b723a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>> @@ -0,0 +1,196 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +# Copyright 2026 ARM Limited. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ARM Mali 5th-Gen GPU System Device
>> +
>> +maintainers:
>> +  - Liviu Dudau <liviu.dudau@arm.com>
>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: arm,mali-gen5-am-system
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Why is this flexible? There is no description in the binding which would
> explain oddities in choices of hardware representation.

I will restore the description that was previously asked to be dropped.

>> +
>> +  reg-names:
>> +    minItems: 1
>> +    items:
>> +      - const: system
>> +      - const: assign
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  dma-coherent: true
>> +
>> +  "#address-cells": true
>> +
>> +  "#size-cells": true
> 
> Both need to be const or enum.
> 
>> +
>> +  ranges: true
>> +
>> +  assignments:
> 
> Do not mix nodes with and without bus addressing. That's mess.

Hi, I was asked to use a more generic DT such that should the
hardware registers change in the future we can still retain
some compatibility. Is it necessarily a problem?

> 
>> +    type: object
>> +    additionalProperties: false
>> +    description:
>> +      Resource group HW resource assignment. Only valid for partition-capable
>> +      GPUs.
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    required:
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +
>> +    patternProperties:
>> +      "^resource-group@[0-3]$":
>> +        type: object
>> +        additionalProperties: false
>> +
>> +        properties:
>> +          reg:
>> +            items:
>> +              - maximum: 3
>> +            description: Resource group number.
>> +
>> +          arm,axi-bus:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            maximum: 1
>> +            default: 0
>> +            description:
>> +              Static resource-group to AXI bus assignment. Valid field values
>> +              are 0 for AXI_A and 1 for AXI_B.
>> +
>> +          arm,partition-mask:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            maximum: 0xf
>> +            default: 0
>> +            description:
>> +              Static partition-control to resource-group assignment. Bit N
>> +              selects partition control ID N. Mask must be disjoint across
>> +              resource groups. Unassigned partitions will be assigned to
>> +              resource group 0 by default.
>> +
>> +          arm,slice-mask:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            maximum: 0xff
>> +            default: 0
>> +            description:
>> +              Static slice to resource-group assignment. Bit N selects slice ID
>> +              N. Mask must be disjoint across resource groups. Unassigned slices
>> +              will be assigned to resource group 0 by default.
>> +
>> +          arm,access-window-mask:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            maximum: 0xffff
>> +            default: 0
>> +            description:
>> +              Static access-window to resource-group assignment.  Bit N selects
>> +              access window ID N. Masks must be disjoint across resource groups.
>> +              Unassigned access-windows will be assigned to resource group 0 by
>> +              default.
>> +
>> +        required:
>> +          - reg
>> +
>> +patternProperties:
>> +  '^gpu-arbitration@[a-f0-9]+$':
>> +    $ref: arm,mali-gen5-am-arbitration.yaml#
> 
> There is no such file. You did not really test it.

Sorry, this was included from a later patch that
introduces this file. I will move it there in v3.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - clocks
>> +
>> +additionalProperties: false
> 
> This goes after allOf: block.
> 
>> +
>> +allOf:
>> +  - if:
>> +      required:
>> +        - assignments
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +        reg-names:
>> +          minItems: 2
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    gpu-system@68000000 {
>> +      compatible = "arm,mali-gen5-am-system";
>> +      reg = <0x68000000 0x10000>;
>> +      reg-names = "system";
>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&mali_gpu_clk>;
>> +    };
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    gpu-system@68000000 {
>> +      compatible = "arm,mali-gen5-am-system";
>> +      reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
>> +      reg-names = "system", "assign";
>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&mali_gpu_clk>;
>> +
>> +      assignments {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        resource-group@0 {
>> +          reg = <0>;
>> +          arm,axi-bus = <0>;
>> +          arm,partition-mask = <0x1>;
>> +          arm,slice-mask = <0x3>;
>> +          arm,access-window-mask = <0xf>;
>> +        };
>> +
>> +        resource-group@1 {
>> +          reg = <1>;
>> +          arm,axi-bus = <0>;
>> +          arm,partition-mask = <0x2>;
>> +          arm,slice-mask = <0xc>;
>> +          arm,access-window-mask = <0xf0>;
>> +        };
>> +
>> +        resource-group@2 {
>> +          reg = <2>;
>> +          arm,axi-bus = <1>;
>> +          arm,partition-mask = <0x4>;
>> +          arm,slice-mask = <0x30>;
>> +          arm,access-window-mask = <0xf00>;
>> +        };
>> +
>> +        resource-group@3 {
>> +          reg = <3>;
>> +          arm,axi-bus = <1>;
>> +          arm,partition-mask = <0x8>;
>> +          arm,slice-mask = <0xc0>;
>> +          arm,access-window-mask = <0xf000>;
>> +        };
> 
> Your example is incomplete.

Could you clarify what specifically is missing?

> 
> Best regards,
> Krzysztof
> 

