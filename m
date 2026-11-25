Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED8606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yq1LtcLp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B70810E8FE;
	Wed, 25 Nov 2026 14:06:55 +0000 (UTC)
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E70C10E8FE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:06:49 +0000 (UTC)
Received: by mail-dl2-f7.google.com with SMTP id
 a92af1059eb24-139b659a45eso659354c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795615608; x=1796220408; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MP09FK8BKciK7H/NzSBFI5ee4XjfPiGr8z/17qMy3kI=;
 b=Yq1LtcLpj4l1glKyuApvxltV144FgCtvL8DDQuaD2IG4vvVsXwHGB0FL+Dc9CnJLwK
 TBLrzz2gykWbTm7duqAM4DbAD29pJK3LfYBF9WdcfIi1MKU3Td7ePDZruvrxH0w9uf7E
 iFb3xXrROotjwiTR/zSmvIAHuCKHZGDI0r2qyiLnxgwni+FvSj/uQEQZg6s0XFTONf6x
 4l0Re/JYYS8Ksl1LBrts3rYWjcqSiGX6+Q4Biw8h/b6nKge+arij6/sL5ArYiCn3otoO
 +ZmT4BKBhLPKMtMEysFLswu2YD/1H2Bov+Sw9uO10mnKL9CkosJ0tV7fzKN6orqePP4a
 E8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795615608; x=1796220408;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP09FK8BKciK7H/NzSBFI5ee4XjfPiGr8z/17qMy3kI=;
 b=VPUohZcFunpp1Dhx4IX152NQHCZ66aIi6B0xsI+6fkIt5g0afyuqvOixDj1S1yztfR
 a1bXGuBK3XrmdUElazXPmxSAO1a0Qq3XNwd4probph2T+ndF7qIzMlQGNxt96TO+f890
 v6Z6PlBcrHkKgWegW4pYdyEI2VrauxPNguP/CxkUM/EOfYJIM9eXVHhRedPpWw8BAugH
 +Ki4N13N0Invwgaq2+k+sMyimjKdlD0fFcULtzkK2fiGy297jWveo0Avoc+vL4u//69H
 RormzPcRUzhbrcSHNkh1uiF4dOgaklDEDTrGVI9W8aETbKbzoBThqzXPZU+kzOiQr1Vb
 kI4w==
X-Forwarded-Encrypted: i=1;
 AL+hErHsR0U4MCQDGbLlTrd7gqNdrFXaGyFP2YJkhgtstuKXVRzawW9Xucqqso3vL8Ksih8uPs42FxGeg8A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TodeFWp0U8oC5pymsOCmMUogcYGlhnhkWyGByGkfBYXhV0rop
 ERuhVy7NUp9BOqEDYPunKKAIMHLZvCjTMmAHbK6GAC7qHoQfZFWepJ5M
X-Gm-Gg: AZFdTZd+Zo2/myB7nczKH3BDSoXRpOmaQhCPRgAS2aDF1r3rw9/iv2o5TyP+O6VgPRQ
 RU1iLEZjRFEveHxrpt8MkJBlTrh/CPiV/xFjrg1j712Km7xUruaDE7BjGoRZ7VX0DKD57CBBetB
 Rsf4fwDypsos6xzuyyFPhCn1xnXzAPuby6mGuZAHHA1M28ScP8uVvxWQCLCVdu+VSay9s4VscwO
 cY3OlaJ/avrpRJRllMXu37EpNaOya4FsjkVUD/qfNzy1Wgah9oNIx1ChgUbZ3Try4NoRuLTnzFb
 emeo3MmaPZoMP6XMdl5RTahVeCHlfyjWfuszCpmJsuLeLDb0bk0+TECF9H6/uYJzoKcVLlkV7ox
 +v0pTx4Z1MRJnloAnLuyXMVzOM4yO/dgqXiu0MgcdMG0uYkuYJnS9108VZj+nDLTPmHsx4vHggb
 lCrLimlIPbETXt7GwkmH7ca2K38mlpokFEXhHliYb2cT48dd5C0d7Ht6DZD021z4B6dKVIh6Sil
 QHjXVxaUDlbUP0TYiYyeVIeq6xNreGGKGp0vOYjBzkfzZ2pia++QA5aXqigOXl7UaUXIRjV5qLj
 /O6Yxx8HVD5E7mOe73lU22fR3LGYIFBwVG62LlZwHA==
X-Received: by 2002:a05:701a:844e:10b0:1b0:20:6444 with SMTP id
 a92af1059eb24-1b56e185990mr10444498c88.39.1795615608143; 
 Wed, 25 Nov 2026 06:06:48 -0800 (PST)
Received: from localhost ([2604:a840:3:1e0::3003])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm61981028eec.26.2026.11.25.06.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:06:47 -0800 (PST)
Date: Wed, 25 Nov 2026 22:06:43 +0800
Message-ID: <eccf3f1e6dc94fbe847d112e8804c053.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: James Morris <jmorris@namei.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
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
Subject: Re: [PATCH v3 00/17] drm/spacemit: add SpacemiT K3 display support
In-Reply-To: <87eaeb2-b6e9-9198-b9cf-7e9f96bdcbc@namei.org>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <87eaeb2-b6e9-9198-b9cf-7e9f96bdcbc@namei.org>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

On Tue, 24 Nov 2026 19:53:11 -0800, James Morris wrote:
> On Sat, 21 Nov 2026, Cody Kang via B4 Relay wrote:
>
> > This series adds display support for the SpacemiT K3 [2], a RISC-V SoC:
> > a new DRM driver, a new PHY driver and three new bindings.
>
>
> Tested-by: James Morris <jmorris@namei.org> # CoM260-IFX, DisplayPort
>
> Assisted by an LLM.
>
> v3 on v7.4-rc1 works on a SpacemiT K3 CoM260 IFX with an Acer EDB323QU
> (2560x1440, 144 Hz) on the DisplayPort connector. The DRM, DP and PHY
> drivers were built in, and Linux ran from an initramfs with
> clk_ignore_unused.

Thanks for testing v3. I will add your Tested-by in v4, on the PHY,
DRM driver, SoC device tree and CoM260-IFX patches.

> The board has the vendor U-Boot 2022.10 built on May 21 2026, not the
> uboot-for-k3-display-verify branch. That link in the cover letter
> returns 404 for me.

I will drop that link in v4.

[...]
> Two observations:
>
> 1. The HPD interrupt never fired. /proc/interrupts stayed at 0 for
>    cac88000.dp in both boots, also across the unplug and replug, when
>    the stream was running. The connector poll caught both.

Same on my CoM260-IFX: the count stays at 0, also across an unplug
and replug with the output on.

The external DP connector is polled on purpose. The interrupt needs
the pixel clock, so it cannot report a plug into an idle port, and the
bridge leaves out DRM_BRIDGE_OP_HPD there.

> 2. With the monitor asleep, nothing was displayed. It kept HPD high and
>    returned a generic 1920x1080 EDID. Link training passed at
>    2.7 Gbps x2, but the monitor stayed dark until I woke it by hand
>    and a later modeset retrained the link. The kernel got no event
>    when the monitor woke. I found no DP_SET_POWER write in the driver;
>    could the sink be left in D3?

Right, v3 never writes DP_SET_POWER. v4 will set the sink to D0
before link training.

Cody
