Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85CCD4F41
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4BD10E601;
	Thu, 14 May 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mlXTNF0R";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D3310E111
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n/
 rcfQf0dCIxlJr4wvaSmuWkvrsnvYDXXitkaZWmmUg=; b=mlXTNF0RO80A4g7ZKt
 8TF4sdV/5BpDx4gXpIpGkbg/v/Gedfr6IimWrQTHsgZHp34qbmVsOwxS0zCGawk3
 XmhX74oZPI4O4dUcmHaexeAfGVzXVMLZS+z0L78zvcMxaqcm0jangt8p/dejt0cq
 jOla/LftSAw2N9+Vqcq8YT6+U=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wAXApbekgVqz+5QBQ--.35178S2; 
 Thu, 14 May 2026 17:16:15 +0800 (CST)
From: liuqiangneo@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Qiang Liu <liuqiang@kylinos.cn>
Subject: [RESEND PATCH 0/2] drm: Use seq_puts() for fixed string output
Date: Thu, 14 May 2026 17:16:08 +0800
Message-ID: <20260514091611.153919-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXApbekgVqz+5QBQ--.35178S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4R6zUUUUU
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC+wC4GmoFkuABwAAA3F
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

From: Qiang Liu <liuqiang@kylinos.cn>

This series converts seq_printf() calls that only print fixed strings
to seq_puts() which avoids the overhead of format string parsing.

Qiang Liu (2):
  drm/debugfs: Replace seq_printf with seq_puts for constant strings
  drm/dp_mst: Replace seq_printf with seq_puts for constant strings

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 14 +++++++-------
 drivers/gpu/drm/drm_debugfs.c                 |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0

