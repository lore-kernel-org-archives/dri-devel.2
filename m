Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABAC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690210F4C2;
	Thu,  3 Sep 2026 09:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HKXXOgT4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBF210F4BE
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 992C960210;
 Thu,  3 Sep 2026 09:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57A31F000E9;
 Thu,  3 Sep 2026 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788429570;
 bh=zDDT5GYlePp6IqrienfrrMdSEG8D67aF7CYFG73UC4w=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=HKXXOgT4iftBhW+jg+mtHmFJ68ugzIw37dhmWtXpvJbH+89XrDveLtY9HSosClYDu
 z2R/L/WFRKNRXEAbXHnWjFc2TO/mOz5D4UlKJPA2nT815YUmyC1Rpiv9KtDtS2EEWN
 zvlb7mD1+FFeBA3unPBMGIkVTWOfqYReTaQZQknLe7f/JWpXFahFac6hGQ7MVq/J00
 jciw7EuuyuWQoc9+awAZYf8xRrcgLof2Zn0f1XhmcWc0s3UosY64F5Cb671V5gNmQt
 7DXIMuRi7+2jc2SZkgx0ruqXKzWsIToYazLTg5Cjrc9XtgyWqJYpUPDrC+zNS+I6xf
 mjlJhrrTyhfTg==
Message-ID: <2e9de8370abf3bff7efc80dcf09d56c6@kernel.org>
Date: Thu, 03 Sep 2026 09:59:27 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RFC v2 03/19] drm/panel: move to a new module
In-Reply-To: <20260903-drm-bridge-every-panel-v2-3-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-3-2ab8ee24538e@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Albert
 Esteve" <aesteve@redhat.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Anusha
 Srivatsa" <asrivats@redhat.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian
 Ray" <ian.ray@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Linus Walleij" <linusw@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
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

On Thu, 3 Sep 2026 10:11:06 +0200, Luca Ceresoli wrote:
> Work is in progress for every drm_panel to embed a drm_bridge, which will
> make the drm_panel code (currently in the drm module) depend on the
> drm_kms_helper module.
>=20
> To avoid the main drm module to depend on other drm modules and create a
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
