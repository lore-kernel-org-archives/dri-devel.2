Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FA9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0D710E520;
	Sat, 27 Jun 2026 21:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcQ8C9K3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nz4hGBFg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8764110E51A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHntI71737145
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RPvoODKkBmF95D+tmF0L44Dp063anXESBCjly0AMjV0=; b=RcQ8C9K3NwzcQO1C
 1orKiqOpSgjs4zbSuUg3A+IRSgAiEt/2WHgRENBrRAuLWyzkdggVDd0QuSSl8SPZ
 Xf6IM0kg6LVW89EG+kfby4PL9H2yRZ16m5N4HFvJ63hPvHx3jFhGTtt5pnkPAkwm
 Grx+lcL1tt+P+vvuAHC+5RAUQjfHasGSwm6dm4sJT1kWyTE1/HR5k61UGLz1uApl
 Psky5RnpBIpZWH9DCpr1kmuPfw9ToCKegrGPj6xGXK2pBL5BeLhFrrpHBMV2BLKx
 p8A/McvUIjgsZf1L2Mgnrbg+ADt0+eLePXRHGFXpQc3EoHJodEKJmbfH5DcNVNa2
 gsWlNA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u71q1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso4904781eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594292; x=1783199092;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RPvoODKkBmF95D+tmF0L44Dp063anXESBCjly0AMjV0=;
 b=Nz4hGBFg7ZhAnMBK5lT3dlpnFU1FURftn/gtT3akHrXimYxAoD5F3nq6CVjpt+GCUf
 LfMfCdAUegpb0ypvp7teFmjjTokRFwix6ojPkMyuHp6cMxw59k7XrcthcTUl90oWvTOh
 2UU9JLIxFzUMZ0+6E50hZ5tAbiQfwmzL7KNIooYj0NACbUzTGEb6AwFO6CE6wEDiW/cf
 8KN2Nh5lO4Qu0U2cQmuDg5KX1REvD6z8lNQytxG8euuNQbNAc6YKwlpLPQXPic8mlTix
 vDDZMtlwv9RzSq6mE6GKUYv+8OoxoeUHQcigJgTrWnixTuHT5FTwM877Uq3IlZTK+XF+
 QwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594292; x=1783199092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RPvoODKkBmF95D+tmF0L44Dp063anXESBCjly0AMjV0=;
 b=P42EPFHsufj6woswCmXftZC/m0GnFrlWsoQJbLa13sJU7sQ7XbTJ5TzequscYMGfvN
 LSUpB5VHZnjY/rT232uY9q8jxoCc0N7AH7bHoLw04EjtgDYT4m/1cEZj66Ab1QWvRscP
 NdIIp4FqcwGqoNWBeyN+ili0gHi0/zi8Un0OaGzwzCEiDQR9Y5ycaQkcPqSnQPiDmdYB
 Sswa0JBbqzel34N2c9WL0DLL8fMNm6LAgG6G+kXFrnxc+3EROuyGGgkSSnokhXQWu4vQ
 L02z33gnaSUyKNBpTH8nUuxANpotrH665aOvP3mUzU09ROByOLPuuPEq1PtV6ImNUq6h
 VDdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/kMs3mWeh4CFF3yoAzf6hcDzDp9fcH5UCSXpWB2pMImNEvwDAefOD0dn0VASpFbBed+MxmUSdxoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVkW1Q4VGBi3vRDp5UAVd6cDvWxqjLS1rRUA6nHF6OICcoSjbQ
 X6eVRqQFtsskQfFr0pjGwtNsMTpY7rLXMibjkXG7PJLkW8atv0UNVWQiKsDqYgSAisnNIYH1ze7
 +KBUdXf6jGN+D2meDnULjWI+1IsV03xSWbVNAZvvPN2N9U9sCZITKm7cfk21noADvHJXI/xI=
X-Gm-Gg: AfdE7clkchuNIuq/MPEn0xNu32Q5d2UCI+JTkchkdWhAdNMhTxKbuNOUra6uRzkw3RO
 95GC8BwUGlAHgRzk6WKJTfVIBAIl6myCHKuatoaESyXCj+ICK+0SglStI2Y4Fgvypq9fO+dx/CD
 LZ3qh3R+b7jra9+MX8zAsf3kpsArP30M8uVSAspYlbzpBfC8ZIbjQ4Cv8fhQb0wxSPNj9lU9CDM
 nd7sF3e79Sc15poZz18daX/DeC33wZJKIOk9UnvI6+jz3nj4OWaCcBzla6RXB2TvfhSV5U2jXz1
 c8+tbtW4QdVtKONXvBVv0nLs/02K2tB/ETvXBeWhOAeSlFgd/P1oQ+vZ0YM0s8Llc4l0t1Fkl+c
 LXexu7hRQdHMlWOaf7PGz+7OC+3qUrlzECUzz
X-Received: by 2002:a05:7301:686:b0:30b:fb9c:f8ff with SMTP id
 5a478bee46e88-30c84b6c53bmr12462577eec.6.1782594292426; 
 Sat, 27 Jun 2026 14:04:52 -0700 (PDT)
X-Received: by 2002:a05:7301:686:b0:30b:fb9c:f8ff with SMTP id
 5a478bee46e88-30c84b6c53bmr12462552eec.6.1782594291889; 
 Sat, 27 Jun 2026 14:04:51 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:04:51 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 02:34:37 +0530
Subject: [PATCH 1/5] drm/bridge: lt9611c: fallback to cached HPD status on
 read failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-hpd_stable-v1-1-13d8b732c4c6@oss.qualcomm.com>
References: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
In-Reply-To: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfXwxGAqrXFwt5y
 Ho1qX4lujxsn0VVtP6ujub4OQcfX8IucEjKn/w76RxFCi1RpZwRxmduSW4en4bNOC2btqaehwAE
 6X3tQSXPGApALM91mFnqURedTzS6UnI=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a403af5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pIV2PmIDnMgX7T2c1DwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: E9R4yE3NMDNBFu2tK_QOHIf1WyLnVqsf
X-Proofpoint-ORIG-GUID: E9R4yE3NMDNBFu2tK_QOHIf1WyLnVqsf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfXy0wS2hbFrjye
 +CbEaxsbmOfpwXJldJAb/lZ1msK0bZRWbXLKF4MAw7+z5z0NuTcjOtvOCEY7p1KyBcCftV/MQvr
 TfxgBHtxt+aeIvycxRk7HJJMykwsoDELM+n/D6HCbEdSy0bInLkR8UvW87dxiTlMgC0JOgaHZWi
 m5L+UqsKywGa1U4o4a++B2pLOcC1qtMhUPbkYZJMTRxI4bY+FfVQFWx9+byd38VZ/qAHvgs6p4v
 bf/Hzt9aorursVWeutktqTldNFjvWSBDQnIDnzPABd5m2ZiwyOq6Ad8H/mpy5fAULDeCk2LN5kj
 oP3bRZRDx6aqZk3VOosffibx9h5/AucFdVeO8tRkj03sAOnuVpBEtL+okfwCA/rgLfA8+T/XIgA
 TL41+a+QF6Eu92cu88VeoX87ZgI4r1rsbB5rTPQoAt65YGppPVodqHqRYQTPj35Nn2WQfirBgkF
 rbhVAgrGp8AaBuqn1Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270187
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

HPD status is retrieved via an MCU command. In some cases the
command may fail, for example when the MCU is not yet ready,
leading to incorrect disconnect reporting.

Instead of returning an error state, fall back to the last known
HPD status to provide a more stable detection result.

This avoids spurious disconnect events during initialization.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 5d67bb7391fb..81ca9d62eae3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -711,10 +711,12 @@ lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector
 	guard(mutex)(&lt9611c->ocm_lock);
 
 	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd), data, ARRAY_SIZE(data));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
-	else
+		connected = lt9611c->hdmi_connected;
+	} else {
 		connected = (data[4] == 0x02);
+	}
 
 	lt9611c->hdmi_connected = connected;
 

-- 
2.34.1

