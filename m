Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C18CD98C7
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BA710E8EB;
	Fri, 12 Jun 2026 00:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Of6Pc/GZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TD7UJeSb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9437210E8DC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:28:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BMVnBf1921636
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6l0mQNRXPjow+FlkvrpYn9i3
 O03bnURn14zmv8KuYjo=; b=Of6Pc/GZtoV88SHtzU30JsOQA+uaAbNxpeSqfY4n
 O4NXIMAHOVM1DsUhU8o10S3id6/azs6vJ6ua7IPkw5iKClhkixSpxAgVkW+bIhJF
 /AH6t57RtvNJIsn9JEWVNezRwKdHQrI02EbUhEQmLJER72IYURB72Pe347P1Szkp
 b87sb1WbJo5iiB93IQdygYmQJgzKp0eaIHl7XuKYKfwRQE5itUwCCtyU9hZv+mdQ
 Bx6rm8VYNt0mm3AF7uHdjbhsGPEwZE81d24Pp6gSBvf/Lb9v5NhtBIfUTsBjWt8O
 W0t5GxW686fGuw06JV/SudeKfhEypXmwq1Ql14VYDe5YJQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbhhnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:28:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517e0cdf99fso8931491cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781224083; x=1781828883;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6l0mQNRXPjow+FlkvrpYn9i3O03bnURn14zmv8KuYjo=;
 b=TD7UJeSbH+m+nsmkBR8WkAxE9NWJbcX8AU7vPzxAQyXJzkYlFTx49XrH87jBhRv53g
 Xx6r1+qn6LxRwXl0DdnTXEY4bIBFdIA7BknXEvRu+GMpakzrPSCv0Y5u88qN90IgRKZC
 +L91aE5Ht7yk/zfQkh/ukOC65Ywvmun/Br67CO7Wc1qvcoTB27GNmElw7P998lsd1tvR
 2h0ilcyAzGF/S2FJ2W0+JHDEzlR5qGiaXLo+XdlwDPIxblhtVKkcRxoBMY8w4Tp0A0sI
 RM+rM/qEK2aWKBjXYJdkiongmybLXcuM4B2tGB8r7W11XZhFpWZKbMFqIrbxNMlqAQKs
 tUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781224083; x=1781828883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6l0mQNRXPjow+FlkvrpYn9i3O03bnURn14zmv8KuYjo=;
 b=K4wzDD27xY/KQwpIpphY7G+d9+4bja9xGbbT1QCR3NplcSMm2SPP4FlpTd1PPsjnbo
 6yh9KcZmIZ8YYi/c3/YCN2YSdiPaQFzWTQwma/TInIK0xQKIdW/hZIspL8tjIQuZdwM8
 bZwMs2hjDjSMpsoifPAehHaHyiS0N10T9sf+IEH3AB9Qdx43gpBKiPrL5lBgNMz6/lv1
 8605IXr6J5xN85q2kqVlF1IVB2UonuVGxDTEyHl9GhZNtjUDUVYiWTkg+jwYROHUGauI
 22cl3CUz7JEqd18UpmRtk6nnRCZPERyDI0d+b7Cy9G4I9XfRXARzUS/QOz0RVHx2GnGZ
 lRwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92/DTjLeycryyb72wHAho6e65j1kQoYHfUPK7IvId+DcJgkAAD0L92b+VrjQABQfUVd1YKUM3ocZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcApioPH1DgqeiVbegOkeABj33CuEFQ7bm6gQq3abnznUhM1AA
 jGdCcU1TDB04XSUwhe+C70TF6jLgWTeKOUQtFyfdTle9nwHEA+3y/Y/pOW/55xV7kQR0WHeduUD
 Fh+gD/cj6+W6IclYDMqWBg4llhmT99CdYgOtechTtLWcND65EFwGI5sycuq70AJAW3ukOOSU=
X-Gm-Gg: Acq92OFl6YIe23iMRvaJxUfW1udGtqEicT79o1DGlIFoMCws4u4ps6ZT19bCs+2iyuP
 2p1C+KOYWWN0etyF+d7HopvCypO0jsgO/vXUrSVnNkFJrujZddIGRBxEj1eeU5M7nWUqyyjCAOJ
 6x7D9QrSqiaGuvCv4F6HEDIrq3ZTKiwYlBqgBpuxYQgXqzkeTfz+i+25HN5hJH4ukfTg+g3yBY3
 5hIi7c6m0ftDpfGNV0/naT2xfdGWbE9+pLQWbFUdaHj+Ni5aaa2ZSEOQry5Hz6X8B9lqtW3EfZl
 BUvi8QzxCXOF7VEqFfON3PyEcdvzoTULZ4MkoazHhO9Vvn/DYzynX14qqPWz6OHJ8/N+z2GD/iG
 27RxHS1hybDIeH0jw3gdDb6ECzuYQAYOMbRQZoNx1DKNiZWRR3m4XlW7AoZ9lE3jM6+CZ+++zBT
 dpONVB7Y2hWiyPH8eWzWLHI+3OYUFCC4/T7dc=
X-Received: by 2002:a05:622a:114f:b0:50d:9aff:8b43 with SMTP id
 d75a77b69052e-517fe4cac8bmr8368971cf.10.1781224082809; 
 Thu, 11 Jun 2026 17:28:02 -0700 (PDT)
X-Received: by 2002:a05:622a:114f:b0:50d:9aff:8b43 with SMTP id
 d75a77b69052e-517fe4cac8bmr8368501cf.10.1781224082373; 
 Thu, 11 Jun 2026 17:28:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1a7328sm50908e87.45.2026.06.11.17.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:28:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 03:27:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH next] drm/msm/adreno: fix use after free on error path in
 a6xx_gpu_init()
Message-ID: <naq44ergspdygj47u3evs5vcgovqokpbenblokuskea3mwnqkh@qirq4jd2f5qh>
References: <aiqNktNfXiaPhje3@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiqNktNfXiaPhje3@stanley.mountain>
X-Proofpoint-GUID: KdoG4cPM3wUrvnRXgWh9vcOJ6uRWz2Vo
X-Proofpoint-ORIG-GUID: KdoG4cPM3wUrvnRXgWh9vcOJ6uRWz2Vo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAwMiBTYWx0ZWRfXxr5CyX1Mfzvh
 nqMsSNJBXxHvkcBU8ObMCEGb7IfEg8mP1z2DCGzgyLo7XkbrebCJ3l9rNDlvBe3Ce3lKe7UrHEz
 OWS0ceJ5vTWFNmTnp3lpPEapf5FvBng=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2b5293 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Lf4_qmz2JCIWfjkWoTMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAwMiBTYWx0ZWRfX9mJtmYEvJ8N3
 lqfzq+19Z7YJt5XOiKDWs2JdJ7BQrkWEyamT3I+oq3s5In/P8+JWCprJ3u+rW4hu/NzkVrt86PI
 hU8FkQCbd1eOzbTp5fNR6Ufz5lt1C1wsbRF/xokAJ4YeLznTK2E/M1P/H1kZtGbE4gLTrs8Lrm8
 qAeqLSy08Ab1uDq0nHFH05vtAunFii6hjBGY9RTj4kYGSVgdC7dFcBQTRWXY2q5nRSlASHxyAf0
 t2PoRZL8SfXlKQv5Gn6Q0ZAm+KYnYNrP0ADNCvPJIncQPp5tBQSe8LC12Wc9Q9gYW7tnGK40Dc5
 qj+pAw0P/wikzmPw892gT3fY50M7L3RjdiM+CdLxanXTl7UlRRXEqUjSq2EKARUi0Vklag3SSBF
 +M9YIk56xb+a6p9aXJ1b9v/VBMqU/cWhbxqbsGAZzsFDXcblZqj/Hy4yLo06woygp26DDMTZcHP
 96iISnM9BLrMkiE0xcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120002
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

On Thu, Jun 11, 2026 at 01:27:30PM +0300, Dan Carpenter wrote:
> The a6xx_destroy() function frees "a6xx_gpu" and so "adreno_gpu" points
> to freed memory.  Preserve the error code before freeing the memory to
> avoid a use after free.
> 
> Fixes: d158886cba08 ("drm/msm/adreno: Trust the SSoT UBWC config")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
