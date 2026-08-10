Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52447C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402C410E8DD;
	Mon, 10 Aug 2026 14:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbbvljsH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xke0A7Y9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A7410E202
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACjA9O1650744
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqPA7hXcyMthrwG82uXYojOfmSg9zyync4goyZRZBhQ=; b=nbbvljsHFd8NaMv9
 60Ymbv+2UWGawpU++nYS+S9WZnBDLS/7oV14ocm8KpwPO4TDMCc/qcOXyrrG9D5b
 1miWShnWj0qWH3VQniFaVj5QfYFZN/VBH8XhOA/bnJ2b3wcObKT3Th6P8TMTTeYG
 3TGxGNJg9Qkfv/eNqg3wuVaRtOyvCLaVYargiDmRDg5U6+voU7YRysiwmC/hlJLP
 jvhwUDdsz0JSYOaxY9LaeSt4Sp0sd13XbMujRmBMiLD+NDqVKcJKBhwB4/ynaRuw
 UPR/joELBkeS626z5LSjRN0yqMdJbd0o1ApYpNRlQ7vISG3RNP1xSK9hTxTJmgzN
 5UthdA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8vhj371-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52cd0374265so38703801cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373516; x=1786978316;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqPA7hXcyMthrwG82uXYojOfmSg9zyync4goyZRZBhQ=;
 b=Xke0A7Y9ddbwoQOr184nNH2hgxTbmpYGb2Hh/e5HI2dfL1jTDGo/zKkRIzwwxUnmVp
 9DmQGo05vJyzOr2/u4FaFz6zF0HXsbRd/q2drnYRYGTQ7JOsEnnKF7DkvsDMDisIu/qt
 ZbHt8UCbreYwWEfaNAub2Ta1muW7HZZCqdA2BKamDhZkzNa467gQlNhhTqSIOaGMNcf7
 ncGSAznJEnIFfYgJBY/8OIbaI8XS+ifJ1fRRad5cNkKQN3YB1QXb5tLedUzRq8eTSqpZ
 R535mgCAtrJGFI3obS4J8e2x/ccvhPp44eD43jOV8AKMe4fGXQF7F+rmmu6GzeNZ6CNG
 kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373516; x=1786978316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqPA7hXcyMthrwG82uXYojOfmSg9zyync4goyZRZBhQ=;
 b=dllYbhasT5MP/2ZugPi2TkQgjQnYlOXaY2U1dCiAZu+0PszVCDLgDrlD1VoeY8yGwE
 z+fuEla7TT6LL6x84mNsnDz/sBW7MbQvWQyVwzlLpdaYNUok2vpEQh+kyCsM+YhQd3Av
 LF8aDFgE3cVFiQ6cGHhOuXlroHx68Yb5K5vG0jWOFRIcQ+hUgUPzZKfmSCHxh5aPTwGp
 yn9rxzsoTYZDHQeCzwfAOTEtT9RQXye9L6LP+btWzcEp/awgaWoLN7SvbxK7bXA75Tvy
 qyTAPPxaYmerzyvy/cdHzh38ywprUe/h8fZ5pN76Xfoc5JI4EdD55k1Y8y7Q5jaO5RDK
 bvUA==
X-Gm-Message-State: AOJu0YyGeb04+hY0eruEpXKgJUsHB1OjWk65xzCbufj/5dHkoWGRw0p7
 7johSiRDHHxnEKkDk7qSw/qfIQt/ps38IC9q3wNbn0W6gi4aCSL6sC9vPMAAT3UwqxcVtPwq6yy
 bRCE3EYEHmqMHBKqT0YGGq0j0cYis9920V9942+0h1rJTrX9jbV7imKyHlOnNB8+RLSUpK04=
X-Gm-Gg: AR+sD13g7S8OwELL156d4g6K5RszzQa75J1E5Nz1xzBqUvAckQMvza3rkw8NwaD8dJ6
 DhOA/d+HOFj3hbdYBef26dJzhai4pHfCvvRfuBS5+lRoo6+Gqbxdu9j9/EFWlvwKOWimb50Nuz/
 82moiFpmihRWoSKC4GTOZAZ40cnM2EvQy1K2ACj6H0Rue6Co6lk7aCxRIKEQ8BEoTMgdCIbweXq
 eVZHPyASIeJa6oURrJI+Y3T+ucr0EX1ym7rQKkZjk/r4rGdDpCRN7yaZi/6AZiprAv3qcbAFz4p
 WeeSfApB2VQh5FXNhyf4AJchwNDC5rbDQTe9/wsTgfDG3C3tyM/s0DgXpn6UhUPj1JjqC7G+eiY
 7bbTNDTDPXyFBw/VOZZ392S6II+fzdHQDNLzQYChf7mt6O0FUzFUs0F5j1yHEHYAz3KYPQVv6Bs
 gjjYudfzIy2kW9+w==
X-Received: by 2002:a05:622a:1f1a:b0:528:3142:d466 with SMTP id
 d75a77b69052e-52d20a920d3mr246432151cf.41.1786373515754; 
 Mon, 10 Aug 2026 07:51:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1f1a:b0:528:3142:d466 with SMTP id
 d75a77b69052e-52d20a920d3mr246431491cf.41.1786373515360; 
 Mon, 10 Aug 2026 07:51:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fddd6a796sm22489661fa.36.2026.08.10.07.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:51:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:51:48 +0300
Subject: [PATCH 3/4] drm/imx: imx-tve: probe DDC before claiming the
 connector is connected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-imx53-fix-hdmi-v1-3-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
In-Reply-To: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7lyUVLekb6zlqpOSAGMVtbpV+Z1fQct7CYaiDbqLUpc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeeWD9jjTXdp/CoYzaPsKhbyUM9+TRBy79PDfc
 XNO7eehHrCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCannlgwAKCRCLPIo+Aiko
 1WPOB/4hXVGf/LzwhsVzCfMkzOBW4qjN/Ris2XQ255uOOa/LZjSJgMWkQVFfI+0aN2uCQGqzWHH
 4YQDal7J8s8zS30byb3gcc844q6FobFk+COFnofwcmZdJ28y2Vi0A2D1V86Frfq1s3KamI6jzdO
 R1Z6W0tynrioBOWxrcHGooKizE4yYiDsE/ExS+An0PoigjfeniNSsW0CGoYCRBbk5omAmriH06B
 V3CcHqMmV3ekT1hTga+WWyuEBPwqDuHrriCHNVUMq4jRHuObKlh7var03UcK2QaSbUpDjH43HPx
 I6eFwO/UtgiAybX2jJSdJpn4PJ10kpXUz2Utw0BgHGbFrFcd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MMtQXsZl c=1 sm=1 tr=0 ts=6a79e58c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=f-i-my0U1ELCb1aI9soA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zsqcBtj6_5M8MnnrEofd7XhMc_HzowJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX27n/qjMG1EtR
 WbvPuC0ELrBVeT2Yy6cgcf0zVoUhwwgFxIK1VIF55nUs6BQlmLs2O+Y2rVp0CmiVlKw01hRLjo4
 oJg07Kwh1fW3hhNutmO+lZKRYhbwME1K8ePIsmWHHw1whjE0pxmTdPrxN6+6f41zggFZsjxlb9g
 MDugiVuLIoYSaJ56R6Jc5mv9h922+mZzrTRkB58MjALZd4fakiVdJkDe7ts7mNb/a2G1LJk4wzS
 flk2opZwZll53peUJyHQ9NRyiRwoJBBfQxZE5/9Npb0rTV7pdokTbeMMFG64CsAoQFtE5nbEII8
 JiXJkU0M8zaH7mT0ZCCfTAYZDk3kGek1YA2pTO8Z7JiB7JSAVF6Rr5pY8bfRpV69Dn3PwleGEuB
 nirHv9Lt0mhMQ2KeU9HXk0skW7xhzoWnK9Kcs+9Q0TWvWfd9oimGzilbszrhSuLEA5TIJY0AIhe
 hbrI1NdVudLHY+FJ8FQ==
X-Proofpoint-GUID: zsqcBtj6_5M8MnnrEofd7XhMc_HzowJL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX50z1jPIwq7gd
 W+vKw9ujJN3f5LJxAk4ofdOQsEb8vKELlT9TGPFHCN/Qaer6DMVr3Gf8p8QjnOSQ/9Z7GPlju08
 ViSoaPboo9cdNUSArtSJsQ90saE/6Cw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100128
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

imx-tve provides no detect callback, so its connector is always reported
as connected and always gets the drm_add_modes_noedid() fallback list,
whether or not anything is attached to the VGA output.

On an i.MX53 QSRB with the MCIMXHDMICARD fitted and nothing on VGA, the
fbdev client therefore lights up both CRTCs: HDMI on DI0 at its preferred
1920x1080 (148.5 MHz) and the phantom VGA output on DI1 at the 1024x768
fallback (65 MHz). Both DIs are ultimately clocked from PLL4 - DI0 via
di_pll4_podf, the TVE via tve_pred/tve_ext_sel - and every link
propagates rate changes, so the TVE reprograms PLL4 underneath the
already running DI0. DI0 stops generating valid timings, its IDMAC EOF
interrupt (which ipuv3-crtc uses as the vblank source) never arrives, and
every commit waits out its full 10 s:

  imx-drm display-subsystem: [drm] *ERROR* [CRTC:40:crtc-0] flip_done timed out

The TVE outputs have no hotplug detection, but a DDC response is decent
evidence that a display is attached. The connector is already registered
with its DDC adapter, so wire up drm_connector_helper_detect_from_ddc().
It reports the connector as disconnected when the DDC bus is there but
nothing answers on it, and falls back to unknown only for boards that
describe no ddc-i2c-bus at all, which keeps those working as before.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index e861b8b9d8fa..11ac69561eb8 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -322,6 +322,7 @@ static const struct drm_connector_funcs imx_tve_connector_funcs = {
 static const struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {
 	.get_modes = imx_tve_connector_get_modes,
 	.mode_valid = imx_tve_connector_mode_valid,
+	.detect_ctx = drm_connector_helper_detect_from_ddc,
 };
 
 static const struct drm_encoder_helper_funcs imx_tve_encoder_helper_funcs = {

-- 
2.47.3

