Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83035C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C0210F2B4;
	Wed,  2 Sep 2026 16:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5ko4yEV";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43AE10F2B4
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:15:01 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4994d41ceb9so967915e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788365700; x=1788970500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVJl7440PF78QFaSaeh/sCgR4xwST1VQbAj1ICZardU=;
 b=D5ko4yEVOluN4MvLSNvvSmqA/GIdj3t4qUrHF5mhG3Qfn98qmEnoe2loJAaiZz28WP
 pQ2I9pPAYqcoRIC6q5jYYRvY0+laJdsIPK+B23ax0fU37LCtYa+Pp34+s8ReCR/pAo8a
 paIE1G9y8FRufffGQcRd+2s2RbYdbYs43fJQgcok1xdOp3wAzx5dgG+0WnFsi26DBwOl
 NbRLciqCZt2rfGADL8zK6RrSnLn3pq2BXW7t6cmZhDzGNuwnwJk8soue2pTia9figYQ6
 1sw1M7HZuezaFoxfnwJod/1VnQ86m5hGG5lYJ90J6IPjWlAQuyJXUvbqNf/uGK6mjKRN
 EBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365700; x=1788970500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nVJl7440PF78QFaSaeh/sCgR4xwST1VQbAj1ICZardU=;
 b=sKkIbhVJni/WPw14kTM4pzbpEEcX/Jt7zcZE1LoOZKpuoAJIMrEbi1r0TKqwTwL/Lj
 RVqrRQ+gZ5kh2vfOMerj2CpYO/ESBK6EhiqAMfB0yQeWroFYmP+h/99VXl54936BeEBb
 2LhjOL7aM2BRSOZK0u4gtGt+mN7LDvhF+UbCO0MxgT67+PPFv9ZlyQkvafuyCiZ+a0Ui
 ItHRAAgcWUh1fiuUbze3rveAd+d2c6k1p9+uNSXSWPr1ebl8c5ltQxjkRul0s7S2JzfS
 wqzCR2cNGU0+naX3Dq6aGuNIyKrlru7q8K7GHfAvqItWwHscvn/LCOnvnHVI/8avZThp
 RrTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCd8wxwwlEAUZ1WPMjhsXjsaqZaMAjf8/nqyB+JJLFXUaqi2qg5oa3E7xW/ky5Ia7x/NaQnL0oKSk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lja2o91ZBwqPEyIwT2y/KPs1SNVc0nOAf9/qJ/7fSFmwMExSbZ
 cHRGlHtHNnVXsH64NprUu/s9Eb0V1eGjDUS/fI7wzhxw4HWyNMDvpDTY
X-Gm-Gg: AR+sD1267CgqxB36XhW7NAm9bZd/l+WMe6FEDL7aL/bsc8Tqnf8CbeUwHHcdsp9ru3x
 28jIS3QcaOacuNa+KKF9lZc2vVz1o+cEltyuf2HfKtKqRgVk0r8mpTXCyHlNavdLARMzN6kD3t1
 gLQev2yAKGogHS2nJFD+aV4ia9C9753VMqUCmYTlNoMJQMFQ1vK8/V3BwQ8j5D9gUgyHwfHfVVz
 DRFDWoo1dcj8FQDHMfDK0KEdVlCz2xhaLXSRzMZ8ICmPdWdqZjojo8A1LMQ+9TWjN4drTL7uNrn
 kJt7JcdIY8qnGauf9GXOUmgQhM5hzWbrHyecVhr2MGfQjITHSMA3tXI+m0rj1Nzw9IAJZCjLm2B
 bcRBMYMS8BfCE5CfazQ3YsvMcdxmlnHACjd55iED5MDB1YxtOYx2MI96jP88gOj9uELJT2mLYKd
 5thUbINh+dw0O7ZfMm8sY2HO2/9kXeOne7e/6gqToFa+PtX2mmDyXwGjZ+Os+XtOQ6BClB/0vKk
 OqopPWQjDGoo1BuRB2yRllKBCrDFx/95RUDs0mte6gSmaQ6ip6nTlL4CYk4li3Wp8GkU6zRR5By
 lxhB
X-Received: by 2002:a05:600c:83c4:b0:49c:e363:c66e with SMTP id
 5b1f17b1804b1-49ce580365emr50281685e9.1.1788365699791; 
 Wed, 02 Sep 2026 09:14:59 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B923800D872728A926FD7C1.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:3800:d872:728a:926f:d7c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm1878395e9.6.2026.09.02.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:14:59 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Simon Wright <simon@symple.nz>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi-qp: use drm_hdmi_acr_get_n_cts()
 helper for audio N/CTS
Date: Wed,  2 Sep 2026 18:14:35 +0200
Message-ID: <20260902161439.5276-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
References: <86fcf349-0a7a-4618-9001-612371b0f71b@symple.nz>
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

Hi Simon,

First RK3588 report for this patch, with register-level before and
after, both HDMI controllers driven at once:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, both HDMI controllers

Base: drm-misc-next 47b823940e38 with the HDMI 2.0 scrambling
series v11 on top. The patch needs one trivial context resolution
there (v11 still carries the open-coded tables next to its new
scrambling defines); the result is your intent verbatim, -206/+3.

Before (table code): at TMDS 297 MHz / 48 kHz the controller ran
with AUDPKT_ACR_CONTROL1 = 0, CTS_OVR_EN clear - the auto-CTS
fallback your commit message describes. Audio still played here
because both my sinks are permissive.

After (this patch), read back from AUDPKT_ACR_CONTROL0/1 while
audio was playing:

  TMDS      sink                     N     CTS      spec CTS
  297 MHz   Sony (300 MHz max)     5120   247500    247500
  594 MHz   Samsung (HF-VSDB 2.0)  6144   594000    594000

Both values land exactly on the HDMI spec numbers, CTS_OVR_EN set,
and audio is audible on both sinks simultaneously. The 594 MHz row
runs on a scrambled HDMI 2.0 link (4K60 RGB), which I believe no
one had exercised with this patch yet. Note N at 594 MHz changes
from the old table's 10240 to the helper's spec value 6144 - no
audible difference on my sinks.

Igor
