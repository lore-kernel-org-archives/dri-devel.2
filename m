Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA727606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YdE4RXLQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C2210EBC8;
	Mon,  2 Nov 2026 08:04:04 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCA210E4E7
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:53:27 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8ad98c3fb15so19625917b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793573606; x=1794178406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s7+GOe5TlTu09tPuJuAXaS5FmzeWJcxHvWMkwG9Tvkg=;
 b=YdE4RXLQB7p3MOkDNcvS0xwLFcxn7qDh8oDiE0owbEY8xTJUaa47yl7MpOPqClCU6T
 YRK59p5tckkXIXFMIbcVg6vHOlWyDmyJx+fPZA9aaC8hv/sR5FFgtlQQteb1SwIkYTaj
 Z8AKAA1T80TwTLu+OCv9NRdM2mth2kUajkw4loyCRqXO3WPshxlRbk+MkS0ty22wgN3Y
 MIbbzniIzdJq9wUvD6BJ4bpmxkfAduejeL97ta81f1KYo7X9gpM2DtNF663q96rhLrqX
 stmIiWSt4Z1qyDUyu9RjWr9m6qSRgIlNjAmVRaPq+daP6WnZW2vA3LGm/UTYyfFXWHUT
 qWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793573606; x=1794178406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s7+GOe5TlTu09tPuJuAXaS5FmzeWJcxHvWMkwG9Tvkg=;
 b=k24BadDZ4B/p1Oe3tJtIUSI8TznKNBbg4zoNieUcj/D6vCAx0qgOXZgWfxrM7hEQlS
 c5AQLNKHx2OtXKY/k7qhKh25LP+v6Tblnj1v1/+bjMpqEpcTRe41lcnAGbTY+NezGYSE
 YiUwtGoLOcqAHqyhgg3T+ulbwaZz8lIX8uawlOyY3b1SFGsi1aBgU/QZvd4jVh70n5pS
 NH4pClL8I0d7XP+1QjlRcyymCuFJ0BjDtdvWqSrdPx0e/iyNxGLQxf6BVybRBddvbexC
 8Db0/hFRhEULVhLi5IlFXDWQUe3z1MXp4w6+MyWFNGpH/m9N0msN0a3SfL1QfrmqQWtR
 qlSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2/6ikPljjjOkMEiYCqQmJ626gi40OI51pUaLZgkIyvxcwKlxwJKjq5VEz1n+dm9VzDK/zNmNEr04=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJdAdF6t8R1glL+R0MOGNJ/sohMiM5Ki40quAUA34bX7CcLzA6y
 wty4ZePJyE6BJTcnjxjtSBoY6a9mk4goZbn1AnUPSLkOpByk42N+2BRU
X-Gm-Gg: AYBFou0qv+eKznLvIANMxSuLvi49KEKCcHVFI9KFAVi2ASXUl2SYpHdMlCfimE+JK28
 VImpzmO9AoQ2FJc21OPJ6LMQycRax10NNbd2B07qb3Vspqni7Tcv74+9iOXOpZYIMMBFAY4taSK
 C6FDpI128NnYxswE5C9XVR/1DtCS6PkK/iP3GTIs3HP7AeMxtfbJUNw6a2mYj17A78xYOLhRy2n
 BsrIo64n8Rz2fIjWQNTRxdHKlbwZZOfs+o57Cz42uH5REGSQfwWOL5XbaXaNQRmlGscyNSvPT4o
 TdFx9UsMpczFA677F/q5akRQFFgK8NfI3tDdJadKkKyDGLDSkVodhAJOZizSdIE0JAyFHOmfwxh
 47MaO+JHwN/F5TsE5mhQUMewxxvMC067FgTXJc0rs+x8PIQ1s3FQaZf8aKVYtD99PRg21wk4phr
 VdDgcCD7CXylo4xfc4V0+OnpjDre2pVo7nI1diIHPQfxWXTu33nWPpabPmd5iI7YeCPFpAzZxAo
 smnMwNLu2X0milIYUXMmX5QNFothXi4b5y9EhrQiO1sWzAHrEu3rHTbVN4qQLXJhfC1eJCiYPU/
 Qhsa4VNRWBSa7hwK0+tE6K4PBAb/fQpZE5phwmqUa/0+C18n538p/rmSf1iGUCzVufVHRjSjpE6
 iGsHei0OypeEiPlLdXlOCjbF4Mw==
X-Received: by 2002:a05:690e:13c9:b0:677:b7a7:ba38 with SMTP id
 956f58d0204a3-67ba4c806b6mr7372011d50.14.1793573605653; 
 Sun, 01 Nov 2026 14:53:25 -0800 (PST)
Received: from tux ([2601:7c0:c37c:135::5a87])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71b70fdsm41846847b3.43.2026.11.01.14.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:53:25 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Riana Tauro <riana.tauro@intel.com>,
	intel-xe@lists.freedesktop.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] drm/xe/xe_ras: Use xe_log_info to avoid passing zero as error
 code
Date: Sun,  1 Nov 2026 16:52:52 -0600
Message-ID: <20261101225252.556741-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_log_err() expects an error code, but in the case 0 branch of
handle_page_offline(), 'ret' is zero. Passing zero to a function
expecting an error code is incorrect.

Switch to xe_log_info() instead so that an error code is not
expected and zero is not passed.

Fixes: 12b427cf8bb0 ("drm/xe/xe_ras: Handle page offline requests for device memory ecc errors")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index db3cbc186a51..7942a2a48887 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -304,9 +304,9 @@ static int handle_page_offline(struct xe_device *xe, u64 page_address, bool noti
 	switch (ret) {
 	case 0:
 		action = XE_RAS_PAGE_ACTION_REMOVE;
-		xe_log_err(xe, DEVICE_MEMORY, ret,
-			   "Poison detected at physical address 0x%llx, page soft-offlined\n",
-			   page_address);
+		xe_log_info(xe, DEVICE_MEMORY,
+			    "Poison detected at physical address 0x%llx, page soft-offlined\n",
+			    page_address);
 		break;
 	case -EIO:
 		xe_log_err(xe, DEVICE_MEMORY, ret,
-- 
Thanks,
ET
https://github.com/sponsors/ethantidmore

