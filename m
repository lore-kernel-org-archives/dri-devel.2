Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5EDCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F053D11266A;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5C0112619
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:30:50 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-35adc681e1aso2934082eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792135850; x=1792740650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=62P/spIL5ufVeOJfaaQ7/HUKNwliOVhhQKYr2DiCnw4=;
 b=UMAV9ef+gx+OziCCDRuy3CoA7ucDGLvs2lucIrbllUVGD3jlnOHW8AalVC8pifApW2
 68QjpPLQUgOHviLbNwJHZxkFODFbIf79WHAbZuPU3HLPNXGcONRQOMPQJ4Uj09vKH2GK
 ZQgobH47JC/y43r6PChbD/fJ/NsVHprk2hp9DgtZZoQwXJee6tvDR2AurE3QjL+UKTiI
 He9+EgN45fT5QoDNCKh2n+sxkOsBFF296Nw8x4fgXveQIvq79C7vle0EelKAwzhwCsJD
 ReCdD6hQS2FRfYZYpxC2Q+b5MRfWB8dYB02QH/xuEvnuT3c3glMYiGT69CnM74jp/7tl
 SK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135850; x=1792740650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62P/spIL5ufVeOJfaaQ7/HUKNwliOVhhQKYr2DiCnw4=;
 b=PjXsoq/cEMbsZPehkVpSDtSNT5htPZAZDJuwhTNajbnJM0oDqGFb4uGp4Ee8DO3W4l
 4ZDNy9HZ379ztAYfHjCJ+jHGP1T9dWBp7fi1PwXi2my7s1yuRRsuTl5PiMXaAL55SP9H
 XTq7Poc87zwzzAn+OK3q3tuui5PM+0WigAaS2zKs7d2+cuAIgsUwxoyBjSp6R3Av8zkX
 9B/5YIYCx0ope2nZN3Are7LWwDJfPRzugskAw21AVSm1DzOaGwNcfqXiKJOF0G+YjFsd
 zmyzLuYrkePoJdVXPeHwt7RHk4qKd5ZNH/7s+3WGVcBX6ftDklj/S2w85yaXRgUqSin7
 RB7w==
X-Gm-Message-State: AFq9FYIyKmStnodCcfW79mb2d06r/kyjJfBUdZo0gRKGyWrY431qA/s2
 WXw2jpLFJHOrttUSDitYT7AMhy3NGqHg0xJBWGDkSK5E6PMvtSO77sem
X-Gm-Gg: AYBFou1CoZF4NvhbfmjfsNCDJcwGi3s7+GKUi7bv7NAAE2SSOrbx0qhESo3UZ8ZDWXq
 d9ycJiD82U6DupyiofnYT0E4tAy3pfCjwxjuk/3HursQfU/Utw4ZbZWaDsgQN4fWuFo8aJyUyXy
 Dw32IFId78vCLOlGXyM+mNqAt7LBHXSUpNuCZSH+bkH86OQ5ttkFohCOQA4ujvMnSGKbg+ekAQF
 Oxn1Md1qtnbic5QFAP2pcVhpxfzklb76Rd01QzDR7wwdSUXvjiHeROGc4lucmxrFzxj3YfZORPu
 7Lks/gHq7aacXlFBPeWFUV3PQHH/6HGT5cD4NKQHMElbP/Fh3pJiy4SzNWYSzcedvh5+s2L42kB
 BPjE6Twx2rbP1lhjhg9N8HcKV2AjAdvmPnr3F9Dvqibk35nSZZDN1QTaEqlE/yNUpdutSE9ZIyJ
 /t6Q604sNZrYcfF49mVoDNirFwagNMPMGf9v88L03Qb5cqTjpT4DSF/7rf+q/AZ1GPiGG4EsdFz
 mez7PaHS3vivHZIewoKGBjonlRkdYWN7TI=
X-Received: by 2002:a05:701b:21d3:10b0:143:296a:3ee with SMTP id
 a92af1059eb24-16a5ef28797mr29299595c88.25.1792135849519; 
 Fri, 16 Oct 2026 00:30:49 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com.
 [104.194.64.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 00:30:47 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com,
 Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v3 0/3] fbcon: fix rotated font buffer handling on font
Date: Fri, 16 Oct 2026 15:30:20 +0800
Message-ID: <20261016073023.490430-1-yyaqia@gmail.com>
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
fails, the font state is rolled back, and the rendering state has to
be selected and the rotated cache rebuilt for the restored font as
well. The rebuild itself cannot be undone, because font_data_rotate()
has already reused or freed the old buffer.

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

Changes since v2:

- patch 2: also select the blitting type again in the error path of
  fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
  uploads the font map to the text engine; without the second call, a
  failed vc_resize() left the engine with the rejected font (found by
  the Sashiko review)

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

 drivers/video/fbdev/core/fbcon.c        | 23 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        |  9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 10 +++++++++-
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.56.0

