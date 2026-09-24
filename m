Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451E4C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666E510F460;
	Thu, 24 Sep 2026 10:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ffizzk+P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F83B10F460
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:35:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F41C842A51;
 Thu, 24 Sep 2026 10:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E801F000FF;
 Thu, 24 Sep 2026 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790246156;
 bh=LKLZqxHoa4np4eVq1b5DdpwkW6IA3T1WKmxwKfQh9Dk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ffizzk+POhJrf1mrTFe2clCf1KMezU5mMvms//eLori9ZuE8vB1cufgzE5xKGp2by
 BvBxiFj61GDPc66LC8406ouPZVN6b4S61FJorIO7cVrGCLv7lRfCNkXjOq8QGcg+A2
 rDzrgLq4SWc2QbCx6KlfQp9NvrGe5HJilT1ltykITJ6vJYJT+DYg/MKFJYBpxGwe2E
 /xhHX1MAnJeyU8nzlM1rbfxgjliOPsL7gk5wUbJwMuDvwjN1oA/KkyiEEdSYucPWdD
 sKDu+CWGmOd0CgEope4koS7uqiJogXpb0YsQ+7968Xhb+vG15kGP3CsMCZ3AD1UABV
 Pj43C1KdMVugA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/15] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260924102135.92217-5-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
 <20260924102135.92217-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:35:56 +0000
Message-Id: <20260924103556.86E801F000FF@smtp.kernel.org>
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
- [High] pm_runtime: asynchronous pm_runtime_put_autosuspend() during reset=
 aborts hardware recovery
--

commit 95b09cd74a75566f037a5b7f059c69a7c6b7352e
Author: Jiaxing Hu <gahing@gahingwoo.com>
accel/rocket: let the core suspend after a reset

This commit changes the PM counter decrement in rocket_reset() from
pm_runtime_put_noidle() to pm_runtime_put_autosuspend() to allow the
core to suspend.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -443,12 +443,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
[ ... ]
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +			pm_runtime_put_autosuspend(core->dev);

[Severity: High]
Does this asynchronous suspend abort the hardware recovery process?

When a job times out and triggers rocket_reset(), this code now schedules
an asynchronous suspend.

However, at the end of rocket_reset(), drm_sched_start() is immediately
invoked to restart the DRM scheduler. If there are pending jobs in the
queue, the scheduler thread can immediately pull the next job and call
pm_runtime_resume_and_get().

This increments the PM usage count and cancels the pending autosuspend
before the timer expires. Consequently, the device might never enter
RPM_SUSPENDED, its power domain never cycles, and the required bus
interface reset fails to trigger.

This leaves the bus interface stuck, causing the IOMMU to stop answering
and plunging the accelerator into an infinite timeout loop. This
regression can occur when user space submits a batch of jobs and one
induces a timeout, leading to a local denial of service.

Would it be safer to use pm_runtime_put_sync() here?=20

Using a synchronous put ensures the device is fully suspended before the
next operation proceeds, which aligns with the requirement for hardware
ordering constraints.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924102135.9221=
7-1-gahing@gahingwoo.com?part=3D4
