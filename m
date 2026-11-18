Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31D606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=iwSWi9dJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C2D10ECAE;
	Wed, 18 Nov 2026 21:11:35 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B61F10E831
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:11:29 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-86156cf8a7eso191205a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795036288; cv=none;
 d=google.com; s=arc-20260327;
 b=HiKsvlcd8RXCS8bAr0jF5oGr5KpP6vEpV2LzBYvLf1Bhps77BH807sXS8EfO5h5CL0
 6XclPBYPLQ6POoAvmGrAWnunBEyF/E98EF235rZQoTzVFIc7oSfND+Y51YKGaIYQUyKx
 d8gFmdMAS2tHiN4d7Y2kH2rsgHo+/6P9PHEZt+SFgG0T+uAazC+UKsteHqfBrY7XWA+9
 k9ab8g+YFmqlJoCTmcFOHf0Zr8IugtSiJFBdDYqaczdqc9Abe3tgxiZye7/M/Zo766nW
 lGa1/SGfhkGJYan33UVUwRVp0tmvqI+3EEQwfWJGOBRQ8FsTVBn9qgr0JAUd1VEmFSBe
 OFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wjl8QCeGjTXH4FsXdqCnkAKCMUVZVTA5duUIZqFFOEc=;
 fh=dQpkAxY2hJd5shkTGRXRkxhhEughLPKavVuP2YTVUvQ=;
 b=VAjGP/ihJVdgW0hImlFyKF7MWZNcDQoXShQ7mvzqSy6mb5dK5yOk7juIgOo3eb1K4j
 WBIYOEymvZGWuyIXGkS7bY2GwhmPv5fYCRYwoURKNzwHBUCE4eusO2e9u44hGP2ucHhb
 392QW2o00Nj9hysaHpKd+RgMD/g6zfqZJsx5cYZLAnJMKpMRciCAGU3oy1tEqm7+HkVs
 HHz1xh/uE81ILw7+YgWxTnFwHyocfY0WcxtVz8Y83rzM9rWSe9pXa1ylkSii7ZxoxW0T
 ZM04//s+4VERtwWSIAnaW+oEDc+0WQTlzEWwVdMDjAloCilY4v5ch0qpY2ZdCBykFuso
 uWQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1795036288; x=1795641088;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wjl8QCeGjTXH4FsXdqCnkAKCMUVZVTA5duUIZqFFOEc=;
 b=iwSWi9dJcidm0ytgqh4eFXlq2xn8fP1HlObnYCFKzYvO+F0fEkUuFaG5ENmYh2ToLS
 vwwWx8vVWX5lFKgvAuHbN+8Qs1sAvsdoR7FBSBiJo5I+rmBZbfRxlqSaoTNmGWpYEot3
 njkNKv+mOMK4XEMNOsBIa3pTXiV9PJUD84nbN5Uuk5R1XaFsAmyvfsLPkxFlhK/4RkTT
 dGrRIL9j95u3w8r0t/ot3caryArtlaU+oxsGkvZmq92egUHEceSYemhRAWoZWw6NLzKw
 7rwa3zgbRJoKVKGx/yIqUD1HL1d5QDd5VTrhNkz7nC7UmpmqtBZ8dzs3ir3unxynjJtZ
 T0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795036288; x=1795641088;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wjl8QCeGjTXH4FsXdqCnkAKCMUVZVTA5duUIZqFFOEc=;
 b=Usc6/Jkq9fdUy7UXJ+vkKdLDfojtuVwo0pOJ781jYVa9yqTfOGjmnbsFnUDVmxgF9y
 I5hFxGZhFt1O8vbc27a74CQf40Vgzpd5PV/dJ5xqJZ0Nk+zzM4tXITgx9eF8ZHWL6pcz
 eEPCTS62A5xAVqVjcMyZYfsSoU8brFI5j+zDvV87thRcAwrR/eNN2Dvm+5Smn1CG3Pnr
 MbqbzxkrEYjd3mBlWY/d57hn/etmgjp9IQ9JVrtA85MwaXPntO6AtF6NPU+UXh8LLPtP
 fpBh2QGxoeQFRwOidV4PaFzqgIUiYjY8cjG3+CDNtPJvLxet1GGdnc0Z9PtNUIvJfnEV
 wcoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGCLjv/EktyVvH1fyp/yO50K4yGrkV6ugDkgDNI0dBiReReG7b3lcpGxZ1l4wG9vtMe+R9CcLLp75E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+nAu6Oh/5PepfybK9qAc0VmrFpfrfF9u4Zth2VcE/fu5lCGK0D
 aWMCuZWAZ+ohzEQysB4CUh56vrc/kSMDDi7mPPOobqB6Bab6onntQJDI+TYvh2UBzUV0gGEcy2D
 SeCFLTiwl7JGUFDznu0zuApkpJsW1LRKdxb8H5f3e4A==
X-Gm-Gg: AYBFou1rDNoaRBEgdth6mwbGlcIBQA8mZd/hEjCSRk+u9LmNDYT109LUDW0gvczKU7u
 RIfttaGCTtx+cK47NwvPYWutLGr9F8y+MYkG3GCXgcriMB8gy/y6mlEQilg8eDlUDuRHovf0Zjt
 3ZHGAsJOloYU5+HwE1hNXdN+zY5oD2AfHAXRnMSzVR/VzQ9YOK16SlSM7ch10Kqy46oASL+Vr1m
 KWiXe+n+EVxC2rHH4Y7dmWuXk5r5v/3ktuYwjfjs91S80b14JrZDoIov/+ErDT7XqG3b4AYDRL0
 Rn+ANc644cOt3a2rVW+JNppQelBsPprLIALOO4JY8lGF2RQQUwF1fh83ZFYhCZTCeSG84TW3+82
 OvnK+8azSSCH98TP5zpXauWU9ekMLS8TqWCg9ZS9aL+y/kBSezgpsweR4o80f6YWJOtjbg133O9
 4oll/99AI/oh4410nFWQFwlNvD2YVLGU6giH8NQ5ltqwsC
X-Received: by 2002:a05:6820:1628:b0:71a:f064:8b06 with SMTP id
 006d021491bc7-71b2a80c0cbmr534052eaf.69.1795036288307; Wed, 18 Nov 2026
 13:11:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-6-henryzhang62@gmail.com>
In-Reply-To: <20261028164539.3471833-6-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 18 Nov 2026 21:11:10 +0000
X-Gm-Features: Aa3M54ppFeoIveUP9gXLzY6cqQDP_Zvlx1z-dyeMZe7MZBe2a_LvWX7OIrzJTkU
Message-ID: <CAPY8ntD7UqYwGfSOp4XW5V6574e7o_bq_hnzNfVoq8y92-3awA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/vc4: dsi: Recover from a timed-out transfer
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
> When a transfer times out, vc4_dsi_host_transfer() disables the
> command, resets the FIFOs and returns -ETIMEDOUT. That is not always
> enough: after an LP receive timeout during a read (the peripheral did
> not complete the bus turnaround), every following transfer times out
> as well, with no interrupt and STAT reading back 0. Only a modeset,
> which goes through post_disable/pre_enable, brings the block back.
>
> Reset the DSI block and its analog front end after a timeout and restore
> the configuration programmed in pre_enable, in the same order as
> pre_enable: the block is ungated and the AFE released only after the
> timings are programmed. Keep the interrupt handler out with
> disable_irq() until the block is restored and INT_STAT is cleared, so
> that neither a late completion interrupt of the timed-out transfer nor
> an error interrupt raised during the reset can complete the next
> transfer or run in the middle of the reset. Also mask the interrupts
> until the AFE is out of reset: the error interrupts otherwise fire
> continuously while it is held in reset. The timed-out message is not
> resent, as it may already have been executed by the peripheral; the
> error is returned and the caller decides whether to retry.
>
> Only do this while the block is enabled. Between post_disable and
> pre_enable the clocks are off and there is nothing to restore; a
> transfer then times out as before. The transfer lock keeps the
> recovery from running in the middle of pre_enable or post_disable.
>
> This does not prevent the timeouts themselves. With video running,
> vc4 does not keep commands within vertical blanking, and transfers can
> still time out, sometimes several in a row after a reset. That is a
> separate issue.

Whilst it's a belt and braces approach to work around the issue, I'll
have a dig next week to see if I can reproduce it and see what is
going on.
There are very few use cases that have a need for sending DCS commands
whilst transmitting video, so it's a bit niche. The reset stopping
video isn't nice although I guess it should be fairly brief.

  Dave

> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 136 ++++++++++++++++++++++++++++++++--
>  1 file changed, 129 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 3ee6e8e86..6edda74e1 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -601,8 +601,11 @@ struct vc4_dsi {
>          * bridge enable/disable paths, which reprogram the block.
>          */
>         struct mutex transfer_lock;
> +       /* The block is powered and configured. Protected by transfer_lock. */
> +       bool enabled;
>         struct completion xfer_completion;
>         int xfer_result;
> +       int irq;
>
>         struct debugfs_regset32 regset;
>  };
> @@ -826,6 +829,8 @@ static void vc4_dsi_bridge_post_disable(struct drm_bridge *bridge,
>
>         guard(mutex)(&dsi->transfer_lock);
>
> +       dsi->enabled = false;
> +
>         clk_disable_unprepare(dsi->pll_phy_clock);
>         clk_disable_unprepare(dsi->escape_clock);
>         clk_disable_unprepare(dsi->pixel_clock);
> @@ -1151,6 +1156,8 @@ static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
>                 DSI_PORT_WRITE(DISP0_CTRL,
>                                DSI_DISP0_COMMAND_MODE);
>         }
> +
> +       dsi->enabled = true;
>  }
>
>  static void vc4_dsi_bridge_enable(struct drm_bridge *bridge,
> @@ -1184,10 +1191,9 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
>                                  &dsi->bridge, flags);
>  }
>
> -static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
> -                                    const struct mipi_dsi_msg *msg)
> +static ssize_t vc4_dsi_transfer(struct vc4_dsi *dsi,
> +                               const struct mipi_dsi_msg *msg)
>  {
> -       struct vc4_dsi *dsi = host_to_dsi(host);
>         struct drm_device *drm = dsi->bridge.dev;
>         struct mipi_dsi_packet packet;
>         u32 pkth = 0, pktc = 0;
> @@ -1195,8 +1201,6 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>         bool is_long = mipi_dsi_packet_format_is_long(msg->type);
>         u32 cmd_fifo_len = 0, pix_fifo_len = 0;
>
> -       guard(mutex)(&dsi->transfer_lock);
> -
>         mipi_dsi_create_packet(&packet, msg);
>
>         pkth |= VC4_SET_FIELD(packet.header[0], DSI_TXPKT1H_BC_DT);
> @@ -1374,6 +1378,120 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>         return ret;
>  }
>
> +/*
> + * Reset the DSI block and its analog front end, then restore the
> + * configuration done in pre_enable. Resetting the FIFOs alone does not
> + * clear the state the block can be left in after a transfer timed out
> + * (e.g. on an LP receive timeout): every following transfer then times
> + * out as well, until the next modeset.
> + */
> +static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)
> +{
> +       u32 en = dsi->variant->port ? DSI1_CTRL_EN : DSI0_CTRL_CTRL0;
> +       u32 ctrl = DSI_PORT_READ(CTRL);
> +       u32 afec0 = DSI_PORT_READ(PHY_AFEC0);
> +       u32 afec1 = DSI_PORT_READ(PHY_AFEC1);
> +       u32 disp0 = DSI_PORT_READ(DISP0_CTRL) & ~DSI_DISP0_ENABLE;
> +       u32 disp1 = DSI_PORT_READ(DISP1_CTRL);
> +       u32 hstx_to = DSI_PORT_READ(HSTX_TO_CNT);
> +       u32 lprx_to = DSI_PORT_READ(LPRX_TO_CNT);
> +       u32 ta_to = DSI_PORT_READ(TA_TO_CNT);
> +       u32 pr_to = DSI_PORT_READ(PR_TO_CNT);
> +       u32 phyc = DSI_PORT_READ(PHYC);
> +       u32 clt0 = DSI_PORT_READ(HS_CLT0);
> +       u32 clt1 = DSI_PORT_READ(HS_CLT1);
> +       u32 clt2 = DSI_PORT_READ(HS_CLT2);
> +       u32 dlt3 = DSI_PORT_READ(HS_DLT3);
> +       u32 dlt4 = DSI_PORT_READ(HS_DLT4);
> +       u32 dlt5 = DSI_PORT_READ(HS_DLT5);
> +       u32 dlt6 = DSI_PORT_READ(HS_DLT6);
> +       u32 dlt7 = DSI_PORT_READ(HS_DLT7);
> +
> +       /*
> +        * Mask the interrupts while the block and its AFE are in reset: the
> +        * error interrupts would otherwise fire continuously.
> +        */
> +       DSI_PORT_WRITE(INT_EN, 0);
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0);
> +       DSI_PORT_WRITE(TXPKT1C, 0);
> +       DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |
> +                      DSI_PORT_BIT(CTRL_RESET_FIFOS));
> +       DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(PHY_AFEC0_RESET));
> +       /* AFEC reset hold time */
> +       mdelay(1);
> +
> +       /*
> +        * Same order as pre_enable: the block stays gated and the AFE in
> +        * reset until the timings are programmed.
> +        */
> +       DSI_PORT_WRITE(CTRL, ctrl & ~(DSI_CTRL_CAL_BYTE | en));
> +       DSI_PORT_WRITE(STAT, DSI_PORT_READ(STAT));
> +       DSI_PORT_WRITE(PHY_AFEC1, afec1);
> +       DSI_PORT_WRITE(HS_CLT0, clt0);
> +       DSI_PORT_WRITE(HS_CLT1, clt1);
> +       DSI_PORT_WRITE(HS_CLT2, clt2);
> +       DSI_PORT_WRITE(HS_DLT3, dlt3);
> +       DSI_PORT_WRITE(HS_DLT4, dlt4);
> +       DSI_PORT_WRITE(HS_DLT5, dlt5);
> +       DSI_PORT_WRITE(HS_DLT6, dlt6);
> +       DSI_PORT_WRITE(HS_DLT7, dlt7);
> +       DSI_PORT_WRITE(PHYC, phyc);
> +       DSI_PORT_WRITE(CTRL, ctrl & ~en);
> +       DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
> +       DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);
> +       DSI_PORT_WRITE(TA_TO_CNT, ta_to);
> +       DSI_PORT_WRITE(PR_TO_CNT, pr_to);
> +       DSI_PORT_WRITE(DISP1_CTRL, disp1);
> +       /* Ungate the block. */
> +       DSI_PORT_WRITE(CTRL, ctrl);
> +       /* Bring AFE out of reset. */
> +       DSI_PORT_WRITE(PHY_AFEC0, afec0 & ~DSI_PORT_BIT(PHY_AFEC0_RESET));
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0);
> +
> +       DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
> +       DSI_PORT_WRITE(INT_EN, DSI_PORT_BIT(INTERRUPTS_ALWAYS_ENABLED));
> +}
> +
> +static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
> +                                    const struct mipi_dsi_msg *msg)
> +{
> +       struct vc4_dsi *dsi = host_to_dsi(host);
> +       u32 disp0_ctrl;
> +       ssize_t ret;
> +
> +       guard(mutex)(&dsi->transfer_lock);
> +
> +       ret = vc4_dsi_transfer(dsi, msg);
> +       /* Only a running block can be reset and restored. */
> +       if (ret != -ETIMEDOUT || !dsi->enabled)
> +               return ret;
> +
> +       /*
> +        * Leave the block usable for the next transfer. The message is not
> +        * resent: it may already have reached the peripheral, and only the
> +        * caller knows whether it is safe to repeat.
> +        */
> +       disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
> +       dev_warn(&dsi->pdev->dev,
> +                "transfer timed out (stat 0x%08x), resetting DSI\n",
> +                DSI_PORT_READ(STAT));
> +       /*
> +        * Keep the interrupt handler out until the block is restored and
> +        * INT_STAT is cleared. The error interrupts are still enabled, and
> +        * a handler running during the reset could complete the next
> +        * transfer, or race with the register writes on DSI1 of the
> +        * BCM2835, where both go through the DMA workaround. disable_irq()
> +        * also waits for a late completion interrupt of the timed-out
> +        * transfer.
> +        */
> +       disable_irq(dsi->irq);
> +       vc4_dsi_reset_and_restore(dsi);
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> +       enable_irq(dsi->irq);
> +
> +       return ret;
> +}
> +
>  static const struct component_ops vc4_dsi_ops;
>  static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
>                                struct mipi_dsi_device *device)
> @@ -1743,14 +1861,18 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>         /* Clear any existing interrupt state. */
>         DSI_PORT_WRITE(INT_STAT, DSI_PORT_READ(INT_STAT));
>
> +       dsi->irq = platform_get_irq(pdev, 0);
> +       if (dsi->irq < 0)
> +               return dsi->irq;
> +
>         if (dsi->reg_dma_mem)
> -               ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
> +               ret = devm_request_threaded_irq(dev, dsi->irq,
>                                                 vc4_dsi_irq_defer_to_thread_handler,
>                                                 vc4_dsi_irq_handler,
>                                                 IRQF_ONESHOT,
>                                                 "vc4 dsi", dsi);
>         else
> -               ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
> +               ret = devm_request_irq(dev, dsi->irq,
>                                        vc4_dsi_irq_handler, 0, "vc4 dsi", dsi);
>         if (ret) {
>                 if (ret != -EPROBE_DEFER)
> --
> 2.47.3
>
