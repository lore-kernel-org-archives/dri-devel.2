Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E5CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640BA10F1C4;
	Thu, 11 Jun 2026 23:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="USTVjs2G";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACE110F1C4
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 23:09:38 +0000 (UTC)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BLL2bH3853575
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=; b=USTVjs2GSY6c
 zWNomSf5E8qjahkAqgjmiQDPFbjEPZsjQeJ/b94zb0GF9NeM8mlmXX9Gk+kwYdrj
 cTftYVPuOSFB/1Nr+8gqaK6p3IfQ3KYjnHVtCfJwHBjSmm33QENUybqoFyJiQ/fu
 n4EJcipp1CqI7B0zNUDMYv+OiLaw5YrOS8y/AuI2CPHIovD+hq3X3/vXm3tTqiTy
 HHxPhprLBQNWDBST0hkTSIsZqY1y3fvMFa5eDd8O3gaW+GcwgHrjI92X6wE8vhNV
 AHzq3kcWmOiBGIroHAC2qW3JwOJCgC75sMNCqZsKh1VQyolLrORLN0mB76o4eHEv
 +bQz7LwmGQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7e1r8j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b550a521so464537a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219376; cv=none;
 d=google.com; s=arc-20240605;
 b=ez8rhKpZk8WQua0iLEEPhP6AkrSuxNiyzzYFqbFTmgvI4EcuNKuSVbe74qlUze8MlE
 krKCvfhEn3zC8PWBWbEvXxYXqpE6ng+Uemr0nuU8t/VbzveoniFJM/K2hULT+azptE1j
 oGwp6a/fe3tnv2hPfd2ha3EEKN0bctCRKBkbBktGiddv5xME3njCSPVdJUwoZxZ2vWB4
 dC5+PXwav9BA6vSfmPCKhrl8X4eoel8i2ZUqtg7d6Cp3QFVRA0QXUpUGhrqUIZLbdvDA
 FDfhdS3bX/7FW4auQXl2wkDEVL7AsCqqrvvr/oDtz86nicnfjJ8LNGw5DvTyzz7ykWjT
 szpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
 fh=7TWByguqzy5Sew/+sXSvJMpMnnxQE2Kt1yxVNT6clUY=;
 b=hhkQ87yuoOjM+lRLmqBadYQPOGswd/rN6jlvB6ly/RzDdmGOcETSIHPwsCI8Hdm/b7
 kieUnDkcCyhpGcgeRt5hTBhs+T9YL+BIWuo3GHmtmBYNa4ezKU8d+BPdkk3nBehL0t/J
 TP9FMv3vIl1oS5EmZ7pjcWaTL9bQyAcmpqiDlnwUeMof4f9z+gF20rNU0QjNgWKbqhJ4
 q4ei8p/ABVyl19aGotbU2S/IQdaV/yQVWKMtfWt0QtxhvvFHQUX0y88aaAKaBTIXT0Kr
 znTm14PXAV48rwZmOAfowJRETiLrSDlOQh50cZP3lbwxTSf0foGsKSZwLtjMeiGKi0f/
 KkCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781219376; x=1781824176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
 b=ccmPvBv8u7aTYnzlrhVRQz2j/rVLGW7xAOp4Jy7rQBPj4wbeoEbjt2fI6U0Q/PiFt2
 3IUdenqrt8ggamJ1jQpE4ORSY/Ybn5n3zdy35ikSo5eEH4ffYn/68ywFJXmBQseyeEsQ
 rxuxIVWlO3q2jZ5kxwU7ndy/Ugg5gR239g1A7TquUf7C38swHbAISQCWFgBvacB8Fnc3
 /dguKu9J7HlV3XmXdw3ZRbwOR0QZRWrF0CDGcscXxkNkAnZb4tzSgaH9QFquyrKFStev
 azJxME0Xc0iOQuSdkH2QDt5gRs+LvqTpHnTVlhKghIJZJRXG6/EJ5ZyipPr/LALg5i+6
 8Chg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fx34h19KzZB2Mk+Dsd5kotXu/KnTkZAa7tJGYOsiTixab42pOWddrBuF9mnx9LwtzZ/AFkT6kPKQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY/1sV2hfooBJudtROHirf2Ue5nC+IgwN3fYfyUKhzaAvGZtm5
 k+iXb+0P7lfzrI5r3rqwh2yM1Oh9aKq3XxEsEWWuG9oK3gwCWB7R+Wwfq/OP6GVoF9ktVuwWafd
 A0Stb9d+wOOgqJKhK/OzNa5rKp3M7RSezLC2yYN6719d8Q8yEZga6nw51Vf8KBlueUotoI0+Giz
 VPuS1A7zqg4XEbuHrIg35CMaGHzj2U3ZuJc6JRWKEnsv8=
X-Gm-Gg: Acq92OFqLALAP88MW6+0xoXoWPkR7kZEtQ5O8M+fT7qFPpHL0VNH1c8oicAK/wKVwM6
 l61mCn2YJX1yMLFCCZ8fGXj87J/is3eGAWV0o/KHhPmVx9ISyw/uQeX9UiU8+DW8FdBmbjLekv9
 CdWIkbe+H2TqST7WKyiiKJs+vt+uEIdCnzf0w7y0FbmHXIzgYXW/PwgzYgRwTFyKmmw4ohs+3OQ
 HQTnBDXfUreD6i66jk2NA==
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120369a34.16.1781219376574; 
 Thu, 11 Jun 2026 16:09:36 -0700 (PDT)
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120344a34.16.1781219376083; Thu, 11 Jun 2026
 16:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-6-zhipingz@meta.com>
 <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
In-Reply-To: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:09:25 -0700
X-Gm-Features: AVVi8CeB8nmACAn2v-1nCwadZsgAxPl-ide5TeaDE88hJZn8TEKcdfaG5LmdPSE
Message-ID: <CAH3zFs3ngOXvA5DRzur-_gQ2e0N+-3Az2KmwxZTYczqw34n_Xw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 08naCtuWX2kTfH_xG9pSXZqNx5YRssZ4
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a2b4031 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=Ikd4Dj_1AAAA:8 a=G2Tmg7Ww-o-apaxFWtcA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: 08naCtuWX2kTfH_xG9pSXZqNx5YRssZ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX/klRYLaSjQxT
 BizsfpIkX4lRq4+So2T5sTf4hGzsljM7ZxH2B+N8XMaYOhhVJX4ypPoDpyP5VNtVIu2e86F+sDJ
 buhic3dloYKEEk+wMg9OHL7+mysnpmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX9XKWbJvO/Bcp
 PdNo5yo/Tshd93fotlBG1qr3DW4FW1+WgEyq6qObGHgAN1gtH2x7xPPCSf7kJ02oEO0XQ2PQQRS
 lo+MC36Q7DKEb21ac0+u4mvPKC4Jecns8V+JP/XjrJB4jMLHjPpu1T7a5oHqq3wJpenifGM9Dh8
 7fzD821/71v+ZDxdMXujTLjb22rmzzZ6FgDQBcA8V2csyHkG5zvecXcn4foM9L7lBdBxinL+0yn
 c+q6xSYcBFg3t3tqcE7jmCPJ41h7Y33E00Q2DokN2QpN5CnfFKRdB2bbstrPUX8qpfj6R6VZk6D
 hsF4Led+tFeySxPnaJAo78UrzUing7mq4gQkWWAfAhsk2JYmyhfmxhB83IM1wPQwG97iZQePuZ/
 IafYBM+twmldj5/9nUXu0sbiCQJLrJJCDLdBshkfYfBe3dTV8uZyxUQUiQtLMjYnQCsGM0WjqgS
 BgA7nJFe4zkGnuj7TMg==
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

On Thu, Jun 11, 2026 at 5:44=E2=80=AFAM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access to a PCIe endpoint and use it to program requester-side TPH
> > on the outbound mkey. If the exporter has no metadata, fall back to the
> > existing no-TPH path.
> >
> > For TPH-backed FRMRs, make the extra ST-table reference belong to the
> > hardware mkey handle rather than the transient MR object. Extend the
> > FRMR pool API so reuse and final destroy can transfer and drop that ref
> > at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> > a ref on an already-known ST index.
> I'd keep the ST reference tied to MRs, where the ST is actually in use.
> There's no functional need to couple ST refcounting to mkey lifetime.
> Once an MR is destroyed and its mkey revoked, the mkey can no longer
> generate traffic, it's just an idle entry in the FRMR pool waiting to be
> aged out or reused.
> This lets us drop all FRMR pool changes from this patch and keep a
> simple flow of 'acquire on MR create, release on MR destroy'.
> > Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> > the requester hint matches the pool key.
> I've fixed that in a series I've sent earlier this week, please rebase
> next version on top of it.
>
> Thanks,
> Michael

ack, thanks!
