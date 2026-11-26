Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB97606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VTE6XHu8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB381120FD;
	Thu, 26 Nov 2026 08:09:23 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22D710E394
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:16:32 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b4c2da74c0so42485967b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795655791; x=1796260591; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QlSPO9+8YS67Tn4rbTFkn+Zhwur7gCmRYFgUkoNRUs4=;
 b=VTE6XHu8PeFhxxEMtCEWS2qvd3ZVikIN7rZi6znUvFhKNEj5bSAqs8+gpqvVOD1FRf
 EQGEWIlV0FM2RaNq+nV2Q/vg5DYCWHLWMRKbDJqcn8A5aRFpT+A+YU2kdwtn4BAZC5/Y
 0WTVrK3ELjIihwj8ggwoYMQCqO8vEiEDzY8KP0iT6iIEiZjFytAk5d9D7csWzccG7Ysh
 uMtgGyh63ZE0n9vBbMlM0nyTRo8bqXSs2NVN/PeLZh5MeB4/hgAsPYoNs3zFmi4Qr7m9
 UM4hnhdOIE62pCNTjYQ9Y+4N5gR+khLxWYVPj3Btq7dGzI2uubIPlvxEMvt+lpyxNBQs
 c9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795655791; x=1796260591;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlSPO9+8YS67Tn4rbTFkn+Zhwur7gCmRYFgUkoNRUs4=;
 b=YdfPdbl/QTkoJoKQkYsFEu2ojAlL648RdqJYX78Lj1E42RyQGU9utqlFaRBfkqeTUB
 pOW8auLfChBWpLaNAhou6WXXArilzYpNOtZfOGi4To1PeFpSER321dNP2a3LkIEk0B9w
 VoGfIja6ykZAP/MbegjJBQ0uRG1mN0qolvWC+JFIC40Cfz4DLzTFTM3VWpoq3fGATBE8
 djyTfvjATx90oDstoAPchCr1uxmidlTHQdTnLu/nE4CbpiabTFto/MqiW/BoukeONnsO
 oMMHoEbSisBlXAZbAB12W4lW/k7Ty7q2gz86lFk2hNlj7Ee438ekVlcU0zsSP8qlFmrP
 7IBA==
X-Forwarded-Encrypted: i=1;
 AL+hErEHv3r28lLeQ1/Td5OIrCiPFT0OOQTsznALPkcfsK7GbrFr0DjTCIJduhDaxL8Sgerphiru8qOYutg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+adym67AF4o7/wTq6MplsVpbLiqbGpY/diQpnD521QUqSzm6v
 H+ovyRaUUjikAHYlzqCoVHrvTY+uciNPf+5wQslr79hPVaXXGHl/hfQp
X-Gm-Gg: AZFdTZdQ7GmisufeJRtG8kHCMYYaHsd0wCIxUjJiGd1jVHSJreE7CXMlSBTvlPnQx85
 Rr82s2AiG/OWrfFtuYQKVoyLG1JVMGPMcdi5pYV373z5btKospksfN8EDlbB+SCXu/xgZaXjsQ5
 +fvFbSdR15OFeZ/QwzOqDPMG7CzT11U6Jfsg9It8cBf80FZAgTsblBpHv0r+NrMotqX2Ps1cj0i
 UgTvfZpLJofzylYii+246GUTYNnWyypz68wKE+GWBrly/BaFU2q/MMbirezffOqT6SSpLztBkz2
 IAEslAIReJC8j+6GPeO9yGZIEAW2KhXYTaPyeeKgF43iyyWH7enManXDxhes74bR8i8KpQGyygZ
 r+6R9Gm3/fOMl03PWUH6T2hXsPTS2L/L+gD4cBvdTsBmegPIXOp21jQtQMPSXGMstyX3W5gJb3v
 9vKOfOaV5G19Jvwmu6Zkw515dWg7Ok+iK5qdhaZ9cNXHbQlHNH11gPdWqyJZ1irZRIPlROrkz6s
 zfY7u576ttAWIoYuEQtIsEKsSH2+/EL07LydFTCNqkMQp5rCkZHEsGHo43yGY7WPrlKAqRxCUzq
 pa5LUv74TwxTHVfMGYHRrjL4
X-Received: by 2002:a05:690c:6a06:b0:8b4:d0ea:ca9d with SMTP id
 00721157ae682-8b52045f6c5mr70876907b3.25.1795655791098; 
 Wed, 25 Nov 2026 17:16:31 -0800 (PST)
Received: from localhost ([120.244.9.31]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b575ff89c0sm12140497b3.0.2026.11.25.17.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 17:16:30 -0800 (PST)
Date: Wed, 25 Nov 2026 20:16:25 -0500
Message-ID: <9ec2f818084f2e723e8b82218a302258.docular.xu@gmail.com>
From: Guodong Xu <docular.xu@gmail.com>
To: Cody Kang <codykang.hk@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Icenowy Zheng <uwu@icenowy.me>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Sarah Emery <sarah.emery@canonical.com>, Ze Huang <ze.huang@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Cody Kang <codykang@vsit.ai>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 12/17] drm/spacemit: add Innosilicon DP/eDP controller
 bridge driver
In-Reply-To: <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cody,

On Sat, 21 Nov 2026 15:40:51 +0800, Cody Kang via B4 Relay wrote:
[...]
> diff --git a/drivers/gpu/drm/spacemit/Kconfig b/drivers/gpu/drm/spacemit/Kconfig
> index 8326a7b98151a..4667cb624401a 100644
> --- a/drivers/gpu/drm/spacemit/Kconfig
> +++ b/drivers/gpu/drm/spacemit/Kconfig
> @@ -16,3 +16,22 @@ config DRM_SPACEMIT
[...]
> +config SPACEMIT_INNO_DP
> +	tristate "SpacemiT Innosilicon DP/eDP controller support"
[...]
> diff --git a/drivers/gpu/drm/spacemit/Makefile b/drivers/gpu/drm/spacemit/Makefile
> index b3b148000cf7b..260d316a271b5 100644
> --- a/drivers/gpu/drm/spacemit/Makefile
> +++ b/drivers/gpu/drm/spacemit/Makefile
> @@ -9,4 +9,7 @@ spacemit-drm-y := spacemit_drm.o \
>  		  dpu/dpu_saturn_hee.o \
>  		  dpu/saturn_fbcmem.o
>
> +spacemit-inno-dp-y := spacemit_inno_dp.o
> +
>  obj-$(CONFIG_DRM_SPACEMIT) += spacemit-drm.o
> +obj-$(CONFIG_SPACEMIT_INNO_DP) += spacemit-inno-dp.o

I noticed a corner case when testing module unload on v3.
spacemit_inno_dp can be removed while a process still has cardN open
(say Xorg or kmscube is running and somebody does rmmod
spacemit_inno_dp), and the DRM device then still holds references on
the bridge. When that process closes cardN later, the kernel oopses. On
a CoM260-IFX:

	sleep 20 < /dev/dri/card0 &
	rmmod spacemit_inno_dp

  Unable to handle kernel paging request at virtual address ffffffff01ac5188
  Modules linked in: spacemit_drm [...] [last unloaded: spacemit_inno_dp]
  epc : drm_bridge_put.part.0+0x72/0xb6 [drm]
  [...]
  [<ffffffff01b0b142>] drm_bridge_put.part.0+0x72/0xb6 [drm]
  [<ffffffff01b0b19e>] drm_bridge_put+0x18/0x22 [drm]
  [<ffffffff01c41318>] drm_bridge_connector_put_bridges+0x34/0x7a [drm_display_helper]
  [<ffffffff01b23400>] drm_managed_release+0x86/0x116 [drm]
  [<ffffffff01b13cce>] drm_minor_release+0x68/0x80 [drm]
  [<ffffffff01b1ce2a>] drm_release+0xd2/0x102 [drm]
  [<ffffffff802b325c>] __fput+0xa8/0x248

An open cardN pins spacemit-drm only. The last drm_bridge_put() comes
at the final close and reads bridge->funcs, which was in the module
of spacemit_inno_dp that is already gone.

Other DRM drivers with the same structure, rockchipdrm for example,
put the bridge driver and the DRM driver into one module. I think doing
the same here (add spacemit_inno_dp.o to spacemit-drm) is the better
solution.

Luca (added to Cc), is module unload something your bridge hotplug
series [1] is meant to cover?

[1] https://lore.kernel.org/r/20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com

Guodong
