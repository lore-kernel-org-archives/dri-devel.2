Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E53606A327
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfO+XRp4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drVfxEnm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E38610EBF1;
	Mon, 26 Oct 2026 06:25:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652B110EBEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aPE22222502
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=; b=RfO+XRp4pjYRM/xe
 mG9DK22XFlQQwhgLDBfJpX33NFBxj96FU7sl8qDGu+Plw5ex5UktXN2OLXZEcPB3
 lug8o00Xm0AzYhEad9Za2pih0Tbw5exLhKuoCnzPprxIuijvxz4zLfEKcFBfYNBD
 f5+Tb9YCPNgaxfkrq7X4qHuv8gdHeoQw+OyffCNvt95dE6s1lAH7r/ILD/USzVUm
 nwszRM9GZvSc0tqFQRJWBBDN6XG+UW+fGRSaExZ5Y1kMG3hd6Sy/gqDES2f0V+mA
 xysdEC50+zKS6USAkgaQint/7kg0MWwL/gfkLauR2rgrEFrK2k/1zcZdMguReItg
 yLnhew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8u0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:24:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e9501034c4so50082685ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995892; x=1793600692;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=;
 b=drVfxEnmIrFzvUsGAZEt8rR4UgZnP/H0ixJN+UPwAo2Sx6G2nzjvg1jbkb7tqLDG95
 8APFxIgBxzwp4wMfP/3sVGQUlvyEs6SVflSzdoNgeKorbA3MI9t+spzj2+h8wi/zo47n
 2ZoXp2X6LTwmsgj8NVCrfO0+AovKud4FmZSEOolU/uCNO307VtMMpjgfjsItysNAN9IF
 9rV4kW3wyy/bT8s6ie8RBTnavr0w3CCKohvnwNKDCypfxRh+5wENCLaq9iotTkBV2o0S
 yX4DR0exeNyTfSECtBKPJyFm8VeT/hO7DQEVZYjCeWM99nhemNIYVoOdFtEDp+fwPA+A
 oXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995892; x=1793600692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=;
 b=uJ4fn+W/TUQscQKEOxNghGVNLP4+ilrI7xtv8E+raz9BodRt+AonnhYaEOQWYVOZc+
 8ZSixH+YDppRE0rrm3znu1tx1WM4Wf9sAXhW0O4NPD5c5EJBz9wb+HB/TnfXFG89ZoiI
 59yQ3H+av9EKVykFrPiiqMSTfY3S65Z/rBtpPCajqoGaAP4miCVQFpGFlbohSE7SGt6n
 U2NL+KAfnD+scyQZ1OBuNgvjouBhzw/g4bvHk+axvD0TySdETSGI0SCFcSY3TB7UddHg
 TlFXGeklN7TPv9vXJ4Nh+9BQusHoWJ1pOxCo0RWdwT5ppiBXLkKTrPtq8jlbd6lYVA3b
 nZlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbhpVs0VqWA2/FfA74j4pqMLyySKr541D1QBf4ePfGljCDMO01n4jJMyPzxhUPVqq+tvUPYYnBsPM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICbD7aOd/lU6npEFAgRKqE7/h+Rea3rqBajwmixu4KBfvMtG4/
 6wNB8BAg7z1leHy0M74OwaOv2bynZq/ai76fM2Wv2mbPCSvcpomvXnEsneEaLH+8DCHtrsYFrh1
 ZvH2wPo0GCVik+o5vPEVYCNmWKQDFvOSHt2JXz3Zh9PobAIPWUlUcARDdT0DCNxOBjWeEbgI=
X-Gm-Gg: AYBFou3QHh3ZetyfdchMm89IZBNQ2Lq1iJfz0b0JDH902u5V1xuynayF/scIAZcvRr1
 C1i5eJO1Y9zH0GjypZGMCp38RZ8kQA5uAqjbX91itZ0cb4vIiJpnYkTzoxjp/q7/cdGavwMLyMa
 WodWXfGka0+hBwfZb4Qx8oj+OXmaqA4j/ddhnPA0dOwUGCL8cJuUEYDJceJkZJPFqBPkMctNQW4
 kmOuEQ1wTHrHkFFuqJDQ5tOJmZ3TaaMSPtwRwfQmzho9lyL7+/sOU1IsgrwhmEE1E/A0qzMB84b
 ZqS9tKqjFdNK8y5rdTicuzlP+7G0G9ln8o7IZ+hrctw0DXZt2DsmAlBJ0j7g+xSLoerEW/geZDd
 Xh8O5H1xvEQOoYz9vu+doH6gfiT/FjPpLqQ==
X-Received: by 2002:a17:902:d4c9:b0:2e9:5b4e:b8a7 with SMTP id
 d9443c01a7336-2ea9c8ebd4cmr50093145ad.51.1792995892292; 
 Sun, 25 Oct 2026 23:24:52 -0700 (PDT)
X-Received: by 2002:a17:902:d4c9:b0:2e9:5b4e:b8a7 with SMTP id
 d9443c01a7336-2ea9c8ebd4cmr50092955ad.51.1792995891873; 
 Sun, 25 Oct 2026 23:24:51 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:24:51 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:28 +0530
Subject: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=888;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=OlbpUMWfalcU4LvUc4XxjyJ0N4RsG6REGtg5lYpZB2g=;
 b=hqaldRzU9Cfrh8WAe0bLtlXt2+O+xAhC8XiFVF+11GcI+fP7EIgtkw/lV0bwk/zrXWsIWG3i6
 OCdlUUwhFkECpl0mDzYq/rh+5qzmVsGCw0XRLE0D382TWK/dkx/0epo
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: pRND-Tj3r6O8FCbUeJFCE0SPz3IZKWDY
X-Proofpoint-GUID: pRND-Tj3r6O8FCbUeJFCE0SPz3IZKWDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4653hK/qX+ID
 1gXtluRT3Fn+uuejoBLUqQLDUVCXRRxIm70+qg2DnmXJXKyXDEtQ698nwixkksg3LTAr0lRXvtp
 x/p29E4oSQ5Xwmp1kUDfRglVWU1gugUJaBYsQ9aSalV5VoR/Z3MMGiq3aWnxmImp73WLkLlOz4z
 1xHr4o55zGn7zhlfPqJGMofAljx2/StZJ0iySsOCVBUeuRg3vjAhb1ay9HqkmWguKCLt/eiAOHx
 hene07/u8rYx84T8J1UIn6s6Gb/j/RlE6Yr7DLNcMGQnVhwJ6AducZQF+S3BISKBDLMQJvIkB5z
 LbOnfyRuOntD32amePSs2uDvz8+z49sA+bf53yUr2Vh1XvqckV6CMHcv8+qSxtKdc9x3BBe0z6H
 8TQjEp2QDORGPFiKU3Xha5o2j2xz4oShiWpbiFKngrXZ8Kamf8VxPI5IK+Nrm4tcTbGjxwx+aWQ
 KsbqRVkUrqUFjqpDNlg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef235 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WCyPByqoPTdveakBLZ4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX1KImfC+oPmWi
 b9pK9zyp2PJzEDFQQyDe6q97HHWDTJhUM4/Ezzs5R2KodVA6ZHPdHUZapv+B19RIsJ9VTDEAaPQ
 BTqfY8yMa9JIbmW86yR52/DFNzXjogM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025
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

The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed
as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
common VirtIO ID header so transport and function drivers use the
shared identifier.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index f9056af0c622..6c6f283733b1 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -70,6 +70,7 @@
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
 #define VIRTIO_ID_MEDIA			48 /* virtio media */
+#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
 
 /*
  * Virtio Transitional IDs

-- 
2.43.0

