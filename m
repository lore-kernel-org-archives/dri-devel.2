Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782B606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwR+e+7p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Um2ZJR0/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B570910EC4E;
	Mon,  2 Nov 2026 09:24:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FCD10EC4E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:24:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AMun1821122
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 09:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Ud+27iM3GCSKJyViO9ZnK+ZXsfw9IiRfqvlCm4Yzp4=; b=QwR+e+7pNnqvm16o
 xEiVCtCF7c1/iJDndPTeiQi4VFPw/s6aibuTC7Vx9FO1PE9BxwiNf5nnCnTZvjsl
 pyIZOZ7iGinxTSqlNirbD+G+Vg08qlK8cD5yjy9vRa/w8dz5QRfroOpP7LqCokib
 8YhQ7mJ0wNeMCUCCtN98RnCUEC4k8h4vZ0EGp4uFnevCr7aZ4iOeu8Q5acrOmdEv
 8jUOtedsRYDHuL7+AsAVPMPtkqukPc7oW971eYTzHn2gxcyjvjjY3jGA7bwzX4Rp
 gdHluJtV+8mFEqru3oSaRe17fZ9bm9RZ3N0t+sCHL/EmLO0uUqJTBBs+qJNf0pVL
 zvMdZg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4gy6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:24:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5476f5bd009so1463401cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793611475; x=1794216275;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3Ud+27iM3GCSKJyViO9ZnK+ZXsfw9IiRfqvlCm4Yzp4=;
 b=Um2ZJR0/ETfNELyCCLbQKqn2i+gAFqukVIUB8ava7udiNMdny95UpDStC1yyfZUQsU
 qoX/pSmkVNh97AjaPIt7Rc3oPUvD2lRfUdVfU+Skh7ZWGEDK2MOBGveEMoE0HIO+KeDO
 kGR9xSgLifXEniM+ZpBD3V+ThEgufV+IEa5MFHLFTqGN+vk3Rug+jQLEqdUGKOUkPPLF
 rMajfjSfeWCzhAhM9AM88b6ZpwxevubwqUvLC0Y8eC2eE206yKlMk0+7cmpyk8yXKDHR
 KDoyj1+H3H4tSNqwmg9jnVDUkBPNX7293kBNHEd/ZHyZ+/IB7cTtSHa9VepE4WcjPJcI
 0C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611475; x=1794216275;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Ud+27iM3GCSKJyViO9ZnK+ZXsfw9IiRfqvlCm4Yzp4=;
 b=QG4GvX472w2wHUWUyCwisOGlKaZHgEs+Ulmn66Vp0/fvJD5TyDSQMglygE4e/WVAKp
 GHJnNeIcemNvz13VbiU0emE5v9OH16S/G/GhTBZhg1g8fedBKSwgsTpL5SSAaJsSJsc9
 MrU2WT8RRV7yoE6PaNwlI58g9/AmpCaOv51Qrwnf1jEI0x38dFVfFLPdSufVR9RpcB3Z
 n6RCwkFtHq/I6oMLRymYjqz+awOjIyggSbgbnxxHAmVSbyQ9/nH29CFBjSDek2Dc5Hk/
 o3koCKWPKmRNSW36gvgXaCLSTIAv2EdHNMSW85eQE+gLVhLS55dr76roTgs5+/dM9Cd1
 DEKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRvJVo1UddqO+53UUWFD55lbP2wH2tc1hkWm2NbWD9HgzvwIIoB5SuG5LU8H7yleY4LeY9H0c1t1M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJWH/6NdqXHhM/gYcSxkRFxhLukHTdu7hNA5EUdzNw6O2pf0L99
 yY1y89o3fsJi2SKgtd/tbLVtHG0Xpxp5fkz98yDqlfTRpAQgi1Foj4xG1fT1TQgO5n1PXm3ZNxe
 0QESBeREFgiRthFBgfqN4F5ldVmBAcbRKOFarYX+L0nfRYtCOX04oing6cTQuuoGxIwx2iIQ=
X-Gm-Gg: AYBFou0Vu1mgBVTU1UQYpkM9ZR7stsz591SzqlpMdXBPoHSrfYBmAvwSUiT7okjsAbZ
 ZphlP9Puo3zypG6Wcc3AWlBUOJKhpjTc4vBD8R4DsGx/fKQ3sE/0NEhvRltQw41siOt+JuwaVGq
 dL5MGE7EqgfIDj1PPHuLobqG+BVLHP535Morjf2KjA6DUAUHzhAQ0hKI0HOoAjNmt6gB6jlG3E7
 XyL6qf5GlOwoh/V9rDNlBAsxnRxiDShbpwJeKRVuhtDqrMm/EivRMQOLVDs76oVIhmweAFxQw6J
 1kLAzfkktbE/XPKTGCQbGAE53Oqz7LHuJgZ0afaqtZqO/EVeS6KeF+9S7d+klqTb0rb3gIJnBcc
 pgPoTT/isnGmpIXmGG0NjoZ8Iz9MdPTKIENJ6AR3Vx5b+yWxzsSqK3vr0XV2BjxwNSE+rt7E=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-9442151da69mr1543681485a.2.1793611475386; 
 Mon, 02 Nov 2026 01:24:35 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-9442151da69mr1543676085a.2.1793611474893; 
 Mon, 02 Nov 2026 01:24:34 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4a91csm358465966b.61.2026.11.02.01.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 01:24:33 -0800 (PST)
Message-ID: <ab231636-67a3-4d00-84b5-1d7671d96120@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:24:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/25] accel/qda: Add remote memory mapping to the DSP
 address space
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-17-88f2f24a5f0b@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-v4-v4-17-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2bAwM_bzPme7mLgfRPnKUq-U8bvxFTeQ
X-Proofpoint-GUID: 2bAwM_bzPme7mLgfRPnKUq-U8bvxFTeQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNyBTYWx0ZWRfX/JBKMJZSBvCe
 /8jw1HpjglTOJ6Qr+t7Xe1f3Bq6cW9T1tl8BOj8aRX7MfBnEbtLlhK9jOpJRFc6COZQ2kUavmeu
 Qlk4ek5tYpYZS4XyEMS8Yt9tL/CoHLc=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae856d4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2m-AKP9SCvF1DGFPBvkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNyBTYWx0ZWRfX9st5VNWdyVXc
 zo4oOJQ4LYm5LS79nzR0MBV93NcC8tCcXxqCzxMwfp8M2+QeU8t3MC+fz9yMoSNN+iRjUShtd+g
 HgLyG64/DD6Y7+w5La8km1zsom3H2DtW7E6ZCmwsk6mXVJQSMjSAAKQYaN6hKoWLl9x22ilfxav
 HIdI/7qQ2JCEYUzdQh6vlYAKBsygsKK/4Z7RK+hWOKtwnGLN7jy+5jnxOrJSiVT1KgNCjkTpJo8
 7f5BqjNSg2gtI94b74SwOG0mzzmX06IZNMsW6Ai2cYVUSVdnpUl+FNErVaQPp4PBhDjV6L4CkKZ
 cQEJLc3m3r/eSdox0Mo5a0DEiI2wqBKRZPdDejGMPXA05HhjTxnDY0pt7dJVH8PwdMS/nnBpnNc
 rMWrzTIru4PNLJeUTJ3/w+fvZUL2ZUH0wkwk2cnGAh+TfxDA4ViSFvEJwRqTv9A4IiTqgWN2InH
 KBAJjMCmtmZ1Fkr12tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020037
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 11:21 PM, Ekansh Gupta wrote:
> From: Ekansh Gupta <ekangupt@qti.qualcomm.com>
> 
> The DSP can only touch memory it has been told about, so user space
> needs a way to make a buffer visible to it ahead of time rather than
> only per call.

[...]

> +struct qda_fastrpc_mem_map_req_msg {
> +	/** @remote_session_id: Session the mapping belongs to */
> +	s32 remote_session_id;
> +	/** @handle: Identifier the DSP tracks the buffer by */
> +	s32 handle;
> +	/** @offset: Offset within the buffer */
> +	s32 offset;

I think this should be 64b too.
> +	/** @flags: Mapping flags (cache attributes, permissions) */
> +	u32 flags;
> +	/** @vaddrin: Address the DSP should map the buffer at, if it can */
> +	u64 vaddrin;
> +	/** @num: Size of the physical page descriptor in bytes */
> +	s32 num;
> +	/** @data_len: Length of additional inline data */
> +	s32 data_len;

And same here (and in the corresponding uapi struct)

Konrad
