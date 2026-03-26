Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEF109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5955310EA02;
	Thu, 26 Mar 2026 06:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BgQfXCxa";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DC210EA06
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:58:43 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c742bc88d87so292645a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774508319; x=1775113119;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdEPxGlOLVBGmER9WSTa0ssfO+YRW1Jn+IHrzAWzqJM=;
 b=BgQfXCxaqQbRzduPq5Rr7IbvgseFz+NmRR4Js9LbLeCMkstw3nkvC7grjvewtBnwoQ
 V98R0r9JhE19JaGcl8r4SMcrbCk2h/uGlUxILamNtOMXlw30zp9P0WmSG0BZ054+DTsg
 0tr+Y+/K+KBsfDwkynTDphMUZx6rZYwBHyLno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774508319; x=1775113119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SdEPxGlOLVBGmER9WSTa0ssfO+YRW1Jn+IHrzAWzqJM=;
 b=STkyzAvelRwLmfSHWmYCgo8kH5cLtgwP+TUE0uzVTjmUebyfwwLPRLJ3wiHJuxDwvI
 vC3PxNd4JBatGfBDJHgjbIVCNb95lEX/CE4LAJG2/7iUvxtPaL1p9r4pvV5YuP+a/mvH
 dpLrGnGhjmkFK7gd5BI5o6ucO6+gQeBhHa3klBB8c9iLfky1nIeIn0NH1h92cpFezIhl
 +tXp3cLMfDNsnF/UD9vAF32fIY44HUsdnXbD99nJQXv6163p1Mtqi9xFaTXaEEcuFIQx
 OfgMKQ4dlK8lGd6V0qVMZMETcQylP0YnAqem9v7+XO8SKHzDy+09U1jKC3wQAoKMGMez
 nHTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRihJemQ4ncS5G4D63S/hoIsrsF0BrpcrSKD9ilf2daeFKL0NNHLUDKdu6NaUhDXvj+EIYMcyNlDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yww69GY0MrJ2qTbnC7ruF+ED7/5zgkqv5g57PSUKosJKyFr+f7G
 MBrpsoT2DDdz/C5M/UzBPj4JUe2nthPBaJfR3XLEYaS8eROJ0ph8gXeLwVKWY/QdGw==
X-Gm-Gg: ATEYQzzjBIc58lJ6WkHcKZ+cVesMA4Nc461UdYnXTNVy+tyNITG++krp+GjKNh5xxDo
 PcMS5qa9C4AxiyE96UPX7ndu2kKZSygFzrvgsJoL8mAjuA/fh+U1nRSkph/dvMIGeWpycVK3ytQ
 jmO/F22yTZIpG0BhRrIVBs9tqxL2nsUQPaKPlhXsggjQBfKkomPqztSevDOC9Jqj1IWujbXIjUz
 Z/LB8CW9Q+2crKSK2Pja/sbkjaLQennHg6qW/jUnlW8xDIIwzU3iiFQEzKfLHno6AbpG4GFw0/K
 LlKsFBkL6QQpj8jGt1lBI6Mbhgeln9IPRLDSevfoTwCt12P8PrJDndi6Mt4KJWsru96u8WlZNmK
 Oq8isrczRzGfFZmfWtjJzpF8Oiypz/a/CxOn3uJ+vqQHjV85tapwQesumXHC7H2wpwSmxpey8uq
 FgBwHU6MI6VjzO7eR3zT0PsLK8Q8dYrdn7c2OVQosZwT9GhoQ845mfXlQYrivyQ5Y3OCCtBruKO
 DhZyEI3
X-Received: by 2002:a05:6a20:729f:b0:398:7b1d:87ce with SMTP id
 adf61e73a8af0-39c4ab57c36mr7202940637.20.1774508318941; 
 Wed, 25 Mar 2026 23:58:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76736e54e4sm1345254a12.0.2026.03.25.23.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:58:38 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-sunxi@lists.linux.dev, Paul Kocialkowski <paulk@sys-base.io>, 
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260311094929.3393338-1-wenst@chromium.org>
References: <20260311094929.3393338-1-wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] drm/gem-dma: Support dedicated DMA device for
 allocation
Message-Id: <177450831563.1057981.13951871384462146640.b4-ty@chromium.org>
Date: Thu, 26 Mar 2026 14:58:35 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 11 Mar 2026 17:49:24 +0800, Chen-Yu Tsai wrote:
> This is v2 of my "support dedicated DMA device for allocation and mmap
> in GEM DMA helpers" series.
> 
> Changes since v1:
> - Link to v1: https://lore.kernel.org/all/20260310032511.2545500-1-wenst@chromium.org/
> - Collected tags
> - Removed reference to mtk_gem.c from the Makefile
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/4] drm/prime: Limit scatter list size with dedicated DMA device
      commit: 864279920b2b2c1dd491eba0d0c64764c0c03d9f
[2/4] drm/gem-dma: Support dedicated DMA device for allocation and mapping
      commit: a9da24732aaa80d631bffc8a1390836d4b896690
[3/4] drm/mediatek: Set dedicated DMA device and drop custom GEM callbacks
      commit: e21b1a91430d5ff626a35f72951ed80268e26de6
[4/4] drm/sun4i: Use backend/mixer as dedicated DMA device
      commit: 25e90f486f5bc8f606f4263c9d86e2d2b1db4613

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

