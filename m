Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19ADF46445
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C2E10E3B4;
	Mon, 16 Mar 2026 11:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FNTQeudR";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C32710E3B9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:03:00 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a12cd0bcd8so5084734e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 04:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658979; cv=none;
 d=google.com; s=arc-20240605;
 b=SmDKU5rYXuQiky2BJdyXzq4h3+GjnySzV8bS3ewYTWPnnLVzlb4g0XJwMnBeCt1bPS
 THpjq5gYEaNJsXKQg06p9V5CVmGTsQxnZArgUjMwcutwBgO5dPZENi90MBc6nXQdlVsQ
 OONEEIos+blF7aqegLP04Ai24m4Kr2+zgu+nd83M6BGT1xbIMSch0fJ0fj89M6ttHIpd
 AWfgp9BQoIz7HwImtlmgxNlL1iKX7aA7URL3s4SEa7q7Hx7Au81ggxtRZ5N4v3ZHSlLV
 eVk8v20kwKaeNeWCBZOgFVyHtX7KWg8DGvUd8EEut3LqhZfV3dBccv9i2A/lvuFHX/a/
 Y8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
 fh=NNXCBwWBt6aQNXPu3EvC72LN0uzxQoacFFYfw7C9xcM=;
 b=hd5br9FAtiCC4BfkFA7HwjXkybqHQLK1cRARJyLYZYzjbMTzUYBhaHOcJAgrCbQ8DK
 1FcOGPcf+j380Bpku6kHVpLXeBwfcCxUDPFTMdJd9Sc4enDU2Hix9GMUSL3cZDya0Cxr
 4zSm8M4KZM7vNidhedZtiyQznNFt6QtrBBMavzvbjeddWu5LItTroz+uUOUrQ6SrAtLj
 rHdzEdsy86/LA3taMpvhigEe6SS9RO33uEo4wRtAhBhh5xrFMIrrbkhsDTFVwB/seGis
 7S/47BFc+5EFDfc7/X7yxmYW8U4ae84eR2jE20DUy2pOA/wACtUyUR7Odiu4/mreTolo
 Vidw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773658979; x=1774263779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
 b=FNTQeudRCygGYbklf/cVkvmc2Sy2AlIcCXjuY+V1Yp3KZiicqBFnAdz9LQEffCOKiy
 vo6ueozSHLEsDjLpEmJ6AhJn/Eduz7o4v75ZpnWAi74apmLuQNUO1Hxeq8DhrnLzkhbl
 FAJaQoWW/TUPxgyGuajYQjZ1hm06g1b6HEkm4hKMvHXpJRCc8m4p+a0JQ4EcdVlkQxVk
 otQI3SMOfXQUiqWbNo6J1peaqO2RnZel6Vi2AFgFqlQtagduFVnQDGKxpenXqhYigHbZ
 xfINaCUjgKbA2KBojMQPgtayvMEeJYDOGweVnUFjAfNsH0yrlX8rZ0FfbmtaB72zCfsC
 XrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773658979; x=1774263779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHF5jh1E/8cDW6oFzgL0o++DHKJ5vfxqmY6kxOKCXrg=;
 b=dZ+fzYW0Jey/kNgWUySVrk0HiyKd1QhijM8Dlxttz2AvcrvELUkds3cnyJ7HDwdoEM
 A2vFj00y7Je1iAgGYIbUZ6hRdvfQMPYIc0z+GkEd/ZTgSyD6geeWpigVpPxavN2FMg/1
 nXvAD9jyUPyz2pCy3PiUTWWGaAiO7O5v/fQx5KovRf9AwdtlkHcIqPKGW/cHRev2oamv
 27sKwVL4daagh603m52nYh3FfRKbAFu5B0uAebURHUroqWe0Umx+pgFoSMQpwf7VGSI3
 J2ebUQ34R+V4B63MNBza0n9WgFwoxOfBoQmZ/E7v0G2h8+Ubijt7DxVooada0a2Y6IJ7
 1Dpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTP0PGwixN8ayAgFysZS79jc1kQtwy5bz5qksZ2h4LDKog+otYDY07M2byrKvNJayPdmbFCnTHPhI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg795mcR7WMWKKnfx7h3suUhtmECLelLzxdrAa5z2j7pu7GcNT
 KgtMlbLx+mNHNKRBBFYyrliojoPP2cwq8nKWiDjYsybBoJzpNa0qRUHVziMaaWpKUKmrMlQUUm2
 tO1apJzHwXVAZGp9DK22lCoyu2SVqm3mFbMLvUpllmQ==
X-Gm-Gg: ATEYQzzeWTEBYEYP0BBHvVl0+b9i38fziqUNo8nxBTyyUYunNFoER2D6UuRGu2NOSP/
 NZ2uQqjMNuZaMH0Duvwlit/uI/3HiVQpw/w3jTJuW+AZQMxiMaAzsH+GXA4HnRS+cUly3zMAXeo
 c3C5IQCdUE4pttkbG5S6JHP2T56lLuI0xxvKkUxFRKrgCbMcrYtn6KM3vIzdvmEwBSFvpbTa2I8
 kGCGPaheV4bsrxKZ/j9ZMFyoTtIiCrKfX+PeLUj6d87qdVltKNzcikXOkjBH/lSdQsxAQwqfWgM
 XGHvNKDm
X-Received: by 2002:a05:6512:3d08:b0:5a1:476f:bbcd with SMTP id
 2adb3069b0e04-5a162b1febemr3904293e87.44.1773658978742; Mon, 16 Mar 2026
 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 12:02:20 +0100
X-Gm-Features: AaiRm53iPYU3kIDyxQsV0KhFz9ohyZ2kXqcNJl_f0uC65KcEG9ey-Zyr9y0Dr8Q
Message-ID: <CAPDyKFqqdGG34+a7hY8feNHsnJsHvq0M45Y5-hDJp=bedHcZpg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, 
 Iago Toral Quiroga <itoral@igalia.com>, Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 kernel-dev@igalia.com, 
 stable@vger.kernel.org, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org
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

On Thu, 12 Mar 2026 at 22:35, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> The bcm2835_asb_control() function uses a tight polling loop to wait
> for the ASB bridge to acknowledge a request. During intensive workloads,
> this handshake intermittently fails for V3D's master ASB on BCM2711,
> resulting in "Failed to disable ASB master for v3d" errors during
> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
> a broken state, leading to bus faults or system hangs on later accesses.
>
> As the timeout is insufficient in some scenarios, increase the polling
> timeout from 1us to 5us, which is still negligible in the context of a
> power domain transition. Also, move the start timestamp to after the
> MMIO write, as the write latency is counted against the timeout,
> reducing the effective wait time for the hardware to respond.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> ---
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Ray Jui <rjui@broadcom.com>
> To: Scott Branden <sbranden@broadcom.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e31440=
2f1cc9897c57dcb 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *=
power, u32 reg, bool enable
>                 break;
>         }
>
> -       start =3D ktime_get_ns();
> -
>         /* Enable the module's async AXI bridges. */
>         if (enable) {
>                 val =3D readl(base + reg) & ~ASB_REQ_STOP;
> @@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>         }
>         writel(PM_PASSWORD | val, base + reg);
>
> +       start =3D ktime_get_ns();
>         while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>                 cpu_relax();
> -               if (ktime_get_ns() - start >=3D 1000)
> +               if (ktime_get_ns() - start >=3D 5000)
>                         return -ETIMEDOUT;
>         }

Please consider replacing the above polling-loop with
readl_poll_timeout() or use another one that fits better from the
similar helpers.

Kind regards
Uffe
