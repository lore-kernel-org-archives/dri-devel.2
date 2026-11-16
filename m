Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA1606A330
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g/kJjfDe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EWPf4BfE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F8510E73C;
	Mon, 16 Nov 2026 10:23:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CF810E73C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:22:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGA4IMu1227984
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=; b=g/kJjfDeQWvOqeQA
 QDBJoKbsX/HjzL2fA2ke7wlJ8QXcVy47tfVjC+zxDA8mqPSWo4h84bh+0ymht1xT
 nDJZiML1lsQFMvoGdmds09kxUNDqL3MJxNbyZlqoq//Qfm55BBhdc3MskIfVbhhf
 VIOUAmDv6gx00nU8MVMXW+9MfMhieDlmjadt6CeaWFvMN4d8o187BTjibUzI/YR7
 9LxHWbTjZqz3tYb0Amrn9PMf7ylzAdGME5Hy8D0gUNez83hjvneMvX97nOv0c38J
 qy1qkUII6ZO7I9UGbXtc0CmCuEWmBccv3Qs6fFq6xctORyAr7PclXxb1twri61dV
 0q+f1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqg28e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:22:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b08364cdc7so2529065a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 02:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794824576; x=1795429376;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=;
 b=EWPf4BfE6bAbouwEyp9P3ICnyWYzATLBeN1L/TjQYcAVBuO76QT+T7V81GIW558ebH
 g5B/d0PlCA6sliuQz2xNUIu3AxShOTOV1/67UxpMCWqUEqB931K3Fvg6jtaVGXxbh0Np
 SkslsrUpTEXwqGuWTawnRinEO0AjN2F63qUxD0n2Rq7SFK9e7KU6odjvXq429ipIYXRf
 6KkJxKRVWb3xgvrKPtCmUGxwMGFxr8p+GJYod7eGG0tVe0/oLNG+rIFJ+17bKftDfmPz
 0AKZkydB+pflKbrhdrL40y1xpKON3HFdBd5rtkjs9cMTL2OGSQ27WncxlOXC8/eZDRjj
 xOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794824576; x=1795429376;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mY/m8G6R6uAHiT5Kg97RYzOdiA/Zxk6otIa5uzGPv1E=;
 b=mZaepyFJ8sFIbT24uEiHwLYhbTtEIU4uAB7q7LrY45prM7VzD0RNOKLEDJI397FRPz
 PPSrXPpwvoXmJC71qx24bqVEGj/pGdSxq8NV5F+EKUgRvqT7DPiMqveqJ9QVUHg8G2ly
 pl2IwL2HbfFVMe9840fqC0URQrwX1OXNjkDWGWs7vZkCBfgmUegXOFWuxcDR0dFyd9pp
 pFoIH3xO99fC35qR6ndFByUwuNmLd8AbPc18mphY+80vIRr3UYpHuIqJbHW2V4MzaU6y
 RBCXycf9QMPDG6H+6fseO3MsjPeysGyIjGMjfHWYBhauZuppwVDkR9q8NJHWH8rBOL4d
 W4CA==
X-Forwarded-Encrypted: i=1;
 AL+hErEi6lFrpL9zURJQ8MLiEwVN9dzr8+VML4FRQWlj9FnfaMW/47qbUMR6D9raUV34tcKhk38UD3dzjAw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8x3Qtr/wzDf3LSXVihhQImKvgVOSlVYkr3jU4GWPA+K1yQCIZi
 ZiIvdorDB7Hg38u4AQj7egATOSxBDP5BESTBTdpz34AfVe0HtsH2mLDEhrIhB3Jrq20uh++SjZB
 WkST2vmezYLHLHw5cdJuh7NOilrWPJQ4dDp+7GX0duESnqOWlwV8M99B1HyVtTv6YdBLxsP0=
X-Gm-Gg: AZFdTZcJMIZfECnQR3eXKyjkLDjzxZAhnohjZnebkRMcAhY2yuHy8gP8GZWT+BzwYov
 aLtQFMgG5As8OwXWXzDs6tj56wHGjNiB4M4eKBXhjLPqP1SijGlvXqhbgAOlvIUcKz8pp/du2vZ
 qgIDYtGcrz9tyjnOFWUaWUT6mt8k7GVuQ4Rs+JCJ3x5YywuS80n1nnkvaAnv1sAHezJjONcdd8d
 /o9Az6Vr81yKDsCcsml4qjuS0rsdjA7TcYzlHNnfAlgRu/R6qZulBWSGP+MjBHhNFbGEen3VEmu
 wPZ1kYva+uMGM7YSQmCx7Bp8QYARpL7CFtZE9evTkKae72AFqEKzsPxzxfnleuJ6B3z63T5T/Wv
 Fk8f3TOEd2yJUm0WtxMoXnBPOm7cLV747SRhmO8RqOe+v0nEueU5o7ya7961+ZoMviVNsaInZLM
 zWnDYbGQ==
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id
 98e67ed59e1d1-3b1b0ba890emr10201792a91.59.1794824575871; 
 Mon, 16 Nov 2026 02:22:55 -0800 (PST)
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id
 98e67ed59e1d1-3b1b0ba890emr10201753a91.59.1794824575285; 
 Mon, 16 Nov 2026 02:22:55 -0800 (PST)
Received: from [10.219.57.214] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f497sm21311203a91.8.2026.11.16.02.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 02:22:54 -0800 (PST)
Message-ID: <9472b028-d2f4-4007-a824-048dd1146099@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 15:52:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
 <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <6648f693-ca76-4edd-99ff-9fd60e71fd15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afad980 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Xv27ygMx39hFiU9I0NgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: rNiSG-PixS1VcC9iHZLz1MvY0lRYy0Ew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfX23El6hcK6GH1
 5cZHHJY89iqCIzCu1M7iVlRyI/2SSH6M6k2fKZb5ihAVpDh3nzuBcobnOlgmZuHQAI15EwmlCqt
 HsqrXp/RXsHNcrk2rE+owNMR5fmum8Lz+iBuXsjNLrHul481j0fiTh4z9u7ZY6o2yFVmgOE9Y8Y
 UeSIvdZV8AMmItOJqTbZMhAudwGFFqv+NPx6BaC/GlrZGwXXAu4sIFphgnfymZ1x2oYF1QDNVgj
 7qLSMY0G4N+1wCPFdKI1hSmNCk62vEGcGBIjZiq0LU90e5lgXrjo++Krin4l9mAMSILzAFairQu
 YfkTCvkmmeBOqFDVO5xiJoMvV+ytj/xsytZ8gcmhuHa4iLqemtHtqExOdw3UjtLyZ7KKub4ORsx
 3fHxp93sv98zUclrxXm17e7LhbECnExu0L6yuEcVv1NHC1PPS145CQsWdHBMx1VoLr7wmkO42Gm
 M5a9MBdLpHKazZQq6GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MSBTYWx0ZWRfX1X3m6OTb5yV3
 Jdlfxpt34/Kj9cahg9zz2w4rbfeuQU3vRgtIoR86F2Nwt4RpixXR5QMiaIPAExjtT+q8zghwkZ9
 T4qsbmB0sDV4/SjYkNPcFWQHMu2SmvE=
X-Proofpoint-GUID: rNiSG-PixS1VcC9iHZLz1MvY0lRYy0Ew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160041
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/2026 3:50 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/22/26 10:08 AM, Vinayak Katoch wrote:
>> ---
>> base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
>> change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6
>> prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v6
>> prerequisite-patch-id: c8b4a3873f9cf0d69beff0f608933ae83faa4c47
>> prerequisite-patch-id: 05d9299adf4184e0e56d97dc063ab5bf227cc5a5
>> prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024
> This series is fixes and why is depending on enhacement patches? It
> makes it very hard to pull fixes when you add dependencies to new
> features or enhancement, Fixes should be independent and cleanly apply
> on linux0-next
> 
> --srini

Sure, will drop the dependencies in next version.
