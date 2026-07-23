Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE49C44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D5710EF51;
	Thu, 23 Jul 2026 01:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e4uvM3gF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7F710EF51
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:50:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7202840753;
 Thu, 23 Jul 2026 01:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5711F000E9;
 Thu, 23 Jul 2026 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771404;
 bh=fQAesKJLz8gU1DLEOIJ+M1KE4v50PQrIaex0JOYA0Oo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e4uvM3gFhzANmBrjt7NMgS6fhaIwsntklWB5NEiCZzFnjnZd1CQVABzZqiu+Rfxsb
 6tfvFV6O89etEKXNDoOCKxft7KHNpaAfk8glf6wo0o0gQyun3ZVqBZJIla8J8Ovcca
 bSOxB+tygNPEfWPllifB36uhEYQs5EOakc8mt0lY+4SMt1tzhLBBEYLb4PmNbcL9+0
 ywQYu2HDzV0PxAH0Fro0BBUTxdY0IJRuPOP7Kb+6E/f0jAxw5EWgRITQZMYdzsP6iN
 qLST33uThglqp+Na78Z8KCzZKl0l+Sm9A/pqhZAZJ9ej4sR+34Y47NIDvWAwSA1d7Z
 F6ik2pom+SZNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/61] drm/display: bridge_connector: Convert to
 drmm_connector_hdmi_init()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-4-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-4-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:50:03 +0000
Message-Id: <20260723015004.1F5711F000E9@smtp.kernel.org>
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
- [High] Lockless removal of bridge from `bridge_lingering_list` can corrup=
t the global list.
--

--- Patch [4]: [PATCH v9 04/61] drm/display: bridge_connector: Convert to d=
rmm_connector_hdmi_init() ---
commit d79fbb96aa85834c574a6211898049f6cf97c1a6
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()

Switch drm_bridge_connector to the new drmm_connector_hdmi_init()
signature. The vendor, product, supported_formats and max_bpc values
now live in struct drm_connector_hdmi_funcs instead of being passed as
separate arguments. Introduce supported_hdmi_ver and max_tmds_char_rate to
struct drm_bridge to let bridges declare their capabilities.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 83f1809a5d376..afaae272347c0 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -460,9 +460,13 @@ void drm_bridge_add(struct drm_bridge *bridge)

[Severity: High]
This is a pre-existing issue, but looking at drm_bridge_add() just before
this hunk, does the lockless list removal risk corrupting the global
bridge_lingering_list?

It looks like the bridge is being removed from the list without acquiring
bridge_lock:

	if (!list_empty(&bridge->list))
		list_del_init(&bridge->list);

If another thread concurrently modifies bridge_lingering_list via
drm_bridge_remove(), or iterates over it via debugfs, couldn't this
lead to list pointer corruption or a crash?

>  	mutex_init(&bridge->hpd_state_mutex);
>  	mutex_init(&bridge->hpd_mutex);
> =20
> -	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
> +	if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
> +		if (bridge->supported_hdmi_ver =3D=3D HDMI_VERSION_UNKNOWN)
> +			DRM_WARN("HDMI bridge misses supported HDMI version\n");
> +
>  		bridge->ycbcr_420_allowed =3D !!(bridge->supported_formats &
>  					       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
> +	}
> =20
>  	mutex_lock(&bridge_lock);
>  	list_add_tail(&bridge->list, &bridge_list);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D4
