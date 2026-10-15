Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A3CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BCD10EC36;
	Thu, 15 Oct 2026 15:24:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093AA10EC36
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:24:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8138F60120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1D21F000C4;
 Thu, 15 Oct 2026 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077839;
 bh=giUe/0pZH+ILQbdNv7oPE7pXmnONwUClpS+hq0/q0CI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fUsy0C7pZmai2t9Eut66Yi/WBSb4xyo5X/Fiu9RmMdzSN69SG6lErOhHWFrLDy/jB
 hjRf3csPfwbCtv+hiVrgXu0FQAxXx0aCFDO3cqkSlByf8/QYmFFhAyR4LGzrVOClR1
 iGPSk2iZV3Rk6Zf56p2Jr5eN8Qf0Fi7o9ZWWC5mao6N2rd4VeI0xiYLyiQ9XZgKw/e
 OYR17grdNj6PSTpSZpPLaAlR/rxZrH9zoOu9ue9VKUaAbDJ8w3iUzqC5dxv+0DCO7V
 bVNMdMfPI+LpgKI6bNTi09BmJVXJBrW6r6ruSD9OEO3z2HkPi2bb6gBplihmKzYTQk
 e7OxPxiXN7o9A==
Message-ID: <sashiko-outbox-173062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/28] drm/atomic: Fix private obj error handling
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-1-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-1-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:23:58 +0000
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
- [High] drm: double list_del() on private obj init failure
--

commit 4bcc9dc639c9860732e1906f0390e6fdeeb98b4e
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Fix private obj error handling

drm_atomic_private_obj_init() adds the object to the privobj_list before
calling atomic_create_state(). If atomic_create_state() fails, this patch
adds an error path that removes the object from the list to avoid a dangling
entry.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f4..9973becb75aee 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1029,6 +1029,8 @@ int drm_atomic_private_obj_init(struct drm_device *=
dev,
>  				const struct drm_private_state_funcs *funcs)
>  {
>  	struct drm_private_state *state;
> +	int ret;
> +
>  	memset(obj, 0, sizeof(*obj));
> =20
>  	drm_modeset_lock_init(&obj->lock);
> @@ -1038,12 +1040,19 @@ int drm_atomic_private_obj_init(struct drm_device=
 *dev,
>  	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
> =20
>  	state =3D obj->funcs->atomic_create_state(obj);
> -	if (IS_ERR(state))
> -		return PTR_ERR(state);
> +	if (IS_ERR(state)) {
> +		ret =3D PTR_ERR(state);
> +		goto err_list_del;
> +	}
> =20
>  	obj->state =3D state;
> =20
>  	return 0;
> +
> +err_list_del:
> +	list_del(&obj->head);

[Severity: High]
Does this error path introduce a double list_del() panic during driver
teardown?

Several callers of drm_atomic_private_obj_init(), such as vc4_ctm_obj_init()
and drm_dp_mst_topology_mgr_init(), ignore its return value. They
unconditionally register their teardown functions, which perform their own
list_del(&obj->head) via drm_atomic_private_obj_fini().

For instance, in drivers/gpu/drm/vc4/vc4_kms.c:vc4_ctm_obj_init():

	drm_atomic_private_obj_init(&vc4->base, &vc4->ctm_manager,
				    &vc4_ctm_state_funcs);

	return drmm_add_action_or_reset(&vc4->base, vc4_ctm_obj_fini, NULL);

If atomic_create_state() fails here, we delete the list head and return an
error, but the caller ignores it. Then, at teardown,
drm_atomic_private_obj_fini() executes a second list_del(&obj->head) on the
poisoned list head, causing a panic.

Will this unwinding cause crashes for these existing callers if initializat=
ion
fails?

> +	drm_modeset_lock_fini(&obj->lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_atomic_private_obj_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D1
