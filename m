Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074EDCD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B55E10E308;
	Fri,  8 May 2026 13:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uvCpTpO4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474EE10E308
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:20:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DA956024D;
 Fri,  8 May 2026 13:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C78C2BCB0;
 Fri,  8 May 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778246451;
 bh=nOPD9atbWThJNMmMoHB5sxyB+Zz+gBrCfQ8sDAbxWfs=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=uvCpTpO4REXkncNMBiNLPHMkLEABizVJIybZSKgueZ4IaHUHavnLFzv8P+NLJzgPD
 56mAOXlI9nEg2TxsBRdamOk/G6RgaGfgclVMiMBk4VzWSh6B/UAarPqlvWcraWZJXy
 jCuzmip8H9tWuqWjWk0hYvRJ3cEuCB+w1yxeHSYw6eamGP8ZuLPDQexOjiAx8jgYsg
 GxsXWeadcSEiVfnwQTHBIyBWfSp3POF7V0KIVSt38axnzkQo/Wn9sz/rRMHJ4inVSS
 DLv7iX+VtDuDuXZ/g5upJqVAmV0nY7PxLtjLUXfjhjudd6i7+M6Ud41q0VPGIObm/9
 TDJJCCo63qNCw==
Date: Fri, 8 May 2026 08:20:48 -0500
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-usb@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 ath11k@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Maxime Ripard <mripard@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-wireless@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org, linux-i2c@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
 ath10k@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: Fix phandle-array constraints, again
Message-ID: <20260508132048.GA1170714-robh@kernel.org>
References: <20260507201749.2605365-1-robh@kernel.org>
 <177818942584.2803269.2192622854542354589.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177818942584.2803269.2192622854542354589.robh@kernel.org>
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

On Thu, May 07, 2026 at 04:30:25PM -0500, Rob Herring (Arm) wrote:
> 
> On Thu, 07 May 2026 15:16:00 -0500, Rob Herring (Arm) wrote:
> > The unfortunately named 'phandle-array' property type is really a matrix
> > with phandle and fixed arg cells entries. A matrix property should have 2
> > levels of items constraints.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - Add proper descriptions for 'qcom,smem-states'. Thanks Krzysztof!
> >  - Fix i2c-parent warning
> >  - Fix extra blank lines
> > ---
> >  .../rockchip/rockchip,rk3399-cdn-dp.yaml       |  2 ++
> >  .../bindings/i2c/i2c-demux-pinctrl.yaml        |  1 +
> >  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml     |  7 ++++---
> >  .../devicetree/bindings/net/qcom,bam-dmux.yaml | 12 ++++++++++++
> >  .../devicetree/bindings/net/qcom,ipa.yaml      | 12 ++++++++++++
> >  .../bindings/net/wireless/qcom,ath10k.yaml     |  8 +++++++-
> >  .../bindings/net/wireless/qcom,ath11k.yaml     |  8 +++++++-
> >  .../net/wireless/qcom,ipq5332-wifi.yaml        | 18 ++++++++++++++++++
> >  .../bindings/pci/toshiba,tc9563.yaml           |  5 +++--
> >  .../remoteproc/qcom,msm8916-mss-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,msm8996-mss-pil.yaml       |  7 +++++++
> >  .../bindings/remoteproc/qcom,pas-common.yaml   |  6 ++++++
> >  .../remoteproc/qcom,qcs404-cdsp-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sc7180-mss-pil.yaml        |  6 ++++++
> >  .../remoteproc/qcom,sc7280-adsp-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sc7280-mss-pil.yaml        |  6 ++++++
> >  .../remoteproc/qcom,sc7280-wpss-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sdm845-adsp-pil.yaml       |  6 ++++++
> >  .../bindings/remoteproc/qcom,wcnss-pil.yaml    |  6 ++++++
> >  .../devicetree/bindings/sound/samsung,tm2.yaml |  8 ++++++--
> >  .../bindings/spi/st,stm32mp25-ospi.yaml        |  5 +++--
> >  .../bindings/usb/chipidea,usb2-common.yaml     |  2 ++
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml  |  7 ++++---
> >  23 files changed, 142 insertions(+), 14 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent:0: [2, 3, 4] is too long
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent: [[2, 3, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml

This needs a fix in dtschema I have not yet pushed out.

Rob
