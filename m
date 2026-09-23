Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F128CC98312
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5772410F20A;
	Wed, 23 Sep 2026 22:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pFK0XnRk";
	dkim-atps=neutral
Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com
 [74.125.231.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B82810F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:04 +0000 (UTC)
Received: by mail-oo2-f41.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc5so808971eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202903; x=1790807703; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
 b=pFK0XnRkCBg+hpmCQcrIIYRkHT9D5RX4M1ca2XKYiljifkaiHPUkdosFLyf3fPtBcT
 serXNt75K/fehCVGzGyDUNMHuJl4EzMiQqEruDwQ1uVbPWdl23rQv0EytDU3DF1zXSws
 0mr9NJsqmq4gO9k/y7t5/aLO3x911XPaz2U2m31QW//UIcacMryxgbmPw559qfRbvCMh
 e8zYiyQPuktPbOzIxZsYua+sZyZgN2xsRFasEWeCu1SzqgNTXHE006LPZEEpxnNTiVOE
 x+v0CjHdNygXm3rA1rTCBcTB2z1+9EL9geT7kcWJ9eoHvpNbxsHsQl5F5qDbIC7oBsU3
 /tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202903; x=1790807703;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
 b=aMbL6UIE6/wV+Do3pQsWRS5KUjmVFtSNLZdS7jvlEgqoXzSDhhoNQG1ZRDu7T7WT0l
 F+iQpkY7jOI0Wr0+mKEZAaS4qqEjwsoosDnNfsCtWZexc/H6WFHyywKge1DlbH5W4JAN
 mBBxAg9gvu3QtGidEsSRw64okf3mzcp/pTWvhjsjijHEDJWUPnrqJwThBPRMQ9otOtV9
 RycpSeHTFewGHRfD+SrwStpmhMPy5B7cN7/dNqTVYZw4r+b+mk0hXAFhn2V8IbWGM8l5
 qri+Q5/lSwL3h7EDbKt0L8Xp8lS0hQMyDtW+dni3azBTKJsZU7sx5EyM1ey37Rkqqdnk
 LRDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+kwes1y/vXRFqNuheF56fWU9BVTONySIjQCu7U/AbFEmOAIFCV4sB5eGoBH23fCCuOEuzScx1CzQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kUPH3Z7ec1U/GK5MpkJ/0yjcCZAPAp8+kv8Fnq2Djtkgr/eadO
 rfd34IPyw4HnKoUDP/edj/wjRECBm6t7f3DvguqSL6SY4dTqS8byp8iL
X-Gm-Gg: AYBFou1qP6A+WCLsxQU2Jt8MQaB2vexvztwY/Ui7zVgm/DlAmkUTvsXxw/bUkAQj4Q1
 F0Ln8pK4gLFdKPI8hwtURVEp7C/CFNGcEb39gnViPr3Fb9DGUvPL4PNclwk1WfxVmU/M7IEf9BM
 3q+5dJslS6wyuIsf8k9hpqUez8udi+kmQS0DjoPshhcJf6t0bmtYcMlcjUZuOLxtFcbPMMMPAIw
 8Ybl+q/LU+tCsSRd1s4BkxUn3I+Yfs0vPZkuTkqWsajyn4Q4O1RuQMT1zji4tBlbG/GPcVwSsOC
 RfCsMMBcg7sB9j2RRqSwpJwlwabUzwslq0Wjv8kKJPFsOilB+9GwBc7sk/IPtBp2Zf9e9l9oujN
 NApUoTnzOsahxL0fJUUq6vge25fzsXMT3l+osQ0j+tOJfxJkmRPwuLa6eYr9PGWYlxg10B3tJt6
 +LLqQvOnOoY4kTkpj66/LZ/SOtqj8e9vFz0AjO3ph4TB6kpBLHB1effQjlqepBhSTmeJtJxxqr/
 1z61hUcmxJZ//xelC4I6CFyq1E8pR2/su2pf8Bs0DUzSK6lpOhj6hVCm9o+cjBH2oVG1mYrF7JT
 maRTLrlX/8oYaaUCumk=
X-Received: by 2002:a05:6820:3090:b0:6c9:80d9:5e9 with SMTP id
 006d021491bc7-6d4410d8263mr670241eaf.42.1790202903465; 
 Wed, 23 Sep 2026 15:35:03 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:35 -0600
Subject: [PATCH v11 11/38] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-11-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
 b=Vfs3Matpzo3SccOlI8tHyei1RBD+zxWT7bK0muNastsFT501W8UwskuCT5d6UkNx7lTaofuTx
 osWKhGB+d2uDdbEIEynMyQnEsO2jTiildSPH6fRj2j31Ia/oBayQeVB
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

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

