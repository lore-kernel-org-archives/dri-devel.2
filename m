Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06AC44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A625810EB4F;
	Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3r8c2Vd";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0FE10EB45
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:20 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so6475385a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667440; x=1785272240; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=Y3r8c2VdRM9HUzdWs2YmG7hqGBaAPqfz7s78dO3WmqwG80uxdPsfJh+tp2PHLxQXBb
 Zltg0R7Q4vL0ZFpEqQHefZx40mof8lqazz5wiUULCm/ShU2WL4X47JRG9sGTGO9PcIVp
 ciH1HvXR3hHDqyhKlHDzaSn7ZogXq8yPp19Y2ujgYkJmohoCK07Oa7XqRy9LUrqrNOM3
 KOGukoZGHEvFo3X0OYriEQ7WSircuOQTEXRTHnxvsoVU6M9hL4/JUPFOryPqWz+YykCK
 iyxPfW97TJHtTLRxzLpNAPtDivOSfm1G8sX70yyDzcpHBc4COsRnzzpbctHyeECQIAa5
 8b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667440; x=1785272240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=jS8xrNsr+d32eDLnpDi7H2Jp23OQxBhlYNbcaaD/DOqDQg9D+nkBO+etzxD/oiPBcN
 v5tvCWFztGCDdG8QeAbRQtKoxXGVltalGOSFvClgos1qXxbqWk6da0fkPpDynY4tP1SC
 E6WdAbgciPh1OoGZOOJAsUCaBBDAvwXfpWUH5e+qg2Vr3qoL+MzOXDa4MXaTlefmjWt4
 mXgIXXssHaAeNd7EPF6fg40ldy/FaXJu2wXLaVx+5x+Rl8iGyPMtBYA2wBL0Yhydf0hC
 CMwKtULOxIKAni/Jz/gHsWBLEyTpmpWE6By1FZB4CpAGeOaQZHOOVG6uXUUcEB4ZaVzi
 cYbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop4lew/QxWXXcGXMktwXiVOT+divDSvGrhiJp2YNtx4XGrQCAaN/0XvFnPFC/4wN5l1E7cIfsfxm8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuDwyBn5BswOJn870TYBdD9NEcY4m+dMVxLheunCWMNb/WZpUj
 4oRP2TeFN0nzFzpcsUQSjfv6LRK65JzaHbHBXhveAhoUUzAj3aStZJPt
X-Gm-Gg: AfdE7cml/P3bOLPaMOq2SfNP90T9eOfwuwzlzIHeBGSb/qoI1i1daSUrRIgy1XxCFcA
 9RhtEsQPq/QeaAH5LRsu8HqjXG1FCziD+YjWMSXTUOPmLL+8+gE7RGeDrtWoYJL3q/UTZJTQpjl
 rlQC7YWM6PtgHx1CQ580W6nNKGu694TyAfeDWE49X0MFr8x3aR5lOBsCWcOXGhVODUM07l4k9GW
 hWIJmadu2iuF0Wma82IJQNffS2PggJlGPIxmpZkVKv25D1W9ASBcnm0WLDGIY94KSKE7wkgS/Qb
 SEBy16SahBX9Ri4/rkIX7+RaEiCbqRIgjQdm0FvoosA0Z2EEFI6ktFw5bCvH2FZxcFZuJXMGi9N
 U6r6tovvGgwBuBTQ1nfco80VPQrskJEyQCsDKuIDEilx+ob69yxL80uIA5hZC510C9DhfYc5uv5
 1YA/g6R4ZTG/RCvM/sFQdy4jQNz0yM0aNgOcErdFhyTiYQCnNkbaWmyFdcEOwWRr2tfLzN5Jd/F
 BdWGX0kRLF/kHrtQTTqDq/ZDaESKECRSsry
X-Received: by 2002:a05:6830:6d10:b0:7e9:b4cf:d8c5 with SMTP id
 46e09a7af769-7eda4d0f61amr9756553a34.25.1784667439823; 
 Tue, 21 Jul 2026 13:57:19 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:56 -0600
Subject: [PATCH v7 07/29] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-7-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=vQYJyP8MxuOQv2u1cH/IFNbnG8o09EQeGls4zdY2WK8vQ/fxaMBvko4DFb9hGhCOlr6txKN/0
 PPhajOOjZloBRtZqJwj6BkpY4kujVHKjVnTzPFcaqBAaTzv5VgUKeh1
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

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.55.0

