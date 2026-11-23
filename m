Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7844606A333
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtMHDWY4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0248110E78F;
	Mon, 23 Nov 2026 12:53:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86C510E78F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:53:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE46F61264;
 Mon, 23 Nov 2026 12:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8201F000C4;
 Mon, 23 Nov 2026 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795438387;
 bh=4/O70bfoOli5WnslzwPrt7cL+seY/RWkEkFVtKOsYPE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=WtMHDWY4UnlBp3mPIB10WxJdpT8OUb9P4rmFrwoEWje7bUdbQZV6vbjAX1xXmrUqh
 7AqC/nx18ZRZ01iAhT5YfuAwvNAH7CS7MVQX1oSY3EGCSTjx77asXhaJNv+g23539n
 28nmY1YtcmEvy4QDd7bebJFB6lzsDgpDAwN9MCfrXJ+vtnchMcln38xNZ2czBskEye
 5qTeVgkQnF9aMoqSKtY+X75BP2QgGmQYJon9LVjWT28i+lcrc4NVVp/+re8D8wBOeb
 A6g/jAGocqab2B5kiBBT2TujnQCzstdBItVecrdYOMEqHCK9KyJJgVCWxMqa6mQ+SG
 XWTfY6QHu83aQ==
Message-ID: <fd4a16ac9439834f998735819be6ba9e@kernel.org>
Date: Mon, 23 Nov 2026 12:53:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 01/25] video/hdmi: Copy SPD vendor/product with
 strtomem_pad()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "David
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

On Sat, 14 Nov 2026 20:03:25 +0200, Cristian Ciocaltea wrote:
> The HDMI specification defines the SPD InfoFrame Vendor Name and Product
> Description as fixed-size fields, padded with zeros and left without any
> trailing NUL when a name spans the whole field.
> 
> Mark the fields as non-strings, so that the copies can be handed over to
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
