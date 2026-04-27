Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFAFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D802210E699;
	Mon, 27 Apr 2026 10:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="LpStolxq";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2B410E699
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=nAD4AusdeD9FfyVrCO0ouM2Cws+0AVlS+08lI2nfBkk=; b=LpStolxq3jg9WYGz1YvWNjkrZS
 ZtAgRFX6liopLoxVtop0BNDB83nNU/t9EOHFPQjli8n6VJ4wWknAghmz15S04zgBtVPbB+4AfXtk3
 6+qOtl0kLOKuZe7LUGOX+4ZppyCD41kXl0NffVwETiQyUw674QprUKvCt8yn+xS52JFGsBTVyWmq1
 4OBJt/Zu+B0XYrIqq3Ryd9/HhtVUOJdgNEpVEaPQbdg7HRcNtDK0ZCVJJFkr09tIv4AsuOJvfwKJD
 s1K1ttn8Le6RQuDuGrC8i2sgOy2se6xaNdmiE2dPW2wo840jwi1jv7UgQVcGZ1dLaWyqS6QNnVZy3
 bdy8wmSw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 06/10] drm/bridge: dw-hdmi-qp: Rate limit i2c read error
 messages
Date: Mon, 27 Apr 2026 12:41:04 +0200
Message-ID: <5203832.44csPzL39Z@phil>
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-6-d778e70c317b@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-6-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Sonntag, 26. April 2026, 02:20:18 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Cristian Ciocaltea:
> During EDID reads, repeated i2c errors can flood the kernel log:
>=20
> [   25.361716] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
> [   25.363376] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
> ...
> [   25.368671] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
> [   25.369440] dwhdmiqp-rockchip fde80000.hdmi: failed to get edid
>=20
> Switch to dev_err_ratelimited() in dw_hdmi_qp_i2c_read() to reduce log
> spam while still reporting the condition.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


