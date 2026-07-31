Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B28DC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FB410F188;
	Fri, 31 Jul 2026 06:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="az1P0/F8";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8887A10F188
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:58:02 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4706f016316so41189f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785481081; x=1786085881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YeBqNG7bCPXWkEk3F3j6eSFPbLdWmf4Wl+oL4uzu69g=;
 b=az1P0/F8RxCj3rL19hZCpDjMtZEQH6mziNENne1oBfsEESEPMhZOYOx8Fx5cabzNGS
 EnU4BbpFb8cUEpspLk/uayBNErO5Qn3ss4J5WcQS94mGNIgOQ7qP4mZzvsSRa+eEnif0
 NBMIM+nBug9Tm6tBPr8n5QkzDZ5Xr4XdubHbFDuZq0PyPtA1aK0/8BAilfXJdX7MFN5p
 VZ2h//8XRkV8YFrpGiwFj1DYamxkkj8G9PHwZPiHOoUg+fq2GncLXUrk8RinB8QOrgJY
 lY6gty9W5BPDTCEBMG1MZKiDHT7OPdziuEs9Alzpsfm8xp+ePv+wddFuXsFWPCFRUfDC
 V1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785481081; x=1786085881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YeBqNG7bCPXWkEk3F3j6eSFPbLdWmf4Wl+oL4uzu69g=;
 b=pI1S0lvOntD13MjkGBRlXmTP4VeGiChZ8OcHWCz//5T4dr1P5PzksX4Z4LO6XdStO2
 1KQdxhOzK0zMLIwLHJ3p2Jfoy8ZLSrxQ2PQd8m47mwWOh6gTejxujQVzDzgn4/cXcMY6
 q/qlF9jaIG/Vm069YuKs6GzlayPld+b/+CkXfY/TvSPfVIbdKEbScehEL+dJPC3SqKX8
 GLJybRWd/u8VbgTtjTUZJlhdScWF3ydXhdpxdys08M/F6KnYln0NuUAq4AhzXO6EBP91
 dM17SIumOstig0sJ0Nhxsf2OKL/dsfLD91aKf1ECt+BWGnxxyLLa6y6UUWb+hGTZUENh
 Yzzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRbZ5FshEC7BgliKw5YTLHKVEJDow8Donw8cYriarD0/TY7wLow2g35kBi4cCZ2RoNZT4CrSdxIjM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFDGq855RFnPy40qjy2tHdJ3Y7yztpq0xPmm/aTTp2EtleANH5
 F5y4xRS+Cic+6MDSS+0YOgRkfKYgrq2H/8E5ZJWu8PS4rgBBaNv2iPyX
X-Gm-Gg: AR+sD133KC6pc5a+0/Cp77DT7DTg+4Em3r+7KhZCGzqRKMbRzOlqs7BYe89tBQZgAMU
 rqevtn35dlqH56kqFHKJM4z8lM4N+3tCDQe+H11Oteezb9pJeQNBca78WsbCmAPnbRLjyyPpNyP
 hQkgHNenLfDK/t5YxQCm2o76FnRHZIeWnF4NobNpl4IWtPKQtrmb7Qt6LhyB4dSF1P8fxIf9T/3
 ydfp+aYyKwcqTu3BdqMYIMl7vYSappQIX9xW/poWXswkTqMiU4+aLVAo6ts6IOOZ8DELfcqAvQ/
 XKglPox8cyv0zkq3FXitIqs9/2iDGLRS22MdAV2GhvQkI94K+Nsln00X6I8M8wkRSuQEy4v8Wei
 biSKeZgSjgCKQLLkJONV3r+0qtA/E6TmOyIWpjXbXH/fPx1n/h0O/76h+qTT9nbL0fVB9sHMwdd
 R2WS6JpoZR0ZWtiTJ/1UWF3dL1Zl5l+F+IF8PD8Gg46WWZ469nFb6nmkAPGCz5WeeDRWrAT/Mi1
 9ANrtLID6piPWmkAEwkGk0Q+jgGxzQ8k6HdsKaPoVNmoEp0bt2BPmnMSMYoplQLqfveMw==
X-Received: by 2002:a05:6000:2686:b0:47f:80e0:53bf with SMTP id
 ffacd0b85a97d-47fd2b6cfcfmr2383206f8f.3.1785481080876; 
 Thu, 30 Jul 2026 23:58:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B8B0053881A2C61CA978D.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:8b00:5388:1a2c:61ca:978d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm1416029f8f.4.2026.07.30.23.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:58:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH 2/2] accel/rocket: keep core slots stable across unbind
 and rebind
Date: Fri, 31 Jul 2026 08:57:44 +0200
Message-ID: <20260731065744.12961-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730113256.1418091-1-gahing@gahingwoo.com>
References: <20260730113256.1418091-1-gahing@gahingwoo.com>
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

Hi Jiaxing,

Thanks - that is exactly the kind of hole a reviewer is for. You were
right on all three counts: the failure path left the slot marked live,
and the live-slot walk in rocket_job_open() could then write one entry
past its allocation.

v2 is out with all three addressed:
https://lore.kernel.org/dri-devel/20260731064933.12548-1-royalnet026@gmail.com/

I also exercised the path you described on RK3588 - a forced error
return in rocket_core_init() for core 2 with cores 0 and 1 bound: the
slot is released, the device comes up with the two remaining cores,
and inference passes bit-exact with only the two live cores'
interrupts firing.

Thanks again for the careful review,
Igor
