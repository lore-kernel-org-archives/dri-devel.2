Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB1606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=a+s9XuSs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F5110FF59;
	Wed, 18 Nov 2026 18:43:10 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C488610FF46
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:43:04 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6b19e291cc6so1139273eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795027384; cv=none;
 d=google.com; s=arc-20260327;
 b=qupSzHidfVSwxltGYLtZRp28LJ+qRPu/op3uAmd15/HhaIou2RzMdsCatKDlu60qnf
 yx6O8eZ5cPH4ewh7Yw4raGJq+qzXQS8BVwQwAms+G3QiAYJkTNf2OkISzCK+Pzq8rxN0
 mjLiDlCuzpImY70+1Ln2xW2zmHLeELVbIEcye0xcPxIEZB4GZj/Ly0ayuMaOGZ3MkWZt
 4i8RhHQjm/ySnXLJHJNK9VCpDnOAuZb7j+OVntNdqPCINrNV7OJBbOA1RIE2Ri3bOwKd
 RaP3yU4BZQRk3iI9bVGE6aqNLrAhrrzVbQVr/UTaBMXlaKgDLDWh78mvOhtv49t2T1Rk
 GEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EcjARjGr/IicDiXvqUvCDlSEccrqjBL8eJv0mQLCiyE=;
 fh=XOlYPM6X8cGqNrS5ew+pse7JpQVMVtR/XIRQsXXNSTU=;
 b=IdqAUDYEGq2aETmE5CNzJHQjB3OYb4VMRaZpzyJ2LUg84tsjtTCEe1WpkYoI1HiCc7
 9e7efhk9yPhNTCWjGKpRLBrc4HIdq2e77+5UgTiKLB+nIHya8a1pOZUa59rKLOnk90jq
 ixBP66Cl9+/azIUSayym4qN/A3vKk2CbikSmQbxFCDCVBPwlK1Ho+VcKcOnfpQDEx8WF
 hFYfcLWbf4XqJRkEgJkTnsxFccYazGPEulodqV9iErGdY7Dy1Ev8rb8oPqRm3xh4LrOM
 vJL//uH4yfo6oL9T3N5qA0vA3mlYosgOCSgGm3SzkiJ0OqvCMc+b8xzaTtJBtcGLC7aa
 kTjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1795027384; x=1795632184;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EcjARjGr/IicDiXvqUvCDlSEccrqjBL8eJv0mQLCiyE=;
 b=a+s9XuSsQgOPguYRX+h8YT8hnolEEvGcWMTD8aC75n3jVDcHPFUnAhUJi/e8+f/9cT
 CZAxBgMlQS3ewiPida7HQy8+UF63d5/CCg1d8cRnraPtGkIZoNYPDxAOTWZ5ylUR3br9
 i5zTkYakgMnO6O2Xee3oSNSHcG79N9faa/2Siu89N8tFiu6fthC2/Tpmlo8EaTpBFgyB
 ZWngQF5vyqX7yV05ngUB5RFdYH3C8wijzLTdWuKmh238lItrsIbVp8Kt4WrHrHqv0ZN1
 0Ybz64myJDpORbNdriqCS3e3JT0qc8M+m6CcTzkUb5mq7EwLUMMMcPeTmWBR8eHOdt0H
 6SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027384; x=1795632184;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EcjARjGr/IicDiXvqUvCDlSEccrqjBL8eJv0mQLCiyE=;
 b=BdYnx1pzIPh5CVCjPiIAvJXc08DmDRd8AVkBuewsZukdWnUIAl2AYGl6J9j7q7I4np
 LwBX3e9qYsJvYjRyLzcGiObMwbCL0YcXhHPlLceO2ADWj5Zied9Wp+g9npEK8uwu+18G
 Icovk4r2SbOcQOpAzQpW07Vfr9rXlbCUggnG5R5jsicHTyPT02vM9TAML+18nuFjp6GD
 0TbCACGBH45x3I7ZsQjxMIdAdwIgfO0yhmX7BJuWnoqGLMy2QI5BeHc8BctgclA2nQP5
 s64G1LogkY4iGURInlbx1fRvGlBLINmlvS1ReuMRDZSPj1d9uje5QnHllAhAs+E1Gp3i
 A+lw==
X-Forwarded-Encrypted: i=1;
 AL+hErGn18lCtGvSZUnINiYlOQetpy45x3USqHcElcLIeQDeJO/wyAzTg4C1rjNbZNScHhQtlbkQAx9yX4E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Y6VkPry9wG86TpVvzIeZ0I9bK02KWsQwwwlUppr1MSbwGKUR1
 HZozahXFx5+FM9xSaU/It/1sDBWTxHgsKG++9JmobUhh9xaJzBUe2Vgespb1j+fuBaRujJc/cdm
 vpGp2bSntOeOIcnih2oJiMoa3xlbg9xJ2OFc2CxVx2A==
X-Gm-Gg: AYBFou12lUR6XFgXo28gNNbVaK1+m1w2iT/FX0VVT/jEnfQBYRxrhGANap5zJyW3tGu
 rbEjryKuSlGN84EbbGn2bHPVb1HGfCszJWqbEDVwJjexZfC2QqsuKXBDl+FjgLy5sKCQZrTaTFz
 zdR4SHzhxZANwbwg7pMh9NudLkKwm5Ckp709Ol6YBSG0rk1db2XhJqq+8RjTMGO26sxSwHFVVd6
 fBvjPdGVwNIPzEujP6/XWsRD8mxZaZLp+5+F/QJgIlnsURumxrkwwPC37zPgaK8Ae4gzTzPE6VS
 jxO9iNbLLVsbJksZkPR4Mnl7sKFxyNwqMAB338CiqB/APxhgROEvC8deGK2d5offm1h2O9VQn/b
 9u8YGbbL+prM9aXeDZ/JAT3kHsGuAUxsdSul1N5ccIYOAUEz9fCEClIdACCSq0JxqLDxqufl9B1
 VAQ+lRqqb5IKwPTwrOI3ONNE7qXsaygMaGtngioxqLfCsApjltdPLDCQ==
X-Received: by 2002:a05:6820:a789:b0:702:dd8d:316e with SMTP id
 006d021491bc7-71b18567b6emr1905469eaf.25.1795027383749; Wed, 18 Nov 2026
 10:43:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-5-henryzhang62@gmail.com>
In-Reply-To: <20261028164539.3471833-5-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 18 Nov 2026 18:42:47 +0000
X-Gm-Features: AclHuK_8CSqY4sWJhVcrZV2Foot33L1p_hxdBf1gCfb__EBplFVm726JFlspi5I
Message-ID: <CAPY8ntAXPpJbid2LXc6r0g-sr95uQ3hckxVqa09qPNMi5JSp6g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/vc4: dsi: Serialize host transfers
To: Henry Zhang <henryzhang62@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Henry

On Wed, 28 Oct 2026 at 16:46, Henry Zhang <henryzhang62@gmail.com> wrote:
>
> vc4_dsi_host_transfer() fills the command FIFOs and the TXPKT registers
> and waits on a single completion without any locking. Two callers
> sending at the same time, for example a panel driver and a backlight
> update, can overwrite each other's packets. Nothing keeps a transfer
> from running while the bridge callbacks reprogram the block either,
> for example while pre_enable sets up the PHY timings.
>
> Add a mutex and hold it for the whole host transfer and in the bridge
> pre_enable, enable, disable and post_disable callbacks. None of these
> callbacks calls into the DSI device, so the lock is never taken
> recursively.

I'll agree that there's an issue, but as it will affect all DSI host
controllers it feels like it should be handled centrally in the core
mipi_dsi_device_transfer rather in all the drivers.

One for the core DRM maintainers to comment on. A quick check says it
would affect at least vc4_dsi, mtk_dsi, mcde_dsi, and cdns-dsi-core.

And your use case is genuine as panel-jdi-lt070me050000.c does exactly
what you describe with the backlight functions are controlled via DCS
commands. It would take quite exact timings to update the backlight
from userspace at the same time it sends the power on init sequence
though.

> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index be9caaf50..3ee6e8e86 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -25,6 +25,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -595,6 +596,11 @@ struct vc4_dsi {
>          */
>         struct clk *pixel_clock;
>
> +       /*
> +        * Serializes host transfers against each other and against the
> +        * bridge enable/disable paths, which reprogram the block.
> +        */
> +       struct mutex transfer_lock;
>         struct completion xfer_completion;
>         int xfer_result;
>
> @@ -805,6 +811,8 @@ static void vc4_dsi_bridge_disable(struct drm_bridge *bridge,
>         struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>         u32 disp0_ctrl;
>
> +       guard(mutex)(&dsi->transfer_lock);

Do we need to take the mutex in any of these functions except
vc4_dsi_host_transfer?
This driver will misbehave if you request a host transfer before
pre_enable or after post_disable. It's been on my list for a while to
look into that one.
But I don't believe there is anything in these functions that would
interrupt a transfer, hence they wouldn't need the mutex.

  Dave

> +
>         disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
>         disp0_ctrl &= ~DSI_DISP0_ENABLE;
>         DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> @@ -816,6 +824,8 @@ static void vc4_dsi_bridge_post_disable(struct drm_bridge *bridge,
>         struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>         struct device *dev = &dsi->pdev->dev;
>
> +       guard(mutex)(&dsi->transfer_lock);
> +
>         clk_disable_unprepare(dsi->pll_phy_clock);
>         clk_disable_unprepare(dsi->escape_clock);
>         clk_disable_unprepare(dsi->pixel_clock);
> @@ -891,6 +901,8 @@ static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
>         unsigned long phy_clock;
>         int ret;
>
> +       guard(mutex)(&dsi->transfer_lock);
> +
>         ret = pm_runtime_resume_and_get(dev);
>         if (ret) {
>                 drm_err(bridge->dev, "Failed to runtime PM enable on DSI%d\n", dsi->variant->port);
> @@ -1148,6 +1160,8 @@ static void vc4_dsi_bridge_enable(struct drm_bridge *bridge,
>         bool debug_dump_regs = false;
>         u32 disp0_ctrl;
>
> +       guard(mutex)(&dsi->transfer_lock);
> +
>         disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
>         disp0_ctrl |= DSI_DISP0_ENABLE;
>         DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> @@ -1181,6 +1195,8 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>         bool is_long = mipi_dsi_packet_format_is_long(msg->type);
>         u32 cmd_fifo_len = 0, pix_fifo_len = 0;
>
> +       guard(mutex)(&dsi->transfer_lock);
> +
>         mipi_dsi_create_packet(&packet, msg);
>
>         pkth |= VC4_SET_FIELD(packet.header[0], DSI_TXPKT1H_BC_DT);
> @@ -1807,6 +1823,7 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct vc4_dsi *dsi;
> +       int ret;
>
>         dsi = devm_drm_bridge_alloc(&pdev->dev, struct vc4_dsi, bridge, &vc4_dsi_bridge_funcs);
>         if (IS_ERR(dsi))
> @@ -1814,6 +1831,9 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>         dev_set_drvdata(dev, dsi);
>
>         dsi->pdev = pdev;
> +       ret = devm_mutex_init(dev, &dsi->transfer_lock);
> +       if (ret)
> +               return ret;
>  #ifdef CONFIG_OF
>         dsi->bridge.of_node = dev->of_node;
>  #endif
> --
> 2.47.3
>
