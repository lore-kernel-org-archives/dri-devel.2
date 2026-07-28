Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269E4C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6097810E601;
	Tue, 28 Jul 2026 21:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+0bIrJ6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E1B10E601
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0RZPmYEwQZkXTcpf2l1l+4ijlYwlkW1HcsdbHw6u8LE+tKHcCt7VXUBLlbrc+6WZ66UJ/asGBLmZXCIfgv1kr4DEHCIqt1f94cwGtVQmi/jyvVV5Duu7EsU1q5jhlTzZVEY+sESTLAh3ryvP709/1hXIwV/htP6azCEF8wzgUb2N4d5wNgeikR0JIVjRgjnZjNr6cjllIR8cpvYGC+gvXQIVkeWtV1Hj3ybduWPKXBGIHWEwRjY9ebb2qHG6OVF5n8+aEhNBdo/6I1taQtPD9Y12svlexPk+abDPyMbs0NB5ZcSy61w0e2F0EgKzKKr+PgJfREjl72K591hocH0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1hgiH6vUasT7Tv4sbwrD/rAOB2+/GhLKCNEDq8+/kU=;
 b=Oku9ptWTCNH1vr+f+aVTRult1FMgkimw1H7QNgtOFCrd5fdNw9Ldo7jhC+ydGQpCtIG5wKQ2Ch69KUDM7F2JxXpe+QZEnWQ0Jiii8KFkux9Guo0Z+4k83VgmuIp8Ue4kb7hFKd7RSxxRA9wEbfGG8dR4AIGKfGgjNxV58zu/eRmI6SwBSXl/L9BEaggfwao/hAUXul7U3NwkMJfRp1fiHk3K9Mk0JYwaLICW+9RdLSYvEHvh8sMm6mmon7xXQAwd9NNi23ZQefcSYXUIBhfpHstr7a+VIYujqlbW2SbjDP9sq78dT3lqd++oErfNn1UWSUtTYv0JTih3Lg7dH7dCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1hgiH6vUasT7Tv4sbwrD/rAOB2+/GhLKCNEDq8+/kU=;
 b=A+0bIrJ6lb1EmYZO4g+sTsMSf7YvaPR0aPJM9UvSU2wT7ch8p1tAtbXgcS8n2g3TEHCxN5JAnLP/qo+2dQEp1+CarWzfJEhmbaMIL52dkrUXWp15PBTrUKGGXU2kpKbwWLJk7GcNHoPJYgMRKbGuzOzin6WI8lScIazvZoDTjuGcAyQU0p5IJ6kuggq7Hr3ILQqMiGqKLTiqqi0KabLXjxtwzwRkUj4DUl+yu8RbkSQf1G5drHWgfk5MvWZTS0Cytn4NsyagXY7VlyOzLSuuUZNlDVL/IqDIT7SOY9Ojera+mwn/co3AB3wXMtzw73Iqgil3b3Qjd8YEVda+r7RTvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 21:49:56 +0000
Received: from LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4]) by LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 21:49:56 +0000
Message-ID: <57e2b956-89fd-43e8-8cb3-a15aee272660@nvidia.com>
Date: Tue, 28 Jul 2026 14:49:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
To: Danilo Krummrich <dakr@kernel.org>, Alistair Popple <apopple@nvidia.com>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org> <amhdA35CcMD_uY2f@nvdebian.thelocal>
 <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To LV3PR12MB9412.namprd12.prod.outlook.com
 (2603:10b6:408:211::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9412:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: d13cece0-ff4e-4a39-f5d9-08deecf229f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iBDM+TKAuQ71qLfwE+8uXyQMWXRWlC2sKYnRb++9mWL/flGVupakuZhT/vDu9WanZ5WrmXxfOgwBcNGK/z2Zl2BXi79w3eclQ7S4T+mHuWr6tos/usB2oUkjN7aqads0iL+YD+BDsfroL6mO+UlUI93ibAZ+fanZbzseB81Ip1pG136bEL1vNqFnplvvhFg+cgNE38zvgiinFMySmMY5Hx9YKs9nTmbKtTxAj02EKD5x/+OK/i9BHBwXrA+EVk1jKcFXDYv/uZo/K1jmhErus7Gp8aFUwMliWsCJvu1NwyyQL2DGqw+Pen9Yj0bmvAuD6EPyQ9ROtQbhU8wYI5v1yuUn+gSo+iCttraPvgrYNDTVYRisj92P+CI36yWamfy2pDVy7fw6BAK/XE+x4uIqdthms4D6+8MvdOYOmLW4StLIoArCAB6buf866rLLmgVP7prGqlzCNLKZOF8DkcH6UT7B75tk0n7/ea4wfZqO2Tby7F8bs4nUXjzk9aNAwQhlemQHsChFopjEKWUfFfDMkPGkvGTsEhsXLPQxoNWzbhNtutz1kBOscNFV8O7NPppY7BFJ7yHjc+dxW4cVMIRCyQgY3d39TLa7hTsN1B5RcFSWTU5dYSfrjT2zJQS1j9mv46Yu0C+cN1T0IRwwEsiAFOMomFRocfZOJVWXZtVu6M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBMZ1VHOFIyKzNmVTN5QzQxVlFlazZTTHNyLyswZDZ0aGg5RDB6ZFZ3ZEtx?=
 =?utf-8?B?dTZGNG91OGdUWjNySkpERGp6WCtqcHNORVdCbC9xVWRhQ2ZTSC82eWp3MjVN?=
 =?utf-8?B?UDZTU09QVEl4TFlPZlJVOG5ITE5lVFBmRmFsQ3k2U1VJSDRpbEd3cXpPTjJ1?=
 =?utf-8?B?eDFENlpVQ3FRU3hzc0pNanpZMzhEUmxzM0ExQzZtQVVveUx1aWVzWEJ5Ni9z?=
 =?utf-8?B?QTlrNUFYeWhSVjJUd1NidTdYWHVFSGRxb1o2bGFHd3FBNmp6aEYvWndEOUNL?=
 =?utf-8?B?VzdCcDl6cVVvd0hiaVd5cXg1TllUb2JCeXR2LzN6V2VmbWgyS1ppWEdPaVAz?=
 =?utf-8?B?Q0JpUDZFcXZtZlJjai9RYjhPRnBsajM4YVJRckNUMEVaOUJKRHE0WHgzeG5T?=
 =?utf-8?B?UVhhZ2pHN1haeG1DdzA0NUpjZEVIdHdCVUg4anJVYTRqbkRlc3NxZ3R6TGx5?=
 =?utf-8?B?VCtrd2ZYd2dkTms2eFpqMUZKRTFvSlQ3YXc3bU1jWEt3d3pjYkNyUVhGSjlX?=
 =?utf-8?B?R2Vwdnh5d2lFUEhUZG9qVjFpSnMzaGdnMXBSSkZxOW9kQ0ZWcXV4TUtUUHFM?=
 =?utf-8?B?bFNPNTB5VG5YOVQzUDl0eDZqMTRaREFwbFg0VmFXK1ZEcEZYanVOYlM1VzND?=
 =?utf-8?B?cWhBWFc5dVZIb2huelpzdTVEY3ZXaUpEb0lXc1UraXcrS3B0RG5tcUR0UktP?=
 =?utf-8?B?dERyNXpLMEdQN1lUN1RMRXRKNXc0N08vYXh2dWRlSDIzem1xQnMzOG5keGdV?=
 =?utf-8?B?aFhMcDJ2VUxSNnloK3hNZlcvV2wwWDBMSEdHWVJnMXduZTR6ekFid1NjVjQ3?=
 =?utf-8?B?QStDaXk3aUY4ZGZsamNnWXMwd3QzR1d3cWhxbUFRc3VDbWxsTFF4VHlwL2Jn?=
 =?utf-8?B?anNTNFFmZ1RTWGlXdEFyVzE0N09WVHVPeEVJdFUvVDVzY3RQTGRKblBTV1VI?=
 =?utf-8?B?M1hSY24xL3VSZDF4UHFscUFQTFU2T1JyZzJ1cEY0d01NZW5ydWpQaURCR0xz?=
 =?utf-8?B?Ukx5MHljdHVGaVUrUStITHJodDNqYWVFZWF0UWtGVnVET1VUYUttbHF5bi9n?=
 =?utf-8?B?cDFoNWRKUTBiRk1KUHhROG92OG9seWtWQ2dpOVgyRmRpWENEOTVEcUNPYisv?=
 =?utf-8?B?UnRTM3preUF5d1pUeHA2MnJSbDJIbGg1S1pVcFlEaVd5VkZJdVZJRHpaNVJk?=
 =?utf-8?B?VTM4T0FSTjlEU0lOZXAzTDRGazRCdEFVS0xjcUJQdTFRVFRRbkRoUnBWSEJX?=
 =?utf-8?B?Uk5yeW11WEpaek51RjdGdUIxSGxlRkEyZkl6NlFUd3hSNEtPUS9VbURXRTh5?=
 =?utf-8?B?UEpCaiswR0drUVFhM0xZWWNGY3h5Qlh4cnN4UWhmMXFJVlJZZDkzcldiNWtY?=
 =?utf-8?B?SkJ5L08yRzd0enhRQlhDYVhZeno5aU1ENmMxY1dGaUVOWmF0dVVudG1wZ2hT?=
 =?utf-8?B?Q0Q1Sy91dS9aM2Y3ckpWdFhlRmZueDl1ZWw2ZTNKeGpCN2FpelJHbUwyNTJ4?=
 =?utf-8?B?ZlljcEd3Tjg5VUk3WGM2cGtnMmh5R01CMFovWG1qU2JBN1FIemVYMng0NDYx?=
 =?utf-8?B?blVObzlmL0U2V3p6Z3ROSHZtaXRSTm00VitacnArQUJLUDVNbkhVZHZiQmc4?=
 =?utf-8?B?LytIZGZrYnd5UU1qc210MllYRFRCak9zTVh4VUg3TEl4cUVnZ2UwSG5uY2VL?=
 =?utf-8?B?NFk5Z1FiTk4yczgyeHF5V1VaQXJGNXg3amhmMkVITmx1TnhyWWNFMDFqTk9i?=
 =?utf-8?B?d214QVV5SUg4S3ovbG9vUFlDVDRKditiQU9tOFJXTzNxVU4zMG13WXRTajFW?=
 =?utf-8?B?V1ZwUmhRTDYvdThya0V1R2RSaFFlam84enZtdjdDV1hrd01NTi84eVRqUE1V?=
 =?utf-8?B?RERkWklWK3c0eEtuYVhVeHFOcG5IZGRYWGRCV0NnSW5Rd3ZkNHJNMTRFZy95?=
 =?utf-8?B?aTJEWWZLMkxUa0tSZlIxTVA0QnpXc2dRaGFnUW1sUkh6cXB1Q3gzbUlnOHhi?=
 =?utf-8?B?bWJTS1NpaUJXSEpDYlkrVHk2SC9wV2Q1Y0NINk5jN085NXhSWXVVRXN3djhR?=
 =?utf-8?B?WEFLMTBjZlZMK2ppOHk2eGtLdU4xdzZVVURIMDY5cHZpbVFJQkdNOFNyNmZZ?=
 =?utf-8?B?Ykx1SzVTekxGUlZERjJLeTVWS2JVRnp4VVhjRDJUWXlUOW9JalBGcGZQVHNp?=
 =?utf-8?B?RUhYNkdwakR3VXZTWTlYWkVFZzRobjUwSWl6NXl1M0MycGdQMlZ6WjM3T3ZQ?=
 =?utf-8?B?UytQYm5mQ0VXcnUveFZOcUc1TVZJZEJkaDBIclRISUVHalBmSVR1OW9UVVlh?=
 =?utf-8?B?d0VCaXA2NDYxOTJEWkVnT0FjYkR6WGdVbzFGZG1YS1FJd21Td0NZdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13cece0-ff4e-4a39-f5d9-08deecf229f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 21:49:56.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbjTsgTnm7Y6icmq1BNAT85LbT36i663w0kISNVOdFXjWlUeIVKU5oBOs+EX5Leskg1ppPSWHtmRlE022s5V5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

On 7/28/26 2:29 PM, Danilo Krummrich wrote:
> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
...
>>> For instance, what's valid for userspace to extract from this? Given chipid is a
>>> composed value, is userspace e.g. allowed to make assumptions on extracting the
>>> architecture? Or is this something we want to expose separately and tell
>>> userspace that the chipid is an opaque value identifying a specific chip only?
>>
>> I _think_ it makes sense for this to just be an opaque value, but it's a good
>> question that I should probably try and get some internal feedback on as well.
>> Reading the arch would then be a separate parameter.
> 
> I'd prefer exposing it as an opaque value and provide other information
> separately; the kernel already does the work anyway, so why duplicate it in
> userspace. It would also remain much cleaner if encoding details ever change.
> 

Just to orient myself, I'm assuming that by "opaque values", you mean using
something that just counts up from, say, 1, instead of using real boot42
values below, right?

That seems like a good approach to me, too. Because I can't imagine anything
particularly good coming from providing unnecessary details to user space
here. :)

>>>> +	/* Turing */
>>>> +	NOVA_DRM_CHIPID_TU102 = 0x162,
>>>> +	NOVA_DRM_CHIPID_TU104 = 0x164,
>>>> +	NOVA_DRM_CHIPID_TU106 = 0x166,
>>>> +	NOVA_DRM_CHIPID_TU117 = 0x167,
>>>> +	NOVA_DRM_CHIPID_TU116 = 0x168,
>>>> +	/* Ampere */
>>>> +	NOVA_DRM_CHIPID_GA100 = 0x170,
>>>> +	NOVA_DRM_CHIPID_GA102 = 0x172,
>>>> +	NOVA_DRM_CHIPID_GA103 = 0x173,
>>>> +	NOVA_DRM_CHIPID_GA104 = 0x174,
>>>> +	NOVA_DRM_CHIPID_GA106 = 0x176,
>>>> +	NOVA_DRM_CHIPID_GA107 = 0x177,
>>>> +	/* Hopper */
>>>> +	NOVA_DRM_CHIPID_GH100 = 0x180,
>>>> +	/* Ada */
>>>> +	NOVA_DRM_CHIPID_AD102 = 0x192,
>>>> +	NOVA_DRM_CHIPID_AD103 = 0x193,
>>>> +	NOVA_DRM_CHIPID_AD104 = 0x194,
>>>> +	NOVA_DRM_CHIPID_AD106 = 0x196,
>>>> +	NOVA_DRM_CHIPID_AD107 = 0x197,
>>>> +	/* Blackwell GB10x */
>>>> +	NOVA_DRM_CHIPID_GB100 = 0x1a0,
>>>> +	NOVA_DRM_CHIPID_GB102 = 0x1a2,
>>>> +	/* Blackwell GB20x */
>>>> +	NOVA_DRM_CHIPID_GB202 = 0x1b2,
>>>> +	NOVA_DRM_CHIPID_GB203 = 0x1b3,
>>>> +	NOVA_DRM_CHIPID_GB205 = 0x1b5,
>>>> +	NOVA_DRM_CHIPID_GB206 = 0x1b6,
>>>> +	NOVA_DRM_CHIPID_GB207 = 0x1b7,
>>>> +};
> 

thanks,
-- 
John Hubbard

