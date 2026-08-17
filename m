Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD6C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505C410E68E;
	Mon, 17 Aug 2026 07:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MUiuJMqq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D0510E68E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMe3db2omz/d/7pNXApIPVAHId4RuVzcbNu1NUcPJSQM6VeBzuaS17h8NsODvh3UZOOL83I2PNv/2nGBjiIOc2lvNDa5t5b5CS15LF0IQ2SZXyhTM6twHtYrQaGxPtRcZa+erbLrPVqGovms+ud0rAPkfEk+W5faLVAplrfirD+vY9l38wXi/Xn1hLxvlbp9vgzakgorzQFer3BlyrFcHf//V9R0ILiZ+4x7cZJy18SjDxQH3Nr4Hc1LZEXpLU5EEzmBaeahIvOzACeB7Au+o2nVYm+wKKnryhj2xr4nrhde2M3qm2SdPpBn1cCd3uJcPBYZMJ442DBxnAeTi1XmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh763tDgoew41ixQGEFs4xuHSIMXExrr7ffNCYFxu68=;
 b=HYzhl/a4TfCuciEMdOsxB/Q1BMoe5x02seOpPtE9lxnohoDjSMztibVQGfH3s7AxmD72EYZxtEBaT64iDdqbzVfnXGJBuNZonn5LoTWmS/y1tVoZGqsTN/r7EOppqGlJVpNG+MLydQr/In4uBCzLXVyyVKJzVxpICHsORGy8YPF/lxXLKivqy36H1hQjb4GflaU9PofZDcTqcev5+qlu0o6dBbfmt05pr0z4iFjGVsCO3AM9AUwcfRYhiUnxbvWfzWbA6ucCiYTAC0wF2F/UWE31XNl+Xoxu6ti/lvJqMbK3FbGaa9y+7WXqPxhsrHu47nRBztLJZqi2w2jMWiNWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh763tDgoew41ixQGEFs4xuHSIMXExrr7ffNCYFxu68=;
 b=MUiuJMqqotmoA13IdfBLc4z57f+/SKb+YF6yT5gt2KCbfZFD6EJ7uXEVLQWl/4eeYv0wmZf7q+MiS2PBCj1ZylBYlS0af7oOEKdMX5YWKpyYKLE0TDZg4E4mYLjbZL3QzkqRzvfBr8HlBduz9w9WGmDHCjgIj9gKUnK+dZW9ovwwsi3axda+uiMGdTYraYX+2cFE7Jd8AyvrDFVnGj5KsN1LIbSf2T0rFhdCzCOy6VaXak2nt/wn5YjQrmRl4mQ000tU4ZfqREoqXO9IznjK8H9uI+xzB1h7tcp7OpM5PsVBVP4aWs1hI8kNJ5E7nyJmg/ukOZ9jbnXe6yLTZBLWVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:18 +0900
Subject: [PATCH v7 04/10] rust: sizes: implement SizeConstants for
 Alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DB9PR06CA0009.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2a033a-82dd-48d5-a050-08defc2dcdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ebt9z2cyFpd8cE1DAGbse/XKh1y8tHtitlqRffebnSnwRpBxtpMX7dWUs2DtHBClvDRzWQ8NxuxJpm1jOQh0wbFIvo+fxmhWFxLuu4FvAHOzcOPLynJop+XJLZUaRY7wNbskiK3+J/ZJR+AyLBcOIvXWUbS5qQDAORq1Ly/c0pDSR3BZWYa+SL0iEoVUwQyc7L9dTjnqDcj/nLiYjWv6aFRT10/C2RQG1ZbADVYhXVRmkPPp8WKLzYWVEZr/SduMbxq46C4/WRx6D8RifoKMffEhsy+mLcgxpZ717Et/ixkkBZlRATk0Ab/Sdn8yAyFpzYK+XC4dKPjb5SAWb+Lc/OGVtiAw2ZCeDcRF+SGlTmwe3KZRns0+mgFj/Yaj+upMnNc9qybi7LALDTJ2gTNnnoSHVLmCfyRhpd54IFjshP/Wg1y8bKAdvA1507/iLcYIerq7FtV/suLY2YZhFZt/ScRVVyK92S8XhG8uQVtXQ/ZNBRAAS7Nntr3F5j9dRjadxC8cnVjVAzLndCmxXLD/KkL5Xti2zQb6PW/rnL+if1QyYUfC+Ad7pleTU/1vnVM5uypbjo1oDYDxlTTJqj7rVr9TdbDgwlNVsXJ6nvqBo9z4u0/9SszyzH4a/guzRdQ1IwPUBa/HNfLbtcXKN60XQrG3qriS3o2NCi0VP5MXQvZw39V7dI0hMleBYSOszAW3yFh6pcyVknMYkVtBmaDi6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtrTkgwNHEyNWFxNFBmZ1dIdHROTXRFOER4ZWlZakpBb3UwZkZwb2xmZ1JC?=
 =?utf-8?B?cmlDMFZRS3hIR20rUEI1UVV5andpQmppVmUyeGZXVzZtSGRxNVdOQ0ZzS2VV?=
 =?utf-8?B?MVU4VXlDQzQ5RHMxcEt5dzR5ell4cEVvYnRxR3lncEIxMjZCVmxvd2RNV2Jk?=
 =?utf-8?B?MldEcERRMnF1dzdGb1JhWTNmNGFCMktNV05IOEVMdDk4YStsd3ZvakIrZG1B?=
 =?utf-8?B?cU5yYlgybzlqb2tjcUVsTGxjNXU0Mlg3aEdLTkViQ2NaallJeEJmRm5WZjNY?=
 =?utf-8?B?bEw4U081dVpyUlNpMngwWnhzcGQyK2ttVGMzNXJNeHErMnpPb2xqZUhIdFRM?=
 =?utf-8?B?T1lMZFJXczJ1Y0tPOG1FQldFdkZJNk4ybVZNd1VSOFhXWlhva1RoWnZIMDZX?=
 =?utf-8?B?cWM5d2JTeGpxVmU0T2h0dmVlNnJqR0MrZUFPWW5ja3htNDBjamtmL1RPREo3?=
 =?utf-8?B?VVltR1pjMDRLcGloQVdiVlBNRHNxUjNDRlVqRXYzWDNGOWRVdHVYK0lSK2xE?=
 =?utf-8?B?amhoN3NqaCtQWkJ3czJ3cmw4cTFiWjFFZUhmOXR1ZkloQ3IvUmpJTXFISXNv?=
 =?utf-8?B?K2t4eENQZjZ5QUh5NWlDdGM1UVJUNURKazVxQm9RMFlXVFVlN3oyak9QMFJB?=
 =?utf-8?B?a0FqNHNpekM2NzQ4R1N4S0xDYnkyakZ1WXIrR2FQS1ZTekYxS2IxZkxUbXcv?=
 =?utf-8?B?V2owa3Jtb25HckpyT1JhRnVubjZJTDR5N2diWjE0cmtyZVJnS0t6a3R2dEx6?=
 =?utf-8?B?MWJEQjdDWjZ2VStTNHVqL2U2cEgvRmhwclNVeVkvVTRuOWdweDZzRGl2VVo0?=
 =?utf-8?B?K0Rsam1Ncy9lZ002QnNsNkxlNGNIYnh1eDRFR1QrSjROblNLWjZ1UTNLYTNh?=
 =?utf-8?B?RklwYkJiVzJ3Z0lPQVJYWElkdUJhVkRNQjdUV2RXMElLQmZzaHhmWEszVXg2?=
 =?utf-8?B?ZlpQeTE1RHE4SkhTRlQ3WHl2VzNxV3V1V05iWWRpZ29rdVhteStXdlRyVGdE?=
 =?utf-8?B?MWNLWStNODJIaEp4Ymtsb05wMVBESWU0RDhNbFBkdEdjUXFzaTVXRlFKVTZ2?=
 =?utf-8?B?MXp4TWgrUUZPdnF6KzRDUVg1c2lndFlGTW5KcWFiT3RlMEluUzZYaU5Rd0Qz?=
 =?utf-8?B?U0F4V3NjV3Y4aCs3WDIrUmI3RWFxTnVJWThma2RYbHRiM3I5cFBwbkgxczRD?=
 =?utf-8?B?dXJ1YTkreU9SRS9yUEF2NVdBbG1MUkN1NWRFNmRPcWNwbHIxaTkrcGlML05Z?=
 =?utf-8?B?RW5VQ294cUUzdDVIMllWVmhWVnp1TGdmQmYzMjFDaTEvSFJkRDR6dHVoRHBR?=
 =?utf-8?B?R3U3bnBCRkpsMTRzck5IU08weDdabytsS3N2cDBQR3Jyb24rTjhmY2RJUlhE?=
 =?utf-8?B?Y21iQ0JuRng3NGhUK3BlQnVIRU9sUW1qclRtM0k0eGVRalJNQTNVUU1xMG44?=
 =?utf-8?B?S1BhM1Q0VTlESyt3cGJ6blZpS0svQWwxNlBIUGJVWHZnTU1CS0pkSjRHUlRR?=
 =?utf-8?B?OFBWUldSTTMzUnFSbE1lZ2RSQmNLRGNIczYweWRnM1AyMDBDNXlVcHEyZjE1?=
 =?utf-8?B?SmxaemEyanM5K3EreFVidThNTTA4cDYvckhTRjdXTjY2dW9VNm9POVpVREFt?=
 =?utf-8?B?N2ZtZTJPQUZDTTkvVXluTytISElLMkdmL3lqSFo4NlRabVVPaDM3cmRxVzkr?=
 =?utf-8?B?Mk9OWTRXTmFJSWhYcHlRU2tXSUdrVDdWa0gvUWEraFlOU1l4bThkUEhuQ3A4?=
 =?utf-8?B?VklmYmVBem5JUTBKcGkxbGRKcGoxRmxwQlVjSGtDN3E2NUhPU29HM1RzUmRW?=
 =?utf-8?B?RmRvMnFWMmdzdnk2RW9aVXhGNUxnclRrK3FsajhIc2RuV0NNa2RQVmF3RDN3?=
 =?utf-8?B?aCtXL29rL3BFaHJaTlVqS1NWZ2dPdVVLRkNqblhkZjdwaC9vUkhYTm1MRDlo?=
 =?utf-8?B?TDZHU3BpQ2RRcE53L0xxUjVkY1lMblEyT2tSWGZHd1g1SXB0S3JyeXM0a1NG?=
 =?utf-8?B?eHJDbjBjRWFHWjhUc25TbG91ZHlSbUtWWmtIZW9wSjF4am5PMEtRVHNlUG8v?=
 =?utf-8?B?dHo2Wm1pSlBEd2IwdWRuUHE2SUJCaDdHY2lWK2tFZ0JwMC9WZ2MxYm4yZ2E0?=
 =?utf-8?B?a1I3L1d2eXlSV3lLMnAva1YwZUlvWEhpUElmbFlUSkFxaG14NXVXR0dzTWVn?=
 =?utf-8?B?QjVCTnh1cUlxcFJ2MFBISk1KaGU3S0hiVm1kT3lLNVBMYitlQzZUYWl0d0tJ?=
 =?utf-8?B?M0JQejBZa2E2RTNCSzhDYXZDa2lhLzFkYzNORlVHVTRFZjNObk9pUmJGWjlD?=
 =?utf-8?B?a1pGbGloQ2FqbWV1ajJ4aWJRMit1N0pSbVdZLzd4WkhJWGJtZjRQOHV0ZWYv?=
 =?utf-8?Q?QRRrTgQUQVcbXZfpB9HwdR9MxnZI0Q3JNCvuOnoG46Stz?=
X-MS-Exchange-AntiSpam-MessageData-1: jvPr+pxAq0BnNA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2a033a-82dd-48d5-a050-08defc2dcdea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:39.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDf/gfnicau2AirYn+bRRFKNLUu4lwrTPTH0JCGabUucFDn154KQ/I04Dt5Tl0hi8EwF2B2kpHF/0VvS2VDT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Currently, constructing an alignment is quite verbose:

`Alignment::new::<8>()`

It's unfortunate because it disincentivizes using it at interface
boundaries. Implement `SizeConstants` for `Alignment` and add some more
size constants (mirroring include/linux/sizes.h) so we can write e.g.
`Alignment::SZ_8` instead.

Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/sizes.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 521b2b38bfe7..825d6b566952 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -13,6 +13,11 @@
 //! these constants as [`u64`] (or [`u32`]) rather than [`usize`], because
 //! device address spaces are sized independently of the CPU pointer width.
 //!
+//! The trait is also implemented for [`Alignment`], providing each size as a
+//! compile-time validated alignment.
+//!
+//! [`Alignment`]: crate::ptr::Alignment
+//!
 //! # Examples
 //!
 //! ```
@@ -35,6 +40,26 @@
 macro_rules! define_sizes {
     ($($type:ty),* $(,)?) => {
         define_sizes!(@internal [$($type),*]
+            /// `0x0000_0001`.
+            SZ_1,
+            /// `0x0000_0002`.
+            SZ_2,
+            /// `0x0000_0004`.
+            SZ_4,
+            /// `0x0000_0008`.
+            SZ_8,
+            /// `0x0000_0010`.
+            SZ_16,
+            /// `0x0000_0020`.
+            SZ_32,
+            /// `0x0000_0040`.
+            SZ_64,
+            /// `0x0000_0080`.
+            SZ_128,
+            /// `0x0000_0100`.
+            SZ_256,
+            /// `0x0000_0200`.
+            SZ_512,
             /// `0x0000_0400`.
             SZ_1K,
             /// `0x0000_0800`.
@@ -85,6 +110,7 @@ macro_rules! define_sizes {
     (@internal [$($type:ty),*] $($names_and_metas:tt)*) => {
         define_sizes!(@consts_and_trait $($names_and_metas)*);
         define_sizes!(@impls [$($type),*] $($names_and_metas)*);
+        define_sizes!(@impl_alignment $($names_and_metas)*);
     };
 
     (@consts_and_trait $($(#[$meta:meta])* $name:ident,)*) => {
@@ -99,13 +125,22 @@ macro_rules! define_sizes {
         /// choose the width that matches their hardware. All `SZ_*` values fit
         /// in a [`u32`], so all implementations are lossless.
         ///
+        /// Also implemented for [`Alignment`], providing each size as a
+        /// compile-time validated alignment.
+        ///
+        /// [`Alignment`]: crate::ptr::Alignment
+        ///
         /// # Examples
         ///
         /// ```
-        /// use kernel::sizes::SizeConstants;
+        /// use kernel::{
+        ///     ptr::Alignment,
+        ///     sizes::SizeConstants, //
+        /// };
         ///
         /// let gpu_heap = 14 * u64::SZ_1M;
         /// let mmio_window = u32::SZ_16M;
+        /// let page_align = Alignment::SZ_4K;
         /// ```
         pub trait SizeConstants {
             $(
@@ -117,6 +152,16 @@ pub trait SizeConstants {
 
     (@impls [] $($(#[$meta:meta])* $name:ident,)*) => {};
 
+    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) => {
+        impl SizeConstants for crate::ptr::Alignment {
+            $(
+                $(#[$meta])*
+                // A non-power-of-two constant will fail the build here if used.
+                const $name: Self = crate::ptr::Alignment::new_checked(self::$name).unwrap();
+            )*
+        }
+    };
+
     (@impls [$first:ty $(, $rest:ty)*] $($(#[$meta:meta])* $name:ident,)*) => {
         impl SizeConstants for $first {
             $(

-- 
2.55.0

