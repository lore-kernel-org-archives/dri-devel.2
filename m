Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D21F8FA90
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D0010ED32;
	Tue, 21 Apr 2026 16:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdQjvNCx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8y+TUdO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D342B10ED34
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:57 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LA68SF1834859
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rcOVoIL16qipe3CVXLjQUxem
 aNCdSh2840igdyFaeuw=; b=IdQjvNCxZC7U+dvO33PUSAJHOjr7aHUIrp2+r+dh
 MEvvhpt5rzCHZh1G+yFFZETBgG3UWMHqyvxT4ji/C/KtnNwpGIMKPo0tOdfHKWiu
 N8MalkSifZzK0VYr49Iys4tK7Nc/eKSeIWZrRyHwED5qaB+vu2nj7leW+imQGSPs
 RnVc/Gj2622bAArQii9wuVbsrnBbLaYv7D9THYqWhALLruIXa0n8anDo/VO+yCI3
 gCCPeO/0gAdd9+tub+K/jjbyShfs4swwX12cqbFxlFt5fzjxY3tC912HXwIxLDIm
 WYBOfRoV6KkUasnkccjfMWKvcgTZ+V3lYZ4FWFJ3ZyYiKQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp76gsc9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:22:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6104087f037so1952717137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776788576; x=1777393376;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rcOVoIL16qipe3CVXLjQUxemaNCdSh2840igdyFaeuw=;
 b=d8y+TUdOt7/+x4bwQls1Lrno3dymDw9yOfP/S/5lFAbK3e9XSN5wSuR0lZysu5ALKV
 /OKZgV1mwxo84kliUEFYFL/zKQp/XUL9XzTCHOjSeYIcwYRSxCNZ4zxHlQYECcz+SmrH
 Tvo+avN8SkJSINb88bbqOYyZAdnb3QaItFqwuk9m19UdbtvKB9Dun61HXKRscyCKTuDJ
 0qICWVctcnxxK5uLQsCsY5DJTZpzw3wzeQO+AjAsnP7DcwVIBl+vIzilVoATGDLqUqyG
 cxwj3XpnYaLzPsoVD4yps8A74Tj82ofZovNd190lADH8BK6+52Mzy8wvxRQ2ZPlWxWNb
 XJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788576; x=1777393376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcOVoIL16qipe3CVXLjQUxemaNCdSh2840igdyFaeuw=;
 b=hfie8pNA1baPHT2r5nuHPC5hljegAuFqsSFDVkwOaNlMivRbv28NmtWYF9RFY3mVRL
 BcHVMgsOBUIzyq7EQCjruABoSqZW71SOtd2N0zDmyesy+nbhqmT7kMnrJqX1vrGFqsSt
 mV7snztQU+WhRUjKNGIR1fmMb/1grZ3tvqdK2e8PLlHktIJgODQJxpXmQoH4DNTF83S9
 ulS0by/bDMUspxtzUQVzbUAFw7va7G1csVXA0hKHcOgnQ989MZtdhG535RfAUMJsH2z3
 h4nw/rHjNoGzq2seZXRKhk4wm5TVhT3ZsCK0tZiA+7b4gyZo7VO9BiBDOqf3PwF0Zfcc
 c6+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0R9q2JqzywknlKW+9ifYeugs7eSEx/18C+MRU//nFggb0kNuDY4cC2vu0lshpmoHa4GeV9JQaWOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqjIglZYokBIsZjLY6ccV4PAxui9A8IPan/oK24DISmmWrP6rl
 M3LJRBQJ7hghxQabtNhyeOnf8z9/qOw6F3YnM/pTR5YSO5A4sqzvUr4ssNTTY5yt+XrOJuomj5z
 oPlfp83ThWs+Msfk3QKPB6wz2SW/c0hDfVoQP31GGY2WifVpQhYcV0vTicsehlcY86dJX4gA=
X-Gm-Gg: AeBDievvA4hiES5rozs/uUrFvQ0R/jto3ne81yruBLvZVXrzsQxOoqXUnjztAASy53Y
 mZGUVqVCj3vk4VtK8o4WX/AqrfaLaO1RoVCEXtW3TXoDyaDwR72bC7h6zHouvp7QdPAMkQmoWYc
 rXwGcFePpd7Byvn6niIm8C2Xkh+jnYsL0e3AmjXyXMq2ZN5WKS2qFPrzmW9VWSE96UR5XUh9YJF
 Y94xbphv68MAdgWUscvjFhRy3I9gsHKouPu4W1GBf8H1LvL/6wMhb/IURVP1JYG2t5ctU3dyZUm
 fD2l6D1jXE+GzfbhAmp+Lota1NpOtEvHlrrRdumG3La7drh92SE8TNICrHhILoDxUjN7sqzN9FS
 +tJ/fakt+fHRRJMYJ0wyNmqJfmtSx8hYjLrtvPK9iSVvo5T43rrtPb5fB3lZsb1CmMChUUl3wWD
 hFB17DMAv2Cdz/Qq5881P+MDu6PmRv2rpNPi77VoiM1qYXjA==
X-Received: by 2002:a05:6102:6881:b0:611:c935:f9c5 with SMTP id
 ada2fe7eead31-616f72fd3c5mr8181420137.24.1776788576080; 
 Tue, 21 Apr 2026 09:22:56 -0700 (PDT)
X-Received: by 2002:a05:6102:6881:b0:611:c935:f9c5 with SMTP id
 ada2fe7eead31-616f72fd3c5mr8181396137.24.1776788575695; 
 Tue, 21 Apr 2026 09:22:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ec365sm3743851e87.83.2026.04.21.09.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:22:54 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:22:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/msm: fbdev: Fix error reporting
Message-ID: <qenwfdjh5yqjgxikqsidw6gcgzmg22g5spk6qerlqtqvidbxc2@sdie3l5zp3ez>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-4-tzimmermann@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX+NYWdff2eocc
 +JdHWZZH+mJtbLYQ2EBkAfKSHeAg8d2azybzs4HOJM4paubFkoZGALLo1YzFcV56I/4hjSn+6qe
 jttAH8GWJcy/BUz6LoPQwLMW5XfgAzajWsUYpq8KpYGbWmrm0BgAVv7ULnwKzshpHLc57KjfVx7
 Qk5suIMVMipaxhyX49JmSsQcTrFIVEQ4TrVlvDNxrEXmfxWSRk5dtd48irxUyH+3xxmx7E4ranS
 9E5XFLr3c8/oTt7tu2B1F64RXp5aQrGfAtS2aUUgCP4KI4opTIlvaTxWFgtUGuV/hEbHyw4nsqv
 V4I9jtdvO8U7ZG856mL5u5yoSRkBolOzDs+wAUDCamlVNj7W4Q6oOajlu5bzTglJtiV3IQTCMtT
 DOHQnVjNajFsPtV0sRPj0L4ZiF34pHMDSYvTQyYyty92g+KTaxGiItCeHv5tzHFv647Aw4aU7GU
 QKWbSb92j6RkTjSbLEg==
X-Proofpoint-GUID: rb5thRoatdOWmXveUHqoPmPOnPLHd4OI
X-Authority-Analysis: v=2.4 cv=crWrVV4i c=1 sm=1 tr=0 ts=69e7a461 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yEC9iBQ8i4zJ9DQTUTYA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: rb5thRoatdOWmXveUHqoPmPOnPLHd4OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210162
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

On Tue, Apr 21, 2026 at 02:51:16PM +0200, Thomas Zimmermann wrote:
> Replace deprecated error reporting in msm_fbdev_driver_fbdev_probe().
> Use drm_warn() and drm_err() instead.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_fbdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
