Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB549CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A6010E158;
	Thu, 30 Apr 2026 11:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+ARXhWJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA4810E158;
 Thu, 30 Apr 2026 11:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux2pjP+qzRO/+K4dSJefrofMx/0yVWf2nC9Ij4jMY3j5dKWCl+14LSAmgefZp/MlbtJJAQql3EfC7scJOBBgbrdw+17wV4jZDtzcywKpBlvYpanoOhUOT/wZoKQPpZIQNJddPzvmiXfqTRFNYXEXYuuuNg9grcNLgw41lQjSDgBFHFSd5T2wauQBRwqpCwIJazd6ikcFPvYKZKQBCF0M9TdXFhomOmEkKtqYd02Q3D4GoZbdRR+qYrPEXIIPJZk/SGrvRYKsHKDzESVY1E75PB2uvTcRGSKu2dcCCc+gTobNAHKIhClD5MrMYxGURsyHxL4xE8m1GyZx5L3stoiTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pf+SXqQqxLRjLO0A5gQ0qhj2W1j4Q8GR35yJ6qqop8=;
 b=qqhy1MgWcxqXtLcxstGkJeLKdd5Zwa0P1TrE5WxygebSE13661SUlCCR3MyULTdZ/zDBmos0xH+kUKAzLSHZPhiHlKk78cgPHS1qj7wTsAuiy0PAdJvLHnXoZdTKSUWyVPxZXyNlA8EZ4O8VcQHi4x5nVksOg6CXnL2DrOUIpXb3VUQMYSSIuHtAUiuaGG2Kprq3rsESS8FG0eZudH8HHtc9z/v4DBE5v/IxKfUbc3eLYcPKpZ93oS/1MVthQKxXMtnSNsD9Ddfc20pFXxIH61s8wzAFaGfSGxD8xSbegbENQgAiTUazYw1K+1wen98jWWVg3L4lIn7SS8BF9REONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pf+SXqQqxLRjLO0A5gQ0qhj2W1j4Q8GR35yJ6qqop8=;
 b=L+ARXhWJJbQWiH/0uyax1YYmvg2Axe5JRPP+URkE+eWZNYMUu2iEA1hXFWeftYFUPGSLn6CIEDjBIyvUXdy+tEqYSPCfZSFXa61+Phb+xGQurMdZjCjHSS9mzAjZbfEEDILl2wqyOh2rj/zf7O9SQPMCrlHPq0QiO0SnOGMrEaDiNFkiM8xIPndjExFcOFNNv6w5t2oV68Cy3OPF0jtzROpoZ6EeudCaO3gRDzfSzTvKqrfzv2QPE8Ih37Ifvr9mKaESztSMYhatAA2aJbfMc9FPbhJOawGy4PUCqgS7CHctCSoKo8FvS4SjIGcrdgRhvv6tiVczdQoC0qAN1zq7rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.21; Thu, 30 Apr 2026 11:24:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 11:24:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 20:23:59 +0900
Message-Id: <DI6G9FSQHM1B.4KGHIQWPC94J@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
 <DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com>
 <DI5LRCUUKJJW.24ZCQBQYEPPVZ@garyguo.net>
In-Reply-To: <DI5LRCUUKJJW.24ZCQBQYEPPVZ@garyguo.net>
X-ClientProxiedBy: OSTP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 643abb0f-48f2-4e57-d47e-08dea6aafb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xiGG0JrlXi6QxyN7nOqJWlEkqhCpP2hRc/GKiE+CW4IX7JOcgJbUc2Jvcp7q3K/vvFazG/XnAmDJX1JTMSpmDNHSrnQJLLUz79bC0UISdIpKJ2A8va4O6IxoO8ff7oYh8U/T7JNCPmaIPE4z7ksKPyqGGztpaQn0//z+zgzh9xC95zTgdbvhqAhM2/6CvFGdYgi5zT3AzjoW9k75e6N5IdQUh74aBYIHq5FPzN3MGYb32Q2V3YS+l9LvwyZs7Jh7Xa7RllogpVzhAhGI1reVIPodXZmXnkRzYzYFP1/D2YvrFmsPStA10cpGyo3a47XZ9PMk8jnwYUF3PPNK8E4ufEFnyeBtt6/fn/pMyX3rmUhjaH3V03npf9VEz9HxYHW2IssPcviAB2LjtSc3J9Wkeb3bYvFJ8EYGMgkiy2ExDdK1jcGgISv1dxmYUh70ytmHYXkfVLFC99tf2QaDa8ajdXxmNPteRNT9NTvXu2t8T7FSyczt9qnV1udOa2NN39kxCynVe/W/DDB7UNTIXkRHUzoDxDSR4FUYzrnwKO4dggdoa8lQ0TsvLlI0MhtveLiIPsyztyii1QXVSsPwy1Rz7+3gP0k1jouJl5+oc4xF7UVogqjeCqW0ROmzGvYXUklhQMH3qXTw2t5UWq/fcRE2+XvoNmXxxIvtlv05RoWqs5ER2tHhw3wJ6pRn61E1x62fl3/d6YGHnKXD2VcOefNozjznLye40TSwcH7Q37MR1Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUhEM0JWU3Bwcys5c3I4bDV0ME12RVc4bVhWdXU3TGNtMXJmTVlXSzVCcGlu?=
 =?utf-8?B?RXRlUWJiZUdFNmhMbExDQ0k5VDBhc3haVTJUWkt5R204bFZMRjZWcUFRdnVx?=
 =?utf-8?B?aUFEaW53M0JEMmEyYTIvK1U1eGdGVlBnRTk4UEZEazgxNHRRWElkQVN0d09U?=
 =?utf-8?B?MkxtUFFta2xhblIrOEVJU01xZUhhUEZmdDZ6RHNrcE1ZTlFQdnhoalQ2N0JU?=
 =?utf-8?B?M2E0aS8yaUpacGNmdE9kL3NvRXUxMm9Hb0pEYnFMZXBRZEd6YWJ5SjNTMFlp?=
 =?utf-8?B?bzlqaEpIdFM1SjNTZVE5Ni9Ua3hjYmYwTUxEck1ERnVLK201NWVvZjRMVHd2?=
 =?utf-8?B?YnJwMW95NXNDZERBZ1pEUlNXNWp2dGFzN0JhOGw0SXZsRDNjNkV4N3pqUTUz?=
 =?utf-8?B?eENQc1J4YXYrMFV5TFdwWlF5dWlRVTJ1Y0pZRVk5OEpVVks5SkVtQithcVBp?=
 =?utf-8?B?NXJyV05XdncremZkMGJWSzJZSGRpdUhMc1lubjhiS3JlTXdQZkpkVTA0eE9L?=
 =?utf-8?B?b0wyRnlCb1BYblArWEZoemd0cWJnR3FkZDNPZGliQmZTK1dzQWJvc3pMblJH?=
 =?utf-8?B?N1JPRUNZeVY2b0VyL1oyR1R3YUd5b0FVOE5Gc2crTURiS25LblBHU29WREhQ?=
 =?utf-8?B?TTNyWjBhS2RTTEVpdGxaY1JKZjJ6Zm5zdytWdHFFejNSMXZIaUQvZm95ZG5L?=
 =?utf-8?B?d2IzODNwZy9RNDVZeDZoV2Uxa3d6MnlZekpWZ1BOYWdObEVzUFQyK29MVUls?=
 =?utf-8?B?cmhqMHdxUFVOa29lamhBQ3hpU2JtY2xBMVg5cy9Nd0NubW9BZERZY2hMS0ha?=
 =?utf-8?B?N0NLNWNJenJxWC9XMkxkRUN4cHhMaGRtZGxiN1lQZFAwd3JjdmRqenZ3YVdF?=
 =?utf-8?B?MFlMaUVZMU5ZVlRHTjQ4OVl4S01pbDVlUDE4UTdtSlBtZkY0QWFRZk95TDFu?=
 =?utf-8?B?MGE5NmRhU28xODVMRlhsc05LMUZ3cldCdEN4RUl2TitVQk1sMXNwUWJOR05G?=
 =?utf-8?B?ZmQyNk5saWNsbnFnbzFjNHBnWmZYMG9Jbk5LVVNYT2VSQXBiM2FpdWNmOU14?=
 =?utf-8?B?Q1NXSW81dzM4V2hPSWoramgzUUdLTStMd0h1akRsekpRaXV5bXhVWDJXcmRR?=
 =?utf-8?B?NlQwRnlpQXYxdDQxU0lyYjZzb0FnNUNpSFpDb2ZIVUFjWkNidDcwTy9KYXRn?=
 =?utf-8?B?MjVQRmJpVzZ2QS9zbU5FU1A5VWRjVC9QbDNYQ0pmZWM5L3lPVzVMQlphYW53?=
 =?utf-8?B?aTJCampWQmRyZzlRMWFKdFBZSDQxbTlqeWRFbTB2bnZodyttOHVNUlcvS256?=
 =?utf-8?B?N2ZabUYrTDF0OUVPb1lOdDdXUk84NG1FQjJEZWFISzYvR1ZXN0ZUNnk1RllN?=
 =?utf-8?B?dnVKSW96L29KWnYvMHhxWnhjaS9PT2VwTDNNVmFyamRDbWJjck5vakhIYld5?=
 =?utf-8?B?MGJyWm9uMlp6VTd3Wjh2NUp5cFBQYVVXU0lxbkJXUVFTZmNjL1UwYUxuN1R4?=
 =?utf-8?B?UnpmalhlZ3Q1MFFlVUVZOEF2YWpuYWRMWGtmU1hZTWVxUk1sdVZ2TWNBVEQy?=
 =?utf-8?B?Q0djZzVXRmpReGFWcHBtbXUrVzR1VHVjYnNpejk4RFZNMHQ4V1lvaHFGQXEy?=
 =?utf-8?B?elhNQTIyem5kajFVbWtFYm4veFF1c1NnZVBERGVRMlpsd0dMdU03N013L2lv?=
 =?utf-8?B?SUVKdEVTL0F5cUxkVWVnaWJJNFZZaEdRY3p4YUlSMkpCRVUrODZnT0Zha3FY?=
 =?utf-8?B?OFRYTEZ2Y2pTRmxXMEN3U0RvMXpGdXJ4SDdFMnJEVWU1Tk8wbWVidG9KbEhT?=
 =?utf-8?B?ZGpOWmxtbWJwMUlrUXhUUzdxcU1ZYVd5Vm1lZlJhNGFKKzZNc0NITVYrOGdo?=
 =?utf-8?B?eUF3U2l6L3R6R0JVN0ljQlBGVkhJMUJCemhwa04vci94bXk3THp0V0M3QlhB?=
 =?utf-8?B?bU5aNFgwUzZsKzlRZzNzSWg1dUNMdjdrTHlkaC9ZMmk5V0dndVB3ZTFsNjlJ?=
 =?utf-8?B?RXRYZXlsODZ2ckFncTVIQi9lQTlib1FYcC95L2IvODN5b3pQYTZKMGxjbjJX?=
 =?utf-8?B?dkxZT29VK01vR1FvUVVWaUdlenBzWGM1OW12RW9zdDVIUE0zdEZyN0VWNElZ?=
 =?utf-8?B?Sk1jcDlVUG9CZlRyRkNUWCtvUXBsSFBxTU5GOU95bGhqd1N5aFZmekc1c1Vr?=
 =?utf-8?B?R2dqbC9lclR0VW5yL1ZFTDhnK0JyckNFZ0twUHc2dFZ4MjBvdDJ1MGRyLzhp?=
 =?utf-8?B?OUU3NWo0blM4ckZWQkVVMHZ1clNGRzB6TjI2NFhXSHVCNDVURWQ1TlljTkFy?=
 =?utf-8?B?aFoxTCtRbEVueEJEcm5PZWY3UDFReURoZ0wvTUpaTDF0KzNqVlZ1V1V3WGto?=
 =?utf-8?Q?DFQG1375wSKYurQESoUWe/uERZazm6rluNeZWDDpju8iT?=
X-MS-Exchange-AntiSpam-MessageData-1: RLTYMNQ2JkIihw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643abb0f-48f2-4e57-d47e-08dea6aafb69
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:24:02.9573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DudyOw9Vj4LBgWkTSfPRrYQLL0kzOFnvdNfJq/jP9n/wZ1qKVfWrr9vXVSh94Kd1oamlmsJhrGxy2Q4d4tqw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

On Wed Apr 29, 2026 at 8:29 PM JST, Gary Guo wrote:
> On Wed Apr 29, 2026 at 12:22 PM BST, Alexandre Courbot wrote:
>> On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
>>> There have been a few cases where the programmer knows that the indices=
 are
>>> in bounds but compiler cannot deduce that. This is also
>>> compiler-version-dependent, so using build indexing here can be
>>> problematic. On the other hand, it is also not ideal to use the fallibl=
e
>>> variant, as it adds error handling path that is never hit.
>>>
>>> Add a new panicking index projection for this scenario. Like all panick=
ing
>>> operations, this should be used carefully only in cases where the user
>>> knows the index is going to be in bounds, and panicking would indicate
>>> something is catastrophically wrong.
>>>
>>> To signify this, require users to explicitly denote the type of index b=
eing
>>> used. The existing two types of index projections also gain the keyword=
ed
>>> version, which will be the recommended way going forward.
>>>
>>> The keyworded syntax also paves the way of perhaps adding more flavors =
in
>>> the future, e.g. `unsafe` index projection. However, unless the code is
>>> extremely performance sensitive and bounds checking cannot be tolerated=
,
>>> panicking variant is safer and should be preferred, so it will be left =
to
>>> future when demand arises.
>>
>> Review nit (no need to respin for this): this patch would probably be
>> easier to review if the renaming of `index` to `build_index` was split
>> into its own patch. It would reduce the diff, while also removing the
>> burden of having to keep in mind that `index` means a different thing
>> depending on whether the line is removed or added. I've found it a bit
>> difficult to keep track of this.
>
> This'll need a respin anyway (to merge with the IO view series) for patch
> logistics reason, so I'll make that change.
>
>>
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/dma.rs            |  3 ++
>>>  rust/kernel/ptr/projection.rs | 98 +++++++++++++++++++++++++++++++++++=
--------
>>>  2 files changed, 84 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>>> index 4995ee5dc689..3e4d44749aaf 100644
>>> --- a/rust/kernel/dma.rs
>>> +++ b/rust/kernel/dma.rs
>>> @@ -1207,6 +1207,9 @@ macro_rules! dma_write {
>>>      (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D>=
 {
>>>          $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)=
*])
>>>      };
>>> +    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $=
($rest:tt)*]) =3D> {
>>> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]]=
 [$($rest)*])
>>> +    };
>>>      (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) =
=3D> {
>>>          $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($res=
t)*])
>>>      };
>>> diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection=
.rs
>>> index 140ea8e21617..845811795393 100644
>>> --- a/rust/kernel/ptr/projection.rs
>>> +++ b/rust/kernel/ptr/projection.rs
>>> @@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
>>>  ///
>>>  /// # Safety
>>>  ///
>>> -/// The implementation of `index` and `get` (if [`Some`] is returned) =
must ensure that, if provided
>>> -/// input pointer `slice` and returned pointer `output`, then:
>>> +/// The implementation of `index`, `build_index` and `get` (if [`Some`=
] is returned) must ensure
>>> +/// that, if provided input pointer `slice` and returned pointer `outp=
ut`, then:
>>>  /// - `output` has the same provenance as `slice`;
>>>  /// - `output.byte_offset_from(slice)` is between 0 to
>>>  ///   `KnownSize::size(slice) - KnownSize::size(output)`.
>>>  ///
>>> -/// This means that if the input pointer is valid, then pointer return=
ed by `get` or `index` is
>>> -/// also valid.
>>> +/// This means that if the input pointer is valid, then pointer return=
ed by `get`, `index` or
>>> +/// `build_index` is also valid.
>>>  #[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be used to=
 index `{T}`")]
>>>  #[doc(hidden)]
>>>  pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>>> @@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>>>      /// Returns an index-projected pointer, if in bounds.
>>>      fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
>>> =20
>>> +    /// Returns an index-projected pointer; panic if out of bounds.
>>> +    fn index(self, slice: *mut T) -> *mut Self::Output;
>>
>> This looks like this could have a default implementation:
>>
>>     fn index(self, slice: *mut T) -> *mut Self::Output {
>>         Self::get(self, slice).unwrap()
>>     }
>>
>> I'm sure there is a good reason for now having this though, so at least
>> for my education: why not? :)
>
> It could, but the implementation is going to be dead code.

Would the generated code from this default implementation be worse than
the specialized ones you wrote? I'd have expected the compiler to
optimize things in such a way that they would be equivalent, only with
less code. Haven't looked at it though.
