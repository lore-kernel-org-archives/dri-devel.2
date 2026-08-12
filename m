Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC240C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B60C10EF9C;
	Wed, 12 Aug 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K64zQzNI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822AA10EF9C;
 Wed, 12 Aug 2026 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=70G4rGw4LXyZZd0eBpnHPHIIA6WX6NpH2rsQoiT5QaA=; b=K64zQzNI7KBpJZ3Oi7kvGElG6L
 C8IWDmWcvzqvB6s+YklFdHGlN4AOpdh5+nSCpR6myTHvnNgxfIs+GBLjEqZMxe4avOglNjq64A4cc
 4BgbXeHvPlO710p+MWX7SfEcgeyz6jUdLUcYPiUpDCZDHqXTFQy4pUQ752sO6/HqXd6WTbZOkIMCO
 /Uz8EZkoLKX+/zC3I9NFmID0RDtWtriHTwxZtzW+xZlyucl+VsEUcm6gkvwzpUWUxASgrra6a74Gp
 VDtyviPEUmsCYQOX0xwPZbeS9kBFY6IgWMpEO5IKEYZGQFl1xcyaToG5k3pP4ZzS1xg2kAi0GrY5/
 qLNSWQHA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wu855-0001VV-Hx; Wed, 12 Aug 2026 14:29:15 +0200
Message-ID: <ab60bdb4-351f-4911-9246-2719d078cb96@igalia.com>
Date: Wed, 12 Aug 2026 13:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
To: phasta@kernel.org, Luke.Wildhardt@proton.me
Cc: Danilo Krummrich <dakr@kernel.org>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
 <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
 <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
 <932892b196f7bbba7f5e9bff22f9b484854aaccc.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <932892b196f7bbba7f5e9bff22f9b484854aaccc.camel@mailbox.org>
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


On 12/08/2026 12:58, Philipp Stanner wrote:
> On Wed, 2026-08-12 at 12:37 +0100, Tvrtko Ursulin wrote:
>> Jokes aside, I agree with the above analysis that a better fix would be
>> to pull things under the lock, and interestingly, Philipp had a lock
>> widening patch not so long ago but I don't remember what happened it or
>> how exactly did it look. It would possibly have fixed this problem.
> 
> https://lore.kernel.org/dri-devel/a0d969408a5a55dfb6d0b3e65906fd7bbf3eee1c.camel@mailbox.org/
> 
> TBH I got discouraged and increasingly dissatisfied with the state of
> our community, because whenever I try to fix things that are
> *obviously* broken and incorrect (and which were usually not broken by
> me), with relatively simple patches, I have to work uphill and only
> receive pushback.
> 
> Reviewers and supporters are usually absent unless they want to have
> more features or performance-hacks added, though it is apparent that
> many indeed read what we are doing.
> 
> Should things get better it's usually not acknowledged, and should
> things go wrong one runs danger of getting blamed with hindsight-bias.
> 
> Had my patch landed and (speculatively) prevented this regression, no
> one would have noticed, but Phoronix would write some nice article
> about the FPS gain in video games, achieved by Tvrtko Ursulin :)

Not sure if you are calling me out here or not, since apart from a 
direct mention, the lore link above is also a reply to my email, so for 
the record, I did give my ack for those patches. Plus I spent time 
testing them. So if you were in fact calling me out, I don't see how 
that is warranted. And on the wider topic I also never shied away from 
the non-glamorous work.

Going back to your linked patch series, now that I re-read it and 
reminded myself, it wouldn't have solved the regression from this thread 
since it left drm_sched_rq_pop_entity() outside the lock. But I did 
agree even then it was a step in the right direction. So if you respin 
it (last patch seemed buggy according to sashiko), maybe replace with my 
version of the completion removal (what happened with that one?), 
ideally fold the patch which removes the double re-lock cycle into the 
actual locking change (I think that's better), my ack still stands.

But I also still think ack from AMD is needed as well since the changed 
code paths are by large used from amdgpu.

Regards,

Tvrtko
> 
> Ah well.
> 
> My vision for drm_sched has been that we absolutely need to start
> establishing strict computer science standards and have to prioritze
> formal correctness, simplicity and documentation over features and
> *especially* performance.
> 
> Though I maybe should have tried to be more polite and diplomatic about
> it, the evidence that I see is that the DRM community does not actually
> want the above. At least I have to conclude that from the lack of
> encouraging participation and the presence of discouragement.
> 
> So if I want to add a spinlock for something obviously broken, the
> burden of proof is on me, not on the one who broke it. If I want to
> prevent someone from adding a 4th drm_sched_start_x() function for
> performance-reasons, then I receive not-so-nice emails.
> 
> Folks here seem to want to continue like they did for the last 15
> years.
> 
> If anyone here reads this who *doesn't* want to continue like we did
> for the last 15 years, then I would kindly ask for public participation
> and help with moving things towards the right direction. Simple emails
> with "I support this idea, +1", would almost be enough.
> 
> 
> It would seem that these recent event might proof that I was right
> about our fundamental issues.
> 
> 
> P.

