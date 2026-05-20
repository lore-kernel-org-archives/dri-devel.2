Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0FCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6AF10E826;
	Wed, 20 May 2026 14:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSDgISG+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMMP1HU7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E911710EFFA
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:12:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuSBr3680289
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=; b=cSDgISG+AOhCmG7R
 DKix72vBfFMmRS7S5JLtuxJgxQ5rA/o91om6pqfXovLaO82aNU3pJLEx7Gv0w3Ug
 qklISnqIKD1ip2d4rvBvU+6XC7jC9BWp+gRYSFso1oPY6GoHyKUX47jeqU9hr37g
 8pWE99iqikCzwkoGHLhOJd11rwpLAsHX9X/w7Lek/kn7r5oD+xRa0sJXoOVy/WnM
 NV+qkDCcoAS8bHvgs08mfpJZKKDCqHndlwYjJWsFwgx1my1puF+DciEmUIXIs2rN
 km8/aItafF6gKi9C0DxV81h2ZXVjN04qiOwEdHsHyj4VN2y+BPsuO4z755cJEnAz
 b6Bgdg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j021t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:12:25 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-56f69a1a9f5so15411489e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779286344; x=1779891144;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=;
 b=OMMP1HU7Ko0C3vQsJKzSvgESrCEvTQ0oq5+gHyr5+mSmDAgy4WURFvjQNq1wqWv9Xt
 Xg4pLKMMjo6XuQqdGfqiuZ3zahhTRL5QhAVgN8xZQywGNU2muais9j/8nFlnqdHh5A8t
 dfMVRguiKcuNXGosHhgF4ZWMG+9nyrIrIa7uNOfd1XbJTwK+Z4eomo94vPFMhFhz4uSH
 LKlL6MaAsPMap5VqCg3UM0dY1jxDl5xYs9B9gA4ZXo1nBwfy+EtgAi3UVRKgOIuo7uhl
 yLH+apU4VhC9c3xQ3UqUYhHQ0X7H12TmxfYqxue7zoITRZMsvP8MaZaCw3/ijfpBmJ1U
 3Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286344; x=1779891144;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fjc/US0eOmCaq8NJVQ5/t7CluwSHuURJ7uN+zaRxrGg=;
 b=elDxiFivx/zs9wdBhrow6V4WhPw3cgB+ToXFO0kysd1R2+/2gYAwfqubWc5HipNqCb
 19obHXu/8DHlJqJRaYXHGvGbAOjPz6wu+Ui0C/otHEIVZF/sWQg3z8M/B2kemI7ZOJFP
 D5gAP/rPGLAopjv0gjmHWdleU4ML1iqew5oll2ecm+snmIZi4ro5QhhMctak4vvGnvXI
 lojy1sMKat6Y1zbWj02ldqBeWp1/nB955B5wfzrO+E94Gm8IjLF3m7wLkkV54NRQvhgN
 x1m7OTQ4jM+p18KKaajZAg60xzjdsU+e2+I/xepX2yjdqpHSxYQk2nRA/BowQ9fQj79G
 iEZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+emR3r6QBW4OfahNt8YOj/wNTcUwFaAr6y5Xz81Hqy4n28wSXJH2e2JAmmKUOBoAHiwtA7S47wFzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgYB65T+Crydb8MDV7rokXMr9i6ZNWmJn50JnWlOMg3dlL204u
 bBpk99Ra84EmvikPp5F0bDdkDFFa71J1hBN0QnWSaCMEF0bY4QgLzKH8HOXJafHpEplEQvOgjlQ
 cQP1Zxle/UHnrpWpkH5tw/SRLGpkrHr7d7pkMQTo5gh062JXpE5sVxb3RyoWpO+7ECgUn0fE=
X-Gm-Gg: Acq92OHh7ZAe9DG/Xd8oIOEhl8hfV7+5WHq//DYmSaIn6S91ymZvboc4lGtkXOxvzsb
 BOOTCJYwg1H5WjO+ScrYdLVN/VeuiGDJvKP/A/TYvd2jrFzn2p8sfDQedJVtM6tW8b4Q+FjCPV1
 RBXyEQr/+FjhPu23GOOHY3LPd43nwcbdKbg6IVaOdSkHEp96R3+mN+sdkkrHycoxPMaI3DvdgJU
 +/V70D999Dums8hRU8dWPTInwrPDCc8Pv3PtJkKcM3i+sd++6nQXEvpxxvn5sL4ALQEoMLFzJC/
 YaLq/x6AV6slK7Zq8OoLy7EWGdntdGGNaog47rb+zmk22/DV/wqROLj7W+JMtgJIdzgCk01s2pl
 UvdnrkTtqRr5v6WMLncCcAeckXBX2EescqP2Q4TZBKbz5llcxAoo6pMmqwVaTYws7sI5JIjrBe0
 y5fbcd5VekOJqoQL4YSls+UlZCJtKROCubgbY=
X-Received: by 2002:a05:6122:2676:b0:57d:6d56:11ff with SMTP id
 71dfb90a1353d-57d6d56133cmr2372266e0c.9.1779286343936; 
 Wed, 20 May 2026 07:12:23 -0700 (PDT)
X-Received: by 2002:a05:6122:2676:b0:57d:6d56:11ff with SMTP id
 71dfb90a1353d-57d6d56133cmr2372208e0c.9.1779286343311; 
 Wed, 20 May 2026 07:12:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cec52sm4960154e87.72.2026.05.20.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:12:22 -0700 (PDT)
Date: Wed, 20 May 2026 17:12:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
Message-ID: <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dc149 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=x97SpM1XRKmEcGPL2ZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: Iz-CcKtGiPU6YZSpYTuHwQesOSm7K8n9
X-Proofpoint-ORIG-GUID: Iz-CcKtGiPU6YZSpYTuHwQesOSm7K8n9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOCBTYWx0ZWRfX2du8ZiXZT5vF
 3TbVaJDkQAfnq8KhCvHrEO7fRy+FgeI1Z/FnX3Ni16qamtqJqN3dyXAT+UaEnzOa8aMfnZZiMa/
 INX6Surq5tbtMtxXpbu6wDfi5DKw3gaPNRemxXyTYzbG7+JO+gds+/jJO+ExWlRijpJ9VmDSEPZ
 R507UkPe9AemWCVZRRUg6pqJp9FUvx/ZzEwobxfWIiXGpa3iLibk7XnFi0UbXajDRM0xpxM7DhO
 Ge2uIfQWC+Xb7s/1wN1fK1VnRiYctUzkfCtrYDiASg37EvucaZWYj7eu5fP4MMDG3Duo178HFbP
 vbYgyQapJliHyqENcYC7J/lNZ9iGeCBJkvmmmgs2XL99xmvioiHPRHcK+7yfaXIqDpIc/mVwshd
 j1NLRdNz7KAbKPr4fLciAhRl60JZn9mlNyb+PZOXZFyw4tMwNRbSKOqzSEOr3MvdR+N+lc7dFNr
 ETNulJw8BMvn5DLXniw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200138
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

On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
> Documentation/accel/qda/. The documentation covers the driver
> architecture, GEM-based buffer management, IOMMU context bank
> isolation, and the RPMsg transport layer.
> 
> The user-space API section describes the DRM IOCTLs for session
> management, GEM buffer allocation, and remote procedure invocation via
> the FastRPC protocol, along with a typical application lifecycle
> example. Sections for dynamic debug and basic testing are also
> included.
> 
> Wire the new documentation into the Compute Accelerators index at
> Documentation/accel/index.rst.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  Documentation/accel/index.rst     |   1 +
>  Documentation/accel/qda/index.rst |  13 ++++
>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
> 
> diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
> index cbc7d4c3876a..5901ea7f784c 100644
> --- a/Documentation/accel/index.rst
> +++ b/Documentation/accel/index.rst
> @@ -10,4 +10,5 @@ Compute Accelerators
>     introduction
>     amdxdna/index
>     qaic/index
> +   qda/index
>     rocket/index
> diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
> new file mode 100644
> index 000000000000..013400cf9c25
> --- /dev/null
> +++ b/Documentation/accel/qda/index.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==================================
> +accel/qda Qualcomm DSP Accelerator
> +==================================
> +
> +The QDA driver provides a DRM accel based interface for Qualcomm DSP offload.
> +It uses the FastRPC protocol and integrates with DRM and GEM infrastructure
> +for device and buffer management.
> +
> +.. toctree::
> +
> +   qda
> diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
> new file mode 100644
> index 000000000000..9f49af6e6acc
> --- /dev/null
> +++ b/Documentation/accel/qda/qda.rst
> @@ -0,0 +1,146 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=====================================
> +Qualcomm DSP Accelerator (QDA) Driver
> +=====================================
> +
> +Introduction
> +============
> +
> +The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides a
> +DRM accel based interface for Qualcomm DSP offload, supporting workloads
> +such as AI inference, computer vision, audio processing, and sensor offload
> +on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM and
> +GEM infrastructure for device and buffer management.
> +
> +Key Features
> +============
> +
> +*   **DRM accel Interface**: Exposes a standard character device node
> +    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
> +*   **FastRPC Protocol**: Implements the FastRPC protocol for communication
> +    between the application processor and the DSP.
> +*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
> +    allocation, lifecycle management, and DMA-BUF import/export.
> +*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory isolation
> +    between different DSP user sessions.
> +*   **Modular Design**: Clean separation between the core DRM logic, the
> +    memory manager, and the RPMsg-based transport layer.
> +
> +Architecture
> +============
> +
> +The QDA driver consists of several functional blocks:
> +
> +1.  **Core Driver (``qda_drv``)**: Manages device registration, file operations,
> +    and DRM accel integration.
> +2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory management
> +    layer that handles IOMMU context banks. It supports pluggable backends
> +    (such as DMA-coherent) to adapt to different SoC memory architectures.
> +3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
> +
> +    * **``qda_gem``**: Core GEM object management, including allocation, mmap
> +      operations, and buffer lifecycle management.
> +    * **``qda_prime``**: PRIME import functionality for DMA-BUF interoperability
> +      with other kernel subsystems.
> +
> +4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg framework
> +    to handle low-level message passing with the DSP firmware.
> +5.  **Compute Bus (``qda_compute_bus``)**: A custom virtual bus used to
> +    enumerate and manage the specific compute context banks defined in the
> +    device tree. The bus was introduced because IOMMU context banks (CBs) are
> +    synthetic constructs — not real platform devices — making a platform driver
> +    an incorrect abstraction for them. The earlier platform-driver approach also
> +    had a race condition: device nodes were created before the RPMsg channel
> +    resources were fully initialized, and because ``probe`` runs asynchronously,
> +    applications could open a CB device and attempt to start a session before
> +    the underlying transport was ready. The compute bus makes CB lifetime
> +    explicitly subordinate to the parent QDA device, closing that window.
> +6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic for
> +    marshalling arguments and handling remote invocations.
> +
> +User-Space API
> +==============
> +
> +The driver exposes a set of DRM-compliant IOCTLs:
> +
> +*   ``DRM_IOCTL_QDA_QUERY``: Query DSP type (e.g., "cdsp", "adsp")
> +    and capabilities.
> +*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process context
> +    on the DSP.
> +*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation (the
> +    primary execution unit).
> +*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP usage.
> +*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memory mapping.
> +*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Map or unmap
> +    buffers into the DSP's virtual address space. Each accepts a ``request``
> +    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGACY`` /
> +    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
> +    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).

Explain, what happens in the users don't map the buffers into the DSP
space. Will DRM_IOCTL_QDA_REMOTE_INVOKE handle the mapping or not? What
is the difference between those two modes?

Would the driver benefit from using GPUVM?

> +
> +Usage Example
> +=============
> +
> +A typical lifecycle for a user-space application:
> +
> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
> +    device node.
> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
> +    establish a session and create a process context on the DSP.
> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or import
> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass arguments and
> +    execute functions on the DSP.
> +5.  **Cleanup**: Close file descriptors to automatically release resources and
> +    detach the session.

I'd have expected the description of the actual example. I.e. clone the
app from https://the.addr, prepare clang >= NN.MM, QAIC (https://foo),
run make, run the app, check the results. I'd remind that DRM Accel has
a very specific requirement of having the working toolhain in the
open-source.

> +
> +Internal Implementation
> +=======================
> +
> +Memory Management
> +-----------------
> +The driver's memory manager creates virtual "IOMMU devices" that map to
> +hardware context banks. This allows the driver to manage multiple isolated
> +address spaces. The implementation uses a DMA-coherent backend to ensure data consistency
> +between the CPU and DSP without manual cache maintenance in most cases.

GEM usage?

> +
> +Debugging
> +=========
> +The driver includes extensive dynamic debug support. Enable it via the
> +kernel's dynamic debug control:
> +
> +.. code-block:: bash
> +
> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_debug/control
> +
> +Testing
> +=======
> +The QDA driver can be exercised using the ``fastrpc_test`` utility from the
> +FastRPC userspace library. Run the test application:

pointer

> +
> +.. code-block:: bash
> +
> +    fastrpc_test -d 3 -U 1 -t linux -a v68
> +
> +**Options**
> +
> +``-d domain``
> +    Select the DSP domain to run on:
> +
> +    * ``0`` — ADSP
> +    * ``1`` — MDSP
> +    * ``2`` — SDSP
> +    * ``3`` — CDSP *(default on targets with CDSP)*
> +
> +``-U unsigned_PD``
> +    Select signed or unsigned protection domain:
> +
> +    * ``0`` — signed PD
> +    * ``1`` — unsigned PD *(default)*
> +
> +``-t target``
> +    Target platform: ``android`` or ``linux`` *(default: linux)*
> +
> +``-a arch_version``
> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
