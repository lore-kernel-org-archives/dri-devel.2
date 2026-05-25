Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC9ECD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 15:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3C510E39E;
	Mon, 25 May 2026 15:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="C5a1B+HY";
	dkim-atps=neutral
X-Greylist: delayed 1494 seconds by postgrey-1.36 at gabe;
 Mon, 25 May 2026 15:11:05 UTC
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDC810E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w/3hesROXh6QgRIYA4BX5lYaKo8hedo3oXUz/m/DUto=; b=C5a1B+HYRKthkXmsQLfGLJyNtX
 iVG9xweFadQIXbrXXU1Q0++Ay4aIxg0ezVZ/Rji3PdLitjFBYLmw2LPxU2XXpaxIVuObM/fzdBz1t
 WPkj5I+84guaUXT6OUHCVSnBUk7py5SPZimqXJ//CNb6ZLWKOww7gXrjElUBHljhHjSc=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1wRWZA-00000007I48-0ryI; Mon, 25 May 2026 17:46:04 +0300
Message-ID: <ace48664-cd7e-4cb8-8940-04ffe6f93e19@minlexx.ru>
Date: Mon, 25 May 2026 17:46:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Inline panel init
 sequences
To: Chintan Patel <chintanlike@gmail.com>, sumit.semwal@linaro.org,
 neil.armstrong@linaro.org
Cc: dianders@chromium.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260523035734.6602-1-chintanlike@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260523035734.6602-1-chintanlike@gmail.com>
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

On 23.05.2026 06:57, Chintan Patel wrote:
> Inline the panel initialization command sequences and remove the
> table-based command abstraction used by the NT36672A panel driver.
> 
> Replace the nt36672a_panel_cmd tables and nt36672a_send_cmds()
> helper with explicit initialization functions using
> mipi_dsi_dcs_write_seq_multi() and
> mipi_dsi_dcs_write_var_seq_multi() directly.
> 
> This improves readability by making the panel programming sequence
> explicit in code and allows future sharing of common command
> subsequences between panels. It also removes an unnecessary wrapper
> around the MIPI DSI helpers.
> 
> Additionally, compress repeated register writes into small loops where
> appropriate to reduce duplication in the initialization sequences.
> 
> Add:
> tianma_fhd_video_send_init_cmds_1()
> tianma_fhd_video_send_init_cmds_2()
> tianma_fhd_video_send_deinit_cmds()
> 
> Update nt36672a_panel_desc to use function pointers for panel init
> sequences and invoke them directly from prepare/unprepare paths.
> 
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v3:
> - Rename on_init_1/on_init_2/off_init to send_init_cmds_1/send_init_cmds_2/send_deinit_cmds
> - Convert all hex values to lowercase (0xFF → 0xff) per kernel coding standards
> 
> Changes in v2:
> - Replace command tables with explicit init functions
> - Remove nt36672a_send_cmds() helper entirely
> - Use mipi_dsi_dcs_write_seq_multi() directly
> - Use mipi_dsi_dcs_write_var_seq_multi() loops for repeated register writes
> - Convert nt36672a_panel_desc command table fields to function pointers
> ---
>   .../gpu/drm/panel/panel-novatek-nt36672a.c    | 522 +++++++-----------
>   1 file changed, 186 insertions(+), 336 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 7e8b5e059575..464d9ce47d87 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c

...

> @@ -162,8 +141,8 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
>   	dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
>   
>   	/* send first part of init cmds */
> -	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_1,
> -			   pinfo->desc->num_on_cmds_1);
> +	if (pinfo->desc->send_init_cmds_1)
> +		pinfo->desc->send_init_cmds_1(&dsi_ctx);
>   
>   	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   
> @@ -173,8 +152,8 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>   
>   	/* Send rest of the init cmds */
> -	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_2,
> -			   pinfo->desc->num_on_cmds_2);
> +	if (pinfo->desc->send_init_cmds_2)
> +		pinfo->desc->send_init_cmds_2(&dsi_ctx);
>   
>   	mipi_dsi_msleep(&dsi_ctx, 120);
>   

Hi!

Here, the split of panel init sequence into 2 separate functions _1 / _2
is completely artificial and completely unnecessary. For some unknown
reason the initial version of driver had initialization procedure cut in
2 parts on the boundary of exit_sleep_mode + set_display_on commands.

I think the whole init sequence should be glued together into one big
send_init_cmds() callback and have all these calls:

     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
     /* 0x46 = 70 ms delay */
     mipi_dsi_msleep(&dsi_ctx, 70);
     mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);


included in the middle. This opens up a possibility for other panels
based on nt36672a to be supported in this driver, which don't have the
init sequence split this way. The location of exit_sleep_mode and
set_display_on commands there is different. And, importantly, the delay
is different too.

I once did a very similar change to this driver [1] to add support for
more panels (ignore touchscreen changes there, look only at panel).
What is also important, that change was also tested on Xiaomi Poco F1
(xiaomi-beryllium) phone, which is the main user of this panel.
Unfortunately I never got to send it, even though I wanted to..

What do you think?

[1] https://gitlab.com/sdm845-mainline/linux/-/merge_requests/131

--
Regards,
Alexey Minnekhanov
