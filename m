Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A00CC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5602310F401;
	Tue, 15 Sep 2026 10:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lzuQ9D2x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7FF10F401
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A23E600D1;
 Tue, 15 Sep 2026 10:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CFD1F000FF;
 Tue, 15 Sep 2026 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789469918;
 bh=4+2JuIf1m5Sq29ZoqN5yO88CtDicReaSY65+x4n/l3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lzuQ9D2xIusQxEpsAT34Ir+FzGPwOtrErZz+Accb9r+ieTP7DZYkNNOpoihKd9Qn2
 wK2gaAz05t7mVjpbV9urcIV8BuyKzlZXjIJpTT/YHD6eeNul0UbkgcSOH2+iOy011Z
 W3a3hc/hQcrRlQPsvmn5jbFUo7Ozjr38q1MBtWYNaEO8kSMMj8oUqbQmJYZwjJyNRd
 1iYE4aQ3vkfS9PBKifj7YLMorq35YWkeN1bKAAou6sCBhQ0oNin5TYA35iBvYeedzJ
 B9Ee4waIfYOEepaF9Q12vDjZmvHOoUNd6o9bMdIcSqjIEdOZadDvCp/jcZmT49xvRI
 sm1EFvjW0/JZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/14] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915104328.45901-5-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:58:38 +0000
Message-Id: <20260915105838.95CFD1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition in reset path prevents required IOMMU hardware reco=
very
--

commit b227f4b369396fb45d834eeade730dbc33623b84
Author: Jiaxing Hu <gahing@gahingwoo.com>

    accel/rocket: let the core suspend after a reset

This commit replaces pm_runtime_put_noidle() with pm_runtime_put_autosuspen=
d()
in the rocket_reset() path to allow the core to suspend. Cycling the power
domain issues a bus interface reset that is needed to recover the IOMMU.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index dfe9135d86af5..2a0b8af6f67da 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -437,12 +437,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
> =20
>  	/*
>  	 * No handler is running now, but we might still have stuck jobs. Let's
> -	 * make sure the PM counters stay balanced by manually calling
> -	 * pm_runtime_put_noidle().
> +	 * make sure the PM counters stay balanced by putting the reference the
> +	 * job took, and request idle while doing it so the core can suspend.
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +			pm_runtime_put_autosuspend(core->dev);

[Severity: High]
Does using pm_runtime_put_autosuspend() here guarantee the synchronous hard=
ware
power cycle required to recover the IOMMU?

Since pm_runtime_put_autosuspend() is asynchronous, it merely queues a susp=
end
with a delay. A few lines below, rocket_reset() calls drm_sched_start():

drivers/accel/rocket/rocket_job.c:rocket_reset() {
	...
	/* Restart the scheduler */
	drm_sched_start(&core->sched, 0);
}

If the scheduler has jobs queued, it will immediately dequeue the next job =
and
execute rocket_job_run(). This function calls pm_runtime_resume_and_get(),
which increments the usage count and cancels the pending autosuspend before=
 the
timer can expire.

Could this race condition prevent the power domain from cycling under conti=
nuous
load, leaving the NPU's IOMMU unresponsive and causing subsequent jobs to f=
ail?

Would it be safer to use a synchronous put like pm_runtime_put_sync() when
hardware ordering constraints require the device to be powered down before =
the
next operation?

> =20
>  		iommu_detach_group(NULL, core->iommu_group);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915104328.4590=
1-1-gahing@gahingwoo.com?part=3D4
