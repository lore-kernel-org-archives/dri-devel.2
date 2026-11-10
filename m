Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B5606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ME3kCSzS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34F610F603;
	Tue, 10 Nov 2026 12:35:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BB910F603;
 Tue, 10 Nov 2026 12:35:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A45341899;
 Tue, 10 Nov 2026 12:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F601F0089F;
 Tue, 10 Nov 2026 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794314145;
 bh=fluuu4xEYv/Da1IY1IuAuVNAQQZsRT3U3HedNDF+t1A=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=ME3kCSzSFXFuLSjcEwqi8H5Fy0+29inmvRFL7i8ZeewELyg7qXBAsUNTX01icopjy
 5ibbwnk4T+GYh3gc0yaHLTl1w/U5dffr5xHLg1tpF0p7XzA18izSirmBw+HTP45s+w
 49RjvO0X2n0ilcjpoGpu6qK7xyiPSqk0zaljMLrnWoBZmcOUMwT86cfJzvlXd6Yp6W
 or+SBUEbdOfcLZ/5oU1SRPxSmAjN2VWb3DCKfHLEUn0yJkQbmGWr5WCGyVdw6hHI6/
 ojRiBogxyNuraxBtIFU/EvDuOdp9iFsTcR5ifCvw89wmCnT1tG7LgE7/cL/HWCCy7S
 H1fy+vuUlT2Lg==
Message-ID: <b7ef68866304a49acfa0be3e1e4078cd@kernel.org>
Date: Tue, 10 Nov 2026 12:35:42 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
In-Reply-To: <20261110120326.538252-1-tzimmermann@suse.de>
References: <20261110120326.538252-1-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, "Maxime
 Ripard" <mripard@kernel.org>
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Tue, 10 Nov 2026 12:53:26 +0100, Thomas Zimmermann wrote:
> The helper drm_crtc_init() sets up a CRTC with a primary plane for
> non-atomic mode setting. Only drivers for some AMD hardware still
> use it.
> 
> Inline drm_crtc_init() into amdgpu and radeon and remove it from
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
