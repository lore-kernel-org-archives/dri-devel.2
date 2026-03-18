Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28876FCD0A5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8193410E72C;
	Wed, 18 Mar 2026 04:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zs95B1dE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C897010E72C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqNb6Z+mFsxVFcgm7sDHaAq4mqynpDNuUP4tUjCmUJXlhs+uAnQhNaS8F0X4WeABVNhuBSA6jrEmPHRKZBA99eXCwhR7Rdt7YtvDyv/wJvzYECmP77nXGqGUPSZCUNOBcnWf4oKrOjSV/I/LstoPct1lBLB8FhO4AL2MhZFma6zXxNQo80WawPPdfWg1omINUwVXz8bpcP33TpwPL41loBUJ9+rvfDueXr37CmNj1eEOUHP4xjLiXFB512LGTrkt9KCjFI3RrwVKAc8Ikdcbl+pqWhXkRbsDeq7ynfMnYAzS6X0U62/hXRltBgUKYxth0SVtb+TemRDuHTiXsxa5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmL/q9TNkEwullukA6pB5tOAJu6ZVWanuQcKSi/yjUc=;
 b=MW4onxUwLPhEIAcLylNl4zxfBkJWUpEse+vXsSh7G8viGSSk7fbUcZOUSAve8Qzg7OiFK3zNmQFlN4EY7xOf7bfazgUiDYW2FPZQHpsZRHegYGVHVyIgv8caWYaTfxr33xDEv9FWvYbp6c8PLM0xUYMEtJMQumrojgSLMo9l+gkjOURPrZoNUISd0kJ4YFEtiVW2AxdIeczBa1Ber491V0GJL1BRxNiMQkuAumcb+itVNKC8UGWY2Wf7uQRmeiGsRCmxwvuChFnclOR50mOYScW7/XJy0iYNKjMvYx6gn05nDDavJNHrTbql4jURH+6fOXWWA08IVN2f9AzNu71U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmL/q9TNkEwullukA6pB5tOAJu6ZVWanuQcKSi/yjUc=;
 b=Zs95B1dECkJGB0Kda06OWWmjIsJDhAI2YbNY7iGVXj3C6nsrsNP4XEHuAIU+ch7EFjR8ZvXdIGPEP/x3sEOBtMy9Y63xa3fg2nhIFh1GwcTR6ghukQa3XfWc+GPYleZgq0l9RZ79hsTzFBpQIE+Ru7ue4Dh1cPBd6WA4afBZJ5TAX8ed/xD5ghdEP1CFP61Oww9h4kbEA7C1EA/LcaRdHSBpKJ62Ol/8pU4RbQe/reQEifbqBnW/DAhdYgMZck4Uf4iBevbE+luxVSeYfPIRPc8vhLII7XqvF4R225iV4/N2C1Bc4qjyVxptUfK4ZBA0ns2usYIN2Z7fga7jOicJgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:07:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 04:07:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 13:07:12 +0900
Subject: [PATCH v5 4/5] gpu: nova-core: gsp: make `Cmdq` a pinned type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-cmdq-locking-v5-4-18b37e3f9069@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
In-Reply-To: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: ea616620-2a2b-411c-4772-08de84a3ec12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ndqwosm2oskyZJtq+RZix1C9Rczn85gRvnzokHTDUIx3v4nRp7D3JIxLqyoQDSLGdpwCI6Acz++ehAf5ISBlTCE/ztl1r0Y5YKx73xIAIs1b2P0vjTAwUJ+ZU3zEESnegLSbaf6ZpBuLU0f0Q16V6Lq4YeU8H4EfJOYhC2bKyJbh/JxujUkznuSXWpQRA6YOmZjseaa1h9tKucdkYxKRBKNwX+fDXLb7rMVdT2QCPOQ4lLzSUL4dF/yt5zl6PcGVJEYp66z8T8w3OEpUq4wqInaDbUsPOcrQNPK0JPwVhlOd/vOZEldJBefOZkVQnCiz2ZNoYux/jVVYMq6pAw035UXy3ziP/PB0TTSgP/GQFYX+QObWsIgvJZFuY6got7M7iF5Sq3Lf8rL+OqBgZ/snwJWemGHvJOQQ6nWDbPokBuNBLIxxy3pWKkFPZfcJFnMfUORSWHrJi+VwWJ89XaQDxrtT6PkeNHD2PsmA6MvfY3AI0Zmm01cMV+eLjequVfLng8lKCdqdalPDtEb8ktIwB4u/rTeUtcEy4E6W08oKJj+X/dJT4ziT/SQSdtNMsPAds3WpFHL+d5rr04ahiyeP9eB3NX1yRXMEGhaWnamZljwBzmKQbuv5vNgSpapCoBNjyMcaaczE0PrtzbaF18EgpS4NaRyCoWIY+epRPBqM++zOlSvQHqkMdW9P+mcR8I0KBfOl/gYOLM1U6qIQvnv+VkVFSq4DuZydLtohrrxshkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dtcGUyWk1Fa0FKNHcvOEdHMFlsWkwyY3BzY1U1eUV6WVRSdHNkSXZUbHRz?=
 =?utf-8?B?V3d1cVQzS2RRK21laEN1KytWZ0toSyttYlc3RkpKc3hUU0JBbUVUbHpWUlgx?=
 =?utf-8?B?QXlhM2FXZERrWklXNERXb2ozSmlaOVdrZmFkQU1NNGtDQXYzV3h2NXRhN0xt?=
 =?utf-8?B?UG1MWm9UY1hJSG5uaThzOW84WlNJcElCblprUStqdjJmelBUcWw1N2E4Y3FW?=
 =?utf-8?B?RzFKZk5ycCtJcjE2cmM3SUVnQmJYR1JaRHVhZlFBTndPV3V0ZXp4OUtzMTc0?=
 =?utf-8?B?aVozbjBvYzBMNG1EZmNWTDdaekI5MUdTaDM0OVROUXNSbURLZkZCWVZPQ1Qy?=
 =?utf-8?B?clV0emFOYkQyZjcrRDh3SnpMdzcyRGVJRjYxb3BsZ0piWTJYMWlVY2ZzYTM3?=
 =?utf-8?B?U1VwWmdCNjdFM0g3U29DMVdEZ2MvbTNnQUFqOWlzMWJkV3h1MngvOExBR2l3?=
 =?utf-8?B?K2VRakozTzVCMTlQaEdPNnBUOXlzUVJLQnMyZjBCOWRrV2FnemVlMEtSVldD?=
 =?utf-8?B?T2p0eDlGY1hOOGRSOFhJOFFzMjI4UTNEK3BWeHQ4WHhLemhndjJRRllYSy8r?=
 =?utf-8?B?MHJUM0tTc0x0cUR2MTRLVTFyMmVmb0sreUdKdS9jcUR5M0NXWThKUS9tTWZP?=
 =?utf-8?B?bURxNnZENFRxMCtrV2k5Zm5uVTJoQWZpZ1oxMXkza2lwVk5GeVZkV1laZThp?=
 =?utf-8?B?M1poSGF2NmZYdHFnekJGd1hWcWt1TE1xYWVneXZac0p1b3I0SENXYnpDMzU0?=
 =?utf-8?B?ZWQ1R3o2Q3gxbTdEZjYzdUgxc3REdWlyZnFOREtTVkxlbDNWVHlab0ZWa1RF?=
 =?utf-8?B?cHNyYjhmek1RVmVmZm91bWVHcXBGMlRNbFhOTU1hcDQ3TElSU01HOGY5R2NZ?=
 =?utf-8?B?dmt2M1VZdkNJbnBVclJwanErZ1B1dTdjbkxIRnE0c2QzdDhqNFljT3psYXVD?=
 =?utf-8?B?a2VVenEwZW5QZVNHVU1QNGpGT3Y1ZGRPN3RxY1R0cVExUm1wSWFtTTJONzUv?=
 =?utf-8?B?bEdIKzR0YUY2Q1Z6THUvckE5elFub3oyZzErM1lqckMvWHdQbkRkS1JoL1Rj?=
 =?utf-8?B?R1p5V1hZalcwNXhQalFBanE2aVQ2eWZNRmVKR01PNWsvcGhsVEVKR3ZvU1Zs?=
 =?utf-8?B?V01jN3pNMGphU1V0RUlheEhJeis5MGNoR1hjd3Rjbzg5SlQ2aE5iVmhPQVNK?=
 =?utf-8?B?RksyemthL2Y2OFN0T1BWRnY3MmxXMjBPYzhWOTFhc1IxenFVQ1pIMWZEQ291?=
 =?utf-8?B?SWI5eGt4OTVVY2NFQlh3blhYYnBHSWJHQWwva05jTTUxSXdjcjVwZE5LTGo0?=
 =?utf-8?B?anF2NGR4V3hINGQ5S3AxNnFzSnprbWZsdSt3UDdJTlFKem9LcVlHYVptUUc2?=
 =?utf-8?B?NGdYYm1mbVVuS0ZxankrSy9FZ25rRDcvYmQyZHFkdVJ2VWVRRE1sSXFrZ1U2?=
 =?utf-8?B?UFUveUNTZUliZXNCc2RTL1c0YWx4bmF4SzVrL2JEdGtRMkVmaExsL1B0SGZD?=
 =?utf-8?B?c2JQclV6dysxSmlRK0RkcXIweGttbmlSR1BvelhUY3hjUm1hQ0tDYmRCWFdC?=
 =?utf-8?B?UFVMcDBlU0MxR3Z2Zmx1QUpiRnNqTGkyLzQxWWVrcFdqWUIwMWdqd0dqZlNU?=
 =?utf-8?B?ekJab1J5N2xuZGpNTWtkVmU3ZHVwVitKTld2R1VoSEtLc3JXY0d3OEJaQ0Fj?=
 =?utf-8?B?TGRla3VLUGY2UXBMaFNyWC9vcmkvL3NrbVRYUm8wbXQ1Ulkxb3I0bzl1U1Ju?=
 =?utf-8?B?OTYxU2o4UldTVEUwTDZ0M0hLN1B0ZWdhcG92TkVGWis1djJ4NGtBZXZGUlEx?=
 =?utf-8?B?bUZONDZLSmVScE41dUpJYWQwTm1iL1pXU1g5UTB0elczSm1udFZPZVNRWW1B?=
 =?utf-8?B?YVJnVHZ5MHFISG9zbUM2MHRGc1hUdGFHZ2N4SFloNWpYRnhld0tWV0NJN1E5?=
 =?utf-8?B?TlN5QnNFMVhuRDlPZWRaUmg1RUhVdC9YOW9mRG1jTWM4NWNkUXIyTDQ2T01s?=
 =?utf-8?B?RUI1SmpmaEt3UWpKdFl5RzhBVUM0d1VCWTQxZDcxVXNvQnBtcjR5WjFwZmp6?=
 =?utf-8?B?SXN1dURXRDBkUUE2YWxCc3p5SDdhVVExUDk4cEtBbklSemo5Rm1lcW1MR1pn?=
 =?utf-8?B?eTQ2TWxVWG1USnRPMHRvaFJXdEJhbEh5Sjh2TnZPZ3FnQVZ3OFNCY1lXMUw2?=
 =?utf-8?B?clV5SHVVSUV1R1B5RS9uUlZMNWRHZGVHQTZTOU1odVl4S2drazRvZEFQYUow?=
 =?utf-8?B?cjZpdVRqVzlxY1NJbXZrcnd2ZkdXWFZFb0FNM0wrMTdyeWdvUVBYVFlUK0R0?=
 =?utf-8?B?WDFkV1BBS2FWVkpGN2E4L1czcEtKNG9UZWpxaElIcmlhbkpReUVNUVRRUEhR?=
 =?utf-8?Q?ox1WF1yTy+lZ3oQZORRVGlzAwfjLcMUfJ/ys0ZdIcJ9Gd?=
X-MS-Exchange-AntiSpam-MessageData-1: EJTdfrDhDzRwmQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea616620-2a2b-411c-4772-08de84a3ec12
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:07:50.9595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXieEUT5eaWkgGCfGqdBaIkT3Pec3PdPFiJaPT2jjlcTLSkY5iS3UhhhFpVWbv8VHVumtjN9rkId9UJvjdZQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

Make `Cmdq` a pinned type. This is needed to use Mutex, which is needed
to add locking to `Cmdq`.

Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Tested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs      | 5 +++--
 drivers/gpu/nova-core/gsp/cmdq.rs | 9 ++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index c69adaa92bbe..72f173726f87 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -114,6 +114,7 @@ pub(crate) struct Gsp {
     /// RM log buffer.
     logrm: LogBuffer,
     /// Command queue.
+    #[pin]
     pub(crate) cmdq: Cmdq,
     /// RM arguments.
     rmargs: CoherentAllocation<GspArgumentsPadded>,
@@ -134,7 +135,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
                 loginit: LogBuffer::new(dev)?,
                 logintr: LogBuffer::new(dev)?,
                 logrm: LogBuffer::new(dev)?,
-                cmdq: Cmdq::new(dev)?,
+                cmdq <- Cmdq::new(dev),
                 rmargs: CoherentAllocation::<GspArgumentsPadded>::alloc_coherent(
                     dev,
                     1,
@@ -151,7 +152,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
                         libos, [1]?, LibosMemoryRegionInitArgument::new("LOGINTR", &logintr.0)
                     );
                     dma_write!(libos, [2]?, LibosMemoryRegionInitArgument::new("LOGRM", &logrm.0));
-                    dma_write!(rmargs, [0]?.inner, fw::GspArgumentsCached::new(cmdq));
+                    dma_write!(rmargs, [0]?.inner, fw::GspArgumentsCached::new(&cmdq));
                     dma_write!(libos, [3]?, LibosMemoryRegionInitArgument::new("RMARGS", rmargs));
                 },
             }))
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 4fc14689d38e..86ff9a3d1732 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -446,6 +446,7 @@ struct GspMessage<'a> {
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
 /// area.
+#[pin_data]
 pub(crate) struct Cmdq {
     /// Device this command queue belongs to.
     dev: ARef<device::Device>,
@@ -479,13 +480,11 @@ impl Cmdq {
     pub(super) const RECEIVE_TIMEOUT: Delta = Delta::from_secs(5);
 
     /// Creates a new command queue for `dev`.
-    pub(crate) fn new(dev: &device::Device<device::Bound>) -> Result<Cmdq> {
-        let gsp_mem = DmaGspMem::new(dev)?;
-
-        Ok(Cmdq {
+    pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinInit<Self, Error> + '_ {
+        try_pin_init!(Self {
+            gsp_mem: DmaGspMem::new(dev)?,
             dev: dev.into(),
             seq: 0,
-            gsp_mem,
         })
     }
 

-- 
2.53.0

