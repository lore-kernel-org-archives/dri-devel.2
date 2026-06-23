Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888BACD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E881D10E944;
	Tue, 23 Jun 2026 05:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="acx6yZxC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F5010E943;
 Tue, 23 Jun 2026 05:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782191639; x=1813727639;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qiF/KxXS9JCiPU2vhXqlcENimzmNiqMNk5aES6FG7f4=;
 b=acx6yZxC4S7eGSuN9t47Lqe/cxyxOXtaAE3N9M2dA35PiOG3arkos/ab
 jzPVnS8MB/RymMMZiZH3m9OP5cBSpeAJgeVg7Ukcbu2SgxneUV5clNYEe
 sgxate/SltZ5nDs76v4nvJINUS5aD2KGTmWw+kz6YAiZ4uCkUOVPsjLTU
 Jas5YQ+iBQ+HTizF0/y4iLWAZe80TWV3ejfAVheHBwsB0brLoVEmL10Qm
 4+zcXbYJRPCgPt3ffrVPTrIlZiXIeuCPJEWoDfYDIk4+U7CyofrjoomNT
 IPjIk0GtwXo/+M1bVeV6alnEPEU1CB0kjRfh63euwJcfANkFtmv7K9g7K g==;
X-CSE-ConnectionGUID: fcKpWLy+RZOy+MRQ/kv+9g==
X-CSE-MsgGUID: 4IdfmYOLRAG0YZH5cgE9wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93289327"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="93289327"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 22:13:59 -0700
X-CSE-ConnectionGUID: BTw0RZArRgGJnxNvzXBeXw==
X-CSE-MsgGUID: H5rZPUSqR+a3tPInJ3jJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="248531086"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 22:13:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:13:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 22:13:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adwjXzQ47Z94tMBk8j0Qu2hXJ+wfA3Jot/RyDLgKvcGQZ2t3dqMZVQLJUeYPl6VcSBrN8Ac2QCN0Md8frFDdbkFzuVKDyiSx/zPPjADZsXdvdrHxATDjawRHKKOHSKB8Dd/9RPQFGBbOfk5TOlWH7UMfd8vQ1u9qWqrV6gYXRt6abUwqDLLB58xt4ITeWvk4Siyl2IeA2pr6eELFueVXG3iwNfj/salJW06t1psgUBWlbnl6eIHzESAS+S3aAW4GqQxpOFiyROJmsUsHCvnotiMk0hAI2XLIBit93yz8Th783AWnSQuSA+TTzm9JujfF4oMknj7RG7SzVQTfGEHtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/L8TLiGz90u4aFq9IZQvbeEUrW6AMYQRc5t7hlbiG0=;
 b=IeyzWRRWcaDmtpxMKaYaGvyOggDqud+psOfzbpvF/0OYr+joQAdoNAgWcvgPqrCjDWoiHE3hyOR5tDBJ3V723tQQTcr98365ZZ8C9gpjWmQv3XAD+Qj/Gu5j3Nmy4v09kVgrxjihMpaAZDH3VFSSH2zK17bG0AHEykKVH4eAlTUiUYD0eqfBUnrMq8D+k9GnY/iMwuMYPX7EnT/umX0yev/KJRXfAgq48zT+xF+hCxSEB+Em36EKUy9ReejTNBTp9uKWx4XpEVAbX8MWnGiVuicuK5ENyIY6OQRiH0dKNpPNq3pW38t4wOY+50VEoY2r4xLEZkSOvqg4nq4do53fKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 05:13:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:13:42 +0000
Date: Mon, 22 Jun 2026 22:13:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <mripard@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <Rodrigo.vivi@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <thomas.hellstrom@linux.intel.com>,
 <tzimmermann@suse.de>
Subject: Re: [PATCH v4 2/2] drm/xe/vm: Add srcid to xe_vm_get_property_ioctl
 fault report
Message-ID: <ajoWA6048WpLhdUW@gsse-cloud1.jf.intel.com>
References: <20260618153312.877948-1-jonathan.cavitt@intel.com>
 <20260618153312.877948-3-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618153312.877948-3-jonathan.cavitt@intel.com>
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 641dcb83-d962-462a-1dea-08ded0e63128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: sBlrfH9+GDA0vTtVEk6GS9qYv0QX7PyErThSNbB7BtUddA4c8mxW1iLUn5yazNvxdcNb5IPuv1aOKx0cdE0xsXCRGd/oNZHpIji0WMh2BOPp+Q/6lpIoB8cvLvxI14mYfeYuOy7gVps5PHbhbR4StFKLoa4wBrW602coeG8hi0tiD/vFobjFPPDWwKlCZq6r0KcIIe2h941AQ0UuMPwq3BSXA7jmXmTS8HO3GI3dJlOMLN1CVg16e+dvPdGJRwvhzN2mmKYspM6FKJ1JQxUL8GvoDXJyXGnUwYGJSb6nWhCljRhJfYRobV/GWvaIHhLAzlcaoR6WEw9u0cuKN/+6LQi/BC7hEgpsCRjgq7/LysCP3VOxTJaUyG48SSg8EdG0zd0yGLUu5WqCKWI/TYOmc8aHNGLYgRnW0ZvwGCXolYtdg6XQwEUxERhouYIlLU/xE7vrfDdOR8g74nnjMCWZlqcBZRQoXlDE9RH2HiPIDRwzRKHH0zrJFlpuFUlkxumIu3EXjn7CEWyKtnwRQ/EO9s+PGz8kS7XMEQo0c2HkHotVaumgBAfACqQA39yuUxlx7YRdGIbzZTI2VqJtoBl+N7oXXpONGO4h+uNl1mO/kEm8YdiuoM7X5w29rCQ6CuEed0OULJQAteud9kPvnQhQuuJ3OkLpaQMrD6LM0nfYUmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Yqkw2bHWkig4+d/Fo6tQBsJgVotui4VoX9hWwRgqezriwpYdPLWYavEwFz?=
 =?iso-8859-1?Q?BGjgUBSgvm3f84IPDzkBT+KLtGI97g4ZYy7cevW9s26QnZxiBKZ+LOR21h?=
 =?iso-8859-1?Q?Z5x2gfQwrG8pEgt7VCODHUoaRmKIgG4Xb92IhmsknQyQQodc3tR2VumpqR?=
 =?iso-8859-1?Q?lfKbtHvM8BamLve2CLBJUo5TSwjNBl9T2cmtYqXTgpVLoUxKvkWz8C3DuW?=
 =?iso-8859-1?Q?lHuh6sEbpUvtXvZXsdC7S3k6lCXFDnuD1D7hN4BCo0TWeGYH6uPvU2j0k5?=
 =?iso-8859-1?Q?7JTHgz7ZIY18JyO6nmHkLOSV58tIqdXO04cyWHmdbmPMDrDBePFGK1jP33?=
 =?iso-8859-1?Q?7n/ITaCP2h2xk+9zGAtScOpK5n7ikapERBG4QeDWsEaCqwAAZ33TBx04B4?=
 =?iso-8859-1?Q?MDZ1Ysa0QK0vAgeD2Jhtl5QoGZoCSIuoLeGObjs4k8DvkqRMvcZISud6fO?=
 =?iso-8859-1?Q?+PwlepuHdEtgu9UbKapZIDgfHFfjaPdzxmdEsOKcxnn3nDsKSnupa5CKXD?=
 =?iso-8859-1?Q?zr0lCDov2ii3YltlxFrweEuWYL9jp93OzB/Xfi2YCME9ZNgzP+9dBl/YXB?=
 =?iso-8859-1?Q?JxVGixb5Fv8ObBc0Ry7o/szeXHKzgl5j5zECQjZhB3UNc560DLxr4Xnx1H?=
 =?iso-8859-1?Q?30y0TzBJRdQYDsHU3kUG58Sst7rWWnQnnFwj3m17z8mZjulDrQjCWH0TB3?=
 =?iso-8859-1?Q?myMvoRdfk4P/+7jnC+0mladJbqgJZ21vu2HB3pCCi3HaEYwWpWx0yKwRGQ?=
 =?iso-8859-1?Q?fxkAe/gQ2gUiF2Y8+4X1YotQAC7dEhJ9JQjDuhFFfDs+N6l06kGfJ1VMfn?=
 =?iso-8859-1?Q?pd4gRfcF6or1aHwePxt3fpbVYyf0g1Aymkd2zGFVakFPokUtosaz3brk6g?=
 =?iso-8859-1?Q?O8vopcKd0vNSZeXENaFRuUuKLKaCaV3UvwM2k+ZhADm/KlOf35rJbRqPAx?=
 =?iso-8859-1?Q?+v6WyEpg+1zs/yhO2yOQq2n4f4jrTy+irjbdPVegsFO9yFX0qsgjrAoAWd?=
 =?iso-8859-1?Q?A4IQNoh/auqBGyvSSJWJEUuLgA2HI6fbSy0TJaHFWiR1EtDRCUTlHu07lN?=
 =?iso-8859-1?Q?D+bFqXiOiZ2yQdgTsMfMszCGAOckl2fLEjqex86Ds5NQDzI0Gn9eMrjEYc?=
 =?iso-8859-1?Q?SnJdkj/ud9CNUfQT66gOOvew1RNe/j5X3OXBob3zYzwz7d7EC64bWBcrYi?=
 =?iso-8859-1?Q?e3GbGVQTIrB5enSQ1docU784h4pN8cqcJjg6t7Gn3oWrRd5Y89vmFMkhJK?=
 =?iso-8859-1?Q?26glqs3/2Rm0b5tPRXV6L69pq/jbBjnDz28WLK8v7E+O9qOE5nPRmiNPWF?=
 =?iso-8859-1?Q?baMatYUBL1D/0cL32mln56yyc1GIpNSMmxKZ3yog43rdHNVnXnCP+9nfqj?=
 =?iso-8859-1?Q?GiDFrybzVQA6iXbQQbVjeBHImYsY6n9LvpOa93NjwKJnXBNH+0vLr2tLAs?=
 =?iso-8859-1?Q?NVGwU/qTRKDN4tbosftHNi2N59Xnhn5+/X9/lkTccuuW5/w8UVV/UVOLxS?=
 =?iso-8859-1?Q?7FszJOJ6XMRZny3V/NTT4yo311mwDheENoqGy5auXV3fCJ6hWdi21s8pSd?=
 =?iso-8859-1?Q?NxYvi/k3/N6KaGn6UK9Dpl5tN5pzhIYEwFWPzf7CSNQdZvq4ks5Be2Xkhr?=
 =?iso-8859-1?Q?+D/sBGWTP7MxSMU3IZgybJtwMUVmxXF2NO6HIMW25smFOlmmfDUI0144xN?=
 =?iso-8859-1?Q?D9/+uLhu4ANHtxpNcGCe7Haf5mM2Nl6JW+4ItearpsDYIe0OegGeagmBPE?=
 =?iso-8859-1?Q?RQcijbrWEA3iSR+zS8y1IXoJF2Z1OV2sxGXpp/+8GHYDkVJhMLNX6+UHgL?=
 =?iso-8859-1?Q?x4w+KaHYRQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: HCuMEpO4q9sZHHsga0V4jPSsMMu/zsMUY58cqGjggBgTIZMtgAl6Gi8AJKUDED39z0TC/hjhmfkLRfTGQWMZyTMDPk6FRTvfNGH9hpHkz+Ds0eguW6XIpci11JRRofw5vx5mvjLUv31afiW3uZD+niFx10LGmoczYF/6YR2H/ERqnNIjQ3KlbRw9URfDFSJW6PJqmwGlEmCxRaGQ+yYtGk+NRKj7XFW+HTsjlPl8sF4TDJ2QDNCIzB6tQ+WOvhE6xHeb7z/EBLl7ZbIayriKMJ2CajtJ1blfguCIpS3k/9rkNVHdd6rdn/RPZL8L7IyJrRqrOK7tUMaRwVKGgCudug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 641dcb83-d962-462a-1dea-08ded0e63128
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:13:42.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/estkP7drbxpZVu+7fVKckcwTb34xbtWxRq2J5hRhcZZfaBlN1g1D42HOd1ZxNy2T2aBSUB6OnF1xQUXxKLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
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

On Thu, Jun 18, 2026 at 11:33:12PM +0800, Jonathan Cavitt wrote:
> Add the SRCID of the faulting hardware unit to the return of the
> xe_vm_get_property_ioctl fault report.
> 
> v2:
> - Readd pad check, as the pad in the ioctl struct was not changed
>   (jcavitt)
> 
> v3:
> - Squash SRCID with ASID to keep the struct compact (Matthew)
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

But also please get an ack from UMD teams.

Matt

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/xe/xe_vm.c       | 8 ++++++++
>  drivers/gpu/drm/xe/xe_vm_types.h | 2 ++
>  include/uapi/drm/xe_drm.h        | 4 ++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 080c2fff0e95..acbfce19b356 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -636,6 +636,7 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm, struct xe_pagefault *pf)
>  				  pf->consumer.fault_type_level);
>  	e->fault_level = FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
>  				   pf->consumer.fault_type_level);
> +	e->srcid = FIELD_GET(XE_PAGEFAULT_SRCID_MASK, pf->consumer.id);
>  
>  	list_add_tail(&e->list, &vm->faults.list);
>  	vm->faults.len++;
> @@ -4108,6 +4109,11 @@ static u8 xe_to_user_fault_level(u8 fault_level)
>  	return fault_level;
>  }
>  
> +static u8 xe_to_user_srcid(u8 srcid)
> +{
> +	return srcid;
> +}
> +
>  static int fill_faults(struct xe_vm *vm,
>  		       struct drm_xe_vm_get_property *args)
>  {
> @@ -4135,6 +4141,8 @@ static int fill_faults(struct xe_vm *vm,
>  		fault_entry.fault_type = xe_to_user_fault_type(entry->fault_type);
>  		fault_entry.fault_level = xe_to_user_fault_level(entry->fault_level);
>  
> +		fault_entry.srcid = xe_to_user_srcid(entry->srcid);
> +
>  		memcpy(&fault_list[i], &fault_entry, entry_size);
>  
>  		i++;
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 635ed29b9a69..e8aea75341cc 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -196,6 +196,7 @@ struct xe_device;
>   * @access_type: type of address access that resulted in fault
>   * @fault_type: type of fault reported
>   * @fault_level: fault level of the fault
> + * @srcid: ID of the faulting hardware unit
>   */
>  struct xe_vm_fault_entry {
>  	struct list_head list;
> @@ -204,6 +205,7 @@ struct xe_vm_fault_entry {
>  	u8 access_type;
>  	u8 fault_type;
>  	u8 fault_level;
> +	u8 srcid;
>  };
>  
>  struct xe_vm {
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 48e9f1fdb78d..2b45b691a032 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1294,8 +1294,8 @@ struct xe_vm_fault {
>  #define FAULT_LEVEL_PML4	3
>  #define FAULT_LEVEL_PML5	4
>  	__u8 fault_level;
> -	/** @pad: MBZ */
> -	__u8 pad;
> +	/** @srcid: ID of the faulting hardware unit */
> +	__u8 srcid;
>  	/** @reserved: MBZ */
>  	__u64 reserved[4];
>  };
> -- 
> 2.53.0
> 
