Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55DDCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3083510ED2F;
	Tue, 29 Sep 2026 07:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hPB/y1lW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C1110ED2F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:46:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28B3660210;
 Tue, 29 Sep 2026 07:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA6A1F00898;
 Tue, 29 Sep 2026 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790667970;
 bh=EIHkUIYifOHwbWldjH0tGVUqDKZQiGqLC0z1iDVXIxU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hPB/y1lW95b+WWL0a1F2vXtqQY+zkP0BP1jQQMSWPftm6hFxBFi4y23QPhjIioMWm
 iGmtj8IPPnbtkTHsPdkR3kWUYftxGO3tfuelZQ94v6IIppKvUnCNfokbVb7/VfFosT
 o3GydFgsN/fV4rmqP/db3QvFVa2q4tfBao2KrrB+mYhktQ3zBvdb6gAn6Ipkl6ytXN
 BAx40hZn8Xaqtsibldcn4kFWkMXKtEdVtvbX6uI8XN+I1LKIJF28ot1GG3+bbFFS5V
 bL8BLgRp8St005piiHIeibktVtPaKQVOJ7uO0UOK4r1YiWgohS+PmGepWYBCoJRVMM
 QDQikM+dT862w==
Date: Tue, 29 Sep 2026 09:46:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Petr Vorel <petr.vorel@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] arm64: dts: qcom: sdm845-samsung-starqltechn:
 Update panel compatible
Message-ID: <20260929-spirited-umber-hedgehog-300ebd@quoll>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-9-08d5c7bf72fc@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-crosshatch-panel-v2-9-08d5c7bf72fc@ixit.cz>
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

On Thu, Sep 24, 2026 at 04:01:37PM +0200, David Heidelberg wrote:
> Original compatible describing only the DDIC used, but omit describing
> the panel used (Samsung AMB577PX01), which we have no way to detect.
> 
> New compatible allows without breaking ABI fixing the inverted reset.

No, this is wrong. You just broke all the users of this DTS.

> 
> Assisted-by: LLM
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

NAK

Best regards,
Krzysztof

