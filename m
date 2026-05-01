Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50058CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3F210F555;
	Fri,  1 May 2026 14:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IDwd5OvA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA7410F554;
 Fri,  1 May 2026 14:09:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 07E4A43289;
 Fri,  1 May 2026 14:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19FC2BCB4;
 Fri,  1 May 2026 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777644551;
 bh=SMByRl8lFrdxKKnkS4vcwTneFAh6CDvoMKSWnMddQSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IDwd5OvATcOeJ+h7ekKmApfuAVD+xci9lzfuOrSfnPI5zTnw95tDinFDy0ZtNzrpT
 9GgQLqYQQZwD3AnSe2EdNxZapxTi3VwG3sVbd9e5FDlaTknEMVZKOqCF4YjaMkN0yk
 I0S+VqEEVePJvpJ0g3mqzm7tNtqaHPy8o4enne0DSuKwB2+cCN27TtpMqtvFJ1fq0Z
 1+F76IuKgFfxsQ20qOaCElTQCstndw1qlLjeNSmbD4qHxnnT2kRC8VSWMMp7Exn9ao
 Rstx6nZYaRWrYUZZCfMwH2X7TQGgSf6DxgxTWHcTo91irDUe7RsbmfH4AcpASMq04z
 tpk2SVdf69Gbw==
Date: Fri, 1 May 2026 19:38:55 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
 mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 09/15] remoteproc: qcom: Select QCOM_PAS generic service
Message-ID: <afSz9ymNrtlEjyDU@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-10-sumit.garg@kernel.org>
 <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429135257.utgighzczrbnl6cp@hu-mojha-hyd.qualcomm.com>
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

On Wed, Apr 29, 2026 at 07:22:57PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:57PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Select PAS generic service driver to enable support for multiple PAS
> > backends like OP-TEE in addition to SCM.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index ee54436fea5a..da3c5d9562ea 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
> >  	select QCOM_Q6V5_COMMON
> >  	select QCOM_RPROC_COMMON
> >  	select QCOM_SCM
> 
> Check do we really need SCM now ?

For WCNSS we don't need, I will drop there but others have SCM memory
assign needs.

> Why not the change for WCNSS, MSS ?

Ack, I will change for them too.

-Sumit

> 
> > +	select QCOM_PAS
> >  	help
> >  	  Say y here to support the TrustZone based Peripheral Image Loader for
> >  	  the Qualcomm remote processors. This is commonly used to control
> 
> 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> -Mukesh Ojha
> 
