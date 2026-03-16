Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91568F46453
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E382410E3BB;
	Mon, 16 Mar 2026 11:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nIyKn5DS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D204B10E3BB;
 Mon, 16 Mar 2026 11:25:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A7976013A;
 Mon, 16 Mar 2026 11:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A36C19421;
 Mon, 16 Mar 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773660327;
 bh=BV2Fvfkpi9LBJuI9ErHX/edj2DFHqDR1D2AIoMHj8dI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=nIyKn5DSZAdduua9xEl6f3AXSiaVCI7S0Nc8gnEIeGrRxxeJI/e+GKCRT/ogCjAfn
 RIm6hRIj0RL9NR7GhED55cAjqeOymxsuEg7+PUwqiAoRg5sNG7TZH9D3XQghBbZ1ov
 IyzrGryBpXOenYX9QTVw9Lpd/pPohS5rYBodL9J3gyTHUGri7aVGuuWLLBI1PRFuj5
 H8BNNnNmZG5fcyU76W5kZOSaIH1AOEmliAeqZQuAtaNlMb4k6C+tiYDsoXn21ZaeuH
 tW6WX04DM7Di8Lh92zhAooMw2g5bL6gKHc1VnFJwAx6rB2UcFHvDv0wbwgl51ftUBf
 6EYR12UNyohbQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 11:25:23 +0100
Message-Id: <DH44U26ZLJS2.3DTS9D6PA0IL4@kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David Airlie"
 <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Philipp Stanner" <phasta@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
In-Reply-To: <20260316043255.226352-3-matthew.brost@intel.com>
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

On Mon Mar 16, 2026 at 5:32 AM CET, Matthew Brost wrote:
> Diverging requirements between GPU drivers using firmware scheduling
> and those using hardware scheduling have shown that drm_gpu_scheduler is
> no longer sufficient for firmware-scheduled GPU drivers. The technical
> debt, lack of memory-safety guarantees, absence of clear object-lifetime
> rules, and numerous driver-specific hacks have rendered
> drm_gpu_scheduler unmaintainable. It is time for a fresh design for
> firmware-scheduled GPU drivers=E2=80=94one that addresses all of the
> aforementioned shortcomings.

I think we all agree on this and I also think we all agree that this should=
 have
been a separate component in the first place -- and just to be clear, I am
saying this in retrospective.

In fact, this is also the reason why I proposed building the Rust component
differently, i.e. start with a Joqueue (or drm_dep as called in this patch)=
 and
expand as needed with a loosely coupled "orchestrator" for drivers with str=
ictly
limited software/hardware queues later.

The reason I proposed a new component for Rust, is basically what you also =
wrote
in your cover letter, plus the fact that it prevents us having to build a R=
ust
abstraction layer to the DRM GPU scheduler.

The latter I identified as pretty questionable as building another abstract=
ion
layer on top of some infrastructure is really something that you only want =
to do
when it is mature enough in terms of lifetime and ownership model.

I'm not saying it wouldn't be possible, but as mentioned in other threads, =
I
don't think it is a good idea building new features on top of something tha=
t has
known problems, even less when they are barely resolvable due to other exis=
ting
dependencies, such as some drivers relying on implementation details
historically, etc.

My point is, the justification for a new Jobqueue component in Rust I consi=
der
given by the fact that it allows us to avoid building another abstraction l=
ayer
on top of DRM sched. Additionally, DRM moves to Rust and gathering experien=
ce
with building native Rust components seems like a good synergy in this cont=
ext.

Having that said, the obvious question for me for this series is how drm_de=
p
fits into the bigger picture.

I.e. what is the maintainance strategy?

Do we want to support three components allowing users to do the same thing?=
 What
happens to DRM sched for 1:1 entity / scheduler relationships?

Is it worth? Do we have enough C users to justify the maintainance of yet
another component? (Again, DRM moves into the direction of Rust drivers, so=
 I
don't know how many new C drivers we will see.) I.e. having this component =
won't
get us rid of the majority of DRM sched users.

What are the expected improvements? Given the above, I'm not sure it will
actually decrease the maintainance burdon of DRM sched.
