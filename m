Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB606606A6A2
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RsYgqMGl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LL44yv4R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2581A11294E;
	Fri, 27 Nov 2026 09:58:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412C5112951
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:53 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7GcCr905128
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GXhjSwlMbfYmQmqfRd6K0jcibQ1hxaw5IB17GQFmx74=; b=RsYgqMGl8jYjCeZR
 7CdcQqqTxD3/95NiHJm5rjlKXG0b/pjZm1IbqhsFG1L6cb+wuoqJFH3xASMJLN1e
 MO6O5uy0cIuEEr+8U0SMk4iSwcsHbk74qzjKkr6H/lXWzVzGRszf3WojwOYJoxd8
 bz6MXKxFqpLTXA4sUuNvfzrizLxjjG9bCcjne80tdfSrM2ZqmGG5RLHkZpSaYEA5
 3glTI3ESXGCpnvgDzqYYRiJmkmpqH/p+/pxn3u4plpVeF7jbLcHWTlwN5ISpQnU6
 rfp5ymPoK6yqMHmeBKoK0iuuNLMFRiR2iqJr5O/ngv/iMJx+75pWqktf6pxXPtA8
 ynIJtg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru39yqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:56:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2f0329e57eeso72274355ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795773411; x=1796378211;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GXhjSwlMbfYmQmqfRd6K0jcibQ1hxaw5IB17GQFmx74=;
 b=LL44yv4RbKScnuvAIMQuC6muM3OXfuWSgENFUqMUg2FVj7Y168KG+N1bPjkEGZThJI
 nNdixCjvRLjJHzmx6OcccNouOIJY3r1XQBlI/x5d3pfclE0lQLbVJ47P6EeEmOO+z9WH
 m0yn2pdyz72gC6jma7jSbWHiQB6pZLeXpl0nBzKx64V1QSLWhUe1FjvHL6NtbYr4Frk7
 77MfBmI6JKYQepiHxkeKlAIGMnARKZmfPaHjoRGDceb9YhhEXtFKOOkjf3+AHac/wb3W
 JMmt3nQ+4Eo46XuQyxy9+yGyiohF/Vt901siUa/6ci2J30w3cpBXnrXaCgx9PjFHadkk
 743g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773411; x=1796378211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GXhjSwlMbfYmQmqfRd6K0jcibQ1hxaw5IB17GQFmx74=;
 b=IwFzOWMy1NTVkR/xmE99jTt4fplEXF5EXkV7vr7BFAb5XydXVEsisXT5EcnNY2RnVh
 dhXT/OLzBKcC6AzxHGkhz4zHfuKVQcSVUV0bA/oy6/pF7LuHviydGP9ejYo7vdAOkddc
 ihuxKwuxqwRH9kz4cmMPSC5dUtvCKq3gH6M8MEXRCD6gqwKUC/iayb6GpWM5crT1eHM+
 o75ZEmoLu0eYr7296Za4Mf+/U0AR+MGK4zOXgifUCNP8HqV53aW//D0gEa43JwC3NxPL
 7P7aCbN0mUgHZKKeB65gz/azvj5R2mBWxerZc2iJA58a/VLbPEiDKBhZnPXVYB0um1yN
 bzzw==
X-Forwarded-Encrypted: i=1;
 AL+hErH8+QDJf+cvWF1QzZ3Rc+b3k9FJCo5I8v7pfEeV1SfotGwWEESfO+dhV6TvTe2Vr/GWORi3IsZKNok=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vi8KpqPNXkmNjkn9hU5COo8JJifkUOWs7HwEkiGVTIBOaiXeF
 dVUhGgZ8BL6HiRs4ccL/H87oPNtV3/hBFU72HWAxI0/HFSzvWcm98nkQczRgMKiuyk8WtkCjTMF
 dq+zFr4Q8UEQkctQI00YXP3HdEsdA0uNGoZqB4u4SMYozm10ZS3FbVRz7+qjDL9PjaQXbhiTYC+
 LiLNU=
X-Gm-Gg: AZFdTZfco5ZUPDfbH8Ia08x1e5mESyNRyxulaDF3qFQevgWktZnT16yeQgWdOweA84u
 YMGqfbIiY8pNkwYZmvMJq+Dxwi87nD0nKwQy89oHUBLGv6htC+IT8WXTZBCajlEdNHPsXEqOOt1
 XkLCnk19PI/fAkxUAnaBHIXtFikF6nWAtNBVuDTOBHesG8KbACEoPIfYwksadS/Bg4U71UX41SO
 5ONlJSTCGOfNcpj2mP/hsryB8t5Tp90AtUK8dLgkJZcuXWohn39HIY3i9xVuM/bhzIaUfHyqXIp
 ifT9d4PGvYsjKZDGmf43qJpvsyXRnIGM3Z8bppy4jLJgLzO+mbQWdcD2TQdbw/HVCp5scvw5eaD
 xxUkOfdr5uIlPsPtwhq3jr77+0iGttuC7BXAInysfSqvsG501X25QpbtxGHQ=
X-Received: by 2002:a17:902:ea01:b0:2ef:da23:7aa1 with SMTP id
 d9443c01a7336-2f03f1c02eamr228710045ad.40.1795773410712; 
 Fri, 27 Nov 2026 01:56:50 -0800 (PST)
X-Received: by 2002:a17:902:ea01:b0:2ef:da23:7aa1 with SMTP id
 d9443c01a7336-2f03f1c02eamr228709795ad.40.1795773410246; 
 Fri, 27 Nov 2026 01:56:50 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f14a432sm118132255ad.75.2026.11.27.01.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:56:49 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:26:39 +0530
Subject: [PATCH 2/2] misc: fastrpc: expose unsigned PD node for
 compute-capable ADSP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-master-v1-2-f998ec22497b@oss.qualcomm.com>
References: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
In-Reply-To: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b0953e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=D5FXuUI4r6NMu6bcXxIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: YIapHObJgWYq-Vs6ifkI0t8yru99sgjJ
X-Proofpoint-ORIG-GUID: YIapHObJgWYq-Vs6ifkI0t8yru99sgjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX6uJL+LaNGUG3
 zu6mt8r8k0MqXVL8Jh/X4xZBiOdr+rBLjpVlHPKyX+oDO1ctzchsYsu7+8LYdc3mLGeDND+dcai
 u07xOa7NHk47UKzLE+MgpuBSW5d7J0tSdZEj69lFsFVs6StNlyVORw+eT2QFx35P6uleM+yzPmK
 DWkICLjkfLLsqEr6j6DJhRQE8hpww3OROWroaxp2uJ6/yFPo7VeeJwaWYf7AAGy2zrc32wqSlDf
 gncoQtvhwm7LJQcQdXBi/QA0PruErRC8v+Fogl77+MPoxE9hy+GFaXUuHJ59T42Gib4p5MUkJlt
 LCvdNmMzI2QbPmat+UMuF34nW6xWjPVC1jwJ2Ny+Dzqy6T0EKybqZUGmdZ1ial/8Y7Yz0VKy1V7
 ZEpXSSJ0fzzp28zj6VkOXnEyK8HPOc3mItwGIkQ0N0ew25nr/iWAiFkf3mph/zP+7HvsIu17Cqj
 +7RDKEx+y25yz85Yhog==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOSBTYWx0ZWRfX8OHY3unQkXw6
 epcEJa2Yt32K5TMKw9adKSWlgkhF5T/p72blEMk/x58hqacO82YaMksnudBQKzHKN8z7JGSDh3y
 Iz65+/ws7c7wEmMmEbxVdZCn4XqXl/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270039
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

ADSP running a compute-capable firmware image needs an additional
unsigned PD device node, same as CDSP/GDSP, instead of only the
signed node it gets today. The probe-time capability query now
caches the DSP's attributes before device nodes are registered, so
fastrpc_register_devices() can check DSP_IMAGE_CONFIG_ATTR_IDX and
fall through to the CDSP/GDSP unsigned+signed registration path when
the queried ADSP reports FASTRPC_DSP_COMPUTE_LITE.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 48ded6080ddd..28d29c768aad 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -88,6 +88,14 @@
 #define FASTRPC_MAX_DSP_ATTRIBUTES (256)
 #define FASTRPC_MAX_DSP_ATTRIBUTES_LEN (sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES)
 
+/* remote_dsp_attributes[] index reporting the DSP's image configuration */
+#define DSP_IMAGE_CONFIG_ATTR_IDX (14)
+
+/* enum dsp_image_config: values reported at DSP_IMAGE_CONFIG_ATTR_IDX */
+#define FASTRPC_DSP_COMPUTE		(1)
+#define FASTRPC_DSP_COMPUTE_LITE	(2)
+#define FASTRPC_DSP_AUDIO		(3)
+
 /* Retrives number of input buffers from the scalars parameter */
 #define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
 
@@ -2621,8 +2629,17 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
 				    struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
+	bool compute_capable = false;
 	int err, i;
 
+	/*
+	 * ADSP running a compute-capable firmware image also needs an
+	 * unsigned PD node, same as CDSP/GDSP.
+	 */
+	if (cctx->domain_id == ADSP_DOMAIN_ID && cctx->valid_attributes &&
+	    cctx->dsp_attributes[DSP_IMAGE_CONFIG_ATTR_IDX] == FASTRPC_DSP_COMPUTE_LITE)
+		compute_capable = true;
+
 	/*
 	 * Duplicate the ADSP sessions before any device node is registered
 	 * below: misc_register() lets userspace open() and allocate a
@@ -2647,6 +2664,9 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
 
 	switch (cctx->domain_id) {
 	case ADSP_DOMAIN_ID:
+		if (compute_capable)
+			goto unsigned_capable;
+		fallthrough;
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
 		/* Unsigned PD offloading is only supported on CDSP and GDSP */
@@ -2657,6 +2677,7 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
+unsigned_capable:
 		cctx->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, cctx, true, cctx->domain);

-- 
2.34.1

