Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1D2C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A5710EB86;
	Tue,  7 Jul 2026 07:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z9GPKCBl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0091010EB86
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lihUxS6gRl7NdUeYYi/hotXsqVpN0wzvh3npF6s5psQWgj/Tpljw6YpAAz43JkpzhL1kriEyBdsKyvftoSoOPYbR66UJa++k90DPox+FWWn/ir9UsO9KxdadVNngDRILG+AEAxLrMtmaDXQe5kVn7tU3ogNjyi7iVAV4C/eWZNICEzvHgrhPvqCtrlthO9/JlCLpxyzYj0sYSpQI15BbYdaRbfgdzSXng4zmsMI13YZqwF/wSgC0x35M0xoLWRclmcPiZKZvd+rF421iGkbM8IcKESUc3y07rpSIxFIDYZQSe8IsM/S/F4eF81GbMiRY3Wn4A68bbPFHChKO+OTjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiyPB/P2AZ/081mG2ZmMwKAqIcDjVshulsFQMtLy2Gc=;
 b=r15jJ9jT1Dx37Bxit5P4abrlvYWp/QWk3QXKsBjzfsVMwoJBxC6S+UePJ3euEErY8yPcrdBfolbolE2U557jBw0vGYfi/rxZ5tIH08EuJlDtD1g5DOsxSzNqCDh4XwJfkAsb3Qbt1UmRhCPpRpxu4rCfw1c9D0yay2GhNNREkQZFIsgvNbF9Bqz39efTu6DhDxf8jAc3tNy3d6gypuT+6Goq7bDhDV84O+5LLsFpUCwu6alLHmHHSLUyKjlCYp7O8yPZYvhVl1ZgUKgHSsLr648C6Al+x9rnsnJYg8uyvhliF92Nlk3i+I/HrIzHn3iTbF2gPVv+swJk9wCMSQ3Nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiyPB/P2AZ/081mG2ZmMwKAqIcDjVshulsFQMtLy2Gc=;
 b=Z9GPKCBlS5UNa+IPFFVdHgcw6xtAzxa6VNjUeW/TbqKf9Iv52drOqT4iqcxAgWU0wWlTpuFA/JFnDxOHgf2qpmXdrrptsspFmruih+lKcBjWRPbzt/kP1656GPjXZvx9eHOg5IISfSLgSz+7pmyGW84YbmEJsImzaatIvFFb+dEzrVBCXykhkCG4OVN5EXMSGf+5HoebmUxvFBHQJXOUawjovZ6FkRX06HRlb2o3CPF3b53DE2M+5D6xQBrGUjoRL51kgq5j7gJ3xbnW3hcykou8Zyqtn6o+u5SyTb9dmJASWR7ZUeibcx5pFtc/3ITq9nIKcBszHPXi2mwet7NYGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:43 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:46 +0900
Subject: [PATCH v5 13/13] gpu: nova-core: store Fsp instance in Gpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-13-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d86f07-8252-4a26-5bc2-08dedbf88974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: yLnsV5AYfr46THajNe9xbEgyP1V9o9uJ5u/PYyzglZHPgi3GjNd4Sr5JBs+4zOhG/DWpxA0UjfjFXXm9SIa0YRcDl/+oCUmgo8FG5VxsHdnOO5j0BZPU4TjfZvQPNSf1coSeqIgbdyOb2Wfv3tTh8OEZlY0Q8OG2IawDukZor2wIbgvLE/0t77AuK1fDdycRt02ybDKUFTU04w/SI3TYKzaaVfUnFQSWgAszADHVEhD9ba1tFFYzgW25ffjrauoIK5d/lMpE+i0/y383iKxWaO9PvlBi0lGA/jjBgSxkjygOKhh+IWGdUcyE8gHshJZSUWgyil1sF3uABDRvzE8nv9e6uV+j4m6sG1gUKWs5Yc19LpfBqIIyog7UHX+9bn3O8bwlEQqCTBh1F/vEI5bj5FiRI7Smcg4Y8Y2+QILQgyr+lMEcGpP63w3QCZkrFmG9vPtDNKYQbDxgIVpxI5uK8eFmTgbZRL3I4uXfGkvrAAYc8AS5E50rv5c+fL5IYmWJt4Gm/bHfcm26GwN+zeG0STmWxL56FcGQBcufGnHId0auDtok13+ddrGFjnvOr2xBQm0evBFlmnj6Dlpk5Eg8IpV42JXQyYcp79sgDubVgcdoZIC0MhSCTRNzBJsEKW62DE3xPZQ948T+Fcv4QZGihe4oYRS+HI+5MVRY/RSbGSdgn36BEzYKOpSChChU36Yb0+bNaBfH/oBu7uOMsQtRuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1NlV1Z5S1U0M3dSOFVrWGtpam9EdmxlRGhqQUtvYkwzMWc2cW9Sa0c1clZC?=
 =?utf-8?B?ak5TWnVtdTBSN0IzdVVsdUUzRW1rbHgxY0ZuUU1wS3p4M2V2UVp6OXV1eFND?=
 =?utf-8?B?NldsWkQ2QmJqZGkrOXZBS0w1OTl0bFRTaU9vUW5iU2RaT2pLUHJoc2hxcVhT?=
 =?utf-8?B?bVB4M0xOSVFnd3BZTDU4RWJWK0hWVkJYeVNxem5HdVcwVWY5eWhoejlPcjBV?=
 =?utf-8?B?YUVROGVyaFl3K1BjVXRUVTdjQVY1RG1Gbjk0RmgyUjJvNno3b2FKV1BILzhv?=
 =?utf-8?B?LzNHVTdYTnpWNXZ0NG9WMi8vWi9qLzZpZitwNHpwT2pNK2MwNEFmYURrZTBh?=
 =?utf-8?B?b3cvV2JBa3hhN1BSUlU2eXE0K0tBMHFUaDM5MkV0NFNqTVRXa25OR00xTzdV?=
 =?utf-8?B?bGpSY01WMVl5QTludjEvNU1KYWVTV2pQNHhjYUpaSjlpbklodC9UTWhzWEp1?=
 =?utf-8?B?ZHZqT3dSeEtzMzJnVmNKT1o5WHVkczBGWDEzaE0wT1RWUmpHa0gwMVJFNEda?=
 =?utf-8?B?R2ppRHluSXFSQk5NZnFoTjJrRW1xMHJNcnlxcHJNUStiZExwb1hnMzUyUWZG?=
 =?utf-8?B?YmxJL2YzWWhDVTJLbzlDK3VvVW9mMGI2M0dWY013bmZxWVJ6WkY5cHFiMy9J?=
 =?utf-8?B?YjR4QU1vdlJiOUtvRnhGdE93SzVmOXM2SXQwWjdvYTBiMXFZaU94UDk0aUpG?=
 =?utf-8?B?NURrSkduNmxsNHZ3ZSsvUS9uQmZWQi9MQ2F2Zkd5azdWWkJDWTdzbHFoNlVX?=
 =?utf-8?B?R2JsTlFBWHZwVGZzbTBHQTVjNjlhc1pXbTc4cUN2aC9LdEtYejBkRStKSFha?=
 =?utf-8?B?d1RVUzVUUkdOdzBrWkJaZ29wNDh2V2N3SDhzclBpWnc0YlR6bHRFWW9jdlFz?=
 =?utf-8?B?RnVkTHF3UmwwTkdXV2J5dWZyeFh1OVBxaXBMY1RXQ3lGZGplVG5BRFpuaUpO?=
 =?utf-8?B?dW9pUkhtbldPVGJVVVNKTzRZdGNNejNHWGdTZ0wwbUhjaGFNOUVleWhnUzlo?=
 =?utf-8?B?VEJIUGp4TkFhYjZ5RlE4cnhSV3g3YjNRenB4Vm9URzB0eDdMeFJNcjdOdURL?=
 =?utf-8?B?MWV0Wngwc3JnS2VMNmkrbFlxL2h2VThPazZLWjM3TkY0clkrRWF2VFY1ekRq?=
 =?utf-8?B?Wm5MRjdUY0pNT3VEUUp3TmppaHA1RjViTHl2VGJxaTQ2NnhmSVVLNUI1M3hR?=
 =?utf-8?B?VDlJTTZHM0E0Yjl3UWtxUUZEeXIweklFcGZiYkUzbSsvSktxRFhnbi9BbWpQ?=
 =?utf-8?B?RktVbVhTRkEwTXB0aytJNzM1T1k2ak9EMlNhaGd1U1pyNDJDU21kODdXSFhw?=
 =?utf-8?B?c0plSWJWWkR0Z1VQZHltYzh2aTh6VStIcDgwMzFLK2pIWU1TdUtUOG5YNzg2?=
 =?utf-8?B?dHd2amYzeE1VZ1ZWYmhDMWxvcmRpc0J0eURlSnQxeUFoUjBsTzl0VitiTmI1?=
 =?utf-8?B?b2VZNi9YVGxaQ1VudFdCTjJXc1lmV1o0NHVudnNORWN1YkQyTk4wMzJab1hF?=
 =?utf-8?B?b3lBUlQvMDBTUG5DWWF6cDY0WEp6dnZUb1hKblU5RWs4SDBaVm96S3piMVk0?=
 =?utf-8?B?OEpYcXBPOGNrdkRIcldrNnBEUlpFNWpYb0YvMkR0bFhGUlhNQi9sdkgyWVk5?=
 =?utf-8?B?cjhGOUdaNjZHZ1hBSFUyUG5yWmVSSXgwOEw0Y0V6T21pTG1SalF2bTd6MmxV?=
 =?utf-8?B?QnN1dE1QcStQUGxKTzNodHlzSEJnTUx6Ty8zRkxwbVJjTnFJRERKRG1VRGVw?=
 =?utf-8?B?QzVnekd3UTNualJMSzIwODFVK29MOGdBaEsySnBWa2ZYTXdNbUJta3FPTEJ4?=
 =?utf-8?B?U3dQTk00OGI1dnNnR2JjcEZyeDRwdWhET3N1cFAzWjJPa3ZYTmVldUNHb3Ry?=
 =?utf-8?B?RmV0bkdtMWRLVTMzNHZXZUxwUDAvQm44TDFpVEJlNFpUR29KNDZEOUVSWnpW?=
 =?utf-8?B?THFUSlFYVkt2TWlLZTZsa01xN2N0MWtwNURMR1pQeWZjeVM5VzRObjRuc2w2?=
 =?utf-8?B?ZDRUVXlCWjVHaEZHQitQdGRKSDVyb2dGc2VCdXNRNEo0NnI2aThiTExWaysy?=
 =?utf-8?B?LzlrS1NnSVA1YTVCNmI4WFZqcXNGdVNNU3pKQzU1MkMvVE83ZlZRN3lWMWNo?=
 =?utf-8?B?ajcxeWwrbFRINlNxUW9lSURMazQxbkR2dTFOQmtLVEttdGRadXh2Q0pMM012?=
 =?utf-8?B?cUg0UkxhRTlxRG5ZaU4yRmtNdEJNVjZhQmV0cUttTnQ1T3JpeXh1M2RBQlQx?=
 =?utf-8?B?RXZLMDlGK0NZc2RLK0F0dDQzVmhTclFpcCs2VDNBcUpGVWl1UVdGMTFLajBX?=
 =?utf-8?B?YUtGUXhJbWxKNTVvMlByeFdBdElGYUdxTVBiMGJqTlgySlo4UFdEN0R3ZHBQ?=
 =?utf-8?Q?X062ynROnUKx7B+bWjrRrTHKK56f11pOcJyzH+fcHBbG2?=
X-MS-Exchange-AntiSpam-MessageData-1: 5POU8BK3CmyTZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d86f07-8252-4a26-5bc2-08dedbf88974
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:43.8890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIArqsyCPBp6cEAle7KQUtbrrr+C/RDES0QoWK/LXr0ohYOt/z9W9y1fQrdmXEfPEm7zVqlNL3AbBIHAwKYy6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

The `Fsp` instance was only used in the Hopper+ boot path, and
consequently built locally (and immediately dropped) in it.

This worked well as a temporary measure, but the FSP is a GPU
sub-device, so its lifetime should match the GPU rather than a single
boot invocation.

It will also be needed in other parts of the driver, for instance vGPU.

Thus, create the `Fsp` instance in the `Gpu` constructor and store it
there, passing it to the GSP boot as a mutable reference using
`GspBootContext`. This makes the `Fsp` available even after the GSP is
booted.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 21 +++++++++++++++++++--
 drivers/gpu/nova-core/gpu.rs           |  9 +++++++++
 drivers/gpu/nova-core/gsp.rs           |  2 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  8 ++------
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index f0c595175c9c..74ea20258b07 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -231,20 +231,37 @@ pub(crate) struct Fsp<'a> {
 }
 
 impl<'a> Fsp<'a> {
+    /// Attempts to create a `Fsp` instance.
+    ///
+    /// This can involve waiting for FSP secure boot completion, but should be instantaneous in
+    /// practice.
+    ///
+    /// If `chipset` doesn't support FSP, `Ok(None)` is returned.
+    pub(crate) fn try_new(
+        dev: &'a device::Device<device::Bound>,
+        bar: Bar0<'a>,
+        chipset: Chipset,
+    ) -> Result<Option<Self>> {
+        match hal::fsp_hal(chipset) {
+            None => Ok(None),
+            Some(hal) => Self::wait_secure_boot(dev, bar, chipset, hal).map(Option::Some),
+        }
+    }
+
     /// Waits for FSP secure boot completion, then returns the [`Fsp`] interface.
     ///
     /// Polls the thermal scratch register until FSP signals boot completion or the timeout
     /// elapses. Returning an [`Fsp`] only on success guarantees, at the API level, that the
     /// interface is not used before secure boot has completed.
-    pub(crate) fn wait_secure_boot(
+    fn wait_secure_boot(
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
         chipset: Chipset,
+        hal: &'static dyn hal::FspHal,
     ) -> Result<Fsp<'a>> {
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 5000;
 
-        let hal = hal::fsp_hal(chipset).ok_or(ENOTSUPP)?;
         let falcon = Falcon::<FspEngine>::new(dev, chipset, bar)?;
         let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fc90069bc2fe..442c0979f9c6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -22,6 +22,7 @@
         Falcon, //
     },
     fb::SysmemFlush,
+    fsp::Fsp,
     gsp::{
         self,
         commands::GetGspStaticInfoReply,
@@ -262,6 +263,10 @@ struct GspResources<'gpu> {
     gsp_falcon: Falcon<'gpu, GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<'gpu, Sec2Falcon>,
+    /// FSP instance, if on an arch that supports it.
+    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
+    // generic against them.
+    fsp: Option<Fsp<'gpu>>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -305,6 +310,7 @@ fn drop(self: Pin<&mut Self>) {
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
+                    fsp: this.fsp.as_mut(),
                 },
                 bundle,
             )
@@ -356,6 +362,8 @@ pub(crate) fn new(
 
                 sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
+                fsp: Fsp::try_new(dev, bar, spec.chipset)?,
+
                 gsp <- Gsp::new(pdev),
 
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
@@ -367,6 +375,7 @@ pub(crate) fn new(
                     chipset: spec.chipset,
                     gsp_falcon,
                     sec2_falcon,
+                    fsp: fsp.as_mut(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 9f055a0d6cb9..d89cc3ba7c72 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -39,6 +39,7 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
+    fsp::Fsp,
     gpu::Chipset,
     gsp::{
         cmdq::Cmdq,
@@ -65,6 +66,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
     pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
+    pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
 }
 
 impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index be531df8680b..d1c4f6104701 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -16,10 +16,7 @@
         Falcon, //
     },
     fb::FbLayout,
-    fsp::{
-        FmcBootArgs,
-        Fsp, //
-    },
+    fsp::FmcBootArgs,
     gsp::{
         hal::{
             GspHal,
@@ -142,7 +139,6 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
-        let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
@@ -150,7 +146,7 @@ fn boot(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
+        let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
 
         let args = FmcBootArgs::new(
             dev,

-- 
2.55.0

