Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64A606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AILszQfw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC31112715;
	Thu, 19 Nov 2026 21:26:50 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D2110F0B7
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:26:40 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-8b2d14968c9so2425607b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795123599; x=1795728399; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vY24YozXGGsZy0MbrhPHZ+OQZbKbtp3K5o/Zm2P/mac=;
 b=AILszQfweAah0skn796ecmiCmetuAvQqB+lOZHYIEJjR35qPISsXJL3w0mcpphh2gP
 C2Tj0h2dJYVnFuxU2O4/XccGIqFkwFUzI/MyGZnYQ4rkvhLm53Vsw27Ca4uehzcAZUM9
 yTYj1hzLF6PR40Y4g0G/MaZ6yW+VKYcveVU0ZiJS1NFrm0kkjDUHhdA5FA0zm5mfH+O6
 w5g9c6dh8Td931hC+iYYL1OiW2uXNjLZRm38yPTUri3RrzWKDs8JpwXIZrfSYjKN2APZ
 TwPmRKGb+90W4BALdPkpRDAh7L0/Sbay8EUGzGMWkxZc7rQijBJSNLdGWTrZ5SxraSWa
 asSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795123599; x=1795728399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vY24YozXGGsZy0MbrhPHZ+OQZbKbtp3K5o/Zm2P/mac=;
 b=Zr35Kz46/h1yBf2hFhRiYgqMq36iU4czvACU+OcjfgkxPLeGVVpjsKstYz7DPs3/fA
 xKAvqWFP3O0qRH11IUzgEjv3wMta2XgQeVGBHvWsLZVwVvYcf2Q4FVLtQHQznTpuNOIf
 Et8FrLOtQY5njqwJBZBzde5WDbb5ew5+4fEPmtK4g/bdwpjqLyI4aazGp1+xKHsvZrNA
 hxw5KJzQDibpwibb/u/9LsKMK3KDfq7ltSEpb9TpyTAjWBDE/8zmBG2so1Qf+PlC4yNw
 l+XjTprdP2sajtwX6vtHFPP+G800WLbe1TDgd9B+F2b0y1nv10eeD55qLV3ICS0yVtGc
 JGNw==
X-Forwarded-Encrypted: i=1;
 AL+hErG1TMXkKimANRBl6BWRsTMbTEP4m5fFDUiRObnTA/AoYkrMddMm0KJ0NZ21JOmwCE9zSmg8sLrVAz8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/I1NU786bwF/TfRT+uJ/+EtYweMaxzbn/bTXVsOWQTp++43vFS
 edflNTOwd4gPoAsvH/JJK0x3EQFI4mBO0IPieYMsFEmjZy3Deq09gaYj
X-Gm-Gg: AZFdTZc/NwF3s23wQQ2qWrbzZF5kYEI54Z1ERxdZ96TGvWZNJtPXfPTIP5p33WqllfD
 L9IbE1pRwkmLLON8OnXPJmuvDOqP2JkR874T12rYA7IZGOhaWkD3TcNNVCBYyt17leaY+/YpXa8
 Q6R5CLkdIHmfVSrFqtv6vQJx0ZRGWcQIfAoRA32AyFEEn4UHpo/8a5qSe0gkMJIurV6CjfB1GNJ
 vWV9eLbLdDxLr76hFMslC4dmXce+5P4nFfflHx4sculxzOoYMf0G2BCwqAuQAxsIJLlMR1jxLbv
 8KkSgeHzolaClc38VUAjbRZHVHCazaiFZx78yekvu/NeYQJ41ij8d7a+TSIXgueZbtt1+jGumc2
 JFty0ncQLTVyDxNoMlwJUhldfaKGsMzOpjsyQahhTFwfn3vtq0J6t1+OpzCOtJvBnxqH9yW458I
 C867yY1uS2NhZdUr1vIS4UufztZHwwt2RdseGh0AYJwY9aJlR1L8EogvISilhbQdJEypJHXAlaq
 T+aWBkaIJ8vFbnjWUPZ+nSQ9j5TH51Xe/Tct5RFcFvjrGa8zEVqzIoFndB2IXoqoD8/k7YlM/9G
 wORZ9s6hPbo2gbhKHFbcq6eveATZVAxQ1c+R67EWIXEMbiCsQaxC5RyYe2PwYK2K6DLVmxUBgGD
 0Q2EvGAtQ6g3/KxhYEB6URHEp6APACUAJ3Y0SBPTprw==
X-Received: by 2002:a05:690c:316:b0:8b3:5f18:7f81 with SMTP id
 00721157ae682-8b52050fc52mr3650177b3.65.1795123599062; 
 Thu, 19 Nov 2026 13:26:39 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52034f7absm5433547b3.41.2026.11.19.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 13:26:37 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 19 Nov 2026 16:26:33 -0500
Subject: [PATCH 2/2] drm/nouveau/dispnv04: Allow PMU sleep on iMac G4 with
 NV34M
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-nouveau-pmac-sleep-v1-2-360c08654a25@gmail.com>
References: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
In-Reply-To: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jUk7WaGILTaMpFlfNkLk0zUgL4/Qx/PtclGtgMowS9g=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3ZYpb/48E8ur2630aPo/M74qovXY81+e/7wfLG9Y
 eszTpmpHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPN1XqGX0xMx6zelE
 0P35yvGG3dEMGy8orEjJUFomuu6JspK+/5I8HI0Lom0KPKNuDA5levn8l/2ax5PGOvlOPbc99Lz
 7/RErnizAYA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerMac6,1 and similar boards are flagged PMAC_MB_MAY_SLEEP. They
only offer PMU sleep (mem_sleep "deep") once a video driver calls
pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE) to say it can bring the
display back after the GPU loses power. radeonfb and aty128fb do this,
nouveau does not, so with nouveau only s2idle is available.

nouveau resumes the NV34M (10de:0329) in the iMac G4 correctly: it runs
the VBIOS init tables and restores the mode. With the previous patch,
the backlight PWM is restored too. Make the call for that GPU.

Other GPUs are left out because they have not been tested.

When nouveau is built in it probes before via-pmu registers its
suspend ops, so "deep" is offered from boot. With nouveau as a module
it is not, because the valid states are computed only once, in
suspend_set_ops(). radeonfb as a module has the same limitation.

Tested on an iMac G4 (PowerMac6,1, 7448, NV34M) with nouveau built in:
one suspend to RAM, woken with the power button. The console came back
with the backlight on and no errors in dmesg.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index 7d44d18e1b88..b4f522fbaf64 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -35,6 +35,10 @@
 
 #include <nvif/if0004.h>
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/pmac_feature.h>
+#endif
+
 /* Apple GPUs whose panel backlight is a PWM in NV_PBUS_DEBUG_DUALHEAD_CTL. */
 bool
 nv04_display_has_apple_backlight(struct drm_device *dev)
@@ -330,5 +334,15 @@ nv04_display_create(struct drm_device *dev)
 
 	nouveau_overlay_init(dev);
 
+#ifdef CONFIG_PPC_PMAC
+	/*
+	 * PMAC_MB_MAY_SLEEP boards only offer PMU sleep once the video driver
+	 * says it can restore the display. Resume has only been tested on the
+	 * NV34M.
+	 */
+	if (to_pci_dev(dev->dev)->device == 0x0329)
+		pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, NULL, 0, 1);
+#endif
+
 	return 0;
 }

-- 
2.56.1

