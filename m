Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986A606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y14TJ8rP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YjNeztvE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCA2112D7C;
	Sat, 24 Oct 2026 00:36:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3468112D55
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv1xL877253
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 31r1EaH4MCPxAQTq2cHbU5NR/uyIR6thPFjexZfrw6o=; b=Y14TJ8rPPToVsOWN
 sBACVXmoasoTJ1BEh5WlrsTucN8+1iRREOVjNrczmobmXxX5oiHYgEGzAQr1iMyM
 u5Nmjq7B2l7gEH3SnQGc/rouMMU5Q23+5/UE0ZDYEwq/XfSNGVYHXWOKX+fISFHO
 6W211gF2HF2lAK6Bq48wtp/cS0JAVlUuak8V7GJ2ouXGjS5/uyLvqZWVgdu3UfhZ
 a0uyVvXiWUfsftHz14XyjlthFB505NTFdrw0dmbMhYjclSTC9VC2Gkk/5RUisOde
 /VquLCadl8Ru2Bli0RFKlPMToXYWy2PjslbH4K3u9hm5C8dQrp7Lv9DEDD3Xhi1r
 oNfPaQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr691kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:36:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c44b8fed1so14525286d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792802171; x=1793406971;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=31r1EaH4MCPxAQTq2cHbU5NR/uyIR6thPFjexZfrw6o=;
 b=YjNeztvEDQU9albbGQl1mr9xd3Ff7zu9ba2ItdgqXPBxlR551f5X6JpNGdnpxLonfC
 L7tzw/OsROdIi5h+C2qRw1oswWv/23FYhnC/u3D/oqDiRBjw/wkDZHeCJn3b1zu+OfIt
 BXrE2uos4RjLXRLD55G5TiAOFgkD+qdvqlnvTa/9hxvsPip0b6cy7+pk99mF06AE57IO
 e5xvUt2Xc15deEyZ5Kq0331ZBxqEuCoqAxCD+wUEvWwS3u4foHyIkmYlmxQ2+5Oys4NS
 eno8cS0KO5Aroh+tg3JddB88s/RvGcZepMUVGI2iFdDLVij8tjq1tU6NE1w2/3VP+Enc
 7RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792802171; x=1793406971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=31r1EaH4MCPxAQTq2cHbU5NR/uyIR6thPFjexZfrw6o=;
 b=ab/G6/hlU19EDywmYT9jQ+62d/cFAxjz7K1wVD8cH4/sNXD+7MorxND8ZmnzKuvUea
 lwRSpCFmcGPH7slCx3hv+LgW5xnFhWd69BlTOZMi5KAnMbdd7Pn+ycmQbjqddFwuf4+n
 Yo30z60ekr0xqm3yGwuoZYYevkOC1kvEHN4OnqI6/UOphEvRfRLG5Ke1jmZ8dJTpDscG
 I1/eQiWSLWSj9a2wCABs9eRAPHXQiDLSnBlLcfGHewIld8cINY5brriY1SuFnvEE+h+l
 0QPvkNgUN0IJlsZ3pIsfSugR6L560SI6sKKkhtivV0EsmOVhvCvrooMC54Owv7Cgi3sl
 gNPw==
X-Gm-Message-State: AFq9FYIil5VJtLr2Nvaoo6BYrfwSCNAUN6SaP4dXFIb7UsX1dpq97ost
 rQz/60oFbogk5ndsmlUu7H/rfAfJWclC+aTynZ8ZlLNepngFhHk0iDVP+pfK5+eSg7WFzvPQmlz
 h71rHz25p9i9A5PZcUG2LQHqy6qG1UwPCQFYO+7uEAJNkr/r3xfzXN/stng3T3whjNjPh1bg=
X-Gm-Gg: AYBFou2gg6HBf+mNwOemsTy6nfw7Bg5fOU0lKoT0HCSTKJNrnWgWJvpWumiBvWC2fy3
 rKXO3rI/LW2EvO0k2s9y2ZC7OhytJRkoyaLq4Z/FtGNTiibK44ttkt8z53mKgpV0srkdQkxjDWw
 duj+7R8h1OxIt2k+Db7ivu/UynY2v1+qQcqCQ+Haz/Ko0lwMAcce764IFtjvloZT59cvvMZR8w5
 tkQlsyBsJkQKmBInE3q2qpwzFhBJ7FThpNz+IWr8TE0IM+J2P1nWTt3pFZjRYBF2+vdfJ8aCQKg
 R9aAIbU+IanzV05NuamvuRLAS25HoS5V15riA2gi16GJRJil13az2gtIMql/LpOzOSOMokRNPcJ
 y3M3nEbzd91jbsonaBeY7PKYK86j9Ovta+fS+tZIMTeJjCLtOuIpQ6O2CTBXaLstu+WWyKa4mvm
 VGDiShxDiaO9Yw
X-Received: by 2002:a05:620a:45ac:b0:93e:f0b9:505a with SMTP id
 af79cd13be357-940ef92acd1mr116215585a.58.1792802170855; 
 Fri, 23 Oct 2026 17:36:10 -0700 (PDT)
X-Received: by 2002:a05:620a:45ac:b0:93e:f0b9:505a with SMTP id
 af79cd13be357-940ef92acd1mr116214485a.58.1792802170444; 
 Fri, 23 Oct 2026 17:36:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d1cf7sm1126651fa.15.2026.10.23.17.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:36:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 03:35:24 +0300
Subject: [PATCH v8 8/9] soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-hpd-irq-events-v8-8-6ee949e7a384@oss.qualcomm.com>
References: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
In-Reply-To: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jYsdop2BAded35utDpfgQd5r9JZyyy8UmHQPRLGSyhM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9btvyFFnqxLn4beuyZo1X0kPkzxT7j+V+WX3wPT+pKeT
 63zd1PsZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEMprY/zt1hWckG0xdONPL
 Z4HYo4JG+c0LTsazGwSXB27eVK1/9LVac+vheX7Tem0dWZwOtG+6t0xbSqdF6d2X1sKZ/Amhk8/
 0dJ+MtVES2CfvLHK4ZLXWvR97hDoFdjh75+zr6Xx7PKvhlZjVSa1jYtYf8t+cY+K7kJVi0GZo4/
 GyvP/hoZdb1nVNjXbazZJ4XWun5mYxn+4sxd1i207MkZ4uEGnY9zRlpWON3CNz1Tn2mub5kkIlA
 o43lQRXPf4kK18/OX7r2Tvz1Fo44l2aMs/t1rHi+jY7PC3KQOT4xIiNk1LqeTZYbo/iEkvxenuw
 9vZhBqnHvLdO8a1UV4h5WZP/IWeV5vHwc5dC7jRK5ewHAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbfd7c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Wdvqb4HS36tEXOME5F0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfXzO2Lg9cvOjCM
 k6caac5EfklVUUV1qLQZYtkz83AkGxfIYoBuWgZg2Jg86T5A7DkK4sAcPL54yIEkX6JHrfnqoIq
 BA90fywdvTwCQDGtQFW/Nc3t4mAkkN68ykrR3dkLarDU30Lh3WNWDXxjVqjvHwyzqEDYmqCmn+H
 vjMGjPSKEv5dgX2/NQLyUeZYJJ7lJlenT4zSMPIyGj7A0dnbaNukQnEUHCP3mPh2kQqVPR/Oxmq
 kQ+jY69ESYU7qGtqeoBtKqvO3q6l+wcesKv8EWSLes80nSR5qH6Mdc5BrKaZxqstEhss4Ma7kW8
 uz48f+m94zLtG75HG9SkoIkAe3kgon/O74fQKA9g15D2hhGoWXzKuJA245UWxUR5z/OnDLk4gW2
 EhW66PGIOkj5Lj2juip0V/57Cf2k6rAYw5arLo0OjDkHe1WbhBOc8I2ztoAlEbaEGVpDglZVtEp
 oUuN/IPmb1taq5pLYow==
X-Proofpoint-ORIG-GUID: qkeNy1oc4jd42xO7HuwkbJD56r9JOKt0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMSBTYWx0ZWRfX9mLUIUiU0jFn
 DUyBI1g9S8w1Vg/GdpWB030WTNVumYiis5qAa4XtTd1p6LADoOwlYqTX+auOEybXnIcjm90LJcz
 kd3r5v05+Cc3VV806O7UJ/mZCapJeFE=
X-Proofpoint-GUID: qkeNy1oc4jd42xO7HuwkbJD56r9JOKt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240001
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

Pass IRQ_HPD events from the firmware to the HPD bridge, letting those
to be delivered to the DisplayPort driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 13c434f8d03a..c463b23c99d3 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -374,7 +374,11 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 		else
 			conn_status = connector_status_disconnected;
 
-		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+						conn_status,
+						alt_port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
 		if (alt_port->svid == USB_TYPEC_TBT_SID)
 			pmic_glink_altmode_enable_tbt(altmode, alt_port);

-- 
2.47.3

