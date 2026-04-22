Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14478F9EDD1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753FA10EA34;
	Wed, 22 Apr 2026 13:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACMU274A";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BF710EA33
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfm/G4hZhtiJ4oHUDjLEWyDDEqW98noAuoezBOmmqP6UC4ai6WC26/tr8G4AwyV9MwkzcQMRJtMx7GnTCPr05KsMsndoyf3m2LYTPgDuVghgZFSN/ZOAWMhKa4+iFwbAgR7jZdW2wnSli6Lhhuetw3XHlNVKd36N2Uu8ktIYJtQnbkmOqVEbbjQOGd006QaQWVTkfJYjcIP81/3EhHRJkHnHa7lTnACxWC1qFuR1DsbV52gM/lQf12OgdgnrHnQVY1mX4WBsCEqH0AC1t3mpw5eFcCrsTQ3obL+ZG25jDxvKSmN7JpWZnggVottbEl/O29I8oOsPgXdAeFE7W1QB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV6eukYANmNvNouhkF8m6FkmU2yWhQaU9nfaxU5oro8=;
 b=OpAAoiCjuk9/ecjxq8CWlsZLrslzlrZOMc/eyfRWOgSxKL+kd+uNlDnGMC5A95ryr5RjSvvUe4Srva5bpEYuGwXR2OQnKXWdSoE9kn/hmKza8USxbRk3ZqMg2onMQBwm1Yzene1Dz59OL6ITHCcV8MH/S1QVAz/GqWFEjelGnNp3YiuousUyw8TzEj/VJwV427vNipteL9H8JSNIQnJTnMaDD6GngKbZb2QfsxrQUr3G8rexcA+s8eHnVMxJ+XWbs/mvcfDtMHOlR+/3X116IfqJfR2USB6SgEFiz3Y2eaUnMHXytMxh3LuxwKtns5pBn7IoFHFDFKukdC/A7dLJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV6eukYANmNvNouhkF8m6FkmU2yWhQaU9nfaxU5oro8=;
 b=ACMU274AyixfIOjvSZw/C99AzF6bcrVj0t25szTR254ITQ1y/Acl7DqohqGMbJ8khTA+wvKzNIYY7fn4+aYzJal2NLy7og9cElR4E7lhtGtbHYwILqVH0XmSORWkxGxV/Qe+v7uH2sASaQuo33iKfApRBffFMo7/ZTEAaOK/B4wNYMVJmido4b/RbTeTzi09FU9DJDuvblOG81UvIOlHBYkUCHas+S85j/6F4hKCggx7oFDhfylWtAmWCKeJRENj1Q28lqTRo7H/yptYx3fqCc9OxTEH5idVzyW0X0bjgf5+sVdskZmXv1yu1xnlp/HkCRqxgVarfH+p/c9QqQCeRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:54 +0900
Subject: [PATCH v3 4/6] gpu: nova-core: do not import firmware commands
 into GSP command module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-4-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0348.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 641b5e00-cabd-487a-5e58-08dea074d327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QxVMzWOmvr/y8eu2ZUwC2VnEXGFRH7sFuChtX0SJcB6ipHZ90VUh7bghZ9MX7IKGW6y/DZKM3xNcMAcjujjXr0pofAWcDBcMrdssRmNRqEMqaNfl9TwyHNfiEs38OjF7rbGWx8eb44cQ2a8xmSdAJZz3h1S57NNFqRPYko+9dAiOVYeZrqzQmFEYWkY/I+cMcXTj2sNB30tUclxYe1KWmmX4cBjyXbaxr11iDSWA/IJqYSj/OESpKaF4u61jt2Ge4e4audKWKfD/WeT/bHDR3WftAbUNvMuqUd0teXfspZY7Ahin9Kv2+7HmOAWVoU3c9M7ZwFJSiT3PjELXPrTg+LrtVb8UwXytZ1ZZZAP8zNNUZqkNTq8WyTtQgedEVFJNePLQJe5DMY6Xo1CEbml4YFprCQxAGZXdCFgwL0NEjnniXY4cS+5evuBPJdxgc6qnuQtXoA7qltqnV2BrDXN+5sHEHMtt9Kbb82J5J1izsfJej9I0zYYNAeCVnLbdGwt9VVlgmKazJY0hV3Hjy3GY6BTlvLHCJy1AKj8ZwSSQbXhbDJADbVDUMWrdHfhvhSNwY0tNssQS3+17D62BNiAUZKEUQlOq66SoloBpkWwJ6gJnWEzxw/Xc5A37hno74u0/Zv+vShc5Akihe42cwZt/CduE+7rrjPCb3KX71aLXCwzkOW7X7uSmKV1PdIZoUF0EJ25k+i1mQbUcBB3M4eUUF9HbDm06aDlbrrEHwHyvAihBeHQQ+7cgjDeI6aTaMJph0ywbp7r7TJ5IiGQ4eVoKkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VVQkdlOTRjbitKTTFPYnZMdjltMzd4UW4weTVxdVlXY0ZRY3BWcnFVRmV0?=
 =?utf-8?B?S28yY0NTaUc4eGtPM3JodW5Ocitobm4ySm56TjROM3A4ZXUvWktzUGx2Q3pN?=
 =?utf-8?B?VHJIZjlDdm4yNjVUY0loYkVUYlBxbEtPaGVQS2d0aUV4a1VRZWxoSGh1VXVa?=
 =?utf-8?B?NWV0b0xFOTBkeWpQbmxyMDUwYXJJNGNucG5vQXdGdVE3UU5pQmRkcWhiaG55?=
 =?utf-8?B?YlQycWJSVXJRUHdmRmFOczY5T2w4RWd3azhvREd1N1ZwL0M1T2V0UGgrS3hJ?=
 =?utf-8?B?RzZ1b2JYV3lkUGwvL2RuOFMvZHlWb0owWkVuMFVYNS9sNkE3Z2p3cWRvL0lR?=
 =?utf-8?B?TzYrd2p5MFJCd3VHOW9kcWlWa2Q4S2UybFY0K3lKd0VLWGxMN3VoRVBteisr?=
 =?utf-8?B?WkQxWTJGdDdISnFEM3Z1a2ZRMnVHR1pxVm94ZFllOVp4UU85N3lML09ucWNi?=
 =?utf-8?B?b2xiOHM0aXN1ZGl3MXkzQWtBRmNTYnhQejNqTDRGcEtmaFdycEtURU9YYTdv?=
 =?utf-8?B?U3E0KzVtaDZBdTFXNWUwU1dVNlBwbUlzYXlUTEt6UGVuNEtHcE1JemVNREh0?=
 =?utf-8?B?djd2b285L2hacWxWZkRLQzA3U3E0elV4NHR5cll1MWJFeUZVbTczR3hoRVIv?=
 =?utf-8?B?SnBsZDltY3lTMmNoTmpsRE5HLzMyZG1CRmR4d1M4T2RvdXJiTlE2ZjhpRzZu?=
 =?utf-8?B?Q2xobHd5dTZlZWpqVDFqZkNUbjdiMGFCRWJ1TVFpcmVNUDJjWXo2N0dpR0tG?=
 =?utf-8?B?dnJyckVMSnM5SVc5T0pVNlJvWmx4R3VBV0FVM1dCMG1Ca0V3bGhyLzFxK1Nh?=
 =?utf-8?B?Y3JtK1QyU1dwR0szbmEzamVObzUvaG82R3BpY3lCLy9CcVVDQmVsZXVMSjBI?=
 =?utf-8?B?SDk5WmY2RjZTbkZ0enRzdnpSUVpmZjNBdStUZlkrQlZmVTRjV1B3ZVpGNmdX?=
 =?utf-8?B?RnRVMTViSUhVaEpSN1NjYUVOWmFYRjZsZVVyOUwxU3hLU2d5Q0Y0NFlVZWhC?=
 =?utf-8?B?Qnc2b1BvNjQrZnk4anZDRE5iNUZPMitFQkFKbi91OWpXekZHU29rNnNjSU1Y?=
 =?utf-8?B?dWlBNlpNWVZQcTkxZy9DKzhRNlVPTkhHb0ZZcXNlN2RBYURYeDgrU1FSbkFX?=
 =?utf-8?B?aVZXNElkTXN5T29lOWtUUzY3Qjd0V0FmRURWVU5zVTBHODIvTGNlNXljUWlB?=
 =?utf-8?B?VGt4R2U2U09ZSGZPbEo0K2YvckNBcTVCQTRmSGoxdmFKOHNmeHJMMzBTaWI0?=
 =?utf-8?B?QkU1ZXdZVFZ6NGJOOEswaU5qN1diNG1IaitvbnlGeStSMUxUaTNkK09EdHVz?=
 =?utf-8?B?ZWZOV21qQWhJYThFZkFHN1lsam1sNHVHOG5KeXBxVVpxZ0hHMzQzK3VuS3R5?=
 =?utf-8?B?bEFUTEpiTzVYRFRueXhRRlFFN0pHN1JOQTF4NVBrM0JCUHFwZ085MVE2dmw3?=
 =?utf-8?B?aEF1cFJyQnk5d0JGblFyenN6RDlyRzVHaUs1R3ZwS3JybnJNN1Z6WEtjZC90?=
 =?utf-8?B?Z2NsK0pEUnZDclJlVWdwd3JxSHBTMVJnMXJ6VVoxK0NXc2VVbVozWkxyRkpL?=
 =?utf-8?B?ZHRCL0JjNlRYT0ZyWlN4UGF1dENmYVpSVVgxRmQ1c1dXdjZnV2JrSmVZNk52?=
 =?utf-8?B?aHBnOUFwRGlMc1dNb2lzSGpCaXhnVitvVGwzZlVacVUya1QxL2FqeWkrZ2N4?=
 =?utf-8?B?Sm53eGxwY1lQamhhLzNsdmxwSE9KTUZyTWlZNW5XVGw1QlU4UjNUdmxNRUJw?=
 =?utf-8?B?YmJ2bUVhVktkUWxKTDZWMmpFTjNxZlo3K2kxM3FHNXU0ZWR0YkJIdW5Qbm12?=
 =?utf-8?B?d09sMHRpeFh5blM3Q3RBT3R3STBlN3dHck1vaUhWOFk2c0JPU2tlSlJCLyti?=
 =?utf-8?B?QnpST1FDV003a0t2S1ErNE5Kd1BwOUk1YUpETFFFUjh2Uk5jdXFnUytzaDJy?=
 =?utf-8?B?TjZtTzlraXd6MXVtTm1IZU9DYlBOMVQ4MnFmWGwwdm1pQjdWalE4QnI1ZTRt?=
 =?utf-8?B?elJvay9mZzFmUXkyNC8xY0ZvVHRhbVZXMEg0VWVmb21UY1dEdCs1Yk53Smpa?=
 =?utf-8?B?OU9kbHliaGpqSmtmMXIrTDBkU2FIUUJLSE81U3JaTWhMZjM2dXlkZUJBTDF6?=
 =?utf-8?B?QzBvTkU3K3FFTktBaHh5eG5BTWdydGE5Z0cvOW1RdXBrNUxLaUUvL1NPWHV0?=
 =?utf-8?B?R0ZQNGdLaGFEMkM2K3c5Zy8xWnNGa1FXcTFtNjBWdUczL0hKdUMvWVBpV1Yz?=
 =?utf-8?B?SGhKdWtabXFteTA0ekwvVWQzMWJPSkJDT1AzSEtzZGpzM0I4dklZWHVuWEtq?=
 =?utf-8?B?TSs2bTEyRVhGTUM2Y0NCdFB1NXVsUGVZQkNwMlZ5ZWlobU5SVHlVVUE2RmtV?=
 =?utf-8?Q?jzjYUE3fdfVo+x0WIQQ1GDSIBFcH+EryLCQVZZrGTsntk?=
X-MS-Exchange-AntiSpam-MessageData-1: OmhyaqR2EAcB6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641b5e00-cabd-487a-5e58-08dea074d327
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:15.5332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoI137Ly8t0c31GVdfht0ZqYUPKUIA/qvyFXCQVQ7jW4BzCa9X7ZlHxtbknAk4qyvnEKueyyJeiHz+SFlAJJ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

Importing all the firmware commands like we did is a bit confusing, as
the layer of a command type (fw or GSP) cannot be inferred from looking
at its name alone. Furthermore it makes it impossible to create commands
that have the same name as their firmware command.

Thus, stop importing all commands and refer to them from the `fw` module
instead.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index e81a865050e0..484aeb7dfd39 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -26,7 +26,7 @@
             NoReply, //
         },
         fw::{
-            commands::*,
+            self,
             MsgFunction, //
         },
     },
@@ -47,12 +47,12 @@ pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
 
 impl<'a> CommandToGsp for SetSystemInfo<'a> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
-    type Command = GspSetSystemInfo;
+    type Command = fw::commands::GspSetSystemInfo;
     type Reply = NoReply;
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspSetSystemInfo::init(self.pdev)
+        Self::Command::init(self.pdev)
     }
 }
 
@@ -99,12 +99,12 @@ pub(crate) fn new() -> Self {
 
 impl CommandToGsp for SetRegistry {
     const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
-    type Command = PackedRegistryTable;
+    type Command = fw::commands::PackedRegistryTable;
     type Reply = NoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        PackedRegistryTable::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
+        Self::Command::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
     }
 
     fn variable_payload_len(&self) -> usize {
@@ -112,22 +112,22 @@ fn variable_payload_len(&self) -> usize {
         for i in 0..Self::NUM_ENTRIES {
             key_size += self.entries[i].key.len() + 1; // +1 for NULL terminator
         }
-        Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>() + key_size
+        Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>() + key_size
     }
 
     fn init_variable_payload(
         &self,
         dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
     ) -> Result {
-        let string_data_start_offset =
-            size_of::<PackedRegistryTable>() + Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>();
+        let string_data_start_offset = size_of::<Self::Command>()
+            + Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>();
 
         // Array for string data.
         let mut string_data = KVec::new();
 
         for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
             dst.write_all(
-                PackedRegistryEntry::new(
+                fw::commands::PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
                     entry.value,
                 )
@@ -179,12 +179,12 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Command = GspStaticConfigInfo;
+    type Command = fw::commands::GspStaticConfigInfo;
     type Reply = GetGspStaticInfoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspStaticConfigInfo::init_zeroed()
+        Self::Command::init_zeroed()
     }
 }
 
@@ -195,7 +195,7 @@ pub(crate) struct GetGspStaticInfoReply {
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Message = GspStaticConfigInfo;
+    type Message = fw::commands::GspStaticConfigInfo;
     type InitError = Infallible;
 
     fn read(

-- 
2.53.0

