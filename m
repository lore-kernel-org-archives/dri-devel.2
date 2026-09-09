Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24126C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E6410E4EA;
	Wed,  9 Sep 2026 12:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NR0sJ+ZS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NR0sJ+ZS";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAF210F0E3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:37:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=A8pOoXyZcenrx1ZkhBAHeR+h8wNJiZ5o5JvCxYH7Nt9nTEZXtPhMrkpIsHCpHuv8/EgPGP4TA57evXeUJVFKyiBmjycstukFnwFsJO2BY7z/LCZP6EvNE7X0zyOqS66ScYMsPZ3da1rSXrraa2/McKfkYSwxKeouH7uoDPCBpKcxcLisT3Kg41XQPAv7d6JkS5YwosSpdjjoQu3z0961IpjVNq1LrgE2RixsL7vJPCGi/YR0T353UdadS1ryt7HfhTBtyg4d6IdA0hULKcfudz+QdzY7nKU/XKwNnrIDwv8qd1Tz9aOC989ZbaLcpXKNM/MHdYQZQyygpPl8xQfkgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRWhjjcBXfIs06YlcDjKUDLw422IQzw4xBnygKwTS/s=;
 b=BbGylazeVbP7EJNHGylSs0teth2UsW0de+X62IzcgHbOhJwvJ2JFfngQJQoh//pgiOZ+n8yVYwrDaUv/pUI8wqCH/UKOI2yTxULXx/x5Ooh6ANCOo2HRsycLK4byYNI/Un5yEKk0g+QHoFrC5aCzaEj9acIHn0Js8IK7B1iJdb5t0MHa9JrBj4LMBid/rQ9XBV/GRmynf3OjWXwmQdjkyi9q/0D79/IYwsjMlgUvC7BK438WmJN5Bsp+cZ8UmVYf5a1tUCeU6sdK4BCpwyNOIY4zOPO6tWiwzVe5ZeMyyXG3LhE4UFr8c04klvqgxxYzXp05R+oRUhOKiN4O+AiKYg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRWhjjcBXfIs06YlcDjKUDLw422IQzw4xBnygKwTS/s=;
 b=NR0sJ+ZSU8elsvqdwkewfdzrK3YcGSDn4t+z0Hr/8V/0GSz3kGXt+W9iArB7Nh2gXeNac5txjvsK1kKcGVNrVppZGmvQWN0UER3hptUGT6xH2sKOAL2L/lHWJSA6GqRNvR8F3ZycVdADQEY24eEsIs6BsY69N46cVrSBPSr4Ewk=
Received: from DU2PR04CA0229.eurprd04.prod.outlook.com (2603:10a6:10:2b1::24)
 by AM0PR08MB5489.eurprd08.prod.outlook.com (2603:10a6:208:18e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 12:37:13 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::8a) by DU2PR04CA0229.outlook.office365.com
 (2603:10a6:10:2b1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 12:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 12:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKm/RTAjlxg/6dq0bhQwbrJYSDu3T6Qu51XXJrX8MIWeqVEbRq/mu8F9oUShc31XlIkMdCf7AA/vxbjH3pC2eZMU9GL7PPo134EbV2s73zXR1EsAwJt0c99piX+uEZZjXU6smxZA3sOQNBR/SWaIleHB2cCd2JqwxEJ4tpet+/+TX9pULmGLlSjCPMvVDP/jBDWXBsilzmrKcv+9sWpj57pGMqr+Hn5E61QqNyxxNNFBgAhWUyZY0/mkR5ds5K01UBvwE2di/BJUg4LQOlrrtBly3HvVYVPDWjHlhVHKaZCYgM4gN2T9Su5+LixnmrQfUYsAlhZFcujCTEsatBb3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRWhjjcBXfIs06YlcDjKUDLw422IQzw4xBnygKwTS/s=;
 b=nCF6bfwqIXoBU1boRPLba0QRf6wKURSaYJpZ7JqoJVFiDz/gNlPZfjYlbTAPQSB8tV7iHh+5gNeUXe1tOgl71HosUmwIE6/9cdzQC92vLiFKYlv3ykn5eXompze1IaNtn6pQmUpII9R3SDDHUyVYf1JOm+rQ9amjEgQtBkyGOATxqX9g3Sum+Cr782iWPtTwE6f/iRPh2Fh/7VTxjwEjZ5SRU1EP7XYRjzqZeNVQl9ZrQw3NdGSyS6bTz50i8dRZRjSENgHhKx3/cPiUTH6Um+aGM7MLkgZyjqTcmsejJN5+qRrj3kaQsJuwWtfHla8s7aoOEKbUsWhgKFsm2VrJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRWhjjcBXfIs06YlcDjKUDLw422IQzw4xBnygKwTS/s=;
 b=NR0sJ+ZSU8elsvqdwkewfdzrK3YcGSDn4t+z0Hr/8V/0GSz3kGXt+W9iArB7Nh2gXeNac5txjvsK1kKcGVNrVppZGmvQWN0UER3hptUGT6xH2sKOAL2L/lHWJSA6GqRNvR8F3ZycVdADQEY24eEsIs6BsY69N46cVrSBPSr4Ewk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by DB4PR08MB9286.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 12:36:34 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:36:34 +0000
From: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH 0/2] Add scope-based cleanup capability to eventfd_ctx
Date: Wed, 09 Sep 2026 14:36:28 +0200
Message-Id: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxSoWoC/yWMQQrCMBBFr1JmbaBmEYNXEReT5MdGMJWZtAild
 zfV5Xv8/zZSSIHSddhIsBYtc+1wPg0UJ64PmJI6kx2tG711BjkZXtqcBTAX57qFT56Z+uUtyOX
 zy93uf9YlPBHb0TgWgRUmCNc4HerF2iC071+rPOE3iQAAAA==
X-Change-ID: 20260826-efd-autofree-766608e8d8aa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Bence Csokas <bence.csokas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|DB4PR08MB9286:EE_|DB5PEPF00014B9F:EE_|AM0PR08MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: a83d3825-2156-4f7a-ea71-08df0e6f129d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: qFqt1bHB1IS/MtyLGhVo0QSqukjlB5x8ibVySjHNkxu8sAeQB+oDBhNSmM+FUGOsAtxWaimsPzyQ/KfKn2p9uV9EAZS5Zs3yMpY89IQ+nkRsvx5/jpTITJPmO4kB0ZacyFjfn+ayjBNq2dd4ZeYVhdZWpCZG2MV0Om4obkzYzi7C9K5nI03WNk5dnCAs8PGUzvlAxcbfb2WSGsZu4ablPpZYTZJpTXkQYJ94YQey691mU5l4cm9nMSgI/VM0SXMhVj3vYarngcbTnI9nXHs2E8VcmrNsB41wif1u6cpqeHeDtGAApqK8htvZXkJyROzOobNWsrVaLGmiA0CNpktG7fsXSCGXBIuc6qfURhMDTw51USh/kZxKeAahuIplIduPRMyBmn5bYU92rXaepZsDyqkbMLH7OKkJaMrsGkdgOcsXQqO5Cbh/6UYC1e/qcTgw1CamvGpiaG802lEJbItRtdZJMGSSwGCYJRUnDq0och2+Cyr21BQPyZx0NxuRxk31DfQm4UkJGkg0+ieEqJ4pozzn15fgHt52tVuQljXO6ozh9qy1ClY4zDpvi2vm1P11Bej9NFyFvuniRSyOluA/68kKzTDGuWTjjZ1iLK+FCKqx7ss9wuMpXuQRw5IlZNCY9x5h8BVDjqEycVaT/7+LQKEA6j+jps3K/DRmyRbNKIo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 3msv4WcegbPwGYsOV59YJxop/yYmqTab1nuQu2IFy8j4dokwl14aCXbmIihGaF//jQffbSS5rHClVlPYZsxIRJoBFhBOoBVG3t06WwvWDQ6Z0J0Om8y/d4CwHzxUKXAwqpphbK+qCqSE0CQLIzOzDXTRa9ovi7sxvMAfiahWGtXWUkkwt2blmM7cJ0JEylM72EH6YjU1M5pMAvdRGNbIeZaBkGwAsH0zR+psQzAieckboaTZI7CBKgNdsaJ2Nh1KtmXOntmz63Icv4ayPJtbzLSNFHVpmapLZdVdvDe/K3CBqY9PRgzzI0qRXKvXyxmHKOvngHL78U1+nT4LqceG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9286
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b7bbdf60-281d-4552-f670-08df0e6efbab
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|7416014|1800799024|35042699022|14060799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cdeyfGykFNTWMtR1rZSdTvCNsnAUK/Lvxwacmc1dtfgXET0+TPzr01f/N8UNPp8hG4RpZ+s0AoZegqGH+ht6topdwBuQPgeXsL6ACJghIggmWT+WL/5+WEwxPxNHsqtq873+0wnq9e8Nhp5miLsm5o5N5uzcLrsZSXeGQfDOcwubFmcbbPiUGlznLNuHNB5Dme/m422JG0w/EtWTn/QR1/8A3yl7twhiTdUeKTvl5TC6/JTtmCrC0zhHVC3LVs93t4RT/dSjdNClUIEq1yvHNASXWL8xz5Y6mb6PZTfHpjdkOvPmVInRMYm5Clgpd3DUoX+pbPKb/FuAr2ZyImpOObVKO6+OcHCGyvY01j6+NiTIphBnhX7gxE3DpNWFsD87u0HglOud5jn6qxd8Hl5wkj2X8oes5OQHpbTSUxEYAnaeS5XA7DybCxGzzWb+fBMri8KSosfM49uO9owQ4C40lKarBRuPSpq3p2VT7wfEg4q8rzZ6ltBdfGiiD74w8/Ad1XUlahvIcoXzyMYRuSdpLLDvm0+7n/iMsjBpcD+rZ4GBTfCkWOMTki+ky4SlcTMxnN8ZYpdjp0A+DYR0ORMq9AN/hjuB4ujuXJRH/JWag79iqRmC3ca6kh6vl1PINeFhDjZRHcMZXUpnqJ712uQWCSAnj0jSQjKtOQhG6YUnC65Mrs/I3zKLMCDcrI4732QFN/teARJnKzmgpvimRMWEVQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(7416014)(1800799024)(35042699022)(14060799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xplXIrWNhG+ktOuwzKVcBN9rb7xfC1PWWVqROyxFYwSDm0eDoATcXKo2RIJ68W9csDjQh8/NAkH/EdS/hgNnZypeO8PsHvhjThRRHmMrwdGFdFR/ozCPQ7IRTCT2EsiUOLEHfP4DdMYXfrWn9yjqQ9FJ7T7nNfaKNhXzVQ8XW1W+8QqTIRnHnObFxkikb88+I88qY1SRqmDvnjM/c/CzpPF/jD9D6MH6xXEfJgK7HuUb4M1jSESQ2Eny7cENujsoHzzPNNs6vnDvpC1YgfMHVMNas6PprkvpApQZiK0m4PBxn3RM5H0fnGwK5ngDw1ki4kq/kOGjDgNaeXxwCK7hp426P2L3MN3RRVK45OLChQ4O9pkwOs4LvM0Cai9oNws3h1kdOInDaZDIYHVtcax75T9eZ+ps2iJWcs3PBeyQx8/N72CZJujfy7+UySZs+J/l
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:37:12.5345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83d3825-2156-4f7a-ea71-08df0e6f129d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5489
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

Add __free() support to eventfd and update drm_syncobj to use it as an
example consumer.

A minor discrepancy I encountered is whether to put a semicolon after
DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
I followed the example set in core-api/cleanup.rst, and omitted it.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Bence Csokas (2):
      eventfd: Add scope-based cleanup capability
      drm/syncobj: Use scope-based cleanup for eventfd_ctx

 drivers/gpu/drm/drm_syncobj.c | 9 ++++-----
 fs/eventfd.c                  | 3 +++
 include/linux/eventfd.h       | 3 +++
 3 files changed, 10 insertions(+), 5 deletions(-)
---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260826-efd-autofree-766608e8d8aa

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

