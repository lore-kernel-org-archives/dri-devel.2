Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F343C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1D410E0F0;
	Tue,  4 Aug 2026 05:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLU8e1qQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6D910E0F0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiSEOmBjO120WkOk0b9Xy3StwxAfnJ+EMVjzacLdb3TdgPSkwdOgVGXsv1+PsYkEU2/YxcCR2fKQMW8/yIZ8nkALyHAy54jWtMgij2ZIg4D0/ELZtmFij0nGD0VGXatp5udGqjltfJjNxmmOP3cpPd/Y3DfuV7OXJq7RpAx5+08NOW24vTAWjgH6F4dhlzHe690K9dN3ntjd9Ixd7Ef33RNtkzDG6vTE1BxHS28NHe7LH7TEA6EY7gTdKqd5TduV9CbMg+vynX1tvHfmj3/W59Fadez4HJrb7hzkzR60Uv3dDRm3HBAB1jl3EgbHrkaKDR5iiCezrZdmObfTIDtBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx2L83N0l8U91v5c1dAV4kkhyXvNvD91IgfSo4s0w+s=;
 b=Axrbnnqx6NtRVhovKPhPLMFcq4kOPXLQ7HU3CyIUYP1FeyX7R5Svk6Hj2Ul0O1Smw8y2me1CfzDRT8urf3kWXIwfB3/KUHo8LVahrkg4pEUJsKDj9cbmnBBsm8UhA5tHwl4ZeS5VxA2MgiHH3x2H4IzRB4bNkkf53P2hM4wASgKcRUIGlnRV12Q7YoMQtgTJYBu5fPuY4GxWEw7Mq3/FSOrVXbBgeZuV2x0vdZu/ymLlO+Q6ftULUCXAtoPz+psTq7AeONll2IQRVFiV9UoW9bZKTvbs8jLEAEAlywiIl2Wk3coAd/fnWsf8j7XOkSDbngHLFUQ6PcVfW+atc7BqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx2L83N0l8U91v5c1dAV4kkhyXvNvD91IgfSo4s0w+s=;
 b=lLU8e1qQQEuzf3bKyr5sHQyx2sV3flbMOA5LLRS9AbkykbfO1/HxvjoRf2lZaX21oqhJLERRB241LoYUXmKnqMnq27t1U5Wd1B+FAPOgZuRRGxK1rH/GA8zssIEU6LIg3a6vG1KRLIZqOR/tH74ZpmOy0ZSQq34mZjTem2/uJk5HGiwA/p4vOjEHzzgEgJcS8xw7rt++6IvHeYn+EvhtvFXAuoPwDSJwcSCPAW50fkDU5tCM0E0VOFnu8fIH9uBV4fJxVKPjCzwTAm3cDT0UKKC1gBD6LsN/XfjJywl5cc+lrPNxx6oq1dqiLa/ZMZyJ2/fUeat+CtJgqzIINtdXyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:30 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 0/5] gpu: nova-core: blackwell follow-ups and fixes
Date: Tue, 04 Aug 2026 14:41:11 +0900
Message-Id: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQ0a7CIAwG4FcxXIvp6DaZV76H8QJYOaJzU5ioM
 Xt3mZp4zC7/0H5tebBA3lFgq9mDeYouuK5NIZ/PmNmp9o+4q1NmAkQJJUiuG2UOV2oabt2NAkc
 wFRbSVKCApa6Tp9dDatps3zlc9J5MPzJjxc6FvvP318iYjXUfPSsmesw4cCtkgZRX1i7rdRtd7
 dTCdEc28lF8gSXgFBAJkIS11AaF1tUEwH+AyKcAJgAypUpV5IT2d4PhfaGn8yV9Xf85exiefI9
 0CFgBAAA=
X-Change-ID: 20260608-blackwell-fixes-30c9358c90a0
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaa576a-ec72-485a-3f60-08def1eb0781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /hZCKYW8bsIOJMZ71As/efZURd/4zYj1Pdkj9AVOvjc3+x7817GDvf8E3n+HfUc/iqHqjI/iaLn5h3xQD0LHzu9PUALmKNvJjZgAaK7ZAeViKvd4jjTzIkpn0eAOWzbtDedcvEsYCg4CIEbvS41jWPJEKULcsXzlXDCJ+Ki1cLB0tCNOmBeyRMX783csRK0ttjOquaN8jKmURuPmy/XrLPT6qjfD4PDffKg4IGqj1H7qP2ft1aFGQWT6XmZhZ5d66m8lauhFK60YYE39Ach1N24x2LKd5N3BrSrEOHz0AUO5+LuCLAQmpAUMhLRUnwkPhD1L07IMopfjrdA3sLaOB6EMbJjotI/F+j5POVw1tOGKr2W6WOUPpma6Wlokpmg+QfCTnfp7Sdk9PKR9Xx+TF5WIVJw/MVD9GZ52d6KKRQZ2HFMLpkbGVF9IxsZ2LZm+mMIYX7ax0QnqqFNTVSKliT/YRXM9121KPdh66S4eNP7F3fCweHovCj+fmQmtO9RKn7RP3ba3lH3eg0AVAZtRCCK84l5/LHzmkK0l95ZKez6BlXKm9ABtg0u6R+G71n0vbnD8wpMK0KRCcjXje+W257w0XpWn47Cd6LZ0yu16TOrFClglt+AXDOA3wGxljiix1fdN2VlzYoAP/KUFzbUR+tKHyX1I762vt6/0oNXlSdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVNMUw2WktoVkNramxLMG1hMjYwamZIMjJWN3Z0T3JTeExKSDFINHhHZlJD?=
 =?utf-8?B?L3B1cllnTEQ1RE92RzFpeDQ1cEY2Ump5OGRCbk0wM2ViNEdvR3czVHVQYXRX?=
 =?utf-8?B?VmFpcXJqVDFaOXJDMXd6Mmh4R3lkYkt0N1R5VnZrOUxkeDVWbmUwVGhzNW1X?=
 =?utf-8?B?c0dHRGZTVk9YTDdUZlA4cTU5ZjJXL0ZEQ3MrT2FZWFJsWVdkZ3hYak1lbldo?=
 =?utf-8?B?UitsRGVxdWJRdnMxQ0FjNGJaSUtLY2IrY1VRdXE4cFQ5QVdETkhBNmZlR2NG?=
 =?utf-8?B?MDMxS1psNmJtNUloMWM4QmYrejBGdUl4Yk1ndEt1aFNxVHA0bXNFam9lZkJv?=
 =?utf-8?B?WWJVVHh3dUdkZWsxZ3lyUHFsYWpORVk1NHBuVFdmNUU5L3hFa1kwM0VFMVE3?=
 =?utf-8?B?MTdYcDNBRklZUXUwNUYwaFdCemw3Y0VBUkZIYzhON2hUdUJxSDlBeWEzc3hO?=
 =?utf-8?B?U3lYVzJVakhsa1pKdE9hdWpFd3BPV2JBWGxpRHMvMXMvSTliTTlZRDJ2UzlK?=
 =?utf-8?B?MTRWU3BnVzdzb1VOYi9zYU9vMkNkUTFMQk1vNXN1KzM0KzZJR0hOcDZ2Lzgw?=
 =?utf-8?B?N3ptaDhhOW93SFZpWldPSmlrQzFPNUhhZXZaRDdKQ201eUNlUkJLQVpqOFI2?=
 =?utf-8?B?bmZhMzNNeUxxVnBVMkV6Q0Z3VHQwdHVqejdpNWZnOHY4c3d5dThOS1MrTm0z?=
 =?utf-8?B?SnhtMXd2WHJVdlN1MjZaWWdFcnNyLzhEamxYV0VUYjFFV2ZIQVFiRTFCSnRY?=
 =?utf-8?B?MjlVa1R0T0RKYS9kT0l0OHdlaEpMYVdWZkZ1dUIyazlBT21JVXFFK0VxaFZp?=
 =?utf-8?B?UTlXeE9FQ3lHUFdyQzBBWnJaTDU2SVhlKzl5d2pxS2dRSDFHVlFHZFdjNS9a?=
 =?utf-8?B?Mlk3c0hxN3NQbXQ4aXpsTEpqdjZIODZVTWdiVTV1OXg2ZHhOeWlhV3JicFpZ?=
 =?utf-8?B?OWpqNEFudUN2dzFiNCs0cGM2YzdrT0Z6Q1BBekFVcVlkQXdLMnlRN3VNTGFx?=
 =?utf-8?B?eTBxbXFhT01LSTVhanZvZEdybHZUVDN3RUowQzl4WDFodlFZRFFiandWU2ww?=
 =?utf-8?B?ZmVFTERmcTNzR2wxOCsrUEFXSlVNaDVCQVRjYlpvTmR5cHFBbE9LeThtaWlq?=
 =?utf-8?B?c3lmWDREQ0dpM2w3SE9pNXVCUU5acGk0YWNKTm9LSjNtR3RSeVZRSmpzUXht?=
 =?utf-8?B?c2VYOU1kMXJaTUc1RUxoTi82YURvSi9tVGI3WmVndTlhS1FMRHRHd0RNVU45?=
 =?utf-8?B?b3JsRHl3STFMTFF6aGtFalZkYTZiUXVMSmlRMDFMdzVHMGtsb3U2ZjZCNGo4?=
 =?utf-8?B?Y1ZsY3k5Q25hZ0ZXUHFBUXVVL0x2S1I0aWJsUGpyWnJWU01XM3NSM0lnVDVt?=
 =?utf-8?B?YUkxblU3RDhQVStrZlBEUW1jR01LNkxObTNnU3FJM1RTb0VoZk9WOGMrMC9o?=
 =?utf-8?B?VlRkSk4wTFBjVmtaQ2k3aGpsTzZkUm1oWUxLOFhpM0NTVzF5cFh0VzRLYUtw?=
 =?utf-8?B?em54U3dvSHE4bmtjU2l6cnBIdUloeDVKTGtLaDZnTUFYQTZEK1gveTJPWWVV?=
 =?utf-8?B?Wit2VzhyQ210UDY4NE5xSzdnV21GZ0dpeUdnSG1IRkhJd21kdWFUNGRVQnE0?=
 =?utf-8?B?ZWs3Vzk4NzVuZjJaL3FCNmVXVlNmeGozWlJXajdDTmhKVlBoaDNPSkVDcklJ?=
 =?utf-8?B?RENrUWgrY3hYNEZEVEdYRzQ2S0krVE0weWU3elNDNW5RVXlWWjByUGZ0RW5U?=
 =?utf-8?B?dHY2cCtFWkN2T3JLWlJiZVF2VnBycWdDdmhscjhEcitPOVcxZ3ZFd1l0TWMy?=
 =?utf-8?B?YmdTbWN1L0NTakhIdTBhQnR0Mk1Yems1STFhemc5SGY1bDU0clJCczlyL0lR?=
 =?utf-8?B?d283cFJVN2hBS0tjVWpXVGExY3A1Tm84MnY3TTNTYndKd0E1MlE1M3FVVklB?=
 =?utf-8?B?Sis0N1p0eG9udW9mWmd6cmozMFVJaHU3bm40Rm95MnVyalR0UnROWkJBcXJR?=
 =?utf-8?B?QzdveVdGMzdTU0JYbTM0SzN5NDZ6OGhBanpuUXRwVFl4aFhaZjJpYzJVYURr?=
 =?utf-8?B?V2xwQVFyQWZaZkdKRUtPbE5RTjFOVVJVY1djakhDNmcvZXFDYmpFeDVmMEE5?=
 =?utf-8?B?WXNoRmNPMzU0MWxjTTBrOUVXcWhCUzdBeGdIWEJ3dTQ3aFZUT0MwWVhDME13?=
 =?utf-8?B?ZGVuMy9SV0pFcW5EanF5enByVFExL1ZtMXI1M3ZiM1M2UXZwcVpLYXZNOVJZ?=
 =?utf-8?B?VnkrZ25CR3VtMHdGaTM4VXJQSDl1c05lRjVVV09ESU1VbkhYRXowcDRKSnRN?=
 =?utf-8?B?UElDOHo0N2JyYkorSWh1QWQ4VmZudE91TmxnanNhb0pHbnpMVFdOSHlLUndX?=
 =?utf-8?Q?0ztzqHwY2X8m9X7Dw4JEqJxt0TSxtzeOcZ0mYKN6p3nsm?=
X-MS-Exchange-AntiSpam-MessageData-1: 7+zwJd0OiUULMg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaa576a-ec72-485a-3f60-08def1eb0781
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:29.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLgIKfiwaNrcciJtr9WYnp1/92QyQsEdrW/emF4OlxERH0DV/zTFBGn1x0XEJdukdmZEqKA5E91QxQ+6m90mVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

Make FbLayout code more obvious and correct.

Currently, the frts vidmem offset is calculated based on the non-wpr
heap size and pmu reservation size, but AFAICT this is not right. The fb
layout actually looks like: | non-wpr heap | WPR2 .. FRTS | PMU reserved
| ... | VGA workspace | It's just by coincidence + generous alignment
that the values happened to match with something more like pmu reserved
size + vga workspace.

`FbLayout` is used for both pre and post FSP architectures. FbLayout
contains ranges for each region of framebuffer, but on post FSP
architectures, only the size is actually used. The region locations are
decided by ACR, which runs as part of the GSP-FMC, not by the driver.
The driver only provides the sizes. So, for post FSP architectures
FbLayout contains essentially guesses for the offsets. Instead, make
separate types so that we only store the information that's actually
needed. This includes the actual reserved size after the pmu reservation
so we can properly compute the frts offset.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v4:
- Rebased + added shared vGPU helper (Alex)
- Clarify comments w.r.t frts offset (Alex)
- Clarify "split Fb layout" commit message w.r.t. ACR (Danilo)
- Link to v3: https://patch.msgid.link/20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com

Changes in v3:
- Remove patches merged already
- Move `fb_end_reserved_size` to FspHal
- Move construction of FbSizes/FbRanges into GSP HAL.
- Link to v2: https://patch.msgid.link/20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com

Changes in v2:
- Rebased on top of 20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com
- Dropped applied patches ("falcon: gsp: move PRIV target mask constants"
  and "fsp: move FMC firmware loading into wait_secure_boot")
- Dropped "gsp: keep FMC boot params DMA region alive during error" - 
  will finish discussion/fix on the bootcontext series from Alex
- Drop "fsp: try to enforce exclusive access to FSP channel" as not
  necessary.
- Added some extra fixes around the falcon "halted" state
- Drop "wait for FSP boot earlier" since FSP is now at Gpu level in the
  bootcontext series from Alex
- Don't reset FSP queue pointers on error
- Add r-b from Alistair
- Return EMSGSIZE not EIO for FSP queue return message too big
- Link to v1: https://patch.msgid.link/20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com

---
Eliot Courtney (5):
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: pass WPR metadata ownership to FmcBootArgs

 drivers/gpu/nova-core/fb.rs            | 75 +++++++++++++++++++++++-------
 drivers/gpu/nova-core/fb/hal.rs        |  2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs  |  2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs  |  2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs  |  5 +-
 drivers/gpu/nova-core/fb/hal/gb202.rs  |  5 +-
 drivers/gpu/nova-core/fb/hal/gh100.rs  |  4 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs  |  6 +--
 drivers/gpu/nova-core/fsp.rs           | 44 +++++++++++-------
 drivers/gpu/nova-core/fsp/hal.rs       |  4 ++
 drivers/gpu/nova-core/fsp/hal/gb100.rs |  6 +++
 drivers/gpu/nova-core/fsp/hal/gb202.rs |  9 +++-
 drivers/gpu/nova-core/fsp/hal/gh100.rs |  9 +++-
 drivers/gpu/nova-core/gsp/boot.rs      | 28 ++++-------
 drivers/gpu/nova-core/gsp/fw.rs        | 85 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       | 12 ++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 21 +++++----
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 32 ++++++++-----
 18 files changed, 234 insertions(+), 117 deletions(-)
---
base-commit: 44e7e7f7cffb10a93bb88e7cb59b7b8b3e2deb1c
change-id: 20260608-blackwell-fixes-30c9358c90a0

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

