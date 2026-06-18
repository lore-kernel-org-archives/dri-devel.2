Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC9CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F69C10E5BF;
	Thu, 18 Jun 2026 06:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="v/PNqA1x";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C247D10E5BF
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:10:04 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I38gGB1651658
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=; b=v/PNqA1xBXvG
 hxasA0LzJ8yq94mP/vLG9ehEDNugAO22PhggvV4w6bqGrDNdz+I5GVtpeVimerEm
 uQBbADRTqFkt4j39n2wuBQO0TJMx0k/Ngsr/XypO3PKVRwiKmvh4Fej+Aga7MC9b
 SW5npdoy0mfJQ2gKUZm2NjxDs+U6T2IMmgYmFXjYTvdZIOpbnaLPBLLnoXNEvfc7
 iabwsALTLrmBCaTpNjhGZBs9JP2hcI6hMQgOEm5TRf/VAIkH5wj2q3y76PUcwfDQ
 7Jhe6K6dHnRe/0Myi50bJqPCe/2OBqPV5juk7YchPYXVwYkfOdTu4kMRyv7cWYYL
 TS+Mvy0faQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg8swfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:04 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6cea6ada5so1365936a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763003; cv=none;
 d=google.com; s=arc-20240605;
 b=eBvrJjNHxM+jfDLby/xNfpEPuw6nC5FTBkhv6ECSXy4UtJD4Py+Elw+UXB80+HBGrS
 KkNXM99wGgOUh606uSsj3uex2IH6Oe1/NXJRAZB/j6ZzokmIfr5LtInJuaCNgkrfF5Nk
 7O/lBk5nTTbZfAa9WvENxicwgdFDpP6gBODUUoShtyxTzwrMin1Iy12VUgBkfK3v673Y
 5rhcwZe72RUMuZMnP8Bu0qBcrTUtmwKYzyjpLaHTgQh+YLDMxSISDQ06aP55pAq+3Hn6
 8rysgAyoc+86otMHAPzxEqUQNt7L1M6t2mCLIhF7c64ZElUzQ6pAN/JXWm6Txknk4Du9
 fiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
 fh=kcudhKi9kcUmLuahsPW2Pxrop1P0aJkAS+sJBBXKw3c=;
 b=fdFUD1qt8DzkfUeWOyucMDBIETljItUV/zWg67CgehaMOkKET0VK9jIMgITt17PUWC
 KuHTYC+y66GhbJJROIRPYI/zkSJOkQ3NogiT223eNja1w2n8wtjL8moIptXKoCIJL5YJ
 /USNLLcRq0pKsxOIOLFsRR+WNi24rCTuATlFoq7MqHcFIF3AYkZwJE4sZnV4zJhcQgYN
 rk5WjZo9KzaOQYFhJauyHjGakYJsEkENghcV3eTC91TcP6DSJ56ShuYZeIJ9VtAQo5MX
 j/fZfOG1TlMYvJ69x29NY78UqrkglF/SunBBIREuEeEVzQIAFmqYYxDc23UaKWdZTwbs
 +tNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781763003; x=1782367803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
 b=Pm14h8Mj1n6kCLUDaqAvrCthDVxTpBgmEiTTnRH2pZMVGnyaG4AckL6tH+0CdcEgXM
 TW0wWY5NUyXU07x0XF7JlhtAXwabnXDCIaz+HNg8LFAia/D5yw/am3pwzsb6rIKYzAS5
 24F9veY3Lg5T2WNF5f4LyWynCWopqN7lN5STOMw3M+nAk/NzczVFBQ5I3yVozthAOLYc
 Yyu9bpk42evHzcnMc/BNq9E5ulx/789ki7Geh93MkFGjVehMZjWH/bU+Dwkq4C2DrRa4
 gTYtWOW10bp/hw1AQWSlqvZo/52OqAVRf5IxFRrZ6W7nJNuv7GVHbbn08hntgRYxI37w
 0bhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XRwe341+I3cmudfYrppUIUT9aGsGvY3X3H2OlNyQiPLt00WvOf2ot5BwaClPLaXyc8LSEabLbxq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxmLMf7qMlLSTuH0BSYl81Eyh12laDj0QO5ug+rc+FJ7ffhCYs
 gnUK48COl/hp8hM2BiNc1OTrlzXP8C+JX01VQkM+MIlkihNqQNhx786+V+i/4cy4LZH6grrkK4H
 Mfj5K2EPmTa/af7kwrSfrJ+mb2R85H8EkwJZy3niOFjr2YsmdEF0uIW8ir8ezMX1zIJ+wBNBCFD
 G2KPJfGNP4ESCO1TU5/J5E5wV62uAlxL6BQBbjBdqeVxM=
X-Gm-Gg: Acq92OGBlVQattRYhv8ZnE7cnGKmyJN78HZ5GMMjIfquIrL8IyjOyIhTTpKNyfRaffQ
 t2AdtgrccSGMhXFFV1mDh/TReiX11sL06HncrZhThUoJiir7TSUt8Bc4bj2dnwWt7Pt+tUKvJmF
 8QfKA4Cy51bMAzIIHfT4oteaA/EjD6wS7pQ1IECm31XbRmOXZFg1LyrciR+AvcoY5Hyq6tg0wb+
 pSDKM4LxjmglLhg3ek9xHXvlnZOhQ==
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e90b3b9930mr6882340a34.12.1781763003196; 
 Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e90b3b9930mr6882279a34.12.1781763001909; Wed, 17 Jun 2026
 23:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com>
 <20260615065912.2177918-5-zhipingz@meta.com>
 <20260617092550.GT327369@unreal>
In-Reply-To: <20260617092550.GT327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:09:49 -0700
X-Gm-Features: AVVi8Cd9LqQxIAml-YNLrnCpxwyq6SYcSY7qEQ2JpeKmDJHK_hh3DSp6GvPOQmk
Message-ID: <CAH3zFs3xfc5k0fhgedCpNAfgfoAvfk0V2pF-xqA1_Q2sGkLnig@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dHinZtZ_hInMAt44HE90t2LUniiCbEbH
X-Proofpoint-ORIG-GUID: dHinZtZ_hInMAt44HE90t2LUniiCbEbH
X-Authority-Analysis: v=2.4 cv=LaoMLDfi c=1 sm=1 tr=0 ts=6a338bbc cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=wthcJ2XvByERRjf4MtwA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX0HNI0Vo6PHFc
 Ywv7JV1PyiR92rNl8sUFmNfbTIeLoKxegDUSkpZyn2KElPmI4cWpFAisPY0t5Ryq01NhZsrAke7
 GUzMvbMo36E0wiOTu29iXfuDAqiRVuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX9Gy5U15yjP1A
 0aqxMBQBY9dz7DasS2CqsRRtpkVUAaFmBaPXL9LKQ4T0iOjuD0euuaAlg6zHnaV5z2D8JHyPoWP
 9CnNGYUbt5J5xpxiQSbVc8dMWW+vpRy5Yekyh7UOrrDwTZIrF3tSHxI1NEgbHrSf7mS+Lg2E+dP
 yK2VRaHvBTc6srSo1oEuvL9CaMAwuyNYSRV+U4cfOpjsQwwOkWZksBTqgG86XjYuWt7WU7gkH1G
 2FYeRLY2TqlmZCCkMSC1Eoo3TGy3UCTj6Leni9n8FyF8AJ8uvNt2DGU2dfkGQG4yRyyWnVZVGCY
 80RHeXqYyqJJQYT54qIPqNEQmi3PAUMZDFeWThpC3UFsATX+FzwizZ4ZzmQbPFdwvppPwujT8IL
 0MjE5YquDqcYpOiyuNc/eY2m3wb5BoTPxsSv7jBuYnLVpfI6tSviKz9c3vA2D775Tx+PGv3BvAy
 RCvHpETK3KXiGQmol+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
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

On Wed, Jun 17, 2026 at 2:25=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> > Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> > peer-to-peer access to a PCIe endpoint and use it to program
> > requester-side TPH on the outbound mkey. If the exporter has no
> > metadata, fall back to the existing no-TPH path.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool core
> > unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
>
> The commit message explains *what* the patch does, but it lacks context on
> *why* the change is needed. The 'what' is mostly clear from reading the c=
ode;
> the important part missing here is the rationale behind the change.
>
> Thanks

Noted, will change the msg in the next version.

Thanks,
Zhiping
