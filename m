Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B087606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FACDzTZk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFF210E1C5;
	Tue, 24 Nov 2026 02:12:28 +0000 (UTC)
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF96310E1C5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:12:21 +0000 (UTC)
Received: by mail-pj2-f4.google.com with SMTP id
 98e67ed59e1d1-3b426133d98so1069229a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795486341; x=1796091141; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DYJhcyx23MYrdnoVW3nJljPvokUxcXGxcoFSW0aOJ4Y=;
 b=FACDzTZkXSdHJYrp1WGINBQkwDXnQvYNPWmneTYa7PpCNM4e/9s5zXaRQuL2rhl6Gi
 m5AgH+3oYrtQ4DT4RnIJMi0fytWD3qh2NiwDxm/Po+i4h2FCY+W9d3DOtw+qWHFkaoR5
 x2WmFhKE0LEUmhMOFzgMEYEOcrqKN5awYRKpdl/1mY3DveC6IwNawUTY3ggmRu2WWBzn
 aVM1Ev1jqRmwne906zVgh10g/CJrVnaHHvhL4vn9ysEkywL66Z87dFx9xBqddYhlGMgN
 +PwT1jZjCLMy+fzIXz5lDW57zknyXXuKX7Iwwn6gg/a6QouPfdaLfp/pOG1UOcpPPvHk
 BM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795486341; x=1796091141;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DYJhcyx23MYrdnoVW3nJljPvokUxcXGxcoFSW0aOJ4Y=;
 b=2DI+UfpB0OTRljY5VObzGeV+GWom0jYJr1keztxJKEBIVsBZeK8ON7T1mtVEpW2ZH8
 9u75S+VwKshvAgnq+YmclV04b176j28cvhPMZAkkrBat1LTPWITgJwXr8epDc/AtVn/0
 DtMDkNm2QfFZrsFrQXz7x6DGlBINyTH8wKG76NZTe1irKfzXmxJPb7x/WO58DU7LPaPJ
 tppeXWcDSpDrdUocrS+NbXQ/qyV1iiQiolWa+qYnFpTzIfKeTJkEfqnZCwV2LGKlgRej
 DijiJtKp6WIjHH1MnAUCItV+DYjrGtAFXLvmCCBhNhzf/UQb8IMRqHS+QhhuUtWd+yMN
 Da/w==
X-Forwarded-Encrypted: i=1;
 AL+hErHIHmnOvKqheGQkTMo2GCiF9FPvtmZP/QYi/avvA7b5cx0t1pFBbxv4jZrTCAG1bnxWVgLzqC4NIKg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/hi/57Ts8gmwd5INLnw0bgIwrTd1tpP3LsxzMc5clQMavCmA9+
 ot9cEfk8AYWVTHdK28HTCj+uwiBy9C/W58Z0nSkOAJ5U7BPJQ0gl8HcU
X-Gm-Gg: AZFdTZdmqn5iJmysieu4b4noTDa+ZjahoiHKe8vUaCHnJq15UyzUSU85slzUAwJjhsb
 Jgwt6ikeTOzvJhAzMWt+dyeq+5EILlgHfNhup8+AwgvoQ0kyOF94OysZOZqLnHSWvXIjEtSLYk3
 w765YvgqnspzTPMtZ68VjSyq+4FGkMOmImWvCut9wWV40S/fxwV5WsrAY4sOM9WR+qZZ5B5Rouf
 KupCDWNWTEGYZ+DHwhj5Jx2JUBr+P1cr3+KiB31haajSXjLU6X2deLfF4XL8Fifvx9DdN2Lxth2
 CkbHvOT6Fvsqet5Yj2zSHt/1vtcIzb16rR3L81x2oo833wZV3FjKDb57jSRt/9cIi32MVPlF/Kh
 uTCZ6/r/PjzHLp71XSgZWMOoEMZiWGkiCtDq3lIxEZXl7a3aE3IG/fUXEmd1kcxqqhNGmUyw+b4
 tXQY80Z0lKj6G+30TkUoW+yrdhD08Jewy3tUkqyn80U76k1gpK4bxuiooUxndn0eTH+d3Zw+V6Z
 IRzk7KRrJbcW6LOtDYlCAqJtjHwOaAuPZZzn7HcRyFCSW8wdgaeiWjL6tk6MNP9HkoS5RIi4mLl
 Xkpf0JBFEB0gNpkKcLw71bjc4gu81akOsQdJuPwoa/fqTTkyTucVuFC00A==
X-Received: by 2002:a17:90b:4ec5:b0:3ac:b2e6:3181 with SMTP id
 98e67ed59e1d1-3b41c9476d3mr12780728a91.37.1795486341377; 
 Mon, 23 Nov 2026 18:12:21 -0800 (PST)
Received: from localhost ([2403:2c80:6::10a9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b48b41928esm9869004a91.9.2026.11.23.18.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:12:19 -0800 (PST)
Date: Tue, 24 Nov 2026 10:12:15 +0800
Message-ID: <3b4d214b53b64cd7941260875bbc88d7.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Ze Huang <ze.huang@oss.qualcomm.com>
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
 Sarah Emery <sarah.emery@canonical.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 00/17] drm/spacemit: add SpacemiT K3 display support
In-Reply-To: <DN2OGZ2JLHQ1.3PK0UZ3K1VYKF@oss.qualcomm.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <DN2OGZ2JLHQ1.3PK0UZ3K1VYKF@oss.qualcomm.com>
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

Hi Ze,

On Mon, 23 Nov 2026 22:59:10 +0800, Ze Huang wrote:
> Thanks for v3. I tested the series based on v7.4-rc1 on the K3 Pico-ITX
> with an external DisplayPort monitor.
>
> Modesetting and page flipping with modetest work at 1920x1080@144Hz,
> and kmscube renders correctly using Mesa softpipe.
>
> Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>

Thanks for testing v3.

Cody
