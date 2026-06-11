Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365D3CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D7410E8C2;
	Thu, 11 Jun 2026 22:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="GSoH5Slu";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E1410E8C2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:55:07 +0000 (UTC)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BEFurG3822102
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=PstN10mGGH+L0A0CuZvfxdqRssEKVpUiOodgdSJiiVo=; b=GSoH5SluoitA
 ZhbhWOwNzZW0wVQslaRzOinRNj0iQBrT8vlZdPN2pSQ81NJhJsM6lrkRBfl65wwB
 Y6XI9NxpND7U3QFlGs/3h9zNcYs5uhOwY47aIU5+EFwN8tL0uJjB3xT4Nc2flLB8
 OuoRY9cJNAxqPnad+ocTYUbkKCVC8IBCfC3SpUi1FJ+WZQob1ge1Jpp9UqjUFdWz
 K1c+zwzcafG7syWDN66Fj9WqXwz7FP2S9x2PYeJbkQE2VqOZpCCSJ1Pi0LPZggjM
 b2aFPVkM2zchaidEebRvMGWAVwnPUS0gkiIJhE8DgZHNoygYJJTbBZkcw54dlUux
 W3AMfKkv+w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by m0089730.ppops.net (PPS) with ESMTPS id 4eqe7xhb7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:55:06 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6f905ea78so792039a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218506; cv=none;
 d=google.com; s=arc-20240605;
 b=OOutMyIh/NUna/kmDbVhCeknJBHTEdyO+QaonUYYMxkr5MKZiLVgCzJMdzbu8Zy8cp
 VkCGffQM1AAm6GJpsXpdo1g5LMRLuFfik6LIMwAR3owm+B9pBhsFRvKSoloSRfwJZw+m
 BDA0oMS40rpMPAo8m1l+WeGEBApkdodjYUfjMGhj+svJTWY8uA3awAqcvqY7E6vU/62p
 7tfjPV9161TIXyqSRILSbPEuUncGzawu0cR+jCGWn9SyFtBbKfL8BKMmie0oX7MJ5G5o
 CPVM/nA/2jgnSi2+jnDH/olj7wpF4XaBEVP/0gSK33EO169jsLI6Ms3gIvPP9DhkgXpT
 7qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
 fh=jZJlarzlJDmijODdXLIId4gbjBwr6UxhIYo5eMmifjk=;
 b=Mvdd5PRkjuwG8zyMa6mSHBSY9lDGotL8iJwJPd4kiROhdg49qR1Lww7fWSDMhZ4A8Y
 1qdV8Q9ryx9BWJUoFdjKPa7gj5gY9kF7PeVVYwNSKjyhL3CXVGAqY0S+HVw7rQDh0lLJ
 o9Wyu18LdLkxAFt7NHZ87CvSaMx3LPCt6Rrj/Rd/bo7DzRVb2xDMJOTQwjDKnQDXK7v9
 Eqx0fl7ZIXgzRIoSlS6bXhraMP1h057iqkd0rS57c/WeTSCXAxDhluOsQ8rmia7RmZJR
 3x0FafJKhfM2kVbJkxx2xeQISbJiEKSC6keFg9qHWIlilnhEltuc9ANS6mdtRcnkw1lK
 hLBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781218506; x=1781823306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
 b=XtTJ2FylYd1XRA+KthLMpkBW1SuowQntZuxWRWFmJMeRmC6XU722/OngW9yFSXQX0Y
 SBB7UtGfFK9ommds9YxqSLoFLFEccFi5SYXN6xqghzaqvnqSscZMBFEMeb+Y9tnuN7E6
 m/lRdvF6wzqAckCcKv6VZlXbwkellwDmwZ7XfxxoA1JM79yU2OWKUmEtMGSBJxO5Cx6G
 UpLhtzJpZNEcFZPjqXq1MLbo6syOHwmwzVMCpKyEfWcQRW2jlan5PbWzANedFtrYpLTw
 aObgLKuXA7sMYCKZsraosJMIBqjuPl3kMFpMrXXxq6D4q64fhme+mm3MFcl23lcPSCHO
 6pAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BD0sneQYgF7wRyHc5QzPGdceVZvGqNgKVVvMjyyw0EhydUJkBpLHpOdlCtH4MmKW2DY1bpyPrIlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmQJXxicw1GvTtUkYFLAlv7UgJlryBPgO24kmqnVIoJtR0d3gD
 uLkK34B+TQHhyFdnYUnAE/2Ju6qkm4SGTqXt12WSLGfuxSKRqJXDpHOodjJhqDp+zyrKmEM9ENr
 xIOVNVzlS8KmVcwEygsog0G6LnPeHm8KwbhuclhtAueEepErcOx1VZiCK6SDBvWqYZDX8JsUcHH
 XqbqUpEVcppWW5UikyBu+Gn1YQ5ghIU0sCeJ+dcSHmt7B/0tf6290=
X-Gm-Gg: Acq92OEPoc/bRFG9rOif/rcdQsya+1aKYHLbI0nFedM+RBqZszzP5TdUYuHzm4Tc8+h
 mNRtEM80TvgaRt4LFwxtg3w5ldrlJN9ftWLLAFsjGOuVrTpNkJV9jS8juiCrEPgsyhipYkL85WM
 w3lNZZFCrXjOGHbagLHFtfP1kh//UMlziczZEa19Ai2eL/sizGcUbUJU3MIZWshwEniHnDYisrK
 aq4/svgqmWNE/RGrymvnQ==
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id
 46e09a7af769-7e7846e89d4mr84841a34.9.1781218505389; 
 Thu, 11 Jun 2026 15:55:05 -0700 (PDT)
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id
 46e09a7af769-7e7846e89d4mr84824a34.9.1781218504891; Thu, 11 Jun 2026 15:55:04
 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-2-zhipingz@meta.com>
 <20260611202559.80EF21F000E9@smtp.kernel.org>
In-Reply-To: <20260611202559.80EF21F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:54:54 -0700
X-Gm-Features: AVVi8Cec0xPin_3Tu2bkuOl2uwNE0xNjryiPQU2XmmSIcyBQ5hzh3oLNXw3MBdo
Message-ID: <CAH3zFs1U92oXZse+8h5rKNrfWmtqt3SeCRJa8D9O8R02chnwTA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfXxf/wu6EpYnxn
 0s+BcgRHrIccTvnw2v/Z7P1DrInpvePF553fZcIgYlNFOXXrW7eN7s4+uqHoongMGceb2E3DCzJ
 9vPmQE1idaUOka0L+cldflCw9TOF7DU=
X-Proofpoint-GUID: x4D0krfoIoAdS35_L5qncHzkfnIo49ok
X-Proofpoint-ORIG-GUID: x4D0krfoIoAdS35_L5qncHzkfnIo49ok
X-Authority-Analysis: v=2.4 cv=Zagt8MVA c=1 sm=1 tr=0 ts=6a2b3cca cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=37eGqx-N3tBcJSbcPa0A:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX4sfWe3GSBYA/
 jeVeQDWoHKftwm5LOoY2NxlPHw4vYc9ZBKJFUNrT/pErelkrMQmRAlI2TPq5/5TNnBT+1MFDykS
 P+ssSyIuoAWf+39WdDr49ZUORhUXC9DL0JCZw6sLZ6YKcuiPv5rk3Mq6GsaRvY97nKGuLQ2Huam
 xdRLZsG+fgaarYR+Xs7i5HY8lsOLVjGufNnnuWvMujw2Ju85wv7ircq/OxR7O4Q4cXFWzV6inna
 2QLzHBvm9oneQDg/70aP8CxIoTr5ZUa69dItClbzRmpgnMgjn2dZdhbzYFQmi+FIRQrg+GHU/da
 SbqbSS/irxLSOY6uj5rT5EuOflqQJ5jNYU8nCrd+4r91WSD4F0ILcTsQuyq+zeAm9ze+mjJl2t8
 N/g8AOP7bhfBMos8AsK/8ox+lyJ1z56NgFGnCATLH6vC2YlKHvsKUrLxgV5wrd6JP/rjbRVTA/l
 UUTsoID9zCVbZUZNLnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Out-of-bounds read in UVERBS_METHOD_DMAH_ALLOC handler due t=
o missing bounds check on user-supplied cpu_id.
> --
>
> commit efb72743b37fe4c5005fca2d75b36ef50832bc6c
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> net/mlx5: free mlx5_st_idx_data on final dealloc
>
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a135..7cedc348790db 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
> >
>
> [Severity: Critical]
> This is a pre-existing issue, but does
> UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC) in
> drivers/infiniband/core/uverbs_std_types_dmah.c lack bounds checking on t=
he
> untrusted user-supplied dmah->cpu_id?
>
> drivers/infiniband/core/uverbs_std_types_dmah.c:UVERBS_HANDLER(UVERBS_MET=
HOD_DMAH_ALLOC)() {
>     ...
>                 ret =3D uverbs_copy_from(&dmah->cpu_id, attrs,
>                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
>                 if (ret)
>                         goto err;
>
>                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
>                         ret =3D -EPERM;
>                         goto err;
>                 }
>     ...
> }
>
> The dmah->cpu_id is copied directly from an untrusted uverbs attribute
> without value validation.
>
> Since cpumask_check only emits a warning if the CPU ID is out of bounds a=
nd
> does not cap the value, could test_bit compute a bit offset far outside t=
he
> bounds of current->cpus_ptr?
>
> Can an attacker exploit this to read unmapped kernel memory (causing a ke=
rnel
> panic) or infer the contents of kernel memory by observing whether the
> syscall succeeds or fails with -EPERM?
>
> --
> Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.dev/=
*/patchset/20260610193158.2614209-1-zhipingz@meta.com?part=3D1__;Iw!!Bt8RZU=
m9aw!-yx89CgOVvF9E6-bX3TWkgI1oBHKqqBP1C88LmgmavxlZKHEFJdEeW7gwHdiVC2U2gzS3R=
GnvW_CiJNQVwxS$

Not relevant to my patch series.

Zhiping
