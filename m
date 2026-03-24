Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D1BF54AC6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBABC10E6FD;
	Tue, 24 Mar 2026 14:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmRNj8t9";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A8D10E6FD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 14:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+0KmnLWK/cId8qeAG4yLh72/NHetqr58mypR1JxFyUTrJR3L7cD0SfEHrBqwYrdDwyJFGsx2KLC9XoQwhEXbXD6tC4B3sTUO1SB2fUf0fF15v5FUTilasJ+c0CiXi4U8DsLJKpdzK7Z0o8xFU/IkUQJ5Y8bfyIRLDAh9/msGQuzdmxhzzEpeSHUJNcMx/N6Xue74994e4+IT2909I6gT0ScVRPSBe71xr2sN0vtH+2U+SzgNsqqiHOLPLruH8gmaAMLC4iL86KTBRzOeoMYeVBwt+ChQmdDTqOkzoqq4+3FJTBrd9vo0KJR705zU8urGCXpRokZ3QLU/aOMQNTqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHnWce7lg2TtrlLj9leQdhu1LkboSyJ+gomV7i6xXeM=;
 b=y01OJkE0AQoYWtP1Aaj+g6kWyLnztxjkIkso7cA/ffj9diogCICzTurgj7DiMapjXkqFGLDOSnizjhpiYWuJi0AWGjPt31sMMnUiE1v+purnl1WlQT5H4Gw84ZAKsNu4HWKbLiUAcKbIMI/7+vm9Vj7sPc/DsHEMh/9IcKx5CE463jA75JsJcmDJo49MS20MO7Ykn6NEWHSNcOhplWBit2JL8QW4Cg6jMyArv3PIX3XwiMt/Vbaj/yQQacrHzUmO4cONOgcl71Sk2aEMMdGYLo+vSRgZUZHeD5x8P+exOq5g6kcms+B6KUCFM3/aomlYEYtV8UxLgGsXp/cmoVOftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHnWce7lg2TtrlLj9leQdhu1LkboSyJ+gomV7i6xXeM=;
 b=qmRNj8t9JLDF7Kl6v9zoJkyL74UyPzVpjUa1aW2L5/sWhK9CywR3YnH02uNyT44U4NdQzcVCo+WcgtskkXvvQkfmVMzEf24dLkb1VkCdoMHmDLrSpwLrXsnyFTsYxPQzeIJ3Lo8d5FCYcrVIYcNCpywr+MKU+3PPDfWQeD1u0+bGMFsJolYyBOHqWvrrNDV/IYuIh+9SY5ncnvIbkdqA3tIyZfzv/u8s6q0IZC/p2m/AZXQQpkROVQmSRzd4kCX4F0GD2OpDJEXJbUa2fkh49d7VoBwcxudNEiXEm8wC7hfBdZ32RKM8NmphMdq6uioKwWU/VeBL/zM4ziGnSijBOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:44:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 14:44:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 23:44:03 +0900
Message-Id: <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
In-Reply-To: <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
X-ClientProxiedBy: OSAPR01CA0253.jpnprd01.prod.outlook.com
 (2603:1096:604:29::25) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: f774583b-ca73-47a2-87d3-08de89b3cd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vH/TqDjpM9C+PhUxR36WoRFFODBWg9lw0hvH5276UBVl7lknsHGANqG1m/bC6RON4Z8DSh3T2f4TRawubwL75Zu3eCWu3z0SXhIxNlSE8ji0R9+osyfRTdbNc0eFs0dmrEAjK28KD2ft8shnCVof+9E5f5KI8F8+OWGToQS23eNQMHyoDgPfzT13XDUD9DJQh4LN4A1+wAXvOzeDowZ2V1kuMvHw0RHQ1S7o2Z1km7fUXd9KFwhNVOgC7It7atusuBEwof/7xlmSSMtQ5n3sZLrmW+0wHtAFDbObEj4v3p1jyX6lwrQhPxJcFvd+MTuq/8QSx/3YYa6KixiAWSY9g608hbUZg/DND59x3FfHvBygYyVNXZNxnsHOEdjarsL/JKcaY09m2E/eXzBzJkkPiO+x9dZ2CoN4HvEWTr93WTwwGg6Nrzs1VQ4oFSugpseKHdkU3pp8LwdCw+9u90X0wTp3PNP+Cft7nHt97b7zWqO9KvuUCzNZcroJfFsZrJT1Fzf4osMBdJNTKnYb3KZglHa9Mwfu3h5S9Ai19yCP7tPZiKhnV74IRiE4SlucOSEmxhT8AOG/jvGI/MfV9NodiBBKwqs98wn2yX4RrZO2gRzofL6QtnVCLAHVqBnr18KjUZkYGF2sT0P/NAm9a/IISc3zIuUyPyJgoGfllRgfbTeMBsysTG5d6MRaekq5wX0vL/JHZdixV2BvXy16m3z2Mp9sqD8ORnn4LdaHCcIbxzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNEVnlic09kbnp6SUNYTkhyUHdSVWJJMmtFYXFlS3M1SitHVWNHYXpmVG9q?=
 =?utf-8?B?eFhTTVZONzBjdGNyM0tWaDhKa2tNeU9UZFZkUWR0MTkvbW5sZC9nekNQdHpW?=
 =?utf-8?B?TU1CWTJOM2Y5b2h4YWQyRjlFWlJ0eVBGU21lZVJtVG5JdmswYU9wYnB0MXc0?=
 =?utf-8?B?NTdxWHc5R2piRlQ0aGRWMlBqSDAybWhoWVFXdktTamNPT2VmZmRJVnlmdXFr?=
 =?utf-8?B?TlBudEtYQXN3Y2NiVmJlRThhQXR1b2pxZEx4bStuY0xzV21XV3c4ckNRcitB?=
 =?utf-8?B?UW5FMWRCRzdGdnAycEdDalRqMC9icHNiY0tzUEw5ZjZtZDBzNmRzU3dDMDZi?=
 =?utf-8?B?NGlvMkRLRHpna3UxcTZRNFI3WHJybzdKb3NwV1liNTlVckVtYmh0NzI5VCtT?=
 =?utf-8?B?a2tJSDZzalhsYWoxR1B6NUU2WHV0N2hiVmVDWkplWGVEQ0RnQW9sN1puN2gw?=
 =?utf-8?B?czlKM1dzUlFwaWQzaG5DMFZwLzlQbjdQdXZIaFV5ck1vbkQrcm1KcHNuV2d5?=
 =?utf-8?B?NTlFSDhHWUZsbXE5WldCaFlCNW5XWXEzZ3l5OEdXRHRZSUZVdFd3NUkycGpy?=
 =?utf-8?B?aTBCT2Y0MDJ4dUJUNTRMRlVUem5XWjB0V0lUbVBUakFDWVhGU08vYnZsK1Nl?=
 =?utf-8?B?aVFGTzkyMTcrcXBNY0FMN2RSWE9JQ0VTOEtueXpacU5qYlpHNGx4NDdWQ3o2?=
 =?utf-8?B?Q0JQZndWTWdyQi91TE1Pam5ub2FVcVpoMXQ5bm9LOU1sQWlTKzRqdXhyVjRS?=
 =?utf-8?B?aE1Lcy9tcGpIWlNGUXNIbldVU0FIVEZiTUdCamJUOFdDbkNJOGF1RTRLcmpN?=
 =?utf-8?B?cGxJMlBEbEFJcWIzMHIyUlp2U1VCcE5qSjhuaFlNWTdneGZTM0tCRjFKRmVz?=
 =?utf-8?B?S3VFNWxialhHdngwTVJqTXVvZVBkbkN1QmJyVG1uZ3BCeXc3R0c4Nlc1WlJ1?=
 =?utf-8?B?WHJzOGlEWlhaa3JpcUtVenZ0aCtJemJuMUZ3MStTKzR0ZUdyNUIxamovSXcv?=
 =?utf-8?B?Tkhja01UVnpxQlBRYlVmZG9XMC8ya1RJN0R1SW03Z2FMRzJpNk1kQU9xMU5Y?=
 =?utf-8?B?cit2aFVhU0VVMnhIN094ejNrRUN3Z2VKbGhiSXBpelg0akpQcDV6V1VFa0M3?=
 =?utf-8?B?Z3pwdkpyVXdEbm16Wkp5S2xjVndpbGdxMkorc2xycXQxZGhSYkU0ZlErd21D?=
 =?utf-8?B?OUNHUkd5UTNteE40azh0R01ieFg5YjM5M21QMGVMeWNHbFUzWFRZd0tDc1hQ?=
 =?utf-8?B?b3JaZWZLQjVMemJqeUpwN1ByV3VMcTliKzBPSE9TQldZdmtBeHFncDJhT3I3?=
 =?utf-8?B?QSsrcTZnNCsrUjF4VklIZ2hwRFIvenYrVncybHU1V2dra1I0eit0SEdYdXg5?=
 =?utf-8?B?S29mRE0vNjUzY25ieU9qSVNaM2d4cHpCMWtVSUE0d3pzUm1Vd3ZKWnpUYlFC?=
 =?utf-8?B?S3pQUEYrQ3pHVDR3UzRQQ3ErditERmhPbXRHd0E0UnZRdkdzWFBCelhxd1Bh?=
 =?utf-8?B?QWlzaVo3QUpJQnNMb3drc0hrd0tkd0sweXV0UDI1SUtxbkl1cHNueEpTWW5L?=
 =?utf-8?B?b0JoUzhOY3hLUWY4SnJGM3ZvUWgrRllFdTErdFVocE9yODhnQ1VlSlh4UHk5?=
 =?utf-8?B?ZVFXN3l5VWpvb1VDVlE0UzZnSzlLMG45c3NMdWNlZFViODZDSlR3emJ4ZTdX?=
 =?utf-8?B?c2NSSXZjMTVDb2E3ektOd1pUNW5OTTVVd2RGSnlZYkRWY2g5L0h6eEVSU3cv?=
 =?utf-8?B?Y3UzcXlCQkdkZzFnSWUxRmMrUFZjQ2Q4aGc2dXRZUXhoNHUxa2pkMk1TdFY0?=
 =?utf-8?B?MHVSY1ZPNm1zNmdGdmJ6aG5jbjVCVXZSOFJsSmpFN1JOajZLNHFtaERHOFJT?=
 =?utf-8?B?UXFHR3IvMGJ0c0czM3RicEZWb2k1TlliRnUvRjNHNERWQ1BVUGh4cVdRTzV3?=
 =?utf-8?B?RGxpOUpCRGJRNzNTdjdYazJVcjduWU5ZQ3JvZkg5by80VDVQekNyaHNXYUpr?=
 =?utf-8?B?ZTZKamRUMU13Ky9VWVYzWmxiRFF1V2F5RFhMYlhlZjhmU0hwVzNtdkNUenVG?=
 =?utf-8?B?UkZmRGRVSzNFbCs2R2FQUEQxN1RaNU0rOW1zWlArZk4xZDBZbnRrZFgvN2Zj?=
 =?utf-8?B?ZTd6aUVMUWRGTnBwUk5lY1pidjhrNEtxaWUvQ3lmcU8xTURPa3drUk5NMVBZ?=
 =?utf-8?B?czZNdWVlcmZBNHNjdEJsNTA3d0RKeGU2aGtCY3VZYWlZVTJpdnRmQzVpalE4?=
 =?utf-8?B?aEJIOFdhRTlEQlVKOXRYT1U1UHFLbHowaFMrZVp6dEVaKzlYV1RVcW1rcFMz?=
 =?utf-8?B?aDhEamFaY1FzYjBkNUpqbkZ6UVJyZ0VXdHpSYXl4N01lZ2VSWkxIVW9pbFVt?=
 =?utf-8?Q?qd8kqTJHuesHYGK5RN68mJ0FJbR1YwR3Xh8iBGG5teDxr?=
X-MS-Exchange-AntiSpam-MessageData-1: A3TtBBAjxLKSTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f774583b-ca73-47a2-87d3-08de89b3cd5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:44:07.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccgqgi0AEbfZ7PLNKvdDOWoTHFaHoblikC9WSsp4H28M+4RuIHpJF9mvgxgNatC4zBxRCPe3u/CYtQzMmrwMKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>> `driver_read_area` and `driver_write_area` are internal methods that
>> return slices containing the area of the command queue buffer that the
>> driver has exclusive read or write access, respectively.
>>
>> While their returned value is correct and safe to use, internally they
>> temporarily create a reference to the whole command-buffer slice,
>> including GSP-owned regions. These regions can change without notice,
>> and thus creating a slice to them is undefined behavior.
>>
>> Fix this by replacing the slice logic with pointer arithmetic and
>> creating slices to valid regions only. It adds unsafe code, but should
>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>
>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue binding=
s and handling")
>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.or=
g/
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> I didn't apply Eliot's Reviewed-by because the code has changed
>> drastically. The logic should remain identical though.
>> ---
>> Changes in v2:
>> - Use `u32_as_usize` consistently.
>> - Reduce the number of `unsafe` blocks by computing the end offset of
>>   the returned slices and creating them at the end, in one step.
>> - Take advantage of the fact that both slices have the same start index
>>   regardless of the branch chosen.
>> - Improve safety comments.
>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8=
f3ce3@nvidia.com
>
> Here's the diff that fixes the issue using I/O projection
> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kern=
el.org/

Should we apply or drop this patch meanwhile? I/O projections are still
undergoing review, but I'm fine with dropping it if Danilo thinks we can
live a bit longer with that UB. It's not like the driver is actively
doing anything useful yet anyway.
