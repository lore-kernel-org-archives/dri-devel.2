Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07660A381D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=cCngm9hF;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=cCngm9hF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA21C1125A3;
	Thu, 19 Nov 2026 15:47:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66AD1125A3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:46:52 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cL6Qr8pIQAE+nk1CxOVZ2DGOcmRIXnhF0OTAmE31cpVVKSgfo/NOvADVB1ldkd78hqopqj9onKkWCcDfegO2AgbopHhaKhlFbOcJUB0FAjZhp0XzuqYG0+oTnQ6BS0/AsXgZraPxcn+pWfYqWgLNIZpzc1MgnA4ShzzHBKSyhgV86/Gum7DJdQ6y/dDDcMgy4KRyUevpg4Pe/SCOhGrSh5sGODMmCvhisXf9JDqdd/+jmfD4PdzuK9vu+5d+v27ZhXQJp0NBN3zzMt3XXIZnyAO3E0hVK2iAO48LnAuumHIcIzAC/c7/Ef8wWe+UGmMmyPy1eZnKDFbbnYBUX4GVYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuFgodGrt7B1kxPNqeVjHJn7cdsGhbRq0xT1NxwpJms=;
 b=HHdDL67rLO4bBWF87C69v9kfhOYJqGXNaH/UOm7R+iMMuqpXKSuapxBCIZ16rpWnDLB5rJ4/05pvCnGbO2+v5JE28+sTHgLVrli8Om3fOQYR74JZ0MMcTL+4y3Nzgo6Ox7ZTYsYbqB1xLdUA/NnNcFZLWsRBe0YcMd6oQUMpePtLFEBm+6WDj7RtiwcEMeiR8xME8SSlDrhQcz2oS0hpy/u4MVqk5aSUBfj3veDvtNQJIWR3aNA+N7DO1ULRLSTIPoM54srGVKrl95/BK+zGqND0DLJHLa5/ITPv9UlJZJirgeOo84NQok6BJhQGowEkRfJWI8cUzzkmv73IystuAw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuFgodGrt7B1kxPNqeVjHJn7cdsGhbRq0xT1NxwpJms=;
 b=cCngm9hFL2BuaxIUXEOAYQYdQ9/lw+OVTsJyyDYmmj0P5O3S1KuORM7ovC0N2k0tJM0frqdaiT5E3WeDylIrcn/rPJ1H6pbuIxAkTfUYY3jTpKJDgOCFIyeeJoyHgGvxbPH4oQPIuZhO+kmBS7JZwzuV9EJhRur6W0PUTFvUDg0=
Received: from DU7P194CA0030.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::21)
 by PR3PR08MB5769.eurprd08.prod.outlook.com (2603:10a6:102:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:46 +0000
Received: from MAD0EPF000008BB.eurprd04.prod.outlook.com
 (2603:10a6:10:553:cafe::90) by DU7P194CA0030.outlook.office365.com
 (2603:10a6:10:553::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 15:46:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BB.mail.protection.outlook.com (10.167.241.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTdYEp28nxELMKVVoE3rQLx4WEWQeoDG9DwCfNYpPof7l4c5Y86pwV9bXSjSdDGUloTVQGy7YYYwejijkD+X/mUE2vcdQtv5jX3KNknQ6Gxv/cbjLCnLdOcGTOK1gMO4BtJiHDKC4HQQnKcrS83BYW5a+22DMU7SLZpu6nqzE2o1m1fRGqtyF15glfKNIJYVRBFiOeCo0jS2OBi2QhiHTjBpw5XYFGQSrb2XDiC0wAOu2Bjqmj92fFaDirqnDWyKMwOxg3Q9MziLOzLSeA9HFxBrt7sYxCD3gb/YTJUbw3KmrLa88/pxvVZXrknUd+BZB1nN3Jwadsa30S4pfVQ4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuFgodGrt7B1kxPNqeVjHJn7cdsGhbRq0xT1NxwpJms=;
 b=KHimoxmuQHZVU1OsBUYpxtdEInuaK0Zom9JhTbck8+GQ5OxVqpWhMElQw0rExu6eov0XhPvRSgtyqvd+7q7MDmyEm0oPZMal8vuSo+TGQ7aVARSxC6cbrWfJFSjSinp2eQHAxF6GT8SkP0YwiG0XmCnQn/mxM9YkCBYg+0jaVAy4wXsQPjunNE6UwKPS9jXLCB85qk3/Hqc+cNeIPH/Y1G4UTYxtcEDoVupS65UJNjijOqIfz5bEnrNI54+tKLWCBKSlDI7SD3EhjXIj6+objOYAAheF/eonvHN/LDelhd1D0M1CmCs5jXkf3gG6VX1apzns8EtX6/i/VLZkZLi/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuFgodGrt7B1kxPNqeVjHJn7cdsGhbRq0xT1NxwpJms=;
 b=cCngm9hFL2BuaxIUXEOAYQYdQ9/lw+OVTsJyyDYmmj0P5O3S1KuORM7ovC0N2k0tJM0frqdaiT5E3WeDylIrcn/rPJ1H6pbuIxAkTfUYY3jTpKJDgOCFIyeeJoyHgGvxbPH4oQPIuZhO+kmBS7JZwzuV9EJhRur6W0PUTFvUDg0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB6231.eurprd08.prod.outlook.com
 (2603:10a6:20b:298::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:46:12 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:12 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] drm/panthor: Add initial Mali v15 support
Date: Thu, 19 Nov 2026 15:45:50 +0000
Message-ID: <20261119154604.2519184-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0646.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::15) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB6231:EE_|MAD0EPF000008BB:EE_|PR3PR08MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2ea911-bd84-442e-3002-08df465450bd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261026140227099003|261022105027099003|261022113327099003|261026121527099003|261102123227099003|261028144727099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: 9TQJoFAjPVooCyFuaGyR+fsluyIJ3/1twJ/kwqbWldcyKa4ZAgstK+UdbPgK3ZiitmjRYAd0ln24mSMuwmNVxhP/ZX6tF+cFUoek6cRphtHDY/jN4W3j2YwAWdNm52Pje2zVZV+7jE9AB4r828NrMMAvDldVj7+kROfZ4e7v6sFsHwlwZJ7VxweoQw4OaK9rV5fWcoHZfpVj2r0U0eorY9b4t/pBW4z9Tx6H63+YLlZd5ATZHOWhtmuapZEtQX5Uf24Th0KFGBnjN+ag1De4dq1WXATO4l7eOOqxAR/UhWxbQtiNCWwySLw6mt4H+H8VCgfjEFw0HrhNv1c12qxxqsEO4SmpEJLjkPcHKiM3UtQg7V1LvLxx7b7Fx+qh0bdhd7YNFsRA3WqIeuDFwXu62EWKgwBpGueaChuUvDvbnIWaTkS3lDO5CB7DKwswDZtwpyZf7GPwcP4BBj8zm8Zo9Ig39Gn2BCQK0V9IkQMM0g48zGUoVikVj6kbiVXf7STUo85BSSDmZ0arGn3d+2ogDB8ZU3ZWz5J0PQANjSdv9Ys3v1tvFgR9BRpYt7r3lBi9xL7xKOKmXtsCd7F5pYcNbechO3CVpvE0n0FE75clQyYM28Gx/xsaT3qy5buxrgHa
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261022105027099003)(261022113327099003)(261026121527099003)(261102123227099003)(261028144727099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: HghyQUlHwz3IpZqfDC9osipjML64Kp5RFjPtMzIMsc708rY2MVs0w2I1RX8ZrAmvZ83KZFJHiBE5Sh83Ybvw4x4DRr9lu5iGDdCyS97s32XxIIvNBUftup3uctfhVkKPAEuSDRC8GOcmqvqxWqhtyIIUXBPrMX9JnsvCKZZItVhBCh0TBq5p87lE4wimHXJ5643XNO2+OiI61ow2xGpwd7FAQQr0tOj2KiKEB/8NHx9fIK6fOHHOzuuILtjdigMSwCoLOg25Pksc5JoqLtwJzsXBnZ8StkJbCW4k11ntmHnCeHI7ZgrMp8Gf7idzw/t+IE9ttkMeLuicH/MprOMsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6231
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c12b5046-51dd-446c-b016-08df46543d1d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|14060799003|35042699022|18002099003|261009223027099003|3023799007|13003099007|11063799006|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022113327099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: e59HTsTKmJtq1RJWstbXIrqnHvMb78ucfQe6iF5/ImBlcQxHDn16NamLVGO+D7i1rT5u+glEVsWwGeiYA7vQFX4jfWl+t4PVFEtSpQnJtIy9TAQs/CIqj6I1SJXu86Oi+n/kEVenGC4DBX8MIfsr0U99eZB/q4tFYXqvVtZGiiniq6nXHrtbxQQGu8sUs015bnvpeGlCXdr03M+m9/3dlm1TajyVM7fPXhollUOFuVt0HZpLFJ8Ej7S6AUpJGHsbuqD5D2Rw9xjOmrGLq18IT5+xADqxOHMKu2E4RXxRUTymTr0A54OBuob0sXVVpcrnQr1NF2fvyRSsJAWAzeTimRnwKWxn+a7LyEjkFANwZlSnzzqOarSQgSf/lA1wcE1vx90aCQycQpB92un0Ot1Ta5vPCS3mAEmvr1ZO/HnWL9I2YucR3K2iFHWF4SjYsloDaxC20RyXOoczyb/QRavGuhyRMIMbrKVAxak+9qgFZFeMXCPV2oolcmMiXYPmtB6h1Z6E+4tkXolTNSAEttwm8+wcKW3ovBvB2Xp4EzxcAy7biBV8dSltFa16/prRe0lXPfRGhE3XFrXbKf+dBEZGhkNZTPaa2KsbDJB4vwywpJ/fNUA2bNj7eyrUfVXYrzhGGWJ/HNt1dgpkZnWnbvt8qhvVQ+S0B+we3KGwJi2sfjE=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(14060799003)(35042699022)(18002099003)(261009223027099003)(3023799007)(13003099007)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022113327099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P8L671pw96XWP4A9YRd71Ljt7SYzUorTDb+avnAv5746F6tg9DhZGUUCGnVmhWbPx/Rlw+hB7ZEI7O3Lqsyb36P8lRBr7iD7VOy8UNZTPohnQo+R+XszlHNx8RMzAkV8xcpDMQ42D6jKp55mUTZMtPCcqIa2mmtym3H0U6PBfYOed1VC/1/hm983t+qL+iBxsSeJO5pihmQD0RuXZA7Kn1QmsLGfzENeMtkAOEXohEiVRRPq6TV6hNPOQ16GxCMMgDAgvbknwHRApW1MTXKe5mq5kt544g+BuZepZ3Onr9FiE5G6ZeebQLiWRjhsA24F7BM+jq2TUVFumkHdu/otfUphkiTYyqjctu35wr7+9ZieRW7Gq/+BkZCkfAcfdp0M/Cd6iPV8xw/5HXPF6RNztsrHHcxwXkOz9bjnfVlTQZ33eKVjHKd/wyqoR0TdDX5B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:46:45.3790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2ea911-bd84-442e-3002-08df465450bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5769
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series extracts the initial hardware support from the previously
posted Mali v15 virtualization series. The remaining virtualization
support will follow separately.

v4:
- Collect R-bs from Liviu and Boris
- Squashed 64-bit GPU_ID decoding [PATCH v3 05/10] into v15 enablement
  [PATCH v3 09/10].
- Defined devfreq_disabled flag panthor_soc_data to disable devfreq
  if it is set.
- Link to v3: https://lore.kernel.org/all/20261118175332.519657-1-karunika.choo@arm.com/
v3:
- Split out the initial Mali v15 support into a standalone series,
  leaving virtualization and arbitration support for a follow-up.
- Rebased on drm-misc-next (fb191ef626555)
- Drop the $nodename constraint from the AM GPU binding.
- Require the arm,zena-css-mali integration compatible followed by
  the arm,mali-gen5-am fallback.
- Update the binding example to use the new compatible, three-cell
  interrupt specifiers, and a single GPU clock.
- Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
  is unknown, as on AM systems without an OPP table.
- Fix the missing blank line after declarations in GPU_ID decoding.
- Link to v2: https://lore.kernel.org/all/20261110153907.3241978-1-karunika.choo@arm.com/

Kind regards,
Karunika

Karunika Choo (9):
  drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
  drm/panthor: Rename neural accelerator feature macro to NX
  drm/panthor: Move register access helpers out of panthor_device.h
  drm/panthor: Parse and store GPU_ID fields
  drm/panthor: Move register base offsets to the HW description
  drm/panthor: Derive MMU AS register addresses from base and stride
  drm/panthor: Skip devfreq when explicitly disabled
  dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM schema
  drm/panthor: Add Mali v15 hardware support

 .../bindings/gpu/arm,mali-gen5-am.yaml        |  89 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panthor/panthor_devfreq.c     |   9 +-
 drivers/gpu/drm/panthor/panthor_device.h      | 105 +++------
 drivers/gpu/drm/panthor/panthor_device_io.h   |  84 ++++++++
 drivers/gpu/drm/panthor/panthor_drv.c         |  14 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |   7 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |   9 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 ++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   4 +-
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 202 ++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h          |  61 +++++-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  47 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |   2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   2 -
 include/uapi/drm/panthor_drm.h                |  23 +-
 19 files changed, 580 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

--
2.43.0

