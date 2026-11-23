Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC4606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HiApJnJl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7DD10E7B7;
	Mon, 23 Nov 2026 16:04:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD33F10E7B7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:03:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C91840B60;
 Mon, 23 Nov 2026 16:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32651F000C4;
 Mon, 23 Nov 2026 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449836;
 bh=ImikEajVtw1Ud3tQpZGQiXNpkN9E46qiLZ4YF5GFcnI=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=HiApJnJlu/SccLq2ljVGGeLFPZF+cqxJVBPFtlqcGngaRUW39BeRybbHS7k7pZKio
 MJv2luvLilLBnGzqhlyto0eKesX+g/+HVJYsCw1d0tBpaStcgBunE8KX1UemD4kyjC
 1PCiHjFwGs/YqCXUMeNTgO1IiTVFRVadLDM3Wof6HgVGc7Qq/zoOB0+exvw0nu9NG2
 hY812pA8oHgKatmV/OzfHalCZJNPVpK8R4TFOZFOlPZxdwVDdugwZ3MR9vTH7ApcRr
 KsDV4N7aS+Gq3/pk/B4tTkZEkkqvWtPp2zsHR5RhbCBPXprLZL7cOnnegXcFXvFLYk
 UyAQw7RmXSCgw==
Message-ID: <b59e98094e10e9baa3309019c729d576@kernel.org>
Date: Mon, 23 Nov 2026 16:03:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 17/25] drm/tests: connector: Add HDMI source-side
 scrambler coverage
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-17-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-17-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:41 +0200, Cristian Ciocaltea wrote:
> Add KUnit tests for the HDMI source-side scrambling validation done by
> the new drmm_connector_hdmi_init() helper.
> 
> Connector initialization derives scrambler support from the
> driver-provided supported_hdmi_ver capability.  Therefore, connectors
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
