Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MFPpcc5O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08AE112BAA;
	Fri, 20 Nov 2026 16:17:38 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3145310ED03
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:38:58 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8b4e2fcc300so2158567b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795124337; x=1795729137; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kZCnjg9SNOEIBkstvPO0BHnnQE09Drv6532P18ADAkU=;
 b=MFPpcc5OJOHRWk/Jc+nYAZPcRaQTLC/aB4Tp5zpBfvJguENBLiNXlgZ3aK6PKcASZD
 Blw7FPGa9K4jPh+IKlMw+XsFT4NRHPZDFczDBAZQI6JSimhqOT9nKOjtpOM/zBETaYOc
 dEG3N50hh3MfTbLH6AC7xbbGoLUOVfKwS37ZhfPZEmSkwrcOowNZ0DxYowe7u5x80nr8
 aDOBbUJb6RM3eAtDVj5or61G7sU3gCWrJDd+YjPOjmHPBdKayda3zTiM3No0b2uIIkiK
 n6f/5+MhY5CO0apXqBYUDj0cDrGvjpa76+nneqsnDVE2JFWRRtEtBcybLoU2r3LhsdGR
 eUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124337; x=1795729137;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kZCnjg9SNOEIBkstvPO0BHnnQE09Drv6532P18ADAkU=;
 b=ChAntEFkFK2hoImwAEzWnGY75Vmfy3M1LftvSs+fJVx1lliUH+WJhL+yZkIY5cd66D
 5+zXvxhoRyzTmP5ofMMroImyX4VC1NdQT+4X+Muhva4jZs136S6ar3Mw3/dh90mygn0L
 vrUmy9KsqdneWUu3YsEFg3KcHuNKD3CVH1s0haKrxmd1QcT6jzu4rIYPlSdqM6gyyMdQ
 IrACpHH1QkSyjae1RxzVnUZoS7iestIBvKFDYcXKmqjwDaPKAohHnea10SJ6Wa3EKBjg
 vYAvnqAQ7EEy0fnVweXWcy40EzO5EUn2ngjppbRv3aHt76/aH8qc38gNTgbphnXat+SB
 fE3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEgoBqg7L4lzXtGKAbOQVJxp6e/tNjJJLvnOa6arEvjK0OtoAC5Z4ZOJX7Soxgd3FEVuyecv5VO0Ck=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+XoiMB4x1jB1YhAuOFQqVMX9KyvGAaTqLWDtfC6Qy6gUQTwhqu
 O2/K8oMUqS4Rzm0RSgpgCMpqW8xGDInUrCybgkV8o0SuwnAVzdwiohw7
X-Gm-Gg: AZFdTZd5BSiEWNdVlQscc82pMNt3RmlTlKxSSpHiCqfOsP69Ttsp9kgnjfRGbbX6Rlj
 c2FlNvb6tmJjB+eXMeOZqO8rrkb3q1nmwAhANHEARzOcZhq6EDcfosWgsbO+FhX1vUmI7AXGF27
 3iqa83ZrRl9NPbQ9cihiIwn8j9jUaTGbyZXM9ibjV5YcnS61EfFtMzGwHkCC5D1853rfnAcpeeW
 U5A6ye/uY2IPnW20HfEYdllBg0d/H5+DgENCu7WtqSjHcFA3W4qRSus/GN8HO67UfmOwxmWKOZ3
 2w4DJ/nFlddI1XeAQ40O7EAMZxTmpymOioQIXPDTzVamHLCCEWinOMy8TekxdIQvHdlqBx1lrHg
 Xe2UEVorVvKQhpSCkMrO8yc1D5uQM628ksFZUM1qEEvnaOibfNmHJQb6ZHRSIw259/WV9ZOgycH
 /7tgAnG5aAKYTw5FGgcUUus9RvveqN801m92X7hRbGWUx5lzb/14NhyQOgefklgVnXg/fB2CTJv
 0FlBg7N1hmo+JusfdRaewuIkQ9C0Mv+HGD3qfcyqeBOmpbz3owjQo8NebAmFGlfjS7EfwdxEZZQ
 nhjmcEHbP33awnYLNk+iIQ7d
X-Received: by 2002:a05:690c:c9e:b0:8b0:95a7:37e2 with SMTP id
 00721157ae682-8b5204ebe00mr4585427b3.80.1795124336861; 
 Thu, 19 Nov 2026 13:38:56 -0800 (PST)
Received: from localhost ([120.244.9.31]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df33b7502sm663093d50.20.2026.11.19.13.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:38:56 -0800 (PST)
Date: Thu, 19 Nov 2026 16:38:52 -0500
Message-ID: <7072ab495239e6bd28e2e9ed75244e24.docular.xu@gmail.com>
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
Subject: Re: [PATCH v2 07/17] drm/spacemit: add Saturn DPU register model
In-Reply-To: <bffbf989f2c99aa8c463719347930aca44962615.camel@icenowy.me>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-7-327d7910bf71@gmail.com>
 <edd7ae1b38ebc687d0b2bfb2509c40fb8a45e625.camel@icenowy.me>
 <19ceb44df3141049a955c2c30fe64766.docular.xu@gmail.com>
 <bffbf989f2c99aa8c463719347930aca44962615.camel@icenowy.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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

On Wed, 18 Nov 2026 18:18:11 +0800, Icenowy Zheng wrote:
> 在 2026-11-17二的 16:48 -0500，Guodong Xu写道：
> > For example, the blocks sit at different addresses, and most fields
> > are at a different word or bit. In dpu_int.h, CFG_RDY_CLR is bit 4 on
> > the K1 and bit 5 on the K3, and the underrun bit is 9 and 8.
>
> Yes, this IP weirdly doesn't consider register map compatiblity at all.

Exactly.

> > IMHO a K1 port should add its own compatible, its own field header
>
> Well I don't think field headers would work for a mainlined driver;
> maybe things like regmap_field could be used to mitigate the
> difference.

Fair point, but maybe that can be done when the K1 is added. For now,
in this series, let's make sure the field header and its users are
self-contained, so that K1 support is easier to add later.

Guodong
