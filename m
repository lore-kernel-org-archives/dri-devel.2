Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70751C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92D10ECA4;
	Tue, 29 Sep 2026 04:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8nIrBaq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F4a3kIsi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157A810ECA0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T470qf419561
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=; b=S8nIrBaqZAT6zR0/
 ij379S8x35yUoJJr9fP+l+WLN72Vej9XCAZaYNjzjGI0ufr1YUKyV8LgGz33RTqV
 qapHgkCteKLLQM5ChCF9pJkQgqjaS3M049xn//ME/wfmZXURtD5SDrp44JR8XJsX
 oKPxSgxmNqa+0Y+2M7Ta3KUwVSRf4dsRlmSYgpa4YVB2dJn7KoSzqmnGJIX0fv/3
 bxYv3KzB48MIFxstr9DjWiuNxOWIYSEWgXvMExe/GUXu9Y3OOMgt3NHf+/Hnef0P
 qTxU2HGQjdV67wmhU8oUp/Nxvlq58n54u9lo4+H9ovACvMAeHiSsKQDB7BGqKlkY
 s0ws9g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmu9kb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso88129546d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656036; x=1791260836;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=;
 b=F4a3kIsiOMe0GA+QPJqpGAvpFjFukDnhzwNrCDbesDcXXetqAqZkTfrYpYmA0Yp7s5
 Kn+saqZeLSc6TJJEMyIFEb6rj8zXxxGh6lsltHNDgMm2QJXT9gJZqVRoLbX+mIkJV4C3
 /DMHSLeweNcfOUTI4BD+RwHKZReMvMYU8woRmYcw+XMX0LLZSUpj10Pwjzc3JU3Blyj+
 EckDuyhbm3PWSkvyx/I/OPXEQkRSRyeEh0IUlnDTEKYLV1oYGkgObYc58kIuCxyWeZEA
 cp6JLPktxWbewggiyVxbmXbujyV3y3UkLIBjS5A34UtdRwabGAUeOI1wrqJE9dRz1/pk
 ylBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656036; x=1791260836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVWiYFGWOQh6WJuSIdom7McLyivYPD7fTLAp4LYIpOU=;
 b=ynjSn/GPpNyJbjl0MRuDw9PtYPmqPF/6TFNhdlNM57ziTw53cXHHiVol/rEKl9dVJ5
 rLKmpdfVk1bFb7WVDFG/aPQpJb1CZ363rb6fQUheQk4h+Z2WVflSF8p+4PiTMTj4qKss
 6cCn6rIzydni+XjVRCoi73OZu+PdJOZ5kUpxzgSOLnVtU5uMF9JfM9k/8pLCNXpiqCd9
 fCoYIma6IcnvwImQZGHV3I8uhhcNiu3t7zsMsWqa2j5G2iYKHzxanNyubPAomP1GxfOY
 MyMcHshqQ9UCnUWJQ/K4OgRUmi4IXpvsx7UR0R0FB+/C27wNejgvLy8rUfZxFaMq2QZA
 2kXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRHAd006TeUICxc938iKFzHStr5FezOHzwQ4ORTjZY3Fdb71wvYbBbZklYmT6BdTMu5OXX2F+5d2Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK5oG7U/lsxvMK6RO8fsvj/p80PiVaAfUKIrsKNKcW+CNh00Sn1
 sAHC7Mt5gnb4EtFWZnM+smRgAuj+mgIbF68u8aAPmNoinbW0QMq4vd8CO8i2jbDWpY8ND/mZ8+A
 YUKKkB1nzp7Or4Ea3z8EZBEcY1JwB9Yk0dACtuQBM5HyWAQHjqwOT0eZoN1mvjaYL0sXXyuA=
X-Gm-Gg: AYBFou0J93ZFyxXx9sbXeC3EDHrtPIrQH+RNII0/hiodBOS8LGLWiKBaUE50hjdsKU/
 3Sm35/UHS/P7yfWE6Q6Id6zxIuRiOVtFI654VauqvKyOulfSwmd1eI7yx3hjye11SLBRquMGawb
 slePUSUyAZtEKZRV0K+QW+3hJQJ5FJhTEx/1iPHt5I7EW/LPM4dCSsBw8nPJwRmp8ZwZw7xCHMA
 XOjChPUbz0Zsh+MTR0xL3ww0q8yvdXh0E2jb6FNvHMfaDH2aebeo7QXEfs5fOrtU+oOA7F+1FGO
 /0Uc5bh/Dc7pdQbsb7VWCPGyOHqAABTTHX91FWxUwGkfLIzwu46jUVbxEqR01Xg3S5mntc7nDjA
 cDC+kl4pcavzCbQ7T9Mm44tlESjKY9py5D/GEd+rtfpBDpZznueMSseCrdQuTBkA=
X-Received: by 2002:a05:6214:31a0:b0:912:517b:40f8 with SMTP id
 6a1803df08f44-914324b441dmr236159496d6.42.1790656035689; 
 Mon, 28 Sep 2026 21:27:15 -0700 (PDT)
X-Received: by 2002:a05:6214:31a0:b0:912:517b:40f8 with SMTP id
 6a1803df08f44-914324b441dmr236159186d6.42.1790656035287; 
 Mon, 28 Sep 2026 21:27:15 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:15 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:34 +0800
Subject: [PATCH v7 10/35] drm/msm/dp: no need to update tu calculation for mst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-10-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1019;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5ZzC8/kHjYiASM/nz9B0eCAoNtT2xRTSonPMA7SeVao=;
 b=3Kl91+chLdEIrP0RlrnuzXJaUuqTMx/dlvGg9HJoRZVD7BSv/O/EbvOkCnmi/WM+yjZbuDzYD
 Jr+qQA9M02CDbvjUoPiMjGicRy6AhGzrUTQTprW7GTrqxzd2Coqxt14
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX9ZvXGtrtthBX
 4azyb9shMODtZ1oG7d+Qyu9DE3TetboN5zvdBBjmxCxAflTd2UShN5iNwGARYXBlVuIu5BVNk3U
 IFQtIXrS9yvXhyYyxMWO4tyinnF+xI7qLbrgsBhNAcU50JAs+kqP7qINujajyEf8Hq4CRJdy0Cx
 PLXtoZp5hLuKHu5n0qWKcmHkCVapLpWHRfN7NOjsKLwYM5d443DxbPOsYmF0ZtWZtK4EURLnvU4
 ISgedRVTdduD5+0RRolfNQc1KuZ/zVQowlRcbvzTY+HSHsbLtNzheKX1/2yRbkkNzH2iRY6KdFT
 uKoJxmIVDKwQnXAq4id+JJLze0TGx2oF5iLHPhSG12P5f28/pdCwRdoWrtJZRrdt6KBpK7qWW+a
 /5QRkbwmhZi+MW3GUAJZT0eGVI69CNVBdO08rgHGpIfsn/clnQJ0Po3D6/wcGqhLJosTc9Aw8zv
 A49zO8ENiPDSHkInuTg==
X-Proofpoint-GUID: d2JEqtzDfuA25ulN9h02l0KJM7TyreE3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX1hLL9i/2SZQb
 lZEEoD++jVM+leFwVtblXttTvihtIwtmnAgSbmmggZrosrkv3B1z0adGPxrfJ9mjoKpWak4+WUO
 xJzIqvwVnq9nZlae8J0T1lV4wtRhHww=
X-Proofpoint-ORIG-GUID: d2JEqtzDfuA25ulN9h02l0KJM7TyreE3
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb3e24 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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
index cd6ae0d5372c..77506e840883 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2703,7 +2703,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
+	if (!ctrl->mst_active)
+		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

