Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1874606A330
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OYEJn1tm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5541210FFC0;
	Wed, 25 Nov 2026 22:25:37 +0000 (UTC)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D5710E20D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:25:31 +0000 (UTC)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3854627c1c8so8715645eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795645531; x=1796250331;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2kzPKo/9bX3t4mDGI1xxNnDKhyKkNyEfJrqaFNBk7E8=;
 b=OYEJn1tm1pJQ3nIYe52OeHDXoW4peMcwlYINNJoei4M3dJtGeq1tk7URaQy7jI9tQc
 a7iBsyCy2ENWH5pcJtmlAq1+d2nV1N7bOzb1BDWq9O79SX4OLeH8d7cD6e99YgMrOOS6
 7sQ53VwNOXZvrJzFgTOSLuiV9hvY2XdtcIGrrsDtMGhultU6SeSrfiUXLq/ddyRHux8n
 0Bgmq+GkXYtfjI1xGQSOzqgrcYQx5QB3ynZ5Bje8o6JZ1vXCQtg/oRbrUth7okrVRNkJ
 xqe8xNDd+WhZjMeBXQCNe0+pzKPTg0U2akqOo95yEHaMGk/h/nycf8b+IqUN7XMREHof
 +tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795645531; x=1796250331;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2kzPKo/9bX3t4mDGI1xxNnDKhyKkNyEfJrqaFNBk7E8=;
 b=s3J/H2I+pSx5YGxDAuB68Q10HN8CnTLdar6QOTpPToRMyZD6MeKdr6gkYIieqlv6vw
 iWocnvrzwWO9EUnyKQJkjo2aZMn90DVfsBiVmw9PY+K/mHMZI3Df9SI2iFUUlxUe4eWc
 zjhy1xrTdAxDsBFXspEPr4vN59fyFlMaOo2UEGA+xT3OIphz2zNkJMXDc+eY1AC/aYFQ
 vxNXTExkdtStCG2mf1rQbUdzuN98tc+T9/Z9XNkbANV0xkELRrgqCzhQETRwiRlPAH0n
 GEpOxaOTNB86qgZYnKJRaBGcBtvq1JK2IOlpCq1mjy/6YqsOFk1NlEo6lWiTjF7R4sKU
 B6iQ==
X-Gm-Message-State: APuU4Z8vI71FKo+G7wcuFK1+1BNEsBvgkc8EAq5KS0vFvYGlGeifhl93
 iP3OLBIZTpkzxYXwb22bEBMbr7eSu/BtXoyyKl9cQQp50eeq1qA1AG6uzVRyTCWTkUi92d4RnVE
 6og==
X-Received: from dlfz25-n2.prod.google.com
 ([2002:a05:701a:8459:20b0:1b5:897d:6e5a])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:1585:b0:147:8a40:cdf3
 with SMTP id a92af1059eb24-1b5568f00a6mr18732225c88.24.1795645530462; Wed, 25
 Nov 2026 14:25:30 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:10 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-1-elkin@google.com>
Subject: [PATCH 0/3] drm/sitronix: st7920: fix SPI DMA buffer, unplug guard,
 and row address
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

Elkin Cruz (3):
  drm/sitronix: st7920: Use DMA-safe serialized TX buffer for SPI writes
  drm/sitronix: st7920: Check drm_dev_enter() in crtc atomic disable
  drm/sitronix: st7920: Pass u8 row address when setting GDRAM address

 drivers/gpu/drm/sitronix/st7920.c | 48 ++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

