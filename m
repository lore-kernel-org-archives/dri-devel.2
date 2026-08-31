Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E16C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A3510E1BC;
	Mon, 31 Aug 2026 16:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dzeg4mg4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D641210E1BC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:36:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98E4C40912
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526341F000E9;
 Mon, 31 Aug 2026 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788194210;
 bh=CohAYkJHzTvR8uFGT55oq/Di5kCASlsrWan64H8DtBY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dzeg4mg4/JyXCCcs3cMFlnpaE2BX1fNTHypNHyfmb5bgUi7Ep8VobrTW9GOadmbM8
 /3T/dwGtjyqv1zojVVuVMaIvGevyFBZc8sjsPenps1LoYhZN8AWpms8MIDDnidZA2y
 WbC+LKdVQdzW1/Ugz9kWAk+9XpCToFh8zlHHkBThdFS2vteTMkBPMv79+XyRtxdmk+
 uRkyi5uFUAlyCras0fWkOf6Pi6d7aFL3qY/97XCrdftTF4nDtYju4IAPiKqJHoVTY9
 DksfoKePDdv7MogXVkyGujYxrdrNMjt6LEQa7G/oEgzRK275ohejXDOsjo6zI/bG9b
 ti3/vWBzbJViw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdkfd: fix UAF race in
 destroy_queue_cpsch
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-446-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-446-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:36:49 +0000
Message-Id: <20260831163650.526341F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypassing the is_being_destroyed check allows a concurrent thread =
to improperly clear the flag, reopening the use-after-free window.

Pre-existing issues:
- [High] q->mqd is unconditionally freed in destroy_queue_cpsch() even if t=
he function fails with a non-timeout error, leading to a UAF in subsequent =
operations like update_queue, and permanent memory leaks of the queue struc=
ture.
--

commit ea1b656c30dda08f56333e614c63a751ee2e05bd
Author: Alysa Liu <Alysa.Liu@amd.com>
Date:   Mon Aug 31 13:27:54 2026 +0000

    drm/amdkfd: fix UAF race in destroy_queue_cpsch
   =20
    wait_on_destroy_queue() drops locks to wait for queue resume, allowing
    a concurrent destroy to free the queue. Use is_being_destroyed flag to
    serialize destruction.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6e7bc983fc0b6..910722be71000 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2500,6 +2500,9 @@ static int wait_on_destroy_queue(struct device_queu=
e_manager *dqm,
>  	if (pdd->qpd.is_debug)
>  		return ret;
> =20
> +	if (q->properties.is_being_destroyed)
> +		return -EBUSY;
> +

[Severity: High]
Is it possible for a concurrent thread to bypass the is_being_destroyed
check if is_debug becomes true?

If Thread A drops locks to wait in wait_event_interruptible(),
is_being_destroyed remains true. If a debugger attaches and is_debug becomes
true, Thread B calling wait_on_destroy_queue() will return early here and
skip the is_being_destroyed check.

>  	q->properties.is_being_destroyed =3D true;
> =20
>  	if (pdd->process->debug_trap_enabled && q->properties.is_suspended) {
[ ... ]
> @@ -2605,7 +2611,7 @@ static int destroy_queue_cpsch(struct device_queue_=
manager *dqm,
>  	return retval;

[Severity: High]
This is a pre-existing issue, but does this unconditionally free q->mqd even
if an error is returned earlier in this function?

If hardware unmap fails (e.g., -ENOMEM from execute_queues_cpsch or -EINVAL
from remove_queue_mes), destroy_queue_cpsch() still calls free_mqd() and
returns the error.

pqm_destroy_queue() receives this error and skips uninit_queue(), leaving t=
he
queue in the active list with a dangling q->mqd pointer. A subsequent
KFD_IOC_UPDATE_QUEUE ioctl will then dereference the freed q->mqd in
update_queue():

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:update_queue() {
    ...
    mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
    ...
}

> =20
>  failed_try_destroy_debugged_queue:
> -
> +	q->properties.is_being_destroyed =3D false;

[Severity: High]
Will unconditionally clearing the flag here re-introduce the use-after-free
race?

If Thread B bypassed the is_being_destroyed check in wait_on_destroy_queue()
due to is_debug becoming true, it will take this error path and clear the
flag. Thread A is still waiting, but its protection is now lost, allowing
Thread C to free the queue before Thread A wakes up.

>  	dqm_unlock(dqm);
>  	return retval;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-446-sashal@kernel.org?part=3D1
