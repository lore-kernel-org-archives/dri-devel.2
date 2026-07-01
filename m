Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F78AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F4810E324;
	Wed,  1 Jul 2026 07:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxnOmPYi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1004510E30D;
 Wed,  1 Jul 2026 07:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32F9B6001D;
 Wed,  1 Jul 2026 07:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F21F000E9;
 Wed,  1 Jul 2026 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782890493;
 bh=E8QuM5x7gXGTaLLIIkxCkvrp1Q5hGaoiUi54XE05gBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lxnOmPYiTm5nMcXoRupb4T809lC2MPU9MotfSPQqFnkS0hl7wSnlOIbrJDt7bYekA
 sVI7f9YSbJwxbO3u0XfHBURHRZlAAzBwjcRa7ShoFl4mSAzdL250vAQBhsVYHLxYOz
 lJ7pSTB5tl4owIgtmPSU9hPFWTm9fZYAtim76KJHfRmZutumZgDE16fIPAKf8KLzGa
 zVY3+Rs/vv9nPdSM0Sa5+CPx4HzOg9SPN/Q04wZ7M/iIGeGJECFNKF6x+a/WnF5n0v
 t4eo5mj5Bhhv0l95T8RNDIP4NtlQqGPv6v66blXrshDRtF6evB4iQ39jw3D4Nl6tV3
 sixI5cetuXoTg==
Date: Wed, 1 Jul 2026 12:51:14 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <akS_6izxrhgK-I22@sumit-xelite>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
 <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
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

On Fri, Jun 26, 2026 at 06:05:54PM +0100, Julian Braha wrote:
> Hi Sumit,
> 
> On 6/26/26 14:34, Sumit Garg wrote:
> 
> >  config QCOM_SCM
> > +	tristate "Qualcomm PAS SCM interface driver"
> > +	select QCOM_PAS
> >  	select QCOM_TZMEM
> > -	tristate
> I think QCOM_SCM is missing a 'select IRQ_DOMAIN'. Right now I get a
> build error without it:
> 
> drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
>   drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
> of function ‘irq_create_fwspec_mapping’; did you mean
> ‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
>    2512 |         return irq_create_fwspec_mapping(&fwspec);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
>         |                irq_create_of_mapping
>

This issue should be independent of this patch-set. Please submit a
standalone fix for this.

-Sumit
