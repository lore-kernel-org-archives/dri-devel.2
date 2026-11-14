Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964B606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGis6+wC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D92C10EA13;
	Sat, 14 Nov 2026 16:10:00 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F7710EA13
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:09:54 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-37986eb6fa2so1681184eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672594; x=1795277394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
 b=aGis6+wCi9s1WY6EOuvi2wDyICRuCvtwg7tZU3DWs4SyrTF/m7e/I7zV8ZgrQ3gjNP
 wE550Mwwx8iJ2xiD3xCGHDBuZUu1RhG2kS4jTpt/iu+ZQhzrzZ6MNaKfmcTyCLst8sBQ
 R6erYzvlbzkG/h1Uz4Kx8LPKl/f5jxLgVh76paHITWLEA/69vLPzUuwXG459y3EDs5x/
 lfyfoHGlzxhrxB4xHSUP+xQZcQW4duqiXeIzHaKX96ujM5dGtDiORGRGbox9N/nWlVfF
 4/XZTcjLcjNU5eq1oxcMxLNhjQzlpQxvNvPlZBDbD5l7Yt0yO+JmM3YvcLcnMO8KLo4t
 0anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672594; x=1795277394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jd91Zwd/kmiwKW4+PLimd5fenaYkPvHETCW1wh847os=;
 b=wBy5wlp7dieGDmOXrJavgz0M50WyJy6sOaroOwByH5ezishOUdz8ymIvGrjmSgHI0g
 ow7myzdcTe4g7JzEn8J+Q4oi20J/HVzT20Xpv+R7OSGw+NM96LTYUTjW5usRtobSH0pL
 s9BNK4RC/zyS5yDq3+itJQrN/QuoIxkLKaqeBVqDQJIHU9SlKd0zAb5AmfxmDvTzlDYj
 fW1n6suhP4Del9zswJR1hV5jz/CDdf2aPVR9wgPIsD38CgeAp5oxdRq6/4d0yJNKvO1d
 OXJkc4g7HNDbciHy4UeziOk6h2d4NOV9ved5TheUbjPMSo+d93yeDAEvdOpq5w7uHcYL
 v9xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErER4v2dvO0K4JKk2BXLc3uNJKQfRZml+NRf/kKtxTLJMbniGRK875MrQt6s2G5NJvDe7EpWMVaaW14=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KTA9nPcH9Dl52HaW1j4/bs7z1ZGK8ALUPbNW/lK0bk2MqFadi
 jjPAhwWCQmfJeOfW18mmMowsbe88K4lKiMSrgI2Juu0vaz802e2+Qq8=
X-Gm-Gg: AYBFou2TT2+l8h4wlnEI9S6/NzteQV0mgce6OojaojpOpBPxXGBMZo5hbt3RbTGbXwD
 6HyP91SJz7sTOBrmaJBxp+5oOL5App122UCm/5fH03SFs3tH3vZzc1ZjV73n0398RKzlq6gmCGk
 UgGfcJx77LgA3ahC7ONxcz7D8JlwSMXwThxAWk302Lm8EnLCZkWaF+ZgpjvFE+HjvjCkJs7dww4
 yUYbfNdPtAvXmJBg9E5tlc/PgG6wkY1joslnU4jtVDlbsm47ppDjPcC3qKIerpPzXaenAjG8usm
 lDgEO473Bg6nhl94pMPcyZDEwF8c5KVZdssJZm1b2q/OupPRfFcoW/rfyCK4w8qFbTc218Id5wT
 G7wl60jcRypxbzrupzhUgRL5GFhQo5q6sixwHqcK8Gjbg89NQwpd7DQ7LRsBTIjOkhTicDv7GLM
 gdXcJ5BoEcvMT7dU0sEqRUW/gvIiz16D6V59qvIwS6eOpDQLmNMcLJ9knlQNlY8CjPRUUQGh681
 K0Jm7sy6iGvml2C13xO2NChAD2ee/0yenj2P+p8EDGLt5vNKr/BRKs1+p4iplOeRJgmBB+Nyogh
 LQgfgQ+cDQ1w99RqpK/LCDpNVqm5GjpSz5VU54V26/92mmVRorqD79Xpn8rflHYFav2bVppJFuL
 Ht3OJEuSeK+I=
X-Received: by 2002:a05:7301:4d16:b0:36a:1d6a:596b with SMTP id
 5a478bee46e88-379675feb32mr5897107eec.29.1794672593531; 
 Sat, 14 Nov 2026 08:09:53 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:53 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 07/12] platform/apple-gmux: Add documentation about iMacs
Date: Sat, 14 Nov 2026 11:06:31 -0500
Message-ID: <20261114160731.3756-8-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation about iMacs

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index a1b7a4709..4f5c98445 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -444,6 +444,11 @@ static const struct backlight_ops gmux_bl_ops = {
  * switch the panel and the external DP connector and allocates a framebuffer
  * for the selected GPU.
  *
+ * There is iGPU present on iMac's aswell, and we can enable it using apple-set-os.
+ * But there arent any display lines going from the iGPU to the display. iGPU is only
+ * used for offloading then, it makes sense as iMac's display are massive (4K or 5K).
+ * A integrated GPU won't be able to handle that.
+ *
  * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
  * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
  * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
-- 
2.55.0

