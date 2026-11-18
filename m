Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB8606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BYYlj/7U;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BYYlj/7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AEE10FF2E;
	Wed, 18 Nov 2026 17:54:51 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A9210EC7B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jSbmB5JVQDQ73wEC10wv1CeMZb0KV/rMzkWJM9j3KYCOTJg80QrS+VljM2RHcpbbYqIq13JW0LrYfm+1D53z148cxlMhmMzAdiUZyYLKhrvo+ZWwfglJi//9ccxk7JBSUyAaYzND5OS53m7dEk1sCFJFpqS1Mi/S8wdfmHXo+URZ9ytRfpH4x5XY6ygxA36rt9V+1Cm0qSSInQp9yQNjQqFWqhukBus8PsJmkHySh0oqb/TY/jD44JqboZTGtOBe1+fELF/ybNUza9Izvr/39gObcv51z16FoGNriikxp1VPnQwnNqukfErIGqlBXmNSfHmHE+lmWHVuJjW8X/siAg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2YiVRnWmyATmc28SgWdX+V85E+XV+ukNLiV/gAd2ls=;
 b=eXjWjdnzNG7cm7LUOdIjKUlFUN9laUFjs9DBfbr/HLMPz/CQLOYjPU+Kkz8tPXlo+gHu//frY24agndhTBdr61RdXfCFHhRYFKatmn29wp576Z4eRpg97GBjT/uyQPJwzKz+ypU9khR/1ILXRuNe1TyuHl4XVKF/RjskwAoMo7GWcTwdZNrluq8qmTBNWFkOPYI1IiDNrmqYsfmamuWXiSYLAVGUCHovZm9qQ2myJ46l7GV2nS56z+8OwlZ1Z5thk0129bOBs401NdafSIUUBlhFKCWmhoBS5J3XCcuz04rV4w+/NtgNpVfrtHt7Vt/PDXzZzrKkAwlYVk320iyKdg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2YiVRnWmyATmc28SgWdX+V85E+XV+ukNLiV/gAd2ls=;
 b=BYYlj/7UXSs4wStG+k3RU4jTPolG19YvL3JzzHltSqoDN941xu3LnWQgoQmZVtBcMZqepQ1U6bTnmpKk7fbF+EsVzCq54HxSEw+9xRug4oA6pZhfUL77uSuxUeiE/F25ni31B8Cfk1QhP3qniC9kZk2qbgPEFvF+heGC2/MJS10=
Received: from WA2PEPF000008BD.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d8::68e)
 by AMCPR08MB999914.eurprd08.prod.outlook.com (2603:10a6:20b:77e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Wed, 18 Nov
 2026 17:54:34 +0000
Received: from WA1PEPF000099CC.eurprd04.prod.outlook.com (2603:10a6:1d8::164)
 by WA2PEPF000008BD.outlook.office365.com (2603:10a6:1d8::68e) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13
 via Frontend Transport; Wed, 18 Nov 2026 17:54:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CC.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8f85Pj3AY2RaxpG4wx913WEUv4apKVgWF+BvSTv2pO0uGzAIT+d7M62J+cLqfrgOV+mVb4c7UpaiiivSyBYcfRB2zWF922zXPF0ifIj5DLnxmJUPzoPHCLzXEn99xHpfASnHSF2jLwlE8J8fW6JbccIxxLGgQeb8dxEps3qrNhAZ2yKiZmitw7ZXPvOHQfmwQBlLwwEWA36IWkLVFCNeJ5Y8z/O6kdKBrvl9a+rDrN+c0ud2HOyqPUV7GSDN69/NvCBpMlqdh8ie5JhbuymUo6jyEKd4t1CCfPHjakEC8vaw5yJCSw0ZFpNSAMrPCZ+MvnWCF0sKgtX+wDgX2Pd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2YiVRnWmyATmc28SgWdX+V85E+XV+ukNLiV/gAd2ls=;
 b=JmKEN5eMu7IKuipNFUi1q2++6Xpzt7mWUPSy6aGM+FUNsoFzq/IrumDh9npWV66R3QT7WzLEdCnBcHzq5j0+ZDShidRXppczgHzqpPXZE1NZl473qSNrTQ2HSOi6qZTwLs6F2FDdHWmxvN5ouSmUJPrxWBpIBOQ0DMWk3XKOLQnuuh4EfGqxQHbNMTjIJ35MNzAZzdIKMBj3B0uJuXznodcNTbaFRlfGmgWNr48cmwh3BIQikfYWlZde5OYZV1KyJ/CcJPDcK18030pw6+smbS4s5XNxc1Fnk64V+cv1ANTgzYkMHDzm7FbyLCdH3fqIPE3CQzl+TYtmUy88lbZTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2YiVRnWmyATmc28SgWdX+V85E+XV+ukNLiV/gAd2ls=;
 b=BYYlj/7UXSs4wStG+k3RU4jTPolG19YvL3JzzHltSqoDN941xu3LnWQgoQmZVtBcMZqepQ1U6bTnmpKk7fbF+EsVzCq54HxSEw+9xRug4oA6pZhfUL77uSuxUeiE/F25ni31B8Cfk1QhP3qniC9kZk2qbgPEFvF+heGC2/MJS10=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:53:58 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:58 +0000
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
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 05/10] drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
Date: Wed, 18 Nov 2026 17:53:21 +0000
Message-ID: <20261118175332.519657-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0651.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::17) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|WA1PEPF000099CC:EE_|AMCPR08MB999914:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ada2456-7e94-41b3-c16a-08df459d0151
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: Q2cOrD709VrVmYqPGJ30N+lheN6BYdUM3IxKPgehSwbl3i12NwtK2cr2tl4bIHJjQUA9aINtL6w1u3EkzlCmclfL+4KRs77HfrYRO5RjgzlCnBwLPW6EXGoTGMnM4sHG6rMnXLWvQwzGlJcKBlGdjoHM56UrIFCNMvVMgPmyMRamAsbT5q9fjMBVUn2jXzhdCEv+FgFFqN5zvQDoBIbtIKlX95CBBhk9I9RXTRmFbpl/uTezmSOsZLzvqBqzLJGc4Dez5H3S3O6BgMxJgToB+Y32B8M2HBfNRSw00i/bFBtxzcHxFTeH3z6l9i5moSKEf/criBdXtuRADVLS7fOKMExRrFXAqlfWUM9JqA/b033WSQVDSYibosHJNYT16MBi27W6eSSFRjA0q+/hk7kTocdWFFfN58h+7aUbBUac4J75rF2rI4SG3tNAgOOi0CaAvP6+IMn7HvRe2Mo4/VbgBRW5/QbOuhs1AJmg0XxKocs6P4NLJKmuW5IL83UZC3LBhjfzNgjGSnaQoHNbYQXm3Qpef3b5fg74kP16Um8j+AxlyKfed2hFOqdLhbdZHnLtF6TzEmwhgZjo4lV3aQvgnfQuAutVGVj0yIkKZfQviZo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: U/mKjpcyTI8zAArSAVjI9C/xF3bLOQmbhjJjlmWuIYqdXsW7XKVs43Hi3K8z8v2iUqtx7N0TB+3/2emhmbYysqR9Po71HUeIAy3LTyHsjycpkYECdUk6fi+KddgeVfo8Lqym0NH5CyEKGZgElfKAxWLV4SPJkblLqoftVYaX+rrDtmJ8CXwxVCsax4EiVgCxOL0239ebELrirFi9DthCz2HDPZXYzP4HlfyvS9taq9KleortqAchcOA7Qvn2HvYB5jHlq48hhxIlxs6QrNIF3xeUf6Ol8MPzTrjDKoMh80gPNMC+b0HF2t5cF3urP/U3mUebi/Yq9gGmnu4c3BtTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36047dba-77d6-4993-14c7-08df459cebc3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|35042699022|36860700016|376014|7416014|23010399003|22082099003|18002099003|6133799003|261009223027099003|3023799007|13003099007|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022113327099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: o0p+vZC2K2soVuKfO0MZHVEZ3cWoLgakD9OZq6BiGXq90zSEVR7q2I7gJZznwzpMRy4e6NIUPES5LHro3ViYBlubgm8fvwR13mfBRZKWRlXGVMLXXfY0VPE8cN+M1s1pHHQRCjxhgfC+B7jzVNSK+mmty88obk6MoqRWu/mqwkLsI2V6afNgrZ+pk7apVsDjdYjNFQIcVrLC193zJtf4I2dE9/r16xZbXM/3Sv1FDP1YeaP6LnoVlIqSjSVrWGb8jrzxsiGMZJR+m5itveFqH9Z6tJFq/Z3dFvJGLo057eJjfaDm7Ui/MiD+MNl9HS99Sr4Hco/4xtmzJXw5AnoA20M2rFA37IKlSMTknZentz2+bmbAIIIMd+VgNpbwx1xiJ8NhQpr7OJXYHVgP3HEOa1qskSV6hsEWPDOrztOzbKCdT6nHuOlrquWHkDvvqOryhe0XV58giaQ5z72FcMARHy+nsa6tculn2Wlg6gJJ4gFbeDJQBy0zF97pI0UPTNZ8SklLj8IlFLNJjCVp0aqSuQiMsD21Fno6LWwAOvwxcjOITkOadRCXn4gyVoVuqKXJnpy0T8EAWLOGdSjfHY44Dsw3bu4JgYTPIHEtIPWCmN1my5qVnvpFTLqKk6WMTYFx/1qimA89MEOAOWZAD+PUUg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022113327099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJgC3o1Y5r2AmADIkYrDbiQm2HrFvTApITy44nZifo9pDNlMdiz4OZzsqA5AdqaBIkZzDy98nbCAJFhiL7k7QQAsg2OXz1oupi4YUHhiqQyeYJ9icshq2SlI/uKBLGKNfkP/jpLzrD6zI2xMJB9wsUNINYJZ0XbLINATQyw3+9NSaktlNjyzuWLePPKKy53GEcVH/UnvuwKuS6mF+qITI2+Ipih5C3S7LsdAS6Rmtfe/hmgEBto5CdCD7a/yMc29kLb4RkmWMKwXBBga0A9yRd7HRAcxQMkkQmMdgEPeSUaAVU3Aduqek9c3IAUtiGeN0BloKJpYKJGOSGkfRq38VX7GrILZ6ApC6td8AYCyA1rFm7r55S6Yaqc6VdlyrBXWl+ou04LZUaitMtkLlj1R65cDrvrR9/XR5gA7muSgIV7ykSeV5ZjpXrHOIki5BAXj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:34.2072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada2456-7e94-41b3-c16a-08df459d0151
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB999914
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

Mali v15 exposes a 64-bit GPU_ID register with a different field layout
from earlier GPUs.

Add the register definitions and decoding helpers for the new format,
read GPU_ID_WIDE when the compatibility value indicates a v15 GPU, and
populate both the cached GPU_ID fields and the uAPI gpu_id_wide field.

This allows userspace and the driver to identify v15 GPUs correctly.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v3:
- Fix the missing blank line after declarations in GPU_ID decoding.
v2:
- Picked up R-b from Liviu.
- Rename the register macro from GPU_WIDE_ID to GPU_ID_WIDE.
- Rename the uAPI field from gpu_wide_id to gpu_id_wide.
- Print the upper 32 bits of GPU_ID_WIDE as the logged 'id' for v15 and
  later GPUs. Keep the existing output for earlier GPUs. Continuation
  fix for previous sashiko comment.
- Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
v1:
- Decode selected GPU_ID format after checking compatibility value.
- Document GPU_DISCOVER and GPU_CONTROL register offset differences
  between GPUs.
- Fix mask generation in panthor_gpu_discover_regs.h

 .../drm/panthor/panthor_gpu_discover_regs.h   | 19 ++++++
 drivers/gpu/drm/panthor/panthor_hw.c          | 63 ++++++++++++++-----
 include/uapi/drm/panthor_drm.h                | 13 ++++
 3 files changed, 81 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
new file mode 100644
index 0000000000000..6896c263f76b6
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
+#define __PANTHOR_GPU_DISCOVER_REGS_H__
+
+#include <linux/bits.h>
+
+#define GPU_ID_WIDE					0x0
+#define   GPU_WIDE_COMPAT				0xF
+#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
+#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
+#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
+#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
+#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
+#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
+#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
+
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 854874a9f322a..a26fe42e14f78 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -3,11 +3,13 @@

 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h>

 #include <drm/drm_print.h>

 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_discover_regs.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
@@ -238,21 +240,30 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)

 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
-	u32 major, minor, status;
+	u32 prod_id, major, minor, status;
 	int ret;

 	ret = panthor_gpu_info_init(ptdev);
 	if (ret)
 		return ret;

+	/*
+	 * The logged 'id' contains four 4-bit architecture and product fields
+	 * in pre-v15 GPUs. In v15+ GPUs, this is now four 8-bit fields.
+	 * Preserve the pre-v15 format for compatibility. Tools decoding these
+	 * fields must handle the wider format for v15+ GPUs.
+	 */
+	if (ptdev->gpu_id.arch_major < 15)
+		prod_id = upper_16_bits(ptdev->gpu_info.gpu_id);
+	else
+		prod_id = upper_32_bits(ptdev->gpu_info.gpu_id_wide);
+
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;

-	drm_info(&ptdev->base,
-		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
-		 major, minor, status);
+	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
+		 get_gpu_model_name(ptdev), prod_id, major, minor, status);

 	drm_info(&ptdev->base,
 		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
@@ -296,18 +307,42 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
 	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);

-	if (!ptdev->gpu_info.gpu_id)
+	if (!gpu_id32)
 		return -ENXIO;

-	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
-	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
+		/*
+		 * GPU_DISCOVER register block always starts at offset zero,
+		 * so does the GPU_CONTROL register block on pre-v15 GPUs.
+		 */
+		void __iomem *discover = ptdev->iomem;
+		u64 gpu_id64 = gpu_read64(discover, GPU_ID_WIDE);
+
+		if (!gpu_id64)
+			return -ENXIO;
+
+		ptdev->gpu_info.gpu_id_wide = gpu_id64;
+
+		gpu_id->arch_major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
+		gpu_id->arch_minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
+		gpu_id->arch_rev = GPU_WIDE_ARCH_REV(gpu_id64);
+		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
+		gpu_id->ver_major = GPU_WIDE_VER_MAJOR(gpu_id64);
+		gpu_id->ver_minor = GPU_WIDE_VER_MINOR(gpu_id64);
+		gpu_id->ver_status = GPU_WIDE_VER_STATUS(gpu_id64);
+	} else {
+		ptdev->gpu_info.gpu_id = gpu_id32;
+
+		gpu_id->arch_major = GPU_ARCH_MAJOR(gpu_id32);
+		gpu_id->arch_minor = GPU_ARCH_MINOR(gpu_id32);
+		gpu_id->arch_rev = GPU_ARCH_REV(gpu_id32);
+		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
+		gpu_id->ver_major = GPU_VER_MAJOR(gpu_id32);
+		gpu_id->ver_minor = GPU_VER_MINOR(gpu_id32);
+		gpu_id->ver_status = GPU_VER_STATUS(gpu_id32);
+	}

 	return 0;
 }
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..09b7f7931e4f4 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -376,6 +376,19 @@ struct drm_panthor_gpu_info {

 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
+
+	/**
+	 * @gpu_id_wide: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
+	 * this is populated.
+	 */
+	__u64 gpu_id_wide;
+#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
+#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
 };

 /**
--
2.43.0

