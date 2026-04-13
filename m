Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F09E93812
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6839010E05D;
	Mon, 13 Apr 2026 03:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="R+B7WINa";
	dkim-atps=neutral
X-Greylist: delayed 383 seconds by postgrey-1.36 at gabe;
 Mon, 13 Apr 2026 03:28:25 UTC
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AF210E05D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 03:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1776050901;
 bh=ogsVwqs2EHz5JEsVYxGWqhUqK0WWsNCtR6dBPtTnbfg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=R+B7WINaBRJVrinve0ezKLkCfyRGeKxRoFDr5KB23cQ21nduBsmk04etQpKCCG8w8
 0oZltJLo6HPzpjRmQuEfDJyefnuZSQ7ZSPuklMBZipxD0vnfDHeywJD6E0/el1XAYe
 ++Mb57UgjWsRKZquaVoMFlFEWzciGlnW5h2/CaGo=
X-QQ-mid: zesmtpsz9t1776050350t7b8516f3
X-QQ-Originating-IP: GNntOqy7/9Vf323diNegGGGi1nHYBbOd6PR/kOLCRlI=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 13 Apr 2026 11:19:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4940756688928196925
Message-ID: <3F2138A226F05F52+ad3e8619-5b37-487c-87e8-cde3b5ae8081@airkyi.com>
Date: Mon, 13 Apr 2026 11:19:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mipi-dsi: Only remove child devices that match the
 dsi device type
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20251203115028.133-1-kernel@airkyi.com>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20251203115028.133-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIOa0ndEC0BbVSWau7HNAqExC4gF2v5aVzIcZ6TzjO70KMoCFxs2Cqli
 QeLhvttQ27nua/m+mA1iEhxeZRpQhlw5bpbuZYu2O4BZV0cRnWkqjbtlV0MFAsrCnHmjy5/
 m9qkQiD0+XjVTtO68IctMk1DQHKe1bS2xcGVJP7pXVo4f461v+RLbSOwRBRbtsJjaMpkldc
 kYa5nxAVptusDFgdeCpCWU+ErQR8s9VY6ekvSTzUAYrqEaabSjWNsA7sCkZnHRSSOeTP+wd
 t9kvHitnhAlaZABAbSlt+fPlZd3/Q3XvAt3JkSiCEwhR23XjRY7V64O4YpoG6sZbiGTtnXf
 YVjAsHgZ+0J0AvR3/3vzCZlF3lO12PQVjt5EEZg9boMTL5xmmSo4bl/u1Q9cqoEnoPDK+mW
 taqqAIoj4akn43VMGuB1T4U0K8kjQ6JESPH5bv/xZbNmvrwouLwXV6z7x7qd0Wg3o3236qE
 iqjpMYgSLBnpZ2jzy5ZhsovZn0ocswXs+NqrUlxan2U5Msw7Hdai/qVbQ+puVxW2UAdOPDn
 ACX/n2AzEOIvp5dlks8YaYl9SPvAQodCM3ntcF6ZdpcystY4dm3M7cD3nM1Xh0fjGF5s7Pw
 YX0+q+qrHfgpUPVoiDmfeVWIun3sJl6vE5bUU5HYdesVtgNOtAitmtE3ezkcgFi2jjU2fbJ
 wdveCESS74CQdCofJNLhY1VCkujLtIgVq5QFRY9s2IvrG6A5sXsnAwak+HRjEubxCBca4bx
 +enNX/KoCkAduMKsB0dJvTmcZX0JEq8YFZtay5CIv64WrAaBHt/CcJzRnvzgh6r2VdM/eeU
 XMoz5ZwmCpAVr5nZt4LhECmxftN8C24MJYjp76olYthlAbw7fDjzn4PtuH9A4V3PCI5ZZR6
 gFQv4cZtBD0gtkW3Viob4vRHsTSbSWo/KbkcuOQ3J1dc7lRiaK+elm7cMOP1kzCPeZdMl3c
 ofQwywrh8X9e012ew2RW8S2OeGBJ6zTi6ePfMY+zDz++UKQtU5/HUKFCcATAYtzuyvps6jC
 cBeKol8rZsQAc6DNIZ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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

Hi,

On 12/3/2025 7:50 PM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This patch checks whether the device is a valid mipi_dsi_device before
> accessing it in mipi_dsi_remove_device_fn().
> 
> The mipi_dsi_host_unregister() assumes that all child devices of the
> host device are mipi_dsi_devices and uses mipi_dsi_remove_device_fn()
> to perform subsequent operations specific to mipi_dsi_device.
> 
> In rockchip platform, for dw-mipi-dsi-rockchip.c, it creates a dphy
> device, and it use the dsi host device as its parent device.
> 
> And when we call dw_mipi_dsi_remove() in
> dw_mipi_dsi_rockchip_remove(), mipi_dsi_host_unregister() will get
> such a dphy child device and treat it as an mipi_dsi_device, which
> will lead to a further panic.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index a712e177b350..5b9cc799eb87 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -349,7 +349,12 @@ EXPORT_SYMBOL(mipi_dsi_host_register);
>  
>  static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
>  {
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
> +	struct mipi_dsi_device *dsi;
> +
> +	if (!dev_is_mipi_dsi(dev))
> +		return 0;
> +
> +	dsi = to_mipi_dsi_device(dev);
>  
>  	if (dsi->attached)
>  		mipi_dsi_detach(dsi);

Gentle ping about this.

Thanks!

-- 
Best, 
Chaoyi

