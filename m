Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDAFCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC4910EE31;
	Mon,  8 Jun 2026 07:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OnDbjHp/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+WkZ4MC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D2310EE31
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:30:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OrId2274533
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NOB6PzJKBKCAB9iTakZfR6X+
 Qsh3+zB9I23qh+8RjR0=; b=OnDbjHp/k4F3OTgAI2di9svMWYMvsGfuj2JuJpkN
 ApcmStw6/dloyNqntXpNN9/P04dJVNfVQZ8NgjeF23a8k/uZ3uqnRxoJxrAfObxD
 8CHPLb5Gdk5ziBPR7RTnKlUSbt3pAvUDuYmS4oVVpodCD4UbtrTrgH4BTFunM/fD
 KVuHmMWQoN4aIGWJS8zxRprcbWXx4AudQTJx62xAhN8H5YTaTwRjvN5kH4jdiRo+
 q0KdilzY1+8pCtgifgu9e0lOQweukGZmKoUhnDjGdIrM60YQ8Vxk5Y/GcQfZ8gYd
 rjffU7AW9BDkJXVzlNQQ8V2ORPxyZ+TF9dm7YBr/WJL4yg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgx8rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:30:39 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-96387f0ca7bso1234154241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780903838; x=1781508638;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NOB6PzJKBKCAB9iTakZfR6X+Qsh3+zB9I23qh+8RjR0=;
 b=I+WkZ4MCFESzQxmbAawsWULLyQUkrg1l+XDzOe3F7PB0gzyVsGUKdjGerPB35eyHlJ
 YMqzFf46m1hxD0bixLpuLOMdjEt9qBVOVXTbfLocE4tCyFu1SD0g0TZ6OtCyDFT/3LWX
 O+0+qp9ZcFMOQ8GxSq5YrRcoyQRMO+sBPHOFW0qZ9z5rMN4ttNfUdIE33TRoTt3oX3c6
 0hKnu54/0TbIGzbU0AtVDwNFiWdJBFc1JXtza8nydBt+/T3s2L97WL0gAfwiigqIScDc
 GehhSuF+C2oJ70xOUTFdaYNpe0Y2J2wiggbFGZHijTR3Kmw8Sm3xnvkv6f5iZNtKImTr
 P+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780903838; x=1781508638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOB6PzJKBKCAB9iTakZfR6X+Qsh3+zB9I23qh+8RjR0=;
 b=Cj8T+iqkexkC/RIyH+u1p37kPjv33ShUSbnhIkfZ6W3EtSTgQNTjD8JbFGiFW89ivZ
 u2gLxpJbIfutrqkw+8c5lWi7FhHW0ztqU8n/aHIaOnxZKNUttA5aqKjXK9o2zLp34cIM
 WgIugq4TZy5e/WHxz0e9IEK/J7HqU270+xwLwbRzy2+oU0nUK4k/E0saWdGbLjjdVuR8
 xBe9SPUTA0qvoNINqkLcajbeBgShJa0dMxHQUn7JpTCcDnpnvLLvUDo9rEvvIWLWz/IL
 qqZnRYb3r8WCQLdNvrSSYXHAFFCRhb2soxblJ49R6FCkNyT/QUVzbtmo0bbZJZI3HZvX
 s5Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ll2sPySs6Ys/zPRUOot+6vXH/8U4DAK8f1sqbQhpVQ0JkW8AzIo0tGHIYrbPzcQuIi2ij5lvNi8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbYPJDHTcR1Q8jpLDKazn1LJxx7MUiEvKobjhc/XkxDYF8P6oH
 s+FL2TjqF8ltFACM8dioHpW8+wYYPI2CiisMQDCaJpkaK/YYr+ZurFE4d8d1MKf4t9UFD7ZKIRj
 PDBs7BDVlHUzhfp7khZ3r7lZdXlxiPPagIoOt+yZ5QW+0bOPzF2s7J/5+mavT2xr8fj4QhN0=
X-Gm-Gg: Acq92OH0z9L1Rf1bR1zmyOZy2MAh/fJQE1InQ5t9hwJ1iyssLXZF0Q9ODSH6i2/udM7
 i9uSF9yHa+GD5rN4QFNTsnyAKV0L1ugCP4J/ZkmYgHkheBziUArQPGgJTto/siemFsd72lJ+WK1
 V8H/514iFIJNNLWiSe9xpLq7uhJffzF42wcLREHWwg79O9Gegpits8Y+VVr6X2VmwV9IUm7HNPf
 +Tkl+npUkBH26hNdIulXau0ZmZAOu48/he8AUniQzwzpre1R11IjbNxF+0TP9TzC/q9QRaHPi0i
 PifktCDs7S1qmboGhiIgqyykfrUR1iT3qOpDb8IaCHmT+WxLX4cEqPhpF1b3Gzg9YQ2StjAW9DF
 0zfTxG4FOLn53LwmYdBtUoBYKgcgz6Bd6iAKUi/X0Q+QQStEmHtb6YCoHJYjEsCWFLL28y8FF0F
 REqMPbDDyrbDYgOmonAdqggQFTOYYg917+MIUCkZYZ/sTaxA==
X-Received: by 2002:a05:6102:32c3:b0:639:3b08:d64c with SMTP id
 ada2fe7eead31-6fef353f3a7mr6149018137.13.1780903838277; 
 Mon, 08 Jun 2026 00:30:38 -0700 (PDT)
X-Received: by 2002:a05:6102:32c3:b0:639:3b08:d64c with SMTP id
 ada2fe7eead31-6fef353f3a7mr6149007137.13.1780903837833; 
 Mon, 08 Jun 2026 00:30:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b904207sm3590321e87.32.2026.06.08.00.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:30:36 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:30:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: take fl->lock when moving mmaps on
 interrupted invoke
Message-ID: <jjfpssvbbhbpxcx5z3p7r7wcowcokscqfjh2jmbqgmjra3ibp5@a5fxebdiwqhr>
References: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a266f9f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=2y4kR7mgpDsC-dX1eGkA:9
 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: Tu_3pV5DwyffAzH9Mno_E94XxqcRdcT4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NyBTYWx0ZWRfXxdOyT53xsOGH
 SVv18y+vTjzQvT0nEYbbKOeAO7yfwq21Z1aAHtrD1cvGI2s8hF9TWocdJuENhy6eWRlLG2H30iT
 TXROzRTucL57xsHstc1y3WinnYQqzMs0ZTQrAmSXuaV6i/44PS8wucPTBLREdWtSf/VUeY5nsue
 bWJFSKB8piBllVUyOdZZspvI6L+W7p77ut7U5fFwngthdPKI0HE9Lbbh8m9WPyz99Ngvran02mT
 B4Hpoix3M5PBFFgv78+Oto7mO5HE3SSI6QumXT7Qs04Hj6CQz2che3oIm8L+qQ/9vTW9EZ6MVei
 mICYL3p81T7LQ9LaKmVNZM1xbI+JdVPxldsK/KNlTJ+BLs1HtJ9ukrszxXm+6n/Iksnh0relFvq
 OSmRZoqvtB20xCWDFXU7fe3GrluDD7tIzhED6pSfnHEt0FPkBlZ6luVjDFNy/3xcr2W7gHtMlbL
 FjITIP55Fxj+tCm8xxg==
X-Proofpoint-ORIG-GUID: Tu_3pV5DwyffAzH9Mno_E94XxqcRdcT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080067
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

On Tue, Jun 02, 2026 at 01:29:58PM +0800, Junrui Luo wrote:
> When an invoke is interrupted by a signal,
> wait_for_completion_interruptible() returns -ERESTARTSYS and
> fastrpc_internal_invoke() moves every buffer from fl->mmaps onto
> cctx->invoke_interrupted_mmaps. This list_del()/list_add_tail() walk
> runs without holding fl->lock, the lock that serialises fl->mmaps in
> fastrpc_req_mmap() and fastrpc_req_munmap() everywhere else.
> 
> Take fl->lock around the move, matching every other fl->mmaps accessor.
> 
> Fixes: 76e8e4ace1ed ("misc: fastrpc: Safekeep mmaps on interrupted invoke")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/misc/fastrpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
