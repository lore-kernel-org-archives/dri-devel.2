Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454B606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FRj83f39
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C23D10E342;
	Mon, 23 Nov 2026 06:58:12 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AAF10E342
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:58:07 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386b8624cf7so207733eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795417086; x=1796021886;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B4or4yeY8OHZRKSj5APXjf36hThUdnZ1Yx/De8GBlX4=;
 b=FRj83f39Utoi9Ri9vQ83Fa41y7M9bOrX/K3bndtUZLZJ3Nrq5c8E6byA+hiPfa7H/d
 zcZd1t5nHyj9L/G3SX1WsrYyU+ybx/j/Gq9jSGXPRf3+18JDbs990Tznplfz39f0dk4S
 g7YBjdL5cPpW59uVfZN00g+uENjTZ7OWaVxW/05pgkeGfb48dhiRbuHBmeX+7Phu5obG
 9BYAfvS+08PlFUjQ5rxU8L51H/MpJvB71oiOKLWsx6fTdcuSSd/Lckavgzlr2nN7PkuT
 70EEEVUd9ew2baVR0Azr7IvOovHDOo2ZYSEp8VaGcyJ6APDVVlozZi03gCNBjiDM46mp
 xzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795417086; x=1796021886;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4or4yeY8OHZRKSj5APXjf36hThUdnZ1Yx/De8GBlX4=;
 b=u18AEYOm72WBJDcUGAIY7lwmYe9qoh26p5FzZA53w4gA1NU3CSqPKRSksBn7H/l0nV
 CrasletHhgYIxbYmYWiALbXq7FI1vLrIQ5VOi9JQtf8KAUrGPDVPuwsGwKsq5aX0Mx+Z
 EXMagXPT5eh9mU+ijNeaC0gKt5sYm4o4QPfKCTHITLKiLfFl3/0hqs0Co56YRVEZEXX+
 KQJqLMdg+MQD/NZH/dWHnKJBGtR/OswEJUjJrJNZWhj3gWA6hHUqqtueuWktMQI9TpnG
 AzMXN0fwliI05QAaOxyAozaHpw7v9OWDrjt0fr3hFZWLEz8GwwLGGajUPp528RvPRnvr
 L7lA==
X-Forwarded-Encrypted: i=1;
 AL+hErG6ooolXiOvZR1i53p1IAqvm1inV5tk4s6/v1t3b3N6tspFXVeVKb0+zO+l1/AdYmdAuJ9rw1d3ZcY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qPIc5Tu3PmrgwfAyxHmxw9FHLhepzDElqIh8fTIzqWAtvCs6G
 JSB9Q97R+3uBkJSkPoT+dfA01dhM/aGDSSnBKD76OFFi1FGBmanRzyX+G+hQOGHnZJ7+Br31tsO
 z4SaOt+/OPw==
X-Received: from dybmw18.prod.google.com
 ([2002:a05:7300:cd92:b0:380:c63f:6b75])
 (user=yidilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:f68e:b0:383:d3d1:f31e
 with SMTP id 5a478bee46e88-3856e94760dmr10863514eec.6.1795417085859; Sun, 22
 Nov 2026 22:58:05 -0800 (PST)
Date: Mon, 23 Nov 2026 14:58:01 +0800
In-Reply-To: <0964123eb95cd4a6516df05003f59f3cdb260d00.camel@mediatek.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <0964123eb95cd4a6516df05003f59f3cdb260d00.camel@mediatek.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123065802.322838-1-yidilin@google.com>
Subject: Re: [PATCH] drm/mediatek: dp: Wait for the complete AUX reply before
 reading it
From: Yidi Lin <yidilin@google.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, CK Hu <ck.hu@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Fei Shao <fshao@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi CK,

Please don't apply this patch for now. It breaks AUX reads with one eDP
panel (CSOT MNB601LS1-6, EDID ID CSW 0x1106) on an MT8189 Chromebook:
the wait for AUX_RX_AUX_RECV_COMPLETE times out with the AUX RX PHY not
idle ("AUX Rx Aux hang, need SW reset"), so the EDID can't be read and
the panel falls back to conservative timings. The current code doesn't
hit this because it reads the RX FIFO as soon as the write pointer
moves.

I'm looking into what is different about this panel's replies, and will
either send a v2 that handles it or drop the patch.

Sorry for the noise, and thanks for the review.

Yidi
