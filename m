Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DE606A337
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Seq8Qk1v;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Seq8Qk1v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E02310FF0B;
	Wed, 18 Nov 2026 17:55:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB2D10FEF6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:55:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=k5E4CEdM03xb+lDCdD3rgrRn8tU1vtKrHvUmO+AxtYMK1RL2xicyFkfKo8CmfEF4hfIzo/Yhd0j7r29O0+BEUvTNITNiKGW4BSV7cSS9VL38AvfStxFKYMvapjdBAj+iDVpQCc2tbjM3JUUGF3xglv1aYCxvl4YNiSIgly7DVHPt3RxXnkE/Mz6lYrCRLd5CbxzYbVQbgtmX1cMcZCO8nNOZVc3/wCSYC0oe5IOlR0gKGjRXAYUGn4z5PaGpzVCK+EZNdGjPF5CA2pQ9+iIOlqVJr84Yr1DWO2AGKbPpldJvYyhZscUUxb35e82//n9XL9cMt/gotkAQ5xMi5CxzFw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSB9R7j+ergcIc6KJ0W4Veb3kwTv0p+q+GFGtDZ/IzY=;
 b=t1OxTvLA6vT7KnGoxhuEo4qN6FfX+8/3zJTy4oqxqqq/df303+rRLpUEogIYdoVRtO9MhbiEQ9D1aAXgVM3vEyDnzUS/axhqk0vREfQMC4ijJaDC/tkqRv5CEeeTOUoZwCXJYfTA1xN8HZjJeU0PK/IG5rKM/oJNXzk6XfZskKTy/yEkqBDmP2O1OI2XBCKA4sHpBJ9WkbVkhtQ27q8y0kppINWZE2/Nt3U+Spu7QkAQNWe/FKG/m5IlpLMiIPS8HpLmGmqNpJUfUzOM2GMNyQzJAT9uhU2N+0gmjDvDKHLSTkoCA2eqxux2KGBFh8SNK9tJiySgSnnzgbLA8pkdQg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSB9R7j+ergcIc6KJ0W4Veb3kwTv0p+q+GFGtDZ/IzY=;
 b=Seq8Qk1vKFpZaOYDEWxajF3KNr/frRZ9AQo50LJa3VqUhc3GS/RlL/PdlUwixY/AjjYA+CtwgCQoe5ngmRtg9p21sodt405UnzjuCxxZilqWjgWyJwITJjMEznnaJ38mus5Gyj0rOK3/ioBEZmvYLqf8LLRb9QQCuXlvbhrlCyA=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by DB9PR08MB8265.eurprd08.prod.outlook.com
 (2603:10a6:10:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:54 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::9d) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 17:54:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxWD3Kz5RFTZrHQlqu8gswTlP/bRiM6T6geit94KIDh8hGARd3A1gsHO/VD4D8+fXMw3g0eHF3XW+i57/H0Cj74iNswxl9ilm/pk3DnScSGF6zZnMBcvHsRvwbJoME4Xv/Dp05exbSyLEXEMyCymY7ONRpbx8DLKuLI80di+QE4ohY5sXZU/0bSgISaW3K6heeoZT+5Alx4tup+wBhjaqooNagdUD/z3W0imlzyLwTXUDfyAQEcXwM60/NeqHP40eSltTPepCuixbu8aUTxVx4I2c2od8nceDmd1uiMBIuGQKAGRfd0KxoMqbwRp8tIwUU+7+tS4FabwZTkRfaUCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSB9R7j+ergcIc6KJ0W4Veb3kwTv0p+q+GFGtDZ/IzY=;
 b=nohK0W7uDTI5siWUUxlSRWhzZyc+ipsID2m/+NMCwLeRGlZu3/PRrC3LYAYrFvNlOe/5WfcIJC+tskWqDwJSzdOAcxbgdXNwA5wF8R7cbKTFE/+RZa2wIDdJpObpkcW1tkensnP+BON8MCeg6LJYYlQf26f5rSvTizo+yPJf722xa3W72+A+PmLpMIb66pdX1JupHP/jkQdLQHNj3GzVHluvZODUwGmP71dm+vXtgk+ounhoDCR6gl3N7KRfdS+ZmqCHWQf0J8w/iaunwCSrCiumoTmexpgyWEZnUDVRywj2OzC8w+J+6va0mo9ltolBlbIx7jDd0FRF7CKVj09yDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSB9R7j+ergcIc6KJ0W4Veb3kwTv0p+q+GFGtDZ/IzY=;
 b=Seq8Qk1vKFpZaOYDEWxajF3KNr/frRZ9AQo50LJa3VqUhc3GS/RlL/PdlUwixY/AjjYA+CtwgCQoe5ngmRtg9p21sodt405UnzjuCxxZilqWjgWyJwITJjMEznnaJ38mus5Gyj0rOK3/ioBEZmvYLqf8LLRb9QQCuXlvbhrlCyA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:17 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:54:17 +0000
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
Subject: [PATCH v3 10/10] drm/panthor: Skip devfreq when no OPP table is
 present
Date: Wed, 18 Nov 2026 17:53:26 +0000
Message-ID: <20261118175332.519657-11-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|DU2PEPF00028D04:EE_|DB9PR08MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbabc1c-3d94-4c9a-49d2-08df459d0cfd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: ux6ltztMhfN0WJZYE15HF9X4EQyESuyln3NDTNiQ9Ro+3ilP3VdQ95pGf5KLoQG05b+eVscvQHTGBX1iTM0UQqxhKc2ddJ/xq9+9b+Ib0QOTosJlWpsaKN8y03cyNoRU19g+h+D8Ptd3rRee7dxfNM+WhH3SE/hdoCFaT9mpxXT3eTk04IkwA9I8TRuh8vi6pwV74imBeqCaLL9MPt5MCC3QG1nZlmtiEpr6UdP6EHOEgdLTfD4/cfwcW86Xxk5knwNzVp6BVXoLiGamXBQxHMsq1bF0ZLI3GNcMuJB1HOcJk9H2fUOC/KChfco+Bm+GxF9O6YYwjSF8S4m98fbmLdHehCOIbUuvlV/JDl96LYMTn4impgmcMwGidVywMwmOjc+vuU+vvjfjUXbyIuOvbVIpMGnAtBiOmaP12efG2rHPADYYSBK/TjYjsiN7QsJApMQRskmQU2e5E+PVewcyYT7zT6YG8ImTWzz9Xuv5nZXTJKbkLVxIPWH0j7SK7PPYj6yoK8AOKQ9dsHIJ1Mq1/Pn3Jo7l735FsRvn2KjVDsaKCRfSLqklcBCVbABLv13rsf4oietLWJyaI0jI0sRzxbY4yJxEusDcJmWpwuWTDgMEvzuPo5EkcQvENaLlqf9n8L9dwOp3FxVIi6ENYWTcaLpRLXxwd9nS9yMmAKFapNk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NrofMCjnQWZFaYtNPA++HupPlCidsrnw0R91U+qhR4cuxBUKjMTzpNLYawN730vXFdO1b+bByMyckp3NLUOMY9Ur7rnXBkZgaqZK+4LTGtAyn41QNZZlf43LnWhM4Mz9PXEG18L4v+f4XaSm6xzetsvUA7iy/9jNXqb5Ln1yCattn7ND1ygio0+kh/uMiAl+//0EcGaHyuClNB4Q/eXsNNUjctfS3g0VLLzDr93d3ekF5t9reErdZN1lEt1I513digod7IWPss5uFe2DO8XSBDQkkQC+H/0aEesIMF7clMgmQScSBltPZGSO+jYd+q0aNCody9nUC2BbA51NGqmN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fedcb507-c448-4147-a773-08df459cf70c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|14060799003|36860700016|1800799024|35042699022|376014|22082099003|18002099003|6133799003|261021123027099003|56012099006|11063799006|261028144727099003|261022075727099003|261102123227099003|261021121427099003|261009223027099003|10067099003|261026121527099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: jR6H4KR10IqcIyqhejF9agOqe6ZiBjFD/KaBl8vrDZRHutqpYj7FAMA65YQut2QlhxP18UHoI2oGSaQq6enBQOL2udmFtlLCi5TvDAuwB3S1TF8Wp7cZPwzbns8GnY0fPrOehVM4zEsuw31NaORYIdRuz/fk8AuwKJU279039r4fkXpl9HtnxTFYvpX2VF9j7vE16syKk6Wz2wIpkUjTNKGXx3OcCeLOszKpwtZ6cL8/qtiMRu9/3qRVsiW7vOjcJ3slcgupcD75oaZujrH78qz1lA47Lb6l8hTCA7kR3O6rHGFfU0xP2MLw07r2dAkaGuNxlWdDpOctd/NgABP0GOq5ff3xogeoAU3dEiPjmyJsyFTTNNXZ85cG02Zke8NmWufuYANxs0EzOzvc96v8tgsVtP8J2lzUkFNSQd0As41RoyfWWQ4s34YzQwZE0iN/AfjlUr/IOtq+7wd7k0ofdSK7UfdNV/NPcx3PnW5vUOKU2N7mo8DdYK73UxjatFKBEBwpgHAPOWgwuZvKALiR2Mzf/4kEXUGj6ngP5ZH3iubk7hAIihzTz1cTZvl01Eux2XwxXKYAqcKMHg5E7/KdOcLg92H/yk5Q3c0OBxuHTZjRwbbL74FxN/sVQoTjOHCBHDFL7FNGCbugzvE5VSW9UqbyrD//3m+o96YWHMocHXIU49b35+LTUHs1d3duUDYRhrN3H2ESrn2O6Dco0WY+BA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(14060799003)(36860700016)(1800799024)(35042699022)(376014)(22082099003)(18002099003)(6133799003)(261021123027099003)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2G2c8C1yDDvimtlibw6tAWOcxpNNN5MymWhaNO04QXjzyOIdHq8tCuYTCYfdk+f3f+gErJnAqYOrEO0dQF1ieOjVj4FhspYVpKdaj3KVIIUY2dK6BprW/A9S/bbBgOT25Zwf8yVJodvlCZ0ilknJau4cQ0SW8gNqfGc1D2RxVcPTGi9liw6eJH1/euOp5+n/wmBdlvZRFC3GZ/0pakrNc5au++RqPIu19SyTUPmmsB8dK6Ky2UvaiMNR9Drs1wLd1zwCB/0U+LXckBxMpapAiYtWWFARgRzxygi1/Dqlt97cNODM8uLCWW6ShNtTz5Z4edFSjtVN/kJF+oWZYY+6Nb8mOyXEBH1uLplpphEMZrg6QnUXNax9cA5RRTtb4OEwkG3GhXSKo8w9Fxf+L+queVVmF1Fb5sjQssjAVM1EYqlZRWygVy/fMXpGFqcspvhB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:53.8726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbabc1c-3d94-4c9a-49d2-08df459d0cfd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8265
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

On Mali v15 AM systems, frequency scaling is handled outside panthor by
the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

Make panthor_devfreq_init() return early when dev_pm_opp_get_opp_table()
returns -ENODEV, and guard the devfreq helper paths against a missing
devfreq instance. Also make it so that frequency can be queried even if
the devfreq instance is missing.

This keeps devfreq enabled for existing platforms while allowing v15 AM
systems to probe without a local devfreq setup.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v3:
- Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
  is unknown, as on AM systems without an OPP table.
v2:
- Directly call functions instead of storing function pointers.
- Picked up R-b from Liviu
v1:
- Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
  of direct DT-property check.
- Support frequency query without devfreq.

 drivers/gpu/drm/panthor/panthor_devfreq.c | 29 +++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_drv.c     |  5 +++-
 drivers/gpu/drm/panthor/panthor_hw.h      |  6 +++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4afe..d1814b5197221 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -12,6 +12,7 @@

 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_hw.h"

 /**
  * struct panthor_devfreq - Device frequency management
@@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	 */
 	table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR_OR_NULL(table)) {
+		/*
+		 * On v15 GPUs, frequency scaling is handled outside of panthor
+		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
+		 * an OPP table. In such cases, do not initialize devfreq for
+		 * panthor.
+		 */
+		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
+		    PTR_ERR(table) == -ENODEV) {
+			drmm_kfree(&ptdev->base, pdevfreq);
+			ptdev->devfreq = NULL;
+			return 0;
+		}
+
 		ret = devm_pm_opp_set_regulators(dev, reg_names);
 		if (ret && ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
@@ -267,7 +281,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;

-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;

 	panthor_devfreq_reset(pdevfreq);
@@ -279,7 +293,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;

-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;

 	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
@@ -290,7 +304,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;

-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;

 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -306,7 +320,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;

-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;

 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -323,10 +337,11 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	unsigned long freq = 0;
 	int ret;

-	if (!pdevfreq->devfreq)
-		return 0;
+	if (!pdevfreq || !pdevfreq->devfreq)
+		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
+	else
+		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);

-	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
 		return 0;

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e9b71ff5ee53f..290f038e0b895 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1715,7 +1715,10 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)
 		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);

-	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+	/* Omit the maximum frequency when it is unknown */
+	if (ptdev->fast_rate)
+		drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+
 	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
 		   panthor_devfreq_get_freq(ptdev));
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index fe31c1088af5a..dee641c698661 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -108,4 +108,10 @@ static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
 	return ptdev->gpu_info.l2_features;
 }

+static inline bool panthor_hw_is_gen5_am(struct device *dev)
+{
+	return device_property_match_string(dev, "compatible",
+					    "arm,mali-gen5-am") >= 0;
+}
+
 #endif /* __PANTHOR_HW_H__ */
--
2.43.0

