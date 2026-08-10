Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926CCC5B575
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7917410EAAD;
	Tue, 11 Aug 2026 07:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="FFJVgUKV";
	dkim-atps=neutral
X-Greylist: delayed 148019 seconds by postgrey-1.36 at gabe;
 Mon, 10 Aug 2026 16:40:55 UTC
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4CA10E934;
 Mon, 10 Aug 2026 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786380051; x=1786639251;
 bh=O5jCfkoJY0H4PdQhix+wbkevzWgpLvmwylGYlo1nJ4U=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FFJVgUKVpAgNN4QiEV4aTabD26nDmpu7izKtqlAbAGe7PwC8W7l2rwjnCq7jI+bF7
 5f2SDD1rn3oMtMnXWGxjxGC+M4n564ZjNPUmFpeRKlgTwgZ0THsBEncEX1J0v8+IIv
 dZgvzf+jQfuRflWXBlzWwo2oSTzEpkxBJx/qwz+ZKoSOXrWL3RB7MHSu5OONTxlMbY
 a0rp4L6mKiZ5/061FSMBQr9a8345xK9lwWp28QUpdLoexnEUBhzQfYu8MZZP43+P8b
 alOo5ai1cYLGGRmjWl8Bm9i9hIQ1qI25B+yskNHpwWD3ycl/8eSQ6i3rIuSzI04p8s
 PEl7bxHueo1Dw==
Date: Mon, 10 Aug 2026 16:40:43 +0000
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
From: Luke.Wildhardt@proton.me
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@mailbox.org>,
 phasta@kernel.org, "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
Message-ID: <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
In-Reply-To: <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
Feedback-ID: 214028577:user:proton
X-Pm-Message-ID: 956e93293421320c46863540605e532c2bf0367a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

Oops, forgot to reply all in my last message.

I did a quick test of the patch before I left this morning, the freezing se=
ems to gone, but when the GPU is under the same condition, the stuttering i=
s more uniform if that makes sense. Granted this was only a 5 minute test b=
ut the freeze was rather reliable before, I can do more testing later.

I know these things can be hard to describe, if that helps. If there's any =
profiling I could do or detailed logging that would help don't hesitate to =
ask.



-------- Original Message --------
On Monday, 08/10/26 at 06:48 Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wro=
te:

On 10/08/2026 13:45, Danilo Krummrich wrote:
> On Mon Aug 10, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
>>> Reverted Commits:
>>>
>>> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
>>> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
>>> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
>>> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run=
 queue
>>> 45c211ddf92a drm/sched: Switch default policy to fair
>>> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
>
> [...]
>
>> That might be the wisest thing to do; but let's hear if Tvrtko has an id=
ea for
>> a hotfix first.
>
> -rc7 was released yesterday; even with a working hotfix today it'd be tri=
cky to
> ensure the hotfix does not regress other drivers or workloads with 7.2 be=
ing
> just a few days ahead.
>
> I suggest to not wait and get the reverts ready.

Yes reverts would be safer. I have them in a branch at
people.freedesktop.org/~tursulin/drm-intel drm-sched-fair-reverts,
mostly straightforward apart from one easy conflict in
amdgpu_xcp_release_sched. Smoke tested on Steam Deck looks fine.

Having said that, the fix for min_vruntime handling I provided earlier
in the thread also looks fine in my testing and is simple. No
regressions found with synthetic unit test workloads or messing around
on the Steam Deck. But we need to wait to hear from Luke since I haven't
been able to repro his report locally yet.

Regards,

Tvrtko


