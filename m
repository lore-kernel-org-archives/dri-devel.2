Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A00E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5AC10E8FE;
	Fri, 10 Apr 2026 09:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BziL3/rq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XvzwUCiM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4783E10E8FE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:33:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8xiFh115439
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1GxlEXlMFGoL3iEpGpKzNu
 8zyIrF4lB+KMnSq+VtabA=; b=BziL3/rqLaFRob+n487fRJi8Bgik6uILHk6REm
 ifqwsrlL7x2wk1Sf6lFeR/ksiVu1XW15/7U3+lXNF2jiv5Gxp511z/sI1xZFAIu+
 c9oGTNuBrfstWVFyyy2bySJk2JJLmlsnZ3cXJLW7iHEY1GR0hQZC5Qh2CvJx26Xx
 x8uXKi9UNRzTNebkiejBGAZb/An27674IgWapXGI3AtlpHjMsq5c75l4X/PlSAbZ
 +qrOp6bIGK2O1vwQnrEqc7+stjDCOn4sMljXinDdjA5WVl49dF8p+lXNaJGR1N56
 m1tzgTseZ1KpK1RC1c67nvYglhK2rDg8RPN31vOCK0yiFCMg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb8rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:33:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ac7ff4a18aso28389286d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813634; x=1776418434;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1GxlEXlMFGoL3iEpGpKzNu8zyIrF4lB+KMnSq+VtabA=;
 b=XvzwUCiMyvYGA1Di0kEYZ+bUhPhv7ybAVDl28KZ9cWsBLF3k+LclpV3QNbox2HH0bJ
 0YHeU47vH1FXNTlxQjdgZpsYn2JGYc6aYQZzq5gO2gD2RO9fxCeGldFycDHAKI8o2e1U
 KSe2QolaAZGgSWP+/XkK2pb6k+IJekuQxwBEdWiwUPmuGI+DZthpeu2bBltYekWiJ0iX
 aJrVrDzqF4g3cJuRN5oVXuSxxOtr+m96rhumnXvLeh+ztISK8mXh5CsOw3NwAas1Av8d
 7pIyolKnL5bFIwhoccpxFbBKg6coQXFeG5paGJx06RcdBIbnXbMLZtrn4i6+OBzqybL5
 Wlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813634; x=1776418434;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GxlEXlMFGoL3iEpGpKzNu8zyIrF4lB+KMnSq+VtabA=;
 b=fCFuamnz4R/hYetfRTcAA3SXu1kzcJZwjYysj2lM0SYS+gSDcB2bvBG3ybo5wBKIUU
 9Gudt9xdXYnJ+VqQLro3mM8e4iUgh+OAK9MwGR0Z5ACCx+G42bUWwpLdyXNEbf+BnnTZ
 yXmM5cT+WB+JwxV8G6VAcJWBK61pniE6+FdMEFcuD8V4z/IyUKlF4LzW0F+T2tpCTKQX
 TRW2leJde9IxLZeW1EGQjxnHbXQkEhgX5jPf0YbkK48agzT8I4SXjmrKAUdHBZzo5G9j
 +g/RDFO0ZON2B6it3pEBMHc757E5HAYNhwQ5VlCZBvbIXkolxWti3SuXbwLcgutF/m7Z
 axBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMCDPzRvnATdbRZI7UYzpwNnIKyJ2tjHvX30C/psyX37CVSBFa6IUZo82Mqj4kgCc/U/5tY+n0Yi0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyj7NGxVLa3XPwHMai/dQzm10BhcSsqfzm8B64dB+Cb8uiseO9+
 vIutfPAGBiSGP2yh2byQDOs+qCSEIcS7nDWFLgp/tzDBQV801TjJ/ezw8WPu6qbg2L7WeBlC/00
 iI4sLjjNDFGXLpMk+sQrdHviByDAEVzw+JNs9akkCtHyRJFdSKqrNA5MoR+vCLXSOa7QP0J0=
X-Gm-Gg: AeBDieujO6PXFAp+OECyPS42aHuIhAb2t+OyZ1pbTQroS+R5O/hrSjkcHCvVB8Mdolk
 2GsW2MgWVQJrR2o54EG46zNjY7OTZpUpk6cErzqA8UDZ7K8AxOBM+SuNU32HxdaL4+U08lUa75Q
 iMbZr8+o87gGCPC/Q7VOMRWvCHg3x6TjiJDKU54S0mGrNKQq9uRO+57H+VLquDI8IOB+PyQd7T9
 cOYvoJHLA4n/PyYo3L/eRdD4VaCxOKP/1Xn1Cc+EG/iZIOXfBt7OKhyr7sf44j214Vp7M8H9S/J
 bj943CdssM55NGSMfiWtYgh2l9f7eNORrJ1SqZkYiLPo30DAKlXLZUNtphNi+ZmPc4cCNLvwQXQ
 HJxNdJ2rkvnpItOpqFIfRoKmhxtIW+RTXgbSxTFoysRzpJG37rpNpIekkDWcavyrGMeOQBpztC0
 EQnWtwqJk=
X-Received: by 2002:a05:6214:4c92:b0:89c:4ea7:a705 with SMTP id
 6a1803df08f44-8ac860f3ac8mr30307816d6.21.1775813634239; 
 Fri, 10 Apr 2026 02:33:54 -0700 (PDT)
X-Received: by 2002:a05:6214:4c92:b0:89c:4ea7:a705 with SMTP id
 6a1803df08f44-8ac860f3ac8mr30307386d6.21.1775813633735; 
 Fri, 10 Apr 2026 02:33:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:33:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v4 00/39] drm/msm/dp: Add MST support for MSM chipsets
Date: Fri, 10 Apr 2026 17:33:35 +0800
Message-Id: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPTD2GkC/22Q3YrCQAxGX6XM9UbSzu+WZdn3WETSdKoDjq1NF
 UF89x3rXnqTcD7ISchdSZxTFNVWdzXHa5I0ngqYj0rxgU77CKkvrBpsHJoaIUuGfiptAW1rjZ2
 LoQtGlYFpjkO6rbLf7YvneL4U5/IKVY4itDrb6mtVarSQe5Ed00LHcQ9XCwjonA/E+pPY/4wim
 /OFjjzmvCnl+7nrjak2cJh6KEcQL+P8b+JgLHrte2femzqSCM8kLW2l44AhdMjW+4bc4K3TJlp
 DpM1gB0ZquLyB1fbx+ANG/qdzPAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=8264;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VLbxJZyiqPOlcQwp522UmmsB0ILjUkfDxXbP24S7/7I=;
 b=IsVAU+0TOM8w8dM+RqEeAPCIf8Dy1XJK/OdKbgPpL3XT2Toeq6Kls69fYwed+lhRBBY3LQyMw
 8E7nsM2v8qHA/UU7v8M3z4/dALgIHOoDKHL+cQU4nKBo/LFzbv1b99n
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX81jKejp+/CVv
 tSkDw4NCr4LryDWDLXobj0id8e/D7Wlz4H8lMUyNjg8sNduXSG7qR6VK66IFdv1WY266H+2csJp
 1VxyBiziMGa+Z0u/KXW4ybV+9ZEJAEzMW3SIrnAOBonNHMMZj6mvf65+Nqxt3Z250TGe7VONv/+
 OvoptSrHlAbJgZKSAMXuo2fwP3gmgeT3LRJXTzgHi3DFB98OjB5ENP7IY7lEycJPXjmBmopxyjs
 wsPkZJ/8Yi4QbYqh98vBrbDUgG/Ctaz82AHSyiju22k1QXB8OlQr5cjp3wARLpNGPAl51E5pF4M
 dSjypxw8Yz+yFOSpbij5PK84oAw1xclGcJGFIksiyEHtL6fDTD3qIa9bAD3Wrp9f+jZN3HWZJOX
 VFXytgjHDfLzi08p0eeFWUDwPx3wxirX7+HScHx0+h/F1Ya6ixuNAPxA+YQnnTYQAdPFwmqQVzC
 OEJ69V1ttvTaOs3rVJg==
X-Proofpoint-GUID: yFiw1zVuMH_r747ApueVjRtiQccMpoX9
X-Proofpoint-ORIG-GUID: yFiw1zVuMH_r747ApueVjRtiQccMpoX9
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c403 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=dsUC2Tdhv4dzEw9V6FUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

[1] : https://patchwork.freedesktop.org/series/151522/ (v5 to fix up HPD)

Overall, the patch series has been organized in the following way:

1) First set are a couple of fixes made while debugging MST but applicable
to SST as well so go ahead of everything else
2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
of the work as current DP driver design had to be adjusted to make this happen.
3) Finally, new files to handle MST related operations

Note:
Validation for this series has so far been done on the latest linux-next
on LeMans, covering both FB console and Weston.

Broader validation, including additional Type-C DP use cases, is still
in progress and may lead to some follow-up adjustments in the next
revision. I wanted to post the current version first to collect early
feedback on the overall approach.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
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
Abhinav Kumar (26):
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use
      drm/msm/dp: separate dp_display_prepare() into its own API
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
      drm/msm/dp: abstract out the dp_display stream helpers to accept a panel
      drm/msm/dp: replace power_on with active_stream_cnt for dp_display
      drm/msm/dp: Mark the SST bridge disconnected when mst is active
      drm/msm/dp: add an API to initialize MST on sink side
      drm/msm/dp: add dp_display_get_panel() to initialize DP panel
      drm/msm/dp: initialize dp_mst module for each DP MST controller
      drm/msm/dp: add dp_mst_drm to manage DP MST bridge operations
      drm/msm/dp: add connector abstraction for DP MST
      drm/msm/dp: add HPD callback for dp MST
      drm/msm/dpu: use msm_dp_get_mst_intf_id() to get the intf id

Yongxing Mou (13):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
      drm/msm/dp: splite msm_dp_ctrl_config_ctrl() into link parts and stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: split link setup from source params
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: Add catalog support for 3rd/4th stream MST
      drm/msm/dp: simplify link and clock disable sequence
      drm/msm/dp: pass panel to display enable/disable helpers
      drm/msm/dp: add prepared to manage link-level operations
      drm/msm/dpu: initialize encoders per stream for DP MST
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: Add MST stream support for supported DP controllers

 drivers/gpu/drm/msm/Makefile                |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  30 +-
 drivers/gpu/drm/msm/dp/dp_audio.c           |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c            | 822 +++++++++++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |  24 +-
 drivers/gpu/drm/msm/dp/dp_display.c         | 598 ++++++++++++++------
 drivers/gpu/drm/msm/dp/dp_display.h         |  31 +-
 drivers/gpu/drm/msm/dp/dp_drm.c             |  43 +-
 drivers/gpu/drm/msm/dp/dp_drm.h             |  12 -
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 795 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  14 +
 drivers/gpu/drm/msm/dp/dp_panel.c           | 315 +++++++----
 drivers/gpu/drm/msm/dp/dp_panel.h           |  32 +-
 drivers/gpu/drm/msm/dp/dp_reg.h             |  48 +-
 drivers/gpu/drm/msm/msm_atomic.c            |   9 +-
 drivers/gpu/drm/msm/msm_drv.h               |  18 +
 drivers/gpu/drm/msm/msm_kms.c               |   2 +
 19 files changed, 2300 insertions(+), 520 deletions(-)
---
base-commit: 3ef088b0c5772a6f75634e54aa34f5fc0a2c041c
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
prerequisite-patch-id: 8b3f7f40025e7a10c4646435e9cfec4f9e275871
prerequisite-patch-id: 547db98962f20218380e966b976aede824ff8433
prerequisite-message-id: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
prerequisite-patch-id: 1867c344ef6ead1034523ba65d2640f9ad0606cd
prerequisite-patch-id: a58ebaf429385c622869c83e83ce7ffdfe9ea27e
prerequisite-patch-id: d0f570e57559248ba6ca733f96fdb02af29f3055
prerequisite-patch-id: 44d390f5319068ad534c4be698dd8dba99c0bfd1
prerequisite-patch-id: 85438690573583cf62065f43531dbb4e221e9dd0
prerequisite-patch-id: b37db0f0b10f16ed45ab056aa87f2275bb02df94
prerequisite-patch-id: dcccd204ee8a979328719d41334453474bcfdf98
prerequisite-patch-id: db07c3aa80a597c91ae2329bc677bfd72b63716a
prerequisite-patch-id: 9778cc1ab60a0870a74d58ff220bb01011fdf1c0
prerequisite-patch-id: 95692a605647e51bdaf8d5b2e61635a6978121f0

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

