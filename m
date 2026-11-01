Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBE60701E7
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jWaSj8/U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XrxpEqmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24C210EABD;
	Sun,  1 Nov 2026 22:25:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677DF10EABD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:25:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK1BZ834716
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1kzG/Dg/owMDGYoIx22GjptP1hF8V3h3xBi1CQ1R8Ew=; b=jWaSj8/U1SPL7Kew
 xJJguFpMYtoheN5mgfVxGTnOpNpeCT+WNv5IDsbXzDBQ+ByC1SqUiPEXVoQIhHlM
 FL/RvqSk3vbFWGNB4BACYJ+oSE+4YlAilR5pACV/98CHMI+US+GxrTVqVwWrn17+
 JZ/cagPU6xAMD1o9S4ZdbByFQSiIjk26lkokUuyQVIJHlnZQOBJLeCKGX86eRG2+
 HssEkjSwHMNAlIlyXWXOzJSPIOmH64ck94lCFDc+J7rtdCx3P75kDYSx2Ih1wjLx
 hhdFjpoz+anJhh20ZUK97TCMPEFLsvKgYwZNdoK5qSfY5pfF52XQPtgSE3HnBvpo
 nzAeyg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9c4wr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:25:27 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-189d17eca17so1840570c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571927; x=1794176727;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1kzG/Dg/owMDGYoIx22GjptP1hF8V3h3xBi1CQ1R8Ew=;
 b=XrxpEqmWcxgylbiNuaE0ZOsOZb8K1bLWn/bCzH+em/j/RBV+Zx8jGQZbu5QX3jDfju
 vXn4IffOY8UX1QFxr/nO1WAC5RTdMN3vmZE9sjQnRvaBpmYPDBAP2wOXZyvz1x122zHf
 wrmUAvmOCOTd+ykhVNkQYwffcfvhe7mKcpqW1qlQ0khbs5h0pGWY0d9bDtDkyha+fyr+
 Ytt+VOofLoy2B+wiEYJ9SzY8PpD9m/XhrWiJzec6cJ8DYeDwuYxFoY9yJME1IaU6mDdh
 h1yepm3VSpAih2cmR6/W/HtctG6YOnGC9aB+GfUmXa0YN8/iU1y+gyb4RnxFjc99lM2V
 0JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571927; x=1794176727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1kzG/Dg/owMDGYoIx22GjptP1hF8V3h3xBi1CQ1R8Ew=;
 b=OkR/gbJmoBS5LX/v5Rfhd24JOs3ZFlkMDw+3GlSaoPjSC6ss3vb7oL8o5Df4PjL48D
 T6umpe9078HGMr+vYaXWr9mH4IIMZlLDfcHj2X8NoBOCpgPD7Tsc6fsxgPYFnASbQkee
 YdOfjMNhmjdp2vByYUdqYFsm1NHOvnl3LRb339j7Ym1cf4IgEHPK7AyWOYvYy9z73il7
 UB376kZ1OJ4EDZZFcKRs8Y7H4tND0S0RP3gGkHHOuq2GLnUlILovDtwuYB4CA20RmzeC
 vHhV/nbtVbRl/JhoSKdvcsOj+Bfh8IzYm+TQgmo0hJH3RNq1l/8FQCuoTXCPeQn5UG91
 XTyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7jPZNG4NIJ40/ZPoYF/HMPTfnkb54SB9m0YYjqRMYXh9Ss71Pv4O8nedSAZCGPjhaYoQsJClTC+c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBI6joxEIuiMxL5po+8TujpglIaYX6QIa2jT1at22M/XFG5RF/
 W2Z7S3DU5B5Q/3ufgiGKOgNwxC1DB8yajBg8sJzyFWMUSJl0USolocGAlFrD0B/bIukh0kUUv8A
 XAIazjsXUNfkNTodSi0asGce14oPcAm3L9FcQ6R3Wte9vtDHDAhgz5ITRJvz4wV5a1DFqR8k=
X-Gm-Gg: AYBFou3mNA6wfq4x/WvXYH0KUDKBTatFKNs4+yn1clF1r/7F1GJnjkn5O1BbBuJ8Mjv
 ZCPNYRQUOKnYAzZ6g8XAGC/M1TlAyYk5K8DBs5eYrMBxQ/LeZV13pRFFWl9zkw5E7FJQOVxIfau
 NgOS6IQ34Q16U5PjQBspwDCIjyWP7Y1aNsixqBl5FhfRoWaGJOQcI8ycTofNdv2tCVXroEioUiK
 eM/TmZSld2xJs1zjcclNmIOdpW+Bu8Z5/LRXFmIN4Vd2KOiaEhkP3tg1KRU7JzAwP/Wp7bLscwD
 REdmEPGfc64Xc6HaHXif1eT9vl25mtoxDoY4ST+LdzoKXYuWnXt+VrAgfKF6I8Tqm8bzQXPWNjP
 bMaB34ADOOXRZ1t6Fibn0AWUqpuu6IBNLaRlwycrAmyNbeYLUXecHbC9uN4psRTpHgJABPZBx/w
 03SkddyQ==
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr18675808c88.3.1793571926913; 
 Sun, 01 Nov 2026 14:25:26 -0800 (PST)
X-Received: by 2002:a05:7022:2203:b0:18d:c38c:bcc9 with SMTP id
 a92af1059eb24-1ac56e8a821mr18675754c88.3.1793571926248; 
 Sun, 01 Nov 2026 14:25:26 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:25 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:35 +0530
Subject: [PATCH v4 22/25] accel/qda: Add remote session attach to the
 legacy shim
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-22-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=9210;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=S1LrahsubxpMaNQzoAQki/9y8aw+aoYCRtlc5M1H2kY=;
 b=GjSwacbsixMm165OAPn7wFwGAIWRJ4X49iL1fNYEkJEXQMujlDQNttaV2fthf2y4/tbCqH+Hi
 AUaznHTWPzgCNLeqhFxJJY4tEOdv7KFfQPr48M42ML1Js+GsAZnhVzN
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: AxHru5ZqdFWuHCvl-LJRFrpgxrmTk6tX
X-Proofpoint-GUID: AxHru5ZqdFWuHCvl-LJRFrpgxrmTk6tX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX53su8CNB1bDO
 61cMUqhu0ZvN620jdlX/Wkwd+3Sw9hdR2mo2JFPXmnACZK2FwJ2Ao8+t9EOMHVtZAfJ9pyneW5n
 WgRI8NBUzpzIafcCuQ2KZ/j2d4vw1g9l9/lBGLD6R8Mvh7ugRc2hBMSnHcunSeqGt5JCJT8RBIw
 w7llIpoF/+1suaeD9e4cNRpeHW+PYm7eDt9jmrxu4FZLjXp8jYkWhI+o0cfpn5cHdY1t3dZUnX6
 5k1+IQZxRBd3fCzq4Mdb3XExI/J2boCvw+Sxarq3aYbaDa6norZa4wcIMGuSYfvbSiJd+hKYA7a
 qffUXlMOPc2PNBkl+nb7pDuzampAAusgDazJCdZQb3PjPSRXOuUSY1SIJy5ON1/xtte4r561UBq
 9wQIkJK2sN/jOcNL6JtBiaMmyvc3/CqiTkj8NXhza1/Gn5sVcGpg5L8ZYlhdaahUZGPM168nQ3U
 CSxvasqbWyyleXOjCNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX7gwL1pdhMiW0
 ERqwHxdPS2PV83HqkQkiP+iXfyVIYfMnqEd13h45aMCGbcQyoKWU2kJtuxN22kfq7JkJZfLDdZP
 sOTa2xqK9/6dvNhfMxcUbG6RfpvKTv8=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae7bc57 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=WqNVZKtITsyolQqna8AA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
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

Wire FASTRPC_IOCTL_INIT_ATTACH, FASTRPC_IOCTL_INIT_ATTACH_SNS and
FASTRPC_IOCTL_INIT_CREATE_STATIC into the legacy FastRPC compatibility
shim, so existing user space using the /dev/fastrpc-* ioctl interface can
attach to the Root, Sensors and Audio protection domains.

Root and Sensors PD attach carry no payload. INIT_CREATE_STATIC forwards
its name and length; memlen is ignored, since the Audio PD remote heap
size always comes from the device tree rather than from user space.

Move the attach logic out of the ioctl handler into a session-level
function that both interfaces call. It checks CAP_SYS_ADMIN itself, so
the legacy path is subject to the same privilege requirement as the
native one.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_fastrpc_shim.c | 24 ++++++++++++++++
 drivers/accel/qda/qda_ioctl.c        | 54 +++++++++++++++++++++++++-----------
 drivers/accel/qda/qda_ioctl.h        |  2 ++
 drivers/accel/qda/qda_legacy_ops.c   |  1 +
 drivers/accel/qda/qda_legacy_ops.h   |  3 ++
 5 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda_fastrpc_shim.c
index c46d2de4f581..c1464b1adbc2 100644
--- a/drivers/accel/qda/qda_fastrpc_shim.c
+++ b/drivers/accel/qda/qda_fastrpc_shim.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
+#include <drm/qda_accel.h>
 #include <uapi/misc/fastrpc.h>
 #include "qda_drv.h"
 #include "qda_fastrpc.h"
@@ -295,6 +296,23 @@ static long qda_shim_init_create(struct qda_shim_file *sf, void __user *argp)
 	return err;
 }
 
+static long qda_shim_attach(struct qda_shim_file *sf, u32 pd_type)
+{
+	return qda_legacy_ops_table.attach(sf->session, pd_type, NULL, 0);
+}
+
+/* memlen is ignored: the Audio PD heap size comes from the device tree */
+static long qda_shim_init_create_static(struct qda_shim_file *sf, void __user *argp)
+{
+	struct fastrpc_init_create_static args;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	return qda_legacy_ops_table.attach(sf->session, QDA_ATTACH_AUDIO_PD,
+					   u64_to_user_ptr(args.name), args.namelen);
+}
+
 static long qda_shim_mmap(struct qda_shim_file *sf, void __user *argp)
 {
 	struct qda_shim_mapping *m;
@@ -516,6 +534,12 @@ static long qda_shim_dispatch(struct qda_shim_file *sf, unsigned int cmd, void _
 		return qda_shim_alloc_dma_buf(sf, argp);
 	case FASTRPC_IOCTL_INIT_CREATE:
 		return qda_shim_init_create(sf, argp);
+	case FASTRPC_IOCTL_INIT_ATTACH:
+		return qda_shim_attach(sf, QDA_ATTACH_ROOT_PD);
+	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
+		return qda_shim_attach(sf, QDA_ATTACH_SENSORS_PD);
+	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
+		return qda_shim_init_create_static(sf, argp);
 	case FASTRPC_IOCTL_MMAP:
 		return qda_shim_mmap(sf, argp);
 	case FASTRPC_IOCTL_MUNMAP:
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 41234fc576a9..aaf3e5e6b5b1 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -183,7 +183,7 @@ int qda_release_dsp_process(struct qda_dev *qdev, struct qda_session *session)
  * so that a concurrent one cannot skip the heap while the first is still in
  * flight, and the flag is set only once the DSP has accepted it.
  */
-static int qda_attach_audio_pd(struct qda_session *session, struct drm_qda_remote_attach *args)
+static int qda_attach_audio_pd(struct qda_session *session, const char __user *uname, u32 namelen)
 {
 	struct qda_dev *qdev = session->qda_dev;
 	struct qda_static_pd_args sargs = {};
@@ -193,20 +193,20 @@ static int qda_attach_audio_pd(struct qda_session *session, struct drm_qda_remot
 	if (strcmp(qdev->dsp_name, "adsp") || !qdev->remote_heap_size)
 		return -ENODEV;
 
-	if (!args->namelen || args->namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
+	if (!namelen || namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
 		return -EINVAL;
 
-	name = memdup_user(u64_to_user_ptr(args->name), args->namelen);
+	name = memdup_user(uname, namelen);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (name[args->namelen - 1]) {
+	if (name[namelen - 1]) {
 		err = -EINVAL;
 		goto out_free;
 	}
 
 	sargs.name = name;
-	sargs.namelen = args->namelen;
+	sargs.namelen = namelen;
 
 	scoped_guard(mutex, &qdev->remote_heap_lock) {
 		if (!qdev->audio_init_mem) {
@@ -226,38 +226,60 @@ static int qda_attach_audio_pd(struct qda_session *session, struct drm_qda_remot
 }
 
 /**
- * qda_ioctl_attach() - Attach to a DSP-resident protection domain
- * @dev: DRM device structure
- * @data: User-space data (struct drm_qda_remote_attach)
- * @file_priv: DRM file private data
+ * qda_session_attach() - Attach a session to a DSP-resident protection domain
+ * @session: Session to attach
+ * @pd_type: QDA_ATTACH_ROOT_PD, QDA_ATTACH_SENSORS_PD or QDA_ATTACH_AUDIO_PD
+ * @name: User pointer to the static PD name (QDA_ATTACH_AUDIO_PD only)
+ * @namelen: Length of @name including the NUL (QDA_ATTACH_AUDIO_PD only)
+ *
+ * Shared by the accel UAPI and the legacy shim, so the privilege check lives
+ * here rather than on the ioctl.
  *
  * Return: 0 on success, negative error code on failure
  */
-int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv)
+int qda_session_attach(struct qda_session *session, u32 pd_type, const char __user *name,
+		       u32 namelen)
 {
-	struct drm_qda_remote_attach *args = data;
-	struct qda_session *session = file_priv->driver_priv;
 	int pd;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if (READ_ONCE(session->init_mem_gem_obj))
 		return -EBUSY;
 
-	switch (args->pd_type) {
+	switch (pd_type) {
 	case QDA_ATTACH_ROOT_PD:
 	case QDA_ATTACH_SENSORS_PD:
-		if (args->name || args->namelen)
+		if (name || namelen)
 			return -EINVAL;
 
-		pd = args->pd_type == QDA_ATTACH_ROOT_PD ? QDA_ROOT_PD : QDA_SENSORS_PD;
+		pd = pd_type == QDA_ATTACH_ROOT_PD ? QDA_ROOT_PD : QDA_SENSORS_PD;
 
 		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
 	case QDA_ATTACH_AUDIO_PD:
-		return qda_attach_audio_pd(session, args);
+		return qda_attach_audio_pd(session, name, namelen);
 	default:
 		return -EINVAL;
 	}
 }
 
+/**
+ * qda_ioctl_attach() - Attach to a DSP-resident protection domain
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_remote_attach)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_remote_attach *args = data;
+
+	return qda_session_attach(file_priv->driver_priv, args->pd_type,
+				  u64_to_user_ptr(args->name), args->namelen);
+}
+
 /**
  * qda_ioctl_mmap() - Map a buffer into the DSP's address space
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index f6f5d64e36ce..94adba549989 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -21,6 +21,8 @@ int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_pri
 int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_session_init_create(struct qda_session *session, struct qda_init_create_args *create);
+int qda_session_attach(struct qda_session *session, u32 pd_type, const char __user *name,
+		       u32 namelen);
 int qda_session_mem_map(struct qda_session *session, struct qda_mem_map_args *args);
 int qda_session_mem_unmap(struct qda_session *session, struct drm_qda_mem_unmap *unmap);
 
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index ea815ab0c52a..fc5e94c0c9bc 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -192,6 +192,7 @@ const struct qda_legacy_ops qda_legacy_ops_table = {
 	.session_create = legacy_session_create,
 	.session_destroy = legacy_session_destroy,
 	.init_create = legacy_init_create,
+	.attach = qda_session_attach,
 	.release = legacy_release,
 	.mmap = legacy_mmap,
 	.mem_map = legacy_mem_map,
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
index e3126ac10507..95a169edc594 100644
--- a/drivers/accel/qda/qda_legacy_ops.h
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -33,6 +33,9 @@ struct qda_legacy_ops {
 	/** @init_create: Create a DSP process from an imported ELF image */
 	int (*init_create)(struct qda_session *session, struct drm_gem_object *elf_obj,
 			   u32 filelen, u32 attrs, u32 siglen);
+	/** @attach: Attach the session to a DSP-resident protection domain */
+	int (*attach)(struct qda_session *session, u32 pd_type, const char __user *name,
+		      u32 namelen);
 	/** @release: Release the session's DSP process, if it has one */
 	int (*release)(struct qda_session *session);
 	/** @mmap: Map a buffer into the DSP's address space */

-- 
2.34.1

