Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5039DFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CA510EA3F;
	Tue, 28 Apr 2026 07:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O9XI4NDl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F00E10EA3C;
 Tue, 28 Apr 2026 07:41:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 53FA360133;
 Tue, 28 Apr 2026 07:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7589DC2BCAF;
 Tue, 28 Apr 2026 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777362096;
 bh=UfYVcnjZ7Yd1VqbbHzwFGlt22qkE7sYoXn7cJY+5boY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O9XI4NDlKQ4ouR8xO0xmvuukD3U+E8twBJIWuneFbU9ESgJxLDGAl+ejeQMerVlA8
 oKFpcaUBUVSpRiB1fs2UanW/pn3xZbb2t98eLegYJZZxY/laF0PW3w/hCosnp8tyDK
 w7mivNDfY76dP6IHKrEjwhP1YTtlMVhV228fzYPYrEq5YuEBKX08RAAkMQ8yabpXLY
 477mqFiYY4Xc3vSnEPNYsYkKp3DGBG9Ve7PhLkM1H6qy0KiuPz1hNkMaLKSwUadSNq
 yih7OWwLMGKiSLBZPwO3cP00Kqzzts+EHG4PhhN4HBZnV0hlXL3BCYZ2N00fff62X8
 Iunf09LYhxIVQ==
Date: Tue, 28 Apr 2026 09:41:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: display/msm: Fix typo in clock-names property
Message-ID: <20260428-wise-rat-of-criticism-df0ea3@quoll>
References: <20260427154658.276737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427154658.276737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, Apr 27, 2026 at 04:46:58PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Fix the typo "clocks-names" to "clock-names" in the allOf/if conditional
> blocks.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note, patch applies on top of next-20260427.

No one can apply on top of next-20260427, there are no such maintainer
trees.

Please add Fixes tag.

Best regards,
Krzysztof

