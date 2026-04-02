Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D33D3942E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF0F10F2AF;
	Thu,  2 Apr 2026 14:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="gm8SVwu5";
	dkim-atps=neutral
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187D210F2B0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1775140127; x=1775399327;
 bh=61zlP1aorHbsMAHfSZBm3dDR0SYcYTVTWR5dLhiSR7Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=gm8SVwu5v9JMT85/BjOj8bg24O4S/6ijwXdJcduK0TvdrxF4BpPACbUjOFhPoghwa
 SyIHO4TnJVj/yfnBD+ImYFKMrciJ/W4vJJPm0aDAHJAmhHga6qYkJB8rXVIYCLlbKt
 IsXu7TvPiKFB05y6OOfc0OQqo6hjCERuf2Cj0t14SusruyWzXu3q3sFgpuA1CjC0UN
 D3rhg85Aho8OGW9KK9NJNK7ZYq6wjTLpKCBYjkTnfsOA74pSR7eYOotPT8qrQBvXhY
 iN0ymU8lSxqeSNuwr75FGkF5a+pXfDc6glvaPwcrgxY4/F8Nd7UTEsAuEiYB4hxrkv
 iWBq4HQJLIrRw==
Date: Thu, 02 Apr 2026 14:28:43 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH 6/6] arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU
 nodes
Message-ID: <R7Ih8jyIY_3BU4y0YERxTj8EaSkmFovmHoVqcbBcUfad9nn0UGonyc4othMA9YsIYlHtnkinSVCNdZgqFxa_B-2nTPDT3MlJud5LpE8jfWc=@pm.me>
In-Reply-To: <20260402-military-arrogant-woodpecker-4ab9b5@quoll>
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
 <20260402-military-arrogant-woodpecker-4ab9b5@quoll>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 8ca7a17b3f3180d3444524a81e6eb8372a481313
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

On Thursday, April 2nd, 2026 at 4:19 AM, Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> On Wed, Apr 01, 2026 at 02:17:44AM +0000, Alexander Koskovich wrote:
> > Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> > Qualcomm SM7635 (Milos) based devices.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  arch/arm64/boot/dts/qcom/milos.dtsi | 148 ++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 148 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/=
qcom/milos.dtsi
> > index 621f05820826..a8feb0339804 100644
> > --- a/arch/arm64/boot/dts/qcom/milos.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/milos.dtsi
> > @@ -7,6 +7,7 @@
> >  #include <dt-bindings/clock/qcom,milos-dispcc.h>
> >  #include <dt-bindings/clock/qcom,milos-gcc.h>
> >  #include <dt-bindings/clock/qcom,milos-gpucc.h>
> > +#include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
>=20
> Why? My next from 27th Match does not have Milos in that binding. Was it
> added? It's worth mentioning in commit msg.

They use the same driver and the GX_CLKCTL_GX_GDSC definition would be
identical, so the header can be reused. I'll mention it in the commit
msg for v2.

>=20
> Also, please keep alphabetical sort of the includes, k < m.

Fixed in v2.

>=20
> Best regards,
> Krzysztof
>=20
> 
