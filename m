Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E02910AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E9A10E088;
	Thu, 26 Mar 2026 18:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TG25N/Z3";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D379310EB8F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:42 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso778705eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551282; x=1775156082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=TG25N/Z3YTgPWXOmXhWjfDAVnM5B6uECwSBVH/Jwb7R/cwOeUBFflRFIfFwpgz6hk5
 aG9SGOFnS8nEvkQIeSuO/6t1xRe2TDfpXzuztD8A7oXMCbejTrgkGkVsW9GKizhZcdR2
 UFWLdT6p40MNOkwM573U3qV/2qzAfs4FviP5SwdAXVSZS2uny7XXGINMT95ZN1aJMhZh
 ne8k9pVBnY65GsX7R1+fypPJzgZGmUHfkLnIcbAk8WCgMi4ajlR6n000Hw5jA1fpj+I2
 bLCmFNRi4pm909OaqfQtdnZSJv6zpQo0UDDRlXZTRvHjLMYcZ3p257Lo39PWik60xBgc
 35VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551282; x=1775156082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wIIBK2xLHmy9ZZczWpP2RzFmOx4bELZz7aMw+RGO2w=;
 b=NSa+D9/kUVux6xl+mvuUHJ7pjn9U9copEfKYXoMSqWenLWvNv3DLlYcuhqL2hzA2Nj
 3iMXiAFTjKklu7ZM5qsBuSDZ0rMapgwk7qNYOVR4JkSUAc14dkScb5IT4JSsda/Hwg/9
 vdrJXmt028xt6KYH535DZSbE8CHaVt4VqKDBprBKtX9zhX7hI0Sm8bWAx9l41VeL1lKe
 1aGCysyVTbtXvl+T5p/V8ebTVLcVge72DgCKAuDjquw1YF6OiJksfE5uSCdEwluwV+2m
 rh8s6n19AFAyUA3RTm+pK5nE/AD4FLXCf9bl45dWp5sCn5GCVFfLLL6mwrKMb8C+G+dy
 PD6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+vIuj9HU3O228vxOwhKN06lvHdfvi/YV2uyIo8tyIu2xuUP+mRShCAt4GGsbU+tpyyOBzADdvXcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJpbALF25SDRP7MpHm+MydccycKe98U3nTgPuTEWyjwF04hnH7
 /bEq7Ou6GXQQC4uTMG89n3t1zjqpL/Aj++8g1urkRL/e+yIIYBlKBevo
X-Gm-Gg: ATEYQzyFFz9NEg/HmXqUtUEO/yAA7k1QcN0cOOzfb7mNG8JUU51LW7ZEQBBcz6cGafp
 9yR3HYImpbXDGy7qcUMlGvZLULAyVI7V59xPVBem+7rI17rRJYTqOgXP6dQ5ai52lwSAoOen7hf
 wFyJnH2SIPBrWHBzUqY0woyG3gIctQdAdZ806et7KfzjrQJgiEJ79+RY3Dmsc7cmRmMju/Llj4p
 naikQgUJp5t7nsf60/xvYWcWkgr6fk3e/mGVcN7unEAQG7miJCWHbKn8R5U4KPvwEZ7pv4uJm3w
 DcwGE098vKUUIVu+RpNnqYnRTZrxJM59XQDIZSnHCvZ+SGc05LC0F00I9CEbf+3zEj/sszkm37P
 dOYvyPPUa/dL+2/Ur/ZCNnXqZiQemi3mtuKMtPORh/rDOa3+7eL9u96uF3kgDdXdqTy6cdTd8Ub
 XjqzQoJzz2AqQ8r7H2U36WhaPQcqUXtmOS54tl4bcoQwQsuzXz
X-Received: by 2002:a05:6820:174b:b0:67c:2af2:a66a with SMTP id
 006d021491bc7-67dff37caf7mr4976746eaf.11.1774551281759; 
 Thu, 26 Mar 2026 11:54:41 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [PATCH v12 08/69] docs/dyndbg: explain flags parse 1st
Date: Thu, 26 Mar 2026 12:53:12 -0600
Message-ID: <20260326185413.1205870-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../admin-guide/dynamic-debug-howto.rst         | 17 +++++++++++++----
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
2.53.0

