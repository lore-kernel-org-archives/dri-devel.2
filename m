Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3E4FF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B9F10EF27;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tennr.com header.i=@tennr.com header.b="ZyrjZyNn";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358C310E995
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:58:47 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8eb5ad01402so958408785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennr.com; s=google; t=1777330726; x=1777935526; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:from:content-language:subject:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tTpdXP31L/w3dxQzZkwmCqv09pS8R5zE05I+AiYdQk=;
 b=ZyrjZyNn3ABt3/p4NWXBbNd04lYE0+0jyeIPKvenHpZ9iCeRAYr4W4GNXY/547JpJi
 H8uaVyf4FNFuBCKlwjCm+lZk0gqkQHFKn0q7PATaQvYgwfEBT8fKKSRhVtlcniZkP87T
 r1/GZjICSDu08x01ZsGQ8zwzJJnlko/4P1eLQ32JU1jL6j2aYvYrtbKq1M1sVMsWoYNy
 v086Kt/FQmGY2e/skbHcAJiMqNHPtjslJTIfQC1IRA1K9mcV+TSScVMsHhd8joLOd76w
 9iiainnGLj3e/+bw/wBG+LHeIFnQppcV179NilQSywwh73/oaw/bUDcdz0wM62K+pS17
 KEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777330726; x=1777935526;
 h=content-transfer-encoding:from:content-language:subject:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+tTpdXP31L/w3dxQzZkwmCqv09pS8R5zE05I+AiYdQk=;
 b=lE4VZ+jYfe2SDQJHapJ9m6Ybtr2FCW97rGQWj8qmM4frzH2jF8ikLumwTq4MYPVWWC
 UChxeivMgD4fzYGYt+3uxv+W6jl50Xsocg9hnb3lzb7sTwwRovwrX+FaKkh6LvE2yTO/
 paK84IFsnyldHhElasfxVg8F4uf64NPhNs+k0z5eYsCfEXSMZCFN3t0MlAdWuIIDv5zj
 AVZ3B0s9yj+JkieaFjXhGvVh5gwF9usekUkL9T65W26JS0zzgBNvxlEnX94iBIcJzD53
 kHqUwvigKnheBEibIvFDoX0oupuVVS/f+3zkovG9o9rsLV+k0Paw8Vaf5qQzxKCdZBYT
 oSHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qvlCoYI+H8bLzI6rgcd8PaRRxTJnVUUb8kPZIjJ7b6JpH4cvWZXJRwbZc7VEwxVtQNUhk2hEqaxk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR5J71PdK3lVRNLV9pdSqZSQepVQAwr44uwwNaBcZ/ZA+BHiiE
 f7ZyqDl9OWyzMx6lmQ5qR5rQV8V0+f1gKtJ7R+eicZZXih79j+lS1idGDuMN0z+XMPg=
X-Gm-Gg: AeBDietkdUJ//hKDcfXT73TJ+uWcdm0g3ARKaSZzvgL4f1jKb1a+Uw8x3sOs94pZ1+X
 hsl9ra8f9T5d5gu/ttRCOOEHqYy8u5NAEL6kpo7GqxdkR9r0g2FrUiUUVmxogB3PX0288HlOx6W
 8XtdXL7Vj/6xMghLuZsZ9tDnKcRw+IcED9Yw9MJvylroewC7T11wLiIU3gHgFVMmnev+igEi/Sq
 kW6tnrGyrkImWbKWOsPfUkm794V/JMvX0Q/GjKVDADMzyYbc/1g1F9rww7ptZxBGbBk/zGJMahV
 oZlaxtSdHBK22xSFupbdY6zgytNbth7wCxysEMVe07gpp6HTiOGy9BgTsUdpfu5m1qFGiieD0dU
 aFuwogESl/DmrM1tf793/O2cbp0NEldlMS9Avu+11c0+fN1BIqe2ton3e4FEcM1QQSwYImko4Rz
 LmlRhY8u2+oc6/Nm5qQDwpDksXaYEdpnZpdWwOmnfzlTwsXon6BZ99OAFhKeJP5b7rbyw=
X-Received: by 2002:ac8:58d6:0:b0:50f:b81e:c655 with SMTP id
 d75a77b69052e-5100e1fbae3mr7673691cf.57.1777330725738; 
 Mon, 27 Apr 2026 15:58:45 -0700 (PDT)
Received: from [172.25.10.5] ([104.225.247.194])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e2976bd6sm6538126d6.35.2026.04.27.15.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 15:58:45 -0700 (PDT)
Message-ID: <986650a0-2035-4082-9867-9c5ecd8dbc55@tennr.com>
Date: Mon, 27 Apr 2026 18:58:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/display: simplify FreeSync MCCS capability check
Content-Language: en-US
From: Avi Radinsky <avi.radinsky@tennr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Simplify the FreeSync MCCS capability check by removing a redundant
freesync_vcp_code test. The expression matches Coccinelle's
!A || (A && B) to !A || B simplification without changing behavior.

Fixes: 6f71d5dd3206 ("drm/amd/display: Read sink freesync support via mccs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604270741.pABgRDTb-lkp@intel.com/
Signed-off-by: Avi Radinsky <avi.radinsky@tennr.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e96a12ff2d31..b7fa74a87c1f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13436,7 +13436,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
 		(!sink->edid_caps.freesync_vcp_code ||
-		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
+		!sink->mccs_caps.freesync_supported))
 		freesync_capable = false;
 
 	if (do_mccs && sink->mccs_caps.freesync_supported && freesync_capable)
