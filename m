Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051DC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A134110E034;
	Tue, 29 Sep 2026 04:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2rbQMZZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMIjtdS2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DF710E04B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47lf03655328
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=RhwLyzv0xmHZsdALpjYVq9
 4Yd1TMs+lP4JJOXIvSkqc=; b=c2rbQMZZqeocrctwDKdJudZqVlXJX+X/5ZsyZy
 dd6V0vU3fJB476Ih1W12PlAWHjZowvX6S6xuSlR1UF5eAhr8Co+ouaJ9vVm8kSY+
 3Z5CimjY1bQWULgx8fqYslyUDeP5K/SL+G7ShNet7kPTEirJdazZsXlq+rUxXXvP
 7pRKjdmeSqXe4sxgI+BI0Ytk8Ndnx15b0PwItfAqe41G8oC4M9jnNPCyI0BzfVY0
 PWBsKYLvYSr48RoLQMaFO6ri4HYGOIlHfUqhY8hJTWHvw9NKt4xBez7IFH6lKrxd
 vF8GOuDkuD7IbZy7QMfGrNG/Cu+grsiZixERF/e7aMEbCGig==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew0jrq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:26:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-914355c5a51so68832616d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790655990; x=1791260790;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RhwLyzv0xmHZsdALpjYVq94Yd1TMs+lP4JJOXIvSkqc=;
 b=EMIjtdS2nS3VezZCC1lOeLMRJgjRz+nrQCoQHcvad4N/baYaZKEXvCQ9f4VzJbwVRz
 H2i2zDdGfdGoIHktWxJZRu3BDb6d1FjbWeai4KQ97iSXjjjdC3tgeXLv1tx6LAzNIPkW
 gslw/YQ7+YVjPBvXYUiaRhMtTmlxVKwt+BxlfpcHwVmvlXuzarFyxmZnM0WHaQFd8BqN
 4ldqxVM9mHkdYP9O3eP/8ILLUMkjcM47tXcQiLRQNx/ASx8qUr+lE5oWqDlr04vpm8zc
 R+f6dyiGEUNGMc9oLuJO9pIhMTifWkNt0NWOETqRrEGLLb8gXTVkUtOz5iwRqDrgQrY5
 hnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790655990; x=1791260790;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RhwLyzv0xmHZsdALpjYVq94Yd1TMs+lP4JJOXIvSkqc=;
 b=ryFWpjTD8aZlBmab4ZqDFXb4f2QdDlL2UEGTAlQ2rg+NeQoGPNQDV9smMhe12Zw5cc
 19apuMwROSh8k77EDoYtIwixp3EhU3T7jVo8wtptTBLfNmAbn4DPITwWrAJWjfU/avPv
 G0ECJ8lY+lf3WCJwwEWHQB6Vdc0OwDLYckeACljb7kAEhl9LsHjvov9FQFOTRzJyoAj8
 LC52H5mmpugAEMXUPynmAvTNlWQnvQepdnDgrFyaCK6kPmSdx2hYWby9eM+tmnU8LjqY
 TVI4NlWq2C5DO3W/O3uJ9s+SiLST9CuAwTtdo+UNWdUK/enht6O74qi5k1hRwsuJj0yh
 QJSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwY+svKDsX96H6BaeM5hkV3MpsSNwmGjfDuDuHmrhYj3R58ud6fROiKcW4ilbn4h+Uu+mFlKuN9mx8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLf4jOpDhibZ+ekwaO5PFdWSUz4pKbkETFb0sDMHC2yKmBnx/3i
 BJvIM2tdIsilktwIH3aQR820JOJhW0EF9jsUjJ38+u+wOg4QOKqIz5S4tS3rfLodKf3Tr8ytQ3d
 DV3SyqrKHijUgEwst1uw9i0k/4Qz2/IwStp9YZLPBlZeFRGj98Okn0SYX1c9D+R0rzi+sFFY=
X-Gm-Gg: AYBFou2gv+MerYbjBOxvhExz67iqQs/4QdYcpEwjAEZQvrIjFDTd6oni4aG3j2pSEyZ
 z1sEmTySbgVvmLnfd9fXuRPED7ck8K7a5MVkhp88w5hkv6oSbRyLjeeck7L9mb1+Ay6otUFPeMu
 RT1+5Iq+fOYsNswN6I3HwaX7gh7XWLVr9JwcT2hJOddQVdO7U4fitaqEvzMROz6x/Q3JsNrMLkd
 3q2mVaHVEk4J63xN2KWNlAYUPgxixLonBLopt8OIhQdB9cuCJCzQjzt9w70gHxD5sA9qvcwebeE
 Mvt+lTvAanbfY+ONqWC4ZdU40SX1+6q4m8wgc8VrJxrlUbjBiTtWFtZedvtVeBFiM6+TYQVi4E/
 QG+y3FmYCOR0QpVSTl9Yt5XURUzthlZ6KkfR6KKiS9KbA7bmyf4JRgw2tmTBHhKI=
X-Received: by 2002:a05:6214:8514:20b0:914:3cd3:a1a9 with SMTP id
 6a1803df08f44-9143cd3a5f1mr157385476d6.12.1790655989404; 
 Mon, 28 Sep 2026 21:26:29 -0700 (PDT)
X-Received: by 2002:a05:6214:8514:20b0:914:3cd3:a1a9 with SMTP id
 6a1803df08f44-9143cd3a5f1mr157385246d6.12.1790655988742; 
 Mon, 28 Sep 2026 21:26:28 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:26:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Date: Tue, 29 Sep 2026 12:25:24 +0800
Message-Id: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALQ9u2oC/3XP32rDIBQG8FcJXs+iJloNZew9xi4057gKyz9NZ
 aPk3WfSi1LWXah8gj+/cyUJY8BE2upKIuaQwjiUcHypSHe2wyfSACUTwYRiDWe0Tz2FqRwLrSW
 vmVOonW5IeTBF9OF7x94/bjnifCnmcrskziak3dj3YWmr2otGSC+ddM4BGMM7azrwICUTqDRob
 aQxeqN7TMnuZdrqtHcxgtHzBDTEmWLGYUk0S8qo9xyQMcO6o3gbUzrMF/u1fXko2yvZep1DWsb
 4s8+cm73Ys/FyUzgnmOQa0Jb1h9u1LO+CEuZB2ArxMocAw7jwzT+Cugu65g+CKkJnONQSlHfmW
 Yd1XX8B4JPcmccBAAA=
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=12889;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=vlTZYMGAgG0PTSkUDGVH4HY0qj0R/SvRdNLKjpyWg90=;
 b=1NrR8Dav7t9VusjdFL9tIUTaYZVoF0O2qqkaoV+X9kSZkg7nynQ4Qyfy+9jOqsHe3NQYlBJfF
 67LMaPQLnEyDtQ7Q4eFlBjuykMqIOL309HLjK5v0quMMUoXbIFpDorg
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/lniQyMaB3qq
 Y0PkzoyEUmxlWrZoprvAZOhjV58U3rw7Um106f/WZCD5MeKvoiQNoheiR8crJr+v75vKVh+m6Y0
 //EVNO0KphKQbnp+g6aI5MwZIH0yXqI=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb3df6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=skkmIMIXlZK7-dkZt6MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX5n/ybWdSO3la
 THJ7NN7NG3XBe89jn03t8nTtzjqC9k5fBqHzIJyNtXYflT8RlD45dY1M/PIl9ywIVFyTOqr/tVJ
 CXTfK9aEgJcFUf7wwxoedP+za0dAPJvQI0l1jUINr3pyT30ioXLkCY1yZz4lGgGgX3yXGlMyHD4
 6s9of69bPLb4EIQUmrGydLo1xDP3hiy9dmmVnUu9Fjt3Eh1t5h2WpQQJIg937AvdAr/XVaJqNVq
 7UHxIilQHF4QqA8xxI6KWWiC/BF8yHUMeJ+MC8wr0AyvHjIRdO5gKFjadvyiXBXa7Tb1MaWiMx7
 MMUq8L45vHeuc6gSUze9uRMhv6UdCqlZi2CJICoFTjBfDO7sHecDrhmu0+vxV0pcKX2IHI/21AP
 r+iU2m0fIe4QUh9SKYWcylmWswxdOX8H2ad/eh1E39zVSb9Tph6KpxCwTltqPsO29qjArY8+jI4
 11arRTjFMMJC+v3KA/g==
X-Proofpoint-GUID: Yjuosrd5t_Ut0CiLjChYxHljAFZFItS0
X-Proofpoint-ORIG-GUID: Yjuosrd5t_Ut0CiLjChYxHljAFZFItS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

This series depends on Dmitry's "drm: handle IRQ_HPD events correctly"
series [1], which adds the IRQ_HPD propagation infrastructure required
for Type-C MST support.

Overall, the patch series has been organized in the following way:

1) First set are preparatory refactors to decouple link-level and
stream-level operations for MST readiness.
2) Prepare the DP driver to get ready to handle multiple streams. This
is the bulk of the work as current DP driver design had to be adjusted
to make this happen.
3) New files to handle MST related operations, DPU encoder integration,
and SST/MST connector state management.
4) Type-C MST support: patches 33-35 handle IRQ_HPD events from Type-C
controllers and fix known issues in the HPD handling path.

Note:
Validation for this series has been done on the latest linux-next on
LeMans (sa8775p) and Glymur, covering both FB console and Weston.
Type-C MST has been validated on Glymur with MST dongles.

[1] https://lore.kernel.org/all/20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com

---
Changes in v7:
- Rebased onto linux-next-20260918.
- Incorporate Type-C IRQ_HPD support: new patches 33-35 handle IRQ_HPD
  events from Type-C controllers.
- Patch 02: Rewrite commit message.
- Patch 05: Handle optional pixel resources without spurious errors and
  track each register block's size separately.
- Patch 07: Use optional-resource mapping for MST2/MST3 registers.
- Patch 12: Handle stream 2/3 VCPF completion through STATUS7 and reuse
  the existing idle helper for SST.
- Patch 15: Preserve the disable guard and adapt it to active_stream_cnt.
- Patch 18: Add explicit MST manager cleanup during KMS teardown.
- Patch 23 (new): Move link capabilities from msm_dp_panel to msm_dp_link.
- Patch 24: Propagate enable errors, update remaining payload slots on
  removal, skip disable hardware operations after disconnect, and use
  shared link capabilities.
- Patch 25 (new): drm/bridge_connector: suppress hotplug for IRQ_HPD
  without status changes.
- Patch 26 (new): drm/bridge_connector: avoid detect-based HPD
  notifications for DisplayPort.
- Patch 27: Route IRQ_HPD through bridge events, drain pending ESI
  events, and synchronize the IRQ before manager destruction.
- Patch 30: Use shared link capabilities and explicitly check for MST.
- Patch 31: Preserve SST operation for SST-sideband-only sinks.
- Patch 33 (new): Fix threaded HPD handler not woken on controller IRQ;
  Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling"); Cc: stable.
- Patch 34 (new): Order IRQ HPD handling: process plug before IRQ_HPD;
  discard IRQ_HPD on unplug.
- Patch 35 (new): soc: qcom: pmic-glink-altmode: skip retimer reset on
  DP IRQ when state is unchanged.
- Link to v6: https://lore.kernel.org/r/20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com

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

Yongxing Mou (19):
      drm/msm/dp: Pass panel to msm_dp_ctrl_config_msa()
      drm/msm/dp: drop redundant config_ctrl_link() from msm_dp_ctrl_on_stream()
      drm/msm/dp: add MST stream register definitions
      drm/msm/dp: add stream-aware link register accessors
      drm/msm/dp: add link_ready to manage link-level operations
      drm/msm/dp: introduce dp_mst_drm module
      drm/msm/dp: add MST connector creation and topology callbacks
      drm/msm/dpu: pass msm_display_info to dpu_encoder_get_intf()
      drm/msm/dpu: use stream_id to select MST interfaces
      drm/msm/dpu: add per-stream MST encoders
      drm/msm/dp: move link capabilities to dp_link
      drm/msm/dp: add atomic stream handling for MST
      drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes
      drm/bridge_connector: avoid detect-based HPD notifications for DisplayPort
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: mark the SST connector disconnected when MST is enabled
      drm/msm/dp: wake threaded handler for HPD IRQs
      drm/msm/dp: order IRQ HPD handling with plug state changes
      soc: qcom: pmic-glink-altmode: skip retimer reset on DP IRQ

 drivers/gpu/drm/display/drm_bridge_connector.c |  28 +-
 drivers/gpu/drm/msm/Makefile                   |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  53 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  34 +-
 drivers/gpu/drm/msm/dp/dp_audio.c              |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c               | 517 +++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h               |  19 +-
 drivers/gpu/drm/msm/dp/dp_debug.c              |   6 +-
 drivers/gpu/drm/msm/dp/dp_display.c            | 459 ++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h            |  26 +-
 drivers/gpu/drm/msm/dp/dp_link.h               |   2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c            | 586 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h            |  18 +
 drivers/gpu/drm/msm/dp/dp_panel.c              | 227 +++++++---
 drivers/gpu/drm/msm/dp/dp_panel.h              |  21 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                |  73 +++
 drivers/gpu/drm/msm/msm_atomic.c               |  14 +-
 drivers/gpu/drm/msm/msm_drv.h                  |  49 +++
 drivers/gpu/drm/msm/msm_kms.c                  |   1 +
 drivers/soc/qcom/pmic_glink_altmode.c          |  38 +-
 21 files changed, 1946 insertions(+), 232 deletions(-)
---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
prerequisite-patch-id: a602ad57feffe40432ce60fc454060f83a81ca55
prerequisite-patch-id: 2e514cf7af2b7537be5c7150f24f084c5460f34e
prerequisite-patch-id: 671b5006ca89747e724706e333578c526b805d2e
prerequisite-patch-id: 1d3431fb1572792afe4b94c798946975f1e73478
prerequisite-patch-id: 65cf0ec52bdeed72174bf06546474c7ce0dce919
prerequisite-patch-id: 687194d87038a56f6462f9a278f38f45ac03b41d
prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
prerequisite-patch-id: 76ea1ecf4e1d83ce2e5730aa36ed1a4524f15e56

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

