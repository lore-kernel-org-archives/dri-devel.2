Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52420CA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7313A10E317;
	Tue,  6 Oct 2026 09:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUyim16t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKzil4mP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A4B10E317
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:50:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6969Qlkb1447188
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 09:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pUHikJVq9dmQEfe/H/jSfclflEc1+RHz3l/t/iTT+4Y=; b=HUyim16tfFBieg0R
 R49TMQCW0m1I7DQ4IV6nXOkrqZpMMMUTYmwrngpRr32/XG5tiUq8Gvx7KUg+86wR
 40l4wp87SBqCeFRq5nGs3/+B3U5k59RAxFzYcq2w04P/CZmZTNwqS6yLSMKGZn8J
 Tj1HKxmP1mYhCi23whIzmO45hfvr5eUy+ztOg8kuRPhrwhrGfg8RZ/vbBINEmwJy
 y0F6t+Ne8DmNVtCUd8blrqjZn8ph3H9Re3YD9qUpw/uOzFaRS11TFDCkUW9/rJ5h
 RUfBkYiGdEnpTTo/hAAMk0SBZHk0xggzssWTpB5u7ArP5W6ORW8x4buYzlnsWvgT
 EDS31g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc502te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 09:50:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-88a2c5d7ef1so3648404b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280237; x=1791885037;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUHikJVq9dmQEfe/H/jSfclflEc1+RHz3l/t/iTT+4Y=;
 b=ZKzil4mP9KaslHDH7Td+Z2WboicrFbA+7BjwN1u4hhIpbDQ1DgUs5gNeE7us8B6CIz
 C6nNw9gzJJfHbbQzMSIxhzR7604CTIV9JOHJaTjdkN6WfR1jb3blP0W3zn4edbqJIrOt
 nhqhLw71VjumrnKOKIQTpQGyZkz7UQ/iajK3vi3GwVwV9zUQrBlea3BO31s1e3Ieiuat
 n5/PsgAFGb5GnwROCFlu2iQSwAEVjO7w5kOaISZeDM0+RXklFEVafcIwXVba4+QzJEcB
 h1b4UX59uWVywlchClREkPOKQwo77UXsEe7E4xHTpTryNhMUuYAu2XYPTtRi58PoJXd7
 vPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280237; x=1791885037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUHikJVq9dmQEfe/H/jSfclflEc1+RHz3l/t/iTT+4Y=;
 b=fkxkL4/NFfNX5WkrLDxo/fulhZIcJK2zZDNNuMbtUdr1d0RJIE6Uwqp3B4XFJw02yn
 ASygWqpm3btXEyraWYOCZKanxYtFSiltRIb1ovEmG7o/sxw/1j11EXFHCQ89Fsc0nF95
 Cc6o33wu8CjP6619Na4amYjZDe2nmMYyGH21xp1uD4AR6YrDZOqgyiG/4nnOSSGHl0Uq
 rxTDv+iSbYCIrQ69LGSwbtlXLdvtov5QGLpNfgxU2pxvFXJrn7B9EzhbrOt60eDK8VJr
 KvOU42Tk+0+80a9b3eK0UQ1dnvxDZSMxB+F0YtUMNEjpCIyEH6TpoGEBrADs2RNFB1ux
 wxsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+wk/dNQEGLMnrkspnjoQmtqjf5BZ9jWRxPbH9CrW3tzgHRldy9O/7P8391xzQ8oYR9d821oIrq8Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mD5uY2SbounG+Aat49wrMEWOtVkDc2zd4KCh/9SUdbf+dOlrY5
 oq17c5qwtM2ZggocUL7Fd1amTy5x27deYf9wjMKGq9NKNY7ffzkHLDgvkFUA3IID1AO+1Xno5Mi
 oj+lWDdqe7FDa7s9TGMZn44EyrikKD9giYH+Vcam1mfeqctLpI4o8Zp8Ygwqs+IvBC965h6s=
X-Gm-Gg: AYBFou2Zk0hu3OBkEo4xSF18RMc30Qw0K1dC6BTbsBqZuIcaKQwhcFtZIa4cPQ17oyR
 lqQqj5Rt7JV3tVovkOL4Ze/NDvcCRDya5SqAjsKoZMESx7Tz1aIq7T90b7IlH0XL2PU4RiknEn9
 DM93RNMDjwzYLvIr0yDjDhyQvIRGpQaKc92IdITgCAT13pnrOkLm2PpJtGqQojwUg5vADK+hWCU
 Kcz50NcL+O4Irlhn4/APpFZd0bxqCkveZ37AyRc0ePOAnfVR09SOX8AooJ8UlrtEuhznBwYWpko
 B9BxiK89NLPP7lJfU9IyPqXVTvnbu+nXDBRS2gCtYV386Wz3BD+7ixn2szeKphzgGiAoB52T41n
 vLlgJWF/KLsKaQ8aJSF3ajk8SnaZrgvzwj8/+ylMiSetwGPa5Ua8dj+JNDPPP5aMY
X-Received: by 2002:a05:6a00:1581:b0:891:1caa:3f72 with SMTP id
 d2e1a72fcca58-8911caa4c0fmr226505b3a.57.1791280236620; 
 Tue, 06 Oct 2026 02:50:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1581:b0:891:1caa:3f72 with SMTP id
 d2e1a72fcca58-8911caa4c0fmr226486b3a.57.1791280236192; 
 Tue, 06 Oct 2026 02:50:36 -0700 (PDT)
Received: from hu-ggarmidi-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-890acde961asm535523b3a.61.2026.10.06.02.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:50:35 -0700 (PDT)
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 02:50:28 -0700
Subject: [PATCH 2/5] firmware: qcom: scm: Allow QSEECOM on Surface Laptop
 8th Edition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mahua-surface-laptop-v1-2-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791280230; l=952;
 i=gopikrishna.garmidi@oss.qualcomm.com; s=20260102;
 h=from:subject:message-id; bh=kDUg1fRRmqKzaG6Zc2sw6qY3SgF2FeNwHEhldgx/a24=;
 b=m77AJBxiEiOXnMON0T+PwcT1ix1BgC8IkQTobT8Dov8QxJKID6TD1khw2uuZIQxKCKSH9xmMr
 1OX4Ljgs05bBI2N/4rdGHcvd2OBZjtwSRHvrJ+XXNQTjncvV6HJ84PM
X-Developer-Key: i=gopikrishna.garmidi@oss.qualcomm.com; a=ed25519;
 pk=TkSjNEhrfsj90i3wkABTZtAjLNr2cfYsujaTvyOIDsE=
X-Authority-Analysis: v=2.4 cv=X5THu2Te c=1 sm=1 tr=0 ts=6ac4c46d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=iOO-S4HMiWNIuKyz5uAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX8sVtLcgVK7ty
 eoia009yqPAmwh62yfRxeK0Vpj4T3lL6teklcfz2bcsv/ENfqPRKU8HjLXeQCsdIkyQ9yFjzN+v
 7mPQiq2t7CPmzrcEYgJR8EEw4M8xoeI=
X-Proofpoint-GUID: L1lcDn-5U-R4hY5cQT25AyYQdD-AWxeh
X-Proofpoint-ORIG-GUID: L1lcDn-5U-R4hY5cQT25AyYQdD-AWxeh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfXyFrPhoip72si
 wEZ6wkUNqdAAhnWrHBpFuasnJ9UadBUOSIXMqjX+nbjmLJKw9U9/tn4GSBSdu9OYroRLfDzEvl3
 s1Dz1SKGbuZG5xxP/7boBkeTcpeOsI2yWIbzmH26fPC+mDIHsW0wUjv97OOcelIcxmMnHOiKLrF
 F20Wad4NN2dAbr+fIw387HzDV7a5Z1pWW8BCSsTnJFDjdjIO5m92yDvIbzSGbAMhwBJyl5GQYnB
 uLF60T8NCrNI7IQrOVSaBGCC9pdU5grUokkLSF326RiHPCh76OIwe1lUrapFuKPL2DAsVxa5aS7
 WLdTkiOKRod9/3G9UkPllboGQwfBNmB8PdNnf2W4p9bkMtHgmxeWA2Wvc/ve564fhY3s4vEIFYe
 Zi7Fw6C2li5X2L/RjAPVFG7p8bKc8m8SE1juwLQpV41PKHyhns0KwxlHBfO6UJoBjZ9ckdnxFDk
 uLiA3+c0b/qt9j4Ipeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060039
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

Allow the use of QSEECOM on the Mahua-based Microsoft Surface Laptop
13.8" 8th Edition, giving access to the UEFI variables and the RTC
offset stored there.

Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 43e250faea75..1fa912a9f700 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2255,6 +2255,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,denali", },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
+	{ .compatible = "microsoft,surface-laptop-8-13in", },
 	{ .compatible = "qcom,glymur-crd" },
 	{ .compatible = "qcom,glymur-qcb" },
 	{ .compatible = "qcom,hamoa-iot-evk" },

-- 
2.34.1

