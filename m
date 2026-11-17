Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1344606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pgAk+UJt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B268810F694;
	Tue, 17 Nov 2026 12:17:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789D510E574;
 Tue, 17 Nov 2026 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=0ajmuEVTcI9BscgueZt4IXU3Kd0+r/99rixUdDp5fLg=; t=1794917842; x=2110277842; 
 b=pgAk+UJtRz0tqZ5BlCuImxQaNcVrx/HywKHfKvoQVxgzdo5WRgtY/LHoW0PFMbL1uw3B/T4xong
 pcdJZtN6bfPUI2yfVBtFrWoAdhgub8n99mpWrrUQpPpVtjyQM2mzbUOcq1wXd/uFpqG6n+OptoKUB
 LT+sgc4hmr3BeW76sefhFyqfi6CApEwjwmBeDVzqUkjBTnrFBaAHMg2AfdIArrnN3Lgdz9j/FKcNO
 IvIQIl+YJD+LqM4L3ptlGy/l79BN5R6GCz6g366Np/N6zHpJalbTT+n/U5O15zvKgKAmMV7RPhLHq
 Z6/WTbG/BYkaIUD6VW/8WdzTgaeZeg3VDI+Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTI7k-00000000a6i-1tIr; Tue, 17 Nov 2026 13:17:20 +0100
Message-ID: <7c97a544-c06a-48b4-8543-118e19a3746f@igalia.com>
Date: Tue, 17 Nov 2026 12:17:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
 <e0d8e3350b8897c186c0780eb0c16e9dd136ef46.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e0d8e3350b8897c186c0780eb0c16e9dd136ef46.camel@mailbox.org>
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 17/11/2026 12:00, Philipp Stanner wrote:
> On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
>> Simplify the code and theoretical runtime combinations by disallowing
>> initializing entities with un-initialized schedulers.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> ---
>> I do not *think* any of the drivers relies on this inverted initialization
>> order but it needs more eyes for sure.
> 
> 
> I increasingly think that the way to go forward is to demand from API
> users that they use the API correctly and appreciate the distinct
> lifetimes and especially initialization and teardown orders.

Enforcing initialisation order is what the patch is doing.

> Sure the API can warn when it's misused, but we have certainly not put
> enough emphasis on really motivating people to set up things right.
> Most APIs I see in the kernel do not warn in foo_init() whether
> foo_init() had been called already.

Exactly, so making entity initialisation fail when the provided list of 
schedulers contains uninitialised elements is this strong motivation you 
are looking for. New callers simply cannot pass driver bring-up with the 
wrong init order.

> What we actually need is more documentation

As opposed to adding restrictions where we can, or in tandem to adding 
restrictions?

Tvrtko

