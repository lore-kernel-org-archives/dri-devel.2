Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC61CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E4A10EFC0;
	Wed, 20 May 2026 14:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJVdwe0E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iebQAdO2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B72610EFC0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:27:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KEFbxd963824
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EFchA/PJgMyqdqvbr5p+Cpu2
 tYJVf4uyCXjeVVObaow=; b=IJVdwe0E9ak1iNh8XXD9rrzKn/RUEyEFg+TihlY6
 0x0kfwSksu6HayCdXDFAChikwMgdL3e8wUM0Atzfurz76tMCVidK95iSWV6cIqnG
 6F/bwCjvcC9GKTkjGx6iT/jnpaBOnkX3OR+yjFiER1R9nnaDOOYPHV+Eo4FnKRCM
 4aks3xgT098xaEVWR9hTv8+pp3Xm1POqGlIIQ8IF58ELY+HjaVV5iwCdQpuDUxuO
 1k5mZhCdgWi22xllqgMo/UolX+X0od3iXAWDRogiJhUHqi8AKuFPBQCQOYsVH9aS
 7Bd83i0RH9+7HtQU/S3XzCkBxlHhTRRDVUUN3Nc8CUD3nQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh01jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:27:38 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-575c3a362f4so10880037e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779287258; x=1779892058;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EFchA/PJgMyqdqvbr5p+Cpu2tYJVf4uyCXjeVVObaow=;
 b=iebQAdO2VNiR36hBt2xozUqmNEYH076i7S0saFrsDh2ytPx0kGn8607yi/r4WCSFrR
 xxPHR9v0CSxWGhuwiNJaxhtuFxbSTcrWBx/Do2U9NHQ8xsZPaQ9dFmXy0LFWJH9EQUgz
 tkbHUawdCiWFm+BZrqu1yW26Np7FuZwdgkkf5fHbyKhyg68Gpxm3FRbyJvHwADNlFvxi
 P3gsb8LA0lqFSOyWKrOhT/rIDnEuUKVIwksO7RypgH0vv18lV2Q47QIg4vuhBXbqPUW6
 ZYtDRRH0Ium10o4f8tmxmwQa+5MNRFYEanQfZ9UsTCLNkNtf44GQwkXHopRJJmLnaCua
 8OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287258; x=1779892058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFchA/PJgMyqdqvbr5p+Cpu2tYJVf4uyCXjeVVObaow=;
 b=fw+T1pkyyVezoD7IeyEWtCymgCJM1OuVXIAYS9jZDkDp2MR5OQVQ0vNrRTe3i47jCm
 GoImk7AWg/QGOBvydL5TW7mbHkv9bBdyc6cAfHz0lVic4kg68Oq/Iwu+1ka8RNw+ZDyv
 CrII3GqyVGct1vRAV3WGWXi276lxHCH1AVEoXLOlxNRrtsHEQ9nXkPkSx2AgI2fmLnPV
 uRfDKxK71xDMbf1hz8DYACd4EG/TkrCNLY89EczQnzajuN/BNpOYgL2O9PZE5AYlg/8Q
 lFObq4iF4bGg9MNQj6ZQxKLi5h6OWRZ9iT6nUrye2vLmDVr22xvy9dohSfpv8tnTfdi3
 XTIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W1Baxz9YYbckhDquVw6vdnoieUAhyYQEesDAwq1eBVs8CUyXNGTzkBasVc4sII1CkbyHTICAWwic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRsPRCBhvYcd/HBonXR8DIARjD3gqaMMHoRaVr52pcBUN9oAVB
 52GvOF7DxTxtrF5/noQDP16IS0uhIvKEVPPW6tTlyd2fkuTuhW1ElWsp2grxdWw3hanRiBB8bP+
 oVIQq++JXoNS9XtT2b6PY5h4XPbX+N12ph1MYNPTf+j/zsbB1gI0Jbgrum4KlCkoC2hVmwyk=
X-Gm-Gg: Acq92OG266dF+8cRJi5jP9u/7sYwDaie8F7pBjB1lALl+5aYLcQ3UdjB1i28hDlUxT8
 1x52orcGIdquVB9umepFzS61VwhRpnZajKgVIIq/bXtSY4ymhScTLfezw9asPb4Jrdm6t91szjB
 jw/KFeHrbv/dtij9YMNDaIPoj/fr9auSxXYJX3IpWT3U98DgTGNK6LkknjpyYX78eSl7znB/z6Y
 8ZKl7olFVSPT5aWGfulddbdm6mkNHNfjaiLDTlsUcE5KKKus6pIVKcx111AAhMJ1WhWLvTRLdpV
 i/u2cN3pvQph07f8PhDncylggUi4DWkrLDCv30VhZhG6YTxPTqzsDB1UL0hlJdmKyCVLr/Weqgg
 85aL/BOcrl8ZJBCCtBx/wJE5/yUVAJo97Wja1NDnH6/3HVzudWhcJBfgEd3VuDXHl0h4iqDxmRx
 hTjJUhoL47a5ykhy5RDT7bIwwKraJlpVMQnOMSvy3S+uXSQw==
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id
 71dfb90a1353d-5760bfb8ca9mr14235218e0c.3.1779287258000; 
 Wed, 20 May 2026 07:27:38 -0700 (PDT)
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id
 71dfb90a1353d-5760bfb8ca9mr14235127e0c.3.1779287257396; 
 Wed, 20 May 2026 07:27:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc39fsm4991506e87.49.2026.05.20.07.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:27:36 -0700 (PDT)
Date: Wed, 20 May 2026 17:27:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0dc4da cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=o1-M_76Tnwwude6v8VIA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX+lvh+Hnyu3t0
 /1gS6FUt9+N3S+cvZEMh9mTQNy2j+0pwqEl9BRRm1l2kA8qZ0m67CmqoZcliCbaBoCji8IryXUQ
 8jdS7325uLfleCT8KrN7eO3FWW5EOEkMRTOFlqoXsCiRzHlLVOP6t07xtIXmDJs+q4GSJHVim0P
 /8CE4nJg1P5Azrl+odw24v/7wZvAvWfnsrEYXnNz0lAJZtuJuPAlQoWZ12quEyUzsQVaRj/P8r1
 ElzPoNaWffDEsWvyXwHHWp1DEdppCDbQ2YALCJ0hrwH0NRU1JM9Qnc/wgxEOqUXwSokgRWO7eMK
 ySQ8FN6zKFcEN1imG5fTCr+czcqc0BqZBWn+jUdTJj9xMZbdVW4sBDFVs12QIOzabM7LV21QI2G
 1zPvKydQCFJNjijqadLXwUB14cJywprDkfOjm3cW52KdDQ0oFQPqRpqaj7UBASrhrSa7nxKzwFC
 lHi1DTSg1aJ2wwelAxw==
X-Proofpoint-GUID: aJ-Tj7zXgwZwPR-zIsK8hICNZYwhjXRC
X-Proofpoint-ORIG-GUID: aJ-Tj7zXgwZwPR-zIsK8hICNZYwhjXRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141
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

On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the QDA memory manager (qda_memory_manager) to track and
> manage the IOMMU devices that back each compute context bank (CB).
> 
> Each CB device registered on the qda-compute-cb bus is assigned a
> unique ID via an XArray and wrapped in a qda_iommu_device descriptor
> that records the device pointer and its stream ID. This registry
> allows the driver to look up the correct IOMMU domain for a given
> session when mapping DSP buffers.
> 
> The memory manager is initialised in qda_init_device() before CB
> devices are populated and torn down in qda_deinit_device() after they
> are destroyed, ensuring no dangling references remain in the XArray.
> 
> qda_cb.c is extended with qda_cb_setup_device(), which is called
> immediately after a CB device is registered on the bus. It allocates
> a qda_iommu_device, registers it with the memory manager, and stores
> it as the CB device's driver data so that qda_destroy_cb_device() can
> retrieve and unregister it during teardown.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile             |   1 +
>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>  drivers/accel/qda/qda_drv.h            |   5 ++
>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>  7 files changed, 254 insertions(+)
> 
> @@ -61,14 +62,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  	}
>  	qdev->dsp_name = label;
>  
> +	ret = qda_init_device(qdev);
> +	if (ret)
> +		return ret;
> +
>  	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>  	if (ret) {
>  		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
> +		qda_deinit_device(qdev);
>  		return ret;
>  	}
>  
>  	ret = qda_register_device(qdev);
>  	if (ret) {
> +		qda_deinit_device(qdev);
>  		qda_cb_unpopulate(qdev);

No, this is not how you unwind in the error case in the kernel. Follow
the established patterns.

>  		return ret;
>  	}
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
