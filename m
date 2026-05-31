Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575DACD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 15:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F92E10E66B;
	Sun, 31 May 2026 15:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nw5t7x6/";
	dkim-atps=neutral
Received: from mail-m93222.xmail.ntesmail.com (mail-m93222.xmail.ntesmail.com
 [103.126.93.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552F610E66B;
 Sun, 31 May 2026 15:23:20 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4079b061e;
 Sun, 31 May 2026 23:23:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, Maarten Lankhorst <dev@lankhorst.se>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, clrkwllms@kernel.org, rostedt@goodmis.org,
 jerome.anand@intel.com, pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Date: Sun, 31 May 2026 23:23:07 +0800
Message-Id: <20260531152307.1283430-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <89e4e6258c62e0e2829038dd4f5a29cc530b4344@intel.com>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
 <20260529122137.VZtFvQvw@linutronix.de>
 <20260529142556.3833775-1-runyu.xiao@seu.edu.cn>
 <89e4e6258c62e0e2829038dd4f5a29cc530b4344@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7ea1d80c03a1kunmeba3563a10bb70
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx0ZVhkZQkwdTEkYGhkZGFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=nw5t7x6/l8f6HAlZDcLLGMPbptweip4K4qDJP30Pu+gaL/IYyMv7uZnRnT8dWa3y/eTVDhBc5tCzQaK9o5Ktw+68G+u8WFurCa27xJjheQnYNetk/kZUXjJ5dw1i6vcdfTkRSoS/Py5/41rpG/sVcrcNkTDe2VLpLyq2oAUqE0c=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=MfgaZITVjf+xSp/VVqdccCnPFjcq7/aWQ93a8bo464M=;
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

Thanks, Jani.

That makes sense. I'll keep this as a standalone patch and respin it
without the stable tag.

Maarten, I understand the same fix is also present in your PREEMPT_RT
series. If you think it would be helpful, I can add a Link: tag to that
series in the next revision to make the overlap explicit.

Best regards,
Runyu
