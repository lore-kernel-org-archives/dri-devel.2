Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A35606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecqGBCl7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3NAZtfU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BAD10E91A;
	Mon, 26 Oct 2026 05:31:51 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53D610E91A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b9wb718212
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=; b=ecqGBCl7iDU9pDko
 eAYWdC2ecPWqVsHyt+6amofgkQW9fS4tZz/1Py6ef05r8metQAO5TvfgmR4qUHcJ
 2Bajust7IfA6Kd8TEfUAMIHtmWurqvWK+gFvMRvYktMA8Wd62DGXugX1ex+DUqwy
 L1+cxYsqmuMBgiwRkaSoB5XhGil90xwgua7E3aXKR9NzLLkQpDVru4eI+VKPw7HV
 /Syg8httgcppGTUoYh+RS4ssoLRDiEfoUtkvm+iWwGmsVNnbIACilNx9E2hykk4w
 snN4upute0OS3g3BvP9lPyqfJDkrwID8OKXbjyso1VjMnU7397nJndoi2HMrDfNt
 zsFIwQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsry43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:31:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a065e2933fso3870582b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992698; x=1793597498;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=;
 b=E3NAZtfUfs2PWVr+jeVfKDfJO/WyHB8p1uE9ioO5WGeFbhhlvXGWIBmX1ZP6u7K2cN
 3XaEX7XJFW1CEkOtAcXOdXPgxdpWMogtguOKxBPgrE8GhlkBev6R2UCzjXqxst9jbBy4
 Bp2Q1IyH0twoy8hNKlHhxAiel+gMi5w4yLlQQ3UgYgTY+TVBwISvluzkVVadr58PdWcd
 BnuY+nnggDt5B+Yp4gaX1iygs5kYEzfy2RIK7MFrnqF/xMS647xPxD6X1x3w1WlzEsOw
 30yWGPkhgK/N8tt+lyz+uzyECbwLMSxOmCoeZOtUdpCp4wWiqn/MEeb6lx96YkS8yuVE
 Vd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992698; x=1793597498;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=;
 b=pr+RM1peSHKoFdZkFrgtjR+RpZW8BNeE4dBPGG+2aEf9OClrUZ/68gaCXjX/GM2hPN
 MxRhIYI23Qv7809b39ceXa1CET3J7jroAoY5Go8b5QtOTd/COVLOs6pvKKsHZhe4BUFP
 M7kcewoOeQOYhZO1QM3fz8+try70Lr4YAsNAiUea0XJJ3PWrTdOMIG1UDgiW0aVP5mTx
 ZkqXoT9HCRy+tT4s6Gnweo1dNS0B2EUUDDR8s773qpu6GiedhkJ7yiDpw9kcrbMBZSnl
 l5tniVNJP0YuU96b3Ve0BkrMR0fwx4aNe6FihipIRYdfdXajQ9EfA2L9diZ7PABx7Q0p
 3+OA==
X-Forwarded-Encrypted: i=1;
 AKwUvBznYUgtFvpy/9blIhYYIMFJWuGxfYwrHNcOwzt/rE11+mPG+LElFPrbJL7gMIEAXIfA4dSeSAAU0as=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtMDmmQLbWGtmJTBca38Sku3/d/Ka4CuSS3Urqe+gH1db9uVKn
 8qnDt/7hx8JowWUFFroR49gr4zLgnbe1HGBVIl/RGzdkZ+MTPyu+PZX8GYJ2bWTNlqd9B2v08rN
 GdQrxhyfhQkFciLGHl+Wn0TCdXokKwbRw1+XodK2j3QLsoGLJdqfsuWuyYZoAS2ZVHJo5xPw=
X-Gm-Gg: AYBFou3A5WTLXWYiwDIr7LurTLdVUjNtCnVXvmmC8SOIcTEbAbcd39+opw3KlzkJGbL
 ryLA1DNpIsE0tv8bFMFmBZaMXCfcxg1TWtSIgG/MHUELydrcGT8/UixOh9uffDhoIAkNdYyN+rQ
 LvOmfh7ye2cbf1+J7puEdC5xt0kkRRmd7wHJnNukeHCbpS6lrRzatOtOHPbMnCxtRrgggzJds2M
 b8ft588O8ymn2XnSxmagQ8xr/9yld1QpNV6qvyrhZxer9Gwu7WW476TBApjigOTJlZKqTnp13n1
 Hbpgvi1wv6WJa2q0NJA+0JNZAVw73RSrCYmc6dh+Alxk8craww/jBBX+/wfix9s2PO6s/Q1Rrk5
 mJuRMZ6i+qyq6GxV9xPKgQ/D2HaVU
X-Received: by 2002:a05:6a00:a0a:b0:89e:d76c:327f with SMTP id
 d2e1a72fcca58-8a367a2d5c5mr4469597b3a.34.1792992698485; 
 Sun, 25 Oct 2026 22:31:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0a:b0:89e:d76c:327f with SMTP id
 d2e1a72fcca58-8a367a2d5c5mr4469573b3a.34.1792992698112; 
 Sun, 25 Oct 2026 22:31:38 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36acada58sm901954b3a.11.2026.10.25.22.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:31:37 -0700 (PDT)
Message-ID: <9dac352b-6f8e-4616-a0c9-50eefbc4c0d4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:33 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX5n1oe4m8J9gd
 EKl1fk+7QynGU033bDXzg9DGpwLZ+XqQjR/DoJMZLx35uBFE2nxMpRWroxbK1MD/SBDWtSZax5I
 BP1pkLEtBNmNZoiV93OIDlfdLHgc4XY=
X-Proofpoint-GUID: 7nRwgRfPxC-Pw2V2C0EWLnOe-aG9R1gW
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adee5bb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lp2TWI-43rxGvoCc0Z8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 7nRwgRfPxC-Pw2V2C0EWLnOe-aG9R1gW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXyQGG6Pf6jMGG
 yyOY1CPC/JZA7jZ/L1yF2l9JksxuZPGPHT6VZEXNreafe92wdYzddMWRQH351NDMFiZfyouBuw+
 AvclZPvkD+d87ZYQIl63apv6R2vK+ycZYGBOIV9qoVK7wIKT809vIUe8euP/wSbGsyu0Pbe5AXm
 WE8hzPgxbpa650L0+3R4/z3RiM94o2DMpjilucnnwVIhPSG97SQr5vmG+AWR470iS6byfFzxi04
 mwyoZ+NHb0eOpJnmBzznnhzdCLL3e5WUBnjH/f+2qXASpzf7oRuSsqkiIT7czB4b28kljdBeFFL
 1bk8qXItXjhNn8+3orzuXFvKz1O4OlHaIqezk8P7roIAIwnCvO54mZJi6GfAKfoBY5pgnt6qf33
 ygriWYAmSrk58+dkGxQze9fS3enPX+R5n0jz5LVoPbsZK5htfKsCGY3hEGJkVjz9dUjAEXVntvw
 V3T0C7jC4NJDlgI2X7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021
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

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sc8280xp device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
