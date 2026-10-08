Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D00DCA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C0110E415;
	Thu,  8 Oct 2026 16:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PCEKF64J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDB410E415;
 Thu,  8 Oct 2026 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791477781; x=1823013781;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qmLT8uznC/Lag1FFHX1GrbY1fLWBQUx/SoHJq5c0dcA=;
 b=PCEKF64JawlrYf8eJ1Le2NJhLYydv9J8mB6VBu/ENXL+xCAJlGTJBn67
 vvdfcuQUKx3nmMTGwyXdebgIQpI346x3iHlW5nUUYhGkt80bjtQrNXQ3S
 pMmfn6tXdTTgL1isWqZ+TNz1olkzRHQd83Mbt+2xMF2uOFtzjGC7VRl2Z
 FY0lYUCPkMIs1BmOAQ2JW2jzBcbbA/HCd2S19MdbHnqFnB/T/IU1PZnaL
 dERftA8uoYEDs4uSBZTqiBKddg4KwpumEZKLydn9l9Tic28tI3GnEU5+q
 N3rTmyYalGUzjWRY8uFd8hXior/z0BLbJSvrDiYDw6ZJ3io6cSonBdPJZ w==;
X-CSE-ConnectionGUID: cUa+5qxSTJmoS711lZS3cw==
X-CSE-MsgGUID: xuKNFXOOSqiJRTeeSpgfKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="152397"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="152397"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:43:00 -0700
X-CSE-ConnectionGUID: eRkZCvJxQziSAuq1srV/Xw==
X-CSE-MsgGUID: mC8L9pn7SWm5gzlwm4lH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="86992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:43:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:42:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 09:42:59 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejsxG3kqUClc0Dx/61wmw65MstsjHcEs00/Ql8f9aBqIT2ctVQpT9cEZ+3CdRep6xwjQZnEiy4NUwhFkQv4M+XbGRveqr76w7Frc33gfno6PPsErCd4H0hjXP9AEbEGT/0W53gkJx5ZHxC3huawKDpzfWvnCM/HEaeT2CxIDFDSbOKPlaF9o2mJWeLlvQ8ph4AcaMEMABE67UVAdlncCusxPBzaGLxYzmZnh4LDCtdEjzJp8j8/lquU6jIT1pMCyTa+p3ZSOIIhuEnYu8sMCft0JdaZVojQ0xespm0Eq4k87CriSGZsvfcsC2t+iyXB4r99XW6NcaB4DvYl7NcJGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6x2HPFUMbEKp0ptiXErhWXs6l/GYKdwkUkalqMW/pI=;
 b=Xn9zk5/SwlxJpnpYYmflGF44Rt3Z3WBtPjySMTnAuAuuCDkYx9lg440tG1z9JmTnZrL3TCI+3rWUuM2mR+qYPcozaBF2hYsHumaqazS+uMs3CKWhS1gFk0gnj/+ZJJJeCJf/u5OylMQCgllqtySFtMJ2c7tMcwZwiWRxHaBYMsyzUO6MXMYIwzOLkGsbl12hCM2jOEpyjKR+x8lcUI8wM5fLojmyVPHBv1/GXXXnMKhi7/rkLTxOenKzQi2PR5QrqVyptrlH7UyDD+wFjp2+fYldvIPNYwMO+ZM0QUUGiZMyGHX0yKXx7pX+PzT14CoPHDvaOEgkKJQPOGVxvpULRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Thu, 8 Oct 2026 16:42:51 +0000
Received: from DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb]) by DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 16:42:51 +0000
Date: Thu, 8 Oct 2026 12:42:34 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Menachem Adin <menachem.adin@intel.com>
Subject: Re: [PATCH v3 1/2] mtd: mtd_intel_dg: add survivability partition
Message-ID: <asfH-tNJlKnNrJV2@intel.com>
References: <20260930-cri_surviv-v3-0-357aeed5fc60@intel.com>
 <20260930-cri_surviv-v3-1-357aeed5fc60@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930-cri_surviv-v3-1-357aeed5fc60@intel.com>
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DS0PR11MB7192.namprd11.prod.outlook.com
 (2603:10b6:8:13a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7192:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc6a454-f7fb-4a2e-36d6-08df255b30f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: O1xUzeMx9VXOgUCHRmxNm5MxkdGD9qKoTe0iZ2VQVTTmpq8YYiOtbJCw7AZchF6YUaMxhsHxI4w2KdXs3M64yebEhIJX1P7TykJM8NxaG20ildLCOpG59C7BdbCxY19ZMudoxOQZKEEUC4sh+ccdO/XkxHnEmTJgfcFRMA9Z6xoUOfn3Z9IaTEqUUkozyJL1jVJrD4tCZN8JaYaroh/IJjynVxraMJ6qOfzpx6vVJFi1qGtSjTI5XlqlQNsSziDHMbS+tbvpPeuAvr5oqbMt2osADZ19a1N8/fkWkLtTvZ8FBx+k6IAcnhhdKwQHvuTAgUvMr/rFQkKKDSCaFX1i7oBNu0FpTfeLUGaHo7oZb/TjHzO6JUEftDuLKiHSLF2VvwcjQtoej7nABgzgTEG/7cXW460RHh3wy2AI9TxCzx+wo3ah8fu9b8OB9rEUZjGoXYzqVKN8KyTayQCYzIka5GbLveCj376l4Zc199tnBwB2QU69y+2UcFY++rsynMmk7+FNL/RZieAqZ7o2wR0J46YrskAE5lc6BQb3e2V0Q73wGXAHfBsPMwnoJfIYM2Haz+nohHew2R5WCFvBSydBvBEeExEwkWvE5imR8PeFaFV5htHC1OoBLMQrC+HamsYuvYvnieInBttzu9rT/OQ9hwN+SaTj7z/TYECowiZG9c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7192.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71xOXq4+Qp6FXAhGYf3NOj2lv/WWdhXJNP7Wf9v09+K/1fijb/bOFDnlHw3g?=
 =?us-ascii?Q?SiwrunYFz+rmd5XnxcSava92O3W23Cbb8PxmDIjvz4VgHTRJlDLneUQ4zAOV?=
 =?us-ascii?Q?I0WagNl/IXAjGrWQl7mROBa+O1zZLSyvPfj6jhrH02AVhNj1w2vcyxXVstO1?=
 =?us-ascii?Q?lIvZXKz+cFOApriF+zOZwSkQV1M+7jdLOCjsDT7dpdSWiYeC0cOR4W5UGdgj?=
 =?us-ascii?Q?kLaSG+yDbkYm//u0iNG3nKvKyrYkOnHHY4CH90qzM3VVV+MgpzSYLpgGNKc5?=
 =?us-ascii?Q?J9H3+rn8oD0aza3DrqqHkurFfiIhK/9gN5G1RZWZ8WpZYUoFS5WQqwRH296H?=
 =?us-ascii?Q?W2qZb/YtJpnyl1GWV2VUy6U/nVYHVxl6fuIdf4hXeNxM34ZPbxgzKob+6UI8?=
 =?us-ascii?Q?5QPRqav7AC4jyj9m3osf4S25HQtsRvk+1gswrwYVU5gnI8JlzT/MlTHvRzcI?=
 =?us-ascii?Q?LzOj7X6uNf+ptxri9iXPvcrumOcxxdi2z6Kr9n14UqzWHBOtniF0EApPxpG4?=
 =?us-ascii?Q?VY7WKQGM7AAPiRsZ6Cec97Bws9KYIZjKCs1FalPlXQkz4wvV7IcUcrRBymE4?=
 =?us-ascii?Q?dCqD2dhEpZZdn2yfQ9FNrOO8UW8dtoLC+2etCuV/nhipKmiHDnBkErYWzmt5?=
 =?us-ascii?Q?kNfxQvZhHeR/lizeuYBYGgsQW/vm9Ma7F+srAwJGq94qPk2BtdEhx3xX5ARN?=
 =?us-ascii?Q?ek6EwmCcB8uQKqIlz46kCKFcLVBa8N+HMAX2MqBTivoY+Tc90lLhRwq4/xhO?=
 =?us-ascii?Q?cQ4t4ku06X0jbqwsEqShUh7CBmGffpLsbTtLNIaRq4PgUgGT3ZOCWlUIkEeL?=
 =?us-ascii?Q?8uGqav2v+T42EaYqJZkIrPfw/SrIun8SitnmzK22gk9Vl8BMRy08my3meKF6?=
 =?us-ascii?Q?+cq8MjHoA2eOJbhPSvWqoeKTMt7of0L9uMBw/mplsnNEP3nZfG7B8+1Doj6k?=
 =?us-ascii?Q?5uMnQCH8Xat751b3YYz0wJH0K3iMEvJiUjHKhg/+R3kapTfFafe2xb/VFv8M?=
 =?us-ascii?Q?sJdi2Q5N7jGodSUmGldujAy2nF2XgPr5bQJqHXVLT0l7K/rag3s7QQPVNngL?=
 =?us-ascii?Q?wMctABdv2QZigQrUjMhNmdZ7GZYVIwpnr4wnsFaPt5jqp9isEZZz3NhjKUPW?=
 =?us-ascii?Q?bf+jTdFEaXFWxRDBJqKBT18d9I/hrj8KK8Qkp1eDQaugAzfjwrQDgW2RjN7J?=
 =?us-ascii?Q?utfhONHRcTtfSwX7TrcVp7z6EoCBsfwX/SznIo8f2RCZCu7VlMhaB4HNeCEI?=
 =?us-ascii?Q?GpIsiwlh3gkkTHlCxbqqCVP3z0rvV/Q18t/SWK2Wx5rnbBWIY+Af4//3NTW2?=
 =?us-ascii?Q?dg4Tvk5Cgb38DHxyjBqvkYLH15jaDjItbsj9a0J4T3pmd7uKY97PgKlCm/fe?=
 =?us-ascii?Q?sivjd/XreWZbmY/N8HpZEUZ58L3zzpetUiBv5ypnzNPtfP0OhiKrAY5jeET3?=
 =?us-ascii?Q?E+EWnscy2pJp9pTAdqPvo//tDqzuMuwq2BTacgslO+0bRQe7b29vdnbDvraA?=
 =?us-ascii?Q?u4dbRgzcpSJIOGtdkicXBcXD9qaUtdMLn6IgrjlZVnDg30KSnHBHA7v3qJ9V?=
 =?us-ascii?Q?bIchroECxhOOa5CT8vbV2eP7iU+vwanSBYUR7dHwFYkTcP9oROyy0t6xwJM5?=
 =?us-ascii?Q?KSjAwrtEhlSs98vF/a2J29diJ8HoVJhCygVUt//W5J/IzsR7i8QEiQWNwt2+?=
 =?us-ascii?Q?3gZ0LGaKlAXR9DCsPFybw+iq9Jjgsjt8mOInsIXwd4Kn7d58WNb/pg1L+W3V?=
 =?us-ascii?Q?YTwHWLyrC/BIKXlBtg8rZGr2CS+x0v0=3D?=
X-Exchange-RoutingPolicyChecked: XnU6cut9Oc/PrhAFqdex/QY61ZInliQNJfTuTRws5NihHZaKa2I7422xgMwVWIHPwRjouvZRtbtiQtAzbmGM4PixQCtlbGepKBB47gflVJBDIsPsEy8Hm3UxKxNhYAi2hMmMe4glJTeEVPzsrZ1cSMWEhBFO4r56Ju38bfmbI11usYMhB6OPhpQpG1ItkG/MAfyDEparliG2Ijr4K52c6XC4HpfErHz763J1tRO7bWv3TRQ3kFa7+ZyTw9SWeX9Rj//VzzaGUts6yMiyCAJE0qU3HEs0jIM59PjMz2yIx6t8COgqZKqlkJBF/OBoEDqiTbDKG4FQQGbVLu0TK3d6Pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc6a454-f7fb-4a2e-36d6-08df255b30f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:42:51.0046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNYr6KfBR6aOPwGn/XY+zsxfww5UQITJttmaOHFBu/7dewmnGlS8tUMJZT18jM3PWxLyzfCJPZyacEmbdNoOfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
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

On Wed, Sep 30, 2026 at 05:14:46PM +0300, Alexander Usyskin wrote:
> Add option to expose additional fixed-sized partition starting
> from the beginning of storage.
> Xe driver can request this partition exposure if firmware or hardware
> have detected failure that may involve corrupted partition table.
> Fixed-sized partition allows full storage re-write in this situation.
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/mtd/devices/mtd_intel_dg.c | 65 ++++++++++++++++++++++++++++----------
>  include/linux/intel_dg_nvm_aux.h   |  1 +
>  2 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
> index a566e86eb5e3..976246e94e79 100644
> --- a/drivers/mtd/devices/mtd_intel_dg.c
> +++ b/drivers/mtd/devices/mtd_intel_dg.c
> @@ -31,6 +31,7 @@ struct intel_dg_nvm {
>  	void __iomem *base;
>  	void __iomem *base2;
>  	bool non_posted_erase;
> +	bool survivability_enabled;
>  
>  	size_t size;
>  	unsigned int nregions;
> @@ -430,6 +431,15 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
>  	/* clean error register, previous errors are ignored */
>  	idg_nvm_error(nvm);
>  
> +	if (nvm->survivability_enabled) {
> +		nvm->size = nvm->regions[0].offset + nvm->regions[0].size - 1;

I see that this offset + region.size - 1 is also used in idg_nvm_get_region()
we could perhaps define a variable with this and document the - 1?!

But it looks right, no blocker...

> +		dev_dbg(device, "Registered survivability region %s size=%lld\n",
> +			nvm->regions[0].name,
> +			nvm->regions[0].size);
> +		n = 1;
> +		goto out;
> +	}
> +
>  	ret = idg_nvm_is_valid(nvm);
>  	if (ret) {
>  		dev_err(device, "The MEM is not valid %d\n", ret);
> @@ -481,6 +491,7 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
>  			n++;
>  	}
>  
> +out:
>  	nvm->non_posted_erase = non_posted_erase;
>  
>  	dev_dbg(device, "Registered %d regions\n", n);
> @@ -753,15 +764,19 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
>  
>  	device = &aux_dev->dev;
>  
> -	/* count available regions */
> -	for (nregions = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
> -		if (invm->regions[i].name)
> -			nregions++;
> -	}
> +	if (invm->survivability_size) {
> +		nregions = 1;
> +	} else {
> +		/* count available regions */
> +		for (nregions = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
> +			if (invm->regions[i].name)
> +				nregions++;
> +		}
>  
> -	if (!nregions) {
> -		dev_err(device, "no regions defined\n");
> -		return -ENODEV;
> +		if (!nregions) {
> +			dev_err(device, "no regions defined\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	nvm = kzalloc_flex(*nvm, regions, nregions);
> @@ -771,21 +786,39 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
>  	kref_init(&nvm->refcnt);
>  	mutex_init(&nvm->lock);
>  	nvm->nregions = nregions;
> +	nvm->survivability_enabled = !!invm->survivability_size;
>  
> -	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
> -		if (!invm->regions[i].name)
> -			continue;
> -
> +	if (invm->survivability_size) { /* survivability partition */
>  		char *name = kasprintf(GFP_KERNEL, "%s.%s",
> -				       dev_name(&aux_dev->dev), invm->regions[i].name);
> +				       dev_name(&aux_dev->dev), "DATA");
>  		if (!name) {
>  			ret = -ENOMEM;
>  			goto err_norpm;
>  		}
>  
> -		nvm->regions[n].name = name;
> -		nvm->regions[n].id = i;
> -		n++;
> +		nvm->regions[0].name = name;
> +		nvm->regions[0].id = 0;
> +		nvm->regions[0].offset  = 0;
> +		nvm->regions[0].size = invm->survivability_size;
> +		nvm->regions[0].is_readable = true;
> +		nvm->regions[0].is_writable = true;
> +		n = 1;
> +	} else {
> +		for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
> +			if (!invm->regions[i].name)
> +				continue;
> +
> +			char *name = kasprintf(GFP_KERNEL, "%s.%s",
> +					       dev_name(&aux_dev->dev), invm->regions[i].name);
> +			if (!name) {
> +				ret = -ENOMEM;
> +				goto err_norpm;
> +			}
> +
> +			nvm->regions[n].name = name;
> +			nvm->regions[n].id = i;
> +			n++;
> +		}

here as well, I believe the if survivability block should only select the
different print name and fix the for delimiter to 1 iteraction, then
you don't duplicate the rest of the code...
but also no blocker from my side:

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  	}
>  
>  	ret = devm_pm_runtime_enable(device);
> diff --git a/include/linux/intel_dg_nvm_aux.h b/include/linux/intel_dg_nvm_aux.h
> index 625d46a6b96e..84b5b6e0c4ea 100644
> --- a/include/linux/intel_dg_nvm_aux.h
> +++ b/include/linux/intel_dg_nvm_aux.h
> @@ -21,6 +21,7 @@ struct intel_dg_nvm_dev {
>  	struct auxiliary_device aux_dev;
>  	bool writable_override;
>  	bool non_posted_erase;
> +	size_t survivability_size;
>  	struct resource bar;
>  	struct resource bar2;
>  	const struct intel_dg_nvm_region *regions;
> 
> -- 
> 2.53.0
> 
