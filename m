Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005D606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mqYNgnt1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=guTCfPf2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF16112175;
	Thu, 19 Nov 2026 08:26:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFC0112158
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vSEt2671967
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BmT4WgTDWT18+4Kh8ZkVb7GOYAc9vJhp+8b3rcFZwLI=; b=mqYNgnt1ihyJitfD
 o4liAA+Ong8B8jJITRvJjay0xYP6nRThep0pAOfItFKXRu1dQcMBpu6zLsa0F/3T
 QPi0aomJkXgTmCxvVMSps5noh37lZZDhH3/SCMqnWsfdrl/pG8NYhPSp4RrqgJGN
 UdvjkkVfc7UiQK6U3xF2JSkb05TBTMlXqSuxTyiBIFGiDPISNLrlxbF0soNYmSe4
 VODR+g+wOstLwU6vj3K0wPemNE1MGv33MfbwRp7Ecblqkd3mELEiaSCahicVSHMq
 MkrRtp9c9WjVP4cizrma1xNeOjQ8w6YipagYBF3gqjkgtI1yhsK8PDw8K6bw8vHD
 Alxmtw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3fye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so455151685a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076798; x=1795681598;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BmT4WgTDWT18+4Kh8ZkVb7GOYAc9vJhp+8b3rcFZwLI=;
 b=guTCfPf26RdF1BsJGJE723yZ7ZlawpSggHLnVNjI7BlB83SUcoiwj+WzEn1yKovbJ1
 IatRQj2AogvfcrhxUxAr8TA+vOX98l6tPrMfiq9RmcIXqEoiPbWzscrnSS4eBsiPZaai
 H8Eta2mqTPH8UiHBTP6zoXCpKmk6fegAT8j5aKdz+3/OmKDh6pqBWct4Q5wqh9/wLUlw
 BLpS3mWjuoB/0k0U2pxF77ufdXksxFw04bTruP24RUyPld/xYwtMO4/lv2IE7bSM4fOz
 7yky3sgY67Y5anFNRz3I6f+eAoyK9D9tx8KS4K3IguB4BLHWQdTjNeWH7BiTTtZU+xQS
 2azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076798; x=1795681598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BmT4WgTDWT18+4Kh8ZkVb7GOYAc9vJhp+8b3rcFZwLI=;
 b=o1Ht8LA8GPR+mMPirz/bjriHHIbVErz6oVpIKOGW0T1ZR3f1wMo1WNHSZZ1GgVhBPc
 cq7Lgo4NY6sfQ5jBBwitYUfYeZ4ss/BGEyejhcCgOy4nzfBkQAVN7kSlYSME7d+OHKmX
 8H6UF4YMuq2TCT+wWTRvUyx5mTQdx13KMSgXHUzhUX5y+O0FUu+LQAPlh39NDfKiop6i
 JtDW5ob5x3xWJLTRZi0B4p16aWeDPJZRIhzK5sjp9zq94lUgeGMPB6XzlTT/7nUnPxYX
 WNJOaa9nIJWHihAJ11Y0xxHhFCUs/o8yyNwA8SoJ2QZYioQLMO1yIyDvN9yxsmnMGnef
 d8Bw==
X-Forwarded-Encrypted: i=1;
 AL+hErHlmaqtIUNlI5WxbB5BrYdu7ESSfW7Zh7Jqzig8OY2hjBWr/rKiBSG8kpMuN0y/DvnbQjz1zwagyiQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NdKnbog5V2vcIACbEjG3PaZzSnx86D0/sT7WY7NlnF/MQA297
 mIONAiwkJQ0OSdrx6lsm/7wn2qQiVd9sedjQo7u+QZWbVESxINA5h30ULVSMhQK9jsO4BEbQDzf
 IbDFUBHqLwLUyJJpTGaDK7OL8an6Ix5sFzXCuP8Azq9GMqQvUieQ0/vWL6HP4g7YI4vh+Fx4=
X-Gm-Gg: AYBFou1PFSvIPH2NNr0bkzHfcEJ8Vebomi9z1BzKOGUnizk5FlmKb3N4d2zbrLxZ3XY
 FaEqWKZPTN6mPjQ7snuboojyR7v2uQOJO65xMDlqBqC08J7xSC/ioX8xlCVNBoY7NKiI62UnVTV
 8BIWWXIaRhgFh87vvkTcK5OvDA++WEdsk4gfuP+4yOkcUsrBKUgKpTC2lCJHf+Tx2/cnLlGqne2
 7JJ8zE8VMKi44acb0Fiirs3iUQ263/xQYHLI5Ww0SpiacMkeACODPSt+DgDNcah10G5S9HXiEt7
 VY9mBy4iGr+4Wa8x4ivr5MFNa2EceRWFMwEVKtjZRr5PZsTas35wn1oj4AcA6eCZKjVlEDPTaNw
 8ffzSP1xgoT845PBwZfyX2jmucm61zJCWZv4hFp1QfOKiPtYz9JTNKyKRNBgF6fQWY9AGVUL96r
 sTpdBOMnyf/AR6+C5S62ggP8HrxASPY0fgyMkE
X-Received: by 2002:a05:620a:608c:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-949994b44b7mr855109085a.2.1795076797896; 
 Thu, 19 Nov 2026 00:26:37 -0800 (PST)
X-Received: by 2002:a05:620a:608c:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-949994b44b7mr855107985a.2.1795076797565; 
 Thu, 19 Nov 2026 00:26:37 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:37 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:27 +0800
Subject: [PATCH v9 25/29] drm/msm/dp: mark the SST bridge disconnected when
 an MST-capable sink is present
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-25-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1383;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=smjaZ/vT/tQUxMxQD/7GfIpJhvqfExIMSEY6fhh3ViM=;
 b=lkf1jB2WLX8xRaINB/7tk5FQ4sYX3U8Xl/o+IjlQnqQmQtdC9BEDpHM+jn2CmhElZJgkiOz/b
 IuV6tPC3rl6ASvvkD0wKshj1a3LDEbbr8Zp/MemXPwzbibAq8REqvi9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 29FTQ5tJKdU_WxkgY-jdUyG0UKa9kLfc
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afeb2be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E_DJWZ853T03DlUWG8wA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXwIzHs4X9nqMw
 QOIOhrQV5x4K2ODotI8MrDXCov1neYtIHuYxmDlx1HqayTL01swfLstyImgMVE1w2E+0dMXLjH2
 BfweyJdF+MhYN5y5Wl10x3cxu+PjCsNiNbKYAhFyVFAqkkYnDX/oWFTPpmRARaofTmfC0M0yDjw
 l56SchR9Z7ZmZb7b8JFr+gWdnG6Ayy/qKyZDoMaXPJs9TKIWXrdAGVsVCxetEdbcRi9EZEXFNCd
 FILofXZfLskdRyKl2z6Kh9kZRM3OlTHFSmxsEQBIwh4zh34+Va/trP8MeDZzBGGoGbYmH0MDigx
 QNSUEWTeCIK55aJemINA+nPMxtB5i3afhVZLbaMKbgtTl3fvDBIuFAUQT71PEPgEBzoz3V8Avtz
 DnNgyf0M//4AwX2CIq0C2LlDnZNYnzAcLoDOzoUWVA8q/VawQeAC0r9Iu/H1WTbT34Hc+NjZZQz
 iHMyvA0JPDey2voBU1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXz7GZKpwcRiBs
 pGA6e+v/Kuw89uFb20qXTDiZGK1IKizMWyda2poqaqya4UJ1r/e2CW3LQyUCIAPbixFHecJVYWk
 aMzofpuks3HNuYJ8D9/qxPlCLjF8/k0=
X-Proofpoint-GUID: 29FTQ5tJKdU_WxkgY-jdUyG0UKa9kLfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
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

When a DP cable is already attached at boot, msm_dp_bridge_detect()
runs from the connector notify path before MST has been activated on
the sink. The DPCD capability read at that point already indicates
that the sink supports MST.

Return connector_status_disconnected from the SST bridge whenever the
controller supports multi-stream (stream_cnt > 1) and the sink reports
MST capability, so that connector detection is handled by MST
connectors instead of the SST bridge.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7f5247cbae03..6f1f9dd3660d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1063,6 +1063,11 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			status = connector_status_disconnected;
 	}
 
+	/* Mark SST connector as disconnected in DP boot-up case */
+	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 &&
+	    drm_dp_read_mst_cap(priv->aux, dpcd) == DRM_DP_MST)
+		status = connector_status_disconnected;
+
 end:
 	/*
 	 * If we detected the DPRX, leave the controller on so that it doesn't

-- 
2.43.0

