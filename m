Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DB610E33D;
	Thu, 16 Jul 2026 12:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="WCWuADOm";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F290710E33D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:14:57 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15bf399d3bso400455866b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784204096; x=1784808896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2tD0gl1WWjr7q7E1psl8+VVqtSN3OA2PtB68wnVaTQM=;
 b=WCWuADOmmTpqKp3PwsXffGUbXk0shjfe/T/oRsa+sjoZwy0kwurDxJcbV0SBdjdRrf
 cRiSIx3DkfJ+SziH2kGY2VtoojJK2+Kjd/us8AmhgMVAPX43SIxsgEnEKBDzSm0/mHnG
 i7Pv2yw8QsSFY6zv+VvxpU3KGlTKz7UpvxbUDVtJQVP8ZO+MZyeZsJOydAQr/suBuTAO
 D3Amgdu4hUCktAQ134xmG8Ji8qXNWVl2spUB/jea4CxuaduR+NIxLqXrO+vEpvEdFdZC
 yAZ+NZnmlZ2fLPUxXz45I0LCTOJMTE7tQicKxaiXLc9hYnks+IkoZ6nFHghs2XMn1Zxa
 ubUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784204096; x=1784808896;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2tD0gl1WWjr7q7E1psl8+VVqtSN3OA2PtB68wnVaTQM=;
 b=bx5bNXHn51JPXt+BLDlFG1N3B5y2xwQ3MnDAkgVKieIpv8gxF+9TOOb34WkuniOwf/
 PaxyfrMiUxufYp6UqzKfAOuDgccbIXJQFDpd+/E3gBUJseAEkzsZXX1IcoWKUMV4JZRl
 O1iTp4XEiuEmBlF6VOr8dJoSEHXurMowmtQUF/lVT359KmcSRhwoxy8MrKk5iMbjTMk7
 99st+4+Bp1XcJdaWfVNKphCkBbkOOAklULxlTNrDSVyx9sr0jtOusbD8a/oUR6OyNPrX
 U3vb6GsLIcLK/aUmH/iw1EE70QbBJmPL927a3+H3o1GR8bmpfrfVEx/orVOdmA3Boe19
 059w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqLFiCO7Mt9HqDTDqHcHVhIOC4jTNEA2dU4jX9Gz5xAAZtkgQNIaIKepZ7o9/8Brc0RK3jyesh4BM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUnrlnf6ns6J5LeLsySjI4CbvQxc/SHcK1H/WHHcf6TwesmsF7
 E+zxBYgUG3d9Kl6cxWnnsQwLzVCQMvukFTLY+JwKuIqGqQqd90PijYCgtbunkIP5aH8=
X-Gm-Gg: AfdE7cllQLH6B5N6FMixNL2s+LBI8RGkabRxNzWGNiXYuRNV1DiE3ahHeGBxHL/4YHV
 6Zlloih9A62HnjyrvwCvhlQkAjK7UYff8YxI6Gehg3igCxkBOjNd0DyBv11CT632XsS5QBQ1bFM
 A3LHHGiBwv7WmFKSaJCzUUd+P3GKiQh2qhbTV8SF95Ig6HMm+OJc5yQfIjzuoOGEJwPC1fKQrxK
 4i1pG0Xc/4mc4QHjVQlPHsLwMs1VNJKh0/MB/LYIu9/jukDoE6ivG3syU93f+TxaKM9XkoS17VI
 c+AqkUpt8YuZK2Za8liZoDF/3PU/sx6xssuG42F1CR9kkAKrRmnO9R2/O/pbGUvUWU2oscbupt9
 zbOZ/ok4AT9JIMB5IgH5cFPgLcSdPDlnQk8jGQM53kB82uG4xgxYwhZSqvLN6Xl6unaifp+NGpk
 UJAcSdVH3CFSzxdvC7jgWlNMg=
X-Received: by 2002:a17:907:c084:b0:c15:c257:9d54 with SMTP id
 a640c23a62f3a-c161ea8a95dmr1148012066b.62.1784204096078; 
 Thu, 16 Jul 2026 05:14:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16874a2453sm200339466b.56.2026.07.16.05.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 05:14:55 -0700 (PDT)
Message-ID: <4dd5a686-f935-41a3-89d2-0f651061545d@ursulin.net>
Date: Thu, 16 Jul 2026 13:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707114807.154572-1-marco.pagani@linux.dev>
 <46ffa75c-83e2-4f4b-9d5b-e43fdfa12176@ursulin.net>
 <f36c7c87-38c5-41f9-bd14-efc9918a4b61@linux.dev>
 <f524ee2d-c15f-4b7f-ae42-2c28b06e58b6@ursulin.net>
 <949473de-f402-44d7-9fd5-125270bdfbd9@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <949473de-f402-44d7-9fd5-125270bdfbd9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 15/07/2026 17:02, Marco Pagani wrote:

8<>

>> I first want to understand exactly what the issue is. The current design
>> exactly cannot free the memory under the scheduler nose unless there is
>> a test bug where test exited and has left the scheduler with unprocessed
>> jobs. I am not saying we cannot have reference counted jobs but, again,
>> at the moment I don't understand the problem.
> 
> I think that the current design of the mock scheduler can indeed free
> test objects' memory under the scheduler backend's nose. Consider the
> example discussed above: the mock scheduler is instantiated and released
> in the .init and .exit functions respectively, while jobs are allocated
> in the test body using drm_mock_sched_job_new(). In this rather basic
> use case, jobs' memory is freed before the entities and the scheduler
> are released in the .exit function.

So at first I thought that as long as entity is freed at each test exit, 
which includes idling, and is done by all current test cases (apart from 
the parallel one where you did it via actions) it is all fine. The 
entity->last_scheduled you mention is not a concern then since it is 
cleared etc.

However, now I think that even if entity is idled and freed before test 
exit that does nothing for the jobs not yet processed by the 
drm_sched_free_job_work()-er.

Even though I was testing with KASAN I possibly did not manage to hit 
that race. Strange but I guess possible.

Unless I am missing something with the above analysis, one options is 
along the lines of what you propose - forgo using kunit managed 
allocations for anything mock scheduler owned. Second would be to stop 
using test suite init/exit for the scheduler management and just make 
each test create own scheduler and free it as it exits.

Regardless of the option, as long as it is safe against UAFs we are I 
think good. Memory leaks on test failures are not that interesting that 
it would warrant coming up with anything more complicated.

Does that make sense? If so, question is which option is simpler? 
Probably just making tests create and destroy schedulers since then 
there is no need to deal with any memory freeing. It would be just two 
lines added to a subset of tests, the ones which rely on .init/.exit.

Regards,

Tvrtko

