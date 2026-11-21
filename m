Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3E606A332
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b=L4tYii16
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D999B10E618;
	Sun, 22 Nov 2026 17:14:30 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D0210E0FF
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 11:48:34 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c5154989984so138442366b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pardini.net; s=google; t=1795261712; x=1795866512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yRL3JyiAib4oTHNTDKyWbrLU/IIxfk4M2prFXzJ16C4=;
 b=L4tYii16SSqocHAh2DyJHSxpSo547b3j2OqgXvEYFHMS97/KATXPrZIa9Rve1+U7xI
 jnrH1PHMc9mfjFZhxm5oW7hPx4jnrX5Jaa/WkNnNcthtUxZFIxnxWfkIBMyhvnMKxJb/
 aEbOSzOD12rINVqwGeQe94Cc2Sa5qfvx5Dzt1yuFZUA3hdiRLp64pnN6XFQwnQaai+db
 T5K9QFl8bTO4wAPreQpX+GmINor6eS0B65ri0dadb+8GTCtubySgkgQdktB/+1X8sXBM
 Uy8YfG1oRqKTgF3KEORGLDN4MaCB5gkTxtasvkDEUK6Fv0GMTDMTYHtUXFDwu75CUA/R
 9IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795261712; x=1795866512;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yRL3JyiAib4oTHNTDKyWbrLU/IIxfk4M2prFXzJ16C4=;
 b=ezqjqXDAe7yp2As8Sm2sslJrAnWEiDsXv6RZr5VNGab9MhDCJHYQtSnrRccKKXO4Mo
 TtD6AvJFVxIbuB0tvm4vjjtR/LmNnq5Z/cl5k0Wp4UFcG19G+akzwq4EMBC9b/cVqbHe
 pVly2tyNN2ZFIqkK+cbDt9pKvkJps/OwXIlYMoiZ+5NypE7n2vLoho5VHpVfbJA0ZI42
 /o87U01ijrUoQidTLnBCq10mS3/fkTux9b+ierrMT4qBIlIiTHc1iEnCdnbP2AX6//jG
 TE/oSbBXOS/c4mGEZUIlRomq0AqnLBlDekhA5HlC0wPMPkZp0bOKVBNPS2TRmXmmKaYy
 +hJg==
X-Forwarded-Encrypted: i=1;
 AL+hErFzL1NwcGJcJnikSwV1q1ivaio53F60FuQA9Dbazcumlf0W0rQJ7k5vFlkCRyakFiGp14+9Cw9IP20=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wmQQ3MdjfpE/ut53ZLuiITNLGgsKvO9dCrfo6pMP/KWjfdud2
 6BGtlv12Yw3Ugdncrkm6a3h4zEjS0YZemLaxk5TDI1umLylxQGkC2PsLCB1J/MQxkA==
X-Gm-Gg: AZFdTZfo6fGM/Ds/tY5gWlYSDYtbhco5rus+uq4oO/JpMAbpCQ2LdKL0SC6Xqr66FUv
 gXa6XUhX8A8GeOjyyhStroLTqgUo01hwkbATnZW41Hpd1sOQsb8nbPKuO96ZS6xU7ZkGEzDPhxj
 D8JOkvLmEFWPQY/srd5xNuM7W6NQyT91BkgXCYWnwggZbt/vjOEc23/1FM23/0dxUy6tVncNwfW
 zTR4YlPTs+G7DKlB0MElePHGvQ9L34dzu81h4UIcrLOJ98lduU4tzld1njUoxnufVTDzyNgJ1Uw
 q6bY8iMXcdbnldBOhDGALST1i06U0OONI38ZK7YAp/OfrWg7URPTRcigVtHsOt283DpJACuMTtz
 lfuJRJUz0r2Ekrv2otyWanNlBP7yYwwK84WoGK1EClvIENeYTqIaL6LVF6+noXAoJwdH1VgpxzX
 4a7l5uZMH7xmu8qx2OWNMDM4luFfUkLYSY5l9CZWs8/PeEufHsA0jXdvHksBbMK9VzjhLMSqd/K
 Ub6MMacOyfUOh8PFexGgWZTQAZRp89YcJNYtIwBfIH/DNBENOLKBoGgySByHggsyesHhcvMWYEB
 6R9Prb72DtESf55udnor94nPePxIXmp1dm4rEZFGswHqDvT5RQq3ytbIBX7jbvtszGvOsNGpJEA
 Ymb4279CVw6/MXfQ+hH9BGDLhv/dVAOj+ioqD0BSQUe3LQgTVdmVOfrBfvCLpq2q4Xk5CQQGVdT
 NN
X-Received: by 2002:a17:906:eb15:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c513a5ed086mr409503766b.11.1795261712641; 
 Sat, 21 Nov 2026 03:48:32 -0800 (PST)
Received: from ?IPV6:2a02:a466:4d7a:0:409e:13f1:8f3d:aa19?
 (2a02-a466-4d7a-0-409e-13f1-8f3d-aa19.fixed6.kpn.net.
 [2a02:a466:4d7a:0:409e:13f1:8f3d:aa19])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afecbb5sm193756466b.71.2026.11.21.03.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 03:48:32 -0800 (PST)
Message-ID: <139cd117-9a75-4304-9e3d-94c47476443e@pardini.net>
Date: Sat, 21 Nov 2026 12:48:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/connector: Cache out-of-band hotplug events
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Igor Paunovic <royalnet026@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/08/2026 16:55, Sebastian Reichel wrote:
> When the USB-C state machine finished negotiating DP AltMode before the
> DRM device has been probed, the out-of-band hotplug events fired to
> early and are lost. Without replugging the display or reloading the
> USB-C driver, the DRM driver assumes nothing is plugged.
[...]

Thanks for this! Tested on a Mekotronics R58X-Pro (RK3588,
FUSB302) on v7.4-rc3 with dw-dp v12 and usbdp part3 v18.

With an Apple USB-C Digital AV Multiport adapter (A2119) plugged in at
boot, HPD arrives about 2s before dw-dp binds. Without this patch DP
stays disconnected until a replug; with it the display comes up at
boot.

Note: I used the rebased copy from your rockchip-devel branch, since v1
no longer applies after the drm_utils.h rename.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro 
(RK3588)

mvg,
Ricardo

