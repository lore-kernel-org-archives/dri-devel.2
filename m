Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCFC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170B810F666;
	Thu, 24 Sep 2026 15:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LcL6ZOeJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vmc9nzXn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ECB10F666
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OFeuZm3220540
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nfSTtB7CnjnuKHzDWEOktG
 VajU38a6DXdrzAiO3Dzy4=; b=LcL6ZOeJMSQE7etRqHMLcZUx+Idw6AqgZ0AcWV
 IYvxvPbKOn8z07PJSdpBc28tPqeQTSE24IDUY8XrQV8fGrBqjYehGyX/SvaRIknu
 DmiezVlpI9Q44Mull/VRDl3BeRqw/lmNCoZp62+CyPtWmEoKLdecUu5J1p1BcdoB
 uGZDIZgTFFMAKR9/T2vb3kYhnPAY4UEE+ry/XrZpY206/Inr2VA9bbQKkdKn8aQI
 C2i6rIKh+2rK5Ni8EmGje+O7Skiw9x3NeXHgmow8dTSBnJBnydNoM6h8vYavS56F
 AiWoxFHbybKC1pFT656i22qf+DwTgC32i0SLgPIAfURP5y2Q==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s91e61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:59:25 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66e608ab218so7333d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790265565; x=1790870365;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nfSTtB7CnjnuKHzDWEOktGVajU38a6DXdrzAiO3Dzy4=;
 b=Vmc9nzXnUitzeo1srQFaaC8PkKz/5poR0JAuhPsv4S4GjT3/asvBHn5ppbrljHjd/o
 sRiJ9eWh7Aqv3G75jkLxm08WVCghMRFMhHlRo9PtmgzX85PDP1MgwDC24KX7jU0v/twd
 Css2+gSyyMdojaut1rY/hs1XJP5oN5GFhAJcZnVc+XyoCQIda1bgx8PpRx9IJITj2xYL
 nXFg5XghXcdSGmJksu4mVmxaCML52xRGTzf2+EYE0KmnTX9RWn5EQ75+Axr41JA/gg+a
 OVXFWYXzMxLY9HeSQr5stdxfitMvOrbhufk6eoxMrfE6ijIS5XvCe9HB4VLb4Y3jkk0z
 qrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265565; x=1790870365;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nfSTtB7CnjnuKHzDWEOktGVajU38a6DXdrzAiO3Dzy4=;
 b=sVxjXJOB8FSY2tO+S+mhXUwh8CmBRvAUjGrKrlOfVvNtFZiYJ5P/qs5HIEoopCKJti
 8pAm8THavW0/pcckBRXgdZ+g0e8RKVB38C9kYoZ1goMNezrjo5aHwC3lxPt5qM8gN1UB
 0nF934aoLVXNJoxLYhJ8FHg2AAzjbuDV6DhGC6iFCaahP8WRRlFm+sh1kST1kZQwnNKy
 TeaPIF/P1ga8+4sXlw7nLOUg/B3ybDHBwGKQAk/ULl6wyz7t/1gtP5izLmFiLwT0g/kq
 x3/NaoWpynuAtN5kp7kr/MjQg4ozqjQyBwtR5SD7RcRCrTSqr+yRfdEPh7GZtASBUkq0
 uosw==
X-Gm-Message-State: AFuF++l0flQtoPMJm/RNuuvphYjJNpdqwAeEPrUL2A8DQssDAqpou1mA
 Gcn0wGdY71ZAH9egYl6Zy/WicCcY5tzIMLFrTwzltADR9JBDWaH3NdYCkf2TfoCioQox2RbX1az
 xrbq7GQGdkY2bOwPcJhDZz43KW8wyDD7l7rJKUQfIrfNVva+hM3HEAnZORYp64XsPMNCD3do=
X-Gm-Gg: AYBFou0sMQX7J3i6jU+m8dfUnaOYANol4vmENzM4maalK94iIMH1OPfekwuw3JzoKvA
 oKuHcvrq4KBS3RLt1wTGB2/wgttroHEmZRDARfCkyCQ113aduP2U8BXgJqA+u0zItkQbhNnwctt
 xw7MjvvnnRvF14vE5rI9hlA/RyWHqnfwWRizMKx08nAl14l/5enGcty5NS5S7+ZN7hHp93Ay2Td
 RK+xD5olVC8yyRIFKVrX+ahWZUVUu6PJicj4Y3j3//0pgqDjckss9ENM6YwgD1NKnPoe7vRNZqz
 PIzU+NIy94Mpmjw1dN9ZVYfGV9+f4p9NuzntZNl7I+EwCraxGnZrZ6as5aHF6HG8cL6BsKkcQx9
 /0aQE0/g/JbGEN9zjy9yjwlcD43ZxRmKcF7kg4XlEo8J3a0bdCNoqGkIpfsntl2l59Jk0shWmNo
 DD/hDRQ01xQYfR0zeS06QP
X-Received: by 2002:a53:e02d:0:b0:672:f638:6e6 with SMTP id
 956f58d0204a3-672f6383704mr1155142d50.3.1790265565264; 
 Thu, 24 Sep 2026 08:59:25 -0700 (PDT)
X-Received: by 2002:a53:e02d:0:b0:672:f638:6e6 with SMTP id
 956f58d0204a3-672f6383704mr1155106d50.3.1790265564675; 
 Thu, 24 Sep 2026 08:59:24 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d81e102asm2271003d50.19.2026.09.24.08.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:59:23 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Subject: [PATCH v9 0/2] This series adds LT9211C bridge driver by extending
 LT9211
Date: Thu, 24 Sep 2026 21:29:09 +0530
Message-Id: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1ItWoC/33RwU7DMAwG4FeZciaT7SROyon3QBzaxGWRthXaU
 YGmvjvZJCiHlEukP4o/W85VTTJmmdTj7qpGmfOUh3MJzcNOxUN7fhWdU8mKgBw0CLpNSR8vDSF
 G3Y05lReuJexjhzGAUaXwbZQ+f97R55eSD3m6DOPXvceMt9t/uRk1atuT8RZ6QcCnYZr27x/tM
 Q6n074c6qbO9Cshgq9KpEF3wMhCxoKPG5JZJcJQlUyRUATYQwupow3J/pHIViVbJAss3kikEN2
 G5H4kBkOmKrkiNZFN14FxEf2GxKvksalKXCRxnIjQkQu8IflVCkRVyRfJp9g79sn5aDeksEoN1
 PcUimQ4cfm9IOhrMy3L8g38SeivwQIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790265554; l=6411;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=ydudDu5jBsMjX2oGdpjCZVgEDwqXfRt4QuPNX5P8jGQ=;
 b=fxGCroy6njAh8Onv5T5JwmA9hYLsab9FY3gLSf4latr0PfRii8vuC5dAcpbk/iwxJwWrW8b0M
 SHpM1sDygF3BPdbo2XqxKOWahy0xKiEif4+pmX+L9VOcAkmh40IzlHR
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NSBTYWx0ZWRfXyxxgGL4ry29y
 1TW13mYxc182HWoizush9Zw9+EalnTLCFQbqvXFLf6Y+nUbrl2dfBI71LattLjdcyz/Dd/JtBqc
 LQvux1iQo495gwx5hzoXfdfb723gEcEY1BkBVND93XCwf3N2eS9wbdTFwAd0ncU4KEqsLwOH9ZQ
 jgUmnCTf0WcdtZOYbaoPAZ55TE5agjOpEpfs/nNU0rG3uLrUzyLt5qEdw2JP8AKvyyrlr7FIkLu
 BGqSn45BqzfP6+mPZ3Ybm5Xb/F2UJdeZxYfJ6Rqc6tv79gMV1a/rNz97BNorcI8gxeifsC7KgwH
 NJSS29PT9q+aE5m0fB7oHUjOlS7YlB+zW2UgMVWsfSZkECrLIx507T1Od2yEapg9mf2u/3buNrG
 hJH88zjZHRqLixHes4WvXdrw6fzXdjPTQvoYej42lkZalwq31Gc3WRxhLwR3gC8Xp82U8UZgKTp
 wywxE+xTKwijGAjDI5w==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab548de cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AhwvnLMPz7v9dBksGrUA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NSBTYWx0ZWRfXyPxuikJvFb/2
 rAY06VdXNN8mu/Cbp+D+FP4SuP6pIthr9RvkUO/Y9+YHxjXX/my5eDav7l1hrY521eBDlViiBQb
 1dxAZXkRMFlapA3VlC+FJWpK2LFbWdQ=
X-Proofpoint-ORIG-GUID: c2BeDZhx8LzY-_kCyPNaBCye24Wip1Uj
X-Proofpoint-GUID: c2BeDZhx8LzY-_kCyPNaBCye24Wip1Uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240065
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
Changes in v9:
- Rebased the series on latest branch.
- Fixed a use-after-free reported by Sashiko AI review: the LT9211C
  workqueue teardown was registered via devm_add_action_or_reset()
  before lt9211_host_attach() created ctx->dsi, so on unbind devres
  would free ctx->dsi before flushing/destroying the workqueue. Moved
  lt9211_host_attach() before the workqueue creation so devres tears
  it down first.
- Link to v8: https://lore.kernel.org/r/20260904-add-lt9211c-bridge-v8-0-36d66168e176@oss.qualcomm.com

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
 drivers/gpu/drm/bridge/lontium-lt9211.c            | 838 ++++++++++++++++++++-
 2 files changed, 810 insertions(+), 33 deletions(-)
---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

