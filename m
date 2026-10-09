Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBADCA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111C71120D1;
	Fri,  9 Oct 2026 11:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NoG1DYQL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012821120A9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt/XoK0mbXN3GUUzXStI+G1Wy7acToi7nEU3KGQ/Wl4u9dmWRVQAcP05gUlk9e8jvz/2SVl9xFAHCxrZxczGYNAxL6x43OZ+1nkn01tVf8G06sMsFL+fuOqZEf/QKr5dmjWJmVUrDQxe+FGJ/e+IUahDjcQt3mkZbsXz+zX4Im/zsqgG7ZpWfnYBmPzBiV9icKwbtVMkQwwMLnR+byZJLehqc3XBukAR34weqlTd0nTlh2bsNwBzZhOnXfIq0JAFeWcWb/VLK5FC4IT1m9ton82iFi3x3zwgSBFtq1sfsjfGbNOjYW1QDsLWtkqamsNhXWJCIBjbiQpF04OhDqxbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXngZ1HrfM31JYoD40aY2U7f/IoFZAAdi0DjUgW0qRI=;
 b=GFRxIznk3LUwYKFjNdIXAnYW5Ams49km4ibiZEjn9r6xIASW+hNH8uwCqbYu16GYUiReLoBkdTsQQCf4x+OCXDrNh4zXbYR8RC0VRfNHx0AtI7aZ4fnIqBZDnSGQAaUtOpD0vygvtHn6TcTWzIrACyqdgKvSm8ArCAr8nE77LFBQSIOGcjWPGhUo7D7eE1+FrC+18UyXdvkDCuSIgsXrl/pX3CuaEHYkUMasKssJ24/NdPFjtt+MbejNxQ/z1nserjek+xEceXpticvS2yVsN9ZEhEmOe2lZioj6VDSrX/RM6tbANbSNAzqtrDfAohDIWAKKxBOWFL/PUyGQn4ghJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXngZ1HrfM31JYoD40aY2U7f/IoFZAAdi0DjUgW0qRI=;
 b=NoG1DYQLjLNnaZvd1jvXhs0WQ4H23+Z2FgD+XF0I+Eb3DKoRPHUyCO4vtFu30NdQjypQDVDNWdPuKeXSniR9q61MAsF49bOr+Gkpb3unpCeVfvh+al9NmPPMl/aHK5681mvuXHJ7AlLCa6M9XVw34JELosL9LbiNOaI58KERSVVAvxKAwCRcz4+/Rh8mUz0oPDI9GuWKsvPs8FTmnIrsxzYz2TdsfuumMmduuI9wMESXjr43aC19ghI1kUu9FahP9XFl8Pfi7dURemNXSN7N84JtzSlsuGS8Tw8cC+BbMJ4JDoh2Ue7SHlUZcDbAYSEe4u+ckASuuV2tpE7kqyd8vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:50 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:06 +0900
Subject: [PATCH v4 10/10] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-10-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: c284d605-18a8-49f0-7070-08df25fc1fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: vsaDd+Tnn7WrNiodnekmVbHfldTTWgwpAuvJkYcVML9CM+boQWSOjfbuMonTE/F3Vs5vom06S/7M/JqtXnb4ExhekS4RAgSAAZdqacuTfwptof0gPU26kGUxBFniykpOvyrk4G5P7F5c/OfGugsywJ81BBr3oa8/jYGir70CS/YCBWtnIEzTb3jE/f6V269kTQW+0xcIztCsdS1Bql/qvQAdN9/f++BDHNzZKq8120Vp29i8fKXK0bFD9+FjLDK1HZOQTsliwb3sILvAz54P43SPSYolOlju/ExL3sk3Ml2I+xNBw4bHOTtzg7+iK4cDLBici8LP66wFTS2QhoRrng/kg4uEYkNEahVj3MazBINgFxZHLmu+G1eZ5qYcro4dPE555ARsVg3WFUz2RVacdX5WXVOuUk9nPh3Yt7W7LIsvnBg3209k1R9679d1rxYzjVJL0eqpZZbM0uneGkjFQ2mlgpbONPby4kogBMwNd/mtThettI2gKQ4EzrTTdWy+qWvHTJBB2qOOIp80GZwMpNftcpIBLpOW6rFSYGMQIQwQNUDxw6k7v/4Zp8ZSOx2Ar7NBcKO0EG+MYxNFgfrB1F3M2vcqB8QBUXrGms/QYeO30s/nJzBwUcaI9QhsRc9PgKj6lgmhT4iMu/LUVqTyvcoGH5t4RDYojE+LAX7CACs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDV5NmhvNUZLQkVRcUE1Qlh0anBpSGNzRElLQ1RtSkdHY29kSE1uc2RVRDA3?=
 =?utf-8?B?b2loWjEzWTliak1qaXo1eVc5Q1UxWHFWTVZPNC9ObXdnOWpYcVhIZkJOWmtt?=
 =?utf-8?B?d2NGcE9UaWF6aGRqdXdGS3RUYkJ6RUdVYjN5TStsR1JQUmFxam0wMVVSQnkr?=
 =?utf-8?B?Nm81SGhmWTM1QngxNG9TUTY0MDc2aGNxc3JnREc0Tml4eE13K1dMcXlFaXA4?=
 =?utf-8?B?UXJhTmlrWXVFUlhXT1BuYVdiRllwVDhPWlBEYmdzZTA0VDJLbzVIOE4yMDB4?=
 =?utf-8?B?R1ZjQXh3dmxzOWVSdVJZM2VpSjV5eWl2WnQzUCtTM1MwYnZ6UUxsb2cvdzlH?=
 =?utf-8?B?eDVaMzhYUmhxRGtKMEEzbC96WENic3ViVkErdGtoUkFIVWVPNVovUkpCazcy?=
 =?utf-8?B?U2R2RmgxR0FUaWdwcjM5aEtqRm80bmtEbE5aRnlLcnVCdUllVWtxK1ByZTYy?=
 =?utf-8?B?ZitDdzRTZjVQZHAreVI3UVNUUHgxeEttL3NWVnNCSmVCQVBUSUhXWGNsQUUx?=
 =?utf-8?B?S2xxYjNaOVlnYmtHNm41UkNwWGZFZWtmbnJKN0pGejRNSzFXaks2REw1bjhI?=
 =?utf-8?B?MjNWVG12MTR1cjExN2h5Znh4RzhldUdlUjRpM0NkeW91WWxKZTlSU1FMc0NX?=
 =?utf-8?B?aVNxN3IzeXBlSWQxZkFxQVNTYXBCRXV3NE52N3VFVGhLSUxacEFrWWVsb1Vn?=
 =?utf-8?B?WEh3MUYvMFl2eXFXbHZGSEo2SHdCdzJvMElTUmowSWU4RU9TYU9taUFDcUdh?=
 =?utf-8?B?UklpeGZvdFdFTklkQ3Zqcm1rZjIyb2dyUVBrcjRBbys1SjRCbWpOQzMyUzQw?=
 =?utf-8?B?QzZzTlRWdFlKZG1PNWhudS9UWGRNb2tHZTlLYkFjUXVHR2xnWnJLWXUxak9o?=
 =?utf-8?B?SkxFTjlBS0FGelF5K0dMVFMwT3pDb09VOXFMTitnK2R3bXNvdVRTS2dPSXhh?=
 =?utf-8?B?aUxMcUhZZHlPbllTaVVkWFhSeGlrV1dabXBwNzN2OG9iejRzNmNqL0VIcjRG?=
 =?utf-8?B?SjhGL1kwdXNjd0hqSnUrd3BTMVJZMnc2dVZNc2dVY0lLYi9wWmhmL3NvdWU3?=
 =?utf-8?B?bHVaOGNqQXUzZzRNU0xFTVdPdVFOaDJVMjA5UDdNYmxPanNMUHp4eEtvNHpF?=
 =?utf-8?B?OE5FZGF5ZXk5OU1DVlZnZEN4LzN5OXFkWkpOUjYrRmlCcTBNUGtNcHdDZHk2?=
 =?utf-8?B?TkIrbC9ScTFjSEh2d3g2OTNKR2sxQURrd1ZyNmlIbi9IT1FyTkt5dDBnbHZR?=
 =?utf-8?B?ZkJUNm9IQ1NvazdXakVLMEZpcjAvK2M1ajRDMnM2T2lkRHV2Q241eWl4ZXhP?=
 =?utf-8?B?QmNnV2dQeE5Sbjk5NEc2RnZxTUZ1bnJQbC9RNmZxMTg1REZmWk11VkYwUnlN?=
 =?utf-8?B?UFR6MTZQTHRoRmZ6c0J5NThqRCt2R0MyNmxlLy95VTJZUEZrU3dNMUVObWlS?=
 =?utf-8?B?NGJYZUpHQU9LamhGUC9FcnNycWoyeU16VDhpWHN6SW95ZXZRMno4SGNrUmdJ?=
 =?utf-8?B?OThuQ01lVVFidnZXb3hweVp1ZmlEV1Q1Z1BjWkxONVpjTzNaWEc5cHNiWW5Q?=
 =?utf-8?B?ZE1JbGtCN1J4R2p0MVRnYzNZUldQZlBIaTEzZmk4cGJpR0QxbE8zbTRzQjFG?=
 =?utf-8?B?a3MxZWZ4K0FHaWVDd2FjeVJuaWlObGVKL3JxbkpwbFdEcTNFMjVpRWdPUExJ?=
 =?utf-8?B?QjhyTytmRlZTdGxFSDRNaDJoR1hzQTJFbElRSmwvQnI2T0Q4TTdhcWRFMmZC?=
 =?utf-8?B?aFJ1TEFrQ2licWJQaFkrVE9lQkxrQUk1S3cyWFgvWGUyZVJQZWFtbTVTZTd5?=
 =?utf-8?B?eExNQzh1Z2RsWjVjMXhFL2tkQVc0M1RsK3I2cGZXN1VwVG5ZZC8vNmhsYlZj?=
 =?utf-8?B?MHg0STEvN0w1K0pvYUYvRDRyVklUZUhoeW5qUFkwZW04NEhERmIzSWgxajlI?=
 =?utf-8?B?dGlOOU1KSFF6ODNrTVRHUzE5T1hrZnc2ZVh4dXBxU3VHWXlBamczR3ozRkll?=
 =?utf-8?B?TFBURkJwUDJaOEpCa2pneXNNM3V0R2NtV2dnS0hkOEplQ01WaGV4VnRoSDVs?=
 =?utf-8?B?NjRjMjBiQWhGV1BOSUVKS2F5aXlQblloK25mMEFvNXVIVklZcmk3d3hIZlQ4?=
 =?utf-8?B?QSttVVZ6RUxVRFlaQ0paVHBzNTBoMC9Ic0ZSdjhVU3NkMkg5MG5OTTFJSElW?=
 =?utf-8?B?NStuSkIyRGhMM1ZnbGlCRUdtUlR2MzVzOXAxUXJ0Q0tDRXhYWmpyeDAybGdB?=
 =?utf-8?B?OFh6OThpMUlIK2lBUjgxVk5USCtnVFpmL0VEUTN3aStqd3c4YSsvOEpoRHBP?=
 =?utf-8?B?N0IwQ3VHUmdSYkJSa3p5R09NSWFGY1RHZVplOHdMMWJpdVc4TnlYZTY4RDhw?=
 =?utf-8?Q?YfRpZbKU7dnrhFK5zzUYwWZve/2KCrE8vTnoQ6ywiLoVr?=
X-MS-Exchange-AntiSpam-MessageData-1: FGqV6VRPpMZ3qg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c284d605-18a8-49f0-7070-08df25fc1fb8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:50.5506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYKhVX3oUUfeaetpXmZlNaOZsX8ZXksIB7DxlQB8frE3Bb8tLA3Uols+T+2GjSjEj7eMm++VMQ04aknoyR8IzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs          |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs     |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq.rs     |  2 +-
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 14 +++++++-------
 4 files changed, 12 insertions(+), 12 deletions(-)

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
index c7deb1ae58f4..3ddde743f73c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -58,7 +58,7 @@
 use super::regs;
 
 /// Marker type representing the absence of a reply for a command. Commands using this as their
-/// reply type are sent using [`Cmdq::send_command_no_wait`].
+/// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
 
 /// Trait implemented by types that can be sent as a single command queue element.
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 39fc3a9e61fe..f334327f97c1 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -162,8 +162,8 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
 
 /// Trait representing messages received from the GSP.
 ///
-/// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
-/// The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
+/// A reply that [`Cmdq::send_rpc_command`] waits for, or an event that [`Cmdq::await_msg`] waits
+/// for. The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
 /// message with [`Self::read`].
 pub(crate) trait MessageFromGsp: Sized {
     /// Function identifying this message from the GSP.
@@ -327,7 +327,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -335,7 +335,7 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
         inner.await_msg()
     }
@@ -349,12 +349,12 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
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
@@ -391,7 +391,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,

-- 
2.56.0

