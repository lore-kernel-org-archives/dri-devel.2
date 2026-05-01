Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB1CD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0581E10E96E;
	Tue,  5 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQbD8pvN";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92AB10F5E7
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:43:16 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8acb09ddbf6so38261506d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777668195; x=1778272995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p5E1HOqyqOzDx9CBzmKmUlb5e5nYghOLHEYeoL69u9Y=;
 b=SQbD8pvNq/MhJy4CnC3J4pG1iradoiMocTIkrJu+lnG8hvEFuGXUyLf+yfjUaEZBiu
 /ZpbIgblNuOg30WJ/IJV9Dbk5I5sqtCu7aq0CnOV9EwjoV7dOZRwI4moC4vvO28H7itl
 ZGRd4d22zh6CF+Ko2G3ztPMTtS+jus89nVPmn0wmHj/SfvtGE9tFESN4LIlQe1Z316eL
 /ci5lpcWQjtmxDdpJA8WQz8c2XPiyRZOs/9SUkjn1OjO86l2aH/RkIV2KBAiUqgx3eC6
 +RuXFaXwhGfn4cdM9NklFUja+iboULradsqxASjEl4o0DVrl+hU8xi9Xuj5gu9zP+sOm
 n4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777668195; x=1778272995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5E1HOqyqOzDx9CBzmKmUlb5e5nYghOLHEYeoL69u9Y=;
 b=JMlkMfyLBnq3vT2mzli91jdCCFJE9WIuLbEH06VzB8Xn7rUHWF9LKrmb8n2MeH3hdK
 gnmKkpDbbqBLh4ZQsjlbqSIIkkXz3YLmgy06BNybPB2ju2egi50kVSqZ2O8pA3HiUSBN
 PQohTjL7H9FgV8QhU9rPGNdgpmKKNX/s0BsEteI9YidEkcU5quYxL5lgq2MgQU2+dCA0
 seSr5xGNZae4AcMSM03KyVi2dp6qH/Mr8b6d/KcyJnfs4Bey7xQ328BRQfO+NazjRSJi
 bZ0CQeD9yaWbm2Mab/5g1tzFOZJyQ8j6OKVWX/AUzdBrvINDFimAmd7fQXcYHce2XY2J
 0wsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mJhyXTCTOkxnOQWNRFS1c0nM41k7JD9y4XyeFhpU9ZyO+FHTeVPibs5JwNHCWPt3MYBd5Wbg+L2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQWCzy0RcJFq4c6/sepuGRLzz06OAiZWasxal1h+21TDT9F41t
 Z6rHkemt0lxMhInSIzpV4pIgT8KKCxzURpriYJQoCf/UgCWbVc8UQQoT
X-Gm-Gg: AeBDietsPEQZt1QsmFCesNSDUOWKg+/ZjfE8Zq8BIEoqF//fIpQ0WMvIPQtbKIn+dZH
 Wxd/rYDnIVhMarMx6gl8tdaDUyLjZnjnRu6Tw/w1SJTqAtgpXY1JvyzFvct1HMW8pSKXc+1xF9T
 Dh3gi3cHM52OVrKdGjbjBXPxXX4jHAwlcZQ0C+fdRR0EBXuVtUf0AwSNVE1uNBjKOA/UH4rRuLa
 1JZhxrhQTDejrpGywB8imKnt5ydPm16ng2Hijmo1Ql2QbPDWXb4O3Mlx/VnWZAbOG1qlnplG3Mu
 6jtoHzNTB6cRxq4R+8hSuTGP6Yvq6eZwV55r/4LzZRYjGesSn1BZ5Ty31W/dvtQ7d985AMNzEU8
 oCpERuAosa4a+sx06RoZsi3Q62uRtdqLZF135oRlhBOFhqXO4J31IapJa8VALibnP/vKE91Av1j
 /Vo169ixAJPJX9T88dEUqqszKUWilV2kIRM1UGwUAnSGGBQF2BVjoSLb3vIa94u94Olp0=
X-Received: by 2002:a0c:f10c:0:b0:89c:de0e:263b with SMTP id
 6a1803df08f44-8b6694eb760mr15323986d6.42.1777668195439; 
 Fri, 01 May 2026 13:43:15 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.5])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b5390ec38asm33730096d6.11.2026.05.01.13.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 13:43:14 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mike Marciniszyn <mmarcini@meta.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/fbdev-helper: Fix deletion of stub for
 drm_fb_helper_gem_is_fb()
Date: Fri,  1 May 2026 16:43:13 -0400
Message-ID: <20260501204313.127616-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

From: Mike Marciniszyn <mmarcini@meta.com>

When CONFIG_DRM_FBDEV_EMULATION  is not defined this error results
when building amdgpu_display.c with CONFIG_DRM_AMDGPU:

error: call to undeclared function 'drm_fb_helper_gem_is_fb'; ISO C99 and
later do not support implicit function
declarations [-Wimplicit-function-declaration]

 1777 |  if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {

Cc: stable@vger.kernel.org
Signed-off-by: Mike Marciniszyn <mmarcini@meta.com>
---
 include/drm/drm_fb_helper.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bf391903443d..7f9ad421af3f 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -273,6 +273,13 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
 bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
 			     const struct drm_gem_object *obj);
+#else
+static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+					   const struct drm_gem_object *obj)
+{
+	return false;
+}
+
 #endif

 #endif
--
2.43.0

