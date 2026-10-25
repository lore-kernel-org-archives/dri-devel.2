Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38E606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OZRGjPzc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A19F10E682;
	Sun, 25 Oct 2026 04:04:28 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD4910E683
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:04:22 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-156cbe59622so1286170c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901061; x=1793505861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vQs/9/+ieViMtOkwrXjmCA1Fgb4ppa6TVTluwiw88qI=;
 b=OZRGjPzcpzghXFwZuGQtc2J/yV7NfyBHeVV9rWYn0H8Q+K+AiceRu/GUU37RRUPC3z
 z+GExE09bQDAQO7pHkWFjANR5dFzh3u8mdQMHPk6FRdIo1FSk5vp3U+h+K8AiiMD4aES
 1S3gykQWKWcE76KgFHkc6Z0t2XmiIb2YsQPRBsw/ffGO5ES6EIjokrZPE6ipOju/hxNu
 o/f/GUyK80V1TTyMJjqLwyu3/mGiuztTc6H48Vth/nwzZNaUr9syIEzU5PHHEfDibDQG
 a8jWh8mcNMKgwHAdhr/+sgyE/N+RMBmSB8sSaDCElJyhtZyuj8EQywFlwC8l6fuVhiQw
 iqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901061; x=1793505861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vQs/9/+ieViMtOkwrXjmCA1Fgb4ppa6TVTluwiw88qI=;
 b=nwOsQ7PmXfhqZb4Y6KODXqEuyj/0kqmJ7mva1QJLLKsalxfddffXelW1Ign1VSGTuT
 2Os0JIzzKKNe7olDfyEApaAVCsz2U+DVEKgogFhNa/w5m8l7pU5NA0za8GULQGve3q9Q
 FeWtQX1KzCeSN3eM9+yJ1vFD4G4on0/p5ZS/CzU6IvJuT5S8xU0fGVdPxfQubbUIF/A4
 qxLDV0fsHgHE1t/dlN1JdFZRnRqUDtWq3ykcItkWrycJLs3zuFyJlU0JL3iDRmtlKige
 0c7W2T2V4tlEl8y3AX81mqJ9g2hWNZaO0sraX99m3Xhwy6W1d1+Zq8p9uH2Fb4vLVmYk
 SbZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5kj9r3hc6esOX8R7odN/V2It5x/VBvv8cli0+zPkO9vqpeVZ4kUxenuewH2nQASy0vGCV1jZ3KH8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImI8pAQ10nfcpaDvwFbKpHtXZdPyYcEbOv5OsXMsbccO796x/+
 f+5YAebLxCq7QIFgvuUFc64LBKr8Udz379XZ/YhZaJYEa54t+JEAndM=
X-Gm-Gg: AYBFou0YhmuemZv1mGuCIKfGEy82n+0Z8rpFMgUMz0rHmDJ8t2QbtBkgxpT1L5icD/g
 SGEi+QO1AxzXW59QybrEMZflafUFr0MYyMOBqaWy01k+qlIrK6svjjuMU1XLwGhIAFwe78D5eql
 QmD8AsVHCEoTNVbqQusmCAUc94HZK4jKJRWYnOMUb6cmNVIWRN0vfqpvcM7o9WRNM8KVoQK3tR3
 TZ3dmFVMcN+2/sEzi95TN2SXvIBx4Z/0B6f9me+hJoRNvnso8erCDI+j0xLzwoZAi+Ayrb7BOps
 YCjhO+pkB5+UyQjfs71S7P3Ax8Epvcr6t0guwDuIHfhmGqmpWgp45Hy1SqUQacQotEjRgr7HDqs
 TX2O8VwLBREQPe8PEtXgT9vOoHqoF3iYj1gioWJFQfKe1swUPX06ApfQc8zszHm6ZCLpVWu/1xf
 hrBMNBsmXcKrfqGRy+v8iD2YWULbaEgZpY8Wm7oDJspW8HG/gIqJJyS+dnRfZXyhKuiF2bDRVe9
 ZAzSdY3ecYvVVm9NTVrXzV/9qDjsTRud8stfkGPESaLASlUlC6k6zyEenEVSxmYn22zkDKIfLTR
 4d3hQVJC7+vXmD1+1Xw464rjOxphzNyXXcKr31dG+QDhtbk8PnLW+qY+ZzSJipiGU0HGp+qEUmL
 1huc4+Teqjwk=
X-Received: by 2002:a05:7022:7e0a:b0:15b:afce:62c2 with SMTP id
 a92af1059eb24-19936e39a84mr5336469c88.41.1792901061085; 
 Sat, 24 Oct 2026 21:04:21 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:04:20 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 13/13] drm/amd/display: Skip panel power savings on eDP links
 without a panel
Date: Sat, 24 Oct 2026 23:59:49 -0400
Message-ID: <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andre Eikmeyer <dev@deq.rocks>

When GMUX routes the internal panel to the integrated GPU, the eDP link
of the AMD GPU has no sink. It still exposed panel_power_savings, and
tuned writes it on every switch between AC and battery. Each write sends
a hotplug event and the following connector probe runtime resumes the
GPU that GMUX had powered off. Only create the attribute when the link
has a panel.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 703d0617d..c8fbd2167 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -761,6 +761,9 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
 		return false;
 
+	if (!amdgpu_dm_connector->dc_link->edp_sink_present)
+		return false;
+
 	if (link->panel_type != PANEL_TYPE_LCD && !link->panel_config.cacp.cacp_supported)
 		return false;
 
-- 
2.55.0

