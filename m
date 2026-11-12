Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E58606A884
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TBIMCm+q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FC810E29F;
	Thu, 12 Nov 2026 14:27:24 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693E010E29F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:27:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jQN4z1kTxz8snG;
 Thu, 12 Nov 2026 15:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794493635; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFar2GgmS4QV/Ptvj3CgdIR9gIlj58NOlAIQYrUBxnU=;
 b=TBIMCm+qT6Xs/zYUHf8V2rh4tw5M5aNBNRtnvevLBBO3SOq++6LtOm/IisJErSJOW/W13+
 tnTDa0zStcxQoolllYFkujX3Y2uR+J+LWNFnsH8HMZvT36hJcXBVopJFSPjIGHsyxxovYZ
 z8rENLn90YX9147w9c6CR7VG1L5ejwKvFK9QCGt4M+UfM3wcfzCa8R/4IuAkm96oB9Vo4h
 1zvqXVHi0lY74EIH5RDYunuIffST8jMpSJafkZTK/6QXePNqMdkVBNH1N+cF0IFF/AC0vn
 s17uoKh4OJzTRXTUmRuEhXzAntjoWrNy95wOpxD9MMWaveVBh9xPWHyQzc1Uxg==
Message-ID: <1f2143d213d22dec427ae1bcfc7cbfe2d34ab83a.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>, "Paul E. McKenney"
 <paulmck@kernel.org>
Date: Thu, 12 Nov 2026 15:27:13 +0100
In-Reply-To: <4606cd56-f1c5-4a00-b9ba-fdbf2206681d@amd.com>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
 <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
 <4606cd56-f1c5-4a00-b9ba-fdbf2206681d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b027d31a49d435f3553
X-MBO-RS-META: ffy9ow4md97w99o3y5j6ab7xe6yqo5jz
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

On Thu, 2026-11-12 at 15:15 +0100, Christian K=C3=B6nig wrote:
>=20
> To allow drivers to more accurately calculate how much time the job spend=
 on the HW.

It's still just not a very good idea to randomly overwrite a fence's
internal value without a formal API contract. This should have done
through a dma_fence_overwrite_timestamp() which is responsible
centrally for the ordering, or, even better, through a separate
timestamp in drm_sched_fence.

Why do they care btw? As far as I have ever seen only amdgpu uses the
scheduled fence. What do you do with it?

I see why Tvrtko needs it, to do the fairness algorithm.

> The time it was pushed the to HW queue is pretty uninteresting for the ti=
me spend on the HW.
>=20
> What you need is the time it started running and that is when a the previ=
ous fence completes.

OK, I see.

> > Is it guaranteed that this fence is signaled and, thus, has a
> > timestamp, or is it not? If it's guaranteed, the test_bit() is actually
> > unnecessary. If it is not guaranteed, then there can be misordering
> > between the two operations and it's UB and, thus, a bug.
> >=20
> > That said, I'm OK with your patch here being merged since you did not
> > cause that chaos / problem, but a second patch with a FIXME about the
> > issue that links this mail-thread would be good.
>=20
> I've considered this approach as well when we originally merged the
> change, but the timestamps are only like 90% accurate anyway so to be
> honest I don't think it really matters.

You have considered which approach?
What do you think of the memory ordering problem I point out?

And btw above you said that this is done so that drivers can do
something "accurately" :)

But as I said to Tvrtko, we are where we are. This here is no big deal,
but I really want to get the dma_fence memory ordering set straight and
well-documented. The usage patterns have fragmented. It's completely
unclear whether what drm_sched does here is actually legal.


P.
