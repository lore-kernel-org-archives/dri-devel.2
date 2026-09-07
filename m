Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EACAC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB6D10E512;
	Mon,  7 Sep 2026 21:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sVp49TME";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDC510E512
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 21:01:43 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so3888272f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788814902; x=1789419702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0jKO+9sWDvAmMVaHnfnr4Hp4hjfEF0vm85uCtXj8WFQ=;
 b=sVp49TMEf38wnE6ra59odKWIeaFoL5D568hJ+BLyCO4a0iz5fkEuJqwWCwDV20owMd
 WrGbSGt3Xp5Dq+u5fSLRPvtbKEXum1GiMNSefJmvY9w3MzHKd6ayEl4CKmC9kiLNJvpj
 gm3YTGY1taGpGbEm5rnL97cv2bCRJkNbhTK6jl5wEuNBVGmryXP2cx6fkyqnNZHIlXdJ
 P5K31yrrEuP1fwGSmegcvu3YufD2ULwxRfOAgBrEB8+r5EPjAH+RIEKsMv5mi6tLLC3w
 EfhDMV8P69fQkdPIjrqq1UzvnOx/6tz9hLVmFb1nX+HBxceb5/wYRKV6gDBne4E6odaC
 0zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788814902; x=1789419702;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0jKO+9sWDvAmMVaHnfnr4Hp4hjfEF0vm85uCtXj8WFQ=;
 b=H8zdNL3XB+y5bgMGfxe5BFQWX2pK91fhFOkOT+3fnP3mhNZJNO5wYo6AgtKsIVv43T
 91+AsDUmnY8EhGBzBWm6q6yHjPWjLTa5eMcsVgutPbS1MmddvbP43XhsObId61PZG8ec
 2gn8rSaEX5dL76VMfuolPJTqugnfURmkOZ8aPEjxL0PizGOjEub8vIioSsxkoYw051S6
 EeQ4LjEqnU3uT4eG28iRkpzr+TeHAa/uaO+HpNLN7BS3e/8eBhjuKHMs4Fw1QKQshB6E
 KJYQVWbyQARB6fsloM+XNFoj7d6nXprQTRlPcmwM0dd8mLIXzpLdCJPHkmVijj4TIghJ
 p0qA==
X-Forwarded-Encrypted: i=1;
 AKwUvByubT+yIAp3XlsFm1ek6/LYC3gqfrH9b142HwLpkLsP6eC03JzWXjx7V4/Cs4q6KbMJuF710ToR7cU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZ1M1C077v4bzTOI5YGasuzuPEEpDqTAzk7iuo2VymGZFF29fQ
 iUK1qfWLbFblcuogj+jrNz+9AnTI0W2p0Al3q912qWfdjkL9MQILjI0xwjYAtw==
X-Gm-Gg: AYBFou0LBidW6wwwXszh8p68fMnk3PSVIRbOU2+Z+fyeb8paNOEsIEnkC2nlPQn6yJ8
 h+7UChJVtTx9futEZUpnuapZR2g5jR+KyYU078Hi4NvafV1NKzRNS4Ljol9BLMPe3LCBk0UmjC1
 P6r9dwo7lOTz1CfYwkmkNSa/63l7ULCwasquLzI1QjFr5DhogXKGUhLiHgI5uV054RNK2MpZ/Pz
 gOn7Lm+iDMAalaouaYeLTSmkTCTFCSrqf/+Ns+niwv/VP2ekGlXi2VbDraRaVJmC4szWR+vHIcB
 Voa8HijRbd/0TmqkJoiMFFIoJ4cG6TUX8vX60rSqHq9aXAEww0b8I6oUvcVxaCEuWaiuRqL3nQj
 XkpQ8Hq/V2EnrvGYtF4JYfxzFMV+4JCk5fqeNFC/0zQS8lXSeLg45m3v6GsxWbfyRO0QhICOoA6
 VPRjifJESK/Tcqys9BNX/kUO2zrIaFxlEUbLeIewXkPwDLY2ylGrSIqmDHy3nRdjv9zTITqIJg
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49cf825a530mr297613755e9.12.1788814901592; 
 Mon, 07 Sep 2026 14:01:41 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-49cf5135353sm299682235e9.2.2026.09.07.14.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 14:01:41 -0700 (PDT)
Message-ID: <6fb14341-655f-4cd0-8704-50c8d2e5850d@gmail.com>
Date: Tue, 8 Sep 2026 00:01:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge commit
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
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



On 3.09.26 г. 12:38 ч., Tomi Valkeinen wrote:
> 'ad->card' was removed in commit 9af2c1d4f847 ("ASoC: ti: omap-hdmi:
> remove unused *card"), but commit 699e5975e2a5 ("drm/omap: Report HDMI
> hotplug events to the ASoC HDMI codec") moved that code line. These
> commits were applied to different trees, and the merge was not quite
> right: assignment to 'ad->card' from the latter commit was left in the
> file, causing:
> 
> sound/soc/ti/omap-hdmi.c:408:11: error: ‘struct hdmi_audio_data’ has no member named ‘card’
> 
> Fix the issue by removing the line.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/apbbvQSfUbzYRFaw@sirena.org.uk/
> Fixes: 1ae7fe832c2d ("Merge drm/drm-next into drm-misc-next")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

> ---
>   sound/soc/ti/omap-hdmi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index c32ec7c0b0cf..2cabd4cc5b0b 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
> @@ -405,7 +405,6 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
>   	card->dev = dev;
>   
>   	atomic_set(&ad->jack_state, -1);
> -	ad->card = card;
>   
>   	snd_soc_card_set_drvdata(card, ad);
>   	ret = devm_snd_soc_register_card(dev, card);
> 
> ---
> base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
> change-id: 20260903-omap-hdmi-fix-7f085e21b708
> 
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
