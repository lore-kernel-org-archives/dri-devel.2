Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787A606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vg6n9+Nb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NpcB+Vqn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95C910E719;
	Thu,  5 Nov 2026 21:32:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CAE10E719
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:32:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6DNi1898038
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mHNN4UGYk4f7WxUC5WbYI+QRTZfXHOpEwWQNcGzXGsQ=; b=Vg6n9+NbGZTtVHdj
 Fz7wYa9/FYcyzV22b/1Gg82MrUzkIbdIZmOWOiV+6e/ghF3OVDd6TM+1o3rpdmqX
 9yWlE5N8F91vnpvAozYHL4nPABbkacPq2npUzkH+Zv0a1AcLPmkHC/e2Qfz71FOS
 wCpHILOloAPNxhhbGU1ByUvH+WTMUsm6wO2Ts1qKAcof9FTEhiuh1cGDZbWYu8wa
 HaelUJcU1M70JJDABgwx0W9731gYoPin3mM5O7pWXAKMKiEVujaARKftk9Y82Ndv
 4blXjOTnEuf8gzVqzRnyigSOW+eWdQrKZ6RMUXsXDT6J85ncVEEdLCOmFyl6i8bF
 +PMHMA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v3x3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:32:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1687011eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914341; x=1794519141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mHNN4UGYk4f7WxUC5WbYI+QRTZfXHOpEwWQNcGzXGsQ=;
 b=NpcB+VqnrJJ/LP47tjLWFS3n6xnRq/nF7WeCF1nIc9ZuAptfD+gBYjm2+7TLtW3h0y
 peXKeoKKeiiIPPsUuaLsSnKHpUv9OIQxNnliOew0uozsFGYV08fOWHMV+MS+Z4uh3C16
 wAUGX3I0VvoWk+Fqnz0DHmpYCxDRInwwg/AanBPJdUeeVWc0Ov4E4Ub1byK0/Hc/Eeyn
 aqCxmUKpQZg3MpjpZQi8O/uPxLidH+dVlNrasvT27XCIbthHua16TcEXxt/ITtq1Vn3s
 mG3u3oTWIR+kg0zY6e9nae6Fxl4HiMGa0SqzPyqUwIq4iGiJkHU+geoqAO1lYzhuoktb
 gzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914341; x=1794519141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mHNN4UGYk4f7WxUC5WbYI+QRTZfXHOpEwWQNcGzXGsQ=;
 b=sJcr87YCVBWIz4hlhDowFJPLugAMqVLfOo8YlC1/yz5YK4axcIeJWlBu8lDbifFGAn
 80IszeVBoHw700mMU7pNlofbo3jaX0kkKQ21ianFWslN/0cARoWKlRaPpa1cJK//MWHu
 VK4RDEa7IsX88ABS7gKwGTMhNKKlR0BLUi7AjNAtojtTsYzvqFfwSY6FmZsA4lIojjl2
 xzmdrL/18+3xfxgUXhVRGIJgIyQ1cqiQZvot2Rv8TEu/aux7cfqOZ7b64hbHlq1GC/Y5
 n7MPH/En0MukR93Kyirz3moER77qRRGIBk0z8rrM/BBFV99YhzV6UIRsl8+Vvt1TlA32
 NFrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8DZiuQlHGbwIEK5EAeQBjrPJXi8xOIzgbNjNi3caRfyX39IMPnJZCoFNnqFJa11audqEoQ4Tb6LI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gJF783Tkfvwxx8uh5EiECeGDlu2MZIL7D7C3uLnD2YETLl+fl
 wvOsXt0n8FY5TcWqapGsSkdZrjujIKfXCyG4zMgIL9hu53KSaPCxgLE3K6KNKNVSF/h1Ls1GA5q
 /wqo6Lc27YH+p9lptW8DNiPV6WRf0PTvTI94BeNOaYmpJBZyx7R/ZnKtfwtUERa3BAXGDH2M=
X-Gm-Gg: AYBFou18H4t+0vmK9w6Pwug61o6Q0NeqpMss0E+QDK0zqMSZs2RRvzEnQWvunMKR6w3
 sGi31n9r+f1SzzeSQyWrmmZb4KQfOJ6JCtnLegrpgcsDk0QVkxDvJiV6y/qGYsPlkNK724quGjz
 2DpuQY1laAzXospa2VP3JBx1cBlSb9nmsZxHiKBQsgsh8Z25726vbMyuzxfLvXfzk+MT/mC/gcj
 uhJLOYLdcsr5uKuThQvjo7HvcIFl39iTd7yjOVewizi87vrza5tm0OHTnxfrPQxfAx07rIQRo6Z
 DgesZqt+BMRVzi4/YLJA70msBOC6gdH7xUS25jXM+LFl1E2r2g72I3KLyGRsxweS6oHew0t5YTt
 kDcdG2Z8LwbQwAEVLOjYOrcgpJsLdhzTK583XCCbw8DivQrmPhxmr02emK6EJ5rNh3iN6mDs=
X-Received: by 2002:a05:701b:4552:10b0:184:ae11:51c8 with SMTP id
 a92af1059eb24-1b24f4e1984mr4785370c88.23.1793914341036; 
 Thu, 05 Nov 2026 13:32:21 -0800 (PST)
X-Received: by 2002:a05:701b:4552:10b0:184:ae11:51c8 with SMTP id
 a92af1059eb24-1b24f4e1984mr4785332c88.23.1793914340117; 
 Thu, 05 Nov 2026 13:32:20 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c772fdsm22496768c88.22.2026.11.05.13.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:32:19 -0800 (PST)
Message-ID: <28a3a810-dc7c-404e-9fb7-35bb2daeac15@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:02:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/15] drm/msm/a8xx: Export aperture helpers
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
 <20261105203057.66520-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX7NPdUsT3RU/a
 BPPL8eTx2mifzS5y+W2PXEx0EVN1O526xvvU2cP8iKZCJ7RVyCHZnfK2tPz4qevcgi9V2JWqIJz
 Viecnql/j60T2SGJbqlih5iozbxkW2s=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aecf5e5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=AFLW1XQu_-GHGceg2_QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX0+TWXBSw304h
 QPNuAG31ICG7hNGqPesTi+ClzrPIWhYuqEziL1dMEXoAKVH+VeJNBq5kvzy4zaZ9BER9jMRJltx
 cQblo+PKL9MklhHCfdBaXa+JNJZqrSPoEUywo352Ex61ai1e/LE0m+CDJik7atVxTSsUX+hNA+c
 cFuptdvrms8UVDstDy68muJxY/IfVYoDkyOuPgHfST5s+NpskPyzOPA/O1SujgS/rKfBYNKDCUU
 5X++BMCc7ClswpKv5alglwBQUJkZQNseCT5tXa1cGzgay+ml4wQg/NSC0DpqOmkkP5Y5SJupqEq
 txglKCseeMKlmfDkyR7mY6c3s1axQ7L/tFlzSkvYhqW8ru2+qYd4O/o3qsiIfXdw6rTy7RLQ4+L
 yM5+/shI7qE08C1TldhOAIj2hWzgyR4iyBoKNwZBxMU3HB49vkZfksjoCn39v+BqaGq5mw0erq4
 KA/6QWRQunpWUoiIWiQ==
X-Proofpoint-GUID: HOG_GSD1wRDYYk2KQAKrO2POkrOgdCRZ
X-Proofpoint-ORIG-GUID: HOG_GSD1wRDYYk2KQAKrO2POkrOgdCRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050085
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/2026 1:59 AM, Rob Clark wrote:
> We'll need these from gen8 gpu state snapshot code as well.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index ab4cb43e4a54..c58a2665e9ab 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -346,6 +346,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  int a6xx_zap_shader_init(struct msm_gpu *gpu);
>  
> +void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
> +void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
> +void a8xx_aperture_clear(struct msm_gpu *gpu);
>  void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
>  int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
>  void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 25ee3ac16ed6..82cddaa7278f 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -32,7 +32,7 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
>  	a6xx_gpu->cached_aperture = val;
>  }
>  
> -static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
> +void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> @@ -42,7 +42,7 @@ static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, un
>  	a8xx_aperture_slice_set(gpu, pipe, 0);
>  }
>  
> -static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
> +void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> @@ -50,7 +50,7 @@ static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
>  	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
>  }
>  
> -static void a8xx_aperture_clear(struct msm_gpu *gpu)
> +void a8xx_aperture_clear(struct msm_gpu *gpu)
>  {
>  	unsigned long flags;
>  

