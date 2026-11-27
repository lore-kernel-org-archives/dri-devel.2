Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7D606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iargXrBa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73659112D65;
	Fri, 27 Nov 2026 20:03:12 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE88112D65
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:03:06 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b86fcbd647so12943904a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795809785; x=1796414585;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
 b=iargXrBaSwph/CTaXfpaioaYSipv+PC/wjAWualfnvGo1IdnbmwC31oKkJs1uqgmCD
 DWJn9aU8kA7ErJEwULqSczUaAfQ2du3TGVgETtcWfqJ65T9P2HEL31GNdJX0u+J1JeZb
 ym5pLsf69xSUq7B746fJHgbyez6V2SSZn8wmlZH0eZ3vJufyv4hQtjJBZubV4jvV5N7p
 ttBu6o/YcxhVFfNaJ9kPuY0erK+GRHI3cwkPCThG5iZWGrqOtogMTepyehuaYj5zQPJV
 Ncm/fqpi/8gPxeXVIpU/Xdx2kyg1Rj/BTVLb3zEty7vBwdFCbBLNu7/J7sLFzL+JjGiG
 StWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809785; x=1796414585;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
 b=T0OdoFRh6Rz3xrNNI0alhJMaA91EcvpLKRnd1ar7iUQ+6I4VsXoI7f0XKWqLJSbozk
 T4xr6A9774kVlNo+4rQnTxRkA/zlFdBKq2tuEDjlTq7NlW7aou2A5oiKm74cZ/swJ4mD
 Se2IzTPVIC4o0lk/GosSOogQIiFgBCJpdY9Xvik1lYQkJ4HrVTND4Eq7uFlmmpn/3RYf
 XxqwCJLFU7fBWMHwbn1VA2qhtgUdwilathE6STant/IOejXmW6ik8KRlj5Ctn9RDZTkd
 APjKfCV+rES1tSrgvlP5pdoBZuOCuOBlDPT1dh+o1VxjzRwfcoUU/yHG2+da6I4faT4d
 8aiw==
X-Forwarded-Encrypted: i=1;
 AL+hErEmqrwwDkoKoMA7rgEz3UogmhSN7ba/xgZFEpvArW9A9VhC8nQRhedfc2pp7TbtRKvmASXpqHt6opc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/c0wtPiZ2eMVJcraeShrKKFbvHivs77P9D+JxllT+KzcNOAwq2
 TAgqHevZ/cXB2ZWM/TZVYHPMEK5ZvOEtwtJ3DWkv1c0n6JAliPlMdh87D0LHQ2ULfFw=
X-Gm-Gg: AZFdTZckAaarsFQf4pbvwtaYv94osdFMasGXhgJ3kLBird3vHodn95nZmg0wSlk8Pe8
 XrS0Wo8NGpL84LRl1IWhtSOCfc/Eb5z6gYww/rvOYwLIDKOJ3LKwH9KkZRUq+ukfVMbnPiSvr4H
 PHKE/d6239kjeydAha3MElKF9pOsmt6H1s5KW7rWcBs1swL/3D70u3alrlP4xMDe78Mw3xQhpr2
 rqHN+7jPp3EI5r7/nj+7+k5sQqp8ymNqLCS8Vwv+0jzcFyHx5L9sBImRwVMUBJiSwaEkOLflZb/
 PVdltv5j/tv3MauzV+6igU7O68yrum1nDIoz0+xgbIAozvN8jliPzbT7vMoEr84zTAy7yq+LwkS
 /bD4ZFzodulPdQwubXmNJd9a/HFAtFDiVkM6kZ+k9qJkuPK2k0wHUiAQOrG5d7iHpx0047skSDV
 xF4T93H2EGlCKxFAFFg31WjSqUYBXKRC8iWGl9Heem32alpuxlnCUV1tCIoL2fTmE0mMF+ck5nR
 kxp3ocE6DC1CBsE33z2G2G08weap1x9oEsCmACfnV9rjytWsRr0+iEz9CJxe0NdeMPXVUjmxtmU
 7iBeSC/9RhVqYQmiVJYOzjAAN04itL0NKt4yY/DnDmEd/WPx
X-Received: by 2002:aa7:d402:0:b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6ba1fae103fmr14763271a12.3.1795809784883; 
 Fri, 27 Nov 2026 12:03:04 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba6f8fa5b9sm9906969a12.37.2026.11.27.12.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:03:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
From: Jerome Brunet <jbrunet@baylibre.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977968.3028968.220600254133838233.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=438; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=1x7I9OxtWjxbS+wEVDFGimHZA2zKBIWqfRJtzMCbXkE=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD7/5dtokM+ZkaTF6K2ZGVttk1rMrH2fK8un5tvb9D
 fstDRc7SlkYxLgYZMUUWWq4q8XfSWp9mTVd5zbMHFYmkCEMXJwCMJH4Q4wMmxfdaay4eymZS6GK
 Z55007ypBev3ur2PCN636eTcxxoMGYwMv2pstwfXV9w7/0GsKypkd/dKC/bAd4cr1ViY1xxhVqj
 nAgA=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:40:34 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

