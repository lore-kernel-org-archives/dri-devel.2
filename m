Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7722606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsKPwXYO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1445110E11C;
	Mon, 23 Nov 2026 16:02:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1976810E11C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:02:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C64784033F;
 Mon, 23 Nov 2026 16:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB231F000CA;
 Mon, 23 Nov 2026 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449768;
 bh=ogU99soocUNAyEPeTznDE3E4dl7rtcgWRc2b1gTGjxY=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=AsKPwXYOYxgAIR1jYhhjlxzaPCpWcxmf5T4hw5nToJppZY+VG3updxJULSflHR5qN
 YpuyJjV2wIFTkDIjx30ulOpinKPOHucmRMZbd/BUMNoEMglunojM6oY4jSoAx0Ejjc
 ZoE8VR7uiZXKPrrkQDVN6/9iWv2yc8Z+79qyuYslHgOJ3mcmeQEIphJjp7d8l9fK7z
 Ba0OnqUpUslek5mlEkTGiSBu21jX5Kg/xI8SkUy59T0FgDEYyWvSc5VEj9du8JLDOy
 UfbCmd2mPfLydPyxiF+G9qw/Iw/1WQev04siPm8yV8jx6yzWcQZIQEKGTPURAzD0Jj
 pPJkLwUG4YrFA==
Message-ID: <844a6063c212561296f2275e9cf4b1ee@kernel.org>
Date: Mon, 23 Nov 2026 16:02:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 16/25] drm/tests: connector: Add HDMI max_tmds_char_rate
 init coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-16-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-16-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:40 +0200, Cristian Ciocaltea wrote:
> Add KUnit tests for the new drmm_connector_hdmi_init() extension, which
> infers the connector's max_tmds_char_rate from the HDMI specification
> version advertised by the driver, for every known version.  Also
> validate a driver-capped max_tmds_char_rate against the version-inferred
> limit: override below, accept at, reject above, reject when no version
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
