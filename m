Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D8210706DB
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 13:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D69B10E496;
	Sat, 14 Mar 2026 13:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qk+zD2me";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0105810E496
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 13:13:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD2FC4448C;
 Sat, 14 Mar 2026 13:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E5C2BC87;
 Sat, 14 Mar 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773494026;
 bh=Ul/KZYYBluOLIebJRnv6IBl+OG4kts3XALkWxCRzAKE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qk+zD2me4/vx2bICl9IpydeNQ0LIJ1zMUTjn2rj7ZAPF2RGXRutSE4S0Q3k+JiK+i
 V0H82+25jHFPDqReKLww8ej0jL3bHlfSeFK42JYzWlNC+Cv1mzl0HAo62QVcRqzaZU
 MCBWcfcOjtWxubJWss0QmqkribB7W3MlFsoJKoGNBKs/qXuyvcXSaWLOX6o4tqW8DQ
 QVsOZvMpz9F9VdSiP07Ru3EFm913dgH/WdPKaelH4DUPro4cVTH6+MERO+pxE1SRk4
 9hnv/8pLdUaL2k/MOVAZIu4zSZCsx/jwnP6B+a1bJtYC3iJJxvadCBE2V2zKdMytSo
 /s39D9mOsalZA==
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260309165635.1138413-1-wens@kernel.org>
References: <20260309165635.1138413-1-wens@kernel.org>
Subject: Re: [PATCH] drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
 get display memory
Message-Id: <177349402468.44870.8589906861344926590.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:13:44 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 10 Mar 2026 00:56:33 +0800, Chen-Yu Tsai wrote:
> Commit 4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
> adds a new helper, which covers fetching a drm_framebuffer's GEM object
> and calculating the buffer address for a given plane.
> 
> This patch uses this helper to replace our own open coded version of the
> same function.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory
      commit: 79ac1c945ab885369a840da014ebc6fcde8e2ae2

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

