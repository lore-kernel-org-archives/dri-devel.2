Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5810F4369E
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5292A10E2BB;
	Fri, 17 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDIb4ftP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MiopBoSn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34B910E2BB
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:18:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H8LJLL1872475
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/o4OAij5cU+4lIvQWD99hEqb
 Gigke6tlElxv00jgEao=; b=pDIb4ftPbTWuv2zFN++lT0LqPW28pAfqwCn+8Iih
 wkHjFctAJF/Jbiy+Zy7ebFziAgTTCn91FKEkgSY6kYUtm6QbwFax1bbE8WGqpLfe
 KZP3Eu4cUUJ9esPJ1zBCYEiPXeG0k7yKhUJpPV1HbGXGwo+082I4ZnrZaF1GUIbB
 2u74tVRZALo8pE0/ie89t/h2blRTQ2Z0oqoEjrcpxQuzYrywyB46vvLXEv6pISrA
 XTfEa/qtORzHFJIwhQY2uwYebTHm7Wmtq4M10eo4X3Ic59g4Sz9WKdp1RTqNIG4A
 aS2KZEZqo8bXt7Yiwad0AoollxRmVaG/hW8evskFWmcBlg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2knc4sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:18:33 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-610478c6ba8so289698137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776431913; x=1777036713;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/o4OAij5cU+4lIvQWD99hEqbGigke6tlElxv00jgEao=;
 b=MiopBoSnBjbf0jOeYg6fLBGm04rWd/Prl50KVuLLX4L0h4YAnB2LO34esKWUZHTRAF
 1b7kSp2y5NUE8OBuAdzq/E64v2PWJSqd41iBLqIvNtKqjvwlkf1jQ4rPgPmLOZWRBlPl
 VpNoDDi9lvwVpi1pZXQqoQKLZmSg57kufYev+YkP547MdhPWtFZeF9xZcwYlH6V+Rho5
 dwKHettfiiHrrHFzmbhAuLTnta6MxYSRjr8gTh7qRZ8VPMB9hxcz5eFGdvGpms+D6vya
 c+YsP7of/nhR5qlZKosg3GHOZsvMZpIkppdxhzLYz8LS5Cil3z20G6Xg0z1Eagp6vOcr
 fzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776431913; x=1777036713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o4OAij5cU+4lIvQWD99hEqbGigke6tlElxv00jgEao=;
 b=an5a7iYjMc38ErNspGkE5Ts2cRXczTyZ7hM5rOFvJPmCktBPeHLRnpLo4hjixsPOvU
 NDGh9V2m8NA0o8AX03PGLiA+Ga1H8GBeykZHvO/STp0KuWMXZm/ViQXjG8bRUCesONFC
 kVfL8fBZl/ChO7g/ZuYavr5JL2AtMIbcXAGIMDrTA36CuqEFzFrN8OdRbViym3njpc7x
 y3tYu6B0oGcwMNHn2/x6H/UtggfQdutFRENJpOpKX8khR3XpFj/hOGFat6YbR+3Yuqrj
 2nlB7I4JNhcuSgMeLNWunvj1mCgY2IdDOlSD9CSo3SHV9ZJMKUwt+9BGT2Lypr2bGci9
 JQgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b4OHwOAgRBiY8E3X9r+sY4x+Cajxzhj2xN1r5xeybz0oDqqbICQo3yq8mpQEMArjIWlHqaPev1nk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSHyVBsjwA2panP3Gv7OoheLi3NrwepQPhOZw82E/ETjiwdEbN
 mUJlM6JqyLnD7SXe/4eb2i9bby3Oy0gzU12oaV4HhRErT2stYnBiki9F9iSAO5grs20nP8ZyRsG
 /Po4dmajKnDPywalKVVvj1K5/C9UXxW5Vo9pt/niYbEe06EapiSn0wF7lXMH1+hQu6MYXD7c=
X-Gm-Gg: AeBDievyb4mWO6Wtt5kw//69x8Mv2uEWsSiC9/7GIK6GZ3xOHSTKOIfRCAxvrFIq+z+
 MGZ3UzAXWqui0LL61+sDYm8bZSOHSLtMHUv3+6ugA18/q4HB4cleZgTMyEAmLW9l0Nq+oYhRqia
 W607liTIkZL5qXThcKDQDDm1OySDPQfX3I7m+ZNOvLmcieP27TDAd7NhzqVXKZaPJLz2ovhmeeC
 RAMZfoJ7eA4fE8NO+uXrgYnETd+RBIUZlcuW/S/ddCBlfUxeC234VIBiRh/gx5qD7vPJQWAhF0V
 xHVUgfcfor+VjpwzZYdUgc0BZlxF4cqQ58zc7AVsoA/EHMl45xO612ZGAUXDYeZC0O4myTTxAgX
 O9ec06P8nysnIF+9lmKhSgbY/WMJqPg80rNSxgbouP+pwxZEbQpD/X1yypvGSbO+lyda61IxH8w
 q+e5X6R7p4OjSPFP7Gf2Bzf+NMyv1zWqbksnOlDw3m0I6OPA==
X-Received: by 2002:a05:6102:4a90:b0:611:17bb:934a with SMTP id
 ada2fe7eead31-616f88b456amr1072768137.28.1776431912882; 
 Fri, 17 Apr 2026 06:18:32 -0700 (PDT)
X-Received: by 2002:a05:6102:4a90:b0:611:17bb:934a with SMTP id
 ada2fe7eead31-616f88b456amr1072719137.28.1776431912455; 
 Fri, 17 Apr 2026 06:18:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e11ecsm390368e87.47.2026.04.17.06.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:18:31 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:18:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
Message-ID: <sol4d2y3jbvlljg2nigtsjmc6iugya36y6vdsu4xyqjyvb5gwi@54vzpkaxzd3r>
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
 <ymieeagodsfbygq7fsejsqriajmncoubzvor7t3ll6ntomtbeg@l65yihnixwbu>
 <0bab12c2-48f3-45a2-a87b-b33b60b5a7df@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bab12c2-48f3-45a2-a87b-b33b60b5a7df@oss.qualcomm.com>
X-Proofpoint-GUID: dTA2YGv8TcnODjemrfZ5OEpXnnZEBPuZ
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e23329 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ltOAzfauH0U5bMVrslcA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: dTA2YGv8TcnODjemrfZ5OEpXnnZEBPuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzMSBTYWx0ZWRfX11Lt5UL72+GE
 ZgPPrWtGviYJYoneY+JSUBu0qAnl2pja+tAhp4r7SDiXBjBRLwp0YiBTmt1a3pux+AnvDvRKQFV
 OB5jInLIop9L0Es/D+T2n7+0z1o+dhAR/2HR4b1FFOLTiUQ9+Oz2IpdfPWswM0a1ZX+VMGijagA
 x9VLKAXmx9/WQeuPJy48jzJexcme4sbm8I+vJ6Wm34F46U+EyN1BysV0wFt71vpyqEK1ut4zgtw
 384ubQ6Dfrq4txh+GS+nK0SKq3CbholnZPBluzuFPATe67YL9mHDkdkCLmgLTRu99Cj2SVAjg+R
 EE2/HYlnlvjWy6cvZfwHULj5gt9/P2yrb6kEwIEqdCcx8ZTdAkYFpxQpZsr/y14Evz7B7f8oUL7
 /6Sv9uI84FAtvQFEbWIvnkRi8oUSop9ryoM3oYLxNx91M/ikg+Kl5Y0u+5Kxp1mfGNEb608WoZa
 3EdiOzLFWqJVXF9ZxSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170131
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

On Thu, Apr 16, 2026 at 07:32:43PM +0530, Ekansh Gupta wrote:
> On 16-04-2026 16:25, Dmitry Baryshkov wrote:
> > On Wed, Apr 15, 2026 at 04:55:30PM +0530, Ekansh Gupta wrote:
> >> For any remote call to DSP, after sending an invocation message,
> >> fastRPC driver waits for glink response and during this time the
> >> CPU can go into low power modes. This adds latency to overall fastrpc
> >> call as CPU wakeup and scheduling latencies are included. Add polling
> >> mode support with which fastRPC driver will poll continuously on a
> >> memory after sending a message to remote subsystem which will eliminate
> >> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
> >> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> >> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> >> request with FASTRPC_POLL_MODE request id.
> >>
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/misc/fastrpc.c      | 137 ++++++++++++++++++++++++++++++++++--
> >>  include/uapi/misc/fastrpc.h |  25 +++++++
> >>  2 files changed, 155 insertions(+), 7 deletions(-)
> >>
> >> @@ -1813,6 +1908,30 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
> >>  	return 0;
> >>  }
> >>  
> >> +static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
> >> +{
> >> +	struct fastrpc_ioctl_set_option opt = {0};
> >> +	int i;
> >> +
> >> +	if (copy_from_user(&opt, argp, sizeof(opt)))
> >> +		return -EFAULT;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
> >> +		if (opt.reserved[i] != 0)
> >> +			return -EINVAL;
> >> +	}
> >> +
> >> +	if (opt.request_id != FASTRPC_POLL_MODE)
> >> +		return -EINVAL;
> >> +
> >> +	if (opt.value)
> >> +		fl->poll_mode = true;
> > 
> > This will enable poll mode on the platforms where it is not supported,
> > later silinently changing back to the normal mode. Please don't surprise
> > users and make this call fail if polling mode is not supported.
> Ack. Working on adding compatible based checks for supporting platforms
> by reading the root compatible string, something like pdmapper[1].

SGTM

> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/soc/qcom/qcom_pd_mapper.c#n643
> 
> Thanks,
> Ekansh
> 
> > 
> >> +	else
> >> +		fl->poll_mode = false;
> >> +
> >> +	return 0;
> >> +}
> >> +
> > 
> 

-- 
With best wishes
Dmitry
