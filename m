Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD155C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 21:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB7810E3D4;
	Fri, 26 Jun 2026 21:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVVJy2+y";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED1C10E3D4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:16:16 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-920f33347f5so124256585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782508575; cv=none;
 d=google.com; s=arc-20260327;
 b=GK28wrdQavLCc9Wjt5rgUvCOklALfk5rXX45mm1UNwyXD60Uc1Bmm1D1iMTxQfL6fy
 eaPxGIYe90URHxtnVbsQV7oFza5vcfrS9hJeLST3zZCJab45rxN9anwrtRh10mtDE0wq
 ZhvBcsX2+Qrn20OxmSSBMJrD+kKE5rXyw+KR2ZNRNXLrqkLv1dgL3vkg1zIGyB198s4A
 RL+i9m6O1jrFH7lEzpl6bqf+fgnFbtw6J6XuZ8Hn6X20asV22G12L//yOgnCOaoUkA/K
 1FlqOqrW27mS2MGzrQAG+NrsepLUiiuN0tiS1snXzkSAV+mEvBfzEcsjELEKcdl0+m6d
 83ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0d/FgUQSoPtAQMkabDsaOJT5+z6/lQLAgbUTZaQby3M=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=YmN6rJBLrcg/LZua2PJmFkjuVQlwd6s1XbeEAQn51KAuoRNnxwJBsGNGuAmsJCWmYk
 RwdfKh1x3+TPdoVIJVJ14zXpltEPsIKQ7xg3n5zgwB5GXqnpEW1oL2EMwChM49diZj3t
 QbbXCrHFysPXCW13KxWlvLZ04YFNHfqdDl2BqFkc8vHGRHJcPVa9yuTLpAHgOHX/fHjo
 tO+odgieQ7pAcjH08vyGc28oW4Q2tO31DBFyJXW5f4im5FMl6S9OQgQTBPe+Zy9dNXsb
 PT/4oe6SGKdYurXoj+54bi4JfuqwOjTur6V8JcJuhXIfGMQTxUGa8s2mWhiz7Ut/0wKI
 xmcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782508575; x=1783113375; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0d/FgUQSoPtAQMkabDsaOJT5+z6/lQLAgbUTZaQby3M=;
 b=MVVJy2+yqpKwjbqBkGgQ0aSVeuCw24Gmaqud/+dcZMlu53TsaHw/p7qu492EA/teCk
 dRVACW5zH9Ele4oty3Z4bB24cmFS8WPj6/izgpane69x70lDq/DvcxyMxZdp61Qu8gMO
 F6PXHscWHKYVCRLI+WsD/WD4Pll3Tvzp0x1AWGQlmr3fzUYZJcv39Vc2tGALFFqFsVQu
 Mcw7gbR6dN5O3e3SYBRVSbRXa4dXF3xxDkWG2myOZu0M+P8msTtQO/uRvaYZIHcshBmD
 zifdGY+OJiGiMQG1ajnZJR21BGDaKOCGy0xfdVf/fpB0vRiGZR/3ngeevKxvoW9EmK1Q
 5jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782508575; x=1783113375;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0d/FgUQSoPtAQMkabDsaOJT5+z6/lQLAgbUTZaQby3M=;
 b=jLN1E7Q+4vkiY3/oLk6vrZRiMbPrHSLPwOseOcQQYeTylp112ByYE0qSbK/LiXPFvA
 N4l6Y+dI/4gOcHenyNHwBxBfIj+plZ961gJmlqdZf/mR1jWA3BvGoyAt6We/aBF+I8L6
 gwDCK5ef55062CuhM+o2EA9SyNmrg86cnjBxVOzcC38lEC9mxU7EB2OZmEBFW0PY6qki
 Y1jDlEIhGB+FFo+HLyurtXqGfDiRcrYXMd6MNbwhh4hpdWhBtA+aCAWjU6aQcrafIQ6O
 BVz2Z3fYz9J/e0xM0Ru8rITCOC9nwZWtxZF/cfblLiy2/i2tWpp0K0g8r1vPL5r0xF1f
 YYrg==
X-Gm-Message-State: AOJu0YzjIQNPQyDZd7WlkdOs/nWVC+zl5TvgISridcxin5NdMyVbTZ3n
 eDHfUlausZ0VyVdAeJUUh5IIrkW0WwXAk3al20NsAfB+DQIh23/PnCa77fw5TWNr20jUcRzfwZK
 TFS9a6rne2+w8eR0MvAlkM6huWGiOinU=
X-Gm-Gg: AfdE7clc7SRgKgQt+/OuZjXEYpqb9xjOWgNtHT36F9E3K5hcQTQwWwUj26/tV7fw/uo
 +6FD5gXVTWWnynByUOkGBh5pWfeukgyDHf19L4qn4ZhG80X9WjMNNhNafi66J9v3IwHNRRJ2HDO
 0+SzjJ4kZ6ECdWR+0tsk1gvuYZPSlRRJkbij/qPwXiHGxmNTkTgi6cY9Tx5neTwJigFOm/Yx9dB
 m/ITg3fG3/4xur6deMXyLNJIx/LWo4J6j/0A9+qUql0vqA6xupdd99Abokm7g2uY4MzvqpwxvTD
 y1gvJZgkDRn0SUso98QBC+FcHejhB8l8bJx2A8YuljnEIFpz4TdBnYy6hA==
X-Received: by 2002:a05:620a:270a:b0:915:8502:f7fe with SMTP id
 af79cd13be357-9293a8ac13dmr1323280185a.15.1782508575217; Fri, 26 Jun 2026
 14:16:15 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 27 Jun 2026 07:16:03 +1000
X-Gm-Features: AVVi8CfyRPotOJ_TxdrhwYWBX0JkirldS5xSmFRkhVWUUnD8tdZOHnPVkJ7VIp4
Message-ID: <CAPM=9tzvPeeEuOKpq+Lh1Zu19nx+-Fpz6-h8huqw=Tm8LN+uaA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Linus,

These are just the fixes from our fixes branch, all pretty small and scattered.

Regards,
Dave.

drm-fixes-2026-06-27:
drm fixes for 7.2-rc1

sysfb
- drm/sysfb truncation and alignment fixes.

edid:
- fix edid OOB read in tile parsing
- increase displayid topology id to correct size.

nouveau:
- fix error handling paths in nouveau

amdxdna:
- get_bo_info fix.

ivpu:
- fix leak when error handling in ivpu.
The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:

  Linux 7.1 (2026-06-14 15:58:38 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-27

for you to fetch changes up to f24ba334afafc70c3149e9db9c0cf8ecc6d52a09:

  Merge tag 'drm-misc-fixes-2026-06-25' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-06-26 08:16:41 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc1

sysfb
- drm/sysfb truncation and alignment fixes.

edid:
- fix edid OOB read in tile parsing
- increase displayid topology id to correct size.

nouveau:
- fix error handling paths in nouveau

amdxdna:
- get_bo_info fix.

ivpu:
- fix leak when error handling in ivpu.

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2026-06-25' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Jani Nikula (1):
      drm/displayid: fix Tiled Display Topology ID size

Junrui Luo (1):
      drm/nouveau: fix reversed error cleanup order in ucopy functions

Karol Wachowski (1):
      accel/ivpu: fix HWS command queue leak on registration failure

Shuvam Pandey (1):
      accel/amdxdna: Use caller client for debug BO sync

Thomas Zimmermann (4):
      drm/sysfb: Do not page-align visible size of the framebuffer
      drm/sysfb: Avoid possible truncation with calculating visible size
      drm/sysfb: Return errno code from drm_sysfb_get_visible_size()
      drm/sysfb: Avoid truncating maximum stride

Wentao Liang (1):
      drm/nouveau/acr: fix missing nvkm_done() in error path of
nvkm_acr_oneinit()

Xiang Mei (1):
      drm/edid: fix OOB read in drm_parse_tiled_block()

 drivers/accel/amdxdna/amdxdna_gem.c            |  3 ++-
 drivers/accel/ivpu/ivpu_job.c                  | 10 +++++-----
 drivers/gpu/drm/drm_connector.c                | 12 ++++++------
 drivers/gpu/drm/drm_displayid_internal.h       |  2 +-
 drivers/gpu/drm/drm_edid.c                     |  8 ++++++++
 drivers/gpu/drm/nouveau/nouveau_exec.c         |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c         |  4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c |  1 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h       |  2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c  | 13 ++++++++++---
 drivers/gpu/drm/sysfb/efidrm.c                 |  7 ++++---
 drivers/gpu/drm/sysfb/vesadrm.c                |  6 +++---
 include/drm/drm_connector.h                    |  6 +++---
 13 files changed, 48 insertions(+), 30 deletions(-)
