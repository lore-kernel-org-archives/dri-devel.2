Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B2FDEE49
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2525010F253;
	Thu, 23 Apr 2026 20:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="ULOazdOO";
	dkim-atps=neutral
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB3510F257
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776976054; x=1777235254;
 bh=jC3Jj+pe7e8TjZGPc3jpIn3auWo68Qc5RELwM6CC6mo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ULOazdOOWnHQZXmGMx2nGb1WGe6LJDbwJm3SCNhKpDAAWMeouv595xSL+RUdlnvbh
 vmmcUUxDU+Z+1PCrFdlOIB0/UPGAca1rSluiUU46rRnFt567Ferw+y7BAu4ykHTin/
 8p9KZ3mFSRRm3FABo8+OPQ5bXT8xeuRccC/j1UmA2jFx1yBYogUhw1yx2U/dvzt9OC
 W3XSa90ZEBPDWA3/+oOgOIu6RqzGkP6aRd1ctoDzVIgZ7mV0oNdOF4UIxGyfibl6II
 O7fkH79w+l3EGLycdB+aucIOv9CJ/lu/UUhdCKzNsEoPrn6EcoxW7GMaTL03zddcCP
 SNgxpkIXHs1Vw==
Date: Thu, 23 Apr 2026 20:27:27 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 6/7] drm/msm/adreno: add Adreno 810 GPU support
Message-ID: <RxsrYj7kE1fS38uw9Frlum-uhzNhpKl4jkrZhaTmBCLLg5ZXTIG-2qdD8HTAyeyHfGMxjV8BAtwwsJJx28J6XApr3P2cFFmNMux3uKTUKgo=@pm.me>
In-Reply-To: <eccce3f2-01a8-4454-87d2-3a599a15b34f@oss.qualcomm.com>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
 <eccce3f2-01a8-4454-87d2-3a599a15b34f@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: b068081630eee9f29900c9312ab14b1b0fe8d6de
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

On Wednesday, April 22nd, 2026 at 9:04 AM, Konrad Dybcio <konrad.dybcio@oss=
.qualcomm.com> wrote:

>=20
>=20
> On 16-Apr-26 13:05, Alexander Koskovich wrote:
> > Add catalog entry and register configuration for the Adreno 810
> > found in Qualcomm SM7635 (Milos) based devices.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 296 ++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
> >  2 files changed, 301 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/dr=
m/msm/adreno/a6xx_catalog.c
> > index 550ff3a9b82e..1190804632d6 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > @@ -1799,6 +1799,259 @@ static const struct adreno_reglist_pipe x285_dy=
n_pwrup_reglist_regs[] =3D {
> >  };
> >  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
> >
> > +static const struct adreno_reglist_pipe a810_nonctxt_regs[] =3D {
>=20
> To align with the latest kgsl which includes all the latest
> recommendations, remove:
>=20
> { REG_A8XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>=20
> { REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
> { REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x00000724, BIT(PIPE_NONE) },
>=20
> { REG_A8XX_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },
>=20
> { REG_A8XX_VSC_BIN_SIZE, 0x00010001, BIT(PIPE_NONE) },
>=20
> and add:
>=20
> (below RB_CCU_CNTL)
> { REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
>=20
> (swap in place)
> { REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
> { REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
>=20
> (below UCHE_CCHE_CACHE_WAYS)
> { REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
>=20
> (below RB_GC_GMEM_PROTECT)
> { REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },

Just wanted to clarify if this was a typo, since you also asked for RB_CCU_=
DBG_ECO_CNTL below RB_CCU_CNTL as well.

>=20
> (The order doesn't actually matter but it'll be easier to diff)
>=20
> Konrad
>=20

Thanks,
Alex
