Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C4CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D0810E0FF;
	Tue, 19 May 2026 08:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOUIcaAz";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B991610E0FF
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:44:55 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c8025f1c227so2753831a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180295; x=1779785095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uowJO01cNG3wo8CJLveZ9KUMF6CjpxDDZdDZxhbcjXI=;
 b=TOUIcaAzvPfn2+3TUMdH83TTEsWS43GuzAbN5+oZthxMn/e6JUeqOrrm+vrG+TicoE
 +VaDcvJeWp2d6S7Wxmg3SjxnNdXPcDsKTusdj9OTDyKG94JYl3YM2uSnMuT1gPN4ppbJ
 zz9oqTrIvWpg0+7mS1nMO90Q+5hO+E2FRS8hM4iywrK0Lpvoj3ZX+bhDUCRgPArXzPF4
 YlPNSkeRaMjyE/H5/zkYvWv/SgAUs1tchYYGYVfSiM+sJFf5/xCK8gYK1pY4sraRJqJZ
 taGxsnqonQEOpKeJvpl8D1YcYgqHN7qyRB/hHHoe29v/6y4rjJGPADMEBnQpnWQvlOby
 9gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180295; x=1779785095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uowJO01cNG3wo8CJLveZ9KUMF6CjpxDDZdDZxhbcjXI=;
 b=gH5ChUEdjp8EGHPeINXForNmB/L9TnoG/LpdZKVBc1ytY4i2x8zKf2h8W1ihZbkRDE
 q3RqaovRWzy3LDpbM3GjbYMKOvCFUmugllufdvaaJV1m/VoUEj5guGizuMsUDjorjHXi
 7RV9qgGLm0CtibhphLPaT3uoJY0sTylF4gJE/zAc2qXBGMUQszqt5jxh+UAeOs2ByCny
 n7ZFlOd3NWLU9uulQ6ebXrDhMtOTqrPWcoU0nb9CszYnBcH4hUAKTxMtQcxnV3omlmw7
 saK/nL9hSOQ5v8FALZqBEICSBWEq2hVKGPFCVHGwgLtJKGyBSQkvY6iw5bt+amXrFwFb
 px9Q==
X-Gm-Message-State: AOJu0YyeQ19uLvqu4rJwaFFCPsJTKxDdxFy9GOz+cXSZ9B63PgOfXJPR
 V0DiD+Tz+mB7nwGMStJ5iF2PjTBZRE2LP+B0f56YcBZ5T54M21c052vp+8v+ZbTm
X-Gm-Gg: Acq92OFVPmAIiVGLux2sbW25uOODPTOWZ0mFOMLsJVZGiWiyd4qGxql86D0CbEk9GKJ
 89Y5sjeL2fHWfwKv3k1nxHavx3jnqyDPVpV/RtZFoh7ZcIdPvbLMcltIkX8GTWdPN50c6HQVUlQ
 HunR9HsQ/ZZN65Ryx8hUIOj5+GDBaspHGJWhwwOutbgY/KSC1PPrby2R/A93T03/T7vpxuyI/W5
 gK+EjPMCpSWjVq+Ul7iF2e3jbZp3ftJlgfhwaoN/IKaPy1uqttzNp2exh1vCin3UYi7uwnYdHRV
 DoGCl+ItqKsvbth/QCCGbBBCTfkwsr7wpIHzrmI5FiuqmS+/1Ij+fM2f3LvtI3BZzWz5YqSRLpT
 OODTOeoozYAf+ALygdekoCd3pRuWeKXm4miXVFPfsUVq3P9VrfpCUDpiNyGAYfI0/vzmnpgl7Oo
 VE0RPOHUM5QCenQmkTKwYTEF9Cw9z2fchY0wDn2Xc5aS5QJ6wuNHmrmOPCv6Hr2sbmJWRdPZwDE
 lSrMiv/RPdb/w6iNirCsLuXbKPQGqZuNhqD2GxoKK5GoQ==
X-Received: by 2002:a05:6a21:6f88:b0:3b2:86a4:ab57 with SMTP id
 adf61e73a8af0-3b286a4ac81mr9916342637.1.1779180294752; 
 Tue, 19 May 2026 01:44:54 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb08cde6sm15636619a12.13.2026.05.19.01.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:44:54 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: zaq14760@gmail.com, airlied@gmail.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, onlywig@gmail.com, robh@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
Subject: Re: [PATCH 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Tue, 19 May 2026 16:44:51 +0800
Message-Id: <20260519084451.2021850-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506-bar-v1-2-12195406f4ef@gmail.com>
References: <20260506-bar-v1-2-12195406f4ef@gmail.com>
MIME-Version: 1.0
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

Hi,

Gentle ping on this driver patch.

The DT binding patch has already received feedback from Conor, which I
will address in v2 by documenting why this panel needs a distinct
compatible despite sharing the same DT properties as the existing
Pixpaper panel.

Any DRM-side feedback on this driver would be appreciated.

Thanks,
LiangCheng
