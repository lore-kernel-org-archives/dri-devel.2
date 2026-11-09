Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249D606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ld9Fxt3K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A3010E34A;
	Mon,  9 Nov 2026 10:33:23 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF12A10E34A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:33:17 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36f6295304dso802949eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794220397; x=1794825197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QfIpduHoe8eeZDLf/6O89XnVTMfwvHnF7GrEmwVWOqo=;
 b=ld9Fxt3KjoA8qkVrZhYqCymdi0CG+SYBui7U/45pgdrJA8Ha5G6IRIigsPqBk2MPbB
 juXcgbl9LQHe69dBduVQVcaHFgjSTsB1BYNoSJQEVK45qq82RF5jIdF2rx346xvFeb/1
 c4kLis5A78vcg4Rc28CqYsTLXlwRdgkNmYYUUGoLIPMASkKrKXtR2NgklS6w1zgjESlK
 4ZKPcryTMnGPdiX4OnXq/ykMCXqiCTqSGj50bm/YNwPlgED7VlWkpfUvMwuL65BQGyZm
 U11hWfcHb3hRirHFUbRBbUW0nnKdGWc76UoKD5Crs/7h0/i4CxwTOyaPHWGrFM3mObse
 hzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794220397; x=1794825197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QfIpduHoe8eeZDLf/6O89XnVTMfwvHnF7GrEmwVWOqo=;
 b=dQ27W2937g80lcmdezX9khhT4VJNAaDi9DdEQr6N950hcVZmWQc1jEIFoxm2kx3cyC
 aofPRcbdElTplbxO3BOaW8ZYNY2gyUUkwlrEdeyOPpAVt12FRKSlvM4Rtp8CA33vNC3u
 oH1auf2kOnbrKdwTxekodyLcAYH2FWk06f9j3QGvToFZF5HLzljWdUZd3TQEH01Eqy9v
 7litBBHwyDwsSRwbFJkF+X6fKi9Eq7EM5SonOOzd1J0kt4A9SUS9JMZKXzgpGqI3phjD
 Q9+bz8CBJFz/GNhsiXP3pP05shDHOh3BwzT7kpxfgAiqfwc8m3FA3i4K2z/a8KD67skO
 esYQ==
X-Gm-Message-State: APuU4Z/90jMugRa2ghCmj1voh8lF9Sij1ELQTDoRama2w9j1la5cmv6G
 iNh0WoFIfHlK1MqnXtVNJNEfnc67eSbjcYMS5E8n4l48ztNELMiTPL0S
X-Gm-Gg: AYBFou388+SzGG1Ufr2A8ZoB6huEXTntuxDm2bu6yC3D21vjCTkJpWfJicAShOSt7LU
 7qw6cV1ECQksYnsOMrrA7Eas4hSyS/R0C0os68SpEDbbbrj3vFKMHwUuchUKeNfqzrfbPj/THg1
 2BnhgD4LcdY7A2gS9yClaVwx0cBkPLQmJNHkFKOUckXNJzbihJdFcAx0eac+ezkHIlbd95YIBZ1
 G4j+nQeDJ/FUx1mWgxySrVRgZezU1lPnityLwgAdNubkF0EwrWJ9U3S6/o9Yx2bk+6B++iEKRYv
 gXt3eqJgMAlWX4BB3hNWSqdE8ly2O3noB/t8Tryd2T9CdB91NBBQ1Td5ts44YcWFgmKq5kuHRgI
 cUdQRphTHI0LfeUS375afg1qEWWn+OTH1+INzMBxmPyqCsPVjlVhWqKnSA+d6GFn4PgKm3tEHYy
 PaCgq4YhNDgiXnvWRrsUGanqutPJeD/sIDSsX6eSkIxChjkmCP8lYgMxNiX4+jt8WZaPufnk025
 d7m388DS7x4VCNHY021gs/TzGY6gYWcvRSqCKXlhqwdenekEFB03I+H6/bvePcuLpSOBtjwj/cd
 mU7tw9jnUu5q8s3X7iFXKc1mFntpeXj2IQqRo1qhGgr71VAFwi3PgIry1oVHlWTX2FciOeeksNg
 Aqb+kCy521/w/m9/BghKvGg415waz
X-Received: by 2002:a05:7300:10a:b0:369:f70e:bd40 with SMTP id
 5a478bee46e88-37256bf1a40mr7451845eec.16.1794220396780; 
 Mon, 09 Nov 2026 02:33:16 -0800 (PST)
Received: from daeinki-virtual-machine.localdomain ([58.124.60.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372656187f8sm11267999eec.5.2026.11.09.02.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 02:33:16 -0800 (PST)
From: Inki Dae <inki.dae@samsung.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org
Subject: [GIT PULL] exynos-drm-fixes
Date: Mon,  9 Nov 2026 19:33:12 +0900
Message-Id: <20261109103312.7235-1-inki.dae@samsung.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave and Daniel,

   This pull request handles FIMD DP clock runtime resume failures and fixes
   a scaler runtime PM reference leak. It also fixes HDMI EDID and DPI panel
   node reference leaks.

   Please kindly let me know if there is any problem.

Thanks,
Inki Dae

The following changes since commit 19e67d977d3d4d0c54f03906ef578578190db9e1:

  Merge tag 'amd-drm-fixes-7.4-2026-11-05' of https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes (2026-11-06 10:43:59 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos tags/exynos-drm-fixes-for-v7.4-rc3

for you to fetch changes up to 869fdc8ba846ee6fec452cc34cf104f9f7142113:

  drm/exynos: dpi: fix panel node reference leak (2026-11-09 15:09:05 +0900)

----------------------------------------------------------------
Fixups
- Handle runtime resume failures before enabling the FIMD DP clock.
- Free the EDID when the HDMI connector update fails.
- Release the scaler runtime PM reference when reset fails.
- Release panel node references after lookup and on DPI parse errors.

----------------------------------------------------------------
Avi Weiss (1):
      drm/exynos: hdmi: free EDID on connector update failure

Jiale Yao (1):
      drm/exynos: fimd: handle runtime resume failure for DP clock

Wentao Liang (1):
      drm/exynos: dpi: fix panel node reference leak

Xiangwu Lai (1):
      drm/exynos: scaler: Fix runtime PM reference leak in scaler_commit

 drivers/gpu/drm/exynos/exynos_drm_dpi.c    |  7 ++++++-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c   | 10 ++++++++--
 drivers/gpu/drm/exynos/exynos_drm_scaler.c |  4 +++-
 drivers/gpu/drm/exynos/exynos_hdmi.c       |  4 +++-
 4 files changed, 20 insertions(+), 5 deletions(-)
