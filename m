Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BE2CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4820C10F32C;
	Wed, 30 Sep 2026 11:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mDJ1jVtY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C0010F32C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:52:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3289D40592;
 Wed, 30 Sep 2026 11:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4994B1F000FF;
 Wed, 30 Sep 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769155;
 bh=gxYxNZzDeVuaR0kHtBi1lxp+gKcX+Q3q3h7snJzMS2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mDJ1jVtYKrylk9FoBnzYRGNnYzm9Qqb1imba6IhnOdaM+Mx5qbZKZ66MWevBJUXuh
 EuR6olQr9kMQU+xj1D1/mNQz0kizmN7a8j6b8yTfhkwdO6SGfncWcJu+gkDyu0XMdW
 yXf+PP3G7jJGFzmK2UOgPbZcf8BP1WhGC6qabkYoN5EplmUV/2owDCvCmimwFTSCKm
 EbqEkX6Rh140cf4tQyinjV2/NANSyC88mhmL+FSvnzI5Hv+egKns6ewHdemR1hfSfR
 ou1rwVHC/xRyNubpzDlJSnV0O5T0BDi0aqqV1ygC2bd7a8BghOZAM9a/rxGIs8uTVE
 itQb47Gg8njXA==
Date: Wed, 30 Sep 2026 12:53:05 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 3/8] misc/arm-cla: Probe firmware-described devices
Message-ID: <20260930115305.GC480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-4-ryan.roberts@arm.com>
 <20260717105709.172911F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717105709.172911F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 10:57:08AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/misc/arm-cla/cla-topology.c b/drivers/misc/arm-cla/cla-topology.c
> > --- /dev/null
> > +++ b/drivers/misc/arm-cla/cla-topology.c
> 
> [ ... ]
> 
> > +struct cla_domain *cla_dev_domain_get(struct cla_dev *dev)
> > +{
> > +	int ret;
> > +	unsigned int domain_id;
> > +	struct cla_domain *domain;
> > +
> > +	/* Domain ID is provided by firmware */
> > +	ret = of_property_read_u32(dev->dev->of_node, "domain", &domain_id);
> > +	if (WARN_ON(ret))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	domain = xa_load(&cla_domains, domain_id);
> > +	if (domain) {
> > +		domain->nr_devs++;
> > +		domain->devs = krealloc_array(domain->devs, domain->nr_devs,
> > +					      sizeof(*domain->devs), GFP_KERNEL);
> 
> [Severity: High]
> Does this code leak the original domain->devs array if krealloc_array() fails
> and returns NULL?

Yes, needs fix

> Also, since domain->nr_devs was unconditionally incremented,
> will a subsequent call to cla_domains_finalise() dereference the NULL
> pointer at domain->devs[j]?

No subsequent call

> 
> > +		if (!domain->devs)
> > +			return ERR_PTR(-ENOMEM);
> > +		domain->devs[domain->nr_devs - 1] = dev;
> > +		return domain;
> > +	}
> > +
> > +	domain = cla_domain_alloc(dev, domain_id);
> > +	if (IS_ERR(domain))
> > +		return domain;
> > +
> > +	cla_nr_domains = max(domain_id + 1, cla_nr_domains);
> 
> [Severity: Medium]
> Can this calculation overflow to 0 if firmware provides a domain_id of
> UINT_MAX? If it overflows, will cla_domains_finalise() skip its loop and
> leave the device uninitialized in the lookup tables?

FW does not provide UINT_MAX as domain ID

