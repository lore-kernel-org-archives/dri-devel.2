Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DK4j4JVl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66CD10E7C5;
	Mon, 23 Nov 2026 13:08:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F85410E7C5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:08:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C73B612B6;
 Mon, 23 Nov 2026 13:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02431F000C0;
 Mon, 23 Nov 2026 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795439278;
 bh=LKa2vsaDvtaWNoj3QpEStf5Hs24zGtCTpUXk/Yj/O2k=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=DK4j4JVlbEivXv3TjcwcBwzD5AUYazUJ6ef11A73UhNJRpp9blOC3zziE1sENTJ7n
 4/9sbQTirzrP2gl1KUSCFR12zIO7vYE82+3nwkNCMOZ7Pv8yc1/fp1H1Qm9T7eTflW
 L/EMq8zh+4kpHX3VvBnm6snCwpkUT5ZIu9KtTDco33fg+N6Rt4bYqJBrMKiq7Wc0+4
 xTth6wqo6XdV9sZeay++YZrOZ+PUnpHdRl1AsBbS9RJJUjotbDclRjgjEKKxYu/PZ3
 4QLhXXPdUey7uGk57zF3pC/Q3HNWNxSd4p2WlZBZlytxxePyKFzR72J6V3k0Ib2faN
 SXC6eLgqO324g==
Message-ID: <98380c565736e8f2b72dd0299743d57c@kernel.org>
Date: Mon, 23 Nov 2026 13:07:55 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 10/25] drm/connector: Drop redundant max_bpc field
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-10-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-10-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:34 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, max_bpc is provided through struct drm_connector_hdmi_funcs,
> a reference to which is already stored in drm_connector_hdmi.
> 
> Drop the redundant connector->max_bpc field and point its users to
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
