Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9D5F54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7EA10E72C;
	Tue, 24 Mar 2026 16:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="AjDtRVP+";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5D42F10E72C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:10:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B3A1A00
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:10:20 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 475073F915
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1774368626; bh=LiKq7+XEkERz+7oUFGh3hi6ZUUrEQoeRp+Pf+HHSaT8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AjDtRVP+vz9ifyNK+UunPKuKsDKD7Fz9UtaHuhnGsgibZ4vP4Lp6U96+rnAE1sU0M
 aKJ1YHeiqlDdu+MaOy4hyckoE38YpyPjaK2GNCN0fIp4mD7hA5hGp9uQXWoQJaseP0
 VTt2QEVoc685ctV+rA4wt2sFrTIoIP3Ws9bwD4SY=
Date: Tue, 24 Mar 2026 16:10:10 +0000
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
Subject: Re: [PATCH v2 0/3] Arm China Linlon-D6 display controller support
Message-ID: <acK3YnKOyPbAroFu@e142607>
References: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313033119.33686-1-cunyuan.liu@cixtech.com>
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

On Fri, Mar 13, 2026 at 11:31:16AM +0800, Cunyuan Liu wrote:
> Adds Komeda DRM support for Arm China Linlon-D6. The IP is register-compatible
> with Mali-D71, so we reuse the D71 code path.
> 
>   [1/3] dt-bindings: vendor-prefixes: add Arm Technology (China) "armchina"
>   [2/3] dt-bindings: add armchina,linlon-d6 compatible (fallback to arm,mali-d71)
>   [3/3] drm/komeda: add Linlon-D6 product ID and of_device_id, use D71 funcs
> 
> Changes in v2:
> - PATCH [2/3]: rework compatible schema using enum as suggested by Krzysztof.
> 
> v1: https://lore.kernel.org/dri-devel/20260311055506.12023-1-cunyuan.liu@cixtech.com/
> 
> Tested on Radxa Orion O6 with Linlon-D6, basic display bring-up works as expected.
> 
> Thanks,
> Cunyuan
> 
> Cunyuan Liu (3):
>   dt-bindings: vendor-prefixes: Add Arm Technology (China) Co., Ltd.
>   dt-bindings: display: arm,komeda: add Arm China Linlon D6 compatible
>   drm/komeda: Add support for Arm China Linlon-D6
> 
>  Documentation/devicetree/bindings/display/arm,komeda.yaml | 4 +++-
>  Documentation/devicetree/bindings/vendor-prefixes.yaml    | 2 ++
>  drivers/gpu/drm/arm/display/include/malidp_product.h      | 1 +
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c          | 1 +
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c           | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0
> 

Pushed the whole series to drm-misc-next.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
