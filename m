Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4290C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFD510F1F2;
	Wed,  2 Sep 2026 13:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HmjjGMwL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D598C10F1F2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXyG0uTz6S9OsZO64Fehqceqlg+zyIjiOks/F3Q+4gwplmYVWQEO/vCCgpf5/fveqGVtHR+T9EvSMTtbqu0nyaPvACJ5nHT+mh1VN3pJg5qS904BScKDBu0ff63bH3cKZJ8TTg4QEvJomuKN7hMyRfqntd1Xc3P8HNucmyrx/hY6qHt+3otqrQ/LwIe33/XMbSaEFaS3vL2mPq/MzSbU6lIfBc99/7Lf/QCg7TkXOVXLR6StJCu/A/XcGNUQH0Ugv1J7ZV34g2/WTPO4K4Cx8dFC2kVUFJ4aYqzn+F5fB/1gI29xSIg2XhDKx4szEs9BgHlOoVqcSIewLvv8EFsnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAFv8gzcBR14sxsplWYcc1hmN+x16e94n2CRnTpPlLI=;
 b=aVBSNjkCyYtcQHd1G9LPNdz23Uow9cgkMcIaJShh3IjPK1eelfCIyhRr9xLY1ms8BUCvI3i2AVcOXrAlrRHi5jjurUq8DITiDXLGEL1G4rBUq6Fp0toifz3uywsK4z7PuRdYZhOqMgOyN9MyeTrT5bLI5M+EQHqTOATOTQmgojwP31ji2VwIuzsWRK/NettyTDwgwazcuzI6YYWJ5KS0KsPjpKd74xX+j8iLT3VfZUeMkg6+MZnfAqQJhK4kLeiL5WjSFaXZsiEu9/c6VZ0tZfMB7fMygYUYw+8drzI/gvp+yMbuXBLZ0wcRoR4c7w0qXjrBnc9O3detXjBgmvFYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAFv8gzcBR14sxsplWYcc1hmN+x16e94n2CRnTpPlLI=;
 b=HmjjGMwLe/KIOkIYOmAaNjsANLgiToqmIuGUyZOxxvJXEqEypPzFXcNz9LNe9IfTtHpDsIoR0gu6JNZ+vakcC2DrpPj2Z5EQZi9v7A70aAHxEbVkVlQgz+LIDDaW+qjVcTNv1oxz4HZ19Wk8Ei/88k31WtfhvptUcj4vsO00k10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:38:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 13:38:28 +0000
Message-ID: <d213e2be-7f87-4864-8842-ecc1b7dabb6c@amd.com>
Date: Wed, 2 Sep 2026 15:38:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?B?6rmA7KKF7ZiB?= <malhyuk97@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
 <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
 <b8f98b9e04c9999008bcdec270b14247e3cd18d0.camel@mailbox.org>
 <619669b6-69ea-4aa5-b91e-b29cc788e335@ursulin.net>
 <95e34a8771fe827e134970a3580ceeb5f661a40d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <95e34a8771fe827e134970a3580ceeb5f661a40d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0410.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f00037-69c3-4d0f-62b2-08df08f77871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mERbFuokEXPB4Ky9KLWPVDhXIxXwYXRCAuwPaZs9XeKoj0Eiv4rqUO4NDqHSxjCgeqBZOiJU90x3i/FJlASTbQCSInIcFKoMzY53v74COAVIFF1oy4I2Z5elh9zHcOXTj42SkxLlYvyCvEvgjvHqwk23Z8QjBnRzqIOwjV0LL0abQoG32UkJNOy80wmASBGNxW3WbonctebNrfKqt+NEpKaWzIP2Zr7oMB6XHF7H8E4ADKoO+PZV5kVp+ebpIF25wRkIvWArS3YZ5uyP+gtn0zQNuQVrbzqJBjJsgBofR7TXoeBzaK1psxbgIusWVbpDDOHFRIxEoG4P05jidbqq+Croi7J1L9sQNDR72saaxEi1ndsU1qNjMB/gtyF0m5dz3ivDW//Nr+OQ8/Ha3eE1+Tw7bB2DZI7ZQpJjoSlxr6nmFasfsRbK8HRVS8VpyN9NFnwo2MeyN5VOnRjG9/TAd6BhhbAFqyp5FYwfZzGJMQEiVQxNtA2C+yb8Sb40JeM1QU93DenqKBOgAeXhCVUSuK4+BWz4jnEYtFshjoai4ranpzyJ69tHWy09FAuIQS+RZQZ3FRm8HovCnRchCqtAaYi42OU+aayCqdOsYAeTWPjpzk1WmtYDxsGg2EwTvTzST4Ag3HnD8SpVVDFRLiw3SKYvKEAaIx/6kca84azwzIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRjYkIxZ3hhSjhlaDZYRm1hNU9ydit2RFdOeUkvWDErVndWSUlObnBZSmNC?=
 =?utf-8?B?ZUE5NUNNZE00cEtLTkk0SE5zQ2NBL0dSVnRqSzE1VFkrODE5dzNpbFkyNUtj?=
 =?utf-8?B?TlZ4N0hpTk1rclFNVFZJWEVTZWY4N0Z6aENJNDBKZ0JqQUpqUXd5MlJZVytl?=
 =?utf-8?B?bmhpUVVVckhGZEU0SFNvdEh2d09BN2trNjh5RkdkWDZ3ejFMSm1nWFFCTHBr?=
 =?utf-8?B?ZkUwQ2pQVDhWNmtINGJHajJobHJSaHMrY3YvQkk4WmxLS3JHenpMai9MOERj?=
 =?utf-8?B?STM0WkJoaVBKSWswcmJNbCtrTStZbWZqZWVUTkhOLytVOVZZbGMxeXRRVnhs?=
 =?utf-8?B?aWtLS0IwdHZDSzNjcU9IK0gxSVpsTUxFWlQ5UVptM1ozN2ZvR2dIazFNR1ll?=
 =?utf-8?B?WWwwYjQ0YkpsRE0zQ1RETnJTeEl6N1crQzJRTVc0T01wZDlwK25vSFh4YWN4?=
 =?utf-8?B?YmhWelRhbGFkNHQzVXlISmxwRHpRK1lITzUzN1hiS1hZSXQycG9SZ3pYUHQx?=
 =?utf-8?B?enBRRnk2Q3diN1J1bzU0OW16QmhCZXg4blhKc3BtQlhwZnR2T1JOVlN1M2xD?=
 =?utf-8?B?VXdXUnlpNDk5OUJlcDFnQlE0OTV6V3NwMGdtbUNtMFhtanVsYWt5YTVQRXNr?=
 =?utf-8?B?ekI2cGdDK3htNWVhbmRhdnlnSDZtVTM2dUsyNFJLaUZDaENNclhrYTYzZjFq?=
 =?utf-8?B?TnRkeGE3bHBRQVFaMXdtaUZySzNrd3BzbnhITStvMFdxdWNzUzR6T1JjUHB2?=
 =?utf-8?B?R3czTEdSczhtcCtNUDEvRzl3ekhJSGNYS0MwcHllMkZZZVk5TFNBWkZpUWVN?=
 =?utf-8?B?N0pUZjBiN2IvU3QrckxEU3U5RUp6bWNyTzlDaFNOVThFbitGeTU2blVvZHc4?=
 =?utf-8?B?Q3pNRzNWS1lieWc2RnF4cWpuT0kyRy9aQ0hUb3JNLzZySloyK2NXWGRxNld6?=
 =?utf-8?B?Y0RWQTh5dlNNMnJYRHg3ekpyZXIwRHB3Nks5YVF2Rm4xU3hOZmtzNFBpRGVQ?=
 =?utf-8?B?VmRWT0llWkpNOGNnUUhuT0d0cFlBNklkOWJiN0xqSWkzSkVmVGREZGtyVjFI?=
 =?utf-8?B?VDZiMFV2Sk1kSFp0eUJVSUNVNE1lbUNFc0o5QVJ0eFBHRDdGMWY1ZGRaTzZp?=
 =?utf-8?B?LytCMDdNeCtDR3VraTNrVHJ1MmZSRE1TWkZGTmgrL1RNV3V0UXBIUjhJdWJT?=
 =?utf-8?B?WDlpb214ODVHSk1EeE9PVXhSSXRYWm9yeUNPd1JDTUpIOXI0YkpLRzFoN1Qr?=
 =?utf-8?B?YmZGd05LQjdZOGcyTTh3U29PLzZQQTNOK0pMNndkTUhCSkFOZG9xbldzbmk0?=
 =?utf-8?B?NUY5NDZSdXV3RndNWitSZ0xJcDIzV1ZIYnF1cGtZYWowZ0U0NzdlSEJLOFRQ?=
 =?utf-8?B?N3JZMzFuM2RpdVBzQlpLK0QvbHplcWlIUHFqVGFVU0c0S2tmMmRKdXExT0Vq?=
 =?utf-8?B?VnpxdXBpWnhsNkhKRFRnTTg4UXcvZEVNZmZ0SVpuOVlTVzU5U1pPaStRUUhS?=
 =?utf-8?B?TEhvS1l1REVZM2xnMVJzQWZOVWxObHVBb2RXcCtqbVVpM0pFNGhjbzRvSFBu?=
 =?utf-8?B?THlRMFkwYm1hbkxINGVnZDNGRU8vdEtEN01DalNvWmk4TU95ODZBdGJ2Rk9u?=
 =?utf-8?B?bDVuNzhWdWRzWnhwRVBjWGdPTXJST2Uyc0xjbzJlMGtqd3lEQXJlRFpZTDd1?=
 =?utf-8?B?U0hXMW1peFMvc21qRVlRd04vcG90bDNUd2pvdnFtZExpREYyUVpzNmplQXNV?=
 =?utf-8?B?aHZaeHR3Y3lSTEFWd0RUOGw3ZHJGNnQxUmg4Tnl5YzlrODI3YURKa2Q3V1h0?=
 =?utf-8?B?ZFZDdEEydjBneDVhSmQzanlRQWNvcEZ4TDArbGR2ZXlLOFhXMisvTnA5Qjll?=
 =?utf-8?B?NjR1dllkbWloZXNtVWM1REJFZnF5ZnEwWXFnUnc2KzZSdWlPaTF6cFJtZHMv?=
 =?utf-8?B?ZFhyczRycjJwVFk0SVYyTjJGN0Zoc0swZksvbHE3bWNLcTBRNXBWYVZINktV?=
 =?utf-8?B?L0lYeTVFSEV2Qy80VTNlRGw5Qk1razBaeDA5Z1NlVEJsaURKWEs2TXdTUjZZ?=
 =?utf-8?B?RWVLM2l6ZGdlL2xkdnRFY2pwNG9YbitMTzlsazEzM0FlUHo1YytvM3FjMHBw?=
 =?utf-8?B?TGY2SmFBM1cvRGtYeEF2QmpsSEYyRlc3UXRiWFlyM01wc01POTdGTllmSTB6?=
 =?utf-8?B?cE5mbFk4Y1V2bFBJYmhOczBEZjlLNjdCT2pzUFgzQlFBR3d0anFMZ0FoTHIr?=
 =?utf-8?B?QnJDMzJOb0tzYTZpSHl3eUt2VGhsR095LzhKRkVVV1Y5dTdQZ1BsWGxvTlkz?=
 =?utf-8?Q?ECAzPYgA2Ic3Kr2ELp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f00037-69c3-4d0f-62b2-08df08f77871
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:38:28.2383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh9n+X0OclPtnkhNaWiQOVTHRjyMyr80Y9Z/EuFMtuRaTt5ArEKUDmAc/2N8jsqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

On 9/2/26 13:39, Philipp Stanner wrote:
> On Wed, 2026-09-02 at 11:20 +0100, Tvrtko Ursulin wrote:
>>
>> To collate two replies in one:
>>
>> On 02/09/2026 11:07, Philipp Stanner wrote:
>>
>>>
>>> The issue here IMO is that we are discussing working around an issue
>>> that actually stems from dma_fence not being consistently synchronized,
>>> notably because of the ops->release callback being implemented.
>>>
>>> ops->release is de facto deprecated, precisely for reasons like these.
>>>
>>> If we could get rid of it for sched_fence, dma_fence would take care of
>>> the decoupling of the name callbacks.
>>>
>>> So that appears worth investigating from my POV.
>>
>> I completely agree here but I am just not sure how feasible that would 
>> be. We may accept to live with the cross-documentation workaround at 
>> least as a start since even if feasible it could be a lot of work to 
>> change sched_fence like that.
> 
> 
> It should be enough to remove ops->release for the finished_fence for
> now, since that's the one typically (always?) shared with userspace.
> 
> All that release cb does is drop yet another reference.

IIRC at some point that change was part of what my patch set to the drm_sched_fence did when I came up with the inline fence.

This was far from completed / thought through but might be useful digging that up again for a start.

Christian.

> I think it's worth an investigation. Maybe 김종혁 can give it a look?
> 
> 
> P.

