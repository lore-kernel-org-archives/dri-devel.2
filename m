Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5795810E328;
	Mon,  6 Jul 2026 09:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WcvtDMPh";
	dkim-atps=neutral
Received: from mout-p-199.mailbox.org (mout-p-199.mailbox.org [80.241.56.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF7F10E328
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:42:58 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-p-199.mailbox.org (Postfix) with ESMTPS id 4gtztS34TszKnTJ;
 Mon, 06 Jul 2026 11:42:56 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WcvtDMPh;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:0:465::101 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gtztQ5lTCz8skM;
 Mon, 06 Jul 2026 11:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783330974; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ9jd7Zxu199hkJd1xLE7QEc/TjACmfRv6CygkoHVoQ=;
 b=WcvtDMPhCBewiHaBykCEOoSvuswegK7PLcuOYlytMHKbFR6ZZUVbBCgpotaZwg3Agw2hWF
 aTI3aIwp6TuopQUTf+yRrpo37hATExHA/kwl4OJ1SArEfPRP5/N2KE+8tMaYbOqlDyym2C
 HVp5Hw4RKl9QIzaI5sSFYtR9IOgIN5T0v9zlXy5AVNXleeBkXUQtv+UoCDv5OjSlQdDPe8
 1j8CNWuNQ01iSSthj/FL3aqJv1eKhVcgX0NUIi1R6tS3yaFOGPSzAWe9cC+Cg0Qkxmg3qm
 psZ7SL+0yWgIcUilk5UyCFTYIgpMNnK5BmNcm3HskTgN0mwJVxjrZwDhc+83ZA==
Message-ID: <0af946b7bef6958f103598083919bbf933423676.camel@mailbox.org>
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, Tvrtko
 Ursulin <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich	 <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Marco Pagani <marco.pagani@linux.dev>, Boris Brezillon	
 <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date: Mon, 06 Jul 2026 11:42:47 +0200
In-Reply-To: <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
 <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
 <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: df8126bf0d27855a51c
X-MBO-RS-META: f8ykmoj3beju11nmnkzj8i63r46bck87
X-Rspamd-Queue-Id: 4gtztS34TszKnTJ
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

On Mon, 2026-07-06 at 09:45 +0100, Tvrtko Ursulin wrote:
> On 03/07/2026 15:47, Philipp Stanner wrote:
> >=20
> >=20
> > I think it can detail which functions will now be locked; but
> > mentioning the users would be overkill and is uncommon for API reworks.
>=20
> Here I disagree quite strongly. Given the patch is making strong claims=
=20
> that the lockless access was added for no obvious reason, and that we
> have now established the lockless helper is in fact used on the=20
> submission paths, it is really required that those strong claims are=20
> backed by a concrete analysis instead of just saying "not performance
> critical in any way".

This is a strong case for the reversal of the burden of proof.

The entire code base of drm_sched has been designed on the computer
science premise of locks being evil. That's why literally all
synchronization primitives except for locks have been used where
possible, including undefined behavior. The designers tried as hard as
they could to avoid locks.

That is clearly proven by the fact that in all original data type
definitions, the only components that were locked were always lists,
since those are the structures where you really cannot avoid a lock in
most cases.

The aversion to locking was so great that they designed spsc_queue,
which uses at least as many as expensive instructions as a lock + list
would have needed, and its correctness is not proven, nor are its
behavior and rules neither documented or proven.

It's not up to the faction who wants to use correct locking and phase
out UB to prove that the locklessness is bad, but to whomever added the
locklessness to prove why it is good, i.e., necessary =E2=80=93 which was n=
ot
done here, neither in comments nor commit message. So the reasonable
assumption is that it's simply a leftover from a flawed, broken design.

And the kernel-workflow is that things are always on-list for a while
before being merged is that parties who do have concerns and who can
point out problems have time to do so. Which is of course open to you:
do you see a performance-regression problem with this patch, and if so,
where?

Anyways:
 * Correct me if I'm wrong, but it would seem the only driver-usage
   which could see a *new* lock in its path is
   drm_sched_entity_error(), for which you yourself agree that it's
   irrelevant performance-wise. Should we still list the user's of that
   function?
 * The other relevant user path, drm_sched_job_arm() via
   drm_sched_entity_select_rq(), must already be called under a common
   driver lock for drm_sched_entity_push_job(), and _select_rq()
   already takes the entity lock. So any significant regression here is
   hyper unlikely.
 * The only other contender is the job pull path, which runs serially,
   by 1 work item at one point in time.
 * drm_sched_entity_kill() / _fini() are used in user context teardown
   path. Performance irrelevant.

I can offer to add the list above for the justification of why removing
the half-undefined behavior is good.

Or what exactly would you want to see documented? "amdgpu uses
drm_sched_job_arm() and now sees a lock-critical section longer by 3
instructions. etnaviv uses drm_sched_job_arm() and now=E2=80=A6"?




P.
