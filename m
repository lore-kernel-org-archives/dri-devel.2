Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C945C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A8310E180;
	Wed,  9 Sep 2026 11:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMB6cuEL";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A2310E180
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:34:23 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4838dbf1bbeso525540f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788953662; x=1789558462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BDAFJuDlghFFa//FTOTLPnlGuO3PdxiOtfn+DAJGPPw=;
 b=GMB6cuEL4Mhu9Nc1zzcTvkQZDio3jX0quSKdr9yfftkQ1i6Oc/Xl1LRqDBzoSofIUs
 ZD2M8U/b2OfJ543DGbT1DL5s+f6H/F8+z+WNxlTDznrAARamcNnUSNhgHaMg1UI0Sk8G
 omf6Djl2d+UjOlNJ/ynC4MHRPJ+lyMq+VC6KOc+PXphv83wRnJfO6mppskCeY2Pr9+0j
 kMUVvOBQQWmIeFN/NtpPKL3W4W2nPaYKrsS6pbtdTNVNIsoGYRbg77S2RR35dv9dt0N7
 EYoGDmv/LzHgX6qbVQlgJWN1WpKV1sABVivD2/RMy5U9wnaWdAwzfSFISZ2rbFGnsbY5
 VMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788953662; x=1789558462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BDAFJuDlghFFa//FTOTLPnlGuO3PdxiOtfn+DAJGPPw=;
 b=bjsEbtTpKNBmFUynYw9DQBN+UwFZDpNiwcs0EhxtbzuAaCnmpJEBk2kTYsiBcUyhFV
 P8Ntu2S7ZIjCqsFO2l6oxlZ8Y54VSmVMKp4XwixoVscefKhpi8PFjwRac32qcpADOiX8
 lmCKxah1lsjZ9oVrq6vCYoY33bzxMZaHj30qsz6TgwHLMexa+tQaRuyEsrGj9A+BdM3C
 X7cRb+88XbgBi9SDl5lSgWtz4DbVWp3gwPUAnUTrEZ01KowqdSN6hNTg6+oUJBTVXfXS
 n1e224XHGCERI3x90pGPL60nDC47LfBcYTVxcpcaEY1u/nmrr1zeDRYui2k8ZQJWaH+o
 08SA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxa2VKyxgNI5V03Vy1PGN+0rjPcpLx9j/ROGIAjyU2+PCdJAo5OxDcKzuLijTNc50eIEJUCXeCYBPw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++koJL9TrP472qzSwx6qxOgI2DDqxOShX8A9LpRqyT2kYQkhOvBI
 Q7bmVyfWGcVYmVYyxh+KwW3SGCcIARe6u2N+J7xXRGnArFYf+bGSvMev
X-Gm-Gg: AYBFou23oof5KqqsXrXeS+5bTGI9+hnGMaegnCmgHtOrqzjg74lkiv+WifFeKErSutg
 DMbhgJC3N76X+eniixhD6E6YlswmpPvTxUgSgo+xKvGxpFZdmNC6B4cA6O6M+HKXJNv02Df41sg
 UPKUVGGAjKSm0AWkfh9b5cEWFLAS2x56POP51KDV7L1DbWciY5GjjQeyUGqkQwAHvFjacAcOt6r
 4NymWFfyt/suahtPvrPQUjS2RFHrhZbcmPQmPBkNl76FyZqj3bJKF4bGjnqs6fETStgXP6mXiqM
 oolHAgBTADu3l1UW2DsVvea+9ceFWZZHFOQfK7IlaQL4CJeS1EF+AL7Hx76T3LmLWdRjKAB4AOQ
 MhHcHGNRau54yBIGcRxA8m6qxQPHZ47poqUTTXEYWQNOHqjWFxWQs1uMgcX7OTnCnhDvujEkr1+
 911ebx5kOiUxG7h2epugWI0aJ8lOCar3bWSBffwRfUo5t4bMBIdsZdt7bJNMUQheFvr+Na1yQ+i
 l5wHSTvzSNaEZDJI/+cqMWcw4DswN/5YQCWY9Nyxd2LWPs4iL6Nev+2bJN0qGSjTkcy+COQCL11
 bTs0X3CXEoBWnw==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-49d01dcc32cmr238211625e9.1.1788953661666; 
 Wed, 09 Sep 2026 04:34:21 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d057f4778sm364624455e9.8.2026.09.09.04.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:34:21 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: add COLOR_ENCODING and COLOR_RANGE
 plane properties
Date: Wed,  9 Sep 2026 13:33:59 +0200
Message-ID: <20260909113400.8295-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716113024.15357-1-royalnet026@gmail.com>
References: <20260716113024.15357-1-royalnet026@gmail.com>
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

Gentle ping on this one - it has had no review since July.

I re-checked it against the tree today rather than assuming it still
stands. On drm-misc-next (8ce26b09f652) all five hunks still apply at
their original line numbers, with no offset and no fuzz, and nothing
merged since exposes these properties. So the gap the patch describes is
unchanged: every YUV plane is still converted with the BT.709 limited
range matrix, which is wrong for BT.601 (SD) and BT.2020 content.

One thing worth flagging, since it decides the merge order rather than
the content. Cristian's "drm/rockchip: vop2: Switch to enum
vop_csc_format" (10/14 of the VOP2 series) touches the same two lines of
vop2_setup_csc_mode() that this patch touches. The two changes are
complementary rather than conflicting: that patch tightens the type of
csc_mode and replaces the "csc_mode = false" assignment, while this one
replaces where the value comes from - the hardcoded input_csc is dropped
in favour of the plane's COLOR_ENCODING and COLOR_RANGE. Whichever lands
second needs a small rebase.

I am happy to do that rebase in either direction. If you would rather
have this on top of the VOP2 series, say so and I will send a v2 once it
lands, with vop2_convert_color_encoding() returning enum vop_csc_format
so the two fit together properly.

Thanks,
Igor
