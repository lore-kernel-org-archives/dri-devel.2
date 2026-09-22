Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E03C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED29810EE55;
	Tue, 22 Sep 2026 20:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="glzKbpTt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="glzKbpTt";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCFE10EB92
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:20 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GsNz79qNWHhUhi1ofpuzx0CiCn1SSAwoSobSHIsGVlldBWFcI1IleVVbrq00WD6WOSR9GmqficKXt2rE2N5LI1Nu0gt7gqiRPyEWeYc2bBu/V8VwfvjMikyw325awmviEx58wF/sdMBKxVqEr9FRMOymzmDwxsx0ZCVYFK/6i6ORaGLi1EIphJyHZ0Co9g3PAguY6s8pVccW5Xfv2l98IarAzR/MsYhIETpeSa/9LW+xg1aBqONGs4zqNf9SHK1CNzRr98HcfGaYyDY2hBfEmmUggtDJgjSzzCJjHIG0zXZdP8atvbZurn5DeTDhvXw5ri9PwNgi/vDRI5nkJRaFiw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8bdvAvRaA37by+SOu5d2U+q2CF5pOPbCZRkDOAF7YQ=;
 b=cDpCsVmfzuLVPL6Kr4dzWpfCEqQIFbMXBnIivBjccFMcqu3sPcAxGVGqB0K3m0n6fEky7Wh5GSH0AfxOMrCAt4GDnierbh5dNLJi6GU+TKa2Ssj7CFDK/VQhuUvjMjPSXsv4j8mxlw06gq0B6PavCj/3aju0qEhws/13NEvqJ1xxrKAZSK53l3z6WqPCh6O3Q0z/LWKX/O+GWE/Z802dRjuwkV1HUQZTB7zvGREkgLcDdzOqD5MUtlQ35Jjx+IEwSmZyetr4NcIWr6egjz4oZHkpMRzKhG6o62U11Web6DF4oEsBx9wGD1wRAQSreS3l9BCcEc5CIpDoZmv5hehkig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8bdvAvRaA37by+SOu5d2U+q2CF5pOPbCZRkDOAF7YQ=;
 b=glzKbpTtCEBf5tqn24xyvxNCaBDXPdCqvfeDDpf7WerHMaloRbnrMdXRodidjqZ3VwV4qGjt9gB76kbb7sT5TDwWIFFmf5HeRnmunBFMIv/goKyjN5otHoFh+YWgvqi1zEmqpwQZCQSHF3xuZG90AXI7XTm2mc05hJKhAS/PLVE=
Received: from DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) by DB9PR08MB9444.eurprd08.prod.outlook.com
 (2603:10a6:10:45a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:15 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::31) by DUZPR01CA0010.outlook.office365.com
 (2603:10a6:10:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 22 Sep 2026 20:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG48FYdtTU3kCsq6dXiMs0gBMq7Qw/IQZvmMZytiMMDFM9E3q9ehQC9RsChxCLnoID+sm8joqvJ314O7nOszKO6yq3k+EaZysqxCjJavkXENZsTvVyLGhQNGX4xfeQCS8/cLB4BrkfKxZu6Ti6YgBa7WSqwaU2oYNYMl36vDD+kATqrEk9pJ1e3M46A+qVNEOEqcK6896A7NQnivPRDjNouDtcj2C1QjFUZvJJ6ba3/qRclh9SyRkrQqKx0JsUMmpkRc5huM/5odjn2wiY8F6D0pfbPdgjLuuw/MNsS8VEgLKEwQTA0E06+9cbnmlDmDjLpSKOW6lJiHfIgMCUYOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8bdvAvRaA37by+SOu5d2U+q2CF5pOPbCZRkDOAF7YQ=;
 b=rj69qiOmHzLpHx8q91glmwVObmcqDBfameZrwBlFfeLHdf5CJy1T72z8D2oJ0wO6+CiBFMr+gW39enScCMvAlvsRMw57tUQVyKP1c21euYCsh/kj7CSkc9NyFNWLoQDcjpujflkWN3SDWt7wQCYgM2zVQKbi+v6vUM2pCb+NcvGuUlTaiLrFWwAHlloEUnUlnwfY3gUkfGHv7Hx49maoer2IUTjCTijRzSZ3IjEfvAz0Sl3ogSg9Km3DfBzxhqJeAdTiKV6ZAJJeCxkOAjCI8r2A/GThAT22oJBB4+4YVWIpPBzpsp4aLiUSLIXXUvoECNkwZVdaIYJ/ObYAd1wHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8bdvAvRaA37by+SOu5d2U+q2CF5pOPbCZRkDOAF7YQ=;
 b=glzKbpTtCEBf5tqn24xyvxNCaBDXPdCqvfeDDpf7WerHMaloRbnrMdXRodidjqZ3VwV4qGjt9gB76kbb7sT5TDwWIFFmf5HeRnmunBFMIv/goKyjN5otHoFh+YWgvqi1zEmqpwQZCQSHF3xuZG90AXI7XTm2mc05hJKhAS/PLVE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:43 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:43 +0000
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
Subject: [PATCH v1 10/27] dt-bindings: gpu: panthor: Document panthor-system
 bindings
Date: Tue, 22 Sep 2026 21:45:04 +0100
Message-ID: <20260922204535.2850094-11-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0082.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::27) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|DB1PEPF000509E3:EE_|DB9PR08MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: a2778625-8cae-4414-2563-08df18eaaf60
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: WdZwuhxdE18ln4abmd2J9s69ZeWK213pI15iFI6Jsnge73uxtDrguYReNeKoFPhMyEV4pymFALdQBT+uPccCZ5/0lpPzl68UwERgmyfVPDHC5xvZRBATyWGr4CB97eYkrT/B4Zmb7xeU+D1+VVeHkvtZxRT+e4CVcn7f/U53A0Za+R0w1y4EmUcvf1FU+4j/S2bi4hIWKeWpR+3tWQLyAB1Qtv1hJ+ID3UMukgQCynpqapVFLgmIXXaJVJhCIXGy8tgspc+dL2NwdN73MW7X0HAQV0VOITlcaSFNL7D3KWrOW7Qn+vhFfaAZEbXoohlc48d6LbVgpxiQnvpRdfnN+YPF/H9uY8mIH9EudkLxpPvlijS5uYkNtTAXZZLIxNrE6Z40Cq0I70tOL4JgtFkda6xQ1SiGI7sPd8IKzdMULoosRB2h+l1bY9STMSRoN+j1tZ4qHKwCYowdugjbGtU8COO2k4X7V8LZUIZyeDRQWJ08hj3rC5yCXq6VDnIz93r/0UGe2O5+B40nbpyald2N7AoxlKvgEVA6TXbyg7D4XRxuTmec62Yi7EJ/VKeRtEhnLM9X9ZosNGdJo/GJ9se2BZNTEPlm0vRlxOP/LWO4meKVtFrE/YmYqxBxZTRt2WmH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: o1Qs9QY1kHhly64iFh1jJ5geX2rUAFIMfdxJySJTn/nm/fTJRkUNY/hHdcOw2612vxDRvJD0fvz0rzIs+jWIov5p3hdgOvRvoiokVJMSpTtuezSbKP055R+EqDggQEHxyu0MFDUVq4pUzqNbh7at8Ikf1gIrbcpH21Iuxnypy99lz0xoPlYMZQxkJYdnGvZ+lA/fMZqBF7SqP1aStaPdn9HYfjHkvxYhfAs9oqC4j96PryadRJWKitNNRh+qV7qvB20XHsxrBWo89QDIspiV9fcslxPRaBlZMOXRI0IydN5AA6Te1qpfkPioDbQ4R2ObYKe7er0qiX3SvNRvd6SRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7c7c367e-b2df-40a3-b39f-08df18ea9bd8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|36860700016|7416014|82310400026|35042699022|376014|1800799024|10067099003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: cHNNTnV7dS8LLkRAhiCIPUMuuLoPc+PfSqBl4zXG6HIu0rZ1paXHu9yFcpHdxSdJ1Th+z8ovRNEVH8mpvcsGKB1aIOkJ9mf9yyEDgdpVoUQxIhpcfEGhHM9hwHMdZAWlVC/nhty+NB5TBeDet7cMouw3PpaTYZEk/034J19ZH1jVkxdQJOF0gc8OgX7t8m8peTP/dgXMdFL5z+RBSplI3ZahMct7XOxBMKYT8Qkk34Vb/p7u/xdIch/jSvn+ZarSvLgGe9vY/IpSRP1sGvqkxSZ/sVgyk3ilRDV2kpGyCO3ALSvHuntLtloeghWGOYAh+BoWUPvn2Zwzb4oZJvX0QPv3QPK9ExLQdkY9nIihhWoYFzz0FDRJN325XfVJkapCdP7j06QLb4YFzHBFpAOvZq/FlaIcn4conN4jd7PaIEevu28KNglJqtxZ+gGpQX2j4GP1z88NW8dKNLMzr0hG4x0OP83bS8ESXA8Z7YlNxItMM82AQBiHXolxfeL6bNQOrU3LVISg1oWGC3vzKcMW5H07ZSY5DD9BMCOLBQyjzJY/LmoqZaiKXYysomadCgGtbLdSmDzgT3OttuAYqGcYQ0zHDNujVuTU3beAQmlshtk+oJ0ClxCEYlhudmGXRUBiDvUmZffX7wf/37S7UZ2hTQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(36860700016)(7416014)(82310400026)(35042699022)(376014)(1800799024)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x92q9zutbqGz4IznkdGCXecxr4D+4pNacqHRpX3LU6KgJRdbvM0cEiJfoPnopVQ+jbmRlTRKUE6AUOHXbIrVGwMXr2qiePYp7LwnrHtykQlrALkN7yRrqPPqc04u5/but53d/kKy5eaogDZy0W3pbJLQPGsh2HEpVQbDGuxgWKJdjbUbbNCYuFSbLivZO+65okC9Xv5sbNob0qH7xlfWHPE3jfciFb2nhtCExD80XGdqglOdZ8ToQjPIHKMWuCodk+6u42eeIwUbjQONy3OckHoBZAEKhNOTEa6pjsmRg9HnxFzGhqJedOm95f/HeKS481qiYyX/t/SgvnBcnN4adl4kmZTi84nb7z/9a/m9DeMSKvaQOt7aDxrf0qwv+FDdlqd2naR6qOw+nU4EwfbvWmv+3Wynot0EYIwCuTMW6VMCGzTQSI2PWumGPmCZ4+Qr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:15.2589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2778625-8cae-4414-2563-08df18eaaf60
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9444
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control
outside the main GPU register window.

Document the system node compatible, register and interrupt resources,
GPU clock, and optional GPU regulator supply used by the AM_SYSTEM
platform driver.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../bindings/gpu/arm,mali-gen5-am-system.yaml | 67 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
new file mode 100644
index 0000000000000..f0689bb8f05a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
@@ -0,0 +1,67 @@
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
+  $nodename:
+    pattern: '^panthor-system@[a-f0-9]+$'
+
+  compatible:
+    oneOf:
+      - items:
+          - const: arm,mali-gen5-am-system
+
+  reg:
+    items:
+      - description: System register
+
+  reg-names:
+    items:
+      - const: system
+
+  interrupts:
+    items:
+      - description: System interrupt
+
+  clocks:
+    maxItems: 1
+    description:
+      Phandle to the GPU clock.
+
+  gpu-supply: true
+
+  dma-coherent: true
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    panthor_system: panthor-system@68000000 {
+      compatible = "arm,mali-gen5-am-system";
+      reg = <0x68000000 0x10000>;
+      reg-names = "system";
+      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&mali_gpu_clk>;
+      gpu-supply = <&gpu_supply>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 40fdb0ecc9c12..377156650580c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2324,6 +2324,7 @@ M:	Liviu Dudau <liviu.dudau@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/
-- 
2.43.0

