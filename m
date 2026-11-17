Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0D606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYP89+E9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACD110E0D7;
	Wed, 18 Nov 2026 08:23:12 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F419A10E4EE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:51:48 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8b4f4095a7aso2076477b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794948708; x=1795553508; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H3h9IxdpOr+oov0x9AuL8BUQNJ9C7SGtsH7YFmYPEqA=;
 b=OYP89+E9Eo4iZ4puXnIJVbbyIml2x/DYNCSJ9Hltd+NF9aJC0ImwU9aiYx9n3lmSbc
 8egHEZOAH/wfWy7et0RVjVOHXvtcpC/Bk+h/47ngxy4yej1XkWOVf6NxXJ8h3fd1jK4F
 m3grqtdSITRIg6CplV1fLWisQD0DK4bmC9gKcFT2uV4QX/a49PwGkYieKkyPPTxVoZ4I
 VU6aw6POcDS7zhUq2lYymnLOcIaooka09zXgyaNQQ119IswzrhnliKFQnN/TRiTTCkA3
 6n75yg0n5PBvk5p4rV7jj1uHXrXNQ+m6fxA8mfaK9XLnFLqixbI+rUL65ZmARyQS+q20
 RR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948708; x=1795553508;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H3h9IxdpOr+oov0x9AuL8BUQNJ9C7SGtsH7YFmYPEqA=;
 b=abVKwiiSc+7iXS6ZljhujxeUREpbCAprYaYHPN7FXJGIqNFHS1q9W/CVxbVULKpzmQ
 56grcD9OHc8aPv4H4uuHpddSWOstmCGK83FkG1firrA6yv6lbFBIeyYf5hS4Po03T2lJ
 2EjSzKyF5zz2SAHIAA0y4Tip6ki9lzpqwv/vPrNUxtiUJbjJ7vIkm1FZRxhqzkgKW8Ht
 Xa5i3bIAOepixMFYRR8zFqgyRY6Ivzhntg8dFVAyfBAF2wTRoYhKPvIQjQEfwAYpPJYO
 i5lDQLyxPw+FB8LaHr1uTjLq+PJ7I08knY/MjiQZpCPnC1QyTpccAuIRIKs0/f0i26wh
 f+5A==
X-Forwarded-Encrypted: i=1;
 AL+hErFSLE5wEcUfMcHmAkvu65lZvlnap1I4JdglX0AZTwixu0fvQ/+3UFNJgy2Kxw2e9XpjR9hirILH37s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8oSGDaCamUv9szEE0B/nddxJM6Ks07tCQe0n70FhG6yBKgm+BN
 Icc0SEWEfaFN1jxP+P54HN57yI2Xpr/VK1RzxAirwUy6KpClhI73a5cw
X-Gm-Gg: AZFdTZfWnjvCn875oKlftExEojq/awWK/IeCZZYEMCKmfEXKOcfx02vFtE8yGgstFhw
 fQmiRVFGqL767BTNuTcOv6wdnoze0/gYB2mziBi1vl4uYuBoLTse+R1i745eMLaXp9sXVGfMOsy
 x1pfcPX8QbYMG+ue5REn1x3gnN/ETd37w/jmBGsF+EMKYRtgSa0tr9nDqtuhfIP8aCKc1tO0+Hm
 yNfHNNBjo+6/O/0COHjHo/C5+wjg2P+Q2LXevmxKkj+SE8gLZmpX5HLdCutI0R5PkElDX0nprnp
 8oqO7M50zN4TmW12GY3nkI6atvvkTdRlivEtymdKof9EnmF7u99gXawoAdnW1VBWgmZrHl0iPeY
 YoiSfOgCIQXBVHhAj9olMke+HmbMmU0L1TDlj0deFEuFp8Wa9KIIiUUorFZ0Gzhqne2560WTN55
 3BKddpDh54fdUJ2nmFJ9oYUAxfMMqCEpbXaS2mdsoNmi7M2K+Qnk0OSks1a5qdE8qrNHlaNfZcf
 xWHH/q3a1RYgmFbhp4smRhk8s5qRajum8o9N19r6YNsjwHFIGHmWNF8uy7v22IdR1k8FCf1IVST
 v1jEAEWuDvLZ3nY6xDfZwX45
X-Received: by 2002:a05:690c:306:b0:8b0:e479:6872 with SMTP id
 00721157ae682-8b4fed09583mr3173897b3.17.1794948707375; 
 Tue, 17 Nov 2026 12:51:47 -0800 (PST)
Received: from localhost ([120.244.9.31]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4fe057c1esm6086647b3.20.2026.11.17.12.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:51:46 -0800 (PST)
Date: Tue, 17 Nov 2026 15:51:42 -0500
Message-ID: <f4b8c87eb0676500661ebea67363ac27.docular.xu@gmail.com>
From: Guodong Xu <docular.xu@gmail.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Cody Kang <codykang.hk@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 15/17] riscv: dts: spacemit: k3-pico-itx: enable the
 DisplayPort output
In-Reply-To: <576146d4f2752c3c3f6ec6c42812cb9956406383.camel@icenowy.me>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
 <576146d4f2752c3c3f6ec6c42812cb9956406383.camel@icenowy.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Icenowy,

On Thu, 03 Sep 2026 20:09:42 +0800, Icenowy Zheng wrote:
> The connector available on the Pico-ITX mainboard isn't a DisplayPort
> port -- it's a USB Type-C port instead.

Right, it is a Type-C receptacle, and the commit message should say
so.

> I think you need to model the Type-C port and alt functions of it.

I am not sure that can be done on this board. The redriver/mux in
front of the receptacle and the PD controller that steers it both
sit on the EC's own I2C bus, and their interrupt goes to the EC too.
The SoC has no bus to either chip; all it gets from that side is the
DP1 HPD line.

So a usb-c-connector node would have nothing to link to here.

Guodong
