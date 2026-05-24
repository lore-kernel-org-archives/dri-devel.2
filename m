Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D4CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 12:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CE510E15C;
	Sun, 24 May 2026 12:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EWvyNaMn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6942A10E15C
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 12:09:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CC06600AA;
 Sun, 24 May 2026 12:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7D81F000E9;
 Sun, 24 May 2026 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779624575;
 bh=x0pitH5PkhGEQgtkB/Mc6awN6Q5lzEr649KS/2bWQtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EWvyNaMnxKQfxBoEvQW0soT9eIVljDvikuHOkfNGrCSQs4GYJnSjZV8ObfDZh7pNI
 GedWm5w8JB+rdEnxu/1lib8xvE7k7ZmN4NRZ0dO8m/SBhC6t9xX8txS2/cnPia0YLU
 +OHd7/3HumRldSuduO4uWhGwUwNJ1PEn8hGFyvMGFUNC9jhAvHFS4KsOllyzEQ9Kk5
 U79PCWzZF2g2s41HR4SyaOb/8ZpN8AfHrdnoPxL+IWZKuNLekPmNH3BYu+Vt2YF3qH
 ahtG/kE97YrG+bGu31uCXusSKcHnmN1pDk42GQ8vApko+iZODpBYXL96a8kKyT0h8E
 cNMcSTQxCvi8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alessio Belle <alessio.belle@imgtec.com>
Subject: Re: [PATCH 6.12.y] drm/imagination: Synchronize interrupts before
 suspending the GPU
Date: Sun, 24 May 2026 08:09:28 -0400
Message-ID: <20260524-stable-item014-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
References: <20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com>
MIME-Version: 1.0
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

> commit 2d7f05cddf4c268cc36256a2476946041dbdd36d upstream.
>
> The runtime PM suspend callback doesn't know whether the IRQ handler is
> in progress on a different CPU core and doesn't wait for it to finish.
> [...]
> This version of the patch contains only the part of the upstream commit
> that applies to 6.12; the rest was a revert of code added in 6.16.

The diff itself is fine and the synchronize_irq() portion is exactly
what we want on 6.12.y. However, the backport drops several trailers
from the upstream commit that we'd like to preserve verbatim on
stable:

  - Reviewed-by: Matt Coster <matt.coster@imgtec.com>
  - Link: https://patch.msgid.link/... (the upstream Link: trailer)
  - Signed-off-by: Matthew Brost (the upstream maintainer SoB that
    landed the patch upstream)

The upstream Fixes: tag also lists two entries:

  Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware ...")
  Fixes: 96822d38ff57 ("drm/imagination: Implement Rogue safety event IRQs")

Your backport keeps only the first. I agree the second Fixes: refers
to code that doesn't exist on 6.12, but please keep it in the commit
message anyway so the trailers match upstream verbatim; stable
convention is to preserve the upstream trailer block unchanged.

Could you send a v2 with the upstream trailers (Reviewed-by, Link,
SoB, both Fixes:) restored?

-- 
Thanks,
Sasha
