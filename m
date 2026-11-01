Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD72606E52D
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HrzSG3s0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GomP/XvO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B94110E484;
	Sun,  1 Nov 2026 22:21:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB3210E484
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:21:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KJuHx2822042
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cp3eEG1uR9LfG2MoyOCL+bQoZ2d+X/rNrmJkd2KbD0I=; b=HrzSG3s0fCOiYYn7
 smaye8HJ+vHZKXCpq6Oa6zx5Gff412eCUHnvhqr/citJ29Lbl+6kJJ4gSuJSPZhQ
 leikp9diO33vvFrhYvHic4KtlGuoB27JQlN8b6yyRtW4Zsx+wZ0elvGWeZoK4CO5
 G/8qaiNj6fg67AQXq/C5clMqC2Xu2N3DDrSC/pL/5FpYclrYdSPZ1J8hEpPSdJE/
 icFUlG8PSJa5Uos4hWehPavOKm6Ci9CvpVSWJjNSjCp7CLriVLoFHQ4Jy4YakryV
 MWHbrzAII013rKy+C9RdM2L1h4LwBRjHtNKmRyKPa0gnIfKqSYRCUNeom6MzI3t5
 nSw+wg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rvew5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:21:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso5328316eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571703; x=1794176503;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cp3eEG1uR9LfG2MoyOCL+bQoZ2d+X/rNrmJkd2KbD0I=;
 b=GomP/XvOZh0cMIM0fPMPWTjcLUgE30bYVa7PBQpx9tAR18UVg2RjyZRlphZHCr/ALj
 jdlpi4FZFr1+y1bEZSqE5PRSsPla7MpD8CAgmq8wNY+VQZWwP6hKpJObWkIFlYBBfJ/U
 0Jg+BS24hcZ9urMhqa94uIsB+4oh0j9We6c+Jo12h2U8yD3u+dBbzS7bDkl/OBF+zB35
 SHC2sY+od0q1/+DyPcTOucyfqpYqxpWo8Ht0LlsR/zV+eEb/2uYMmJr52Iiogk7oj+Nm
 /k84HVnCs+SMtbjj9ZQoQiIp0cveHt1iIa889E1IMbHUqmO2yUwgoQ0Qq6ljLDp5tPol
 rC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571703; x=1794176503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cp3eEG1uR9LfG2MoyOCL+bQoZ2d+X/rNrmJkd2KbD0I=;
 b=d4HYeWihvLCPIHYa/aaLcMXa3wZWxVch67MtJ/z/iNXAGmN1Lq1OzMdgts91G9YphM
 0KiK1/f/gHAaMnzoDdvuqr+VFkZPuuSLi5wu7MyLRDvxtNzSlLgB/vTlqvpMTYRYTKyp
 X7ZdXbS2a9z8aPe0FvTA37W7j04DqwLzZ/aBEsIMNfAiTarwGe96DKdgwQl5vJydQBt9
 dFZp7ERbb53Q+KULWyhXRhP9lrJWyIvwDZPK+Io+LYhMKBP6CzNUQ/QpVzWmsbU33L+n
 J1JDW1RiOhSSEr85hBtm54jk0nDjs6wtqs+EW0Z/l8ya7KvmjI9z7tPdtgkR3JLcLylO
 ohiA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhQK6Ri1jOBsd1TUglk3pUHBSt2eUPOMZCOn/t3am6QN/vl6SXd0QOgp6BC+LgmYYzAIg4bsGI4/I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6vVUY026Sg/U3yeP1yCJDmQF8h4EOsj4mVkkHOX5hmxzDhP/Z
 0wkzB7Lzn5RY4P9tPgJ7qG2cUXL/bUD50F7OuIkgnq59AO3tpAfQvkbxlt6ZskR+t520DZ1wGbd
 uyuFTMXPb1xvv/NmjC9/CZ60IFUuUKyRP3+PWzQIN0a3Zo8FKeDiQiTU6eifkqrPXhZ9iFfk=
X-Gm-Gg: AYBFou08k4c6Gcku4Jpnd41G9TB+E9ftvpoGDN269H0ukiwpOaZ8u2OPV/c/Vns+zsa
 lVhdMk2H1Its3/uUb+NxjPWUwDr8LEDnGGpSZi5r9h09R0+pVOe5qZn3SV8bWGX9yat2aeKeQRw
 H18kx9AeEd9GdLzSou+q3fBNvJEer0f2FL3eWsTXlwnaOprPqvtyFI8zvWW7I/HXpq49RLBTO1Q
 SUenBA9I/r/k31d772yJf99+COj6sGYxsGv14pWjgc+zX/q4JcqnbtGW87m7daY5zwystgCyGTd
 WbDzn70TgToiEryG8TPtNTfOXVdFf0gRfuWIxlJC9k5CJA7pZrRyHnUzPqphkAtoAMY9FP9m55+
 gcoJroYAyKIrbb3EE7uzAQqhAXiD+WbnZjaF5aTzTE+JUPhAlxeLsBctpTpl3f6G9rUVRoveraY
 zYs7QyaQ==
X-Received: by 2002:a05:7022:619b:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-1a9497b9d52mr23433379c88.15.1793571701607; 
 Sun, 01 Nov 2026 14:21:41 -0800 (PST)
X-Received: by 2002:a05:7022:619b:b0:144:eb3f:563a with SMTP id
 a92af1059eb24-1a9497b9d52mr23433298c88.15.1793571700795; 
 Sun, 01 Nov 2026 14:21:40 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:21:40 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:14 +0530
Subject: [PATCH v4 01/25] accel/qda: Add QDA driver documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-1-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=13102;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=jmM3pSIPYEkLouo1xFl+BJbx6wXTrOJiMV1SgH//ji4=;
 b=yZtzolAKc5qfruLbUURpgtdGmlJ+j3pMkKGIgbN0Nd5PWev4RRRHgNo8gSGWzrlvV+MiBKmAk
 PCe6RZ2qoZgBFQlBTELsDZezA9l3GzxdwawCkzNUaQl/Rw1k88S+URs
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: ZqLHwGr0xMUyTmSxnEEEMX0MYIpPsm64
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae7bb77 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=2kRYhx3FWN7WjntzlDQA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX951KF6wddRYq
 dxOmxH9popOYATSfRPziQ0H/4nXxLiNYFz3xE9aEmei1O/o1kc/qa3sPTcpLlfV44F4ovTSHup1
 us6/qwc6+Er0a+ieKmlubVhpE25i+uI=
X-Proofpoint-GUID: ZqLHwGr0xMUyTmSxnEEEMX0MYIpPsm64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXx6LUGE8yCxHa
 gz5BUsux8a6uHbbu8gYMZx75tO9cY7lrzoKUqbDuhN7sjjnTW+qdOXQarX6qFbRpAUaoWYuVNvX
 1JM1YVJyBCRU+hmOgLjsIUfYVKg4RTQXI3aw6DstlW3G7g4KiAvh2SRPvHyP91TpjnYKg34D5tf
 EBNswtG6qbaSCPH7C4t4dhNM3WU+4dlGjMQp8EGb4OS/t04gNRiqiSXrWoxd3Kogxlq7kLyq8lJ
 /7HQgJ1ereYcd3W/3v5A+08kozYt5Hm/fuBGlyQwn/fPyE3ZW5TZZ4uP9UH910vA4Mf6TMaHNWs
 aL2HTWrXOObXE+wlN3h6qIqCtYAx76+fSjX4QVe2ICH75FiQnZ7vmE2z8sWev0zXkqI0RCGWa2c
 ZqkbDxilyH4e4L0/S/z+S0toV8dIeCGTGOZ4BQBerwUM8yOuwEVZaatQdVwI5WguhHGrBShK2ht
 ECkTzlyUbrEQ0mdWCWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The QDA driver is intended to replace drivers/misc/fastrpc.c with a DRM
accel driver. Its design differs from the existing driver in ways that
reviewers need to see before reading the code: buffers are only ever
passed as GEM handles, each open file owns an IOMMU context bank, and
the legacy /dev/fastrpc-* interface is provided by a separate
compatibility module instead of by the core driver.

Add the documentation at the start of the series so that the following
patches can be reviewed against it. It describes the driver as the
series completes it, and so covers ioctls and modules that later
patches add.

The document also points to the open source user space, the FastRPC
library and the QAIC compiler, used to exercise the driver.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 Documentation/accel/index.rst     |   1 +
 Documentation/accel/qda/index.rst |  13 +++
 Documentation/accel/qda/qda.rst   | 222 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                       |   9 ++
 4 files changed, 245 insertions(+)

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
index 000000000000..4d81f6b413ff
--- /dev/null
+++ b/Documentation/accel/qda/qda.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================================
+Qualcomm DSP Accelerator (QDA) Driver
+=====================================
+
+Introduction
+============
+
+The QDA driver is a DRM accel driver for Qualcomm's Hexagon DSPs. It provides
+an interface for offloading workloads such as AI inference, computer vision,
+audio processing and sensor processing to the DSPs on Qualcomm SoCs. It
+speaks the FastRPC protocol to the DSP over RPMsg and uses the DRM GEM and
+PRIME infrastructure for buffer management.
+
+The driver binds to the device-tree nodes described by
+``Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml``.
+
+Relationship to the FastRPC Driver
+==================================
+
+Qualcomm SoCs currently offload DSP work through ``drivers/misc/fastrpc.c``,
+a misc character device driver that predates the DRM accel subsystem. QDA is
+intended to replace it.
+
+To keep existing user space working, the ``qda_fastrpc_shim`` module
+(``CONFIG_DRM_ACCEL_QDA_FASTRPC_SHIM``) registers the same
+``/dev/fastrpc-<dsp>`` (and, where applicable, ``/dev/fastrpc-<dsp>-secure``)
+device nodes and translates the legacy ioctls onto QDA sessions. The shim
+holds only the legacy ABI handling; the protocol, buffer and session logic
+all live in the QDA core.
+
+QDA and ``CONFIG_QCOM_FASTRPC`` bind the same device-tree nodes and create
+the same device nodes, so they are mutually exclusive. Once the shim has
+reached parity with the legacy ABI, ``drivers/misc/fastrpc.c`` is to be
+removed.
+
+The shim keeps the legacy secure and non-secure node model. A DSP domain is
+secure unless its device-tree node has ``qcom,non-secure-domain``. ADSP, MDSP
+and SDSP get a single node, ``/dev/fastrpc-<dsp>`` or
+``/dev/fastrpc-<dsp>-secure`` according to the domain. CDSP and GDSP, which
+support unsigned protection domains, always get both nodes. On a secure
+domain, a client that opened the non-secure node may only create an unsigned
+protection domain, and only on a DSP that supports them. As in the legacy
+driver, access to either node is controlled by the node's file permissions.
+
+Architecture
+============
+
+The QDA driver consists of the following blocks:
+
+1.  **Core driver** (``qda_drv``): device registration, per-open session
+    state and DRM accel integration.
+2.  **Transport** (``qda_rpmsg``): binds to the DSP's RPMsg channel and sends
+    and receives FastRPC messages.
+3.  **SoC data** (``qda_soc``): per-SoC parameters such as the position of
+    the stream ID in a DSP address and the supported DMA address width.
+4.  **Context banks** (``qda_cb``): creates a platform device for each
+    ``qcom,fastrpc-compute-cb`` child node of the DSP's device-tree node,
+    using ``of_platform_device_create()``. Registering the device is what
+    gives it its IOMMU domain, so no driver has to bind to it. They are
+    created before the accel device is registered and destroyed after it is
+    unplugged, so user space can never reach a context bank that does not
+    exist.
+5.  **Memory manager** (``qda_memory_manager``, ``qda_memory_dma``): tracks
+    the context banks and allocates DMA-coherent memory from the one
+    assigned to a session.
+6.  **GEM** (``qda_gem``, ``qda_prime``): GEM buffer objects, mmap and PRIME
+    import.
+7.  **FastRPC core** (``qda_fastrpc``): argument marshalling, invocation
+    contexts and the DSP process management calls.
+8.  **Legacy interface** (``qda_legacy_ops``, ``qda_fastrpc_shim``): the
+    compatibility layer described above.
+
+Memory Management
+=================
+
+Buffers are GEM objects backed by DMA-coherent memory allocated through the
+session's context bank device, so their DMA address is an address in that
+context bank's SMMU address space.
+
+A session is one open file: either an ``/dev/accel/accel*`` file or, with
+the shim, a ``/dev/fastrpc-*`` one. It is assigned one context bank,
+exclusively, on its first buffer allocation or import. If no context bank is
+free, the operation fails with ``-EBUSY``. Context banks are not shared
+between sessions, so one session cannot reach another's buffers through an
+address the DSP accepts.
+
+Buffer arguments to every ioctl are identified by a GEM handle together with
+an offset and a length within that buffer. No ioctl takes a user pointer to
+buffer contents or a DMA-BUF file descriptor. To use a buffer from another
+driver, user space imports its DMA-BUF with ``DRM_IOCTL_PRIME_FD_TO_HANDLE``
+first. Imported buffers must be contiguous in the context bank's address
+space, because the DSP is given a single base address per buffer; other
+imports are rejected.
+
+The DSP manages its own virtual address space. The AP side only maps buffers
+into the SMMU context bank through the DMA API, so QDA does not use
+``drm_gpuvm``.
+
+User-Space API
+==============
+
+The driver exposes the following ioctls, defined in
+``include/uapi/drm/qda_accel.h``:
+
+``DRM_IOCTL_QDA_QUERY``
+    Query a property of the DSP selected by ``query_type``:
+    ``QDA_QUERY_DSP_NAME`` returns the domain name (for example ``cdsp``),
+    which is how user space picks the right ``/dev/accel/accel*`` node, and
+    ``QDA_QUERY_DSP_CAPABILITIES`` returns the value of the DSP capability
+    selected by ``attribute_id`` (cached per-device after the first
+    successful query).
+
+``DRM_IOCTL_QDA_GEM_CREATE``
+    Allocate a GEM buffer object and return its handle.
+
+``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``
+    Return the offset to pass to ``mmap()`` on the accel file descriptor to
+    map a GEM buffer object. Imported buffers cannot be mapped this way.
+
+``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``
+    Create a user process on the DSP from an ELF image given as a GEM handle.
+    Creating a signed process domain (``attrs`` without
+    ``QDA_INIT_ATTR_UNSIGNED_MODULE``) requires ``CAP_SYS_ADMIN``.
+
+``DRM_IOCTL_QDA_REMOTE_MMAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``
+    Create or remove a persistent mapping of a buffer in the DSP's address
+    space. ``request`` selects between mapping a whole buffer, optionally at
+    a hinted address (``QDA_REQUEST_MMAP``, ``QDA_REQUEST_MUNMAP``), and
+    mapping a region with SMMU attributes (``QDA_REQUEST_MEM_MAP``,
+    ``QDA_REQUEST_MEM_UNMAP``). An unmap must use the same request the
+    mapping was made with.
+
+    A mapping does not keep the buffer alive. Its GEM handle has to stay
+    open for as long as the DSP uses the mapping, and must only be closed
+    after the mapping has been removed.
+
+``DRM_IOCTL_QDA_REMOTE_INVOKE``
+    Call a method on the DSP. This is the main execution primitive.
+
+    The scalars value ``sc`` selects the method and describes the arguments:
+    bits 28..24 are the method index, bits 23..16 the number of input
+    buffers, bits 15..8 the number of output buffers, bits 7..4 the number
+    of input handles and bits 3..0 the number of output handles. ``args``
+    points to an array with one entry per argument, in that order, each
+    naming a buffer by GEM handle together with an offset and a length
+    within it.
+
+    The handles must stay open for the duration of the call. Buffers are
+    given to the DSP by their SMMU addresses, so they do not need a prior
+    ``REMOTE_MMAP``; use ``REMOTE_MMAP`` for buffers the DSP keeps using
+    across calls.
+
+``DRM_IOCTL_QDA_REMOTE_SESSION_ATTACH``
+    Attach the session to an existing protection domain instead of creating
+    a user process: ``QDA_ATTACH_ROOT_PD``, ``QDA_ATTACH_AUDIO_PD`` or
+    ``QDA_ATTACH_SENSORS_PD``. Requires ``CAP_SYS_ADMIN``, and fails with
+    ``-EBUSY`` if a process has already been created on the session. The
+    first Audio PD attach on a device additionally hands the DSP the remote
+    heap reserved for it in the device tree; later attaches reuse it.
+
+``DRM_IOCTL_QDA_SET_OPTION``
+    Set a session option. ``QDA_SET_OPTION_POLL_MODE`` switches a dynamic
+    invocation in a user PD between waiting for an interrupt-based reply and
+    polling shared memory for completion, trading CPU cycles for lower
+    round-trip latency. Rejected with ``-EOPNOTSUPP`` on DSPs that do not
+    support polling.
+
+Usage Example
+=============
+
+A typical lifecycle for a user-space application:
+
+1.  **Discovery**: open ``/dev/accel/accel*`` and use
+    ``DRM_IOCTL_QDA_QUERY`` to find the node for the wanted DSP domain.
+2.  **Initialization**: call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` to
+    create a process on the DSP.
+3.  **Memory**: allocate buffers with ``DRM_IOCTL_QDA_GEM_CREATE``, or import
+    DMA-BUFs from other drivers with ``DRM_IOCTL_PRIME_FD_TO_HANDLE``.
+4.  **Execution**: use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to run functions on
+    the DSP.
+5.  **Cleanup**: close the file descriptor. The DSP process is released and
+    the session's buffers and context bank are freed.
+
+DSP Restart
+===========
+
+When the DSP's RPMsg channel goes away, for example because the remote
+processor is stopped or crashes, invocations still waiting for a reply fail
+with ``-EPIPE`` and later ioctls fail with ``-ENODEV``. The DSP comes back
+as a new accel device, possibly with a different minor number, so user space
+has to close the file descriptor and repeat discovery.
+
+Debugging
+=========
+
+The driver's debug messages use the DRM driver debug category. Enable them
+with:
+
+.. code-block:: bash
+
+    echo 0x2 > /sys/module/drm/parameters/debug
+
+or, where ``drm`` is built in, with ``drm.debug=0x2`` on the kernel command
+line.
+
+Testing
+=======
+
+The driver is exercised with the ``fastrpc_test`` utility from the
+open-source FastRPC user-space library, built with the open-source QAIC IDL
+compiler:
+
+* FastRPC library: https://github.com/qualcomm/fastrpc
+* QAIC compiler: https://github.com/qualcomm/QAIC
+
+For example, to run the tests on the CDSP with an unsigned process domain:
+
+.. code-block:: bash
+
+    fastrpc_test -d 3 -U 1 -t linux -a v68
diff --git a/MAINTAINERS b/MAINTAINERS
index aaf2825ac945..6803c60cbc64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22973,6 +22973,15 @@ S:	Supported
 F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 F:	drivers/crypto/qce/
 
+QUALCOMM DSP ACCELERATOR (QDA) DRIVER
+M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
+M:	Srinivas Kandagatla <srini@kernel.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/accel/qda/
+
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org

-- 
2.34.1

