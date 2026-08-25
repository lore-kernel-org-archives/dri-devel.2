Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F5C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 18:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5757910E1B6;
	Tue, 25 Aug 2026 18:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUhuBEVi";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2093A10E1B6
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 18:40:01 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-45171f2f608so196537fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 11:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683200; cv=none;
 d=google.com; s=arc-20260327;
 b=n7mX5s16wgwiU9N7wnRhYZQDQ50Qgt99OWkTjm2cGbon/eDjZCFpvRefSyBHravzKM
 5Hbsf/bKSY7739e9Gquqv115M8FmX7oFaqdBmR/0VSYvkl4+O6jC2nnrtBuvir/amIbc
 XMbjr32JnniMeiEge2AuE+MFnF5W9Gy5+HVmDtaV8zoDZG+aGBWLaIrgEUu8x4xM0pM/
 ZERP5My31ev5L1C3sCMR2uhFqNUG1Yrcf6JudP/0qrMsYjdgeT0L452jRy5VhzFhh3r9
 /M6pNAHUC9/yccUL0ZfqTMxh+3EEHBKV3nnfo6tk3OfwOj/fjh4hSu2BysJNTRg4GKV/
 LE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
 fh=Ip2z8fEsEdRAOZhBc+m9eUDb7t4vLNF8HzLLMdwiF78=;
 b=hM9tNox2v0MqUvbIRwRL+eD+e3QavUTIDp40ZXUcC7AcgJ+exWo8V3pnbvHekmXqeN
 sHxY9ReHfFz/g5RTBRTq7bv/ed32BNqlO0/5M4p4EL+igaKQaxxsClthc+UoLl6Zeo4g
 rZ2CZPoh3wiasDBAPlEhsgUSm9mOoki30ectTikEXbj4HT7M4vwENb6D81TTEkDRdpxx
 NgvQasj1edQ3drf17w3x74NO93C/WWnd+xBYHkgHbd4Vu31es7W+6IiKHra19JGzMEtv
 p7GstQ+tjdFONaEiNetjltUo947AhYyRjgMUD9dphbkrKl1/ivUl42f603JqzdpUNhPl
 ErgA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787683200; x=1788288000; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
 b=bUhuBEViBa084ZH5u2CcXuMvCbwxMgmJxZwTrriX+7W5EVogiXeVHKmjcBr/bxM+Gx
 Y3wtNivf8GKcSEmUuvidrWAS1kv5Dx0HIfjYXVgatcFydRALRRiuu38axc3LRcmVPvNw
 8K0VhIDFQrIOmdtF/OD/RhU8r18RpYh8oxg1axXDBGNEsNHL4mwhmdIXXEIjZx9inrCI
 mB5h1YV5mXbAY87wEOTOA2LH996sfXtOYZe4Cmm6zbR/wZ2nI7+BsXPU3y9X9XyZSJG3
 PXdn0OtJpvV3DvCy4by06eIxaN9BdDpNq+g1l0r4+8EYyswLZqlaa7ipAQSzEYRnGdbc
 n5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787683200; x=1788288000;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
 b=TZTmrL7gkuvH15WsboXBh5CA/ZUFQkv++HpmvPXtDpe6dM8lW8nCQ6DG6C2jsYG85Q
 zvY2dhvLTXjsqL4G5fmnV1nuHvHshPcamLNvCcg2zSYsWjAQtqoIWUu2bWUrRxdmTLlF
 +y4nf7c4/e16AIZRVTRAd9LSo8VGg5YRSBgChRMmOQ9g07Dj/jttIULQS+uoNuSfzNuL
 Br77/t2a7ZN/UeC18DNEqtJvQ8IBGnRKzz7mstrtDE2bwlqapCPKkM8qsQdV+xrTVUM7
 kTXhOGAdNgj3hr/tkyK9iSaXrfqL7GR2qCD8yqY1bxOcH5hvE3o8o0mZugCjk5yDj05N
 Ckcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvltY8XYb1LwPSV3r1Hnsf/CW/QOclsTVHn9qT7p+XrVEmnJVp9YQ0S4KcCTPIiIQCkH8xSDp+4X8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLO1N5gX17fmnx0v0e56YYE0tPpSOw1Z8csgBVkQ24HxMUPBUA
 iqlDSTPDI/CKLOL8qxQtglHtXwqya3pEOYJKDvyTCdE6bxPck2Z6GRK9gX70euZ+VzQp6NRUhHY
 do5p29SeEjPIJJzulny7uU9GMKKk95zc=
X-Gm-Gg: AR+sD11B0neVYo+2lpUrQ8O/d0+9IS2w4M4QuIdPmFMYjiVQoM4TE+32Y1jEtksfWOL
 P+EgWXEQC0th5IzahQvxkPKUnZIJ3w14rguryiQMaUMPmp2XSOlMzoY5ctO9v09wowb0qhn9dWz
 lZzGWoIKof2vD4Mx5cMgg3XZwgfnf68I5l5fix9MYDYTVBtZInCqicrQcDVDlfgBlmEx+SqGMTq
 epw1ctbUrHUYPKcGlIWg09bh6lvJmOMZgdFRCHczVQy+IypdmycZBQeXNOkmSlyNQz/8kGqXs+w
 FWQMlThBPNyE662OR95NTQeGRrZklirwcFWRTVebPdqE6g==
X-Received: by 2002:a05:6870:f623:b0:435:16e9:f288 with SMTP id
 586e51a60fabf-4659bb24b93mr1602806fac.20.1787683200126; Tue, 25 Aug 2026
 11:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <e393996a-3ef1-4c43-b762-af8cd0f2a4b6@suse.de>
In-Reply-To: <e393996a-3ef1-4c43-b762-af8cd0f2a4b6@suse.de>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 25 Aug 2026 20:39:49 +0200
X-Gm-Features: AcwNN1Va3aTr02pKhzBqoinFUkwxjfSbh2WQ-EpZwUvKwCIdS5rdnwq9NOj-ZWw
Message-ID: <CAJpoHp56yo+eQAYjvR3ez=HTSzapCd3dYppo=MdPx-Lm4J4DQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] drm/drm_simple: remove drm_simple_encoder_init
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Liu Ying <victor.liu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
 John Stultz <jstultz@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 virtualization@lists.linux.dev, imx@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-doc@vger.kernel.org
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

Hey,

> Diogo, do you want to send out another revision? Otherwise it's time to
> get these patches merged.

I would keep them as is, unless you see anything that should really be
improved before merging.

Best regards,
Diogo
