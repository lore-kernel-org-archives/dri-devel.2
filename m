Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VqEqEuWs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KLC8qzNU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CD010ED25;
	Mon, 26 Oct 2026 09:39:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F4210ED25
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:39:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arjN1181759
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w/iLWULZfyYJInPergzM8rUXSCK5Rmi/SGvYDtmq1OU=; b=VqEqEuWsgh56Xb9S
 cpHo/6LH6TuyV1z5cwX6i1uDLS4x1T//86MpXUTsu5MMWf6+TsnwGF05rtpnEZBy
 XjVFds75SQXXXJSs7Ly7Be+PQvWNie+qFOL4SWh55be1xsvqKSJ3xFFnCC47axBj
 j9IUjBhv0yob73caB09JK/n02LNy7dv8vqkFDasko08DTLjQRcm/IjAsOnOs98zl
 KduK/fnyxop99YY0zy+25gySF14ZjfKBN25wOimjCHVjZm3Engw1GNMNBct8O7DX
 uTjseWvxN1hCmQpd6h7dRp3o9unLBsWC1pWtUj33C0CmiWeH2qCxiBCRn8HPC4se
 kqS/gA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27wrd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:39:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ea6b66e53so36073285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007567; x=1793612367;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w/iLWULZfyYJInPergzM8rUXSCK5Rmi/SGvYDtmq1OU=;
 b=KLC8qzNUbn6PHRCEE/K8dYnz4OLNFOxAvoiu5WmEvbQndz4/F8M5BHDNI16WjFn0di
 vLWFpR9dMHjwhHDSyCyHxqgr1Lhet8C0N/o74Oox3nJts8vwzWZOKc9ukJeDp3wFvKWZ
 6qSbbjDR4M52gtMph0ELe9q8LQpG03Cao1xComlos3j98cBZMwy8JJG8dxP59x0Kgb2p
 FKylTRbNau9YYkjgMuLYmBuBnmw6oWcC9dA4oWaVL9nbl9jZK28XuEIo5WBbGHeNVSI3
 dUPampPYRM/ubsuC3RlaQhwUT5g67j9FyUnC11pOyir99yfg6WS+QOeeqixdmi8GuJ8K
 /fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007567; x=1793612367;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/iLWULZfyYJInPergzM8rUXSCK5Rmi/SGvYDtmq1OU=;
 b=0+o9i16G6ujQnsQ/jagnL4llMN+71bBXXaPJyqVma2WexqdolmEGBCoZWXbHV5zbjG
 kmw6R3U8zk0tKSmAif5VkFLsN/uExNUE0XVJZ9VryL3Q2UYGdrTUfjZCx6vQvPQXhboC
 sRmB5bKYOBDmriJ5AFZLhGIhWf/Gh2PEFJhQuGf0OJLGWJp8YM6orSVmYigw7M57PulQ
 ryOtO5kr4METmVXlV2OIFyb2/C8UUVaAcJRZ1ByghyTw7zM81ZIA23QeFPUv8cqTXf1t
 RzLpKKMwySvnVq28c3KmkF9oMBKSMqA/qRLnAp3p99asdEXOKnuTKDSsurVxjy7vuxpw
 rjaw==
X-Forwarded-Encrypted: i=1;
 AKwUvByX7wGBqUHu2WDCK5Qe2zh4fJ4fawljX7FLRtow5oAAoyVacI6YUhxdTpWiFO7BpFda32uVxd8ZvY8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIm+e1SzReMBqiO3fW8vaBjFpIS8SWmGDSaOB0x0E4pzs7IPtYj
 TEFkTJdt9W1Wl7DYoEwVw1CKI4SfGkZCchFrATjkeN1KI+CpTMrUm/1xd/gAEOxOf/98EdzGmg0
 MwVapqzgKQRs7TX55nCv49GbUUzvI+cwlH3waPZcA5kQJVjIAhknuUI5/NFkMFzaUAPyEjhI=
X-Gm-Gg: AYBFou03xN/0THTMuOJknrsuMUnlpirki3cwmKJK9cb7qoEwwjTRioiC5+ikW/nkrYe
 WHO3U1j2u+f0A9o9Qzz7aUGDR4ArwHltEjJ9u7cbJ5z4qDgvQZtnV0RYENGZjNSPvTepQzi8Zox
 1nXBzospaKHc1Q488BbQkbR0K+w7mtg3IChx8Wv2N5l0vsfNLHl44N+1jC/7sy1XQqceSmfVRer
 AuJZv7i7rHitfswjY8+mse6dDnTAe4+cxDp+SS8DLNTXkW/sOH0LwmkkZOR6oKQ3gqgy1DXJDSg
 2eTnftkAOfJHL6GhFQsJ9Lwv+f1LoMCGlGGacvNiRqk7FVgd7v1+f5v1wDWLvtp0zz48/Hi69NZ
 Rtgnn6zE2xq+3zg1AkE2HFA==
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id
 af79cd13be357-940ef8dcadamr953765685a.3.1793007567277; 
 Mon, 26 Oct 2026 02:39:27 -0700 (PDT)
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id
 af79cd13be357-940ef8dcadamr953764285a.3.1793007566871; 
 Mon, 26 Oct 2026 02:39:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595e25fsm3393695a12.7.2026.10.26.02.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:39:26 -0700 (PDT)
Message-ID: <aaca9b2e-d318-494b-8313-46945dfb96a4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:39:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] drm/msm/mdp5: unwind a failed mdp5_kms_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-7-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-7-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf1fd0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=b3vL7svAqNHW8n6rvRwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: GsE1EtIxe0CfDd1kl0aFhwLWnfnmlkXv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXx4335vixsB3j
 90walBhjgp3SF6LQuOA3YEmEV4UTvvTg5UrLnhvCZKxjMmd1wlPLTPMcjME02WTFEkKeJXUIvM4
 W8FlLx8H8qMyWZRMHsRfji0OXXeiCK4=
X-Proofpoint-GUID: GsE1EtIxe0CfDd1kl0aFhwLWnfnmlkXv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX2kPociqb6Vq5
 EQ1R7vAbMdCYSjS3cgc+xNKg7ETq+gLMlqEPXjjwGHuQKnaE9TvakxTBeIFHHBBh1YTzs8PafL7
 LPQ7V9R9XnbVO8EuIdslnCWWdcwoKDRzDBTvT3nhS6K4SxNB9wzlbbwK5vnAXd+dkiPnSFOtfGl
 AnCfXBI0uxUeS+PZze7HzpIpga8EWLOY4LVkgqeN3ju6/pHnOApzUrOCbnnuA/lOBfazbqzIrbR
 HoZq4p1qFmdFlm4EOMUlfvFO+JUrw7WVfcvFY+4edqxvFh41WjhWIX+Auzb+7hJKI/vjSud6GBB
 wO+ostQ6gBb+AQZJPSWWVfE657hGGGq3qTTn20GZxYAcHhHfStYNFqOta4+IG6P74hmc77yPnpy
 1k1rWUoKQoWAWHXSPACQnKYrzVDHy5rB/r6+mWJEHlyNy4AlnSL0N6xUcwv91TkxAYcLTN9GJ8W
 KeBBWPFBVwxwN89gqeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260038
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
> mdp5_kms_init() returns straight away when one of its later steps fails,
> leaving behind the kms, the runtime PM reference taken around the address
> space setup and the address space itself, and lets the ->destroy()
> callback, which the caller runs afterwards, clean up. When mdp5_init()
> fails, however, it has already run mdp5_destroy() itself, and ->destroy()
> runs it a second time: the global state object is finalised twice.
> 
> Undo the steps which have completed, in the reverse order, drop the
> runtime PM reference on the error path as well, and tell the caller not
> to run ->destroy() after a failed init. Fold the hardware setup, which
> can't fail, into mdp5_kms_init().
> 
> Fixes: 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic object")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
