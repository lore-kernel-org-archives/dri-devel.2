Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33810AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAC910EBAC;
	Thu, 26 Mar 2026 18:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a5T1QWkE";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6666210EB8F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:47 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-41576c5c01cso890803fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551286; x=1775156086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=a5T1QWkE1WYGGaGnep2uw4lBcZR5x+eI79MI3AtB/f9cfIs6ZYu69AtXkyYavZcsZW
 oyd5Mqc1mwTU7Hr6yGOt7tGo8HGeeYsS7c+SV4ByBFHni1HRtAMtoc4oLUH9zvTZ6mkd
 yAYaaX44lP+AUbq0w+dAhcqutllk8AKAcfF1IgdznZu+IaF4Tpzek2/Q0JepWJsQuCKO
 RqPrKc02R6fSB0D7bTink3u7Mv5TjCvJvtkvndQsiGxjM1a8nRFfsESjWeHbapClkIcL
 ac7i/oK9w6k1inxCTmNAy+7nkeQ1IyXM0bWRBaRloUWG8inJmDjzWLQO7HD3HDoiulrV
 Qm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551286; x=1775156086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DJe7q9AzKIA5JE9j9dS7BkLMe6yLjsp/ulkOtgleYM=;
 b=XzYhaANwsTWx4BjI4Pu+pn/MkpfUWsKnZeVASgnteoD/fmTPwU486cQ+k8DyanGsVU
 ZrM6qZMI1+1UGxGQX12A0AVC3lN+YBC2VlftgtLpvnd2mCkA/evbAB4JVSiiyx9qqWxZ
 nfVh+bjAuA0Q/p8TjE2ECioUMDaX+kEyo2PImhboskjK2H/+YNs0cnSDrq5fIu3e4KD+
 P/+r8Hyuu3hfXLwTKU0v2jvG2kFAyujVQ0SibbBxTbQI+3Y4nEUqf30Un1cSeUqJRLHI
 0x//YCtRAfU39nffepyo/dpJ0NA2izNMI5vnrdvStG6tAPmLJADCVYGuNmyWwUHoBdWa
 YDDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1uUVHs6U2/1/rO7pn1kSSaZWmvzG6H+hVnHM8tjTrcgFvR8MPOccBKcHtg72xyu0GTlsPVnLdIYk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0zV0dH1OuSt2Mv/a55knwiralwsJxbm3KUDRc2zo02cg3CeZi
 Tg/UEPhcPn20YmbD6de/axNpGkQsAlA0tXtOZpDQNY8MofnI+x+rpJWt
X-Gm-Gg: ATEYQzz0LgMZfn7tlJDuzP4tGwhVX+stPNrL4u7NHuX33Q9F9o3hafq51h1rG6psFMP
 5kj4a4y9LvCkzBdTO6oA9kOfIcAd2GwEto8rgMRb2yoYFjrijZjo11xYju81Hl9gjw6L2oQ4fON
 YumekX5R16vUG8QALuIFfViB1LZi462ODyaXuNUQ4FofY0ZVFFiRlp8S8vHJuIAJ9hs1x07Q2dR
 RRuFA1j9NWsw8PjrcmaCosaErM33N6limqbg5k2oAVAteA+h7S2RUnohyh75/nov0pabExnlR+8
 l6hEYysxwQtte0CyE3xfIW7Ww4y7MuGD8LnGYn+An53O8fZ4mWyVQ8Ub04d3cOqc/conH2abPNv
 AgL4akV2P9Y0fspyXUpLTh2vJ4nej6Mgec05bygD2DSXvLaDvJXRjFRwuIAezYtjbRRDW/zABaX
 a1xn1u8T7WbU0c2H4Acep4Rtg7N3PDx69lJFsuGFjPbuehix5U
X-Received: by 2002:a05:6870:458c:b0:417:4c0a:1ff4 with SMTP id
 586e51a60fabf-41ca6d15f6amr4828699fac.10.1774551286631; 
 Thu, 26 Mar 2026 11:54:46 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:45 -0700 (PDT)
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
Subject: [PATCH v12 11/69] dyndbg: make ddebug_class_param union members same
 size
Date: Thu, 26 Mar 2026 12:53:15 -0600
Message-ID: <20260326185413.1205870-12-jim.cromie@gmail.com>
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

