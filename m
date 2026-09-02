Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7ADC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A3E10E46A;
	Wed,  2 Sep 2026 06:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R0smeIz6";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC9A10E46A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 06:52:27 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495437bb891so4948675e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788331946; x=1788936746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xn4PAkw0tahIVVTtwzVrKulou125O66ZpuD5FdtR8Zg=;
 b=R0smeIz6KqtMseP2T/k2FDr0pwg2x4pow9JK8FUQSQxvMjP0gnS1PpqXhOESX5k96G
 ympm7JsH3YpZjKRHd2JFG2WgcQF5/NGYO1v5FMA8eOonZOfACn1zTX6WFi4CVD0Bvovh
 n+DLUEZgndwsvuSEVtoZQGsklXE2bZRrVp2cSrc9UYFh49sn9lIaJSGuDWO+OkJ/oQ2A
 nVQUKpXmRdFlzJs7gk/OM/vX2qUMEJyzwcRnWEvuRDOv/oYOA4ylT3Scqvc5c1qpQSv3
 7rd6NsEu4jDUmqBLEse/ofXgTX7QSXq4rUjRPfxDTCl+puL/BrifcvEXde32jAyMf58k
 Wt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788331946; x=1788936746;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xn4PAkw0tahIVVTtwzVrKulou125O66ZpuD5FdtR8Zg=;
 b=VhGgs/p0TlQ+pAhuMd3/6noheth0zHZWb6m8QkadjJ30DOZ87amwQP/P7o0o9FH8Lr
 kknSs5ESCUwctA3Q0tKXdv8LE3gCDnV0/LG/2ddUOBcv3LQdDdSIfntkaeC4TjXWE7kL
 3Ruq2r5y5Sa8E9Bl5UT9juq4d+OjBNFFM0Uo012b1RboJJC5dLp8MBsH4nKtanf62CEp
 EsN0e7n+Zu6nPFTe8qZvODv0AmHcJsj109pocNTf9znVf7ItHQgH5MfnrkehdHtaY3jF
 cWIQy1DnfoLqHvimCw4D+/ArsqG+gt2csWRsWxKM5ii2T3CHIuWbeFrGyVqELgaWPIg9
 LAmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFKEvJ1gk9HPIj6XiRPPA/Ap7VtVn47r/5CwUANjWSS1brd+411p2xtP74JBj3BH5FfHoBtA0uX60=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYAOQDy/TvueBxAKL/bx9j/+vLu80koKdBVUfzrE/vHfL3j/ZW
 bkHFwzKXuqlQmOpF4q4HH6R0V8iQZa1EKxsuiIYzLUL3uVfJzLioCs6q
X-Gm-Gg: AR+sD11rAAwY/MP0fV/t6p16E96XrM72neQk97d+hxHdosKxd/8gTNFmlzG5gcYhl1P
 otSkJJdMfmXIfDSITSiFJ4n0miaFiigx8AJTVpBGXKQAdkV/BLJJMPijjEnRK2fJ+9jq12UQiSn
 iVGF1WtsD3xtHr/o6B1Q8Qc+M6YoCaz9ahogF6TqGTja0FR2Zg42dBYViq75SHW5pZThToePSuH
 Fd/ZWwkJTZh/HUvJFFr2FCQ/YIeuEwQpmz1z/Nuub+3RM94layEKwbyAvT5FXp1aAvrgG7rLbMD
 oCZOn33jTVQjyq7fO6aXzpCgQlDP2iJd5m87XEP+1og6HppQnqKTq5E212QFIw1Igi0uSJXuyDP
 fCDKoA29MT9gh/XSOTNLKwKXc6BB/M1Kwh70eoSSN4T/FE+VFOMDEPJcXN221gOTMQEKILLk4ii
 16IV1FOrveUxqbW+vojFvPek/4UjokLHz9EGjvAyf/heL/lG1aSiYaJOYk45K8e328aNGAKpFnK
 Q==
X-Received: by 2002:a05:600c:3f0b:b0:49c:ced9:ab7f with SMTP id
 5b1f17b1804b1-49ce7c316aemr13532185e9.8.1788331945999; 
 Tue, 01 Sep 2026 23:52:25 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10148sm123486195e9.5.2026.09.01.23.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 23:52:25 -0700 (PDT)
Message-ID: <3cd2c640-3ce8-4163-9f7b-3abba46ae072@gmail.com>
Date: Wed, 2 Sep 2026 09:52:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <apbbvQSfUbzYRFaw@sirena.org.uk>
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



On 1.09.26 г. 17:05 ч., Mark Brown wrote:
> Hi all,
> 
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> /tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
>    408 |         ad->card = card;
>        |         ~~  ^
> 
> Caused by commit
> 
>     699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI codec)
> 
> I have used the tree from next-20260831 instead.

This seems to be due to an interaction between two patches:
1. 9af2c1d4f847 (ASoC: ti: omap-hdmi: remove unused *card) / 
875e906efdc4 (ASoC: ti: preparation for Card capsuling)
2. 699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI 
codec)

Both (1) patches are in the tree and remove the 'card' member from 
struct hdmi_audio_data, while (2) was already in transit. Patch (2) only 
reorders the existing ad->card = card assignment, so it still contains 
that reference:

+	ad->card = card;
+
+	snd_soc_card_set_drvdata(card, ad);
  	ret = devm_snd_soc_register_card(dev, card);
  	if (ret) {
  		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
  		return ret;
  	}

-	ad->card = card;
-	snd_soc_card_set_drvdata(card, ad);
-
  	dev_set_drvdata(dev, ad);

