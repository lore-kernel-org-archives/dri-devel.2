Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B71C624D5
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CB510E498;
	Wed,  2 Sep 2026 10:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SCWmuZlL";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A44410E498
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:07:26 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hZdgv0bBszMlGN;
 Wed, 02 Sep 2026 12:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788343643; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd2QZHuCqki2/DZSJKeq7TNX1Q38m5J7uP4gfs4WbPI=;
 b=SCWmuZlLeSiBk56qd6bJ/pnhSxcstWyQicJ7DMbIQR4W3NRXi1Oz4lBTfaoF1i7oIrLWjX
 jcmpWBxn1ucSI9+k77D87Q1I18av1R7OexGzrYkTiHEevmdf73Il/Ljwhh4RE5jLWVFlFK
 KmjcxN/Tedy5WjsQ6MfOGodiw/db79HlYxtwj5k8Bgd8ghEBBNOW77PSzXZ0iCylw9m9Ru
 OdDUhHKrp699WWUFdL++jGbIshR+TZOLcV2t3WB6DR5nmFucRnueCaz5n8J0n6NeK/olfI
 BN9FSk2INdd0Jmeglnl+qIoR8pFpWInL+Z0KzbzvBqQsQKAvxw81Pi/8fi1rBQ==
Message-ID: <b8f98b9e04c9999008bcdec270b14247e3cd18d0.camel@mailbox.org>
Subject: Re: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: =?UTF-8?Q?=EA=B9=80=EC=A2=85=ED=98=81?= <malhyuk97@gmail.com>, 
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org,
 phasta@kernel.org
Cc: christian.koenig@amd.com, ckoenig.leichtzumerken@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 12:07:19 +0200
In-Reply-To: <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
References: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
 <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ed49uz6hqoh8dm5q1wrh6qcuhpig4cdx
X-MBO-RS-ID: 58e6fea7db5b6a90fe7
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

On Wed, 2026-09-02 at 02:57 -0700, =EA=B9=80=EC=A2=85=ED=98=81 wrote:
> On 02/09/2026 10:46, Tvrtko Ursulin wrote:
> > It is not guaranteed in the documented contract that the name passed to
> > drm_sched_init has to outlive the scheduler.
>=20
> Right. Caching the bare pointer only works because every in-tree driver
> passes a string literal today - xe's q->name (freed with the exec queue,
> hence 299bc6d50b1b) is the counter-example where v1 would still dangle.
>=20
> > Hm, that might be overkill.. how about we just keep a copy of the name
> > in the scheduler object?
>=20
> The catch is the scheduler object is itself freed on context teardown, so
> a copy that lives there dangles for the exported fence just the same. To
> actually stop dereferencing ->sched the copy has to live in the fence -
> kstrdup in drm_sched_fence_init(), freed from the fence release. That's a=
n
> alloc per fence on the submit path though.
>=20
> If that overhead isn't wanted, the lighter option is to keep the pointer
> and document in gpu_scheduler.h that the drm_sched_init() name must follo=
w
> the dma-fence safe access rules (outlive any exported fence). That matche=
s
> what the already-fixed drivers do and leaves the submit path untouched.
>=20
> Either one fixes amdxdna/nouveau/msm in the core. I'd lean to the
> documented-pointer version unless you'd rather pay the kstrdup - let me k=
now
> which and I'll respin as a core-only series (fix + the kunit test).
>=20
> Thanks for the 6bd90e700b42/299bc6d50b1b context, that clears up what the
> half-fix missed.


The issue here IMO is that we are discussing working around an issue
that actually stems from dma_fence not being consistently synchronized,
notably because of the ops->release callback being implemented.

ops->release is de facto deprecated, precisely for reasons like these.

If we could get rid of it for sched_fence, dma_fence would take care of
the decoupling of the name callbacks.

So that appears worth investigating from my POV.


P.
