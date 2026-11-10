Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED160A383F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gq84ZnNo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HSO+EcoV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0977110EDC4;
	Tue, 10 Nov 2026 04:56:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E7F10EDC4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:27 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4AZGD2298814
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jiYfc46G77lt9R6Qh2XdLqt53zKjKZqhaxsJEqh35jc=; b=gq84ZnNoff3ICxIU
 B9H4a4zH9bTIylAz0tQVLzLZC4MBlJYKK8l4voWT1MRUc63bijt0SrIobHQkstAa
 DDG+VIvwttrkHM6FaSxZ2YDYwUbDezZi2YpT1SobD8wXLqrxQDn0O2SIzSj4YSdN
 fFJ108k43Fcej2K5iWUrYiqx5KIovNTjKExIj8QbDc5ySszxIiL5d2UI92IvaP3h
 VDO6RFQW3zn0VUn4WqyjVJU2Ilx3Ar+eDl2FyRHi7EiNoJkc20OyZQnx+qj5bvYt
 kHyTTF+u44GtptjGZ/gZFKU8k8AFI5N5p9IhHx1g47uFczDAmeokb/9Z6Yk664uR
 Pz8ZPQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2n0mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so321401785a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286586; x=1794891386;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiYfc46G77lt9R6Qh2XdLqt53zKjKZqhaxsJEqh35jc=;
 b=HSO+EcoVK82vMBZZgxGPIqpFRaAVKts7ji5BT81FumOVRYZGa6v8uW42+lbR5Lm+Ra
 udEZ7YWxUX5LzC46zOVD3wFk2RPKVCIwEg1CRnR4nesYCPLB3a4YuRNbR3UZ8Zm+6dgX
 Xa4XiandX7IkCQWidojAR7tl65F7GT83anMlIzZtv1gE4ZpIKaJS6JBfwT66sVuEgsY6
 nwaPOGMctJ1AFib+t+7jGHg/PEU6hd1DtcqfpjF/0AREMihM/4mjoPdmOd2tfuYdH/zz
 sJvaIhxCTyQxu4H7vu9nf2qwkMe6jkgBqQX68cObdXH6RgLeJFtSxTHxM4No1vH0qjx3
 2r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286586; x=1794891386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jiYfc46G77lt9R6Qh2XdLqt53zKjKZqhaxsJEqh35jc=;
 b=2hbD6Nj9SnFKCC29KEFlbqFJUcgo+nLiTh0bOKQVu3H4jbvHmKI6zm2XY2jsbEEbY4
 k7QlS6+21XUm6G0dxQSYzRjcb2CQk8j+VK4dTsa2+l4KtZWxqD0aVaPwSS7ARbLAIZ7s
 g/E+7ijYbzvY2wP8IMn3P3IzYB7OlND1oJTjDjn0evgPFBcRCfrBd2Pos3rJ0UDQStku
 9pATLxRkt4oN/j9nXvZirCrOI9UqzajMwMU3KvAjPzA2wzA9Bx4hUPRATN26l/x4BAy8
 1YPpqP9PaBAxCouBv58HujcOALDsdyIPcnpDwvGOvhjDnN2G661HP+rL+6S7L7hl4xMJ
 YdEA==
X-Forwarded-Encrypted: i=1;
 AL+hErGA/za1nGi2lRiSS/7tZRQ6Z6UyCOjJ/fLdVEgxMakbHnmF4sJNH+oiaK1U6gqnqxvaKJ6dgMvB59c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zvPzEhmm81SgUKXK1ieUHkcgp2TcHDCFyJU9MXnP0AW+zc8JQ
 bi3TKUjiH5EN0H0gSet8tW1CUfhJDWq00eDTNcQYlIrwM50xVV1XqT+sZObDKP1mXC50+/9cx9q
 gdW7FwE4yku7kinkzjU9kmRysfOsOuprLB809FybwW6ehLuyTInsXiLMQdlGreWaidy8Vj/Gee/
 5xxWUdww==
X-Gm-Gg: AYBFou0YFuWXoBNAO0MdFC3LOp+jTXMDo01KI3RU1FE7EGpqkk2ekewTAiYHzMG/H67
 5Tm6h2Ft6JYL2m3Wikf3FpK2xis3+cMOOlB4p8mOuDEvENzaMw8xsRAqS/erMwuwObYNgsr5At5
 0LpSSP91IBtqGAIk6hSDXAAhY3MIzZtC/s9FeYd7fBSwNZe1gh2kPr2+BKtbFYd+Sa+wVIfQcVZ
 wzzAwCu5Jb8ggvjoh2EBl+Et8+uG7gFxo+u/19lwbu0z2VA7X8pklSONFfbpXxnLTHNeDRS9vqc
 YoTOCAf1r6E/nFBKgNlYZ3zOLWkJi55Ng+JDamRm/hl6JpATwmgbG8p6ErWYx9mnYQr4Hl9Xr23
 D3jwFPhz5D+Ro2Pgl+8eFB4hVhYieVP3Q0vgT1IK2UC5MNBY+6DV2vQ2tiVzvyvfYlX1NnvpX9+
 degI/47fjlS6hPjRWWcZ9CT9L3ggAwlBRNSlPr
X-Received: by 2002:a05:620a:1d0b:b0:93e:c12c:9dd0 with SMTP id
 af79cd13be357-9479f4454a3mr237103985a.80.1794286586034; 
 Mon, 09 Nov 2026 20:56:26 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:93e:c12c:9dd0 with SMTP id
 af79cd13be357-9479f4454a3mr237101785a.80.1794286585589; 
 Mon, 09 Nov 2026 20:56:25 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:25 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:44 +0800
Subject: [PATCH v8 23/29] drm/msm/dp: mark the SST bridge disconnected when
 mst is active
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-23-d040fb33db5f@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1111;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=g/Wmh1bQW+8FuOEW6WjMpaGh0c6vu+MEknlrm5lZYXI=;
 b=WR7Qm7cjMwoK1HNDcf6+Pbhjj4o6Zh3v1SLbX1SStKLOwIM3yAtmg1wNzx9kFfNItg0v/Yejc
 mAEoxYEue7aDgLDCBEgqwqh2Jcyx7OgWpTxK08iSYc+2eDw72RKUmdT
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af2a3fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX8dLE1ZELkjV6
 p8IDmqHJIqpZddTwwSUtPdPxJzKgRQHYF/WK0iam1p2PbzPtHn0tUP6a56QVj2VRFae+ceAK5f7
 DYuWJtpVIwvemJRICBFo2s+xt0OzEc6GQeL+xuwMkjsDjHZCYTfFp3Pdzu+jyn7ni/9TLEac7GH
 r1yIRWKGUDwn7hUYEH28XAv4cLulFQNiAJeb7F733bDCoLUW1Ejw6HKees0EVGcuuHzdHLH/5Mh
 45o/q6EwaZUhsg0mwSx9FMc5HF8F1dGlEBtz4uVxNb1o3vBx/mvePdRIcVVkRYMAejzQyTcsiNk
 yH1ZKOQNSHyDMLfYSDN+MUHHYFzKQKIdEsttq2lrrUDC3E0lbVj6P6hCN2jxGCpbTfV1y4XRb3g
 dNqvo/5EsyqYCuRY1rmQnKbadcI+4CQg3M3z4HDMDWqIA7uHFKR+IVbEolLAxBnzKxduUPO5+fG
 g9ih6876NNlkJmFfinQ==
X-Proofpoint-GUID: tNRAbXHtoHi1Q2qzeAqBaS-I5lXgISJy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4nnIWzRYbxo7
 j6e5BTSHesiqsMjDk+2hpLZ1OTm8B2g0Q2WL79WFToQbQgS/3OxXh3xSj5BXxkvaLekxgMXsSSe
 ekSNDQ14h05vvWGpbxT8vnio8Nc7hto=
X-Proofpoint-ORIG-GUID: tNRAbXHtoHi1Q2qzeAqBaS-I5lXgISJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skip detection for the
SST bridge when MST is active, matching the behavior of other DP MST
implementations.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b4e788d1f611..f87eea19c4f5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -976,7 +976,11 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	if (dp->mst_active)
+		return status;
+
 	guard(mutex)(&priv->plugged_lock);
+
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.43.0

