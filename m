Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390B5CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA4710FFF4;
	Fri, 29 May 2026 14:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mm9lGvge";
	dkim-atps=neutral
Received: from mail-m9362.xmail.ntesmail.com (mail-m9362.xmail.ntesmail.com
 [103.126.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86762112001;
 Fri, 29 May 2026 14:26:23 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40596a441;
 Fri, 29 May 2026 22:26:19 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, Maarten Lankhorst <dev@lankhorst.se>,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, clrkwllms@kernel.org, rostedt@goodmis.org,
 jerome.anand@intel.com, pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Date: Fri, 29 May 2026 22:25:56 +0800
Message-Id: <20260529142556.3833775-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529122137.VZtFvQvw@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
 <20260529122137.VZtFvQvw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7420fd2803a1kunme34de274a313e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR4eVhkeTBhNS0MaSklKSlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=mm9lGvgeNttz3NAtznE5f1qkRm9D0UUEThEA9OVg2hrp1oTSq8zU2XQMC/qAy3pnUl10kBsAucyUf0RzDc3zG6ZLOP1VTKvCTbAv1P5dNgFrHveQdhIAatf47XRnXJK9B7/KjQrvRHsAGjBsd+weBz5FOoOyJPFURqGcniXCPSA=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=XIcFOKByaKlp7A36dRzcZgy0gMLVUvtFvUu9QwhQsDM=;
 h=date:mime-version:subject:message-id:from;
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

Thanks Sebastian and Maarten.

I understand this fix is already covered by Maarten's i915 PREEMPT_RT
series and that the series is still pending review.

I'll drop this standalone patch and won't pursue a stable-targeted
version.

This issue was independently found by our static analysis and validated
with a no-device QEMU harness. If the extra analysis or validation
details are useful for the ongoing series, I can share them separately.

Best regards,
Runyu
