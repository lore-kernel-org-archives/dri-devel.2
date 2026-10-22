Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EB606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=LZcRw+G2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0210112568;
	Thu, 22 Oct 2026 11:42:33 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2258810E3FB;
 Thu, 22 Oct 2026 11:42:27 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9PQS0cXgzKnBt;
 Thu, 22 Oct 2026 13:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792669344; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmAOhFOUl+jgvj3w/Fv9SPPkZ2u6YRily7KkPBXzABY=;
 b=LZcRw+G2IK/jT6oj395A+7STUWrKsAdWs59UJmf5YR1Q945HOZGRtM2pg9/OKOnx3ku08g
 ORr+1a5eZiXNtDAcuk0vtKl4O5Si0LzVQJA7R8iTMEnwzkCrGf/TGF7pb8sjakz1/P6Sa4
 f+ctqHY/bieBpgKYpRaLr4Kt2qXAzTjHtzAb8Rzx6LSZbDdq+XskvD9/KDjZS9aG8cpYa6
 uzhMW6McnUAagSEuMzhbjcgL7SbiHZFJVvv47K3UMmw4qwe6IUvhjlDS0PhiFzUvtSItaV
 Yme1eqV8rpRjfj0WjfZck8ewslhvPdHMIFpUbZaTHspwaBu7Fqn/1jEHvICaog==
Message-ID: <3eff390804e2791e73733a38e245979f375b7b64.camel@mailbox.org>
Subject: Re: [PATCH] drm/scheduler: signal fences of jobs pushed to a
 stopped entity
From: Philipp Stanner <phasta@mailbox.org>
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com, tvrtko.ursulin@igalia.com, phasta@kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Date: Thu, 22 Oct 2026 13:42:22 +0200
In-Reply-To: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
References: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: a3pqdk7ewpj5pbxk8p1jd1imtb5xudnk
X-MBO-RS-ID: 9a57cb3bcd345bf0012
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Cc Danilo

Please use scripts/get_maintainer.pl


On Thu, 2026-10-22 at 12:54 +0200, Olivier Kaloudoff wrote:
> An earlier attempt [1] checked ->stopped without holding entity->lock
> and was rejected as racy; this performs the check under the lock where
> ->stopped is written.

I think it was also rejected because this as an attempt to fix a driver
issue in the shared infrastructure:

https://lore.kernel.org/dri-devel/61787d6cdbfbcb8acdd28c9b6ead50dfb0641899.=
camel@mailbox.org/


Who stops an entity?

It is amdgpu, which does so by calling drm_sched_entity_kill(). This is
the only place where an entity gets stopped.

Thus, amdgpu runs into an issue because it tries to push to an entity
which it has stopped itself. So the logical solution is to just not do
that :)

>=20
> Note: Tvrtko Ursulin's entity run-queue consolidation series [2]
> moves this code around, making drm_sched_entity_push_job() lockless
> and taking entity->lock inside drm_sched_rq_add_entity() instead.
> The orphan survives that series unchanged -- the job is queued before
> the NULL return and nothing completes it -- so this fix stays needed
> whichever lands first; the loser's side just needs a context rebase.

That is long outdated, Tvrtko has now agreed to getting us rid of the
spsc_queue, which means that _push_job() and _pop_job() will almost be
fully locked, with a nice clean linked list below.

>=20

[=E2=80=A6]

> =C2=A0
> +	/*
> +	 * A stopped entity is never put back on a run queue, so a job
> +	 * queued on it would be stranded forever and its fences would
> +	 * never signal, hanging any task waiting on them. Don't queue
> +	 * the job at all; run the normal kill-jobs work on it so its
> +	 * finished fence completes with -ESRCH.
> +	 */
> +	if (unlikely(entity->stopped)) {
> +		spin_unlock(&entity->lock);
> +		/*
> +		 * Balance the atomic_inc(&sched->score) above; the
> +		 * decrement in drm_sched_job_done() only happens when
> +		 * the job actually runs on a scheduler.
> +		 */
> +		atomic_dec(entity->rq->sched->score);
> +		DRM_ERROR("Trying to push to a killed entity\n");

Having a warning around here could be okay-ish I guess, but actual
operational code is not, because it fixes around the driver being
broken.

The warning would then merely be there to inform the driver that it
needs to be repaired.


P.

> +		INIT_WORK(&sched_job->work, drm_sched_entity_kill_jobs_work);
> +		schedule_work(&sched_job->work);
> +		return;
