Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC4C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FCF10EDF8;
	Thu, 30 Jul 2026 07:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kX7M8Lrt";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5810EDF8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:21:41 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-473987fc217so123054f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785396100; x=1786000900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gbV641T0LN96g2Xmc5h13OPzy/3kHyekAXKlELi/Eas=;
 b=kX7M8LrtKfRl71oopFqAQ3a/Kiv5W20efsYrY89bhKiAJcp+ISc3LxA6nAdtZhYdVh
 mKNKkmToJK5xtGQbHV1pM8uayAOOl8rVce/gOi9vaoAlZvPfFnplzklntfwKdBHxdKV9
 IwYgmOBQd6xMYapKGs9fYg1OiwXGCVctR6sWFftKzUD04grBZvDdhkr0RYsMvwNZYfJc
 c+jLJmmauW4TPUjQVsCeSAGIrNHA8E9BinEEuN/q3wdkXHaW68l8+9NGwppMMcpj4Shw
 YYAY5lxjOMPd3oObPpI2VtRpwv1KdH0ELIxHiNJpTjA23jfMB6eqb/8Y5ccHEdbOEvJi
 HRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785396100; x=1786000900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gbV641T0LN96g2Xmc5h13OPzy/3kHyekAXKlELi/Eas=;
 b=rp3iVcSqAu9SIHr5wUiNczYVso7PgFagWYUuSsLuD5K5ZdSYYfLHV1P8ygzQeG7/3G
 X6x/fz7/JEE7JRW3KYfCng/0CkYqkyZn0EhUq+C5A9YJbG16Nwv/Pjb6V5irU2op3dT4
 9PdZ3Vy6KQpRTxh5Xp8zY4+w2kg/8WNrIqrVH18hDCSrS4SWCftG3JQLEtN3vtceSjFh
 DPhExol5DVhE3kFgKWicHEw/QFhGXWy/My3TMFN0DYsrAoF/WMtx2vWrZ1TgpNueK39s
 OCv9HoDZu7K5lIPEwXQmnldeyxami/gN+Oc7QUaJvV2z+6r+VpzvE4SC4riT9/usDs4Y
 LH8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLgdncTJJ7jMqOwnK+iwBGVNs2w3AGQVR2eZYw2/wGdnC6W5EOL5G/fDIbumHo0QR1koSMZ3tUUUY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAwzi9ajARc0Mlz1mbLcEsAPF3gwrytuckupxjc8bDOBNF7hXJ
 DuPMIXVn8NOGT397IdFRWnoaXQd5uwaBS//QbI4MRkybgOBzePUou5E0
X-Gm-Gg: AR+sD13Do1Qb4sK785mabamYqWLqZS8kkOv1UIBmxz4qGwQ2BY7PT8EQ5CB+wRdGRqR
 2btbz6InlIQDhtlPkFi8kfSNa9wLkpexF8tRogFFNgvudJ5ACmnLytsDLf07PvkNLW1AgH7jQSo
 TMb8xzd5vQjlVM/YahiSnhWd7rFnb2jT495CfZriqBvzVYW/E1gHeFQftQDLf26PzD2OgaVf6zf
 6PzrmrfzOapbrtgPjVWq3dMVqI3ldL5ob9irRbO9sc4FJITDxZsTPNqEWE1e2QGrVPIDSwKglaP
 QkgINxRgYD6PFaD6pUxZMO+D5FoIHkw8ikMRhEsRDERQk3hnNYHOoYedHxoit51ZAk88Gs7h01c
 eSg3WqeQV+OObeUW94VVMCz4tOUXVTIV7nxUU0bAS/cFTLWpL+ZsVCguZtHsEmUMFaqrBG4uMME
 sTDcWYdH6hZbY+KpN0nmGgKq9+mM8vWbo4EMeP4M/HpZgXkG+QgEXeKvH9toqRvNk/R7Kjxx3Pk
 CeZ8t6SXbLDKoVpkk19PWPfzD3cJXUOY7WM0CJq1LxJ3p4tPDs26cmlhSW8PvXuFnTjdw==
X-Received: by 2002:a05:600c:4ec6:b0:495:71ff:598d with SMTP id
 5b1f17b1804b1-49800e6d0b8mr16966975e9.1.1785396099679; 
 Thu, 30 Jul 2026 00:21:39 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8A5A00BF2D55A7591B4173.dsl.pool.telekom.hu.
 [2001:4c4e:1b8a:5a00:bf2d:55a7:591b:4173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010aaceasm37002475e9.12.2026.07.30.00.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:21:39 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH] accel/rocket: clear rdev on device init failure
Date: Thu, 30 Jul 2026 09:21:24 +0200
Message-ID: <20260730072124.174165-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708062845.716487-1-lgs201920130244@gmail.com>
References: <20260708062845.716487-1-lgs201920130244@gmail.com>
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

Hi Guangshuo,

I have been working on this driver on RK3588 (Orange Pi 5 Plus) and
went through your fix carefully:

- The analysis matches the code: rocket_probe() publishes the ERR_PTR
  into the file-scoped rdev before the IS_ERR() check, and since
  __driver_attach() keeps probing the remaining devices after a failed
  probe, the next rknn-core dereferences the poisoned pointer at
  rdev->num_cores. Every RK3588 DT carries three rknn-core nodes, so
  the follow-up probe is guaranteed.

- rocket_device_init() cannot return -EPROBE_DEFER (it does no clock,
  regulator or supplier lookups), so clearing rdev here cannot
  interfere with the deferral path in rocket_core_init(), which
  already resets rdev correctly further down in rocket_probe().

- The fix mirrors the shape the driver already uses on the
  rocket_core_init() failure path (fini + rdev = NULL) and changes
  nothing on the success path.

Reviewed-by: Igor Paunovic <royalnet026@gmail.com>

I also ran the patched driver on RK3588: normal three-core probe,
runtime PM suspend/resume and a Teflon/MobileNetV1 inference run are
all unaffected.

Thanks,
Igor
