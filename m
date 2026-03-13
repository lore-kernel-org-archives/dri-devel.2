Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B8105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C9F10EBF1;
	Fri, 13 Mar 2026 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aamel5+i";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A5610EBF7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:12 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-464bba3a9easo1493155b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408192; x=1774012992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=Aamel5+i4EvQRqTbJeWKQTYzNrPJgUdLhphQaGIOxbMmoZuEEmzgtIlyL16GJ1t7H3
 BS2/izNHTkjAoiWAoAVCUW/MmRV1s+DCciAerYretcpqhmHAQWx+gB0bl4IdjcMSr0xU
 VVBewsyOYG5QRDHmq47pHp+wp+8I0l+fZVJy5IbiEtvGP+ivhheMTmCzx9BnvUrsH6dD
 8d8+oZa2GzlU+bu5qpnrdY91liaHyHj0OQN/c0krs6w0NHNZgmawFr3zjrrT8oNaDaVt
 Qo0usr1X7TKnKgT0V/oRyq0GOVtWn3YfG/vGRJIdkY0CbfjHh0yoWpSllOc9DW1wBjQi
 bpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408192; x=1774012992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=XjjfmUMrkGDOXKeAlWW6bK6Gl1rBoH0XjprERSKoLzYp+qEvyHPWAuvwPV4g/A1i7/
 9uXab7dBIiTaIuLEuiyt1e/Z8XN0FLtyJ6MfTE9BQTCI0b14vnntdKWoEXkihAhPL6fS
 qonGmVq6oCTI6rMykZqOho7i5NTLGbOa3IH4vz1jQlXusSYPKIKPkzhIdeFrgcrbRjJb
 QTAoBVvG+RuSVCIWylkPuBPWHDA8SqbVm0qJVok7QgrDc0sQDrzU6CCATwxE99azquqF
 6esgd9JF5F/RPPbSMK0ILCP4Kb6B7PpGD4jCcPMCQT0Te+uOwEqaSmscDkxCUP1CAiiR
 2uaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp5RSau4g8j8J7ghkPEd+BvZdDeU9Z8mnHmfLcBIxWBlR7dYcmxsuh9awd5oz7L5C/U/s6aQPQykk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyGwIlBStlMIx7lOeENziDk543Rb9Ckdb6+Kx39wMVXS/ivmJG
 19al+K3hmSj/JLvZvdlouikxNT874umU+Luo8hzTPaN9d4ieUFIs3su7
X-Gm-Gg: ATEYQzzxcuX0eXV69Ksokg8Gdq1JTbvCGAUjMCs69je5mMbPX0Gv3APGBDj8Oacxq7r
 +CVffIuohaxMbhdgXdDR/OvIr7XFVrGo1d/oke+Iv5HoioXS+yDKsFioRaznMObmWNFDtv1cucv
 AwII+w6YarAVM/qn6rpXERcQiqLPMr706qlogvNsR8ANXOqV8rjcl3nKNwxF3Ak8rp0PLRpZsjt
 4c2aqIW1GWWBM8vdDknlnCVkLO8+3244gd28IF2U659bwAppgtcxlnHiEKosM2qB5bNMZW/T9E0
 BE+qcTHV1ANJR/gRfdpigDdTbbMc7MOukAfyfUXMrX33x4MmwtjbXj58EPQlEnRdJlnfHYn9pGt
 zSfT5vGPCMKwg0RYtAhL/aGgM64W7T2OgOhQGF1Mt80bL3i7zJnNWP0WtGN+LAl5/B2DHiJMGTl
 0Xz1PyuZWMrgnr+7m7dybugSaH7J+OBwEn8J396NexIVWfOMm+WXzVzxcCXmY=
X-Received: by 2002:a05:6808:514b:b0:45f:59e:1e06 with SMTP id
 5614622812f47-467570a2074mr1690601b6e.4.1773408191750; 
 Fri, 13 Mar 2026 06:23:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:11 -0700 (PDT)
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
Subject: [PATCH v11 08/65] dyndbg: make ddebug_class_param union members same
 size
Date: Fri, 13 Mar 2026 07:19:33 -0600
Message-ID: <20260313132103.2529746-9-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a10adac8e8f0..441305277914 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -104,7 +104,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a9caf84ddb22..ffa1cf7c2c72 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -811,7 +811,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.53.0

