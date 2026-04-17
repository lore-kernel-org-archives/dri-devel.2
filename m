Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A088F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7156D10EADE;
	Fri, 17 Apr 2026 23:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kjxik8l/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZyPBJXV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067610EADE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:19:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4DMU4044157
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VnGT4yYVSKKnHe3hN22Q2w8W
 ITpizZZoB8Nb+Aqiw/4=; b=Kjxik8l/kP0StwaiCl9Uu/V6uelDcj3TJnEVEXir
 eFNyVuCBluBP22jyJKJb0GDEEbIJtzqNV7//La7q5/uYzfVJSHJlHnP7fW/rB/ai
 OSAADRl9/s01zZJLbvIbWFXCwwFmYtNy3ZhzkNi1IwlNNgYl2EFDh+Hxpj1EYQfW
 5lod/UTKXXFmvGx+C6ZxsloQUGPUqqjXpBEuki4Ni4WKV7aGdlnzya1C+EUcXBpd
 kCRH0EA3IfaegcoPGUPvfqgpOkAepkkcvlXGFaqpJ3E81YcboDiiiljMHkSGlDBp
 sxGf497Ui2l71of4pouHL8UuaqxUS6MRoPRbDf3tF5WDmQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkqumh61y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:19:03 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-610503b689eso1518618137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467942; x=1777072742;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnGT4yYVSKKnHe3hN22Q2w8WITpizZZoB8Nb+Aqiw/4=;
 b=aZyPBJXV4TeWU914WxdLIzwsJZIeyo8bKgyUVQMnuvnjcHYheaKRrDeJoaDafMGeBN
 /F0OEDNyZawbrZ8UpoZj3f7UH3qmpr+tCCq/FSoswUUOmP1AszDeMyuYM8TAXUEsvW0p
 gVc6+aa6Y5kqonouxlRdeP+wOreZiQCCuHJcJWau0307pBKFX4BPvd1YbC5DO98ucKwo
 peZdRRY2VH5yWc9Sr2AdOhnCrk1FyFk9/EBQVgvrDx/3/GoGcFDVe+lMm+B1DapJA43q
 wcwg8ijSvkbJxgodpkKZJWdi45QiSYIcWXKIKwPvNuYApILFQd7G+NwsStpzbhFPtPoY
 T78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467942; x=1777072742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnGT4yYVSKKnHe3hN22Q2w8WITpizZZoB8Nb+Aqiw/4=;
 b=gll3aYy0ZfI21bLBHZlqJaRscW6+PboqAhnWKxgUF41VXTkqzZM5QCfruGSDfnHUJ6
 W02GN+O7qWkf8on8sk6cpEUnrAeeTs65RS33bjWind3Me2o4PYoqhzycPE0xHfUHClYo
 3bLjtp2+pXGigMkVZdxYDSgzO5p0hNPXrmtbYYx86J0QGlRI5tpQ4zgac9qEjwzwnmGr
 sG3WoLN/sEq4MJxvepL5GFuXe8ceaDvnwSAF2iKP3BAbNXUR+rY38X1E9+mQAU3d/y/t
 h46S8D8IepQIcnNGpwxBHClsQAd8PvUhJtEwjkIPcpRa+yWF+w3h+4MFe3YDbpvdDAxJ
 lgBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oFDqHncTvs1skmL4IgdsRWUewypj2KfvLyuLXZthNNZ1M8I0arEFAOS5Qw1F9B7y0MxpuG8y5OuA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzwq7pIk45l2AbheRyfEnIcjg+ZabirokeLMc5S+NJPcMSXNFCs
 yhfLvkzrUB1iWCl1uGAyQzNI7A0dbYcbzNRdtH6sofpGEY6i3Znp012EgR+fx+TNrokr4bthwfg
 ZS1pFjGkSJMelc9c7V7EtukkLeaoAwQd3AxIYrS0EJyqmAkrTRt7y3MGnh5GkdHOULM4JlOg=
X-Gm-Gg: AeBDiet7lvSEy2L9C/4gPZvQmGlgIN5se/znszg5BNXM7nBXPe8qzw/uJUF8XJi5Xgd
 tTE7Aau63DoqZ7ZMuxi+YX7ybCgU2VQ94QwJz8205HNeApFozlpYlYyeE41KimAZ0rBJYlofUgj
 eBTaPpPIJ+jvw6qpU0MePTxS2FA7mLvJ2T+P0I22TSBXbQ1j75KNhUOjgKNTOAswhHqECgjWaf2
 zmjWMlwkIcuht4M/ptLMC52N+DVNlUBEENlIdmQ2gI8PXo3V8x9MlH/CzgE3YYKKSMG13YrupJY
 sv5qD4gKHpHsHW2ixkQlf5A2qjRQH+rA6LWQQvZaZRSvG2bPLX5anh+I0SuVF0LIPW9Eo1I0D+R
 Ao2U/OOe0gs72iNxn1kKcS4R1Q1jcim15EoBs9UWENS7gZ9WbhLGvDjuNLxQY3g8IvyHHApadmc
 oX/q6AwbSNmByILfs22LgE9VTiViwc6HnJEw3jdRCejdLZ6A==
X-Received: by 2002:a05:6102:f8b:b0:607:b901:5d74 with SMTP id
 ada2fe7eead31-616f4d7d122mr2879167137.9.1776467942064; 
 Fri, 17 Apr 2026 16:19:02 -0700 (PDT)
X-Received: by 2002:a05:6102:f8b:b0:607:b901:5d74 with SMTP id
 ada2fe7eead31-616f4d7d122mr2879154137.9.1776467941658; 
 Fri, 17 Apr 2026 16:19:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f5119sm6297071fa.2.2026.04.17.16.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:18:59 -0700 (PDT)
Date: Sat, 18 Apr 2026 02:18:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/41] drm/bridge: adv7511: remove now-redundant call to
 drm_connector_attach_encoder()
Message-ID: <fubj26rg2rxywerlk6ftpafmtwcbkuljkcr7omgy6ngd73fsgl@ofzzwld6udjw>
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
 <20260417-drm-bridge-connector-attach_encoder-v1-3-67b8b8fb872a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-drm-bridge-connector-attach_encoder-v1-3-67b8b8fb872a@bootlin.com>
X-Proofpoint-ORIG-GUID: un6EWQbjjut_fFDsVF-un7h63n0-9_e_
X-Proofpoint-GUID: un6EWQbjjut_fFDsVF-un7h63n0-9_e_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX2kANu9S/XguM
 1yp3biGdeiAbwzyUC3OQNLd/JXgP1zSz/o4Bolh1EnYpQ59s46DzygIG300H7pkScjZAvlWH+0e
 OsjF22ciO1Zxo1svonUQL1Hgv5n5j2nYIgc76cS6csJkacsxAGRw/Rh3ZWi4XtXvCFEm+e+vRx2
 cGrMxYrXUf1nEUHeorB96U632+yeEMCmMeuKxPhCKcpfSttgIVYLUcJcVcKil3mz5BUV0I8X/3U
 0Wirl4PtHMad9VnZGde9rN7xqKf086tj831wJaPUnC1b1cEKJFmohD5mNRrkZv6jPmt7hKAxp+6
 tOYp3j0vho+bpP70u/CEs+gjx/47xS1Ukiuz8hIQ/XCWq48j114KfPnleqAcLV2ZcQ+zNsdD1do
 gJisBH7tQJpMyySCT7ma3OYTpv83bOrckIfa1Zez1fH5frXVJsr6CTK7QsVLZSskXG9hjSgB/Gh
 nOyHG0DX4pqxZvq022g==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=69e2bfe7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=84E8lGIrwPO-yZbwuzUA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170230
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

On Fri, Apr 17, 2026 at 11:57:51AM +0200, Luca Ceresoli wrote:
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
