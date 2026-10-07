Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10525CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568B510E607;
	Wed,  7 Oct 2026 15:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pklZAV+e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WM6KOeoK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2B410E607
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:54:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtTog2809030
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 15:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Wn/eF3+D6S100Mm1A0q9mTWa29XtPz46LOWvNb0UqIc=; b=pk
 lZAV+eC/gcSTolOMNnBZPjxvRmtcGRUSGVmNasznAiJhX6oInpKlXD1fMtOlvzDm
 pbjnlVgWTH/8MVvpk2Awu8dUejQFLHhHl3T1KbylyysniMO9IMnrq1dYrlkOzeaA
 Aaq4cip4T7hjTIYqyOMUA2tBkNX/nbR7VtM9P4Ejb6ADG5Gp+ljLK1r2qfHB96g/
 VBWp6MFqGHUuf63KJkxeiGryQWkok7o0XZgPo8EEdla3laHofYP2HC/rEUUZsKc1
 PE1TBsPCAqzVdzkrTE0rYZUvcCa6WDezLY8zIcekxyeAZGiqpSEK/UvbsnDgubZ6
 N4jcJXtvoRZKq4a7at3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8t6kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 15:54:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so3845339eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791388489; cv=none;
 d=google.com; s=arc-20260327;
 b=CdXIeAResamvEuFNjqqWrZm77TxTH72v0A/TK5AXXWSp74KcAvxovhivBYQIcfr2x7
 VXJ6Fr2VNCoZXOfAUkgS9kxmwG1LjNQZeM+paagueUjPl27iK/x/8u8xhoBKkvD8jajJ
 MRtli1RjzW0hm2UgZsyhBS3/q7ivwsbbGg9oK4Gb+3vYYJLtg+ZvY9/Iw7xg5q66BHU1
 HmV6mhIjzhhhhW21FwstzM3OpvOA++BQtYz7DTGB3ywPCK3ioN5cfdl3D+yi1RePYlZw
 G84lKIz0+37zbTmElCCdeGp2fdxjcnDKaoK39K3f76ncWjdQ39s77AxhSRRd9sNBW+EC
 jOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Wn/eF3+D6S100Mm1A0q9mTWa29XtPz46LOWvNb0UqIc=;
 fh=V5egTcqJo7lZ6AX+8n8+0NAw9s2ZdL8A4iuyEy2QN4Y=;
 b=UyJhqWjF+LY5ExNhsaAQDBTNq+1MHuJu1MtINrbTkSkLsmnXHRMrnvWfe9mvbvFbtJ
 diWwcaq9L6WRyZNDH/M6zj5ad/57WPlzYeXMP9ZiP8U7ke8Ph9A97IUbpwuR7b16Bkd6
 LiASf7zCB5wMKEZ49+K4i8EHxhmAcZ32oGRY6KHTXdz/Oy4Sbqv4i5VXgJ5MAAm0o329
 3m1/XYZOfUxj2hm8fPqXj1et9PnVaduwIbUD6HHBc7sBe+uR3YaGTUSEfDu7cCO0ClKa
 jxpD1ZmXZRgis6m8/jSqL2DyAE8jwJUV3UXIYYD7gVjBNuRknQSEpFV03Vd1WydwoLUO
 VRTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791388489; x=1791993289;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wn/eF3+D6S100Mm1A0q9mTWa29XtPz46LOWvNb0UqIc=;
 b=WM6KOeoKBX76AWw90Imw1iL2xLSnTi3+7M/blo1IMR0R9+XSzyFfx45ynlpjGeZbie
 EqeDynTVrNE7PBXnRfoSuBY+R3hxSUqW4SsTFaaGQNd0DsNYFdw90sAJeFiZRB25yV8x
 DAF1GIJydqAQQoLGj5ZWZB2zb5xQoOQ63yYDbwOjLFatb6rEisDSr1CnTdM2ZNGZY++d
 RSBgFxu1MR/bPrlRT/Uo1CR2Dd9+9YA+FCq5zrzI+b1A7rdcqvJwl+nm/mOEd4xgyCyj
 Y5RjFSVVBt+b0qZBVw6w0BUoS2DWxjupkFOxUB1NcYOm6NFLtj4npWjSv1eO7/P9yEH8
 Me3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791388489; x=1791993289;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wn/eF3+D6S100Mm1A0q9mTWa29XtPz46LOWvNb0UqIc=;
 b=U3/q7iC6H2hW5rXMNY1GOEDdcNbAxB38CLCSOwcKe8GG2hQGG5kKSzuI3SUmgnSroJ
 KSFGEhAXBHQFK9SlsBrPcxhLJhRLqOyrThSnT5azNU584gFfIXoAl9t8OX0l0MYHz/mr
 zkAZ6eAPrxW5bgrYL1Hsn9WFpdtgD07MfC3be4L1nD0TeZl2YqfT9iUKdu9I1ZtDyShc
 3h39BcdD2O9HzTaip/vgTfGMBlBJHJezazIdWrSLCOoI/iqXMAQR75PIukCWbfrczBtr
 Y/GjSzXC1BwNVeultmxUfU1Wn83FjK/0iYlVRdrn+UUCW4B7wJEZQnE2jLAlVMBkVKxX
 zccw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1vpdWdzE6lociaLKV9kfuAjJ8s2eHN5O4mUbkeKjD4ljHu/O8mGJs2GGL7ry7AF7eXFJ7aMiFc90=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQnvSlBvTVnu7i6OxU4hs3Oxu6ODhoKFLSYEmwEiYQoYR/pwKV
 5CGY6oCpxRIXqZK9jwaRgptqdCAoeMdsUnzGj4ZuL4ij1Zl9wT7d7iAQreyJgFwdStPu531kFe6
 edGP5nH3fAaBNWrObHB2yIRBckXVoCu3LL+nnnLOh5Att4zCGf/b+h/Ma9PHrNRu3f3NMmmBmGg
 K2bI0O8PezqYCG5tIUZvGDHC6ghNhJUplni7a/2av86QsyIA==
X-Gm-Gg: AYBFou2RBNzGcKBz21k+uWt6fXfgxz8GyoLOcZk/15XQL1LoProGPs1iEJc4JTM4lAc
 O6FE59rVnoHnmLSwLuvnTBqZYjCMS7qkjDKRyuDR7eC88eE6zBS0YLTIG9u5hTZSqkugN2QUkMk
 nTA03K/be8BWbJRwq54FjmExc90qGyBm/zg/29wO3SGp6uNXfcJEKmM4Cy
X-Received: by 2002:a05:701b:2806:b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-162044bf3f0mr2885600c88.7.1791388488611; 
 Wed, 07 Oct 2026 08:54:48 -0700 (PDT)
X-Received: by 2002:a05:701b:2806:b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-162044bf3f0mr2885557c88.7.1791388488032; Wed, 07 Oct 2026
 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261007131543.7634-1-liujianfeng1994@gmail.com>
In-Reply-To: <20261007131543.7634-1-liujianfeng1994@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 08:54:36 -0700
X-Gm-Features: AclHuK9GXc0-XXuEkvshyXJ-4VCucnnUec19JgkYED6meMWxaPoMrc6_lJWUEQc
Message-ID: <CACSVV03imsi930GwjSHwAAb0D7wAAmUpbkPRzQwYThfb+A58kw@mail.gmail.com>
Subject: Re: [RFT 0/5] drm/msm: DMABUF_DEBUG fixes
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: abelvesa@kernel.org, abhinav.kumar@linux.dev, acelan.kao@canonical.com,
 airlied@gmail.com, akuchynski@chromium.org, bleung@chromium.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, jesszhan0024@gmail.com,
 johan@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 pooja.katiyar@intel.com, sean@poorly.run, simona@ffwll.ch,
 yuanhsinte@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MyBTYWx0ZWRfXzv6nhUwuxUeL
 aoOK40iLMoA6/y3NQ61jhMkQEkN6WLO+bvhujknHHFxYuaQDPfw06s5k6msPPB5HGizuhrhvKuS
 uPEFW+sC2DFTZR8tC3sjb5QlxjwX6uw=
X-Proofpoint-ORIG-GUID: vftnE-k6jWAFWQPfvK62bZrqFV0f9SXa
X-Proofpoint-GUID: vftnE-k6jWAFWQPfvK62bZrqFV0f9SXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MyBTYWx0ZWRfXxqNIlD5+9HYf
 5UvahVvfAqBRqAunDS5fqlcPxQ9sj6hIqiWhvXS4vRtGZRZlS0L452x4D5/RYQF6OMJK0KqDz3R
 HX6VQkdVmMxoNpypE2bvhNpAJJo6JHud04mbAj4PuFjsfiGyB/GcvDugatZS/jt3Hl1z71i9af0
 y2CBAmxZGDAjtO8WILDU62F/uJzM8Lbd3HmzRYDQh/Tu6pzOHOeDOZxAMRgC5ahgXLmoapC9gLN
 sNpvHHpUakkV9uDx7TmzA9r6wSTAo80K1IWZ09mx2DQeQMGuwg8aL/T2rE9xxrHg2W9noqdtStk
 zzU0fV9qSeVgssBPln5ePwqLby4cStEAnn4mJ/hCzylYX/Ry5YsMlXVZATuyxlRg0oDq3/xCf4+
 ohEf17X1xlFj7ZSVOJyqLE0Z9TPtonYWZfR6WQ3S9cew+S0EYPIoNXQefa1R+rrApwaRAejza+e
 4D7d7y63llQ9mojDJgA==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac66b4e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=dfe0JtAcDOuVnXIYvJMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070063
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Oct 7, 2026 at 6:16=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmail.=
com> wrote:
>
> Hi Rob,
>
> On Tue, Oct 6, 2026 at 6:09 AM Rob Clark wrote:
> > With DMABUF_DEBUG=3Dy, the page information is stripped from the sgt th=
at
> > we get for an externally allocated buffer that is dma-buf imported (as
> > opposed to an exported GEM buffer that is re-imported). [...]
>
> Tested on the machine that originally reported the breakage - this
> exercises exactly the externally-allocated-buffer case from your cover
> letter:
>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer
>   SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=3Dy
>
> Hardware video decode in chromium (V4L2 decoder capture buffers from
> videobuf2-dma-contig imported into msm and rendered by the GPU)
> displays correctly, with zero arm-smmu faults and zero io-pgtable
> WARNs.  For comparison, on plain v7.3-rc5 with DMABUF_DEBUG=3Dy the
> same workload logs UCHE translation faults and a __arm_lpae_unmap()
> WARN storm (~470 traces per minute of playback).
>
> This is also much cleaner than the translation-based approach in the
> follow-up series I withdrew - mapping from the DMA addresses is where
> I should have ended up in the first place.
>
> One small suggestion for __do_map(): panthor treats "map_pages()
> mapped nothing" as an error (panthor_mmu.c):
>
>         /* If nothing was mapped, consider it an ENOMEM. */
>         if (!ret && !mapped)
>                 ret =3D -ENOMEM;

Yeah, that is probably a good idea.

Thanks for testing

BR,
-R

>
> With the DMA fields now populated on both paths this should not
> trigger in practice, but it would turn any future regression back
> into a loud failure instead of a silent empty mapping - which is
> the failure mode this whole series fixes.
>
> Happy to run more (heap-exported dmabuf import test, kmssink scanout
> of V4L2 frames) on any revision.
>
> BR,
> Jianfeng
