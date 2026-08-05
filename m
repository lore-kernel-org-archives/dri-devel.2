Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B1C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD87810E15C;
	Wed,  5 Aug 2026 05:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8yp/AoK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B2110E151
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTJIz/EaPw5uZscGn9SIKpIlc9xsnuZSQeWE6xpTlGHVHSZxgHfUO58Wn19o14+dCDsVRQ9suyaSUgD/933yqzQPOY3aqueJgtQDwV2qNkm1YNjA1vrzMPWPUo8Fb0Aoi3i04u51RYGcULz3Fx/5dAOwUDlo6RWXOUdYv/pUpN+B+p8s7OI7oH5zHSZxmGeLi5/k2dgRkMIYdgN7SNBrY/dnZLw0DJC/VSiI3snUD7lw0BHjIkStKfEmjlKx8ZYP45cC5mzUDVv+/2xhShRE0IwKW/H7KvY1aDnAhXyp2uY2EqbcGkKU59NPGNVy1aUsUsfmHAUDYwR9nadcMw6t8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWAXh38a9EmczYF10P4OgTOZulKFGhXTT8r0uESRPNc=;
 b=hmIMCtq3cwA1VhkWs64LF5TE0x9/eI64BuUsZE4I1tBQxzcMOOYvTr0WVrB5/wXNX23grOh0OmQAbdI5CmY6vkaYvkfyhs9TOMtZx00hhxj5Rgc7p3MFzcE3gjMW9BIKyYbjrlfbTrXZKs97efj+R0X8KOt7ncyM58ynaV4phqKtkzOB0hGyIrIHqefBsOzAOh3uvSQNkrcQ4zl9NyFQflsi+TBuUhmR12tJL72MI2ExW39fCvhM1g0sbL0Pv5tsLHAGQFQ3RmNdKhKqnlWSesx0X+P7ckaTm9uef8Xzslbwy9wfgEIr1nkEJXULOe8EqakG3XoNPSFod9PnLaEsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWAXh38a9EmczYF10P4OgTOZulKFGhXTT8r0uESRPNc=;
 b=E8yp/AoKiObwWEX0RtSztQMOJO0FAA1YO2s2/VfySjEcaQRHkonCKcTD1b2PUh1Y6jAyf9zCXbuT5WpdfTAA0zle6/SV6SM5sx2O43pUspPHqMudrNWdBKcd2uiEC5q1HfcqOLWmG0DkhEa/PFN3TwALvwJPy5ysbFWY5uG+pwwfTBOLr8ykiLSblvRDMuWJrMsCWwNrmkWIXjOh2tbCQ+hnebqfC41QuDPaCjttwjvU7MWttSXK4ClYd5+115/6gNffGlL+dlDC1zKoUVVa7ecvpuNXRR9OqWGYLlZCJrJgUXDZDNsKoqiWhI5V261mCNaduatE46RaUDpX505SRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 05:01:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 05:01:56 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/3] gpu: nova-core: falcon: use I/O projections for DMA
 transfers
Date: Wed, 05 Aug 2026 14:01:44 +0900
Message-Id: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ7CIBBFr9KwFkNpFevKe5guRpjaMRYaqETTc
 HehHsDlS95/f2UBPWFg52plHiMFcjaD3FVMj2DvyMlkZlLIo1Cy5QM8tbPcTMBn7x6ol7wIHKF
 r2kYP2gCyPJ49DvTewtf+x+F1K3qpFWOksDj/2Z5jXby/J7HmgncHJeQJlBagLjaSIdhrN7E+p
 fQFUmnq0s8AAAA=
X-Change-ID: 20260724-falcon-dma-projections-ea9343cfcdae
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0161.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bb976c-9ee8-40d2-e124-08def2aeac3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|7416014|1800799024|366016|921020|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: pqauWAF2Uh1+1CCIMJQ4NIu/RRSu5dBVgKw9bPFSw0QIEPWadhKW4JLWFnS4MHuhECgNM5qbnJ5eecJ70EX+XPCxt+ktaGOPwi05B3C3eupVqbrYAP959TeaHNpJeW/K5vw6BbguuIKQeiko/xDUjGlOAe+SC2NjBDnblpUtyoDF78NXJ9KfcMGM9pOqzboaKq6pxUYNTOLPyoR1+Ba0SWcrcuZsYYiNWs5jXIKDGMbsB7XHN6Gxz1dU1GQ+tr9YP/LI7WV2QxzG1Y7vshgwYrx80IAgvNLE4XIYK+cDNE0KCHh21hmDK9DwejCCQSN+nct/8IV5aDIOmOu588FdseVkJBBhBjS1G0xWn4nFKXmNRn9kx8t5R9UnYTvlovygcTfom0bRMwEUZu/WTjaFBIv6oI3oFnQ2iuUDS3o2n8Mg50nwcFNXIfXIpP2Dg1Jtwum2aDMt1DyFdKTZAWDSOflPYV+i5yxl13Gf0Q9OLC1OBzke/RvaxeqK6XxB4z/hGIcHNAx0Yn+VHPEnZVSA3ZEpqpqEPVuQ/8h5cJyrZ5z+ZDqRQR7UITTtN1jx/kLQfFrijWhTjsAvipq2qpQ0KSyRRURa4wrIUv8My1oUlDstVnxG5ChOhhZBgR0VaJkUGnnsudTXb27OsF85p0E9SIIPYdeomeoRpYny1TZ6cgQCVuoDqi0ut9/rPUpOQQZuG85mO9fIEPkbjJKPZtewuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(7416014)(1800799024)(366016)(921020)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFA1NlE2N1NyN1VZNXN4QUhUODByeGhOdDNLSDdvUmhnS0w5cVBPVnJmVUNR?=
 =?utf-8?B?YTd4WjJYS2xoSDVQNTRkY3YvWkV6d0tVeXd2Q3NUK2k0K1gxRWZiQjhBMkQz?=
 =?utf-8?B?MmQ5WDFCWDEzLzdxVjhKZTJWNG1PYVBDaG5nVzlsaTJtMVdPV0ExaG96S0ZZ?=
 =?utf-8?B?NmdJWExjRjRYWkFZK1FtWXdyVzRJSzZmc0JWVi9VNUQ1TDJxUXpSc3ZVcElx?=
 =?utf-8?B?NnQ2NnNNeFhRQzNVcXd0MmN2ZWRSdHo4emdSeU5hZDVHRHhLWXlBZWpXbXFp?=
 =?utf-8?B?ZTdBeGFnaFA1R2RaYUt4WmN4ck85THd4aVMwWHFQU05DczE3blZIaFdkUUI2?=
 =?utf-8?B?V3ZoZmZvd1l3eWVVVjdZcE5qL2FJWmRYb045QlNJbGVJRGE2UXpSc2JPUnF4?=
 =?utf-8?B?TzVqSUVBQ1RHak9wVEZ6am14ZUJFZjlJbU5UWHUzT0NDclhINFJFS1JLSmRm?=
 =?utf-8?B?L0M0T2ZrV3Y4d0UwaGxmNDNtU0J5YTJncXllSHFPSm1kcFg2S1RTaUNJdDMx?=
 =?utf-8?B?Ym96eVNiK0pRelg2U2w3ajRhc3cvR2RocDZUeU9qUENUaUdhbCtqQ3o0Rktp?=
 =?utf-8?B?S3I1YXhpV2VEVERST2ZxeWNtUEdndGNIdzlua1g3RUYzdExKa05JUWtqeWJX?=
 =?utf-8?B?UEZIeC9aY1AwWVpPc1VCdTFkYzV5Szkrd0ptanZvVU9ZNEdXQ1ZRczQyb280?=
 =?utf-8?B?ekZZcCs4N0MvZHpTblRObi9WUTZEbEs3dk5CaDBtRXRLWFdLdzFXZkJ4Z0JO?=
 =?utf-8?B?VE1sdmpaY1lHNkVUaE90aVgxaTJhTU9GZWIyZ01jVFNITys1YjQxNTFJcWEy?=
 =?utf-8?B?SFRJK0dBU1dFazRRVElRajFVMEVhVTVNZm1zVlVpL1l0RFJKeHc0ajVkaWlw?=
 =?utf-8?B?YUpxY3FaSlhleXAvbjdxYTUvdmlTalQ2cm5Ra0ZGVjJ1cVNyM3M5QnFmTWkx?=
 =?utf-8?B?NHQzZUs0a25UOC9Ic21aS3dWUUpDNHkzb0FuYWg2UnpaOTAyRFo0YUpqZFF5?=
 =?utf-8?B?bW55TXJNY3FleStQS3VXaVRhT1NnMDJLSkJVb0h4VjcwRUFiai9VckFwSkZh?=
 =?utf-8?B?WkVSQmhiYXJ3NWJFUjdrcXArN1lLdW1XRlE4Z3RVQWdyZE43VmhFeWp2SnNL?=
 =?utf-8?B?UjlJQ2FpTU5Hdm9NYmM1UEFvSmtPMVBrYitBN0Ezd3N2TUFodk9sSUpSdGxi?=
 =?utf-8?B?bzdpNmZpdjIvMzAyTGcwV2RFeHg2S0VoL3ZCd0tkOUNVUTVQZ3djYjhiaHpr?=
 =?utf-8?B?N0kwRmRMaU1OWGVBcDJnNDBPUDZNWnhKandKZ25IRE15ejhnUXY0UmVXRmhT?=
 =?utf-8?B?YXo5cHFXVG5COTBLSmVpNGpMdzlZVVNZdEgvTGp5OWdlSjRaQzJTbHVXWHNa?=
 =?utf-8?B?ZDR5Nkt1YUJFK3dybWR6Y2ZFcytsUzdlUHpiVUQveFZTWE15OG5xVmtWUmRk?=
 =?utf-8?B?RHI2bE40K3JqT2ZtU2NrcExORE9nUVo2V1VKQ3RnU3ZIaUJnMjVGTWdoMFpG?=
 =?utf-8?B?SXpWRzFDZDNjMXJVbnFiejJRaXZyaEF5bGE5enRmeUJqcUQzMmt3azdRZzhl?=
 =?utf-8?B?NW9BT0xMYjc5NjRqZkNrVlN5M2x3ek1oSGo3SWUrVzJMcTNiaU4yNjFTSUpr?=
 =?utf-8?B?dEFGekF4TGhhbk9nTnArbjBCQk03Ni9ZWCttbjRPYkRZNW10d2x2NFJHb0VW?=
 =?utf-8?B?OEhzVlk4MVV3b0wzRnpFYkNUTHVsZVFVTGZ3TFRSQ2FDVTRZRk50d1BYOWMw?=
 =?utf-8?B?S1dLaTVVRnEydHQ4dWMzSGM2eXh5Nmh6L1VhcW9MdklmNFBzdmV4allPOVdr?=
 =?utf-8?B?WnpjQW1IaEVzeVd1VTBLVTZ5TWwzRmIvVVlmQXhOMHZUYW0yN3VYSXU0dHJm?=
 =?utf-8?B?dVdnUVEvdkZqOVhDWDlJVzBXNmU2OGFiUUhKcG9LbFMraGdocFE5RXhmdm5y?=
 =?utf-8?B?SHJQU1VJZTlsYUoyT1NjTHVyMzl1RjY2UVRwK3JrT3c3czl0alVQYWRtYXVa?=
 =?utf-8?B?ZFdlNk12MFNMRjhJVk5sRlp5bXl6K1lobDlJTWNYZ0ZWWEk4VGdrUDZHbEhJ?=
 =?utf-8?B?YUxhZkZTcmt6WjRDdUJZbUdwaHdjL2xpMDZEckZqMEpOcWtEY1FuYUR2bldF?=
 =?utf-8?B?RlMrUDBxRi95ME0yK1AyLytOQTh6WXY2N1ZPMFhCNnpBckFFL29vYWtuL3p4?=
 =?utf-8?B?YW9uOFg2TEVvbTlkbkFCdXFxOXpoYm1hNVZmQTFuTVFWeUY5ZFIzQ21kdnVZ?=
 =?utf-8?B?K3FVUmt1dDFvWXF1VXJQVFR2VXQvbFFSdVNXYXVoNS9yT1ZKWWxjNUVVdVVV?=
 =?utf-8?B?YlFBdlBVb2RmZGNBQUxudHN4Yk1kVGo2d2F4RmZUUjNoVlVla21kK0N0aHUr?=
 =?utf-8?Q?x8Pq6zouoFO42dviK276wpHdYfpP/jPYf4FUgmCO6wl3O?=
X-MS-Exchange-AntiSpam-MessageData-1: GmmKJkKkhGhVdw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bb976c-9ee8-40d2-e124-08def2aeac3d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:01:56.3333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOjp9jbnF8FvNopsE7efDBQx/tHZxIRqk1BEnACVBRuvbw0siTAdZOY8DxtgDBNca8SsB535MD6HI1LMd0xGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

Falcon DMA transfers were using cumbersome address arithmetic and
explicit bounds checks to ensure a requested transfer is valid. This
series replaces it with an I/O projection which, if successful, carries
the same bounds guarantees and does not require performing operations on
DMA addresses.

The first patch removes a redundant check that is covered by the
register's `try_with_...` family of methods.

The second patch renames `dma_handle` to `dma_address` throughout the
tree after comments received on v1. nova-core is the only user at the
moment, so the renaming remains contained.

Patch 3 switches to I/O projections in the Falcon code, the original
motivation for this series.

This series is based on drm-rust-next.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Add a patch renaming `dma_handle` to `dma_address`.
- Use `dma_address` consistently within nova-core.
- Link to v1: https://patch.msgid.link/20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com

---
Alexandre Courbot (3):
      gpu: nova-core: falcon: remove unnecessary check
      rust: dma: rename dma_handle to dma_address
      gpu: nova-core: falcon: use I/O projection to check transfer bounds

 drivers/gpu/nova-core/falcon.rs                    | 66 ++++++++------------
 drivers/gpu/nova-core/fb.rs                        |  4 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  8 ++-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  4 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |  6 +-
 drivers/gpu/nova-core/fsp.rs                       |  6 +-
 drivers/gpu/nova-core/gsp.rs                       |  2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  8 +--
 drivers/gpu/nova-core/gsp/fw.rs                    | 10 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |  2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  8 ++-
 drivers/gpu/nova-core/gsp/sequencer.rs             |  8 +--
 rust/kernel/dma.rs                                 | 70 +++++++++++-----------
 13 files changed, 95 insertions(+), 107 deletions(-)
---
base-commit: 44e7e7f7cffb10a93bb88e7cb59b7b8b3e2deb1c
change-id: 20260724-falcon-dma-projections-ea9343cfcdae

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

