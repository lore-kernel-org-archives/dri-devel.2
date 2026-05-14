Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E5CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BADD10E3D3;
	Thu, 14 May 2026 15:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QZFFGtOE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E5010E3D3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778771791; x=1810307791;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3JSzYpxyFAPAV18OpPQ8hxMvOxPJj8r25FHVoAq1sLQ=;
 b=QZFFGtOEsEy1ZTAoMON9lUf/yN+rByGdhGDswRy1+30idROtxUIqDq5p
 i1J4T1xhpgpBRdz6p0CJJjvAr1m/3Wge8vuLhyQpdTyDTX90gmls/EM18
 whOqVyWBIaiYx6i5vkfvudusQ+8ZwySci3TlPUjWPr7ZNTquP8zb7wKlM
 A20DaiAcrLlggx8WIigPnBpZ6ViowhdmnHvxSIRyJhYuS8hlQojmc2+v3
 2+6BX+ceoLUGXoOcngfmr0N7gXyxKoULwFEHhozgOCUdb89emZOBtgYIY
 s3/kdhD3B/og7/yGuCa1YyluSFsSKGUen0TQ+522f1YbeiqKOQnvBF1CM Q==;
X-CSE-ConnectionGUID: m5w+q0HUSAeQY/xZx9q/zQ==
X-CSE-MsgGUID: 1xoZqOVaT5+HxYfwCPZ5BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="102387182"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="102387182"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 08:16:30 -0700
X-CSE-ConnectionGUID: 9z/XXPDcTM+50CD6QaanwQ==
X-CSE-MsgGUID: fhG49Ti0RR+eO4LHkB7TBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="276490609"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 08:16:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 08:16:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 08:16:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 08:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2d8PIyTXeZp2GoWfuWQUIhTdQ69LUw/VnoVGGb9f1mh2wdEzUt/iAAhhqBUjHzSfz5XMvOfb7vYaHOYNjKDRt8brXathdKrKOhcMZQq7XffZDYRrwq1LJdQYpIvCaOQrTxWD4n6cIjLDCobqC4Ap6h6RJOBXAzH9ikgadkLbSqFvcjnVfBqL7ifRp0pQYfsB16UAxYUVCB8osnudMa+kA/CoQlTDEZ51IjKQUm/sf5TBQvLCRjMRtNln0hUw6pBO8ICBgqJ+KAOdd8Gh/6SsAiS8bYpZjjUl396i59WozqRC5ubkH5ynhRQYzmzJLSNXLvbfvRaM2YPmcCJy3BAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ubabcP+Wl0dRmN+mBBOln3XtU1GVSyPAvIZgcJuPCo=;
 b=R6lfHOcl7Sj+0LsKuWz18sfGVdBVyX8gehg0x1kmyPHx9+hNJLJnwwuD0aKi3Qs68aYEAUx87CRBSvhuHgRaAwE8TCvgumm50A7iiRf0BU5osSAghxdtKRsM2zzlTbFhZI7IKH9v4QoI4LQBy9mXZ7I+eFDlmyPeh1ufdAk6Zcc6V4hg9PPCLJokX9Tr+QDPSIjNCReEgBxnI1ruwuKMjKWHYz9C/2D1f/n2gdTq3bo6xGipMbUj6AQ9CC3v2cnXaR8+wcXQXlE33dQcOEJrevEQg8uJcDJQyYS5jpSlEhVY7h4DlvLQKIgDV6hTxTb5Ntr3uw7SdcjSWaLLZ0w9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:16:26 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9913.012; Thu, 14 May 2026
 15:16:25 +0000
Date: Thu, 14 May 2026 11:16:21 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/gem: Remove unneeded ret check in change handle ioctl
Message-ID: <agXnRdDmtGvIsmot@intel.com>
References: <20260511142540.2989187-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511142540.2989187-1-jonathan.cavitt@intel.com>
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: e95ad673-d3bd-4991-65f4-08deb1cbc3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: OK8EDCqhQM17Elp8VClvNMv3wGkHCqABJw+6/FK1ICzUDGohRgx35pGoxHm1/de0bKuB75nk/9SAAfqIp4AEdVIMaRfAjk/VzUJyNwWnWhF3xhQRmapOnu1yWev1D0qRkCSn0efiestmoHFgTArmV9R/BN1EC8POAD+oCOBczzxkkUGUJzp7tyEu4Ye+M7As7lcwvWmLe0q+zAUasr7MeIPYZz5hNiYTKpfiGZj8d/R2mFaR/dI6O3JbKw5yTXU+/TLkk4McKE2wcPRNxvJJgrVdzCKAfP5/R6Rf4jfrgEenoc2Ui0xT3OwSAGg6piRme4584bBB5dNeZ7sVi8AUhb6tqT5EYXo0GDM1+opEIQmq88XcJCq+2FFWYTA3S6aoD5n/oeoNcFCSZhzNuA9PqlZf5V11YLrGahexhcMgEc0i8JlLXEEsUCrsoQMrX+i6vSkBYeM73Goj0g5+a7xBVYj++SyvkYnbR8h9607AFx9xHjsb5VSXduUqOe4EADBBUif3zs1Zjb7BrtexYi4E8Bs+PYBwHl3wd3TKI5ZIvgXcseu7/8xFu51sp4F+Fv0hm0CE2iyCkoWynz/q9MmsQTPj6C7dOTntr+IgcUwCzZuxQQBVVO4OiON6zX7oqJsQou/RkmWGaj1QG3kJ63jWOrS2iGURWQh8DnJfLABBkpPVVf/mgTyHP683oc6F5MI9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+iEopyuUQEYFiTA0h3w7EhDVJOjrZNrO7mNQr2e9GSV5MkRhkLCT+UOaB4r?=
 =?us-ascii?Q?AC9G3OVq5ZRQGaqNv9qQlW3zBp3guclF1B47zPhNOFLmk6DOsMKE8LhZAOSw?=
 =?us-ascii?Q?cHVkWfS713QDCdKONfmogL3ZXrhoq/rG6ohbF0IorHc+kW3E9HNVy3RubzEN?=
 =?us-ascii?Q?shF8ko3Gd9WBHjMJS5AB6Fndl0xLHwLiSfcp+qpiPqFLboaFya2QB4SdR6RN?=
 =?us-ascii?Q?e2xizCevhEviBbV2umh2spHdMgC9vupfCLz4UF8tkQXqQAC9WceEYkIqMlXP?=
 =?us-ascii?Q?08GzknIAM7vC4no5x5IBz3OzuwQFGGVkdtwPS0vETXXppGz605Ai48mM1G8j?=
 =?us-ascii?Q?JfSaP0AAYcDw0QKjTAR/g1BF98kNui9GVaYNLxx5nAEU7bw8iafo+9FwkAuN?=
 =?us-ascii?Q?gDFSEWsPYVgt57DS1o6rXDPwMhRLwKb9nlItHe9ygv34knZ4USEuAfR158PT?=
 =?us-ascii?Q?DYN5yD+l7vNvTNQ1BsB7N7gqTuQv5HPgb0nuFGHmr4qiUGuB2KV738cOGzsh?=
 =?us-ascii?Q?uEV9kwyK7sPajxadFDfNKkvLhJlQIqH6VaxHByj0a97hgZ06vAaA1c5IH3Mh?=
 =?us-ascii?Q?bNUdO0wHj172LNfatYl6S2NnrlSnOUJG1h4VYxX1fx/mf0FIbKXjIysCAUvY?=
 =?us-ascii?Q?fJVeG+j+wvv4BUjVyII27EKX/h4Ysbu9/2xVzYQf9LNThhIKkcpnHZsFk33z?=
 =?us-ascii?Q?++jHeY32JYLZ45ofI8vLHGyHxCYcMKY8RuFROCxATMhPD+Sn07d4s6Nr4CGu?=
 =?us-ascii?Q?c2y70CCJZzn9PYQEKZYBpcpk8QyE9Va2F0NsTOoLVbTI2sTSpYoVmFzLu8nU?=
 =?us-ascii?Q?52V2XmSA50SZWTDoKzHJHPi/NmNKnv4Fq06g4INVC+7+Nqo/ga0fFwluAwlq?=
 =?us-ascii?Q?azngpHKpflDhbZU9D9V2fz0f//YGMbmz09lnMrrB9o2g70Gs9PZGQAydjUmY?=
 =?us-ascii?Q?tqxBvPavhT5Z8qB165yv+8ZFkMhSxXyJfpr/6Shndm8X+L8PO2vptDKqGIwY?=
 =?us-ascii?Q?PYlTRnAOap7Ls0WDtCzF25n68sKAlQvljudFuGn2cR2HqXxmZ62ZlU+IQTIm?=
 =?us-ascii?Q?8aBKX1fKAuuoFe9ZOKOTUXAXs9mZP74vt4WZWu1L9vlmHpcd4iBpOk2LKvsm?=
 =?us-ascii?Q?DLVj4J6/AcgqI9MsA81WS6a5hBWmkWc+/agqkK0vFrQcntU7vwcjXiahiz2a?=
 =?us-ascii?Q?YU8QdxnaFyFWRCuOXp9hlTYTzhCbmq+GTopvDL/bITSzFwJJRmZXUjOFpMMF?=
 =?us-ascii?Q?I5Vq4/ZrwwJmp4pLFWJ5ZE2rmPtap1HGzsFTvrHd94/9gX8Znqm09xKB1XBY?=
 =?us-ascii?Q?93sin2Tuu/S2631w/PCYkr4DQ+ZP6f/oEsJEXMhe8HdhYI0rI6vM0OgQmLXR?=
 =?us-ascii?Q?eKbGW3rsASKx7yWaJ7GSmmqr6UARy93DQ0mE7cgBKW22U/m2OiHtteJC5oOL?=
 =?us-ascii?Q?IMNsx6sP/+NN9UNmGCdYOD1tr/lfB8djZTCnjsNkY0noBdzLT/w9WdlGNH8Q?=
 =?us-ascii?Q?GLhA1QYrWj76MlCweNBYYrvvBvC5l5L1dLPMX+R9pidc1Axj6oD03mVgW8g0?=
 =?us-ascii?Q?3Y82npdXfVwnJyIzeOkYvkAOuQNAMMUBQByM0FHZt4cr+vgVm1J/eMWIzT6Z?=
 =?us-ascii?Q?lrP0QUU+IwPYH6O1nI8+G9M3Wcp8v08PRpHTqRh3JYN6KE+68oVkKh5MkjT0?=
 =?us-ascii?Q?p7IB4Pg4W9fNYTphst2Qpb3gSrdqS33aq8HDyrmPrAqc02cZpnfY6n0xQxlJ?=
 =?us-ascii?Q?ttsWO3eILw=3D=3D?=
X-Exchange-RoutingPolicyChecked: rfVoL2qr9FiqyuUfmS94U4qlH0ikTvGOc8rYz497M7soDwEW2zsnMkfUZIqg18CYWJJr07Uk40o9dok5mJ6hWZj64cwE+QT32M0SxGPgZ4rBBXyD5hPPPUkW3HIO2jpDthL2rubTkBl5mjOuoJ7hOUoYh0XfrMQPY8+jnmJLM0ghKkCHYgsvPfnhYZiB+gPTsx0LfY4uqp5Do3iogNPPcDPYjY4nTRtk3Bu2YJXjs6p5SP50K05sOMGvQEnRGJI0d8nKghjm4hanN7rb7oMylmfdj1KVfjzHA8C7aMsHqZ83ZfmmuJZY2t+0OGKJt2P5o00sCv245qlt0i9maRqVUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e95ad673-d3bd-4991-65f4-08deb1cbc3dc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 15:16:25.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM4osH7mjG4jaWOmsRLN0wu7c59/kJcbU4UPYSRmYqJVd9FFRT9+AnrNkh0mP5IPZcKMN6f4h0saHYmFD2EiAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com
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

On Mon, May 11, 2026 at 10:25:40PM +0800, Jonathan Cavitt wrote:
> Remove the "if (ret < 0)" branch after idr_replace in
> drm_gem_change_handle_ioctl.  It is unused, as in the only place we
> modify the return value between there and the previous return value
> check, we also immediately jump to out_unlock, bypassing the check
> entirely.
> 
> Issue caught by static analysis.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_gem.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index abc8e41d6652..110bc5a58862 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1067,9 +1067,6 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  
>  	spin_unlock(&file_priv->table_lock);
>  
> -	if (ret < 0)
> -		goto out_unlock;
> -
>  	if (obj->dma_buf) {
>  		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
>  					       handle);
> -- 
> 2.53.0
> 
