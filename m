Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E80CFF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40A710EF3E;
	Wed, 29 Apr 2026 10:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HU4nuTC1";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F96A10EA42
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:43:27 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-69498319ee7so3374907eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777362207; cv=none;
 d=google.com; s=arc-20240605;
 b=B2t+nIaihnAx7f37ne+sQVoB2UWfw2nryq69NH/F/O5X7T8J0OrVg0dbFVSTtgkDiy
 Tt+yA0rqGFS3riQ84T+/04JH2wePa9TQFqbSpUzYk73GLn2WU0nT46X4s/RW4kqqoHTd
 5Mgh0dxz6VTstxIhVaH7u+koE0MXNbrN/+B8zj+QOB+a1W+KnbtRjScribl3QPbwqUl0
 Ti8XuzMwurMyHNjNxr3VXVuQpf9EI6tGIEGpM8CJF0ezVk/RJ9MF+2AeDQEQZug+dZzA
 67kBFHwUtN7IkE+kH4vDBRM0oyVXlQNvL7Jy4mEVEiXzeEA6Fxk5denSQCWwXG5LPIbV
 j85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nlCWMuzvVJ7IzoN/xOGYuIb24YK5KEaZSDEM2wO3L9I=;
 fh=1k7gkL7VJYj2p48ERexp2Kx7M/dtEBr8u/rK+lLG/lo=;
 b=VCZ4RHgT8reR4KBWWTReqRZl/wgvbB7DO+yktzRyVkCbZNAF7PH9tVoN0k9DSBpdLw
 G9z2Ng+0m76DM5avliUJbybUhECU9rBozq5vPJGpipqo1aelzjfsVNDx12kd/QC9xV/3
 wZBxBALJm8hI9g6VoUuNVu8l/4D4yyNNMQAhFGc6ktxkxkPLYp7Om5sGcCS2oZJXq1Ma
 ToVo0rCUcYsfmMrSLPfjocTfEqMoAbMMEqQGKU3zhabeU63nVohh6C4evW2g2zva3pcT
 O3ZD0IIBBFi8g9FwScQ1J2atfQ7zB9ZKJ/rTMOhCoJhtI5E9YRpBTk71z4l6wiEisXkZ
 HMIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777362207; x=1777967007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlCWMuzvVJ7IzoN/xOGYuIb24YK5KEaZSDEM2wO3L9I=;
 b=HU4nuTC1yVl1jV9jsVl+UBF09w7WuYI6ysrgLlGoeDLKlByyHeDBz/NiO0qcluF1gl
 rNf3LTi5jUwOIAN/AdDgp2PFzAM5vTAK4Y+IFGsvrFONAD4LJWnoCEq2o/5qq2WjytNW
 baymeKkxPcl2pPJPAsRhDLt7++LfOFoBdZOSMPBCBpDWXkydHEjpZ/GmaXvcMlNQ7PoN
 SSWRxgkjIrW+O/HKLKAeVb8WXlxBIpFvInSFJbEW36vEdS3X1B9OlGYYpSgPp5dVgRfl
 IIjrIGvxD/nJdKUr3UNuhJbjr8vesvZhn8sPWSR4eHfC2h+DVzYr7ig0zWhCR1P4J49j
 0sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362207; x=1777967007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nlCWMuzvVJ7IzoN/xOGYuIb24YK5KEaZSDEM2wO3L9I=;
 b=PD3YAHamDAu2DIBAPT3zAq181jW2oTvhT0n8c/N+7CW6UwZtjjsbDe37ny75Nt5fLO
 PWV4LmSnZPl6LGVTzbEgYlrDCBA8FjqKeXQBN/3UbMfgpgCm8c5b7Y4eGpKnwv/jxrEo
 2YIVHkz4Xs6wk1rFB4fouEPbJoI7ME+WUT84N18INOcqFSmJtHJFeDxnC2OtbuVaEXjY
 h9zmXAP/4t3ggBJ/ZqAqPZ1sxgBg82HYmgRKOEBRa9UlkBfdE3Bc9+KiqpUgag0Y/mUk
 V70y0hx9HrnHJhY+EtWy+u9MoIydFTOkWOt9atZt1MBSgA8b8NoKXgFsVl8o+976W6MT
 tVeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ySv/ykpxol1NcH6IqoSq7wMCehp8muCEdZm/3/mQg79Id6U9IrhI0psG2cZ7kHkmNEnpFJcf8dLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYdMsCrRGCRwQ62O17zPVGG42t3BVT9xWiEXNWNwi2tWRIOnkq
 BGeFyEtP0TPJJJ+gqAnWe0nRHm5Q0Xbw9xhO656+BLltDtPanVHxN12j3IQ1eeCXED0szT0iQ7P
 HLaz10xa9+XkseXUI7cHKfdOCeHCEIs4=
X-Gm-Gg: AeBDievbTGGuaail5tep2296bD9GeL+M0Ue002XXAHrStaVy8+5DE1iv4m2mFmm+0Z6
 GbeuBnHsVFRIpP5mQA7ao99uNM0pJYkXHn52hV1xUgQqiRnwrFjpGKKeAJ7Vlh6/VesGDJCUq03
 tXMEP728h/3XtDA96ixJxA4bg+Am/Ajc6Y4OiRF+9eRCY/W+sZ2hYVIXAxY94QN+SmbVxbMmdKT
 uSNi1kWEW7MtPKMupwrpZqHusBJ/1xlRmRMkNbeAdokeZLOvPzOEFaRYqG9LGweN9KJ4uPDxyQX
 YJov1AyUKcOutrtPcw==
X-Received: by 2002:a4a:d154:0:b0:694:857a:5a78 with SMTP id
 006d021491bc7-6965c24db04mr901521eaf.8.1777362206757; Tue, 28 Apr 2026
 00:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260424085007.3239969-1-syyang@lontium.com>
In-Reply-To: <20260424085007.3239969-1-syyang@lontium.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 28 Apr 2026 15:43:14 +0800
X-Gm-Features: AVHnY4IQskqnH5leWyDO4V390XKUdr9xIa_jNwD7t-f6Q8D1cijxN2LeWsm7gY0
Message-ID: <CAFQXuNYQZrOUvuQmB9RpBRqTz8obVLg0Oo5O856ukYZcBLR=QA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix the interrupt clearing error in LT9611
To: Sunyun Yang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 16:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Incorrect clearing of the LT9611 interrupt register causes subsequent
> interrupts to not be recognized.
>
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/br=
idge/lontium-lt9611.c
> index 4517aee83332..f30a2875000f 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -398,6 +398,7 @@ static irqreturn_t lt9611_irq_thread_handler(int irq,=
 void *dev_id)
>                 dev_info(lt9611->dev, "hdmi cable disconnected\n");
>
>                 regmap_write(lt9611->regmap, 0x8207, 0xbf);
> +               regmap_write(lt9611->regmap, 0x8207, 0xff);
>                 regmap_write(lt9611->regmap, 0x8207, 0x3f);
>         }
>
> @@ -406,6 +407,7 @@ static irqreturn_t lt9611_irq_thread_handler(int irq,=
 void *dev_id)
>                 dev_info(lt9611->dev, "hdmi cable connected\n");
>
>                 regmap_write(lt9611->regmap, 0x8207, 0x7f);
> +               regmap_write(lt9611->regmap, 0x8207, 0xff);
>                 regmap_write(lt9611->regmap, 0x8207, 0x3f);
>         }
>
Please check this email.
> --
> 2.34.1
>
