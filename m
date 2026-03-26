Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C0810AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903D010EBB4;
	Thu, 26 Mar 2026 18:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uc+V+vIw";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C86710EBB4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:50 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40429b1d8baso540209fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551290; x=1775156090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z18RPkW2IZoeg5aoWLW/CvDoUPtyLf/KFWO8hAB/+ds=;
 b=Uc+V+vIwt+NnkXdfEX6piAWgo7LRM5ZN6PghW6v51c5ivZPrMaVkP02HXXgOM7Vf9I
 E7Q636MOYNKm4+/6ez0EQRrx9+wLGSezeSVdVIA1EOgk9YEX5/t+0QXfXkuc2196zEhw
 ilEtg2fJ3fbqDDju8bgLOUn9a6fOAFHeSKnw54GLFNjTlcgjBfJ+EPmwHI+hgFE8oC9n
 3R13CwZ9rssJrCQmdpwpvhc1uhdKs7C9Sj3vfQzNDoaFdPNGp1jz6qfpfPfvzqZ+neBq
 nocvtwQb5AGWvma/w8YDD1Af46hV2+qAbo4/SmSsp9Isj6Rhrg7wKxA6uuyzJliVSqGL
 BgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551290; x=1775156090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z18RPkW2IZoeg5aoWLW/CvDoUPtyLf/KFWO8hAB/+ds=;
 b=NCajjWeJf7WHr2AbAarMTRiWed4QO8eu3IErl8VCcETHBLPghCTAnVOcpUdoAFHewx
 jjAx2FZdndHuW9S7M95lb0jW//rsgMRcETlrMlNMU8Xd05NeCzW2fPnyF/gHSQe52TAA
 +kcsMtqhdwUwnGaVBkWuILKzcTuT0eaWx+QvloOfi3ZLbgSTfoLicovg09k57MuFQW5I
 jmtXZIFC3GO2m04f6CID3HtpDO12UoOEg59LS/SrDehSQdscGUEFUbRL4B9FevKbjVil
 nmdkRkFfA8Kd/5UYfos+GTKlSVo/kMejq1a63h/2fBNFFk+1QpHibhF13jqkcmBWF4R5
 lMUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGz+LLpT+qVtrVrygjRtokhGpflFB7QngYqA9p9mnrnZtZtlf8OvwUZ6VM4YI34cCVotNLRJm3xt0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGFM5haqsCCbaF3w5odYu/fUG48ozJpW3Vk60x4Jr2jraXcj85
 35rAZVHbO/wgHnhf+K6BBEzMzEvmYRpylZXzBixOoYeeR8wOVXFoAe6t
X-Gm-Gg: ATEYQzywNVZD6ORSnMeSF4AB33zFLmr+JT5wlj9Zxzyh64sSLiFBQ+cDgdDqekSWXnr
 unvGQiEPLsrPSKCyZ/jJytovdGDlnktG1JkDxdCnfTUaxb9HAgmbdpPaGM593WXuk8rRvViGRSM
 MclyqExf/VbcehpW4HNg3P55fGh5Ot1i8IJx+di/kWAFPJMs9ca1+U4KvG9YMCOJyx3M7TGll/7
 Ep/8efJpjrez6oh6tgXmGUqwG3gSELutaWBYj+TRY0CP6zfG0eXvDXo/2GBCcLqdW91Zqp29Euf
 JbrHqfKj6ImPtBmIa5Tkoztd7O6opETaju7yJS2gS+MzYJc/Sc3sVE8sj1Garv536sR08AW6ZIL
 u6EYmj2M6Fn055mhTw2JL55RsoCBTBo/EKLs9Kme/I01lysBJSqkxr19JgOa7tOvJ4BJlRCeTHp
 05w708naT0zORcH9+6Ii8EprGET7/NyVxsYQFCmeDCbOLzDjTF1qGFGr2PRD8=
X-Received: by 2002:a05:6870:e6c4:b0:417:5d13:2bdc with SMTP id
 586e51a60fabf-41ca718019amr4930535fac.51.1774551289656; 
 Thu, 26 Mar 2026 11:54:49 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 13/69] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Thu, 26 Mar 2026 12:53:17 -0600
Message-ID: <20260326185413.1205870-14-jim.cromie@gmail.com>
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

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ffa1cf7c2c72..9575b92a8deb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.53.0

