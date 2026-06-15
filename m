Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30420CD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB4110E48B;
	Mon, 15 Jun 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HN/xjk9X";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E5E10E48B
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa2HErX5tQeNeu8rOeafejvw9j4ZGGNRrP/LTA0iSQAWkACtlsUDkRKPBE+WUU2A5qKRZBBYECiHmLw1qcjacl08sU8Ik3kjQrh0MyK4rnCUA+ODqaGMEfBW1ctz8rO8Le1ZQHHw7JCo3XC0xDfRM3pGCsCi5SDTfqw8HsXcHRcuGheN7wwpIi1C7GDylvmSbEp1jaW2/o8fk4gVVGowDvnxU7pqCQiICSKDu5qOc96+QvaRvHbm4hGRdEkrYQE5lt/v6i6UKCmrS516qUg1f9kTp1s/d+mqCfUNZmB9dbnz+eufHlMVClTVnhesFTsWx7ZiaK2h5cES7SBBdDBXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzNJ6ar9d/V1Uyl3l+MjPH+FtmoIl07LdZQ3AbVAbDA=;
 b=NkbXLlycJEP8HbLRAlcrntfjsRbfST+O6zY6sIN9xPKRWx438gjyufUQUkJtI8lajhWm8eLzyIJPHJ4dF9emfosEWqXCpxi2N6T3jOTa2Myxy8bJbRereeJMETHGqLsIMkQIqg6mxGizWP1DfkeJPEPNzxDe6iOrsc0O7Vz/nfV89+hoDwu74vu1izfQBZJF4S5L7jwepTaJnL63+5KRNxPQMtTxBOw1XOdvnjwUguXkQElzG8Rfk9EKtEbP0TFtO99RcLSBCLFBBhv+eJ932SgW4k/WZWj1Q6HCYBRnKH9UOLF6LazGT/7SHF0TSSW5JYgcLFe7hoSCJnA5A2pmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzNJ6ar9d/V1Uyl3l+MjPH+FtmoIl07LdZQ3AbVAbDA=;
 b=HN/xjk9X6/V9rHeeN7vRomuRwbw36hCuxVGE8830YmSIQO8cnfFFwdoENILSOPR3uiYkf6nnx3aTmlSUJe6Sj1XVb4EhRP8r4Z2TysxzFmHdOTApR12sQMBoTDHo3dwn9gOGp7xZFg1vCnq1YI7rL3dLqDVYKIl82eBQweHqZWdJrFZXEjLhMbWt17jO52tH24M5+Yy+Rx2ijfhG+grUltp2Awc4hrPOYu4HbyOtyupD/Ql63O9RT2g9WSeKEgruDsWnolJVTFPq44MF0D8mTTDnSwzfLMSIh+6m1xVHiOVbx/kCadsgKxtZJxV3z6imB1yJVGbLdU1BlGXpgf+Q5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:41:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:28 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 00/13] gpu: nova-core: blackwell follow-ups and fixes
Date: Mon, 15 Jun 2026 23:40:40 +0900
Message-Id: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqEMAyF4VeRrC1Ei6K+irioMc5kpqg0zgXEd
 7fq8uPwnw2Ug7BCk2wQ+Csq8xSRpQnQ000PNjJEQ455iSVWpveO3j/23ozyZzUWqbZFRTU6hFg
 tga8hRm13Wz/9i2k9b2DfDyrX0VZzAAAA
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
X-ClientProxiedBy: TY4PR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2af109-4d6b-44cf-ca31-08decaec2f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ueKIzzBjbsSFy1Xn0JpiV7C+7PEX0gWz9v/oBpStK+QNjCUitYRUtXUY9XoyQrGV2M4uHDV1MJ2N3c2rU9hcerUu7qB1n/3cYJFclEEyBlNEDKWq9XAebVAnfm9SieuQiP/AewEzM8YqIziJ0rBAXeeE9OHodoV/9tDGuOHAX1BLkQkPSZCcz6rcYki8pZstqcLfphGpSlZkvpI04fFIH7epZ1HXPc1MioSvSSs40lzGDYc1Lp0f6jSZGr47wrF0KJ3eL7To3qEr7d0xZ2vEhIYO7cxJAd8XVl73HtX3PyXX90+LnZhEYwDHfDZ5s3x/6yaSetg6/x5s+0QBh9EbkwdiGgqVkTdnhwI9mVZy6D6T8x37nsH7ijtQblY9TeXO0/kNQ6t9Aj7LuE1KFWknqZexbFI3K7CasdPmTct94gMFUBpgcjn8k4NntewiKZ8NsgCXrwXP02lTjh6lXjv3dK3QAnClcuw/kaHOKocD5rQBvUpHS3DrBppC5NmCEaPqLy/gpv7wM2b6Sj/jvWhI/HQCUCwIHkRXsE/2RdNLaFeh05NqbHp+rvGe/BwmnXh/OyFwcKO6n3MAmdX8sCA3jXWR1SVWpgRVlMdF4xo8hAXAkRM3/OiHvbVnnlwjm+0az/xe44x335z8rxhBbINL7jenH+XI9JmePxmmyOFUj9X4dts1dPJt8cKKPffFMNwj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZQY0kxQkVvaXpuNVZ3Yis3eWhDWC85ZWd3M2xiTVpSRk5QTEZCMWJnRUo2?=
 =?utf-8?B?UEppUm0xWmlzYXBBQllhREVmTk13NTdBMHQ0RjJjZUtya1lvd2N5czJxSENE?=
 =?utf-8?B?UHhJL2RqYW84dm1QUXVpeWxzTFNIdG8vRSt3WldHSnY5M2J2Y1JJbFFPYTE2?=
 =?utf-8?B?Uy9YRUVnbStIZWVWZ1Z2Wk9tWHlXZHJRZTJqTmtYNkpiNzZoYmVDY3FJYysz?=
 =?utf-8?B?dGJKWFVPVHNyWE9YYXdlMkE1NkR3UGVlclR6enZ3a0Fxc1RJTEhYQXZNOTZQ?=
 =?utf-8?B?VXZDa0MxNFdHKzg0c0JJcnNQL2cxYkpLNWJUNGJJSFVxeExpQTRxZnhjMzFP?=
 =?utf-8?B?RnNTbHFWa0dUTXpuRUE1b1hGZ1pkSnl5a3ZsUGRMZ1BETHcwdDh6dVFvYzNa?=
 =?utf-8?B?WU9RMzFwT3Jucmg2Wnh6WWpPaFpLeXVqa28xWWY3dlJXbGs2bzFOZ1R6WnRa?=
 =?utf-8?B?cWNQUUU1N3ErbUdnNy84RFlWUEgrSFR4NkJkMm9uYUpjcjhmbFNoQXdIcnk0?=
 =?utf-8?B?NXVKSmV6aS9kajd5dTByRldnSEFaS2FCOXh4ZWtmUmxjdGtpVm80QkJ2RFJO?=
 =?utf-8?B?bjl1VlROV055YUc2bjdITXlkbTVFZno0U0JrdTdCdFoyL2RCUUFHK0tPaWcz?=
 =?utf-8?B?cEVwOXArejRPL1FLNGEvTlM4OTRlRFZ1QW40dHdtbXRoc3lvdkw1R3JrMnlt?=
 =?utf-8?B?TGVRd0VRNzU1OFdIa0ttU3JrRmd6UTVldWFRd01ESndrdjRMcVlCWVNYL0c1?=
 =?utf-8?B?cDFORDI4REtrZWY2dG14aWppZm84VDR5NDg0TktTZG5pME9MWVRCU0pCUE8y?=
 =?utf-8?B?U3FBU0UvREhWNWY3Zmh5QmtjaWdOMXgwekJQSEdSSUJIT3MwOCsxS2pmb3hL?=
 =?utf-8?B?d2laVS93Tzd5aEwxaEcxYzVXalNWbWoxN1NodUY1b1Rmb1JsZCtyclpCMkd2?=
 =?utf-8?B?YUVMMmFCMURTM3cyWlZZMGIwajlRd2treTR4eS9CbEVrTlpWck9ybDVSaFk3?=
 =?utf-8?B?V3RnUGdmSXRhWFc3eUtJNVFrS0lWVk1nQkVWNTdkeUNCeENVSVJRYmQySHhN?=
 =?utf-8?B?bTFvTDFrUldrR3R2b3hKdDNVK0IrbFgyeWEyTWJ4V0JFL0EvcVA0bVppNkZo?=
 =?utf-8?B?RXplM3BjWWRzN1cwcU5JUWRRbTFBSzNMYkNRU3VaUDJ5aXgxSGpRNGp6NjBy?=
 =?utf-8?B?ODJPOUVRQlZKVmQ1MmkwaWpPbWVrRFd0R1RCWGc4dFhPQTZsL3BuQWFEZTQx?=
 =?utf-8?B?eFFNNnM1U1JHcmpJVzE0M2wzZVlYUFBsMS9ENmY4YUZ3RHZHZExSaVhkanVP?=
 =?utf-8?B?eFlPd0FITkpubjFrYlk2VlJZMW5PTHNQalJSQUVxMHNTRmFnZjMxNzY0VDZO?=
 =?utf-8?B?dlNMejMvRHlMU1JPZmZMV01JZ0N1VGYzTko3QVljV1NWNmpNL0htckFMR3I4?=
 =?utf-8?B?RzZYb2RhbnVaOGc3QTg1RzluSmN1WldkdVlGZDdQMVhrYWtpalVQV1ZnZmIr?=
 =?utf-8?B?emUzcVNpSUhicnZDU3pWeDlIdUI4U1BNNmxMd1FQUDJ4VWlOMWQ3cy9RcEk2?=
 =?utf-8?B?eXQ4OGIrUGN6WTBzR2YvQzR2NS9ybjJzMk5EaVJUWlFlQ2ZUZkN3emx5MkpS?=
 =?utf-8?B?TVhFTXRrMzYvN1k2aDFpUUYzMTIzRllUWDhscG1LcnM0Sml4Q0VEUk9mMUJh?=
 =?utf-8?B?RHNibTEyd2NyQTRvN2hiQnkzc0FGTUVMbk1yWHhlV0xaL1BZY3VYV1JoTlRy?=
 =?utf-8?B?SENLcVhUYThDd3oyY3pMSWFZcVZJTmI3ZXczbWhvaURhWU5EVS8rUTRIVG1P?=
 =?utf-8?B?MldOQmU5SkE3Tyt1UjVmQjNBRVNBSE9TQ0daY3FyWHFsS1JSWEJia0JkVHdB?=
 =?utf-8?B?SU9hWVFibnB0Mk9CQ0RMMkQ1eDJ5YnNNTk1pWXRUSld6MUk3Vngwc25obERy?=
 =?utf-8?B?NG9zOWtCaVQwZHdLQ3NWMFIrMGdnWXZaQWdqT1Z0OU5BQnB5dUhJV0toVGp5?=
 =?utf-8?B?UTNMWksrd2lMcG9FV3ZJUmQzZmJOOGQwSysxYnByNGdkdXBrVTlDTm1GNktF?=
 =?utf-8?B?bU1FdEJGdmx2Z0pkdi9rVkt1S0VsTENNQXlDaXJkU0FQQ3V0Qy93Wk9PQmts?=
 =?utf-8?B?VFJMM0pDRUxYNHl2a2ozdG5ybHB5WW81ZWp6SUdTN0g4M21oMi9OSUFibm5n?=
 =?utf-8?B?V3E2SGN1SERrNFVuQWJDR2NLNUhEeUl2NUJQRU1XNXVUayt6elE0aUZiYmty?=
 =?utf-8?B?c0FaNnZvSklLak1TeVAxZ0VSMXdDNDk4azgrN1pvUWZ4emMvZEZYQzlsVE1S?=
 =?utf-8?B?ZG8yd1B4ZFE0ZW5QVVRHZzM2QXVzQW40OW9lTE5hNzk0di90YjFJbTVpdGRI?=
 =?utf-8?Q?T+8zxr68LZlNR+MCpWJSXFuRqg2zWWhQMatQiWZBvsCwo?=
X-MS-Exchange-AntiSpam-MessageData-1: nI0YAPu1aV0iuA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2af109-4d6b-44cf-ca31-08decaec2f17
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:28.6373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGVz/e3d7RNa0ALIA2rN++WGlvCCzinsWhP0RoJ0RzXEWPa8binctJYcXeW6Z2zO9Jfp/CqnFMm+f4y/uqKZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

Several fixes and clean-ups for blackwell related functionality. In
particular:

- FSP communication hardening
- Fix for Coherent allocation lifetime issues during FMC boot
- Convert some raw DMA handle stores into &Coherent stores to help
  prevent future issues with the allocation not staying alive long
  enough
- Move wait for FSP boot earlier - AFAICT, it's not valid to access
  certain registers before this is done.
- Make FbLayout code more obvious and correct
  Currently, the frts vidmem  offset is calculated based on the non-wpr
  heap size and pmu reservation size, but AFAICT this is not right. The
  fb layout actually looks like:
  | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
  It's just by coincidence + generous alignment that the values happened
  to match with something more like pmu reserved size + vga workspace.

  Originally, I thought it would make sense to use the offset of
  FbLayout::frts to compute frts vidmem offset, but actually the offsets
  in FbLayout AFAICT don't make sense on post-FSP.

  `FbLayout` is used for both pre and post FSP architectures. FbLayout
  contains ranges for each region of framebuffer, but on post FSP
  architectures, only the size is actually used by GSP. The offsets are
  not decided by the driver. So, for post FSP architectures FbLayout
  contains essentially guesses for the offsets. Instead, make separate
  types so that we only store the information that's actually needed.
  This includes the actual reserved size after the pmu reservation so we
  can properly compute the frts offset.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (13):
      gpu: nova-core: fsp: limit FSP receive message allocation size
      gpu: nova-core: fsp: catch bogus queue pointer issues
      gpu: nova-core: fsp: try to enforce exclusive access to FSP channel
      gpu: nova-core: falcon: gsp: move PRIV target mask constants
      gpu: nova-core: gsp: keep FMC boot params DMA region alive during error
      gpu: nova-core: fsp: move FMC firmware loading into wait_secure_boot
      gpu: nova-core: gsp: ensure lifetime for FMC boot DMA allocations
      gpu: nova-core: gsp: ensure LibOS DMA allocation lives long enough
      gpu: nova-core: wait for FSP boot earlier
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs

 drivers/gpu/nova-core/falcon/fsp.rs    |  70 ++++++++++++++-----
 drivers/gpu/nova-core/falcon/gsp.rs    |  11 +--
 drivers/gpu/nova-core/fb.rs            |  83 +++++++++++++++++++----
 drivers/gpu/nova-core/fb/hal.rs        |   5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs  |   6 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs  |   6 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs  |   9 ++-
 drivers/gpu/nova-core/fb/hal/gb202.rs  |   9 ++-
 drivers/gpu/nova-core/fb/hal/gh100.rs  |   8 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs  |  14 +++-
 drivers/gpu/nova-core/fsp.rs           | 119 ++++++++++++++++++---------------
 drivers/gpu/nova-core/fsp/hal.rs       |   4 +-
 drivers/gpu/nova-core/fsp/hal/gb100.rs |   4 +-
 drivers/gpu/nova-core/fsp/hal/gb202.rs |   4 +-
 drivers/gpu/nova-core/fsp/hal/gh100.rs |  10 +--
 drivers/gpu/nova-core/gpu.rs           |   7 +-
 drivers/gpu/nova-core/gpu/hal.rs       |   6 +-
 drivers/gpu/nova-core/gpu/hal/gh100.rs |  10 ++-
 drivers/gpu/nova-core/gpu/hal/tu102.rs |   3 +-
 drivers/gpu/nova-core/gsp.rs           |   8 +--
 drivers/gpu/nova-core/gsp/boot.rs      |  10 +--
 drivers/gpu/nova-core/gsp/fw.rs        |  95 ++++++++++++++++++++------
 drivers/gpu/nova-core/gsp/hal.rs       |   4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  39 +++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  26 ++++---
 drivers/gpu/nova-core/gsp/sequencer.rs |  18 +++--
 26 files changed, 396 insertions(+), 192 deletions(-)
---
base-commit: 5f7410aa26524101d34b627fbe16670b1514962c
change-id: 20260608-blackwell-fixes-30c9358c90a0

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

