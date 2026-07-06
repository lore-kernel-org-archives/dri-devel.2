Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5AFC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EB610E78B;
	Mon,  6 Jul 2026 16:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fEJAH5pk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092C010E78B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 16:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 854C9412DE;
 Mon,  6 Jul 2026 16:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA7D1F000E9;
 Mon,  6 Jul 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783356648;
 bh=lB8AmE01x3pOGC49SN5Hh0rNVmozdHeSscMj7Yjuhf8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=fEJAH5pkQVrtrZmjpQE2/wRtQhEMgTf7Try6BxbnZobHx3bGmnXsGFOuqzlbpjfZP
 25s10dXoVM3O6DHDX1cOl2CdKlJZ03SWMxxDcEfTRANMgGFwSbTZP1sxwjRovYdH5+
 fd9/0JKD8okhGm8mSUiNGFrCaInZTVqa1IFajI42fblPvzHxq0l+mxmdjTwTIALeYo
 6s0gqdPfEb7BP2kqjUZpZgt2M156iLmNIAUwtb09HYZe+arLHzLxvbdOhMnrGAI0P2
 BR0RXTjP8ryIkr3+jaMmldXbJhkpjPn1nlRpegKpUuzUoLwIayUPihfZloDAFqHRBh
 BXH8bpEHqsayg==
From: Chen-Yu Tsai <wens@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Diogo Silva <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
Message-Id: <178335664599.3964854.35900641652179943.b4-ty@kernel.org>
Date: Tue, 07 Jul 2026 00:50:45 +0800
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

On Tue, 23 Jun 2026 22:34:40 +0200, Diogo Silva wrote:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the dependency on drm simple helpers from sun4i
> DRM drivers.
> 
> 

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: Remove dependency on DRM simple helpers
      commit: 34d85c43b6cb3abec03d6f9d8128fb28a7e2bfdf

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

