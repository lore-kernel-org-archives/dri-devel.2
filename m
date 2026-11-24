Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02726606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bWm23t2/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bWm23t2/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75FD10F799;
	Tue, 24 Nov 2026 16:21:19 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF10710F678
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tFqmWU8eKeiW2Lph0NzmQC8XyG95bM1BcEFKr6ffoaCmpn93BKpuJsQbwqstxCEFbk7FXHxWxDU6N0LKgHbr7xrDiUtdtCIfeRrDz+z4A6bXQYm6Ins9VzcwJESPGK8EFxMe6wBvAwfDsBV/F8UnsDpvrraDRDFQ4IDmdqgNKRDVIl+OlPA7T/IybWCIQzTiaNBuZt+7sqz8wP5fyJtq76ojgVKE2uvjU9AvBEPXzM7lqHN6mqyMIq3vbxgeEFHJyWITCV25xSr8yBvd6RoDLP+kS6J+slr7rqKKExzAW8bxqE0zKkpTPh9mUvHmb4mCCGBCZEIMEYQyCOVVW8NLXg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=WSFcNe4RNVlDzhkEr7BeROrP+GlOWHgFuVGLub8qlYL70D1wMMFmwYx1chX7Q+b1fty+nrThA+qar3lJtiVMc7JJM5ZYVg3TBHyzPvlXiz+aTngWCcGWjlaonASsmOhg8y2SWdejEOSyQBBVINa+5NZTm8AkY4t1Edu3bMfO7ZqRGNAjqCl7UC7Cfwi5y+JUgOLaM02ZzmVx7o+Mu+MNaX8ukRixjj1GNogCQm09v7K5FGzsEMhh/pYlF96ETrTY8C1+I1bWZUYNvS/JVr2WRf8XFAbIejEOZqWOgw3Lb2HjJzudUxZcScZ5724TTSlJlSwWUYiYTCdjg3/GlpMp/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=bWm23t2/oEvYamXDLU8w/Cac/7byXZAtwogHuzgfE0oWRCG2M5pdBIVKz6zbRXznLmlBS0p0NyJfXtgP93sjMCh0fomJYbP3uBFEjXIGID0XC2xagCbXcD9iIOfya5At9cLmeM7Z+eCf+fjStJWKHIsGQCL6gcOGUj6JPapn1U8=
Received: from DUZPR01CA0334.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::25) by PAXPR08MB7621.eurprd08.prod.outlook.com
 (2603:10a6:102:23f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 16:20:53 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:4b8:cafe::39) by DUZPR01CA0334.outlook.office365.com
 (2603:10a6:10:4b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 16:20:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj/TKE8VuueUNw/U8KlDzPFxd43dTfDN75F9Z1lF1ADds8yG4T2FaIht78yastgnqiuwHdm8Tff0LD5jfe6J77wZC8ylSGuD98jLijI10r5BDf0Ag4Bsk184e7tQYvuL3T605pyfqS21bMfBM5Kd9Q742ngI2kVWKnVbgD4jkS3QarzY/b0wTKY6/U4eDGd6jSqJNsFnXcJJtmHuCE7z2S9dAC27xJn9HD0sK/4wA0gurjuVfIeeVyEtlEF7lcw8TrOUFRhPkU6S0B3pSC6qeQtpryj0MbwkBxVrgW62OttOwT44QdYShCf0AQ/b7bw4RtCPRYITMT7Vv5K3mXRALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=NHrkyHlkrzgsW1zCiJPtiKT2DV4MlXZ0ovETAWqPlELAZq+aOQLfamKCQnNoMXLuSNE6rwLBnCghvledTToYAN92gH2YhHAVJZD2CLS1K+T7gsxzvldxmBhv6FaEjmZhq2fb4mseDDSByIJrAcLevVvtwjy6/XjU+mcnKG7iT8FIbDiczSVM0PXgaxOcY8ae8b7D/DgjgyVfm+mT6muVKFI3AMmnz2IxLg6qYthqNTemheWhytJvplrUdMqZNyBw+md8s4aVkJMR707aUR6NLNh8SHpG1m1bVg55OLjmxJ5p78Pk9CgBSXqU1nTQZogAuZgeN7XYuJHMBSiWVdjIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvhAXoG9GESkVNki7FPp+cmB6oYXLuirLqLKIFWoQbY=;
 b=bWm23t2/oEvYamXDLU8w/Cac/7byXZAtwogHuzgfE0oWRCG2M5pdBIVKz6zbRXznLmlBS0p0NyJfXtgP93sjMCh0fomJYbP3uBFEjXIGID0XC2xagCbXcD9iIOfya5At9cLmeM7Z+eCf+fjStJWKHIsGQCL6gcOGUj6JPapn1U8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by VI3PR08MB938182.eurprd08.prod.outlook.com (2603:10a6:800:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:20 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:20 +0000
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
Subject: [PATCH v5 6/9] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Tue, 24 Nov 2026 16:19:44 +0000
Message-ID: <20261124161952.1053586-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0104.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::13) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|VI3PR08MB938182:EE_|MAD0EPF000008A8:EE_|PAXPR08MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc0bb1e-b0d2-432a-af4e-08df4a46e91f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: CZOa0ygxRQSQ82wXkBS8WmysgmPYqCwEZ539z9OilY/NWzT5VWQOYu2DUcpakLpPuN3nt5lg/Z4fze4DB6fhpr2eDCrJ46YJezOC2O6VCtgwjalRlYH8YfvB69oQ2b9gNI75Gwi0hKZmu9nHoK3Q1MjR8rjOHet+s3MXw2uOKS9cOqe0klWkmggw2Sp4CllKesvpeY2ZI4pKLlIenu1yb54v36totTEqrhhXB+euQh0uOhkPhxsOZwzTYzV/oZPkr9Z2skE3z7u3N0+ISYfJk0yUgtS5mSI9BXIxgy8na5k/ib1ECSTfp76cWTfcJyN/Skz1HjmM5eMhGCPwnUU7DOPoMrUPoSbdDtx6TNlTsgFPdRl/gN6IQY8h5A6AbyrhirilpaFTsjnkRTMUJ3fInLGVq7Sue01sizFk9vfbtOc+UwlDlaGxS7/XEbjQvg16Dks1gWd+a1Hz/+WakpQP0hQzqFHMFbCMExwWLlZtoGEnlpHXoruNmxYrThT4MRYwKy4FoSMO57VN0vO2rBZ+IWVpPRR1pg6MbVIkfHinVhVwJ94zxsZjMu7udhbrIaz1aogrmE7qJQ0OgiyxolToWxitrl50dVUW1zbzwVQQ4DI4/sHKyJPgH8aK1Hhde1e7
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UUdPGcGqztPMLkhmYK185T/CVf0h6tTO0a5Z8bB10GYDEbdeC3aYuyET1hGUOcbENPaMW6vLXkAEbjFfzohv5lngyVAoOXThvAH/+TtSPcURrZWE6IZ89pQB1gytNtK87wvn5wUcyahQU3mpdwQ6qLvqpLt1Nk+as1hepvMQ97TjxvMpSd2HKdfQkdeMm2MrXHk53yEIZlIB+QN3uuoxGCR7ipg7x006duUxt9a8ceCMdgfPeimayn9jFtAUfzRpDtxBITAAOC6WqOFjuMUWiQ4yHS0BobdQsM0FkSlySh899xHdKDEHBdj+nN4r4MWDePLLB4tfoAgI3CGmrpZJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB938182
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 143fdb0f-e617-4215-5b79-08df4a46d56d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|376014|36860700016|14060799003|1800799024|82310400026|10067099003|11063799006|261028144727099003|56012099006|261022105027099003|261022075727099003|261021123027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: +JU3M1hK0MBYkzXjtCqzyoZ0uESzHaQxcONIDdgDXZcCjEjMAk0e5lqAk6HSyQm19iwLj12lweNnJew12IOd7Ijft/ekjmF0jMRENAxERYESkEHpyyMwINIFSA+FX65VYxb1+0OGXS08bpsNGJKGhUnuwuv1tcdhnsf2/HbOaRHbDJ886Nsj1lkDg2EI1a4wZEViqbNpnco+9sYHLPvLuADSypcd+SlzjGIXtbdycS4AM4zasEtWoknhgEfRZ1bVg+EL1yifv+L3LyfwGHmpLOVQmiQodsd92M8JX5hTjYfIXHMAA7vpYmMFVbE+n3MHAb+fw/R8ecpUXj1Wu2DgddOgdGxWQia5nZKhSm5uL41gYsoQv8wmrh2J9lNpAC8lwYtX9yKa0ulNQy+dscabNkPtg8lBA3DaKXcfTKfqtwUFInjsS1gMVQJiETzAANdihQMG0jEhg5bwn201aHozvuqConY1OFEqny6GmKknRMm7izNxD7kCl7xGCQ1+2a4fg3veQIHhpGUiDd2Q6rsf5GABoJBKzh8tiT9T3tTZgDVFgscQ2Ue0t4435HHi8UKrbEmm8rawfwnJ2f8f1qSSfZCodpV6+Qb70WoMoaXE1ECDQqXpEKH+Wj20HqV/ds/L93Jc2Smv39Bz51iVv8fZOokrGYcrDxEjormJ0WB3drE=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(376014)(36860700016)(14060799003)(1800799024)(82310400026)(10067099003)(11063799006)(261028144727099003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dMpToIlxPWl0w7EIXctxJTFxYWGVKstDbKIdoY+pEaIJyp5x+JSd2XCm430iXH3EotmTatSUAWDSoVgo5z7hXViXAuj8Ze6vEELjehAckoRgStq9jjS9MIGhmVfr3Xt9apcoQVhHWOnbrT68oPhAQqi75OCw7uwQ75f7qUAo1LsRODmAJDvIs/NvbSWPMruUL4RSAAXWhowU5EOMao1jW5EfyjD0pBC0OFpJ1j/bZwjukvMiPhcWyhbbQrxl+ZuXWwSvVRyDSXqXuccpqcsGMKtWd7OzD67+3G3Nav+49PvH7IUM4PUS39StT0mcBxfS71IXJE9H4uY3zfeQt+5uly/zMB4+0dyJQhj+2CwGlU/Jut7X+ETGQXPrG4T53A85PbwiyD8rzGrj425HGzGNnS2FUINx/tZ4dBB63mG9yz7PpJ+rK7/+shG9ohe5sOZa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:52.5143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc0bb1e-b0d2-432a-af4e-08df4a46e91f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7621
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

