Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400ECD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CA510F618;
	Mon,  8 Jun 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="jjHbK9Wq";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22BE10F618
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1780933348;
 bh=yEOieKCXcv06vNuoNgdqY2ql2LhHpG4SOd+tbelcK1g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jjHbK9Wq/UkjdyR1CPaGt2LbGlVFCF1AgS2o1b7hzDnvpIXccZ3FDt6M7iVOR2SWG
 VS7gh5ghgEwKy8gFBjxDdWe6sp/rT58mHtC0Kd1CC4hUWCz5GlA27uvAgGUUge/krg
 BbZ8mn7BClVCsTeY14u8Tf9aY+jCQV1Aola4mNDjmV6Gc9aMd/kJE+G+3q8JeUxI0v
 VT5usdK0TNIRkVCXJeK5SmQ/d9IDdxrI9OykiKVzdUR93rlNnCOMWwuEhuFbMdYKwV
 +SPrFTcyX3bU6z7NIQoDDBo6SNEBPQvWQfHQTgNpxc7TPi+7j703Sw2nUzVceVDS/7
 l7+IaHMInx2YA==
Message-ID: <c0dd1298-17be-44ba-8866-c8602aaa69c6@lankhorst.se>
Date: Mon, 8 Jun 2026 17:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
To: Maxime Ripard <mripard@kernel.org>
Cc: Natalie Vock <natalie.vock@gmx.de>, Eric Chanudet <echanude@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Albert Esteve <aesteve@redhat.com>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
 <20260608-glorious-fluorescent-salamander-93daec@houat>
 <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
 <20260608-rational-cuscus-of-enhancement-eecbfa@houat>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260608-rational-cuscus-of-enhancement-eecbfa@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,

On 6/8/26 16:04, Maxime Ripard wrote:
> On Mon, Jun 08, 2026 at 03:13:56PM +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 6/8/26 14:42, Maxime Ripard wrote:
>>> On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
>>>> Hey,
>>>>
>>>> On 6/6/26 18:31, Natalie Vock wrote:
>>>>> On 6/6/26 00:44, Eric Chanudet wrote:
>>>>>> Accept only one "region value" pair entry for the dmem.max, dmem.min,
>>>>>> dmem.low files.>
>>>>>> This changes the UAPI that otherwise accepted multiple lines for setting
>>>>>> multiple entries in one write. No existing user is known to rely on
>>>>>> writing multiple regions in a single write.
>>>>>
>>>>> Ugh, shoot.
>>>>>
>>>>> For dmem.low specifically, there already are some userspace thingies floating around that may write more than one region/value pairs.
>>>>>
>>>>> These thingies all depend on that one patchset for dmemcg protection that I should really get around to merging[1]. Since the userspace utilities depend on not-yet-merged patches, they sort of have to expect stuff changing under their belts, so I wouldn't really consider those users a blocker by necessity.
>>>>>
>>>>> As I see it, we could go down one of two paths:
>>>>> 1. We go ahead with the patch as proposed, and I make sure that the users I know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but since the already use non-merged UAPIs in one place, you can argue that these users kind of have to expect breakage.
>>>>> 2. We use the old handling allowing multiple lines for dmem.min and dmem.low only. This preserves compatibility but uglifies the code by quite a bit.
>>>>>
>>>>> All things considered, I think I personally would prefer going with 1. and taking the patch as proposed and just having one codepath handling every limit file. Just highlighting this so we don't do it on accident.
>>>>>
>>>>> [1] https://patchwork.freedesktop.org/series/163183/
>>>>>
>>>>
>>>> I prefer option 1 as well, but would like an ack from one of the core cgroup maintainers too,
>>>> and what Maxime's opinion on this as well.
>>>
>>> Option 1 works for me too if doable
>>>
>>> Maxime
>>
>>
>> I see this as an acked-by?
>>
>> I'll commit this patch to drm-misc-next if so.
>>
>> Fortunately it may not even break those scripts in the typical case
>> where only 1 region is registered, eg the most common laptop/desktop
>> case.
> 
> Natalie had a bunch of comments afaik, so I was expecting a v2, but if
> you intend to merge it as is, you can add it if you want.

Yeah forgot about that for a second, will wait for v2!

Kind regards,
~Maarten Lankhorst
