Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146CB10AB82F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1B110EBA3;
	Thu, 26 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ja+uFaDi";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A2110EB50
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:54 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so637549a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568874; x=1775173674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
 b=ja+uFaDiGS6mu5o+Y5ueUGQ3shfHUXLDKYRJNB8nL9ZDHiY7clOflC4fkB3KNjVApu
 09KRGqpHKTQNmujjYsTPF+QMv4mivAPmvvA7Q3QY5WUqOM5GPeJFqpOFBDPpSBLw13aB
 s6bZY9Ni2M0wgwgxRX485vaCYBItg2IFXYijOrE17i2R9h6Ww9o+P0vrZsrgcp9yv1sd
 g/8kl4YPb4tMoZKJJ8ajM7I+GGPSSI9ur7xUHHOB8/vr4PCahY0RAbpQbL9s/lflBBAP
 iClfG/iap66u4RyrfTTlQozMkuBpKmFf1uba27SbVyqJfBdceZMYTxCgAdPu1ZiGVbu2
 QNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568874; x=1775173674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
 b=TyamT82TBeYIm0ptZ3hGATdMLvbCl3oh1KGcuKomhtp6EFqr4iD7s6zz8fpfjTARTZ
 zYCmH6zdrV75+yLOUuGtAvDAHCEQ1c35F2j7gr93HntIvnDWV6tRqoZDGZXxBfaRxDPK
 PnvGsSclSA2y/wec6CpZ9liUkRPUxY9WeF9pUinRM95+i2YDt1l0Ld6qqh5zmBHyFp+g
 9kkbwioo6GDxDSbvMnO9eouoeO6H16LU44ESoNAqCDDfju9oci56rLeC60+Rs0S5CulI
 05ZoLpFSfTRmy/veXeTwAEaZVIcLQQ2+7odZJEVBIoO7kCNn5KQOVwBuGzKfCTUnACgu
 g4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbNW4eWjUW+rR9hBEGVddPL/4tNh6QG6iB9vMXy02MSySp3wLFd2kIFA5rd//4N2oboTaVjYEU8FI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoglQ1Gugz5pI7Q/HFln1F6m60X/IvBHirWi5edLXfYG+dXGSJ
 ymFuJ8ky1/c35V53oit79dzlAYEpfQ1M1TDT1CuR/s5/Des3OTGf77SX
X-Gm-Gg: ATEYQzwJMX82KTUkWnGK/gsgHpdP+TdlpuBHRpVoXt0w3Re2zzfni3i5g+uVJBPAaWc
 6S8SyN+9voSk6AE4cKA9ndMNSc034eLWHlsWLSgl3tC5giwWFSEngsvxRSEiZet29CKkiAlksVd
 w97Pbpd3p6HaAghHm7ffxmfsK86hqLDNbp5oM4qVgK++vhKa2X5NSuVOEK9aMgOp3+zepT3dxBV
 aBX34tl7h+tmo7CS+97F7hIraTqLfAU0sDFylRW1pkGcRJ5x1EmrWbHtPQ3hkUghcIY/bD/Ld9E
 wcZWS/y0w/8VPZk0VbfyPrbdnZCpjj/em4ujyEPBvmMlcuIO7R3WUCis5kTDTUb+TFbyO6aunD2
 rHraAnAZ1mZfRwoZ15sB2GCyjjPCNHPOJlfJBdoVtnE0MsTD2forrhk0vKAHa54jLqa5ja0/tOQ
 ZgnXjAbBY7HGGa31iY+v5tKwXuwZXuq/O3utud83xMq2P8C+7Gpxqtr4o=
X-Received: by 2002:a05:6a20:94cb:b0:398:9820:f6cc with SMTP id
 adf61e73a8af0-39c87bcf3e0mr492459637.55.1774568874123; 
 Thu, 26 Mar 2026 16:47:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 9/9] drm/amd: Disable ASPM on SI
Date: Thu, 26 Mar 2026 16:47:16 -0700
Message-ID: <20260326234716.16723-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7bdd91abf0cb3ea78160e2e78fb58b12f6a38d55 ]

Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
It's unclear if this is a platform-specific or GPU-specific issue.
Disable ASPM on SI for the time being.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb3c6bfe2e6c..12d7e45a4245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1761,6 +1761,13 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 
 static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 {
+	/* Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
+	 * It's unclear if this is a platform-specific or GPU-specific issue.
+	 * Disable ASPM on SI for the time being.
+	 */
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return true;
+
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-- 
2.53.0

