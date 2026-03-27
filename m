Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FDD10F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFFE10EEA1;
	Fri, 27 Mar 2026 19:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AtHExjP8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/mfQXb0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A1210EEA1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2gtF083220
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3/7oi9V5zEYfmrCd11E6BnEImx10l5mAyfwySmVa/4A=; b=AtHExjP85gtbbVeH
 DN1a8Tgx5uzN5MCN8tbWrmMKQpJk2Qgskx4TPxSmr73SZJCPwvzA3tPZu8Eshd+z
 2glXAEpcadfjrmo4nzobtDazY9DZ9QqJQAfrJZHFE4Se40dLVSDPVl6wleidoiI+
 ubsLwTvWRxSxpY78y5svwLWCxgtpkfFne3Rh7PoW1Ml9OuoakaiTTztrBO9IJ1pq
 I1+o1LXk7gUA/9mvCZaOu3Dli9sOPNsHI6EgSd9ZOec5ONnv5WCgAwevZHwDpkYQ
 XNgRezbiliLffBsKz0IFAsyLwHXE80YOfuG86qGKcXZkYLN85bo6FDOOJKjVhXuj
 tp640A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx39sc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4076dc16so56901821cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640876; x=1775245676;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/7oi9V5zEYfmrCd11E6BnEImx10l5mAyfwySmVa/4A=;
 b=V/mfQXb0fJr06TS0ll2hstLKOeeutwvIEWrl7QVN13n3T+T+4ZomnxwPZn1w9kCiHE
 0izyaDsW2rVJoFn4VqEefgOUgWaRNdBAq20WL/fEgKAG2Oe0T/OVm8ec/dfXVt4W9Azf
 STm00oesWe+n6ih2HP5G81ua3/BpfxdwHXJi6mbJdoQiTnCk/iQ2U+GWF0HFsHVxcoCL
 cxRN6mPQdM6wNUq9WM3r5rUEnaKaI+JVIsO6PTjSMDiP5Jkt4KjGbXT0hz9ouam4C9OK
 3hRga2cwWbisgwpVVhr8vntJ6JJ+8kH7/rSby41E7vq/4+BWdn81FmJL5YT9JsXSdQsX
 iJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640876; x=1775245676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3/7oi9V5zEYfmrCd11E6BnEImx10l5mAyfwySmVa/4A=;
 b=cxLF/Q3J+9kB160FhcU8bad72mGhtdnhbNn0AHqFlg/dk+6h7K9O3EGyU0fI27gGWr
 Wj80+HDiAI5o8nmZU8O1qGDrO4rk+Wvh81A5qRoaBmxRY2ulNp98F2goKRKGajyjo8vz
 nHtkW7aHznoAhco8M52xLjH4Qd2ckcu+aYeCrls2/5viKQA9s59AFci7O48B4QDoM+rh
 hmmvNwqLWSQmi5rO/v4Q4PHBAjp6eF67U/ol4eiIYTiyDnJQXUZuRl1v9jz51LoNvhXV
 TX57WMIF8fNWIJzJfNfpA5Z3CZcTZR4ORXAKflIihmbtpD1qHCjlpqNynPCKlF1KCduE
 qpxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAjSDAECFB0cLDrnH7gVbJg/cRUCSSq8FT2sMf6v96Y7Lp9h4My7b3mI8sQNuNf/Pe5ND4EEBVQNY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/GP8O8UUQuW1/7UTvFCkUSHwFwi3Ik0ze9zB2udT1R9e1iC1W
 nI9xEgGk5fOlVywoeA7ajOy2JoUJjOvrgVg0n9Ops66RurDxt5zCnofe+LdMrn929GCMXoySAFs
 k0GiaGYGyTp2vfGiSg0rgW+WJnyr3jQ0OgLeT1ZlPffUezecqIgoRkIaOdxxp8bt3EFyScFA=
X-Gm-Gg: ATEYQzxMy1Xf4OWUH9W5OvAwcWfjgiEh3DvjWSOcw6xhDD3gJx0gOeId8mssTYo98HQ
 7hlRAFu2TW2JzX3W94ALCARs/NY8NqFcLynGel5l57RwpxTF+I4Q/pYeilgw8W1Wb8cxfCixxt2
 Tr++BicbVPQ0AVmmWyQjIg+V0t++J52zyxOwSLsci/kFPMSiS4b68Sx5fAevJddWl9jtOaVacWZ
 vENib5rqz2pO8qDggutvN3XQBN769okSCTKULhT1Y90/YeXTydRpjbJcKkgRuypDUOh+G8SbD3m
 kxWDpX/WEuFuZwkGUW7+/uwOcLO4XBxtngKgLmrLb4pUiFEAFJx03mhxeYfq/ZlLCRAgAtEI9Cc
 E/q+LJ8SGKmgngy/1xGlc/Xt3oRi8VR5CXihSJ2mxmqYNsY2Yoh8mPLAkEiKV7ZjjgjwptIPtjn
 jAbz7hBna2LQpnBSUOMewWveTv5hUPTS/o
X-Received: by 2002:ac8:5744:0:b0:509:33b:ed6 with SMTP id
 d75a77b69052e-50ba38369a9mr54190911cf.23.1774640876118; 
 Fri, 27 Mar 2026 12:47:56 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:509:33b:ed6 with SMTP id
 d75a77b69052e-50ba38369a9mr54190441cf.23.1774640875610; 
 Fri, 27 Mar 2026 12:47:55 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
Date: Fri, 27 Mar 2026 21:47:41 +0200
Message-ID: <177463970794.3488980.5641186548018992630.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
References: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6deec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LbxHV1oPoWewQDzF:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=pO8qyPEA-sju0QlNnlIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: O2z61tif3FLpCi9dKVqX7NG4kcVZ0UDf
X-Proofpoint-ORIG-GUID: O2z61tif3FLpCi9dKVqX7NG4kcVZ0UDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX4qEJt8/24OtR
 4SDQ5DSwulPVkQWiCiyIT2AqSfszCZzoRsaLpqOK+Lq7xH0Bh56e5AHqJd4J3A+2n92eRuzbvNO
 vvSZSEzUsjQDZGoQS1169RzqOl4G9nU2O/SS0ij0vXt6s4agfNBwdS/Cmn9U7raMwrxPX8WBSX2
 lREyx3LkhpbYWzPvExo8vTB1bZVM8OUjIFj/ZCLfHu21YEoOzsv/QHg+lEyezC4T/amrZL9KrNx
 UsqfJYohdOIt9s3dbXpuuzDrZsBswC6OMHPPH9GDMSxt/jKFNfaF2V/HhhC0gQKjYkaTewk6zzz
 BSHcs/amRdX5/fhoRJZemmxp8oelp3ODtIZ3/JaoMJKEBOsOlk144WUbWo/5Yz1jHEviCz7+i45
 GeUIhvNzjCuJOOs7Hi5kdWyx1sf14Um8iniYu2ijFZo5XQ853st+s0XHr6Mrg7RjwtYGAdSCgua
 9PhpPJoYd97ejTaLvlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Tue, 17 Mar 2026 17:30:05 +0200, Dmitry Baryshkov wrote:
> Current topology code will try using 2 LMs with just one DSC, which
> breaks cases like SC7280 / Fairphone5. Forbid using 2 LMs split in such
> a case.

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: don't try using 2 LMs if only one DSC is available
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b9699dd86276

Best regards,
-- 
With best wishes
Dmitry


