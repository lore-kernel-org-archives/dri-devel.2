Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C4105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA40610EC00;
	Fri, 13 Mar 2026 13:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaPvrfBk";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FB810EC00
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:47 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-466ed3bc95eso795020b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408226; x=1774013026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=So1OTSMskFHrYYWc+bNZ+5Ly0eOy3XxdufShv2uDEDM=;
 b=gaPvrfBkXcQpC1LYAo1ReApEuCBQc3X6A6P58QI2uez9l/Boc4sAH1KdJYNkLOC2K+
 9PGE52w4yF/rwI8c9TU1DJuHg+7WHy9Yd429tM+/lNEc59ZTcWCAIfHwAQDNJK6Cn1cK
 SCfzJ7OWqUFojm1z7F8e3lA0vd/bx12QntJ0HYYtMm5rUHAe7+FUo3Yf183kSyfATuqv
 MGQnl2xil9R3i8CF4oPqoCREB+Ym0Dlxcq33M44a1szdOGpHH/tPpIr4zszn1QwMsoux
 VCZGd5LI3Cfd1bSBWFU4bt5nS/mIp29/BDku38c/y96ib3uhhi41GryLrZn5llB24uRh
 1Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408226; x=1774013026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=So1OTSMskFHrYYWc+bNZ+5Ly0eOy3XxdufShv2uDEDM=;
 b=ruTOUcz1uucDjsE4w5dKt3idVwxfDuY/oiWlFUrkLxeTRQErVQOqnHfTEx7asRVrBE
 h4MxuynHPx5GxhmYUzH32KeDIe1ZIZqg7OSywimCg9bl2+Z+cB09uMQdUoUHHVFdIuxV
 X+tNftONfq3KEoVwcYqD6qI2YKXtb8+nFOshsRtJu/rN8TTjsaQoHq3+UBFgclnsKS5T
 rZKOQdCzExuZZA6Xp09ZQcWg9mhddxxi1+VLcoUtXeqi9eAQOxA+rI9jXKcRsQ6vT8ee
 T4FeZ+e83WD+nipGPUqOf0OSjHc0BeKDVFWCNRKDLjP4eUHNjtqjYs3TeQXBmWULalcr
 kKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVviHlAcMtvtVrdpfuLHOrSEyhbIGLdp/K7iB940SKqqY+P85AwmPN3Se597ZbdpEVwVhaJBy/HpjE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRQYos/4J+A2JI9J5g01EMWdnDNr//r0uaAiKhPnZ0leIbMx+j
 5pf/+69DVJUE4154i4VxUAdYOQPvEIZ0D5xQ9K9qXFmy6UhXX5GfGgsh
X-Gm-Gg: ATEYQzzKOdr50I6Zk0ISyV++g+aZMi4oCD0sqJAL59y7oTNuJx5u2tAdfdvt3mAEadz
 SfSNsj1oCucGjsXyfExWki4bAsk57rJiOGqi+JNm2YCvFlToesBO7qKq3p2ZKUuw5BzUzJWqcU4
 4RrKSrfYz6mQlCMpJ7xaO+ubNW2+9ZKXarT6Xqoj+uYH67qQcAq8CMT08knejOIyOIT4fffcjws
 08BzH1BNJY6eWhgwDj0TLB82Bx1s66G9RuZKcRkbezErYkwXmqHRqScz0QmnKhAHfm4LUUTEJhK
 RkHvyJIrNL6OyGAYb4UUac00PS7a0a9SRWdcKJq1EQfHm1fc/tubtpvEfclXYOBtA01KhBb0f/R
 urkt/IAidTcwYnpCYE14Hdqp37XdkAsRlLCx5QrDvbxr5QWvVa8F3oGxH8tezIaX9PSyDAbbnhw
 g/XcZv6g/wd8NEtilV1t6wybj44AvKgrJk7sHVH8H2x4ISA7O9
X-Received: by 2002:a05:6808:6717:b0:467:462b:ab0 with SMTP id
 5614622812f47-46757050cfbmr1535486b6e.2.1773408226613; 
 Fri, 13 Mar 2026 06:23:46 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 23/65] dyndbg: detect class_id reservation conflicts
Date: Fri, 13 Mar 2026 07:19:48 -0600
Message-ID: <20260313132103.2529746-24-jim.cromie@gmail.com>
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

If a module _DEFINEs 2 or more classmaps, it must devise them to share
the per-module 0..62 class-id space; ie their respective base,+length
reservations cannot overlap.

To detect conflicts at modprobe, add ddebug_class_range_overlap(),
call it from ddebug_add_module(), and WARN and return -EINVAL when
they're detected.

This insures that class_id -> classname lookup has just 1 answer, so
the 1st-found search in find-class-name works properly.

test_dynamic_debug.c:

If built with -DFORCE_CLASSID_CONFLICT, the test-modules invoke 2
conflicting DYNAMIC_DEBUG_CLASSMAP_DEFINE() declarations, into parent
and the _submod.  These conflict with one of the good ones in the
parent (D2_CORE..etc), causing the modprobe(s) to warn

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v9 - fix WARN() by adding new 1st arg 1.
---
 lib/dynamic_debug.c      | 10 ++++++++++
 lib/test_dynamic_debug.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66f4bfe39e89..ec0d1c427d59 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1317,6 +1317,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct _ddebug_class_map *cm;
 	struct _ddebug_class_user *cli;
+	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1341,6 +1342,11 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_mark_vector_subrange(i, cli, &dt->info, users, dt);
 	/* now di is stale */
 
+	/* insure 2+ classmaps share the per-module 0..62 class_id space */
+	for_subvec(i, cm, &dt->info, maps)
+		if (ddebug_class_range_overlap(cm, &reserved_ids))
+			goto cleanup;
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1353,6 +1359,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	vpr_info("%3u debug prints in module %s\n",
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
+cleanup:
+	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	kfree(dt);
+	return -EINVAL;
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 6c4548f63512..1ba4be9a403a 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -128,6 +128,14 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 
+#ifdef FORCE_CLASSID_CONFLICT
+/*
+ * Enable with -Dflag on compile to test overlapping class-id range
+ * detection.  This should warn on modprobes.
+ */
+DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
+#endif
+
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
 /*
-- 
2.53.0

