Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B836606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m9CCfkDH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eaU9HjSt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B1689B78;
	Mon, 26 Oct 2026 09:22:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EE210ED0E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:22:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xN3X1912088
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBHz0YV3YdiXGolaXXLrTp8rFrwcwAaKpHWy6zk0/rM=; b=m9CCfkDHBtQtvar0
 NYfH7dg81uQPVwzS1po3OITBRmUfqMcPwOo5cWXJyjfvoXUoQNYe3lSx/ObzhQ2e
 Ch7m2dCfokKZPKrkU4GTRz213IWkhyTHfoRcss+h6wVIQIidhaCVk1hZttIpvvIq
 9qoTTtKleoaH7M/pp3UV6nnngrJpyWHrrDyVcG6M3eWd9/aVfKRyAhgnfCzfInNm
 Lfu/Bkog2SmK8A1GZXAsXx7/GSosAqAkK9PfLmoRy0exxp1BgtM9zDzdqw8XIeAJ
 VsN6RIFgHALZX3oIeQgiDBjmCLRzdSfznhVGLf4J94QEs5/0K82TaWyoTtKTEw9t
 C6AARw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u602rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:22:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c5ffce3f4so2582116d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006533; x=1793611333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iBHz0YV3YdiXGolaXXLrTp8rFrwcwAaKpHWy6zk0/rM=;
 b=eaU9HjStbr1j7CIU4V3TEIWs5hmG0XYiNZkcYhhjReQAlqKV6jd9TNZ/DHwIvJYNkt
 sm8Q4KHVXReyZtSPGU3AGrPNrkkEKre6hbwg20wrHXJara7y0BWiv7PgAXKrDLTg74Cg
 5IEzS7bDUzrLcLiQPQJ0tABFki6U27j5q4htqZQ1arIyitDzhHvJLJfSxF+Og65WdsMX
 I23VBxUNnqOwUwkKLX9izckfnGWbLF7npxBAcK4fwkifU/fGmhZpQfoForUioUCIPOTk
 iRKiOMUyFFEJv+DUwiQ9hfYSpX9HUHQZi8LAElH++oZyVpySfLP4slM1mvzOGMwLXbR6
 nPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006533; x=1793611333;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iBHz0YV3YdiXGolaXXLrTp8rFrwcwAaKpHWy6zk0/rM=;
 b=xrkHBsQ2hoyzTSZtzaPshbtWLz558EZeC+ovRroGoOmCNc1zdX7DekcdGAivkv/QnE
 NHGOQgPvGCNobvre/NpB30saj2Kbj6oG0ggx4p5NtBWgTfXVLV5EUTRgj1sr3QLAYKpT
 hRVDFf/aj8Ggx+YoGItH1pyp1qSSTx3iOBscqy5JcFRIWzNAK5bhfEL4Bnc7pcM+j21E
 6KJi9wPZsf4V+11/+P1sx7lJ1ByKQvKrrQ02XDq7F1PhB1l1xwlgv6pH7P1EUqdjgL4N
 eFJjQRLbGixH6yyG6GpV+KNGPG1z2FvW8FWnQz+jXuhbRMvdEpKYAqPps0PsKvH4FOYS
 G9MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxvmbt8K3fSn3xpp/1bhSLEhcFUvnuL+pxRdkyY53vSnoN7jU6iKYnhG55styFKfKLYsrlSXR+qXg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbwPwiIcJcEJieI2rZheD3OnaADMiYQjq7ZPDQ4MZBsepKgZxc
 xzMEzoSPuKWJjhrKl0o+zYaGF4Lszsms0VSdqc5S+AUiuaogMq8BtmV2QCkCiIiqGfKi3wtQ4lr
 LxlphRV7YcWcQe2pFZxL8utP4+4+wxWiEsq5stY9WBuCayY4NkdWb9sAfiOxb6yvUzE7D8xrFUg
 kcbFA=
X-Gm-Gg: AYBFou2sFbf+C3fCviXuFyw1E2O6coB8+4KtezX6sjK3tBOl++3Rnej9oQnEoXQ6+uu
 jy/cs6tpsC4MxSggK8eRNjnBCdCt0FZvrFB6MLWfq1D5s6bumXpmeKNpCOeFW7nW+XR2h+9YyXl
 3hbDkI0dbQW2pGPMCFLTF2Fz75ZyFgCm43t8NtqWj9ChvxAp/B0NnKE9gL+oxm0PnblLgK7os8K
 J2AoHVG+qb0cJKD71TrSvlOF6TbjDtmUso/ktr4OIgIzbQfrMC+uz+VWN914r1B2XEkXG9TePkS
 v08UEW/IGOb5hxdJy6FLTOfxwxjo0f1Ghsxsa7XpqqdXVQv0wxQgKuhnfrXOqyS+5TMiGaw0dKq
 6cOAud9MqCckVveLSvG+CSg==
X-Received: by 2002:a05:620a:8703:20b0:93f:a34:d9fa with SMTP id
 af79cd13be357-940ef7d5676mr947659285a.1.1793006532775; 
 Mon, 26 Oct 2026 02:22:12 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:20b0:93f:a34:d9fa with SMTP id
 af79cd13be357-940ef7d5676mr947656285a.1.1793006532304; 
 Mon, 26 Oct 2026 02:22:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4992141068sm76044666b.60.2026.10.26.02.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:22:11 -0700 (PDT)
Message-ID: <a2905078-a7ca-4241-92f1-d4d2b0de3984@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:22:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] drm/msm/mdp5: forget the hardware blocks of a
 previous bind
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-2-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-2-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HxnML9FHUdBNp7K4g2mMGivzxwySaDF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX7i52/Jpiwr7X
 SvdP5kXp9gcY0Pj/HZw0eyOnJl5aLeLwT8wiXS0Kco50weeqEsX/XNZElHdyQ2gaTeiw/357lRb
 bE1Hib/OKig803HNAmscIxRyoQm2pnPUVL+0TDPaJo6rCWg2Mf4LeeFi0zR1ojr5Z3YxrTBCCXB
 vJ7zhKxGsbOXqDYfkShQbZ+SJPILeKuYC/WsqQ/4Dn92Cg4qgrJWrLYX5pBEtGSPtJEX+uxKCbl
 uSsuV6JpjlPC1f6g/qXn+fund7ypZfXgASmp+kja4ZIW54eyWTC0cD9vuWC1iQGNUTHCsqo3XcJ
 4XtIyxGghVgGdW7eKqphzieazv1YgLHw0TokioCjtSuitk3UJBDzv6gvn4W9nfM4PMPQ65aAg2r
 q9WkQmOYn+MgllNHr6N/I7nsGca26OXnm0jaGimzCTSaEiRzfZA6BbxNRjOule2KsJ0cPamZuDC
 lkfHlKf4oAbLPU1ir4w==
X-Proofpoint-ORIG-GUID: HxnML9FHUdBNp7K4g2mMGivzxwySaDF9
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf1bc5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=sdshgxurkjS-ratPg-cA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNyBTYWx0ZWRfX6TzfhckZRJaZ
 JrDSVCr2nBpRTx3JCkO47kKQhk6U0UnBGHlS5C+RbOodipSoPVnil+CXiBigS4QUVbChHayPTkU
 hUwx73Dc7K/yv1/rQn9kEH+fjA/A3II=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260037
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

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> Binding the MDP5 driver again, after an unbind or after a failed bind,
> corrupts struct mdp5_kms. On DB820c, binding it after a failed bind
> oopses in hwmixer_init():
> 
>   Unable to handle kernel paging request at virtual address ffff0004d411f9d8
>   pc : mdp5_kms_init+0x264/0x7f8
> 
> Since mdp5_kms is allocated in mdp5_dev_probe(), it outlives the bind,
> but hwpipe_init(), hwmixer_init() and interface_init() still run on
> each bind and append to the hwpipes[], hwmixers[] and intfs[] arrays
> without resetting their counts. The second bind writes past the end of
> hwpipes[] into the fields which follow it.
> 
> Reset the counts when the hardware blocks are torn down. The blocks
> themselves are devm-allocated on the MDP5 device on each bind and are
> only freed when it is unbound; that leak is left for a separate change.
> 
> Fixes: 1f50db2f3e1e ("drm/msm/mdp5: move resource allocation to the _probe function")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
