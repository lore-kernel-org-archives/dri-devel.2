Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67494606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2oKww8+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A951C10E049;
	Thu,  5 Nov 2026 22:56:49 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CA010E049
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 22:56:43 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-8256106635eso54938a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 14:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793919403; x=1794524203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3RsdbC2bbI8UhChgtAfOULi3ppDsu1ChEm9HZQL/Z6U=;
 b=L2oKww8+pqE5dx52IsOZioFZaPQ0AYIDlEDeIEho/SwD4/qnnd+2PEwZ+WRhLsaxrt
 IW57pFgB6TR81b+ESc+Y4ECqcblzSPV+ePbodLYYM7Zy91O5iEf+40WmD3/ckRqGh7f+
 xhrJn8HnWlrz5ULjvBqppU6iIMI++zFkb9mPBe/YzDWn55vnonVzbkB7hKwMcdiUBBWz
 WojBx6xWx4R+26bz1hpayRe+zCKj5xUh9M7b7SnyxsvH12e/ZEZNo0y+LRdjzhCuaq4Z
 oWhUJCOBZiPpEgEIw+h0sIPfDz1BiTNr1o0ZKJLwNACGjtm9thQbGDjufJr3GWp1/YtV
 vexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793919403; x=1794524203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3RsdbC2bbI8UhChgtAfOULi3ppDsu1ChEm9HZQL/Z6U=;
 b=Wh/ENbu3Ro48R+/15QtxPnqX1YtYb3UjYE49PlrRbDcLWXR70ibeRBKEmRaCRXh+xR
 y8KRQF+zf32Ms52hjDONPOuRDsnIHaxv84TVhng28oyqS+ib1QBmTju/TVGggFojvvrq
 /Im0jjqn0KISW3/H/DFAcEPBR/wQfCaCEYkW0BeABWpXyub/q/Uivbvc1UrV6QFq3VJg
 LzQbr5qQTiZpS9ovEwKUVUeQ59rxXvIPVRrs7knbZT49NYbcxZJLw95Ha7Uc+ssg6rFQ
 Z9mNCMyogvxpu5XA6sQq7yCU1/KEQFfWBOHvRw7TPEm024Y++EqPWrDqpZVDj1C80iI+
 jE5A==
X-Gm-Message-State: APuU4Z+lEt9+5awpcXqDSIWs0EHSDRSAvsA0VvGCIV88JxucmAgApZ4Q
 c9bju9plMtjf+JbsKquPIJz5+r54oz9joFIQrzf3x5pY/rAEd+pXoExg
X-Gm-Gg: AYBFou3K2Nk6x0LYwtYnEDtyYojrH9y84pSMd/KO1cZFxkA1xN8AtIkXCoRKh+ibrWD
 H3d/sZsFYJ7f5biK4L7zrVcta0pv0oDvITpKyoc0E/XRcQPr42+HMq5JqNzCrrpeX63UF66ccaL
 5HL6G3qnu1PMVWdguY5LjG5e0eqzobL5enejwmdBHwOU7wJg8bM6kGGqjEzK2SdX7Gq/zi5Ran9
 TvjoAt4FhB7MQUt4ywR0ozYo6z5dlqkLADywmknfQHMTGxENjDGYyN+r7HG17Ov0b+eRlC/LHSe
 Uil+zSQ9KAgDRCuv3agurIPGFAN6SOtq77wG5vWY3POLrPryyg6+STtRwH0aSSKOkULEhMSt9Dq
 pv5D0JdsQZfia6ufSWlE9q8ESDR0Z7/prd+UFRl39Z/1P7XLcrn9u0G/1642PE4l8mlEuGmwCMF
 PsKmUZDBmkqqQM4rRDtdkG+gfymxyGPE7Pu5HHhrGLT5KdkQzDFV0iImsEVylG3bel1U0wF41sW
 Qu2lz/qISVovRdZvCBL7p7b6CWu3e+sNCphj1vHrn9qCDr92iz21HD/eWqUUna7hrqdcOZZcoGy
 lNP+7EnHIhxaywG4via0bgB1Getn02IWvsfv8njltgB1dqkFW6N5iADvIepfJrHC76SvZK7fpSG
 Ws5S+1nox6A==
X-Received: by 2002:a05:6830:719c:b0:81c:292f:97a3 with SMTP id
 46e09a7af769-85f1cee5befmr758396a34.5.1793919402763; 
 Thu, 05 Nov 2026 14:56:42 -0800 (PST)
Received: from localhost.localdomain ([72.12.197.23])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dbf3741sm553742a34.9.2026.11.05.14.56.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 14:56:42 -0800 (PST)
From: Aditya Tipre <tipreaditya@gmail.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 sowmiya.s@intel.com, kamil.konieczny@linux.intel.com,
 karthik.b.s@intel.com, swati2.sharma@intel.com, tipreaditya@gmail.com
Subject: [PATCH i-g-t v3 1/2] tests/kms_writeback: Wait for the valid FB ID
 writeback
Date: Thu,  5 Nov 2026 17:56:27 -0500
Message-ID: <20261105225628.4123-1-tipreaditya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <PH7PR11MB6796FA8DDA56651E65E018D2E5682@PH7PR11MB6796.namprd11.prod.outlook.com>
References: <PH7PR11MB6796FA8DDA56651E65E018D2E5682@PH7PR11MB6796.namprd11.prod.outlook.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The positive WRITEBACK_FB_ID test submits a writeback to the common input
framebuffer without requesting or waiting for its completion fence. A
blocking atomic commit does not imply that writeback has finished.

The following pixel-output test fills the same buffer with its reference
color. The earlier writeback can still be modifying it, leaving a mixture
of the old and new contents and causing intermittent checksum failures.
On ARM64 VKMS, a diagnostic run observed the prior fence still unsignalled
and a black row in both the input and the captured output after the input
had been filled red.

Request a fence for the successful FB ID writeback and wait for it before
returning. Only require the returned fence descriptor to be -1 when the
commit fails, so the shared commit helper also accepts this successful
fenced operation. Keep all invalid-parameter checks intact.

Signed-off-by: Aditya Tipre <tipreaditya@gmail.com>
---
New prerequisite in v3:
- Wait for the existing valid FB ID writeback before its target buffer is
  reused as input by the next subtest.

A diagnostic run observed the prior fence still unsignalled and a row of
old black pixels replacing red input pixels. Waiting for the fence removes
this race. The standalone fix passes the four applicable existing subtests
on unfixed and fixed VKMS kernels with one and two CPUs; both XRGB2101010
cases skip.

 tests/kms_writeback.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/kms_writeback.c b/tests/kms_writeback.c
index 7c30e8e..550d603 100644
--- a/tests/kms_writeback.c
+++ b/tests/kms_writeback.c
@@ -228,7 +228,7 @@ static int do_writeback_test(igt_output_t *output, uint32_t fb_id,
 
 	ret = igt_display_try_commit_atomic(display, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
 
-	if (ptr_valid)
+	if (ptr_valid && ret)
 		igt_assert(*out_fence_ptr == -1);
 
 	/* WRITEBACK_FB_ID must always read as zero */
@@ -288,8 +288,12 @@ static void writeback_fb_id(igt_output_t *output, igt_fb_t *valid_fb, igt_fb_t *
 	igt_assert_eq(ret, 0);
 
 	/* Valid output buffer */
-	ret = do_writeback_test(output, valid_fb->fb_id, NULL, false);
+	ret = do_writeback_test(output, valid_fb->fb_id,
+				&output->writeback_out_fence_fd, true);
 	igt_assert_eq(ret, 0);
+
+	/* The next subtest may reuse this buffer as input. */
+	igt_get_and_wait_out_fence(output);
 }
 
 static void fill_fb(igt_fb_t *fb, uint32_t pixel)

base-commit: 454657e58fbcfd6fa8a9db0830aa1652fe6364c2
-- 
2.50.1 (Apple Git-155)

