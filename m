Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BDCCCF2C4
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E61310E46B;
	Sat, 17 Oct 2026 17:48:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F271D10E407;
 Sat, 17 Oct 2026 17:47:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A359403CC;
 Sat, 17 Oct 2026 17:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F1C1F000C4;
 Sat, 17 Oct 2026 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792259273;
 bh=Y6wxuefu0HGgZzpl2asEyZMD0ztQpYnD4de3W/AFpWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AGv3iQNt7FUTHSsqJfqKTVAnVEHdNhpjoiq8FkaAz/62FZELr0jWeO5/qcFtMjENn
 rFb1s7xF+gHfiXJANG2cSyWe3RKiBhm0b2qRIhM4x9TMpXTP47F1/DELrCJbfNEU/s
 WpddNqtwJ8nqH82txBFhsAkIpDBXHjVpzDe/N/hXffIxcnAsNbM9ccrT9t8i+q/ahS
 JtrPk89M2IrzsVyfc0Oc+fwwIuoRCWuZzHqFuYiNn2imvFhj/9ukCIWXFYVWs58QUE
 lnnBJ1dR33Wv/dfN6+lBW2OptCyJY0AQHhp7oRGFnJ+IHmvmZ+LpdDW/FD8AfoAptt
 zpiYKn/exylOA==
Date: Sat, 17 Oct 2026 19:47:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: msm: Document Adreno 620 and
 its GMU
Message-ID: <20261017-discreet-rugged-carp-f4cf39@quoll>
References: <20261016-adreno-a620-v1-0-4a7ed6210d7d@brar.si>
 <20261016-adreno-a620-v1-1-4a7ed6210d7d@brar.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016-adreno-a620-v1-1-4a7ed6210d7d@brar.si>
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

On Fri, Oct 16, 2026 at 06:23:11PM +0530, Ishu Brar wrote:
> Add the Adreno 620 found in the Qualcomm SM7250 and its GMU. The GMU
> has the same registers, clocks, interrupts and power domains as the
> 650.2 one. As on the other A6xx parts, the GPU clocks are defined in
> the GMU node, so the GPU node has none.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 2 ++
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

