Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE35606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CYjbkWKY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FA610E22A;
	Mon,  9 Nov 2026 11:14:44 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48E610E22A;
 Mon,  9 Nov 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=TP9cabTjciYnZSD78/LJCeeuiPkfKCro4x+CT7c0heI=; t=1794222877; x=2109582877; 
 b=CYjbkWKYpnukQ9KuFsIMxpY2cbWJknVVI79/0tkgH7yBxwFgV0tivGbopBZCX61ry4faSVOvpN0
 qfs9Ivt+6Z02QyCXdJ6ovz5DCslWJpfu3vmVc1wxa0jOkrWOLghu37zykgl7gFXKggRwxvyZzsh0p
 bty32LwI1HsYygW0qSDfHOHqgwz5VQVubWzQKkH3szUEG/WR4ZtSqE8lBagNDDNs8Ik7LflyJZy7G
 FnPNv//39vaOCeBw52NDp1EdOX6URAHcU6Z7TuThU+iY3fa93q6w//6uxFaQ31vqbaiSJki2jrYT+
 yQvUMRL6pZqfCHWnqyoOhpXmhhqQ+hpzTwZQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQNKd-007CqZ-50; Mon, 09 Nov 2026 12:14:35 +0100
Message-ID: <776a6511-834d-458e-beba-82cd7e37a126@igalia.com>
Date: Mon, 9 Nov 2026 11:14:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/sched: Replace SPSC queue with a list and spinlock
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <e0476d10290d0f787a467f36381e8439530ba2ff.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e0476d10290d0f787a467f36381e8439530ba2ff.camel@mailbox.org>
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


On 09/11/2026 10:21, Philipp Stanner wrote:
> On Fri, 2026-11-06 at 14:56 +0000, Tvrtko Ursulin wrote:
>> [First four patches are just my queue to avoid conflicts. I am still hoping I
>> can bring them in a state where all is good since all these together simplify
>> things.]
> 
> I'm confused, so is this an RFC for AMD to take a first look?

Yes, but as the cover letter later re-iterates, skip to patches 5 and 6 
for spsc removal. Prologue is due my local patch ordering and otherwise 
there would be conflicts.

>> So as requested by Philipp and as the title says - replacing the SPSC queue with
>> a list and a spinlock. A first cut which passes unit tests and smoke testing on
>> AMD.
> 
> Thx for working on this, it's one of the most important chunks of tech
> debt!
> 
>> But it wasn't easy, since we can't really get away from some of the deeply
>> ingrained scheduler design points.
> 
> What would those be?

See patch 6. Unlocked peek from the run job singleton due entity<->rq 
lock inversion and sleeping ->prepare_job. In this RFC peek is 
implemented via list RCU helpers which make it safe because the single 
consumer is still true.

Regards,

Tvrtko

