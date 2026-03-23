Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186ADF46139
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E96410E043;
	Mon, 23 Mar 2026 15:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="WHUlp5Ek";
	dkim-atps=neutral
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BDA10E135
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1774279750; x=1774538950;
 bh=ElJJRngS4oul6QvfUaEwS3ay9qvA+cCk2pKKulBFxDs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=WHUlp5EkQyNS+aIpB9qWTxKtaXqdErK1Gi+Y8Azlc4NqeNvC+ogSuKJ4QHvnb7Iun
 zDKws6ZAOzlKDHAsOXdLgfDM0TLePG+vJhxjf7LwPOtwItDGwOANvxXOYiHwdcXFum
 d3nMNlkvaqEuO+nhElAsGvwIN962uQgNfItHaXLB6EGmy9PcoqwG31SsnvDnoOJZHT
 ezW5/Wcnvo9PZ4OaSzpFVL6S9Jgz/W9eTdNcsjeQilUao2eS8HuPuuHmNK+b5Sd0El
 UbIlfCFLxlvdoKaic5CB178nZ+uebxxjQc+yutzHP+NVnWOzpPIJecRxesMkJy4D0k
 Lsw6xAJlkDaLw==
Date: Mon, 23 Mar 2026 15:28:59 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 5/5] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <nmC5g-yqiyxWusbu6f0dZ0s7W-bqYdVUT0fIX9h1MsvYrAE521869Ei9NAKzwxbz30rvdYJCVjEWexnaUrAx_63G2DtM2mVUZthU1VRUbrg=@pm.me>
In-Reply-To: <20260321-dsi-rgb101010-support-v4-5-eb28ecebbfe8@pm.me>
References: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
 <20260321-dsi-rgb101010-support-v4-5-eb28ecebbfe8@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 327602c420a395c5a4d2f5d47513c5fff064faf7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Saturday, March 21st, 2026 at 3:52 AM, Alexander Koskovich <akoskovich@p=
m.me> wrote:

> =20
> +=09if (dsi->format =3D=3D MIPI_DSI_FMT_RGB101010 &&
> +=09    !msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR_6G,
> +=09=09=09=09     MSM_DSI_6G_VER_MINOR_V2_1_0)) {
> +=09=09DRM_DEV_ERROR(&msm_host->pdev->dev,
> +=09=09=09      "RGB101010 not supported on this DSI controller\n");
> +=09=09return -EINVAL;
> +=09}
> +
>

Was tipped off to this bit downstream where if DSC is enabled and panel use=
s
RGB101010, it overrides back to RGB888:
https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-driver=
s/-/blob/DISPLAY.LA.4.0.r2-10000-lanai.0/msm/dsi/dsi_display.c?ref_type=3Dt=
ags#L7209

Only does this if widebus isn't also enabled though. Should we do this as w=
ell
upstream?

Thanks,
Alex
