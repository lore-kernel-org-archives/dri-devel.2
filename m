Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65764CCF2C1
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9177E10E40A;
	Sat, 17 Oct 2026 16:42:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4416410E22E;
 Sat, 17 Oct 2026 16:42:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2019F602CC;
 Sat, 17 Oct 2026 16:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280561F000C4;
 Sat, 17 Oct 2026 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792255362;
 bh=Dp+xWq2eEsv1m0He3+VqRksxCmCEv66m1b2LKY7pLX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MURcNqE1hNqkHH1CxzzDisdzt8ZCGGglaQPyeJYbNU2CWmW1KHl3H0IDmYsysqFUw
 rPy2/t4wV6QnBzggIgueqEPLfIfvtsCp4MEnRn0cO8zP/bW6muFLzBPNQ+aUjq3Roz
 X/+Iufi3TDS6Ri4+5Z+euYNPyX2HcaI//LsSAQANyhvPyb3eWW2qSO0quqMh8ofCl3
 1rWGsoIRghFM3QFY9HYRfLZFbBzXze/LygWU+je8H3tdQQiwC5XPWcKCEkBS58cDGj
 FgXzgc+DiiuwSiiZfzEBNEObTzQYh0xrCdzgEVssq5JwzfjIBlfr5C2idXu/wDZvxt
 p/MMRwnjQTaHg==
Date: Sat, 17 Oct 2026 18:42:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, 
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display/msm: dp-controller: Document
 Kaanapali
Message-ID: <20261017-uptight-bullmastiff-from-pluto-6f9ace@quoll>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
 <20261015-kaanapali_dp-v2-1-c15cb83d9140@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-kaanapali_dp-v2-1-c15cb83d9140@oss.qualcomm.com>
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

On Thu, Oct 15, 2026 at 03:24:32PM +0530, Balaji Kalkonda wrote:
> Document the DisplayPort controller on Qualcomm Kaanapali.
> 
> Kaanapali uses its own DP compatible string and has a resource
> layout with five register ranges and six clocks. Add SoC-specific
> constraints for those resource counts.

Valid Sashiko comments.

Best regards,
Krzysztof

