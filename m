Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A746CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4D010F1F1;
	Thu,  2 Jul 2026 07:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBD2vekB";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EF810E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:43:00 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39b349ae174so8654061fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782949379; x=1783554179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
 b=WBD2vekBa9Wyn0xma+o/XgGzNubF+Ah81j6WnrEGj2qgDh22t6062j754MvO9ZzQNb
 rOu/gJPGlEwV9aU/O9x3yWW3XjwXc5cbQENqQgToisLhbkgYSXwWYXNT3rujvO6S/NKn
 kSH2xJeud7KM4lQ9azfzohYZ7EwIUUMwd3KVpDTYFZhidYKu4YZ+aT/+iGiCiPAOj0fi
 cIKtk79GWCJWHpuIwgyOvsq8C7jVhXffMpCzqdg6+03lKmvVqtYN6bzTXxtzmHYwGeWJ
 c0BIRJa2+b0xaqbO8RsSQCl+XlUS9DJNcVVu5nohlwTbwNM+boDekUZ3IP167thS2Gdj
 1lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782949379; x=1783554179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
 b=in9muKAOR6vazm4iuaw2mQaiPj69Zdkx36tDqsqWyYVT3eJkWuQkWU6KeU0n7FEqKQ
 rQEEWUvLCFAb/1SiwycIO15EehSo22bGJbvk6jwibue5BLy56A+U3BLu27zbG8snuas7
 jMdb5SYldOZ0cdezajNMGjT9KUT0XlgToykpowQs1W0HBDGGYpOnbAJOo8I84BgUpliH
 vluq9ucTOcN30zvm07AupXuPqZZ7thXIXWnccjn7xilfvbX8YnsKJX+v+HQT47bikcVg
 hYy3jWPTlWTsnRqiQ/NNf9we84Cv5AAuJ7Vv4ZF9Nu3Im9tf3LwqPJ0hR8ZevyPfEMxY
 COwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmQeOjo9FYTULL7BBVYUZQn9ncuCIjsXwMGi4YfBkdRZumKNyAWLg8QiXDZixRflnJClxL6Mxlia4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQnBPSzwT1bNyNMesDrfBnCVzs7cqnPjapKQmrP78+3U9m0Dsh
 IfoISu9x3iIKCZl7D+rBlmwvS9fg6rB/1ZScSRYz+fbDGFoj7Uj/oRbJ
X-Gm-Gg: AfdE7cmS6fdalKUPokFQiyhmVc9CpnxjKeojw3zVGWRys2llU2V+tXLvCJoQvh4wVWH
 Rm8X1yiPhurN+r2BTd8LA8J+GqprV5PxoNMHSQx6esN4LjGbUWiJfkGRjf7sOTRzb+aqCwG9TYx
 SPBfvp5T/MfPjDw6bqHO6pZgAZOMJ0BQ+cLArPXr0mbJdx4raoOJcwyuB5AucWIxQkkFGG/aoTi
 K7VC2P3lfzx0fF7PXdj8HcLqmdi4ZMw+3OcQ0JZCN0nrzb4sFIcCHO4P4sver7xeMvSbB48uaw8
 IvrRdr/x4QX1zl1JcA4g9dEjLUQdpWQ17ZLzOa1JBCTvC65oPWo8xgEcDeL7fDVUvxVwlkjTtoH
 +2GcbHaIFO2f/xM/Kjkmmmdl+QjQtbSgfRvF0HwtGRaMqkbSL0TwpVIEMi0oFcDTMDR39AvOZW8
 yt6C0sq5swn5HLUAb/auIUrIQOsMF83dI=
X-Received: by 2002:a05:651c:889:b0:399:87c9:459a with SMTP id
 38308e7fff4ca-39b36de5658mr6680111fa.9.1782949378486; 
 Wed, 01 Jul 2026 16:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:42:56 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 2/3] fbdev: clear fb_info->mode before deleting a videomode
Date: Thu,  2 Jul 2026 01:42:47 +0200
Message-Id: <20260701234248.236023-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

fb_set_var() can delete a mode from info->modelist when userspace
passes FB_ACTIVATE_INV_MODE through FBIOPUT_VSCREENINFO. The code
checks that the mode being deleted is not the current info->var and
that fbcon is not using it, but it does not check fb_info->mode.

fb_info->mode may still point into the modelist entry being deleted.
If the entry is freed, later mode sysfs reads through show_mode() can
dereference a stale pointer.

Clear fb_info->mode before calling fb_delete_videomode() when it
matches the mode being removed.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2f1c56e5a7..c8aa163b0e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -246,8 +246,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		ret = fb_mode_is_equal(&mode1, &mode2);
 		if (!ret) {
 			ret = fbcon_mode_deleted(info, &mode1);
-			if (!ret)
+			if (!ret) {
+				if (info->mode && fb_mode_is_equal(info->mode, &mode1))
+					info->mode = NULL;
 				fb_delete_videomode(&mode1, &info->modelist);
+			}
 		}
 
 		return ret ? -EINVAL : 0;
-- 
2.39.5

