Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD6606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUidxd8E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F33110E769;
	Mon, 23 Nov 2026 12:57:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5600410E769
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:57:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DC3042E82;
 Mon, 23 Nov 2026 12:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F01F000CF;
 Mon, 23 Nov 2026 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795438663;
 bh=zNq/MlEjOpYgXITeVLi5w4s9w4CqSYphZ/ocF2OCe1Q=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=LUidxd8E92aKROlErK0iYasgvyjOewYoRm5sY/9Z8f6OmY9GVu0U2qY1GI0vwIexc
 O8S4MSTO4UXGRzNRX/wsbsQkke8AEi24fUSwEJ2HS+/l6R58a+ttVxx35wBZxipBlW
 RN/WOdGQ4Ydjj8rFKFzh3SkUaakC21YdGqF07D9+zUZ2Cpsl8Sh1qLwfr0zpFod5Zj
 97v/DZy/axkFROCP0muODpntkfPt4+IF4N6crN0NIfWDXB4i98wd6scP5TYhrHH3d0
 Eik7E7yDxG1YW0VefTvSKmCqxZqQcSZC3MvUcFdD/MhK1ectdzL2eb/1DrUBDKXHdg
 GzmefYEwvoUYw==
Message-ID: <26dd97eb96195f3884e7dc55e677eded@kernel.org>
Date: Mon, 23 Nov 2026 12:57:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 05/25] drm/tests: connector: Convert to
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-5-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-5-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Sat, 14 Nov 2026 20:03:29 +0200, Cristian Ciocaltea wrote:
> Switch tests over to the new drmm_connector_hdmi_init() signature, where
> the vendor, product, supported_formats and max_bpc values previously
> passed as arguments are now provided through struct
> drm_connector_hdmi_funcs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
