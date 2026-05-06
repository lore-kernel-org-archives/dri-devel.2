Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29564CD342F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 00:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E1A10E22E;
	Wed,  6 May 2026 00:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OfFDwYQE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B5C10E22E
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778028630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b9H8cYKTCyIKnl9+d/AL5JHJT5IYmUArCaFMH4v5EuY=;
 b=OfFDwYQEsLlW9dTnaELgrooZ06vF5Oiyqt7ArBPjW0gW6ZqAx26/H44nEZVEWLS9Wl2RUd
 MEqiHs2bNMK5An3Hcjx0wZ+eJZS3+n3WxT5s1/7dSvB4+imiOAFc+hmH69hHALxkKQa/tQ
 9tbaeLVeCTT782R+TA9wHTIGE383bQI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-cLRrSgbxP12EIXWNvjQgXA-1; Tue, 05 May 2026 20:50:28 -0400
X-MC-Unique: cLRrSgbxP12EIXWNvjQgXA-1
X-Mimecast-MFC-AGG-ID: cLRrSgbxP12EIXWNvjQgXA_1778028628
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8f87d6ce659so1212838785a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 17:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778028628; x=1778633428;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9H8cYKTCyIKnl9+d/AL5JHJT5IYmUArCaFMH4v5EuY=;
 b=TQw70SEsWetPD91rZkLk+XTCl2txNJZdGyAd4TGM1xuqWjRrFagt/CqQn7L4R/QblS
 1AMIGfyAXYuQVa660Fl1fT3HevuG4K8aTcRrcod2NmjTgxwkKQOO4BhCRXa0uA1s8xVY
 i2PdZcnXNz2OozdNkGn7TEQhWa9lnjn1WN2nUOdswBIcM1J7qtS7COJ4qW3vH6N/yCEM
 EQPvsAjQwDb795x8QamwCSyLks7WZ7hG2zU6qcwHzN4Wy5S71J8TZMrpqXm7rOMpob0O
 1PsxjCmcoKnFKSLeJmkzSekc+YDPYP/JsMITGGab1zgfL6GNOKWAwPcvbrO6Cj1blke4
 A5JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9w0dq9GKK/YMl6a7maPKRJiA52m7xuqzpyhda/x0/HPGBRmTYAjSp7M21eg1SKgMZgZc1RRzp4QjQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKBemz70z5ftbbTbIdVXkhiAiL1J1UiOasL2R+oE42NgzNsc9L
 JOGY9HeOTqgX4/JGq7SnjpVsSbKKhU9yp1eUvuxTioxO+1W9N286qDTUwtEDRseRz185gC0Lzha
 54/lXRvYppglYedyIvKqUijeOC2egij+gr8V9HidRcs8H85QoqZ1bfvFGUFJZen/tUqSaOw==
X-Gm-Gg: AeBDieu9kVysFZsJSESWye8EeWr8J4m/U6bh4D+waORsbu8KVfEBgpt5jQF8mN2MIQb
 RJVqcZmhn8vPEY4m/bqloSDAZiYv+52fpRNhTKmszIEQT4IC55PKFCCv0EVBomkQ0nv4JUtBKBI
 I17JZ+SMvNtFdY1pRtx0MRLGk3xROb82vO3UGeLiQ8ctEwyT81fKXm3F7T1a3oG59cnMwbvjpWS
 SA+BGadK5rlDQim5d5++UWa58Ta8ZQtDrdXzIPcPLbNjl2JvxxkMPJ6Z6HHdZoaIWy0iH1eUHwA
 IdojeR80m9fl3aP56K0uzYLOrT3ugwF6rKqeEuPQyh06wiFFsOWhrKGZGQV66OnkLUs6lu7TvZX
 YJsWjm66tyCxIan0vCM0A6B4iZtKw7iMYNPF4+cU1AOO5oF95HLApq7oAKb3/yA6fNHlCexus
X-Received: by 2002:a05:620a:454d:b0:8cd:7952:d449 with SMTP id
 af79cd13be357-904d5f00d9emr231852685a.29.1778028627965; 
 Tue, 05 May 2026 17:50:27 -0700 (PDT)
X-Received: by 2002:a05:620a:454d:b0:8cd:7952:d449 with SMTP id
 af79cd13be357-904d5f00d9emr231848285a.29.1778028627449; 
 Tue, 05 May 2026 17:50:27 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net.
 [73.183.52.120]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91fb3bsm1464933385a.41.2026.05.05.17.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 17:50:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v3 00/15] clk: introduce clk_determine_rate_noop() and
 update drivers to use it
Date: Tue, 05 May 2026 20:48:56 -0400
Message-Id: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDsQNVHpVYqLoH90aJvIREpBv
 LvB5bd476AMFWR6VgcpfpIlxYL2UdG0+riAZS6mxjSdccbx9HnzjB36lQhWv4NjShvXvXfWhn4
 w9UCl3hRB/vf5NZ7nBVsAcIVpAAAA
X-Change-ID: 20260505-clk-determine-rate-noop-17a544f78018
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Abel Vesa <abelvesa@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Anson Huang <anson.huang@nxp.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 arm-scmi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=zMeXAyyLpb1ycANNIw7NwRnIidpI1as921qDmQJS1JY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ/TXBhDD/HJ+irfPCG5f8LBYvv8Dx9dmqr4NPkLyFFK
 ++kbGS41lHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEFrEwMqxq53uRvrC91Ddt
 SpiPrVzUGZG/vn+yPrXy74upe2fVfJGRYcr2/5NeNj+qTdRbHh6S2B+gniyyo6Z0VsK7yHUStra
 VbAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rCM1xIfZlWA812PJ3skLUJ51dBKqqpdR0KGo4R2OoXs_1778028628
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

There are some clocks where the determine_rate clk op is just an empty
function that returns 0. This can be either because the rounding is
managed by the firmware/hardware, or the clock is capable of any rate.
Let's add a new new shared function to clk.c named
clk_determine_rate_noop(), and update all of the drivers that have an
empty determine_rate() ops to use this new shared function.

The first patch in this series also includes a minor cleanup to
drivers/clk/imx/clk-scu.c. I included it as the first patch so it
doesn't get buried in the middle of this series. I change this same
driver later in the series to use clk_determine_rate_noop().

Changes since v2:
https://lore.kernel.org/all/20260309-clk-det-rate-fw-managed-v2-0-c48ef5a3100a@redhat.com/
- Dropped the NOOP flag and just use a dedicated noop function.

Merge Strategy
--------------
All of this needs to be directly merged by Stephen as one series into
his tree. Subsystem maintainers: please leave a Reviewed-by or Acked-by
for Stephen. To reduce the noise, I am only CCing people on their
respective drivers.

Since there's only 3 drivers outside of drivers/clk that need to be
updated, I included them in this same series for completeness. These
should go through Stephen's tree as well.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (15):
      clk: imx: scu: drop redundant init.ops variable assignment
      clk: add clk_determine_rate_noop()
      clk: hisilicon: hi3660-stub: use clk_determine_rate_noop()
      clk: imx: scu: use clk_determine_rate_noop()
      clk: qcom: rpm: use clk_determine_rate_noop()
      clk: qcom: rpmh: use clk_determine_rate_noop()
      clk: qcom: smd-rpm: use clk_determine_rate_noop()
      clk: renesas: rzg2l-cpg: use clk_determine_rate_noop()
      clk: rp1: use clk_determine_rate_noop()
      clk: samsung: acpm: use clk_determine_rate_noop()
      clk: scpi: use clk_determine_rate_noop()
      clk: sprd: use clk_determine_rate_noop()
      phy: mediatek: phy-mtk-hdmi-mt2701: use clk_determine_rate_noop()
      pmdomain: mediatek: airoha: use clk_determine_rate_noop()
      pmdomain: mediatek: mtk-mfg: use clk_determine_rate_noop()

 drivers/clk/clk-rp1.c                           |  8 +-------
 drivers/clk/clk-scpi.c                          | 14 +-------------
 drivers/clk/clk.c                               | 18 ++++++++++++++++++
 drivers/clk/hisilicon/clk-hi3660-stub.c         | 12 +-----------
 drivers/clk/imx/clk-scu.c                       | 24 +++---------------------
 drivers/clk/qcom/clk-rpm.c                      | 15 ++-------------
 drivers/clk/qcom/clk-rpmh.c                     |  8 +-------
 drivers/clk/qcom/clk-smd-rpm.c                  | 13 +------------
 drivers/clk/renesas/rzg2l-cpg.c                 |  8 +-------
 drivers/clk/samsung/clk-acpm.c                  | 14 +-------------
 drivers/clk/sprd/pll.c                          |  8 +-------
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c      |  8 +-------
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c |  8 +-------
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c    | 23 ++---------------------
 include/linux/clk-provider.h                    |  1 +
 15 files changed, 36 insertions(+), 146 deletions(-)
---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260505-clk-determine-rate-noop-17a544f78018

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

