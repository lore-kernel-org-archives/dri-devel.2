Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62603606A335
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSpW+L2W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT2dyECf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB76810EFAD;
	Mon, 26 Oct 2026 15:30:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738AD10EF8B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:30:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvcUE465831
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aNEN/0vWce/15eUz14WckhE2l2ohDRpHNcQP7Q+mdfo=; b=eSpW+L2W+Csp5WUY
 GvxBySkIFVAQMZDJu9L5LzxKEJW4zA6tUbyUJ30PNCJh7eFycvg5q4yjUoI/K74O
 s4bnSEYpe809dALsn3T5v/PlZsUrCJOZI+O5/CsnItZZOQvcOims7eMpT6O780dA
 oEWEFAxUo1ftvTTDWDHldVpRFns1GAIp0xuChWsQRFPVuHSZtqegzef0LKDxlFFM
 uwWWjUr7Ar0+hnxUJCQQmCTC/bbaBBqIcZyp/7HnJM4qYnKAF2Bo7bDiyjbSW9HC
 lMNG/NVva6MDU83MQbjG8IJpZmu2Za7iKWE8WTOC072qK2y4eF2x1rlhkHkVdSni
 kkm0Qg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpu3ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:30:43 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988bcc2f50fso156430241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793028642; x=1793633442;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aNEN/0vWce/15eUz14WckhE2l2ohDRpHNcQP7Q+mdfo=;
 b=CT2dyECfOtqhNYWJcCyOPaCsgR2+A+zLM45YCV61w9Ht3ff/qpOmD6eU94P8XUFHjB
 RLf4uWMecS25KkXXfP+aqBHvHt/JSvrYZVYi8riRkiHNRhrfhQhYQmRbOLJ5CiIQ9zuz
 wGSBYxOBEAJeTp1LTIom4NTYMxSZ1mDkc4SBOyxT9lBINHFfA52jJskCZJ5L9pwvVZO6
 hnyGL0vdT7nt9Figh86hX+q2V2pQzwjU7yG7kZ0+XHGFp4XV5SetwXdesreJq7ImHj7j
 xQJDfQVBxdBIlcEfWz1XisnKYfrx0lgwXUmjhj2nQgak36JHABydZfiqUU3MzXd2rycu
 LvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028642; x=1793633442;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aNEN/0vWce/15eUz14WckhE2l2ohDRpHNcQP7Q+mdfo=;
 b=mvwBCCg7u5Y3fMJpTXTav0/hydbUmG4Q7S3UFBpanHtdUFT0IvCzEQabZiywAST+Np
 wRzXsnBcr8qFdBWsUW6oYOxKUIeOonOfzYfeuANj5Up8+WEHCn0TMTM478ypF93cY16v
 X+Jy+HEZupt8vCnOAPm9QUddKpmvcK7NMoqGEtZmm9owaV397pPnF7JfDtld+sg8MFhg
 L7Gz5XAScXo4QLN3BWG/okKaOdXfJmTRmr+SvxmvzHSVPLHJNEf5p+SNr0s9jZISUN7E
 Y9WOy///88M7H4o6TQYRtKbFnw8IQUJhZXTd/f4nQn2O7wKx+M4ATl2NIgv17rXcO9KF
 Wz4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD4bHtekFhUwwXfvySxK2nm/mfMdCSiGNZ5n0Jx3sEjI2/wDEVY+xmFiUi2DWY3mhHl7gMKN86v10=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJcsW8TibW4MtI3vptIsguA6QKHuPllX7/XcB7sjPNhrLpVJsv4
 JCIO0alPeGUp3QBqyVbndHtrfrKBkUhTvV2UJTH4H9M6DJVKaDuiQ1cp3vJUCwx/HhVD5xWhlyQ
 mf7q9DmFYzaSijKZngsn8uznnlMFOzP+FaNy+Qi71LRU4l497yPFqT1Sq4Uq0WczCfoRc+tU=
X-Gm-Gg: AYBFou3uonn3n4EChJFCUST8zE+abErLGyvGW7Q9I2r8/qbCOARgCMNv2vLRVnCmf63
 fTv9MifCFEMs5xEUpBOhkQqu1xhSNI7+GchbO9ZWsQ55dfQ+/llWHnh5X6Xy/xwbYUf5jQhDxR5
 sxYMySAtpUnBgMQeH9F3jvss7XvN/wqZZmzGOAR/MzqEUoNyE4Q4wr/fZASXIZl6sPyfElZTanV
 obrJaOymMY3H1yQPOsy4WP49WeTcHwVO3FJIOvnUgseQ6mVFYBNv451FAqsfn+eFkKxaWyTTUjK
 Dsa1X8FT9whh5jUrj/GiPAQF8J7J3OwhJxXw8OaVM95c8L6E3P/ATs2WRoOBtH6Mkpxs7P2hbpA
 xhSxnb+pAs1nUJcfweU66yQ==
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id
 71dfb90a1353d-5ec2331473amr2249018e0c.5.1793028641681; 
 Mon, 26 Oct 2026 08:30:41 -0700 (PDT)
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id
 71dfb90a1353d-5ec2331473amr2248969e0c.5.1793028641198; 
 Mon, 26 Oct 2026 08:30:41 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd79eb05sm333500666b.79.2026.10.26.08.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 08:30:40 -0700 (PDT)
Message-ID: <a5667943-3c3a-4bcd-99f4-fe5e487cb6c5@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:30:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
To: rob.clark@oss.qualcomm.com, Konrad Dybcio <konradybcio@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
References: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
 <CACSVV03M_MzamPN5X=+bmbqOkET2QOJk8O_vQyhnjDGbSTvN2g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV03M_MzamPN5X=+bmbqOkET2QOJk8O_vQyhnjDGbSTvN2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MSBTYWx0ZWRfX3JxjMfIFlJlP
 fyVcdKTZLBNZXslrn/FOQTFEZQNuNNhQ8Cs4b/qtW/PCEbplmZgOl+BjbLDVHOEPkbaq3R7PWdL
 DaFwLLB6sYGeuh+XrhtvJ/h0VK/2xR4=
X-Proofpoint-GUID: v1E2lzCFI8fHVfHQWOwnjFBEHngV25yY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MSBTYWx0ZWRfX9DCHyyhNY+r8
 aTJK3hrNzG9mJDxK47zBkcrC8GQ2q1IVYgVGktoTttdyg102sXHOLYgsrCklv+cTP9B6eSP/Rhc
 3qq0pVFcEGUX1WTmT/coRKQCG3qxWd1em5jzXHq0fAge/fBNdEYP9idb7Qn3cdJw4aA9qky3EEs
 IHCGoDBD1T+6X7O8BSjGJHip2T7dPypaZO2yU8UiDlhC+LYaB8XSmygkOKohY9/DPnzoV2TIpxi
 5M6y3nb/k/fwl51UAik2bUXYduAJHN+E0/hCkq6claH1dhsAEnUPEEPqKZSZ8Nm2mr8i9ZkLjqx
 J7ziYFnoQSfipl+SVg+duU91BLuxFlZ9saLxBVJQ8C+az70rBW7TbL+VOoiZQ4Cha4wwSdVUodD
 j/Ha0Q7Ivx2mASHrcj4yolKcrR4FN5I7zxYCiJJCh4/Or4R8Q1YD9UNVTY3Hin0+TDy52DRXr8B
 +FKCz5SZ/o46NDiWzpQ==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf7223 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=obMtVcPMbQgr-G-mzi0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: v1E2lzCFI8fHVfHQWOwnjFBEHngV25yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260061
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

On 10/26/26 4:26 PM, Rob Clark wrote:
> On Mon, Oct 26, 2026 at 4:40 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Much of the VM handling code is a headache to read and maintain.
>> There's a soup of mixed-signedness/size types which need to be compared
>> and added and getting that wrong in C is very easy.
>>
>> The "(range + obj_offset) > obj->size" check could wrap for a large
>> obj_offset, which let an out-of-range map be accepted and then mapped
>> as nothing. Oxidize it and use checked_add() to fix that.
>>
>> This commit is a "get the foot in the door" type change to make sure
>> that folks building kernels for Qualcomm SoCs have their Rust setup
>> ready. It may/should be extended to the wider mm code once the
>> appropriate abstractions are finalized.
>>
>> Worth noting, the C UERR() macro expands to dev_dbg() and the Rust
>> implementation for that currently doesn't support dynamic_debug.
>>
>> The DRM_BRIDGE dependency is dropped because including RUST exposed
>> some spaghetti dependencies ending at DEBUGFS and it's enabled anyway.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>> (if this is rejected we may just patch the C code).
>>
>> Notably, this will regress some ancient configurations:
>> -- arch/arm/Kconfig
>>     select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
> 
> Side note, I'm ok w/ drm/msm (or at least the gpu part) depending on
> CPU_LITTLE_ENDIAN.  The combination of BE CPU and LE GPU would be a
> mess.  I'll actively ignore bug reports, patches, etc related to BE.
> So please, no BE!

arm64 is free of it now!

134b0fbc5c24 ("arm64: Kbuild: Remove vestigial big-endian support")

Konrad
