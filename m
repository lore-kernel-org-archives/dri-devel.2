Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C12CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C2E10ED4A;
	Mon,  8 Jun 2026 06:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FT8/W/Pr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDKIZ+Du";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A6C10ED4A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:06:53 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580EVQm1572480
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KlfLurUd8p3s0dk6It2TIQLA
 87lnAfygY8nlifB5wTU=; b=FT8/W/PrRO9jgzC51Yh6zwWAW79z/umsUOb0Ql34
 WHc5cXQkfQvdBUTvclTE7Rwi4eC0miveZk67xFzFDFaueE+Fo0bWL5V0bSw/pvUx
 gzF90Emdr5Sg4grGH8KTMnwvVWMRFmQEskr5pMf6WPkveJj20qQuzUvMvlRwJ5d5
 NX2pYp8AWldhuWJHXUJFMXP3jVjhhza2MnIDVOmXEqB4TVa08VdbVDZRuyVBGZ5h
 PN6syuhM5HNAb4ZY/rFnbveISUKsrs9JLinNEY1FO2DwLu5ZzPIiihnuTIiUs3bB
 Jy/oFlvRyl0+mUOii/9pZftaPkGb5gy7s5zS6OPAZfjUXQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8wy53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:06:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6751c50552dso1900125137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780898812; x=1781503612;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KlfLurUd8p3s0dk6It2TIQLA87lnAfygY8nlifB5wTU=;
 b=HDKIZ+Du72SzUuj2tDafm2Y9QYoy2rAMFbDFVwp1y7Q/uj2OPb8yRx58ZsDNtYseYB
 0lRSrr7xG76ZbDct3jmBdfOIxibCvsOjGWck325GnI6oXibRB4u3JThdadKL/Zry9Lec
 nbueArR9chXt06VKSqn1DF2e1F+Ru6IukdojoNw4ZUgHiEnPukLiWxhsOpPVuMFHpY/i
 Z7kX8HUCdvFwRfOIoKvdSKFSLJ+G2ZyRfiVhVYuYhiErJCXJVfkhFhHUiY/XdR4SSjyV
 hMJXMZGVFo6AxvbSyNOIIipQZyJMnkLNwcyP9hS7LYnfO9M/Dq4FBQW2u9Y4X17d2aWF
 Ukrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898812; x=1781503612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlfLurUd8p3s0dk6It2TIQLA87lnAfygY8nlifB5wTU=;
 b=PqrEWtTq0v6ePbdAwGENthY8C3hHHmXoYF9gmrw1/oZAVggnnpnGsj/ajTcch51TYq
 odhq9nO9LVi9z9G+gjyJAvq+oKl6u47AJw4YQilWe1jF9Fy/jtWn1D4CH2VpN65vq4TV
 kiE+A+Ak6ZYi93HJbgx6a3SHSd+TasI6zk84jC6gCH1Up1Sr+tx9r4Uf8yIj9ZMNVG2c
 z0duoXDWlCOWKlfD4vaUUZQtlH3Pmi0JfYyERAEPTgY2bd3bDOOsYABVyAQuGwJuWzVy
 YTJdqitpXJvib32RQ2BTP7LMUDOb6zRd/MmqBSo4SR34j738tim8ZfpTAZ7uLzwAii+z
 KPRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nPBiESUGDKk2BsAEN395S5+8TNe29SubIgSXNUfT/cWTJoCkgIqC+0Ow07I/M6qZJvYIRi5MsZDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMhDfrKOU0SoSgOUkdnhYd8TWbK2qy/0hNHSFoD4ETkasQKneh
 3nX5/1abLrVmaqurw0TVQvRfvw30lEcgd91szkupWAez4eU/TBG6Hqda6gBCw7A86edYlv9R0+G
 smsMTml+3QRbwtc2vCufdW0bfp3Um7xNChGiKBGb0KfQo3+bTpNXRpWe099bfLaXyfZLwFTg=
X-Gm-Gg: Acq92OG+eFLs/AWX7S/wpjZyG4ydC7tslH+7+TSLsOqwarEu4N+83JrPRk2QW46/szw
 G3l+JyYtdCFNur2oSCF4XvB8ndeXZSVWizhgf1O3ybhNtWMrMKzXxUPZHXLEtsmWx6ZKI5vWIHk
 +E4SFmleZs3VJAQn8vbctyT+hVdT6WsPUKMNJt9sDxqwgP8PAAfR53dSGteMP1kgorcoQKfnlcn
 Z7qHykWyugtepHTgwe7kKHAPh/TBzv7uK/UMxzPXQLvVzfBHYUCUnZFmQC74qGK40bsMTXC2hez
 HYnoXYMI5Ma9EHQnsYb5VZX8X/UEseYp4IzvFLaAtcextZfjOgovrX/ZQBiNfZ9dy2qeWSKDNTO
 Fw7Pgps6ZfBqaZPXi36Yr3wuZcD7ZMO8z3AnvM0aze4/T9UmMGnMVHRCwTRxALgaNjQmWxb0+jh
 7Xb5sezJr07v7qFwf9KG4yT+fIfcjbpXeQF9+pvwEbyMCVaQ==
X-Received: by 2002:a05:6102:290e:b0:631:26f6:7009 with SMTP id
 ada2fe7eead31-6fefee62e5fmr6369671137.26.1780898812304; 
 Sun, 07 Jun 2026 23:06:52 -0700 (PDT)
X-Received: by 2002:a05:6102:290e:b0:631:26f6:7009 with SMTP id
 ada2fe7eead31-6fefee62e5fmr6369662137.26.1780898811891; 
 Sun, 07 Jun 2026 23:06:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b990344sm3547105e87.65.2026.06.07.23.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:06:50 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:06:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v7 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <ootpegidjjs5h54yvfyopwoycj7zzrfml5i6evfqpb527776td@zkcfkjfc622j>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-3-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071750.526-3-jianping.li@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _W1tFYnqZ7MtxbC-qkQxWcgk1Ji2MitC
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a265bfd cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tfs65u0VeOSdEd3mGyIA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MyBTYWx0ZWRfXz/hMBlHIeb4v
 4zq2SGiw6Sss+Xd/iJN94r2CWsQ4dUnrpF8DCrm4CfNkj1hJjW6GLrlR6UT/4cy8S7VEDT5emG7
 2OUQDQ2F+/twcYOu+wnD1NGR+JcyPx+IkpShET8jxRwre0HNy+Bv6toNWq/U2pP9iqrgpQ6Ikt2
 jeNh1D32pn3cIhMi3bQDj+vUdzEP1fVRfvKZqMEJR8rXWppXmwxHj3A8XBDnDF/pU0x1SjBF35P
 5zg3L2Ycz6QTMi0G1t4wyzHsvAZaw9lmGHi2BEtQ+stwYLOWL/EEJWVQQfSzj9RukYebip6gDaQ
 822ypfGQt05R5yDvxum7TzDsC93iqaQ7VBvKORfawmybHX6Nxe2jXYbek5w/ko44aKETSblpVrg
 LEfXs1Yos5yjmc7d1R1QZ6+axWX6DGcx9RUN5Qg+5Y411VXCt8IoHiACgii4UcfcGxmk2l0dmwR
 vW5h+eqtpJxasWgJoZg==
X-Proofpoint-GUID: _W1tFYnqZ7MtxbC-qkQxWcgk1Ji2MitC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080053
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

On Tue, Jun 02, 2026 at 03:17:47PM +0800, Jianping Li wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> getting removed from the list after it is unmapped from DSP. This can
> create potential race conditions if multiple threads invoke unmap
> concurrently, where one thread may remove the entry from the list while
> another thread's unmap operation is still ongoing.
> 
> Fix this by removing the buffer entry from the list before calling the
> unmap operation. If the unmap fails, the entry is re-added to the list
> so that userspace can retry the unmap, or alternatively, the buffer
> will be cleaned up during device release when the DSP process is torn
> down and all DSP-side mappings are freed along with remaining buffers
> in the list.
> 
> Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
> Cc: stable@kernel.org
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
