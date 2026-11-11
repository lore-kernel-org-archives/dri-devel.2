Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA3606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dP/UqmoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5801A10F965;
	Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E409610E089
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:26:34 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36fe5944e9aso2780518eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794371194; x=1794975994; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JkuS+mUk2RH2MSK3tXztbBdwGQB9HnQXtlhnX94SlQA=;
 b=dP/UqmoHsBwxY7UVnmiS3QDlsjfhA7Lk6jIuXAVH9kB6o6zDu0qyIvv46f7zzs/fpF
 Pcv7FgF1CDW4P/v0J4pGpN6B0QpflA1UPN0gEmzDVMfarVbXJnY8mfiEK19/sv/BngvC
 kRuunJDcjwgTth/kQ7ng+XW+hv+2hjlhfWanh7LWlvEIsEExUwVnwtqMDeYyXwW6OxaX
 XOG1Qu/kX7pAroE1aoB/vPROJK3Z/7neKDMYySOVle+Is5PVjmw67Gm6L2zB5JOfQLTQ
 Q/H08Yg+qGvUiVr+d7XflX6uH6Qt5tbJTPqkyNH8HVa6cSojYwGRvfmxmQ4gAcJgkXDM
 EmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794371194; x=1794975994;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JkuS+mUk2RH2MSK3tXztbBdwGQB9HnQXtlhnX94SlQA=;
 b=wXQgoXhO4UmcoI/71hXP2XUv8w89wFrr82KAJAJGe6n7PO9K8hZiCjMkflNNqzCB1M
 aWpjrFoO2GL+HSFao9i8RL8Pu1lSSCoRk1QYZicIAqK1PUwRyWx79tp1kojLFuuKfZT6
 S0fR75ujuNGmOcQRjXdpDyYI9NrPzk50DjW4TKp0qAdZZNo0o4C02Unn967D/h0ini5s
 LhosE+Nvzj24EFSkrQKVkmW0yiB7tF/DuzsWbpsx1tEgtN/VU8aaTPcjPCIAuFwP7f2+
 PrTdbIIo+VhXEG7nQwge650VeKqoY30jIY58dutBggpH4xE07XrYVJLMR22eToxfzn9L
 4+Zg==
X-Forwarded-Encrypted: i=1;
 AL+hErHJdCmsGpLwImD6UDaVU3NjfBBUPBgw9iAsG/82zdhgja6UcVFfvZ7h9eeovXa9hKDv75qBLAcmRto=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ng3mnCY6LNCy7yfoCq+IOg1M2TLoShfmD1Sprqjkpc0r9wL1r
 u+8mraPC7QGiMVFabithcIcyFd6C30ikOog44r+5YdkhFUIvvfg6g0zE
X-Gm-Gg: AYBFou2jSsnSFNSzk1epfjtsaizgLzbNdkpGH9kWNMsJGL+kfO/IVI+2WSzIVc/tWY2
 IlLnV1z6gWYaULyp3uprpvtPWraWXyuIg01ShZzpTagmR3hP2gb0MP76MbwXVwEb2Kq0/8JS0td
 XASutNk32qDuJEmwL3JB85O9P0rAbN7IqZAnbvsA6oL/P7bCbU12dQBjQoLClDcfQPlZzyPBP59
 mCGVgiU4TkLntAgpeENM2KrdWL0KZFDw8bx5d3spUPjAWu+lMDbrAzxLYu3tJP09F7Ksb6hn5ax
 CySoKINHWdP1z4Xbm1wWVe8HdbR13sqKeUKEyeKMaaF9ph7hp8xQR8JQZrVNxUhNeUOqR7+YrWY
 yDzajUihtddNUDr5Ex5bFPyCAz5UWhE2LT+hMLVMuaIVmIx0Nn3hV2LmGFRstv55Xt+Sc+zXUiV
 AcqiZ2roIj3fZYTQhZlnpjeGXL56UyuhTvEPcv897sq/cwX1Fl1GmCzGEcUwwLWbTlKWgeE5zj1
 24PqT7aUKcE2cF4FQ9JyNWj4fEUKxh81fBUzeUmcgvP/OUtmcwgJThdeZNYjamDVGhmOeixfxOU
 K/8=
X-Received: by 2002:a05:7300:c382:b0:376:bcc4:774b with SMTP id
 5a478bee46e88-376bcc479abmr1028837eec.23.1794371193980; 
 Tue, 10 Nov 2026 20:26:33 -0800 (PST)
Received: from localhost ([2403:2c80:6::10d9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfc6sm13018714eec.17.2026.11.10.20.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 20:26:33 -0800 (PST)
Date: Wed, 11 Nov 2026 12:26:28 +0800
Message-ID: <0d340a99e07dfba7ea1fba6d9529a1a6.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Jerome Brunet <jbrunet@baylibre.com>
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
 Guodong Xu <docular.xu@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 06/17] clk: spacemit: k3: parent eDP/DP pixel clock to
 the PHY PLL
In-Reply-To: <1jwls975nh.fsf@starbuckisacylon.baylibre.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-6-327d7910bf71@gmail.com>
 <1jwls975nh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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

Hi Jerome,

On Fri, 25 Sep 2026 16:43:46 +0200, Jerome Brunet wrote:
> On dim. 09 août 2026 at 21:14, Cody Kang <codykang.hk@gmail.com> wrote:
[...]
> >  static const struct clk_parent_data edp0_pclk_parents[] = {
> >  	CCU_PARENT_HW(lcd_pxclk),
> > -	CCU_PARENT_NAME(external_clk),
> > +	CCU_PARENT_NAME(edp0_pll_pxclk),
>
> hidden behind this macro is a .fw_name. Basically these are your DT
> input names. You can't change them at will like that because your
> bindings are supposed to be stable.

Thanks for the review.

> You should not use placeholder name, ever. No need to make the
> name too specific either, from the beginning it should have been
> something like "pixel_pll" or whatever your doc refer it with.

Agreed. The new names follow the documentation: the K3 user manual
describes these two mux inputs as "pixclk from eDP0 PLL" and "pixclk
from eDP1 PLL" (PMU_LCD_EDP_CTRL, fields EDP0_PIXCLK_SEL and
EDP1_PIXCLK_SEL).

> "external_clk" is not declared in your bindings AFAICT, so at least it
> should be fine to remove it.

Right. It is in no binding and no device tree in the tree supplies it,
so nothing that follows the bindings changes.

> There need to be a dt-binding patch documenting the new name you need
> and then you can start using it in the driver.

Patch 04 of this series is that patch ("dt-bindings: soc: spacemit:
allow eDP/DP PHY PLL pixel clocks on K3 APMU"). It comes before this one.

I will change the commit message in v3 to better align with the logic you
described.

> In the future, please try to document all the inputs of your controller
> in the bindings. Even if you do not use them yet, they exist.

My read is that comment is more to the original commit where 'external_clk'
being commited, which is not from me. But yes, I agree with you.

Cody
