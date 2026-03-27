Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D63C10ED665
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957EF10EDFB;
	Fri, 27 Mar 2026 12:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kA5KYHyR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B103510EDFC;
 Fri, 27 Mar 2026 12:19:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B4A740107;
 Fri, 27 Mar 2026 12:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE0C19423;
 Fri, 27 Mar 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774613950;
 bh=WdmmxLC4uZUaxNYg07u+R61NqLzB+09CSA+9gpv6wjo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kA5KYHyR7h3Q8MfGqowvF8zh3gqZs2NKETp6VjzAQHFOxAoWEqN0DxyQgjKOs/s4j
 qXoc++EGCuN+Jk+SBWCPkkRPeNWml7CZJMT/6nIXgPViu8Dnrf5Y0JvyDOyGoeqnbI
 0H5VWYLLc8pldAYA4QYKHb8XZkd0dRadiA9mRFVYgx1cYMtKzVV+8iqrV7NgH528iQ
 NLZxMIbfgUxSiLRf8oVPOV+33glZq4ueSjniXmTt5fgoBdhmEIK2PUTDmmUKysdutE
 loM8mBn20nJPvqYo7NRuB1vdTTBJYMQIPAhOc/DLPCFcpNFcwr1vGOZ12458rn/B7m
 QhOIXoObtExuw==
Date: Fri, 27 Mar 2026 17:48:52 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <acZ1rDB5-koq8UqF@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-4-sumit.garg@kernel.org>
 <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7b116d-de41-4b9a-9c84-1010e226bac8@oss.qualcomm.com>
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

On Fri, Mar 27, 2026 at 05:40:16PM +0530, Harshal Dev wrote:
> 
> 
> On 3/12/2026 11:57 AM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > With the availability of generic PAS service, let's add SCM calls as
> > a backend to keep supporting legacy QTEE interfaces. The exported
> > qcom_scm* wrappers will get dropped once all the client drivers get
> > migrated as part of future patches.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig    |   1 +
> >  drivers/firmware/qcom/qcom_scm.c | 336 ++++++++++++++-----------------
> >  2 files changed, 156 insertions(+), 181 deletions(-)
> >
> 
> [..]
> 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 8fbc96693a55..2d7937ae7c8f 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> 
> [..]
> 
> >  
> > -/**
> > - * devm_qcom_scm_pas_context_alloc() - Allocate peripheral authentication service
> > - *				       context for a given peripheral
> > - *
> > - * PAS context is device-resource managed, so the caller does not need
> > - * to worry about freeing the context memory.
> > - *
> > - * @dev:	  PAS firmware device
> > - * @pas_id:	  peripheral authentication service id
> > - * @mem_phys:	  Subsystem reserve memory start address
> > - * @mem_size:	  Subsystem reserve memory size
> > - *
> > - * Returns: The new PAS context, or ERR_PTR() on failure.
> > - */
> 
> Shouldn't we drop the documentation for the exported functions in this file as part of
> patch 14/15? After this patch is applied, the devm_qcom_scm_pas_context_alloc() function
> still remains exported and available.

I don't see value in maintaining redundant documentation during the
course of the patch-set. The wrappers are only maintained to keep the
individual commits compilable such that we don't break kernel git
bisection scripts.

-Sumit
