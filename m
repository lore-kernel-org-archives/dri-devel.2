Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38873C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BA010EE0C;
	Wed,  1 Jul 2026 07:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nSBETdRo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70ECE10EE07;
 Wed,  1 Jul 2026 07:17:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5443643427;
 Wed,  1 Jul 2026 07:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482A1F00A3A;
 Wed,  1 Jul 2026 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782890277;
 bh=bZyuXeywd+lw/R/9JrIOGEdzbOE8NvZv2e8JZJqiMXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nSBETdRogeR8MHyqq0tQ7kwPggPv+npkmZ8Q1LMqWxByDcjboUJr2oEBlMEx+O5V+
 vSW6k030dDQusRdwbl1fHjMJQm2Ib8/SJYez/hReuxinfpAkmWB6T7T6eay7CSaXy0
 Ysce7YgcKUZ/LgHPOjEle37ctrasPoSzHg8Il2vl5siGgtfmDypD3dttt7Cb+Y6I2O
 JXj1QsbsW4t+he0qYUHbtxso40EtCb1kIkvX0BRs/I98WcV4q3iQboVu9ZLEeXEPjR
 ZKnEZjXdpswkB88L1IUhPu6jRs0rq0LUu09Nc32/TMuAtfXp2ziKW/GlET9ddH8HYz
 ZrrFxGHiWYbTw==
Date: Wed, 1 Jul 2026 12:47:38 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
Message-ID: <akS_Ep0ZgRjclzKV@sumit-xelite>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
 <dc7e58d3-4383-4d93-a38e-699888bff903@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7e58d3-4383-4d93-a38e-699888bff903@oss.qualcomm.com>
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

On Tue, Jun 30, 2026 at 02:14:30PM +0200, Konrad Dybcio wrote:
> On 6/26/26 3:34 PM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> 
> [...]
> 
> > +bool qcom_pas_is_available(void)
> 
> This is the most important function, for which I would expect
> kerneldoc be present. I think it also wouldn't hurt to add a
> footnote in every other function's kerneldoc saying that this must
> be called first

Will add in the next spin.

-Sumit
