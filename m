Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB77C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1812B10E627;
	Mon, 13 Jul 2026 17:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e+vKztkQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC7C10E627
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:11:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B4A2600D8;
 Mon, 13 Jul 2026 17:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D476C1F00A3A;
 Mon, 13 Jul 2026 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783962700;
 bh=aKs5fgpDGbjVA4/sXLKlz6OKtuurHs4tokGqg7EWMoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e+vKztkQrTN6Z/ZBNoq8MDxk7OygKY4LjFgOuc805M9uXn+0AX5F6zAeSRmZ2V/UO
 Ekwk+cVf30C7PX9dTHhvphnSortuqtHoOeIWQHHRQi7ojJtmTy+CPHVKizZsyP4tB+
 J/JghSIxCQT/MU59liHhrsxpBk32DpA25EpL01zVtbQ+aPUxtkZjadEx2yjBZDzCUf
 oHed6rXNVHmrJv84x5CgbLu4oY9OfesW4J8K74funNYXeyZUpfQ19tBZF/kwmF0a/3
 mVtnJbdSKzgEzCXxIldQbyG+/RRO2C8T/5GV17mo5+2lpZYBjVji0tM1ANevk2iejN
 qCABn3bIsKFxQ==
Date: Mon, 13 Jul 2026 19:11:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v6 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
Message-ID: <wbez5pvslz2opnjd2mih7b4noce2oghbdi3ncxyrpg7u7vocas@zj4zzxh53myv>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
 <n45ii7ekxeefuxw2ydwzsx7lqlfczbgg6obrzmzpytl2fin7j5@vbhmrptcjvcb>
 <a05e7dcc-7d8b-4db0-bd51-754184afb7c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a05e7dcc-7d8b-4db0-bd51-754184afb7c1@oss.qualcomm.com>
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

On Mon, Jul 13, 2026 at 12:55:52PM +0530, Kishore Batta wrote:
> 
> On 7/9/2026 11:49 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 01, 2026 at 04:07:38PM +0530, Kishore Batta wrote:
> > > The Sahara driver currently selects a firmware image table based on the
> > > attached device, but it does not recognize QDU100 devices that expose the
> > > protocol on the SAHARA MHI channel. As a result, the host cannot associate
> > > QDU100 devices with the correct firmware namespace during image transfer.
> > > 
> > > Extend the probe time variant selection to match the SAHARA MHI channel and
> > > associate it with the QDU100 firmware folder. Add a firmware lookup
> > > fallback for cases where an image does not have an explicit entry in the
> > > device's firmware table. This allows required images to be provisioned by
> > > the platform.
> > > 
> > > This change only affects devices matched on the SAHARA MHI channel and
> > > does not change behavior for existing AIC100 and AIC200 devices.
> > > 
> > > Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> > > ---
> > >   drivers/bus/mhi/host/clients/sahara/sahara.c | 27 +++++++++++++++--
> > >   drivers/bus/mhi/host/pci_generic.c           | 45 ++++++++++++++++++++++++++++
> > >   2 files changed, 70 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > index e339c67e236af271645ca81cc517efd9eead87e4..9adbd84859073d8024ba2a5fcfa33897439d6759 100644
> > > --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> > > @@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *context)
> > >   static int sahara_find_image(struct sahara_context *context, u32 image_id)
> > >   {
> > > +	char *fw_path;
> > >   	int ret;
> > >   	if (image_id == context->active_image_id)
> > > @@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
> > >   	}
> > >   	if (image_id >= context->table_size || !context->image_table[image_id]) {
> > > -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
> > > -		return -EINVAL;
> > > +		if (!context->fw_folder) {
> > > +			dev_err(&context->mhi_dev->dev,
> > > +				"Request for unknown image: %u (no fw folder)\n", image_id);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/%u",
> > > +				    context->fw_folder, image_id);
> > > +		if (!fw_path)
> > > +			return -ENOMEM;
> > > +
> > > +		ret = firmware_request_nowarn(&context->firmware,
> > > +					      fw_path,
> > > +					      &context->mhi_dev->dev);
> > > +		kfree(fw_path);
> > > +		if (ret) {
> > > +			dev_err(&context->mhi_dev->dev,
> > > +				"request for unknown image: %d\n", image_id);
> > > +			return -EINVAL;
> > > +		}
> > > +		context->active_image_id = image_id;
> > > +		return 0;
> > >   	}
> > >   	/*
> > > @@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
> > >   static const struct mhi_device_id sahara_mhi_match_table[] = {
> > >   	{ .chan = "QAIC_SAHARA", },
> > > +	{ .chan = "SAHARA"},
> > >   	{},
> > >   };
> > > +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
> > This change should belong to a separate patch.
> 
> There was a review comment from Jeff(v4, patch 3) to move to this change to
> the patch which adds QDU100 support so that it doesn't break bisect. Please
> let me know if i need to move it to a separate patch altogether ?
> 

Since it is a new device support for Sahara, bisect is not really a problem. But
I do see a value in keeping everything in a single patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
