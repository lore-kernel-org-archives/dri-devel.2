Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B21CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B04F10EF94;
	Thu, 11 Jun 2026 14:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ml0dDu8M";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014D110EF94
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:45:45 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-befd83e0521so217767066b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189144; cv=none;
 d=google.com; s=arc-20240605;
 b=eB+VNw8g3n5UQIPdc7GJ5NcEtHd8FUDtX9WokDV9b0KNeSoHddEuHG6hPyb1ffLtiJ
 A7hldt700otnHyM5HRIY2OyzA2EBfwcehXqSfyLiMbRqGWcFQqkmZ0fnJhzqrN1LqIM8
 8bcw8I2/DsyEeQWreY1zcxa9LjEUuL5QN55wBl9xAULPYr/ox2vQwl99Ujjd3pNcTv65
 P4XEasMyXWOR0jXnXohgygrUcjhIZL1yPMA3Lx8IFj5VAfBmLls2lz8nESla/6XvYLAh
 cDmOCqoFZZJTLq8mRrhLQmdnU88DDLTd3IcgA0O1Blex6r+jK0eh1L/t9eIbJBuyRXXU
 iwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
 fh=Cw4uHJY5W51eD3xrOGEwa09JJ+ZA7gFQKQoZ0X0qb5I=;
 b=EuXilI+QOgK1gIWXpiP+0YVqmbg61GASVWFmYVCZC+BgecfRI69NwM1PmleS4uYkX0
 coMdYo5VkXdUJzGUR9cKDL0F5jV07yH6GCw2U2GgLw0VAkTF+PtaLnPiCoevno2bJ4fj
 edTx0X7qaT5ARn4q+BC7zo+RSvkU15ac83xiruJ8pXGcxlkK4myvfuyJ3ZHibnXXOBEx
 HjB/ttdAnSN2Fg69X9M6gCgwA5tQEiUmFmKUu/OtrufUow0pKVVNoM4zhCgUomysNUcb
 SlhfjXM2Wn69x5zy6sePQz3BphJTyAm63Ox2Nj/ZrifX5hW0fQPpA12VJSrPbxdZa332
 T+Sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781189144; x=1781793944; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
 b=ml0dDu8Mpk8QsG+H2TyXJfV4Jurz3tq4lwiO6gZ3MLpQCIv2c0F/UE5Gdn9l+qszhZ
 S2AALHyjpnnRfR32Bw7VXcm86T6cp6sWR8bBQeDZxlzT3x3Io6Bn5HBEG0jes2IWUzQu
 JMDd4S6gzkCwnR4HWNaaZ33Ld282Rcv85R2oJubw9R9lKCqHyOBx7Bkx8n0zrNK7vucR
 A1Da3gU81LyQ+sgBDVgb2Tm0nu0U3+hVn3ozBmEpxATwI6/O3kRBHYZnPn+4Wn90KJnZ
 uPF7gMiLbt3RJbbJuHu8Pq/ZbAFklwHgyQ8DqvnE1E8Q3B8zruvtTkED4blJQDRuAQaa
 SNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189144; x=1781793944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
 b=OBFnVGugwPYTWfq/S8Vqf9FtOVdT7T+jR54RpjQsCLZ8zwuMSZ8NnNwa3IpEIHopvy
 rZDVN/jxY61Lt3WT0Ts1kSRT18V77Glo14Dvl+cUU3kx1gYaBVZvGU1utT/ZVwpfhbPl
 hzmB/9mTcd7M3DsOJ2XOzkoF+FccVionHSasnnIQhBCAGpgyeAG7tl3GtVeSeWbWNIEi
 0fzAlugYfD8CvjMds3bC6hJ2zibPdmZdAFEG1/eS/qYJ/LEhh04D9X2BshaXiiF6/6Hr
 6EZUqj/KcaXM07jm6dQS3Zsjm2e5TCJo1ajC/sM4hXPUff05fd9DoEm6gd2NrpuSGnas
 JB2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ80AvbE9jbUZ8gZuBNZYedK9k3nmMwEFFCUgrN1fJ3WY98DaWUkDycp/F+LAIXwZ96uuskGYAk7DVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdPd3bS1s0TGcxxh5h381hQzp5AHMQC2Z2dGMy1LQspIneBZqR
 ORdO0GpSHCLphzf8lsjag1npUIjgJMj/QVwldgGLE6GwEMDBhUTXzP1opkGXaR6XrGVqr37M06r
 zXqzbc0JQVVAwdaXt4CoWsMJrVZ9QrmccCI5lkwSqbQ==
X-Gm-Gg: Acq92OHvqVPitqehecxZDND1ZfYuIPhlPyewEei9LTOA9XsY8HG3HG9u87XIwufensO
 oWhyUX3m7L7qRi9Kgq/Z3oCjAdPk20KpperQZD/dl6zjEFjvqi0T8dKOUxjTlLqqfd8hBBj/OFl
 8szF3hnW+QploOiTgTE94blKryZo6o1MIQKK9c+b7RBYrPYKTnWTaRiLuwXDOIe4nGM58Gd9pbV
 9vAkx3URWbq0ph291GwFR046SEqow7t5xkWkbeSoFOjIheN0AJiW3K6ArCScSY6mQnBnBo+E5LC
 3/24OxoC+A+T5pbB47kmZaBiT31H5uLHeKRD38wISGI46V2ijoUydTGbiw==
X-Received: by 2002:a17:906:4fd1:b0:bee:a39b:ab7b with SMTP id
 a640c23a62f3a-bfc78ed6c4fmr158181366b.31.1781189144237; Thu, 11 Jun 2026
 07:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
 <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
In-Reply-To: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Jun 2026 20:15:32 +0530
X-Gm-Features: AVVi8CeA1CWJ3Tf7y-K-ZwxKVWTsZOKhQeXrR2LoMbjQ-zl-nOkzKd4bOJvB8OA
Message-ID: <CAO_48GHEfq7wpvM_4OXcMhgdASgH9J96nhEd0QFh2Rg8aPxpfw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Jiri Pirko <jiri@resnulli.us>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
 linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
 x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
 mripard@kernel.org, afd@ti.com, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jiri,

On Thu, 11 Jun 2026 at 15:51, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
> >From: Arnd Bergmann <arnd@arndb.de>
> >
> >While system heap and system_cc_shared heap share a lot of code
> >and hence the same source file, their users have different needs.
> >
> >system heap users need it to be a loadable module, while
> >system_cc_shared heap users don't.
> >
> >Building as a loadable module breaks system_cc_shared heap on
> >powerpc and s390 due to un-exported set_memory_encrypted /
> >set_memory_decrypted functions.
> >
> >Fix these by reorganising code to put the system_cc_shared heap
> >under a new Kconfig symbol, which allows either building both
> >into the kernel, or leave encryption up to the consumers of the
> >system heap.
> >
> >Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> >---
> > drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> > drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> > 2 files changed, 18 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> >index e273fb18feca..a39decdcf067 100644
> >--- a/drivers/dma-buf/heaps/Kconfig
> >+++ b/drivers/dma-buf/heaps/Kconfig
> >@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> >         Choose this option to enable the system dmabuf heap. The system heap
> >         is backed by pages from the buddy allocator. If in doubt, say Y.
> >
> >+config DMABUF_HEAPS_CC_SYSTEM
>
> Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
> name?
>
> With or without it:
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
Thanks for catching this; I'll fix this while pushing to
drm-misc-next-fixes in a few minutes.

Best,
Sumit.
