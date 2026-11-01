Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898F6075766
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HjI30reg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XX6aFm1X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EA210E4C0;
	Sun,  1 Nov 2026 22:23:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41F010E4C0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:23:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK5or1801381
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BViaA/LZCA2eznDO8jwbtITxviDy3Vi/ja3RZJ8xpeI=; b=HjI30regMSvBmVMj
 gjqUiRDZYw98TuSzIXP4XizTm+wcdACiRb3b4qhPrfKSWTwwdzBYnKUm0stfe4ut
 yTrbyjCm6zD4vkWMAQN/U+6cV7DD1XXjFqRS8kqxlHn1tnFmbIDoolObYF5pTFPW
 XqzHpxfFg31bFDWVTt/Pf6kdXlcymYRmfsjbfXVd0zAf/jdLdLgfWjC2YrD2Rnpb
 bzKz5BqvQMDGf5QgVU6N3yosM3b6Et2KXb17rk+4KWBCtePC+Lj5xCaK4H/syRQu
 A/m9FrS98KBLX1vq8Oxo1+0dGOD7NzRal+kshDNDKN4O1TduEuHZTcDTG9RyJuJv
 00Im+A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8duca31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:23:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so4541603c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571821; x=1794176621;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BViaA/LZCA2eznDO8jwbtITxviDy3Vi/ja3RZJ8xpeI=;
 b=XX6aFm1XrvJSthgtsm/h6FSrPZByyV3mW/IUG4qjFklWaPtNISSlRhWK7NZIblAyQe
 wkOGDOLf+Ocieu0qOInh0BW4W+xxZwX0mfkgXgyqwG7lSe4IlUuQI07FAIg94KQBcZUC
 WoHmylBzM1rPr04RAvq3jTsuZ4uEqRvZenIyWj/PyOc9xGLerZv3yP90qFMwfQsYzTLm
 lMSgp5VhBMdrRXC7SBqpVdOj8605sfwbNUwzkjj+SBP1uJefEkya7nl48hTRj94xAMyA
 qevZYsOy55UzPXTtlqtP+EUDG6FsIJATmUuiqC9G7uEOZrJNOjc+ShsN/k/JYiHa6EW8
 gNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571821; x=1794176621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BViaA/LZCA2eznDO8jwbtITxviDy3Vi/ja3RZJ8xpeI=;
 b=HQ9jPYYsKtbiJF33+sMvRWBNwp68DTgQv4fyijH4l+xs1wCvV0KJ4X44XCQ63g6F+G
 CouH7m3z300rh8/zDRcHduKGhQLOzzlF+OTevOP7CFpTb4WDia8GFpqdk9dc07ZVyG+Z
 XSn0rgYZDaDm/vKpP7JW0e0pXw23XA4FdBjBoG6ktjLjSmls58GOvn/glPGkmpQV9l6H
 cjsMZf5iiXhRFlRw92+Kd2/mjbN/itxDh2zpBNcK4OLDRKZfBoIbnAKDagCmzDskvx0r
 Sc5x+2YOJWH8RGx4dqd4Cq/PxOFmrJWQFfgUxKyyRT1jtniPuFhhm4bvEMrvej7+fMrj
 Bs/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBfsdD2hakGCkWUqXctwR5XFHVSZaxgWjxwhQv7mUUPrKYLaWs6m82eOJZ1YJFy1e2RT0G4gyWDxE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLSr6wwQI3MXAt8bcI9lVrGl0m1V7snkXhTyiO+3EC2pT2C022X
 3P8FmCdcv7RAT41MLmsLZ7TmHwMr3/OkTMuiEjwcF17EOnmGVE5fxsNwDMIe1A3m9wf3BBg3bgu
 I4a4w9jq1mRj0cYNz1DYrAwunp3yfa2miZiFwh+8G6WXTEZ+HMdO8TuclDmPFPDHgB4j1nws=
X-Gm-Gg: AYBFou1A7bKSoS+bmXm5ROOWleaKbkNoq6bnWidnYjTBdxI6GTy1K0V1qs2LbLYdZUL
 UtJvUlub/Dn0DJtREWH34LuYa1HnOrR/6NVI6Q49ePD75YqZfg81lPw0wqlvXuMqKI54tCY6C+m
 g8xLtEqIvjzV5iz2ZDQuUZscbrhsxkc6iJlp8QTAsfsjBDIBJWWXI4i0ALs4S21b8p79rvVKeNS
 WvHHcy9zSpROPw9Ptq5xnnnVAAi7yqvmC9Jc/1Sps9HqR5zWatDeccvv6vYyL54P0S21GzQOnXS
 HQ58ZUi8YEx6ReNHbXdDWOLs/wMWFemJko+SlFdJAbjYbZdHOnHdYeS3eA5mSC63gsO93DohMdL
 8XUg053YNiuSc8WE/rmilwfwxMSTdI1IEPHW1C0x0spGJwPH7Cn+Rg2IBA92B77Izx1IR3x6+wO
 jnQJVb0Q==
X-Received: by 2002:a05:7022:3c81:b0:1a9:f97a:34d with SMTP id
 a92af1059eb24-1ac5bbb4858mr10912746c88.13.1793571820103; 
 Sun, 01 Nov 2026 14:23:40 -0800 (PST)
X-Received: by 2002:a05:7022:3c81:b0:1a9:f97a:34d with SMTP id
 a92af1059eb24-1ac5bbb4858mr10912648c88.13.1793571818934; 
 Sun, 01 Nov 2026 14:23:38 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:23:38 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:25 +0530
Subject: [PATCH v4 12/25] accel/qda: Add invocation argument validation and
 packing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-12-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=32451;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=0PSSBsqHuGlSuhsZ2JE+IhJyS6yIAHvqL5Czu6GnWWk=;
 b=sutq0KirbFn65z21zXzrUohz+M6TXUIyhK1kPwSSncJjloMItXBksxOrlucPE3WiGDK+WSnXT
 dyO9nzft9GmCkrODRmV+GGiINvqDhUSLhb7OsMJUAab3BCU2eBLlH2g
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae7bbed cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1O07AsD1Dv-dcpSskdwA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: hDY38fAnD4FT74uKtgR6jIadWpH09wor
X-Proofpoint-GUID: hDY38fAnD4FT74uKtgR6jIadWpH09wor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX4f+hSLaq9t7q
 RiRxZE1xnx5IjCMV++CrpKeMV9mtG1AvgeU/FGUYyWn9qi0jemhB+N9PpmsUfqwG6VgVWdVYonQ
 c0Vh0y0msf9f/6R5JUcpuIVn9soKgA24HMDfLtsQ3aiR7Maz/RhcUh4B60Pb6n93pXvbqB+ThYC
 aQ/+NKIl3GrSOj0YB310Y62axUn9Dtq/Ptn9U/M9ktLibGSkGrJOD6ZCn5IfXd7MT8yUkouLhp9
 kCZpl7CfjazIukmwUnA3GMWrPmqEZY4IL3+ucaCI7/VshkT1YLz6wx9LYt+yayLM95RFWxPSvW9
 EQA+1y91P+KCr+4x8KuJyYa1XBB9BCm8AIRtybgHR70MWv7wN5B3qLK1Jc8F5/AkjFMSWZbdJAd
 rfMBTEbLCShyPHaWQifRVqpD8wH2ievzF52V5flBD5DE3YaUyq4noE/tEPKecxaT2xaj6ihMoz5
 T4Qfb30GMz82FTTRzEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX/Zp8aGG0sBa8
 M/aPDLfMget4kG0D3nwjd9eeqPbhx2M/Q4ew/XXIFizjDA5mGOag5iZX7nteYdKAm9BFYA9ZILd
 3KgxAhq4smBQDyy7BycUu+acUpILPYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
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

The DSP reads one buffer per invocation describing where every argument
is. Build that buffer from the argument descriptors user space supplies.

A descriptor names a buffer by handle and a region of it by offset and
length. Handles are resolved in the calling session's own table, and the
buffer they name must be mapped in the context bank assigned to that
session. The table alone is not enough: a buffer exported with
DRM_IOCTL_PRIME_HANDLE_TO_FD and imported back on the same device
resolves to the original object, still mapped in the exporting session's
bank, and the DSP derives the bank from the address it is given. Without
the second check one session could read and write in another's address
space.

For a buffer argument the region is also checked against the buffer's
real size. A region described as larger than its buffer would otherwise
let the DSP read and write past the end of it, into whatever else is
mapped in the same context bank.

The DSP is given the exact address of each argument and the page-aligned
region containing it, since it takes the offset within the page from the
low bits of the address.

The payload is cleared before use, so nothing left from a previous
allocation is visible to the DSP, and a write barrier separates filling
it in from telling the DSP about it.

The same buffer carries a list the DSP writes into to say which buffers
it has finished with, so releasing those is added here alongside the
code that decides where the list lives. That memory is writable by the
DSP, so its contents are not trusted: the walk is bounded by the region
sized for it, stops at the first empty entry, and resolves each entry in
the calling session's own handle table, so a bad value can at worst name
a buffer that session already owns. It is only read once a barrier has
made the DSP's writes visible.

Buffers resolved for an invocation are held until it is freed, so an
error part-way through releases what was already resolved.

An invocation keeps a reference on the session that issued it. A caller
that stops waiting for the DSP leaves the invocation behind, because the
DSP still owns the payload buffer, and that buffer was allocated from
the session's context bank. Holding the session keeps the bank assigned
for as long as the DSP may still write into it, and keeps the handle
table around for the list above.

Payload buffers are kept per session rather than freed, and reused by a
later invocation needing one no larger, since allocating and tearing
down a DMA-coherent, IOMMU-mapped buffer for every invocation is wasteful
for a workload that invokes the same handle repeatedly. The number kept
is bounded, so a session cannot pin an unbounded number of buffers, and
the rest are freed with the session.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c        |  49 +++-
 drivers/accel/qda/qda_drv.h        |  23 +-
 drivers/accel/qda/qda_fastrpc.c    | 482 +++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h    | 111 +++++++++
 drivers/accel/qda/qda_legacy_ops.c |   2 +-
 include/uapi/drm/qda_accel.h       |  36 +++
 6 files changed, 695 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index bdfb23c3c0b1..99bd37fca438 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -12,6 +12,7 @@
 #include <drm/qda_accel.h>
 
 #include "qda_drv.h"
+#include "qda_fastrpc.h"
 #include "qda_ioctl.h"
 #include "qda_prime.h"
 
@@ -19,6 +20,8 @@
  * qda_session_alloc() - Create a session on a device
  * @qdev: Device to create the session on
  *
+ * The caller holds the initial reference and drops it with qda_session_put().
+ *
  * Return: The new session, or ERR_PTR on failure
  */
 struct qda_session *qda_session_alloc(struct qda_dev *qdev)
@@ -30,6 +33,14 @@ struct qda_session *qda_session_alloc(struct qda_dev *qdev)
 		return ERR_PTR(-ENOMEM);
 
 	session->qda_dev = qdev;
+	/*
+	 * Wraps after 2^31 sessions on one device, which no real workload
+	 * reaches: a session lasts as long as the file it was opened on.
+	 */
+	session->remote_session_id = atomic_inc_return(&qdev->session_id_seq);
+	INIT_LIST_HEAD(&session->msg_buf_pool);
+	mutex_init(&session->msg_buf_pool_lock);
+	kref_init(&session->ref);
 
 	return session;
 }
@@ -50,22 +61,47 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
 	return 0;
 }
 
-/**
- * qda_session_free() - Release a session and whatever it still holds
- * @session: Session to release
+/*
+ * Runs once the owner and every invocation of the session are gone, so the
+ * context bank is held for as long as the DSP may still write into a buffer
+ * allocated from it.
  */
-void qda_session_free(struct qda_session *session)
+static void qda_session_release(struct kref *ref)
 {
+	struct qda_session *session = container_of(ref, struct qda_session, ref);
+
+	qda_session_msg_buf_pool_destroy(session);
+
 	if (session->assigned_iommu_dev)
 		qda_memory_manager_release_device(session->assigned_iommu_dev);
 
+	mutex_destroy(&session->msg_buf_pool_lock);
 	kfree(session);
 }
-EXPORT_SYMBOL_FOR_MODULES(qda_session_free, "qda_fastrpc_shim");
+
+/**
+ * qda_session_get() - Take a reference on a session
+ * @session: Session to reference
+ */
+void qda_session_get(struct qda_session *session)
+{
+	kref_get(&session->ref);
+}
+EXPORT_SYMBOL_FOR_MODULES(qda_session_get, "qda_fastrpc_shim");
+
+/**
+ * qda_session_put() - Drop a reference on a session
+ * @session: Session to release
+ */
+void qda_session_put(struct qda_session *session)
+{
+	kref_put(&session->ref, qda_session_release);
+}
+EXPORT_SYMBOL_FOR_MODULES(qda_session_put, "qda_fastrpc_shim");
 
 static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
-	qda_session_free(file->driver_priv);
+	qda_session_put(file->driver_priv);
 }
 
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
@@ -102,6 +138,7 @@ struct qda_dev *qda_alloc_device(struct device *dev)
 	mutex_init(&qdev->import_lock);
 	xa_init_flags(&qdev->ctx_xa, XA_FLAGS_ALLOC1);
 	atomic64_set(&qdev->ctx_seq, 0);
+	atomic_set(&qdev->session_id_seq, 0);
 
 	return qdev;
 }
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index b7cbb1667adb..80a8569b311a 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -9,6 +9,7 @@
 #include <linux/atomic.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/device.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
@@ -37,6 +38,10 @@
  * FastRPC compatibility shim, one per open /dev/fastrpc-* file with no DRM
  * file behind it at all. The core is keyed on this rather than on struct
  * drm_file so that it can serve both.
+ *
+ * Reference counted because an invocation outlives the caller that issued it
+ * when the DSP has not answered yet, and keeps using the session it belongs
+ * to after the file it was opened on is closed.
  */
 struct qda_session {
 	/** @qda_dev: Back-pointer to device structure */
@@ -49,6 +54,19 @@ struct qda_session {
 	struct drm_file *file;
 	/** @assigned_iommu_dev: Context bank owned by this session, or NULL */
 	struct qda_iommu_device *assigned_iommu_dev;
+	/** @remote_session_id: Identifies this session to the DSP */
+	int remote_session_id;
+	/**
+	 * @msg_buf_pool: Invoke header buffers this session is done with,
+	 * kept for its later invocations to reuse.
+	 */
+	struct list_head msg_buf_pool;
+	/** @msg_buf_pool_count: Number of entries in @msg_buf_pool */
+	int msg_buf_pool_count;
+	/** @msg_buf_pool_lock: Protects @msg_buf_pool and @msg_buf_pool_count */
+	struct mutex msg_buf_pool_lock;
+	/** @ref: Dropped by the owner of the session and by every invocation */
+	struct kref ref;
 };
 
 /**
@@ -81,6 +99,8 @@ struct qda_dev {
 	struct xarray ctx_xa;
 	/** @ctx_seq: Distinguishes invocations that reuse a context ID */
 	atomic64_t ctx_seq;
+	/** @session_id_seq: Hands out the session IDs the DSP is told */
+	atomic_t session_id_seq;
 	/** @soc_data: Per-SoC DSP integration parameters */
 	const struct qda_soc_data *soc_data;
 	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
@@ -114,6 +134,7 @@ void qda_unregister_device(struct qda_dev *qdev);
 
 /* Sessions, shared with the legacy shim */
 struct qda_session *qda_session_alloc(struct qda_dev *qdev);
-void qda_session_free(struct qda_session *session);
+void qda_session_get(struct qda_session *session);
+void qda_session_put(struct qda_session *session);
 
 #endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index ec37a38e9215..2971f2f9461f 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -1,9 +1,202 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 #include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_print.h>
 #include "qda_drv.h"
 #include "qda_fastrpc.h"
+#include "qda_gem.h"
+
+/*
+ * The caller owns the returned reference and must drop it with
+ * drm_gem_object_put().
+ *
+ * A handle naming a buffer mapped into another session's context bank is
+ * rejected. Looking the handle up in the calling session's table is not
+ * enough on its own: a buffer exported with DRM_IOCTL_PRIME_HANDLE_TO_FD and
+ * imported back on the same device resolves to the original object, still
+ * mapped in the exporting session's bank. The DSP derives the bank from the
+ * address, so forwarding such a buffer would let one session read and write
+ * in another's address space.
+ */
+static int get_gem_obj_from_handle(struct qda_fastrpc_invoke_ctx *ctx, u32 handle,
+				   struct drm_gem_object **gem_obj)
+{
+	struct drm_gem_object *obj;
+
+	if (!ctx->session->file)
+		return -EOPNOTSUPP;
+
+	obj = drm_gem_object_lookup(ctx->session->file, handle);
+	if (!obj)
+		return -ENOENT;
+
+	if (to_qda_gem_obj(obj)->iommu_dev != ctx->session->assigned_iommu_dev) {
+		drm_dbg_driver(&ctx->qdev->drm_dev,
+			       "Buffer %u belongs to another session\n", handle);
+		drm_gem_object_put(obj);
+		return -EACCES;
+	}
+
+	*gem_obj = obj;
+
+	return 0;
+}
+
+static void setup_pages_from_gem_obj(struct qda_gem_obj *qda_gem_obj,
+				     struct qda_phy_page *pages)
+{
+	pages->addr = qda_gem_obj->dma_addr;
+	pages->size = qda_gem_obj->size;
+}
+
+static u64 calculate_page_aligned_size(u64 addr, u64 len)
+{
+	u64 pg_start = (addr & PAGE_MASK) >> PAGE_SHIFT;
+	u64 pg_end = ((addr + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
+
+	return (pg_end - pg_start + 1) * PAGE_SIZE;
+}
+
+/*
+ * Each scalar argument is backed by exactly one contiguous DMA region: native
+ * GEM objects are allocated contiguous and imported ones are rejected at
+ * import time unless they are. So the metadata region needs exactly one
+ * qda_remote_buf, one qda_invoke_buf and one qda_phy_page per scalar; unlike
+ * drivers/misc/fastrpc.c, which supports multi-page buffers and so may need
+ * several qda_phy_page entries per scalar. It ends with the handle list and
+ * the CRC list.
+ */
+static size_t qda_fastrpc_get_meta_size(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	return (sizeof(struct qda_remote_buf) +
+		sizeof(struct qda_invoke_buf) +
+		sizeof(struct qda_phy_page)) * ctx->nscalars +
+		sizeof(u64) * QDA_FASTRPC_MAX_HANDLELIST +
+		sizeof(u32) * QDA_FASTRPC_MAX_CRCLIST;
+}
+
+/**
+ * qda_fastrpc_cleanup_handlelist() - Release DMA handles the DSP no longer needs
+ * @ctx: Invocation context whose response buffer contains the handle list
+ *
+ * The DSP signals handle release by writing GEM handles into the handle list
+ * region of the response buffer. Walk the list and close each handle, which
+ * drops the GEM reference and tears down the IOMMU mapping. This must be called
+ * after dma_rmb() has made the DSP's writes visible.
+ *
+ * The list is memory the DSP writes, so its contents are not trusted: it is
+ * bounded by the region qda_fastrpc_get_meta_size() sized for it, ends at the
+ * first zero entry, and each entry is looked up in the calling session's own
+ * handle table, so a bad value can at worst name a buffer that session
+ * already owns.
+ */
+void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	u64 *handlelist;
+	int i;
+
+	handlelist = (u64 *)(ctx->pages + ctx->nscalars);
+	for (i = 0; i < QDA_FASTRPC_MAX_HANDLELIST; i++) {
+		if (!handlelist[i])
+			break;
+		if (ctx->session->file)
+			drm_gem_handle_delete(ctx->session->file, (u32)handlelist[i]);
+	}
+}
+
+/**
+ * struct qda_msg_buf_pool_entry - One idle invoke header buffer
+ */
+struct qda_msg_buf_pool_entry {
+	/** @node: Linkage in struct qda_session.msg_buf_pool */
+	struct list_head node;
+	/** @gem_obj: The buffer, holding the pool's reference on it */
+	struct drm_gem_object *gem_obj;
+};
+
+/*
+ * Hand out one of the session's idle header buffers, so that a workload
+ * invoking the same handle repeatedly does not allocate and tear down a
+ * DMA-coherent, IOMMU-mapped buffer every time. The smallest buffer that
+ * fits is picked, to keep a large one available for a later invocation that
+ * needs it.
+ *
+ * Returns NULL if the pool has nothing big enough, leaving the caller to
+ * allocate.
+ */
+static struct drm_gem_object *qda_session_msg_buf_get(struct qda_session *session, size_t size)
+{
+	struct qda_msg_buf_pool_entry *entry, *best = NULL;
+	struct drm_gem_object *gem_obj;
+
+	guard(mutex)(&session->msg_buf_pool_lock);
+
+	list_for_each_entry(entry, &session->msg_buf_pool, node) {
+		size_t entry_size = to_qda_gem_obj(entry->gem_obj)->size;
+
+		if (entry_size >= size &&
+		    (!best || entry_size < to_qda_gem_obj(best->gem_obj)->size))
+			best = entry;
+	}
+
+	if (!best)
+		return NULL;
+
+	list_del(&best->node);
+	session->msg_buf_pool_count--;
+	gem_obj = best->gem_obj;
+	kfree(best);
+
+	return gem_obj;
+}
+
+/*
+ * Keep a finished header buffer for the session's later invocations, or
+ * release it if the session has reached its share already, so that a session
+ * cannot pin an unbounded number of buffers.
+ */
+static void qda_session_msg_buf_put(struct qda_session *session, struct drm_gem_object *gem_obj)
+{
+	struct qda_msg_buf_pool_entry *entry = NULL;
+
+	scoped_guard(mutex, &session->msg_buf_pool_lock) {
+		if (session->msg_buf_pool_count < QDA_MSG_BUF_POOL_MAX)
+			entry = kzalloc_obj(*entry);
+
+		if (entry) {
+			entry->gem_obj = gem_obj;
+			list_add(&entry->node, &session->msg_buf_pool);
+			session->msg_buf_pool_count++;
+		}
+	}
+
+	if (!entry)
+		drm_gem_object_put(gem_obj);
+}
+
+/**
+ * qda_session_msg_buf_pool_destroy() - Release a session's pooled buffers
+ * @session: Session being torn down
+ *
+ * Runs with the session's last reference gone, so no invocation can return a
+ * buffer to the pool while it is being emptied.
+ */
+void qda_session_msg_buf_pool_destroy(struct qda_session *session)
+{
+	struct qda_msg_buf_pool_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &session->msg_buf_pool, node) {
+		list_del(&entry->node);
+		drm_gem_object_put(entry->gem_obj);
+		kfree(entry);
+	}
+	session->msg_buf_pool_count = 0;
+}
 
 /**
  * qda_fastrpc_context_free() - Release an invocation
@@ -12,13 +205,33 @@
  * Runs when the last reference goes. The invocation leaves the lookup table
  * here and not earlier, so that its ID cannot be handed to a new invocation
  * while this one can still be found and completed.
+ *
+ * The session is released last, since the buffers released before it were
+ * allocated from its context bank.
  */
 void qda_fastrpc_context_free(struct kref *ref)
 {
 	struct qda_fastrpc_invoke_ctx *ctx =
 		container_of(ref, struct qda_fastrpc_invoke_ctx, refcount);
+	int i;
 
 	xa_erase(&ctx->qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, ctx->ctxid));
+
+	if (ctx->gem_objs) {
+		for (i = 0; i < ctx->nscalars; ++i) {
+			if (ctx->gem_objs[i])
+				drm_gem_object_put(ctx->gem_objs[i]);
+		}
+		kfree(ctx->gem_objs);
+	}
+
+	if (ctx->msg_gem_obj)
+		qda_session_msg_buf_put(ctx->session, &ctx->msg_gem_obj->base);
+
+	if (ctx->session)
+		qda_session_put(ctx->session);
+
+	kfree(ctx->args);
 	kfree(ctx);
 }
 
@@ -70,3 +283,272 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev)
 
 	return ctx;
 }
+
+/*
+ * Resolve the address of an in/out buffer argument. The buffer is named by a
+ * GEM handle, looked up in the calling session's own handle table, so a
+ * session cannot name another's buffer. The offset and length come from user
+ * space and are checked against the buffer's real size: a region described as
+ * larger than its buffer would let the DSP read and write past the end of it,
+ * into whatever else is mapped in the same context bank.
+ */
+static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
+			      union qda_remote_arg *rpra,
+			      struct qda_phy_page *pages)
+{
+	u64 len = ctx->args[i].length;
+	struct qda_gem_obj *qda_gem_obj;
+	struct drm_gem_object *gem_obj;
+	u64 unaligned_addr;
+	int err;
+
+	if (!ctx->args[i].handle)
+		return -EINVAL;
+
+	err = get_gem_obj_from_handle(ctx, ctx->args[i].handle, &gem_obj);
+	if (err)
+		return err;
+
+	qda_gem_obj = to_qda_gem_obj(gem_obj);
+	if (ctx->args[i].offset > qda_gem_obj->size ||
+	    len > qda_gem_obj->size - ctx->args[i].offset) {
+		drm_dbg_driver(&ctx->qdev->drm_dev,
+			       "Argument %d is out of bounds of its buffer\n", i);
+		drm_gem_object_put(gem_obj);
+		return -EINVAL;
+	}
+
+	ctx->gem_objs[i] = gem_obj;
+
+	/*
+	 * The DSP takes the in-page offset from the low bits of buf.addr; the
+	 * IOVA keeps those bits and stays unique per buffer, as the user VA it
+	 * replaces was.
+	 */
+	unaligned_addr = qda_gem_obj->dma_addr + ctx->args[i].offset;
+	rpra[i].buf.addr = unaligned_addr;
+	pages[i].addr = unaligned_addr & PAGE_MASK;
+	pages[i].size = calculate_page_aligned_size(unaligned_addr, len);
+
+	return 0;
+}
+
+/*
+ * Resolve a DMA-handle argument. The kernel needs the physical page
+ * descriptor, while the DSP identifies the buffer by its GEM handle and
+ * resolves that itself.
+ */
+static int process_dma_handle(struct qda_fastrpc_invoke_ctx *ctx, int i,
+			      union qda_remote_arg *rpra,
+			      struct qda_phy_page *pages)
+{
+	struct drm_gem_object *gem_obj;
+	int err;
+
+	if (!ctx->args[i].handle) {
+		rpra[i].buf.addr = ctx->args[i].offset;
+		rpra[i].buf.len = ctx->args[i].length;
+		return 0;
+	}
+
+	if (ctx->gem_objs[i]) {
+		gem_obj = ctx->gem_objs[i];
+	} else {
+		err = get_gem_obj_from_handle(ctx, ctx->args[i].handle, &gem_obj);
+		if (err)
+			return err;
+
+		ctx->gem_objs[i] = gem_obj;
+	}
+
+	setup_pages_from_gem_obj(to_qda_gem_obj(gem_obj), &pages[i]);
+
+	/* The DSP-facing offset and length fields are 32-bit by wire format */
+	rpra[i].dma.handle = ctx->args[i].handle;
+	rpra[i].dma.len = (u32)ctx->args[i].length;
+	rpra[i].dma.offset = (u32)ctx->args[i].offset;
+
+	return 0;
+}
+
+/**
+ * qda_fastrpc_get_header_size() - Compute the FastRPC message header size
+ * @ctx: FastRPC invocation context
+ *
+ * Two sizes come out of this: the buffer is allocated page-aligned, which is
+ * what the caller gets back, while @ctx->pkt_size keeps the unaligned size
+ * the DSP is told about.
+ *
+ * Return: Page-aligned size of the message payload buffer in bytes
+ */
+static size_t qda_fastrpc_get_header_size(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	ctx->pkt_size = ALIGN(qda_fastrpc_get_meta_size(ctx), QDA_FASTRPC_ALIGN);
+
+	return PAGE_ALIGN(ctx->pkt_size);
+}
+
+static int qda_fastrpc_get_args(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg)
+{
+	struct qda_invoke_buf *list;
+	struct qda_phy_page *pages;
+	union qda_remote_arg *rpra;
+	int i, err;
+
+	msg->buf = ctx->msg_gem_obj->virt;
+	msg->phys = ctx->msg_gem_obj->dma_addr;
+	/*
+	 * The payload is handed to the DSP whole, including the regions it
+	 * writes into, so clear it rather than rely on how it was allocated.
+	 */
+	memset(msg->buf, 0, ctx->msg_gem_obj->size);
+
+	/* One descriptor of each kind per argument, in three adjacent arrays */
+	rpra = msg->buf;
+	list = (struct qda_invoke_buf *)&rpra[ctx->nscalars];
+	pages = (struct qda_phy_page *)&list[ctx->nscalars];
+	/* Kept so the handle list, which follows the pages, can be found later */
+	ctx->pages = pages;
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		rpra[i].buf.addr = 0;
+		rpra[i].buf.len = ctx->args[i].length;
+		list[i].num = ctx->args[i].length ? 1 : 0;
+		list[i].pgidx = i;
+
+		if (!ctx->args[i].length)
+			continue;
+
+		err = process_msg_buffer(ctx, i, rpra, pages);
+		if (err)
+			return err;
+	}
+
+	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
+		list[i].num = ctx->args[i].length ? 1 : 0;
+		list[i].pgidx = i;
+
+		err = process_dma_handle(ctx, i, rpra, pages);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * qda_fastrpc_invoke_pack() - Pack an invocation context into a QDA message
+ * @ctx: FastRPC invocation context
+ * @msg: QDA message to fill in
+ *
+ * Allocates the payload buffer the DSP reads, resolves every argument into
+ * it, and fills in the wire message that points at it.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg)
+{
+	struct qda_dev *qdev = ctx->qdev;
+	struct drm_gem_object *gem_obj;
+	size_t hdr_size;
+	int err;
+
+	hdr_size = qda_fastrpc_get_header_size(ctx);
+
+	gem_obj = qda_session_msg_buf_get(ctx->session, hdr_size);
+	if (!gem_obj) {
+		gem_obj = qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr,
+						hdr_size, ctx->session);
+		if (IS_ERR(gem_obj))
+			return PTR_ERR(gem_obj);
+	}
+
+	ctx->msg_gem_obj = to_qda_gem_obj(gem_obj);
+
+	err = qda_fastrpc_get_args(ctx, msg);
+	if (err)
+		return err;
+
+	/* Ensure the payload is visible to the DSP before the doorbell */
+	dma_wmb();
+
+	msg->fastrpc.remote_session_id = ctx->session->remote_session_id;
+	msg->fastrpc.tid = current->pid;
+	msg->fastrpc.ctx = ctx->ctxid | QDA_USER_PD;
+	msg->fastrpc.handle = ctx->handle;
+	msg->fastrpc.sc = ctx->sc;
+	msg->fastrpc.addr = msg->phys;
+	msg->fastrpc.size = roundup(ctx->pkt_size, PAGE_SIZE);
+	msg->fastrpc_ctx = ctx;
+
+	return 0;
+}
+
+/*
+ * INVOKE_DYNAMIC: the argument descriptors are supplied by user space, which
+ * is also responsible for having imported every buffer to a GEM handle.
+ */
+static int qda_fastrpc_prepare_args_invoke(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct drm_qda_invoke_args *invoke_args = argp;
+	struct drm_qda_fastrpc_invoke_args *args;
+	u32 nscalars;
+
+	ctx->handle = invoke_args->handle;
+	ctx->sc = invoke_args->sc;
+
+	nscalars = QDA_REMOTE_SCALARS_LENGTH(ctx->sc);
+	if (!nscalars)
+		return 0;
+
+	args = kzalloc_objs(*args, nscalars);
+	if (!args)
+		return -ENOMEM;
+
+	if (copy_from_user(args, u64_to_user_ptr(invoke_args->args),
+			   nscalars * sizeof(*args))) {
+		kfree(args);
+		return -EFAULT;
+	}
+
+	ctx->args = args;
+
+	return 0;
+}
+
+/**
+ * qda_fastrpc_prepare_args() - Prepare arguments for a FastRPC invocation
+ * @ctx: FastRPC invocation context
+ * @session: Session issuing the invocation
+ * @argp: Kernel-side ioctl argument buffer owned by the DRM core
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
+			     struct qda_session *session, void *argp)
+{
+	int err;
+
+	/*
+	 * Held until the invocation is freed, which may be after the file the
+	 * session was opened on is closed: the DSP owns the payload buffer
+	 * until it answers, and that buffer came from the session.
+	 */
+	qda_session_get(session);
+	ctx->session = session;
+
+	err = qda_fastrpc_prepare_args_invoke(ctx, argp);
+	if (err)
+		return err;
+
+	ctx->nscalars = QDA_REMOTE_SCALARS_LENGTH(ctx->sc);
+	ctx->nbufs = QDA_REMOTE_SCALARS_INBUFS(ctx->sc) + QDA_REMOTE_SCALARS_OUTBUFS(ctx->sc);
+
+	if (ctx->nscalars && !ctx->gem_objs) {
+		ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, ctx->nscalars);
+		if (!ctx->gem_objs)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 170b513533b9..8440efc21b77 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -11,8 +11,38 @@
 #include <linux/kref.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <drm/qda_accel.h>
 
+struct drm_gem_object;
 struct qda_dev;
+struct qda_gem_obj;
+struct qda_session;
+
+/*
+ * FastRPC scalar extraction macros
+ *
+ * These macros extract different fields from the scalar value that describes
+ * the arguments passed in a FastRPC invocation.
+ */
+#define QDA_REMOTE_SCALARS_INBUFS(sc)		(((sc) >> 16) & 0x0ff)
+#define QDA_REMOTE_SCALARS_OUTBUFS(sc)		(((sc) >> 8) & 0x0ff)
+#define QDA_REMOTE_SCALARS_INHANDLES(sc)	(((sc) >> 4) & 0x0f)
+#define QDA_REMOTE_SCALARS_OUTHANDLES(sc)	((sc) & 0x0f)
+#define QDA_REMOTE_SCALARS_LENGTH(sc)		(QDA_REMOTE_SCALARS_INBUFS(sc) +    \
+						 QDA_REMOTE_SCALARS_OUTBUFS(sc) +   \
+						 QDA_REMOTE_SCALARS_INHANDLES(sc) + \
+						 QDA_REMOTE_SCALARS_OUTHANDLES(sc))
+
+/* FastRPC configuration constants */
+#define QDA_FASTRPC_ALIGN		128	/* Alignment the DSP expects of the payload */
+#define QDA_FASTRPC_MAX_HANDLELIST	16	/* Handles the DSP can ask to release */
+#define QDA_FASTRPC_MAX_CRCLIST		64	/* CRC list entries */
+
+/* Protection domain a session's invocations run in */
+#define QDA_USER_PD			1
+
+/* Idle invoke header buffers a session keeps for reuse */
+#define QDA_MSG_BUF_POOL_MAX		8
 
 /*
  * Layout of the context the DSP echoes back in its response:
@@ -29,6 +59,58 @@ struct qda_dev;
 #define QDA_FASTRPC_CTXID_SEQ_MASK	GENMASK_ULL(63, 16)
 #define QDA_FASTRPC_CTXID_MAX		(QDA_FASTRPC_CTXID_MASK >> 8)
 
+/**
+ * struct qda_remote_dmahandle - Remote DMA handle descriptor
+ */
+struct qda_remote_dmahandle {
+	/** @handle: Handle of the buffer */
+	s32 handle;
+	/** @offset: Byte offset within the buffer object */
+	u32 offset;
+	/** @len: Length of the region in bytes */
+	u32 len;
+};
+
+/**
+ * struct qda_remote_buf - Remote buffer descriptor
+ */
+struct qda_remote_buf {
+	/** @addr: Address of the argument as the DSP sees it */
+	u64 addr;
+	/** @len: Length of the buffer in bytes */
+	u64 len;
+};
+
+/**
+ * union qda_remote_arg - Remote argument (buffer or DMA handle)
+ */
+union qda_remote_arg {
+	/** @buf: Buffer descriptor */
+	struct qda_remote_buf buf;
+	/** @dma: DMA handle descriptor */
+	struct qda_remote_dmahandle dma;
+};
+
+/**
+ * struct qda_phy_page - Physical page descriptor
+ */
+struct qda_phy_page {
+	/** @addr: Physical (IOMMU) address of the region */
+	u64 addr;
+	/** @size: Size of the contiguous region in bytes */
+	u64 size;
+};
+
+/**
+ * struct qda_invoke_buf - Invoke buffer descriptor
+ */
+struct qda_invoke_buf {
+	/** @num: Number of contiguous physical regions */
+	u32 num;
+	/** @pgidx: Index into the physical page array */
+	u32 pgidx;
+};
+
 /**
  * struct qda_fastrpc_msg - FastRPC wire message for remote invocations
  *
@@ -62,6 +144,10 @@ struct qda_msg {
 	 * Must be the first member.
 	 */
 	struct qda_fastrpc_msg fastrpc;
+	/** @buf: Kernel virtual address of the payload buffer */
+	void *buf;
+	/** @phys: Physical/DMA address of the payload buffer */
+	u64 phys;
 	/** @fastrpc_ctx: Back-pointer to the owning invocation context */
 	struct qda_fastrpc_invoke_ctx *fastrpc_ctx;
 };
@@ -72,10 +158,30 @@ struct qda_msg {
 struct qda_fastrpc_invoke_ctx {
 	/** @qdev: Device the invocation was issued on */
 	struct qda_dev *qdev;
+	/** @session: Session that initiated this invocation */
+	struct qda_session *session;
 	/** @ctxid: Wire context with the protection domain bits clear */
 	u64 ctxid;
 	/** @retval: Status the DSP reported, or an error if it never answered */
 	int retval;
+	/** @nscalars: Total number of scalar arguments */
+	int nscalars;
+	/** @nbufs: Number of buffer arguments; the rest are handle arguments */
+	int nbufs;
+	/** @handle: Handle of the remote method being invoked */
+	u32 handle;
+	/** @sc: Scalars value encoding in/out buffer counts */
+	u32 sc;
+	/** @pkt_size: Total payload size in bytes */
+	size_t pkt_size;
+	/** @args: Invoke argument descriptors */
+	struct drm_qda_fastrpc_invoke_args *args;
+	/** @gem_objs: Buffer each argument resolved to, held until the end */
+	struct drm_gem_object **gem_objs;
+	/** @msg_gem_obj: GEM object backing the message payload buffer */
+	struct qda_gem_obj *msg_gem_obj;
+	/** @pages: Array of physical page descriptors inside the payload */
+	struct qda_phy_page *pages;
 	/** @work: Completed once the DSP has answered */
 	struct completion work;
 	/**
@@ -94,5 +200,10 @@ struct qda_fastrpc_invoke_ctx {
 
 struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
 void qda_fastrpc_context_free(struct kref *ref);
+void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
+void qda_session_msg_buf_pool_destroy(struct qda_session *session);
+int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
+			     struct qda_session *session, void *argp);
+int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg);
 
 #endif /* __QDA_FASTRPC_H__ */
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index 3566a10c6488..9639ea84b200 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -33,7 +33,7 @@ static void legacy_session_destroy(struct qda_session *session)
 {
 	struct drm_device *drm_dev = &session->qda_dev->drm_dev;
 
-	qda_session_free(session);
+	qda_session_put(session);
 	drm_dev_put(drm_dev);
 }
 
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 8e64480cdd82..6d81f0ef47b6 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -70,6 +70,42 @@ struct drm_qda_gem_mmap_offset {
 	__u32 pad;
 };
 
+/**
+ * struct drm_qda_fastrpc_invoke_args - FastRPC invocation argument descriptor
+ * @offset: Byte offset within the buffer at which the argument starts
+ * @length: Length of the argument data in bytes
+ * @handle: GEM handle of the buffer holding the argument
+ * @attr: Argument attributes and flags
+ *
+ * Describes a single argument of a FastRPC invocation. Every argument lives
+ * in a buffer, named by the handle it was created or imported under, and
+ * @offset and @length must describe a region within that buffer. Userspace
+ * imports any DMA-BUF fd to a GEM handle before passing it here; the driver
+ * never accepts DMA-BUF fds directly.
+ */
+struct drm_qda_fastrpc_invoke_args {
+	__u64 offset;
+	__u64 length;
+	__u32 handle;
+	__u32 attr;
+};
+
+/**
+ * struct drm_qda_invoke_args - Dynamic FastRPC invocation parameters
+ * @handle: Remote handle to invoke on the DSP
+ * @sc: Scalars value encoding the remote method and the argument counts
+ * @args: User-space pointer to an array of struct
+ *        drm_qda_fastrpc_invoke_args entries, one per argument @sc describes
+ *
+ * Runs a method on the DSP. Results are written directly into the argument
+ * buffers, so there is nothing to read back from this structure.
+ */
+struct drm_qda_invoke_args {
+	__u32 handle;
+	__u32 sc;
+	__u64 args;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

