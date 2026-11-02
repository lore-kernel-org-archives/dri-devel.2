Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1D60A261D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vDgS+0U/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423C410EE57;
	Mon,  2 Nov 2026 13:40:47 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3F010EE55
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so32286105e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626839; x=1794231639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OwvQ1K/T5ntTIih2Uajc562qVZy7T1bItsBHgcFYO5c=;
 b=vDgS+0U/Xq/OMYMn1UwpXYlodC20Q98XeO3+7F5x5YzymlUeaeB4fzjS/rmYKE/tHu
 TOVSbxZ2xNEhWAlpXYIJcrioKXls9B5ftzgt5EbETP7M6Zq4N4tZSHPskHD5NFNyFX52
 yAAj0mvEtlkvudlRrTrXXptqWzdkVxMhFohPTo5VjrgUrzyDmlyUyDin7eUG7FOINEhT
 mE/u7Ji8SuRR/w4j01OXxXQgjO1BKyYJQJBriZIg1UY3FRraUSLC55sBoGmFDzwce2Vy
 MS/BTy5QDmjv8klYoLiigiVaH43zdOoKCo9aWvryKSZ1YUGXFS9TjtxAEBRycMplSrKQ
 1YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626839; x=1794231639;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OwvQ1K/T5ntTIih2Uajc562qVZy7T1bItsBHgcFYO5c=;
 b=sGgDj07pd4yAzHSx7wFqTlYYnORegWUVGXkT8tDgvs79FLvVxDCm6+HJLQS0S27KMG
 ycM19FM5AB31vA/BtAJHcgIWSWSBuPkC1aj4E0ArS5OyTBkRJIDmlMc1iQWsne7ETFJg
 fkt+BlpMrHAG0eFXY7WopefxHXr8srxn1suMbJb4THsFNF+13a1MS5PrUmg1wmDJCYJC
 SRloF9FiupiavIxjCWaUfqQKcEP3WxSfXmPuf/znfEFBRIVTzde9G/ZcB6e4a/o21PiE
 hBu9FXBQ/H3jCmVmsFMYFv2OBBRlCy7gOli4piLN7/8TKqNjmczAv4iVeV0LmC1Tyb0/
 CplA==
X-Gm-Message-State: AFq9FYJeQu1OD6xSj1qDKXfcGs3Rj3666MCbu0az2i7fnvynRNCVy3TT
 +p94vwT7FEysdOwkJyhCgceI2QGawQOn8rpJ+ovyvstfs1GuCo0w15sAC6FQni+T9o3zKcJwqCk
 I/FlC
X-Gm-Gg: AYBFou1IQKGdKnYlSZO2KN2A5zA9WH/Q271/PGq0ikocSZCxLsszlMwf99LoU2iZMb7
 4OZ4UlFqtx3MpOvYMufzjxvoL6MWURmgq9MqwbgRdRPmSfi1/FG4Gzu8+ecGgk3NtF/tJAaKlO7
 zND6b88RxtiNV2qFBodTI9dT5fAK9SBZTSyEhc//zRR/NpdjFKcSBlXeqDSsdYgUji5ckbfotss
 gHKxMzC0wW8ZytzzExXgOB1g7a2zQiWqUPaBX/GcO2OpfQP8PZHpi7kIf1oKctGXRC/PR8bY2GH
 +3Nj/9BiZnBIv09kE6Cg4swA3flx593JWWbGG0MSTG+s6yX0qgQVSkmvSG1X+h5fIDTaAM5BHSm
 eWOiYB14PTQX3muYbZjMPTy0MKjztNFklQrp57HBlfCs+u3nGNCD91O9aUZ1ouN6R8AUUaikHUm
 mj0+VHaZbgekZ44pSWbkBeVFbAoacdoqMqLXn78KpqP9bLc4h+y79ys6pmWT4OcJevFqen+Fur5
 5zIPtloqQ9GFFAtZTw1QEry+t76Ce3jy73OldVHEB1+us4CApLd02us9On0D9h3FuifeRg7P1iM
 3vSeldBt7ICjJFqKs5KAWZyXvg4+KvL6h0jrg408cZBIv9FzRA==
X-Received: by 2002:a05:600c:8b06:b0:4a2:d:5ccc with SMTP id
 5b1f17b1804b1-4ac17b2bc63mr237869415e9.10.1793626838793; 
 Mon, 02 Nov 2026 05:40:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Primoz Fiser <primoz.fiser@norik.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
In-Reply-To: <20261008053850.2941955-1-primoz.fiser@norik.com>
References: <20261008053850.2941955-1-primoz.fiser@norik.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: display: panel-simple: Allow
 "data-mapping" for "auo,g104sn02"
Message-Id: <179362683780.3310106.8889373164273856192.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 08 Oct 2026 07:38:49 +0200, Primoz Fiser wrote:
> As per the AUO G104SN02 datasheet, section 6.4.1 "SEL68", this panel's
> SEL68 pin selects between 6 bits (SEL68 low/NC) and 8 bits (SEL68 high)
> per color over LVDS, i.e. an 18-bit or a 24-bit input format.
> 
> Currently, the auo_g104sn02 panel_desc only allows for the 24-bit
> configuration by default. Boards wired for the 18-bit configuration need
> the override introduced by commit 1cd3ea3e4b12 ("drm/panel-simple: allow
> LVDS format override")) to describe that instead.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel-simple: Allow "data-mapping" for "auo,g104sn02"
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/47459027812c73d4826f5f78bc8291cb59a5de3e

-- 
Neil

