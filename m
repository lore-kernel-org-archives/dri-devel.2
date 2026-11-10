Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060360A2635
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lxrxQEkW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZPQZL8JH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339A810EDAC;
	Tue, 10 Nov 2026 04:55:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E6C10E2DA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:57 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A9vD2919648
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fYm7TimCwGGgjfZzxnOZ602ufC4cDb0WBqAEbjVY3Mo=; b=lxrxQEkWbMUEZwv5
 e83HHum9MCFcRA22E0fzc6ODfrNKZOSyIyHqSt84YYC29etob9IhfBNqED+Veuzv
 h+LpXik9ine2R1UdYO+VZnbzGxvLRPDt5btZaK4NO7Srs/K2IP68MNN6uyOPWeEm
 rNvrRD//e0ZBCzvSMYyKWZN35JbCSuVBaD8DJjzP7fRRa8GXc9VbBk2STC/YwhnB
 uPKfcz3K/DkamC2jyNZ5VHDNAKdkicXmvCNL0K/oKkUv5Fo791Upl86GHGqpkuLW
 ggHq24aX2Faw+888s6dPM/MPt5Df0j2WVBf1bVT6Md+94H2a8XBn7OJ+sy3phHmj
 zdlZUg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg1qtp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944101e6367so313391685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286496; x=1794891296;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYm7TimCwGGgjfZzxnOZ602ufC4cDb0WBqAEbjVY3Mo=;
 b=ZPQZL8JHhReSm+dw+RJ0fgTE02AmxDdHe/KxMwuWOMselqxl+9srr4jX1kgPxzv/Ou
 HB7QJ48UEQAr4Avfp3sSnMsHlOqXD7xCIIj7C6+VujH+R8hOhU9QU7IwUEe4iEF1mTJk
 sQ8DROwyKLqrEV7wUolUNtvPxkszgm6Viujh6e5YFeDvSAnjIMR+fxCHmpzgCkIIUvOA
 YiTsbV8bcIXlk4CqEYlBcHcfw8ZaWUQAsgNwfhmxWIbiQ/bm74E7B4wWczsalOn22L1m
 omCcl1YEp3IV2VlGD08JaW+NdE9INctJlRj62bJg/QW29gAR3Dv2SdWOzwFa1o/m+mTN
 cs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286496; x=1794891296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fYm7TimCwGGgjfZzxnOZ602ufC4cDb0WBqAEbjVY3Mo=;
 b=2Y5rZ3n2lA/bNf5srv5iKA4ycVdSLElAkbFFkj92s7Yr4JW1hLMfyT24XRlAPqXYKO
 W6s48yrroQ72eMkirT+I/1Zo7krbkXWukn0dYkgicoeMdCi0VE03gQeo2gOqAHXMVk8H
 N0K/9otP3EOHeo4STu4dPLlD3danlSceTLW1+5L2PZsZbhQnG1RayLd6jA108u8odOWu
 W8fjEd9Xqw20Tzb8Nv6aC3LutSF09sMebGWGlK18FZI1FHd+rdZ4W7Qd11G4Ow0FbSBq
 SjnzI15lgGJY15KV0v8UHmoUsrUcwykG+zKgMepyS+QXCWyuuGxyjP0+sCDePUkY61Kk
 KQzw==
X-Forwarded-Encrypted: i=1;
 AL+hErH7le9QDXsR2csZhhopFb92VFrnmYQujiNgP681i0Ub53E079pb7tIeIrHgua5Q7x9xiORbsh3s2qY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/WTs3/lJTfenqfb/HcrAxhWp3m8Mj3BGq9Qhq7LmVQnUPbIQmK
 c1ppkA7DE5MkZacdm6dlpwNis9ZpUZdomPt0teazCV4TJrUOGxRHO9YgRrCvSqF7oO6O/10/8Zf
 WXv6Qr/3u8UU67e9Ld+uPwg4joa/636C6Zemdsle9AWEAKkxRfg41yQ1jg5uR1gNokw3QQKc=
X-Gm-Gg: AYBFou2msEfjEuq0ZkgktXd8Q7T1DPZGZAgjMAdEywVsXSjr+APWyWLcHC4ucMOgBDq
 k9yXOUmMN4qRdGuKagiL9LALTTrzvEzHTFVnT3LzXzqTzGu7icc8CEoEKn+9628C9zg0jegVa5n
 L3SAeNe9MH5uZnXEJ7aJhJTq1ygkx/rApYDc0x1vKs0k5PHvfxDxljrxRoY5LqydhGcC5+XRgNW
 KbSB5Fmutd9DexdbQ9IdzjBy2EndamtrXSTEgvpmDsISLjs206bgUJJCA+N/47OuGCM2vYWyB+P
 x3nIiTobNGc2iu8DVhdXbDTiULNOJmmzKewp3xXIwXDHHxBS5Hhb8gCmZIzWX69fOG4zc9d0hnY
 y0mer8/YMh+z/0Gci+V/HTHRzAf9iqwDNluQItYdofVQqwtz3nIrFvEZgGn5UHeCwq/ZkRmXzOJ
 KxDhkBzPKd6VOl1YsS7729Hv6+fsQcR7UUYXdl
X-Received: by 2002:a05:620a:8386:b0:939:2b7c:34d1 with SMTP id
 af79cd13be357-9479f465011mr241868385a.15.1794286495899; 
 Mon, 09 Nov 2026 20:54:55 -0800 (PST)
X-Received: by 2002:a05:620a:8386:b0:939:2b7c:34d1 with SMTP id
 af79cd13be357-9479f465011mr241866085a.15.1794286495432; 
 Mon, 09 Nov 2026 20:54:55 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:54:55 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:25 +0800
Subject: [PATCH v8 04/29] drm/msm/dp: no need to update tu calculation for mst
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-4-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=B9iC9f11P3UYhJG6GuGSgLAVw76YLRk1a4MmxuGI4sk=;
 b=psDEnqwU6EoGLJN91XM63kS7wCtg9ipDg0kiJSTV6L2ym7K+3qRBc7chEobbAYpAfiAmTLqH6
 fd/3dHbv3UZBNX/aGuCR+RPmOoRE5isNlIFkDQHGcko/lfMzJU58Qjb
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX/zkPIZkd4Wa4
 8CK9iVI322PBJdx8g26QFS07bnbdn+O3RCTeg+Ep03Qix9BEhsfdHb+G0OWJPhqWHKcG165Pz7L
 7b5+8S1ZK8LfozWttnq9KOP9W+K5Wfbj4y1ALgSeU+QFlmXyvo5SM+KAQRZ3R1EEXS4juDnTip/
 5eAXd998FHh1SihMeP0oMYjLQjt3Z6Tq3Zz2/hplKXXVCKtMnliXHt3/TnAR1eSFPTzfPF4RPvJ
 BTv6o27keVkfsBqciveKylVo7I10bQuutcTdo51mM7KMWlE4dak4uyV183LbeMHbTrbYl1wwlMS
 KfUZHeiNC4qIIaHJEin5GBzdDKvQKgE0FF9numi2oJKy88x+Ef22PjEHUjQlP9ngh0TmN09Cb8f
 eVXBHiVAhr28xgOamgx01upzAivgcbesVoXek1mOndgiXnPBPL3hXn1MqnFgPOT84i8blF7Gnm0
 GeBq3cVEyImbiJ7KhFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX/HasnQR5Vw0+
 ZmiYsHStvekUPzpL5+9x9jQjt7QkIxew5kOFoojsaGw3YVWE/2mnqwWtDSJg/OqocXaTB3N9yoO
 NI/kayfg7nbYA4uF5hqX22MADtznq5s=
X-Proofpoint-GUID: lugHLlr5w0rouboSDHJ8pq6WD3NSMMV-
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2a3a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lugHLlr5w0rouboSDHJ8pq6WD3NSMMV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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

DP stream is transmitted in transfer units only for SST
case, there is no need to calculate and program TU parameters
for MST case. Skip the TU programming for MST cases.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b6ff3d8caa2b..a7cd3c87cd7e 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2712,7 +2712,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
+	if (!ctrl->mst_mode)
+		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

