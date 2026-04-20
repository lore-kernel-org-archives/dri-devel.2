Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50EFF588E1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B63010E67E;
	Mon, 20 Apr 2026 14:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lvY87at9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18DD10E67E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:33:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B74D1444DD;
 Mon, 20 Apr 2026 14:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647AAC2BCB4;
 Mon, 20 Apr 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776695625;
 bh=P28JjJyeQsLcizRVuelUNaPqYIj5AsoRGrZR1HPwgmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lvY87at9iO7B7ik5tLUNmUlPeerAWH+F7UhIHsjnoqJWnlTg5mkGtPu+IBLq32Mtd
 DRY3YdzoH0ZhiT3wtG9shcI1zHKSSRLlVRcU4yLweYrdfC+NLDZIxjHoGVq0m2ha10
 SLRFcdhbbel3OPHDn0KyTktjXra95nYAUSFriWFXgHC8B/mBk7oES4d+wSpHm+Si4c
 YY6gr0oBWsCUtX+GWD2rMiHbcXMNTk69zrXefiakBYCgDCGbJjfsf90GP2z3vTzMm2
 wXZ4w+DkGzrC0luBd0wcU6EAQuthr8syEMxWZSNliXi22Z45g0T8QoikrxbWLqnKgj
 uyhHfjO7XC/ag==
Date: Mon, 20 Apr 2026 09:33:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH v1 1/1 RESEND] dt-bindings: display: bridge: ssd2825:
 inherit dsi-controller properties
Message-ID: <177669562148.2456487.17336642131288149446.robh@kernel.org>
References: <20260417064657.20293-1-clamor95@gmail.com>
 <20260417064657.20293-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417064657.20293-2-clamor95@gmail.com>
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


On Fri, 17 Apr 2026 09:46:57 +0300, Svyatoslav Ryhel wrote:
> SSD2825 being RGB-DSI bridge should inherit dsi-controller properties same
> way other DSI controllers and DSI bridges do.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/display/bridge/solomon,ssd2825.yaml    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!

