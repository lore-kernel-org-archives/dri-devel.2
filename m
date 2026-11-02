Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C9606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YSJI50GD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ge8hPhwO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C98510ED02;
	Mon,  2 Nov 2026 11:07:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE99610E616
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:07:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AMdZ1821203
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 us+y4KpJBze+sBMisIIItx/0Q9rWzDs7/LBvnzrOOkg=; b=YSJI50GD0pv74wxx
 f3/5v2zO5MQ7f+HswW7GkMNtUAIAS52RHsRHKgHOK7SddPmYtKZRYA7+iBjkCL2U
 QIds5uoQwO0TOUn881hDy/+sp0EnCGWHqkTo/NAi5v0AMGpfUQcUdFtDB2B7G1D8
 2oyeFFT5OFExLZIoN3YVgeanM6vmkHkgXe5dnw1spnaCmpG2rRMO8A4d1acazYt0
 Nm1/UxRaOsM/fK6JA/QJUDtTFjUEpT84WpaOqAScgwqRwfAkYE5Qvl/D/xfGYE6F
 cOPzWSBch+fpF7NRs9Ewqtryj1q/jEDMD/QyzmS1bWUAJVuI4PfK9OY7jboP0eNr
 uUzKcQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hc2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:07:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e629c7b16so49710085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793617628; x=1794222428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=us+y4KpJBze+sBMisIIItx/0Q9rWzDs7/LBvnzrOOkg=;
 b=Ge8hPhwO3xZD1DxKmC6ySkj47OyvF46Pib8abFc7gQJ2eql95t4aRFhy0razk44uK4
 sNVVsOfVl0Il10Frs04jLfVU3iMXbBqtYV2bRIaBnghUz4Pul2HojYw9Y3Xt7sVngYxa
 fzojz82qLFjc2XKdgDv6QDgXLs0Q33Y/I8+Xfw5LmJ2VEJSNqNGecOgJ2elLPFZv2GN2
 vKJwSAhOoggQBZXQ5DSDBomnEX+j76TPBk8MrAOaWc4nieaOerdOkt/rvsZkL5//4JsP
 8aQqxAmzGEdFgM1Rv2QYd2P8bNSsJsy6ijMx1tTmD4bOeEsVVGln3ZhLj2fxFSAI/gen
 FYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793617628; x=1794222428;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=us+y4KpJBze+sBMisIIItx/0Q9rWzDs7/LBvnzrOOkg=;
 b=stvNk6yd9znC18jt3m4EPwLQZ5OPCJcJfXL9YHJVXHcJXI7EHqOpSSUSW6iogDe3ea
 SOiVhk6Z3nB4NQMyMidsN0HUNwh3FChfwOUOSh33c3UK1MqaapJsTHSG4XRkNlM94QGF
 3JrgIxT4JAFKT4ffPSKmdDSvGnHt2z9k8L3Mo+iaIvHUOOJ6uoEOQl8IGlp1xNzsnEPQ
 v/1kEvCTYG5tjG4ZrOpRV6SAidSaDOBe4nyUegrxYMPrRx1PNwNORUcRC/47YqYGdXjX
 JKGNuSoDPuXjM5QC4t0ssNOWVG7AHqoghDQGGGJlbC3gwAT13b1p8oVqN75a3RXmbKYf
 UrxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx8ecJe5/dDRPAhQ6qu4mQPkLgmQniAgVBHGpDaB1fn17ZrkyvxGJjcjLGlwSQ0ifOGxvgQGH9ZCI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLzZ2VVWKK0BUeBjGhgArBIVdWBGt88nbDSW2iRgoOvYMknCACt
 rKnDq9fTPaTOZbQZjsODOe+fUzo1cFe72MT4NjrjysZ+iB2x84mRlYairfjS548qUN+vAC+Qd5o
 GXQarnEdm7TW/BjFN8v2s+5Kje7vrRqwt+6/kpYiKmLuO9CM+w/X4xxPR1M/PgpGaZPBataY=
X-Gm-Gg: AYBFou3bZjkbg5u1e+nEHUdL3GFjlQii2+5ukgnTzQbt2+d9yXaFqWdsqF6OwqpcyUg
 KSyPa+nRkaAlOciYHYlMvBb2lRc85ip19RXdQUZ1L3ZVoDI3oH9I2DHTu/BmjYHHazxC+8tAImt
 UwF53ovWNmjJqL2dRZtYYNvB6C3pbvdk6oEcM6KA7s9FuUix6zYtWjgiW/HEp6dV1bzHsMqxiDd
 8Ss/+A0/2dVBvxSv9FtvUrUuoiRC8MS5W9MY4t3ZjhZ4mm+6lwzMv6HXhoWEJAc8+EFD/PkrH4C
 JQL36hD+YQhQ/LlQLeO9PWSgOMLxsIateVdEQzp1zNKdJOam1iUjrA8uBTaWYCbNsX7Kb+uv1ZQ
 twgCKEvcfdbn55BE9fGfGAZlu1v3dRGstnpDRn1Gyhe3/3IXTjNM5tXf8CqojSvN6vuj7Pwc=
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr1537820885a.5.1793617628073; 
 Mon, 02 Nov 2026 03:07:08 -0800 (PST)
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr1537815585a.5.1793617627632; 
 Mon, 02 Nov 2026 03:07:07 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabecd226sm373928566b.74.2026.11.02.03.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:07:06 -0800 (PST)
Message-ID: <fc32b535-e06d-42b1-8806-3f3a2a9843e0@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:07:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] drm/msm: Add cleanup help for disabling IFPC
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
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-11-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030211928.45761-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1zRM-Aln5JOQmzI-Bwi_gjsd-t50V7WJ
X-Proofpoint-GUID: 1zRM-Aln5JOQmzI-Bwi_gjsd-t50V7WJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfX+ydgaXdOes1h
 HVKWptgXKoaAy1XnLjfW0Ohfk1N6bhounRXH4TynQmztDrQf+Mn6epovIm8QPV/ylrdrsBUT0uW
 FpIy28zrOTlrEJdd095TF8o671/E8is=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae86edd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cWb5AwZ_sP_0w0E8whcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfX6Xxc24FtXwGw
 lkyi43ZHoLbrOWDhw83Hbheys1rxXzY3TlFygU8cWHXG9IVHPtAb+TpIci8MRVyWS1tPGyVWnxy
 3Tqtstv5dy8dqU89PmYiK9yZFMj/FpjX+JK4CahWroxE5bbZm6YDIyW4epRVBBG+duxQWAUAy5V
 FbsAyGG0lk+fRED3dDnXAAAiUzY3MfLARSvpG7o7IJPmPiAxRn3QyDuYp9o9X3avZ20GwzGHuxY
 oZ8HZ/K4OrU5lcqpIYi0fNAXgBTDlpTiFCOZQwpybGlc5kjtUKxDBf1NLE/WdYzSO68pK/KD97H
 DeP2EJS/aj6hUjlYZMBMHMSSspCVcMQ4nDwJfLC78nAeRPdfUs3x1qKIHo0J3K+k2qqQRg84I2v
 Z2YTmrXxpQX5rttkD6BKTAbHejERCQixkEGuvVzKEjxUgAKU/4q9bG6aoQhTNJRdNovgSS4rfho
 lg0S4Fq4KeT0AMQwBJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020044
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

On 10/30/26 10:18 PM, Rob Clark wrote:
> Simplify error path cleanup for IFPC-disable critical sections.
> 
> Note that this moves where we re-enable IFPC until after the
> wake_up_all(), but that is harmless.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
