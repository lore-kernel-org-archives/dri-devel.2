Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD589C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B22610E386;
	Tue, 21 Jul 2026 14:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ifvo8ykP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBDA10EA4C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0A1360054;
 Tue, 21 Jul 2026 14:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B51F000E9;
 Tue, 21 Jul 2026 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784645843;
 bh=qWLT0SyX9FvTZtG37OnDF5iWpBSsGRQYZou5kUEJWvE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ifvo8ykPirCMfHJFuerVxO8eElxWx5WIa7Cg9x8Uyj1pnrLoNGLuwNdqNBPsyaBwd
 TWULK1cM9lIf8s2ehNDErUxL9WTGrqbT9Xigw09L7yyj4bXaRKpD5higkZNdiubNqS
 me/3Y63v5KQiyoOl0H/YHdibpLfzO5zpE+C3st+8THeGu4iZLxKp2FeW8sHZe/4WaE
 Jx+xRu4oxVlH614T+JCMwyfarWrpfMRf297wWovC1JBGdPQkZFnx98crJnDeLvPBie
 GxaYaTqe5qg31GurrBrHCUl1pvwqsvcg6zZ6UJyiwggr3Bx3ZjPri2aM7bUe0AwQms
 FraqwmiT00SXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: stop IRQ work before teardown
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721143559.27322-1-mhun512@gmail.com>
References: <20260721143559.27322-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:57:22 +0000
Message-Id: <20260721145723.6D8B51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The teardown path uses cancel_delayed_work() instead of cancel_del=
ayed_work_sync(), allowing the timer handler to race with destroy_workqueue=
() and lead to a use-after-free.
- [High] If driver initialization fails during or after anx7625_link_bridge=
(), the DRM bridge remains registered but its parent memory is freed by dev=
res, leading to a Use-After-Free.
- [Medium] anx7625_bridge_atomic_disable() attempts to wait for hdcp_work u=
sing flush_workqueue(), but this does not cancel or wait for pending delaye=
d work timers.
--

--- Patch [1]: [PATCH] drm/bridge: anx7625: stop IRQ work before teardown -=
--
commit f6280d9ebcac680a90e170320e540ca6f7ab4e30
Author: Myeonghun Pak <mhun512@gmail.com>

drm/bridge: anx7625: stop IRQ work before teardown

This commit disables the HPD interrupt and destroys the workqueue first to
synchronize with the handler and drain queued work. This prevents the
interrupt from racing with teardown and queuing work that accesses released
objects.

> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index ebd34657908ea..9c9a4a7bbf726 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2973,13 +2973,15 @@ static void anx7625_i2c_remove(struct i2c_client =
*client)
>  {
[ ... ]
>  	drm_bridge_remove(&platform->bridge);
> =20
> -	if (platform->pdata.intp_irq)
> -		destroy_workqueue(platform->workqueue);
> -
>  	if (platform->hdcp_workqueue) {
>  		cancel_delayed_work(&platform->hdcp_work);

[Severity: High]
This is a pre-existing issue, but does this non-synchronous cancel allow
a race condition?=20

If cancel_delayed_work() is called while the timer callback is executing on
another CPU, it returns immediately without waiting. When destroy_workqueue=
()
then frees the workqueue, the timer callback could resume and attempt to
queue work on the freed workqueue, leading to a use-after-free.=20

Should this use cancel_delayed_work_sync() instead?

>  		destroy_workqueue(platform->hdcp_workqueue);
>  	}

[Severity: Medium]
This is a pre-existing issue, but does anx7625_bridge_atomic_disable()=20
correctly handle the delayed work?=20

drivers/gpu/drm/bridge/analogix/anx7625.c:anx7625_bridge_atomic_disable() {
    ...
	flush_workqueue(ctx->hdcp_workqueue);
    ...
}

Calling flush_workqueue() doesn't actually cancel or wait for pending
delayed work timers if they haven't expired yet, causing the work to run=20
later. Should this use cancel_delayed_work_sync() to ensure the work is=20
properly stopped?

[Severity: High]
This is a pre-existing issue, but does the probe function leak the DRM=20
bridge registration on error paths?

drivers/gpu/drm/bridge/analogix/anx7625.c:anx7625_i2c_probe() {
    ...
	ret =3D anx7625_typec_register(platform);
	if (ret)
		goto pm_suspend;
    ...
}

Because anx7625_link_bridge() calls drm_bridge_add() earlier in the probe,
if a subsequent step like anx7625_typec_register() fails, the probe
function jumps to the error path and returns an error without calling
drm_bridge_remove().=20

The devres framework then frees the platform structure, but the bridge rema=
ins
globally registered in bridge_list. Any subsequent iteration of the bridge
list by the DRM core would dereference the freed memory, leading to a
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721143559.2732=
2-1-mhun512@gmail.com?part=3D1
