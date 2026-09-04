Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16A9C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C1A10F96C;
	Fri,  4 Sep 2026 08:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TbZNw/no";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062B810F96A
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:40:03 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbqf73hkpzMlP2;
 Fri, 04 Sep 2026 10:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788511199; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH2uLsC7WJQSI+F9UTh8XM4wmuGO2p9r3sUh4J5zSQQ=;
 b=TbZNw/noO1prHxarOkgk3xXiT7Yddgx5Sl94ZILtzjInU7nBko+3rNtbBr3gSq4VxP8Eg1
 5MKoAQPTK7xcGXwENxEpfh4Kr4XFTRXuAYKcDxu/yGRIfjpo1xZ6pbyaLYQVmd/jM0OVGP
 lj+n+LbT0y0Dqgj4Z1LJJjDCfBR0GoaWE+SvPEHCZ0RS8db9F4v7SSRAUWK+DKTBwuFObZ
 QKTq5L8P45UUeoGEtePFBYgJwlIxgDNOJN0n/s4vvi1gkbSMj9N8fIgaiJ36lpceFeGy+N
 UL4EUkbETQzMlnzHDVP4pV+/ExNb9OQIVMHya94nm/Lvqp6C39FxNPdK9ZnYzA==
Message-ID: <196070b75705e9bc38106c235dab75e92d98cb2b.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, christian.koenig@amd.com,
 phasta@kernel.org, tursulin@ursulin.net, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Date: Fri, 04 Sep 2026 10:39:55 +0200
In-Reply-To: <20260904083138.2135429-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <20260904083138.2135429-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 878bbfafc54389cb408
X-MBO-RS-META: 5m9cmtes7t7juujy1d8z5qotj7cypkqf
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

On Fri, 2026-09-04 at 17:31 +0900, Jonghyuk Kim(MalHyuk) wrote:
> On 9/4/26 10:20, Christian K=C3=B6nig wrote:
> Understood - ops-detach is about producer/module decoupling, not about th=
e
> scheduler's lifetime relative to the driver, so framing it as "the comple=
te
> fix" for this bug was wrong. I will drop the TODO patch as well.

Please wait a bit until we discussed it for a bit.

>=20
> > I think we should rather re-consider patch 035219a760edb35ae9a9e96beba7=
f122e26a997b
> > ("dma-buf: dma-fence: Fix potential NULL pointer dereference"):
> > [...]
> > The problem is that we didn't considered that there a fence implementat=
ions
> > which still have a release or wait callbacks but rely on not needing to
> > return a string for a signaled fence.
>=20
> That matches what I see in the code, thanks - this is the actual root cau=
se and
> it is not drm/sched specific.
>=20
> dma_fence_signal_timestamp_locked() only clears the ops pointer for fence=
s that
> carry neither .release nor .wait:
>=20
> 	ops =3D rcu_dereference_protected(fence->ops, true);
> 	if (!ops->release && !ops->wait)
> 		RCU_INIT_POINTER(fence->ops, NULL);
>=20
> drm_sched_fence implements .release, so its ops survive signalling. Befor=
e
> 035219a760ed the helpers gated on the signaled bit, so such a fence retur=
ned
> the static string and the producer callback was never reached. Since that
> commit they gate on the ops pointer alone, so get_timeline_name() /
> get_driver_name() are called on a long-signalled fence - which is exactly=
 the
> window my report hits, with ->sched already freed.
>=20
> To be clear, I am not suggesting a revert: 035219a760ed fixes a real prob=
lem,
> namely that "set signaled bit, then NULL the ops" and "load ops, then che=
ck the
> signaled bit" can be reordered on weakly ordered platforms, and using the=
 ops
> pointer as the synchronization point solves that elegantly. That property
> should stay.
>=20
> What seems to be missing is that the ops check answers "may I dereference=
 the
> pointer", not "may I call into the producer". The dma-fence rules say the
> latter is not allowed once the fence is signalled, so I think both condit=
ions
> are needed:
>=20
> 	ops =3D rcu_dereference(fence->ops);
> 	if (ops && !dma_fence_test_signaled_flag(fence))
> 		return (const char __rcu *)ops->get_timeline_name(fence);
> 	else
> 		return (const char __rcu *)"signaled-timeline";
>=20
> The ops load keeps the RCU/ordering guarantee from 035219a760ed, and the
> signaled check restores the contract. That fixes every implementation whi=
ch
> keeps .release or .wait and assumes it is not called after signalling, ra=
ther
> than just drm/sched, and it puts no lifetime burden on drivers.
>=20
> Philipp, since 035219a760ed is yours - do you agree with adding the signa=
led
> check back on top of the ops check? I would rather have your ack on that =
before
> I respin.

That commit has to stay because it solves an ordering problem on some
architectures.

I do agree to having a conversation with Christian in my other mail,
where I wonder whether it would be better if a driver does the is-
signaled check, holding the lock.

These things are extremely complicated and cannot be rushed. We
discussed dma_fence synchronization for weeks this summer and concluded
that there is no easy solution at hands for some problems, notably
because of callbacks and legacy callbacks, and also because Christian
and I disagree on to what degree a fence should be locked.

>=20
> One thing I noticed while checking the callers: the tracepoints in
> include/trace/events/dma_fence.h and drivers/gpu/drm/amd/amdgpu/amdgpu_tr=
ace.h
> call fence->ops->get_driver_name() / get_timeline_name() directly instead=
 of
> going through the helpers, so they are not covered by the above. That loo=
ks
> like a pre-existing and much narrower exposure (tracing only), but let me=
 know
> if you want it addressed in the same series or separately.

Do you generate part of your mails with an LLM? It seems to be a huge
corpus for 11min of time between receiving and answer


P.
