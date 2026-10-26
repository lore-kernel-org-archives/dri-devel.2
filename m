Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA85606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ItEGc5uu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dw5ERqUL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC2F10EE98;
	Mon, 26 Oct 2026 12:02:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D35310EE98
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:02:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAswHm4131502
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=; b=ItEGc5uuZEPb/KGb
 EhHnE2Ni0IRkipvHjLuYd7Vrs9LtGXnJrR9MqECWpw6mjRrLbsGnFVwTJyque5Vf
 g1wCRxRhQhN3/Mgy/qJ2ozw73hvf30vdn3Zgz1zsRPKMnP3A+gfrKBRxjr/sFrs1
 1JR8zxvQOi123lmZdwm7kuNZu5I864qfTK58c+m3ShwcsH+QQpQ4DUcIJuuQUnwM
 sEdh7zoTvXgntul9ja69eZVwMSrOFqrElCp87JeKYctt8TgOXSxWVaDEX5Lax/uH
 cY6J5FIbc0qRTQuxVoq6D+CdSCfCl8+3GswbcrthaA25f/A57Rsbk5z4rjeZoPe3
 hG4+fw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q0am0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:01:59 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-988b530df14so84648241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793016118; x=1793620918;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=;
 b=dw5ERqULA783xpk+eADRZwcP6b1dbIt2uYpH4YSIgSattshfVMk5N4Wb5UFHW3Y1+u
 u7zaAHBRLRwX2sPurJnsFklrxN+IieJ9emaikNwyezrRM76CLhSsqM2NtYCyz+Hy/NXm
 KlPq/2ZQmI+SBfslEb6kQZzff5itKZsFd8CB9/QHTb0DoaTfT5sNWtUSzZtXI9C49WMj
 AcVr6HUOM58p5CwuGJM8OQxqxjkiOaaLr34E+2VAdYQ5GJPJfm40PLCPL7XR0WVt0YD/
 BuyrWESUozbijkwFN6S2qnNpM9TIU1NCqqouDFryLOgWjOVvNjvi6uATK0VGPkqQ2L4U
 GGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016118; x=1793620918;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=;
 b=nIvLlezEVYAJPR5MbDPx/F0Ggl8owG1DePD+w54HfcO6Am1clRexVUGaCiWGIHksBn
 xhn+nq0QnEtuWA30NsksPoS9DNeqXEMYRpwaL8f5bJ7JoZg3OUJuQjtzFTr4u1Lwvr69
 PMKtrDEsAo83OBWnmgzBhQ5oh59Ozzz451QtBOhalo29JTD3TA0LLbARwkP7nlirz2rT
 a9EZxIlB9FV0G2bN9FH50kjUAdM9LcgSZbrQCc2NS/ShF/PXkS+O5jJJywud9DTCfsG9
 mqQXW8Mrn3imWZ/dRIW4XONFdOe5RczSOYTDeuty/I8p7TvBVvaY6sAeK7y1p4QqRYPf
 qOfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrCoPj0NNJ8URyb6h45/d8U3rbsJwUuqyXNX6mLGQthixNVtwVWPsNb0ztaZQd1JQBWHPCXW8vGsM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLg9kEdbP2m7kV+tH1tTRpmY3QUgWSFNyrc7J+izupQv3rktGB
 R4sed6p50BrnwR4hCp/w2Gs9bH1qe5zDhYU7SB2DiVCMWdvmeFmx0m6FmdMxsVfLLPbyqsiHc4/
 NHSsx8tEI+/OLWOiMLW755bKsZPeMKKS6696QmqrdKEFkIoQltA3bdHigJ5+7eRzuKjmXGTc=
X-Gm-Gg: AYBFou0uPQOXVuqgT6RZAJ/fi1Nd4F49NJ9JLKtdlZtw532PaGGQkzsGd+6iPYYew24
 zLH9Z3ttxy1G+NPBoIXx7KKj9w8MqBoq5Me3689+SsgVh7My8qw4OZF0+JdU+naK9s8grnkAfF+
 PTe5lTYudSFoeS0gejMYFDrf9ma3Jz83fEuZFMFaLgI6xy0v0tlLBT/Ft82jP/E6mB1emXzqMN0
 gIm29woA9CBidaMRktPXqw/0juMVlyVXbmIX70MYoDPPZEZmLXG1x88A3+wcoGp2N+gqvIq/6aB
 p8zZIllkwv3cRIYEutow8+Udon4I2k1xnY3pLou/CMfsX2bhEulvM66r/ecHoMGY+Vs6vEwknpX
 ScM3HBKb0S8v+GEtL6YXfJQ==
X-Received: by 2002:a05:6122:e012:20b0:5ce:23fe:84d8 with SMTP id
 71dfb90a1353d-5ec22ecf6e9mr1504277e0c.0.1793016112026; 
 Mon, 26 Oct 2026 05:01:52 -0700 (PDT)
X-Received: by 2002:a05:6122:e012:20b0:5ce:23fe:84d8 with SMTP id
 71dfb90a1353d-5ec22ecf6e9mr1503020e0c.0.1793016106287; 
 Mon, 26 Oct 2026 05:01:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46c59c063csm265518866b.34.2026.10.26.05.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:01:44 -0700 (PDT)
Message-ID: <9845762f-c667-427f-a848-ee1cb1291779@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:01:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX82iCrqJKlIh4
 ZDipWCxHfD+V/KHNy2/8PD60GimnJF+TwPdbrj41Xvyibb/09668EXEleBqOf/N815i5IzLN4x+
 mf3/moTGUjMKv0KItS2nglHb+pEM0KQ=
X-Proofpoint-ORIG-GUID: 5COQZdyqGvIa-t9VL0Xyf4lgbzv20MJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX8CkkH2wyuiOF
 KFYSXwz68XuGPRp/6JHU54ItsUYydEDsRVqp7Ghj3yYuzwFQo02y/Qs7RzaHjFvprIJwGnXAk7T
 QLo/XPiS/vmht1GXl/uIqSjMspJ6WdEkQcmM6vnyW9FUifSPqcH0/yxrPxJc8Ulb0LRkzPkY5Hp
 621QEJ97IN0oxjoLkYIW9G88IOHaGrXwSZOTWNxBiRbQZd0gscXU1c5EKWtuaNHIn9HDyGv3u4z
 ZO+hYTTJSK4uHgyqzAWpQ5/bPJBVaT4gZ+BwsLRESUy3ovpWWqaqx+xQg0gbIjAHkWnzNUaNI5S
 Om/lQzClRZclUujYXtuirS0YV/L5nYp1zEt3KZQN/QI3wvzwkA7M8np5YXOOHnAUwk6pa/xv4Sa
 HrMv2ep7655Mz0NQdvkBrz3HqElkUrEjOOxoz0tfVuUoBeZs/zhtSZUNnsKpa5PvqOYql62B74p
 WOG16Ix3pJxCdUEu8yg==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf4137 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=khcIRSTurGpjo1Y0ADwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 5COQZdyqGvIa-t9VL0Xyf4lgbzv20MJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047
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

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Lemans device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

The documentation doesn't concur this for this platform

Konrad
