Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD917C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041C210E722;
	Mon, 31 Aug 2026 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBZ7MiyA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fx9ECKIj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322B610E710
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xNfV3018224
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=; b=fBZ7MiyA/wcyQEAH
 cLroINa44aiJ/v5s8hKlUPt8sp+WYUhB9dSe9KajSFDP/1WhPPGE3FoJCVXnqj6Z
 F2B/8O3Cnh1FzUC8tm0b3ysN76gaRbG8Z/JGnoK5Nd50wr1Dkh7ZbuF1BZhnZQ++
 QSR3jkPuDdPIq6QjCLCVVKdSEXxYq2IH8EixUEN8R0QjjPyEq60KQ3QzZfcsUviX
 O2Jle/Iap8q+EO/sMmEUbEy2kggSWoLMbVaM22GsTOMf5ZRsSBZr7UKM/kcHJlE2
 Dmvon3iOWiMjEkQlpa/WRoOg+ECBuADMmhlM5ZqlidTzLap3PsAUojDqLvkYCz9x
 6gmSIQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqn2ncq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e8341cfb4so24942606d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164313; x=1788769113;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=;
 b=fx9ECKIjGUVtnYVB6f4Xi0vtHt7RHEfBVIvc0T8kWdGbQQjfdI+vxZKnfykLvJRgLA
 IVjn6O0oEjzZEOPLEs2IiSkFib7aw3UcrJiBpL6Wk0w4cbvxvbYJSxFYwffR9V3HTV8k
 W/Y/henKKoeJBuCA3Hof6Y17LWQk+17NjTWP9f5qGnFpI2LjBAjQXCN2vHhppXvvnQUL
 SuDdNNpDydnDqkYbKCZh/T3k6hLzUXLGamlEHNte/6qFpCGMS7xi4bhTF89fMFjQEEoS
 mQIfdaJmoeN8Jbyr8733cwGQ4qWbEITmBO/UeXWP2mvPBX2woTTUtvihc7v0nFC57VKE
 fVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164313; x=1788769113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MG7hWOfh4QGMHVtzXUSFpYHK8rElTo1Z2L8fJrvwBMs=;
 b=Wosm4ntiTiqyC1VUE12eaFYytJkI7la8X8ddxi2nGXaiC4oSVJQNjnTN1uss7BYk8j
 x9LKuh6KTCKUllxkLqf8KhPMq5tqzU9xJ/e42lj/kAHLH87B7OMkDwrKOzU2yNhszrBf
 YvN+8B7mGHPU3fzGGnShbW/84XJNd9epa20sM/PkmuahFJDcoY4Gpv3cY690ugvo+3/I
 Bm6DCgQ/9n6k/IKs0MGL5S/7eaHrV/ANuWotGJsbsHyzQfSskh/8GGCvx6FXJILXrnaX
 8lQpjYrwtNIuaiG4AmTVkq629KXjZDuPMagV+35HT8/9568+FJRD0+VFTnURXDXS9pJn
 ghlg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rob/QM4COBtYJI2R3abUSV+EDtnbjc45xVziSeNBFuJf5okLQLAdhznYTGktlCkYiZeaa8hR8EnGEo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kTsYb9bHAwEqx5vjnB3chRAG+NMDWYcx7Ufu/hJDHjKeDKCR9f
 NMdcTIPaGE/iUiouiH/i0RZqiA1zAVheEZwRoqbnq0zDxdjom5MIlYDGlXYP7L+/zHv4+yVP4+f
 P407cATh8vUKVN4FTn3Z4j1GA/LdcrE/LXVRItyKBu27hauMS7TORpV5k4qpI1jX3ZEeZHvM=
X-Gm-Gg: AR+sD137PgcP6Jnlg3gpkIrWLSxIAawn3ZN2F3EN4Ij9HwrHmIbUvDQyVntP7qJHbn1
 3QsKopzgaV6DHXmEJ7e3QqHzmwRcBJG4D5MLifMw5q7icKR3iKaptDCSXwI4RZUkxdTF8erudzI
 ISZ5dFckOO5on/dI/DYK/C558iLRXnLnltfioAHlnnVY+4/202zdRugPbwwY+3il7wDWQE7tEKF
 eJvYatrhIXO+IR4i7OIPKt97rcJa+gkjy5oZdW8UzN23wtMPCJHGXSGL1n5Mu5wWGz8nzXlT/uF
 cFRfSoN6H9qBJ0PxINJxJX/7cWVW2/rmw/NpSw50U3ORf+eFqjoqkUxRMw4F3qXaYjZFfKvZlqC
 wa9YZrR6mZ/Tw6TCAbdUjrWHn0aHtuyZj2lTnEn0q0gOHewGZ2ZQy6amxtKR8gLw=
X-Received: by 2002:a05:620a:2308:20b0:932:df7e:b31d with SMTP id
 af79cd13be357-939137d104fmr2188034185a.12.1788164312670; 
 Mon, 31 Aug 2026 01:18:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2308:20b0:932:df7e:b31d with SMTP id
 af79cd13be357-939137d104fmr2188029585a.12.1788164312069; 
 Mon, 31 Aug 2026 01:18:32 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:31 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:28 +0800
Subject: [PATCH v6 11/29] drm/msm/dp: always program MST_FIFO_CONSTANT_FILL
 for MST use cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-11-c91d35d6fb9e@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=2539;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=mtZ1HCvBc/lbpNSY8CTLdvHlrW0O7SuiIwZF96PT1pI=;
 b=STO9GwinFhcQSFq0MNtOu3KI0vWHHsIUt8A6GJA77uEm9psDlpyVubXkRIn8eJJRV4AXy9qsO
 N1ponTqrGlKCr5PxDrTcgo4WEZlcrnwjV0nY/Jl41/oCdspYwXbBZWF
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: q0XyVdwDmyx2GZWTHsokwLTV1p2JqQcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX9pzL7JnZ0olt
 B/8axpCLqA/70pQuVzSZrPJ9iXZ0KzhqXnp2GV9XV3B8OXNVQPolOqlogcLHwo4E5bjJVWhoJfR
 D++FApwa3ay+IO37Yf2rfuBAVoz0xmdNFWZFdO11gShYL6fAX5wyjBQPDizKOXCZ0mpbqqYeY6Q
 S3P6xyx9JY4w+2YDnycSjNK5ApxznmaqDKfBzZrq4+dv1YH4rhGcM7XdC4uCaYiKM9xts1DKcoT
 5RIZMxWqx5zpPJE3qk/vD2cuwuIWbIumxGTXjq7N294kzZsej52pL74pHVXXe2OjhrSdWBYrSFU
 tbTPV07teXb/dXISQaCvwTqFNd3DsFncnxUwt5bUx02hLKr13zec/Xn4J9FRcaGyOLvUYUfLNAm
 yE2+p2rlK2itu4B3NTfXbiwODCj64LxYE8VYUaXPusySfzrKeP/uXz7nRsrwK6DxphX2dKFFd5u
 qdRCmtpyz4zaanVkmtw==
X-Proofpoint-GUID: q0XyVdwDmyx2GZWTHsokwLTV1p2JqQcw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX6vFxxJ90lzJj
 mkk6FRQ1NXKawZKHBfU51vPUMu9E8+lSOzLLIll9v1ZctVWHtKL/ydsNi3hKGr9Pearg89sxKNV
 q3AQzCDxymdUoM4QhC+X6dzLpiy92/U=
X-Authority-Analysis: v=2.4 cv=a5kAM0SF c=1 sm=1 tr=0 ts=6a9538d9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
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
index 77506e840883..9a0c9737e6d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -584,6 +584,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(panel, ctrl->mst_active);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index d3468b73fdc3..bc7bad5ca3b1 100644
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
index dc046fec24fc..04938b9d2091 100644
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

