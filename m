Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26108CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8656C10E2A8;
	Thu, 21 May 2026 09:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="R0D0zqrj";
	dkim-atps=neutral
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E294E10E107;
 Thu, 21 May 2026 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1779354226; x=1779613426;
 bh=XUOs5gzGAQsfeLUsJnVftHR4Vb5FftuYeGY6rn8jz0E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=R0D0zqrjGCyWsuQ6b9mypJwIzOF8Y0katgLZRMiayBuusZ0iwdIgcEklFemG/r6tn
 DwOpvWS+xBHsTAGXriTQVw16UnvuKxUo1fTLEQdePQaG7F1SBf79LAGCU/tVVxXVtF
 bi8B/KrAPytg3vhJ6siZDTKxsQXs+OGtQV0B+F+WLOhMy8ZVvICSJfv9X+kmL8LjIe
 hGWL6dK7LQKOXbGlMIB6Or+W/pONfjNt8mlruAF1mqxe3vFozCaMJooPFUBPuDnNs3
 2ORvA1FpgkABj0dYfpHo8mc173r7mCmgk9GtFhsyAQDUq8CWFG21zZB7OEe4sy1HfM
 Ok79cjNyWE0zg==
Date: Thu, 21 May 2026 09:03:40 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <B1J_l5TEAq5VkrzIONy8jR64syCY4emf6nfv6_oisI08IblhzeBv7meOvwVNFxknOEtVAA9QZKkG1eUtMlsCU4vJeYit4gAWYI2J5p-U6tc=@pm.me>
In-Reply-To: <efede04f-b2e2-4fba-8247-f92eafa2b381@linaro.org>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v1-2-1bd66b7f9e0c@pm.me>
 <w74ctaczp3ty7wil2sfkztc6wvuppgpyff4tw4dze34irvfmlx@e5f36rzqmp6i>
 <efede04f-b2e2-4fba-8247-f92eafa2b381@linaro.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: fb4b6bed8fc43b6f3108e2d4f609f11792d1cd57
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

On Thursday, May 21st, 2026 at 3:50 AM, Neil Armstrong <neil.armstrong@lina=
ro.org> wrote:

> On 3/18/26 10:39, Dmitry Baryshkov wrote:
> > On Wed, Mar 18, 2026 at 07:33:03AM +0000, Alexander Koskovich wrote:
> >> Some panels support multiple slice to be sent in a single DSC packet a=
nd
> >> this feature is a must for specific panels, such as the JDI LPM026M648=
C.
> >>
> >> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_p=
kt
> >> from slice_count, note that most panels are expected to just work with
> >> just one slice per packet.
> >>
> >> This change was originally authored by Jonathan Marek:
> >> https://lore.kernel.org/all/20231114174218.19765-3-jonathan@marek.ca
> >
> > This is a wrong way to give attribution. Either please retain the autho=
r
> > and Jonathan's SoB or use Co-developed-by and still Jonathan's SoB.
>=20
> Please retain `Signed-off-by: Jonathan Marek <jonathan@marek.ca>` since t=
he only
> major difference with the original patch is moving the drm_mipi_dsi.h cha=
nge to
> another patch.

Yeah, made sure to add his Signed-off-by to v2:
https://lore.kernel.org/linux-arm-msm/20260318-dsi-dsc-slice-per-pkt-v2-2-0=
a1b316f8250@pm.me

>=20
> >
> > The patch looks good to me.
> >
> >>
> >> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> >> ---
> >>   drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
> >>   1 file changed, 10 insertions(+), 15 deletions(-)
> >>
> >
>=20
>=20
> 
