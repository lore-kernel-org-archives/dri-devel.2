Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC12CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8610F289;
	Thu, 28 May 2026 14:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iZwR0Tfh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F13310F289
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHnM0LGgfqq7hamNFw7JqiZT0NVwPwPCjU2bTgbJYTdK4lkL69PkHzsigGYz9t2UIlCtNVCuFuKPeBzjCnsczEK6oZswIX257YZUs7Vx7swnF1A1k2KUHFc0TFs/xsJTUrMoitDOxErKSkqYBenvv8we5ri2oJQjIknmUr2haPJqq2FMocK/FN8wiQj5VbzmCrJ4gKg/qT7P9ht5G7Cm5s9p5UyvJJpPZzS/vKOxd98+ji8WYzKFFurkJTXgEQXJwWuEzIKhyBvhdbTF1RIdMMllWfq8qP4TCU9mkoheabF2oexk2bLvvNHT27oinKMvxazEdCsmJ7NDOS626gPQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Y+nNzbPBuWeMiSLqjDAOGJm8jlS9R7Rl0y+LKZhFE=;
 b=Hyy3a1JGW2DxlljOQjibXwZ58Sy8FBP7zREbbkNSnlDBssF17JFH12T3RNUVTIDftK/Q8uwT5EsU35hSCcURVygRJ4b6+wSpcqbuF16K/tABIKgi57KZrGRc3Yau3zmfDoD3Zp+iSGX9VL3OEqWi5vnNTxczYkoc7Mv3wK6QBmrq6DfJm1bZjnAwGbH5lIgpvSmao064ueuTVOjN516LklWgxcagBYybhmPgcgtB6FsZUFiIxR+hZe0CHBSqHfcYslo/+hfxEMEtV/1lMftzPZTITDrdHvHo/M/C6ysjJpfu+CR0YVJ7xkNgxZ0gXO0zI/H31aKYOcnteL0+/n5HwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Y+nNzbPBuWeMiSLqjDAOGJm8jlS9R7Rl0y+LKZhFE=;
 b=iZwR0TfhXUD9/6cHy7VVwpBZ9cFvt0TE2LXferSUCIdpiHHGZFEBN66Nm7/l9ZVhbg0MpX6M6YG12Ybe8ZQ54IjH+qkODjD1AjETEb/T8CSfWcfPVF4Wq9ipI7EUvtv5ZKzRDx4Sw5zjXOIvC13cyqUqYwAr9+uknZJTcm6/fzAyp5d2ZwsaMFOKQCE72IfR2cOwx/umRYmnY96wwjlflRKOpABDjWDwj2puKjnnZNzzGkXNEsz+u8ou5l489b394PGmDoFKH/XBtwTiybmytUIkW6LEHhHhJ/JdiZyXqVlH4XCC+oWFPLzqr+DTFvZ+qCA8GlCWPJBkoVLIvecY1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:25:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 14:25:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 23:25:07 +0900
Message-Id: <DIUDNDWW79P6.3S10C21ZQMBLX@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/7] pin_init: always inline the #ident and
 #project_ident methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
 <20260527-nova-exports-v2-2-06de4c556d55@nvidia.com>
 <DITND8OO1D7K.2694AAY23IQVT@garyguo.net>
In-Reply-To: <DITND8OO1D7K.2694AAY23IQVT@garyguo.net>
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: dd23c44c-fbd8-4848-0a4a-08debcc4ed27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JSUtCrCFqySY7SLgIUZ27dpSTNWsDlWixZeA6MU/4ACbNT6aGATmy+5QaZ8PFeSTpsPG0Irj0dij3G2/kyj58K0ugF7Rf6vCjJ95tJeOtZ6aJdsRf+xanmGR7uLZnSDXdhiss5GIBWrs5ZxjT+hTjspHB0i1tYJJVqe5aqfG11LafkIwKgWKIrJ+udHAI+AuoFPpRXgVoDspXHjcMLA4H1VyWzQiEhNTOEnBSvIcVJiNz3B3mWFhFYAKjskhVpwjA1A6EP4+WckyKHCeOJ1oz9TmV0AhFh8hTSjcHA4M8bq7HaQTOP389UYkpXVwvjZ2EbPuHgdgOP86/5EGt/lnOGfegngzZYQQ2O6oaPLxmOGaFMeKdvY5oZK02oUVAUhOTj5AXq1DPBoyBsx1IB1OJiYQs1fju9XTbx6cIsM1wueWOioiDIWuItDg6j5TDShBzkMdvluVDkiQAxLpli3G5DXJyKk/LOzuALimnkxxM0+sScolHDcTZriTPydM7absu2AAirRdahRUk9SLwVpIX7S0ys5OSbD2mD1Rs/0NvM5h9C35bU/1qbFQ+q0zq9D5stnTl0EYe16pZaTrefpu4Q0Mxr/ajfDwow6QuN/eObcKFs9QZJFuSCAX4bMJHGBEHC/nQ0eQ6wK/2tLEncH6QW0F/1uJspBGo/IWqhx/XAFS4KqTjFD4nFLL7798D9d7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVIvbmRvNXlCOVZZQk1rZUJ2UUJTNFpocW9WNDVNMC9FR1lOVzZ4bnczMFo2?=
 =?utf-8?B?Ym5CSUdSaTRYZHdBWTR5YlR4OHlWVEVZREc4TXBvOGVldjJGaG81N2ZIbnNj?=
 =?utf-8?B?Z3N3dzRKaEN5UnQrVExPbER4bno3Y3REMk00SUcvQTJZS29KMCtYU1hoM2V0?=
 =?utf-8?B?SVhDemwveEdZNklzWENBOEN5Q3NyNE9IUEZVTDh0T1Y1d2dpZmhRSWpjTDBm?=
 =?utf-8?B?UHlyNDFzWGxjVENWTHNFRC9LQ0g0N1VYZy8zT1hCZ1J6SGhNOC94VXZucXdQ?=
 =?utf-8?B?MDFJcmRuUWhNb3BTaFN0K2dNU2VJdTRHM0hzeXZ1dzJMMGtzcHErVDlaOGJT?=
 =?utf-8?B?VlU1UGk3VWhlVWRrRjhERktyNkZUdVlGREVWaG16SHpjb08zMmdibk5PRjkw?=
 =?utf-8?B?MGVYVjBGenRLRHZwbGdnejZhVEpMNHo5d2J5eUtPQUh0eWdMdGNBOWJkL3Ey?=
 =?utf-8?B?bGg2b3hKVUZoUXRlWnhOSjl0WG1Vdyt6UCtwYTBYdnRBUDY0UU8xUGJVUGpx?=
 =?utf-8?B?M0JTaVIzM004OUhuK0NhMlo3M3dYOURtM3FhM1pRYlB1WmZjVHRzck4wS1Jn?=
 =?utf-8?B?VUVUbWVQUFFRSFFFQU9YdzY4QU5LbDVsT0pISW1OcjlrUUMxc1VkT2N3em1j?=
 =?utf-8?B?Vzc2MUtzZkVFVVo5YmM3QlJPUDZEWTAwRlZNMk11ZUIwU0I4TFo0NVJPTlBy?=
 =?utf-8?B?SlRRVVkxRmJ6NkkrQUdNSU5LZU1kTnBwbGM1dWFGUEdvZlJYaHRmemZVbFNq?=
 =?utf-8?B?VXFDaG1aUk5NQ2VaK3FqRHpjbVRZdlJBblZtTkhMTWpDUGswNXlzY0dzM3FS?=
 =?utf-8?B?ZWtUR2wxVHNZSUdoRXpYYlI1eGw4alpneit3WC91ZGEyUEpsa0N1dUVZMWZk?=
 =?utf-8?B?OVNubTlGVFJtK2tCN1lidHhDZnYzaTNPUVd6SjVkYjRsbHI3NksxS2ZpYlIx?=
 =?utf-8?B?ZzJ4bi80WENOL3ZVY2dMVmxqa0N6V0xKT1dXSERtaTJhRUVPZ0FkNkNvd2Rj?=
 =?utf-8?B?MWU1eWlsdDNxbmxXU0RkYkNNVjdhdlFHd251V3JQN0tsYmd5NjlCVWNBTmx3?=
 =?utf-8?B?MmdQU25UYzM0TG5paDNxSkZaM2dQakNJTFpQS0hiWDg1WVVRR3IwZ3MzVUVa?=
 =?utf-8?B?R04zSXpXVytRcldyQmh4eUZWakJsb2Frc1FwM0VlREM5elNuZ3hQZGd6d2No?=
 =?utf-8?B?M0tYaGk2WWR2a3duMFR0bWFUWklKQmVQSnZzTVUycEhnRnBWQ3FVbFlZMnQ4?=
 =?utf-8?B?YmNsWmYrNzE5YXJFMFJlSEozV2dkN0VEc1pldjBFNnVES3BSeWV0TnJIZkJ0?=
 =?utf-8?B?NndwR3d6K0RWdkhMNlNGa1RFMkhhejZweUJIU3NicUxmWkY3M1hmQldjQW9m?=
 =?utf-8?B?M2FOMk5uU1kybTVDejZLOGtOd0s4aHVXT0QxYTB4MlZmd1U2Z041SlpWbXM1?=
 =?utf-8?B?ZkhiQ0FxUFBuVHoySElRYjUvYnpXQmxlS1RKZGtHTCtaMCt0QWI5V2w1UElN?=
 =?utf-8?B?SG9kSy90djJ1S1RQUG82RHRBVk8wcXU4czArb05wSmVrT094WFNiRXhlMU1v?=
 =?utf-8?B?VHhRaWRLOTN5YXFVUE5KU1MvYjlQMnhLbTlUTVBGVk16YzBZQ2RmbE5hQzRz?=
 =?utf-8?B?bzRNY2pUTXRzbmluZTBmM3NBaWh0K2xwYjF6R0hhbUJ4M0JTSnhVSmk1amcy?=
 =?utf-8?B?YTVTcnhwcnRKNzBqWVd2aVJzVlFXRlk2dW5QMFczMDliY0NWbjg2QWpuR3FG?=
 =?utf-8?B?T1piWGc5a2JDUWV3ODNKOGQ0M1d4Z2w4SG5hL29SZmFoU3hoUVJNbk9ibGFQ?=
 =?utf-8?B?Q3Q4b0s2MEpKblBxcitDM0xTZlJIZkF4d21PNDhCanFOSktPOXJnZksyY0Ey?=
 =?utf-8?B?M3h2b25jVTFBdVJybkY3MTlYSm81enRNa1RrZUZscVI2NUpBemlXSkN5WHNk?=
 =?utf-8?B?SGJOTmQxa3pWbitld3NkRDdiUk5CWjBzTFdCQ295clhiM084TUhSaTJqOEZ6?=
 =?utf-8?B?cmNNY1JPNjVFR0dhaDlJU1haZHEyL3JzS0xQT1JxT1NVWktWd1JvVTNJZ1RX?=
 =?utf-8?B?UDY0Q0gzZFpKRWNVTnJDeU1tRGp0R05kTndGcVhvU3hWRDB0KytNTitiSGVX?=
 =?utf-8?B?bEtPd1lXcTg0d3I2cEFiZlUxMkR3ZFVzMy9uLzU0QWx4RmFGTy9PcGxrSlJP?=
 =?utf-8?B?NXFvR0haZXl5aEVtd24zS1ZKbzEzempjK1ZWOW9ZdXdibEJibE9QcE1OWnla?=
 =?utf-8?B?YjBLcGcxdzQwd2RRbVB0MjZ1T0h4YzdCUStUSUU4MjAvWDI5MU9OdzM3RmFI?=
 =?utf-8?B?YnZFM0k1aGxHWVJsUlQ2ZnlscXd6UXNGSFNSOStETWR4LzFVMkJGK1p1YXBw?=
 =?utf-8?Q?iO4BkhEwiyJrq26x8KntT6b6feGCb/5E9p2c7K5MfvzeK?=
X-MS-Exchange-AntiSpam-MessageData-1: +z7PvkQbQEU7tQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd23c44c-fbd8-4848-0a4a-08debcc4ed27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:25:11.5102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU1Bs1XyLDcRV8BkBbHzGq6s0GewFBVSfA8/epdB2G+p6gblmLQ8W3HTB+WvsUxQpQR8/FTCPg0T0BQ3ESr3BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

On Thu May 28, 2026 at 2:49 AM JST, Gary Guo wrote:
> On Wed May 27, 2026 at 12:52 PM BST, Alexandre Courbot wrote:
>> These methods should always be inlined for optimization reasons. Failure
>> to do so can also produce symbol names larger than what `modpost`
>> supports.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/pin-init/internal/src/pin_data.rs | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/inte=
rnal/src/pin_data.rs
>> index 7d871236b49c..945254740f61 100644
>> --- a/rust/pin-init/internal/src/pin_data.rs
>> +++ b/rust/pin-init/internal/src/pin_data.rs
>> @@ -395,6 +395,7 @@ fn handle_field(
>>              ///   to deallocate.
>>              #pin_safety
>>              #(#attrs)*
>> +            #[inline(always)]
>>              #vis unsafe fn #ident<E>(
>>                  self,
>>                  slot: *mut #ty,
>> @@ -409,6 +410,7 @@ fn handle_field(
>>              ///
>>              #[doc =3D #slot_safety]
>>              #(#attrs)*
>> +            #[inline(always)]
>>              #vis unsafe fn #project_ident<'__slot>(
>>                  self,
>>                  slot: &'__slot mut #ty,
>
> This code doesn't exist anymore on pin-init-next.

Ack, and actually it turns out these inlines are not strictly necessary
anyway, so I will just drop this patch.
