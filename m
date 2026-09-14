Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E928C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6276310E54C;
	Mon, 14 Sep 2026 09:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BF+/n0ic";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0A610E54C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789377840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tb/KsUxM9jxkMjSRJHpE7KiQY8ZPLkB6sQ8Hi6kwrEk=;
 b=BF+/n0icy0NlsGO8AsKL9U36iiZxwd3DNEFzhxipypD0oJ6LmWBd9RDpQDFhgw7EWYtIA+
 7Z3ISjxoqbmyP6iQq/klGZ+pOx64+lHU0gmQAIO88i/SoFCZHZ0Ez+/NzRw+U+g2YKDZ8A
 fS43SMkAsyZHUK/JJiLvskVrLToBf2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-l-r99kkBP2GvEsBB1nMGRw-1; Mon, 14 Sep 2026 05:23:56 -0400
X-MC-Unique: l-r99kkBP2GvEsBB1nMGRw-1
X-Mimecast-MFC-AGG-ID: l-r99kkBP2GvEsBB1nMGRw_1789377835
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso24912895e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377835; x=1789982635;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tb/KsUxM9jxkMjSRJHpE7KiQY8ZPLkB6sQ8Hi6kwrEk=;
 b=gN6T9ABd6tPQfZ9jfUKFUjxPEetE6T/fNvMsmCSjATfe8+naM3JKh2z0uf8xX13Csg
 S5ayFJIh0ZW+pKIu+i9krBIFUFmGKe/DmHWib+Cbj2Kd0dZpBibjaXPEHRCNz0IAfpnN
 iqX9MmXLkqY2Ju4u+6X6/vegG9Vwr5vOVZ5ssQC/3XyUB8A3Q6Dha0M07K4v7gB7n8mH
 2wN06g+6ROMphoaTvQG7QChIShMh/gPC7S5gQPKf3rm3h6/YF5aFL1rYSm5nUKjdVZc6
 vGmB+0Sk1sKJ2zY7E7v19AIffbIRNAFT/uImLDRsph428tmq9AfVc+wYt7vitGxEWE6O
 K94Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhAigd4DN3rIOZjsu1dZBBVE+LMT474Hf+ZttuMzbv0ytoWo7hQQRR5rGy/8bz0wCAOv7+O1Kle4c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mm7X9tLgBRG6C14pxNfA3vb55M7B3Jxqjp4dzowokjNo/DBSeC
 hefElW9bvUqXFkxfQ+8XkRTsPK7NdeMzPfEim1UmBZxuQICfv9v401CqXVZLJZlIrocb5sDyLsU
 OISfGlnhPPbmSVtAa98NguRnE1ZLUeXg1HH9QL4YOQ05kOQYXyOA8DrQ4KiU2skuJBx1n3Q==
X-Gm-Gg: AYBFou0GhDLQXOa3KllwtYD4jQ/kp2iZlm/Nb2QdKnjp47BjGWezXz24iNxrZKsVIVX
 R/oA4dJDoWpQ1tWLEMOIAX3+kiY+e1J2tOf4ddJwnBkH2gqQ2732uL6yI0Po2ReLBmuOdQYUI3Y
 3p9Naax6HnskbIzkxJvHIWfvb7Dc7nghGMpKn44YU/Vl2Q0JF9MWoBjqg5irrKRVlEBNPsNiBg4
 Arm955mvuVPD6cjAscrbPn5ISx1Fa5dXFR8G4qoEBm12YvJcOqV9Naqhqpt+T8vF4PSGmrgzbbP
 z3uXulrq2kiQlY2Js8LKvsniiBJjFY25m+48ldHYMfcV2wEKb/ACUUFFxOke8cHkBcxkDZt+oqy
 K5hTx3CBHW/ILMMkAdkeYIEjmB4thA3ybkUvPTHZ5C3kXx/bi6XUwq5OCqQ==
X-Received: by 2002:a05:600c:628f:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49e7a66ae3dmr16857795e9.21.1789377835276; 
 Mon, 14 Sep 2026 02:23:55 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49e7a66ae3dmr16857405e9.21.1789377834915; 
 Mon, 14 Sep 2026 02:23:54 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm399519375e9.2.2026.09.14.02.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:23:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Chen-Yu Tsai
 <wens@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Liu Ying
 <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>, Philipp Zabel
 <p.zabel@pengutronix.de>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob
 Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Philippe Cornu
 <philippe.cornu@foss.st.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Adrien Grassein <adrien.grassein@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simha BN <simhavcs@gmail.com>, CK Hu
 <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>, Yongxing Mou
 <yongxing.mou@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: Use consistent indentation in
 the example
In-Reply-To: <20260913123331.100293-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913123331.100293-3-krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 11:23:52 +0200
Message-ID: <87pkyg1907.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sxZVD4XjbAIyKWA2GeVeHSMxK4OLRWp4p_IRpcbBu38_1789377835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> writes:

> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

