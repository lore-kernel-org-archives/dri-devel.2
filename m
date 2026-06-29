Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E516BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BCC10E8A2;
	Mon, 29 Jun 2026 13:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSoNKlTL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxAZeZZM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F036B10E759
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATBFh2647661
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EzUX6DCnLm9c9ZCkeVOBQO
 S1YlMMAo176Qhn/POAkko=; b=oSoNKlTLDQtCj8SdyDUvs8df4teO7QJA9j7sr2
 0IwyutggBaDLSihMzkBugevmwkSnHM1BFmJYQlYgiPmTH/TKbYYgL+xnNoi3EBRD
 rIetCQDJ/0hK3pIqdFMagFKZqD4/PuJ5yZ2H7I/fACt0JNDeWVvtzOdcE2elpSAF
 cNbDElsXUY6bQh5TzXvE+xIAgcAUY06cDHDs5C5GdSnBPiqIHWZ85+CLgueoGCwc
 +Lnr7ohSJF3NiCw0Zvv6N9luZhtzFjdjr00gJd14mZ4RgOgPB7anaubEsIfz6P9m
 P34atT4m01FTHBCNUPy1F61QWNvUuK9INDmT+JTwsiglY2Kg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhek4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:31 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bbd3241499so2915944e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738991; x=1783343791;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzUX6DCnLm9c9ZCkeVOBQOS1YlMMAo176Qhn/POAkko=;
 b=WxAZeZZMiOW1AFXmrmudmqSZBwPbKKO6Ihpcun/7y6vvj+9QV7pABc4HjWmJqE2cEF
 0vNnINRqUQY3vRN2+Zg+wZo4HYbRx2ByQkiWRA2WNXIrv0rFjs16/UuEzk85f9r3LylU
 UkmeWY8u/XWqUeld7bqCRmZE7xDhdnBUppdDAkk3TRHJN6ONTxEl5I397MNGgwMWEJ4K
 +cSvq9JNBDsGa5sTMeTYEiDxfBdLpLwUxz7OYbRZYaXsVp/2wHOi7MobiGBPHlQm5Y1M
 f2rN2ErZj+WJwNkPjH1rRRAAUu6aQ0bzYLuLLnWvk1LPt5H4bhuiS3XbsewpopCs3tFZ
 wnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738991; x=1783343791;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzUX6DCnLm9c9ZCkeVOBQOS1YlMMAo176Qhn/POAkko=;
 b=gJwR2GR1/XmWDK/dZootEkhGqz6hkktexDfyVQ2wGYnOcDrw0ojc0kHEhiq+5M/L8E
 PL27ztGI00bcQxa3oyqa+6rBN3QmWh8hcaMVTgfEorSTCsO+VJ6PRb48Zlv+5F7wO0JX
 ASaoHF/y0begyzPoe1UcLInQU3/l8RKWm0eCLBMfjIJDnm2oO3NZs9TVAC8KUyFPwSXH
 jNfIMM/YMxShVxaXSm3Z9N/A7LoacVgWt1BNLxXN05Bn/Dm4zB0ADhjvJTwqAowDg+lr
 C+u1eubNRxTLLYY6dpXy1+0K1/Rm19+xEgUA5S8EiluWB7qd5H/zUzNBAA/tnlWrZdTw
 hrrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpnj8EnKg2cB/vIdJLoxoGf35nIvycYAirv0uI87Zc1QfFm2oT4l7GECUIe1JPUm9XW+XxXyoEbl1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpN5I6kzA9eOAf4sNRdv4mioQXgUqvsS5qFoU8lsx7mpvsRrSj
 nC8CpndkV2whzgV9Pyza7RxGLVJbG1DxUPznrcdJPSC/rGEoJtHJKqT5LkyVYbINjCSAB+tlGik
 rMLCE+rStmiKsCzDK/wSEYBGh6puqIQNiRObL3Is/P+yWsti+KcpzXBREpUztC/brzLo5XTw=
X-Gm-Gg: AfdE7ckoO5Eif/moyN1ldJiPdnFOvh7DJ36W/MM4UDAL3MYp0+IZwCSueFpJA4YctvS
 FGiwJk9erkWNDACR86//uhk5MC5lxWbX9aubXD1Bx3m8HtVJNlA3q77l8yCaEZ1FUvzk7Olv5UG
 hEIIsZi0dGXUh4oLCXOrtdgbxW98tyVsKt+96YA93ETEavKNLDlO00eCK1veGKkj1W7obo19ImT
 ipM7Cy6nr1Jn3CGkd6lQIgN+8ffvyEncYQhpf4grlWbmWpeDEdfYdNeRHghe7V/u8ZUoLZaar8W
 Pjibh0bh7DJgdOkQ1/gXnFswgw5p+VRIrTwpuQkyjiaIvao4xWTkcYNDvIPxUo6kLKcn4DkdcNA
 mzRSv1UqfwyY37+b3LfDguVqSK2/hdl4PW3is2JGoTr3lBcsxWJSH8FwG5kSRTNJ/BCe2PlXxog
 ==
X-Received: by 2002:a05:6122:d1e:b0:5bd:89bd:354c with SMTP id
 71dfb90a1353d-5bdba9a976emr381274e0c.11.1782738990815; 
 Mon, 29 Jun 2026 06:16:30 -0700 (PDT)
X-Received: by 2002:a05:6122:d1e:b0:5bd:89bd:354c with SMTP id
 71dfb90a1353d-5bdba9a976emr381211e0c.11.1782738990253; 
 Mon, 29 Jun 2026 06:16:30 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:16:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v5 00/25] drm/msm/dp: Add MST support for MSM chipsets
Date: Mon, 29 Jun 2026 21:16:18 +0800
Message-Id: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJwQmoC/22P3WrDMAyFXyX4ei7+i+2EMfYeowzbUVZDnbR2G
 lpK3n2Ke7ldSOII9J2jJymQIxTSN0+SYY0lzhOK9q0h4eSmH6BxQE0EE5opzmgqiQ4XHAuVLZf
 Ma7DeKoIHlwxjvFfY1/GlM1xvyFxeS5KgFFeZffNekZp1iPtGXDiDm+hqKKPg0IpLsELKz7mUw
 /XmzmFO6YDtY7fyrgDdN3HpGzCDYQy46qQCbUerpbSh1ZyFUTgw2nTWay3JHuoUyzLnR314VTX
 Vf7+tCnN4wVpuB3BYf3KQ47Ztv2uNRmFAAQAA
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=8332;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5et0EHDEiQXAKizjYlZTNasB+K7WuFtQKxbEXsrIp2k=;
 b=vSEOkG9G9emv4BP1xpeK4IKC9tFKiK0quEeejWXtHjfL6QkRICMu+RDGKD++/gF7apJle0FNJ
 4evCJVTrf9/CGzU7/tt8DN1Acmp3Smf4sas+CgfkIgNdp4vtlTDr83D
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 6Qre4LKuGSyAWeuAksSzFr5yF0-V3vzF
X-Proofpoint-ORIG-GUID: 6Qre4LKuGSyAWeuAksSzFr5yF0-V3vzF
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a42702f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=uKobFkzxL6-HA6XF2LEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX0BXkKGHFzwol
 DSJ9SKJGjAMwfUqZnTikh//H/MpqCMGS0URrdwclK8l1A4RIYEI7fxmLFQj0sxZLPQIsgHkw3w2
 zbqYBBYOwSILzuwrf8ojYV37J4ZC+AA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX7TsSp5SJrsib
 fH+7sLS1+qmGTOuCSDAk8VzrxFMQkaU0bNu4AiBItzcZlqOQfbg3DzYAHUMazwmMF7ZqzwGE+Ky
 WPKL4dnZpZvVecAx2Ie6tRZSMa8REU6soDlne/XTuRnMHGzMNAS9YOMHDl1EUX5pW87xs/J+gGM
 TCEZWie9t0T+DQtKDJxt6mTCXkhSRTiSjbaOFHWoUv2zL5GTW6sn/shNVIw54M8/dvTDBPzhVxH
 hjSZY/dvuEWDlsm+Xz51VFlRwRcLPZp++rL41GS/HRqJ7DOr668J5DTtbotw7r5uJ+Na0fdO49q
 S/6beFgmUu/nXhzsM39TICDc0lNcxfMWdlsQkle8CrJ34Kzgy5TP0RWfuMfDfGag1CQ3Ys5zm9h
 I97qFpCuiA7SVlWBiiCuXcDHbk6h/c84LwmkvWGvYH5S0PbH2egyjAxl3G2dmElbp2wDXEweHg2
 a6nsVXI45lnmBhp3xHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

This patch series was made on top of:

[1] : https://patchwork.freedesktop.org/series/167458/ (preclear up)

Overall, the patch series has been organized in the following way:

1) First set are a couple of fixes made while debugging MST but applicable
to SST as well so go ahead of everything else
2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
of the work as current DP driver design had to be adjusted to make this happen.
3) Finally, new files to handle MST related operations

Note:
Validation for this series has so far been done on the latest linux-next
on LeMans, covering both FB console and Weston.

Type-C MST support will be submitted shortly after this series.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
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
Abhinav Kumar (19):
      drm/msm/dp: introduce stream_id for each DP panel
      drm/msm/dp: introduce max_streams for DP controller MST support
      drm/msm/dp: Add support for programming p1/p2/p3 register blocks
      drm/msm/dp: use stream_id to change offsets in dp_catalog
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: Add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: Add support for MST channel slot allocation
      drm/msm/dp: Add support for sending VCPF packets in DP controller
      drm/msm/dp: Always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: move link-level teardown from display_disable to display_unprepare
      drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
      drm/msm/dp: replace power_on with active_stream_cnt for dp_display
      drm/msm/dp: Mark the SST bridge disconnected when mst is active
      drm/msm/dp: add an API to initialize MST on sink side
      drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
      drm/msm/dp: initialize dp_mst module for each DP MST controller
      drm/msm/dp: add connector abstraction for DP MST
      drm/msm/dp: add HPD callback for dp MST

Yongxing Mou (6):
      drm/msm/dp: add link_ready to manage link-level operations
      drm/msm/dpu: initialize encoders per stream for DP MST
      drm/msm/dpu: expose dpu_encoder ops for DP MST reuse
      drm/msm/dpu: use msm_dp_get_mst_intf_id() to get the intf id
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: add dp_mst_drm to manage DP MST encoder operations

 drivers/gpu/drm/msm/Makefile                |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  40 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   8 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  30 +-
 drivers/gpu/drm/msm/dp/dp_audio.c           |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c            | 473 ++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |  17 +-
 drivers/gpu/drm/msm/dp/dp_display.c         | 394 +++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h         |  25 +-
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 583 ++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  14 +
 drivers/gpu/drm/msm/dp/dp_panel.c           | 197 ++++++++--
 drivers/gpu/drm/msm/dp/dp_panel.h           |  20 +-
 drivers/gpu/drm/msm/dp/dp_reg.h             |  68 ++++
 drivers/gpu/drm/msm/msm_atomic.c            |  14 +-
 drivers/gpu/drm/msm/msm_drv.h               |  19 +
 drivers/gpu/drm/msm/msm_kms.c               |   1 +
 17 files changed, 1718 insertions(+), 190 deletions(-)
---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
prerequisite-patch-id: 1d440cb9fed2bdd66d8de0e1e20475f0fe166973
prerequisite-patch-id: be0f4b80697df7224c80362b161b8a9f0a542184
prerequisite-patch-id: eefa6e6353df301420feae1da704a9db2c2155f2
prerequisite-patch-id: 9e9095f82dd6c131c9f3c1de4fdb8a62bd65ca24
prerequisite-patch-id: 3e635f008f9b56823101abd9253905f078fcb3b5
prerequisite-patch-id: e39e0dc124ed043c7a419610ebe03ad105da27db
prerequisite-patch-id: 945af39213cd4241e1a5929fada04a9286aeb5db
prerequisite-patch-id: 898ae7e4582a6b31492c223e7dd167fb9ce78096
prerequisite-patch-id: 3887553893357c1ffbda99eb010801bc2166cbad
prerequisite-patch-id: 7ccd961fa3c6f925659dee7d7a5bd167c8e7331b
prerequisite-patch-id: be2bf918e0e87ec2ea999927f36bd172c498748e
prerequisite-patch-id: 6aacdabb2dd0536dc04da04f8419ae39e35f8b19
prerequisite-patch-id: a9f27eff8f643ff445810b17d670891928f5b416
prerequisite-patch-id: efd300a2b52715153b8c1c7407db696eb331594b
prerequisite-patch-id: 950abefc4862050ef606404977fd27c5dd2cbb2b

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

