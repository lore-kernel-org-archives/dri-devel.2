Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE7C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472E710EC50;
	Tue, 22 Sep 2026 10:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gVRMHA5b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA2310EC50;
 Tue, 22 Sep 2026 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790073054; x=1821609054;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rVx1Ga7x8BB7Zg2M0CRdnA2F5rr3KdLyeWxelvYMHFw=;
 b=gVRMHA5bL4bJxQ944N3HDOPPD/iX9M3byoW4Km6Me5YupaVIuXniP+qU
 VgbxpqzynxQDJ6yzsnl8vvrhqDI7YcwnvyBLb3+TaldpeKO4Fxiy0RFDP
 bmKDhRvtTeohPccgRrwof9Au+mpc26OD+ZSPoHRQIhdyV3zSCx6ZGusjp
 zvos5sLXh8ee9WEu4T0Nz3psXCZDZI6EPDveJOtIWEvi8MN7CO1fMWEHw
 GW0fcfH777LiywZ8PIv9v8NaUEsDIePlZMvNKZicP3+/TKB9892Z83QVJ
 Ehm4d+c1B2s1NsgDeRWKEStDKRi0YIxX3n8LsLfVNIXSi3fD0qIDsbqol g==;
X-CSE-ConnectionGUID: oE+ujCVnRdOBLTARBWv5Rg==
X-CSE-MsgGUID: mNdXrcR7Sb23lXyi3DBr7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1164182"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1164182"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:30:53 -0700
X-CSE-ConnectionGUID: Kz5491BaRBSQ0kKLpKPzIg==
X-CSE-MsgGUID: bONz6f9cQtSVZtD98Mi9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4062790"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa012.fm.intel.com with ESMTP; 22 Sep 2026 03:30:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 1ACFC99; Tue, 22 Sep 2026 12:30:45 +0200 (CEST)
Date: Tue, 22 Sep 2026 12:30:45 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, brgl@kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v8 3/5] drm/xe/i2c: use
 device_create_managed_software_node()
Message-ID: <arJY1TMBIZCy8E7n@black.igk.intel.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
 <20260716-swnode-remove-on-dev-unreg-v8-3-5c2b8cc38c28@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-3-5c2b8cc38c28@oss.qualcomm.com>
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

On Thu, Jul 16, 2026 at 02:31:38PM +0200, Bartosz Golaszewski wrote:
> This driver intentionally uses the fine-grained approach to creating
> platform devices. It assigns a software node as the primary firmware
> node of the device it creates. Ahead of improving the reference counting
> of platform device software nodes, switch to using
> device_create_managed_software_node(). This way, we create a dynamic
> software node whose life-time is tied to the device to which it's
> assigned.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

What happened to this one? I can see the commit 0f485f88656a
("drm/xe/i2c: use device_create_managed_software_node()"), but not the
code change?

There is no revert and there are no other commits touching this part
of the driver, so it's as if the patch was never actually applied?

Thanks,

> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
>  drivers/gpu/drm/xe/xe_i2c.h |  1 -
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 3d80eafb9a1318996d10db11e14af4cfde07ba55..af6e973e5e68125a9c006bb646447ca6e377a6e6 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -93,13 +93,8 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  {
>  	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
>  	struct platform_device *pdev;
> -	struct fwnode_handle *fwnode;
>  	int ret;
>  
> -	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> -	if (IS_ERR(fwnode))
> -		return PTR_ERR(fwnode);
> -
>  	/*
>  	 * Not using platform_device_register_full() here because we don't have
>  	 * a handle to the platform_device before it returns. xe_i2c_notifier()
> @@ -107,10 +102,14 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	 * platform_device_register_full() is done.
>  	 */
>  	pdev = platform_device_alloc(adapter_name, pci_dev_id(pci));
> -	if (!pdev) {
> -		ret = -ENOMEM;
> -		goto err_fwnode_remove;
> -	}
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	ret = device_create_managed_software_node(&pdev->dev,
> +						  xe_i2c_adapter_properties,
> +						  NULL);
> +	if (ret)
> +		goto err_pdev_put;
>  
>  	if (i2c->adapter_irq) {
>  		struct resource res;
> @@ -123,8 +122,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	}
>  
>  	pdev->dev.parent = i2c->drm_dev;
> -	platform_device_set_fwnode(pdev, fwnode);
> -	i2c->adapter_node = fwnode;
>  	i2c->pdev = pdev;
>  
>  	ret = platform_device_add(pdev);
> @@ -135,8 +132,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  
>  err_pdev_put:
>  	platform_device_put(pdev);
> -err_fwnode_remove:
> -	fwnode_remove_software_node(fwnode);
>  
>  	return ret;
>  }
> @@ -144,7 +139,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
>  {
>  	platform_device_unregister(i2c->pdev);
> -	fwnode_remove_software_node(i2c->adapter_node);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> index 425d8160835f4648891ff75f2a9c06284241710e..b28229f056c5a664e1d41dc0cc1978782fe1c2f1 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.h
> +++ b/drivers/gpu/drm/xe/xe_i2c.h
> @@ -30,7 +30,6 @@ struct xe_i2c_endpoint {
>  };
>  
>  struct xe_i2c {
> -	struct fwnode_handle *adapter_node;
>  	struct platform_device *pdev;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> 
> -- 
> 2.47.3

-- 
heikki
