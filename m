Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6121CFF494B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD89C10E461;
	Mon, 30 Mar 2026 07:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MWwAMHbX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2B210E461;
 Mon, 30 Mar 2026 07:08:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9254A43D99;
 Mon, 30 Mar 2026 07:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37DEC4CEF7;
 Mon, 30 Mar 2026 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774854537;
 bh=/jDwCS37ClQxnMNZi4IpdtAvb0wwJQBYhYWpxA7NdaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MWwAMHbXhHOam7pxS91Eazmz+hUaoDAf2swLU3Xxq0gOap3WbmlYuHlA7Lt16iHk/
 okQRjsC54iUTWRm7vbYcOl63AQeNSP1MNEgw1swjH48UQtjagL+B86CXREPNJzOwOq
 Cp8lf0iFOXffdYv5f1ZGoX72EDi3p7JUGh67peAHFMO9Q/7XBtMWuezArFeYv8+qt4
 fgq1SWLpceGxYsLEgK9CZjwsuKJFx4nOY6DeWoYA4vzLl8bC5lMBjrcNcnMwUkRVKt
 CDc0Q5JxKQzahwBZXb6knpLrYwg3kt1+XvW2qSNHe45aTGMzshmNSA4zgJNCA3qG5D
 kMXWwGLdrpl2w==
Date: Mon, 30 Mar 2026 12:38:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <acohdYeKYSDQrKUZ@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
 <acE-kAi2tkPh2qie@sumit-xelite>
 <5c5b49aa-7819-44c6-b5f7-19ec780d73fa@kernel.org>
 <2e55bdc3-54a1-4f18-b9ad-fe03f21fc4da@oss.qualcomm.com>
 <a0a7269d-7a09-4a78-a4b0-b39b67bc253b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a7269d-7a09-4a78-a4b0-b39b67bc253b@kernel.org>
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

On Fri, Mar 27, 2026 at 02:56:40PM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2026 15:26, Konrad Dybcio wrote:
> >>>
> >>> This pattern has been carried from the PAS API contract among kernel
> >>> clients and the SCM PAS service earlier. The clients don't hold a
> >>> reference to the PAS data like underlying platform or TEE device etc.
> >>> Hence the need to have a global data pointer to hold reference to the
> >>> ops data structure registered by drivers having different lifetime of
> >>> devices. Also, the PAS APIs can be called from very different client
> >>> driver contexts.
> >>>
> >>> Surely, avoiding global data is always better given a better alternative
> >>> is there. Do you have any better alternative proposal here?
> >>
> >> Why it cannot be part of the context?
> >>
> >> Look at your API, e.g.:
> >> qcom_pas_init_image(). It takes struct qcom_pas_context which should
> >> contain the ops.

Have a look at all other PAS client APIs, the context isn't something
that each client takes a reference and pass it on for every PAS
invocation. And changing the PAS API contract for kernel clients is out
of scope of this patch-set.

> > 
> > This would make the client have to select the ops. The whole point is to
> > avoid that, since the client has no clue (and is supposed not to have any).
> 
> Yeah, I see. The problem is that this patchset just keeps growing the
> singletons so except existing 'struct qcom_scm *__scm' in qcom_scm.c,
> this one brings at least three new: 'ops_ptr', 'qcom_pas_ops_scm' and
> 'qcom_pas_ops_tee'.

Not sure how you equate ops structure __pointer__ to the ops structure
itself. Can you enlighten me how in the rest of the kernel ops data
structures are shared among independent modules registering on different
bus types?

> 
> I don't think you need all four in total, but only one which will hold
> whatever pointers are necessary.

Your arguments seems to be in favour of the existing monolithic SCM
driver design but you need to understand that's not how underlying TZ
services are implemented. The PAS service in TZ has nothing to do with
the ICE service for inline crypto as an example.

Please go through the motivation of this patch-set and the corresponding
OP-TEE implementation as TZ which is all open source.

-Sumit
