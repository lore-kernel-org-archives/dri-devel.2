Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B12606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=HaCzYLFd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5003310EB9D;
	Fri, 13 Nov 2026 09:26:48 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBD811238D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=YvJjcy31nJo6yvTFYbci5u0PZ6dzXajX8UHoRlkgrDc=; t=1794562002; x=2109922002; 
 b=HaCzYLFdI76BLvFd68kINua9ojeQuxLhSBlnOnF0MbI7mI9vRLJ6B9JZyuhRZM6RYu0oSRggrdC
 nUm3+VTDciXFFRlE2OBiZSWdeMCtR0lkkKTqV7eVF+YtUDLwtJwgLbs+71e4EV/H3EIVCBJdr3bcX
 U5LfZV45XzwpaXAeKgS0Unde5H2WYRu/+dmUSRHF4jAXt7bjAB7zF2IjMqpllJCN89+783W8R2NqU
 Zxppfq6/dRXvbEXlNSZ0I+iUm2t57vEavBX0FwXQOGwl9TGBjRSM4D3bnGHf9QdU8oEO8uGekNnb5
 DrjgpbufTR2+tBRiLmdotsfKfiqG7YIzKl5g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRnYJ-00A6xx-Q8; Fri, 13 Nov 2026 10:26:35 +0100
Message-ID: <4d2f91cf-992a-4717-b527-925c44fa5df1@igalia.com>
Date: Fri, 13 Nov 2026 09:26:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
 <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
 <4606cd56-f1c5-4a00-b9ba-fdbf2206681d@amd.com>
 <1f2143d213d22dec427ae1bcfc7cbfe2d34ab83a.camel@mailbox.org>
 <c956cf4e-96a5-475d-b12c-406c5e008b54@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <c956cf4e-96a5-475d-b12c-406c5e008b54@amd.com>
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


On 12/11/2026 14:51, Christian König wrote:

>> And btw above you said that this is done so that drivers can do
>> something "accurately" :)
> 
> Well "more accurately", e.g. the accuracy increases from completely off to only slightly off :)

Yeah it works pretty well expect one corner case on AMD which I 
discovered couple days ago but that's unrelated to this.

For what DRM scheduler is concerned, this patch is only adding a 
time_after() guard so shouldn't really be controversial. Any further 
improvements can be done on top.

> Because of the interrupt latency and everything involved a submission which takes 3ms can report in anything from 3ms to 6ms runtime from my experience.
> 
> If somebody wants this to be really accurate we would need to record the HW timestamps. That is possible, Intel does that for example, but for AMD HW nobody really cared enough so far to requests this.

On Intel context's runtime is recorded by the GPU on context save. This 
makes it almost trivial and removes any complications with queue depth 
etc. Only trick is when a context is currently running to report last 
known hardware runtime plus the time between last schedule in and the 
query. And it requires the driver to know how to convert between the GPU 
and system clock domains but that's trivial.

Does AMD have something similar? If so perhaps it could also solve the 
problem of the high priority and normal priority gfx rings randomly 
inflating the reported runtime to sum up above 100%. Then we could add a 
mechanism for the DRM scheduler to either ask the driver, or allow the 
driver to provide accurate job runtime.

Regards,

Tvrtko

