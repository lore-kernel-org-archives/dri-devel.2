Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF389F99C95
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D30410E0C2;
	Sun, 19 Apr 2026 00:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gR697kqo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C9WjffhV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF43F10E0C2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:16:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63IJmsve3263867
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=krtkKxe19pMn4PJwb0xqRCTx
 s6eIr+De+hcmkYF9q48=; b=gR697kqo80AfHPSVffaSyFYnY6aqjhi5knRMEcry
 pUTuAf6jP8zXHkkY2KJEWhJfCS9zAU1Vcz86eE6qwoHoU2HtpPtG5fudRj7dOyhf
 lAiR7LAsOR5T5ankj4p4/rHYlEJIpW8iC225aFk5K5YLMBtSdpGdNwZwzGRhdQmF
 23lq2V6dzPnpj3lwWiG8sv1ULnN+bO1GLkWcM0uIED9vacHlgShdQYmSeHgvcAV+
 4f+6eBdTLlcNvwin8N9iKAePe1bjK6NqACqnfVbtT0gTjGHv2gm0cpjq0+imp05d
 COD+qz1rDaBlio8vkaV2wGdbVJpSp5CooJp2SJapHEtjnw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qahn5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:16:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso22946641cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776557786; x=1777162586;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=krtkKxe19pMn4PJwb0xqRCTxs6eIr+De+hcmkYF9q48=;
 b=C9WjffhVl+EhHMfepsknOPrNl5sWvHVTPCYEXrTqsGIOa4W5Eeb4qI6YGa/SegjwlW
 pP4G64qwMh///swUzKkAYAms9Mxk0IRwOXM9DC68br8raIDIST8CQ5N4Vud/2XWfrXje
 eDRF83AbELFIvAzL1aEBQta1uYH80/SHXiTWafIyzHdfvy796uSzbmD9NFgbSm0BHE1n
 0lFR3bejxFsXYZ8J0nXGnQQ1nkWzr7+6rpZPCQhF4x1OaavV2giHx+yx4wv/5fb/GKdH
 VNOHlXtWRRJ98MyBbX9cmSCs8QQK+z8XtUvqycMwgKYvxwJ0N6RK+Fcwjy8duChIRzCV
 CEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776557786; x=1777162586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krtkKxe19pMn4PJwb0xqRCTxs6eIr+De+hcmkYF9q48=;
 b=WuXW+SyzEIEnjZxV5qYvHFxoIUJIbJnHcq2Hk5hMtitJGQarHUoUZEjFHHMM2xOun/
 8K8YFMI1GemrKB+hwbbUzeQjrkSM49qBJVCo38E1cLdL88u5jbQICbDLZfa6YVv6z1Kn
 13lIfcaeyR/jiK1hM0tk5OHayX+M1IgoVw60LNF+3AaIX8cDucy3zA2ytTj5tLxvN+/0
 Ww7nhPgfQ9Zx5ZLd8NAIXtWxboW3O2SwOFvgLWPjR6gEWOJmpHVQhKhWGErc0Sbz/BIO
 4KW2EAOvKoXiE/vgKHJgbq+ixWtl0jbexxrqA1xc+w5C3QSftweQVjKPCC65BuyH9CR2
 WO6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9P+SooEpPq3YajcS/IJUjDcXyXVYvrQ4IvAxPMkM935SRLtzaquJlp4AxcKzt5t/lKqpIu0IBRZSs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSy0t7JFoHeZrijcibYOHzDzvDwgukT4jBb2NgM1ljLfDubYPj
 0W0gTNTJAunhOspHfSTYIGCd/ulA/sQUIeCUZpTyOG+Ql0zQcGh1aj/LekGaWWEs1BlDfBbv3nw
 AGudgJLGPzdEL/IXxtz9HO3A+LxCv58XHDm9aAOBdWQVCfKe+SaI9aYXc4ztd1cpSnGPTmKE=
X-Gm-Gg: AeBDieuubGGhn5LKhHeuatMYslv/VNWsKDyaUKzznYEW5wJIndWNwq93erK4YJBSUJ1
 GO/RYDX+j5J4VKtGwNtaNKZD2oKJZR+ldnkwUL6IxPaBbfcfeQFRLWOeOqN+nmBMkFCxFRh4jZ9
 ZSvHyqD0T1vRzHhtkgO3C+uxKeA19+/+xguPY4/W1kxpqyReAkx9dcJ9k1UiE/kSfC1M6nymWaN
 z7rChKGIX2pd1zWHMdQ5MfC9aGnpI/UXROPC8DvEPUgo9wfy4lP3IMPQKWE7dbbhSKd7JRdtlXH
 Eh+RdtgTcey21hdJCvgKnrRdSA58Tmsh1QboR/9HDBznfgsA/Lfi7BKMGj41yYL+6zO7hdworo5
 E1gpnGiDA3DTXwvuLm2YrRM+FsGd6XA6B/DiI9XCNIjxZnL+xwJ6va1zuqk3+UeR6tv+9Q812Jv
 k8bHfabq/O2TrVtOM9XFOfbHn3PZpPa/x0mCBpnUk4hqSv7w==
X-Received: by 2002:a05:622a:1f8a:b0:50d:9e69:8099 with SMTP id
 d75a77b69052e-50e36833221mr139255251cf.19.1776557785937; 
 Sat, 18 Apr 2026 17:16:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8a:b0:50d:9e69:8099 with SMTP id
 d75a77b69052e-50e36833221mr139254881cf.19.1776557785464; 
 Sat, 18 Apr 2026 17:16:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad343sm1729076e87.2.2026.04.18.17.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:16:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:16:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Message-ID: <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
X-Proofpoint-GUID: DoRwR6vfdlolHba3OuKMmNGKsoZQo9Yk
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e41eda cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tB70rH4wX7YjnKcxG8sA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: DoRwR6vfdlolHba3OuKMmNGKsoZQo9Yk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwMSBTYWx0ZWRfX8XTomIDm63/C
 b+D6J5GxfQx0wUT995YbXtf91BRW0Z2ZB3AK9nPVxCopXWdQAMwGIRYPTQKPLP3BBgBOcbCjQni
 vEgOjxFnBbIVYk6KkdE+9hCsgK5rznq+nrX/M90K+RKxchEgConIxT8EIKtgFZY1p6URwKXIZlQ
 xlaHc17juNDnJvif0s7ocU3i5E2AcYdpSEEA/Y8wkPYrQeSKUxmzFvqnUO/A2dHLIlHAiYui34c
 INqApvHD6t0mv3TTnTwdIYtPK7kJ1zmYJXZE1dLxwp8OLC3aDUHaC10QaT7WCDeBlWiQmRi2PQF
 O/swGxjbZIK7v8/DzXe80rKrfXrHXAVAY/ZdN8AcC7fhr7xMGo+BTYx0IIVXbrcg1UlOPWM8lGk
 vZ7hPwUb2pURjBwPNHg4TZmQk2X8TBafo2DfLI+yoBvAUMugxBg2nZA4T0W/t6IyvKEalw/7OJa
 WSuMG0DG1crk/j+ibAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190001
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

On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
> 
> 
> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> > Replace the platform driver approach for compute bank (CB) devices
> > with the generic context_device_bus_type. Compute bank devices are
> > synthetic IOMMU context banks, not real platform devices, so using
> > the context device bus provides a more accurate representation in
> > the device model.
> > 
> > Currently, fastrpc used of_platform_populate() to create platform
> > devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> > driver (fastrpc_cb_driver) to handle probe/remove. This approach
> > had a race condition: device nodes were created before channel
> > resources (like spin_lock) were initialized, and probe was async,
> > so applications could open the device before sessions were available.
> > 
> > This patch addresses the race by manually creating and configuring
> > CB devices synchronously during fastrpc_rpmsg_probe(), after all
> > channel resources are initialized. The approach follows the pattern
> > used in host1x_memory_context_list_init().
> > 
> > Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > ---
> >   drivers/misc/Kconfig   |   1 +
> >   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
> >   2 files changed, 125 insertions(+), 56 deletions(-)
> > 
> >   	}
> >   	dma_bits = cctx->soc_data->dma_addr_bits_default;
> > +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> > +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> > +
> >   	sess = &cctx->session[cctx->sesscount++];
> >   	sess->used = false;
> >   	sess->valid = true;
> > -	sess->dev = dev;
> > -	dev_set_drvdata(dev, sess);
> > +	sess->sid = sid;
> > +	spin_unlock_irqrestore(&cctx->lock, flags);
> > -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> > -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> > +	cb_dev = kzalloc_obj(*cb_dev);
> > +	if (!cb_dev)
> > +		return -ENOMEM;
> > -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> > -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> > +	cb_dev->sess = sess;
> > -	if (sessions > 0) {
> > -		struct fastrpc_session_ctx *dup_sess;
> > +	device_initialize(&cb_dev->dev);
> > +	cb_dev->dev.parent = parent;
> > +	cb_dev->dev.bus = &context_device_bus_type;
> > +	cb_dev->dev.release = fastrpc_cb_dev_release;
> > +	cb_dev->dev.of_node = of_node_get(cb_node);
> > +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> > +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> > +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
> > +	rc = device_add(&cb_dev->dev);
> 
> device_initialize() and device_add() can be replaced with single
> device_register() call. You can refer the below patch,

Keep in mind that for several arches device_initialize() sets the
coherent_dma_mask. So one should set coherent_dma_mask (as it's done
here) after calling device_initialize().

> 
> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
> 

-- 
With best wishes
Dmitry
