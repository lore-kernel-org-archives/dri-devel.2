Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9BECC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDD810EB82;
	Thu, 15 Oct 2026 07:39:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B78A1120C7
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:38:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F2HDWh840950
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ClwmXz9GEyeVTsDXk0nrep
 zRp6jajvMOiFCFegqIY6c=; b=NUCY/H5QS8KXs3A5yZFTzefsreFexWaCAbhsL4
 0oSoCQrnaB1aE0FfaJ8JJaU4ktBJrmQzhIQQghVqBVlvaEjJLEWupqAkUWdDSdRN
 13jV4j0giZp2yhxZm3Zrj+smxTNMkv6jpof98Fl17xOfpCAEtTbi8eOPjzCPmcgi
 9c4DUCQgjSKub177PAbCv0RIaeLVtym4nNt4ZtsAcD48oulcOUv3O3hWrER/LXdI
 qckzx6huBqd8zVe1dfmI3fO1TnMlBKUzPPCCtWN1eMN00H8jRw3ZNIgAFpMg8P79
 uWubmoKB92DUjGEfJhlVwVh3m6Ok2jAuyfJkJtB3MAEXz4fA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wtsdg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:38:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so6554443a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792049933; x=1792654733;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ClwmXz9GEyeVTsDXk0nrepzRp6jajvMOiFCFegqIY6c=;
 b=DalgHDNiKjZQtRvyAMyHfxGInjugIgTmJ6kt6z3rVDTXU7w/gH9zgXp/DRiEwcEwTF
 x/HFWbPUobg0EsfMtOTTvhCo5cYgxsEAORhy52vg6N+JvJ5JbKsifZcv00kY2yaDqYnX
 i3BOwUpHRB8GLoNIlyZ5MSIqM0ODieZkLcwq+ZHT7uEinw3d4NvVwwoOIvWSeBU7NXx+
 BkjgfZF//nxgUw+2P3fBa/l2dxWFXZYsQIwHjGE2IrnpWv4lUW7DtqQR8Y235bUlLbNZ
 eXZkA9WbUlZgUhMXYhu7po/ysKS5eqWsOi/n6MAr3EnQrysb+jBQpQrHFXCR+mKwJ5/j
 KrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049933; x=1792654733;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ClwmXz9GEyeVTsDXk0nrepzRp6jajvMOiFCFegqIY6c=;
 b=NYWVir4JYoCn5JUmSy/EBv7DCvyTja2M0QUOQaloDhIC8A6Zppm48otA1dHE6JGdHw
 MHuHGBkp9VqVk1EKpTKDqGYZggMamMH/Nit1wW73188QQRuDRRdjubcOEigwTnuoP2XI
 11WzjMQc8hzqITwEmcU9zFdYoSDeiAFaA6yjPQOvy2PTAT6ljdHI1WcD/1pbHlRdabiq
 gSL3ZdfpkkqmssK5MigOUKZTo37A3b1mh2l/aqlb6XxxnZwuhz8gJee8S6Qw3jJ9htKf
 dF3cOKiFwKW3BIoB6eoOwLjWYEERw3JZIeHkjOKt15AGks7DupRngPbvy53oVf7hgK9W
 Zo8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByim3tEt0Win/p8ZhRZ4hJlbI9427ewzB1LDuJdAzlGt/YVJuC02/jJbn8K1wP7zVgdFC+OGPf7l+M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI52SIJ6bUSgp1ghLEtK9pW7yZj+Ory3VEoTMGLvhMh1NB9pvpd
 XK8i30ZDWVdwttzw7iySxrlM7pO2uB3cP1dwF5DV6GIZvKZuYZrgTKE0maqq9XNWjYDvx6r2qPV
 oiiUZdcTUt4M+rkInEp10FcKvxo89oYE1rxIyP3PyzO2+17W97Xp4WBlp0Bufva6nGdpErPU=
X-Gm-Gg: AYBFou29ylVdSHubsJtf2Z3EsK4S4PXIv7Oycj6aCpuvE9JA46ZXfd+BstXKRq914j1
 3zPiammHYzZYOJdelCPEpmbTZLVHmyKKOUda6RCQr3EF44V6RWbbQZCdTYSI+p2K7EiGvL7OAyL
 F9dz7QUz00ZALC1f0HFF2WyYcAgUoLJmlh9XEC5PI/JQk1JJtt/n+MmisAqIlXfgn1YGG/8VF4V
 T3osB84ZRLdxXC/cZpKzWbM5nHA/bSOLRiUVZZ9sAEJLYr3pKTZcAFG+8psJ7DSYNnAwBxhfSDI
 ccPRAgvt/XWNiaQWwp3luk81kP+XO+0eQYmuSxDMmxHU0asoCxVLDzv6oVTPaNYin1R2hb/P/5B
 HUSW36wWWtMMHzoilk0t60rwJdg4KDFToV8A=
X-Received: by 2002:a17:90b:2d86:b0:39e:359f:8539 with SMTP id
 98e67ed59e1d1-3ab3a90b5f4mr13847440a91.15.1792049932619; 
 Thu, 15 Oct 2026 00:38:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2d86:b0:39e:359f:8539 with SMTP id
 98e67ed59e1d1-3ab3a90b5f4mr13847400a91.15.1792049932031; 
 Thu, 15 Oct 2026 00:38:52 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:38:51 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH 00/13] drm/msm/dcp: Add Qualcomm DCP display support
Date: Thu, 15 Oct 2026 13:08:20 +0530
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOyC0GoC/yXMTQ6CQAxA4auQrmnCTMCoVzEs5qc6xQySFokJ4
 e6MsPwW762gJEwK92oFoYWVP2OBqSsIyY0vQo7FYBt7MY1pcdBE7+QEo2TMmjGGCReDwVtvXby
 1185DqSehJ/+O86M/rV8/UJj/O9i2HRfbFzZ7AAAA
X-Change-ID: 20261014-jshekhar-drm-msm-dcp-v1-cb2b2ad9485b
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=9691;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=bMdrm5Z5SHntZQm0fWWpRdfG/PLXGSyBI27ZPdP0lMY=;
 b=Fo2a+znPxC/MpXCw2LQYHgZjEGFjhHXLAwGikfT66Xto1PQfnMBaExY+LD/AGhme0ziQvbzCU
 dkooxT3J7d9BnQgAyDAfiohZH1BM4NnVBG3gE0wu4VLxVsr40z+ce89
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXwK77uRTrNwWK
 /VG+jaepUN2ha8uRyBwwdWXrPOI4UHygMyLJehKL8QsN/QuSu1B+enLGDC9Ns34+eN8XTKtOJRw
 3jyKumTqsA7Z3ZSEqFGDiOXM66lq0Ok=
X-Proofpoint-ORIG-GUID: xid8TE6yWV2TFjjQzyzx3yDo652W_mo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXxT6Ka2yAGchL
 ypQxgnANIdnZx+apy+Rdhergqa8poh15RzRSbJ/XLk4pt7VkCt/3RbCtARkBIargjBYGolNLrUv
 hvYrVJOMpd463zxpOrqctAggDHG9LlJmmfQmhODMawBbZYL6UlYa0bDzXDBtQfOnF85ugOpCLVB
 n/+XOm6DEzCcdALgrovm70LREvhQ0jvuKgV5lA/evOM/HHzBpltrjh8fLagoww9+pe8UZkCCPBf
 /mGuXXrfHUylT2pQugEQeshrp21Sh7VClb9+P37csYs9w2hrFg+aMMVokptm72XS4OjwqUE+JYt
 smPtfzJr1xjkMpaNzALBYeqRm6Pr7N+QV6rl04Z3nPdO8zyv8IkkcLw9iQ04ltSfiyCr0H7kwkN
 AM7nnKIG1ejwEImJWPzi8yav3gNHHC60/BoPUo2YUq9Tl+war1FkUxfYpunkG+Sivo9/VYYoFWh
 eQ/VWo1ck6j+hSidsRg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0830d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9ybXZpbEqOl-BeKKuDUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: xid8TE6yWV2TFjjQzyzx3yDo652W_mo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030
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

On Qualcomm platforms using the Display Co-Processor (DCP), the display
hardware is owned and programmed by firmware. Linux does not access
the display controller, DSI controller, DSI PHY, display clocks, or other
display pipeline registers.

The display pipeline must nevertheless be exposed through the DRM/KMS
interfaces so userspace can perform modesetting, framebuffer updates,
panel control, and page flips.

This series adds a DCP KMS backend to MSM DRM, representing the
firmware-owned pipeline and translating DRM operations into HFI commands.

DCP communicates with Linux over VirtIO and uses the HFI protocol for
command and response handling, capability discovery, and
display events.

This series adds:

- Device-tree bindings for the DCP VirtIO-MMIO function, IOVA
  range, separate transport and framebuffer IOMMU contexts, IPCC power
  notification, interrupts, and the external DSI display graph.

- HFI protocol definitions and packet helpers for capability discovery,
  modesetting, plane and CRTC configuration, DSI, and panel control.

- VirtIO transport with command and response queues. HFI command, response,
  and capability buffers are allocated through the DMA API in the address
  space visible to DCP firmware.

- Synchronous command tracking, asynchronous response dispatch, timeout
  handling, and queue teardown synchronization for safe device removal.

- Capability discovery for displays, CRTCs, mixers, VIG and DMA pipes,
  DSI interfaces, and panel resources.

- DRM planes and CRTCs using the standard atomic-state model. DRM state is
  translated into HFI properties for layer configuration and mixer
  limits, bandwidth and clock properties, frame sequencing, and triggering.

- An MSM KMS backend, DCP encoder, and DSI bridge. The backend reuses
  the existing MSM DRM device, GEM and framebuffer handling, atomic commit
  infrastructure, encoder, bridge, and connector support.

- Asynchronous VSYNC, frame-scan completion, and error events propagated to
  DRM for vblank and page-flip completion.

- IPCC power notifications wake DCP firmware and coordinate HFI queue
  activity across firmware power transitions.

DCP is integrated as an MSM KMS backend rather than a separate DRM device.
This preserves the userspace-visible MSM DRM device and allows Linux
to retain normal DRM/KMS semantics while display hardware remains owned by
firmware.

The initial implementation supports the DSI output described below and uses
resources reported by firmware. Split-pipe, multirect, cursor-pipe,
partial-update, DisplayPort, and writeback support are deferred.

Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:

- Display console at 1440x3200.
- Panel initialization and DCS transfers complete successfully.

Device Tree Topology
====================

  qcom,dcp-virtio
  VirtIO-MMIO host
  ├── iommus              VirtIO/HFI DMA context
  ├── iommu-ranges        IOVA window
  ├── interrupts          VirtIO + power notification
  ├── mboxes              dcp-power-tx
  └── dcp-subsystem
      ├── compatible       virtio,device34
      ├── iommus           framebuffer DMA context
      ├── port@1           DCP INTF1
      │    └── endpoint ────────────┐
      └── dsi@0                     │
           ├── port@0 ◄─────────────┘
           └── port@1             DSI output

Runtime Architecture
====================

  Linux DRM/KMS
  ├── planes, CRTCs, connector, encoder, DSI bridge
  ├── atomic state and framebuffer handling
  └── DCP VirtIO device driver
              |
              v
  Upstream VirtIO-MMIO transport
              |
              v
  DCP HFI protocol
  ├── capability and resource discovery
  ├── commands and responses
  └── VSYNC, frame-done, and error events
              |
       +------+-------+
       |              |
       v              v
  cmd/resp queues   IPCC mailbox
  HFI buffers       power notification
       |              |
       +------+-------+
              |
              v
       DCP firmware
       ├── display pipeline and VIG/DMA pipes
       ├── DSI PHY and controller
       └── display clocks and resource handling

Dependencies
============

The DT changes depend on the following series:

- VPU IOMMU IOVA handling:

  https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

- Hawi device-tree support:

  https://lore.kernel.org/all/20260923-hawi-dt-post-v1-4-e41473b6298b@oss.qualcomm.com/
  https://lore.kernel.org/all/20260923-hawi-dt-post-v1-3-e41473b6298b@oss.qualcomm.com/

The VPU IOMMU series provides the IOVA handling required by the DCP VirtIO
transport. The Hawi DT series provides the platform nodes and IOMMU
descriptions consumed by this series.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
Jayant Shekhar (13):
      dt-bindings: display: msm: Add Qualcomm DCP bindings
      drm/msm/dcp: Add HFI protocol definitions
      drm/msm/dcp: Add HFI transport over VirtIO
      drm/msm/dcp: Add IPCC power notification
      drm/msm/dcp: Add HFI display command implementations
      drm/msm/dcp: Add planes, CRTCs, and HFI event routing
      drm/msm/dcp: Add DCP encoder
      drm/msm/dcp: Add DSI bridge
      drm/msm/dcp: Register DCP display pipeline
      drm/msm/dcp: Add VirtIO transport and platform driver
      drm/msm: Support KMS backends without a display IRQ
      drm/msm: Register the DCP backend
      arm64: dts: qcom: hawi: Add DCP support

 .../bindings/display/msm/qcom,dcp-dsi.yaml         |   75 ++
 .../bindings/display/msm/qcom,dcp-virtio.yaml      |  113 ++
 .../devicetree/bindings/display/msm/qcom,dcp.yaml  |  119 ++
 arch/arm64/boot/dts/qcom/hawi-mtp.dts              |  131 ++-
 arch/arm64/boot/dts/qcom/hawi.dtsi                 |   59 +
 drivers/gpu/drm/msm/Kconfig                        |   25 +
 drivers/gpu/drm/msm/Makefile                       |   21 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c                 |  747 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_crtc.h                 |  104 ++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c              |  659 +++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h              |   51 +
 drivers/gpu/drm/msm/dcp/dcp_drv.c                  |  245 ++++
 drivers/gpu/drm/msm/dcp/dcp_drv.h                  |   50 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c           | 1140 ++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h           |   69 ++
 drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h            |   77 ++
 drivers/gpu/drm/msm/dcp/dcp_encoder.c              |   31 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.h              |   16 +
 drivers/gpu/drm/msm/dcp/dcp_hfi.h                  |  273 +++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c             | 1219 ++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c             |  191 +++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c              |  253 ++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c        |  601 ++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c          |   64 +
 drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c              |  451 ++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c            |   64 +
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h             |   74 ++
 drivers/gpu/drm/msm/dcp/dcp_ipcc.c                 |  212 ++++
 drivers/gpu/drm/msm/dcp/dcp_ipcc.h                 |   56 +
 drivers/gpu/drm/msm/dcp/dcp_plane.c                | 1077 +++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_plane.h                |   61 +
 drivers/gpu/drm/msm/dcp/dcp_virtio.c               |  302 +++++
 drivers/gpu/drm/msm/dcp/dcp_virtio.h               |   22 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h  |   78 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h |  105 ++
 .../drm/msm/dcp/hfi/hfi_commands_display_events.h  |   90 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h   |   27 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h      |  182 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h      |   61 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h     |  464 ++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h   |  247 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h       |  287 +++++
 .../gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h   |   79 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c           |  106 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h           |   65 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h           |   76 ++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_device.h    |  102 ++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_display.h   |  480 ++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h |  198 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c         |  157 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h         |   77 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c            |   79 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h            |   56 +
 drivers/gpu/drm/msm/msm_drv.c                      |    2 +
 drivers/gpu/drm/msm/msm_drv.h                      |    8 +
 drivers/gpu/drm/msm/msm_kms.c                      |    2 +-
 56 files changed, 11678 insertions(+), 2 deletions(-)
---
base-commit: 08d7e5910b32af25b08b1b16ff89883a38908c72
change-id: 20261014-jshekhar-drm-msm-dcp-v1-cb2b2ad9485b

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

