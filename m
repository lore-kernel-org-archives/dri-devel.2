Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD3CC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C2210EE8A;
	Wed,  9 Sep 2026 04:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIgfFW/W";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555A10EE8A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGbOgN0OgNwk/PI6LC1AgTJwtd+bmFXZqiXG0Jh0c9HxdNuSQzJCZsmLb+2Wjxz46DmhKyt0YV1RJjRxy0zaBoXCyuQRX5dsHivfzsTcDCFaA32bYlKxSZpYfrWoT8LTjBoxT2BO5BRjw2gTuktWR7z8r7RIpRjFmPADF+zgUK5W+GgKEwQLcX+T2oe2cbFT4l8zSxSK30tSPooyEPs344KIzynchyYhJvNqMSWCYqWT/ldfFCy7wjVJED07zFJ076hRxWXzNWNqE9n8KGTY2G6pym75B3xU1w/Q/x0apD6hoK/smArRDTZPUmKj4kyeix9bRHoF+ABxVs6KC2Re5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0ihvBMjGbUPL+I3j6UFPDxiv+5njam0YLbVLrWc7Cw=;
 b=jyG7ZdU42+OedQ6AZddQ3wStAUArAIDLpi39czyrpHGu8dL1g6L1Mt5a6sgvuct7Z8DESUvTtEV35D77nzi1grxR0Rsqdc0vD4SXAifolXj/ODnpLHzP5VJYEXc+1RmvHfwsDDlQv8NxLPMilWxWhK15wszZqOVBHHjR2apJYJkwb4+IZxVUKpzaRwenPxUenJL45MRBCWdSdTHbszTxydG5Kxx/1pBClM8SNFcMist2PX7jvlOtCc4fCK5pgs3MSz0brTCeYpRQ/ciJ1WeNRzclKuG1E15ZPlc0A+M15/CPruMlCXpoS7CWFJRmJlM8C0Q1QtQfVFSLzX+g/NW6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ihvBMjGbUPL+I3j6UFPDxiv+5njam0YLbVLrWc7Cw=;
 b=VIgfFW/WE57o4UE8jgpscYkKisVvrhMnK574ESMAJutw4KfmVMhepiq0SUd5ypC10phL42RJ7jeXH4eZR/SwxIHQ0cf7LEy4hHLKAX+4pzENgqQJYuHI2JbeJe8pk8jqJEwjakZeb85GY+PktWBjD2LsHv6BXrJ2iMAFFJOZeMVJ6zFOmmzhzknp8m7UT+EpzOmBGBCgSB47C+4aCv0nw/hEzXq8UPAoVMoJKwDAw1nWrcAd1IM5U7ob/hS2SxJQ2PYlXFMJXKdyNU3UH4ebL3WTjBY2VkOj7g4qbQ7KEljiGkgk95O+nr2MmFUEriUigbeTbv5MBsicobvfKTtIig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:46 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:52 +0900
Subject: [PATCH 14/16] gpu: nova-core: Add BAR1 aperture type and size constant
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-14-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df0453c-3c50-4838-cb4a-08df0e26ed1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JWrzQpSRxsgG+EogE2CfV6FkfNMl4lWZwRxktvM1iPWrP/4e/XTHj1ZKMCkosqN1qoVoaqyq4ri5qtbWjWyDKqieZoUpQgmwqrDyVY5XRWlzVM8Yer2zDIXBt9kOrH3oEJE/5KPmjOEKi4HYbAz7XJ8REGGvlmCHP2c5aXPNK5F0GzwSsVfPRxubT2upCb08JPbtdy95QJI0NkHVFvShc8AvFN6yaEw0+Ksfgpk7PdJm/2av1dQdW3pYrEjzQ9IO/NNwFIG0W1uWhfL7GIo7B3VKi1w/b/Ro8Rww19JKrOTPwmRje/cgqU40z8c0YSPtP/yRlEOgTMWizwkxjc+dANu75WsOTFKwbqlBSgPbA4INp8DGvbGnWHckqSjFk8DcTSRNzFy0eXZXYO4saLqFZGev/aU8bpA3gRoHZ9eFNiapYAYn4oczFBDXnM2jZjRdBqqWWXQEh+wdhwIOhjzE8sm80Y6y+xw1IhPdt5XC9Tycior8TvqXaLfgTsolE0U9KMcOAXd/FkaQqDB1Ir2WLojs90TpNZNI3BCehUZYkHaCrzAfiKnmdOjJRHNNNr8Z1ZdhVS4IsoAbab6x/v0jDIwX7mvLbMqb2AfcfqUPqrDJnkj396+Ecu4Wt5mkv2hxc7THtTRFYDUZOPilAjVq8gcINYUJXtN+eFZ4PWGSpQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTQ5aStxaHpiNzBzQWFrRys4eDdXeTVVcjhWMXpodG8wY2pvbmlvcXJPU3VD?=
 =?utf-8?B?eWRwTWZQRFcxVWxXZmlLaHpHdXJXWS9TSFYvYTY1cTVZZ2NnblpoMmM2c1NE?=
 =?utf-8?B?dnV4ZlR2Ym5ZZGxGNTBlTUJndlZrUmhweENNSFhCOGsrRjkvNHozZzVUZDRa?=
 =?utf-8?B?OEEzVEg5UHlWVEwvSVlqTGdUZ3E5Rlo3Z0FENGVtbUcySEt1VERUVUVxWXRY?=
 =?utf-8?B?dHBIWHBIcW1rRFQ2MTYybGFWMmVwZkJzTDBnbFQ1WmdnMU9sRy9VTmcwQ2Jj?=
 =?utf-8?B?MnpmSXV4dVVRczhva3l1ZGc3eDBtUXNqdEhkOEtLWm80bXlKbHdEdXVtckta?=
 =?utf-8?B?RTJhNkpMM1JxNk9lYUdlRmVMWk9SU1hxQkg3djZGc3JGUW1EWWhIaHkvM3lI?=
 =?utf-8?B?Ykt3SFpTcS8wVGFhYW45NS9tMlRPSVdXSDhuQ1pmMGZzd1hlNDhVS2VRSFZC?=
 =?utf-8?B?eG9BTDhhV0lIcFU5MHNMZ1ZlMEdhOThubjhRdjJJWWJINnhhMWZERjViQ09r?=
 =?utf-8?B?WGZoUldEcEFLVkJGcVRKdzdKQ1RrdCtyQTMwWWN5NG5DUzRWSFNEWVNoVkIz?=
 =?utf-8?B?UzIzRm9UeXRnb2dnTzRLS2VLMWFzTzY5TFpLN2lCWVJUWmlaSjJjMXV6dG82?=
 =?utf-8?B?OFZFWVZ0enlMdGNJTFo0eXdCK3BMeW9JTzloNlJlNTVBc2xGNnAxb1dtS3E3?=
 =?utf-8?B?Skptam9oM2gybnUzZm04SVF0b3pZTW1QZnBWVTI2cFZ4K1dCemxnVnBIeHJl?=
 =?utf-8?B?eFUrVkxmZXNrTkpEM0g0VGVGanRtKzZzSmdIKzVmVlJjQlZjYXVnK0pva1ZS?=
 =?utf-8?B?dWQxcFZKMHVOR0wyWXhDY28zOHlwcVVJYVEveExqWmVZZ1M3K0Y4c2xmRFRi?=
 =?utf-8?B?eWNOOGFlTTFYdDVVcTlOeWgrNkJMdGJhRE1HUFMyVGpza1MxdlFLT2Q3UmNq?=
 =?utf-8?B?Y1B2QTRFSFdJZzBzWGZmOFVSU3BRVmJsdjUvbFhpLzdqaS9MTWthVUVZM2ZR?=
 =?utf-8?B?Rm56eG4yc0hDUGdFRnhnTDg2RUJ1Z2JtVUh2WmFxaytHNDlNU1ltaE00Ty9l?=
 =?utf-8?B?VHFXQk1YOVBMTm04ZTFDKzUvdjd1T3RnRXlBMXdEYnM3bEdNQmY3WXIzY01a?=
 =?utf-8?B?VytBcTFBSnpVRjNES1FnNVF0TzB5Ynczc0FzTGl0b3VSYlljMjZ4UjFYejVE?=
 =?utf-8?B?cWhua3drSXFXWVBPU1dXV3d2TE05d2RsbExoOUMzeTUxbTJJLzVuKzJGY0pn?=
 =?utf-8?B?ZWxUL1c0WHcvMFRKWE9DYmtUaDgwZFU2WmlleDlEWkFvRjIxODhLWlZUdUU2?=
 =?utf-8?B?elVsbzVhcS9vaUdBRVRVbjVyalJzVjFLa1pNMDFlTW5iejJ2aFN0bmFtbjhs?=
 =?utf-8?B?WkdpQ0FVZjF4cGdTZGNVZGEyMU5nRWNJbmxaUE14WUVZTDN1bjJPeU9LTXVl?=
 =?utf-8?B?Zk83TnRHYUI0RTNVRHduVUtEc3ZkbVRsOUxWdjVlMjBycUtaSFpRRStiYkRG?=
 =?utf-8?B?aHFDZXBTMm9OVWhKRmpQaEJ1L1cxazRSTUkyMkMyTFNjaWVuVWlyRTZFN1ZW?=
 =?utf-8?B?VWIxeXZFL2UwY1JZNnlxU0RqM2t4WVpON0lWd2JjMS91enArellEaG8yZUhW?=
 =?utf-8?B?OVVCekNaYXpOZFF3V0NyL3Yxd0I2MHhKZ3lmdk1yR2ZJVVhPK0xjZFJEUkZ6?=
 =?utf-8?B?K09EaTFnQVFMZjRSMlU3b0ExclVWc3dJa0tjOWlzQUZndC9xbGVWVFNoOFB1?=
 =?utf-8?B?Z3MzaWE0TGo1bjhQNUlraHM3cGRQT25maUdPcFIvVXBncFplV0c1a0ZMaWhs?=
 =?utf-8?B?RG5ZM2FBZ3VleGNHb3drZC9MOE9EZk03MDFNMy9TUmlCM0FFVTRUSUNMeXY4?=
 =?utf-8?B?dVdIV21WYXpxelFORTBTNjBqK3BqSm1JbUNnMVQrUnY3eldFVXVsK3FISzVX?=
 =?utf-8?B?VDZjTmRaL0c0aDVxQ1grODhFVDJzbVE4eHFKeWgyS2ZMRmh4bHVWT2J5cW9Z?=
 =?utf-8?B?REUzMWdxZUduaktibFdaMVVoMFg0emtzYlBBTnY2TGMrZHgwZXEvSzhDSUJa?=
 =?utf-8?B?UURCSmZodGsrUnljK3ZNbkxzV0JBQ3BOeXpScjJQRVBEZGhwd3RnOXBhNGhB?=
 =?utf-8?B?eXhXbk9kVS85eFZUdTVDK1Fqd0hJWi9TbGQ5UDF1d1NjeUlqeFlZTFpqK0h1?=
 =?utf-8?B?bjNPblRRTzY4K0pUZVc3SGR1YUs4WU96Z3djNFdJWEtSVlB6WjBwM0VGTDUy?=
 =?utf-8?B?L2I5QzdFU3lYNWZyQXM3bXdITVhpN2cvdFVML0piMFlWM05vb1Q1L1ptNlZr?=
 =?utf-8?B?enkvWUFIMTZUYmN4NDdHb3VwL2hkY0tNUy80eVhlRU00QWNhSlpLemhMcFBj?=
 =?utf-8?Q?C3N8G2UmBXW55dyCBbPGcXeEnJeiQL7uEZ4Fmvn5X8rS+?=
X-MS-Exchange-AntiSpam-MessageData-1: DKkU/iUfEqSNUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df0453c-3c50-4838-cb4a-08df0e26ed1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:46.0832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Moiqsnob4pbxYgWLBHgylaRnD7jkLMvVLrtrfuriHdh9GP3Z45tmk6AG9ehMhq5tbE/4Xtt9UBABoJRYlbxCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add BAR1_SIZE constant and Bar1 type alias for the 256MB BAR1 aperture.
These are prerequisites for BAR1 memory access functionality.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: add the Bar1 lifetime for current PCI BAR ownership]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs          | 2 ++
 drivers/gpu/nova-core/gsp/commands.rs    | 4 ++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8cef4c284277..5723ff8f71ea 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -38,6 +38,8 @@ pub(crate) struct NovaCore<'bound> {
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
 pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
+#[expect(dead_code)]
+pub(crate) type Bar1<'a> = pci::Bar<'a>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index eea1c9ed4684..1c467718c679 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -214,6 +214,9 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// BAR1 Page Directory Entry base address.
+    #[expect(dead_code)]
+    pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
     /// Exclusive end of the FB physical address space.
@@ -237,6 +240,7 @@ fn read(
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            bar1_pde_base: msg.bar1_pde_base(),
             usable_fb_regions,
             total_fb_end,
         })
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6e85442a4b13..32856ff74183 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -131,6 +131,14 @@ impl GspStaticConfigInfo {
         self.0.gpuNameString
     }
 
+    /// Returns the BAR1 Page Directory Entry base address.
+    ///
+    /// This is the root page table address for BAR1 virtual memory,
+    /// set up by GSP-RM firmware.
+    pub(crate) fn bar1_pde_base(&self) -> u64 {
+        self.0.bar1PdeBase
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,

-- 
2.55.0

