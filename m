Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6760A2600
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KDKmk1rZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E205D10F6D3;
	Tue, 10 Nov 2026 13:15:45 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605E710F6CD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:34 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b757029223so839448a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316533; x=1794921333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0V44FvUiKl8gCxdVxr4jy7rtjbf/nRu5WgYEJWTezPI=;
 b=KDKmk1rZeOjQh1aTVjG+vZPp0c1mpIXkkJ9o0XJ4A0EHU4jNGMxz48WoZSNwoJpySk
 bCWZula4OxYrIkLSuaIW1Amq7GGSQW3AgUk7uIwUC7v9dWhKmOL8JylarXms0fSolApc
 BXl2iaoMemPHvfh1HP9YSmFEyiLur1cKcqFuTCyVPGjF3Xj1CjiPcIcD5lC66O0heCpI
 ONimatuUKWQdXcQmeoJ3M53gOb2bwLZp0ZQsTk6nEjgAbt3jj5kDNnHW6nbM8CKapFHe
 xjfMy0XCCp44am3nRSAP62ggM0xrIILowMfo4iSB8D+1x0QmI6QiqNsCoDjKwCuZeQgv
 oJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316533; x=1794921333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0V44FvUiKl8gCxdVxr4jy7rtjbf/nRu5WgYEJWTezPI=;
 b=JxI+OkBbCcWH/JRuszVdhkLB9MDo+p/nnHT7oNvFm94CdbgiDcji9fYEByD29f0i9P
 AB6xylzWCF51FP7Jjv531GskdtT7ExcKXO1+GmEz3EUpDPfY6NUQDQ6byvKNq8mF6r+O
 6SkMfuT3o2f9ricDoBAW2nK+amk4XSn7M4d8aWjpfrjryZcd7hApPIUjjs2VTS4nnXIZ
 7Tw1T1zbrMEDNWOAswTBNUwxhXX7SjIPrT0xGLVccoTaAeGQg3XgIR4QYOBrixka7kWz
 clFARxWibYjmB7oz4FJ+OoHvgbQMqC7O6C0Gv3geBErYxZrqIdzTUXfpVQ4mF7EzVGlN
 xasQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH3FsQ2T71vgryMABTkjjMi3NyoQiHu+V60NfgxcZgUKQz6FIsEMqpYwkCjhns4mnpF8L+xVzoVPys=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/PepBWJW/7uEtT1I/sEekjQx/vzDXetI0af9lN9r4+H/eoycC
 fVRB62Y9p4+xEQkAePNHwed26CNV5kj+g+isPND4IArlwcWBP1URaTUy
X-Gm-Gg: AYBFou393DHwRFheoQhrFx9NJiQhYcVYBhgH/jO6oK2HeL+MexP7/N49kob8D28d6Af
 GhgxAYfY1sVFkboXSGVuI3XKBILkc9AigHWkBNVqZ7GozLS07Injs1+Gvk7BEDaSPJL88kSO5r6
 pawstiL/gOhGwoOb6FU3gf+ym/iYYmyUhsEjCRyb3ywC4keMBMEuPyITwGDJpO4k19VA+emhGZD
 JvA0PZ/cNb/MZD6vQUWhOe7jrJ7M97oCmPUJbtNohnVZenDCQ0fkhmr+HaSfmXEZBQOpwkvOnUH
 ddfUaelPnvsFb3te+4tr9+tPEmunURSlpRkw2WhKoPNAqyCRm6KrGK20LmOlFbDsuWg1eogGtQZ
 0L1rNB2VtEHndwxS8sPhFQn40l3JU0GidG1ml0kxmmGw6Y6l4A+xCJUiIhj6Z8zYu4VYgcKIm2h
 I8p/rKezpUGzLpsxMO30xLh10e/huPcBTagKYR6q8UxIq1AzdBuz+34jUwQyRQc5OExyXJr4nvd
 dPVn71XbVqmVYiGwH5aDqIRZg5DYdCe8HFQlub/EJxK6zYHYC+u2FmvFxpdYFL2iDtJOrIALqMB
 2ePHdKNvOOjRA2vf+ajbohivwtmn/gH1/Z16CWhZUmpQJrlF6NUNO6Abk2la8gW+AjqsaUTTKHb
 G
X-Received: by 2002:a05:6402:2047:b0:6b6:f881:b6db with SMTP id
 4fb4d7f45d1cf-6b7565f8de2mr1387154a12.11.1794316532608; 
 Tue, 10 Nov 2026 05:15:32 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:32 -0800 (PST)
From: =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Apply requested TxFFE level right away
 in FRL training
Date: Tue, 10 Nov 2026 14:09:54 +0100
Message-ID: <20261110130956.160024-2-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the sink answers an LTP request with 0xE (next TxFFE level) in
LTS:3, hdmi_frl_perform_link_training() programs the new level only on
the next poll, and only if the sink has set FLT_update again by then.
The sink usually has not, as the driver has just cleared FLT_update.
The sink keeps asking, and current_FFE advances without reaching the
PHY.

A Samsung QE65Q80T (2020) needs one TxFFE step at 10 Gbps x 4, so its
link mostly ends up at 6 Gbps x 3.

Program the requested level right away and drop the deferred
programming.

Fixes: cbb8e2044b9e ("drm/amd/display: Add DC link support for FRL")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrzej Piątyszek <andrzej.piatyszek@gmail.com>
---
 .../display/dc/link/protocols/link_hdmi_frl.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 960f18fe2..78e62bfec 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -640,26 +640,6 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				prev_flt_update = scdc_update.fields.FLT_UPDATE;
 			}
 
-			/*Set TxFFE = TxFFE0*/
-			/*Program FFE_Levels - scdc_config has this field at 0 */
-			if (override_FFE) {
-				if (current_FFE == 0)
-					dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
-							test_req.fields.TXFFE_DEEMPHASIS,
-							test_req.fields.TXFFE_PRESHOOT,
-							test_req.fields.TXFFE_NOFFE,
-							link_settings);
-				else {
-					if (scdc_update.fields.FLT_UPDATE)
-						dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
-								test_req.fields.TXFFE_DEEMPHASIS,
-								test_req.fields.TXFFE_PRESHOOT,
-								test_req.fields.TXFFE_NOFFE,
-								link_settings);
-				}
-				FRL_INFO("FRL LINK TRAINING:  TxFFE = %d.\n", current_FFE);
-				override_FFE = false;
-			}
 			if (scdc_update.fields.FLT_UPDATE) {
 				offset = HDMI_SCDC_LTP_REQ;
 				link_query_ddc_data(ddc_service, slave_address,
@@ -749,6 +729,19 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 					ln1_pattern = pre_ln1_pattern;
 					ln2_pattern = pre_ln2_pattern;
 					ln3_pattern = pre_ln3_pattern;
+
+					/*
+					 * The sink re-evaluates the link as soon as FLT_update
+					 * is cleared, so program the requested level now.
+					 */
+					dio_link_enc->funcs->prog_eq_setting(dio_link_enc,
+							current_FFE,
+							test_req.fields.TXFFE_DEEMPHASIS,
+							test_req.fields.TXFFE_PRESHOOT,
+							test_req.fields.TXFFE_NOFFE,
+							link_settings);
+					FRL_INFO("FRL LINK TRAINING:  TxFFE = %d.\n", current_FFE);
+					override_FFE = false;
 				}
 
 				FRL_INFO("FRL LINK TRAINING:  Setting Training Pattern [ln0,ln1,ln2,ln3] = [%d,%d,%d,%d].\n",
-- 
2.56.0

