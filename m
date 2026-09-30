Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A250CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030F910E234;
	Wed, 30 Sep 2026 16:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ceg/Sbhc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N7/Buv1A";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8093710E234
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:07:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxpiw3063756
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=59fvn6HNCxIB5d75o9AyYwbT
 6TRJJUb8uFgR5eg9RW0=; b=Ceg/SbhcGM1koch9h2BSx3RC0GoFx/hQKhQuktDZ
 lPBh6arfjeh/UObm74Ri1KTrpPCFZHKA525CHGg9fn8Q0RehXPxNCJhDZLok1sGc
 /3QIFqci9rQ7F/Brxd+mtc9QRfvianNIZvpaJi9eeEBh9nNJl0Wrbb+rjN9c10O7
 dIyuM5/K5ZJGzHrk1YiTSr21OW9Fbwwnyj/New3naAB6cy1ZFT07LIJi6YiyewOk
 L5sCXR6kVS5FOSclPkLHmu8pDHuY9GFVzAAij17eJts3mEEh2hgcLubIxXZEoyEa
 mzKmFDI7s48MK13Q2027bDDuBheXB6jCr1Zk5eBHs7ModA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjkfkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:07:13 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7a77961b860so1049436137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790784432; x=1791389232;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=59fvn6HNCxIB5d75o9AyYwbT6TRJJUb8uFgR5eg9RW0=;
 b=N7/Buv1AwweqTKlKwSFEgG+5o+hYgkkc93Vu23oaNRwufaE3dQM1IBNFB2SY9g+BjI
 zMJFqEV2Igtm0dbTGdgxKwE9HnF7/ga/rPKUmkRZRlCtg8P3QXmVmFyT802x3dqYAJpQ
 F1Kux0fYLPNtAKoisfoshX/8SZBpIzbyCk6r40c9sH6mov1AyknaeA3FKC/C53TAMjiK
 ur/+k0cTlBSU6R8Ljlne80HLJwNuCeVKlpF0Sb6JIRrtxMoJ6koYCaYz4KfoMhTQQ3uF
 R1nNG7nXJ8KFPxYgya3vqlCn13UyGC4smBcj2x2Cmo0YI6uWaxq4y4xB5DZy68+jMVMn
 H5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784432; x=1791389232;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=59fvn6HNCxIB5d75o9AyYwbT6TRJJUb8uFgR5eg9RW0=;
 b=EGSkI6JSQIxaNL5eEzDbkdmaMq3EzI8r/qmKGjQr7/nVLo0wfk01SLVkTrTgxuWdOV
 3A+jN/iXutQGt4nD3WmwQTkYSHljA+ZRgWgFOvAiKXrK0GN5K8u44Ks3x7z/0EY2brJs
 D4hBZEKG/RPVnsTt7S6U+KgxRhKWtJG/hD6CCSiP1I1/YgYp4oGKsfhPl9+yD+GDnd0H
 41N7oWNbz9G5sU9IrJkj++T6GZh0GtrD6UfvIoflZA+EmGBHs94r8lL7g65jlgQDe0O7
 hdogMV90vItWc/iFwu/iBI+ngQGX2T2ZdscajMHyI9cBIFNF0qV9jygp0tNhn1oNml2n
 asZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK720IzFQ36LdTMW94x4AjXCPD5fx4uasIG4dKCLdwdQVuQr0HVj0nQvmIC9NgLND6GqA1VJK4PjE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIDPIRP08TvVx3R8FU/gW6jH6w5TM3i0HuJAbAEE82m6cwnEAOu
 9A0tShUyPT5KhlEu7k56khV4GVeGWOgUyfAWqY7MqBP5K7+0rK3XWLkh2n0EF35FpphtuPYS3pV
 1LK2z+Bnibi+POdN1Vosio//1X0YNZZeKKhqWSU5xCPIUXhApokcpwinXb3jeN2wq4QjzLY2DhI
 npLZo=
X-Gm-Gg: AYBFou2dKvTk2SFLRAcKWX+Ed+7vlxG8HTjcNEipRNzG/tsaXF4vcvCMaV4RRrWnbcO
 wcx9TbmSJO6FqHRXvVo3O4paiTNWoRIYmgsNxvgMWKcuunPH8dt5xL03ERGHZWamJ2bdZOFPy9s
 RK9s+G+CcJddZ2RdDNmaILJxacLQ3L8sV3UoPeXjVF8VebLxkc4TVtO1nutxQF81FJnLrjg+300
 UF2O+Z5XKGdER67aMHcduSDYEJPTMyMeJ6kC2UVJKK83wgXVC2jf7Oub78rkEG3Amxa+Xaq/563
 npp3jMQjrfqcuE4rTiHDLjhO5MZ2VQOV6v3F3h8+1isW2JfCADZ1LsEJGAW/iDPukFGTCN32Uh6
 pNjl/980dIIu/xafGhWVf0PLL1u/MCDF7I/RuPIgZ7f5Wd26vdL7p1cauiwZiylU3KIPP83UMlA
 xF3vJzn6NInYkN
X-Received: by 2002:a05:6102:91d:b0:7a8:6ffc:1c25 with SMTP id
 ada2fe7eead31-7be72ca7984mr386858137.18.1790784431900; 
 Wed, 30 Sep 2026 09:07:11 -0700 (PDT)
X-Received: by 2002:a05:6102:91d:b0:7a8:6ffc:1c25 with SMTP id
 ada2fe7eead31-7be72ca7984mr386837137.18.1790784431400; 
 Wed, 30 Sep 2026 09:07:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42faa8cbsm82075e87.23.2026.09.30.09.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:07:10 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:07:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 04/13] drm/msm/dp: Serialize HPD state updates
Message-ID: <zzsqfw3ncrse7mtxrp5dmny6fd3grtulhxhpawo6gahugtu7ft@qqshhudt7jen>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-4-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-4-dbbf8b2b42bc@radxa.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX4WzVmbB30swZ
 wnnsFml+dyXfT8SxIHXEMZl3Zm2KaJWe7c4b4D0dSfPuKiKKJYefn5414n0sny0RDw9yHFMWKO3
 X6E6u/LuhNzWsifT/3eBztdfzdKQQM4=
X-Proofpoint-GUID: 9Ggoy4IUGAUEbABlkYT6PaC2h1xaTznE
X-Proofpoint-ORIG-GUID: 9Ggoy4IUGAUEbABlkYT6PaC2h1xaTznE
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd33b1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=zIYKY0NWTygHEUM1x6YA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=-aSRE8QhW-JAV6biHavz:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX9CGNaoryc7Hv
 rtn7HAdxA9E6QTHWKYXqvtxpOAxRwV3VV6cMkPgPGRmrShSWp/6ALfAbpEECQuMr07VMkLUcjF8
 O+xBWLeRWgV0b9AOYLTCIjnbk4rEQdpDmza9jpYFfO2wSE4GeCUxRJLIUVBiA/v7JBYfC1dBBUD
 9TpB/z6Exk6Oo7yQNZZViWr2UNfzW5LEyjbFoRv+Cd1yiPQDX6ICv4vpluLKB5tpcaQ7PmEolJk
 YS5lDbmGC8B8wHN4ANVm+KOlHIuKThv7lw6LW1pTXzH8MUTTNFGGrT1g9oiTuY+JNXDcPVyWHE1
 QjtKMxdNpzyV1Hd9osTeFEeLe1WVpQ/1vFCJJR9w/Abj9j2Md6MBtXO6HsN/LCDjW0Q86ibkJLl
 MJvtInLZ9raPYDd3ZBrx1K6gaBwcHtK25B+GXYJ6EQ18y8eEJUo4EbSPugDm6o7lMgwxZYbxsSd
 xM+JWoMEqEABFjPVsyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300064
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

On Wed, Sep 30, 2026 at 08:41:48PM +0800, Xilin Wu wrote:
> The plug and detect paths hold plugged_lock while accessing the sink
> state, but IRQ-HPD processing updates the same state without that lock.
> Unplug also changes the video-test flag and AUX transfer gate before
> acquiring the lock.
> 
> Cover those updates with plugged_lock so that users of the connection
> lock cannot observe partially updated HPD state. This also lets stream
> failure cleanup decide whether to preserve AUX while excluding HPD
> processing.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
