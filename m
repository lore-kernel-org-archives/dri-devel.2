Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB495606A6D7
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SkalbdHq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PbaI9SO9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CF010EA9E;
	Sun,  1 Nov 2026 22:24:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9755F10E4E9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:24:14 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KKCmM1454417
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SOTNALfY355tG4nzq6xR1w/CITtnkXHjcAE9PFVEmNE=; b=SkalbdHqz06WMnFh
 jfeG12Lh7UXgtrOq6BzLcieXvP5jd06alGJrJKzeMii8xJ2lZWVa7ML19tx8T+r8
 5TOz1mahedI32f9Mlhtyr1Q1XVnuW+7hIFUAwtKOzSl6BydZ5ohCCbj9KSd26zed
 nP5JQ9NRaCA3LX9WyyCPHryDJQBRiUO7JVDQABm5ukUxd/mL0pIIGutO4RZrIKN+
 PknCqliJR/nz/coVuQXmUBUf+PIjGHx+p9w5zNmFaQLDn8uj7i1CJ1qNVt372xpK
 T2aWcAWhR+XWfzSzCSEAcKY5lkQIAnf8SKCuScSkP13vMxxtOzaBZ9qfN+g0L8hG
 DUBswA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfvdsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:24:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso178358c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571852; x=1794176652;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SOTNALfY355tG4nzq6xR1w/CITtnkXHjcAE9PFVEmNE=;
 b=PbaI9SO9CiQqAueUWTmnPkiVYySBkFp0JtFCOoRykFynOMyiMnTOKpHIajDTyWQIbm
 o6zL7eTFl5IxgKrdxL42OtoLZWauGhPjxRFYfULIBEIoYkSoYnSasAWT7wcaMjqxx7AV
 XnkVhovvsCHSm7JhKEwn3x8vfvRpSaKbOBvzBwoKExrRO9IjkiJ7LrURvNCdPBHg1Ly7
 Eht7AAKcuLf/rA8xCXP6PBO5aoyHqmKkLPQflpIrVjc7GjTrrKKzXf6a2ZiEzrFIVvnn
 F3rfIUxRNTSKzTJ0YoQPeKoYgPcWt6dQwVS1F8uT2NUEwmjLqjlEQdhWfJKyzKT8pu74
 8aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571852; x=1794176652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SOTNALfY355tG4nzq6xR1w/CITtnkXHjcAE9PFVEmNE=;
 b=wpxE7X40x9za/4YS8xEN0lzi//Kr7zhkF/oym4a0W0UD/EV+AVdiOP+RmH0wyh8Atl
 LrOGZidnjz2NKeXhiEkVB3TcWieTnefATkyDNfr60UM6tGrm3wVHBng0uKLOiVAkk4JS
 /10+4tOWgchvimQQEg65+uanggGAE5z7g/IwSxSjqxWHbYFAIq+X0oIAbpnfd3VkUwH2
 q3/zjT75JYy4M7ZpoMEnxGkH+fNoQbeZgyWH6yvP/WNlYfkBbPjJJY6OKYggpRuMqmbm
 +LLtcwdAl5P+WP486fJ6uV3SAa4fdL06Ub1Er50kecQt8SVhYCnWU4CsEULT1MsOrRwC
 /muw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJrMeHzC0Rk7k69xuDO1Y/OKZwGuQxpfxAkPEb9+4XFH6+2hHxxLS2SB3Ws+ffsbJWn5Cs6/JLuao=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJQKE15RddjjAb8PiVTSyVNri9AB4TRwoz101X8VTJZEbHwCPrd
 3aCN0cP0bwkPhKgfBjuR3vedNKgeW0O4GHwb4e8Zlk/j0F6X5O2cClpQv72Z4rCDFdZRdahZFxv
 dj5DNSrDbCf7aSwvvyW6usiLIUOPWLlOk9zKWcPbbtUujfPx82wpmnvP1RvskTBrJEtyOfUc=
X-Gm-Gg: AYBFou1v9BQ57D+h40BGn0UxauXrapg4r95WCZgWzdMu2LSVzokfL2mCt8fMHSfIUFE
 UFq4M3ITwBNWSYqh55++awvOtO9WqA4PcXY1C1jL4ss1EA7OZsgQFBwrgjkbmmb6lus4tXwzUZT
 TI/M1blaAtKiv2QaDHLLMvEP9fd+nnEDZsOUrqsHRNzIR5M0MFM1HGiQYkmaxTdhsE+oqY450km
 mnq1kHv4HF8g3gdmSkTmY2Jx3W+XxNS8RtwEzZaZzr538csodOJFChppJtYXsBxeupuFgz34SvZ
 3x6w9QZBmWczEGE90nD0KiGfvM+krHhiFBVBaRKo4gJFh44so5qXkYaFwDfQY6wS58f7nZOt4/D
 M8mGjBwY7puxlA7Wt791nDyWOalGmbM98EhwLAw/id41Tm1CiyNG7XqmfxTl0wr2d4xj4HXMXgW
 8AMs508w==
X-Received: by 2002:a05:701b:271a:b0:14e:4a59:273e with SMTP id
 a92af1059eb24-1ac5d88c670mr11072635c88.9.1793571851892; 
 Sun, 01 Nov 2026 14:24:11 -0800 (PST)
X-Received: by 2002:a05:701b:271a:b0:14e:4a59:273e with SMTP id
 a92af1059eb24-1ac5d88c670mr11072582c88.9.1793571851115; 
 Sun, 01 Nov 2026 14:24:11 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:24:10 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:28 +0530
Subject: [PATCH v4 15/25] accel/qda: Add DSP process creation and release
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-15-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=23702;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=/CXW3NGdmgJhSnM0ZP+SkYFTrK2H61EXqgqaMj2CJHs=;
 b=NeovDB1TAyXMybb9ANm/m1Cg+0QwLyraYorRwcFEIkOt1E5gaxx8djXiqmQYsrbgWqsorBDLY
 uCAyXkXbmiWDFFFpJP4HePiE7kByP1QgIy+1PeNo8De5/cjev8toDp5
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwoyRnIwA7lrt
 NQ/jUC+77fZeYZ1EqU17SV4oCoutfFEi4KfpLNhEGdLPgV1FFO6UO1IknkiaHWMcnBMwIpvApOs
 99eGkDcfRUwc0AykHg58DfIebEDMj5M=
X-Proofpoint-GUID: AvLnGRCbHS6kwyLRwWHOjaSrdhdT4ChL
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae7bc0d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=c8HEKybcYLooNZtmsfcA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: AvLnGRCbHS6kwyLRwWHOjaSrdhdT4ChL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXzKyYalAk2GQ5
 FkKsDeo233jJUb8T/RNNQ3Gs0BUDTmIZeyXQn7gFgkdk/Koxl36y8ciSds2l8KTgM/kDpspmT4l
 W/EDMO5dn4LJhsdYgrdLlQ3w7sYGvwzsIK4vuW9ybbqSWp0Gl9V7pGM/hAfkWZhmdDnlkplgsZH
 4PGCpoMhLUtEYXUOn3hT8+EDb2IoZTt7gdwoZye2Cv0JPpESeMeg9/OQ4aguSiHb4HpcG7buI6X
 tg7booDTs2A6wb30lYhUflExAFwU0EDxcpPgNwMoB0V+dKN9HyPl3CGxjohz6uu7tVKhF7x/BeX
 Nauj4nZbPjX1Pusq+Bd5jhQDlprzO5TO/V8PpJ4ePIA1Vf+cgxEPmkZeTv8ijKeXFvSkTEfwqB7
 N58olCEU1WLvNtd0x2O5zOIIzcaJjKZLcBBQvEptwRiMyjYcjKcN+l07t59twADDN6yxR0y0Ywq
 A+zqU8Q38KJu5ni3t7A==
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

An application needs a process on the DSP to run its own code, and
that process has to be torn down when the application goes away. Add
the requests that create and release one, and the ioctl that creates
it.

Creating a process hands the DSP an ELF image, which the caller names
by buffer handle, together with a block of memory the DSP loads the
image into. That memory is allocated per session and kept until the
process is released, since the DSP uses it for as long as the process
runs. A process created again on the same session replaces the first,
so the memory held for the previous one is dropped first.

A signed process runs with the DSP's trust in the signature, so
creating one requires CAP_SYS_ADMIN; only an unsigned process may be
created without it.

Releasing is sent when a session closes, if the device is still there
to receive it. Once the DSP has torn the process down, the memory held
for it is freed.

Every request after a successful create is directed at the new
protection domain, so the session remembers which one it is in and the
message built for a request carries it. Requests addressed to the
initialisation handle carry session ID 0, since the session has no
process yet to identify.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |  16 +++-
 drivers/accel/qda/qda_drv.h     |  11 +++
 drivers/accel/qda/qda_fastrpc.c | 202 ++++++++++++++++++++++++++++++++++++++--
 drivers/accel/qda/qda_fastrpc.h |  48 +++++++++-
 drivers/accel/qda/qda_ioctl.c   |  59 +++++++++++-
 drivers/accel/qda/qda_ioctl.h   |   1 +
 include/uapi/drm/qda_accel.h    |  28 ++++++
 7 files changed, 354 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 7d44342d3f67..983c6a3dcfb4 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -13,6 +13,7 @@
 
 #include "qda_drv.h"
 #include "qda_fastrpc.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 #include "qda_prime.h"
 
@@ -72,6 +73,9 @@ static void qda_session_release(struct kref *ref)
 
 	qda_session_msg_buf_pool_destroy(session);
 
+	if (session->init_mem_gem_obj)
+		drm_gem_object_put(&session->init_mem_gem_obj->base);
+
 	if (session->assigned_iommu_dev)
 		qda_memory_manager_release_device(session->assigned_iommu_dev);
 
@@ -101,7 +105,16 @@ EXPORT_SYMBOL_FOR_MODULES(qda_session_put, "qda_fastrpc_shim");
 
 static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
-	qda_session_put(file->driver_priv);
+	struct qda_session *session = file->driver_priv;
+	int idx;
+
+	/* Only a session that created a process has one to release */
+	if (READ_ONCE(session->init_mem_gem_obj) && drm_dev_enter(dev, &idx)) {
+		qda_release_dsp_process(session->qda_dev, session);
+		drm_dev_exit(idx);
+	}
+
+	qda_session_put(session);
 }
 
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
@@ -111,6 +124,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_INVOKE, qda_ioctl_invoke, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
 };
 
 static const struct drm_driver qda_drm_driver = {
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 80a8569b311a..2f98fd83fdda 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -56,6 +56,14 @@ struct qda_session {
 	struct qda_iommu_device *assigned_iommu_dev;
 	/** @remote_session_id: Identifies this session to the DSP */
 	int remote_session_id;
+	/** @pd: Protection domain this session's requests are directed at */
+	int pd;
+	/**
+	 * @init_mem_gem_obj: Memory the DSP loaded this session's process
+	 * into, held for as long as the process runs. Swapped with xchg(), as
+	 * ioctls on one file can run concurrently.
+	 */
+	struct qda_gem_obj *init_mem_gem_obj;
 	/**
 	 * @msg_buf_pool: Invoke header buffers this session is done with,
 	 * kept for its later invocations to reuse.
@@ -137,4 +145,7 @@ struct qda_session *qda_session_alloc(struct qda_dev *qdev);
 void qda_session_get(struct qda_session *session);
 void qda_session_put(struct qda_session *session);
 
+/* DSP process management */
+int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session);
+
 #endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 693dd6f035d2..4672405ea4b7 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 #include <linux/bitfield.h>
+#include <linux/capability.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
@@ -245,6 +248,9 @@ void qda_fastrpc_context_free(struct kref *ref)
 	if (ctx->msg_gem_obj)
 		qda_session_msg_buf_put(ctx->session, &ctx->msg_gem_obj->base);
 
+	if (ctx->init_mem_gem_obj)
+		drm_gem_object_put(&ctx->init_mem_gem_obj->base);
+
 	if (ctx->session)
 		qda_session_put(ctx->session);
 
@@ -301,10 +307,54 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev)
 	return ctx;
 }
 
+/*
+ * Allocate one DMA-coherent object to hold every buffer the driver builds for
+ * one of its own requests, so they cost a single page rather than one each.
+ * The memory is cleared, so output slots start out clean.
+ */
+static struct qda_gem_obj *alloc_kernel_gem(struct qda_fastrpc_invoke_ctx *ctx, size_t size)
+{
+	struct qda_dev *qdev = ctx->qdev;
+	struct drm_gem_object *gem_obj;
+
+	gem_obj = qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr, size, ctx->session);
+	if (IS_ERR(gem_obj))
+		return ERR_CAST(gem_obj);
+
+	memset(to_qda_gem_obj(gem_obj)->virt, 0, to_qda_gem_obj(gem_obj)->size);
+
+	return to_qda_gem_obj(gem_obj);
+}
+
+/* The context releases whatever has been allocated here if a later step fails */
+static int alloc_kernel_args(struct qda_fastrpc_invoke_ctx *ctx, u32 nargs)
+{
+	ctx->args = kzalloc_objs(*ctx->args, nargs);
+	if (!ctx->args)
+		return -ENOMEM;
+
+	ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, nargs);
+	if (!ctx->gem_objs)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* Describe the region at @ptr in @kernel_gem as argument @idx, taking a reference on it */
+static void assign_kernel_gem_arg(struct qda_fastrpc_invoke_ctx *ctx, int idx,
+				  struct qda_gem_obj *kernel_gem, void *ptr, size_t len)
+{
+	ctx->args[idx].offset = (u8 *)ptr - (u8 *)kernel_gem->virt;
+	ctx->args[idx].length = len;
+	drm_gem_object_get(&kernel_gem->base);
+	ctx->gem_objs[idx] = &kernel_gem->base;
+}
+
 /*
  * Resolve the address of an in/out buffer argument. The buffer is either a
- * GEM object the legacy shim already resolved into ctx->gem_objs[i], or a GEM
- * handle looked up in the calling session's own handle table. For a handle,
+ * GEM object already resolved into ctx->gem_objs[i], by the legacy shim or by
+ * the driver for its own requests, or a GEM handle looked up in the calling
+ * session's own handle table. For a handle,
  * the offset and length come from user space and are checked against the
  * buffer's real size: a region described as larger than its buffer would let
  * the DSP read and write past the end of it, into whatever else is mapped in
@@ -321,7 +371,7 @@ static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
 	u64 vma_offset = 0;
 	int err;
 
-	if (ctx->gem_objs[i]) {
+	if (ctx->gem_objs[i] && ctx->legacy) {
 		/*
 		 * The legacy ABI predates GEM handles, so the offset field
 		 * holds an address in the caller's own mapping of the buffer,
@@ -341,6 +391,17 @@ static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
 		return 0;
 	}
 
+	if (ctx->gem_objs[i]) {
+		/* Built by the driver, so the offset is a byte offset into the buffer */
+		qda_gem_obj = to_qda_gem_obj(ctx->gem_objs[i]);
+		unaligned_addr = qda_gem_obj->dma_addr + ctx->args[i].offset;
+		rpra[i].buf.addr = unaligned_addr;
+		pages[i].addr = unaligned_addr & PAGE_MASK;
+		pages[i].size = calculate_page_aligned_size(unaligned_addr, len);
+
+		return 0;
+	}
+
 	if (!ctx->args[i].handle)
 		return -EINVAL;
 
@@ -511,9 +572,14 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *
 	/* Ensure the payload is visible to the DSP before the doorbell */
 	dma_wmb();
 
-	msg->fastrpc.remote_session_id = ctx->session->remote_session_id;
+	/* The session has no process yet to identify while one is being created */
+	if (ctx->handle == QDA_FASTRPC_INIT_HANDLE)
+		msg->fastrpc.remote_session_id = 0;
+	else
+		msg->fastrpc.remote_session_id = ctx->session->remote_session_id;
+
 	msg->fastrpc.tid = current->pid;
-	msg->fastrpc.ctx = ctx->ctxid | QDA_USER_PD;
+	msg->fastrpc.ctx = ctx->ctxid | ctx->pd;
 	msg->fastrpc.handle = ctx->handle;
 	msg->fastrpc.sc = ctx->sc;
 	msg->fastrpc.addr = msg->phys;
@@ -639,6 +705,9 @@ int qda_fastrpc_invoke_legacy(struct qda_dev *qdev, struct qda_session *session,
 	/* Dropped by qda_fastrpc_context_free(), as for the accel UAPI path */
 	qda_session_get(session);
 	ctx->session = session;
+	ctx->type = QDA_FASTRPC_RMID_INVOKE_DYNAMIC;
+	ctx->legacy = true;
+	ctx->pd = READ_ONCE(session->pd);
 	ctx->handle = handle;
 	ctx->sc = sc;
 
@@ -688,6 +757,110 @@ int qda_fastrpc_invoke_legacy(struct qda_dev *qdev, struct qda_session *session,
 	return err;
 }
 
+/*
+ * INIT_RELEASE packed layout:
+ *   [0] remote_session_id	sizeof(int)	IN
+ */
+static int qda_fastrpc_prepare_args_release_process(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	struct qda_gem_obj *kernel_gem;
+	int err;
+
+	ctx->sc = QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_RELEASE, 1, 0);
+	ctx->handle = QDA_FASTRPC_INIT_HANDLE;
+
+	err = alloc_kernel_args(ctx, 1);
+	if (err)
+		return err;
+
+	kernel_gem = alloc_kernel_gem(ctx, sizeof(int));
+	if (IS_ERR(kernel_gem))
+		return PTR_ERR(kernel_gem);
+
+	*(int *)kernel_gem->virt = ctx->session->remote_session_id;
+	assign_kernel_gem_arg(ctx, 0, kernel_gem, kernel_gem->virt, sizeof(int));
+	drm_gem_object_put(&kernel_gem->base);
+
+	return 0;
+}
+
+/*
+ * INIT_CREATE / INIT_CREATE_ATTR packed layout:
+ *   [0] inbuf	sizeof(qda_fastrpc_create_process_inbuf)	IN
+ *   [1] comm	TASK_COMM_LEN					IN
+ *   [2] ELF	buffer named by the caller's handle, not packed	IN
+ *   [3] pages	sizeof(qda_phy_page), the process image memory	IN
+ *
+ * The attributes and signature length travel in @inbuf. The _ATTR method is
+ * used when any attribute is set, as in drivers/misc/fastrpc.c.
+ */
+static int qda_fastrpc_prepare_args_init_create(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct drm_qda_init_create *init = argp;
+	struct qda_fastrpc_create_process_inbuf *inbuf;
+	struct qda_dev *qdev = ctx->qdev;
+	struct drm_gem_object *gem_obj;
+	struct qda_gem_obj *kernel_gem;
+	u8 *gv;
+	int err;
+
+	const size_t off_inbuf = 0;
+	const size_t off_comm = off_inbuf + sizeof(*inbuf);
+	const size_t off_pages = off_comm + TASK_COMM_LEN;
+	const size_t total_size = off_pages + sizeof(struct qda_phy_page);
+
+	if (init->file || init->filelen > QDA_FASTRPC_INIT_FILELEN_MAX)
+		return -EINVAL;
+
+	/* A signed process runs with the DSP's trust in the signature */
+	if (!(init->attrs & QDA_INIT_ATTR_UNSIGNED_MODULE) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* The DSP loads the image into this memory and keeps using it while the process runs */
+	gem_obj = qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr,
+					QDA_FASTRPC_INIT_FILELEN_MAX, ctx->session);
+	if (IS_ERR(gem_obj))
+		return PTR_ERR(gem_obj);
+
+	ctx->init_mem_gem_obj = to_qda_gem_obj(gem_obj);
+
+	ctx->sc = init->attrs ? QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0)
+			      : QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_CREATE, 4, 0);
+	ctx->handle = QDA_FASTRPC_INIT_HANDLE;
+
+	err = alloc_kernel_args(ctx, 4);
+	if (err)
+		return err;
+
+	kernel_gem = alloc_kernel_gem(ctx, total_size);
+	if (IS_ERR(kernel_gem))
+		return PTR_ERR(kernel_gem);
+	gv = kernel_gem->virt;
+
+	inbuf = (struct qda_fastrpc_create_process_inbuf *)(gv + off_inbuf);
+	inbuf->remote_session_id = ctx->session->remote_session_id;
+	inbuf->filelen = init->filelen;
+	inbuf->pageslen = 1;
+	inbuf->attrs = init->attrs;
+	inbuf->siglen = init->siglen;
+
+	strscpy(gv + off_comm, current->comm, TASK_COMM_LEN);
+	inbuf->namelen = strlen(gv + off_comm) + 1;
+
+	setup_pages_from_gem_obj(ctx->init_mem_gem_obj, (struct qda_phy_page *)(gv + off_pages));
+
+	assign_kernel_gem_arg(ctx, 0, kernel_gem, inbuf, sizeof(*inbuf));
+	assign_kernel_gem_arg(ctx, 1, kernel_gem, gv + off_comm, inbuf->namelen);
+	/* The image starts at the beginning of the buffer the caller named */
+	ctx->args[2].length = init->filelen;
+	ctx->args[2].handle = init->filehandle;
+	assign_kernel_gem_arg(ctx, 3, kernel_gem, gv + off_pages, sizeof(struct qda_phy_page));
+
+	drm_gem_object_put(&kernel_gem->base);
+
+	return 0;
+}
+
 /*
  * INVOKE_DYNAMIC: the argument descriptors are supplied by user space, which
  * is also responsible for having imported every buffer to a GEM handle.
@@ -740,8 +913,23 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx,
 	 */
 	qda_session_get(session);
 	ctx->session = session;
-
-	err = qda_fastrpc_prepare_args_invoke(ctx, argp);
+	ctx->pd = READ_ONCE(session->pd);
+
+	switch (ctx->type) {
+	case QDA_FASTRPC_RMID_INIT_RELEASE:
+		err = qda_fastrpc_prepare_args_release_process(ctx);
+		break;
+	case QDA_FASTRPC_RMID_INIT_CREATE:
+		/* The new process is in the user PD, and so is the request creating it */
+		ctx->pd = QDA_USER_PD;
+		err = qda_fastrpc_prepare_args_init_create(ctx, argp);
+		break;
+	case QDA_FASTRPC_RMID_INVOKE_DYNAMIC:
+		err = qda_fastrpc_prepare_args_invoke(ctx, argp);
+		break;
+	default:
+		return -EINVAL;
+	}
 	if (err)
 		return err;
 
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 3243bd1065c6..eaebc4e99676 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -33,14 +33,32 @@ struct qda_session;
 						 QDA_REMOTE_SCALARS_INHANDLES(sc) + \
 						 QDA_REMOTE_SCALARS_OUTHANDLES(sc))
 
+/* Encodes a method ID and the in/out buffer counts; handle counts are zero */
+#define QDA_FASTRPC_SCALARS(method, in, out)	((((method) & 0x1f) << 24) | \
+						 (((in) & 0xff) << 16) |     \
+						 (((out) & 0xff) << 8))
+
 /* FastRPC configuration constants */
 #define QDA_FASTRPC_ALIGN		128	/* Alignment the DSP expects of the payload */
 #define QDA_FASTRPC_MAX_HANDLELIST	16	/* Handles the DSP can ask to release */
 #define QDA_FASTRPC_MAX_CRCLIST		64	/* CRC list entries */
 
-/* Protection domain a session's invocations run in */
+/* Methods of the initialisation handle */
+#define QDA_FASTRPC_RMID_INIT_RELEASE		1
+#define QDA_FASTRPC_RMID_INIT_CREATE		6
+#define QDA_FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define QDA_FASTRPC_RMID_INVOKE_DYNAMIC		0xFFFFFFFFU
+
+/* Handle the initialisation methods are addressed to */
+#define QDA_FASTRPC_INIT_HANDLE		0x1
+
+/* Protection domains a request can be directed at */
+#define QDA_ROOT_PD			0
 #define QDA_USER_PD			1
 
+/* Largest ELF image a process may be created from */
+#define QDA_FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
+
 /* Idle invoke header buffers a session keeps for reuse */
 #define QDA_MSG_BUF_POOL_MAX		8
 
@@ -111,6 +129,26 @@ struct qda_invoke_buf {
 	u32 pgidx;
 };
 
+/**
+ * struct qda_fastrpc_create_process_inbuf - Input buffer for process creation
+ *
+ * Layout the DSP expects; do not reorder.
+ */
+struct qda_fastrpc_create_process_inbuf {
+	/** @remote_session_id: Session the process belongs to */
+	int remote_session_id;
+	/** @namelen: Length of the process name including the NUL */
+	u32 namelen;
+	/** @filelen: Length of the ELF image in bytes */
+	u32 filelen;
+	/** @pageslen: Number of physical page descriptors */
+	u32 pageslen;
+	/** @attrs: Process attribute flags */
+	u32 attrs;
+	/** @siglen: Length of the signature data in bytes */
+	u32 siglen;
+};
+
 /**
  * struct qda_fastrpc_msg - FastRPC wire message for remote invocations
  *
@@ -164,6 +202,12 @@ struct qda_fastrpc_invoke_ctx {
 	u64 ctxid;
 	/** @retval: Status the DSP reported, or an error if it never answered */
 	int retval;
+	/** @pd: Protection domain, OR'ed into the low bits of @ctxid when packed */
+	int pd;
+	/** @type: Method being invoked (QDA_FASTRPC_RMID_*) */
+	u32 type;
+	/** @legacy: Arguments came from the legacy shim, where offsets are user VAs */
+	bool legacy;
 	/** @nscalars: Total number of scalar arguments */
 	int nscalars;
 	/** @nbufs: Number of buffer arguments; the rest are handle arguments */
@@ -180,6 +224,8 @@ struct qda_fastrpc_invoke_ctx {
 	struct drm_gem_object **gem_objs;
 	/** @msg_gem_obj: GEM object backing the message payload buffer */
 	struct qda_gem_obj *msg_gem_obj;
+	/** @init_mem_gem_obj: Memory the DSP loads a new process into */
+	struct qda_gem_obj *init_mem_gem_obj;
 	/** @pages: Array of physical page descriptors inside the payload */
 	struct qda_phy_page *pages;
 	/** @work: Completed once the DSP has answered */
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index e9f4151e344a..f51ad0bc9e9c 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -75,7 +75,22 @@ int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_fil
 	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->offset);
 }
 
-static int qda_fastrpc_invoke(void *data, struct qda_session *session)
+/*
+ * A process created again replaces the first, so the memory held for the
+ * previous one is dropped. Swapped atomically, as ioctls on one file can run
+ * concurrently.
+ */
+static void qda_session_set_init_mem(struct qda_session *session, struct qda_gem_obj *mem)
+{
+	struct qda_gem_obj *old;
+
+	drm_gem_object_get(&mem->base);
+	old = xchg(&session->init_mem_gem_obj, mem);
+	if (old)
+		drm_gem_object_put(&old->base);
+}
+
+static int qda_fastrpc_invoke(u32 type, void *data, struct qda_session *session)
 {
 	struct qda_dev *qdev = session->qda_dev;
 	struct qda_fastrpc_invoke_ctx *ctx;
@@ -85,11 +100,26 @@ static int qda_fastrpc_invoke(void *data, struct qda_session *session)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	ctx->type = type;
+
 	err = qda_fastrpc_prepare_args(ctx, session, data);
 	if (err)
 		goto out_put;
 
 	err = qda_fastrpc_invoke_common(qdev, ctx);
+	if (err)
+		goto out_put;
+
+	/*
+	 * The session only changes once the DSP has accepted the request, so a
+	 * failed create leaves the previous process, if any, as it was. The
+	 * memory is freed with the session, which the invocation keeps alive
+	 * until it is done, so a release needs no reference of its own.
+	 */
+	if (type == QDA_FASTRPC_RMID_INIT_CREATE) {
+		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
+		WRITE_ONCE(session->pd, QDA_USER_PD);
+	}
 
 out_put:
 	kref_put(&ctx->refcount, qda_fastrpc_context_free);
@@ -97,6 +127,31 @@ static int qda_fastrpc_invoke(void *data, struct qda_session *session)
 	return err;
 }
 
+/**
+ * qda_ioctl_init_create() - Create a DSP process
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_init_create)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE, data, file_priv->driver_priv);
+}
+
+/**
+ * qda_release_dsp_process() - Tear down a session's DSP process
+ * @qdev: QDA device structure
+ * @session: Session whose process is released
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session)
+{
+	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_RELEASE, NULL, session);
+}
+
 /**
  * qda_ioctl_invoke() - Run a method on the DSP
  * @dev: DRM device structure
@@ -107,5 +162,5 @@ static int qda_fastrpc_invoke(void *data, struct qda_session *session)
  */
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv)
 {
-	return qda_fastrpc_invoke(data, file_priv->driver_priv);
+	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INVOKE_DYNAMIC, data, file_priv->driver_priv);
 }
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 3bb9cfd98370..da67f863c03c 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -12,5 +12,6 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
 int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index c21bc5b2446c..75e67c5f5923 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -16,6 +16,7 @@ extern "C" {
 #define DRM_QDA_GEM_CREATE		0x01
 #define DRM_QDA_GEM_MMAP_OFFSET		0x02
 #define DRM_QDA_REMOTE_INVOKE		0x03
+#define DRM_QDA_REMOTE_SESSION_CREATE	0x04
 
 #define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
 					 struct drm_qda_query)
@@ -25,6 +26,9 @@ extern "C" {
 					 struct drm_qda_gem_mmap_offset)
 #define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
 					 struct drm_qda_invoke_args)
+#define DRM_IOCTL_QDA_REMOTE_SESSION_CREATE					\
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_SESSION_CREATE,		\
+		 struct drm_qda_init_create)
 
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME		1
@@ -109,6 +113,30 @@ struct drm_qda_invoke_args {
 	__u64 args;
 };
 
+/* Process attribute flags for drm_qda_init_create.attrs */
+#define QDA_INIT_ATTR_UNSIGNED_MODULE	(1U << 3)
+
+/**
+ * struct drm_qda_init_create - DSP process creation parameters
+ * @filelen: Length of the ELF image in bytes
+ * @filehandle: Handle of the buffer holding the ELF image
+ * @attrs: Process attribute flags
+ * @siglen: Length of the signature data in bytes
+ * @file: Reserved, must be zero
+ *
+ * Creates a process on the DSP for this file to run in. Without
+ * QDA_INIT_ATTR_UNSIGNED_MODULE in @attrs the process is created signed, which
+ * requires CAP_SYS_ADMIN. Creating a process again on the same file replaces
+ * the first.
+ */
+struct drm_qda_init_create {
+	__u32 filelen;
+	__u32 filehandle;
+	__u32 attrs;
+	__u32 siglen;
+	__u64 file;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

