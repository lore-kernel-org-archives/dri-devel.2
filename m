Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EE7EC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864D610E3DD;
	Mon, 23 Mar 2026 11:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8Tq2syZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A46D10E34F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImSUfM2E+a9A19Da8g6qr1XeDgm+USdaGhne6jeVL4IGR4gIAmtxyC8SZG+06Y1BGWK7QUUnoRiIvD17CsMZhd4ddcyAyCDa4j6s1m2bR2vzTq2pW11y98NkVl0oDp3gOLcxGtvEUReGaAT8CuB/aGk9vhjq+htlJSQCXqBSVus63pPM48KUJKe/dBZDJDk9ofQl0cG7nFf2D89KRJFa7081qmg09Kufxx4ZO68QZCa4qyWlvm91O68DdHy8aFaqIpuNZRoVhMvi8iTtN5S//PvloCtqkWc/U/Bfo4aSC43Z7hoN7jztMD9oWMdSMfdcTqkViflWOHUl+n7ki1vchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtoOP7sdNEMzMPtLDiTVY27E03ddYw9W60HrH3dyJPE=;
 b=X1DbMSiwLym0f9oQcm6wYhfxCzFhutJhVVlG2BI/AjtI0DuFP/pRnZ8IWfOc+G/zYRiv37LpuTANnwtssmYKRRdzazszSDhWevSzfyejkLf4MgZOalHLy5vyvJ7p8xy1O+qzZNvCjmBvop8PXdXh3tIvhvcrZsqbKlptyYxKeFn6h/EUBo7QI1HdgSjbWnE7AG6UgRHKkuqOyQXE7JHVrWV5nbwWpFg+l+JM96dtUGOBI5bGg4oSlSVcLgJVWO7eeyfolq3vRBpmsCf5YqdJuJpBjyCpyXH5pYgXKWtH5+NDP5Eq3TFlQOx3SA3N9RYgaGE1kNBDcUyD8uLJpjxJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtoOP7sdNEMzMPtLDiTVY27E03ddYw9W60HrH3dyJPE=;
 b=f8Tq2syZGfcbu+69tRBcob7KrOWHX6X3dR4mj2WhclZBinagjdxzDQCQKyVJaZweaHXTOj6YkyxNsGzrxWIQpM9Uv+repg/yhL5cuuhNRvMX1o2OlW2w8ElxYnVKuNAkbspZQ1j6O/fruzSdL+B9EAY2az2GAig5Dmt5us0XcHOhlzkuC9yM/TpRgRVSDMiz6qNwJ5WnoQZFHrUOlFW+cpamv75pjx9gQElP/7ffU46oJuK6Nscn4m2gcwShctUsEa3UOC7YVPCjrLHEKDAwlePTTJW1R0R+ODChsnSoTufRYYVovMEXlaYyOxkSQ+/JTmtG4vXaqEvmk/VWd89JYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:07:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:07:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:36 +0900
Subject: [PATCH v3 01/10] gpu: nova-core: convert PMC registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-1-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 3370374d-b85f-43d5-95e3-08de88cc6d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2GMR7UCU5bzmPC9+Lmd73+KmhKlCodnTtqWM2KEUv2JfRgJssOFbW0eS35SB1TkUEmLvD8gRT7wrn6LSui6d/Una5qt/qaxqaYOsVbLcKQCMlteP143PkYAbv0CkzmLxIq7W8zX0CNMZ/ACtc9l32RCPD2LWyX/eZqC7gyP0sV1Sy9bJUOgshqhzwtr+tVTAMwCmPHzMfGIobYNTJoho7/I9DkQhhgfxo79oVOim2QO6M0/VgdeH5SUWlZanOis2U8Q1w/FjQVBXV5xPmX0EGAYZDwDl3Y9cSjOugH/fYlrAameYfr0rr/zgGn/nT7m8TLEGn4aZXt/uRV5D469DaazjyBrBLx9UbHDqdscXjH6Dv5587gMHCHz2BZXDGwAHa6Jfy11ox1IxCSAZpfxaEdmQym7IoaH/gYaNHGuPC35Wpbm0pXbM/tGbPVnS+fKzebUjTOFEnfKVYXouIcpUYBVwhKQF3kLDNXMGClE7xgdoeSNyLqmyuMzuuM9rxa8gYqsa0e5AGgS5vOqgrWL8xwbvXDJRO7ETqOZz3r8/PpXxaRYPYZswRTJHUMYx3YPYlXJmYB/XnMRH/rUtsNmycTcVUbrhOOb1r6NkkoAtWxD6YftbXsKYRH7zIzOeW2fFqOqf3gTT8P0Zrqflaf/z/zcnwTn+xW9OJCnn/wqMVCoNDc+6F7OlhbjVaTMLUkbIAIw8WZkJCXB204WJ76UcfjaMKAVVki+Kh4Pn4oI88Y58Hjelfvvv466A+6dfV7hKMoocUCl9l168w10xR8k1rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjF6dDJmeUdrd3ZBQjVxVFg5ZUJpeWxQeUZFVWhEOGdNaU5NUlliU1g5Z0tp?=
 =?utf-8?B?WXNPTTk1Vmw1d3dLQ0xEeU9tNXRCWHZKQ0d0L2tkVm5va3F6OU41R2QvRDAv?=
 =?utf-8?B?RUUxaFhLNDlsZXhkTzJpbXVWbHYzUHA4c1ZyTkJoYXBscDlKQlU1SDYvUDZ0?=
 =?utf-8?B?NXlmSWVuSEV6TkFxVHgyQngwemxmcmpmamFWTGRmRk1pVnUyWmppdXdBUlh5?=
 =?utf-8?B?bDgyYThJNXNBSGpJRldNYWRaVk5MSS9wUloxVG93ak1WZW9MT0R4NjV3SHBU?=
 =?utf-8?B?aVdpSVN4UkkwTU15RVJ3VUpkQ0FaNE9BcXdpbS9yblZUbDJxY3ZBWkhEQi9S?=
 =?utf-8?B?S0NxRDgrQlpiL2dZVDJpbTFTQ0RjcW5VV3A3eW9tR3RHck1oR01iRDBFZktT?=
 =?utf-8?B?VXBOSVhLM1IwbHczVXpva2QyNWNScTNidkcxSm9GeGEyNlZhYmRuZFM5M0la?=
 =?utf-8?B?VTJkWGVMa0ZvNCtocU8zc3N4RmdDN3p0MDgwNmt2Wnk2bDhTL0JZTVdNSUdT?=
 =?utf-8?B?eGMxanF5V3VUY0J3QVhJVDlGZFI5OU9PQUVOUTYxUXRaSStPaDZKcHpac0Qx?=
 =?utf-8?B?Tk5QR1VaZHhNVE4zdU8vNzhmdHUycU9SVHROQ0ZHY21jV0k4eThqcXM1SVVi?=
 =?utf-8?B?d1pEcHVucVdhTTIvU2xCdTJxengwWlF4RXVkdTBsWkc3bllZeWQzVW1naTFs?=
 =?utf-8?B?U0lEVEhOVmwxdU1ZY3RDYzdoUjAzcDF4c3VycXFxaGh1WTA3dkhFMC9vaGN6?=
 =?utf-8?B?Yk1ZK20zTG45NlN2RHAxWloyU25lWmJ3T25FWGl4RU50U0pEMXFGWWRTbERn?=
 =?utf-8?B?UHFnZithd1dLb2xTU0xDcDl5VzgvZlZidkF1YzUvY0FOcEF5emEvaFF3RTJM?=
 =?utf-8?B?dkZKVGtUWTQ2T0xsMmVrL1ZSeHJNUFZMUXhSSklQenlKWGtqL2pUbmtta2Zy?=
 =?utf-8?B?dDFHLytsRkNoUmFVM2VMa01zekFJMDVZL29vMkhaanlzQUpmcnhycFJlRlJP?=
 =?utf-8?B?K25sNU1ZMDFqZC9LQTBIQ0k5VCtjb01BYTlVUlZvOTEreXcrR1gyZEtZOFVk?=
 =?utf-8?B?WFNJS0J4cnhpRmJvZzFGT25WZEowL2tMNWhhQTZUN0Rrekl5S25jODc2OVVn?=
 =?utf-8?B?amVPNXdTUEZPbkZNSGgwR1V0UU9RVER5QWR5YkxhbndUOVJVdy80QUhYbWg2?=
 =?utf-8?B?aWdTNHp2Y1Y5SS9zRXR5MFR0d1h0TVBVUnJ6bnBpRzR1RTBKekRRTWE0dEd0?=
 =?utf-8?B?Ukh2eW1lYm9HYjdDbzlWSTMxVFFTWEh0eStpSzFiYW9WMUxNcW9VU3R4SnQw?=
 =?utf-8?B?MUtmb29aSDNobTdRbTNuUnVQUFMwdlZmSmRVT2ZOOWR6OFVqY3E0am11Y2pH?=
 =?utf-8?B?Nnp6T0FPb2xVMWZRUmoyT1BEYUwzM2Yrcm1zUGdlVVBsZ21JY0MwYkxhNnJT?=
 =?utf-8?B?Z1h3VHNGcGRMTlUyTkR4c2NtODJuZVphVXhPRGlQWGR5Z2dRa3RoUUZ3NHpm?=
 =?utf-8?B?a3pMNGRSWFBrc2RLWmg2cm9WajBVclVZUXcwb2s3OUIvOWpzYlUxM05hS2tZ?=
 =?utf-8?B?VzEwSGZDaXVXUHF6Q0sxNDJUaVBOVVV2UkFhS3pXUzFNM2c4RHdBdGdTNjdJ?=
 =?utf-8?B?aFNTOFBpNHgrRy9mZldycDY1OWZQcmprc3Y0S0dMTkZzQ3Z1ODYzMjBiVUpG?=
 =?utf-8?B?K05kMUpoMmdGQWtZaW10K0hFa3g3V2tOcDNwZERtSGdDci9hR1pUOXE3N3dU?=
 =?utf-8?B?cEViNWVRWDhONnk1Zk0xZ1kxblVINDNVUk5FRi80eFpJQlBrZ1l4NDcyUVJE?=
 =?utf-8?B?cnZYVkZ4QmJ1T0FQbkUxUXkrcitrVER4U2JUVHN4NmtUbVhFWVpDQjBtWW1M?=
 =?utf-8?B?MVJUUlpmQmFuQ2JFd0VmZFMvd3UyOHZxNzdoM2Q3Y0FJNTdjalRjL1VsT3Bn?=
 =?utf-8?B?ejBDZ04yNXpJWTRtREJVejMyY1gvY1BVWnlZOUpnNzc5RXNGVHZTdWx0NTRP?=
 =?utf-8?B?NWlTK2gxTXdhTFVUeUFBUWVVeXBBcVhHeWxTWEhia0VxbVpVcHFtTDdkQllT?=
 =?utf-8?B?azdSSTkxS3hFYmdjLzFiVkdyZVY4OFlOVWk4TTR1UzBkRmhzS2lWZWN6cVR6?=
 =?utf-8?B?MHYydnpSOGVadHpaQXJSUHg4ZHRJRGVXcG1udHBMb2tCWFcyUnptMjc1RGxZ?=
 =?utf-8?B?aWkyZXVPcmlqOFJHVzFNN0U1a1FDMDM2WjRaZ1JidkVoand4cElqTjRWb2dw?=
 =?utf-8?B?cG1pSElaMkZpVWlzeFg0N2hvL044M1JyK1lseStQeXZCbDFOVzJZZ3ZxZnVi?=
 =?utf-8?B?Ynl6aWpodFRHL20wR2JCWHp2Rm81d1EzUmFvRXFmUlJscmNENFV0QmQzYytK?=
 =?utf-8?Q?9qAz2JUoQClUKPz4lJBV/gzzmK0xLkjUbWui6+CfPb5Br?=
X-MS-Exchange-AntiSpam-MessageData-1: AmlLZlhyUBCDsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3370374d-b85f-43d5-95e3-08de88cc6d56
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:07:52.3608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li6AjEKTkwDAjKQydqTttOk1pd+W4ttGnCK4Qie96JXQsK1elK87hbmfs2p3d5Ln43jXBLoxG3NfQCWOmf6fMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

Convert all PMC registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs |  7 ++++--
 drivers/gpu/nova-core/gpu.rs    | 37 +++++++++++++++---------------
 drivers/gpu/nova-core/regs.rs   | 50 ++++++++++++++++++++++++++---------------
 3 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 7097a206ec3c..5a4f7fc85160 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -13,7 +13,10 @@
         DmaAddress,
         DmaMask, //
     },
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
             .write(bar, &E::ID);
 
         Ok(())
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8579d632e717..cb549c8b254f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,6 +4,8 @@
     device,
     devres::Devres,
     fmt,
+    io::Io,
+    num::Bounded,
     pci,
     prelude::*,
     sync::Arc, //
@@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 /// Enum representation of the GPU generation.
-///
-/// TODO: remove the `Default` trait implementation, and the `#[default]`
-/// attribute, once the register!() macro (which creates Architecture items) no
-/// longer requires it for read-only fields.
-#[derive(fmt::Debug, Default, Copy, Clone)]
-#[repr(u8)]
+#[derive(fmt::Debug, Copy, Clone)]
 pub(crate) enum Architecture {
-    #[default]
     Turing = 0x16,
     Ampere = 0x17,
     Ada = 0x19,
 }
 
-impl TryFrom<u8> for Architecture {
+impl TryFrom<Bounded<u32, 6>> for Architecture {
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
+        match u8::from(value) {
             0x16 => Ok(Self::Turing),
             0x17 => Ok(Self::Ampere),
             0x19 => Ok(Self::Ada),
@@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-impl From<Architecture> for u8 {
+impl From<Architecture> for Bounded<u32, 6> {
     fn from(value: Architecture) -> Self {
-        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
-        value as u8
+        match value {
+            Architecture::Turing => Bounded::<u32, _>::new::<0x16>(),
+            Architecture::Ampere => Bounded::<u32, _>::new::<0x17>(),
+            Architecture::Ada => Bounded::<u32, _>::new::<0x19>(),
+        }
     }
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: Bounded<u8, 4>,
+    minor: Bounded<u8, 4>,
 }
 
 impl From<regs::NV_PMC_BOOT_42> for Revision {
     fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
@@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result<Spec> {
         //     from an earlier (pre-Fermi) era, and then using boot42 to precisely identify the GPU.
         //     Somewhere in the Rubin timeframe, boot0 will no longer have space to add new GPU IDs.
 
-        let boot0 = regs::NV_PMC_BOOT_0::read(bar);
+        let boot0 = bar.read(regs::NV_PMC_BOOT_0);
 
         if boot0.is_older_than_fermi() {
             return Err(ENODEV);
         }
 
-        let boot42 = regs::NV_PMC_BOOT_42::read(bar);
+        let boot42 = bar.read(regs::NV_PMC_BOOT_42);
         Spec::try_from(boot42).inspect_err(|_| {
             dev_err!(dev, "Unsupported chipset: {}\n", boot42);
         })
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 53f412f0ca32..58fb807605dd 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -8,6 +8,7 @@
 pub(crate) mod macros;
 
 use kernel::{
+    io,
     prelude::*,
     time, //
 };
@@ -37,18 +38,38 @@
 
 // PMC
 
-register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
-});
+io::register! {
+    /// Basic revision information about the GPU.
+    pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
+        /// Lower bits of the architecture.
+        28:24   architecture_0;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// MSB of the architecture.
+        8:8     architecture_1;
+        /// Major revision of the chip.
+        7:4     major_revision;
+        /// Minor revision of the chip.
+        3:0     minor_revision;
+    }
+
+    /// Extended architecture information.
+    pub(crate) NV_PMC_BOOT_42(u32) @ 0x00000a00 {
+        /// Architecture value.
+        29:24   architecture ?=> Architecture;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// Major revision of the chip.
+        19:16   major_revision;
+        /// Minor revision of the chip.
+        15:12   minor_revision;
+    }
+}
 
 impl NV_PMC_BOOT_0 {
     pub(crate) fn is_older_than_fermi(self) -> bool {
         // From https://github.com/NVIDIA/open-gpu-doc/tree/master/manuals :
-        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u8 = 0xc;
+        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u32 = 0xc;
 
         // Older chips left arch1 zeroed out. That, combined with an arch0 value that is less than
         // GF100, means "older than Fermi".
@@ -56,13 +77,6 @@ pub(crate) fn is_older_than_fermi(self) -> bool {
     }
 }
 
-register!(NV_PMC_BOOT_42 @ 0x00000a00, "Extended architecture information" {
-    15:12   minor_revision as u8, "Minor revision of the chip";
-    19:16   major_revision as u8, "Major revision of the chip";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    29:24   architecture as u8 ?=> Architecture, "Architecture value";
-});
-
 impl NV_PMC_BOOT_42 {
     /// Combines `architecture` and `implementation` to obtain a code unique to the chipset.
     pub(crate) fn chipset(self) -> Result<Chipset> {
@@ -76,8 +90,8 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
     /// Returns the raw architecture value from the register.
     fn architecture_raw(self) -> u8 {
-        ((self.0 >> Self::ARCHITECTURE_RANGE.start()) & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1))
-            as u8
+        ((self.into_raw() >> Self::ARCHITECTURE_RANGE.start())
+            & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1)) as u8
     }
 }
 
@@ -86,7 +100,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
         write!(
             f,
             "boot42 = 0x{:08x} (architecture 0x{:x}, implementation 0x{:x})",
-            self.0,
+            self.inner,
             self.architecture_raw(),
             self.implementation()
         )

-- 
2.53.0

