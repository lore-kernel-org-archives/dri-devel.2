Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF0CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9229F10E0CC;
	Fri, 16 Oct 2026 06:27:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC76A10E0CC;
 Fri, 16 Oct 2026 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792132038; x=1823668038;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hiihIFxvY1rnzklFQnlhkj2SEFWaG8vfnSCPjfTo0DU=;
 b=UmlL0PiarAk39Itq+Jy1Ir7cF3TFveqQ8Lw02pR4RgUXlO+/GyX7s8n9
 nKf8EclvMOvN2AdQuX/fadlNbRFNS81S9UbWKYmNZXb9JbOhryQxdTNQV
 3f5NGfSMMjjvP21Kp7hY3X85lepQuwm5Bz/RxyHzajj2copAvO2Nk4oHX
 dXPpI77R5gOGDQCvkfFADuEFVM6U2rkyST14QiQnKZPnaPbkrIndCdiKA
 JaMdKqk4RJOFTOvxfb1alpUSFtwE3eO/5Zx/uIkEAbQJSG+wbLPQFgEbg
 r7rqQk8fCvMgf1anORGdmMP46w3b7i+Y/49RpOkR5F/hOhdtJKZNS8HGd Q==;
X-CSE-ConnectionGUID: KtnbZnmHRxSp/ucWALUsUg==
X-CSE-MsgGUID: gzesuUoOTuq5NA2aHrz2kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="813117"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="813117"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 23:27:14 -0700
X-CSE-ConnectionGUID: 2g/lAndASVGjpNDjOPx/3w==
X-CSE-MsgGUID: H7HLg/d1TJCmChSCs1bXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1845322"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 23:27:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 23:27:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 23:27:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 23:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGzgjUO0kd0VPZ9ZkM9F8Xykl7thRgrX3GlCvFS3lxjTyFVz7tnaAJS0SLJ/4q1r/deesvwPhRC4M63QyM3Znwftb7dkcSM313kTfHW38DCRAD2cBDIh25gwBTWiEVsdV48lR9wPBcUlgWnxFGlcm/hxfTZvXHxeCCsZYA7oY2My0q/TsvHS+mv45PNpSzWfYnXOAdEJpV/5MEsugZN9DJ7l1ZcR/Q7SShPeBggzYSZLEflCAWmB8rJeiVyprbHRwGZGgpurhUO2fXnOaLcV1lnzsRkmHrb/UfWkmjrFkXfZisiCDyxSYxJ2xie53jEzCjGjctt1oXusSLbMW6bjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3yCwpTOJn5idI2JxSkmBG7l2pZjyU+m5tS6ffo+yfY=;
 b=jhs1qmPIioee9hqBkCAJADwz9bgSxLwseDlAYvayXqoJUbrnAWylBkuk0gJ6/qyxmehabqV2R7/auaycdwq+Utwq4s+DF5BynuRMzgBn8JxM3++s41/1K8LnfDKZ7RXSCvZz8ZibfdGoW+aqgoQErpJt/bj8+pN5CRMdph7JS1IoLM2rkXGiye5dgKiegiiQ1D2KoN24DPl6BngaUnbudgzZIp8ry5TXEl9ks5vgxBXM+d6HoiwXH5Q1cvJ0jjppg1Kns5LFPZZ83sz6yBj6APA7Z6uin/koGbyFPlavRBlNOjfMP75bkIf6EdAH6y9wNbsWoz7o57TZvnnv2+yMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by EA3PR11MB986640.namprd11.prod.outlook.com (2603:10b6:303:309::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 06:27:02 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:27:01 +0000
Date: Thu, 15 Oct 2026 23:26:59 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <matthew.brost@intel.com>
Subject: Re: [PATCH v3 1/6] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
Message-ID: <atHDszh1A9Eqsukh@nvishwa1-desk>
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
 <20261014190200.1700470-9-niranjana.vishwanathapura@intel.com>
 <af32a6f6-ccee-4265-96bf-d8508d0127b7@suse.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af32a6f6-ccee-4265-96bf-d8508d0127b7@suse.de>
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|EA3PR11MB986640:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e12f11-d197-4774-09e5-08df2b4e7cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|5023799004|56012099006|4143699003|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: OOLygslYlD8qI2Yl4mfcgvx4uj1FHzlMLdUvMbq+oZ8AJ9iUx0EIq+pF1CLNhIgJpamhXVgTP7CeIrILCS+aFvQnp94zlJHRlO4H6s1kdymyFr55mH7HP8snXR0Q06fDqK5nnF0j/9jiUA+FNTC6otQ5fthQpPJU8E+fXJ1L8y5UwvHVM2OHw4Ax5VQnJ58KKKHvxaVii0+bONhIAJQKPiOzs47feQHJRm9TzLEBsqmRLSxwwWq3GuOEsYrYiWyUueOAYwTT5f9HMryFc4ivQ/NNui4vhkei/43lmY8Brhcw5XkdZ1vqS+FrwJyZD4UH45cQq63Bqoo9SqMW4w9ha5hoMgb8OfhGOZ2E9CorsfIV+NON7CNnoBLsMh+y63JFouyVNxlxZKOuw/7mTnG1nJqCIIwOyWc51M/CyaW9LCtYne2CghulLPU7zXX/cXEy/TiZkmieVliVHva13O6EhMmfhUhQd4emoj5lklP8KFgNNas97xwMCnVQ7rqNYS3x3f0diQUCpO6OmAMO6vIM0smvyVchkonTANtTqa33k+GfxBlFnIIcA/BwOAK5DrZ1c316wIku5CpE21hmTGL10WU/Cc5nGpDLqo0nGgpppfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OcN51XQ2zZJtG0SGKsWYgUBvwk43bCYMVnlVLl9QSoKB4ckANboP3I0W4b?=
 =?iso-8859-1?Q?z+KNrefFQhG07r7NLKRC7UUUJf8Wj8ux7XMf3drCkVqhAr4wtdi6bmoiEg?=
 =?iso-8859-1?Q?ANipLn9ogP91iBhnJZQI2bRDezAlaDDBO8LO4CRWhJngo8O8C1F9ra5oSR?=
 =?iso-8859-1?Q?h5cbarFpRPMsYZnuuem2lZHKMVc8nK4sxbsFKm67fnvlOIMqreyHxda4zI?=
 =?iso-8859-1?Q?kf/GUiV0rb05vb5Szhbvh4In/W1cS7U6XefffZlSLkVYqoi808FGeNmlYZ?=
 =?iso-8859-1?Q?h6qLRzg4zPgpSKpLf/IIpYZgfpJ+rcrwn9ypO6zuVFfzFTVfE7F5mcWPJw?=
 =?iso-8859-1?Q?oiH1NPAyZGJQn5CRp0PK/c4SMmR5IJNxVCR+OVsCEN8QqVf9MLN8F7uqxE?=
 =?iso-8859-1?Q?Q1QktmXDNYcV/1FhZtG72/K2VUB/M6hnM/QFszVOXuKnuyYFVJ6WggbC3/?=
 =?iso-8859-1?Q?/GW3kIRCB2cfarYnTIQ8r4ZoXJxS3t2pyT9edznZMnB952BmC7iFqDponO?=
 =?iso-8859-1?Q?3xQvD3UAFxqzAp8e7EvxmVtJTa4c6xcI8O17ON7Bhvjt0biwxrTNdEte7z?=
 =?iso-8859-1?Q?UwM6A+nZFHRusriWfn0WnI1cDygqcPB7YbJJid9/XPk2L+hg+wg9xtBXJV?=
 =?iso-8859-1?Q?zarxNI/70iwyoUOif3bJz1yFOPokqBtpELlSmyBF63z6IQ21VXsweBsdJC?=
 =?iso-8859-1?Q?315B1JpuoE2uXmjcLCjcf1Zpju8sroMsNsoZZecqzd3ZmgaoN7PV/QUaXh?=
 =?iso-8859-1?Q?34RUDEpS9W6YBDV7p8I9eNivZcXG2Bnr4P09pIyyMR8MPqi2LnhY12IkrC?=
 =?iso-8859-1?Q?NIKWG6u2vrzQvS6pJI0XlBDOKXwS13GrSChp+DqN3RTEy3Nrr7btp4dwvh?=
 =?iso-8859-1?Q?B6AJVQYyv4lpRwn2W28SFiNIfldVIeZzVgq+Gqt5P+QxfV8v3JhH3o/ZeQ?=
 =?iso-8859-1?Q?8EfPe0BaO3eBUgx5AclaJAmfmZYEhczuIqdXY2sF4bbVDA5vg4ZUI07DII?=
 =?iso-8859-1?Q?ZnyJOv+w+4mEBkyL/3eLY1YYVB7xUBzx3CTKocMWySJdugj7rOcraWf+ni?=
 =?iso-8859-1?Q?Qf06oqBX7kcsyHYnRgVsEPGME0/JgENhDibUwd5yaa3zaJopYDFJmjaoFt?=
 =?iso-8859-1?Q?dl7dw3orpU5qnKRslGzHtJxpMBl5kk/Fyc62Bj0jZHhaIjZ6SUx9JHOuh4?=
 =?iso-8859-1?Q?3BI/1QzyGRfMXADE/eO7XpYgeT628SmHKB3vPhbiScBu29sqWhPPY7YoM+?=
 =?iso-8859-1?Q?jqJrl4q22+xRvKuyJ/ociRjizbaAPkFUAHM1y2Os8hOwvyS4W3KmX4Ja68?=
 =?iso-8859-1?Q?7namrQUuR4nTEWQN+os+eXdcSCtKrHoL6Uwl1akdtA45yTnCCW/AUP7/E/?=
 =?iso-8859-1?Q?henIsPb43viGrRN8nwS/yqZLtOFia+ur1DQVas55jppoPpAvRE6HbrIL3z?=
 =?iso-8859-1?Q?7hBaoKzDuc9hWB2VS/ctSDpm6JyL55sPqP8LIUk+6TuM4gdRwWiqq2K3GS?=
 =?iso-8859-1?Q?v9vZ00OuHpcN+3uHFWiGlEp/KYHbn2A5Y6l7d8gZaP0yjiKsCWj4tW0Omy?=
 =?iso-8859-1?Q?rzPrhiVDczwkfP5jMbHy/wLqCEUMZMESvcZzZCEWgPgxdMXpEdPkoh03S5?=
 =?iso-8859-1?Q?/XukC/H9dk87WizCCYJmz9dSeAGnn495jOprfuKKU0CGJXBCgbHojGv8Jr?=
 =?iso-8859-1?Q?EQX02A8298EZqA8jZxzVN51n2VpgK1SYsR3op6sowuc+TdzH3OCgpTydzx?=
 =?iso-8859-1?Q?idM2PyPBza5q3S2Ywx4BwyZY6babfYEGenrrEwVv/sTLpvfFLNjJ99URWe?=
 =?iso-8859-1?Q?7PkwSNBq1T7oj7U6Up4Gpsq9WqtW+15JMGaQj07V0/r+ZpsLQbQC?=
X-Exchange-RoutingPolicyChecked: JBFyz23Qx3MqVkxXqLqoAgO0UZamyHiQDFi3LwVzQlzI9n8xfGvbZT0RnjW2tqp6scF7rBxRlIe/fTfVgBOzj32tT6ta3Dg6282bwogmINJkHx0qfFTNjgFtI+L6nM6ByOR4Bq04VfizeSDPumM7RMzNpWJ6hvTrDLM5c2NtdNSXp230f19Q/QlqkhgadMl3A0r/+rvlIUl4qZx+tIA7pYIHU6cm4UJ6b8AUWNOOYUZX4227gnrjACIcIUliRwp5PKUjrwqwJyo0wSaBvgBEARwqzItdvZ5teS9icag8uhoR6sYvGVTytdP83BHduUttDXDTKk9RmwmxFSiL9hFP7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e12f11-d197-4774-09e5-08df2b4e7cf6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:27:01.5204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1wtwJs/8pci7wK67L8B6KzzwBQ3zsOP9F1GxBqmiI1j9gsVMZ4YPb1lV3IBwIJA5WNUheUDQLnibzjS5H5SnGaeTie6pT9oalhayNfbFSzP1sK1sjtjaVw/HruUWtsU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR11MB986640
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

On Thu, Oct 15, 2026 at 09:27:08AM +0200, Thomas Zimmermann wrote:
>Hi
>
>Am 14.10.26 um 21:02 schrieb Niranjana Vishwanathapura:
>>From: Farah Kassabri <farah.kassabri@intel.com>
>>
>>Add drm_gem_prime_self_import() to detect and handle the case where a
>>PRIME dma-buf being imported was exported by the same DRM device.
>>
>>When the dma-buf originates from the importing device and uses the
>>expected dma-buf ops, the helper returns the associated GEM object and
>>takes an extra reference on it. This allows drivers to bypass the
>>generic PRIME import path and avoid taking an additional reference on
>>the dma-buf file.
>>
>>The helper simplifies self-import handling and avoids duplication of
>>this pattern across DRM drivers.
>>
>>v2: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
>>     helper routine
>
>Why even bother submitting this? It is the same series that I already 
>declined with a few cosmetic changes.
>
>The abstract entry point for importing is drm_driver.gem_prime_import. 
>The implementation is driver specific. No need to over abstract. 
>Keeping drm_gem_object_get() separate from the test is a feature, not 
>a bug BTW.
>
>If you want to improve the status quo, change dma-buf such that prime 
>works without relying on the vtable and ->priv. I outlined this in my 
>earlier replies.
>

Hi Thomas,

As mentioned in other thread, your earlier suggesion of
'__drm_gem_is_exported_dma_buf(dev, ops, dma_buf)' is not fully helpful
as it would require drivers to still take object reference. Besides,
this also depends on 'ops'.

To me the 'dma_buf_ops as export identifer' seems to be well accepted
idiom, though we may say it shouldn't be in stricter sense.

But if we were not to relay on vtable and ->priv, then it looks like
the best alternative will be to have DRM subsystem maintain a list of
exported dma-buf objects per drm device. Then during import, parse this
list to determine if the import is self-import or not.

I am not sure if it is worth to add this list just for this simple helper
routine. If using dma_buf ops is no go, then yah, let us drop this series,
keep current code and may be look into this alternative later through an RFC.

Thanks,
Niranjana

>Best regards
>Thomas
>
>
>
>>
>>Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
>>Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>>Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>---
>>  drivers/gpu/drm/drm_prime.c | 10 ++-------
>>  include/drm/drm_gem.h       | 42 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 44 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>index 9b44c78cd77f..7a15c29052eb 100644
>>--- a/drivers/gpu/drm/drm_prime.c
>>+++ b/drivers/gpu/drm/drm_prime.c
>>@@ -974,15 +974,9 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>  	struct drm_gem_object *obj;
>>  	int ret;
>>-	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>>-		/*
>>-		 * Importing dmabuf exported from our own gem increases
>>-		 * refcount on gem itself instead of f_count of dmabuf.
>>-		 */
>>-		obj = dma_buf->priv;
>>-		drm_gem_object_get(obj);
>>+	obj = drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
>>+	if (obj)
>>  		return obj;
>>-	}
>>  	if (!dev->driver->gem_prime_import_sg_table)
>>  		return ERR_PTR(-EINVAL);
>>diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>index 885244e375d3..238ec08f0d81 100644
>>--- a/include/drm/drm_gem.h
>>+++ b/include/drm/drm_gem.h
>>@@ -646,6 +646,48 @@ static inline bool drm_gem_is_imported(const struct drm_gem_object *obj)
>>  	return !!obj->import_attach;
>>  }
>>+/**
>>+ * drm_gem_prime_self_import - Attempt to import a dma-buf exported by this DRM device
>>+ * @dev: DRM device performing the import
>>+ * @dma_buf: dma-buf to import
>>+ * @expected_ops: dma-buf ops used by this driver
>>+ *
>>+ * If @dma_buf was exported by this DRM device using @expected_ops, return the
>>+ * corresponding GEM object and take an extra reference on it. In this case,
>>+ * the import avoids taking a reference on the dma-buf file and instead bumps
>>+ * the GEM object's refcount directly.
>>+ *
>>+ * Comparing @dma_buf->ops against @expected_ops is plumbing: dma-buf has no
>>+ * first-class exporter identifier, so the ops pointer is used as a stand-in to
>>+ * recognise a buffer this driver exported. A dedicated exporter identity would
>>+ * let this be done without reaching into @dma_buf->ops.
>>+ *
>>+ * Returns:
>>+ * A referenced GEM object on success, or %NULL if the dma-buf was not exported
>>+ * by this device or does not match @expected_ops.
>>+ */
>>+static inline struct drm_gem_object *
>>+drm_gem_prime_self_import(struct drm_device *dev, struct dma_buf *dma_buf,
>>+			  const struct dma_buf_ops *expected_ops)
>>+{
>>+	struct drm_gem_object *obj;
>>+
>>+	if (dma_buf->ops != expected_ops)
>>+		return NULL;
>>+
>>+	obj = dma_buf->priv;
>>+	if (obj->dev != dev)
>>+		return NULL;
>>+
>>+	/*
>>+	 * Importing dmabuf exported from the driver's own gem increases
>>+	 * refcount on gem itself instead of f_count of dmabuf.
>>+	 */
>>+	drm_gem_object_get(obj);
>>+
>>+	return obj;
>>+}
>>+
>>  #ifdef CONFIG_LOCKDEP
>>  #define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
>>  	lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
>
>-- 
>--
>Thomas Zimmermann
>Graphics Driver Developer
>SUSE Software Solutions Germany GmbH
>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>
>
