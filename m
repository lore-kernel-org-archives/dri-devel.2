Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF3A109C040
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74E810E8E3;
	Wed, 25 Mar 2026 18:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oBp6Qc2i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBO/OALj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9F810E8E3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:17:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFHHBO779733
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=yz5R8rn8dDhfOt0Mi7lIkNBz84jcDCRPY486ZJRPWtw=; b=oB
 p6Qc2i4SR2SOcrl3PdHh+loPVs/FrGtePoHkFxbC8nySkGimb5XOupo9l8J0O99L
 l11RtEz3BR+W/9EUfQQ7fJTPMOZU+CWYFYxOp2Fea15yU5Csb/UTqOfFca50UYcK
 OZyN18MnqwQ2C7JnuwuYw6z3hyOkZXMBWdnrgxEdDoiOShFwQPplEbWGNSGHmoNj
 LYcDE3fHc06xfjOh2Kzn1eJESIvwthzOEG6VZei/83RTGTSMPO3sPOYCPksKoxVI
 6wUGjj6vMn/MU1LN5xrgO4X2kHv+fuj+Ru2R2eZ78Vno+m2FFYjJGc5BaJvJ3CA3
 VA3Zd+GbEoUMaJIl/kYg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4cvp214u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:17:54 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d9e1866bf1so237539a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774462674; cv=none;
 d=google.com; s=arc-20240605;
 b=N/EYJys5l4NOV43lsOlT6Bv0q6a4sc0ITPfcTZjAl+5vGaO3zDYp90FIRMpKzLnkkl
 u/JjX+pyVa2p+ha2gFspCV0zwO8Ri0kxsUsgCMymjuYdNuYIoorVHj2QjveYnNSAbuGW
 BtL0Ys48qpyYjMgNWKrE45ssVLg14Nc2dC3aSVSnDo5qXPdnMxeF14JmW3VC8YI+mNN2
 rPVPkJOt91OEDPW3OAAjCLU/vcYk79z8qMNz6agSvm21X75CRy9qNMHLHgsjRyfcqvpI
 XN700Pz0/zJZ/wu8TTPcwB8n5lY31PjdFPaCytJ50CHYrLrnau11dOK0QegYZvdCRZwb
 vc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=yz5R8rn8dDhfOt0Mi7lIkNBz84jcDCRPY486ZJRPWtw=;
 fh=VMIbKNIFl+E8DCwG+7Cvd0FItXI7oVT1Sidt2r4mkkU=;
 b=WMAjJYraqZdB03UTNDrgVsBqGT47LSwuxXUnS8aihM32LibPdU/c+ZpttRDhfUNSSH
 CB5k0VZYp43mMB7hovMgC7FIs3LsKJtxh+JqY2ebVhMKntq4TBWuudsHBJB0tcM4tSbR
 WwWZo1AQWDWbHmff59cpjDpBlYbeL/MwNYPqTvoFdH/bCQi3v0LDUbIlI+blR9XKWCGR
 ujDSoEXAviL8pOu5JFgHWcaBnZHpLHdANlY5ok2clY59buZdhVaExNPbBzYI45HfqpnY
 XGs4sAGD2URsIh8cfTqg0LEnra5GORFgQJWWtYGxR/Q2XalKHEB1vW+2ZbtzJXsHA2KH
 +hRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774462674; x=1775067474;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yz5R8rn8dDhfOt0Mi7lIkNBz84jcDCRPY486ZJRPWtw=;
 b=HBO/OALjfv/QSbgmgGOPhPvwlAh4QRAwFzLyx0DdRNKbuv/kNVFvZvyOKj6rMUpUjO
 9VtymzzsmosYSUb5j20yXix0DwepGRjl7hjREBiZbrKw/1VdT3McTixEwIJWGgPjynnv
 GTHX6zWDTCZi438KfEPVpYDmbfxIhA3rFpLucuJTgHf0Hspjt3CaYi5FQ8pQX7rm9FJM
 GAamfTOalTm7nWtsGX7c3um86NoW97KWHPRwZ5sq+iZGQQY3lIxPr0IRvCe6QrgtFhmg
 eidds5zFJBQ7Rqfqt3iqq2VjkFLlFqkTOm0Wevm1fxsRGDFN8vCnRHcBPGKQjYKR33Ji
 m9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774462674; x=1775067474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yz5R8rn8dDhfOt0Mi7lIkNBz84jcDCRPY486ZJRPWtw=;
 b=svhH2BygEwRKAA10jatB1ltHPJDH7pxXj0uGoDV0NqeDU49utplzv2EeKshB3M6ncf
 bmTT3Qsqvdqs5/6BbTGTDYoVQEbINX9y+lGdIFLfyETM8aVRoU8b2bkXL6iz5q0d+ZWA
 kVbl+yz1mM2nQJtKxFnPbAjXDAp+aVt2BYm1rMcJAFpr4vAArqMl6ClmbrYoidvLGgMH
 qjp5ibLtbZOov4Gg7dGEB6gyL4EHACRkpQZVTx9tUDGewAs9ThHQSofof0RnVSofvcgr
 9m6Kem11JRZej4N4Brz7MXMKImhd3IROpwGKNm5V465o/ldv5xaIFTk0KlgCETou6jq1
 WskQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ4scJU3JaXC1mDIDQtzidmbN8o7iuLMr9L7jWyKDphGeHZ5+3TTg8VKYLSSeAdUwPggviXT9cIJY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyP4D5KuqDD/EIa0sCz1sSyjPE08yKb9OPZ9NWGldDoqOE8Zfbu
 EGe+fO7d1x0c11adwcDrESP8f1cuEsw+ueDu0qUVK9yNyLxFVDRmvF3Egbu34Brna367t5CUngA
 NUAHAAuDrnh5QgZyfJEJANZgjGrOBJeHRfwaGmwSW1pBfnNTcbibrtIFswhmVODPfVpI3XcZzeQ
 dcxeEMVHELxs4azRlxpuxpsIyDy1ubIwp0vKKoACisMLot2A==
X-Gm-Gg: ATEYQzxAVsGWOsjCWCom8RvwKZHF9Lwavgfv1w4DFyqtQaRAOsZmPh9Bl1wxfl0j740
 v0G0w9uOlnAyNBQCxlmbLIxwHfsdjmhxPaYNP2jZsMoV91Ju50+Y+PpGsjq0vQfCmSEha1/chon
 VaV0XnsEglaKgVGu2P/hh9a8wqukUF3zYGxDwA6rAJHow61e1sbdb2/qToZBnyyztsyFJhPlT1h
 6AcQsxWbqLxbGjKy94bCwFbo9Phm0c521SHOQ==
X-Received: by 2002:a05:6830:82b3:b0:7d9:ad90:573c with SMTP id
 46e09a7af769-7d9d67ce85dmr2636097a34.17.1774462674119; 
 Wed, 25 Mar 2026 11:17:54 -0700 (PDT)
X-Received: by 2002:a05:6830:82b3:b0:7d9:ad90:573c with SMTP id
 46e09a7af769-7d9d67ce85dmr2636059a34.17.1774462673599; Wed, 25 Mar 2026
 11:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
 <acQk5DFDM0I6609-@sobremesa>
In-Reply-To: <acQk5DFDM0I6609-@sobremesa>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:17:42 -0700
X-Gm-Features: AaiRm533cRYPc0fxyULd_3mrZEreXZyZ-DpSRBrzORo_MSWcZ-q3GuM9ycfRSqk
Message-ID: <CACSVV010cyWQkmSaW1rvqfheAHxgFtVCg0zxfCzGe-kqWX2aPw@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Support repeated mappings in GPUVM and Panthor
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qiZYTECdptFddB8GsG8Q3P_WcPPhVfba
X-Proofpoint-GUID: qiZYTECdptFddB8GsG8Q3P_WcPPhVfba
X-Authority-Analysis: v=2.4 cv=Q73fIo2a c=1 sm=1 tr=0 ts=69c426d2 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=QX4gbG5DAAAA:8 a=jM_h5LxyeXWGEVmy1tgA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzMiBTYWx0ZWRfXz1DWZ9MvoMvw
 sO9OY50Zs6Vhn8APLWCTOaTW4nwsrkPGp0kLAJ8QkKT4dBKu6eHEiCfhQvnY+iDnWoosNk5yQio
 l1dUVgVXnF1yn/3hfy1dVwbWSbmYUwIz1HzQPzCn93IX7b9ywmmkMagpi10PKZgpdI6AgoC/cTH
 3bkjjW9seaoNfsJXQaga0H7NXN+jcAcnwxU8D11faIzwz3EF7JffRZg/4aNjZ8LhKbJwBJIu+YU
 U2qg2SvJvVaUH9HGmPEOHy4Tg95Ybu3o3lNbUqolPKvM8uc2sEKaQ9ouGkaYFnFtJx/Hzdj7XAB
 syLilou9CQq8vW7SA7NIBxzFZ1m7AhraWANlgeOZZpGGb16KJ1BtqA/FQqDlpkYDTb34Pwc/fHO
 qxfATbbkXqyHMZZcoAgLnRswTe5ht4zRK1W/njNEzlGNHnw5UkZjVAZm4+AURYfLGK3HZevQUJj
 0hIEGiGcftFYiS3lDDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250132
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

On Wed, Mar 25, 2026 at 11:12=E2=80=AFAM Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> Hi Dave,
>
> On 25.03.2026 06:51, Dave Airlie wrote:
> > On Sat, 14 Mar 2026 at 01:19, Adri=C3=A1n Larumbe
> > <adrian.larumbe@collabora.com> wrote:
> > >
> > > This patch series adds OP_MAP_REPEAT flag, which lets the user map a =
BO
> > > region over an address range repeatedly with just one map operation.
> > >
> > > Sparse resources in the Vulkan API let the user leave regions of a
> > > resource unmapped (from the API perspective.) Accesses to such region=
s
> > > must not result in program termination, but loads produce undefined
> > > values.
> > >
> > > To implement this feature on Mali hardware, Vulkan sparse unmap is
> > > implemented by mapping the specified region to a "dummy bo" so that t=
he
> > > accesses do not fault. A newly created sparse resource starts off
> > > unmapped, and therefore also has to be mapped to the "dummy bo".  Thi=
s
> > > "dummy bo" is small (a page size) in comparison to the sizes of va
> > > ranges that we might want to map to it, and a large number of vm_bind
> > > ops can be necessary. For example, if the user were to create a
> > > 100e6-byte sparse resident resource, we'd have to poke VM_BIND with
> > > ceil(100e6/0x1000)=3D24415 map operations.
> >
> > So other drivers pass a NULL (xe) operation to their VM BIND which
> > then goes into the kernel and is handled in the backend to write the
> > special sparse PT entry.
> >
> > Can't you just do the same thing in the driver backend, have a dummy
> > bo allocated in the kernel and map the pages to it when you see a NULL
> > mapping,
>
> We could. There's been some ongoing talk among Collaborans about whether =
to move
> all this functionality into the driver backend. We decided to keep it par=
t of the
> gpuvm core because we thought other drivers might profit from it, but if =
there's
> no such interest, I think it's best to leave the DRM core untouched and h=
andle
> repeated mappings the way you suggested.

fwiw, msm handles this on the kernel side with a dummy page.  (No
point really in it being a full fledged gem obj)

BR,
-R

> > or does this mess up some accounting or refcounts?
> >
> > Dave.
>
> Adrian Larumbe
