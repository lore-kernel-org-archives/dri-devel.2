Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7132606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Azzodiig
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5667B10E85C;
	Wed,  4 Nov 2026 08:33:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B7E10E21D;
 Wed,  4 Nov 2026 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=OjgfVkz7I6aaeDs/niXGQ9dYXWbLr1dkB1rbziP/69o=; t=1793781229; x=2109141229; 
 b=AzzodiigM4F1/f5nYUmWh9xe5ijn0U/yUQxzgNythRo61fbEv8yLnDt//z+6I8nX4jvqOeOfN4x
 SeUFKdinYvUSnx95DWPFSmzI6TodHUURa+mqdzOf8+yOP5H6T3m1uZbtprLjVVwexEssDHTLusjUP
 /dBa43r/L2lcrZR02AN5elucHkT4LCK53jZuH/CuUMRH1HXDFP46TmSEjCzXmaaFPvhsCpEjpf0gs
 Q+ilRBOMD17yf4eRTamxjpAHMdJIIlnkPOc/7EByTZYbXXDc9v6HrSohu1QcVdaHb4LyV2rmSEvRU
 J5Wfgc2vMUDycq7lLr1bfS/qcvvtTQ/yHBcQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOWRF-0024QM-Ow; Wed, 04 Nov 2026 09:33:45 +0100
Message-ID: <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
Date: Wed, 4 Nov 2026 08:33:44 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority
 at runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
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


On 04/11/2026 08:18, Philipp Stanner wrote:
> On Tue, 2026-11-03 at 16:03 +0000, Tvrtko Ursulin wrote:
>> I'd like to get the fixes in so I can mentally focus on the continuation
>> of the bigger story. Not least that not fixing it causes sashiko to flag
>> the bugs, either when touching the neighbouring code, or possibly even
>> just the logical functionality.
> 
> 
> Fine by me, no major objections :)
> 
> The only thing that makes me a bit uneasy is
> drm_sched_entity_set_priority()'s semantic. I know it's only used by
> amdgpu, but nevertheless the reader might be tempted to think it should
> only change the priority of an entity within a runqueue.
> Could you add some sort of code or doc comment hinting at there being a
> TODO for the future rework? Good to have that in case any of us is
> assigned to work on different projects in 2 months.

I lost you here - what should the comment say?

Regards,

Tvrtko
