Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D27C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B7A10E28F;
	Tue, 15 Sep 2026 16:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9EPfYJd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65EC10E28F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:20:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A02343E01;
 Tue, 15 Sep 2026 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122331F000FF;
 Tue, 15 Sep 2026 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789489231;
 bh=RXBrLiLiz0n80fxwj45X8rCy/dKBYNqLefu8S9axmic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K9EPfYJdOLWHN9V7ExZUViRpxfyW+Gl5dGATOov+LO7B8ua0v7l0/qijwtlyr3SDr
 WiGhdHsox88YDnIKD7gaYSZRh5QtuGrHmESkR3Hlza5FfBDwO90gizk6ONlSrdTw9q
 DhbSV8xSQYaet9/EJNyUWzkCqmouKlYgZHJvzMo6pwKeg8LMzVvrP/AN9SSkGDr6K6
 3YsHvRYoA08Vazpkm34Di+9hI95aLXz+I3ZNjOidZc5s3YRkcOXZQqdDP4po+4e1it
 dI78yIVGdR1vEwYhsoMc4In8ZGLW66GFzlt5LRXM3fWpCYt+w0SWGtyZga172IPbzw
 cDknCzmeZuzFQ==
Date: Tue, 15 Sep 2026 18:20:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
Message-ID: <fsrr5xg4plfknfcvv5co4ciklz5pywa5bbfxbthwsnjevysr5v@myghuxblnend>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <xfwoa4jjigdx46lunasf5ze23ihm6qcvbhge7n27mxst5fxyzj@3ovbxzp4wzkk>
 <811E4CAAE0EC3103+2a53ade9-4b52-49a5-945d-2364fbce3c82@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <811E4CAAE0EC3103+2a53ade9-4b52-49a5-945d-2364fbce3c82@radxa.com>
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

On Tue, Sep 15, 2026 at 11:04:25PM +0800, Xilin Wu wrote:
> On 9/10/2026 11:04 PM, Manivannan Sadhasivam wrote:
> > On Tue, Sep 01, 2026 at 04:47:54PM +0800, Xilin Wu wrote:
> > > The TC9563 PCI power-control driver powers off external downstream ports
> > > whose device tree nodes have status = "disabled".
> > > 
> > > On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> > > powered-off port functions during PCI enumeration raises an Arm SError
> > > instead of returning an all-ones PCI error response. This prevents the
> > > board from completing boot.
> > > 
> > > Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
> > > dev->match_driver") made disabled PCI functions remain discoverable so
> > > PCI fixups can still be applied, while suppressing driver binding later.
> > > Preserve that behavior for endpoint functions.
> > > 
> > > For an unavailable node describing a PCI-to-PCI bridge, however, the
> > > node also represents a subordinate bus that must not be enumerated.
> > > Check the device tree node before reading the Vendor ID and return a PCI
> > > error response without accessing config space when such a bridge is
> > > disabled.
> > > 
> > > Functions not described by device tree and disabled endpoint functions
> > > remain discoverable.
> > > 
> > > Signed-off-by: Xilin Wu <sophon@radxa.com>
> > 
> > Does this patch help?
> > https://lore.kernel.org/linux-pci/20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com/
> > 
> > - Mani
> > 
> 
> Thanks for the pointer. I don't think it helps in this case. That patch
> enables the Qualcomm ECAM blocker when the Root Port link goes down. Here,
> the link between the Root Port and the TC9563 remains up; only some TC9563
> downstream port functions are powered off, and probing those functions
> triggers the SError. Therefore, we still need to avoid these config-space
> reads.
> 

Sorry, I misread the problem statement and your analysis about the patch I
pointed out is correct. Here, there won't be any LDn as the PCIe link between
the RP and Switch upstream would be active.

But looking at the patch, I think it is going in the right direction because,
this issue of probing the unavailable PCI devices is not Qcom specific. So
adding the check in the generic PCI code is the right thing to do.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
