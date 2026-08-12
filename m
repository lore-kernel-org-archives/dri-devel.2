Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99605C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C1A10E0D0;
	Wed, 12 Aug 2026 12:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mv5OxmVP";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DEC10E0D0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:48:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49552f516beso273815e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786538897; x=1787143697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
 b=mv5OxmVPQrxKUiAEVwhN3QtMTO0LzGlY7wjKDQ8nKNOiGcd7zwo7lc+i2aIzpAm+9Z
 x8Oyift5EG9k4HJMjC7cfDknxedmZwBF1XJgJBDComqP0b3XZr5wzWoshoAiGCKZ2qBw
 1ohvN/pZbj4fzKEc7RoipSv3eGVSEth3S+7xYzUUmh6BgkkWuBkphC+U6yfP68HQqeTs
 N8Gnk9tC+YFw07MiH1pVJUOu5G6l0VEgKMwxLC/kcLWcRrNt16NM/Yb0FMYZ2fB6BKRL
 tUlJmC9anKgBB9TzgQV6VlOY4RGf1JazqAo6sn/9d4gkEILl3VQB8N63EmalMDvvdCpI
 YELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538897; x=1787143697;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
 b=VyL2I183IHxuCfsWxhI4+KZTQF8yaLJUOR70E6V6kJ6tfaCnLOmtbmecsgxF3rtrh6
 aa31w6D4iP+fBdERpn0EMupBDrYMkKYx7ia9ujd3iqk0FN8YMivD1H9e6NPYHo55bUZI
 yhNBtLQrXV4DXPquPdbKi5ZDzN8pyTi2BdQlHovQa8jvaLEQ1MPCybEAXIw8Eim72b6v
 0yh3Q1zAa1Yhopf+rEMQO6Dpi36UPH2ehl/eg/nJLMn2uiLgTwlgzFYwhOt9ZuTE1t9k
 02dsWBVcGMgGcndkLOv2Fm7Wd4t0RkdCJbe1mgMI10sx5MhZEgZiJo96YDR3vgiJrDCn
 TpCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgWSsKJE/0Vd/UuDmivnuTSYHiEzWWcL6D1EELYetQIu9UXctnTr/b4wvufflm+kpion0/0qrE/v0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzd7Z+sO+80k3chDCCvJjDmgFCQU0KDejCcElpRD83osC5iNznA
 alwEMBqpcxYzuKsdeCNY6g053LVqgmEtctC5tls4GzmcRG/WtlESKmuX
X-Gm-Gg: AR+sD13q5H6emtpxRMcMtUNV+sVNiVzJ4cm+wE/AbKJhH99BJEGBZkbFHYtNXqGcp74
 BAaoYvFFA3OaNDWzKrJBa4qDos9vwkh0b+0sBJmoIxe1lnW1/2b0C9kNbnhxNLuNoPpZj5vfIlp
 NtnN9St+yY6PK38JRvnmcwLpe0wRPmU1RV1m775O+BHzZT8Z4mMQJGgAyEJPx/gTtV/+2QgmU6T
 t1R6kYKSDiHmMO2/toHfVdsFGaoHAnyfz6kYk2ysRATmnDUTcyMzVLf4AhGIsXp3UOepZhSxh35
 KJZx9YDLqU1srNJ3GKBCZI5+Z1Fvw7TtCRxt84e7KeRtJ9QA+P389wnSz72Onbjbf0wHm1xJUcn
 x3piA0RtiePguuELqmP7zYtFQ76VRiNVNAk+jwZtsZWWuBD8whdbpba5PXSfDVlSxQKIkMiCD7n
 x1+xN532QUq+ROYe0WlubIUNI++Qpx5ZFN0sioRxfnwzYUpeyqX6Ivn3EXHet+1hnHvgjuGRaxt
 MuDm3BeqIYzhrmS+26WL2QAYVZVgsGpfNtaMKixZ7vNBjeuJGG+crOEFevK6k1BZt8z
X-Received: by 2002:a05:600c:4688:b0:498:8e6:d463 with SMTP id
 5b1f17b1804b1-4997c0ddd6amr30132445e9.1.1786538897096; 
 Wed, 12 Aug 2026 05:48:17 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu.
 [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98ce0bsm47612095e9.11.2026.08.12.05.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:48:16 -0700 (PDT)
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
Subject: Re: [PATCH v7 01/10] accel/rocket: take the completion register
 writes under job_lock
Date: Wed, 12 Aug 2026 14:47:52 +0200
Message-ID: <20260812124755.6507-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-2-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-2-gahing@gahingwoo.com>
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

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores

I ran this on an Orange Pi 5 Plus across all three NPU cores, against a
base without the series. Both modules were built the same way and
neither carried any local DVFS work.

  base:  v7.2 rocket
         + Guangshuo Li's "clear rdev on device init failure"
         + my "request the core clocks by name" v2
         + my lifecycle v2 1/2 and 2/2
  test:  the same, plus 1/10, 7/10 and 8/10 from this series

Six phases per module: all three cores bound; core 2 unbound and
rebound; core 0 unbound and rebound; all three unbound and all three
rebound. One MobileNet V1 run per phase through the Teflon delegate.
The oracle is the sha256 of the tensors that both change between
different inputs and stay stable across repeats, so a stale output
buffer cannot pass as a recomputation.

                          base    this series
    three cores           89.3       90.0   inf/s
    core 2 unbound        87.6       88.8
    core 2 rebound        88.9       88.2
    core 0 unbound        75.3       75.0
    core 0 rebound        88.6       88.4
    all three cycled      88.7       88.3

All twelve runs produce identical oracle hashes and the same
classification. Interrupts per inference are 42.75 in both, and the
distribution matches phase for phase: with core 0 bound it takes 41.7
of them and core 1 takes 1.02; with core 0 unbound the same work moves
to core 1. Neither round logged anything beyond the probe messages.

That comes to 2596 inferences and 111048 completion interrupts through
rocket_job_handle_irq() with the two writes moved under job_lock, with
no difference in result from the same count without them.

On the change itself: I could not construct the race on the normal
path. The scheduler runs one job at a time and the fence is signalled
under the same lock after the writes, so a submit cannot overlap the
completion it follows.

Where I think it is reachable is the reset path. rocket_reset() calls
drm_sched_stop() and then says "Remaining interrupts have been
handled", but drm_sched_stop() stops the scheduler, not the threaded
IRQ handler. A handler already in flight can therefore run alongside
rocket_reset(), and after drm_sched_start() alongside a fresh job.
Making the write and the decision one step is the right shape for
that. It does not stop a late handler from writing the zero into a job
that is not the one whose interrupt it is handling, though - would a
synchronize_irq(core->irq) before the guard in rocket_reset() be worth
having as well?

One note on the base, since it matters to anyone repeating this. The
core-0 rebind step needs my lifecycle series underneath. Without it,
that rebind hands the returning core the index of a core that is still
live: the driver prints "core 2" for fdab0000.npu, inference starts
returning a different answer, and the teardown that follows dies in
destroy_workqueue() under drm_sched_fini() with a poisoned list
pointer, leaving an unkillable D state. None of that is your series
doing - it reproduces with 1/10, 7/10 and 8/10 absent - but it does
mean the three-core test cannot run to completion on a tree without it.

Igor
