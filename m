Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C48C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD0110ECCB;
	Tue, 29 Sep 2026 04:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckeCrnZx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LaHGdqHs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B78210ECCA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47i5W4052976
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mFMehukAqEhgm8Zxo1p6NeadQI8Gqa7siR9Yx52UGMk=; b=ckeCrnZx6UmRwruS
 bmdUpUbee/0XMGzvZWpJ8DJa5pCVyI9B1n0XyHpZV9ZuF9vGpzbHkLs895l836Ek
 qLHVXtJxPDpTu+9N8lmIUcBs3S90LowZZCkPsDi9tcrpO7nXap127uA5AAfw8fga
 PckI1l7yWhKzCzRsnzI8Od2Rf3lbc6rTAvgJQHvBRiy9v8mMNNjHF6xLHmuAf7Tz
 Ipuo96GY5rChoDz/GIucSLRUSFmGHX8MHTxUQBSicprc2weB4zkbc6AZ8Hl2l6xH
 tkt2f47uGX7jT8nBlJYUJR9CkoNvpUFsgsRNDi4ZAXQZBR172ftw1VZwm21avj5a
 brqvVw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2jc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-914355c5a51so68854206d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656137; x=1791260937;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mFMehukAqEhgm8Zxo1p6NeadQI8Gqa7siR9Yx52UGMk=;
 b=LaHGdqHsdk49uMnnQG272c/1n/9RgkPnQVi6VOLcMsmB/MAjVPQaADpC32vKAA4bBs
 mMCvZBOGWYBxaxKxMTSSgz3TxYWfJGMTK2zO+Wpb+Gny27KDBceu+rC0c7qFZ9KRH7dP
 16SVezJ71Qz3aa99Z9S0I4ELiQP3aQl8pyBl5LXkh9cILvj68UJ+BrxZBhlyL3YXPUqw
 PXHkUB11NCGm1TdNvgOFssYpYIK8qcrqzA6/a1gUbFmOQDM+lDNPfe1FgS9a8Fu+4ebD
 XKZVu1G6bBCQSTh7LBHvcsETghaSMT49Nkx4Vr3wneoD04cviRmGZzGSPuT2es9ctFBl
 Eyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656137; x=1791260937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mFMehukAqEhgm8Zxo1p6NeadQI8Gqa7siR9Yx52UGMk=;
 b=mWK0ryIZ6Bcf8dB5qf5hFs3YCYePJFE7HAW3vMESLC7u42lqgeIYE6c5KiHxcIYmKO
 FscMnHLwnqi+L2kWCkxQau6I+VuV+/ZOGki6GB8GLMKRnBPPHSHpmRUrtTvcvaDvEgy+
 BeGTt4dfOE6GzJu4J2cZwuzf7fhVb3fXLNOfPe4HHgRVE/VU5PyvJ5CHfL8PyAdXJsWQ
 iPreY26secTGB99sRmHZKNOinUNyGt3GT6olvNatDP+JqAa2o5lbglUEeySEmF7NBzLI
 bvKa1tKpap9zVHtKd3c7htH5t6KfMXHTdKsDl0YkHMeaXE1U9o4Y8Imo2mBzoMC+SBwA
 LMYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzTGJxHANXM4fv+kHiVxy7Y1rTsHSAXy+BvejY05J4Oxk/XXmugscLpY74hjHKpvdI+cW3fG/vdZ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+oU6mbPuxUluChD6fIHeDio8U2+lQ8iFA294bOwy1wo6AWkLv
 cXlfYW5btPCYnuJukGcIRmzRpXXo3VFDgnLWNS9RxHSisP9Z+dTu5Si6HgB0DzPDuCYPMbRMpla
 lL/phlEWpikkgWGi5M0nRTR/sJyRQMx0W2kHMI6c0vKjZLU9lh9aUFZFVcZ0RqJgg78134mY=
X-Gm-Gg: AYBFou3KdBXSCubg1MygKm51sH61MC3ngWSWKY1i1XJTAATLB05tNKu/L1XdwkC9xzZ
 BqkstZLrO8Bq2eiKGHqZJxsk08dgrIABPFoV13isiClEqLVqFqiWTo/RfvIskZVUszrWCqW14w5
 34F1r4NWDxzV464u0pkgsRJXNjOOBSnGlvb/P2T0otffMOLqo5/NBP8g8MZUaQKcpqc/tJOPbZd
 sdsCyjvXkhbRs0zqbPkB59s5/LDuiJeGzyD4n3C0/nFsgPEqKJhpwFrBsGfjYV23aMvER4AfF+j
 LMViWxnEI/k7+EPVZ88gSJLmUz2kQzm7HKfz6J7HUHRjoA2fDjtfyJ4nxiAPyfdD0336NyF64zX
 EXIouo92NPoXkDA7z/0MC9nTcRt6DZokVvVPIf3j7DbaLvRYsfI9UJEPHdqzePWk=
X-Received: by 2002:a05:6214:493:b0:912:517b:8f5 with SMTP id
 6a1803df08f44-9142f93e82bmr240773486d6.39.1790656137486; 
 Mon, 28 Sep 2026 21:28:57 -0700 (PDT)
X-Received: by 2002:a05:6214:493:b0:912:517b:8f5 with SMTP id
 6a1803df08f44-9142f93e82bmr240773206d6.39.1790656136925; 
 Mon, 28 Sep 2026 21:28:56 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:56 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:56 +0800
Subject: [PATCH v7 32/35] drm/msm/dp: mark the SST connector disconnected
 when MST is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-32-4b81473185e7@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1197;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5htyHKHCl9o+PbYW78BpjyfMd9ftMyBWL2GavIFT4qs=;
 b=Htcq/cd08vgiwo2WZz1Ns8qcJpcWLAGy4lEg9agUz1Lj1glaG45ntMYmEWSpK1P4kwu6DU6Y+
 i5th5qSz060DrXvDI3dIYnXi72pkGHgLrvNgR4ocWHilfZY401bSd9Y
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX38qWRtlbrVVt
 ZR/tlytnkGlMRsEAnoAEt4c1+c2wmxdJzBm9tM+aaKOhzcapdw1TkD3VyJ7X1SHziptRgW12xns
 CIk10utFSXt0Dc8TaSQyCtuX4SSyFC8=
X-Proofpoint-GUID: ruyHwNIgB6ZYe_0ycrErGkWetQePFMBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXwtyf/+BQXp+m
 7GR2a096hmDIbTtKMxLJ54lmjF+FvibpYXW0qJck5K0LlFhsGKSMxfRGoLiraxrXuh/EofXgjZk
 WBYzd2+qNZBnMukbW2knvg5nTz3nG9NoenzZDZzuhbXlyNBwRP3xDCwxOnXiRxN5ApoRL4eLAkc
 OZTE8GdK3IuGRQnFHfkAdudRVRcvEBWtdigxQF9LXo+YURxkInOZsd+nFKvYcTmOyW0aLK2WRcM
 IquSP8SXXtjhc9kWdPkQLJ7HWgLHQ4e1kF/xp1u5oPeGT462sZPPhVlsyCle36M4Y7tHW5JdDQC
 sBT17izexuNAURHtpECqaKbmWWUQn8vlimVE/ovcxqsh5Ly+0TtCyd7X0sJ36kBIGtZ7Yp/ic3j
 ScImHN6JtZC3mUQtvthNsMhoJPUBF9zubUajHz0zpiHeWqTdEHHj+93jpBENYtM2UM+Kutmtd0Q
 aWaQlF9M0O4Al46xsXA==
X-Proofpoint-ORIG-GUID: ruyHwNIgB6ZYe_0ycrErGkWetQePFMBN
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e8a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VuhzylXr5gTqft-DN9kA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
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

When MST becomes active, the initial HPD plug notification updates the
SST connector state to connected.

However, the subsequent SST connector detect path reports disconnected
while MST is enabled. This connected -> disconnected transition is then
observed by the polling logic and may result in an unnecessary hotplug
event.

Set the SST connector state to disconnected immediately after MST is
initialized so that the detect path does not introduce a transient
state change.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0e8181932c27..327777f5c95e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -290,6 +290,10 @@ static void msm_dp_display_mst_enable(struct msm_dp_display_private *dp)
 	}
 
 	msm_dp->mst_active = true;
+
+	scoped_guard(mutex, &msm_dp->connector->dev->mode_config.mutex)
+		msm_dp->connector->status = connector_status_disconnected;
+
 	msm_dp_mst_display_set_mgr_state(msm_dp, true);
 }
 

-- 
2.43.0

