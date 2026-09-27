Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38257C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD7010E885;
	Mon, 28 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/hJno9/";
	dkim-atps=neutral
Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com
 [74.125.230.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16E310E42C
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 09:48:42 +0000 (UTC)
Received: by mail-lr2-f35.google.com with SMTP id
 38308e7fff4ca-3a64d20990fso19125271fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 02:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790502521; cv=none;
 d=google.com; s=arc-20260327;
 b=CNdCxMmU2L2h5aadJrDxdbulxZtgAMKeDg9/48T35vYI9F+38CK1f89SBBP3aijCSA
 bXmZVlNufdtTpX+N9GdehrdqKRYXcOdAa3HPE6F3DCPiryrixxmRNAKLTatWBYKG8rZ0
 xzSrqj43NMn9LXwqiJAuxI9ZM/sLdCA6oxlpUy5i3NLrRhmW0Q/OrEg5CQ8PYyezFaJM
 p2TL50c/Dkhb43ivO9tugnUAh0gaglfz9iRRCksGq9EZo3Y+/AJqbRgUFH/P1/JVBtbH
 JGpOLSObjdc+2Wa+7xM5qnDEKQZp+gtt7GsSd5sfxk8qSm+pLPZL3/gGF3hb7AnzlknD
 w2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
 fh=SB8H25/QE/FFg1nYZcdnjvvbzFveLVI+jAgret0ighU=;
 b=inPJ+FpSFKGs+iOIDxRihDxgG3KapptnaWLUy50ddLbwXj+ylRaEGhdevs7jL1WT8B
 hzkpOp0eDaVdgUgCchjBjKFIVw8n6B1fA1QXqQZ8YPW+EIRyX6XqfBkohpYAN0b62oZT
 Bi1yVx7Ap+1yBVysWMUemN5LpFaKbzjI+5PWBM/Y+h6/r+nD2Pl2oNeEJ2K1dTJfkrUw
 opMLNmhYBk233HDgDMSmDL59Lw1mxNcFZc4+XRnVbU8g3fZNiopmp8UVT1JLZ6U+vemz
 FZScO2PsLK+2J92zZxm15C0kCk3GDQueV0dvYgwMbe2Zu/wvxQFdSR8kRLVmnF1CZWaI
 J/ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790502521; x=1791107321; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
 b=O/hJno9/uM9FsWzwb9azA3yQJ3eSDMfG42MfsQ8MGBEJlQWfAkp/XqETUqcm6yhGY3
 1JvjzrREoJnUqCmAG6u9nExncRxdT1gAarm0rG5MTkGpPQCjZtDwfeBjyARhNqr/caTy
 5H+KWErnS03Ko3PtSsoOYOJh2DrV+k8GVyOIGL+6ZChsWNCDdxypfggCH4wzKErcJ9JM
 3ZZSbkX8aBBu+hkZeBt3ZFPdhQwyupfMkh/DalPAgAzVw6IwdLo2aGwK7J24DDH1cjCr
 WBfJ2paycwQ/EFBErDKk98iv1NNBXJP07NHhkpea0gc49ETh+ju/72Y4dkXXRHYJrXlX
 pjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790502521; x=1791107321;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
 b=sjlOioGo32u1PluMROiy6FIZx9bC0JiiqrhZvAZyatMi82E5BXSN9MhUjDPxoD/UVx
 KFpmuDlsNgkjuiQy1/Gbl5OPAzR2u+nHndVyuuCreMUUcu5WbRq8ikKnoBVVKgraMwRS
 9HBoXZ678Z2iB8G3lg9z2UgL+n5U5e6WpXmi8hNX+WTZCJZlLNie0sJxvwdrItRXkDdz
 3VR+1RtSbx6WMXrnrpI8jcNJ9ZIWOV50HZTxDfUM5t4d3xOOs50cE/JSMeEvGiye1KcD
 ILPGZRAljBWP+nNxfh3PaZ0rwRIDMctiNJoxVFlK0gwmPuiX0HyTuNKQqGNRhoExvgKo
 OLmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCV0Kkx7CvRnzvdh57B3ex+86tNSklV28NMcVAaS6gNKsvjPmFudeN+89e99DS9IqBVFDr2QIoLG4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIkdPDd0DwKTFF8ZvbAkzj2HzUeMvRHWf0NNtYDgsPF3n2jH5aF
 shMd2UiRvyR4SMbZLqFL4O2m7KHGl/PysZ2pN1JhVbgIz8Z4qeE6nGV3BZekQXgXNTfFGSVrk3e
 8CY8r9RFGSgVlTFunA/v8O+rHWwqC6r4=
X-Gm-Gg: AYBFou0X/tn8tdFW+xzutjRCfsGv4MpQSmHMs18UHVSvmoGJE8niyH79ezzILtd+Soa
 VObQxayyFoGmHL1rDkOTjHa8+LBIO8cGcnjjTRwo9011zfjOyvuYQiCU/d8vHsUBbMqKFigqdqB
 JSi0YlBUbhBc1AhXmL9WWPyzOzHNoz8ybHP/tWa6d2Q1ApMaNxoQ6aF/58eyrOht/M3sr0B6G1d
 3bftYxLO9pqvdAvnnXpApPt3VAKCNhmUlzgQEGTBKUVx1C0NLrgi/P6qi4CH9MT9nJZ7jidND5O
 +ev0neV5XOtIYL4VddKrg5hmfz+428ke21tk8qlKVoww9QHEZEQiY2yzjHO6edOcccuuob/QDKs
 5VvJHLyndo0Vl/iqftGhrQ9yxVz+HaGYSPiSs+94g8h3//XlbNavsqYnWlbV42x3DXo/FAlfw51
 kf
X-Received: by 2002:a2e:a812:0:b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a63de5c715mr24136561fa.21.1790502520622; Sun, 27 Sep 2026
 02:48:40 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 27 Sep 2026 02:48:40 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 27 Sep 2026 02:48:40 -0700
MIME-Version: 1.0
From: krishnanand G <krishnanandgeetheswaran@gmail.com>
Date: Sun, 27 Sep 2026 02:48:40 -0700
X-Gm-Features: AclHuK8BTBfNpqz3m6BQ2iIMJxIt6xRy_BCLLwu5RAkXd_Z2NtIUajK6RkAMxFU
Message-ID: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>
Subject: [PATCH] staging: fbtft: fix spacing in macro calls
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

From 5473fd52eeda7ab1f608c414e386dad0ea40bef4 Mon Sep 17 00:00:00 2001
From: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
Date: Sat, 26 Sep 2026 19:41:06 +0530
Subject: [PATCH] staging: fbtft: fix spacing in macro calls

The two calls to define_fbtft_write_reg() that use the default
modifier have a space before the closing parenthesis. This triggers
two checkpatch.pl errors.

Add an inline comment for the intentionally empty modifier argument.
It satisfies the spacing check without changing the macro expansion.

Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
  drivers/staging/fbtft/fbtft-bus.c
Signed-off-by: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
Assisted-by: LLM
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c
b/drivers/staging/fbtft/fbtft-bus.c
index 30e436f..5f320de 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);

-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, /* no modifier */)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, /* no modifier */)

 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.39.0.windows.2
