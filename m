Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DA606A69C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZG4lFPi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAAE10FA1C;
	Wed, 25 Nov 2026 08:43:14 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E56610E579
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:45:18 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8a594d313a3so3109286b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795535118; x=1796139918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fGnAXl9mAkM8+L7H53FV4IJ0uW8w/+sPQwCsSY5K0ME=;
 b=pZG4lFPinaVHWqjahT+ivMkFPDQOfi+GbECG0KldCvCxOpvjsCFqmpIVSgtCoND516
 +lcD70VzE7UNvN1i66g3xpw/PW0rVmPKzPxgCuuxOX3MVJMYpMca+VrZuKIJjxvVgmTg
 /QnnNS92vvvN+PWGFAhPqHAcQupy9bso7G8hDXyx/fEdGPCxonff+Vu+QrW2nT/D+ao/
 5IFSPUErW/1WkmrwwhPQW9HFYohTN9XZ1tnQgtC5G/X8lZqRq+to8n2NCl1QMmXPkV0F
 33Qo841ucm4Qpu2lLXOZjLR2OsVJbdaTN0jhRN/javV2Aj/GaUqk4toMf7p8IKcrUhJE
 lL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795535118; x=1796139918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fGnAXl9mAkM8+L7H53FV4IJ0uW8w/+sPQwCsSY5K0ME=;
 b=Gt+oWUtFSV+E+mpP3YoasfCkpwbClH+3LdxSCPKaRvQHbO5KRVBOtzfJNBPY7+Hv2R
 OvOOnqDiFwhRgpd4Iy2qHO7mwL2RalD5tc6L/qJvSR6yhlVvac8s7QttBzKe0EtRZL4p
 7HJoSFy43J6V6Jo/7XaV+gYwddb9U8DEmgCcMPH5X1a/W7sG/geFbuOVGKANyNiWYspX
 hLbi0Vo6KXkdV4lzZ2c4Ktz9p1Wg0q10njZjqPNWCoipeXPNUrQd9FQ7wf4ZtWkTcKqi
 /vvIix2wM/rDUuk72d6g24jSC4pLUb8yy7MGdkOfAxwclHuwrem+nPVIncVi691WmS/4
 iWoA==
X-Forwarded-Encrypted: i=1;
 AL+hErGy6gTya+POv1cQ8WgziWT/e5bVjQ0IrkClpYSjPrc4AYidxi8eLX5OWROK2hnFqMBTvFKpagmde54=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/3vGiNpV/DIkBBy23xvz2nyF+GxjXuagnpeeoQwzJJ+tzmt2mW
 Yp4Pvl2BvWObb1gY5Z+iXgHCdBZpCmgl7lpfsX0bcbCHz279LDXUCYm4wVcL70AuIA==
X-Gm-Gg: AZFdTZeE88EaoblgHCivvD+2+d1R/tkt+iTPKVD9aedlobE6z0de99jSqAoTP44rI/f
 XgaZ4raKe121KWJzi6W5P92g6t4fo0NjLhNcIbYHdicPw9AD8j55c29KrrrJdHZrn2fVnxu1EYM
 D+nexw3OTPu+sjCPqNCiHV+C/rG4iG9YOrDrwsif4iKIFsC6CsLVAsAXQdhMbZXvhDpUHMaTJIO
 RELaiDGn2dNT5s8Bl76Rg+3yWLoF5KhNu+RjpAGRbaNYLA8RYgTfPPHBIe+SHUFymxHR9y6C3Te
 SUwXTlnfSS7dA7PZfXKH8vXuduUnzNDqnKkn55lGJFDYr3B+e8X5lcd93vNLwK923JOQGxxZXmI
 bf8F4D73vgOWzuoxjNxcgxZ+mL28taXEVQ1TlRl98cr8GPH/gMgji/B0b2bV+1BFUgKHTjn4PYb
 e+eWG9YXOqp4YFF5KS3agwlcu+7CgxrzJRtR3eJcY7/id2ziJv1PtTsV72IFoP9ubPU1PbZ5zz9
 KLUMtfIaky2xZKibrcsPzjMp0FmGnE3zeF9SUxYQEcMXIhzSCa2UUsyTyAnkkN4rDZjsbTXOSB+
 jZJbqWgx8QJoUr9WaE0eoHAW4UMZW1RMlItnGd7pybRVVSNswOB39WzJwdiUvoNWMhIR
X-Received: by 2002:a05:6a00:a117:b0:8bf:ef6e:1eb5 with SMTP id
 d2e1a72fcca58-8c87d022919mr12535440b3a.43.1795535117471; 
 Tue, 24 Nov 2026 07:45:17 -0800 (PST)
Received: from localhost.localdomain
 ([2406:3003:2002:639c:5da8:85f0:b5f6:2eae])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm7338465b3a.14.2026.11.24.07.45.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 07:45:17 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Yige Jiang <yigejiang86@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] firmware: sysfb: Clear the device pointer on registration
 failure
Date: Tue, 24 Nov 2026 23:45:11 +0800
Message-ID: <confirmed-20261105-25-a16124b5ff57@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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

sysfb_init() stores the legacy framebuffer device in the file-scope pd
pointer before adding its data and registering it. If either operation
fails, the error path drops the allocation reference but leaves pd set.
A later sysfb_disable() then passes this stale pointer to
platform_device_unregister().

Clear pd after releasing the failed device, while disable_lock is still
held. This makes sysfb_unregister() skip it just as it skips an absent
or already unregistered framebuffer.

Fixes: bde376e9de3c ("firmware: sysfb: Add sysfb_disable() helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: x86_64, GCC 14.2.0, W=1, drivers/firmware/sysfb.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/firmware/sysfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c188301afb4a9c9dbdf969828ab9449f6..9cd660a509da939c28e93956d7b6420c794048c1 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -214,6 +214,7 @@ static __init int sysfb_init(void)
 	goto put_device;
 err:
 	platform_device_put(pd);
+	pd = NULL;
 put_device:
 	put_device(parent);
 unlock_mutex:

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
