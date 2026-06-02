Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99FBCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F7B10F64B;
	Tue,  2 Jun 2026 22:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnITl4YL";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A070F10F643
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so15757435e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440497; x=1781045297; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
 b=jnITl4YLvRS0uSVxy4vwUEJzx+RVZGUJBJUneYD4yaHihzLh51YqlhvWUKJbYFi1Kh
 X1IANIe5ZJwGO7pLgxidgzgTA6TeWc1UjkOphFyDeBGfHECWw5w7Enn+mSxcCJ+GJ1xc
 OQD2gHrjWEkFnSY/r6IMS3EIp5vNy1kMCDY6o8ffx0Tz/mx1BnsgJ4/Elokutl1Ty0mK
 yfOzfahu1sMZHxPCDxoBT0Rnmdl++rT16T+XAOCQpabt64wIK+NB/j6OCEmGIa2TSmzI
 ZRzLrICO2jQpbhum3ZBa5dJUdL3BJurIqU7p+BSW/ZSLiPnK44wxhpIsN/Wjj+GNKj9G
 RGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440497; x=1781045297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
 b=bfF+pnSOVzl+nUnBhXpxSusnWtAFNnCsvaQzI+WtDKsqJFLJ8RRUtEwAhHlooiM+xA
 hP8LQP/PMEvteQ1sroHQxRmzM/Dp3heuRGYlFz5BYPGpqQztL4m/bvzJPxvuxsxu6vqO
 1bMpAPqTyvtvs8Uk4xy437qFIfxF6tKO8yTu2+1AbQMsCLzdQmqR0MGuDIV689RwA9/d
 eC1Yl2ngfwMutayZkDauZ7Dtqr/y0JZyonwJ1nv1ntSgvLOdL0iDTn4omUafgq4p7wXT
 Jc3fl5EWQtpLDAWoWVqP9C1As3rhUVZ1p9iVTLHc+9mgpeei3j5wqG00AIXu1vFp3Ku+
 CqoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g+bo7HX015acGutyuKBs0rKicVFYWvkMx9BYopPxghJeU18sn/I78xSXgFrH3wne1sjvG679xTTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznDsjajCsAMO76+vLUqvcaHXbnsPjJ9wHddAkADH0IowX93+lc
 XHToVJXtdFnHsHvdgzPQyvjVkGAgN5kHUKdjWuuSoLaRxsBaHvvQhcfW
X-Gm-Gg: Acq92OGlUoneyOa99XYCncdhgFwadWRkdjIXItyW4XgMt/RQ5Fbee5a14OoDObqa9pr
 Z1/cVvX+9sMii4aB2sr3UZFSXtEB96WG512D6g/5/L7Io+l2Gqg6Vb5xQWfRps922xF3vqUzFYy
 QX1Y7wjn76WI1QXE0kRlCetNuiCUXHf5dztpcE0l1yOXCuK7UGJtUarsf/jLsX9wxFbOFdOn8rd
 IELB5zyzp127wxk8L4R1bYIjSazBbM0leVNhQNBwPPBWmXJzEVA1lXfIlridhJqU9niM/ynirqF
 d0hevxOr3mT1pGw+H+0Bw5z9dfhZ2HazksDubGAYCElDdcd6JiltfcDsoPBJV+w8RBkh+Mc9yqR
 bfAa5KFrl7FuTyvxyvOr0ux7Qh25c8AXVWqk+jbf7+WdwUmNU90oS+GBafmlWKAzO0QMsnbQIUZ
 tYO/uWavkBfjW/0Oni9g9en+gl/Ttz3w8252R9y3aong==
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490b5fe0e36mr10870455e9.17.1780440497119; 
 Tue, 02 Jun 2026 15:48:17 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:47:59 +0000
Subject: [PATCH v4 02/25] docs/dyndbg: explain flags parse 1st
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-2-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1814;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
 b=iGpCIeDHPVfQ770YcsgKYXv3tJwW3O+XIWlcq5CIrp9h5VC/6DBVR3xkR4b7Qcc8Pnj13ieeI
 Y4QZse5sLQqBLq9EL6k0vDUfzHjGV6rne+yovUgeHPiSQqfDC5aN483
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |

-- 
2.54.0

