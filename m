Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1040CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9ED10EA1C;
	Wed, 17 Jun 2026 13:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JncEwr+f";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C57C10EA1C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haV5/a9/PRxicy3Grptfpz5Fh/INEvzAMlEwykWmsrSTv/f/LUuDep0KPJS1Prm9XmgjqTxxgjNMS77dV/+DzbOMPpqPcZmq+vZXOpGokNQIOMu7iQhdw5fG3TYHTE9yjpgrITp4XBPiYaEj2dXqSnsRbUaOdU8eo+8oeWlGnGBJ/gPpnLnSEbMDtnr3CeP3DDZ1NW8Eolfvss5rdWViqsIMgLJQ1CDcpWAzFwOZbNUuoxz0nItnfHRFDp4m5DulSNvAY6LbGGso6R9H3CivcroneeAMWd9OdPCfAme+T4df/DKKHeIulyCPt/eOosEmM/51Xxx2LWL6GOXuNClEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4BIZ0VXtCCHY79/TQdr+pD0ddIno4ePKMnS1IkdKBA=;
 b=kFWTxceFOrlWCnVUkPAqjow1P28J3fKjRpKalZ94rmJ85rjrqWFv/Rz+mwIBdCQS8iRt92DQsW9Um+VKJ3x9aa4cDDJddPk9hP0AQW8Hk41IkWGp9fYliIW85wqqrCyxKhGpiF7ameV0Cm3jLkwXaHWcflQ1x8NtRxmSMr/JwN4MqOgfiEFCD9QvMzFPSYchPzi5FsNparbdLw42hWM3JQlkYvGFFo+AKQvoYbALdaKxMxMXgRvhmuTgdP6eP20UrEGRooEsF7fwZ9aGi/kAtfEfLwreTNwAb124SrEhKq6m/C3yr6vV+IbskYE6sRL1OKs1gYFZZggO+KUMjOXiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4BIZ0VXtCCHY79/TQdr+pD0ddIno4ePKMnS1IkdKBA=;
 b=JncEwr+fIJMsfsbRatwabRAO+jDGmden9tXp/khIiaPVwUR4iBF3rEfkjcu+3rUgHp8tILyc/SqxCQldRctUFeDUXPF4YlEvYdVoUp7RNJE8Y8EBZWpLOZMYYEoWQAQdiwuyUr4Gio0UlDwmajTwmZTK4k5B1LTZW0rG+KYl7yCd0IuqiVaZNAHIQPXnwkpJ56QtNZtl9qK9kLmI92KOFVoQZ9ZbGgW8nEQs1G+u7NLUpYlI8KMZGe4GEvhMBcp+tgge3YbIAcHXyIiauXpqyA75E2K62Y6fVIwVTJ9ARi8VAPaOPpPOAPYihZSB/R6S/H8KUGYM1tRktYTv+RcRLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:24:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 13:24:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 22:24:43 +0900
Subject: [PATCH v3 1/3] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v3-1-20b9ec5fe9f2@nvidia.com>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:405:378::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b45be3-c5e5-4264-e1bd-08decc73d100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|7416014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k58/8WFfqK7gAauYVZAQwXOfhk8vd3/a9HYOmIAdxdRdsuSV9TKjFZP05AG4pbaorJvuWbDLu3RfncsKb03moOQJDv4mZzbGrDqJOxr9/0l/ZtVL2Mion7DSnYeX/x5Le0EkFqvt0VwOwIc7qjceFcXSf6OA0dTlg9qT38Cx7jP1aatJtV5OXovfrlhMR6LwIamXoEjmIPy/Of29cqEFghGjCyiuKbD6ImJ8r1HyErCnuaD4Fe0lSqvA3vujWF6QKqZC2pYCkjX3GwlWOpom2siYvF89Z6sG9UKnT1CYdua4NUVp5+8VvU+lFId6hy1B/Dw4oCbyze7gYBRbmYmVW4BVb3LaEcBUrzXK1SqVxhEt3WzVok4n4xsMnuUxk/gG49Ku0OR01dZYa83mYtmhKHTqzIDymEpq5Dnoy5/bouKcqXQZCaU5WtZ87Ey8KWFxeleceHVImuVO/l6AfF226aCS//YwAjeKG3d8dIQOmWqWNdQk6GpJ8uMQ0NTdVwz0DWXWX1MkSNEGyHORADwHTC+A/AhOWBVQEUVbIdKeRF+PC2Hp5u4V7p5U8QvqiBJ8CQw87fh3d/Tv9lMcFIr9BeaCQWGEBEh5XyvoDOMWibI2SrxLn1Oxe4WEcj3vIqqECF952+gOlvBk+HujGjwR778d3rO1QGe4z7axCb0D5645XaisZnf/pmBkhp5imfcb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(7416014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlPak4wb1Y0Mk9NUzFneG9rOTc5Nk9zRXJETENaRmJtT1ZRakVmWE1YUmls?=
 =?utf-8?B?dC9PTjVYRExRRy84MzMyZW8vYTRRbFA4L3dvSVVqZHUwcnpXaHVIRjVWV250?=
 =?utf-8?B?d3hKWmFMZGFRd0Z3RWQ5RHpBVzVNZldSOURaa0pUenBHRlRmYnJiRGUxRjFV?=
 =?utf-8?B?WU9NU09tRkVvQjEwT3FGSEQwY0JmdTJDaHg4eWRvV3o1cGNUS1kyLzl0RTNF?=
 =?utf-8?B?dkFEdkFRVHFOL1RWMUlqd09WTjE5V3lrTHNDUWFXTHNaVnU4S1BnTW8rQThB?=
 =?utf-8?B?MlpkNGYyM0lSSlhSZ3hQenJKVUpCd0RSa3JUU2NGVFhEVXJlbEtTVms0RmUr?=
 =?utf-8?B?d240aEtOSTNGZEhyZkF4aXI2d3hiRmNBWVQ3eXhxNG9CcS83bXZwK3kvNUlq?=
 =?utf-8?B?dnlSRlJhcUtXVGt0a1hhS3F6MFJuYzhMbnp2WGhYc2dqYVE1NEUxLys0amVX?=
 =?utf-8?B?UnJDTDdodGlUV2VQaGFXMjVFV3pJZldWV0JKVUVUeHBmYW40eUFFSGwrNUpI?=
 =?utf-8?B?SFBsZ1VzKzdBT00xWktVbU9MdWlISnBITG9UNFhkTjZraDVZN1BYQW1udmFv?=
 =?utf-8?B?RDJrN044SW0yNnc2NGxZTE1wdHBMM2QybXJHR1NxbWtTSGJnU21BVHQ4QVRr?=
 =?utf-8?B?Q2ViSmhOWVFGL2FBSU1HUk40S3NmT3JKS24zbStVWHBrZHAyemJuWVMvNXE4?=
 =?utf-8?B?ZEVJZ0JBRll0Yk1HQ2hNbFhHL1hrV2pDcDdNRHVldDdrc1Zab3JmS21QdVdr?=
 =?utf-8?B?Vys4YUJiOGl5alBBWXFKRGhzamhmSkMzRTNHa1JMNktBclgxckViZnRadzZT?=
 =?utf-8?B?L2NCQVNMWkhtWHduWEtDTVk3eXl6ck1wZDB6U25zVzBaaDNEQW1nUldqV1VW?=
 =?utf-8?B?emZXd0RPS01UTXZ0Zit3MnExS3FoUlVlVGxVUXVQVEV3SGJjNVJCMVU3ajl0?=
 =?utf-8?B?Nm84Uk93VzBZcithaHk4WFNpbEFvb0NudDJTNzJaUW1ZNlhPYTQ5NW5UUmRs?=
 =?utf-8?B?aG5xem1kM3ozUkRPZ1FwSm1DWVpZd1dNUWlIWTFHOGtEdE9PK29INjlxWnNu?=
 =?utf-8?B?MU0reXk0Y2Z6YWlMcVhSekgzNnRvK283SjJHZG0rcTd5SkkxWEpsT0VxMWZX?=
 =?utf-8?B?Y0QvVzhpWHhKWExqdWIvVzBxSW9LOERhcUtSenA0SVY4UGVGRkszelBCbWdI?=
 =?utf-8?B?MFY0QisvbTRYWmVTWmJPeEh1b1Z5RHJQTjdTQWtPNTA4MXd4ck1ZM0RTK0hx?=
 =?utf-8?B?WDh3Rk9VUGVTWVVBeTErVHlRMXNtcjdFazRsbGQ1ZVZvRFpKRVQ2SXIyY1lK?=
 =?utf-8?B?aEYrYU9EUFBMakpxOTBvZGZpZE5TYVBjNllmZitaSUZhaDNFNFVFV2tvTlVa?=
 =?utf-8?B?N2dQbHUyTldMZ2RGdS9TZzlpMjl2cWt1WTYwdGRxcEVlRm15VmZjQVA1YkZG?=
 =?utf-8?B?dXJhSlVzdnNpeDB2MEx4WHd1WlFFUUtQdVpaTW5RMEJDaXR1cEMvbGxEVnZP?=
 =?utf-8?B?emhVN0pkNC9ibEtIWGM2RTUvTUFnNHUvRDZOOU9DTkFydzVzNWdyQ2ozWTNu?=
 =?utf-8?B?RWFxNDhkM1FtT2pPaGR5WEJoRTlreWtKUWgrNEdxdEt2b3FyWnVwbjZvUEVz?=
 =?utf-8?B?aElDZE00UUxPdEtRQmJYcXA4ejBnWWowbURWZi9ySGc2Y0VBa2Jxb0swQzZR?=
 =?utf-8?B?c0J4MzhCTmk1bDloeVY5enRXTVBCVUZuS3NlZFZSRnlLM2VqcE1YaktValpt?=
 =?utf-8?B?U3BBejNjY0RYb2xiRXZwN09kelAySkF2ZzNqbWhCZ3pKbVgydzBzUkxYVWZk?=
 =?utf-8?B?L0o1VGxYQTA5a2ExaWxwd3FFUW1xL2VHVlZPdndpenBrelJGS1VaRVFCTGtO?=
 =?utf-8?B?TEdZYnpIUTZ2MDd1emZVcGRWYTJlQUcyem94ZXV6dzJOa3pXeUZVTGdwYndu?=
 =?utf-8?B?dmZXRHNNbW5GM3h1Q3A5aWEzMTl3TXdkY1dLVE9VbWhxZ2h2UWN5RTI1VWVk?=
 =?utf-8?B?Q240RFB0SE93N0d4THFpYXBTOUNaYW51aGRsdXpjaWEySWdhWE16OUlFS05J?=
 =?utf-8?B?YTZrVlJZbDVYVGtVQWxaUksxRHVWY0JzTEJmNWhvRWRHUjE2VzFteTFxNzg4?=
 =?utf-8?B?UGRTNWNLdXVGbkttdHhtZEd5OWFhS3RQWnN0RUkwTjM1SUpKWEd4SlZwWVNk?=
 =?utf-8?B?ZGtSS2RNaExsUkZwUTVPeWhZL0xYT1o3VGtTYlM1a1lWNGlrQWpjeUhScGV4?=
 =?utf-8?B?aHRCOU9CcmpBMWJnN2diOUI4ZjAxa25XMU8vSElTcjQ5UkFzWVgyQ3ZBYURk?=
 =?utf-8?B?VUxQY0liQlU2VVFsNXpwVzhmcGQ3eWhWNjByZWtveC9kUGVEVjBGNU0rWExK?=
 =?utf-8?Q?7ZvbnidNTV+wj/fo4jEEiuRJNJKw7f9Fitc3ycF9gpeHR?=
X-MS-Exchange-AntiSpam-MessageData-1: cmi4En7IlVhDGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b45be3-c5e5-4264-e1bd-08decc73d100
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:24:53.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqwmr320KR7J0tTaPmtAb82mFxvNTnEiyL0BudnHbEZMt7hBuphtQLl6MoNCukVuGEjQRB8b7gedAGHl9qwSDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 104 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 6a9572107cf3..acee9a3ab37f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -263,35 +263,62 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
+    /// GSP and its resources.
+    #[pin]
+    gsp_resources: GspResources<'gpu>,
+    /// System memory page required for flushing all pending GPU-side memory writes done through
+    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
+    ///
+    /// Must be kept declared *after* `gsp_resources`, as the latter's `PinnedDrop` implementation
+    /// requires the sysmem flush page to be in place.
+    sysmem_flush: SysmemFlush<'gpu>,
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
@@ -309,46 +336,35 @@ pub(crate) fn new(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
+            // Initialize this early because `gsp_resources` depends on it.
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
-            gsp_falcon: Falcon::new(
-                pdev.as_ref(),
-                spec.chipset,
-            )
-            .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+            gsp_resources <- try_pin_init!(GspResources {
+                device: pdev.as_ref(),
 
-            sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
-
-            gsp <- Gsp::new(pdev),
-
-            // This member must be initialized last, so the `UnloadBundle` can never be dropped from
-            // outside of the constructed `Gpu`, ensuring that the unload sequence is properly run
-            // in case of failure.
-            unload_bundle: gsp.boot(GspBootContext {
-                pdev,
                 bar,
-                chipset: spec.chipset,
-                gsp_falcon,
-                sec2_falcon,
-            })?,
-            bar,
+
+                gsp_falcon: Falcon::new(
+                    pdev.as_ref(),
+                    spec.chipset,
+                )
+                .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+
+                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+
+                gsp <- Gsp::new(pdev),
+
+                // This member must be initialized last, so the `UnloadBundle` can never be dropped
+                // from outside of the constructed `GspResources`, ensuring that the unload sequence
+                // is properly run in case of failure.
+                unload_bundle: gsp.boot(GspBootContext {
+                    pdev,
+                    bar,
+                    chipset: spec.chipset,
+                    gsp_falcon,
+                    sec2_falcon,
+                })?,
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

