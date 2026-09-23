Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE81C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4ED10EB29;
	Wed, 23 Sep 2026 15:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0VMJDPo2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6F410EB29
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l65GZEdAHzfctijuN1VwBwmsWuEI/B8XgywtKGznnlw4SVLoBofHaSA70Evb5Y9e+ME+FBBySJLAnJXh2Uev3osnNrCVXDFDz10sWcaOkQpZDLX3oj7bR9zVAKw9VnDfFOjblfFpk+XlBF8YI9Q3XnThksvK7bfla+ALmRqZ4uKLHCf2uvzToXP4HzQk9lUtYQEQc6PyJ+9LtbuO07+VqBhhpTs8b2/KxQfjES0A2Krjv6JDkti3v4eSYEL5n0qJs3lif7IRDn1A9+d0Z/qzdQN0nRDbLo9PGFV8/qTwqkSlYmj/jKjUZ50vhUZNIwzlpXfFmfAWplXJ928JSJIN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lslTJMbaoWGmu5jtc143L8t4cb5oNX4pFRUUXPOy3+M=;
 b=yl0CBHk52veXXoSIvXk7KKe+aJhRs14Cmu2JcRU8bDTw4fYp0pD9XfBQiUfmwhU58AYFRox6Gj7z7Cz7MZQkRP/Z+4Tvzmmf1txySOXdA7FWtsBlb+XbaVu5WJhYNLjJKvg2nBb3t6oXnrUkzwXTbU5yqwuVRIsP5ZvxJy3gzrLlwNrGlPg5DlQnRfT4O6/6uAc7UatfW1gkQ61islEP6JqHbKdcsZBVsb4PTkopLEhbIf/Kg39R3+0Ko1rlU9v4Er21Gohbhzff2o8EUJxtQGN0LOgknRjSyGWEGG141EouKMr3uEDGsRZCn8Hpa7lWVXxr07XIQur3+y+LufjTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lslTJMbaoWGmu5jtc143L8t4cb5oNX4pFRUUXPOy3+M=;
 b=0VMJDPo2t4rBysLVjGCJcprbO3QVKga2QvbWBDhHnaHSWHXu9ST16yofa7R5xQErTOT5MAqbJ0azN15nugGkiS1B6yAipgZcLfFMwNF4GF1iayV31LTts4cT9vZ13cgeRVe/Yyv4UAMgzNsUoG2N2j7YWx9YPlH9ujAFbJnnQFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:35:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:35:28 +0000
Message-ID: <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
Date: Wed, 23 Sep 2026 17:35:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1276f1-e2dc-4e24-af4f-08df19884b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gLwadnGosCOfN9/N/I8n+VKawFZZj6tBZIUhq0900zm7iiC0sZX9ZdpgqkZ/JGOosxLrIE343ex+lidTE+GD7yfNkNaAZ49Asd9zlXDM+w1tUfKRq9M+id/Juo1RlvKqclWnsJ7/7ra4eX+kB7bQgfME5E5PP0e9OcTCJWftC5qzaw8Djiso7O4hVkjAjXROF2W0i5Sl7u07JulPjMf+I6Py+DXiVhNvKElRHCH+PB6h7BRAP1TjXYeAi867btMDe5HKatJ2hDjY5DKd84u3ku3PFZ+xmv6oNciRKU42VIZcKCMmhJ07TSWDsFbguscru0qve7706smIStZlaD7x4ig9gz6TnojkAgJO5vYdj2hNUVPrnrBjXEi7CRYor5vVvv9VjwiBGxLHGNAS2hU0sHkfB8cig6P+HrpikkqUp/Ucb68EjfSNDlfDXcvEqBF2nv338167s1snwWy6kg/WV/z/rKcvANYRWeRXoGkAFrjeh7ab62IGLcTEHMy7D8uLwe7rbuR9pDzMf7YXYxJOe1ha1SKy8z4+rbkccFrtSW+PsowlLX1paPkF1zHHthUqFajLrmJviXMuWiDKh+wnJz4l5k+K9V6gh/tkfkbMZBUcEdPS8zVSvC2yuTOH0Fnhhx6+Hw7xisrcDBWi/Qcvt8FUtbdpnYRscJ7NqyVZ9p0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdaOUFyeG5XbUVUZURiUk02SU0zZ2tYVUFRSUZJYVBnWnRLQ0ZJbFpJNjMv?=
 =?utf-8?B?MmFVWlNKRWc4Y2IvVTRYcnYxQVZnb1Y2VVVsb2V5d1FOSjkvK0lObUxxRzBS?=
 =?utf-8?B?dTk3UzVsdjlRdk9VK3k1RFFsa0tLNTZNNW00V01xblptUCtVelJrbTVVKzFx?=
 =?utf-8?B?N2NUL09ueGNZWitlRmo5QktQUHJpS0VONnozRTV3dHEzZ1NteVpQT1VKTUxJ?=
 =?utf-8?B?Skt2a0ZsY0RwcHFRZW1Lc0tlWVVnTloxVWlWeTdnVDRKcVFwY0NvekhJSHFY?=
 =?utf-8?B?eWtuaG5IVFFtTnJZVklVVEtVOXlIM1psQU9IajNBa0ZOWTJFTUZ4Z3hpUk9p?=
 =?utf-8?B?UHg5QnY1S0p3c0gvcTFqVVF4TGlKbDAwL01iRGkvTkZrNnNrblJ2dW9lWDBw?=
 =?utf-8?B?SGkwRlQzTVpUbG05N2F6Y0pkdWN1M0s3OWtNWUl4R1lvdzhVR3dITkwxZk1K?=
 =?utf-8?B?c0JXRk5qalJWL0Z3emFJcTdNUnJ5Rk5uSmVXZE02OTcrSkh0TDFPYzBTYVB6?=
 =?utf-8?B?Y1ZLb25VTi9sTGFaUGE3OVJNTWtXNTFKb2ZaUjJsTUx5dGI1MGJ1dUljL3Mv?=
 =?utf-8?B?THpxTUR1cE9kTUc1b0FZSTJkNHV5emFlWERRVUNxU0gxZ1FoUm56VW5qS2Fs?=
 =?utf-8?B?bk5Zd01BWGh6NGFMZkdvUGdqT25xTnNlUzRaQzZVblZFbGVTZkpPMjZzUHdX?=
 =?utf-8?B?Ykp4VmFYcmxzZ2k1b2NHQXA1M3UzMG1JekUvNlp4UnhMU0gvczRyeE9HMHYz?=
 =?utf-8?B?SGF5T204NXpHREtqY0xZMy8yTXRDc0ZVYXNWeVM0aGpmbkpUU0tWTG92blhD?=
 =?utf-8?B?TTFER0phbGppT3IwVzl3TkJvY3ozbHNiMHR2Wm5PY0VwZDhCVUJKTDVjMkR4?=
 =?utf-8?B?UzFYVWNLM2l3TDgzR3ZXR29DNWJESC9YcVZQOU9PRHI5eWlSaXNnWStkajQ5?=
 =?utf-8?B?aXlIYXJIcGd2dDZFUFdTZklSYWx5SzlHZk5ySXB4OWlpS1JDUURXZXRiWHVO?=
 =?utf-8?B?d083OHNWaEZ3UmRiQTVJVndHdkdCSURKNDNBWHZNaUxkenpJUWZxRlhFbXhn?=
 =?utf-8?B?QXZ3OThLcXRNRlN6enUxWXpQMHdxU0hJRkYwdGFhaE9CbExESDc2TlA1U2lT?=
 =?utf-8?B?aFZlZnF6aTE3RE5HQ1Z2cGJXbHFXVExMeElWQWFSNk1uY0ZYM0pyYjZqdVly?=
 =?utf-8?B?TWZjTVFsWVRMS2FvNDJFVVMxeFF5bjN4ZTNXSEhWaWkwQ2V5WEIyMlBybzc5?=
 =?utf-8?B?Y2ZHZktGV1JpQjgyVVI3YTRuM3hsNHhZZGZROVZvazJGc3FhakpBdGlPZkhw?=
 =?utf-8?B?bnJvQUdOdUthUk9qSThhcmVzNFFLY2hHTkFLVk02dEdqVGVZb0N4eWpTRXhE?=
 =?utf-8?B?L1p1cm11VUJiU1JGRnhWekxVaFMxa21hd2VERlo3b2VyZElBSXU4SHZoRXNN?=
 =?utf-8?B?bWlQcGl2V1lGaE10aUMvUHFxeGVJeUFna2xsVFBOMXVsOG9vR3k4K3MvQVVJ?=
 =?utf-8?B?aC91TmJWSGR6L3FSS01kQnpOczgyVVUzUUZhSHJneXVjcmxacGlheTZqT1VS?=
 =?utf-8?B?bFFsRDFMMkVFRWllU2hEbkpNZ1JGejVyZlFLWUdnK0cveEJGazZkeW1wTldv?=
 =?utf-8?B?M0kzVXdWT1dNRnlKYWRzdFIrTjd2UGRBS0hLeFNWL3lVZG1RRWpKTVNrZ1Fr?=
 =?utf-8?B?RHIrSGNEbXJoRnc2bTZkVEZlTmJwRVpjTnczU29BTjFxd3VvdUtmTEtDVTg2?=
 =?utf-8?B?M3VBUkJQSEZxcWFJZmFOVC9qVXUwOGN5cFNEandpbkRNeDJWNCszcUM5Sk10?=
 =?utf-8?B?VTZVMVBFbGR0N1d2d3BOeVNQWnRhRTBqSHNiV3g4L3JhVWVtZDRhYkYzRW1R?=
 =?utf-8?B?blJyTHFFYytxNW9ZbWo0d1N2MnBEc3ZpZlE4WWd3dlRLRy9QN0hxazV1RFdj?=
 =?utf-8?B?NHJTMGc5QXNYSG9pOEF2SmQzSFl5UnFUcUgxSm1La2ZQL0FONHErRHlBMUhT?=
 =?utf-8?B?eGVmSWVQVEhzK2ZNSVk2M1k3TzJkQW9mY1h3LzlYbXVwU2FXNXBZZ3RiSE5a?=
 =?utf-8?B?YlBnUVRyYnFTb0xmdkFXSnVpazFnWXdUZkppZ1FzL0ZUcWZ2M2ZIZEJnNUcy?=
 =?utf-8?B?V3l5SndETnlWN3QvM2RxT042OVBTZi9LWSs0bWZtNFlua053YTE3VVF0dElJ?=
 =?utf-8?B?SG1TR3lWaEtsTlZQbUlyazZiMytuVUtKcjZCNnJDN3BHdHVLcnBhZFdBR0Zp?=
 =?utf-8?B?MGxwMEtJVUNyNEFCL3c5YXhHWHorTjFvRmZnZ2Q4eWwwUVBUc2RGMEhYUU1m?=
 =?utf-8?Q?72vTeq15Cmz1ELgsx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1276f1-e2dc-4e24-af4f-08df19884b75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:35:28.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHxAwq4h/f2yidhq7t4JmFaQpW2vxS3oXBhbRaghI2pVrcWVya5tkMma0d0s+pt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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

On 9/23/26 17:27, Philipp Stanner wrote:
> On Wed, 2026-09-23 at 17:13 +0200, Christian König wrote:
>> On 9/23/26 17:03, Philipp Stanner wrote:
>>>
> 
> […]
> 
>>
>>> 	Consumers of a fence can instead notify themselves by
>>> +	 * registering a callback on the fence.
>>
>> Mhm, the wait callback is transparent to consumers it's just that implementations used it for quite a number of different hacks.
> 
> Right…
> 
> but doesn't the question then become why dma_fence_wait_timeout() even
> exists? IOW, shall we deprecate it, too?

Yes, without the wait callback it is only a wrapper to block the current thread for a dma_fence to signal using a callback.

It's still quite useful to have a common function for that I think.

> It seems to be a reimplementation of waitqueues. The driver could get
> this functionality by using a waitqueue whose event gets triggered by a
> fence callback.
> 
> dma_fence_default_wait() interacts directly with the task state with
> __XX_task() functions which looks very.. deep to me :)

That is *exactly* what I pointed out as well >10 years ago before that stuff was merged upstream :)

A wait_event based implementation would be tons of cleaner if you ask me.

>>
>> I would just drop that sentence.
>>
>>>  	 */
>>>  	signed long (*wait)(struct dma_fence *fence,
>>>  			    bool intr, signed long timeout);
>>> @@ -243,6 +249,8 @@ struct dma_fence_ops {
>>>  	/**
>>>  	 * @release:
>>>  	 *
>>> +	 * DEPRECATED!
>>> +	 *
>>>  	 * Called on destruction of fence to release additional resources.
>>>  	 * Can be called from irq context.  This callback is optional. If it is
>>>  	 * NULL, then dma_fence_free() is instead called as the default
>>> @@ -254,6 +262,12 @@ struct dma_fence_ops {
>>>  	 *
>>>  	 * If the callback is implemented the memory backing the dma_fence
>>>  	 * object must be freed RCU safe.
>>> +	 *
>>> +	 * Deprecated because it prevents the producer of a fence from
>>> +	 * unloading. No new users must be implemented. Parties with a
>>> +	 * hypothetical need for this callback can instead simply and directly
>>> +	 * perform their custom release operations one RCU grace period after
>>> +	 * they have signaled the fence.
>>
>> Yeah that is a bit problematic.
>>
>> We need my patch set to explicit signal fences instead of returning true/false from callback for that so that a backend can properly implement this.
> 
> Well, what I'm trying to say in this docu is that the driver can kick
> off custom operations that shall be performed once everyone is "done"
> with the fence after signaling it. Any driver data that might still be
> around cannot be accessed by fence consumers after signaling anymore.
> So the driver could trigger cleanup work after a graceperiod, as long
> as it does not involve kfree()-ing the fence itself.

That sounds sane to me, but I'm not sure how to phrase it cleaner either.

For now I'm ok with it, maybe somebody else has a better idea to how write this.

Thanks,
Christian.

> 
> 
> P.

