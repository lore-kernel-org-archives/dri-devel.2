Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68B606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E8d75sZ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5411611200B;
	Wed, 25 Nov 2026 23:26:48 +0000 (UTC)
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45670112009
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:26:42 +0000 (UTC)
Received: by mail-oo2-f7.google.com with SMTP id
 006d021491bc7-71abadc4460so1963109eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795649201; x=1796254001; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z0QB7Z5jkpv7pdrIgKYxDo+vWMbTwUMEbHjEmTz2knQ=;
 b=E8d75sZ0k8D2lXQKq9y7SVHZSrNENEGNPvDkEiWISRasxb0JI5QtMVFE2cMTHQf3bL
 BLis4at2Zw2k/OpQu1oIKTP0HoRjL20RC0s4Gw0/m12nGwj51ocKDXNNY3SZCk7DfSQS
 R8WKuuTCpJdWb27h6XpXnGjKLRWJfAGXAKE2btfYlNqYwFcuutlYsq3NBpggolVTrV30
 XOk7APW+KGwc+KmqelZHmH9Zg/VvUGG+DMoGwAOE+ZK3A4g5m7F18ujgL297u+a+IYGa
 J3PbA4Y1g0PHGuPMJ2QoEVG+87wUGiJkn+EYVwpQSHbaTeOa6FdreQzkaCNiq+bnFuFz
 mF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795649201; x=1796254001;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z0QB7Z5jkpv7pdrIgKYxDo+vWMbTwUMEbHjEmTz2knQ=;
 b=RcvRFVRRHkKSvXwR32NJKbWgbR7KdVfxatAKQ0Oy+ZMukfCAb0uo2uH3IM3nJaOvtu
 rASiJHtLhGklKIadtghh6h3L3C5iEXlhxWWZ8d175WG7T1v+c0rrQtB2a8xckjifhI7h
 p+xSltNT2zWsKnt/SYUjxiFNRIt/6b0+9t6wJphlP2qbk5hwUcHjQT79tH4zx9e0NTy/
 cRQDISFZfGe6sJtW+WjVsD4u+i0FnGIzQrb2vr57jEcaXuvlwNvEy8/EjRj9JZOITnF9
 mNDjqjQbCpxKDF+vzQZ2l3V+pZAYquJ6A+dcu6BrcFqz7sA2mOdUevrF4T7E4rZoL42F
 PUZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFg7FbdoMnCFMxuMoqccaeV5vIglj5rdEUsYAm/y8liccLPYvGxcQi0Ny+npRBzfw+KH1PI6QAgnbU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Bzf3s4VDUE0upKSSEu6r97wAwE1fTska5ryibrWNllL587GT2
 D5r+3IWOsj+RVClAXGL5boHCFDhOW2Vv8OZcz/yNvPOau1Ib6LteC8JF
X-Gm-Gg: AZFdTZeUzDioMhKqfbMaIy/o4Mhu8buynSbCLCKEChPtDHqLDRDEFZVqpeRBOvko3oM
 N/s9Lezdwa0Tka4/DJ4zKl5oBGHWiopvPQZHHaMnhfKJvlkooTDOjpkXECmiKyAIrYBGvf+NdI/
 eZOUulCaknuMxtoCSM19CZzz4U/QsXr0nyvivNzm3WnBK821eNfHmjQafbnnosOIVPTd0Q20AyX
 TfvSx4fVrP96gvWFo2drbI53AAc5qKtlALNN/nCyzIl7P+vdXviiuTFdUbiysB4S4UoQk1CGbKt
 I0Godx5zFc2TeSmUwAoyIxY6Cxvbse3UPWh58A4WLQt8Gnih1mKzyYByAF1Rtv642z59pGGioJp
 ORKPyPSub88SjZ+2uU4IQsfmHYV69bCOJ2l1aKMe2vEdtA8bR7G2nLVefDDQ5RIaytZJFPdAPSR
 Kyic3ZGLU5NK5PBm/REULe0gNV1dxvjo1COMJtNJ7O/A4P2xxuqZPqgWi5Mx+zJLxAbxjMQRNhB
 apGxm1mrBQewCvQPnYrBEpD+89I1Z2vJGtlVGKFbLGENMMIBNyaUqRZY+0INBbC9aQll9seKUbl
 T6cjeVucnCckN8IFefFxm05+BbDSR2b+bmhdNDUHDQq3k3OzuVOr3kCP
X-Received: by 2002:a05:6820:4a19:b0:71a:ea6a:4f64 with SMTP id
 006d021491bc7-71b394eff5cmr13989163eaf.50.1795649201237; 
 Wed, 25 Nov 2026 15:26:41 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631692f049sm14304892a34.25.2026.11.25.15.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 15:26:39 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH 0/2] drm/imagination: Hard reset fixes for META firmware cores
Date: Wed, 25 Nov 2026 17:26:05 -0600
Message-Id: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQrCQAwF0KuErBtwCtYwVxEXnfFXs2lLYge19
 O6C7wBv54AbgjPt7GgWtsycKXXE9TnOD4jdORP3p35IKal48Q0SG76yNhdH4CWOujT4R8o46KW
 qlknP3BGvjsne//96O44foHpfG28AAAA=
X-Change-ID: 20261118-rbrue-suez-pvr-reset-recovery-ba687c88bf85
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649198; l=2234;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=lkEeogA18QR5ZUQab4hqwxSvIcO221SDwijc6qoyQnk=;
 b=JDtsFvDvlwWCk6Tsxcp50PSYzaNzHOuoyL9IpilsW3rOapT46GqCpUu7ptjf4eUxNexFo9Pa6
 Kykh/ogXyvTA6WrZar1k+v6Lmlnj5ckxeMJwqEdaCaBericGI8U/cBp
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two fixes found while chasing GPU freezes on an MT8173 tablet (GX6250,
BVNC 4.40.2.51, META firmware processor).

The firmware reports page faults of its own with FWCCB command 112,
which the driver logs as unknown and drops; patch 1 logs the address.

Patch 2: every hard reset on this core ended with "GPU device lost".
pvr_fw_stop() waits for the Garten wrapper to go idle, and a META that
was not asked to idle first keeps it busy; all the other idle polls
pass. Skipping that one wait on a hard reset, as the driver already does
when a debugger has halted META, lets the soft reset that follows stop
the core. Other firmware processors, and the other polls, are
unchanged.

On the board, with lockdep and a local debug hook that forces a hard
reset from the watchdog under glmark2, every hard reset recovered
without losing the device: 13 forced and 8 that the watchdog started on
its own, on this series over drm-misc-next. New GPU work ran correctly
afterwards. Contexts that had jobs in flight at the reset are flagged
guilty as before, and the clients using them (here KWin, through zink)
stop rendering.

I do not have Imagination's documentation for the META stop sequence. If
halting the META threads through the slave port first is the right
shape, I am happy to test that instead.

This series was developed with the help of an LLM.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Ryan Brue (2):
      drm/imagination: Report firmware page faults
      drm/imagination: Don't wait for a running META to idle on a hard reset

 drivers/gpu/drm/imagination/pvr_ccb.c          |  5 +++++
 drivers/gpu/drm/imagination/pvr_fw.c           |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.h           |  3 ++-
 drivers/gpu/drm/imagination/pvr_fw_meta.c      |  6 ++++--
 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 10 ++++++----
 drivers/gpu/drm/imagination/pvr_fw_startstop.h |  4 +++-
 drivers/gpu/drm/imagination/pvr_power.c        |  4 ++--
 7 files changed, 23 insertions(+), 11 deletions(-)
---
base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804
change-id: 20261118-rbrue-suez-pvr-reset-recovery-ba687c88bf85

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

