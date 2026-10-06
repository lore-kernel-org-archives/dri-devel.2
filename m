Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CC0CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 23:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE3410E261;
	Tue,  6 Oct 2026 23:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bv2ZRxva";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A85F10E261
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 23:19:46 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-150f88d22aeso2234746c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791328786; x=1791933586;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L71GPMsk4GSIdxEygBnLFVf0LVf2CMTomc/BzDysxCo=;
 b=Bv2ZRxvak2ots59evESEfcejEUgmNkocnE7qAxRyRqJ1OM4gvu3cHe9Y8gxIDxEStc
 0QnpmmgsG0LF55yn5Let2ub6lbGw5Hj08pjPQ+FLiGKwCCR1bSCquPaVuY6n7tylq7Op
 GK+W72aIUDAqelMhSCiD7EVjw9RbOIcZ1twjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791328786; x=1791933586;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L71GPMsk4GSIdxEygBnLFVf0LVf2CMTomc/BzDysxCo=;
 b=DGuEsO8XJEV/qOIUGrFW3DHVM/qbg6tQcM15VwGJ5+RUiFOmF+GBMuFZguNjsj91Tt
 0Cx6xu0DqEZD5jAxlKZTtrl2YMleTWMTm1OQ805B8Rq9TWR++E/zl873q2/71vsAgLnh
 9ArOLpMZ+r5tqEeF04pQpQr9RfafDpNhSZ68U84mox4R0OOKQTgPWlm7qZ0tY2Z7N7PK
 BQAgqPhv+Df2ZpSwmMslxtnoly7FeVemgxB3RzuhtUdoPyQ1Aq1v5dkRslPvn2jhZofy
 mAuR9JFPg79++B/hn9Xt87kNVHg57gSoBcmu3+zUV7vsapMA3sA6QnVD4yKNbz+CKK4I
 o/cg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBuWacrjOVM8u958W5g+ipdnTyLvcj2l8s59Jk4ADMRN9ro3UREItIZuE8srd0M2I54pDo/TvnULs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++klirFYl+mV08H/FyuhEAv3hN9s5PAuDtJ7jD/21fzSpRhMajdw
 3iHQ23qRdq8BW/z7i1z4Fz6pn8z7Sx2XfJPMLsy8M3QTw80DsC3h3U4yIDGSrjTF0Q==
X-Gm-Gg: AYBFou1pTP8aSeUP9iyEcn25zt9Zbx+PJPsgf8h7Bj3TAHctFsuqLijEf90i2HLr/76
 YXvMYdSNEMyDhh9SHCy6u3zCxilxuNi373SALYOy0FGCbAeKVqBE+kEZMAqWEti9eipbPv5KJu1
 ELqAOUV98ONnUfSlKltK+jVUmdT7kxn2Aw3iOaymOMbbg15ayO7dPmFJQNK7SfgtSpanDFY2aU9
 tdXAG/hdloiCgs3uqypq+TpBqiTLUHR6VEO6bwWtp3QvC+wHb1m3nw2NoxBanXW4W8B8GuUQL8x
 xIb6CvCw2cmfL4XO0YIdEDPRd3+YoEkU16er7t9cEPWGvb6+XasAIZ8NUGWM45OeCsMAiFVfsDV
 nFHy19wo6IVgyWF8NK4TwfW8M7BPYgUI1voGd5BhqdZbIpOrLOkqz5xRhSAQsm1UVMeWVGSci/s
 PyLBQmsUNThlS8RnAZvSmWrkCR9zomp6NAZrGctSD4eQwWPJnNgErvysNJp6aM8PYzrkUNPcczq
 FIWc/I9oblaUHiQjawEuEoi54/9KjFmPdC33w==
X-Received: by 2002:a05:701b:4553:10b0:151:7831:e401 with SMTP id
 a92af1059eb24-162045b8dcfmr323314c88.15.1791328785498; 
 Tue, 06 Oct 2026 16:19:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
 by smtp.gmail.com with UTF8SMTPSA id
 a92af1059eb24-161680e191esm1583634c88.11.2026.10.06.16.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 16:19:44 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Alex Elder <elder@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 David Lechner <dlechner@baylibre.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hadar Gat <hadar.gat@arm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jaroslav Kysela <perex@perex.cz>, Jessica Zhang <jesszhan0024@gmail.com>,
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Brown <broonie@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Olivia Mackall <olivia@selenic.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Rui Miguel Silva <rmfrfs@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, greybus-dev@lists.linaro.org,
 linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-staging@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: [PATCH 00/13] PM: runtime: Convert pm_runtime_put_autosuspend() and
 friends to a void function
Date: Tue,  6 Oct 2026 16:13:28 -0700
Message-ID: <20261006231900.3230373-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Similar to this effort:

  Subject: [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
  https://lore.kernel.org/all/6245770.lOV4Wx5bFT@rafael.j.wysocki/

i.e., commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void") and friends.

As with pm_runtime_put(), there is very little value in return-code
checking for any of the other async __pm_runtime_suspend() and
__pm_runtime_idle() APIs:

  pm_runtime_put_autosuspend()
  pm_request_idle()
  pm_request_autosuspend()

Checking the return code is more likely to
produce a race condition (fighting with user space writing "on" to the
"control" attribute) than to tell a consumer useful info.

Nobody outside KUnit tests checks pm_request_idle() or
pm_request_autosuspend() return codes, but there are a number of
pm_runtime_put_autosuspend() callers that check its return code. Thus,
this series largely deals with pm_runtime_put_autosuspend().

Patches 1-11 are independent of each other, and similarly to the last
series, I expect the respective maintainers can pick them up. We can
apply patch 12 later. Patch 13 is also independent, but included in this
topic for completeness. It can be applied any time.

This touches a lot of trees/maintainers, so I tried to keep CC's only
for the relevant patch(es), plus the cover letter. I hope that's not too
noisy.

- Brian


Brian Norris (13):
  hwrng: cctrng: Discard pm_runtime_put_autosuspend() return value
  drm: Discard pm_runtime_put_autosuspend() return values
  iio: Discard pm_runtime_put_autosuspend() return values
  media: venus: Discard pm_runtime_put_autosuspend() return values
  pinctrl: qcom: lpass-lpi: Discard pm_runtime_put_autosuspend() return
    values
  spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
  greybus: Discard pm_runtime_put_autosuspend() return value
  ALSA: hda: Discard pm_runtime_put_autosuspend() return value
  ASoC: codecs: lpass: Discard pm_runtime_put_autosuspend() return
    values
  ASoC: intel: atom: Discard pm_runtime_put_autosuspend() return value
  ASoC: SOF: Discard pm_runtime_put_autosuspend() return values
  PM: runtime: Drop pm_runtime_put_autosuspend() return code
  PM: runtime: Drop pm_request_{idle,autosuspend}() return codes

 drivers/base/power/runtime-test.c             |  8 ---
 drivers/char/hw_random/cctrng.c               |  6 +-
 drivers/gpu/drm/panel/panel-simple.c          |  8 +--
 drivers/gpu/drm/tidss/tidss_drv.c             |  7 +--
 drivers/gpu/drm/v3d/v3d_drv.h                 |  4 +-
 drivers/iio/accel/bmc150-accel-core.c         | 14 ++---
 drivers/iio/accel/fxls8962af-core.c           | 11 +---
 drivers/iio/accel/kxcjk-1013.c                | 15 ++---
 drivers/iio/accel/mma8452.c                   | 15 +++--
 drivers/iio/accel/mma9551_core.c              | 15 +++--
 drivers/iio/adc/rcar-gyroadc.c                |  4 +-
 drivers/iio/adc/ti-ads1015.c                  |  8 +--
 drivers/iio/chemical/atlas-sensor.c           |  4 +-
 .../common/hid-sensors/hid-sensor-trigger.c   | 14 ++---
 drivers/iio/gyro/bmg160_core.c                | 17 +++--
 drivers/iio/gyro/fxas21002c_core.c            | 12 ++--
 drivers/iio/imu/kmx61.c                       | 17 +++--
 drivers/iio/light/apds9960.c                  |  2 +-
 drivers/iio/light/isl29028.c                  | 15 +----
 drivers/iio/light/pa12203001.c                |  3 +-
 drivers/iio/light/rpr0521.c                   | 15 +++--
 drivers/iio/light/tsl2583.c                   | 27 ++------
 drivers/iio/light/us5182d.c                   |  3 +-
 drivers/media/platform/qcom/venus/vdec.c      | 10 ++-
 drivers/media/platform/qcom/venus/venc.c      | 10 ++-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c      | 16 +++--
 drivers/spi/spi-ti-qspi.c                     |  6 +-
 drivers/staging/greybus/power_supply.c        |  8 +--
 include/linux/greybus/bundle.h                | 12 +---
 include/linux/pm_runtime.h                    | 63 +++----------------
 include/sound/hdaudio.h                       |  8 +--
 sound/hda/core/device.c                       | 13 ++--
 sound/soc/codecs/lpass-rx-macro.c             |  4 +-
 sound/soc/codecs/lpass-tx-macro.c             |  4 +-
 sound/soc/codecs/lpass-va-macro.c             | 17 ++---
 sound/soc/codecs/lpass-wsa-macro.c            |  8 +--
 sound/soc/intel/atom/sst/sst.h                |  2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c  |  4 +-
 sound/soc/intel/atom/sst/sst_pvt.c            |  9 +--
 sound/soc/sof/control.c                       |  6 +-
 sound/soc/sof/sof-client-ipc-flood-test.c     |  5 +-
 .../soc/sof/sof-client-ipc-kernel-injector.c  |  4 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c   |  6 +-
 sound/soc/sof/sof-client-probes.c             | 18 ++----
 44 files changed, 152 insertions(+), 325 deletions(-)

-- 
2.56.0.360.g66cac248cb-goog

