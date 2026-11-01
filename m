Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9560701EB
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A/dbVlrd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KccXVTQl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5FD10E4E9;
	Sun,  1 Nov 2026 22:25:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C108C10E4E9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:25:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK8Gh733010
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mq4v21tGOqTatBGXDzvOKSgKE9+F60z+3Zn0OTugLJk=; b=A/dbVlrdba2bDQDM
 fPBcuSk56UNJcQcm91riAMq0oxpXIGCmFNMFffRFdnw4TQ5067gwH4+2ai3A+Sgv
 HGIJs3LgQZzbaEeq0n4U6HhWMyA5LYAz1WHOm/FA9mUf+lrpLjO7gR6QM4FaoWZJ
 aXUwxF01SgSqOx+V5dRPYQoVAZtiTY0PglN8VmI02x18IEbgw7K+KBQEmzzUPLkg
 TYVa0V2xDUkmI/ASxhDHU6iYOdbpWKbAyfD5IcoKiw/ksAQgN9ltBvQ579mhKR4Y
 PjtMoQeABI/jaRzYTcrGnD5zu7DRwnPhohTvrZ5KAJdPrJD1QBXywDyQFMHJEjss
 3Aa4aw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7v9jf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:25:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2936211eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571917; x=1794176717;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mq4v21tGOqTatBGXDzvOKSgKE9+F60z+3Zn0OTugLJk=;
 b=KccXVTQlyNurTtgPpLE6gBIOoZZe6VR2qHzj53lVi3p6qoXWFHDVz6Uzra8B71XR/m
 9fMUnkytyNLZzIQAWGzUxBOk2Q3b13Rc7Pfyi+J9Nh1/BEwvhe51hQUZNXNcCg5BRVof
 6kcd7f35MoMT/m1RKHkMpfavwaI8ahJBxnSBBYw/MsE6HsSyecuqQ2o/lSxrXS+dEDOF
 L/LR2CjQOMg5Rykylm6n4o2BhmtOmWG5OQ/HrEgh+s0nbGmerTEBNe+Q1Y5SBr+eRtOu
 2gYsAQRAr+LGQcgq3PVBof9nrKxJqEXavHUbA7zQtKhTOJYajvD8AKuh5C31fCAp9OqL
 53XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571917; x=1794176717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mq4v21tGOqTatBGXDzvOKSgKE9+F60z+3Zn0OTugLJk=;
 b=1i7GN4A/EOlpcEzOJpIEP2I+fSFM910GP9m9Nu2h/Jy9OsgXYjVsuQc1GJkMQwZnbG
 0kXNZbaerglIlDZnjDBF0fBFL1/jgOzcxGiBSoiIPKuD7gDU+Lk5U4gToB3ISd6TA3ME
 lCmKMDXfqGVI6TP38xmZkoAdIsTLMD8IQkHBRFO/SmxxMsGbTtzbjv5KRv4m9AOP0JK9
 dYZNtYNPQQqnJ7pb3O7N5S+Ui8O7R1lklQGQESWU7s0iSVCgon9RmSARfhcjixo5HdYj
 MoySaI4Nbo/CELaZa9KauPrwtVkcKCSeYGl8kpQVZ2BFplobii6/O/N5EGgiyR6HaZnS
 gNIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7HAPwGMpJE7O9IZkHN2qScSE4Q4+bsWvyKXMFGJfSclt0NsyP0jke32JfwsIPt0FLw09I9Igm+fo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKo78NUfTumrHMlhQxWRvpYXmYUbz4EqpFno4S2612AGTUTQgjt
 a2bYUn4pH8KQuy2xV9xPsJBoiPzkt7diwUlkWXu4vFZ2JuevemgdF8JFlWJ/WIb1S3WbFRNPmKb
 LC7pGNTCZiq9UDQDHvL9CaIF+/gtVgn5b9G//+mHN5P8L/Ikm2cbt0HsxtjObCUL1jLE3jRo=
X-Gm-Gg: AYBFou1AxwZqnsm9DwurgtCo1LzY817BBSkcwAytIuSCsevWn/Puawr6sEScnJQQSKo
 vuaqJ5N/VdBDQSP9SN3Axc2gyxQ1cELDYTeqz8q9cojsX4k9otY0V30sHU5uwNGEn2D93064ypT
 H/cQLsfCY2kmfYJhsemv9lVlth0XmuHOb8aC3+5/mXBAOjAaXvKghefoCHDBerAI9ym7jI+bltg
 AD2POkrt7sntC4b7ZAv9zE5wB4Hk07vAx+kBoIWELe+EnJbX4G/vQ8pkODSXNiGIEcH9ejf4FEd
 SMJVF3kgzhKseql+SW5zm5Bl4ONePY5FwtVFczMgXP4Pk3pBwUXJXB5pFRJr4oL/HBAQOQJGLje
 VsjPljJ6crnNEHUj73UXFOc+syYTlLr8zvKdzOCTmVoGl01t4nfNjDgcB870fV8Ql5PwMV8Q8ZT
 GPWJPNvw==
X-Received: by 2002:a05:7022:4b:b0:1a3:dbb2:478a with SMTP id
 a92af1059eb24-1ac5c92de5dmr15877888c88.27.1793571916211; 
 Sun, 01 Nov 2026 14:25:16 -0800 (PST)
X-Received: by 2002:a05:7022:4b:b0:1a3:dbb2:478a with SMTP id
 a92af1059eb24-1ac5c92de5dmr15877830c88.27.1793571915511; 
 Sun, 01 Nov 2026 14:25:15 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:15 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:34 +0530
Subject: [PATCH v4 21/25] accel/qda: Add Audio protection domain attach and
 its remote heap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-21-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=16701;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=LgcntdqkBShlO8amls1wIzgARYknBeDNMKLW6fhJTQM=;
 b=bMiFsApKvZAseEa0qgwtOILtZWuZ2LEL69qPJWchDYEmxOve4YWXK4oae6srq+j0LLUzs4qXQ
 D3byeISDbCRCnOKD3jhP6D+rlWTGER4QGdY8Ydd4OtE1xRbYYSb0sO4
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: 6ocA6gG7fX7VPJ_289zNvRnbTtNa7EXE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX1kvi0kRXpPIa
 dG+3VsDSeDycA5iQKhR0d3xCqowrdVTgf7+zIfduBtWEHOv5TmjC9CKS1XIcrECabrzKiPvsOh3
 UQSih1fm4ROD7RXYbd8fV4m37BZzMeo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwn1ZQTKs/c43
 Kl7g8js9hKv39cTFUbFvr1qA3DWrzMwH6jex2nvM0ddI9gzNSJN4akkz87bXCMFM8Ub5RXQ/rAu
 cheu6sqh0nZH9C9ypuxxiWh5r5ny4zcjH3ydDKyF75Sx3huskKA1//0EVYbwu5wZGKt/CKlxxiK
 B0mkXcq1s/w5Tjddh+H2YkTW5/naawo2LvGIl3Pqt9PlVE09J8YLXLiV0+2oAbWohdfYlvutIOe
 +o+8Gw8NxlobnkciOYHXSE5dWiM0iOEt+ptNW2lLAIWkhkM3+moE6G4YfDpvmdDGlRPjjRRji4S
 LvdQSKcyTG0Tx7PQPFB2m+vU8RoBsd83YTIlSupvjDhaOxof8CpHod2SJaKPTkQ0Zf+PYYSteyu
 IoovwlCMnSuEC0w8Dgm9F7JPh8ynnvpiw5azjLbykNfq6iZ8ZwyxvWCdLVc6YBaNuMhm44D9Egz
 gN1r3Vb9uanDqjflA3g==
X-Proofpoint-GUID: 6ocA6gG7fX7VPJ_289zNvRnbTtNa7EXE
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae7bc4d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wuXFcW2BkFgktBl-NxIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ekansh Gupta <ekangupt@qti.qualcomm.com>

Attaching to the Audio PD differs from Root and Sensors PD attach in two
ways: it names a static PD by a string rather than a fixed protection
domain value, and the DSP expects a region of memory reserved for it in
the device tree to be handed over the first time any session attaches
to it.

Parse the "qcom,vmids" property into a VM permission table and the
reserved-memory region into a physical range at probe time, and use
qcom_scm_assign_mem() to grant the DSP's VMs access to that range. Only
the first successful attach on a device sends the region to the DSP;
later attaches, including after a daemon restart, reuse it. The region
is handed back to HLOS when the rpmsg channel goes away.

The region is optional; without it an Audio PD attach fails.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/Kconfig       |  1 +
 drivers/accel/qda/qda_drv.h     | 19 +++++++++
 drivers/accel/qda/qda_fastrpc.c | 54 ++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h | 30 ++++++++++++++
 drivers/accel/qda/qda_ioctl.c   | 72 ++++++++++++++++++++++++++------
 drivers/accel/qda/qda_rpmsg.c   | 92 ++++++++++++++++++++++++++++++++++++++++-
 include/uapi/drm/qda_accel.h    | 15 +++++--
 7 files changed, 267 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
index c440191a54ff..72b5ee6d58ec 100644
--- a/drivers/accel/qda/Kconfig
+++ b/drivers/accel/qda/Kconfig
@@ -9,6 +9,7 @@ config DRM_ACCEL_QDA
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	select AUXILIARY_BUS
+	select QCOM_SCM
 	help
 	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
 	  This driver provides a standardized interface for offloading computational
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 2f98fd83fdda..1d083ea9fdd7 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -9,6 +9,7 @@
 #include <linux/atomic.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/device.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -31,6 +32,9 @@
  */
 #define QDA_LEGACY_AUXDEV_NAME "fastrpc"
 
+/* Upper bound on the "qcom,vmids" DT property */
+#define QDA_MAX_VMIDS	16
+
 /**
  * struct qda_session - One user of a DSP
  *
@@ -118,6 +122,21 @@ struct qda_dev {
 	 * to, or NULL if it could not be created
 	 */
 	struct auxiliary_device *legacy_auxdev;
+	/** @vmperms: VMs the remote heap is shared with, from qcom,vmids */
+	struct qcom_scm_vmperm vmperms[QDA_MAX_VMIDS];
+	/** @vmcount: Number of valid entries in @vmperms */
+	int vmcount;
+	/** @remote_heap_addr: Physical base of the reserved region, or 0 */
+	phys_addr_t remote_heap_addr;
+	/** @remote_heap_size: Size of the reserved region, or 0 */
+	u64 remote_heap_size;
+	/**
+	 * @remote_heap_lock: Held across an Audio PD attach, so the heap is
+	 * handed to the DSP by exactly one of them. Protects @audio_init_mem.
+	 */
+	struct mutex remote_heap_lock;
+	/** @audio_init_mem: True once the DSP has been given the remote heap */
+	bool audio_init_mem;
 };
 
 /**
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 5bf55b7953c8..e9688e3ba404 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -930,6 +930,56 @@ static int qda_fastrpc_prepare_args_init_create(struct qda_fastrpc_invoke_ctx *c
 	return err;
 }
 
+/*
+ * INIT_CREATE_STATIC packed layout:
+ *   [0] inbuf	sizeof(qda_fastrpc_create_static_inbuf)	IN
+ *   [1] name	namelen, including the NUL		IN
+ *   [2] heap	sizeof(qda_phy_page)			IN
+ *
+ * The heap descriptor is always present; its size is zero, and so pageslen,
+ * when the DSP already has the remote heap.
+ */
+static int qda_fastrpc_prepare_args_create_static(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct qda_static_pd_args *sargs = argp;
+	struct qda_fastrpc_create_static_inbuf *inbuf;
+	struct qda_gem_obj *kernel_gem;
+	u8 *gv;
+	int err;
+
+	const size_t off_inbuf = 0;
+	const size_t off_name = off_inbuf + sizeof(*inbuf);
+	const size_t off_heap = ALIGN(off_name + sargs->namelen, sizeof(u64));
+	const size_t total_size = off_heap + sizeof(struct qda_phy_page);
+
+	ctx->sc = QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+	ctx->handle = QDA_FASTRPC_INIT_HANDLE;
+
+	err = alloc_kernel_args(ctx, 3);
+	if (err)
+		return err;
+
+	kernel_gem = alloc_kernel_gem(ctx, total_size);
+	if (IS_ERR(kernel_gem))
+		return PTR_ERR(kernel_gem);
+	gv = kernel_gem->virt;
+
+	inbuf = (struct qda_fastrpc_create_static_inbuf *)(gv + off_inbuf);
+	inbuf->remote_session_id = ctx->session->remote_session_id;
+	inbuf->namelen = sargs->namelen;
+	inbuf->pageslen = sargs->heap.size ? 1 : 0;
+
+	memcpy(gv + off_name, sargs->name, sargs->namelen);
+	memcpy(gv + off_heap, &sargs->heap, sizeof(sargs->heap));
+
+	assign_kernel_gem_arg(ctx, 0, kernel_gem, gv + off_inbuf, sizeof(*inbuf));
+	assign_kernel_gem_arg(ctx, 1, kernel_gem, gv + off_name, sargs->namelen);
+	assign_kernel_gem_arg(ctx, 2, kernel_gem, gv + off_heap, sizeof(struct qda_phy_page));
+	drm_gem_object_put(&kernel_gem->base);
+
+	return 0;
+}
+
 /*
  * Find the buffer a mapping request names and describe it to the DSP. The
  * buffer is held by the context until the request is done, so that closing its
@@ -1223,6 +1273,10 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
 		ctx->pd = QDA_USER_PD;
 		err = qda_fastrpc_prepare_args_init_create(ctx, argp);
 		break;
+	case QDA_FASTRPC_RMID_INIT_CREATE_STATIC:
+		ctx->pd = QDA_USER_PD;
+		err = qda_fastrpc_prepare_args_create_static(ctx, argp);
+		break;
 	case QDA_FASTRPC_RMID_INIT_MMAP:
 		err = qda_fastrpc_prepare_args_map(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 29e1c3946d60..de04cadcaeb0 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -50,6 +50,7 @@ struct qda_session;
 #define QDA_FASTRPC_RMID_INIT_MUNMAP		5
 #define QDA_FASTRPC_RMID_INIT_CREATE		6
 #define QDA_FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define QDA_FASTRPC_RMID_INIT_CREATE_STATIC	8
 #define QDA_FASTRPC_RMID_INIT_MEM_MAP		10
 #define QDA_FASTRPC_RMID_INIT_MEM_UNMAP		11
 #define QDA_FASTRPC_RMID_INVOKE_DYNAMIC		0xFFFFFFFFU
@@ -65,6 +66,9 @@ struct qda_session;
 /* Largest ELF image a process may be created from */
 #define QDA_FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
 
+/* Longest static PD name, including the NUL */
+#define QDA_FASTRPC_INIT_NAMELEN_MAX	128
+
 /* Idle invoke header buffers a session keeps for reuse */
 #define QDA_MSG_BUF_POOL_MAX		8
 
@@ -155,6 +159,20 @@ struct qda_fastrpc_create_process_inbuf {
 	u32 siglen;
 };
 
+/**
+ * struct qda_fastrpc_create_static_inbuf - Input buffer for attaching to a static PD
+ *
+ * Layout the DSP expects; do not reorder.
+ */
+struct qda_fastrpc_create_static_inbuf {
+	/** @remote_session_id: Session the attach belongs to */
+	int remote_session_id;
+	/** @namelen: Length of the static PD name including the NUL */
+	u32 namelen;
+	/** @pageslen: Number of remote heap descriptors that follow the name (0 or 1) */
+	u32 pageslen;
+};
+
 /**
  * struct qda_fastrpc_map_req_msg - Request to map a whole buffer
  *
@@ -379,6 +397,18 @@ struct qda_mem_map_args {
 	struct drm_gem_object *obj;
 };
 
+/**
+ * struct qda_static_pd_args - Kernel-side arguments for attaching to a static PD
+ */
+struct qda_static_pd_args {
+	/** @name: Kernel copy of the NUL-terminated PD name */
+	const char *name;
+	/** @namelen: Length of @name including the NUL */
+	u32 namelen;
+	/** @heap: Remote heap to hand the DSP, or zero size if it already has it */
+	struct qda_phy_page heap;
+};
+
 struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 9b8cccfea1e3..41234fc576a9 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -121,7 +121,8 @@ static int qda_fastrpc_invoke(u32 type, void *data, struct qda_session *session)
 	if (type == QDA_FASTRPC_RMID_INIT_CREATE) {
 		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
 		WRITE_ONCE(session->pd, QDA_USER_PD);
-	} else if (type == QDA_FASTRPC_RMID_INIT_ATTACH) {
+	} else if (type == QDA_FASTRPC_RMID_INIT_ATTACH ||
+		   type == QDA_FASTRPC_RMID_INIT_CREATE_STATIC) {
 		WRITE_ONCE(session->pd, ctx->pd);
 	}
 
@@ -176,6 +177,54 @@ int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session)
 	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_RELEASE, NULL, session);
 }
 
+/*
+ * The Audio PD keeps the remote heap across daemon restarts, so only the first
+ * attach on a device hands it to the DSP. The lock is held across the attach
+ * so that a concurrent one cannot skip the heap while the first is still in
+ * flight, and the flag is set only once the DSP has accepted it.
+ */
+static int qda_attach_audio_pd(struct qda_session *session, struct drm_qda_remote_attach *args)
+{
+	struct qda_dev *qdev = session->qda_dev;
+	struct qda_static_pd_args sargs = {};
+	char *name;
+	int err;
+
+	if (strcmp(qdev->dsp_name, "adsp") || !qdev->remote_heap_size)
+		return -ENODEV;
+
+	if (!args->namelen || args->namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
+		return -EINVAL;
+
+	name = memdup_user(u64_to_user_ptr(args->name), args->namelen);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (name[args->namelen - 1]) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	sargs.name = name;
+	sargs.namelen = args->namelen;
+
+	scoped_guard(mutex, &qdev->remote_heap_lock) {
+		if (!qdev->audio_init_mem) {
+			sargs.heap.addr = qdev->remote_heap_addr;
+			sargs.heap.size = qdev->remote_heap_size;
+		}
+
+		err = qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE_STATIC, &sargs, session);
+		if (!err && sargs.heap.size)
+			qdev->audio_init_mem = true;
+	}
+
+out_free:
+	kfree(name);
+
+	return err;
+}
+
 /**
  * qda_ioctl_attach() - Attach to a DSP-resident protection domain
  * @dev: DRM device structure
@@ -190,24 +239,23 @@ int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_p
 	struct qda_session *session = file_priv->driver_priv;
 	int pd;
 
-	if (args->pad)
-		return -EINVAL;
+	if (READ_ONCE(session->init_mem_gem_obj))
+		return -EBUSY;
 
 	switch (args->pd_type) {
 	case QDA_ATTACH_ROOT_PD:
-		pd = QDA_ROOT_PD;
-		break;
 	case QDA_ATTACH_SENSORS_PD:
-		pd = QDA_SENSORS_PD;
-		break;
+		if (args->name || args->namelen)
+			return -EINVAL;
+
+		pd = args->pd_type == QDA_ATTACH_ROOT_PD ? QDA_ROOT_PD : QDA_SENSORS_PD;
+
+		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
+	case QDA_ATTACH_AUDIO_PD:
+		return qda_attach_audio_pd(session, args);
 	default:
 		return -EINVAL;
 	}
-
-	if (READ_ONCE(session->init_mem_gem_obj))
-		return -EBUSY;
-
-	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
 }
 
 /**
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
index 7e58df3eb2e1..b93e906b5793 100644
--- a/drivers/accel/qda/qda_rpmsg.c
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -4,7 +4,9 @@
 #include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/rpmsg.h>
+#include <linux/string.h>
 #include <linux/wait.h>
 #include <drm/drm_print.h>
 
@@ -145,6 +147,81 @@ static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 	return ret;
 }
 
+static int qda_init_vmperms(struct qda_dev *qdev)
+{
+	u32 vmids[QDA_MAX_VMIDS];
+	int vmcount, i;
+
+	vmcount = of_property_read_variable_u32_array(qdev->dev->of_node, "qcom,vmids",
+						      vmids, 0, QDA_MAX_VMIDS);
+	if (vmcount == -EINVAL || vmcount == -ENODATA)
+		return 0;
+	if (vmcount < 0)
+		return vmcount;
+
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	for (i = 0; i < vmcount; i++) {
+		qdev->vmperms[i].vmid = vmids[i];
+		qdev->vmperms[i].perm = QCOM_SCM_PERM_RWX;
+	}
+	qdev->vmcount = vmcount;
+
+	return 0;
+}
+
+/*
+ * The region is optional: without it an Audio PD attach is refused. It is
+ * recorded only once it has been assigned, so teardown hands back exactly
+ * what was handed over.
+ */
+static int qda_init_remote_heap(struct qda_dev *qdev)
+{
+	u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+	struct resource res;
+	int ret;
+
+	if (strcmp(qdev->dsp_name, "adsp") && strcmp(qdev->dsp_name, "sdsp"))
+		return 0;
+
+	if (of_reserved_mem_region_to_resource(qdev->dev->of_node, 0, &res))
+		return 0;
+
+	if (qdev->vmcount) {
+		ret = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+					  qdev->vmperms, qdev->vmcount);
+		if (ret)
+			return ret;
+	}
+
+	qdev->remote_heap_addr = res.start;
+	qdev->remote_heap_size = resource_size(&res);
+
+	return 0;
+}
+
+static void qda_deinit_remote_heap(struct qda_dev *qdev)
+{
+	struct qcom_scm_vmperm dst_perms = {
+		.vmid = QCOM_SCM_VMID_HLOS,
+		.perm = QCOM_SCM_PERM_RWX,
+	};
+	u64 src_perms = 0;
+	int ret, i;
+
+	if (!qdev->remote_heap_size || !qdev->vmcount)
+		return;
+
+	for (i = 0; i < qdev->vmcount; i++)
+		src_perms |= BIT(qdev->vmperms[i].vmid);
+
+	ret = qcom_scm_assign_mem(qdev->remote_heap_addr, qdev->remote_heap_size,
+				  &src_perms, &dst_perms, 1);
+	if (ret)
+		dev_err(qdev->dev, "Failed to assign remote heap back to HLOS: %d\n", ret);
+}
+
 static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
@@ -163,6 +240,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
 	qda_fastrpc_flush_pending(qdev);
 	qda_cb_unpopulate(qdev);
 	qda_deinit_device(qdev);
+	qda_deinit_remote_heap(qdev);
 }
 
 static int qda_count_cb_nodes(struct device_node *parent_node)
@@ -195,10 +273,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
 		return ret;
 	}
 
-	ret = qda_init_device(qdev, qda_count_cb_nodes(rpdev->dev.of_node));
+	mutex_init(&qdev->remote_heap_lock);
+
+	ret = qda_init_vmperms(qdev);
+	if (ret)
+		return ret;
+
+	ret = qda_init_remote_heap(qdev);
 	if (ret)
 		return ret;
 
+	ret = qda_init_device(qdev, qda_count_cb_nodes(rpdev->dev.of_node));
+	if (ret)
+		goto err_deinit_remote_heap;
+
 	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
 	if (ret)
 		goto err_deinit;
@@ -213,6 +301,8 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
 	qda_cb_unpopulate(qdev);
 err_deinit:
 	qda_deinit_device(qdev);
+err_deinit_remote_heap:
+	qda_deinit_remote_heap(qdev);
 	return ret;
 }
 
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 59ad5b8cc997..7c439058876e 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -210,22 +210,31 @@ struct drm_qda_mem_unmap {
 /* Protection domains for drm_qda_remote_attach.pd_type */
 #define QDA_ATTACH_ROOT_PD	1
 #define QDA_ATTACH_SENSORS_PD	2
+#define QDA_ATTACH_AUDIO_PD	3
 
 /**
  * struct drm_qda_remote_attach - Parameters for attaching to a DSP protection domain
- * @pd_type: QDA_ATTACH_ROOT_PD or QDA_ATTACH_SENSORS_PD
- * @pad: Must be zero
+ * @pd_type: QDA_ATTACH_ROOT_PD, QDA_ATTACH_SENSORS_PD or QDA_ATTACH_AUDIO_PD
+ * @namelen: Length of the name in bytes including the NUL terminator
+ *           (QDA_ATTACH_AUDIO_PD only, otherwise must be zero)
+ * @name: User pointer to the NUL-terminated name of the static PD to attach
+ *        to (QDA_ATTACH_AUDIO_PD only, otherwise must be zero)
  *
  * Binds this file to a protection domain that already exists on the DSP,
  * instead of creating one with DRM_IOCTL_QDA_REMOTE_SESSION_CREATE. Every
  * later request on the file is directed at it. Fails with EBUSY if a process
  * has already been created on the file.
  *
+ * For QDA_ATTACH_AUDIO_PD, the first successful attach on a device also
+ * hands the DSP the remote heap reserved for it in the device tree; later
+ * attaches reuse that heap.
+ *
  * Requires CAP_SYS_ADMIN.
  */
 struct drm_qda_remote_attach {
 	__u32 pd_type;
-	__u32 pad;
+	__u32 namelen;
+	__u64 name;
 };
 
 #if defined(__cplusplus)

-- 
2.34.1

