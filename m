Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B83606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nU7JS+lo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FA110E4E0;
	Tue, 20 Oct 2026 11:07:35 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E2710E772
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvQuYpsBZR9IMnWNgi0bdcmEs3GBPB+cf28FC+OCpFgCw52hbBJyKvFRXdhIz9cw/1ocoi3zKt6DOA5xCvb1spAbfpnjBmfCkVj1vgKjhvcVnBShvk/UgCgAWY7T+SA8ag+ZTgrqQKr6AElkBSWvsIsQ51PZ7GrA4t93xvxkn2i3j/6tGgwH3dAbvgUwE6J1iRWLE00wie5XlbHMscofJPbi6DVwBydnX8RrWu1EDlWUyj/WJnNBuwesYdojMh7cLj+b/TP33gCasCuejnHInw1ZR0ets+IZ04IHHEMw4ecG6oWH5k5MQQ0dllKAmZ/zrmIZWsxD+XthG66Hu+Aphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfpTenJLV11C8zLTg+eSOxW3ZLFCC14tUi1cENXKY+k=;
 b=xDAE9Lywfz/xMMG4YLii/20yuUKbT0b5TqkYYhjkdMnHlsjnuriIzh9/kuZaPo6mveNBxScnOBahDRdKL/HCYTG2Go/TmKwe/VRcTQUuah4aZKjT/hzjkvanKEmZmqSGkzEvVJfdoqmYT69Qkx2qYoEWxdhnPIIrA50T4Ifu7EpEeb/mIwSE4sUedOznKcefzatmBNOg4c3FbK5RP8803u5mS3GzmuZdGG60+q/5LItKLiGXA9co+JbWPzUCA+JtH1BpwplWAL//iTLZ/m7KweVCNLbJKJ5hkUjLuNqPpHneO5yddATZ0yrOJkXA1zJF3Gpv9rTMZI2mGRH9Q1gIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfpTenJLV11C8zLTg+eSOxW3ZLFCC14tUi1cENXKY+k=;
 b=nU7JS+lokXGg73K0+kdyiP/HinriDsNOGNZZdb4YpM85jxcRmQVeLVgkr3sjyobCqZqpf+Lh54GJei0HBDnuCt7mXEXq55ox46ALCnLFz6up/5cYjeVukIw2FvzKQitUN3eosLUnIa/N1bvb212gXf/PnXsuw2GgQyp/lMYymns=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:05:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:05:16 +0000
Message-ID: <9f7b3443-4b95-4bc5-affc-0e7616a4bb75@amd.com>
Date: Tue, 20 Oct 2026 13:05:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Don't BUG when a CRTC fence signals during a name
 lookup
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 redducc <sushmit718@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261019161731.2341-1-sushmit718@gmail.com>
 <30a31088a0386d5f5d53e74632ea9a63566dccde.camel@mailbox.org>
 <4dabaef5-25ad-480d-96f6-5feb26a64e42@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4dabaef5-25ad-480d-96f6-5feb26a64e42@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4fe8a4-9a87-46c0-d2c6-08df2e9a0598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|11063799006|56012099006|261009220027099003|261009221727099003|261009223027099003|261009221227099003|261009223327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VIb2saeUVwn+iToKO3WH4kSOQNPNNwO4i8aUn9XqvFWcI8mKcQlRCx4ywPDQiMmwpLf1nfcTMhEn5PYuLNi+TfBwrTC94cBoUuiTFqaMGJjMHcj7XwIXWLYuTNrFQ/qb8X1thGIgV1oOiz6KsyWZcCIWIgsmi3ZLpb3K8qoZ7GdizaqeRu2bi4Jdpbud3AqFKY8enbOOiRIr8lv4FPGF1w84FWwV3OElv6ncYIH159+lZXaGkS4ZtJGAu+4AMl4PqRa5B7sbrmHgXg10++Ou7eNMXqDGiWI80IV+c/Ul/AuCIIbqgfWsA2Q4Q9K4fLrizNECqKThBA1RLhJKQYV0HJBQkdOgy2PYbOBZZkm3J1QdqJn7t8QHbueahCBPzN+TiWlnevXd9/zGAMofBUd4yx17WgubC6nBYd94EELDGN18GOm7Wo0vOeLH/A2U5DynH03iqY3cFOWi97E29/EpGRpu8/Tw/4x+P2WyGJoGCvx2CNOyQdFP7e6o6MHzUh2gD3+TATXkk17pJeb+fyEZgeEV9dgv1Hh2AbLkW0j4ct4euB/Taa30XP6W3rL0t/R6WMMfJLeIfAnbOT8Dt16m5F3Eup671meYee6+9Z4M88tWotyp+XBbsjd1CRUX+UdcoH4GerFTkrM5nqaOv5sX6v4Sr2edOwCeLECQyioFy6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261009220027099003)(261009221727099003)(261009223027099003)(261009221227099003)(261009223327099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnBHcTRFajVFSU03N1g2UTA0UkxjdEljWG1LMjFGR3REZXB3YUUxTk5OOGVt?=
 =?utf-8?B?eDM3MEplbGlma1R4djkxaThEdjF5ZWNPRHA5UGlZa2tFTTcxZzdMWXVrZUVz?=
 =?utf-8?B?cTFROGZDdnJzT1NUWUVBRkVKUkN4TU5MK202WkV6L0YzRTc4K2piRWxZWjRi?=
 =?utf-8?B?T2tIbUpOdHJZVUdlbmlCN1IwS0JaVFBNL252MG16eTcvcFRmcUtjSVVmdDVD?=
 =?utf-8?B?dEZ6NytEaEM0ekczWFM5cHdZWnlYRXlueVRtWmZuMXhVNWh6ODE1ZjNqUWVt?=
 =?utf-8?B?RHF3K2FyQm1nMndTaVNoYmtnUnBIcndTWDEzdDNHbHREQ1FnZEE0SWJ5b05P?=
 =?utf-8?B?TjJhWGFDOTRaVkE0cEJxbnlFTEF5NXNyWDVWMGx1dUlzWWRuMmcwMTUrc09y?=
 =?utf-8?B?YUZZb1hPcXc4V3M1T0cwak9KQ3BMNnBKOWY5akQ1R0FIdWFhcmRIYjVnbkpL?=
 =?utf-8?B?cjY2eVNRMWRJR0VkUGFkWVpIYjNXODR1ZXI5ZFFuaDlpMzBLUUZEbFp6NTN0?=
 =?utf-8?B?bTJWWXdzSlpvRkZ5bTZuNGNnM2FUcUo0aGZWeUFVSmpFOFU5OWZSdnZYUDJp?=
 =?utf-8?B?R1V4SWdETVE3dFJuMVFlV1IrR0pNNXEveXFNcHR0NW1iUWg0WE5tRGc4NEVz?=
 =?utf-8?B?ZlJYWElJZzBnSVN4cUpGb043NDJlRzRnc3BYMThDTGdvRlVad1Z5WUtham03?=
 =?utf-8?B?UnVPZzRwaklHY0hITGMvNmxZRXJnaHVIMnBsUXJhNUxJY2RoNUU1dHlKUkZE?=
 =?utf-8?B?SHJ2UENJZ25yWXMxelhUYmNlT0hGQkN0bXp5eWFYS2N6cEFLcDlwbk02SFRN?=
 =?utf-8?B?NlFyTyttbHNMQUtuNVFKSTQzSGk3bkNTTTY2bEMwcHdaVnppK0djQUdMaGJS?=
 =?utf-8?B?UWhaVnJ2VG5RcGx6QkJIa3BRTE00bEk2bjY5bzZ4aGJRc1NicWQ1dnMvVHEx?=
 =?utf-8?B?cXNML1lIc0lsSTBRd2NEOTJSYXh6RkNNU2k0L1RhV0doY0lSZ2R3TWUvMWxN?=
 =?utf-8?B?YWR1emRuaEp4Sjh2SGkyN3lnZHVCa3E1SC9mSlZXV1FjVWErTTBVdlRNTi9M?=
 =?utf-8?B?bGlZM2dqWjJwNXlaSThYVUdmY2hKcnNSVnZYUkhJZFZhKzY2ZWtyTXkreStD?=
 =?utf-8?B?QUNROURLbHFxcVFvVFF4c3l1cFpkcUNOakFkb2F1ZEozYXZwdUpRV09GOW5u?=
 =?utf-8?B?VFhMUXRrNkxNb2gzd1ZqOE96N3hWNlJqcStRWVVwNTRWYU9VYktrUkVrUTFC?=
 =?utf-8?B?VjExRkk0OUVFN3pLTGpiVDdKTVJCV1YrZGtpamRRSFdaeUo4dmpQWDJKYlhm?=
 =?utf-8?B?R1lCMW1kS3JCUk5IWi9kMXppb1FncXpmTzlTQ0owRTAwWjBxUXEvVmtQcVRV?=
 =?utf-8?B?MUUrbEpzaHJiQnNZOUIrTC9QaXNzbThKVTdWYVVhS1ZiZ211VE92Y1F4cEVO?=
 =?utf-8?B?ZmNFTzkxWTVZMW9HRi9IYzFKYTQyTXI1VmtYUzFueGN1VWJ1R3hMRXpiMDZk?=
 =?utf-8?B?ZnZmTlpCM2pDajUxUmZQKzZ3dmpFYWNlK2hiRENiWkIvT0VGRVZ2OGIrUSto?=
 =?utf-8?B?M1FmaUcrWXlkVTc2bStSTExmRG1YclRwTkhBZWpPT0M4NVdiN3Zpb0RhYW5Q?=
 =?utf-8?B?ZUhleXVIYjdCMzNualpKam9NeU5PeXJpRkcwWTRTRnF0aWRjcDQxQXRvZ0pz?=
 =?utf-8?B?emUxNTAxQXJ3eERXa3VLTGo2MFVTUzljVGhndjQwVUlWdTg2YjcxTnJrUWEy?=
 =?utf-8?B?ejZmNGdJRHF2dkV4NlhkanlCOXlXVWdzVTk3OEQ3UjlZY0NsUy9KVEhZKzRr?=
 =?utf-8?B?MkExelczV3BVWmZwYmh4QncwV0Y0dGtwTm1WNmd4SFBxdUVUUndEZjl1UU13?=
 =?utf-8?B?UzA4ek9sSHc0OVd6SExvbnNaa1VZOFkzVVF5aVFJeEdzTGhjdHU4SFo2bENO?=
 =?utf-8?B?WGY4STErcXk2aWcxZ2pQaGF0b3k4a2RXMCtML0o4U3BIeWdjaHQ1TjV2NTdV?=
 =?utf-8?B?dXhKQTJuak9DUUZvYUpUMWxWSnJ1cXNBQTVQNXp2ZGZkcjhLU0JMeU1VS1VQ?=
 =?utf-8?B?eXRJR1hJZmo3T25WQ1d3R09UNUpuUjZVcjdIT1lJTldrUEorZlljWXJTV2tI?=
 =?utf-8?B?Z1pzRHFJeXFQOHNHa1RueVo5bjJjbHFpNVlQMWJza3MyaVRZUCtDYUxXZ2ZD?=
 =?utf-8?B?VjZPZzBoc1hBZHVFdlFSZTVBTm9DNnF1eVg2VkpRNE5uVzJ1MDdZYjh6dkIz?=
 =?utf-8?B?Ky9yVzFxMmJpM00rQ2Mwc1FEYm5yWUxmbFZzZCs0WXV3ZGVuWUFWL2NJUVdv?=
 =?utf-8?Q?8sYnUDpEUS+lb2RyzE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4fe8a4-9a87-46c0-d2c6-08df2e9a0598
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:05:16.6441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmBz6FcE8uHU/lpxYYSapM/wMJM8EiVWgZzYzIt8QgnyHpmRKIOSbTR0ZoYeSHkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 08:57, Tvrtko Ursulin wrote:
> 
> On 20/10/2026 07:53, Philipp Stanner wrote:
>> On Mon, 2026-10-19 at 16:17 +0000, redducc wrote:
>>> dma_fence_signal_timestamp_locked() clears fence->ops on signalling when
>>> the ops have neither a release nor a wait callback, which is the case
>>> for drm_crtc_fence_ops.
>>>
>>> dma_fence_driver_name() and dma_fence_timeline_name() load fence->ops,
>>> check the signalled bit and then call into the ops. If the fence
>>> signals between that check and the call, fence_to_crtc() rereads
>>> fence->ops, finds NULL and hits the BUG_ON(). This takes down any
>>> caller of SYNC_IOC_FILE_INFO on a CRTC out-fence, such as Android's
>>> surfaceflinger, which hit it on a Snapdragon 8+ Gen 1 phone (msm).
>>>
>>> The CRTC behind the fence outlives it, so reading the name after the
>>> ops were cleared is fine. Only warn when the fence carries foreign ops.
>>
>> @Christian:
>> We have now seen several bugs like these, which is one of the reasons
>> why I believe that RCU is the wrong solution for dma_fence.
>>
>> I present another rework RFC soonish.
>>
>>>
>>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>>> Assisted-by: LLM
>>> Signed-off-by: redducc <sushmit718@gmail.com>
>>
>> Reviewed-by: Philipp Stanner <phasta@kernel.org>
> 
> Hm this looked familiar so I looked around. There was an earlier fix for the same from Andre with msg-id 20260721-linux-drm_crtc_fix2-v3-2-afa8c71506e6@linaro.org which seems to have fallen through the cracks.

Yeah I was also wondering why that patch was never pushed.

I will take another look at this.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>>
>> The Signed tag btw. states that you have the legal right to push this
>> code upstream, and that you agree with the kernel's licensing. It's
>> uncommon to use with pseudonyms and lessens your personal accumulation
>> of prestige ;)
>>
>>
>> Philipp
>>
>>> ---
>>>   drivers/gpu/drm/drm_crtc.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>>> index 63ead8ba6756..1dbd0e9db536 100644
>>> --- a/drivers/gpu/drm/drm_crtc.c
>>> +++ b/drivers/gpu/drm/drm_crtc.c
>>> @@ -158,7 +158,13 @@ static const struct dma_fence_ops drm_crtc_fence_ops;
>>>     static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
>>>   {
>>> -    BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
>>> +    const struct dma_fence_ops *ops = rcu_access_pointer(fence->ops);
>>> +
>>> +    /*
>>> +     * Signalling clears ops, and can race with a name lookup that already
>>> +     * picked our callbacks, so only a foreign ops pointer is a bug.
>>> +     */
>>> +    WARN_ON_ONCE(ops && ops != &drm_crtc_fence_ops);
>>>       return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
>>>   }
>>>  
>>> base-commit: 6a56f4f29711dd2da49f03a5b99ce53779e638d7
> 

