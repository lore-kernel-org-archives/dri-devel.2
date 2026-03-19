Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFED109024D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A07010E0FA;
	Thu, 19 Mar 2026 16:32:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id AF6C310E0FA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:32:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE252247
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:32:16 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 1483F3F7BD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:32:21 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:32:05 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, heiko@sntech.de, marex@nabladev.com,
 dev@kael-k.io, prabhakar.mahadev-lad.rj@bp.renesas.com,
 andre.przywara@arm.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Arm Technology
 (China) Co., Ltd.
Message-ID: <abwlBZ0nORcTOUby@e142607>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
 <20260313033119.33686-2-cunyuan.liu@cixtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313033119.33686-2-cunyuan.liu@cixtech.com>
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

On Fri, Mar 13, 2026 at 11:31:17AM +0800, Cunyuan Liu wrote:
> Add "armchina" vendor prefix for Arm Technology (China) Co., Ltd.
> 
> Link: https://www.armchina.com/
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Rob, should I take the whole series through drm-misc-next or should I split the bindings
into a separate pull?

Best regards,
Liviu

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ee7fd3cfe203..c7ca7f43925b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -172,6 +172,8 @@ patternProperties:
>      description: ARM Ltd.
>    "^armadeus,.*":
>      description: ARMadeus Systems SARL
> +  "^armchina,.*":
> +    description: Arm Technology (China) Co., Ltd.
>    "^armsom,.*":
>      description: ArmSoM Technology Co., Ltd.
>    "^arrow,.*":
> -- 
> 2.53.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
