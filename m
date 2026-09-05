Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73453C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9240510E2AA;
	Sat,  5 Sep 2026 15:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cc0qkNhg";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1A910E2AA
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:11:34 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd82be878so371715e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788621093; x=1789225893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V6Tg/R56zXVR2Nup96RdAYV8c+PyuQeFJYrSPcXGgxo=;
 b=Cc0qkNhg3QDeFoZ7aOJGsEmr7phe1iRpjDqOyxVXIyfIXAJIdaD7O7q/sjcK95BSb4
 0aOj0JT95OdN/n0CkNumW4Rl9Muq1dUofIqKHabGyJ2OElEFq7JgojD2OjDudklFscZA
 /glqjF+Eewx+xTdNX3aEeQc6jvHRv2xGkCoI4a+1PA+uizlfj+jVcfwmfhhXF9fXFF6a
 9UWHSj5DxFxk6MZwiaWy8ZZF6jCqYzyaZfFl8uzs9OBvvY5Yp3s9V2YU+P9Om687QQAa
 qmqKFdYSg/yv8h2uqks61TCLmtwEL9UEbtBdhV5ju9G9aSYc2YAFH46ZdVUkFcvbb7p4
 jBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788621093; x=1789225893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V6Tg/R56zXVR2Nup96RdAYV8c+PyuQeFJYrSPcXGgxo=;
 b=EPRU6JXiEpVBdvFcvS4gPkwTk7EAz5FYqFEgcd+Lkft1Z8wSYcWHYLZnZIxzHC4aVR
 O2/cHOP/8nlw376MGcl47QWXXq8TOEyFbywE08WQK70wa5AKVO87VyU1KC8Zk+qs+izc
 Z/UU6mC5z+K036WM/dTD/XwpGwWRDB8UrvXPup2SWi4wu1PhCTBvk8wsbVRHecVr3zCH
 JiBoNDKUy14FVcxtzXr7zxN0fsA5Ec/Axh0fNvNhDRap4Bm4L6LlqvjnvI2ohzUGiynS
 rXTFHo7X9B4x9akL2OU97EAaZSzdkbCLTWKafO8Oi0/FHH+5RmPecuBrlfBDuDznfng4
 36ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwayH8NT5NhKMV/cmn8lb505SmlQ7yqbVTbs1LykSXA4/AYDUBh7Y6WT1IFHn7Qb+UcA64jMl8saBw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsMMR1P4+AuShdVgotq3O7tpIYZPj+aZ7N1hFTZ//wwBsUeVa8
 iWyhRrv8hk3GVjuxPrMb6vXhGRXCnPSSIJgdm0dtq6TcH3s3mgGruWZ1
X-Gm-Gg: AYBFou2xJ8/76XFX7hUDslintPHtk9mTITIU07WTKFJe/Fck8jNSiu8EvuzDezaRtP2
 Tidk+QODmJsPmbSxNJJlDupUA3Vo9les6mKTQxw3EwFJDhzqQpmmV27Q8BoD9FHCMIou9rMRyxS
 P88IYhkVzDB/AauA8ehqfn9vkDN4YlaqHmRVL1SUrlGKlvjolQmcfHy9dzD4NKKVYiTf0LQHrzd
 /ddf8oolU2XDSFZ0HVUw2g2v1IGfv6jT6hcm2NT8dNE3DG2QOCFVUmnCrqCW+fNNGfE5e+ZwEe/
 DXfli6rUHYgIsljjfuLQgD3r46XVXV1bLIRHeWiVyFTXtxt+MY1om8fZImAm0VZq7ZKOxN8XBb2
 vdXdf9u5xtj+93/pxOL2tBNll8XXBaGgKPp/jSoJvXmjIB+hDcqXM3Rh05YNPYWlJ3/dHmLxtAA
 lXqDIgp4/wr/DeJaxi1NmVvmDrDaKWsk9ULCSGzTu9wt7r4T+I216Pz67hSLLmPU2LAZQaqwntK
 hdpy7YvLmae0c0LewtBCkaY74gMHnU9tfJNJQ7JkrXjsc9wy83Q7DOodJmWXMx1OA==
X-Received: by 2002:a05:600c:860b:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49d01dd6b62mr41625625e9.2.1788621092762; 
 Sat, 05 Sep 2026 08:11:32 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E0061C002CD703C2CBB.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:61c0:2cd:703c:2cbb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm11955662f8f.2.2026.09.05.08.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:11:32 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Date: Sat,  5 Sep 2026 17:11:06 +0200
Message-ID: <20260905151112.8752-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apwUewaRnoTNXHCt@rock-5b-plus>
References: <20260904125936.26234-1-royalnet026@gmail.com>
 <apwUewaRnoTNXHCt@rock-5b-plus>
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

Hi Sidong,

> I've tested this patch in Radxa Rock 5 B+ and it works.

Thank you. That is the first test of it on an RK3588 that is not mine, and
b4 collects your tag with the comment attached.

> It seems that there is other issue about num_core. For example,
> sched_to_core() finds core for sched with num_core and it could make
> same error like find_core_for_dev().

You were right, and it is worse than a failed lookup: neither caller checks
what sched_to_core() returns.

I built a KASAN kernel and unbound the middle of the three cores while three
clients were submitting to all of them. It faults twice, once from the
surviving core's job queue and once from its reset work:

  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
  Workqueue: fdad0000.npu drm_sched_run_job_work [gpu_sched]
  pc : rocket_job_run+0x234/0x838 [rocket]

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: rocket-reset-2 drm_sched_job_timedout [gpu_sched]
  pc : rocket_job_timedout+0xf0/0x1e0 [rocket]

Both are the third core. The workqueue names are its device and its
core->index, and it had been left at slot 2 while num_cores was down to 2.

The fix is one word, and it carries your Reported-by:

  https://lore.kernel.org/dri-devel/20260905150432.7477-1-royalnet026@gmail.com/

Same test on a kernel with it applied: no faults, journal clean. It applies
on top of the patch you tested, since max_cores comes from that one.

What it does not fix, and the patch says so: an open client keeps an entity
pointing at the scheduler of the core that went away. drm_sched then logs
"not ready, skipping" for every job that lands on it - 25006 of them in my
run - and the client waits in dma_fence_default_wait for a fence that will
never signal. The board stays up and the client hangs. Making one core of
several safe to unbind while a client is open needs more than a fix, and I
did not want to hide that behind a patch that only stops the oops.

Thanks for reading it closely enough to spot the second one.

Igor
