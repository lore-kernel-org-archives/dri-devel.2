Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F48CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CF510E855;
	Tue, 16 Jun 2026 07:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MNnoiPxn";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9817210E855
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZxr/9VVVrgP5iFH6dMLu2lZs35O33JbY9wX8symkrfMpv03waHtI0DMR+/kXf113EA6yt9LThwZ8SeSM50wX/3fHBBxhGcwGJ9/le5am2czXPyifKIDREL6zp/Zx+ccKZ60bgoqV8Jk0qFQ4id7ubDQldwKhP7eBeMOd31teGfosTR9NlBwi0bB2hPSCUY9uQ8XTfC3YPRzz/5k/yjtcqSlaQVBA8ivKx0rtXNcdfl1/btgztgFDAxCuMEPUqeILOUJ3gvt+uoqbaikgn9lLDlGVgygQUGJ9W1q2/zaaqrWY06epx+wSBWmHdS7jtivqZ17gq0pPmPu2wa4j+NPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liy4f5SAQamkiTbHQta8LJs8fk0Zs92rX2D+m4vkYkI=;
 b=ZAND186VjVPgYN3nAFzo1YuhasstfTTenwx6P0PZwxEdenSiy0/UFI5TNvqv/iMc/nHRMZ2vCcAJsxkAE+URKR4DYvAkDTiyWe96vDAaJHKeHuKAFXoHOe46iNj48X1l+wx8AGvDfYTpJ+8ScZoD1b+j+x65LiQ5tPnfeIRiobSH+Jw58nVumhS3uzwkPY+jMdw9Ccilx8Mg9myxyQq8Q5qSCmz+BPhwB7MovfbGAUUB7s0YW4BGKC2VZ/Pfs5yDmc8S0GreB2jlOO+16idPSUkJWYH8DuEO1aA8phh7XWiovOmrgBV0X8et7adosRjin8tTtGNOt2FJYJf/Wnk0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liy4f5SAQamkiTbHQta8LJs8fk0Zs92rX2D+m4vkYkI=;
 b=MNnoiPxn29RYZDJWACdqVuApK0CWxG7wgzUNz3komemLZ5VGtPQasQjASBGETlPwWrlKhGdroT0nSszjNYpktOXfuJjOpz6RViBZ5ue5p15eEErtCWaGlrrjEPR15uqZppxsVp+y3U8ZlMsI++GzA9dagnzaepAO+ZJUPEIzvPk=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by IA4PR10MB8686.namprd10.prod.outlook.com (2603:10b6:208:56f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:08:26 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::56) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 07:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 07:08:26 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 02:08:24 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 02:08:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 02:08:24 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65G78Jdj3662807;
 Tue, 16 Jun 2026 02:08:20 -0500
Message-ID: <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
Date: Tue, 16 Jun 2026 12:38:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Wig
 Cheng <onlywig@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA4PR10MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 473d3b97-c28b-46dc-344b-08decb760fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|18002099003|22082099003|921020|6133799003|5023799004|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: Ncf7K2w4qF7MCRjEMdwdW0zzrD1DrS/BQH7IJz41jHVt39HP3ZayiZkR8aX1xhwHoEAEr40MQfij73knueuphqNC8YE198jZo1dCl3SCS6Zx69m2dRhOk8nYrSbyR4W7fRxy87VU0mVm2TMgM+BaLE90vM89cNa3j+W+2j8VGap4QXDsuX8ThcYsFvaVoLopK9utVQrcIeADTA/GtWNIFx22xdGZpN4a7USEFaHUZO37Vcky9cdev1cmLdYoI/9wGqaVlG3NhfwIno6/Np/V3tJnZ4mFmfHaXbI1ySU8xzEPBwm5mH4soWXxCBIAcIU9bKuxmziaPKOyCYIL07WgTFO/E3rA8q14snyR8wkPKgUfwOttAc5hAvdW9ghmV5Wg1gWD//qkwH4BoEVvpCZp0DT/Ent6siUF5em6rZ6gwlV4KleUyycirMKMf/pPEbsYaaRN4UJW7o9uaVZpvwzGBQlkU9jkLP046UU5b5ArKm+9i+UFfLkB/cr6RuqKjmULJUaTbjfiSsU05iTiAWQtJsxtAKRLL3C40ANjWO7jamJO7rhT2wRWqZzk9Xq5hzfZeaiBbaeyu4DFeJE8dRpNZ7p+GiN/oXRPWZN46wqZEjuj5TfwWWJ1/STujLWlCZ1E4DAwSNGF8GaBbUkSm5tBngaTIfIvozUPdDuXiEsEBgT5VPLsPvmxOSwuQQ6zXqFUhE6gZWYjAuH423kRAgGAFtaJLuIEYp0moRWTwRMUfQU=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(921020)(6133799003)(5023799004)(4143699003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZl3pY1khXkojsmLV9ORJxFpOvskSAqS6Bq9fwXb+PMya0SfJoZAusRnYQYiokF/DRTbioQ2cOTwmN1jB+IoE7SU6ost1HeWdn27jtKOQA9k7c1w6oFj9LTR1v7nWKH9YD471qv2O/UensZqe9rwKWjXuYHetrCxx6V9Gz19iWc4s8/oTUSAql7/Do6mo9K0OOxcRl1Wb83gSmk9ww2s7bxfe4Ipy7IiPBKkdoRCazm97PpBQOF59ioG3XPicowkm4IgGmBW2PMU62a5ZSkgX35kM58Cycn5mTe/HgSnmuht4PwZlgrmMv9bEHbApedA6k8G8iUTag1DcF+VRVbguvqmhIoFF0gsYRfp9jZpnQuDudOvby5NN4jjkhujAKukBeo4+zSGyRf0OWnE0J6SSQ9VQ4SjFDP7dQVkt99IY/LwI8hJUSTbPo/5DxAWkUZc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:08:26.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473d3b97-c28b-46dc-344b-08decb760fe1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8686
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

Hi LiangCheng,

Thanks for the patch.

On 29/05/26 16:01, LiangCheng Wang wrote:
> Introduce a DRM driver for the Mayqueen Pixpaper 4.26
> monochrome e-ink display panel, which is controlled via SPI.
> The driver supports an 800x480 display with XRGB8888
> framebuffer input.
> 

1) Could you please share the datasheet for the display controller used 
inside this pixpaper version ?

The PIXPAPER 4.26 command set matches the Solomon SSD1683 almost exactly 
as documented in the SSD1683 datasheet [0]. It can also be seen that the 
macro values match exactly as well with the posted driver [1].

The only material difference is the ctrl2 update byte 0xF4 vs the 
SSD1683 documented sequences (0xFF for BW full refresh, 0xF7 for 
3-color). 0xF4 omits the final Disable Analog + Disable OSC bits that 
SSD1683 normally expects.

2) Does 0xFF or 0xF7 mode work as well for your display or is it 
strictly 0xF4 which seems to mean that analog and osc bits are disabled 
?
  
  

3) Also could you confirm which display controller IC does the PIXPAPER 
4.26 use ? If it is SSD1683 (or any other ssd16xx variant), it would be 
appropriate to add this panel as a new display panel entry in
panel-ssd16xx.c rather than a separate driver to avoid code duplication.
You can refer how "Good Display GDEY042T81" was added for e.g. it should 
be something like :

   [PIXPAPER426M] = { 
  

       .data_entry_mode            = SSD16XX_DATA_ENTRY_XINC_YINC, 
  

       .driver_output_ctrl_byte3   = 0x02,  /* SM=1 interlaced scan */ 
  

       .default_refresh_mode       = SSD16XX_REFRESH_FULL, /* single 
mode: 0xF4 */ 

       .default_border_waveform_init   = SSD16XX_BORDER_LUT1, 
  

       .default_border_waveform_update = SSD16XX_BORDER_LUT1, 
  

       .default_clear_on_init      = -1, 
  

       .default_clear_on_disable   = -1, 
  

       .red_supported              = false, 
  

       .mode                       = &pixpaper426m_mode, 
  

   },

and a new compatible entry :
   static const struct of_device_id ssd16xx_of_match[] = { 
  

       { .compatible = "gooddisplay,gdey042t81",   .data = (void 
*)GDEY042T81  }, 

       { .compatible = "mayqueen,pixpaper-426m",   .data = (void 
*)PIXPAPER426M }, 

       { } 
  

   }; 
  


[0] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[1] : https://lore.kernel.org/all/20260430183311.2978142-4-devarsht@ti.com/

Kindly let me know if any queries.

Regards
Devarsh

> Also, add Kconfig and Makefile entries for the driver and
> update MAINTAINERS for the Pixpaper DRM drivers and binding.
> 
> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
>   MAINTAINERS                          |   3 +-
>   drivers/gpu/drm/tiny/Kconfig         |  16 +
>   drivers/gpu/drm/tiny/Makefile        |   1 +
>   drivers/gpu/drm/tiny/pixpaper-426m.c | 817 +++++++++++++++++++++++++++++++++++
>   4 files changed, 836 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db53bb8cc8e75b5d2269ee0591ea20..eebd73ee1f531d3785ec963da03fbab265c2d188 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8234,11 +8234,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	Documentation/devicetree/bindings/display/repaper.txt
>   F:	drivers/gpu/drm/tiny/repaper.c
>   
> -DRM DRIVER FOR PIXPAPER E-INK PANEL
> +DRM DRIVER FOR PIXPAPER E-INK PANELS
>   M:	LiangCheng Wang <zaq14760@gmail.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> +F:	drivers/gpu/drm/tiny/pixpaper-426m.c
>   F:	drivers/gpu/drm/tiny/pixpaper.c
>   
>   DRM DRIVER FOR QEMU'S CIRRUS DEVICE
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a4709564e63c758e857bdb4a320dbe7..028c4314106ac31dfa717f6433c28e58b34c21e8 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -98,6 +98,22 @@ config DRM_PIXPAPER
>   
>   	  If M is selected, the module will be built as pixpaper.ko.
>   
> +config DRM_PIXPAPER_426M
> +	tristate "DRM support for PIXPAPER 4.26 monochrome display panel"
> +	depends on DRM && SPI
> +	depends on MMU
> +	select DRM_CLIENT_SELECTION
> +	select DRM_GEM_SHMEM_HELPER
> +	select DRM_KMS_HELPER
> +	help
> +	  DRM driver for the Mayqueen Pixpaper 4.26 monochrome e-ink
> +	  display panel.
> +
> +	  This driver supports SPI-connected 800x480 monochrome panels
> +	  with an XRGB8888 framebuffer input format.
> +
> +	  If M is selected, the module will be built as pixpaper-426m.ko.
> +
>   config TINYDRM_HX8357D
>   	tristate "DRM support for HX8357D display panels"
>   	depends on DRM && SPI
> diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
> index 48d30bf6152f979404ac1004174587823a30109e..037b751a1a851cc2f86f701ff71008bcb9c59f29 100644
> --- a/drivers/gpu/drm/tiny/Makefile
> +++ b/drivers/gpu/drm/tiny/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_CIRRUS_QEMU)		+= cirrus-qemu.o
>   obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
>   obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
>   obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
> +obj-$(CONFIG_DRM_PIXPAPER_426M)         += pixpaper-426m.o
>   obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
>   obj-$(CONFIG_TINYDRM_ILI9163)		+= ili9163.o
>   obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
> diff --git a/drivers/gpu/drm/tiny/pixpaper-426m.c b/drivers/gpu/drm/tiny/pixpaper-426m.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..99464d564f315543037a3621ff85f98f1bd8f34c
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/pixpaper-426m.c
> @@ -0,0 +1,817 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DRM driver for PIXPAPER 4.26 monochrome e-ink panel
> + *
> + * Author: LiangCheng Wang <zaq14760@gmail.com>,
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +
> +#include <drm/clients/drm_client_setup.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fbdev_shmem.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +
> +MODULE_IMPORT_NS("DMA_BUF");
> +
> +/* Panel visible resolution */
> +#define PIXPAPER_WIDTH    800
> +#define PIXPAPER_HEIGHT   480
> +
> +/*
> + * The panel datasheet specifies an active area of 92.8 mm x 55.68 mm.
> + * Round to whole millimeters for drm_display_info.
> + */
> +#define PIXPAPER_WIDTH_MM   93
> +#define PIXPAPER_HEIGHT_MM  56
> +
> +/*
> + * According to the panel datasheet, no RGB-style timing parameters
> + * (porches, sync widths, or a dot clock) are provided. Define a minimal
> + * fixed mode only to satisfy the DRM mode API for this SPI-driven
> + * e-paper panel.
> + */
> +#define PIXPAPER_HSYNC_LEN     1
> +#define PIXPAPER_HFRONT_PORCH  1
> +#define PIXPAPER_HBACK_PORCH   1
> +#define PIXPAPER_VSYNC_LEN     1
> +#define PIXPAPER_VFRONT_PORCH  1
> +#define PIXPAPER_VBACK_PORCH   1
> +#define PIXPAPER_MODE_REFRESH_HZ 1
> +#define PIXPAPER_MODE_CLOCK_KHZ \
> +	(((PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH + PIXPAPER_HSYNC_LEN + \
> +	   PIXPAPER_HBACK_PORCH) * \
> +	  (PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH + PIXPAPER_VSYNC_LEN + \
> +	   PIXPAPER_VBACK_PORCH) * \
> +	  PIXPAPER_MODE_REFRESH_HZ) / 1000)
> +
> +#define PIXPAPER_SPI_BITS_PER_WORD 8
> +#define PIXPAPER_SPI_SPEED_DEFAULT 1000000
> +
> +#define PIXPAPER_TX_BUF_SIZE 8
> +
> +#define PIXPAPER_PIXEL_THRESHOLD 128
> +
> +#define PIXPAPER_BUSY_TIMEOUT_MS 10000
> +#define PIXPAPER_BUSY_POLL_INITIAL_US_MIN 1000
> +#define PIXPAPER_BUSY_POLL_INITIAL_US_MAX 1500
> +#define PIXPAPER_BUSY_POLL_US_MIN 100
> +#define PIXPAPER_BUSY_POLL_US_MAX 200
> +
> +#define PIXPAPER_RAM_START_ADDR 0x00
> +
> +#define PIXPAPER_LUMA_R_WEIGHT 299
> +#define PIXPAPER_LUMA_G_WEIGHT 587
> +#define PIXPAPER_LUMA_B_WEIGHT 114
> +#define PIXPAPER_LUMA_DIVISOR 1000
> +#define PIXPAPER_LUMA_ROUNDING_BIAS 500
> +
> +#define PIXPAPER_CMD_DRIVER_OUTPUT_CTRL      0x01
> +#define PIXPAPER_CMD_BOOSTER_SOFT_START_CTRL 0x0C
> +#define PIXPAPER_CMD_TEMP_SENSOR_CONTROL     0x18


> +#define PIXPAPER_CMD_MASTER_ACTIVATION       0x20
> +#define PIXPAPER_CMD_DISPLAY_UPDATE_CTRL2    0x22
> +#define PIXPAPER_CMD_WRITE_RAM_BW            0x24
> +#define PIXPAPER_CMD_BORDER_WAVEFORM_CONTROL 0x3C
> +#define PIXPAPER_CMD_SET_RAM_X_START_END     0x44
> +#define PIXPAPER_CMD_SET_RAM_Y_START_END     0x45
> +#define PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER  0x4E
> +#define PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER  0x4F
> +


> +#define PIXPAPER_DRIVER_OUTPUT_SM                BIT(1)
> +
> +#define PIXPAPER_BORDER_WAVEFORM_GS_TRANSITION   (0x0 << 6)
> +#define PIXPAPER_BORDER_WAVEFORM_LUT1_SEL        0x1
> +
> +#define PIXPAPER_UPDATE_CTRL2_ENABLE_CLK         BIT(7)
> +#define PIXPAPER_UPDATE_CTRL2_ENABLE_ANALOG      BIT(6)
> +#define PIXPAPER_UPDATE_CTRL2_LOAD_TEMP          BIT(5)
> +#define PIXPAPER_UPDATE_CTRL2_LOAD_LUT           BIT(4)
> +#define PIXPAPER_UPDATE_CTRL2_PATTERN_DISPLAY    BIT(2)
> +
> +#define PIXPAPER_TEMP_SENSOR_INTERNAL           0x80
> +#define PIXPAPER_SOFTSTART_A                    0xAE
> +#define PIXPAPER_SOFTSTART_B                    0xC7
> +#define PIXPAPER_SOFTSTART_C                    0xC3
> +#define PIXPAPER_SOFTSTART_D                    0xC0
> +#define PIXPAPER_SOFTSTART_E                    0x80
> +#define PIXPAPER_DRIVER_OUTPUT_GD_SM_TB         PIXPAPER_DRIVER_OUTPUT_SM
> +#define PIXPAPER_BORDER_LUT1                    \
> +	(PIXPAPER_BORDER_WAVEFORM_GS_TRANSITION | \
> +	 PIXPAPER_BORDER_WAVEFORM_LUT1_SEL)
> +#define PIXPAPER_UPDATE_INITIAL                 \
> +	(PIXPAPER_UPDATE_CTRL2_ENABLE_CLK | \
> +	PIXPAPER_UPDATE_CTRL2_ENABLE_ANALOG | \
> +	PIXPAPER_UPDATE_CTRL2_LOAD_TEMP | \
> +	PIXPAPER_UPDATE_CTRL2_LOAD_LUT | \
> +	PIXPAPER_UPDATE_CTRL2_PATTERN_DISPLAY)
> +struct pixpaper_error_ctx {
> +	int errno_code;
> +};
> +
> +struct pixpaper_init_seq {
> +	u8 cmd;
> +	const u8 *data;
> +	u8 len;
> +};
> +
> +struct pixpaper_panel {
> +	struct drm_device drm;
> +	struct drm_plane plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +
> +	struct spi_device *spi;
> +	struct gpio_desc *reset;
> +	struct gpio_desc *busy;
> +	struct gpio_desc *dc;
> +
> +	u8 *tx_buf;
> +};
> +
> +static const uint32_t pixpaper_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const u8 pixpaper_init_temp_sensor[] = {
> +	PIXPAPER_TEMP_SENSOR_INTERNAL,
> +};
> +
> +static const u8 pixpaper_init_softstart[] = {
> +	PIXPAPER_SOFTSTART_A,
> +	PIXPAPER_SOFTSTART_B,
> +	PIXPAPER_SOFTSTART_C,
> +	PIXPAPER_SOFTSTART_D,
> +	PIXPAPER_SOFTSTART_E,
> +};
> +
> +static const u8 pixpaper_init_driver_output[] = {
> +	(PIXPAPER_HEIGHT - 1) & 0xff,
> +	(PIXPAPER_HEIGHT - 1) >> 8,
> +	PIXPAPER_DRIVER_OUTPUT_GD_SM_TB,
> +};
> +
> +static const u8 pixpaper_init_border[] = {
> +	PIXPAPER_BORDER_LUT1,
> +};
> +
> +static const u8 pixpaper_init_ram_x_window[] = {
> +	PIXPAPER_RAM_START_ADDR,
> +	PIXPAPER_RAM_START_ADDR,
> +	(PIXPAPER_WIDTH - 1) & 0xff,
> +	(PIXPAPER_WIDTH - 1) >> 8,
> +};
> +
> +static const u8 pixpaper_init_ram_y_window[] = {
> +	PIXPAPER_RAM_START_ADDR,
> +	PIXPAPER_RAM_START_ADDR,
> +	(PIXPAPER_HEIGHT - 1) & 0xff,
> +	(PIXPAPER_HEIGHT - 1) >> 8,
> +};
> +
> +static const u8 pixpaper_init_ram_x_counter[] = {
> +	PIXPAPER_RAM_START_ADDR,
> +	PIXPAPER_RAM_START_ADDR,
> +};
> +
> +static const u8 pixpaper_init_ram_y_counter[] = {
> +	PIXPAPER_RAM_START_ADDR,
> +	PIXPAPER_RAM_START_ADDR,
> +};
> +
> +static const struct pixpaper_init_seq pixpaper_init_seqs[] = {
> +	{
> +		.cmd = PIXPAPER_CMD_TEMP_SENSOR_CONTROL,
> +		.data = pixpaper_init_temp_sensor,
> +		.len = ARRAY_SIZE(pixpaper_init_temp_sensor),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_BOOSTER_SOFT_START_CTRL,
> +		.data = pixpaper_init_softstart,
> +		.len = ARRAY_SIZE(pixpaper_init_softstart),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_DRIVER_OUTPUT_CTRL,
> +		.data = pixpaper_init_driver_output,
> +		.len = ARRAY_SIZE(pixpaper_init_driver_output),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_BORDER_WAVEFORM_CONTROL,
> +		.data = pixpaper_init_border,
> +		.len = ARRAY_SIZE(pixpaper_init_border),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_SET_RAM_X_START_END,
> +		.data = pixpaper_init_ram_x_window,
> +		.len = ARRAY_SIZE(pixpaper_init_ram_x_window),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_SET_RAM_Y_START_END,
> +		.data = pixpaper_init_ram_y_window,
> +		.len = ARRAY_SIZE(pixpaper_init_ram_y_window),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER,
> +		.data = pixpaper_init_ram_x_counter,
> +		.len = ARRAY_SIZE(pixpaper_init_ram_x_counter),
> +	},
> +	{
> +		.cmd = PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER,
> +		.data = pixpaper_init_ram_y_counter,
> +		.len = ARRAY_SIZE(pixpaper_init_ram_y_counter),
> +	},
> +};
> +
> +static inline struct pixpaper_panel *to_pixpaper_panel(struct drm_device *drm)
> +{
> +	return container_of(drm, struct pixpaper_panel, drm);
> +}
> +
> +static void pixpaper_wait_for_panel(struct pixpaper_panel *panel)
> +{
> +	unsigned int timeout_ms = PIXPAPER_BUSY_TIMEOUT_MS;
> +	unsigned long timeout_jiffies = jiffies + msecs_to_jiffies(timeout_ms);
> +
> +	usleep_range(PIXPAPER_BUSY_POLL_INITIAL_US_MIN,
> +		     PIXPAPER_BUSY_POLL_INITIAL_US_MAX);
> +	while (gpiod_get_value_cansleep(panel->busy) != 0) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			/*
> +			 * Treat a busy timeout as warning-only. Some panels may
> +			 * keep BUSY asserted longer than expected during
> +			 * initialization or refresh.
> +			 */
> +			drm_warn(&panel->drm, "Busy wait timed out\n");
> +			return;
> +		}
> +		usleep_range(PIXPAPER_BUSY_POLL_US_MIN,
> +			     PIXPAPER_BUSY_POLL_US_MAX);
> +	}
> +}
> +
> +static void pixpaper_spi_write(struct pixpaper_panel *panel, int dc,
> +			       const void *buf, size_t len,
> +			       struct pixpaper_error_ctx *err)
> +{
> +	int ret;
> +
> +	if (err->errno_code || !len)
> +		return;
> +
> +	gpiod_set_value_cansleep(panel->dc, dc);
> +	usleep_range(1, 5);
> +
> +	ret = spi_write(panel->spi, buf, len);
> +	if (ret < 0)
> +		err->errno_code = ret;
> +}
> +
> +static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
> +			      struct pixpaper_error_ctx *err)
> +{
> +	panel->tx_buf[0] = cmd;
> +	pixpaper_spi_write(panel, 0, panel->tx_buf, sizeof(cmd), err);
> +}
> +
> +static void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
> +			       struct pixpaper_error_ctx *err)
> +{
> +	panel->tx_buf[0] = data;
> +	pixpaper_spi_write(panel, 1, panel->tx_buf, sizeof(data), err);
> +}
> +
> +static void pixpaper_reset_ram_counters(struct pixpaper_panel *panel,
> +					struct pixpaper_error_ctx *err)
> +{
> +	if (err->errno_code)
> +		return;
> +
> +	pixpaper_send_cmd(panel, PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER, err);
> +	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
> +	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
> +
> +	pixpaper_send_cmd(panel, PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER, err);
> +	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
> +	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
> +}
> +
> +static void pixpaper_write_ram(struct pixpaper_panel *panel, u8 cmd,
> +			       const u8 *buf, u32 len,
> +			       struct pixpaper_error_ctx *err)
> +{
> +	if (err->errno_code || !buf || !len)
> +		return;
> +
> +	pixpaper_reset_ram_counters(panel, err);
> +
> +	pixpaper_send_cmd(panel, cmd, err);
> +	pixpaper_spi_write(panel, 1, buf, len, err);
> +}
> +
> +static void pixpaper_send_init_seq(struct pixpaper_panel *panel,
> +				   const struct pixpaper_init_seq *seq,
> +				   struct pixpaper_error_ctx *err)
> +{
> +	if (err->errno_code || !seq->data || !seq->len)
> +		return;
> +
> +	if (seq->len > PIXPAPER_TX_BUF_SIZE) {
> +		err->errno_code = -EINVAL;
> +		return;
> +	}
> +
> +	pixpaper_send_cmd(panel, seq->cmd, err);
> +	memcpy(panel->tx_buf, seq->data, seq->len);
> +	pixpaper_spi_write(panel, 1, panel->tx_buf, seq->len, err);
> +}
> +
> +static void pixpaper_trigger_update(struct pixpaper_panel *panel,
> +				    struct pixpaper_error_ctx *err)
> +{
> +	if (err->errno_code)
> +		return;
> +
> +	pixpaper_send_cmd(panel, PIXPAPER_CMD_DISPLAY_UPDATE_CTRL2, err);
> +	pixpaper_send_data(panel, PIXPAPER_UPDATE_INITIAL, err);
> +	pixpaper_send_cmd(panel, PIXPAPER_CMD_MASTER_ACTIVATION, err);
> +	pixpaper_wait_for_panel(panel);
> +}
> +
> +static void pixpaper_xrgb8888_to_bw(const void *src, void *dst, u32 height,
> +				    u32 width, u32 src_pitch, u32 dst_pitch)
> +{
> +	const uint8_t *src_base = src;
> +	uint8_t *dst_pixels = dst;
> +
> +	if (dst == NULL || src == NULL)
> +		return;
> +
> +	for (u32 y = 0; y < height; y++) {
> +		uint8_t *dst_row = dst_pixels + y * dst_pitch;
> +		const __le32 *src_pixels =
> +			(const __le32 *)(src_base + y * src_pitch);
> +
> +		for (u32 x = 0; x < width; x++) {
> +			/*
> +			 * The panel RAM X direction is reversed relative to DRM
> +			 * coordinates. Read pixels from right to left so the
> +			 * displayed image matches the expected orientation on
> +			 * the panel.
> +			 */
> +			u32 src_x = width - 1 - x;
> +			uint8_t r, g, b;
> +			u8 bit;
> +			u32 bit_pos = x % 8;
> +			u32 byte_pos = x / 8;
> +			uint32_t gray_val;
> +			uint32_t pixel;
> +
> +			pixel = le32_to_cpu(src_pixels[src_x]);
> +			r = (pixel >> 16) & 0xFF;
> +			g = (pixel >> 8) & 0xFF;
> +			b = pixel & 0xFF;
> +
> +			gray_val = (r * PIXPAPER_LUMA_R_WEIGHT +
> +				    g * PIXPAPER_LUMA_G_WEIGHT +
> +				    b * PIXPAPER_LUMA_B_WEIGHT +
> +				    PIXPAPER_LUMA_ROUNDING_BIAS) /
> +				   PIXPAPER_LUMA_DIVISOR;
> +			bit = gray_val >= PIXPAPER_PIXEL_THRESHOLD;
> +
> +			if (bit)
> +				dst_row[byte_pos] |= BIT(7 - bit_pos);
> +			else
> +				dst_row[byte_pos] &= ~BIT(7 - bit_pos);
> +		}
> +	}
> +}
> +
> +static void *pixpaper_prepare_buffer(const void *vaddr,
> +				     const struct drm_framebuffer *fb,
> +				     u32 *dst_pitch,
> +				     struct pixpaper_error_ctx *err)
> +{
> +	void *dst;
> +
> +	if (err->errno_code)
> +		return NULL;
> +
> +	*dst_pitch = DIV_ROUND_UP(fb->width, 8);
> +	dst = kzalloc(*dst_pitch * fb->height, GFP_KERNEL);
> +	if (!dst) {
> +		err->errno_code = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	pixpaper_xrgb8888_to_bw(vaddr, dst, fb->height, fb->width,
> +				fb->pitches[0], *dst_pitch);
> +
> +	return dst;
> +}
> +
> +static void pixpaper_write_image(struct pixpaper_panel *panel,
> +				 const u8 *buf, u32 len,
> +				 struct pixpaper_error_ctx *err)
> +{
> +	if (err->errno_code)
> +		return;
> +
> +	pixpaper_write_ram(panel, PIXPAPER_CMD_WRITE_RAM_BW, buf, len, err);
> +}
> +
> +static int pixpaper_panel_hw_init(struct pixpaper_panel *panel)
> +{
> +	struct pixpaper_error_ctx err = { .errno_code = 0 };
> +	u8 i;
> +
> +	gpiod_set_value_cansleep(panel->reset, 0);
> +	msleep(50);
> +	gpiod_set_value_cansleep(panel->reset, 1);
> +	msleep(50);
> +
> +	pixpaper_wait_for_panel(panel);
> +
> +	for (i = 0; i < ARRAY_SIZE(pixpaper_init_seqs); i++) {
> +		pixpaper_send_init_seq(panel, &pixpaper_init_seqs[i], &err);
> +		if (err.errno_code)
> +			goto init_fail;
> +	}
> +
> +	return 0;
> +
> +init_fail:
> +	drm_err(&panel->drm, "Hardware initialization failed (err=%d)\n",
> +		err.errno_code);
> +	return err.errno_code;
> +}
> +
> +static int pixpaper_plane_helper_atomic_check(struct drm_plane *plane,
> +					      struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *new_plane_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc *new_crtc = new_plane_state->crtc;
> +	struct drm_crtc_state *new_crtc_state = NULL;
> +	int ret;
> +
> +	if (new_crtc)
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
> +						  new_crtc_state, DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING, false, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int pixpaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					     struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *crtc_state =
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	if (!crtc_state->enable)
> +		return 0;
> +
> +	return drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +}
> +
> +static void pixpaper_crtc_atomic_enable(struct drm_crtc *crtc,
> +					struct drm_atomic_state *state)
> +{
> +	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
> +	struct drm_device *drm = &panel->drm;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	drm_dev_exit(idx);
> +}
> +
> +static void pixpaper_crtc_atomic_disable(struct drm_crtc *crtc,
> +					 struct drm_atomic_state *state)
> +{
> +	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
> +	struct drm_device *drm = &panel->drm;
> +	int idx;
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	drm_dev_exit(idx);
> +}
> +
> +static void pixpaper_plane_atomic_update(struct drm_plane *plane,
> +					 struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *plane_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =
> +		to_drm_shadow_plane_state(plane_state);
> +	struct pixpaper_panel *panel = to_pixpaper_panel(plane->dev);
> +
> +	if (!plane_state->crtc || !plane_state->fb || !plane_state->visible)
> +		return;
> +
> +	{
> +		struct drm_device *drm = &panel->drm;
> +		struct drm_framebuffer *fb = plane_state->fb;
> +		struct iosys_map map = shadow_plane_state->data[0];
> +		const void *vaddr = map.vaddr;
> +		int idx;
> +		struct pixpaper_error_ctx err = { .errno_code = 0 };
> +		uint32_t dst_pitch;
> +		void *dst = NULL;
> +		u32 dst_len;
> +
> +		if (!drm_dev_enter(drm, &idx))
> +			return;
> +
> +		if (fb->format->format != DRM_FORMAT_XRGB8888) {
> +			err.errno_code = -EINVAL;
> +			drm_err_once(drm, "Unsupported framebuffer format: 0x%08x\n",
> +				    fb->format->format);
> +			goto update_cleanup;
> +		}
> +
> +		dst = pixpaper_prepare_buffer(vaddr, fb, &dst_pitch, &err);
> +		if (err.errno_code) {
> +			drm_err_once(drm, "Failed to allocate temporary buffer\n");
> +			goto update_cleanup;
> +		}
> +
> +		dst_len = dst_pitch * fb->height;
> +		pixpaper_write_image(panel, dst, dst_len, &err);
> +		if (err.errno_code)
> +			goto update_cleanup;
> +
> +		pixpaper_trigger_update(panel, &err);
> +		if (err.errno_code)
> +			goto update_cleanup;
> +update_cleanup:
> +		if (err.errno_code && err.errno_code != -ETIMEDOUT)
> +			drm_err_once(drm, "Frame update failed: %d\n",
> +				     err.errno_code);
> +
> +		kfree(dst);
> +		drm_dev_exit(idx);
> +	}
> +}
> +
> +static const struct drm_display_mode pixpaper_mode = {
> +	.clock = PIXPAPER_MODE_CLOCK_KHZ,
> +	.hdisplay = PIXPAPER_WIDTH,
> +	.hsync_start = PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH,
> +	.hsync_end = PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH + PIXPAPER_HSYNC_LEN,
> +	.htotal = PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH + PIXPAPER_HSYNC_LEN +
> +		  PIXPAPER_HBACK_PORCH,
> +	.vdisplay = PIXPAPER_HEIGHT,
> +	.vsync_start = PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH,
> +	.vsync_end = PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH + PIXPAPER_VSYNC_LEN,
> +	.vtotal = PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH + PIXPAPER_VSYNC_LEN +
> +		  PIXPAPER_VBACK_PORCH,
> +	.width_mm = PIXPAPER_WIDTH_MM,
> +	.height_mm = PIXPAPER_HEIGHT_MM,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static int pixpaper_connector_get_modes(struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &pixpaper_mode);
> +}
> +
> +static enum drm_mode_status
> +pixpaper_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
> +{
> +	if (mode->hdisplay == PIXPAPER_WIDTH &&
> +	    mode->vdisplay == PIXPAPER_HEIGHT)
> +		return MODE_OK;
> +
> +	return MODE_BAD;
> +}
> +
> +static const struct drm_plane_funcs pixpaper_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,
> +};
> +
> +static const struct drm_plane_helper_funcs pixpaper_plane_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_check = pixpaper_plane_helper_atomic_check,
> +	.atomic_update = pixpaper_plane_atomic_update,
> +};
> +
> +static const struct drm_crtc_funcs pixpaper_crtc_funcs = {
> +	.set_config = drm_atomic_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.destroy = drm_crtc_cleanup,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_crtc_helper_funcs pixpaper_crtc_helper_funcs = {
> +	.mode_valid = pixpaper_mode_valid,
> +	.atomic_check = pixpaper_crtc_helper_atomic_check,
> +	.atomic_enable = pixpaper_crtc_atomic_enable,
> +	.atomic_disable = pixpaper_crtc_atomic_disable,
> +};
> +
> +static const struct drm_encoder_funcs pixpaper_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +static const struct drm_connector_funcs pixpaper_connector_funcs = {
> +	.reset = drm_atomic_helper_connector_reset,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_connector_helper_funcs pixpaper_connector_helper_funcs = {
> +	.get_modes = pixpaper_connector_get_modes,
> +};
> +
> +DEFINE_DRM_GEM_FOPS(pixpaper_fops);
> +
> +static struct drm_driver pixpaper_drm_driver = {
> +	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.fops = &pixpaper_fops,
> +	.name = "pixpaper-426m",
> +	.desc = "DRM driver for PIXPAPER 4.26 monochrome e-ink panel",
> +	.major = 1,
> +	.minor = 0,
> +	DRM_GEM_SHMEM_DRIVER_OPS,
> +	DRM_FBDEV_SHMEM_DRIVER_OPS,
> +};
> +
> +static const struct drm_mode_config_funcs pixpaper_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create_with_dirty,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +static int pixpaper_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct pixpaper_panel *panel;
> +	struct drm_device *drm;
> +	int ret;
> +
> +	panel = devm_drm_dev_alloc(dev, &pixpaper_drm_driver,
> +				   struct pixpaper_panel, drm);
> +	if (IS_ERR(panel))
> +		return PTR_ERR(panel);
> +
> +	drm = &panel->drm;
> +	panel->spi = spi;
> +	spi_set_drvdata(spi, panel);
> +
> +	panel->tx_buf = devm_kzalloc(dev, PIXPAPER_TX_BUF_SIZE, GFP_KERNEL);
> +	if (!panel->tx_buf)
> +		return -ENOMEM;
> +
> +	ret = drmm_mode_config_init(drm);
> +	if (ret)
> +		return ret;
> +
> +	spi->mode = SPI_MODE_0;
> +	spi->bits_per_word = PIXPAPER_SPI_BITS_PER_WORD;
> +
> +	if (!spi->max_speed_hz) {
> +		drm_warn(drm,
> +			 "spi-max-frequency not specified in DT, using default %u Hz\n",
> +			 PIXPAPER_SPI_SPEED_DEFAULT);
> +		spi->max_speed_hz = PIXPAPER_SPI_SPEED_DEFAULT;
> +	}
> +
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		drm_err(drm, "SPI setup failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!dev->dma_mask)
> +		dev->dma_mask = &dev->coherent_dma_mask;
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		drm_err(drm, "Failed to set DMA mask: %d\n", ret);
> +		return ret;
> +	}
> +
> +	panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(panel->reset))
> +		return PTR_ERR(panel->reset);
> +
> +	panel->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
> +	if (IS_ERR(panel->busy))
> +		return PTR_ERR(panel->busy);
> +
> +	panel->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_HIGH);
> +	if (IS_ERR(panel->dc))
> +		return PTR_ERR(panel->dc);
> +
> +	ret = pixpaper_panel_hw_init(panel);
> +	if (ret) {
> +		drm_err(drm, "Panel hardware initialization failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	drm->mode_config.funcs = &pixpaper_mode_config_funcs;
> +	drm->mode_config.min_width = PIXPAPER_WIDTH;
> +	drm->mode_config.max_width = PIXPAPER_WIDTH;
> +	drm->mode_config.min_height = PIXPAPER_HEIGHT;
> +	drm->mode_config.max_height = PIXPAPER_HEIGHT;
> +
> +	ret = drm_universal_plane_init(drm, &panel->plane, 1, &pixpaper_plane_funcs,
> +				       pixpaper_formats, ARRAY_SIZE(pixpaper_formats), NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(&panel->plane, &pixpaper_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, &panel->crtc, &panel->plane, NULL,
> +					&pixpaper_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +	drm_crtc_helper_add(&panel->crtc, &pixpaper_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, &panel->encoder, &pixpaper_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_connector_init(drm, &panel->connector,
> +				 &pixpaper_connector_funcs,
> +				 DRM_MODE_CONNECTOR_SPI);
> +	if (ret)
> +		return ret;
> +
> +	drm_connector_helper_add(&panel->connector,
> +				 &pixpaper_connector_helper_funcs);
> +	drm_connector_attach_encoder(&panel->connector, &panel->encoder);
> +	panel->encoder.possible_crtcs = drm_crtc_mask(&panel->crtc);
> +
> +	drm_mode_config_reset(drm);
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret)
> +		return ret;
> +
> +	drm_client_setup(drm, NULL);
> +
> +	return 0;
> +}
> +
> +static void pixpaper_remove(struct spi_device *spi)
> +{
> +	struct pixpaper_panel *panel = spi_get_drvdata(spi);
> +
> +	if (!panel)
> +		return;
> +
> +	drm_dev_unplug(&panel->drm);
> +	drm_atomic_helper_shutdown(&panel->drm);
> +}
> +
> +static const struct spi_device_id pixpaper_ids[] = { { "pixpaper-426m", 0 }, {} };
> +MODULE_DEVICE_TABLE(spi, pixpaper_ids);
> +
> +static const struct of_device_id pixpaper_dt_ids[] = {
> +	{ .compatible = "mayqueen,pixpaper-426m" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pixpaper_dt_ids);
> +
> +static struct spi_driver pixpaper_spi_driver = {
> +	.driver = {
> +		.name = "pixpaper-426m",
> +		.of_match_table = pixpaper_dt_ids,
> +	},
> +	.id_table = pixpaper_ids,
> +	.probe = pixpaper_probe,
> +	.remove = pixpaper_remove,
> +};
> +
> +module_spi_driver(pixpaper_spi_driver);
> +
> +MODULE_AUTHOR("LiangCheng Wang");
> +MODULE_DESCRIPTION("DRM SPI driver for PIXPAPER 4.26 monochrome e-ink panel");
> +MODULE_LICENSE("GPL");
> 

