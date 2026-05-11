Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F43CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 07:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45BC10E1A5;
	Mon, 11 May 2026 07:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u4bsnOCC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472C110E4DA
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:16:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 67FEF6001A;
 Mon, 11 May 2026 07:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD1CC2BCB0;
 Mon, 11 May 2026 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778483789;
 bh=s/p9ZMl4D1FgVG+KS700GxGxXD3Qwq6c7/WdOd497MA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u4bsnOCCtJwXHFwT3ZFXUm20wRE2QWIonOu+VgXEWhjMkmrPVTSuHcFMJ4gdAiSmi
 0gPzA1dfqsTG9ZSL661mMXvQyv8zSyR8Irl2jWFSpgVuXYk4ln0O8Y0SYPKbghaIk+
 VoCfDbmk/xz/MdH4Y9XUyFZaqJXy78Y6B2pGRXklwmbborFNSR85pigIJm7dOagTWG
 o/fJrSLVjNwjH3xoua5k3qRz5IULtETLywNARx14qKIrT1+a2uxceUVPSQ4Q5LbC+t
 I56O5x51bfcgRAeHhfPStxo0sXJwmZu4ee0In1KNGruJ5Rb3eb5DdORyzQP8pJHTuP
 Q0v89iw07pmhA==
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Albert Esteve <aesteve@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] drm/panel: Use refcounted allocation for
 remaining panel drivers
Date: Mon, 11 May 2026 09:16:24 +0200
Message-ID: <177848377975.134076.3948751574253318426.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
References: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 08 May 2026 09:04:40 +0200, Albert Esteve wrote:
> This series converts 9 remaining panel drivers from the deprecated
> devm_kzalloc() + drm_panel_init() pattern to the refcounted
> devm_drm_panel_alloc() API. This follows the work by Anusha Srivatsa
> who introduced the refcounted panel allocation infrastructure [1] and
> converted a first batch of drivers [2] (the last part of a 5 sub-series).
> 
> Reasoning:
> ----------
> The old allocation pattern is unsafe: when the panel device is
> unbound, devm frees the context struct immediately, but the DRM
> device may still hold a reference to the embedded drm_panel through
> the panel bridge, leading to a use-after-free. devm_drm_panel_alloc()
> wraps the allocation in a kref scheme, so the memory is only freed
> when the last reference is dropped.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime
