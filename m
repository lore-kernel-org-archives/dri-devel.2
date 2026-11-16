Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247C606AB6B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IE2XIxF9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6826810EF61;
	Mon, 16 Nov 2026 11:08:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC97B10EF61
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:08:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC49E6287D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFC1F000C5;
 Mon, 16 Nov 2026 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794827300;
 bh=Bryua1IHnl2xGc61WQRfMsS1gZL1h3OiJH++4Gi4CZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IE2XIxF9AbDaanka5QNa6kUuMNMnHLpnABZ1GM6MZLArgC/POVATawhm0Izk++uLc
 XWAGtl3M+l9KlgJzmEliIq50gqmbgTXdpBiZw3StWITx1YKebPx1cYCQUE3f0uILLs
 TKe5vAysua+6N+Qzdqb7mhfJXxm+sUgET4lGt+ixBW95OzBfUmRDkNDaiujZrU0x7Q
 7Oj/t60wZXp8sV251IFolcQWjigVaoIngLn1zHn3kIefYtfNg2TVGnM5OeZKS1XSe/
 hk4qMdLzLWwiVLWP4TnagTXw0qtG13p7Ryo5FSke81VYXSkPXBbifxHmZ1XSvbKa8W
 S94ITxnt6oapA==
Message-ID: <sashiko-outbox-216845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 62/64] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-drm-no-more-config-reset-v2-62-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-62-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:08:19 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/vmwgfx: leak of ldu_priv in vmw_kms_init() on initial
  state error
--

commit 5f937b8ad11b4bd1a6956c12405bef9b28767c1f
Author: Maxime Ripard <mripard@kernel.org>

drm/vmwgfx: Switch to drm_mode_config_create_initial_state

This commit replaces the drm_mode_config_reset() calls in the individual
display unit init functions with a single
drm_mode_config_create_initial_state() call in vmw_kms_init().

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 90ab9380d8830..4924649033bb7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1175,11 +1175,23 @@ int vmw_kms_init(struct vmw_private *dev_priv)
>  		if (ret) /* Fallback */
>  			ret =3D vmw_kms_ldu_init_display(dev_priv);
>  	}
> +	if (ret)
> +		return ret;
> +
>  	BUILD_BUG_ON(ARRAY_SIZE(display_unit_names) !=3D (vmw_du_max + 1));
>  	drm_info(&dev_priv->drm, "%s display unit initialized\n",
>  		 display_unit_names[dev_priv->active_display_unit]);
> =20
> -	return ret;
> +	/*
> +	 * Create the initial state once, after the display unit that will
> +	 * be used has been settled on: a failure in one of the display
> +	 * unit initialization functions is used as a fallback condition to
> +	 * try the next one, and creating the state on a partially
> +	 * initialized device would both leave the KMS objects of the two
> +	 * backends on the same drm_device and trip WARN_ON() on the objects
> +	 * that don't have a state.
> +	 */
> +	return drm_mode_config_create_initial_state(dev);
>  }

[Severity: Medium]
Does this leak dev_priv->ldu_priv if drm_mode_config_create_initial_state()
fails after falling back to vmw_kms_ldu_init_display()?

vmw_kms_ldu_init_display() allocates dev_priv->ldu_priv with kmalloc_obj(),
which is only freed by vmw_kms_close() -> vmw_kms_ldu_close_display(). When
vmw_kms_init() returns an error here, vmw_driver_load() jumps to out_no_kms
and skips vmw_kms_close().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-drm-no-mor=
e-config-reset-v2-0-0bb471f4d1e0@kernel.org?part=3D62
