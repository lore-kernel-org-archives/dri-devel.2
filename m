Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dY7NyN8W;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dY7NyN8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C7410F138;
	Tue, 10 Nov 2026 15:40:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B610B10F138
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VdkQlaVz+uNtIAS6jsB46QtGu8HtIWax4/3mF28CesSl0UvSRgJo1QjVg7TufHoV1GzFh+b21Bk/SNnvackrmoPInb5M4/r3KcEiXN5h6stGbXQSd3Iq7DQzJrOgI7ijbShRuZ5VfdjM5aILAU9ceUQ/mA6mbpTMeo4jMyLE+ZzIlrFqqFx2Ix7kEBYchXgMZl41Fx2JpoNkXV7Lnf1uHJvjYH4gSasWBkYCfJHXXLIVYytRxTxF2V1agzaICn/Coh9PRjsle1yLXRoEQyA4JMcRzQ9NQLm7QlTDu4jbqQeXPITCh9ZzJfKo2V2XoFpVfobMDlvfulUPS53zz2snuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=vLhd0IfW7RJ7wsEiJhKT5COz9Yk9tlZ7rEHao5fBND0TGbrQ6ql6gRWSwu5l8FvTJdpCNNFl/QktDtd9fRIiwaY3mD+TCCMyNowJ5I7rTRI7BqoOLU6GJ3+kJyrPY7a5YYa8TdcHRCeyAP4uZz8LwXhP2PF7vuTq1b8wbVYFXWSrzplcv3RwEttlzeF/l92sUcH3JY59SYVWQT2Fe2ziaALXx54EpdYDmiywyYq+qekOgb08QqCF+lh2jqzYHqwURcF+y4YhX6RFlfRCqRMGNVDC4w0OcaRgD2ny03q9Ha7RO/UrIooITtS+mIUMTvEgWAxiqfDnHMdOz7J3cbTAUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=dY7NyN8WF2fPhIjqcmPq657oZ+59kXzpyoi2JUszMjhJoRodcFyA9V5xULHs+EaEwLIYZhheuTpEGcOrnpWhsJMyeBribNdYgm2zOJsSQZkelJrdMWa0OVXzkNn69lPJKnEIwB3ZalOqVuzbHXAhWeckv/U09MbLmUTh8vgcepE=
Received: from DUZPR01CA0323.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::24) by AMBPR08MB547813.eurprd08.prod.outlook.com
 (2603:10a6:20b:7b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:04 +0000
Received: from MAD0EPF000008B5.eurprd04.prod.outlook.com
 (2603:10a6:10:4ba:cafe::9d) by DUZPR01CA0323.outlook.office365.com
 (2603:10a6:10:4ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B5.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsrzTq86l+vXHK7MsO7u2Q8xTVf79vYOXaURf+0SEGHlKgf7aIZOl98Q1JCAKgWIDLdSKBsWch+ql4kQLGT2h00T3bx89hQyYob8k9CcUCIPJHNtS7jY1/Zg6mDNxscqdZTE04/6fGdkBL4pq6/FuRFvRPksrV+j/WQW/VnMMgbp66M5DoiZV3mBXJ58cPjuEw/4D9IAVj96XpfCuhcfXNYFtIfZLYsWkm07r/+x9DYaE9dLTgUfwI/Y8hzvG5vOJtT6dYNi40n9yxNZyFezZelb3Xgaz2HT5vysMdr91C+qrXRKrZxP1eiYKYaGygokU8ieiOkXita5YqZSpIQ+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=SVYR5+T5da35EwEfBexCDGQoqO+7yUkZb5T5jqoixESG/K9u3fNIi3XQ5WaM6D7nh1FYFENeQijoNbU3IJ/Q8FKvQk23FAXoSnRo80AjIZq28kny7xj622RB6Pe9c8G8LWFHd59wivcJ3hYlMJMAqoXHkYmqFGvDIpmrhb1jVV/7jz/y95BCRN5FhZybR1URmqfDdEJ4vV3w6mOxzJncfHjIGvdtMUGLUpHcnE2lpP9TvyqVnWNQ6GwbELbB564m5LphHn8QTE5X2Fw/ep5S43r+GIiKrMNcbeLUotY9jTyVv/eN6Itg0k11fVC5u2k4BLGAk2+ca0mqhKDj8zrh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=dY7NyN8WF2fPhIjqcmPq657oZ+59kXzpyoi2JUszMjhJoRodcFyA9V5xULHs+EaEwLIYZhheuTpEGcOrnpWhsJMyeBribNdYgm2zOJsSQZkelJrdMWa0OVXzkNn69lPJKnEIwB3ZalOqVuzbHXAhWeckv/U09MbLmUTh8vgcepE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:39:30 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:39:29 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 01/28] drm/panthor: Ignore -EOPNOTSUPP for shader-present
 nvmem lookup
Date: Tue, 10 Nov 2026 15:38:22 +0000
Message-ID: <20261110153907.3241978-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|MAD0EPF000008B5:EE_|AMBPR08MB547813:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c6a9e0-e231-4366-5513-08df3f40e356
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261021121427099003|261021123027099003|261026121527099003|56012099006|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: GSFmVqVaxW3FdkWrFfwVQwpS0DZHhrpLO/PIUinIYNZzc333nZp3mC9vAUaEothv/geEe3ukNZhsvikSrEbwuF8iO0TfxHHiN4KqOaunH+7znus8ecFOhxmv5YOinnuKZE+gFx522KCCCk6vImCzBp4AS97A1SK8Wcd0NHRYk4YAVOeavDXFxQ6X+6BaMeclwuFX6L8zPb3xNUB5UT+IQ1yYGcMbSQSQoid0KTX5OQ1VMNBvg1CQNKPyfDYTlMn3WMA/EWufCj0Ax/nqNyg7uRJPl2xk5+ogTfJbGhxn3qsAb+25sl9bm1hNEQjbofoGUckLoecc7HeTZIfMJUdQStO3YFCHvn97sPvxTxfbgnnt2Ojv1OWcbhIo4LouxCklsIKptqApRZRGhTIMRJsK719R4jBqjmhosolJG9f6vvpM9g2iOukADSzY4i+J3yAfIcTbzulaIXsqLRXeXDsGF2rjazYApRdCfQZfM9N8m+WfCrk/F6hwWQDQsQnbbqA+MnUFrWQFliNHCiUdaTS1KSGDIuyEK2/jxh5gTP/egC9Ydv3rs/o0eGyMfgJAYpWarDOWt9ANP/cHJ3nTCE0GCGQtVtY6ANj9VXkHWXdNhgcWBP0szRUoQ0Eu2MjfSUWyhAfW9SoN+fEkh11WxPEt7mv7Bjavqh/IVYo9ztkZd8Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(56012099006)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: rFA0POWvFtmQPZxoNb6NEBTZc2pwSrQksZmFWoei1V/+RjIQRaGk5mAeow8L5W/q+p3cihqqDKqvDcr72JiHBvNJE21ysDDBUqB9prGlwCpD0xrAB+4vuyYiDBTXCYIjz0EaP21ZmeQuV5lQpTUHl2ARPYRA0hqR7QPuax8WpkCrWF/WhyyKW+K55lqIh8cX7JgW69wC02aq2zBYzktYNhNB1vuXzz7LBYCVKUyfge7M+8PDqE83Y+USGw4Uv4+xlWn4qWE44wOak0givA2kgKxf1PGPZC0DVWSvUiS8l4NMqhnsorF401UcbZM9CiWh9y317Ge9qrQW0QAoqmUo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B5.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 709eb3e2-739c-4d8e-4e11-08df3f40cf29
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|23010399003|35042699022|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|261102123227099003|261021121427099003|261022075727099003|56012099006|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: SnbjFP/7TiFzNeZjL0AJoLJjmziIHoFlWRLBYOxCHJsev4hPu9L5gbt399KGepg9+z1mebOt1gce8GTNAa8vJPXzA799wEW4nE6PU2rB+QPfzYtM3gkHw2Zxzk918CUSd+37Y7iVPdche4tgx+YalvoMGryAVScJgtde3bPUL/pd0Auh0N1sqcK8hgu/KwOgRVu5k2SR5U+ko9mTgCi7VBaBPous1NNUYK413Zv3esPvhtUZdZ5Cm4gL6XLF4/Yrufo9U2gucNAso7SUwB7XsTjBmzb1Qqpu0oWnSmmJTybCp5FmTMx7vziAf3osjLD3DrAiRrGABqTDSRtxeVjyiOc/vIgyezEeF6wEBXPQJupf5eq324T3vzhDnIif3a9VOfye3nW1LeI8/mM+SgorEHvRIb2Xx4+TMCdqSb+hzQ4JqZFutb1crUAvkFe8uUo8m3JEm8RW/pX0JHWzmEJKxJJ0x07eNJe1QByXLd6zVNKRFJUxBOcZL3Z+edHhpHnWtmDyjoZ2eJP9ihJKoHJlde3O7gHdLvpNqtl88TN2IdUIKSlydaOrbdfeqjrQyXlkyv85X3L5NtS4JgoXbXbOWXUdGusUX+5o7StalvShjZpfFQDKUnIPrzav47Nx3qbC6kbPnckLOLR+c65dymYDJqP26XmwdgrjP0X9TdqSIFlsLtC3GK+Cwnahk1ik3ExFqvtXrUZ/tyDK28RbgKTe7w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(23010399003)(35042699022)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(56012099006)(261021123027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 83wNLjPMLAFyxZXUogMuheecAfzBN+Ri7ETc2H3AzuFVGlvs5l3yzpwysyrKS6madFU/zKOKpF2rtfTqBy1f/MK0DxBMrEYrXIS3Vmwq5Lkx2Ivvbb4CmxuR1iVpg64PO9kFwDqU2324zkEvA/VRB3zScbTkUhsbYPIvbH6aaegrkmN4aFzTMvKiEJUcsjWA/nxXu/LVAqUM9R1TvIPJTXqPs+fZGduvMluxctoTvapU6RLP4ZSgIVu0SHbqupy6yXpMA4ZXWU/Fumlqn3+UPWfg9JIyc2y4GuCtWN/9A/W9tJpi8d+/T6HAU7wCYmNIRdd14ZlBe3wuSLwC0d64CY4j7c9IbR4UW8u2395u03zE0ec/2F3VKDUkzT2rJ2NTWknntKz2UpnrSUx+Otw9CjkVapY8e/KZGQ0MrpC0sMYscZ7n2EfekkrY+yf/ew5/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:03.2830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c6a9e0-e231-4366-5513-08df3f40e356
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B5.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB547813
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

When CONFIG_NVMEM is disabled, reading the optional "shader-present"
nvmem cell can return -EOPNOTSUPP.

Treat this the same as the cell being absent so panthor can continue
probing on platforms that do not provide shader-present fuses through
nvmem.

Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from nvmem")
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
v1:
- Picked up R-bs from Boris and Steve
- Added Fixes tag

 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index ea1e222ef1210..34dc4b9d9dc09 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 					      &contents);
 	if (!ret)
 		ptdev->gpu_info.shader_present = contents;
-	else if (ret == -ENOENT)
+	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
 		return 0;
 	else
 		return dev_err_probe(ptdev->base.dev, ret,
-- 
2.43.0

