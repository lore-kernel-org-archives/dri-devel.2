Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523AC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453AA10E4E4;
	Mon, 27 Jul 2026 20:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LaRuKq3s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41ADF10E4E4;
 Mon, 27 Jul 2026 20:24:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29246413DB;
 Mon, 27 Jul 2026 20:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BFD1F000E9;
 Mon, 27 Jul 2026 20:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785183847;
 bh=1zsX+/hLibeVR8dk98Ayb9qUBCFj724jbHItlZRXEQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LaRuKq3sgFAWH1R1f0y0QFO5AT9g1HZWhfB08B27UePLiO3pqCfPFDlio1Wz1htNH
 MzCIJFa/TCb+/cFleaik0z02VtREs8aCVff2fVbqYH/LdLWsPN6tJ+jJeWkJ5/sqtn
 NB9cw2vQFOKOpwIU3z37o5IXqPYCTBRAdUbLKwow6TVb/RjKY5UrlZTds8ntbde1PP
 Z5uXLVuqQdVhyqTyflzh1dVH4WHSudRsykhO/SLdjdCoUEczN3X+D0BtjUzRZ2kvu9
 dghedHsYizbQXq3lxiieU7qVq5NYqTc0SZW+j89xaceACh3Ma0WVyUjebUWp5kjRXd
 3n70l04u3D4yA==
Date: Mon, 27 Jul 2026 22:24:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: panel: Modify reset gpio
 number constrain
Message-ID: <20260727-dynamic-tunneling-nyala-ede2fa@quoll>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-1-c042266b9eeb@linaro.org>
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

On Mon, Jul 27, 2026 at 04:08:40PM +0800, Jun Nie wrote:
> Some panel support 2 reset gpio, such as Synaptics R63455. So modify the
> number constrain of gpio to 1 to avoid check failure.

Also:
Subject - anything is "modify" be specific.

Best regards,
Krzysztof

