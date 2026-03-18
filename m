Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF72210854C9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 21:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189AC10E062;
	Wed, 18 Mar 2026 21:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Qp/7XfNq";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786BB10E062
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 21:52:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2AE9E4E426FA;
 Wed, 18 Mar 2026 21:52:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA5346004F;
 Wed, 18 Mar 2026 21:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F197010450599; Wed, 18 Mar 2026 22:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773870754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hWDGumjNeG1y9SM0/jlZ31MlASAIa2Shc7waG7yET5E=;
 b=Qp/7XfNqeiRlS2+FBFlAtJhAPg1H9lzngRLAmk7YMdnDETz5Ii0gzMXoDaPoiIm5JqXBz+
 SP+F1t8MBRVtuKOMECJJDob2CZbvKJN7ciyNAn0BRWjEQp9qLjTe/eUPrtWlPQoxpjaUPa
 /3FJgnvCwUSMiKo+z05es+JDYa+Up2B6Iqn0h2m4VuuGSeAAenVZtRFSMp3VFuB4RBVI7n
 EGXNktIavNFYIru59l1A7GHcROoZf+jC5AarvH8/56cbv7Kf46QGs11U3A2aQxzvSlQmbG
 W1SJ+yOmhDoyHj0e9x5uVtn2kWEXvedAjYDoEmUgA+r2YjRbKtgcQ239VNKQZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 22:52:26 +0100
Message-Id: <DH68P6XTTTTP.10WUEJQMP1OC9@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, "Douglas Anderson"
 <dianders@chromium.org>, "Andy Yan" <andy.yan@rock-chips.com>, "Sugar
 Zhang" <sugar.zhang@rock-chips.com>, "Heiko Stuebner" <heiko@sntech.de>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, "Christian
 Hewitt" <christianshewitt@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
 <DH56X74P9GC9.1O123S92J60RG@bootlin.com>
 <00EE3E21-F614-429B-ACB6-19AF64CF74B3@gmail.com>
 <DH58MAETGDMM.2QS6VJDQ7UXIV@bootlin.com>
 <0895dfa0-9527-41b1-b991-a2bd6e0c549b@collabora.com>
In-Reply-To: <0895dfa0-9527-41b1-b991-a2bd6e0c549b@collabora.com>
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

Hello Cristian,

On Wed Mar 18, 2026 at 7:12 PM CET, Cristian Ciocaltea wrote:
>> So now this patch is on drm-misc-fixes, but drm-misc-fixes and
>> drm-misc-next are now conflicting because of other changes by Cristian
>> Ciocaltea applied in the meanwhile to drm-misc-next, and particularly
>> commit 3ea699b56d31 ("drm/bridge: dw-hdmi-qp: Rework Audio InfoFrame
>> handler").
>>
>> Cristian, Christian (heh), Jonas, could you please check whether the cod=
e
>> on drm-misc-next has or not the bug that is fixed here? And if it still
>> has, send a fix based on current drm-misc-next?
>
> The conflicting commit in drm-misc-next (i.e. 3ea699b56d31) implicitly re=
solves
> this audio related issue as well, hence there is no need for any further =
action.

Good to know! Thanks for checking.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
