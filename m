Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96DAC98309
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E492D10EE67;
	Tue, 22 Sep 2026 20:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HpbaDdwu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HpbaDdwu";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011058.outbound.protection.outlook.com
 [40.107.130.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB54710EE6B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:12 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JawO5K8JBFCyp/uQArXj9yf/+lQS/enLGj1l2GWF+9JDL5KqfgWTmj+1WNGwd4p1bPoelXZR5e7pazAe0kvRnSuhs2dI0+fdgrsg9rtwHxMVl/LcAHIC796J57sW3QogrLtCcVyY/cWA4W90H6dVN9J/y0JsUTsUl+UuqfM/iPWuwnWuT5bmN8Vw4tWKwK9b5ooO+7DQQemLoQ4fIGzjz+RTw03Iv4p74YIlwiEiQA9WKHW4hBnZxzHZDl+Kahg6g2p97WlCNCtY+Bmgl0huBavTV0lJV2vJuBM2xuOBe7bk6lEnIhb0XGHvqCYvwpX5Kjdh5zfMdIglqjDWlEPB5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEIMUIDEtXxnhZaUC2V83Oj3097KKnXyvWIut9RVChY=;
 b=bB2czm8206IjTrY0kEGfmFYWqKHWtC3Y+63etKZAxbKMqXw5X0Bs6y4oeG0y5lRvr3lBHuG430knsbwSFZqk9I0bJLcmHVgVL5sZOlrAidHXViT6NSqiQW15Gr8LUgqHkHZJgkbZrOny7atkx4XECqBFNBnWtxYaXND4jloOY3rsuMIAsHf+6YgeI1UJNIj0JILBwvgpxKN+tfUQkgVpAsvVR7l6vgTZ2K+2m6JOJn/iCOXrnNoZnpG15BCM1astXsGNvfDMx4BLKCoCwqfEaVNlT5Lfz4/IVMTjzosZjF2A7u/V3Si6DTiMm7wH1I2PTBUH6QFMgNDot1nDE9GuNA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEIMUIDEtXxnhZaUC2V83Oj3097KKnXyvWIut9RVChY=;
 b=HpbaDdwuRi9UQP2Ar6vseHtPMX2SuCe1j/JMwGMYxPnIPgUOnmGCYDMKK4O5zQ9DS16plj9JKLNIs2o36F3SjATwjlUOt2BZw0DjZ+Ueaa91CISTYjJti7of6c3rp68hJtDY4sn++QBLhFk+ffSXuWvBmafmQMQ4bEZ1OprrJdY=
Received: from PA7P264CA0488.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::22)
 by AS2PR08MB8746.eurprd08.prod.outlook.com (2603:10a6:20b:55e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:48:06 +0000
Received: from MAD0EPF000008C6.eurprd05.prod.outlook.com
 (2603:10a6:102:3dc:cafe::34) by PA7P264CA0488.outlook.office365.com
 (2603:10a6:102:3dc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SanCoilI1I3PkZVcVW637QIEm+ALLu6/Rxd4ZoMpkmkxd56DY5LtavI3QWQpItHQFXjpapBKu7bLId74rdSdecyD+CIwMTfnFC6RYcMxqSaPlCB9rivVKr6/hM4lDWpdUT3Vy1LSl9i0dCbt4xMJv3NLfSgIeTCFURYxXivHwPzw4uCIS/QFFhXNnn1ojApKYm28u5rmgiYW9V7BRyE0lFjCeh5Dsodct8stSvYc+DjPy1Av/dJ2LQHVJCCNPtTvOavt/Lxx5d2VcFMSvWtg0JUvEOnX6oxVuv0hpTGAbfrPPgAjl3QGnAc0sM5BhDtV4pgenT+Ekfd7i1aDrImabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEIMUIDEtXxnhZaUC2V83Oj3097KKnXyvWIut9RVChY=;
 b=mf2CC7R32RZdBaRkmnbGizDgGmWP2IrqdyhScMxv1sOYlRgpIazFI8ocyZI1i5yfe6gFmrM10BLAnhStqs55Tu4amff42/uDVse/gLFQ55WUPGFvgSn4o21GrRtLht5KiUYR3a2b+eqxgTkIHT2UgqrnreIW1cwdkIbGT7pHA3styoHTGQU4UMCAvaE0G+8EU7f2Q+8vUZe35F4X91tfTWH6/A6r2/QUPFKu0QPHb7nyxXy0ySYyjIJzVc5yBGIDSqijVGXSb7Ey+AmebFJnswX4S2BV4u++XgUSGI5+/ZcVhtcRxjUkCwi89NDmGTCkLIPELHFgeR2U/Aa9lEBwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEIMUIDEtXxnhZaUC2V83Oj3097KKnXyvWIut9RVChY=;
 b=HpbaDdwuRi9UQP2Ar6vseHtPMX2SuCe1j/JMwGMYxPnIPgUOnmGCYDMKK4O5zQ9DS16plj9JKLNIs2o36F3SjATwjlUOt2BZw0DjZ+Ueaa91CISTYjJti7of6c3rp68hJtDY4sn++QBLhFk+ffSXuWvBmafmQMQ4bEZ1OprrJdY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:33 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:33 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 24/27] drm/panthor: Route HW component PM through access
 windows
Date: Tue, 22 Sep 2026 21:45:18 +0100
Message-ID: <20260922204535.2850094-25-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|MAD0EPF000008C6:EE_|AS2PR08MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 23486822-4511-4b5b-9661-08df18eacd7c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: E7c78rgcPDPdMhavHdXmKDEUOCVB4YBldXrkjg7qwpzEhK6qxBHMdfdkvT58lIcD9qgM+bFx82SnUuBzCMXLP6V8lZc+ybh9gBJcQ8TsF3erS13fETM5Cy0K9s2ot7620TfmPQhjZtmsiYlmQBxn6Xa4tezUPfXCVyWagXS+zlqLeOeHzd86YJz/wJGXTVs5p+BmK2PnmFtX7ye1Z6bbqms4YAxaGcThfmzkO9/X1akFnyaRpj8LzWq3YwOinJdBJYO3AV/8XX5KACAbOAf9Wn0KbKd7O20i+OjPTMCLXsgISlOsthN4dFw0R/9W6cXXCSmvII7isasW9RasoZyqX+ggo2KbAruVIUXq9n/BtZSzGxbftg+KKSY637JWVLF8VH9AGpPr5mEg0dxx+GZbjoQWMQuKEIOvJEKn162sZTEVWdZby/uztZdT44+N652OjDkaA6+iDgeEC2gA9zUVlQUUArsaZb8q1LPKKWQ3eL/uG0TCBsIhyTR9UQgWASsUIcjtjLzkkA+eeKnMrfOnUgteeS+QFyZZmWqwPbCA1bEbZo20zuCZViVNsTWBJPs4NLMwkoHVjNZ0r8YmMRLfNP2Gg0t3VL1GTt/plr+G22yu8A+oI1rYf1wAqE//LyV8VJiv/AGgrpAjY3oZ1wzEFGS15v19EZtOIdfAsIGKM6c=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: t+kIgesK9i02SNBEwHWErHooQ2f/8cb38iQ8+zORiH8ma8czOuxzxnyUsfbtWfI1nmuJWIabBdrQNIz5X6+1e9LiEu6WhYvRk6vhJn28jEuZ8IWMtaR+JGCkmD41H3Tq1QGSuhHDHXnJdUVvXlLLf8FgciaZTUT7Wic3qZG+G+tUTg8sUDeI+CHpsMj0fDtVSRqcpzeB11zCM491l211jvobT/aFKACxqKeRJOGhGDJ8/4/d+mKNRTuXM8mMPIJ7BKaAye5CYu5CaXyiBAZiYOIzHcrLh2FiNHmFPVpjdstIKUtChWkt157NqT1OBRmsfmfAx+0NwVT8wvUbDRhVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4241cb05-f68d-45d9-8734-08df18eab9b9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700016|1800799024|35042699022|23010399003|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sE5/4mNMYqb1378COiRDJQvzTsT5CHCcVq33RQYwnr1mDE+GgQ6+O/Wm7+glpQCYQ26sRBYZ06Yew3bRg+Ld3C3EQKOoLaB4F3uX/wcqVsTirA5e0MSMSkVcP37IqB1w62MvCxPJpQ6bxb76tnWBUQJolyJz+AgMVEvV+fAyhPnDTpt86ZBkagOd5nFwSZgqTVNmjPJ+Ak2iAUwl7HNfoNjDiZIxiZjjuHeOw+gS5LIGFyiiTEW/RcWvRGivPvt/Riv+ns6hN2Qz8nd44h0oH4YxfzU1TkBRE/Gy3OzMTR0w0JFw5rJ5oBL0U2YrlASjmALkaxKCQULaLFi8U6E/HEaC3/gwzuF40EuqSsD73hN8wCFVUP95G3Y/S3DiwFxwo9D7OLS66GOj4NiMgeipZWKRFlr70TFvODt7U4UKFsJl43b6rfiHjwhT/cYf//wzpfzRntdig2iZ2jg972LDdXx4yDkTCgG7DMyhS6GFUQambIkBbBvT9w5cLga/shhpe2PE1w82oaBLshqbpQP1y0GzpcwYZNgP+eYR3vo2feO9Zk6MWXtmzuHOArTMITKjJe08fp6deKK973Icd0K0+ubxWdQq8vcd4mJwxWZaVGqZhxVuS6mWZE8p7xS9P5LqXFGbuuNvwQ65x6NCfo5Z7AJ2EgsHWVhP/tQQYs/5izE2VaKPDEJJn/SgDP2WyezqBqaR3rV+jqPl2909MWe1rA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700016)(1800799024)(35042699022)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GXnWshAGCBZVhVtBsDkrtLHa92rUjDzQczc3ZYt88N5fkWWUskpbi1Wk6GfbFAKEGm0iPKrZTWRP/COMVREqFP4jQV/GP+vOdMpqs/KdU3+IZRcmCKd5AiiUpxwFRWrVQ1ulgz/3xDRoFeMP8wLudKZuomj/EIEwh3y74DFsArqqzDXDi+ADK3bJBaXKQ7NsLbmAnN8Rdbv4cqVbHIbJ3j44q/B2NHfwK0RJGo2gCijJkbICrFnWbPPRS/ZLMF1VOUBQHhCkyoesc4+Bqs7alcSR6tH4k9i5Pol9fqWyHfSGXDeJ16JvAzJ4ZVVUryRf+FhT147Th3HDTI/Aj7I6p61kFj/LII5vLJdmq/wzvGijtk0d/AQcAjles3+zZ4/506Czbq34mJXZUql3z6WOYIGRjVYnH8sm4GkXxojGmvpwpfUaV+yBB+yu1YaK380h
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:05.6971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23486822-4511-4b5b-9661-08df18eacd7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8746
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

Make access-window resume and suspend own GPU access when AW support is
present, while keeping the direct HW component PM path for older GPUs.

Handle WINDOW_CLOSED and arbiter restart events, defer post-yield
cleanup to workqueue context, and make panthor_device_resume_and_get()
ensure that GPU access is obtained before callers touch hardware.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- update panthor_aw_ensure_gpu_access() to wait for AW state transitions
  and retry on -EAGAIN.

 drivers/gpu/drm/panthor/panthor_aw.c     | 194 +++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_aw.h     |   8 +-
 drivers/gpu/drm/panthor/panthor_device.c |   6 +-
 drivers/gpu/drm/panthor/panthor_device.h |  15 +-
 4 files changed, 198 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 40122bb4b83af..4fcfb3ad05073 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -77,6 +77,9 @@ struct panthor_aw {
 
 	/** @msg_retry_work: Work to resend messages */
 	struct work_struct msg_retry_work;
+
+	/** @post_yield_work: Work to yield the GPU */
+	struct work_struct post_yield_work;
 };
 
 static bool panthor_aw_is_open(struct panthor_aw *aw)
@@ -118,6 +121,52 @@ static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 timeout_m
 		timeout_ms);
 }
 
+static void panthor_aw_post_yield_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, post_yield_work);
+	struct panthor_device *ptdev = aw->ptdev;
+	struct device *dev = ptdev->base.dev;
+	int ret;
+
+	/* Something else has progressed the state to READY. */
+	if (atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_STOPPED)
+		return;
+
+	/*
+	 * Ensure in-progress resume is completed and prevent future RPM suspend
+	 * to keep the clocks turned on when accessing HW registers.
+	 */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	ret = panthor_device_suspend_hw_components(ptdev);
+	if (ret)
+		dev_warn(dev, "Failed to suspend hardware components.");
+
+	panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+
+	/*
+	 * schedule an immediate tick to re-evaluate if there is any additional
+	 * work. This will request access to the GPU again and if the driver has
+	 * gone idle, it will yield GPU access via the runtime suspend path.
+	 */
+	panthor_sched_resume(ptdev);
+
+	pm_runtime_put_noidle(dev);
+}
+
+static bool panthor_aw_schedule_post_yield_work(struct panthor_aw *aw)
+{
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				     PANTHOR_AW_STATE_GPU_STOPPED)) {
+		queue_work(aw->wq, &aw->post_yield_work);
+		return true;
+	}
+
+	return false;
+}
+
 static void panthor_aw_msg_retry_work(struct work_struct *work)
 {
 	struct panthor_aw *aw =
@@ -166,7 +215,9 @@ static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 message)
 
 		panthor_aw_send_msg(aw, reply);
 
-		/* TODO: Handle AW restart */
+		/* Arbiter was restarted. Window is no longer granted access. */
+		if (panthor_aw_schedule_post_yield_work(aw))
+			drm_info(&ptdev->base, "Arbiter was restarted, yielding GPU");
 	}
 
 	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_INIT, PANTHOR_AW_STATE_READY);
@@ -192,6 +243,38 @@ static void panthor_aw_handle_message(struct panthor_aw *aw)
 		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
 }
 
+static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+
+	/* Ignore this WINDOW_CLOSED as part of reset operation. */
+	if (panthor_device_reset_is_pending(ptdev))
+		return;
+
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_STOPPED ||
+	    atomic_read(&aw->state) == PANTHOR_AW_STATE_READY ||
+	    atomic_read(&aw->state) == PANTHOR_AW_STATE_INIT) {
+		drm_warn(&ptdev->base, "Unexpected WINDOW_CLOSED received");
+		return;
+	}
+
+	/*
+	 * Window may have been closed immediately after opening.
+	 * Setting state back to READY will prevent WINDOW_OPENDED from
+	 * mistakenly transitioning the state to GRANTED.
+	 */
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+				     PANTHOR_AW_STATE_READY))
+		return;
+
+	/* Triggerred from messaged-based yield. Unblock its wait */
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_STOPPED_IDLE,
+				     PANTHOR_AW_STATE_READY))
+		return;
+
+	panthor_aw_schedule_post_yield_work(aw);
+}
+
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 {
 	struct panthor_irq *pirq = data;
@@ -211,7 +294,9 @@ static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 	if (status & WINDOW_IRQ_MESSAGE)
 		panthor_aw_handle_message(aw);
 
-	/* TODO: handle WINDOW_CLOSED*/
+	if (status & WINDOW_IRQ_WINDOW_CLOSED)
+		panthor_aw_handle_window_closed(aw);
+
 
 	if ((status & WINDOW_IRQ_WINDOW_OPENED) && panthor_aw_is_open(aw))
 		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
@@ -259,6 +344,7 @@ static int panthor_request_aw_irq(struct panthor_device *ptdev,
 
 static int panthor_aw_request(struct panthor_aw *aw)
 {
+	struct panthor_device *ptdev = aw->ptdev;
 	int ret;
 
 again:
@@ -266,6 +352,9 @@ static int panthor_aw_request(struct panthor_aw *aw)
 	case PANTHOR_AW_STATE_GPU_GRANTED:
 		return 0;
 
+	case PANTHOR_AW_STATE_GPU_STOPPED:
+		return -EAGAIN;
+
 	case PANTHOR_AW_STATE_READY:
 		break;
 
@@ -273,14 +362,22 @@ static int panthor_aw_request(struct panthor_aw *aw)
 		panthor_aw_handshake_init(aw);
 		ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
 					    PANTHOR_AW_HANDSHAKE_TIMEOUT_MS);
-		if (ret)
+		if (ret) {
+			drm_err(&ptdev->base,
+				"Timed out waiting for handshake to complete");
 			return ret;
+		}
+
 		goto again;
 	default:
 		ret = panthor_aw_state_wait_transition(
 			aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
-		if (ret)
+		if (ret) {
+			drm_err(&ptdev->base,
+				"Timed out waiting for AW state transition");
 			return ret;
+		}
+
 		goto again;
 	}
 
@@ -290,15 +387,20 @@ static int panthor_aw_request(struct panthor_aw *aw)
 
 	panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
 
-	/* Wait for GPU to be granted */
-	ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_GPU_GRANTED,
-				    PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
+	ret = panthor_aw_wait_cond(
+		aw, atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_REQUEST,
+		PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
 	if (ret) {
-		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+		if (!panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+					      PANTHOR_AW_STATE_READY))
+			goto again;
+
+		drm_err(&ptdev->base,
+				"Timed out waiting for AW GPU to be granted");
 		return ret;
 	}
 
-	return 0;
+	goto again;
 }
 
 static int panthor_aw_yield(struct panthor_aw *aw)
@@ -330,6 +432,7 @@ int panthor_aw_init(struct panthor_device *ptdev)
 	aw->iomem = ptdev->iomem;
 
 	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+	INIT_WORK(&aw->post_yield_work, panthor_aw_post_yield_work);
 
 	init_waitqueue_head(&aw->waitqueue);
 	atomic_set(&aw->state, PANTHOR_AW_STATE_INIT);
@@ -362,6 +465,7 @@ void panthor_aw_unplug(struct panthor_device *ptdev)
 		return;
 
 	disable_work_sync(&aw->msg_retry_work);
+	disable_work_sync(&aw->post_yield_work);
 
 	panthor_aw_irq_suspend(&aw->irq);
 }
@@ -371,17 +475,48 @@ int panthor_aw_resume(struct panthor_device *ptdev)
 	struct panthor_aw *aw = ptdev->aw;
 	int ret;
 
+	/* resume hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_resume_hw_components(ptdev);
 
 	panthor_aw_irq_resume(&aw->irq);
 
+again:
 	ret = panthor_aw_request(aw);
+	if (ret)
+		goto err_out;
+
+	ret = panthor_device_resume_hw_components(ptdev);
 	if (ret) {
-		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		/* Yield GPU access if HW components failed to resume */
+		if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+					     PANTHOR_AW_STATE_STOPPED_IDLE)) {
+			/*
+			 * If failure is caused by WINDOW_CLOSED and the IRQ is
+			 * handled after this condition, AW may emit a rogue
+			 * idle event that will be ignored by the arbitration
+			 * scheduler. WINDOW_CLOSED handler will then transition
+			 * the state back to READY.
+			 */
+			panthor_aw_yield(aw);
+		}
+
+		goto err_out;
+	}
+
+	/*
+	 * WINDOW_CLOSED won the race. post_yield_work owns component cleanup
+	 * and will transition state to READY after this PM transition is
+	 * complete.
+	 */
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_STOPPED) {
+		ret = -EAGAIN;
 		goto err_out;
 	}
 
+	if (atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_GRANTED)
+		goto again;
+
 	return 0;
 
 err_out:
@@ -396,20 +531,45 @@ int panthor_aw_suspend(struct panthor_device *ptdev)
 
 	/* suspend hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_suspend_hw_components(ptdev);
 
 	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_READY)
 		goto out_irq_suspend;
 
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_GRANTED) {
+		ret = panthor_device_suspend_hw_components(ptdev);
+		if (ret)
+			goto out_irq_suspend;
+	}
+
 	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
-		PANTHOR_AW_STATE_GPU_STOPPED))
+		PANTHOR_AW_STATE_STOPPED_IDLE)) {
 		ret = panthor_aw_yield(aw);
-	else
-		ret = panthor_aw_state_wait(
-			aw, PANTHOR_AW_STATE_READY,
-			PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+		if (ret)
+			panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+	}
 
 out_irq_suspend:
 	panthor_aw_irq_suspend(&aw->irq);
 	return ret;
 }
+
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
+{
+	int ret;
+
+	if (!ptdev->aw)
+		return 0;
+
+again:
+	ret = panthor_aw_resume(ptdev);
+	if (ret != -EAGAIN)
+		return ret;
+
+	ret = panthor_aw_state_wait_transition(
+		ptdev->aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+	if (ret)
+		return ret;
+
+	goto again;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index c2b89caa87c48..7a46a1e18093a 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -24,10 +24,10 @@ enum aw_states {
 	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
 	PANTHOR_AW_STATE_GPU_GRANTED,
 
-	/** @PANTHOR_AW_STATE_GPU_STOP: AW is requested to stop GPU access. */
-	PANTHOR_AW_STATE_GPU_STOP,
+	/** @PANTHOR_AW_STATE_STOPPED_IDLE: AW has stopped GPU access. */
+	PANTHOR_AW_STATE_STOPPED_IDLE,
 
-	/** @PANTHOR_AW_STATE_GPU_STOPPED: AW has stopped GPU access. */
+	/** @PANTHOR_AW_STATE_GPU_STOPPED: Window was closed, cleanup required. */
 	PANTHOR_AW_STATE_GPU_STOPPED,
 };
 
@@ -39,4 +39,6 @@ int panthor_aw_resume(struct panthor_device *ptdev);
 
 int panthor_aw_suspend(struct panthor_device *ptdev);
 
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 2ccd8ad6318d1..ea35c5e1d87b4 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -577,11 +577,11 @@ int panthor_device_resume(struct device *dev)
 			atomic_set(&ptdev->reset.pending, 0);
 		}
 
-		ret = panthor_device_resume_hw_components(ptdev);
+		ret = panthor_aw_resume(ptdev);
 		if (ret && ptdev->reset.fast) {
 			drm_err(&ptdev->base, "Fast reset failed, trying a slow reset");
 			ptdev->reset.fast = false;
-			ret = panthor_device_resume_hw_components(ptdev);
+			ret = panthor_aw_resume(ptdev);
 		}
 
 		if (!ret)
@@ -650,7 +650,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_device_suspend_hw_components(ptdev);
+		panthor_aw_suspend(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 42c5052ac83b9..59bc48d05eb1e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,7 @@
 #include <drm/panthor_drm.h>
 
 #include "panthor_device_io.h"
+#include "panthor_aw.h"
 
 struct panthor_aw;
 struct panthor_csf;
@@ -466,8 +467,18 @@ static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 	 * succeeded. Given resume errors are not expected, this is probably
 	 * something we can live with.
 	 */
-	if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
-		pm_runtime_set_suspended(ptdev->base.dev);
+	if (ret) {
+		if (atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
+			pm_runtime_set_suspended(ptdev->base.dev);
+
+		return ret;
+	}
+
+	ret = panthor_aw_ensure_gpu_access(ptdev);
+	if (ret) {
+		pm_runtime_put_autosuspend(ptdev->base.dev);
+		return ret;
+	}
 
 	return ret;
 }
-- 
2.43.0

