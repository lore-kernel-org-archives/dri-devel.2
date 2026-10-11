Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D7CA9ED0
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D491E10E135;
	Sun, 11 Oct 2026 17:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PKxGZFpy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PKxGZFpy";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EAB10E135
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IIhDIdX8R8RkxFqCxBKOdU4MUIanmEGqh3+R5PA0tVgGAGsw/guONXyi70oUkuSxYRpuRsx3oeYSQg3P/r+/G369/MeanhC75l/+FurQBr4GXmR2bCHud3dpUu6nxjBCSRRwsufCDgZqz9AJA6Oz1NHnXqwHkAT5kyZH2n6gsxRcegWbM7FXLqx2tDS2ddSuRiR4Yzaa/MV0ODZpmddPby2CIXlGTjNhXjeaRSLd+HJ2HJ82rF8h4h3lqxYKckgddR7tgphuM7QGfJk01YRzG6k9A0OqOHwHeb5sEF2pfE5xvgHtgULzT4FNGBcMOGgYLoV/UoEgfwOUegpb6WkwTw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOlGWin7237jvcz8PKAzq/GqL+7Iyzum2o7xijQ7TGw=;
 b=vpxzpz53NjsCUwQYIX9OHlOlRrqTns8f5waLMJ0r/O9DEXowQBh2bEugVfC+eqhwdb2U6lIBi1eRU9PHzrEF5FVFqaCtFWaZOXEOWLFxdmQCTfWPXqsih1O472+K/Dd+je9TlsNEMD+bmcP3n3Xw0eMOKSNb1yg8N4j6hcJAy91l/s6vgz1P5j1Ks73NuWfdiQpP13J7OFAhE/BKY5xRL04KZqfireDin2Cy+nhDLE4R078SpuRnHZ6O04+xW+VPCtWRXc7wLj8WnzAECLMpZ8EYO04OdDNxVbBx82UhXwy97ldCTDDhaArIqfRQgyOewR+zIRwS4Vq6cc30hpl2yQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOlGWin7237jvcz8PKAzq/GqL+7Iyzum2o7xijQ7TGw=;
 b=PKxGZFpy7qRtHXekEpu4aVoZMJ8B0lSyYt81iAwIHY6m+F3pAHLHTF69ex9IrirbbOwdEbqS2d6dU9y7wR+uWUZjMagaD9UqQiXdxcTSkJChzMlSNhhLUBtDDGafstuNd7vHeJOA3j2z8+ltnwoB5vUDITDxzW2i8ugkY6CS/fg=
Received: from OS6P279CA0153.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:39::13)
 by VI0PR08MB11293.eurprd08.prod.outlook.com (2603:10a6:800:306::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:17 +0000
Received: from CPH1EPF00000530.eurprd05.prod.outlook.com
 (2603:10a6:e10:39:cafe::1c) by OS6P279CA0153.outlook.office365.com
 (2603:10a6:e10:39::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000530.mail.protection.outlook.com (10.167.241.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGF7pJzMz/CZ73qSTBKcX/heoAi4WyN1kIORcvQAcXUpJVcEiWqDc5tPWP1zv7oWbxNrT0lX2Cx+iJ5hdL9lMRADFdvCmvSEAXdtkZeNlwNfArYjSD9+mCH/ltj8b7At+Hi9kK/fDFMySuP3Y52k1Y3G8zdaUXmw/5EnAnb4yHuB9KJb8IZ4OYyX8S+ofLiS41AewmmK9ogvH4NOBKTLvKZ9JVHaqqRW9t5vgKPRsGoJP0x57gkmCK3G72oo1ZhENo5VtIUeDW6Z8AGCACFjtHfZh/0X3Kwels5plU3mxLmgYa6nez1jLAThOKOXbJ1uNSTa82xzXs+tpRdJpApNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOlGWin7237jvcz8PKAzq/GqL+7Iyzum2o7xijQ7TGw=;
 b=JSEUMdMv5Ge23Wt/7USaOYxrG1xpmoDLU0FiUinMUgHY1hZZwLvdty7VTpb4vaSfMU4tD3ANU0lj+lP495dpjFlf2VG7seZgmc0u8jcoqhZK7XHWtvdPAC/uZgXktYxLSrw48TH6++ZKd+fC1A7+Xy1/6WBaZbzk8iXhP07MZGeduhgIzu7lSZJBRCN8O+iqMGvA0Vwv1mrz9d13//KBVrObdilkS+AFsGiaXgcCb0bSeL78lDLhDw3kNWu/yrm8D0tBO/mx72PV/5k5Pk0wpJOWdbjaA8Ah1fVs85Is2VLeuGSE+ORXtWAITJOcl62F2k9rUb47RBvMgvnDu9dCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOlGWin7237jvcz8PKAzq/GqL+7Iyzum2o7xijQ7TGw=;
 b=PKxGZFpy7qRtHXekEpu4aVoZMJ8B0lSyYt81iAwIHY6m+F3pAHLHTF69ex9IrirbbOwdEbqS2d6dU9y7wR+uWUZjMagaD9UqQiXdxcTSkJChzMlSNhhLUBtDDGafstuNd7vHeJOA3j2z8+ltnwoB5vUDITDxzW2i8ugkY6CS/fg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:43 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:43 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:50 +0100
Subject: [PATCH v7 3/8] drm/panthor: Add DEV_QUERY.PERF_INFO handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-3-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|CPH1EPF00000530:EE_|VI0PR08MB11293:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db94b2b-0a57-4642-cd41-08df27beb67b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: /yyczxfEc8KKPsTKlMtD4SG8UsYkapBkGfeRllNeA1BQTP1TLASF6JWJjXpSumLPNIYHsRxrU5vGcrFwWb9trzSFNt9iCxHFUyz837iQFzI8RzamCd6vpDdPBYUDulHdqf9ms12N0UbW/HDrWijhqb9zZ/fFNcRgzCvlEVTXR2nSRH2PQSNeUp/SeLR6aCjaOtBUTAJz31/mS8zeROgKBRYjnbxZ5dvf1ZI+9P1WO3Q+JAHZF+SzCXsNiU+JnKnl7jjatv9S5ZueKp1PJlG1RQApBcxgJyNkwFjS08ntyu5ulYm7AQTIUHO1s5Hp9MKZJZsZnbTVXfIaMlsE0ON84o5FlVs5JA0Om4aaaRt18co9040qAmnOKYATtpJAniZ8SwGGolDJ3cEkS4T0RAM6t1MvbnxCrL9ytupSLxLVm9KCNCmPOxtGPzknnGNCsZw/+RUTrRyIGl63vkF7U4WgxqJ8JUhnthUbel8SxU+9JyFyL+eh33Vx+01bj/C9xbmPqaWIjPtoglQI3b032rZNenonk5IjOI1JSO7EKA2TXR0eLtwJPQrD6HbcfqgCElMDs67Wu/y4CKH56reBeAk7Pam5urRb1d/FBzFrzY/vSR83RqB7fhsUj45OaWI1ykl529DwyOuqgkNjalN9B45kChppg1N0LETSVbC5CW6gApPP3ah6/1JYUjYGDqekARD/E25DYVZXqBLR7ObYfdJ0/w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZSKg/3q65QZ3Qbgu88sC7vW72UXzqze9qh99FK69RBMmI7at3l8j1WgjjYXHyZZkTqkGLBc0A7R8XYq0cdK7UZR1CScEoZ4K3G1/2h/HJK83cjpEk8CrCKVQf9byr9ZcAs/c6EVihIX5k5Qua1Fk/HjiSrNczsVBvzv0PI4OiVDRaOay+/vVAC3rmFo1jhYP4agYYsdsH+xfPkHLVs20mGzHjybu0xxWhAWN1YrEDMF/u4pllzFBzxVnqDQBEDGR5LndqrDUo7N3xIc+u8OVauO1ZizHTkFn7ZwKHbd1mtMStRn80RNe0Ym6Gn4KcERh32WpcdzDwbNM/WKDU71aqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: da125ed0-4fe7-48cd-1560-08df27bea25d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|14060799003|82310400026|7416014|1800799024|35042699022|376014|6133799003|10067099003|18002099003|22082099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZImwr/jdlp9g/Ssg81fmU4jWhDTwpHD+qWevYi5s9LYqnbImMnezvRRXr4iOH9KLs4Wc6AF0Di/tXgnbIB46BysFR39E+jhhLflWfiyDCI5JqYLX4dp9Yfnwo57iiEns+vy8dfTUGqteHXhhvf6bK4knfbuYGxjdJ1MGKNzTQt6DfmQRk1zYlJqNKVAfpiWiDlxD+//aZehQDuXRSydLiIeQeDqK/7asYU8MFiL2IVLXRjcQjQsWA3epD5qVJA/5pUcg7LYnrkJAt1X4eFfU+SR+JEUROJQoAIAmL4dfG4RZz8nm4YFmW9eUIx+/MdKe8MoyPc8fuhQLSXxUVIh4l+Hgl0vqrLW1HM1xmGHJwazgY/OsmbqJW1jjDE5WbCwal6CY3teEEo8gEUnc61XyVSTV3SNpsPf7pabjHa7bI4j0LxEMMfEJWdCIvVt+RpZgb2wyeF7KnrCuAp9TFef0G6mGLM1k8NkJsOJ3v2so8sD5D5m4G38Da2Vx1GwHLYUQ0WsfwjMYLvle2K1v8k2fEhYAzE/GYRZvvTEqM8QxG8+MPdf3VusN2YSW/04/cNzdqHxFGYzRP+GlgSHjxdxrOjsA1p/EaIO0lPLRKrHLe48Zj2osX83fvSz4LYLaitywZSlVBcf1K8+iPs9mV1ASlrMIeNk06EwbRS1UDxNfIQ5QEOvXyq/4MdDUrNAdzoc/GTAUBHV8TnV6zYBWDfb4IcN0BAOsLtOO0uRtZGq35paaWnOZrwwrLF1AoEEUjSLu
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(14060799003)(82310400026)(7416014)(1800799024)(35042699022)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gaF6iT0gomNZLB/Wc4qK4rFUT8H1nNIr3tiAsQoQosoUpniBBODdTHsGYAetk3GpYh/XGoRNn1nYncPnrQ7P//Dz2lF8koYZASZYa+oq5CcGvTHY7NkIJIF0ig3HpmKsv7dSsigC6KTHSKpP1cCW1Viy6yNLVR04SmQWpW+2nxzgzCoRkD/Ve54LIX2+nOQPyQ1pf2MbWgna/ZEO5/+Hmf6Aa4elBUDGsu2i2FxeckjF/Tlv9cDh7IuQ+m2KvHIVoUTpC9aJde5ueDbHf0rhqM40UeGjSrylvYzKvkYGgPmkwhj4qI/CNzQmHGGIJ6u5vvED1AXzzUlkBUMoZkfI0Ln7bYev8J7Nb6BnJI91HlUniH/sp96IFBje5v448ecpv+35QVeE3lJTk/f0u+q5RaDcclHzSn+xS1MKa+ucvI9zLKetYxcvaTfvxMVU9nyb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:16.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db94b2b-0a57-4642-cd41-08df27beb67b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11293
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

This change adds the IOCTL to query data about the performance counter
setup. Some of this data was available via previous DEV_QUERY calls,
for instance for GPU info, but exposing it via PERF_INFO
minimizes the overhead of creating a single session to just the one
aggregate IOCTL, and removes the dependence on architectural details of
the counter layout.

This required reading one of the GPU registers, which is exposed via
a new helper in the gpu header.

The current handling covers GPUs from the Mali-Gx10 up to and including
the Mali-G1.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/Makefile         |  1 +
 drivers/gpu/drm/panthor/panthor_device.c |  7 +++
 drivers/gpu/drm/panthor/panthor_device.h |  3 ++
 drivers/gpu/drm/panthor/panthor_drv.c    | 10 +++-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  5 ++
 drivers/gpu/drm/panthor/panthor_gpu.h    |  2 +
 drivers/gpu/drm/panthor/panthor_perf.c   | 87 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   | 15 ++++++
 8 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index dd15d52a88ba..c65fff290720 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -10,6 +10,7 @@ panthor-y := \
 	panthor_heap.o \
 	panthor_hw.o \
 	panthor_mmu.o \
+	panthor_perf.o \
 	panthor_pwr.o \
 	panthor_sched.o
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de350..2877d47c6717 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -24,6 +24,7 @@
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_pwr.h"
 #include "panthor_sched.h"
 
@@ -287,6 +288,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_fw;
 
+	ret = panthor_perf_init(ptdev);
+	if (ret)
+		goto err_unplug_sched;
+
 	panthor_gem_init(ptdev);
 
 	/* Now that everything is initialized, we can enable the reset work. */
@@ -305,6 +310,8 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 err_disable_autosuspend:
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
+
+err_unplug_sched:
 	panthor_sched_unplug(ptdev);
 
 err_unplug_fw:
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd41..d93b182a3d9b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -174,6 +174,9 @@ struct panthor_device {
 	/** @pwr: Power control management data. */
 	struct panthor_pwr *pwr;
 
+	/** @perf_info: Performance counter interface information. */
+	struct drm_panthor_perf_info perf_info;
+
 	/** @gpu: GPU management data. */
 	struct panthor_gpu *gpu;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 8cdba0c1a14b..b6b55b0f2ff5 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -182,7 +182,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -959,6 +960,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->mmu_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+			args->size = sizeof(ptdev->perf_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -992,6 +997,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->perf_info);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101e..726a70b74346 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -508,3 +508,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	drm_err(&ptdev->base, "Coherency not supported by the device");
 	return -ENOTSUPP;
 }
+
+u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev)
+{
+	return gpu_read(ptdev->gpu->iomem, GPU_PRFCNT_FEATURES);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index f615feb05609..46a6ca98cbb1 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -60,4 +60,6 @@ u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev);
 
+u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
new file mode 100644
index 000000000000..cbfe1ca5872d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2023 Collabora Ltd */
+/* Copyright 2025 Arm ltd. */
+
+#include <linux/bitops.h>
+#include <drm/panthor_drm.h>
+
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_gpu.h"
+#include "panthor_gpu_regs.h"
+#include "panthor_perf.h"
+
+/**
+ * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
+ * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
+ * which indicates the same information.
+ */
+#define PANTHOR_PERF_COUNTERS_PER_BLOCK (64)
+
+/**
+ * PANTHOR_HW_COUNTER_SIZE - The size of a hardware counter in the FW ring buffer.
+ */
+#define PANTHOR_HW_COUNTER_SIZE (sizeof(u32))
+
+struct panthor_perf_counter_block {
+	struct drm_panthor_perf_block_header header;
+	u64 counters[];
+};
+
+static size_t get_annotated_block_size(size_t counters_per_block)
+{
+	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
+}
+
+static size_t session_get_sample_size(const struct drm_panthor_perf_info *const info)
+{
+	const size_t block_size = get_annotated_block_size(info->counters_per_block);
+	const size_t block_nr = info->cshw_blocks + info->fw_blocks +
+		info->tiler_blocks + info->memsys_blocks + info->shader_blocks;
+
+	return info->sample_header_size + (block_size * block_nr);
+}
+
+static void panthor_perf_info_init(struct panthor_device *const ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+		perf_info->counters_per_block = PANTHOR_PERF_COUNTERS_PER_BLOCK;
+	} else {
+		u32 features = panthor_gpu_get_prfcnt_features(ptdev);
+
+		perf_info->counters_per_block = PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(features) /
+			PANTHOR_HW_COUNTER_SIZE;
+	}
+
+	perf_info->sample_header_size = sizeof(struct drm_panthor_perf_sample_header);
+	perf_info->block_header_size = sizeof(struct drm_panthor_perf_block_header);
+
+	if (GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size))
+		perf_info->fw_blocks = 1;
+
+	perf_info->cshw_blocks = 1;
+	perf_info->tiler_blocks = 1;
+	perf_info->memsys_blocks = GPU_MEM_FEATURES_L2_SLICES(ptdev->gpu_info.mem_features);
+	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
+
+	perf_info->sample_size = session_get_sample_size(perf_info);
+}
+
+/**
+ * panthor_perf_init - Initialize the performance counter subsystem.
+ * @ptdev: Panthor device
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_init(struct panthor_device *ptdev)
+{
+	if (!ptdev)
+		return -EINVAL;
+
+	panthor_perf_info_init(ptdev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
new file mode 100644
index 000000000000..3c32c24c164c
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2025 Collabora Ltd */
+/* Copyright 2025 Arm ltd. */
+
+#ifndef __PANTHOR_PERF_H__
+#define __PANTHOR_PERF_H__
+
+#include <linux/types.h>
+
+struct panthor_device;
+
+int panthor_perf_init(struct panthor_device *ptdev);
+
+#endif /* __PANTHOR_PERF_H__ */
+

-- 
2.43.0

