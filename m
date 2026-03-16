Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C742F53D87
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC62C10E323;
	Mon, 16 Mar 2026 18:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3B1nt3A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PTlKqCbh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B00510E323
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:50:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GF4Nu2795437
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Q8YGBda9KOWCRb2Cug1HV/KM
 YV+AJlVa1FamO6IJAT0=; b=E3B1nt3A5bsRv/nTpUsvIg4h8p7ERZNQOPCcPQtD
 ENyY83BT296WCI+Q3y34BUfmwZ++q2STnSQLYuSeYSQcU5MDe/A9Ol+7NU6L/Tyo
 oe3s2UgQJwOtk3RWMpcCteyvngj7Wp2d8lgsvOGafye8+P5inFf0N4q1EjFJIhbr
 jl7wsmnRzpErSOzzc8rOwPynWn7yKcODKJhaSGXDnG6T02IH6QnReBdcm9Xbz7RF
 RzC4AeFTQjaw8aTRRiqL5Z/rjUPNneUW5qm/pzhLIWw+jOHkJNF0R6djZiwzoEQE
 AAXMOqV13FfQ15fsHudKG4kDwvqyPZA2982RCzL+KPOKAQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm6d0v19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:50:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5092033798eso69674681cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773687053; x=1774291853;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8YGBda9KOWCRb2Cug1HV/KMYV+AJlVa1FamO6IJAT0=;
 b=PTlKqCbhqW9ebIqNF25CKEv3FiBn2M8luokqKBaATo8z29h3Kq9mf5A95VdULk31mq
 6twr3YVsG45AsKqx5P6SnMC1deeAXPuE2vXdqRmRXzTF2FnBlOesuhj2P++mC5mq4ZjW
 zIHQzTiftk8GwZ7Xbif5IzS6rX1HIu+aWoptN1cigLOZY40Ft2U2DbTjN9BCwHKn79Ns
 rkPExQAgL7m7v+YBSJEKvoi04N3Rr2kHfDsbEcK7sfWnVRPkmM0DtrDFDCTtoPoRsie1
 +t2QSL1OUfR4Lb2bgtxKiRwQ1HovPUErfD//VBTR6Yf6GODf8PgFJHubdsxr+KIhmGTt
 xD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773687053; x=1774291853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8YGBda9KOWCRb2Cug1HV/KMYV+AJlVa1FamO6IJAT0=;
 b=Din1xFdN8AIfWe5rQi53cCzINVLY/tLqImC5Mn0R1/CbNXFZBiYoUk32YVobik6m4A
 9HFu5rq9fdsJ2iE5V1NRaqtVJ7xN1vBLLMTt9l//sb4b/VrKYqPA5FZsECDDgT2YRTcI
 WMYQNLkbHshsUtjViUXeNgxe0jO4JC+alcjG1K9ByY1qRWxZcgC1zjEquPdqN30jNdyZ
 TVECpHaryrkDm9OIVY9256owmarn2DAim80D/Zc7PhyhJKhQaKgdD8ziZ93/ZO/bH+3h
 OUWH+6nrzHxR/LaWXtwcJUTd7V9KoZJ4XbaSmMewD6VlGn20ZxThakK2bULKv7/Pp3VS
 wcRw==
X-Gm-Message-State: AOJu0YxSdLCv8IkVDlE6RBYm3ggEx/na8yZ5Q3ZcvssgrVrS3rjqML4P
 W6n1ZeM27v3MVLkzdoJvBn3HUeOA9T+oh2vHW/1QizgO0VdIMuXuHOZaFsoeUrEzJJEPvz6vV1h
 RerGyVJPUVtJUzLjNB7wJdiXWecJrkE32F80dEyh2RQxBa3j9vcY2MY5wai5BKxm17o7rX3k=
X-Gm-Gg: ATEYQzyge2uyKLU+N7PK1HctcPSWHKxOThW6xjI10Z/x0uzKW7SM+ePP/hrvqQOsXrO
 xArOYjPCvLbGcHVRbu2MFMX9JPYmmNOwIWgyKfe5412A+hWi6hTySoE/2az9cPJzGLoOaAWAOF1
 NnBr5GdYw0+WhXjRrfDkAsIATwXfPGrq+ulGIVs+BAX93jFT45CZUXBQ9+MBZ9oFFTVDTmj6B9E
 I4vGsfhFTVC4F+MT+9x0ZmH/NCsOKh+gVMWzr1HJLcjMQAKiyAkR1nN8SK71NtgV37jzvidaPIG
 QgXJr0AnYKA2mNMbrZrCaqtDioFjgY8wH9jj7deLjV+iHIwvDcl7XfqEDSak0u53oEhgMM2dDFI
 hzdQhawGwmuJVGIUtX1eGkWEBNFAuJ0cgsoVsPetQoDWOroftRD9wb9EXW8+8Iy5PI3TkVf3Ifm
 92bi2+E8o/6+4oWrfvpJujFOnSfqbtMJk2MOY=
X-Received: by 2002:a05:622a:198a:b0:509:4342:9980 with SMTP id
 d75a77b69052e-50957cfb4d5mr190496741cf.33.1773687052848; 
 Mon, 16 Mar 2026 11:50:52 -0700 (PDT)
X-Received: by 2002:a05:622a:198a:b0:509:4342:9980 with SMTP id
 d75a77b69052e-50957cfb4d5mr190496461cf.33.1773687052405; 
 Mon, 16 Mar 2026 11:50:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156162ac3sm3712137e87.46.2026.03.16.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:50:51 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:50:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm/adreno: Change chip_id format
Message-ID: <l5efwvmvrla3we5a5mgf2hrngtgyplla5avolda636apgycve3@fkyet2nl5d5n>
References: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
 <20260316183436.671482-2-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316183436.671482-2-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c7+mgB9l c=1 sm=1 tr=0 ts=69b8510d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=LrZYsQg68yZ-jVbP9dYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: D4GNrCTAoQDGT_aamh4DKBjTL3cYno_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MCBTYWx0ZWRfXyGF8lXIerYMA
 +XlRkxo8E5qvD+mbfs7UfGB+osUmVbMITsaWw47cdsLmWAw+706/LVuXGkq443iLECTQ4bHYMSI
 z/yb4FxUf4fZ7WzW+B8Lgl46ciTYf/I2CBazAbXqIl00BwnApr/NYme7/G6uE5x+iL+Z6DJZq40
 jN1v9deaua84jjAUm6uX7OXxUtY4Vk+hNQnwurPmMWX8/6dW3lSVb4NWv4OeIKRc68BTRMOj+O1
 vf1yclfaRGNaA0THZWGldNrpX+YJf4zGVOJV8qfor4f0/+7urCpeWrmUQhCcW3d2Qavakim9CiP
 8jwsG/OXRJAm5NrAboTBXpEuIfYAkgSwzYr6sXA7s2mzug6NxSLUlzktRPHMAS/vv6+eDEWBAoJ
 Ymq8/jrDvxUXTGs1lrmDZaSLbsqRGmgkBZnu4SjzPmYwDJ/DbPrFM627zurW8CGiW0QmZQSn5Ux
 c4UjPU43PjiprRteFsg==
X-Proofpoint-GUID: D4GNrCTAoQDGT_aamh4DKBjTL3cYno_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160150
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

On Mon, Mar 16, 2026 at 11:34:33AM -0700, Rob Clark wrote:
> The "ipv4-style" %u.%u.%u.%u used to make sense when the chip_id was
> simply encoding gen.major.minor.patch.  But this hasn't been true for
> at least a couple years.
> 
> Switch to %08x, which is still easy enough to read for older devices,
> and much easier to read with the new scheme.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
