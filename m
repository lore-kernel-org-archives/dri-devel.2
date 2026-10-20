Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451460A2619
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Tu80jOx+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BE610E8CB;
	Tue, 20 Oct 2026 06:58:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41C010EB72
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=x/3R0C43YAiNZIf6KcOw82RzTJCd2JeVTwUmw8+iu6g=; b=Tu80jOx+iGKr9Kje54pGhsr6Jt
 v4KEwmJWNmNWQfudbZEjR6WfBrhlCoK7cMj3cVMzL4vCSxUVyhg/BArsV0nMNuxaYPAIjUsuvjGu+
 LYMdiKNz04/tfcZ5NFnqUV/xVG0E4RZp/ryy5akm6VdRCtu5zTznh23nai5awECJycdT0DUHsTaCA
 NOivDOrpLb6f3jprW7CPWOVxPLrKjuKiKDY/ygs6HtVyZronPJuqMraNECYqpNt8QooR5216rcCEo
 s7gfS1YeTxwlKw5kbOS06OxpN0vo2qygAg7IYXoWUTaDgedYHB7Od1DIXkepTtqWPY99Z4UdfNJIW
 sL6hJHTg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJ3mr-004HEI-P2; Tue, 20 Oct 2026 08:57:29 +0200
Message-ID: <4dabaef5-25ad-480d-96f6-5feb26a64e42@igalia.com>
Date: Tue, 20 Oct 2026 07:57:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Don't BUG when a CRTC fence signals during a name
 lookup
To: phasta@kernel.org, redducc <sushmit718@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261019161731.2341-1-sushmit718@gmail.com>
 <30a31088a0386d5f5d53e74632ea9a63566dccde.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <30a31088a0386d5f5d53e74632ea9a63566dccde.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/10/2026 07:53, Philipp Stanner wrote:
> On Mon, 2026-10-19 at 16:17 +0000, redducc wrote:
>> dma_fence_signal_timestamp_locked() clears fence->ops on signalling when
>> the ops have neither a release nor a wait callback, which is the case
>> for drm_crtc_fence_ops.
>>
>> dma_fence_driver_name() and dma_fence_timeline_name() load fence->ops,
>> check the signalled bit and then call into the ops. If the fence
>> signals between that check and the call, fence_to_crtc() rereads
>> fence->ops, finds NULL and hits the BUG_ON(). This takes down any
>> caller of SYNC_IOC_FILE_INFO on a CRTC out-fence, such as Android's
>> surfaceflinger, which hit it on a Snapdragon 8+ Gen 1 phone (msm).
>>
>> The CRTC behind the fence outlives it, so reading the name after the
>> ops were cleared is fine. Only warn when the fence carries foreign ops.
> 
> @Christian:
> We have now seen several bugs like these, which is one of the reasons
> why I believe that RCU is the wrong solution for dma_fence.
> 
> I present another rework RFC soonish.
> 
>>
>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>> Assisted-by: LLM
>> Signed-off-by: redducc <sushmit718@gmail.com>
> 
> Reviewed-by: Philipp Stanner <phasta@kernel.org>

Hm this looked familiar so I looked around. There was an earlier fix for 
the same from Andre with msg-id 
20260721-linux-drm_crtc_fix2-v3-2-afa8c71506e6@linaro.org which seems to 
have fallen through the cracks.

Regards,

Tvrtko

> 
> 
> The Signed tag btw. states that you have the legal right to push this
> code upstream, and that you agree with the kernel's licensing. It's
> uncommon to use with pseudonyms and lessens your personal accumulation
> of prestige ;)
> 
> 
> Philipp
> 
>> ---
>>   drivers/gpu/drm/drm_crtc.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>> index 63ead8ba6756..1dbd0e9db536 100644
>> --- a/drivers/gpu/drm/drm_crtc.c
>> +++ b/drivers/gpu/drm/drm_crtc.c
>> @@ -158,7 +158,13 @@ static const struct dma_fence_ops drm_crtc_fence_ops;
>>   
>>   static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
>>   {
>> -	BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
>> +	const struct dma_fence_ops *ops = rcu_access_pointer(fence->ops);
>> +
>> +	/*
>> +	 * Signalling clears ops, and can race with a name lookup that already
>> +	 * picked our callbacks, so only a foreign ops pointer is a bug.
>> +	 */
>> +	WARN_ON_ONCE(ops && ops != &drm_crtc_fence_ops);
>>   	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
>>   }
>>   
>>
>> base-commit: 6a56f4f29711dd2da49f03a5b99ce53779e638d7

