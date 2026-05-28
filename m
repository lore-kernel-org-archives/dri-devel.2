Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4884CD6E4B
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8863710F334;
	Thu, 28 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dhIFR03a";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dhIFR03a";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CA810F32C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wW9uAo4t4dEP5moRp/5GqCDTZTWq0X4Ozdou5xoYgp9Hha5u3ESSfT40/Jko8iO6EfBpohgvO6h7zBRDKdzZZyOnpsNtSbso5FTzvyH84ww4UITFDd7L1T8/Q7Hnr8WY3swHu7cuZ64Gm+WPUeT/F4otnwW7Ik0Z3WI6NxqpcHJvFKzpIMxqz2X7RIxna5onJrfnRdf2dcV1xLIuraG5AdS0qplte5g1yz6BZyaXjSmyCbzJrO4HDTTsL7qhNr0mHJfLa4gwb30rcU2WbYyj8OEKrAdWAKGTOSLYdHgVCeY3+MZmr3yYJp26TuztXWFu+Te0gAVaPFJO10+DMeK0bg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2eHSYICaROJhfP5w00n+r6BkZz0t3L3qAUDdaRAshU=;
 b=h3Q+7i3h1/6J+D1RF6wxrzZuQOPi92ubj4Z7sxx3tGQHaS3i/Ii2JjmBGeBM9XBXVmnyzdbDxNNuxxQW58Mdd/6GbjTOadNk6y/bRrAjLsf9XF76Iu0Q2I7zZnqhNa9vV6fVS8BocyvoBn+Sv1FUvT7J3cEEl1vkMtjZUstlCJV8GGFm/K9TJadWNS3UisYlEqDCj6CVAZisIaEXJvIoTnA9ndXJf4EFtz/xSSnL66h5e8foDRROwQkgay0oEZ9rotHKGWJU7GIVAuYBfS2wgq9lp8wR+TyhiGk8X7V17bbq52XNp6UxTwO149kAyM+erecU0hZNs0KrIzEGfdt1mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2eHSYICaROJhfP5w00n+r6BkZz0t3L3qAUDdaRAshU=;
 b=dhIFR03aGMnmFdl8Cl/fETOOvtHnJxH1m6VqoPE7X507d+N/whsyPoqgny6RekZ8gt2hmk6zexZXkvXYRY8bW/H2/gvuC0S2HDbeyIh0bk3wnlc5NTjQLsBhFtGdk64QL9B8iDrDrJpvLCjvbtVr8QBEmjsuu67SiswMLzD23uk=
Received: from CWLP123CA0173.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::8)
 by VI0PR08MB10448.eurprd08.prod.outlook.com (2603:10a6:800:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 15:07:06 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:400:19b:cafe::57) by CWLP123CA0173.outlook.office365.com
 (2603:10a6:400:19b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhjxhr5GjTQ9mEiR3Ql1d7S9u0sqmrd4t/XuTgd2zWUT94C1LV2ev6VlwQm4eChtwkkGiF3Jmw6zHzndsKzVrI207D4S4M9UK1/Xf/38ULKr9Jju07rMSFl30lxoJ5JqFDtfp368DpzV1BmJsyGC2+WOCzu/zfOMdhyq0BI1zvEijFttUrcP8e7AafOiRQIZm3A1axNd6Qretmhf/kLb3eBF2M7sd5kUqsrwYqL5aJo9Az6wfGFFkTQW266rMfxm1WqKYxrQ7PK+b8j7LHw9at1J0mr7dyM/fSV2io3Q6ti1ooM2WSOihi1HHguX/xWYMpivUVbGJ8NmR6kIO9d/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2eHSYICaROJhfP5w00n+r6BkZz0t3L3qAUDdaRAshU=;
 b=qchDodPwYwxiET9y63FFUlyG/yNEl90+tkZQNioDGsgdsqjrWfSiZ+PYxFKEQzAQfroxUjlMvHsaS76iryRrA4tHNwuEKP/wE4TvyZmhjdphcLBh2gtMe9F92Cvar9TKa7EAfpvsmDsKEI3QYl5fljvSrNkK97y3sx7G9GPp04e0sBOdtw7WCfAPbnPB4uzgUCftXzwwZJQPSMZK7uaTTzk7nFKsY4+PH/79KhE44Ip0xscZ1wO/DBO2qXCYeA8W8hQULre7VilMgcK+Fd354yEgh5Q4XGA2VMAzBvg0UZWaeuZzDIyaGf4b9rAYD8HnuKx2xclk7wn5SRhWLZDBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2eHSYICaROJhfP5w00n+r6BkZz0t3L3qAUDdaRAshU=;
 b=dhIFR03aGMnmFdl8Cl/fETOOvtHnJxH1m6VqoPE7X507d+N/whsyPoqgny6RekZ8gt2hmk6zexZXkvXYRY8bW/H2/gvuC0S2HDbeyIh0bk3wnlc5NTjQLsBhFtGdk64QL9B8iDrDrJpvLCjvbtVr8QBEmjsuu67SiswMLzD23uk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:00 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:00 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/18] drm/panthor: Move register base offsets to the HW
 description
Date: Thu, 28 May 2026 16:05:33 +0100
Message-ID: <20260528150546.3168527-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0310.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::7) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AMS0EPF00000198:EE_|VI0PR08MB10448:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8175b5-8582-4910-4b92-08debccac822
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: J8vKTTO2nimI/Bpht8VSgbE11ZzlTAbvwALbm2MzAjdESSkKVVhs+qNjgFWhrJn42wiJsJMawbRBTREC/ytNj1UA05Mz6nYs7Dj2dUp2bxCzcULVLm4CMuX7vPwvMQ+ElHJLTi/0y2LgPYE2sDLGwRwEB8eO7tEv+QDs3IMhWyQhEi5o46oRdDSs2WObKa95Rt/4yGprZooEALR3tFbFtlKhhXdtEAKoV2Ka/vPqdRbKD/osKuSCqCC+9heeXLehJb0LWXfsZcpGFCK7MWvp2H0VEc8O9lI5TI8HoLQRKExKQMKoRnGZJjm6Pg/IIdL+T2E1FEFNh1LYLsey8cqz0BovpXrffvKPeR//7H9cmQLYKBKS89pwMZYexmSl++MHmKpeGNQ6YavSvOfr2VRDCUkCcJD8T3oR9QAQX85wZbaq6YWJN8xAytg9b5CgPLD8YhL37y0XEyQdCwWRx7n7fVCdklPmGXQvDBJ7cesNZ3XwgucyYbUGAVd/QuV5IeUMmz/YK8+q1GkyNyZ1fndqvSwKBk7UmtD6RToN7Iig773i8+gyGUB8ysjUy+bBhqJvQkehcx7WdkR0PIQsmkUQ5ejwErwxdtwc7jdl6oZj5c88LPyTgAY6/P0i9IDRgheST14xiNkgGZukhaWAZ8Mh/jm9lMkKnOEYNuvZUh3zQ6xNdiQ3HKZmVoz9WpIk6r6j
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QNMuumzNSX+gH2nwYbj+57VRq7IoDfvWtam5LnfBktbTuvT0J/pt0oLSu/QZ/XXOL/cHjwpPT5JiffVYzGHu0QOp8PYc+bunlaucIzN29CYySfj1/UhY1/frHCzFq/zVH3e+rZRdlOMn7F6GWQRCjCUw6PAgeabWbMHABcZhLTemRBZDT7iSVfP25Zzpc4o028wP3s6NUv+CQRix+OgESWjUAzzycFCpY48EN4H9mkPGrOXNZlQp4yb/luoaKqiA6pFroQ8Dlx0zNfpQTNecAczTQ5kBa/kfJtzYxh8xj2FxYp6yqtSJklHuwGtFxXbEpqSqBY678lu25C3bTwjxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79a2eecd-e253-4f73-5a52-08debccaa0fd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|14060799003|35042699022|11063799006|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9pmtWfSAdNGE77IfXDd9i9izazAVZ9beTCEVbgoWFd5RBBozXbTeVZu8f/3ZrNEGr8teR43FEQGz4B4+JRRetTxZOsU66V1M6OFD49Wi+UVUsCvcpeCwepJbhl+p4aP5/Y/iEpiQG6PwcNosFN/9yDC0HifeDydWsadQYPv9Q2a9HfAlZBOXcaxRwiXfhSNp/mnRPqKOdX/yZaPq17lxnXPjxburEgtDvhDe5fE7TjCioGaB3ssOZJHhkrh8VAecdZTbocZciDIntNk/lfL8sDSIJEHMJHoxaSnRpba+egoRyJnXaaH7GqV/vWKU6qf6aRDislZBBMD8bjgT6ytsm22SoGwXwS40k2QUesfQySAzBCUWy8+mySVZUm4hPgFZntRl2z/PshQOd2TbfYxat3jWIGLATwYgx5tkebhhZWXtjIul+eFYPkMBtsLEJKyBrGTfpz0zDnadxdcvBxdJVuHTld2oVKXrRMkZptuEnQdRDXoBQDd4yv4244trxx0aKAKENTduaBtwoGkoN1gO3sNHEG1Ld9Kpvh31PGIwF9R1l3VHilB6cVhA0qLqQX+W9UyDoESkpu3tYWuyJB4gzBJBNdVVpebXvV4+BB/d3pLIlGKhh3SOtEEtO0WWThp3ltjpOszYvcqazZP3e0XV7OnSo4vywg0zMHsBUOcz05CHsUTVcv2VSUwvgcQCo0N2kNklFqYIG2WvtxHhKrQtFAZjfUeRY+aoiaFVj0qWxxQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(14060799003)(35042699022)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9F53V5BuJ3vu7t0Yr6BXbcWl2thMbF2c+PKPLk/cBwGHUhVeZmxjsUQ0qDHWx72nRstchrJ4gTkj/zTKQxNlfhJLs9uCkKDll9ROzL5vz1XVtkwmwf/b5oV/LMu9JRXTSF11IGi7XxWeBV9GYqaBfe49kkv3JRoybFkFpB81QyCUaJYlzHOOCtr1WOrZfebaRtxLNzqgaC/YUrKUnIfzyrRgYEQrGi4KTNBGGmPgiFiHDIrrolkRXGKpbO5HdSuDB75lOguUCzSVkS/2vYq50nwzJjNFy1HlaHMaFfYeSu3/gsGn6Br57pn7iJ3eogYwjhJ+MIBpqt6GjK6b/H6ZLVPs2NRH19AaCgeprHR3dL6SD90hotTPc8dy9k+KifsGK75YJN8HyEUq+fjIIs75OsIAqzjCwhkYLQMGp+OfCYS9sEEw7dKnlrsHW4UCWTM/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:05.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8175b5-8582-4910-4b92-08debccac822
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10448
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

Mali v15 reorders several register regions, including GPU_CONTROL,
MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
fixed base layout across all supported GPUs.

Add per-GPU register base offsets to the panthor hardware description
and switch the GPU, FW and PWR local iomem setup to use those stored
values. With the base addresses now owned by the hardware description,
drop the corresponding fixed base-offset definitions from the register
headers.

This prepares the driver for GPUs with different register layouts
without changing the existing behaviour on currently supported parts.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
 drivers/gpu/drm/panthor/panthor_gpu.c      |  7 +++----
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 13 +++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h       | 19 +++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_pwr.c      |  4 ++--
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  3 ---
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 784d0a25beb2..f6381f5f236f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1467,7 +1467,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
-	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+	fw->iomem = ptdev->iomem + ptdev->hw->map.mcu_control_base;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index b2e59cfc22b0..a3492f7f913f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL_BASE				0x700
-
 #define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index bb5e64188a15..3c88a25287bf 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -154,7 +154,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	gpu->iomem = ptdev->iomem + ptdev->hw->map.gpu_control_base;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -170,9 +170,8 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
-				      GPU_INTERRUPTS_MASK,
-				      ptdev->iomem + GPU_INT_BASE);
+	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK,
+				      gpu->iomem + GPU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4..753df8700990 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
-#define GPU_CONTROL_BASE				0x0
-
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 833d10cbb2d6..1f7fab4caf4d 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -38,6 +38,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.power_changed_off = panthor_gpu_power_changed_off,
 		.power_changed_on = panthor_gpu_power_changed_on,
 	},
+	.map = {
+		.gpu_control_base = 0x0,
+		.mcu_control_base = 0x700,
+	},
 };
 
 static struct panthor_hw panthor_hw_arch_v14 = {
@@ -46,6 +50,11 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.l2_power_off = panthor_pwr_l2_power_off,
 		.l2_power_on = panthor_pwr_l2_power_on,
 	},
+	.map = {
+		.gpu_control_base = 0x0,
+		.pwr_control_base = 0x800,
+		.mcu_control_base = 0x700,
+	},
 };
 
 static struct panthor_hw_entry panthor_hw_match[] = {
@@ -197,7 +206,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->map.gpu_control_base;
 
 	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
 	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
@@ -223,7 +232,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
-		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
 
 		/* Introduced in arch 14.x */
 		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 2a666d8cdb98..58673a427bc9 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -26,14 +26,29 @@ struct panthor_hw_ops {
 	void (*power_changed_off)(struct panthor_device *ptdev);
 };
 
+/**
+ * struct panthor_hw_regmap - Register base addresses
+ */
+struct panthor_hw_regmap {
+	/** @gpu_control_base: GPU_CONTROL base address */
+	u32 gpu_control_base;
+
+	/** @pwr_control_base: PWR_CONTROL base address */
+	u32 pwr_control_base;
+
+	/** @mcu_control_base: MCU_CONTROL base address */
+	u32 mcu_control_base;
+};
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
-	/** @features: Bitmap containing panthor_hw_feature */
-
 	/** @ops: Panthor HW specific operations */
 	struct panthor_hw_ops ops;
+
+	/** @map: Panthor HW-specific register base addresses */
+	struct panthor_hw_regmap map;
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 1cba093a2452..b833e4559e45 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -475,7 +475,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
-	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+	pwr->iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
@@ -486,7 +486,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 	err = panthor_request_pwr_irq(
 		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
-		pwr->iomem + PWR_INT_BASE);
+		pwr->iomem);
 	if (err)
 		return err;
 
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 9cf7a715066f..12939dcd7519 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -4,9 +4,6 @@
 #ifndef __PANTHOR_PWR_REGS_H__
 #define __PANTHOR_PWR_REGS_H__
 
-#define PWR_CONTROL_BASE				0x800
-
-#define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
 #define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
-- 
2.43.0

