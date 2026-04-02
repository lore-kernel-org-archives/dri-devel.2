Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84D6D6AB16
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268F610F6BB;
	Thu,  2 Apr 2026 22:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="Pzc7FSlG";
	dkim-atps=neutral
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E9F10F6BA;
 Thu,  2 Apr 2026 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1775168049; x=1775427249;
 bh=jCVxWp1Wa9DZrYLVZygaJiD6PPNzR/XYIA5bc1ilxoM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Pzc7FSlGncSn9+Dho8TL2mFejNm7yEwhSU4bclcihtXJ2Gx93GiFeFzBaSK14l873
 6KtRMy0nq3+1+Yjmo7JxqUYDkJ+8ioPozIP2Hev2evIW6GTtToDvL10iXrsF8bUPh7
 eRqHP00lcNvOmQryJy/rNNV57xa9iGFaeHL+QWSf5ecn/hIgzhrC7zZ8mpJ6NFy4wN
 YpRKLNCx8GU60GSG4Cok55wGjAys+fuUqtu7q52pznSO34jDea7xsFqe4s4cXWjbia
 ohSGhfFMlHdWBpLMU28p4SGGxueb2fJbcaK8AnyiPRVZ4Y4QDifU7GFJTvTeSHfDdv
 eWpRgKqi7/eVg==
Date: Thu, 02 Apr 2026 22:14:03 +0000
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
Subject: Re: [PATCH 5/6] drm/msm/adreno: add Adreno 810 GPU support
Message-ID: <hvcBm15eFRX0ZonD34zzneuD50ceOzKGo1pE8LkQrQL1qEb4t0pEA4ankxEViVr7lwghJeGOoYp2ub8Ti2idrIzMfBXHBqnXejwukigxz9s=@pm.me>
In-Reply-To: <6da36e75-effb-4e3e-a2f9-c0f3ebdbcc21@oss.qualcomm.com>
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-5-725801dbb12b@pm.me>
 <6da36e75-effb-4e3e-a2f9-c0f3ebdbcc21@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 3bbaf83d1f497f4183e13864bd345040f061a6ef
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

On Wednesday, April 1st, 2026 at 6:15 AM, Konrad Dybcio <konrad.dybcio@oss.=
qualcomm.com> wrote:

>=20
> I may be on an older tag or something, but:
>=20
> $ diff /tmp/downstream.txt /tmp/upstream.txt
> 24a25
> > { GEN7_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
> 27,28c28,29
> < { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
> < { GEN8_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
> ---
> > { GEN8_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
> > { GEN8_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
> 31,32c32
> < /* Disable write slow pointer in data phase queue */
> < { GEN8_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
> ---
> > { GEN8_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },
>=20
>=20
> > +};
> > +
> > +static const u32 a810_protect_regs[] =3D {
>=20
> $ diff /tmp/downstream.txt /tmp/upstream.txt
>=20
> < A6XX_PROTECT_NORDWR(0x0ae00, 0x0),
> < A6XX_PROTECT_NORDWR(0x0ae02, 0x4),
> ---
> > A6XX_PROTECT_NORDWR(0x0ae00, 0x6),
>=20
> -> the difference is that
>=20
> SP_DBG_ECO_CNTL and SP_ADDR_MODE_CNTL are not protected
>=20
> that might have been a part of the ^ difference

Going back for v2 and making sure this is 1:1 to GRAPHICS.LA.14.0.r5-03100-=
lanai.0, I
think I was going back and forth between my own downstream from the OEM,
GRAPHICS.LA.14.0.r5 and GRAPHICS.LA.15.0.r1.

GRAPHICS.LA.15.0.r1 has gen8_3_0 support, but I'm not sure if there are any
devices that actually ship with it on that branch. Seemed to be fairly out
of sync from LA.14.

>=20
> Also it may be that the better name for this table is a830_protect_regs[]

Can you elaborate on this? The only names I know this GPU by are "a810" and
"gen8_3_0".

>=20
>=20
> The other tables, I'm lost. Akhil, please take a look.
>=20
>=20
> Konrad

Thanks,
Alex
>=20
> 
