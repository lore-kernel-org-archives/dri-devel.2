Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E46BCD4F49
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D674C10E422;
	Fri, 15 May 2026 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwMpC3a5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyNbCvCK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE5110E422
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:33:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FAX6Mm3219657
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=m0xOM7VOPQoZujb+gaqC0lLv
 yQgX/qpmVlsX/RoLGUc=; b=iwMpC3a5P/TYNs9rw5RwFNGJz/dUeiw+0w1FFu27
 PLnfQmZ9KEj0swU1FCuwEOkD/uCYYXobwndRyv9pYrQVXuloGmeboLoSZGQ9fMJN
 27wmdBwyHnSuCFlxuULIHWRaBtLxbsEc+RM2XwpdL9GsRHPeswevzbqXX2t7nBq3
 8Ivyb7BWBSti4R+qZA8+JhSNCqxHahN2Zz8fhXDwkw3gXwqEvoKH1nm6Jy8coKWq
 CqHyzhMU3wLYWVr2y10swiYYsV0PwdgukiCG6LjbfEY9hV5FzreV+PaCefRttGp4
 1R9d3vnJ1XcBX5PoJayopAUAzC9tsHummuYlK/sZOPuefA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s3dmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:33:20 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-43a4f4a252cso410012fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778852000; x=1779456800;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m0xOM7VOPQoZujb+gaqC0lLvyQgX/qpmVlsX/RoLGUc=;
 b=LyNbCvCKl8BRX+0YrTiH/GVJ+4g9Vlm2G1HomIvr4sNbyg4HuYCW9v4K/DC3pF/5Yz
 Y+xkfaWSggv98WcQzqAXVF0hHZa7VTXlpf2AHJHOXONA4hCZChxRXXRrT0c9f2xRunGv
 Enpea5S3ejEaMDym5Rhz1QVXeqZOaSae7FCUyPfG7iO7/ihKldCd3g3vsR6GLhkEBWZp
 TViYyH2PQrVy6POXbXVmWabcrocwlTPozwQHjQ75lqUtFSZ+145GtjISKcbJEVBa5cTY
 WcAunJrv35BTU76e3S6QNW1o33NYxDzkafTR1flOkcCzhZW+cUc27VRk6STr2iRKOFSi
 ZbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852000; x=1779456800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0xOM7VOPQoZujb+gaqC0lLvyQgX/qpmVlsX/RoLGUc=;
 b=YBs1TH05lY0SXNPjzUXsoPpZ1YU5pGcmxFjJ4F3943LbSX8vPaBiIKPXaI85EF7RQH
 6MA/BCqL/gSTfp7HwnboKSOGa8a/36qcbn6mIGEn9fwamQgRiMExSE3yYhCjyqolN4Wq
 ERq0YaNvR52uECyYq1xkK2yqOl/NvcRJs0cnzLNr301ik2PqBGnq2/AzUxGpviHoNoph
 EHog+qUOFGnXYgnOr6Zv9DDbkl/AFvM1lIEHXrUrdGuRUVsGttVeEORhV4D28IUzaQE6
 6Fat914/yj8q13SvsXbBvhsGi7z9E5yZK6katXe6N5TVw5L5ku3O+7dZJt7rbrKtdvne
 8jWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DVWmYUuhp/nrCzz9L7teGq3dJgpuCQeLEKsw96N1vnyvuqSSWuRGBV6wYOX5r1ZC1Xaj9FjfWIYs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQqIsEJWaeg4+7pe5f2DEJsmvB9nJzhXsqtwoP7fqkWPOTNQHG
 QUfdbQnK6sc2GNwo8yO4Hr6yA9SdGcE0/bZp7cvAdOfU6jm14t4CxSnaOFan0bXt5RWMpICijsn
 wPSBdp/xucmgteR9s5kBYfOnzGAMdII3sRyfYUimBbs+3JUtOpicEl+9wXqcpnLKniECCQAA=
X-Gm-Gg: Acq92OHNaS5u8jn4fC63V/flYjm5jt1pQrwbY5uw/GIL8nZa4imlMraFZ5Ol1pxh53r
 V9+n4u4X3AiudK8urRw2mUktC7UqByjFfHq80aZzJFHMoIZrkpyml4ir3CBYvuGSYOo6Oyb4c68
 p1RMlUncR7a5ToR/it3vzMFioN8/GdDLsVuJm3gPCWHUNstdg7IDIqsWeUb97SdtgAOCAwQpfY/
 RiY0ow0ks1gUokKZGLY7srDe0cQWDti8V44+6DvtUoBg/StqK2j0xKw0c7YoOLvgsSEa83VTFLb
 LTmBjY5x0rprXwZb9FT1+tQjEXp+mJIdMj+WGxpA2ReVwpG+qLKayIa5b3yeiT34vI/8J2Y/G/9
 jyg6YhciaWTWJOqj1rylT9g0ocCZMchanAI0MS8xjf/gXPRl/JIMiTpkyb8nWUxWhAe7vi1nHlW
 8qY6Efb/9XmBxlf6gEiDWoc0cBneMT7O7Gsxk=
X-Received: by 2002:a05:6820:616:b0:694:21fa:4ef2 with SMTP id
 006d021491bc7-69c9bfaded0mr2413843eaf.43.1778852000292; 
 Fri, 15 May 2026 06:33:20 -0700 (PDT)
X-Received: by 2002:a05:6820:616:b0:694:21fa:4ef2 with SMTP id
 006d021491bc7-69c9bfaded0mr2413810eaf.43.1778851999809; 
 Fri, 15 May 2026 06:33:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11ad33sm1350151e87.33.2026.05.15.06.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:33:18 -0700 (PDT)
Date: Fri, 15 May 2026 16:33:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 1/5] misc: fastrpc: Fix initial memory allocation for
 Audio PD memory pool
Message-ID: <almtuwpdab6oc44zljo333iv6iels24j27ucuiwsojkfc56zmt@xrbj6baxc46b>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-2-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124217.20723-2-jianping.li@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNyBTYWx0ZWRfXyY7xqZ0vTzLK
 RzfnkgGMuNynUZiVEiLeLRJ6UaweIriwUYFiqSHS10Ql+uiqUTxiwN0tAUOHLJKif+U1tA+rFVi
 ZtSxIeJ1rvba+d/LWqyao/DK1eIiAnoVahZR71yBe12jnwxpEcT5QoA4DOfQbrukdu4dY1DyL/n
 sQlXzt4UVBc6w5asbbzbDNgAbr8V+13qbYJ+0bibjhzWyyJKxAFJcc0WtcT8K13kZ8ZRRVtGZF3
 wDg3Z58hjHGFIXw18avDvT+U21GI3wh5H3lGVoQMSxMhijFlOU8QI/1NLCDBJQpAeVoWeMirjZY
 YPfvqBBU+ZcES6M0gyG1pu0jjzf6pS8svkoQmHlQ/89AMsS4WLStVpRHTjm9b2dDhxSjnYOhpGX
 RqXuy/pAFcY5hBaSIoN82RbtidjF0uImi9880U8UVnHef+H3nvpFtaRpeJcLI1Ln1Kx+3TE7k9O
 YrGozAPlx3WqYSawEOw==
X-Proofpoint-GUID: fHwxFi4J2RybAcwXjkPmbuB35Se8odQ2
X-Proofpoint-ORIG-GUID: fHwxFi4J2RybAcwXjkPmbuB35Se8odQ2
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0720a0 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tbY2IoXn8WmGO_B21IcA:9 a=CjuIK1q_8ugA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150137
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

On Fri, May 15, 2026 at 08:42:13PM +0800, Jianping Li wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> The initial buffer allocated for the Audio PD memory pool is never added
> to the pool because pageslen is set to 0. As a result, the buffer is not
> registered with Audio PD and is never used, causing a memory leak. Audio
> PD immediately falls back to allocating memory from the remote heap since
> the pool starts out empty.
> 
> Fix this by setting pageslen to 1 so that the initially allocated buffer
> is correctly registered and becomes part of the Audio PD memory pool.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

If it's From:Ekansh, it can't be CDB: Ekansh. How can Ekansh co-develop
the patch with himself?

> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..8b21f85cd9f4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1324,7 +1324,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  		err = PTR_ERR(name);
>  		goto err;
>  	}
> -
> +	inbuf.client_id = fl->client_id;
> +	inbuf.namelen = init.namelen;
> +	inbuf.pageslen = 0;
>  	if (!fl->cctx->remote_heap) {
>  		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>  						&fl->cctx->remote_heap);
> @@ -1347,12 +1349,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  				goto err_map;
>  			}
>  			scm_done = true;
> +			inbuf.pageslen = 1;
>  		}
>  	}
>  
> -	inbuf.client_id = fl->client_id;
> -	inbuf.namelen = init.namelen;
> -	inbuf.pageslen = 0;
>  	fl->pd = USER_PD;
>  
>  	args[0].ptr = (u64)(uintptr_t)&inbuf;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
