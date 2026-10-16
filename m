Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281CCCF2C1
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F44112A4E;
	Fri, 16 Oct 2026 22:49:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB14112A25;
 Fri, 16 Oct 2026 22:49:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E59746022E;
 Fri, 16 Oct 2026 22:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE33B1F000C4;
 Fri, 16 Oct 2026 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792190954;
 bh=scthorKrG8eAJYWdzqIYf09NTRv0K0CrY9Go6fw5xwc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XQBLIWrnR2vcp0RxEUEaQaOJ34wkca3U54iqZe7dcL+RStYpwT/OQyY+U+URo7ZW+
 trIp+ywRavPwwFm/2ilCbsaLE4TbykGcyu1WpCZI/Puvo+ctmJU6PtenQsbduroLx2
 EvYc3P1PYB9Fipzk3vXfoqbBn6a55LtS5eXT0HBtXmhJ10rjTO8xF7HM90GYRAe9Bg
 +mBN2827tpPwnwFPSBB8ZQ3YDZwOUlfGk/Z73sg3HFM9eK2QTRmFB5R3zUJFDCr18+
 ZY/mx7OapgPJpscZy/XVqoPcaOgOvvfZtX6drVHkIYZr2Urzg6ykGIqdILF+OUqMiD
 kJdnUyC/e8xvw==
Date: Fri, 16 Oct 2026 15:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
Message-ID: <20261016154913.1af64e88@kernel.org>
In-Reply-To: <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  7 Oct 2026 13:33:53 +0530 Aravind Iddamsetty wrote:
> +  -
> +    name: retired-resource-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this retired resource operation.
> +      -
> +        name: vram-page
> +        type: nest
> +        nested-attributes: vram-page-attrs

why wrap attrs in a nest? Are you planning to add other resource types
(than a page)? It's a common anti-pattern in Netlink to over-wrap stuff.

> +        doc: >-
> +             Type-specific payload. The resource type is identified by the
> +             node (its node-name); each node reports a single resource type.
> +  -
> +    name: vram-page-attrs
> +    attributes:
> +      -
> +        name: address
> +        type: u64
> +        doc: Device address of the retired VRAM page (e.g. DPA).
> +      -
> +        name: size
> +        type: u64

prefer uint

> +        doc: Size of the retired VRAM page in bytes.
> +      -
> +        name: max-pages
> +        type: u32
> +        doc: >-
> +             Maximum VRAM pages that can be retired. Present only in the
> +             leading summary entry of the dump (no address/size/status).
> +      -
> +        name: status
> +        type: u32
> +        doc: Retirement status of the retired VRAM page.
> +        enum: retired-resource-status
> +      -
> +        name: pad
> +        type: pad

And then you won't need pad
