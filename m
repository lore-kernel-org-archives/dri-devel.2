Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0FACD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 10:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EDD10E13E;
	Mon, 25 May 2026 10:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NcpNvr/k";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr
 [80.12.242.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1010E13E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 10:14:24 +0000 (UTC)
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
 by smtp.orange.fr with ESMTPSA
 id RSKCwSmE60vWHRSKCwRtyp; Mon, 25 May 2026 12:14:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1779704063;
 bh=RHF5/7UJVhD27Lwb3tHM9Ryg0OTUsaGFuxHHVJkuPxk=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=NcpNvr/k0+PeOZaoW4Nk+Iybpzmi6ytDHvD3XA9jydeEmW1P78wZ0USD+CLdeAkuk
 ai4y2JPxyZaViQI8SK+BkPTe4+ykrdzO1mTOrZ5qGqe4hUHCVgq4Q0b2u7P5iIcGuj
 rVLOQ8OZcaOYRJ5f1yhHkKFQskNW47SimzDKmBXgFwy4yFqQKG4JA/2NcwFz7WnrKj
 Yxr3iCo2J4Mrnwr373rlBZWNMWbbe0z6p5R/QC+dTybMbizogzsDRkb2DpoPQWJPTR
 WYBs8pEp0/Q28im+9cWb764Z3e6YEUsCti2zPMKtIoh9qS4WkT5JCMLV/g22LGGBQ6
 ZZ3CbCAMRr5Pg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 12:14:23 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <f90481df-c68e-4c3c-be50-ad4e5e97d19b@wanadoo.fr>
Date: Mon, 25 May 2026 12:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: novatek-nt36523: use devm_drm_panel_add()
To: Myeonghun Pak <mhun512@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <cover.1779640137.git.mhun512@gmail.com>
 <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 24/05/2026 à 18:36, Myeonghun Pak a écrit :
> nt36523_probe() adds the DRM panel before attaching the DSI devices. If
> one of the devm_mipi_dsi_attach() calls fails, probe returns with the
> panel still registered.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 0993234a0045 ("drm/panel: Add driver for Novatek NT36523")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index 226d91daf8..f6592b01df 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -1047,13 +1047,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> -static void nt36523_remove(struct mipi_dsi_device *dsi)
> -{
> -	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);

Hi,

Not looked in details, but the:
	mipi_dsi_set_drvdata(dsi, pinfo);
in the probe now looks useless.

CJ

> -
> -	drm_panel_remove(&pinfo->panel);
> -}
> -
>   static int nt36523_get_modes(struct drm_panel *panel,
>   			       struct drm_connector *connector)
>   {
> @@ -1225,7 +1218,9 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>   			return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   	}
>   
> -	drm_panel_add(&pinfo->panel);
> +	ret = devm_drm_panel_add(dev, &pinfo->panel);
> +	if (ret)
> +		return ret;
>   
>   	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
>   		pinfo->dsi[i]->lanes = pinfo->desc->lanes;
> @@ -1259,7 +1254,6 @@ MODULE_DEVICE_TABLE(of, nt36523_of_match);
>   
>   static struct mipi_dsi_driver nt36523_driver = {
>   	.probe = nt36523_probe,
> -	.remove = nt36523_remove,
>   	.driver = {
>   		.name = "panel-novatek-nt36523",
>   		.of_match_table = nt36523_of_match,

