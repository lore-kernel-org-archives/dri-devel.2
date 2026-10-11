Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C32CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703D710E354;
	Sun, 11 Oct 2026 17:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fLwbJ+HN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fLwbJ+HN";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07BB10E1EC
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g9zngYqBBCg2Ghe4bZVGAHknqd8HanJWIsAVAfXGL1R0Sl172Ih654hkUmRnaGqljYOTBTny8hUfnx4PgTF5BBpC/F/qf1GPa5psKVgmACSz6WwmmUXX8/5RVb2HijG5RnwusztsMtsMq5KsE1SK6d21om1G9w1H+dohwQCNortYNwlgLuLjsUhltekgAxgQHlYC4pSAXrIB6xYwsVnY/1pPplM0CP4IC8m4c1x7cWG1BWIGLAcbrMbEoMyIiPpcd68o/bUOBGxI2GuPtMIk0If94K6VRJ6269xEHwQvO3wGJUSMokDw/bErXP0Wx85l7Zb3CzTZWV1aLIKAhyAj3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REcdvGKMkeaOw7L4knRzBUoUI/WA3xFmgPtUil10S3k=;
 b=R/cyG+vQHt1ru9vRkDiDTnRUGhXl4sCDsOzoPyJmuxmh3K/MkQXJ4syllayN4WVnkP89aqfKUNFvJzSDZrS9VRaPTqOsNGMMrMcc23GATCY4AO7pb3xW2R/lwvIdFIKYeY/+LxBUz6k8ZrAiy6TCY4nz4Tjy5DEpZcCjlYzZptKhUVUDGKxgVxKi1ZR/889bzuRHY+QHPeHOEXUBFM6CyO79gadqvj5NMQW3haUYIWeG+TdgvgZMbfQsGRE4XF3WAiZvaRsAtMddcnje6zfo6W/bLkr+KcKkQDpXKkr8tBUbvd2YzryKBcoZgAFEjzabTcNmMTuj2WnqojYPP7vFgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REcdvGKMkeaOw7L4knRzBUoUI/WA3xFmgPtUil10S3k=;
 b=fLwbJ+HNZHWs2+EUXa/4qcbqg+sTz6v62YjXtWzjXFDUv7QLu47icO16g4wVPA2WWg06FG5qWDjzYyqUisBOMK0t3QLYqxENCxL7T8r1SwgAT6ZY/y77ASoUomqenWUp1nm+bhmi2LRaPjHmX0WaON1a1+pjFOqxaULg9z8QTwI=
Received: from OL1P279CA0067.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::18)
 by MI3PR08MB11984.eurprd08.prod.outlook.com (2603:10a6:290:80::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Sun, 11 Oct
 2026 17:40:19 +0000
Received: from CPH1EPF00000529.eurprd05.prod.outlook.com
 (2603:10a6:e10:15:cafe::65) by OL1P279CA0067.outlook.office365.com
 (2603:10a6:e10:15::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000529.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs5pRZmZB45+ClQh1tdIgHaqyPacC9ekY1Lj+V6VEBWFhI+IVAmu0zhuu7DHxYt8Jv91WFyt2puUUZ7ZFbskMGlRQeZYD66eF7tlR+O2UNr1JFD7p2psJkPVJvjuzrykEdPEG6mtP1BH/QWP6bya2c0fO5cSaVI3NTWUOtqSv5tD7aloBJiIMOu4plOrLyXWkFtnFWW0xZlW9mZ6TDK6RcO5uvBi/vjz5QZW+dvHRdXiB6kFPTgERqfPwZFoMPFd+cx+qqtVPyDxHINSuZxmrpQKE98J4/Hts0dcOQTRUBwZQq5O7cIaUC1VqMCT3f8b+Bs7p1g4kPtujctqaFhzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REcdvGKMkeaOw7L4knRzBUoUI/WA3xFmgPtUil10S3k=;
 b=THUwJ6e7LPwRG2foe0OaH1hXEXXjoYe/ZVl8YmY53tNI+9fM/zsompyij09HVAM60TN6NgBR/7iBAIkBx2kz/Z5D7p5xPeOaurQ79goFSKHgRc3y0wEPP4mkBosVql5JpWpBGwbBTrBO9U8ZmouTSjucDhStIDQ2b7ri5TbnA7vtQh8v7vd+nOVi5fVv+3baJlvScR1Asg/6o80hKesjY6wRHUeiJxr0Hn1SE00VzZklNChVwzOdlr/AFsZ3B3hQmkDyF/bfvyDbfJcBWjjQ3ZJdBcIEIdeh78ZClMX1yTFg6yfMaPZZGqgNbnpSbYAhCnazfnFGmzW1YOHJnPb6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REcdvGKMkeaOw7L4knRzBUoUI/WA3xFmgPtUil10S3k=;
 b=fLwbJ+HNZHWs2+EUXa/4qcbqg+sTz6v62YjXtWzjXFDUv7QLu47icO16g4wVPA2WWg06FG5qWDjzYyqUisBOMK0t3QLYqxENCxL7T8r1SwgAT6ZY/y77ASoUomqenWUp1nm+bhmi2LRaPjHmX0WaON1a1+pjFOqxaULg9z8QTwI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:46 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:46 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:53 +0100
Subject: [PATCH v7 6/8] drm/panthor: Implement sample handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-panthor-performance-counters-v7-6-12c32495062f@arm.com>
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
 nd@arm.com, =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|CPH1EPF00000529:EE_|MI3PR08MB11984:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2610d4-a69b-425d-54eb-08df27beb784
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: lLBP4WlvpGNSu6KwWhg2mzFB7xw6ygLauWEYNqQ4t5ljLxiEMDzmUcxDz/iSGvzLUACYatpsFlgeV9lmOjNmgK3syEjAjQ5w5k7eNWA1ZS/COFcFGaS4MdjGAiCbuKPUhl46YaWLYMQ2q9RkqCdqYbQN4N9cYHMZVTYOgqsbCmyfw9PqE7aAT2xJgU9pA0eKqF0Nz+gClrmmKea8IBK/Srz9gMnnvmkkuB+qrhqO3VwdVIPv7z0Qt/bNIsRoufPOZvXCTTTc0gqQU7n4PZxv7hJN8wFbidjlKTmoa4jHespK9yh2r2z41nm+jtK/tun8MhQtjwlNvLIloF1r1KdmLGEGL0u0aK0jw/zULzqw4GZX3L9hp7Mo5VzDGJm9ewtg1Mboh50DrEvw4pViNKMdI9YIjk3lk/8sOdoqTmTeGqEFxpvoWTgGcuNw4zblRfD0cOb58ywDJMivnOlr1HscZ+6WZJqXOIdKmyy9tNj1fIwh+QRcXnoNSOR3juLTXA6FQ0vgBHR5oHfxyQki5VM5+caiFcg9tf+yG4BgvuriuMDeo5BYxYxNBVxLHM9+xllaBxUXmpgsqS93YISA3Fp+yW28pDnArDetadxWN3sh1O+uNNN2aVYD2gfUu30OQrHeg5OIHBsYL+qdIo93GDJ8YsbMrsqZG9TUZh74K2m5sihG35PK/HEWvWFg/D/ClYyoB7/F2Ly/6Wu5wta1WuDANA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: s7u4JU/A2iRnV8Hwy1Bf+jaotHcCe7r87Ydqz3txNcx8D4B3Is7Q+byfE8QTDwevnExW/o3dIM84/PmSYSxcgDKyXsUkpy1sQ3XvL5nfD5l7WRxgWKkBwpgfLz4PBajNU63+AkkV7qxRaIG+NluOUIykoFieutUKnm0v3LRuqaesDmw3r1LiVLZ0AoufyXtExKj+2w4vv9iPBulQogZ6mJLZTl+R8YAC2w+kMBl++NVSHRskOc+JtZDzlvk99BmWFaRvOw7Vbs5ogMekgawaABCZstITwMju3qrGSjgfneF93p36YNrJWC43jUG4Yk5Xr3ZUHgklU1E+H8EG9L4vjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ee37973d-4a9c-4e51-2405-08df27bea427
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|35042699022|376014|14060799003|6133799003|18002099003|22082099003|10067099003|3023799007|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4TfZiwwanTtkkl4Hlglq0b80aZIe3leaNovo0T9k64fI/dBTLh1Z8Mgp+rboeOWiBYacHHzOyIzN6V8cZQ4Bsk4clU0MOvoSycHns0fFJs4h4DbsHrzI/hRPF0zuRkYsyAIiH9wlibpKj+mHqBTgV32WRk5UQXNiRyE2FOXjT/iO0P+6PzEFfrItsOfpx0rBb8LcU4yndyYN93Etbps1Mj/Snj6AfJ1fuI/4spynmPWSkq9f8MVnMmGbCalCHWcLzMgTQzgoerCdyjHfDnG2qyHkcFpICKELIqLqq9oAdNvoUwfG4BgVtoRiW9O2GXKp2AJH2sjTgtH8bz9C7j+EmqKr1amAwEI53aheUFgzlVZPf7SUM/bgLKCaeVV4yRxNNcYsRMf+uQnKSKqXqjecLYsSx1VAihhMZ/49C608dRHjdSna+tiQ1C4KfxDtKBX55ZZE/+c6dNWcTPDHNCMv3wGX4fOrWFJkCCohdsF9cMI6eOsS7SE0qMJpTkmvP++EijXnnapfiLmf89sYbaHqNJbxQfaPNaKcNF3kocbkPQTIrtB6VWFqqPdRnuziMcBO7j2OptQqYTfaGc8ipLGvNmj81wuT5W4pzTC/0IPZALB+D3xg5KxGqvjhqgNK7T52+3yl9W0UAHgkjJAl/sEjZroiMwTZzHZBN10mrx3NQENHorWj2M0KmT4Ur7VciulAQf7lCe1eImRKBn+Co5dA5jAKWyM0DqZ+k7zxb+0TtGAStL/10RSIq4ojFO20Jsh3
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(35042699022)(376014)(14060799003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hJwXh+dOkUWCh5QHYRoINGc1pmRikGtIHtVQjdjM1wcA94h16kEkSDEVmCaO2s+Kf77pZIJ3H90MWMKqS+/HQ/vB5Dw1z3vhRrwMoyOA0/V5CIkBN58HzG17Klo66/BnfGfQHjscDWeAMJLO+iCs/+5oEywI7RJTZgsu7ziZz0wpC1tLkAhFNZnDQud8KOTeJk6WJJPXoknTRHqNycmAkxGrqJME66SL92CbLC21HZsMA6p0avzpnVC9ABX7hPow2ZJt019wpW/f9Wa1t0kMESwq8x1k62V+LvgI0uhsDsHZagX5RDY43+0KpiIZ7FBQR5qZfeD5qBdcW9gCm8uY9WKOsOQumUahJl0zYoFmt1dK/hjfxezpGEM8MYQcWptkWoH79pl/nPv9HZQbRKhFZwWa8CrQQhc1VM52WRup+PMeR2GUT31u8CtiPa7rGl55
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:18.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2610d4-a69b-425d-54eb-08df27beb784
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11984
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

From: Adrián Larumbe <adrian.larumbe@collabora.com>

panthor_perf aggregates counter and set requests coming from userspace
and mediates interactions with the FW interface, to ensure that user
sessions cannot override the global configuration.

From the top-level interface, the two types of samples are supported:
clearing samples and regular samples. Clearing samples are
a special sample type that allow for the creation of a sampling
baseline, to ensure that a session does not obtain counter data from
before its creation.

Upon receipt of a relevant interrupt, corresponding to one of the
three relevant bits of the GLB_ACK register, panthor_perf takes any
samples that occurred, and, based on the insert and extract indices,
accumulates them to an internal storage buffer after zero-extending
the counters from the 32-bit counters emitted by the hardware to
64-bit counters for internal accumulation.

When the performance counters are enabled, the FW ensures no counter
data is lost when entering and leaving non-counting regions by
producing automatic samples that do not correspond to a
GLB_REQ.PRFCNT_SAMPLE request. Such regions may be per hardware unit,
such as when a shader core powers down, or global. Most of these
events do not directly correspond to session sample requests, so any
intermediary counter data must be stored into a temporary
accumulation buffer.

If there are sessions waiting for a sample, this accumulated buffer
will be taken, and emitted for each waiting client. During this phase,
information like the timestamps of sample request and sample emission,
type of the counter block and block index annotations are added to the
sample header and block headers. If no sessions are waiting for
a sample, this accumulation buffer is kept until the next time a
sample is requested.

Special handling is needed for the PRFCNT_OVERFLOW interrupt, which is
an indication that the internal sample handling rate was insufficient.

A semi-static table maintains the mappings between the offsets from
the base of a FW sample to the corresponding block type. Since the
counter blocks themselves do not contain this information, this needs to
be done in the kernel.

This table also handles the sparseness of the shader cores,
wherein the physical core mask contains holes, but the memory allocated
for it is done based on the position of the most significant bit. In
cases with highly sparse core masks, this means that a lot of shader
counter blocks are empty, and must be skipped.

The number of ring buffer slots is configurable through module param
to allow for a lower memory footprint on memory constrained systems.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Co-developed-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c   |    5 +
 drivers/gpu/drm/panthor/panthor_perf.c | 1075 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_perf.h |    2 +
 3 files changed, 1069 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13b..7d4b253bfe0c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -25,6 +25,7 @@
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_sched.h"
 #include "panthor_trace.h"
 
@@ -1072,9 +1073,12 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 
 	/* Enable interrupts we care about. */
 	glb_iface->input->ack_irq_mask = GLB_CFG_ALLOC_EN |
+					 GLB_PERFCNT_SAMPLE |
 					 GLB_PING |
 					 GLB_CFG_PROGRESS_TIMER |
 					 GLB_CFG_POWEROFF_TIMER |
+					 GLB_PERFCNT_THRESHOLD |
+					 GLB_PERFCNT_OVERFLOW |
 					 GLB_IDLE_EN |
 					 GLB_IDLE;
 
@@ -1122,6 +1126,7 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
 			duration = U32_MAX;
 		trace_gpu_job_irq(ptdev->base.dev, status, duration);
 	}
+	panthor_perf_report_irq(ptdev, status);
 }
 
 static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index 76c346981150..c66ad658a95d 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -11,8 +11,11 @@
 
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_fw_regs.h"
+#include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
+#include "panthor_mmu.h"
 #include "panthor_perf.h"
 
 /**
@@ -36,6 +39,76 @@
  */
 #define PANTHOR_PERF_EM_BITS (BITS_PER_TYPE(u64) * 2)
 
+/**
+ * PANTHOR_CTR_TIMESTAMP_LO - The first architecturally mandated counter of every block type
+ *                            contains the low 32-bits of the TIMESTAMP value.
+ */
+#define PANTHOR_CTR_TIMESTAMP_LO (0)
+
+/**
+ * PANTHOR_CTR_TIMESTAMP_HI - The register offset containinig the high 32-bits of the TIMESTAMP
+ *                            value.
+ */
+#define PANTHOR_CTR_TIMESTAMP_HI (1)
+
+/**
+ * PANTHOR_CTR_PRFCNT_EN - The register offset containing the enable mask for the enabled counters
+ *                         that were written to memory.
+ */
+#define PANTHOR_CTR_PRFCNT_EN (2)
+
+/**
+ * PANTHOR_HEADER_COUNTERS - The first four counters of every block type are architecturally
+ *                           defined to be equivalent. The fourth counter is always reserved,
+ *                           and should be zero and as such, does not have a separate define.
+ *
+ *                           These are the only four counters that are the same between different
+ *                           blocks and are consistent between different architectures.
+ */
+#define PANTHOR_HEADER_COUNTERS (4)
+
+/**
+ * PANTHOR_CTR_SAMPLE_REASON - The metadata block has a single value in position three which
+ *                             indicates the reason a sample was taken.
+ */
+#define PANTHOR_CTR_SAMPLE_REASON (3)
+
+/**
+ * PANTHOR_PERF_RINGBUF_SLOTS_MIN - The minimum permitted number of slots in the Panthor perf
+ *                                  ring buffer.
+ */
+#define PANTHOR_PERF_RINGBUF_SLOTS_MIN (16)
+
+/**
+ * PANTHOR_PERF_RINGBUF_SLOTS_MAX - The maximum permitted number of slots in the Panthor perf
+ *                                  ring buffer.
+ */
+#define PANTHOR_PERF_RINGBUF_SLOTS_MAX (256)
+
+static unsigned int perf_ringbuf_slots = 32;
+
+static int perf_ringbuf_slots_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int slots;
+	int ret = kstrtouint(val, 0, &slots);
+
+	if (ret)
+		return ret;
+
+	if (!is_power_of_2(slots))
+		return -EINVAL;
+
+	return param_set_uint_minmax(val, kp, 16, 128);
+}
+
+static const struct kernel_param_ops perf_ringbuf_ops = {
+	.set = perf_ringbuf_slots_set,
+	.get = param_get_uint,
+};
+module_param_cb(perf_ringbuf_slots, &perf_ringbuf_ops, &perf_ringbuf_slots, 0400);
+MODULE_PARM_DESC(perf_ringbuf_slots,
+		 "Power of two slots allocated for the Panthor perf kernel-FW ringbuffer");
+
 enum panthor_perf_session_state {
 	/** @PANTHOR_PERF_SESSION_STOPPED: The session cannot sample. It starts out stopped. */
 	PANTHOR_PERF_SESSION_STOPPED = 0,
@@ -68,12 +141,33 @@ struct panthor_perf_counter_block {
 	u64 counters[];
 };
 
+struct panthor_perf_fw_block {
+	/** @block_count: Number of blocks of the given @type in the FW ringbuffer. */
+	size_t block_count;
+
+	/** @phys_mask: Bitmask of the physically available blocks. */
+	u64 phys_mask;
+};
+
 struct panthor_perf_bo {
 	struct drm_gem_object *obj;
 	void *vaddr;
 };
 
+struct panthor_perf_sample_block_iter {
+	const u8 *src;
+	u8 *dst;
+	size_t offset;
+	size_t data_size;
+	size_t block_size;
+	const struct panthor_perf_counter_block *src_blk;
+	struct panthor_perf_counter_block *dst_blk;
+};
+
 struct panthor_perf_session {
+	/** @state_wq: Wait queue for state transitions driven by the sampling path. */
+	wait_queue_head_t state_wq;
+
 	/** @state_lock: Used to protect session state information and overflow bit. */
 	struct mutex state_lock;
 
@@ -92,6 +186,12 @@ struct panthor_perf_session {
 	 */
 	u64 accum_idx;
 
+	/** @pending_sample: Whether this session has a sample requested on it. */
+	bool pending_sample;
+
+	/** @sample_flags: Accumulated @drm_panthor_perf_sample_flags for the pending sample. */
+	u32 sample_flags;
+
 	/** @sample_start_ns: Sample request time, obtained from a monotonic raw clock. */
 	u64 sample_start_ns;
 
@@ -148,11 +248,88 @@ struct panthor_perf {
 	/** @info: Pointer to the previously initialized perf info. */
 	struct drm_panthor_perf_info *info;
 
+	/** @rb: Kernel BO in the FW AS containing the sample ringbuffer. */
+	struct panthor_kernel_bo *rb;
+
+	/** @sample_slots: Number of sample slots in the FW ringbuffer. */
+	size_t sample_slots;
+
+	/** @em: Combined enable mask for all of the active sessions. */
+	struct panthor_perf_enable_masks *em;
+
 	/**
-	 * @op_lock: Serializes session operations. Acquire before looking up session
-	 *           handles and before a session's state_lock.
+	 * @fw_block_size: The size of a single block in the FW ring buffer, equal to
+	 *                 sizeof(u32) * counters_per_block.
+	 */
+	size_t fw_block_size;
+
+	/**
+	 * @fw_sample_size: The size of a single FW sample in the FW ringbuffer.
+	 */
+	size_t fw_sample_size;
+
+	/**
+	 * @blocks: FW block layout for one sample. Metadata blocks are consumed
+	 *          internally and omitted from userspace samples.
+	 */
+	struct panthor_perf_fw_block blocks[DRM_PANTHOR_PERF_BLOCK_MAX];
+
+	/**
+	 * @sample: Pointer to an upscaled and annotated sample that may be emitted to userspace.
+	 *          This is used both as an intermediate buffer to do the zero-extension of the
+	 *          32-bit counters to 64-bits and as a storage buffer in case of automatic samples.
+	 */
+	u8 *sample;
+
+	/**
+	 * @op_lock: Serializes session operations and global FW configuration. Acquire
+	 *           before looking up session handles and before @session_lock or a
+	 *           session's state_lock. The sample worker must not acquire this lock,
+	 *           so synchronous session operations can wait for sample delivery.
+	 *           Runtime-PM references must be acquired and released outside this
+	 *           lock, as the PM callbacks also acquire it.
 	 */
 	struct mutex op_lock;
+
+	/**
+	 * @session_lock: Lock used to guard the @session_list.
+	 */
+	struct mutex session_lock;
+
+	/** @session_list: List of all sessions. */
+	struct list_head session_list;
+
+	/** @pend_lock: Lock used to guard the requested sample field. */
+	spinlock_t pend_lock;
+
+
+	/** @fw_sample_requested: A sample has been requested. */
+	bool fw_sample_requested;
+
+	/** @set_config: The set that will be configured onto the hardware. */
+	u8 set_config;
+
+	/** @last_fw_sample_time: The CPU-side timestamp of the latest consumed FW sample. */
+	u64 last_fw_sample_time;
+
+	/** @sample_workq: Workqueue to handle and accumulate samples. */
+	struct workqueue_struct *sample_workq;
+
+	/** @sample_work: Worker to consume available FW samples and expose them to the user. */
+	struct work_struct sample_work;
+
+	/**
+	 * @ptdev: Backpointer to the Panthor device, needed to ring the global doorbell and
+	 *         interface with FW.
+	 */
+	struct panthor_device *ptdev;
+};
+
+struct panthor_perf_fw_block_iter {
+	const struct panthor_perf *perf_ctx;
+	enum drm_panthor_perf_block_type type;
+	u32 idx;
+	size_t offset;
 };
 
 struct panthor_perf_pool {
@@ -171,6 +348,33 @@ static size_t get_annotated_block_size(size_t counters_per_block)
 	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
 }
 
+static void
+sample_block_iter_init(const struct drm_panthor_perf_info *info,
+		       const u8 *src, u8 *dst,
+		       struct panthor_perf_sample_block_iter *iter)
+{
+	const size_t sample_header_size = info->sample_header_size;
+
+	*iter = (struct panthor_perf_sample_block_iter) {
+		.src = src + sample_header_size,
+		.dst = dst + sample_header_size,
+		.data_size = info->sample_size - sample_header_size,
+		.block_size = get_annotated_block_size(info->counters_per_block),
+	};
+}
+
+static bool sample_block_iter_next(struct panthor_perf_sample_block_iter *iter)
+{
+	if (iter->offset >= iter->data_size)
+		return false;
+
+	iter->src_blk = (const struct panthor_perf_counter_block *)(iter->src + iter->offset);
+	iter->dst_blk = (struct panthor_perf_counter_block *)(iter->dst + iter->offset);
+	iter->offset += iter->block_size;
+
+	return true;
+}
+
 static size_t session_get_sample_size(const struct drm_panthor_perf_info *const info)
 {
 	const size_t block_size = get_annotated_block_size(info->counters_per_block);
@@ -239,6 +443,30 @@ session_get(struct panthor_perf_session *session)
 	return session;
 }
 
+static void panthor_perf_em_add(struct panthor_perf_enable_masks *const dst_em,
+				const struct panthor_perf_enable_masks *const src_em)
+{
+	size_t i = 0;
+
+	for (i = DRM_PANTHOR_PERF_BLOCK_FIRST; i <= DRM_PANTHOR_PERF_BLOCK_LAST; i++)
+		bitmap_or(dst_em->mask[i], dst_em->mask[i], src_em->mask[i], PANTHOR_PERF_EM_BITS);
+}
+
+static u64 session_read_extract_idx(struct panthor_perf_session *session)
+{
+	/* Userspace will update their own extract index to indicate that a sample is consumed
+	 * from the ringbuffer, and we must ensure we read the latest value.
+	 */
+	return smp_load_acquire(&session->control->extract_idx);
+}
+
+static void session_write_insert_idx(struct panthor_perf_session *session, u64 idx)
+{
+	/* Userspace needs the insert index to know where to look for the sample. */
+	smp_store_release(&session->control->insert_idx, idx);
+	session->insert_idx = idx;
+}
+
 static int
 panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t expected_size,
 		    struct panthor_perf_bo *bo)
@@ -338,6 +566,277 @@ session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
 	return session;
 }
 
+static u32 compress_enable_mask(u32 counters, const unsigned long *const src)
+{
+	size_t i;
+	u32 result = 0;
+	const unsigned long ctr_per_bit = counters / BITS_PER_TYPE(u32);
+
+	for_each_set_bit(i, src, counters) {
+		const unsigned long pos = div_u64(i, ctr_per_bit);
+
+		result |= BIT(pos);
+	}
+
+	return result;
+}
+
+static void expand_enable_mask(u32 counters, u32 em, unsigned long *const dst)
+{
+	size_t i;
+	const unsigned long ctrs_per_bit = counters / BITS_PER_TYPE(u32);
+	DECLARE_BITMAP(emb, BITS_PER_TYPE(u32));
+
+	bitmap_from_arr32(emb, &em, BITS_PER_TYPE(u32));
+
+	for_each_set_bit(i, emb, BITS_PER_TYPE(u32))
+		bitmap_set(dst, i * ctrs_per_bit, ctrs_per_bit);
+}
+
+static inline bool
+panthor_perf_fw_block_iter_valid(struct panthor_perf_fw_block_iter *iter)
+{
+	const struct panthor_perf *perf = iter->perf_ctx;
+
+	while (iter->type < DRM_PANTHOR_PERF_BLOCK_MAX) {
+		if (iter->idx < perf->blocks[iter->type].block_count)
+			return true;
+
+		iter->type++;
+		iter->idx = 0;
+	}
+
+	return false;
+}
+
+static void panthor_perf_handle_fw_samples(struct panthor_device *ptdev,
+					   u32 extract_idx, u32 insert_idx)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	const size_t ann_block_size =
+		get_annotated_block_size(ptdev->perf_info.counters_per_block);
+	u32 i;
+
+	for (i = extract_idx; i != insert_idx; i++) {
+		u32 slot = i % perf->sample_slots;
+		u8 *fw_sample = (u8 *)perf->rb->kmap + slot * perf->fw_sample_size;
+		struct panthor_perf_fw_block_iter fw_iter = { .perf_ctx = perf };
+		size_t ann_off = ptdev->perf_info.sample_header_size;
+
+		for (; panthor_perf_fw_block_iter_valid(&fw_iter);
+		     fw_iter.offset += fw_iter.perf_ctx->fw_block_size, fw_iter.idx++) {
+			struct panthor_perf_counter_block *blk =
+				(typeof(blk))(perf->sample + ann_off);
+			u32 *const block = (u32 *)(fw_sample + fw_iter.offset);
+			const u32 prfcnt_en = block[PANTHOR_CTR_PRFCNT_EN];
+
+			if (fw_iter.type == DRM_PANTHOR_PERF_BLOCK_METADATA) {
+				/*
+				 * The host must clear the SAMPLE_REASON to acknowledge it has
+				 * consumed the sample.
+				 */
+				block[PANTHOR_CTR_SAMPLE_REASON] = 0;
+				continue;
+			}
+
+			if (!(perf->blocks[fw_iter.type].phys_mask & BIT_ULL(fw_iter.idx)))
+				continue;
+
+			blk->header = (struct drm_panthor_perf_block_header) {
+				.block_idx = fw_iter.idx,
+				.block_type = fw_iter.type,
+			};
+
+			if (prfcnt_en == 0)
+				goto advance_block;
+
+			/*
+			 * The four header counters must be treated differently, because they are
+			 * not additive. For the fourth, the assignment does not matter, as it
+			 * is reserved and should be zero.
+			 */
+			blk->counters[PANTHOR_CTR_TIMESTAMP_LO] = block[PANTHOR_CTR_TIMESTAMP_LO];
+			blk->counters[PANTHOR_CTR_TIMESTAMP_HI] = block[PANTHOR_CTR_TIMESTAMP_HI];
+			blk->counters[PANTHOR_CTR_PRFCNT_EN] = block[PANTHOR_CTR_PRFCNT_EN];
+
+			/*
+			 * The host must clear PRFCNT_EN to acknowledge it has consumed the sample.
+			 */
+			block[PANTHOR_CTR_PRFCNT_EN] = 0;
+
+			if (prfcnt_en == 1)
+				goto advance_block;
+
+			for (size_t k = PANTHOR_HEADER_COUNTERS;
+			     k < ptdev->perf_info.counters_per_block; k++)
+				blk->counters[k] += block[k];
+
+advance_block:
+			ann_off += ann_block_size;
+		}
+
+		perf->last_fw_sample_time = ktime_get_raw_ns();
+	}
+}
+
+static size_t panthor_perf_get_fw_reported_size(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+
+	size_t fw_size = GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size);
+	size_t hw_size = GLB_PERFCNT_HW_SIZE(glb_iface->control->perfcnt_size);
+	size_t md_size = PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features);
+
+	return md_size + fw_size + hw_size;
+}
+
+static size_t get_reserved_sc_blocks(struct panthor_device *ptdev)
+{
+	const u64 sc_mask = ptdev->gpu_info.shader_present;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 14)
+		return fls64(sc_mask);
+
+	return ptdev->perf_info.shader_blocks;
+}
+
+#define BLK_MASK(x) GENMASK_ULL((x) - 1, 0)
+
+static u64 get_sc_mask(struct panthor_device *ptdev)
+{
+	const u64 sc_mask = ptdev->gpu_info.shader_present;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 14)
+		return sc_mask;
+
+	return BLK_MASK(hweight64(sc_mask));
+}
+
+static int panthor_perf_setup_fw_buffer(struct panthor_device *ptdev, struct panthor_perf *perf)
+{
+	struct drm_panthor_perf_info *info = &ptdev->perf_info;
+	const size_t block_size = info->counters_per_block * PANTHOR_HW_COUNTER_SIZE;
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	const size_t reported_sample_size = panthor_perf_get_fw_reported_size(ptdev);
+	const bool has_metadata = PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features);
+	const struct panthor_perf_fw_block blocks[DRM_PANTHOR_PERF_BLOCK_MAX] = {
+		[DRM_PANTHOR_PERF_BLOCK_METADATA] = {
+			.block_count = has_metadata ? 1 : 0,
+			.phys_mask = has_metadata ? BIT_ULL(0) : 0,
+		},
+		[DRM_PANTHOR_PERF_BLOCK_FW] = {
+			.block_count = info->fw_blocks,
+			.phys_mask = info->fw_blocks ? BLK_MASK(info->fw_blocks) : 0,
+		},
+		[DRM_PANTHOR_PERF_BLOCK_CSHW] = {
+			.block_count = info->cshw_blocks,
+			.phys_mask = BLK_MASK(info->cshw_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_TILER] = {
+			.block_count = info->tiler_blocks,
+			.phys_mask = BLK_MASK(info->tiler_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_MEMSYS] = {
+			.block_count = info->memsys_blocks,
+			.phys_mask = BLK_MASK(info->memsys_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_SHADER] = {
+			.block_count = get_reserved_sc_blocks(ptdev),
+			.phys_mask = get_sc_mask(ptdev),
+		},
+	};
+	size_t offset = 0;
+
+	for (enum drm_panthor_perf_block_type type = 0; type < DRM_PANTHOR_PERF_BLOCK_MAX; type++)
+		offset += blocks[type].block_count * block_size;
+
+	if (offset != reported_sample_size) {
+		drm_warn(&ptdev->base,
+				"Could not align fw and kernel perf buffers, feature disabled.");
+		return -EINVAL;
+	}
+
+	memcpy(perf->blocks, blocks, sizeof(blocks));
+	perf->fw_block_size = block_size;
+	perf->fw_sample_size = offset;
+
+	return 0;
+}
+
+static int panthor_perf_fw_stop_sampling(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	u32 acked;
+	int ret;
+
+	if (~READ_ONCE(glb_iface->input->req) & GLB_PERFCNT_ENABLE)
+		return 0;
+
+	panthor_fw_update_reqs(glb_iface, req, 0, GLB_PERFCNT_ENABLE);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PERFCNT_ENABLE, &acked, 100);
+	if (ret)
+		drm_warn(&ptdev->base, "Could not disable performance counters");
+
+	return ret;
+}
+
+static int panthor_perf_fw_start_sampling(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	u32 acked;
+	int ret;
+
+	if (READ_ONCE(glb_iface->input->req) & GLB_PERFCNT_ENABLE)
+		return 0;
+
+	/*
+	 * The spec mandates that the host zero the PRFCNT_EXTRACT register before an enable
+	 * operation, and each (re-)enable will require an enable-disable pair to program
+	 * the new changes onto the FW interface.
+	 */
+	WRITE_ONCE(glb_iface->input->perfcnt_extract, 0);
+
+	panthor_fw_update_reqs(glb_iface, req, GLB_PERFCNT_ENABLE, GLB_PERFCNT_ENABLE);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PERFCNT_ENABLE, &acked, 100);
+	if (ret)
+		drm_warn(&ptdev->base, "Could not enable performance counters");
+
+	return ret;
+}
+
+static void panthor_perf_fw_write_config(struct panthor_perf *perf)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(perf->ptdev);
+	const u32 counters = perf->info->counters_per_block;
+	const struct panthor_perf_enable_masks *const em = perf->em;
+	u32 perfcnt_config;
+
+	glb_iface->input->perfcnt_csf_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_CSHW]);
+	glb_iface->input->perfcnt_shader_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_SHADER]);
+	glb_iface->input->perfcnt_mmu_l2_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_MEMSYS]);
+	glb_iface->input->perfcnt_tiler_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_TILER]);
+	glb_iface->input->perfcnt_fw_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_FW]);
+	glb_iface->input->perfcnt_csg_enable = 0;
+
+	WRITE_ONCE(glb_iface->input->perfcnt_as, panthor_vm_as(panthor_fw_vm(perf->ptdev)));
+	WRITE_ONCE(glb_iface->input->perfcnt_base, panthor_kernel_bo_gpuva(perf->rb));
+
+	perfcnt_config = GLB_PERFCNT_CONFIG_SIZE(perf_ringbuf_slots);
+	perfcnt_config |= GLB_PERFCNT_CONFIG_SET(perf->set_config);
+
+	if (PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features))
+		perfcnt_config |= GLB_PERFCNT_METADATA_ENABLE;
+
+	WRITE_ONCE(glb_iface->input->perfcnt_config, perfcnt_config);
+}
+
 #define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
 	static bool session_is_## name(struct panthor_perf_session *session) \
 	{								     \
@@ -349,6 +848,7 @@ session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
 DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
 DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
 DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
+DEFINE_SESSION_STATE_CHECK(stopped, PANTHOR_PERF_SESSION_STOPPED);
 
 static bool session_has_overflow(struct panthor_perf_session *session)
 {
@@ -365,6 +865,388 @@ static void session_set_state(struct panthor_perf_session *session,
 	session->state = state;
 }
 
+static bool session_has_space(struct panthor_perf_session *session, u32 needed)
+{
+	const u64 insert = session->insert_idx;
+	const u64 extract = session_read_extract_idx(session);
+
+	return insert - extract + needed <= session->ringbuf_slots;
+}
+
+/**
+ * session_accumulate_sample - Accumulate requested counters into an existing sample.
+ * @ptdev: Panthor device.
+ * @session: Perf session.
+ * @session_sample: Start of the destination sample, including its header.
+ * @perf_sample: Start of the intermediate sample, including its header.
+ *
+ * Firmware enable masks select groups of counters. Copy timestamps and accumulate
+ * only the counters requested by this session.
+ */
+static void session_accumulate_sample(struct panthor_device *ptdev,
+				      struct panthor_perf_session *session,
+				      u8 *session_sample, u8 *perf_sample)
+{
+	const struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+	struct panthor_perf_enable_masks *em = session->enabled_counters;
+	struct panthor_perf_sample_block_iter iter;
+	const u32 counters = perf_info->counters_per_block;
+
+	sample_block_iter_init(perf_info, perf_sample, session_sample, &iter);
+
+	while (sample_block_iter_next(&iter)) {
+		DECLARE_BITMAP(enabled_ctrs, PANTHOR_PERF_EM_BITS);
+		const struct panthor_perf_counter_block *src_blk = iter.src_blk;
+		struct panthor_perf_counter_block *dst_blk = iter.dst_blk;
+
+		bitmap_from_arr64(enabled_ctrs, em->mask[dst_blk->header.block_type],
+				  PANTHOR_PERF_EM_BITS);
+		bitmap_clear(enabled_ctrs, 0, PANTHOR_HEADER_COUNTERS);
+
+		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =
+			src_blk->counters[PANTHOR_CTR_TIMESTAMP_HI];
+		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =
+			src_blk->counters[PANTHOR_CTR_TIMESTAMP_LO];
+
+		for (size_t ctr_idx = PANTHOR_HEADER_COUNTERS; ctr_idx < counters; ctr_idx++)
+			if (test_bit(ctr_idx, enabled_ctrs))
+				dst_blk->counters[ctr_idx] += src_blk->counters[ctr_idx];
+	}
+}
+
+static void perf_fw_request_sample(struct panthor_perf *perf)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(perf->ptdev);
+	bool sample;
+
+	scoped_guard(spinlock_irqsave, &perf->pend_lock) {
+		sample = !perf->fw_sample_requested;
+
+		if (sample)
+			perf->fw_sample_requested = true;
+	}
+
+	if (sample) {
+		panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PERFCNT_SAMPLE);
+		panthor_fw_ring_doorbell(perf->ptdev, CSF_GLB_DOORBELL_ID);
+	}
+}
+
+/**
+ * session_populate_sample - Populate a new userspace sample slot.
+ * @ptdev: Panthor device.
+ * @session: Perf session.
+ * @session_sample: Start of the destination sample, including its header.
+ * @perf_sample: Start of the intermediate sample, including its header.
+ *
+ * Copy the counter blocks and clear counters not requested by this session.
+ * Update each block's PRFCNT_EN value to reflect this session's enable mask.
+ * The sample header is filled when the sample is published.
+ */
+static void session_populate_sample(struct panthor_device *ptdev,
+				    struct panthor_perf_session *session, u8 *session_sample,
+				    u8 *perf_sample)
+{
+	const struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+	struct panthor_perf_sample_block_iter iter;
+	const size_t sample_header_size = perf_info->sample_header_size;
+	const size_t data_size = perf_info->sample_size - sample_header_size;
+	const u32 counters = perf_info->counters_per_block;
+
+	memcpy(session_sample + sample_header_size, perf_sample + sample_header_size, data_size);
+
+	sample_block_iter_init(perf_info, perf_sample, session_sample, &iter);
+
+	while (sample_block_iter_next(&iter)) {
+		DECLARE_BITMAP(em_diff, PANTHOR_PERF_EM_BITS);
+		DECLARE_BITMAP(enabled_ctrs, PANTHOR_PERF_EM_BITS);
+		struct panthor_perf_counter_block *blk = iter.dst_blk;
+		enum drm_panthor_perf_block_type type = blk->header.block_type;
+		unsigned long *blk_em = session->enabled_counters->mask[type];
+		const u32 blk_prfcnt_en = blk->counters[PANTHOR_CTR_PRFCNT_EN];
+
+		bitmap_zero(enabled_ctrs, PANTHOR_PERF_EM_BITS);
+		expand_enable_mask(counters, blk_prfcnt_en, enabled_ctrs);
+		bitmap_andnot(em_diff, enabled_ctrs, blk_em, PANTHOR_PERF_EM_BITS);
+		bitmap_clear(em_diff, 0, PANTHOR_HEADER_COUNTERS);
+
+		blk->counters[PANTHOR_CTR_PRFCNT_EN] = compress_enable_mask(counters, blk_em);
+
+		for (size_t ctr_idx = PANTHOR_HEADER_COUNTERS; ctr_idx < counters; ctr_idx++) {
+			if (test_bit(ctr_idx, em_diff))
+				blk->counters[ctr_idx] = 0;
+		}
+	}
+}
+
+static void session_copy_sample(struct panthor_device *ptdev,
+				struct panthor_perf_session *session, u32 flags)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	const size_t sample_size = ptdev->perf_info.sample_size;
+	const u64 insert_idx = session->insert_idx;
+	u8 *new_sample;
+
+	scoped_guard(mutex, &session->state_lock) {
+		if (flags & DRM_PANTHOR_PERF_SAMPLE_OVERFLOW)
+			session->overflow = true;
+
+		if (session_is_starting(session) ||
+		    (!session_is_active(session) && !session_is_stopping(session)))
+			return;
+	}
+
+	new_sample = session->samples + (insert_idx % session->ringbuf_slots) * sample_size;
+
+	if (session->accum_idx != insert_idx) {
+		session->sample_flags = flags;
+		session_populate_sample(ptdev, session, new_sample, perf->sample);
+		session->accum_idx = insert_idx;
+	} else {
+		session->sample_flags |= flags;
+		session_accumulate_sample(ptdev, session, new_sample, perf->sample);
+	}
+}
+
+static void session_publish_sample(struct panthor_perf *perf,
+				   struct panthor_perf_session *session)
+{
+	const struct drm_panthor_perf_info *const info = &perf->ptdev->perf_info;
+	u8 *sample = session->samples +
+		(session->insert_idx % session->ringbuf_slots) * info->sample_size;
+	struct drm_panthor_perf_sample_header *hdr = (typeof(hdr))sample;
+
+	*hdr = (struct drm_panthor_perf_sample_header) {
+		.user_data = session->user_data,
+		.timestamp_start_ns = session->sample_start_ns,
+		.timestamp_end_ns = perf->last_fw_sample_time,
+		.flags = session->sample_flags,
+	};
+
+	session_write_insert_idx(session, session->insert_idx + 1);
+
+	/* Order sample and insert-index writes before the eventfd notification. */
+	wmb();
+
+	eventfd_signal(session->eventfd);
+}
+
+static void session_emit_sample(struct panthor_perf *perf, struct panthor_perf_session *session)
+{
+	guard(mutex)(&session->state_lock);
+
+	if (session_is_starting(session)) {
+		session_set_state(session, PANTHOR_PERF_SESSION_ACTIVE);
+		goto update_session;
+	}
+
+	if (session_is_stopping(session)) {
+		session_publish_sample(perf, session);
+		goto handle_stopping;
+	}
+
+	if (!session_is_active(session))
+		return;
+
+	if (session->pending_sample) {
+		session->pending_sample = false;
+		session_publish_sample(perf, session);
+		goto update_session;
+	}
+
+	return;
+
+handle_stopping:
+	if (session_is_stopping(session))
+		session_set_state(session, PANTHOR_PERF_SESSION_STOPPED);
+
+update_session:
+	session->sample_flags = 0;
+	session->sample_start_ns = perf->last_fw_sample_time;
+	wake_up_all(&session->state_wq);
+}
+
+static void panthor_perf_sample_worker(struct work_struct *work)
+{
+	struct panthor_perf *perf = container_of(work, struct panthor_perf, sample_work);
+	struct panthor_device *const ptdev = perf->ptdev;
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	const u32 extract_idx = READ_ONCE(glb_iface->input->perfcnt_extract);
+	const u32 insert_idx = READ_ONCE(glb_iface->output->perfcnt_insert);
+	const u32 ack = READ_ONCE(glb_iface->output->ack);
+	const u32 req = READ_ONCE(glb_iface->input->req);
+	const u32 events = (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT_OVERFLOW);
+	const u32 flags = events & GLB_PERFCNT_OVERFLOW ? DRM_PANTHOR_PERF_SAMPLE_OVERFLOW : 0;
+
+	/* Defer sample processing until the pending reset completes. */
+	if (panthor_device_reset_is_pending(ptdev)) {
+		queue_work(perf->sample_workq, &perf->sample_work);
+		return;
+	}
+
+	/* A stale notification must not complete a userspace sample request. */
+	if (extract_idx == insert_idx)
+		goto ack_events;
+
+	panthor_perf_handle_fw_samples(ptdev, extract_idx, insert_idx);
+	WRITE_ONCE(glb_iface->input->perfcnt_extract, insert_idx);
+
+	scoped_guard(mutex, &perf->session_lock) {
+		struct panthor_perf_session *session;
+
+		list_for_each_entry(session, &perf->session_list, sessions)
+			session_copy_sample(ptdev, session, flags);
+
+		list_for_each_entry(session, &perf->session_list, sessions)
+			session_emit_sample(perf, session);
+	}
+
+	memset(perf->sample, 0, ptdev->perf_info.sample_size);
+
+ack_events:
+	if (events)
+		panthor_fw_update_reqs(glb_iface, req, ack, events);
+}
+
+void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct panthor_perf *const perf = ptdev->perf;
+
+	if (!(status & JOB_INT_GLOBAL_IF))
+		return;
+
+	if (!perf)
+		return;
+
+	const u32 ack = READ_ONCE(glb_iface->output->ack);
+	const u32 req = READ_ONCE(glb_iface->input->req);
+	const u32 events = (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT_OVERFLOW);
+	const bool sample_acked = ((req & GLB_PERFCNT_SAMPLE) == (ack & GLB_PERFCNT_SAMPLE));
+	const u32 extract_idx = READ_ONCE(glb_iface->input->perfcnt_extract);
+	const u32 insert_idx = READ_ONCE(glb_iface->output->perfcnt_insert);
+	const bool has_sample = sample_acked && insert_idx != extract_idx;
+
+	if (sample_acked) {
+		guard(spinlock_irqsave)(&perf->pend_lock);
+		perf->fw_sample_requested = false;
+	}
+
+	if (events || has_sample)
+		queue_work(perf->sample_workq, &perf->sample_work);
+}
+
+static int perf_enable(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->op_lock);
+
+	guard(mutex)(&perf->session_lock);
+
+	if (list_empty(&perf->session_list))
+		return 0;
+
+	panthor_perf_fw_write_config(perf);
+	return panthor_perf_fw_start_sampling(perf->ptdev);
+}
+
+static int perf_disable(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->op_lock);
+
+	guard(mutex)(&perf->session_lock);
+
+	if (list_empty(&perf->session_list))
+		return 0;
+
+	return panthor_perf_fw_stop_sampling(perf->ptdev);
+}
+
+static void compute_enable_mask(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->session_lock);
+
+	struct list_head *snode;
+	struct panthor_perf_enable_masks em = {};
+
+	list_for_each(snode, &perf->session_list)
+	{
+		struct panthor_perf_session *session =
+			container_of(snode, typeof(*session), sessions);
+
+		panthor_perf_em_add(&em, session->enabled_counters);
+	}
+
+	*perf->em = em;
+}
+
+static void perf_attach_session(struct panthor_perf *perf, struct panthor_perf_session *session)
+{
+	lockdep_assert_held(&perf->session_lock);
+
+	session_get(session);
+	list_add_tail(&session->sessions, &perf->session_list);
+	compute_enable_mask(perf);
+}
+
+static void perf_detach_session(struct panthor_perf *perf, struct panthor_perf_session *session)
+{
+	lockdep_assert_held(&perf->session_lock);
+
+	list_del_init(&session->sessions);
+	compute_enable_mask(perf);
+	session_put(session);
+}
+
+static int panthor_perf_session_add(struct panthor_perf *perf,
+				    struct panthor_perf_session *session, u8 set)
+{
+	int ret = 0;
+
+	guard(mutex)(&perf->op_lock);
+
+	scoped_guard(mutex, &perf->session_lock) {
+		if (!list_empty(&perf->session_list))
+			return -EBUSY;
+
+		perf->set_config = set;
+	}
+
+	ret = perf_disable(perf);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &perf->session_lock)
+		perf_attach_session(perf, session);
+
+	ret = perf_enable(perf);
+	if (ret)
+		goto drop_session_ref;
+
+	return ret;
+drop_session_ref:
+	scoped_guard(mutex, &perf->session_lock)
+		perf_detach_session(perf, session);
+
+	return ret;
+}
+
+static int panthor_perf_session_remove(struct panthor_perf *perf,
+				       struct panthor_perf_session *session)
+{
+	guard(mutex)(&perf->op_lock);
+
+	/*
+	 * Even if the disable fails,  the session must be removed, so the error
+	 * is ignored.
+	 */
+	perf_disable(perf);
+
+	scoped_guard(mutex, &perf->session_lock)
+		perf_detach_session(perf, session);
+
+	return perf_enable(perf);
+}
+
 /**
  * panthor_perf_init - Initialize the performance counter subsystem.
  * @ptdev: Panthor device
@@ -377,7 +1259,10 @@ static void session_set_state(struct panthor_perf_session *session,
 int panthor_perf_init(struct panthor_device *ptdev)
 {
 	struct panthor_perf *perf;
-	int ret = 0;
+	struct panthor_kernel_bo *bo;
+	struct panthor_perf_enable_masks *em;
+	u8 *sample;
+	int ret;
 
 	if (!ptdev)
 		return -EINVAL;
@@ -392,12 +1277,107 @@ int panthor_perf_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_mutex_init(&ptdev->base, &perf->session_lock);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&perf->pend_lock);
+
+	ret = panthor_perf_setup_fw_buffer(ptdev, perf);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"Failed to setup FW ring buffer, disabling perf.");
+		return -EOPNOTSUPP;
+	}
+
+	sample = drmm_kzalloc(&ptdev->base, ptdev->perf_info.sample_size, GFP_KERNEL);
+	if (!sample)
+		return -ENOMEM;
+
+	em = drmm_kzalloc(&ptdev->base, sizeof(*em), GFP_KERNEL);
+	if (!em)
+		return -ENOMEM;
+
+	bo = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
+				      perf->fw_sample_size * perf_ringbuf_slots,
+				      DRM_PANTHOR_BO_NO_MMAP,
+				      DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
+				      DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
+				      PANTHOR_VM_KERNEL_AUTO_VA,
+				      "perf_ringbuf");
+
+	if (IS_ERR_OR_NULL(bo))
+		return IS_ERR(bo) ? PTR_ERR(bo) : -ENOMEM;
+
+	ret = panthor_kernel_bo_vmap(bo);
+	if (ret)
+		goto cleanup_bo;
+
+	perf->sample_workq = alloc_workqueue("panthor_perf_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
+	if (!perf->sample_workq) {
+		ret = -ENOMEM;
+		goto cleanup_vmap;
+	}
+
+	ret = drmm_add_action_or_reset(&ptdev->base, __drmm_workqueue_release,
+				       perf->sample_workq);
+	if (ret)
+		goto cleanup_vmap;
+
+	INIT_WORK(&perf->sample_work, panthor_perf_sample_worker);
+	perf->rb = bo;
+	perf->sample = sample;
+	perf->sample_slots = perf_ringbuf_slots;
+	perf->em = em;
+	perf->last_fw_sample_time = ktime_get_raw_ns();
+
+	INIT_LIST_HEAD(&perf->session_list);
+
 	drm_info(&ptdev->base, "Performance counter subsystem initialized");
 
 	perf->info = &ptdev->perf_info;
+	perf->ptdev = ptdev;
 	ptdev->perf = perf;
 
 	return ret;
+
+cleanup_vmap:
+	panthor_kernel_bo_vunmap(bo);
+
+cleanup_bo:
+	panthor_kernel_bo_destroy(bo);
+
+	return ret;
+}
+
+typedef bool (*session_state_cb)(struct panthor_perf_session *session);
+
+/**
+ * panthor_perf_request_sync - Request synchronous sample causing
+ * @perf: Perf struct
+ * @session: Target session
+ * @cb: Callback for the expected state of the session at the end of a sample.
+ *
+ * Perform a synchronous sample for scenarios where the sample must complete for the user to
+ * unambiguously know the state of the session. The two cases where this may be used are:
+ * - starting a new session (initial samples): any data from before this sample must not show up
+ *   in a new sampling session.
+ * - stopping an existing session: the eventfd may already have been signalled, meaning the
+ *   user may not find out when the session is stopped and continue waiting for more samples.
+ *
+ * Return: 0 on success, -ETIMEDOUT on wait failure
+ */
+static int panthor_perf_request_sync(struct panthor_perf *perf,
+				     struct panthor_perf_session *session, session_state_cb cb)
+{
+	int ret;
+
+	perf_fw_request_sample(perf);
+
+	ret = wait_event_timeout(session->state_wq, cb(session),
+				 msecs_to_jiffies(1000));
+
+	return ret ? 0 : -ETIMEDOUT;
 }
 
 /**
@@ -473,6 +1453,7 @@ int panthor_perf_session_create(struct drm_file *file,
 
 	kref_init(&session->ref);
 	INIT_LIST_HEAD(&session->sessions);
+	init_waitqueue_head(&session->state_wq);
 	mutex_init(&session->state_lock);
 	session->control = control.vaddr;
 	*session->control = (struct drm_panthor_perf_ringbuf_control) { 0 };
@@ -483,18 +1464,32 @@ int panthor_perf_session_create(struct drm_file *file,
 	session->control_buf = control;
 	session->accum_idx = U32_MAX;
 
+	ret = pm_runtime_resume_and_get(ptdev->base.dev);
+	if (ret)
+		goto cleanup_obj;
+
+	ret = panthor_perf_session_add(ptdev->perf, session, create_args->block_set);
+	if (ret)
+		goto cleanup_pm;
+
 	ret = xa_alloc_cyclic(&pfile->sessions->xa, &session_id, session,
-			      pfile->sessions->session_range,
-			      &pfile->sessions->next, GFP_KERNEL);
+			pfile->sessions->session_range,
+			&pfile->sessions->next, GFP_KERNEL);
 	if (ret < 0) {
 		drm_err(&ptdev->base, "File session limit exceeded.\n");
 		ret = -EBUSY;
-		goto cleanup_obj;
+		goto cleanup_tracked;
 	}
 
 	*sid = session_id;
 	return 0;
 
+cleanup_tracked:
+	panthor_perf_session_remove(pfile->ptdev->perf, session);
+
+cleanup_pm:
+	pm_runtime_put(ptdev->base.dev);
+
 cleanup_obj:
 	session_put(session);
 	return ret;
@@ -524,26 +1519,38 @@ static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
 	if (session_is_starting(session))
 		return -EBUSY;
 
+	if (session->pending_sample)
+		return -EBUSY;
+
+	if (!session_has_space(session, 1))
+		return -EBUSY;
+
 	if (session_is_stopping(session))
 		return 1;
 
 	session_set_state(session, PANTHOR_PERF_SESSION_STOPPING);
+	session->sample_start_ns = ktime_get_raw_ns();
 	session->user_data = user_data;
 
 	return 1;
 }
 
+static bool session_is_stopped_locked(struct panthor_perf_session *session)
+{
+	guard(mutex)(&session->state_lock);
+
+	return session_is_stopped(session);
+}
+
 static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *session,
 			u64 user_data)
 {
 	int ret;
-
 	ret = session_try_stop(session, user_data);
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
-	return 0;
+	return panthor_perf_request_sync(perf, session, session_is_stopped_locked);
 }
 
 static int session_try_start(struct panthor_perf_session *session, u64 user_data)
@@ -560,11 +1567,20 @@ static int session_try_start(struct panthor_perf_session *session, u64 user_data
 		return 0;
 
 	session_set_state(session, PANTHOR_PERF_SESSION_STARTING);
+	session->overflow = false;
+	session->sample_start_ns = ktime_get_raw_ns();
 	session->user_data = user_data;
 
 	return 1;
 }
 
+static bool session_is_active_locked(struct panthor_perf_session *session)
+{
+	guard(mutex)(&session->state_lock);
+
+	return session_is_active(session);
+}
+
 static int session_start(struct panthor_perf *perf, struct panthor_perf_session *session,
 			 u64 user_data)
 {
@@ -574,8 +1590,7 @@ static int session_start(struct panthor_perf *perf, struct panthor_perf_session
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
-	return 0;
+	return panthor_perf_request_sync(perf, session, session_is_active_locked);
 }
 
 static int session_try_sample(struct panthor_perf_session *session, u64 user_data)
@@ -591,7 +1606,20 @@ static int session_try_sample(struct panthor_perf_session *session, u64 user_dat
 	if (session_has_overflow(session))
 		return -EACCES;
 
+	if (session->pending_sample)
+		return -EBUSY;
+
+	/*
+	 * Must have at least two slots remaining in the ringbuffer to sample: one for
+	 * the current sample, and one for a stop sample, since a stop command should
+	 * always be acknowledged by taking a final sample and stopping the session.
+	 */
+	if (!session_has_space(session, 2))
+		return -ENOSPC;
+
 	session->user_data = user_data;
+	session->sample_start_ns = ktime_get_raw_ns();
+	session->pending_sample = true;
 
 	return 1;
 }
@@ -599,14 +1627,14 @@ static int session_try_sample(struct panthor_perf_session *session, u64 user_dat
 static int session_sample(struct panthor_perf *perf, struct panthor_perf_session *session,
 			  u64 user_data)
 {
-
 	int ret;
 
 	ret = session_try_sample(session, user_data);
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
+	perf_fw_request_sample(perf);
+
 	return 0;
 }
 
@@ -651,9 +1679,14 @@ int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
 			return ret;
 
 		xa_erase(&pfile->sessions->xa, handle);
+		ret = perf_disable(perf);
+
+		scoped_guard(mutex, &perf->session_lock)
+			perf_detach_session(perf, session);
 	}
 
 	session_put(session);
+	pm_runtime_put_sync(perf->ptdev->base.dev);
 
 	return ret;
 }
@@ -774,11 +1807,22 @@ int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user
  */
 void panthor_perf_unplug(struct panthor_device *ptdev)
 {
+	int ret;
 	struct panthor_perf *perf = ptdev->perf;
 
 	if (!perf)
 		return;
 
+	scoped_guard(mutex, &perf->op_lock)
+		ret = perf_disable(perf);
+	if (ret)
+		drm_err(&perf->ptdev->base, "Failed to disable performance counter sampling!");
+
+	disable_work_sync(&perf->sample_work);
+
+	panthor_kernel_bo_vunmap(perf->rb);
+	panthor_kernel_bo_destroy(perf->rb);
+
 	ptdev->perf = NULL;
 }
 
@@ -809,9 +1853,14 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile)
 	if (IS_ERR_OR_NULL(pool))
 		return;
 
+	if (!pfile->ptdev->perf)
+		return;
+
 	xa_for_each(&pool->xa, handle, session) {
 		xa_erase(&pool->xa, handle);
+		panthor_perf_session_remove(pfile->ptdev->perf, session);
 		session_put(session);
+		pm_runtime_put_sync(pfile->ptdev->base.dev);
 	}
 
 	xa_destroy(&pool->xa);
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index 641a88edd75a..0e1172dbae39 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -28,5 +28,7 @@ int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_
 int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int sid, u64 user_data);
 int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle, u64 user_data);
 
+void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status);
+
 #endif /* __PANTHOR_PERF_H__ */
 

-- 
2.43.0

