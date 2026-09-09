Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E152AC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223CB10E16E;
	Wed,  9 Sep 2026 11:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5EVt2dY";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA0F10E16E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:26:16 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843703c170so439527f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788953174; x=1789557974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X9DeehTFtKYcoXYYj70SGng74boW4Lx0fudui6KbUDU=;
 b=V5EVt2dYro/gfvWJ/BV0XIRBe3wrnugDGG34gzTjPp3oVxW2yOi/BdUbrtBl/qMd97
 GvxeA5GOgKyWzTaPFaeEP4J4m5zCRbVinj0Rxv/fOGpGZlOmJ77apePe0G4LakYGEWkx
 r8XbJp3EefOMNYSmQqA2y8BdiQJ6jVHfOpDEf96FYAvDNdLfYeLFJmOlNniF/4z+8yjK
 EplThOkVQ5pPSRCuAKsdW5G8xYpalTo2Rq83Bi94EpYiaPXADwjc3DW3/gDn4Uhpn2+Z
 iXLRpjtDu7mRXIdt4iY4nerOYfXy2IOrzp0+Bs3ovKBZlkL1UUmOmqq5y2z88QrVUYsP
 zEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788953174; x=1789557974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X9DeehTFtKYcoXYYj70SGng74boW4Lx0fudui6KbUDU=;
 b=Gurn32/18SoDHKv0rX5BGBOGmkWK7F+taLya0H4u+GgVrS03w1dtU0hVS3DXz/EGWM
 MCeNMYTUHNnAJYqRioAnZz8v+bif/YUQLlE7p22HO+4IVesfi/tGXjYl7XBaeqfZ+nep
 H5D1BnM5Bj1zZ5LhcFywNAdSp+NcT4OhvfbaQ1JBNZiOMwmUPuXAfs4mk6TAr8o2jb3a
 jn4ys39deX+BHQWMaBoBLfrl8OiSVf38mNy80BYkeoeOOdN4VcIAMxos7W6hRwg3Ul6b
 auQfRoPX6kOjvPwzev03Wem988oFv9yJOtddLPV1iRyB4fEuh2yNg6YIKmuFMdwJRc86
 cDZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykk8vGLSwVnhfGgYzY7BV4YHH+0Um2pI1xzEtRFP2rUR75jEm+X0UaqcjGkIDVN2g2TNpm8Iky/zs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTT7ppk9B/N3QilqyXzJm+2LkP8hQ4amApB13LmTEGzB9rft2O
 KkKCiyJCdhw/aQ8VWqNm/3Bo4NHQIebIPr9jjW28dmlNhjWhLSar6EZv
X-Gm-Gg: AYBFou3cslTlXWG3gTMhyrPzENjISJv3kC4wb1zRF8/Dg/TBQBK/TnVkXEvXcC8VRvW
 nRDtKgvQNRfksPh/s1hmkXjRMeoWw61FyPXDYrFDFBHg5ws4CYZbNVOmv85fZBrttNddwvC23x6
 ijD4XgNZs6i33IkjroHt2QpO1rjXpQ0yqql/yq7GiFP3gWGaXnUYWjeGx8wt7efxfUQU1j27AHf
 MFnL/WR/37V9YV4PcKt/B0man2aaqVp1t54zwSbbwiinf6SRayTq2mrYTMIE1uqHZ/HTQ4AB19w
 GEvVY97B8pEQ7xX5cPHDx1jUAgJiPXMrFJQHAqV32CC2Ity1minhUV63dFEaKg0derlvHiDH9iB
 Q0ErxQtazZEcTGMwLDHKa3I11JAFyoVBE/UhYvd+2YtSghCXF/Dbv+YPjLx/Hf0gjNe70RL0ZsL
 5GNdhBDyLm7ro1qTAy/2iETv074DZVgwpmiGsz4uGJ6Ci+3HFlvh87jjiAbkWsgkmMNuK6WdW++
 NLQ+t1wIOTzzJCiVlGSuoNODxFge/TB+u9aDntoQHfOqK6N5jk0RXobd77MLtD0iQmPDdGO1bkZ
 /kY=
X-Received: by 2002:a05:6000:4805:b0:482:e0f3:462c with SMTP id
 ffacd0b85a97d-4859796300amr24943997f8f.0.1788953174092; 
 Wed, 09 Sep 2026 04:26:14 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9b49sm36475476f8f.17.2026.09.09.04.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:26:13 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Maxime Ripard <mripard@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
Date: Wed,  9 Sep 2026 13:25:40 +0200
Message-ID: <20260909112543.6913-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153416.8459-1-royalnet026@gmail.com>
References: <20260805153416.8459-1-royalnet026@gmail.com>
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

Hi Heiko,

Gentle ping on this one - it has been a month without review.

I re-checked it today rather than assuming: it still applies cleanly on
drm-misc-next (8ce26b09f652), with no offset and no fuzz, and nothing
merged since attaches the Colorspace property for this connector. So the
gap is still there: without it KWin reports the outputs as "HDR:
incapable" on RK3588 even though the sinks and the rest of the kernel
side are ready.

The patch is independent of Cristian's dw-hdmi-qp HDMI 2.0 series; that
series is not in drm-misc-next yet, and when it lands its patch 34 will
touch the first context line of my hunk, so I will rebase and resend as
v3 at that point. The change itself does not overlap with it.

Happy to respin if you would rather have it on top of that series.

Thanks,
Igor
