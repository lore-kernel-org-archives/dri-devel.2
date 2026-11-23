Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436C606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04mu0Xt5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F15F10ED44;
	Mon, 23 Nov 2026 11:26:12 +0000 (UTC)
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D83310ED44
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:26:06 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3b10718b387so1717597a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795433166; x=1796037966; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Io7ujKNNt7SQhbgiNtNsmPHGRtWoUuLSgdS1AFaBjnc=;
 b=04mu0Xt5d2sK0bZY4gdDuIY4UoypSK/oLJLuQiQb0hbr30PO7Mp0f302DNMax7LgLY
 IohuWnK4ewa0rMys5uHITvmfqihqCvEkl7fdH/XKHx2Nw6EYn1/lwOdT2K443j3GdIh6
 pbv8MS9iPAoDXKKFGfOBxO1xy+2e1Da5I/POyIJ8FbJ9trpWJYW8p7h/ZP9zalwDuUDe
 pMWV+3aOqtTofNT4KD+Zdl2cqdtjZwz9pUDYY6zklZCGrCrDAejki9CjEp2WsF91xFdj
 balzk0WJk6Drsl65LiE+zSvqm2ze0en7hyiKWwSmbQGtGdxq9hQq66FFBGIxmH8kw/bH
 UWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433166; x=1796037966;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Io7ujKNNt7SQhbgiNtNsmPHGRtWoUuLSgdS1AFaBjnc=;
 b=NU2X4km0U20YG5AifcqV/IuVbKiZJ9gL+nYdv6Zqn1RAAOZC/WVkxYD5VFpURq0G5o
 6mx0I94A8T+ibrMkeqKeIZm9jw2Oy2it6h1RwqhpS22Pe3fELzh20jlr7O5IPgGayoF7
 TYCaihAASEpjROXyszs1eY5iowvrx/NUAMKwEIBCdgqpagJzZx6t3R2Iu26wIo2l1svA
 l1Mtljkl6b4fiAusSfjHH+tsrjy37vEWiJj4+Y7QYcsIsYYVq+vYcQuhTT/X+NKRJ4FN
 9Yay4YQaIbJSexcdY8D5Tedd/QzSAMlQEoN8lBm8pF7slSdENBCG5MCIclcVrBUmwhXb
 J7uA==
X-Forwarded-Encrypted: i=1;
 AL+hErGvUlcLXC4rspt19ndHj14rcTlK3f0j+UWz8UU+43XR2OFmriffKkQHwr50XrcGBZ0bUQZxEUmW8TI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8evcE63soEgs0qjlHhW3+pT2dYi8MPaT5+r+PceJwzRJgleQhk
 8gi0XrqgYkuEaXUwxp19PJd8MQmBgVs1Zl0Ctg0b07E0lYDMmfvsG9BZ
X-Gm-Gg: AZFdTZcMCOhv91iEJ4IGhf3aXrbgSB2McGyMBZKoqHQO9TEj0S1I6coKiOL8JH7quSt
 iDItw536NAMDXC6CBTJT+iX3U03NUawX+kNTcS+HhbSAWZHT14Er0px3VyWtdURrF7vHEUJy91s
 NxMjqz1UPnZDd0ZAXKMdrEqLJ2G2blMjfEUOktK40Cc8ELz6fTkj1MtdHX9FY+i8gclStRzn9sN
 IEBuZE+lbWnr/x4FxgqeVA7QZgJOBxB2tnYrsp6KN64/toMiNSL66Hr4J0HM0mMXKcb7a7C/peI
 5xWC+a2dXSTRCk0C03xBx590XkDoVUdgbZa18acf+R+g28+DW20NaqYqNGtAKovMdL3QAnxrndo
 YYiuAbE18G6i8XxBZGcHeiwcxUud5Etjsxw54ybGm/j0dm1pCwqzTX029p7hQm9jzOWgSHtBoip
 ZFrvwueoJp9Est0Ji2sUv1IOfkUHFtZhHFaY8lkJDttq3/QzTBSkfyFKDc2eqUltv5Rdkki3pRx
 kx/Pj0MTwIQH5IH2MY9r8AJcX0ItG7u9AH4ii1p9r6IC+uvTM+wv+W1PzetKFCL0WVNgAT0AsMi
 BhCc5ZFF8d/X4qF3Dw1QdfaJdJu+KjlK8Zc=
X-Received: by 2002:a17:90b:4c07:b0:3b4:f92:ade7 with SMTP id
 98e67ed59e1d1-3b41cb20eb8mr10517519a91.52.1795433165943; 
 Mon, 23 Nov 2026 03:26:05 -0800 (PST)
Received: from localhost ([2403:2c80:6::10a9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad8e93asm17449770a91.11.2026.11.23.03.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:26:05 -0800 (PST)
Date: Mon, 23 Nov 2026 19:26:02 +0800
Message-ID: <f5c6f44bfb6040289653cdc079b1cb2a.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Sarah Emery <sarah.emery@canonical.com>, Ze Huang <ze.huang@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 10/17] drm/spacemit: add Saturn DPU KMS pipeline
In-Reply-To: <awPxPHpr4NYxqdmf@houat>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-10-ec419e8e96b8@gmail.com> <awPxPHpr4NYxqdmf@houat>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Hi Maxime,

On Mon, 23 Nov 2026 08:55:40 +0100, Maxime Ripard wrote:
> On Sat, Nov 21, 2026 at 03:40:49PM +0800, Cody Kang via B4 Relay wrote:
> > +static int spacemit_drm_master_bind(struct device *dev)
[...]
> > +	drm_mode_config_reset(drm);
>
> You need to use drm_mode_config_create_initial_state().

Thanks for the review. Will fix in v4.

Cody
