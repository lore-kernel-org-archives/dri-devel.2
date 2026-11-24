Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E0606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwMhbtW9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD48110ECD9;
	Tue, 24 Nov 2026 00:31:47 +0000 (UTC)
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466BD10ECD9
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 00:31:41 +0000 (UTC)
Received: by mail-oo2-f2.google.com with SMTP id
 46e09a7af769-862a00144f1so839836a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795480300; x=1796085100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x6zdHjHGVwvVlbnZegdR/xLT/lgEN20BGxlK4KRKp5E=;
 b=VwMhbtW98rU630Kuy6y+NeGbKHgXL/WTvh/EzeG1QsnD+C6CsgvNCTxbvrhbfYLhBk
 6HPsPI+maqSzVjLzOTK58dNcDvR/yAYOW4ghkJWQDGMe8rl45Trx/QN/ZWSTyv/c4bar
 zQSmRlV8Fb0df/o8B7xM/XPE+xWjDvOZ2gOWixKENpOfvxd+nL0zWgzCBREfzhkhEpbe
 KMb8Yngv0i3PBLEpmLi/f0BWhG9xnzQfPH2s7Hwikp197HNYUtqBJaXI66syDRlCRo7x
 woHnKofgpLgjDcUWjJw/vXrJkh3/oGd0OorNqrOSoIe8PpjAc5I/a7VIjcqULeXHQPkm
 MULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795480300; x=1796085100;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6zdHjHGVwvVlbnZegdR/xLT/lgEN20BGxlK4KRKp5E=;
 b=eLe1cf07K48WRAnBI+uVeKaecASkcG1AKPRFCT7a2TQEsbXaivUSJYZn1Zk8fF2ZSL
 Tne2N9Y9OE73T4dj5OYy4b8FQO9tmrT2tCt3fJtZO8HoxMhXCnl/duaeVtpi2Ai5h0zA
 Fvt11yW90fWwhzPhNwyWUyMOhxwL+7h/bB3NgDo1k1NW8Sf+5LOUntFCYLl9PP1OIMmo
 h7g/oXQPRf9ALa5Ith42tmkM2xEDQMCjf7Tuvy0pbv5M4h/pVg4g6X2RDCIJBJ9kxhTr
 ZAP4orIvUAma7KZV0UMQBY0glSD2mSX9R9M6PEKfxgKoA4YsBWNYLPUonHtvCvZNdOte
 mzZA==
X-Forwarded-Encrypted: i=1;
 AL+hErFQhhEno9/BVn3IFDQ3Y4bCWOV1YcxNg/kLK/5O5pAkYhvbC4OOlVGt0zs6Q/8NQqC5xENzk45nxRw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RzHKhmRqviqiwOWotPoc5+TE4RwP0x2qgBAQeNuwgy0gTGO3p
 w5rlVjp76PfJ8RbphGP8Y+WJE4Cw4YEUsQa8UwPA20OuYqpb+DqOOlFc
X-Gm-Gg: AZFdTZdBQrYZJUBMO/eo4VFEaR6IgrJIozsr2d6cID0pqL6uyLkgfAxPw7BXVkvLKms
 5kQzeIMzpmzH0EksF+gjJxH3dMCMYHyi1/ong69ILWdNGlAnT7GFc9HPJYRe0CP6WJUQHtnfF08
 9aVE86rrdfRnmRPs5lLL4cbYif35HOerHqgXiixDNErExTUTE/kwE1jnENWtYOl/5X/JMHdfSZF
 tLdi4/+IDseyMM+GEl0Mqgt6GHbv03dwlK9JaVusGqkNNpWw3nYX/+GIEJ1gxK0gpK98pmO00CN
 fAbso9jsIxyJrSHWACGf9ziq6hdH9qWHhxZc3WXgE+Jgbn3miUvByXYhFyqmony7k9cH29UZg+2
 mXPdVOBaAkLIkcQj9oGAhi61eaGNBctAIug5GPRTjlYAyGQx9ASDyoNdvr4N0Rhvxr+7GsRzdjI
 8VLz4QGMBB2S2qt1zr2baPLuTpKDW4JSoEZOQjXaNRdoc/NEy26NKVB0RWi0mZxxht9OaxXEPnF
 O6H6OawBk7HzIgAGtQ6/1pBvCPnQDf2HerbbTSucaI78LWfeKajI6Q1ZxMX0XJ2F0KYfPi+iRRh
 qTLn6lOh/CwFsKK/LEkqYUyRxyg96tfW9KcaUUJ/UoVa9Q==
X-Received: by 2002:a05:6830:43a0:b0:81c:a6c8:8a65 with SMTP id
 46e09a7af769-8631593740fmr14730091a34.25.1795480300341; 
 Mon, 23 Nov 2026 16:31:40 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::d500? ([2600:8804:5716:d800::d500])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631670c44dsm9477750a34.0.2026.11.23.16.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 16:31:39 -0800 (PST)
Message-ID: <fe208c0c-cea4-4e56-8283-e242ac1cd2ae@gmail.com>
Date: Mon, 23 Nov 2026 18:31:36 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zi-hao.huang@mediatek.com
Cc: airlied@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, shaoming.chen@mediatek.com,
 simona@ffwll.ch
References: <20261119033634.1844084-1-zi-hao.huang@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261119033634.1844084-1-zi-hao.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:36:34AM +0800, Zi-Hao Huang wrote:
 > I'm not sure the trigger is specific to our downstream driver.

I hit the same lockup on MT8173 (Amazon Fire HD 10 2017) with the 
upstream driver. v7.4-rc4, whose only DSI change is "drm/mediatek: dsi: 
force command mode in mtk_dsi_poweron()" from the mediatek tree, and the 
mainline NT51021 panel driver, which also sets prepare_prev_first and 
sends display off and enter sleep from .unprepare.

The trigger for me was suspend under Plasma. logind's PrepareForSleep 
makes KWin turn the display off, and the session is frozen while KWin's 
commit is still in the panel's unprepare. The freezer's fake signal ends 
the interruptible wait with -ERESTARTSYS, mtk_dsi_host_send_cmd() takes 
that for success, and the late CMD_DONE lands in mtk_dsi_irq()'s 
DSI_BUSY loop. After the watchdog reset, MT8173's last-PC latch showed 
CPU0 at mtk_dsi_irq+0x84, the DSI_INTSTA read in that loop.

With only mediatek-drm.ko changed, suspending through logind with a GPU 
benchmark running: without the patch 5 of 6 suspends reset the board 
(about one in three without the load); with this v2, 0 of 10, with no 
DSI IRQ or vblank timeouts, and the panel's power-down still takes 270ms.

The wake_up() hunk matters. With only the wait changed, every command 
waited out its 2s timeout and the panel's power-down took 10.4s.

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # MT8173, NT51021

I actually had a similar fix ready to go, and found your patch, so thank 
you :)

Best regards,
Ryan Brue
