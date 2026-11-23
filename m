Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F027606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hq4tuU7Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B505910EEE3;
	Mon, 23 Nov 2026 15:31:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E151510EEE3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:31:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F16D5622F4;
 Mon, 23 Nov 2026 15:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016811F000D0;
 Mon, 23 Nov 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795447895;
 bh=saLnfNPmsNs2Ceg6gcANcLn87Y4bq8AO+/qeu4LIL6A=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Hq4tuU7QWrB22/kGIC1JjkwS64OmbEFEpd9j3wxh5d3T2U20wm8+M6xA2BhJMv4/a
 tbOUMmbDkfRyDPrLd4XhlUhf9J8NZR7FCBWOhz4QceL2k5VJCJHuyLg/jxjFuycCMK
 5lBBRhYZtKF6kOxw6YgVGY0DkDXe6uZQgHXF6nqWB9NvItIVsIf1Ar70vBe4gYzd7o
 7SnNFJwtJv67tmUE+BoAv72CLbP3bye9CrtHpnR/w5OjUEpWWa5MtSDY1AR5lYp+5f
 AxMfB81CtjQ47xY21y5QWC2fv2vj7Dc7zV+F2vHrOHzP8x45oLpe3WnzXnidcERruI
 fyRvS02NxNwhQ==
Message-ID: <1b1e27151f140aae552460189a1d608e@kernel.org>
Date: Mon, 23 Nov 2026 15:31:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 12/25] drm/connector: Fix comment in
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-12-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-12-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:36 +0200, Cristian Ciocaltea wrote:
> The comment related to the computation of maximum TMDS character rate
> refers to a non-existent caps->max_tmds_char_rate, a left-over from the
> early stages of development.
> 
> Update the statement to reference hdmi_funcs->supported_tmds_char_rate.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
