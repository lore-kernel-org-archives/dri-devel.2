Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718E9C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47DB10F8B5;
	Fri,  4 Sep 2026 07:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="plwxu7yG";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BEC10E442
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 17:07:01 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso412a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788455221; x=1789060021; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDFcBw+OAGvI9CgN/45/xQaVNM9WgzSnrhfaFNWW050=;
 b=plwxu7yG4cjkdPE32nruJ7AK+C7QxNwuTBZfgmNbwu/Dv8DK0YHEJROgT7Bvm0QLnC
 5vn5TYoqm+mQoe41rNEWCF1Ohg6KGht87Igv+gMrQ5ZCF5d2BdaVvIP+BOR3A2XWbLKM
 xG2YpUVV5YtLu5EFUMQ++omaIP63dpndOkujDPj+Yu00EgPW7lCwsl+ADTfHwfhI1g5V
 T1yzI/igMLu3yGh1raDlYhFRlh5QpCBfRAOtd0wIn7qZnG8bVax/EGqx26Szh0w/x1Bu
 kCwRCW3kYbnaOFES1HZpfv0E+9n6cx2cNu5v6X0TwmBSwArgNyqz3lB0yBW5GMAlc2rH
 tSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788455221; x=1789060021;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FDFcBw+OAGvI9CgN/45/xQaVNM9WgzSnrhfaFNWW050=;
 b=eOmvm5jaYTjsm77fQjVSCG99VDnNrosSrreCsOcdzp7nj2Ttw0ui5u3ZyNL0zvX36y
 YK6nG+s3pdcD4GWE/bwvuFnhT3I16teVTi93xdlSeeKhpiSdCP25xvA6jllV96JSEHeT
 PXM+eZbafTAcsA9R6yB1LynsmqaMTMQ9W1m3jCHzej43zLLhxSFfLuA7UCegV3RpTmbj
 XhH3f0ZwrFP4XNPlku9boFQxoAQDqDN1I5OU5C1gcOEwf5ycvNbW/SfnWX1A1XBy2lx1
 HsJZVgKpsnIY2uo6i11nxSlD9QUaV9GW515xFhHqIN0+SOiym+I+mzopMWwyB11WVjpp
 Ek5g==
X-Gm-Message-State: AFuF++m1Zjdd4gjZR9yQEoBfmm2zvZbbN5y5ST6LrT9Nxf6/ty2N5L8F
 t8KLR1AWha5YGKJhFNRt84WhSx7abhSNU5ZEehukgHrWrMI4JBP7n4JV
X-Gm-Gg: AYBFou3r/w9aC+hMfLIiqAb88yb/jpydlK49S/mCHtGRcXOeTsgeAVsR3ZJetOpp5xQ
 WzR0RwAMoJUdHcaAs05T/NMPv+rfT1FCH12hDh2tH5eRSLGb6EY06VFbdhIdkFIeQJowmkeb55c
 sIJ8i/bXwPQSj1NpiIh4+3lU4zT1py93xVrwC2dm9iwEnI3/lirGmlbi1qUgbSzhRXOy/Kgp4s2
 wIKsVRDtsdLpjSUGJhUy3oyX91wQStyLjuVwvIJ/TrKpFdAaT88TMn6Snu76ghYjpxEegVKW2bJ
 Bd31OiLyc+mci0vjorox6xxmje9gnJI8b0S2JfpMCEULvfIZlgWYXRfE3c7ANcScF2NYan0bKqN
 Qys/kw3PXwA8Rx7WIRmY1E5Zizm0+cuABLkJTegfM5B2PyFNWU/tRN+IIj+TvycwrmE6JGkroyJ
 sRsFkNVyux38bT5tflLSWhyp5NEEuAditMguCs38zx3pfbLeBGlqs5TrIikIfiM+OQfQ==
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39aee219427mr20003360a91.18.1788455221096; 
 Thu, 03 Sep 2026 10:07:01 -0700 (PDT)
Received: from [100.87.176.22] ([112.133.220.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432435648esm891560c88.5.2026.09.03.10.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:07:00 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Thu, 03 Sep 2026 22:34:38 +0530
Subject: [PATCH] Documentation/gpu: Fix spelling mistakes in todo gpu doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-docs-gpu-todo-v1-1-be712c8f67a0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNj3ZT85GLd9IJS3ZL8lHxdY0NDQ7NkMxNTC3MTJaCegqLUtMwKsHn
 RsbW1AK0AuWhfAAAA
X-Change-ID: 20260903-docs-gpu-todo-31116c645874
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788455216; l=2678;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=mwjS1qJDm5Rrnz3Is+AgPi54s75JfFcvKNHxNEqcXXI=;
 b=5IWOsWt9xiohCr8FqZ9h6JG87i/4Ds/tmjR+ndAiXtH1mAt27ALWop+qT8AA+3ER/f4AdBiOL
 nkusp+c/CarBjOJZhGw4YlrhF9zBSwGWupOkbvtDzFtfSi9Mt8D2CmW
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

Fix some obvious typos in the todo.rst doc.

Correct spellings of incorrect words.
Fix an article usage.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 Documentation/gpu/todo.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 14cf37590..187932554 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -277,8 +277,8 @@ Various hold-ups:
 - Need to switch to drm_gem_fb_create(), as now drm_gem_fb_create() checks for
   valid formats for atomic drivers.
 
-- Many drivers subclass drm_framebuffer, we'd need a embedding compatible
-  version of the varios drm_gem_fb_create functions. Maybe called
+- Many drivers subclass drm_framebuffer, we'd need an embedding compatible
+  version of the various drm_gem_fb_create functions. Maybe called
   drm_gem_fb_create/_with_dirty/_with_funcs as needed.
 
 Contact: Simona Vetter
@@ -303,7 +303,7 @@ everything after it has done the write-protect/mkwrite trickery:
 
       vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
 
-- Set the mkwrite and fsync callbacks with similar implementions to the core
+- Set the mkwrite and fsync callbacks with similar implementations to the core
   fbdev defio stuff. These should all work on plain ptes, they don't actually
   require a struct page.  uff. These should all work on plain ptes, they don't
   actually require a struct page.
@@ -465,7 +465,7 @@ be turned into a WARN_ON() or somehow made louder.
 At the moment, we expect that we may still encounter the warnings in the
 drm_panel core when using panel-simple and panel-edp. Since those panel
 drivers are used with a lot of different DRM modeset drivers they still
-make an extra effort to disable/unprepare the panel themsevles at shutdown
+make an extra effort to disable/unprepare the panel themselves at shutdown
 time. Specifically we could still encounter those warnings if the panel
 driver gets shutdown() _before_ the DRM modeset driver and the DRM modeset
 driver properly calls drm_atomic_helper_shutdown() in its own shutdown()
@@ -891,7 +891,7 @@ Querying errors from drm_syncobj
 ================================
 
 The drm_syncobj container can be used by driver independent code to signal
-complection of submission.
+completion of submission.
 
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.

---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260903-docs-gpu-todo-31116c645874

Best regards,
-- 
Hardik Kumar <hardikxk@gmail.com>

