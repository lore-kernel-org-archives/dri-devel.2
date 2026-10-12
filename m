Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763C0CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C342410E469;
	Mon, 12 Oct 2026 12:57:08 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675EC10E469
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bThBZezxVLRysFg7TiajusimFWt2vrKJirdZngvEuR2smnCzumQgHnYip1xI0MtlTVwbofsPiq+wI7qwYTI2ToXXwT5j1kv+vlMxT3ywD+4QX7J1J44iV7CU5Gts77adJ9toaA3Bh9B4zLT3TQ556BrDtpsNuVQ6yoTgacNTrU2fN2f7hVJp7Ti03tFjiPsYn4i8JofHpGy0LEKvtuZN6VC1oPp1ANs4geDGlS0bWuwOBn6n8usWzw3iY15yUcqz3dNYssqr5oEYFG9g6oV2BaXzzVKYUhbZ4WicF3BUAX+l14BGEqUAcgoRM/ZPejVuwBUebheedrrrLMcryj9S1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VrkGiuHssYXUfiB9n0YrlNmoZITIeeBa+jZA6yU7w8=;
 b=w9lBrYhGQEVWPIsP0mUu0pKpM9UwCO0QwehxkfA37r/CkANl/r8ZlF+7wxjgg+rDrDwOH67imSMqW8OtNmCvKKVRstP/o8B1rlx2Lk8s1A086cKJ+G3aFk9MmPrNiz2o8MqRWUm9WAJSaYB+MiEkZ9znYlw81RbsHi1sBts0nva7C8wEIoAT0fD0gOz9aZgXpr+Z2N40BXqSftC3OMR8v+OaECECRjsIJgjegtZlZB8zGVWyVuSHrjm3jeVUL2jPJSrtpkwbuiXfjqU+qpmBG8lnX0sYMOEELPN2Y8/6B+5IlxIryOJCaUH+9GJKJHYhQjmJsujCmVoGSru4f1uRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VrkGiuHssYXUfiB9n0YrlNmoZITIeeBa+jZA6yU7w8=;
 b=LJN89alaEgDvnG/qLqsZs9LRbgca8R6dT/ff/kYYJhasP4yMaF9rPDhMcn1jJR9scce8XwLvg8xAPFcm79oTCxVRiS4bkjVqxiD1oylwhRCSUAY6ysvop3YUBDnjT353u7m6QNEDTCwBt1mJT1IgEUTIYGX1avA/XAVFt+NC0kA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:56:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:56:57 +0000
Message-ID: <6c4e21d6-d347-4e1d-ba2a-87e17e91b580@amd.com>
Date: Mon, 12 Oct 2026 14:56:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/syncobj: fix fence and syncobj leak in
 drm_syncobj_import_sync_file_fence
To: Julian Orth <ju.orth@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20261010180711.1548333-1-ju.orth@gmail.com>
 <20261010180711.1548333-2-ju.orth@gmail.com>
 <49d4f34d-6d27-4a70-88ad-a5e939eef084@amd.com>
 <CAHijbEWpH+0M=mU3GiQWNL8b+6uTd=dK59UM=ejtviHmiRFq2A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHijbEWpH+0M=mU3GiQWNL8b+6uTd=dK59UM=ejtviHmiRFq2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: c0da418f-9083-41ab-b09b-08df28604c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|22082099003|18002099003|11063799006|4143699003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: XBAx/+Nlq80TxFcjo9RLqWNH/uGRUTBV2cnec26cqlbSQnWfqX88/HQQsZjo9s1/LVt1qz5unAfUjsOaWUY+sh1Owu0AnaZUFr22AbjZdfI9AMmyT2PijU1VbZnik9sxYYhN4gCwndr73SBWoj7lsYz6PkGMBnzZfvyE0frQip2VregIZcBO4mqhLeuwxXTL/ylOFDL/4z+qt1DfStz/Vpd7O64ZypiHeXa+YNm1kin4tZiMMw70mvb7YDp/VosczMCeNcAk0fyvmSsE43eJAVZojxnTL7a0+fik/MWJmjILKxUHtTYKeqcZnVwWLFa/gDEtoCTofs5ZB41a7stTLbz9kLuOp0oX/Mcrqd5+esz6dVWrcye0MRvcYLxcV0xia7GpajgrIytk9US9YfE8SRv5OM87eMjUFsCxPQsJIQQzyMZZ6Dzjoue1vNiPltkHuVCeRmsbEuGGE2hwqKNh4QRjKa+mJlRJ6Q1ZD9g8b163ikinFKE1Bp7c85cZV3DE/bZjy5qHVomwxV+Oouf4rUxFZHb9/NsOTq4VEucipMiquJcqCIjyXQFIYy9aObjWXHMeplwef9ZGMp8EqR6BH57DAfDpSCq0O2sJIQcHEj3e+EbikdgJN0Nk8du8XlSc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0thWjhWZXVldENXNXpDNnFLa3R1Y250VjlyMm8xNUw3NUlSMU9KNlIxVkp3?=
 =?utf-8?B?NVBqbGFsUlNDZG9oWGprOG9kR3JkbllvaU5Sbnl4dUNTbGJiSzcrMDZ6S3JM?=
 =?utf-8?B?b0dXTDFqWFY2U0dvdnZocVk4M0RYeXNIVE1PTVUvOXYrUE96OFNtWWd2aHk1?=
 =?utf-8?B?R1NJalpXeCtxcXNCcytmOXl2SE04Q21vY2x5OUw1SnVSTkZDMHh0bXdKdGh3?=
 =?utf-8?B?MkEzU2k4bFMxN2d3K0oyR0R5NlJ3U2lXMXI0djI0R3p2MTFqRzlkUHJMampD?=
 =?utf-8?B?Wjh5aUlTVWZGL29UeEVVaG1xbEc2UjdDSXNnRzlKck5pZi9XTHRLUVJjTGdq?=
 =?utf-8?B?cVlwNlVLeW5wRlFpdUlkZ1BVMndaaWlwT0FTcjRkdkhYc29Cb1NqYkZTK0l6?=
 =?utf-8?B?eDBZejdkblhCSEhwYlNzNzNjR25ZTkZUcjlxT1VTcTNGQm1SSysxNk5Kd1Z4?=
 =?utf-8?B?aXFOc0ZXRWJuanMxRCtBYzNEbkNieHBuMGlvZDNIL3VXY05BZVV4dU15ZEJj?=
 =?utf-8?B?UjU4bXpsTlJkZlMwTkhvZkdYeFNySmxCa0l6dWtrdEREOWlRNXNNQzBhdlc4?=
 =?utf-8?B?WTh6ZTFLSGZyanVVa2c4YWVJTHlaZ1BWTERpVjJoK0ZMZ3lMQy9tOXY1cGhh?=
 =?utf-8?B?TXc5R3RTRXB3L3BwRXhqdWRiQmZOellKTDBEdDhoVnh3Q1p5TjNwVXpjMHdq?=
 =?utf-8?B?aGlFL1pNY3dON2JraFZ0dDNXTTlPNjYyQUZ4WklsSnp4a29rWXdWRTk1aTg3?=
 =?utf-8?B?ZDdZaWd0dXJFenNLaUNGazRYT2F2MjRJbU1udktHb0ZzSTZuSFpFRE5GUHBi?=
 =?utf-8?B?eS9MMDNPMk0vZ0xEZmdyRHVuQUd0cDRjb2thc2Y2MGFoQUwyNEx4aVJ3UURt?=
 =?utf-8?B?Z1cxKzhiZ2lXaURPUjd2bEVUbUlJL3cyQVZFbkVCTU9XeEJBcGVkTFkvSExl?=
 =?utf-8?B?WGloSVJaMHNiVlRiV1g3RlVpNXNQcmVkZVVhNjdWZGxEUjdhOTJMTGtUTnRY?=
 =?utf-8?B?Zkw1L25tUEtueXpuRmlJYnBaUTFZV3d0VytVNG5RTU5uRXF6SjlFcmFWc3hM?=
 =?utf-8?B?cDJEems5dHNHS1NyV3BVayt5cHIzREtFbmhma3FWYXRsWUVsVnRGQ1hnUUJn?=
 =?utf-8?B?WHVpdXdYYnM5a2JtNnR6UDJDM2p2RXNRQTNRV0pUVUd1Sno2NFB3ZjhWRHov?=
 =?utf-8?B?Ulc1Sm16WFVEenNmOHFXQ1pWL3VqR09BMnY3RXEzeTIvN2pjbVRiQlFycGRZ?=
 =?utf-8?B?SkZoYUhwM2FraVFJd3daellHYUp4encyQlB6VVVQUzZnNS9lWVZNb0J6L3JL?=
 =?utf-8?B?L1RHa2RzZ3U0NlAwdjlSa2dGQmwrZU9UQlRIUlU5RTVIbWlVWS92dXV6blhu?=
 =?utf-8?B?L0FrRThrWk1BMHhiRzVYeUhqc09BbFZBRGN0UGxlQ25TMU50VVFVQ2NxTVFH?=
 =?utf-8?B?UG5xb3NjcmxIMlpjWTlSZ1VGQXNMVHRwdGRSbEpoRzMwQ283ak1CS1UralJG?=
 =?utf-8?B?aHZsZVhlVEFPSUowS3FjYVcyWllaazJpUVpWVW85bWJRd1gwQkZxdHVmd3Va?=
 =?utf-8?B?Si9yTGpIS2JGUS9zNUREZVNSSHNnbG5yMjNlQjBPcDA1Rm05UG4vRXZoY1Fu?=
 =?utf-8?B?L0FieWZiMXRiOGw5TUt5Q2FVdzRyV3F3OEllcE1ZbnhqUVZ6RU05UkU3bDdF?=
 =?utf-8?B?UjNXNlVWK1p0Q0V5K2FmSEhvQ2d3cHFtTzE2bjd3ZkhwK25Bdm13UlBFVUk2?=
 =?utf-8?B?d1FsSlJKeE5CZjNEcG9OMzRiZXhsYmNuayszN1RzV3FzcnQ5MjMzektqRWtP?=
 =?utf-8?B?alRBa25qd1RFMlEvamxYbnEyOEEwd01XNVY1eVkrSy9NTVpnczVLOEhPa3NV?=
 =?utf-8?B?MnBSWXNtSGV2UFF1SnhPZXdIREE4VmxMckFhS3QvbUxVVnRnMkplTkhZQ2JW?=
 =?utf-8?B?Wlp2TDFXRlpyNjNGTStrMUlubm1rTEMvSFdOb0ovSi9ZMWVKSTRpUWZnL1Zq?=
 =?utf-8?B?Nmc4aSt3SjNCU1hlanZzZDFkQ3Z6QmE1cUFyK2ZLRGljZnBmaGR3S2pBbzJl?=
 =?utf-8?B?UG50b2dNcGpkeUswMWZsOWlKZHRRL0JUWWhSVEJRLzFyeDhSaWE2c0wxU3BD?=
 =?utf-8?B?RVgvL0ZnRGtrdkx3TlVubHRrL29XUWVNcHJhSmhiY2lraUx1NFZwdzlPME1S?=
 =?utf-8?B?T09tSnFOeXY2RTErUlJWME9JUW1WUVBZU1NxVDVVSEl5TVVFRHI1cnp0OXJW?=
 =?utf-8?B?R3FBNmZwc296WVJ2MXQxc1JCZlNLTEY5ZEovK2hvQkwrQ0RxWlpBVC9mRVdu?=
 =?utf-8?Q?cBE+f1DluPzfgtTlbL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0da418f-9083-41ab-b09b-08df28604c44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:56:57.4934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVVuTy+77ugt7bWZM0/3gP7FvQsqD90rfd0agQaT0VAPw0M3wku5I7D9XB2yM2uO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

On 10/12/26 13:38, Julian Orth wrote:
> On Mon, Oct 12, 2026 at 9:45 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>>
>> On 10/10/26 20:07, Julian Orth wrote:
>>> If dma_fence_chain_alloc() fails, the function returns -ENOMEM without
>>> dropping the references to the imported fence and the syncobj.
>>>
>>> Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
>>> Assisted-by: Claude:claude-opus-5-5
>>> Signed-off-by: Julian Orth <ju.orth@gmail.com>
>>> ---
>>>  drivers/gpu/drm/drm_syncobj.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>>> index c23a5de27..5ca5163d0 100644
>>> --- a/drivers/gpu/drm/drm_syncobj.c
>>> +++ b/drivers/gpu/drm/drm_syncobj.c
>>> @@ -730,6 +730,7 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>>>  {
>>>       struct dma_fence *fence = sync_file_get_fence(fd);
>>>       struct drm_syncobj *syncobj;
>>> +     int ret = 0;
>>
>> Please don't initialize return values on declaration that is often considered bad coding style.
>>
>>>
>>>       if (!fence)
>>>               return -EINVAL;
>>> @@ -743,17 +744,20 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>>>       if (point) {
>>
>>>               struct dma_fence_chain *chain = dma_fence_chain_alloc();
>>>
>>> -             if (!chain)
>>> -                     return -ENOMEM;
>>> +             if (!chain) {
>>> +                     ret = -ENOMEM;
>>> +                     goto out;
>>> +             }
>>>
>>>               drm_syncobj_add_point(syncobj, chain, fence, point);
>>
>> Allocation and adding the point is intentionally separated so that dma_fence_chain_alloc() can be called before looking up the syncobj or previous fence.
>>
>> I suggest to make use of that.
> 
> This is the fourth time that someone has tried to fix this trivial bug
> for over a year.

I was already wondering as well if we haven't fixed that before.

> The previous 3 cases were:
> 
> https://lore.kernel.org/all/c715ef30-9d91-46f3-8a0f-1039f3d25e7d@stanley.mountain/
> https://lore.kernel.org/all/20260516-jorth-syncobj-v1-9-88ede9d98a81@gmail.com/
> https://lore.kernel.org/all/20260525025455.3887523-1-vulab@iscas.ac.cn/
> 
> The last of which didn't even receive a reply. And there have been
> more cases in the past where I encountered a dri-devel-adjacent issue,
> googled it, and found that patches had already been sent in years ago
> to fix it, but were ignored.

The problem here is clearly that nobody feels responsible for pushing that fix.

Regards,
Christian.

> 
> Which is all to explain why I had all of the work for this series done by AI.
> 
> I heard some chatter about dri-devel adopting a gitlab-based workflow,
> and I hope that works out and I didn't misunderstand. Because the
> current system is clearly broken. Nobody keeps track of which bugs
> have been reported, nobody triages existing bugs, nobody keeps track
> of attempts to fix bugs. Which is how 3 people ended up doing repeat
> work of discovering, analyzing, and fixing the same bug.
> 
> The same pattern applies to my patch two. I clearly don't know enough
> about the (probably) undocumented semantics of where and when which
> structure of fences can be used. Which is why I sent in a bug report
> about this issue in May instead of trying to fix it on my own:
> https://lore.kernel.org/all/CAHijbEUKuXNeSnT82P-ojOhzU5siNHjxUW+qEDOqx07Ys9m=xw@mail.gmail.com/
> 
> I would have hoped that a bug report amounting to "this new feature
> causes the kernel to spam dmesg at 60 fps" would get some attention.
> But no. The only way to get this issue fixed seems to be me acting as
> a meat proxy to fix an issue that I know very little about.
> 
> Thanks for reading my blog post.
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>       } else {
>>>               drm_syncobj_replace_fence(syncobj, fence);
>>>       }
>>>
>>> +out:
>>>       dma_fence_put(fence);
>>>       drm_syncobj_put(syncobj);
>>> -     return 0;
>>> +     return ret;
>>>  }
>>>
>>>  static int drm_syncobj_export_sync_file(struct drm_file *file_private,
>>

