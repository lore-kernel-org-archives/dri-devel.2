Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B3CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63A510E619;
	Wed, 20 May 2026 14:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgWvSvcc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="El9wyd6D";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DCA10E619
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oPBj1177884
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6tCnNFj4WCxpcwrHOfsYOWMW
 qwLTQRnnuiD3kfu4AiI=; b=UgWvSvccqLfXw468Tkb1E8z6KQ+1FXfgivcyie7X
 7mRZ4oCLQU1RX9AnUfRXMQrsZMMMiDgAVw1X6NOgmCry+U0AELq6l19HEamwzETn
 3gg5F6tydxeCV6hvpsj/COwqFRUSJoCNzxQgEaaPqYVTCLq71D0ajGtpX+OeeqOq
 HhG74oxpccO/ary6rB+UwoAHJ1Pv9dIY4ZuX+tp8HMgDtY3Uw6TQ0jS5nB2TzzkG
 CKUC9UbymTzuzqxqNWBHg38Fqm4K0lK+Im7H2LDH7Kr2h8eGe17dYPmROTcR/1AI
 lE7cFSgZTKqxEMB5bh3X9ggyJsBA9U7rpLT+t2G5L3890g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6rxwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:54 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-57563cc7576so4105107e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779286793; x=1779891593;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tCnNFj4WCxpcwrHOfsYOWMWqwLTQRnnuiD3kfu4AiI=;
 b=El9wyd6D5874p6qJ3Ceg0L5R22dc9yEeiKIGsOVVVeAf3MDOu+bKOmilP+QCPr6Bjv
 p7pZXxYPg44IwmnY/PtSOWvML61ZuRBnv7hmwJ+7BQAhNPgvikNPUXB4vAqkciNYRBJ5
 SGzebO08RMuCTtkvfFWWuzTKn63xl5b/iTPklTwchtgXIe2TD0OsHQHCHZ4BCPEGhvxm
 sVzWgRPO8Mz60EXMjns3A6uyEqbQSHqw6qm1PsPcPQ7/41R3uwOmy5D1hbegq1XQYS4O
 S+n5vPzvB46HVF671xzBar/ZeOAJhYMmvJdNNt19VQTP76RL8JtnEGwYEvNuH94tlT65
 WdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286793; x=1779891593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tCnNFj4WCxpcwrHOfsYOWMWqwLTQRnnuiD3kfu4AiI=;
 b=ZTog6ESH2vvpoFMLPx5CkLg78b/6B7kEJ21iKEcHIKeL14zUp+toHxkgFxWjQ/pgWT
 A5jzdeDiRcYTwSbYb0IBcVPr471LQ2FNA/xj1PyZNItaSQNjE5bR+7/nNcPNdfGOxxlP
 4AzupOs3WR2FecZlGXewCBhlc2E5lX2IybH3hfJdGWS65J95z/X/kcPEiC6572HR2jYE
 hEE5+hCSLnVXqnssxIWX2nQWdYT2SC0lVxxcSPYQvCE93M15zqc0gsJPPx6YrD0oL3eh
 sayUgJX9TOPLCOjavpAs+RqGFOmquqC8eH4UGpfH7KMy6F2j9ucDSpomFwFPC9CgvIXX
 ADsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ImoAjhEgFSEdrKC5HFhlQz0DzqpxnYb1PBNaFxeUhbbOe7JAuAmPFiB+or26IJM90wU5+J8GDZmM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXHb6Z9BGBukMs+8EH7qkiVjPP7pV5jhyraEPKkr8yLTyvg5w9
 jsY0FVmKe4pJoDYyeaDy9shripJSKnmSkPqpN/8MjoxoSShFlTRY8fZ2Kix/VhaOmaFebVGPXzM
 PGrf4O6lGjHaljZ9htcKPh0GQNWGTV6+Xb6bdNDNlynFjGKwp676Lmzp7odbNdpF8uXjigTE=
X-Gm-Gg: Acq92OGLcZUnJCu/HrFdsBCuf7Mih9BUDhJRvf7rYMtokCZ/NRaSpFTh7e6ZJv168u/
 FmfJolj3vHPR9D1gzkI0IkCHBGNVRISvG/Vi4gVkyIOWd+p4fZOa39CURboUqjxMhBi0Ujqxl7C
 hp7Mqx67eosn/tHTNJAX9xS1QreG4oyRxdZKDePazIW7K2GMW/MysViEH2IPyrLwRsPr6gSoLe7
 IfWL1Kkz9Cr0Femz38nTBPphIm8ycdGnHB9yeRE4cMp4BmStuqRD8RVUZ061HlYNxZ5kIL3K4sP
 RD4uMLz/nDriUYqUGacZbByDAnHVejbDwj/+5H6Cyw3jepjUkrxEfHzoywy48SYlFg2yDZj4nx6
 RSHP/s2O8zsYtytCOUWx0Uux6BUlwenaTNTY1Min0MFIdQoTfaivBOPUmqx1YwhTMsHIt2BxgbJ
 DtqQtNmfdydhhBpZxXjA9ys3E+eTPnUswhEjE=
X-Received: by 2002:a05:6122:828e:b0:577:559a:3ef8 with SMTP id
 71dfb90a1353d-577559a4a34mr8499336e0c.11.1779286793225; 
 Wed, 20 May 2026 07:19:53 -0700 (PDT)
X-Received: by 2002:a05:6122:828e:b0:577:559a:3ef8 with SMTP id
 71dfb90a1353d-577559a4a34mr8499265e0c.11.1779286792601; 
 Wed, 20 May 2026 07:19:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc12asm4981844e87.42.2026.05.20.07.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:19:51 -0700 (PDT)
Date: Wed, 20 May 2026 17:19:49 +0300
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
Subject: Re: [PATCH 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Message-ID: <hhqbykyitoqjyekwn3tdv6ytzzg7hv27tqj5h26frxxoe2j3do@zzng2lmpfz2i>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-5-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-5-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-GUID: MGg4W3ungVCIHO9NxPQYGbjf0WA6258V
X-Proofpoint-ORIG-GUID: MGg4W3ungVCIHO9NxPQYGbjf0WA6258V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOSBTYWx0ZWRfX2M20Y8oDrie9
 sH4DOJMZ3eNdRnV8sSLxxrk6nV1WSJE0J55hs64Lyv0nxIavLs/VwHxf+ccieJFfVuvvAqYiBdy
 XPfyLVTWUAu2OrRM7XU+kY7auu8Savr4VSkj/sEeFFF8hODg+xyunpB3FxCxOMZrAq/ul0DISiN
 /8CXRO6fq8/JFBNfZA1/YgJ/FD/LEuRlh1zitVn4wIfa/mH0or1tkmS15t6QwYNUQ/vdprJOcna
 utxJw9O35jiQo4UmV31bS9fWWUh5P7XvR6X3nHxw0IICkvXhRmmQFp/a8VTMec33TVmVBCJYDvJ
 14+Yxq3Ct+LvUhS37kaufmJAIu5jBaLGduGha7Wje8p5eyHZQO53Wt/nICFn1TiAlnUQHkcLa+u
 VV4oYOTM4VD+c3o1ympG0EoHYDK3a1cX/MjCnJZ5/5eBtYUjFy6R2xoeShOEKU4KmcvMS1Cr7IX
 2OD6cwzOBI2KAZMBlig==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dc30a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lBWuVeWgvPZisQjhOOYA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200139
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

On Tue, May 19, 2026 at 11:45:55AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Register the QDA compute context bank bus (qda-compute-cb) with the
> IOMMU subsystem by adding it to the iommu_buses[] array.
> 
> The QDA driver creates synthetic devices on this bus to represent
> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
> so that the DSP memory manager can enforce per-session address space
> isolation. Without this registration, the IOMMU subsystem does not
> probe CB devices for IOMMU groups and of_dma_configure() in the bus
> dma_configure callback has no IOMMU domain to attach to.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
