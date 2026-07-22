Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41454C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9718F10E31D;
	Wed, 22 Jul 2026 19:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R6CWYkHe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4299810E31D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7517A600AF;
 Wed, 22 Jul 2026 19:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA8E1F000E9;
 Wed, 22 Jul 2026 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784749195;
 bh=ZUyuIQ9nqah6EK1D0NOzJjYyGgjr5WnKeB3TFi1F4Es=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R6CWYkHej0TzzO3ANb+dlL3TJDL3lajBzdS7ovs2HnGR3VdE6hO8OmjYjtU5Q3ihV
 32qRgwxReQThPm6my97JY7+60yWrfpNW8oeww//RcBSMlDPhke2TKYzh10GK11eSFA
 UtxlzQ8mkezj74OtVQqlYyLcWZaTJss2ohbsf8WSbNkQPY5tyih3A9ksZhbsEWuD+i
 1hKiMHK9mBog2OGwfIsWBto97LQQHYz9bvF33U4xmvY4SB3sZSI5A03zUlAvMJsqtE
 DJLlQkpjN71PUJN2D6QVYbHuWPHPpsY2nGExOQxV4p9qq2etYLE2R5GRjNgXx8NFcU
 vWRQaMdWksDiQ==
Date: Wed, 22 Jul 2026 14:39:54 -0500
From: Rob Herring <robh@kernel.org>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel-lvds: Add boe,dv215fhm-r01
 compatible
Message-ID: <20260722193954.GA1559082-robh@kernel.org>
References: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
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

On Sun, Jul 19, 2026 at 09:38:36PM +0530, Vishnu Saini wrote:
> Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> compatible string to the panel-lvds binding.
> 
> Also remove the 'port' requirement from the required list to allow
> dual-channel LVDS panels to use the 'ports' graph topology with
> separate port@0 (odd pixels) and port@1 (even pixels) nodes, as
> required by the dual-LVDS binding.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/panel/panel-lvds.yaml          | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index b89f86bc0683..584818b2df6e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -58,6 +58,8 @@ properties:
>            - hydis,hv070wx2-1e0
>            # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
>            - jenson,bl-jt60050-01a
> +          # BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> +          - boe,dv215fhm-r01

This belongs in panel-simple-lvds-dual-ports.yaml.

Rob
