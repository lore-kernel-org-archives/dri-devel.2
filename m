Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61F606A88F
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mge3O4Cw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ehMPn+XG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03B310E7E7;
	Wed, 11 Nov 2026 13:05:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A492B10E553
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCYvQQ1359103
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hDLeoRycWT9SktFPdwCLoZ37ME2W+Lxacb6xfAmuc+I=; b=Mge3O4CwSJkvft/M
 0oULLG3uxOE3oRd9OmqHOc6ZLnVhTNWkBctwmxVN1uEjgcR5GeY6h7EVMbRahlm6
 E5aCb0iW840dXFUSH0TmnYRAgtuf2iVUovfsdy/Fw50fOqWy0YIyUqRmmgzh+YEM
 DA5UvugwCKzvfMQxRKoLf283EVC4NQrKqeS5yl9hsOd5ThOYbzxF/nXyZ8FtADfm
 hTzHFV0Ufopkxf22HKBdlHrJ8UleYb1fqWe5TXSzTST6xWIhsfnChWJZVKbCJGJ6
 pam1beh7NBu6e1pJ9NS4IRbt99jfIokbhAu63j5Pi6otuSyowaOxoPsJhQIVsjFB
 zfLeWw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7psbun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so2186199241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794402335; x=1795007135;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hDLeoRycWT9SktFPdwCLoZ37ME2W+Lxacb6xfAmuc+I=;
 b=ehMPn+XGZO+THu8aRGOvie8UNlGg+z8pEe/2okFxua0sU5EIjyXP7f6PcxSDS9kVhH
 iik1F+aoPX/8nLyWgb/jkGjqKB9OphDNVhqAyHJKkhGjUCqhfq4rDv9OdUOj6epZhdSR
 XBceioHZ+mWTKYP8zH8nhXgVuLKDdUR2g1XZlwmpdOKLwuF43Yl8TOgMS3+GdbYVmNIu
 RiZvKiE4lME+Dlr+9pz7dUfP48d7MVOiV8ZF4vhHk84xPNeQ7EXnW0tQvQlu/BZ7pq90
 2RxNh28DK3pQYQwYEPSxnCTqLsHLROHsl2rg3FPKbAD9nFMG1VZ0eV8NqeYjqqqVUfIy
 kvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402335; x=1795007135;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hDLeoRycWT9SktFPdwCLoZ37ME2W+Lxacb6xfAmuc+I=;
 b=yZuRocbu0EwdSlLzphX+FDWNcDVlRyGzu3QHPa5Xq3yuEiO/zr9xDt7Dn7N6ux7shg
 tSR3J6Tz7fBrutrsSiOQ0ucoOg64B8iIZOCR2xT4wcxrVNAB/JJujbVSSk8uPeZPYxlP
 0aVDLnw8rWv6p0BSNp7A/Fx7QZ6k/4EokgSGhJ4yEtBUGO8vqgIAApvFhmaADZ1uBYfK
 Dm47DgxPpR4xWP6tI6HIikj6cXWrXTnIXZnPGA4G3ob1ykrurErqYZ1PhCebWE+WuxuV
 Mmi3zJQ/p4GMj5OT/JbcSe7hP1s6cewxht9flweSWybjFZfmeGcINBGKzpKhBt8mypVp
 nOHw==
X-Forwarded-Encrypted: i=1;
 AL+hErEXLW0FHMxwMGSu2hdONSM3sZm6lic9vb2RLAT+1ACf4+Opj7pVsmqYKVjXeFpQu4LsFU4nLOu2uL8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S9LQqTKRZEpjVTPOjsyNmuZeZJ7QPHyYcs1L22d4V5EDL+Z5u
 l/blsCzV/WJBXai9UvsNlAuM/8BWrJnpGdvxRnNjCnSVCSwXsHiohpEKr+y0CsZrMguEoC7fUiP
 zSb9MIa4vtQvXs8LM/bGftlNo9mGdDiT+e28sSELlXxu4Ljl41QucC7IWWM7xjQ/cttYNws8=
X-Gm-Gg: AYBFou0XBU2oJPHCQkvWgM4yVnYsgVNNksoYRYWjmkdtDAzuduo9vlCgU2OXthib67G
 +JrI6fv/vyikZ55+cl8gInh7PXn448fP9lH05Jut7sKUkhXxvHaGMOnRM1XZUxwXvCf6qexOlb3
 e+QhfaG3UY0xdn8FEEWSTfvuFcwhmqUKF5yjlQJGytZqUDK/jgCmPRszFiLgy21gB50pGlNp5Md
 lqqgMkDWX/t/jH2EUkioZsSEFapl0wDlXvhuTOeg2ptcdKJTbMtZjUAkMTLreQFo9wPWAh8slyY
 Y719rH3B+iNt6M7fSv8cux9mM4gLWfke41PnMBHSlajgmOvm1GFFXHRBlaPODdt7AhfF5d5qB3j
 REiaut/pgOM0Ch8oDyULuWbwv2A2hkt7mvDs30W181A09Alq+CKJHi2YEHwt67kEXlbfB1zTc24
 cx4kpOizNfMz5O04bgX9IMJWfO7meoaNCQiI+93DpsCr9+T0UnbPMj8SnnnvaQaw==
X-Received: by 2002:a05:6122:6b8d:20b0:5ea:dc36:245b with SMTP id
 71dfb90a1353d-5ee1c474bc8mr607052e0c.18.1794402334745; 
 Wed, 11 Nov 2026 05:05:34 -0800 (PST)
X-Received: by 2002:a05:6122:6b8d:20b0:5ea:dc36:245b with SMTP id
 71dfb90a1353d-5ee1c474bc8mr607007e0c.18.1794402334231; 
 Wed, 11 Nov 2026 05:05:34 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15d368e81sm391858e87.21.2026.11.11.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:05:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 15:05:14 +0200
Subject: [PATCH 1/3] drm/msm/a3xx: report CP protected mode faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-a3xx-fix-me-v1-1-d81f50f1ba1e@oss.qualcomm.com>
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4Y+Iv8q+tsWXTJKMzXRLMGryRf3mAZDY044kGmA5Nag=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq9GgUTPifT2R98oLnAuweKYncAzC263DJMOnx9
 QaisRxcyIaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavRoFAAKCRCLPIo+Aiko
 1WaLB/sEAJNtbNDwO4OauPCLF+uCRNRvoFmLZFRL7gSi57adZOlEkNx+JKqvx9S+op/InytelPD
 zjekmDD8voqBhuE5S1cl4OeGWPSXUOg5y2anGXeAd59Ti32LUWq4kbvSkIqtsxL9cFewnlAPMGx
 2JLzspBz2ZcIvMORoAKhyv4YiflsYOzq9vNS00bySGQqufZHJrKWBrQi7AvChRHsekN8lZBNejn
 IgDu8/mL/lWbPs6anNZ4aY1X5Ozvaf4Okg9HsIzpKooSLbg1+wzpyykMY+RvAeP1StAZJ1f7eRO
 XqmO0SQ303J+I5Wx2lIJgaHw+4lBz6/B/YLTkLuP+R6hWRfV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX1gKuVEjQxRTq
 pN7ze9Club+/JKj8DLriAQUXvWP8VkfZJmvpgDJ3BQl9n36ngMXWkLRog8sr6M3C5cYVwQCM75u
 50sC5IZsUKgAWjxzs5nLkZpBIf56eAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX3Q5XF0GsqrfK
 W8ckCaEfwJ4DGubXmetFoEI+oMX4IC7yWhDuvH6QIrUV8nCuj3fIKZ9uIfqBUEQiovMtIVptHNp
 tEKPgSs2jY+MCHEjL31r2KbWZDjy6YcVVTgdRdvycqFSl3tPIN8tFqvsssQbqjbjb895B1abjjy
 l4jo3Hd5goSnOzMPa3HH0g7qRQ+e11hqzAuPpeqEiF4E0dDOTsdRtkA7zkc3iiQa3PUAdZ+vekf
 XT4xRZKQV7ScrIqXG/0myyiHk0IexsLcQChfmC+6UYYwj0VkZkY96ZWn4z9jkNXPyU6E0esQj2M
 mf0oyVKtx3EHkrFtR/rXWklNMLApwaEPDdquqFB8VqcU86Up9xdn4TZieecEoloAi6z4zSuUMqB
 tnx7qZSqtuUWryIOmT7aK0XMFCi8J6deGFSHToDBF8HU8ur81gbnVGDhxRI+e3gpYrKKAZI9CKD
 +ctf21VSpIEUVdbWF8w==
X-Proofpoint-GUID: JZ-zIWsw6Us1p92mDjXNH55epcziwHpX
X-Proofpoint-ORIG-GUID: JZ-zIWsw6Us1p92mDjXNH55epcziwHpX
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af46820 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0SDkzDXPlMfVP_Iu0jUA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052
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

a3xx_irq() acks every interrupt without looking at it, so a write to a
protected register shows up only as a hangcheck timeout with no hint of
which register was hit. Print the faulting address the way a4xx and a5xx
already do.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 160d302e16a3..7e03b7305493 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -419,7 +419,14 @@ static irqreturn_t a3xx_irq(struct msm_gpu *gpu)
 	status = gpu_read(gpu, REG_A3XX_RBBM_INT_0_STATUS);
 	DBG("%s: %08x", gpu->name, status);
 
-	// TODO
+	if (status & A3XX_INT0_CP_REG_PROTECT_FAULT) {
+		u32 val = gpu_read(gpu, REG_A3XX_CP_PROTECT_STATUS);
+
+		dev_err_ratelimited(gpu->dev->dev,
+			"CP | protected mode error | %s | addr=0x%8.8X | status=0x%8.8X\n",
+			val & (1 << 24) ? "WRITE" : "READ",
+			(val & 0xFFFFF) >> 2, val);
+	}
 
 	gpu_write(gpu, REG_A3XX_RBBM_INT_CLEAR_CMD, status);
 

-- 
2.47.3

