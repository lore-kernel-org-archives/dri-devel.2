Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D4C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E30210E65E;
	Thu,  9 Jul 2026 12:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehOHDB5U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QAyFTlR0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8A410E65E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:29:19 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNLmo1451084
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 12:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Tw1OFA8zGlUmp7TWO31AYtON
 c9Q6jWnjThMGR0z4UAI=; b=ehOHDB5U8faluam2E45stS/nkWZJsDQKtIbtU/Qn
 H5K53bz4XetZgguAMkIsmis6tArYjE1UpucVgEd+WJC5QaRew/DyWRl/W4dvFXfW
 DocjEfyMDTLfmvKJ2G3iiWQE5erAUrOlUoNfEwDXgj19bjTc1ix9Lw3KgwFKCrEP
 N48rDIqvXij7a7K6+hS56mIg7U/dGV7cHcGoLXeIWwwHyHqv5oKl2v7dE7e0fXZU
 LshGwOvXxwjbSeAI+gDR4U75zlKYCQG8li/WQopnRjgBR52XJy938sS8zVgiPzyQ
 sJAWiOC8jM4c9fwa6Z9HnTepy9qQJQt+AcCYVISa2TbNfw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vhwa8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:29:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-744e806f474so337267137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783600158; x=1784204958;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tw1OFA8zGlUmp7TWO31AYtONc9Q6jWnjThMGR0z4UAI=;
 b=QAyFTlR0r1Ht8kHM2WZZQ2jgdku13QxMSWVGFxZoBeZKx8fcMDqeXrN4WvNZgHGHKk
 AckaE2nClZq0NC3EOH6FNa1yr6en22bPBZPctwncYLq3Xdp5GDAtvlO9aQ4wb7x6cIPy
 YpJMu/o+urbfx1iMwapLV7n43dtYso5f1hi7GQYyi6cWltbuT0ULk4THpNkFIsOU5pNT
 ux8Fme+8WzdzXQ48AVpmhpPLbtg9l00PuyfS6wCJ4tEh2Ao5o62O/NZEUvFyCZM2S2sU
 jjiwLebagYrCu6dZsX2BOvvv1AmbNk7FP2jLjphNf52ImfFVyZK23tOPC+utbgRJvekS
 MkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600158; x=1784204958;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tw1OFA8zGlUmp7TWO31AYtONc9Q6jWnjThMGR0z4UAI=;
 b=AxmwFvdGNz+uTnHiEsFGz2XaIBNUglBGnfOXqjFLfUQ8rqElMg0XVH/FyQ2W7JUkkN
 EnWHtexkulOWQfD2O4N0cWYdWF3kWkZkPFkNgyHUwM3P4VzjXgJGJVlNBZB2NQ1q0Nlg
 9qGubha4bJQP/8AMIjYQANE7YBDX9oQUg/y50d0Y/c1NUiUgxnby7cIRo8uBNdfzdeQ8
 4C13Kq3yJtnaCHLv4k+HGWdJePcR0SlmfvYbJVQ+71zfJb8rCwNvQ24TynTeJHD6u2N9
 g174YZ39RwBHp1pUn0eNlWXXOngiNQqPa9mZ6ptvcOZ13Zy7t0Vo48B7loTCJDKhAtDt
 unIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCCl8zp1y/BjP98xrpC/3pS9AA2ZPg42Vzy+7quW4S8cOdJmvSd1cPwfwiP+SqWlqaamJznFCd9yY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiY69eUaU/AWeOhMlEc4sqPO+M8Knbsb7gQFgNo1ann8lxtyZT
 3magi80w3ndAkmzQHWJtoACoX8ENTZWs1/3ayr12+zZtj/ntJUqMuW969XbsR8DnVyGlewlg33a
 8jcU89GBHaakov3A167aC+u5dMOoBZZ9Vp6u3DWftwYjJkpt2HjJMUbOPYsw8vMjE/Tu4KTo=
X-Gm-Gg: AfdE7cnJsndS9m15Un0/ufqUJ8wyU+odWJLud3xCqoGuLzOS+tO533+qX3wXXzwjyc7
 H1SMV12o0SYi6BXzV650GWuXL1Ug5dCBm4Le9ZOGkeSBTvY5EKPuVxciZUbqMnd4P4LrMWvZGn7
 3wb10jD1Ua0ehasjL16rjGF5/L87DQ2C6nuNNP+im9Ci17KAP/mFCvCAYQNC903VaQ7XZeuAg9H
 PUaIqNKvJGaeu0tv1XOCgLGwWzcxY0LHGW2A+MZh3xQv+xxkzxAxLb4E67EGKBS7tKzeB7FMlek
 ldYEPct3knlG//RTGeZ22Rfi1tRmPhof2TCpKuG3Fg4qpbusbYF49/8la+9JaW2GzI1JR1oY/UF
 xqyvfEYQYZYnqbu3HIUvjvk4ZIflhc8/81d/TXpP+vt4mmEtlshn2jnXIAKovRdzbLzkf9gOcVa
 Wypq59KmhmXeNIzJMsCIiFUvWF
X-Received: by 2002:a05:6102:5091:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-744e00d15acmr4404176137.13.1783600158151; 
 Thu, 09 Jul 2026 05:29:18 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:739:5f55:3c3c with SMTP id
 ada2fe7eead31-744e00d15acmr4404148137.13.1783600157674; 
 Thu, 09 Jul 2026 05:29:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b83dbasm3295271fa.19.2026.07.09.05.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:29:16 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:29:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lontium-lt9611uxc: add missing
 MODULE_DEVICE_TABLE()
Message-ID: <ozkjkm64rcyb7yhvaprdesi7uiryvlc7k4zq2v5echpjwppauz@on5fat6ir4mm>
References: <20260704151439.10250-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704151439.10250-1-pengpeng@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfXxePfEomTukTE
 GpUrO2OSdQ7Aw4T9/OGjViLQcM/zludHNsIhU/6yOIGPcFBtUG3Bsd03zJnz/M7Uzac3vBrLX+9
 FEYUm9IuYTHMI3GI4b4hKzDn0fPSCppRbUiGkqSGdeRL+RNn2U7M2ALESxtwIje6/2NlhI2Qlxd
 iUo6RSaedl6eVpz5cTmBvyK1NyXwKCDDT74zOmyAZAuXF8FIZxf6RJzxOPSPYzu324yyTdcbrJo
 8sUeq8EdDl4zZoTgVg2jPPNpodQx+IAEQ17WrjMviO9Z4SXvAp2dr/2VNDZ7kltfSEm3CuFo0NO
 rQBZ1Pg3/dke1MkY94AXAjKlbyHLIkSgAH+rx7V/h53asvFNlsjjdyHHdYJ6ZHiXEFZHxoNx+cR
 5u3m9hkzDZgKlLkw1XZL1j2cwnXoJhGRfPwdBKWgO/7wF3m2f2cXPvfALm8rOA0BYG1szf4IsMU
 SEA/0lJd+BarCto20AA==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f941f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_ysCb4Hr1M9gRo8ogBUA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyMiBTYWx0ZWRfX2JjfuN1FDhvK
 cT6VL5uHnd4ud6U/r23IgkftMBzYGfo8xC47UWvqOew/mDS8xcVkqLgDBpZZkLOaty0KM5serUU
 CbQTYSgY2iMfpGbWWGa3eL0A/hrKR94=
X-Proofpoint-ORIG-GUID: RkeAkJh1fmR9lvjh_2QjoNKdHGThu2yL
X-Proofpoint-GUID: RkeAkJh1fmR9lvjh_2QjoNKdHGThu2yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090122
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

On Sat, Jul 04, 2026 at 11:11:34PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the i2c bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


Although it makes little sense, the driver won't work without an OF and
there a modalias table for of.

-- 
With best wishes
Dmitry
