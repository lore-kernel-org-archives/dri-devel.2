Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC0EFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5618510EB70;
	Tue, 28 Apr 2026 12:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaXsBEdG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddx6N9qx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20B010EB30
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:51:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S7uume3968092
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=32t3b21r1KQk2fgkjfbu0iKT
 hIYQpu1nQvpOz4FMAcc=; b=AaXsBEdGC5H4uhwWSyMgzFjAfiYYKeTWlcdO4BnB
 CFqezHNd9YGUoU+HnH17XAaDGiMRMqdyyQ77ekAC5MsOFUaE/U/xOCp6BG9J3fc5
 5dvlQ28UXObRBG+ZoIIc9Qm6qP+XSIgQPwhqE4S+nEp2HNq5OEANCNDUOWlGkCO4
 2c0oIeYVBU4IjPs7QVobdnfrHKiGaD7FR/hBuMN059SpvXT1EpcgfQFBS1cWWgUZ
 I+w9kdRlYZaJ6EROpcJWQiSKbUVnZq9GLJwoq94KHNVKluiYGliKAU6guwkBSwhh
 KWF08wT9gJoDVHa5o77118ESg1mURhwycjvA+F6OLfambA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0h3dm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:51:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50edf01172bso232233381cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777380688; x=1777985488;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=32t3b21r1KQk2fgkjfbu0iKThIYQpu1nQvpOz4FMAcc=;
 b=ddx6N9qxew3bb1qNPzlhbj7Lu2XYCJXetAybfDLhbeMhP8SCknDArN9P+Bjz6reHpI
 h7BsRFlilSkdd2l4u5N5qaGIdw/zvUeUiCk3P2bXhXfX7f/qy/In5lTk+fROJs8ZaLY2
 Q5gH77yrdnoUmKR37KpiM3pDkwuBravCQ1mudJcqHYQ5HxD8K8LqqYWNNPy7mlZGP5OP
 /oTboj+m1NenMpLyZNRPxKlzY6W0d2eYJb0o0UIXc1WA/l0QOVmJI57OtvGo+dOf5Ryi
 Kr3dIT2cA+0v56QcmJxmhnXJGQkKlqJzFcJiz3Q2Qi6OHDvgw9xriIqNnhOpQUM0mu3e
 LlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777380688; x=1777985488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32t3b21r1KQk2fgkjfbu0iKThIYQpu1nQvpOz4FMAcc=;
 b=hKsF0pb4IDIS5Vd4VpcXfpuE37HWREsdpI2wA2e4sItMKYPrjA1vp6XCSNL/j1vGD/
 X3Dni7Vh0VFUUc6nZIIm59c/fE1IhYypppeIG9zmlEH8j5Xsggoydb1s5Povc4cjoKRC
 tEQc+tMu5GKWBo1zrHL+rUfqss0I5/9WKD+Xz9fzEmHkuIjFQNjH5t034M8wLdqm+FBs
 d6xtzkkUohXDFLmlx+VBgpT/WQJ5XfP2UWxIX+LY+qdIUTG31bmlbvBloaVc3Bg1F+Jk
 vAhJkVemGm4hzJTfzCIeqwr+wZEzXVagEXUIIiiqO+35bdFWxx+q6s1Dx8eCr1H3Q2At
 GjpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tNAnvgoznKiiG+YhdiDe54sH6pV9FjXxAUHGRqoVthxj0HSN67waEqn1nQKR8oEDmFyZDGHD5zXA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc7OU1/3NqHu2aDUpFiJG7f3Gt+qBi6Z9LWlWUmo8Jc2rqGKGb
 Wllh68zON/18QkvqQFdlQErSzcoZoj67JwDg09uRuGzDbRt+BqwGwvoHtgc+QQGQ2fbDlPLyac+
 v6viFvutrWqyVBK9RNKmu5+yyyvwyLXmacrn6kvHthjBSWFPMQDwe5iGnL2Te5NES9oyFecE=
X-Gm-Gg: AeBDieum5GO3YIHrDzbgnDM/9bfqTmigOvz3XihZxgxRDEnurp7qC+NT/khknK0n+Pl
 r4a1mJqPeLKrqMlRXNR9DjDAIXyopLxdA2q+s76DSt0khb1dfKwA97WrX4eeLJciSXR2PXYwJfd
 3Imu/jtBnlC6KzjD81gii/YgEgkR8sdKMr1GBfTHhPr4fsPLPZECDSyUS51ytOhzgz/Hd9qNfkO
 GIrcfrdWq1K1/625FXnDT2H58s3Qrj3PMdWt9gVAKvZXQfQ+kddVhpCsN4o5/gPt+xP5dLzPgAa
 4BuK+0hnn1ixTEg6dWIoP4GHXhFCSCO6cyJVQiWr3gstnTzJ5Q5nbxWVEDHA1TJupvp8Ue9TYMw
 a/BvobJDBNDh7LOS6zpRIDLJ8CTCZ/8KPCzefJUsTtF+n3QcXyFtt4SEKO3PS/Hz+EarBwINvrl
 zrQ3AzsZV209QwkzlSBJ5vDHGd0k1ftwWPePwlLEKYl8K4cw==
X-Received: by 2002:ac8:7c4b:0:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-5100e107b18mr39674411cf.10.1777380688275; 
 Tue, 28 Apr 2026 05:51:28 -0700 (PDT)
X-Received: by 2002:ac8:7c4b:0:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-5100e107b18mr39673101cf.10.1777380687032; 
 Tue, 28 Apr 2026 05:51:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5f91sm600051e87.43.2026.04.28.05.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 05:51:26 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:51:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Fix Kaanapali CWB register configuration
Message-ID: <kgbs7sg5itirg5ovidtifw3rwf35ehjdegatcww2hdlqoefxid@bicocpkv6jd2>
References: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f0ad50 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=g7eih2tgvwwgKFoWVAgA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: IyyARwwCPcGf8f7Ypvwl5nxftJ35PzXn
X-Proofpoint-ORIG-GUID: IyyARwwCPcGf8f7Ypvwl5nxftJ35PzXn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfX5gYrs6Xx/0uC
 Yw/3Ojz3B/AWIgPI3l8bchMBwB+ElfR4UoNIvDkVQDZ4LQDljcdt0P3NAjcJLojWmMVym8yO0v5
 SjDtj0TAaImRBzoWB+SN1bDuvcb64qzisxT29JzZO3kPXJZYH5hG0e2wvrupwNwl/PF6l/i+h73
 ZGKeeieNbt2rSruFMg7OrN1QtcaGq7W1LYIiwEXsZ/Mg1enC8T1W7aN6qlyNgJrBn1qN+VPFgPx
 MzMWP0I7DsdwM+CUwEFyVVPUoj568gwyG+bJGsCeGcT1FLHUvlAJNgOvwO4tw0bKkoG/5uXnm19
 dQ/hQPg0C9eWRaZT4qERJRQRgYciGuSRWTSlyLOsjNIwKYn0plzMzJtngJjfDOpNtAyiQGLi+qV
 Tv9AFcaxJWki01GdghOw4KoD3dX5GPk/xENPyJasdrBQfZ3UfYXoDTjOYgFyBqwvkKI7CHKjNDn
 CPKMHN5vB7+u8S/pixw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280117
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

On Tue, Apr 28, 2026 at 05:14:25PM +0530, Mahadevan P wrote:
> The Kaanapali DPU catalog defines kaanapali_cwb[] with the correct
> CWB base addresses for this platform (0x169200, 0x169600, 0x16a200,
> 0x16a600), but the dpu_kaanapali_cfg struct was mistakenly pointing
> to sm8650_cwb instead. The SM8650 CWB blocks sit at completely
> different offsets (0x66200, 0x66600, 0x7E200, 0x7E600), so using
> them on Kaanapali would program CWB registers at wrong addresses,
> corrupting unrelated hardware blocks and breaking writeback capture.
> 
> Fix this by pointing .cwb to the correct kaanapali_cwb array.
> 
> Fixes: 83fe2cd56b1d ("drm/msm/dpu: Add support for Kaanapali DPU")
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
