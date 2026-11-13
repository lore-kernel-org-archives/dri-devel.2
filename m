Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21ED606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=znC2qB0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B5710F014;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AEF10E4BA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:22:58 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5c09dbe96b1so133530e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601376; cv=none;
 d=google.com; s=arc-20260327;
 b=selHQ+Ixuuft2Uf3ZF8Y/H1MqGPi7LR0Hypw7BmMzNIucOrmO0YKYcabpItxse3QR6
 r8kNZcTz4HMzGsVrDxpcrx+b8nE2mX7ud3Tof+CUjbg0R54GwKZSQMI0PRyhxzbGdIB6
 7j+YBmQYJ8O2WRGqLDK78+dtNBOwvd2vGlOmXVUqHpz28TmtSr14rkcwHGJif0WfwKHI
 Euie9yhy8kiwH2pR6HkzeNLKvrBq1gmUkb/ShS4HJFeoUZoYR3nXy//SCfekULdBRuRO
 PcfXPImzpoVI8xJxweIGTtNmU0tV+IDtAbPkFNnjGAwpCk7MYYE0H+b0CHO7/olyXSk2
 Ia+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AW+nl+4nxASRB/K+GIqpGeSKyCzwpDQjXMxGtCvf3sQ=;
 fh=kYNIbCZF0nIZh1xW228K1+5y/NEHH07aD73TgEl+VGY=;
 b=A4ITRp3nPb/xXzCwyOM/AZi+/nq6dtmSK4ubxDxlxfJ5OislDjRa5iDtMwELVXMwlj
 82LcLo6UOUbEE8p5caGJz+VC8esNbnurH5xC3vvxsc//Aap6IIcl7oJKd5jG0cFycaVL
 A22G9uenZaQcCdP9ZllNgAB8C8Y124SwM3w3ZBXps1MeM5T9C7tnqtoZWjela/rgHgzq
 hGZuMmX8NmOpSVoqDtFdpGW6BCzdjI8YM4sOOdI36A4BFZI6SCNG3X2esW+we7nbHPyD
 fgijtZduOG4Pe5/zxfaQ/E526b4neHGDiK+72Q5bkEbWYC3ocdGFKs1t9oTjx4FXtmsM
 rdxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601376; x=1795206176; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AW+nl+4nxASRB/K+GIqpGeSKyCzwpDQjXMxGtCvf3sQ=;
 b=znC2qB0m1tEhCE5362Ru7LdBS+UyYDkniPda0cNTl8nDYIKYAWVqw415hMTLoo8eqs
 aUWounLz5Xwjb5XWzhnGugPGn8rf02PGiSrbxxUDjjtLeO5WU4XV9lmB5ad/sJYGiWk9
 +fr/pj5mbEH9HM9q5qnr12ZyhlTb9kH1lkLrXbqKNj+yxb6NcrLMmx9nD2DFre7E7p1S
 /QqdkgBeuNPTqHHXNYCOBgboSgXDouyzCiF+4WvYG0RcxvnP3Ee2Xxuyc+IRhLBLaUp8
 AbChFWJ429sZ/CPMtRjp5dcBh9b4j/FhWKIBrrSuCkFFj2G4yeaZxKpjjoL3DUea5z2r
 MC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601376; x=1795206176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AW+nl+4nxASRB/K+GIqpGeSKyCzwpDQjXMxGtCvf3sQ=;
 b=yhpcxFiISxxecHXUMEvGHHKXzmWZGIL73gUzb6bxNhqUPC0ydX9LoSDKJY4A9XgeB9
 /vavduJh+vZUMMnzKA6sdVa5DvlJAzubeVGrF3q1YxCaLFiihWw4MmBr9ZOC4ExXiC0T
 U9HkfwS5TncquhgjWLyXC36UsL0p3Ij4HTAiGfHcKZG8SKjzqR+4VC/SgQUicIDAd8ed
 96q+Qxh25wxMRswCbxuplxZe8As8yBy5iFq+3WTjOShQ1T2PTsWjjFBmOYOSuthdPIcw
 tEZXSaeHtdSJlng3lGWQSxg+3xGp4OQQCFYA93psjV80d7HMZyr1tqiUzDukWhPVZIgG
 LGzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF894CkLA9Jvluw0ohozryatquCTufIoPDT0Er2mLcu647CLcF3VLbXueeV8moONLYpjOhisBMEnLc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8szHW7xzyGIX/lTWc/U14ffG+nw1xs3dUpLVust69C78XuH6Ep
 bxCMq0VnsBTICB1cHU1uhHvRzwlxSjggKR1RWkqTRSQiLL1WlVGEdhb4d5zjbXnNOERyfQJgyVn
 rZWa4Y2UKGPUrBWExAvXws/mzZqQSSus=
X-Gm-Gg: AYBFou174Q1aPJXFJKfDbKuVs7jqLPnmrOTehCUlpkkH5e8uO9Ws1oSy68DduF5MYg2
 uqzKSF1z+qf4q2fHc/kmvhveOm2J6tf0b2IMPzmMr3qyZKF7b0Yt6Q7v31qxLtfbPzHdAI3s+WL
 qq/cNgF36QmgbCXaGre05QvrFf02scm4P1jMc5yR7mRPS7ivZzqm0wR7Lbg2Us5UvN4hVVSFpBI
 JE56qocFMIcZ8auszRNgmY6usRsPm2H88cZjhDQ24uYvBvtKlBasRj7uD1FxtF3nhzBBRr38ewt
 QHvXZFi6/T+tfW21BqSN8Yj6eQfl2XnITVB7lVAxLvS3BfT9zQf8t5PlJqHX6gbqrSV7xX5qNxF
 JztnfrSOPdRlxTco0ZEQYbwAsejZ6aPBXYC7Lwm6u5wmYf+zO5EPqjNZjcARvU8oi9rpEh40=
X-Received: by 2002:a05:6512:39d4:b0:5bf:a48b:7827 with SMTP id
 2adb3069b0e04-5c1705f074amr1901758e87.2.1794601376064; Fri, 13 Nov 2026
 12:22:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-2-8218c1cf8ac8@gmail.com>
 <72fb3540-e08e-40be-8f3d-63727063be6a@rock-chips.com>
In-Reply-To: <72fb3540-e08e-40be-8f3d-63727063be6a@rock-chips.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:22:43 -0800
X-Gm-Features: AclHuK83avg87MErP1c1PWVXkGZUeHXXf76PgTC3e-PET4yuVzF7UOnIAvMmRRg
Message-ID: <CAEy9hNXox_rE9XUOKe=0zedpTR-sfpz4sum34s_DW12bM52q-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] drm/rockchip: vop2: Don't use uninitialised
 dividers on RK3588
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Damon,

> I think we can drop the previous divider initialization, and configure
> the correct dividers for specific interfaces.

Thanks, v3 does it this way. One difference: if_pixclk_div isn't set
for DP and DPI today, so v3 sets it to 1 there as well; nothing is
written for it in those cases. HDMI with DSC isn't supported by the
driver, so dclk_out_div is 1 for HDMI.

v3 2/8: https://lore.kernel.org/r/20261113-vop2-fixes-v3-2-08ae37e83b5c@gmail.com

Best regards,
Arun
