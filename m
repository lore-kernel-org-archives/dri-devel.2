Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FF4C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7205310F38B;
	Thu, 13 Aug 2026 14:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="acAYIZk+";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EA510F38B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:56:46 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so904381a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786633006; cv=none;
 d=google.com; s=arc-20260327;
 b=ZL5cZ0FB2VIX0xJWyDsltt4FxdjoCoSy+OySFKRskQf8dxBn4uASQ0JksE6kCGu8q1
 l7PQfw5L/iv87YuEctgxsHfE1LrNnS35H7yV2WK/bmbp+XJM4a/CeGxhF4xHQXuJIyvN
 pc1tiAVyXlYkLHlJPy2fzEu8a7lN0QU1aJqTWIadMh4jvQPrOzNMxcV36FB+DC4NzrL4
 T1cAOAVk1NZ4RBRuTHyQhAJssFB/Jwimk1S1lxZYF/7w5f71fCIVBlOJoNPQZhdk+ZVu
 VPRtylj8ZbEEsT0BL9PHtvElywJPledvDvZlFrj5Tk1WAuG5CUucGEdbknkMRPWZ+jJl
 c45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xq++Qn1xDsOmBUH579ICrWONnVsNFNIKJyDQ1d6clA4=;
 fh=MKcqeJYx3VK1gWj//3Rx5CW3X4RLFi0QZ73s9BaTnXg=;
 b=ZPN/++lkoqGmWZDTtYR85Azwd8wYW3d1CSA/F3UJ2cH4WTgI6cpEqKzDVDwustXdC3
 MxU8KHr51tx5yRWNarbtMvZTmuCX5myYB2gmDpqow0qkYr1fFxRdWRLmc5adPiw1si0o
 5T5uiejRDi2YcN51pEqb8w75Y+81arsCZ/0Oy04jSJC1GPhfh5qGm27M3YppQzka5pci
 8cLXL1yIt+XlAX/jDeOvMwpZZY9Xq2xWRFrW7wEAqV7dQiLUT3vWDuZDnnZM83DFodom
 h77qW0H4vkCQdgulo+ia3ibGhw2vASrgCKK7mPhRqG0UkDIlZefYfzIT6k5+7js+9ZEx
 F1Ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786633006; x=1787237806;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xq++Qn1xDsOmBUH579ICrWONnVsNFNIKJyDQ1d6clA4=;
 b=acAYIZk+kOtzTdj650bk94xroFC3a22VqQm0tvU75P0dVukyFV1quZqLBefrJEad42
 uC7UiKQdoG2uun7oC/X8P6e0fo170CRqXf7AZmyNLCTqgca38otCjraqkaRLAoFEPMAe
 ff8IzIqeQSGlGMw1JlYyoKHTHZKVelsCSDi5BNLad7IRZbRTk29Bm6vX4faXnw/KPLsI
 zpfogmgRzBQvDH23onasVhGS9/YrpjtxEFjgHQUgqTqDz6VCJlGjcwn1Ijhui1FkaT4v
 ym6paSr+4dRLcWkNW4bhFw0gECdCxHzVGmlxUvDZnC+OghCHRCrj6aqocq+Ik3qaWZlh
 TtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633006; x=1787237806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xq++Qn1xDsOmBUH579ICrWONnVsNFNIKJyDQ1d6clA4=;
 b=joaXqpielW5p657KENqueQu2DYjy7FHu3tupQCTFc/dfs/VCrbgJ4ZfxmTMGCQG1J1
 XBF3//aumDLFe4CoDc7kNuzscMV5vEfE9PNTesA3bNz/CguF/5eM3Y6cA25HjZOVUfTV
 MtditHEdfBJ4L+xsUusrVBvIVUbLrkdqtswuaMunBDNI9YyFEgq3vXvtLfYuJaqkA7TS
 +Rusqjw8QGMvrECJToCLYSpm3OeRV8D0OVtPRJaKC7gQZLclG7TIruyjLn8owfYIVmf1
 2clah63yGIowkjmiBjIgIrXWBgstCSCVIVC7ltpClcxRj20pVpuE9D20gSOkWmhnAnJs
 eqww==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzDeu88klJJT71fOzdOxzPbNK2QwyJtmtJ0a4e8I+Ajxbe1NSI4RO8GCpXYDNovIQ2l3O5Ap/V6P4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIpM7hd7kuhiVmh1ODwcnCHr9f1seQaadFDk0M6AcwSDJUGCJp
 N9UC8ht4uibo2zRkC36alFyGDMlKn2rlWvFSDLg/WNFkQM/p9oFnTcdVeW0zqgJ7O3o0kjSuBdD
 TTXE5T7XY2TMMVDx8+lYURK6S/W9/tvPs3xpJ6R3N8Q==
X-Gm-Gg: AR+sD11V/kxUmefCCK/OOuDiGYgUOwWR7zSiXhvFENn/QSiQbfLv7Loml448VI08uZo
 9ohiPkR4vz2S//d/KY09tZehIE5ZzV1CL+riHL/Af5eW/6llEEEvCOVkV2Sc8FF0CRRUJAMiKLU
 StOsrbu3UrFCG/fCmrE7bhV8f43ilO0FccffBoWj0sOggv8qT8cQWjM4pFoJuQmiEdhqz4fYA9W
 1ZG9R+tc0J9T09sbMZWRdYAjn20pcCHIbV436juErO7HYIAwVHRnlA6vxrPGVOzr42vChEvevn2
 VUx1Qlj0X9XTvz5qmN+cKAMsvaUvpgWcRfiZFlOWHEZj
X-Received: by 2002:a17:90b:3805:b0:381:5bd6:eb19 with SMTP id
 98e67ed59e1d1-3931e2d5ad3mr6739275a91.18.1786633005755; Thu, 13 Aug 2026
 07:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
 <20260724-scdc-link-health-v9-2-bdda406d016d@collabora.com>
In-Reply-To: <20260724-scdc-link-health-v9-2-bdda406d016d@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 15:56:34 +0100
X-Gm-Features: AUfX_mw_wf8mbHFBpVPiqBoHbpDY5XZSRNwpWrmFgEGAvC8xQ68IRVU4r6Y0j2I
Message-ID: <CAPj87rM3BxAf3+4UZF-qD+45bFup9FV81Xhrn98m7sewZihhGQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] drm/scdc-helper: Add scdc_status debugfs entry
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
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

On Fri, 24 Jul 2026 at 15:23, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> SCDC provides status information on the current display link. At the
> very least, it may be useful to expose this info through debugfs.
>
> Add a debugfs entry for it under the connector, which displays a few
> more details parsed out of the SCDC registers. A new
> drm_scdc_debugfs_init function can be called by the connector
> implementation to initialise the debugfs file.

Reviewed-by: Daniel Stone <daniels@collabora.com>
