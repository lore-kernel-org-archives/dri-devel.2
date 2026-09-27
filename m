Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73CDC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC8C10E577;
	Sun, 27 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kr633U1Q";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F2210E54A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u60uJTnzXtvirdN9mPISk8BE+0HJl0/WlGPew7Z4Sd92AibHu+ynUKJz6MCC54f0FwSi1g+tWhjhkyxy7LgDr1CAKS19ZNUsewDOfu2SwqU8/m/AffPbmamGvbUFePO32d78Fy26BwhPSw4uWgbucCuwRMMWem/Q+kAnUtHrAbygSGcKhR7vojVRPI55THEb4ndEhdLEHRRsxMSbGZDGgkFrzEMxukt/pFHuI2JCFHPcOlW8larg545MMnckaINQ2ej9FdRFLhUQ5h0f+6fRq6z5MNVCCI2pdcKUNIYGLpT1NkRLH4BVx/XT6FAE9oFrHB03gHqAq6VE7U/3ytQh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO/gnvr6ss5WKgymeUS8w+UBj2c2ugbTngmTZsRsams=;
 b=QydE+NYwSqFeM/QnHFPycywF+mTZhZJfN6894uMCrQOtKM5ig5djtgLXf+0fzSCEsk4FhfkexOB4GtOqcjtgPcg9+ROw5ufDjg1/QjUbWHtdPa1eoJUfTeuub7b9/spqQCwUi0ABNefpYQpgDl5hUX4FsEiJnONom6KVtk1ihrnDXJSkJ5bb8BiP3f+2hZZvqCwlsVMo1dQwr8q5f+xyQuDqIO5X+/MzukcaZbROxUFF59jBZ62k9qrXXHXWT/f/UBQCfDXArVkXlz+ndHozdz35NX7F1yjVuc93/pBQ6TCEgjKCcRwvcH/sU1VfnwLN/5G9hwK5i3jAhsCj1Ped8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO/gnvr6ss5WKgymeUS8w+UBj2c2ugbTngmTZsRsams=;
 b=Kr633U1QTmE6EQ67MdI9iZdHS5BrKje0Lln+eWSCgwqApgWxFLBlvlasdsqb6m9pl3gg0hqExYtv1A+6Q4y3EH5ZhV6WtqjC7iJDrlUAYB3bENOrKGuoUqKXeiN8AGueSvRsL87AfQ6p4FAJiK5gxXiz2OGm7V/JszCQu2WthHl7ROHWWJc1dT338KP07Yi/mT7ScOIwD75sibjedKU+VldMY3NE8MCc9EjTAQnDRzTWUW83LkZRWp0KXdzlMXA7PrGiu3Quv8lN0YJ6QswUuzgEmnYetLzDFonuusbKy3givMsqZ2tgKGMpotCoWSkpOU+MotM2va8PePk5KZg7hA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:32 +0900
Subject: [PATCH 10/10] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-10-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 292a4105-b10b-4c92-525f-08df1c889133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: L9vtuuETwhtti8tkXyS3wmKj1SZ6WFo1GMNAn410gWvF1Av5tELDJnZygKZAf0YvjyhpmWVE+pVTTJV/082zfMu1/4R8dTSmgUPL51ri3Nkd9VwgHk8XRdiL4bsk88+QXTVJG18sGkIUDBo/GH6nQ0juW0C41FhEqEC/D6j0h4JAa2ferD9SOqaOlwki+oFVxYyMXyQKwgthOOHY7T7zbI3Ego44c8hPUF/zOi3MqeP/edgERAevoxIDVb2Jxh5vG6qrkKy+CwdJJ7vGi/FRctmAffpUNI8UwY9z1og4MvIwwtUaZBLOk7V6YTCJIodfGjOUAScLyYXhDULwQuex5vwlwcxex8QGdVDVp6tyNblNOgrkfgYlDAekxssy4TCBUwkHIR1ek2kySl9YqgKEMb3RX6BjZcFRLN84mrXH1oF6EcrLB65RECEQHvcCunAhSIwjO29tbemkb9TWUkiX1nUG/Q3X6/4xqv0bP/EvCuwxWDi3RxzPpSF8A1N2uPd90Si1BfvcBKJfh5yAFxAVygxXuqKzwzoph64vCsiM/rC2O4NstaebUvIFK2ZubXoOdf9flYn3NudoRc7pp361KBSvwwTbBPZXAvhiro7QPW9LG7ZSyPW/a3VBHvdsIe/ZuJgjr1u4omSeoERWSAmgPpnvvUMGMWceSX/zogd7/n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXgzd0V2RTUrVCtqM0lITjR5eWp2bi93c0YzYmFma2tEa3dLdFd2ekg1SnFx?=
 =?utf-8?B?N1hNV0pib3ZDY1NHZWNtK0NqeTJPNGVRQnJNdFc3VUZEWisvZDdHd2pWN2Yy?=
 =?utf-8?B?TURMbDBpdmt6NEM2MFA0RFQ3aHdHS2VWeFRNbWZJVWdnRENUU0x4azlhNEtF?=
 =?utf-8?B?aGhWbm5KV0lJc1ZCbkpFUXQ0MTcrVm41ME81ZVl1UHZ6dVRTbjZzL01adzBq?=
 =?utf-8?B?b3FkdXpXNUZFY3gvcDNoVjdSSTAvZWJycTcyZHE2azJNZ3FhdFZ5UW11SHFL?=
 =?utf-8?B?NnMrNGJIYis5b0p1Y3hUWWU2eFo5RXN6Z21LV1hFZUIvTjB1cXFDL3ZYWFIr?=
 =?utf-8?B?VXFaWUF1UzYrMDI2ek9kcDJQNjA0R0pjT0QrK1J6ZEhpNlp4OWtpN0FnY2VR?=
 =?utf-8?B?Q0VMYmZzYTRWMXJiRm5vZjZySFN1K0ZaSDZIcFlsUnB4UEt5a2FVdFc0SVRl?=
 =?utf-8?B?UlYralQ4d1h5d2czY0Nldlg0WFhFMlBJb1hPNTd5eWtkTWlKclZrZ3dKWjRZ?=
 =?utf-8?B?NEZObjBZUDZqak9yQ2J3eXVDdlMxSkw4VlJDVXFid3FXS0NWSThIaEpEZGxN?=
 =?utf-8?B?NTVhT0V6TEx1ZUZBc1dHRlFqTUhaMGRXUDBHS3lORERkWTN4TmtQbm9lTmZ5?=
 =?utf-8?B?Y2hRb2ZGQmxqMkFRbGYvaE82TThUNGk3aVpXdUYrYlp2OVFuZ1lhaGxEUW04?=
 =?utf-8?B?aW9pazZhdjZ0MFMxWTV2cm5lOVBqYm5PTGpQUXo3ay9vVmRVall3MDlCM0h3?=
 =?utf-8?B?aWRNUEcwQlJqNzNoK0J1SlFPSjVCcDArMnBYU1R3elJGSDBhaEpobWpvbjhx?=
 =?utf-8?B?ZStaNmZNcW02cFZ0T1E1OVcwRUlrVHNIemVPUnVFdHZhcXBrYklmOTZwd0Ju?=
 =?utf-8?B?M0NDRGNuZElGK1BndlNVaUpFR0ZwSDJRT0RDa3V6Y1VmbzVpbDR1VUdZaVd1?=
 =?utf-8?B?VU4vTTlSUnJzMWhUSDBGd3pNWVQwY1lHbU92UEk4dmx0cDA3RjFMNEdlYk8v?=
 =?utf-8?B?U2hPMGxhVWhoMURkamJHcDBTNm1xWkNodzZVczk5SFA3VUw4bGhNd3Nicyt4?=
 =?utf-8?B?SGVqRmhCUHhiVlVWZ0xQWTlUNnZTL1ovZnc2eWhvRUpINTZIRGZPbmgyZ3dv?=
 =?utf-8?B?VVhiUHhSRVA1UEFyMXBtclp1TlNnN0drcXR3bHQ2MVlpMm9vdFBBaG5TKzAy?=
 =?utf-8?B?N0Q1UlJNOW8rZFZMTi9mWjYrWUJZMms3SHZuZktCaC9nelV4M1lseDRiYm43?=
 =?utf-8?B?YTBzQi9uWCtIc2pUWHg0a2lJT2tBTUJQWTljOFNVNUliRCtuTnNGYzI5LzNs?=
 =?utf-8?B?Y0t2R0dUUnc2dEFDUGtNbjVpZ1Y4L3Y2c2FWVS81cUtGWnJucHd6Wkx1a3hO?=
 =?utf-8?B?VEpic1VaTmVkVW9mbWQrUlZOeFpTVEdtN1JlMWY3TWZDMEtpanVCSWJ6TVR2?=
 =?utf-8?B?TW9aTDVIU0M2NWp6VGZNYnNsN0Y5WUR1RmlXVzhzQXUyR3BvN0czUEJBK2k5?=
 =?utf-8?B?UGRWc2NWM3dFd3gxWWRveHFSV0xYL0NzZGRBTW5OcmVOenlDSVloWENwb0pi?=
 =?utf-8?B?TGNnMkF4KzBtdExjUFg0QVk3YnhveUJNdTljT0NuVlNja0tFd3VuaU1ySkZp?=
 =?utf-8?B?RWhkczl1Wmw3QnZHOVpCSVlVVkhneWp6OVl1RmZHRGorNDcxZ3BHSks5dFVC?=
 =?utf-8?B?cGJURGJVeEZnTDZ4TCtiWU4rYzcwdlhCWXIvc1h3a0wwa2c2a0JOemg2VmNQ?=
 =?utf-8?B?dlNrVzh0N3lKS0RaOTRoR1VhRTdjRmpzNTB3MFh0am1JMU1Uc0U0MHd6WFRW?=
 =?utf-8?B?OEhVdWtHdXE2a2tWcFZXSE9Zc2loYlNiMDVWQm9uN2F4M3BDWUovbU5odW5x?=
 =?utf-8?B?dEIzeG0veXFlcWxNT1VVMzEyaC9LV3paUGNsdDVwcjZ5aXVWRThZenQ1ZGhY?=
 =?utf-8?B?RXBtN3J3bDFWRjNEcVJmajIrYnlqallkUmtpUm9iWWJ5Vm00WnFLdmNoU3VW?=
 =?utf-8?B?c3c5Zi9vWWhzNjlWaGdLa3pxanBBRE5ydGRQWWttRzgyMFlDWDUrbmMzYnRk?=
 =?utf-8?B?c05xS3JkbXhoTG50dkdFYlhUakNyeEdHWk1JNVUrUEk3cXJ2eXRDVU1SMmp6?=
 =?utf-8?B?WVlJQUZTS2Y0UUk0N1RVWkM3ZWllMDkxQktCVHQybDlXUHJ3THJ2V3ZPeXVx?=
 =?utf-8?B?NVloRE4wWnFhdU01MGNmRUNONmFmUjZkb2pXc1d3L2k2eldOcjlueEhoYjdm?=
 =?utf-8?B?TjFiSURIZXV1dHA0MG9wRlFlY1RXYmdFcHA2dzdJMFVtYnBxdkJRUkZKTnYz?=
 =?utf-8?B?NmJtVWNzTDhMakc0SlNHRWdISjA5YnJhRWsvU1pKS2tBeVJYbW5aOUIwSFgz?=
 =?utf-8?Q?DCU3tArVNK3SL3tI2qo3ypKpli/GkbeVls3a/EsjhFGwL?=
X-MS-Exchange-AntiSpam-MessageData-1: rbtBRB+yfG0idw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292a4105-b10b-4c92-525f-08df1c889133
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:58.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ2X8y10jXm5Rs1oRzhy51jj0OLnPGwX0RaTi885QuPnwK+NoUpCTw0+UomStgZEliAK7Rkt6XfTH/ga7JiQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs     | 30 +++++++++++++++---------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs    |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 75a3ba7d50f4..ed7eef21e8f9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -221,7 +221,7 @@ pub(crate) fn new(
 
     /// Query the GSP for the static GPU information.
     pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
-        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
+        self.cmdq.send_rpc_command(commands::rpc::GetGspStaticInfo)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8e446ad1eac2..0d0b07fafd4f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -43,9 +43,9 @@ pub(crate) fn boot(
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
+            .send_rpc_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
+            .send_rpc_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
@@ -91,7 +91,7 @@ fn shutdown_gsp(
         mode: commands::rpc::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
-        cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
+        cmdq.send_rpc_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 335f94c4d2aa..81f8c79b1bb5 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -135,7 +135,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
+    fn send_single_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
@@ -196,19 +196,19 @@ fn send_single_command<M>(&mut self, command: M) -> Result
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_single_rpc_command(command),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_single_rpc_command(command)?;
 
                 while let Some(continuation) = continuations.next() {
                     // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_single_rpc_command::<ContinuationRecord<'_>>(continuation)?;
                 }
 
                 Ok(())
@@ -216,7 +216,7 @@ fn send_command<M>(&mut self, command: M) -> Result
         }
     }
 
-    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+    fn wait_for_rpc_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         let GspMessage {
             header,
             contents: (slice_1, slice_2),
@@ -275,12 +275,12 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
     /// - `ERANGE` if the message had a recognized but non-matching function code.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
+    fn receive_rpc_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        let message = self.wait_for_msg(timeout)?;
+        let message = self.wait_for_rpc_msg(timeout)?;
         let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
@@ -329,7 +329,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -337,10 +337,10 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
         loop {
-            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
+            match inner.receive_rpc_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
                 Ok(reply) => break Ok(reply),
                 Err(ERANGE) => continue,
                 Err(e) => break Err(e),
@@ -357,22 +357,22 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
+    pub(crate) fn send_rpc_command_no_wait<M>(&self, command: M) -> Result
     where
         M: CommandToGsp<Reply = NoReply>,
         Error: From<M::InitError>,
     {
-        self.inner.lock().send_command(command)
+        self.inner.lock().send_rpc_command(command)
     }
 
     /// Receive a message from the GSP.
     ///
     /// See [`CmdqInner::receive_msg`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    pub(crate) fn receive_rpc_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().receive_msg(timeout)
+        self.inner.lock().receive_rpc_msg(timeout)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
index a3262cc3e0e9..ad4f466427c0 100644
--- a/drivers/gpu/nova-core/gsp/commands/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -191,7 +191,7 @@ fn read(
 /// Waits for GSP initialization to complete.
 pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
     loop {
-        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
+        match cmdq.receive_rpc_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
             Ok(_) => break Ok(()),
             Err(ERANGE) => continue,
             Err(e) => break Err(e),
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index ebf13867746f..ab3237ed64d6 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -344,7 +344,7 @@ pub(crate) fn run(
         bootloader_app_version: u32,
     ) -> Result {
         let seq_info = loop {
-            match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
+            match cmdq.receive_rpc_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,
                 Err(ERANGE) => continue,
                 Err(e) => return Err(e),

-- 
2.55.0

