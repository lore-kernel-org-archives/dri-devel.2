Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E8606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Cza1Asfe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69B610E87C;
	Wed,  4 Nov 2026 10:43:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2961E10E596;
 Wed,  4 Nov 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=C1t2w24fWeOoDhxdfcptUtgJ8R2xYuJdVJTWO4qDgQg=; t=1793789029; x=2109149029; 
 b=Cza1AsfeNQgj60oI7iZpquv+sr850LBoMGX8RovsLLQjCBznjrXfuScquE3v5RwR/Mv8jKgkz7C
 RXWIor+k548wQxOtFKvIPCUMhIatHzd3l2JsC2J+9biyssOHosGlqpJ50JP4X/FaIUC4nHPPJM3hx
 C1W3BabltGznChiltiSo087/JHarUYmcUMK4L8rXWW/BCMPEKY/zZlvGkTnVMgtJZX9ME/98oAUBS
 /xBMan2Ff1m7F4xP/va88V6jzqwQ16eEirMVUPdBv0whJDsOckUo1DmOwyjsFvi6OcC7HRHldjgKq
 wp/jS7iY9gmHrJXqq5A5ditQsh09lbpP51VA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOYT4-002AYb-D5; Wed, 04 Nov 2026 11:43:46 +0100
Message-ID: <7277f083-2d17-4bed-bdaf-e6c616cc5ec9@igalia.com>
Date: Wed, 4 Nov 2026 10:43:45 +0000
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
 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
 <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
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


On 04/11/2026 08:48, Philipp Stanner wrote:
> On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
>> I lost you here - what should the comment say?
> 
> Just a "TODO: entity->rq_priority could not be fully removed due to the
> partial revert of the CFS scheduling rework. For formal correctness, it
> still has to be adjusted here".
> 
> Just so that the reader sees that this is in an intermediate state
> right now, and so he's incentivized to git-blame the TODO to find the
> associated commits and mailing-list-archives.

I would rather not do it in a patch with a Fixes: tag, or actually at 
all - it feels arbitrary to sprinkle a TODO mentioning future work at a 
single random place like set_priority(). Could we go with these two as 
they are and continue from there?

Regards,

Tvrtko

