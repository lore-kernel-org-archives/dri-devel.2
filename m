Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA67606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmk730E4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05D310FE9E;
	Wed, 25 Nov 2026 17:59:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD9A10FE9E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CFA761DDE;
 Wed, 25 Nov 2026 17:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15031F000C4;
 Wed, 25 Nov 2026 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795629590;
 bh=EvLUU+i87Xih6BMRkCTHh3iFiwDCIvyzWq2UAlrVtYA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hmk730E4nUTvBUK/u10u+zA0ONEv3JG6CQshHIFd2jABxgXOy8sbVcMX7o7c13m98
 Gt8QtmS9WZ6brXc/XVD3M9sLIr3g0XZjFAhcHrrHYPlyBr3PoOvi/v2BQVEBRji3Oc
 Zj2zPyViXdHp7Sq1BbuJ5/BJ7O/k5ClyYcmwAs+EXXvkJTNuhml/4NHAj8zLoGGQVF
 qN7/kUzJ253abSl1fq+VFvQOdA9doyaTbvzgVeoQXXFHllKiDY1tf2P9p8o9wP9Jl+
 a1eZAje07hwMDi/uNOjYzeeSZ2sbirAC6nZlqA0agyNgA8I3K37urIU1kArnMchKEm
 RC2xgfJq45SYQ==
Message-ID: <sashiko-outbox-233880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/32] drm/bridge: constify
 of_drm_find_and_get_bridge() device_node parameter
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-11-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-11-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:59:49 +0000
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
- [Low] drm/bridge: non-const np in !CONFIG_OF
  of_drm_find_and_get_bridge() stub
--

commit 7679a18d386b4f07d4526f35667dbb513f3a913d
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: constify of_drm_find_and_get_bridge() device_node parameter

This commit changes the device_node parameter of
of_drm_find_and_get_bridge() to const so callers can pass a const pointer.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 12ca7f6fb5243..d6ef020c4cc9b 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1274,7 +1274,7 @@ int drm_bridge_attach(struct drm_encoder *encoder, =
struct drm_bridge *bridge,
>  		      enum drm_bridge_attach_flags flags);
> =20
>  #ifdef CONFIG_OF
> -struct drm_bridge *of_drm_find_and_get_bridge(struct device_node *np);
> +struct drm_bridge *of_drm_find_and_get_bridge(const struct device_node *=
np);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  struct drm_bridge *of_drm_get_bridge_by_endpoint(const struct device_nod=
e *np,
>  						 int port, int endpoint);

[Severity: Low]
Should the !CONFIG_OF stub of of_drm_find_and_get_bridge() in the #else
branch right below also take a const struct device_node *np?

include/drm/drm_bridge.h:
    #else
    static inline struct drm_bridge *of_drm_find_and_get_bridge(struct devi=
ce_node *np)
    {
    	return NULL;
    }

Without const on the stub, passing a const struct device_node * in a
!CONFIG_OF build fails to compile with a discarded-qualifiers error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D11
