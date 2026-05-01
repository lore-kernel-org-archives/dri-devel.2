Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC81CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 10:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAC510E1AA;
	Fri,  1 May 2026 10:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pcM3uEAs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE64C10E1AA
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 10:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjBCMyTFrlKQBavT8AgSS1xOWikV41ss2FEnAj11ik/ayKhIuSY5kXkEE4FdW1B6FWLzp9sEDEOjB0nV6WyBdwQm3n9PmAO989E7h+3rCL9nxpMwbowx3hAa0BMHLgeLCgdg1P5d4yOpaTLoDANPu4/bCi/C5bTb8rxJVo+LtCX9/+ZWODBRchwKfo4NgRE3v0MtFD9mzo3kucSRz8faid2Iz1ucvzwqHKfHRqGo3FjIyp83zLqt7hNusELHGxJubO2cAT2o9aprs525rvQKq0zlMJT1qAfqZVciLu71yOIzQi0VAarhlL6ACwMZjxIlypWcsrSn+GRNCNF0uRnchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU8vBMoNr590np4u9ihfBOXt/MYinYUE99JHdPPs/K8=;
 b=cNTsaeIh219z14kWhhm4rXNBXQtYpuJJNCU25lc5Mb4Umce45kzXfCcniMV1T9kfem65o2ZZYBDG7ekyw1VRvX3XqzU0Lvu6B+qLx2kTzjSgoLWSP7J73pTzKF8vSI+iPD4jZCT7/hUMzB6YateHHqPcxwBhVQmIF1UGfn6UwHJROUvaaDWKPOaPj3TcN3NqrFK8Lh6rhUc+Gy3Hvcb7ecW1+3ABHzfPQRnkjwDGCwqjrO+4DW4FK/CUEXWXeGxz+d4him/I5BLZq8zzrKNtoOJ76R/1vuHWGawxS8r68mTjOnaqu89yN1uz771FpghA1SWpJ6ki1nmW18C1JhrO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU8vBMoNr590np4u9ihfBOXt/MYinYUE99JHdPPs/K8=;
 b=pcM3uEAsL7fZPPZfpXXpzlj/vQcX5XFo5CiKP+shES+QfLFkPDnznnhRWC/Ob1B4hdvT7aDZ5LCWTGHYmP2oxNwN2KslaVzZC3UdvMzIhl+dk0LYv5rfKWOLifFQ8uiTO4qT02+qH0B6taBSQca7bK0ZtpeE6nhVcS8RZ1znwO6da5VgbrP4C6PtfYo2xa3i6/I97Qb6qJWcRdNDLVxt0LDmp9fjJRyNHscTdQGRVgZRsgL8n+aSMoeO68kfy4f2HogcOcBYQuTCZQdwkMar39WrUqxaIfDJec0XfUwPwSfOyJXlaX3GNrvImpmAvrMtcAgkQ0tOfaqc/46/c9zU4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 10:50:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:50:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 19:50:35 +0900
Message-Id: <DI7A6EZFQCV8.L8KA3WNETXYW@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
 <afG7Np4Lmv9k7D1U@google.com> <DI5LUYIPIYB5.1CY8G9M7R5W6H@garyguo.net>
In-Reply-To: <DI5LUYIPIYB5.1CY8G9M7R5W6H@garyguo.net>
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ba061-a084-4bb6-b265-08dea76f7ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DA5XWw2GcaaF0ddqTzmVvRXI6iE8AF3H69WG0MnDwJict/i2iyFkn8PDqP2ueWih7BuYwhZH3IChzLumLjLaqOT3IXc6WBggGCoEi2XBwSue2cZ6KL4mYjKRCLK/Q7AEFwm1oRcf+aoNzjUlW+X2GMZpWs6B53RI1yBy1C6ngc0i/ukxspyv00TjYfu2+so/hipb1pFybGleJuAQiW9GQmZVwzKKRcq19QE6fDu4XF3hBj5+SfAzVvXJrtUAPmCExIhW7aGoStW2KEDhTO0G26UBB0ocoTMjINOzO54bezin9DckVXN/bBJvTYZ1aaCJLEzhxtLiHtw3xWpXqdlEBwZ+Ci8Ru29QPFAxs9MGg/uCCMbjzf1sRkfno7wWIsc46N8oweIfZdKpaZGHMaN9l5rioDIjQCQakS3Qkr+CaChf+nfkNOaEP6dNzpn5vO513MtYRO91kQ9EHdoE2zhU7mPgo0DXesp1RoPV+XJcQZhMYV8pt8wg1VXNvW7U4jiDtPEIShJB4CTViCBgRDS7oSsfne1q6FpPO1Zg62RHtsYa2shkKKyxfIhGk0xZxhWx4oMLKyhgrx0VdKB/oW8t8i30yksrkQKp5EB4vdPkFeQzNl0VX8lB9m6vM9P/M1L90Ay0DGlgPJibw7rw9oJbZue9APxFHNweiiBd9MWfmHS80FfjonAlwH5SMGOts+Lu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1IT201UWQ2OEZzVXZ1dDdXeGNNUjRycDU0cW5yMXJEMUtZR1VIYWczdkF6?=
 =?utf-8?B?ZmxSRVBKck85azZmRlVQdnk3YWRJbjZUSk1yVzlwTHI5dmtmYTdDQm1zUzFt?=
 =?utf-8?B?bm9HazZrMHlwU1cwY3VxZkIyS292MGxJZEVBS21pRTZ1N1dmWVR0dC83cmIw?=
 =?utf-8?B?K211VVh1SlVjRW4zVS9sSnlmc2o5Z0JmbkRkM2pFR0luSHB2Q0hiY2R5aFFw?=
 =?utf-8?B?dmFuaGVmT2wrTE9GTzBURmFUVUorZXUyajdzSnhCOEFmUUtNaHZlVFZEM3RX?=
 =?utf-8?B?ZVc5MVJIeSsvY0JWbWRMWEJzNzdJMGJ4QWlXaWNObEJqVUhtOCtnL2hZdC9m?=
 =?utf-8?B?enpvUlpvNjFCZmZBMkFMRTdPeis3QTlUYkVvOC96bFhjT096UGhJT0pmMjlL?=
 =?utf-8?B?bUtPc0FOaFJJblNwRTBXSWs4WUthcEVINlhMcXA0M3ZjMGxlcmVFdU1kYklz?=
 =?utf-8?B?alBYclliclhFSWVQS3VWcElncnZtWlRBb0ZKMG54RTQvMENad052L3NmelF6?=
 =?utf-8?B?VTlqN3REYmVWcHdnZEFPTis2SGFvalNtcHRPQmZabGpWY3QvTUJwdzdEYk45?=
 =?utf-8?B?TFpuUTM2bW1zRnJtMjJEOWJRSlNTamIva05mZW5WSHUzTllwZ1JCcEVESVc3?=
 =?utf-8?B?aGRKZVBmaGFVUFo5V3F1NjcwaWI1aDUrWmpMeDl6NmlXWHA4MnZ4RHlFUGpl?=
 =?utf-8?B?dVA4QUtrdXlzd0UwN21xcUorTEhTRThoUGJNMk9ZbFhtVjBvb3FOdmxKVEZ6?=
 =?utf-8?B?Qm5hZ0YvNUI4ODgwcWpTWHBWKy8vNy9vMUU4OG05UVFVRE8zMG0xMFNqZ1FD?=
 =?utf-8?B?dnM3R3NZRWVMNWVsVE95ZVRqYWF4Y29WSUxuR21mcm9XWWt0VjlxZ1QzQWdh?=
 =?utf-8?B?UlVwRGNPdzdJYUFDS0hZZ002MDJRTCtJQ1p4MXJrU1BRcTVKbTFCRFJMMW5w?=
 =?utf-8?B?RmJlcmUzbjAvcFkvYThDUDJLOUppL1FsSnc4MmloT214Uy9ub2psUzNMTGZw?=
 =?utf-8?B?UXJ0TnFablZCb0lZaFc2VkZVSWFOZHFtTUcrby9YdHJmNlNyRnRSY3huZmpI?=
 =?utf-8?B?Wm0xOHhHekNUclBYL0hHeVJxU0ErUHNjcEtqaXg0K3FpVUwwUkNVY3RmcTBs?=
 =?utf-8?B?bHdGUmh1SjFYSTJhZXNrWUtKY0FsRkZxTTl6NHlVZWxDZkt5d0FPNHcySlJW?=
 =?utf-8?B?U3JSWWoyR3V0TWxaZk5UWVpOcFg4NFdaSkkvZ2lOVVJyazd5QnI1ZXpzRDZU?=
 =?utf-8?B?aWJDTXlCOXBzUGVYeExpWGQyNnlIYTFidHkwclphWkxZMGdEYlh5MVIzVmV4?=
 =?utf-8?B?Y05Dejd2ZEowU0ZwMWZBL2xrSk9yZFoyRER5NWJ5Rm9KOGtGZHNqcXM1VUtr?=
 =?utf-8?B?b1A3Yi9NYzV3bmFIaEwrQ2k1NE50OVNqQjhIQnJkMTI5TkUrU2tWUjNCTHZN?=
 =?utf-8?B?VEF1MFgzdEpwejlpT3UxRkovT2ZzU1dWdnpTcG1oUVRCb0hxSW14aTlNSzgr?=
 =?utf-8?B?MUZTQ0ZBZ2VZblJMVW9WaXBQbkF1UitkQ1RRa2tMdlMwSXdGZ1A4S2xhZnhn?=
 =?utf-8?B?ZkN3ejlMNXZVVGlOMmhkOU9ZY2VYVDlacjBWVmtCUWRwa1BRbzRoUHdRNzdp?=
 =?utf-8?B?TVJuN0ZXU3hlcW5ZWTMyM3BLdGJrZjVCS0JrNjZWbjFWNjRqZTgvTmdhWTlW?=
 =?utf-8?B?ODczYWhhV0x3RVpWTmp6cHBVSmtKUU9lNHBmemtlbGJSYk41ZkFVeUMwMDd6?=
 =?utf-8?B?VEJjcU5jRVhraEVjb3J4WXZjQytOdFJBN2xtR2twZi9pRDZPWFBxbHZVUHYw?=
 =?utf-8?B?UFFkMHl2aUFGOU5id1dGcUpXN1Npek0zQlV1eU5CZ2xKY2pkQ2w3REw2Y1F6?=
 =?utf-8?B?OFdWUHNGNHFBc3drQ2diWUIwZ0ZmWVMwSUxqTGdBd1Vic01uTVdPZS9oY2x2?=
 =?utf-8?B?MEZQZ3l4WUtvcmJOZVVJZk1YSTdIbTJ4ZnVmUENsTG81dzhUQWoxU0lBUXll?=
 =?utf-8?B?bjZaRTd5T2grL1hZdWhJY2VDNXNyU1dUKzJFK3JyNzVCcmtrV01GU0JONFYw?=
 =?utf-8?B?Y0wzVFVSNzYvM2x1NFBnKzZjalhBRXkrRHlCR21XRWdXQXNXR1JTU04wckhV?=
 =?utf-8?B?RHB0RjZFYjJjUmpVMS9UOGRBVUo1Rnl6VzNldjI1YkNkR2FWeGVJRUdDWW5J?=
 =?utf-8?B?T25RZkZMY2hMZzdHNlFocEFoNFpkanhRa0VSdkFoTXhGZXJqdEIxY1IyNzBS?=
 =?utf-8?B?c0dKZUYxNzFYcGkraGplT1Y1ZnVmK0tTS2dMeEpYd0FNZUFNdDczOFFySHlV?=
 =?utf-8?B?RjVDNzF4WXJEdXQyZkMzOXRkTXZWL0VIQWZnT0UrWU1sa2V0ZCsvTEtOVDA2?=
 =?utf-8?Q?onNVpg+MCMbE3rwrgLmbkOzc4adwyxuJPLuqZXy3opxs9?=
X-MS-Exchange-AntiSpam-MessageData-1: 0qiNl6V8eX47bg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ba061-a084-4bb6-b265-08dea76f7ba7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:50:39.3938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hdEvYitBsFGF/su4J0WM1TeZX0O4NKkaL653zmmchtM1YS9wMQnt8bMlvHfirjU1YewRUqf0wnpq8NzWZSKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

On Wed Apr 29, 2026 at 8:34 PM JST, Gary Guo wrote:
> On Wed Apr 29, 2026 at 9:03 AM BST, Alice Ryhl wrote:
>>
>>> @@ -133,6 +140,10 @@ pub fn new(dev: &device::Device, data: impl PinIni=
t<T::Data, Error>) -> Result<A
>>>          .cast();
>>>          let raw_drm =3D NonNull::new(from_err_ptr(raw_drm)?).ok_or(ENO=
MEM)?;
>>> =20
>>> +        // SAFETY: `raw_drm` is a valid pointer to `Self`, given that =
`__drm_dev_alloc` was
>>> +        // successful.
>>> +        let drm_dev =3D unsafe { Self::into_drm_device(raw_drm) };
>>> +
>>>          // SAFETY: `raw_drm` is a valid pointer to `Self`.
>>>          let raw_data =3D unsafe { ptr::addr_of_mut!((*raw_drm.as_ptr()=
).data) };
>>> =20
>>> @@ -140,15 +151,14 @@ pub fn new(dev: &device::Device, data: impl PinIn=
it<T::Data, Error>) -> Result<A
>>>          // - `raw_data` is a valid pointer to uninitialized memory.
>>>          // - `raw_data` will not move until it is dropped.
>>>          unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
>>> -            // SAFETY: `raw_drm` is a valid pointer to `Self`, given t=
hat `__drm_dev_alloc` was
>>> -            // successful.
>>> -            let drm_dev =3D unsafe { Self::into_drm_device(raw_drm) };
>>> -
>>>              // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_=
dev` must be valid and the
>>>              // refcount must be non-zero.
>>>              unsafe { bindings::drm_dev_put(drm_dev) };
>>>          })?;
>>> =20
>>> +        // SAFETY: `drm_dev` is still private to this function.
>>> +        unsafe { (*drm_dev).driver =3D &Self::VTABLE };
>>
>> It would be bad if this ended up being a reference to a local variable.
>> Please use `&const { Self::VTABLE }` so that it doesn't compile if this
>> occurs.
>
> Self::VTABLE and `const {}` are both just constants and there's no differ=
ence
> here.
>
> If you want to guaranteed static promotion it should be
>
>     const { &Self::VTABLE }
>
> Best,
> Gary

Thanks all, I have done both of these things (const{&} + stack alloc).
The `drm_driver` struct is 200 bytes, for reference (w.r.t. stack
alloc).
