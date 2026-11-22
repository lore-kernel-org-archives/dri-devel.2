Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37353606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I40ZNxg7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DF710E04A;
	Sun, 22 Nov 2026 16:18:33 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9EF10E04A
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:18:26 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so26414195e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795364304; x=1795969104;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ZiEeOYhVKS03CHr35HdwHPjYPpUXJNlNyaUVNFPqXQ=;
 b=I40ZNxg7e1UIo7LWRXAAh0nVhPOb8e/UNtOdf0BlPZuveRayPP7BpVNiNp5H/k0tUu
 eqZkA42Ne7PNNA3U9mU44OEs29NcK25+1hf78cNQWQDPHD6wYZB1015AowvJD0oUVvt6
 qKRzptybB5wkKq4Lf4KgGt+eIU0UVEHdubRBkSqnI7k7TriCHlwNLJ3qFrwMa8Qz1/Eo
 lBVO6PV62Bo+Lu4wYrWYa40IBc2nhUoP7plwYkYF9lBdjqAfzyDSHjZhXhsXm4r/9H+X
 P/wni/khj/mj35VDqvFWERixcApUCDCjSMegPQsLOr4BE1nqTBN0ZwyMG/YJqC/zeHit
 RsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795364304; x=1795969104;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ZiEeOYhVKS03CHr35HdwHPjYPpUXJNlNyaUVNFPqXQ=;
 b=HvSiukdiSNDl4u2HnHm/MNxqk8jVPyVZaWHKcV2C6yYVXQiOCUl5vWvI75RgdXbGvz
 5JRBJWO8lT4ZLMO95mUnC4vjebsY/5sYWm5Mbm+uW6kIhk4Wh9S4arDF6//E6mc9OmP6
 gGsnfargBNfO8jYq8CSn4QJczYTQGUz/0N8MsRbPah9Afzo7dopY2I/GWPouGhmg2dku
 OsO2EiBb3oHxjYcuAglmFOFSq74fay1jWKxc4z1GJYgcAjyAmxOaLlB+cwLyOJDuIWkY
 vZdVpHDPshNKQS4QsYwupSlihADMJEpnuxjOagEAXI37J898byjuG/IUX+IG8WDC0ZIk
 yNlA==
X-Forwarded-Encrypted: i=1;
 AL+hErE9buP2FOFH7eIhEep1zlJ34oBmAwLcEK2ZQHb6c6IYLYmK2hTC5CfnklMK0Bp8VBcWE5V+upZ0eVY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92QIs4Sv7XH6fcmC+ZEiu+aDSCKW7GvDN71WV5xO14PeIdbQBz
 DA3vb/MgG8EtKOS+gjWUcz1y6j7mp1tatsWZOXRrdV27Q3GaYh6JUqSiFUXZduQCseQ=
X-Gm-Gg: AZFdTZfQOq3rvSLDApuqOV0vRZHLlzqHKdcU3BolobiTc/o5417Jv0qqy+Px1aTFu+s
 SXbR2expzcCUGCAp5X4tKcsVdHgn3OI5q0xWmo/J/l0NOjLqUOg/7yBSokx8fJcq0kM37T0W85A
 gqd3u/GO+DuysAOZqxtTzv72pyPUVozDLXFH4u/YIYLDkznLVCMI3FOitVGyeRDKzD0uATTjG4L
 42XXdf4wXJ1YsEOAG0qHUO9nKtCc4mNvfq6Mr157oaZmHZcUVRLWjDzFC4lLKH8KawjTS2gf4ui
 JVxSwcFWZycbYZmWyT45Z3p1W1b4d83jquHKNG9Zyf9eapoKJUcYwyT4U7ui09D9FHmy33N+26A
 fwd12l4nTIXdCRdCR1bbwdTR+gW32fX5W8B1cqxwejyU9Www3dAErBGtdtcH7diOa8eIyASOypP
 cOyXU9ttkPEmiBSj+D9VDoVdHvesBqrMd8bRotsZcq+EaXOL57f+4ZSsDXZQNRpzu1CIIhE5qUH
 a2lOGgwlDrLtqXk2kojjP6TetjHVjZjfWKSRe2WmS267LW74zqFpwS/JpkvAzuNOH3/3j+R7T/q
 keQfRDjegSVHnIT5wb+p0JnlBdzzcB+kjPCb0V26yxj96XU8
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id
 5b1f17b1804b1-4bb94573c9amr46862925e9.2.1795364304705; 
 Sun, 22 Nov 2026 08:18:24 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm226037545e9.4.2026.11.22.08.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:18:24 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Cody Kang <codykang.hk@gmail.com>
Cc: Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
Subject: Re: (subset) [PATCH v3 00/17] drm/spacemit: add SpacemiT K3
 display support
Message-Id: <179536429642.2728475.2044119204203952258.b4-ty@b4>
Date: Sun, 22 Nov 2026 17:18:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=207; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=v3hfU9UHf+Kw6j8mPInDkRCmcdQcn/tFYuhWer9PVLA=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNnMouffLtac7bcg5TPvFslVKz/IiM43L2d2W3La8FzzF
 i6bCx9Xd5SyMIhxMciKKbLUcFeLv5PU+jJrus5tmDmsTCBDGLg4BWAim44zMmxxe2hesHqmrEzE
 C5a4iu+CTLL9sfqpvwrzRPpPFr2X/8XwPyhe6sxK569/On8WiM9u/vRjfl5c4ZyfsjXJvPYlub7
 z2QA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to clk/linux.git (clk-spacemit), thanks!

[06/17] clk: spacemit: k3: parent eDP/DP pixel clock to the PHY PLL
        https://git.kernel.org/clk/linux/c/dd010f2b662d

Best regards,
--
Jerome

