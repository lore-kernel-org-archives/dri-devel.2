Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78B606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=PQMZtNqw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0A910E313;
	Mon, 26 Oct 2026 18:13:43 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE9610E313
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:13:37 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-844a8bf7e25so2339793a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038416; cv=none;
 d=google.com; s=arc-20260327;
 b=qmGHStMTyO5XwdvMWbvfmeeaiP+Yg/aSipwkF3YZHDCnpBto21OPni5L2RgSGOPXMI
 tiPvpE+8mpozcN3H38pMFK7PgGpOOitMQkBoPXnsf5nri/FswE4s5Euz+eubsb1rm2J7
 566RH4ovaYiNOwNS5FaUqjrs9bZ7CXwHiuqZ2i099WCxo3NuTj6+sVoeqI+tQrf+lqkp
 ES5en+IHIAPvE9JHFUXjP2no9xQ7S37gFEsfoMpaPEPECAPeXdHMf4HtsI1Ms7/13KPh
 lcN9L3pI8FdpwBa9xebzlVjGVzJl/wl5V42t7VvM7lLQfhHsHUnmjpYaK8lMl9EQqpEa
 f6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9AjMwR7Z8B2oTWOzAAhJ00jw1hl54hnoREOaiO4tzI0=;
 fh=eD6JdcIItJeLZC4aLk7RTeb+8o1nsA5fqcZbgWwHqwM=;
 b=huevBm5oDHlC3XtjH9c8H81q/52uKQomk7qWEgl5QczdTAechzVSCkXVHKnMd2CXTu
 iRFfuppFPm/34BseZAwtufm0jiItpf8gaEXn1OyhKIkZEhY+JDa0zPjB1vf1gEBqOsKf
 OqngmOvAW51sVXFbi+VwHJ3enQh5VLvQtM1pOTM1JamIs3luhtcRcQ6ra+0gmpmg/yfh
 Labfnt2Bj17sdB5L1lqRYZBzSfbGxZGMHT+BdGRxSzU9cgXlQ0NwyQ+4yqYQa1hZhKOb
 Jc30nzpeiJ1L26zkCOROzNxAaamZmP1oHgqxb5Uwd1F6mTgM7E/k22vefPnoOthALTwc
 F9Jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793038416; x=1793643216;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9AjMwR7Z8B2oTWOzAAhJ00jw1hl54hnoREOaiO4tzI0=;
 b=PQMZtNqwgyuQVBklaU+4sH3c7RzmJovMtMlANig/sBOlLPeMuyqPtU2LXgg1EVq0Ro
 b6yByL52Fx+mFX2uij0v7t/XnF1L419D0K/vLMbjWZnqu97OdOJXotCiBLjRQvYrSfIE
 kGNRSqnmEhPt+V2YAgsHTSD4ttreoCiPrqCO8xWjPScRVwClDrvQBX4XpM/xW6n3xv1c
 kmbyZdZL/j09PajMPL6cUziTD687McPGuo4YHRgj2CeQ5ZYKUJ5Am6KtQl/5EtKR2LKx
 jZW3KI65V8AImQtBGZslK/Fnv+VPYt3D1lI4SLKLojIHQ+0nZNfmiGinV2/r25cafZ/F
 YPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038416; x=1793643216;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9AjMwR7Z8B2oTWOzAAhJ00jw1hl54hnoREOaiO4tzI0=;
 b=vS0lY037l0rW0bOH0QH3duaXcmoxwGAVliSHtjXOqJCorcgDxSynT+09Fw4Z0vavly
 f752z+UUhsi+TuCWNZDUQFadCNsYtSlyLndzUOoLFM7MGSCwmWGcKHOZFIn2x89SsT2J
 gSacwTj5AKlWI8NzMiemOm26PVXJP+gA/bqqK2/Z5hERT9BoOWlW+uhVeO87CyJb4rIs
 V993x9vPZ+TWzPP5awC6LqCfbdDlrWqXGds4G7ETcPKDJjUYfeDR3I7d2Sae/aYW9D4u
 Rhw2n5IGO254FO9afTGu+gXBinb5KLJXOg44N0beP9qUxEGh8K3m+z+XHSsbmg/RKwc9
 UNsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPCI9OybId9q2vPMP1adabh0aaoTLqdopsDTWwEc0GYv5AINX0155cFCUqpT4dHjAEgZfXwbAWxPo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjNif6PJmkpAR5tbknpdfTNjOYExyPNNehlLqsxJEKVKnneB15
 app8tydqs8tXtJmWm3lpNXhYW+3EIScAZ3Hr4yKhqcpGuQz7/xp4IO32bIX0oz9dHY37t41GKzx
 UYXyrOblwJsw/Ll0OtCV3pLt5lQHi0vojuk5aNuu31g==
X-Gm-Gg: AYBFou2d/lmwNAID7Uw5eor7WHQdb39PH4sTQILkb9kiUfFlSY6Dmlnmd5WklyrpeHB
 Rbcvx6X4bBtRz1NkJJyBFgzFm1SWUvOXpnCTcxBeXUajpz1Dqw+AY3Son4j+UKp2Sh7jtcsulZQ
 ywZpoUwpkptT6Pq+csFvxxnLO16PfGEU3ctKlvuDMLB/wXrFOCBtt/nzKABgpVUnG7GpHj29nU+
 JuC+foI7eRJ7FXn0bEHh8zrL+SkuQjcAgafN9tY4zAc+I550YIhQnFcfZ5SYUayVLDBW0x9Z58L
 pXhe0OzOfv7IXZ2F3glRdILN+k6q7jnHhj2p2BFUniZ1pVmJcgvKmdZgnV8gX8Ah54K1yyKKttV
 zr5ZIaCiVJeWygVSTug5/cxwzA7aHdA2r8lBcvGOvRyvd360rrICIPKMItUezpApJE685IxiB7c
 M0qUsvpV5Ob/ZU8qeb2T//pwKBz1KdYfevI7hJ6Q41yqyFrzz3IJ94pA==
X-Received: by 2002:a05:6820:80f:b0:70d:1692:14fa with SMTP id
 006d021491bc7-70d169217b8mr2519101eaf.13.1793038416125; Mon, 26 Oct 2026
 11:13:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019174930.7237-1-henryzhang62@gmail.com>
 <20261019174930.7237-2-henryzhang62@gmail.com>
In-Reply-To: <20261019174930.7237-2-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 26 Oct 2026 18:13:19 +0000
X-Gm-Features: AclHuK_KlFEnUlqXLwNDSuqARQFNNPqFsCBg53fZhcmuBv7einI3hP8qmGSxzCM
Message-ID: <CAPY8ntAhuJ2cvoTjDoZoMe9c+43sD4muATtRSq-cFnQRk14-=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/vc4: dsi: Don't return error reports as read
 data
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

On Mon, 19 Oct 2026 at 18:54, Henry Zhang <henryzhang62@gmail.com> wrote:
>
> When a DSI peripheral detects an error, for example contention during
> the bus turnaround, it may answer a read request with an Acknowledge
> and Error Report short packet instead of the read response.
>
> vc4_dsi_host_transfer() does not check the type of the received packet
> (there is a FINISHME for it). It copies the two bytes of the error
> report into the caller's buffer and returns success, so the caller
> gets the error bits as if they were register contents. Packets
> received with a checksum error, an uncorrectable ECC error or
> incomplete are passed on the same way.
>
> Return -EIO in these cases so that callers can tell a failed read from
> data, and retry if they want to.
>
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>

Thanks for the patch.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>
> Notes:
>     v2: no changes.
>
>  drivers/gpu/drm/vc4/vc4_dsi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 5ed3c35..5452b72 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -39,6 +39,8 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> +#include <video/mipi_display.h>
> +
>  #include "vc4_drv.h"
>  #include "vc4_regs.h"
>
> @@ -1299,6 +1301,24 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>                 u32 rxpkt1h = DSI_PORT_READ(RXPKT1H);
>                 u8 *msg_rx = msg->rx_buf;
>
> +               /*
> +                * A peripheral that detected an error, e.g. contention during
> +                * the bus turnaround, may answer with an Acknowledge and Error
> +                * Report instead of the read response. Don't hand that, or a
> +                * packet received with errors, to the caller as read data.
> +                * Bits 7:6 of the Data ID are the virtual channel.
> +                */
> +               if ((rxpkt1h & (DSI_RXPKT1H_CRC_ERR | DSI_RXPKT1H_DET_ERR |
> +                               DSI_RXPKT1H_INCOMP_PKT)) ||
> +                   (!(rxpkt1h & DSI_RXPKT1H_PKT_TYPE_LONG) &&
> +                    (VC4_GET_FIELD(rxpkt1h, DSI_RXPKT1H_DT_LP_CMD) & 0x3f) ==
> +                    MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT)) {
> +                       drm_dbg_driver(drm, "DSI read rejected, RXPKT1H 0x%08x\n",
> +                                      rxpkt1h);
> +                       ret = -EIO;
> +                       goto reset_fifo_and_return;
> +               }
> +
>                 if (rxpkt1h & DSI_RXPKT1H_PKT_TYPE_LONG) {
>                         u32 rxlen = VC4_GET_FIELD(rxpkt1h,
>                                                   DSI_RXPKT1H_BC_PARAM);
> @@ -1313,8 +1333,6 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>                         for (i = 0; i < msg->rx_len; i++)
>                                 msg_rx[i] = DSI_READ(DSI1_RXPKT_FIFO);
>                 } else {
> -                       /* FINISHME: Handle AWER */
> -
>                         msg_rx[0] = VC4_GET_FIELD(rxpkt1h,
>                                                   DSI_RXPKT1H_SHORT_0);
>                         if (msg->rx_len > 1) {
> --
> 2.47.3
>
