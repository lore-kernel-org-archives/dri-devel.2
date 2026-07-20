Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB7C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF6710E7BA;
	Mon, 20 Jul 2026 07:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8pcGwx+";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFC810E670
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:39:39 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b00d1e7082so7300616e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 22:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784525978; cv=none;
 d=google.com; s=arc-20260327;
 b=oU+bHMgGaIdXziveBowfyHYbWrtBvHcSQ0X0D7ai13Jfe+GpZApyQ8Cj/ogMCfez/C
 YAFz5bvQk0KQdCVbaeSu4Bl2gAv3rFnZpR2OtbDnqsi5Jlae2Dm8jD4T76hkz03qWUUC
 xAxNICxB7QsONMy8m13GOTK6zqLzOW/aOJ2AzRrMd8ouuVFxkkQ42CiCLPZC0fIFZfiH
 F7EDLKld+V0hk9maFbFZyQpResHpwGxPHR/BUn802PkLB7ne2j439akuaZgfzQmsBk89
 sOGWDUk6KI63jjzinAKnbfDQW/iVtL0mGMNwUtshxBh28vy4iblC7UMXfL2bYE7ylfTk
 n8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W6NVY7nCUOS6eRqN28XA6yLYq6AGh2fODwowWpZd9JU=;
 fh=JIuDqsWZOjyS3yzp2MdOenE570ibHUeJAjsYyCa3BAg=;
 b=iAGCVs0chb8LqxhuMVW3WSIawM9DVtmsNjMF9XBQSdtPsNfZkHq2mDM110feWdAXKG
 9owYlo21koLzHdxLD9C39CsFmJp8jVUHHbT6GSuoy1EfswLWw/BMZS9xAZKGpnjniOAa
 WbAvqfC8iK0XkytpkNnpE36lgFVn75UA/DCrkf3gZJCJVydVjHLwlv4MSM+5DroeAfDF
 cCnlAXtgkHBLG2l9uK0v3wwpupQXWJnKxyNuSzED60jltDJOrx/dLrH0RUEHGwKbsCEt
 aA+y+Frrq0gDXTs97RJoMmAhY2hMGGYGBUkXnoRHlFzJW6fZjc1kGpiiRi/Fl2uCydjY
 b/GQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784525978; x=1785130778; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W6NVY7nCUOS6eRqN28XA6yLYq6AGh2fODwowWpZd9JU=;
 b=A8pcGwx+GQT4YFdQ1SbAxZhPAhgrnAhiwnDj47HiAGgluuKnxUtvuGmfYWzWNYuH0Y
 Os7riFf2TIhCWocn9ByobhJuKYCWFfrcn1kt7gEcoQUUntbZ1RBNeEisOto13i9PDtXV
 lNvs8LYytA83xnc4B4pS1JVmG6N0jf8ghe1OHy/u0l2AqEhXKkxwp4mL0bh4dbrnWq+/
 pBbdvoFGQ1Kvg2Uvhx9XSW2pKExD6csonQ1qlyBXw/+RmdQVIh9l7q0vQXhSrrrWPT7x
 xGTYi3I6b4jGIO820XjBJsLxr6jzgBdFPthhdIzblt//JTHSXVEMzfLhIS8W3MhsGisM
 VtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784525978; x=1785130778;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W6NVY7nCUOS6eRqN28XA6yLYq6AGh2fODwowWpZd9JU=;
 b=A3txXpEVv6cwrOm4KqBOrpoxkJc3z7fwvKlF49or2/gQnDNmgiYJ4Xr+JXNorm4RZi
 66VJdWKonaUYkoq/WSkXalr7kEpKgpKnYu12470m1zs3dl33uw/HtPYcTgQnttdYMAem
 qaPsRWpdP+6S+ZefE2cUxo125iH4b2Gta9F+0DJKcZMz3FcuMySsp0tTplh4bUHbR04O
 ahSq1G1d7mcEBb7KcRYMUAiDbZy1mZQG+G43Yr3vTz8qFJsXbocJsF29nmVCxFNzn0z3
 pDPo/WeDwxo+bx3fKywjf+zbkvHFeDVtl27pGnrodSvypykwaIc4qmyk/azr/oRCcQut
 +AAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPGIylJKm4j1Vk7x+l0j56dK2bu+IcZ4pAql6FQEL4fzRDinEB7fi+LJOYLu90D49ei8dWclYRinQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNnSsqn1KtheQa3II4MaOgTJ5ttcqQOJNCG3P6pVMbL7mOU8Kx
 0BMlfoqgsa09Rnd76JPcvchthE7k0H0bLFiwGmzDXxkEGXC5FYd93DnhjTpFwdoJSZ5QH9SWOKv
 ku+s5uiK4ANDz8OC6Gf87TuixMXvLkdA=
X-Gm-Gg: AfdE7cnY4xYFOGgI+IdDJokJJ7rffqX1sKlc86aKkGeK6I9RI9qbe2S/t5fjBrbsKF7
 eMGdKsOzxG/rDTGe+t0qcdn8K4Zv0XPKL+Ttd4f5itwVvptwYVPmi9V5ICy+otb2rPino++mIQK
 omsqGGgVZdKk44O0+uKVjOqiQlWN8RCqelDXRQYo++oW6deaccxYiLCvYYMP4GfMBTtHBo6ltQP
 vie5wiwdzTZqHCc9pC1FTntSBNQeGbgpOQ70yGyxYzJobuslg7z58dcE/Of
X-Received: by 2002:a19:f518:0:b0:5ae:bf95:38e7 with SMTP id
 2adb3069b0e04-5b28f87cb15mr1651466e87.10.1784525977505; Sun, 19 Jul 2026
 22:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-4-rok@kanardia.eu>
In-Reply-To: <20260717120005.2087386-4-rok@kanardia.eu>
From: Alibek Omarov <a1ba.omarov@gmail.com>
Date: Mon, 20 Jul 2026 10:39:26 +0500
X-Gm-Features: AUfX_mxWr9jRQfWnrNfb652ggdrTJfNDWLizy8QL0xejOpCnF33xEHR31Qj3tRw
Message-ID: <CAKyg=SV2-81VFgr+Tq=-Si5EO-86MA+ZFoQ+DX1fEYdnnLYJng@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support
To: Rok Markovic <rok@kanardia.eu>
Cc: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jakob Loeschke <jakob@loe-web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:04 +0000
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

> Based on Alibek Omarov's earlier posting [1], with the changes below.

Hi, I'm Alibek Omarov and thanks for picking up my patches. I didn't
had time to finish them and these days I don't work on hardware that
uses any of Rockchip SoCs. However, if I'm not wrong, it's still used
in production and I had report from Jakob Loeschke (added in CC) who
confirmed it worked in their setup as well.

Thanks.
