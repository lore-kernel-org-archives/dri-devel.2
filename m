Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C8FCD0C6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91B410E6BE;
	Wed, 18 Mar 2026 07:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hd9GMB7e";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233B10E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTsbPOjHMiqBOoMyhp3J/bVuN1gpU+qzxkX18e7U544ZLPwojjmTN3yjG5HH1joBX0U+SLbnUJHMLwnSQ0rKJcC1T8dguKBFxLRp7MNXjcLJ7MSNRgdQWlv3l/uQo7xaWzcEe1nlnT2/3BXv3Nb0yPdgyAzZt+/HBGM0YdwhoK465sLpvvVeqO9FSXsgnka/s+gvOZU8WCSp5RffELyKUwcCzM4dCGVO4h3r0k7d7qjyvDSBqWzkj/OL9KnjX1GwL/furWOVlpi0xPbzfmyOBeyTSuxAI5wtVZc/KqX1M8zEbJPUXR90hlDij2yvI9poemIzeii4XjKqulufbZrqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzSwQOmvjY4sYtqZtOreKEykQCR1/tb0rDwprvzqNus=;
 b=okWm1YGziNonOox9V5fe8MFhjVwG20d2kpfx9c74SJYrq8oUt0woUQy3KofTqMEyk4X67Xv6skqV0Osf5pCrNqx9MaXv8cMjKq7ZAM2ITphANubhmjILnWxoP9EgS4GfBATp4O6xu1dUU5wD3SNk353OSN5vaO8SF3+YWpBldO0pxvPAZZdzE8w6M2SXYDRCIUFQlPK0UaRfQESTUDYTlFogG1V+iwYlrIBxOfW+PV/xg6ZMN99vaHTL5Znh46lNfdAvxfcF2yMAt4ZEgxrmr1UzY7dIpxHo23/vYFLBAKD1B9+P39aSrkKKQeKN6MYJweZqfgoPrVTwxHl+xKnfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzSwQOmvjY4sYtqZtOreKEykQCR1/tb0rDwprvzqNus=;
 b=hd9GMB7eyjli6QNQuMU1f5hoFL1DGtuQHmtuYwnTfb0AcQ91a1h/dUz90wyMyrCxMg42Qw8hiMCIjcelZqXYObapDWDGzkYFtPDTPWMssWX3D4GQAa7WEK9TnWimgxqyEEbT1+T43XTVlkzUcBcZMoBv3SVGAfBCPLgshFEvpEgpQs/6GW/5OufUmBq1qcRtPatD5ObPf05rhuwhNiWdKkrpGzS+Q9bm/qgtr58h/S/PiWg3W+LS9EnbBJXrhvWzhmyQBjBuOCyvktWtq0euGdQ16gwsvIuOMrN91FO4lxnYZ8QpchjC3NJGemIDYYIVdFm7QMCXPxuwoyPdTAkgZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:13:59 +0900
Subject: [PATCH v2 3/9] gpu: nova-core: gsp: expose GSP-RM internal client
 and subdevice handles
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-3-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: cea5e769-a7d5-4cda-3ddf-08de84be094f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qVStIU6tav7PmdOydTGs19l7FPfns+kzGVEosSXLN9LKRG8S2LqjIkJvYaDM9c1VYBhiWPC/pVZ6u09at59q9Zo8JERsbFPEUOLvSOtFUyckoJmg6rLFlGxT6lkks9yHsBwq0u/CibWycZLt2r5wXC9Ghm6PPnyjuDz6U74pdbCsm6bmEdngxPn1Oa52pebXfL5Vt7WQ0ZjrRMIYrKJ+KKYC1CLCfTAIS36/NOwpIJTynEIszr6LH0/dzOPoxA7dZPSMr+EVEpn3dMDgj3jFKIkGCn5TAO9wfpxHy2rZsO54dD01Z6SHQji1xbmHOqEFQxhUXmF9B/JOuG5JIgpq9/ycARSTLHOT5vzrL9baOO+fRBgEz73MXp+YTOuKbB/oi0+mvWO3dNcMl7AefESFYE/MA/xEHMseJSMQwGZrlzA8Z13LDYAZkvAmZQrkwOnuEWW0FPaFkVJVqcQZJz5zGXFdEfWpujDe+WIaBQU7JDOh7OxLUgvB7nMtvkHFzC04kZBhUd2T4WJDlP/Df/58GIa7jI4hw9bloXTJdtZZhmArSn89tzzEHKdoMn0u1cSfRl2iTPYya1cc1LRxZg2YQNNAbcON2dXxuvXTdCiRbwVolOxEWslE7gYuXmqnaVNjMfAv9CZTShwAtAnqd9IlG+62R/yCmV14LA+GIR7Zs0j88m4jJMEAzx4T0fov18CSxPZV4x6MWCP5TI2FZFNP4NbH++g344wEe4Y4K9kFDF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEE1MlhKK2VOZlFTcE82Y05FdGYvU2d5Vmk1NytMMExKdjA3alpHckdjd1VS?=
 =?utf-8?B?TlNQREUrUDZVWVA4UGphUVEyYUpud0hNbXpqTzJlUGNmQjlYa0RnMVNoOUFU?=
 =?utf-8?B?VzhUUlBEcGFDZVBlbHBjd2grbVVTN2ZHQjBVUHB2VE5TTjVkbjF4TmJJZDN5?=
 =?utf-8?B?eTBmd2pBekFxdjlJKzFYWUF6NE1KcVdqeVJPclVpdEtHbE54WUNuUTVHNmhE?=
 =?utf-8?B?QlN4VjRkY0ZvQjFJdmlXQXlpM20rNlNIN3BZa3k2bmR4ajBiaDR6d3ZRMkVV?=
 =?utf-8?B?eHAxYTBJT3JSZ084UUx0dlFjbzNPL3JESHJSRmc5U1M0N1ROck10Q3pXZGlz?=
 =?utf-8?B?b0ZudEJPWEhBcnFvVWw0dmpHRi9jdDJVTy8wVFIyaTNNdHF3SVpBelBTa043?=
 =?utf-8?B?eXNaMU9qVDhJWDVaR3JDT3BrMzFFU0tmZUZhWStQR0FUcCtzNjc1cG1lVVVD?=
 =?utf-8?B?c3ZUV2UrQVkvMVRoYmdWQkpjNWd4NWdHa3ZBWmpjakVRM2ZzUjYxbDZpSHNX?=
 =?utf-8?B?Mk0yRnlKYjhldHk3ckt2VjlCdWd2NlhDRDdkVVl6dmU4OXZxTmlCM0JKNnlL?=
 =?utf-8?B?TTd0WGFQSy9ubFVqZWhrMHFHd3B0VE1nVHRQWEtHZ3R4b0ljUWdkcUtOSktO?=
 =?utf-8?B?eUdiZVYxSjRIZVQ5YVF1UkxacUhVRHE0TWRNTENQVHVkVXp4R0FQdGNNMDU5?=
 =?utf-8?B?UkErRzNKQUpRYjh3Y0JYaEdTcmM5TXRPb1N2K1RJWnZJWEhwcUZ4b21ReWIy?=
 =?utf-8?B?RHBpY21HQi9DOUFMY3kvNFI5OExEWDEyN1Q2OFNPQXlKRmt2ZmlhZGZiTmph?=
 =?utf-8?B?b3BLVnoxSktjWGtZUUtzRjc2NnhSSGtvMTVuTjVTZ2NCTFVMS29IVlJULy94?=
 =?utf-8?B?RmRmeXhYbkVDcG55UGtSM3hkRExMYk1PWkh5ZTBuYUNvejlWTTIwTTRJNXNH?=
 =?utf-8?B?RzhFRmVFQUwvR21QT3NETFdGVEEzRGl3dzR3Smt3RFFtSVIxN0ZSQ2pFR0wx?=
 =?utf-8?B?aXFOZUZOc3h6YWhNR1dSRk9aUFhBKzh4QmJQK3BScC9mUVRyMXM1NlZDbWNk?=
 =?utf-8?B?dGYyV0FudGMvODZ4em8rS0lrOHJBNEE0Umk0K01FcHlGUWxDcDRqUWhSdTV4?=
 =?utf-8?B?MklqKzNDTmZrUHNQSzlDN3Q4bVRJcGlHV3p4cmdodTN3MklibmVKQTBNRWFq?=
 =?utf-8?B?QVZXWWFjRmNNbm1lUExUWElISkJqaW50ekVQOXZNUEJkNkhhaENmcGhMOExm?=
 =?utf-8?B?TmQxSmZvaE1vdU1Cc0pEemJFZnlGbTBQUXV0OFBhb1RlVGdQYXB2dk1EVWVo?=
 =?utf-8?B?dDFaTGthZmpGbXNLUThVN1I1bXRZd0V6T0JoL1orTHpjbFFoT3RsZU9BY1Zw?=
 =?utf-8?B?TGMyNkJlcTlrS1pEazYyUFpKN0N6RjlIcjFVbWVzUlNaMmQ4bi9zbHNhYlZv?=
 =?utf-8?B?SkZTOCtOa2FucDFJWVFvUVBUYmlnVkwwbU5HYksySGg5ZVExU2RPNGk3YUdP?=
 =?utf-8?B?Y05rblM0WUgxQ2NjUnQ3dElMR0txdTZtbEN3WGhjQklKQ1VJT1FWdVh2dERl?=
 =?utf-8?B?ZXFSeGtCRFRMc3F2TURLL1NvdVdJZTBoVFJsWkExSVc2ZVBrcXVmZzRlRHpp?=
 =?utf-8?B?WnlFV05JZENuNjlQQVB1blZQS2RFdGZCUWlQczFkN29idUU0a1VOV01GQ0RO?=
 =?utf-8?B?cnhjbXA2WDIzVkMwdnl3OFN6bExKNkg3bEg0dTBvZnRtUmIrQ3FvWmxsZE8z?=
 =?utf-8?B?V3VhT09QdU9DclRJeGFEQU5OMzhsQ0dMdklETHNUbUFsZmR3Smw3UWJ5ajNk?=
 =?utf-8?B?MEJNWHFvVFdTSHdXL24zZXRXTDZjN0hHNjJpbTFBYWRrNWdkUnNUYXhxL3VJ?=
 =?utf-8?B?OVZSNTZFaVVJMVczcytVcGhtTDRwejBVS0k3Y3NKZnJPYlpLMk9idzBPZmsw?=
 =?utf-8?B?WWxlNmpyUnFhbHJaUy9WbkJDR1dVMlRHUnNxWGNBc0NlTWxkby9WcWtmRFA5?=
 =?utf-8?B?QVpnemR4VWlUNnlDV01NYXEvOThGMWlTOWJKUVhpaFdTSXNyREJuank3SExo?=
 =?utf-8?B?Tko1SnFvOXZnT2x2YWdMZlpGaEdIaVhzLzRuN3hnTCswS1B6ckhtZ3lFQ050?=
 =?utf-8?B?OWdKWlZIN0l3NmZ2eGh3WG5aSVpuell5NDVjWjJjbmQzaVhJVnR4S2gvL0R2?=
 =?utf-8?B?Mk5BdmFOdWZtbHpubWFxcnJqbmt3VXladTFhSWIyT0pGMTZ0Wmo2MTlUbngv?=
 =?utf-8?B?MUtrY2FYQjFrQ2RsSVdTTk5IUndjM3BYRkF6ZHgxZzhLNFB3NmJvNlBhNjZD?=
 =?utf-8?B?M3kwcmJuelFyY3dtamcwQzYzZnJXNEVhRFMzV2FLTlREa3IwN0QySFRnZFJX?=
 =?utf-8?Q?g9896Sy8YwTs2NZjJiRQ79pOgqKmdfNR8MY7040lFqU0U?=
X-MS-Exchange-AntiSpam-MessageData-1: jm1wQVXTAgVing==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea5e769-a7d5-4cda-3ddf-08de84be094f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:46.9030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9E8j79rA39NOoMzJYgIfvr0JtSCUtl1SwCI4L7MyQcHkDmWUTAVhNswiGXx9tsWiD6Ha55j7p3yu9yXR/cI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Expose the `hInternalClient` and `hInternalSubdevice` handles. These are
needed for RM control calls.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    | 65 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 19 +++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..f3566f3ea6a7 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -4,6 +4,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    marker::PhantomData,
     str::Utf8Error, //
 };
 
@@ -34,6 +35,54 @@
     sbuffer::SBufferIter,
 };
 
+/// Marker type for a GSP-RM client handle.
+///
+/// A client handle identifies a client which provides a namespace for RM objects. Lookup of objects
+/// happens within the client namespace.
+pub(crate) struct Client;
+
+/// Marker type for a GSP-RM device handle.
+///
+/// A device handle identifies a logical GPU device instance under a client. In multi-GPU
+/// configurations it can represent a grouped or logical device.
+#[expect(dead_code)]
+pub(crate) struct Device;
+
+/// Marker type for a GSP-RM subdevice handle.
+///
+/// A subdevice handle identifies a child of a device that selects one specific GPU within that
+/// device.
+pub(crate) struct Subdevice;
+
+/// A typed GSP-RM object handle.
+///
+/// These handles form a tree structure with different types of RM objects, with client at the root.
+/// An RM object is anything identified by a valid handle. For example, the tree may look like
+/// Client -> Device -> Subdevice, where there may be multiple devices under each client, and
+/// multiple subdevices under each device.
+#[derive(Debug)]
+pub(crate) struct Handle<T>(u32, PhantomData<T>);
+
+impl<T> Clone for Handle<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+impl<T> Copy for Handle<T> {}
+
+impl<T> Handle<T> {
+    /// Creates a new handle from a raw value.
+    pub(crate) fn new(raw: u32) -> Self {
+        Self(raw, PhantomData)
+    }
+
+    /// Returns the raw handle value.
+    #[expect(dead_code)]
+    pub(crate) fn as_raw(self) -> u32 {
+        self.0
+    }
+}
+
 /// The `GspSetSystemInfo` command.
 pub(crate) struct SetSystemInfo<'a> {
     pdev: &'a pci::Device<device::Bound>,
@@ -192,6 +241,8 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    client: Handle<Client>,
+    subdevice: Handle<Subdevice>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -205,6 +256,8 @@ fn read(
     ) -> Result<Self, Self::InitError> {
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            client: msg.client(),
+            subdevice: msg.subdevice(),
         })
     }
 }
@@ -231,6 +284,18 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .to_str()
             .map_err(GpuNameError::InvalidUtf8)
     }
+
+    /// Returns the client handle allocated by GSP-RM.
+    #[expect(dead_code)]
+    pub(crate) fn client(&self) -> Handle<Client> {
+        self.client
+    }
+
+    /// Returns the subdevice handle allocated by GSP-RM.
+    #[expect(dead_code)]
+    pub(crate) fn subdevice(&self) -> Handle<Subdevice> {
+        self.subdevice
+    }
 }
 
 /// Send the [`GetGspInfo`] command and awaits for its reply.
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..9fce6ffefbce 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -10,7 +10,14 @@
     }, //
 };
 
-use crate::gsp::GSP_PAGE_SIZE;
+use crate::gsp::{
+    commands::{
+        Client,
+        Handle,
+        Subdevice, //
+    },
+    GSP_PAGE_SIZE, //
+};
 
 use super::bindings;
 
@@ -121,6 +128,16 @@ impl GspStaticConfigInfo {
     pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
         self.0.gpuNameString
     }
+
+    /// Returns the client handle allocated by GSP-RM.
+    pub(crate) fn client(&self) -> Handle<Client> {
+        Handle::new(self.0.hInternalClient)
+    }
+
+    /// Returns the subdevice handle allocated by GSP-RM.
+    pub(crate) fn subdevice(&self) -> Handle<Subdevice> {
+        Handle::new(self.0.hInternalSubdevice)
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.

-- 
2.53.0

