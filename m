Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8AC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3894910E261;
	Fri, 17 Jul 2026 11:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dyoZuIo3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55A10E261
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xxIsQSg04fOTxREa+UoZNMpcPVEt5HkqPG/20xgZv+Q=; b=dyoZuIo3x2pEGQNn2Jt0hF6qe7
 M0s9k9X/KASZct0M+P9iAc9zFg6qGYCLBdBke8XFcWN/cKxlhYleEA9t8QpYjpfuv4uTmcHaQIg72
 z0afQO6qBl7qlMHvel4PzedrCuYUiCjf431wZ4gwntPXxedyiKiUxJvNuS46HcKkdhaISpOffnoJi
 lWa/J848/4Y+55e9G9qTJSgVEtRwld5w3NHpO700i3Z39hXa6JikIGYsjRrT0yJ8WqbP3aMqlgGvI
 j9ulG/wTEkRIUj1N/NgWuyYOruEBoYbkld4NsK7R6dYVYvbU0U5dL46tYlNNeXWmokKa6AiUT5mZT
 GfdE6BQw==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkgY7-00GMQR-25; Fri, 17 Jul 2026 13:16:11 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH] =?UTF-8?q?mailmap:=20Update=20Ma=C3=ADra=20Canal's=20emai?=
 =?UTF-8?q?l=20address?=
Date: Fri, 17 Jul 2026 08:14:30 -0300
Message-ID: <20260717111559.2759217-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.54.0
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

My university email will cease to exist in the next few days, so map it
to a personal email address.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index f4f18b06f2f1..6fe93913a910 100644
--- a/.mailmap
+++ b/.mailmap
@@ -539,6 +539,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com> <mkenna@codeaurora.org>
 Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
+Maíra Canal <mairacanal@riseup.net> <maira.canal@usp.br>
 Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
 Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
-- 
2.54.0

