Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1598CD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CFB10E160;
	Tue,  9 Jun 2026 08:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebHryX1L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7355810E160
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIyBLjFYEcdq26hTEw4e1o0pGzyYnl2jGKUu8fUPoVC4vo5a3axZOFo74iSMqUu6Cqj7gwSfbkb/qQ78aPNvZm4L6WZ3D77dssBUN8gujFFC8f15IJ7IJWwXI9RWbzwELiNCjeb+/zQSf6Ww/RXL80Rf/SPxRjAUawDbBskybGfAZUF2bQR+LgxMFK6fXofQKPRjbHeZg9j5F1Z3dVLF9OdhjKJszUFSrmm1EKJWyoAT1nCAK9Zp9SXbpS++Shh0khyXP7D3CUR5N9TbBpiHi87/5R0MPLoG3rsLQRe4j7T9BwqH1qpy1pIPDFOLyqcG3T3c6XB41l93vBfu7zg3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmCMOmQz3s5FC/dYTgPofAF/zDhoCtloJKYaG5IP+uk=;
 b=mqbYhwMg/FhcOyx7eUTS1CoKRtC0wqw+afFONM4sZQY3iRPvjDOo/9JcNY8tJwMQAK7+5nu7zXL8WmTLzp1vxW3pyrWnn2QjHoCl9OraX4KCjXApnR2eaHBbWPcK0SqJlZL9elGQaxB9AWp4ziMvQ8dYtSJimeNXLDTR0Tj64THZA+i8mJB55pjyqqx8sz/PYA83bkVW5Ba8l1/vAZ8HeDhtivlZOQgnS9vRDce9LTuqMGp7W1jEijRWU2elloci8/RH0K9KmvLAmnwJqD17GfeilIBve9TbVRlVmW0kD7WTS3Bt4r9nfTW9tVFw0ML3ScCBSbw1UCur2Z/rg8cU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmCMOmQz3s5FC/dYTgPofAF/zDhoCtloJKYaG5IP+uk=;
 b=ebHryX1LR4jgxhuzLMpzjX+qdWriy+ImsOmJk8VzM8C+PKdhVK6O/IAZ6x1gBZ9/TdnK4weU1Wk/8o8WcAmbi3N+7cL5+w6j42Robnr/lfPJtjAgKVsxfOQmYHUe9QXb9arvO+ltJE5QR2wIqmX8wyFoAHgCWAtzuuae7Kr5m0i+aJoMx7+vt4fZVX0dQp4Tjop2TLDB0iiCv70k2oy9g8Awj02A8+GCO0mvmjidXFpP9LFvy6da+zR9mHUY+9u4UrWYDuGVxp4SUq8KYeomXQPuoUFTDYwi6FWX/ZS/lPiyryZiiUpL9QKqRKYYLk4G7nd/lgskl5yIY3e8T5DvCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:04:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:04:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 09 Jun 2026 17:03:59 +0900
Subject: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned Gpu
 subobject
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:604:da::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa1b9ed-ce45-403b-bccb-08dec5fdaf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vnP7bb+7P57eK5VSSTFypwM77PSsjHYbsON4t2L7Iy/Jd4QO13K858RV7A0MrnEWJNjwiLxZX3c6GGGlWuHoMdpKq3X5EzR5mZXzGjQgyb4oHvu3J93+WVm7reRT1LU0Oz9arFcgvZ7/7qLBD/gTXapGiaJ6hkqEqApibp6rN50HveRnEhinBhnM8Awv/fuQd0YQNxfsjPwgmdrlPaD5zBsBZlQ55xu19WpAhx2RYmn/7N+FXpiysTCuZJLt3x1yXK53Y4/uzVRgZYg/4sMW1q3aIZQ6n+9Ia4QK43Ehl05Z3GjmB71gGGIvep1LMraFb+GsFMPXm0iQ7nYD0wMv3PlBTlnv8m6I0ZAEmBudqdqOJfTH66Bb7lsIoyKqxB5ONiejE3FWenaDw13vHLRumkkppQwe8jdKoYsKKBBQvyLGrAEZQANU42QNnzM1Cnfz1OtnM7mfYAEgnPqUR63/GTv+w4blNu2fp68GM5bDZIHPz2b60+c8/vKtfpKMirxBI762DB2cOnzjWgxIMouPXCSDF2n8oE6mm4UHdjUC7bzfXDQraGMe4groRDr1YEfXNwNEBs5X/EWcQsxw4orF0IPctOTu0fKWuNQ9NRfFFvQ5KP0HE4uB6TjoBsjce5+j2drSslQkPCa5E1Tc7sSK4QyYqGrH6GC58K0gMts8BhN862IVUhNYHtxy6shcXPxp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS9Eb0tMK1RLVXExWTZUNFZWdHpmajkzMzltOW8rMUIyWEpMbGkvWFRUZ2Zz?=
 =?utf-8?B?Q2dKQzE5YWhMSThtWWMwR2pERjQ1N0ZQaTBnNGVoaG9keVJRUXpkYWxWYXhn?=
 =?utf-8?B?QTZBODRTanVvRHg5Zm42ZWVyby81M1ByekZiNVZQcXVxdXRIWXJKUnA0VmFw?=
 =?utf-8?B?YkhTUDFIVzFSWDI0UHMzOVppTWVzQm4xUXZXLzF4S0gyK1c4NnVsdlJrazk1?=
 =?utf-8?B?QVphZ2tMTUppL0VJNnRhQmVReFZNY0t5SGM1MVZXRWw5KzZ4M0FoQW1EZ0NZ?=
 =?utf-8?B?dWFtSC9yTWE3VEFRY1poM21JakszNXVJYWRDYng2YW1lNjc4MmtKWTN5Sk5G?=
 =?utf-8?B?emczNHg1d0hHWUFjb1VTOWcyRkdEdUxYMS9HM05zazZoeVNLakYzQ1BUd1V0?=
 =?utf-8?B?YWVZaHFZYTd5ZjE1OTA1YVU5TjNDODNLa2hCMmMyeTJ0cHV1OTJWNE9BMW9I?=
 =?utf-8?B?T1kxczB1RG90RndmYnVLeHVBbFpiM3BHUjJ4Mythdm83cjA3cmlDei9Ob1Q1?=
 =?utf-8?B?aHFaZFQ4YTAzWTUwWkJCY1ZiRGJOZkxJS0NTN21DRFYvTWVWNFYzdjRQb2Ft?=
 =?utf-8?B?RnVSdXV4dkpOVHZ1MS8vSjFVWThXdTU0N3k5RXJDOGU2cFA3S0tnVFAxck9Z?=
 =?utf-8?B?d29NMDBKMHA0WU15M2lkMEZuVW8rekZiUUtSMjRPNWZONTNjQlVpeDNDKzdj?=
 =?utf-8?B?WlRBb1hFL1Z4UUhRZ3oxRU5HVnFtZk1TM3A2NFNScmx6VWRjS3JuMG8vcDJV?=
 =?utf-8?B?YVpId1djdG04WTNzQ2xtSUNoZWo4SjRNS3EyQTF6bGpueXZyaDd5ZGRGa0FW?=
 =?utf-8?B?UmxsbzA3aE9xN2s0cWNrRi9pcHJrUXpJN0VSRVFIdzVJU3JSOGNzZVpOYzE5?=
 =?utf-8?B?bjIwZ2dUVXo2bEQzSmlYcFRnOGFaNXBzck9semRvUEhmT2swQnd1SENEWHo5?=
 =?utf-8?B?NXdvMnFMeW1lYk93Q2tBWDlSYUxmRzZjWGVkUkQ4aERSYyt6U1hBZDZPRVZU?=
 =?utf-8?B?MVJwK3VhMFhacGpxelFOS2ZRK0I3ai9INDFNSTVJbE1Hd0RxdCtxeWI1UVYz?=
 =?utf-8?B?K2txQW9aYWlMUFNkOHg1MTZKVGFRUTBoSkFibjNLS25zcUlISDhUNHNKam5H?=
 =?utf-8?B?MjdNVStIOFlHOWhlRFkxK3k0YU1pdWJpK3F3ZjZ4cG5ZdnIyS3poYTZWdjJt?=
 =?utf-8?B?dk50d0g2RUNxVjFzMVovZUswTGtmcDRJczM2ay82dnlBcENFSEk3eTVTL2Fp?=
 =?utf-8?B?ODlSME1EL2RiNy9tRUU5NUdtYzJDajArNFFaZmpKY3JFc3EwckRRdUN5V01o?=
 =?utf-8?B?MzBORnU2ZXU1K0NoS3pOZEdxazZpWU5UMm81Y29FMy93eHZmL2ZObEVLdDBy?=
 =?utf-8?B?VEdZK2sxWGZ0ZCtaRWVFVTJ4NnliRHlGbkM3MGN5WGErRXhUdVJPMG1tY2VR?=
 =?utf-8?B?VS9rRzFCZE9NMnlBUG1qUlRkU0YxL2lCMjhxTW5qN2NZSWZ0ZnBiengvdC9k?=
 =?utf-8?B?TEd3SjRkRzRIMHhFaHY1ZnFEdXFoYXZOajFFTjJ1ZnZLWWpJVC9GR1oyeGVY?=
 =?utf-8?B?YkRKc1cyVllHY1pseEM4aVBOSlpsa3M4RWNBMHhBdzhscCtubVNsRGtTeDRr?=
 =?utf-8?B?eXRiYlpuQU5Kc2xPS3BpcldzZ0hOZDdPNFlnV2I4d1U2OWVkVjZ1QitNUFV6?=
 =?utf-8?B?WlRkbnczQ3UvRjJua3NUUUllSE5ia2M0QThmTC84azF6a2p5anBFZE1YbXJG?=
 =?utf-8?B?U2EreFcxOVAzeG1WR0RxUG9yVWJ4VnRwc3MvblIxeTRpVnJQaFpFNDBFeEpN?=
 =?utf-8?B?TGpXM0JNMkFSY2NZLzI2ZmVhMnYrOHd2VDBCMThvR05aQjhLZGZ5enNuUnN4?=
 =?utf-8?B?dlo5Ris4Q3hCU0xVUS9DUEdYL08ycjFTb3hPbkRWalhyMjFsb25aTmNJSmZF?=
 =?utf-8?B?bTVQd0grZzlFQ3k3TmFzbmp2ZmlOUUtTbmtnNnUxeUllTEd3anBoY0JKcTlM?=
 =?utf-8?B?M3dFTGZ2YTYxRTNNelFPa2YvTjB2KzNWRVpMK2loclVjLzQ3TjQ5UDhINmxB?=
 =?utf-8?B?ODcvNFhTOG5mQS9GTFRRL2VLSjhFSjBudHhvekk3Z0t2OXpoV0dQc0xNYS9a?=
 =?utf-8?B?Ym04V1dXcHFKQk5SRElUTzBxbFF6NUhmWW1DcXJ6NncraElGUnFuUWhid2hT?=
 =?utf-8?B?a2w3K2dvWDlIQTBhZk15UGIzbXJoRjMzRmZsNER6ckxJZW5Vb0pONjd1Zzcy?=
 =?utf-8?B?N1A1RVNaYklJM0ZqR2N2VHJNc01ocHpxRnhTd2tIdGgxaEVCUlp3U0NsTHgw?=
 =?utf-8?B?RUpXOXZTZjU1K0kxUTgrZFBuZW1UbTRQUXJLeTg5UzNkRWpvckkrYmxrUXg3?=
 =?utf-8?Q?QsLUSD+J+VVsi2A2F3vj6bTjEuFEUH9shkQDUiLrwv8Fx?=
X-MS-Exchange-AntiSpam-MessageData-1: xduYh7QKIve3YQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa1b9ed-ce45-403b-bccb-08dec5fdaf6b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:04:09.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1sHEW6FSn1n4VEZskZ/UkdOnR30M7qgsnDjfupbwzqz5fwnrK/fFHLcInQ5vQrxTg1hvt8DaH0ZBXZiP6xQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

`Gpu` currently owns the state needed to unload the GSP directly. This
means that `unload_bundle` has to be the last initialized field: once GSP
boot succeeds, any later initialization failure would leave `Gpu`
partially initialized, and its `PinnedDrop` implementation would not run.

This prevents adding fallible `Gpu` fields that need to query the GSP
after it has booted.

Move the GSP state and unload bundle into a dedicated pinned
`GspResources` object. Once that subobject has been initialized, its
`PinnedDrop` implementation will run even if initialization of a later
`Gpu` field fails, ensuring that the GSP unload sequence is executed.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 86 +++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b3c91731db45..6b3e02c71dee 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -262,35 +262,59 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-/// Structure holding the resources required to operate the GPU.
+/// Self-contained resources to operate and drop the GSP.
 #[pin_data(PinnedDrop)]
-pub(crate) struct Gpu<'gpu> {
+struct GspResources<'gpu> {
     /// Device owning the GPU.
     device: &'gpu device::Device<device::Bound>,
-    spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: Bar0<'gpu>,
-    /// System memory page required for flushing all pending GPU-side memory writes done through
-    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
-    /// GSP runtime data. Temporarily an empty placeholder.
+    /// GSP runtime data.
     #[pin]
     gsp: Gsp,
     /// GSP unload firmware bundle, if any.
     unload_bundle: Option<gsp::UnloadBundle>,
 }
 
+/// Structure holding the resources required to operate the GPU.
+#[pin_data]
+pub(crate) struct Gpu<'gpu> {
+    spec: Spec,
+    /// System memory page required for flushing all pending GPU-side memory writes done through
+    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
+    sysmem_flush: SysmemFlush<'gpu>,
+    /// GSP and its resources.
+    #[pin]
+    gsp_resources: GspResources<'gpu>,
+}
+
+#[pinned_drop]
+impl PinnedDrop for GspResources<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        let this = self.project();
+        let device = *this.device;
+        let bar = *this.bar;
+        let bundle = this.unload_bundle.take();
+
+        let _ = this
+            .gsp
+            .as_ref()
+            .get_ref()
+            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
+            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
+    }
+}
+
 impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new(
         pdev: &'gpu pci::Device<device::Core<'_>>,
         bar: Bar0<'gpu>,
     ) -> impl PinInit<Self, Error> + 'gpu {
         try_pin_init!(Self {
-            device: pdev.as_ref(),
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
@@ -310,38 +334,26 @@ pub(crate) fn new(
 
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
-            gsp_falcon: Falcon::new(
-                pdev.as_ref(),
-                spec.chipset,
-            )
-            .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+            gsp_resources <- try_pin_init!(GspResources {
+                device: pdev.as_ref(),
 
-            sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+                bar,
 
-            gsp <- Gsp::new(pdev),
+                gsp_falcon: Falcon::new(
+                    pdev.as_ref(),
+                    spec.chipset,
+                )
+                .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
 
-            // This member must be initialized last, so the `UnloadBundle` can never be dropped from
-            // outside of the constructed `Gpu`, ensuring that the unload sequence is properly run
-            // in case of failure.
-            unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
-            bar,
+                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+
+                gsp <- Gsp::new(pdev),
+
+                // This member must be initialized last, so the `UnloadBundle` can never be dropped
+                // from outside of the constructed `GspResources`, ensuring that the unload sequence
+                // is properly run in case of failure.
+                unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
+            }),
         })
     }
 }
-
-#[pinned_drop]
-impl PinnedDrop for Gpu<'_> {
-    fn drop(self: Pin<&mut Self>) {
-        let this = self.project();
-        let device = *this.device;
-        let bar = *this.bar;
-        let bundle = this.unload_bundle.take();
-
-        let _ = this
-            .gsp
-            .as_ref()
-            .get_ref()
-            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
-            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
-    }
-}

-- 
2.54.0

