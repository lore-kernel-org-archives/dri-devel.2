Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C93CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C4710F3ED;
	Fri, 15 May 2026 06:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6CrqHg8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7032410F3E9
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcWWykoltThtoemRKDHy0yaX8QqlkOaM8YMqBhbAbok9YYQDZxp2axmUd2PPajaEcudBSKNk6KXbBJvCDH4Uh8Khalfb3a9upuR+uNUSKS3EetgFOgU4I0yUXWvGU0hTvWPYitlm+gcOm+iLVCiOuD2F71h3OvB8ymilf3X3ITCJ8OGDWNLntrsZwq1QkW/VquLHyUD12FGZgEYVJr86AV11uaA6bEmZKDRmtPRpR5nJJJXPDCoF3OaQ+dRWppj/YexuExVQ0/2YRCNYeR0YklkADON5aDszZz3MT7WxrRkr3nbczj/Akag+sLSlwLF9T464x2eOyVMP1ljKanJZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6iG/PmYZ3+YQdGlaU16g12Hm45zvxBoiUdOCQbCakI=;
 b=L+3/67WK+F7MaP4B4WgGOPyizV3vhq7yKTZk1oc146OU35/NSizUG/6LKLOW5uUGkrCEYSBeoA51E4Z7bCQ+IgiJPSfEv26IW4FUZddxeT6FUD8J8p2x6BCeHpUgai4UEJVPEvOrOcpLwgR3T9krH8Lu2WEvifqdMHRcSX0/SnE6gzmu7ktf0KJJbJmpGbh4qZFqLA6xfKGo4vGLpZUQB61Ny0lvT9SmNlzhSY+MZK8Z4mdS/dhI2M0cuBbR7/JrP81DXYf39O4aZImvvVHltuGd1cUXIxmUKdJTbaFVsOZFQRNr7rZ64fn9MzeDb7U5QzGcL95+uMumX8qbumjpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6iG/PmYZ3+YQdGlaU16g12Hm45zvxBoiUdOCQbCakI=;
 b=t6CrqHg8oY8xkT/wbItCPEMQv7horUdjLsYvqbTIBScTLXrsDnioR9+shl2+3hTt2yF51nDkEwf13IhZIZGT+OR/7k4zacRgAqKzd70htPOGa+xo+ScspyWBTuRDLAoq0IBKwipCcvMT/epmO9mrWkP0bssm9YHwYZEwFTx++SoxxP9JfWrYxUMO3ijNrnyUIgvHFndE627uwSeyhXM3A7L+Kviv87GDrXT3nTESgyc0ofz8Psdn94LCIlxzGlMIY76emEa7oFKh2e2T4fHs8K+0gaDZI1KP6IDfrlwGDHDw7V7LZ1guVmCEe7637u/0J+hTcGTX8aJlb/JCFR153w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:12:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:12:55 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:28 +0900
Subject: [PATCH v5 2/7] gpu: nova-core: do not import firmware commands
 into GSP command module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-2-c4d6250ad160@nvidia.com>
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:604:254::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 10839ed3-e3ad-4179-6532-08deb24900c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: e1nbXAlpTRTjnaebY9K3bO835W4pGffCTzpOBPDYvL2Y9TOA1zEnASqqKpYBvSniILygpxRduZuswJMHoS8Epi8NQw20j6huka34v8BLRWaL/xlNhkFR3xWW+UqSrqVJYUWi0ghU6XtZtSm6c2bxth4z18xqJSSduQ6gPdD/SohCzqc5yNHxeAtkfzid5HM/9tXGl7DdxC5BTQ9eE4nDsBm07LefmU+/9jeJXEmC3ceTqenimjNdADCkwGx2MmNMVfl3n8S0izYqp8pPhskmg6b/nJ5effSi0l5fz7vSAjB26VLU0fMJx6ogPuaH0KJDgNc/jQQEIwQckw+sH0dWZEZzo9koL8rvuAWjED/Izt/YLlRaGcTusP27tESPZhAr2tiDr9A8hxFeOHEu1W7BTeoFueHiaT+rwzuwcE8P5Lj9K+z4iDmEFBkzRzEQUzXYNGk8hGaoQqvNeS1TrytC8yDUzAscNeswBss7PY0J5oaY3STSQtepJR2rvlzxIaSFf4Qi/T8d1sNmSkeWcw3Eb3H4zzU6Mapp9hgU5xWmxzvtY79+Nwchd5Z/eqtIW/SIU1Je9unP/OF7PJUQa8Wygvrv9jQgro6zrJF27zKdZxX4B5ivAXNEvZGgjshJqOc1fVvjrpyO0bat7W5hpPJWuJ6BBvL1gfcdsGc0JpypW1PTVkhGORvSe2QMlVaOAMK2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2UyQ001ODFPb1o4YzNJbGw3ZUdVL3FJaEc3RXcrZG5oNThRV2VVMWtyK1lS?=
 =?utf-8?B?UmlvMUhjaW9KNGpSN3A2WTAxaDV1dHAwODlNa0dmNm9HakhQU0lCZHUyVkVv?=
 =?utf-8?B?OFJwMDhBL1puWkl2Rm9RYm1pTGFBcEk3blMwcFZySHoyb2FocUc4eTM5WlJP?=
 =?utf-8?B?R1V3VUZ3NW9SMWlENEg5eUhlRTN4T0IwR3lHZDhvbG15QmVkQ2pzMWdjb1BQ?=
 =?utf-8?B?K3kxNEZPbWNzdDlicDhVcDMvMkxoZi9yc2paODVHVnplQlZXSFgybVpjZTFo?=
 =?utf-8?B?MDlrV2RHV0dWNTF6bEN4dlNyeGsvTFRtWjNYbkpER0Y1WVdPdWoybFRmMU92?=
 =?utf-8?B?UlRnSzVRVk1aZTV1Zm5GbmNUS0JSVUk2YTBlQkhYbTQ2ak54VzBMdDBNdlVa?=
 =?utf-8?B?N0EreVoyc1lweC9xcXBEVVc0dmIzMzh4Yk0rcndhSnUrSjJpbTlwclUyRS91?=
 =?utf-8?B?UnRxb2FLYm1FaW5lYno1cG9XUFBkWlZOdU42aEt3WGQzcE0zcXhLNHI4YUVB?=
 =?utf-8?B?dnB5SXR3SWZIbngrS2RBWFYybTVrU1FVa2MzYjZKeXh1bFNPZVdNOHZ6eFJ1?=
 =?utf-8?B?bVplWEZpQ2Y1dDYzNHpCaGlhWE8vL2JrV0RoaXdBNllOWTZKTmxCc2tKc05B?=
 =?utf-8?B?Z1lVblpOQVprQmUyOXBvaU83aEpyMWw0MWtPRVI2dlNnbHBtN2JlOWl1OUM3?=
 =?utf-8?B?aGhVSEVJZ2tkcld4VC95WmJzZkF3M3Z3K25wTWJFMVBQclY1MFFKVll1blVa?=
 =?utf-8?B?OXRHNnNWTEp6eHZrbnZNNy9idzg0Unh1WXpPSmRsOXZ1UHpkTllhK0JsNmNl?=
 =?utf-8?B?bHFQWmU4aGtjN05LYVV1TjFuUnpjNWRyZGJoOFM1U1FDd2R4bVEwNG81Tm5u?=
 =?utf-8?B?Z25KQ2pyWDZSZVJaUXNGVkZGYTlHVXErOWpmbUNWOVpmMVg2eC9ZTlRqd2pP?=
 =?utf-8?B?NTZXY2RjS0NYVlIzaW40Rk1iT0VyZmJDYXBxM2JEOTVXTVJFNm8wSnBnK0lS?=
 =?utf-8?B?Nnp0T3VsZ0lscFp5ZVVRNnBXajBaUk9uMlQ4KzZTdVlVYm1WZUxNRW56Mklk?=
 =?utf-8?B?Sm9LTk5NT0Y5UzRuamtGdjJUNWh2UkhRZG5ReithN2Z2UHF5ZEQyRm9MMGZk?=
 =?utf-8?B?a0xqbGpTWGFSSW96Sm83Unp2aVlDNWpRSG1zVGdlRmlCMzdZaW5kcUlJVHli?=
 =?utf-8?B?Nno3SStwQ2M5WDljcUhZckgvTVNpNHpJV2tJTGRQSGxsNzJsTEVPNEtubnhD?=
 =?utf-8?B?U3hnUHZROStwYndTM21rSWh5ZjVnUjFkQmlEWDdWbW5icTZrcVlMcFllaHVM?=
 =?utf-8?B?dFdtcFpIMit6Q1llZEllb205Q2pQZWlmanZ4V2ZEQ2kxVC82a21kKy9jSFdB?=
 =?utf-8?B?ZTNma1VlSG9paEs5RzhkZlVUakJDamtrSytoV0N2WjA5eW9vQ0tQWVZidUpI?=
 =?utf-8?B?WEhCclFxUUFOU0RlQkhDekR1d1ZJQ2RoOWdLTlJ5R2NycDlvUjZsOCt2OXpp?=
 =?utf-8?B?MWo5UEN1OTh3MmV6Ykw1MldDN3lUU3Y4eUo0L21TRVUyWG9CTU1BSllWMC9w?=
 =?utf-8?B?Z3BTOHZaOFUyV3J1MkZoM1BQcDJmN005SW96QUxlT0R4amhTVW5VYzdzMXg0?=
 =?utf-8?B?eGJKKzlkKzVGTXhycVl0Z20xM0dxcWpMM0tVMW1UUFgxSkFyYWEwRi9DaVdS?=
 =?utf-8?B?YkpCZU11S3Arcm1CUzgxUGRKR0JrR1dlWVBwSGFZYVZDbFdlYWpHU3BQdjE3?=
 =?utf-8?B?a0tEYk5hcllQM0hqY0tlcjBHQ0dVZzZjSktWelN4Z05vK2tZNTNIRVZzMXdo?=
 =?utf-8?B?SzFySnZoMXZzZm5HUHJVVEhZME1rY1RjNWw5aElpMmFtMnlDT2F3dTdsU0FY?=
 =?utf-8?B?RitOTkNFZ3ZyV2VQaHFtbTdYSk5ZeTZRM3FjNktvWk1wNlNIZDQwTURwNmN5?=
 =?utf-8?B?V0w3aTZ4SUphUllIbEN0eDFGNElMRi9YY1hFZlpZQmJsRjJEbjE1enRHMkJy?=
 =?utf-8?B?QUFIY0hTNEptODV5RXhpQzFMS1FMMWhtaXN0UkV4OGsrOExUV2p2T2kvQU1W?=
 =?utf-8?B?ZUVLemJvK1VHcEZaZ2NVamN6V2pUckNYenQ0ZkdxbmZ3L0xGWE9zY1IvZ0lW?=
 =?utf-8?B?TjVMUk15ZnU0aXZwZHZkL3R5Q0ZLd1hSVkw2alc1dTZZdjhOaDZjMmtWejJv?=
 =?utf-8?B?YlpXWm1vUlk2cncwaHplNzNwUEFhelplUTYxUnBma1dJY3JseVBzZkd3VHMy?=
 =?utf-8?B?OHRHemdKTmFxZ1VnUXV3K3BZVWRoS1lUQVpQMGZDbm5zUU4rZ2xWMi9WN2E5?=
 =?utf-8?B?cDREaGkxSG00Vy9iZC90Si8zM3NWZ3B4TCtyczQ5dTBXRmhpMUZYQ2MvbGU1?=
 =?utf-8?Q?kc1crF3NMKyCYBFBCWxWPs4OLBDE4OShBl7FiZ9xDhLRH?=
X-MS-Exchange-AntiSpam-MessageData-1: oErwyTOgPWNsRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10839ed3-e3ad-4179-6532-08deb24900c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:12:54.9650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMPvzVkFy1U56IKgWjMuw5DNFN9HPh0Hd9uD5D+FfQhVGf9t5MdChqqNH4FQdHMcVvQiriU3NjwOsQBjfXUHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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
index 74a8a79bd2d6..e78bf94bc5b0 100644
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
@@ -47,12 +47,12 @@ pub(crate) fn new(pdev: &'bound pci::Device<device::Bound>) -> Self {
 
 impl<'bound> CommandToGsp for SetSystemInfo<'bound> {
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

