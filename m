Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927ADC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9614710E3C5;
	Mon, 17 Aug 2026 04:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XboIU2tH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0AZINtZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2A610E3C5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDs5v856998
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PuQ+dyZpJqr1RpG9/VFSg2QnHWbegqtlPq2np7ofsvM=; b=XboIU2tHR0ICaw8l
 gatRswRN19A5oaw9PNm808p+8aEYvP5B2DDeTcVzmbJupoKN3hLFi66mbEfK/wkP
 WRJbPve5eLLcFMXLv1OqW05sGxbNvqOXqJ6EdomGEi2TRJynCVUVhtPA/t/pvD45
 ek0bAOvIWpf5AvlJEVU8l8NRoi0sVmrHrSd5jk+DP5jxKpi8fvjwJsBR/upLaQma
 Ig6Amq65knkDuPcNAnc+m3I4kyH7NhY8GZkK/1YMubqFsy5phFvv90zkxPI4I5GW
 vBq2qOnn9z2Gf8I2c8c3tGoOV3XVwp3A2DrYclQ9a12TW8wgCNPBI1XeX/XbwlYL
 U3IKTw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwn531-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so2912581b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942085; x=1787546885;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PuQ+dyZpJqr1RpG9/VFSg2QnHWbegqtlPq2np7ofsvM=;
 b=i0AZINtZM2eRH7YlOthGsXNrydqy1DsOJ8tZPPhNyrifXB1SMEx28tuncr1vzx86X8
 GheYXuNcHjyfG8P7Mcm2F8XxmtFEVyFmiHf3I8qg0PcnojNvdQfsBoRUPNizuoi261eq
 vTvCXd6Ik7aIfEyXGVk/62xPoZ2wFN9lAtKq/1p0KAxq7myDaY19UIh6qQoB5LKcOs+Q
 iaiHlRQmtnLEY1GF++2cxYHh76emiZ4Biu23nfGwHIBjokjb6C+Xr77a/T01W2LZMuop
 dMxPq2NEXijzb1ixnHRHuvdCre6l2NYp2dnbUmwK45kGpSwvoc9yPXvGlCCLe+vulMV5
 TAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942085; x=1787546885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PuQ+dyZpJqr1RpG9/VFSg2QnHWbegqtlPq2np7ofsvM=;
 b=QuoQBdE5KotmPJ+sI5Jwa7OaVSCGXe2BSAAs4nlnSh0RL3A8Vy7x1XlXFpMvg06VuT
 PQf5QOeW6J7PNhen2uvkBPmhdyJN/ZdqaA1mf3LTyKgf8tnocd/Qi2QLsWGhlyuraw1p
 7wlZaCg/El6+x9T1O0n+JWav9VYVzghiyVzxsipgR3MueaSwuX52fnB0RxStJ12VKRLA
 jG6u03muQsskm7Wug6hPR72VVGm0KWUv6z7qEBO0qhoPCFoj/3FWSo1TvF0si4lz8sWc
 uMLXHPImebGiosmIHla+mfx8cUn+YhCbzBlRXaXDyA2lQ+qHEGcpq5SThqoswEfbfpmI
 L89Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKrUmQpSlWVrN/Xs9UiGpAO8vwcQEfCrP6hHWYbmivBW1KnxueikxRTtdvxXcBpojCKohMhUTl0pM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmOYO6VPPpM8MOJPHmo3t+LrPMeLhOGHzu3/z3OHcfiNCYje0t
 QjVfDC7duWfxZmnjvQNm0ZhbsI2lMAHeTzVUUo+m/ySmCugcJVYHWe02h/W2zEc+fgkXuxtyErJ
 5nR5+DeSKcwmoxlOp9nj2bREvD4exohWRuLvJN5CZ+gJrgFmYXfRGAnn+Dd8vBkzHWxBiXfc=
X-Gm-Gg: AR+sD12U6t9cVUhXpJI6lHowsjbCjAQbpUQouIKkNTL97Oaz17jztX2eCFk6M0yg6Cd
 wwuq363gAy0doXq5agOi256igmSiEzcZDLlxikb1hq1ixZaDfTW7IKcg1KNcZC4kF+mG3iNqR8R
 BrthLLdN2M8X3raYyLTmXnu/FcbRosFJ3jn/SmYdMzqLDQOYNRaT0ixIy6xBioQgTVsyTf41ZSD
 R3pJOu5+xaMoTStbGwz1LhnxZugAk2At18lA/0IVGm+tYdOXan9ksNaoSkj58iwjqHwtuvTlLNQ
 DZ+sInKpxkuDYY7/ed4+NZnYxZkQLDEPvwjNIpRAuwdUZN1Wj40lQfD3TEh418jDfqcGjhUeRcC
 UB5qk2mirTOdL2zeHwdL2zC5DyDGk08uU
X-Received: by 2002:a05:6a00:4502:b0:846:f517:ba5a with SMTP id
 d2e1a72fcca58-84fde3e5737mr22785042b3a.28.1786942084475; 
 Sun, 16 Aug 2026 21:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:4502:b0:846:f517:ba5a with SMTP id
 d2e1a72fcca58-84fde3e5737mr22784996b3a.28.1786942083985; 
 Sun, 16 Aug 2026 21:48:03 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:48:03 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:37 +0530
Subject: [PATCH v2 02/15] accel/qda: Add QDA driver documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-qda-v2-v2-2-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=10551;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=s4qS4qk0iKOII4Too+x8DDYPaoroX9lvNznQX8dMsdc=;
 b=6AMGjvYlQK7kqcLh2D7azpHnCteWLXp3wiS0gm4FGTE0MCWVEXJCDgLh0pYXowy/5zqudsGde
 bz0Nyda7uA9Aw6/7LjqylHAlpX2hhRnGQ4huDxJsU6htzYIIEm2+f1z
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: rVxTguevZyxWxcqrjRJbc7ISRDeCDl6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX1S8+6J0j2JmQ
 tIgWMS2EKZnv0B83QrJ7KQ+/eTcDcHLXB5C19I79ABUFKw4aLfnjNaPj0LpD/TPP1nL/gUsL20R
 GvRtMBe9X+qevj0RM4lP3Rnyjq/mzqvY6lcx9K8tqCL4+uLQucuxEoyHv54wfzxbYyqKsGAsPF9
 65vXlu4qQ/4PSZTB/ZfEfnD8B3kesdJaiEw4UKO5JHd/gF/M2V+sYYFDD+FblMUvDPjC9qM2OR1
 qbswK0TQ5HRwa/SeApORur3vLM4uVG735IRB9vfo8T6h1TUG/4wdBisL7u04W9YSSBAK0kbu0mS
 IqKfD+OCgZRYGo9Y36tReRU16gmZNIz7nvooWXfikR6tdYrwUAeqnpI21kn4Hw0VKCsCiRSqA1J
 pOuXGUmvSDtb7zf9v7xPIN1oWEwFskML1k174+OyWb3iH6aCy2WYPMHBBpTY8aOA8CQtbZfNm0N
 Dfd+IGAme8NObUX2v5g==
X-Proofpoint-GUID: rVxTguevZyxWxcqrjRJbc7ISRDeCDl6i
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a829285 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=b5As1VL6SZ8mNc28oXsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX5VtlMYWz/pHR
 4LNd1xm6EM+ZzBBfnScHcHf3GRnZvrAoLR/MYAFfvXN6d3M5dczJN25EzKlpdTffFQDOMGqrEQQ
 MHydlj5HxdOSXp8OF1CL+dR9MgO5ThQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170033
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

Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
Documentation/accel/qda/. The documentation covers the driver
architecture, GEM-based buffer management, IOMMU context bank
isolation, and the RPMsg transport layer.

The user-space API section describes the DRM IOCTLs for session
management, GEM buffer allocation, and remote procedure invocation via
the FastRPC protocol, along with a typical application lifecycle
example. Sections for dynamic debug and basic testing are also
included.

Wire the new documentation into the Compute Accelerators index at
Documentation/accel/index.rst.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Explain implicit per-invocation mapping vs persistent REMOTE_MAP
  (Dmitry Baryshkov)
- Add a GPUVM section explaining why gpuvm is not used
  (Dmitry Baryshkov)
- Expand the memory management section to describe GEM usage and PRIME
  interoperability (Dmitry Baryshkov)
- Add links to the open-source user-space library and QAIC compiler, and
  document how to build them (Dmitry Baryshkov, Tomeu Vizoso)
---
 Documentation/accel/index.rst     |   1 +
 Documentation/accel/qda/index.rst |  13 +++
 Documentation/accel/qda/qda.rst   | 191 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)

diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
index cbc7d4c3876a..5901ea7f784c 100644
--- a/Documentation/accel/index.rst
+++ b/Documentation/accel/index.rst
@@ -10,4 +10,5 @@ Compute Accelerators
    introduction
    amdxdna/index
    qaic/index
+   qda/index
    rocket/index
diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qda/index.rst
new file mode 100644
index 000000000000..013400cf9c25
--- /dev/null
+++ b/Documentation/accel/qda/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==================================
+accel/qda Qualcomm DSP Accelerator
+==================================
+
+The QDA driver provides a DRM accel based interface for Qualcomm DSP offload.
+It uses the FastRPC protocol and integrates with DRM and GEM infrastructure
+for device and buffer management.
+
+.. toctree::
+
+   qda
diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/qda.rst
new file mode 100644
index 000000000000..3a9ba4a90803
--- /dev/null
+++ b/Documentation/accel/qda/qda.rst
@@ -0,0 +1,191 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================================
+Qualcomm DSP Accelerator (QDA) Driver
+=====================================
+
+Introduction
+============
+
+The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides a
+DRM accel based interface for Qualcomm DSP offload, supporting workloads
+such as AI inference, computer vision, audio processing, and sensor offload
+on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM and
+GEM infrastructure for device and buffer management.
+
+Key Features
+============
+
+*   **DRM accel Interface**: Exposes a standard character device node
+    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
+*   **FastRPC Protocol**: Implements the FastRPC protocol for communication
+    between the application processor and the DSP.
+*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
+    allocation, lifecycle management, and DMA-BUF import/export.
+*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory isolation
+    between different DSP user sessions.
+*   **Modular Design**: Clean separation between the core DRM logic, the
+    memory manager, and the RPMsg-based transport layer.
+
+Architecture
+============
+
+The QDA driver consists of several functional blocks:
+
+1.  **Core Driver (``qda_drv``)**: Manages device registration, file operations,
+    and DRM accel integration.
+2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory management
+    layer that handles IOMMU context banks. It supports pluggable backends
+    (such as DMA-coherent) to adapt to different SoC memory architectures.
+3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer management:
+
+    * **``qda_gem``**: Core GEM object management, including allocation, mmap
+      operations, and buffer lifecycle management.
+    * **``qda_prime``**: PRIME import functionality for DMA-BUF interoperability
+      with other kernel subsystems.
+
+4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg framework
+    to handle low-level message passing with the DSP firmware.
+5.  **Compute Bus (``qda_compute_bus``)**: A virtual bus that enumerates the
+    compute context banks described in the device tree. IOMMU context banks are
+    synthetic constructs rather than real platform devices, so a dedicated bus
+    is a better fit than a platform driver, and it makes context bank lifetime
+    explicitly subordinate to the parent QDA device.
+6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic for
+    marshalling arguments and handling remote invocations.
+
+User-Space API
+==============
+
+The driver exposes a set of DRM-compliant IOCTLs:
+
+*   ``DRM_IOCTL_QDA_QUERY``: Query DSP parameters, such as the DSP name and
+    hardware capabilities, based on a user-specified ``query_type``.
+*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process context
+    on the DSP.
+*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation (the
+    primary execution unit).
+*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP usage.
+*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memory mapping.
+*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Map or unmap
+    buffers into the DSP's virtual address space. Each accepts a ``request``
+    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGACY`` /
+    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
+    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).
+
+    Note that ``DRM_IOCTL_QDA_REMOTE_INVOKE`` will automatically perform
+    dynamic, short-lived mappings for buffer arguments on the fly during a
+    single invocation. However, for performance-critical or frequently
+    used buffers, explicitly mapping them persistently via
+    ``DRM_IOCTL_QDA_REMOTE_MAP`` bypasses this dynamic pin/map/unmap overhead
+    on subsequent invocations.
+
+Usage Example
+=============
+
+A typical lifecycle for a user-space application:
+
+1.  **Discovery**: Open ``/dev/accel/accel*`` and use
+    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
+    device node.
+2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
+    establish a session and create a process context on the DSP.
+3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or import
+    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
+4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass arguments and
+    execute functions on the DSP.
+5.  **Cleanup**: Close file descriptors to automatically release resources and
+    detach the session.
+
+Internal Implementation
+=======================
+
+Memory Management & GEM Usage
+-----------------------------
+The QDA driver uses the standard DRM GEM framework to manage memory buffers.
+Native buffers are allocated from coherent DMA memory and represented as GEM
+objects.
+
+The memory manager creates virtual "IOMMU devices" that map to hardware
+context banks, giving each user session an isolated address space. The
+DMA-coherent backend keeps data consistent between the CPU and DSP without
+manual cache maintenance.
+
+PRIME Interoperability
+~~~~~~~~~~~~~~~~~~~~~~
+By integrating with the DRM GEM PRIME interfaces, the QDA driver supports
+zero-copy sharing of memory buffers (DMA-BUFs) with other multimedia and
+compute subsystems on the SoC.
+
+GPUVM
+~~~~~
+While the DRM core provides the ``gpuvm`` helper framework to manage virtual
+address spaces, the QDA driver does not utilize it. This is because the DSP
+virtual address allocation and page table updates are managed entirely by the
+secure kernel running on the Hexagon DSP. The AP-side driver's responsibility
+is strictly limited to mapping physical pages into the SMMU context bank;
+therefore, the extra layer of AP-side VM tracking provided by GPUVM is redundant.
+
+Debugging
+=========
+Diagnostic messages are emitted through dynamic debug. Enable them for the
+whole driver with:
+
+.. code-block:: bash
+
+    echo "module qda +p" > /sys/kernel/debug/dynamic_debug/control
+
+Testing
+=======
+The QDA driver can be exercised using the ``fastrpc_test`` utility from the
+open-source FastRPC userspace library available at `qualcomm/fastrpc
+<https://github.com/qualcomm/fastrpc>`_.
+
+Building Userspace & Tests
+--------------------------
+To satisfy the DRM accel requirement for a fully open-source userspace toolchain,
+the compiler, userspace library, and test suite must be set up using standard
+open-source tools:
+
+1. **Install Compiler**: Install the latest LLVM.
+2. **QAIC Compiler**: The Qualcomm IDL Compiler (QAIC) is fully open-source and
+   available at `qualcomm/QAIC <https://github.com/qualcomm/QAIC>`_.
+3. **Build FastRPC Userspace Library**: Clone and compile the library:
+
+   .. code-block:: bash
+
+       git clone https://github.com/qualcomm/fastrpc.git
+       cd fastrpc
+       ./gitcompile --host=aarch64-linux-gnu
+       make
+       sudo make install
+
+Running the Test Application
+----------------------------
+Once installed, run the test utility on the target device:
+
+.. code-block:: bash
+
+    fastrpc_test -d 3 -U 1 -t linux -a v68
+
+**Options**
+
+``-d domain``
+    Select the DSP domain to run on:
+
+    * ``0`` — ADSP
+    * ``1`` — MDSP
+    * ``2`` — SDSP
+    * ``3`` — CDSP *(default on targets with CDSP)*
+
+``-U unsigned_PD``
+    Select signed or unsigned protection domain:
+
+    * ``0`` — signed PD
+    * ``1`` — unsigned PD *(default)*
+
+``-t target``
+    Target platform: ``android`` or ``linux`` *(default: linux)*
+
+``-a arch_version``
+    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*

-- 
2.34.1

