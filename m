Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FF8FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E23610E58A;
	Mon, 27 Apr 2026 06:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4nGvrs6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8DE10E58A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcfhT7WhwxH4KQVjRcICnu9RBSNC0q7xG7GCMfLtMbKul+XfiV5KWIoycBmcBYdtPpg+DQHLl6qDf8bbeGfvyiuHf8qshj7RdYT1s2HTdDDUv6ODKv5sJhOk2fSIBBxCrtIQHAfwgVzqBnpovr2W2E4bPahMuEPRyQp3/I3oSIaBPsCoy3Rxd52eQbp47kvg2mSIVaB3QQ6nUMPpck+ZAJTvlFKgvEhEC27VSzqjz3KHu+uWbZ/Ns6PnHqng2ITsTgbz5+2IZWuzfTJ2TGHVxuhzZYbzAfJQh1aH3RnftjzaVJzcdQPn1P0Ta2EFQiMPcpzN3Sub4lRSwoWyifDvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPY/2ePOSyeAVjGA7NblcZAYGjaNSyNZ9IE6vcSF+zY=;
 b=u6mwO3OSvXKgWBAyT+wlPUrnbMmnoP2RXPlSkfJjuH78AkEOy61v733rUX5Ws8oSwDF999Dw8H/deDvcEIpFT9RSYwp0j1dEPBHH/8mn1PdtQVNTifdfoRsv7sP5cDWMF/58un4DBqtQ81KYPLWj1d+K9nuDfke0AFEvQTwiYIIZ0gHbsBM64q/8WbbMgWDJ88z9oNCovii2MEdykkDONzq5UWEedkbz8pu/YDqO4RsrhkyCGhDKYmxJnzFGn1/CkOr3m6opOC6Am6ooPxPSxpRlJ78a2i/ULwmEeap+OMMH0+S1I2qDmx1QTvZBUmqxwJmQtUYo4kRNUvXmK3U6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPY/2ePOSyeAVjGA7NblcZAYGjaNSyNZ9IE6vcSF+zY=;
 b=N4nGvrs6azDpN91rW8sySR5grCeY5AZ+IpZFnUxQx7p+skr+7Md0l7/o7S5MN941lddo5ZmlJMAWBhTkB9afkCeFGa50E5gMUVxLkc1S3JLIa8cGCd5pP80g7YCWjI16rUurg06sktYxa2j5z/+9sgNBScsDcaBomFnLgXc2ZcyawhjZogC5ULTuCnX3Y+CZtTsGajUPxKjGtEaBK3aMp59GOYgHDxjeM7TsfyRp0Kgl0mDXlyTSrdNDsiNRf4hBuvEcc4G54WB1sKPLa+IbUcJP6Jengy93WDUgbnnRZukn6dseDmw0ZeYIHReY3iMUIGOuXEuyr+GP8Z0Yg9ul5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:56:59 +0900
Subject: [PATCH v4 2/8] gpu: nova-core: do not import firmware commands
 into GSP command module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-2-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8380e689-c167-4d3f-a827-08dea42a35f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fjabmPKvVHlgDqN89M3GwefxlKtyAq5TKmIljCazBREcRDReV9e3CMJdLQK163wuxrdS/KLPRq6DZ+hFzDm4czKkoTnH/v52izw0zT4DD4dxutOndragtDMXAEzjqCxCl2z+r3v/s5haI0mhhgrpjrmY+wGspnHmW648e9kQWEibhYnz2qPCTCkI7eejyHkOpk6uYxjdtoLj8ZZ7ZNB2u30H64sPduZF1pBURgsvNKFlYtpShl5YMBANGivVtlAIUYDoW4vTCaXkqd6G3GG/M/cGuvjWU7aMIuwt5egp8yEsI/ntYqXJIFgbGWaBAlntfDGBYlNgXk/bc8XKMwZBD08SivCdBbOiSlVU+SPkkhLy2bHGDgFprYVXtTudd81GAr/YEXM4mEa/v6AMPJv8NZXLiMxMVzNRmAVcBV4RA+FThZoJIyp3XsGc5IHOcyhQe0sP3G94Y+hErnSHO+uOfwpixOEJXiFYAu0bTEx9tCfpwAM8Sr+T41SaaKtmWb6OWvc9F4ZlS8+VA48gclgDAkVd2B/GyJkv3WYV4nx1MwNd7uvRnLBtq1r9Vm78D6xm9EvGxcWUV8OX+uyRnAj7qi8wjvq3BNads8BkZC2oRYq6QG/rM734I7Gy8WgaHT/GqFzvo3XcqW4lcqptZPyqUxrvdFtKU5E940UQyLVK2JfFX13kWYh5rvkFtT46BvnKyUnG5pcSzt2jClBS1YdaowNAHmOVJTTF+0sV21hHsDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBXUDRuRjFQZ29CMXRGMjhpeGZvOHNURm4vWDdncjRreEVVRm1vSXB2WE1o?=
 =?utf-8?B?Z0M2ZGtlamErS25TdC9HckVadFkwTG9rbGpRTElCSzZ3K3FCRm5JSE1qZ0FP?=
 =?utf-8?B?ZXJuRGlkVHdLMlQvdzhqZ1dVWTV4QjFKK1F2M2xmWHkvdm1xQUREeTJ6aUYv?=
 =?utf-8?B?blBYTGxpTHdXdDI4Ukk3TTRzaWpPTjlFMUNiaW5HQjhKMG12bWU5dTlWOEFF?=
 =?utf-8?B?NTBidWw1NlEwdmRWTzNHTEZCT2g2TURWbks3eDBrUEMvcjRtV0hQenZXUXNY?=
 =?utf-8?B?NzVYMllTeWxjdnlxQUpjTFpyaWMxZDA4TDYremRSaHJJcElNT2oxdUcyK1JX?=
 =?utf-8?B?R0FWbG5YUSthMU1tUUZDeS9QWFB6WEdyU3dlUmlRYW95QklZZHlOVXVyMkxX?=
 =?utf-8?B?OHpOeFBRTU9Tc3VMWG9hUCtpZ1dobnZIYThZVi9pajM4azAzQ2ExYjJkMlRK?=
 =?utf-8?B?THY2Ynp6bG5Bc3ZQSDR2L2Q0WXRXZTZQRFdwZUVXVkZCYitpTmJmeGYzUUpl?=
 =?utf-8?B?eW5ybnpyQlh2alJCN0d1M3g5dEhmcDEvRkw5VEhBTjNrc21UaXRLWk5rM2t0?=
 =?utf-8?B?T2t5b0R6eHZGcktqYldLRE1TNnA5TlF0RDZWTDVrWGdBTVVaODhyMDBhM2kr?=
 =?utf-8?B?T0RKSnc0c2RKY3hnYll6VjROd0kwWDdoeU9TNTdpRXJQTDFSb25WQWJlTVgy?=
 =?utf-8?B?WUNHbWZzMVRhVnYxdExmOUtIcU85L29IemowWG1WQTZFeFgybjYrU1RZT0dE?=
 =?utf-8?B?Qkxwd0p0Ui9RbUxjVEhobGtNYXRpRkR5eTkvcUNyZ1lTWXZzbFNJem9tcTl1?=
 =?utf-8?B?NjJCSEx5ZnNaRXBoNXlWWTlZYXBFb1NtMFVWb1A2V0RxUitFcGM4TmgrcEFK?=
 =?utf-8?B?SFF1bmx1L3V2N2g0ay9GSlJTcVRyMWQ2Y2dXbjQ2UWIzSWF4S1RzSUl2VFUx?=
 =?utf-8?B?ZldxTGVzK2JuVnBTck1kQXByOHRzaHFFZnhydlAvR1BzdlhHeGlSUTdOOC9V?=
 =?utf-8?B?QUwyck10WFZKRTJsc3Q3aDBpb3EyOFIzdlRyUEtmaGZVK0RxUGg3K21hSStM?=
 =?utf-8?B?aXE5WXdwUkRRTWlQcUtoa0gwbmZObHZiVHptRTY4cElVVWdhVWFXbDBOaUpM?=
 =?utf-8?B?OCtXdmhBa2xsLytVVm1EaFFQS1Y4K2lZMjhWYlpYZEw4dFZOM3lvK0JCdnB4?=
 =?utf-8?B?Y2NYeG5PZW1KYVBGc1pFNkJjYkFHSW15dlZMRVdPNE5weThaRWxMYTlONnV2?=
 =?utf-8?B?OVJYU2IwaGNEUURTcFMyTXNxQTVMaDdId01kQS9iRmdMcjE4NFdTcDROUzBm?=
 =?utf-8?B?ZWpqRG9YVGM4RlVVS1E5S1BRY0V3Q1FpeG5kRzNXRVBpQmxKTzllVjRFMmM1?=
 =?utf-8?B?Y0hDdHNNajFEczZQSDdSaCtDNW5Mdlk2c3daOE55K2ZheHlnQnhzTythOGhs?=
 =?utf-8?B?dEpQdzVVclg0NThTdnRRTmZkUUUwdWttOW16eFNhVElnaUxKWkJVdEQxR3Vo?=
 =?utf-8?B?RUVrNlJVbVd6LzJHTTZkYm5kYk5QbGhXaG1lbU4ybnhrWFN4UnIxYkpvR0dR?=
 =?utf-8?B?YXhPS2R6RC9YU1NTbUg4V28ycjkrU0lNelM2VGdSdWMrdU10aW5xOStsNTdV?=
 =?utf-8?B?R2FOUmxqSXdRdXEwbzN5ekxxaXo1YnQwNVAwb0FhWlpRN3NoZzM2MVUvOTds?=
 =?utf-8?B?SUR2eHJhdHd2a1RLSzBMdWtqTVZ0NElkdTRkNWIxMXhrdWpKQ3gzeFFGMk9Q?=
 =?utf-8?B?UXNJY2dTVGwzUFVWT3prQ2N6RGZmWWNoRTJ5cXRaSlJYYjVQVlNLdEo5Qjdw?=
 =?utf-8?B?eGc5WHQ3b3NwQ0dwRzJxM3FOVTVFYndzVWJscFdkYTF5Rjd3UW5BdE00enh2?=
 =?utf-8?B?MG16VXViR252dldnQ2w3Y290dms5QXpQSG9NZXUrUDVjOHpBMGM2STVIdmFs?=
 =?utf-8?B?dmRaaStzUlRzc3h3RkVIaWJWNlVDTWR5clpzQm43SlNhZktVV0p4WERESk9L?=
 =?utf-8?B?VGZCNE9oVVF6S2crSXNLSUtUS0hBL3NEeTdUYUtLRXpJa2swaDVtV0JJY05z?=
 =?utf-8?B?eWlvai82UlZaemVtNi9zaTJmOHRZR1FFdzNDNVVKQ3d0ZUdRRDZnb1VPVjNR?=
 =?utf-8?B?UzhOdmp1NjVnNnhoV0JWeXpkQkRYdUE0RW9yK3p0Zk9QZzkyd2c0RTU4S2kx?=
 =?utf-8?B?cjN4V1JMbmcrUDFYekQ2aWJ5NlBaQjJPSkxLa0ZtWW8wOEg0UTVHd1g4L3hT?=
 =?utf-8?B?ZzJ0WU9vVkljeTFYY0VwQ3RTV0Qza3VTRmRyOFI2cDZRQ3Ywamp0akFxOUZj?=
 =?utf-8?B?aDVRejk2cnVBY3BCQXN6SElORFJUSVA2d01SeW1lY3BmbHNWQXJuWFJhbG9W?=
 =?utf-8?Q?GkF7Ql/7BCfbLytUHxsWIp2q6nz3/ZR7cQ37uo8nTiB0b?=
X-MS-Exchange-AntiSpam-MessageData-1: RwWpliGTUM1nmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380e689-c167-4d3f-a827-08dea42a35f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:13.5479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEoMG4YBALEo2tCKPMR9+xmbGUU7WzzRjwW31Q9MFIJCl1MDzKMMktN0ntdD4K+AsFNJxq1EkQeqk7RG6SY8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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
2.54.0

