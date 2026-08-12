Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FB3C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A78210E417;
	Wed, 12 Aug 2026 11:59:01 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6CE10E417;
 Wed, 12 Aug 2026 11:58:59 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKn8L1qlzzKvxn;
 Wed, 12 Aug 2026 13:58:58 +0200 (CEST)
Message-ID: <932892b196f7bbba7f5e9bff22f9b484854aaccc.camel@mailbox.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Luke.Wildhardt@proton.me
Cc: Danilo Krummrich <dakr@kernel.org>, phasta@kernel.org, 
 "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "ckoenig.leichtzumerken@gmail.com"
 <ckoenig.leichtzumerken@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Wed, 12 Aug 2026 13:58:54 +0200
In-Reply-To: <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
 <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
 <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: c458c48d41946d84b5f
X-MBO-RS-META: 4gth8jcm81u5wkqkmj6m45i1ad48gjpj
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-08-12 at 12:37 +0100, Tvrtko Ursulin wrote:
> Jokes aside, I agree with the above analysis that a better fix would be=
=20
> to pull things under the lock, and interestingly, Philipp had a lock=20
> widening patch not so long ago but I don't remember what happened it or=
=20
> how exactly did it look. It would possibly have fixed this problem.

https://lore.kernel.org/dri-devel/a0d969408a5a55dfb6d0b3e65906fd7bbf3eee1c.=
camel@mailbox.org/

TBH I got discouraged and increasingly dissatisfied with the state of
our community, because whenever I try to fix things that are
*obviously* broken and incorrect (and which were usually not broken by
me), with relatively simple patches, I have to work uphill and only
receive pushback.

Reviewers and supporters are usually absent unless they want to have
more features or performance-hacks added, though it is apparent that
many indeed read what we are doing.

Should things get better it's usually not acknowledged, and should
things go wrong one runs danger of getting blamed with hindsight-bias.

Had my patch landed and (speculatively) prevented this regression, no
one would have noticed, but Phoronix would write some nice article
about the FPS gain in video games, achieved by Tvrtko Ursulin :)

Ah well.

My vision for drm_sched has been that we absolutely need to start
establishing strict computer science standards and have to prioritze
formal correctness, simplicity and documentation over features and
*especially* performance.

Though I maybe should have tried to be more polite and diplomatic about
it, the evidence that I see is that the DRM community does not actually
want the above. At least I have to conclude that from the lack of
encouraging participation and the presence of discouragement.=C2=A0

So if I want to add a spinlock for something obviously broken, the
burden of proof is on me, not on the one who broke it. If I want to
prevent someone from adding a 4th drm_sched_start_x() function for
performance-reasons, then I receive not-so-nice emails.

Folks here seem to want to continue like they did for the last 15
years.

If anyone here reads this who *doesn't* want to continue like we did
for the last 15 years, then I would kindly ask for public participation
and help with moving things towards the right direction. Simple emails
with "I support this idea, +1", would almost be enough.


It would seem that these recent event might proof that I was right
about our fundamental issues.


P.
