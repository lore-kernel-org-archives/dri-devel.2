Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811ED1061B01
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C296E10E7B5;
	Mon, 30 Mar 2026 14:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O7cMcjwe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A85310E7B6;
 Mon, 30 Mar 2026 14:28:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 660C8600AE;
 Mon, 30 Mar 2026 14:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA1C4CEF7;
 Mon, 30 Mar 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774880926;
 bh=OoPe8AbkdWCfK+Bx27MFyVex52ff4rXkE2+CiqmLJxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O7cMcjweWItBG0J6SJKa9mc/r180E1Am1NLMtsywGPX9btnU1BI/+27tGNPrm4hzZ
 lC1m3oNFs8IYaL1OP0GjP/t5HKMvCEs4ZreLTTipC5Y1ncnzo743uasRJVDgW+Vkb2
 Yy63n8cR+iXT/Jo06u9K4FGmRktSiHQ9JrmPbz7MWBD9CeMFTwMtS1KMMtLt8R/yXL
 MR20oqGh8asm7DkO4clBY0xHThVMbeD6AZFFgVBj1Ga+YcB4CFZXHL0HadzEOzlx+D
 j1nkodPY2C+EKgDwL30i5CQXLp7c1jtTwxVD+iApBCgrSLfaGSszPxsseR29sPG/U4
 mWp2ILgmY+h7g==
Date: Mon, 30 Mar 2026 09:28:40 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, 
 abhinav.kumar@linux.dev, sean@poorly.run, marijn.suijten@somainline.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 quic_mahap@quicinc.com, konradybcio@kernel.org, mani@kernel.org, 
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 vkoul@kernel.org, kishon@kernel.org, 
 cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 quic_vproddut@quicinc.com
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: qcom-edp: Add reference clock
 for sa8775p eDP PHY
Message-ID: <acqGFwaVFQ3ZNmlR@baldur>
References: <20260128114853.2543416-1-quic_riteshk@quicinc.com>
 <20260128114853.2543416-2-quic_riteshk@quicinc.com>
 <gurq34svc5p52bqx5qwkgjmschzcbklmssjzmu2tg5wzgppkft@c6nrw2ageyp2>
 <c77ff64f-57d1-4495-bfbd-986644aad71d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77ff64f-57d1-4495-bfbd-986644aad71d@quicinc.com>
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

On Wed, Mar 11, 2026 at 06:37:31PM +0530, Ritesh Kumar wrote:
> 
> On 3/5/2026 12:27 AM, Bjorn Andersson wrote:
> > On Wed, Jan 28, 2026 at 05:18:49PM +0530, Ritesh Kumar wrote:
> > > The initial sa8775p eDP PHY binding contribution missed adding support for
> > > voting on the eDP reference clock. This went unnoticed because the UFS PHY
> > > driver happened to enable the same clock.
> > > > After commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor
> > phy_power_on/off
> > > calls"), the eDP reference clock is no longer kept enabled, which results
> > > in the following PHY power-on failure:
> > > > phy phy-aec2a00.phy.10: phy poweron failed --> -110
> > > > To fix this, explicit voting for the eDP reference clock is
> > required.
> > > This patch adds the eDP reference clock for sa8775p eDP PHY and updates
> > > the corresponding example node.
> > > > Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> > 
> > Is there any reason why you didn't follow up on this patch Ritesh?
> > Looks like it's ready to be merged.
> 
> I was waiting for patch to merge as there is no pending comments.
> 

It's been two months now, if you want your patches to be merged please
show that - ask the maintainer for a status update, ask a colleague to
send a reviewed-by...

Perhaps the maintainer lost track of your change?

Perhaps it's not clear that the change "need" an Ack from e.g. Dmitry
and then it should be merged by Vinod? Because you're changing two
different subsystems but leave it up to the maintainers to figure out
how to deal with this...


Either way, show that you want this to be merged, don't just wait until
the situation resolves itself.

Regards,
Bjorn

> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > 
> > Regards,
> > Bjorn
> > 
> > > ---
> > >  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml  | 6 ++++--
> > >  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml     | 1 +
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > > > diff --git
> > a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> > b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> > > index e2730a2f25cf..6c827cf9692b 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> > > @@ -200,9 +200,11 @@ examples:
> > >                    <0x0aec2000 0x1c8>;
> > >  >              clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > > -                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>;
> > > +                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> > > +                     <&gcc GCC_EDP_REF_CLKREF_EN>;
> > >              clock-names = "aux",
> > > -                          "cfg_ahb";
> > > +                          "cfg_ahb",
> > > +                          "ref";
> > >  >              #clock-cells = <1>;
> > >              #phy-cells = <0>;
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > index 4a1daae3d8d4..0bf8bf4f66ac 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > > @@ -74,6 +74,7 @@ allOf:
> > >          compatible:
> > >            enum:
> > >              - qcom,glymur-dp-phy
> > > +            - qcom,sa8775p-edp-phy
> > >              - qcom,x1e80100-dp-phy
> > >      then:
> > >        properties:
> > > -- > 2.34.1
> > >
