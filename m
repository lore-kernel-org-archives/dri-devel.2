Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC5F436BF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 18:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425FE10EA92;
	Fri, 17 Apr 2026 18:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="J7o8Uin6";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6031910EA92
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=iSdycSiP5esxiXkmf5jgR1xrey6IchJab4DsyuEFOg8=; b=J7o8Uin6ImzqMX+KPax8BJ7oJ+
 Cb0v9P9UtzsxzUJ1PiDCPiHvp7I9rSe78ThYD1Tt7h+3XRwFSZg0ecRb5X5Hr7cz7JBut5A7xOPSK
 VwbILE8E7ELijmYSfw3MXYywI7xW9CBw7+pAqxrUXfIGiHlbriPuqzw1IHp0o1MAGlB0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1wDoOu-000000002y1-3QhF;
 Fri, 17 Apr 2026 14:58:49 -0400
Date: Fri, 17 Apr 2026 14:58:48 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pavel Machek <pavel@nabladev.com>,
 linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: renesas: rz-du: mipi_dsi: Fix return path on error
Message-Id: <20260417145848.aae623dee5356ae715ea1faa@hugovil.com>
In-Reply-To: <20260417140231.3972749-1-chris.brandt@renesas.com>
References: <20260417140231.3972749-1-chris.brandt@renesas.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

Hi Chris,

On Fri, 17 Apr 2026 10:02:31 -0400
Chris Brandt <chris.brandt@renesas.com> wrote:

> In case of error, we should unwind correctly.
> 
> Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transfers")
> Suggested-by: Pavel Machek <pavel@nabladev.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 29f2b7d24fe5..92ea26ce723f 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1476,8 +1476,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
>  					       &dsi->dcs_buf_phys, GFP_KERNEL);
> -	if (!dsi->dcs_buf_virt)
> -		return -ENOMEM;
> +	if (!dsi->dcs_buf_virt) {
> +		ret = -ENOMEM;
> +		goto err_pm_disable;
> +	}
>  
>  	return 0;
>  
> -- 
> 2.52.0
> 
> 


-- 
Hugo Villeneuve
