Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABDC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2404810EEF1;
	Wed,  9 Sep 2026 06:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="siKYB46r";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BB510EEF1
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsK+AiaRJFmDSlOyBWA+zrCWffnY20dsGxqNRM9GD14cG/wGKDW17vZopp9VAkwNhdFIiRgYkEAF6mb6B5Z3q46Dl2q+u/j8QQUZU+bi5Ddc9lHmHwhkyEtT6cwp1XIJu6ZWEr8Ifo4xFAjehSXGlfxibIRmabBAHsth1Xv0M+uGCMGMNWypjI4nNs3FfmS70/LD2V5piK27LZ4jy9ZvC/QgDUgXaGMdYK/DvIYb3x3JKJl5qPwLgK6WTfyOsfxKc525e4ZmC7veHjRLS275HBkHCjH5/ctOdQMpyBrB1TR1HhdW+aa9vOtro++IFXkQnEbaE20uJNK9KzmQDIxOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEI564vw5/zPm50At7cNk26Hrh/9B0lrfhkrt8IIIX8=;
 b=xKo1UaiEQZyYMjWVH9H3y0HoCvJQ1QjkEV0kkruY0FzMOXhbElKNaSntjO1L+ExuLQgZy7j8paCleC+J3M1el5pTu5b4Qdc0vcqybkKq3slGARiO6W0Ng9iDkNrzDx0V6a50qV6xYu6QCyIBpJTbrtw10PD5oZ3WIJNc8f9jCgrPrSNQPiC5CC1caYYwLLPMV7hkpNoNKAyFFAVL58l54zlzXYTiloSzSslL1hAcUES7D1LyxQids56ink/l1grKs2npgd2Qx5UlQHBo9S76utq/W0unOzbwJgD27wb/aB/gBKZVx7n6P80HszaiqQsuw9+7YaQ03PYGhMgSQHGxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEI564vw5/zPm50At7cNk26Hrh/9B0lrfhkrt8IIIX8=;
 b=siKYB46rLbbeGRCuMyv2kOWdTRZOqo63L4+dVgr73N2V+O9Vo7soPE3wqvZDhAKSTv7KOCqrOgJ17xuBPo/FmhO/JO2PJMCShCpO3A9ZTmhR6a903mm9LjIpxtr41xjQ0IABK49Ti7d9rSXWqBLy9LuACUyIgWbB7Dxzjcy9SEzjMtWJjW4Gjj+F6F4lL4pYWfTYhY+bGX2+Ah95L3BkYPQNS22E3UUumPeon5KtdnFne1pxS2JvS6xEWBb4t0nRnbmcKcS/NS8tCyy6xLNVvu3XOFtbJL4t+qcgycBTnJcxj8nuje3Y7sQZFFItoRO59bowR9MdNisPz6ow/5nJFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:46:10 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:46:10 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 10/13] drm: nova: Expose a render node
Date: Wed,  9 Sep 2026 16:45:03 +1000
Message-ID: <20260909064506.910162-11-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0024.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::14) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d57fef-887e-45af-105f-08df0e3e0855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c2/tQ1iOBr2kZRZ3tMjRx7kg9pJvZJt9B9PKhSEixJ16/eEE8+CnKjrXoF+5q9Cc2eu/rgDGuSKTT56YQEmH7ESexenyn8Gq4qSxn+jTopjw8o254dccx2Gpf/dF3tjqBcG5O4hfmQx0d2QCE5vsnQvMI1xtIaRdt0W+m1MBa9TMvHjlvPm/cIK2rU6bwOtn2v2SJLS0Wl5j5R4cO0WOFszYt4ImXQrn0a1gnEUP05AXY+2F4Cy6BtG38wwOH/zgnnyl8PwRSxO3qfOuhUPsDGufFav/DHsezKjAMWIuKb8XkBs4D40ZRtgHcvXB6valbgX1Z0BOTFsfGefj/j24lLjy0QhWrzsBvfpKmKJIq8ympZhkScCzCjg7oZ5ecDwFV48oYoSpYpRktYCZVbmR2xgFg0UWNI6pDcZx3U17te6u92+4IEK+8NNikK5DqxMwM07NFueriSz2sYOU5+gz80TtsmkN0jFjXxaEDICIyQnK4dlbNCmuCSsPEGPu+u/tbgFfdsj3RT/T09lU2RjsaRN2F7ZoLeIfEOVLKsa6FRZ8JDeiB21LAsJrVb0j60IO3TKSfxBMFMWMduTOr1WPiGjgvH60oZaW9GxH8NFRf3sRL4Rnozg4/DiJYd/weEIf8eK6KqS71jX/Qpqrc3nWwIPaZk+XRsqwENuPD6dI5ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(10063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3G4rniqFKTUGmLnonZUnALe158kECozIVGq0bte1uEeW+DXKtgotPALRdKqK?=
 =?us-ascii?Q?PG4CWKmxV/KzvvpFv2XtLu5Svov0sVkC/t6Ad0KtSJWHObQ7noCv0eLlLEXw?=
 =?us-ascii?Q?rCMRXdMCP3LzO/rnU28zm1UfwFoRSlta7xhXpzvn3EkkbUoePdRrWaB5em7Q?=
 =?us-ascii?Q?ziFxSE3SJ1ORXwOTRvKuxsMk7oAlcQR7d647xAraXQ8vFqvpLn16iAaDkOy3?=
 =?us-ascii?Q?bqzqJ07cB1VjEF+7RXKwCL+4dcxkp7juHqOkEg82507gp/w7TORnpl1dW21E?=
 =?us-ascii?Q?6OsUPBYEvP4Cuc8xGgJlYIWRrylIU/ccooTFNEGamGiaOFfIvmOMulGFC7gJ?=
 =?us-ascii?Q?eunXByWMbomJIPY94x51vEvQs0BQAVv6vzeUbByBnyCsIgNnlEJ/vzhvsahZ?=
 =?us-ascii?Q?EZZqFy9WlrnEcS8zZdVtBQj43asZYA0BsPr1ta+gJ24iZAob6xMokFum+Qrn?=
 =?us-ascii?Q?nH2DFOIY1gqg1StqET/i68u9vpEkVZKNGdlWiSUPtmXE5qnUfw0HFyOiQzfL?=
 =?us-ascii?Q?We1gWPBhNsbiA8d4o2l1jbQ2Q7H6CHqB8SdIO8JkVoi8xUvk+TvRqrynslDg?=
 =?us-ascii?Q?DfZysEmyp9JK74VwWsw4iWc6DRsU+32lUN1OjZvg7xwDD99l7OOU5n4Ylhth?=
 =?us-ascii?Q?/qZ9ddNdlt7gWhFGuaa/UCkOjbYmiJkKHbDdZn8tCdaHaUlvhFnYfkzYa4ls?=
 =?us-ascii?Q?LEFIbmGpNJsYhRMbWCtaUfFuX9bBO04YPMzA5JjIln4hWT0gWgnfaU1Su7e8?=
 =?us-ascii?Q?+09OKuZ+lzCIsv7QGwuRTOAEVxYzD1eqHSzgQBWa/0otXed2uDjfkAJwP1VX?=
 =?us-ascii?Q?WlnCj8+gqnuQzoESpj2ydBf6utEss/z7IZnX2Q+m6aRtAcn7v/r3pzd9byXF?=
 =?us-ascii?Q?KmXvg3dUphH1mzU7/wRwT19dF3d52t8kvuly/GtXwxWnqDxFYLm/RT8nqRnY?=
 =?us-ascii?Q?7X3e8X3GcZvjEd3AxKiY1qQguOOISu3h8tqpYo59+bU5eygRZGhFnenuJOAI?=
 =?us-ascii?Q?aHzAKM27AL5H94EI+/igxWxAJ34oXe9QwQqgtbbHm5pr1JzJQCQ/XxL8zJO0?=
 =?us-ascii?Q?QGEDJo/aPaI5Hzw+6qqeHN6kb1UFwW1FVF7ARXKW7vqIVsiVas1SYhcslrsD?=
 =?us-ascii?Q?1tlkJLqvH0PGZe1R8OhsVmHoJ4zfjoRDdj7HACvynn7tsxbxuHjGPvlKUFZy?=
 =?us-ascii?Q?8dMpHuTWJ5ZqekNEInPvs9o2HuUmQJvDxwsrIUZMrEEkkN/46vpa8IjvY/86?=
 =?us-ascii?Q?OlDDyh1UbgdzMtZW39Md7NL866KIVw9QqerAN6kpPGQnUAqm0I+nvE0JTsqy?=
 =?us-ascii?Q?GwkxIGqTieWbqQxgQzoJPsMT3AoBGdUjXkxvpnmx+ByNXVFpo5zSE1/q6kem?=
 =?us-ascii?Q?Gty0R6vqaD/4Yujl9DwhNtonBbOwhkstM8E81GU/h3xwDCtaXhrYBLQDw6I3?=
 =?us-ascii?Q?fnWZBmgNo3/yS6KxNmKnORi4c7iqkbSEUK2ShkaaWDru1yMzp0AIbXSAArvA?=
 =?us-ascii?Q?aMgQ/2PpTWltp3Vpfa5XTELc8e2XhxuGBQ/J5fhpt+BDfdG5R15qrnYeH/vT?=
 =?us-ascii?Q?H6Eo5UBEeJk+T3N74yRAhiNDe4qM7rCnWCOo8btDwxyb62drzB4Q/4eDqc0E?=
 =?us-ascii?Q?EepSrUoCTmm4adWeXSRgwRY1W5bBswcnZtHMa248lReVPBxDENiFMRMRJG/x?=
 =?us-ascii?Q?EfrEvUyl8wPKxoEpG/YLpn2azaNohUeomWf8iu5nW/ptsfUkcO+c5bJUq3My?=
 =?us-ascii?Q?3OQDvUQubQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d57fef-887e-45af-105f-08df0e3e0855
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:46:10.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U97WXavX5VIUH/1MC6EYIGtDemYAarK6NGZtjvdIWfW13aSlNlrhnP8HTQPLQI4N32nb2pTmJXTCAWSA16ZMGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

nova-drm currently only exposes a primary node even though all of its
ioctls are already marked DRM_RENDER_ALLOW. Set the DRIVER_RENDER
feature so that a render node (/dev/dri/renderDXX) is created as well.

This is required to allow render and compute clients to interact with
nova-drm.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - New for v3.
---
 drivers/gpu/drm/nova/driver.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 0acdd2eb45ca..46e13fe795eb 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -92,6 +92,7 @@ impl drm::Driver for NovaDriver {
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
+    const FEAT_RENDER: bool = true;
 
     kernel::declare_drm_ioctls! {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
-- 
2.54.0

