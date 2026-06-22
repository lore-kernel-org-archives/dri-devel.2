Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A34FCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B136A10E59E;
	Mon, 22 Jun 2026 09:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+ZGmbUf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FE910E5B2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:06:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C624E60051;
 Mon, 22 Jun 2026 09:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F441F000E9;
 Mon, 22 Jun 2026 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119189;
 bh=3OpnCcLp2SxK3baSJkRWODl6DG7SGkGWaZQW8EzUiKE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=P+ZGmbUfRl9r1UbU4bhESyUWD5MGiZwKJp//NvSFg50U5Errx42/TR7Ct4TwAH/q2
 Sq5npnmVAsXqadLTWJn5kw9BTrLH1jr6mDbznDPgagvz3WfxhMdGxfMBJw4YqdDKTO
 SnCh/6PugOknmaZMW0S388SH8ipCA48KvD0PRkdFT62xef9IggE6D9AepElWqj3pD0
 LNYoxlAUPBD9j3MlBfZw/QqCjRllqXan0WkFJNqNnN4Iyu1WHqeI1qaMuo4WMzU1sE
 LR3jsWoguHtS8POyH1CePWf5EmxBX7bCDhAH+q+UmlBqQxffYxoxYwRb0CAtSJOVUv
 +O1z8bhoqbw/Q==
Message-ID: <5a1934848d855881e769fc3263891f60@kernel.org>
Date: Mon, 22 Jun 2026 09:06:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v3 1/2] drm/display: hdmi: Only allow BPC values of 8,
 10, 12 and 16
In-Reply-To: <20260619-hdmi-max-bpc-fix-v3-1-ba83e5361eb0@collabora.com>
References: <20260619-hdmi-max-bpc-fix-v3-1-ba83e5361eb0@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Fri, 19 Jun 2026 16:37:31 +0200, Nicolas Frattaroli wrote:
> As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
> only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
> Allowing more than this has surprising consequences for the atomic check
> phase. The HDMI state helpers may accidentally conclude that a sink
> supports 11bpc if a caller asks for it.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
