Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7180CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BFE10F0F0;
	Thu,  7 May 2026 13:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uq1IJy/h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8Ejb0e1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F0710F10A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647Bb5QU682766
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E8UKyBMI9aXDerKMMuS9I2o4XUlZFnkN8S7rKi7M+vI=; b=Uq1IJy/htIJt+NQP
 +97RGvKvMroukDlzt519f8z+PqWkQET+cP6dWSEoY8jeVlArZ4G1orGtyCazXWrP
 lCc5d/EhRaLPN3eSv1tZfYWUr7hEDCEU7ji2geJz6m8WXMysyihaYYMnpNj26Ygc
 DrInNxh4Q+oH2GNdiFa9FTpRstwGjaqhlCg8Hdx2krprQHfYAy/IBf07kS/BO44M
 rJ1b0oD0TQH4LWLKjlLyxThQu/AKCaG+AP4gZjXhTr2zsY/8wDgj4lBBkpAMV7MN
 ROiWwRNSQtnhCbSoggSsEBtDgHZCfyopMn5kafLVQoYBFAZWGi2ClYKel2h4HlY5
 Zwwgzg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhasn0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:09 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7dca6ecdd85so987566a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159049; x=1778763849;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E8UKyBMI9aXDerKMMuS9I2o4XUlZFnkN8S7rKi7M+vI=;
 b=H8Ejb0e16Fe+wSJQmtboK177hcAXwvUDqO3kNkdGN3EaoTap7FGIhErjiqmysvp/Vf
 aIXoaMhRzWymUg+pHot8uMFQWdLh6q493QtxXN4vjre6jr5WQJuj+xgSS7KRkr6R52rH
 x+MvOHAUAlNeRnc1FITgUSI6n6LIygWzTtlg12VSWPRA5W0WeSwtFUtnU5CwOAj+UJsX
 iYd0jZkrLhGr5v7kErXsTeWWLwW4/GSrzt4w5YtV4jHzZrmN+0cgaTi41ExQXKLEZxXY
 BDo/sUE15ktliR29KQTRgJTyxScFsuJpaog94gvVYRtYbHYn8/wihRfKxbYzRLdLefp3
 fy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159049; x=1778763849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E8UKyBMI9aXDerKMMuS9I2o4XUlZFnkN8S7rKi7M+vI=;
 b=TaFXY3IY51IpDoyM6ILrUyc52eN3egp2rHyrNPkgIWkQSUK6JEmVeYwVbc9esTzJUN
 lzodAVtecZiAIHXUGQnwFP5uljacohOm6bQcm/vnzdGfxNtK4fnGn6oq/bNyJkunk261
 FGPKnQOgnGGizV3zhs8e4doui0YW7p+kdQSE9kHjlJ6ua3OdeK5dvdUhEHw/TsuykNNE
 Dl93b6nuu8xT7//GI9nV9d5GQdRHc6XqpW44B+yx2QbNJqXdfzzPSkrPb7nBwi47Z1+e
 ZZuLkMRt3uDVAnCfyRSu8uTCjmMkH5dnsX+7XmslSMuzE8DrnGPIlSQn3pJOAgoJjAB1
 Czpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hn3TfX7uweibQPM2ELNSm887Lb6jBGO/ZXk+IvF5K0wK9cxARsCMseiMUX0uHq434uywCCbktLlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMmMdulIcwi6pypw6prkvoyBMyG5hXZkuNtGPFVxRrFpMEhEgz
 P5ZT89yUG54A5CWwfXgWqenQdWO4rrXr2JaCd57DkuDJSN/xPKWttrQVAasY5GG7hgesFmXLj1p
 J7EF/aExIALMSt1nzXfInQQ1gy0Mhto6JMMAh5CurQywd8yU6COB8+nfiOKUq8wNja2PNfBs=
X-Gm-Gg: AeBDievp8KOR1yFLuq1oP0RtJT1X9bz6UZ4bIq4yEUo6GAGpEAshmfpN5PFuMXt/FUf
 iks5YA3GRZflwwvfvNujcBWoW689afurCf92Jn6jQPgYDbWaFx5WppXUOn72OkFXLM6gtKN/8RU
 t0a8wFyvPvaY+mpdvioN4ioquTgZ4efSAirtWkTTEdO6LVaJtWssEF8Qp2hsxXsFsht1PvfbESL
 BxeUoYre5cyho7ILlSbnaPccvqKvn+uJpiQ8l22psOqmglKybJ/rfwIJUxYLL6DQKJI2NmCqQyQ
 s5VgIJEwvR1WMy3B4dshNsNN34YfJ/iDc2qPGWHdeUJCnbp3B9Aw3LM4xIMmCZxBi5oPuuL/ckU
 rkOkQ/zCbXcF/s3G26vWlQuRtsEsuI+RU5gmr9kj215E/jHmteuoqIA3yS3l7vQTKQZdxvoLZv2
 Fyl/qAeZFMe205Bub0av1K476bs+qYvhMAjKUwUpfS1IfjJzU5yt/VMU/i
X-Received: by 2002:a05:6830:d10:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e1dee5c2a3mr4091742a34.7.1778159048796; 
 Thu, 07 May 2026 06:04:08 -0700 (PDT)
X-Received: by 2002:a05:6830:d10:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e1dee5c2a3mr4091665a34.7.1778159048321; 
 Thu, 07 May 2026 06:04:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:17 +0300
Subject: [PATCH v4 21/29] drm/msm/dpu: drop ubwc_dec_version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-21-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6/5IEPHnHjsy/MNdRL68KMLC1ruE2SNNotIn7x431DE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Hiuz6OTOj8UzEXAFUw/dmR4jvL5EtTdsnI
 2df/NhAQPGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1e/2B/wMxNYcytNhIYIBg35i5k6yugSw72+pS1wXnY/InuMscCe5nB0HcZfOLizjCtlCAq7eL7d
 Fy8JHAuLUS53M8E2nhjNqIByrAWWSW25IOsGW9D/SKueRMcoc2RVu8UwE4qSWZSmYIJUV/+K4mG
 6m17Ww0RMjc3Lf0L3gOHW4ZGWlVzget66HXzQgiNIasg7HcVJWhrvHy5iF3Aa7NbqNrX656jG9e
 nyNyA0C3HSB/KSgSYu5pt0Fag6Rl5R37o33oo/DedOjgB9TDZTwDu7rrOVN7E3v/OFaua6mS/Gi
 eHSCbmZ4mE1iAmT5Q73vIXlmtbKlf7m8XQt+fMtYq/2oEZc0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXwlWB/eYGmO3u
 jUcqN6ZhpDXAkMyKK8sF4u3en5hvaQe6ZBq/fCtZ9XqN7XhCR+UlZLGgN6bpaQlui/7MS7sKBnu
 cXjTycuQ1WFYMiH7YM5Tqk+QwwmcMWJCdMiVCGT8OAEIg2sFp7TDHFDvrcrNADCkZhbos7jHzaA
 TJGebrXBgIIsP1wc6iHar1dVVatzKdztTdxDpvrUACWOOMp1Jib8dtGOFKrLY3K5sJjchVIzepe
 0ogN+p3zJtzpP+yBtqm8BFWqZYhKgn5ncnKBzoIDHKOiwObpo+/wEt++MndOK5TtZwZiliH6JZd
 1+fjyDr1F8qUY5C35x5cDckTjNaKOjrgK0fSfnZ4rMj9yj6LqIKwAlQE6A7mKvOm/bBkh3/HTj8
 HpyIUdXJ6tbGE7ra+OzleJNd8y09RDe8ovtJytkOMlFJz5SP6NfB69ip4AtE+b3Wm3EfPGJ8UAO
 5qhnK/M7EpAI8TjL87w==
X-Proofpoint-ORIG-GUID: j_E-HLKUZI0o6xPGinTIgHRO4ACHWxVe
X-Proofpoint-GUID: j_E-HLKUZI0o6xPGinTIgHRO4ACHWxVe
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fc8dc9 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=OFVxzADIxEWc22agC70A:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

Stop using ubwc_dec_version (the version of the UBWC block in the
display subsystem) for detecting the enablement of the UBWC. Use only
ubwc_enc_version, the version of the UBWC which we are setting up for.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 3c315d5805b8..5f42058bedbb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1781,8 +1781,7 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
 		uint32_t format, uint64_t modifier)
 {
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
-	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0) &&
-			   (dpu_kms->mdss->ubwc_dec_version == 0);
+	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0);
 
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;

-- 
2.47.3

