Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB2CD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA1589798;
	Wed, 13 May 2026 07:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Z1sg4zZ1";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159C210ECDE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bt
 Qp0D6vHdKR6HkgZFmsrQBrm2zmBt70kTdlxMSUbIk=; b=Z1sg4zZ1rocTsjjvSj
 nd/SHKj6ZsEVtIs+y5PoqcZzffEG6D3QshMFn19k0escRlaHY4FVzCqWkBFRcNa6
 z9nsGFAJRibbXZvX9lCmIgs/upiXeVxKyCbxj50hW03SlEI7qn93uxBxChvOWrn2
 bI4F9hZSXwckHbEr9R2wpmcD0=
Received: from wmy.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wCHZeETKgRqTjh7BA--.6891S2; 
 Wed, 13 May 2026 15:37:01 +0800 (CST)
From: <w15303746062@163.com>
To: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: BUG: drm/ast: soft lockup due to missing timeout in hardware polling
 (ast_2500_patch_ahb)
Date: Wed, 13 May 2026 15:36:48 +0800
Message-Id: <20260513073649.352831-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHZeETKgRqTjh7BA--.6891S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryUuFyrWFy8Ar4fWF17Jrb_yoW5Jr1fpa
 yY9ws8KayDJ3WDKa48Aa1xZryrZw4rKay5GFykKr1Fvw1DKF9Yyr1Sqwsxt3W7C39FyFyS
 q3Wqqryj9ayDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jntxDUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-x0tEWoEKh2vCAAA3g
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Hi all,

While analyzing the AST driver's hardware interactions using our custom device emulation and fuzzing framework (DevGen), we observed a severe soft lockup in the DRM driver. 

Although the underlying trigger in our environment was an incomplete emulation of the ASPEED AHB bridge, this highlighted a critical defensive programming gap in the driver itself: a complete lack of timeout mechanisms in the hardware polling loops.

This issue causes a complete system hang (CPU stuck for 143s+) and leads to subsequent I/O starvation and system paralysis (e.g., jbd2 and systemd-journald blocked).

### Crash Log Snippet

watchdog: BUG: soft lockup - CPU#3 stuck for 143s! [systemd-udevd:162]
RIP: 0010:ioread32+0x0/0xa0
Call Trace:
 <TASK>
 __ast_read32
 __ast_mindwm+0x4d/0x80 [ast]
 ast_2500_patch_ahb+0x9d/0x120 [ast]
 ast_detect_chip 
 ast_pci_probe+0xa1a/0xb70 [ast]
 ...

### Vulnerability Analysis

Even on bare-metal hardware, an unresponsive ASPEED chip, a PCIe bus fault, or unexpected hardware states can cause the kernel to hang forever in the following loops during initialization:

1. Inside `ast_2500_patch_ahb()`:
    do {
        __ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
        data = __ast_mindwm(regs, 0x1e6e2000);
    } while (data != 1); // <--- Infinite loop if hardware doesn't respond properly

2. Inside the underlying I/O accessors `__ast_mindwm()` and `__ast_moutdwm()`:
    do {
        data = __ast_read32(regs, 0xf004) & 0xffff0000;
    } while (data != (r & 0xffff0000)); // <--- Infinite loop

### Proposed Fix Direction

To prevent the kernel from hanging indefinitely and to gracefully abort the probe (`-ENODEV`) upon hardware failure, these loops must implement a timeout mechanism (e.g., using `readx_poll_timeout` or a loop counter with `udelay`).

Interestingly, other functions in the same file (e.g., `mmc_test`) correctly implement a timeout counter (`if (++timeout > TIMEOUT) return false;`), but the initialization paths mentioned above blindly trust the hardware state.

We are reporting this defect so that the maintainers can decide the appropriate timeout thresholds and implement a safe fallback mechanism across the `ast` driver.

Please let us know if you need more information or the full dmesg log.

Reported-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Best regards,
Mingyu Wang

