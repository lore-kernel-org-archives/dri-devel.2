Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7440C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3454910E89A;
	Mon, 29 Jun 2026 12:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7tnqt5Z";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E34910E89C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0H4gUGdg/id/8WcRom9r41yYHnLKudb4Ac9/4X63bPs8T6TjhUR4RrTSlfhWEnpwDDbaK92jbSAuhSm6I6yYI0UB8p2Q+dnwjB13oBZbgbHPz9Y1Tl9UlVc9SPwxP78yrtRxK6AzCiCyfFNuDGl8zQzIg0s4rXwaDioMtBHgJqkiyl23aT+LsnvlM0ugp/BOxxXzcCyxc2KymxhaF5fjY9o3r2AgdcQthpW5zTwOPuzzpQYI9n1+bbb4hVAH8mwt6961K8aGSsE6oHAzaJNC7iWLrpNjAAJDgGxGEuNZzUgbWaQf023R85dtKxF70agvaOfTPOFA5fdy6Dmc0LT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykKB1VyM8q/Rq+2Bg0VHoKuDrSyWZZDYFDQOGbZnCm8=;
 b=sYvoaTLdqixkLwk2/qUgd48HeF+x9NfvoUwxWDKm6FA9IR9XTso6Q46RmQIjM04jTXPutD5dST4dqOYJTx4GGuCE4czBjX3XNGbfWcMSYGtJWdzWJMPZD3eJsgR3lBn7ZD6K7d3IMbChgg01ReWm8Lv+289tkuLWrjEofTl11f3BkLYgp5ihNsJmvV2niIobtG3olTxxtHk75COwotHAJMa6uu/jei66Wb6HFwR0BqJtl68FaLZ1aRZ3qa9UDJPQzxDFRk7rBumueNmEN609NjUyMdXTTDyxn/yRng4oRsFLZyLd7JjAZjvttCJWrrFl3NEnAMo1lrBchBadMkwJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykKB1VyM8q/Rq+2Bg0VHoKuDrSyWZZDYFDQOGbZnCm8=;
 b=V7tnqt5ZsF8sIWcsAEVVXMUy0nKcRyxNGGXG3CpCpjS5CjzDLfTVNcAdbKzoISslhlizwO0vFvP1POhTyb2hXaJoOYPKWeB5kDjgiSMUoZglk0rhKRYkp4wFhmykLtcyHI/4dLvFF/3mEGCjACH1qo4es0qmfiaURhGyIR8VPxnqHQVBV4Z1uNaoDljK9gKgKyuw8GxtIOTmC7BhR+xbLgEo6QZlvpdc2UA8XsJ4nj6fE3x1vHoCoj4cEuc8VTPp9p1tM9i+LRI3vLupS/9WZqjolS5etiS22vfCybLLeomezQv8rTPngl4m+M3u27Lt3BfbGpDwSPQ7sN6d1gn1jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:42 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:55 +0900
Subject: [PATCH v3 12/12] gpu: nova-core: store Fsp instance in Gpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-12-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 164fbe06-c860-4e40-2f06-08ded5da8392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|3023799007|22082099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 5WElPV2bnaFHyMyI8jtjIc+UrIIsv4hC0OYz+Dchn5NuDqQ5t2b2eJGpDzzSomqo96LF70iM0M0v68xww08zxd8NlEKBwwiF0xF3nOili4FOOXx4SQCFwmf7qlB44CIK/pjZmU9MDInLA5Bk4c1Gfqlme+kUSxu/17GeKO6CB5XJoce2rc6ynJkTOAnNb2/ZgO2ffP0sPPKqC883bKlqyRVwIdvr6PiVogPPhuwiKeA9DAX/0y7jh3xVZKNnlguNBqfjMJRQIyUDqplMVjZz85zZHdsrN//XTgj9XBElvz9diEIsAoaerNqbCZwdLsDqT7fVhz6nBpC7knn3/lTn6vcHHlpl6HmGGtgx6JiRovEmOLF+oCxzpDmjb+zQ9b91J1B3Eg3uZ3CHZ/JgqPp1jIh9nJYU4cUYzzGCzfBAdi32a8GFVY9ZvafAqFp/QPLyDl2SK22GSNhAoG5nz7Gy3a0VzVrTRp+0CCIBWNX7gf7W9qxbt98/gwtEDS3X9KjOF/t1giQKf7VyRgBGYX4Cc3387MlxoTllTt7qVv3AcFMLkJ3UieKK/amhmthKKOm2rqR+uUpz0fsTmDkFWhR1MM18aZPQGiPNceZHLNZIzL1oOHh3Wjd27VJW9EVAJr3j2sWPVgyjMT7br1nVni6kIDN9wFGuZyA0DFKXAph+z6pwzrmbcFYwwKjVIm5TFiBu00B2kQ7cHSEpSTBbwQPeqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(3023799007)(22082099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdsMVIzaUl6Y1N4L1hMMmx5K0hmOG9KSmNxa2t3RURpaFduekJWV0I0b1RM?=
 =?utf-8?B?TVFsMnFrOEEvL2h3QW5LVU9lTE1idjZjV1dRN0ZNaUVzeE9ITmJRbkU2S1pS?=
 =?utf-8?B?MEc2YWJ0WWlwVW1lZHhVeUxYT0JxWDdNT3pGNWxiS2RHcUJsV1Z0SE9rYVd5?=
 =?utf-8?B?cHlxWGNONGpvb2FoU2kremZ5YW1BSVFqbjNYbGNKWjhjZm5KQTMrYit0M2xx?=
 =?utf-8?B?Qmt3bXlMZVJVNlkwQlJiOEZFRDIrZ1JBKzUxSi93OVc1UTV5MkV2aG1rMzY0?=
 =?utf-8?B?cFdwQ0p4aEhpYWswT2R1S2ZBVDBuRXJCaXhrMnlJOFBxRWpnSEYwSnlJREQ1?=
 =?utf-8?B?SEV4NmpFcGdNVEV1clJ6L3EyNnVEVHNvS3VDN2NhTVRsSGtuanVjQkl6VHl2?=
 =?utf-8?B?TkRHZzN2ZEpKdnVrbnlEd3NXLzB2N0pzc3dwR1M2d1V6SkdYNzBMMlRLUmQz?=
 =?utf-8?B?bGlnSlQ1UVZsbGRRNnprZjRyYTRYcXQ2QjRGWncvQTZJQk1NTDlFTVZ2OHZC?=
 =?utf-8?B?anRmbnNUTFc3R1VabW9uUUMvdEh0NURtQXh4N1FnWUFMdm0vWWIwV1RIRnIw?=
 =?utf-8?B?em4wZ2VUdmxVd1FYeHVJUHo5b1UybnBDOHY2MkVtL2IxZ2ZKOThLTUM1SmNJ?=
 =?utf-8?B?Tnp6SHJCbGc5QWZLMnZ0eUd2ZEswTStRdEY0dGVKWGRONWdhL3VZMW1ZVkRx?=
 =?utf-8?B?UmFyZVl4UjJsOGRKaUF2YjBPS2tDMnhJN1B6R0x4UGNMZFBVVmdYUDNwYmxQ?=
 =?utf-8?B?MlNhS1grVS9pUlRsRnU5dlQ0WHQ1d2Izb2dOSzhFMFg0VVI1bHp1RXQwRWh6?=
 =?utf-8?B?bjR4VEd1Nkx2UWVWb202ZlNkdlNiTEtGZjgrUjJ5cWNkbkErb0RZZlRYYS9O?=
 =?utf-8?B?cU4ybC9CbytFUFZMRDNhME1meWRTc3l3djJUeTIremNhMVpZL0puYS9nVzBI?=
 =?utf-8?B?N05sWWRMcHhZdlpFbW9UM0E1dlA5cFRWK0FTV0N1dzVmZC9JNCtnNnl5WUpV?=
 =?utf-8?B?NUdlYS9nWXBGTjhuRkxqZ09zNWx4eTlWQVNIQnBHd1JpZHJXbEVpbmVQTjB4?=
 =?utf-8?B?VExpQVpwdmU3b3NSaEsvTmpPdnRBcUtpWnppZnNQM2ZNQzNZTDJHRXhERHlM?=
 =?utf-8?B?cGxISTloVUtFcks0UHRGeGRVZXViYmxDeWgxVXBtYkJKVXg2dmdiL2RxUkta?=
 =?utf-8?B?SVAyRmJFZkthd2t0TWZXb1dFMTg3QnkrVzlkQmdxOUc2cEMvRXFuZ2duQ050?=
 =?utf-8?B?b1YxY1hmaDA1OUU5djhWUDV4NVh3MVlZeU9rcGVGS3cweWVENjE0bDVzSnJB?=
 =?utf-8?B?YUNlMExNK1Q4SkV1UHQzNnYvTjhBYTJvWjUvZzhyT1dkaHF3OFhUN1Y0d3lN?=
 =?utf-8?B?MFNUaEo5ZEZUOTEveHZ4M2ZVT0x1V3NiMmVxMGlZbFY4b2M0TUh6R0hzOFVG?=
 =?utf-8?B?d3NHSC9IQ1FyOVlmQ2dDb3E1eFltS2NrMDRXbTJMOXRwenBDWFcrQnE4YzRP?=
 =?utf-8?B?a2lpTGFnOG92eHpiNGV1a3oxODNMQ2puRlJsazducUdCamY0UllVZjVSQ1Vi?=
 =?utf-8?B?NEpFN0xLUVU4YURNOUc0Zi9rRUFBQWdRL3d5VkJ2eXZpRzJNTXpXQjZBc3BS?=
 =?utf-8?B?aFdoK0Z5VmMvbG1EaXRkUmtwTFdIRkVzVkNhZnMvbDJ1dVk1T00yWE1sZmZk?=
 =?utf-8?B?bFV6dFFtcEdHdk1rSHpZOEh2Y0RUSUJBcVJUU1NwM2JYcGsvM25LR1FhcXRM?=
 =?utf-8?B?aklVRys5OFlJcFcrMHV3M29FUDZWb2FwaHZLdGFJNlRMT3BGZUV1bVpUckFY?=
 =?utf-8?B?dDIvMzBkaU5iNFZXbFhSYWFoalBVSTVwSzNVNkpvZExRYVFPbEI1elMxSnhr?=
 =?utf-8?B?K1BMRDZQUVZXcTBpcUhOVUpMQ0VweGF4TDdUb3p6R3NmMURtRFZscENQaUhM?=
 =?utf-8?B?MGtvT3NoNGxRY3FnNlF5bVBmNW8vUnJhQlpzMUxrNitRZDNSeUNpVXJZdnRa?=
 =?utf-8?B?SE5IQmF6bzE4VUl3eFB5U3lOYjQwaUxlTFdnVUJZY21wLzlwc3U3SGdzSDBv?=
 =?utf-8?B?c0VXOGVPdlpTNEthQ2tESWJvZjE4WHJnWnEvajhTRUJjWkdJeCtFNzRBd3Bx?=
 =?utf-8?B?RzBxY3BZK2kvdEhmMHF0SktxTWR1bEFrSm5KV1FOcnNmc3QvSWUwSEJZWEFW?=
 =?utf-8?B?WjNOOU5sLy9DUWdUTXRGYjJrMlY4Mmx4UnY3dkQwaytPenUrNTBQQW1nS1hG?=
 =?utf-8?B?MnNUbnBXOWhJNlZYYXZucFJRdFp2RmlNb3I3RlJNdzhUdndiVW5LVlZkQmh6?=
 =?utf-8?B?aTBmOGFrbEJDQ2dVQmFwbE9WUFVoQzNQUTh6NFUxM2R1dzFTdkxCbGtCT25M?=
 =?utf-8?Q?dQAEETYaATc6qX5nUwu5LTOmiyR1amfUhgRTxgD4HL7rm?=
X-MS-Exchange-AntiSpam-MessageData-1: 6od1xhh9vP8wNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164fbe06-c860-4e40-2f06-08ded5da8392
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:42.1711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9TXxegcikcgSozVjcvrMHp8h3ItHqVsxX8EJ8I/VjENDPeDB+mzTn/lAtg4fLGE9/l01vjuiVNBAI9gnKdvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
---
 drivers/gpu/nova-core/gpu.rs           | 15 ++++++++++++++-
 drivers/gpu/nova-core/gsp.rs           |  2 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  7 ++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index cec21eadf0bf..7ed8411f4a08 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -22,11 +22,13 @@
         Falcon, //
     },
     fb::SysmemFlush,
+    fsp::Fsp,
     gsp::{
         self,
         commands::GetGspStaticInfoReply,
         Gsp,
-        GspBootContext, //
+        GspBootContext,
+        GspBootMethod, //
     },
     regs,
 };
@@ -262,6 +264,10 @@ struct GspResources<'gpu> {
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
+    /// FSP instance, if on an arch that supports it.
+    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
+    // generic against them.
+    fsp: Option<Fsp>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -305,6 +311,7 @@ fn drop(self: Pin<&mut Self>) {
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
+                    fsp: this.fsp.as_mut(),
                 },
                 bundle,
             )
@@ -355,6 +362,11 @@ pub(crate) fn new(
 
                 sec2_falcon: Falcon::new(dev, spec.chipset)?,
 
+                fsp: match spec.chipset.gsp_boot_method() {
+                    GspBootMethod::Sec2 { .. } => None,
+                    GspBootMethod::Fsp => Some(Fsp::wait_secure_boot(dev, bar, spec.chipset)?),
+                },
+
                 gsp <- Gsp::new(pdev),
 
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
@@ -366,6 +378,7 @@ pub(crate) fn new(
                     chipset: spec.chipset,
                     gsp_falcon,
                     sec2_falcon,
+                    fsp: fsp.as_mut(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 771b38e6335d..ff438506070a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,6 +38,7 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
+    fsp::Fsp,
     gpu::{
         Architecture,
         Chipset, //
@@ -62,6 +63,7 @@ pub(crate) struct GspBootContext<'a> {
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'a Falcon<GspFalcon>,
     pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
+    pub(crate) fsp: Option<&'a mut Fsp>,
 }
 
 impl<'a> GspBootContext<'a> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index a617b8f5974f..bf1776bb7f5d 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,10 +17,7 @@
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
@@ -153,7 +150,7 @@ fn boot(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
+        let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
 
         let args = FmcBootArgs::new(
             dev,

-- 
2.54.0

