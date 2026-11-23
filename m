Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70285606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8Fh3daD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2310E4A9;
	Mon, 23 Nov 2026 12:58:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D747A10E4A9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:58:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D744161934;
 Mon, 23 Nov 2026 12:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7681F000C0;
 Mon, 23 Nov 2026 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795438729;
 bh=/iMdDPOlUrYpb8pfDUfC/X2GGru3CmJD7BQ2/aFt7vo=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=g8Fh3daD3xH+mbm/mrxKESnZNu3kBwJ2o5nRb+HFA7we1T/7H+YEdvL42tRd/YLav
 YAWkg4Zb10Odzmg1d1hRv3d0ym6GOvra3iFAPMQkMpYB1X2wcBeiy6KXpNczXRF3Tq
 pRvSLxkYjPjEVlA9dMhEprbZGDEU1Y2JqMOVx67JrgwlsPG2Gg4G9ylnjhV5LRUXwv
 aMKQvMIKBK1CxR58eT6uRB9sARJn0Jq5sO7gYYLk2BB86r2Iv7eDzt0vIyxrCar8qm
 WICwTayWsG7YpMqKWwX8Db/paUAu/YhXjdSSzagWk8MLm2qQf6ac3SO4A4FEa6alXG
 S+pWvq8+AJP3w==
Message-ID: <28fb51fd6287f4b2faf996b696724c7e@kernel.org>
Date: Mon, 23 Nov 2026 12:58:46 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 06/25] drm/tests: hdmi: Convert to
 drmm_connector_hdmi_init()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:30 +0200, Cristian Ciocaltea wrote:
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
