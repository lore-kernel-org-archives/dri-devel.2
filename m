Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04EF1091904
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E00610E18F;
	Thu, 19 Mar 2026 19:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="TKwe6vIc";
	dkim-atps=neutral
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B363C10E902
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773947039; x=1774206239;
 bh=Z7rz17oXwJA2+Xw+Tg0a6ScefxcvHHGVlmuQ1UcC2rY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TKwe6vIcpm0QAZdnu6XpX/mNxIfG2Nb3MlLrh0zym6eQaugGYQ0S74xqtpspCdn5h
 Ekwpb66+I5jIrZyL9lZ8Sb5nDHtuhscZpf86XJuNdUZDsKKSvNAAhfR8v4Wc0VeF0C
 lSPHswtiYE2ykUd0IXiLlfjVOeQerYqZoJeXBOqJefvL6l7AmZywwTQyrQB/eCGsSb
 5RnqJv03u4pIAaPbFJ9n8RsujS7QHyvaPiW24SbOKIAEUe7a0+xuUC98v07Xoj9hT2
 oDWpM8FpY1MBxLswC7QC2zLGgPELbzxy/Ig7cVBw3E58FJWrOKjxKj+CR7poQ+8LMB
 LdJiJnWsRcUtQ==
Date: Thu, 19 Mar 2026 19:03:52 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 3/4] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <ZFutyWx-D2vGcrFK6-0ybqW1lyufJy0qIr2g8QtwbUArTYq5Pus7dcqie5lJjYgFgyAmB_othdAem8nuN4kcJGF8dINyvDQz9BhUKkOo__A=@pm.me>
In-Reply-To: <gompbnsbhmfx3ze2nq2h47t5aohsm6oxuetaymjpn6kajmhu65@r4qnbfshwmgh>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-3-85b99df2d090@pm.me>
 <gompbnsbhmfx3ze2nq2h47t5aohsm6oxuetaymjpn6kajmhu65@r4qnbfshwmgh>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 585559cb4244f9036800069bc683aa8c6646446f
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

On Thursday, March 19th, 2026 at 3:00 PM, Dmitry Baryshkov <dmitry.baryshko=
v@oss.qualcomm.com> wrote:

> On Thu, Mar 19, 2026 at 11:57:56AM +0000, Alexander Koskovich wrote:
> > Add video and command mode destination format mappings for RGB101010,
> > and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> > the new format value.
> >
> > Make sure this is guarded behind MSM_DSI_6G_VER >=3D V2.1.0 as anything
> > older does not support this.
> >
> > Required for 10 bit panels such as the BOE BF068MWM-TD0.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c            | 10 ++++++++++
> >  drivers/gpu/drm/msm/registers/display/dsi.xml |  5 ++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> For the patch itself:
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>=20
> Note, you've dropped the patch adding RGB101010 to
> include/drm/drm_mipi_dsi.h without declaring a dependency on any
> external patchset, so this can't be merged.

Oops, guess I skipped over that while rebasing. Will address in v4.

>=20
> Also, there was a report from LKP that you need to fix the meson driver
> while adding new MIPI define (we should not be introducing known
> warnings to the kernel).

Will address that

>=20
> --
> With best wishes
> Dmitry
>=20
>=20

Thanks,
Alex
