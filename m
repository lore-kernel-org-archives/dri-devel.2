Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65E103E166
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F3B10E76B;
	Wed, 18 Mar 2026 11:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Scwf/6qS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Scwf/6qS";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013059.outbound.protection.outlook.com
 [52.101.83.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C0A10E76B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:31:11 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RUkxdKW/6l++ePISRRvOfR8KJcy9ph/4H6GG0WMpgX0ubD52CiLefDMUGNygFMioba+f8IJESUbGbJ3BGNCZhMxszRr1F1LMtQ6vvlkvK8uMLn2AWjs8LCtOeqI87koksDVz44KXBTp//9oTTzJq47iAM9bog5SfaJk+3TtBPhgUtwZkR+UaRh5zv0AkyUf0mTZLfu7B52W02EHA+B6ivg3eIkvmgDodY1zjWttWkuzD8t4k0r6zI3S/VGTQKfuoYRzZYfsvM+BjwdeB42aq/01tvhTMkA1/Io98lLwMDMSFQt0xsOdFBgDmERjD6qMOQotK63Z0iaM8C4B/fg0LHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQrp1UoAP4+nAAwiVOYFBF2rDBnie27sy+0lBfd1ve8=;
 b=c3E7pXS8/+UfLVAvKFIbp5+W5JHfyQZXVdXdZbxiiTvx7k4cEeQLa6BxxZbvGNpeKjqQ9Y698V+9liQ9C9ITf+2w8AP/ky7kb38RzkLcddiZe5VvmwY4fC/BhcgnZd0cogWCClwPWeZpYdZSRy7A3D9IX6sqNZIHp0u/1bMYKNanSnBtkvxCeUYBC/06GBYngJ76ZucEqUock5BlBaqlJLDRUG9wvXoeYKDhbS5hidhi3t4LWSlJHrw11XQMIIkxAccO16w/AxGvavGM0HpUEPa8rTjagrDGIa+RtUw/JDrUih1AWTWTut2Y0zKs2Z/uXjhbMRiNUXJM+sLTDm46bg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQrp1UoAP4+nAAwiVOYFBF2rDBnie27sy+0lBfd1ve8=;
 b=Scwf/6qSbqiWeEufYFhbGMe8ZbKVbmKU6d/mh/2yZ/VoqwNwtP1BU8PV5LSf/S+rjxVgBaCfZGTMgAKekMnqJpOu68+pbVa9FNGT6gTdeN+uzbIxZ58pf9iaAnMhqq+3RLt0nd4blCXZ+DT0auerIVuG+TBqGAW7s2vARlzL6ww=
Received: from AM4PR0302CA0027.eurprd03.prod.outlook.com (2603:10a6:205:2::40)
 by GV1PR08MB10372.eurprd08.prod.outlook.com (2603:10a6:150:80::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:31:00 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::f6) by AM4PR0302CA0027.outlook.office365.com
 (2603:10a6:205:2::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 11:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Wed, 18 Mar 2026 11:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIXnLkpq5Tv/AwwqHApCw3qZweOEmfdVuQyygWY6YadhJBEZYVIF1S5HIsvOUxWeYUR+DgoJuLUUGZ+8t6GrudKgtXV2L1G6MuLl1B6LLPrIFX6tswas1QIWvPDh+AyGBayU1jcwvYIF3lXmnXRuqw8PjxoRWUqpHczFspE0tooOeShthlvN72H7zlWcpQqeHqo+T9eoT+5Bhw6x7nyHG7EwNaw8cbvPLkZ1wXPJ8EaYUjS1Ht40Rz+X9cEclbRLzQzwGMDWFuNirS9VOv+SWxOz+L9QU7+iMD5suyrgMMz/3lMjJZLWK2N4kUpgbAWYp2iN9gAndqMTtldoOGqVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQrp1UoAP4+nAAwiVOYFBF2rDBnie27sy+0lBfd1ve8=;
 b=rO98wsnAcE8MZ+dt/5nmIw4YnWYEVKOuBCO/c1+t5BEWbNaNoktT8Y+aTDeooB7ea6g0gI+1Stl94hww0XcsVdQB6M/dnmpD6/EKLItd4noebSqz4p8cowrebpHBUFiRp7qxhs2LDVHdCOUsSY3NJXELEG5p9dCGB38rxsdGplXPvMC7Zu8sVr2nhsMSXv4vmZ22Ir78MPrXSz8CSqo8ALIiT/LnHJ/Nan5Dbubj1AZkYoievmzjXVm32Oyqy5ITPX9r1eTsDo0/F1BYX1nij6YGrCr+d3IgvMREduakK+F2dYh6DXjLPZ+Cfm+cO17VD+pfyZsij3Xlz7ZxM7ZEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQrp1UoAP4+nAAwiVOYFBF2rDBnie27sy+0lBfd1ve8=;
 b=Scwf/6qSbqiWeEufYFhbGMe8ZbKVbmKU6d/mh/2yZ/VoqwNwtP1BU8PV5LSf/S+rjxVgBaCfZGTMgAKekMnqJpOu68+pbVa9FNGT6gTdeN+uzbIxZ58pf9iaAnMhqq+3RLt0nd4blCXZ+DT0auerIVuG+TBqGAW7s2vARlzL6ww=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by DB9PR08MB8265.eurprd08.prod.outlook.com (2603:10a6:10:3c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:29:54 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:29:54 +0000
From: Marcin Slusarz <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 nd@arm.com
Subject: [PATCH] drm/panthor: extend timestamp query with flags
Date: Wed, 18 Mar 2026 12:29:52 +0100
Message-ID: <20260318112952.645160-1-marcin.slusarz@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::16) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|DB9PR08MB8265:EE_|AMS1EPF0000003F:EE_|GV1PR08MB10372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4760c7-92d2-45b0-3ef8-08de84e1d4ab
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: tvD8wO7AKFfWZ6hTSji6LS+CHK5LbmT6TkJKRsPI9YXQfC8FBApj63XXvPQWZljWC2AVa6Yd2fvVNpDCHSLnXltjPWWHXV5RTFDcN7SmGpjpeq6JQx9a27q6s+XfHY7apDSTL8cmJQIl4GAZ70zEKqKVTpds7l+f8PJmBnjW+lr1iuwk8C0D71Yi8/Y2AVk1caH0qPVq0f2s1ABMYBpRYKs5kbEAABII6sTT1WJHjX0iETjyqzgL3W52N0YV/He61OWLbtoFyYwRm75xaKNyDmYLpoUpvvVjDoB50qT/faMGbN1DjBP5S3BO0V3iqL4+1ICkrtql5dF15H+/tPYdC5IPiz9OqhMZnYxNP/Pd39+dJpmhrATdd+oAo+n3SEFN17G7jNFQ5e0eAuv4GwzYfnj0CaRd7wbxRRbXHo7kDHwLJVJ9jKSgJu7uj1WIrYMv86NeZrJwEly84qk51I53jiCID+f32l6jgsjF9iLg/rNO/Gh+dskIZM7WppwsKXjMBxgRLFJpc2kbTR3X+VqJOQxQ1qrl6j8qzhFD6QcXrcMVPAJAf7Im/jee7UBFjWwMhnHMRWzYAPIjmlzK1uIbzQwc8ihzdSBDRKP83hoD37whhzmv3HpfoyPUET1vt+ANv+UqW+jaseM+gHonWjX9uzIJ4C1Pm9LslTZxC5BpARgVcoNG4rR955sMvm87VPmeVYV6AZ+LMb5OZ+EONqlEXiiTCV5ppZ/u/uEzXUuibJA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: SW0OrZAK5y0K4IHq2hWM/MQtcPNPUTCHHWb3lAB/aPu3F/JVdmJSWTFc46mkDbkpULBQj9DB2lB7VRNERKqAqvl671WWz0Wiz+jlvz5x4dUwWYAbWt/JouI5MV+puHXDYGCm2DPW9E6ZDXrm0r0epBQgJ3/mKHH7V9BZtcFn62kbeDd+M0PBpJWebxqNyDtukV11UEpfS7EXU+yw7eYr4EOmXQ9tz3ptfsEuBK3rci6BVQCBzVzjpI4rJ23V0CLnwVQGPzZeEtDhD3TscB2TJRJ3wu3h+cRuxBmwyN9KY5BHSAAXs1PiYUFhmGJ8L2S96+8XotTlNg6+aSTWQ5Rpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8265
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7619a424-53f2-498d-058b-08de84e1acf7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|35042699022|376014|82310400026|1800799024|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: Pd7hGbjKwfDdXj5fW87Ycb8HadPZPk/a+yOFVWYc13jgcT4Jhc0DTKZpaQEXxbSnCD+uvGMG7uiYOMtkD7H5UO9EVu47P9Ad+xFYDPwFI201dZdiwSnTv6GQzh6eFvx3L5Ao7SOurgpTmWwBW59awTNGLJs6phD0dPy7kKE54pO/r3l31YEYfflj43jMv4M2pae1m+OEIAwkc6MFkN277m2f0vIetYSgxp56LTvm/UD63ZSFNNqmU4Z2YWkZ89ELI+h5hvaYzcFj+KTGk97jLHmQ24n9uuU8TzhM8T9BowWvhiy7zBkEQWiiVi27AAfMK40+AWKLPxbogSRvnvlFyE3QKjHdVENAMcHj6ou7Dj1XWv5Ca6oJCEq4H07us1gwiybG9rQERNNKeQqENUhVgFdxGMPeQhXVSDB7z38gmzX5HzK95lKWMavFn+x2OAwyT/9s7fHA+Vn2lzd2+HddHX0EuymHAT62Wcjmim2/uZcsfQEddih59xELqY4iUBPbc0lKcmZJHp+Mk83+UXEf0k4TjMlA6raGJu5Kv9+XlM/Ju3OLdjXyvRNm6S7/EfTzggFfHQ2cgxeEVvYgD/09TzvOFlDuHJrio8ngvpJGlrhABRDFr4TdaorWMt16o0iPmgwNSn5CpW/JPXE2OGHpKcZFuLdHALhGuh4/KPhR1TiYlTOJYJu830NqynYJcIitvbv94ftZGSGMu3ppeY/kQyMTj3GYQMT0S9phiQm8uFggyYzkfGqgFrdtMLu6YmUL+cIw8AJ7ZPYvdCXBv4zDcw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(35042699022)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dwwYxW2weJX79UTP9yEY8lCTHCNEGNPPJp7GhXCNRLNeWFNWiU64kSABTHfK1DaLGiAL4kMRTICwMWBq9BF2DRxZKuDxy+t4D0jWbm9xKx9SyNcwpPxcCrlamBMYmZB7o97H+yGHtud6YUcYxV9HH+3nsLQB1p5QACZmJ2Vwt0DqJXG0snUYBPEUwwR1DNJpwZ1MYn2t1Svx0M8EkoUcn9RHvws84lp0yE54X3Vcn2IDvWJeT2ATtkg/XlBvFXhskqKbtFh9ncCiagIjw9BmtUmdZmmFrbWbIU7XkqTwgV74SZ8iI2vnhrRKy23S91TWbtJm5Z1UOhIVOGVJ/77iPOpvKw0mpStXnzU5u2aVEsVdYt8+qMpoCrUFRsnSvBg2+bidgMRhiMX+SNTqgjUQrHOssXRcf7s0Ml6Eba/Tz47KY6FcjCRiEeBBRr0UsKAW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:31:00.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4760c7-92d2-45b0-3ef8-08de84e1d4ab
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10372
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

Flags now control which data user space wants to query,
there is more information sources, and there's ability
to query duration of multiple timestamp reads.

New sources:
- CPU's monotonic,
- CPU's monotonic raw,
- GPU's cycle count

These changes should make the implementation of
VK_KHR_calibrated_timestamps more accurate and much simpler.

Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
---
This is counter proposal to https://lore.kernel.org/all/20250916200751.3999354-1-olvaffe@gmail.com/
---
 drivers/gpu/drm/panthor/panthor_drv.c | 124 ++++++++++++++++++++++++--
 include/uapi/drm/panthor_drm.h        |  51 ++++++++++-
 2 files changed, 166 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 165dddfde6ca..19ede20a578e 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -13,7 +13,9 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 #include <linux/time64.h>
+#include <linux/time_namespace.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
@@ -762,21 +764,123 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
 }
 
 static int panthor_query_timestamp_info(struct panthor_device *ptdev,
-					struct drm_panthor_timestamp_info *arg)
+					struct drm_panthor_timestamp_info *arg,
+					u32 size)
 {
 	int ret;
+	u32 flags;
+	unsigned long irq_flags;
+	struct timespec64 cpu_ts;
+	u64 query_start_time;
+	bool minimize_interruption;
+	u32 timestamp_types = 0;
+
+	if (size >= offsetof(struct drm_panthor_timestamp_info, pad1) + sizeof(arg->pad1) &&
+			arg->pad1 != 0)
+		return -EINVAL;
+
+	if (size >= offsetof(struct drm_panthor_timestamp_info, flags) + sizeof(arg->flags))
+		flags = arg->flags;
+	else
+		flags = DRM_PANTHOR_TIMESTAMP_GPU |
+			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+			DRM_PANTHOR_TIMESTAMP_FREQ;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case 0:
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		timestamp_types++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags & ~(DRM_PANTHOR_TIMESTAMP_GPU |
+		      DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK |
+		      DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+		      DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT |
+		      DRM_PANTHOR_TIMESTAMP_FREQ |
+		      DRM_PANTHOR_TIMESTAMP_DURATION))
+		return -EINVAL;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		timestamp_types++;
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		timestamp_types++;
+
+	minimize_interruption =
+		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
+		(timestamp_types >= 2);
 
 	ret = panthor_device_resume_and_get(ptdev);
 	if (ret)
 		return ret;
 
+	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
 #ifdef CONFIG_ARM_ARCH_TIMER
-	arg->timestamp_frequency = arch_timer_get_cntfrq();
+		arg->timestamp_frequency = arch_timer_get_cntfrq();
 #else
-	arg->timestamp_frequency = 0;
+		arg->timestamp_frequency = 0;
 #endif
-	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
-	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	} else {
+		arg->timestamp_frequency = 0;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
+		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	else
+		arg->timestamp_offset = 0;
+
+	if (minimize_interruption) {
+		preempt_disable();
+		local_irq_save(irq_flags);
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		query_start_time = local_clock();
+	else
+		query_start_time = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+	else
+		arg->current_timestamp = 0;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+		ktime_get_ts64(&cpu_ts);
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		ktime_get_raw_ts64(&cpu_ts);
+		break;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
+	else
+		arg->cycle_count = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		arg->duration_nsec = local_clock() - query_start_time;
+	else
+		arg->duration_nsec = 0;
+
+	if (minimize_interruption) {
+		local_irq_restore(irq_flags);
+		preempt_enable();
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+		timens_add_monotonic(&cpu_ts);
+
+		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
+		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
+	} else {
+		arg->cpu_timestamp_sec = 0;
+		arg->cpu_timestamp_nsec = 0;
+	}
 
 	pm_runtime_put(ptdev->base.dev);
 	return 0;
@@ -851,7 +955,12 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
 	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
-		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
+		if (copy_from_user(&timestamp_info,
+				   (const void __user __force *) args->pointer,
+				   args->size))
+			return -EFAULT;
+
+		ret = panthor_query_timestamp_info(ptdev, &timestamp_info, args->size);
 
 		if (ret)
 			return ret;
@@ -1680,6 +1789,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
+ * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1693,7 +1803,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 7,
+	.minor = 8,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b401ac585d6a..c869e8b95ecd 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -409,6 +409,35 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/**
+ * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
+ */
+enum drm_panthor_timestamp_info_flags {
+	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
+	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
+	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
+	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
+	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
+
+	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
+	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
+
+	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
+	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
+};
+
 /**
  * struct drm_panthor_timestamp_info - Timestamp information
  *
@@ -421,11 +450,29 @@ struct drm_panthor_timestamp_info {
 	 */
 	__u64 timestamp_frequency;
 
-	/** @current_timestamp: The current timestamp. */
+	/** @current_timestamp: The current GPU timestamp. */
 	__u64 current_timestamp;
 
-	/** @timestamp_offset: The offset of the timestamp timer. */
+	/** @timestamp_offset: The offset of the GPU timestamp timer. */
 	__u64 timestamp_offset;
+
+	/** @flags: Bitmask of drm_panthor_timestamp_info_flags. */
+	__u32 flags;
+
+	/** @duration_nsec: Duration of time query. */
+	__u32 duration_nsec;
+
+	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
+	__u64 cycle_count;
+
+	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
+	__u64 cpu_timestamp_sec;
+
+	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
+	__u32 cpu_timestamp_nsec;
+
+	/** @pad1: Padding, MBZ. */
+	__u32 pad1;
 };
 
 /**
-- 
2.34.1

