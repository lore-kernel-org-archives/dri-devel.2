Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1C106B50F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCEC10E89E;
	Wed, 25 Mar 2026 12:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dq6e2q+E";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0E310E894
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep2v34lVcMPgFEvue9lJrpaYi/1LH+c0t+ovVkwnKlzE0efZDFnVCQkUj9SrEX2UmyRhLJcMw9mhoyBB1dsGqd8YMzUzFdJhpj1Sj3CdKXCHY1Yjc2c0vGsdQ/A757E+4GmEMJF/unj3DLRP6m8rs35btFpE1XotoUCf+QbNGO8+JuTfsofmYUFAF6/1sKYNOw9PSFZsxVIQt+1ieuHTNZAZeBdGXZvWGRLDAb1FZArs8xklyFsFZTlGzYEmxmWhAKK3mAzaUNPw4/u+YroJM3kwrxKrek8SlQWlaxPBeOGR5AHAcuQ826E0m9QgcbPXY+MkhbuN6D8soTTkRN+GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzSwQOmvjY4sYtqZtOreKEykQCR1/tb0rDwprvzqNus=;
 b=yVQKJv7DGG9qWzvzbxSEUCLGlMRgk4ocswwu9W9vYDKdUpgqW/BWu7LZE8Xz6a87UKkLbouWj/XNv1mGXLXalz+Wqui554Q+DpTW2oh0S7ZjEPuvsUjjgFpaOGmLr+NmJjywQ6ZcK4FmiPqossnrwPdFKkR1GzejijlSzcLTMv2Z8UzFx0qS6Sdh3ApzXiyIqAfbxaxm8cqduRy/OpIfrD3pXYeuhN6scfA7BL3ohYUQFsUvzFGVslarjaVI4b1FPmWzh2C4s4/+JcFojQDunbWY+NJLaeHscMGnIf6XlGmeZwjZyClw7RKFaelM1OiUMUOKwYxZJJVP+TOxGYwZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzSwQOmvjY4sYtqZtOreKEykQCR1/tb0rDwprvzqNus=;
 b=dq6e2q+EGtvEqeBHY7gCysI4HJmblzgIezV2+yHPVaQORbSqQG4Yfu2fzx/bG4HNJdIxR6gQd5Bwx+weHWyAoz6mT5fWIuEOy1edZfHCM8+8QT/pkqy71a87wwrnxs2tWilGQFlCzsjitKnCD5Z35VvLN+5BufeYtpnmQMAViDsfqVGoZq+sw7d3lkaojbKKpvH95sSf1lWQHwORQ1/Ik/MaDnJJTs7KK7f4hlWWvz9zvaae9x88skv12F1wrc+ZzXFmFEs0hY7lQIthFFATnn8Fanyg7AG80Bn9WK/UfdfpvgTXiTp+VSZ/rQU7R9TzN1Um2xfWpphs1R7kM4qgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:13:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:13:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:41 +0900
Subject: [PATCH v3 3/9] gpu: nova-core: gsp: expose GSP-RM internal client
 and subdevice handles
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-3-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec2f980-a463-48ed-7b5b-08de8a67fed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U5Kal+blkbAE2GMYUXwM1DzESqfvw5Ke3eHsQtFy1eHF0Ui5Q0nJtF878mkaxeSQin28OKgas5nZDBaDug0GcfqfTp2T1ohfAYpZ/YINGMDd/2ZFHxrdD7FwMN9P7iEgqSrhK3dr7a48u8AxGQJCGe5fHy3HM+zLlv0DUcoAPkXNdwf2mMts/8M2G76Z0vERhfMvlgX1JrcNhOc8S1NE/EKijEYBjMQfGu9/C1Uy2crCm2NQYEiRfHq2ZZL8ZMi/AYYgjSzfD+4I6GULCaEIwN3d2svo3kEflEPtJCVO5/uUp2OK9QKMWPlr2aLX5tmZWYWPC2MB6szLqhQUxTByyXSv8WuylonUxokgq8LEi+dy6w73QJUmVwxd524yZYohG6B0YMGDSIukCL2GvtW9JaJmqrr6WLuwPnHYomwx+SjvVll6cpFevtEJrc85oB4XyRErNNiJ7SIOACWSRzMY7cZxhCh8Q70/He2JjfPZDnGzhbCQ9N0SltcLmh9t8Oea8RDmNgiiAY2HEfOzeXkh0vjhLrUDf9U92OuQ3Ig6QbS+fy4ZG011sTLPlWF94+YFzhGaovTJqji8TI8jR1oq0LgPrpmqbHFYQ3j0N/hFLcZwLgKEV+VBmvnJ3Q5U6ExoxzQbtHFblAc0bHXyluy+1WVngUzF9RWS7HUKHRBkeW5gZtOHexsmtBjLxkhAwLeaJhRCjLfO2vF+JJuFzTXNLvuWPIPzcb/9bouFqRi4o40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtsRzE1bWltNlJxQkxZdU0xMlhrU0JhcUVpaU9PRGhFUDBYcDB6bml3eldJ?=
 =?utf-8?B?dzNDdEdaUUl1WXRXbnlGNUJuL2xYZ0twdTNBNVM3dUVic0tsN1duakJUcnVQ?=
 =?utf-8?B?cXpFOXN4K3dJVkI4WWs4U0FJNUVPV3hNRTYzTVR1ZmErRUZVL2gzeGhmVFVV?=
 =?utf-8?B?dXdQaXZNby81dFE1b2p2NDJnYlY1SjNyc1VQOThrTHdFUHBDQW8yRGk4ci9S?=
 =?utf-8?B?YVFWNGYwcVV1SkhQUDJkMTRRQnQ5N0JYMSsvV01SOUxvZGFZbXdGRjloVk1w?=
 =?utf-8?B?M3prbUgzTE1YR1hJd2xGY2prZHNQeFRYMGhYUkV5YlJFOGoycFdvQ0pTUU1H?=
 =?utf-8?B?N1NDak80c2R1dXh2LzYvdThTWDlzV1JVMkRBei9GTWgzRWhZUGpFQ2M0UTNq?=
 =?utf-8?B?VVF4SEtKTExxOWZ0a055MkV4YUlEYUQvUUdlNHBka1MyZ3BlZVZXcGo2aytX?=
 =?utf-8?B?Tlg2ZlZGT0VEYmxkclJqQW9ET1BzeVV0WmtxODFkRkZhdEVzdXNMbXRQamdi?=
 =?utf-8?B?djc5M3pCb0RoT0VlTkdaODdzSU42cXdsMmZUZFRtQ05LSDVSU1JYZGlrbGdn?=
 =?utf-8?B?aVFCTGd2dWcrTUc5SjRudWZLOXNzZGZwbDZJVlhubEl5Q09HbUhERitUT3ZF?=
 =?utf-8?B?NWNJK3lNWEluaWN2T1h5RTJIQ3VsRWhjRU5JczRsT0prTDI3N0pyRGhGMDhC?=
 =?utf-8?B?N2ZyRGFza1pOR3NWdDhpVlB3RGdJbnF4NW1seE4rNFZpMG1kbUFSeGdkRkpo?=
 =?utf-8?B?N3pVVmNhT1VRSERIa2pXdTV4Z3ZCVHpvVjcxMVBjcVNEbStkOG9wWVRMcGhX?=
 =?utf-8?B?a29PVXlSdjV5WXQ0N3BXVXNScVBxUWtZNDhXT3ZHc2pZK2lmSlp4N240eVN6?=
 =?utf-8?B?OFRBMXYweHBnVE50UnE3eVdPUDFIdDBVTlRFVEJpT1JGOVpJNUF4MS9PSG0y?=
 =?utf-8?B?enpPb2hsVERxdU91ZERrdXRVck41d0htVkUwbmE5Ym1BcGZOV09iSXNZMWI4?=
 =?utf-8?B?cWhvMS9hMm04RGx3bWZ5Y1dYZkUwYlF0S2JpLzVKd0pWcEV4MDdDQm44VkZK?=
 =?utf-8?B?ODFRZFlTK0RZSnVOQkR1amk0cTMvRU9kU1RKdkd3THAwbm9ZM2V5L2drQjVQ?=
 =?utf-8?B?eTZzSExoN3F1Smx0bXllbk45d1Jsb243RXdCTEIrUEZrSGNIZUViUFVQODJQ?=
 =?utf-8?B?UnRKWDlRcDVDbmIrWDlCVmZaVGY4OXUyQjlaZW1yR1RXM2RVWGhBRzRHSVFI?=
 =?utf-8?B?SG5xS01kMXR3Z0hRZmUwOE15TlBEMFY2RGdUOGhndFVCaHVWbHJtWEwyVWg3?=
 =?utf-8?B?VEVGUTc0VDkwMXp2UklyZFZ4dTRvLzNrMGttelhsakxRR01LQUlSRjZYRTV5?=
 =?utf-8?B?TE9CRERqZkxzNWU1NUFEamM2aFBhbFNqay8veGZObzRpbE1NSEFVTU5jZjUy?=
 =?utf-8?B?eG9rbFF4TnJWdXFkRjZ0dWxZb2VCM0w5ZWpzRXFpN3ZYb0M0V1VlYlNyZTEy?=
 =?utf-8?B?T2Z5SnA0T3h1UG9QRjFqVU90aXVSY3p0NG5ObWpyeFBVTDlMMVBGbkwxbExK?=
 =?utf-8?B?c1gvK2lJYTM5eWg1L0hBREduRTFmRlVCb3RwNXBsNXNoNitVV21rOEZqQWY0?=
 =?utf-8?B?THROY0hjbkhiRjZBa2cyb2RjQjdDNFhhcFFyakRNNXVjL1Boa05oenAzWk4r?=
 =?utf-8?B?aTU2VUdKZC9qS1FKcjVuRTJrZERURk5zVEdza2hqUXpwWW9UNDhzcjgySERK?=
 =?utf-8?B?M0JnYkhRaHRxVmxDZlMzbnhXdnFZK2k2ODVRbXpaVkRyVmZYODhFZklZUnk3?=
 =?utf-8?B?VzJBT0tOTEZ5MXZxSDlFNlhOUUFxUE5USHhiK1NPTVZhOVRNRXhuaUs0ZTJV?=
 =?utf-8?B?ZytXTDNTczEyVUpmaEt2TFJXcG5WREV4S01ZaXc1QWE3Q3JFeEFUaUZqZDNH?=
 =?utf-8?B?R2ZUNTZUQ0ZTa2pmNHBBSm1pb2hsazFwTlk5MkN6dGZWS3Z6Ujh0a2MzaDdV?=
 =?utf-8?B?VFRESHl6QjJCU0hpRmMzS240b3pVek5WNCtmTVI4eVRhNHkwdC9jVW1Gd0Iv?=
 =?utf-8?B?akpQVE8yMU45eE1XUmJhb3lqSGtrZi8zbVd5bEZ0NDZVMkxCMmhLa1Jackw0?=
 =?utf-8?B?aEorNHlXUER0VCs4Z0Q5V2pxTnREOUUyKyt5VEMzeG9YUlE0NU5CM0VpNTlV?=
 =?utf-8?B?dG1tVTNnMnkwSERKRXhKci92aDJ6WEhQN3R4aTJ4ZEJUbHZjbERWL3pXWGVQ?=
 =?utf-8?B?bldNeEw2a2w1dkd2SHR2RExuTFR0NmN1U1hxSk80NGx6UE42RmRoZU5yNTQ0?=
 =?utf-8?B?RW1BVFZtT2pLZVg0VWFYTEtZNDlRTjJDM2tkdHNjbjlsVzVoYW1QVkdhUTky?=
 =?utf-8?Q?gEigYQcM7morPGgPHibVDxs6Rhr1UIl0Uv6Z8TJ3PGb57?=
X-MS-Exchange-AntiSpam-MessageData-1: f/o6eE9aGYP7lg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec2f980-a463-48ed-7b5b-08de8a67fed5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:13:59.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu5JKNufKGc7OSlQT6B9opTLeyLY4ysaeiEBvZEUhwyi3DsLps5Dr90EwrA5M3usZl5YMYJDKutS0wED9AXvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

