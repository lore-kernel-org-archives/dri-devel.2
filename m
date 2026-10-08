Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0934CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5512C10E856;
	Thu,  8 Oct 2026 13:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lm5FvxkO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tjfd/iBN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932110E838
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:14:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK7mH3733019
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ULsdr9EtHW4nby9+oSfQABjhp0vJRi4rQqPanDn8yPA=; b=lm5FvxkOJ9ep9y/e
 ig/jtp5ufi7GdUDrew6o+i3AE4S9T7NUxk6TBrGxmaZa45CEHxjZy3a4LoGSO44n
 qaFQX8Mi5wnsDYqYSogpVLe/k0r29qCaawTxPqBf/7pOR42W0EJyCcWwRaZhyEVj
 wYaPHPAeTcR2s54iCgGOO9MIkAkvYJY7t+uZt/nlshpLebuu8VTCE9zePKn+oNL4
 uNfkzXDTAXi1Q8HTGUV5H+yfestm9gNYFLL0CEn7Y0aNA0mu3klN+aSmAPPa3kaW
 +OD0LZTtxZjQAxC2b7sfsJyFG9e5EGChaDma0H0t4NWReQ20qEhCCd6g6UYbfWUN
 cJLgLw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe6b1px-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:14:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91064f6e75bso157135546d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465297; x=1792070097;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULsdr9EtHW4nby9+oSfQABjhp0vJRi4rQqPanDn8yPA=;
 b=Tjfd/iBNRzPrOKv4G6h5uYHdHdTtjX8yiSFN1TifyFpzwnriKPVHjBeSr3VskEhxGZ
 j7Q9PXHcAzTTUaEqf9ROC8zBD9XsI1xONuq9/+k1Ia9aV/cuuqOJAWE+XhUbC8lkO8UL
 D6VrvWDcIVGYhg9gEQhB97EG8bc6lYXP+o5Z5DwUo+Vk7wNMzRLdjwUF/pfq/wmNOm6W
 CU89R30CF08D1aprgVulNK86o2eg9kFPfIGnfnQYB1HUl18zkB7zAO6EY1qSLiVUrsef
 KDCJFM5yJ4Q9Q+rwmkTvoCssiPX9F/0ydcWltMcxxF3zSnk20DfYuYzHJ2mE8KCPseC/
 yA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465297; x=1792070097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULsdr9EtHW4nby9+oSfQABjhp0vJRi4rQqPanDn8yPA=;
 b=UB3nVEZBGzeyF6WGskQALXFjhuj1x6mxmC+uVvhdCNnXTfXQqYZH1LFBXiHpZAtPz4
 IF6+ITx8Do3qGvd2VD/5PjeY63yt4xb4OxDst6XoV3DvEnPU4a23VUC+4RG/RUKI1S2S
 26hTdQYa6gr6kq8pZLHd2ZcRJaW4h/FmstQmKjY6UON4MOJNZg7Hc5aXA5YkIJwjDEzh
 UM6LP2Z3Jf+3pTY5vd8YtAYa7G7HpxJBYDg7ytwidvEtu6ibaFDgCOQQx6Jz/Uf6Rd46
 knLlfgsSMth9Jg7eYILoLYxSy9y/C/d8WUJbUHdruZ1deurUhjXtgcgA3s3tYapyg4TO
 WZ/w==
X-Gm-Message-State: AFuF++nJ1Nw2w0njHfGrpX94zhdx8Ken1dPJMk0DJVETKQDgi94Vrn+e
 /dohg2QPX0XM4QSWnJuvxNjkFXbi+XORqIHgxHDXY5UteO24/YtfXxXa9XuDzfUNFLBOu4LHJjk
 bFkqi0MlRt5JsEJhKqDebx9ktjLy3BTNbNFy3q2THo7SKzSv+ALID7jB0GR7syuRm9NlR2j7mJd
 3WSY/Itg==
X-Gm-Gg: AYBFou3gQZYn9xKn8OUIDS5ej5ttSJa9NdvDgWp27zG8xoCjRVrnCN1LTh2Gw+j9P3Z
 vIF4YfeyHWAsTddSKRaAYG9l5yN5MK4hd3J5PTeQ6V4K9HMAC+mQTytFTA9K5FdsttxRv8hBtPI
 DyU5KLfEWVrtgRKMeDAi1PDeQ9J2omDweTD1HE5xb57CGP7NwVdACybt/z0Z/ZOu/gVGn09fLjw
 FhGE22cXRnlOER/B3c+fd/tjMaywtVmOcTI/RJ5eTv2OSUDbvdB/NKo5o3Vb8DqnZVRB6U1lNMg
 yGkW2sxRsZ68ReckHsBzeI9li6oTLymbW6Y99M+PlDWdiJTEuCfbTRuelwuHlKsGTaRDkMpab5E
 z2Xxcz4wvTXLb7X/h2yJFBJt+LrtP6KxZcTnydxDJwZ2A2nPLxT0ACHCe8Svf8SxIPCUlRIutGP
 TMK7Og12u3zkFp
X-Received: by 2002:a05:6214:5d8b:b0:917:aad8:7e56 with SMTP id
 6a1803df08f44-91997852d60mr99078826d6.35.1791465296936; 
 Thu, 08 Oct 2026 06:14:56 -0700 (PDT)
X-Received: by 2002:a05:6214:5d8b:b0:917:aad8:7e56 with SMTP id
 6a1803df08f44-91997852d60mr99077966d6.35.1791465296229; 
 Thu, 08 Oct 2026 06:14:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:25 +0300
Subject: [PATCH RFC 3/9] drm/bridge: drop the bridge pointer from
 drm_bridge_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-3-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=C7K0x2PDL4mXbbpidAxqPo6vZ2ktQLhh/Ny8cKcMzuE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dG8pydL/rICq6oSSygX4yIznUj8DQFVHyS9
 5ymh0KSKsOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRgAKCRCLPIo+Aiko
 1Qp0CACdcSztWd8DMlIRYIuRUMwhaj2vowoxVztZUpF2pNpOi1q3Ya9MpKntwa8MuRANIknXIfS
 LRbllo9IOl56qgLc0ImgqmCqFi0FtzOmIh6XlGLzjoYkRT086I2Sbu9n5sO/Of/Gart62PxsvTu
 KFK2+FXEOYZ2W34J8u/zohy8BsDsKcLnomu48P+x7Efd+m6hNuLZahrD7mR1gmBD8ArRWt7V9zi
 hQMY4AOmvTBinPF1n7CsEinGfvRg70cse9eXtn1Den7+aiMlszcOjLMd+AL1+dhOueZS9vUxlyn
 mtmd/IP4ABxDnB3EbMyk4xIysmEN95xpijUyFWn6vM6QfWH+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ktolIewYfdJ8JpyTmL5GGouIkJYtqilq
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac79752 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=IhB6q-WDNiCyW_00jvIA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: ktolIewYfdJ8JpyTmL5GGouIkJYtqilq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX55CRRTt86VN1
 dkThvbAGTshhwGw1oV1upKYA1J8cVKCxKQ9oFoDEkfwec9d6Uc0IOA1QJpvolIrxYuW4yaCpHeK
 lqmvDsMLciOfBSB6ZWSAZPUPaV8cKvG+PIB6BdM3YMX88r7uVOWJ8b1PDqP9bOvB/Yv0GZ78mz/
 5j1XrWFSlUAjf81zKPM8vg/pmxouwytRtBHy0Seuyfmi/32FttnwoZPrqzj8EfQG4WKU298b3Gj
 uTtNoZgcNofGtnkKBN+RnCDzv1rVbYALGADl88CmHRgOks829cZQKuazi9rV83RpoCBsEwx2tVn
 G+Sfxu1BzK0LwsKA04YlSMx0lbXpaA/KPzWGY5PUNRfOT58tvTLZcjD1650hCtfow7oRl6Skif5
 A8EEjzkk7wxLCgg+OgRf67puU5RaCt5yVi8OpnG838tMiC7/y2idlTIKsTcbNEMr7oGZT2EUc1T
 l4Khe+lYZJJZcb+7znA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX3YdcNrJbebm8
 C7djnPLkATN3gEpm+lmW53c+Co6sHV1bKEQeNVsBtcu0BAwmtSD/ezu9CmeKHS+dSz9JcKpNre8
 cvU/kq3zcU+uiQ1Cnva4lp1xIOS0q3k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080052
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

struct drm_bridge_state carries a pointer to the bridge it belongs to.
It was needed when the bridge state was introduced, as the private
object state it is based on had no link to its object back then. Since
commit 97a1f01b3f2f ("drm/atomic: Add atomic_print_state to private
objects") struct drm_private_state has such a link, making the bridge
pointer redundant. Nothing reads it anymore, it is only kept up to date
by the state helpers.

Drop the pointer. The bridge can be obtained from the state with
drm_priv_to_bridge(state->base.obj).

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 2 --
 include/drm/drm_atomic.h                  | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 406157a3660f..f66937d7044e 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -759,7 +759,6 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
 {
 	__drm_atomic_helper_private_obj_duplicate_state(&bridge->base,
 							&state->base);
-	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_duplicate_state);
 
@@ -822,7 +821,6 @@ void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge)
 {
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
-	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..095b9db145b7 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1381,11 +1381,6 @@ struct drm_bridge_state {
 	 */
 	struct drm_private_state base;
 
-	/**
-	 * @bridge: the bridge this state refers to
-	 */
-	struct drm_bridge *bridge;
-
 	/**
 	 * @input_bus_cfg: input bus configuration
 	 */

-- 
2.47.3

