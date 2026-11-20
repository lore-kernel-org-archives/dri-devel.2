Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48195606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyPMsWYf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A714E112BA1;
	Fri, 20 Nov 2026 16:17:38 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C5710E2CF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:42:15 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-9497a167a6aso193877885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795142534; x=1795747334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Nzf7HyGQGJipLzRsxdSMLabv2rUKwLHQTs0uFyn5jw=;
 b=hyPMsWYfacIzGmvCvDqucy9V82id/k87iwhemu6I79jinnfAdw19s8vSlvFK5I5KNd
 WhdLJ59VkupRlUkrb5J6CS17VgnLC3REbNkEoAGUWZVmZNcspvGpCBDflDNBRHu98q92
 7CjnBp2Cde+HpeRikIVsbyTzKW6d9/YzkHseM1xAsvIihK8DPY2Tww4nSyKtq9kC7NzB
 Co90PWcUIuH6AbpFaN7kacE7rQqGmF2PZ3ZHYgrDd5uh7GK9O6BwTox8dP8MSBXmcmvD
 ztJOpit/uy9w+Yr2T0pQv/tjKP+hpHORu7jbK/27dDJcuiRNGaAXnVaC2sWGEElMw1eb
 AyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795142534; x=1795747334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Nzf7HyGQGJipLzRsxdSMLabv2rUKwLHQTs0uFyn5jw=;
 b=Ti4ZhnaWq6sZa7fIKiRNZLIhDzTGnr8PMCIsACPkWFcrN+l4aP9G1869ZcqGuy6IX3
 BrKiYmwsp4m1CQoEmlj/GAKJuwjLy0jHWc5dB+dkwyWE7cZakp/6TbwO1clB1HYSTCGS
 45pkap7GQE7lxqptffLcudIsxVbKfkYM4Yrg5Kfg+I5q54ty4xcNZpZet4YHp3LesAXn
 33c9vTf5WCpFNpUlU6JraI4zBlb7rqYLR9ftrA8XsBpjXcvYGr60qMl4V8nRGi0Z0a2i
 ezBzv8Vgg0qp9Fhs7/NtkVdi6YtIdx6+3RJJAjaECWUu1n8dKYS4DhumHHpFLw+u/N+k
 ub8g==
X-Forwarded-Encrypted: i=1;
 AL+hErGk8tg3J+l33p7Guzuzmu4/XXqh7u3H4/yxCQ6oJHOvpa4RujZzVshJy7KGbXd9NNUDcFtFyGcUVrA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/WeCi4SVC1BaS7PUTLG9tnYIptwQPWCkzeierbpCg3Bjf0eu8
 a4xJkxCO4rlO6eaSCFZpI8Ix8R4WoMXaGjEhh25CGVZynF8iLpNCqQ8P
X-Gm-Gg: AYBFou2PWIR1pfsptR3tBEc3R4tm8HpkAxSMb/mA0vtS1XuQQqC5vkK0Ivq09kzAko7
 IPPZTfUeFD/W6mALIDRxvo1hu2B/i/Z/dVteIJedg7qDsI21rC1qtTwwDK7Dzmm/vaMU1xk6KSt
 Al+RX+t2T+8GG3VtklzQj/1H1OP5J4R0nwghHvMx/e1Tt9H4vFsNvp/WPZrjMA88F6TH+7cLMEW
 NcXfvBJ4vA6NkW3Hv3wH4FvGk1mFBflBylaruJiMQecfIG1/OaDsFqsuiYvBBcWbvitW6PIOLim
 7Yc2f5eGRB6ygTkQeGLxPtlfQ01eBAJnU53UDxf7pAxH8pci9b+z/FSWTkOUPd/ehHbIp7UGXb2
 ZOEfJtw2iRoVBW+xBeAupEocMCRq+w0dyGwVctfo0saUHIu7J+qPJtOyqrG4ds25PL6tcMxtSkN
 wd0LOGMDyMTbNltYzyhWvi3inTjt+vRqO8lXJI+3h5IiIRCKPuIQaGsbRZDt4rVrw81UgWsZP0I
 ydTV5of1h/bfOx6NKJ7ig/brKnnniIFxID4IuBnw1Hdauv49WU7K4weWyO306h3LDILEou2RAxX
 l+RtcOqKLilW7iquUyLmniZdyU/3ZsL42bo2N/FcHTOrDywh7m/3UsjNXIy4SY2A4YrVtaa8Yv0
 =
X-Received: by 2002:a05:620a:2852:b0:949:8014:70e1 with SMTP id
 af79cd13be357-949ba95ad91mr277788285a.6.1795142533878; 
 Thu, 19 Nov 2026 18:42:13 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031617sm100514785a.1.2026.11.19.18.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 18:42:13 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/i915/gem: Set the VM owner before publishing the VM
Date: Thu, 19 Nov 2026 21:42:10 -0500
Message-ID: <20261120024210.1658348-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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

i915_gem_vm_create_ioctl() adds the VM to the file's VM table before
setting its owner (vm.fpriv). A concurrent lookup can therefore see
the VM without an owner and allocate page tables that are missing
from the client's memory accounting. Concurrent VM destruction can
also free the VM before the owner assignment, causing a write to
freed memory.

Set the owner before inserting the VM into the table with xa_alloc().
If xa_alloc() fails, err_put still releases the VM.

Fixes: ca02a0119f81 ("drm/i915: Record which client owns a VM")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig and W=1.

 drivers/gpu/drm/i915/gem/i915_gem_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c58ffa5a8fa6..489b221091d1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1838,6 +1838,8 @@ int i915_gem_vm_create_ioctl(struct drm_device *dev, void *data,
 			goto err_put;
 	}
 
+	ppgtt->vm.fpriv = file_priv;
+
 	err = xa_alloc(&file_priv->vm_xa, &id, &ppgtt->vm,
 		       xa_limit_32b, GFP_KERNEL);
 	if (err)
@@ -1845,7 +1847,6 @@ int i915_gem_vm_create_ioctl(struct drm_device *dev, void *data,
 
 	GEM_BUG_ON(id == 0); /* reserved for invalid/unassigned ppgtt */
 	args->vm_id = id;
-	ppgtt->vm.fpriv = file_priv;
 	return 0;
 
 err_put:

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.43.0

