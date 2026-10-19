Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A1606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qjxgQ+Ml
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC9710F2FA;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54AEA10E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:02:17 +0000 (UTC)
Received: by mail-dy2-f8.google.com with SMTP id
 5a478bee46e88-33baa8eb238so1481600eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792400536; x=1793005336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RAvRyHlIfiRgj3s2BsPRbneZn58NB0+Nwn0y6jlCCk8=;
 b=qjxgQ+Ml6GlK+y9ZSdSDg8aOrjoG5ucWfGTJOwHn7S6lZkKps+M1hOfMxNuazgmcXW
 GuDqQxuRkrUUolz/FAVak3sWeEX6WYawzkvNRqKkinfm0Z/yRlvNXcQLzfyXfZ5WZj83
 csFA6wRF1U2LtITDiJLrI/huslCzOqMsCDDdFoLIaAGWjgW5IWhRnwxrqDCFuop0bHXy
 oypOqwtj041uy1ypYDiific1sEOqJ4hRaVhk/Jwwm7cq1VE1ZZU3n5CXOwHWf3uqrbJm
 QdtXM8tSDbg9TAebXqYF1R2MeOIL8uIfHus5DX3h5B5HiAuXfP2zEE4vlOE106/bKf6a
 riUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400536; x=1793005336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RAvRyHlIfiRgj3s2BsPRbneZn58NB0+Nwn0y6jlCCk8=;
 b=uM2xbqqL3ISJVEA29bcwHEh+UcKXAwqEV3zN48Xmnrra+56M2Hzhgb8DrcAbS7nSpt
 IyCs7eUMQtEW/FSxoeJaa6IxGqMLN7bsV3ysgx5BtxDe24clLkq9/1x7v4uAgjEtt5vQ
 msCyifdvNx4p52V3dkanNMDsj1ACa+qfVSNyyAzMS3Ir+N7yUbYf4wpbW/hiSWJJtZr0
 QorxMwdwZNgY3Ist2SJlf28Syitb/9xwo7SdnAiualfJvKqZYtXV0vr77WClCY7UtiZO
 7s3Bvr2wmU5quez6pxl5tSsuUptLlsSX0uz8Oc+nPFvShJJjCLcA94p/N1O32zDh6v3n
 orsQ==
X-Gm-Message-State: AFq9FYIqKghXlCg90ZOWSvZnErpqO6k0IYnZBnELI0yHiR0rQumyoSDC
 s5FFbisjpOEc8g2rLxgkua5+2FsHichOVsZkRfc692GeXAcABtmTTTfo
X-Gm-Gg: AYBFou1qqKDwp950oa520kXy6ltxj9AyIdPQ1jNLOcAKc8KrRPKc7iSsG3x+7pcbGrP
 ODoR+XMN8WZRor1fy9aq302/p5VFosmFhB444vmrJZMYyKs1CKPUxAAb9mZgObd2qV6sMhw2Unt
 rjJN3IRqMlrxFdRFM60sbyGhNjq+9MMngc3Rg3BVJcdq+wBsiUgK+uBCGB87froDRY2vjuvPa7D
 8mGJ9S8BqS7vhxKFK2XmQjfvLS73bkIu14jzHQdIR6Orssu89VUO8IhzBAQvVirw1IYiIjZ5RWc
 pobHC5IUQ29vSYXIALqcaQLgI9HSOCSki/J81eOS6XsfEMPNFPuVVyeeoArlK8VBeZPUXKBh5Wj
 v8YNFscFxBrDT9zOuISHNvOhHmqrSsPAHVjVglGPt1vBR3DIBmGrmVClT23rpvlLlHpj7yUeHLk
 6KUymBwIT678RpCHl+/PQXSxLKb56VerbyHhyrMwE2U00uCQeoxKTYTvYkcNr9uWQl14gxrWFI0
 iOyn9Qz5FYao0C1Wl/nuy/zC2JT8uLp8Oc=
X-Received: by 2002:a05:701a:c951:b0:14c:637d:682d with SMTP id
 a92af1059eb24-18514b00b40mr12311278c88.43.1792400536345; 
 Mon, 19 Oct 2026 02:02:16 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:02:15 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v4 0/3] fbcon: fix rotated font buffer handling on font change
Date: Mon, 19 Oct 2026 17:02:03 +0800
Message-ID: <20261019090206.1094958-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix out-of-bounds reads of the rotated font buffer when the console
font changes on a rotated console (fbcon=rotate:N). KDFONTOP installs
the new geometry and vc_resize() redraws before par->rotated.buf is
updated, so the old buffer is indexed with the new cell size.

Patch 1 keys the rotated font cache on the font geometry. Patch 2
rebuilds it on font changes, restoring the old buffer if the change
fails. Patch 3 retries a failed allocation.

Changes since v3: roll back via the saved buffer instead of re-running
rotate_font(), abort the font change on rebuild failure, and guard the
rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.

v1: https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 50 +++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        |  9 ++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 10 +++++++-
 3 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.56.0


