Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E2FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2509510E56A;
	Fri,  3 Jul 2026 08:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0JyIGVC";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A4F10E56A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:10:24 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493c486f012so1187365e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783066223; x=1783671023; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cwYdbfI8WEQMnRvQOATdDHCYGWSWpstPY10+DzjdmWk=;
 b=S0JyIGVCsVnnmFLiH0sIXC4cD1mhdVRZE8FRfKnEHErjhFbYVYdPOtAeB0hmv7J1Nx
 rmVmDaEJ7v4ppKRHmQzrN9E1kgxAvp3pJ4ks8LsfGceYfnE5AQjwryaVp5wbhXBH2BPS
 qKExA5OL016twgoAlcFd91HkAdQHBjnm3ShQGI3T55Oh2YlHGdjay+JTeeiHnMaXw9lf
 ApGg6BEPi6TqdXk0fZlWw2xsXoEaNJoFH94Xnw07CzC0sqZHF6Tc4I4pisz2bdNlr1fF
 qvjTG6Bd2pmMS2IAIQbYtdLtsr6+B8Yuze6yPXYsxKEEE7e/bt37F47G2lvEm66kRFy/
 SnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066223; x=1783671023;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cwYdbfI8WEQMnRvQOATdDHCYGWSWpstPY10+DzjdmWk=;
 b=P/RzqFYIOh3Fp+O/AhFIPPdzPB3Q6wP+6GuQAnsI0Gcy+c32cHGb+mNy5eWjxwOcSB
 JNGuM/1ioh8S7ot/QNpBkQ0qngxrZXU6Gb/ceA4ZjnEuKk8YZJO+pXccKFlynX1zBD/D
 6bYbHEGf72CizDrCHrraawZ3x9qP0mXnJo3w8RGR1iXUhwZphzake5ljLceNTbQUFEJG
 38fJ1mjq5qkAmPv1vdj+6LTkC1Cku4Eycl5ai5QoMF9wObkkHRitgFfrwuwhEPGyDKsD
 bXpn8Nq+MuLp09T4h1F+9+FnW/VecciDp7ZL/+gRnis+5ZEnDTOb7omoPE25kyozhAbo
 B6Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ldKtr42g0qe2L3MfF/dB+h/vRWmloSH8QOOygLc035wlsRERmyNcRP3YWXbBrBJvyJqds2nMQ5WQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1PJqtXwE19Z7VTQFLwdfAcgcb+l9OneBZru6J4NJxoOqK8xtY
 oP8Fwh79IFasmonb86jhAuH/zxAfuPvUs38Ly3LfSHR3lZloUajr3ZX946xMTopGNRg=
X-Gm-Gg: AfdE7clOZ7PcVJ0n2TlMPgEMC8qK57V2mjKYbil73P7rM1fw0rv570oPf/aCWpLvbry
 SN0w9tFLqqkDKVh7TGvNjMxstrONWyjF1E5ZEhiZJpWtAbf/JwR/0TsbX83gVvyKIigIFy4hsRp
 ppoOpmLbsz0I675tV+nyqIe8cJFaBzQj5sgNWD4wUxEW+a9So9FuBX9L072HxqgkRVuVFi0lCKZ
 g0wtozjxwiQ9PsNo8COF8cCOOsO4OV8dGV8K0lH2yiwxzLLI++JxplcBVh+Uc5Gbc/gzPJsJ76j
 mlSXe2wvTtRnOYuPZzNCNN+HwI8dXOky+uS5Ovsw6/5pBevwC0fxOkVMKM24lCmxDVoif7g/HWt
 d77F1Yt77Rshm5RV8dTTF3RqrbmBOwWnG/quzH2zWXZjUNZ30VzdWnw1+CyXmeiJbF2R2w6S3jr
 r17OHzJ8zUOgQnMvnis2uirDZTl5FkFnVkVvpraw==
X-Received: by 2002:a05:600c:1553:b0:493:c310:4106 with SMTP id
 5b1f17b1804b1-493c31041f0mr114749635e9.35.1783066222523; 
 Fri, 03 Jul 2026 01:10:22 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a44d7sm14920012f8f.9.2026.07.03.01.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:10:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] drm/panel: couple of visionox vtdr6140 driver
 enhancements
Date: Fri, 03 Jul 2026 10:10:18 +0200
Message-Id: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpuR2oC/43NQQ7CIBQE0KsY1mI+YGl15T2MC/r5KEaLgUo0p
 neX6kKNiXE5ycybG0sUPSW2nNxYpOyTD10J8+mE4c50W+LelswkSA0a5rwPJ488HZtLBTz3Nmq
 hgNuEXGis9aI2ujLIyv4UyfnLw15vnjmd2z1hP4JjY+dTH+L1cZ7F2PvnJwsOHBYtWmGdE65dH
 XxnYpiFuGXjUZZvlKx+UbJQaFVdkQMCpC9Kvaga5C9KFcq2TSOMclj6H9QwDHfV5f3IawEAAA=
 =
X-Change-ID: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=N33u7urcNff4XSanf+t1gY0lClgiA4xBRu96eeO026w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqR25s5qoN/KYr6yBDhlcee2Oj8EdJ0uFV/A9xPcCC
 VcUsH+6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakdubAAKCRB33NvayMhJ0bMWEA
 CGl/VOp0g6cPZFAKe3LIKUqYfvYspi5/6Er4zX//4wk+BRMJMZcUrvgbtYhrnToq/J96wGBlu+TShT
 PIWDUvVXDwGcATZ11aJ4y2e0/zPDaOHci9G3bIdwDkLeRyoaNd8JFegnBg4zbHsWyr4YheLr0EA8qy
 BYQ7w7tDKQBO2Kdhq+LOytttg6Claf9BVXo+YxTjdo/bMuYalMZlMXeCv0NtDvnWrrvSm2yywEx906
 X8OwOqHrluBniCR9a4BgWN3A0cnZ3qF09DzUkq2XKeP2F2N9oIpOSEqgUDq8ZQJtsIZm5+FqLKmUs0
 8GT3tu1EzUwzatHzlx1VR+EwllOlojxH8wKx1ZqYIbksO5HYDLhRejpMXFrk5HkYNhz0up3aZ5NP5k
 yCSjHCN2afuoISfTN+ei4IQBDFkmBNWS2q9MIJoQUsPDRBIV50AEnBTGd4g5LgxSGi8pbQzRAwxclU
 FOF9zcoS3m9fA/BXdjppTWCV6Qeicc0TL9OddJkzYZ6i0UZCrShMusZdjEyN+EnLJoyAmKb8eytCxo
 d16kMHAvbvrMiLIl8+j56vAkp0DyTxcQNJa/h5CVCsBAxOvxVqBkNvrx+sCbOS4V90sfGQfBas0xu0
 W0sCXd5lQjeSN36pZIgkZKpJ6++kO6WdybXvBnocZq31PktI0tVfKlBOHgsA==
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
Changes in v4:
- fix typo in Kconfig
- Add review tags from Dmitry
- Link to v3: https://patch.msgid.link/20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org

Changes in v3:
- add missing CONFIG_DRM_DISPLAY_HELPER
- Link to v2: https://patch.msgid.link/20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org

Changes in v2:
- select CONFIG_DRM_DISPLAY_DSC_HELPER
- Link to v1: https://patch.msgid.link/20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org

---
Jun Nie (1):
      drm/panel: Enable DSC for Visionox VTDR6130 panel

Neil Armstrong (1):
      drm/panel: visionox-vtdr6130: switch to devm panel calls and drop remove

 drivers/gpu/drm/panel/Kconfig                   |  2 ++
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 42 ++++++++++++-------------
 2 files changed, 23 insertions(+), 21 deletions(-)
---
base-commit: 44d19b8a7548aa25cbc6ebd5f27e958f7142c36b
change-id: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

