Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386EBC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9538310E6FC;
	Wed, 15 Jul 2026 20:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FkCbj5iV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D0310E525;
 Wed, 15 Jul 2026 20:56:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2D13407FF;
 Wed, 15 Jul 2026 20:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7873C1F000E9;
 Wed, 15 Jul 2026 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784148962;
 bh=m4XmsXdgfJ/7kH3sualvLazcBXFKF6f6kDqvJIEEgsE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FkCbj5iVJfU+LrvOIrZnVTa0oy+9XoN3XHaZ+IEPklQhed6GuGmXtzJn0uIyBXBI2
 BsjjJvWy+hFAdkOBfpF/e5+OuPUdxwlMobkbhF/ORwIEn+sRHv49X8p9xREUDBXSYh
 jIDLAv8MoVaceI1UPG680F7xGFgvUEgutmCC7HQBllcYGmYwKtMtmyCZB6hEG67BP9
 SyUchYqwkcjrGVrpCwpjHfGLApAZLNSMkQXgS7pCi1onnnPwCYWHkj6wgjiaxTJRaX
 gf1Up7DGqmfDV/YbDstC0rUP6Tm8+p+vBUEP8s31pEbk6idGQ+tpNidcO0qnBABHlf
 3BA0yzRsgCSZA==
Date: Wed, 15 Jul 2026 15:55:57 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/8] qcom: display / dts: Few corrections of
 address spaces.
Message-ID: <alfzlxrqu23e9AgO@baldur>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <178339449937.1938770.7041355905157380217.b4-ty@kernel.org>
 <b50912e0-b7cb-4986-9e62-63a15792a167@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50912e0-b7cb-4986-9e62-63a15792a167@kernel.org>
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

On Tue, Jul 07, 2026 at 07:57:22AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2026 05:21, Bjorn Andersson wrote:
> > 
> > On Sun, 05 Apr 2026 16:33:56 +0200, Krzysztof Kozlowski wrote:
> >> Changes in v2:
> >> - Patch #2: Add dai-common.yaml reference (Dmitry)
> >> - Correct subject
> >> - Rb tags
> >> - Re-order Eliza bindings patch
> >> - Link to v1: https://patch.msgid.link/20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [8/8] arm64: dts: qcom: sm8750: Correct DPU VBIF address space size
> >       commit: 4fd832d6aed496c7111746d2c1e36b006659f89d
> > 
> 
> 
> Only this one? I guess I will rebase and resend.
> 

I don't know why one this one. As far as I can tell they are all in my
tree, so it's strange that b4 only noticed the last one.

Hopefully that rebase came out empty? Or am I reading things
incorrectly?

Regards,
Bjorn

> Best regards,
> Krzysztof
