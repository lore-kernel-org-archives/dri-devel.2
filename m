Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3344F3ED5C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B42010E263;
	Sun, 12 Apr 2026 00:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YT3y9Jhm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIXv0qGK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA23D10E25C
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:00:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43QLo621302
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RZ6SZmB7GxAMhUsegl55+JuW
 gBPAgi+FiM1cMMAS/dM=; b=YT3y9Jhm1g5tXCkYxQ/zSdWwM37iCWOmiBclvkK+
 Or0kkdMOmVbbvUpDlnUNReA4DlAd7sdeLKTWdfpYTE9O17NVeLS6ARmj5pGwmwzp
 76c5evMmfK4hWR58SBOumkxbIN5oFyQUn2sheMFSqrBNELoKqIqDdK1zHRQpiVYS
 SlxHkGY4Z9uAmVIItXk8r5qrGameAOn9E3U20+a6D00YmCljTFpl5JJkO71Wo141
 xZOBI+Z0Pur53f1slBp7eeaMo64fOurH4DmC2ick0rI4gxu/MLiwL9PCpM53ggXa
 iL7PQjYwGwFffH8FEXOF0ospq84TuGsbg6x7vivQ7Pa9WQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfshwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:00:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4b81c632so16921531cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952037; x=1776556837;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RZ6SZmB7GxAMhUsegl55+JuWgBPAgi+FiM1cMMAS/dM=;
 b=BIXv0qGKM0UypK6BzK2W4fSPTh9DtOeXttsSzenOFtv8tefxH4hiB2RBW33GjTaU49
 ydMw1O5ZokzlNGgTozyoosW+jzDk5MPTo1b8nozUemISHd5y+73OQzk5Hz5Wj+/imyAH
 knTZYxHV3zygS2W7onpPEyrtPW8Vb295Oa2VxL4EMDEmJryVJufBpbWUREyDxDRcVJAD
 JCD6ukP/jlIRDjsu1PF6NbteMMCuktk0bhefwzEoMJjCEWSOxvb54Sf+8JH3mYIc25t3
 83CqdDD+WgXhrr3pd9TlgptWVQeaAHd5xgUpw0GYTqwHF450HsEcsmVf9e1ZqUV4Gc2W
 k4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952037; x=1776556837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZ6SZmB7GxAMhUsegl55+JuWgBPAgi+FiM1cMMAS/dM=;
 b=RmCFOMVIa1caRYwWxHHHmiE/e/klaswdimsXbRnENFmNegxxDxzvacR6s1UatSyI5+
 MKGPcaWGdgNDujErJFVRtwhvt3kfbI1znk88NyhtImOhiylELCV274PmW5NJy2glimTg
 C4KeSusCjtmQsgZ0UZJ99uk3peongMrFNZOV00vpvaG1u/mKyu6fvzMQoUTvrQ6J1ka/
 mjmMTtVg0cwmgcKacoR25WBs8MYtHTZq6SmXZyAxq0/X0F1PM4VT1npSjvMWJafnAt1V
 /ZHGyS7waSOpB23SjVGcv5OeJd3F0llND3PHz4dyuV+GnQjEItSKAmoYCYpmvxDPIi5J
 ojKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMJnlwzM6cSrJF2qMoYuYXvCC9FPgGxYXg/U/sPIGfuWViz1YTn4+DOCZpiY0PORBOaHbpgFxNzpI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkIYxleSlKTStapAY8/CjV4UFa9PZfvpTX/sPBAnS+GBmwih8n
 9saK7U/Mvk9RIjVoocOfPXUXgfJgXBgWgtPYVCHjkvi1wP6Yi+jbW+DMZRDy+V0qudRtdTAVVSx
 qOdOg8kY0NMXEB4qC94BD6AgrL6Pf+u8L2Jm6+bJNbd00NBCEpAIJR0P4MbfEl1JBGvUqxHg=
X-Gm-Gg: AeBDieuvc6CRwz8xLB0M6jetkwaRCJLrRVw1+kHpVbwpw7xV4sbokWdBGwK7RYGrl9b
 HMJnTuqMcdSZxwgCLqjFOAIKBpu27TRuP44gFYPze62wnYaNFUQwyG03qnRFFBT6by0StVKAUqQ
 TINW3A4bU1YIIcC04H+BdwPXAcDLI3/tCFsjnVpzbGMccKxV370yqwcLWUBcofBCusuKUH3mmIi
 2BjW2xi08qcg1jJVjzem0KiIC1be8dlDrk8DSDecJ69x5DncDbUjZL+QJpX8IRkZwosI91ODJ7B
 dfRXwJzjm6fmf7bJoi0N4kQc27MLqdRc7hT0ajwgHT/NpQwd/V7VO0Auc6eEnbUT3ibIlp+6JpY
 tzanP0w0mrrIw4bHSHF4DTLOvjyNUML5GIYdFfgwH7rb5VuoE0PoWJEorVs9m10vMVZJEUsH8bm
 d4k7k4b3g1Mx5Con3R9zf5xPVsHLBCK4PGPZw=
X-Received: by 2002:a05:622a:1496:b0:50d:86cb:db80 with SMTP id
 d75a77b69052e-50dd5aac472mr124876321cf.8.1775952036902; 
 Sat, 11 Apr 2026 17:00:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1496:b0:50d:86cb:db80 with SMTP id
 d75a77b69052e-50dd5aac472mr124875741cf.8.1775952036467; 
 Sat, 11 Apr 2026 17:00:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeef3003sm1651884e87.55.2026.04.11.17.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:00:33 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:00:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/39] drm/msm/dp: simplify link and clock disable
 sequence
Message-ID: <klw35brevymi66f5o4acv5i7hu2yoc4boidtsojcpmnawbv3iy@oxpzhet3gjyk>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-24-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-24-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-GUID: E1D3cT6wG_YLCuXHiSeEO0xTngxn2wER
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dae0a5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=j01KFDZj9uNjKbeLSeUA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: E1D3cT6wG_YLCuXHiSeEO0xTngxn2wER
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIxOSBTYWx0ZWRfX80yuHdLRVP/x
 YJL/ICEvw2HW0uJ1/k9A7anckNEopt+9dnUoRfOrz/MGxLxPYD+zudEWh9yOxAcTzQa+RVmpusr
 x0Ejhw0KKnmq7A7xZ9rSG2l1cUdCWEYc9clkw2C1JwVhZ+VwIZ95dlrrnReY9zBOHKd8qcvVRe0
 6LGyszBdR4otIreTezmvS1xuO5BQC/kW+vYguaJzdaQK+GWn3JJA29z64S+9qWzByoYZTpg/BnZ
 b0uifhRpQhd/b9+F6GfYN3GuHRbpJOd+I+iiZSmY32no0hTTzCtPodKfFutBHoVbR+Vy3NvL4rR
 tPBZHgMXvyDG62m3Hf0+57IXpTxev2vdOQNVvCnIfWixvyRTnR36s/cUIQleIdZvNZYV+INU1nQ
 zUfrpOqyBLhqaBw/pOlhUxYAQUuWCAnPEdWBXuv7A8P7/yZGJSUugLVtjPhhvWWs5LR7xFN7BuD
 jwV9hqH7s2mS2/3jnbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110219
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

On Fri, Apr 10, 2026 at 05:33:59PM +0800, Yongxing Mou wrote:
> Move the common disable steps out of the sink_count check to make the
> flow easier to follow.
> 
> No functional change intended.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
