Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D21C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5556610EB87;
	Wed, 19 Aug 2026 15:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rcp73d+S";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5F710EC05
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:46:52 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f5d5dbf80so115765f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787154411; x=1787759211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExnKAVPk+swRg6enIhEeCZ07HSSnP/eXJ5Jbmt+6Xbo=;
 b=rcp73d+Sj1C/saIFLkrCYLU2Q1prS27lA1wEiHoUw6o7AUG7tZCrES5lHiEF7D+J9K
 dkxQAZgNUL53jrOL4ph7uCDXDrQkMyhzvmhN7EjNcurupWwBFkXZS4eZiCIt6KdqBLHU
 cpcGzClodjRjkwX44ghKx8e3WHpQPBPTVXD/tI0zBUpFLlc8Ivw/FFZqlnYMEqpWxBX0
 oIaygNqnx4rKA3hHl3TkYU+hLoqSYaFj1EVWrU992XKw7BbRJWVTTeKq37DM8EbW0oIz
 qhR7j542JqhpCNS0mbfXT62yjNbb3yU5OQHrB86UIbXcbtyu5UdKBj5jMj5mR9xkrXts
 72yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154411; x=1787759211;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ExnKAVPk+swRg6enIhEeCZ07HSSnP/eXJ5Jbmt+6Xbo=;
 b=M4zMPg/hYQAOVJWg8Gc/YQjAUhzn3S9jNHWMN0sgCtIuio8WbyTor3BvFxfUbR+ZXE
 ofbToDOZhoJ/adEkbLzcZkIwEAq+ROgeS4Gk1HzJVOIJP38ByN/fz8NOvD8Y57n4jsJw
 MmVuputN1ADW3X1QhNfC9WFF8LUBwjp5JBleZYX8cYblqh2Y9uNpRrqG4U6pA4bXx+i7
 wPs1CkIVJuhU8PFGUGlLXj7qF6avCs8QuOzK44J7ZaDT8o6lRttoggrHUUZhSF4bop70
 84WqK8X1+cy3/yFbNd9qO2X94e3HIS8UTS+PmsYSG5G33UZ9Tdr/yqvqXOeNds13Aq7v
 tVJw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpen7qZjA/6V+6pKKtAoBnpKAKgQ2VUTewBnql1EGfcazdotMpIMzocXlK8LYyPaNawtje4MaqaoFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1WVss95uJ+uwLNxHcgMSrkGU8h6874RV8wCkdvlCa+835Jpfm
 93B6y74hQo8PEqeZGtxQc8+1nllyUTz7zsEEqKeK4ylQJAAO6lVJ+zhAFjNl2Q==
X-Gm-Gg: AR+sD1292ghRA/3mPZqEpMSZzXJlWK3mm2yPMHWvn8MKnPEItoWhOdnTPoRsm3uW0zp
 ioMdhpoYkCqwxZm3AiZCJiDUBQyH1bVUJH0Dd/+tBe2xy6pDz6gkwC05Cxe8khk7V6qo0RplR3n
 Bz9rtUCYT+JHWnGueciKDX6OPcDesDwg0TOaLMX52Xra2meETevMsFqK3fEOja6hsyx1gZlawX8
 JT2v6QvjIj462BIEIdiGfAfzmG4nyG/hMmbIsf2O0BsUUOpSIgJtEe0Ud5UqdT9CPb8mYsJ6ejo
 TZJaggzsj4FC3orkHKcGxg8gbQemio3T8T5GRR0HVRLnzK8iTjpRbHw1fe3lQp2giFlChVk/B5e
 XPPoQNuSRNCXrzXbXvmaZs0RRMJ+sNcvViMkTeuN+ZJAjW1nVIIt0rRp/aXfpVPleaepZkSjsA4
 wOpT72i1yVf7dAqgcg0GfywHkrnRm7ilzO3Bwm8Hnt99FlgxRT1kcVXgo5kogoUy1b3A2K5mx3R
 SE9HbkOE414nFIiE4m5MlEn5Y6UkNsDPIMm1GcU7yaOmZYAmgbCa//ySlZ35OdhY0cfTg2sk1XZ
 nf3yaQ==
X-Received: by 2002:a05:600c:8b6e:b0:490:ec79:3046 with SMTP id
 5b1f17b1804b1-499aa0e0223mr56044905e9.0.1787154411075; 
 Wed, 19 Aug 2026 08:46:51 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B929600FBC58E6E51BF6D72.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:fbc5:8e6e:51bf:6d72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9def415sm57189175e9.2.2026.08.19.08.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:46:50 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 19 Aug 2026 17:46:32 +0200
Message-ID: <20260819154634.7584-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819105723.632029-1-gahing@gahingwoo.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260819105723.632029-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Jiaxing,

A short logistics note so you can plan around me rather than wait on
silence: yes to both. I will read what the vendor stack actually
programs into the output stage on RK3588 (your option A vs a floor
enable), and separately force an output below its zero point through
the open stack, so the two explanations get separated on this SoC.

I am pairing that with the oc=56/88/120 sweep you asked for earlier,
as one measurement session - numbers in the coming days. If either
result is going to gate something in your v9 timing, say so and I will
reorder.

The correction itself, with the control run and the paper-trail rounds
behind it, reads solid from here.

Regards,
Igor
