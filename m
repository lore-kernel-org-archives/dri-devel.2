Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B71CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A31A10EADA;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbnlU9kP";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E068110E544
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 10:05:45 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so5043235e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791108344; x=1791713144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C7dO0Rcfru0/bHBYtaY5qQl2mBgYh6+npZqhA24Mb2E=;
 b=CbnlU9kPcNvQvi34+9SNRFXI2HXHwm84H0URN4T4c5gZjZLjTXvuUFbbbdZ9eaqhvl
 36G/uMKneY/VYRnwRj/QaWyRsrLh0qjYcCN1kSoZPtxZlCt4xlUCYlG1mIyKNySnNwvp
 no+DEM7jfEgfY6n7TiT26LofedPS9/wvG9yJZC8mQBRzPtvPs1IGthzRwOTB4OvEOEzZ
 Tfa04x0JdNACaybIenS3qwPHfsTm5PhlZOVKwb7T9v8NG/ayKlmjJaZuNPmJ5uoFzrjx
 L4j6jKK0c3fIcyOqWFvS5fHSYb/x6IqCf/HtVbgC1PCGlWjbAmLePNxlQPNtIEAj4cSk
 zBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791108344; x=1791713144;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C7dO0Rcfru0/bHBYtaY5qQl2mBgYh6+npZqhA24Mb2E=;
 b=Mlc6Frdp3FiGY5X3y74WtfeGbRedsaqljG5AH6Aa7Q3Ktes8uXzJTWk6tGSAV24WcH
 ibjR1Q++GWDHeUazQz7d9rTfx3hfwFNvtkTjIEHwIsFEAYllNKjpX9rhltKOM6Qk6WEz
 q3dhDrwDjHQPFKaY/NnptMBoeZ/LVlzm42XFTuOXWlr/hNn6Vbd/fRunGz1jysBUfQoP
 wYLhRdTQP+8tD5hmpKgGZfg91B5sAMOMUI4K33JoROalzkZYm6o+6ZoKfIBsBToIEYfR
 zqY+/0ZARDlzYkEF8Mg8M6aiiA455J1q2KO0Szpy1b0vnuJpz22AS1BlK/a7wMyQHabi
 DORQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkuzX+eIoJbX406blA7/+CYxTxk6NtGweeamVv54tp4HgKTZ599PZAYX8ifnX7Pzbe8lNMR4nSJAE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++moFiarkTUNwWIPT55luB/MHlB62+0THT35dWm0YzZi39krYFQ/
 cvPXbaD2oE/MdVPzHyhL/JXfpHG12MtkNaob+mtKjGoLLw6+DaUCmOf9
X-Gm-Gg: AYBFou2FWDYoNhXSq+QexpznuyLTURTnjZtdvbVdRpkn9Y3IXCKj3vnAp43HHx3Otr7
 eKr3Cvq7NZnI02RmCvBkbRSI+LbwEtaboUyu2/Ja+1A4kBj3mi0ZmERJwbUkaVl3BHj+S7eh+1h
 1v14/rTBOSLHp5tlMFngC9z/0rkjs426GwOJ7/UoJC3c4OFUSh9p2L0L+HhfwM+Lgop2oR4xPuc
 T7u+JXn1Lc6xCUCeV4NeDd5Xq1LcEL3V9S0vG/vCGwXqZ29Okzt69rurzlAFd65gZYpQksGt0ZX
 M17wvmNLIxUZRlRNZyPMukwv7DmUVmlVxa6TvA2VSlTb5lSE4xknH/KBiu7mMYJCKF5leZaQ88L
 +tCnil6K5yx2REzTcy6Sv5COApwimolSlLfM/MWozi0heqzgTxwrcYDRlzBmX8H8y6AgjNrjnEN
 bBSuEbj9ijAE2jzPxHvCIb4GTuDZdDRxbTIameNn7jGU2ISkjxdb1Wz9XNc3c1pPXDBh2NNagwr
 fayDw==
X-Received: by 2002:a05:600c:620c:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4a027583fb0mr131735445e9.20.1791108344053; 
 Sun, 04 Oct 2026 03:05:44 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.11])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a02770e8f2sm215687755e9.6.2026.10.04.03.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:05:43 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when link
 training succeeds
Date: Sun,  4 Oct 2026 12:04:59 +0200
Message-ID: <179110829900.3315.15040287408420454805@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8b45dfc1-5350-4a63-9213-a1160478683d@oss.qualcomm.com>
References: <8b45dfc1-5350-4a63-9213-a1160478683d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On Mon, Sep 07, 2026, Saurabh Anand wrote:
> Yes, agreed. I will update it in the next version.

Any updates?

This is not limited to Type-C. On a Lenovo Yoga Slim 7x Gen 11 (Glymur)
the eDP panel sometimes stays dark at boot without this patch, since
msm_dp_display_prepare_link() is shared with eDP. The only training
error in the log is the forced second retrain:

[    1.839032] [drm:msm_dp_ctrl_link_train_1_2] *ERROR* link training #2 on phy 0 failed. ret=-110
[    1.839043] [drm:msm_dp_ctrl_setup_main_link] *ERROR* link training on sink failed. ret=-110

msm_dp_ctrl_on_link() succeeded just before, but the retrain from
msm_dp_ctrl_prepare_stream_on() is not retried and its return value is
ignored, so the link is left untrained. I'll test v2 when it is out.

Oleg
