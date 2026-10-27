Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F2606A322
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HIppQxKc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bq1bASx5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852F10E410;
	Tue, 27 Oct 2026 14:24:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C328A10F5A1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:24:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoGYE2948260
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LN1Oeyao2kg5V9q6w22O9xhm9h+2v4Y2mED0tEdoGDw=; b=HIppQxKcJFJOi7wA
 c2VTSdgE9+YCIX1z5JXXPX7eC+wPYYAInjIz9MJ03SHS6MqBT89JXG4kDEeeY5bH
 nttxdLQzCQuGpUPRMF7prX5DWvmtr7bzH+D88VdvdjRe1StqTNMfj8n0npLcRx4l
 ybhSR8uFcKR2LPMhPC9CaY8JVacJapAAIEZDtn+46404U9cNg5Ro3VOMZpL/SVjZ
 LY2BrXEgWHh68aa/7zA5/0UGc0Kvs4q2hIb7LfRqbVZ/f0NL76BOW7Rt0vrfXdEs
 4b93ZKzQloMF1O/pYiT7S6wkXosBiq2/22jmlfYEeOg8zNglM6fxk1q+0PLIRjg4
 wDJoDQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw21hqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:24:13 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c0e2566d30so81850137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111053; x=1793715853;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LN1Oeyao2kg5V9q6w22O9xhm9h+2v4Y2mED0tEdoGDw=;
 b=Bq1bASx5NPPigh51qO12+rTUTdEosVOUaFVuEFCTJc1zpC+HaFg+2TTN5K5CqQv0wN
 68hH3hdBsJ+ZZRmJgWl9bv3yoJzm/FNB3xCQoJDbKi/WbfeGcGzQJ/UymnEr8aaWomfH
 0GTvKZhQMdhZC7nPWV7/9o5kXx89zgTcg1j6nqpD/nEWDGPvDkVa2XQtv0WRTeTzAzSY
 rKHb5dayBbAxilEkFRLii/WhS/Mh0lOmHRKM9d5DlsyZaGB7bc13waXND20Qc6OCKRrK
 Nwd20BMxlU52TpogwJOj0YoMdDqPLdPGhfYvT8q+1gS8i1j85qmQdN8Mpf3g+9aiNx7Q
 eiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111053; x=1793715853;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LN1Oeyao2kg5V9q6w22O9xhm9h+2v4Y2mED0tEdoGDw=;
 b=qOcVuuz4m6/zpTNyfDkzrzeAznJ58yLdZO99d4uzwjPhbDFZDXe5zMhpRM915r1Q98
 qRiqk5hwGb/rmwsB6id3KRmhFxkcxgua7FiIDDzx2/PNM2wAbAtEZaxinmcWDQEmTPtK
 LgOzceWasVo+aiail3rM96OjynLZWKeCuUF+xOgfmD3lVm95a9AnPgy0/TUC+VW5Qh3L
 1bDIHbq46g+jm9dZuaV/e9EXGbKP+q4NVyMRX+KxLZDpyiuVIv9I85KBhoOIuzU8QPHa
 5mccmSZPxtxMtLtn+uEAqPfhiFrZsV33URWbKjZX3net54U3CF/ePfSllPQ+KLF1cWza
 d5Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvByXF7HQqSMti0SeXvHGEi/XxfF0Y4xor6wv2IJ5a8zyl9Cdij33He6cxPvNtf52XAx1N7bSANkl0qA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3ucM7KbdGJQX6GL3JJuLp54VSullt/pD1E+wecmpAjGpzcCQl
 5lODsJ+Av1u4caCN0dUQk+rfNeVUr12CHZUGsrNmKFpUiHLveAOzSDVt0enC3dJePhRukaBdHgN
 w7EbKqIAhdnxhaiIMQUE6OfsUTELxjMyhJbL3pBWFVKjFygt7NKUIGBbLeB0L8vE0mtfaD4s=
X-Gm-Gg: AYBFou1DNN7UCSUuWsnh1Q07Ncyb4XM1NNFwDG2nXZDz6vZWFAQae58CkXRx92wXX7B
 ou6K2y8cNaNYtm5ySI67HEnJTi9OXEcJHvn8ICiReX0Iix9naa2cpAcLZ6rnm2lyzBQmirGDUHu
 zns/qvDPfrtzP2vAMkegOTHCkBcv+8+SD3iLlFTKzzzfzmEITCmN0niQj1lxg5Ug+1miwfE+zSK
 kvueLfTkxYD/z9omcT3h0OnIqZgH8iMCrZ9gdyqFJZEChTxfb+uj9e8B8ip7aK39G2SZCtSKYMF
 Vs5MX3ccNiE47vm7pTnKOJpGFPjDckshNLWRuknDuJnhBy83bhMBf7RhOgkfy9S1c69m1T4OvpI
 V/tBMPagHgW/4UAEYFQEVug==
X-Received: by 2002:a05:6102:8698:20b0:7cc:1137:9d98 with SMTP id
 ada2fe7eead31-7ce5c6ac82cmr3604872137.0.1793111052671; 
 Tue, 27 Oct 2026 07:24:12 -0700 (PDT)
X-Received: by 2002:a05:6102:8698:20b0:7cc:1137:9d98 with SMTP id
 ada2fe7eead31-7ce5c6ac82cmr3604839137.0.1793111052163; 
 Tue, 27 Oct 2026 07:24:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b49602346esm180294a12.7.2026.10.27.07.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:24:11 -0700 (PDT)
Message-ID: <2dc67d8c-f406-44e9-bf54-12704a8792de@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:24:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/gem: Add some cleanup.h
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Bart Van Assche <bvanassche@acm.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261027141430.20258-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027141430.20258-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfX6isrAj8PV8vE
 KvdxmWXGs/WF2vlphwxYd++dr09CiYPfl2V6Z4tOfE15GrJXlGmWNoHou/W1VsHwFWrnjEzehes
 WtAXpkH1Fgoun05PrKkiWIzRB7La+InUFiSbH2r9EX+PzId4aLzUxaBY4oQdD1dG3jtaYPjSMVg
 7ws1BAmY/hl8Qh/eaET5iNB/YtnQ13tteIYVbv1QwwAYssvodRPS7x3tBzlft+aRJtU/HT29PzU
 YaLXjvGQ9FzuK78MxeeInm/I2QCNf/3DoSJnNWAvzggp+8cOuNWcmnjICqWcx91b/bRl4LUW/xk
 CsYuX6EOIHESONb5udWlyK+Z+Mk9JLWLIi1vIg7b8SdhnmBueexRq1dUFCPgHrE5/XjZV2KlFee
 sWrV+rNbB8TdtnMxFsIRRDy6Yv0Whm4noPYFVIiKUCleGhvpof9S2AbkuPSe2mcMmb5X74MEMIn
 8ei2IkOytxVNdFwHHYw==
X-Proofpoint-GUID: aAexnFknlAvIB4iJTm_QrUSl7tMWOPBo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfX2AfefQCUvjHm
 GVB+KGxahCH7iCqXyx6mIuBC7QuC4lhuBsnz06gI1NXnciM0sast6yqc1rjxD2zmJHwXJ4YLEu/
 ollae86bw8VloviDdn4mhuEdeC9Q3SY=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0b40d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=OIDORtarOpwJ7gKWPgsA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: aAexnFknlAvIB4iJTm_QrUSl7tMWOPBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270057
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 3:14 PM, Rob Clark wrote:
> Convert (most of) the msm_gem_lock() and friends over to scope based
> cleanup.
> 
> Other than fixing a lock leak in msm_ioctl_gem_info_set_metadata() there
> should be no functional change.

[...]


> @@ -608,26 +600,20 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
>  		return 0;
>  	}
>  
> -	ret = msm_gem_lock_interruptible(obj);
> -	if (ret)
> -		return ret;

LLM is a bit grumpy since this no longer returns all of the return
codes that it can but I think it doesn't matter

There's a couple of single-line-scopes we could shave off but any
which way

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
