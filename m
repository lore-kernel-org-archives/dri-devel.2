Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F29C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2014910E729;
	Mon, 31 Aug 2026 08:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUAgg3rZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNXKL6RB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EA310E72D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xeO92824429
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=; b=EUAgg3rZBgh67bMt
 n4V6hNOyPmFmvSHgoruagyasxqNkOHEyg1/72ubm32C0Z2jorDXBjJZ5Mkk92gas
 hv0clGJk+bXqMwbt1ifNqAnghIVvxqvq23dztsmCYi6tGQArxHe6VUhteGp+8JDc
 /b9f+8QEyDCLwXe0Apzu5Tfcru48AF+qXJkMabNNPCFadgSwr+rxwIOofQcQCVlJ
 IV8515sAWuQipEtj8W6a5ZKzArdOp111gwqCTsAU3JCFInopTWzi97ZP3C3WOLJy
 yfxVGoaUPcZdgtLDpL8f74IkLZSWVnGZi+NK65eCzKEpHcI4GHf+GNwIzB88pbyj
 PzJKPQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2dddp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494527488so536895185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164365; x=1788769165;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=;
 b=SNXKL6RBORqosAH6I/MLndHss8D36D9tnpfkH78AloL4BvVx6SXVbeTMUkY0kn+CBk
 9Oh5zy4xru4I+Ro9THJCStZGyb13UAW9PNYuWPwFfQIgQsPcqbTMHJpezz2/+RZO9D3p
 +OnBWgHseSZy7AL3ldpRBPgRVujUXkEl6K+cnowX4/kKgzOQpFfAmPGOjqVAZN1mnZtB
 U0hcbHKxC5WrQDxOFF7lsJIpFbu+rFGIbeWlOHEYoZ3dOfGIMU85kGpFsK+9Ccs+VRRo
 QfsRLqlkHRL1g4CYQ97A5MfMJzTwshKABcyS9Qxg1ZjeOgVq97v3aEqdp2Ma6XaR+YKK
 3QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164365; x=1788769165;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5i86ADppHi1rPUDdBO+P0YYM37FqBEqSi4JIna7g85E=;
 b=TQv1qNd2lHdQzOkB29H3PZqqsbKWSG0k1F71RzpBvNWi7DtQ56fAjpNxuTn+0Wn30y
 vRmSugIVgaZ4CXe0DYxsdpymulAnrLUGO/HezjO2NLGWI7Ck5zzfQgH7zvDC28DMyAwo
 XCzqa395z22X1lrTzDXL4A0HMeb1xNp9H24E5ol3J99OyLIgalOf/PWQNtZRxncgWmkq
 9qv7A8dsClHMWDACrlEoyQ8aAp4/i+6Y+CpsLZEA42bjtGDkKZoK2BE3qPKy1qpLDFyY
 0jGo2lm+YULWrxb8pNJIvl2G9xKYKy2xYbS933eYtXkXXXG71s1jf1lKYyp14eDbD10I
 9VxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLaMQpWdVORFOcNyIeSdRPxL69dOQD4MGHT79uYLbZzjuJ8UwafPelsI9XAg5DqwegECHSMHvJvZ0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYS/Lv0cHq1GI2/85oj3m9fYVLp2HMPZwkxHJeMtJB4yqnN2WB
 SBqVBULxnQkNZp4Kn8o1mK9LWjjZm0YI1EQlOwQbY4BVamuyu2N/2DGkhe+2U1Uu8sda5QmT30Q
 iV24Z3N4koRIpBGmfsQPbf60F5GaOQaPbqEmbJJYJmHF+FwT2jGtv8r11ECxehpM2+MyJWUo=
X-Gm-Gg: AR+sD13IygSIbZxFEIvvlWXePZu+F1fMbwMEa4oisjscyqSe8W8RuLIDjRjHN/nI2bK
 Drv66wxNFxx3p0sPMbyp8hJGUEVf3dV/R+rd5vyHrXlcd8MZCiv06wUFOGcMd/4ZtMWIJoCgcdb
 grg+M5p6YQrMps9jGzGflbdVDFxF0Qx2L5EVT93vE+ZIcbOgqNYh0ibJZNJ9pBGF6v6j7tj6l+J
 nRtvx7mfCCE4uxD6KLMxx10YXlbmFsS9x55uIOjFL/sS/M9n+XpJ3PY0cTGb216y2P9KIjdXho9
 k0tlGguZ4EPMpQkI/enBZ6X9Tbk/tMjih6uzGs6+rcBEI3m+hr8DzPVjYjypubFZ7zYsk4g2K2J
 etqzacFJXUBozrxmUqf4cNIZAdxWfTAMrbAD1zj11QEozy5YvyEY+qTyT2HXJMrA=
X-Received: by 2002:a05:620a:700f:b0:92e:5444:9274 with SMTP id
 af79cd13be357-939139477c5mr2842288085a.30.1788164365479; 
 Mon, 31 Aug 2026 01:19:25 -0700 (PDT)
X-Received: by 2002:a05:620a:700f:b0:92e:5444:9274 with SMTP id
 af79cd13be357-939139477c5mr2842284685a.30.1788164365052; 
 Mon, 31 Aug 2026 01:19:25 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:24 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:37 +0800
Subject: [PATCH v6 20/29] drm/msm/dpu: pass msm_display_info to
 dpu_encoder_get_intf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-20-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=1951;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RFTciPI+nxW5BGq7bvVuLZ5n+fGy2vZwA3KysuQPE2w=;
 b=GFCIg6TuUI4SMExx+M4fD8R46ivwwCdbuUkowW6DnjurVcB4pw1J1jwhP/VbhXftm601RKrUb
 /yHJSMRhzA9DD99W0+J4kq2dcH8QtATr5oKzfwXkpBlprMKrVjLJ28n
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a95390e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TTd-C8IxYANZTSfMnlIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YdeAWWYknlAN4D-H5T5n2vtQzEZWKJe3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX+sNn9Kxu8uel
 FH/fEpU/pmm/8wMLXbf6kXENrG2U5kdZFLyurw3z8MQoIyvu/Yzv2+zeCeSeubo+hYdwUGTAnM1
 ctKznihY1Xx+39LUkP8DQqRh60wu360qNLNLn4B6xEzumkWC9MnugvvvoAqfTk208u8InP2tmYK
 nEpHXDNHFWzJiP9DAvXHxUSVYWvvaEQc1plZwNRm6vZ4Tr2PdHJW9l6FmMn6SEVnl+cG4K1AnXq
 J6dC15ErRMNxNYq/RT1T9UmSQzVvz/Vk1I8U0V2nn0b0eI7x6Gg8LXcEc+eVeXXBQuPTCjiROs8
 yL52iv6Z+CmloABodlBx4/UvreaUCR/dU6TnMUksYQfE71dQ9zLEO83wC7968SIa9OoLrvAK+8g
 3aKInvLSqiAmPkYgfAK6FWqepPpiWP54A9p8mWJc6yDw1mAxt7Pbd0aqPmgkxNbiccim9vfVOQJ
 idFUctnOenPy9DKC5sQ==
X-Proofpoint-ORIG-GUID: YdeAWWYknlAN4D-H5T5n2vtQzEZWKJe3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXzMjuudTsYPTU
 C2+V2OIVhguZC/cFms5DH/Be7hQMxJai/RWVrdIqgfJyYEcas7yFf4Efh0rQUnGq4MfsplO8W52
 MoX1kRuGv3AZbyPWA8i9nzCpZDc6v4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
index 1f20695f81e3..91cbb0ca521b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1437,15 +1437,16 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
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
@@ -2674,8 +2675,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 				i, controller_id, phys_params.split_role);
 
 		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
-							   disp_info->intf_type,
-							   controller_id);
+							   disp_info, i);
 
 		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
 			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);

-- 
2.43.0

