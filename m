Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7DCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351AE10EF69;
	Wed, 13 May 2026 16:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Umk+nQqf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D47D10EF69
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:45:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4929060129;
 Wed, 13 May 2026 16:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD15C19425;
 Wed, 13 May 2026 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778690712;
 bh=msDVtcqmbmg66KjNFHJpNOm8yFfAcfXZQ+MbCdSjyII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Umk+nQqfftUIQjg05CAeja8xnssdz9t0+lnmY9bCiojocCGCPcSDmJzJt1/etBL6U
 hqjNbZXsGJkvxXpwIwd5SjmBOdhvmiRMv5oP1VnZsUlIn/a6VdSbeiMOcQK+e3d7vM
 p8i44SrcPHtfgfN7URfm225mfu6GDVZjoWNLnRPO+YRZeTB7f9v4QJ+GDjfapd+imO
 EzhbxAYNUJORt9ExeMNZNiLp/+fEC/TFDGeWo1XmibrzNBZzClxDaKgBXOPURcUbMF
 mPnKHbsny1EWeDebt7n00Ken2sNqEPdrTHRhytSi9dS5iJXVBf0wSkVoBRRHUKzCJF
 vjj1d03javrBA==
Date: Wed, 13 May 2026 11:45:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, David Airlie <airlied@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: display: imx: add deprecated property
 'port' and 'display-timings'
Message-ID: <177869070825.1285462.2467866866860816055.robh@kernel.org>
References: <20260511220924.1905571-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511220924.1905571-1-Frank.Li@nxp.com>
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


On Mon, 11 May 2026 18:09:24 -0400, Frank Li wrote:
> Add deprecated property 'port' and 'display-timings' for i.MX5 SoCs (over
> 15 years) to fix below CHECK_DTBS warnings:
>   arm/boot/dts/nxp/imx/imx51-apf51dev.dtb: disp1 (fsl,imx-parallel-display): 'display-timings', 'port' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/imx/fsl,imx-parallel-display.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../display/imx/fsl,imx-parallel-display.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Applied, thanks!

