Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB6606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=No443RHT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xaxqr3Qx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9938A10E131;
	Fri, 30 Oct 2026 13:46:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2938310E131
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:46:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGLQk3130305
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0NcigoaWZbBvhzKKergF0yshnBcIAC0oeCoWwdEcoSY=; b=No443RHTXo5OlYX2
 d3LQA14O4Fe89DgHq8bilq01x1XqJcERXdk0Nhe07kpLU7nP+fEshnHDYMVt0h8/
 O6SR2pLzQQuKlrljpQeKazew2uA7SXbYASvEQhu3z5c+oPpaOnfB8k3GpaXLQqWP
 8t/CzVYSzcCxeqWQfVnrccktgmrwxppycvtt/2D0lGoq7AOhxEo8WrWQ2S3hudUC
 8TASEPMUAXmD2NdPwfnxMRZXKMWl9aikMuoZKOkCFTpZ9pR7nJjek2cynFvvpDL5
 uFVyiqhcbtXk3Gry1IQg8+Dsyzdbn+pLWzeJlGp1iwtBsGJoRN0GmCCZYRC/tQ3V
 i7LUmg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk8my-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:46:46 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9909853d264so24358241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793368006; x=1793972806;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0NcigoaWZbBvhzKKergF0yshnBcIAC0oeCoWwdEcoSY=;
 b=Xaxqr3QxrJ9VF5Q+HDKOph2M35RbB4EETCld1JniBG+jePpdeJuTzagbQezPfZGiMC
 UHnQ4+HZ9iHc9aS8jYJaFVnVQRI9J+NZIAmCXZvT+y8+/Qguv/ggqeo00H/wIE/IjkDl
 MXCCZ0Yqi7X9Q28xNCm4XIh1/3aSjQujYe9tY/29EdfGf5vWxHGineFPgx2xMzSBP/KP
 LXIwfeIESdK1SV/H1SMIZhf8kziHKkyEUlp8gI0RPavjGkDMDJt6O5vNtZH0w3wH+qnd
 AkpfNHfX8wQOKu599znHxQfM+DGcEVpCyJ/ELqaf3/25HHrEYf9eUlsvEKNkx7TceePY
 qEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793368006; x=1793972806;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0NcigoaWZbBvhzKKergF0yshnBcIAC0oeCoWwdEcoSY=;
 b=DkBUIIzUC4CC7te8hYJbybLv+E/x9Fbcs0/r3XI32Bi2Phmr475mpPiGnNB++fKhsg
 rLBSiApVUdDrHED4eSTAlWySZhwMlIRLRefKf2dhL2ccAEWPsn/F1oeFas+GZ0YRqFat
 zBVltNsFCZGgjigqSC96I2BljzFZCKao7bxMNoOdWcX7JF+GxQPOY/R6+gXeZ23mc17O
 m4LWlKLO6g5gDsjuM/v2IBS2rsArmjmWk6HGe/PjaDOmVvPL3dNaYQnnfwdfYCpK/DSR
 FXUL4nvc/nxnmUU/MSbKFpCcGtATGYUF+LAeE5j+hvnyc/rJdzqaqXy4dxOnlY83qO/4
 G5ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoU7/eMEg3cDkRd288iCYKgVdPrdFA1QyBgozvE42/yAKYF4XfAeT4TYlu+4dUTi8REPbfP08IS+U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLuFUxv8/B/ymtq110OW58E6q7ikMTM9uSvp6upGCme5s3sHUy0
 obNTFcTNbArrtap9PsVNs1vp1H2YqfDYEqqtFuzYEhzeCKmZYf3BwWcq6pLSdkkLt/f+PJJUp48
 vmDBs34h3Ah4vF95zdUB8JQRuNeUoA1QMB0iLH+nHjIfhR9Q6EWfdO2HK23P7VwWvWlO1IFk=
X-Gm-Gg: AYBFou0LDPDjNw97rxSjqDYvDl7p8IM8DBwulBbceHJoGhiuPF0/JdjvPiD3ycz6ET2
 uBOUqkHacrl+TCJzaccAII7yBXILguf14mlYisPf2LL9H7wCBaQyeuhz5XnUiRX9dsW7MKkqhWt
 bYQp7Q1/bEFu8n4GnclyiSexOKC7dDpsOX1FNxe5MXkWUoT8s3AjSSrXF6XMaKIQ0ICSlZHCOdB
 zAcmMwehHi+hc1wdlSuhjmMDRIaj157EZR58FaVYrh2LUfuTx/qjelf6km5Y6Yl031KvWwpy0AP
 LYOGQNbhQs9qWA5JWsyWxWEBBD1KhSHQ7RTWzqslz6Jon3Od1tRnF2pxIFbQsoe8G7MZe0iOtJD
 b8YFzF9GFOg8Aqxw38rViC/QdftO3GeE1aEZw5WibDHwAg/c3CkGZj936U/T1ZqUiPnDaKJQP
X-Received: by 2002:a05:6122:6310:b0:5ea:c984:5ad5 with SMTP id
 71dfb90a1353d-5ec6883359amr1068965e0c.3.1793368005503; 
 Fri, 30 Oct 2026 06:46:45 -0700 (PDT)
X-Received: by 2002:a05:6122:6310:b0:5ea:c984:5ad5 with SMTP id
 71dfb90a1353d-5ec6883359amr1068930e0c.3.1793368005039; 
 Fri, 30 Oct 2026 06:46:45 -0700 (PDT)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc174dbsm68328466b.3.2026.10.30.06.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:46:43 -0700 (PDT)
Message-ID: <b1bf792c-8571-417d-9c98-f0b330a3abf9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:46:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup
 reglist
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-14-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029201730.151754-14-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3NLtsxYj3w0M5mDAzGKq3Zt4XmQGnS6M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX6DEubYFUvpHh
 l72Ld15Bpq/cYnv3VBfsIcWAhYNGOau2kpfrRp1JY3DYPyR0dMmkc+6WTMFWgE+OjaPS7JrB6bT
 3rUf/TjuvHrQjEI77iTaNxhgSpqbgxg=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae49fc6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iG851RqCUpnUipWvLlEA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: 3NLtsxYj3w0M5mDAzGKq3Zt4XmQGnS6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX7jR9H5zKvtti
 97moxSq1TRtL5Z4VyNRMZvE5pF8yVtU07MfhtlFlMHDIIfMQwizSEbMBJ3CtNUbQhFYsErxuOi4
 ZmnvonmdvulKHrkRSJYKrM3r072FfSrIs03HS4ZNOSOlLzxgwkVSIgIlhq7U9pK7zjYr0EPlKE4
 8w4QHLvH4UxPnvCw9xvIGMkcFf0XPysUsErS+eKMrywtfPu7dW7BSalhkGDFOdE23MGuF0WqFMW
 J8m2ZsfNEQXWXbKrA8ucXrEpJTjHqXOxqyfkqAsNVweHbJCmm4FlRi7/9xu0G5aKs8nub4NkTlS
 +8oNeDTjk36X8UUGJ6sMD380LjnyQn0NLrkvEUvCg2F1/uC9KMxt9J2NgsiwYDHj6zFYZ3Me2Ve
 LNL6lo1Jn0/IlxyWZYs6JAcK5JmGPmo9P0RGzgm8ae7UvbCt3wWaN1CLa7fZj3zq4C6vx9UEkI1
 sVS3lmRULBxYL5ah7Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
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

On 10/29/26 9:16 PM, Rob Clark wrote:
> We're going to start using more of the CP_PROTECT_PIPE regs.  Rather
> than missing to restore one somewhere, just add them all to the pwrup
> reglist.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

I was kinda hoping we would iterate over them in the code instead
anyway for this one

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
