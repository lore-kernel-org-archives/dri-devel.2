Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B3CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B25310E75A;
	Tue, 13 Oct 2026 08:48:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093EB10E75A;
 Tue, 13 Oct 2026 08:48:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F77A60261;
 Tue, 13 Oct 2026 08:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E0F1F00893;
 Tue, 13 Oct 2026 08:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791881319;
 bh=36P5CpgdnuQ4CoV44/SKhsr0TCOPh6qxQXHvG9Dgu5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bGXGjOhcc9psij0rrEqM/LpPPJCe3tWvDn7YM7khlzZlzUZhnVTd6hOsrFRnKdgvh
 oyGFczU1xntEjvmvoagTrbIe0yySuqByu73Gtf6CkPiBg1uIbqU151QTy+sVuBd7fu
 2itMFOi5JYJlen3w003Y7h739T62k9buitqneKGhhp1eh6BtxA7Lk/cAx8/FAjl+uV
 czBZoUK14IZZi8y3wwNiedPDlFDsfERM9g80F/9JrR3kQC1okmoTQhjs12Rrun2Z/Z
 tU4b9m+RBQE0LLOVaVh2ceBFrux/bRg4ra9I9ftkFuY8P6JSffx3rTtRpi6v8fRZ+Y
 v+kM/2oHg/idg==
Date: Tue, 13 Oct 2026 10:48:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Shawn Guo <shengchao.guo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>, 
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/13] dt-bindings: display: msm: Document the Nord
 DiplayPort controller
Message-ID: <20261013-honored-bear-of-cleaning-bd8108@quoll>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-2-a2ab9af954d2@oss.qualcomm.com>
 <20261013-tangible-wakeful-swift-a38f8f@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-tangible-wakeful-swift-a38f8f@quoll>
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

On Tue, Oct 13, 2026 at 09:44:15AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Oct 12, 2026 at 07:02:12PM +0530, Nabige Aala wrote:
> > From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > 
> > Nord uses MDSS 12.1 with two independent DP controller instances,
> > each exposing two DP cores at new IO offsets. None of the existing
> > compatibles match this layout, so add qcom,nord-dp.
> > 
> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> 
> Do I understand correctly:
> Device is fully compatible with qcom,sa8775p-dp, but a simple to fix
> driver limitation is preventing compatibility?
> 
> If so, let's fix the driver - just add more addresses to the
> msm_dp_desc_sa8775p array?

Or it does not matter, because top-level MDSS anyway cannot use
compatibility?

Best regards,
Krzysztof

