Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438F8C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE9310E47D;
	Fri, 28 Aug 2026 05:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwPrze9k";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F84A10E47D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVqyowKaPDXuIh1MS1dZNUvw4LOHUQgp0zkuAq+Rsoi5gnbhESQ0OIFW9GSaSjY/GPFNkddkUhIlH0jWkqOtvYTm2RvienvcV2ujjkomTxBG/3sUjPDfw2c8kdDxMvlh3yc0gv1e0cOVBabL9cW6z0r6fSf5BHHxhnEL2/MucO4fDlp+d/KrN6qTyRCT+8FJxGQlQekNaOTo5pntS2TPtio64Kf3VdhEB4ASvNtMWCUfAL5ZYhEmLgDnHc6eurnuD6FsfPZWRjVblVbBC5nW82o9KISBrsmRCai/x8gPTTCTN6iaZwDUhdLh5NkNqDKPyNVtvvp9TTJHdcae1AZ9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mxHN5iqRQrBWtGgkt1wzXl1TwbmZK0DqdsAhUo04Oo=;
 b=mBxL3FBrN+i3E+igdZMKmzuE4CPbXUH70dehDZQM0v7vDzLNmskmLCOgjb9DxOYQjMAzzJu+XCQxjDmaIN8zcuQ8njyzPlPgycIFEXznnpqwy8Ksm4VZdGO/MmnPayIMDi2mTetFPcsiQZ2SS0x6SeKnhUJ4yU3cy4yL5CihX2t96NCIQdzjKsZQd0RQmCFw6J9nGN2dOAApBuJOopcJ7WffaY8rXU+xSfpTwQKg3TUQljjbS9JCaezoW/LD9k9VLhC6aUp0bR/wvhO4EhwRWme2xGfQXVCzPHpt81ad8oDTytRgF0v9XEug/uK7ypyg1lUuV89ecPARV8FXjma82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mxHN5iqRQrBWtGgkt1wzXl1TwbmZK0DqdsAhUo04Oo=;
 b=AwPrze9k8+N7d4glYSL8MrqtqpLfDU9pO0IRWYqx3r1zKBAuJIZ8vK4EyYpmcl7DBmpNrC4STXnfFAv3AA14BmZW1ZGJ+dXHLuv8XcP5UFmbhHQOZlIGtxFk1bdJx2Wj21l+ceFRBdv1ug9+TCOjqxM0ymXSDeX8g51JIAaW5IuS3GJo/ZkirOfRMAslcU5IIlAxZcHLwbKmIeCQ1N1f/pOCNTUemu6Z/OnsOT/wPK6uXE0gggG8tzldfO1TwiadVy69D+8Kbq/aM+QH/q7S2ztV8oLj+CRpBlwicpaV93aYJ+1jYBbxOX5ugJyBKZ/uW9eZWGAxEgpf55q6tcWPEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:33:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:33:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: complete conversion to kernel `num` module
Date: Fri, 28 Aug 2026 14:33:12 +0900
Message-Id: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyML3bz8ssT4vNJcXTOTVMMko1QLkzRzcyWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQADS2gtbAAAAA==
X-Change-ID: 20260828-nova_num-64e1b2e84f77
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:405:379::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d72220-784b-4b51-b311-08df04c5dcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: GnoumZp/8vFzOsfKavy9eehvINqWiHHdwgr2vbY/PTz0W/O/N1ie0S81rzTVaAzHoBN1V6RLZQDGh/Qoi4/9MQ0wSK+V35+tDuhVhtGF4RO0plUW7O78QnU6zmliD5TAy6g4dcgvpsrHmeuOh3jCqWVqu7ErLKJI/CInI0j5neXyazupXKfd2oMKvzyUWMQndLzJzkcP+URsuHU5IsHMIk2L1F1wDcFxY0Rtk3us7MbX68FChyybTvZ6YfXw3KkBHvTWsIAst35GQmwWWQEAl+J08jcHC1TqIVKFC7R24MjA9+jbTl5s1c6UD6DZwlCzAWeVdx5jOuwXX1a+8PQ2kCHQ57Rn16LXpnWSX4l07tMohQnkcqt+gvdN0OKZi/xegoFo8YYTvhk6k0BRiH8tlbMOF6yr/mTWtN2HYYpM4enxCWitu208oxGZ41NkfMwUKlseqkeD8YFtFvpgtEAj4b+aaJuUVpWxkWj5j2a2dA8/lmARRajAVntAlZwfyrhFR9/5vOn+tDC3zg686+vUYjJm1ErHMYq4rvyw2Xj7Pjy+Hm+dtTt6AAJW1Z7uXUO89+ngOf4O3HRDAj0cjdAGjFJo2rF41CTXvaX7gxTjcGsPIbTMecIhg6xKEx/nNKmEQEHyH/JrwLYar1E6SeSsYSNvipHUbA74oEyXNlEF0ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE5BeEE0QUFBd29uQWx2RXRuQVdFMUVzTUJCdmJCZDdENXNVV2czb1crRjlr?=
 =?utf-8?B?b2VHZmY0Z05KWG8wUmhkOGx0OVJ5Q2p3aDdYdWZkZG5jdGorQm03TEUxbkdX?=
 =?utf-8?B?VEgvRTBIQzF4emx6ckZRbERVS1EyelM0V2RPRGY1RTgyTnZXa1VSbUE5UTFu?=
 =?utf-8?B?ZU9sOWhuMjk5YUY1VW82SGUrK2VXVXpvaEcvVnNiMktTN2ZnK1ZxNkRTc09s?=
 =?utf-8?B?K0tTMjQvbzN3UC9nc29kS3J2ai9XcW9wVExwRmdlRnpiNDN6MmpaWGtPcnVT?=
 =?utf-8?B?dWNIVFQ5TU9mMGNodTgzRHZHNTRkOEdsWW1sSVZ5M2IrTlJXWGErOEZneDZQ?=
 =?utf-8?B?dldtYVV2K2t3TkJDb0Fjam9qUjNSQ1pWUzhBdnNTUzdVdmExUTJtMk50TFRI?=
 =?utf-8?B?NTF2eUpsSnl6SGxvMzlnTmtla3pIaUhDTmhEbi9kQjVGN0dzOFV5Q25zbWgw?=
 =?utf-8?B?eXUrT0lnQ3ZOZndpRnROL3dtZTYzVys0Nk0vcU1lcU1MdFpsaEV3YU5VM2NX?=
 =?utf-8?B?RzFVaFRlKytRS3pLMkpsZm1Dbkd5VlVPZGU4UnZ6QTZjU3kwbm5hdEFjNHdM?=
 =?utf-8?B?aklZTkVhcGlaSm5FblBieHduMVdyM2RSdWliaE9NVzJJa09iQ0ZuRS9TTjJF?=
 =?utf-8?B?VUlMUWYrMXgvNTZGc3FQemF4aVZvQk03TzA0WDRxbUpmM2trNktjc2gwMndu?=
 =?utf-8?B?SzlQNndtYWZYQWo1aDhPUlVoK3hIZURDUXIxVUxuY2FEVUorbVhuQng5Vllx?=
 =?utf-8?B?bytHN0h1Y2FVOGt3enk1VU03SDc4SnUzTVU2VkFJWFBCdFBpajBPS2xXb1RO?=
 =?utf-8?B?OW5RYjMvUWN6WUhybllRYmN0bW96NEUvNVdOZ3ZuZFdGNFAweE5KM0hTaFZq?=
 =?utf-8?B?MDRyZjd3VVNiU3d0dzI1K2Q4RWcvUmttQjZEay9lWG16VUlJQU93ZU13RHYw?=
 =?utf-8?B?VkpmQjRVOUJrV21EYUd1dnFtc09ScmlMWm5XcFBTZEVuTDNNZ3Y5SnZsS3NT?=
 =?utf-8?B?MjRCN284UTJhejdTYUpHbDNIaVl2T09GT0w3ejhpMEUwVmdVR251dXNQMnFp?=
 =?utf-8?B?U2FLY25TWkdLaXFvQXR5NDFENXliSkt1NVlucUVSQ1pGdk90V0NSVlVKVmNP?=
 =?utf-8?B?NGVYR1lWOXZDZFFaWVFSM3ZoeUhpekNYRWo2U040VkczSUI1Wkx4M2hCZmVV?=
 =?utf-8?B?Ky93dEIwTy9oNmE4dmNkSmgyNWNDKzBRSzZVM0JsMTljM0VNenZRVTltdXBq?=
 =?utf-8?B?QklEWm1LMnVWdnV3cXlpSWdhNEVUUjlIYTZiOVlCMDNlQVk0Wmd6VFBXcTNy?=
 =?utf-8?B?REU2N2hqY0RXOUdTUTd1RXNURGlGQ1RqWXhOTmx0bEMyRTNIYjNieitUUkJs?=
 =?utf-8?B?bzB4ZnZueW9TN2pXRlFKMkU3RllWbGIwcjYzTGhoZDJZbjhxMFNwVGI2T0Vt?=
 =?utf-8?B?Y2hsT2ZvWSsyajFmcU50ZHl3dFUwQzUvMENrVHRBbzMrcExCc1A4UWtFQW42?=
 =?utf-8?B?RjFjNWwvTGNndHYvSHNGS2N4SW5BS1ZCNWdzZmxXS3dkTUhtbUE1RldGbXQr?=
 =?utf-8?B?RFIwSlF5UG1XK0VqSStTSFN6YkRCemprbXg1TnFKY1hZV2ZTUzBTVWY3bnNq?=
 =?utf-8?B?YnZrSENnUWg5U3Z5Q2NLamNGK3Fha1E4UWdjTGJla1dsaUh6MTY1T0ZSZTdE?=
 =?utf-8?B?NkZoYjJCK29nMGxZaGhURWFKbkhTenM3MlUyTnVnckdzNlgxYVJlejlxclRz?=
 =?utf-8?B?eit6R1dOaVQ0RzRZOTdHV0pjMms5SlV0cXUwQWFVbXJTSVlsUlQ4OWxOQzMx?=
 =?utf-8?B?K0dzRUpabmJVVHMzZytINjFXNHJMMS9rdkovR3l0R3J6UUtVakRqTmVIUzNp?=
 =?utf-8?B?TTk4Y1BNYllyZmV2UW13a0J4azJjYW1lT1Fwa3JLN3ZSRDdQWTI4d0l5Znh6?=
 =?utf-8?B?ZWM2cnBtd0ZuTS9pL0gzWnUwWWgzSnRxck81NWgyNHlXRnRjSXJObnpBN0RW?=
 =?utf-8?B?d3FGcGRBeVJucDRDelZoMmptTWl6TXFFY2Rac2tGN3U0YzZrN2dUYnZvWlhE?=
 =?utf-8?B?MjdYVG1jN0xqWGZyT2pwUlNBczVmYXE2K3ZVdmhqaERNSStva0dZcmh2WWJJ?=
 =?utf-8?B?SmprQ2JaSVM2Tm1nUXJrb1NER2RjUkpjbmw0QkxJdWJWa3RHaDArZkpaZ1BT?=
 =?utf-8?B?UmpsRXM1WTFMSThTbC9YdXh2blJId3hyZjY3V0YvalkwR0dvOFF4ajRzVklW?=
 =?utf-8?B?QldSTHR0ZFNBcFgrWlZjNUZDZDBjUnFCWWRreHBXZnVMM1gxaWVPNkpncG52?=
 =?utf-8?B?T3hqSm1tT0g1SkNKY2xnYURaVk84eVRPVit3bTZPbUlmcGMzUUJKWExmc1FB?=
 =?utf-8?Q?2p+QzOya8K7KHINaYoP9EgC+1mkPH3uIL2i9RSrMCaX30?=
X-MS-Exchange-AntiSpam-MessageData-1: ph+HwqNvQKj3+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d72220-784b-4b51-b311-08df04c5dcc4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:33:16.9894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kglxr1nqoRWEcAFXqwnA+lIW5fjjW5/yksGwLTH8TmoSL45CWn57EVzjYSRZ78sfSjIRYWdtyG3do/n4BunN5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

This is extracted from the now-defunct `const_as` series [1] and
does the groundwork required to eventually convert nova-core to use the
`cv!` macro [2].

Patch 1 does the minimum necessary to convert nova-core to the kernel's
num module and removes its local copy. Patch 2 broadens the use of
`FromSafeCast` to avoid having to refer the `casts` module at every
conversion. After it, the only references left to `casts` are the
conversions done in const context, that will eventually be replaced by
the `cv!` macro.

This series is based on `master` and should be mergeable after `-rc1`
has been tagged.

[1] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[2] https://lore.kernel.org/all/DL051FB1HOBY.2UC911T3M9AIS@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      gpu: nova-core: use kernel lossless integer conversion module
      gpu: nova-core: use FromSafeCast wherever possible

 drivers/gpu/nova-core/falcon.rs                    |  12 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
 drivers/gpu/nova-core/fb.rs                        |   2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   6 +-
 drivers/gpu/nova-core/firmware.rs                  |   4 +-
 drivers/gpu/nova-core/firmware/booter.rs           |   4 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   4 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   9 +-
 drivers/gpu/nova-core/firmware/tlv.rs              |  11 +-
 drivers/gpu/nova-core/fsp.rs                       |   8 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  25 +--
 drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   4 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
 drivers/gpu/nova-core/mctp.rs                      |   8 +-
 drivers/gpu/nova-core/num.rs                       | 211 ---------------------
 drivers/gpu/nova-core/vbios.rs                     |   2 +-
 19 files changed, 81 insertions(+), 283 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260828-nova_num-64e1b2e84f77

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

