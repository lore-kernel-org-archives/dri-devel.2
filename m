Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4D606A333
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qv/KBXKL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0461510E1BC;
	Sun, 15 Nov 2026 06:26:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3D310E1BC
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F868605EB;
 Sun, 15 Nov 2026 06:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF31F000C4;
 Sun, 15 Nov 2026 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794723988;
 bh=UD/foHw0BvnfH895HUVfxnwnVTVm+H1O95yVqicCrpA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qv/KBXKLZbBoPfwXpoR1RiblbGTfIC1o0cMclDCyVbZcQGXQHbR6BmG/CWPRuNrBZ
 fJeIa+dRpylOs2b9hZBcnXV1ArgYPe6neo7OVk2TD6cQXYvKfw2cjo3GDJ4koc9ezI
 F0cfEuQ0rNmf5ugmR9YB7UCXMiwH5bUC7T+EJ85EB/TeQJkVtgRjfCosQbkKi0+IQ5
 eFXraDiXh5QL8OTblzGrwbp4zG4YL1cJfJh9BX8cM71gUCTQh8qYgWzfHZ1zFLb59j
 /xH5CF7SFlB0VlvqmZQOufHE1FyO5XoCy88v/Dy6bAN+CBE4gSBYUqoeGurEJU5R9W
 xKJPIl07IA4vw==
Message-ID: <sashiko-outbox-215248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] drm/sun4i: Switch DE33 to split plane bindings
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20261115061102.229680-9-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-9-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 06:26:27 +0000
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
- [Low] drm/sun4i: stale @map kernel-doc entry on struct sun8i_mixer_cfg
--

commit 4d9d59875c066497d13ed0e8e40a5cc35799a204
Author: Jernej Skrabec <jernej.skrabec@gmail.com>

drm/sun4i: Switch DE33 to split plane bindings

This commit switches DE33 mixer discovery to use the shared plane driver
and split register bindings, removing the legacy per-mixer DE33 plane setup.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
> index e2f83301aae8d..7abc88c898d92 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -202,7 +202,6 @@ struct sun8i_mixer_cfg {
>  	int			ui_num;
>  	unsigned int		de_type;
>  	unsigned long		mod_rate;
> -	unsigned int		map[6];
>  };

[Severity: Low]
Should the @map entry in the kernel-doc comment above struct
sun8i_mixer_cfg also be removed?  Leaving it causes scripts/kernel-doc
(and W=3D1 builds) to warn about an excess struct member description.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115061102.2296=
80-1-jernej.skrabec@gmail.com?part=3D8
