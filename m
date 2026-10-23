Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532E606A322
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lwJovSwb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxMagFf0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AA9112B5F;
	Fri, 23 Oct 2026 13:40:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C439112B4B
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAUIH1948369
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GMjekKslBoodemGPPh2ySDDLJdT5DA5F/zIx2IC+Abs=; b=lwJovSwb4feHyeVB
 XVS8i1jLDX83FthRRAPJfCanB/3BSMGjUOvUbEJ7GV/719UL2R0sP3KVEsGiWZnK
 BLAhSn4BDYalJdgXokzGfS3FIKDboeACnQBrAp7wkQguVVW3tmvAXtNvcWkH20hz
 WR0bUOfeUMavoat6S4u6qELaK5fQLaDxGlZKUS+g0Npv8xzgxCwHFVKuuvOkiOC+
 00t96YGBhun0M8O7kMAHATR+Dl9x+ENVmdyDvigScdIzXCrZ7WaKB/HAlqJAtWZg
 4TUVR47GqCQWjtLDF40nzzzKAfmxwKHudor7RxU07EeNRJjoP62tD+pLLHtQDzlA
 SETExw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtuwwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso396343885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792762822; x=1793367622;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GMjekKslBoodemGPPh2ySDDLJdT5DA5F/zIx2IC+Abs=;
 b=cxMagFf0pYZjpNvLPn+K1U0MHFecb4nURoLZXDd/mS+tvtV80/LaYW/ykNK0pZP7Dd
 jrbYLgnZYUVZa33QgBb7QfKW7rjAqod9GnSFJdbmnw4izVy6JnX0aGJVaKcskcjusXwm
 wpgPyXT+a3T3xlKhDSr9xwY75MjapfgJkqb/qKZwAJ0nfEtqiqHYulIGfFwduPaq6+E6
 Cl4to1vw79S3rxW4E9350Pqn/tl5BmgXyC3jzfJQMRzPseIiU5zjFhO4VdXqqj3S5pA+
 pyJxtSpRMR7TymrxkkJKRVYZp/lcVkrqbgBkdzMNRPT20+BhCDzamh5mns8kfMNz/m2+
 WQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762822; x=1793367622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GMjekKslBoodemGPPh2ySDDLJdT5DA5F/zIx2IC+Abs=;
 b=wCZIdYqddLjQeQxNSeX2IRVzaWu4PcYzck8PdSC69Zl0witidrpbGB/OLkG+Q8By9D
 DkrWNCz6ShKR/+37ewxrIG2RnEp24pds0wEBa97V3I7ciS23A/ROTvluqLXMvr+bvqJQ
 dqstptBGEHe1ctRdQd3Nj5EbvaEUJ/Nriwdgo/xJul4mCIaUSKPpx3aIb5m+Gd29QP0K
 KzerFCzOQCUT+4m+0S120fisaD9xQPQKMgQs3t5HjB69iC9EkAllTk+Ev1Zu24fCG13F
 aBVEGOANei2IGYDH/dDX/CWe6q58I/dv0DeqXz93NaWiQfQC1im8t8nhieo/FcWPTxF3
 nuvg==
X-Gm-Message-State: AFq9FYKQ568B713ltX5BMbRJbWVVYHLmIr+5ks3MvK7uWPO0s53ImGpj
 abBc4E7oqvpduKdHnFZJ+wxNYXScNW/t5YyAzGiU3FeGU/Bq/zD1jrkcN/GENTpnV0ein1oSxB9
 Mr/7KGZbhM+AoLSbcJ0jG8KTL1bFjFtL8h4Pe81f6zKsearttwxIR2q1IKK/YPDKoW8ueEkI=
X-Gm-Gg: AYBFou3zdIewkGyBfEHujI8paaRJhUH/8Pc2dA8U6Sv4O+kOcBgxVlZ0GadNCY4WWGe
 YQr8M+UZzWU2APIOOuskMfZ0dLq+kRcCTowBXR1EHlVwrWVKg6V2DBBE4iI6OeHu91j/vQVVaXP
 wCll8S68HXbGYgLYhTRdk+Joonq7XkdYH/FnuNGXwg/kbtfRpJPw0G+M8ktnfXPa+YzATyUFaCR
 ikxtHowZgTUnGFGKirf8cqrr+vmnoeJGsl0JfsA4K6IvhfF8k8Qxkp1DcstQx8yIjksfqRuQnZM
 FeJPhY1pbTNe122JFme8qj5jAjXrVrFp3jjfuQjybpHjTU41qNKHnY1ZoNub5gK9O8tZor/chIy
 Okhf9oyDlcb+Os5srg1+QsDdl48yN+dm0kxZsspRiDAVCBe6JBwk58g7h/r3oWj3s6bFmjdDHbM
 WLgi8PvisRDkZq
X-Received: by 2002:a05:620a:8082:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-93f6271feb8mr827058785a.20.1792762822259; 
 Fri, 23 Oct 2026 06:40:22 -0700 (PDT)
X-Received: by 2002:a05:620a:8082:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-93f6271feb8mr827051285a.20.1792762821589; 
 Fri, 23 Oct 2026 06:40:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac65ce14fcsm5309701fa.7.2026.10.23.06.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:40:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:39:44 +0300
Subject: [PATCH v7 4/9] drm/bridge: pass extra events to the HPD callback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-hpd-irq-events-v7-4-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
In-Reply-To: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8438;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TKKw/H3SXfDs3PoOXuNmfA50Zj1t8JLh5+PJ27RzJ3o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq22OoXQgMR8sNqQwwI15YWalXno5a6+AYYINQR
 SAiPVggL2OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCattjqAAKCRCLPIo+Aiko
 1cFgCACEBUmVLLc54TGDOCvi6zS6Q7Sl8njhheMr4ONhlUknuUbc9tV5oj4bwHx9f03y5XbwUVu
 zt8ejw5xN5EpWtK7NzfJOVOIHPb3gPMCdYUVRwiu6dFfGhhMxMitspo2FR8jVmslyKBe+TQjfyr
 8tQtmrz2ZXfFSiSz9Wd2iiMf55NdyCOSlpyAt1pV037+x35+76Sm3ssLA9Gun4DjYQekPEVDKTR
 VV5FmqawDNT+6ELAsgcOJ7A7p9ip7CthnZmUsmWsNYPFz4ZgMCK4Pp0qqWNq2UaZT0W6uBITHas
 tq/KB+b4KxpmxwZAtdTpv4/zKFO2SpTs0H1tHTc1XLpzYDwh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb63c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=m8ToADvmAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=KfJoKOGgR5IJitVib78A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: sUgIpKilSrY-IhSf-n2mU5KEqNGVexOS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX8s6lXD1ELz4r
 to7IDmxt4NWPvLHKiT72CbSsBKNXKSD0OgXvBZ5NwzuA7Xoy2FYrz40gK3QRTG5e9uFZzbvCSeF
 uTkk7WG75uI+tgA0sAKW1Y5j2LqaBoRacm837Mz5FgUT/Chtms7mrBkUE4qNdxq7af3mmstArYT
 dtc6Cfl4ab7hR4c3asvMl0vRs7QjPMi5qWhASJoSp8MAJ/LgvddQWoJ5x+20ed4wYcfjdymn4nY
 2tV3GrIkzLBhra2k1Uh1K/P8k/jwQYhAqS/q00UO0pA37k4WZq17mc+ZMCpwS8EVhiYDIDP84R/
 2Ckua/VVdUhxsK97E/2/OOF2XhHjJu8h60GsEPBWywOPfASd4aGRqSBOxkD7cwc8GazkBQZFEsT
 HxFkkaBUKyOhrDAO1r3QHa7Qvd+/dYtAv2ZxmIGUMZABfnVK1GyjCjEXuo0dw1MADJ6HGD/jUTr
 C+vcEZIDrPzOx3nd40Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX4B+XgqjG98ug
 TbEHEiStNff94ADsRNKTapXlmS3TP8tr71HZwxvHyT0KmUYz1ie2sMYDSwkbLE3x9Gbn9wP/Hph
 7L7wmdanp34SujF0qtkUrTFoq9C0CDw=
X-Proofpoint-ORIG-GUID: sUgIpKilSrY-IhSf-n2mU5KEqNGVexOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230053
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Bridge drivers report these events through the
drm_bridge_hpd_notify_extra(). Pass down the extra status to the HPD
callback, specified during the drm_bridge_hpd_enable(), letting
underlying drivers (e.g. drm_bridge_connector) to receive these events.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # lt8912b
Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c |  5 +++--
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++--------
 drivers/gpu/drm/omapdrm/dss/hdmi5.c            |  3 ++-
 include/drm/drm_bridge.h                       | 28 ++++++++++++++++++++++----
 7 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 4bc64b2885f7..deb5d510a616 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -258,7 +258,8 @@ static const struct drm_connector_helper_funcs ch7033_connector_helper_funcs = {
 	.best_encoder = ch7033_connector_best_encoder,
 };
 
-static void ch7033_hpd_event(void *arg, enum drm_connector_status status)
+static void ch7033_hpd_event(void *arg, enum drm_connector_status status,
+			     enum drm_connector_dp_event event)
 {
 	struct ch7033_priv *priv = arg;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index e347d04b7b2d..82f5232b4205 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -506,7 +506,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	return 0;
 }
 
-static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status)
+static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status,
+				 enum drm_connector_dp_event event)
 {
 	struct lt8912 *lt = data;
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 629ff7095e87..03dbb449e0a7 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -110,7 +110,8 @@ static void tfp410_hpd_work_func(struct work_struct *work)
 		drm_helper_hpd_irq_event(dvi->bridge.dev);
 }
 
-static void tfp410_hpd_callback(void *arg, enum drm_connector_status status)
+static void tfp410_hpd_callback(void *arg, enum drm_connector_status status,
+				enum drm_connector_dp_event event)
 {
 	struct tfp410 *dvi = arg;
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 1b0a1a00d8eb..4ade63306653 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -172,9 +172,10 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 }
 
 static void drm_bridge_connector_hpd_cb(void *cb_data,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					enum drm_connector_dp_event event)
 {
-	drm_bridge_connector_handle_hpd(cb_data, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+	drm_bridge_connector_handle_hpd(cb_data, status, event);
 }
 
 static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e7f9e6d58927..2bc54131e58b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1553,7 +1553,8 @@ EXPORT_SYMBOL_GPL(drm_bridge_edid_read);
  */
 void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 			   void (*cb)(void *data,
-				      enum drm_connector_status status),
+				      enum drm_connector_status status,
+				      enum drm_connector_dp_event event),
 			   void *data)
 {
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
@@ -1611,25 +1612,28 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
 /**
- * drm_bridge_hpd_notify - notify hot plug detection events
+ * drm_bridge_hpd_notify_extra - notify hot plug detection and sink IRQ events
  * @bridge: bridge control structure
  * @status: output connection status
+ * @event: additional status recorded by the sink
  *
  * Bridge drivers shall call this function to report hot plug events when they
- * detect a change in the output status, when hot plug detection has been
- * enabled by drm_bridge_hpd_enable().
+ * detect a change in the output status or when the sink has reported extra HPD
+ * status events (like the IRQ_HPD in case of the DisplayPort), when hot plug
+ * detection has been enabled by drm_bridge_hpd_enable().
  *
  * This function shall be called in a context that can sleep.
  */
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status)
+void drm_bridge_hpd_notify_extra(struct drm_bridge *bridge,
+				 enum drm_connector_status status,
+				 enum drm_connector_dp_event event)
 {
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
-		bridge->hpd_cb(bridge->hpd_data, status);
+		bridge->hpd_cb(bridge->hpd_data, status, event);
 	mutex_unlock(&bridge->hpd_mutex);
 }
-EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
+EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify_extra);
 
 #ifdef CONFIG_OF
 /**
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index c542ba6ce7d3..a21f9355594c 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -427,7 +427,8 @@ static void hdmi5_bridge_disable(struct drm_bridge *bridge,
 
 static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
 				    struct drm_connector *connector,
-				    enum drm_connector_status status)
+				    enum drm_connector_status status,
+				    enum drm_connector_dp_event event)
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 6382ef5f1ea2..c839a6993a83 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1208,7 +1208,8 @@ struct drm_bridge {
 	 * @hpd_cb: Hot plug detection callback, registered with
 	 * drm_bridge_hpd_enable().
 	 */
-	void (*hpd_cb)(void *data, enum drm_connector_status status);
+	void (*hpd_cb)(void *data, enum drm_connector_status status,
+		       enum drm_connector_dp_event event);
 	/**
 	 * @hpd_data: Private data passed to the Hot plug detection callback
 	 * @hpd_cb.
@@ -1517,11 +1518,30 @@ const struct drm_edid *drm_bridge_edid_read(struct drm_bridge *bridge,
 					    struct drm_connector *connector);
 void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 			   void (*cb)(void *data,
-				      enum drm_connector_status status),
+				      enum drm_connector_status status,
+				      enum drm_connector_dp_event event),
 			   void *data);
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
-void drm_bridge_hpd_notify(struct drm_bridge *bridge,
-			   enum drm_connector_status status);
+void drm_bridge_hpd_notify_extra(struct drm_bridge *bridge,
+				 enum drm_connector_status status,
+				 enum drm_connector_dp_event event);
+
+/**
+ * drm_bridge_hpd_notify - notify hot plug detection events
+ * @bridge: bridge control structure
+ * @status: output connection status
+ *
+ * Bridge drivers shall call this function to report hot plug events when they
+ * detect a change in the output status, when hot plug detection has been
+ * enabled by drm_bridge_hpd_enable().
+ *
+ * This function shall be called in a context that can sleep.
+ */
+static inline void drm_bridge_hpd_notify(struct drm_bridge *bridge,
+					 enum drm_connector_status status)
+{
+	drm_bridge_hpd_notify_extra(bridge, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+}
 
 void drm_bridge_debugfs_params(struct dentry *root);
 void drm_bridge_debugfs_encoder_params(struct dentry *root, struct drm_encoder *encoder);

-- 
2.47.3

