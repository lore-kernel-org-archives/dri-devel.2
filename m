Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F46070EBA
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NrrMKBal;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tx2KELYh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1788210EABF;
	Sun,  1 Nov 2026 22:25:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACF910EABF
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:25:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK3Va2377075
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UoXewJ+qoJ0mNCjyPNEf85tc/AzzsV0ZZJUTkeHj8tM=; b=NrrMKBal1dXoKXUg
 oRZN1JvOaJIN+P27N48rbuxEk2sQtUihIl1p52km3oQkBNWB3mjh8MRA7RL7vAWu
 56QoK2SXe2qSFGVKo4A2LGEjJuoLtwRgerDb+PoyU0h4wvs+IKk4iGCaKu+K/z4w
 wm7l1yO/iSS8kibYW69+lHnSJrMWuQYx2W0bbDQpkc0FkQzgzpXsVW5hv8SVrSLs
 P2QWlgAyDu5u1BkPVKum7eixtLDecGhabtU86bNTxWhnOM7p6veK/SFpLmz7j6rI
 2PP7nd3ROHlD85tejum/1yVkywNH6eZ2ptB3f80QISi7YpiVLI4JC4lEpH125tXB
 nqodPA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6me9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:25:39 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1663fb7e005so2536872c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571939; x=1794176739;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UoXewJ+qoJ0mNCjyPNEf85tc/AzzsV0ZZJUTkeHj8tM=;
 b=Tx2KELYhT3MUA4a9NhB8iZmkyHlI5D7ww6WeWMYEk/2Nm91WCq8IREmMZ1uy3NORuR
 rGBlgpsoll4Y/1QTE1F/bGANsAjORRZgOG74n/OCYVp9c7vW7GPMNDY8koQEzQ76RLql
 7pZB8uEAqBkz7K4Fs+MeUqwynx/976XwZIE5Tw/ZOErXn0x+7AYXeMcgNWWgjV3jE8TN
 abwtsj7wZm3mu3PFtq0i+abqxfSOLTvO95BTJk6k+/7UYOnIwKx/KdhjI4HdBc8JjeCm
 27gz1K2WKc2qekwzdknUDcPOJ5o83OTzymKNDVrS47kEw7Qn8r8utyaqbm9DQLPsq3r0
 Mkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571939; x=1794176739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UoXewJ+qoJ0mNCjyPNEf85tc/AzzsV0ZZJUTkeHj8tM=;
 b=jltaIluxF2z0FetxdtTK/pjLn4v4zPbKceQT/5KtI7VTliYBOC8q4q+2uE759IVpUj
 LlUzf/TiLb3yH2vsBLfM0pNlGmJgGh+UtpcHKrjmYvg8qevu03yKe5A0JArHHF8IEhoW
 0HQCsAFQ3T/RZbw98aZDC3GW95o7k5kSeU8eqZZsTIqnlhwSY3RljTRRjTLkJ8sxQHEz
 CeiTNEAnTEbGv36wnEnrdnKhDpH8c4TwMs3x0mvIHASaFEHo+/6Xapl6kW1w3WUVWRi3
 WXDGCMTs+ADAgd81+mCwj8+d7/yjR4nNH9NBbVVnDChbzfGYgPUfU0V4SCepP4PseyDI
 O2rA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2xODsFei7Zr29LO33kp1kqT8BeC1FxMmcl9tuOGzQsRXUPnFygjH/LYwwPO0c/XNORzk0yoMInE4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7uTXLUxQ1/4/LcMAcmj8LC/9lA/RJnSwfWWr0KNshcYFpHl42
 OsXTGNFei9Kfi9043nAtN7CcpS0N01P3B3JJL7fcx//kDdW+9LFbgwYOTDmtTpAIyk5CtWeQzl8
 6h/WCrIIpSO8yDaL+V3o5Jh6mfU+MycKlEIihJ4CJDsgE2LzXvgoty8y/XJplJehwbl2/w54=
X-Gm-Gg: AYBFou2bBW+2C2pi4yb+A0oAj133H17j0OYnNOmtPiKm8ED47rZvMgiCy7bwirV/IaD
 LWnd7pkTcjBVRUkMV3g/gI3p4GOzl/n9KNLA4WvP55o0wgcU2nMoTQHdQIHg+jDmQVtTjmUyF+c
 Xdd5vZUuVTjVigRrRz6wqKDg/LbFTcs6c917jnks9X70kgl3ZdP3a4oJwp5aN/4eRLGfMwo7mDA
 OvgkZivjxSKAev7pn2aztx+6GVlPaQaQvJG/AthTqXVaAaC6G2Q6iIztosujIhkx94E24C+TAj0
 czhDFn3foqfPvy+Zft+PC3Dlr29OQ+qsqBi3LBhTVVvwThFfaPQNmzIaCnGItJ8uwFLsdDlA9zX
 2xQLhehZiF125x5LUcstnrnCPYiiyeyieuU57xsH3a+ldnjlj1M8HmAuYlxcvVOuc8wRQX6hr9p
 Ad8Q4mQg==
X-Received: by 2002:a05:7022:f908:b0:14c:d84c:7182 with SMTP id
 a92af1059eb24-1ac5da75597mr11150942c88.22.1793571937920; 
 Sun, 01 Nov 2026 14:25:37 -0800 (PST)
X-Received: by 2002:a05:7022:f908:b0:14c:d84c:7182 with SMTP id
 a92af1059eb24-1ac5da75597mr11150877c88.22.1793571936932; 
 Sun, 01 Nov 2026 14:25:36 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:36 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:36 +0530
Subject: [PATCH v4 23/25] accel/qda: Add DSP capability query
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-23-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=10471;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=4QIZzgQix6cG3ssVtqx+8DJ25upu5rDPc5bsdyYcbs8=;
 b=t7OqUD+ipLOcfM5X1uvFAyDz59PT/R9V8zjulsxcB4GZxcqlEsSzWHmVsHHaS1nDCwZDaYEwa
 4w0jIiHRVg7C/6YpiUXai0F1gpD0RyrPGkldZaBDHUyioaDuTxFaxdA
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: Mzdhyr9ZCJ2wKog20fBK12JbxfhlBx8B
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae7bc63 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zoN6bUAshuLXMwAB7M0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: Mzdhyr9ZCJ2wKog20fBK12JbxfhlBx8B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX0OrUKDerGf/Q
 BnNvxMXu0Dhpi/9/Ol40pNmbNUUcufnxjLsScaj+gSCVikjRd2YCCZevDHH7IS+bz2aFz/EMK0B
 SW8/lIGgN177dgeg/nP3vXkxJPcKbBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwDnLrgwIMkPT
 3hYNmld+r5RSxojTRly5FYTO1iucNfxA6MgJ8Om01iNe9ZQqxecQaKPkfbiEAZb3CPky6fpb+mF
 FDGV410HQF8tVBj1cW4+BvMeZeb1Pbpp2JfM3XgXFiuTnB8Gou1/RL2AeClFTBI72VVDSshawFC
 11C9bWj+igUJQnDgo7D0NJXEP5HLaYn+CN/qrhCdTJp9zmsg8YfSss17XlrpjxwLVi+rWoDJkKp
 LMNu6g+VagDKPiFi8xLvcv2rqWgf95I/MtoD87IgyUxASO7i89Z/dYG8xZlVLJcUdg5Fko4CpT3
 7jMFPSUH5bonLVeB96RGD6aX1TTU9LuSpWqnx3a4xr8cnhOssPjiEIiw5v+UT8+2WJqrdcPBFCl
 dqFfEzvLw8emBsy0pMFkgwpARMa+pZGTVDhrcw0qD2OquSTDV42lp+5zz5hkv7JLQ6CqNd2vHLG
 oPjnm3ZDrrOQ2SdJjuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
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

Add a DRM_IOCTL_QDA_QUERY query type that returns a DSP capability
attribute, such as async support, unsigned PD offload or VTCM size, so
user space can ask the DSP what it supports without a separate ioctl.

The attributes are fetched from the DSP through its stateless utilities
handle, which needs no process context, and cached on the device the
first time any session queries them. Later queries from any session are
served from the cache. A DSP without capability support makes the query
fail with -EOPNOTSUPP.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |  2 ++
 drivers/accel/qda/qda_drv.h     |  9 ++++++++
 drivers/accel/qda/qda_fastrpc.c | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h | 12 +++++++++++
 drivers/accel/qda/qda_ioctl.c   | 42 ++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h   |  2 ++
 include/uapi/drm/qda_accel.h    | 15 +++++++++++--
 7 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 1e72dce769b9..51d8ef10c6c1 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -154,6 +154,7 @@ struct qda_dev *qda_alloc_device(struct device *dev)
 
 	INIT_LIST_HEAD(&qdev->cb_devs);
 	mutex_init(&qdev->import_lock);
+	mutex_init(&qdev->attr_lock);
 	xa_init_flags(&qdev->ctx_xa, XA_FLAGS_ALLOC1);
 	atomic64_set(&qdev->ctx_seq, 0);
 	atomic_set(&qdev->session_id_seq, 0);
@@ -181,6 +182,7 @@ void qda_deinit_device(struct qda_dev *qdev)
 	qda_memory_manager_exit(qdev->iommu_mgr);
 	xa_destroy(&qdev->ctx_xa);
 	mutex_destroy(&qdev->import_lock);
+	mutex_destroy(&qdev->attr_lock);
 }
 
 int qda_register_device(struct qda_dev *qdev)
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 1d083ea9fdd7..cbb580d03e0b 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -35,6 +35,9 @@
 /* Upper bound on the "qcom,vmids" DT property */
 #define QDA_MAX_VMIDS	16
 
+/* Size of the cached DSP attribute array; index 0 is reserved */
+#define QDA_MAX_DSP_ATTRIBUTES	256
+
 /**
  * struct qda_session - One user of a DSP
  *
@@ -122,6 +125,12 @@ struct qda_dev {
 	 * to, or NULL if it could not be created
 	 */
 	struct auxiliary_device *legacy_auxdev;
+	/** @attr_lock: Serialises the DSP capability query and protects the cache below */
+	struct mutex attr_lock;
+	/** @valid_attributes: True once @dsp_attributes has been queried from the DSP */
+	bool valid_attributes;
+	/** @dsp_attributes: Cached DSP capability attributes */
+	u32 dsp_attributes[QDA_MAX_DSP_ATTRIBUTES];
 	/** @vmperms: VMs the remote heap is shared with, from qcom,vmids */
 	struct qcom_scm_vmperm vmperms[QDA_MAX_VMIDS];
 	/** @vmcount: Number of valid entries in @vmperms */
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index e9688e3ba404..6044cfad53e9 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -638,6 +638,13 @@ void qda_fastrpc_return_result(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 	int idx;
 
 	switch (ctx->type) {
+	case QDA_FASTRPC_TYPE_GET_DSP_INFO:
+		/* @argp is the attribute array; entry 0 is reserved */
+		((u32 *)argp)[0] = 0;
+		memcpy((u32 *)argp + 1,
+		       (u8 *)to_qda_gem_obj(ctx->gem_objs[1])->virt + ctx->args[1].offset,
+		       ctx->args[1].length);
+		return;
 	case QDA_FASTRPC_RMID_INIT_MMAP:
 		idx = 2;
 		break;
@@ -980,6 +987,43 @@ static int qda_fastrpc_prepare_args_create_static(struct qda_fastrpc_invoke_ctx
 	return 0;
 }
 
+/*
+ * DSP capability query packed layout:
+ *   [0] count	sizeof(u32), the capacity of the array below	IN
+ *   [1] attrs	(QDA_MAX_DSP_ATTRIBUTES - 1) * sizeof(u32)	OUT
+ *
+ * Index 0 of the cached array is reserved, so only the rest is exchanged.
+ */
+static int qda_fastrpc_prepare_args_get_dsp_info(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	const u32 attr_count = QDA_MAX_DSP_ATTRIBUTES - 1;
+	struct qda_gem_obj *kernel_gem;
+	int err;
+
+	const size_t off_attrs = sizeof(u32);
+	const size_t total_size = off_attrs + attr_count * sizeof(u32);
+
+	ctx->sc = QDA_FASTRPC_SCALARS(0, 1, 1);
+	ctx->handle = QDA_FASTRPC_DSP_UTILITIES_HANDLE;
+
+	err = alloc_kernel_args(ctx, 2);
+	if (err)
+		return err;
+
+	kernel_gem = alloc_kernel_gem(ctx, total_size);
+	if (IS_ERR(kernel_gem))
+		return PTR_ERR(kernel_gem);
+
+	*(u32 *)kernel_gem->virt = attr_count;
+
+	assign_kernel_gem_arg(ctx, 0, kernel_gem, kernel_gem->virt, sizeof(u32));
+	assign_kernel_gem_arg(ctx, 1, kernel_gem, (u8 *)kernel_gem->virt + off_attrs,
+			      attr_count * sizeof(u32));
+	drm_gem_object_put(&kernel_gem->base);
+
+	return 0;
+}
+
 /*
  * Find the buffer a mapping request names and describe it to the DSP. The
  * buffer is held by the context until the request is done, so that closing its
@@ -1277,6 +1321,9 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
 		ctx->pd = QDA_USER_PD;
 		err = qda_fastrpc_prepare_args_create_static(ctx, argp);
 		break;
+	case QDA_FASTRPC_TYPE_GET_DSP_INFO:
+		err = qda_fastrpc_prepare_args_get_dsp_info(ctx);
+		break;
 	case QDA_FASTRPC_RMID_INIT_MMAP:
 		err = qda_fastrpc_prepare_args_map(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index de04cadcaeb0..7d5cd04943a3 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -55,9 +55,21 @@ struct qda_session;
 #define QDA_FASTRPC_RMID_INIT_MEM_UNMAP		11
 #define QDA_FASTRPC_RMID_INVOKE_DYNAMIC		0xFFFFFFFFU
 
+/*
+ * ctx->type tag for the DSP capability query. Not a wire method ID: the query
+ * is addressed by QDA_FASTRPC_DSP_UTILITIES_HANDLE, method 0.
+ */
+#define QDA_FASTRPC_TYPE_GET_DSP_INFO		0xFFFFFFFEU
+
 /* Handle the initialisation methods are addressed to */
 #define QDA_FASTRPC_INIT_HANDLE		0x1
 
+/* Handle of the DSP's utility calls, which include the capability query */
+#define QDA_FASTRPC_DSP_UTILITIES_HANDLE	0x2
+
+/* Status the DSP returns when it does not support the capability query */
+#define QDA_FASTRPC_DSP_UNSUPPORTED_API		0x80000414U
+
 /* Protection domains a request can be directed at */
 #define QDA_ROOT_PD			0
 #define QDA_USER_PD			1
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index aaf3e5e6b5b1..c784defd0f70 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -27,6 +27,9 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 	case QDA_QUERY_DSP_NAME:
 		strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
 		return 0;
+	case QDA_QUERY_DSP_CAPABILITIES:
+		return qda_get_dsp_capability(qdev, file_priv->driver_priv,
+					      args->cap.attribute_id, &args->cap.capability);
 	default:
 		return -EINVAL;
 	}
@@ -165,6 +168,45 @@ int qda_session_init_create(struct qda_session *session, struct qda_init_create_
 	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE, create, session);
 }
 
+/**
+ * qda_get_dsp_capability() - Read one DSP capability attribute
+ * @qdev: Device whose DSP to query
+ * @session: Session the query is issued on if the cache is still empty
+ * @attribute_id: Attribute to read
+ * @capability: Receives the value of the attribute
+ *
+ * The attributes are fetched from the DSP once per device and served from the
+ * cache afterwards, to every session. The cache is only written by a query
+ * that succeeded.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_get_dsp_capability(struct qda_dev *qdev, struct qda_session *session,
+			   u32 attribute_id, u32 *capability)
+{
+	int err;
+
+	if (attribute_id >= QDA_MAX_DSP_ATTRIBUTES)
+		return -EOVERFLOW;
+
+	guard(mutex)(&qdev->attr_lock);
+
+	if (!qdev->valid_attributes) {
+		err = qda_fastrpc_invoke(QDA_FASTRPC_TYPE_GET_DSP_INFO, qdev->dsp_attributes,
+					 session);
+		if (err == (int)QDA_FASTRPC_DSP_UNSUPPORTED_API)
+			return -EOPNOTSUPP;
+		if (err)
+			return err;
+
+		qdev->valid_attributes = true;
+	}
+
+	*capability = qdev->dsp_attributes[attribute_id];
+
+	return 0;
+}
+
 /**
  * qda_release_dsp_process() - Tear down a session's DSP process
  * @qdev: QDA device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 94adba549989..329f3809c8ce 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -23,6 +23,8 @@ int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_p
 int qda_session_init_create(struct qda_session *session, struct qda_init_create_args *create);
 int qda_session_attach(struct qda_session *session, u32 pd_type, const char __user *name,
 		       u32 namelen);
+int qda_get_dsp_capability(struct qda_dev *qdev, struct qda_session *session,
+			   u32 attribute_id, u32 *capability);
 int qda_session_mem_map(struct qda_session *session, struct qda_mem_map_args *args);
 int qda_session_mem_unmap(struct qda_session *session, struct drm_qda_mem_unmap *unmap);
 
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 7c439058876e..07b943a3c822 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -50,19 +50,30 @@ extern "C" {
 
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME		1
+#define QDA_QUERY_DSP_CAPABILITIES	2
 
 /**
  * struct drm_qda_query - Device information query structure
  * @query_type: Type of query (input)
  * @dsp_name: Null-terminated name of the DSP (returned when query_type is
  *            QDA_QUERY_DSP_NAME)
+ * @cap: DSP capability query (used when query_type is
+ *       QDA_QUERY_DSP_CAPABILITIES): @cap.attribute_id selects the attribute
+ *       (input) and @cap.capability returns its value (output)
  *
  * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
- * based on @query_type.
+ * based on @query_type. @dsp_name and @cap share storage, as only one query
+ * is made per call.
  */
 struct drm_qda_query {
 	__u32 query_type;
-	__u8 dsp_name[16];
+	union {
+		__u8 dsp_name[16];
+		struct {
+			__u32 attribute_id;
+			__u32 capability;
+		} cap;
+	};
 };
 
 /**

-- 
2.34.1

