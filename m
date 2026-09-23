Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612B0C98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7C910F212;
	Wed, 23 Sep 2026 22:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmO8VmP1";
	dkim-atps=neutral
Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com
 [74.125.231.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF8410E4DF
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:59 +0000 (UTC)
Received: by mail-oa2-f35.google.com with SMTP id
 586e51a60fabf-48f0056ef38so1076636fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202898; x=1790807698; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xNViDLZP/ndw6d10bbxAPq/kQLONZJvroL/iiRclils=;
 b=LmO8VmP15P20UoqAtq4trenpPdFs/z3GtNaaX2MMrAuMka6JsldEIYBkApmj2tt+08
 qXUlBEwREryFv2ag9V/KCVjBDXaH5i7mM3U+tHRe4YgitCWEvxVt7VAPCVBp1t0+fUh7
 gx3AonQ0hUMFJvpfUomRuknw3C0WK3LQjsF7+c9vcPg4dzcmKBcSr53v8Br5APSMkRg0
 TCfExa9LeDgPQ13cexDoBhnL4R3RCcLD07gvBnbMB5FyF/tSfejZLX9D6hJAitr68C1N
 wHlama74nPKgQn8tzMY+zioWRn9vMuS+B9E0YO+Pc/xyBcYNHzdPLsQ7I4J42Y0oUwQ4
 5CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202898; x=1790807698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xNViDLZP/ndw6d10bbxAPq/kQLONZJvroL/iiRclils=;
 b=PvrEsqm6OotKjD5xWD9jcUm8+D2OT053rtn6wGSqXHddr4ESa+qTDeIXKPVqA/0GlP
 ZERB8TiWef7meMVD/duCT7TKs9Cn4ko5pjxiEikagzHhRW+0Ww7+TGJ2KTmU5onit9vW
 kfuDQRgL2aosxLE60nRpkgYs51pGd3We+gqDtm6bZkCjW3pTJHzzCG7uWPSjCSIaXyiU
 5ULjwvNFhmvInXx9usPzdIWlG/pfMw36aic8neUDHTnMLLtN0Np/QFoSPcx7KfQJINW0
 dmYOYfcUfWFH9FoeJMCxvYcWc7h9BS9VrXEIPQ/qhMgef8TU6t12W1dIpTM2o1xRVhXp
 fTIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFD9TAAu+mjAYllglRczgdJLSj47Y5Fngiw2Dutr+n2OChMkEyweUyxXbgpCg+gsh78uYZsphSivw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nr37jyFepNKNV2cD+WKlmwMox87qHvu8Xe7PI9A89B/MzGQW5t
 GuDsLAvXxeF+vriP79f2msSdQIze7EOrCyG42GjAHt+mtkDcKgn77iKa
X-Gm-Gg: AYBFou0atr7A8v3oA1KkQRYZuqJpZo1nQPaQc30l6zk99DDqzcje7v5cBk2g0TnoLza
 QAh0ydh/FrhoyyPZ0A+c2zOu8jA6puVpZ8fc7BhrxqfsDQoGaaijfcduKclbso72GiSxjIi5WXU
 iUhVL1HP6O/Q2Jd2xhl0YjRRVUu7jOc7JR55DvGHgAf3alzB4FX0uFppG6PmabJQWpyL+Rh1tXe
 sdkQZrxYvUSpB0IW3ST2vRS+SE6sshM/QrgCGdsDttjKF6hgsAqEFm1QCbuMYmYx0Rwbm5RsEXi
 bYN2/y+esXk9xe9aqGAiMXLtwryNZgh0fyHRpQ6wkUI5oxLGRucLymkaJc+We0c9cE5pNSGkjEr
 CwI7SI46WpK3YhUquEwk3vgUFWEb8Te9GoCU/20AL5jLE39RUi5Fp8S+iZ8Gyuo7Sc7wN74io6p
 6Cu6xnHhiYWp0IlNT/1BdWImvT6SuBf/XXoPSoWU+cY3DYoZGGdzMaZhyFCPjc3HrsOkOfK9YK5
 WZCpMzLMMYmmr9+TyZsd2ZEy7APnLP1+t3gvRzcryANAhzAz6VDVyqPkPV2wUc8rGUNyNm7D/ia
 Zz3NIl8iDwzM2sXVs/Q=
X-Received: by 2002:a05:6870:80cc:b0:475:e2e9:4f4b with SMTP id
 586e51a60fabf-491e83eeaf3mr672694fac.25.1790202898430; 
 Wed, 23 Sep 2026 15:34:58 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:33 -0600
Subject: [PATCH v11 09/38] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-9-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=kcJmyR2ErJB3b2aUXQffOC1Yo8OFza9JdCBgcSweT8E=;
 b=EbxJ8aNNn2N8JWyaS6BS7GNKrgNA37jjdazA0+2phkEkOMkVK1BeOeOwCsbS7bDOavlG0jg3E
 9f6ObqsU7WvBJArvz0Lx/Dn7IfQl791wTvtF+oh1MjjDRgkeEqKxwyh
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

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8682c23b5fe7..13a3d1a8c3ca 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1174,7 +1174,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.55.0

