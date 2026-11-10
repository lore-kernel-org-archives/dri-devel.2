Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BF606C423
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GQXV+peR;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GQXV+peR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1F210F7BF;
	Tue, 10 Nov 2026 15:42:07 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCBC10F7BE
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fGjf/XJmBcpk3qcahmyKIwN86WQ1T6EQADJMjmA9YvoD5pWGR+OkN7icKPP/+556L+6npv0cxr4B5i9aJmDa/QKncx2N9Y+ZyiT+RbjTjb4MRxDD9irekKBXEhrzeo1NvDjiHa/Boo9/+GIThzojZn5/Pyb5iXfVDiQdmQ3AdcBL/QYddexjIUiSYI3bfceMqlTSdvaWfiJRNyYAGe3q4iL4mqXU0cje4Cz815COQVrVD6z53ORlmLWng8khgKY+4X3KvhZ0aQxEejRogNzm2mnF0bJt6c4SZAzgzDnvvdJHSnb53hVeKG8m0ualUuIw+eH4YHNzl8oA7fUVcpXiaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/oOT4EjDmezlai5eFr5dM/rS/+ZuGN5hT4WrC1737g=;
 b=owcV99wPawAlPzRfqgaCn4bE2n7xPAvn0YHpPnbNs6Pay3jv0qXTHeh36NojhANC7I51HhRF/eYrQ8qNmVbvSLkMjHWWtFYBFiGbzMag4/qXFicmt6agGztacwAwuvEL28rDfMWZ5Kv5ZDKu9Fsx+LndotGoD0Sbt2YYypSwe/ZpOY0XleJG4Dl6cj4Tdotc2Mnu/YT7GhJgDLErttQxSWtSkMiXoT3lnsH/pLhRPZmbJWEOdRB2XTLJBNh5cOcRFaR04hhJAzpCu6hX0MzPjrtSTWAlMBJDY7lWP2BsG7SwBXGy15GmxxRcG8YxsY3+mL3T237Zx1BFJk+//bHBiA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/oOT4EjDmezlai5eFr5dM/rS/+ZuGN5hT4WrC1737g=;
 b=GQXV+peR6PgIohgzLgmA3/KVprPtyitrW35t87Cjs8EbSFjV2Fm62SsLKHaLJARSdncRUj+/2lz2RywclOsxERe3+af8P+3urMgEu6vEuuhtaO0nvneVyNIwPUGKa+Kag/KESf3Zbhn+vxRP5ymeTG8lscgetcQDwO+MJLWd/DM=
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by VI0PR08MB11383.eurprd08.prod.outlook.com
 (2603:10a6:800:303::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:43 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::5c) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmawIxXSDeai/yH6xMHx6CwQXPO4IivwYLCTXK9LRzTaE2Vz1wWPYiC+2oefb5s7mQf7hDtgXIgVA5OrwZqCOUIETG7GfaZONXHOaIn1VKOQxywdymqPXZ7QNfqlJrx2/LJsv6DJ7bfI0A9yXCfo1qdoAeBLcwDb3hjGLf8l7mh3l026ljCjtEi+qP/udU9Eo///grG6LwjhcaBH1k6QcP91BvFJcF81EafU+zvrlAdTzJ+fvC1w60d+kLjiH6E74+dtwgj0OUGzwX340TRvxZufqUoM4S7H4zoCyF3cXKYUq6nzODug5pTbHJtTcfAh/0Xvzx2vPKlt9UnLYcsHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/oOT4EjDmezlai5eFr5dM/rS/+ZuGN5hT4WrC1737g=;
 b=Xx+K42eIMMBXOpyK1FEsVvu4aZk+8He7ofpmSWMf9XxaFvZWFxFo1vWjQb9ykXsM2C0vxurIEx8yMVcwZqSjqoWD7qINPSY/ouGRDC9ZY2ekEDKjzdIQpcodM7dMOXMdPBpbOtRsk9af58q4clk8ug2+YXThy8jtbTekFkPKTS3Bin+c/Tzyd3Ycxx7iXzcMWlk8XLtmHUwTSzBvg6D9u6tfLBv6Ec+WA+rB2pJJ95Thf74x9Yil+nQSY7o77lcYAZwb5+Y0hHI/KhKwLJqvgsUiK6jJ+WU0uwmZ3nXAHU9cBPGb859etetw57J56afFkgZgMHIXWErbc2Eo2Af23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/oOT4EjDmezlai5eFr5dM/rS/+ZuGN5hT4WrC1737g=;
 b=GQXV+peR6PgIohgzLgmA3/KVprPtyitrW35t87Cjs8EbSFjV2Fm62SsLKHaLJARSdncRUj+/2lz2RywclOsxERe3+af8P+3urMgEu6vEuuhtaO0nvneVyNIwPUGKa+Kag/KESf3Zbhn+vxRP5ymeTG8lscgetcQDwO+MJLWd/DM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:11 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:11 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 20/28] drm/panthor: Handle partition control
 INVALID_COMMAND interrupt
Date: Tue, 10 Nov 2026 15:38:41 +0000
Message-ID: <20261110153907.3241978-21-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|DU2PEPF00028CFE:EE_|VI0PR08MB11383:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b61af9-c92e-4e7e-6139-08df3f411ee8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261022105027099003|261102123227099003|261026121527099003|56012099006|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: ukkPnpvjn//ohGyXQuQbR0IBZNZ1ozsAYNwuIBY5Z7eue4WLQyPXWp8/czf6oVppdh1p5LHKQGAjCe5nzLPNJEWTquTB0GiOtZX2kOFlWlc69svoDbuxb54mYYFloN0HIzDJnVHsSImvCfRk0qAuZ4b4/Dr5Pk3NDbgxSKiF5/naO8AkswffTyeMMlv6hPBJrs1B6jLGbbrAVLfW9Yuzwm32eoNKK7CSo14HMnwfQ8KRd5CEhnRQggK4D/rCkD0jVhYBrEgUEV/+pXifQnHP7qpJOvPcNev9G9EKDpuU3eal3v+MFR5UzCqU2CmqLFBwiHJz1k/VpCtXTgamoXrHvzrI7V5OVsvKBUWDhBs9MgF7zZxIPeOMTUCdRO6PPuroxnX+aata/4khQrScemgs8uBL4O5WGdrAa44An1uOyU3XKTlzTamShPvd9ksaJYHcJgvdaodbYDzoV1Q85jYOdW059xokseA3g79pXOqlKdJCWRN4VfpE990FgdybvkaX+5RiclNcGiji0fyBIhf1din15Z+ExjVJ2Ra5pcNQ/ElWaRhp2xcQIJ8hr6PJEWbkCLwPDrxLMwZQweE68GrKcIjzd53DEuz1+W7PwjRwVqL8xwnCa4EJstMoqpxZoxy3zxK3IOwb2FbeACYDI2feEU1biVqwmXuTgG5yvgwCHHw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(56012099006)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BW+INlHIPeRrNyl7RfqZqpNFn5r0CojNzbMjN7fhGaWmY0AWdI3/x0VM6gbuDOLEG0XOnrX5dHQjl36jKFKi1fSgOOReIIX6oEW0+566R1tkmeDbRPrmQJctlKwUVWTkWCKNCirfMWc1+yvtNXBNovs0Q5CcQh0Z24NYeCddWYVtGpS+IIUeejn0J+RixP3DLbSxUT6l65Bkj+0acC5m9aAX/l3ToB6tdSOG7qjRNrjSESa04viKw5Tc/n9dtTd7//7JbOagB6nPoEg/xMda3o+g9kTRZss4ukBsLNptRWvETbtrlGLkodBjWKRduDQXSzsGYiD31yEuk6ZixTesFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f371a1b3-6408-479c-4f93-08df3f410bb1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|14060799003|35042699022|1800799024|36860700016|82310400026|261102123227099003|11063799006|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|261022105027099003|261009223027099003|56012099006|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: EGYuJNWO4nowInoSdWAf/UzQ61a+W6psB37mKoLmU5KEn+RbzHMhoB8HmowewhdBauhKgfmJeR2gpB5r3XEjPm5Bd+a9KO6nglYQ4645qqvAUCRhg0ucGX4LzdWEjCy03kltOIBT7g3nkKhB0hWHM8BT7SIp/yV5cbL0GyBAvlEW9b8VgwfL37MZjqPM02XvRiXx3Ryn3F0iJnZFrcT8ZpqHHnkQ2CR0Sxfx0Zsc/SHLICzu+0BJwUe9qY4X73mPKX7ebv0tfGYcqvaO1Pj4JeU1v09H1XOKeBL8FFQnDkIlcU4VgPsyBK174GmnwUP+6qOcT3NCrXXp0TSzUXXm50rhsoc9RgJm0NfoFbIdNhm3GETuwx073Lk3NVhLEoGrn50VpuAG9bmefGOmkJrCL+tlITQbV6mrb3udaVt6ovmp/P3KX9j88QNwxD+ydFXnUYk/4lbFn0J2hTJb2Y5A/0/MkLEK4RartaJ7xsVrNOcgn9x4xqCC3vIFKS5aVLtmsYKvwtnwz9+Hlkfaonnvb0JY9sgCg41zX0vhC62Aou4q/WiRLHTjbYZPhJ+vcP4j2+VEEdOHGn3EXOJcBf/8DNKfoeE9Y1peR8cRTFQ8splNv8QdJYq41Cj4M1Dq6HriyQUDUWmzuIrqZTTf/kQNyCLWOkgyesx2pKCGcO2gYKuMNFJKYhNxpnBP0CKchhpRqfvZMv2XV/EXQ41XSY47OA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(14060799003)(35042699022)(1800799024)(36860700016)(82310400026)(261102123227099003)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261009223027099003)(56012099006)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p9H6HIF+qJq++VAD9qofV3tceYNgQysm9j8UnGFOLRBmvSa4v26IuYiNXPJpOUnIU/rOp+fd5kvYb7sY81ycZ3IgW1larhSUa4shlOloABH7uUmCBkWyLybdw4VZwRy9O8kgIL6SfHqBCv4uRZ6tCSZaMHdO+8INIhGBlBYwv3FmjRt9cPGCPEM+zG/cEUhQuMUBOabiG0YcZGSaS6IbEN7HzBWMlwLXKFAeWZgTjgtVx2p3v6Pj2oTgHSh2BMbPsLc2AqhVPEp81mhedoDyz+WivUYfzkeczVI//ueiSMgCuy/cz790J6nlTd67uFJriT08d5eoWlrtUzGIe33h3Tcp3g11UQ6TTwXmlBSRu4KDz1mDxBuhzx5+gMo3zflnFzgMT2TMz+Vag0LqmyXT3PAgE2pKRo+/Oxvkc3o1bRnz1fFVZzS+ykkb7IasCLUC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:43.2775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b61af9-c92e-4e7e-6139-08df3f411ee8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11383
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

Partition commands can be rejected while the hardware changes state.

Track the latest command and its target access window. Handle
INVALID_COMMAND interrupts without waiting for state transitions
in IRQ context.

Retry yield and close commands unless the partition is in RESET.
Retry open commands unless the partition is in WINDOW_OPEN.

If an open command finds the partition open for a different access
window, request scheduler recovery.

Handle INVALID_COMMAND before RESET_DONE. Clear the saved command
when handling RESET_DONE.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- make error notification hold assignment_lock during sched_id lookup.
- Track YIELD_IDLE and update invalid command handling to prevent
  untracked commands from triggering the interrupt for valid commands
  that pass.
- Move invalid command handling before RESET_DONE.

 .../panthor/arbitration/panthor_arbitration.h |   2 +
 .../arbitration/panthor_arbitration_drv.c     |  16 +++
 .../arbitration/panthor_arbitration_sched.c   |  10 ++
 .../arbitration/panthor_arbitration_sched.h   |   4 +
 .../arbitration/panthor_partition_control.c   | 109 +++++++++++++++---
 5 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 9a6c251d962de..02e1debf1d75a 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -67,4 +67,6 @@ int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id,
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id);
 
+int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 6479a7602868c..dc63e85ace3de 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -303,6 +303,22 @@ int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id)
 	return panthor_partition_control_close_window(adev->pc[sched_id]);
 }
 
+int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id)
+{
+	int idx;
+
+	guard(spinlock_irqsave)(&adev->assignment_lock);
+
+	idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	panthor_arbitration_sched_reset(adev->sched[idx], aw_id);
+
+	return 0;
+}
+
 static int panthor_arbitration_probe(struct platform_device *pdev)
 {
 	struct panthor_arbitration *adev;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index 95a7685a5b3d6..16bd0fac2514e 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -838,3 +838,13 @@ void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *s
 
 	sched->disabled &= ~BIT(reason);
 }
+
+void panthor_arbitration_sched_reset(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id != sched->active_aw_id)
+		return;
+
+	arb_sched_queue_work(sched, &sched->reset_work);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
index 187124ac39a5e..7e192dfc7756b 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -6,6 +6,8 @@
 
 #include <linux/types.h>
 
+#include "panthor_arbitration.h"
+
 struct panthor_arbitration;
 struct panthor_arbitration_sched;
 
@@ -34,6 +36,8 @@ void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sch
 void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
 					     enum panthor_arb_sched_disable_reason reason);
 
+void panthor_arbitration_sched_reset(struct panthor_arbitration_sched *sched, u8 aw_id);
+
 int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id);
 int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id);
 int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index d8fdafbf31864..3b472403f49d1 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -29,6 +29,7 @@
 
 #define AM_PART_COMMAND				0x100
 #define   AM_PART_SET_COMMAND(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define   AM_PART_GET_COMMAND(x)		FIELD_GET(GENMASK(7, 0), x)
 #define     PART_CMD_YIELD_IDLE			0x10
 #define     PART_CMD_YIELD_NOW			0x11
 #define     PART_CMD_CLOSE_WINDOW		0x20
@@ -43,6 +44,15 @@
 #define PART_REG_POLL_SLEEP_US			10
 #define PART_STATE_TRANSITION_TIMEOUT_US	5000000
 
+/** struct panthor_partition_cmd - Partition command data */
+struct panthor_partition_cmd {
+	/** @cmd: AM_PARTITION_COMMAND value */
+	u32 cmd;
+
+	/** @aw_id: AW ID the command was sent for */
+	int aw_id;
+};
+
 /**
  * struct panthor_partition_control - Partition control data
  */
@@ -73,6 +83,9 @@ struct panthor_partition_control {
 
 	/** @closing: synchronous closing of the partition */
 	bool closing;
+
+	/** @last_cmd: Last sent command */
+	struct panthor_partition_cmd last_cmd;
 };
 
 static void partition_irq_suspend(struct panthor_partition_control *pc)
@@ -118,6 +131,23 @@ static int partition_state_wait(struct panthor_partition_control *pc, u32 state)
 				 false, pc);
 }
 
+static inline void
+partition_command_write_untracked(struct panthor_partition_control *pc, u32 cmd)
+{
+	gpu_write(pc->iomem, AM_PART_COMMAND, cmd);
+}
+
+static void partition_command_write(struct panthor_partition_control *pc,
+				    u32 cmd, int aw_id)
+{
+	lockdep_assert_held(&pc->lock);
+
+	partition_command_write_untracked(pc, cmd);
+
+	pc->last_cmd.cmd = cmd;
+	pc->last_cmd.aw_id = aw_id;
+}
+
 static int yield_now(struct panthor_partition_control *pc)
 {
 	guard(spinlock_irqsave)(&pc->lock);
@@ -128,8 +158,8 @@ static int yield_now(struct panthor_partition_control *pc)
 	if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN)
 		return -EAGAIN;
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
+	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW),
+				pc->current_aw);
 
 	return 0;
 }
@@ -144,8 +174,8 @@ static int yield_idle(struct panthor_partition_control *pc)
 	if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN)
 		return -EAGAIN;
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
+	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE),
+				pc->current_aw);
 
 	return 0;
 }
@@ -162,8 +192,8 @@ static int window_close(struct panthor_partition_control *pc)
 
 	pc->closing = true;
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
+	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW),
+				pc->current_aw);
 
 	return 0;
 }
@@ -188,8 +218,8 @@ static int window_open(struct panthor_partition_control *pc, u8 aw_id)
 		return -EBUSY;
 	}
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id));
+	partition_command_write(pc, (AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) |
+				     AM_PART_SET_WINDOW(aw_id)), aw_id);
 
 	pc->current_aw = aw_id;
 
@@ -201,10 +231,16 @@ static void partition_handle_reset_done(struct panthor_partition_control *pc)
 	bool notify_stopped = false;
 	int aw_id;
 
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_RESET_DONE);
+
 	scoped_guard(spinlock_irqsave, &pc->lock) {
 		aw_id = pc->current_aw;
 		pc->current_aw = AW_UNASSIGNED;
 
+		/* invalidate last command */
+		pc->last_cmd.aw_id = AW_UNASSIGNED;
+		pc->last_cmd.cmd = 0;
+
 		/* RESET_DONE from CLOSE_WINDOW */
 		if (pc->closing)
 			pc->closing = false;
@@ -216,6 +252,55 @@ static void partition_handle_reset_done(struct panthor_partition_control *pc)
 		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
 }
 
+static void partition_handle_invalid_cmd(struct panthor_partition_control *pc)
+{
+	bool on_err = false;
+	int aw_id;
+
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_INVALID_COMMAND);
+
+	scoped_guard(spinlock_irqsave, &pc->lock) {
+		if (!pc->last_cmd.cmd)
+			return;
+
+		if (pc->last_cmd.aw_id < 0)
+			return;
+
+		if (pc->last_cmd.aw_id != pc->current_aw)
+			return;
+
+		switch (AM_PART_GET_COMMAND(pc->last_cmd.cmd)) {
+		case PART_CMD_YIELD_IDLE:
+		case PART_CMD_YIELD_NOW:
+		case PART_CMD_CLOSE_WINDOW:
+			if (partition_state_get(pc) != PART_STATE_RESET) {
+				partition_command_write(pc, pc->last_cmd.cmd,
+							pc->last_cmd.aw_id);
+				return;
+			}
+			break;
+		case PART_CMD_OPEN_WINDOW:
+			if (partition_state_get(pc) != PART_STATE_WINDOW_OPEN) {
+				partition_command_write(pc, pc->last_cmd.cmd,
+							pc->last_cmd.aw_id);
+				return;
+			} else if (partition_aw_get(pc) == pc->last_cmd.aw_id) {
+				return;
+			}
+
+			on_err = true;
+			aw_id = pc->last_cmd.aw_id;
+
+			break;
+		default:
+			return;
+		}
+	}
+
+	if (on_err)
+		panthor_arbitration_notify_err(dev_get_drvdata(pc->dev), aw_id);
+}
+
 static irqreturn_t partition_irq_raw_handler(int irq, void *data)
 {
 	struct panthor_partition_control *pc = data;
@@ -230,13 +315,11 @@ static irqreturn_t partition_irq_raw_handler(int irq, void *data)
 	if (!status)
 		return IRQ_NONE;
 
-	if (status & PART_RESET_DONE)
-		partition_handle_reset_done(pc);
-
 	if (status & PART_INVALID_COMMAND)
-		dev_warn(pc->dev, "%s: Invalid command", pc->name);
+		partition_handle_invalid_cmd(pc);
 
-	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, status);
+	if (status & PART_RESET_DONE)
+		partition_handle_reset_done(pc);
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0

