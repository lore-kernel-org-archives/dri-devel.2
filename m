Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A254DC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CE710E6F4;
	Mon, 17 Aug 2026 09:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AiVa0IUy";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9519F10E6F4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:30:38 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495773ee3edso2788685e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786959037; x=1787563837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vg/Jh1xJqMzCAOU1msGZarPzfg6nU4pDbrQ+dCgsG9U=;
 b=AiVa0IUyfG+U/WKZPV1OqOf1lQknzSBSliUSYXWvxo6fOF2kV5FAOFEgtPrJ8o3Nyc
 4vwXpe4Q/k10uDm30RP7oDdRlV4hFWLj6kae6qilBc/mc1gIh24GoSOi4wUw4EL/FiHT
 d31s4vCuCvUN44MPxJfNPNXGEvizvd4rmhsHxJ5AqHoJOz/imBQcaTFXWAsg7K8gIfIj
 ZCLrcX+RGekOT1KYsVFWDz/sk0hymDdyx3QcZiHPPCoTrn9LZFZaHLnCZ0wuLCmLGfbK
 f78P4PhLjeXzwGzZPDjJpKNQuOXoFCyfVfsvYzDhTEEXC3b/57FwRILTcICChmjQTQkL
 7HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786959037; x=1787563837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vg/Jh1xJqMzCAOU1msGZarPzfg6nU4pDbrQ+dCgsG9U=;
 b=ApV935P1HcQtuDsyOmwTi0SpIE4JiVEw4QQst42zbkK9Dy4rKpY78oNtPJXBRG5I2h
 ELHUX1aAd25Y1MonyLxUNJfA8zrMwZys/JRiQd8ji5khJlLSV7V8VZiWdYDf01vmcxix
 bWMIvwheGNjHBBN08r8d9HDJ1CLZ1SIpN0x5sR2+L2llcv0kc9aDPbrMJk4o9G8Zic4s
 3Cb6vHZbxWbNMaXTTF8UeJmVZ7xnDfCE0F9OzOz9OV+8OTBwKDmRg6h4Chk5KaR3fT9P
 +LpjKGYfYN0D1eSNAkP01xyyzu58njZ1H3o2UIT4+QF6h31dqVB7AkPohbOn0dr/tZuS
 iotg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnQ1+DySvzdfSyTF2L/hHS6EpRNeEQX5yTj4BiDQftFCxZjsRp90qns4+S/hoEamWdVIERVhEKB4Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO95FvMH0VRoHLXYaNCCGXRcltsSwiVI4Ws2eRIkhzVCb/OIRp
 t8Up15qiCuUbKFBBW3IhbHSEDhWPYV6K+lsNuQiFhbE+nq6/Q2eqRrh8
X-Gm-Gg: AR+sD1155m5Ch/XLdElwsPFqpDlzonXOtxSc2GIW1L43eMF0Vi1SJN1syb72E2UY/vQ
 IL9tAykCo3/GsjUwxPCOUqMmVvzKBkhTYojxihBS1MOSCA5r35Zg9Phoj2lYNcOPGlVuMXKlaxi
 +YtYrekX8nmFgW+JWoneVJ3s7VC26Qi7g0sP3gMWSGMyc1L4eZsuARRrM6nWX1lZzPeynXmZ7tq
 3qnBABkwBuN8GFk8sLrQJ5NXDN4OeLFoFmxznvhgXdeY9lq+aaKbO9hxFCv1aVCELI33BJA8KaY
 33NmExZDDvhVzaxEoJs5uBuP3Zxyyv0vut6WRf7qxKB/50F+rOmxtdLehjM2Ql+ZU8XCaRFzm65
 zoWD7EgeN3ah7yuGnAxQNRO1PgzmX4KSnDJrbaUeXIh0BqMqL9khwwkZqbhB72P6WVBrEKVHBzh
 9Wd5yx8/Jj2zBlrSc2++0vgTxg3RKDs5PleEuSGMGgD7L3GPAPY9NVhqjLkEf9y/FJiTFsdocwh
 bFBtWwBNrSk0Mo1oZa6epUnt3VKBbRrcMijuBD9nCY7UmtYX6A/7+hpkERrXXwUSItWow==
X-Received: by 2002:a05:600c:1d23:b0:499:59a1:96f7 with SMTP id
 5b1f17b1804b1-4998792aab8mr184494205e9.1.1786959036570; 
 Mon, 17 Aug 2026 02:30:36 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8FC50027494B64639367E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:c500:2749:4b64:6393:67e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a31396sm2474365f8f.2.2026.08.17.02.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:30:36 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 11:30:04 +0200
Message-ID: <20260817093009.22359-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817072045.876042-1-triet.hoang.dev@gmail.com>
References: <20260817055315.C9AA41F000E9@smtp.kernel.org>
 <20260817072045.876042-1-triet.hoang.dev@gmail.com>
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

Hi Triet,

Thanks for picking this up -- the rocket driver has few enough eyes on it
that allocation-check patches are welcome.

The rocket_job_push() half looks right to me. The early return skips the
err: label, but bos is NULL there anyway, and the caller
(rocket_ioctl_submit_job()) takes the goto out_cleanup_job path, which
does drm_sched_job_cleanup() and rocket_job_put(). Nothing is leaked and
nothing is armed yet, so returning early is safe.

On rocket_job_open(), the v2 change fixes the error path, but I think it
only covers half of what was reported. The other half is still there:
the array leaks on a single-core device even when nothing fails.

drm_sched_entity_init() stores the caller's array only when it will
actually need it:

	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;

(drivers/gpu/drm/scheduler/sched_entity.c, unchanged in current
mainline). And rocket_job_close() frees exactly that field:

	kfree(entity->sched_list);
	drm_sched_entity_destroy(entity);

So when rdev->num_cores == 1, drm_sched_entity_init() succeeds,
entity->sched_list is NULL, rocket_job_close() frees NULL, and the array
that rocket_job_open() allocated is never freed. One pointer per open(),
unbounded across open/close cycles.

That is not a hypothetical configuration. The RK3576 series currently on
the list enables exactly one core on the ROCK 4D -- its commit message
says so in as many words ("Only rknn_core_0 is enabled: the driver binds
one core per node and the second core is left to whoever can test it").
Any RK3588 DT that leaves a single core enabled lands in the same place.

I would suggest not depending on drm_sched_entity_init()'s internal
choice about sched_list at all: keep the pointer in rocket_file_priv and
free it unconditionally in rocket_job_close(). That covers one core and
many cores with the same line, and it stops rocket_job_close() from
reaching into a scheduler-internal field to decide what it owns. But
that is a bigger change than the one you set out to make, so it may be
better as a separate patch -- Tomeu's call.

Two smaller things:

  - With the check added, ret is assigned unconditionally from
    drm_sched_entity_init(), so the "int ret = 0" initialiser in v2 is
    no longer doing anything.

  - Heads-up on collision: I have a patch in flight that touches these
    same lines of rocket_job_open() ("accel/rocket: keep core slots
    stable across unbind and rebind", part of a two-patch lifecycle
    series). Whichever of us lands first, the other rebases -- I am happy
    for that to be me. Worth mentioning because in my version the count
    passed to drm_sched_entity_init() is the number of *live* cores, so
    once cores are unbound down to one, the leak above starts happening
    on a multi-core board too, at runtime.

I have not run your patch, so no tag from me. If it would help, I can
test it on RK3588 with three cores and again with two of them unbound,
and check the single-core case with kmemleak.

Regards,
Igor
