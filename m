Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8F606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fAamMi8M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE4B10F00D;
	Sat, 14 Nov 2026 16:24:59 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3F110E561
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:43:59 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so358770066b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620637; x=1795225437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ln/RngDaBKEnJFXqfKaXLiW2drDb5LIdcMJafwzjtfA=;
 b=fAamMi8M1XatpkG2C72yQttqUVQGl0beWVEH8mopdMselkrRq8zyDEOQ1kqYo8c/wK
 Mtipv6PYv7EL7RHVgOE3ymJCTzU7jsFKN17f87znGTZgQ1iQNl+GGEwqWIc41Q9xj8sK
 DfyJecdWE959QjwuZyaBnSM+vE6FugyaroNLC0kP3LOELbItMusbMYO1ugLEWG+OsaFv
 qbggafHWHB+DEa8Sq+B/TKTXwB92AKxpuTKXa/nF/2kBlNaJ7SIa0ze/yPeYsFTbS+J/
 8yKR58CDFglbiuSc5joApMXrEP5H7hGoTSXTJuwH93SU6/Xfot8kCKBrN1Rt6IfUsZ7e
 U5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620637; x=1795225437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ln/RngDaBKEnJFXqfKaXLiW2drDb5LIdcMJafwzjtfA=;
 b=tcz5tz70xl1rryATHSHDjdecJA6yK6LB8ilIwWSMwVIb2Ojjp6WQEkKp6YLr09Wos3
 2YMboaePQaVArQaUmFLhVcCrVZ0TyGuWV4nCqGt1IP50YK9wCZovypxk91RnsnwwTtEO
 xHAikAC0zfxXhnz8ZRq/85SC4gHpbuqHS0Rnx80S+exZHlanwa2oOx7clDTywrhTo2ha
 TNHIATKacz5Kbv3NkRbX2C4BhzsAPC2WDw8dTgxdi05EJEUTsz1ID1/cdLQtnWPQrJJB
 2LeVfR3rbA5a77OMeUN+tlZW0bL8wYMNDoIb1eG9sxgybINoKO/tP9CY5eRorKSX3X/S
 HePA==
X-Forwarded-Encrypted: i=1;
 AL+hErHFYTGq0acMRV5un76PAu3KNEAv4NamCytqeY5TO1bztpwNHgh5SB/QcRT2/TZJrQs/TRG4FnTC8Lg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zQEHAoMYkYHUa64lVzcwINPTTYel3L2YqozQEafGlPm7WBxKx
 DczRVq56/1YsZsjgehCPHKYZrFF+wUIPZ6wsZ+RuIlNfXxEW20k97923
X-Gm-Gg: AYBFou1XRlTD6B2l9bfxKjwC7NRjosCaz6epUUSP1CSHTq4sxhcP+G1MS/4ojeQF98R
 rUylFCrfIZ8xYKUM1/jDo/KFEs3LmWt0liR86pmvXZzcsOUtfG6bGxv/db/p8cUp3oR1nCBlVa5
 OjpWfq5LdyZ9KOhtmeje1LPoJeXTA7sxLT9Gh56tKo45w6n0Np4NVeBDu1f+p15aOj3QNbKNoBh
 QoXdQDWATFDTXi+L3shOFZzaruxxtKomTTca5f7MgwP993aBIhvC11pNLqzVCcrQB9Ny+34apBQ
 BOUJxqbjDCUS/s9ry2yFRUgRPQODZJvPLDQKO2VZ/hWB+88p7vVX6OQDNwqHYXUSfRrXKMMwm9O
 Og8GhS1fEwO6BwNBBKbS6N6v/pAmcaifNO7L2IzjPkK9yj9+cmI0ctFD/DzMDNQMc3xdPI/T7vg
 qTBjhDBVsRzt4hgsARJwb7+s8L7dClIHQMjZBVPpC018c+t622bKP8JAjMERnBaZsGA8bCuOWVX
 jDwzqgqhiDBeYFmya5U37ciOdLuF8ly0RywjyvzRAZv04tEgfmOP/sSj9WB1iKMcMSSc+MH0fTO
 iEZViPJNbofQu4tDespziJvaJo6bZmQpBG8AJvJYKiUyWGMROsXWLTfyqkvQQrBfUR/35RBNtC9
 uwwpKjUSPw20IPZnuD/IgvFk=
X-Received: by 2002:a17:907:849:b0:c2e:7fe7:2898 with SMTP id
 a640c23a62f3a-c509634b3fcmr384987366b.12.1794620637178; 
 Fri, 13 Nov 2026 17:43:57 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:43:56 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 1/7] drm/i915/panel: Fix the pixel clock overflow in the VRR
 vtotal
Date: Sat, 14 Nov 2026 04:43:29 +0300
Message-ID: <20261114014335.2132756-2-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114014335.2132756-1-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

intel_panel_compute_config_vrr() multiplies the pixel clock in kHz by
1000 in a signed int. A 3840x2400@240 timing has a 2342.4 MHz pixel
clock, the product overflows, and the vertical total computed for a
refresh rate other than that of the fixed mode comes out negative.

Do the multiplication in 64 bits.

This needs a fixed mode above 2147 MHz, so one that uses the joiner,
inside the VRR range of the panel, and a request for another refresh
rate that ends up on that fixed mode, as the allow_modeset=false path
does for a mode that is VRR compatible with the current one.

Fixes: a2da67028cd0 ("drm/i915: Allow arbitrary refresh rates with VRR eDP panels")
Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b3..157be3153c7e 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -277,8 +277,8 @@ static int intel_panel_compute_config_vrr(struct intel_atomic_state *state,
 		int vsync_end_offset = adjusted_mode->vtotal - adjusted_mode->vsync_end;
 
 		adjusted_mode->vtotal =
-			DIV_ROUND_CLOSEST(adjusted_mode->clock * 1000,
-					  adjusted_mode->htotal * vrefresh);
+			DIV_ROUND_CLOSEST_ULL(mul_u32_u32(adjusted_mode->clock, 1000),
+					      adjusted_mode->htotal * vrefresh);
 
 		adjusted_mode->vsync_start = adjusted_mode->vtotal - vsync_start_offset;
 		adjusted_mode->vsync_end = adjusted_mode->vtotal - vsync_end_offset;
-- 
2.56.0

