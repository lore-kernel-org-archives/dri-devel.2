Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB510AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA75C10EBD9;
	Thu, 26 Mar 2026 18:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JIOIMwNg";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A30910EBB9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:24 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso852576fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551323; x=1775156123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHBDIqz9/qVForB86mGxoTdQjucG23eTecUbThbELwQ=;
 b=JIOIMwNgut7zpMR8MY6Xy82gDArQYbm9cCsWN0ZFE21J40w277YRUOuNlCPk84KOi9
 7/UyDl5h1agq1AtdRFRoCZTktR5iED2zCW0h4qZmkib2+KdNRv5xZh/1a3conav6jqIi
 dMnBkmeYVVmzgJU+yqntxT4d9oAORE/N13UB3PBW+3px71qTxNCSqoubbPnl4eb24Y+r
 M8ufdhKwPH/YZMAxfuh/ddMp6Zmq60bdJznVfAEePubGKm0utAzWmsTuq4m8OHetDYTv
 SPfNL2Jsp17+gOZXY1GnNMHhfp9NvcdoFbNGqa0lKHXEEZ6GUxFU/9CsTHq75m6g+Rkd
 IZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551323; x=1775156123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PHBDIqz9/qVForB86mGxoTdQjucG23eTecUbThbELwQ=;
 b=mVIZUVhS4nUa4cE61f+sGTuydB1z0EmbM18vqz9piBR6FAs8xXztFAdOxDIyaj74HM
 9Moulv49alG+dJBC5AZmQkUbW9GBWNYOeqvftLRyevISEG+PEH7hJDD/kNza/N5iPuWK
 Ns7tdHrysjgubOft9wMW6lxhAVf5WYs7pEFreRNfFjoabvPPdDrvdplK8UNEN2jbbCBz
 8ryKJ4cwYfjRVBmb4fd2vmBgxxSoEebQRHls2YYwmBpS0oqaVtWJCWbuTjO84DibQstn
 bXScONeOpNMQguo9VD4z9qPjIa+CQbbs9B5rJu+TdQ937pLM/+93Ym2k4mkNuTK28lAb
 lh5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEJ+TqHVbim8MQmdDv8eyKRXihNctwgkO2I4rA3RsghvdYrNH6aEuPP2awnHIQtOSqwgQjVI+uN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl0DwmfmJntc638+LEWqW4G1/RJpfJiPOuNHtKM0LnoIYjgzRz
 xD6Ay3W/fnMvyJeaMqZes82ptznmP6YbwDtL4isIHHuPe54XkTwm5oiG
X-Gm-Gg: ATEYQzxjB2r4H2CcfXGiCxrA9wxfyNbMINK7otgWh4DX4hPgqcAIfuLatmMyTtCDNw2
 SsNBf1sP9q1SLQFgicUN+PujJGPNE/JWnu+gcpwv4U659BsG3rmSDD7hnyHhCZzcxGjt9otDjP1
 zweJoHRUiqa6rS/FJkXfXyjK7nUpM7FppRnPiOuUjHqY6LbKAVjQ7zw86zN3SSTZ+TISbX1u2vs
 EhoUFIsvSLjETrIaaPED5F0gYsnS8JyapGsIE2cqcW7ckQOQ6EhcdIN/QgPxYBUiwx+rxUh7GhL
 PCoqs687lq5NlovATYTe9evnSP0FIm/ZQzpQ48HGxvd2FgWW+dFotef1BKooUCYLioNcT5QscfE
 fU71IEvN2Y5MtX2GwEcE13HUEtqR5yo8Gf0ZbhBSt4S3L0EVCKzB+veZZ/mA0U3ns5/EvP7OlVL
 FKlaBvPsj2HUGAn/GeMVcrWadRRX1GQqxGIVngItskDsbUBRVG
X-Received: by 2002:a05:6871:520d:b0:417:5970:28ea with SMTP id
 586e51a60fabf-41ca715a2acmr4330662fac.51.1774551323554; 
 Thu, 26 Mar 2026 11:55:23 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:23 -0700 (PDT)
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
 Philipp Hahn <phahn-oss@avm.de>
Subject: [PATCH v12 36/69] dyndbg: Ignore additional arguments from pr_fmt
Date: Thu, 26 Mar 2026 12:53:40 -0600
Message-ID: <20260326185413.1205870-37-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philipp Hahn <phahn-oss@avm.de>

pr_fmt can be used to add a common prefix to any output from a module:
	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__

But adding additional arguments breaks dynamic debug:
> error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> |         pr_debug_ratelimited("%s", "Hello world!");
> |                                                  ^
> note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> |
> error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> note: in expansion of macro ‘pr_debug_ratelimited’
> |         pr_debug_ratelimited("%s", "Hello world!");
> |         ^~~~~~~~~~~~~~~~~~~~

Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
any additional argument, which `pr_fmt` might add.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
[pr_fmt change on _submod]
Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/test_dynamic_debug.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 1b401f398a3c..49f37d6a4eab 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -344,7 +344,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		dump_stack();					\
 }
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
+#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg_descriptors") name = {		\
 		.modname = KBUILD_MODNAME,			\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index db555f5f8ea4..779309898422 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -23,7 +23,7 @@
  * the usage clearer.
  */
 #if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
-  #define pr_fmt(fmt) "test_dd_submod: " fmt
+  #define pr_fmt(fmt) "test_dd_submod: %s " fmt, __func__
 #else
   #define pr_fmt(fmt) "test_dd: " fmt
 #endif
@@ -214,7 +214,7 @@ static int __init test_dynamic_debug_init(void)
 
 static void __exit test_dynamic_debug_exit(void)
 {
-	pr_debug("exited\n");
+	pr_debug_ratelimited("exited\n");
 }
 
 module_init(test_dynamic_debug_init);
-- 
2.53.0

