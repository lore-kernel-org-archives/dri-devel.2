Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E93C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B062110E894;
	Mon, 10 Aug 2026 13:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nxuu18EG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C306A10E894
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBMVhWMRlRLa2ZzLrKJKQ62CTBHZmYPne/sWpUOva6lVvKzVOM7UJ/cYiaraktdLpnI1q9TkckoGtZUzC52l7MSZk7XLwP5f44P6rhvamYmFAE56k6wRF5Ddzz9UiI6ewno8UKWi+LKgCVq2n59rxcV0W4hpC+miHu/+oD6DtaX06lZ2sXExDtBmUNSsCVQeazNzfFi3aeiO93YZnDuZV7ANla8YoUEXZUJrIWy56MLPZi+KJmKLjMIf+RxRPU/LJR3hz2+Al5yH/68SLilG3OXLKDJwuy6j79KGjfHTLvC8hWlxsfACUkllRmmd9qQZjFRPoawVfQcmUjg7f2R29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHvlATAeu0qkPCZ5AX8NUgZP6iYc8IERZT3DSyy1WpE=;
 b=M5V+lU7HXpQJQ6rqT3OiDsDn/GrESxirpMSJpnnoB7RGauu/81Lpra1xJBGQoPPhftJD7BJhcNr5WxkzWILBqmBN3hRzX9Ye/svNNox81vZhoUbI96QnZVnExaPOfa6SIGeztUHbQN54WCauVbH5kIXd09gwcIP2QwqbvPh9GyILX9A4XZwUxzC7As3nlWl76nUuAfTloXx2ONjsHJWTSwtuBtp3AcfTBB7tK62A7VyH0YgsoDR/GuuGgPz1WcgNi9MgPgtT0MVzXNViBP70/ETz9VQGHXuEkY77EZBonoOW9MV/ttuACSF40bEIPObC7HSfwtM/vLZoSGliYWTSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHvlATAeu0qkPCZ5AX8NUgZP6iYc8IERZT3DSyy1WpE=;
 b=Nxuu18EGP6bSxULVQdvp1UYdKEX3oKGB8+QWiOvPRqvukAi074/Ct5W8KkYoia+1SKZ3zLU+XaTk+2GGzyBdAyTUv9qZphmXlQawi7CVW4pa+nqKv/TTDubgiFs3kZoUrhXoPmq2zoi8VPx+r7Swii5y7vxXq3z5dWZ6VmL9m2/9ya22OZbE/saOzAgrTbb9lgD6vYa3QfIQV50OPJB1gEZdwRYRwnZx6HIn525G0vBB+xyhSpF7bOvMkr48IlxSfL5Lve03+uEljLBbPtSrgEvyE44qVXVxYe5U62ZuZpVVw6c5TAEOruEMbQoz5agOPsGNwNVJrXol0B0XtDqm8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:19 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:19 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:32 +0900
Subject: [PATCH v2 10/12] gpu: nova-core: mm: Add GpuMm centralized memory
 manager
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-10-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b0316c-4b7f-4347-a499-08def6e76f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: H3d0ksIq+7LLyvhT5hoWw4sFe1xeYDN9QqQ0euC67E/86cI0mUE6RTDI5PNJzb6uiHpZ8uv9eZn8cdWJz7BsK8AMxSihys6kNVU3xW1nhi8WuJFRrjG9vQv9nLSkfZXA/7VmLuQhgBn3zwKXcaCOwU68g5gpXjSiXLfLXB7MRyluHytAH5sETqInYrmNp6f72fh0ccd4+P/BtQLxmRbrcEl7I3Gn7GSbstrnsdb3OSvgkFSFXpoW0hM6uEyEkxJol9BvLB5V5++xs8t+qmS9RRN5jDeRqHLVz4PExr+NxzqBJa/7iO1ZzU5qox8sy3K+bEh9DWrumqn+9UiXEB+iDKw9/fSDeb3iUapHxl8JtJogSsfMEQH4q3t9s+KI1U94xpQM35a+N/V8PNIq0bCTZIC9Zd5IuKhY1yfFzN8hLrAHNogESN+wUA7Dr0iszLmdRCcCMiyFyTM7ksgZCy9UBnHoTiLCn2oXnlM2b9n2V/yKFdoxIys6frBF8jmWUp4Ejq9+QXqq7wIqKRm3CpSE/Yrh3a2KIVPhTRAn4ylccWQpumyrh2EwwvBUu97eztDtAhZfHz20jkDq0HyR/JCy3boTXEKkI21K+OcANgprz6X9+a/Uy1zZDgnKFt9Pk5bpkq2xUGozwtqtudERiGirgZf5OwafbT+Zgjt4w6IOKQIpz9IFOZkkr5h5LS13ovl3fNXHse1XDRKwu6eCWNMPBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tmTjNwMUFLYjZZcXBxTWMzY2RweWhNRlhNMlJYcWdsRDltK2hvSTJlK015?=
 =?utf-8?B?K3Q5VjY1dGpCcFZRQWthWWZSZnVNSmtUYnJCVVczV3c3K2EwbTIvNlhPVm5K?=
 =?utf-8?B?SS9wa3N2KzdiM0pNb0JwLzVrcXBycUVLV1pLK1ljeG1CUksvdzFSQ3lZbnhv?=
 =?utf-8?B?UFZGMDFmNWNzc2tQY0FMeDVycmtNWTR0MEhCQ0dtTTdzbFZ3cnpvUWdSMW8r?=
 =?utf-8?B?aFYyQXZTK2tsM2ZoSkRmOVJ6b3N3bng0bUdUaHp3Ui80VHhNZ2JDRm1OUUpK?=
 =?utf-8?B?RDJTZ3VaNzhDUXZIV0VrejdNRnpIbS9IL1ZEVEYwelk0N2FHNlQ3b05BY01u?=
 =?utf-8?B?VG4xQnJzNlN0SDF6MDB1b1dMNDVwc0V2QzEvb1BPZzRYaEhFWlJRdVM3eFRZ?=
 =?utf-8?B?SzdJRDR5cDlQUGV3SENSakF5R0MxQ3pBZVMyTTRpT1VBWHo4cmVwUE5OOFhT?=
 =?utf-8?B?aWdnbzFJeC9xWHNadnFFMFNKZVVFaU9ZNlNhN29aQUZmcTFVekh5TFN1WlFk?=
 =?utf-8?B?ZVRjRE5oNkFKVG5JRXg0N0k0K252ZW1Oa3pLQU83MmV1VnJ0MFo4RlhNT3FQ?=
 =?utf-8?B?c3N2QURycTFjRnB3dUM3UTEvaWRGaWt6SW9xWTJQTnBFU3ZtKzF5YXh6Q3FZ?=
 =?utf-8?B?ZldpbCtxQ25QV2JUQlNLdGZFaWg5dFBHZ0ZvdVQvU09BWnRmaWJzR2hHRWJi?=
 =?utf-8?B?RWozK2xaVncvMktTYWVvdmhYdWRUTUo3TytBWFNJWHRFVjRXU0VUWjhNNnd4?=
 =?utf-8?B?MEdGSkFpRExlQ3RQc0ZuMFBPa2FrUjk1S1Zob3hFU21DL0VRRjJIeHIxMmg2?=
 =?utf-8?B?eUJUT0oxbTBGcFluK1BXa1ViYmlvSkF6Vm5uV1ZPRFRRYkpST3ZiTFhWNnlS?=
 =?utf-8?B?WS9MUXQzajFqc0Z3djVtVUluSWpPMWdKMzJsT1NUV3N6bmxUMVNHSTR3cE5O?=
 =?utf-8?B?allIRGpMSkptUkVEVHhjU2RjeThnYm53YmFOMWFPcTBxVE81dFpGQmRmODRO?=
 =?utf-8?B?R1dodE1SQ295b1lZeUFUMmVuTDFkNTNQTjNZU3NCbkpxU2Z5OWhpYnUveko2?=
 =?utf-8?B?TDRKSUlzUW5TNUtjT3VON3RxdjRzY1dIeWtNUGw4REJISXU2bmU2eEhGaEs1?=
 =?utf-8?B?b1RvbmNkc1lTMDRTVzNUMXk0WCswS2h1SmhrZXN0SHJPZmtJM2k2cGRnOTJa?=
 =?utf-8?B?KzBrS3gxbEk5VkExRFo1UHJTeFlNUldYV043d1FRaDBubzJtalA2WVNMS21r?=
 =?utf-8?B?TFFzazVXalo0NEorS3BqakhiQldGK1l2cDEzY2xEdUdOSGVFalVpb29xbWp2?=
 =?utf-8?B?UVh5Qld5bmZtd2U1ZDdpeTBtYUZyajNxdEwvbzZnLzE5dXNvZ1dhS3QxMktB?=
 =?utf-8?B?RUN1VHpWbXhnL2c0WC9LWTVaQU03eDRJOXZOMXNsejBUY2xVOGJhUFNoczdr?=
 =?utf-8?B?RGhXOFlWckhmZjA5cFZ2aVpyTGU2cUt6OGtYYVNHZW83aXZNbWpXSmJ1azBL?=
 =?utf-8?B?cVJabW4xVzE0TnZ6Ym1aeVdRN2J5UWxVTjRkNzBzZEcwcW9kWW5TQVRuV3pE?=
 =?utf-8?B?TlJJN05JQ0szWlJ5NEVCb3Y4K1dpVUJSRkF5OVZJb09RTnlQT3BxZ2I4cHlR?=
 =?utf-8?B?bm4vaWxETmdFelFJY3JtaVdlc0wvYVMyTDFaUG1US2dMcVZxdHoxZldUeWhU?=
 =?utf-8?B?aGRQN3BSVlE3Wkdqb2lkTzJHUFhIUURBSTNVcTFVRk1wbGUzWGJrSVFSMUdq?=
 =?utf-8?B?aSs1SlV4dCtUYTV5eXMydldoVklCeDVUTVE5cStrWFJab2RBVDI5eVowYXhk?=
 =?utf-8?B?ZkVOV2pFSFdyM25hRE1iMDhBRXBId2x5VVlPUVJkY1d2ODZwaXRYMll5SlJs?=
 =?utf-8?B?c3dKd0tEYUpBQW5ZUEgwWHIwNmVPYkp2SnFZTXBiTTJnK0xvNVVpcTZXRkkw?=
 =?utf-8?B?ZkNyS1M4TjRsdWhvVDB2Z2tZRng4cGYvU3Jza0h0bkhqU0c1Z25sMEF6VDNO?=
 =?utf-8?B?VlYvZ2FOeVZQdEF3bGE3YjVXQWFrdHphckRwU3BnVU45djE1WUVZZjZHSmhr?=
 =?utf-8?B?ZFNxZkltNXgvMVJkZ1JXODZvTVZ0U1Iyb3gzN09zVnAxZnNWTGliRDNFZlBL?=
 =?utf-8?B?QzVTZlFFN0xSYUpJMHdzdFhlUkU3cUxTb1UwZDVVZVRNbXNVTVNPaTRHUWpT?=
 =?utf-8?B?NGJvRzFjbndBcUsrUE04RWpZNHBqVUxKbU54MHZMRkc2bUlRZkNtWHVaWjJl?=
 =?utf-8?B?bXlWU1VHbTBabU15TkpDL2F0UVdVbEdDZVRFZCtEUHFMYWpYNkJUaCszMzVM?=
 =?utf-8?B?UDVHdWlkbXJ4MjZrN2Y1Q0JPeklIVTJlZmFNdjIwN1d4M3YvMnE1aVQzWXJR?=
 =?utf-8?Q?yZAP2q6FjH9NVtmV0MUEE6HcxVCX9xFtTQ0wFmAQGY86X?=
X-MS-Exchange-AntiSpam-MessageData-1: xoSViyz98W9lXQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b0316c-4b7f-4347-a499-08def6e76f22
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:19.7438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBwrMdW18faHTQZaq/zkDyevrEgg2k5QQAGO+CSLwgMfxRxL+WRmwqJ6OsYv7iVZUevP31ydPtc3z3gJhOnBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Introduce GpuMm as the centralized GPU memory manager. At this point in
the series, GpuMm only owns the PRAMIN window for direct VRAM access;
the buddy allocator and TLB manager are added later when those backing
types become available.

This provides a clean ownership model where GpuMm provides accessor
methods for its components that can be used for memory management
operations, and lets follow-on patches (such as the PRAMIN aperture
self-tests) reference `pramin_mut()` cleanly.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: squash the total VRAM end patch, drop its dev_info print]
[ecourtney: take the maximum FB limit before adding one, fail with EINVAL]
[ecourtney: rebase for the Bar0 lifetime and ownership changes, drop Arcs]
[ecourtney: source the chipset through gsp_resources]
[ecourtney: build the VRAM region in new(), pramin() becomes pramin_mut()]
[ecourtney: declare mm before gsp_resources, doc wording cleanups]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 18 +++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    |  4 ++++
 drivers/gpu/nova-core/gsp/fw/commands.rs |  5 +++++
 drivers/gpu/nova-core/mm.rs              | 35 ++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 42a4cd7971fa..e29e07488e78 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -29,6 +29,10 @@
         Gsp,
         GspBootContext, //
     },
+    mm::{
+        GpuMm,
+        VramAddress, //
+    },
     regs,
     vgpu::VgpuManager, //
 };
@@ -283,6 +287,11 @@ pub(crate) struct Gpu<'gpu> {
     spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
+    /// GPU memory manager owning memory management resources.
+    ///
+    /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
+    /// the GSP is still operational.
+    mm: GpuMm<'gpu>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -410,7 +419,14 @@ pub(crate) fn new(
                 }
 
                 info
-            }
+            },
+
+            // Create GPU memory manager owning memory management resources.
+            mm: GpuMm::new(
+                bar,
+                gsp_resources.spec.chipset,
+                VramAddress::from_raw(gsp_static_info.total_fb_end),
+            )?,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index ffc25fd8c47b..eea1c9ed4684 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -216,6 +216,8 @@ pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
+    /// Exclusive end of the FB physical address space.
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -231,10 +233,12 @@ fn read(
         for region in msg.usable_fb_regions() {
             usable_fb_regions.push(region, GFP_KERNEL)?;
         }
+        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_regions,
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..6e85442a4b13 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -165,6 +165,11 @@ pub(crate) fn usable_fb_regions(&self) -> impl Iterator<Item = Range<u64>> + '_
             }
         })
     }
+
+    /// Computes the exclusive end of the FB physical address space.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        self.fb_regions().map(|reg| reg.limit).max()?.checked_add(1)
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index ef5b1cad56c3..58dce211a337 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,10 +19,45 @@
     },
 };
 
+use crate::{
+    driver::Bar0,
+    gpu::Chipset, //
+};
+
 mod hal;
 mod pramin;
 mod regs;
 
+/// GPU Memory Manager - owns all core MM components.
+///
+/// Provides centralized ownership of memory management resources:
+/// - [`pramin::Pramin`] for direct VRAM access.
+pub(crate) struct GpuMm<'gpu> {
+    pramin: pramin::Pramin<'gpu>,
+}
+
+impl<'gpu> GpuMm<'gpu> {
+    /// Creates the GPU memory manager.
+    pub(crate) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        total_fb_end: VramAddress,
+    ) -> Result<Self> {
+        // PRAMIN covers all physical VRAM (including GSP-reserved areas
+        // above the usable region, e.g. the BAR1 page directory).
+        let vram_region = VramAddress::ZERO..total_fb_end;
+
+        Ok(Self {
+            pramin: pramin::Pramin::new(bar, chipset, vram_region)?,
+        })
+    }
+
+    /// Access the [`pramin::Pramin`].
+    fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
+        &mut self.pramin
+    }
+}
+
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
 #[repr(transparent)]

-- 
2.55.0

