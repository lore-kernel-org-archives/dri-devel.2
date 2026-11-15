Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28987606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hm5I51Hh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A1710E013;
	Sun, 15 Nov 2026 15:03:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C0C10E013
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:03:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 652C740175;
 Sun, 15 Nov 2026 15:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821021F000C4;
 Sun, 15 Nov 2026 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794755014;
 bh=cuIPeSmMQumt6Xz/JP9UG4bk+SAVXVlRFXLYgQ+8MVY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=hm5I51HhmteSNslariNAGq3luQb33RBBUVD8h6cTRV733B9WRFMMxIfAZh95Y34AP
 omVgGGvPDO+j2+glRsgfzVhl+HsD0unPwDT8n8qnQzc1oVLmucPm9lyLWBXH6UHkBg
 fTxZY0J8INyk4qujuHLbma3GE0cH/QnFvu1IOj+dwF1sact5wTZvlKpKV/J3Xf0YVq
 Od66PSwJRQaQLArlPZ8rHNvivVRmFQk6TfwgYYp/iDFJG9X23oPMOy9Z9PzrWMzzN+
 HYC5mmsdmxoJyyOzxgBG4iUrztSgUAGiRIy3f82glCCfYl6932ep8nT9d78z8HuWaF
 Ug/ashFhhiJ8Q==
From: Chen-Yu Tsai <wens@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261104185659.884455-1-jernej.skrabec@gmail.com>
References: <20261104185659.884455-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: Deinit PHY in bind error path
Message-Id: <179475501230.3244977.13845276937669658695.b4-ty@kernel.org>
Date: Sun, 15 Nov 2026 23:03:32 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 19:56:59 +0100, Jernej Skrabec wrote:
> sun8i_hdmi_phy_init() enables the PHY clocks and deasserts the PHY
> reset. When dw_hdmi_bind() fails afterwards, the error path doesn't
> undo that, so the clocks stay enabled and every further bind attempt
> enables them once more.
> 
> Call sun8i_hdmi_phy_deinit() in the error path, like unbind does.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: dw-hdmi: Deinit PHY in bind error path
      commit: 39e407b553ec15d4a233b651531ad431ed7542be

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

