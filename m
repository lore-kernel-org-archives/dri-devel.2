Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC6CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0776310FEC1;
	Fri,  9 Oct 2026 06:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PoLOy0JB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CE110FEB7;
 Fri,  9 Oct 2026 06:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791528208; x=1823064208;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9lLJ4PgzKT4QEgsMwa1RJl9IAa2IvjyvMd2JpBFhd7o=;
 b=PoLOy0JBXK/MVKbOmc3vp4Asj9ssosn0iR5hSVZQ6hk7iFUeEQpdBK8N
 Dmiy8HdAGF97HS65Rum/cPcXHkn1GzCN/MGVxy5rpOupf0HV1AWUTDJG8
 Flb1Cbl4vLIB4SJMusSRo1xNdlHkd+Lm1n1g0QmOuIN50wOVs6XQOvPhU
 Ox5an2AQ20I0Rs88l1j9ep3D3/3Kv0UDIozu6fsF3lZGNovorayxeeO5R
 USEUCLh+mbl6xLGuLBbNJb1lKBDizS53Y0loIKwm+MGznB9IpQUP7pXhi
 AsifGbgw+EwKi5bdAO8Psgb1hBjyOYUaX+xpi1p1vKDrBnQ1Eour4QQCz w==;
X-CSE-ConnectionGUID: 7NHLOm2cT7aTFSVqoDIFpw==
X-CSE-MsgGUID: qzFT5fyDTmWP+gE5LaApwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="196685"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="196685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 23:43:28 -0700
X-CSE-ConnectionGUID: kLcQtP0BTiuAymDcEiMh/g==
X-CSE-MsgGUID: bH3XVp/LQUevBdbqRubEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="570684"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 23:43:26 -0700
Date: Fri, 9 Oct 2026 08:43:22 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 brgl@kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] drm/xe/i2c: use device_create_managed_software_node()
Message-ID: <asiNCndYPAlM1p5u@black.igk.intel.com>
References: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
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

On Tue, Sep 22, 2026 at 04:25:55PM +0200, Bartosz Golaszewski wrote:
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
> ---
> This patch exists in mainline as commit fc90ce2d ("drm/xe/i2c: use
> device_create_managed_software_node()") but the code got silently
> overwritten by merge commit cc467969646b ("Merge drm/drm-next into
> drm-xe-next"). It should be reapplied.

Seeing this on drm-xe-next during driver unbind.

[ 8042.309896] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b73: 0000 [#1] SMP NOPTI
[ 8042.316397] [Poison overwritten] 0xff110001b3a7e838-0xff110001b3a7e847 @offset=26680. First byte 0x6a instead of 0x6b
[ 8042.316513] =============================================================================
[ 8042.316534] BUG kmalloc-512 (Tainted: G S   U      E      ): Object corrupt
[ 8042.316551] -----------------------------------------------------------------------------

[ 8042.316572] Allocated in swnode_register+0x35/0x260 age=42577 cpu=0 pid=381
[ 8042.316598]  swnode_register+0x35/0x260
[ 8042.316612]  fwnode_create_software_node+0xbe/0x180
[ 8042.316628]  device_create_managed_software_node+0x82/0xf0
[ 8042.316642]  xe_i2c_probe+0x1b8/0x260 [xe]
[ 8042.316939]  xe_device_probe+0x617/0x1000 [xe]
[ 8042.317109]  xe_pci_probe+0x539/0xb40 [xe]
[ 8042.317310]  local_pci_probe+0x47/0xa0
[ 8042.317322]  local_pci_probe_callback+0x1a/0x30
[ 8042.317334]  process_one_work+0x2ad/0x880
[ 8042.317347]  worker_thread+0x204/0x3e0
[ 8042.317357]  kthread+0x113/0x150
[ 8042.317367]  ret_from_fork+0x2dd/0x3c0
[ 8042.317379]  ret_from_fork_asm+0x1a/0x30
[ 8042.317391] Freed in software_node_release+0xa0/0x100 age=2 cpu=13 pid=6676
[ 8042.317409]  kfree+0x227/0x4c0
[ 8042.317418]  software_node_release+0xa0/0x100
[ 8042.317429]  kobject_put+0x8c/0x220
[ 8042.317440]  software_node_notify_remove+0xa5/0xe0
[ 8042.317450]  device_del+0x17b/0x3b0
[ 8042.317461]  platform_device_del.part.0+0x18/0x90
[ 8042.317475]  platform_device_unregister+0x24/0x40
[ 8042.317486]  xe_i2c_remove+0x84/0xa0 [xe]
[ 8042.317720]  devm_action_release+0x1a/0x20
[ 8042.317729]  release_nodes+0x3d/0x130
[ 8042.317738]  devres_release_all+0x96/0xd0
[ 8042.317749]  device_unbind_cleanup+0x2a/0xa0
[ 8042.317763]  device_release_driver_internal+0x21e/0x260
[ 8042.317775]  device_driver_detach+0x18/0x20
[ 8042.317785]  unbind_store+0xa8/0xb0
[ 8042.317794]  drv_attr_store+0x28/0x40
[ 8042.317804] Slab 0xffd4000006ce9e00 objects=21 used=17 fp=0xff110001b3a7dc00 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[ 8042.317830] Object 0xff110001b3a7e800 @offset=26624 fp=0xff110001b3a7dc00

Raag

> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
>  drivers/gpu/drm/xe/xe_i2c.h |  1 -
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 51ca9fb73b708317c5dd8613d0ba060b8dc2028e..f4f3819882897f7f19a7bd3043a936e3c7eec553 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -111,14 +111,9 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  {
>  	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
>  	struct platform_device *pdev;
> -	struct fwnode_handle *fwnode;
>  	int ret;
>  	u32 id;
>  
> -	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> -	if (IS_ERR(fwnode))
> -		return PTR_ERR(fwnode);
> -
>  	id = (pci_domain_nr(pci->bus) << 16) | pci_dev_id(pci);
>  
>  	/*
> @@ -128,14 +123,16 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	 * platform_device_register_full() is done.
>  	 */
>  	pdev = platform_device_alloc(adapter_name, id);
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
>  	pdev->dev.parent = i2c->drm_dev;
> -	pdev->dev.fwnode = fwnode;
> -	i2c->adapter_node = fwnode;
>  	i2c->pdev = pdev;
>  
>  	ret = platform_device_add(pdev);
> @@ -146,8 +143,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  
>  err_pdev_put:
>  	platform_device_put(pdev);
> -err_fwnode_remove:
> -	fwnode_remove_software_node(fwnode);
>  
>  	return ret;
>  }
> @@ -155,7 +150,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
>  {
>  	platform_device_unregister(i2c->pdev);
> -	fwnode_remove_software_node(i2c->adapter_node);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> index d63adacfefe71b3ae695987f104f978959a7e2c5..5969054a6b6b3f184857defd4ad3f6489f05aca0 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.h
> +++ b/drivers/gpu/drm/xe/xe_i2c.h
> @@ -33,7 +33,6 @@ struct xe_i2c_endpoint {
>  };
>  
>  struct xe_i2c {
> -	struct fwnode_handle *adapter_node;
>  	struct platform_device *pdev;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> 
> ---
> base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
> change-id: 20260922-xe-i2c-reapply-swnode-unreg-8e18b542549f
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
