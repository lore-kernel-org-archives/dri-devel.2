Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970C606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Np6W6Unx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JGnj1Y76
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262861120EF;
	Thu, 19 Nov 2026 08:25:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628EA1120EF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:57 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wK5Q1007331
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /op15N+dk/kFzQiPKrVNKKswtw3ovipu+xGcbt9hcwI=; b=Np6W6Unx7oVmngR8
 nY+Vkve6gsZODrE/5nksVuERVDpZmsNlRv1oOXWWsRYmsMBnU0bgZRw2/SXdo87B
 IB8zks3HYSlvsPbgWYyF3xdYHdpEmrnD1Gnwc4Fqg1Z40a95H0PUzsto3vFVZSaN
 XqmgroHCIxw+xgs9g57ntCy7lObo1w6ZJdxOZ+Qc78hRCtChAmnEj1CXVxZ7o7Gr
 7kY+bI/iThsOohyVv6Ckw0HKus/3tOGTFFCv9n2QBX8J1aFGOLJ2Ly75y0BEwktq
 h+GZxIulWo+WsyLCsg5IR2erdCYw/TqbAi1DLZNVXKnONG5JexUPCxkb31Ihd/nL
 sYWS0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1etnus8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d322fbso39275485a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076696; x=1795681496;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/op15N+dk/kFzQiPKrVNKKswtw3ovipu+xGcbt9hcwI=;
 b=JGnj1Y76piW3/eGiPykXHZBJExASEJjlRDupibrnDwpbEEIOF9DO6Y+6pZvdXDCQe3
 YfHzL2yfVNdOK/fXRHOX+kXdIV23nYgaWGxLvkLkqz2pRzgy8Pj487rPWyEQcc+cejdX
 nBBiIng/8ch206E3CTwwv5J7AjiUH1bQKMXMLWUB7abkGSmxJlQg3r1/DfUzKPYcH32y
 l8+KWLzmMR0QgqaUlyBzO1Smo+u2SoTxosBTcnGC3irvoQfk5R4a52oaXAOyWnxdBtNS
 zC3pKLMKV3RvHsZc+MLtwHRvJFdnN+B7QmXmpeZ4KOPajVaQ7lN/Hk6klsKXUZ/KUO2v
 8Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076696; x=1795681496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/op15N+dk/kFzQiPKrVNKKswtw3ovipu+xGcbt9hcwI=;
 b=aHK6I2Iimr/7IwVywBCcCzyC62k1VQ3u1cgh5BK6rZ+ZdBrQDA7IAwNxq1LdJirmvH
 UYB9LC6L1E7FlTZy5cic8zTwQdLzATMpDjGqCUe3ctRLPg09l6xkUc576vv1WwVO5VSR
 1k+/fc+xPSfBjLY5qezuPWBT2fccSBmTL5uBhEgD7FbsU8yuUZjPtwDy1sGDrIRkp5IN
 5x1KbdG933oOvgzVCcZlCWzEBcQc7VYYIdY3DMs+Yvn9PYuUDk+1EuK5Qy1PswJwdB3Y
 x9fYRIw+2mOyDfNZHvNLptoM8RK+K5ij9rvUPd8aJFXZoHBgpFPKZJjer7En3woj6c0z
 yA2g==
X-Forwarded-Encrypted: i=1;
 AL+hErHh0QdSkatMsP3xR8V55h2kQBBkoYInNr3C9ZvdOP9MSkv01gu5QeJiYz0zqYmxzuWoJXCX6i/pR+4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zQ//90izBkS8uXh3f307mjkDP/AdXSk3UHnh6n72ouYYAWUyz
 C/UsLyZYHitBe0JT5RRwzGu21Ee7Az39AxMFj7z4PJPF3FhwngPXmi8bFUnYjH3JjY/x1KzSJfF
 fpc+BuExcA15R+xORHUPK3yrAEyU96v3CYmsuCtLlLp7mbUhvU1I4KM/CxvCrWi6ZA9B2tiQ=
X-Gm-Gg: AYBFou0c8zPcHmE3cAiyc4z1bIRi56TDpBezIUZo18/2VOBklss9d91KKDoIUjYkMsg
 9f3h8F6oQgJePdbJC2Nw9/ARkUuaFyaPAlr9FN7zvuxLdaux961YftZv6MPJWK3IKX/H+ViCXII
 0+tAGH+u+NBfFVQ8LCq5M3V0k9ryLQD4EGY1XRJBSes30S4nt74ULjqm3AtGJmQPkj7ilc51PHm
 gEgM8gGMdigKQykiH8mt6UtP+oKu6JuEgpBEOjaNt1G4E74HMJumJpDvWgOWobxeebji4nJTxXT
 opGSsBZlUT7dEFvAwd6VTMPcjyCSMHio3ZoMTzCwepKl8fzi085qkRZivybv7GtzT7GJyESO85k
 5hvYR4E29txDPYC1QPUsY0BZwIt6uy/k2dV786D6FuIqi4eY1NoV1rPyzPVNKIgE11DAJaly7Ay
 8XBexnXYcv+A4pJ2eIxfzcVkVShiM82B/NCN05
X-Received: by 2002:a05:620a:7008:b0:949:326f:bd2b with SMTP id
 af79cd13be357-949995b5a7amr965123785a.43.1795076695689; 
 Thu, 19 Nov 2026 00:24:55 -0800 (PST)
X-Received: by 2002:a05:620a:7008:b0:949:326f:bd2b with SMTP id
 af79cd13be357-949995b5a7amr965120885a.43.1795076695233; 
 Thu, 19 Nov 2026 00:24:55 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:54 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:07 +0800
Subject: [PATCH v9 05/29] drm/msm/dp: always program MST_FIFO_CONSTANT_FILL
 for MST use cases
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-5-ca61be4edfc3@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=2543;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=MVPwEB6GiAIVVN89kkQvG4WB2TiaPNUUb+TMfZpXjic=;
 b=H4BxblsNZpj0t6p86OkaQw/cMiFN86vt41iSqzygdVcIGdXJZpWYFqoTsc+Uvp1VvGnioKTvf
 +5GIKAQ9BCMCOmy7mbBPGawtxlB5deWwLBtZLZzekhQfzlrxHo+smPq
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=b8UncdGx c=1 sm=1 tr=0 ts=6afeb258 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DrI3pk6BOGKCoqyvp2L_zoUWBCbJX7X1
X-Proofpoint-ORIG-GUID: DrI3pk6BOGKCoqyvp2L_zoUWBCbJX7X1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX/0PVdbrXgWIB
 7c7bdZUu/Zh6DfZnHEHHkaY+9VnMfpnI6VilQTHCVFl8P2G2OBC9vHMDK6j3u4FPVFsWxJF1wTE
 wph0SXiYO3QAA6aEIifxe4Jz3/E/1Dg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXwT3bB84jvkJQ
 wWVOYa6kvnPZ6Tf604MkAh6HNvfL/Y88x15LVR8ea9+pSk5FdTDzjx8JodXMV0IfBXU0h9W9Mci
 TkxzAeD6t5LWa34KMP/H6dbh/ipPw/A9VVQyTR9IM0EeUxfA9POnVzqIqsbu2fZl5/cKWCx2uBC
 ED+5OnMiBs0NSyUpAJMNDbeDgbEiQxnWqJ5jHu60fy+aIcw21SdlJDsMzCXaBc6HHH5I/P0zt9K
 amCcZ04VC7IZPxzwy+6MDbNTHesypqi1EEbb6enRBzKMgLlnlNlIGfkQ/NyRowkb8C01HFwy+HM
 pMpJwjwByAdOeTD0OBh9nWWpnZdLYHQzSXI8DkLIeKajlrm4XJvQkBOXRBQjnS0MkA5y4ZI+Ovx
 2QBaDu1nvn0jWgsLA70tplShRD1ly7Fipga9j6yXT1L+wwzRz3ViZYsgqU2hWT+OjruTFwNWZj7
 zSmWMS8X3Ggo/0HnhAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

As per the hardware programming guide, MST_FIFO_CONSTANT_FILL must
always be programmed when operating in MST mode. Ensure the register
is configured accordingly.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c  |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f3f97a800a738..a3aa946c24257 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -584,6 +584,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(panel, ctrl->mst_mode);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d3468b73fdc32..bc7bad5ca3b18 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -741,6 +741,18 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	return 0;
 }
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en)
+{
+	struct msm_dp_panel_private *panel;
+
+	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+
+	if (mst_en)
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x01);
+	else
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x00);
+}
+
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 				 const struct drm_display_mode *adjusted_mode,
 				 u32 bpp)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index dc046fec24fc7..04938b9d2091f 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -72,6 +72,8 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en);
+
 /**
  * is_link_rate_valid() - validates the link rate
  * @bw_code: link rate requested by the sink

-- 
2.43.0

