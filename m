Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4A1CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67FD10F348;
	Thu, 28 May 2026 15:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JradGPD7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JradGPD7";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011040.outbound.protection.outlook.com
 [40.107.130.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0150810F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:21 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n9S19tLdlEm/yimevpUifH0Dm282fT/0f/JtQu/M/YaXvqw96vESyank/9/rkBaeq6kFHYjdL1jlytHw6LMd4+q93/+ruUberdO729uZ9i4hJpyJ8PTfp5LQJabWeJOXNMiu8TK3jIghyjiizXy9Q1ZfKfrui0ouujN7sLZR3F1De0TIUOMYQ7KMjxwloAdhqRFlDlWR9XkIDqzL4upjW0mT1pkYzPmwnkLJGKuTi1jrwqJR8rhWZJVr0zQ2XGQOUGQUPJEDcLvzt6f1rU0mJlt1gxK62fFbhYGnhSNnRmIShDzJ1++miVUQA4nRaWD6dgsqxi4+URGu70kMt3rvkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbSAjjclZghagaKTSrx5vnYkjZ7WfMN9xwRwP62qQqk=;
 b=eTE0kxMWFDW5T8msKBO4lx1lYrSLRszfv4cq7Ta3gqqmP3VoaYeH06SWu1xzVq0R3sEZhopDPnyOspCGX3mjD8NKCNxGUU6+qdP+/8hpsaRufNP2MayKDa9rZ9jfdCtkgq5YQYuZwOMD1U3DZaX3ndRi5/QtHeNO3zleujmOWaGe5hNWPH7Nvwn6dOdhb9ucTTbwO3tlIAfT7ASWZQs5rZPIXuMtC7PXyejuztte4uo/xbGCWMF5ZpyFoog2n2+tt2iLroGDyRbiRzO+u+YJTvS+itxeFfua/sXNdut8nSSxRr0pFFtaHgWcOdGjrrGzUzpOap8EXQVpybWIaq+NhA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbSAjjclZghagaKTSrx5vnYkjZ7WfMN9xwRwP62qQqk=;
 b=JradGPD7ovTLmBGXCFOIms2MLXi3XjQqR8YKQV6J0S9DRYE7Hj+AuafDOuj6ib/7fvC5Z7O5g0wx/+bH81zUSatF+ywzclprSHoIRje9Ol274xC8UM/C6ZR8qK7UESd7IN6Bt7raTKT/COzQT0FPOxU89nb/Baj9bu7bVfVLOOs=
Received: from AM0PR05CA0080.eurprd05.prod.outlook.com (2603:10a6:208:136::20)
 by DBAPR08MB5735.eurprd08.prod.outlook.com (2603:10a6:10:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:07:16 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:208:136:cafe::48) by AM0PR05CA0080.outlook.office365.com
 (2603:10a6:208:136::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfGRCmbtXHzSFwomThuef2UzsYiBPrcWT2IcOv+3hXEhE/St8D1tCg/riu1vp/iM1bXQ/yI7UQWadvpOm4rn+D9F3V3Cl71aP72A2bwn0s35nw/y2p1tctgmv5mioozyfpSADMnwxin1UOaXuCfedS88fM3OPFa6G3hyYAuEXW0x6ot8zAiVGQ0AVvKR2AEQMoX5ZrCCx3gha1D1aB4CbrbX+QT7Y8CsgnM56kBu2UWv2jN6BWuEofBO8ONEI+l+qhYH5L5s09XsfReUSWHhQ83729n0/lN+hNj4DuKkW7pEFatLrCHg5RjmGKsSkYAQnyUrXWXIQuxFprTQcHgiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbSAjjclZghagaKTSrx5vnYkjZ7WfMN9xwRwP62qQqk=;
 b=AegvnZvJUaJ+n4HmQozU5JLwwuUzrNauHep3tfuJh5B4sYhPQitaOiqn3RlobVxpjh6BqLYMWuVGipTiNqgIrYPP6brVZC235j0K0F435QGWXSMNVk4ZppyIZspJRQEFJPSwre05ElUvdU8SZbRHsMw232TPkaiO8u37rxNSZfVWRAf4f3divY8+I2ECO3Dp2Ptiklxy8QduAPSu4dtKcinkyvdQgR2ukMMK9pgy5N/4K0rD6QafY25ohZGQ95/0sCG+9SjQ9OfVIwzhXemMEhoigflqx7KbuCup5TKzegWSLzGxDEacyvlO1bnggA0PFpw7fuMktn2xmr0Y6g2Wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbSAjjclZghagaKTSrx5vnYkjZ7WfMN9xwRwP62qQqk=;
 b=JradGPD7ovTLmBGXCFOIms2MLXi3XjQqR8YKQV6J0S9DRYE7Hj+AuafDOuj6ib/7fvC5Z7O5g0wx/+bH81zUSatF+ywzclprSHoIRje9Ol274xC8UM/C6ZR8qK7UESd7IN6Bt7raTKT/COzQT0FPOxU89nb/Baj9bu7bVfVLOOs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:13 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:12 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/18] drm/panthor: Route arbitration events
Date: Thu, 28 May 2026 16:05:42 +0100
Message-ID: <20260528150546.3168527-15-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::11) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AM2PEPF0001C717:EE_|DBAPR08MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1223ddee-38ff-4558-7afc-08debccace6b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: rpG/j52fSwVEphI9tXYBzkuqmvuOwZFR37saJnO9cYnbojwaq5yN+WwwKKXyIF6KuqUIkPCVmnQ/6M4onqBcm4MYHqkyn7rhns38OR1dKyXZUhe1B58WoEVGFng6jWL3Jbk3iTicemC30+7iGLTjZYI6MpjAKkdZhpS1LLR4sRsHKIBIDMwc5iquc4UzZyl7qrTv4boj/6ghjP2ijsdmmcQLF82kFsEi+CNmWi26fqjO33Saff+Fuv+WSc9UIbyZ5Nd9n2agq9UjPK2/XwB4qOOlfMmoNKYlUnh+4ikMslaNrweOyApTRMutDGQEkzIebEWgCa5UybTuDfV/O4gIiyW1X3aARQLx9QyFjRM/d4TDsf60Wg/HgrRuWsDHtQxB1+O0fGjQz1dwhRfYLEmZasEmqYjB5N0nz1EykJY6MvcA/nJRlg1wq2nJQw7Fy68KOymZlz0vQ0fQ6hGMyTiTpGZUx+AjvO81849DHUMldyhVYU2dc8V44y4hDG8tGsvOXXyIlt3A9T5HxjxGFLkhYKMgVQr2VuUe0aOuqZcmFYYGJCtq+nv7LwnyVH0E0oAYOsik8J3vXN85aOn3Sx+rL+yQukikKv3Y3KZABFxvMvg5Rvp4WXPsQnhJOleea9m3MYsu1DpxX16rMYs54kmDmWQNdlE9sg+9DY9Pw4GM4dZVP57hOX+1+zBDVOH7Xx96
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oQhYlj/a1Ejc8WeYz/VdMA0QjRi8kEcVVUxM0/EZ1CDhIm9mV0iqQTEZyV/3/STNBowzXWQ34vJUSSVxtAl5oUI/qTaPT5Rly94ysZLEMfGaaPtT/4nXgYb5uk3wWl+sVtp09H0WL4iowdIFRqurY+ZD4fqMHe5scOltR0qkYdyfCz/odRzHDW1DC3rzLZl2pHXIe4BQRUbXXtA4vFp5tCXeUO3OulEvVDE1FDHVLiA6k8YKD//VcFldCG5TA9mHwlCOm5A9sWwZskWasqt2r7VhT7R95KDp9u5x5TNxIj6JqC+LkhfDo+2YbUEk7nX6uQI6l9V+RwWD22e8GvHbVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b532d5ba-5cd4-4cfc-08ce-08debccaa847
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|14060799003|376014|35042699022|82310400026|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 9Hr3V3b81Viw/JrZhH7DMyFBRnQlelBGcU6ha76cJxvbxYCSZaVSXFzy+IuFAL1e3EQxewy2rrcij3c6XJpfhceBlQZPhtw0kOd5bOXlSwSdchnjLOdnTRKhzwwEK+rgA1pNPL9sOQCu8O9yX6ihSb6qbxNLmYynmBKHOPcEhefE7/FoPlDC78kfwpS3Bk9pcV26Y+ko2+dK65AmkmFczfhKhvt3wFX9w+cdKXIBVjA4raN3vdGOdkE02SmNHKKN6OcuWAZFtwG0h5V0bThkkmvYo4XCKTS5gCjCwBSkb/DRYWgXYZ9oNfGcrpx6iBAMQOTJ2VGxiSATSCo/iCoCWa7wNbuPF3CW9xt25wmCLW4kFU842L+l/vpomf431hVxsdc8bEiWS8GhNZXQcr5oi28Wt3ZNhR8b7oMTTSHgXpvJw3xch+haZOTe7rtPeVdbiepgdCZp+1fFohiON+pPsx2Uy26GiaZselT3LCdIqgDdBERiQy7dluP8ad7Z/otEA/ThtXGw2Bc+f8Tre4F76ipEbrlLNr8mQgurbrTfLOt0AP1ZQhhn10O+OKT9uwEVljMqbQX3uuiIUnHksSw488btB6Pm40BniqSgbxFggzWK8NspCelmwdP8/CXh/aRo9OPqhdT7IbMoqXDkQPlvCk3NGIJwYSk6ZNJTrDUAvsPBNdrrg3ufGg/F5AnLDbUUvhx/X6KspmvQDvTRC9APrh+vwCGnZH7MCniABTCdOzI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(14060799003)(376014)(35042699022)(82310400026)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HSa1g3/tSfWWGSs2A8FHOZM9r1lJLyTr82vypaoo9w+DxvB/GPi1k1lVv9lIRRtw2EoVsB4EWIv8wg+hVaN5/UR4R7HD4PrFmbbSmPIhBCvblrv0EXZU+kXDoS3aXF+aNRnWFL3VPIj2IEisSsKTQ61oePoCp69a5QtQRQmXxpQdyWY8pAKM1F7P5yWSk1SjGpSeqxmGAOHFJ1cxaKRcd1eUNIW9ikgDcHuVYT68gQH9DPdAH1/WFueI08kul4fyyO5M63IscRE6otF9ATlmZjVfmso3SMVezIb/Z0Rn0Itp7tM96bvZ60n79b/c2m2J0sNpoEXgRuETF8O14jXFdMi4ifetkcwy5+WYNXU5h2ERuZqlMsq5YvoVW3Xt/tm7ZcGeZGUHMtusSsTStdDREMpOthOok8T/3IjPPs2C8ijb6Cb7hCibYsqL1eFd9Bck
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:16.4712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1223ddee-38ff-4558-7afc-08debccace6b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5735
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

Wire the resource-group, scheduler, and partition-control blocks
together. Resource-group messages now feed request and idle events into
the scheduler, while partition RESET_DONE from a YIELD_DONE reports the
active access window as stopped.

Add the arbiter-to-window callbacks used by the scheduler to grant,
yield, and close partition windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../panthor/arbitration/panthor_arbitration.h | 12 ++++++
 .../arbitration/panthor_arbitration_drv.c     | 38 +++++++++++++++++++
 .../arbitration/panthor_partition_control.c   |  9 +++++
 .../arbitration/panthor_resource_group.c      |  4 +-
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 0bc683e6a71d..fca1a2325b16 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -4,6 +4,8 @@
 #ifndef __PANTHOR_ARBITRATION_H__
 #define __PANTHOR_ARBITRATION_H__
 
+#include <linux/types.h>
+
 struct device;
 struct panthor_arbitration_sched;
 struct panthor_partition_control;
@@ -30,4 +32,14 @@ struct panthor_arbitration {
 	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
 };
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id);
+
+/* Arbiter to AW events */
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 5cdefd9ed5c9..edbda1845068 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -55,6 +55,44 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	return 0;
 }
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_idle(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_stopped(adev->sched[0], aw_id);
+}
+
+/* Arbiter to AW events */
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_open_window(adev->pc[0], aw_id);
+}
+
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_yield_now(adev->pc[0]);
+}
+
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_close_window(adev->pc[0]);
+}
+
 static int panthor_arbitration_probe(struct platform_device *pdev)
 {
 	struct panthor_arbitration *adev;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index f4bad839610d..095e19c8d4c5 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -220,15 +220,24 @@ static int window_open(struct panthor_partition_control *pc, u8 aw_id)
 
 static void partition_handle_reset_done(struct panthor_partition_control *pc)
 {
+	bool notify_stopped = false;
+	int aw_id;
+
 	scoped_guard(spinlock_irqsave, &pc->lock) {
+		aw_id = pc->current_aw;
 		pc->current_aw = -1;
 
 		/* RESET_DONE from CLOSE_WINDOW */
 		if (pc->closing)
 			pc->closing = false;
+		else if (aw_id >= 0)
+			notify_stopped = true;
 	}
 
 	wake_up_all(&pc->waitqueue);
+
+	if (notify_stopped)
+		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
 }
 
 static irqreturn_t partition_irq_raw_handler(int irq, void *data)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
index cd1ad0532766..6264efc2e29a 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -127,10 +127,10 @@ static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
 		rg_respond_to_handshake(rg, aw_id, message);
 		break;
 	case VM_ARB_GPU_REQUEST:
-		/* TODO: on_request */
+		panthor_arbitration_on_request(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	case VM_ARB_GPU_STOPPED:
-		/* TODO: on_idle */
+		panthor_arbitration_on_idle(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	default:
 		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
-- 
2.43.0

