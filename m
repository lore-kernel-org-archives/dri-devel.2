Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4AFF60ED
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFCA10E7FF;
	Tue, 31 Mar 2026 08:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjZSb0ms";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D296310E7FF
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSkG1WmxD8iQJ758XkENgNQXGRP0O/t1vYSupL2axaN9A/I4QzFcg/ynCRuzuB1l0stsCuV7kcBtHW6GmoXWJ/DUoNXhTMFwRpmHYtXMSzwSmeCRtil5nh8A4A9c3vVK+7/tHZudtb5qf63tpasVsIn9kiGtYfz+BEF+3IcNo7qgvNDntiyMlmTor9H3V/P1Vo9cgKOodXFK6H++TLbPvfLFljQgt9Z9jTKd6jNtTGxWyRJtSxGZFl8Sw+rKWR+nu6gE2zv9XMCSBtMeHIybszIiI7AvH3v9FxYo3ASldJIvyDVjMxdo2Pl5b+sgEARSNyhtmC2bvux2Ks6bPuPcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbwQ/e20JkCFdvkc8D57EBsHD434cP0/b+7Pmcb4sVg=;
 b=D+rnNg3ppifK0he1ZbpaexhyzElOY4fnZuJekUIygpAY9BJc6IYgzHX3UUlnHMAIaUePvs8G3IZdAw9SQ5KwajJ2FW04DdWweIU+uqmvUiu2Wnm6zz4PyICZxa+hTJmvu/q6H5UGvJ1ml4Ziswg2hURrbOUGBX7QjqluMjqX093CmZXg97RX/2JJzUlrJNl311vW7k99A1HzG1X+30muLGMGARlGj4NudkoiYI4GyABNgLk9690OILNh4OxWjSVsQkTrvNMABFNYfRfbadoo/XWxBODqK9LiP/RTvia9NKI/jEHds+p52kKsbiPpl7lF68l2eJMFO88EsLrOck/V2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbwQ/e20JkCFdvkc8D57EBsHD434cP0/b+7Pmcb4sVg=;
 b=bjZSb0ms2bCW8N3lK/XAv8xwbdqWrKYrlkVy9eN+9vXTYVc8sNU8TEVJjSFkB4K3i4pVcHhoi/LH23xErWYRp0kamqQYmNnmjbYs7mIILE+PwmVpmBBibcwdd38PpTMBiEumo+GAzu1tPjS+ZE2/UxFc6Bm5rf7WugodQdzhuci/oe0gb6CndzdPgZhBqAjp7xVqmVWfqcWyPYKD3xEF6ngmqK48gkjPubTP8MGHRbNXc0VWc5LZmVKLb79+MKyENFiVKJ6887Cnbk1YxA6BsXwN0Z1GxyXA9XCEWNr9x0Som/9vYEXSk36mqf/KFHIYz9PZPzZ4OS8l4wx/Xf3KRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:48:02 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:48:01 +0000
Message-ID: <8bfc1678-e2a6-45ca-9246-5b10b935d0d3@nvidia.com>
Date: Tue, 31 Mar 2026 19:47:54 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib: test_hmm: evict device pages on file close to
 avoid use-after-free
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: zenghui.yu@linux.dev, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260331063445.3551404-1-apopple@nvidia.com>
 <20260331063445.3551404-2-apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260331063445.3551404-2-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcb99a6-8e8c-4352-8b05-08de8f02376c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6JFmj6XlRD2YbqyfalaGHknPCQFiJY4tD1XBmU1+HsPwERQ0BLb3160e6cuDW4EppfEvVYX35yn0YGvR+CX8ODwIouD/RPo3H2mLmpD3iXRKw8B/HbvcCllonVCyvasuC2EXRJW2kBZnjStEWLtJTaLwihQwV1SBRLIPC/l+FvomMhkGJ3hsq6ZsMJOl0SbWo/UiNpZNP7EiRoCFuNN28QoJIEGZV1nPqGO8ZIDfcs3rggdg9pKzc6wZmGqp8m796saTewZAAWJpgI/WqwjPpWR9ZyYvsPMkCsg7BNEDXGM3rGrCTA1t1dK1/BL50CDkVgDAlf6knspRyu6V1sUDtsiR6/+U4zgTdT2j7aAIdckWUOyCTznscY2iVZJEzU92Jh182/N4PY0oFLIch+4vyy02r7VY904jsSN8nArACYkNrYVDngRiq+KJ0M0p03S30fxvnvSBCqcfIsGaRjDwtakO2jYWF9RQM036iDqHh6gmln8yOnY+/E4kaNG+t9F5bO/N1faSA+XTMcgU6Hv98bXlMx8o9cX+Ktai2ymOrwPe6pj5L9UmrkmD8kKuhaTk31INVYQlUs4YHIZAjvsrJGG21o/NWcHq6TSXwCK7EDU3JsPiryboGFcCK7Z5/3VsJWRV55sMD8vUZ+qsVipFufaj1NNrJbmYPa/dAlv/T/o24/D7Q0bbNWGiHo3iaWsTuTtR1JyYuJE3iR6G9LhPu+Fw23GVLiYlc+WoiMDq0v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUR3OWdwTlJsZDFGbVVrVjZ1Z2VSYmNBamNYSlJNWUUweG81NnJ5d2huM0do?=
 =?utf-8?B?aG5jaHdnejVlNTN0eEtiTjNtMUdmcE5LVzJlQVk0KzBGZlBWNmtJcDFjbzl0?=
 =?utf-8?B?QWxxTnk5bEJreWpnMGxtNkY3aXArVSsvdUN2T3dORUxKcUtBT3p2MmhTRzBO?=
 =?utf-8?B?VktZWS90N0RQUkpBWHo2ZFptUjlqa2FXYklnbTVyRHJjeFRTeUs4YWNOcWR4?=
 =?utf-8?B?ZDJ0NTF2eGhJMGZoZWtHVkxDN2lCSmh4Y1JockFmSHlwNW9rOFhUSWpuazZs?=
 =?utf-8?B?UVNSQnJtNjRkNS9uZU5vZzM0YTkwa0YyMk82OTNyUm1SL3lEbUVRUk9YbnVY?=
 =?utf-8?B?Wnh1cUs5SDlyWFRxbDdJdTdZOGs2Y2xwMmMwSWF6Y1ZyUWNsblhQVm90UndU?=
 =?utf-8?B?K3NvWEFHVHFsOGlkTFN3K3Z5UTBUd056a09waVZENXZRQU5FanZhMmd0Q2Rl?=
 =?utf-8?B?b1VYdGdIWkNCdzBhWldVSURJSUNOSS9YbDZMNEhydU1OcWF4QnMybTN0SFMz?=
 =?utf-8?B?dlExVllFM3p2SThvYW5hMmRxZ0dORjhHWmNqaWNCelVvc3dhaWxlS09ZUDhX?=
 =?utf-8?B?a0RWZ3R2aythb1loRVNWblZYUUhmV3JRU1kwditQTUFUU3pJMDczeGhSTml4?=
 =?utf-8?B?Sm5OcDloUktPbDZkdVZ3cU9GMDhNWU94ZHU1U1c1a25QRmUyNFBuZ1UzTEph?=
 =?utf-8?B?WnNGWWZDODdZQXR5cnNxb1BDd2RVNzNwRzlmSXlhZHVIaFgvbmZxUFZzRFRp?=
 =?utf-8?B?YVRhZ2E0QmUvYVRxYmJBWThzbGtSajhVa3Mxcm1RVnBIQnVVWWYwWC9zakdB?=
 =?utf-8?B?RmMxZlR3SmxLd2tud2hlTDgvL081dUM2NFZkS25oY0dhRzV0c1FjZFAvNWtt?=
 =?utf-8?B?VHlrTWhlcXJwZC8wUi9mcGIvSUY1Wm1zZTluYXFoSlBWb29maC9EVWlFNVUz?=
 =?utf-8?B?NTAxSHpoYjhJaUNqSnp1VnFDN0cySEo3bWwvUXN2VngyWmdFVkltZ3hqeHJw?=
 =?utf-8?B?WHpzVk1iZHRFc0FZZ2dHdUZHZzVOWVJXK3BxNmhWR2hmcklsUlIrMHVQU2Zm?=
 =?utf-8?B?cGl6T3JEd0djL05iYnlEdGs4K3BIVzZ4WVNUeUlaS0JER3lHdGExWDZuOU5q?=
 =?utf-8?B?OTNwalFiQzBIVllpWXNtVkFYSjNsZHFrcGI0MHg0c1lEWjVUSHVsbjlBdm45?=
 =?utf-8?B?ZlZkb0pNZk5tSVJ5bDFTSHptZFJLeHl3bUxwN3IxQUxaRWhwbDFLc2dXNzVW?=
 =?utf-8?B?ZW1kakx6T3RkdFJ2OTlMSDBMMjhFOSt1Rmp6SlFrWDVDTTVreWhFZm43dmcz?=
 =?utf-8?B?UXZzRm03bUhlUFNaMm5UaG9yOTdiNDIzWDAvdGFyd1hkdk5scFUydUg3alRk?=
 =?utf-8?B?R3NNZFJSWG5jTnBvdTJ3NUlvMDFSR0Vsd3B6VkNKd0NuQS8xUWF2cHJlYVRP?=
 =?utf-8?B?Q3JMMzZudjZSVmFQUXp5bGhnYjBVMmdRMS9QRHFqUHZyT0kybG9RZC9STDNZ?=
 =?utf-8?B?S0NJOUVHakVhTkg5bkNrY3YwbExGRERwZVd2c3FYRkpZRWNtK3NMMVUyYjFC?=
 =?utf-8?B?a2dFT2w4SEtLVThqRURvakNERCtucUpWV2EvUGFFdFR0bkRQQWxrTzJEdmtu?=
 =?utf-8?B?cS9QRnAxbWZNRFplTG90dVdqV2VWRHpUaGJOV0tLNjhkT1U4eiszVi83bzln?=
 =?utf-8?B?eVAxT1hUZ2dka3ZTeG1RNVMrdmVaYUt5Q09NYkZ1bjRJajFmMGUwN3A4VVd3?=
 =?utf-8?B?eHhoNDJad3lpa3ZmNkxSTFp6ZloyMVErcnJ1bUJwVVJiRnV0Mk52RlFmUlRT?=
 =?utf-8?B?MzlsT1dnbmtKUHY3NlNpZyt4YUFIL3dWK0hSR1ZKU3RpTmQvV1dhdCtVOU1Q?=
 =?utf-8?B?ZVplaU1BTCtJaklXT0FBNHRTS3liVENBeVRHbEJQYndkaUROR1hrUXdtL21O?=
 =?utf-8?B?MGRFNHpNZW1QLzlPM2pZR2V1dUlOSjNycXdTRDM1ZkhrU1EwMS91bnJVaVYy?=
 =?utf-8?B?RVZUUmllTVNqL0FFR043UGV0aEVuZGFyZFdjSWo2VnlzYm5rUk5SUlE1S2FQ?=
 =?utf-8?B?cURsRWM2MERMUTRpQjlsOXZxL0VPSzF0M0FocGtGRjE5UUNnajQybDJDdVdm?=
 =?utf-8?B?WVBoUmx1U3Zaa3JGRytVbmNKK1VCS0gvVHYwQVZyRkkyWVVzcVRsaCtxMzBH?=
 =?utf-8?B?alB3STBUNExGU2hXUG9iNVFKaFFIZHNJOVhkS1EzQjNaZVN6NWFnREpHV2No?=
 =?utf-8?B?aVhnY2VLbTVMK3JYTUtYUjhqR2N1L1NWcHp6c0FpaUh1NE5EQ2R0T3ZDQUlh?=
 =?utf-8?B?T3dTU3dacUJYTnFOOXdHL0x3Mjhqa0gvL3RzR0ZMcTd0ZU1QQjdKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcb99a6-8e8c-4352-8b05-08de8f02376c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:48:01.6996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYrtxOqNloumMxXAyDoGyw3tm3dRdvzKJMBx8vCAQOEDxHtd0zu6xx8nDXFKxUc+JD9FQnsGUX5Hqtnt+Q0i9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228
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

On 3/31/26 17:34, Alistair Popple wrote:
> When dmirror_fops_release() is called it frees the dmirror struct but
> doesn't migrate device private pages back to system memory first. This
> leaves those pages with a dangling zone_device_data pointer to the freed
> dmirror.
> 
> If a subsequent fault occurs on those pages (eg. during coredump) the
> dmirror_devmem_fault() callback dereferences the stale pointer causing a
> kernel panic. This was reported [1] when running mm/ksft_hmm.sh on
> arm64, where a test failure triggered SIGABRT and the resulting coredump
> walked the VMAs faulting in the stale device private pages.
> 
> Fix this by calling dmirror_device_evict_chunk() for each devmem chunk
> in dmirror_fops_release() to migrate all device private pages back to
> system memory before freeing the dmirror struct. The function is moved
> earlier in the file to avoid a forward declaration.
> 
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Closes: https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Note that I wasn't able to replicate the exact crash in [1] although I
> replicated something similar. So I haven't been able to verify this
> fixes the crash conclusively, but it should.
> 
> [1] https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> ---

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
