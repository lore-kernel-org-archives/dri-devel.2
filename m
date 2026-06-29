Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FFFC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E92210E84D;
	Mon, 29 Jun 2026 12:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oEC87rEb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oEC87rEb";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013047.outbound.protection.outlook.com
 [52.101.83.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582BC10E84D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:11:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LQis4qAnWsSvA3KiHPJpsT3ths17jt0Ao7L9mjF25/VRDbVoyso8Or32mHRQEE8ltBR4CqxuMmbTWaTtFs2bcqxW250uSg6vdfYGQGbVgQ0AnH42zVyOyMcKgv2WLFLhBIck2vBxitMNKOKrlkfJO0OuwZMozJXZOw8S6qoIJwXSio4WhS3F3/Q2G2/NZj1mt57jrulgNZbbXt0apZfQtUyVTHU6SMe9Ck1FKy2cvBxpcOCa/thPgXIGm1fU2ANwzhYh2qN4/lPCR0yJzTyPYydmkHnbCpFu1RrdseX3kh9oAzKiHh3gcfXrbyaLUGu+hn53KYJ3uUjye6Z8tWfNWA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2WYSNk2l92qCX95W+ayFM7mWzxfeQQVs9uuifvfFmY=;
 b=uvQaxxK4h2VSVyVJ0rbMrFry0Tz04hUABRt4PoAnzY+7IeP0go9OvS5A5lsuiKmTyfzIZBJ4o8AvmEWqz+KD0tjRoUoL+bb8KKD/HAgzKDsWKGi9IU1jBy+fbiOOq3IKevqtYDMke2JRtSkBF8/c+GJyVMT/i/xvO8JFxJYNSB5qnY3sZEC9oij0oEOEwWl3+5jYa/Wdrrgk5zd4LiRLM1+GHEXxEiaqtv/p3TqyuF8R2zffVubYxSvhDs8vjdqnXDuMfpDLzgQU3/57HBiFTqIIfDvLr5qPszgpnkTgVNuGSyrPZaKbKY2a8RAQn78jTInao0s9lcG8uFuKp5c8Ww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2WYSNk2l92qCX95W+ayFM7mWzxfeQQVs9uuifvfFmY=;
 b=oEC87rEb4KYKLuCNj/zwInSMBJV1bKXZHYVaqvJLjH887RLFqAjDavFN2TmV0a4pm6dhnLhwC5i2+AFOgZtRBLbDaJWHb10k4OI5ukUuB6FWQd2VJZ/Y+8zJIG00rkkkoprRWaZCKnGEPyltAeite+VFfyerNXqZPEIywDyacWo=
Received: from AM0P309CA0016.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::14)
 by DB4PR08MB9311.eurprd08.prod.outlook.com (2603:10a6:10:3f5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:11:42 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::97) by AM0P309CA0016.outlook.office365.com
 (2603:10a6:20b:28f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.0 via Frontend Transport; Mon, 29
 Jun 2026 12:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 12:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkrnNB9Bfl4wgInSXynAtq0d2o1vvIwBlJVkV0awORQrWRQG/yY6An9m1CdE/+HCIWGE7hJDBzcUSg416oaSZMJQKgif+SEvndaxlu8QY16uTRvVZ8LhsIXyJYh08i+ShUXw0bAyZOt5yiiZaMta8LmIj9zukZgcoWM8Ebk4IRQZOO8BEic4Yj4sypg2ozg4Obzd7F+I0+3zsvwJYG3Uh+EbY8nNdd+mpcX7I8NQLDeR8aDMnDSfhCsV/nf4dd7SjBbd79YAPkAB5x4+MAJUdjoUAAgrowrG+TszfU1Jc0FjgYoh0fAF38mnwp5xQj6+dburwVxYoiXzCwOCu/6qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2WYSNk2l92qCX95W+ayFM7mWzxfeQQVs9uuifvfFmY=;
 b=K2H1xqRECKJVO8FhyU6Be+nhxIpFPgsArI11vKuCuVQBZTUWgD//D3UFxhWN+8WrREHaEIIkNH1Io+3wEb7+d6mnaBByGF/JdT5PMLwUOZ/1mj3oz1yRQ6Ivefi4i1isYR8X2sc8wgVBl7RjWgrsuoG5Om9pyiqlqQpU0oTubUovdDaTbgmuHUHSjAwKyhvTrjFV7tBIpCxtixIYM6zOz3a+NCWWpltOuku3zAjOoLDgN8+Aiu0DVPSkdfiSpyFR2Gj9+uDbFp99J3ygGzz/515kPsbURH/e5SUXGvS7LiZgzLL78utTdjSLL38Ru4COoklrp1/9FhQk7k2m+t828Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2WYSNk2l92qCX95W+ayFM7mWzxfeQQVs9uuifvfFmY=;
 b=oEC87rEb4KYKLuCNj/zwInSMBJV1bKXZHYVaqvJLjH887RLFqAjDavFN2TmV0a4pm6dhnLhwC5i2+AFOgZtRBLbDaJWHb10k4OI5ukUuB6FWQd2VJZ/Y+8zJIG00rkkkoprRWaZCKnGEPyltAeite+VFfyerNXqZPEIywDyacWo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB10272.eurprd08.prod.outlook.com
 (2603:10a6:20b:62b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:10:39 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:10:39 +0000
Message-ID: <3568d803-3e96-42a5-8bcb-67cec9cb0fb2@arm.com>
Date: Mon, 29 Jun 2026 13:10:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/panthor: Don't overrule pending immediate ticks
 in sched_resume_tick()
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::9) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB10272:EE_|AM4PEPF00027A5E:EE_|DB4PR08MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: b25407fc-54b7-4144-6fc4-08ded5d79491
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 5ZAUXnvrupIYCKwZGk5pCWzn8pYfBg91nHzwHKWfd0wgmawv2v8o5Mts7apuGeuCiIFfpaptj8VECPqkc3z4xUrtWftPgPHEiPPrMRn2i1tL58fEE8b1avFK8BEAtkaDD2l8ACPdJwHw6RfHcIMrVn69NzRX56GSps0twTQHX9RSWiqwqf0dMcnw4UkAQ0+ZT+1CgjIY5Aso1in8/pWq887Od18UP29PVoNEdfsyyKSR3NJC39PTlvb8vANS4LN1G4v0k51OGSTCaHaxwIuQ+U3eL2TGzxVtP4tEix7dyb8A0LahBQc35blkQayB9LP4cgoKzhag76cxl3uAwCOefDmk/bD5asubHq4sMsm+lWMchhaT4w1g8V4TXDygYLwG79/soT6ZJKpxi4vYd3T4kALGrXxeqKANX+dRE5Q9IknvMIQ8GuQlYgmgW2o9GhHiETrgaMxyT75+Pp1yiiEVatj30T8drEFmLgi/thL1wiawOmfHCQpeWuqPJenPaBRtIQq1MXTeH0H4MpB2NZ6oIYqe6SICj9MFOHW6PbiFXc/2uL1HfK8i9Hp/3MHx6mSQIW/4ehv6Isau0evfJZDyZF9X+s+gOcsxCAMMg9pRPfg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: L2gauDE6u03o0h5pdGLWKOVxjG3D3Z++zSMNcOVOPOlvkNN9GOtFwJlYW4CrloyE+TYQ6+ZsfvG2aWwNFwthOA2ukqugTFlY1RAvWAwSJ5BZ0M2if8H0tk2DHpEKrKzQlpcG//qsDiPxKbU80RmUvjZ7ZKAZdBNkKpp92Y/WZlK7P2AvC0DB2SDMpX31M6wCJfD3JXiuwAi4t1gQjraDJ/EWwjH0xkcCsN0/7HzIXRutpqrkSDCuwv7h2w7TdbL5aMo9L92wL1MfsLbeLne8p6ifwiaQz09xzy6Hgg3AQM0WW+hlUsPUtUstL8hA0xm2zqapvBLJyurZ+OJYHsdKPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10272
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b854a067-2d9c-487c-892b-08ded5d76ef6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|14060799003|1800799024|35042699022|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tbmRBE0oOgsa+EMrr79zF5wTDMpWicow8THXBm3EnlHGEm9LdohRiaAapfzaaIbFAG19fkt7JnDSfY1vCdyDfHRdlVJw9I137IUcwvrJrGP0GUCK2MAIu5Z3xxNfRXPUkeHau4/t/PRM1aJ0oj0cZEkdJjSaFxkTqsV9bl7e6j/Yrwl9xMgdGlKP1IoGDMdbsy6Kh0CAfrO8aJhX4cC4G47Bb7ElvkH6+JKpchw/KUHGj85bXfL+qgyWXQDtgopZC8nl9icg2wKZzvTlviMZZUSMNg33z2NLOo+droIubmHGV6GWRPgcyKMhky0gV9eGQb0hvlAXa1JEO14EBlv+BHUPTQy6GZSqTbAJukD6tamdrfvO+bmTQNWbCFb9v+wyc1TWm6aFZYUbdkURUCwGtXbz9847/3dxaO1oeo3zdzpdmrvy+5KzMbJcQtGCKrg3Njr0pt3Uq/A/OpdcAgqp2qnMLJ3YKgO19ynx5fbVCyq0vO0Uh9XLaUDsQvGGG7CfMRCrLS/LVTdGzw9DqQ4qwRcc9eIv9IZPi/P0pdMUqayUf5/ak2KbUUNbUgRqkdZjWrzLw0It8+9wWeVj3p0CEZ655KmcYkE5mXsBXp3ZKJJjcfihq8P29jQrA1uz/cLHdyfBW1Jchc5QqFABu3CXig==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(14060799003)(1800799024)(35042699022)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XRPwfYQ4/9R8niFHdA/UnKbwL21HJUbTYMaGWZuqlykAFTOEUsLM2wu0a571r88Iax4fpbHJ1NnNaBNUWPj/kEA6ECbiF2rpRQE3b6EJKqOg83VsN1qd2+pxxSF2tC6ADSEuPv2vu+JiJ8W8k3pQY/10hNlo6ZX7SVVpukrCB263Y4Yj7AUB25Q8+2N+I9qKCOHVC0jnFhmYIugNbFE5OczPB3pAsu1hG/uiueARlFqFQczlNiIa+J6cb9BEosuT3wmQ5YE2MEQQJBiSuEtacvKqR6WfMASeMuvF8hGOkq/KJHR8HLGByfhCxwXQT8AzKkiC06m2PXdi0LDrhycFkqXo7Ep9tFzFXxX53DHB2zZTOvXu7bU8CFHa85hoji0230lH9CpVEUCT2Q6pMuNAVM2C7kfZxrfrJAtDt7phZUIuFo457WySVIisjlLzah0z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:11:41.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25407fc-54b7-4144-6fc4-08ded5d79491
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9311
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

On 25/06/2026 13:40, Boris Brezillon wrote:
> We schedule immediate ticks when we need to process events on CSGs,
> but those immediate ticks don't change the resched_target because we
> want the other groups to stay scheduled for the remaining of the GPU
> timeslot they were given. Make sure these immediate ticks don't get
> overruled by a sched_queue_delayed_work() that would delay the tick
> execution.
> 
> Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 8fd4d97b062e..ab3e13e44a26 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
>  	else
>  		delay_jiffies = 0;
>  
> -	sched_queue_delayed_work(sched, tick, delay_jiffies);
> +	/* We schedule immediate ticks when we need to process events on CSGs,
> +	 * but those don't change the resched_target because we want the other
> +	 * groups to stay scheduled for the remaining of the GPU timeslot they
> +	 * were given. Make sure those immediate ticks don't get overruled by
> +	 * a sched_queue_delayed_work() that would delay the tick execution.
> +	 */
> +	if (!delayed_work_pending(&sched->tick_work))
> +		sched_queue_delayed_work(sched, tick, delay_jiffies);
>  }
>  
>  static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)
> 

Reviewed-by: Karunika Choo <karunika.choo@arm.com>

Kind regards,
Karunika Chooo
