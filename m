Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C760A380E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S4evh8RL;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=S4evh8RL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31931125D1;
	Thu, 19 Nov 2026 15:47:32 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D7A1125B1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hKu8rBfSxFYA2YOa2GBX4f9ScvX2iN0zrTP4HLvD/xEK/E6NmRmZem1TzqGzthX+fjf6g2/Z0l3dNj3pU/zwha6AIUudcdkiwNo0TScikDPPJv9fS+tItBsS8s81cdQ8KwW404KZ7FM5gKubsKKs35yqMXDi/ze7uQkNEO3MVToHis6vwqM9qCR1vYngTFm7vAaPx+VJUs+41b7K151qFsRGQ7ka4wt3tUE50rnm1pCMlC2kbCQ62/b3e40jB2wYZpbYGds9hR/QgCbZ/C0fA1qSkeBQitrTfA4CM5cIRBLy475toochotnw7L+R5XtfpHJth1w1ytis68QkOW3DdA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=Sf7zVWevYtbMwXzmEs6uVbYzxwpncxWWytDpBvXX8hGDYmRbXRPglL23CqrxrRN1GkoBPFvQ2b0CyyI8FIwq18tcwr/BKdLuEARKyqEPXVhPkQF3+drLf3OdKHqCQCjRbfd/hIkUd2Ipya2aB/WdkrOFm0TgASrYeIM2WNH57L6fN0kRXm0/nIu/n4TMS9jb/k2f2try9qJx1SN1D687ILKqLGUquWs8URuTbfSTpB/wbEFbxaallYpqa0eJRHjXxY8aBj/gFLLAcB1y/iJYvuQiokdSbG7RpdIFdcQD9IaWLtyJR5EuGDgLtE6+ri3p7AsHIGsUgZ73t2kwGBte3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=S4evh8RLqcEaMxvkjjsxgJHXk/tRj3DTLLkILgB2ccQzoDAWGrcMYtp13XN8EHq5NaUP8npOOBLNFqjP+jzvmf+rBvDCY/bGEVIT09MBboTuJ6XyZHLrrqS7Pb5aXMQ6CuXRT3fZpdYjJsVlvpfnDiOAU7038RzecPpL0WjMrNA=
Received: from AS4P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::8)
 by DU0PR08MB9461.eurprd08.prod.outlook.com (2603:10a6:10:42f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:47:07 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::4d) by AS4P189CA0003.outlook.office365.com
 (2603:10a6:20b:5d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 15:47:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puDz3Sau4PjR6W5eAaWUeDqvTrOpaQqwKHYlEfmYy9r7uMeE1Md+BwvYCJ5kpqVuoj0FxymLWJzpYdhD3HOZZOnpO2RGOApaX8ZgjQTgPq+1TuSkpkVOtfKPXHkbW1j90FbvXHpTME71pQYu6tv9md6wMBgmlenaLZZ2cmwWfQyo++yzAVpDMz24xv/tCAMsmPvuGItambZnW07gZX/rgO5QhjDHK89bnVgGBNZz7vQB0X2rAHz2KQyNEHUJedz8kaujRlbxI+5tdBIYxfWZ7+ZuAqnc8Cnw1TttzlLfJKK+TyM/7laeml+XB/IrwtJyPEOHSX3kqZsNt2aEiUgYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=dszy609/uC/kA/rlv+f3kCEKfLBsFenOyUQGz9DbHmRlfJHPEaRsD3iifeklknnkcfM6wqqjLb6ux0Akg73ZZ4jTsVoqQBebUdVOxhAFTUix+b9+tq+WsP3Fn6kVejVYfTvKs1iMmukbBeSl/Ytn3wqvTOgiC0Ps6hRv0puweQgHTsNaiSh82wjeYvFkTj7KwDkxla/fWJInPXSlH/shK3sjaQ2WJ4oWANPFfJJGEJB/cQ3psugKLw6JPKk8cAHJqlOWMUpj85znZ2qfs2dT4alOrbU7gh/VX4Xba/UtsxEFw4b8J2i0lVcOOXXxQOxM5C6VTjdHz6yykvi+ytGpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=S4evh8RLqcEaMxvkjjsxgJHXk/tRj3DTLLkILgB2ccQzoDAWGrcMYtp13XN8EHq5NaUP8npOOBLNFqjP+jzvmf+rBvDCY/bGEVIT09MBboTuJ6XyZHLrrqS7Pb5aXMQ6CuXRT3fZpdYjJsVlvpfnDiOAU7038RzecPpL0WjMrNA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:33 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:33 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 6/9] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Thu, 19 Nov 2026 15:45:56 +0000
Message-ID: <20261119154604.2519184-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0457.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::12) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|DB3PEPF0000885A:EE_|DU0PR08MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccf0901-c518-4036-ce15-08df46545d98
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|261009223027099003|3023799007|56012099006|11063799006|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: jyKGiLJ0Xt4qgik1m1aSd+B9YEmdrcza9zE6eKreAim5ZrH20inMgV6TVln2a7MdwRrOyWlJo72an4FZIRZV26bWQv4BYtbYzjDq6wvKUqQCVFKcS2eTkg1a7ktydHV+/lVsYZVQd//O5y9q36lj25UE/DRR4e1HKJhg1m9QRyS3gR5OW92Xd7EAQOdeChgd92ccZEv3v9Iwfc+i49zO82oVIvHyFfqVBjXhOl/EPIvRQe+4sbCfiuyUpczvzuViDOKbf9c6TQffShLjjg8XbAsrpC5sRlkkDlE+W06blRf7jXOj+g97uxFtc01HcoyY4M83LNHFYd7togaE3Ia8xEucqmma2DFy7Vtbce+uUoqtWhloeUZw5yoRNXbTYlxt5Wl3hf4MgIDxjDkXHg1ZWOZEfuHYn0aPFZjIWVdNKlZSs1T/mpyRohjPfIEZJ9+c7UgPaKxI6h7A6zbRBdyPNEaiQI+0HHkTxrw1XaNGVa3KXWDBbo/1ONkIHE82BU3K/lVqWmcocPDtfSoW5Zl+6r+kqMppVIe2ASGiYzWcd+Pu7BSAwSVPXOQn5NJK5Eqh8FrVUJ2p4M5dMAeVuJF233X/WzPZkxG5A+UoO8xxh9go2uUfWX3MHek4VGSupayL
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: hYSFqJBLNyk8aBPcBnuX58/BekckqikZFMMtdcmQQlg/5CClGOqJ8NoeKqaotSnpc+x7Vs0XvYvyX2BQlRCLferklPwRezcM6w9kKWNpqn21f9CEed+jCzZsuxTxzglxl21PXGL8KCbc4Ak5L/qKzQ2t2iuY8BGjVC4PjmRs3ZpUXj6Ax2rJw2dgerwK1x2Gq4wHnUITQIqyWM29Sg3lXihPFVi/KcTQ/CVYX31cdRXXqU9KKwm+j6F2xgWhZHFTRWODU5y2TBSL3O/nhPtiutECiuPRV4reP6D140guf7bLVG8FR7JKUdWp2UsPE1UasDGU5eCS3WjJbcIJ7B0bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ad05342b-d6fc-49cc-89d6-08df4654496e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700016|82310400026|23010399003|376014|35042699022|22082099003|261009223027099003|18002099003|3023799007|11063799006|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: hH+Yoaj7K1GS7efVtQFW8g0LxlV1F/fmQzbWt/QFpJY9B8q5lMJYwaLCLq22pHp3fPBGcApJsJ3F8Wx0Q8lsaBd4qRPrf0yeeGexhBFqTTF1SmpdxuumSlJ8SPzMf2JFAgEf2S5EUVkqe8ObzUs5goWZtlwrRsa3IedwKDZxYg5ve8RlCPdnAmC60Bs4J0Kk7cXHRxG8VU/L/LIDXUnTiUi/IssNTVgzrPyHFj45DcTe8FxUucTi0MzcL2t8gusfhaGXBpwua3iVYIC9IZ+3Wzn7wNm8i76NIUL63zYVaadvvNWZHW/TWR382dPmsPD6kRWSEcVpg8P1WojRELyHnPJNbRWndkogCReMeS0rFxcyVEc6lQ0JAfoDHo7rcsttH7g20ONQo2cn1qIvRWxeisB2JnWEyFQkA241OGUFTlciqRpRJswCNAnkdN/ngjru6UXgaKZ32MWlUN07PRm//uBpFcKw3Xp+FsAG9BaHR6v74bCHjr88SC8hWNPx211x8DVtO/uxlWIOt/bfxjhtjvoSPQqNO7cWsi7iiM95gI/31YoWoPHgeHZkJ6azJ8glaIDZ2LuENMLJcGH9lap4DrztQ0wtH7zY7NXOw+f3hGgy+brMMDm8sGKE/Q6QNPUGiHislrAbaLpjoq8QIq7J2QAfOjZeVT+geHJ3aBP1d5s=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700016)(82310400026)(23010399003)(376014)(35042699022)(22082099003)(261009223027099003)(18002099003)(3023799007)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4WlI+/ek3mUBRDpLXkTjIMBa7oMvDAgkqrDdgcio/yY93k1tklRHd3ZvZMXGRhZQ6RqDdH+iWt1qfPNjqtv/NaOH5PsKfWPfXaOwZdxnpZObFUjXnMLn5yN4GNs11LCOx4shjODqBH24ehlfiA4Orxk9B8B6Qa4lDq9/jXJ4Ik5ROBQWP2JCdnbx39zkb/dQgBvrK3YcYShae/6fqxcp97FLM+bBs4fVXTnuPJxYnW4pqA/9dFYUE0eGV77CYfHNSECAO6eXs7fP/WfNNfp/3vnwMBUs1ZB1mXxzHp5gSJEhLRBYQE5fSW5cys63/rOM/sOP6mnlk3rIP5/icRaZ+FAveFuuX7Mvs+UL5OQ3JicRNN4FzBIxxl0X0p8G2Mh3UbqRr+TO8Vhnnm/vwMcZj34GxljZBJiT0rOhpJj8zyFsPcR8EcH/ZuCWryTIMamQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:07.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccf0901-c518-4036-ce15-08df46545d98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9461
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

Move the MMU address-space register layout into the hardware description
by storing the MMU_AS base offset and per-AS stride in the Panthor HW
map.

Use those values to compute the iomem pointer for each AS slot and make
the MMU AS register definitions relative to the per-slot register window
instead of hard-coding the slot offset in every register macro.

This prepares the MMU code for GPUs where the MMU AS register region is
not at a fixed offset while keeping the existing register accesses
scoped to a single AS window.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
- Avoid enabling all AS IRQs on init and replace with explicit IRQ clear
  to preserve init behaviour. AS IRQs are enabled as part of
  panthor_mmu_as_enable(). This also prevents accessing NULL iomem
  pointers for initialized AS during init per sashiko's comment.
- Link: https://lore.kernel.org/all/20260922210016.0C0961F000FF@smtp.kernel.org/
v1:
- align with updated panthor_hw_regbank structure.
- moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
  to retrieve it.

 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
 drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 47 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 4fe9e6aeadf76..593bf6743d6df 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -43,6 +43,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.mcu_control = {
 			.offset = 0x700,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
@@ -62,6 +66,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.pwr_control = {
 			.offset = 0x800,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 0a82152d772ad..4cb603a3acef6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -49,6 +49,9 @@ struct panthor_hw_regs_layout {
 
 	/** @mcu_control: MCU_CONTROL register bank layout */
 	struct panthor_hw_regbank mcu_control;
+
+	/** @mmu_as_control: MMU_AS_CONTROL register bank layout */
+	struct panthor_hw_regbank mmu_as_control;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d1c29eec46f21..718160c0779ae 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -35,6 +35,7 @@
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
@@ -49,15 +50,15 @@ struct panthor_vm;
 struct panthor_as_slot {
 	/** @vm: VM bound to this slot. NULL is no VM is bound. */
 	struct panthor_vm *vm;
+
+	/** @iomem: CPU mapping for MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
 };
 
 /**
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
-	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem;
-
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -533,6 +534,11 @@ static void free_pt(void *cookie, void *data, size_t size)
 	kmem_cache_free(pt_cache, data);
 }
 
+static void __iomem *as_iomem(struct panthor_mmu *mmu, u32 as_nr)
+{
+	return mmu->as.slots[as_nr].iomem;
+}
+
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
@@ -542,7 +548,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem(mmu, as_nr), AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -560,7 +566,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(as_iomem(ptdev->mmu, as_nr), AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -603,9 +609,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 
 	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, transtab);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, memattr);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -627,9 +633,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 			return ret;
 	}
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	ret = as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 	if (ret)
@@ -1799,7 +1805,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1861,8 +1867,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
+		addr = gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -3429,8 +3435,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
+	unsigned long as_present_mask = ptdev->gpu_info.as_present;
+	struct panthor_hw_regbank *regbank = &ptdev->hw->regs.mmu_as_control;
 	struct panthor_mmu *mmu;
 	int ret, irq;
+	u32 as_id;
 
 	panthor_mmu_info_init(ptdev);
 
@@ -3449,7 +3458,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
+		u64 offset = regbank->offset + (regbank->stride * as_id);
+
+		guard(mutex)(&mmu->as.slots_lock);
+		mmu->as.slots[as_id].iomem = ptdev->iomem + offset;
+	}
+
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
@@ -3479,7 +3494,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	panthor_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
+	gpu_write(mmu->irq.iomem, INT_CLEAR, panthor_mmu_fault_mask(ptdev, ~0));
 	panthor_irq_resume(&mmu->irq);
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 1ec7f5ef2b196..82661283b46ab 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -11,13 +11,8 @@
 
 /* AS_COMMAND register commands */
 
-#define MMU_AS_BASE					0x2400
-
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define AS_TRANSTAB					0x0
+#define AS_MEMATTR					0x8
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
 							 ((w) ? BIT(0) : 0) | \
@@ -29,8 +24,8 @@
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
 #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define AS_LOCKADDR					0x10
+#define AS_COMMAND					0x18
 #define   AS_COMMAND_NOP				0
 #define   AS_COMMAND_UPDATE				1
 #define   AS_COMMAND_LOCK				2
@@ -38,16 +33,16 @@
 #define   AS_COMMAND_FLUSH_PT				4
 #define   AS_COMMAND_FLUSH_MEM				5
 #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define AS_FAULTSTATUS					0x1C
 #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define AS_FAULTADDRESS					0x20
+#define AS_STATUS					0x28
 #define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define AS_TRANSCFG					0x30
 #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
 #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
 #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
@@ -65,6 +60,6 @@
 #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
 #define   AS_TRANSCFG_WXN				BIT(35)
 #define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+#define AS_FAULTEXTRA					0x38
 
 #endif /* __PANTHOR_MMU_REGS_H__ */
-- 
2.43.0

