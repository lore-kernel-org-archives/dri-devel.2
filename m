Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A7DCA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D75610E2FE;
	Fri,  2 Oct 2026 18:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LaLhjL/q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LaLhjL/q";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FD110E2FE;
 Fri,  2 Oct 2026 18:09:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rmkcfkdS7dco+J1uNQsPxLnnFaGi8QaVUeKfMaup/qLaP9cUBHvkqFyt9HxOg5++mnWZ2dXTNJdqTKEtSCqGF2n5b8q+LCiDVkw5ruiNsW9fpvlLAL/+IjYI0hXe0idXNylkpjNmRJQ1U6IdbBX3pdThrbxJaCo3YSIOhBtnac5V0JItfJJNKmEkmITaXeQ+w2F6We/j37j8JJ7uMSHXS6MK1zwNOvuJz4ntPOJqu68pm6KnEdFPLpGd6AV9dvsirZCt5K3a0qc6yte3DxDWAnQngoGnm40pb9fO8agZdoUtcanemIQYo+/fAh/iaDKcixsxcWTuAVeyv23jAKi7BA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2ewfN0qoFIyXGDU+QeiksL6dREzVdV4nqTBNLUZFPk=;
 b=jNi9urgIRvdF6Rrev6n3BlF6+l1RH8FomoxohAN9TcB50fma1nFmGpO12DFaQlnx7LqUTbAhE+wQ51wn6+R6opMtuCbuBaFCb5YcmXP1eYQg+Jy7VIKR0PxVJBIwinUhp6FueLzRYUNeuMMYqpYR2pcWMob0UNMaEm4Az1uRdqk21kUgJDUiK0oJNW01HZd7gKuYGISkY0pkccVWwE8JqOdeFVwFlI4uNAM8r3Dv4HZpfpAjA/NBfSe0TtdT4IazNcrwbPH5p7bDcrsD6PvIGz576DXnn2cGZ5+yZz/7gUdspSY1h9zerddEjh6w3+GMmCCBGc6FA7w07iMTe7YQ6A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ewfN0qoFIyXGDU+QeiksL6dREzVdV4nqTBNLUZFPk=;
 b=LaLhjL/qp6aclyDRhpXltljg09wBtJn4AwORyr2d6QsTTKDiRn3NzaFhpamT8+0GtjsKpm6mr9x9n4p/9bXzBGxPLS5BNYz3dhqI6c1nlkhj0Ktt8AJmkdbmCIGDXxwUDZFqYJoOmQQI15fyQE8CdlYpTPAiKpdmoaKpoQav6ts=
Received: from ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:46::11)
 by AMDPR08MB11673.eurprd08.prod.outlook.com (2603:10a6:20b:73c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 2 Oct
 2026 18:08:54 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:910:46:cafe::69) by ZR2P278CA0017.outlook.office365.com
 (2603:10a6:910:46::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 18:08:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Fri, 2 Oct 2026 18:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or1E6MWybRtIT21jswSx1K93NhBwEnxDRsWqMe22SmQNGPQxay8A4+NFtD8wSJLWlu6IITQPxgx7nOAr5p5ftq8qU22l5hrW90iKR/azoEzHR5zKlt7kSncArhEvWzLaUmJfzrz2z2/Y00XSH+qFaVjwJfavMae2D2btQS2gY0w1zaEK/WedVNJE5EbJAOW7hM5vCf8IVruwK8VxjrNhMqOGaisu2pG4ezDlwPc0mWnD5ot7I//P4hkiLmpw5GNgMuB8xIqQ8pbMDS+fWsfRHWH+UgOxSZt73lOgGRRVEnHgjj396pa1F4txqlHUceCQIqC3XqZRQjP6/GviDGJuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2ewfN0qoFIyXGDU+QeiksL6dREzVdV4nqTBNLUZFPk=;
 b=hiiEa50Lr/WJEBbEBggTzW/0ZbmeYVX3kT4nAwg80Aa32bAvi47pniwM8tptqGsuyakp5SjwZMZ3cYfrZtQ6NstU4bMEZdomI2nHqcIJxE5GWv6ZvYVCIwI8F5eOSRZDf3wTKwPBWL4fKTVCo1grtxE7earS4Lt6b5y66N16EO6j9/CIR9UJv4joQeb5VAxoTuuI1c3Xqw8SbFq6vTEUC/zmPAiJNcQ2GwwrHFlTWpxr3oLldNd3VYouF+v/8PW9zKxwcbt5LNaCHMIimUFf/l1C/MtsYl/FURxhjeKxhmoJ1Y0SX8fBb5wk+ytGW7iafYlpEddursoNj/Z2Aat3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ewfN0qoFIyXGDU+QeiksL6dREzVdV4nqTBNLUZFPk=;
 b=LaLhjL/qp6aclyDRhpXltljg09wBtJn4AwORyr2d6QsTTKDiRn3NzaFhpamT8+0GtjsKpm6mr9x9n4p/9bXzBGxPLS5BNYz3dhqI6c1nlkhj0Ktt8AJmkdbmCIGDXxwUDZFqYJoOmQQI15fyQE8CdlYpTPAiKpdmoaKpoQav6ts=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by MMZPR08MB068467.eurprd08.prod.outlook.com
 (2603:10a6:190:46::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 18:08:18 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 18:08:18 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Fri, 02 Oct 2026 20:08:08 +0200
Subject: [PATCH v6] drm: uapi: Add macro for chipset specific event ID region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-drm-uapi-vnd-v6-1-3ac4087acf64@arm.com>
X-B4-Tracking: v=1; b=H4sIAAfzv2oC/52PywrCMBBFf0WydkoebRpc+R/iYppObZCmJalBk
 f67iS7Erbs5cM+9zJNFCo4iO+yeLFBy0c0+g97vmB3RXwhcn5lJLjWvuYE+THDDxUHyPfRqINN
 SKweFLCtLoMHd33Wnc+YOI0EX0NuxlEwYVwolOLq4zuHxnk2ixD8LWmihasNlpVW+NUjoyFuqb
 JyvGI8YpsrOEyvlqf7Ta76e4er3o9SAAIGtaFCbWlrxVbdtewE2IajcLwEAAA==
X-Change-ID: 20260408-drm-uapi-vnd-d3fe87e72f3a
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Peter Griffin <peter.griffin@linaro.org>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
 Daniel Kiss <Daniel.Kiss@arm.com>, Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR1P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::17) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|MMZPR08MB068467:EE_|ZR1PEPF0000E461:EE_|AMDPR08MB11673:EE_
X-MS-Office365-Filtering-Correlation-Id: e653ab6f-b099-409c-2d37-08df20b03804
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info-Original: byLkwnhCrNi5g0YtWM8CMjDSVik4lOar59zfCZcgf2IDpVcwMC9M/3eHEa6hvJtsq+RLdY9kIKICsbOGd6J1S8uSLL0xr/rq8PgGAWRLoekhXIGF8AkeBoLY1tDXBv8CMt1jt9KCBoChE9iv2epsu+opCtKJOvIPtelnvY55r5S9ELUalbxxvFEUkj0+gKSXMgVzZRZj6PyRtS0U1Ey3Ph+KwF+KuoAWq4w0um5QWRmhfj8cNxys18QGvPu3/HowNoSvJOLZ+hK6ma8/N9zj8MGy4UumeKsHiu8bWdaraLeb9uSDF1KkuXwBnTTgWsDND8cKyWUCUdWaJLRlApgLmjAUdICLCZtrElv45olkMvztk46j3TKf6zflNNUFbirkiE8Ucms4xFgeXjR1Obs4jBwSFu+5o8tiDM5R43KWReZiCMMPNSOvv93+dmXF/cUYNRdQR9XZC3IR69lGpPGVFxkejvaS0jToZhhrSQ8Op23ZBEFqsTDdFa4802vSjCdlis0lJAxBmSEFC03gqTtu1U/GSvgjf+RLM4wT2PnWW3QFdJxZoYgg3j/q2KV7xs3VP0KPtOTGnlnDf7eXtrQM+T1zUY1P1Gn3eAAJeTSgDYJ6LeIBS6Uiq0c7n0vmtKjdw8JcnR+bYfn8FmD3UEnuYrCX9MLLcJT3Wl+wdabwsys=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 3Z5XRj7NnhmwvnzsJ0cto3PR4lg27zPOiJJAXBCOnJzFAhYUYgRP6je+nZBFaXFmH1IbM4wcDzK0vquoPHjCM8eHgVfXABxip8fERiI4mcbPB51o++ni4Gf+lDVvCtIS2PKX6I9Z8PmNojnFLxaqjFT+FuiTITFtMhylWGUey//G3U0soRwTgNATjxWkAFm4xrcf/rMHLW39YDv0681hkCqJ/1s7D+yKWhfO3xPgbNHQek0fBI5S1mm6UT/7gvECzKWP74SmmCXSTlRQDUajomciQVWVHv5vl1sO2jyymd46AfrxoEgjlR39TGhiQgyR6GttYbSNOvJOktvnHCSD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB068467
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2b6c2b01-038b-40f1-279f-08df20b022e1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|82310400026|23010399003|7416014|35042699022|36860700016|10067099003|56012099006|11063799006|921020|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: NoQuTHrg4Y4TLzF/NT09/H5nI5oRTZtgJKgX6yiA9bFyWx0H0zLNgzFq5Th0vaRHnGR8XMi1cQ6JPTGyRLQWdUAR/g9wDHOE9gYnBKCBLXYo4ua7Pr5K/0t11vKxJq4PfhdU8Vskgvj/OGN367RUAGcx591mFuXo0lD57D71zYDQh2FsEEOdmqZ2HW+pZh0fbRgUt6i6FiUrMIZG+kwZj2qZArkxzTczkIWtS+LoI+U+zCEiQLBWEH5Qd9sWB30+4+s8pQII/GnlU1OfNndfDly4ucXCjpOToP1sTcRylTyAt68FWuKio7BxPEOlzjm254AaZtPlgPgoNWRfUw91vIJH/rRSc+MfscsidzC2QoBBcBNltkVAwg3SOQdlwCRXfcmhRGQ6t/MIFjj0dUYnS8mlgeXJK11VkhlxBGxswladKRMK1S536C+N2vqHtJfGQ9BllvhcKkOx4zMOscfMAxMFE6xa0svh/AVb48z43UcVSpXWlbP3lqEAHKbJ8VjPAsWZCI3at/4+PFLghUIjQ/ERK1MvE9TCQ4UzMqkjJ57IV0U+/CTcFxeWJ/cyFWRJ0YKBFg/MAuzLEnKkiZe7cts/iG7qpcSfM+etCmq8f1D2nGYCdjMnPrnSU/7e1Q10SdBw1cPypALoCYncnxjwAtgEONkpyxY+JaySoW/o26C1ppbFnW639rnASLv3IJoS6VRLPJGY6WKjqHJyx2fjyw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(82310400026)(23010399003)(7416014)(35042699022)(36860700016)(10067099003)(56012099006)(11063799006)(921020)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZBqfhNZldmyjBzXvIUv7bEM64vUaTOx7kxf3KRac/1rUv7DX5mMmIIgy0PBO98GERBWe7tE9iyF2MxzTIi0lD7b4Lr0obGS4T1LNhWg9TgcEWl8U6uO6lrypNEh4E7ZnryQR31mNl9SacPlCpemVDMl67CP7VLI+XWeNdIskDKDdd4ILjDWNlGRDQh+U7bgxRXXSxXtxMQcugxcGUQ2pShSRKZYwBqcAGjvcb8p/SKxaNASZVFiQrWRERZ1yOn5Np7mBL/HHomQtyXDTm9D2q8+DN48XEliZpxYibXa6UPn6siZvv2jYZhbtLO0PE79dDE7S0uzhkzYg7jRARPae8NxdljaJ4fKUtHl19wBziqE6cxFkHINRyvkey4SK80uvSQauJWkCiXNlaGS7xiX22XFDyMH7LG8ExFqUS0WkLtToHvxPL86+Tzp5qk02HWWl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 18:08:53.4348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e653ab6f-b099-409c-2d37-08df20b03804
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11673
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

uapi/drm/drm.h states:

    Event types 0 - 0x7fffffff are generic DRM events, 0x80000000 and
    up are chipset specific.

However, this distinction was not put in the code. To elevate the contract
between the generic DRM framework and the driver from the comment to code,
put this in a macro for clarity and convenience.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Link: https://lore.kernel.org/lkml/d37a738d-f316-42cf-8dbc-99a732a33240@broadcom.com/
Cc: Daniel Kiss <Daniel.Kiss@arm.com>
Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v6:
- Rebase to master
- Link to v5: https://patch.msgid.link/20260803-drm-uapi-vnd-v5-1-1a715a6842c1@arm.com

Changes in v5:
- Rebase to master
- Collect Maaz's tag
- Link to v4: https://patch.msgid.link/20260616134802.636166-2-bence.csokas@arm.com

Changes in v4:
- Document `_v` parameter
- Also convert DRM_NOUVEAU_EVENT_NVIF

Changes in v2, v3:
- Rebase to master
- Link to v1: https://lore.kernel.org/lkml/20260408163608.361826-2-bence.csokas@arm.com/T/#u
---
 include/uapi/drm/drm.h         | 9 +++++++++
 include/uapi/drm/exynos_drm.h  | 4 ++--
 include/uapi/drm/nouveau_drm.h | 2 +-
 include/uapi/drm/virtgpu_drm.h | 2 +-
 include/uapi/drm/vmwgfx_drm.h  | 2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..c703e106d750 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1408,6 +1408,15 @@ struct drm_event {
  * The event payload is a struct drm_event_crtc_sequence.
  */
 #define DRM_EVENT_CRTC_SEQUENCE	0x03
+/**
+ * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
+ * @_v: vendor-specific ID
+ *
+ * These event IDs are reserved for chipset and driver specific events.
+ *
+ * Refer to the chipset driver's header for details and payload struct.
+ */
+#define DRM_EVENT_VENDOR_SPECIFIC(_v) ((_v) | 0x80000000)
 
 struct drm_event_vblank {
 	struct drm_event base;
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index a51aa1c618c1..8d3156fb129c 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -395,8 +395,8 @@ struct drm_exynos_ioctl_ipp_commit {
 		DRM_EXYNOS_IPP_COMMIT, struct drm_exynos_ioctl_ipp_commit)
 
 /* Exynos specific events */
-#define DRM_EXYNOS_G2D_EVENT		0x80000000
-#define DRM_EXYNOS_IPP_EVENT		0x80000002
+#define DRM_EXYNOS_G2D_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x0)
+#define DRM_EXYNOS_IPP_EVENT		DRM_EVENT_VENDOR_SPECIFIC(0x2)
 
 struct drm_exynos_g2d_event {
 	struct drm_event	base;
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index c4905b3e4e91..abf044a257c4 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -25,7 +25,7 @@
 #ifndef __NOUVEAU_DRM_H__
 #define __NOUVEAU_DRM_H__
 
-#define DRM_NOUVEAU_EVENT_NVIF                                       0x80000000
+#define DRM_NOUVEAU_EVENT_NVIF DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 #include "drm.h"
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12aed5..4a2f8b1e9225 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -229,7 +229,7 @@ struct drm_virtgpu_context_init {
  * effect.  The event size is sizeof(drm_event), since there is no additional
  * payload.
  */
-#define VIRTGPU_EVENT_FENCE_SIGNALED 0x90000000
+#define VIRTGPU_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x10000000)
 
 #define DRM_IOCTL_VIRTGPU_MAP \
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index 7d786a0cc835..5e5878384e60 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -715,7 +715,7 @@ struct drm_vmw_fence_arg {
 /*
  * The event type
  */
-#define DRM_VMW_EVENT_FENCE_SIGNALED 0x80000000
+#define DRM_VMW_EVENT_FENCE_SIGNALED DRM_EVENT_VENDOR_SPECIFIC(0x0)
 
 struct drm_vmw_event_fence {
 	struct drm_event base;

---
base-commit: 5e0f8396d4805a3e7f753fa58c8c55f1f3cc2160
change-id: 20260408-drm-uapi-vnd-d3fe87e72f3a

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

