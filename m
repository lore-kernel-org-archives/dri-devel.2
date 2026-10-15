Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DF0CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D3310E27D;
	Thu, 15 Oct 2026 20:12:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5451010E27D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:11:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB6F643B9F;
 Thu, 15 Oct 2026 20:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA151F000C4;
 Thu, 15 Oct 2026 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792095116;
 bh=XyXToTfD30NMTH56PCohND5pezL23xfEZy59DIVFNXo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C6xDSguTrak3YRNOzO3P9bCfFHDGlBHecCrl1SM1FdTxv63jam1YyMSHhXQv0GN4o
 6rGjahoNHj5upzPfi504vofhlw8RCZyIkNQeatgMcv5LggFdZ7FyP+UhqOeeLNjpTW
 6Q0vTS4wn+saw9vqG/OS4ocLo05VGXIlYen7pVNtyXwPFnDMXtfICM/IELTxQBVdjB
 +yrGpTjWYIBaEkzTAkJ6Tb6fzfUst0WgfI4PxK/Ynxz8NRrZ4SlljjxdB43ugBqbvO
 0S48njeULhPxDLEsf/dpwfL4GAq6TEkYbk93VbYYGPg422AOzMQfScKx+g2BWPyaiT
 //CFc76JhSGhg==
Date: Thu, 15 Oct 2026 15:11:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Stephen Boyd <sboyd@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-clk@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: display: panel: add Truly NT36850
 WQHD panel
Message-ID: <179209511403.2867457.13660971781879980821.robh@kernel.org>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
 <20261015-sdm845-hdk-v4-1-b532b9f4029c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-sdm845-hdk-v4-1-b532b9f4029c@oss.qualcomm.com>
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


On Thu, 15 Oct 2026 11:39:08 +0300, Dmitry Baryshkov wrote:
> Describe the Truly 5.7" WQHD dual-DSI command mode panel based on the
> Novatek NT36850, used on the display cards for the Qualcomm SDM845 and
> SM8150 HDKs.
> 
> The model name of the panel is not known. Neither the vendor kernel nor
> the HDK documentation mention it, and the panel block cannot be taken
> apart completely to check the label. So the compatible is built from
> the vendor, resolution, refresh rate and the controller name.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../display/panel/truly,wqhd60-nt36850.yaml        | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

