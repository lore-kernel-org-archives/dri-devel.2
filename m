Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219E606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e1IitvQw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L6uwz1nr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628D2112A9F;
	Fri, 23 Oct 2026 10:05:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB18112AA2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:05:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FUQM2650423
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tR6WqUzgduImAQJNa+B+OOfRPJTUMCWJUP/DfxjaDDI=; b=e1IitvQwugHSTyFE
 Dm1H4kwMP7I7VgngRGtFJ1/5y1UgtiLBitdqqJjjfUVZAJVxahCNCQ61KI4n8QIq
 lurMPzcozAx6foaQeREbf2vNqWkJ4LLBfnlgITt3FuWwvrxGcnZ29KuFmgN86r/7
 IMEPg0OEGgjEafKdhOIfuGhEtvMKKHmC8yWIoFz6bTifa+vvHo+7Y7lXeqaoJQ0Q
 dLfOxUkKZ+MOR1sU+zn4Rt8uvWAP2s1rG6VBkaaozC1798bvzKniWTXU+UHPhHOR
 OinWOlNs1w4jYqG55QWo+78SiLbCrmZlfNf9Ntx2Rk+lAyI9Hj2It1ZwBv5RLaix
 3rdsbQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjb6bg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:05:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e629c7b16so12219585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792749939; x=1793354739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tR6WqUzgduImAQJNa+B+OOfRPJTUMCWJUP/DfxjaDDI=;
 b=L6uwz1nr1g9KPIkUX6F4vtKg2zqIwtNrW6b6HEYFHpJfQouaoINWx07Vahj6LknLm2
 BBcGDWarDeh6SuZCIzFS3jolGcYHs1iIDSTNZMctkL2ToaCh28vpWW4NZJh9Mx50Ouba
 PjpgDB+SVXxGCs1gBNzMcWPN7BkCQH8U/lDNHxpkyhqekxnBwZZrV9gyVmxgf+2LFuOg
 HA1SynV/vma5oLFYV6HsSsUbFx0NUfZD6yV/CuajAEr17P10A3enmGLvk7xQReiv3RjS
 5KSCgxVpdysbbcG0Loj1IvR+EYXZVcg1NxwE+j2EjTJKee4OeS77bb67RILHCQ4n8ISi
 wHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792749939; x=1793354739;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tR6WqUzgduImAQJNa+B+OOfRPJTUMCWJUP/DfxjaDDI=;
 b=Uj2zNANQ6xmKG9DN+9uBiWjrEbF9ptywEPYTq5jy254nD0nZyxzMqQIiB11e4wEHCi
 XXNBZ+9iUqV89jnQL2kXwsI+8Dj6lfAZT8mUVvFLocqweZ158cDec5AUfBFTuV7j8ymW
 ySR0I9IoEwSEdVbsbZjVRqVdFxtbfcghlNBQIcO9vLpgqpI2OBXBkO5CdyJZ+wUjN3p2
 Z9dFjcZK1Ux0xZCqJ5ZEjLM5imKBB9nmVOM87vBaKstQ2TqcsQYn13R2IoZ2jcRLEtrQ
 Fb1OD8hZruVQ8hFTaJPmmPrjqG61+2tlbmRQWWg0TWx+CQsURN1PtQAMWK+32Uwz03VV
 jweQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByFAjpx8TzZCL3tQGktAmKFnFe13AKOEAWMMPBmg81u+5tzmqJZwsp/Ok700Xd0vCrQruQY5pEbJro=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLo/c6xEpcIr/qVC8yo1y8HRcXIg0H0YXl3Z2QQWghX0hwRGOMU
 VhmXFe3QNFWoP8axIlTlU4FeYp4MZJon+S+Xyt6EUdk9zcdM/NoMevs/U0BWVDCjp+QdF2w9A7w
 UDrRJ3ZjhVPQf9XJHZD8jb4Bm0I+gxgxYDRky2f/M6IoSeJSxwJaQiKzd1K44BUujT+xCVMs=
X-Gm-Gg: AYBFou1M3YtLquVUpYszveeDz5+UjegwtupD9I5GJUNnhz5AQnRYz0zZCU5apc6NzWM
 FML1UdlwsacvaNrht0IbKyK4kph1/b8j0zuXbieYwRmAEzJZ5IkQOunqlijVH/F3yzZ/DanGQvf
 0ONLdgaTz8XUgGN+sReizKGJr9eJfVrWa8BKLHqIAR8GDMEUMS/omj5KgmCA60oqQxAjQc4HU7+
 r4wU/0H8wY9/kAMEUV/sOt9w1I9J8kYkFiDPLFO3mleQONtWpL3XsgrvDAblfkRnRfX6J34/N9/
 HpDnDnNK2I5reZZJfWoNZmH1PT66kmyPOzjWFe8TpkzihIbOj6ER4xNe5uEhEeXzmsISQKSJuir
 /yVH4QhocRye2SvM/fnxs1A==
X-Received: by 2002:a05:620a:7313:10b0:939:8148:1e3d with SMTP id
 af79cd13be357-93f6f7f3e78mr327421985a.2.1792749938486; 
 Fri, 23 Oct 2026 03:05:38 -0700 (PDT)
X-Received: by 2002:a05:620a:7313:10b0:939:8148:1e3d with SMTP id
 af79cd13be357-93f6f7f3e78mr327418185a.2.1792749937962; 
 Fri, 23 Oct 2026 03:05:37 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c4d0d6sm85262566b.29.2026.10.23.03.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:05:37 -0700 (PDT)
Message-ID: <43ca74be-942c-4b52-a87d-1bf13d5dea6e@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:05:34 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Report primary minor index as gpu_mem_total
 gpu_id
To: oushixiong1025@163.com, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20261023072644.542364-1-oushixiong1025@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023072644.542364-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lp07KtXc5hIgdSbSBK0Aos60VHcoyAn-
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb3173 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=nDcocf_55Z5I0WzahHEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX7N3vio7DTO+U
 T3KWPoiwd635okBx8veFZO4V5BHoctsCFNNMrsfHL+/p9BnKwEzdI4zoK/CGm1DF7G8R+l/q2OK
 P7RbsP+D7DL6YS9Qz5KlARu9DFwzESw=
X-Proofpoint-ORIG-GUID: Lp07KtXc5hIgdSbSBK0Aos60VHcoyAn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfXwuJxxGNw5BOY
 wfVIsEtEhyJrSCPQMUKpkAA2kJ1VyYp2dAIxrsZMlys64NEUlE2ZxlhwQxhAX3P5PNx5KZe0zC6
 JZSSng9vNiDQ/wJRos2NyVaX/Z01GLWASgFc57f9Mm1b3ktrQ92PTHC0hRISrM2x1H3Zpjy3oSN
 VIW7PKepYEdAS5hhp5jjxJcZ3uWPE8Pw8+wmczh1P64mUvC9yWMbg3gSKca1jjKvllaG29U2lyr
 AMPFcurnfelnhxHkPqx+J0Ikz6CNGpFZsy3RPz/+GxqfB1BS4/MyR7AyBpm3y5z2CmhzWlpQxGG
 etCP1QTOtnaHYHV+4nPCu3dy3wlYND25SkKjvLq8LAoL2lssFkkVK4RCXmWTY0aqydHcu6W06O4
 4tJUegIkdPellPi71RmjgutO1tPvbGsyyVnvXTUo9yNssxMksRGzMguzwoIZrFmWgmAqmBRoCQV
 HP56ih9iR2v9yrD5MhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 9:26 AM, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> Both gpu_mem_total emissions hardcode gpu_id 0, so events from multiple
> GPUs are indistinguishable. Report dev->primary->index instead, as xe
> already does in commit ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace
> points").
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
