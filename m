Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9CCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D24910EF8B;
	Wed,  8 Jul 2026 02:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnuoS9wg";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC4410EF79
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:45 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-492046a3313so182245b6e.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477125; x=1784081925; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
 b=jnuoS9wgABG0MIi46R8TvP92KCj+76GymlrKAZhr/jBXe33l8k857DQHWwQa3TPV6B
 4nu3yYbXRiiOlNd5liO4bFDyQNMDsOWiHnmiYgK6E2o6+Y/DGpGKWy9tR6jU/n4dXhw+
 ovuCkL077Eyg8/IIKdraUe7yetHWkKd7ZRZtwx3u0trh3FWp+8A3HTFQKA6Az3U4BEeE
 POg5Ow78CRbS87nIEEMADJHxZJxwVodgXXNXihC3tZmyB/twFB3UdYW/Rmtr0iuEtQyn
 m58m6/7xAIZ6+q0eFRwptn9j1ybD2KzCahxw/XG0QIwTkmH3mkREZrcU3q/FK8WoBr0v
 Rt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477125; x=1784081925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
 b=HCQeXJ6fcKnjJhMuWDdhdkoqFh+4QXV282LxLQxXQBddtioc8EMwwreLSK//hc7BpY
 GITHGZQunpNABk9FPJkxSRE9iSg6nq/szJgAuJ1PwRboIDv0fDC6b3bfAWYqpIa2Jpn+
 aMZPL9bHdrt23lAnwGjxn9C5gURresxcKa1tsb0Ncw4MoTmSTE5hgRBCzpRaj5qbxrcs
 TarIW/AOsIgMq0O71wjzJZYGz+4jG+Q7KtbKtGYtZhDyiFLGECanSjBzZ/bw/TK2hOlS
 PRbRJUBe0mS+oAN47snmX/DhxQT4MBOhPhIt18rn2Tbh/smOKz6vZDcg2zbISqrRlF1o
 ogaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sJHm3hYR/yRwbLMurr/IIEzHVEfQwnS7bZ036lS6GOvtWFujEHVttgYxTyzlNq+tl+Ti+TS+NqAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyksQsUkiHDIyaMI5mki9oglFK1EQvkCirQPNV04+QQxkOw1fUD
 heYwimIXNBDcWl/w462q2bedCab72YdByKBs2I7DI6pscVq1xbmFVbQt
X-Gm-Gg: AfdE7cllfH3Ah/O2x7m+2Dw2s5p2/LvErJfJEPPjIutOKguOAMyZ0s2kQfKftxUQCti
 c89G/m0kxTz8ep7bSn7n/Ng/rYRT6o4Q/CSHKcqqRsWynVKspsB27BViZrjt8zcyS/KoK1Wq8jG
 shNnbX0QHRKtoj3VmpcLdzHyEdHkWKXRJFrMVwxZku4vQo+ZMeH4G36B4YN9eIwEgfOMZyX+eGI
 13sDgQeVUovhC/AlQ61T4LFfC7Ju1NK7M3U0FrLlXjXbXkUV+GvJWvLIJ5YerLJiTOXSfrxZejA
 VqWCVcPXt6SeW2bsTJyAE0s2YxhnOT3xM0zphwAAXhT6uoWjGct6CBHuXEjgL9TN3M2nLZa5SNK
 mTBAA7yBJ0DDpj/s22qHb+foiSwwpnIAf6sAl+sn17/06MfKW3Knf8VdQgrYSL8QGqvSJzN7hST
 0OTds2iDm84NURu3MR2VOy7EETK8qMx7TltSeDco7cX3JUXz/JeqI=
X-Received: by 2002:a05:6808:c3e9:b0:49b:dcb8:e2b5 with SMTP id
 5614622812f47-4a2031a6787mr416421b6e.19.1783477124787; 
 Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:11 -0600
Subject: [PATCH v6 11/24] dyndbg: bump num-tokens in a query-cmd from 9 to 15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-11-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=x84mdEzo7hGPjR/NYVWAEdiwl+S1LrXalF/kCz4ObuI=;
 b=TVncpAifs+aOm9EOV2um20M9XK9Z1sHPPRKEV6GBYmmZOlkbuXaoVE3Tmhtle2n/KiIbg4PGk
 /LU+iPNi0+RChSjgg5OL9l/UjA4Som2XihR5K5pxfUf7olt/oz10Exq
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

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 

-- 
2.55.0

