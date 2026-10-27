Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB47606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBfSKDWU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZoRi7lI6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7382C10E3EB;
	Tue, 27 Oct 2026 11:59:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCF210E3EB
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:58:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeJBN1427318
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=; b=kBfSKDWUMiXE2MWx
 UfYT9MTCvVbTk9XVkED0JWhz24h90TOvx3quBRZyIGkuBmeOcLVAASYHkSPc5jd9
 20OL1qOFckWZdVF22xCb4DHsImDKQJ+HY0gE9Puoq8vfCxMql1dRBYs6BmAlVWkH
 RckL2BFQH4slxrpmXRzhtbMnE3opd90cHsq4rPjmX5givw+9B3vXRWeJObmuRz6N
 eIczvP7UgFt+gMQysBziSYzWN+aCk2AJj+H9AcxTNT5TBbx8jcMrNpGfkkboZj58
 MM8fBhuJ041bi8ILWgKK1X+7Svs5sFcPpxWAhjOsO50G+lKkwvnJnlDOD4CQpqOn
 EscHRw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbeq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:58:50 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf5c02f7a3so632413137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793102329; x=1793707129;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
 b=ZoRi7lI6Q2LLPvEmniwWsjaHC/1O2roTXZuktNTQoV1Creyblf9vnFTUzhZfyDYf4e
 P/HZ9mgrEfO+7hZFp4NLvoJLSoZBiDrX1FKGiwOycM+ugppdgimT8MeJnrDawwsYWuE/
 h/y2Xd8co1qvdHV9E7turi1Kw/f4x9H64ttrop14naywI1WfzA6SyN9anKIu8P+ZM12/
 yZ3yFdjSXzD5WsXsze1PjwQMMORe6N3qO0ZsLs/R9K0ZYNNt92j3KVbB+hf0x2oF40Iz
 JSXSg44bJ4BZA/BezIRHmSUvExSfM4+Bao0FhAyK8i9RnF19c+RFtgwRAbiBAvcIQHS+
 1GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102329; x=1793707129;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
 b=0XrR07H0yTjkLjDb2plZRVpm11Yf1JUwfr1Nhs4Q0cICccfj4rYXPc1czgcRbiFOHJ
 0QnH12WUKRsq/Wce7DAsKuJW23rF1R/H3D5ykE2B44aygXLXjM0Bzvpq1QrRTvOAq2aW
 0zi6244lXy3CELwYtdVjXgu7RESsugjcGyJW7/mdtRB5w2TLxcMH3kxdrule3e7nojb3
 Yet3iMNo7yx8dhzwiLOhcn8Eeu2A5j3OtSTh8uOgQdiJX4mK5s4pq2S0prTNnXgy6qKF
 7FHm96wq6gjxvi3g098HIxfeeOXRHi8w9qReXWWECyuX0xATaNmv0NwE/t87WodFtMkt
 EVWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxBZDk6PvruIRyyf3GVVPT2hhOH63rSbXBTU7wH6Vv/nqSOv5QiaLuXas076+PSngnMS6u+BGXd/M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIaax/7UcFn0fI13zhZAX6dwmVJ5N4X0QxITYp/8ShZb0q+uz2L
 m8VFvZS22+web7Dme28CEwrc93OzzAC6B0ptl8h8/Xssg25LF3OrSdrhtZ6xAsxp9lLOJQw7NFI
 2R4KDl2wKHDPHYfuA8zI8HcsjZ1cdIyAgV7szS4hXoBVUD/UPO+9DE0ilrx4IfUkKSYYmg9I=
X-Gm-Gg: AYBFou1Gga37pzD7MhGgVVidFiymVAUIMu4MmVn8aDFlid351cim6Rcr6ciObM9xhst
 sxI4MIba2n79BWZ1Q8/7tMzcUiSVV1+MAS/JGlB+6gHSQ4mmWdD0Pw4PHpWmxj9Yvv/V3/HxKWV
 3J9LUdErLm1fZwoxB8TZR5KbQOMrHmCqfyYgPb6ZmVk9GovXsX3QqReUE5aK5sFMHd6PSh+S47X
 wUvn47IBvywTKFTDKwqI3Q+0YFIG8khQECSl/5qvdsgFVbhYy7dir77WmUyctXTuds9COfn4/oF
 KXddnce2xXXCfvwzWIAAqU0+gKCacGdmPMbT9jFxUH5rmRINfJmE8QTiIWjihFOB2RW7VsENUMh
 70JHYpJ9xNHdbz+uGMCj7axha8lx/0MexQG0/67iQsglZLxv2m68GC8LEulGDz7jbKV9t72/Ntx
 ipYrbnrdj43XdO
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id
 ada2fe7eead31-7ce5ce246dfmr3089893137.32.1793102329244; 
 Tue, 27 Oct 2026 04:58:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id
 ada2fe7eead31-7ce5ce246dfmr3089855137.32.1793102328285; 
 Tue, 27 Oct 2026 04:58:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a6aca4sm2092776e87.15.2026.10.27.04.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:58:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:58:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 00/23] drm/msm/dcp: Add Qualcomm DCP display support
Message-ID: <55uzx3sa4jor5p7i5erhyuangyfvc3ssp5rgelagk4ysply2ip@3x46t7swwj56>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX19r87lbggrww
 aD9zLC57aduw5SmQA8zg0v6QlKTYBT8fB24gqbkR/NJFSnyu/IuhywgqKefKtURBFjtwzRSJ+pm
 pcDE+LlLn0/VsVasUWZQmeK7OftNSNQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX/meDpwq4SiSj
 a6V/lJm9gYtNOtXVKjPEoDC/3WFXxb6Acf2+sbGX8Euad7O0JYvBt9xaXeZGIyrOOA8yf5KRfxU
 GH1U/+tzRuIIautOBSlYsU73w/6VkwlX3lPJa58ub/utOzkny6qt4hmZ3UFvBlvw/pxywNWzxH8
 RDzvHyoJC3ek42mY1iT0z1ixqbUhpNNC/Z1A1DUF/al2Ny0DkErH4OE9Mh8jZZtdYWs0UlmilcG
 fuFcBBx8f9ltxWjCy/0Z+s8VY8qm0lQ+59nVAxzlq8pMPv9mfXMBW0XscoRg5UREZkO+sovGBYN
 BXph1/KYSbneKgfQVdlcSBa8Y1CLnDShGH+aps1rALnwEM0LXcaCtUIZ9DmRhJY0vY/PhuN7xQD
 8UDQMMtvpGMLgvIHH81n9ftFBcK0dVSbZbenp/QrtAI6sT6qgII2129Ux+rCNzGF8ocVEwZlIt5
 8zrEePK2X5e9573fWrw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae091fa cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=sWvDS1lmqIG2hvCGZjwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: -b2Qw_HiCPxZu6YltnePlNmdE5P4_D77
X-Proofpoint-GUID: -b2Qw_HiCPxZu6YltnePlNmdE5P4_D77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270047
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:10AM +0530, Jayant Shekhar wrote:
> On Qualcomm platforms using the Display Co-Processor (DCP), the display
> hardware is owned and programmed by firmware. Linux does not access the
> display controller, DSI controller, DSI PHY, display clocks, or other
> display pipeline registers.
> 
> The display pipeline must nevertheless be exposed through the DRM/KMS
> interfaces so userspace can perform modesetting, framebuffer updates,
> panel control, and page flips.
> 
> This series adds a DCP KMS backend to MSM DRM. It represents the
> firmware-owned display pipeline and translates DRM operations into HFI
> commands.
> 
> DCP communicates with Linux over VirtIO and uses the HFI protocol for
> command and response handling, capability discovery, and display events.
> 
> This series adds:
> 
> - Device-tree bindings for the Qualcomm DCP VirtIO transport wrapper,
>   firmware-visible IOVA ranges, separate transport and framebuffer IOMMU
>   contexts, IPCC power notification, interrupts, and the external DSI
>   display graph.
> 
> - HFI protocol definitions and packet helpers for capability discovery,
>   modesetting, plane and CRTC configuration, DSI, and panel control.
> 
> - A Qualcomm DCP transport wrapper which initializes the IPCC channel,
>   sends the required power notification, and registers the DCP VirtIO
>   device directly. The wrapper also implements the MMIO transport and
>   keeps VirtIO queue activity ordered with DCP power transitions.
> 
> - VirtIO command and response queues. HFI command, response, and
>   capability buffers are allocated through the DMA API in the address
>   space visible to DCP firmware.
> 
> - Synchronous command tracking, asynchronous response dispatch, timeout
>   handling, and queue teardown synchronization for safe device removal.
> 
> - Capability discovery for displays, CRTCs, mixers, VIG and DMA pipes,
>   DSI interfaces, and panel resources.
> 
> - DRM planes and CRTCs using the standard atomic-state model. DRM state is
>   translated into HFI properties for layer configuration, mixer limits,
>   bandwidth and clock properties, frame sequencing, and triggering.
> 
> - An MSM KMS backend, DCP encoder, and DSI bridge. The backend reuses the
>   existing MSM DRM device, GEM and framebuffer handling, atomic commit
>   infrastructure, encoder, bridge, and connector support.
> 
> - Asynchronous VSYNC, frame-scan completion, and error events propagated to
>   DRM for vblank and page-flip completion.
> 
> - IPCC power notifications to wake DCP firmware and coordinate HFI queue
>   activity across firmware power transitions.
> 
> DCP is integrated as an MSM KMS backend rather than a separate DRM device.
> This preserves the userspace-visible MSM DRM device and allows Linux to
> retain normal DRM/KMS semantics while display hardware remains owned by
> firmware.
> 
> The initial implementation supports the DSI output described below and
> uses resources reported by firmware. Split-pipe, multirect, cursor-pipe,
> partial-update, DisplayPort, and writeback support are deferred.
> 
> Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:
> 
> - Display console at 1440x3200.
> - Panel initialization and DCS transfers complete successfully.
> 
> Device Tree Topology
> ====================
> 
>   qcom,dcp-virtio
>   ├── transport IOMMU context
>   ├── firmware-visible iommu-ranges
>   ├── VirtIO and power-notify interrupts
>   ├── dcp-power-tx mailbox
>   └── dcp-subsystem
>       ├── compatible = "virtio,device34"
>       ├── framebuffer IOMMU context
>       ├── port@0
>       │   └── endpoint ─────────────── panel endpoint
>       └── dsi@0
>           └── panel@0
> 
> The DCP INTF endpoint connects directly to the panel endpoint. Firmware
> internal paths, including the INTF-to-DSI connection, are not described in
> the device tree.
> 
> Runtime Architecture
> ====================
> 
>   Linux DRM/KMS
>   └── DCP MSM KMS backend
>       ├── planes, CRTCs, encoder, connector, and DSI bridge
>       └── DRM atomic state and commit handling
>                   │
>                   ▼
>       DCP VirtIO function driver
>                   │
>                   ▼
>               VirtIO core
>                   │
>                   ▼
>       qcom,dcp-virtio transport wrapper
>       ├── IPCC initialization and power notification
>       ├── MMIO register access
>       ├── VirtIO queue setup and interrupt handling
>       ├── VirtIO device registration
>       └── suspend/resume power sequencing
>                   │
>                   ▼
>               DCP firmware
>               ├── HFI command and response handling
>               ├── display pipeline and VIG/DMA pipes
>               ├── DSI PHY and controller
>               └── display clocks and resource handling

Going through the series, I have come with the quite generic comment.
Please split the series into two independent parts:
- Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
  drivers/virtio/virtio_dcp_*.[ch]

  Driver for the DCP + IPCC VirtIO host. The driver should not know
  anything about the display interface.

- Documentation/devicetree/bindings/display/msm
  drivers/gpu/drm/msm/dcp

  The actual driver for the DCP display engines. It must not know or
  care at all about the particular VirtIO host (or SoC FWIW). It should
  not use IPCC. If we pass it through to the VM via virtio-mmio or
  virtio-pci it must work as is.

Possibly submit those as two separate series.


-- 
With best wishes
Dmitry
