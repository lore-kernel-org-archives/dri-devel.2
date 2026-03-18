Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92394FCD0A7
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0485510E72A;
	Wed, 18 Mar 2026 04:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmBlqTO2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F63010E72A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3Rovn9ltXkc/qEKg3nDrX6CeYnO+vn0kviBTIsnSi7CC4jKLb1va+jHfeKnRUSiRannocwtFD8WdxxI+uaTExNYEoHFPVtAXa3y/2AzzeEw87zXbk4F0s9kDcuxwEDe93PIwArMwDvQeGgF1OUUmvzv80eyHOZtB8CnBhsbdvJ9Wl3PNyEq1HcNOupBpYojg8SrKoFkKS/sylKisTxRvvOrhKev33xRa4yxITVkbw4r8isRiyNLRO0ygIvIusXe/jROVPNvRX36e8i5J+BvJjxnEW5nuoa5RRB0+GuZtRB2F1OkxqTO0bU0wRaMFlXzFpjrzZsVQEZlqxijJb1l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWzBDG/QxRbwJx7SQgDrh1kHKoXiWoQmLIJ2EiVGfCo=;
 b=caLVn2AKr0MffcPgm1bq9InvaTTRCozFPIf/Es9dwCJO4xpf3ORX1k0WpbC+PceomAbQaqwUmakncGXqwa6lCyxDPlHPRfNMbgEcPu2z0Cing/tKKA7SJiEj+R3SB2THErlkI2fg8cLFK3iuqViL6OhdAr9GYgHENqOGyMextQP9wpIvOgPRCzdh9EX+gOtrTV6dyc6NQQZT7ulkaFwPSbyII/SbNaASdQQ/j6Qkr9f16dhfJg+2p54eJaqUiocbuov3sr4g7KOnEQT1zWI9DZS8Poe7CpYZyQadOmLrIZ+UUCVSbiIG330DY/J5mlq/r2BD4jVWJiDR2JdDkO/aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWzBDG/QxRbwJx7SQgDrh1kHKoXiWoQmLIJ2EiVGfCo=;
 b=gmBlqTO2oyDh3scyrL15cKIsbcETOffku0IKBYAqspZRj1ORVPNIfR10GLFSaYIFpLYxdN+ByyFKwsY2CtDp9Dx7Ju3hm/jqei4o9Q9SrJVdnvMl05S/oOFAExxUQgA+APgRYbFTPiSe5XSHzYfvHQVefJ7/z0x2Sw7o91J0LIHjxbXnAghfrxQJOfiGs3XTWIJVlkAVxnFiIKW5ZgySKiO6BHG4buHSOUGMjlOKYmK5+f+A+Sg/b7Dc7216ggKsMMMSLtH9IQnjJMF9hXbMitZiAMSYJ1z2MGt/zVnUNQY4VZbH3CwR78+UQ8ehoubOculwvaxA0bGB8tYhCv+FKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:07:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 04:07:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 13:07:11 +0900
Subject: [PATCH v5 3/5] gpu: nova-core: gsp: add reply/no-reply info to
 `CommandToGsp`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-cmdq-locking-v5-3-18b37e3f9069@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: d70f1058-4e82-4567-2627-08de84a3e9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4NgrzoulrQTVfkqbN4zRON0tfW4hsvh11RGP3zy+iG/pelbZJgLnvbgAPB0xq+9BAxcn1bzYplUQvrVfmMI1+Z4R2x4uLxrMYRNDm4bzDomBpCbUJGyNDy16gWeOS/XkrMF8QlQWyrtPiA+/owj7LY4qYUCjuL5jDeg9Di1g1dDN/9P4YWDibvLvTyFQGkj2LSuRe0246ADVGRrB1Kmqq5Lh8odjQ3PthfYvClQpDjpt8/AhVLBKEUYKywqbYvBUC8e4k4IfLYl1PYMXwGxYEk8u/9IsOk77Zj823TVsJNc5t+anbGJcu5e3gkQwFvDjM9+Kz6adtkMOTXH8MgJzrh9Z8gzXxpsvZGuKxkoxT5TkEsrDIlCw25F5o4hxgmqpBr3ITvKKeylrUokgkGynDZovqh54LVEwBExdV4gXz4MmaziJr0Hd/OWLmTHATvXOZw7ZGuPSRi8IURbr6TF6kljGMHo/j7Y7w/aujdvUmpqGi04zUS/g91XzuNBziYHpKf95X6swBFdIuoutWhX/kdxbauWWN2QySEMxDD3hp4kjZ359oqUdSjB/cknCEKjrOop/7vxbiYYHqI2G1KlQ4T8hapmUyQI6JiIQHYKkiTxm09pFzPoGuFf4tY6+xHn9dXjaIDu3p8Iqcz0yB3q0k7VQIDTh/GXn/RiwHt3fk5DQRBIAqNe49up+GjEQ9wr6fY2RX8sq4E9zFH1eiRnzmgTV0J0T4ELsaJJ7UArmWkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWI3TnBPeDQ5Yk1NcmQ0UGhvR0RvcW4rRkdtTTlydElDVWF0bk9RZzZyTzdT?=
 =?utf-8?B?UjZiM2pESmgydUd0N052b1Y4UGE1NWw2YzV4ejFsclRiNjZSTVI2Z1E1U1RD?=
 =?utf-8?B?dFk4S0l6RjlpcENVQmthTWU5aXpLQ3BhMXhQVXFTZldaKzN6b0srSlNBOHZl?=
 =?utf-8?B?cG1CRWExcm4waFphWnJxSEpxZ0VDMnJibEF1S0xlVkdhWDNxS2ZkS2pJa1Vi?=
 =?utf-8?B?V0pOTnd4S1haZ3ljVTFyYVhYTVBYdzArL0FtdElrc1dONGNMOEJ4bjNvYkp5?=
 =?utf-8?B?Y1VWS2luRGd3bWRvK1MxMThDaDZHNUMwRk45Q2FNNlpwZkZtM084b1JYNXBj?=
 =?utf-8?B?NXZqWTVlbjF3L0VTSFJPY3RvT0duODRkbGdEUHJtOCs4dVNBL1h3MjdWZVVs?=
 =?utf-8?B?RVZ5Nk9VbEh2RzdCeEdrb2VjdlZkVzZPczBiaUxEQkZGTHNveGd6dFpFeGY3?=
 =?utf-8?B?c2lZcGMyekdwcHdUTjdVcEluVHFGR1UrVUxvV0VJcjJITXIxME9SenVDY1o1?=
 =?utf-8?B?cXlYRXA1U0wyM3BXS01ac25CUlQ5bjJaTGJZRUhmWFZSSFJnOU5GMkdxcnVQ?=
 =?utf-8?B?ek1qUDI0bE80OU9IS0dydXJEZzBtZkxzUXVYbG5EMDJLVFpNNG0xSU03RFJ5?=
 =?utf-8?B?VERWUEg5cXhJZmZNYzNQSUlKUWJ0NnZhazFHY1JHY2R0VWJCQmVCaGxaU0p0?=
 =?utf-8?B?czRYaTlubXZCTzd0MEdhY0Nib1lud3oyZkpwbVoxSy8xQlhZa3JUQmFvejZt?=
 =?utf-8?B?YkhyU2M2LzBWVkh6NzBWd0wxRy9uZVpMZTNpNlJjS21YTmZNMW96dE52TkVs?=
 =?utf-8?B?M01pQ0c1RzFORVF6cndsT3l5TDV2VUFHaUhSWUk1MlBRaTFvVzZZM3ZPOW9r?=
 =?utf-8?B?eFQ4OE5YdHNwejJiYlZZOGVWRStOSzBMUU11WG1Hem5Ic252d1R3SEhSc2hB?=
 =?utf-8?B?Z1h6WHBXeW1uWnRSVzFpV1duTzY5aE9HcjNFazFTWkJ4K3RaYjdMRVE4UUdn?=
 =?utf-8?B?dkhvcnV5T3h4SVJMSXhRZnppUkliRHlWaXZEYmtyNWhjaWErYzlCNCtubVVS?=
 =?utf-8?B?T280cWplWURnWkwvR2kyTVp3elFPR3NkRTRVdEtHZDkxTDU1T3hHZ09HUExR?=
 =?utf-8?B?b1ZDRmtPN1AvNm94Q0wzZGs3QlF2Q3Y2TXJLcG4xaVhWbmpOUlJMSERGeEFi?=
 =?utf-8?B?SnJRd2xhYUhUNVA4a0RhdDJUdFQva0QvY3hMeitUTW9BNU1YelBZK0RLZEYy?=
 =?utf-8?B?a3ZOdW14a3h4RWJjWlFmNnFnbTFReEduYXZPM0RPTjZCTGpOZ3FERHRpVkNU?=
 =?utf-8?B?aVdSemRzTEVVYXRKaW1yaHhEUzlJZDdxNTdyTVFyTEdxSVRhd1VNVHFKUkxD?=
 =?utf-8?B?L0VRVEZlbUpQaVN5WHNiUDhUMVk0NlQyQzAySFVNeCtBK2xYRWw1QUFlUzNq?=
 =?utf-8?B?TWhvSHJCODVYZU5TdXBSQm5lWHNXMmNLRSt2R0JlQkVORzRTMXVQWUJoamlY?=
 =?utf-8?B?UzAxSU9mdGJ5bzgwUUhaejdBWmhaTDNuQ3VDK2tnR01HSDFuenZaUXJXZ210?=
 =?utf-8?B?Q1pWY04zbzI4a1FRK3Z1bFpNRzZ1RVRTZEdGaVYwMHl4Mzh5aytFcnlYRThX?=
 =?utf-8?B?RE5BOStvY2tRZ0Q4L2lvNlFxRHpPUzBJOFlJZ2svbVZHMlRZZms3MFJCQTNM?=
 =?utf-8?B?WjJBbG5ScmlnWjZYekZ3SisrZVR6S2x2ZzFWV1RRaWxnYWwvaGo1b0RJZVlU?=
 =?utf-8?B?UE13aUVYRGZOanU2bCs2SExOSGxZR1F1MnN4RlJ0RXVvejZmTmpibG1RU3pp?=
 =?utf-8?B?S2xUd0FiSkw4T3JMbklPMWx3TmY1Mjl5ZGordGFGS0Q5Z3hHYzFwRXRyQUpO?=
 =?utf-8?B?cFhJOWtzclQ2anZrVThEVk9SK3pQUW1VL1JDazhMdkxuT1RQZmlFQ2VMb1dy?=
 =?utf-8?B?VjRWVGtwdTd3RlRLeHV6aEJRS3h5OUVDRWJ1UDVXdFJNZ1NnT3VLMFMzOXBO?=
 =?utf-8?B?ZVIrUXRGazVCKzNxcURNbTFDMFVhYmUxN1h2RHVHZzE3Tk5JV1hVVTJINVlD?=
 =?utf-8?B?Vk1MK3d2eStMcUt2NXozaFNxd1BTQURwTVlWc0NyaTdUZ1p2bThrM05ZWjA2?=
 =?utf-8?B?dkVNRWtKRWh0RDJuQnZ4ZHJ2YjlEWS9hQUZKWi9LNkRkcDg1K2tiSmNpeWVk?=
 =?utf-8?B?dmlmeE5xZ3AwNW9pQ0ZQRjF4WkdHaFloUGxPZlVsY2U4N0d5UDVTZExSeTIw?=
 =?utf-8?B?M2lNYVEzSDM0aU40RDRZRytCektRd2c0UjAyeElSLzlVTjdRV1d5Si84WHFp?=
 =?utf-8?B?emRVek1HY2xMcTU2OFowMGRoWHE3SUFJQmhRd3RwREZoQVJSRG9XSXVuVzdl?=
 =?utf-8?Q?syZ8tocWscjjLyo9tAsgHGikET/F6FzvJXqK8ssw1yi62?=
X-MS-Exchange-AntiSpam-MessageData-1: RBZ2qSsZbAn83Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70f1058-4e82-4567-2627-08de84a3e9d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:07:47.1969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI6NCi1P46lh5J6MnC/2oPMmlto91cNVuIN7FbBavvviIcaTMgMjUTnyieApGD2kfIhPQ8Bzy3nyYD85pDhMKw==
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

Add type infrastructure to know what reply is expected from each
`CommandToGsp`. Uses a marker type `NoReply` which does not implement
`MessageFromGsp` to mark commands which don't expect a response.

Update `send_command` to wait for a reply and add `send_command_no_wait`
which sends a command that has no reply, without blocking.

This prepares for adding locking to the queue.

Tested-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs              |  5 ++-
 drivers/gpu/nova-core/gsp/cmdq.rs              | 62 ++++++++++++++++++++++++--
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs |  8 +++-
 drivers/gpu/nova-core/gsp/commands.rs          | 16 +++----
 4 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 6db2decbc6f5..ffc478b33640 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -169,8 +169,9 @@ pub(crate) fn boot(
         dma_write!(wpr_meta, [0]?, GspFwWprMeta::new(&gsp_fw, &fb_layout));
 
         self.cmdq
-            .send_command(bar, commands::SetSystemInfo::new(pdev))?;
-        self.cmdq.send_command(bar, commands::SetRegistry::new())?;
+            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
+        self.cmdq
+            .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
         gsp_falcon.reset(bar)?;
         let libos_handle = self.libos.dma_handle();
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index c62db727a2a9..4fc14689d38e 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -45,10 +45,14 @@
     sbuffer::SBufferIter, //
 };
 
+/// Marker type representing the absence of a reply for a command. Commands using this as their
+/// reply type are sent using [`Cmdq::send_command_no_wait`].
+pub(crate) struct NoReply;
+
 /// Trait implemented by types representing a command to send to the GSP.
 ///
-/// The main purpose of this trait is to provide [`Cmdq::send_command`] with the information it
-/// needs to send a given command.
+/// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
+/// a given command.
 ///
 /// [`CommandToGsp::init`] in particular is responsible for initializing the command directly
 /// into the space reserved for it in the command queue buffer.
@@ -63,6 +67,10 @@ pub(crate) trait CommandToGsp {
     /// Type generated by [`CommandToGsp::init`], to be written into the command queue buffer.
     type Command: FromBytes + AsBytes;
 
+    /// Type of the reply expected from the GSP, or [`NoReply`] for commands that don't
+    /// have a reply.
+    type Reply;
+
     /// Error type returned by [`CommandToGsp::init`].
     type InitError;
 
@@ -581,7 +589,7 @@ fn send_single_command<M>(&mut self, bar: &Bar0, command: M) -> Result
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result
+    fn send_command_internal<M>(&mut self, bar: &Bar0, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
@@ -601,6 +609,54 @@ pub(crate) fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result
         }
     }
 
+    /// Sends `command` to the GSP and waits for the reply.
+    ///
+    /// Messages with non-matching function codes are silently consumed until the expected reply
+    /// arrives.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
+    ///   not received within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command and reply initializers are propagated as-is.
+    pub(crate) fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result<M::Reply>
+    where
+        M: CommandToGsp,
+        M::Reply: MessageFromGsp,
+        Error: From<M::InitError>,
+        Error: From<<M::Reply as MessageFromGsp>::InitError>,
+    {
+        self.send_command_internal(bar, command)?;
+
+        loop {
+            match self.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
+                Ok(reply) => break Ok(reply),
+                Err(ERANGE) => continue,
+                Err(e) => break Err(e),
+            }
+        }
+    }
+
+    /// Sends `command` to the GSP without waiting for a reply.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command initializers are propagated as-is.
+    pub(crate) fn send_command_no_wait<M>(&mut self, bar: &Bar0, command: M) -> Result
+    where
+        M: CommandToGsp<Reply = NoReply>,
+        Error: From<M::InitError>,
+    {
+        self.send_command_internal(bar, command)
+    }
+
     /// Wait for a message to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
index 2aa17caac2e0..05e904f18097 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
@@ -6,7 +6,10 @@
 
 use kernel::prelude::*;
 
-use super::CommandToGsp;
+use super::{
+    CommandToGsp,
+    NoReply, //
+};
 
 use crate::{
     gsp::fw::{
@@ -63,6 +66,7 @@ fn new(data: &'a [u8]) -> Self {
 impl<'a> CommandToGsp for ContinuationRecord<'a> {
     const FUNCTION: MsgFunction = MsgFunction::ContinuationRecord;
     type Command = ();
+    type Reply = NoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -144,6 +148,7 @@ fn new(command: C, payload: KVVec<u8>) -> Self {
 impl<C: CommandToGsp> CommandToGsp for SplitCommand<C> {
     const FUNCTION: MsgFunction = C::FUNCTION;
     type Command = C::Command;
+    type Reply = C::Reply;
     type InitError = C::InitError;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -206,6 +211,7 @@ fn new(len: usize) -> Result<Self> {
     impl CommandToGsp for TestPayload {
         const FUNCTION: MsgFunction = MsgFunction::Nop;
         type Command = TestHeader;
+        type Reply = NoReply;
         type InitError = Infallible;
 
         fn init(&self) -> impl Init<Self::Command, Self::InitError> {
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 88df117ba575..77054c92fcc2 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -23,7 +23,8 @@
         cmdq::{
             Cmdq,
             CommandToGsp,
-            MessageFromGsp, //
+            MessageFromGsp,
+            NoReply, //
         },
         fw::{
             commands::*,
@@ -48,6 +49,7 @@ pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
 impl<'a> CommandToGsp for SetSystemInfo<'a> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
     type Command = GspSetSystemInfo;
+    type Reply = NoReply;
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -99,6 +101,7 @@ pub(crate) fn new() -> Self {
 impl CommandToGsp for SetRegistry {
     const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
     type Command = PackedRegistryTable;
+    type Reply = NoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -178,6 +181,7 @@ pub(crate) fn wait_gsp_init_done(cmdq: &mut Cmdq) -> Result {
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Command = GspStaticConfigInfo;
+    type Reply = GetGspStaticInfoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -231,13 +235,5 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
 
 /// Send the [`GetGspInfo`] command and awaits for its reply.
 pub(crate) fn get_gsp_info(cmdq: &mut Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
-    cmdq.send_command(bar, GetGspStaticInfo)?;
-
-    loop {
-        match cmdq.receive_msg::<GetGspStaticInfoReply>(Cmdq::RECEIVE_TIMEOUT) {
-            Ok(info) => return Ok(info),
-            Err(ERANGE) => continue,
-            Err(e) => return Err(e),
-        }
-    }
+    cmdq.send_command(bar, GetGspStaticInfo)
 }

-- 
2.53.0

