Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DB0CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8B910E359;
	Sun, 11 Oct 2026 17:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kBqvHwxG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kBqvHwxG";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5DF10E135
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BW+DHSBrvujGvOyJbe0SwWFYMiE5GG3TCYiuQEjy5mNfsHbFfbKuZd6idL8/ZQY2NK7+1aCoaxOlyXp/9jDmrgwX7BgF//vXRr/Ggp8hVXxczjbKnUu9MTwewu7bPrVbrP6dZZXE3iNHEb9BM4U3s7yW36BNDq7SeIWwQjaIBA5fb11SI2NIhKnsjJA0W+FcF2LhDWYWsi8Vuww4Bfrfd0uf5eCodCRYxYhlyogvtyRwsQobcDfa5KmBGCVJSiW4mr4xkxlMOfYOvXf2NKKAhcWc4N6BQKlQuzGAhcmm+xOOopLJlKA73GFh2ZXnjZYHSyFUukB2ZRsCvxeuD8D34A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgQnJSCaYpfcDW90CuLAi4zX9qHHQfKaR+yyWzBBy+A=;
 b=MdCd61FkoYm7ggDNwu95r+302qUCAJI0hZXZV52avJyRuXPk6zYZtrHXbaL5kJg1c6IluTqrX8CojQ6KWxKA+cfaqzekjltaNKt37HjPSR8IVp4ksBV37tDtTQ1T017/hLDgPj1AKSiNWV+dr7ePBOdK455Ey90KTjFgjHRu8SNwJ08goJRiLlzjOZFP0EAGTTSVGtTX00mrYO+ThNwgOlZM6fOb9bYSioXwa9FMPkibtfIGiQ6WNpmHMef9loGN6N5tEd2otL7wQDLJSbe7dYjlC88oRoyQBzuhzBHHHAfNrTOeeOnvzK+rLSsDsRtA1WPwJjEKUDVZPfTd/KAeEg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgQnJSCaYpfcDW90CuLAi4zX9qHHQfKaR+yyWzBBy+A=;
 b=kBqvHwxGqI527GhkuRJUPuC/gVp9H+pyQy8grpX+MtFnn1/P/VQIg5m/YJ8ZiI4kAxe69M3e66zFgllTHEd2i6GSNlVix2f5b2AmMIurBcCbNM/N0LaID6THcv6xdZkgwtj/OmZKJ8W3W5Ii0MG4dj7yBSkwN335LfnFC6rNelA=
Received: from PA7P264CA0526.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::7)
 by GVXPR08MB11536.eurprd08.prod.outlook.com (2603:10a6:150:2c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:14 +0000
Received: from MI3PEPF0000848F.eurprd03.prod.outlook.com
 (2603:10a6:102:3db:cafe::9c) by PA7P264CA0526.outlook.office365.com
 (2603:10a6:102:3db::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000848F.mail.protection.outlook.com (10.167.240.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj9oT72VB9aG1Z5Zwpq6a7mjew+N7p3Lo+waq7ABa0zF421x85yZ7NUCvhL76Nn5W27aNycX2Z39ormuNdIBVpcShjFWPOgSjhzeECqLMTIHLjn50jLFA9R8e0VpLFA/xIfhkg6bTH3Xos9Kr974R5cCE6Sxk10gUGW5j+hqxj/a9V4ZHQ6/b7lGaRPWJ6Up7edXhgm5RPc1JxgafVR9wblTmr/4Hxu5kzL2UJVFwBs545LJSUOZ+9HzcBi2TGe/p10igBUfDErnf5wazpt9kdh+MflfX19fHmLC7IFleusU7NEqeuofwkbT50lrUffDBUn7pQ4xsMIFFUR54zrd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgQnJSCaYpfcDW90CuLAi4zX9qHHQfKaR+yyWzBBy+A=;
 b=nGzkrWfZMiStrGVtGhr2z1fiUF469J3CmNNTum6SAXLJhlYPwFrKquChWimUhG0nTuhG93dFeksnixgyewKEg8qNiK6gnQ9YFsqXAGRiqwhvvS3czsaDgNXUCyi4FH9aPQJXyOOxnbKMHsFgOM0rtJMlXKEbrab3qRRndqkBJ5Fg6JsS96Q2HzQP5z1auoliha6UZHZT+pANvbreKT5iIcNqeZuvfkj6fNjsNZz9gVtkdJUsC+aeR0tR1dDb4eiGgdx8XuA++VWftDQdsq9rY5uiVMPZGh6kCh/wPBt4/6hA6FQDHKaCqTRVYezMOGoUavJ4FQL9vDvVQlLIQLOW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgQnJSCaYpfcDW90CuLAi4zX9qHHQfKaR+yyWzBBy+A=;
 b=kBqvHwxGqI527GhkuRJUPuC/gVp9H+pyQy8grpX+MtFnn1/P/VQIg5m/YJ8ZiI4kAxe69M3e66zFgllTHEd2i6GSNlVix2f5b2AmMIurBcCbNM/N0LaID6THcv6xdZkgwtj/OmZKJ8W3W5Ii0MG4dj7yBSkwN335LfnFC6rNelA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:40 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:40 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [PATCH v7 0/8] drm/panthor: Performance counter implementation
 with single manual client support
Date: Sun, 11 Oct 2026 18:36:47 +0100
Message-Id: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC/Jy2oC/yXMwQrCMAwA0F8ZORsYZXPMXxEPXZa5CKYl6UQY+
 3erHt/l7eBswg6XZgfjl7gkrRhODdAa9c4oczWENpzbPoyYo5Y1GWa2JdkzKjFS2rSwOfZjN3M
 M3UBhglpk40Xev/56+9u36cFUviccxwfCm7kHgAAAAA==
X-Change-ID: 20260529-panthor-performance-counters-594dea247c2b
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Mihail Atanassov <mihail.atanassov@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR3P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::21) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|MI3PEPF0000848F:EE_|GVXPR08MB11536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0f3c77-173c-4a0d-2aaf-08df27beb4c2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|18002099003|260925021311599003|260925021911599003|260925022911599003|3023799007|13003099007|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: u6TDjtO8dBFxYSSrmanLd/TRmdLyX/tCve875l+g8YPmCZfytIpdiGzopiWIiyudycPF6JTKEGzfudvxHidO/OTxRkJ9QkGdakll+nhrnnDHmdGmUd8oEMh5oiGcss00Q8Ywv6rorqPm5hoWRo7vcHOujvNuZ1POJvaCzpQBb+R/Lgh5+I6QPtHlzDAhjbrf9WZWz5DERVDTOARgfyLGGX+f/irBZG9yHvxWe4QwA9XjSHks14OtWSFs7DUWhblFYMyrZpIjIYj/KfLbxEEMDnVSAoK7JCV73MISeFHGLeL8T2U+5ZRLu61wzwh66TywWsXP9PkD7M8nRiDZFzEKHaRuNvPoReYs0gC1eHkfgBzoKI/jgaLTMCkMafEvsfv541bCtYQ38BP0rUiZq9+FSD53xz9n09TkktCXGsspqA6XRQyJUKEuUhD27DmcAMuppu6WpZ0RO2GA4JqJjhxSvTSK6ZR7qYNdI5DrdECZRL9+8PQJNd85fYltJvn9SL2f0+TRE5H0gQ4BLkQdnn+EZOnatjhY7Cyq41rP89sFPR5fn4TYZBLoThjENPKR+CgNbT4/EYAxAwSESwbPZbCfoCpfJLHR91q7Iy0r37z3bzjpjISRMvHe9/rcwbCdbkquf8KZyvPBeTwKZ0aJaSi6QdMJzEbyR9z6ISEkAFvCPyg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(18002099003)(260925021311599003)(260925021911599003)(260925022911599003)(3023799007)(13003099007)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nKBI+FHNqIYn2dC9Bh9faMaTNIca3zbvQWtm4xgPWIQkuyMeOJaVmG5JJfKPgxlnFPMCGtBmBii8Pvhu3G3oNrmUwEL9tHWtflz3uzWAfoglS1m1cuLQgeWSZKocjI06z+4Y4/ma7YXZ2TytVp3UPjKL3Hc+SvBdi6ZdGDTRz0+XgW6JQDl+ykWowlPpMhb/wBQbqTk4uEH2eyPnPqnItWVoHe+/UlBxxNS8boyjx1F8Vre8egAIhVYvmLHeNKpLGk7GGWoDpUGZPB2kEPdFXFSgkjvTX7LDurAulZJtQKQqaBl9Rn3nojFxcP+X6ej+f1r021CNZyBYr3DbVRim5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e499d230-6036-4f68-cdcb-08df27bea0b4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|376014|7416014|35042699022|36860700016|23010399003|6133799003|10067099003|18002099003|260925021911599003|260925021311599003|260925022911599003|3023799007|13003099007|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9T2H7+CzihKLeQYNxKcEDjON5Pb8LSRvnwF9ehW70Szw/ptiWJM6BYLEL13/ONON6FFAzAy7+uPC+P8npOwt2MyhMYieCCwQrysQopwKYxtZpO28Wd50eh4KNoT9p89lcSpLGLYuMG23fQM8yh82ny6XSqnzNHutZhc4lF9WpOcLphoGkxmqsjsMV8eaBYdU0nzCXGb+2Thy9OoH6HIiUD9bJyp7V50JeYUX6WT158h9VHWJ5oFk/99c2oMOH/xD/yii++NQvEXql48CYrjYGakJAmko4iQEuCHdvJRrb+NwK5tjADkexuaolZ6jw9LN8dOHpcZ0Y50IHpya8aGPyhBVAMnOi1njxwC8ssSXo/kzHPAXXfQJN5F4rqkVdd9sgMlugp4SGXKtkYUc98CajmNdeElkpNhTeTQCoHayUrCA+4YBMCZeX5pOFcN2Ylo43kIfNVKwCypQXT5bUFFNuv31YAvVFWJcRdfhtx0ZfwyM4vEg/vwwyf3VlePyjCYpoMNlarfYZ8davms4QgS9wscIduE1tWvkiLjAdqTP8A3WjGLa1zzsnWCYnAqrQjm4nn3fyVt/sGFsdpOhN9Vpwd1QtmgL63c6K9LFiKSVFDGb4sEBSn1iaIa3F0UK6h1szN6aVubumiCDQI6h7RVxJnh/ZTYdSMmkxjK4LiHnivQqFoIrMdwiNOsdopd8do7iWPTAEHF3wLODkwOVecN6gA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(376014)(7416014)(35042699022)(36860700016)(23010399003)(6133799003)(10067099003)(18002099003)(260925021911599003)(260925021311599003)(260925022911599003)(3023799007)(13003099007)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fxng4YjgIqPmyciZVsIhBspRqOmU3ShKwRzQQw6dwuFan838dvj5/D06FO9y9TbHiSvgrRX1qPNU4vgdPBTWxGJk2b62Z6xsVaIK8mcG2uiGbqso6aYV5Laj20Y2ySO47gIxEQCKia6WLZig0iQ6ogo+Ke6rPef6uFK6gJQkH0sc2WAfck9n2SEeeU55A9QfSstALQfkReQ6U3o58mX6k/6+ahn7G0dgSkhqSqild77DCDqnd1CEAAjyNlPipGS2B7IEJr7zaoIsrBF/ptO+6xV6vzcobOTCm3QrtO2unP3JiGsIDY21mK+zlNyN5tN58WcR3sErUqNWAuNwoB7tBlR9+4BPWhPNhwqnHjs8rLAqJ3bxHhGYVHIbeRJ0qcCw5UCu0PV+LL6KxRnZRe5S24bvblDWmO1OQH5LqbvCfpFy59CQ3yU8tvggtxTqvp2o
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:13.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0f3c77-173c-4a0d-2aaf-08df27beb4c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11536
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

Hello,

This patch set implements initial support for performance counter
sampling in Panthor, as a follow-up for Adrián Larumbe's patch
set [1]. In response to follow-up comments on v6, uAPI features that
were not being populated in the original series are now dropped, leaving
only the features necessary for the initial implementation.

The Mali performance counters are controlled via a global firmware
interface to point to a buffer that contains samples of either 64 or 128
32-bit counters per block instance. Each of the block types has its own
32-bit enable mask, allowing for finer-grained control of which counters
are emitted. The size of the sample is dictated by the sum of the
FIRMWARE_SIZE and the HARDWARE_SIZE fields, but neither the FW nor the
HW provide sufficient information about what block types are present at
what offsets. This information is architectural, and may change between
different major versions, as well as different firmware revisions.

To work around the instability of the counter block layout, the kernel
maintains its own offset table per GPU, and provides that via
additional block headers inserted into the data. This enables old
userspace clients to interpret a buffer copied over directly from hardware,
for users like libGPUCounters[2] embedded in an executable to retain some level of
support for counter sampling without being updated.

The following performance counter implementation supports a single
userspace explicitly requesting samples via ioctl, and managing the
consumed samples via a ring buffer and a set of control indices. The
user client passes in the resources to create a session, at which point
they can explicitly enable or disable sampling via the
PERF_SESSION_START/PERF_SESSION_STOP ioctls.

Samples are request via an explicit PERF_SESSION_SAMPLE ioctl. When
the request round trips back to the KMD, an eventfd is signaled for the
user indicating that the sample is complete and can be found in the
shared user/kernel ring buffer.

Existing performance counter workflows, such as those in game
engines, and user-space power models/governor implementations
require the ability to simultaneously obtain counter data on the same
driver. Though this is not enabled out of the box, handling for multiple
sessions sampling at different cadences is added via the sample
accumulation handling.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/35024

v7:
- Move the perf commands into their own ioctls
- Moved session tracking to the pfile
- Fixed padding on uAPI structs
- Removed the sampler abstraction
- Moved new registers to a separate commit
- Drop the offset argument for session creation
- Drop the count of enabled clients, using the session_list directly
- Removed the r-b's due to significant changes in the patches
- Added check for CAP_PERFMON on session setup
- Fixed architectural handling of prfcnt_en
- Link to v6: https://lore.kernel.org/dri-devel/20251215171453.2506348-1-lukas.zapolskas@arm.com/

v6:
- xa_erase -> xa_delete to fix up dangling session issues
- Move setting user data into request callback to avoid setting it on error
- Embed the enable mask into the sampler
- Added helper for sample_enable and sampler_disable to eliminate duplicate checks
- Drop PM reference on session enable failure
- Drop the panthor_perf_em_zero function
- Added R-b's for the first several patches
- Added added reading of the PRFCNT_FEATURES register on supporting architectures
- link to v5: https://lore.kernel.org/dri-devel/cover.1753449448.git.lukas.zapolskas@arm.com/

v5:
- Started re-using perf info size fields instead of
  recomputing the size where needed
- Removed panthor_file pointer to the drm_file
- Fixed ordering of subsystem unplug on init failure
- Using the kernel struct size to allocate memory for user-passed
  uAPI struct.
- Inlined panthor_perf_sampler_{suspend,resume} into
  panthor_perf_{suspend,resume}
- Inlined
- Updated all callers of CIRC_SPACE_TO_END to use CIRC_SPACE
  for correct ring buffer wraparound.
- Free the session and sampler enable maps on termination
- Drop the return values from panthor_perf_{suspend,resume}
- Update userdata and end timestamp on accumulation
- Removed the ptdev checks on suspend and resume paths
- Link to v4: https://lore.kernel.org/dri-devel/cover.1747148172.git.lukas.zapolskas@arm.com/

v4:
- Added sample size to the uAPI.
- Clarified the bit-to-counter mapping for enable masks.
- Fixed IRQ handling: the PERFCNT_THRESHOLD and PERFCNT_OVERFLOW
  interrupts can be handled by checking the difference between the
  REQ and ACK bits, whereas PERFCNT_SAMPLE needs external data to
  validate.
- FW ring buffer indices are now only wrapped when reading the buffer
  and are otherwise left in their pre-wrapped form.
- Accumulation index is now bumped after the first copy.
- All insert and extract index reads now use the proper, full-width
  type.
- L2 slices are now computed via a macro to extract the relevant
  bits from the MEM_FEATURES register. This macro was moved from
  the uAPI due to changes in the register making it unstable.
- Consistently take the sampler lock to check if a sample has been
  requested.
- Link to v3: https://lore.kernel.org/dri-devel/cover.1743517880.git.lukas.zapolskas@arm.com/

v3:
- Fixed offset issues into FW ring buffer
- Fixed sparse shader core handling
- Added pre- and post- reset handlers
- Added module param to control size of FW ring buffer
- Clarified naming on sampler functions
- Added error logging for PERF_SETUP
- Link to v2: https://lore.kernel.org/dri-devel/20241211165024.490748-1-lukas.zapolskas@arm.com/

RFC v2:
- Link to v1: https://lore.kernel.org/lkml/20240305165820.585245-1-adrian.larumbe@collabora.com/T/#m67d1f89614fe35dc0560e8304d6731eb1a6942b6

[1]: https://lore.kernel.org/lkml/20240305165820.585245-1-adrian.larumbe@collabora.com/T/#m67d1f89614fe35dc0560e8304d6731eb1a6942b6
[2]: https://github.com/ARM-software/libGPUCounters

base commit: e48123c607a0

---
Adrián Larumbe (1):
      drm/panthor: Implement sample handling

Lukas Zapolskas (7):
      drm/panthor: Add performance counter uAPI
      drm/panthor: Add register definitions for perf
      drm/panthor: Add DEV_QUERY.PERF_INFO handling
      drm/panthor: Add panthor perf initialization and termination
      drm/panthor: Introduce sampling sessions to handle userspace clients
      drm/panthor: Add suspend, resume and reset handling
      drm/panthor: Expose the panthor perf ioctls

 drivers/gpu/drm/panthor/Makefile           |    1 +
 drivers/gpu/drm/panthor/panthor_device.c   |   17 +-
 drivers/gpu/drm/panthor/panthor_device.h   |   12 +-
 drivers/gpu/drm/panthor/panthor_drv.c      |  134 +-
 drivers/gpu/drm/panthor/panthor_fw.c       |    5 +
 drivers/gpu/drm/panthor/panthor_fw.h       |    9 +-
 drivers/gpu/drm/panthor/panthor_gpu.c      |    5 +
 drivers/gpu/drm/panthor/panthor_gpu.h      |    2 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |    4 +
 drivers/gpu/drm/panthor/panthor_perf.c     | 1953 ++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h     |   40 +
 include/uapi/drm/panthor_drm.h             |  370 ++++++
 12 files changed, 2547 insertions(+), 5 deletions(-)
---
base-commit: 4b7a49d66c8398a7984dff4ac54d1acc6b3a58df
change-id: 20260529-panthor-performance-counters-594dea247c2b

Best regards,
--  
Lukas Zapolskas <lukas.zapolskas@arm.com>

