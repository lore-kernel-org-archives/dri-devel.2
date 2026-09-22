Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC47C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB39210EB50;
	Tue, 22 Sep 2026 20:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pJhs2QKz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pJhs2QKz";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE2710EB44
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g++u4X46CXzTjT6bG2juSFwyZXDfDYUMnnSKRWDpK4P/w93sJFTMcsBKqi2LEoLOKQ38M/Z4VYfGUCHNm9sG0zVFq4HKIsaohhs7Bw8Bx+YU1Y7ywgEr/WYIdm+kZKJGJrUdhpT9eAfrdoBAbzc66NxJIAMJrJhNk214AL/q0VhvDa0eQttbIzEikfzNQ40go5Rj/9M+t2Eey26Ewthysgv/71PNKa6irQJnefbEixGsGFKnlwaV5WT/5huGFp2ojatzA7FE9M6BWvCD9Kmgf2oEinECD89seGEmdwxnC6mgZwiZrfYDQcdOZPhqjzWU1Jis5beasIk4NWjNIDP28Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04UzrHhJCsBj0A2xmkEwwi/5LBGp/Z2ChU/53mgmk9Q=;
 b=dadET51KwMpSTyoZBXYAzTG19IoS44hglQ8QiJFS8s6H2FqWl1R4N868pr1rLC4XkPbF9zFC//sDwkc/foyqMztLkYwnZPbBW9f1Wf5+d3tCyy3byDCW7NFjPEYpPpECuAdi+5qDbQ3fg3RZtTZ8JmH7M2FPR733UskpUNxtSb60GJ4sl3q8ypfSZ7WJoFaFSfIw3yHqxPseOJZEF8pzjaeVfxo3CDR4/WJuVKD7zKnhUxbomuA5NK7cs0SdU3ghcOBh+YABysbYgV+QleTTCEbwqsylF3dg92sHzeqspdPhOK+pjH8fCXIE/kiAKy93QSz7xv8WzXLRT4eQ+w+CkQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04UzrHhJCsBj0A2xmkEwwi/5LBGp/Z2ChU/53mgmk9Q=;
 b=pJhs2QKzEwlTPWaPNQD4djZLy23USM52fC84zQtoCkkqQ3lBiuY7aJ73Rary/ZSv0MD/oHlpM3ApfOFfwACki3RtB8tEKqeU3K8+fRfPkTpI7ax2E/bmZphF0v+vum7qiKVei7bdiY1qbyEOK+89h0fOWHoYzUdH6L8lQtsK9cg=
Received: from PR1P264CA0011.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::16)
 by AS2PR08MB9427.eurprd08.prod.outlook.com (2603:10a6:20b:5e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:04 +0000
Received: from MI3PEPF00008481.eurprd02.prod.outlook.com
 (2603:10a6:102:19e:cafe::2c) by PR1P264CA0011.outlook.office365.com
 (2603:10a6:102:19e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008481.mail.protection.outlook.com (10.167.240.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY2XkWkwUvhXIVqybrHBbzt2XmKrWizfx6OImi2YgyEYiyxtq9OG/7mhOh8LHTGyTfcNBBGTxAFv8k8W2l7bTvlDRMcRimVRArFodvcrlp1hFH3fM4lALepqdlQ6i0cIhpiNZjHYFIhQL2vcSMyInIDTwqD5/7j2ZP+EnvufkWqx/7i13+SdkAjGbCVT+NKE0nYzACGezFCvSn+hEkErQcPjQZDpsXbl8ukeieQ8mIiRYr+RQfUOtA1eynXgpe2H5NpTeIGSOGV0oaVTGl5OyRyTt64hUbDGV2ShmmqZzQeMYx4CBIQ9gCthHpUo8ZOmBZRIcTdHMssiORwLadir+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04UzrHhJCsBj0A2xmkEwwi/5LBGp/Z2ChU/53mgmk9Q=;
 b=bgGGZpro61zcYEmw6vo34IQK++M6Kef0pHhlRPKhC1ArHQUresLZCi/gSvYjEkVEtFJ54rXuhaMZoQiQvkPnwx7s5TQF4lORX85Kn89NDDC1sMb/FCKgHp0Ow2cBmMFxmkXjol7D87YEObRL/xpdw8B0pnahmf2sCImArS5bUEvAaRjQddZl/9+hxF7g0jqa6QJjIsC3EA+7gz+G/Vu/5+KaFyzGBtLVeunlNotC2AwceNQVtLLTmK5md10TJeqkAjePPHjImOEg8PRtWao/iGbM70h+dmzC6ruVhZB7khPdQmN601oK6Z5cNKD++0GNAUHqJRIjwViI2mN6/3tanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04UzrHhJCsBj0A2xmkEwwi/5LBGp/Z2ChU/53mgmk9Q=;
 b=pJhs2QKzEwlTPWaPNQD4djZLy23USM52fC84zQtoCkkqQ3lBiuY7aJ73Rary/ZSv0MD/oHlpM3ApfOFfwACki3RtB8tEKqeU3K8+fRfPkTpI7ax2E/bmZphF0v+vum7qiKVei7bdiY1qbyEOK+89h0fOWHoYzUdH6L8lQtsK9cg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:28 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:28 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 07/27] dt-bindings: gpu: mali-valhall-csf: Add Mali Gen5 AM
 compatible
Date: Tue, 22 Sep 2026 21:45:01 +0100
Message-ID: <20260922204535.2850094-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::10) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|MI3PEPF00008481:EE_|AS2PR08MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a39ffb0-3eb8-4ba6-1ae1-08df18eaa87e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 155OycUfkwzy6v6PKi9iBpPbzeRSBFcuadLV7dfbiqYDgywa5PKW1ZhZEwLyZcqCG8J2NgodvdBWbj4w4Vgc/3mUcIiqydWLvnF/kaTPcuDgiaxFknKL4TEnZ9C+M+BSADE+VI6p9jzkaqKQQiAlJnKhK7XsDzcgqc5ZWvoMV6EA2i0OB6s/4MsHf2P15QJBaSx8IMtYXc7goU3q+75MaPYbOMfo0v7uVXR9ATCyMu1xQ9Acu/z4UEr2obICiPGfq1ema29IYWTOWPmiTI+T/p/scI237LEHoy5PYSFQnqxpIFYzyL61stW3a1zyW/mg3Ekce78p1rx9yQ+RzbQxLknHI3yfrod9yRxqad5+XHUqiwxQgUxf2Oy2LyX1EIxxvaab5YfSaS+D9uLe2r0iid/TDpeWlgXr9pdoFc3iY1l5F0ywzs4lmIqqLgZs6spV5n4oJtxNiPc84o7QAyz8PwFYHM7WGxVwwCzR6kA4X4D87fWWw1+6+FvO82wx4+PU+TnVU/ikieVKGMqxccO42Gq/EaJBAnIbLdFcjndz9uv5d4MUIP4WMcp1Tc0RcztvAdglQKz33BYLaqL+1gy29EQHXDAro+jIcEpF/kQH/2hswFXbHp5q2VmarrLngz3cHAtj8ywxrJbFSJ98/vIx8KgaUzUVgeMQPRyrK1+ee84=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JiwcXor8DN4G3I0fsyGFamHJjxxkS/YQ3S5VQGXmjZx5aT53ft7ndw/3FGHYts59wTx29wSq2vkf2st0Yr5Q0ERZaGasqLFn3/00QDVnBbOIDfuQl9BQDl8l7qMZSzXghH94/rUrJaJlO5IVLSdBS5MNh5TbEGHSe3qzeDnulOw0LYceH6BS2FXboNuROcNuIdCPoPczIvp9U7g5UsfAXkR80TcCue4BhTHAxMJ9TK2SLVP6a6HqKevLkWlVBCTI4SpOHjOmL7owVvFnymMymJfL7aE2XUwe87VaBcsvgfkEFodj6gMysJMKUZdEJ6DECRRbTpYhCKzH7GIildlXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008481.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 91ead820-36d7-46b2-c255-08df18ea935c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|35042699022|376014|14060799003|23010399003|7416014|82310400026|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 348ubYaRZ/ItkiD76fbJKFiOjElv+raEG2wOt+GDTii6+5WeK9mEF2SmPubAuvD4gTduIf0UKB44lXsjXPUSAHnnA3pifGLAA7e9CEipzG37bh2wmI3gZ/dYfhAw8ooYh5gXik6+6OaQ4aM/+CSjeEnYYeK5AjpDdmKzzMT8gvbIOAhm8RmqfR9puylPhDsQ40yV3itWOKmkAYQsMWXmgFWh/8d0/Icc1UqhU3t5VzPhY0kOjzW8VnxWV9wSAEfyDNUrTKAQ4Z32LbntyKd3a2m5xz3WqV1Iwn+ZNYxXBrG8iftvODxgqZgCxPdznv2B4Tf4EFr3G2k4Fi5ihDZYSFF4j/LcCwb2WMqfZcFPCLLj0jn/nSiZhyR7NNtpsSMQHDv5dMZIGuPfqpb5s2ZfhGQnX++HRPsdsx8M/eyr8pfNylhckW9DpUml6JZ4sSzZmq4r3vmmbFcgMeQe/Pv0jo7u13gvgD8GLK+BGvLpgjQ0xeyujW5lzn0BlH0ZtA1T3EGgUgFrP1cvcoJgG3R+AIxkaMA381p+MNWGTNIudjC0aR+ksrZzXz3ScpUnQX5pfEap0eynXIGRk9wODMWPNmc5qhRxsD+LY+norvvzI1BwNpZJNfL1snQMgkqbAuD7j2hVtxOkCSZ005E8IN7y+sUgG1ZupaU3PPEu9TH25zqeoW7oQuNYoJqTj2c/3ypCukznti29bgaqiDEeJ4199Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(35042699022)(376014)(14060799003)(23010399003)(7416014)(82310400026)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1BR2nBx741tTb+q6K24Swc/WqC6mhFdo4N139H19i5uCTmkDWtl/WW/rvFFKsBFHqc3IuyJcbjRuXrosUz5q+pzhq3ZPYpw6eRlCjpVd9KUvGod1v+/yln+Z9vYcJ9CYQPGZ3w05fz/gQXSmslFhhNR/bSQfL0Ps9Vb7ItIqpCnB/BTEQ/pH8JG3VXXO/mXWyMpXZe1+gFdRbDiiRN3Cdy4o9Jfio4kvHXHPgs8fnhEI2O7lgA9AmSOIw2GQ1xCSurLhssDkqgpQZiEsuH4xXw3d8zGzBiVusCYXh0y80GvXRG7cVmygaQ05gsgxXUbieDZYOZGPDWcVPrJPAwD8ezcqte5kypGF8O91NVpOxlMgyg4df3fvxVjBKWEpFIuGcZ84L+x0XePTUU397ayK3p2bimJaDXXs/idltp/iG+bnG043PEomVj83qbjVvUtc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:03.6331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a39ffb0-3eb8-4ba6-1ae1-08df18eaa87e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008481.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9427
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

Add the generic "arm,mali-gen5-am" compatible for Mali Gen5 AM GPU
integrations.

Mali Gen5 AM systems use the external AM_GOVERNOR block for frequency
scaling, so OPP, cooling and local GPU supply properties are not valid
for this compatible.

Add a matching example node.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml    | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 8eccd4338a2b2..a1e85570b4b3b 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -22,6 +22,7 @@ properties:
               - nxp,imx95-mali            # G310
               - rockchip,rk3588-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
+      - const: arm,mali-gen5-am
 
   reg:
     maxItems: 1
@@ -146,6 +147,19 @@ allOf:
         - nvmem-cells
         - nvmem-cell-names
         - power-domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,mali-gen5-am
+    then:
+      properties:
+        mali-supply: false
+        sram-supply: false
+        operating-points-v2: false
+        opp-table: false
+        "#cooling-cells": false
+        dynamic-power-coefficient: false
 
 examples:
   - |
@@ -195,5 +209,15 @@ examples:
         nvmem-cell-names = "shader-present";
         power-domains = <&gpufreq>;
     };
-
+  - |
+    gpu@100000 {
+        compatible = "arm,mali-gen5-am";
+        reg = <0x100000 0x480000>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        clocks = <&gpu_clock 0>, <&gpu_clock 1>, <&gpu_clock 2>;
+        clock-names = "core", "coregroup", "stacks";
+    };
 ...
-- 
2.43.0

