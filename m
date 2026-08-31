Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B676C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8971D10E6F0;
	Mon, 31 Aug 2026 08:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Znhj7JfR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORCOxCy6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C354E10E6F0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xLTf2332563
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HX0TtP1Vb/NHM85LfX8GMg
 ydl3O6Uu01GFUhUZo+Tjc=; b=Znhj7JfRtT8Z3Dyj82nAC65teE70KHQmv2+ojn
 gxknWyG4QVrh+mtVG73kCigJknPS5C/gIAL0bIyyAZgC/IINXnWXB16aCwwLNmR1
 qKHOrkOqbSYiRJziVtSFVcqXirX9XydepDYCoDCRtZ5hobIUrNM3r/GAEF7in1+J
 Viq81GYD2Px3ZABHZnJggWo415vfE6d8n5LMvTjU10Bfn9/QW0oDRlHeQI6caHKs
 7AGk0H7Uh4G1VOkRlLmYwtdi7SyROWVtRaJyrtbJaGIm+wYhtlRfhb7rSSRyrEaa
 F70sjiWwJAq2QoAqMZ49VsoL4nPwZv/B8olzRMJdp/YL1LKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq856qt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so486878185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164254; x=1788769054;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HX0TtP1Vb/NHM85LfX8GMgydl3O6Uu01GFUhUZo+Tjc=;
 b=ORCOxCy64DSpNHp6xIyrbAvsD81JhWHveZHrr7zfRuu/Lo6qDjYrCTK92vX0Ze9fqH
 ZXmWopb4nnXf79pOknpBh82eqzMr17yUC55OVmaqvztLO7+t2Je4c/gpLF82alQQ0eJQ
 bkMR0/PSOFIrzF9lNXuW1KJ9OMRpsYEuD39L4GZf6Oo26LjMGZGh++XOoLdRIIXN3Ekm
 +XLH8/p7pwBfoa/Stln4Q3A+OOzOFAtFTfZFpcYsaTRRrIp1WX80N8EMjvHgFAiCW626
 VV0/hHHYfJ9N4fjTdlh3SxBtJ5Ex/wny8sqIeCYwdKlgxpBRxUV3cPuzSE5OXRKopIUr
 NNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164254; x=1788769054;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HX0TtP1Vb/NHM85LfX8GMgydl3O6Uu01GFUhUZo+Tjc=;
 b=ruTlHBZvxe2LDW60f+YG6aSqxK3rbqYOCnyaaMrnRY2oejqWa5jEQJMEf/f6ffopyY
 Xm9ogezsaebrFr9H2u6Q/S24yTu6iqpJnM306AjDES6oBC4vfX/98CJyW3/UNz1yx1Fv
 fMV5eVZj243ee50AvYAo4GJrRcJ1byluJVdfvNaJQEedGqeGWvpJzS9f5FbfQn0zjx3t
 52UUPs70YMJ+CAKp7S7e3xJXZEWpYNDFrPhusuNCjGmlYFm+d0Tu+FRvpXV37ze+6HDX
 8JX2Z/7ulgKUJhfSjWDHopcGmmQWoH59cpucMtpQNgGi7z+AcywNOXaC82jiVsVD89WO
 IeKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYCNQHilDZjIbLWQX9IvlmicHjQAquxCmo9Rk2F5kPrvv58DkJbg4dhFdZWRhZl10qmy9n+HE7Wbo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nT1sDLqjIMTMiRbQ4I/0tsC0098krz6hI9d8C4Nj9aZDh5WOdF
 HBv+i3COxvh8ga3LV8buVJmDjZEO/LNrFlXEWtRIzGuyUd6lIowMbPlWLXL0oJrK+7+31ETko1G
 PkRpXepkkZMGwqaVEQMOxhq1ox9x3I+o92l6WdjGRmUSncMAmNSz+0jdTxvDifYnBTa0pCiQ=
X-Gm-Gg: AR+sD12VSKrGzNG/UOnBTgoBg+LGhVbQEUvrOwzb9i+KNxqpsm9e4X06z+tLPIbr3yj
 O5WIdQyndcV9e5r85W7WYiX+wKVZTGJ4RgUYIpx4TBOxdEe8TfMdj46RmfjfVe8EMvC/hSu6Tg1
 YduUdFX0Jz/OgE8Qj4JgfE5/FhwYjc2oYPV/bfFaqLPkVUlkiJHsuxWmjcdMTTEuHmxRTWStoQf
 3mmqx4+zEWC9ct1k5xzylcg7sLIVEjY8YQ2lfssgGGHb3J+A2wYAws0HntVy6gEeckPRN/UWoUF
 wSbyk3Xns3dTp1UbaTM/D1P9JOIL7IzGgA8CJflHnSbeXbcerZQrj0qqkkxvEZAnipqQITdMH3b
 XNzYGtitLQitivMMB/mLntSaxdGmGgC7jfwuxjnVqkHeisHpfoE24GpYVMrnPLR0=
X-Received: by 2002:a05:620a:630f:20b0:937:3a1d:175a with SMTP id
 af79cd13be357-93913794454mr2100549785a.3.1788164254031; 
 Mon, 31 Aug 2026 01:17:34 -0700 (PDT)
X-Received: by 2002:a05:620a:630f:20b0:937:3a1d:175a with SMTP id
 af79cd13be357-93913794454mr2100545985a.3.1788164253378; 
 Mon, 31 Aug 2026 01:17:33 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:17:33 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v6 00/29] drm/msm/dp: Add MST support for MSM chipsets
Date: Mon, 31 Aug 2026 16:17:17 +0800
Message-Id: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI04lWoC/23OzW7DIAwH8FeJOI/KGHBIT32PaQc+3BVpaVpIo
 01V3n00PUyTesDob8k/+y4ql8xV7Lu7KLzkmqdzC/TWiXjy50+WObUsEJDAKJBjHWW6tG+W2io
 NgdgFZ0QbuBQ+5u8Ne/945sLXWzPnZ1MEX1nGaRzzvO9YAyE51N4A9Wgj4xBib2NwHA31SbNij
 SQe1inXeSo/252L2bBXJy1GggwIVrnEvr3DVOvuevNfj627VjZtsX8C4fBPsE1QyTlMAyg8mhf
 Cuq6/5g9rCDkBAAA=
X-Change-ID: 20260410-msm-dp-mst-35130b6e8b84
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=9704;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=t+Q1qWhln3sjCSLlRA6F/QwwMt4akMg3L+tdEaits1Y=;
 b=ooWIYyJOLoQg5UH59drn28lbAvPscbzaSpPBKc6nM1sPlCs+IXEzog3QWzNE+gwUAgcJp9TN1
 nu36N1iyJBGCkAh+6AZsTKV+QlKYW3/0IYme/fqywdpcWqlub4Sb3W+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: i75fxehZTE4pbpUpgv8JAFodYBLbTt7f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXyLZ8IYH20CJh
 ks9OgcGeVtBt7hDIYvchChwq+ZwZihim6KVfpaRnOmpFF92i5YGpfUYn+F2Jbvi2afewRsU8Rza
 xcVICpzBskYu/e33VkRrNokGOhtx3sw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXzzuwoh0BKDEm
 5FHt6RBYHy0uVi1efnb9vhuoXOWmdecM2RNoCbufPdmzpRRtivAAJjIusdiACackwWY20TT1gLT
 gZuCKbQjBGD6KonI+TaPm/owr+W3nwN5o/1McOjrgANK7bmS7EKs89Bh881UaFlmBRvd3Ybyrln
 CY36bLDu0wcHexG9WrRKTD8ZPxXvfXxIuELDoshZ8Uo7gaOHibsZ5YL0xBjAStRrT4Q1ok94ZGr
 LMU7bADL98YZuuDyfjNzZcX7gWLIHukvFDp/nsl1Yav3BfaWdvXDFW8dHfVlycbcd6WWdz2PtC6
 08EttHXx8VKyzWNQ5zSlO3hvW1SJZenwkjRPgf/TXieeom2NjNBPA0XgpkryTvZ03g4VBUEcECH
 5IdC9OQYbZEIvE+NKJK2z+qrSW6pzkNi9xy/8je28Mvq1rR+TIhPON762NGb/+XzDpsWaxTFybi
 s0UGL9HTCkrCzi6QZug==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a95389f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=HzqZzwtbLOXzCu1XSVEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: i75fxehZTE4pbpUpgv8JAFodYBLbTt7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

Add support for Multi-stream transport for MSM chipsets that allow
a single instance of DP controller to send multiple streams.

This series has been validated on sa8775p ride platform using multiple
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.

With 4x4K monitors, due to lack of layer mixers that combination will not
work but this can be supported as well after some rework on the DPU side.

In addition, SST was re-validated with all these changes to ensure there
were no regressions.

The prerequisite cleanup series [1] has been merged into linux-next.

Type-C MST support depends on the DRM IRQ design which is still under
discussion, so it will be updated in that series first and folded into
the MST series once the design stabilizes.

Overall, the patch series has been organized in the following way:

1) First set are preparatory refactors to decouple link-level and
stream-level operations for MST readiness.
2) Prepare the DP driver to get ready to handle multiple streams. This
is the bulk of the work as current DP driver design had to be adjusted
to make this happen.
3) Finally, new files to handle MST related operations, DPU encoder
integration, and SST/MST connector state management.

Note:
Validation for this series has so far been done on the latest linux-next
on LeMans, covering both FB console and Weston.

[1] https://lore.kernel.org/r/20260528-dp_mstclean-v9-0-f094cea8ca24@oss.qualcomm.com

---
Changes in v6:
- Rebased onto linux-next 20260828; drop already-merged prerequisite
  cleanup patches.
- Reordered patches for better logical flow.
- Patch 01: Also move power_on=false into display_unprepare.
- Patch 02 (new): Split from old patch 04.
- Patch 03 (new): Split from old patch 04.
- Patch 04: Squash num_pixel_clks into this patch.
- Patch 05: Use loop for snapshot; skip inactive streams before adding.
- Patch 06 (new): Split register definitions out of old patch 04.
- Patch 07: Rewrite old patch 04; replace stream_id special-casing
  with transparent msm_dp_read/write_link() helpers.
- Patch 08: Fix REG_DP_MST_ACT register placement.
- Patch 13: Drop defensive start_slot bounds check; rename
  channel_alloc -> update_timeslot.
- Patch 14: Guard link training with active_stream_cnt == 0.
- Patch 16: Add locking annotation; group link_ready with status
  variables.
- Patch 17: Drop redundant stream_id >= DP_STREAM_MAX check.
- Patch 18: Consolidate msm_dp_mst_attach_encoder() and
  msm_dp_get_mst_max_stream() definition, declaration, and usage
  into this patch.
- Patch 19 (new): Split connector/topology callbacks out of old
  patch 23+24.
- Patch 20 (new): Split dpu_encoder_get_intf() refactor out of old
  patch 21.
- Patch 21: Squash stream_id condition; reorder before MST encoder
  patch.
- Patch 22: Use thin wrappers instead of renaming/exporting core
  dpu_encoder functions; use suggested for-loop style.
- Patch 23 (new): Split atomic stream enable/disable/check out of
  old patch 23.
- Patch 24: Add hpd_irq_lock; use %*ph for ESI debug prints.
- Patch 26: Defer SST-disconnect-on-MST-cap to new patches 28-29
  to avoid bisect breakage.
- Patch 27: Add comment for clear-before-write DPCD sequence.
- Patch 28 (new): Split from old patch 14; handle boot-with-cable
  SST bridge detection.
- Patch 29 (new): Handle SST connector status when MST is enabled.
- Link to v5: https://lore.kernel.org/r/20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com

Changes in v5(fix comments from V4):
- Dropped early refactoring patches (v4 01-12); restructured as
  "move link-level teardown", "factor out _helper variants", etc.
- Dropped v4 39/39 (platform MST stream list); use DT pixel-clock
  count instead per Dmitry's request.
- Patch 02: Remove artificial max-stream limitation check.
  unify register naming (REG_DP1 vs MMSS_DP1).
- Patch 05: Calculate ACT wait time dynamically from mode parameters
  instead of hardcoded 20 ms.
- Patch 08: Replace start-slot loop with direct math; fix commit message.
- Patch 09: Add locking annotation "Must be called with
  msm_dp_mst::mst_lock held" to msm_dp_ctrl_push_vcpf().
- Patch 17: Rename prepared flag to link_ready.
- Patch 22: Move drm_dp_mst_atomic_check() call into msm_atomic.c.
- Patch 23: Replace bridge-based MST DRM model with encoder-based
  approach; remove redundant bridge layer between encoder and connector.
- Patch 24: Add drm_edid_free(); add FIXME for bpp negotiation.
- Patch 25: Use dp->plugged flag instead of link status for MST plug path routing.
- Link to v4: https://lore.kernel.org/r/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com

Changes in v4:
- Fixed most comments from V3.
- Rebase onto HPD refactor V5.
- Fixed casing/formatting issues, for example: “mst”.
- Drop .mode_set() and set_mode in .atomic_enable().
- Rewrite commit messages that are unclear.
- Use the same API for MST link and SST link writes.
- Use the new drm_dp_dpcd_read_byte() / drm_dp_dpcd_write_byte() interfaces.
- Remove some unnecessary payload fields from the MST bridge.
- Remove some defensive NULL pointer checks.
- Reworked the patch order to make the series easier to follow.
- Add support for more platforms.
- Link to v3: https://lore.kernel.org/r/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com

Changes in v3: Fixed review comments from Dmitry
- Fixed lots of comments from series V1/V2.
- Rebased onto next-20250808.
- Rebased onto Jessica's HPD-refactor branch.
- Fixed formatting issues in commit messages under changes.
- Removed unnecessary one-line wrappers.
- Relocated MST-related .atomic_check() calls to their appropriate positions.
- Removed the logic related to slot checking in .mode_valid().
- Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com

Changes in v2: Fixed review comments from Dmitry
- Rebase on top of next-20250606
- Add all 4 streams pixel clks support and MST2/MST3 Link clk support
- Address the formatting issues mentioned in the review comments
- Drop the cache of msm_dp_panel->drm_edid cached
- Remove the one-line wrapper funtion and redundant conditional check
- Fixed the commit messgae descriptions of some patches
- Reordered the patches and renamed some functions and variables
- Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
8618d42a99a@quicinc.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

---
Abhinav Kumar (16):
      drm/msm/dp: move link-level teardown from display_disable to display_unprepare
      drm/msm/dp: introduce stream_id for each DP panel
      drm/msm/dp: add support for programming p1/p2/p3 register blocks
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: add support for sending VCPF packets in DP controller
      drm/msm/dp: add support for MST channel slot allocation
      drm/msm/dp: replace power_on with active_stream_cnt
      drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
      drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
      drm/msm/dp: add HPD callback for dp MST
      drm/msm/dp: mark the SST bridge disconnected when mst is active
      drm/msm/dp: enable MST on capable sinks
      drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is present

Yongxing Mou (13):
      drm/msm/dp: refactor msm_dp_ctrl_config_msa() to take panel
      drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
      drm/msm/dp: add MST stream register definitions
      drm/msm/dp: add stream-aware link register accessors
      drm/msm/dp: add link_ready to manage link-level operations
      drm/msm/dp: introduce dp_mst_drm module
      drm/msm/dp: add MST connector creation and topology callbacks
      drm/msm/dpu: pass msm_display_info to dpu_encoder_get_intf()
      drm/msm/dpu: use stream_id to select MST interfaces
      drm/msm/dpu: add per-stream MST encoders
      drm/msm/dp: add atomic stream handling for MST
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: mark the SST connector disconnected when MST is enabled

 drivers/gpu/drm/msm/Makefile                |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  51 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  27 +-
 drivers/gpu/drm/msm/dp/dp_audio.c           |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c            | 479 ++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |  19 +-
 drivers/gpu/drm/msm/dp/dp_display.c         | 414 ++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h         |  26 +-
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 538 ++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  16 +
 drivers/gpu/drm/msm/dp/dp_panel.c           | 205 ++++++++---
 drivers/gpu/drm/msm/dp/dp_panel.h           |  19 +-
 drivers/gpu/drm/msm/dp/dp_reg.h             |  69 ++++
 drivers/gpu/drm/msm/msm_atomic.c            |  14 +-
 drivers/gpu/drm/msm/msm_drv.h               |  41 +++
 drivers/gpu/drm/msm/msm_kms.c               |   1 +
 17 files changed, 1727 insertions(+), 199 deletions(-)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260410-msm-dp-mst-35130b6e8b84

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

