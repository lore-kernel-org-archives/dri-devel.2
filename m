Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F650606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UOt3gzwq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdJ3QeqD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8995A10E01F;
	Mon, 26 Oct 2026 09:52:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17D110E01F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:52:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aPkr2222520
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=; b=UOt3gzwqp5/X1jCI
 Io2LU+WTnhExq2YTUf2cjNzlQFHgtPXtw0/sJHWKWz6RnPrQ0I+xV1yoNqveIqMg
 eqmdoSjdoYV77ppTP0pCOOzNqaRrBhW9eiMjEquyUMO0tZ3mq66gl9lPYAO8mvN8
 XOmrHt9Hnr4Dwm3in1T9WD7G2Ep8yJ+eGBVMYr2Qyy/d5q99uMHywf+LRApJahI2
 W855lwZAxdOFCO+H4g4nhmU6KfKzo472WhR1v6NkYOcu0HERoAcrpAs3fphfXsIG
 CiCxxagEL+r9h4H8f6mSMDxlOE3xXbXjPxgxzAr6aM9IjCAE8KLG9AFHS8D4AOyK
 THpY4g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9j0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:52:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53635fe2335so2912421cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008341; x=1793613141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=;
 b=SdJ3QeqDnVhX3VI/jiRGmPSRaAfZ/roOesOl3eIxb1MhcE6P15MIxoP1nNLFUS2NV1
 6D1YnhBkNbVS8OHY2wmE3mJnhYL6HLjIb5KInnKV5by1XF1lXFxdfaYMMalMJue4+Dwl
 1zqIv3HXZG3fpZfqt0RaNPOrMTciHH9vl4O57Ax+iUB9ryz5dhGHs01Qm/nowQJuAIx2
 TPeDOQz11xd6IYk/wNExU8W31X+CjiJsEAzgxlgEGa9QRV5zPYS/CfbFCMOAN9dYThSE
 lCQrAfjnJwXNFIkpomyQN33jxiAQUJYVk/CGMALXP3171owv4rxIuEfiZguehrE7JBRo
 YOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008341; x=1793613141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=;
 b=1WpxSRT011+l8oRcv0C4LLYjPG83jyLJhntZht3XWcvTriIjFVXu1mof5Xs/2fxMvE
 PPM2aUTZAD00pUxWC/2jGV0Z3/eNn6Q31Lz5LouJloUcANEtzm4A0T+dNQcrpTul/YL1
 CZT/WD5ry+ZwdocQSbyC3GCC9Zk3HQu/i4rotxZmnAXyY3qtJFXGQt9/9Pyjwr+LO8Ok
 PfduXJk2LV9bM0BPvtmocXZJ+6IZglIOhBomd/Qc/aXdllsTBi0fRv8JN0w9XDSuNcFD
 wXmeVDLMW14PnWeibfkJU0iUAhCZLzGTKDPoQHsU9kwDTiTxgAi/NnZFWbOVXgvnCxm2
 7ToA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwclN5gPVAaWo6OYL7RASoF+CrEOHWy/EcEw8cOscEWz8TX3yP3WFtXakjzrWurCNkNzX/LYSxvQXw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJc1WzsrGGQuoszeM32ZgZoY7osmMqw/WGztCDILZCad2lBDe9X
 /pVaSf1FLT5j+qY1ZkRZS/sYBRKjFL7DamnVk1gd7oP8X7wrxO74/ro7MihyE0U8inAdZTmcrAG
 /Pg5nIwhTZWAeOsUhD3fc+6CofsK1BgJUUy+Qc3etE/SuqRDOgpy1MWgOlK71lApoVo8duSU=
X-Gm-Gg: AYBFou3fBNQKFfoEqHVuWrDiCK1PvBjfrIMWEsJfUIeA81g8t9XUDElp+dINs//92Ai
 mkOzCPa2agkrfy7kyvdCK8IF3OH6yi8yhnXXs87Pl48uK25b9lNdvpwk6ISPHR6DpZ95FsYXvzH
 iUqJAukQc7HZMYQJtqJLGE/5Sl0Dqx41BUTwY+zZUDvql8taXCy3NIpr468gmoiLk8IV9Y+0j+6
 z7zURG4MHOkWAn2XbqRtmuIg1d0o4QvjTzoe87JhOhy5s9aHlwsGXhkFuxsDWahlZpQj5GBn8dN
 LnIilUUGCCYodmbdTPG/zf9OnNYScj+nxAinDbPiXHv3l2aLvLMycaZpsiYFWLiw0Xnr5iEB+eC
 vy/MH56MXRAH4bFNN/wO9ZQ==
X-Received: by 2002:a05:622a:6804:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-5383b504b5cmr93393471cf.3.1793008341266; 
 Mon, 26 Oct 2026 02:52:21 -0700 (PDT)
X-Received: by 2002:a05:622a:6804:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-5383b504b5cmr93393211cf.3.1793008340839; 
 Mon, 26 Oct 2026 02:52:20 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7984e9sm296717366b.74.2026.10.26.02.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:52:20 -0700 (PDT)
Message-ID: <5d732b4e-4558-41d3-8c89-a2218c93d108@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:52:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Fix stale boot up BW vote
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-3-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-3-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JaBc7YdUCEsaRBF-zioPaV_nN9Ow0FZU
X-Proofpoint-GUID: JaBc7YdUCEsaRBF-zioPaV_nN9Ow0FZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXxEL6LRRsviUm
 h/fANVysyB5maRoukotaNHkBP83XiSPrk7qGZrh6hGJXOR1pld6dafcS8VVisdsADMZ1l7ZwSwk
 +FvDLh70nn2O26WAJk8zqdyKDBuU8b637EXFUo6G/IpE5Uz4xSekwdpgvAHopSgDqK2ertNBi/4
 Gw3KMk9p48kkSNN/zGkeIGiovUy+XO2HJ3aunccI2BlWw94PbLzHQqM6RJeFeNuLAJwX7Ac+PvN
 6RaYtr+56espyN7kQoFXVLddaSbBWqNllNbuwDw4QHGqVdT0oeI/vuLYn/L2t+ci4fMXwiVglSl
 YHYptPyzK7AGETnhuag4QueODso4OHISpJ92ID+F5epO6Sz8ZkUPCsqxu8LqnYWDnwdWLdelPZF
 dkPM8kCRvIQvpAJM2yKwmXRA8+I0QpTU1r/wX2OtcXwYiD1LHsXevGF8xiFI8cmeTXPH+s7em5F
 Jz4b5Kxp4rseOdnDaHA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf22d5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1Jnm8Am4PKJ2EhgLYOkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX6kDo1O0VWv2H
 zzacyC/hyztFNCR/r7OuBdWtti/KHWr97Rke3WrzbF6/mzfKDg6IqW+/ROPgFeuw6mvv/I2D4S1
 NQJXkv0Xg+kdjghrwE3gfGuPwEq6Yxg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> An initial bus bandwidth is voted during boot to bring up the GMU. In GPUs
> where the GMU drives bandwidth scaling, this boot-time BW vote is
> redundant and can be removed.
> 
> Fixes: 7047e655a567 ("drm/msm: adreno: find bandwidth index of OPP and set it along freq index")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
