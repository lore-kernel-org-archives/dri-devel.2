Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WOepiCYz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OpLthaPs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDBA10ED92;
	Tue, 10 Nov 2026 04:55:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D45610ED92
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4AGhO679765
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o+4gC9v+ruTggTrvIA1zWjWIgQFEi8q477yOKxoTCWo=; b=WOepiCYzZxZW5qsF
 Hgate/qHVjDxmMGqXyDyC90/Wt8zeS335/GAom+5VaBwty1f7dHk/yBc0Y0odrz6
 s6WWcynpMO859vh7Ru049HK+rd739oGY3h23T7eKvc3QK/ux6GpGMCDUedmARM9h
 faZSdCdhHc+Dvl8zS+h/uPahvCipofS1NFkS4wBhHbtozYsE3xi++ymZOkC3/U9q
 WuTKJBM8bLAn8vlHsXHrAzo0PZcOmrSky21O4/lfI8yQI2txsYUBZBzuEok57LCT
 r6FwC0f62gCj55k5cG3V39B/Q6p0spN0Kjd98VhMitkFLkg8WvPl64DW0CfDOqRl
 0JyjDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv48d1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94776ee7bf0so268839285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286501; x=1794891301;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o+4gC9v+ruTggTrvIA1zWjWIgQFEi8q477yOKxoTCWo=;
 b=OpLthaPsrnygZcMHhBqpSr3yg/6z+aIatr0Zrt+u8oX2ddJQ+SoMwI8HfCqvke4zRt
 rAMXSNJQ2KMAD5v9xF9YrpYE0DSBJFk5rh+z9lnXOl5yKcSaba1dU7zhTGUn+0fz0hKL
 uzFbLCG+aie9i+N4TfErFDQ888RlMzBwL/AHyRa1aUvDj1210tC6R94Qf2V4FrxGmJMk
 yrstHuBHk6kF33i/WCeNQtEJutE5cuwSd1y7eq6ZFq1iAI/QhUsTZ+cdWHE1mZ8ejcIe
 4b7havH9bxbF2O+1dRZ5o3AJieo/AnE7mwgh79AztCZ8NODVXpHlky6+9xHlKyEJHPZd
 +X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286501; x=1794891301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o+4gC9v+ruTggTrvIA1zWjWIgQFEi8q477yOKxoTCWo=;
 b=ei48YjcFREv6yx5E1czIUZzWf7RWq85mzBcUlPyQ87Mt0LicQ39Ocuk/+ver5QS7mr
 Li/y2qw9HniXeiutvFUf3Dt5Lhg2707IUEaj8lXdm+QpkdnybmaVU3YqHzUfBwzchF0+
 mDbOX9h2zRivLzKdT9peGxyw7P/Tdh/1k06gZ5FJXHC0g3CbS8NZv5ExGc5cbBrZVABt
 7mYb/EXHLNPGPkl2Im6M3lDNCzo4bVb2V6M1gHx4YjBVOc4gViqhHEV9E4c4fShp77VV
 ofrCYAmR0ZZt42dkjwnSl9LhrK5B7J62c3Eggj/lO4NWK8JyYg4G190Wk6zGZp+Iebye
 cqNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGCYg36+Y/auaxc/OO4bqhnkUkKqwgWU1DO+F1iFoDIlsiwPX9HHUxMuI/xNcT8OXwpbE48lb3pfSM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/G7DGNmdoQztwdGn7hWtj2k5dsMD0zFImll8ZVUTZ0wsyhilux
 Zpse02OdiJ4JrS+4mAm32WFmHIOuxdY1OzN3chQ0C4P+oIsYg5MTK4fV1gW7C9KsdAaZ6Zd5yl4
 h1HaarRsFTaTck/XdfJboidosyukqamqItdAJsNqQXmj0RsyQgxfbH6TIkLcsRlExZvDshwA=
X-Gm-Gg: AYBFou3WTUrObiVq5ndl6Crxj53PY3sEINUmLhMYo164lCTONsHTs5zawUFZUhWKQIe
 38QvqNQPnp3CLXPcEDCrN5uXDs1Eurkat7W51JChXis1e0vFdbcNt+2j/L/ne8nxNklklSstuH0
 dYXtH4a3Vk6zVqMCoX3TUVYXuCTTVFHpl1L8gxMCvWZ8av2qKECfeO5CRpTD+Euaor3S8aJl7Pm
 IjWNskWywbAa8DXIQaFzihTQSnwo17jX8w9wstU1LIxTV8ewaMGnraBwecUaEMvzZsS8iOIjI/Q
 AUsuAxs/8wxqeSV6BZos9CDCAlWnU/ny/WxJ3SlEIS/kODlhbcXRCKD0egrmQM6Cc0GCAcpc47n
 P8SPo3OK+P1ayJgX2SD6OAQTETolByfwMCylnmA9ZxiGTUZUNxlHIKuVDXujONcTKgrpMMyTYy4
 6dQ+PrV92hn2JgwO+KK/g4yQwr4lht/XPx+F6p
X-Received: by 2002:a05:620a:4722:b0:93f:568d:ebbf with SMTP id
 af79cd13be357-9479f33ba8amr246376285a.75.1794286500846; 
 Mon, 09 Nov 2026 20:55:00 -0800 (PST)
X-Received: by 2002:a05:620a:4722:b0:93f:568d:ebbf with SMTP id
 af79cd13be357-9479f33ba8amr246374785a.75.1794286500317; 
 Mon, 09 Nov 2026 20:55:00 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:00 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:26 +0800
Subject: [PATCH v8 05/29] drm/msm/dp: always program MST_FIFO_CONSTANT_FILL
 for MST use cases
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-5-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=2543;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=j2fqlJcjMVtjRnKxnkNTkMekgG+qai5ABTbaNabRSf0=;
 b=ENcaNasL578wGbSz7mh3yjYfPh1SGMpHK+rUDVSVqTXgskgMTBlJ0hnSef8jsVtVVlCktM9aq
 U6l9gtc9IysALu77JpO0l+Gm1fDVQ7zLSJpYXu11eDyTTzXdaSK5S1n
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXzL68ZC3l2xi6
 4C4gOZHzIzgV32k0C3lY48JQisw0hveG45kdBeIHmb6kv7IukC4pzfPRcbO3Ji6l4LBThNAE82W
 EqsmciaM4jW9kMMDdaqRdh7SLb5yQ88=
X-Proofpoint-ORIG-GUID: bt5qufDDKx6-ETXVdlRZ30sCD9UUrduW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXzvWSCRrl+8Zj
 69xEApQbZgYa1pecBTxHgIg9gEvA13P45F8sjB67bEaS1hm86Pa3IYVcMws6N+3lSlkM0DEG9cW
 M5bAzkueIRIfiwjiXiERmTUyT0/64ykZdaZMOG+NarWs3jh4rtnoeiTkHRvgvIXmeBHbX6Sktjf
 7ziToFmfP6trP5ElIoZh603ZdeCAvfm7DzAJY0EeQH6U1gF0hlci5QboyeRr2g61rTYlnKfOwJm
 ZI1R2wamfCXKaT1ingFTktDjyIGWLfP8ilfDhMHTDUs91WaJaCtTgvOO+QtMuGXhpu2JJRVW7i5
 B7NNls1CDQUx+aPJnvLpPKB2PsleHwI4777xoA7DoKbUQEIcb086YhklVzrCFkaxWyjlyCEc+Sm
 Sg088tkXJXp+vK3fAwia2wtoodJFiAWtXqlvfJ9fBspdmXHZaJyo70WWZ6oFQgNdM4dttuhV/ZQ
 c0LCvr4zA3HmTF4XscA==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2a3a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bt5qufDDKx6-ETXVdlRZ30sCD9UUrduW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
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
index a7cd3c87cd7e3..249c818fe79c5 100644
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

