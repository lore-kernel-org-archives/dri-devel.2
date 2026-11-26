Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BF606A683
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PkJkQQdH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zm0WzVaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1672410F5EF;
	Thu, 26 Nov 2026 06:29:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B96E10F5EF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36J8M394026
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=S1PfSPwOFX0MWE8bPkRfQg
 Tr8TnbUtpYuxljXaH6x70=; b=PkJkQQdH0xbVgnXG9CyAYK6Q8uY2L3DWF/nsA1
 im9xk/28t/eZAFgcUdLVXcj9Scalrj/QoyGfvBPBZ9gB97b/5LaPR+AQfSy/tMqQ
 +HrgK9bgwFJTHE+OfeIxEhCftKcK2fefje+CC9tcmcz7gbo8eNEo8Hkki7tGWlvY
 LMqNfDtya2gh8Y3vk240gWMq+UODwpHI6r1IOkq+HDRisAAeXhGfZSi3R0C7CJzX
 xKVk/SXCDKVbVbmuuPi5dok928hFX7CFsbbcQmsEllR/SFB6knTlLg0hnp+7E/F/
 D3vR7lh0wneVRhQCpvqjYtJo0MqNqrjTrLGKD2Uc3AajaSCA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y1qa5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2f040056fd0so37085495ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674566; x=1796279366;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S1PfSPwOFX0MWE8bPkRfQgTr8TnbUtpYuxljXaH6x70=;
 b=Zm0WzVaVV+HB1UDzsyXEqOJvLzDVYXk1BVBNp8DYGmnMVOKsMNgQo3R4MGb0mEyDZ3
 tzWc1FRZ3TlrWMkQQJKnG4fcSsXbxHcLpW+pWReltIOWvKXbT8OL9CdAAWUAO60wsuNR
 YiyQGcrTZfPrVy4/F79bBoSPAzOo4nEv0DfRwjc2f3OQICKemaY8rv6u4gW4J2Nt1D52
 1IPSaYB45ZEZcgZN1wIFEfiV0H6zplgJOzpZa8lvLa1jWzA22r+IOjoLNTySU8fNnZj6
 CNXJvlnYbKcKgjEC3p0VL0UQkXVlmJJKTTMK0V6N3rDvTk/tJATGEenB8wKja/Y0THJh
 ZiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674566; x=1796279366;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S1PfSPwOFX0MWE8bPkRfQgTr8TnbUtpYuxljXaH6x70=;
 b=GcGSWcQ8xg50zbDQC0maQtx+Rzic89uLDl3+gTHtKsqv2HjZFU3KwN2IRSqQpuAsdB
 kjl7uGIga28b5y/5yUYDqwCwKqDtJWt5+2hXaNeuAe8z0Pi4rH+mMiOWcr6YoCOv0DHh
 klQDay1UzxwSkxOzXV4uu/71sJfAS9YrWDD3pH9xrlAFyfb38Euzlzd1rdngWTAEhAvD
 SZ5TPIqbGcRQYZve+4iIQq1TM+6sDpBsy3Mw1Js24Z1/mGLGcWFGSXjQvYa8oi082N4a
 Doa63iNElhqogCn8jyxdyMhmngSoA4dHZuolrLJy0AE/XhHdQWmzJC/SAGSbmvRrx0qe
 tsfw==
X-Forwarded-Encrypted: i=1;
 AL+hErEGmuMVhohQjvo9dPrT8n4CbdYYv+5iQhIeYH7+FT6+8DjPrgLk0EKILdjom+O2TgttSso/wKur8Ss=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/7vPkxF7UTtQka14O1jTjfQFJWd6xO86IkrZOsTxgVmfzShNf6
 4T/sM2mbGd12+Cg5fpmVBAebJbVS4IaBUA5MT/N56wUq+JvOgPkkPOmnz0/dbwZXK73actQLsrQ
 19DkFACGFfxSbWSMkYfynX8lHpVSTEKRfN/4B6RvuCOZ0NK4FDw5dLyXCiWYZPMow7K0AUNc=
X-Gm-Gg: AZFdTZc9hvji0rEOx0P6KKdgycu5ecbvZiYbDQ8I1PUjWZBMj5BxhpRePbZF2egppj/
 Zn6x9iA/Bf+5PfMUAGD6WENfLszW4TLLM9FKeSpuPgiXzRbNE/pSERmAiiRaX2QO908drzDew3t
 /pXYmf9DOS3K6HmgeEqLLc7QNsMNinVtje5YRcGFw0Bxufi3JZVvoKq49rGYPzv8vqSn9QvRatQ
 fgXh+XN6hJqAH1Ca8WuWiD5mMcEOwbgBXVvpv72Vp63GcpzS5ua6cYYc2pztneKGX/gny1Z1pNr
 veMMDsgeh8guTMAFdaJD0TcfIFMpsWkpEytZyfIjc5wzoiSkSw9TfWDVdlO3XfvhdfdQQ0XUWEc
 NPsXGkv64XJ11nOSzJQoMtWbomOFoauNxA7tCDrI2miMRdxxFoaMetWAMSyNLM0YU+t3/Q9mMuA
 MpdrmEZJBg
X-Received: by 2002:a17:902:d492:b0:2f0:87fa:e3e6 with SMTP id
 d9443c01a7336-2f087fae858mr100200505ad.36.1795674565645; 
 Wed, 25 Nov 2026 22:29:25 -0800 (PST)
X-Received: by 2002:a17:902:d492:b0:2f0:87fa:e3e6 with SMTP id
 d9443c01a7336-2f087fae858mr100200235ad.36.1795674565085; 
 Wed, 25 Nov 2026 22:29:25 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:29:24 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH v3 00/21] drm/msm/dcp: Add Qualcomm DCP display support
Date: Thu, 26 Nov 2026 11:59:08 +0530
Message-Id: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALTRB2sC/0WO22qEMBRFf0Xy3Ay5J0op/Y8yD7mc1EzrqIlKY
 Zh/b9RCXwI77LP2eqACOUFBXfNAGbZU0nivgb80yPf2/gk4hZoRI0xRShm+lR6+epvxxnHwEwb
 T+ki4JFo4VK+mDDH9HMSP65nL6m7glx3z18gwr3VqOWtosovv61DXAPgYlLJSOhOZ045Fr4NWw
 VAZrfeWCNMGQnbOAKXYQ7BrXk8/pv79Zj8OeEt5SeMhulFMsHaidcFq0VL1PpZymVf7XYvDpT5
 vO9XZAnj/SUvXtIJrIlQreRVx3MXqxZU0TEgCtk7qEA2zGl2fz195Myc+SwEAAA==
X-Change-ID: 20261112-jshekhar-v3-dcp-e89cf035074b
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
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=15813;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=8adzhkTct+L8UJxlUtsJlP+OozclkRKTwrEhNyQCbo0=;
 b=zhrpjcY6ZZY5QoduKoGWgyUCTnPSi3da2MZzYzPprK0W+GjxuQ8abyYGni0Nh84SFKKhNI7OH
 NQ771JwviljAkuoGHLXY0Mc8HV6QODjM1Q6H5uQHncsELKpObkS7TEM
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX17DVl/cDu/xS
 fxvZbUIOaTEhmJtxZzgfir49tzZX3TPaCTDgjdr+NyvVxSOhIMBzxAPs1mUS2SAkQ4hYGr07rei
 reXOgazWHd8q/WdUwX4DCWE9VPRFLmkrgVERFcMvfUHV+EV3afSGQVElXPR3pyWMOygrPXYnGO6
 JCx3iBuvMhrWE333VP8uhV3uXnbOKfjMSbiFtcJn+DwS247+IUq96Yx3iDTYigvNReFn+l6G0jY
 CBmt3NJzphBJ3LkDASK88JA9/csn7h4SMlYgeEzs7Ncq6K3IpTJpwczb88W9nLE0F6BY9txFjfO
 0S+t3d9IxwGyVSMxZQlYaxHQ0H9qqvaXcxqdkJwZtj4BxhQaAv6XoSoUMd3wgtLkUOEAieeq05j
 Lg6AZVBG9JsrEXmNDAdrgPU3cij/KrApcjSmAPboLCIJGu54KtDwE8pQHV2kljjXeEESRDo1iKp
 TivecoyKgBWehMGI6pw==
X-Proofpoint-GUID: Ix5rAkugg3GIBVpQgYjb4nrAamdvHe9o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX3qon8l2BDW/t
 +YqyOQ7OJkEFlNb0kuiRam06HOgLrbeaAokuG9iFmqUkf9aEHI7V2RnGZihjMaOHOfRSCGesc8k
 GDVIFvl0UgAg/P6MYvYyZW09pZxUOcM=
X-Proofpoint-ORIG-GUID: Ix5rAkugg3GIBVpQgYjb4nrAamdvHe9o
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07d1c6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=tVI0ZWmoAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8
 a=e5mUnYsNAAAA:8 a=FiR2urJ6vj9GDEvaUFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

On Qualcomm platforms using the Display Co-Processor (DCP), firmware owns
and programs the display hardware. Linux cannot directly access the display
controller, DSI controller or PHY, display clocks, or related pipeline
registers.

This series adds the DCP display-function driver as an MSM DRM/KMS backend.
It discovers display capabilities through HFI over VirtIO and translates
DRM atomic operations into firmware commands, while preserving the existing
MSM DRM device and userspace interfaces.

The series adds:

- HFI protocol definitions, packet helpers, command/response handling,
  capability discovery, and asynchronous display-event processing.
- DRM planes, CRTCs, encoder, DSI host/bridge, and KMS integration for
  firmware-owned display resources.
- HFI-based DSI mode validation, display power/session management, bridge
  configuration, and DCS transfers.
- A DCP VirtIO function driver that carries HFI traffic over VirtIO queues
  and handles the DMA/IOMMU needs of the display function.
- Device-tree bindings for the DCP display function, framebuffer IOMMU
  context, INTF graph, DSI host indices, and downstream display connections.
- Hawi device-tree integration for the DCP display function.

The Qualcomm-specific VirtIO host transport is submitted separately. It
handles IPCC power notification and VirtIO-MMIO register access; this series
contains the DCP function driver and display stack. The function driver
currently validates its parent transport using the device-tree compatible.

DCP is integrated as an MSM KMS backend rather than a separate DRM device.
Firmware reports available display resources and owns the display pipeline;
Linux retains standard DRM/KMS atomic, framebuffer, bridge, and event
handling.

The initial implementation supports the DSI output described below.
Split-pipe, multirect, cursor-pipe, partial-update, DisplayPort, and
writeback support are deferred.

Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:

- Display console at 1440x3200.
- Panel initialization and DCS transfers complete successfully.

Device-tree topology
===================

  qcom,dcp-virtio                         (companion host series)
  └── display-subsystem                   (DCP display function)
      ├── framebuffer IOMMU context
      ├── port@N ────────────────────────> downstream display endpoint
      └── dsi@N
          └── DSI peripheral

The INTF graph endpoint connects directly to the downstream display
endpoint. Firmware-internal paths, including the INTF-to-DSI connection,
are discovered and managed by firmware rather than described in DT.

Runtime architecture
====================

  Linux DRM/KMS
  └── MSM DCP KMS backend
      ├── planes, CRTCs, encoder, and DSI bridge
      └── HFI command and event handling
                  │
                  │ VirtIO queues
                  ▼
          VirtIO core / DCP function driver
                  │
                  ▼
          Qualcomm VirtIO host transport
          (companion series: IPCC and MMIO)
                  │
                  ▼
              DCP firmware
              ├── display pipeline and resources
              ├── DSI controller and PHY
              └── display clocks

Probe and initialization
========================

  Qualcomm host transport initializes power notification
                  │
                  ▼
  Host registers the VirtIO device
                  │
                  ▼
  VirtIO core binds the DCP function driver
                  │
                  ▼
  Initialize HFI queues; send DEVICE_INIT; query capabilities
                  │
                  ▼
  Register the MSM DRM/KMS backend

The host must complete its power-notification sequence before accessing
VirtIO-MMIO registers. Once the VirtIO device is registered, the DCP
function driver initializes HFI, discovers firmware resources, and exposes
the display backend to MSM DRM.

Dependencies
============

- The VPU IOMMU series provides IOVA handling required for firmware-visible
  DMA mappings:
  https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

- The separate Qualcomm DCP VirtIO host-transport series provides the
  IPCC-aware host required to expose the DCP function device.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
Changes in v3:
 - Split the patches into two independent series: one for the Qualcomm VirtIO
   transport and one for the DCP display driver. (Dmitry)
 - Fold the DSI-host schema into the DCP binding, rename the transport child
   to display-subsystem, and clarify the shared interface-index namespace
   and IOVA cell format. (Dmitry)
 - Model the Linux DSI connection as a generic DRM bridge and use
   struct drm_dsc_config rather than duplicating DSC fields. (Dmitry)
 - Move mode-dependent DSC setup and HFI mode validation into atomic check,
   and send display-disable and post-disable HFI commands from their
   corresponding DRM callbacks. (Dmitry)
 - Remove redundant NULL, framebuffer, and vblank-state checks; use
   struct drm_rect for mixer ROIs; and enforce blend-stage limits
   through normalized_zpos. (Dmitry)
 - Remove the portrait-specific width/height cap swap; check max_width
   directly and leave full mode validation to firmware. (Dmitry)
 - Reduce atomic-check diagnostics to debug-level logging and document
   fullscreen-plane handling. (Dmitry)
 - Split the Qualcomm VirtIO host transport into a separate series,
   use VIRTIO_ID_VENDOR and validate the parent DT compatible for DCP. (Dmitry)
 - Clarify that DCP uses firmware-delivered display events and has no
   host-visible display IRQ. (Dmitry)
 - Remove redundant/unused Hawi pinctrl states and clean up the
   DTS formatting. (Dmitry)

Changes in v2:
  - Compared with v1, the series is split into smaller patches. (Dmitry)
  - Reworked the VirtIO transport integration so the Qualcomm
    `qcom,dcp-virtio` wrapper performs the required IPCC power
    notification before accessing the VirtIO MMIO registers and
    registering the virtio_device. The transport registers the device
    directly.
  - Reworked the DT topology so the DCP INTF output connects directly to
    the panel endpoint. The firmware-internal INTF-to-DSI path is no
    described in DT. (Dmitry)
  - Updated the DCP VirtIO binding to document the Qualcomm VirtIO
    transport and VirtIO MMIO register layout, Qualcomm power-notify
    interrupt, IOMMU contexts, mailbox, and firmware-visible IOVA
    range. (Dmitry)
  - Removed the interrupt-names property and used the defined interrupt
    ordering for the VirtIO and power-notify interrupts. (Dmitry)
  - Added panel bridge and component integration so panel bridges are
    resolved through the DCP DSI host before DRM registration. (Dmitry)
  - Tracked CRTCs using firmware display IDs instead of DRM CRTC
    iteration order. (Dmitry)
  - Moved DSI DCS-buffer mapping into KMS hardware initialization,
    after the IOMMU VM became available, with rollback unmapping on
    failure and before VM teardown.
  - Reworked IPCC resource handling to use managed IRQ and mailbox
    cleanup. (Dmitry)
  - Moved IRQ-wake handling to the suspend and resume paths. (Dmitry)
  - Removed the ipcc_valid state and made IPCC initialization and teardown
    follow the channel lifetime. (Dmitry)
  - Embedded the HFI capability cache and removed unused capability fields,
    feature flags, and callback state. (Dmitry)
  - Removed VirtIO config-change capability re-query handling because
    capabilities are consumed during initialization.
  - Removed the temporary self-component shim and registered DCP DSI hosts
    as components. (Dmitry)
  - Added optional GPU component matching for the display-only DCP DRM
    device. (Dmitry)
  - Made HFI packet-ID allocation atomic across wraparound using cmpxchg().
    (Dmitry)
  - Updated bandwidth aggregation to ignore invisible planes and planes
    without framebuffers. (Dmitry)
  - Moved DSI topology values into atomic bridge state while keeping static
    panel configuration separate from per-commit state. (Dmitry)
  - Removed the unused DP catalog and resource path. (Dmitry)
  - Removed unused HFI hotplug and error callback plumbing. (Dmitry)
  - Simplified HFI buffer release paths for callers already holding the
    command lock. (Dmitry)
  - Exported the generic MSM GPU-component matching helper for the DCP
    backend.
  - Replaced deprecated DRM logging macros with DRM device logging helpers.
    (Dmitry)
  - Removed unused includes and fixed indentation, naming, logging, and
    error-handling issues. (Dmitry)
  - Removed status in DT bindings and commit subject. (Krzysztof)
  - Documented the DSI host DT ABI: DSI hosts use the generic dsi@N node
    naming convention, and their reg properties identify the corresponding
    DCP output index. (Krzysztof)
  - Fixed the Assisted-by trailer order. (Dmitry, Krzysztof)

- Link to v1: https://patch.msgid.link/20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com
- Link to v2: https://lore.kernel.org/dri-devel/20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com/

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Philipp Stanner <phasta@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Flemin Jose <flemin.jose@oss.qualcomm.com>
To: Mahadevan P <mahap@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org

---
Jayant Shekhar (21):
      dt-bindings: display: msm: Add Qualcomm DCP
      drm/msm/dcp: Add HFI packet helpers
      drm/msm/dcp: Add HFI device definitions
      drm/msm/dcp: Add HFI display definitions
      drm/msm/dcp: Add HFI panel definitions
      drm/msm/dcp: Add HFI VirtIO transport
      drm/msm/dcp: Handle asynchronous HFI responses
      drm/msm/dcp: Add generic HFI display commands
      drm/msm/dcp: Add HFI DSI and panel commands
      drm/msm/dcp: Add DCP CRTCs
      drm/msm/dcp: Add DCP planes
      drm/msm/dcp: Route HFI display events
      drm/msm/dcp: Add DCP encoder
      drm/msm/dcp: Add DCP DSI host and panel support
      drm/msm/dcp: Integrate the DSI bridge with KMS
      drm/msm/dcp: Register DCP display pipeline
      drm/msm: Export GPU component matching helper
      drm/msm/dcp: Add DCP VirtIO driver
      drm/msm: Support KMS backends without a display IRQ
      drm/msm: Register the DCP backend
      arm64: dts: qcom: hawi: Add DCP support

 .../devicetree/bindings/display/msm/qcom,dcp.yaml  |  159 +++
 arch/arm64/boot/dts/qcom/hawi-mtp.dts              |  108 ++
 arch/arm64/boot/dts/qcom/hawi.dtsi                 |   45 +
 drivers/gpu/drm/msm/Kconfig                        |   26 +
 drivers/gpu/drm/msm/Makefile                       |   20 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c                 |  721 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_crtc.h                 |   85 ++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c              |  708 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h              |   60 +
 drivers/gpu/drm/msm/dcp/dcp_drv.c                  |  193 ++++
 drivers/gpu/drm/msm/dcp/dcp_drv.h                  |   43 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c           |  988 +++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h           |   71 ++
 drivers/gpu/drm/msm/dcp/dcp_dsi_config.h           |   67 ++
 drivers/gpu/drm/msm/dcp/dcp_encoder.c              |   29 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.h              |   16 +
 drivers/gpu/drm/msm/dcp/dcp_hfi.h                  |  264 +++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c             | 1150 ++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c             |  191 ++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c              |  166 +++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c       |  597 ++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c          |   60 +
 drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c              |  325 ++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c            |   63 ++
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h             |   47 +
 drivers/gpu/drm/msm/dcp/dcp_plane.c                | 1042 ++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_plane.h                |   36 +
 drivers/gpu/drm/msm/dcp/dcp_plane_state.h          |   37 +
 drivers/gpu/drm/msm/dcp/dcp_virtio.c               |  310 ++++++
 drivers/gpu/drm/msm/dcp/dcp_virtio.h               |   12 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h  |   78 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h |  105 ++
 .../drm/msm/dcp/hfi/hfi_commands_display_events.h  |   90 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h   |   27 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h      |  182 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h      |   61 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h     |  464 ++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h   |  247 +++++
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
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c            |   62 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h            |   56 +
 drivers/gpu/drm/msm/msm_drv.c                      |    8 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   10 +
 drivers/gpu/drm/msm/msm_kms.c                      |    2 +-
 53 files changed, 10654 insertions(+), 4 deletions(-)
---
base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
change-id: 20261112-jshekhar-v3-dcp-e89cf035074b
prerequisite-patch-id: eecfd66a55b8f2b7b2fc7d76d815facca0489d00
prerequisite-message-id: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
prerequisite-patch-id: 43f30570f31419a014962e6012f98f5b341d46bc
prerequisite-patch-id: 08ffd8da137637eda4fa6d64a4a7fc5a24ea80a6
prerequisite-patch-id: eca5d1310fd57c909cedf1668e075acb966db4ba

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

