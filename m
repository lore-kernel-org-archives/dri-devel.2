Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD7CC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FD110ED3B;
	Wed, 19 Aug 2026 06:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LBoZuKk6";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C0A10ED34
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:52:10 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4957952e0f8so707385e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787122329; x=1787727129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eNYpcIGxrPu5UcGxlHe8CSKb/lcjMt/RLjlOnDxhBfE=;
 b=LBoZuKk6nFuCHa8UD94c04gTA/Axg8IboASleqn57N4pGZBRT02Fs1Qm+MDTERnQ+x
 EZK/xRfZFiWxgmvQZJVXezuN33hdLRWgKsGIMz6lMGzdBk4RYmiasN7PXNGvyce59lIF
 tWbTTtj6mUaTr3BkXFe+SbVLTsxCLNM/KbwJDUp5ghIaCnsLUOkcLDotAmaoj21Oq9b6
 neMYaSbBcDqeA0tc8PMroXb2NDnOuh4sExp5LcxcwCnkq/WRbCsV/NulkSIBCS9R6tHg
 oRboKI2snNJpjraYVHaOJ33TLsyyuzDoMn1GYK/1bWXplc3FvSfyGD7kFTXqc9FYvoDe
 1KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787122329; x=1787727129;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eNYpcIGxrPu5UcGxlHe8CSKb/lcjMt/RLjlOnDxhBfE=;
 b=DTdfaEwBLgBkCvR+j+C8acZx6Jv21AyxpmxIh44dJsyIzqR3TfcKLGNZcPQI/3KUjI
 PrbmVHnv352MDbRJhaFwT2yiLmXVoOCaj0ZeQEpqaMEJjYSnuQoCSPLpHJZL+Qn61VW8
 pHy1ka2q0aZc/e6ObL/IFl4H3Jg07P2cYTWBVh/YCw8KjFhTiYRhNb/1uOaaXSI9DRdZ
 f3dlx1uCGV56xDbE0hv4FWSSJkEqNCX2r+wAdp5oFw/YQr7uva/VodMdU+wAaRJdxQLh
 cGH817r3vw9voxQfHYD2z+r2e+82O1zNTsmSpFtxf7KVlYZPwGyAyrg6z89BJT/kwL/i
 r0ew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkZiZVC4lzTrdrP+I4hAGmZoD1JVM7Pyb7jTfq4P17QlYEQiMgN3Y+1SwnXx2Z05j0NtOqiZ4JLCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxquKsF286UPvu/euwHeSkiOXBDWqfefXxCQqajrgokdgxoKa/V
 SHjFlBHFHqPnXvYRGwfHrzNbznUW6RWOvEnlNQ5/z1Hm8g2jLThdRH7o
X-Gm-Gg: AR+sD101K8KkMqKrgbDszgxqYmekWr19smLAnPIl3+wiOly2upYOzzQz896DANaa2Wv
 bKG6bv/XQmNtS6o0DJDxHL2xmyQJcMSuDgWR7HZAaVzK8RdBXwDjkLhR1OxMhzMzr5MfKU2xWll
 BWjJFo0/1yrNDeTeg9ufaRy+FQ3FV8sTtDb+d3PksHTxj2icnziGfv2iE5ccbqd/bW4leDFgtS/
 daVz8BpQlJ2wnyWhni4T7QC/o8fJUTsyYBnBeA+PBwmfAVhWy/6qmBKJB0WHNz158kGNX3bvW/y
 CdUnkvaZmbK5XrYZZE5x5uyp63wltY6Rxn3edVnFPVTUR2hnKxHt0e3s6NQfOtFl+xqPZL+xboE
 s633F0meMxfnQ4m9baEfHc975Dl8x/g7TkJoRd8uPbX7ep6NmWTMrGk5ZrrLrO05F1wHVQ7EAv6
 z7gHSoPlDUT4DzgG3+/Td+WxItlp7Fxns6LOdoQVQAj8THjjEmeH7ix4bdhw12GVciFe3W/wTY3
 WT05HpPPohsgbk+BigDRt/CZTTXdiP27vISpBJalrnt0XAXhkcFsKHnWx45rSe6gENj5Cgym1PQ
 MAE0
X-Received: by 2002:a05:600c:1c29:b0:495:4126:1e55 with SMTP id
 5b1f17b1804b1-499aa1c16d7mr24093695e9.2.1787122329217; 
 Tue, 18 Aug 2026 23:52:09 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B929600C08047F1073FEAD0.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:c080:47f1:73f:ead0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9aa7e8dsm24166515e9.0.2026.08.18.23.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 23:52:08 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Wed, 19 Aug 2026 08:51:45 +0200
Message-ID: <20260819065146.5904-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819013609.1613919-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-3-gahing@gahingwoo.com>
 <20260819013609.1613919-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Jiaxing,

Thank you for the round history and for running my archive check - the
zero stall/paging count telling us the MMU is not responding at all is
a better characterization than anything I had. put_noidle vs
put_autosuspend with a separately forced suspend/resume sounds like the
right de-confounding split; I will watch for the result.

Here is the induced reset test I promised, run this morning.

Setup: RK3588 (Orange Pi 5 Plus), all three cores bound. My 7.2-rc6
tree with exactly two rocket changes from your series - 1/12 and 2/12 -
plus one local test-only patch lowering JOB_TIMEOUT_MS to 2 ms so that
healthy jobs (~5 ms at this clock) cross the timeout deterministically.
No other rocket changes; in particular my lifecycle series is not
applied. PROVE_LOCKING=y and DEBUG_ATOMIC_SLEEP=y. Serial console
captured on a second machine for the whole session.

Protocol, built around the trap you described - the RK3576 symptom
emits from rk_iommu_enable() on the next attach, not from the reset
itself: 20 scheduler-driven runs over the model set with all three
cores active, a follow-up inference after every induced reset, then a
forced autosuspend cycle and one more inference. Two full passes, at
console_loglevel 8 and 4, because synchronous serial printing on this
path can perturb the timing.

Results:

- Pass 1 (loglevel 8): 12 induced resets. Pass 2 (loglevel 4): 8.
- Every reset recovered. Zero MMU_DTE_ADDR, zero "Error during raw
  reset", zero lockdep or atomic-sleep hits across both passes.
- Outputs matched the oracle in 48/48 checks per pass, including the
  inference after the forced suspend/resume.
- All three cores returned to runtime-suspended between rounds; the
  domain did drop and come back cleanly after every reset.

So on RK3588 with 1/12+2/12 the block comes back every time, and your
non-recovery does not reproduce. Combined with your archive result
this is consistent with the failure being RK3576-specific on the
platform/IOMMU side rather than rocket-wide.

Two honest limits on what this run shows:

1. All resets ran with three cores bound. Isolating a single core
   requires unbinding the other two, and without my pending lifecycle
   fixes that path is not safe on this tree (the list corruption I
   reported on Aug 12), so I skipped it deliberately rather than test
   through a known-broken path.

2. This run alone says nothing about the race 1/12+2/12 close. The
   same protocol on the base without those two patches is queued as a
   separate build; only that differential earns a Tested-by, and when
   it lands the tag will carry its conditions:
   # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

Raw logs (dmesg, per-run outputs, serial capture) are kept; happy to
share any of it on request.

Regards,
Igor
