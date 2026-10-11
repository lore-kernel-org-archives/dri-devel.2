Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB31DCA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C69410E33E;
	Sun, 11 Oct 2026 17:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="eBk5e/9f";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eBk5e/9f";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E7D10E135
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:26 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UN7OscTIYuBVObPGG9ktQ5xn5XfpZtyvUGyhOR95zBT+0J13JnB5P1mvnfZUcH6o4BluDdlrnvO92Mj5ctJ8/bLP6Ft4Ogg6ZFb3XcKsSeNjT+vvPuSkg8B+XuF9M6eE2G0vhlf1f2ot2AzNvGGBccrEo6+cOQ9bEGLF5BmE9OFjlvZbwC2t2JBfOgY5BUkKwbpPz2CeirWXhKrfW8pRxJBkQobC9gcio11uSCbIGPiUDWgMQAp0bGtdfXmIkMUEmdJlh/+UNXdav3wBSHiqrege7mEzfUgJSC5R2xD9WxX0Wz36VbJb9RxJJlHo3HPv5ft18T123mhYSxtaCZ+VAA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc37M6QgBRfufBHCc3OxQCMD+F2pIrrBVzaBaFbLNKM=;
 b=fOkMNLSqKzYBUoDC78pim6f+VIM+3D05r3XYfwcSSIrzljSmLOYvpV5+RXTfrUOWuN1L3FNUj4CaCaldW26i2VaAo2t7w3MWUpw9LM9FK3F0CBdKJgOYkP9q+BrLGzfI15ZfxxX9K8z7YwK08uOu8WZnaSMxBeyjrWn9lVF/QQkEEA5OovIZal5pKDK1Zjl0Djy0tMkRCjpYsaZvNh4hpB9/dBB0b0iIpfGfWWSfexOKuNW5s/BItR/vZ5xtbn+KutNLmgX1fiEdZKTbmh25myZ6DroEG6DsxzY63mRni5QafD2wq5YltT9CKKtFL3EcfoIdbs30Gv7vcXEuQ/5+wA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc37M6QgBRfufBHCc3OxQCMD+F2pIrrBVzaBaFbLNKM=;
 b=eBk5e/9fi9yRV45jwpUVhsXi88NBi/KTXomjvQZYgBPxG0mXDSD5ZEbE11oLvUmEXIp7VFirwVqc5pdpuSsA24Esp5CTBhy7ZveVpV1zGFZGDGE4jQGz1MgWdfoch6CYvcoSoGjsAw9KC/gkIRIGluIarmJEyqNQf2/SQ4/STfw=
Received: from GV3PEPF0001DC1A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::26a) by PA6PR08MB10596.eurprd08.prod.outlook.com
 (2603:10a6:102:3d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:22 +0000
Received: from WA1PEPF00009B3C.eurprd05.prod.outlook.com (2603:10a6:1d8::11a)
 by GV3PEPF0001DC1A.outlook.office365.com (2603:10a6:158:400::26a)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.13 via Frontend Transport; Sun, 11 Oct 2026 17:40:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B3C.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXnwAYcHFrLrw+oTdJFTw6QLdrMpHM/3TQxQiykugnyDuZFjFAxKeUsGD6utPNXsyox3dXwU3uWTiKJv9brNsCwkr1f1Kk4NvKVguPF+oBpznAOAYWNv3WcDbyWCHpUO3a5HehH3q4w5LW0h2CcGmS27O8f7m5ydaCedoVvrfSlwb7pGVGGJkualMsXrzyJsHhnE/vmNY+BSv5PQvO//363XZTow0SN+dukxzYuaPhem9Be7+58g9joOT/CJMCUdeGvsoPB42CURX3HcwdQFpsRsdQFx+9+ZROiinokh677VwMvKcnt7W51V3qfTyctDrc8WxbZP1F0xMwYXXNw1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc37M6QgBRfufBHCc3OxQCMD+F2pIrrBVzaBaFbLNKM=;
 b=f2YIPfV6bQdvQZjdqMCweAk8yVy5a4g/ky6UOUsM275HR4kavBYrPbSfUDZs5g69zMXGOywVfCy6/uNaVFdpgAs24r8AAKRI/0JYc+2m7FcREH4Ju5AsWgDPYbDIcI0KEjYNKOajTmtqvaetoCHx8Jvs2C3NFM+Vn+LmgP3jizbYoWHwmckzmIsP0sTAvTnNbUMfamjaB6HsifcTRA3gssxIQEqJ9Yt92hfYUMpO7SJLb0C/bpvfXSNmf7y+4tREh27hDm/cp3jrDpG+V8+Y97s5b7FHJFDGN3KkHd1m12umQtu4ARWqq37v0P7r6lnkRHnNR5lwjzMSSO5PwROj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc37M6QgBRfufBHCc3OxQCMD+F2pIrrBVzaBaFbLNKM=;
 b=eBk5e/9fi9yRV45jwpUVhsXi88NBi/KTXomjvQZYgBPxG0mXDSD5ZEbE11oLvUmEXIp7VFirwVqc5pdpuSsA24Esp5CTBhy7ZveVpV1zGFZGDGE4jQGz1MgWdfoch6CYvcoSoGjsAw9KC/gkIRIGluIarmJEyqNQf2/SQ4/STfw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by DB9PR08MB7496.eurprd08.prod.outlook.com (2603:10a6:10:36b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:48 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:48 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:55 +0100
Subject: [PATCH v7 8/8] drm/panthor: Expose the panthor perf ioctls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-8-12c32495062f@arm.com>
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
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|DB9PR08MB7496:EE_|WA1PEPF00009B3C:EE_|PA6PR08MB10596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd9dbb0-1f2b-4465-5870-08df27beb911
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: yd+NeodbJCxLzY0f02Ug/68+MjvMC0VfSCfZNgODE2XTnwfq9t/CJHmjlmET7tHb3OgxG5fPyCKXePgUJHUKepw/sR9nauJLWLQxvk9txR6rwIWWIsXlBnjKgQeD+S+vukF21yLU3v5Sj91o5kT+t3115G0qpHh1ekG0qt6lvs2jrz/NeWvdu60svHIYDSYxnd1jo1olgR99uDlTPPu0oIEABZuL9nkOhLjb2BtVCaVqeb0GHqnUQ/zLKBuBWVdtXR8z5s3kBoRaj1HHDakhwCYAfD2u3SD/vDNeUtaBEQcSehwvIb3j+7ku0cfnA+6dLBOwZxJG/zVwOXBqxx3K/aTaCFabh6aQE+/wKBWMFOIXaiyTJkseQbP/Fa4s0D3P1LZ5RB5H9JJFLAa/BPPzyi2uvjzQW7qN1FsPQinACUxuYJ6l2gxwI4sNd/hjhvyA1p3T/TbSPsjslSFBHyBdAYig1HswX5ALSqUmmU7/LwTpxkoXvyalEm2WE4l4U0x3Kr8vYEaHEga11GsOsary1SLyE7hRFmBZlB1uSoGj8SM3QUjf7W2I+Gc2NxVvgq+VYxjZY2GKflkT+IJW7ComS/LzBj1YPzcPI5OEZ+q1tWFoeYDqeak/3hT4J8znGyein+BAksf3qHHDvENLcTR18KnEHTiP8Ir5b84oo1Bpu5X2gZqXN+n2NucjBguaLJvc3eZyNNyzirxDAssdmV9z1g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: kdyC/240y4WrE8RTN0TvCZ7yyYEAU9UrZT4pCwhC8fCzb0pDUXjDAgHE7SwwPZwGcU8CuoMiHSSPxFF4hueWgK8Qbxt6esliUrWdzAyYdBA1ouhtx2YHpIiPejiAQwI6h/WO624Gyx9GLFDs0k+GZ8H4jgaxaYf/Cq+ALygvp/zNY7cMgi99RbBunWs1jWDTg3Chgqj+0xec1rsqnAsJTHVsINjkEJxgyXd4Gb6suOmLvZ6G3ZsWwbSrIF5J6Y+2qb2NJFfpC62Eg1iCkm50amTh1RdHu716yQYmpnag1hSEYKJyCurHE4wApGeOt8WkwVyTn3KhBRP8McWO58lD+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7496
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f9336985-cad9-4289-1d90-08df27bea556
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|7416014|82310400026|36860700016|1800799024|14060799003|23010399003|10067099003|22082099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: LIH+zVrp+3NHEl2YIpuH7XcnSGB/y1UgWQjU8YQw6yrxv/Sd72wU3bP6Kyh+A55hOxSimUhnYCWfFycC6k/wRWggjVvQ10kSUSGLNKtCaJolHSU8fA5/HonpbVWADCDkB9NtXnj4kG75eR5aqZkMgDvl+obqvVpJbu9zz+ZsrhclEH80bFYENOuB5Jy4UHR0MJo/EAMqQip2pprQ2CShZitR3TwwiWsbt/6OAiykzshFXb/8vjMG1aV+8yfLLDP/+7NLgSQ/ejxXo1XvVCj/lWxKktcP/ph+uka+U4Wl9wjGU8cSeOHOvmId2WSnfvp7BowMklBhGj9Gs8a0LqzGKYLgasOIuMI87eNAI1J/h+YnVSxYqpyZHGfhflmD9NFVJVBRbWaIQ9jldm+sO1mJvPDcHh7oF6AEFaOKseDtdsgLG1+yB0ToDSUOI7pL9y5qSDMYF02+MkD1Jckgqf8u8Emjj+02Kioat1krrfU56FigMUyubpzwG43AFOErmwfLVBDlbAJRSJt/Y86TMYzfNrHh+e54E70Dx0tazj/jBPb/UXuau9s90I4AK3DkXw7UNEbx3LgDJDFACo0MwKBpeXTEqg4JVW/n31Qal6Zj36jpmONseSVBpyxQOPMBQ53dVu3yZkOJ4zN2gNZ+bTcxZB7Hm8w9kLqnhuU8u38NA26Mnp67c1VrhKoaHDClmj+UuriECaAXtNbQVX+5+bFe2T1BtN7P5FHoRM2L8NLZ3k+TA4P1ogDpbFH96d/eGFW3
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(7416014)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jdeZqSfxrRKwPEbRZ6QLBf9yQQ4w3kOyRaawFyI2Z4iHD+p5I6NadkC2TWMxHk8QnFMZH6zoq6Fdhjylm5ktpZ463Z0n4AzuCzRqfsFv7Ue+4AWDrTdEyIAJsjDmHY4zQpiqo92Aw0mQaBT1DQD6rmAgWUe2/KrCk042dyTbZQziU/8UenLdtTBEv5eG4DqN29URXCHeiu3sxSpDCr/P69k5+9xh5e8LrXUEZS/ukF1kCXiy/YvD2v3qCWtx2nQrpkSIgT6My//JvYAtqCJLWUbHJPpPMjhjnP9wKOkmG6XxS5aFGPmP+QL6nOpJ1LrmKCv6lEryz0HLZECqI/rG3wKGxUmU8sXMjltrDeRaDshcqfyYqUZfs6zMUCRdE94q9Jnyn7jq82qFkl7dVdlez/j+8SDeB9erVxL/XwnS+Pe7PBXns8BjXlOzbpJfJhwZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:20.9971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd9dbb0-1f2b-4465-5870-08df27beb911
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10596
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

This patch implements the PANTHOR_PERF_SESSION ioctl series.

The minor version is bumped to indicate that the feature is now
supported.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 117 +++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 3e62142d7ebd..5ca41cb9c1ba 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -184,7 +184,12 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_create, shader_enable_mask), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_start, user_data), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_stop, user_data), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_sample, user_data), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_destroy, handle))
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -1603,6 +1608,103 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
 	return 0;
 }
 
+static int panthor_ioctl_perf_session_create(struct drm_device *ddev, void *data,
+					     struct drm_file *file)
+{
+	int ret, cookie;
+	unsigned long sid = 0;
+	struct drm_panthor_perf_session_create *args = data;
+
+	if (!drm_dev_enter(file->minor->dev, &cookie))
+		return -ENODEV;
+
+	if (!mem_is_zero(args->pad, sizeof(args->pad)))
+		return -EINVAL;
+
+	ret = panthor_perf_session_create(file, args, &sid);
+	if (ret)
+		return ret;
+
+	drm_dev_exit(cookie);
+	return sid;
+}
+
+static int panthor_ioctl_perf_session_start(struct drm_device *ddev, void *data,
+					    struct drm_file *file)
+{
+	int cookie, ret;
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_start *args = data;
+
+	if (!drm_dev_enter(file->minor->dev, &cookie))
+		return -ENODEV;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	ret = panthor_perf_session_start(pfile, args->handle, args->user_data);
+
+	drm_dev_exit(cookie);
+	return ret;
+}
+
+static int panthor_ioctl_perf_session_sample(struct drm_device *ddev, void *data,
+					     struct drm_file *file)
+{
+	int cookie, ret;
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_sample *args = data;
+
+	if (!drm_dev_enter(file->minor->dev, &cookie))
+		return -ENODEV;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	ret =  panthor_perf_session_sample(pfile, args->handle, args->user_data);
+
+	drm_dev_exit(cookie);
+	return ret;
+}
+
+static int panthor_ioctl_perf_session_stop(struct drm_device *ddev, void *data,
+					   struct drm_file *file)
+{
+	int cookie, ret;
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_stop *args = data;
+
+	if (!drm_dev_enter(file->minor->dev, &cookie))
+		return -ENODEV;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	ret = panthor_perf_session_stop(pfile, args->handle, args->user_data);
+
+	drm_dev_exit(cookie);
+	return ret;
+}
+
+static int panthor_ioctl_perf_session_destroy(struct drm_device *ddev, void *data,
+					      struct drm_file *file)
+{
+	int cookie, ret;
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_destroy *args = data;
+
+	if (!drm_dev_enter(file->minor->dev, &cookie))
+		return -ENODEV;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	ret = panthor_perf_session_destroy(pfile, args->handle);
+
+	drm_dev_exit(cookie);
+	return ret;
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1687,6 +1789,11 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_CREATE, perf_session_create, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_START, perf_session_start, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_SAMPLE, perf_session_sample, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_STOP, perf_session_stop, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_DESTROY, perf_session_destroy, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -1807,6 +1914,12 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds DEV_QUERY_PERF_INFO query
+ *        - adds PERF_SESSION_CREATE ioctl
+ *        - adds PERF_SESSION_START ioctl
+ *        - adds PERF_SESSION_SAMPLE ioctl
+ *        - adds PERF_SESSION_STOP ioctl
+ *        - adds PERF_SESSION_DESTROY ioctl
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1820,7 +1933,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,

-- 
2.43.0

