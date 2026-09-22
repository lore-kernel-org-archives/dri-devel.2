Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C69DC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26710ECE2;
	Tue, 22 Sep 2026 20:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XADNs5Yf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XADNs5Yf";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12ECE10EB5F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:29 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mHzC9g3YICQEdDwSXxr3qXvZe9wDKI67/e1NGM8FdpnTBd2k4lM9jfggfzHb3J6hyRJN5QBbBnvXHM03r7XAFOnIB3OJdaj3pmWHA/kLf/+NGx0AQ002NVYGGq7QnVv85WttpadPgOCIHkr6sDTH0Oedd3AqvRallJ5PeUMZygoAmSaC4vnYbn7p0BhW9heOSQgJ56CAMPyVOvlUy3u3bUAnhpaJiyXt39jRTjR55aN2VayS2Fse0JUqStjSGs8/mp9jgZgbh+f1rkTKobbdoctaxb3wje2gOxg+TVs91SOattDgSwP8G+zr099lmZ4tWEkdHrMFRgEyN6r6USsnYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9g1JtaqDQvXyWCVVJP6YHHXic///QBgDhYDelhtLMY=;
 b=d0a/RBRrh8pTgHnvn2tMYsbAVjtMlrXhHYyVDWbfHT6xve+21JR+uJHBakUct2T9TR3NJi7Tsg1IgrPlTZ288rF+VGAvodbSd7hFn8yveo8/Bp2syxK2vbAqRmtSCQdejqstHnwR0nQcxr+ut9fjsceNRHkE1/L70vkPaoxFHV3l1ISsl43fuVh+Z7aF8FBH42rgTIwZUf4DGhh5R48QWYwfH/ZrI60q8CNznZfCa2vxoGvSNZYP5Cq+OUE/bXT061Nd9Z9/WXHE/S4WOUluqErziU6r0uDH3marA1u5RDWdZMll+mCmyPYaBxp2hVL20O8FlutsiwRuBVNu7HvdfQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9g1JtaqDQvXyWCVVJP6YHHXic///QBgDhYDelhtLMY=;
 b=XADNs5Yf6OnaU25SPhhFFaZqIxO+j61OHVnQrFsaiApo3oRFuNhoTcGI4xZPfOHZctMAvyBwPfutDZ/j2RZ/TSce1QR0rpAvR5ak3MQFDDPm3y7TVeUu4ehxXCPSuuYhCbXmeOOj+VnZxuZEaeIN9LK/BdCqTcgKo0fP34zK0AE=
Received: from PAZP264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::18)
 by DU0PR08MB7906.eurprd08.prod.outlook.com (2603:10a6:10:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:24 +0000
Received: from MI3PEPF00008499.eurprd03.prod.outlook.com
 (2603:10a6:102:21:cafe::2f) by PAZP264CA0013.outlook.office365.com
 (2603:10a6:102:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008499.mail.protection.outlook.com (10.167.240.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiLXumTGsmPsiPZxVNyi6vZeQwjP28vDADSx2Fe5z2wvKqqFPCe6Iwh5dNUtZby64CChnhLqvahZrC0jMEn6UBP8xOWbyHSp0Hx6v9ctFSuWiYgO3dE6BAric/QZBFDfJTjNcoqawWEuu1rVp+4UQIBT9OMyTELIiSFaY4xbGlQHt0oQrcOjlDXXEXQIl8Y6JY7e0nwje2wvb3tC1fXX2BtGE6+PgdZw9LfCAyQ6DzUw6O1RSnNdn/Ngiz7chN5eov0OYwFe8Q6HT4VRJLVkdHdmaznDTMoGIdvPAJYH7dZ279gUNvtgaWj+wvuC/mYxn3VqUZhcq+aYcwP15zSXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9g1JtaqDQvXyWCVVJP6YHHXic///QBgDhYDelhtLMY=;
 b=alr6B+zU1l/2HXkiLDUMVufHwEUuXrR1B5wMOUrpy758ufnocdZjJmhEgUEonUabO01c27FyEzj3gERP9ILuHWnsXO6JGGRSLcLdFL6+kKNNrU33+VQMNqk3z8KaGo+yMY/VNkXFlswD+rBD/vfSP7PXUiuGowdNK3VSyWBPT5gcV4Ag/xhEHOQExNMKgWo9Vgqt5yK0W0EPLj9xijZYt32h5aWzHkKR+65YhbSIlsmZec5JjXdfxEOpUFUChw8FxhLumSI7n1H41QcakIcQ6gHe6kuPV3YXYv5ZQWLNPcVpYxRRypEtbtE97Dm6RT9Y0xwa8OJaodc65ychBehlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9g1JtaqDQvXyWCVVJP6YHHXic///QBgDhYDelhtLMY=;
 b=XADNs5Yf6OnaU25SPhhFFaZqIxO+j61OHVnQrFsaiApo3oRFuNhoTcGI4xZPfOHZctMAvyBwPfutDZ/j2RZ/TSce1QR0rpAvR5ak3MQFDDPm3y7TVeUu4ehxXCPSuuYhCbXmeOOj+VnZxuZEaeIN9LK/BdCqTcgKo0fP34zK0AE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:51 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:51 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 12/27] dt-bindings: gpu: panthor: Document
 panthor-arbitration bindings
Date: Tue, 22 Sep 2026 21:45:06 +0100
Message-ID: <20260922204535.2850094-13-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|MI3PEPF00008499:EE_|DU0PR08MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d6bf28-d173-4b20-dfe2-08df18eab477
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: lCL/b8vzmpShRwO80CRh6IA+rmFeAX6IblAO09iVKby/iUbLH0hrqFAGsDXjWLVh1lG5Ue0jZghZeWQPWH9f38K47eGqlS1WmmajeU+6IOiMfJLin7pgm1XERwEmh3LpjSZprCUJ2veAVA3R4pxEBeFIytNIMi0UAJlkWR9Kd0mIbb8un7EUvYutu6WQ/YAO40aG3gWhdDucadUU92WCCrulg2LppfTYaFkRcvuUZFzPBfnA1e0yMMO7SbJ+VYzr2PBvNshxLPU7vaMxA3sir9lalyvL4XHZyGL539IqZuJddWxbmom43CZ/7h2E2VSOt2KGfZpt+aqBbiVhtSDu/mGwLbqbm3rA0w4C+ByHqdeM0OSG9KTE5RGpdIJ7rmnvz/CTQGCMW5OX08ndBtyxSsqzD3uu2WxZdgfJ9r3s5kpH7xAj91/qwOd4+0Ii+vM0KuyXLf1U29E5f1HCjRrKZg6lMVNBX4OdjQ5E6ztv0z++arRg53cPXLo3+prOGClKcnj0W50Ki76OJsaHnj4jTlIJ2eo/3Ji2ojy0d3h0L90bTEZIwOt5LKSkDkS4AfDMPUPvMqBr36ejAOIfFnh9xs69jav7WN1ysDBxqaTYk5Y=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: vid4bshej+vAZEjvBQAROT8p2XQUejeYzxVhLral1c0vWw5XJbKvxutgi5PB1/2CHuhGAhTfNn2RbN9Un9XclvoY8JiUI5RgvbeGMnt//yFtipyaUmb5y5MCUFET4WftnLaS4juvU9zAfwTrIawI03zQYBFuNXUeNC7LcwzG8sQQA+/gh9SfcQMBHzw5H4yxgHJMatAijls9rff4C3SP8k6eq/DctrS2hjKhvnII3E3HH0xR1C33s8z2+1768VjHaTZbQxfgAQHVRXClTgKcbXYX4ocqm6QtcUtSicbdK4w4oWgAoaB5mFGxbgx2sJ2hNfJv6ZKUGPSm2J8h5is/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e3de65f-f8bc-4030-c28c-08df18eaa0d9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|7416014|36860700016|82310400026|376014|23010399003|35042699022|11063799006|56012099006|10067099003|3023799007|13003099007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: czn6DBXEqn41u09sRrYQlXvxagdf94Rx6gBqrVm+oB77xxVUoAmogYXCuqjZSz/BFupLX1WhC6bXaU5/iwTREvb/wZwa2h7/LhxTMND91/rYinxWQbiLzgcuHDUlAHYMu4K+yynS2rMw4WrM68boIZAc/gLYlRClWcBAUFJgmHu6M0XR7tgTpU0F5gk8tYDsF9j900Dm5CfkdbpJ20BrCEXl5iHVjA6gJyZGu1pb1TiFG8pXT+u+SH4d7+2hVLTDorfkSjqoNNKFCIldZQgMINwY1p7ia+JQMRdq9pNc2HaL3CBM6rBXN40abiwQSdc05j4EIWMgb1GW7sMoKLi/QkrwyDn/l2ZVHl5E+UvBHrxNRw/M6hn8j5UMBXCyDzBf/BM35mB/1hn3Qw8lRe/5j4aF3N2bO52iRGO5MCFDIXB8ozdyobV4tt5Uk63EkRdf7xWfc0nhCkTgjdfalUkYKASCB8l/KuzuVVn/h86NFmGbqfgAVrDQJmTP9Nctoue8H76AnYK0VU5uWnCrefyz24FSZPgUSRPa+IwLwyDHsOqzaV7sQGSgV6kexLoEdhDjp3qN2QGJfTq6n2FIY/A6qqtg6N895TdnRdMoP5KJY7O+0W8kVkTZu5crmbbTdRw2urHLuF0sxrYCxR0dwHduTw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(7416014)(36860700016)(82310400026)(376014)(23010399003)(35042699022)(11063799006)(56012099006)(10067099003)(3023799007)(13003099007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: isXfk7ZYrmvcWq1wny3Ss1dCrYzZR6tAQcxk1z8MFXCMWblG56m31B9KqLXNKBKXZRq1/2cOnbCmXTbeobHF9JieKss3fFGdT7GtrUfPeuTzeZIVdQ5d4R68rxTUmie1D00f9Dq3M5nm85/eJimuzxhEnUdYRk3bKIsKT60nKFrAQQlm6+KA58v+MUV3uT7S56k+sZczWM7I23G9375bhzZ0b3OZJRnUte3XntsW+ySloqTkD7AHnHIOWIWMJ3pdnLPvedEZ2qfGZ/6rKX5KtP9i/5MHWVZ2H7syRfDPmMVlvaX61JAApqbyjK0ioHumtGpQ4Ov8Wazs+RTCHxZZax2hIhcINHZDRitdWHHbu4YBTKkhnTjPhE6tSKwtFw4AQ4EreQ33XGSOvEFI46LTm5YSXPUKG+MH4CxymIbezUApTsZfmuaWbSuileFH4FLF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:23.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d6bf28-d173-4b20-dfe2-08df18eab477
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7906
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

Mali 5th-Gen AM GPUs expose arbitration registers outside the GPU node.
The arbitration device contains partition-control and resource-group
register blocks used to grant, yield, and close access windows.

Document partition and resource-group child nodes, each with its own
register range, interrupt and hardware ID.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../gpu/arm,mali-gen5-am-arbitration.yaml     | 125 ++++++++++++++++++
 .../bindings/gpu/arm,mali-gen5-am-system.yaml |   9 ++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
new file mode 100644
index 0000000000000..9ea2b4bb9a344
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2026 ARM Limited. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-arbitration.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th-Gen GPU Arbitration Device
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+description:
+  The arbitration device manages partition-control and resource-group blocks.
+  Each block is described by a child node with its own register range,
+  interrupt and hardware ID. Partition and resource-group IDs are separate
+  namespaces. Access-window IDs are global to the GPU.
+
+properties:
+  $nodename:
+    const: panthor-arbitration
+
+  compatible:
+    const: arm,mali-gen5-am-arbitration
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges: true
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description:
+      Partition control block and its initial resource assignments.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Partition control register range.
+
+      interrupts:
+        maxItems: 1
+        description: Partition control interrupt.
+
+      arm,id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Hardware partition control index. Must identify a partition present on
+          the GPU and be unique among this device's partition nodes.
+
+    required:
+      - reg
+      - interrupts
+      - arm,id
+
+  "^resource-group@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description:
+      Resource group block used for access-window messaging.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Resource group register range.
+
+      interrupts:
+        maxItems: 1
+        description: Resource group interrupt.
+
+      arm,id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Hardware resource group index. Must identify a resource group
+          present on the GPU and be unique among this device's resource group
+          nodes.
+
+    required:
+      - reg
+      - interrupts
+      - arm,id
+
+  "^gpu@[0-9a-f]+$":
+    $ref: arm,mali-valhall-csf.yaml#
+    properties:
+      compatible:
+        const: arm,mali-gen5-am
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    panthor-arbitration {
+        compatible = "arm,mali-gen5-am-arbitration";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        partition@50000 {
+            reg = <0x50000 0x10000>;
+            interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>;
+            arm,id = <0>;
+        };
+
+        resource-group@c0000 {
+            reg = <0xc0000 0x10000>;
+            interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>;
+            arm,id = <0>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
index f0689bb8f05a2..a027dc5f4f890 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
@@ -41,6 +41,15 @@ properties:
 
   dma-coherent: true
 
+  "#address-cells": true
+
+  "#size-cells": true
+
+  ranges: true
+
+  panthor-arbitration:
+    $ref: arm,mali-gen5-am-arbitration.yaml#
+
 required:
   - compatible
   - reg
-- 
2.43.0

