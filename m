Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CD606D828
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KVmyxOoY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SsHLJNSP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094B610FD1F;
	Wed,  4 Nov 2026 16:36:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3C910FD45
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiwOr2210825
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PCyKNjNXkfC6vJ8k7pznUeniVUo6Eq98jGCiiKVtI8s=; b=KVmyxOoYa5okzUM5
 QqSLWDrlRg2WLD5SvdtbZ4FL/aTjlYMj3MrI+TjsSCrfMk13Et7P4padU0BPkfCZ
 Xg4U3DwQRmeMDNvJf910KvKQCBKxpfm/2HVS9e3VgGz1Azf+vrJ0+V7bKhDricq0
 jwnGKaumJnC7Tj8RXIth5VNxZps9lK3vxjUTvZxgCDLeOmzL8wRQm8Ak6LoMih7Q
 5zD8lzHOFIGlhb0nrCQFC/1ADGjIw5oJHRjshd5/eJ/9sKykY39+cHSo+a2hzel3
 JkcsxooIZq+9x9pjXXBeZVIsxhXV3CxHIz74HjSrZr/RHl/c+oY3g8tiCaHJwqmK
 KEotRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrjdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so160639785a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810199; x=1794414999;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCyKNjNXkfC6vJ8k7pznUeniVUo6Eq98jGCiiKVtI8s=;
 b=SsHLJNSPvP3ybAFfFl6rtrZlWpYXuYJ2kn+YlosGVJOPkdO76B+T79AOnsEtjzfx/l
 YklVTyGWvUef4lXU2JQKv9WKURq4VuHKodkoo4diHQ5I9re0QM4Joum2HtZ0m3nhAmDY
 Ww9RMpBKDSoYEA3HqCYcoidA2Fr34fN9LGo6ZWeXqc9Ohfdk6TvAobI7crj7LY3fzgK0
 04C3tx/yEL9oH9J4ZBRgcRMygrhAJ5x15ZsLUWl8wz+i7HjdvcFoB1U38p/SP5Ql24Er
 IcbkIoUKXsP1tpgzJ4NRzsdb/62S0ZksfwQGucTzZA0909xEX39omwWAu4e8bImnAOV0
 QmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810199; x=1794414999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCyKNjNXkfC6vJ8k7pznUeniVUo6Eq98jGCiiKVtI8s=;
 b=V/vZ5Ne3ZKmPBgg+ojzKXzblXmJ33CNrV7jzpK+c5AUbs82N1u2w/qqbmPLpenuIMe
 KIAJ4f8KaAziCIxUNl3ALGpUKKQ6Amg2R2w3C1UckSEqB+0vO8V8npLPEeICDcPPAafA
 jHdRh/DdbeeILQvA/oILKr6T2q63Xv9uQO6/KqU+ec1gCRPZIOQ49nlIZpYFJZreYZK3
 66w07AJOFd7ZZL7rlsquway881Ke9L5Feh/g47eC5UaWj21tjrWAZC/L+vi3XJRyljKF
 DXuZ7oBllQQdU/EU5unaR9mMf1mL3tDgey/eMqpzEn43kwLEkxFid4O9mAMgutpB61Jg
 TOFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1VPm4+lIXsjp2haYF4PqhcWmvzYn2jru7xARmdmPoyDmo6nS1Pd0HD2BIZ5zANQy5QM2tAzSOKV4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90uT8D/MDlc+nm09rYsPe6pZbCaWk03QFcOQW/8EvmYfMinXP7
 Hz9E4h750B40nP4520kM2XAObf2HxTRiPfQj5FPUi4+cr0ohFZsDPLgfgbV9cwoqUjetjW5fGTD
 chTRZLdDRgRM2jQTbIzKeKJwM6rIdyPmMfImXUSFHmpfhMOK90Wc7i+CRBuKtEA1z2QHbL8s=
X-Gm-Gg: AYBFou3yQT2xTscOXtC6YmP7leD8p1uRuEMfEzjbM11HPEoI1Cl4p+KmuXkUeyDxe+X
 stOvM0cDOnngfThAQPsdnPEX7XIOlwoBJhs8SUIFOeA8K0Z5FUPriZrlj4HlWSduIVYC5Q15ocy
 J7RlntmuGVPeKXOdaJpa8fxTnNIY/7TFr61xTucqtpAnSfP1Bxl7DgbmgHWUu1WE8m5+2wEoxdV
 aHr2+pNfd1sGtsGSf8W/rFOFWIgHb5iYp9vxj12juwpmMub/BAsBhrflCwz4ckZ0fzMZBLbo2kX
 4lgPyNNEldR2insGQhqIpB7jSE3Y2MV1aC9Ua7q5Ir0z68oysdkg1YU2jYsssF8q6vrb5LITY4L
 cIiG5wi23bwl619upeTLnawzY6cjVpH8QysD4TTt1jn6U2KHLdQ5vIQgc1R6EI3vy2bFkUHG8fq
 KuTbn+2Rlz738iLAa5mnVcM0xXILbFfg3dZMYI/HsG2O42atnx86Hgw57AOVRzXA==
X-Received: by 2002:a05:620a:4492:b0:945:c430:1c09 with SMTP id
 af79cd13be357-945c4301ff5mr1022745685a.37.1793810198451; 
 Wed, 04 Nov 2026 08:36:38 -0800 (PST)
X-Received: by 2002:a05:620a:4492:b0:945:c430:1c09 with SMTP id
 af79cd13be357-945c4301ff5mr1022738585a.37.1793810197934; 
 Wed, 04 Nov 2026 08:36:37 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:10 +0200
Subject: [PATCH 6/7] media: venus: report the QC10C data stride
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-6-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
In-Reply-To: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LLOKk1PZHMHbARwKPBiaX438vRakCex3LyDXd5CzP5Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq618Hm+3JHCmDS8u8qZblVd37BJ0x5xxPEFCaZ
 5lHf2oTUQmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCautfBwAKCRCLPIo+Aiko
 1ScwB/kBqkQMDyv22eW/LRrim5v1nMIo5n/TiIcDqwMPDTe9ThQDcJrVGvheq1kCkI+n/MV+XId
 UlANsjeeLygcFql217+g32OWD5Xv7t0P34ePgYkfgzj2+TEMQK97ZeQ+JR3UDNJOlxQgIaSTxsk
 DyIYnl15R7a0RZtFDzFxrqhmh8QRdr7QqeAGMuYNd9avQqNsHNLw2k8ANO3tWu1guplMQLhWzE2
 Y170gFyTcyfQ9bGF8hu59eWQfaM+ZC94qIWix4CoP9MKhDPKtBJTITsBrOr6z1HY5bz5dJ67V5V
 wG8tqcixLYZ2KaxhY4Nh70HqmMvobjeU3ZVCZpvZbpEo453N
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX+ZQvbMeszGez
 A7i55rrCWamq5WeY795Qny+u4+0UWutcC8tYgYLfU7fxLKGn+3naq3plFpw/54BaPVhQZWEimBk
 HQI0RlgsaVG0Th1iXkA/yaOf4+2+9vo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX4m7pcrh4nvxG
 oO/Yb43p4l/MTtkxV8kuJQHue5bhbBUbi+H7Lbj+ovO55HZYErJ4+KNbWCbTzj+6QzvLgu3FUBB
 PN7+VqnsEv09/2SOrOApky7u1qSLDRvFMSfVM/OyXGlvcUWiJltoGFE59872WUMS1PbwsbBbfXd
 s+M2v6nzpr0iei5s0VSB5NzdKwumQnARaCxNzPXFb2sqJidlPyK20A7P/2BjD+4+ndEp+zkHcAK
 Uj0aY9bWOH3vuLFzs10ydLvW+7StmsIzOP1ebCFSEYbVFRKju7vgNNC62OJ+ONkFfhXeIkdmrcZ
 Kp+VNB+QXylfKFMHVoue83E5EBbgv8O67tC8lqe/LBtPnZS9qIzTWn00jvGV+9kFyDRUTQ5KcN6
 Dz8Vvk/ifYlSqQWFQIZLE/DJlEA0l58fUIZCfGnRS3UKm26rV0mYSwtYFJldS0N5QZT+C3yJCgy
 7qFweG+jzqv1j9CUklw==
X-Proofpoint-ORIG-GUID: bwK3VhjCBUDJRfSwOiQYT93-zdHio7-9
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb5f17 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lvl4w2d8MLr2OEpUskUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: bwK3VhjCBUDJRfSwOiQYT93-zdHio7-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

For QC10C capture buffers the decoder reports bytesperline as the width
aligned to 128, as for 8-bit formats. QC10C packs three 10-bit samples
in 32 bits and pads each line to 256 bytes per 192 pixels, so the
reported value is too small: a 1920 pixel line takes 2560 bytes, not
1920. Userspace using bytesperline to import the frame into DRM gets a
wrong pitch.

Report the stride the buffer actually has, as computed for the
buffer size and as Iris already does. The downstream msm_vidc driver
reports VENUS_Y_STRIDE(), which for NV12_BPP10_UBWC is the same
ALIGN(ALIGN(width, 192) * 4 / 3, 256).

Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6a43ea191da1..9de0c9bc2919 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -227,7 +227,10 @@ vdec_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
 			stride *= 2;
 
 		pfmt[0].sizeimage = szimage;
-		pfmt[0].bytesperline = ALIGN(stride, 128);
+		if (pixmp->pixelformat == V4L2_PIX_FMT_QC10C)
+			pfmt[0].bytesperline = DIV_ROUND_UP(pixmp->width, 192) * 256;
+		else
+			pfmt[0].bytesperline = ALIGN(stride, 128);
 	} else {
 		pfmt[0].sizeimage = clamp_t(u32, pfmt[0].sizeimage, 0, SZ_8M);
 		pfmt[0].sizeimage = max(pfmt[0].sizeimage, szimage);

-- 
2.47.3

