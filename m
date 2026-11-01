Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C177606A33C
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pI48dMOY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UKOchCPx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9384D10E4C6;
	Sun,  1 Nov 2026 22:24:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C669D10E4E9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:24:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK31m1454027
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UKkKGpQfuAsSbYZ0H+ZknwKr8tAezXYRg/MOMWChtDQ=; b=pI48dMOYBrvzwYPt
 NiL8NSUkIAawy3OW1oUuVbKNJy9hF2HCjM6ybrLScyGdFEys22ZXSQ47qn6V0OLL
 27zl2cfVxrpdEaKpsf+psU7iKACxFztn/N3yJv3epMELQg7kFQmGKbYY9ULl7dP8
 mn5XY4d7WsdNV/WE24pCuCOxxYS5OToar4AIxuBuU2hnGmuuNgp+rMBjiyHU+Q5A
 yikdk14vFIqyj1kxCefATsb2vFTOL+R7827cIftgvsqtNOWl3oa9F5TAGZSyip/x
 h2rTynTWSqzYKjf0gq1zuMMvYd8lZ/6XaEAiMAMEEmPmh3mmaHbNWcwBGoTOPWq/
 /xO0aA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfvds7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:24:02 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1663fb7e005so2536496c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571842; x=1794176642;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKkKGpQfuAsSbYZ0H+ZknwKr8tAezXYRg/MOMWChtDQ=;
 b=UKOchCPxpAvJJI18JF8YRj0tU64ZHc5FYxsnEwxVOi8UVXLXbeUcziwFxqb/0H2O7a
 HAG+Ha5M26v4cnfKW9BKZz9XsH75UfwEQ866eRj/yEeBDqj5u1pAgjXVRkNqERGWzMTE
 imuuqQq6c83ofkmXJUXZIaMo7u0NcZLSuvL7u6QDzO7jXC7PKpcvp6F4JCUAGYGlUnwv
 k9O+doubd41K9IziB1IUjAd1BJg0NqjzRgNYHk1YwE5FiK2W3IFpmuUgxlzPy0qZb2bk
 pUBwKbRpoI95f4vzTtxTqhuWOaYiRIR/5loQ5CTpMEK1A8qA2dzoCNaRPct+SHWjsOfW
 lcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571842; x=1794176642;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UKkKGpQfuAsSbYZ0H+ZknwKr8tAezXYRg/MOMWChtDQ=;
 b=k8Oexxof4Y3m3fbLoi9aYWvdW/zf8Bjpb1T4hMPo9YMOmqIvQj87XO6NDRpzjIqniO
 h4jiBbVuUqRLyrtC8AgXo5anOm0b7czdUisXesltc+9eSlBb7AqpVVgLT0CGYDsNdKJG
 17DkprRB0WOD43+Gzi057yiVGPO26TlM/OiKYu9+I8iPS1FlfiFkq+PDGto9KrQSyfP7
 R3PKh/bCZOtuXA1MUjLs08m+R/16R1kcJg6uSqVfTmvE2Zw6aAA1Qm9QC5gJQHof7cpB
 vbm910V6TU/Cbua+VTWLILX0JRwCCD83Cs5AlSvd+CMgtvVp2ahIrB1QzloZX8UXw9Yy
 hSBw==
X-Forwarded-Encrypted: i=1;
 AKwUvByr7vHU3hz9jwT0kZbxU8pYI4FHzUO9t6i3stt80Jd4fpfyRJGzoI2OhOV+dzl/TqgoMPNAeb4t6x4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIeMhLZ2F5uw8Q2OjhHqg6FArbJNX7gy1qAyz9JwTyZ8L98md0
 W7v0ss7gitNsTJCLLiXU1UD2mAJ7ZiGLuQi54L9yyZHYQ93xUyDBEcfRBjXqyHsnsO2qrDcaL1K
 YzHZhMs2AIiK9pYNQMZBNJ4140xQO/t5N4AMjg6hS0xVhRl1F/jDz+j4+Lbu/SGiTqBUhpX8=
X-Gm-Gg: AYBFou35/7tmVPDj3mO4CbJ4P89oIdhbfonIq6xrMNDIAWDP0E0E8DvKVxAAUdZRcrA
 VVlLHIb7ylgK4g268RFqQKI5djVLyTBoV/YGa8E89GvessRnCoid/pKF2PBg2AR765aZnNoDhat
 hKVo6enm7tnEr9cZQUriUxVaPq/9KbZMcgSOJ5ccrOpI2MxaGQ9lz+PdT0PfjRa0lOc2ihlBMOf
 HjwMI/NmDuXIdvWtvbECyf68DR0Xl16VI7iYo0i+I2s1tUDy375mrN74NuVS8YApQ9tA7ReDyAO
 jEe4epWG/NB20RjMG81/NibWBcVdEKsKUf52AGtUA95vGLNRvv+gRirjzHIsOnaqhKWrdawC5ll
 77Vp3AVkLVreO3PYNQmevfKGedHDXScfQGNZN8iHn6MYIKyxSyQWGm6PTdEW23YEhdXJruKbuyf
 8ZoF4X/Q==
X-Received: by 2002:a05:7022:5f02:b0:1a0:e3e2:22a3 with SMTP id
 a92af1059eb24-1ac5e323588mr10959461c88.31.1793571841243; 
 Sun, 01 Nov 2026 14:24:01 -0800 (PST)
X-Received: by 2002:a05:7022:5f02:b0:1a0:e3e2:22a3 with SMTP id
 a92af1059eb24-1ac5e323588mr10959376c88.31.1793571840324; 
 Sun, 01 Nov 2026 14:24:00 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:23:59 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:27 +0530
Subject: [PATCH v4 14/25] accel/qda: Add invocation through the legacy
 FastRPC shim
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-14-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=14703;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=21l63ZVWUFF26+ylulnT7ztx0HSiNTEOlwqfJOHwlr4=;
 b=MHk2ESut0MYi0BIErN+G/x7CEU+0cU1k1dxJECGmJbWRBSGxaZZClI7rokj6OPiHRer5C0k2O
 sA3cNYgB9JKA9Ss9jMFLjzrKnyT/KP1KT4Bl8NEUTJAjlApvU91EqWp
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX/02qYcu9Q7bf
 8IwCUERNrvigFVd9YRzHwL07KBuzw68tsTO95x6wDz0nlh+0upnhpmSqnEhO/7ZkldTL5X1VVmm
 u87pxgJr3wIeDJpCn5cICvImM12+OTo=
X-Proofpoint-GUID: k09cAsFZyUCkL5ahVxxH-qM-8EP8GK39
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae7bc02 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=v0r2gR-24sa0sj8xi20A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: k09cAsFZyUCkL5ahVxxH-qM-8EP8GK39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX0em9qZ8yFEAv
 j0xRpcB0z+QTs3mUb53XcEZAesouFTMi6eI32OLVeeRxcvwwZQJDmRXo7j4STqWuLNeEZG8e2jf
 D+gGmOOVa02SLL+esQ5VqgFro7G7KLbyQp/TzKZSISs6ga/cIxyx6PlKbsLJqklK//aTSwk8tkI
 HSkc3a8QRby0j1vn9efMklV34iUKaHI7nmqtKNqJxBwuMmZiopRmXKEPUdqp0pNY+E1p1WF1kwN
 pNu+ziii3uAwWNj/3O+Bu9ryqem6dkXiMMt9trBpqOWpOFoByKtz93aAo9WaDqe472HKOvWhHNx
 In2SpT5IrWoOsjP6AGGFIcbw6931huzo+nT0WOikYFqUD7bj//kwV9n7dbOjN7WnZ8eQeG2HW2E
 ZCO2VU/upNRyZE9AU3mWfZKJkL3WB+EhSXck605YrLpfyyqwGNX57q4heEzMJEbr61+0/fTWLQo
 aMLFHxlJZZJ2jimXBBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
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

Let applications written for the /dev/fastrpc-* interface run methods
on the DSP, by converting their arguments into what the invocation code
takes and handing them over.

A legacy argument is a user pointer, a length and a file descriptor for
the buffer it lives in. The shim imports each descriptor into the
session's context bank, so the DSP can reach the buffer, and passes the
resulting objects along with the pointers and lengths. A session the
shim created has no handle table, so these arguments cannot be named by
handle the way the accel interface does; the invocation takes the
already-resolved objects instead. Ownership of each object moves into
the invocation, so the shim drops its references itself only if
importing a later argument fails.

The pointer a legacy caller passes is an address in its own mapping of
the buffer, and the interface predates GEM handles and cannot change, so
the offset into the buffer is recovered from that mapping. Unlike
handle-named arguments, these are not checked against the size of the
buffer they name.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_fastrpc.c      | 151 +++++++++++++++++++++++++++++++++--
 drivers/accel/qda/qda_fastrpc.h      |  19 +++++
 drivers/accel/qda/qda_fastrpc_shim.c |  87 ++++++++++++++++++++
 drivers/accel/qda/qda_legacy_ops.c   |   8 ++
 drivers/accel/qda/qda_legacy_ops.h   |   4 +
 5 files changed, 262 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 3a1959e2c53e..693dd6f035d2 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -55,6 +55,22 @@ static void setup_pages_from_gem_obj(struct qda_gem_obj *qda_gem_obj,
 	pages->size = qda_gem_obj->size;
 }
 
+static int calculate_vma_offset(u64 user_ptr, u64 *offset)
+{
+	struct vm_area_struct *vma;
+	int ret = -EFAULT;
+
+	mmap_read_lock(current->mm);
+	vma = find_vma(current->mm, user_ptr);
+	if (vma && vma->vm_start <= user_ptr) {
+		*offset = (user_ptr & PAGE_MASK) - vma->vm_start;
+		ret = 0;
+	}
+	mmap_read_unlock(current->mm);
+
+	return ret;
+}
+
 static u64 calculate_page_aligned_size(u64 addr, u64 len)
 {
 	u64 pg_start = (addr & PAGE_MASK) >> PAGE_SHIFT;
@@ -286,23 +302,45 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev)
 }
 
 /*
- * Resolve the address of an in/out buffer argument. The buffer is named by a
- * GEM handle, looked up in the calling session's own handle table, so a
- * session cannot name another's buffer. The offset and length come from user
- * space and are checked against the buffer's real size: a region described as
- * larger than its buffer would let the DSP read and write past the end of it,
- * into whatever else is mapped in the same context bank.
+ * Resolve the address of an in/out buffer argument. The buffer is either a
+ * GEM object the legacy shim already resolved into ctx->gem_objs[i], or a GEM
+ * handle looked up in the calling session's own handle table. For a handle,
+ * the offset and length come from user space and are checked against the
+ * buffer's real size: a region described as larger than its buffer would let
+ * the DSP read and write past the end of it, into whatever else is mapped in
+ * the same context bank.
  */
 static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
 			      union qda_remote_arg *rpra,
 			      struct qda_phy_page *pages)
 {
 	u64 len = ctx->args[i].length;
-	struct qda_gem_obj *qda_gem_obj;
 	struct drm_gem_object *gem_obj;
+	struct qda_gem_obj *qda_gem_obj;
 	u64 unaligned_addr;
+	u64 vma_offset = 0;
 	int err;
 
+	if (ctx->gem_objs[i]) {
+		/*
+		 * The legacy ABI predates GEM handles, so the offset field
+		 * holds an address in the caller's own mapping of the buffer,
+		 * or 0 if it has none, meaning the start of the buffer.
+		 */
+		qda_gem_obj = to_qda_gem_obj(ctx->gem_objs[i]);
+		if (ctx->args[i].offset) {
+			err = calculate_vma_offset(ctx->args[i].offset, &vma_offset);
+			if (err)
+				return err;
+		}
+
+		rpra[i].buf.addr = ctx->args[i].offset;
+		pages[i].addr = qda_gem_obj->dma_addr + vma_offset;
+		pages[i].size = calculate_page_aligned_size(ctx->args[i].offset, len);
+
+		return 0;
+	}
+
 	if (!ctx->args[i].handle)
 		return -EINVAL;
 
@@ -551,6 +589,105 @@ int qda_fastrpc_invoke_common(struct qda_dev *qdev, struct qda_fastrpc_invoke_ct
 	return 0;
 }
 
+/**
+ * qda_fastrpc_invoke_legacy() - Perform a dynamic invocation on behalf of the legacy shim
+ * @qdev: Device to invoke on
+ * @session: Legacy session (no backing drm_file)
+ * @handle: Remote handle to invoke on the DSP
+ * @sc: FastRPC scalars value encoding the number of in/out buffers
+ * @legacy_args: Kernel-side argument array, one entry per QDA_REMOTE_SCALARS_LENGTH(sc)
+ *
+ * Unlike the accel UAPI path, the argument descriptors and any backing GEM
+ * objects already live in kernel memory: the shim has already resolved
+ * every fd-backed argument via its own import path, since a legacy session
+ * has no GEM handle table to resolve a handle-based argument against.
+ * Ownership of each @legacy_args[i].obj reference transfers to this function,
+ * on failure as well as on success.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_fastrpc_invoke_legacy(struct qda_dev *qdev, struct qda_session *session,
+			      u32 handle, u32 sc, struct qda_legacy_invoke_arg *legacy_args)
+{
+	struct qda_fastrpc_invoke_ctx *ctx;
+	struct drm_qda_fastrpc_invoke_args *args;
+	u32 nscalars;
+	int err;
+	int i;
+
+	nscalars = QDA_REMOTE_SCALARS_LENGTH(sc);
+
+	/*
+	 * An fd naming a buffer another session exported resolves to the
+	 * original object, still mapped in that session's context bank, so
+	 * the same check as for a handle applies.
+	 */
+	for (i = 0; i < nscalars; ++i) {
+		if (legacy_args[i].obj &&
+		    to_qda_gem_obj(legacy_args[i].obj)->iommu_dev != session->assigned_iommu_dev) {
+			err = -EACCES;
+			goto err_put_legacy_objs;
+		}
+	}
+
+	ctx = qda_fastrpc_context_alloc(qdev);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		goto err_put_legacy_objs;
+	}
+
+	/* Dropped by qda_fastrpc_context_free(), as for the accel UAPI path */
+	qda_session_get(session);
+	ctx->session = session;
+	ctx->handle = handle;
+	ctx->sc = sc;
+
+	ctx->nbufs = QDA_REMOTE_SCALARS_INBUFS(sc) + QDA_REMOTE_SCALARS_OUTBUFS(sc);
+	if (nscalars) {
+		args = kzalloc_objs(*args, nscalars);
+		if (!args) {
+			err = -ENOMEM;
+			goto err_put_legacy_objs_ctx;
+		}
+
+		ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, nscalars);
+		if (!ctx->gem_objs) {
+			kfree(args);
+			err = -ENOMEM;
+			goto err_put_legacy_objs_ctx;
+		}
+
+		for (i = 0; i < nscalars; ++i) {
+			args[i].offset = legacy_args[i].ptr;
+			args[i].length = legacy_args[i].length;
+			/* process_dma_handle() skips handle args whose handle is 0 */
+			args[i].handle = (i >= ctx->nbufs && legacy_args[i].obj) ?
+					 (u32)legacy_args[i].fd : 0;
+			ctx->gem_objs[i] = legacy_args[i].obj;
+		}
+
+		ctx->args = args;
+	}
+
+	ctx->nscalars = nscalars;
+
+	err = qda_fastrpc_invoke_common(qdev, ctx);
+
+	kref_put(&ctx->refcount, qda_fastrpc_context_free);
+
+	return err;
+
+err_put_legacy_objs_ctx:
+	kref_put(&ctx->refcount, qda_fastrpc_context_free);
+err_put_legacy_objs:
+	/* The context never took the objects, so release them here */
+	for (i = 0; i < nscalars; ++i)
+		if (legacy_args[i].obj)
+			drm_gem_object_put(legacy_args[i].obj);
+
+	return err;
+}
+
 /*
  * INVOKE_DYNAMIC: the argument descriptors are supplied by user space, which
  * is also responsible for having imported every buffer to a GEM handle.
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 61f80c64e6d2..3243bd1065c6 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -198,6 +198,23 @@ struct qda_fastrpc_invoke_ctx {
 	struct work_struct put_work;
 };
 
+/**
+ * struct qda_legacy_invoke_arg - Kernel-side invoke argument for the legacy shim
+ *
+ * Built by the FastRPC compatibility shim from a legacy fastrpc_invoke_args
+ * entry; @obj is NULL for an argument with no backing fd.
+ */
+struct qda_legacy_invoke_arg {
+	/** @ptr: Argument pointer (user virtual address) */
+	u64 ptr;
+	/** @length: Length of the argument data in bytes */
+	u64 length;
+	/** @obj: Pre-resolved GEM object for an fd-backed argument, or NULL */
+	struct drm_gem_object *obj;
+	/** @fd: Legacy fd, forwarded as the DSP-visible handle for handle arguments */
+	s32 fd;
+};
+
 struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
@@ -207,5 +224,7 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
 int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg);
 int qda_fastrpc_invoke_common(struct qda_dev *qdev, struct qda_fastrpc_invoke_ctx *ctx);
 void qda_fastrpc_flush_pending(struct qda_dev *qdev);
+int qda_fastrpc_invoke_legacy(struct qda_dev *qdev, struct qda_session *session,
+			      u32 handle, u32 sc, struct qda_legacy_invoke_arg *legacy_args);
 
 #endif /* __QDA_FASTRPC_H__ */
diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda_fastrpc_shim.c
index 25f5c242efde..03fce990ccdb 100644
--- a/drivers/accel/qda/qda_fastrpc_shim.c
+++ b/drivers/accel/qda/qda_fastrpc_shim.c
@@ -15,8 +15,10 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
 #include <uapi/misc/fastrpc.h>
 #include "qda_drv.h"
+#include "qda_fastrpc.h"
 #include "qda_legacy_ops.h"
 
 /* State of one open /dev/fastrpc-* file */
@@ -50,6 +52,25 @@ struct qda_shim_dev {
 
 static const struct file_operations qda_shim_fops;
 
+/* A negative @fd means the argument has no buffer, which is not an error */
+static struct drm_gem_object *shim_import_fd(struct qda_session *session, s32 fd)
+{
+	struct drm_gem_object *obj;
+	struct dma_buf *dmabuf;
+
+	if (fd < 0)
+		return NULL;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return ERR_CAST(dmabuf);
+
+	obj = qda_legacy_ops_table.import_dmabuf(session, dmabuf);
+	dma_buf_put(dmabuf);
+
+	return obj;
+}
+
 static int qda_shim_open(struct inode *inode, struct file *file)
 {
 	struct qda_shim_node *snode = container_of(file->private_data, struct qda_shim_node,
@@ -120,11 +141,77 @@ static long qda_shim_alloc_dma_buf(struct qda_shim_file *sf, void __user *argp)
 	return 0;
 }
 
+static long qda_shim_invoke(struct qda_shim_file *sf, void __user *argp)
+{
+	struct qda_legacy_invoke_arg *largs;
+	struct fastrpc_invoke_args *uargs;
+	struct fastrpc_invoke args;
+	u32 nargs;
+	int err;
+	int i;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	nargs = QDA_REMOTE_SCALARS_LENGTH(args.sc);
+	if (!nargs)
+		return qda_legacy_ops_table.invoke(sf->session, args.handle, args.sc, NULL);
+
+	uargs = kcalloc(nargs, sizeof(*uargs), GFP_KERNEL);
+	if (!uargs)
+		return -ENOMEM;
+
+	if (copy_from_user(uargs, u64_to_user_ptr(args.args), nargs * sizeof(*uargs))) {
+		kfree(uargs);
+		return -EFAULT;
+	}
+
+	largs = kcalloc(nargs, sizeof(*largs), GFP_KERNEL);
+	if (!largs) {
+		kfree(uargs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nargs; ++i) {
+		struct drm_gem_object *obj;
+
+		largs[i].ptr = uargs[i].ptr;
+		largs[i].length = uargs[i].length;
+		largs[i].fd = uargs[i].fd;
+
+		obj = shim_import_fd(sf->session, uargs[i].fd);
+		if (IS_ERR(obj)) {
+			err = PTR_ERR(obj);
+			goto err_put_objs;
+		}
+		largs[i].obj = obj;
+	}
+
+	kfree(uargs);
+
+	/* Takes ownership of every largs[i].obj, whether or not it succeeds */
+	err = qda_legacy_ops_table.invoke(sf->session, args.handle, args.sc, largs);
+	kfree(largs);
+
+	return err;
+
+err_put_objs:
+	while (i-- > 0)
+		if (largs[i].obj)
+			drm_gem_object_put(largs[i].obj);
+	kfree(largs);
+	kfree(uargs);
+
+	return err;
+}
+
 static long qda_shim_dispatch(struct qda_shim_file *sf, unsigned int cmd, void __user *argp)
 {
 	switch (cmd) {
 	case FASTRPC_IOCTL_ALLOC_DMA_BUFF:
 		return qda_shim_alloc_dma_buf(sf, argp);
+	case FASTRPC_IOCTL_INVOKE:
+		return qda_shim_invoke(sf, argp);
 	default:
 		/*
 		 * Includes FASTRPC_IOCTL_FREE_DMA_BUFF, which the driver this
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index 9639ea84b200..74ee4995350e 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -8,6 +8,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_prime.h>
 #include "qda_drv.h"
+#include "qda_fastrpc.h"
 #include "qda_gem.h"
 #include "qda_legacy_ops.h"
 #include "qda_prime.h"
@@ -71,10 +72,17 @@ static struct drm_gem_object *legacy_import_dmabuf(struct qda_session *session,
 	return qda_prime_import_dmabuf(&session->qda_dev->drm_dev, session, dmabuf);
 }
 
+static int legacy_invoke(struct qda_session *session, u32 handle, u32 sc,
+			 struct qda_legacy_invoke_arg *args)
+{
+	return qda_fastrpc_invoke_legacy(session->qda_dev, session, handle, sc, args);
+}
+
 const struct qda_legacy_ops qda_legacy_ops_table = {
 	.session_create = legacy_session_create,
 	.session_destroy = legacy_session_destroy,
 	.alloc_dmabuf = legacy_alloc_dmabuf,
 	.import_dmabuf = legacy_import_dmabuf,
+	.invoke = legacy_invoke,
 };
 EXPORT_SYMBOL_FOR_MODULES(qda_legacy_ops_table, "qda_fastrpc_shim");
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
index 76b80dc87a4b..ba1ce3c0a22b 100644
--- a/drivers/accel/qda/qda_legacy_ops.h
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -11,6 +11,7 @@
 struct dma_buf;
 struct drm_gem_object;
 struct qda_dev;
+struct qda_legacy_invoke_arg;
 struct qda_session;
 
 /**
@@ -34,6 +35,9 @@ struct qda_legacy_ops {
 	/** @import_dmabuf: Map a DMA-BUF into a session's context bank */
 	struct drm_gem_object *(*import_dmabuf)(struct qda_session *session,
 						struct dma_buf *dmabuf);
+	/** @invoke: Run a method on the DSP; takes ownership of each @args[i].obj */
+	int (*invoke)(struct qda_session *session, u32 handle, u32 sc,
+		      struct qda_legacy_invoke_arg *args);
 };
 
 extern const struct qda_legacy_ops qda_legacy_ops_table;

-- 
2.34.1

