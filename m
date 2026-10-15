Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C423CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AA111205C;
	Thu, 15 Oct 2026 16:15:11 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2E51120FA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:51:51 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so48484685e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792072310; x=1792677110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pb2lT+n+6HQvd1ljvbTw9518TzY0iE2FdURBlgBDLT4=;
 b=FAdk6iLPbdAuk13+GHTeExoxjoTqShQtN2qqvVX5989CULqRKPVmf/rNvRjzzbOcD3
 qAywe5jfF4DUGs30k61ZsGfIloKLrU16SmRsqAuuoV0oeqbVV+YI8PZ1NhRchdsBotga
 qSE9BrwDwJ1FlIDiSCgvoHKWj9so0FBKj4SsrZv9A2cwOSe7jhnFkI+JUFv9H4wKY0k4
 daXo4G9IDrPQBnNz4p+7G+JX5C+DZzloFqul9Tikr0uF4WzT2urRka0iUH4aUkvtfrum
 spyH/nvcPz2jur7Q+dPo+nUmMkEPsi1h4R5F7/vaFRWytdecOqDSB1RecoT0YZbJjHQZ
 ctlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072310; x=1792677110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pb2lT+n+6HQvd1ljvbTw9518TzY0iE2FdURBlgBDLT4=;
 b=r3jjzB12b18dvlZxO0EXZgB3iTkuhphIoFSIUMHMGEQRjiM9J9K5yd0HYzWOA9I2h5
 rHb6poeBeuOPdeKvlqm7wJ0N4SVFlScbkFCQ1ebW9j3egZPSM0jiWV2b7uaSq2ui9GIu
 A6b1PzP+aHpgt8p7EdUc3zKwsZKBbPNjcQSK4ef1NUeCC80LtnglWL0D3Q6qvzFvhs0c
 OEfIDXEAGr6mWK+kTfaE+eE8/slwiYZVzphtKLBkdMCXbIlji7TU8QxfrckHb+sVvFxK
 Ivluf0e3xk46Y/rkcVbY75C2WRZFfw4E2Rvf874dYnxc/N3hZNp7IEN0rh6eRplSK2Zd
 KxLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI+ySqyA7zEpo1sik4fFc2qM2EFiDjODyrLgNYrfCC+iaDytqAeRD15vMNfeq9WS6sV936K6oL9u4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLr06xVGXbQYeLOYx2BrFf+igNy9wm1ehf9BUuzgRMtjc7OI5H5
 drdUrBQi3XeH/lr/PTHIJluJExgY2KRgjfkKUf4vfobJnMIFq6Y9ZKo=
X-Gm-Gg: AYBFou0FkPpGY0S1zB8XBo+0AqxK5HrFg6jPnpW2KFyPqLyZ+CwM/snOST1Pg8Ehpdk
 samrxVTUwEo3asAnNUBB8oko9EB+cuLRPLoNRuwOaNFGzlnmyO2QAgfK+zrzM4aRILwKnRrU37D
 Ofk84LlAm+za2mLaxc2oKxxhBus2aKzc6ad98iQRAO/HbsmdhRYPfMl5HRO1y9va3Te88QmzAaB
 iN9KXj9L3NQS1P3s8mQIw4nlgXL4jlywpsP6ftYtzCvtf0KXNi/RKUTdgdxFBjqEQoiDSOyGnJ9
 iZzyttOx5wjdCOZ/UYx/9wG2hJjKkdP0LkepGIbP5JLO2mL58EoPM/ftcej9QmDj7O52Z/Q4RFw
 QQTHP0O3nNcXlpFHpORTAfoTjTZSUlvrWIjEz2VmZykeatIMdHuGmT0vOjn8w/cS4ajGfR2DkK5
 uQfRJmLWcvDFGczr3crTkU7d2Vz0WB+zZQcSayF5CGkcJeKRGD0O2ovNJkgN+QvB0cJ3JHU3QCN
 xetm3JhTjJ53Cumukzgev/h+zhIcIY7iPbd3PWtVs7SNMC/V32cdZ/7q/oGQvgR6dRyMsDlNg1R
 l2/5j2Ae3jgsFk8LlqWY7Y/Le+qh4pBqbJ8Hv//lhVWu2/MBvNARmTftYqNnJGE5lcwiMS0uTSH
 5xb2jacVtyDNrQA9Y8A==
X-Received: by 2002:a05:600d:644f:10b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4a196611aa3mr240527545e9.29.1792072309564; 
 Thu, 15 Oct 2026 06:51:49 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-5.broadband.mtnet.hr.
 [92.242.248.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm69642565e9.8.2026.10.15.06.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 06:51:49 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH] drm/drm_exec: fix kernel-doc string in drm_exec_retry
Date: Thu, 15 Oct 2026 15:50:29 +0200
Message-ID: <20261015135029.22698-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

Building the documentation currently with make htmldocs gives the
following errors:

  WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not described in 'drm_exec_retry'
  WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')
  WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not described in 'drm_exec_retry'
  WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')

This is because the parameter is defined without the underscore in the
kernel-doc string. Change the parameter name to add the missing
underscore.

Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 include/drm/drm_exec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index cc2937185a9f..ae1d074ade5a 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 
 /**
  * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
- * @exec: drm_exec object
+ * @_exec: drm_exec object
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
-- 
2.56.0

