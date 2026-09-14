Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD9C88E66
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA76D10ED30;
	Mon, 14 Sep 2026 12:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LtaFrVrO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE4510ED30
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:23:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BB4243BE8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D71F00903
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789388608;
 bh=xh/h1a9+AEVQdtdCPX52wjftYDfYPBwVyd1n4MqElrM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=LtaFrVrO54HzwOWHQ17zfSEzdcFKSXWoJ4iRtY0paqCoukyW+5i5ZqYDkoNpPY3eC
 pdJYhbhNfh+Pfc46+kS3xYA0+eNCBZrBUhXkb6pwWbaJr7FhWBiFwtr3crMhNZGTia
 qVOISC8inXdosWzHjRPkelpXgQg4GsA8Xc3cZg4ibmpptb5u411C9auHF77A0nmjLz
 DuijKv3b+pv2I7OnCfYFleRxaHKO08LF4GlLos5pXpTS1UG3Sn8sDNANCEUTBNR01Y
 iYgEqCd9OfUzeoOkrkFcCFIsdB7D+/3Zj49xKLxlpGBpSURdiNezOljOp/Q+3NPMpr
 ydOCveyRoJezw==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f12so2130093e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:23:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzwmceCwDjfUQzHkMHO7FV/WXw9ltk210w1zuiStzT4ipBod+oqCM2xT2zo0HDWVyW7QbkheHnZjPU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k2eA0CFHZE5g8ZY6vmUY9ju0D18UOKesQ2L7uo0NC+LyDp3Oa2
 ZDxtA2//aXoVsBGcH0LUAARjgMJ/0K3b6dQwLKEYtH2gRoKHZHdz1FGvv1fbQmOi+7s5ydg0WRe
 5z6KMJns9fDEPEVpx9IpQEHaixYXgKAo=
X-Received: by 2002:a05:6512:2256:b0:5b6:422:a61b with SMTP id
 2adb3069b0e04-5b8ae6b919cmr1225861e87.27.1789388606808; Mon, 14 Sep 2026
 05:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-10-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-10-2ab8ee24538e@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 14:23:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQ_APuJwxv1f572YNHURG2ZRBNLP2Lob1vtb5uQNOWUg@mail.gmail.com>
X-Gm-Features: AcwNN1UmOzAhpMF6R-BINpe4Y2w_L9NY2N3wgg-AOAvIXgsgHbEmBWIvTK04h4E
Message-ID: <CAD++jLkQ_APuJwxv1f572YNHURG2ZRBNLP2Lob1vtb5uQNOWUg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/19] drm/mcde: dsi: don't create a panel_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Sep 3, 2026 at 10:12=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> Now a panel_bridge is automatically created for every drm_panel, so this
> code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
> would lead to creating a second bridge for the same panel.
>
> Update and simplify the code by just getting a reference to the
> already-existing bridge.
>
> Also keep the "connected to non-panel bridge (unsupported)\n" error logic
> by using the drm_bridge_is_panel() function.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Okay then!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
