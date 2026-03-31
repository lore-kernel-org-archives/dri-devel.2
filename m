Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17068FF60C8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6432710E1CF;
	Tue, 31 Mar 2026 05:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ee6fnoy/";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2831310E1CF
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 05:00:14 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso3477300a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774933213; cv=none;
 d=google.com; s=arc-20240605;
 b=cLir6hfayTfU+B3yU0FrPhAyoFdfsY9WmExWb7n/CcsPMcxFi8Jvu0jVlNHexCgA9Q
 T4Iu9ilz3s50RrdVO7FC3G3fbXVYQsXShwuE6qA4G0/Sx8JV9RT22gQKyScFyjkP+Cy3
 eUFqFASH9kfeN4yV6n7n0aV7lYhi23yfVYg9oXwtlx7TGOYaQkpgaH8XrMz4ZnsHpDT3
 Cdzrzzktobz3qUjMIP8b4FPtAQPe/QovRWoF97LWFLRjuV+OZR3oKfayjY6DRfEkPuGv
 0peJy1MuR1S8D/vjj4kSMjZmb6bZJCRdPD07NZWABurqkiPyfWagCSvzGGkPDMlUCpmr
 d7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
 fh=Zoq3Mpx/ioOKeykwrFTZbK/9cS1PW3cMywYnwHBYxRg=;
 b=ExR7GHjEassqGHNVFXcYNmccGmJbk471YKhWB5XxA7NaztytUFVBxyKKvqJDwBR7Z2
 HHw54YVBYrwl+NINTsOB5A4+akHek5b2g0uxorBxDQvMXn7/gQ0pG86kGfhIYYzFpqHg
 BC1k6d3Kjvgtw2Zr3xUhdxGcRpRzor52yoUH9aoV2+IOpf1DdQr3+WevRGApbDrpeYEk
 Ytb51EuJHYYPwTgzxgWh6KsPe7jcdBJWNKZorLMNsCSeq5W7dRBRLm5JeR8bY6cWI6+l
 ge/3hGRIflk0zv8/WXdseMoUnDlsKfVvAJmS3EUPLZ6Y3m6y1EKLTXSjctWhQQAvvOWT
 BTAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774933213; x=1775538013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
 b=Ee6fnoy/X+pVJy19dqTlvvU0jacZa/XNtfib9EqnPApj0B2SRot6epY3G1mUjWuL1A
 Zxmv9IAiM1Wq1A7rpFUQ1WQq1p5a7vkH+G7UolqSi/KvFsoWziZm9fDXJYpR1VE1sC0T
 dkdIsNh3iPgVOi4rfSRuUrwYdz30LiP+r2mZACFOXx6EHppu8DnoUrMTQsvAGO9eqIrn
 poAWy4HwuhTSr/lZt8+UnIeVZGc3NWKXfVZZ/xhtjGar32Ys6ukstd1hF2JcMRbxRGpP
 9dk74WypxMa7rLJNc55geqvi+G3LGgsgmQFIFanvUx1nIxr+jKJbMaxCooQSuf8GEa2Z
 O14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774933213; x=1775538013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qn9GR33IpU25pLfXu1OSUX8rRbknNQbsON2unRJuEZI=;
 b=Of1CbWsRyi1urSpxc8+rIURMx14LHV/y3vc7tqf2vaqIRZChpkvLdoWY4t8EPU284w
 6Bynf5740WyivIysKjak60bXdXBIrzudf/KQFyVeui2eDxTtEh7Mq0jn/daTXGGggVIK
 05hpuI3Yx6Fs65R6esvofN2hHNqU9psJezs+K+FE7Z3P+9U3t7mg0HmJBUDW16TJ/+o8
 sXi6reRKVRHgNNUEB/h0xjYEQYsHEB/sZ+U/wpVKbMbgUbEAA1ctaHZbsB9aeWVgBUsZ
 1JQ2sHoJr1P4gNCMxhgd+jPmmy/ioldL+M8T/CBNqLptiQAaQbALoUg+k9fVeZAZuuig
 jj0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuicMf53aACGPhDIpVuowDwfXMcKdM96HeM7XxAjVlnJ9vtggo25UG+28HjdKWw3G6mivycTGUJds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU5IcbS3CpLaP50T8r0d9/kR19AHWiGkK9tPDuhctuNdbNme6+
 apsvKwTKdS9DYKckp33gXxFAplwmX9XWwwF6kYNA+UZDf+wVECUz+rM/9YGh3/8UDln1pXcBLru
 SEGPri3jYg25bne2xQGB0Ug4HQp9+vPhckkZXKJclt0pXAfE=
X-Gm-Gg: ATEYQzyFvmYGXDexsUjNehPIQ3RRGOwAUbuI6zGU0fSvp47ylaKi9ESs7oTw5RPhr+r
 DYy8kECq2WbkPtGEIvaCy6zUXUTvMHTuO6/cfhlUi6+oA6//TWgTJw4UxT5WoK1uoN0jZf19Kus
 L9Axp61qQpdCk2X1NcfUb5PhkZC1xQZLhwZzlaZc9paVjB9dRbHey5PVy7cZrxQ/mxQSj/Hp7oA
 K7P9rs7pyj+JNd2/QsHE74ujBz5wULl0Xf9BztCFV+43o52w9+gvKYvXf9aCyMw8ZyLJNTdRoc+
 exocvs1DTl5I6ml9i1yo
X-Received: by 2002:a05:6830:82a9:b0:7d7:455d:1003 with SMTP id
 46e09a7af769-7d9fad9b3d5mr8646097a34.4.1774933213062; Mon, 30 Mar 2026
 22:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260314232722.15555-1-mikhail.v.gavrilov@gmail.com>
 <CH3PR11MB7177D5538C726029D80BA6CEF841A@CH3PR11MB7177.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB7177D5538C726029D80BA6CEF841A@CH3PR11MB7177.namprd11.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 10:00:01 +0500
X-Gm-Features: AQROBzCwLvCBjKMjXnGlDUOQAPoq0K7FN6AFDT1twLET-_2xPEv2urT74LC2vBE
Message-ID: <CABXGCsP+4pSyXHcOBokD5kSuVVa86xhjD+8OTy2woGavovhNKQ@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: fix DMA direction mismatch in release_udmabuf()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 17, 2026 at 10:42=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
>
> Reviewed-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> Thanks,
> Vivek
>

Hi Gerd,

Gentle ping on this patch. It has Vivek's Reviewed-by and fixes a
DMA-API warning present since v5.5.

--=20
Best Regards,
Mike Gavrilov.
