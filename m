Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5086CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE10F10E469;
	Mon, 15 Jun 2026 13:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="igzhS2uF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="igzhS2uF";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41D410E06B
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 13:54:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dyhp5lhJi5oRvXgY2mS9++jvxsSaguibiBOWfuUjRJz2n85TIE0ird/JMEcMn3/+s3Pt62JumMHzeZEUQJB3lAwRAeTcIt7A8KEIJ9rL2p1kTH94nt96O0XV4SzcwbooYX8D8O9VjtlISavdKlN2tlPTcIo1QLKpYxJUdyHjuEjt/qe8NiNj9ACjgiRvsbf4kokio2DI1fPWc0R0WzOIlgRBRqsXDJDfvjkMIX15qeMe1YqSQahM3IXcBERuT3iRIaKabUGgKVZ6TACsLHZ0D/ZwPhJMK8hw+exsjOMsiDAQC2v4ABYoRR0NKBK4XS6dBC6KYUQx4/n3imq4rVY7Cg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo6Q4HHlGvWeSV5TqH0kN84+1wSYdj1XJq3bOkF2cOQ=;
 b=hQAz7PAFryn/Jt3YrPyfeg+7un6yAr8YP1idOQolmd0jPP97rnRy8OSu+CUGOh43X4L9gsKvggmPMSw8mjpclwboBgLdNc1SDzExOGqi2kk+tWA7FhQAo5b960XsKliNZu4UuLlD2jQ1H5vid+MxGYX1TF+81NWVUDh9R4voZcRM3hC7kUewQzjepwHKx5KeAxs9MzcY0LKj7c6JUDsb6UiyqV/u8FCid6DZ0d0OFzTm2WrjtP0E9s3J1ALpZNCkjUNki58IJ6C3LL3VK/zgAomjJ/6VMt37iqnNByqGN192WjIuG74fG70BeKS/omUvps3J9vGMoRLg8jP2F/NOyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo6Q4HHlGvWeSV5TqH0kN84+1wSYdj1XJq3bOkF2cOQ=;
 b=igzhS2uF3gPTNhsfdAh1ZDRmbkqO1xdnFJJb8quzraNRvKLphYORRFK02vcRf6dCV4Bmsv80gFlQ1pQDV7QyhkboBsp1bH6u5+nYPuNYpk53yvm43Tx+kaSJUGONKKYCSwwWf4ROJgF9RxCXutqx9Uv83ByF4JuSdCiCoeq0Zy4=
Received: from AM8P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::27)
 by DU5PR08MB10609.eurprd08.prod.outlook.com (2603:10a6:10:518::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:54:07 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::98) by AM8P190CA0022.outlook.office365.com
 (2603:10a6:20b:219::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 13:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Mon, 15 Jun 2026 13:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCLOQcB+rNMYXSziQRgAQjudyxmLntg7Pj8uzh3VT3RMujgNx10khP6MAyu/DH8oUycTpqhTc/trGkHPHTGzEyCS156Esp04c109QMKrs56/pNO9GxgJwhw1DQAgXP7FVJEvx5+Yf/6tLaHtVWkreuPfAPq6vqFI2/BgulsJBeRAe24dYb5myKLu2/OwsvQCHSsdFoLs+0PM754XxAE7tOpBtz3ZINyh+5chaxTxGUz8QR3hqrVH8XocslvYdneO8eVJ2oU+PLCb7qxLdwaC+2mTNrk0W/R7xeLm5jphlKhkXWq/zGb9wQV5358zndVZxIqdMj8KGeZsDIWbR5imXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo6Q4HHlGvWeSV5TqH0kN84+1wSYdj1XJq3bOkF2cOQ=;
 b=nFTUQzsiFXC8eIIX5zeqXkpQH7oMCAVNn9SI6Kfkko/khN+lb6DdF0CW6gU2JPFYOkboF9dVOpUZFW9AzvMRiz7Sg9juCymYph0qndGYHrCwlqR3lPP+m/Ql5crY/nLi3GE80lnBlkfvVv9zV///ikfMYdkd0HnbLJR7YzgLZr4APWf+xIE4YxpdgbP5hRNS9+OGQxCCYeLrwmO/sb3i2+QFEg0x5M3WCVSuG5G80uB7rTzG4OeaUc7RxvsHhxVjESzpyc2fOKrBQPNweMM9YjpLt+wNirxspnWxkVwTjqVYiuZAJzFNfEw28x+6KwUMNVC5ibTTKHgGc0aZJ2vZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo6Q4HHlGvWeSV5TqH0kN84+1wSYdj1XJq3bOkF2cOQ=;
 b=igzhS2uF3gPTNhsfdAh1ZDRmbkqO1xdnFJJb8quzraNRvKLphYORRFK02vcRf6dCV4Bmsv80gFlQ1pQDV7QyhkboBsp1bH6u5+nYPuNYpk53yvm43Tx+kaSJUGONKKYCSwwWf4ROJgF9RxCXutqx9Uv83ByF4JuSdCiCoeq0Zy4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AS8PR08MB6007.eurprd08.prod.outlook.com
 (2603:10a6:20b:29e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:53:03 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:53:03 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Bence Csokas <bence.csokas@arm.com>, Daniel Kiss <Daniel.Kiss@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH resend] drm: uapi: Add macro for chipset specific event ID
 region
Date: Mon, 15 Jun 2026 15:52:36 +0200
Message-ID: <20260615135238.564424-1-bence.csokas@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0491.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::28) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|AS8PR08MB6007:EE_|AMS0EPF000001A3:EE_|DU5PR08MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 294a82b3-d89b-4be8-ddaa-08decae5909a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: fZu9yS8ex0K0uvOBJnKlvGNRRn2jo9XShczsZLuMkJvbWiwFjWcP/x5aGyhWKkMvWz67AyD8tl8XyhDHutk+GZ1LkE99VPVg24YwLQqqXqvftL19/ZrPjRFTb7CBnSBHVLAZPQi7ijHrg5X3pkAm3LPWikE3TMY1hQV9MEEDZkvpGtSEvei/wUh19YHfAgNq1a4N9EwQ2urZn4+XLufoeXMKINtHIA4xEJvxLkoff4/9Pn7qEYVey6BAyABaos4LYZ49Klt8VuK5NyqTLCNu8/mzfgbl2krCI6h1YKXKCADCca07FNb0lHEAEw1YO/mArMOCLQJ2NdYTH1yiLt+pnhd7uGR6/EcZfZZIXlYwagkW0sZPcaDScfZJB4bK4BzuNQl4BsmqHulYubYy+gekLmOyhMuQISzllkU7NlVBVMDv1/SbeugbtEs2zz3BVy+ySSqhg72Hv1Hlc4nkK+OJQpxonSGXZQg4/wewX2uWZKW7M7JCqWmq5MDUWPWuZd9vJnyotuONcS2ffmSDYl2F/yWpNEs+Uk+lG1n6nvdF3NGA0MpW+GfB8eAHiM4xE7x21xJ8q3kCH6jHtIRe7dTozSXXbiclqYAUTHYT4/PG2Zwpi/PoivQiUaczVN5X9FoMqoYAeUvS3bTEuSZ/xEkJo4uPuvLMMhrVCsqLP4Hc7k/qgXH5Phc0iWIP6KlglWF3
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: WTTqmaJDZhm/WfepIds7e8psG8yW78X6hMh8F4lBG2Rnf4qhRzy1IjEzZcyVKYxrfvkGKFjG6vpFzMISZ5OKU4vlFVbF+pxMU0ebjaQE+VWwmfSEqCq9I/tHxsEAyyUvb4fIMGX4bzVl6BvNAOOEphkGdIhe/LzcFNlVfAJO3Mo6VTTFR/e44t/Pt1qbgA9wrTM8sHx8+sLkxfoRnr0S7ZhXMS+BQMfhvWBAbZaAS8CbkRi1ko9kPDv8p9Nl4TuVy+Q6sfToY1c8c4xrzpv15dJfLWYn4GyULaeX8i/hb7V1qimErGgxAev/n0WhVUkz0KpkVZ12TSQEZ5zsTAcp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6007
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c57dad40-d2db-45a9-be79-08decae56b25
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|7416014|376014|82310400026|23010399003|35042699022|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3/dItL8eR5/VogiRo489vrExhnq+DCNM9PQhwwUkKOVEiLqo1a20y6QmmMKMD7bwY4WBFM2M1YgtA/cc8qDR+7aNHn50htC1kkMUHQyJttnVkpa/0QqZckuZ1Tud7yJwU3A9dqlSQAjwX7/jSoOw1RbvOZGYu1mGHoVLImKnC9LIGa1mJPWS8XdTCRrzAjVNA7fJ+T5DX8VWMpfDzz8z4g2IqiBTZ/69O7I3YnYSczvrqU7s7TC3m0sNTMV1nATB4s2lbtpXNb8+EIUEe2eSGoJ7qybQdWK9fbLdGrNUiUa8D+2ryZ8ZjNTkUJytcp7LOOWaVC+kCXtxv8dPMEJvymK9Wc87wdi5G4CQZu60RaZvIGAL3VnYtypdsGp1yLnOA5un7Zq4A5IUC6wbhERVF48lhjV12qkoYep11e6d3t+WC20tOf1939sepa0akBcWkrzj8/FxM9uEXytlgIsrsMHMuBEHAC98tA/mJgIwDjZoVlS8ec11mA5vPYtNujH1Edl4BjtPPThlpbHovw1Yp51xGxJnOirT/az769asrOsuG6Hzh9MSBho2N5MbnS9UcpkUubaVtJIkQOJA1hFvbx6ypRV5j3akR3bW9Qn+t8aoxGbXLkczriBz524KVN7A4XZdxyvVBQa1TqbeLcc/AV7noARhWKZgCAON5xskG0ABKOJBQERzP+lJfl2NAE0uvfzruVDyIeAXproIdWBZY8lWVKU+g4Fzlr2buSNjoEk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(7416014)(376014)(82310400026)(23010399003)(35042699022)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bYbsnOHDfsHF3tpa51QDddDnrS5ewiIqxvnZKi1sS1jAGzEjnrGVS//QmW0PoJ3V5h2Xeplj0jyjBjw41wf3pfV+lmLh+rtoXPx5yR5hqSkvzcDgGYV29XfHVrZQpQpqAPCa9CWlhzv2hmts5tztoItLDiHpXEncbdiwNfdIimVKB5soD12ZhC6m+bUGF6JyiWG8ZBXBh8i9vkktLPFMXHF7lGn34d21S1vk0MoW2+bbZgUIJiIIKT995yCZltvfQbOeMHp6bD2L2MF+fXF/+9jVQlzFyUdb0Yq83q9h8Vgf62MYeucem7s1vF3vYo5eFm5UNy35JSfFN3uI7TtYu9lrNLcgJu+3V49DAFQlnY4HmUmwyJBBoomnjKTCZ8H/cofidAwA1r7eRnlGR4QuyFZYk033bs5pcMsPLrtm6XfKUQDAEfLWnr7DiCGlkEjH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:54:05.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294a82b3-d89b-4be8-ddaa-08decae5909a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10609
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

Cc: Daniel Kiss <Daniel.Kiss@arm.com>
Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/uapi/drm/drm.h         | 8 ++++++++
 include/uapi/drm/exynos_drm.h  | 4 ++--
 include/uapi/drm/virtgpu_drm.h | 2 +-
 include/uapi/drm/vmwgfx_drm.h  | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d27..aa745e643ef4 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1419,6 +1419,14 @@ struct drm_event {
  * The event payload is a struct drm_event_crtc_sequence.
  */
 #define DRM_EVENT_CRTC_SEQUENCE	0x03
+/**
+ * DRM_EVENT_VENDOR_SPECIFIC - vendor/chipset specific event
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
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9debb320c34b..03e8a0c7f778 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -224,7 +224,7 @@ struct drm_virtgpu_context_init {
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

base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.54.0

