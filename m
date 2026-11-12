Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2E606B24F
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HuQYRPR7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56BA10FDF3;
	Thu, 12 Nov 2026 08:49:20 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530DF10FDF3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:49:03 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jQDZd66t2zKnTT;
 Thu, 12 Nov 2026 09:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794473337; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alzMJs4adjqBFbZrKkqV3hABIS76fUp64iOReTaXvdw=;
 b=HuQYRPR79kzM4pxp1DAKAhI+qzIVO03SaVrCpQs/p1sIUutV8tRte4kGTbeJhpapt8u4xA
 LK83bWDHIoEyyhI3D0uEd7NfVICXoin4oe2gpOrjEUyIj4dQ0JQZ/AI5MAR+rw6krjpXQu
 Ms1B8PsZITfQXCczVdD6xXiSjwoKlxZfiHz3nieuH6vSI5bOmKg978Ig3LTrOTOAwXC6ZK
 +w3Z7m4UwO51nsTsPnHE7X0e7xv48RC0/hVqE9Nb9eBxwoN1LpSIvkWPkx1UBXPX0pJKmE
 cNnHNlxaEWV92xAG+YRgaKUz5BljPbeh/eK3oS1rCJzuBFBknj7eX3oArt3THQ==
Message-ID: <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>, "Paul E.
 McKenney"	 <paulmck@kernel.org>
Date: Thu, 12 Nov 2026 09:48:49 +0100
In-Reply-To: <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: k1deue8az9fyiy7ea4hsrsw7m3d5hein
X-MBO-RS-ID: d740cfd46c66c6e4555
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

On Wed, 2026-11-11 at 15:05 +0000, Tvrtko Ursulin wrote:
> jobs. It did not feel worth explicitly putting cc: stable on the patch.

OK.

> > This is the *next* job's scheduled fence, so this sounds suspiciously
> > racy. Testing the bit and overwriting the timestamp, can't that race?
>=20
> I have a feeling the code was assuming the default ordered workqueue=20
> ensures either run_job or free_job runs at a time. So seeing timestamped=
=20
> next fence guarantees free_job has exclusive right to the timestamp write=
.
>=20
> That is not true though for the three drivers which use own unordered
> workqueues - pvr, nouveau and panthor.
>=20
> If we look at the drm_sched_run_job_work():
> ...
> 	drm_sched_job_begin(sched_job);
> =C2=A0 -> puts on a pending_list for free job to find
> ...
> drm_sched_fence_scheduled(s_fence, fence);
> =C2=A0 -> signals the scheduled fence
> ...
>=20
> If free_job interleaves in the middle, so it sees the next job but it
> looks unscheduled it will skip the correction.

I'm not even sure why this is done here. We just overwrite the fence's
timestamp. Why?

The fence gets marked (signaled) as scheduled in
drm_sched_run_job_work(). Hence, that should be the relevant point in
time. Why should free_job() have anything to do with that?

Looks very suspicious. As if there are two redundant mechanisms here.

> Yes I think you are right. As said I think there is no real bug due race=
=20
> with unordered workqueues, but for formal correctness it would require a=
=20
> memory barrier after test_bit, or full blown locking.

Is it guaranteed that this fence is signaled and, thus, has a
timestamp, or is it not? If it's guaranteed, the test_bit() is actually
unnecessary. If it is not guaranteed, then there can be misordering
between the two operations and it's UB and, thus, a bug.


That said, I'm OK with your patch here being merged since you did not
cause that chaos / problem, but a second patch with a FIXME about the
issue that links this mail-thread would be good.


P.
