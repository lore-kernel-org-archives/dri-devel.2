Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7C60A260C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHGbaHBI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvVZNeX3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3022112162;
	Thu, 19 Nov 2026 08:26:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3694112152
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wK0O1007323
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=; b=CHGbaHBIokjSX0Ka
 xtz4C14FRoBGNSwLdsdqRhbovXQ6KGRSWFWBTIT/te/ybSIcli2IFMnS3QPefB8o
 ydGfRD1pk3ToVJYCbLu0ckffuKT3H5gt+fA/3Hc+yljf2k8Uvo/dVhaZyuRGNNFJ
 2o5p9mBCi/3Wa9qr0xpu6SlK2qXNJ7ba3fmreafiSrYcT6sh4r8OheN4vJdko4b6
 AEqNorsx4TvJGOrcJCeHaLg07jnbeSx2zUfhsdc7I0pFR1OxKhrcemPPr4mjKPRa
 VyWy4poSdyLsGXeQrcyHaNe8/qIW6DU1b6Lv/cKX+c6Gnu0RMkl3Q1L6EvTQFwoA
 7gsuuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1etnuskh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495af07676so341413185a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076772; x=1795681572;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=;
 b=cvVZNeX3PVVp/cvq9guQvtAINMk1LFl5Mh+oz7wYjLPUfchCx58KH9BCi0Sia1vYMD
 tvgRqXel4d/ytELRmlrHP31A2QJKNIQg3pYGNFD8oSzIGFSK1vBaeTJa6LWDmfZbStNw
 OrcMsurhWUkaApXDpUalgZXSuY0G5Xy2YnhMvq85PVLDVQ8XxEZf/wbZsPR/G7s5RQUX
 +xYzdOzL8GYUzomHFl8CKY1Gs3sd033iOTHY/nO1ZL8Z37mXeSkzVRwJcOTSxJt9FCaw
 NxB0AJ79NQh28uF+xktZTP1n3g+A4ccOniP0kjRXsxcluDwoAJd7lTX1GoKz1QNK8unk
 1vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076772; x=1795681572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=;
 b=bUSf2gSZBZzE48xqJ/gbvABl31VX0Dy3uePuYk9tTibRUrOyEnw8DBxzb2/gOxPh3R
 MZP4ihBIGz7yigbxGLs3wDj9DUqVw1n/NedT5nQmXl5eBCIBAgxKHemmC31Bmp94nD7t
 MgLCzoaQjw8LCGBnq+qu1E73SMcf+CgRRa0lViYAgt/JNvWVNWSQpzi/HLAPw81POkFw
 xfp6oVNG7DUbgl2dE4CTapyueGUM0YjjGo63UKEdkV3LwrgttLIUDVj2HCcOxg7Z+bam
 GMdr8Q5oB6eW6aA9jWtOsYKOe357/eEgvGPapRe4QcHfXPiBpErvj9CWZBY6hTpaAQ+B
 /vmg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZ1RWACIB9zrvUnZviE6I4oMPvtRCnTHe0hqm7Uhc065qfZo4oMDfOIad6z/LCp8zkfXd4lE62ZHs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8J9s3+icZ0ug7ofPco5q6e3kXDK1lu279SFrCz9HygyxEIT9su
 FQxVI95hfAEsvd0hGc9auoAkEZigy0KDNH8oqqEd3LqqqXcqKeD0iLDTbRdsqVUGOlX6Ly3/VTl
 fIb2hI4UmwNXdQLjUBlHzLJMn2ay2K7LNKFPS/qPq0YrBtMZwJot0ZcZRxuce5dc7nW4L8mU=
X-Gm-Gg: AYBFou09nz1qOfB6A9y2hoqCUzX8HKTcDsUSHj/CuQwwjuWA5lCdNNfOwFOpWUF8HZ0
 KEtw/vWYNs/TiIWk3pD8TpaoGTmkcBMWcy23UaMZrM36UQy/WJ5k2VeSgalKcP9sXvgvZR0Ufbo
 59BNjH6i/LslDWgldVmLPBG5gJGH0YlQKOB1MdD0LjY6IiLf7QrNWQYwDQS7ZBaBD4xkfnLFSG8
 AlIlaXc0keNjSNkUz/p57dRSHebFfmQEI5C2eSeXQSE333lnYDxQ39tso2l5N8P/Djz5Yt6tmjX
 49l/2dfDZAdy27EQp3lUmYJGBaS5qe9GFtiOCi+TzKj7d8GNf35FxWSkG4CHsIxDi+wg3h8k57/
 Kj4qJxi52qtDoPAyoJOwNZiEc0eaOveqdOs9xWLtUkOelaq/HTOOtAbijWyAwUBpIy/ED2yo/Vj
 juAuaC261Of4a0nrbn5hsMh4KRlghWd0eok8Sm
X-Received: by 2002:a05:620a:28d6:b0:949:664e:e3e8 with SMTP id
 af79cd13be357-949997274acmr1001222485a.34.1795076772102; 
 Thu, 19 Nov 2026 00:26:12 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:949:664e:e3e8 with SMTP id
 af79cd13be357-949997274acmr1001219985a.34.1795076771656; 
 Thu, 19 Nov 2026 00:26:11 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:11 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:22 +0800
Subject: [PATCH v9 20/29] drm/bridge_connector: avoid detect-based HPD
 notifications for DisplayPort
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-20-ca61be4edfc3@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1626;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0BzSJVy5hCHAkX2oiDIpRZW7mGbTKWmnfn6hw/d2uWg=;
 b=WT2ZHw/Exms3N6Ny5DojIlbfnJonYmXUGvFt1rEmkvbknaPOYX081PQFTO2u35tS87UdRFGVX
 /bbVhhp5pDVAaCM2xdJFrBDVfuziqWCmGSjfXTMks5Wvk7kpW4wvK+9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=b8UncdGx c=1 sm=1 tr=0 ts=6afeb2a5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=c5AeteMbgwRpADRefSEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: dPYO2HfiekxdLzT7dZymUjgc0Ea4SYiU
X-Proofpoint-ORIG-GUID: dPYO2HfiekxdLzT7dZymUjgc0Ea4SYiU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXwOETs/vC1iLj
 MRtpkyAu49732ymyszV0C0OEwDoYZrhEqxVj21dVxu4hqUAxjwNuu2ZlI3Hu+ZN1JlwHp7Z+Gyy
 wUBJuZrKvwGYBC/MRN5M19KJ5yjBXac=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0MRC8lJiJ8Gf
 ZKFEt8eB9059z3r9bGU6kWWXk8GCNafp8fQ9NZbZat0Br7wrgabZq6ORm3EMFNMALZwekBSL2oD
 2fKpMtRptFWDFJyifGmlNq8CLslzeYV9LEzpPZUioGl65Y2tt3IBPae4wpToNyIwVfzfRMHi7jR
 6gW3w8zZKwAIGO1Fa7SLPNIM3G4BOsyAoZ7YHtqNpjPPmKWBaStZD7qktz22tHJsHPTTFMp5d/k
 O3azcFx86wFSoCf6HDv1UY5i51Q613NmclVd6/NS2eMWBW5TEkaaf7havAC3Zg7URvLA8D/SEcF
 5ORzTOWtl5WGxYEigIRo+MbQWRpqOZXfBrOri9YDBx4VlKI28X6b35ZMDT2H21g3vXTufoXg9hu
 iU3Tsk5ucxjQdQ2qjCUjJRplpM4kMjHojHpIkfimcMJtaF02KVjtUeXxFg0yGI8h7/nbA1302i3
 657ZJHPhVGIejn6juuQ==
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

When MST is active, the SST connector reports disconnected even though
the physical DP link is still connected. drm_bridge_connector_detect()
forwards this result to the bridge chain as an HPD notification.

On MSM DP, this notification invokes unplug handling and tears down the
active link and MST topology while the cable is still plugged in.

For DisplayPort connectors with an HPD source, stop notifying the bridge
chain from the detect path. Plug, unplug and IRQ_HPD notifications remain
handled through the existing HPD event path.

Preserve detect-based notifications for other connector types and for
DisplayPort connectors without an HPD source.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 1d4502126bff..dbe874d26911 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -315,7 +315,10 @@ static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
 				return ret;
 		}
 
-		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort ||
+		    !bridge_connector->bridge_hpd)
+			drm_bridge_connector_hpd_notify(connector, status,
+							DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:

-- 
2.43.0

