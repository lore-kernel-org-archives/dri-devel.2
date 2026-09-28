Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44CAC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385D210E825;
	Mon, 28 Sep 2026 08:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4PF3mIQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC8F10E2E0;
 Mon, 28 Sep 2026 08:52:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97D3C600E2;
 Mon, 28 Sep 2026 08:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18421F000FF;
 Mon, 28 Sep 2026 08:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585567;
 bh=GBWiIMmpScxYzj+2p1+R20a5UVJCHxzDufe+GyeONd4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=I4PF3mIQyN65jDvd146w9975EvHc8idIik+0joAk5Mv4leEp8nknCuFSlJFte3UVd
 RCN7u9T7xXz3hleSyU71irWimiTtxu6ZruDQ2u27vIMv2eOMBpSOLe94sSd2xebMA9
 MYHI8g+z9/rgRRxX8xGswUYwNUC/gZnG2rCxxZRhdWWr+aZte739TTPVb+9csJhlYi
 AC4km+RNQjk/rmcY/O1xaoZPhW7LeUuNcQWNxbatO6Sw0b5gYAQUfzCLca7CTTqF4W
 o4DblrSO86u0xowuZRp/61yxEM4uYsBlNa18bVGVP2WwfzD4/IiMJzUWuOnmDCNe0f
 tE5QTMFP/7ljA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 10:52:44 +0200
Message-Id: <DLQTLWC6YFPE.1FN6GSV00AWXM@kernel.org>
Subject: Re: [PATCH 1/2] drm/sched: keep the current runqueue when no
 scheduler is ready
Cc: <vitaly.prosyak@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Philipp Stanner" <phasta@kernel.org>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260928020018.120503-1-vitaly.prosyak@amd.com>
 <arnPBVP3cnDNwTMn@gsse-cloud1.jf.intel.com>
In-Reply-To: <arnPBVP3cnDNwTMn@gsse-cloud1.jf.intel.com>
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

On Mon Sep 28, 2026 at 4:20 AM CEST, Matthew Brost wrote:
> To me, this looks like a lifetime issue that should be fixed in AMDGPU.
> Either that, or we need to rework DRM to have proper lifetime management,
> or, of course, just deprecate drm_sched.

Agreed. The lifetime and ownership model in drm_sched is not fundamentally
wrong, but the implementation is not consistently keeping it up and drivers=
 also
don't always honor it.

> In other words, we need refcounting so that drm_sched_fini() cannot be
> called while jobs are still in flight, nor can jobs be submitted before
> drm_sched_init(). Alternatively, drm_dep could serve as a replacement.

I'm not a huge fan of refcounting for those kind of things because it
fundamentally incentivises the wrong lifetime model in the context of the d=
river
model. The driver model requires a bounded lifetime scope, but refcounting
incentivises an unbounded lifetime model, which leads to other problems.

So, especially for the sake of deferring drm_sched_fini() from running jobs=
,
drivers still have to make sure that all jobs are torn down and drm_sched_f=
ini()
is called *before* driver unbind completes. IOW, drivers should tear down t=
he
hardware and hence all jobs latest in remove() and then call drm_sched_fini=
()
subsequently.

Refcounting does not provide a lot of value in this regard, because we have=
 to
somehow guarantee that the hardware and all jobs are torn down at this spec=
ific
boundary anyway.

This is also my biggest concern about drm_dep, it seems to be designed with
exactly the idea of an unbounded lifetime model, which is not the correct d=
esign
for anything that represents a device resource (e.g. a GPU job).

Now, to be fair, refcounting is really the only mechanism that we have in C=
 to
manage lifetimes, everything else is more or less just a convention. That s=
aid,
I'm not all against refcounting in general, but we have to be careful about=
 how
it influences the design in terms of a bounded and unbounded lifetime model=
.
