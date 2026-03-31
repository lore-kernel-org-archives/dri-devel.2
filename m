Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD12E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303F310F411;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="NgpBhtFm";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8248610E270
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:24:24 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ULIC9K3706628
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=; b=NgpBhtFmItDM
 CNbcwb/E9DkdCKHJ/+HXG5nYnUCSAGdnK0J1DywzsfubqT3zoyDOiorROwlve6f5
 Fabj2p7OS4l9/vDda/nt1iaWFhmj/dD7ikbmlCSU9C3dxHoD/BW1829WKG1gSNUo
 bvhspgCJNM7QlFoJ6rz3LBSz57IF68o48IZ5V4B4vXaE0cFVG0Wx1twzhAphguZA
 x2QO4KynACOL7v8zMEgjTg34ybae8h4kqqcSIVWunaNwvXNvzVjB0rqBMikZSh7r
 g5YEFzd1SPUtzJOBJK+aZ0ehLdWWfxZnd/kXQFeHL1MALxrPKcsgO9HqIAQQZ7ex
 Zwkn3t7Umw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d6y3rna43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:24:23 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-41c08879ba3so24581791fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774970663; cv=none;
 d=google.com; s=arc-20240605;
 b=ZjdL7JZdLqFArM1J+dJ4wA0dmlayuV5ggLckO2V3TnKN6XmLtwAhTfzmvbMHXbMRAU
 KBAgIjlIAYl2fzJfSarxJDHC6sH0OOwiVfnh6fgUBao4pdRcuklUEIvANkfIRr3O04ZM
 mLjnz+6fqSDmDbs73/8rWhCimgd2C5sN5ZVZYinDGheqZG53EtubM2z5+pVRjs4ulAc8
 KieQPWxup2d9lKhkzhGYwV9NCRyqlL/jYmbzvtyKsU3dTYQdrLQBdBYWrVr6S69+neHP
 3IkEswZrGyFXR//JbgEHpy+rudSaZvLPYFecZ0RSEN81DDxyaoF7aWLiA/yElChDh7ca
 rKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=;
 fh=fs6hsuJqUymRFaY68g7SrM82h8LW2Y21oYfBcRALuQc=;
 b=NKYXU7K/LpG9k93CHUU2sHG6MIDqK4vsV3RLhU3az+5srzPwZm6dUC+ff6I9VU2tig
 vSuENNvw2IvQz4zwU858KqXz/SmK7rjSZQIuzhS60ISMXSlqWxIcQQIsx1heBIVoKF5E
 WQnW8zu6XtkBAA2wOVkKNmc1BDALz4VWSpoWPlrusMbzcZlU0p9XfNFXumVmqhdlw348
 hWCVEWB95iMqab7PYIfpJjH97/1i1o7ygmGqYhOWdXCRPkzYovRHSmibBlPd6MsHOYF9
 xkGi+uCJC+Y4uXMPj5J1pSdXmtpbYySB8NYwQ5W6Fjv9xQ/g5nA0SQ7YBO0OV23mkF9m
 rIag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774970663; x=1775575463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVzD9RZ8DOj+OZScnURt3JaaKOoh5Y6w5keNNJrEDEk=;
 b=Y4QWiYmT/6xBqsWASvqGXhqvJNrREmYHJXBxjEhTAF85zmgLICE5bFKNHsw82OQOsH
 /9cAsRMvuNVKcBj4p2+OvYBMUvXjqXGxWD9EFLQZhgAKxQEw/FNem/DbmwKTAP/UFymD
 rePuojr4vrxZsYZiCxAxVu8KDPwesZ/flmHQpRliAnyEpIOQwsV41XA4L7qrgU4lzC6P
 c4trVG3jogKzxMWHVN1njbR9SFT4MsLzJ3rD6NNccZCC7T/MH+lJ9dLYTzL7W2Pu1lXo
 seCs2xcc6su0n/h+LKiNUVf/BdsajXWKQwVHfLY8giKkecVRA2hdVkT52CfVB6Y1G/5I
 5wGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVlB2noYsNGCtPtJGFXpY/3SYQEx38LOf/DWxCFRKE5B631LhddMvRHDqTWe+Qnb/7WjL3nQBwVJQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNn5sXv3JhLfr5OAMPdeiss9mV1h2aXegBdm2QDM4kSkT++Ee8
 fpkwShSdQUSCQ6G2aNmL2b88YLMCAeGdMkvBBN5zxnv2VEmLmEEkD8B8Qj0SjUgQS14aSNnwnMJ
 C6Sy+RyURFDICRp/u261T0EICSl6MUwFvkDq3Z8wdpmepj3x7c3tCxiX1pGbzSCeYO2v8VUtjDa
 QwGpj2kWQlO1LEosqVRomDVsC6zGESA7Z/a4To4PSkK6I=
X-Gm-Gg: ATEYQzwGBVqMCiOQoDpG9hfBnnE5cIEe4gV1UuvrhGSa+7o3O5n7sV5IeOWKYZ/oTUR
 KkLqOgL4O7XUPdqCYiofCTH+w+83+Bj6yL2hvKr8VZg9jKftwUBVYG+ZkvxifmsQoR0G+SrZBpq
 jfmY4Mr5CY7Ma9GOQMtAYJztv4xBWmiLJof0BXE67UmRqjiRT/oubSqtfXOueDJA==
X-Received: by 2002:a05:6820:2901:b0:67f:31e3:81a with SMTP id
 006d021491bc7-67f31e31008mr367469eaf.2.1774970662812; 
 Tue, 31 Mar 2026 08:24:22 -0700 (PDT)
X-Received: by 2002:a05:6820:2901:b0:67f:31e3:81a with SMTP id
 006d021491bc7-67f31e31008mr367434eaf.2.1774970662327; Tue, 31 Mar 2026
 08:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260312184613.3710705-1-mattev@meta.com>
 <20260312184613.3710705-10-mattev@meta.com>
 <20260330133336.GT310919@nvidia.com>
In-Reply-To: <20260330133336.GT310919@nvidia.com>
From: Matt Evans <mattev@meta.com>
Date: Tue, 31 Mar 2026 16:24:11 +0100
X-Gm-Features: AQROBzBjz_Oa24Ou_FBmQkKdtClzBrzQA9IDx3XIRw5UCOwDpX9lbYyqY3Y5W8c
Message-ID: <CAFzAbJHqnuV2vA-LPQy3xo1KesLUxJOCtS4FigsaZtaZEi19jQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 09/10] vfio/pci: Add mmap() attributes to DMABUF
 feature
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0OCBTYWx0ZWRfXxBZjxJ7v3IQY
 X2qtC+s0BEKosMfuXlLbnNmSo1vyk01d66Ga7PVeXmXhLJMRIJuAm7cuSU46Qg3obJZ0aSYo+oy
 lFUJb/dJLcgivCky5MNQRTivrsle1P9mvoqSGBa6zfbfT3ronMuBa56Nl0PMRD+OTBM4fsgALsg
 3D7NC0TBo/AE7JP6YkFkPT37BDOtfGBcBYOC6wA5mYhOAFF/TuQsbDPQz5b9t3o6118d32790vd
 wQud0hg9dovqTQax32YlcXYk0TP0duRJbfzVp8aUN7PdZkqDd1oSy9UAmfEyTqlvbf/hPMgDIko
 lXE6NsLz2yHD/eNz5bgNOFwuxfvA3/hrRwQg/dZufJUE2tXGfXeaqa2pr/BXxvi085Flvxet+1V
 PpRIUS+Sd4rr29jjiC7qvQbX9QFNHjjp+8Yl7r3xvVDYIFPDhtFp2uWbHmCoHfCRZsJl+AtJl2Y
 ZjCRxMYayAGUIdODTPA==
X-Proofpoint-GUID: mkG-4Z15iKp53-ecEjefi8W3iey-y34F
X-Proofpoint-ORIG-GUID: mkG-4Z15iKp53-ecEjefi8W3iey-y34F
X-Authority-Analysis: v=2.4 cv=f/5FxeyM c=1 sm=1 tr=0 ts=69cbe727 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=Ikd4Dj_1AAAA:8 a=scxTcjKw9OI2Du0FDOwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

HI Jason,

On Mon, Mar 30, 2026 at 2:33=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 11:46:07AM -0700, Matt Evans wrote:
> > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > request CPU-facing memory type attributes for mmap()s of the buffer.
> > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > PTEs for the DMABUF's BAR region.
>
> This seems very straightforward, I like it
>
> Did I get it right that the idea is the user would request a dmabuf
> with these flags and then mmap the dmabuf?

Right, export it with a requested attribute (as possibly some
sub-slice(s) of a larger BAR if you like) and then map it (no
attributes need to be specified at mmap() time).

Thanks,

Matt
