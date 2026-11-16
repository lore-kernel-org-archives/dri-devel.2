Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04820606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=a7qhV5xg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287E110E9E2;
	Mon, 16 Nov 2026 11:42:19 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3FE10E9E2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794829331;
 bh=rtRemMSx3UtzeqG96wyxcLAlrvIK8a5x0EolpxH9CkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a7qhV5xgNj76z0QH2oTygaP02beUsCdh9SYyE8q9xMzxBGZn5z8R4UJHU679GnyMO
 XhJwrZHhmuiHf2SspnlLiWQzY5WXZBZEOCsjuKBXjfsT8yFXfX9nIXI55W4r5ATxx3
 OxgjE4xa/9O4a5+cZDZuVWdP+almClyKhOgZGCge0YbrhG0dKlSxUzerR7YockCC0a
 GmURl9d/TjuvYhNe2KtBFpdu/LuTzZurugUgAUt7LKEs07Mox/zgEaIAgkb6h7BJu1
 zeIZOhuSIpCTqAwAuqut90ZsOJxbMCiwrBocJX/QTGh2qWnUo/vWZurHrnkn93hDe2
 G6uPU8qbhVUkA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D9FEC17E0036;
 Mon, 16 Nov 2026 12:42:10 +0100 (CET)
Date: Mon, 16 Nov 2026 13:42:10 +0200
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Message-ID: <179482905239.1644942.18191359932991723848.b4-ty@b4>
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 19 May 2026 14:00:11 -0400, Detlev Casanova wrote:
> -EOPNOTSUPP is not logged as an error by the ASoC subsystem, but -ENODEV
> is.
> It also better represents the situation: The operation is currently not
> supported (because clocks are not enabled and tmds_char_rate is
> unavailable), but the hardware is present.
>
> Using -EOPNOTSUPP in the audio_prepare callback removes possible repeated
> warning log lines when HDMI is not connected.
>
> [...]

Applied, thanks!

[1/1] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio functions
      commit: 247695b19afcea036873882ebe5db94a4e80e867

Best regards,
--
Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
