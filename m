Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD64C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C6710E37C;
	Thu, 16 Jul 2026 20:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="BeR11qvm";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB2610E37C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:11:11 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJohXh4011904
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=FmELQBnFhyva8tqlkEZm6vsX9KbwpXPdoDW/5vArsKs=; b=BeR11qvmnnNI
 DzI/KcfGXkxY1JZELI8FYHdPO9IXUhqdHYrWC8lX59Hu2MJ0ZHd4AsNG2hgDGQpG
 IHT6XH5Qlfcp5OP6jzCLd5FvYJglbau8ApcPoD8Xz8kK/fSxfdjJ8AN8toSgqmVe
 v5wge45nB//G/3uFGquRWqSQUTJvOt53gIka1wnS/2dOzX9ajVcld2KKhTTJDgb2
 HLYpsvHpWstKTDtQXwYKzP+utDzERk+q65fDYWCP+ttjXMpPWN/GGjFizYxN52+n
 0G14OHlgtzgd5o2++cURe6sCIkND9KFf2CJXFvIJACRpxYjoKeFIkldXMd9VvGym
 8BWJjHisZA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ff4h48mma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9dee2f7b5so4792931a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232670; cv=none;
 d=google.com; s=arc-20260327;
 b=ftmGMtWJ3kDSIKHVQMawSd8JndHY2tf8oVWJsQsKwfMiFV2K+KfnDJADUKreCkXguZ
 MK9f1933aVWgSWqSIDBMsnJtcs2CJ7LOyoybkI4cYsd1Z4U6voJryMaCCzQD2oGoPvTS
 JmBz/xlDdtYbqKcyjLfg+Juzzyezt4nS/tEk9sJwuPUeUuJLqTLVW2qQr1ATtacKeQrK
 AFuwgDh226eQfyF9WzMJr7+3PwNL/F+VbfnuiT0/2ZneEJ5HKER6ID8ACMB6ABJ/OAF7
 GsCl/XqIedbdJGvL2asDYcvPwCrnE44pDwWgzM6wrEuqxTrOH2+FibsKibjKjye+g5ZD
 c1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
 fh=Hs7zZ06jiOIWpp+xI/agTzC9FugXYqg6BLdiJKHO0eA=;
 b=YagjyQjkpkYDG3wtkLF09R659UpzKuoRwaR9zmhmGm9LbOg6H27R29GnnbHwviQl0/
 LDEQcZ+MGQSjXJCpyFn7yKS5LX27fwyqiUd9ab78FvsyQlUkUvbNkRwi6mbUNtyAxjls
 x6tau9FEf1fKpY0DGdryZc7ChLdSHOu8D+w7+Ms9tjRvoPxvawsQNQqV8ZzsUaClQOU3
 Gn+YE8yezkY+rI3KTY1GZwULjbaDBxV5/oEhTOOR6BSU/TUVUHcXVTs9jHTnUepJ0Lrm
 QjZZuTrbH9l4dkrQRSgQlFFfHIgZhUbTn92TBwUmvo3dW7Qp7ALWrNX4wHqNNWm271Yy
 2G4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232670; x=1784837470;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
 b=PN/+LTJg0uhBYsKOzhhknEpmJfS/fAUlcxZIo87dp5fw/x9LITPlzpwofPXvXajbcv
 /aVoGXUe1rb/wO601uLAVYSCNoWp2EAlSb3/uVRXeyuTQK4fvCvfj0akA6OBImO6oNa/
 vW9bwvoNSg2GdJyFz1xhOmdJ7tzT+R0Jm9GDDcUpbMykCwjkKZnINxhfmERKDoiIZYjf
 w/BVIkSY7UOsLzzry4a/l59HOmKzPsIjaKAkICLtP4xRAFzLm7U9Wy913a6g20qNxI58
 UjQlySmKN92Zp9PQKGWKH8hKV2fVm1cvG9OosNgee5evO3hudjvH/4Nquqm1azSMFzht
 YXRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSTPNs1ENUTogmoyR0chqv1vepteguE6+HGziDpBNjbgE91hLyvIyOhRpcyQFJixld9K43055DqQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEp7Jn1OPXYuTjj6wRkKGHX4SA3TkSAIOfvXuHXcefUj22eyem
 sT6N6piJ/gkzNPSEkL8EAyT8aFH8nesWXdgqy4qy/c8sH6+/z+AR4E1FB1qP7aEzzgQ++XdldEZ
 y2TAeQzn3J6C5YzZveFFo9wNohoznFXPobtGiQLj9OD3eXItUe8rVYNTUsT3donZlil2zzFMRT8
 gadZkC3M9B8/Q3DdP+T2h6M4CKN4c5ddvymKN6xu9XLEM=
X-Gm-Gg: AfdE7cnhbJ/8u7b34CmU3s9FihlIvEEvfBYkXKPM9mbHQqLAMh3yueIhp80T69o74LP
 vxhKd69VBk8NLfPDedoGHplKiR2fa8X/pPDBNKEK5evxFZHFNnbmaC/pWUNoJtN7Bl/dJezUXff
 BxEImv4CgJcByoRnAZqzsh5auWwun1LEQCRIx2xUnaxCTj7IjfTJmwyG1cdPcunpszKdUc23iiy
 Kg/nJE/QDmY8NO605U=
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7ec97340ddamr801705a34.5.1784232670076; 
 Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7ec97340ddamr801684a34.5.1784232669654; Thu, 16 Jul 2026
 13:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
 <20260716144708.GD210048@ziepe.ca>
In-Reply-To: <20260716144708.GD210048@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:10:58 -0700
X-Gm-Features: AUfX_myheEIlUGdSHFK_vqkE1hm0qjp53c8YkJwDa1cVW2p7StXgd-p-wIuQhRA
Message-ID: <CAH3zFs2fLC5GodysR9_QhFMb169DjtsNFnfBeO9MPk9S=DLcfA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>, 
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX2Y33jB8dY8N7
 YNz/YzuK3RkgmmCKGUAs9wQAD2uwfyyBa8EeyfyZWjxpnWwThdguIvjDBVUOcUGdc3dxQNICpPM
 IBInP5pTLLiCIq/q/uPXnT2PUUyz6sPopGPnBM8MvhqiDVPzznMvpCsMaPrQFw7jcLCzla1NfC9
 SxL242LnC9dDVUHzAIQizcqSZYTXJDWobEjUyhWD4YXKfQtTViqr9WCtSVREINe0c4gIjouqOw1
 90YVOyi4fgDnqylt5uJbZE70eSDg6YbDuXkybuSg9/r28ZV8pAf4dNKb5jjZaI8QQCua/Wkdh8H
 /UtHoqb+/9NXEURKECrQRh8EVnoznUOzquWQ3nb1hOkt8bGbozjRt8a7hPESR6b9DtvSiaPY7yL
 NzXw9RdZw4ofc2ZYI2VUKjhF4OI7G+Csmt6G7k4LdKmf7B05pD+f2QixSybOVwxi91BStcPP7Gd
 U1CyMwB4Bemm7Gc1ByA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX+ZWOYiM6pBQS
 jozrQeGZCuDTXcmEOGN1SI3hX9m6MLJRT0rTJgDlD+4aJ8kLrt57TD/88nC1DBPj2IdTYcPZ48F
 6TThFHhGnp0Jtc2R6DExs4gv5nx8thg=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a593adf cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=9jRdOu3wAAAA:8 a=AMAE7NpZmBqY-1WNrTMA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: K9F5124xrCfPAMIGgucCY6MVxJMmyR3c
X-Proofpoint-ORIG-GUID: K9F5124xrCfPAMIGgucCY6MVxJMmyR3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
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

On Thu, Jul 16, 2026 at 7:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Jul 16, 2026 at 09:07:35AM +0800, fengchengwen wrote:
> > Because cross-Root-Port P2P traffic with ST does not affect the host, b=
ut
> > merely the completer may experience some performance degradation because
> > it lacks the TPH hint. In this case, I suggest adding restrictions in t=
he
> > uAPI.
>
> I don't think this is complexity is worth doing for something that has
> no functional impact.
>
> There is no difference between supplying the TPH and not supplying it,
> so may as well supply it.
>
> Jason

Agreed, thanks -- that's the intended model. The ST is an advisory
hint; when it can't reach the completer the traffic just behaves as
the non-TPH baseline, so there's nothing to gate in the uAPI.

Thanks,
Zhiping
