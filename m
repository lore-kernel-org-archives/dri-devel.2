Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2B2CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A79A10F1B1;
	Thu, 11 Jun 2026 23:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="C/D5WLO0";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0F810F1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 23:45:54 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BBinPe099437
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=; b=C/D5WLO0mmbA
 Ud0JqF5B+NiRYogOXFY27nmYpBJEirm9IRllvwozXjgx8OIFD5ZV8faeqTA3bkPS
 QQWZkebPb05AEUyMH8P16H5UX/fEBtNpeSpSliXT4oXjzyno6ILLCxFInu9/96z5
 1EJj/KLr2YVNpfd/nUoJ5mhagh5nM7sa5TvPfzFUJ71l8C1p7W0tPydae6CxTcqV
 tYwT6puC45+P6mMcS1ezBsA7Os1dhZQGhyxQyH3i47tvMD+VBY2zLGJ1L2IC/Muy
 9fS62yBoiRy7/k9VAoZ+zz+a3YlY8q3mXa4pSOy8Nssbs4fwqZWQUMQUW7GP/2Hm
 q3IRLexocQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7b9ja7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6cea6ada5so910869a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781221553; cv=none;
 d=google.com; s=arc-20240605;
 b=hRwciYWJjuXXickhvbOwCt8YzPnH/Z4vaazrYUW6FC4EAaD03LfLKxVI201FtV67OR
 qJrug+Stai2CV0tjSOgFYzEuUUhe9XEVKyQnxkmNHYUUeE0m9N72GRXhNJW0wH/aOx7R
 CA8chssxNR5iF5q9A4vcT+ZfnmDKa4R6hiZ/bI9qk94mfEFTbejR7dJ6a9mUqBldPCO7
 al1k1bSla/jmyJK/EntS8tGyVwsQ3cv9JdqA/08Yl6LKdJ8sNnIdqZewG9x3VCN0ejBX
 NKBYv9Z4Q22qJalmgWO2XbsUpt1bnAzqpRHcvoLL0on0dlEJ/XJynjHBB3WDdXOTWseA
 sYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
 fh=MV6E9/3kJdZ4kMZwz3aRtrKU3jgRe3sVS4yrb4n3I5A=;
 b=ELDs7J7+yC8t7PDhVaox9nsHu2ocSXQzQMecjtC85uwKLIkhiEenvnlxVU5JPuUXFt
 i7O3Upc5YzHrO5H35YyehNbBhXTK3KggM4OYaqDkJD6/yGUymsySQMW/hrrOXFn5qS45
 GEr5buG7+RuJATo3oHH3q+E2oRQ2v7Zis+01EsLIApUwM5jq5gg076Eu+bmi+XQm2th8
 J1NxfVMUyG4fRJeppk1gotRI2Lb/YgpBVu3kOHFsqotdyFQrEoG2840x6r8fadqPRs/v
 XLcB5PjmRTkaJ8rKklJq/gekMtV26l3dB0XbB0SvsKmk6SK00A4qpJydga+voVtc8zBP
 hDEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781221553; x=1781826353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
 b=QTyjFBfTs2zCt7zf8makTpwuuUrp+/2zqLT4Fq784K7LkS8Y6Q9ihSpTPpLHEzsTqN
 sg8L6kpLUpygtCd1QTlHpthvjGa8zon1mKGN3xvbciHehRBmNP0aAU2gWEpufQqA6mqs
 AaVfKogDJerJsBFrIjB5OMlewvfiLuItrx3kD8hG3TfqhLQm/tFn0EwkYo+Ogwxq2BzI
 +gIXEUrerZg23l5o6uUh3oQbeXm2Wwai3hVfej2skIKEcDh5MuoUuEFIC3CoNz6r90ZB
 SoOjMgmBGQ2/B/R3GVSGV2vqqEoDMGzyddP2+wwGgBwCuX4KmsTmOTNisjjJKfoJTaEI
 +gTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gKS34ew8nvOn4jpNbnSO81PvaLwZENwWoSGC7bAQc2ZblfBEjhYRT/TXiBgLL+Vp0hIg7FMwf1Gc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyThZ+k/7GKxWOywJbo1EusuQeOLiOj896qjy/YO18RFxRriPS
 3iezvDLhJ1aa7S9o7SGgEHrbbgHw+UXlu85uvNzg2wh66ctL+R2T3b4G8P8a14shIB8vD7a5nU2
 hKBXWdmpCAaJ3Y9kzi5U3Hm9Ze9M2bhrlElBB/0k558SaoJNbT6b4V1dawPxJF5Dc066vf0zQFw
 XUTykwjyluIgf1cMxv5CGIe8/ndcqBE9jg86PfzBRS240=
X-Gm-Gg: Acq92OGvLnmohbahLBjd/Mhdh+oh6GJe9HAs3cjf3jXmovkuH0f8Aa9M+GPrAnNDw9o
 bMpUfxV80ppcml66Dt70h9GCDtH4/K25FMndQBl6hREWVA/K6pAEHL06EVyv/elgKLYmCZ+pjad
 puOrJwregnJFQb1zlpQtGZRwOZf7bMhZITjIqfIPY7hx1y+0i3fOF80oKeMb3QPTs08GccBX52X
 +b6zI9WbCzdULZB4N/cjw==
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152174a34.20.1781221553600; 
 Thu, 11 Jun 2026 16:45:53 -0700 (PDT)
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152160a34.20.1781221553208; Thu, 11 Jun 2026
 16:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
 <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
In-Reply-To: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:45:41 -0700
X-Gm-Features: AVVi8Cfn8yu04sl-GzuR397tWS6RCJ76opDbk_4XDQqGmuG536f9nq5T-lNoRa0
Message-ID: <CAH3zFs21OjkJtYKSqV5rjnEqOU=221LQLY2qXo9pMb79kRSQgQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX0UQkjHC8b0aR
 XSxbEMBE+EHsN5IK3hlxgQ3Cicb34dfTwNx4cPSKIBpiagJZrD68u8Y3oG/q16OB+vpp+Ct1Ubq
 +0rZs5n1Af199NtLTH7JTIjtPXpurns=
X-Proofpoint-ORIG-GUID: XPNp0jieO9XSoL7GUHQwTkeJMyMCYumw
X-Authority-Analysis: v=2.4 cv=FOIrAeos c=1 sm=1 tr=0 ts=6a2b48b2 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=iziE14hG8lcdKKJlCxoA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX65PPDcNAPgXh
 VqQRiNRvgojVh4/oATaoIqxPwb8l5zLCxR7MWhJpI6jrbw2HVAQFLkkmK9CzfyWgdMXbtjQsXmE
 ROY8gO/llMPbQ6asUSYYI9dI1UOPljZ5Tq4lLqqWeZNQUtCTyycryAooiFriKK8i4hKKW675Cst
 iXhL0KI6bWcFC9KrXX2qRZKjJA49YcLmSbx/1B5xKO6bFWQQNfh84ApDcYNeUHuhyAO48ORcctm
 ZVmVkj3axXNCvQxeu/STVzxadFpzwXA2Nz5yOeCXUGlDIdAiGFJ12ouWPSiR6E4hP7mPGlaFO6l
 fivPuNX0IftpegQAekCricg+2J5436ydpSgO/AE67LWouOu4DfgwtI44rz88cmLB6H7c0HCEvU2
 3hZ3kdAXBAAHzdpqcajrVVuLEx6DzuGb7VX+vKulingMAFAS+jgYT5GZTcZ7CEb9hI0UyfLuM3w
 Do5ECumHWGnvVw+WZLg==
X-Proofpoint-GUID: XPNp0jieO9XSoL7GUHQwTkeJMyMCYumw
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

On Thu, Jun 11, 2026 at 3:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > > >
> > On 6/10/26 21:31, Zhiping Zhang wrote:
> > > When the last reference to an ST table entry is dropped,
> > > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > > therefore accumulate one struct mlx5_st_idx_data per cycle.
> > >
> > > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > > struct matches the lifetime of the ST entry it tracks.
> > >
> > > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > Since this is an obvious bug fix I think it shouldn't be part of this p=
atch set and go upstream completely independent.
> >
> > Regards,
> > Christian.
> >
>
> Sure, Michael replied that he has made a patch to fix it, i will rebase o=
n top.

Never mind, it seems Michael's patch did not contain the fix, let me
submit a separate set.

Thanks,
Zhiping
