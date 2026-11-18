Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810E606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PU6ME0Mp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A1110F944;
	Wed, 18 Nov 2026 12:27:51 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7AF10F944
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:27:45 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a5506f09f5so545604f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004864; x=1795609664;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q5C/iHN7Lmzj8RXtCSxUA965C7B7NlmPdCiPikMVO9w=;
 b=PU6ME0MpzrXfIaJviKtpFuNRmGV6ZFjw5odMxV/fSpamqJaWnwirxL/HkW6GiUwThL
 FRQ3Lqar933DhtZws0ObH5M5p6Otc+9tHkAi8RZqpL2tz2T/6imBsZtpRhtn2h0gw+Rd
 gNQQ65KA4q3AVQYAdozIUAAvSPuRQKT1iHqsV87jJkeaRRg1/ZEgvhVpQn4k6BBtrnpC
 fvKve2afPDYpd4SUSmeMiK7Lcv7Uv3Yr5ZX/C+bjXFNBCW9VNK4tT3TrkCDKC1Dsg+Wj
 bOmRSswsKtFS3Ac6pyZ8ZOV9B3vgnz8ghmM8scZZZ9uHE5PpFMLIKnffoXVSWVsTM4pl
 BEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004864; x=1795609664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5C/iHN7Lmzj8RXtCSxUA965C7B7NlmPdCiPikMVO9w=;
 b=rDroep82cmkUP/O3bg+ko36VNKcmexTmUdvTmh2KVWGMWAB/iqtYc2VR+geRzFfCAd
 mzwt9F24daep33i3AyTQLQtlYmXzIvWFaGxddFu0TCiAchDEih+JvZgha3svGOECn7fB
 yLG94gmNIeiHMxfD76vMIREIw2t24llrQvwvxFb9Hhkek1m+1HrTEhc9dhg7vU/V42cq
 zKen30zD1G2ealYUaLRPsmxSOFkuUVeAizdyuas3djtbBmGO9Lcf+IGDdaGrlPmZYBxd
 +EbdJPQsEsxGPJTArDZXq+OgHsySWWmCdMw6Zs6YVxLI562SgBQjbG/OPaQ74co8Of9V
 2oAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFsc9BruGJ5bn2PrSrcvY2EhP62v505mwqq/q48nWn/DJq8i2icsEEeC8D7gZwKW7HXx2O1eU5ylk0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HQyMbDlTsTiU/U9/5UIxZKzoDGV5BzECytHp34iHtzEs4ejPz
 +tVK+w/BXwAJb9K8JZE5YfDlCLAU45TDWwVdFkgma73rp0tn1KhVLTimXfvJmFrNmo0=
X-Gm-Gg: AZFdTZfudo1Coe8xkyiridlorm409UZKxpWuAnSQH7t3HAqNXgQ0AzNaTNpcbeRY5Qg
 luDkrfYEdWAfV2BdFHtDuf48cneXXDf9EPMnBIHtTMUndlzHQ3IOjHrffQkQhASaVZw10khI4kI
 1ytkOoMEzPXjAQOElDYv0QNajvBVjFWW9kpCJNbDsy1IlVM2Sx6chZY6nU3JN4N6cr9ZHfEhdPE
 MdbaN0LZCwpNZLToiUDEhgxLY732aW+YeG47qiGoCcsEXwvhQ1gfFDX4gr9PI6SA0aMc6ub1eBb
 TZDCeMSCyiNNBGNKT6xgBzF4z8Z0vgwMx8lAkQb7648RPIPb2PSn/3U4uqCXrdZIbi+ScDuEI7U
 Epdro/XClpiQyTZTNeEsMPuBGeuqKCfMoxrXXfIDazZ7jgaLi11xFFd8LdKalsAFZ0r7IyDTo83
 WD4NVb4D4WQr+BtzPajx70saZChh4p0E74IBFvG9w9fkjnx8TALeG0MQF8iQ5fVyZ8gElqJOgNr
 bWUZVajH0P1AY6Lpu263Moz9oalQeAMq+UWbPsjk17YrPuuojQuOW5rYBSTONG+Oqb6aWPovyRy
 cYT9IEM2c1gaops5QjxOZzVxlvgyr1LFQYy4HUdQoe4GkF4KKWUhCZrj5BQiqHZcoW/eZLQ8CdB
 SVg==
X-Received: by 2002:a5d:4f10:0:b0:49c:fde4:1af5 with SMTP id
 ffacd0b85a97d-4a63bbc41c8mr4416511f8f.54.1795004864445; 
 Wed, 18 Nov 2026 04:27:44 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm4875705f8f.9.2026.11.18.04.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:27:43 -0800 (PST)
Message-ID: <f91804a6-39bc-4a86-b24e-9588327e092e@baylibre.com>
Date: Wed, 18 Nov 2026 12:27:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 04/12] accel/rocket: let the core suspend after a reset
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> The earlier test on the ROCK 4D was done on the v15 code: the job after a
> timeout went from all 128 channels wrong to all 128 correct.
> 
> Repeated resets were triggered with a 2 ms job timeout.
> 
> v15 (put, then reset): tested twice; both times the board hung within the
> same second as the first batch of job timeouts, with nothing printed.
> 
> v16 (reset, then put): tested four times; the board never hung.
> 
> So moving pm_runtime_put_autosuspend() after rocket_core_reset() avoids
> the board hanging during a reset.

These sentences (history of the patch series) are commentary rather than
commit message material, they should go after the ---.
See Commentary section in submitting-patches.rst



