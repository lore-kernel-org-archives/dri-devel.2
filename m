Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA89606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oX1COnQ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F55110F49B;
	Tue, 20 Oct 2026 10:09:36 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B3710F492
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD/aP1+VeY95SoEBZjIvRajz62sXm7527nRxReQceE9JZO9aebeDzT50Azf+8teIVYV+2yKzEKrrtaswxAnuyL+k+J7RVkzUvp/wighY768QswGmsa/ye98WZACvLG90kOmWoEYaKuQVCMFhUg6hdT6h9uGwCIT2qzudWhBgg8Sc8NJ0r/IXnEOVPPoMaraDBkQzWLVdI+FS8ou+laOrOTB6zoQTFYpyf9+6CkWgla4qFzpjEOClsZKHNEbvwskEntgPG/C52AShTtU89iV3ucijeAnXb7TdZjezqA83jTj1C0KtEprFQ1+JZTkgR7bm9p5lFxLGEZryY32N1Wm+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztF1kFyn/NSBzu3Nhn+T8MAIbemulrvfAGEsaghrDu4=;
 b=bJpNPO8QnePVoW/Ia3Wju1i0LMNssCaDiwO6hogJLei42GVI62b21f1lOvJSZTh5h6LoVdM6TP09n51exR+FNjrf2l/odrecK3WFzUr135Cx8BZl13GSlr4rSxnpfyV+mvzU7ThHwDeSDTa+Bkr8EnX0aT0k+794M7Ze2z8tVv9o42RPx9BaIWvnAej2okBxgeoWklOOhedMKxWckKRtI2KgtvjCEShaLmZmj9jB5MMEFBYWnBMQy6QL9B2V03cledkfsmf/CZaHCgGlIpNYg5BJaQ79M5s/X1QqwHI4ZooM8tRwqRa/Tgkvu4G/EOMltnAXSUtB+X+/jQFm+Jrpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztF1kFyn/NSBzu3Nhn+T8MAIbemulrvfAGEsaghrDu4=;
 b=oX1COnQ+crEmoQpsO37OR9VHhqfpZrRZbms1I1w6D+AzK2D6mDBR0Jq/T8jtfjwnfh5p27jReAX5dw33l9kicnhP3ROfftHEjC3SQhOknRBoBoWX2j4Kicj/mF+fd9vBscfJHYb3/sl7r1e0LvqR5AE3a/pbXEWkIfAr3wj5Obe6s0ULannWsIzW91KJwXG8IhYupHMrlfo8cPfjnolhR1RvD5DMIBtJtkJUZEXHvVVW+pDmLrVMul9pzv/1uUn6zEMkdmD0sOX+QfoRA+RDUmTlqHoilC8NoXs3Ecsok1gXVMdwBNvdrK4rWT4Pgw3Zad8oyjMpD+yaaV6DnhkxdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:09:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:09:12 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:35 +0900
Subject: [PATCH v5 14/14] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-14-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 93105e0b-d610-4a8e-3824-08df2e92307c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: +U5faI9KIV4IHfjeTsQWWojipIp+5rbJyrosnpiO5H4MWZNmJngo11tNuwKqgGQF15Ws+3yVruFi7vCZevqNIGtEUa9cZi4zmVq26ntu+GoWkiJpUGbN9ltm+Xa17Apy9vlvNbSbQxXiBK5i6r7OcF5X81sNNfujzMD0Nr5KykBWjbsIm5fUu+AH4vDL0qavvL1J8UqqBvmpbXQB2m5IHnL4/Qv+ojcS7jMkFXJFkrlzssXqajgbV/cPD7hx6TaiUc5Jhppm15JQuREaXTtpGiPAb1OJl7m8uxHQ00T2P+/mzpr8Y77wQlhozeZ9FqRpZem1W7Wz9GzLBVSrufh/KJZRctuH+aFAna9fI4yvO9SjX0huIXdNB8FMCeBpHwyu7vO9OxoX23KqAQFBRjiOtvRl0iIHg+7BQiScGmB7WojLKpKglZmAHBNFtBI50+0bjESTIGe+1SwNP53IRtQWizY3SdnhM8OrnbWt8pq2QcJ/i69WnvayeUqtzOP9wTOLLkIxsGARsxc+sKea9G+xY7AExGMlfJtfT5jYbWjffEuLjELeJrn9F7EpUgrwowciD+1SRl7nJv1q+LtgjVP8G6HTOLYr3rw6o8n5R1Q4ytEQYfZ6QLcPWCqewFZPZimnQwpRsjEOLkYLd72qre0ThdtThZjWN6tEXWQl13cWS/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNuZXZPNk5zc0h3N1FGM09rRUZHL3pocHgyZkhLYmhqcTF1WitPN3Btd0pD?=
 =?utf-8?B?MFZyNFo1OHFjdUVOQkJpdG9HY0QweWlmbHZEK0ZyM3JGdjY4TFd6d3FrUTNU?=
 =?utf-8?B?aEorNHBENHBmd2tGTmd5Y0JsUllDcWVTNkdzRGsxVUxJOS9rZElBUWdwWHJ2?=
 =?utf-8?B?VEt5YlJRN2tGcXlWUmhDd2hWOS9GeUIzeTFwSVZaaUI1U2lCYkVZTlNsNEJ3?=
 =?utf-8?B?YWJkV1pXRjB4Y1c0WWhOT1VuM1B5VERCdlVhV0VHUWVVL1dCTWZSMDRncHZ2?=
 =?utf-8?B?UE4zcUJaZWd5SE9MOXRvSUw5UmNzS0NFSC9mNFZxOUpqOHBkZEU4amFvRFV1?=
 =?utf-8?B?dTZOY0Ezbm1Wdi8wMmNYYVcwOE5rUDlCNWRXQlpNNVNsVzg1L3B2bDJLN2or?=
 =?utf-8?B?ZVZubTFpbHhvT3ZVMk9GckJBVGp5ZFJhR0pFcGJVYmdnV01Xb0J4RXZwaFBh?=
 =?utf-8?B?Z3pLeVlURUd2dFIwUTR3V01RT1I0UHhrbXZvU0RmMzRuRk1YN2JENzhNMzN1?=
 =?utf-8?B?L2pLdThxZ2MzZjNTOFJCdER1OFF2ZEduZEE0eGYrOExJMUpQeHk5UWRiRjhL?=
 =?utf-8?B?aXZTRXI3cmVWN1FUZFFHYXQ4WGlCMXp1SmlCS3MzaCt4bVFweDNUeFFPODdr?=
 =?utf-8?B?aE4wbU4xMkp3dWFBZkU2TXQyY1RWdVhWVjhpNW92b094MkF6U2JSazN4WlVj?=
 =?utf-8?B?aXFZeTRTZkJxajMySXVNczJ5Y245dnFkZVBKTEVEOE9xTk8zS1hqdTRvdW1Q?=
 =?utf-8?B?NWlNR3JrRjdKdkhRZTRkcWtyNGkyYlBwcmZVaVN6VzcwdHE3eXlMVFQ0VVM4?=
 =?utf-8?B?VTJxMEU0S3N5WE9LT3ZtNzl1WDM3WHJLVThaSEJ6R3FDdko5SUNXWU05OWE3?=
 =?utf-8?B?NlRlUHEwVVBjWEdTbjNYNStiNDJNcERHL3R1UXZUaGZhSkJYYjdva0R2emI2?=
 =?utf-8?B?MVcvQmpFMnBFU0pUMWJLZFJUVEN2U3p6VHBVdzM3bEJrK09mREtsRHluK2dj?=
 =?utf-8?B?U2piU3dYd2ptMXpzNXRJajRMK01zaTROZWlTTVN6djZBbFQ0aSs5QXNGN1hS?=
 =?utf-8?B?dVJDZVMzRjBuUWpscDI4SUxvcm1RaTk1Z2xFc1dNWGc4WE1vQ1hyZmRIdDNZ?=
 =?utf-8?B?R1hIRVI3bGhWdkEyeVYweGhlTnhJdWY2djFiazlkMGZVRUM1STlNNEdJS1lI?=
 =?utf-8?B?cmNtRVpBcExRZmxsaTFQZFdzQ3c1U1pMUWJ0ZXRJYmhBc1FxS3NCL2dDbmNS?=
 =?utf-8?B?Q2tXOFgrRXIwa3hibGpZZmtVUmFpWUZGclRNWlhZdk5mcXlzbXYyb1Bhc2p3?=
 =?utf-8?B?M01mWDdKcXk1Nk9OdXpLZGVjTndNd2R0anhLN015SjYxQWNiQU9uRE5BQlQy?=
 =?utf-8?B?aW15c2RqaWwyaEdqN2lTYWpWa3NKOHVIYTVhdm9nNE83bTBJQ0ZPR3hmSFFq?=
 =?utf-8?B?Ujd0N2tFTG5HRWpUOWg3UEtybGx6MVFoSm9aaW5EdEs0MzZ6azZWZnFFbW9j?=
 =?utf-8?B?WHQ2QlZBUmRzMC9ja3B6cGFJL3g0WlZ4Sy9SUHpRRDMyZnJ0NVhxMm1aNit0?=
 =?utf-8?B?OEEwQlhqYW1YN28zenFmKzluOVpYWnBmdUQ0QnB6NWRpMlVKMlQxa0N3eDJ5?=
 =?utf-8?B?Y0hJNWtUMlhpQ3FBNTZ6NTgxeHcvVTdpQlhOWjVzSS9jRTg4RnN0ODdhaHdM?=
 =?utf-8?B?WWtqRGRFaDF0VjNmTktZKzNGczR4Q01FYzhQM3hzb0UvV0VMU3hMNElnNkFM?=
 =?utf-8?B?ekRRS3NpRENndWtMbFpRVU1PeU5vM1hRRjdtTmF2UFJCWFhZSWZab05SQUk0?=
 =?utf-8?B?RjFqU2d6ZzdnTVdseUhqaWtkWWpRUTRkMHNLT253Zll3Y2lPWDNJSUxKNTRM?=
 =?utf-8?B?eExVWENwM2F1Vmdub0pJWHBPajhpWXNrZFBHMlBrTjFZNHVtc0ZHajhpREh5?=
 =?utf-8?B?dmdmWEVrczdaZ1htUHd4QlV2REszMzV0ODZYbDk3cEdFNlg0WlBXY0RKeEtD?=
 =?utf-8?B?SGQ1MHJIblhZdGpWeXIwYW5RRk1GYkpRRXl1MzhsTEdKbVVNZG5rY1pXbEFJ?=
 =?utf-8?B?ejdXR05OcjdUd0RCNlYxQ0NYcURubnFBMDVOcm02NkpBRldCeEljVUZvOEFU?=
 =?utf-8?B?aFVKRTdkVGcram92OWZrRGFmek01aVc5Qy9KU1p5OG03RGZNTGFrVDFHLzk0?=
 =?utf-8?B?emc3QW9jd29zaGFLL2hCajVYN1hGUHJ0dUlMb2J6eFRJSFJ3S1J4V2hhTHF0?=
 =?utf-8?B?a1Q4MTBrWk9oS1FpaExPVjlkR2ZDdFdVYi91R0R1SjZ3bmZ4RlFKRk1XcEs2?=
 =?utf-8?B?aE1nVnpFMkliUGhHL0x4S0lYdTdqM0FvVkRDeUlZZWNYMUtjTzU3alBqTzUx?=
 =?utf-8?Q?MAspz355XblqU1D0p/Nm2Sbj4ZKfYO3vOxiZTo6saI2ny?=
X-MS-Exchange-AntiSpam-MessageData-1: Ae5OYgh6HsSjFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93105e0b-d610-4a8e-3824-08df2e92307c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:09:12.4379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8Pn2m/lGkNCXlE1WYwMyIjJ08rGmBzuvDptLNtzcXzp/NeOEyAjSHQRUj17Asn9plJoaVJOnZUAp44DMTl1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq.rs         |  2 +-
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs     | 24 ++++++++++++------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs    |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

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
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index c5a2f08cda94..48f3116e8599 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -62,7 +62,7 @@
 use super::regs;
 
 /// Marker type representing the absence of a reply for a command. Commands using this as their
-/// reply type are sent using [`Cmdq::send_command_no_wait`].
+/// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
 
 /// Trait implemented by types that can be sent as a single command queue element.
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 13baf4398632..2c52ec78871b 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -158,9 +158,9 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
 
 /// Trait representing messages received from the GSP.
 ///
-/// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
-/// The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
-/// message with [`Self::read`].
+/// A reply that [`Cmdq::send_rpc_command`] waits for, or an event that [`Cmdq::await_rpc_msg`]
+/// waits for. The receiver matches a message's function code against [`Self::FUNCTION`] and decodes
+/// the message with [`Self::read`].
 pub(crate) trait MessageFromGsp: Sized {
     /// Function identifying this message from the GSP.
     const FUNCTION: MsgFunction;
@@ -284,7 +284,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -292,9 +292,9 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
-        inner.await_msg()
+        inner.await_rpc_msg()
     }
 
     /// Sends `command` to the GSP without waiting for a reply.
@@ -306,12 +306,12 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
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
 
     /// Waits for an unsolicited GSP event of type `M`. Events that arrive before it are logged and
@@ -327,12 +327,12 @@ pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
     /// - `EIO` if a message fails framing or checksum validation.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    pub(crate) fn await_msg<M: MessageFromGsp>(&self) -> Result<M>
+    pub(crate) fn await_rpc_msg<M: MessageFromGsp>(&self) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().await_msg()
+        self.inner.lock().await_rpc_msg()
     }
 }
 
@@ -348,7 +348,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
@@ -379,7 +379,7 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// - `EIO` if a message fails framing or checksum validation.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
+    fn await_rpc_msg<M: MessageFromGsp>(&mut self) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
index 54c40f29e367..156357dd48df 100644
--- a/drivers/gpu/nova-core/gsp/commands/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -190,7 +190,7 @@ fn read(
 
 /// Waits for GSP initialization to complete.
 pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
-    cmdq.await_msg::<GspInitDone>().map(|_| ())
+    cmdq.await_rpc_msg::<GspInitDone>().map(|_| ())
 }
 
 /// The `GetGspStaticInfo` command.
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 9f5ab08def2c..23b09fb875e9 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -343,7 +343,7 @@ pub(crate) fn run(
         libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
         bootloader_app_version: u32,
     ) -> Result {
-        let seq_info = cmdq.await_msg::<GspSequence>()?;
+        let seq_info = cmdq.await_rpc_msg::<GspSequence>()?;
 
         let sequencer = GspSequencer {
             bar: ctx.bar,

-- 
2.56.0

