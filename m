Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC962C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84D610EB5F;
	Tue,  1 Sep 2026 07:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="S46tbBRs";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BBE10EB5F
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 07:09:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E03E61A1851;
 Tue,  1 Sep 2026 07:09:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A96676053C;
 Tue,  1 Sep 2026 07:09:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A05911C78A73; 
 Tue,  1 Sep 2026 09:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788246559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=azbA4EriyIuSSgA9MK6fPCdkyDzmm+8sSS/z2y87Z5U=;
 b=S46tbBRspM5s0aKsHNokZfOfNb8cl+p0i1dapuhgbhX4RFRQMvUxoA/OAEfbFKnAZcy9Tw
 uMaannzJwpY0e2mWLI2p/xJZvIYWw3AumCHdFxIYH/hj9/1gtmOO0I0/FQTJ8T1uAUxJ4M
 1b84GsLHAKA0HJZUbC5mC6I5YxtIb5szVmtzIUHnhjy0O+X5yf/06Iz08gkClHtM0mAQMT
 g/q42mKkHayvwWJEa1m0GOAFR5Z+XApPMDPXglD81DMNBYcE+H81NQvIsQdUrCQbGxMRay
 0u2b73EcCt/VW/d35Wf4J1AHj7+JfSFQQGtiL645y4oPLA1cAJ7wlJ/qnXgdcg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 09:09:11 +0200
Message-Id: <DL3SHWGWGJRM.8EBXAKKNSVB5@bootlin.com>
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
Cc: "Sunyun Yang" <syyang@lontium.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <venkata.valluru@oss.qualcomm.com>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
To: "Mohit Dsor" <mohit.dsor@oss.qualcomm.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
 <178766696083.117435.16339828039068931624.b4-review@b4>
 <apXKES8WQzVDbQG8@hu-mdsor-hyd.qualcomm.com>
In-Reply-To: <apXKES8WQzVDbQG8@hu-mdsor-hyd.qualcomm.com>
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

Hello Mohit,

On Mon Aug 31, 2026 at 8:38 PM CEST, Mohit Dsor wrote:

[...]

>> > +#include <drm/drm_of.h>
>>
>> Unused include?
> Using this header for of_drm_get_bridge_by_endpoint

of_drm_get_bridge_by_endpoint() is declared in drm_bridge.h.

>> > +static enum drm_mode_status
>> > +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
>>                      ^^^^
>> Out of curiosity, what does "char" means here?
> "char" =3D character =E2=80=94 TMDS (Transition Minimized Differential Si=
gnaling) transmits data using 8b/10b encoding, where each
>   encoded 10-bit symbol is called a "character". The TMDS character rate =
is the number of these symbols transmitted per second
>   per lane, which equals the TMDS clock frequency.

Ah, OK, thanks for the explanation.

>> Also, I _think_ lt9611c_regulator_init() could just
>> devm_regulator_bulk_get_enable() to do both things at once, but I'm not
>> sure that would be compatible with PM. If it's safe it would simplify th=
e
>> code quite a lot, and also allow using devm_drm_bridge_add() below, maki=
ng
>> the remove function almost empty.
> regulator_bulk_disable/enable are called in suspend/resume and in remove =
=E2=80=94 so devm_regulator_bulk_get_enable is not suitable
>   here

OK, I was not sure about that, thanks for checking.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
