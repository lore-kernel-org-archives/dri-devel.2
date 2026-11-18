Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AEE606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mDfsPJxQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8C110FB73;
	Wed, 18 Nov 2026 12:28:13 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F17F10FB73
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:28:07 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a5506f09f5so545882f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004885; x=1795609685;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ByWoUJOn8xt5bIjc/DgDVb/Znhr0IJHP27C3VPG/e4=;
 b=mDfsPJxQn/pcgLbUuuEZCyWWexK6MQR/Nk6Nbi3qYMvH6gBv1XSdMK3+aC665JMSz2
 qX2P3079gFbE+nBUko85AlS5RBYHAXbvHPxEhWKB3LFyISIXHZRpD9YxhA23ITw8ERZ7
 jnOouTNAxhZ7zCqTTfqVTYd+ciPwN4tWtUCj+GetOSM5PeyafiQjMCK6LJk0EDYIQKyw
 ocfPUkM7sKx/05tXYwuFzNPgWjeSRQAc2al0dw7D8avuf8yfRsquX6dXUhmWJXUYoCFb
 IVPCOx4QchSsnd6WxTMXmCnf89SUAcJqefo4keSYgRIJyVM81AGFL2WbeORCi/FK2Qdo
 K6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004885; x=1795609685;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ByWoUJOn8xt5bIjc/DgDVb/Znhr0IJHP27C3VPG/e4=;
 b=JMOtVSgnRQvcobvJd+fByGGUfqqJSZh4f8lp7hvXrloEkz+Q7L91AzyJodi5SutkUZ
 dFgl+QwrA+tRrnlf2v6o/NiJTPzQyZIHo6logubU9Gc8y0uurjpdhqp3LV7ra1kC2dnN
 kue9ZWqtG6922EqZHeg1LuzVLL+jDq93O6rGa7kiwHSOidXWEIa9x8E/4f6JOGivcBYT
 cVQO5JJylx6z7IOTvI1VbAprl4ajcPonN1MrD6nX1qcdfT6xtLZVqByx48ywb+EmghHr
 nxkLm4Vmkc5M/gOW0BwfF4CrYLDqNAkTBQ3kMkxEwZIwvtPaSKGgvHeuFyr4HKUAnTvs
 G2hg==
X-Forwarded-Encrypted: i=1;
 AL+hErE4GMEwCU2fTCcvTEK2uPpv3AlYtoLHIPLGZlDivRwkW0Vk/Jaaf/K1YoI9ndS5fXKf7TXUhWVS26w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/MJkRMFaAa1jIz/ba+r/0yiKa/4nGx0daJNYivAS3ZQPrr2FjT
 Urp+xNo4wIJOrOeneh5dj09ntAXIEAU84cyYsRjsksw851uaNHEpSh2vpaAZ1CUoiWU=
X-Gm-Gg: AZFdTZelxJXzGuLCNv52OiiS2eCRpZCTeu+jODetdl+d4ZpKXs9ckByIIEfQ0y2+AfZ
 D/LJ1ITDCoPUfyh/b3vLUJd71SABO+zFz6kxTjNarD1pO+J4h6TO+Y6vPg8kVruq1eJNzcZkwDJ
 MFWUPFCaX2HHVUNhJWtK4pe32iNkrwEONPHA0SB0wUbhNXAe5JCpIFR+5Extuis/QmPy7yyfK3m
 cfGik3grvC7h6AThleTs7sjtnnLUwpCTPKkSXJQ+7BFNvkYe6ptI2kGdZLy9geAmiGVODKqEHsX
 o+C+Nsn0RNQwPAhfSN3w8ip4KTWfC0CPtfTKX0IJ8uISv1Y6HbTdMfRm/2e1zE4+/HCDU2c3yQB
 3LCNt4PEORhKRODd11r33Ulg+ncBipqQeMxbN5LYheJHClDPrJTSYjyw7S+cQfJqqLsssXfCAtU
 mX/BTpU4a7qApsZAQxhvi1JdVte1HH5AAqnCXgtv7GWnlZtNKDHLfHbWQZtbOaDPF94ITFeqZB2
 c49jnZAIb+ifGv2XfcBb7spUAg9FEhgi2mo8yHXkKH6NWw8IsqOiy1XEh/7XjAKaBH+Ix+JuaxZ
 BsC4lCNcqQ5JkkJg3ZfTmL+aCFCBUet4Q+0MpNXwK2sSLrp8MQdGoISUDSwuo6VXYqOXIYMW8UE
 xzw==
X-Received: by 2002:a05:6000:2608:b0:4a6:8012:198 with SMTP id
 ffacd0b85a97d-4a6801202dbmr3938687f8f.31.1795004885474; 
 Wed, 18 Nov 2026 04:28:05 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c23bsm4011448f8f.12.2026.11.18.04.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:28:05 -0800 (PST)
Message-ID: <c5068359-e155-4374-9f3a-1b89106c6fb4@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:02 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 09/12] accel/rocket: add RK3576 NPU (RKNN) support
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
 <57874e7459ed84ad47b2e31a62871ff535da249b.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <57874e7459ed84ad47b2e31a62871ff535da249b.1794615323.git.gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> # Conflicts:
> #	drivers/accel/rocket/rocket_core.c
> #	drivers/accel/rocket/rocket_core.h

This needs to be removed from the commit message.


> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
> index db137e2ec15e..868af86d00ce 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/of.h>
>  
>  #include "rocket_device.h"
> +#include "rocket_drv.h"
>  
>  struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  					 const struct drm_driver *rocket_drm_driver)
> @@ -27,7 +28,7 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  	ddev = &rdev->ddev;
>  	dev_set_drvdata(dev, rdev);
>  
> -	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
> +	for_each_matching_node(core_node, rocket_dt_match)
>  		if (of_device_is_available(core_node))
>  			num_cores++;

I think it would be a little cleaner to do the counting in rocket_drv.c,
and pass it in as a parameter to rocket_device_init().
Then you don't need to share the dt_match over two files.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 68df1596014e..59a6f548e108 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -31,6 +31,11 @@
>  /* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
>  #define ROCKET_REGCMD_ALIGN	16
>  
> +#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
> +#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
> +#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
> +#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)

This introduces an inconsistency in the way registers are handled. All
other reg definitions are in rocket_registers.h (originating from mesa
xml) but this one is placed here.

I think you should add it to mesa as some kind of register variant, and
then regenerate rocket_registers.h

