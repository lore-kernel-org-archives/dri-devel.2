Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48597FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDE110E37D;
	Wed, 29 Apr 2026 11:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lv4Kz1Zb";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3401510EF91
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:29:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2B646C5EF22;
 Wed, 29 Apr 2026 11:30:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0CC43601DF;
 Wed, 29 Apr 2026 11:29:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB12F10729BF1; 
 Wed, 29 Apr 2026 13:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777462174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2Zv48fATMycZuKANXcifZ0d/83RwSxZhoqE9aoobzl0=;
 b=Lv4Kz1ZbnKY5PB9QFKgwfNTPnnzsAV6QU4gciByC2XIv32iy3RDpzUfBG0lRxt5Dzooa6B
 fjoL0ur55+5x5M4GTjazMscBdM8BCsEwdKFyO+g4pgdREF6O4UMsd/DmO8xYHsKfulypYy
 NeVolEU5kJNgq5XMK5ZVGx2vgKkuJWggMCjywXNGY5eu0K+nsthBw8jALMNbHGynXuTHcg
 Hd5pusvh5r+Tpuh2ObFnNHssGJFTeenypxie2hEmnllBUvn88spV/okeAVy8N9dxy9dEuL
 j6QhAwMsghcviuxmiqOBL++b8Jgmw/BSNYVQQnPHVp2EAGAbHgSNwfPkTF+IKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:29:24 +0200
Message-Id: <DI5LR1VCMTKO.1S3KLBK8F0XIA@bootlin.com>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Extract error pointer from
 correct variable
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Marek Szyprowski" <m.szyprowski@samsung.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Damon Ding" <damon.ding@rock-chips.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260429030840.704252-1-ethantidmore06@gmail.com>
In-Reply-To: <20260429030840.704252-1-ethantidmore06@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed Apr 29, 2026 at 5:08 AM CEST, Ethan Tidmore wrote:
> In devm_drm_panel_bridge_add() error path the pointer error should be
> extracted from dp->plat_data->next_bridge but instead it is extracted
> from bridge, which is a valid pointer and not part of this error path.
>
> Extract error pointer from correct variable.
>
> Detected by Smatch:
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1489 analogix_dp_bind(=
)
> warn: passing a valid pointer to 'PTR_ERR'
>
> Fixes: 1b86a69b61df4 ("drm/bridge: analogix_dp: Apply panel_bridge helper=
")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
