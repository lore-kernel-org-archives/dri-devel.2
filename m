Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CC3CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BC810ED8F;
	Mon,  8 Jun 2026 06:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kugHaf6W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jOyTAiTT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A561110ED8F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:38:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Olwq2801762
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GzbD86PS+yb3OAsCbIu1GxEp
 RjklHGCsYXNUOB6It0I=; b=kugHaf6WQXtSez9Kh+KtJt/OGqcLJTEx5MB9npmf
 yaayAEHx4VNZuv46ayOQ9JJezqNyWP6UM8EfhICj0neEtKPDOzODdNOuGnFoZ35j
 tiVf5C/mxWvYXoh+vzfM3Az0pXr//uyMaU0f6fTobhlAI17M5x0OZr3NRv1emuXy
 KBPWS0wCkvNdBpQAKVtq78/mHjYjPeAaQIdMamO0sdlTbPEQfJyqk19EyMxUaTRa
 LryLv3M875EH+EgMe0+UwC7gDkkNYbzEugI4LFqyTOw/3FkTeB6XlvLBDg/mIYji
 UjLFG1a9TiydkRVjgXCxT3CrNluwH/a2rYXvk3s8k6U/Zw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3ppns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:38:00 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5a7cbf971fcso2181255e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780900680; x=1781505480;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GzbD86PS+yb3OAsCbIu1GxEpRjklHGCsYXNUOB6It0I=;
 b=jOyTAiTTPrNoBMZLonsWUQ6u9IE710oGET34NugebibKs+Ieu02ghL0sqrSI3k1+Ih
 WuzI5VhWDxFo3XqYxuMf0Bg6FgvQoCTF7wJcIFHmOmhIbRWMD6DfkUBj5OhBoBab5/X8
 gAAp3n4zSYugzwl+VArWumw/NeRgkPKLe1IFmuh+HILZRyDTsk58yb2AsfxEg84/6ZNY
 PGv0wYeo4cldAUWZruH1YcsVZIlm5u0e/vI5jSKu2/sHYMoza3EsTl7FUILKB4jIDM4C
 OpBtI3cpCqMJ96gELigAB1YUbPt1BSkeUWkr+qbHndWo7mxaWgqQq1TxFL9TsdRBQF/L
 GKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780900680; x=1781505480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzbD86PS+yb3OAsCbIu1GxEpRjklHGCsYXNUOB6It0I=;
 b=ZLNAbko5J/SuCs7QkTTqojzp8wdiGsmyDUzxBq01NoJ/UFKHmUvJYvMx4AzDvH3URY
 BLhUwtz0vL+/uxEi3NR25bzinE/shKldcrejmGXN7doDmuwHCGn232/GH367X0ijZd70
 p7Rv3KTxcla7Oj9Iiv4ltBCUYWXzukoICbeuTZlmRctcPaoTor1JYHQjiwDVu4siuJrY
 skv93blo6lcczeZTgLfx9jPWh7B4YQdaWy8B9ktFiwwudTqTYiljy0QqLhC5bI7T6T5/
 0NbC/0YnAE3RraJ+FMb5IuJkynRODOHE09aGkHyv2ovmfbtLoXaYYrUCTBEzpMr8/zhe
 WR9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gQI9+NOd56ZgTdPm4Jml/8I2sRGkrltEoUzU/yORek6Il4fpI0iSC/AEywcO/JfZsf3suV12AnKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwERsgx5xHHANZe7bCsacyZwrwpc5kVUGqdstIAaOuSL8Xa5FN7
 r3+VW+oFGEW/h899EAJUNtqoqV6za4Oi5PCvYWSXa8JfiuoWh6UyYzRxXlvOsir7JIP0x0aEvz2
 aEsCtxl34pCdFuCGt3HmtjuHIp4rgs+gveYQuA5/4nm7QLK7aaZCFVr8r4akNBev2FEwJ8LI=
X-Gm-Gg: Acq92OF1Ib8TpuKCQkv9ggzT2yom75D5Wh19cEsk4TEqZJXsffw7VuXljwurB4zuR8b
 XMNYAaCcCGpmZv/shr6FzIN1ieXkqHM6pkY5/QPql54BuJJMilE2VRk63FCLe5vKvXEbpzJwAta
 IWq20WQ+ZLbx1By7XCfVcyQXbhtRFjG1zbvya0JKO149JLZ/4FlFnFB5dFg3mRB/2cPAtwAIcop
 Hv2c4dCFErWOCdlAmjnpVxVADjUacwFnKP2U/N6DyZ63kfeKRikZcykhUL8tw9Z4L6WJAImg8RI
 T3MgVyQiyG0jHGASVtk1YfiJVHfpZrPwYeQmMk5mpYOdg/YqUX428tgf4JiDQZbLG3/J49ZVOBf
 o9UIJFSE6/cKcIcsrv2rXtpswkQOKNXPkHGXd5ThLlksUVBNsTYlCKAT04DYWY96VlvPJ2jaixP
 JPSQ/odVuZ76Wai54IHkc/My/DvM00KiEJxI8uVAViEqK2SQ==
X-Received: by 2002:a05:6102:f98:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-6ff04530fdfmr6692203137.20.1780900680014; 
 Sun, 07 Jun 2026 23:38:00 -0700 (PDT)
X-Received: by 2002:a05:6102:f98:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-6ff04530fdfmr6692195137.20.1780900679575; 
 Sun, 07 Jun 2026 23:37:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b98fddasm3534447e87.64.2026.06.07.23.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:37:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:37:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com,
 stable@kernel.org
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
Message-ID: <mdmtc4sfeoishc64essdbrzcasd5kotbwtulk4pajjzvcy56fa@2dcpz23uuxkw>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
 <bcm2eufawifaq65i5qlqmbam4wtv2du5re6c54tiamdbynmras@lbfd44kjb6da>
 <ddeff296-abc0-4e1b-a721-761e2cbd331d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddeff296-abc0-4e1b-a721-761e2cbd331d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1OCBTYWx0ZWRfX6ZvkVplsVmDf
 P8kf0oDZ56T2q7n6b3npvs30cF+XLEFRlcKgZkfNPcxqY0Gv7pEdcjD9MVHmKYsXaRBYD7eoKzV
 QyDWOT+VeQD6ljVgyAYHsaABqB2IaLsHilmY9YvDRAQdlHSdzIt5pbO/BmG8YJRrPIpCLMHFu+X
 nZsmXYvTdytnurdcVvRbMsy2MFDFB6XXluqxbExD7sFsaZlFkHOO4t6V2HgMbyTzV3c7Q+uPHG1
 imQuVUYylkoU+mWn8GDw7BL9sYlNOhcycVJR2VLco4Auh+rTJ4hwomdThMR7uXJcoGXSpN0s3zU
 RCLDloTAkMUFnPLbxfJ8pR0GonryoZWiD+5c8fItd78k9DE/fbuv1ecRNTaxkG+UHj/jHJgNCdb
 jX9Ltfu9//DlTeWel7tH3D2RFrYzL9SC8FEtqqUEW4M9o5r5gWBDYV5Puvw4wTi8YabWd2S8KcD
 XUjkTRvbsObZUK9fOdg==
X-Proofpoint-ORIG-GUID: cJGIUyzMezbrgVOdXY8jpks8uDlDDPPa
X-Proofpoint-GUID: cJGIUyzMezbrgVOdXY8jpks8uDlDDPPa
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a266348 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VkaHa-le0D-4vWXTXWcA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080058
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

On Mon, Jun 08, 2026 at 02:29:13PM +0800, Jianping Li wrote:
> 
> On 6/8/2026 2:11 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 02, 2026 at 03:17:48PM +0800, Jianping Li wrote:
> > > Audio PD static process creation assumes that a reserved-memory
> > > region is defined in DT and exposed via cctx->remote_heap.
> > > 
> > > If reserved-memory is missing or incomplete, the driver may pass
> > > invalid address/size information to the DSP, leading to undefined
> > > behavior or crashes.
> > > 
> > > Add explicit validation for remote_heap presence and size before
> > > sending the memory to DSP, and fail early if the configuration is
> > > invalid.
> > > 
> > > Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> > > ---
> > >   drivers/misc/fastrpc.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index a8a58f889d07..f46a8f53970d 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
> > >   	} inbuf;
> > >   	u32 sc;
> > > +	if (!fl->cctx->remote_heap ||
> > > +	    !fl->cctx->remote_heap->dma_addr ||
> > > +	    !fl->cctx->remote_heap->size) {
> > > +		err = -ENOMEM;
> > > +		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");
> > > +		return err;
> > > +	}
> > Won't this check without the next commit break the kernel? I don't see
> > where else the remote heap is being allocated.
> 
> Yes, this check depends on remote_heap being populated during rpmsg
> probe from the reserved-memory region, introduced in a subsequent
> patch in this series.
> 
> If there is no dependency on the next series, the remote_heap allocation here after the if check.
> The logic will be wrong.

So, at least you need to squash those two together.

> 
> > 
> > >   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
> > >   	if (!args)
> > >   		return -ENOMEM;
> > > -- 
> > > 2.43.0
> > > 

-- 
With best wishes
Dmitry
