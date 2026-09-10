Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9F8C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C33610E116;
	Thu, 10 Sep 2026 15:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BFom+Ghy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FA910E116
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 15:05:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9403C407DF;
 Thu, 10 Sep 2026 15:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F61F000FF;
 Thu, 10 Sep 2026 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789052703;
 bh=5QahWKcG5oxi4x41HxsoEwy2LjSq/5QUc3DqUoozLAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BFom+GhyzJjyXzSFfgYe0Iqnl1pnI//uGaSJahBizFoLv3NfQbQuGImDKx1WRAVxU
 +Wvg4hm25LIp33iwPKOM0lOEWVEbMSQm7JjAP69JIR9OUxW05zIWQBCB6ztzKp51Ui
 yOaNLG2Ed0E3KV63uVHYg/CITTZF/u6IoTVW1RXsxOUK66rwbymnd0ATMuLm28vTIB
 /NZpQUVuq2UdXhiJgVPI3EJEEQO2VDsBa3HK9G4Bv9T1///i9WT1lEwojBm1+qPbsi
 O85VFYw70WcdpL2e+h379SnZmNg8CqEPt/8aOMWE22gAbSgXC8HxH2BKXHODiFSNEq
 wS5bb7drf+Onw==
Date: Thu, 10 Sep 2026 17:04:49 +0200
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
Message-ID: <xfwoa4jjigdx46lunasf5ze23ihm6qcvbhge7n27mxst5fxyzj@3ovbxzp4wzkk>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
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

On Tue, Sep 01, 2026 at 04:47:54PM +0800, Xilin Wu wrote:
> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status = "disabled".
> 
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.
> 
> Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
> dev->match_driver") made disabled PCI functions remain discoverable so
> PCI fixups can still be applied, while suppressing driver binding later.
> Preserve that behavior for endpoint functions.
> 
> For an unavailable node describing a PCI-to-PCI bridge, however, the
> node also represents a subordinate bus that must not be enumerated.
> Check the device tree node before reading the Vendor ID and return a PCI
> error response without accessing config space when such a bridge is
> disabled.
> 
> Functions not described by device tree and disabled endpoint functions
> remain discoverable.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Does this patch help?
https://lore.kernel.org/linux-pci/20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
