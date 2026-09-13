Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109CFC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D108310E90F;
	Sun, 13 Sep 2026 21:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGiId68X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHGDRxgo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC6410E90F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:40:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DLFUBg3673870
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C/RcLWpqyWB/bxvbtCv9lklV
 mRMtUxPOU2Z0l295uIQ=; b=SGiId68X//DGV/frJRtGspfr0CwCMEQVrn04N9jS
 wA7UPgaBFIDQPjY3PlSaGkI1GYUpcmyoNi5jigpsAjqtOBB2gc4R/o9EgT/u27AC
 qUZksWF7PAIlX14luJAOStEhS7WJUsMPUVtJmN7cqpAkeNgf8Kp0uR/q53dl765j
 qXFULfA3t4vShapg5WcU/+t4TbNnRR7V9K/aWW+qEn/ZPu04x5KvnK52z8ulHe5x
 EDB2UiEkmNGry9075HqGJmzw6p3Ri399pPWdxbHu4MaQU/Hf5crRoyxMwJg9PnLZ
 0ZF8vfcnMLhx4YWl+fqJVsy8C5nt+iLUfGwxmaDSVx3IEg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k081dw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:40:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980989f5030so2257801241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789335601; x=1789940401;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/RcLWpqyWB/bxvbtCv9lklVmRMtUxPOU2Z0l295uIQ=;
 b=IHGDRxgoy85qgT32RrpKA0cOL4r+LfSr1gXpjKSU5NuhpEk8wBA0vHofM0XEzUQbHy
 G0gsw7EpFrCqg2nUJPyHCPNRSDwVGAZLRYPPj8Lg+F22JgWLXhtO3dl2Tt5BFzWhFFvL
 ZjcvVGoyIRUhmW+hsVAgFpw7gpj1romru5EOv24KfNi12r9K246lGXWNwCxELlSwLS/N
 dRmG+FAFq+7Ga5O5S0vPjK+u3W+RIJ4JqZZTjyMoF6P0vL5NPIvAfkLYlvo6AgbXM1eb
 KoSdivkUS37fkzrZRj2R149ekbHAA16FrzZYnKcIOOMInDbgiIFcqHItJxNWMUJp1GM4
 AkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335601; x=1789940401;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/RcLWpqyWB/bxvbtCv9lklVmRMtUxPOU2Z0l295uIQ=;
 b=Nk2FofQoAzSzGODKDV8XsrixTPlEBOnMfRiNGyv1AGG17OHAVGhNv/x2bqiXVJTAvM
 QoQeruPWOt2XRPiZYpGYBk4+Bmx6pDvcfYx8C3K1NwMUimKYoIik1jg//KsSqYwlVH45
 UcT4N/hScJXNpD9Y1zg9o4B2QPPtz6044kW6Ff+8QnAvv2cacaziyx4/FZRNxfkdMdUc
 rUN9xy0wbqzW8D+1JsTGWGapfKbyHnmRk4X9/UWrPu4Y7ZSLcxJxdTVB3yRmp7l4gEht
 x9QrSlX0sBTLA1+1Lqq5Yt//H0Ihd/PQTRHzS1C1v/vwX+qMWEwAFu5ehFnVMv5m4SYj
 3k7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2rpnEmKCsVyme3lzRJ8857bQoP87jLWaRENRcJ3Z+Ui/jeBzj/ijmXcOJp/ybIcu07o7AbvdW3b8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++md6BHy648z80fTQei8VxUrLE/zjMkdDsFsJbk0AwuJ/WvH/FUP
 jwooiO4HQa944gLwtj97+8OmVfIhbPXFY1JfRw+JQO8fBAsdd9ojjpqOaSA4tsibK2ISPPCNB/7
 4B+fUlL01H6/TJLc/YDpKR/DKo9D8UOl555UjuRsGnimgI/QyEcFop8NJF51pM3ocPX0SiWs=
X-Gm-Gg: AYBFou3/iGb7vBK2uUq/FTa4lYV0bxZUTta87Ki0PudG0JglrE0afzlFJ5aat8tsd/S
 uvc2SWrMcrcpB0jcKpBXMHpDIVEcPvAXWSLlcq5DGSzoqtGDJBwwWSrc6TfdoXbkuZmeAKVmEwV
 I95mAEg9CA2hX5WM2Rd+WSpTdFQcoJJgc9T/NQA/DcWJFXe9nNKCd/rSZk1gp4aWV/dZKrr+iEm
 duBv7XUk56pIWqEJ86tWenMXJ+sJ0rWmEk62lb8H2uIepdjNMTgmTvfOzhmdDIrgIy4UQgEXEoN
 Z/3EL6sKp3Ye84OAVyeYqjhcrS1lhn+l+9bCya/1XAyhQwYPcuRwcc+x0Ogi09CKX0vO1yovHlv
 IVrBNDvryERfVnfE0eTc7cM6b7LDdXTjtB7GPbM9UzOYiLJtehk3h4Dnc1Nk5OOm/2jbXn1oWJy
 El8KwIOobU9uXZ
X-Received: by 2002:a05:6102:8021:b0:77b:ae7:1bba with SMTP id
 ada2fe7eead31-792a6758ac2mr15026770137.3.1789335600802; 
 Sun, 13 Sep 2026 14:40:00 -0700 (PDT)
X-Received: by 2002:a05:6102:8021:b0:77b:ae7:1bba with SMTP id
 ada2fe7eead31-792a6758ac2mr15026758137.3.1789335600440; 
 Sun, 13 Sep 2026 14:40:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a336c26fsm20669481fa.37.2026.09.13.14.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:39:58 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:39:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] drm/msm/dp: skip LTTPR init when no LTTPRs are present
Message-ID: <ej7zom63d6scqrxtymszwswnstmftm76bsqtn4beqz2vceqzho@rdfxlo3duii2>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-3-2825e5bf8a96@oss.qualcomm.com>
 <315db50d-6553-412d-8fca-a4b4441f881b@oss.qualcomm.com>
 <fa897e53-2ebe-4322-bf73-98788854083d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa897e53-2ebe-4322-bf73-98788854083d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwOSBTYWx0ZWRfXyS6p+2K29jgp
 n6A5/lfQL7Rh9laQVTxEIBvgX5S8X2f9D8+ACX0NBWN3YWBnJZlvpCA7i2ive+Qj4pBr4IhdlaP
 KOeqrdKaa7KqEaWbRJlDrR4WYBOreV0=
X-Proofpoint-GUID: U8HJ6Hz7s2IoTj6qKvHIfwiRETPi-CP5
X-Proofpoint-ORIG-GUID: U8HJ6Hz7s2IoTj6qKvHIfwiRETPi-CP5
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa71831 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=amprJqNY4E7PqP1f_1cA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwOSBTYWx0ZWRfXxpb/dFA5gNcP
 fekHZOY1mHlDIoVac0IZF+8Hvi8H1hcs3NUFfDR6N1Av6qf4iLyQqVNfs4p1xYb9Pdx1hPEG7XG
 QktslhrN46Z0ORlIldRcd15iAuWnSA8P0kiAimE+hDQB/eZ7v2wBrZmdtQ3FdjxL6IXfW3j6JxZ
 VkjNhBNhci18RNRgKhN5UH+RSg/d4EFBfS4hJ3PHK0CB22U//PqxPLb2MJ70XMYPj29eVUZEmrT
 KTPdF+2uM29LgCguyGgdW56p2xNDhHAY8NITt4O7RGlb6JW7C4Sswmn2KrkO0nR5HOoSqZRO26G
 uSRpipeJchlMIoRe3HoQ8K/0bcX1rqgG54brguow8Z/bvm/2EAZPmiRkuIWTxYEKyUogcvOdPGx
 RzVCNcSh/GIWPHRK6ojIrTn0GRBoYoDuKX82UEIXMlePYuUPiMXZLLMildb4ku1d0jU+MH4HnNA
 Zr1uAui669u2ZoZIV8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130309
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

On Mon, Sep 07, 2026 at 03:14:33PM +0530, Saurabh Anand wrote:
> 
> On 24-08-2026 18:45, Konrad Dybcio wrote:
> > On 8/24/26 1:28 PM, Saurabh Anand wrote:
> > > drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
> > > negative value on error. The previous code passed the result directly
> > > to drm_dp_lttpr_init() without checking, which would call into the
> > > LTTPR transparency-mode setup with a zero or negative repeater count.
> > > 
> > > Add an early return for lttpr_count <= 0 to skip the init entirely
> > > when there are no repeaters in the link, matching the expected usage
> > > of drm_dp_lttpr_init().
> > Reading the body of that function, I'm not sure your statement is true
> 
> drm_dp_lttpr_count() returns 0 when no LTTPRs are detected and a
> negative error code when the LTTPR common capabilities report an invalid
> or unsupported repeater count.
> 
> drm_dp_lttpr_init() already handles the zero-count case by returning
> early. However, when passed a negative count, it still writes transparent
> mode before returning -ENODEV.

And this is correct. If there are more than 8 LTTPRs, they must be
switched to the transparent mode as it's impossible to control them
individually.

> 
> I will update the commit message giving more details.
> 
> > 
> > Konrad

-- 
With best wishes
Dmitry
