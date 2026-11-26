Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E8606A68D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LhAaeTaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F829112155;
	Thu, 26 Nov 2026 08:21:33 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622F411214D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI6hjCU5ySHKWhByFaofvCtxXfXDWPa1H2ogCD/cJl+Jw5h1mtlfUCbnEa6RbG5qutR+XqpQFvHbAcY5gMZDRk+oLrlq65FLMNlbve0hfxvSX+qQ0xuuWoz7xAA0p1yGwT4GbbB3hajyNTvZ1xm8mU7YdMRvDRe6enDbiNcd8Ll8CvHLP0dl9sLwc7PVAdSnUKQqtZOWLs5dRdPKzIztKWxo7tiyZWtTffWHMLknxi/Bopjv6X2c8nmU0mCCqE76iIKNOHJrbsNUlwLjt6fTKzPGRvDqlTAf0DGlmESevkIWeq42RnmqHa+dpqWZbBDyU2DrlXsM1Bwd4eem2+yOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi6DPbefR17d89NDmL6atgVQ448zUlLkyKKH49tYVD8=;
 b=sYVXJuZt2pgCytp3rL7qlJSpguKAI46GJb5A2pvQ4/JWn2i8SwG0hMMYIW1hhyge8JESGdPkwDn5Q1lDAI+TOkOg8BOiZ/jegVuqRfDh/q/PluPn3J/8NQH83FOdlouEm4Ljr/XdFSMGsQSMCC43DR7LSHlGzXkIZBvqEfQjQiJAd4fHI52kiIxC9kiC9TeL8JXaE3oqz2UZMiAses0vAvrN2UDNHcKsD+Gx+zYA+T8xOlsHg60saEbdZD56HrnvV9rrARn53NFIZ19b6hqG6QoIbHGmi1yD0SvXzqslks8PeEz4JIZX6iW/bBzU7omNOAUIO3iR8ITZ/nCugBwfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi6DPbefR17d89NDmL6atgVQ448zUlLkyKKH49tYVD8=;
 b=LhAaeTaVRRoybIbrWDNS1vyPiGo2sbqm5hYRh/BjkoWEGzzXzUiEPzOztu90vav+V2XJhlbsylGBCJaFj5b5Du6D0yr1LvIItiYSX8eKV4LsL0a3dOjq0UtAEARXOTqIO7SK6yjRnuZBcanUfvTCMaz0QtgLdQqA+YaV7JqRlR+vqXT4MCHhCDmK1tvCTRF+lznZOTuRNuNqqjS1/NyYJ/fo2Swh6aw7kZf5atv7ZBEj6K6EEE8uwg0COjN0YiMlheE9JoMRHGOCHCRXniVxlr5XgOktVtzdr+AwiMf6fF3VukeeumnAnqW8MLsXQ5VDOlM935ncPLRMzBqdNJxkXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:56 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:14 +0900
Subject: [PATCH 5/7] gpu: nova-core: falcon: add `FalconImage` for
 `FalconFirmware` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-5-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: dc38aea6-e3bf-4d39-ac5b-08df4b9631a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261026121527099003|261102123227099003|261022115727099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: dVIo2W+yVGyiBgWThTleppR9QLyI8fzOAXfBGf/GxIb7WBlvDW2KoTegMZZADpCkyvEu1C0zgrhxNj1+vd5jj1MHGaHG4XI3GvszB07lf4Jfdf8QYb/YF1G0oY3JrOSuNuCLXPEuxQa9y7w7fN6T7zA0lW4gzMls7hT1kIoWXk/BMoAO8Zu3kPiqFT8ibBcPk1fGqK4LWqJ0JPRr0ZdBA3u+8RAURUj0jis8rIfhGbXhydTaKuP5ZNqgWyUElRWJDiRcwJIlWcbxfXSNNuLyAsUeDN4NeUJMGYzxcopKjAAMO2ZAZ1FNB9TIKUlsDh5OqI38LXIWDCMnyhWnvBTUYGWbPTyK7K3gnK8y1KY5rZ3XZ9gE/XivBU8WA189z+9WwflU67WjQUOwhvD6wEugWaT5uRwiTO+uukNRS+FxBp1DL3toW0vTMxeIUc5qYXDhbBJV8h0qYDHwSKbIWwdLI34o2c/Y+WeRDLcnC87m8ohC57bgerihh8xtBz9LRml0zXgzQ7Xkojp4ozhz8dCKccD/WtvgIL0FmzH05B6MshKJ6J/OlnSjSHEL1h/od56/AkS5gZT/tmbQ8VN2mjb0/qp9UK9la58YX75VeZP6g7PqUoqK7GgHKpCs99s5tBlXLkH4gn8YI+zEWLg+w9iCMHX8x8ZHL2vCb8vPm5s+Ivc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pMaDZkM21UYUdDS3h0NWx1SHp3SCtnZlFuMHgrSU0zUG5yYjl1eURwT2lD?=
 =?utf-8?B?bzNhMVdaWGV2a3ROMXg2dG5Cam8wTE5BdWxpSnRhVThJODlZeWpOaHZqdEJu?=
 =?utf-8?B?d3ZuNGFGN0llbG9JY3RyVVFabi9vaVlBaVNMVnlFZEdSUWpzUEQ0YkVuY3dk?=
 =?utf-8?B?R29ab3o2eWg4bUZNZkcxdXhvQTZKeEJGbGVvUXpwdTljL2JDM2kwakdHdUI0?=
 =?utf-8?B?VE8vc0ZkTS9wdzlpNWgxMTh0NkFidDBPNXFuSERYdVhGRWQ5QytWOHh2Qks5?=
 =?utf-8?B?ZzdjTC83b1VYUXhveW43RGNxMjJkRTZzdDJzMnJnV0Rianh6MEFmTE1JNStE?=
 =?utf-8?B?S0xQUEkwV0VSSlRlV1lFc2FSQmtUOWE3cGV3Mlg3d1Z5ZjRCK0JsbVExckpO?=
 =?utf-8?B?V3hvRE9iaEpGZk1nNDZoY2lDOEIxY2VjWFk1YUtSMlZJVDdZR1lXWVlWb0t2?=
 =?utf-8?B?WHQrNVV1NE10RzFKOHpCMEVnR3BmN2FVV3NEZll2TWx0dTJVVUVSZ2w0RjBI?=
 =?utf-8?B?bHlRLzRPREV4Y0l0VDhPbk9ldUZ4b1pZaWxoZDl3VnIvNXRjMy9Fc3dtT0Fn?=
 =?utf-8?B?eGVqVlN5MndNV0lhNnl3VE1WVUtjN2VubmVjNkN6SEpXcTRMVXJkSkRuOWlD?=
 =?utf-8?B?MDNiYUxUS1JremtUejhtbWY3REh0dVRJendKVjdrV2dlcE9nbUNNVE9tRktZ?=
 =?utf-8?B?TDFRM0ozdGtuQVJUNmlvMCs3ZDdId1VZb0RHWFRDQ0g5eTF0SUtsK0ZFcm1z?=
 =?utf-8?B?V2FhOUVHb1ExbG9YVFZKUmZSS09PK09JVWt3MFkyLzg5cmZlTk5hWDZBYnFv?=
 =?utf-8?B?WDEvNFpoZXNVUjE0RjhrSTNFMkhuWU9zSkl0eVcxR3dxZHNrMllVdS9LZGFy?=
 =?utf-8?B?WVFCQzlQNldsVTJaWkhuejBocE1henNPRkp2ZHE0ZUVqRWNJR21QVXpzN0dQ?=
 =?utf-8?B?cmV2cnR1OE1ZYnFXcHRMQk1NL2lGSk9SU0NzT3JRT2tSTDBPMjJOdC91SmU5?=
 =?utf-8?B?bXhLeHcxdS8vaVVIM3JsZndaM09PTHk4U1c3Uy80UWRBc3dIVDNSVWtPRHJ3?=
 =?utf-8?B?ZjNQSEcxRUpBbk9rMm5yejVUcHJHY0pOTTdHaS9zNXBOUzRhUW1SNXg0THpI?=
 =?utf-8?B?cnBMQncvRXhLbWdBMVJlZUVUaTJyNnZIVzFTSU9KVXlCMDc1UWFsOURnY2dx?=
 =?utf-8?B?VW1IOElkU0tsSjNhV1Jmd1ZrekFXc01lUlBIbGVUOHNya2dKZmNtM29Rcjdi?=
 =?utf-8?B?U3ZtZ3FCM2x3bzJNajJzVmlTZ2NJUGpBVFo0SFJSc1FsdGtFK3FGWlJHYlBk?=
 =?utf-8?B?eGR5Ui9iSnlEdDVKVDUyTHRnc1RUU2kwNXJHWGFCY0VkVW9SajdFd2JaQitL?=
 =?utf-8?B?UDZvclo3bG1xanJHeGNSd0xLYi8yUHFNTHQvZHJyQVJpbVJUV0FmQlR1SUcv?=
 =?utf-8?B?YkVZblBXc0w1MTA4bWVWK082bnVoRGkyQU5PYVNxZHhxWmMweGJOcnJoTk5n?=
 =?utf-8?B?S3hBVys0d0IwVGNodkQzZ2dLK2wvVmRld09BMzBzalpnOUhMZlp0S2x6eUh0?=
 =?utf-8?B?bHRlWDhCT1NlRkJMaDEvQTMzMkZHMzl0Ujd4YWNLaWJ4RzdUOStrWU51a1ND?=
 =?utf-8?B?dXhDd3F5RVk0OWYxeVhPWUF5VVVzSXdiOGRTQVpETlFPYlFJRkIzRU42UDl4?=
 =?utf-8?B?SlBiOEpZYzVLa0pndXJUYW85SCtaOGpQZ3JaczZjSFlvbGpGMHR4N0pVMlF6?=
 =?utf-8?B?Z1ZXNmMzbW1VUi9RYUo1eHZPL3l6REoxbzZFM2twSE5oTkRua3dxODJ6dEhV?=
 =?utf-8?B?T2VKcks2SVFYSFYrSFVBZWwvY2FQQTN5UFY2YUUrK0pQWGdvVWJJTEh2cGpR?=
 =?utf-8?B?T05UOHV3U1pDZnRFdDNxUTlucFpDMWVEOFVtVysyeTl5UkE4TFZsUkp4ZHc1?=
 =?utf-8?B?MEtRd2N0TnZIbmdKcU9ScGVEMlZBa29KdzVERGdsamd1YXd4L0ZVZ0NaY2g0?=
 =?utf-8?B?akVXMHNiNjVRL1QvNUd0c2JJVUFWQm9OSjlkZ1V1Q1VZN1FUWVdhVVh4TEVn?=
 =?utf-8?B?d3haRklMa1JmVUJ1a2crV3pWT1kxb0hxdHloU2F2ZlRaRGFXaVV0eXBoNUJH?=
 =?utf-8?B?WWdiVzFRN1EwWC9lVnp0Y1pUQm05NWozVFlGV3pHSk5JT3RiY0o0L29lYXFB?=
 =?utf-8?B?MWE3aS93aWxmemR0cEVBRFZJbDBBYWNyMG5lMkJOQnk1c0ZyMlhrUDhhT3Qr?=
 =?utf-8?B?alZsUUhtT2ZGWXRlcWNibm0wNWNDc2pnQXlYQzAyd2FRU1oxOUlGK28wTzNu?=
 =?utf-8?B?SXZoa2hhL25ENmRmTGZnTlc0YjY5NE02Y0FqTlZkNG0zZjc3UEIrNmkzRitl?=
 =?utf-8?Q?AjqUPXA8Q28BNdXmJ9mxeUdQXRcHcqB3qK2VzFOpIOUuJ?=
X-MS-Exchange-AntiSpam-MessageData-1: PzDSotYd8co8YA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc38aea6-e3bf-4d39-ac5b-08df4b9631a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:56.2630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpOdFdBJgokhHrenz0kf+NyBXH8sHG5dXaIDx2GR4gO1o3JNXOmvUOhZRjTEl4ft/VoamTskMD9I/78AnqyeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a new struct `FalconImage` which holds each segment (secure
imem, non-secure imem, dmem) that needs to be uploaded to a falcon.

This replaces `FalconDmaLoadable` which mixed the locations/source of
each segment with how it is given to a falcon. This makes it easier to
add falcon firmware loaded from framebuffer memory, which is needed for
r000.

Since this decouples storage of segments from the way to send them, we
can also remove the PIO adapter and separate PIO specific machinery.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    | 307 ++++++++-------------
 drivers/gpu/nova-core/firmware/booter.rs           |  43 +--
 drivers/gpu/nova-core/firmware/fwsec.rs            |  42 +--
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   9 +-
 drivers/gpu/nova-core/firmware/gen_bootloader.rs   |  57 ++--
 5 files changed, 190 insertions(+), 268 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index f0e6f0eea641..337d13359fa5 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -17,10 +17,6 @@
         Io,
         Mmio, //
     },
-    num::{
-        Bounded,
-        TryIntoBounded, //
-    },
     prelude::*,
     sizes::SZ_4K,
     time::Delta,
@@ -132,7 +128,6 @@ pub(crate) enum FalconMem {
     /// Secure Instruction Memory.
     ImemSecure,
     /// Non-Secure Instruction Memory.
-    #[expect(unused)]
     ImemNonSecure,
     /// Data Memory. If `tag` is set, a transfer into DMEM also tags each block with its source
     /// offset, which is then the DMEM virtual address of the image.
@@ -234,141 +229,58 @@ pub(crate) enum FalconSegmentSource<'a> {
     },
 }
 
-/// Trait implemented by falcon firmwares that can be loaded using DMA.
-pub(crate) trait FalconDmaLoadable {
-    /// Returns the firmware data as a slice of bytes.
-    fn as_slice(&self) -> &[u8];
+/// Code to load into `IMEM`.
+#[derive(Clone)]
+pub(crate) struct FalconImemSegment<'a> {
+    /// Where the code is.
+    pub(crate) source: FalconSegmentSource<'a>,
+    /// Offset in `IMEM` at which to load the code.
+    pub(crate) dst_start: u32,
+    /// Virtual address of the code, used for tagging.
+    pub(crate) va: u32,
+}
 
-    /// Returns the load parameters for Secure `IMEM`.
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget;
-
-    /// Returns the load parameters for Non-Secure `IMEM`,
-    /// used only on Turing and GA100.
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget>;
-
-    /// Returns the load parameters for `DMEM`.
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget;
-
-    /// Returns an adapter that provides the required parameter to load this firmware using PIO.
-    ///
-    /// This can only fail if some `u32` fields cannot be converted to `u16`, or if the indices in
-    /// the headers are invalid.
-    fn try_as_pio_loadable(&self) -> Result<FalconDmaFirmwarePioAdapter<'_, Self>> {
-        let new_pio_imem = |params: FalconDmaLoadTarget, secure| {
-            let start = usize::from_safe_cast(params.src_start);
-            let end = start + usize::from_safe_cast(params.len);
-            let data = self.as_slice().get(start..end).ok_or(EINVAL)?;
-
-            let dst_start = params.dst_start.try_into_bounded().ok_or(EINVAL)?;
-
-            Ok::<_, Error>(FalconPioImemLoadTarget {
-                data,
-                dst_start,
-                secure,
-                start_tag: dst_start.shr::<8, 16>().into(),
-            })
-        };
-
-        let imem_sec = new_pio_imem(self.imem_sec_load_params(), true)?;
-
-        let imem_ns = if let Some(params) = self.imem_ns_load_params() {
-            Some(new_pio_imem(params, false)?)
-        } else {
-            None
-        };
-
-        let dmem = {
-            let params = self.dmem_load_params();
-            let start = usize::from_safe_cast(params.src_start);
-            let end = start + usize::from_safe_cast(params.len);
-            let data = self.as_slice().get(start..end).ok_or(EINVAL)?;
-
-            let dst_start = u16::try_from(params.dst_start).map_err(|_| EINVAL)?;
-
-            FalconPioDmemLoadTarget { data, dst_start }
-        };
-
-        Ok(FalconDmaFirmwarePioAdapter {
-            fw: self,
-            imem_sec,
-            imem_ns,
-            dmem,
+impl<'a> FalconImemSegment<'a> {
+    /// Returns the code of `blob` that `target` describes, to be tagged with `va`.
+    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconDmaLoadTarget, va: u32) -> Result<Self> {
+        Ok(Self {
+            source: FalconSegmentSource::Sysmem(target.data(blob)?),
+            dst_start: target.dst_start,
+            va,
         })
     }
 }
 
-/// Represents a portion of the firmware to be loaded into IMEM using PIO.
+/// Data to load into falcon's `DMEM`.
 #[derive(Clone)]
-pub(crate) struct FalconPioImemLoadTarget<'a> {
-    pub(crate) data: &'a [u8],
-    pub(crate) dst_start: Bounded<u32, 24>,
-    pub(crate) secure: bool,
-    pub(crate) start_tag: u16,
+pub(crate) struct FalconDmemSegment<'a> {
+    /// Where the data is.
+    pub(crate) source: FalconSegmentSource<'a>,
+    /// Offset in falcon's `DMEM` at which to load the data.
+    pub(crate) dst_start: u32,
+    /// Virtual address of the data, used for tagging, or `None` to leave untagged.
+    pub(crate) va: Option<u32>,
 }
 
-/// Represents a portion of the firmware to be loaded into DMEM using PIO.
-#[derive(Clone)]
-pub(crate) struct FalconPioDmemLoadTarget<'a> {
-    pub(crate) data: &'a [u8],
-    pub(crate) dst_start: u16,
-}
-
-/// Trait for providing PIO load parameters of falcon firmwares.
-pub(crate) trait FalconPioLoadable {
-    /// Returns the load parameters for Secure `IMEM`, if any.
-    fn imem_sec_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>>;
-
-    /// Returns the load parameters for Non-Secure `IMEM`, if any.
-    fn imem_ns_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>>;
-
-    /// Returns the load parameters for `DMEM`.
-    fn dmem_load_params(&self) -> FalconPioDmemLoadTarget<'_>;
-}
-
-/// Adapter type that makes any DMA-loadable firmware also loadable via PIO.
-///
-/// Created using [`FalconDmaLoadable::try_as_pio_loadable`].
-pub(crate) struct FalconDmaFirmwarePioAdapter<'a, T: FalconDmaLoadable + ?Sized> {
-    /// Reference to the DMA firmware.
-    fw: &'a T,
-    /// Validated secure IMEM parameters.
-    imem_sec: FalconPioImemLoadTarget<'a>,
-    /// Validated non-secure IMEM parameters.
-    imem_ns: Option<FalconPioImemLoadTarget<'a>>,
-    /// Validated DMEM parameters.
-    dmem: FalconPioDmemLoadTarget<'a>,
-}
-
-impl<'a, T> FalconPioLoadable for FalconDmaFirmwarePioAdapter<'a, T>
-where
-    T: FalconDmaLoadable + ?Sized,
-{
-    fn imem_sec_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>> {
-        Some(self.imem_sec.clone())
-    }
-
-    fn imem_ns_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>> {
-        self.imem_ns.clone()
-    }
-
-    fn dmem_load_params(&self) -> FalconPioDmemLoadTarget<'_> {
-        self.dmem.clone()
+impl<'a> FalconDmemSegment<'a> {
+    /// Returns the data of `blob` that `target` describes (untagged).
+    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconDmaLoadTarget) -> Result<Self> {
+        Ok(Self {
+            source: FalconSegmentSource::Sysmem(target.data(blob)?),
+            dst_start: target.dst_start,
+            va: None,
+        })
     }
 }
 
-impl<'a, T> FalconFirmware for FalconDmaFirmwarePioAdapter<'a, T>
-where
-    T: FalconDmaLoadable + FalconFirmware + ?Sized,
-{
-    type Target = <T as FalconFirmware>::Target;
-
-    fn brom_params(&self) -> FalconBromParams {
-        self.fw.brom_params()
-    }
-
-    fn boot_addr(&self) -> u32 {
-        self.fw.boot_addr()
-    }
+/// Firmware image to load into a falcon.
+pub(crate) struct FalconImage<'a> {
+    /// Non-secure code.
+    pub(crate) imem_ns: Option<FalconImemSegment<'a>>,
+    /// Secure code.
+    pub(crate) imem_sec: Option<FalconImemSegment<'a>>,
+    /// Data of the image.
+    pub(crate) dmem: FalconDmemSegment<'a>,
 }
 
 /// Trait for a falcon firmware.
@@ -378,6 +290,9 @@ pub(crate) trait FalconFirmware {
     /// Engine on which this firmware is to be loaded.
     type Target: FalconEngine;
 
+    /// Returns the image to load into the falcon.
+    fn image(&self) -> Result<FalconImage<'_>>;
+
     /// Returns the parameters to write into the BROM registers.
     fn brom_params(&self) -> FalconBromParams;
 
@@ -446,25 +361,32 @@ pub(crate) fn reset(&self) -> Result {
 
     /// Write a slice to Falcon IMEM memory using programmed I/O (PIO).
     ///
-    /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result {
+    /// Returns `EINVAL` if `data.len()` is not a multiple of 4, and `EOVERFLOW` if
+    /// `dst_start` does not fit in the `offs` field of `IMEMC`.
+    fn pio_wr_imem_slice(
+        &self,
+        data: &[u8],
+        dst_start: u32,
+        secure: bool,
+        start_tag: u16,
+    ) -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
-        if load_offsets.data.len() % 4 != 0 {
+        if data.len() % 4 != 0 {
             return Err(EINVAL);
         }
 
         self.pfalcon.write(
             Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_IMEMC::zeroed()
-                .with_secure(load_offsets.secure)
+                .with_secure(secure)
                 .with_aincw(true)
-                .with_offs(load_offsets.dst_start),
+                .try_with_offs(dst_start)?,
         );
 
-        for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
+        for (n, block) in data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
-            let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
+            let tag: u16 = start_tag.checked_add(n).ok_or(ERANGE)?;
             self.pfalcon.write(
                 Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
@@ -483,11 +405,12 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
 
     /// Write a slice to Falcon DMEM memory using programmed I/O (PIO).
     ///
-    /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result {
+    /// Returns `EINVAL` if `data.len()` is not a multiple of 4, and `EOVERFLOW` if
+    /// `dst_start` does not fit in the `offs` field of `DMEMC`.
+    fn pio_wr_dmem_slice(&self, data: &[u8], dst_start: u32) -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
-        if load_offsets.data.len() % 4 != 0 {
+        if data.len() % 4 != 0 {
             return Err(EINVAL);
         }
 
@@ -495,10 +418,10 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
             Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_DMEMC::zeroed()
                 .with_aincw(true)
-                .with_offs(load_offsets.dst_start),
+                .try_with_offs(dst_start)?,
         );
 
-        for word in load_offsets.data.chunks_exact(4) {
+        for word in data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
             self.pfalcon.write(
                 Array::at(Self::PIO_PORT),
@@ -509,27 +432,6 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
         Ok(())
     }
 
-    /// Perform a PIO copy into `IMEM` and `DMEM` of `fw`.
-    pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
-        &self,
-        fw: &F,
-    ) -> Result {
-        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
-            v.with_allow_phys_no_ctx(true)
-        });
-
-        self.pfalcon
-            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
-
-        if let Some(imem_ns) = fw.imem_ns_load_params() {
-            self.pio_wr_imem_slice(imem_ns)?;
-        }
-        if let Some(imem_sec) = fw.imem_sec_load_params() {
-            self.pio_wr_imem_slice(imem_sec)?;
-        }
-        self.pio_wr_dmem_slice(fw.dmem_load_params())
-    }
-
     /// Programs FBIF context DMA slot `ctx_dma` with the value that `configure` returns, runs `f`,
     /// and restores the slot once `f` has returned `Ok`.
     ///
@@ -671,26 +573,64 @@ fn dma_stage(&self, data: &[u8], offset: u32) -> Result<Coherent<'a, [u8]>> {
         Ok(dma_obj.into())
     }
 
-    /// Perform a DMA load into `IMEM` and `DMEM` of `fw`.
-    fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) -> Result {
-        let blob = fw.as_slice();
-        let imem_sec = fw.imem_sec_load_params();
-        let dmem = fw.dmem_load_params();
+    /// Load `segment` into `IMEM`, as secure code if `secure` is set.
+    fn load_imem(&self, segment: &FalconImemSegment<'_>, secure: bool) -> Result {
+        match (segment.source, self.hal.load_method()) {
+            (FalconSegmentSource::Sysmem(data), LoadMethod::Pio) => self.pio_wr_imem_slice(
+                data,
+                segment.dst_start,
+                secure,
+                u16::try_from(segment.va >> 8)?,
+            ),
+            (source, _) => self.dma_wr(
+                source,
+                if secure {
+                    FalconMem::ImemSecure
+                } else {
+                    FalconMem::ImemNonSecure
+                },
+                segment.va,
+                segment.dst_start,
+            ),
+        }
+    }
+
+    /// Load `segment` into falcon's `DMEM`.
+    fn load_dmem(&self, segment: &FalconDmemSegment<'_>) -> Result {
+        match (segment.source, self.hal.load_method()) {
+            (FalconSegmentSource::Sysmem(data), LoadMethod::Pio) => {
+                // Tagging not possible if using PIO.
+                if segment.va.is_some() {
+                    return Err(EINVAL);
+                }
+
+                self.pio_wr_dmem_slice(data, segment.dst_start)
+            }
+            (source, _) => self.dma_wr(
+                source,
+                FalconMem::Dmem {
+                    tag: segment.va.is_some(),
+                },
+                segment.va.unwrap_or(0),
+                segment.dst_start,
+            ),
+        }
+    }
+
+    /// Load a firmware image into Falcon memory, using the preferred method for the current
+    /// chipset.
+    pub(crate) fn load<F: FalconFirmware<Target = E>>(&self, fw: &F) -> Result {
+        let image = fw.image()?;
 
         self.dma_reset();
 
-        self.dma_wr(
-            FalconSegmentSource::Sysmem(imem_sec.data(blob)?),
-            FalconMem::ImemSecure,
-            imem_sec.src_start,
-            imem_sec.dst_start,
-        )?;
-        self.dma_wr(
-            FalconSegmentSource::Sysmem(dmem.data(blob)?),
-            FalconMem::Dmem { tag: false },
-            0,
-            dmem.dst_start,
-        )
+        if let Some(segment) = &image.imem_ns {
+            self.load_imem(segment, false)?;
+        }
+        if let Some(segment) = &image.imem_sec {
+            self.load_imem(segment, true)?;
+        }
+        self.load_dmem(&image.dmem)
     }
 
     /// Wait until the falcon CPU is halted.
@@ -802,15 +742,6 @@ pub(crate) fn is_riscv_halted(&self) -> Result<bool> {
         self.hal.is_riscv_halted(self)
     }
 
-    /// Load a firmware image into Falcon memory, using the preferred method for the current
-    /// chipset.
-    pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) -> Result {
-        match self.hal.load_method() {
-            LoadMethod::Dma => self.dma_load(fw),
-            LoadMethod::Pio => self.pio_load(&fw.try_as_pio_loadable()?),
-        }
-    }
-
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, app_version: u32) {
         self.pfalcon
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index a52c965093c9..0e7a839c644b 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -19,8 +19,10 @@
         Falcon,
         FalconBromParams,
         FalconDmaLoadTarget,
-        FalconDmaLoadable,
-        FalconFirmware, //
+        FalconDmemSegment,
+        FalconFirmware,
+        FalconImage,
+        FalconImemSegment, //
     },
     firmware::{
         tlv::{
@@ -207,27 +209,28 @@ pub(crate) fn run<T>(
     }
 }
 
-impl FalconDmaLoadable for BooterFirmware {
-    fn as_slice(&self) -> &[u8] {
-        self.ucode.0.as_slice()
-    }
-
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
-        self.imem_sec_load_target.clone()
-    }
-
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
-        self.imem_ns_load_target.clone()
-    }
-
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
-        self.dmem_load_target.clone()
-    }
-}
-
 impl FalconFirmware for BooterFirmware {
     type Target = Sec2;
 
+    fn image(&self) -> Result<FalconImage<'_>> {
+        let blob = self.ucode.0.as_slice();
+        let imem_sec = &self.imem_sec_load_target;
+
+        Ok(FalconImage {
+            imem_ns: self
+                .imem_ns_load_target
+                .as_ref()
+                .map(|target| FalconImemSegment::from_blob(blob, target, target.dst_start))
+                .transpose()?,
+            imem_sec: Some(FalconImemSegment::from_blob(
+                blob,
+                imem_sec,
+                imem_sec.src_start,
+            )?),
+            dmem: FalconDmemSegment::from_blob(blob, &self.dmem_load_target)?,
+        })
+    }
+
     fn brom_params(&self) -> FalconBromParams {
         self.brom_params.clone()
     }
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 45b088f30b76..bde546c95a41 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -31,9 +31,10 @@
         gsp::Gsp,
         Falcon,
         FalconBromParams,
-        FalconDmaLoadTarget,
-        FalconDmaLoadable,
-        FalconFirmware, //
+        FalconDmemSegment,
+        FalconFirmware,
+        FalconImage,
+        FalconImemSegment, //
     },
     firmware::{
         FalconUCodeDesc,
@@ -180,27 +181,26 @@ pub(crate) struct FwsecFirmware {
     ucode: FirmwareObject<Self, Signed>,
 }
 
-impl FalconDmaLoadable for FwsecFirmware {
-    fn as_slice(&self) -> &[u8] {
-        self.ucode.0.as_slice()
-    }
-
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
-        self.desc.imem_sec_load_params()
-    }
-
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
-        self.desc.imem_ns_load_params()
-    }
-
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
-        self.desc.dmem_load_params()
-    }
-}
-
 impl FalconFirmware for FwsecFirmware {
     type Target = Gsp;
 
+    fn image(&self) -> Result<FalconImage<'_>> {
+        match self.desc {
+            // V2 FWSEC only boots through the generic bootloader.
+            FalconUCodeDesc::V2(_) => return Err(EINVAL),
+            FalconUCodeDesc::V3(_) => {}
+        }
+
+        let blob = self.ucode.0.as_slice();
+        let imem = self.desc.imem_sec_load_params();
+
+        Ok(FalconImage {
+            imem_ns: None,
+            imem_sec: Some(FalconImemSegment::from_blob(blob, &imem, self.boot_addr())?),
+            dmem: FalconDmemSegment::from_blob(blob, &self.desc.dmem_load_params())?,
+        })
+    }
+
     fn brom_params(&self) -> FalconBromParams {
         FalconBromParams {
             pkc_data_offset: self.desc.pkc_data_offset(),
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 461e5e6f7899..ace97b049874 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -19,7 +19,6 @@
     falcon::{
         gsp::Gsp,
         Falcon,
-        FalconDmaLoadable,
         FalconFbifTarget, //
     },
     firmware::{
@@ -63,7 +62,7 @@ pub(crate) fn new(
         // In practice, this is expected to always be zero but is required for code correctness.
         let (align_padding, firmware_dma) = {
             let align_padding = {
-                let imem_sec = firmware.imem_sec_load_params();
+                let imem_sec = firmware.desc.imem_sec_load_params();
 
                 imem_sec
                     .dst_start
@@ -82,9 +81,9 @@ pub(crate) fn new(
         };
 
         let dmem_desc = {
-            let imem_sec = firmware.imem_sec_load_params();
-            let imem_ns = firmware.imem_ns_load_params().ok_or(EINVAL)?;
-            let dmem = firmware.dmem_load_params();
+            let imem_sec = firmware.desc.imem_sec_load_params();
+            let imem_ns = firmware.desc.imem_ns_load_params().ok_or(EINVAL)?;
+            let dmem = firmware.desc.dmem_load_params();
 
             // The bootloader does not have a data destination offset field and copies the data at
             // the start of DMEM, so it can only be used if the destination offset of the firmware
diff --git a/drivers/gpu/nova-core/firmware/gen_bootloader.rs b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
index cfc1b99c015c..b5c8621574b1 100644
--- a/drivers/gpu/nova-core/firmware/gen_bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
@@ -23,12 +23,13 @@
         Falcon,
         FalconBromParams,
         FalconDmaLoadTarget,
+        FalconDmemSegment,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconFirmware,
-        FalconPioDmemLoadTarget,
-        FalconPioImemLoadTarget,
-        FalconPioLoadable, //
+        FalconImage,
+        FalconImemSegment,
+        FalconSegmentSource, //
     },
     firmware::tlv::{
         request_tlv, //
@@ -174,17 +175,6 @@ fn boot_addr(&self) -> u32 {
         u32::from(self.start_tag) << 8
     }
 
-    /// Returns the PIO parameters that place this bootloader in non-secure IMEM, at byte offset
-    /// `dst_start`.
-    fn imem_load_params(&self, dst_start: Bounded<u32, 24>) -> FalconPioImemLoadTarget<'_> {
-        FalconPioImemLoadTarget {
-            data: self.ucode.as_ref(),
-            dst_start,
-            secure: false,
-            start_tag: self.start_tag,
-        }
-    }
-
     /// Runs the bootloader on `falcon` to load and start the image that `dmem_desc` names.
     ///
     /// The bootloader and the descriptor are loaded by PIO, the bootloader in the last blocks of
@@ -229,15 +219,15 @@ pub(crate) fn run(
                     dmem_desc,
                 };
 
-                falcon.pio_load(&fw)?;
+                falcon.load(&fw)?;
                 falcon.boot(&fw, Some(mbox0), None)
             },
         )
     }
 }
 
-/// The generic bootloader together with the descriptor that it reads from DMEM offset 0, as one
-/// firmware that [`Falcon::pio_load`] accepts.
+/// The generic bootloader together with the descriptor that it reads from DMEM
+/// offset 0, as one [`FalconFirmware`].
 struct GenericBootloaderLoad<'a> {
     bootloader: &'a GenericBootloader,
     /// Byte offset in IMEM at which the bootloader's code is loaded.
@@ -248,6 +238,22 @@ struct GenericBootloaderLoad<'a> {
 impl FalconFirmware for GenericBootloaderLoad<'_> {
     type Target = Gsp;
 
+    fn image(&self) -> Result<FalconImage<'_>> {
+        Ok(FalconImage {
+            imem_ns: Some(FalconImemSegment {
+                source: FalconSegmentSource::Sysmem(self.bootloader.ucode.as_ref()),
+                dst_start: self.imem_dst_start.get(),
+                va: self.bootloader.boot_addr(),
+            }),
+            imem_sec: None,
+            dmem: FalconDmemSegment {
+                source: FalconSegmentSource::Sysmem(self.dmem_desc.as_bytes()),
+                dst_start: 0,
+                va: None,
+            },
+        })
+    }
+
     fn brom_params(&self) -> FalconBromParams {
         // The bootloader is unsigned, and the falcon HALs of the chipsets that load it this way
         // write no BROM registers, so these values never reach hardware.
@@ -262,20 +268,3 @@ fn boot_addr(&self) -> u32 {
         self.bootloader.boot_addr()
     }
 }
-
-impl FalconPioLoadable for GenericBootloaderLoad<'_> {
-    fn imem_sec_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>> {
-        None
-    }
-
-    fn imem_ns_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>> {
-        Some(self.bootloader.imem_load_params(self.imem_dst_start))
-    }
-
-    fn dmem_load_params(&self) -> FalconPioDmemLoadTarget<'_> {
-        FalconPioDmemLoadTarget {
-            data: self.dmem_desc.as_bytes(),
-            dst_start: 0,
-        }
-    }
-}

-- 
2.56.1

