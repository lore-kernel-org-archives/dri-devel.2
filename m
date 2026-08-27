Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A412C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FD910EEF8;
	Thu, 27 Aug 2026 08:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JcocZZK5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83A610EEF8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goRclbBSczFP4ELWxljMAPWRRJpa1ls2uvh8k3YInfdrbUh+m4ang5tO9ANtGejAgkSGpv2mkHdWmKhNcJ6bHgHzp106+T+Sd7sgHzfgQflAynh1j5TG7HTxN5ZH6AMylxJqkhqPzkPGvmTWFTxmAKsrCr2a/h0s/lHUSPBZ+5Pi3X37PbBq1rvUSfs5gcvl9vyz2ZRtRsyyRSgc4sSMkVmByx+yrqjsD9zVkembjdW+qAQEb7PYCYRW5uz4s3/rBqsRC6K6FbnaL9fIdfBWYrNdvmMTDSTBx55l2rvCm06MNuOWKIsYRanV/hiXoZR5j8UB8RHodH0kFv2Fi6IjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrhQCq9TfB6+BQJFSUUUFXtQ5C7LOiyKKboARNboz4I=;
 b=sm8Dl37UGpaLdeYqc+8ZuVIopRIQ74Tr/c5VveJaGfWy/+tMGRiEJwi2forjAUnHE3S+OwpuTS87eYPQHzcwT0fWchVGcrzuV0OuVlNTKo/gBm3513fEiIZmWhLLeACiwap9ev2ZRl+vVtHIbB2ty8AcZLB3/BKo3pd+h9x6TgWYS7zAcHZxSTGXLjGHFc+BqrEUq+il45yl4zLc8aQ4pgnhu+6PgfTZS/lwdDoAMHXNqyHVXycwsTILdvb6/FJ7Sg5/MP97ALJ3SE2+sg0CO/ggXtONHf0RJ98sp8cLggnq7IJX/2RmPfh0hLeU+TLWHJgp7812QYttZOWdNr+HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrhQCq9TfB6+BQJFSUUUFXtQ5C7LOiyKKboARNboz4I=;
 b=JcocZZK5FRAPvYzEbYoKqha9sZfxO7vpb/lXtU/yWJKlHU7sVCeRBvDJ6bPFn//NgWiDlR/LcCD+X0jGub7/SbufnFyZv1/AK3fFmAFiveszJiudAp13Cqy8A+dLxOfril8FonE//sv0P61PdPO4MfQTmXrEE24jwC+VNA6MqQpbjhbRg7m1BXve3Afn3WN1bdTuancXgRvAgQ9NzFdHA1gdui8oPtKOCR+Nxd6DNOewXhR4h9qV6oF9FPTc8HpB/tlH/aDVyXW8fUd7qWcF6Kk3XfvYWhWE01h0w3vxpPpjZl+y2NdreuHP851z95/Kr33oiZr5hHvcnq8XxMLAFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:31 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:48 +0900
Subject: [PATCH v3 07/10] docs: gpu: nova-core: Document the PRAMIN
 aperture mechanism
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-7-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f62721e-144d-47f9-25a9-08df04188782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MK/9n9EbvbEIneLbp3ehrbN4Ga42IupfChZpa29n8rzNmqzs0QQxlmbTyI2MgcbIzXJU13Nx/lQNjKnbvv7htZwlbDtURNIbQUFNjs7XHEYtQVnIYbbMD2ecG1u9Wz5SjGq5qL4CeW/pN10fAmiUuyndwYwmG3OWMx4vGGARmB/B8+2u2KESP95LAlE2QxSMBawDSxueNcFOw1bozoIRFkxZfNNWXCeIVbWD88y1eVdf9cVRfJ3SVldcoRE2468G3uducrxb41dTd46p481JfX/h9+PJuFJ6sLMa8c7s3p4503Oobxc0Js1qPWbXBEGRTEC/ZtQe7D55Vi9nIBc3Wy9fKtmqINRjRtejzTzD3HfobMIMD3xhFxcGk9ZhiLzRazPZKXSYD/jupR/EVfLQuiFEVHfG3rIWnNuW4aluC2po2LiA/qHAh+19ThmwSh+pXDX0nyFXvEXSE6u7Aqb6AxqkJApu4VFAhwl1CaDWtjQz+H89xEeUx5oEZ1VhT/dxrDB/sMByMALPcwem/4k088mMlR8QYer8JtP7BpJREkAuRNv0uBz452BM6sggnwegRBiLWhrfHhaVz3jaggwj9804rJZSoELHW3YIYQ5ItG1CLkN498xZE35FKJUpQaacrHmHXB8AMsUkeNjuYQV2po2DLnrmlBeXYgLjCVuycs7cA43iZwBDFIjREm6aamE9cria3DxYSGGpYFsPui+S2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lUTFJWZGhzY1pMYzIwVnpBL25IYUpCcXdGaWEvTUR2aTFuL2lOQk50R0lC?=
 =?utf-8?B?azh6d1JVYlB0aFp3RklObTBlY0VCYzgwNXpoMTVKdldmanRiZlA2VDRIenpP?=
 =?utf-8?B?ZGlFMmx3UjhublZMUzlDMFdkYm9hbitDQmNjOVkzWmg0NEFrZFpIeXZmdGhq?=
 =?utf-8?B?a2JTS0hMM3craW82Tjl3eVVtRVlWQlhXM3dQdm9nUGJvR01qeGJMaDlPUXNJ?=
 =?utf-8?B?bGR1dnoweXA5TW1XSkFnMHVDZ1ZWQ1NyeWV1d3FRSlNoVW9HZ0F2aDRmbUtm?=
 =?utf-8?B?anM2SjZlNmppdElNUU04aWphMTBhTjNEcGtzWXYwZHhYaGFLa2lscGVtcFNK?=
 =?utf-8?B?NUNCZno0YTN3Q3hVTFlRVGtRODJ0TUV2cHlONC9NbUZnOXdZd3lTUEtOY3FJ?=
 =?utf-8?B?OTJ3d2tFZUdPYzhkaDhhRXZSaWFISWswOE9PcXVpT1NBYWM2YTZKQ1VIWmg3?=
 =?utf-8?B?V21RM2lQZlVhNE52SWlGLzA4eTJQYXdHK2VSaDlMeFhJYld3ZUQ1cE1mejNI?=
 =?utf-8?B?ZEdmS3BvZ0NlLzRFT29BZnF1Zklua3hwVHdSYzNYMXUxdmliQmdoOUt0Sjln?=
 =?utf-8?B?bDJJV1p2OVJhR25lYTNrMURlYiswc0tZU2pqd2c0eEV6YWdTVjc5aWJhSlU1?=
 =?utf-8?B?L0xUWGtBOHhKdUlmMzIwT1R5Nm1LTkJwd0VBbGZOOW0vaHUvNjBMZGRuclpz?=
 =?utf-8?B?andQd1YvVlIyQlZyemYrZHVzRlpVU1ZrSW9ycmNRMEdnaFRCSHZ1R0Z5ZnlU?=
 =?utf-8?B?UC9CNUVmdUUzVUhGWS9PRHhGTUh2NDAvMXJkUm9SbXF3NkN1RE5PWHVUaGpX?=
 =?utf-8?B?c0U2NmJHZ3VzbDNrdXJzZSt2RUxsSGZuQ0tnKzAxaDF4cjFkaHVuQ1AzMXlj?=
 =?utf-8?B?RjFNQVlxUytRc1kyR2pKU2R0SDErbG9lNU1JWXdCL2hjeWUvUkV0NGlQWjZC?=
 =?utf-8?B?c3BjeHcrU1BHNUdtSENDRmtOYlJwYkY1M1dyV3Z4RTlOd1ZtSVVUTlJwaU94?=
 =?utf-8?B?V2h0STlwMk54U2c0cmZrcVlaNHNzK0VvRVdHR1dyeEJERGwyNHU1UjdJbW5v?=
 =?utf-8?B?dENOb0pVU2swRllhZ3p3VjBaM1dGM3llMkN0aGU1blAxN1JHN2kzbEFSdFF2?=
 =?utf-8?B?a2dwc1JVUmgvOERCalkrWVRJaEEwZXIvZ1haTDd2OW45YWNLbUFtUWl3dENy?=
 =?utf-8?B?UkJCN1lLZURNRVZ1a0oySld3azNzeURIMnFSNyt6eTNEMnM0RmJXWWJsRHhZ?=
 =?utf-8?B?OTNEcjR2U0QxQ3JJbDVvUFgvNmFVdFBCWXFLOExEUHN2bThmK1EzRllkUUYz?=
 =?utf-8?B?cnBZeGhLRXFOeUt5VEhoWjc2SnJobmJ3UitZYU5ORVVsRzBRcTVTSWlXRGpk?=
 =?utf-8?B?OG1ESXdhbjQ5SHpxNm4vUWxCczIvc2ZMQkM1NnJTUkpYbDNFYnVjam9oVGpL?=
 =?utf-8?B?QS9MN2NNeWVCNElYaHpiejh1bkJDblNYWllOMUlwTGJsempZTVBnZEhQSVB1?=
 =?utf-8?B?UDhGdXNOZWNZaGRxdkg3dGkwc2I3OVAxUFc4RHo1N3Yva005ZDhaRkMzczdM?=
 =?utf-8?B?dVJWN0h0Uno5T2cwQ3hXTFlpMWNRZHNPWTFPRnNoMjdIaERrdldiZ0R2UVE4?=
 =?utf-8?B?Zkd2eTJzZmNTdU12UDE5bnNKR0hjOENrUHU1cmlxeFFlVW9BVXg5Q1dJdUNl?=
 =?utf-8?B?OStEaGdXcGtvc2JDYlV5SkdlYUhYRmFMYjMzUS9jOXAxSEwwbit5TTJTemJn?=
 =?utf-8?B?dE5SWWR0K1gwSGlzTnI2QVFQQnZNY3AxVktTbmdUQmUxM0xOYmZMbDBYaFBV?=
 =?utf-8?B?emdtb3VnZG1xMXhtZkQ0RUZDeWtFVVRxaFdoY0xsdEJoMlBDdkFqY05jblJV?=
 =?utf-8?B?c1NZVXN1a0l4dVRTUTJueEN6TUo0QUNqQlMrZExlRVdGMDZMOUZnVFJQWTQr?=
 =?utf-8?B?RmlHb1g1bFpNM0Z5b0N0dFlTRS9ZeW9WRWY0aGNDK3JBY20xMEZYa0dQa2da?=
 =?utf-8?B?T2pOMFYwN0JDOWorbzRORlJRRTJrN2FsdHNQZ2dKanByNm13MWY4Zll5UHRa?=
 =?utf-8?B?UUsxTHhOUk1qd0ZyV0pZZFY5MjRheStEd2Vxait1c3VuOU9sNU5FTnc3WDZT?=
 =?utf-8?B?cGpWTE54NkttaFRZQXBVaWlLcWlKSDlGT2VBQjBUV1NzNW9MUndqODFUNFZG?=
 =?utf-8?B?b3hQMWlOYmpSaHB2TXVtUFViQWJRUm5NajMvUFZKZUVsZEQ0R0I1di94WU11?=
 =?utf-8?B?SS84NzhpQ09GL3VqeUFIc0E4eXBReG1xRnRYanBnWmlvR2JDT0dJYWhEbEd3?=
 =?utf-8?B?amczSHpXWmVTQjVIS0NpYnRNQUlQS0tIK1V0U1JRL1ZEM2xSTGlvU250ZHFn?=
 =?utf-8?Q?6dCWr5jw5F4PNZpqNh3gJvxD3SAmH7x+2tHXCWoCJraib?=
X-MS-Exchange-AntiSpam-MessageData-1: axpu2ODQBwBvVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f62721e-144d-47f9-25a9-08df04188782
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:30.9979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /et0SaZcwdcMM0ETfoSy7ubKSWIqZ3SaLUywHvDGmVzAivQUATtlusIVIFzzgmDfy5YvrU98ppQJGIIILHxB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VRAM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: fix the TARGET encodings, KiB/MiB units, wording nits]
[ecourtney: wrap at 80 columns]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 128 +++++++++++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 129 insertions(+)

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..f50b052d73ba
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere
+   family. It may change for future generations and is intended to assist in
+   understanding the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video
+RAM (VRAM) before the GPU's Memory Management Unit (MMU) and page tables are
+initialized. This 1 MiB sliding window, located at a fixed offset within BAR0,
+is essential for setting up page tables and other critical GPU data structures
+without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe
+Bus Controller Unit) and provides a CPU-accessible window into VRAM through the
+PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+ <------------ [1]
+                                    |  |  |   PRAMIN     |    |    |
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1 MiB)    |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+ <------- [2]
+                                    |  |       VRAM           |    |
+                                    |  |    (Several GiB)     |    |
+                                    |  |                      |    |
+                                    |  |   FB[0x0000000000]   |    |
+                                    |  |          ...         |    |
+                                    |  |   FB[0xFFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+    [1] Window starts at BAR0 + 0x700000.
+    [2] Program PRAMIN to any 64 KiB-aligned VRAM boundary.
+
+PBUS is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1 MiB sliding aperture that can be repositioned
+over the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    The 24-bit BASE_ADDR field encodes bits [39:16] of the target VRAM address,
+    providing 40-bit (1 TiB) address space coverage with 64 KiB alignment.
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: Reserved (unused)
+    - 0x2: SYS_MEM_COH (Coherent System Memory)
+    - 0x3: SYS_MEM_NONCOH (Non-coherent System Memory)
+
+.. note::
+   Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+   target values are documented here for hardware completeness but are
+   not used by the driver.
+
+64 KiB Alignment Requirement
+----------------------------
+
+The PRAMIN window must be aligned to 64 KiB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x0000000000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x00000FFFFF +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64 KiB-aligned boundary   |
+    |                                                         |
+    |  0x0123400000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x01234FFFFF +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0xFFFFF00000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0xFFFFFFFFFF +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index 2afa58e8f08d..59b206238498 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -34,3 +34,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/fwsec
    core/falcon
    core/tlv
+   core/pramin

-- 
2.55.0

