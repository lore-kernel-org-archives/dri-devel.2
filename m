Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4EFCA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D188992E;
	Sat,  3 Oct 2026 00:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtcAzMFg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdLaLCoM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CD98992E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:46:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne4Cr2928154
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 acP/SVCD5qt0mkL6J4sXpOMzffwmRvuVbat3/cHG+e8=; b=LtcAzMFgc1O9Q/VN
 e3feZBVeF/zp6DeArWUbaNRvJgM3YEsex3NWh0sNyUeTAMXxLfEjPc8Jz4eIuwrX
 5YobT13ZouVcY6vxl96Xq32nU9y8/XJj/u7l9lE3Ex0tU93HRmc+7FMeKXsm7Ncy
 PR0bti/ZzrJjIpLt7hEEyuXau5PP3uLDuiWrLL1KEgbHAud2fK9/+y82/cERPdDz
 RvUqO1DYKgufDf+2B+YNyyCP23cYDb7+OWRlDe2AGXaHIY/z9Iia83j//2WDCPi8
 1RvazIoo30yMKz46ZRlS2w2kvkA4C42phfR/dF602/dc2zewkZiDUvrjWX5sbV85
 5oXc8Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfvvt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:46:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbacbb996so20163085a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988414; x=1791593214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=acP/SVCD5qt0mkL6J4sXpOMzffwmRvuVbat3/cHG+e8=;
 b=hdLaLCoMzyJwZ1vNiQddRkdFF1QX4cRA322+aQ9X/7Wog1dMo61p9kpqaNsAVAayn4
 qfySW7sml9R8AviYaix20wCj1KsGFe367/mzQFg9hL8UWBLKzqhGllfiEKpu1lI0vAc9
 dfDsdoTgXvkKPT4OeqJs+rKA0n0y+EDajQ+Mou31aKa0nLeRHJT7JbNrwfkFAI7DM74C
 GiXFVO6CluFUL5Wg5pjYNmaDgSW3gi+DTnuAqm2CmYGhDwa4nRTJrvKRT/qKnT6V3AND
 mqO/ChuHDt+coc9beujAVS3HsKswgC+hKNXAzXpWM9l5t95x8S1EdDpBy6U5p8IoaJR8
 3pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988414; x=1791593214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=acP/SVCD5qt0mkL6J4sXpOMzffwmRvuVbat3/cHG+e8=;
 b=h1zF4yxz3+qqLtVPgZUESk59uWxWN57/Ym7Xd1ccohWKqpmW7fdLsFJBXWuJO/eyy2
 JqL4Zrtm2WUhoKhJBj7Ffe/UOfAZeYeQQ9YC5jmOQqXOraert4t3X3PdDRKTO4F+0+lE
 kO5tjpOH0fW+p4CBkazlnmknZq/mFZjzlORLkxa9A7MFzQdun0e9b5bKPCht7zC7LImK
 B92U/oFDQkoqpIyhnaVvh1z08+wNRJUg/waIuRh8n9aHlCuqmTYL39vMrXcE+6iSD7Pl
 nwPNXl7bQE5sb2o/HbZDjmUQnrkWaOyQzlVfKsJBFsvZHSKEYn0NBvbuP7EqXU1SZHst
 9aYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxST8sEh325rt+h9nZhDd0dMsK3iffZcJjZh3FRVcmTuHwHMxhcdEP93UFXYVxhnAJpihOkWYWFkDc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWxKebmc6HS46bmKxm0ZNzRMd/KkHgf2RANgAW2cLuCg/WLfbA
 vZTeTgz6aTKr6C3Y/NnGcO1hTvJAg5ulI0PofgNC2SDwlC7YtlbMSEk6VzS3sugc2sCTwZrD5qG
 YTnwSR0GF/+YIncdNqNIThfEponqUjhhnmpF5tw5nGg5rzec4/CiazIMkxE8ELaIV8MdkNKE=
X-Gm-Gg: AYBFou3ZNI9mAoZJ7xn+9lbDfB/nwOJtOwRpvZB37HWhSJFOdGQrI6Pp0FQCvswiL1H
 V8z26iDxHUdEEkyE4r0Kgs+2COVfV3J1H1WJiig7ev+lrtXszaj3ylSiIW2wjcm6HuCrYCgbTpi
 XoJ5W8yRbr7Qx/AyoMdtAoqMH7YZXhD4TaYiRRyPC5xGdJCfeHrp20ngiBNag1Ykd9rQlxw9tqM
 iGmblh0CjqfhXdOOeKK4SGu4J/9/7anHB16XL0tVRipzHCL5+oteY64L1bIRhZccT4myTWIg/9k
 oY+pRU3IWjb34OksOgjYmaZZX5ARr078wN8bn7BeNIabSya4Pj3CjOq+EUET2/MyVtgxK8DaR15
 sPDSRRzsIcDQS1XpoCifHe/SMJFPqRQfZwe5fD6zWal2j6YCjAWCdb7TVNTHtmTW/OaRRbsEuH7
 S5RazJ5//Gf0wl
X-Received: by 2002:a05:620a:319d:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93ce94ed6camr814411285a.13.1790988414112; 
 Fri, 02 Oct 2026 17:46:54 -0700 (PDT)
X-Received: by 2002:a05:620a:319d:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93ce94ed6camr814407185a.13.1790988413562; 
 Fri, 02 Oct 2026 17:46:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:46:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: drop cursor pipe for msm8x76
Date: Sat,  3 Oct 2026 03:46:50 +0300
Message-ID: <179098834080.3641559.9462474422543913351.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
References: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CPWPDryZJ9QwwKZxqvTvJ8-Dk72YA23D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX3NAhHd36uzbL
 pxrvuBnXwvdzvhY0u/0XpIf9q+aaiGFxuNDDODpn8anhLqOF/aiD3IvXeYxkR3yoaEvHUbx1WDc
 vhq01NPMvSV0kiN7gOQxZlp3qXhH/H8=
X-Proofpoint-ORIG-GUID: CPWPDryZJ9QwwKZxqvTvJ8-Dk72YA23D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX6zZQWxmkoUzZ
 HUpC+8BY2E0I59EcSMmPpBUFJ7zUo0NqZdHeYgR55luDqgKDk7K/my7AzxvI5kfyj+F3CmhgKbv
 U++GpwsMKvCwG7/9N7+9k9E/LZdWScz673nHcqslV2l/mQ7Ou1LojnlAHQo+gDbPK328GTQkmqh
 K2EcjJvIivM3vhF4NyACkCv+qtv7STFAMXZsDKxc0pfBcRqYr+O9PkBKZb+sqvyNkD8mCNU5XTG
 lCyNsV46EfV3bzx69JCoKixPUUZtv8WLAeQLZklHBOEvuT5Z0UpihFrrQpW5xEeL6n0z4t2F5zV
 wngKWl+NRQVJaVYy2d9J1dz8PvbonSS66xK94GSbNVQPHnpAv1Jn0bq31O+8s1QXWC16iT5mqio
 6MihnC4KE/badfGXyNwc/4KeJ1rVmDupeyKl/9DhfaBigO6NsNWoNTgbN7m0ofmZvL4CyyHuMLV
 wtlDqttTx6s1CXWR4TQ==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6ac0507e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=VSGBqGf-xlBxKiEaLwYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Mon, 14 Sep 2026 02:24:24 +0300, Dmitry Baryshkov wrote:
> The MSM8976/56 family of platforms doe't have a separate cursor plane.
> Instead the cursor is a part of the LM block. Drop the erroneously added
> pipe configuration, letting LM to provide a legacy cursor instead.

Applied to ttt, thanks!

[1/1] drm/msm/mdp5: drop cursor pipe for msm8x76
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c33cee4c07f1

Best regards,
-- 
With best wishes
Dmitry


