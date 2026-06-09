Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BBCD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B1010E24C;
	Tue,  9 Jun 2026 10:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHyu+mt5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600A910E24C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:47:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9835A60172;
 Tue,  9 Jun 2026 10:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE71F00893;
 Tue,  9 Jun 2026 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781002063;
 bh=UgKWXFrGeJV3JMqK79Tri336w9pcl6UGK8OEmvfxyBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHyu+mt5z/aSa6Mkz/YjRPn4pSuiPaVfBCBHY6MV6NalLNbwktzMFluRGfmDjiwLl
 tox2+wBL5zroYj3M2RJH3r54/Y12aFZStnM5el7gC1T0tGjd96EPhYaNia+VBh/OoI
 ntGezh4oPmbCEd/BiGE+OQeJv8UQ5TsajZ5qf3tjhERHtyHrADGjVLfgBtsjgwW2Ma
 33bEAz+mGMGwywSfT/x4fs3XDrQQsNKwGcaf4gLqgPmCHE9itihUwkOmTZKt1lXEDM
 lFcx530+pKzjAM0cUvJBefKSGPB4DUuA9clYxE+lWRpac3ZcsvPEEWvqbb/7+LqUnC
 5vCoYKYvFX93w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: create duplicate sessions after all CB
 probing
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
References: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:47:42 +0000
Message-Id: <20260609104743.28FE71F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [High] Deferring session duplication to fastrpc_rpmsg_probe() creates a r=
ace condition with concurrent device open, permanently leaking duplicated s=
essions.
- [High] An unlocked check on data->sesscount > 0 introduces a TOCTOU race =
with concurrent device unbinding, leading to an out-of-bounds read.
- [Medium] Relying on of_platform_populate() for synchronous child device p=
robing fails under asynchronous driver probing, leaving ADSP with missing s=
essions.

Pre-existing issues:
- [Critical] The fastrpc misc device is registered and exposed to userspace=
 before its underlying data structures and locks are initialized.
- [High] Removing a fastrpc context bank decrements sesscount without shift=
ing the active sessions, corrupting the session array upon subsequent binds.
- [High] If of_platform_populate() fails, the parent's data context is free=
d without depopulating successfully probed child devices, leading to a Use-=
After-Free.
- [High] A failure in dma_set_mask() leaves a corrupted, non-DMA-capable se=
ssion in the array, which fastrpc_rpmsg_probe() will wrongfully duplicate.
- [High] SCM memory assignment is not reverted on error paths in fastrpc_rp=
msg_probe.
- [High] Unbinding a fastrpc-cb device while a session is actively in use l=
eaves a dangling device pointer in the active session context.
--

commit f82362da546a7805f6c3c7071b9238f77f55a851
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: create duplicate sessions after all CB probing

This commit defers the duplication of ADSP sessions from the per-CB probe
path to the main fastrpc_rpmsg_probe function after all child nodes have
been populated.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a3..46afbae9c2341 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device =
*pdev)
[ ... ]
>  	if (!cctx)
>  		return -EINVAL;
> =20
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> -
>  	spin_lock_irqsave(&cctx->lock, flags);

[Severity: High]
This is a pre-existing issue, but when unbinding a fastrpc-cb device,
fastrpc_cb_remove() decrements cctx->sesscount without shifting the active
sessions to fill the gap. Does this mean cctx->sesscount becomes an
incorrect insertion index, causing subsequent probes to blindly overwrite an
active session upon a new bind?

[Severity: High]
This is also a pre-existing issue, but fastrpc_cb_remove() marks the session
invalid and decrements sesscount without waiting for active users to close
their file descriptors. Does this leave a dangling device pointer in the
active session context, triggering a use-after-free when subsequent ioctls
attempt to use it?

> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device=
 *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> =20
> -	if (sessions > 0) {
[ ... ]
> -	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {

[Severity: High]
This isn't a bug introduced by this patch, but what happens if
dma_set_mask() fails here? The function logs an error and returns, but
cctx->sesscount was already incremented. Does this leave a dangling,
non-DMA-capable session in the array that the new loop in
fastrpc_rpmsg_probe() will now wrongfully duplicate?

> @@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)

[Severity: Critical]
This is a pre-existing issue, but fastrpc_device_register() is called
earlier in this function to expose the device to userspace. Since data->lock
and data->users are initialized later, couldn't a concurrent userspace open
trigger a kernel panic by attempting to acquire an uninitialized spinlock?

[Severity: High]
This is another pre-existing issue, but earlier in this function
qcom_scm_assign_mem() is called to assign memory ownership to the DSP. If a
subsequent step in the probe fails, the error paths do not restore the
memory permissions back to the host. Does this permanently blackhole the
memory?

>  	if (err)
>  		goto err_deregister_fdev;

[Severity: High]
This isn't a bug introduced by this patch, but if of_platform_populate()
fails right before this check, the error path frees the data context. Does
it skip tearing down the successfully probed child devices, leaving them
with a dangling pointer that could cause a use-after-free upon removal?

> =20
> +	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {

[Severity: High]
Does checking data->sesscount here without holding data->lock introduce a
race with concurrent device unbinding? If a child context bank device is
unbound before the lock is acquired, sesscount could be decremented to 0.
When the lock is acquired below, would data->sesscount - 1 resolve to
index -1 and cause an out-of-bounds read?

[Severity: Medium]
Will this check fail if asynchronous driver probing is enabled? If child
probes are deferred to a workqueue, of_platform_populate() could return
immediately while data->sesscount is still 0, silently skipping the session
duplication.

> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +		int i;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess =3D &data->session[data->sesscount - 1];
> +		for (i =3D 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >=3D FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess =3D &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));

[Severity: High]
Since the /dev/fastrpc-* device is exposed to userspace before this loop
runs, could a concurrent application open the device and set the
last_sess->used flag to true via fastrpc_session_alloc()? If so, would this
memcpy() blindly copy the dirtied state, permanently leaking the duplicated
sessions since they wouldn't be attached to any active client?

> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dup-sessio=
ns-v1-1-26934abb9fa3@oss.qualcomm.com?part=3D1
