Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84138606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UcS0ih4B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LvrNvlv2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E724810E1F7;
	Mon, 26 Oct 2026 15:34:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B6410EF8F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:33:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvwmD2707743
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=qidAGMYPaKRzpoE4VkvBWD/KkiVta3FKeYv3IJb+rMQ=; b=Uc
 S0ih4B0SqyqXAGstgs78uTJ2W7qimh8yCjoJbY09Gm39AV24Ile16ot+enHW4FFm
 9qMmuf6FHur8O9jfG/YMtkMxEAz1IiClXAjROITmWFDsnvmI8tw6nfgct/dmtN9z
 c63Mg4VyG+G/31UCIsG0BKMBk7IEt/zLwMQ/+Wf++9Km8773Q8spidzIzLZMEjwK
 Sbh+9lT/5wawmkzk3TuAEmif2GlDCYa/P8Qdcjgh7TkJmLTCpkZEDNIxwFNJiao3
 92AAAEeutzkreIbsQHsLINmFTDvp/FJ3sBJNB/sQeJ5RgQcq7rMOpOGcAHd2kmcv
 I4q1Lf0XMMwaAaExINsA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u61fsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:33:58 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-704aee0b7b2so3179402eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793028838; cv=none;
 d=google.com; s=arc-20260327;
 b=rR37qH8CN/2MOHPXhjhbwvyo2wpKr+sqdlTyrO0v6JHpXg+bz/6yQI8TBp3pYcpWr8
 t5inh+w6+YxScSObHyVz5B7R5Vr04yjxqk7DJ42xpCeJ3+rjjCOX2oLeDk75qNofNeZ2
 RQItlGnR9b16GiEjrvpCTFMrIwePlm+qLGefe5WZGpLKss/VWU40Opn4yxP3FgFTq8WP
 yKq2w+dFwrxLoPZJUSJ2T9WevN3eKRgxZzuT0xTqHUIRCZGu7yIcD+G9qhBWdjWV4NTI
 lI2NJ+ZkulVKUPFr/T/xNQrI9Ni5+2fGnQHkWVowo9H/6MOAygksMmJpqTrvcbx447mQ
 NssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qidAGMYPaKRzpoE4VkvBWD/KkiVta3FKeYv3IJb+rMQ=;
 fh=r0pnopSaZmClIwrAuTMF/Xkj4RLIeWWw0Vfff2UngK8=;
 b=R2GmUd1Vhya5Waq1n2IJCDmHMkE0xqz6RdGhmGqH3W/kgt3+Ini7vtz2Qa/IAWENpu
 YRNkWz8VWblufIqc2Bn29axN7Qnzwdj6daovemk8kwbY7nCYQcvsEZkiA3ABTyJrn5Ku
 sVBu3zQmKXnrdQm24WpJcyr2N/C8NsoInCA9S9a2F1XamcZN/6s8cPqMC4WCHhMSLwF0
 NnqrCDdHCN2Y/8/kXwTTMBLOmItF1Je2YyTyCTpHVX0qfpku2c2qY31sIks6cIVjxkFt
 hnN9f/qxVg/krLyrktfM7J3C0FiBYfJbJ68XLcrwVhE+9P4u6eY4VyMBumE4GaR2EAje
 SX9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793028838; x=1793633638;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qidAGMYPaKRzpoE4VkvBWD/KkiVta3FKeYv3IJb+rMQ=;
 b=LvrNvlv2et/b0Y/Jhpt36F3ogMDOHiGMonyXi82etPz18zWfzyEXpv+Ik/7IcCLrji
 v3koxsnYfKGvgPIikNSI75IEsKqzgjvDBEL3bmowv1+rjWT81fDtSiyf0im02MSztv4t
 IGfDPhPSse1bipuS/vQBNswppOjYIYCGcT5LGubf6VwAFZj8cwECSYT8A8zHiCh9ZX3i
 NP6CpE93n9t8rjv+5GJukB+tOfjx8LCwEqUr/rogoPKLvqKhfkYD0i7tIaUzEgw1WNaO
 slGp+in6BymXYd7fG3I+nIHKzWDZv6xfpCt9KzVLVXvo7YDAMjws9U7pTjo7mRnzIIe4
 fEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028838; x=1793633638;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qidAGMYPaKRzpoE4VkvBWD/KkiVta3FKeYv3IJb+rMQ=;
 b=pF3KLBbokYbM6ggBJfCnZU0Iy0LZq9jy4emkswFQDV7gOILxLFFOCoDIkGBh7rQqHb
 SrPPtt1X5lZqxm39LV6RP6SRpnsxr1mxhlvmkxRnRquOAmAlNkToSIaIt6rUYtkRByLa
 jRoupsxwAnhAjpwJQCTjVMyo2Fpc6f51tZUlo9enjuSfQEdwsK01tiSUtfCCMtxfvtKe
 zAieU/lCvQCbmFu7thVnw8uw8DPueN+Hb2qy+hqaghIsKOOCrvXcASrKazbt3z0/grET
 M2nqPJ3uGzaaN2WRufjAYOSk6GVuo2MC59S85IP9Hd05O5MwTC2tYd0RnL4QDdO/Za91
 Vc6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+h3+IjrjjAVSuDJpLEjAC1UC2fD3u4lUteibWboH/MFn8IkHZBWprGvjcJ7vLPLjkTGWs78t7nLU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIr1Q1V46eojmRgUp3n00kiQvH0jSLMNbnmEx6JYwJS1zNW3k7G
 JwdFiMvqGgrkPVnpAT2YHPQwlB8cRrXahBb8OIrIedW88nQytpcow4e0DdxNhsUd0TKJSOIz6++
 lxMfgkoCdbp/Pj3/9fsfwRsAlvCeyI04+gNSbDGeRWGOD5zyxZnuI2PSVzws4UYxofx9jvxlkxa
 oxpO6//T41X9kE56qXHqYo9UWEN3f9b4THzKcp4AoO+BSLuQ==
X-Gm-Gg: AYBFou14VNNq1fOw4zQjZ0gw2KXXpKg+2277dOxIAEF7pJceXwnF/ZUFFvLaOXc9LSo
 f0ekNl67uTb3Tp/Cqw+C7UmQd38QvfG3vMgToXq4r3fZoZpL7spstYZy4yrNx6X8WO1oldHx+lk
 cT/bPbSXwJldJdJEJJ/xI2VE+uxeD2eAbeXtTc8J+hzdo+BEHFeCNqX9hREQ==
X-Received: by 2002:a05:6820:1387:b0:70e:78ba:11dc with SMTP id
 006d021491bc7-70e78ba2a36mr1241822eaf.17.1793028837864; 
 Mon, 26 Oct 2026 08:33:57 -0700 (PDT)
X-Received: by 2002:a05:6820:1387:b0:70e:78ba:11dc with SMTP id
 006d021491bc7-70e78ba2a36mr1241797eaf.17.1793028837444; Mon, 26 Oct 2026
 08:33:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
 <CACSVV03M_MzamPN5X=+bmbqOkET2QOJk8O_vQyhnjDGbSTvN2g@mail.gmail.com>
 <a5667943-3c3a-4bcd-99f4-fe5e487cb6c5@oss.qualcomm.com>
In-Reply-To: <a5667943-3c3a-4bcd-99f4-fe5e487cb6c5@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 08:33:44 -0700
X-Gm-Features: AclHuK_qyCyqkMau4o0U6eEvxC80Yve9tJ1hV1jdwuEzcVPxGyIcGYsybUyrLPI
Message-ID: <CACSVV016mJk+oLotAUKeXr4a9FHn=cfPcWrxdfrwRxmC4S4wqw@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YySoRcVeLNZnTasOu-A8N2QqV4OLE4NF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MSBTYWx0ZWRfXzJonwmxmLOmb
 Cf9K/LT9N9F1y9tvta0tBmOpuDEO3Cw8oI1pGRhOIBybwEqhxlyQ6gWbYN6Svu+JCIRmAEnY5l7
 iHpflmZLt4xGeebjCpuj78Uq7eAr/ZjHdE56eE6Z8veF8I6onjyk5G5uKFAqrABOwt2H+T8HnUB
 tgrPUtKxPeFA3e/rSJw2niD79ky+TWGaSdEwiC+FvGhz5GJ6mCPBfwJTi/euAj2rvhsLzqy5QSr
 bI9C01XzipnG8vE2k6oXW0Wzm9QY1KJFZ65uiYcJLaKE9GQsVDi+m9jg7+N5PJvFuOfl3HjXtjl
 9XGgg4o4iDehkJOdyaFmbIlGTzLcSRawRS1rDkP/48HL51pRz+qokJZXHZrFpIrQK75k9FIiTRU
 2jpviGJfvgO0gAulaUUiyqqrJm9J3VcZmztWFxe5emakA2GJRnBSjSsX+xDn/GZL9byyePPteja
 IMl23HqBriRlIzqq5nw==
X-Proofpoint-ORIG-GUID: YySoRcVeLNZnTasOu-A8N2QqV4OLE4NF
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf72e6 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=9rG3V10fu7yUYHM-WnoA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MSBTYWx0ZWRfX5vW9BJK0H1On
 kK14OmAgBg17SjmaU1zy543mbN2pCqcXtGltC2i5P5Iz+HpBm3Xyu6pph7+9FkQ9sy9ac0CJxXT
 R8jI9NFHclx9Wq7UabxuZuOM4vTo7cU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 8:30=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/26/26 4:26 PM, Rob Clark wrote:
> > On Mon, Oct 26, 2026 at 4:40=E2=80=AFAM Konrad Dybcio <konradybcio@kern=
el.org> wrote:
> >>
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> Much of the VM handling code is a headache to read and maintain.
> >> There's a soup of mixed-signedness/size types which need to be compare=
d
> >> and added and getting that wrong in C is very easy.
> >>
> >> The "(range + obj_offset) > obj->size" check could wrap for a large
> >> obj_offset, which let an out-of-range map be accepted and then mapped
> >> as nothing. Oxidize it and use checked_add() to fix that.
> >>
> >> This commit is a "get the foot in the door" type change to make sure
> >> that folks building kernels for Qualcomm SoCs have their Rust setup
> >> ready. It may/should be extended to the wider mm code once the
> >> appropriate abstractions are finalized.
> >>
> >> Worth noting, the C UERR() macro expands to dev_dbg() and the Rust
> >> implementation for that currently doesn't support dynamic_debug.
> >>
> >> The DRM_BRIDGE dependency is dropped because including RUST exposed
> >> some spaghetti dependencies ending at DEBUGFS and it's enabled anyway.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> ---
> >> (if this is rejected we may just patch the C code).
> >>
> >> Notably, this will regress some ancient configurations:
> >> -- arch/arm/Kconfig
> >>     select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
> >
> > Side note, I'm ok w/ drm/msm (or at least the gpu part) depending on
> > CPU_LITTLE_ENDIAN.  The combination of BE CPU and LE GPU would be a
> > mess.  I'll actively ignore bug reports, patches, etc related to BE.
> > So please, no BE!
>
> arm64 is free of it now!
>
> 134b0fbc5c24 ("arm64: Kbuild: Remove vestigial big-endian support")

And there was much rejoicing :-)

BR,
-R
