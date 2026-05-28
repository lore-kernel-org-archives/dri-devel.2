Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D9CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C1010F174;
	Thu, 28 May 2026 13:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5iYKOAc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfO1wFcN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1D810F174
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:19:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8w47q124976
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4useIf4eLqCZe5bOXRzatW9D
 bQChiyEdf+RF+QCQ5+Q=; b=R5iYKOAcT3bwEKJ+H6PZicn2pv4zi5WVmalWCqob
 iEyQidn8MrLgEbbDDAsSdNhXbVom3hP0oMkE11LHOeGrdxlU7DKFKy2Ka66d0Gcy
 eef3wV4J1RRAAZT75YIgF8PSbXw0uQuY7Dbg/Kx05jCSqf6plZ+Le37onO/P0hmH
 ZyeyicVDAsHdUqyPiwwMq36LENgNEawsBQZJZDwMQOU+qnkEvfI89sRObgpj0hes
 xp9IFpouHSyoZyvVOFDu1indYYt9vnAAikHid1LvTtYEOji3sZnAsuEJre/+UGI/
 yyRC6Qmr5qmjixQePXJkgSHFlSh95RztRMgLOugrDjWXXg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycaue5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:19:26 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56fab6d9242so25511486e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779974366; x=1780579166;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4useIf4eLqCZe5bOXRzatW9DbQChiyEdf+RF+QCQ5+Q=;
 b=JfO1wFcNvgRYTa/ckvdsMFpkfqCF5UKjfNdi69BAJA7QfF8yu6WVsIxdw4B3Kv7QpP
 Qy1iUtg/d1cjEn8guvWj187kFffFG+bxYTifFnIPqC14S1trJDrPFGvSjG0sejmNZ65Q
 Wz3vvh+PyhLGrjQBf+0B9e4XD/6zD1YdhE3rWPwKrpFsfyyRCP22MMb0SYR0pBq8wPlE
 udlqls42arBQAwenJkONbhKbUVrfICexqsFMAIZlWI5MeNRb9ZMjaXhP/tvWmVqvZuF5
 K5MOW3CKhkh3N8W0mAGGojztUaa/9UUxXOAzsbL9eraYKUgkW0TD4jwJtM88jiXjd74S
 56eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974366; x=1780579166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4useIf4eLqCZe5bOXRzatW9DbQChiyEdf+RF+QCQ5+Q=;
 b=acI0ORr9xwnSbXycAVETcluRPTUNsUz+sDHI2CZJhbOsTIv81o+mGi2Sm8UDCtsl1k
 FutKVzC9XrWuV4amY+k0ALxip0O0EYYpS3/LbhNGgQHLyIJ8hWq/nORPL5j5/n65f53w
 9JHroEDPqKqK1uEuTO67P+Lh7cvjUKZhSBWd/Zq0gNE8nxZxLInlaAMRLiCW+qJOgg5q
 G6XMAL3MiHmoPVSwyXlFYQtX8hbVTi6cJR7fGJ/9B723oSWDhX7uuRgJ99QXCSCUs6t1
 klJiAfRuUZOhnJrDt2GvVfayib4lNaTX3ZAjb4wXYeaqwnc4avFXhx92tXW34JrgHceo
 ZQhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ87jyAMEYHOhjUbkdklSEetK5rbIC2E2T/rjG/NuC37YiARHTQ8vCZDwkjpgh865snmPq6oVbrVEg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZGBstattBpGJN99RLKGPGXf5/oCASoLyGCNKGlsd4NEOPcyNj
 TkPMV30B/DjpFbmWE1vcjLmaDoSWyeXes8Guf47EZJn7CDNG/em7Nxm2/bCA9gffC4CrR2DhTtO
 QqxYBcrKB6TXmPqRQ8ypy515lUJHf43ltv8WbgSVboQfjvFAyJEOc7qNK+LY7NrJr0DImRG0=
X-Gm-Gg: Acq92OG710D63xXK+SGsJymE0eQGftq4ByJOSYZNKFkgUX0s+lvekMHRvc63Haj6ZFo
 i8T6jMq0eVKW+UqVfjVobo/aZZmcZuKjQ3bDbyr2omWx73ycm3uleils/XFrF29MDzkJJiPFmHx
 38dO3gaHVggdQDXPu07YgEsaXL6WpZWx9IiYwK6FWsw3skKKWk/n0dR6ozSL2vYsL3HdLwSTmwx
 1kKqjnWDK3bvt7Y+JvYDaIY3WtidmzwLM9LQ5VaTkHLPRXfD7mHpkb2n890rXM4pA81AWODOdHW
 pqs4UYD2cjXjkEO/Lm0ay2K/ELDqui6aMHq646dn/TNaDaVygZEkmVDFfj+X4WrTcUMss8BahBr
 4WCxxPlbECHB0YxYx0fD5T/EaxNeJnvHTcq2+9117DJC57XJMTHXXQxjLA57tanf5RZeHU49fo9
 mhBndIWRtNLyPM/rxECn1ldg/BFpQuR7P14SPvd8koFEwVag==
X-Received: by 2002:a05:6122:1d13:b0:56c:3a57:aee2 with SMTP id
 71dfb90a1353d-58660c8bcadmr16307660e0c.6.1779974365823; 
 Thu, 28 May 2026 06:19:25 -0700 (PDT)
X-Received: by 2002:a05:6122:1d13:b0:56c:3a57:aee2 with SMTP id
 71dfb90a1353d-58660c8bcadmr16307589e0c.6.1779974365298; 
 Thu, 28 May 2026 06:19:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa463312b2sm1891842e87.62.2026.05.28.06.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:19:24 -0700 (PDT)
Date: Thu, 28 May 2026 16:19:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add Microsoft Surface Pro 12in
Message-ID: <q2ffaqisybasi6nfciy4iel44kwxaiqkzc2fv2bo6omrsodbpg@mghuize6kwco>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
 <8ac29ee38ba80a3fbde8bfe43b74b9b936b31cb1.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac29ee38ba80a3fbde8bfe43b74b9b936b31cb1.1778822464.git.harrison.vanderbyl@gmail.com>
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a1840de cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=NJ6gOXVS0vVz-tHME-0A:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: jm2kbkmXc_GztBoDXca49pelLEnLxgeJ
X-Proofpoint-ORIG-GUID: jm2kbkmXc_GztBoDXca49pelLEnLxgeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzNCBTYWx0ZWRfX+0HvvNTOnwFr
 CngjO/jx9bQgUaFF9aZyMhhICDirhWG3xdp/FHAIcpt+wwbvtAyoOJo0pBCJkenrSIRK3XPAjNg
 8aq7ASuj4VFkyiiIP7y7noS8+d2piD/NeuyQFmSXPBBzupkVv7Q8sFtJcQFdNeDTjMOsCCMNzRA
 iOGxz44KYiP+CDYL8yuKxSISfoZ6nIsLRoLhIAqEwroYmFqkFnreK3119ADQoc24Khj73vllS/H
 EQMpXdTtF8X7/2bkncyoBvgn74stJc/WagGuJIS5RYKnYtKT//2A6vv+TRyhNBMmuRU6AMh8Cru
 RRg89jlDfONTKQy2vpbddzkTixh1w8cx7YhDXqQFORCKdHajtR2wM296tkaWz2tjAr/Gv/BVnij
 CCVO3N5Jne6gdH57gFXDqxd9gZrMB+Cg6pdFzUA/RbMRQfGZ9w1UJ5hgzpjmjn4HSrsRfWr22zo
 aT6cMdf5fNV3MgwgscQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280134
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

On Fri, May 15, 2026 at 03:41:52PM +1000, Harrison Vanderbyl wrote:
> Initial device tree for Microsoft Surface Pro 12in
> 
> Currently supported:
>   - UFS
>   - Touchscreen
>   - Pen
>   - USB 3.2 x2 (DP Alt Mode)
>   - Audio
>   - Wifi
>   - Bluetooth
>   - CDSP
>   - ADSP
>   - GPU
> 
> Not currently supported:
>   - Accelerometer
>   - Front, Back and IR cameras
>   - IRIS video decoder
> 
> Tested on Surface_Pro_12in_1st_Ed_with_Snapdragon_2110
> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |    2 +
>  .../dts/qcom/x1p42100-microsoft-sp12in.dts    | 1201 +++++++++++++++++
>  2 files changed, 1203 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
