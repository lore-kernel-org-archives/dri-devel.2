Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485B606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=paP0fjVJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3997E10E12E;
	Thu, 29 Oct 2026 15:42:38 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF60610E12E
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTsZ1DqrfXXVLnJyGER/4kJduwYbK570OzSkln3pFwx/YcN6laxzasev9CuKF/NrB/ae4ZAdfwZKtIZBUgFkVGTkz/5Sx8/eECaFWpn8ECQ0wG3CGxvXNw1W1OQeGz/V0c4Che3HuQ6lfRKYTx8nQ7hLKTwP5DczwUiAs8v3KRT3YrOSD9p5zf9SIXproBF+QaS0+iCZC5nBcOdccQRcF5VtKGnjot6U+5Ca3j33ems4hEFuYqMJwyBOQIaNobD/C0voQHGWzfU1rNwtBR6qsMTEebEmCoVunCwnGMtoIkYv8ybxLqOWUGDDbyZFf+h+0ALWNzhDbX1dQ34HsQADLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM7dRLsF47Q2IpYGKtZy5xFISzX8e2vEP3w/em2MyAw=;
 b=gqrggNNDo6wh/oxdqw0QSiXSS2qYbpevdff00TdakKYkt+1WMrVvYMbRfBRWbVtlVW2qPswvW0xGhXiYiZzTksie7lGzN+wqFWGxlx8riczTLcafHLh+u493NyP+FGib1rCmeb8NWD0YwsJPcIRx3/5eIchaJlDJrZs53ftZ4Rkc/RUw+f96wHrwKllelXulRCUGoXCkl/ouK55JZy10V67hVQTea4mvU+0K5HRJdh8Y3lfgmGxbHeTKFNS6jmLxxaHqLfIqo0cahYbZd9Dy6arZz7IjdlU69AYYEA5nZGYw6MzuVBVWUmZmu5EEm0mGOgCRHtIjI2PHLWF5tBEJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM7dRLsF47Q2IpYGKtZy5xFISzX8e2vEP3w/em2MyAw=;
 b=paP0fjVJPCmFbRiRE9uVVl0AJMj7GO+G5MjtNkm5JHjqwrAN+rTFI08bg8B/sl7jEOjmODowbjkIidHQmLkp8TjixkSuUt4vlaTCLGMnN3f8yHObUudAPsAIVCTVZJRd4IKwh8ZeSaAlypP+RId98Aom22D2n2sw7lWj/t/haKO37KcLYVmEwoTe5PPCClH1azDnbj3dMY+5PCg6d8q3d7+LyVl3m3oKWQ4ANY5EMJobDdazuTXocX2M1+vHCVXNg7qMSqZxMPKy3s7+9tQ/LVH1jFjNoV/Sm7DBod724mfShQ4/h/H7KwuTa/Sl1SoiBwYRZ2R/+K+/FNupEFEpaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:42:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 15:42:28 +0000
Date: Thu, 29 Oct 2026 11:42:19 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/31] accel: ethosu: Suspend after initialization
Message-ID: <auNpW5PRWjWPm8My@lizhi-Precision-Tower-5810>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-1-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-ethosu-fixes-v4-1-4aa25e22578e@kernel.org>
X-ClientProxiedBy: PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI1PR04MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 587379a8-fda6-41e5-32ac-08df35d33c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|19092799006|4143699003|56012099006|261009221227099003|261009223027099003|261026121527099003|11063799006|261021121427099003|261021123027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kJsanzG5oO5KYTZF+NfqSyz4qHIpe4GEj5xwBGZQMNfLXAMxcWI/ZkP2ElU7lnx8YUhK21OVGLLzpkuK9gSEgNui5RERT/xGS71iD+xDijJ7n8EDkcRgaVOaVWliU+yv6Qa4LA8nnugJrDDFATnPikEkqiDY0Mp3/pWahpC1T6AJRj8BeG1O7ghdcq6Z7S4L5ygyAR1+7CHc6vWBhdHyY/R3sJ1FJMH/N27BU+etUK1bv5gqm4vypZzujKF1LN7xumdN4Q5CxK7LJdc0EcT4uN71yewbA9B4Wi5isEgdZBlKo66NSnZ+BeZHxgF6lrHfZhbmTg8BxOPyQIFoGyxI41ZG4GyCmoM933gePdPQRTRYRgZJ7xTkIo+bBeCvndvr1xNVE9SOGbZxHteG30YBNdGhaxDNnB9td0a6hgZ7iQl0csOd/b1Iq1Kf+wOUGzrN+GuR9c5Rd1mjhjx5Shre9tsYLivu/6Cjj8X4fvSxBSnzNoxCcxpHpOLseF9suL8SNkxMMlcFHga1um2LPqeveTIWhv0dxsuZuTa+CydF4QDGehFWSnyrK468+C+iNuEJ74Vka3W3MlOnBYWkJv/8iaREszhSZ/xSfXwRSPUWhF2tkHztr5fTu/zvSLasv9viNsRSoqSy2omGzLAISNeeYCwHg3EZ1QNQp+lzMFgqLC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(4143699003)(56012099006)(261009221227099003)(261009223027099003)(261026121527099003)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PB+OwRN0eG3ki69M8Bcg8Yo4AL6MZf7p1KPr9bi+b+zzyYTTZovQ5v3QP0/z?=
 =?us-ascii?Q?dM/8q15RgbF2dj3GuQ3eaeH/10rCfVU9esPexMBAVr1sUgqXkZm67Cqt3CFz?=
 =?us-ascii?Q?tTMJ9EsHTOvSUCy6Uqft1RGS45WYabh19lCjK1a01G9O81lPiW1MpNmKJnur?=
 =?us-ascii?Q?YzHi8S+1j9TTRrwFFsRc+E1WTGCMlFgtO7cuGFa9ojIWaRirIAZPCF9+W+yx?=
 =?us-ascii?Q?k3QNNXuO5akIcCKKv/Lv23jR6DoMoh3WifkZet9ymamqOfTEVXkw+Vt19Tlq?=
 =?us-ascii?Q?ZNN8okfdI3P5u2t0tEffw1uWkkUw2uaReYHyQnawzMI/4tPaYu/Tc36IKACZ?=
 =?us-ascii?Q?xGFGdclitHxLkVtglEfzWUvuENeQJCkUx8NGLPsO2TGz+UARmoWuDquBMOR7?=
 =?us-ascii?Q?LA5+ZPKj7fPeaL/fhkfu2O2hRBGb53ZexIZn1cIdRPK8ApjEYGfa7dmE1LEY?=
 =?us-ascii?Q?DOyu4makJ4lK/SenUjxHPjV9j2rM8MxrXyX1hzXRZ3xftrRi0R7Lw0Du5ekw?=
 =?us-ascii?Q?I5Dgs2yAWqyO/2DWlIAzTODjz8w3Ax+7OiM4xv62/xaDHTvVMpNmwhSpMUaL?=
 =?us-ascii?Q?ceq9FWVdKfmKv9t0FvrNpyKeIcpYCSfeGWOn3ikbQo8vlFkvqRF7tMeE3U5Q?=
 =?us-ascii?Q?XgGSVCx9T8uEJ4ianqz4V9Eb1MNAnVoduZfZApK8rtQdhsfLSTxUQHnZ1Gi2?=
 =?us-ascii?Q?AlyVGXVqRJZwXCxVMBY8Sl3v9M+L++urLC3tIJIWVoD4mFL1I4lf/X85fdZU?=
 =?us-ascii?Q?Y/YMaz/y0TwSTW3nkBCj3ongt13e4ehCh29WrV4PcV6tNT2Lv7uJw+c15WFD?=
 =?us-ascii?Q?S5fozZKjaHv7UMkMjn06ZKAuq0F0s6jzkHAga+ER6G6nw6xLaJq8LofO8MLD?=
 =?us-ascii?Q?/3JpZRHz01TAMgx2OfS37NGDM93EHhicqYCjYg+yMNM3FI9xKuUR2xtiaWMk?=
 =?us-ascii?Q?93gL0ZSwB7z1PDQZPB1H+78FC6LHyTGQzHwVjzgKbcMeOSePrWYyaftilycL?=
 =?us-ascii?Q?zJ1aIZE2mQ4YDXLrtMMilTjjjCoPc0FQPFfh12oSUpgy6XcvI1HqXA1VMbRO?=
 =?us-ascii?Q?FVAWL0EDhd3SS32AyXgy+xJwpPkFgwPpZNM/liSVS9H5DA1IJRzD3oqu7esK?=
 =?us-ascii?Q?zkwVXLY3iOfUb4Z6goPJy6mQ3qQOAlid5P5AJ5ovSDCChLRprJnOeJB5/s5N?=
 =?us-ascii?Q?1vxzLf9MGwGEI0La5v+g2QeXwZ8aWiLAadX2jjbNPbv9ThXd3bX3astsf+z1?=
 =?us-ascii?Q?WLNG0eRkXXrG2FtC7Na5DAZLRrUc/eTlCKU6Lv5T350x/oPnnBxJ3pOti1RY?=
 =?us-ascii?Q?ObsSN9xLVum7rEaHO2FDoKf5BXwXXJ4/NzqwKjvsW48Uq1trLDhl5HVHr/J7?=
 =?us-ascii?Q?MiQblpGuM3ZyililA2VbHAvTZ9ng/FZw51/R2116IWUl+DsLzWLqa/hsXDGG?=
 =?us-ascii?Q?lsOZH60WEk07HV+1D2qYyMdY6o3HYI9D4N325D9nE8SDIoahHdexC/dpO1vL?=
 =?us-ascii?Q?bCSlIKCh939gOlRRaP31/TXg87A2eaC9W0WsARDd0PYN+InwXxYIMxV/2vA/?=
 =?us-ascii?Q?+eJjw0xHs+Dj4/MEwsjqYwfDx0lACiDXALzWZkfVM0zqBT3lqt+PlakV4IdI?=
 =?us-ascii?Q?7HW3jk1avt3LjQ/IRkjRaIAdiJ1vGWC17DuZjQeAHv3ljtYXSEYmbc3toqUb?=
 =?us-ascii?Q?8qzq0ukUo3BSdc/dL1fbFIWGTMKOM6PxXILOXEsYi1IWk/aZ1GAU/d4iGByZ?=
 =?us-ascii?Q?nX9Uu9Dn9HCBuktkFNL4Re+Wb0ho7fE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587379a8-fda6-41e5-32ac-08df35d33c79
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:42:28.0834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njRpOmS7vpYx5HiwHjdHBEZeNy1Ot33Y9r0BtNsIbVX1hdKiYKEaRwOBCqieG57ZT0l/0uRTz6Sfkzb1JbXkFwkiZT7csIV7EnTcmUgfEEgmZpuzPcVHcM/JOLOubqJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:35:48AM -0500, Rob Herring (Arm) wrote:
> The initial runtime-PM reference is held only while initializing the
> NPU. Release it synchronously from ethosu_init() after the final
> hardware access, before registering the DRM device.
>
> This keeps the runtime-PM setup and initial reference handling together
> and leaves the autosuspend configuration in place for subsequent jobs.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2:
>  - new patch
> ---
>  drivers/accel/ethosu/ethosu_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> index 4a24bbd2bb61..38af57807cee 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
>  		 ethosudev->npu_info.sram_size / 1024,
>  		 ethosudev->npu_info.pmu_counters);
>
> +	pm_runtime_put_sync_suspend(ethosudev->base.dev);
> +
>  	return 0;
>  }
>
> @@ -376,10 +378,6 @@ static int ethosu_probe(struct platform_device *pdev)
>  		return ret;
>
>  	ret = drm_dev_register(&ethosudev->base, 0);
> -	if (ret)
> -		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
> -
> -	pm_runtime_put_autosuspend(ethosudev->base.dev);
>  	return ret;
>  }
>
>
> --
> 2.53.0
>
