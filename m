Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C106CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 16:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA10B112279;
	Fri, 29 May 2026 16:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O5F7b4Dk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFE4112278;
 Fri, 29 May 2026 16:51:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCB67440C0;
 Fri, 29 May 2026 16:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131451F00893;
 Fri, 29 May 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780073480;
 bh=L5+wHn6IPAv0JkbtVrb75rqnC0AiAfo3kPe47o2FMJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O5F7b4DksWQU62v76qQ9nPGlqNavKqAJLKtElCgI2i8AXZtEEvhBFlR7E2Yg3yk5U
 G86F2yMcRZWsNOU+GuANmzbKfK+AqFFz6W8wgHwcTYWlVmDwagQQ9kMAXsOXMg4XwJ
 7VaYW4IXOfHcMN5itlQgZbrV8dD/H+M0kslRA8exIjxX/G3Dbbz0KQY6iqKmT3Yq66
 I1rNR9fB08SxB6SMbvfE74iEj/rsntMh2utHW9VyXvjGf7KjMFnIxgSzfelq+BSq6l
 JOJaIx/KYVibZaBfdZwpM5o1Z5umcAg9xuPbyV1OPFxJO4rXjr3g0A6FhyZfBZ3UBV
 4g7Q1SXaENuxg==
Date: Fri, 29 May 2026 18:51:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/6] dt-bindings: display/msm/gpu: Document Adreno 810
 GPU
Message-ID: <20260529-vagabond-tungsten-worm-5f58cf@quoll>
References: <20260528-adreno-810-v7-0-7fe7fdd97fc2@pm.me>
 <20260528-adreno-810-v7-2-7fe7fdd97fc2@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528-adreno-810-v7-2-7fe7fdd97fc2@pm.me>
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

On Thu, May 28, 2026 at 09:48:39AM +0000, Alexander Koskovich wrote:
> Document the GPU compatible string used for the Adreno 810.
> 
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

