Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE9CC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FA410E206;
	Fri,  4 Sep 2026 17:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="enj6eA1a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mervg8XL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0C110E206
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 17:29:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HImlL3586967
 for <dri-devel@lists.freedesktop.org>; Fri, 4 Sep 2026 17:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=o6wa5ZvzXv5T3XPryztIZu
 COvwVbCLtIzQUjOAkt0Ro=; b=enj6eA1ayrUebdugQcndzpCccUMeN1fvBIcH7L
 8WVZ777XzuIkGS25h2Dvjr7vVNnutHPfuaLpBWuTJ1CtL3tdYyx1Ofg8YZl/Lg8d
 Gdrg9bdqUcEL+h9R0P+qZsufhO4q48IaI+o86GLv0yHhrw7jLOxkDKH8PQgH/GM7
 Jy306xLKLUS2whGwaA6gICHhWlFsNQXd1Z+o0PiMHpMjcuaFp2FnTcqW5ZDQQUFk
 IzbJ4Hlmz1Kda1Hb5IjzNIPNpaFNxQCMUsDzl78cjUB4vZvsJ7LxXBY0oS3tjSKb
 evKDzk0FrZKpfFL19BEs5I/8ZlzgDXBKAzGqFy2wkYM9edGw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp1fka78-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 17:29:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398bb9a6408so266470a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788542974; x=1789147774;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o6wa5ZvzXv5T3XPryztIZuCOvwVbCLtIzQUjOAkt0Ro=;
 b=Mervg8XLOpm7RpgjKZg6sceE2tFlTF1ZNm90t+B46+lwB5QS+PGACyRRZ8Q6yvC3dj
 vWXEiMLJWzX6j/7bLlhdkrMAGt3E2do3Z6DzsbBMqQ9t10ppmxx3/k/oxSOSciS4Y/tj
 S0g2H2wmwtMgQcF5AprcBIyfBQR+iw39PAMUc+zN9QjeljTphG7H8gcJE0s7Jop7YFfI
 fGBzocpaJ3t+bLY2SNNRpmwsqQjZoTPTqWGJ7mCDlqqF/SUtKd08lI65n+bb+lS/Afu1
 TXgXkWnjm+Osq9t7zh5lIsnmp6lKDPgHThvktUrQ484fatK1fzjhovC4qsLLw7e/OhdI
 tazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788542974; x=1789147774;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o6wa5ZvzXv5T3XPryztIZuCOvwVbCLtIzQUjOAkt0Ro=;
 b=Mni/6g4xoOMbYhiHqzrA1P3j2+GBFCjpqp62PgckCTiTE8z0rP/z0Y6sWfc/KZddM4
 bdbrbO69KBQbzfPyZ6893bHHC+glFjz0bFcOA1H/MMjGWjlWNBLLF/5C+SUSWdbcL4DQ
 7Ou14xmVSxOBoHCtSx156fK4MZNxtBHZRUCPoehQXRRgw1ySQOWLW/O4MmsSDQYjHyE7
 JdSnkNcV6UzoLTd3YqBdIppn2kj4thM39a0o9tuJSE9K4LkcZR0u6HSupwRviGTdam93
 p3bvdNuN9wk5LVJD995Ep5b7HScnk9FXzsaW4Gj/qFrwBwiEiQMMhyaK0mFMtPmu4Ctb
 hI+g==
X-Gm-Message-State: AFuF++nG3EzFXRw3/zOE0CUtYZCVc8dFUhNJvnjjCCwTLv489o8hMxhD
 XfpviR7wJoVGiq4gHNdGzl3xXURQWIRjU0DdTvpsazg069cDwoRatUx1XCT+Du3uA19xMyWBv6Q
 v9GelPMtp0Mj7CL/L+81LeUg/5jljvaMskxz/d+8gV/irqSbnt+gPRMcb3GqGV7MHM95t0F4=
X-Gm-Gg: AYBFou1q8OCxBXlscO6SsUWrH46tMrhP/7zYQsoQaaj4DgmT0BhPGAx0dIHh6g1FYxd
 E7VFaabhxu9chYhsd44zDNVAof9g8G1mb/gnzJLthq3o8WpFyHNFyTRW/+eqNyxxlOVJ5gcDO9K
 ScwbbYP/M5AZJUJ1Da03feAhwU7coVXvhTTWDAmH8zLc8KzW2EfwWn2LPHXbpYpfjOS8mwV3WL8
 dhZGHo26758UR5iC4rPjdRMUTq7b4iF5NDFosNKDwiXh0w+ANk4Zh5ZVJt4LtysmLDHXGpqeoz3
 TADyxpNMXzO+JwZ2Uon/a7tQv3Ivf/1gU5KOfaixhNwbRPPLtOolEU0gEpbYmjbd2evtPbnQRXd
 Mmg4BolgxpOE0wZtM300pCcL7T0Sac6MHNzm56JkIX1uw5P//h+P8aJnBBDM/IUrkWvf9UatLlR
 Do7YnNOIU7o3LmZuctSezm
X-Received: by 2002:a17:90b:574e:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-39b3d5dd778mr595446a91.2.1788542973525; 
 Fri, 04 Sep 2026 10:29:33 -0700 (PDT)
X-Received: by 2002:a17:90b:574e:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-39b3d5dd778mr595405a91.2.1788542973011; 
 Fri, 04 Sep 2026 10:29:33 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm12396019c88.4.2026.09.04.10.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 10:29:32 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Subject: [PATCH v8 0/2] This series adds LT9211C bridge driver by extending
 LT9211
Date: Fri, 04 Sep 2026 22:59:20 +0530
Message-Id: <20260904-add-lt9211c-bridge-v8-0-36d66168e176@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPD/mmoC/33Ny07DMBAF0F+pvMbVzPgxDiv+A7GIH6GW2gbiE
 oGq/DtuJQgLh81Id3TnzFWUNOVUxOPuKqY055LHcw3uYSfCoT+/JpljzYKADHQIso9RHi8dIQb
 ppxxrw/SEQ/AYHChRD9+mNOTPO/r8UvMhl8s4fd1/zHjb/svNKFHqgRRrGBICPo2l7N8/+mMYT
 6d9HeKmzvQrIQI3JZIgPVi0iZQGDhuSWiVC15RUlTAlsAw9RE8bkv4jkW5KukoabGKVArlgNiT
 zI1lQpJqSqVIXrPIelAnIG5JdJcauKdkqJWMjERoyzm5IvEqOqClxlTiGwViOhoNuSMuyfAPfQ
 e1XdwIAAA==
X-Change-ID: 20250910-add-lt9211c-bridge-5a21fcb1c803
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788542964; l=5884;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=B7nfWqGasNONmthzuGpOhvqXfRcUY5Px93+mZxgX2Zk=;
 b=Mgn72OqFE5IJ0D75DTxJZtokMKfgiLXu7BC0+u5bbSJLlt6v5oudsNIosprP6utFroZaqmEoQ
 NyXszHOkT7+CNUpIiCbUGKaLS0TKs85j9+7GSAfaMRnOOlDl+cKeZ7N
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=F+xnsKhN c=1 sm=1 tr=0 ts=6a9afffe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j8kyfJY6CSYuxqjyPqsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: B44QKMnc83Swwhj8GHesLer13pQiY-y9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE1OSBTYWx0ZWRfX4T9DTJikfzfk
 9i/egwZfLGWW66+MYE59wVnQd3oSr9QhaBBteZsutgTbUURqR2IQgbV3NOy4cHcOPIE65hJAbvx
 wQ4OD0qRPJE9muX5Jpgt32WZxmb3nwg=
X-Proofpoint-GUID: B44QKMnc83Swwhj8GHesLer13pQiY-y9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE1OSBTYWx0ZWRfX7szfz2TR03JN
 NugLB/MzX+LBG/Mit0/7ooSgsevTSh/AIsafbGLxob0ttoLW475f3T+YN93scxEbVVZcLa0pQak
 Dt69MngQJGfCmRdv2Ten6I9NsNZ9s7+iCffJ6b/Ryp8dyLwmbiYuTMmEs00E2tsXq++KmqdSApb
 drwN926N6o+uaFM3AjnpKyJ6Fif1PPQBZQl2SBEAwiv/YMadvfMnXBV2/T76K/8OQPxImAex62o
 pNzUz0C0z1djnuE1ko/07j26NmQK9lFoNzp+ztDXnFbTTehJi58qxG50uzangIyuES5+ETS6Bsw
 +h2TUnz4LR3fq5MiQfN1QJNiE/yjr7wcYPQFEz450Yd1PIJe2U66uWsdNAMWvNzxdOk9ccfvZvo
 vYV1dJVEUdXCi5Vf0skVzy2B5wfBuOUtlYC3ZtgoKfFYg6BW5wy2MSB1bIIcovO1PfwZte29HmY
 KSrae/Xj8sAUQIJHbIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040159
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

LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
This adds support for DSI to LVDS bridge configuration. By extending the
existing lontium-lt9211 driver to support DSI-to-LVDS bridge configuration.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v8:
- Addressed Sashiko AI review comments on v7:
  - lt9211_read_chipid() now cross-checks the detected chip ID against
    the chip type requested by the DT compatible string, instead of
    accepting either ID unconditionally.
  - Pixel clock overflow and divide-by-zero concerns in
    lt9211c_configure_tx() are false positives: lt9211_mode_valid()
    already clamps mode->clock to the 25000-176000 kHz LVDS range
    before any mode reaches this code.
- Switched the LT9211C deferred init from delayed_work to a plain
  work_struct/queue_work(), since the delay was always 0ms.
- Link to v7: https://lore.kernel.org/r/20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com

Changes in v7:
- Squashed 5 fixes from Philipp Zabel, except drop delayed work.
    drm/bridge: lt9211: fix regmap_write error handling
    drm/bridge: lt9211: use regmap_write_bits
    drm/bridge: lt9211: reuse lt9211_configure_timing in lt9211c_configure_timing
    drm/bridge: lt9211: combine equal branches
    drm/bridge: lt9211: use devm_drm_bridge_add and drop lt9211_remove
- Keeping the delayed work but improved the approach by reducing the delay
  to 0ms and wait on vblank irq to correctly configure bridge and autodetect
  RX as with synchronous approach in atomic_enable callback autodetect RX
  was failed to detect RX format/width/height due to stream was not live.
- Introduced lt9211_chip_data and fetched it via i2c_get_match_data(),
  removing the remaining chip_type branches. [Philipp Zabel]
- Switched lt9211c_regmap_config.cache_type from REGCACHE_RBTREE to
  REGCACHE_NONE. [Philipp Zabel]
- The few read-modify-write registers now use regmap_write_bits()) [Philipp Zabel]
- Merged the mode->clock < 22000 and < 44000 branches in
  lt9211c_configure_plls() that wrote identical 0x822f/div values;
  0x822c is now written unconditionally in every branch instead of
  being left stale when the mode clock moves out of the < 22000 range [Philipp Zabel]
- Removed the dead "set bit 0x80 then mask it off" on the 0xd026
  write in lt9211c_configure_plls() [Philipp Zabel]
- Consolidated the duplicated SOT / HS-settle-set write into a single
  hs_settle calculation and one regmap_write() call [Philipp Zabel]
- Fixed error handling on regmap_write() calls in
  lt9211c_configure_plls() that used "ret |=" across multiple writes,
  which drops the return value of an earlier failed write [Philipp Zabel]
- Reused lt9211_configure_timing() from lt9211c_configure_timing()
  instead of duplicating the timing register sequence [Philipp Zabel]
- Switched to devm_drm_bridge_add() and devm_add_action_or_reset() for
  the LT9211C workqueue, dropping the explicit lt9211_remove() [Philipp Zabel]
- Squashed LT9211C burst mode fix from Oleksij Rempel.
- Added Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
- Link to v6: https://lore.kernel.org/r/20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com

Changes in v6:
- Nilesh Laad and Gopi Botlagunta  moved to different org in Qualcomm. Further, i will followup on this series with community, will also submit the dt series where LT9211C bridge is used.
- Rebased onto current drm-misc-next (commit 671b7825dbfe)
- Fixed lt9211_read_chipid: LT9211 match no longer checks chipid[2],
  preserving compatibility with LT9211 rev U5 (db74b04edce1)
- Fixed indentation in lt9211_atomic_enable LT9211 path (was double-indented)
- Fixed indentation in lt9211_delayed_work_func body (was double-indented)
- Gated workqueue creation on LT9211C chip type only
- Fixed few formatting warnings with coccinelle and W=1
- Link to v5: https://lore.kernel.org/r/20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com

Changes in v5:
- Addressed code formatting in lt9211 driver (no functional or design changes)
- Addressed v4 comments on lontium-lt9211.yaml
- Link to v4: https://lore.kernel.org/r/20251224-add-lt9211c-bridge-v4-0-406e73ec28c5@oss.qualcomm.com

Changes in v4:
- Removed lontium-lt9211c.yaml
- Extended lontium-lt9211.yaml to support LT9211C
- Link to v3: https://lore.kernel.org/r/20251218-add-lt9211c-bridge-v3-0-1ee0670a0db2@oss.qualcomm.com

Changes in v3:
- Removed lontium-lt9211c as separate driver
- Add support to lontium-lt9211c bridge driver by extending the existing lontium-lt9211.c
- Fixed kernel test robot reported build errors
- Link to v2: https://lore.kernel.org/lkml/20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com/

Changes in v2:
- Combined driver patch from https://lore.kernel.org/lkml/20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com/
- Added MODULE_AUTHOR
- Uppercase to lowercase for hex values
- Link to v1: https://lore.kernel.org/r/20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com

---
Yi Zhang (2):
      dt-bindings: display: bridge: lontium,lt9211: Add lt9211c support
      drm/bridge: add support for lontium lt9211c bridge

 .../bindings/display/bridge/lontium,lt9211.yaml    |   5 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            | 837 ++++++++++++++++++++-
 2 files changed, 807 insertions(+), 35 deletions(-)
---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

