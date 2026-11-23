Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ay3g793d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5232010E4A4;
	Mon, 23 Nov 2026 13:07:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A1B10E4A4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:07:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99F0444814;
 Mon, 23 Nov 2026 13:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA611F000CA;
 Mon, 23 Nov 2026 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795439249;
 bh=vdxhRaQriSkjmU7uxkOrG5krlgZH26MSD++dFcw6b/U=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Ay3g793dsN2YBA+eUW3PLAfPKW2d8RoGpfOPAWBeb3ceXlZW23XpDxQRg+D5JIgXZ
 YyYRtnmp5jAGLJpYzdYSpQr+TXGfDJaCVUMM3S9AHRnkghdNpwCaZQo/3TB20oAq4F
 TTFTjxe4ZHCxBK37C/aNryEDW0915ymNfVGCw5Di8tWL0jhAy+xZF1QxR2dMdAyp94
 4Di7JTSPQAHqYd9a70HZ4fiIchq8W/8ZNintFh/emVhqsHapoxqZk+GZLM7gBLX584
 Gw/EUujZbIWvp5FYd6yL2NpR6q06fpIqbqOdHWEqsyIhTHlVtIrjj1kvLBQyPAVaWX
 1A0vJdRR4PEJA==
Message-ID: <88513b81069770339040ceea59f8e0a0@kernel.org>
Date: Mon, 23 Nov 2026 13:07:26 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 08/25] drm/connector: Drop redundant hdmi vendor/product
 fields
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-8-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-8-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:32 +0200, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, vendor and product are provided through struct
> drm_connector_hdmi_funcs, a reference to which is already stored in
> drm_connector_hdmi.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
