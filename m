Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48054C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC9B10E258;
	Sun,  5 Jul 2026 22:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="rZuXWZbw";
	dkim-atps=neutral
X-Greylist: delayed 8400 seconds by postgrey-1.36 at gabe;
 Sun, 05 Jul 2026 22:41:31 UTC
Received: from smtpout4.mo533.mail-out.ovh.net
 (smtpout4.mo533.mail-out.ovh.net [46.105.32.238])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDE410E258
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 22:41:31 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gtZps523lz60f2;
 Sun,  5 Jul 2026 17:53:25 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <mripard@kernel.org>; Sun,  5 Jul 2026 17:53:25 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.96.215])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gtZps3r5mz1xpp; Sun,  5 Jul 2026 17:53:25 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id C28208E18E8; 
 Sun,  5 Jul 2026 17:53:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00581ce1a25-37cf-4ab8-b85f-94ca8e301fdf,
 683B9B328535C0D7EC9FC65928CF7512BF5568BE) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: Update Natalie Vock's email
Date: Sun,  5 Jul 2026 19:53:05 +0200
Message-ID: <20260705175305.5589-1-nat@pixelcluster.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11102780459085881608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTERHsNAQghgjtX4RWKFPuqIEy/wf74l6izFnx3irNiiYDWKMxYlQV3ztnaqLtsPSKVH529UVv/RnW0qfYe5fmWXSBq3h0tNLP903RECH6H2gq9g1npDrIQJxpCTEpMYDyPDGM+STzwB/gFDMW6RB30Wx3IFj2773diMu85sTdURen/awqeXT2cM0K2S8NMLQyj22XNL4xJEjt1TtT2rtY8z7iPN/RZlIed5D/FGZoszFSt2kHZLQcZpWtMd54L2DQnKo77cfZ283LKlg8sxhiauTJvl151tZSn2Jp2B8ibTMolTWMUfdPc3GPcCOptqXgU2tbtEz3DX5cWWjJTNb4Jgk71vlF7UasNGXiPxTvgNokNqpkKjJ8J0fsbPW/GyW+ZUMlvB0G4YT4zGVSMOoGWs6q3VJkNvL6sEK+u439hy+CZGsgscXBBCvrVtxK/lazCmvqx/t3hMIxhZKoOY3rGn3LsewclyR5ZGNnvPMmsg3ll2ckz42Y18rZKb3FkqsgIGzqLJFp0mS4VglPFd4OQR7GrH6J/bfc3Fd2jpl1kI9vDkLyu8Ml5ZQWzuejgnN8XzmTSrrFGS/bZl1C0XmJPZj8FYKztTsnUC1OH+nmD7EeUZZhJuZUGHrbR7o02TIuFNOhfZSYmr1I4L9EvLdQ0LLanCIl8IpBjBGcFGLi7qjA
DKIM-Signature: a=rsa-sha256; bh=SLuS2uS6RgZGB1ql0D+nnk+eDSxcq2jQnWd6GhqMUSk=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783274006; v=1;
 b=rZuXWZbw5IA8cq76PH03auRWfNVc5bOL3ZlqSgSoqslrbFNRQ5syxfjqLOGGfJNI4tBgqIZJ
 yruu5IVnqd08nq7k58JthXqUDhlw94GrOg33MNjN6YAaH3/UYbdupoQ7D4NC8JL3vzuNX65sR20
 P99Mp8bC07ddO5HysaFvzoFzJKQJFpuuYlP/HJpgjpuYuL8uQ28nr+KXVc0sAwPNSwkYrwLLy1H
 tKkdwltEu8Cw4xVXDnUyyrLsKMzJg5jPPay0wFh8MMakptYmBOtiGWlgUlFV9BQ6qkFm5vS8wUW
 zs+de0RV5COolaktJkIi+GImKaMShMfOCrMzj2UmpYvfw==
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

From now on I'll use my own domain for development work, reflect that in
MAINTAINERS and mailmap.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index d0d1367a261b8..3050ab1b97ea2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -627,7 +627,8 @@ Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
 Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
-Natalie Vock <natalie.vock@gmx.de> <friedrich.vock@gmx.de>
+Natalie Vock <nat@pixelcluster.dev> <friedrich.vock@gmx.de>
+Natalie Vock <nat@pixelcluster.dev> <natalie.vock@gmx.de>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
 Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
 Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 377d224c5f76d..0caa9ea58db04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6636,7 +6636,7 @@ F:	tools/testing/selftests/cgroup/test_cpuset_v1_base.sh
 CONTROL GROUP - DEVICE MEMORY CONTROLLER (DMEM)
 M:	Maarten Lankhorst <dev@lankhorst.se>
 M:	Maxime Ripard <mripard@kernel.org>
-M:	Natalie Vock <natalie.vock@gmx.de>
+M:	Natalie Vock <nat@pixelcluster.dev>
 L:	cgroups@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-- 
2.55.0

