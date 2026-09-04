Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ACFC61DD3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 00:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34E710ECCE;
	Fri,  4 Sep 2026 00:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i/VHyv+V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41C910E198;
 Fri,  4 Sep 2026 00:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788481022; x=1820017022;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VECTp8Uno5PEqTOBVLwpxPduWtQnFPR5aG6NXWhK5eo=;
 b=i/VHyv+Vo0qTtwjzQ0bweVApy1/Lzo0QKYwILc5q+1V5Ju3cDhKZ9dCF
 3VcWwKHrZ7scvU4uVOFDsLN7YIm0/sHD3Wtu2FSJqeE4DaHw/1SdB1RFP
 hS2DdgNhD5b7gwzU2l/z/zpPCDIjdebq+nhox/NizPdzYGYPIYRiv5cH2
 vH5V7WvtdlrrAAFjQieFpgHrnTuk3hTuFPokEK4bSsuYxmyvhmvey0jr2
 5S87kfHIIagRljtdISP3dbOF8qm4AtbQziKTGMZM6x6Omz12dkIJzu/t5
 F7cmWI5yamuZKvUUhodxZbVcB3XHd5xaZiCp9eT5g23W0LdB4KYf4kbE3 w==;
X-CSE-ConnectionGUID: dRqNbmKETY2sMoE4eBvwUQ==
X-CSE-MsgGUID: X5mS61nWT8epqnoUD0Vd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88860214"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88860214"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 17:17:01 -0700
X-CSE-ConnectionGUID: Qv09JPUaQ0im4RrJpVJ2zw==
X-CSE-MsgGUID: hAp+1SvDQHKL0ok4HnWl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293398898"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 17:17:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 17:17:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 17:17:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 17:17:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzWxaOaNrFax0sHe2iCmb4CyXocbFXSxoqdj+gR+R8MKNC1nJkLdkfNRk/HRRKLoIt3Myb2JKGULS8eAUtAQEtGIw10GYTy2bfvF3Uq0aY0jvr5HMpVRsN6oJt+G8Tr5dlFLq9joGd0NDE2IluyWAVet5zCNYW+Kf0JcTWyn0xCXFDSKF9n4w6TI/mrYHMRyVeusItDSAXEghISlQfA0JML0stLbv+P4UcPyn5STdFGPFjod8diIs0dFpq/1ysCLLAMFYZnwbrbboYQsfHbPcsOcTFOtJJ0ORfDVqJykk4aThlfWpInApr5gV9DKGmF5blqEEMVo+9WqbEGZiD23cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgOoMqm8v+FIw406ikIub+l54VhyHRQGE4wyXJT2ukQ=;
 b=x/SQpEgpsecZB7bjmOKsVew8l/vhIH8rnReECsC4OBnB/IFEyz3GlG9l69kyMOTCwZg0TChS2PfSJRWY/QOzTGc2tjQSEIu7tGm1hx4c5R+kClXuUmX15gdc1yYQlIiXsJosNGS2XJZL68zKfBRYikteuuMykAc42DmI338YWmI698DSNv/5NXzGP3os/gFx02Djx9PHE+Gx5tE+F8GA3N7MEQFCmX9bydCY590wDi4z+JPwoscsj9PukqDVlCrOTaS38sXoEVJLvY+s51FebuHtzjRwbu9seZaTwg3pwCXtgPAV67xyeY4OK2dmeId5Q13idY1ygGs28z1MrommmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 00:16:58 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 00:16:58 +0000
Date: Thu, 3 Sep 2026 17:16:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <alex.zuo@intel.com>,
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe: Rename xe_vm_fault to drm_xe_vm_fault
Message-ID: <apoN91t7qC1orEC+@gsse-cloud1.jf.intel.com>
References: <20260903231632.399765-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903231632.399765-1-jonathan.cavitt@intel.com>
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: ab15d7b3-3f6f-43e7-c48e-08df0a19d54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: UNKIFv65O4TAsRHQpzxpxUo+fgmFh1n9COv+SH9zYFxCb0R2C3pcRHotu9bTT8cEcmaJVxZ/sVE9HMfNi7qnp6GX0Eogx/JWMsMMSaIi5KeCwnvi3nrrRNLmV7Dp3fQ7fOUmAe2D6soEmL8mX28AEurgMTFhVeat3eDMffWg7yIttsAnbEOZCgvG0IkAfLNEd2Q4LKWz41ZElIm4LULqvdKBTAOq8dKtnZmoJM7kvUJEKG7+wecUtCyjNgGfXFHKbHji2H+2SIoifjcHbE0eTsC94izg9V5WqNQPz0aFeHUOHCFisj6pHcSD1eo5lOQlb4C5xxfAvhNKCXst6P1Jc2hE+JjA/okWmvFENEsiWVb9E1iML9C8VEObPU/7v4pZZfkHvc2R1bP9Zbw4MGLR3Dp+0Xz8C1lqO1+NSSH2QAjanmVOuOLdIpFOIuoqygRwg2mRQNIGATN4C1y/V5ydizcfjDiwglE3hilQsnhKLItDRojEJi2X/GCNzmGX8xDMzMTUwhWsqso75e08jYTIXw4DUFXP+Xv190rkxw+WZGs53ueTOgNdJZBVKaMYoEtV45UYKdELb+NMqFsvwoHF/xQz59WfH6jro7BVPlWoSROCB9bK1OZaQymVA4QIfmPGQnbZXlrXqOGsbNPII+N25Jb4CjTdj6TtM/93W5NMkNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xHKP0cuPfVAFjrKpHOSn8LdKIGm33w/xwTWxChbXiIdUf5rD2jeBtll2NAT?=
 =?us-ascii?Q?gyVlqZ1UCYFO2OnbvDQuKoaav6+uS5TLBr0kJ9WJNfE948Taq2GfmzxWe8d2?=
 =?us-ascii?Q?NSrZ0/apMAw0kMUnjFwguW+fHSuG9IUcXiCPfN/8s0VLEGb1xF4xD6TmEehN?=
 =?us-ascii?Q?cOTUvnSCohD9c7ClevFzYD4sq/C+T+pPhU6oFidFgH3x257b0siyF0kwsJE7?=
 =?us-ascii?Q?nI5MyhagPrPAkHLXnRIpW2TcqMCa3wTyFE7us1x5XYeBc0JMQMcMr9uhgvxn?=
 =?us-ascii?Q?F5XOQqv9SgOtFUb7YiXCrI0wQjVSqeO56qrtPAp6aCe7rJtPybCsF0I/I872?=
 =?us-ascii?Q?xj2YAsEW+Ry2yLmg5nWsIob/rpb73h9rQig7jM60SLf240Yjk31HU6c5qsbt?=
 =?us-ascii?Q?fu6VG+2kq42+n/FG5ioMAWSiHWDvWhXHIXuU20ajww7pLpmksMqfc1wM1Dce?=
 =?us-ascii?Q?/UCHmy1Gy2wKm6TsEUCCb0ue3v7Uz+7GktqP95hG+1YpjwasZvGZTp8lfdQE?=
 =?us-ascii?Q?iDqoljt9c1FQaly/PTv+Iu1bKXNE3DS+oVDKp+/rYAS/hXpPDC4OLIWUzL2P?=
 =?us-ascii?Q?Uj8eqZ/7M1FpQRTtM97vXT4JjY4dDViQXDdKOGMAqAbeyqQ+DZ5fonF1OpLV?=
 =?us-ascii?Q?rYcXHU+n3nhuUioCVZql+sDYnfiK7K/LZDWynhphhSCXrflWeIxuY16Ech4Z?=
 =?us-ascii?Q?osvFfS7+Y4rhmffVPCjMm/qOVvV6xxbZfbboUpkPk3a1KYDMD+KcgmyFXDGb?=
 =?us-ascii?Q?aLIqbqMg9qASE6o4semM+klPjAYM03mO7FlpC7Rp3gRc9RoM7ZiDzhuO1wCP?=
 =?us-ascii?Q?YiUPogdxU6wEe5lUoti/SUa8PlRIGIF6XsG0QsPtFTGnzbnFn9u53rlwly2W?=
 =?us-ascii?Q?mpL4f4cpKxCKWS3GL0WiMkpIianwq3byiHNXH15LgGz62ZwYDqd2N7FEpDnG?=
 =?us-ascii?Q?ID4oidQudlrKRkGZ96MBNIRK3e5zsDnW3HPPLAB5Nj68MJ/annZkbs453h1G?=
 =?us-ascii?Q?sJcuWGGwUwcRAcZRIpyGAFdtteOxapp32btBK6bw/uLcGYsDqKx0rW5s/ai7?=
 =?us-ascii?Q?0DJN4Y2wp0lrYZf2Ew/mwoSXfY2BwWemR+bROMZYpRMTS4bs+Wdlnu4mnBfe?=
 =?us-ascii?Q?wQkElKjGgTNhJ3b2YKq1CQ3Z6V1y6HpEbEoOIfz1uxqgjLNOk4xZzf8C7wee?=
 =?us-ascii?Q?FxexrxoFgTbdsT21fol/funovYAYMez47f0PBOxASZck4Zu92zaDXASygW2b?=
 =?us-ascii?Q?HZaN2rQiOntoG7zX1PssW98DGDiPuaf7iBzlMeEfwcEOrRPDPrWFa0RjoiCM?=
 =?us-ascii?Q?AhB0hyJELRFl0DBLWfHaBY39EzN0hBOn67UXXHyept1aPBjvyOpyemN04UAJ?=
 =?us-ascii?Q?CLo1wUHVZ96X/JmOyB6e7FLRgtBsV0Y8ufrMj+maollxK9hNl9uhsiZLCPhx?=
 =?us-ascii?Q?OBbQ/ROJ6uj8JYFv/D6jyBXou3iqpUUnmdpZB6tXn743c++je9YGXfyqoJwU?=
 =?us-ascii?Q?f3wCWh19+cSvPzakq7+Tu6yeheUtWOJWT4Z+YjPoMQh6BYi6me+0RZK8vue+?=
 =?us-ascii?Q?N8Jl4wLQM4RpM9XetSn+8pC+ml1CeQF+MlF5sqDOY9rJUZ7am8ORR+8rIthP?=
 =?us-ascii?Q?qLfejAcTUNCV9NYwZIlRqnl7c6wbbuz4z6FHRxmuOOBo+hxyivYRgNnmLjlC?=
 =?us-ascii?Q?7yuImgoyTIdZAy4KwG8kvdkaRWVEvPi6cghjVSX7wWUbZ7d7NlqB3/X13pHC?=
 =?us-ascii?Q?6B6JAWHgPflFcB9zIZz1lCSeyvNgQ4k=3D?=
X-Exchange-RoutingPolicyChecked: 2fENmMEX+aiN8epZ3u2sMMXeTBTfVR9vPBSpkz35OhvZFUu5x81x7X4VcK9e09F4duCenEYoNf8/iHCkCA+7e0roZJ8/rdpMM29CDXgzp9mGI4cWsXB7QHSksTriTSg0a3qw+ti/lo/xHnSFAkfIjuexaVk92AF8crlq/bjL6DIPxrdSBN3UYgtPv/cC1Hu4UFABrPyE1sFACYbJJoGAe9Vyt1NB2PPBA3Rc6GxYhlB5QWIC6HPAnNKv+4296emfULNN1BRfwV6eHe2H8lVJwNVrLTWxwYWyKirYXJdB8f0zumUOZSxjQ88fEsx5R9YN2bErVb1OFxXqfl7XIoN2uw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab15d7b3-3f6f-43e7-c48e-08df0a19d54d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 00:16:58.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfayIKulbXo4U+uwFcBXx3jmVM+IObduCA/0IOBbcC3tuaPQJmx9dUSiuW9G8issv9BllSfFqXJWHigmAU/kiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
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

On Fri, Sep 04, 2026 at 07:16:32AM +0800, Jonathan Cavitt wrote:
> Rename xe_vm_fault to drm_xe_vm_fault to better align with uAPI struct
> naming conventions.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Sashiko raised a concern that this could break compilation. I suppose
that's probably correct if, for example, a project is built against
headers installed on a machine. However, I think most projects include
the header directly in the project. Mesa, for example, does this in
`./include/drm-uapi/xe_drm.h`.

So I'd say this is a non-issue. When a project pulls in the new header,
it can fix the compilation changes in tandem.

That said, let's make sure we get an ack from Mesa (which I believe is
the only UAPI user) before merging this change.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 14 +++++++-------
>  include/uapi/drm/xe_drm.h  |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 753a5fc55baa0..22ce6f8dfb783 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -4286,15 +4286,15 @@ static u8 xe_to_user_srcid(u8 srcid)
>  static int fill_faults(struct xe_vm *vm,
>  		       struct drm_xe_vm_get_property *args)
>  {
> -	struct xe_vm_fault __user *usr_ptr = u64_to_user_ptr(args->data);
> -	struct xe_vm_fault *fault_list, fault_entry = { 0 };
> +	struct drm_xe_vm_fault __user *usr_ptr = u64_to_user_ptr(args->data);
> +	struct drm_xe_vm_fault *fault_list, fault_entry = { 0 };
>  	struct xe_vm_fault_entry *entry;
>  	int ret = 0, i = 0, count, entry_size;
>  
> -	entry_size = sizeof(struct xe_vm_fault);
> +	entry_size = sizeof(struct drm_xe_vm_fault);
>  	count = args->size / entry_size;
>  
> -	fault_list = kcalloc(count, sizeof(struct xe_vm_fault), GFP_KERNEL);
> +	fault_list = kcalloc(count, sizeof(struct drm_xe_vm_fault), GFP_KERNEL);
>  	if (!fault_list)
>  		return -ENOMEM;
>  
> @@ -4332,7 +4332,7 @@ static int xe_vm_get_property_helper(struct xe_vm *vm,
>  	switch (args->property) {
>  	case DRM_XE_VM_GET_PROPERTY_FAULTS:
>  		spin_lock(&vm->faults.lock);
> -		size = size_mul(sizeof(struct xe_vm_fault), vm->faults.len);
> +		size = size_mul(sizeof(struct drm_xe_vm_fault), vm->faults.len);
>  		spin_unlock(&vm->faults.lock);
>  
>  		if (!args->size) {
> @@ -4347,9 +4347,9 @@ static int xe_vm_get_property_helper(struct xe_vm *vm,
>  		 * the number of faults in the VM fault array.
>  		 *
>  		 * We should also at least assert that the args->size value
> -		 * is a multiple of the xe_vm_fault struct size.
> +		 * is a multiple of the drm_xe_vm_fault struct size.
>  		 */
> -		if (args->size > size || args->size % sizeof(struct xe_vm_fault))
> +		if (args->size > size || args->size % sizeof(struct drm_xe_vm_fault))
>  			return -EINVAL;
>  
>  		return fill_faults(vm, args);
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 8c852abcacf0d..89c0dbe227dd7 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1271,8 +1271,8 @@ struct drm_xe_vm_bind {
>  	__u64 reserved[2];
>  };
>  
> -/** struct xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERTY_FAULTS */
> -struct xe_vm_fault {
> +/** struct drm_xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERTY_FAULTS */
> +struct drm_xe_vm_fault {
>  	/** @address: Canonical address of the fault */
>  	__u64 address;
>  	/** @address_precision: Precision of faulted address */
> -- 
> 2.53.0
> 
