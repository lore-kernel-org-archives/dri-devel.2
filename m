Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9708606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l77HuDWW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AAD112F19;
	Fri,  6 Nov 2026 16:40:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7D5112F12
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3B9E42AE1;
 Fri,  6 Nov 2026 16:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2581F008A5;
 Fri,  6 Nov 2026 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793983214;
 bh=Ay2elfYczK0OYydR8mDHF51I2gsg5W+QJhXacNMWDz8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l77HuDWWO6hC/1ORGbwYjSMq8wMbRO5BIupU3oGbhlevPYQ4BI4B2zSaNgwEpfQeF
 /t0HhdKtlG/Q9y9KSqObHsksz8rye0pHo5YchlQbWxEOS/56ZG7OmCBYiWr60BPFsY
 nEHqfLFbk3unVX18WA33UEIACD4UuAS3SiF7CkPnS0uwkwLLSXDPtTthOde2bid3Zo
 szCEq56VGtcrZBI6S6diTOczD5mEuLVXj+E39utwUtAvfzNm2AGC1H4kWrnU+eOT0Y
 UrDw2sh7rOIbNfTiPnHaSPIGTqd1igR0BI2yUsUPqbjYi//6BYVctqOrIV4dzrEe7D
 s/FSRxNOGli0g==
Message-ID: <sashiko-outbox-201842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/todo: remove drmm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-3-c0ea3382b798@bootlin.com>
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
 <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-3-c0ea3382b798@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:40:14 +0000
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
- [Medium] drm/todo: premature removal of drmm_of_get_bridge() with
  remaining vc4 callers
--

commit 73f1f37bf0d85f99c672e8364cc4d9cbf3a65321
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/todo: remove drmm_of_get_bridge()

This commit removes drmm_of_get_bridge() from the list of deprecated
panel_bridge functions to remove in the DRM TODO documentation.

> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index a437ae5c71f47..a2500418ff2ef 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -494,7 +494,6 @@ transparently, and the are deprecated.
>  The funcions to remove are:
>   - drm_panel_bridge_add_typed()
>   - devm_drm_of_get_bridge()
> - - drmm_of_get_bridge()
>   - drm_panel_bridge_remove()
>   - drmm_drm_panel_bridge_release()
>   - devm_drm_panel_bridge_release()

[Severity: Medium]
Is it premature to remove drmm_of_get_bridge() from the TODO list and the
kernel?

Two unconverted callers remain in the VC4 driver: vc4_dpi_init_bridge() in
drivers/gpu/drm/vc4/vc4_dpi.c and vc4_dsi_bind() in
drivers/gpu/drm/vc4/vc4_dsi.c.  With drmm_of_get_bridge() removed in
commit "drm/panel: remove drmm_of_get_bridge()", building with
CONFIG_DRM_VC4 enabled fails until those callers are converted as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-panel_=
bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com?part=3D3
