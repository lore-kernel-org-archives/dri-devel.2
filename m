Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D2CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF5E10E8DE;
	Mon, 28 Sep 2026 08:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsU10DFq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A51D10E8D5
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB0uwznstW6QpIiMC0FD2rMySzauqiMxiNHwdYhMXmbl48gfS71po8T8/dB9VjEO6MH5bOhO/SmcZB+xeMLdlO0psf3aJ8bIBI/Gmcb2Yp9d1QQxGIEloMBBrDpUaalGe9JwDPZilxz97J+Z6agQsvjTnK/6ZtcVb3O40Z2G+SOwLM275ZSH78T9EvofKSJq4MFoxcdZFLRANUulgVzCQqZ18guWBMCdP9ohpXbvdQDFOMpkmkG3yOKQNJ7qzlqJugMbLSXTUqBUxw1xwu8+Czppv/ZFDOBxC0vdcZ2kps2EGBj8ougyCjfauYta8Kzo6UR1e9wPd/aQRpA5P+O0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS6aTUJsNMCH7fSHKuJFcVVVt9xFqg1HRFc6uBeL9wU=;
 b=s51NXRF1mTJ7vTGLb3pPbvBRyVUB+Y4IFCAjEkUh6wEzkolAHlwNkALe323a+JSTy6tTVpG8zwd5jyAv5XnQPg7/aYENhpzI1H/WZPDb5tpUE3nRyvGlSrRCIJVvOzPkkhaAlNy7Lxmb0rT1hgVW5prrkpeOHX7yIXRbdnOCE2Dgi0ZgyfUORs1ZyMBYj0XtqsP272W+xk+5EVsY/zU3ZIcs44If5pnOTqaF3Y3hwGupyFb4tf4KpI7+EbvGJi5zxxGy3wI44NbMH7Y0Bxjt6FIPkDvm/Ft3rn+5LdO/J5AijRbOKBk9otk4PLMXVM/ZX0hvASKAgE+cJptGSuqOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS6aTUJsNMCH7fSHKuJFcVVVt9xFqg1HRFc6uBeL9wU=;
 b=GsU10DFqznog5L+pyf6XV+MDdNwfe2M1oPEANuH5KVdOjGWeQw+KvHKRqvaaDCVGpDRd7xu/4g7KNUwF56NpIsh5mkWYxniDE8Jlh365Wyvy6swQqGPK6efZdYhYitTspHirThV3uo7Azxf2TQP7euYIY1G2lpE62aGG6qmpHvDq0XlRqKQf6Dr3gWziamGe6Ow+OyAKR72mnfSZAU7Vm48GqdEXUNPnCLdzsrSCSZ3W/2wkF5g5maeGnSGxMGxANRglNTPOfVxjE63lSal6ZTFvxQ3xG990p0JTq1G3K4OiRDwkEneB+2tugkbxAiORS+TAgZmcQWEoE7G0upJAYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:27 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:47 +0900
Subject: [PATCH v3 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-8-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: cefe7ad4-6f37-428b-0d1f-08df1d3c9085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|3023799007|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: B6wK8/+1VKniXhorw1B25okkq1e5IjF8OR5k593jurvKGCnotzXryxLU9inLbftVhGkMYabyChuBK/7jmu0cKyejaSK+I5zhVAFgT8NBHO/zYS3Kaqf2J5DaPnVLJC6pmAXUcaP57zH3c92RCFE+zXsONAYPyNHJFjwgV3XUYDwlBPzE3EzTtCkOsR8rmow3kmaGuj2zdGeZVlTEjktYWUFOaw3icim99GahNjZMh1h7kajPfNVgUaNr6OApVMNWl3v8hTuXTNZY5icOu4tg5mjD/dBzP1wf5rzqt6YpWmSPBLfExawjlDBC4uXC+laxAkRb80vkPducG+OdS7z6qi9KKoUZmtg3UoOzB5BbgwHmGZ2kbTwWLKhIrIzYG1nSy2sVQBHJHC6xf8bj/t95BQBxm0qzLD61LbUbhSsRTwlU2VUcNMh4QJdpKzKUoxTFm5LLJZuLdoDjZm80tSB270+Mz8vAEXg/KuOVhzGq42sm1vVVwj37i0p4I1DwkFJYUtbhZmGw4X6heCBbpg6oCiOxOTAaQUGmTcubh6wEqCh15/AVbys93Z9daZzgnMs1CwjtHQJ/hn8NdLKAjx7zpZaehphHq6n+XHbOlLNFF/IGBD3o/yJGw/6a7nAQV1EupxZPxdFuvRIRIUHrrBZhOW5hqrWqQql0x5IwdKDVqxtptg1LBcFC81yHUBN4quorr/CbL8nGAfDZVFldLqDIRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(3023799007)(6133799003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU04eFQzYmd3S3lGaXZoY01vSFdSUTE0Z0JSRzNxSUpuNG8rcVk1OVVOdFZ6?=
 =?utf-8?B?YzIvaWhWd29NcDhZUGFYaXowQVljNjFQa1ROQ0ZqVDk2VEhwRGdpL3cyWU9J?=
 =?utf-8?B?SWhTaEsyRXJDbm5EUzVXS3NBbFV3Q3VwVlNLVDFXZzA1R1kzN2hoMWxNa0JD?=
 =?utf-8?B?L2Vwa3NzVUNkQUJsS2ZGcHRBQlpIUXQxank0RXJFVXVnSU0zK2pRbzh2dHV0?=
 =?utf-8?B?RW1pbDhzbGRmTm1SL3FSV1NyZjA2VlplbWx2QXZ4dEhpdnNER0szemc0VEla?=
 =?utf-8?B?MFZvckM2MXFQcTlnbmFhdWJlLzNiclhLUFlrMHVmVnBvSUU5NnZKbkdCb1dn?=
 =?utf-8?B?QUhPcVV6N3FUR3pwVkhHZTg0bzZzNEdyS0REQUVVVlBTQ0xBb3pCdThXOWNt?=
 =?utf-8?B?dXl3Mk1MWnkwWGpFeVE5bHNZRGNuT3FrbDY2OHhpMVFRZEQ2WU05SUFOUUg0?=
 =?utf-8?B?b09IU3lSbzQ0VGdFNHJQQkpsdHBHOWNQVE41VjhERFpQRmtOanVBVjhoaG9R?=
 =?utf-8?B?MlVVblQvSW1oLytZaTNRNVFGS21UQ0gvdldJaHlwOWlYZnlUb2pXL3VZdFgv?=
 =?utf-8?B?enl6aWNhclkwRC9SMElrRVk5aWp4MUsyMHVERC9kYy9OOEMwaVY2VFpEL08r?=
 =?utf-8?B?dFpzd0YxUnNuYWJ0QWZHeGdBUlBuWWZyR0szdnRXam5aMEtNczNSdUh0UEUy?=
 =?utf-8?B?MFU1K2sxMVFGNE9Pc3RjS3FjblRuY2xNZVJVaERLU09CWm9QSUQ3RDdoK3V4?=
 =?utf-8?B?cWNvVHdDWDBwbWVWM01UWEh6SGVrN0pvTExLV1hBbndybS92UXRGU25kTDh1?=
 =?utf-8?B?aDVxV2VjNXUwa2xtSWNiU1pId2x3MHdxVHhIR1BtOVMyMU4wbjhUQWN5dk1a?=
 =?utf-8?B?b0xXdGYxU00xMTlFd0tIdUtaSWwzdm9BdTlENSt3K3V0T3N4SkJiR05kd1VT?=
 =?utf-8?B?Q0x4ZUF1MlUvT1RDV2hlRk05dituZkEzdFhNekxmd3k5Wi9Bb0h5QUZCcFI3?=
 =?utf-8?B?L0ZHRHNCM21kUTlUaUplU0tJNTVKMElVaGZvRWFBK0IzdU9iM3A3QTY2MXo1?=
 =?utf-8?B?blN3czM2ditoVklFbTJ5dHZYN2VhMW44d0xSVWxYUklId3VnNFpTWTA3Vzg0?=
 =?utf-8?B?bFRSRlRLK1Y1djluUFJuVytSUm1KOXIwQXFlMHRLY0RMQnJKeDVYaW1VNWxD?=
 =?utf-8?B?TU5aWmpQN1pmbzVGeklUdGpFWDJoUzBDeGsvQ0RXdzhnTWJaRDVZNTBUN0lx?=
 =?utf-8?B?UXNSWm5MZERrM0hPYkdlSXdQL3p6cUNYY3NqeEVrZVZMTDZ3N0kwcVA5WGhV?=
 =?utf-8?B?OThwNzQyR2p5UlFtK253SW1CVWo1RDJHMnpBNmVuVHRmak9DblVYSlY4Zk1k?=
 =?utf-8?B?UE8wa2FIVks2cVlxOW92RllFZlVLdzRYcUlnOWNKM055SDFMbHVZaUN2VUdw?=
 =?utf-8?B?T1BvY1pnVjZDZHJkZnhER3BMaTA1SGJSKzNDRzUvR3FVQVZhQURFT2g2ZEpF?=
 =?utf-8?B?cGVyNmlkSUx1QzRIR21QNUxvQS9uMm5rMWVXZWRjOHBlUmZsbXhQbGJXdnc1?=
 =?utf-8?B?aitiTGdJKzd6QU1ZemRGTWtuUkRHZE1scVNtWVROTXY5a3QvQ3BlYmowbllz?=
 =?utf-8?B?MTFUN1pTejkvRmcySlgzYTJyc21HcS9IQ21TUEdFVTBadkx0VVZNVEdERkR3?=
 =?utf-8?B?YkhqWW5oS2laZC9RVElhak53YWlsY01LRzF2cXIwOHluTkxIMWUyS0h5Mnhm?=
 =?utf-8?B?eXZhUElEZEFmZ1d0eFAzUjN0UDVIa1lUa2V0MGRvY1A1amxoUnpZQjdYUk5a?=
 =?utf-8?B?ekVBSGhCWnRLVW5NZzVVcHRpelRtVVlGbFF4dXBXRkg1ZTZmc3luNU9tTm1T?=
 =?utf-8?B?U1lzc3RNRmt6S0VxZWpTNjlqN0pWOFUwaDBiT2YzT29XdnoyWjhLNFVzKzJM?=
 =?utf-8?B?VkZkMmpteDhaY1o0YjJIdnFWSmhwckdwVFRUUDFtdWdnMUUvV251Sll2Wmhw?=
 =?utf-8?B?MEVmNW5NZW9tUjNidHlPQmt3Wi92NUVTc3czN0k3Mk9XTjRsbEJDS3lHUWdT?=
 =?utf-8?B?VHdXUU5PZHQzN3dCc3hIL3AwNTJKOXVIa2YxRlltUEsvQ3d4VTREYmh4c3R3?=
 =?utf-8?B?SXFscjVDdk9Fa2xIV1dYS1F4ekNuNUtZSlptaFdCVVI2WWZzNlZPSGgvTnVW?=
 =?utf-8?B?b3gzOVl4NGpRaThiT1JXRGRHeHZWU2lHbUhZTWtoOXdFRVhwNXFzZW9HQTBM?=
 =?utf-8?B?bkM2bXZnYVJJOC9mbU0rWHltL2dNalZxWktNRGZFSldoWEdzY3IvSnpwWUJC?=
 =?utf-8?B?MTcwWnBsMm5NaWphb0FVbGVwSzJDQ1JqQ1hIZnBiUG9pcXg0cWRjb3hsdHJH?=
 =?utf-8?Q?eY744G0vj0gOCSw3F1TIAN90nKQt5+cuEu3eUfCj7JEo3?=
X-MS-Exchange-AntiSpam-MessageData-1: e1H3sZ/UnPAT2g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefe7ad4-6f37-428b-0d1f-08df1d3c9085
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:27.0794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otfiUwh+422PTHNqKqHTgY65co/IYCxTPUSRLUdoEZnJSfDsrdUPR5GmV/jmF4sdRgmUjtAtA9Bd6IN7PyuWuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Add the first user of NVKV encode/decode which is the request and
response for GSP init. For now this is exercised via unit tests. Later
patches will support GMCAPI in `Cmdq` and use these messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 447 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 -
 drivers/gpu/nova-core/gsp/nvkv/decode.rs |   1 +
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |   1 +
 4 files changed, 448 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 32856ff74183..02de225af917 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -4,6 +4,8 @@
 use core::ops::Range;
 
 use kernel::{
+    alloc::ArrayVec,
+    bitfield,
     device,
     pci,
     prelude::*,
@@ -15,7 +17,21 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE,
+    gsp::{
+        nvkv::{
+            nvkv_decode,
+            nvkv_encode,
+            Accumulated,
+            Array,
+            DecoderValue,
+            Encodable,
+            Encoder,
+            Key,
+            KeyId,
+            Required, //
+        },
+        GSP_PAGE_SIZE, //
+    },
     num::IntoSafeCast, //
 };
 
@@ -230,3 +246,432 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for UnloadingGuestDriver {}
+
+/// The host CPU architecture.
+#[derive(Clone, Copy)]
+pub(crate) enum HostArch {
+    None = 0,
+    X86_64 = 1,
+    Ppc64le = 2,
+    Arm = 3,
+    Aarch64 = 4,
+    Riscv64 = 5,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros once
+// they land.
+impl TryFrom<u32> for HostArch {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::X86_64),
+            2 => Ok(Self::Ppc64le),
+            3 => Ok(Self::Arm),
+            4 => Ok(Self::Aarch64),
+            5 => Ok(Self::Riscv64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<HostArch> for u32 {
+    fn from(value: HostArch) -> Self {
+        value as u32
+    }
+}
+
+nvkv_encode! {
+    /// A GSP registry entry.
+    struct RegKey {
+        key_name: Key<&'static [u8], { Self::REGKEY_NAME_KEY }>,
+        key_value: Key<u32, { Self::REGKEY_VALUE_U32_KEY }>,
+    }
+}
+
+impl RegKey {
+    // Define the Key IDs read/written by GSP.
+    const REGKEY_NAME_KEY: KeyId = 0x3070;
+    const REGKEY_VALUE_U32_KEY: KeyId = 0x3071;
+}
+
+impl Encodable for KVVec<RegKey> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        for regkey in self {
+            regkey.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
+nvkv_encode! {
+    /// SR-IOV virtual function information.
+    struct VfInfo {
+        total_vfs: Key<u32, { Self::VF_TOTAL_VFS_KEY }>,
+        first_vf_offset: Key<u32, { Self::VF_FIRST_VF_OFFSET_KEY }>,
+        flags: Key<u64, { Self::VF_FLAGS_KEY }>,
+        first_bar0_address: Key<u64, { Self::VF_FIRST_BAR0_ADDRESS_KEY }>,
+        first_bar1_address: Key<u64, { Self::VF_FIRST_BAR1_ADDRESS_KEY }>,
+        first_bar2_address: Key<u64, { Self::VF_FIRST_BAR2_ADDRESS_KEY }>,
+    }
+}
+
+impl VfInfo {
+    // Define the Key IDs read/written by GSP.
+    const VF_TOTAL_VFS_KEY: KeyId = 0x0080;
+    const VF_FIRST_VF_OFFSET_KEY: KeyId = 0x0081;
+    const VF_FLAGS_KEY: KeyId = 0x1003;
+    const VF_FIRST_BAR0_ADDRESS_KEY: KeyId = 0x1050;
+    const VF_FIRST_BAR1_ADDRESS_KEY: KeyId = 0x1051;
+    const VF_FIRST_BAR2_ADDRESS_KEY: KeyId = 0x1052;
+}
+
+nvkv_encode! {
+    /// Payload of the `GSP_INIT` command.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    struct GspInitRequest {
+        pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
+        pci_sub_device_id: Key<u32, { Self::PCI_SUBDEVICE_ID_KEY }>,
+        pci_revision_id: Key<u32, { Self::PCI_REVISION_ID_KEY }>,
+        pci_config_mirror_base: Key<u32, { Self::PCI_CONFIG_MIRROR_BASE_KEY }>,
+        pci_config_mirror_size: Key<u32, { Self::PCI_CONFIG_MIRROR_SIZE_KEY }>,
+        host_arch: Key<HostArch, { Self::HOST_ARCH_KEY }, u32>,
+        bus_device_func: Key<u64, { Self::NV_DOMAIN_BUS_DEVICE_FUNC_KEY }>,
+        regkeys: KVVec<RegKey>,
+        vf_info: Option<VfInfo>,
+    }
+}
+
+impl GspInitRequest {
+    // Define the Key IDs read/written by GSP.
+    const PCI_DEVICE_ID_KEY: KeyId = 0x0001;
+    const PCI_SUBDEVICE_ID_KEY: KeyId = 0x0002;
+    const PCI_REVISION_ID_KEY: KeyId = 0x0003;
+    const PCI_CONFIG_MIRROR_BASE_KEY: KeyId = 0x0010;
+    const PCI_CONFIG_MIRROR_SIZE_KEY: KeyId = 0x0011;
+    const HOST_ARCH_KEY: KeyId = 0x0070;
+    const NV_DOMAIN_BUS_DEVICE_FUNC_KEY: KeyId = 0x1020;
+}
+
+// Decode:
+
+// Should decode with UnknownKeyPolicy::Ignore.
+nvkv_decode! {
+    /// Schema for the `GSP_INIT` response.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    struct GspInitResponseSchema => GspInitResponse {
+        gpu_name:
+            Array<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, { Self::GPU_NAME_STRING_KEY }>,
+        fb_regions: Accumulated<FbRegionSchema>,
+        bar1_pde_base: Required<u64, { Self::BAR1_PDE_BASE_KEY }>,
+        vmmu_segment_size: Key<u64, { Self::VMMU_SEGMENT_SIZE_KEY }>,
+    }
+}
+
+impl GspInitResponseSchema {
+    // Define the Key IDs read/written by GSP.
+    const GPU_NAME_STRING_KEY: KeyId = 0x2000;
+    const BAR1_PDE_BASE_KEY: KeyId = 0x1020;
+    const VMMU_SEGMENT_SIZE_KEY: KeyId = 0x1050;
+}
+
+/// Payload of the `GSP_INIT` response.
+struct GspInitResponse {
+    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
+    fb_regions: KVVec<FbRegion>,
+    bar1_pde_base: u64,
+    vmmu_segment_size: u64,
+}
+
+impl GspInitResponse {
+    const MAX_GPU_NAME_LEN: usize = 64;
+}
+
+nvkv_decode! {
+    /// Schema for one FB region of the `GSP_INIT` response.
+    struct FbRegionSchema => FbRegion {
+        base: Required<u64, { Self::BASE_KEY }>,
+        limit: Required<u64, { Self::LIMIT_KEY }>,
+        flags: Required<FbRegionFlags, { Self::FLAGS_KEY }>,
+        tag: Required<u32, { Self::TAG_KEY }>,
+    }
+}
+
+impl FbRegionSchema {
+    // Define the Key IDs read/written by GSP.
+    const BASE_KEY: KeyId = 0x1011;
+    const LIMIT_KEY: KeyId = 0x1012;
+    const FLAGS_KEY: KeyId = 0x0012;
+    const TAG_KEY: KeyId = 0x0013;
+}
+
+bitfield! {
+    /// FB region attribute flags.
+    struct FbRegionFlags(u32) {
+        0:0 support_compressed => bool;
+        1:1 support_iso => bool;
+        2:2 protected => bool;
+    }
+}
+
+impl TryFrom<DecoderValue<'_>> for FbRegionFlags {
+    type Error = Error;
+
+    fn try_from(value: DecoderValue<'_>) -> Result<Self> {
+        if let DecoderValue::Scalar32(v) = value {
+            Ok(v.into())
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
+/// One FB memory region.
+struct FbRegion {
+    base: u64,
+    limit: u64,
+    flags: FbRegionFlags,
+    tag: u32,
+}
+
+#[kunit_tests(nova_core_fw_commands)]
+mod tests {
+    use crate::gsp::nvkv::{
+        Decoder,
+        DecoderValue,
+        Index,
+        Schema,
+        UnknownKeyPolicy,
+        Visit, //
+    };
+
+    use super::*;
+
+    /// Decodes the registry keys of a `GspInitRequest` into (name, value) pairs.
+    #[derive(Default)]
+    struct RegKeysSchema<'d> {
+        pairs: KVVec<(&'d [u8], u32)>,
+        // A name whose value has not been decoded yet.
+        name: Option<&'d [u8]>,
+    }
+
+    impl<'d> Schema for RegKeysSchema<'d> {
+        type Target = KVVec<(&'d [u8], u32)>;
+
+        fn init() -> impl Init<Self> {
+            Self::default()
+        }
+
+        fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+            // A name must be followed by its value.
+            if self.name.take().is_some() {
+                return Err(EINVAL);
+            }
+            Ok(core::mem::take(&mut self.pairs))
+        }
+    }
+
+    impl<'d> Visit<'d> for RegKeysSchema<'d> {
+        fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d>) -> Result<bool> {
+            if key != RegKey::REGKEY_NAME_KEY && key != RegKey::REGKEY_VALUE_U32_KEY {
+                return Ok(false);
+            }
+            if index != Index::new::<0>() {
+                return Err(EINVAL);
+            }
+            if key == RegKey::REGKEY_NAME_KEY {
+                // A name must be followed by its value before the next name.
+                if self.name.replace(value.try_into()?).is_some() {
+                    return Err(EINVAL);
+                }
+            } else {
+                let name = self.name.take().ok_or(EINVAL)?;
+                self.pairs.push((name, value.try_into()?), GFP_KERNEL)?;
+            }
+            Ok(true)
+        }
+    }
+
+    // Tests that `GspInitRequest` encodes correctly.
+    #[test]
+    fn gsp_init_request() -> Result {
+        let mut encoder = Encoder::new();
+
+        let mut regkeys = KVVec::new();
+        regkeys.push(
+            RegKey {
+                key_name: b"testkey1\0".into(),
+                key_value: 0xdead_beef.into(),
+            },
+            GFP_KERNEL,
+        )?;
+        regkeys.push(
+            RegKey {
+                key_name: b"testkey2\0".into(),
+                key_value: 0x1234_5678.into(),
+            },
+            GFP_KERNEL,
+        )?;
+
+        let gsp_init = GspInitRequest {
+            pci_device_id: 45.into(),
+            pci_sub_device_id: 67.into(),
+            pci_revision_id: 3.into(),
+            pci_config_mirror_base: 0x1234_5678.into(),
+            pci_config_mirror_size: 0x1000.into(),
+            host_arch: HostArch::Aarch64.into(),
+            bus_device_func: 0x0001_0203_0405_0607.into(),
+            regkeys,
+            vf_info: Some(VfInfo {
+                total_vfs: 8.into(),
+                first_vf_offset: 1.into(),
+                flags: 0x7.into(),
+                first_bar0_address: 0x1000_0000.into(),
+                first_bar1_address: 0x2000_0000.into(),
+                first_bar2_address: 0x3000_0000.into(),
+            }),
+        };
+
+        gsp_init.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+        assert_eq!(encoded.len(), 26);
+
+        type Req = GspInitRequest;
+        let index0 = Index::new::<0>();
+        let mut expected = Encoder::new();
+        expected.encode_u32(Req::PCI_DEVICE_ID_KEY, index0, 45)?;
+        expected.encode_u32(Req::PCI_SUBDEVICE_ID_KEY, index0, 67)?;
+        expected.encode_u32(Req::PCI_REVISION_ID_KEY, index0, 3)?;
+        expected.encode_u32(Req::PCI_CONFIG_MIRROR_BASE_KEY, index0, 0x1234_5678)?;
+        expected.encode_u32(Req::PCI_CONFIG_MIRROR_SIZE_KEY, index0, 0x1000)?;
+        expected.encode_u32(Req::HOST_ARCH_KEY, index0, HostArch::Aarch64.into())?;
+        expected.encode_u64(
+            Req::NV_DOMAIN_BUS_DEVICE_FUNC_KEY,
+            index0,
+            0x0001_0203_0405_0607,
+        )?;
+        // Each registry key is its name followed by its value, both at index 0.
+        expected.encode_array8(RegKey::REGKEY_NAME_KEY, index0, b"testkey1\0")?;
+        expected.encode_u32(RegKey::REGKEY_VALUE_U32_KEY, index0, 0xdead_beef)?;
+        expected.encode_array8(RegKey::REGKEY_NAME_KEY, index0, b"testkey2\0")?;
+        expected.encode_u32(RegKey::REGKEY_VALUE_U32_KEY, index0, 0x1234_5678)?;
+        expected.encode_u32(VfInfo::VF_TOTAL_VFS_KEY, index0, 8)?;
+        expected.encode_u32(VfInfo::VF_FIRST_VF_OFFSET_KEY, index0, 1)?;
+        expected.encode_u64(VfInfo::VF_FLAGS_KEY, index0, 0x7)?;
+        expected.encode_u64(VfInfo::VF_FIRST_BAR0_ADDRESS_KEY, index0, 0x1000_0000)?;
+        expected.encode_u64(VfInfo::VF_FIRST_BAR1_ADDRESS_KEY, index0, 0x2000_0000)?;
+        expected.encode_u64(VfInfo::VF_FIRST_BAR2_ADDRESS_KEY, index0, 0x3000_0000)?;
+        assert_eq!(*encoded, *expected.finish());
+
+        // Decode the registry keys back out of the request, ignoring the other keys.
+        let decoder = Decoder::new(&encoded, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(RegKeysSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+        assert_eq!(
+            decoded.as_slice(),
+            &[
+                (&b"testkey1\0"[..], 0xdead_beef),
+                (&b"testkey2\0"[..], 0x1234_5678),
+            ]
+        );
+
+        Ok(())
+    }
+
+    // Tests that FB region decoding fails when required keys are missing.
+    #[test]
+    fn decode_fb_region_missing_required_fails() -> Result {
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, Index::new::<0>(), 0x1000_0000)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(FbRegionSchema::init(), GFP_KERNEL)?;
+        let init = decoder.decode(&mut *schema)?;
+        assert!(KBox::try_init(init, GFP_KERNEL).is_err());
+
+        Ok(())
+    }
+
+    // Tests that a minimal and a full `GSP_INIT` response decode correctly.
+    #[test]
+    fn gsp_init_response() -> Result {
+        let name = b"test name\0";
+        const BAR1_PDE_BASE: u64 = 0xdead_0000;
+        const FB_REGION0_BASE: u64 = 0x1000_0000;
+        const FB_REGION0_LIMIT: u64 = 0x1fff_ffff;
+        const FB_REGION0_FLAGS: u32 = 0x7;
+        const FB_REGION0_TAG: u32 = 0;
+        const FB_REGION1_BASE: u64 = 0x2000_0000;
+        const FB_REGION1_LIMIT: u64 = 0x2fff_ffff;
+        const FB_REGION1_FLAGS: u32 = 0x3;
+        const FB_REGION1_TAG: u32 = 1;
+        const VMMU_SEGMENT_SIZE: u64 = 0x0200_0000;
+
+        type Resp = GspInitResponseSchema;
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+
+        // A minimal response: only the BAR1 PDE base, so the FB region list stays empty.
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(Resp::init(), GFP_KERNEL)?;
+        let response = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert!(response.fb_regions.is_empty());
+
+        // A full response.
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(Resp::GPU_NAME_STRING_KEY, index0, name)?;
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index0, FB_REGION0_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index0, FB_REGION0_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index0, FB_REGION0_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index0, FB_REGION0_TAG)?;
+
+        // Test that this unrelated key can safely interleave.
+        encoder.encode_u64(Resp::VMMU_SEGMENT_SIZE_KEY, index0, VMMU_SEGMENT_SIZE)?;
+
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index1, FB_REGION1_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index1, FB_REGION1_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index1, FB_REGION1_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index1, FB_REGION1_TAG)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(Resp::init(), GFP_KERNEL)?;
+        let response = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(&*response.gpu_name, &name[..]);
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert_eq!(response.fb_regions.len(), 2);
+
+        let fb_region0 = &response.fb_regions[0];
+        assert_eq!(fb_region0.base, FB_REGION0_BASE);
+        assert_eq!(fb_region0.limit, FB_REGION0_LIMIT);
+        assert_eq!(fb_region0.flags.into_raw(), FB_REGION0_FLAGS);
+        assert!(fb_region0.flags.support_compressed());
+        assert!(fb_region0.flags.support_iso());
+        assert!(fb_region0.flags.protected());
+        assert_eq!(fb_region0.tag, FB_REGION0_TAG);
+
+        let fb_region1 = &response.fb_regions[1];
+        assert_eq!(fb_region1.base, FB_REGION1_BASE);
+        assert_eq!(fb_region1.limit, FB_REGION1_LIMIT);
+        assert_eq!(fb_region1.flags.into_raw(), FB_REGION1_FLAGS);
+        assert_eq!(fb_region1.tag, FB_REGION1_TAG);
+
+        assert_eq!(response.vmmu_segment_size, VMMU_SEGMENT_SIZE);
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 5791df07a7fa..353125e2d321 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,9 +9,6 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
-
 use core::{
     marker::PhantomData,
     ops::{
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index 24dad31296cb..c592d3098816 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -132,6 +132,7 @@ fn visit(
         }
     };
 }
+pub(crate) use nvkv_decode;
 
 impl<T: Default, const KEY_ID: KeyId> Schema for Key<T, KEY_ID> {
     type Target = T;
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index 2cc0cfbad814..6d06682fca5f 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -62,6 +62,7 @@ fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::R
         }
     };
 }
+pub(crate) use nvkv_encode;
 
 /// A value with a specific index that encodes under the NVKV key `KEY_ID`.
 struct IndexedKey<T, const KEY_ID: KeyId> {

-- 
2.55.0

