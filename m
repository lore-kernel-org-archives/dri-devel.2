Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A1CD8CA4
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BA210E5C5;
	Sun,  7 Jun 2026 21:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hn5CUgbi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LzrPCXVj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F62510E670
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657KcdYq1080892
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzWM1TZRG4fIsuvgrGBJ02mMzsQCiM1GfHgBBstXKAk=; b=hn5CUgbiAJuLHwDU
 XtFLBR9mpaeAH1nUby7GCEGjmehu4jV6xB59t/z094qPjswb9dx48zPy/HY6rVMW
 0Vml1KTght2Z/yv3jPYj97Mp2AiYhM0S1A1b5TbxkYEbvt52K/V9RlenZMZr5nQi
 R8l5kPczHLiQONmvQP1zKltG46qXolNQAkRCHYIacaeNO9p8//I8cHq70nlaPhqd
 nVGOLO/27EgaoQsTCStJQhIue2tZjfnt87dJ/LOorZg0HK69vQJdNpuUs79Ct3lf
 GHaadiTeIMTosYTqmCassoj+XIiTQ1+gFJliDbhm/rVhREHzCcPnDuFPk/e+XPxn
 2ICmag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadvhua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5175aa1a54bso83213211cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780868011; x=1781472811;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzWM1TZRG4fIsuvgrGBJ02mMzsQCiM1GfHgBBstXKAk=;
 b=LzrPCXVj/pJofwXHNv1tyDDL8Ip3prHXSGM6864b2CBt2g2pRk4Y3oZxol+t+MOBzL
 cOU8FwcsPRG3ayvWTpa2T6QxjXHxdkLZIIhIpObnQQLAhnZ/TiSFpEdo0ULAaw1R7GKn
 GjayM3KYbZCJUL/xS4pioRoCS6b7HBN/U+p3+70SMpqL/nOCxjKXQiGi5RzrfVkNau+h
 nKC+nAs2fYDtnh/f8C2yyf89Mn4MY7eeagsBuqb+I26InNVkieyuloHpUwyvVp4N5jMk
 4RCzF1kJkoSEfwGNGTs3HySnLnKhnuZOY77hHS6oV0P3V/6xj7kIna8PhS5S/9bMMpx+
 3obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780868011; x=1781472811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzWM1TZRG4fIsuvgrGBJ02mMzsQCiM1GfHgBBstXKAk=;
 b=I4KfhABWuroIq6BpEkyMqnosiSjTHbcHqlRRJYwJydeeHvUdajEsbHFgT0KCh56+BX
 5St9w8WxPurEN+CGOYCKW6ohkl+iaAnpY2spht0oj9PNdTfNG311FLzvnmCf0OpItGEh
 WMQ3gUo1gLKrNWaW4DjhFZMMwmF9NS+oF2nk1d2hxP0H1PodpPs87/1pe9marxeZE+xC
 8z1FRdm0a57sIZxm3Glp4bjSZXgq2q5cDEH2wNWmOBymaQn9YDCegngvEoTBnkiO69p6
 a9ZjqA9tOZMYekWG8nOKN3YFoY5TPQNCReUhplCso+spv3vPG9ALUrkzYEZKLl5Zf5C3
 c/qA==
X-Gm-Message-State: AOJu0YzaFjFGLUCB07cqWiszjCW9y7JUA0Ea5ytuPdTdC3jEBS2BXnSR
 9PHyaADL6VDNqTu+KVr9HMO2kbr847iCz5qDxdHDf1LKX7/pnduLUZ6qq7lQ/hGXa2g+MEK1b+R
 0IvzbV9eAM1ia7//RooeSGt9tdbl98UAmoq89dmEkxPmmzX+2MWiN3zHuKVTOGSTzcyAJJ1g=
X-Gm-Gg: Acq92OFMKiGYwb1EpTx67awfsNuLZVSRaDCbyhoxNjitpLwcN991+s9oH6yLtnGxZQG
 5uptdSYZo4NXyGbr7Mj84aUDcmkLhfg2ldMSO3DiezgNSD2hdZOLidHSA/Z2AyXl4LJu/b/5wKu
 1IGKlTSsljLzTJGwSLK7g60WdYxWgtG3BzT/iAZXMbk5n5yfMv/hggi5iGRk13aOLmxtqtgm248
 RnZztrxLF2wyCWFH7BoWJMfZ3WsS7OJd7LipNUIUFfYHNwl1pjA8Qe+nrhqvk9s3IvFihKjeQel
 BRn1zu+XMk8wqj+gWKjlJ5nh5ZJaLL0aGOM0+vNZpXlr4CcvbVtb2Mud6C4oymKQF3o+haFZT8K
 b+wk7PD8za0MNiNa2ZERjUcTBZnQ97S8kUNL3n5oMdQWhYaI+33PtIN82wHHFfmCewfd8nnHJiC
 0Bt7iguHpGPAbOqFhHjCMxd4JXo96YNk0VbAsLW1cjWiCk+Q==
X-Received: by 2002:a05:622a:190e:b0:517:7b6c:4459 with SMTP id
 d75a77b69052e-51795b8652fmr197936041cf.24.1780868010815; 
 Sun, 07 Jun 2026 14:33:30 -0700 (PDT)
X-Received: by 2002:a05:622a:190e:b0:517:7b6c:4459 with SMTP id
 d75a77b69052e-51795b8652fmr197935631cf.24.1780868010370; 
 Sun, 07 Jun 2026 14:33:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 00:33:07 +0300
Subject: [PATCH v4 6/8] drm/msm: dp: handle the IRQ_HPD events reported by
 USB-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hpd-irq-events-v4-6-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
In-Reply-To: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QU1zz0yugX4tikhrrDvaSfvgadApD+nFc1XuyjM+i64=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOQkeAHjmwgf4TWmB+cq7J3apXFq4vK/4Y/t
 1PsK+1kRv+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjkAAKCRCLPIo+Aiko
 1ViTB/9NfpVnjn43UETfojgpSwReE0dmwB3DsDHqHJqEU8ojNNa4kPpaiCJU81lltCqj5XgErdr
 rCaglIXukNpl6RYq2cnOGXZDBFtEgA1NT4vKlAyKuMYlmZz0pWVp+FHDFuLRJ8tRA9L8J190qw8
 BO+hYy1pXLBiA/M32oxz8e8bzTDXNSD3K8dG6Y4JaoJige6+C+SFHd0d05ZNIvHff21WqKgWR8K
 Jhgy/Dnewo698WJFRxsEqUx6F3RzyX08UbeMeFsVfwktU0USS/tH60kTsuxsPpyB5yREqjDzwQ4
 m7VCLAA3vhAoRAt4dZxK3oKdlRp2MTrv7zcL8DXzOeRsT3eX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a25e3ab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kFJzCQJ8v3RGWcIHJrMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 8oE5c_l_9Zo5P9dnk3AoR4klKm-C3pig
X-Proofpoint-ORIG-GUID: 8oE5c_l_9Zo5P9dnk3AoR4klKm-C3pig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX9uX6TIEwsicy
 PNwaImU3a8pzhdgEq9oehMND9fwGPBBpnnWzoJu/pnMfSERHmWzU3IkNjs9d8Ajsv7ggN8TSEAl
 OZ0khKzWpasaCTloZnK1k3ndKRgSlx8cW/uf+JEc4jEEQ4lzas1jnN3PJMaA31pn3sC24Cop3IJ
 GxX55fxkbdClopO4L9P0bC6U6NNT7Ty5iw1O51lSi57NZ+gitffT/ztg/NTBQGq43ALo2eAELgK
 wCBsasNFRXyvv3l9wr1SaSQ7Hh2gwuKN9ENSZrNZOCwQ+9YOxQcZJHr+7mRY5tcJ5r79oNbabMj
 1M4TcU+ffdt4sAC56LFYJ2T+j6vYUcZhUcQ4q79srPRNnb9kxjC5zlDSvsPKK2ORLYDHvPDdN+N
 wvDgJPrSrnWOFCLyEa9Nvcc7pF9OAex3PMvy+/sQdmI81whNjD4B29BfcFXiAXRzkgQzPYcBukf
 aELgn1MR9uPkZ5l9xZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070217
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side, for example DP MST events.

Let the MSM DisplayPort driver properly track and handle IRQ_HPD
delivered over the OOB events (e.g. from the USB-C AltMode handler).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c0f6a8ff9b99..743d8fa40dc6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1533,11 +1533,12 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		   msm_dp_display->connector_type, hpd_link_status, status);
 
 	if (status == connector_status_connected) {
-		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
+		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
+		    extra_status == DRM_CONNECTOR_DP_IRQ_HPD) {
+			msm_dp_irq_hpd_handle(dp);
+		} else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
 			msm_dp_hpd_unplug_handle(dp);
 			msm_dp_hpd_plug_handle(dp);
-		} else if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) {
-			msm_dp_irq_hpd_handle(dp);
 		} else {
 			msm_dp_hpd_plug_handle(dp);
 		}

-- 
2.47.3

