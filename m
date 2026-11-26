Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD6I3s1f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131610E77A;
	Thu, 26 Nov 2026 08:34:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75AF10E77A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:34:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 488FF6298E;
 Thu, 26 Nov 2026 08:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F351F000C0;
 Thu, 26 Nov 2026 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682087;
 bh=mQQCu5t/uHwNW69/mnlXFnXyWKMKzFbuiCbf97VBC6o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=DD6I3s1fHccCoFuai0lyNsBwmcIFeMUVDTyPp8f3GsgzsyDjDC2yXBxWjNj9kBS7l
 ct4VFlYaPu79kR8HYzhbrtahaVBJCogZN7/ITXOLIQT++KGdokynYOO6U1a5TehOUF
 KRFoh1TQthBJfWTpFDgu/mv7yj96gp80+tL4dGYaybSM4AXrL7ElSt4ZlQQHeVluUY
 8B+7DtqZPrgIvfITUFNn90Y8EmppZh/1xmXOfMoMw7Wqk6DQYx332Q8jmwdKD7FEDD
 i7YiQ+yPtRM7sugk32xcS+31HL3K6uj1DnoB5hh3fA4EzijpI3UIhTmayfpQQXNuUJ
 GhO7UFiBj9yIA==
Message-ID: <sashiko-outbox-235033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/sti: hqvdp: start the XP70 from device init
To: "Minseo Park" <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261126024710.33401-4-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
 <20261126024710.33401-4-hiyoukou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:34:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/sti: hqvdp: sti_hqvdp_bind() exposes plane with clk off on
  init failure
- [Medium] drm/sti: hqvdp: sti_hqvdp_bind() leaks hqvdp->clk on error
  and unbind
--

commit a8cf3e26ef27767a003bfe97a37331241f497584
Author: Minseo Park <hiyoukou@gmail.com>

drm/sti: hqvdp: start the XP70 from device init

This commit moves the sti_hqvdp_start_xp70() call out of
sti_hqvdp_atomic_check() and into sti_hqvdp_bind() so that atomic check
does not touch hardware or load firmware.

> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hq=
vdp.c
> index 360d213f2094f..c6b6ed54b8995 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1081,10 +1081,6 @@ static int sti_hqvdp_atomic_check(struct drm_plane=
 *drm_plane,
>  		return -EINVAL;
>  	}
> =20
> -	if (!hqvdp->xp70_initialized)
> -		/* Start HQVDP XP70 coprocessor */
> -		sti_hqvdp_start_xp70(hqvdp);
> -
>  	if (!hqvdp->vtg_registered) {
>  		/* Prevent VTG shutdown */
>  		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
> @@ -1333,6 +1329,9 @@ static int sti_hqvdp_bind(struct device *dev, struc=
t device *master, void *data)
> =20
>  	hqvdp->drm_dev =3D drm_dev;
> =20
> +	/* Start HQVDP XP70 coprocessor */
> +	sti_hqvdp_start_xp70(hqvdp);

[Severity: High]
Can this expose the HQVDP plane with hqvdp->clk disabled when
sti_hqvdp_start_xp70() fails?

Commit e00fe64a5ccd ("drm/sti: load HQVDP firmware the first time HQVDP's
plane is used") moved firmware loading out of sti_hqvdp_bind() because the
root filesystem may not be mounted yet at bind time.  When
request_firmware() or the XP70 boot poll fails in sti_hqvdp_start_xp70(),
hqvdp->xp70_initialized stays false and hqvdp->clk is left disabled, yet
sti_hqvdp_bind() still registers the DRM plane and neither
sti_hqvdp_atomic_check() nor sti_hqvdp_atomic_update() checks
hqvdp->xp70_initialized.

A subsequent commit on the plane then performs unclocked MMIO reads and
writes in sti_hqvdp_atomic_update() (via sti_hqvdp_get_free_cmd() and
HQVDP_MBX_NEXT_CMD), which can trigger an external abort or bus hang, and
disabling the plane runs sti_hqvdp_disable() from vtg_irq_thread(), doing
unclocked MMIO and sleeping for 1000 ms in the VSync IRQ thread.

Could sti_hqvdp_start_xp70() be called from sti_hqvdp_atomic_update()
instead, with register accesses guarded by hqvdp->xp70_initialized?

> +
>  	/* Create HQVDP plane once xp70 is initialized */
>  	plane =3D sti_hqvdp_create(drm_dev, hqvdp->dev, STI_HQVDP_0);
>  	if (!plane)

[Severity: Medium]
Does this leak the prepare and enable references on hqvdp->clk?

sti_hqvdp_start_xp70() calls clk_prepare_enable(hqvdp->clk), which is now
enabled unconditionally at bind time even if the plane is never used, and
nothing calls clk_disable_unprepare(hqvdp->clk) if sti_hqvdp_create() or a
later component bind fails, or when the component is unbound in
sti_hqvdp_unbind().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126024710.3340=
1-1-hiyoukou@gmail.com?part=3D3
