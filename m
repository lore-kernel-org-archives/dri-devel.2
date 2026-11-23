Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C55606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnb0gqJa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE7610E7F1;
	Mon, 23 Nov 2026 13:07:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7692810E7F1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:07:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EAD143926;
 Mon, 23 Nov 2026 13:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615591F000D1;
 Mon, 23 Nov 2026 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795439263;
 bh=9OlWkQM+XFoN1Gs95fD/lZlKv7wZ9cKWXpxYEv3AD9g=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=hnb0gqJazK387+u2EVsGIBflv5BRGabh1+/e68fIAp0LpW/GSLj2dey8mo2V4esdD
 07JfjdvM45fs3Zm59mN8WA19c9ZN8De+bYmfBZ8yxu5lGqTuljKdYn3tlyw+i0spoG
 C4giAORXw1pORS21HEcnFL9yIJhSCJ5tQ/Ia1Uz8mXgkyMcQQvwrkWi0yYyqt/Mwa2
 baEI/C4665/euuzOS8k1orEm7fWbvUCxmr6HvaOEXAf9bKFOcJTUbWbwHDGJaYc+P6
 YiBz8pDKinek7XEJodZtaWUPet2z20utNtqGYAf/R5ojRE1RylRVljwx/SHOEUNqfh
 fvGb3WPU6+Z0Q==
Message-ID: <2fddb3794c21ee97aebfdbc14f29ad9f@kernel.org>
Date: Mon, 23 Nov 2026 13:07:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 09/25] drm/connector: Drop redundant hdmi
 supported_formats field
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-9-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-9-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 "Hans Verkuil" <hverkuil@kernel.org>, "Helge Deller" <deller@gmx.de>, "Igor
 Paunovic" <royalnet026@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?Um9iaW4gUsOkYmVy?= <robin.raebi@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thierry Reding" <treding@nvidia.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
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

On Sat, 14 Nov 2026 20:03:33 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, supported_formats is provided through struct
> drm_connector_hdmi_funcs, a reference to which is already stored in
> drm_connector_hdmi.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
