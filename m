Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB2CCD4F5E
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD74F10EAC6;
	Tue, 19 May 2026 07:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TksMm5Tf";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47BCA10E8EA
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 21:20:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so22608675e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779139212; x=1779744012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eib3eRFzS2+00sCLYIMDe5vm4mlk/dWlRJSkbmyxtqY=;
 b=TksMm5TfdCGVJclcnfxJcT2vlQa5pGrzYY7XL+DUSwd5dauXkaCoTxUbJAP0BfK4j3
 EqK1i3Tb9MDo5ojR9kIaZI4ghfELrWL3rpz7OuZUPN6hDKJ1YrkF0Bxi7uMh5okv9zrt
 jP91TM7i+WYN9Z2tRVZ0VHbljBVaK3C4lZ9BNa+ZUdL1d6fbIhKElft5yUr2qR9Jg48I
 4wz9e+Ony6Ns7VwFsgjBg+mL2hGVZsOzndQPwPBK8Et027k9XEBRaJxg+GPg2Pot3p5f
 o38bicxoR3Buwsj7eVuRSpaNYfOZhoheZP1B3hxam3WnoJcEEPnA1T8gldybuo0w9QkC
 oi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139212; x=1779744012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eib3eRFzS2+00sCLYIMDe5vm4mlk/dWlRJSkbmyxtqY=;
 b=V7xBSHZSJgyVcFomXpbU2KPTJKEZzVILSU9LwI1tl4xkhYzFeKXniVcsDJeQZvAYC7
 ckBWOolKeRGAcL+7SEUKX/6T3p8eVvr8d2Sl3mILqANrqM9V9UEeDAliUCE+wK3+Z0uv
 TZm0XNpcfKOwpxd8m0M91LtgPFDUqfXL2lmKY1m3q7CSfa1Dmq0YSyooSWdJKQOBtDq4
 gG1VcWshFDEgOO2O0xSpl/j5cKVpsfOQ0gxkByFzXIS0vnuSkYw9GHdqCu8KUe7POtHZ
 PI2Kx+gc/fK7t+zPQvEesANYy5JZHHcHUvejLBkhbeFl1+5N4eFoDMUg48byzYEGGVeP
 4qOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gXM8PKYr7kfPqIl4fIQ3ZHD7p9eXpoKkOr6Jyqn/OGuRMYjD/Zca1trG6De+tCFq2sQlUgtlZauw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkM9DoenWZg+N4O/vbRgf2zgyaIi3blSAw/YY1u+iK2KBUJ0tx
 jZd96ZDDF9lc4qRgQUHdANC63rTPZv17wytR/zTXZ5lGmjZDjLZsSfQ2
X-Gm-Gg: Acq92OGVY8lChPXZjj6TxjzDczwhvJjHL6awYiYy5kgCkWAL20lNB2RuKHbc1wljwsI
 SioCdjaqCWWxNa3AsiUMa5R6vrA0bnhDXX818MdXduyYMpyGUWw2v8N8STE4nVPWitZC4hkKERl
 DugwY8DNNx+RBBI1Q5gofhr7jLVoD7JxChXWbLCdTjquiZEsjizYr14sSLTp5aPvmS4SQ//8FfY
 bJ7SwzGyDfUSCB64Z+26n6Kt98xj3Tcu3gqy+rJHIxkfBIhNq64+mjjSwULe+WybLKy3a3JkRwj
 Rlm0X7Px5vW/OnkndJQJWYGFqTv+ZMUsiT5zAMnSpGPP2lKona7ITCM2KFKJcuiovsAQnAvNPon
 WTY7kL4jw5IjWnh0sPqNDLor9svGMHEOMmfAjrKMalrK+7omxzTjXG0U9HVru9AI2JEw/jta+Jn
 uiU07bltNr3cbDsEBl1MAjaRzsJeUE7wK5qYUV3uI7MRRQM6bq
X-Received: by 2002:a05:600c:a405:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48fe60dd5e8mr252074615e9.15.1779139211392; 
 Mon, 18 May 2026 14:20:11 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:564:5711:52c6:59ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm37133980f8f.15.2026.05.18.14.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:20:11 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 lkp@intel.com, Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v3 0/2] drm/radeon: fix iMac11,1 dark display
Date: Mon, 18 May 2026 23:14:09 +0200
Message-ID: <20260518211409.4868-3-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Hello Alex,

thank you for the feedback. I've updated the patch to use dmi_match()
as suggested, limited to iMac11,1 only since that is the only machine
I have tested so far.

I will have access to other older Apple iMacs which also show display
issues under Linux. Given your comment about unusual wiring and
potentially broken atom tables on these machines, it would make sense
to investigate this more thoroughly in the long run. I would be happy
to help with testing if that would be useful.

The build error reported by the kernel test robot is also fixed — the
previous version was missing the dependency on the ASIC_IS_DCE31()
macro introduced in patch 1. Both patches are now submitted together
as a series.

Changes in v3:
- Submit both patches together as a series to fix the build dependency
- Use dmi_match(DMI_PRODUCT_NAME, "iMac11,1") instead of
  ASIC_IS_DCE31() to avoid breaking other DCE3.x boards
  (suggested by Alex Deucher)
- Limit fix to iMac11,1 only (only tested machine)

Tested on iMac11,1 with Debian Linux.

Gilles Risch (2):
  drm/radeon: fix internal display on iMac11,1 (RV770/DCE3.1)
  drm/radeon: fix eDP resume from suspend on iMac11,1 / DCE3.1 systems

 drivers/gpu/drm/radeon/atombios_crtc.c     |  4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 16 +++++++++-------
 drivers/gpu/drm/radeon/radeon.h            |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3

