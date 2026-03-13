Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB51C105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CB710EBF4;
	Fri, 13 Mar 2026 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlPnBfD2";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07D010EBF4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:14 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-46702742c99so1401120b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408194; x=1774012994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=WlPnBfD2ikkHx6z98gzW9KZsxQ79SjmFVGsIFvb4gIeRclv9o/NVPVmmklXGIPliZU
 EpnR6Ch/Shbs+/lo0h/8ggG1/aijyiogv93k3Aouta1SpEsg2gbY7a02rLUQ83OJzlsV
 dYwiC8t0ROXtgwhHWVNeGdo+7ro6C+OKyX9+1Mf5z38mNfOjX66SCmuudX9EdlnVNTR2
 0lKTjka44O4biP3/aPrqeRzCG5FPwKoPVS5EA/jSXmOvAepyinUADi70Qb+L0pJn/Jq8
 tOkrkXSZIMoyXQWA1A+xnTduz0g6ZMekSyjYxSKoQJXQoPk8bVR9EH3YONHt/iyhO3C0
 KgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408194; x=1774012994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4prZoq+o67W5OQsgLrKexlAzQC80y9w+24uEfnXM5Y=;
 b=PcG0SM60Kg+iOLE/eDrail0A5vPB/7VDj1LlcSrm5BNY9FnldYHJWh6tc8FM7fh+2o
 xLQ4gOaJgAEXImkYHivRw8CD8BoSj+B/kC1By61CgTPU9EV7MRKD8waOV2WjG2gJO7Qh
 TeUYoo0NiGAOSLxOjUOQXsybfVoXsuj8sbaD5hFXQqAODXXDNDXVBx6q9755wBjepMEL
 G5AxMpz3ljDVsuWgiaT7I1k7xoYACFBvX/W+0PnT8Rx5lphwyOMwKGo4QgRKcQoCOh/E
 CpQ8tfygA9RfENIQLndN4hVyt4xdDUCO6bRmXdlL/QZrchYnYSfzb7rKAu4G3vDlbE4J
 4Teg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB2y66vfxC5JCjTYKNFD64x+5sSp6Wi/sgo39/G+24bBxa+1CEnwZwv9D7F7Bk4ZlU3GygXYB6UI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjVKLa8myYbRcLcwTIjp72BtI6vKfonFSs5ZDxCfZ2dWNuOGkL
 TcyqsyHOb+LC//JMpBwdCz1L7gX8WbSvkJ9RgsVAV/Wis8+r/4dpViLe
X-Gm-Gg: ATEYQzxH9A5MN7F5uLya1vyscNzXd1hA0iHYNwuNj6qQPYOnxbiG/0VbqDPxp89Vx1Z
 kZV/rTAk/AdI7LSBY+/p0IHCwCVbt1YD706YNIWM+mDnPeouza277PABvuzwiBwf6KWcEvGkcSd
 EDVj1JlmxD59EEmvf1R8HoxqzSmD9x69OItDzWngxF6GVtqMchw6/mqShbGmmpVORJI4zJefu/s
 Mez8SzyHJXqYzDtffAL89hLbmpBoeGd+FhBwKknSHo6nfqSIONqvTR/x1S+M7tjm7UXuzY1/2iS
 kpXRJyJenYEZqpj4YZErfJEMMWSFHUkZSiM1pFiGDUJMdk6Zwn7Iso1pJcX/v6cnW5Tj4SdLIoU
 6Lxd2CynL66JiSJTndBMpZPmL+BOYnJ2GhILJDjJkRqAtJPWf3YZdnNFf22QX/KH0Q2q/iGs2Pw
 OT3kSPfYh6S3shtdhmfDaLn7onCG0yg6htfuNFIyGQ3fbO33FW
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id
 5614622812f47-4675701babbmr1568851b6e.6.1773408193868; 
 Fri, 13 Mar 2026 06:23:13 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 09/65] dyndbg: drop NUM_TYPE_ARRAY
Date: Fri, 13 Mar 2026 07:19:34 -0600
Message-ID: <20260313132103.2529746-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 441305277914..92627a03b4d1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -132,11 +132,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
-- 
2.53.0

