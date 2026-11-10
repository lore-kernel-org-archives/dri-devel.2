Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBF60A383B
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AnpTLoy4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gn+dXVn8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DDC10EDC1;
	Tue, 10 Nov 2026 04:56:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA96710EDC7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4ABrB1957780
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=; b=AnpTLoy4Rf8Kph2/
 VnpjvANelHxxBsn7Potl1+Mix4C5oNNt3kbNPtDHyRGLuQuFC6xunwkPdI/X0sQ5
 AoeUY+/NONARe43Uebg2Q4BTAC4FB1kvHWqZrl9TwNHo3ATpogr8gZWkJ62Qe2FL
 xoNeYVtCu8mzi63tpECYKWxUV9CHmNJI9ArIfVL6VEF7/R8G9XiJcTgkkOs9Z1YL
 JOlVzmcNu6jL7Aq92Y1vcmOAY2+vXF4pfRv3uoYgATApct6+shLsC/Kt0ItGnhZF
 LOIGJMF0DlMDAZqzNhoI+s9DTj6Yc+mI/2BcgO2BvFgd5kHjksrCMWKqgZ6a+5cN
 yA9g1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydknkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso377452485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286572; x=1794891372;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=;
 b=gn+dXVn8E3iWos76mhOoFtiOncBxmwG8LH9mBn2cY1Ovjq5qGS7I8+lF1BY8hJftqW
 /zUjgq5+3xcMrGD1Q53UqVZt9Buyn9vnoihxBQgScCPxbFm+SkvmTKVNQcu7lc4DlHzk
 xQZiaNTOeSDlwN+7amNT6iHtoUad28/qCWeMf4sDC34FujhD8ePmCMbfMJxiNb4ypwUl
 c3KPraiadSs/bOf86qnH2ItpBzff9yP1YWenF3rWhhQuc39W9LeEsznkJKIIyHWV7KgD
 taBtFz9pL41QC0ccDBWLdjAl39NDkW8WA0u2RZB8PwffmIYnXxFIG4JYP7FxJwQXxsBC
 0ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286572; x=1794891372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m+p8Z+9cYwy8buXbdgXCX158UXxIYvSeJYw1+9vLHUw=;
 b=hgFO/Fu0JArXgM0LRAkUadvS3FQAhYKu4XntLxy20kAfoQWGYrQwW5AZXe4UrG9Puq
 vgY8nUeYWYEwgVK11taRbZwCqwbxM4feylklalIMGYP6ZohOdsVrVnhcDdZrUEHQdUtS
 xPqgy6ffuIdxkbZF8n8KjiRSKf3iYg5u3WRtlqrUI9QB6WJ61InOKBM1g0BX5RiDBO9T
 CyYSKwE8CumLQKkmVTtsXZ7LdlX3xiRImzW8hLLrv5i+67tmMLPNRhf6hH/WPaYSjmtN
 41TQ5oaHaexqmendYbeeT42E59H2Xu23uGiliwX6HNbjtt6VelWQnNhseRH/Yc6v0cMG
 /r3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF9GsocMqGBIghQr6BQygDC/DIbg/fN03ZcOKM2ExxK1Iy889NlKxCf3dpBMj5LLJ7pRd0Dmiaau1k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8jPV/+1m+lbjAfVQIvOzU/RmLDLTN+OFdR7+6GImcFd/xwTvwX
 bPo6+eLmS3bO+Uyg5OPykxOZbNaDdaI3b42GulbGIOLVaux3wVVY78gfcmDzYZgTJ+Ff1ZX9H/C
 rugBzwzm7e/FoyhQF6kcclfmQM4ZlIX2Au402IjpAbzf3x+dZh5Iizy8DElWllwhd+np7sOU=
X-Gm-Gg: AYBFou2CnR76SKHnfbE3pA19ERCwM1VQYiZBtE1z4Xn+GTft0EHoXsv3OQuiaYB0v6z
 6eVpDbT0LO+jTF8JhcPFifC1iGbtrBmfma20F1dwUDACLWAbpXP20kusjbiKNz/2+2xgRLywG51
 qaol5obv26RtH0OgFZg6mrViR5LpzuNumWpxXasIcwlKzpHAtY/Pe0z/T/yz2gNgybaKXy1327Y
 kP9dpxMDHa9psaJ7Ik8c5a48hRPLHTEd6I4Nm34PVkB7QBYFUjLJGk9Fb84KQ5aROYljrVg0/Fs
 zutR0JZ19Yl917lIRGylm63e9566qoy54t3YQTmb0HEZnaipX5Xl9qQ8C1XC/XIrjk4pn2zWeLV
 rNZtv37ZXOC/8Sfbihj3mudZEqqMHIaht/Nu04HyIZz+cyIib9OvW8pJscWa61C4QNnHyhgxr/8
 P4fY4s6phXlXprZxNCFsNUtH8Z1caQiypqrKpY
X-Received: by 2002:a05:620a:3193:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9479f343931mr274929985a.65.1794286571762; 
 Mon, 09 Nov 2026 20:56:11 -0800 (PST)
X-Received: by 2002:a05:620a:3193:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9479f343931mr274927485a.65.1794286571307; 
 Mon, 09 Nov 2026 20:56:11 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:11 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:41 +0800
Subject: [PATCH v8 20/29] drm/bridge_connector: avoid detect-based HPD
 notifications for DisplayPort
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-20-d040fb33db5f@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1626;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0BzSJVy5hCHAkX2oiDIpRZW7mGbTKWmnfn6hw/d2uWg=;
 b=ar5hEtLcpwfPsJS8Yu2/xs75nWEgCc2nuCkoqEuJP7Hc/pXZdA5U9VXgPqcrHXwaWSL9ardjj
 9kEnuf+m6TAAAYlUhsTcmA2UpeKQ3GjnMpD6TGfK1pJk1KZu0HEJTeW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX8TbUmZ4SicBw
 DASB7z6mF8QEZ9mTsBXoPsK4F3sB5MvWAv6i8S0wo68ffu/LxzCG0g5nVmosUxMs4TnAcyqTFuV
 WOz21XE4ROW/5osDzajsqVmSO1xe/Xc=
X-Proofpoint-GUID: v8l5DkCoUKWGeL_Z9tbAWZwhyM8Ghggx
X-Proofpoint-ORIG-GUID: v8l5DkCoUKWGeL_Z9tbAWZwhyM8Ghggx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX9mET14Fz170k
 CdxcPs0LU4M/EgkoPommgEaspKRQ6fRo6Wb8SuwsaOwXWvQZauM7j85czNlJgGaTp74qRtM9FxN
 Ki/1IPw6pleiZ0Ob6TgyhCF4MWjre2EY+Vae+bzyfimUdIVsaX9ngGx7Ilg/gU4amlezRQr4AZG
 W8cdvVMJWKQUdLhgKJV+Zyg3pLIchyqgCmgI3AdMoPnKNei6O9uAewjkefFvoyrJ+gJThn22hwV
 KyYI3EJT13Ye1zO2pkxXp0D9JLk4KDj+5Hl9O73RTEsdsQ1TIlFsQeDaCjOr3AfdBSz7RvHjcX/
 hOW4apql+2/qH4YqwOTDMc+jzFDo3rnOiu2JZiVTvcrXwrsAtg1SCn7ya9p3JvXfTc4T13G/OrT
 9ORUP8TNKKcWHK4QUaKPpIkxOxTtGaci2ZZgwimM0KkNdpF3+1jWUruxlSdo1BilX8K7wq4Z4Kj
 6Fk37nU03FgW2CQwmXQ==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a3ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=c5AeteMbgwRpADRefSEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
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

