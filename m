Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C560D109318B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C427910EAAE;
	Fri, 20 Mar 2026 08:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="LZr/A/Pv";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Fri, 20 Mar 2026 07:44:45 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF1010E00D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=49
 MLMm2kYF+EwW+R5CMI+SZqwQQ7hOJulu1YCAUAv40=; b=LZr/A/Pv7JQMcHcHev
 dh54SR3Uario7obLPcNUJnwXHjitqz9nADbQlDDGbF30ojgSJuGdpldNHJnqSZT5
 rIHWPl2cVdkuAPbbZEHldNQB4heTCwVcClK75/0RaVL5NaIYP3eN1dY9NDambR1n
 im67edN11kKpkiJ/d4xDHTsXk=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCnYRfT97xpLMlnAQ--.10124S2; 
 Fri, 20 Mar 2026 15:31:34 +0800 (CST)
From: liuqiangneo@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH 0/2] drm: Use seq_puts() for fixed string output
Date: Fri, 20 Mar 2026 15:31:26 +0800
Message-ID: <20260320073129.145575-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnYRfT97xpLMlnAQ--.10124S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4kXrykuw48Zr4UXFWDArb_yoWxAFbEka
 s7u3W7Krsruas8CF1IyF1fJayjkay2vFWkXa4agFySgr13Xr15AayDKFnrXr18WFsrtrWD
 Za4rXr1rZF1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8A9N7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC+xa8Hmm899ZKPwAA3O
X-Mailman-Approved-At: Fri, 20 Mar 2026 08:38:22 +0000
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

Changes:
- drivers/gpu/drm/drm_debugfs.c
- drivers/gpu/drm/display/drm_dp_mst_topology.c

This has no functional impact on output.

Qiang Liu (2):
  drm/debugfs: Replace seq_printf with seq_puts for constant strings
  drm/dp_mst: Replace seq_printf with seq_puts for constant strings

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 14 +++++++-------
 drivers/gpu/drm/drm_debugfs.c                 |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0

