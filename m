Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEF5D6AAF0
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A5810E3DA;
	Thu,  2 Apr 2026 16:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="ZjGc7gPJ";
	dkim-atps=neutral
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C240810E3D0;
 Thu,  2 Apr 2026 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1775147777; x=1775406977;
 bh=7A5KjAmYV7XjxwFzAz+Gu1zpdCKkT5ACIwBJxXrfzmU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZjGc7gPJQwjhROunTaMcWSkai0CpMs053PXGNoKZLTeOykC5fYp/CPEQOcicDzK09
 bcqIszQTneJiFQHdaVtJaJ00VpOSxTwV/hSewDU5d60ohbSsOA4RCWWvVSAP/litwm
 C+obpeBdVrL8oPoS2hMabZrAG6gq5ky+J2ABuN0FN7jUiQdfXRpSVQA/TMeFfbm/d6
 +E6sqITdoXkEcz3c4E+5vP+kgnCIBKHCTg7Es8czklUvX29OYfDLwpTVEwEVayYwh0
 mVaqp6hk/h5pQlxW5n36MaZ1VcfvO2jyrSrsQqlOoXCX9YiOf/5y+H+kG0VlIH9xKu
 ljCUJqgSXiM/g==
Date: Thu, 02 Apr 2026 16:36:10 +0000
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
Message-ID: <_oKtywl2hPElduEp5xQuU-pvfR8_24TNztuXf3Il3DaaddUmg04Z27u2uYnUtox8G44_zuniSoDZTSJMMW44-HNTXLFJkKCjslAeEe96u9Y=@pm.me>
In-Reply-To: <182d58c1-21fb-4cab-8ce7-26f07d63d246@kernel.org>
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
 <20260402-military-arrogant-woodpecker-4ab9b5@quoll>
 <182d58c1-21fb-4cab-8ce7-26f07d63d246@kernel.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 64f2696b295c5bd3bf39079b8ba9b6a975e446ee
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

On Thursday, April 2nd, 2026 at 4:22 AM, Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> On 02/04/2026 10:19, Krzysztof Kozlowski wrote:
> > On Wed, Apr 01, 2026 at 02:17:44AM +0000, Alexander Koskovich wrote:
> >> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> >> Qualcomm SM7635 (Milos) based devices.
> >>
> >> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> >> ---
> >>  arch/arm64/boot/dts/qcom/milos.dtsi | 148 +++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 148 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts=
/qcom/milos.dtsi
> >> index 621f05820826..a8feb0339804 100644
> >> --- a/arch/arm64/boot/dts/qcom/milos.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/milos.dtsi
> >> @@ -7,6 +7,7 @@
> >>  #include <dt-bindings/clock/qcom,milos-dispcc.h>
> >>  #include <dt-bindings/clock/qcom,milos-gcc.h>
> >>  #include <dt-bindings/clock/qcom,milos-gpucc.h>
> >> +#include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>
> >
> > Why? My next from 27th Match does not have Milos in that binding. Was i=
t
> > added? It's worth mentioning in commit msg.
> >
>=20
> Now I checked in the cover letter - that patch was rejected. You cannot
> depend on rejected patch and still claim that this patchset is ready for
> merging. This patchset should be somehow marked that it depends on stuff
> which is wrong, usually I recommend marking it as RFC with explanation
> in cover letter WHY this is RFC (because it cannot be merged).

I don't see where the gxclkctl milos patch was rejected, there were some mi=
nor
comments that need to be addressed in a v2 though, is that what you mean by=
 it
being rejected?

Will just mark v2 of this series as RFC.

>=20
> Best regards,
> Krzysztof
>=20

Thanks,
Alex
