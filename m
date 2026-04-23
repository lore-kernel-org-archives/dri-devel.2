Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31E4FDEE49
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D44110F265;
	Thu, 23 Apr 2026 20:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="gNcE76g7";
	dkim-atps=neutral
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60EC10F257;
 Thu, 23 Apr 2026 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776976463; x=1777235663;
 bh=G/daCJIfnhGdXQISec5Nc7m2347M1zLsULfaxHx3oG8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gNcE76g7YofdTje7Aer6qNs/kz0XY0pThZiRLQj9QDZU3DpUB8Imy/yX1WAWrCc/l
 i31sGjdYaMYJdaqad7az7w7NApoOyuP32NSP5JmgvxDBhwgxoe4yJvoh4rdtUJ2R1q
 vsuNxEM4/OOK3nm3ZxSmN/9H0maRocDqFM+s9JN21oGBIITlDk7HX+CXsWzusCpo7e
 TtSo8ov1acLag2y+OtRfPNUQ5H4fmZ1wlbJ+Jbblibhz4PS3Jkchyy4iXxWZshCeHT
 3vn5wscno1YvVAcpjV7h9YYG8QpM06TfIYlRbW2mk3GdKQea8BqBtPn7VmhyC3+hho
 8YyzH9E3hBqoQ==
Date: Thu, 23 Apr 2026 20:34:17 +0000
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
Message-ID: <oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me>
In-Reply-To: <23fbb36e-56b4-4ecf-94e9-4038c6311b31@oss.qualcomm.com>
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
 <23fbb36e-56b4-4ecf-94e9-4038c6311b31@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 65a8b8efc4ce8f33e838f483cd77361e1348e288
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

> On 4/16/26 1:05 PM, Alexander Koskovich wrote:
> > Add catalog entry and register configuration for the Adreno 810
> > found in Qualcomm SM7635 (Milos) based devices.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
>=20
> [...]
>=20
> > +static const uint32_t a810_pwrup_reglist_regs[] =3D {
> > +=09REG_A6XX_UCHE_MODE_CNTL,
> > +=09REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
> > +=09REG_A8XX_UCHE_GBIF_GX_CONFIG,
> > +=09REG_A8XX_UCHE_CACHE_WAYS,
> > +=09REG_A8XX_UCHE_CCHE_MODE_CNTL,
> > +=09REG_A8XX_UCHE_CCHE_CACHE_WAYS,
> > +=09REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN,
> > +=09REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN + 1,
> > +=09REG_A8XX_UCHE_CCHE_TRAP_BASE,
> > +=09REG_A8XX_UCHE_CCHE_TRAP_BASE + 1,
> > +=09REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE,
> > +=09REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE + 1,
> > +=09REG_A8XX_UCHE_WRITE_THRU_BASE,
> > +=09REG_A8XX_UCHE_WRITE_THRU_BASE + 1,
> > +=09REG_A8XX_UCHE_TRAP_BASE,
> > +=09REG_A8XX_UCHE_TRAP_BASE + 1,
> > +=09REG_A8XX_UCHE_CLIENT_PF,
> > +=09REG_A8XX_VSC_BIN_SIZE,
>=20
> This REG_A8XX_VSC_BIN_SIZE is removed from all lists for all chips
> in newer kgsl
>=20
> > +=09REG_A8XX_RB_CMP_NC_MODE_CNTL,
> > +=09REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
> > +=09REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
> > +=09REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN + 1,
> > +=09REG_A7XX_SP_READ_SEL,
>=20
> Somewhat similarly,
>=20
> TPL1_NC_MODE_CNTL
> TPL1_DBG_ECO_CNTL
> TPL1_DBG_ECO_CNTL1
>=20
> should be preempt+ifpc for all targets, it seems
>=20
> [...]
>=20
> > +static const u32 a810_ifpc_reglist_regs[] =3D {
> > +=09REG_A8XX_RBBM_NC_MODE_CNTL,
> > +=09REG_A8XX_RBBM_PERFCTR_CNTL,
>=20
> This list matches the expectations, modulo this RBBM_PERFCTR_CNTL

Note on this, added this shortly before submitting this series as requested=
 by Akhil:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40613#note_339530=
8

Though, I've seen some perfctr stuff on list so not sure if this should be
removed soon...

> and the registers I mentioned above that should be moved to the
> first list
>=20
> [...]
> > +static const struct adreno_reglist_pipe a810_dyn_pwrup_reglist_regs[] =
=3D {
> > +=09{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
> > +=09{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
> > +=09{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) =
},
> > +=09{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> > +=09{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> > +=09{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
>=20
> + RB_CCU_DBG_ECO_CNTL to BR
>=20
> [...]
>=20
> > +=09=09.speedbins =3D ADRENO_SPEEDBINS(
> > +=09=09=09{ 0,   0 },
> > +=09=09=09{ 242, 1 },
> > +=09=09=09{ 221, 2 },
> > +=09=09),
>=20
> The DTs I have all point to SMEM-based SKU checks. Did you find these
> numbers empirically?

Yes, and I used speedbin instead as upstream doesn't support the SKU checks
downstream does. Utilizing GPU_CC_FREQ_LIMIT_VAL to serve as speedbin
on this platform.

>=20
> Konrad
> 
