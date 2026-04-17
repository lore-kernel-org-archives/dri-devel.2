Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A424F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61F010EA84;
	Fri, 17 Apr 2026 15:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rzgp3YYs";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150B610EA7F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoEAdnl8SMx0scNWS4Bj6RajOKUIGqMA4dfcTjrLAhOe+JeLGNZEK4KHOsjZleMrOitfHJnIvhjqDd6SWjgrNW1kP3uJqaMielsMCV1ZqmaKhNe0aA1Q/v8heHM19sF0ZPinqTnHmgfz2XcPdeLnqFvbPoeTq5P/j2wgWEjrUIQKIB4d5RVf/VC8pOCElRV5gag/9q9AF3hrzVc8FAwSA3dUD4F7RpJzHw8MDQw3IIvD7x5nEvx7oCdFqJ/IUTFNBLCgjB/kHAi7rQwZrH1D3JuFS4J7+fQcJkVcb6ec7zkYVfseihI85yc5g4l9KeuoHNXJMnWbT61nAj2q+FFd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtBnRxLvtH7eqPhgMtyj3U5Um7xYlqzvbRKtu5TBQig=;
 b=e1+Rj92j94KXaHDf31YrYSay9WKApkh/DnxqXZEucEkunSSrmZu0aTTT+Ivw3tteS10GmqVyL7wawSYiBQOuqid7bDJBaGvqDjo3f/nSN2k6rcEiix77Dx8UgS91/uLx28rlrQV6H27IFTl9V3J7xe2eMMapVskmmd4T37nYvo2Kmse80aBwA6quHvRshDTDbGzzzDbGw2O+LHPezu/HnebMGgjtM5ZiMky5qbFN49tnAHKhMw+5fHNQ4STvRPYh67tYYMFZ9LddYKYdUaurl2u+QHS0UOoLc1QoDnX6hC3/yA98ld+LQ8jQd0DDDpd+TfiN4z7PZc0L2LMetXXSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtBnRxLvtH7eqPhgMtyj3U5Um7xYlqzvbRKtu5TBQig=;
 b=Rzgp3YYs7wqtiI+NeyaiMelerhurpPCHEW906W7SwenseJP89Zi0gTJPmT4ciwXX8qWQn7hN8I72zFkhS9A9xMw/k8bVT6sJ00DwF34U3Vg5hb2SSpRWIIa78gaoSWWx5Vb5yFN+Ids7Ti/8llvCqDJ7aIBY1qE1DHFYtBKMB9bafw/ijG/nzzTZOaNYdofjD2/ILZluJlOq1bRN76+lv53YfX1ElC7M8908mu7TAgdS8/+bbgEpHK+8HpkBfmwiuTLEEreegFrkoFxJPjYmniaH5bmO9zb6xegIM/JnHncdzR+lgAMVsTuzTImXbhLtvKaGwr1NAQpQvOUEP1e1Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:22 +0900
Subject: [PATCH v4 4/8] gpu: nova-core: gsp: expose GSP-RM internal client
 and subdevice handles
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-4-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a2f607-af4d-4b1f-e749-08de9c96b818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Jy3taqNaZkYSab8k96ppt6zlIc0tXGe/E79U0gVki4n4+0Hf0GiyYSubBxj8WW1ZNWkx8pHRDriNk5iT2OZ486zbm+IuWdbFP2pH2w86iEHVxfgLLBNew92oxt9bu08yw5j4wD98R5vidPkzCDbYwK24IEsYxWEujSYG7zV4/TObZXqg69vYygFF8OnSQLJIME5uousx05mzEnz+ihzexvEKf8J9VCpl/t6wi6ZgyQ6K3UDuOZ9XufCSNrrmXemj2rDEqcjasoO37DUCc5ftWZMJ9fMx1dTOgO8CRLJgvXbhnlmsTmeBzwL2PMjRVPrSs7vAHhUOeCLtWHSDeg2g9iWoz7CErS1ulFY5l+9gbw4trwF3khfutPpVITteGWsDxHB2nnR47L+Kz0i0fkgKdutFur8bkbvjqRhHhpGI+mG+Suclrtb6OrVqd4GcJ6Pa5maklH34pRyL0pZN0P7J3zC/qecvH3ZyNXQJNL3Oen8k/EzeIyjG6SSM0V3IVBX5Tu/PVxRaHSUTk9Z+jaAV9WWRc5LKlqF68eSgdKQonvphwTOsDmojexCV/zoxhuQ972QSIGUYpxSv2jVEElY5z24MlWbu9WjIsbCjAn0gD/F+wwODUfv3og2lQfNMLILQiGFwb6ghMZh5wXof2e1NZyQV0jH2FTvzKNplrrBL8wsiYF4HlwXOY69fIcdRAxwTbhzt0M8toejBv5u/41K4mtT2WcSUjhJPfPq+iXOp2So=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3psZWJsYUU3QTQxb2RuWEJVMUNzVE42Nk8zWDBHWXRCTHU0c1ZOZGxVNDV1?=
 =?utf-8?B?TU4yNWoya0NXNDQxRjQzZVpodDFiOEI3VFJRUUtRUWp1bDBnQW1HSWt4SHdw?=
 =?utf-8?B?b1RYWmhOcVR5WENCdDU1NkUrVk1uRUZCaFJJNGJkUmduYlNpMUlWQnhRN3Ex?=
 =?utf-8?B?QmFLVTYxUEh4SWN3Sm5wN0h3bkxVK3M3d2tVTldDTE55NmJjUFNqdTErVlhE?=
 =?utf-8?B?VlprYlFKc3BqbzlYaE5RbGxrN0MxdmxhZ3N5U1ppcnJyNEV6cFFhcnplc3Zz?=
 =?utf-8?B?Vk1SMFY3bzFQelQyTGZLQytYSUIzdWowSlpOa1MrUzVCTzNtWlE4SGtQc2Rw?=
 =?utf-8?B?MnVjSkZDbGVCTnpUR2FvdVZWU0NqbzIvOXNiTzBERzlDbGx4RDlyZ2pVN1lw?=
 =?utf-8?B?dUcybHJCVTZOK2ZhM1Q1cGl0QmdnL0hxUk9oZ3l6emlsZkV5UXJWZkhHUmNm?=
 =?utf-8?B?bjhtSmM1Rm1ybDRVMUpvVnppaHgycWtnY2VnRkNjcERCa1lCZ1hkc1R0U1Fz?=
 =?utf-8?B?SmtrTFdXK1dWb3FYKzZialZCZ0ZadVRvNlhmaVJIQ1l4Q3ZabWl1Y21Bb1Bz?=
 =?utf-8?B?cThLWEdUZExNSGRnckNwWlRmUUtGVjMzaDRSdkwyZDlyRGVneXl6N2Mvc0V4?=
 =?utf-8?B?M0RLZzhxbjNqSSttZG5tNm1PV2VIQmJPbjdrZjZMWkFQMVNqdDNZcUt3YXFs?=
 =?utf-8?B?VUtLTndFOW9qTWdlOVJiVHRaRlFaSnpzSjlYM2xLVHpoek5WNlQzK2ltdzFB?=
 =?utf-8?B?eTZmL2JZRVRpTTZYN29qbS9WRWdMK1J4bVE5NGRIak5TVUF2VmZjZEFGcGlM?=
 =?utf-8?B?cCtyYUF1ZFJLL2UybFNvcE5lOWF2elpNZGlJNGVrTFBFb0tsRTNyUktGNTNG?=
 =?utf-8?B?dlJMWjFHemNLWGZ2UHlrOXVNMlpSYzVzeGRaSFpON2UzRHhsWk5zaWZBcyt2?=
 =?utf-8?B?YXBhdXRXMGpWYW9HS2VxemwzRU1ZTGpKRHcwSFZTK2VoV1BpUGd1ampISUNL?=
 =?utf-8?B?dmNGcW9QemJtZUtoVll0YUNsY3N1SjM5MnZWaWlocFgxdm80R2lIck1QZXFV?=
 =?utf-8?B?YlhhNStuK3JjTTNjTk5OSXlvVnhSVGJDRDVFQ1lsS0VaTTNMUlpOeStzVXcx?=
 =?utf-8?B?cmpraXlnbDJQQ25HVFZhVnFrb0xudWd0enJhSVEzS3ZDanRXcHJ5eVdvS0Ri?=
 =?utf-8?B?cXg0alVBdjZ1b1BUMGxyS2FZbXhYcDdVVWw1YlBXbXRaWkNyT2JReEt5anV0?=
 =?utf-8?B?dGFsQmQ4aGVpMkVoNVNVZUg4d3NlQ1c2SnIxbW93bjNJcGpCQ1RKV3ErZXEy?=
 =?utf-8?B?bEZiZkQxenJ0L1RNT1dwenRiRVd3b3liK2gyUjluV2R2WWZkd2xTd1BHQW9z?=
 =?utf-8?B?ektiMzJLb3N6dGErUmhvbmFpcVY1RU8xZXZaRzdPai9SenBvbnlyZ081TWdE?=
 =?utf-8?B?cWI2ekhnSktKYUthQW5xZnNMY1Y3eEVBWCt6YTI1ZUVsMk9vMGVnOUkzdTl1?=
 =?utf-8?B?OC9FbXJDMG5sRFBma0d0Y0U5MEc1eG84ZGNncFlGMmRXaTMyQ1phVlhnWmR4?=
 =?utf-8?B?Y2l4cXhiSHh5TTBaK2ZRYkV1bGVXQlR1aG9PblNqMy9GWVFWZCtWa3Z0Qy9j?=
 =?utf-8?B?R01KakVua2lQQ3UvT21QQ2NyTU4xbE9hSVFmalpBYXBCZXA4VHo5czNFTWdV?=
 =?utf-8?B?SHNzV3Urbmd3aFFTWXN4WVFpNmd5RnRJTFdPaWF2L1V4MmxaSnFudXBqbnFi?=
 =?utf-8?B?NDY0MGMzengzTHVkTk5ZS29pZVpPUDlNcnRHTDZjSW5ZazJIZWorZGhwd1h2?=
 =?utf-8?B?ZWgxMm5sVVFXZDlhUFBIOEk3Y1QyV1FWZTNhRmVIT09pUDNPWXN5allhMlNW?=
 =?utf-8?B?ajd4UDEwNTlRVFAzZXp6dUxOdHJxK3N0WG9tSFl5OWRGQWdNWlMwTDdnaWdT?=
 =?utf-8?B?cWN4NkE0bEhHQ3FoSnpnM2JSaFZ2SnhMd3paeVhpR0EzSnFkUFNmV3pIcGN5?=
 =?utf-8?B?azcxdDZRU1JLMzNVcjRzWjZ5VU5YZTZxS084bzRqOXRNRmphamlwRk1Hcnd4?=
 =?utf-8?B?dEdrMEpiZ3JvYXFKeTFrVFVLUE0wd09Bd2I5RzNCMnljaEcxS1lCaXdBVjIy?=
 =?utf-8?B?eGtucUdqMU96YzRiWnNHRkdSRDZSVFh3UTZXU25jT0YxUldjVEJZUmRJNmUz?=
 =?utf-8?B?c0gvUnB1SkFweko1WS9uS3dnV1ExQWRmSXZ6bmhXY3BDMEw0MFByZXEzMnBl?=
 =?utf-8?B?cnV4OVlaSHVRZXlORy9lcW9MS2xEZWk2cGRVNmFqd0hCa3J3Um5mU2Y5bnR6?=
 =?utf-8?B?MWxyY0VITEUwaUIwaFJmTFZWNzFUOW1MS1hVT0dObU9LNldRZmNSOHNpalkx?=
 =?utf-8?Q?gna085NLiqVFTpQtcXRhgNdnLeDUCJMj0sdSSv6cYBSV2?=
X-MS-Exchange-AntiSpam-MessageData-1: Kx8U0911xS9axg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a2f607-af4d-4b1f-e749-08de9c96b818
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:48.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DODRLmlvm7WISXpx3A/jMd8K2yfrb+2iFCfTRslPvo46b9cQfPwh7VLtbQ8FEJ7rZ67CuIAfsQascrTGkRXMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    | 65 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 19 +++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index b8f64bfe9313..8a19ef689731 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -4,6 +4,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    marker::PhantomData,
     str::Utf8Error, //
 };
 
@@ -35,6 +36,54 @@
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
@@ -193,6 +242,8 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    client: Handle<Client>,
+    subdevice: Handle<Subdevice>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -206,6 +257,8 @@ fn read(
     ) -> Result<Self, Self::InitError> {
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            client: msg.client(),
+            subdevice: msg.subdevice(),
         })
     }
 }
@@ -232,6 +285,18 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
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

