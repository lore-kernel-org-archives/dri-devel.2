Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7554BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1B210F855;
	Fri, 10 Jul 2026 11:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mcTQIozB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DE310F855
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:06:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 400D2601D9;
 Fri, 10 Jul 2026 11:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C304E1F000E9;
 Fri, 10 Jul 2026 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783681611;
 bh=cQO47jRpPd+vUqhjURj7utOfDc+c6W0JjdmIWPTReHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mcTQIozBrxos64nUsq3IQG7nQVKumCM54j4Snt07rqbXjATUlh29w7a1foUXoUi3K
 yM5tIUjJ3kaa0WAPIuRmEsEHN5hYZ/nL2mLecz4SfdHizGARUhuQUxfU3mbXjLWkhO
 M04uIFQoq5M3gDSnYpgk+xnT8lUgUbdx4sBjW61Epyl98vQ/cjcruixLTgsFuXvNDu
 sEDpt1+pRF961jbcEpl+xkWXmf44AmSWvvhHZUeA9Nn5JCvBiYTpb9XwHlLgXswRE1
 xasD36JJVAa6tfDw2iRECJGmR0eKz0q6WQi+dlcT766xY+lnUVJJJTQZPvi/IxkcyS
 MmgNgrKen8Dig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] accel: ethosu: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710105937.409992-2-panchuang@vivo.com>
References: <20260710105937.409992-1-panchuang@vivo.com>
 <20260710105937.409992-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:06:50 +0000
Message-Id: <20260710110650.C304E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Calling `drm_sched_fini()` after `drm_sched_init()` fails causes a=
 kernel panic due to uninitialized structures.
--

--- Patch [1]: [PATCH 1/2] accel: ethosu: Remove redundant dev_err() ---
commit ab2aa317daa0785d0207a88d5d5b51fcef216f77
Author: Pan Chuang <panchuang@vivo.com>

accel: ethosu: Remove redundant dev_err()

This commit removes redundant driver-specific error logging after
devm_request_threaded_irq(), relying on the core IRQ code to automatically
log failures.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -338,10 +338,8 @@ int ethosu_job_init(struct ethosu_device *edev)
[ ... ]
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	edev->fence_context =3D dma_fence_context_alloc(1);

[Severity: High]
This is a pre-existing issue, but does the error handling path later in
ethosu_job_init() cause a kernel panic if drm_sched_init() fails?

If drm_sched_init() returns an error (for example, due to an out-of-memory
condition), the code jumps to the error label:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_init() {
    ...
    ret =3D drm_sched_init(&edev->sched, &args);
    if (ret) {
        dev_err(dev, "Failed to create scheduler: %d\n", ret);
        goto err_sched;
    }
    ...
err_sched:
    drm_sched_fini(&edev->sched);
    return ret;
}

At this point, the job_scheduled waitqueue inside drm_gpu_scheduler remains
completely zero-initialized. When drm_sched_fini() attempts to wake up tasks
by calling wake_up_all(&sched->job_scheduled), the zero-initialized list_he=
ad
means its next pointer is NULL. The list_empty() check incorrectly returns
false, and the subsequent list iteration dereferences the NULL pointer.

Could this lead to an immediate panic during device probe failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710105937.4099=
92-1-panchuang@vivo.com?part=3D1
