Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD4BCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEFC10F113;
	Thu,  7 May 2026 13:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEywWpGS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xj8Wqci6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB45410F106
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:56 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pTYJ1424449
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MiMZZ1052yDPRoDHI1EQCs5Lnko8TFUQgp+tMPDYfxQ=; b=oEywWpGSzWRePXJK
 gmG1MvdkLWgvs6152dzalF5sQftTpJxaqH1daASeYlBM0l5gYL6pLSiH5qWUfe4H
 ulAtdmChIW1WcQrRFRMDv+jKAyamkWAj8q+pcpvy1GfdhD5pTLTEQXFepJTimqKq
 oXpidnNp2Eu3jRbNtlnwIA+nv2PLFjUNt8deB9mcIFo0LhbmV0kVAyw99zuQqDLO
 5ONobA05VEM5di7vVEqScyCEnIiVY1IFHo/n0gvqTWvRA9VgQTzOG/u+Zq1d8mId
 Ois3lr3MHOo8acLrGGpqJjE1Lfx8IlExdZns03/+lgjp7Pz7AxupBT1G5elMEZiM
 mrwKdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfs46f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso8416795ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159035; x=1778763835;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MiMZZ1052yDPRoDHI1EQCs5Lnko8TFUQgp+tMPDYfxQ=;
 b=Xj8Wqci6Ii5eSASQT/3PdI6KyRDLKBhcpN/89lUCUu4mcAqSUzW39sTiA5tFMaxWxz
 1YaC2dztm4+5FoIoiGmR3GChfHdzVLXnwbKV/Gb/TKdPGHfZKeYDqeqca/rmoBLGo8Tz
 2FOtdff6S2MUUKqYB6Z3uUSFXg9K8KvWTO4JHJ4/uuqSFgxTxt59Qc8dFGdMimwOlHb7
 c5sQvOIvD5y9l1bTDMKG/sulh+6Oruh48+RbVrQz+tPz752cqp17QWAYCm50121FdpVq
 jy8xDjSWdrPkr6NDl8wmoxnBy+GLK9IOQh2iU0FHvta2akhGu3j95SHJKXMZm3W91WgF
 itbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159035; x=1778763835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MiMZZ1052yDPRoDHI1EQCs5Lnko8TFUQgp+tMPDYfxQ=;
 b=CvHjZ+vpn0NQAsL4tCZQvGPtRi9scliwz7x4MypdFuOC/2okNHa7GPHOCawNYKa8Ho
 pbOPDYflTlJnfciQnub7CIPTNc6vhh7BzxSzF6sL5caBOOtwfMEF3DM/8SWNQpt1CunW
 tDghUWqAdapaelL7gEg29GDTxfQibChoXixmI+1BLPOt/F9RgZbu14RVcSi60YohPC3V
 1RqAG2HTNPL9aT+Z5wXfSOHe9K+9w+X1QW8TJrGet9hejmSGgOspFhdmt17B3u4Hr3n+
 qN2XsfOF//W4QGRKiXcC7XNTTBrPVoVaWN+JpDBh4aC22KHfUeDw/fb80IDuoDMnp+fD
 GXfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fPWrIbd6k9p+8tZr2nauORFZTzl6SgvIPg9vD5LH6YDFNhS7CPiAO442e2TOl0+dEOzK9j/1bVj4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyt0KLTw70qptZHhcqT8CZNlXdcVS0P08ZnXGSa1LcpldzEOO8f
 c4Pu2QggJwGZX/MgYM11guwvQXgnCIZ9Rtc7SIJ3pdGu0cIHIip0wU7jt3pWjKLyPOdWQLH550g
 R0UnHNvipCMbqsSd+bOZhRbfL/27YMeqRNHkE7QSjlnV4oFrCyD4GhXbXZzgiQfGGQH6s3IM=
X-Gm-Gg: AeBDieuLgnctiyWFgSeDLFcKU/RsDxbB9+y7kpx/u1oukoR+k+bZQAZWSdXUaMPhovH
 8l62XhnOib6hR19TBaVG93DAaqq8IbLrVV8P9W2U+SN5a36H9q1518/ZUNqhBcRXX6JGk4Vq541
 dbfN+A2O/9pyXo34tBjwrNQD2s9j7CDTIFcTmYvglXCRFYKi6ijiFaCbbXdCJEJYCvvBy24lo0c
 Plrh5IDvIKBxUXC2DA5OiZEoSVjUH4YymFIQ5yCWL1A9EOu0tiT4VvKD0dWOfvummGs8NBs0u8Q
 yH8mV9eJRteduDMh9O/3qIyBV3m+FAgYf2H3FQjk3uB3HpiUygjXEtFtM/THGzRCMkan0Pej+/9
 EB37aufLCkldYRf//kQl67PTjVzkIWhtHjoK+rWUmxPrSXXg3c7Qol1MpArv03TI4VoBZTA3XmP
 q/RQtV8zrlDgCitR1Myl12c/vVd4fsmtoKFJmHvHUGd4L7fw==
X-Received: by 2002:a17:903:4b03:b0:2b7:ac66:27ff with SMTP id
 d9443c01a7336-2ba79c1032fmr77299115ad.25.1778159034998; 
 Thu, 07 May 2026 06:03:54 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2b7:ac66:27ff with SMTP id
 d9443c01a7336-2ba79c1032fmr77298475ad.25.1778159034308; 
 Thu, 07 May 2026 06:03:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:12 +0300
Subject: [PATCH v4 16/29] drm/msm/adreno: write reserved UBWC-related bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-16-c19593d20c1d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q9RI/4rORLjuoIkao8D5cG6JGxpUvALVyWJahsPA044=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2GchYN7k+lOs1ISxjgfJ+YmoTHo6uU2sMGV
 ijFP89R/TCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhgAKCRCLPIo+Aiko
 1We7B/4nSv9/kJ3DeWZeYVRCTBVttJUCHRTg8V1FDz/S49P6d3ChSpvqwAtC6qEbbwBMkPev70i
 hajv0BIcGPINEkBkx5Szj8sd9OuxWfWFZxhAoGTkAG7VHBGMjLVOt3ySYJt/t+beCHOUxmurbQx
 HPoEnTHbPhbDKzNX4T9tAPB3L/GJfAGyO7lvLPpxRkaDVzp0U9gybFNy6qNOn2e8p9sGVtVxK0I
 6Z36Je1P7olk7igueQ1NWSgmlKYr8KFv/kTWzEjgHsqIdD8kziId5L7ePl1MJhTnIwQu/FWhIcb
 ePUi+V4fHBQFJq25foDv7SgGqmdLWsMvIA62sFVE+boCOL4v
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc8dbc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=jQZLqUlzLjo5U5EXcnwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX0a5u65Ohu8dt
 hzd0EV08w2ZnPvnsI/3CIeaSO4pYaVxW9qj1PUElzp54KfIHcGLdiQMCjtKhSMb5ZXGjnbaeTLx
 PNCcQB1+v5nlJp+J+98u0Z135Mi+LQnrOAgWSf7DlfcsvVkh3pcef6OF7dJmzNSK9zUINDtTXaY
 KJmQPaDgE7/yO8oF7FeEW0z6T8gN90Cs4leUTinA8EWFDjHTumS32dHSPEd0UASBo6vVYuIaoeA
 qEmt3xRIXSxkT/aHKwtvlxeGPKxSQJf4gIm+BLorM1vGWpYAuWukwK34XnKPZOK+J0kEtMB8PBV
 k9iTVJFB8e66h0r9YQodyZmgF09kzsG6ietPUXnWZH8+5xf49BrR4C6B5AYCzX5+AvjrreNSZT1
 W7r8F/7f11bH+Sk22GQ9wwGdmVyu/stbOwWbLFQJe0oqTZVIKEQwi/hS68vw+HIGWwat71g8wGz
 kGb/nKlXG6FLn7TZfKQ==
X-Proofpoint-GUID: nQsItdkEdYFXZPZT-lsUsTchfpqnGmfw
X-Proofpoint-ORIG-GUID: nQsItdkEdYFXZPZT-lsUsTchfpqnGmfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

On the latest A8xx Adreno chips several of the bits in the UBWC-related
registers are now hardwired to 1. Currently the driver doesn't write
them because there is no side-effect. In the preparation for the
refactoring in the next patch, write '1' to those bits anyway.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 53def136e0fc..7a6223ddd8cf 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -288,6 +288,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	switch (ubwc_version) {
 	case UBWC_6_0:
 		yuvnotcomptofc = true;
+		amsbc = true;
+		rgb565_predicator = true;
 		break;
 	case UBWC_5_0:
 		amsbc = true;

-- 
2.47.3

