Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F6CC56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AED310EDE0;
	Wed,  5 Aug 2026 10:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QQLk0p3J";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E923E10EDE0
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785926650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBLPmYrNwyqCULYKtthS+JHQCLS3nMPhwf7QeBH1JBU=;
 b=QQLk0p3JcKiB2fiVfd1Y7A6SlAR6Wf0kgKXsD8kWUC5YUGZydX/EsvZOXENSXdM4ouQauY
 hJJK3mACBfwSjzpQ20vii9XwMIN41G8M5x+jspPu3mwajEovGoSc/P6612pUNzAWh0qcva
 hahevqkD0AwkKkUb91EyewDhpGuj/10=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-I15_pzuLMBSn4G2kcIkkUQ-1; Wed, 05 Aug 2026 06:44:09 -0400
X-MC-Unique: I15_pzuLMBSn4G2kcIkkUQ-1
X-Mimecast-MFC-AGG-ID: I15_pzuLMBSn4G2kcIkkUQ_1785926649
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81ebb5e11caso23801837b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 03:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785926648; x=1786531448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VBLPmYrNwyqCULYKtthS+JHQCLS3nMPhwf7QeBH1JBU=;
 b=jCAXhrDXspdIGcBpaNRxhhYBWLUBgrEoyBqeQPO0E6lgVdxGJgnmTgKNc/njpdyM5B
 FgNdwo8n0HNYelMgALBGLz0YFBU68ooQRuq2HPEbqFl9/k0hgiEJAcjE1cePf+jt+6kT
 CqLPMcMZO/m4o1oJGzprKqhfGsXi++9LMD1nNKU2xmnKuH08UFk/qEMdFNmjTo97wuSS
 4A/nUR1LUI4WLEFBDsIZmrYNzEVOIKYUzVsr5EZ2/hBWnZLnCoRNzljml69dxvc/tcFv
 GkjXZSvzkNNoMleZt+r3uLHo22KKWAR8l8Lau82/8gIG2CdVfMJkLV1GhjjtTVVcSOlj
 5s5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqr4Qj9144QfoV8FZSq22iV/6UyNQ2w8OXSMd1dCNCbP0NuX5i2v5QVL45SF7Sccqukz/2ivgy5RM0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS8uwm9oyXMHsXOAc+6ToyIpvwbPm+gvIibT2h/E0BsV6/NGht
 BOdSmaISljsH4rBcQo60gUE6ilxoHJfZLto6rUWJMIACdR67y178IW+jb9kzG9vjMCUtEBmoRjm
 sBXPrrxqYw3NmS8tiYIBfEykHRF/wYJA2yRq+HdoMJnUi69esNBMU/zwUiy8Vlypfj0VNS/aAuM
 7mYsWrKBs3pvGVUQQJNy5derq4arvFwPssHo3ZiBzG3Ynf
X-Gm-Gg: AR+sD11sBwHSiOKGoDM4CKimdXNJNLw7AFGuq9mFNeKb58qxGkR9PnRgIld8L/PfJr4
 +soFuuIj1FuJxC73SHrD+RBsOIq2YvgkMDThnTYt4IEdp/SSKl4G14Pn04lxe+34sRNg5iS8nPV
 PssX6XOe9yRaEOuZBDD6u/52wjXWlnRDp09ZFWZ/bVXiXNhQTn3PdDfIg=
X-Received: by 2002:a05:690c:4d02:b0:80d:964f:88fd with SMTP id
 00721157ae682-8201f0c14a8mr34578087b3.5.1785926648667; 
 Wed, 05 Aug 2026 03:44:08 -0700 (PDT)
X-Received: by 2002:a05:690c:4d02:b0:80d:964f:88fd with SMTP id
 00721157ae682-8201f0c14a8mr34577737b3.5.1785926648209; Wed, 05 Aug 2026
 03:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260722-panel-fix-kms-panel-put-v1-1-ebde56446ee5@linaro.org>
In-Reply-To: <20260722-panel-fix-kms-panel-put-v1-1-ebde56446ee5@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 5 Aug 2026 12:43:57 +0200
X-Gm-Features: AUfX_mzIqL0xVaQ870Pw0RFXK5xY2ZBOqREaUxjUjBjO8iIwCsGBLuNH2W3gAs8
Message-ID: <CADSE00K71ke8yXv8xxJ=e68kqPQAjXiOw1kY_BFpTsfw=xiJaw@mail.gmail.com>
Subject: Re: [PATCH] drm: fix missing header include for drm_panel_put()
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -zB1YjVPbEkxydBUX5MIBRXQMNev1sR8tpzcLo_g9Fw_1785926649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Neil,

On Wed, Jul 22, 2026 at 12:07=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Some DRM drivers lacked the drm_panel.h include to use drm_panel_put()
> after the commit b71a623598d3 ("drm/panel: of_drm_find_panel() return a c=
ounted reference").
>
> Fixes: b71a623598d3 ("drm/panel: of_drm_find_panel() return a counted ref=
erence")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Oops, I missed building on my last revision. Thanks for taking care of
this and sorry for the inconvenience.

BR,
Albert.

> ---
>  drivers/gpu/drm/imx/dcss/dcss-kms.c | 1 +
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c   | 1 +
>  drivers/gpu/drm/stm/ltdc.c          | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dc=
ss/dcss-kms.c
> index 01e0c10b6ea1..7c5a6e2bc89a 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mx=
sfb_drv.c
> index 7cb19c15bf39..8b4a500347fb 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -29,6 +29,7 @@
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index daf198edb42f..8818dcf98da7 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -34,6 +34,7 @@
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>
> ---
> base-commit: 0f065acf44aeb8c32691d88cc87004fd2e54e902
> change-id: 20260722-panel-fix-kms-panel-put-38c079412f83
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>

