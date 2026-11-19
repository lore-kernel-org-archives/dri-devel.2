Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF26606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=drcMbsMF;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=drcMbsMF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75F91125DE;
	Thu, 19 Nov 2026 15:47:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698B21125DC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ub8N07rRjZJwdN/FoGmkb4KqUBdx61dNcTL+AClVYPlb/FmpCiOhflpelHWj5zpJy/HnggJ0Z1WQemmh3WQm+T9ePKc17f//k+PHivhAYmngc1eoXGeAh1nJQebOm5w9A4SVtmTUAu1O1G5mnFFkcu+LFtRiDEDt/yfYrSwKAI8eQWSjAUcoaFhlHmZUjMGi1Pnbiloio9cVBtuEZY1ywQfIolQiIT2LXN/ShbDDAsmLwgp04ugOYJp+/vP8xEPgg1jQJI0guX0CDISGW2z/flEfbWl9ewKS8pe6kOE0Q3DIrJDSD+iSWlDY6e82zTNeUfHzDIfiI00RsDJbFcOmyw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vHP2PvwFlf7d4Oyrs5KSVIqSPeaTTGRjHX6hmij83o=;
 b=lF2yF1JVcx7YLgDhU0j5LojOMpjxxGhJRNpUm1iYrv/i+WR9snmI5+ngwcfAX8X2w9ec8o1XW57UMHnWiFKdap4xt0GNPH/9r9I2h8NJBBX2Io9UilMpMM/4Zmy4QejGF0w9hLV94umpvdoizIgPs2dS+oh81+VvGoNAA28xu3fcj+O1UDkRxJJ22nzSQJjL5Mh0oES8ObLnV0j/Q4O5CP7kzfop//v3vkB1/0KiEqEcUlJslkXdyw6ryF34OrsHXLvp2CntYGHOvTZS4MPWtw/H4Sn+gXi+kLZw5mH2ZA/kVX0PnIg4KA+N9eNzfMNemztkuCSM7+j0jE35NS3WBw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vHP2PvwFlf7d4Oyrs5KSVIqSPeaTTGRjHX6hmij83o=;
 b=drcMbsMFN4ZGWNapl7a7aBR0q7LmemrjxeFEp+6DimviuckNuiVm+r4hPFMc6FlA/tLn1tM3VegA4LYD7wRKySOATBAjH6qizov59T5h5Q9nGvRKNOfVjoCnpGRA9wl6R0vx9KjuRPHYXWEgHbTzVNJ2a83Zi8MT1c7wME1SuMc=
Received: from VI1PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:802:2::20)
 by DB9PR08MB11339.eurprd08.prod.outlook.com (2603:10a6:10:605::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:47:30 +0000
Received: from MI3PEPF00008493.eurprd03.prod.outlook.com
 (2603:10a6:802:2:cafe::7d) by VI1PR04CA0049.outlook.office365.com
 (2603:10a6:802:2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 15:47:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008493.mail.protection.outlook.com (10.167.240.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzbkjHohRMPQaUTzpomk19A4nhs5Q0ULV1EhIQznOi80OHKMB+jIZXfUUG5Ufw5wOdphedDmEib32I/CUZeo/tVVHCaPZMwhgcl0/VEWU/Geo/Z8XCXA32oGtr9SfRGIa0vB7Fxw2iI0IwkIUUDVAQHxLGLccJDg/Xub1ybJCX24sXHTORAj1jmT3yzBUB/2SqMnuFRTD8LcSGHx/q6INLQPTylvvyCbnlmI0MKBJxIB4YL+2X1HhJq4IMUtmC0ki8SBNcgQA4YRN7/8UIwWQ9tkKuiG2W3qjbr4HDoPiPkoQpbos5GFBydtTca27+Qsb5RLc3kubLwm2R9r5XeH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vHP2PvwFlf7d4Oyrs5KSVIqSPeaTTGRjHX6hmij83o=;
 b=LuAe5wpDLCAm+HXSiMLK7coo72a9V9cKyZ0MKPBZO7X3ML0hiPP2NtikkuIzaKuBUzeAQaEct/l/cb4zSQtC7rXi3yE6HgiRjmhG7djrEh/l4raoW6HE7WwnZkshBqT0NRLbwLTaKh0+OeqOkjWVJBHSdnS6AL2gt5fxobNNpCOjqYb0atb4S21Y41e46bTvFx5UMhFs0s1cA+QXDsHVjFbfV8SWXscP7v83Hs7j5nUXNjAV9c7iOABCz47pEzHXJDquNOjXMVCEFCgIz0O3Qsth5U/cS76+8MtByydqVLpA/pCCWNjWSyE2btWR57x+6s/wx8j3sueHY9WllTcUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vHP2PvwFlf7d4Oyrs5KSVIqSPeaTTGRjHX6hmij83o=;
 b=drcMbsMFN4ZGWNapl7a7aBR0q7LmemrjxeFEp+6DimviuckNuiVm+r4hPFMc6FlA/tLn1tM3VegA4LYD7wRKySOATBAjH6qizov59T5h5Q9nGvRKNOfVjoCnpGRA9wl6R0vx9KjuRPHYXWEgHbTzVNJ2a83Zi8MT1c7wME1SuMc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:46 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:38 +0000
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
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 8/9] dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM
 schema
Date: Thu, 19 Nov 2026 15:45:58 +0000
Message-ID: <20261119154604.2519184-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|MI3PEPF00008493:EE_|DB9PR08MB11339:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3789c1-8746-491f-e652-08df46546a57
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|261009223027099003|3023799007|56012099006|11063799006|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: lyIH5k5bbTGlC/o+JLoLMBjXeE32FeP0mJyG8u6ZRFw9+XYQ+j8v7JUC+76uJq77tTdwgwvArCnS/oMqQCO1tIerCZhd6ck67jNa58YnEATnftANMmayw47baPplNcVDGH2592VqAaVO32dvVeFU47A3tcTL5NGBoAbN8opyK+TpbJ3OFG4qSYz5rv0MQe0X9gyYQyjaF1W8HObhNVOgiCpYi+QqjTZV6Dbr8gJXM0iMAhXjy0TvkjfrlVV2DDL/tE9TDxJCYD5LRuJpzwkpZyifIT2VrtNcMnct2DeU8AhvVwU/pgQujA+/Q+YrgiIVpm0DRXEaVjwZ+uwaw8PbnJqMYMSPpkgSViWz05cnR7Jg5attIMbdBM2/w275vPjOYZ05/HeJMW0HTFs4UyBksrbi7VBjo8z/iWR2OB/0sKl4XJbFNMdDRTGl3tDmz0XSYf17qCsmo6dUKy+nqJlG+x++ymQkSOc556ZgsUxuUyXqPGIBcv96OF5V0HpGnHeAlJTSj4d+Jbg7mDmrLipO8WThW7tBvSLGxKgB9ZQIitzH0afFRg/SYuHEuvaey9cjtm+R5g9f0zhmjAIyo+ISon3darB0d9A7KNQY2nEBZBo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: q27vD7BATvUn+igzyzSm0Lw7/V1BOc5Jook0W2OPzUvzgd55NftmQpGyOUxYdBu2FbpFEPbU5hjhnsknA86xh54zGcKdIQ9XZRkb/yLPcPNP5//ztSTm27w0p2pEZQT1cHXyhgHJaM0nig4onYU05zMqBzve6UZQmXgZn54bcHmOVJB8XeKADQ8D4X3d5arvek58kQ0Wm9yPHEtFpnunkK7MsZNX6xqxrNivpQXhVXbAQJQNj0xLKpqSuQszsFIOoGxtk2YM/OlWrDzxFFoTiQzVXQHtP+22R2BomlfQs6ccV0QXCtN9rJy+0rFTg5eaVYq0uh415VancUWoWrE78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 28d6366a-689b-40f0-8bda-08df46544cba
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|35042699022|376014|14060799003|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|10067099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: vk1NCnrHNyCHAntkylELQbn53XcFiSdQUcC7odESaAKk4cYoWlDKSQ1Y7GUsyr/wGquDy1DzXitTzluLpqj0RqUn51JBTUqDsDC8Ps1qmpfZoTL2wvVBZPVYwYGL8ff+wqcpr/ChSzZ+0iPIEEohrW05yxAI+QCpcS5+hSoCxu3jQM2/ysLxlEfgbLlAlP4+pNPPhaBbnHMXyfPwmte/XRp9NJae4v1z8XEysemCLKb5hQqpDB4kIAs1jQ46B3lxVR44Ntzj0fqztiGJq2bpIGuw8mVTaQ4Bj+pRJ36jgg/DygWeXBDN+hVdJQBssFuNgvCxRB+83fPUheffZh9pWfXA+NLyTdEIp5wBHernuR7bckfVPOCuWPyG2UAglC2FKvDrcAs53xRnRF6ODdZxmQvoxt8X6oo5wMH4TdWgn5KvN1RWbiiKd+43wspt6nv+tPBCHs6cyLPnNmDJN5SIytUlZFkzBkpDWIY1Xklqw/t6ie7D/hs8OCDz7Bv6f1eOIBoHZwVIhXsYSDPpBuGsFloYQEyMpTjo4X0ltaNQjgZ8AfN/VuLHMtcjBbMSCZJQRq7mkaqIM21mwd2isp9Wb56UYHnTIKUk4YdPBhdNTgUmnpuJ0o/vYXwG/fFagPb6k8PTs5pmCjvbbXNXB8rKUA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(35042699022)(376014)(14060799003)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KL//x0z1iNZRDzcecETbFsYP/o/sBWS5dMR5utS1BZS9llFFHgvaXr7vxJKhi3jZ4EYnCcQ2zU3kcev3j+Cr0GbecdloWTF/qkivr7vvMAdgvUyGt+IXS54CuEV9bfyCPJgFgLa2eOL7x+85ed3FSRobARq8UIhEGVo04/S4xYDqybFgq8iqsOLhdO5wx9L0ZdLWnntjHJIeyy8e0apC8RFzy7wH3te21FfeI1dbfLWU52uhIyGMsm/WYdh/okvlDQj7kJNbs7jvaROUhcJXLYyDhOz6AHuFzC/S+RNuAt2CTOKGLoMBX9Q8Loj3NHtmnyukKSnGbKZwYHTATdu1GD7yJb48XTWo7uJZK8izsDQ9c7SebKZJJGpqYjZgIuw702B9rqMbxHyaahPMtBpIGspOU3q/15zg9ScNYgI6jX5X67i/JvX20Skh/wQa+xyO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:28.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3789c1-8746-491f-e652-08df46546a57
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11339
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

Add a separate device-tree schema for Mali 5th-Gen AM GPUs.

AM_GOVERNOR controls GPU frequency. The GPU node does not accept OPP,
cooling or GPU supply properties.

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Pick up Ack from Boris
v3:
- Drop the $nodename constraint from the AM GPU binding.
- Require the arm,zena-css-mali integration compatible followed by
  the arm,mali-gen5-am fallback.
- Update the binding example to use the new compatible, three-cell
  interrupt specifiers, and a single GPU clock.
v2:
- Move arm,mali-gen5-am support from arm,mali-valhall-csf.yaml to a
  separate arm,mali-gen5-am.yaml schema.
- Move the AM GPU example to the new schema and add the interrupt
  binding headers.
- Add the new schema to the Panthor MAINTAINERS entry.

 .../bindings/gpu/arm,mali-gen5-am.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
new file mode 100644
index 0000000000000..af758daec2aeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th Gen AM GPU
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,zena-css-mali
+      - const: arm,mali-gen5-am
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Job interrupt
+      - description: MMU interrupt
+      - description: GPU interrupt
+
+  interrupt-names:
+    items:
+      - const: job
+      - const: mmu
+      - const: gpu
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - enum:
+          - coregroup
+          - stacks
+      - const: stacks
+
+  nvmem-cells:
+    items:
+      - description: bitmask of functional shader cores
+
+  nvmem-cell-names:
+    items:
+      - const: shader-present
+
+  power-domains:
+    minItems: 1
+    maxItems: 5
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 5
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@100000 {
+        compatible = "arm,zena-css-mali", "arm,mali-gen5-am";
+        reg = <0x100000 0x480000>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&gpu_clk>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index bcade5bfbafe9..93ee837af9958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2404,6 +2404,7 @@ R:	Chris Diamand <chris.diamand@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/
-- 
2.43.0

