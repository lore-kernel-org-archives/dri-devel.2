Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8505FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049EE10E486;
	Sat, 25 Apr 2026 21:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MGucsS1j";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4238610E486
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc9Ww4eIz8woGCps3I3ffiWKytlh6c3zyAho4/ZJrQ0WmTFkIAP6Efu5zNW0Z4N9fqrsv+2zXuctcwnPRfk0WQHLvI1KJ1jL4VxXDA2s/Z3W25WFiFaQL1MHlx4T9iOAo9A4FmL3NgAzjyEkFpK/0rW90b+dJS8y1jY/Q+2MNLinO7cyxDrgb2+SHOoDgakLWfvSmcyMtUEcETUl3gcomaCuwsjxWAEJ0d3sftC1qA7ExGukETn/CC36AW8cP8rii5XM+Yw4CfIvwu2EbmySva4PzlQjjg0YluFw5klMDA8gDWaxZsrgrgz3idQodDzJJ8puKweIkhHoc90Wz6U4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRbN/LIzygbNoI2YU6Nnqe5pEZ0N5ICANNj34grsCUE=;
 b=OPTP0Lw4mf0ajsNB5PUMv2OsWk9ymHu6Sqr3lb8fqbagXtRqYUF+0TOesy7gB3HRHa8GSTqAKhLCCGkHb2lXFQsaxpXU3WMWMMfNgOKJTyPvR08fmel/oxYoXsVB7PhkN2pjSQVxJqRzL6eJNrPdWC6W0rNWbBTBPMEe5ZCIQhWhTdQiDr+NUhzSHLEA9BnEy/xveLWfRNC5rLjgKO96/nK2nn44cVE+gxJqVdNdPdrOMwzNBMgjzhFT9u8utp26EXu+uMznfGDxqyAAxP1yMhSUg10mNJU012/eoVqZPqo3VPYkKsVigiI42GkCVO7JBc4EXZl4Xnppucr5n8HvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRbN/LIzygbNoI2YU6Nnqe5pEZ0N5ICANNj34grsCUE=;
 b=MGucsS1jL72bbf5MXaWvAA20PCLAzVw1CnnvLgPzcTN9TqZTLOv06gzXnQs137WIvDrKABq4ugb2+hwZWx4ranqZGrAp/w3Xl1Weem1RABgANPr/xuR0as2VRaMOWoqP2VNaocf5xBYtCUaUtg3nMIsfRe7nbc1QH5fV6v995EIh+3L0uTl9TA2wvZ3gBUIMw4zqqVIzSZD7lLpaEXpfcP9nUSO0A844y/MDlQXPqpRXLdWfyj4s3yusbJAzqB3+Rqx54J7XNOwP/8r9IYEUi/AGvPilC9FWZedKi7uj/4IkbUDZOjTzAKQBqUQgq359yn16F5Qly1gi+Ge1x9c5YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:15 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:15 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 03/22] gpu: nova-core: gsp: Expose total physical VRAM end
 from FB region info
Date: Sat, 25 Apr 2026 17:14:35 -0400
Message-Id: <20260425211454.174696-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c898bc9-53b7-4c60-8422-08dea30fbe9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L1PdUQiv7rQiwpmqYAxQV/YaVR9/9lmsQO4XxN+LstVAZtvTLgmabg65RRqJ+9vzvb0EAl/yZSLxlWMcxeXAEAsOHrby9Be93NDsbYL01yl4j3Irn7asl0QJrrI5hXDfRsOJldcxgB3R39L3mtXVlydMx2jh9fpXhG6PYHut3A4N/wi+Yu0qwjkaflkxf9pVCXuThYHYVksZ7pk+pNTzrEdB3q3OQpYll5YKv6HQjT42eMN6lnSF2rKpAMnIWqDS7hDG7MlfgChXvtB51Jlb2vmqt4Y99aFfWqGVwSIlyM+xJfxTELfszGuSvviyfSP1uNsFQwEULI1sQaR1BTmKjJD0NrNNkQBK7+xRqnFvYrJC8Oxbo9RlxyVEju4xlc/56oqe89u4eY+vZ71/RX9EHbcdARmXGIhCxx0gdumak7Wj318X+dpZyO70RpVzy+bHwmijsQfog7M/aR9xXnEh0yKNPuSWOxtJXo4AlXcpfXHoi6hWxiH2dWJBptkzKD9ar/XcZD8CoItVII/f898h/H3F7xK8Ps7IVVv3Q7lkbpTagxnhpraIPhJU9B6wI9ndASGlwQM9/v0r8lI7akHvUnPLC+iU+xvddaWiNHAIHVhiEefXlCBQEp37qabJ2iYCSwoYLEnZi2bQCteNfdFp3AmeSlCzcNBHgPAJeVBDaWu6mqJs0iRMDwL/iU8OZyacjRig9YVKuLKYWEGlOxjYX/VGiZoJDF3RZsppad7HVBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dhftu5fAPspJ7891j+RCYInoEob2e4dexsb8QPFcGgVKBaSQwwaJHsSRZjDw?=
 =?us-ascii?Q?h36gGBu45vasD1ZBlHt7W2GwyF6+NiCG5xmjjXFnaXd34orEU0/Ima26WA4C?=
 =?us-ascii?Q?J4dlXT0VYVGx3v/V4+buXsW6i7iSY3k7Iv6Y5Aujxs+ZrRwCoJoL+4q50+Qh?=
 =?us-ascii?Q?il/1PF9GdwtE+FfsQ5wpUXCR29Om0FyHs8h05pWtc0ICG/bpL+t7jg6eY4/r?=
 =?us-ascii?Q?XGdM0F4B81HplhaFYwgu9UOZS/R0ndCLiEGK4hLRcTOgUB86lC6rSHI3kap+?=
 =?us-ascii?Q?y2FGaNtsp56Egsn3Vv+VCt1H6+hBYz0VbUTXrKPJUTO5MG3kc5/dMlBu2xrC?=
 =?us-ascii?Q?Lm8VULJrQb/M9P65lwKgKw5gLvwo+iGWg+mDaCl2UysCnm31jWRRmEMrxrsM?=
 =?us-ascii?Q?eVN9iVDH+tkP3AFm1WyrtpGJ3dXWt6LpijCfMl6uNg6scVOyAFDPJlv13W3L?=
 =?us-ascii?Q?9AAWs4AEJkqvcrkxbo837OB8oP1jkmPoO8dWufVnBmFtttV1ZLxjrFomUuAJ?=
 =?us-ascii?Q?YOeDK2LOEo3bQZFUMhLIR5bWOVcKc5yd5thkDwsgX9P8oTo1FY1bWk4+Lv40?=
 =?us-ascii?Q?6/lJbMqNNB9PV2A0jBksEZAKozw6jr/nDKG10kOzqHZe0Ko06CNnM0ZsHEvS?=
 =?us-ascii?Q?d2Xfl4665/w/pl2uxB/aQT1VQiQEfmmKkDV9i0wQvNqGCHkyeYUKfAbDVXQt?=
 =?us-ascii?Q?iDQ2r3oXMjfZFNOARurAW9p/BstaX+8C7UbNvIv/8pSO3q7QCX9TZDd/TbKt?=
 =?us-ascii?Q?DvzI+yxYhYvIymPQS0hU2o22NKlXogCqtrC/jUrGx9DaXI5R+RA5KBzggydR?=
 =?us-ascii?Q?lljXzVNiFZizBFuMb/skB/s07JPoqLe+yn11fVTcLV0po/e+7OF0zTgwkV2Y?=
 =?us-ascii?Q?Xi6JVu0KVUhCEzPfp/ikpHKVvI7yU+Y1z/4o10NHGw8mxjmpgd+hPJUu15Il?=
 =?us-ascii?Q?jFEYdyARmCc8nDwZvnWn0I579Plr6chut6aSRYCjZXRi4i67YpdGIyjQsqli?=
 =?us-ascii?Q?M/yMToc5V9cXVh6eYAqJSmxkpvWKWieF+xZpOGlyPo1sStfPNij6uu2tFKxv?=
 =?us-ascii?Q?3vM/fVpiM9A3uihpFn8VTNmKvNoJqCQkbh7iz5TruE4u7E4QWhFapbWZiwah?=
 =?us-ascii?Q?jamNS/MS8zov5nAoqHtlg3xJE7VYAcL1vynfru7hcsJ+ecJRtZhFDdauHhEa?=
 =?us-ascii?Q?f0QPqRi+1SDP5eVnpi3njqwKXWWhw5J8ueY2vPfdcxYlgLtnBhDovY5ThHy/?=
 =?us-ascii?Q?RKtDvAzI425+868IdzBYDXr0ORNyv14j6ers0aYroYj41h4tEqZvodx9cZ6i?=
 =?us-ascii?Q?DINUKOqOoLA68d1u2nmuwL3mhC2M/DzvjZoJSHPsIJht3J8wXc1wpXJTeE0A?=
 =?us-ascii?Q?oO7kM8Agl8ZttEd388DtMkE3exsh/IKSa06mmOtPnjwxJDfFbu/LCaY1bylp?=
 =?us-ascii?Q?TeMkbfGPt4h23T14r3LgwcIA7NVhfQas84iLHjQrbS0DAfxQaK7Ic1sP8gwL?=
 =?us-ascii?Q?p7iXEcLQf/pLQqk62HnRmTKCL9ZbcGhJy4txuPzpZlwXVQZ4qbhbmvtwSgPK?=
 =?us-ascii?Q?l/y07sGGgtLUkrgRDxKwTwbiz7206CZCaog2z2E3WoaB+iRCKRksHSaZv7eK?=
 =?us-ascii?Q?S9yj5yJRgUNCxXOQv3pFzAPytX+okrcl9di3QfS6FEDcHecWTcSLse9ltn8H?=
 =?us-ascii?Q?fi9CdPiv8MNhsVMuSvQr6AKrkgAmQLYjvyjzWjt2IbWAIp/0m1c6dgCDBUu2?=
 =?us-ascii?Q?b9O7MEjXQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c898bc9-53b7-4c60-8422-08dea30fbe9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:15.2150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKSJK0EDHatJTZL+KUQv53r8F7+j0+OkIBu52yMyy5hUfr+vlqDCSJl0acYHzH2KBVjp0xSSgz0FwfPGop+SEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Add `total_fb_end()` to `GspStaticConfigInfo` that computes the
exclusive end address of the highest valid FB region covering both
usable and GSP-reserved areas.

This allows callers to know the full physical VRAM extent, not just
the allocatable portion.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 12 +++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    |  5 +++++
 drivers/gpu/nova-core/gsp/fw/commands.rs |  7 +++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index f2a8915a1ff4..675a0676f032 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -273,7 +273,17 @@ pub(crate) fn new<'a>(
 
             gsp <- Gsp::new(pdev),
 
-            gsp_static_info: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            gsp_static_info: {
+                let info = gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?;
+
+                dev_info!(
+                    pdev.as_ref(),
+                    "Total physical VRAM: {} MiB\n",
+                    info.total_fb_end >> 20
+                );
+
+                info
+            },
 
             bar: devres_bar,
         })
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index d18abd8b5f04..40b4ef72169d 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -196,6 +196,8 @@ pub(crate) struct GetGspStaticInfoReply {
     /// Usable FB (VRAM) region for driver memory allocation.
     #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
+    /// End of VRAM.
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -207,9 +209,12 @@ fn read(
         msg: &Self::Message,
         _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
+        let total_fb_end = msg.total_fb_end().ok_or(ENODEV)?;
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_region: msg.first_usable_fb_region().ok_or(ENODEV)?,
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index a34d29280430..8619f08a689d 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -164,6 +164,13 @@ pub(crate) fn first_usable_fb_region(&self) -> Option<Range<u64>> {
             }
         })
     }
+
+    /// Compute the end of physical VRAM from all FB regions.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        self.fb_regions()
+            .filter_map(|reg| reg.limit.checked_add(1))
+            .max()
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
-- 
2.34.1

