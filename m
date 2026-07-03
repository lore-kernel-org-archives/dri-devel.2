Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F56EC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C61910E665;
	Fri,  3 Jul 2026 18:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="me0GXB1O";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D77B10E665;
 Fri,  3 Jul 2026 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783103765; x=1814639765;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Gpa2Q+hXf4yva+GpnxaC4OV3I48oETuDoKMn0Vi44zU=;
 b=me0GXB1O8ZJ+cbDputKf0dEYIB6fjX4JcraUVFmzuNDmeyEiHfyxntri
 vgv+B06ZE70PaeKYuz7BI3Umvf58Y87razb3g084NwEl4OxRX0J+AM5Gc
 n2WzmlJ4/vP5lGF3Upyhe+Ndw+mw78IyhAx6osO3YttaKpPNF8xKhacqL
 QyXOoX4TwwX36sV8SDD/N65Pgui2RJwDxdyn4gcRI6l9bbOYCyjPJdkuF
 k547Z+JNO6fTNZoBjb2vWNlR5ScDk0wPJCU/Dk4Fwytu7PRrATY46yZUD
 Lw5kOBYDaJZYK34ObnUWdecD322mSseszePo3/7zqw+6v0PRUXSsc7zYo Q==;
X-CSE-ConnectionGUID: J+7QNVdvQeefiuC+s1hPkg==
X-CSE-MsgGUID: b66IMM9ESdCTnW89mD9XHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="94504105"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94504105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 11:36:05 -0700
X-CSE-ConnectionGUID: tXT2bcflR8GkNZTbqt8gGA==
X-CSE-MsgGUID: OSh9LyMYSneIkuBwB9plaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="248714666"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 11:36:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:36:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 11:36:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgRy46LvvML8dtOh6oLckwibDW1ut88P4Fi1MrJwACe2qzoMmdBsenbmb9uWL7+x+tKdewTGfFV6T0ramgCqsLXPioSda2UsF++6WYFVKeK6TLIzfOG8YCuNQ4TgJZNLPaeNuJ0Gp4hsCHk54NoS1gIiqOK23UuEZFm4A9dh6Vw553nQhG77DUiX5tgQLoiALrUkN6npaaId/kqRlDnaJ0reeJEJctlstHt3l2KAnGb1uqDcBNrg++kI3rpgBAfDXTO/pa35IuZoOxaWfgy58QqngJYppo5KvhIv9gsJZoQZMw+a/gJnIB3NoOT9y2uyAcCUtzgcn9bEpHTx3RvWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqec/8jWk+Kum0lSko+Xg/AG8OiIMi3qFoRgY+1a53w=;
 b=jnZzVf9eBpFTcjHqyHxGIZ39HVp3tqis+Csro2a6lFzLs5jNAfrG52459srPIXekLRiw1HLGuHa8FnnHZ8VbtZG7ahNZQJm3Q7z0k7oOQPC4Uh8QVUAdeB9TBi1q7i2cQK5HBAOsI6C13Lmirw7C0F7AisFmAsOFoC0/zID/YW3s9FXDG1ckOgwwvxnCLgkjaxK6kRy2s0TDzXLnFGq7remIUjWqnT5f+OCern8Abh7tJiUEvSIqKBK8p/YbeTjMWbz4mSRns4FXREn+OcJdPuIfPi7TBdotrcBDBXv39nLvNEzaoHtpaXR6LjYjLVgSK/3ODpP/SnNMVNGaKoLG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 18:36:00 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 18:36:00 +0000
Date: Fri, 3 Jul 2026 14:35:55 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Rafael Passos <rafael@rcpassos.me>
CC: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH RESEND v2] Documentation: xe_drm: fix chars used for
 subsection
Message-ID: <akgBC8A9h8nIyEYd@intel.com>
References: <20260701012141.167868-1-rafael@rcpassos.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701012141.167868-1-rafael@rcpassos.me>
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: f9537d48-e5e2-421a-bad0-08ded931edd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mD9CvjyIxeIz1CwIEe36xthg5shuWpJXmKV0tykuu6AAkKDDJuh/dITsiyHa1lLZNEfHqiPku3y9vmp5a7gAibhaByLMpQanlSOETPmWzd42mJaQWAIqO9c2gFcXxmhDuuFBfftz3Wr53cwd5JwiyrNwMU02CpiHd6rSR6nNkrizE0vT7WZa6Ph/Ta8DOIz9yz/jYMN+pW6EnUdZqIWMsLv+BR2ZQT8dhoxvzBWccM4wJoS7l3Q3D5SeXW9HP/FAiFBHwGGrh4/I0BwzD/R2bpkmWoKrDRr8Sj8kamOvQRSm2Dm2RlClXOb2gbwoloIDmmPZbtvXTl2waF61BhwdoDC+3oN+p3aEVlPWZX9AUYCAkDtduOeN+iKTWdzAwqSXqJGqolFcYF3tWBpoH7FL5hT9hfVAUfjMYC+nFYs5L9PUTyNWe9WVrop4pU6Znwlr4+L7eJBVSBWFoeieTlIT0uEY641EweszDhxNZUwc0Ng7ANKtyawMLyrCiyL0DgiCn4htKEUruyrKP7SHjs2r55YI7ROpJb9UjXx+CDGG9IgYELpG6knibTUFIYInGv20YigDW25oFKaSo81O6dCk6WL6jJbi0nz+kaHcSFqKxOq6ebu/iSndPYXdW4vpG3BjSfyewjzvDeMLU/si/eKLdqI63ms9CBvEVOHse/N9o7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?185k300RSNKXOkSG2uRiIWrEJsh2qm3d8AgnQhRYJpQxEDh59ec9+pROPtmR?=
 =?us-ascii?Q?hvGW8KX1UjhtRewfEa4IinGE9FxX5nxGROB3m9Rt2U39fhYFwbM4QT3C731c?=
 =?us-ascii?Q?g99+oZ6FzV4im8q4kBYe4mMbEL8kZQKu3Vn5qIrtsbbfT6nG/cTvEWI0QuBw?=
 =?us-ascii?Q?9YZUnx4h/b7HR3q+ukgc/H/gAcwKWiKmBYITtZUx0D+V4DEGda3Vtm+6OBKj?=
 =?us-ascii?Q?gI66Eco0+Nzai4UiBOYKVF054la3Z1it9hjCt80t3jiwm+wXpvQEIetpEa+0?=
 =?us-ascii?Q?kckasjp26ZHy5+/SmWF/LXgJtVTQPsvTq+CTRNvvaWO/R2kkOoD38vQDBmxl?=
 =?us-ascii?Q?VpPpC67Esurgxaiwtu5Bojk0ONTwHg7d+9SJo2vxAgPH9uKr+dBzgGCozDrN?=
 =?us-ascii?Q?xwsNINuhpKb9f3zpcaoh3pJ4QyPklTYRPDYTZG6eSshWWcC0fpImw2cW/fFs?=
 =?us-ascii?Q?DM3GAG69az2hW0bqRYG6tZvaZX5bZCsXe5cv8XdttPnnwAvl44HEq7P8pbqq?=
 =?us-ascii?Q?kiRK9JPiyLp2lWQrgQWeU5EW5Wd92A1HDsDv2fkGzfexNoBs3qJSaEjz9wC2?=
 =?us-ascii?Q?YoafWTiSnSctFVOVj5Pv5EKIOO9D9t+S+j9ZK3aCP8QcFfG1a2EYiWd7QaR+?=
 =?us-ascii?Q?aPmLIZAX/uHG9ydNdAYXx2asVv9XgpNnbffelgojUt3shHL02x79iOoHeYTH?=
 =?us-ascii?Q?WOSOTxhEOhXT+DG7LcWBbx6yK72GJRU8ifyBa8jBHa6gwvLhQDIcvCo3X52t?=
 =?us-ascii?Q?AwtOR+QAvd7aO3VREu0sUYOA2/QgA6YEtKb9AngwfmlCVGlPjLAJ44NX2mCz?=
 =?us-ascii?Q?8//p44vR2jaRIc6Cq02fFqEbJvvwn0d4GpCwgQL1/AK+hriy6Tn9bqgKFjjC?=
 =?us-ascii?Q?XdcW09LF8NcCUhUldckBnmJqE9eCqE5Xm+DgFG1NUHWR+BWPZI8W/SiZTFqi?=
 =?us-ascii?Q?PAA6zrRyy1G3Nlk9MB0Yb8DcFJbJ6/+Z7WyijYOk60HJSVPdwvH+zNctywW2?=
 =?us-ascii?Q?BsJZv54H9ybBIlGb1D9jdKPi8r3fHqPZVHUTtntVuy0JB8nE+o1P2PhyR6Zk?=
 =?us-ascii?Q?74gatQGsTPfZjvdaaadlVrSnZkz+ybg6YscSq/jVGzVaqvnXGPVkgsZgsQzF?=
 =?us-ascii?Q?6MkOzAfZMkETdVjPPP1+aBWBQaCG+msgL39vEkppk7cI+1MYwiQEBmfVuHUU?=
 =?us-ascii?Q?o8CrGyAH+K7HWzK9n7dS5EXDstm1KDIji4zIUJdc47HNGUytHqGICE+bGSvi?=
 =?us-ascii?Q?HgpsbCNoPDUyfZmA9z1mAFJhfNqpQSTZWjibkRN0td7zN1ogaxp1cqB0wzv8?=
 =?us-ascii?Q?aASzlF771dQ1BUtktJSxVssCtjsdMSUqnxu5Lg3H5opL4PjMdTlHHLpfZjQQ?=
 =?us-ascii?Q?fUhHtzmbIm1xfCKaYwP7aleYtDY0oQeup3VZGCwyPCC1zHxAbrHJPFXV7fyN?=
 =?us-ascii?Q?w6lcK6FpHTkCq/GsCg1MyzOFPWCR/2LRtEoA8xDOLU0c47p5WBRY4GWh1+MB?=
 =?us-ascii?Q?z0+J3fiWBiVqB1uohdoP5JF52eFZcrRJqT/R5x6zDlKN+Gr67639XT+S2Zqp?=
 =?us-ascii?Q?cnFn6zQ6Sl3P3edRQA7OCksdEFBAvA9nhBxLzKqZjdCcGbr6RCnHgIjuy6n6?=
 =?us-ascii?Q?xUjbyLkfNDiQIvr4o2kKVJ7BEPGdbhuvdWLug7tvcLjMw1ILekVYpEOIIrk9?=
 =?us-ascii?Q?I+aBtvgEvE9O51c9nXtlKY4fJ/czWejzt0YMC/kcio2LEh/0u3g9uEZm/Sb1?=
 =?us-ascii?Q?JvPuBsyFOw=3D=3D?=
X-Exchange-RoutingPolicyChecked: UwXIeW3WKdw+MnjIbynGXcUxMl2RDJaqPrXPfuvA9+9Dgkbv6Ei5t1YkZsOo/YBBP4jTDUPPaNKH+PQ7TS8uNYzp/vSvR/Ip4hrhzpgsrokH06a+KY0BSnhbHKbaLdCV4bO1RMZjydaZzjKr0qpRaWF+KfN6EpOW0G6NvXQQdcEjfosNMVsfnFp17/Vx5Wc/G2lI2KWPH1bYhGpPiOdGLfRPv8I8CJBG0AkSXD049FvvCrJG67HqtaeuqzDLQGEiccrO1cIMGnXlNw6i48jYnpgJffheLmMG7yxCPrPt7HJU3e5yOtM/jrCu6itVerDHMpJKAIE206B/JnxNIph6kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9537d48-e5e2-421a-bad0-08ded931edd9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:36:00.2000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy0OwWkHCBO1KGEEQfLdbsMShC88oceRHNzhQVJgtieqgG1rfl6zzfI1SXF20z/FPoWhMxpGYwsUQOaomi4vyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
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

On Tue, Jun 30, 2026 at 10:20:58PM -0300, Rafael Passos wrote:
> Fixes "ERROR: A level 2 section cannot be used here".
> Equal signs are reserved for document titles.
> This file docs gets imported by driver-uapi.rst,
> and the page title is defined there.
> 
> 
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
> Hi, I send the v1 for this patch only for the linux-doc list.
> The v2 fixes this, and has improvements to the commit message.
> 
> It was reviewed and tested by Randy Dunlap.
> I decided to re-send since the original emails was not in picked by lore (not sure why).
> https://lore.kernel.org/intel-xe/1a20e4bf-fd7f-453e-b7a8-c7feb0b077c6@infradead.org/
> 
> In case it helps, here are the tags Randy added in my first send:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Next time, please put these directly above the '---' along with your sign-off.
And please use the standard 'drm/xe:' tag in the subject.

I modified the subject and pushed it to drm-xe-next. Thanks for the patch.

> 
> Thanks,
> Rafael Passos
> 
>  include/uapi/drm/xe_drm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 48e9f1fdb78d..4dfb30e6c8a8 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -2537,21 +2537,21 @@ struct drm_xe_exec_queue_set_property {
>   * Refer to Documentation/netlink/specs/drm_ras.yaml for complete interface specification.
>   *
>   * Node Registration
> - * =================
> + * -----------------
>   *
>   * The driver registers DRM RAS nodes for each error severity level.
>   * enum drm_xe_ras_error_severity defines the node-id, while DRM_XE_RAS_ERROR_SEVERITY_NAMES maps
>   * node-id to node-name.
>   *
>   * Error Classification
> - * ====================
> + * --------------------
>   *
>   * Each node contains a list of error counters. Each error is identified by a error-id and
>   * an error-name. enum drm_xe_ras_error_component defines the error-id, while
>   * DRM_XE_RAS_ERROR_COMPONENT_NAMES maps error-id to error-name.
>   *
>   * User Interface
> - * ==============
> + * --------------
>   *
>   * To retrieve error values of a error counter, userspace applications should
>   * follow the below steps:
> -- 
> 2.53.0
> 
