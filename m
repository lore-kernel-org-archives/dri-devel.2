Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2036C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504CB10E6C3;
	Mon, 17 Aug 2026 08:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="opeJTfKV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 012FB10E6C3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:23:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21B8E600AE;
 Mon, 17 Aug 2026 08:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595D41F000E9;
 Mon, 17 Aug 2026 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786955033;
 bh=IAnRoYYaCcNWXVO+kY6gx/NoZuY4LVjT6MxFmX622og=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=opeJTfKVf1z1Ebyby4IxVs0DSH1L8WeOY0Cu0AXsh0Vk1KfEAZsXB69fwnzmpDrb3
 GE22/mzYHQXWgjnrV1Tgo11Moh1ilzoK3AXROcFXl9tNhoWRGZGgdCgb7RMOYw88nP
 b/maZ5e2xc+nzYWT/EjmTKrVkzgk8J0hYfMuE2hUo9exb86r9xrBFMIjIor6oXUFD8
 2n0f/r0ffs3tpmoXSRtG1PuRFlW1Ls6cwFWYctyUUgGkZm59hcPdWWPBmOxeY1q8pr
 +Ag0ki5gKIrGnRqn6abjiMenpm3HS95Rs++ndOrsExSpnSnM7z9fMPXD6Hn/MKyOmy
 7H2pnGwxDXb8g==
Message-ID: <cf21ed9cd15d6f6d6e41dcb73872244b@kernel.org>
Date: Mon, 17 Aug 2026 08:23:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 02/11] drm: of: drm_of_find_panel_or_bridge: simplify
 error return paths
In-Reply-To: <20260814-drm-bridge-every-panel-v1-2-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-2-19cd5277cc8d@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian
 Ray" <ian.ray@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Linus Walleij" <linusw@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 14 Aug 2026 16:05:50 +0200, Luca Ceresoli wrote:
> In prepataion to further modify the logic of this function, simplify the
> error-returning code.
> 
> With this change, on any error there is an immediate 'return -<ERRNO>;'
> statement, without having to carry on the return value until the end.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
