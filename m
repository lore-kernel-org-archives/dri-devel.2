Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99147606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hoFxjwvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B1B10F6C5;
	Tue,  3 Nov 2026 16:03:12 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EC510F6C9;
 Tue,  3 Nov 2026 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=PmqAMN0m0LlKVLmim0O2UColmqtAweSNc5SBGMdXPZU=; t=1793721786; x=2109081786; 
 b=hoFxjwvH7g+3BFpbrZctWInrXljyhl5bLf4T8uhqEpkyClOpYcekHUYej01a+3KFi3qaJwgTyLP
 NgLd4WTB631YpCAPoi911xvhkp1WEunPl9ySr4EXbsHvHVoGWinNSxSghO693GWsAGSYlQEEH79Dm
 /mtVbJNCXwjogVsPmbu9xm4PpQ9+0i0Eynl1NUSbzuW+IwdHyWuicEB/GNmFt0HjIENTFeYNVnKdo
 p1GXJpNbKXdMa0HK9b7uGIOJvm+Lvb1McKD564soYUTZ3ONx5SwlG53vlO9a7ciLPp9XvlDwG8f/j
 vK2H+3zJtncSGC5EenWghj7r2B7ShdR3tuzA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOGyU-001NPa-Eq; Tue, 03 Nov 2026 17:03:02 +0100
Message-ID: <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
Date: Tue, 3 Nov 2026 16:03:01 +0000
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
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
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


On 02/11/2026 15:40, Philipp Stanner wrote:
> On Mon, 2026-11-02 at 14:47 +0000, Tvrtko Ursulin wrote:
>> With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if*
>> there exists userspace which does dynamic priority changes (calls
>> DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on
>> entities using those SDMA engines directly. All clear now? :))
> 
> 
> Argh, maybe I should not have asked, but since we are here already…
> 
> 
> It seems that all this is inconsistent already.
> Why do we even have both, priority and rq_priority? Both should always
> be identical.
> 
> I suppose it is because we're in the "transition to CFS" phase where
> you will actually need a per-RQ-priority (rq_priority), later phasing
> entity->priority out.
> 
> Right?

The opposite - entity->rq_priority goes away when FIFO and RR are 
removed and we can (again) consolidate to a single run-queue. Until 
then, it is FAIR where priority != rq_priority (because everything is in 
the single run queue), and FIFO and RR where priority == rq_priority.

> If so, I wonder if we can't leave it be until we are at CFS?

I'd like to get the fixes in so I can mentally focus on the continuation 
of the bigger story. Not least that not fixing it causes sashiko to flag 
the bugs, either when touching the neighbouring code, or possibly even 
just the logical functionality.

Regards,

Tvrtko

