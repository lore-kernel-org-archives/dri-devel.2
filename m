Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB258CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063E1113FD5;
	Thu,  4 Jun 2026 12:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qbMvyf7k";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CFD113FD5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:41:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso5492935e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780576899; x=1781181699; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yaF6dT3/3oZFUZQ63U3q1nVOw5azU9TIPKTq3SkqFUg=;
 b=qbMvyf7kjaFhksbOD87gw02eVQU3DedzkDDVeIYBojk+twZRxXvth7eBoPLbu7vpT2
 Asykq0eV5cJx2ZjaydH7Lrw0bFpjLvrBFtyF54Njd+BE7JkRaXEb8vZrZzW6PwNsfzJG
 85BUwf7sM1bgVphVBXY1n682CPQ2o2PeV6RlmPFHqbiAvHWk8XL8+c+Uyud5Pz0f5inL
 hlI3/aoApDuSESaP5U/tXZPr8zNv9OsKwQdOWLFXBA1VfHWZ12GCp2+g4qG4A1X4nuEz
 d6fH2M0SfI+6urdEhFuSzz07TB5bOVgpTnRygKL8Dn2Hb1kkKKzVL/vgt9B8yRx4F62A
 o5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576899; x=1781181699;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaF6dT3/3oZFUZQ63U3q1nVOw5azU9TIPKTq3SkqFUg=;
 b=G24ldNx17ByaKLsud7yeTfFFVLiexOWYPkcm2nhkK8D0QrGJLsohcZiUIfpW4Q2aeL
 I5ms0FW0nmCZybncbNDj66KLITqbbc8UVq+jqJH5hlQoySpKrkeVxKILkiBJWgLiX6BL
 X6ZeB5up4CH2ffAGUfEmiStKU+WpJL+esvqVKvpaExhbMwvkkYrN3reN6U7odhzfruiC
 7rDx1AyP+CELg28OivmoSNCJcLRe0QSOZ5qbM7cFPkFKeEL3xccYYG/hIZsJdto1qWbs
 EBahMYriXToHX516CBI26e7oUTE86i5AJi3DFge+3Y5oC2kJlTJyY4eW4zg7cu0pZFRw
 qPkw==
X-Gm-Message-State: AOJu0YxHgUgD0kt0lc/JfhtwoUvb0VoJoNB9yu7b6G91QRmmRUQ63FlO
 Td+LyXkVBpSa27OLfCTqulRN3DW1WPVS4Glen8tvKF/jTQwq6c2k+Eow/jj2/gh26VU=
X-Gm-Gg: Acq92OFQswV62H27v663DDoDi7L4w/HKAyIWXu+zCYij/F4dTzQ5L0K6pXugsxT/nT0
 DP5fzXrBSjhAo3h5ptu84bCyJed7zpwN4QNkXmC9FcVW6OwOaNpVCq/VHA4VvpUgXOQ/sA86aq7
 G6a87ban9T8lqQ9eXdMqpSU+HmNagRzYVkYFzWCmjagRS9H/8apMJrCKPxh8eB62oroqui473VE
 5fzcMYxLcUFRQfyRAIacoQHsaIHK5087DMMtZ8coblT/VHnlEChjNORaoTAnOzW61of12WPiaag
 Eg45bezQavnIp7p23Vbfx5AWZu2/FNa2UDhZtJvMPzfQZ4FmX2F1vybPimC5VEa8g5u5+F75Lv4
 3JUUcbt4+38dyOo/LtQKBP114ybKhmcEBRDM4cy0x0Fn8bz+LjNKeXdMlKnUf4tSrHkP4bLVHsv
 ziHdv82fb5GopcdIFiJk5inV0Qv2VbwmnzP/AxD+e4UbOe2AfLs6OrGL0=
X-Received: by 2002:a05:600c:3487:b0:490:b6a4:9f43 with SMTP id
 5b1f17b1804b1-490b6a4a040mr115728355e9.7.1780576898590; 
 Thu, 04 Jun 2026 05:41:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm16242686f8f.25.2026.06.04.05.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:41:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] drm/panel: couple of visionox vtdr6140 driver enhancements
Date: Thu, 04 Jun 2026 14:41:34 +0200
Message-Id: <20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5yIWoC/yXMwQ6CMAyA4VchPdtkQyjqqxAPs6taE4Gsk5AQ3
 p2px+/w/yuYJBWDS7VCkllNx6HAHyrgZxgeghqLoXY1OXIN5nFSRnufltbhnGMif3QYjdETd3T
 uArWBofRTkrsuv3d//ds+t5dw/g5h23aG2Kh0fQAAAA==
X-Change-ID: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=609;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bAxPMwLB7LUOZ+P8mFegVr6+ZhkgNJibde/NKx75Wcc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqIXKALbDzOZamF4NSYdEeWNfNx9AK4Cgfqo2CbOzU
 /PDhFPKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaiFygAAKCRB33NvayMhJ0ZUQD/
 4/nmbTIguEXIWuXbs2d56oEf1Jj3Z5Ut2wAI4gKrDyQQY3xzWDoHXw6T7dYVdEqJ8jjMwnH4JlqRqR
 MaHwOdFxNYLhCMQemO6BhctXm3ZEmzXVkQpEy1Ucamh6XSwaxXICdH6apLb2vbjqu7NdKOgRqj+HjT
 15SE3YOAdWXV8hjrdNC0SYmgbmUSMTJYxcyvZfau0oQEIzgGPbtVl48U3WA8ZRHa4dKqHNS3XFIdCD
 twQ+RqBGof9cN7tl0TKinJdFQMfbc9bEojMK5gAGC8OFmiddgS4CsaY/6E37nxEFwK4UJext1wo2f8
 /WTrHTrsHpqmW1rBL84yrvVx1UPCAJzFmbK5ygRgeJJSSQhmQDtd1nIPndOhUYMLZAzOW1il8u2xHW
 8bGImlFNK3Vl3SNWnwxkkc4EaRd3uuYFAuDbiXnEawO+iaSeU/gjlpbHa8F9ouQlqApzG2C3lhWIh2
 IXbuA42diVn21GlbkeEcnms8/uJz5bkKBR1GsivlspXh9t2e3h3PLcZv3gl7Pprmuvac0UOYKkcZdD
 isWSD9acbd9RPrLy4n69mV83O7iISNQ0N1WkXt1SCDvP5eKYrn8bPqjIVaBs6g+CUBAwsvmzDlS843
 hEIUPp7ljTVwekL/o/BkwZ2+biGfRwyFFrAzc9zLVfZoI3efGRNs7Yi7jp/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable DSC and switch to devm_calls in probe.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Jun Nie (1):
      drm/panel: Enable DSC for Visionox VTDR6130 panel

Neil Armstrong (1):
      drm/panel: visionox-vtdr6130: switch to devm panel calls and drop remove

 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 42 ++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

