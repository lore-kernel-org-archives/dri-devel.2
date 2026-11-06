Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RB21rBPU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40D7112D6A;
	Fri,  6 Nov 2026 13:33:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F663112D6A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53BCB40D41
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1950C1F0089F;
 Fri,  6 Nov 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971991;
 bh=k6iVkbOfucje5xhfpTi5BED914rn6xsYJ9XmJAWbNck=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RB21rBPUhkc36kBmJoC8IPxkOS8sdyfvEwAt7kykAGK5rDcXxFdUWji7UGDlGfjuh
 9X9qCHX0mEfTIfzce4MWVh51f7HS0ooojm6nLz5WScCU3pCMFyQ07UUKAkuE/Wre04
 sH4NPYITWYNyC06e0whr0SAuIgi6zhmXVrKfrMek77wOyHkZ8R7ESnDfpO+RkMtybE
 QdVltLxhlF7vboNuzqxU+8Cx0jBXLxgNiAAoeZrLaixLwM+5dz7aqqAUQoCXV2JFWF
 YsMk7EYllDWHLpVycPMGKUlB5LUfopbryjldEHsZ4xmtWfza1PD2TAJHz9VENxTNY8
 Yx0+a7resrZ3A==
Message-ID: <sashiko-outbox-201471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/39] drm/ingenic: Convert to devm_drm_bridge_alloc()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:33:10 +0000
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
- [High] drm/ingenic: use-after-free in ingenic_drm_bind() from
  devm/drmm mismatch
- [Low] drm/ingenic: missing devm_drm_bridge_add() in ingenic_drm_bind()
--

commit b0cc78f8ec81445f2abbfeb18a785a51d40b8824
Author: Maxime Ripard <mripard@kernel.org>

drm/ingenic: Convert to devm_drm_bridge_alloc()

This commit converts struct ingenic_drm_bridge allocation in
ingenic_drm_bind() from drmm_encoder_alloc() to devm_drm_bridge_alloc()
paired with drmm_encoder_init().

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 63198fd594984..8cad8dcfae609 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1303,20 +1303,27 @@ static int ingenic_drm_bind(struct device *dev, b=
ool has_components)
>  			drm_panel_put(panel);
>  		}
> =20
> -		ib =3D drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
> -					NULL, DRM_MODE_ENCODER_DPI, NULL);
> +		ib =3D devm_drm_bridge_alloc(dev, struct ingenic_drm_bridge,
> +					   bridge, &ingenic_drm_bridge_funcs);
>  		if (IS_ERR(ib)) {
>  			ret =3D PTR_ERR(ib);
> -			dev_err(dev, "Failed to init encoder: %d\n", ret);
> +			dev_err(dev, "Failed to allocate bridge: %d\n", ret);
>  			goto err_drvdata;
>  		}
> =20
>  		encoder =3D &ib->encoder;
> +
> +		ret =3D drmm_encoder_init(drm, encoder, NULL,
> +					DRM_MODE_ENCODER_DPI, NULL);
> +		if (ret) {
> +			dev_err(dev, "Failed to init encoder: %d\n", ret);
> +			goto err_drvdata;
> +		}

[Severity: High]
Can mixing devm_drm_bridge_alloc() and drmm_encoder_init() on the same
struct ingenic_drm_bridge cause a use-after-free of ib->encoder during
teardown?

ingenic_drm_bind() allocates drm via devm_drm_dev_alloc() before calling
devm_drm_bridge_alloc(), so devres runs drm_bridge_put_void(&ib->bridge)
before devm_drm_dev_init_release() runs drm_managed_release().

On unbind, drm_bridge_put_void() drops the devm reference on ib->bridge,
leaving only the reference taken by drm_bridge_attach().  When
drmm_encoder_alloc_release() then calls drm_encoder_cleanup(&ib->encoder),
detaching ib->bridge drops its last reference and __drm_bridge_free() frees
the entire struct ingenic_drm_bridge container while drm_encoder_cleanup()
is still accessing encoder:

drivers/gpu/drm/drm_encoder.c:drm_encoder_cleanup() {
	...
	list_for_each_entry_safe(bridge, next, &tmplist, chain_node)
		drm_bridge_detach(bridge);

	drm_mode_object_unregister(dev, &encoder->base);
	kfree(encoder->name);
	list_del(&encoder->head);
	dev->mode_config.num_encoder--;
	mutex_destroy(&encoder->bridge_chain_mutex);

	memset(encoder, 0, sizeof(*encoder));
}

If drm_bridge_attach() fails earlier during bind (for example with
-EPROBE_DEFER), drm_bridge_put_void() frees ib before drm_managed_release()
even enters drm_encoder_cleanup().

> +
>  		encoder->possible_crtcs =3D drm_crtc_mask(&priv->crtc);
> =20
>  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
> =20
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
>  		ib->next_bridge =3D bridge;
> =20
>  		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,

[Severity: Low]
Does attaching &ib->bridge without calling devm_drm_bridge_add() first
trigger a warning in drm_bridge_attach()?

Previously drmm_encoder_alloc() zero-initialized ib->bridge.list, so
list_empty(&bridge->list) was false.  __devm_drm_bridge_alloc() initializes
bridge->list with INIT_LIST_HEAD(), causing drm_bridge_attach() to hit
DRM_WARN("Missing drm_bridge_add() before attach\n") on every probe.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D1
