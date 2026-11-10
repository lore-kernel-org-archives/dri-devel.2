Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9433E60A2624
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jj31q4mm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OKpTczc0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18EB10EDC6;
	Tue, 10 Nov 2026 04:56:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399E210EDCC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:37 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A7s11957688
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3S1qtCn7UxWFRWy87zfGVw+9PWRdpRwaQRgJeQkoggQ=; b=jj31q4mmGzsllkPW
 oLUqZ2MbqNc1v9D2gFKfdPzle3uJghQPrHL2y5Na/tU6KwTFPUuAT+1zrgtGB9mB
 NPx0ngYElKDlccW8zp1Ms5CdwaBWdaP51zlQfR9IR8LH8PJrQhzGEc6pXGcEHngY
 zpT/bA8UyMkk9sowzhIQc6KKMacKI6u1p/HiWMqtITbE1fU6tOLu8hAxB0fRCTVc
 bj95zy7cP5De2M3NbdypaPbBQvvF10i/NKJOwXjq56bLEYxlvmrkLS5e6uATlU37
 WN5amoaK1sfiMEtn1hZUFA4mOFbJoI73OCJMUs5AoZWfAyYFnozRMS/O66eeDNkL
 sgJ5bw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydknmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94776ee7bf0so269012085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286595; x=1794891395;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3S1qtCn7UxWFRWy87zfGVw+9PWRdpRwaQRgJeQkoggQ=;
 b=OKpTczc0myQQn4Wm/xqz12Nv6j7ASINphJjjsiL0hsvb/qCMXYtvdSxMkm0/v3cIKN
 Ysah911pxeLqzTX2HognhEtvC0Np/hhuyLKitP9Fkm1OacyNJf/savmOfh3QeWSMubsm
 f3NOolcuosectyw1DExuBLQnn4tLEuxSsNy0LpmhcLABA3k3GIWmK+wJ+T7RaIxp3BCK
 gJ6eDmh8X6d6IlcpXWSwMyQ0B7uEwijLu6BWdBzXg/MU1L4l6TepUEs/U5YmH6qG4xUk
 MueLeVFJxWZEF51aNRFham4T/WSDoBlYxSU/n5fxYpxxHZiXIuymSNi2rNqiZngnBHsp
 RvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286595; x=1794891395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3S1qtCn7UxWFRWy87zfGVw+9PWRdpRwaQRgJeQkoggQ=;
 b=Y9xfVc23fVJ3ILSRk7cDKowab9Bk3eB+NW1vQBMP9DInNMdikZHXUIX3gluVS0LCEJ
 14UElOAkrGqkN7gO7Sx0gNYs6Xw4UlfTDM/THaJHNEPeQ+dfMzsm23JAy4iVYGENDaju
 g4dRsXEOWQ3pOerrOy7G6LzVsbD6v1LnbMv+hN3iTb3TTvKNsLHRjyXZtVIUtEP3wHJO
 nxifsV4glmiAGvZ+vOLnQmt8K9l1n6bcwMFj4tUuQlDryui529xd2s/pHkRHgvj47a8u
 AIb/6alQ+I5NBeVv1aWKVWS8wPjQLgYFbyo4QaAP86Ds8Yv9m45VFdjLhUFJcxpY0xdx
 TTyA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFPrib3nzyNQ7DfVK5WaeA7aTVUm93thB+MgGMbpIsioEhvA7R40sqUR7Ee/xgzecGYc0p6H0WH2g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QgrF4JeX297e1xQYghkroLzZXW8z0XbfVc5+/u/0xSaNQo4Qw
 Wx0dnmF4qfvz+2+fRYH+SpGJ34SXnwqUEyVf9Xgc8e4AvCoAmc0xrdwJUKLFiVtwHalDS1cHHmr
 gx/nCp+W2HJ3dItNjPjNUTJP4BXwVe1soZaHoD/ZlGEm7HjfkwJ485AvmSxprPCVonNdQYp8=
X-Gm-Gg: AYBFou3edBOY1hLIIcxl78wBXmgzH41Pr/i3ZRcbxq3Gmt8nzUvlfQdztNyALnIL/3o
 rFN7V4T2YRehhQlEL3NzEBI/xgJr6ymydq9awjFzvEDROuhij/b4DV2dLEZ/8pkfYNQ5yG6paX4
 N2KxXn0bjn5wF+vUgbYg8injkT1Ns7CiUgX+rHw2xhOQXfD4N9HytKuhYFrXH8TdLpLPS+12VSQ
 lgLbTNhCV99eIaJ+CceQTmGeXBd4YJNGXgrVChu7tNnFPo+irAsrbH5yDLoNpos30IO4l+LGCi9
 W7dBT2o5g/o4f14Tv5pcLjl+5Ngt41oh12r/9yS6GJzDaNND3qOK1z4asBYLUVw6OJTmg0ux7Sv
 rHK9f8C+VmoKOdzk6bGEovZAahc02r/pjSCxnRL5xbSP+hsEk3u7GGR436DA0b1UyBXctK07hHp
 laj/ptysO9L5S/NxpKYowARU+54ZmjUVg9/msM
X-Received: by 2002:a05:620a:2586:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-9479f1b9eb6mr278179985a.2.1794286595588; 
 Mon, 09 Nov 2026 20:56:35 -0800 (PST)
X-Received: by 2002:a05:620a:2586:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-9479f1b9eb6mr278176885a.2.1794286595119; 
 Mon, 09 Nov 2026 20:56:35 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:34 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:46 +0800
Subject: [PATCH v8 25/29] drm/msm/dp: mark the SST bridge disconnected when
 an MST-capable sink is present
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-25-d040fb33db5f@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1383;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=bBuxzsx7BIcnWIcOt6s6iyCubG47bE57DQZDBblPLv8=;
 b=DLNzgPu9qOBxtXLswwJcZYEcAtSDIC4flSxsblLg7PLqOIqmq9F/2ZFaYh/pBACS4ZJ8d4IBT
 R57rPTUbFUMBpKiBRKDMAmu6VaDTETc3eU7/WX4vr9Kr4om62lqG6OE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4Oa7dmp38YUK
 f3iTnbatV3xnhcmV190ScZf5dCzTAAOvHZmX7yGkpr9PsyKvrNdxrGOWbqdXzH6CF483Efwfrc1
 hGfH1VKzkzsWTxc2eS7+7TlH8hbopbY=
X-Proofpoint-GUID: 98nkF_mm6-ucgAJRAuAQJMWUavE3oqB3
X-Proofpoint-ORIG-GUID: 98nkF_mm6-ucgAJRAuAQJMWUavE3oqB3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX/Kk5TrG+/Bl2
 GLpYG2KAmsCHTEJU7eXJMQvesY0xQj+qC60SKLJtd7WWot3nGEtySEI+NrsPhrXW/e0TxbkDfM4
 Q/ggQ9wEvYLPjOzENrynHqDrH0JCpzQi7VHMHsNGn1sgewFdLGBqomaj9reNiSYFtSEezTF65Qf
 p0y356bkHIyBO4D6vGpzT4kO2tcl3Zfm0YGNDt8nev95R21GiAVW91ZFHe1xe0nZaV1bunD6Q65
 uYrI4CtsLfNr5Y6oprUqG+TH8Xx9/8AgRQq2COAvfGKQZSNImQrCA/jKw95FNW6X59CgiSWQ5sC
 X8i52a0OgLCwnxVJfr23DYWw6JYSJpXZLfifoVTkZnG3sJqMnASZmh+Uebi5vzm8WQPgLfP0C7h
 e9D7qmdv9QbCYRM8C686nJnZ2v576Ox34H7PcZaHz/uN8B5KLW04ylkjbb71fPBLxmlnkiP2tsq
 lJiSw60wa2wFMQiZdmw==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a404 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=E_DJWZ853T03DlUWG8wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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
index eeb0e0494900..8ea3d258a98f 100644
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

