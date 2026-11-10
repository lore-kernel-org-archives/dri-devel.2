Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAF60A2601
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mMGdK87l;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mMGdK87l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0ACD10F7B4;
	Tue, 10 Nov 2026 15:41:26 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013046.outbound.protection.outlook.com
 [52.101.83.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED17010F7A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:12 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xT8UeyJgWCUaG5LWwYz7zOsyEo1/eMQq37nohqPv+YI+GD16ZTOUXo2dp88qHfigxmGjErUoKWd2A2k4Vflyf3SiyGVd3Xcp0CsW4zgS4Z8YbTEVefFBaMsF5LZht4lnf+3Bxf6rXZbu/f+df9Nx7O7oVa+mGIdElxCkidy1zu7H9hnd4Ysh6AWKMrAdHp9rItFZ7Ro6vYWIiU6BrIhbUAprT+17Av2Py+ZIKmSWpLi5EgrsvoqCTDt0q+QkzyvnUDum11nME7+d1UR6hB5M7EQXp2fYYZ4jqmgKNA0svECsG8SrkORLQTMQ4ZQY9mRGR/qILfjKeogj8KgUF2QSwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL7bIPIsF2taVakLIYfFFwK2LHI3QFYYSovH91576fc=;
 b=tx9KTgQkwjDuUWCWE28iWR7sh1zFYIJfzdfC0R6BR5oRzGQ1E9HyekKDdmg17Y42Aikv3IRkQxzO6ahooKilxyVGs0RHrZ8Cl9kPQ1XKZ96U9z7dd4mKX/to049Ekx2IJHy9/qnCTu+IZPL6M0zQTRSBDMt5+81uZhdMDPNyGyLbYlLh+Y9SWjJ++YIYCcZsaDGAOT5zckexStSVm9njBLPdoBh/o2DdL3wx5SiCu7AOuh3adC22pil0MFOiR6tvGIYJUqPpS+EU6LPyhXYkdq8jwEhti+mwSmGPqpChXiZpqXhpYJtGDn6lhSNTskwWVP2wIFtKv1K2RizGoAwuuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7bIPIsF2taVakLIYfFFwK2LHI3QFYYSovH91576fc=;
 b=mMGdK87laR+LsvLgIzmgq2VMr7UozJiS9L5wonvqrZeDXn7JDfF2AkmR9VWLQNue12MMke61+bu4KagOSRt3KldtXzQXU3o0XQ/+VULkHn+bkZ07iupRgAbm6E5kmCVgVLL/16Vb9Qgcmp07nciW8q/5cmpJPT5XHRqxmMIu3f8=
Received: from PA7P264CA0378.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::23)
 by FRRPR08MB11966.eurprd08.prod.outlook.com (2603:10a6:d10:1d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:07 +0000
Received: from ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
 (2603:10a6:102:399:cafe::35) by PA7P264CA0378.outlook.office365.com
 (2603:10a6:102:399::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B4.mail.protection.outlook.com (10.167.241.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc19YR5/wmES0e87214DYEm3HkgVES25nbUGzjPyQ7QX2WT2QVsURvNdxsC9RXxHsTKyuhamPF9oiOk6AQaLP6KzPvMaRvjqip4HTd3XZxYAK6ihqs8UcxtMav86OtfBPe7U6I7Lb94JS9SfEIsblC+VuQbaSyHU1my/Ip8VfhSqSZlpAypkUyWXyMi9HoMDqowPLPNnA/mNYdQHgJLj1Y2B3YxDE9sUiHkhWvs5v06ZF5AiA19mtaGCLVKTcjmzV6D6OfMIWCBE5i0kqhc2mjgYZGe3tokl+3Uxlf9YJl9S8mNBcq1RaVKhpAIYe4ItmSsn72fkrHPaTOiO3kIRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL7bIPIsF2taVakLIYfFFwK2LHI3QFYYSovH91576fc=;
 b=S4RB2j6wzyOjRPjq1xhA9RPMg6r5NsYgNFEnJ+rnf/UXs1wT08d1i/WBIQNw7sYJ25G7bwsYmOuvNaB5I5HVkQBA46Ox0dDjciEBw0Q5jxZTA3o2HzYO+2/PS8eFvPFL8bQQBUzzYzycfXv0moPOy6j3scQvuCYHamBJVjKnO8/U4TRHNZj3RP1rWFtjAauwMVXswfJ43ZyBaR+BNYl5RKP0vKFJjjXpqf9RCrApmY2GmfttHv/GEKI768PFdOAAT0xcOPxA/+3IGaG742qjQyzNe2XvSFFIKWJNTOQ+E/0Tm0tCBHJzOGUcRfksSxYv2FFtUvyevewoRnaXshdkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7bIPIsF2taVakLIYfFFwK2LHI3QFYYSovH91576fc=;
 b=mMGdK87laR+LsvLgIzmgq2VMr7UozJiS9L5wonvqrZeDXn7JDfF2AkmR9VWLQNue12MMke61+bu4KagOSRt3KldtXzQXU3o0XQ/+VULkHn+bkZ07iupRgAbm6E5kmCVgVLL/16Vb9Qgcmp07nciW8q/5cmpJPT5XHRqxmMIu3f8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:29 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:29 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 11/28] dt-bindings: gpu: panthor: Document AM system
 bindings
Date: Tue, 10 Nov 2026 15:38:32 +0000
Message-ID: <20261110153907.3241978-12-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|ZR1PEPF0000E6B4:EE_|FRRPR08MB11966:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b8b16d-c8bc-4a03-daed-08df3f4108bf
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261022105027099003|5023799004|261102123227099003|261026121527099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: qGEgmv1Dm18nmE/OFGhqYuZ+be1zEQYF82ODsUg3byh3n3YpGGHR+bOBjh/vk3+ol4W4cyIx7pui6wXwZXG3PQIsWrdJyIzz47Dnx8ElLOuIlvMsR00jDLAo8tIBh3jWyvzW/0dIwq7SR1UPGPs0P+qgTU+M8t884VF3mb5EIzQZv6lUCTeFeHesa3j++MCQMYO1g++8Y0WIYSCtyowkMj/2LLJFl9jBCWr5mR2JfvBEpR3JHVAkybyAsfeEPQgU8bc1bYinAspGajK43Z4PMYsYbiSrmJEfXxkFddKWqZF3R0f/lgKo0CbMA4/y/2Es5azvk6kTmNuhmq30HKP6PYbooH2DB2GLKcajMIB0nUAmelFkGdkPahlONvatweZDRYXmf5vZbGBASAamHuUGLVSqi35WyaBEJNlhUAbaoMHkCCTRq/dzd8DwvcCHEcHVXTNPmPDEA9AH9Y2RBgsjyGXkt6/q0xo5Xnxfsy5y8P4HlQ3IMpxfzqGujSTPFNddmIAtixSD57mkHGykNSvPu9EN6kSz1OkWQZtwP72hhcB9kBjGp/lFK8qaalmN4Nr+5dnhEqWEVfWCfmrU9rvY9l2xJ50BlQ5zkvAN8xNgewI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261022105027099003)(5023799004)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ngQFBaUA9J2HfFXNvrHdd+ODfGeWv1IFZdUGq2NZO6CJ4svB39SBNS3Vl2UysI9fOxig1yr6b2V6xI5G8DdmjCeA1A8nCeauH1HZxROZg4dTWwiXKKs7gcAyaS6dLlt/Ecl55RkIhkAekHtasHQeRFK0FVa+CWkelQIecwngan5xNoDUu1gil3Ql0B/BjZqAEuOB221DQNS1bRbOVUL3FG8WO5IbszBC0PNSK9SStjYtCB9Q4YuDT/XtEbqtNE3pjpH8M4yTr3pPJhRExT3IJEAUQyAL5S5+EGzsVJiHlzhqWb2B8JFF1ckuKeqPAUghbEtHwjhh2OgQWN6IoTVlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f436162-930f-4bac-e20a-08df3f40f2ef
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|35042699022|23010399003|376014|14060799003|1800799024|82310400026|56012099006|11063799006|5023799004|261021121427099003|261026140227099003|261022113327099003|261022075727099003|261026121527099003|261009223027099003|261022105027099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: oBqX5ZpChngJM09HmuZoqwvCo27Nk7sEGw3A3B1Cv+cLBB7Zz1QgfFuw1vlJ6MB/FZPpVYnA6NDsdkSb1/4CZdZ7kp+tKnWGY9xJniJ6ANdoaxtkjpJCJMX0zZ2liG9pqJMBy8HaIoDEZTXcvXE7KytP64MB+Oxag/wluYlopVMs4WM56AZkqdnqmPogLYWosNRE14pZijE/Bnfswy5dvgxbGvZuB4x6Y83oWciSYKG1J1RPyaGglK/Bt/97cll8UrZHrbQux0XLh0bUjM8mgSNjo7MsfGi3ZSatsZsGyCVrlHBho9GZxgdkA9Io36psyHWc+SRuA+zOAuNc8h+WQqF8vBl04SUnpNJvF026EhF1LgQsTVh0PG8AK3Eq0NifDpI3FizDQZeUIk0Uf/pM7VghsYl24HaeeN2PK3gZYOMv5gk4nQTaH5VjeZBA9EwyyqASmwQJ7FZRF8mkT416FeM1Esb572bK/RhFFZVhVHFTum3c+5fUrMrM2pSIPhyMTZbTndV2ww7OcNedVF/UVYkv534jk4AhahJFQ3WV7v856S1A5kJscijL8AaPHUdNv6qmzx+vzdP1LE1Rp4m1Ybzvxf28E6ntJu0EmAPgj5FGaMLLoyPt7j7+n6LNAFxz71Co4R+uq+erNwCfFyFrug==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(35042699022)(23010399003)(376014)(14060799003)(1800799024)(82310400026)(56012099006)(11063799006)(5023799004)(261021121427099003)(261026140227099003)(261022113327099003)(261022075727099003)(261026121527099003)(261009223027099003)(261022105027099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o663aTpjCVW8URUlNBYBZ/arJo35Ae9eepDRJFf/jny3wyZ8EW0ILYAC3cDHQ205K2sQkwO/EyjzoScuIH5EBYQO3tZM9vUZI5+Jv1EO9TGIqRr8wcfMLP8oFskxLtI3Ch9wkTU6i55diMWpz2bdfp0exNI9lCdo1sfKPy0wgpAPzB7Rwm8Moi8wsBQpjsNr2yTwsdxhDZfy2ZZnLqWF/yksO/XhxWvu66a304y/pkam0njiOh8BzU9mUShFRCP41dDA37YTmg2Pid1srgLxTeKfCd9GNNhi1QwxjkdfiGwjctc92912uYtx1uQSPPPLIEGeDW7M6fskUR653cFJlTS4RHSoZ73xckfVM+ev+Wa+sL939+NpmyxkAxZMhB6dfsNmfLuTSV4kcQ0BO6YWX0S947fQvm3ybJvjO36soJ4ixbY5yl45sJu6yf71Vq1T
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:06.0406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b8b16d-c8bc-4a03-daed-08df3f4108bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11966
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

Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control and
the AM_ASSIGN block for HW resource assignment outside the GPU
job submission register window.

Document the system node compatible, register and interrupt resources,
GPU clock, and assignment properties for HW resource assignment.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Add an optional AM_ASSIGN register range. Require this range when the
  assignments node is present.
- Describe resource-group assignments for AXI buses, partitions, slices
  and access windows on partition-capable GPUs.
- Allow gpu-arbitration child nodes and the #address-cells, #size-cells
  and ranges properties.
- Remove the panthor-system node-name restriction.
- Remove gpu-supply from the schema and example.
- Add an example with assignments for partition-capable GPU with four
  resource groups.
- Move the MAINTAINERS update to the GPU schema patch.

 .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
new file mode 100644
index 0000000000000..9e0477b8b723a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2026 ARM Limited. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th-Gen GPU System Device
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+properties:
+  compatible:
+    items:
+      - const: arm,mali-gen5-am-system
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: system
+      - const: assign
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dma-coherent: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges: true
+
+  assignments:
+    type: object
+    additionalProperties: false
+    description:
+      Resource group HW resource assignment. Only valid for partition-capable
+      GPUs.
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+    patternProperties:
+      "^resource-group@[0-3]$":
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            items:
+              - maximum: 3
+            description: Resource group number.
+
+          arm,axi-bus:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 1
+            default: 0
+            description:
+              Static resource-group to AXI bus assignment. Valid field values
+              are 0 for AXI_A and 1 for AXI_B.
+
+          arm,partition-mask:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 0xf
+            default: 0
+            description:
+              Static partition-control to resource-group assignment. Bit N
+              selects partition control ID N. Mask must be disjoint across
+              resource groups. Unassigned partitions will be assigned to
+              resource group 0 by default.
+
+          arm,slice-mask:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 0xff
+            default: 0
+            description:
+              Static slice to resource-group assignment. Bit N selects slice ID
+              N. Mask must be disjoint across resource groups. Unassigned slices
+              will be assigned to resource group 0 by default.
+
+          arm,access-window-mask:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 0xffff
+            default: 0
+            description:
+              Static access-window to resource-group assignment.  Bit N selects
+              access window ID N. Masks must be disjoint across resource groups.
+              Unassigned access-windows will be assigned to resource group 0 by
+              default.
+
+        required:
+          - reg
+
+patternProperties:
+  '^gpu-arbitration@[a-f0-9]+$':
+    $ref: arm,mali-gen5-am-arbitration.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      required:
+        - assignments
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu-system@68000000 {
+      compatible = "arm,mali-gen5-am-system";
+      reg = <0x68000000 0x10000>;
+      reg-names = "system";
+      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&mali_gpu_clk>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu-system@68000000 {
+      compatible = "arm,mali-gen5-am-system";
+      reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
+      reg-names = "system", "assign";
+      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&mali_gpu_clk>;
+
+      assignments {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        resource-group@0 {
+          reg = <0>;
+          arm,axi-bus = <0>;
+          arm,partition-mask = <0x1>;
+          arm,slice-mask = <0x3>;
+          arm,access-window-mask = <0xf>;
+        };
+
+        resource-group@1 {
+          reg = <1>;
+          arm,axi-bus = <0>;
+          arm,partition-mask = <0x2>;
+          arm,slice-mask = <0xc>;
+          arm,access-window-mask = <0xf0>;
+        };
+
+        resource-group@2 {
+          reg = <2>;
+          arm,axi-bus = <1>;
+          arm,partition-mask = <0x4>;
+          arm,slice-mask = <0x30>;
+          arm,access-window-mask = <0xf00>;
+        };
+
+        resource-group@3 {
+          reg = <3>;
+          arm,axi-bus = <1>;
+          arm,partition-mask = <0x8>;
+          arm,slice-mask = <0xc0>;
+          arm,access-window-mask = <0xf000>;
+        };
+      };
+    };
+
+...
-- 
2.43.0

