Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B3606E526
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nuQFYCfs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fm7cpyHE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B2A10EAC1;
	Sun,  1 Nov 2026 22:26:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A392510EAC0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:25:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KJxN11808356
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nwucajbD+HNWxH4FxeHiZU8tWXZnOU3zyZiJTCLv21w=; b=nuQFYCfsssQ3y9N0
 7Za3EjBr7nYaRhEHo9aY3j7SnThyTGwMB/gPb5kJYP450DFQoxpU0e1nmLixVV2g
 Ryy94jRAyJPD183XJBUbly1erFQ8c8d+0JRI+ib3Y1GMov/cte8Tv9hCHE5XdPsO
 0jL2sdhUWBn6EGsz8oHxzjrMfRJq0zkKcqa9syoD2B3FRbMvY1BVgEmUFwIv9I50
 RoMr8LcuNQc4ncTb4h34iWJ6nuOXUq4XdRVDzWvKxRtXdkNl/oc3gkvB7xpbjcqO
 f5ZlITYalzKx+4c7MXLabR5NGdhYYH/qH6/7j6ht8uobG6vEnFPNFChWIteB4Abp
 E7xFZg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkmq3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:25:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a26fe9521so3264345eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571949; x=1794176749;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nwucajbD+HNWxH4FxeHiZU8tWXZnOU3zyZiJTCLv21w=;
 b=fm7cpyHENb6NDRHEE94D6Et62+HsgmK4pLATnrdxtYbWah8ykXa/3MeIqaWJj2OzDk
 onv3jJmSgUTomZWQFgJ/d+nZPxJ+6VrGyQ2WjgGGUTrynoReUfHqY7JHjfpD4YmJNP9z
 JE/sNJ62aTufczi70hLPCTOlnUnoNVfET+Ok6YvAizR1EoFT4C8unKyrnrftqZ9Q4aGE
 KU2SZXOg+yHgX+9Jda8ZpguAtgjY7ZRNZVSGeVdZfejMUW3CbALoFacB5VwiM4ytEL2A
 bcJx5WBMuAQhYy2/zrWx81X0O2BvypUroCBmUl7Stc8Id+E6+UdTmjNH4kf2CdGksjnw
 +EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571949; x=1794176749;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nwucajbD+HNWxH4FxeHiZU8tWXZnOU3zyZiJTCLv21w=;
 b=uqX6IhOKcbgNtnFvWdG5OMhJ/eJRC6Z8nEea3yrRq/IDl357UX5mxgl+CEsGdP8tpM
 g8k9Lk/Sf5Ry8Q5tt0okWVF4sh5NRo/i3luAavlSDGml3xvgvHsnacOPDVX/6ByZlxxo
 azbWhIzR0Zk5Cn2wEY3dzcnspRrfrNUaHcUwUc0ogK9yQjvTVZVj2ELqdl+OEVfiqlhC
 ViCtsPaLM5WtOA6T9ZKpgJLafIlK5e6Z8JV7cIJg9nqE7Gwer+LVrywebfsWJq7c1jqW
 1FUaxlkoe+TBz5FPedI+6rBKI7so5NE+TLJ5uYgFYN3gxgR8qCV7dt6WGVJVzz4a7b5E
 RFjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz80P1JyDkffhspqUhsfclbBAV3sPS+ItN/qXyZrmeu66oulhtLjcqFEe4NybWcucZwy2tscvpCxLw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6pi3tB3SDTiATtyOUmOxkgI0S5gZjveWTNnXKWfPKPTCbSbiy
 RY5OhjF5KjdLl3DV4LYkU7dFr6s/1K0j3jHWd3uIdnM0dY4HaZgBThuubbZAtciva2oJXYUDbbW
 GF5dWzhmqTeDNz5QBT4CpqKlZfyfPjrqvmccHZVy6OvmG/OAJtdBl1tbX9AxraqCtcChUmbM=
X-Gm-Gg: AYBFou3YTquyY1NCfbelhSJlp8ckkbL8KvpfFTk+zMybLj+EQ1nTqhG1ngygAnoWFjt
 jCztBi4/3vWCYHequxr853kCmjaUr+cvNbOSStWoczbH+KIa3iLcZEj8msqV8fAQB3GZtTV0Ghs
 ZPZAd0UoK7C1sdv6fXv+F/Ghaudrw92gcLBLq+T9FlKRXyzi+LjLO4q+IOl2Hw5roN7QRWC10jj
 TKjzbz7wEWowmDfVDgydFK6YgTIvzx+swrxOxv9ojIjAGF4XsaSmIohFWXYjrPxSfn8xLoIcYK6
 kkHlC4hmTSdps3Lny7xoomOS+yA2JrseIC7B8YKzltDFw2Zuno+VgmQMmTVvpNFnHerz42TPV1S
 djVGskQ3Liax9Rz9BN1wrgZisDeiggByENLRTRZJhGt6yAVVBx2h7BOYEvi+j/MIL3SZ4Qnog1c
 9rt0WE0w==
X-Received: by 2002:a05:701b:2092:20b0:1a7:77ae:11f6 with SMTP id
 a92af1059eb24-1ac5b7e0185mr12212172c88.17.1793571948416; 
 Sun, 01 Nov 2026 14:25:48 -0800 (PST)
X-Received: by 2002:a05:701b:2092:20b0:1a7:77ae:11f6 with SMTP id
 a92af1059eb24-1ac5b7e0185mr12212134c88.17.1793571947846; 
 Sun, 01 Nov 2026 14:25:47 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:25:47 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:37 +0530
Subject: [PATCH v4 24/25] accel/qda: Add legacy shim support for DSP
 capability query
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-24-88f2f24a5f0b@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=3736;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=jwnH5cfp8M6GHrX4Z/62vWuSavKSWMU+7o5H4b+rDhI=;
 b=e5bP4QRM4M++NoUYF49dvgjnn6jVgLjcjBzplELgWbocjqksZsYZ+UeV+0spKYA4N1U2Y6IMe
 CXSX78olZOjCfKLCICBHH6b1BTgTKI13Kv1urMO2RHlPcTyD5seSD2d
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: 74vuNqKHRiP2zEjGgj9OhhLxd4uwo0N2
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae7bc6d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=co94-PkH9mM8E1aZUYUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX3f6Nj4IFIaeD
 P/p85Dbv+pK4XCNcX6QpHEK5z6ZXIy1qO9J08+z13Q26067sOJwRjhZn88L1QRisAzPZGhVUuZc
 yQlazLhF9WRIfagA5CI0clcf6VB56YM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXxRa7F81N3rjt
 QPfUlGqIa9ux5dvuWt+KuHUWL1nHsDPJY9A85zkBfH6WPRWX9zh7YsGr786f2GjYf5jCL0uF00c
 JJhKQAYyTTAsPd4c+gQWMeLGToEFf8u4xtkPPhx6UQwmBhSnWceMX4v7OVPQQQhK+RxVnKJ8AEi
 D6MFZ8xOautvC/6RKKKmAtrhQZGPQK+PMwnXqOL48uyNTLYq6iOXWV0/2BFAW+3kR3xjJbeIsj5
 MznqKmQ/YQrNEFirrZzwBVHKiDs1Cs/v5wtzhBX1Jkb8Js5F7xcX/bOjUl1w7hXbdvTmFlmwIev
 Beqns0FmsCBZK9Kgm6LwjMe5csid3OENVFRGC6XvWEj4cHhdvigCxB04ZI+XqiArVqD/dBv6aqZ
 INgKNsJN8aMhCmy+cxYD8PkzGCvXMg5DYIGV84euCZTPSS0Efay/Zv2L1dWBtn1ovWhD+XTtbaL
 ej6r0lqE3D2EgAVkA6w==
X-Proofpoint-ORIG-GUID: 74vuNqKHRiP2zEjGgj9OhhLxd4uwo0N2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010089
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

Wire FASTRPC_IOCTL_GET_DSP_INFO into the legacy FastRPC compatibility
shim on top of qda_fastrpc_get_dsp_info(), so existing user space can
query DSP capabilities through the /dev/fastrpc-* interface exactly
as it could with the driver this one replaces.

The device-wide capability cache introduced for the native
DRM_IOCTL_QDA_QUERY path is reused as-is; the shim only has to
translate between the legacy fastrpc_ioctl_capability layout and the
shared qda_fastrpc_get_dsp_info() call.

Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>
---
 drivers/accel/qda/qda_fastrpc_shim.c | 20 ++++++++++++++++++++
 drivers/accel/qda/qda_legacy_ops.c   |  6 ++++++
 drivers/accel/qda/qda_legacy_ops.h   |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda_fastrpc_shim.c
index c1464b1adbc2..2be1dd116ef7 100644
--- a/drivers/accel/qda/qda_fastrpc_shim.c
+++ b/drivers/accel/qda/qda_fastrpc_shim.c
@@ -463,6 +463,24 @@ static long qda_shim_mem_unmap(struct qda_shim_file *sf, void __user *argp)
 	return 0;
 }
 
+static long qda_shim_get_dsp_info(struct qda_shim_file *sf, void __user *argp)
+{
+	struct fastrpc_ioctl_capability args;
+	int err;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	err = qda_legacy_ops_table.get_dsp_info(sf->session, args.attribute_id, &args.capability);
+	if (err)
+		return err;
+
+	if (copy_to_user(argp, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long qda_shim_invoke(struct qda_shim_file *sf, void __user *argp)
 {
 	struct qda_legacy_invoke_arg *largs;
@@ -550,6 +568,8 @@ static long qda_shim_dispatch(struct qda_shim_file *sf, unsigned int cmd, void _
 		return qda_shim_mem_unmap(sf, argp);
 	case FASTRPC_IOCTL_INVOKE:
 		return qda_shim_invoke(sf, argp);
+	case FASTRPC_IOCTL_GET_DSP_INFO:
+		return qda_shim_get_dsp_info(sf, argp);
 	default:
 		/*
 		 * Includes FASTRPC_IOCTL_FREE_DMA_BUFF, which the driver this
diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_legacy_ops.c
index fc5e94c0c9bc..8d9d597c76c2 100644
--- a/drivers/accel/qda/qda_legacy_ops.c
+++ b/drivers/accel/qda/qda_legacy_ops.c
@@ -188,6 +188,11 @@ static int legacy_invoke(struct qda_session *session, u32 handle, u32 sc,
 	return qda_fastrpc_invoke_legacy(session->qda_dev, session, handle, sc, args);
 }
 
+static int legacy_get_dsp_info(struct qda_session *session, u32 attribute_id, u32 *capability)
+{
+	return qda_get_dsp_capability(session->qda_dev, session, attribute_id, capability);
+}
+
 const struct qda_legacy_ops qda_legacy_ops_table = {
 	.session_create = legacy_session_create,
 	.session_destroy = legacy_session_destroy,
@@ -201,5 +206,6 @@ const struct qda_legacy_ops qda_legacy_ops_table = {
 	.alloc_dmabuf = legacy_alloc_dmabuf,
 	.import_dmabuf = legacy_import_dmabuf,
 	.invoke = legacy_invoke,
+	.get_dsp_info = legacy_get_dsp_info,
 };
 EXPORT_SYMBOL_FOR_MODULES(qda_legacy_ops_table, "qda_fastrpc_shim");
diff --git a/drivers/accel/qda/qda_legacy_ops.h b/drivers/accel/qda/qda_legacy_ops.h
index 95a169edc594..c79003021fc1 100644
--- a/drivers/accel/qda/qda_legacy_ops.h
+++ b/drivers/accel/qda/qda_legacy_ops.h
@@ -57,6 +57,8 @@ struct qda_legacy_ops {
 	/** @invoke: Run a method on the DSP; takes ownership of each @args[i].obj */
 	int (*invoke)(struct qda_session *session, u32 handle, u32 sc,
 		      struct qda_legacy_invoke_arg *args);
+	/** @get_dsp_info: Query a DSP capability attribute */
+	int (*get_dsp_info)(struct qda_session *session, u32 attribute_id, u32 *capability);
 };
 
 extern const struct qda_legacy_ops qda_legacy_ops_table;

-- 
2.34.1

