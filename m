Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD98606A331
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=fJidFxKT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B6E10FAF1;
	Wed, 11 Nov 2026 11:15:29 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AADB10FAF1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=h6AuWUaGarDctQ5l7dVAUhKlPDbR4Gj0cCKk8wqMzm0=; t=1794395723; x=2109755723; 
 b=fJidFxKTzpxKRQ+cl1X0Q9v14SbA0q2l8rpPlYQajwWqxhpsi50cAAxL39H3Glt2KT4M2TSL2vg
 eohNTqsBlg2BFp6Tb08yFKmeEf8x7ffL7DqObJbqFDogL1aD7ZhrmntgCJwxzHse0RXrbDxoHY6i2
 ozqM11w1mxybdtNtUTVIgfI/ojPqdyG42bIEkBmK4M8gQli8Dde0/rNVkvsri7jQXJWLMyTQQkMCb
 5phPPxLahHtc04YdUH33co/teFPtfuKF1bu17ycSvzZBhCSOHPorZV9pxDPjvPN105XkHtQ4YCxcz
 C5fjRFFna+YlI2qraERpO/SCZoaNijI9WA4g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xR6IS-008mx4-Ts; Wed, 11 Nov 2026 12:15:20 +0100
Message-ID: <2d61a52b-74f2-419f-968e-f377d61bf338@igalia.com>
Date: Wed, 11 Nov 2026 11:15:20 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Switch the default policy to "fair"
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261110141455.28739-1-tvrtko.ursulin@igalia.com>
 <30a1da3baf35c7706e2381d9e3bac3e478f64421.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <30a1da3baf35c7706e2381d9e3bac3e478f64421.camel@mailbox.org>
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/11/2026 14:28, Philipp Stanner wrote:
> On Tue, 2026-11-10 at 14:14 +0000, Tvrtko Ursulin wrote:
>> After the last known real fair policy bug was fixed in commit:
>> 2ab510e63197 ("drm/sched: Fix virtual runtime race")
>>
>> And two theoretical ones in commits:
>> cda6f72545f2 ("drm/sched: Fix out of bounds entity priority check"
>> 75709a35da45 ("drm/sched: Adjust run-queue when changing priority at runtime")
>>
>> Lets switch the default policy to fair.
> 
> We shall, but first let's get the spsc_queue series in. Considering
> that the last time we blew up the kernel with CFS was – ultimately –
> caused by the scheduler's lack of locking, getting rid of a magic
> lockless queue involved in all entities seems the safest path
> available.
> 
> Christian's recent comments [1] indicate that the complicated AMD fix
> might be dropped altogether, so we can be positive that spsc can be
> merged relatively quickly.

Okay, we are keeping an eye on that and we will see.

On the topic of the fair policy, with the latest SteamOS update I pulled 
yesterday, and kwin_wayland moving to high priority gfx context, I've 
noticed job runtime accounting is a bit off so I will see if I can 
improve that in the meantime. Problem is when there is no preemption and 
two gfx rings share the same hardware it overaccounts since wall time != 
gpu time. I've sent one trivial and unrelated job runtime accounting fix 
  but for the shared pipes and no preemption it is still in 
brainstorming stage.

Regards,

Tvrtko

> 
> Philipp
> 
> [1] https://lore.kernel.org/dri-devel/52d41d99-90f0-40d1-828e-0456dad433b6@gmail.com/
> 

