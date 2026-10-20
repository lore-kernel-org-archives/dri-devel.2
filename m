Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B3606A334
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j7g/K/Lu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD2810EB7D;
	Tue, 20 Oct 2026 10:08:45 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1EE10EB7D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJBh5meSTpjTnxe4MxO7p1YYBZk9fip3+Gfqh1PUfBXhWGkE2mgG3iO5bo6u72Rga507eyVw6kXxYSrHH9ws91QQyViiglzSTJ0DIK5A9HMAisUHqvnzLDTr92Z1npN7G1zGVE/QUCFCTIzI2mYTJb/5DCAkS3pXjKl2QIz1P9bGdbhF67T1hibEKk5UbQL9Pus6zJbIQbAnwLoo1kDo1sikkwco02NnARVOGm882pPY9QmWejAeCRmS43LVkqPvjpQ+A8IeRoUey/J0b8Oz3FkNKTJjYKlJNvgrJ9m++xqi2IocrUSFjV9DCuONpS3LrnQGtpqifDJWi04+q27CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZExl7wrM208udxPVTfeoFY7ZvvTPJIRs9B2JEqWsAM=;
 b=qlVemTqo/7hl3EfZgijaL6QHtP0hCi6co/U2nmvd4JrrXDQXojP7zO/kMvR9G8uHHtnMZ0VG8kE0fLqhRs0y0m//kYA4GqzBZ6k6tlrJKSmhuXvUJCEi7DRNQJviAHfYRHhMUZd43l1QfR/du2dRoiWl1JHsnaILWktF7n46rZWLhURqZoo/5tGf98BHNkVsddr0hFP+d8oBSAX1NJuEus8PkJNrxwyrIJUfHNCSrympNCLSkxM0ufMpmShc7j5qPHEt5MfP9mDzUP27hODH6KH3OiUZ0DZ+Lzz9edg3U++n007WeEMrsajPDeKGSk7lvs5J4Ameg0TVj/lHApCHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZExl7wrM208udxPVTfeoFY7ZvvTPJIRs9B2JEqWsAM=;
 b=j7g/K/LuD6O5aXUILLkWognqUn1BSAXQgBFkqCJiGMdwGAChwFEgba29Q/we+Fhck2R8uYHtYcPftcyflbMd4r3U1OwM/TGlgR1ajYEcAhNa7241iqtCUlnnytgZGAIzsJ+k8S1olyvbRZFYttcJM42NUZ5QkRPNo3WVHzAYZW+gAtvIUjdD2p+GdzAjgOMH8hcIpNeqgIF4zHRKpiw1vZ7Ji6SRE5EPGHMdbc5sn9E3ca9vXHEuzYBbyzzitS0PiFIF3QigJTaE3081cCAKS7/T1S1NZg4oaji5lfHKmhvffuHHL0KsdUDQObT4A31XL3ml8yq4fDIcJ5DLJEHLig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:31 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:22 +0900
Subject: [PATCH v5 01/14] gpu: nova-core: gsp: cmdq: remove stale comment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-1-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0368.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 677945f6-07c1-421c-51de-08df2e921839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pLpwAVQJ5H9E9653OOz3lFdNoVoVQDGvQ8oYOLWw6gpsLiA2714I72vkTvsaOCucv0ZjucPnZW0moZFOMI1vyptRI8NXeYSpRoecd7O7rOWH0IyoRVuDAurwlx+OzkflkjG2mMoW4zBv0XRR4axAXRPq5SnZ41xIksgmlK5C8WFCfECFd91HJTat2luFK7k/NJHAFaczUU4D35YiQGQhjzkGtOj+kObcRrhfZoOoLJyV/uFzNqjbKvCvO4QHRlPlRCuCGDtQTrmH90DX8imJ7he/h3Oarjxod7DMmYujDfiqqkwmxDDhQSHpP3X1IQvsivvpFBXiCblsTSDNiK4udZybDP6mzFbTofYyEFbWxMzY2S3mD6z/iPvYlPkjD5Z1DvQqo3lMbb6CWW9Wp2DS2HqzaiVSpywCz2Ubu6ImRg+tgNXZBEHBJCWVBrgVSoNiYyCQUaD8fuCR8lwwBdLwYCLA4g9xmreA1PQvokmLSC4COaEb23z5rvigiZSgnkJC8eRGetYol1YkNTrbGo4SgLTQW+JUJteydS/lE0JPRgFeHPZkrHAa2uxmM4y+MdBg8xFXmB7DPiBdcUtDqDPdDHZfttht/zRnlE4DWhUEFw8PXYDz4ZP91eIMv1FKPTUPK54elXldtVt0T0XHo7LA9kk+CI9u6wyYO2b021wDhBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZENGZrT0xORlVjTHdTQ1FrVHZZblgyaXVwN0ZjTjAzZGJVWGtxN1pCSDBx?=
 =?utf-8?B?U2g3SkZGQ3V3aFlLcnJWdDJ2MlloSzhmTHg5ek5hNU0xN25hR3VicUxjTW5o?=
 =?utf-8?B?NG1LQmhHc1l2K0xuclBxdGlNVHZEWnMxZ3VBQnh4Vm50UDExVUQ2eEF4cEcx?=
 =?utf-8?B?NTJsTzMxUEVpS2c5WUpjcCtoUTlRdzQzS2dobVRFdlRwZFVlM3RJTVpCMkht?=
 =?utf-8?B?aXh4WXZ2ZUxPOWFNWnB5cjdoTm0vWUI3UG0zZlF2L1hyb3Q3SlVjVFZtajh3?=
 =?utf-8?B?ck9sckoyOEEzNjc5Q3EzWml6ZEVDODYwdmtzYjlzdUFzYVFEMzVZcngzd0hT?=
 =?utf-8?B?dWQxbjI0bmNKUEdpQzg5dnU4MCtjb1QycEFTWGJMOGJOV0RUcmwwVHNOYXRB?=
 =?utf-8?B?RkZRNVBsVEtBZFdWMGtKQmlMTm1SUklhUlg1dmhuWmhGK1BaVElUUjMyTmdw?=
 =?utf-8?B?N3pDUWtHaG1QS3ptVk9ZU1QzaHhjck9JMzNtOE1mZTdNT1JQNFJlRTdjZjNL?=
 =?utf-8?B?U3VzcjdFUXQ3ZTdyVFhGa3lySEtMVXRSSTIyVTM3QWdwNTE1Wnd2a3NtbzJ4?=
 =?utf-8?B?WTl1QWxYblNpOWcxY01WbkhrZGtJRnlucGJtay9rSlpPZmp0Z0RMNThsemdW?=
 =?utf-8?B?WTMrSGszM0dUVjBLbUNZdk9IbUZDdWF6YTdCcnRlTXBaYjRZWkJSaERkMmM2?=
 =?utf-8?B?MEFLZWZadWxpMVpxWWRnYkZnTE14eEJnd1d4RndkRi81eXl5ZDhLNmFtd2dL?=
 =?utf-8?B?ZGw2RXlaZkZTUUpVNGJQc01vbzF2VVRmQ0FjSUdhRkZ3clZraWtBYzNQMTlp?=
 =?utf-8?B?Yk8waS80S1lqaDdXakJJUkx3d3V1L0Q4NnZGUHhIak9XdWh1bVBIWlUvdHpN?=
 =?utf-8?B?dVJyUzBNeU1tY1NmeVpxQm15ZTVuWGN3QUFEc01VQjNyVkV0V1EzYlhySEhy?=
 =?utf-8?B?NUxEUDFSTWo5eE96bG5Eb0J4eDVCay9oUDFCQ0xTYXdvYXJpWUt1WkJIejlN?=
 =?utf-8?B?ZXowOTFIVHgybGU2NlNjYnNqczFPdUc3NysxQ3hUdHpDcDFrSUNMV2lmUmEw?=
 =?utf-8?B?RzJXRnpQRU5sRHltYzArVEZLOTdHdTVkU1ZUME9kQzBmbVVQNzJsUXZFWnpL?=
 =?utf-8?B?VktaZzV6cE9yZkdDU3dXZXQ1VGdyckxERS8xV00veHN6dDJVNm04eVpXU2d4?=
 =?utf-8?B?bGtHdzdiUHBtU2IwZ09lN2FLTU5aUFpLYmpldnBSRWY4MCtyc3lMa3ZUZ1B2?=
 =?utf-8?B?YVhmeUZhTExtWWtBV25CR0JWTHIzQ09YdzkxQjdGcW9ZZjBKMExPdmFZdmk5?=
 =?utf-8?B?eGkzTjNNVVNlTlRSaFBzOXUzN1NlbGVtMDNza2w3NUsxc2ZGUEFpalRsWEZi?=
 =?utf-8?B?d29iRGwrV0ZMaGZMeDExdTZiMWRtYW1iZEh4dDN2NHRaZEJrSkZ2UlVjWXBW?=
 =?utf-8?B?WlpGaW1zWUFsL3greFZJSUtpendHY2ltZ1dNUS94bFVzOXZpOGRSNXlYeisv?=
 =?utf-8?B?UG9HUmdwcUZMaHpZNzQyTEVod1B1Q2hxRHl6REcra21lZHNUVGFXL3JxeHBR?=
 =?utf-8?B?b0UvM3JiZk9xMndoMUI5d1JlaDQrK3JyN3hMdlhaYTc5MDRiRm00cDBBdUJI?=
 =?utf-8?B?UjN2MWw0ZGpoRExML1BXNTFxVnYrejY5RG5LOC92TjlrcGhPbGYwZk04blk4?=
 =?utf-8?B?bi9PaWY2VnVQY01uOUdKSXhyWWFjTERIK1U3ajVMamxnTlhxcUJrcjZ0dC9x?=
 =?utf-8?B?MThlY0hOQXJCdmhvOUVyVjBrQnBSQ0FGSXV3Z29USUVRTncrZXRFNEx3c0ho?=
 =?utf-8?B?VktybjdiT3V5VStUUGxhVFBKTnU0SFRnRmcybVpkY1cwemt3R2xkd21RZFpZ?=
 =?utf-8?B?eHBpdmVVeGxZUmJiN0J3QmtqcStibzh4dFhBbGFheW83dHh3Z0hQbXd3Y29X?=
 =?utf-8?B?RjNqdWF6ek5HNnhEVUFUTVZ5WWMrSE8ybklkK1F4anVRR2NFdFBhRTIwclBN?=
 =?utf-8?B?WDFmOWlOc3lOVDcwVzUzeE91TkNqdHNCWHJrcjdodTRyNlZYWHZWVGJ3ZVpz?=
 =?utf-8?B?Q1RLSVZKWkN3WndOMCthYjNDall3TXFPeDR1OW4xQmdBWkRKMjZVK211c3FT?=
 =?utf-8?B?eEVsK2lIRDVzMWc0b0x0LzNrTElxcWpSSFpodGtRbWhEZzVlSE9DMUVNSEpl?=
 =?utf-8?B?SFpNWnQ1WnFUbk1WVS9QYUp6Y21SWDJyWkRyTmNLaTFwVTdab1hJdloxVlZO?=
 =?utf-8?B?c2FQbU5uZ3BuODBwVkc2S0J5cXNuSE9zQysyWlBTSlpHR3k3Ly9IYjE4RE1h?=
 =?utf-8?B?SEtUTk45VlJJUk81bVEwbGxVellmNEM2eGJjeHhyL2tyd0ZZZXRKeVMzVDZa?=
 =?utf-8?Q?ec6xlxPehRGAU6Qa9Iv5pvWsmkXh0zEVxL7FA5PKfiTsc?=
X-MS-Exchange-AntiSpam-MessageData-1: NhkthBvB+dZoww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677945f6-07c1-421c-51de-08df2e921839
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:31.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8D4qXo4jP+M4PCXMfkEU+N8DYD077SxOgCqhIkYVnKslFINte2L4SHwdaNZ0EGKAxXso1Yf1iBEgd6jNgbHRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The message constructor is no longer run by `wait_for_msg`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1b2f346a237f..accfc1d20d28 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -777,8 +777,6 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
     /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
     ///   message queue.
-    ///
-    /// Error codes returned by the message constructor are propagated as-is.
     fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(

-- 
2.56.0

