Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14FC606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KVE/4Uld
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA8A10FE8D;
	Thu, 19 Nov 2026 07:53:05 +0000 (UTC)
Received: from mail-pi2-f4.google.com (mail-pi2-f4.google.com [74.125.227.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CE410EC27
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:49:12 +0000 (UTC)
Received: by mail-pi2-f4.google.com with SMTP id
 41be03b00d2f7-cdd8c1fdf4aso314144a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795016952; x=1795621752; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cer8YfO6jgJ8rX/jlVTUPHJd3RGw4HKBsstgFxqYGYA=;
 b=KVE/4UldePEs0pWAEoBGc9IVPnRw8RRnyVROR7jtuRooBOnfB7r8K3jYxd6kqpSNOA
 CNCpl7Aasu3cIHHuZoHS5xJa9LuYqCD+Ac0Hz13KjwtUrY7+IXocR2oY8fjzlvzFhCXr
 sM993UKo9Znv6WHVOBIGo5/htkj3341MkM7MEOKI05AFmrsT4pW0jcDEuV5qcyEkQ1VZ
 8lwp2x2D+ReaprpbtlnFb1f+UunlkUHERnSkO8AgWHD5r52UMZ83PtQSedsquZtcX9Qn
 kQT1ra+4HzwrtJVnho+SPSAf9o0V+RkhtXxyFnhKOfrAdhHcVylXeaKLPhOs3St6LB34
 Oj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795016952; x=1795621752;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cer8YfO6jgJ8rX/jlVTUPHJd3RGw4HKBsstgFxqYGYA=;
 b=EbibaZfG8Su+cBd4ZDKfiJGBP1G5NOX/a3fLkN5h83j3u1Du7fnMBo5KNgag2rfn3S
 BhnsYE1BrW3TBe2NNeZvXxnSf2Dy07XI/wmzW+XSNGZv72Z53Pzy8FxcKesSnnv+FCvq
 hQRp2t4g073165cCpMInkdo71ZVJAQDF670OngER3oPieQCuvsxBolGnlEEcAnVrGDF/
 mKFOsO62dUmL9V4LzOIjvdu+To4gCUJi1sSk6nk3SJT1QbQxJqW2b+huNuDv+qJ6i4tU
 hvBDGEOEk49R3xzcwjm7WDsGNhTj4GhcdIkLM6Dh2uSdg9gaN8lkUW5PPTBpOxatPfkN
 b5/g==
X-Forwarded-Encrypted: i=1;
 AL+hErGaNszakj/NTWAPDLCvRsfJT18kvPDBAOzTHYzKZR2GmE+Sw7Z3m7TLxvyeP4PlVEYkTs/92s/kyuQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+GQBLVHJzw6YXfpgAx+yiI6pxxc5ynrcujdiywQdiuF4nxYokl
 iG8croq5ulmeej6XqEQb5p/goJGcBNfIuGA3Kp6osGvmHJzKTfXxZxIv
X-Gm-Gg: AYBFou1lkHW74l3X+auG9eTzAezd+cEOlJSrmyelAfemXpFgnHNa32/9UDyOpv3oJru
 6NyzfodxeJGJLWKBd4/kbN/MOwrPe2gnk6yHWNS03RyosHZbrMX+C60LPVsB82n9kkrW+97GzFv
 8I1o2V61+51x+7uFqShuIyoppGCdX5MV9sJk0uKkPscf8mcJP3cjiVJDsLhi1agzCSI7Enx8f0X
 lnE4rIiHIiUQmfHMs4wF7TXgLoYqPplljuB4ndstae5w7FmFjo3Vd3JwSPZl9XiVSmM4xQiEiIz
 XlhBP1M2MT2XbgZjP0s/jGnKYbFHM18rUfCd1GK7NOBitBefNhHzRVZihnkgvm0LS43PBKf3bsU
 C2I5nSjUcMQYxWzEPP47fa8ONgalIt9cXJRbeQ6dfTHT+ExsEeFAUMbn8EO6nHvOjXosF0791Bx
 9RTdQjeZ+1zKnLIuTKiz0ejcM98o0F54Lb1gcIsTAKF+7MYFFLiWkoNhfEF8GgRB7BEOboFAOA1
 tzFJsH5kMltstfStwAvbtrQQ91F38aE7Ihis7L8rFuf57iiQ3Eu05T7CqnGx9swsj7E5vkc6C4n
 P48=
X-Received: by 2002:a05:6a21:6e0c:b0:3e1:bb35:476c with SMTP id
 adf61e73a8af0-3fe8bdd7c38mr2965829637.72.1795016951931; 
 Wed, 18 Nov 2026 07:49:11 -0800 (PST)
Received: from localhost ([2403:2c80:6::107b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c6660c2e4csm1055183b3a.22.2026.11.18.07.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:49:11 -0800 (PST)
Date: Wed, 18 Nov 2026 23:49:05 +0800
Message-ID: <e4eb5f5b7ed8b3b6bf47d709e4344e0a.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Icenowy Zheng <uwu@icenowy.me>, Guodong Xu <docular.xu@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
In-Reply-To: <9d97d5dbcc619a9c52904ff8c6704a91fe8351e7.camel@icenowy.me>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-15-327d7910bf71@gmail.com>
 <576146d4f2752c3c3f6ec6c42812cb9956406383.camel@icenowy.me>
 <f4b8c87eb0676500661ebea67363ac27.docular.xu@gmail.com>
 <9d97d5dbcc619a9c52904ff8c6704a91fe8351e7.camel@icenowy.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:53:02 +0000
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

Hi Icenowy, Guodong,

On Wed, 18 Nov 2026 14:25:38 +0800, Icenowy Zheng wrote:
> 在 2026-11-17二的 15:51 -0500，Guodong Xu写道：
> > On Thu, 03 Sep 2026 20:09:42 +0800, Icenowy Zheng wrote:
> > > The connector available on the Pico-ITX mainboard isn't a
> > > DisplayPort
> > > port -- it's a USB Type-C port instead.
> >
> > Right, it is a Type-C receptacle, and the commit message should say
> > so.

Agreed; v3 will say Type-C receptacle in the commit message.

> > > I think you need to model the Type-C port and alt functions of it.
> >
> > I am not sure that can be done on this board. The redriver/mux in
> > front of the receptacle and the PD controller that steers it both
> > sit on the EC's own I2C bus, and their interrupt goes to the EC too.
> > The SoC has no bus to either chip; all it gets from that side is the
> > DP1 HPD line.
>
> The ChromeOS EC firmware exposes some control for a Type-C port, you
> can search for `google,cros-ec-typec` and `google,extcon-usbc-cros-ec`
> compatible string in arch/arm64/boot/dts for more details.
>
> Although the K3 Pico ITX hardware connects the EC to the SoC with some
> not-so-embedded interface (eSPI), which needs to be handled first.

Thanks for the pointers, and thanks both for the review. With that, I
think in v3 I will leave the dp1_out endpoint unconnected, as it is in
v2. Let me know if you disagree.

Cody
