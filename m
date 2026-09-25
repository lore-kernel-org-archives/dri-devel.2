Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D944C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8C710E5CE;
	Fri, 25 Sep 2026 12:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eOugo/xs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACD610E5CE
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:30:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B929660136;
 Fri, 25 Sep 2026 12:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408321F000FF;
 Fri, 25 Sep 2026 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790339456;
 bh=f1wkjUAJ6a32H/DZDitGVNd21IhCL485bJ83WiTx4Nw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eOugo/xsQISJsvHT3Y8QYzdtdSKE2XO5BUK/EeruX2DxiSTHELjtUAzyby8WVJpL+
 cMG6VLOZe1Axw/ywbqTLiN8pV9wZol56K1GQQRKnjpJXc4YuwTRx5I4aHPPRA+SRAu
 57qyQzmmPaBQeoCi23hTnKwklXIykSLQ6W8EWHAcVfTdh5pC79i8V/WzjGvQbmuUwG
 LBVS02XF7LnVQcLJeL1qBsJFafJWSwIdzWEM51zy9iwcVH+3ZnWeGl6rrwryyLVxpv
 8yqgzFkESb6WrmOyaI1DhvI2afx1VhdIOb6Eg1MnTckp5yMMvXQv8d+LlEieXOkBSM
 4MBAbyreql0Xw==
Date: Fri, 25 Sep 2026 14:30:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v5 1/2] dt-bindings: display: Add GlandaGPU binding
Message-ID: <20260925-fabulous-wren-of-action-89d266@quoll>
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
 <20260920193944.110983-2-kieweg.leander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920193944.110983-2-kieweg.leander@gmail.com>
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

On Sun, Sep 20, 2026 at 09:39:43PM +0200, Leander Kieweg wrote:
> Add Device Tree binding documentation for GlandaGPU, a custom
> FPGA-based 2D display controller.
> 
> For hardware designs and RTL sources, see:
> https://github.com/stiangglanda/GlandaGPU
> 
> Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
> ---
>  .../bindings/display/kieweg,gpu.yaml          | 56 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

