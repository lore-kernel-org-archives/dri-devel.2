Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F6CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB9D10F174;
	Wed, 30 Sep 2026 04:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gt9rUnJL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EC010F174
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70E5F416E8;
 Wed, 30 Sep 2026 04:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296251F000FF;
 Wed, 30 Sep 2026 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740830;
 bh=qUKunCQfOgRF10If53khkAj9loIsrWMNbITdejKIxV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gt9rUnJL0SRUVvy3ABJDQwuvflfI1cmUCzhBLlOo+g3ytFlXx1K8qDgtjnSiT9QjH
 VkS/Nxl1umeZGWziA0e7vAVgPoG28kaQWxWfpK7dN6yvvb5Qg1ByC5f+bdvh/STePs
 b5UfEy05Qs7JXasqTljoM8ewfcdiTnb/vXsq+EZRQIJ6nK54TdIh0tawgYZsqhiDRv
 QW39eQyeWULbDFsAdkLByAoJrM0D75Ubb6o9xUygosDlEcEyEopFTJSQq5DWwfCmcn
 eQaRHfV7OP5apzkJHeFC/HxL8rpoXzy9kr/96LueEmselxpbnPxvtm30yH7OW7pzk+
 fKiEyyILQkq+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 12/20] accel/amdxdna: Implement AIE4 kernel queue
 lifecycle and memory layout
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-13-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-13-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:00:29 +0000
Message-Id: <20260930040030.296251F000FF@smtp.kernel.org>
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
- [High] amdxdna: System-wide DoS via dev_lock when sleeping with SRCU read=
 lock held
--

commit 132c3fc1d7de0e87a5c560f0114f2517ab24e40c
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout

This commit initializes the kernel-mode submission required buffers, workqu=
eue,
and hardware contexts for AIE4. It updates the queue definition, adds a job
workqueue for pending and running jobs, initializes direct and indirect pac=
kets,
and implements hardware context lifecycle operations.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 5a2fc19bad206..3927c9fef05f9 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -301,10 +456,12 @@ static inline bool check_cmd_done(struct amdxdna_hw=
ctx *hwctx, u64 seq)
>  int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
>  {
>  	unsigned long wait_jifs =3D MAX_SCHEDULE_TIMEOUT;
> -	struct amdxdna_hwctx_priv *priv =3D hwctx->priv;
> -	struct cert_comp *cert_comp =3D priv->cert_comp;
> +	struct cert_comp *cert_comp =3D aie4_get_cert_comp(hwctx);
>  	long ret;
> =20
> +	if (!cert_comp)
> +		return -EAGAIN;
> +
>  	if (timeout)
>  		wait_jifs =3D msecs_to_jiffies(timeout);
> =20
>  	ret =3D wait_event_interruptible_timeout(cert_comp->waitq,
>  					       (check_cmd_done(hwctx, seq)),
>  					       wait_jifs);

[Severity: High]
Could this indefinite sleep cause a system-wide denial of service by deadlo=
cking
the device?

If a user calls the wait ioctl with an infinite timeout, the caller acquires
srcu_read_lock(&client->hwctx_srcu) and sleeps indefinitely in
aie4_cmd_wait() waiting for hardware completion.

Concurrently, if another thread attempts to destroy the same hardware conte=
xt,
it will acquire the global xdna->dev_lock and call amdxdna_hwctx_destroy_rc=
u().
This function blocks on synchronize_srcu(&client->hwctx_srcu), waiting for =
the
wait ioctl to drop the SRCU read lock.

However, the hardware destruction that would wake up the wait queue is call=
ed=20
after synchronize_srcu():

amdxdna_hwctx_destroy_rcu() {
    ...
    synchronize_srcu(&client->hwctx_srcu);
   =20
    /* At this point, user is not able to submit new commands */
    xdna->dev_info->ops->hwctx_fini(hwctx);
}

This creates a circular dependency where aie4_cmd_wait() will never wake up
because hwctx_fini() cannot run, leaving xdna->dev_lock held forever. Could=
 we
handle the destruction order differently or abort the wait before calling
synchronize_srcu()?

>  	if (!ret)
>  		ret =3D -ETIME;
> =20
> +	aie4_put_cert_comp(cert_comp);
> +
>  	return ret <=3D 0 ? ret : 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D12
