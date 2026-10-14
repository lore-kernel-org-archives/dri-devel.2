Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E39BCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268B6112190;
	Thu, 15 Oct 2026 07:57:19 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724AC10E472
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:55:39 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-33c2520ad38so9757705eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791993339; cv=none;
 d=google.com; s=arc-20260327;
 b=J4z6PtODnhIQRvWYpDVZTypFBqksSvSqsWQHezeS9LAgsJV2gl5P9VcZapdaJfwWDT
 YH2xYtBqM869ANRfm9IxtdmAL7mBIe15WTFKh0xJEW1T5a2axHRPye1dcgYA/R+YHjSb
 iXPZXH8a86QU+zz28NZ89YuvYi8kbfLufKZ7NNNPlxI+23NUoUr5dB8Pde+vlOAbXoqB
 7efd7ACBbzThdaIH8+VEwi4leJ9Qoygk1D0lchh0Txfm6JjL9PFi4fJlPNKNiqZ11GEg
 zuUbg5NKqYkQHJgie4H5BeJtfe6k0usHulItL+NrPSLYThdCxuQplnOubWkSBYNdZD1F
 kCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2XXdOgd3LhsMPgu7e26Zyz/aXhCrCbllsm1LzmgfNuM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=nR53X3pXodPTt82A17v5DPY8hJtfrKP7JomBpq230bhUobtRSKsmm4tmg8cfnYceUA
 mWpi8hBqdIIxJ5TzMz715zf5UsBTKIBz4HBLIpFk5AfKqRn3kbw7F4TeNtlddDxZDoXc
 O8Rp6iMb4VtT166OC2vizOyDXR83WxjBx/sQfHALBPb3WOK190zXbDNm9CZuc/AIigVC
 TCTXnyM5cBRJfK5e7ytupvN9HIl1bxhRiJJmTEkel2dpJHaNmHSIhdPF0zAzTWECBDY0
 9IEO4bWRxpq9dZGfH45nruQAyQCD0wii8oUBDIEHZEZo8hKWMslDN73Cr8MmeDaUTSJu
 HIbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791993339; x=1792598139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2XXdOgd3LhsMPgu7e26Zyz/aXhCrCbllsm1LzmgfNuM=;
 b=iV+ncuxQM9C4O1OoWpdOX+KoY0I2m1vI18YkHPVw5n2/CFLL7pevE0je1eC6O4KEI/
 wJZKMFw7w4vKg6j7hRx335UinTHoq/u6XLNSqOXB7qwkdRg1PjGjvCamW5XrjijePwGB
 dB/owNwipbk7+y+HZPN1xbQ9vcf53GGIvtIlqrW+VRPGfj0m9e1F23adVpTZWY5IO10m
 U7dk2HYCT/fzDi36RAE38VOfDuBW9bpPkAeub2xZmbSbD5Mw5Ycrjr6ggQN5l4uSd7aM
 9WACrg3a1e3MV40w1vp5a+PKM6ve7QHlMq4PO/RNYbawqMMlBOVUP3sqA9lhq0L4uL39
 pRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791993339; x=1792598139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2XXdOgd3LhsMPgu7e26Zyz/aXhCrCbllsm1LzmgfNuM=;
 b=Joi+ePpoTrV098n6u5Ay9gCNl9TZcGz0Qw353P3RZZpcLhz9ThXrLpdMUmW8uHNzCc
 45A5UWbMvEYrSbvgB7l6Crlo5i1THDbLLw+ZkSTm9tnZB28QaEZzR0Y9env/0XN/t/62
 uHdVycWBFjtSN7waKj6QkGDkOYgRcoT2Aq0S+gzOq73p8muoJpjuK4QYOj/TzBoFFzM+
 5gLfWtCL+mFWmPHSqSW1gO7BcZZgSIY6rMlsk7z7JT8rs45YOo1j1Xa7d5UFwFw0nExw
 jh7ITpMQ9IUphULNkGAMoF6ILJs0ySfTiEw6H3VrPaq/uhmHEmKGxxm3rO5T4KfEF2Qn
 ey2A==
X-Gm-Message-State: AFq9FYLLldPtdxlhSPd13gcW5O1RALLPzoH/E6wcLpWy50O8+U3kuQDn
 ewQNH9ghsI7aE/90fwQ+HvbCpIiA+Nu4TtbLudJwTCUlmWy28Qyb1PnHvM/rLB8lbeNHRf2bTny
 gWXsX7od8doOZZerHv+4wRkjGlXmoIGFsYm/2
X-Gm-Gg: AYBFou1JBkI/MHQpBHw0qjjaE5l3E/qaPd82oWx6N/9RwDGXTfgSlDWzq6cdxGiVrrt
 nVjuXPRlXT3tDFDp5OXSfZouMtcTNdcveHUpR/TU0G47JTnmGOtC2tZQ4Fc2VAQwFa1toJQp3b0
 lzMG/ukABVdSp7B9wQ6qpUv01R/oTwBj8HYqzCLAF6eXP9kmCN5VEbV9U6WNi3CPtpECnBuKFXo
 ZQBe7YSsiaeZzNXz1ruJsXKkNxZSjg0qFXBszY2VIWF+LlEX/lOGz/xjYpyKhsoHSIDjurZpebg
 TlXmUSOuIOxFW2oV0d73g9nF6B2fGboNLS9IyN/sgsD1i+hDKsSmySzunQ==
X-Received: by 2002:a05:7300:f582:b0:353:5ae1:b0f5 with SMTP id
 5a478bee46e88-3537e101bf0mr22008049eec.26.1791993338445; Wed, 14 Oct 2026
 08:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261012190249.3167-1-henryzhang62@gmail.com>
 <20261012190249.3167-3-henryzhang62@gmail.com>
 <sashiko-outbox-168575@kernel.org>
In-Reply-To: <sashiko-outbox-168575@kernel.org>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Wed, 14 Oct 2026 08:55:27 -0700
X-Gm-Features: AclHuK_eh9bczZI4ebGr5UhWIqsDinkzAv7SQWdD090e4uC4ltYZQMFfxCEVzUk
Message-ID: <CANTW0yoUt9v5xgMQxRWdOGyWVxTW0x_o1=qwuLPjSCDq_DkkUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vc4: dsi: Recover from a timed-out transfer
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On Mon, Oct 12, 2026 at 12:16=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] drm/vc4: dsi: premature controller enable during timeout reset c=
auses hardware instability
> - [High] drm/vc4: dsi: spurious completion due to IRQ handler TOCTOU race
> - [Medium] drm/vc4: missing mutex serialization in DSI host transfer
> --
Thanks for the review.

1. Agreed. Mainline's pre_enable ungates the block only after the PHY
   timings, timeouts and DISP1 are programmed; the restore must follow
   the same order. Will fix in v2.
2. Agreed. The race predates this patch, but the timeout path is the
   right place to close it; v2 will call synchronize_irq() before the
   reset.
3. vc4_dsi_host_transfer() has never serialized transfers. I'll add a
   separate patch in v2 that takes a mutex around host transfers.

Henry

> commit b73bc40cfc01c81e251315be152ff0c2c6aa9361
> Author: Henry Zhang <henryzhang62@gmail.com>
>
> drm/vc4: dsi: Recover from a timed-out transfer
>
> When a transfer times out, vc4_dsi_host_transfer() disables the command,
> resets the FIFOs and returns -ETIMEDOUT. This commit adds a recovery
> mechanism that resets the DSI block and its analog front end after a
> timeout and restores the configuration so DSI keeps working without a
> modeset.
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.=
c
> index c092a1aaf700a..3783ff3eeac97 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> [ ... ]
> @@ -1359,6 +1358,93 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_d=
si_host *host,
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
> +       u32 ctrl =3D DSI_PORT_READ(CTRL);
> +       u32 afec0 =3D DSI_PORT_READ(PHY_AFEC0);
> [ ... ]
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0);
> +       DSI_PORT_WRITE(TXPKT1C, 0);
> +       DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |
> +                      DSI_PORT_BIT(CTRL_RESET_FIFOS));
> +       DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(PHY_AFEC0_RESET));
> +       /* AFEC reset hold time */
> +       mdelay(1);
> +
> +       DSI_PORT_WRITE(CTRL, ctrl & ~DSI_CTRL_CAL_BYTE);
> +       DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
> +       DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);
>
> [Severity: High]
> Can writing ctrl & ~DSI_CTRL_CAL_BYTE back to CTRL prematurely un-gate an=
d
> enable the controller before the subsequent writes to timing and PHY
> configuration registers?
>
> Since ctrl was read while a transfer was in progress, it contains the ena=
ble
> bit (DSI0_CTRL_CTRL0 or DSI1_CTRL_EN).
>
> Writing it back here enables the hardware block before its timings
> (HSTX_TO_CNT, HS_CLT0, PHYC, etc.) are restored, which could cause errati=
c bus
> behavior and unrecoverable hardware states.
>
> > +     DSI_PORT_WRITE(TA_TO_CNT, ta_to);
> [ ... ]
> +static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
> +                                    const struct mipi_dsi_msg *msg)
> +{
> +       struct vc4_dsi *dsi =3D host_to_dsi(host);
> +       u32 disp0_ctrl;
> +       ssize_t ret;
> +
> +       ret =3D vc4_dsi_transfer(dsi, msg);
>
> [Severity: Medium]
> Does this entry point need a mutex to serialize concurrent transfers?
>
> If user-space concurrently triggers DCS commands (e.g., via sysfs backlig=
ht
> updates and DRM KMS modesets), they can race because vc4_dsi_transfer()
> modifies shared variables like dsi->xfer_completion without a lock.
>
> With this patch, a timeout caused by such a race now triggers a full bloc=
k
> reset in vc4_dsi_reset_and_restore(), disrupting any interleaved concurre=
nt
> transfer.
>
> +       if (ret !=3D -ETIMEDOUT)
> +               return ret;
> +
> +       /*
> +        * Leave the block usable for the next transfer. The message is n=
ot
> +        * resent: it may already have reached the peripheral, and only t=
he
> +        * caller knows whether it is safe to repeat.
> +        */
> +       disp0_ctrl =3D DSI_PORT_READ(DISP0_CTRL);
> +       dev_warn(&dsi->pdev->dev,
> +                "transfer timed out (stat 0x%08x), resetting DSI\n",
> +                DSI_PORT_READ(STAT));
> +       vc4_dsi_reset_and_restore(dsi);
> +       DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
> +
> +       return ret;
> +}
>
> [Severity: High]
> Can a timed-out transfer cause a spurious completion of a subsequent tran=
sfer?
>
> If vc4_dsi_transfer() times out, wait_for_completion_timeout() returns.
> However, if the hardware interrupt had fired and the threaded IRQ handler
> (vc4_dsi_irq_handler) was preempted before calling
> complete(&dsi->xfer_completion), it could still be pending.
>
> Since there is no synchronization (like synchronize_irq()) in this timeou=
t
> recovery path to wait for the IRQ handler to finish, it returns immediate=
ly.
>
> The caller might retry the transfer, reinitializing dsi->xfer_completion.=
 The
> preempted IRQ thread could then resume, calling complete() and falsely wa=
king up
> the new transfer prematurely while the hardware is still busy.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012190249.31=
67-1-henryzhang62@gmail.com?part=3D2
