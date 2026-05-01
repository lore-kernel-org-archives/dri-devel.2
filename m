Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBD6CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6B010F535;
	Fri,  1 May 2026 13:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hacn9ZH5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E212210F533;
 Fri,  1 May 2026 13:57:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B4D440414;
 Fri,  1 May 2026 13:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D0C2BCB4;
 Fri,  1 May 2026 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777643840;
 bh=w8gK0qhyZPCNHIhL7IgT046DTvz68t7gU8GMkEECV+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hacn9ZH5LTvmUEB+PI0lanXZ2FDkaV/k8AvcTqlgzHo2Nh8mDkG32yuYesG/z9/xt
 tiNfGbgRgtdPkDbgn2sbCJBYPBXSntkFP+Ciuprfd/oGtJ6P2+UHYgiARxi/2eHq12
 l72dxRCf48OjqnJJQyxceie8uFZFzjk6iNYmYw2vGMkp5M9P6An69nQwYf3yqaV9v7
 l+ZerbetJ1RzM9cIp+KXtSXFmPn5WyK1Jfkvopr7Ig61kDhQH4KUTaG9L5eOapl4TL
 SPBkZw05fHoJZpexPjP2QnrP1gpwZoagmU7iYmrssHTVQ3syTqab3G/5xZSJVQHbcP
 rEdHxzf5ICJww==
Date: Fri, 1 May 2026 19:27:03 +0530
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
Subject: Re: [PATCH v4 05/15] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
Message-ID: <afSxLxDPHh6Ajpi6@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-6-sumit.garg@kernel.org>
 <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
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

On Wed, Apr 29, 2026 at 06:55:12PM +0530, Mukesh Ojha wrote:
> On Mon, Apr 27, 2026 at 03:25:53PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 51 +++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index da27d1d3c9da..847249c28c1b 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> 
> Can you check do we really need this header ?

Yeah it's needed for qcom_scm_assign_mem() API.

> 
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/remoteproc.h>
> > @@ -118,8 +119,8 @@ struct qcom_pas {
> >  	struct qcom_rproc_ssr ssr_subdev;
> >  	struct qcom_sysmon *sysmon;
> >  
> > -	struct qcom_scm_pas_context *pas_ctx;
> > -	struct qcom_scm_pas_context *dtb_pas_ctx;
> > +	struct qcom_pas_context *pas_ctx;
> > +	struct qcom_pas_context *dtb_pas_ctx;
> >  };
> >  
> >  static void qcom_pas_segment_dump(struct rproc *rproc,
> > @@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
> >  
> >  	do {
> >  		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
> > -		ret = qcom_scm_pas_shutdown(pas->pas_id);
> > +		ret = qcom_pas_shutdown(pas->pas_id);
> >  	} while (ret == -EINVAL && --retry_num);
> >  
> >  	return ret;
> > @@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
> >  	 * auth_and_reset() was successful, but in other cases clean it up
> >  	 * here.
> >  	 */
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  	return 0;
> >  }
> > @@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
> >  	pas->firmware = fw;
> >  
> >  	if (pas->lite_pas_id)
> > -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> > +		qcom_pas_shutdown(pas->lite_pas_id);
> >  	if (pas->lite_dtb_pas_id)
> > -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> > +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
> >  
> >  	if (pas->dtb_pas_id) {
> >  		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
> > @@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
> >  	return 0;
> >  
> >  release_dtb_metadata:
> > -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  	release_firmware(pas->dtb_firmware);
> >  
> >  	return ret;
> > @@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
> >  		if (ret)
> >  			goto disable_px_supply;
> >  
> > -		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> > +		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> >  		if (ret) {
> >  			dev_err(pas->dev,
> >  				"failed to authenticate dtb image and release reset\n");
> > @@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
> >  	if (ret)
> >  		goto release_pas_metadata;
> >  
> > -	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
> > +	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
> >  	if (ret) {
> >  		dev_err(pas->dev,
> >  			"failed to authenticate image and release reset\n");
> > @@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
> >  	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
> >  	if (ret == -ETIMEDOUT) {
> >  		dev_err(pas->dev, "start timed out\n");
> > -		qcom_scm_pas_shutdown(pas->pas_id);
> > +		qcom_pas_shutdown(pas->pas_id);
> >  		goto unmap_carveout;
> >  	}
> >  
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
> >  	pas->firmware = NULL;
> > @@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
> >  unmap_carveout:
> >  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
> >  release_pas_metadata:
> > -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> > +	qcom_pas_metadata_release(pas->pas_ctx);
> >  	if (pas->dtb_pas_id)
> > -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> > +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> >  
> >  unmap_dtb_carveout:
> >  	if (pas->dtb_pas_id)
> > @@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
> >  	if (ret == -ETIMEDOUT)
> >  		dev_err(pas->dev, "timed out on wait\n");
> >  
> > -	ret = qcom_scm_pas_shutdown(pas->pas_id);
> > +	ret = qcom_pas_shutdown(pas->pas_id);
> >  	if (ret && pas->decrypt_shutdown)
> >  		ret = qcom_pas_shutdown_poll_decrypt(pas);
> >  
> > @@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
> >  		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
> >  
> >  	if (pas->dtb_pas_id) {
> > -		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
> > +		ret = qcom_pas_shutdown(pas->dtb_pas_id);
> >  		if (ret)
> >  			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
> >  
> > @@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
> >  	 *
> >  	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
> >  	 * or not and if it is not having then we pass NULL and zero as input resource
> > -	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> > +	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
> >  	 * and this is even true for Qualcomm remote processor who does follow remoteproc
> >  	 * framework.
> >  	 */
> > -	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> > +	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> >  	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
> >  	if (ret) {
> >  		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
> > @@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  	if (!desc)
> >  		return -EINVAL;
> >  
> > -	if (!qcom_scm_is_available())
> > +	if (!qcom_pas_is_available())
> >  		return -EPROBE_DEFER;
> >  
> >  	fw_name = desc->firmware_name;
> > @@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
> >  
> >  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
> >  
> > -	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> > -						       pas->mem_phys, pas->mem_size);
> > +	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> > +						   pas->mem_phys, pas->mem_size);
> >  	if (IS_ERR(pas->pas_ctx)) {
> >  		ret = PTR_ERR(pas->pas_ctx);
> >  		goto remove_ssr_sysmon;
> >  	}
> >  
> > -	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> > -							   pas->dtb_mem_phys,
> > -							   pas->dtb_mem_size);
> > +	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> > +						       pas->dtb_mem_phys,
> > +						       pas->dtb_mem_size);
> >  	if (IS_ERR(pas->dtb_pas_ctx)) {
> >  		ret = PTR_ERR(pas->dtb_pas_ctx);
> >  		goto remove_ssr_sysmon;
> > -- 
> > 2.51.0
> > 
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks.

-Sumit
