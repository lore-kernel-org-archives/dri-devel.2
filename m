Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F74AFB44A6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECFC10E115;
	Fri, 24 Apr 2026 06:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ng83SDId";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F99010E115
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:11:35 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8a154cc6a48so82869886d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 23:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777011095; cv=none;
 d=google.com; s=arc-20240605;
 b=eo2KnA6xbGRR4o7MtwRZvpuj3Ai6dvtGCeR93b10R2JSLSlzwSin+SkVSh8xWTWle3
 K5IHYnVdeRKVOppPhoxaY8XkUy+2yt4AfxEiMgRrgjDApHwqYeA9bMBvWoHx657g+jX1
 AwRORsBwrTmN3JSTLrpzo1dqLoQlLMoGSGKVf1G7F89FGFM1ZXu9uEX1X5dUkzpghMCA
 3FI0/f/egpUB4olii67ZHnme7u0OWQdd+MySC7g9+IJsdUA9oKgFxaCLUopU+o2ofJN/
 rQBNMNSBVO1xwXKhrhEuIpeIYOvdjNYJrHaNiIGLya1hmAKoHiYi6woMP++4MEWPXW2g
 ISzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=lAQExAUPok89iPyzwC82TShnwD4EyWoGMdq+koOs3tY=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=V9OrTsVQJBreCdqnbi9+LsxAokRte6bhdUOpMJRckClN4VmP4B8Lfk+5K1hz9wgFSL
 I4g1g88z7XmiOJBeC5jMdFM6dajwnZ+BHbZVyXr6gFUePRuUtLV56v9/fAyBxJ6WBaNc
 p+WQmiSo8PhzKz1TU35FOJ/ps/GATrg3ShklY4BGLTzDxmLeRoD27vyq8I0nMOzy/tim
 4/qw8sYGEMHQMxs5Kiy3+c6z7z5Ppt3pdv6f/yEnAmlAEmWCrIMaL9DO62bGCC4p9L4b
 M876mhhcDC+moPNkOxsfMrJYqwlqNNFxqECVAi4uL35UzWOchvVzY7uHBDlQe9LbKPAu
 MVtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777011095; x=1777615895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lAQExAUPok89iPyzwC82TShnwD4EyWoGMdq+koOs3tY=;
 b=ng83SDIdRbn9LbzyWYPNCT3wh2vjkyNbaZYaT3/zUAuXGToItw0Nq84H+9nTw675y8
 W434IBRS4hAgdD9JhnxChSQyeQPgnaVnK37y+KRgasXj/su47ScMc+a5aoZj4f9Uu+VD
 MQacUmM7lCVMqYCFmGHuNnxNyEvO0nXIoaGAClKZCPhuWhIRBfl9wdd0b/8qAqEW/PuO
 bIglS4Sk+WCw6Xold163b2YAD8MzcNIjttkbH9VHXlQywzyGFWlarMArlZRNS/qoOcB7
 MFiQSTkylQbgg9n4pmVoP/WZ1erW8sWCxqeIdPNawSMpsVtH3s3FEJ4zYQKzvufWUco2
 Ps7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777011095; x=1777615895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAQExAUPok89iPyzwC82TShnwD4EyWoGMdq+koOs3tY=;
 b=nxLnmqq6kazki43c5MaXpJlHAIbDkEXyTn4OPoTUq0ZaB+2tP2m7S3NFsucOMAViVB
 m9vmUfoJi9w0qwvxAL91PX3BSpug/Ru0k12nZUvUvOrno0TT8Q1ymIy7m2G/iVAOAwG6
 hTxg5KovZdGDIEl/5avTnSG5r51+6WcMb4JCV8rv9NKp2DMoIIype4Y+EYHoSzt9FtAu
 bXijCl3LlObcJsgZuJ0eFOsBS+IRVhx9+HIGUsj1PYOphKS3SpfY5zjh6YIgMhtAZU7m
 NAIyOkUooqR8OX8PDx5pp+AOpIhckbd5LQk+87kPHRiLXRqzlDwzjjDI7rLulrMANPBz
 hwfA==
X-Gm-Message-State: AOJu0YzwqoFiYf3PWFc8wp+8NHvdjJJV78UHXs6pVi76P607bLAkVxxb
 fHpK7hAxxnT07NUiFhnCgO+ecmWGRxFHcpzl/d8OfyTHKYdWuOXaSsHDBBQipNvZmST3Og4wr+q
 bZs/UX3fBsnBM733MzrrJfyUJxsE/DA4=
X-Gm-Gg: AeBDiev2g43cy7kEyoegIu9ygY5WbzmbcJ2RiCKt78bb/9q1hbABwIbHgaQa6Vw06Gl
 XnQkxTZ5QPxhaa2jKL8kI8FYDfPENOCf/s/xXPE0NlSU5ewJUvGerE1w5tbqTl2yPi9Y7cK+79x
 +p7B46oZUm0LObZ4oci3IfoS3hgkx5kXV3Yxzdnv47LXYlDKzE6/tu7VOEqFN+3FELXO60zDENE
 cHyfMlCfEbFx2knGjSJNZPuZco6VCO8HYy6hrgJPx/kKAVPxIP1FE1NgnvMqTmWRQA8TaHUbfqI
 eDjPWKvwsatt9Eiwxl/Hv6GemVlHIYzBTb0GMDaJWEyPMkr31Ffl6filGXuPFlPlP4rGzqueSSu
 JLQ==
X-Received: by 2002:a05:6214:21ca:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-8b0280fa95dmr496920306d6.34.1777011094648; Thu, 23 Apr 2026
 23:11:34 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 24 Apr 2026 16:11:23 +1000
X-Gm-Features: AQROBzAg5zCiTi9nyMcDWd_PYKg_IqjHOqpJI4R5g__Y8c0Oec09TcKHhdOZkag
Message-ID: <CAPM=9twXGyOZMh2k20wFnVXH5tpbX8DRhNRv6rMBw1oMyPoQ_g@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

These are the regular fixes that have built up over last couple of
weeks, all pretty minor and spread all over.

Dave.

drm-fixes-2026-04-24:
drm fixes for 7.1-rc1

atomic:
- raise the vblank timeout to avoid it on virtual drivers
- fix colorop duplication

bridge:
- stm_lvds: state check fix
- dw-mipi-dsi: bridge reference leak fix

panel:
- visionx-rm69299: init fix

dma-fence:
- fix sparse warning

dma-buf:
- UAF fix

panthor:
- mapping fix

arcgpu:
- device_node reference leak fix

nouveau:
- memory leak in error path fix
- overflow in reloc path for old hw fix

hv:
- Kconfig fix

v3d:
- infinite loop fix
The following changes since commit 028ef9c96e96197026887c0f092424679298aae8=
:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-24

for you to fetch changes up to 56d0a0b38faa13836568d425f6ea806e27f3a69e:

  Merge tag 'drm-misc-fixes-2026-04-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-04-24 13:56:54 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc1

atomic:
- raise the vblank timeout to avoid it on virtual drivers
- fix colorop duplication

bridge:
- stm_lvds: state check fix
- dw-mipi-dsi: bridge reference leak fix

panel:
- visionx-rm69299: init fix

dma-fence:
- fix sparse warning

dma-buf:
- UAF fix

panthor:
- mapping fix

arcgpu:
- device_node reference leak fix

nouveau:
- memory leak in error path fix
- overflow in reloc path for old hw fix

hv:
- Kconfig fix

v3d:
- infinite loop fix

----------------------------------------------------------------
Adri=C3=A1n Larumbe (2):
      drm/panthor: Extend VM locked region for remap case to be a superset
      drm/panthor: Fix outdated function documentation

Andi Shyti (1):
      dma-buf: fix UAF in dma_buf_put() tracepoint

Ashutosh Desai (1):
      drm/v3d: Reject empty multisync extension to prevent infinite loop

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2026-04-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Carlier (1):
      drm/nouveau: fix nvkm_device leak on aperture removal failure

Greg Kroah-Hartman (1):
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check

Guido G=C3=BCnther (1):
      drm/panel: visionox-rm69299: Make use of prepare_prev_first

Luca Ceresoli (1):
      drm/arcpgu: fix device node leak

Marek Vasut (1):
      drm/bridge: stm_lvds: Do not fail atomic_check on disabled connector

Melissa Wen (1):
      drm/drm_atomic: duplicate colorop states if plane color pipeline in u=
se

Osama Abdelkader (1):
      drm/bridge: dw-mipi-dsi: Fix bridge leak when host attach fails

Thomas Zimmermann (2):
      drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
      hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS

Tvrtko Ursulin (1):
      dma-fence: Silence sparse warning in dma_fence_describe

Yongbang Shi (1):
      MAINTAINERS: split hisilicon maintenance and add Yongbang Shi
for hibmc-drm matainers

 MAINTAINERS                                    | 13 ++++++++++---
 drivers/dma-buf/dma-buf.c                      |  3 +--
 drivers/dma-buf/dma-fence.c                    |  4 ++--
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c  |  6 +++++-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c |  6 +++++-
 drivers/gpu/drm/drm_atomic_helper.c            | 14 +++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_drm.c          |  2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c          |  2 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c |  2 ++
 drivers/gpu/drm/panthor/panthor_gem.c          |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c          | 19 +++++++++++++++++++
 drivers/gpu/drm/stm/lvds.c                     |  6 +++---
 drivers/gpu/drm/tiny/arcpgu.c                  |  3 ++-
 drivers/gpu/drm/v3d/v3d_submit.c               |  5 +++++
 drivers/hv/Kconfig                             |  2 +-
 include/drm/drm_atomic.h                       |  3 ++-
 16 files changed, 73 insertions(+), 19 deletions(-)
