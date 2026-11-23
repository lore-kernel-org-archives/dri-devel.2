Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA9606A336
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLM1k6L2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D858F10EC4A;
	Mon, 23 Nov 2026 16:32:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B62E10EC4A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:32:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8A19411BB;
 Mon, 23 Nov 2026 16:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90861F000C6;
 Mon, 23 Nov 2026 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795451549;
 bh=syh5NUCkFSDuNSoqaqc0P58U/D0IjYIPZRRH/6IPrVo=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=CLM1k6L2JXN72bCmrf2hP4K7BImGUMgSljhky3dH1hK5x3lMsxoyNkZ1JHhGhgfED
 xcHPy3el2QY4UR4M/HdmFGpmvvaWH899lGS0PcFe4JpIjtCy3fN0QjrQfXvQU5vyLu
 hViBTSOHYeMAV/8lfwdnfODg78J88nlU3kJF71RGl9VcnOiJ4aF2APBc4tbWsHHJCk
 pYx3kOyQbMeJ14LpaHdOVY5KSBImK/gtmL9/RQC/S8m5O08/H31KfgLsf1cw0d3H7m
 jjQoRpHdfFVqEGLwgPAXSrAsb5eFP4fJz4qoMefDx/5hRz+Tye7H51xRX2O3Y/8wnb
 EM3WSFyo7K+Vw==
Message-ID: <d72ce0d7c68709192afada7ad52409f2@kernel.org>
Date: Mon, 23 Nov 2026 16:32:26 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 19/25] drm/tests: hdmi: Verify scrambler_needed computation
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-19-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-19-20e8a33a2286@collabora.com>
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

On Sat, 14 Nov 2026 20:03:43 +0200, Cristian Ciocaltea wrote:
> Scrambling is only required when the TMDS character rate exceeds 340
> MHz, so the decision must be based on that rate rather than on the mode
> clock.  Add atomic-check tests on an HDMI 2.0 connector, for which the
> core infers scrambler support and a 600 MHz TMDS limit, covering:
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
