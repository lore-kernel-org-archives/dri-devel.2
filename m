Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56950CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B849010ED2C;
	Wed, 13 May 2026 19:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="ron3m7lL";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5WzK42O";
	dkim-atps=neutral
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80AE10F01F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:21:07 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 378D9EC00D7;
 Wed, 13 May 2026 15:11:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 15:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778699510;
 x=1778785910; bh=IMiTolzI/z84pa6E563G2cQo6bO9Q+x/ya5iPnM63iU=; b=
 ron3m7lLO4wF5u+0kYddL6j1mJmPJtsnv8Icv6T64E1ZA/kDx2crRbz9UC2MGBIR
 XecVvo+ltsjwyLiWlnTlpGUGoOnlkG2/wid8Jiix0A374kodKwU14/yPKUvOCK4R
 d0ACRnc3Yus0rAtUziwXtrpo7JWP9FBGFUyDYtqniL4EwHNj+knAjNpGXmzR1pZO
 gEpCk8FA9iu9IWJNzMMAa2vLoZdSNg/LyODNxBQMlgHrMKyKZ3oHTKK7WdhZyHa5
 iHxlr27lgfpEuvTr+ehtukM0Wn08nL6fs6I0jmBZwrF1GXOUJMA2xorYvB4YjSTy
 D+IwPwaj/LTCMR18gG6bhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778699510; x=
 1778785910; bh=IMiTolzI/z84pa6E563G2cQo6bO9Q+x/ya5iPnM63iU=; b=i
 5WzK42OpzeRFjBXLOfh6BXtaCGX8cH9qoRdC6L6L4vbgoDtpt7Ln2cl8POK+7/v3
 TGLeLsMLftk8ctJNR2yBnnTVpmTqAaRoLOOsu8J3Cq52W61IgwrPIxHMWd/DApfx
 mFpUZnwnrE3XSe1EoUP4anuKkjGTZu2p0HEMN/KI6MEpBfrYJoRMy2JWIievNV9+
 x0dM/r0YzuLrsreZAhYv3DUUxwqBGblE128bpRjC1g2QfPiRZpLtCLy21AYPAWOU
 NwfmSJcBjnATyYZe9WrRfz3uZzP7AiFTAfCc97MKv0U6vDVgSKU2Nr9T1w7dZyM3
 hyNcOnqm3JG5G+k9cB24Q==
X-ME-Sender: <xms:9cwEaspxsYnqeavZlOTl6bnkp_ml0uQ6CSQxJP_4DVzI3KlumiAwyw>
 <xme:9cwEavPVzJZAHrnPyEPTobJ60TesctgAWrsFnQxYgRA2uNqgJHMcg1UP4obJTsadc
 G2NLNfeN90sEqwS2YHnvW5-oiI3oZMQAeUBQuQ9n6Ix1QkUIrODWhU>
X-ME-Received: <xmr:9cwEalqjGad4RdOOfblTEsC3N6I8xJvJ6lRP0431UN-mWpIIk63ZIwMb-V65guzpTZF7n1sH24_ilQnABKgm7w_f7B4ISbuuPUeR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgr
 shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrg
 htvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheet
 heekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhn
 rghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopehlrghurhgvnhhtrdhpihhntghhrghrthdorhgvnhgvshgrshesihguvggr
 shhonhgsohgrrhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhgvughirgesvhhgvg
 hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhs
 rdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgvsh
 grshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmihdr
 vhgrlhhkvghinhgvnhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepkh
 hivghrrghnrdgsihhnghhhrghmsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphht
 thhopegsihhjuhdruggrshdrjhiisegsphdrrhgvnhgvshgrshdrtghomhdprhgtphhtth
 hopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehf
 fhiflhhlrdgthh
X-ME-Proxy: <xmx:9swEaqtqGgIaT7q_YDsKyUiGZtAKt3A3YqCOmkHETGlT7PzT-uZi9g>
 <xmx:9swEas3k1pyH-74rWcluYmPILsjMJbKhASJKOgFm-dtpmGtxmWoF-A>
 <xmx:9swEatEQDmU8A8F-iB3xeUeNH2Afp2MEqo0uespSvISwlPli34Tk1A>
 <xmx:9swEavtXhfz2zApUlgLlC9vGsJUkyhjHyvU668lcpYMdfcTF7NIJhw>
 <xmx:9swEapy-4W8srdo3CMmOuGM-c62WAfp-jidf_PRxSIaaqKWAngyuBLfc>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:11:49 -0400 (EDT)
Date: Wed, 13 May 2026 21:11:48 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 02/11] media: renesas: vsp1: Split vsp1_du_setup_lif()
Message-ID: <20260513191148.GE332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-3-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-3-laurent.pinchart+renesas@ideasonboard.com>
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

Hi Laurent,

Thanks for your cleanup!

On 2026-05-12 02:56:26 +0300, Laurent Pinchart wrote:
> The vsp1_du_setup_lif() function is used to configure and enable a
> pipeline, as well as disable it, depending on the cfg argument being a
> valid pointer or NULL. This creates a confusing API. Improve it by
> splitting the function in two, a vsp1_du_enable() function to configure
> a pipeline, and a vsp1_du_disable() function to disaple it.
> 
> Keep vsp1_du_setup_lif() as an inline wrapper for existing callers in
> the DRM subsystem, to simplify merging. The callers will be updated
> separately and the old API will then be removed.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  .../media/platform/renesas/vsp1/vsp1_drm.c    | 140 ++++++++++--------
>  include/media/vsp1.h                          |  14 +-
>  2 files changed, 91 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> index 79b85968b061..1f431874064d 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> @@ -629,14 +629,14 @@ int vsp1_du_init(struct device *dev)
>  EXPORT_SYMBOL_GPL(vsp1_du_init);
>  
>  /**
> - * vsp1_du_setup_lif - Setup the output part of the VSP pipeline
> + * vsp1_du_enable - Setup and enable a DU pipeline
>   * @dev: the VSP device
>   * @pipe_index: the DRM pipeline index
>   * @cfg: the LIF configuration
>   *
>   * Configure the output part of VSP DRM pipeline for the given frame @cfg.width
>   * and @cfg.height. This sets up formats on the BRx source pad, the WPF sink and
> - * source pads, and the LIF sink pad.
> + * source pads, and the LIF sink pad, and then starts the pipeline.
>   *
>   * The @pipe_index argument selects which DRM pipeline to setup. The number of
>   * available pipelines depend on the VSP instance.
> @@ -649,14 +649,13 @@ EXPORT_SYMBOL_GPL(vsp1_du_init);
>   *
>   * Return 0 on success or a negative error code on failure.
>   */
> -int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
> -		      const struct vsp1_du_lif_config *cfg)
> +int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
> +		   const struct vsp1_du_lif_config *cfg)
>  {
>  	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
>  	struct vsp1_drm_pipeline *drm_pipe;
>  	struct vsp1_pipeline *pipe;
>  	unsigned long flags;
> -	unsigned int i;
>  	int ret;
>  
>  	if (pipe_index >= vsp1->info->lif_count)
> @@ -665,60 +664,6 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
>  	drm_pipe = &vsp1->drm->pipe[pipe_index];
>  	pipe = &drm_pipe->pipe;
>  
> -	if (!cfg) {
> -		struct vsp1_brx *brx;
> -
> -		mutex_lock(&vsp1->drm->lock);
> -
> -		brx = to_brx(&pipe->brx->subdev);
> -
> -		/*
> -		 * NULL configuration means the CRTC is being disabled, stop
> -		 * the pipeline and turn the light off.
> -		 */
> -		ret = vsp1_pipeline_stop(pipe);
> -		if (ret == -ETIMEDOUT)
> -			dev_err(vsp1->dev, "DRM pipeline stop timeout\n");
> -
> -		for (i = 0; i < ARRAY_SIZE(pipe->inputs); ++i) {
> -			struct vsp1_rwpf *rpf = pipe->inputs[i];
> -
> -			if (!rpf)
> -				continue;
> -
> -			/*
> -			 * Remove the RPF from the pipe and the list of BRx
> -			 * inputs.
> -			 */
> -			WARN_ON(!rpf->entity.pipe);
> -			rpf->entity.pipe = NULL;
> -			list_del(&rpf->entity.list_pipe);
> -			pipe->inputs[i] = NULL;
> -
> -			brx->inputs[rpf->brx_input].rpf = NULL;
> -		}
> -
> -		drm_pipe->du_complete = NULL;
> -		pipe->num_inputs = 0;
> -
> -		dev_dbg(vsp1->dev, "%s: pipe %u: releasing %s\n",
> -			__func__, pipe->lif->index,
> -			BRX_NAME(pipe->brx));
> -
> -		list_del(&pipe->brx->list_pipe);
> -		pipe->brx->pipe = NULL;
> -		pipe->brx = NULL;
> -
> -		mutex_unlock(&vsp1->drm->lock);
> -
> -		vsp1_dlm_reset(pipe->output->dlm);
> -		vsp1_device_put(vsp1);
> -
> -		dev_dbg(vsp1->dev, "%s: pipeline disabled\n", __func__);
> -
> -		return 0;
> -	}
> -
>  	/* Reset the underrun counter */
>  	pipe->underrun_count = 0;
>  
> @@ -741,7 +686,7 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
>  	if (ret < 0)
>  		goto unlock;
>  
> -	vsp1_pipeline_dump(pipe, "LIF setup");
> +	vsp1_pipeline_dump(pipe, "DU enable");
>  
>  	/* Enable the VSP1. */
>  	ret = vsp1_device_get(vsp1);
> @@ -777,7 +722,80 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(vsp1_du_setup_lif);
> +EXPORT_SYMBOL_GPL(vsp1_du_enable);
> +
> +/**
> + * vsp1_du_disable - Disable and stop a DU pipeline
> + * @dev: the VSP device
> + * @pipe_index: the DRM pipeline index
> + *
> + * The @pipe_index argument selects which DRM pipeline to disable. The number
> + * of available pipelines depend on the VSP instance.
> + *
> + * Return 0 on success or a negative error code on failure.
> + */
> +int vsp1_du_disable(struct device *dev, unsigned int pipe_index)
> +{
> +	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
> +	struct vsp1_drm_pipeline *drm_pipe;
> +	struct vsp1_pipeline *pipe;
> +	struct vsp1_brx *brx;
> +	unsigned int i;
> +	int ret;
> +
> +	if (pipe_index >= vsp1->info->lif_count)
> +		return -EINVAL;
> +
> +	drm_pipe = &vsp1->drm->pipe[pipe_index];
> +	pipe = &drm_pipe->pipe;
> +
> +	mutex_lock(&vsp1->drm->lock);
> +
> +	brx = to_brx(&pipe->brx->subdev);
> +
> +	ret = vsp1_pipeline_stop(pipe);
> +	if (ret == -ETIMEDOUT)
> +		dev_err(vsp1->dev, "DRM pipeline stop timeout\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(pipe->inputs); ++i) {
> +		struct vsp1_rwpf *rpf = pipe->inputs[i];
> +
> +		if (!rpf)
> +			continue;
> +
> +		/*
> +		 * Remove the RPF from the pipe and the list of BRx
> +		 * inputs.
> +		 */
> +		WARN_ON(!rpf->entity.pipe);
> +		rpf->entity.pipe = NULL;
> +		list_del(&rpf->entity.list_pipe);
> +		pipe->inputs[i] = NULL;
> +
> +		brx->inputs[rpf->brx_input].rpf = NULL;
> +	}
> +
> +	drm_pipe->du_complete = NULL;
> +	pipe->num_inputs = 0;
> +
> +	dev_dbg(vsp1->dev, "%s: pipe %u: releasing %s\n",
> +		__func__, pipe->lif->index,
> +		BRX_NAME(pipe->brx));
> +
> +	list_del(&pipe->brx->list_pipe);
> +	pipe->brx->pipe = NULL;
> +	pipe->brx = NULL;
> +
> +	mutex_unlock(&vsp1->drm->lock);
> +
> +	vsp1_dlm_reset(pipe->output->dlm);
> +	vsp1_device_put(vsp1);
> +
> +	dev_dbg(vsp1->dev, "%s: pipeline disabled\n", __func__);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vsp1_du_disable);
>  
>  /**
>   * vsp1_du_atomic_begin - Prepare for an atomic update
> diff --git a/include/media/vsp1.h b/include/media/vsp1.h
> index d9b91ff02761..d2085cdb7fcb 100644
> --- a/include/media/vsp1.h
> +++ b/include/media/vsp1.h
> @@ -44,8 +44,18 @@ struct vsp1_du_lif_config {
>  	void *callback_data;
>  };
>  
> -int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
> -		      const struct vsp1_du_lif_config *cfg);
> +int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
> +		   const struct vsp1_du_lif_config *cfg);
> +int vsp1_du_disable(struct device *dev, unsigned int pipe_index);
> +
> +static inline int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
> +				    const struct vsp1_du_lif_config *cfg)
> +{
> +	if (cfg)
> +		return vsp1_du_enable(dev, pipe_index, cfg);
> +	else
> +		return vsp1_du_disable(dev, pipe_index);
> +}
>  
>  /**
>   * struct vsp1_du_atomic_config - VSP atomic configuration parameters
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
