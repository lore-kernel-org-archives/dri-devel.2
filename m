Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACC606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mPuY6K5Y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AJ/nQw6C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EED112153;
	Thu, 19 Nov 2026 08:26:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317D8112142
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v3g11962317
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=; b=mPuY6K5YwhLhWFCd
 ypMLasoj1giRpgz27CbUY8eWBx1RhMyx7NlkI7M6N/x796uKaSLQgL3X7FlRhho0
 Ih2EfyOI/JDYa8Er5upbDhth/RdEzQA5alPCgX5YktVnAPpELsTp8RU28WIbelYq
 8BGHtkdI224Jtv86gtCym5yxU6dQbjVn5vMHEm4tSRP1IjN4ILL0BhuA1tCIVBbl
 JpWMN1OBsR85Sq8kzLKJPSuB0mlLeP7+rbK2cTczQlCxOm7Rga0F1buyYJSoosvu
 UNRclSDghyi2vmtMe8Pb4qfUk0ilN1OQwkzbusVyk778cP7up2SbC8gRFTA6LV4s
 0WrtGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcu8ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9493e89d4f9so325124985a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076742; x=1795681542;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=;
 b=AJ/nQw6CA8lf7EJRtMKhVeWEI1HjsOIQZ+a5Ii3PJSKrDFf8a6quIDb3TuTPL/CtNf
 ejoGM8W/E71NOEqA0DQuzEweQfEzDogdMi08zRop6Yki+XtK8d6y6ZtHGftTWFu7e0cq
 giCvhDPnaDnD9BeFodx6hpkRDzdKJFLuKUoS+yu8Op5tZWVdFXgyySJqwgZAYn8TM50R
 4Ue8wjdVhH0/Bz0TAJCDLSbjoNk13TyzpDE3vQQ4bwAKbtVImfAZP9F8yfENsYM+Rf2I
 fwfoDn4PeKNutyoB6lSPpvv/2ROC5O+blWr8iIhhIvAJZvxbaj4y03r3gBCNzIosgBM5
 u2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076742; x=1795681542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gn3THCYh3qTT2YvtvLWHN5pOZBv2Lnvog214YoYtky8=;
 b=Aih/QDRdCY5vDymz7dUAxpigFAhQRYlTc3NXFHs2p047krtOpwoqrdTtRFdqBVHnOL
 k2i/JpVWpe1g8E2QiouEV0gSbn1eQ9rIEsu9GuL3GzJl3xdOuDmNcFyJzTCZK/xMZEG0
 zH2i5rdm0t0sIq2SjYqwxRnsW0iFsO10UZdSO/eKVEGwws6pACu/OWQd4rbBxrCtWB2c
 4KTCVUjCvUZc56Vz7kMOrMiTh8TRLnYKY4Z2vjYFkpFVVEYIjUmMumbesExWTqe9FFJI
 N19hYaWb5xthJP9rrIagQbmgfQ/E5gIHsBOBif09QAJJ4Wa2JxGBQIJRbXh9W+rE/0j0
 NBKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEBvqZIF2/8bTXj5z6TMhGC5ezScW9xoGWyZSwK5R4FSl+ULdcCd5Ro4vVXrxjCUFiAtF49+2J0AKA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+CGIzEbYXgBsZ8ZqMVHUyN1REj9Q9bhZckOPWN1rRGNzfWYLo
 RzMD9u8LeWtrXdOarXppbDOvi4b0i0JqqnVKS3L/nUlfZKSdBRTmt92AAkr1EUNMLWyae5lGcbl
 pOqtdpxLsWNGvm908NVh10qp1IK64DtYelNY2w2IaLUYOb2kL4WmB2Gy3E+M87ksUT/LzilQ=
X-Gm-Gg: AYBFou1PG/DkDLQCldIBVDu7Ficozy+2YPsjgY61A9b5KKUCtTsXeES4u09+SeHrYcj
 isYF2dcqrSU16ZO0aWj+tvckZg3ddhu0MnAcUY9RXIK23ivnkHd5mDwa2qEqhwHwOKctfme+V2f
 j4nuvulLU9ek3mLMpcgx90tleL5GF6Z5n3iEHJ5DYSQIxCH1njM0lotzV0pAnLWeMAcv577yzzw
 KVKq+TL+/R6z/BHSq9x3C4mkXjNvNsEe54KZTueTT8QXWsJG927PpmDpxKU5ZDayupvCsT2q+50
 /3Dj+7cXZiy6TkTXucqGOgsu+pX9Wxbj8mQdQVkRYR7vSzsR98XaPFQv5SwRNw+/vvw/pQKX2i4
 GialeAdWPbRtWDKuxKmbMQAmyVAF7B343X1EmNIksoWs2mfSj+cQEeBzgSVdlZ4CQ1foJQn2LZv
 3yp4Vl74TL138vxLYGWAomeIYa+CDbT2jhV/3P
X-Received: by 2002:a05:620a:7005:b0:949:6898:2e4b with SMTP id
 af79cd13be357-949996fe1c1mr829347385a.66.1795076742528; 
 Thu, 19 Nov 2026 00:25:42 -0800 (PST)
X-Received: by 2002:a05:620a:7005:b0:949:6898:2e4b with SMTP id
 af79cd13be357-949996fe1c1mr829344785a.66.1795076742036; 
 Thu, 19 Nov 2026 00:25:42 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:41 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:16 +0800
Subject: [PATCH v9 14/29] drm/msm/dpu: pass msm_display_info to
 dpu_encoder_get_intf()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-14-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1951;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kSG1AwjhdD6UXXB/LAoKM+KcPZ/iXxLYW1hElXuN5Nc=;
 b=IHUvVKZkGRkoW7hQeHl3YpQ6YDmXlLanxPRfT2SaBkyaR7C5gQLgk1L/Uo7kZTHecoGa1oaHC
 uLBGr7s+ww4AFEIC/HqlhYOEJuq/o2w6Ly0xpX1nNFFCNkMNXK2Lf3W
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afeb287 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TTd-C8IxYANZTSfMnlIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9HyirMPXbLVUIpI-EwOOUTj18hjkqYEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX6GJPTylFw9tL
 VgFvOMcBnwipM9+CcJZ6GJDp6DQMHcNuPzlYivOhqkrZy3xR4F6euz8goBvO5N9jj/3R2y3p0vy
 hqP4ff4rk5ATsSsx1IGTiiuhUeyVN1MK59ISMhHQ0DEQqJxJxpOookpVferIvRvwCXq7VFd9FXD
 LlzctsXn6x9c9BT0yheIyJea1yszufslViJb1qyY0Fu0U6VX35/WW/aVacYtbcPq+YwKmZYjWXE
 PO5qfAtUvxFyWDKgo+aYk7VZuB9lXlmDRCsTQu1Wu0mIdLR4fHnWFIPW1VXBeKR19aNMAuNDcuM
 Gb2ZPSE7RKZaN78WNO7t77ML0aH/jHYS70d4xTl3TOwYEtf65YcdKb4cNJE0/xP6RDZrkE4JF8q
 /zrOJv6Qqx5vhI66tmrvPKCGln2w6wrD9sQUMtRbZl03OEd3wrCab+GlT7kWhJxqvIF8kRt4dQ7
 +ihCD0PP8mXh+Yndfcw==
X-Proofpoint-GUID: 9HyirMPXbLVUIpI-EwOOUTj18hjkqYEr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX9UquvkMYfbUW
 +Xc87dvJsBMpN5oTEtruCKjg6H5dsQUXc8zFxPdnu+l+ss5GhnbhayvDzimGuwy9GW42ZssVtsj
 YpiNgQhPnr4l/pfz+Qgk9a+G83aqzLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

