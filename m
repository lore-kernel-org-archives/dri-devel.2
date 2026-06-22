Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51ACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 05:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6564910E4A1;
	Mon, 22 Jun 2026 05:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLPZrHyw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E9610E4A1;
 Mon, 22 Jun 2026 05:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGRoJcaixYodGtHSZVbBEa+WcBR0OUiyZoW5k47YUuyM5sHn8avdNgAkl8Km8/iaO4s4eQcZvhpMWJ2cnFLmmaaMtNmcBQWgtoz9arBPD8ENCIz85TFIltImqFi6TYc16bp8CJegl5G6G7d/xeqrL1gextHSnj7CC9MRo9JQNkOTZi99NS+PwL02b79ogjBCexcsAr5gfJqAv7xZ6181VkssKUibn+teyXZAf741uodC6ZpIDelKEZ//vKdBbKohKKu7In68YCCwhTJbXGDjrPHyzFZIL79oD9xNLuRS+YnnVjFKkKB/XE36U8u2c5hRhH3HmDmNiuh0eC9eIMOe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxx5znzXA8Onv3cnuDSXTKuGvsAoAfKmZkeSYNDxXxU=;
 b=v2+F4IyU2c0slVoaN1lHOYrjeWBcsYLZ+5pMlVQxBrCi4cMC9qym1aWkXTbv/uQsjv7YHwrimpCHiTaeiDF7OeJmja3QLxXelK2gO6pj8X/858aTPpeGu64h+273YgIRtuSgz/cHk54qSgCVJ+Orwm0Z/cY4qhYqsENKJtJL3CgtEyADK5JLuNxy6Itq9nGqn1bYWNd1HonUFf2EkEEQ5Q215TtsANwx1xHCb/99SxjXpqt9RFlEXgbNiW1iVWBMG/sROpru9p1bGkxVTo7GZfG49PTxtCeeo7Aaa8uS0Ofv0SA9cxXI5+uPIM+FQplac3iZDpsnAuesxUmIFRdRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxx5znzXA8Onv3cnuDSXTKuGvsAoAfKmZkeSYNDxXxU=;
 b=pLPZrHywDQPWtYC+urJ1O0TbDLA/bxSXHSz2wFxZ6I+h6FxNdSdU7s3ecI25VSJMu5s9tDO42EZcvbA2iWsa4XMiOhnEvSR8X9/2FwJ71mmOQxLz+r3blQ0m4nekyng67xFreFWJsdJqGOZ0vxKnpf/BHcUymOQw5x/naSQMClUlDbUNgQGnXjH8e74ltZlBt4a3RGzacVCnxhEiYPXbEXcgRTFJ0F38X2+KClWVQCn4HbeFX+VTCWVLR/zfrKD0vZ4xtty3AdJgULsSpuDwVlm42Ia2I2R5V/N6BVlfirYFOZ45gmT1AdrTDUcBthfZCuQUMv//8qHA/xzu5N72bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Mon, 22 Jun
 2026 05:23:49 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 05:23:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 14:23:45 +0900
Message-Id: <DJFBSI205B62.18DIR7L2OBUN8@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: convert to kernel bitfield macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
 <20260617-nova-bitfield-v1-1-ec10c6772666@nvidia.com>
In-Reply-To: <20260617-nova-bitfield-v1-1-ec10c6772666@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5fe59e-7db4-4fd3-fc99-08ded01e706b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|921020|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: s8XPJannRysVc54TgcxQc8gVeqMok8srXLbStQ16KG2WEnoMwb6+D6RQQZMNSSlzDj+DPRqbF8/8jy4wzxEuDNX522/4hi6LYDD450EVGTvI+wTGfD7Vq4fW5PsLZuR0fEqL3yyAE6gsQ1YkQvVir11bIIdCVD/7B0pgADRJRm3ZakVMJFvOJ1QNZjrIOVGil4/JEdoWUVDCNmjm0ytgl8vkQe60WMPYh3IW2wWMpvlGPUvonZ1RpJMJ4gMb+KnaBy8hPNj+ErfzV0X70W9MRnDMXlQm0NnuOemaO4XN+vfDeqYLNl6TU8ldb2CXXgBhmaCv4c9HFc7AtlLVjM9jig4aVrrMCYaOg5xuCs3VRxMApRbrFUt0maLAXoID5n6RkJ1hHL/AkoVF09/weTbd2xaNukL9nW4E7+AZ+2lcDd10QwCVzEG+SU4cMVNh3qq10FMC+jr6BQYT9Kb2RiOK552SaSoUQa67ye7ukPcmoeenx59dwsoiw0Uuks2uVsirXJTkgKEF265lWWdBbxaDNIkGWqZqKabiTyg1KS2LvQzm6UUVHz1ZfOQyhUU8FbBQU3uqoUM+s9+m+NHTmB29rI5hrY1Yn9C4cbmX1yAHDvsAvSx349pNjTvQp0+LAsmJbGc4pTGYGX7SJEPMC7zORK+9PslodWSgZiiwtO6zCY/xF9a8+qILJNxfQecAuWY1I1+4Km0s7wX9yo9d+Zz5GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NkUHpyZlRodm5iZVc2NmJnanlwN3UwOUFjRG9YZUhXSjJWYmd5WFBlTzJy?=
 =?utf-8?B?RlFNeEsycU9nZXE3blg5cWxGZ0sweFcrWEhlaTU1cm8xZ3hhUGgzWENSenpr?=
 =?utf-8?B?M1hZNVRTc2xZbFc1OWg2MnFTdG0wOU5mNmNnaXdJQlBQMkxQTHFNVTJGSmR0?=
 =?utf-8?B?dnQyTDRkRXY3TmhJM2RjRlBxQzc1eG40aTJZN0JYTTF2LytBMVZPOHI5MVJt?=
 =?utf-8?B?cElmdHVra1AwOXlNandaZUpjcjlDOUJDWVdDOWJWZjNkSm9STWZRUmRFMHdJ?=
 =?utf-8?B?bTV1b3hpNDBPNm1TbDdkNlprVnBKOWRhSjUySlJXMjZUYmZuUE0xOVFkZEJa?=
 =?utf-8?B?cVlDUUtYSFpmRGliQ3lBUGYraStZYnF5ZmpzMktJSlBOWXNzQ1lrdjJ3dldv?=
 =?utf-8?B?aDlOY25CcWtjcHcwSGp6b0R0cmRnd1RQYnI4enY4NTFGQ0dCZUFIQ3E3Q1Zq?=
 =?utf-8?B?SWh6ZGo4OUkyQVFHclJmMGs3L1JmN2F5MmhzWnB0SDZEdTRyOHBDWkliYlM4?=
 =?utf-8?B?eTdBM2hWNFJ3a2o1cGphNzJCN0VHMUQwTzlwTmN0L2hyVmRMd2ZtVmRwUFcy?=
 =?utf-8?B?K3RWR0NJN0pVWC9PMHdSWTNEblNWM3NLV21mUW1yNnZHV05IeTJpZjFSTFJw?=
 =?utf-8?B?bGV3RUYzTzgrZCttWjlORDhmM2ZmVHNRQkU5eU5KVEp3eWxDODJhS0ZGdDJU?=
 =?utf-8?B?WHRPTEZWaXB5Yi9WeThHbWJLM1k5MWFJNkhjQjZJWVFEVlM1VVdEa0JkQ2xo?=
 =?utf-8?B?SGhvbWZWSm9aT3ArZG5wMjJhbUVqYVozblh0VUVqT3BxcGs2TzRPNWZ0bUM4?=
 =?utf-8?B?c0czdUJKYjNlSFAzNC9JSXVma2ZGcUJvZjdYRGYzMGQrbEtNdGE0ajByb1do?=
 =?utf-8?B?alVhUVV0MkFTMmxJUHlFcUlKQkNYY0hWL1g5aStxbk9ndlRHTHYyd0FuZm5j?=
 =?utf-8?B?NXMyMkdjQ1p1bmRjb2c2UHVWREZxOGY3Qzh0WXk2NDI3Y2s4QjJVY053M0ph?=
 =?utf-8?B?Z1BuQTNucnN4R1ZxcVlYdUlmckZNVUtqQnNyUWpQcEh5ZzNRajgrcnQ5VjJo?=
 =?utf-8?B?S3pITmNIdGhJSlpzTXluOEZvVlFtN1hkeThsUmROYXRZYk9DeGd0K3FXa3pH?=
 =?utf-8?B?VnJ1RHliZ01RVWNRN0M2aDBVbFpPTVVFNXVhZzF6N21XVEZDVzE3MmdNOUM3?=
 =?utf-8?B?L0tqQUV3VnIxL05NTmp0cGY0VUYxbnFwdmJBaHRSWEVtTkNyVGhKN3FiaXNj?=
 =?utf-8?B?RnFMbVl2a1B6d2ZHZVFvdlNqSE9hUFBIVUs3WEpnTlpPMFc4L0RpWEVYbVhs?=
 =?utf-8?B?azUrREY3S1RnQ0M3dTY4bkZlS0lyaExvb0JQUFBOTVVKQW1xY01ZMGhUeUZp?=
 =?utf-8?B?cGlPT3RISTRIMDdUODduZVlGYURSUWtKT244ZmVZMGxubllud0g3bUp2MTVZ?=
 =?utf-8?B?dnltVDFhOStsM1NOY0JzaE5tY2VKWXFDVEJTb0VzeEg1R0MrOHgvVGpSMU1K?=
 =?utf-8?B?R2RqZHpKSnhmK2dGK0IwVFVWNkJsL2llVDlMWThBY0dWbDIrUnZsaDRqYjBH?=
 =?utf-8?B?NlVEVko1ZitROFovSlVGSzcySmZ5emdPcVdlU2JFcWZGZlp0QmJHTnNiSytm?=
 =?utf-8?B?a2ZqSWRleXlXcVk4TlFkN21TRFhlWk5zdXIvNHBlT1Z4MkwxVmxldjNOdmdS?=
 =?utf-8?B?SnZlUTY2OU56UG5vNjA2aEZmRk4zQ1RieE5yWlNsclR0MURzZG9EVEk1ME1h?=
 =?utf-8?B?UVFtZnFWYmsxcEVzZXpBdWhGMWJDU0dlMEI4alhZUXRIdEQ2QkkvWFlkZlF0?=
 =?utf-8?B?eDZ4RUVhSXJxY2U0b1FiSlN5ditCaDA2Y09jK25ZeDNyWlVCOG16N1k5SGVi?=
 =?utf-8?B?LzRwMUxPd1pzOEV0ZXQxV1RiYXd3UHozMElYNU1tYzJVU3dsNGV4ZG5keDdE?=
 =?utf-8?B?SU5lTjk4eXNLV0RiQytRMkwrZm1qL1lsUVBza0YyWGVzeDBFSmczM2E5Y2Ru?=
 =?utf-8?B?WC9GU25rTGNzaGNnUVdySExtNmpORFgzNlcrUm4wak1oSkkxcUdSL29LNEk3?=
 =?utf-8?B?a0lVRkRFdENrekZhUlB2VkNxVDVKQUkxWnJYN3IwSFl5ajNHd3UzVlRDTTYw?=
 =?utf-8?B?d08yc3Q1cGVmbmdjbGUyT0tRL09iMUFXOWZqOEdzbDNQdlM0OVFrRkgzd25I?=
 =?utf-8?B?eEVSd0UveDZqL0o4UWVIVmpJNHNSN3ZWKzdDdlZkUXBZUXZiNWt3a2lyV2p6?=
 =?utf-8?B?b2g1OUxXUXZzckE0Q1dnQ2xKMFFuNGNMd2pTSEhabStreVhCbC9vNGVHYkdO?=
 =?utf-8?B?Vm9XeFdLbnJEMzl6cGFlemg0SWM0KzJkS0lNTzBzVzhzeEdoMXJ2RStMRG9E?=
 =?utf-8?Q?DW4Rnej/Q8yu0kEEFfuIcuIQ/atHJoqOAL6MI3Wlmh8Lc?=
X-MS-Exchange-AntiSpam-MessageData-1: CyZLDbm0By1U9w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fe59e-7db4-4fd3-fc99-08ded01e706b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 05:23:48.8614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIeNzGM/X9GihphZ2Wr7tQng5jOYnq4lq8LPDGZBK9AOBYZkwKF/HWd9yJiW1b29u5lnS3VPqpvrFfczMDjxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168
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

On Wed Jun 17, 2026 at 11:02 PM JST, Alexandre Courbot wrote:
> Replace uses of the Nova-local `bitfield!` macro with the kernel one.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> ---

Modulo the comment raised by sashiko about skipping the log on error,

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
