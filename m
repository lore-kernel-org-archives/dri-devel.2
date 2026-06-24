Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F04FCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C529610E047;
	Wed, 24 Jun 2026 07:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j738PO5c";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B19610E047
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 07:33:58 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4glYb62rNLz9tw3;
 Wed, 24 Jun 2026 09:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782286434; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xhqANqXbBDjD09Kcx3ptU85p1q/zZqKt88Vv4SvkH0=;
 b=j738PO5ccKMhV73EZ88zzWFCVeZeXn94C+R0K2QIyN3ab/CDS1w1b+YnnbsQRXZknXAGVR
 Dj0w+C+qK3faK+GrBaalyRck1ih+GMsBjr8gmjAPxiX7uEXQVu4uIXn1DaODjuUor+8gqM
 f4x9HhJ68SUn3XOgkqfWp+DmegWH5UB2DhvcUxEE5vejdAcSQskOu4HwR6iHxf3EVpmIGE
 CkySYvI3aSzZ+u1xkopwykwY3tihD1H91Zcov7TFjEIgAIVHMJwToi2Gzg3fVdq2bfojK/
 dHScushEe/9FKBTnS7vNYRg8up0+z2oBvY2QCwVI+or9wL98EGB6c1uUgopNww==
Message-ID: <2f2c50a8ff6d3fdd42d0d10535a129dd5a948801.camel@mailbox.org>
Subject: Re: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>, 
 phasta@kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Wed, 24 Jun 2026 09:33:48 +0200
In-Reply-To: <1467578694a17b2b4978a6193cf21db324daff98.camel@linaro.org>
References: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
 <1cfd56b7f1a166e25d6588d66a621524f3d983de.camel@mailbox.org>
 <6483098adae29787862473e39b1f9cf3c3f16625.camel@linaro.org>
 <f59d6080cf31f424ebcf0e6086b4a93623813a6e.camel@mailbox.org>
 <1467578694a17b2b4978a6193cf21db324daff98.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 9d260a57382f0a7e894
X-MBO-RS-META: ua5w6qn7zzqcxerqb93cb4bo1d85bkrk
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

On Tue, 2026-06-23 at 15:33 +0100, Andr=C3=A9 Draszik wrote:
> > However, if my issue were to be solved with barriers, the
> > test_and_set_bit() in dma_fence_signal_timestamp_locked() would have to
> > be replaced with the more weakly ordered test_bit() and set_bit(),
> > maybe creating other pitfalls.
>=20
> For the avoidance of doubts, I'm not saying that all the issues you raise=
d
> can be solved by barriers instead of appropriate locks (I don't know enou=
gh
> about the code and issues in general here).

I'm not saying that you're saying that. I'm just cautioning you that
this change could be tricky.

>=20
> I do think however that appropriate locks will fix the ordering issue
> highlighted by sashiko (i.e. +1 for your argument). Barriers would fix th=
is
> specific issue, too, but that is not a statement about any wider issues.=
=20
>=20
> > The ordering issue in the get_*_name() functions plays into that.
> > Setting the bit would then be done after setting the ops-pointer to
> > NULL. So one would have to try to move the NULL set, too.
> >=20
> > Long story short, this is painful and subtle.
> >=20
> > But I think what we are realizing over and over again is that dma_fence
> > has many subtleties to its API contract, and the implementation's
> > sparring use of spinlocks leads to workarounds where people take locks
> > manually or have to do an RCU dance.
> >=20
> > Note that Christian is strongly opposed to guarding everything with
> > locks, in part for supposedly occuring deadlocks in the fence callbacks
> > when the driver needs to take its own locks.
>=20
> ww_mutex could help against deadlocks, but might affect performance, in c=
ase
> these are all critical code paths (IDK),

You can't use sleepable locks in fences. They fire in interrupt context
left and right ;)

Despite, that wouldn't even solve the reported problem.

The tl;dr is:

there is fence_ops->enable_signaling(), which is currently being called
with the fence lock held. So the driver, in that callback, cannot take
a driver-specific lock IF there is another driver party (like an IRQ)
taking first the driver lock and then the fence lock.

Which is why Christian K=C3=B6nig wants to remove the fence lock being held
in enable_signaling().

One reason why that, supposedly, is currently not a problem is that
without fence->inline_lock, you can protect the fctx with the same lock
and do fctx list manipulations in enable_signaling() with lock
protection.


If you have a big bowl of popcorn available, you could checkout this
thread:

https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.org=
/

;p

My own thinking is:
If everyone used inline_lock, and if we could rely on everyone being
able to do the necessary work in enable_signaling() without said lock-
inversion, then we could perfectly synchronize all actions related to
dma_fence, including driver and, thus, fence_ops unload.

The only thing blocking really might be enable_signaling (the other
callbacks already take the lock). The more difficult question would be
how to implement that in a backwards compatible manner, i.e., for those
who don't have inline_lock.

Another idea for the distant future might be to question the existence
of those callbacks. Userspace often is sort of decoupled from the
hardware fences through intermediate fences already.

>=20
> > The community discussion regarding that problem is currently in some
> > sort of dead end, where none of us seems to know what the correct path
> > forward is.
>=20
> Please ignore if the following doesn't make sense, I'm just a bystander :=
-)
> How about at least adding the required barriers and related changes, and
> taking it from there? This would solve some immediate and easy to hit
> issues on Arm64? If they turn out to be insufficient, code can still
> be changed.
>=20

I am in support of that, which is why I posted that RFC for feedback
about the appropriate memory barriers.

>=20
> BTW, thanks Philipp for all these details, much appreciated.

You're welcome. If you'd find a clever solution, probably everyone
would be happy.


P.

>=20
> Cheers,
> A.
