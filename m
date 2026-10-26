Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78585606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FIoA4Kox;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G1NXMV+Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C4510E338;
	Mon, 26 Oct 2026 15:08:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CAAA10E338
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:08:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvgLZ4098743
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dd7RAO3avlBAcafG0kd8O46r9QB0mFFuCyVtLE7G4lo=; b=FIoA4Kox/ttae0+O
 t98EgnygqVSsHm2ONIDoPWq4F6mCBecD5xgWMZxA/Z+aInxiCxDMSFEflyfNO7XO
 xa9phdWO7fvx8TEUjviy4CWZT1aDuOHwlwCzg4wTjwCLLm/iR8/ETzMrG4mRJ45a
 0D3/ZRp9LdnXuAUrPsQ5EPew42p1UNiYx6vPc2o51M/sW+qAdrobTdA24pNRloNI
 ZGGu2jbIXXixL978qmXp7a4wc7ik88U8epAJ8o0x06NgvXGyRjw75b5aSVUpSDQx
 rBzAdziDr9ohbKmGMia0VfpP68oF6SnOQUpH4hOCmWOXoBwrgZ6avHgd+XQ5hDpK
 vajIaA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s916bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:08:00 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cba2460f8fso130429137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793027280; x=1793632080;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dd7RAO3avlBAcafG0kd8O46r9QB0mFFuCyVtLE7G4lo=;
 b=G1NXMV+Qcch6pTnCjDDQaG/wapy+sCARzRiLiSVuGUXiIiVFR0a2DGPx7HR2aF6Exk
 idrOW7tNYYIJrbeMUVeY5T2E1Efqp4AxaX66az51vFrrLoPm0NhDv6h1NI62BNJ/zsvo
 F2vGYuucoowicsgz9HQXoj11ylzjXlBb0vnx7qm7BeIjZkmuTdu9vUtAthSo+BZvZKbV
 WeoB4flHqjJvTanA2vz1Owvhm3vG6GQIE7bwJMOs6g7z32E8zVoyDcrKIyiJcWSmvt5I
 7SQqUuvFN1YBXDtS824uTt0JoSgrEHkpR6kjtBwM7x01uxUQhYvSgrssp1ryGbO+IqcP
 AIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027280; x=1793632080;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dd7RAO3avlBAcafG0kd8O46r9QB0mFFuCyVtLE7G4lo=;
 b=Ka0eLR1jS47a/6K/004E67PIZY0viqttm/AVZshOxupz2PeDXk329UvRJCXAuGu6FF
 cEc1h6GfFWFovpU4YYiZYqzkmQgQ+m8cK/JXNR41djeOd3y5MHxeXjFDFjw2XODq5x8f
 m5aexY5gu1zYbjpEjY+cWfFlzTvm+MeZCX8hGA24dJ1ArZAqfP1EOPbKxuI6kpiG8d1m
 ci1II8JDtG3WiYq/sB+41/J/fZ/PPFYy/LL3pf1EfdoH3y1SDtivtf17RwhmhDQPpu22
 l0QuhmzFMk4Wsm3uyhFOeGNNTTxiyu+DS5gccL1kI2RifCIeDZuBdlgSUUKHWU31BIZ9
 XS4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwc8sAFLNP9QiosV1oHEofA3Dr+hQ8NvXh1WKT/L84uObAltlKp544OeiJ9Zeg+jk+5YvKcfOK0CpY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwW/0VXXYxftK7saz848cVOm/+ggkQoK1AdxizQg+VS0VSKa/4
 vHX9P2AB03lgT1Jc0LCDz39+YI74zU2Vlh7A4pVSs0PJaXaQU3n+Tp5NaKMYk/MSPwT52emXECU
 6c8ThmzcF4T+rolqQWfPjGbrUrM8nrMeFQsK4kBlhx9oiZ4gKleQwPLGk3FxC9xJG3Wrk3Jw=
X-Gm-Gg: AYBFou0q/KCTiSftHJzCtVTzVXBLO1JyhqHibhNgyGwAlSvFHhbUyWHHs9urw0OFhta
 zBsOeNmx5vk93LOKuJB/2sgaZiynDOEbPClQWD0LPf6XuiWq65tDYoIdk6ZvYYQ6btOeJz0PVyO
 dHer7B1AXs0hFEV6NUbXzBdwfGQFPRJEziws/ZlGqHwHz9XV+nU+8xCjXy7292iymjIoC9TSjKf
 IiICz0jS7MwXuf7EvSsIlB8tLD57ySS3CCATBgfP5KGygghcLUTgZZVWuXaD5wm2pQbsepXLpKy
 7q7hP8ojmkFfwBYze/yDZPfTyxaoXMgebA3xCQLDcbNa6kAWfQaz8IQ/Vji2p/vC+K6PQUYu/os
 9KhQVE9cfaycANG8Lwpdsxw==
X-Received: by 2002:a05:6122:e006:10b0:5ea:e196:2742 with SMTP id
 71dfb90a1353d-5ec232d4fe2mr2047511e0c.4.1793027279391; 
 Mon, 26 Oct 2026 08:07:59 -0700 (PDT)
X-Received: by 2002:a05:6122:e006:10b0:5ea:e196:2742 with SMTP id
 71dfb90a1353d-5ec232d4fe2mr2047469e0c.4.1793027278882; 
 Mon, 26 Oct 2026 08:07:58 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd79683csm325953166b.69.2026.10.26.08.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 08:07:57 -0700 (PDT)
Message-ID: <bd89e242-22ec-4666-988b-9edc473a5851@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:07:53 +0100
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
 <CACSVV01LdgUEAG+xyhWRoWe5Y=N7KztU1p4kQyzeW_KeWWAA1w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV01LdgUEAG+xyhWRoWe5Y=N7KztU1p4kQyzeW_KeWWAA1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX/rOYAGbM55qn
 iepVfZvC3J+Fv0QSs0R0YrvCexmslKTnp+kuvg+5SU65+JlxR6lNtqts+uPc3URJpxKxJglMJMV
 SEXht8WX9+x7pa4CLmcDrZ+PdIwITc86zivrQ4uODPUv5xHNHX0dDvcizOkds8RCEw/pdWaC7Bo
 FGeyceMNOYPXYB8XJYLvd0HJS2ssINXzyGzoRuz62lrf1pI9mdWQe3pv3lOOpupyG/cZ/rX1UtO
 olCtD/jkcta+OGT4yw9hUAXKOPf/llCB0Fs5FmE7xeIJRYNjzqJvrH4ab+vrElmd5j/ePXlfSro
 cWUn+UtuSXulIamme3rYc3UUj3GTSyOqm55shxYcbKaWA5yTft5mW88WpwlzA1i1pn5NGxvio23
 puhd+YQouZ1ybr1402yHwz1kV3iVrMdcn1UcKhG7kFUvz5Mif71F1QxS/s0ofePQriL7QghZBI/
 B+8R34QXI0ItDZa/Zcg==
X-Proofpoint-ORIG-GUID: DsiOc7yYv4iczIOC_OI7oWukaCQcPaMZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX1K0+whlh4OxW
 7GOz5/yGIxPS6OvPG5VMjZS0ZXbnh12ksxtOSgW26VK74wQs9BSB2GamJPqV+ralfWrUeUb/ZqZ
 rdULDRtzWBt3UDEVCZ6eIhCLF2O0gok=
X-Proofpoint-GUID: DsiOc7yYv4iczIOC_OI7oWukaCQcPaMZ
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf6cd0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KBXt8WmB77sV3oe1ItkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260060
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 3:39 PM, Rob Clark wrote:
> On Mon, Oct 26, 2026 at 4:40 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Much of the VM handling code is a headache to read and maintain.
>> There's a soup of mixed-signedness/size types which need to be compared
>> and added and getting that wrong in C is very easy.

[...]

>> @@ -1118,11 +1071,10 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
>>                 op->obj = obj;
>>                 cnt++;
>>
>> -               if ((op->range + op->obj_offset) > obj->size) {
>> -                       ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
>> -                                  op->range, op->obj_offset, obj->size);
>> +               ret = msm_vm_bind_check_bo_range(dev->dev, op->obj_offset, op->range,
>> +                                                obj->size);
>> +               if (ret)
> 
> I think the ioctl surface area is a sensible place to start using
> rust.. but seems like this patch could instead be a 1-ish line patch
> to use check_add_overflow() here?

Yeah I said that under the --- line, my main objective here is to
encourage rs

> Big picture, I'm a bit more interested in the
> goto-error-unwind-spagatti-monstors.  Even there, just using more
> cleanup.h would be an improvement.

Same. I'm done reviewing gotos. LLMs help a lot, but LLMs probably
prefer Rust too.

Konrad
