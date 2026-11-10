Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16560A383E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XzSWdh5x;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQstUv2n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926C010EDBD;
	Tue, 10 Nov 2026 04:55:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B8710EDB7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A8lK1207780
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=; b=XzSWdh5x8phoUSbJ
 Q1JndPHV1IvO/YsY8U6xT3UDNpxqoBZgh8xpKb2E6+buJ2MG/xTuKgETbnQWUJTY
 DPw0bV7XEDoXPArIVpEcmJVX4th9F+WjZfw9UHHTrBoz2YnmnkjPL34DRCcxwV2Z
 XT8ioBymRDBhM0/So6IYERrFvkLC4Vm5XhtFikOh61Z7a/CaY7hQMmqlF+2sSaVM
 L4bi9fukZNkJpqQdH8PfnhgqmBshr0fNrXaxM4WIaNuD2xQii2gaxFniqRaTVV8N
 OVWkhsnmoBAPbHNv6TDnHFE+ALtdmGcenr6Ej7KGE5RCJ/Q18Ssbv9czE0RPQWGg
 yIW5og==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkhf8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94607500fb0so284028085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286544; x=1794891344;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=;
 b=fQstUv2n7ZgkLyIwgxj2jUDeY99hfJRxBf46Zt9I7xYUADFCHWaPGjeRm50F0j6JNe
 dBNAVmoBQwfLdVGZuTPsxwJ8kFbEHF98f5KrMDKlteegbWJltB9HMvYbtWeJI0ChAAPN
 IV2BKYi056pODsCorJPnziFYbSnVxxfOC0ue1rRKebQTZcX93B64s0IpwJQRJS0hrF20
 dvFd1yOR0c+HmIstVfy9Otu8cFAbF1+lC1/um2UPLFH+xmi4lYjcNnZWvdSF7ktvhEgN
 8PuuNBrW/ALFscY/HMfY9+7LVtAUAPjE/RJ+Qb3G9QTvl9hPzgnrkuZcIHrdwrzRahGJ
 /jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286544; x=1794891344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=;
 b=dYM/xbfgYdqf3xB/x4+yOvHI7JIGFYcbIpv3+2knURxhN1L+8HvJyyXwbMyD2rVPCQ
 kv4hEuA6zXQaExZslkz1dvbhyvzEkS0jwgs+7XrLi/RWsiRXNLAjaZCxNaDnH8p32Glw
 ZrUsyCiqAb1RWPjdHL0SSUSxrF2Wk/8j78gN3i9M7mb2lSGQ+aWqLCYRHkvqkZj6E0qE
 Pa9qd5PhgE4wfzll5xT9SHmC7FfNy1wn6f7mUrQmqG38bc1C1qu72OfwKRZ4K0TcomVp
 NraATcBIyiS095NACUfSsA4rCY9RnipsQdjZ0nUwvCQVHVk75rqSWbexZY6a9dQQNtUl
 EzLA==
X-Forwarded-Encrypted: i=1;
 AL+hErGDmher8AFMPWZCxhJPMKox42oto/9E1ALD7rrQaJ3bZOaZuxnbfQC8D5zC5tkRLokrWnM2B2gzscU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Dc2yEct8YSvE0UHJhswlhwTsWgzOT6KVJMUf/y4uQLwWKtu5W
 BAwWD0ZylAze0B6Gwl7UYZDCSRQMB1KuSr5X9tngIW5XM1EiIeSm8qULkWGEkuiyX1tiZyGcOE+
 h6ygSH45vnBRebRyr0F/eL3AzYMiCgx0DYeYFmguuDaN8Jy3U+6wjMgODL+VW7eMzRK1BCwg=
X-Gm-Gg: AYBFou1em0QnTQXkRndi1OoD5CVjxKxd5MS/XAtnmjH5QABNlkm6NbZeb+SgzuWK25a
 3aKNflUyEMrtaOk9l+ih4vQth1uV1X0TMj2uGpSKviDpoIuHqGmqACwDxhHu4XMJ1VQRTP5Y7UB
 1gZWEhoIp08s12Kvhq61fTG4d8poidWPnUUwx1pde16Bu7ZgJKOe4Vn6uXlupVuzaFkLCilB6rF
 DBl7gpeRAiY1v3WxSoYt4Fx0nT91d8quh4tm5nicJu5u505SMA5ZM0AfO4jZqx7yVIYDuQDDI/G
 N6U198HaZs/46lsta0Ow/H5/B/Qf3uV4gPjOITtgnIPwd0qnVMauVXgzTgKV9raVZGDaNcxecpO
 aMEt/wjzDl58Cc9qJJybD1FNOZp5jr3Cs2XXqTN494iKe2p1edoijTs9c3vZEK5r4+3PrfRbWxz
 WyuyuVJi6Ou1t23WeT3lSPH2SpewrKLgbJ1npF
X-Received: by 2002:a05:620a:1d0b:b0:93e:8c7a:bbf7 with SMTP id
 af79cd13be357-9479f1cd114mr240620285a.10.1794286544159; 
 Mon, 09 Nov 2026 20:55:44 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:93e:8c7a:bbf7 with SMTP id
 af79cd13be357-9479f1cd114mr240619285a.10.1794286543702; 
 Mon, 09 Nov 2026 20:55:43 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:43 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:35 +0800
Subject: [PATCH v8 14/29] drm/msm/dpu: pass msm_display_info to
 dpu_encoder_get_intf()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-14-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1951;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kSG1AwjhdD6UXXB/LAoKM+KcPZ/iXxLYW1hElXuN5Nc=;
 b=1Ahcc+eArGXWKK2CYbauZTCiZtd9bFfI6sItHoIq65yoqCvQ9mfGCoCrQeVFNLgJuKNWpVsCW
 PJy5zw+3G1uB3vk13q6TkD4K+aY3gUEiJW1Dvu9X8fj5+CwTAmVwwwn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: lcHuGaDSWJzaMXNBW18cO0o7eLj56UYL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4OXHbqCqKdBD
 dtox/x263lESg6Oceid00PVKq/ueN2nkV5KIjlThJn1Pmpe6SKoB3K+06gGCKtNGu98skkBuo5a
 ecPOc14UEu+alkaTFy7acZEuXXR7Taw=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af2a3d0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TTd-C8IxYANZTSfMnlIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lcHuGaDSWJzaMXNBW18cO0o7eLj56UYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX+BqHRkf3nCcB
 I0/FptEXNNeXY7Y7/jDKugdhINK42kdT1rz323Yvr6xKpfDbQ/uSU0R6SPQLuyZSNa7EzbBFNwl
 QtfoEkfLPr8PVOwDRD7eT9maYbhGskpaQG4DsSFL8OogeBjPwB3NW9xSRc6BGL5VLGdx8BCZjqa
 alW/2o1l9T+ibX/oLnuEbrlQKSjHhTZQNeJUL7+2R6ZSrg5xIwrlQMVDLeEJWxZ2gQNx7ltDcsD
 gosoC3F3/GnRrE7CRitGj6F4TLVqG/Si6ap0Ux8BI4x5qetqEpZcKFJcNyHjVnrEeJ7aR3FMKIA
 SsO7xdDK9vtDV0igOunANyEDTc7zhtb6qqHCTKCu+JWwVVgt6wPQWYgLSowgpFPuDupZ8afK6x1
 /iIVz0jSpNW52Z9/5Em9DOYy6fVpdv8xBNcY420zKmZPHEqGNgv5W9Ea5Y0lRcvqv/FDlnPGuZ+
 9NzmK6ikNssjVUOBZAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

Derive the controller ID from disp_info->h_tile_instance[index] instead
of passing it separately to dpu_encoder_get_intf().

This removes a redundant argument and keeps all interface selection
parameters in msm_display_info.

No functional change.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0a6be69a3e83..5e1c98371181 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1435,15 +1435,16 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
 		struct dpu_rm *dpu_rm,
-		enum dpu_intf_type type, u32 controller_id)
+		struct msm_display_info *disp_info, int index)
 {
 	int i = 0;
+	u32 controller_id = disp_info->h_tile_instance[index];
 
-	if (type == INTF_WB)
+	if (disp_info->intf_type == INTF_WB)
 		return NULL;
 
 	for (i = 0; i < catalog->intf_count; i++) {
-		if (catalog->intf[i].type == type
+		if (catalog->intf[i].type == disp_info->intf_type
 		    && catalog->intf[i].controller_id == controller_id) {
 			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
 		}
@@ -2672,8 +2673,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 				i, controller_id, phys_params.split_role);
 
 		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
-							   disp_info->intf_type,
-							   controller_id);
+							   disp_info, i);
 
 		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
 			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);

-- 
2.43.0

