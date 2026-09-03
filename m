Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A0C79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14B410F8C0;
	Fri,  4 Sep 2026 07:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6/gc+en";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3D710E0D7
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:03:19 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so2644375a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788422599; x=1789027399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=C6/gc+eng7TguaAdi9vR5AYHkGuY6y/V1s3mP6OHLHiVRJo3tJitJOxxEmncrTcKvA
 SQLtrnnDLNcCyIRxSGJl/ycz9xWG8WlIYfUfg4ibGP6H1cE3MgXkhZaq7exQz37ChGkA
 HGTo8WRuOvrGop3AweCTmawMLwxxfevga+OL5gE43pYJXVS6rc5p7Y0pbgjEeZ89b7WB
 HvZvwsi9xvDc6Py9bUl7sBQsMnUqL4WO0hWL9GgcgHDPOFYwXN+q446xL+cT7sxpwjAN
 N3aJnOD42ylwerSxwSPUx0dMCWSEfip6llKZX55iyP/Do6IDi0kcdxIRVKsbZb6xHxQ2
 qJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788422599; x=1789027399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=H101ml1xw7MPb03LrA4Moj7g3vtzxZCqLRomG7rPq+wpw0ssqN+cP9LRWU+Gnfrm/+
 qzuDQRpez1RJZVyEn5GxRbR2Jkau2iXw0u+XEchjUpkCd81KF1vGovEQQtu3pN1zrKLB
 VeX1cw8UuKysHozUQq40/olwAetN9IN7JrerJOgaFq2VbEcNA38mbqxctdMcyaxpkPPO
 qTonbO7mwIEMVn8p4qVsI1cV6VsK+0Q52h9e0xFHMhVLEesF35cXNapvb4cC5XXSbUzB
 Hwi/CTFHJM1kgBXwioiKhKE5Rwv+rR2yWSz6mO8fbLoKeUK1NOq6PClEtF8WHui9/34v
 qOGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5GM9h/6NNIDrMpp09Z6jvQyCMYFwdmlfG7/PmwZzfsEpeC57lg4DBYPBIkh5DABDREZSJBdwAc6E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbfLNkL7C5eVsgTiK6+DbMGxR/hSAFuRLv043MTXjQ7mIejfQC
 bxKjw27ddv9ns0o0vMpP7D7wduO2YdTP8xI/k0zAmBRxphqSPb0CXcsf
X-Gm-Gg: AYBFou3eiRiEqzSe4apSeUJkb7bqjoyuL6MPEMXCUHl6Si9I+crQ+Y75rMAEq8KRZwm
 MS2tfFL8yPSB6gwsVQdPpObevlCdr5iXY7tS13471isCvdEvRaoOTapd+KIC6ps0u22YhdzRUTV
 JnqdnRFMpM+fRfmUSyUruBjS3viFlvB3jqu4f61/sHa7K9gTuqH2XwlwJg1VHdqiNcbFgJLXi50
 1fTrBkL70lHDlccJCLbo8siLy+4zICrZzBMewzjfuwU9VG4HSl2BKPA8QZypJTIs/AbKKsK9MQx
 HElKSxji64FqB5Z1dq2lgwBraezFs1r2xBkHYGmsCRs3axare2YpC7ub8bQivpnsnWXuSG7WfKq
 fQk5FO/u3T69sImSaBpDD6obcN6KNzsKBi1bG1dCnTiR+Rk9o9ns9ZkRs7n+/NOIVy7xq+LHxoR
 YiC5EmO7DewIoZbxA/wGI48XJIRg6ZAdnhAJu2POabpwuSsa9Vv04wso3CnhKu3+jmuoZw1YuHW
 VCaUGLjkUUFjBb1r0urZ9c3SZg7evKje5jd5epq1Cn1WxedGGExd+Newa0oSlGMlZ1xew==
X-Received: by 2002:a17:90a:da8f:b0:398:c8ef:3644 with SMTP id
 98e67ed59e1d1-39aee156f4amr15934057a91.15.1788422598847; 
 Thu, 03 Sep 2026 01:03:18 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08300ba2sm4345553a91.1.2026.09.03.01.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 01:03:18 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Thu,  3 Sep 2026 16:03:07 +0800
Message-ID: <20260903080307.5764-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074152.456231F00A3D@smtp.kernel.org>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
 <20260903074152.456231F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 03 Sep 2026 15:41:51 +0800, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but could this calculation trigger a division
> by zero kernel panic if denom is 0?
[...]
> Would it make sense to add an early return to check if refresh_hz evaluates
> to 0 before proceeding with these calculations?

The arithmetic is right: refresh_hz == 0 gives denom == 0, which divides
by zero both in the div_u64() and in the 100000/refresh_hz check a few
lines below.

As noted, it is pre-existing.  The original code divided by the same
denom, so this patch does not change that exposure in either direction.

For it to trigger, refresh_hz = pix_clk_100hz * 100 / (v_total * h_total)
would have to truncate to zero, i.e. a mode below 1 Hz.  This block only
runs for a single active stream that has already passed the MALL
eligibility checks above it, and with VRR the v_total used here is
adjust.v_total_max, which corresponds to the panel's minimum refresh
(48 Hz on the display I tested).  I could not construct a case where a
live stream reaches this point with refresh_hz == 0.

I would rather not fold a guard into this patch: it carries a Fixes: tag
for the underflow, and the two problems are independent.  If the
hardening is wanted I am happy to send it separately, something like

	if (!refresh_hz)
		return false;

before denom is computed.

Thanks,
Francis
