Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UbWt5xIy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91FF10E413;
	Thu, 26 Nov 2026 16:39:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B254810E413
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=kbBcWz7M/dp9EJCVbYhqj8zDvU5uF/XvLDIGwwLKiXg=; t=1795711157; x=2111071157; 
 b=UbWt5xIyj/WcNZPF4BAaHEva4W8t0GoB/lY2BvSkPru7sheHvVDH+IJmG0Y6vA4jiaa7y+2VcIB
 vBpnNsLfLl7CagirblAYJKraaGSDBCC1EZSSYaYJOcPB68oLsWVS/LUgZ/uobq9lcu2xQFwe+M3jA
 8C/an9XUsARjaUJNV6bYmt5YFMe507XALI6miX6pUqkDp4jzPms3F7OgdFYHmNNejT4l/bSOUCZDA
 OcpPsMImq5KTwP1Yb7bKzAY4F8WrCPVYClZl1ZGgltNwzSCOOBlDZ3x0VVfCSPpUa1UOzud0Gflsx
 YLdC4Wve+bnm8TQ/TxyWxRmD6elQwEiA7LHA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWcV4-00000004Tzu-0q4A; Thu, 26 Nov 2026 17:39:10 +0100
Message-ID: <947b762d-1530-4302-a330-1c234538281a@igalia.com>
Date: Thu, 26 Nov 2026 16:39:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Extend locking in drm_sched_entity_select_rq()
To: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261117093708.647488-2-phasta@kernel.org>
 <5922ac007b35e54e8b0c60a04cc55fb7fc88d72e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5922ac007b35e54e8b0c60a04cc55fb7fc88d72e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26/11/2026 16:14, Philipp Stanner wrote:
> On Tue, 2026-11-17 at 10:37 +0100, Philipp Stanner wrote:
>> drm_sched_entity_select_rq() evaluates entity->sched_list locklessly,
>> which is elsewhere always lock-protected. Another lockless check regards
>> spsc_queue_count(). spsc_queue is evaluated under lock protection at
>> many places already and the plan is to replace it with fully locked
>> infrastructure anyways.
>>
>> Move the spin_lock() in drm_sched_entity_select_rq() upwards.
> 
> Tvrtko, Christian, objections with merging that for now?

I don't have any huge objections but it is a bit underwhelming aka we 
don't get anything much with it really.

I was hoping my series which ends with "drm/sched: Address the fence_seq 
fixme" would get some more attention because it basically ends with a 
similar but perhaps a better result, where the lock actually goes one 
level up to drm_sched_job_arm and atomic_t fence_seq gets removed. So we 
can say there are some tangible benefits in that case.

But it is not just that series and the sched_list confusion it fixes, 
but also since in this commit message you elude to spsc queue removal, 
that's another one which we have sitting in limbo.

I mean it's all well and good moving spsc_queue_count under a lock but, 
again, it doesn't gain us much. In the spsc removal sketch I have for 
example demonstrated how that we can easily remove that 
spsc_queue_count, plus some spsc_queue_peeks. In theory that could be 
done even without the full spsc queue removal.

Perhaps we could close on all those opens somehow?

Regards,

Tvrtko

