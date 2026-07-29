Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06A4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2FD10EC3B;
	Wed, 29 Jul 2026 13:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgpVyafE";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F1510EC3B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:18:37 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-472d9d69e16so69907f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785331116; x=1785935916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjjw1RkAPYuo5u/kShDGP9k+6R1UYg0FLc5QSsYJaSo=;
 b=TgpVyafEI7venio9WHGYaBpoRNXSK6hQawuo9xmHlTLKlBbcISsZj1UEXec2vacl9m
 vztCnnxt/GZklc1GdohUYbl8cy1Pr4GyPp0s4HAZU63Q5dcta94DbyM9Q+HeqPjulPFw
 KFSIT/NJqDcGD3TVnEQmp585BNOMhGccAGJuN2uH+OAWD05quyXNzIQb2hnqbjk6NgKu
 25s+QbLtAgOaOCAtiCCYM0hD2JAcYWHJFoRxEnLZxEizRoqJUBKXIMTTqAuUMy0P7K+F
 O/ETKV7yNI7lFzaSuG0GxIlhHA3Ojwoj/9PWw3eDf2+/w5pQfyoge00gYVpWHxZQ+NU7
 fWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785331116; x=1785935916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mjjw1RkAPYuo5u/kShDGP9k+6R1UYg0FLc5QSsYJaSo=;
 b=Ds8JzH9kzbD/rEZcp4DjihCWAAg+V16zzIHbh7+SFiUv5L8OMI02MlYXjJfMtHhs4o
 jPU1Qk9JM5L8TS1c1WH1WCbNvGP2OZ93IRUZaEKe9XcuZFThRqCmYO47d2GPKH7ZxAlB
 apoEKOOhrHG92i2no7/QELezEvjOGvsOp0APsUCpO5csyWtzX+YesTj/VdV+zEfyRnN/
 98c+xXKW91l8eHbls0pxfWQg3KA6RnYssjb3CBBF5mXS2yghbf9kE4/Up+7K2nCOWnTU
 UVgmRXLzvU3fs1Yi+PwIyR64d/OwiIQ4kiLB/JAq/ThZNRgvDZa0GJfn2k0TpLohH24V
 EBig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw95vLykQitGWeBXJNtbBNM33V0O7Z3Xfwki/amVj4LRfXYRlcmeFSvTdakAObxImrAYm67R5FKNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcrhVQ/KK0Q1iguFLhr49iaw55PxvyC+2BFm7gbWV5GYpYzQib
 uzE2K3xse2udpKdqNftrP5FyCDA3R2f9ZL32CeKSMT6bnvbgT+s7A2YUgl9Kyw==
X-Gm-Gg: AR+sD12fLUl98DVu+ONCPlsSLaMggWv8CZj0qWuCHQN3HlFH/yM8eKnr/P9EeZfyK6x
 2e6JWKDN89uYtKQATV1+eBxhVrBg6ahmLRmnpPdaQCx67mwY7O102GiXrzifjWmh1ESuY0JJdcR
 9QSW/JJ8LKNuEsg7TdjRIoIEBpWFNH2OfEx1J7P95qV3/SVkFOBd+bjFPytWcbotGa3FN5d2xfY
 0A42aeqCklJn4meIOpabeAVvxDVejk/3aLH8J6AhyHCqbUesc2//DjMXUeEvBRbplVqr0Tb2D1a
 A9m01fQ/5600IsAs5XavijqeHhDmt5Tzwroe2Dj2MbzXDXTMAVsZqxrd/0xAGuQ4YwkC2t5BCMk
 Z/ork4QLA4ac/Y5Yuvy/Q/VNenD/baxe3HK0gVaQYrsXryVtIT74dz/8XgUVU6lySpqG7VApx1C
 j3Xu4wFxDyLsxaJctPtLOdSHNYTplVDdO9ybvJSFzbVfsY7s7y5IQPgOI8Ce3TPwOCIBk/TqBLK
 MMD+Fl2NtQLiYeeP0KBUI5mKoW0VOdOwVxuiajzBUb10a+36dKUfsw0v0Yd5sgGYvIj613eugQn
 3rgl
X-Received: by 2002:a5d:588f:0:b0:47f:91f0:9ab with SMTP id
 ffacd0b85a97d-47fb1e64f3emr5389018f8f.0.1785331116120; 
 Wed, 29 Jul 2026 06:18:36 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B886F0027B74C8463513DA4.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:6f00:27b7:4c84:6351:3da4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa394bsm7543751f8f.3.2026.07.29.06.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 06:18:35 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v6 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Wed, 29 Jul 2026 15:18:16 +0200
Message-ID: <20260729131816.129422-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610071045.3414828-2-zhaojinming@uniontech.com>
References: <20260610071045.3414828-2-zhaojinming@uniontech.com>
MIME-Version: 1.0
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

Hi Zhao,

I ran into the iommu_group leak independently today - Sashiko flagged
it again on my rocket clks fix [1] - and before writing anything I
went through the lists and found your series, so let me try to help
here rather than duplicate it.

I read v6 2/2 and the review history, and I think the patch got stuck
because it bundles two separate things:

 (a) the iommu_group leak in rocket_job_handle_irq(). Your fix for
     this is exactly right: reusing the cached core->iommu_group
     matches what rocket_job_run() and rocket_reset() already do, and
     rocket_core_init() sets up the cache before the IRQ handler can
     run and only puts it in rocket_core_fini(). That part is a clean
     one-liner with Fixes: 0810d5ad88a1.

 (b) the runtime-PM guards around the IRQ register accesses - which is
     where each revision drew new review comments.

Would you consider respinning just (a) as a standalone v7? I would be
glad to test it on RK3588 (Orange Pi 5 Plus) and reply with Tested-by:
I have a benchmark here that exercises exactly that line ~150 times
per second with bit-exact output verification. (b) can then be
discussed separately without holding the simple fix hostage.

For what it is worth regarding the AI review noise: the leak is real
but bounded - it happens once per job (the intermediate-task IRQs
return before that line), and the group kobject kref saturates with a
one-time WARN rather than overflowing - and the one-line fix cannot
regress the NULL-group case either, since it passes the same value the
current code already passes. So (a) stands on its own merits.

[1] https://lore.kernel.org/linux-rockchip/20260729092939.118779-1-royalnet026@gmail.com/

Thanks,
Igor Paunovic
