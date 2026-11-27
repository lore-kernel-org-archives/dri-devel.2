Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16019606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R/Fspw60
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E73112D67;
	Fri, 27 Nov 2026 20:03:24 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634E8112D67
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:03:08 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c5127c7abd5so1292661366b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795809787; x=1796414587;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
 b=R/Fspw60SjHgBD9xFzV/8mkFSI15EmrkbT/0dFfZrRxasDPLn6jJcG9bKkwJn3WPOT
 /C3lU+J6+x6sluuU4Ksm1zYFShG2r9n6mgpq7r9Ud0cUp/hHsTZs8JNlffCQALcyk32I
 Wv5IR5HY0PCN4rPWC8ln4vwogEUTdf1brneR3yWBPc6GB3T9j/etYxvnXosE/lQ3oHJT
 Kwd9wSTwNzXBPAPobejJg+afwCrK6FAwf63bvy7bSx6VoP6m8PfzkPui6JzHJ+uljAWE
 n6cWV039WCeSwz6lKqyC94Ul/w8Wwcelm1jgJc4h5fj+748nH025GKRjTplBMGtNrchi
 QwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809787; x=1796414587;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
 b=WLWuhew0P5LFqAQCcfIryjrPVVrGd/5Gk5fKj/fNpcNfOPDWuIn+JTBmJR6McemaY/
 Ii7MlIhRxlmay5pmSD37VPxx/8fShXSIn1gc946c4v5CzuIYkduapydWcGeW6wnyLI4j
 1x/Gl3uDWd/rCcikRwlO1yUpsKcYs6NH4NfsMERsP3SjNydpJ5/e4GwgrAlu9J73KREd
 fHVyhNfheoCf97tjcaphEkHdlNBwPIuaqG660EmpbezAA/3awq1tY8m8ZkX/kX1IcXG2
 1MxPb4gAKRaTHA7914L+KVClI9RnvRA++NgHLB3pSLkYYPZJ95vIn3ClFlAfKoRLu8zR
 FnMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEXGrQW4K5ywWNgOBHbWY30eEKNpQL8NmBudof0pRmNTiKNMPuAyR1M/g6B6mevONgiSfRhgdS2gow=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4EdzCOztOufpvigk7WeYwEXPQ+m9o3uVi0e6zlBT2V9dkp5uM
 5wdPpBW0MO/9KiYakfGB+2bQCLWOjcaLvFRsxFIL86c/HEBZKjxgZ6bGW24d/bzKLds=
X-Gm-Gg: AZFdTZcvI70nsG8Ges4xTllyjSDCDtcRTRxaO2N4m+FptfphWfpjEkC+VuRvg0ZqBqg
 UxOHqh0Tv5VYkaNdNacRIe6D0jXrYVIccLh4ebCPJXSzeRyaVRkO6WOwrEvaMq5H1N/lxeFmrCu
 u6N8Q/iSBb82zklKcZMSCGyJMGVwfrQoJV2cCs9SDusR61yYOs1Up4MPeZcsTr288F0MH3iIG1q
 Ug/4hQpbTPIlzbh0swrVL+BdyQZOkx2NuD9dZs1puZEJRjiylwSdwio2lRTg8EVv7eJpRQFCzzu
 jwtCxhSma8z/QB+JQ670DuM5e0UfKvm5zb8OeULJwKdHXMHX5Wvw5K/eW+N0GlgbctwF5arcaDu
 MOl1nmh6uC8LJhE2uVYa3YsrXeIqWXA3grxKso6nz/BKNmk6JbKKw96rxkg4ng00xhd0L1SxlWR
 eCs02dibgIIDDL100M37MxPZOAwE7khLS5Jdxmiy91kfht4JTVi2++9BH0cAp30zMg2ABwHxlDe
 pu6BEckHBb4dvV6ebbwwl6TD57IIEpGpVClPiJgvOvc8F4DIAIZBTKsX59yjr5fhUkjgIuT715X
 kmLd17bv4hCUJE1aR5EEdOL9aGRaeMglQ9Ix35OGDpjM4C5I
X-Received: by 2002:a17:906:5908:b0:c3f:d8f2:f08e with SMTP id
 a640c23a62f3a-c513aad1aa7mr1591096666b.44.1795809786817; 
 Fri, 27 Nov 2026 12:03:06 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae661b3sm897861366b.16.2026.11.27.12.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:03:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
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
In-Reply-To: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977969.3028968.47907747276860033.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=576; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=w+BoHiPo+P6YGPZSkRwTWt/kGI08hfYqlVrPoLWDzrs=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD781zBdazCsg9lL/zber23mznz9vt33xqqNRSyql5
 9/lP4XqHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZjIejtGhnPrDj/t/PYpMF4p
 5/BazfN3D21QT/A6eNT9yBfJZ1dZop8wMpzYzS/A8uDOTLmdR+uChb9oSs6TL/Rb7JC9947joo3
 LLnMBAA==
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

On Thu, 19 Nov 2026 14:40:35 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Clocks obtained through of_clk_get_from_provider() show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> Add a new variant dev_clk_get_from_provider() that also takes a consumer
> device, so callers can provide it, and consumer's name will be shown in
> the clk_summary output.
> 
> Reimplement of_clk_get_from_provider() on top of
> dev_clk_get_from_provider().
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

