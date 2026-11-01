Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8A606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V9fCngnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164B010EA07;
	Sun,  1 Nov 2026 11:58:31 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A19310E32E
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 10:48:01 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1931ff67a29so3163364c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793530081; x=1794134881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+aTVbnkfZYsolInJM1P7mrXF8suFhh3kNR1fi3nP4Y4=;
 b=V9fCngnAc65y3frsLHzQNOv++hRbeksVJcw8cGUPdI00cgSBcBT1RUVvbPa4htqBhk
 QyulD/Dn+vSEp7TU4GrVeuO/PdKCfWWLarMFDRc8AKjp94bvSa13lvuBQ91wSSny3mMB
 IIMcucoR2uiXUs5joElraGMRVqn8AjQFo5stDRr1Wc0XUBcRVKbIbEqKTH70roZHCCoe
 +CL7X+yS4VolzaNUvljI2eIUbl11sosFOll3pUbHbcJrHpdF6H49gq4qSt9Ucytst4iq
 /jGMPu4NsGwyAMyIbSSG8s67U40jL2OMPj2IGHi9/JSJWahX//9uh8WL8EPjTOts5BfQ
 mOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793530081; x=1794134881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+aTVbnkfZYsolInJM1P7mrXF8suFhh3kNR1fi3nP4Y4=;
 b=UHkmgfmivV/2h9xSciXy1EAiVngL4BAac/2aZowM4oiug6WbuVoNbYT4K8THjOFC1k
 olIt8zKHDcI4hXc+/Pxpe4jXf8OeoTWqyZaRZimKcOL9nZh1meQ3TaK7otA+y9m/MVHm
 TChbt6APMyFlVRktOXiqVgfjJr1RP5ruMCctuQoJ5dgYXHixC/ZkZXgtfE2mnLFDASqG
 xlteNeS0PNdhSZoThwQdK+zuyMtVwS5qn2L7IjgpcxBNMFUZM3XJZ36iicMhEXkyOQTZ
 RsWRN3r6NzX1ZO6W+QlHTppsdPZzq5DoIohUcUKOR0TykV+jx3rKwsq0eKuINMAAVg2y
 /cyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0k6ACxC40vbdD+kFUAIGG8fTTAJojmtYQQ25T8x88eWFRRl7ku71zjHWHLyl7WbvQgsm/Y6aNlus=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsFKcsNZT7F1+QhpbYlpE1uGjsGikC9Tnupu7SCQcV03NBRsXz
 1bTj8e6ZPCF397Xt82DRTJvKWc1U8B3ofYxbIMJbzEGfrP/Rq6xYsxn9
X-Gm-Gg: AYBFou2yS4pUJntsjCNSUS4B5uHdpGX1u20JwBcWJb5rNaHOXYPtINp2AynzvyLjKI/
 SqN+leDnUcSsAAE4MkPOfTnSI9I9un7Fk7bz3yeKiBGqDh4DW5mdbtNS6GFR3vdloDhQ5ARvYQV
 ycSGX1veahvRmlAJWkt8+Rv/RUncm2a+qcHEdeYv3Wb1ZTPbvFrnET9kEF8jMPlFJOEwExC7phY
 HDnqQ7r2F7Y8jYJ8HN+Lo/iXrVaL97xBPJrr7FZYp2UBrqUCq56wD9svn+06X+gYbaUi04G2vva
 kCE9ea/8O3yOjEm1Cy60slp1KybMybzQ9+pOD7ZMUENaOyazIn2ZD4IhQPSSLnREbAy1jFzD4YP
 /SWsTbsMk/o9uV40ZvgVZzCo+UmIpE35oo9DkNYQ0N6SoPbCJGlXtWN22RD3iOMWzMIBq52gIp8
 cfq3XUeRHYR8YhsqUL+aW7tE1y7YzW3ejuul4f8C1fxRJErQRb4mxyxhjJh+fpAoMb/TGbg5I8L
 AvJ0UupFp6l5wG3NQaVA2ESzKYJj2N7q1zR7eCLiXy9aV9xIY8pocOpoHNoqPU4Stt/gWNU1iLs
 HtkPER5JtFg0gfQq/1qzseSsenRN
X-Received: by 2002:a05:701b:2050:10b0:152:92c6:8b58 with SMTP id
 a92af1059eb24-1ac5c555078mr11436993c88.35.1793530080785; 
 Sun, 01 Nov 2026 02:48:00 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:e7f6:4b7d:197f:48c0])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac19c6b969sm23334554c88.14.2026.11.01.02.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:48:00 -0800 (PST)
From: mdshahid03@gmail.com
To: austin.zheng@amd.com,
	jun.lei@amd.com
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] drm/amd/display: fix USR retraining support check
Date: Sun,  1 Nov 2026 16:17:27 +0530
Message-ID: <20261101104727.141852-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shahid <mdshahid03@gmail.com>

The USR retraining support check tests the address of
USRRetrainingSupport[j] instead of its Boolean value.

Since the address of the array element is non-NULL,the
condition can always true, even when USR retraining is
required but not supported.

This issue is reported by script test_addr.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index a8519f547dce..74cb65687a50 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
 	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
-	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
+	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT: ===============================================\n");
 }
 
-- 
2.43.0

