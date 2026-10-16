Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB22CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE0711264A;
	Fri, 16 Oct 2026 07:35:41 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90A610E2E4
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:45:43 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-35de2661992so1537079eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792122343; x=1792727143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L9utFG+7l3jNDaHXc+0ut/Bf6ZmDHhf+7z5lxoYvvn4=;
 b=XiQGK1u8SFFC8w/zRrxDlkoHlULD/Fr+ujkxXtG2wJsEZOF6fmKVsxB6Kbuc8wFGqb
 w9G/FoLeH09Rmvph66CgEUj9IbPqIzDfUgcI0OjlB6iCt01Ur7eYZXaqTbsTzxpNYiJ1
 0PfgfTaJRM/LChstx/KNAyfHH3I+f5q2f07cGHa07aEKJE9KPWT/kKA8Z1wYhXSRyR9E
 RM0groEHMMA3kBMTLGQQ/Izg2gn0927znMU4ApzyPFn5UFnxhUqO65LFbJuZP5GAJmdQ
 Q+MlAPv5dQmsVuQUVwbuiKBikepeP9Vt6wYjFOkWo2NskhM89Vwj8kx6iUFrU9lDdNDc
 AK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792122343; x=1792727143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L9utFG+7l3jNDaHXc+0ut/Bf6ZmDHhf+7z5lxoYvvn4=;
 b=rCAET4MbgfObz0ba9/y0RIkdFrPDA8AYyPN7CdWEWsyFRsEKJ+paHJS5pcSz1zPbwh
 7lbb7L3Xl7+QdqSgMri9v8qESBkT0BggW/F/2MFh+Yo1Qu8typAIKujXBzbiOnVkHKAo
 ufyqFyw19HbxtkPXkkG4YRinO7o2jltxGfy+u6dw1WoiqqRnVVfOEJGyAeth5NRN7OQJ
 v9gJ0MhQGnntVDdLN4MKOQcy7NXxOu0MHTK0CDl9YmWl2ihBRaYz8va/iaxecvFl6zRp
 jtACsRVt7au5BtIJnRy6NO5Gjh+kLkIgB292QgRgC/iQoWXrf+SMz6SB83T90DgaJJow
 S0rg==
X-Gm-Message-State: AFq9FYJpPAjtTRSMtVzmgouGinzEiUhqxsAL8jiBbw/o02mxpSIrFgzt
 fz1t3l95AuSL0Coa0VuZ2jTU91H8vs7KfogBqcf0E1el4n2tulHfb5j1
X-Gm-Gg: AYBFou0QNPyxJPwAhBz6lAkFPboYXn2Oe2pRwDvHDbWd5X9iSVuUuohCjVP1lIxgR/a
 zeVvhkTfwEfaA+vEF+yHGqjJP90pmqR2zOnTylltQjV2Bn8c3cClz3s+uTS9zd2a5ipyAAQ8rxI
 +d8xG9NK6lx88xbd/ZtfVJ1uyfwbgxi2bqCwIP4H0DmhgWcCzjLfiiBp/Wk4Y456vRsmViSMdym
 YFMxmloLmge/4eU5IZ8AaIS4RO/RNXD/AaPWIXOxLifnIMzeJ+k0nMWAgWGJC3KRW3OvLM97xVk
 vvN58pQEuE7QEek9qCkhLevWrYMkuG+i1yZ994UL0KLDsQGQsLVZewFUepHde02Sks3vs0JFBJ8
 ZJva5k8B6wB7B5PVSbWSEzRmh1RS40JpmMmmAC/uDoVy4J+/CxCz2ax5qYDm1pDL7Uk8lOBLGHb
 s7U6DH8LkoTOwWPlxVIHfGR5E/dmKSL+zyV2QiayYUtR10tNkNW67vfOHPGd+40CQ18EPW9Iz01
 Jab5hRN0nMRo5TbdGcFaKUrlw63megceO6aBmY=
X-Received: by 2002:a05:7300:1ca3:b0:351:7416:5f28 with SMTP id
 5a478bee46e88-3537e016fe8mr30314288eec.27.1792122341773; 
 Thu, 15 Oct 2026 20:45:41 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:45:41 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v2 0/3] fbcon: fix rotated font buffer handling on font change
Date: Fri, 16 Oct 2026 11:45:30 +0800
Message-ID: <20261016034533.445862-1-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

From: Yao Yiqi <yyaqia@gmail.com>

Sorry for the late update. I was overwhelmed by the AI reviews. This is
not the driver that I am very familiar with, so it spends me a *lot* of
time.

This series fixes out-of-bounds reads of the rotated font buffer on
consoles that use fbcon's software rotation (fbcon=rotate:N).

Changing the console font through KDFONTOP installs the new font
geometry and then calls vc_resize(), whose redraw indexes
par->rotated.buf with the new cell size while the buffer is still
sized and laid out for the old font. KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Patch 2 adds the missing rebuild for the font-change path, and
compensates in the error path of fbcon_do_set_font(): if vc_resize()
fails, the font state is rolled back, and the rotated cache has to be
rebuilt for the restored font as well. The rebuild itself cannot be
undone, because font_data_rotate() has already reused or freed the
old buffer.

The cache key in fbcon_rotate_font() compared only the fontdata
pointer and the rotation. Raw font data does not store geometry, and
fbcon_set_font() deduplicates uploads by byte equality, so re-uploading
the same bytes with different dimensions keeps the pointer unchanged
while the geometry changes; the early-out then skips the rebuild and
the stale buffer is overrun during the resize redraw. Patch 1 adds the
font geometry to the cache key. Patch 3 makes a failed buffer
allocation retried on the next call, instead of blanking the console
until a font or rotation with a different key is installed.

The unrotated-rendering fallback that fbcon_init(), fbcon_switch() and
fbcon_modechanged() attempt when rotate_font() fails is ineffective:
set_blitting_type() immediately re-derives par->rotate from
par->p->con_rotate and reinstalls the rotated bitops. This is a
pre-existing issue that is independent of the font-change path, so it
is deliberately not addressed here and will be sent separately.

Changes since v1 [1]:

- new patch 1 ("Include font geometry in the rotated font cache") in
  response to the review, which noted that the early-out relies on the
  fontdata pointer alone
- patch 2 (was patch 1): also rebuild in the error path of
  fbcon_do_set_font(), so a failed vc_resize() no longer leaves the
  cache describing the rejected font while the console renders with
  the restored one; and select the console's blitting state with
  set_blitting_type() before rebuilding, like the other rotate_font()
  callers, instead of writing par->p directly
- patch 3 (was patch 2): unchanged in essence; the retry now covers
  the geometry-aware key of patch 1

[1] https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 19 +++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        |  9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 10 +++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.56.0

