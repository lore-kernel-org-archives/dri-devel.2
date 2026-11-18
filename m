Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E247606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsgEYDzG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9568210E0C8;
	Wed, 18 Nov 2026 07:17:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C7C10E691
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF25E42DDE;
 Wed, 18 Nov 2026 07:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10611F000C4;
 Wed, 18 Nov 2026 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794986227;
 bh=4HGkfAVus6YcI7VI/ZJ3dJp8pV2R3bXnKS6/VIEVFFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IsgEYDzGQiJjT1qC5qKJvbnaQejQHzSfn5/Z57XccP79WXXeIuiPHyJkbxFCfZK8j
 PFP+95Kb8AiloI+ZoPZnPlasyoJ8MkgN/1DmcYm0rf2vDlaHvU6jB5MPgBfysXiiQX
 Sw6FHkbsdFJkQY17WYDmzTgNiqzsiDDBo+1m9SJECuYb33sDqf4paki5NnbasMDkiI
 K1VSR40o3IzmT9aHQLCPEJaKTn2ier7LOQYKB9sITakAyF2+omw/KqpiaxqHvizN4Y
 rYfxSauwTnZrDFwfDR8L/K+LAGxfSI4+NnA5NAS3f9UTbPKs6Vm03z83HaNnSHdyOC
 2W4+bULle0z5Q==
Received: from johan by xi.lan with local (Exim 4.100.1)
 (envelope-from <johan@kernel.org>) id 1xTZui-00000004UkN-33Gh;
 Wed, 18 Nov 2026 08:17:04 +0100
Date: Wed, 18 Nov 2026 08:17:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
Message-ID: <av1Q8B27DkF8Iv2W@hovoldconsulting.com>
References: <20260716132334.1565183-1-johan@kernel.org>
 <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
 <avw_XKo3EzosfyIh@hovoldconsulting.com>
 <CAD=FV=X5DTqanxUBt9KoVh_93u9EUQm8_B2mnej=+-nxpA81gw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X5DTqanxUBt9KoVh_93u9EUQm8_B2mnej=+-nxpA81gw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 08:24:53PM -0800, Doug Anderson wrote:

> I took a quick gander. One thing I notice is that earlier in the
> thread there is a Sashiko review [1]. It seems to point out a valid
> problem here. I'd imagine that if I land this patch, I'll get a
> nastygram from Arnd and his RANDCONFIG testing. Am I confused? Is
> Sashiko wrong in its analysis?

Thanks, Doug.

Yeah, I took a look at that at the time and I believe the LLM is
mistaken as DRM selects I2C since forever so the driver cannot be built
without CONFIG_I2C enabled (and you'd have the same situation with
the panel-edp change merged in July).

I started cleaning up the I2C mess but got pre-empted. I don't think
that should block this change.

Johan
 
> [1] http://lore.kernel.org/r/20260716134901.05E221F00A3E@smtp.kernel.org
