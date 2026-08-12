Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F013C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F025B10EFA3;
	Wed, 12 Aug 2026 12:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jywXgEBV";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015EA10EFA3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:49:08 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso560425e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786538946; x=1787143746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
 b=jywXgEBVyWrpMndyBBGAAMxwQkbbKKXtHEQVh2KHekncY/fNspgznpTDBkn0cHma56
 ZjkSXGR9u8y4Qt/R0mPrmmX4yvdAaiZDdGV+LYef6AnlBhnSmQU+BfdERHHTzzcw8c8T
 LXA1qzPVh6o+mL5llP3TliaJQEIkyMUEILrjA+zQ5CjqObib3SmHt5et4YTHhl2S8tRT
 P0KjarHAMIh1uXMn7jZAFoBV12NkgtCbG0UmczrwWLrLCALFhvrJoVzY71tsDx1IXa/o
 D5oDP7gdUHlcOZBBjimGY5Pb6YFi+Lg7DHbvks9vSm3s3ESxn2uEkSwg52wQhXqOeEwb
 waBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538946; x=1787143746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
 b=Em7Dypdf09EKn2rl/EGM6hZp8XH1PSYjxHeYgncqHQ11e9ZQVfBrzRfEgQ7upXWO6B
 BhpDJGAiIb0hoU1D6c8VTqjqHvjzULBeML/2luPIYcbmhMtbeDNqxHlAOs9CiUmVMYa2
 BOa5Gsgcxc8OAyw/MZNWFFES5auxcskaTzLYb+eeOpGlstRGcR0LWWGSiqTlo+YTm1Jd
 eOVzMX2AMKc0oafP69wLYLG0AjCEk0yowtMh6vgfD4mlE9p8eHSWq+NovQKctS3TIMdW
 l9Vig6g/Ez1FByv2gTYaJWgr7RMeBr9QFUp2xMeEzNwF10O4MU2y4bV9XB2UiTN5MXCU
 Kk3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2OlZoFs8hLGPNy5+2O5XZnpTGVVtyu2aAYfm3Ox6shcA5zbGiiUMfDnksBbI4jGKRJBhNt3HxVHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6Qf2qpIxKmSqEu8R7ydM0rE6gUZuINroDMxQBuwL6LG2KRfOi
 V/iJJ8CzzVvx9slpcoJxK5heP3Ee+bnLGhHgDvVmnOquGVN+iTrMXGz5
X-Gm-Gg: AR+sD11ShyidN1DSYQ0U4VKMO21elbsiSMPWb5CvQ5YHK3/aahiaf7Jj1d2amk1IvaU
 xbk1PitCOgzUOd6cpeHcaimdUIGQomxdLfN2A8BVgvXig+wk7r7DJMkRGK6d+12SgALsqdDxQdC
 lflXinnY+GcSKyAkxCC9tTLI+b+MOfsc69Mpo9oUv4gO3Us+/9wykIgW0wW8tP5JXJRyPID9DFY
 +qQXB33TKNZ8tL7bNYfQkj4woyFB5ZLm8oRxCWxuetwEWOiY99PQ8BMFRYXBYCqQ4uSN5eIs7kA
 I1d+hCl0y0eANBUJs5hnvq/MNDb/YqMp6itnuGAwwc6EbhmfpEURZwkC7hOyvFNCU42egcRfdU8
 Y+MFlvB5s6fGqDahD8UCD5Mh197XBxhPFc78wI7hNQ85tEaixWANTO/EEI1KJVEGrqQw2ShrvGc
 7Dj9qeMg2jqqCgZIRehxFms7x6pdYZqL7F20Zw9K7ZB48q/7ZBOxHGWhMLt2tiggsxNwBjzA77r
 md2p9sNnPFKSoVppu01tlUBTNoXvTghOVvyfzUod3TdHilJ66xtAX8tJEpNlYSlmp/w
X-Received: by 2002:a05:600c:3b17:b0:495:71ff:598d with SMTP id
 5b1f17b1804b1-4997c0ca479mr29063825e9.1.1786538946151; 
 Wed, 12 Aug 2026 05:49:06 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu.
 [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e260sm7247226f8f.17.2026.08.12.05.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:49:05 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: Igor Paunovic <royalnet026@gmail.com>, alchark@flipper.net,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 12 Aug 2026 14:48:47 +0200
Message-ID: <20260812124850.6597-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-9-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
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

Two things here, one of which I think has to be fixed before this
lands.

The first is a comment that outlived its subject. This patch adds the
following just above the PC_TASK_CON block:

  /*
   * RK3576 arms the same DPU completion as RK3588, but the interrupt
   * never reaches the GIC. The completion itself is visible in
   * INTERRUPT_RAW_STATUS, so sample that instead. The tick cap bounds
   * jobs that never raise it at all, which is the same open problem as
   * the wrong inference results.
   */

That is the v6 comment for the poll. It states the premise your cover
letter withdraws, it describes machinery this version deletes, and it
has no code under it - the next line opens the second comment block.
Left in, the driver would carry a claim that contradicts both the
commit introducing it and the register description two paragraphs
below it.

The second is placement rather than correctness. This patch also
factors the completion tail out of rocket_job_handle_irq() into
rocket_job_next_locked(). I read that as behaviour-neutral on RK3588 -
the return that used to leave handle_irq() now leaves the helper, and
scoped_guard drops the lock either way - and the numbers I posted on
1/10 bear it out. But it restructures the shared completion path in a
patch whose subject is adding RK3576, which puts a bisect in the wrong
place if it ever turns out not to be neutral. It would sit more
naturally in 1/10, which already touches that function, or in a patch
of its own.

Both of the things I raised on v6 are right in this version. The power
domain list is attached before anything that would have to be unwound,
and the comment saying why a plain return is correct there is a good
addition. clks[] grows in the same patch that adds the two names.

I also went looking for an ARRAY_SIZE(core->clks) or
ARRAY_SIZE(core->resets) left behind, since that would walk six entries
on a four-clock RK3588. All six are converted in 7/10, including the
two in rocket_drv.c's runtime PM callbacks, which are the easiest pair
to miss.

Igor
