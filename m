Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F3F94CA2
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF8E10EE40;
	Wed, 22 Apr 2026 00:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iV1SKUUu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YL1UOrPs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEE210EE12
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:14:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZnPE3730712
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fa9ijfGy2njsQ7eq08Ou4TCL
 LA4Ab7TBDNn8fSAtksI=; b=iV1SKUUu+JucCiYy4wvuy5+Cp2uN8ms5cwi81ylE
 vLcNe4yAjR4T8FrFFs0rYrBzSNzKz89ZARj++V3pPbSQ3w6xbuWl9Z38LX13Aw8Y
 84U1ERuHqEX6AR4fRlOAh2hmuqfywF6P9q0xKHP9byucs7+DGkzztafAPfLhBUDx
 pP/XlSSIrAn37OwJVfyauzpfkFd6Loatrac32J7pm0mhdZ6+NitdC38GFXc8nawn
 ofWralYCAYDn2PWHQreSzjNby2rcbCBOXyMTGSklb794dlDbi9fZXmcpxLVBxUt9
 rz6u4J68zwVhR0WW77GyN8kP7DdFn46pSmicJvTribA4NQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfrupn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:14:15 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-612d26038fbso3095057137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776816855; x=1777421655;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fa9ijfGy2njsQ7eq08Ou4TCLLA4Ab7TBDNn8fSAtksI=;
 b=YL1UOrPsTQ5g+k94S3sz8Gai+dYNia2wZd4jTBGNFzVU8dYCUa3pbgLg1yX+aCdhR8
 iQSoxuU8hAz4NC0YOG+yQf9z2JC9jav2no5hc2Fo626v0GfW8oFdP45BDY5GPwm5ufMh
 fC6qxH5NpbSEX50LfvUVdbpjjXAhW+Q7PO4UqRdQrzJnvubbVlbiNEKp0CjsWw12D4WR
 5uVj35nRqX2UoeGp1ED+KiN7K7ABgRh1A2s/cNNaVW6FkUvoYhJsPHJ292ZtpdsU9FnG
 OIOoFIY3BMpNW0ZktR78IOc//8OsJLjMurYWknqSMPnsu2cNhD0vvadQDy+eKcRTI+TT
 4hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816855; x=1777421655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa9ijfGy2njsQ7eq08Ou4TCLLA4Ab7TBDNn8fSAtksI=;
 b=aN6Bb1+F3bJxjNsZv2FHsMUMoHH+pxg5I9pjpBBMGrnF/zErKLuK7HJhlsuBHCffal
 NGZw6xUCsABl3CHKlN98rMDxlnKvlX2hcj4c+Z7eh845d41HR7n8A7277d9H2/0oNjww
 7LlBHdi/7I2mIjke49j3ZWTB9yJ/7vSAhTfU7+KPUFe8OEIYz2wvxZM23btXzq/5xDLV
 gdPrHExH0rIjRL/4IpLxVn2gjkqTvkmuQzuTTzUf7W8ppuWaRcOz6qd9vZvPAAoyoQcy
 Oe+ylq1QedlmjwPqDInsC66KGpRAQoyn2eeQRCTKKqejFO1Ty2Sjtx8b/ODlNFUqaD2x
 Qj7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ISagbMa3bSd5BX9+F86Edud6NGJd9HjE+Q6fkLRp5wjjkk4iupG8GBPG8N7nIFR4buFjP/L+eYLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhRSwRCBVbOZVvEHZdn/q7WeWOKnVTfe5y1YfaYm6Ter5pcKKq
 g0sCu7XvsT2JSduPDahnmtpZk1C3Z9hvfYqLKfLbS++BCoHeHoL/0s2XO8nmZ9qWklRx3SUVxTq
 7W8eulv1BWCBCaRtLUBNAV//iNltzq4MRTCX9ROz+n+lnaxrTZCdmnE5V5NjqQirB6QdV3OQ=
X-Gm-Gg: AeBDieuxgxEgctV21yvHxKVQcZ3TS6cNkjItIvsssYvPeJymcJtSClnoCATgCBha8qx
 t/yfeaMt2HEhmvK08FGqxVIWZ47UFmPBdsZ0cr3RjuHiendSw//ObzwmceFdd1qOqFoIMFDtcrp
 Wg2ro/J7T+SvbM1lQUWRCrCJuh3OyNq4uyyUiu23xEm3vFS7p192yrt4Nfheu3nGf9nW42KCr1G
 NyBvchBXU0Sce23T3EUgJVyCtYiaD7AJtYj9w9rdtGG/ppBmuZoykoqvyDwiCF00SCRmlacD2GW
 I0hAYTN+RlFLAP4u+Ur/zMjJT6GD80A//WMIMJwtN/DnQNtr3EhtqC2dwntwMnQngL3wVHGeZU5
 dARANxfSO5mt2pEwBJllKHasIPcFJgrIJ4+GFgWaQwBgfZj20jPlAoeCtBj6dNEhuh7kDdetujG
 0h/Xv0AZ8ISv6iLGVKD3tKGKnIA/NSnyrNk1jn/3oRh9dNLw==
X-Received: by 2002:a05:6102:80aa:b0:604:f155:9374 with SMTP id
 ada2fe7eead31-616f67c7f28mr10964533137.15.1776816855101; 
 Tue, 21 Apr 2026 17:14:15 -0700 (PDT)
X-Received: by 2002:a05:6102:80aa:b0:604:f155:9374 with SMTP id
 ada2fe7eead31-616f67c7f28mr10964520137.15.1776816854745; 
 Tue, 21 Apr 2026 17:14:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb73de2esm31660631fa.36.2026.04.21.17.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:14:12 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:14:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/6] drm/msm: fbdev: Use client buffers
Message-ID: <tyeiktohirfdxqz4psxoxbvxogakabbnbdwcf6ado2um5sym2n@5h6ip5oj6ucj>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <pcbuciyme6uh7hmduzzykuyacwelope6or5durvddzwfandtvb@wfjyexsjra5x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pcbuciyme6uh7hmduzzykuyacwelope6or5durvddzwfandtvb@wfjyexsjra5x>
X-Proofpoint-GUID: xfCnpbWmFWDB5QN5FEHALuZBAj87-nJz
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=69e812d7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KNjA7eja_kyHsgebIicA:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwMCBTYWx0ZWRfX6RanNU4/GA+H
 tl9kVxdG+u6Plp4sHFu4mhJQ62PJ9ozYA1ctQfmG8RpAeY8McxLfbuG/1GgwOH21BnSVVhICkQ1
 Ia0oTK09yYyWNpcJVklzCUsA6ooo06cFZvA4L2Zro0EZedK0snzNOahQbvXqq+OUtvRbSQE7Wgy
 +eYonF8wmfiBZYijaefK45rjTiEkhO1onT+cBvOOq+vtO82GgKPupaEO22AHygafeUHiwxtdTle
 kvSx9koy0j5wTrnlk6BSn5DBagFQK8j9nPiHIdbymo9Tc6g0GMrSWfbipWjW9HJzh6tcFlrl1KO
 HAHN21fAqMAc+5YUP7CSU75C2LOAiFGgy8gdGB0N1f1A5SGtcqIStVh6KtcL3xks58AZLeNlMHU
 +TB7LKwibBGsN/0MFdVUw77vSvte8eyQOxho/AgujSZuVmsDHrqbPFvuAQRLImDLHLWdL7TOYMB
 VSOOQHgJy8XQm1l03nA==
X-Proofpoint-ORIG-GUID: xfCnpbWmFWDB5QN5FEHALuZBAj87-nJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220000
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

On Tue, Apr 21, 2026 at 07:08:31PM +0300, Dmitry Baryshkov wrote:
> On Tue, Apr 21, 2026 at 02:51:13PM +0200, Thomas Zimmermann wrote:
> > A client buffer holds the DRM framebuffer for an in-kernel DRM
> > client. Until now, msm created an internal ad-hoc framebuffer for
> > its fbdev emulation, while by-passing the regular interfaces used by
> > user-space compositors.
> 
> I assume this was somewhat because we supported using the stolen memory
> for FB. Support for it has been dropped when we moved to GPUVM.
> 
> Rob, would it be possible to get it back at some point?
> 
> Thomas, would the series prevent us from using the stolen memory for FB?

And answering my question, no, we still can continue using stolen memory
for the FB.

-- 
With best wishes
Dmitry
