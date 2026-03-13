Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C0F105F791
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D491310E0F9;
	Fri, 13 Mar 2026 10:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9LMONvk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ODHNFcDX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B6E10EB75
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:20:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5terl3342538
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C5GWyweR8GJyu+q701PruVpq5YRzGNbSIhWI0RsI32o=; b=O9LMONvkz1MJwVu1
 4mDumvWkef4mDErooZfYBSNruArlCTELUZkrsygODy4kd2n8IyqFk4hxKvzZ/2qj
 13hl4795ZH1HafqOsaz+8L5e1B6gWVPDlv0qxwZ0yJkm5N5TmRX57I8Rj6GTisbV
 8nMBpBi25GyRKuYPPjRCCykGTbNLd6bP4ZZlLu+zHHqX5TwRfUlqUDWFCMLIS+k8
 qZUe599yXdwUwMz8w2VRYR3LaSCRnLp8Ka3h1k+Ut6xvlqnZQ3XpDH88xuzZaODU
 CEB4myj6fqmj2ulsCnx/voufWff88GW+ptRGQBdLCpUQOx41oAxWpWyUw1rf2auQ
 EPsWSQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cus9w4c4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:20:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899fbe67875so11962506d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397204; x=1774002004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C5GWyweR8GJyu+q701PruVpq5YRzGNbSIhWI0RsI32o=;
 b=ODHNFcDXrc2V5JC/7hka7m4qFLGxpF/9qB8byWYG4Yodj8QWQKloQH9j7y5Zvj9+24
 dtRSOzkeCg7JY6QlDPJQlu4c1SdYObKPIlYwHrGG4a8UcEe78DWm2HaES5iTdP1PxI4p
 ujaVswEWuB3k2FFBrq+D/Rb3rzL59HykAu9ElRspx2KWkXaKyhU6ON0BdflaPM3KP/6K
 +rojI9oL1cRfihJIQ+jlkBZ6XOktrUgBU8bpqsSMevsoMoFKNGcDh9akzL9+IE5vF+M2
 QLRXC5CuVjOypYJKO8RBgFHYDA1FH7iZJj3whqSMHsq9887AaEZRMaDpXHGqq9qyDefg
 9s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397204; x=1774002004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5GWyweR8GJyu+q701PruVpq5YRzGNbSIhWI0RsI32o=;
 b=IVTAfLoBJeGzFTq8iPgoTUxmsBi8ZvFOunyrLS5zdF+BMvINvcd01HobIUa3SJin7k
 63dalEXkQgPZ2JycBwcOugXINKVVdDExJ39odCPUesE72Nn2lLxpHzu5vSkG6C5eTH/b
 J6zHOaBRBdpchilhC2acatsnxwj/zQkaMWtGplBmGpOiAhmq3geXJipKa0FoBF71akka
 +yTsVD9OzwzRqBYpEVBtb5hXBcJ7oSOx9LdS+KwqPo9E22WdBL7AmomK0wP03EZys3kw
 4Krd7iWJL47kq7OFx9Bao5rgCoDAPA0IekGJEeHPgY0OXY+49XOs9MYZEejhE8ylQ9Y4
 TjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUftzeVFc3SyKQ8PkKwoMRiev5aOniVAIEwXISKdRHzu5sXn9QA0Xs8sgX6CV7T4WqkeLIxmuCWGtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1SSoftZcTdf0BQf5vkUikOc6pqLisMt90qMq4xxviZrdKRh6p
 QDtETG1iQGFWKveB6C/7vzi7QeJaRoZ8Yd9U57qlFM3bV3RepNaUIPzQ5WyGbtUu4saNEoCFyPj
 Ha9pr/gnRnN7589zXpL/2+kDtfgWSlMoFHOMMiLsWr95U9jnp54nCO3FI0xcPLk8aFAFXhCM=
X-Gm-Gg: ATEYQzxc6W8Yw2Q46XsnSIOnvbovG2Wh148PR16+VoMdehFr23Y1JOKOTGPg9viNHw4
 BcMSzGhpAr9VQztZA/mr9HTRTMzcghxpl8xLGLNRpevIsaCwseXK7RR84MyyQ/YYwFnJnQTTI6R
 RDLuYFWO/Ap3fpewUK/M90fpk1+/zmI4B9PDEqiJsgYklG4PT+VNk5kSVUYEhn6CR6vfznd/4KB
 MYSTPWMhgzE5Ti5vzpnnjn93QDY2uh3O5ua8AfEEiSE1w5VJDSqk5a95T2XBqo8J8lLldWm/RR7
 SX/TBVv3v27hBu1XSHPpflyz50HQcJjBDwrTxy0Ba38uGk2EFjVK9lF/s9ygpTNBqDPzoTWiGeJ
 l/o3OpkGtBlfC0GZONXJUwaBfLuGhVPefe0xRfVui4B3Xfz+FQ6mbEJjyD9SDA+79vmGpZd4Pz3
 DBETM=
X-Received: by 2002:a05:6214:5c89:b0:89a:44d7:6589 with SMTP id
 6a1803df08f44-89a82032dc5mr27235676d6.8.1773397204238; 
 Fri, 13 Mar 2026 03:20:04 -0700 (PDT)
X-Received: by 2002:a05:6214:5c89:b0:89a:44d7:6589 with SMTP id
 6a1803df08f44-89a82032dc5mr27235426d6.8.1773397203880; 
 Fri, 13 Mar 2026 03:20:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cdb1d20sm35152166b.41.2026.03.13.03.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:20:02 -0700 (PDT)
Message-ID: <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: N6yd507z9oWY7AoTk3RRfwHkQZ1o5zWU
X-Authority-Analysis: v=2.4 cv=IIIPywvG c=1 sm=1 tr=0 ts=69b3e4d4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=e-ZaeZba6QCqovTgSgsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MCBTYWx0ZWRfXwuh1pE7FHirH
 K+cwqShlGr/ve7j7PsxdY0jmaYgSKV0tYHb2bN91rn4H5wl395xAnMuhvIwzdjhxlUo6NVgsFtK
 d44TxayoZOkn2cSI43Dz0nLRn4z06IILTMXJ5ogeHzSt8ZJ3LlhApNex5smQauffbsT7xzCfMGj
 +nzvo3Y8fgnBKPkc7FOOBPGGQTqS8reRabEwRIgwzO72VUAnx23IIGLCK1Mj0GD/+K/uZZ0jTlZ
 BkMVZ2k9L10tOi79bDd1hZ35XFA5rtYXRFWHzBsdOjjYgCaQORtFCCg11y2u8Hz+TzQ4IWuN8mM
 1nAEUrgWBZjktFKqYgrGNyEUXBYdejBwxcSa9W/sgHtCqX+Qj3vh7gVdLTnPXbJv87U1VdJIFPV
 dKwIb3ExlI5jk+pz7okaKIZCTYkrsI37/LsDnWTrD3lvgP/1OiUympNlp1pF2DVSZ8iPCGiF8aF
 FnjmWO96NjA+pdkL/OA==
X-Proofpoint-ORIG-GUID: N6yd507z9oWY7AoTk3RRfwHkQZ1o5zWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130080
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of checking the UBWC version
> directly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index ca59bcdde7b2..04efc29f38cd 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
>  	if (qcom_ubwc_macrotile_mode(data))
>  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
>  
> -	if (data->ubwc_enc_version == UBWC_3_0)
> +	if (qcom_ubwc_enable_amsbc(data))
>  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;

I know it's already there, but fwiw downstream doesn't seem to be
concerned with toggling AMSBC in MDSS (perhaps incorrectly?)

Konrad
