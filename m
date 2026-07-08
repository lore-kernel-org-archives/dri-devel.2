Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC678C44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B897010EF7C;
	Wed,  8 Jul 2026 02:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZpl+4pz";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EBA10EF74
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:28 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4896ae35be9so93436b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477108; x=1784081908; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=AZpl+4pzH45n+rxKn/ECgZBjfYSSGJseEHxGFI0otTyDgyCKikaX0UNA+2cGplw3sX
 IMwdomgrC36+adDQM4v/HOyKnE0R51Dxn3p703nrqzvRiXlSTD03NSOZBJIAlhaP+Ul/
 O+LowF83DZ7jG8HMvWkSR0Zr5y6WxqAg6c2UFZWv+RrJhrCdqW/Fg0b0BIhdfRKkvGUs
 FK4cKC1vZ6qu2pmETanvLVFI/m73D8Qf109G2PABhTgRp/qPl3j+O0f2pcAnJhEO6arG
 sBe7Jp02c6QVPRKzbA6alnNHporIokIhhyr2HhxJFOOhQiD6W/7NftOyQ0OVNsrQRrxv
 IuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477108; x=1784081908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
 b=jB2pVeUw16hCrRa4P0bwiDJMAt8CMYjFeGc+Ff8QSWQa2R8ZsLI56UBpG9KBlD0oQ2
 +DiJypP8we9WXgbRQ/nJraGg8qOcliq1mxDskp/HE6rvaRF9QdI7L6KIgImYZo9VwuDs
 9fpEWV8hKNxZrCuocdPtgCOu9p1kxm6/FiMCIQJtVO1yVkgIP/EbK9Az3X/GMWrS3pBe
 29kFqH/gQ4KckEKzwyqvGClpnM+F1ksZcxfTJCnn9kV+jwuXlG/UE4e8Fz7K+j8xARxj
 wnqX8uPuca6wFMGTuXSf/Eb7tB/NaJCXx7lxK6qNYddcKAScr4CuBoygqeSxtog959pf
 Bpxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+es0tZncDkfqUNsvlL2EcjHwFxrXw7ZpnFq+50AZ/BhmmhlM9o8aVYpCzhBGjRgni3NQ4FI0JDFHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyakC+IoWdL00QCO+khgVTcSskOolkpo7eOSofhwpI4fomAwV22
 GdcGTu3TfYRqSrSWsPc5OnMZNZKlmo18UHpxo46IkirwDYDlsatsUdsH
X-Gm-Gg: AfdE7cnOtjkuDZzj56RPPRJAzHGTIoKUMxY5uFgC3po0+4xU7EjwVuF+9HJxQKeQ7rd
 Z31Xx4/X6Kgd/UikJnUpovH+wjz9TdKY5ku9/WC0mN60ar0ckhlVb9ncAE0trgoWl1y6SVHuCtm
 ipzt4QhMLwiXnmbTxz9M7d69glAPmhSvWwBDsSVJ4eq8kHFBvs+LuQ1B/fkGR+a7K8F1Eg1myr3
 smjaUaZfJBWpZujCjACcUmuL2yuXGHeAuJ+2Ooz03O0dX6O9thb4wcaLE1bzLSSew0sVtyVhcKN
 avM6gFW1BW09xYoPu9CI9a+TpYDZ39ztpSj3yACGxQsIUXpGF83S3jV9kIpMOBRy4AN6aNCEIlt
 HNMyA8aVvBKfZB4uPAdhswFNNl/Uock/jZVNikkPxh+Ybtk75CPdV74C9mnxrbG34kiraac1g0H
 N/q3JAN/ww0n6yhcibCrfarpnXW8HBJmTgTGEvJtDJXqvhTF9cShQ=
X-Received: by 2002:a05:6808:1301:b0:495:f67c:d96a with SMTP id
 5614622812f47-4a20264e162mr418615b6e.12.1783477108113; 
 Tue, 07 Jul 2026 19:18:28 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:02 -0600
Subject: [PATCH v6 02/24] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-2-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=SW23dhkCOL2pSCo6EH2WYcPsMXMwsLEFgTbnzKPCXHy+TJuLv9grtIQXaj7l92AGZ85zaQDO0
 mPpMl6EC6ViDb0cLrpFnIMxdam2Jl2qUBgCdf4+kuCsDM0rZKd2SFlv
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

