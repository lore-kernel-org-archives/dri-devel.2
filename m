Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB7F8FA9A
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542B310ED0F;
	Tue, 21 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIW8pWv7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X3amF7zX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E589610ED01
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:09:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LA68QK1834859
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3qqoLhtCKIU98lhE+Indaovk
 ghDvJPWPB17ZsVSHxg4=; b=hIW8pWv7vu/YWk5OKS+ssqLrw1Jmsv1pQzxuK32u
 lbbQPlAMxpp7+vC902CItexX599xdd9mDkej4QhTFvHVruSec1d7YFle/8uVl7qm
 PP3YHyBWQJRaDEak5UUpsOZcSh2Z6SdQYj/f0qzdj1DsaR+kwLKONlQLP6Hhxe3A
 uwUgDDtNGGlsfYGW7Vw3ZwdbKwMThJ3OYqEwO+T00lv87YpiK3TYIrwaybfKGWJh
 6WiN4dxNnP7C4mZOENfMKBMxk3k31gtTMzNJS23Qd/IXWWFVzRmjwwe5SLG/AiH4
 HfkTcmbb0ij92UYnfo8lJpy4KPDfw0ng09lUkO/wLBuYsQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp76gsagy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:09:26 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-94ad0ada31bso9155147241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787765; x=1777392565;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3qqoLhtCKIU98lhE+IndaovkghDvJPWPB17ZsVSHxg4=;
 b=X3amF7zXgEqYLRygRs9Jn6HmDSEYdPLyQ9Ulj6Caj6R9SJKzCzfnEE7JUMutOmPkF8
 eDT5CEjKIpUiRzQIkFVJQCK6BmknHVzqCCF6FfbB/+OUh0q4JaecNNyV8kMLuC63Zz/2
 WQzkfVZOfBHQkbP28dcMKYe7mF7/VDE6bUAbO7Td8OPPfcCt5+cIvP0GAQOgvi8rawIL
 xWQbzscTYfoKcfAUsh8vSF1DgQL+kIDz04iIu5Oc3/B5SSu1SPIzW8/b4/WsyNZY0Utp
 x31WnvUCrNWB+vGJrAqez3j7M1u59xG+Ol0lOglXka36upPZ4ooakkrkvjexw6HaHGBO
 SREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787765; x=1777392565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qqoLhtCKIU98lhE+IndaovkghDvJPWPB17ZsVSHxg4=;
 b=U/9GCmYy7dGrc0Idgf1hKSvUjjetmwlyB5z/G6AqUaXQnhtOD4J3W1QAODlcEtZ5JO
 sD/WT4KjBBng+mtPKMxqzQpPmneVexPt53bM3ewtUiQaS0nOkJNRV1DQvS6UYMGl7wHK
 e0yi+bM0HJK18jwTK67ZAXT60ThNYBRitUluKpUUNcuduiCm5V46Sgc2QgmUmPbbCzEo
 rF4zK51iZnLJPQCP3F48q+lQJUgCdVZS1CEeeHy7/isE2WLNQJdhjY9kraLUd4W3NItk
 gcqDA0UBma8ZFoRM96WOnSrdcaTSAX9oe2zxLQNxdcljOPp+KlzLFbNyv8t4rGQcWOfO
 Rg1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XwjL0lhwDDTdHsZKfGGpf7jn16oFEZuaUoiHj6dl0AC9jePjQE96DRq+zBTHO7f0LSNlQSUuVpkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUfqgwUvqvwlgdVTPIOSRCcs82XpDZHZGkA7MEwJlZS5W/1UnE
 GHOP9ZJPbtsnzw1o0FCu3PajybxcbyWP1/8oL7KsNj3arfxwAdfb2qcsB+inamDW0J72mX9mYb+
 vjIWxkft51VoVWP84CTOsy69e2sMxiMf6cc/plblcRCTOzA1CWuFiV1FywwAKCah3PbkD3RM=
X-Gm-Gg: AeBDiesJMVc4Cdb3q76HE5sGAuiH8LQBPYPr9vzBTP1OUPIZkcwQRC3c7GzBmI/wuV/
 3deqdhF3a3hHZThs93SAxpnmq9jykapz3mJK5mCyMGAmp6ZwuSrmijwRDkABzQsvvjh1nh6z63Z
 8PRIPIu71/xeSNCTqMJZrklO+9zARqy+I1fGUZhRq3v2Y2cCfGESZUkq1RTMIN9vK5nroo3Y3Jz
 Ka9sv/J51tnmrh1XcFsN1ZTY8dUGurU7gfPh7GBkwNIGeq4gAR7TQ7rPnjCaaK1O6ACkJyrfRCy
 Z+cGndZyJw3h83n5frMAU4douU2J6hWzB9GqyMt2WGiZdnnBap4uXLOWACXs9IJNAhk0JZW6hQU
 RIE0iU8NfxDOkJbySj/JjHEmw+ZgxytpGZ/enbaIM4ex3KmID1J03sJXUTtpyxhYzRl5ugI3+vu
 d3OzQ8WvnYQZ+WUYDEgPIqtdJjEKXV6bPAsXhTmHpWfnKEHA==
X-Received: by 2002:a05:6102:94f:b0:608:d8be:da4c with SMTP id
 ada2fe7eead31-616fb8a27e7mr6289680137.1.1776787765389; 
 Tue, 21 Apr 2026 09:09:25 -0700 (PDT)
X-Received: by 2002:a05:6102:94f:b0:608:d8be:da4c with SMTP id
 ada2fe7eead31-616fb8a27e7mr6289662137.1.1776787764949; 
 Tue, 21 Apr 2026 09:09:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb73de2esm29636821fa.36.2026.04.21.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:09:23 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:09:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/6] drm/msm: Do not declare msm_framebuffer_init() as
 static
Message-ID: <i3scoal5ilinifiiigmutnzi4zflkp7hh7ao7xuwngsa5c6ktm@t3moisfrwmob>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-2-tzimmermann@suse.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MCBTYWx0ZWRfX1XOchxcLdgLT
 BcLC0nWicrtZgn+J/v8Z5ukkCGAbCmLom6fzv9Mek9sxMPc2aeV+QxvbV7WJS7HqAwN/RKClLVI
 j5wJ5beZywgfOsEpW8cQtK9c4xim3XoureJWB8pQ5FaUu+E68zKuwfdVb6QsBQKznDVr0pNEnkD
 +DD0oLAUwBh56uDVIanbcBJqW1z5K3xdI/UsSOs5p69QOdnJLkRjyNQwrc9ExUbWX0ZPtpKw9Ol
 1LP+0Nd2Fqm+PfNbVDTS99FowRm5DfWKfLC5kxM8TdiDcBWrT4FY76qlA0WQ/uPgmZJK+F4oBYT
 QsGI4b2Gx8RPRW6nIEOMRAYl6NBo5aruJCcX+QSpIlo6u8uasolL4eKzKupKAaStlLjbesBfVs6
 0hnhMiWEnp9IT9m8oO+4HQgZgqQXyrKGdXGIe4umta+MdS0gF0LN/YFcEDah5ETrSBentzAlnnC
 2zZPjlcktvYYibEWfJw==
X-Proofpoint-GUID: 7DOt8X9Z_QyYYKkvL2DxGG4xocr5R5WH
X-Authority-Analysis: v=2.4 cv=crWrVV4i c=1 sm=1 tr=0 ts=69e7a136 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=I2v9zooOMI0D0AckUToA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: 7DOt8X9Z_QyYYKkvL2DxGG4xocr5R5WH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210160
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

On Tue, Apr 21, 2026 at 02:51:14PM +0200, Thomas Zimmermann wrote:
> Declare msm_framebuffer_init() in msm_drv.h and remove the static
> qualifier. The function will be required in msm_fbdev.c after inlining
> msm_alloc_stolen_fb().
> 
> Also move msm_framebuffer_init() before msm_framebuffer_create(), so
> that it can later be made static again. Prepares msm's fbdev emulation
> for using client buffers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h |  4 ++
>  drivers/gpu/drm/msm/msm_fb.c  | 72 +++++++++++++++++------------------
>  2 files changed, 39 insertions(+), 37 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
