Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD45105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7313C10EC0F;
	Fri, 13 Mar 2026 13:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCdlUqIj";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C13E10EC06
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:11 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-46702742c99so1401812b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408250; x=1774013050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+DKhn/7Y3l3C4FKBxAszRLz9P1Pf05n9UBGOlLEX4s=;
 b=CCdlUqIj86TorFk4KSYg+b4tsZCmtkzcAa6Rk//JUwPSP91VSl8MKtp6KZhbGtDEOO
 3oz3ev2tlbw4DONzwIJsDPdy0+GJ4J6XiXUHEKlPmI5B2/BSdpS7YLa3DggfUdnf8ISY
 6LRUlx/uIG5+tCjc7CwFH3aqvyUDKER9oG+Q0tOFdHSoIIIs0/W0X4/oiwXeussBhApw
 yTvnYNrBrhtLeKKoPKl8LthB8WExyn9ITQgdE9Gl33CnIIGEfQTLd1t7GcdlTHyVsQht
 qnfcsT1nywAN9G2DTywTq3+O0QGymJMl2ZV7P4N7Elgn4OI/pP0t+x9DyGRD8Xa41/Q7
 bbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408250; x=1774013050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+DKhn/7Y3l3C4FKBxAszRLz9P1Pf05n9UBGOlLEX4s=;
 b=Vi/NGdf8XaXx+3zr/Vc8XFludzYkjuXPWJuU11LI5+FjpnlTUs3m9tA7kd52p9ZgLO
 WKQsx2eX+qdg9W8QjO8B5+BHZFYUbExK47Bkl/MeZiVmp0GdM+vT5hSz5KUJcHlmcg2l
 +S79c8B6c3WFIOohJXrvqEijJk0C5CpnKUQL8rHX9f0UWrIMc+caN8hZmKbj+wEhpwKp
 0dosZfteC9/OVOHND7sddHk8MKfaW4TGapgG94fWAWGbjVILQMuIayNBmMLM0Y7mZAoO
 rj6CW4z1hr8angjZdv2hItHPLd8MUU5rO3fY8fEhTFvAg4g7tgrUcUK6FT7PVI7TQ4AV
 1/0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbcpg9wzCpTM0imf1YLJKwtZBTh+1253nlSpa8BnLEoScPN1QnKTx6ic+nRcxXDmZBFLZN7vg9sK4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOQRKiBV1+I5Rjw3cqi0o6fHjV0Q5tI1YnKSyyZqTo49WF2J9h
 tD4p6wUolHLt4+vNmUrP0fb/BnuBCAmFC+2diAvQVXatzc6vS7z/yHg4
X-Gm-Gg: ATEYQzxFqw9EgcZ5tbNmm2z+3Rnge2Nj6caJsxiqfZvDGTGk0kE+ejWwaa2Hm8ycY1u
 MF4c80BWnqANAvWQAKv1agV1QyRMjIM6GxwvkUZdZ15zhKs0I52cddtf8PeDD3Nx5XFw3FcM2PS
 SgxbGUxGW8npuR8UiLr3Mbwh410VdwE7LrZUOyOBpwlwHc6qcuw9C8t1XnG0wyLIjF9rg0jPsyO
 KjRYN6uR5M3Wc+gy87U7p+D8gST/WCNh64YoiLjl9QzCd9OG8BeMpCfdUCZXVCo60tSv+d4TCQD
 x8ksW09ZvYowNmbv3ze6E+0nTE41WaudfleXvFIM9meCaBjgOnrW/dDxjvRJ+kAaF+CKYqzRKko
 bBFBT3yDY1TmEKYfoK9H7tA3DnNRnpEdKw2m2NDDQkEXMfaU4vRbsHpBQIk/qtBLw1QRIzTzzTL
 9vsJfbDj0y73mZQibmPQX6wM2IhyHUo/nT4fvJHTS18gL8OrNr
X-Received: by 2002:a05:6808:15a2:b0:467:5571:1b0a with SMTP id
 5614622812f47-467570d9e44mr1817008b6e.26.1773408250365; 
 Fri, 13 Mar 2026 06:24:10 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 34/65] drm: use correct ccflags-y spelling
Date: Fri, 13 Mar 2026 07:19:59 -0600
Message-ID: <20260313132103.2529746-35-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which disabled dynamic-debug in modules built with:

CONFIG_DYNAMIC_DEBUG=n		# 1
CONFIG_DYNAMIC_DEBUG_CORE=y	# 2
CONFIG_DRM_USE_DYNAMIC_DEBUG=y	# 3

NB: this adds the flag (when 3) more often than strictly needed;
modules built with CONFIG_DYNAMIC_DEBUG=y (!1) don't need the flag.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index aba4bf542a35..02e244688b48 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn
-- 
2.53.0

