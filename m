Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA5C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C527610E538;
	Mon, 24 Aug 2026 13:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ma9gwPyu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE11B10E413;
 Mon, 24 Aug 2026 13:31:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5593643369;
 Mon, 24 Aug 2026 13:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEE1F000E9;
 Mon, 24 Aug 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787578286;
 bh=u9T/h+lPActj6yEYerAGiMyBvLKieymUVCIpbzIXmnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ma9gwPyuayrlTBaKEXokmPN27o2yRo1CeDmyOyeBBIghi+KYvAH1qa4noYgVbTbBB
 VInkBO4h//vF/oIzsj9pCva3a0Tf8nmx/uq6v9DhAUQm4uJtIkQh+hpzhrD1QlPSSU
 mZul63v1E8dlAPWH37vRMt8EsRkutHSTSBBVc2h7k+/XMAZwkhUfMlXyC0mSVw3CQn
 0Vf7/zQ68Tw8Bvvr+vkxibIVXP5dY9xNin+NVr6TxO3po+pcYpQzMwVzLB9HR0GSt0
 jhUAcIYH+7diwbGvXP4NAICGTKjpbKRTD80Kx1mBvGmXKkhmCyHB6NlxbxZhJEaq0u
 hKC3uOaws3OZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] drm/panic: Restrict to primary planes;
 unconditionally unregister
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, ojeda@kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260824125201.218863-10-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:31:25 +0000
Message-Id: <20260824133125.BEBEE1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional calls to kmsg_dump_unregister() for all planes cau=
se severe delays during device teardown due to sequential synchronize_rcu()=
 calls.
- [Medium] drm_panic_is_enabled() was not updated to enforce the primary pl=
ane restriction, leading to inconsistent panic handler state.
--

--- Patch [9]: [PATCH v2 09/13] drm/panic: Restrict to primary planes; unco=
nditionally unregister ---
commit c3117dcbe59bcb2d0d31d68229c5ec24738e412e
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Restrict to primary planes; unconditionally unregister

Restrict panic handling to primary displays. Overlays and cursors
should not display panic output. If there are exceptions, they can
be registered by the driver itself.

For cleanup, unregister each plane unconditionally. The kmsg dumper
already keeps track of the registration status so DRM doesn't have
to.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 2048a3bf736f0..7dbbcc1c219ff 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -1079,6 +1079,8 @@ void drm_panic_register(struct drm_device *dev)
>  		return;
> =20
>  	drm_for_each_plane(plane, dev) {
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;

[Severity: Medium]
Was drm_panic_is_enabled() updated to match this new primary plane
restriction?

If a driver implements the panic callback on a non-primary plane but not on=
 a
primary plane, drm_panic_is_enabled() will return true since it lacks this
type check:

drivers/gpu/drm/drm_panic.c:drm_panic_is_enabled() {
...
	drm_for_each_plane(plane, dev)
		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
			return true;
...
}

Because drm_panic_register() skips the non-primary plane, it won't actually
be registered. Does this false positive in drm_panic_is_enabled() introduce=
 a
regression where drm_fb_helper disables its fallback panic handling, leaving
the system with no panic screen handler at all?

>  		if (!plane->helper_private || !plane->helper_private->get_scanout_buff=
er)
>  			continue;
>  		plane->kmsg_panic.dump =3D drm_panic;

[ ... ]

> @@ -1105,11 +1107,8 @@ void drm_panic_unregister(struct drm_device *dev)
>  	if (!dev->mode_config.num_total_plane)
>  		return;
> =20
> -	drm_for_each_plane(plane, dev) {
> -		if (!plane->helper_private || !plane->helper_private->get_scanout_buff=
er)
> -			continue;
> +	drm_for_each_plane(plane, dev)
>  		kmsg_dump_unregister(&plane->kmsg_panic);
> -	}
>  }

[Severity: Medium]
Does this unconditional loop cause severe delays during device teardown?

The function kmsg_dump_unregister() executes synchronize_rcu() at the end
regardless of the dumper's registration status:

kernel/printk/printk.c:kmsg_dump_unregister() {
...
	spin_unlock_irqrestore(&dump_list_lock, flags);
	synchronize_rcu();
...
}

Looping sequentially over all planes without checking if they were actually
registered forces the teardown path to block for multiple consecutive RCU
grace periods. Can this regression potentially add hundreds of milliseconds=
 to
several seconds of delay during driver unbind or hot-unplug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D9
