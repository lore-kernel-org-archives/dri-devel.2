Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C38CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B41010EE96;
	Thu, 11 Jun 2026 11:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vexdn9ED";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C4F10EE96
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:33:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso74925915ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781177613; cv=none;
 d=google.com; s=arc-20240605;
 b=NZcGmUregMWNJ6TIhH5YoOTpnAfNA2LuytdIyPicZ8bhaqrvgVFhhTtPlup2DP0s8M
 l4jmEiupcWAO4atwX48pFFA9BfzdvzF8vXvXr0tcR5dbj43239EZyIF1nVjvRB4Ijpsb
 gVjsoI1r79aG5ZTGXduLt3d+3DGJlJHtnCwOPMrvUkOyJvL9f1QVj/RgTIxDEUFhW7m2
 didZILQ0jWvJLFXtm3sYw0xvrcGUp2f+EA2Tl8j2WUqo0jiL+1MQqtvUzC3M+gMkihg0
 YCoJMdtyJ0lhu4owSrjtP9KVr9d5+n67krKY5/QZ3ku99aR3oiBjOQtdJ3BNk2l+5Pe5
 88bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dp9QBlKQgTMU863TVI7dtmsZ6ywpDTOUUJKYTfISpko=;
 fh=m/sl8ULpbFGVr6Vd/I5iaFoXeKx+GjnR62Wrw1yHdcw=;
 b=Tbey2IPOSkPg+jqgNWI7yotL1O19eYhKIuPY/E3HgIVazJepbPuWd8XjIPn68hS+SQ
 o+I3/ffdO+b4amcrajZG89hH91CmzHzG8GD7ipGR2zeT49vkFD0wdm4bKGHvcslzorRC
 moJGSohmM+7e5BMddbs/VXX50LxEkJY4LvL1PH5pMxo54mrKYvryvK766+PfDBu0Tkzo
 6ZyaoWmkI7EcDGiRcKTaruKNo/zuTedivvCWG1cxavj7Cgj8OJTSr5S4bhtm/K+Zg1i1
 cjWCS6hyFGVCYSBzODMJxr2xzteegIFp68djhQflu3MluWfFa4LXlxxpy9GBHxKOCsDl
 rUrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781177613; x=1781782413; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dp9QBlKQgTMU863TVI7dtmsZ6ywpDTOUUJKYTfISpko=;
 b=Vexdn9EDZAs2g5OWwHlWeQO/DihI8wMQIVoRD07IvD3cpeO7mBHy0yqXL/0fIEKsNi
 Vn7unn7fyObdkzRj4eE5Us/9Lun5ehunItnnBU6zzpGv/kyZB/kDj7F/6B7Qtq9oxI7Y
 ubvtqt1bklz0D1nCyENIiYKCbS05HEtX10+KLa3UmKRkh1P9tKDXpGDIfjTfRYpT5uI6
 7FtH2Lr1Zm4CwWScB3r5fS5EgrtmDQylNbS7ktb+MDfOThw8qVViUmB7SvEk6LiMwWdK
 K9wEjLlOFuLL+j9ow1bkXo6Ppxe64m6Ss2s4wgsKfSLKFSWS2pFl1NEJ6ak9EHhI7pGN
 ZxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177613; x=1781782413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp9QBlKQgTMU863TVI7dtmsZ6ywpDTOUUJKYTfISpko=;
 b=SmkYgOqAi4Y8zj2LomF2LIF1DQ927on1PbDjbaPBSNASCneZj4sxNdhcQJJIv8bgvX
 RxPDX5soy4x/8iiY23KVLwbGuFcc1opVG+8+Iqdt/LNsUwjCKkVg+qJodoRyYaccTGv0
 NrK97T41ghR4/mQer5iRnJnRU7yA8h70Zxnsw03RXrpH+neToITSI0XFuSHffIm4gIsI
 cGrzAVCYgMZT13sBudR3ZGd4S8TiT9sMlkNnW3pYEa+PCVCzPolLyV8hEDloa/rw76Ey
 09xJk4G4jdCA7FJTKKzUhAaQPtKflz58Pk6SboKymWx75wwecq9RZVtBYJc9uC6yGJq/
 AQJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ92z5/bqknA5BfNVY0a+3sHw2ha8fuzzBxrCZWgCLhnsXwTBJ/UIIHMv4FlHctpsxFvPBaqzkvsTYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOcsb+3Eshiuu7JD/shuwqm+VxKtuZDSxTHp2KDXXTdfpK/Bz4
 oTd5EDL3dC9RWPLFELH3T9oo9DT7aiVcc+ojivvoQl7dFnDkFzprO9bJSTPSS85hl22e++NecGP
 irwt5BLj8+p5kl+vpHCKrbFA5kkkXl5y2RsJ3
X-Gm-Gg: Acq92OGeAyv8mZZwTKjBpdCrWlnm5EfDlQ+H4NA9hrDjKpmbIyj0COk1XK1tDfJjkem
 Is2Vz9HwcXdUCTb1ImUgYaRRcpSgmAIt6oloEFkKKbYPy8UVvLGiUNlo+Besu4OQ3U/npPAHyGI
 1asz5lWeXFGsQ5hRyR9RcU4upwkYgJkKQKI6Y4X/1OTPPSNWWvkyzYto11lafEM5/9OKTxmRCBo
 uPESqVaJIdTTyvkJtHRPaFK2Jdt0BXwViR6njfkvp6or7RNAhDoKWkt0/DXg6Eib7SLcIRP+KlK
 8W4QTmIdQJ7/kx+C3U8Xk45yKYS90gY6N880+wnilLrshubi
X-Received: by 2002:a17:903:37c6:b0:2c0:a360:45e9 with SMTP id
 d9443c01a7336-2c2f2b6ee3amr28266425ad.29.1781177613475; Thu, 11 Jun 2026
 04:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260511085148.652256-1-l.stach@pengutronix.de>
 <20260511085148.652256-2-l.stach@pengutronix.de>
In-Reply-To: <20260511085148.652256-2-l.stach@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 11 Jun 2026 13:33:20 +0200
X-Gm-Features: AVVi8CdntjkGsiSaOStsg0DvQrN99U9lXn-a3gylizm_-sdLiXemiGC-O5Gz3VI
Message-ID: <CAH9NwWcqF1+=opm0wcVevYwv+9GKm-OZYde+W0Wc4d9PbCjaNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/etnaviv: check MMUv2 status after reset
To: Lucas Stach <l.stach@pengutronix.de>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

>
> A fully GPU reset is the only way to disable the MMUv2 and the
> driver depends on the MMU being disabled after a reset to be able
> to properly restart the GPU. Validate this assumption by checking
> that the reset actually did disable the MMU.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 34fff36af450..577fc8131976 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -601,6 +601,23 @@ static int etnaviv_hw_reset(struct etnaviv_gpu *gpu)
>                         continue;
>                 }
>
> +               /* try resetting again if MMUv2 is not disabled */
> +               if (gpu->identity.minor_features1 & chipMinorFeatures1_MMU_VERSION) {
> +                       if (gpu->sec_mode == ETNA_SEC_KERNEL) {
> +                               if (gpu_read(gpu, VIVS_MMUv2_SEC_CONTROL) &
> +                                   VIVS_MMUv2_SEC_CONTROL_ENABLE) {
> +                                       dev_dbg(gpu->dev, "MMU is not disabled\n");
> +                                       continue;
> +                               }
> +                       } else {
> +                               if (gpu_read(gpu, VIVS_MMUv2_CONTROL) &
> +                                   VIVS_MMUv2_CONTROL_ENABLE) {
> +                                       dev_dbg(gpu->dev, "MMU is not disabled\n");
> +                                       continue;
> +                               }
> +                       }
> +               }
> +
>                 /* enable debug register access */
>                 control &= ~VIVS_HI_CLOCK_CONTROL_DISABLE_DEBUG_REGISTERS;
>                 gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, control);
> --
> 2.47.3
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
