Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5562CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 11:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E1E10E072;
	Mon,  4 May 2026 11:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bKjpZmuv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DF610E072;
 Mon,  4 May 2026 11:23:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F2A043DA9;
 Mon,  4 May 2026 11:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17416C2BCB8;
 Mon,  4 May 2026 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777893824;
 bh=1w+MzSobxxhh4/Z6BnF1Kps4Ui5Z89S5baW8VF7cW6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bKjpZmuvT3AASZNwdOzNxp2knijQMyMENFMHM5uqAOrV+70C3W/V+G62NSkeLnjzL
 d7IH3uPHFHyq6SvUwEUCu6X33eAaaVpuGEI+NWlgvBQgKDyKKsXmUsMFbxJTZk5XmB
 Lo3jNju8AYgqS3cynz2WeFDWRkxL7rvgwSY5jsqgL9E7bn8S4dT+McwB5oeSR6cyY8
 GE5Y1kovSElzmwnbUck5r3saI9Xt0dB57LfWOdOonvUwnNHfNwZ0RJwogibRCtfsn8
 L4L0/hTuWlEatyhi8lNXCX9h5krZSukJ7LkRsewUB1J58/zkoNMLAc9tK7EMOodhSX
 SWLdQcNbZAOaQ==
Date: Mon, 4 May 2026 16:53:26 +0530
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
Subject: Re: [PATCH v4 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <afiBrt7g1Y4-Eozu@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-4-sumit.garg@kernel.org>
 <20260429104841.l555xd2izoyrqjp4@hu-mojha-hyd.qualcomm.com>
 <afStf3iBDtP2z6Eo@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afStf3iBDtP2z6Eo@sumit-xelite>
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

On Fri, May 01, 2026 at 07:11:19PM +0530, Sumit Garg wrote:
> On Wed, Apr 29, 2026 at 04:18:41PM +0530, Mukesh Ojha wrote:
> > On Mon, Apr 27, 2026 at 03:25:51PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > With the availability of generic PAS service, let's add SCM calls as
> > > a backend to keep supporting legacy QTEE interfaces. The exported
> > > qcom_scm* wrappers will get dropped once all the client drivers get
> > > migrated as part of future patches.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  drivers/firmware/qcom/Kconfig    |   1 +
> > >  drivers/firmware/qcom/qcom_scm.c | 335 ++++++++++++++-----------------
> > >  2 files changed, 155 insertions(+), 181 deletions(-)
> > >  
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > index 9b06a69d3a6d..d87a962e93da 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > >  
> > > -/**
> > > - * qcom_scm_pas_shutdown() - Shut down the remote processor
> > > - * @pas_id:	peripheral authentication service id
> > > - *
> > > - * Returns 0 on success.
> > > - */
> > > -int qcom_scm_pas_shutdown(u32 pas_id)
> > > +static int __qcom_scm_pas_set_remote_state(struct device *dev, u32 state,
> > > +					   u32 pas_id)
> > > +{
> > > +	struct qcom_scm_desc desc = {
> > > +		.svc = QCOM_SCM_SVC_BOOT,
> > > +		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
> > > +		.arginfo = QCOM_SCM_ARGS(2),
> > > +		.args[0] = state,
> > > +		.args[1] = pas_id,
> > > +		.owner = ARM_SMCCC_OWNER_SIP,
> > > +	};
> > > +	struct qcom_scm_res res;
> > > +	int ret;
> > > +
> > > +	ret = qcom_scm_call(dev, &desc, &res);
> > > +
> > > +	return ret ? : res.result[0];
> > > +}
> > > +
> > > +int qcom_scm_set_remote_state(u32 state, u32 id)
> > 
> > s/id/pas_id
> 
> Ack.
>

Coming back to this comment again, since this is a temporary wrapper
which is going to be dropped as part of 2nd last patch, I don't think
there is value to fix them as they maintain existing APIs interface.

-Sumit
