Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702B606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PT4G2fAc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NaedW7Ca
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E2010EDA8;
	Tue, 10 Nov 2026 04:55:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62CE10E136
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4AJ7s1957886
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/uQ+PciZKgM4MpOioR71b1
 I3F2UT2QOM8zaZyK6f/dc=; b=PT4G2fAc0zrttoF9IexP3b6NnN8+XPnIiW2kBk
 JcQqdpw/TUVNiS4cdjdhxqzYn8AWjUsftrMIuOn7744dSyS8DJxC9J7SCkqDS46f
 J3VXINrv3jQXyCA7eU0kKwm99ajb7JBi/dQXcmhvBEH6Yfoz1p7n3Ds/ncYEvtwj
 kVBiJkN5rUiwiUC75MV0Njhg+qcB4uJADq99XfJW4OVNRr9lxheb268JEr5SQLj9
 OVeNJdak5/Pu8tMAPRNFS1Wh5Bwcbiy2l9Fw0Zo5P/5pYMa9542t6JH2crC3l+ka
 rtGmeOKEnoM/NtQFOBi+hdRL01TQMPs9hevqgTsoJp6W+6Sg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydkneg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944101e6367so313364085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286477; x=1794891277;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/uQ+PciZKgM4MpOioR71b1I3F2UT2QOM8zaZyK6f/dc=;
 b=NaedW7Ca2mzlWxAZhgD4Ll5FP8J02NASW93dAAMG215qEh2tjKuuA56J+T0s1gw67f
 mSIRkB9+bqblHXyKHLGcYGJQ3hxuQHnKyCR0MlsNA3qF+sy4p1FePhyx288EcoY2HzS/
 6NiFGhFbnytUTi2ErUmpWOmJG2bMY3Qp0CfktGvWruJ5Pqv/EXSUWqPLPZDxR1APy9c9
 fsqM0aqbMcBt/B2p0vl8sHLysXeRmxwkesgHhlr0i9vkFc+aHRydZfohqSgm8MNNPPQe
 VKF7P9/pCd98cX0FbkUL4e5+mRmzdhHQO3dnlrU3+9pGPt8zr42w2WM1Jz60vMjmQr7I
 EOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286477; x=1794891277;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/uQ+PciZKgM4MpOioR71b1I3F2UT2QOM8zaZyK6f/dc=;
 b=jLNenHHfb9FLBxx6jEj3Sknu3VgD2iolj5n1TGwS88u/CIRvOFP+EXDtZvVZA3H7Iw
 rLSNdctZAQa577aLffFupadHn0/CVyUZwqHAImNrMLaq1Kop0CeAOIZ65xBlZpLMvfMC
 0A9ciT+0O0r6T23AcI2rqnwApcGZHekjCVDsK+i/B5WmK1Fag1K8OaBXS7+nbZcva3os
 /jHuiAbh2NcIb0dw3Y3CftP6xS7WAp/W58UYjtKeZYBOBh43iqFk870e45FBdah8UAlj
 ggS2TnjnQNtmBOcyMVJOqy7N24aDmIKvzLCOPQc8/Q1T0/w5Bah0ZIDysdq0z51e8Ko2
 jOww==
X-Forwarded-Encrypted: i=1;
 AL+hErEuOi4ASS3jb+tJnSgZgeuMIRW6OnCSE6sQl91FL0JTWaC2mZzXj3IwhnWemIHG7c63EZqNzlMw4bc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8bn2OC6GQi4XX0F/P4j0Lxapwxu+iMgjpMMomRZpy/5Bxkousg
 Pi8xtFdzv2xoLpP74pTasgjSVjhBI0QuemutgKE97phkdTP05g4bJxAxuG4QO/QSCA5bf+HJi5b
 ik9v+SoSzggVxrFtaHDkeNNJmQQv910S0k8U8Jznzm+pvRYR/oSIUQE+w1MqKmgTp+A0vEFw=
X-Gm-Gg: AYBFou0QAFR5GmII3ERHgMPaei7xqXFi6EWdS16s+Vf3PzbFfLT2MBMlevr3Yp7Ydja
 EXDlISUBVghbqvF/qrhOkRqnHWzZXRzmK1HvVMyeP1qv+JkVoXTmJzblKnelHMnPE8wxgS4AgqL
 U3yGBI/LcyNYyS5z8Xu5ZBXFEQtZlHsjIe/VTQ9f7yURTP8SRfzDIkdoV/oXyCIbE+jvMq87JBt
 slMmR4qpo66KnbSwEMY4Oo/3PksKjC1pq0rnCTYo0ZU9WKnZ3T53RWWoSRB06aKEEJ4n4lFmvni
 +xYs0KdD4ZnRMCsVCs/ehmR7Q2lxRxg80SQDKYmqPUI0I0P1UGnR2i50JTusFIO/+jqbUV2y0FU
 CgWlNold9+st2j+JFZgoc+btILpgC/GgsVZrJK3L6y+rnSylziiUeUuVtMc6LhgJ0UpChsO6K5/
 btvgUwcFfV6SSSL0KPlN7+quxD/RUCd/veqLwp
X-Received: by 2002:a05:620a:1a0f:b0:944:2057:a091 with SMTP id
 af79cd13be357-9479f26fbfbmr245662285a.40.1794286476645; 
 Mon, 09 Nov 2026 20:54:36 -0800 (PST)
X-Received: by 2002:a05:620a:1a0f:b0:944:2057:a091 with SMTP id
 af79cd13be357-9479f26fbfbmr245658685a.40.1794286476047; 
 Mon, 09 Nov 2026 20:54:36 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:54:35 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v8 00/29] drm/msm/dp: Add MST support for MSM chipsets
Date: Tue, 10 Nov 2026 12:54:21 +0800
Message-Id: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH6j8moC/3XPy27DIBAF0F+xWJeIx/Cyoqr/UXUBZlIj1XZiH
 KtVlH8vdhZW2mQB6CJxuHMhGceEmdTVhYw4p5yGvgT7UpGm9f0n0hRLJoIJzYAz2uWOxmM5Jio
 VlyxotMECKQ+OIx7S94q9f9zyiKdzMafbJQk+I22GrktTXQktTYjYMCWVFwygiVYyDN5546SWW
 vHoGMiF7jBnv5apq/3ShTMBtD1GmsYTxRn7KdPZUkY1ogOHxksLb0POu9PZfy1f7sr2SpZebcr
 TMP6sM8+wFns03gyFC4IpbiP6sv5xqzarTdDC3QmqCDxaK8ogXBzgiaA3wUp+J+giNI5HqaI+B
 Pesg9kE96eDKQIEy8FIbhWaB8L1ev0FkweTEAkCAAA=
X-Change-ID: 20260410-msm-dp-mst-35130b6e8b84
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>, stable@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=14739;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wlsw3C6bw99wEI5/qlccjxrx08IsEjqDkJyp/tct/fY=;
 b=fTQnK5jiOhrsUinDlrdfM8nqrVr4YqY+fdNyOqY+iRRNz3PYOlyO0MsxEtPh45YjnC250SEli
 p3jAuR3FJYBAP1lje3YEmg3dwwMMQkjIXBPaYCR8Z9z1AGEJfkYorI9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4YGm7I2RUH9G
 8HSqryts+W6gKT9Js6etXLjAbhg/EUvww5lilvqtCi5au5RKjMdsIG6wvi+LROVcjFHLxv1ojvK
 CCrfchrTk3rPYEO31HyBOGriG5ggdis=
X-Proofpoint-GUID: TSByMCxeMGIe2XQVtvskbu9T3pWE_jml
X-Proofpoint-ORIG-GUID: TSByMCxeMGIe2XQVtvskbu9T3pWE_jml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXzoYQWUNq00Uc
 f7K89dgoEMWRRsnRIvQ4vlAwfB2mh333D5SCYjdjP5HPAzOk9+CXPLvmEWUoUBCvmamszOVNIus
 mt4yG0HK2r4k52JF2NYnEB8/r/1Mj/QUA21iMvGEqTbmO2PqnrAZ9Zd0lP+d22mvc7l/8/8PuKq
 glxBre6CFnVP0wF4xDQhySjg87F5qHqcg7wo+KhrUad8TllJJjacLLyGM8ksQHkoMivlWOiIdyw
 kracE0pEi8hAqmpP48PsO3LkZDkKY1OWsX7yimkzPKxa7yJjCh/TzAoxkr4IPBm52R+7aOVhNAv
 7hFTKJ0D7pU5EB/0zhHcZRut45EB/miYPVPImldMi3DHNjhcKqdvBNvfqvVuy2IoFgWHrqR39zi
 Lb2Clm4H2kVwX/jMqTpkKDCTjzFpopYV/lw9vYkVu0lRXJvEbafihfoiJfLl/pGqAgqS4lBioYq
 IbFV060oM+mz43vkqtQ==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a38d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=z_i5WFFK-8ga3zmfCq4A:9
 a=Glr7RG19KHHE_zVI:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

1) MST controller support (patches 01-07): low-level additions for
multi-stream operation — ACT/VCPF packet transmission, payload slot
allocation, and mainlink MST mode.
2) Driver refactors (patches 08-11): replace the power_on flag with a
per-stream bitmask, factor out panel-accepting bridge helpers, and
introduce link_ready for explicit link-level state tracking.
3) MST DRM infrastructure (patches 12-18): new dp_mst_drm module for
topology management, DPU per-stream encoder support, and atomic
stream enable/disable handling.
4) SST/MST connector state and HPD fixes (patches 19-29): SST/MST
connector state management, HPD event routing through the MST
manager, per-stream bpp selection, and Type-C retimer guard.

Note:
Validation for this series has been done on the latest linux-next on
LeMans (sa8775p) and Glymur, covering both FB console and Weston.
Type-C MST has been validated on Glymur with MST dongles.

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

---
Changes in v8:
- Rebased onto linux-next-20261102; dropped patches 01-07 of v7.
- Dropped patch 32/35 of v7 since it not needed.
- Renamed the controller's mst_active to mst_mode so that it no longer
  shadows struct msm_dp::mst_active).
- Dropped the driver-side slot bookkeeping; the MST helpers now pass a
  msm_dp_mst_slot_info table built from the topology state (patches 07,
  09, 18).
- Patch 01 (new): Skip sink requests while the mainlink clocks are off.
- Patch 02: Use DIV_ROUND_UP_ULL() for the 64-bit division in the ACT
  wait time.
- Patch 06: Mask the STATUS5/STATUS7 reads down to their own interrupt
  bits.
- Patch 07: Take the slot table from the caller; simplify the rate
  governor's fixed-point rounding. Rewrite commit message.
- Patch 08: Replace active_stream_cnt with active_stream_mask so that a
  single stream can be queried.
- Patch 09: Thread the slot table through the helpers; key the disable
  guard on the stream's own bit.
- Patch 10: Release the runtime PM reference on every prepare_link()
  failure path, and check sink_count before taking it.
- Patch 12: Skip the MST manager cleanup when dpu_kms->dev is NULL after
  an early probe failure.
- Patch 13: Use the DP controller's own device for runtime PM; return
  early when MST is not active.
- Patch 18: Report enable failures and stop the stream enable sequence;
  collect the payload slots of all streams.
- Patch 19: Read the old connector status in the same critical section
  as detect().
- Patch 20: Drop the explanatory comment.
- Patch 21: Drop the plug guard in msm_dp_hpd_plug_handle(); hpd v8 has
  a stronger one.
- Patch 23: Check for MST before taking plugged_lock.
- Patch 27: Drop the hunk that handled plug before IRQ_HPD, now done by
  hpd v8; retitle accordingly.
- Patch 28 (new): Select the MST stream bpp during the atomic check
  instead of failing the modeset.
- Link to v7: https://lore.kernel.org/r/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com

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
- Fixed casing/formatting issues, for example: "mst".
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
Abhinav Kumar (13):
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: add support for sending VCPF packets in DP controller
      drm/msm/dp: add support for MST channel slot allocation
      drm/msm/dp: replace power_on with active_stream_mask
      drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
      drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
      drm/msm/dp: add HPD callback for dp MST
      drm/msm/dp: mark the SST bridge disconnected when mst is active
      drm/msm/dp: enable MST on capable sinks
      drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is present

Yongxing Mou (16):
      drm/msm/dp: skip sink requests while the mainlink clocks are off
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
      drm/msm/dp: wake threaded handler for HPD IRQs
      drm/msm/dp: ignore IRQ HPD latched together with an unplug
      drm/msm/dp: select MST stream bpp during atomic check
      soc: qcom: pmic-glink-altmode: skip retimer reset on DP IRQ

 drivers/gpu/drm/display/drm_bridge_connector.c |  23 +-
 drivers/gpu/drm/msm/Makefile                   |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  51 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  37 +-
 drivers/gpu/drm/msm/dp/dp_audio.c              |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c               | 320 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h               |   9 +-
 drivers/gpu/drm/msm/dp/dp_debug.c              |   6 +-
 drivers/gpu/drm/msm/dp/dp_display.c            | 388 ++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h            |  27 +-
 drivers/gpu/drm/msm/dp/dp_link.h               |   2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c            | 679 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h            |  18 +
 drivers/gpu/drm/msm/dp/dp_panel.c              |  34 +-
 drivers/gpu/drm/msm/dp/dp_panel.h              |  10 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                |  17 +
 drivers/gpu/drm/msm/msm_atomic.c               |  14 +-
 drivers/gpu/drm/msm/msm_drv.h                  |  47 ++
 drivers/gpu/drm/msm/msm_kms.c                  |   1 +
 drivers/soc/qcom/pmic_glink_altmode.c          |  38 +-
 21 files changed, 1599 insertions(+), 129 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
prerequisite-patch-id: 38205d2013335920df343c240fa0afc17b987763
prerequisite-patch-id: 358e5f35d442041b88e52d8e39a564a053a0f990
prerequisite-patch-id: 9860b9acb12b1c2652e4e9f4860968a2ca3361f0
prerequisite-patch-id: 53486e695198f785401740f7f4372bdf335fb620
prerequisite-patch-id: c8e551a07553f7dc107063a1dbec1d415184f97b
prerequisite-patch-id: 1a6251919897ca5e8b12a63774a833fd8460c67a
prerequisite-patch-id: 846ab694795c6bec123d1dc46d7a53097bf594bf
prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
prerequisite-patch-id: 76ea1ecf4e1d83ce2e5730aa36ed1a4524f15e56

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

