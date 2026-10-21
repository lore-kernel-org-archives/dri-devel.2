Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF44606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hZjYcSLB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071EB10FD09;
	Wed, 21 Oct 2026 09:00:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF0110FCEA;
 Wed, 21 Oct 2026 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=oQFRAIN/Kg+rUKxxIhXpQ/3PZ6B2SGP/yaVRNhzlPzs=; b=hZjYcSLBv+GenKn7PKDAysOL5K
 9x8dn7ygE8zziHVviibkGXh68LVJWG1mtK3TW/mYZ4yqcw4iO+jkEccW7RzYdoqmBVHMjqIGf8DGt
 zOxouy6M6MKrNzohSPc1xLcFykYYWslYf2EP+uuP4w4hZwh1179oRkVX0y0L65HQXj1avPTHebskz
 aeALfH7//QVqPNpbs+H0VOBgqxX1iWBSibjej+1ME49pzIQuG5W+Y1eYYzbO40zqTsK1yjZl0APaN
 dNk1rWu37AHSJnM2lfDM+BrnFASZPvIc+xx1oue9e7Bx+WOO8ue5s/qlHo3nhH1Zm/3racYT8LhHM
 JQ4e70aw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJSB4-005SSz-Lw; Wed, 21 Oct 2026 11:00:06 +0200
Message-ID: <af06597a-7759-4d48-914a-c5364794346c@igalia.com>
Date: Wed, 21 Oct 2026 10:00:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] DRM scheduler assorted cleanups
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <1f102ca178b7101008e45b796dc67a64cee0b029.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <1f102ca178b7101008e45b796dc67a64cee0b029.camel@mailbox.org>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/10/2026 17:04, Philipp Stanner wrote:
> On Tue, 2026-10-20 at 16:41 +0100, Tvrtko Ursulin wrote:
>> A little bit of a dump of my patch queue leading towards the SPSC queue removal
>> (which is still WIP). Primarily because Philipp asked me to rebase and re-post
>> "drm/sched: Replace completion with a flush".
> 
> What's your merge plan for this? Since it's a series one would expect
> that things depend on one another, but patches like 4 look surprisingly
> independent.

It is not quite there yet according to sashiko, but in principle, deal 
with logical units in the order of the series, since that is what avoids 
conflicts.

>> Then I realised we agreed to split out one part of that in a separate patch.
> 
> completion ⇒ flush patch now need to be part of a series? It was
> independent before.

Cover message explains it. We agreed to split it into two, and then I 
realized one more patch is needed to make it more believable. So it's at 
least three for that logical block.

>> Specifically "drm/sched: Ignore stopped entity attempt to change its run-queue".
>> And I also realized that one is easier to argue for if we also try to tighten
>> the rules around entity initialization. Which is "drm/sched: Disallow
>> initializing entities with un-initialized schedulers".
>>
>> Then there are some trivial cleanups in the same area which should be easy
>> reviews.
>>
>> The first patch of the series feel free to ignore. I have sent it separately
>> already but need to include it so the series actually applies, both for CI, and
>> should someone want to apply the series.
> 
> But why is it a series when so many things are independent? :(

Most touch either drm_sched_init() or drm_sched_entity_init() so sending 
them separately would make some not apply. Or for example first patch in 
the series, the fix for a theoretical regression, I've sent separately 
but is still unreviewed and the rest of the series depends on it as 
well. That is also explain in the cover letter.

Anyway, there will be a respin when I get to reading what sashiko found 
in this round..

Tvrtko

