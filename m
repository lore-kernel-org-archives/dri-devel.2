Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151EFC61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC8710F42F;
	Fri, 28 Aug 2026 16:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mAbgo131";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C03810F42E;
 Fri, 28 Aug 2026 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787935532; x=1819471532;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cv+hyYt6yvGSAr2EgyahzzfNZNjpnqk/t2BOY/9qCiM=;
 b=mAbgo131Tu+5bDSPtfbdVwEaQsZOzAeFuoxfJ5i9G6OemP/M8Pb3R5QO
 yt37Gavuma7YXcO8IP/h7R2EZuqE6w+WPBTQQdLur3F/r9N8Xf7VDuIsI
 ymwnuuSyVff67OC6dMI0ZqFvzg6/QbXbDgHIO19IyFF7lP71w9IPF5cGA
 56J9X9JfnMiljvyowQCXujYGoSDvSd7qI3Dlk17OQpVybLcSpg4aZ6ZaG
 +hGZ9XGnvnyGaMKsyuGUDU+mWdDeUhfYteg6usy2d5OsiANKhj8YLpcvO
 BKO7vT2zzDGa9ZAyHaMp+3MRYB0iKYmaHLuLieykVrZdC7IQQInQrq3Io g==;
X-CSE-ConnectionGUID: zJuL8C+dTjy6t55fsgpPpA==
X-CSE-MsgGUID: P6H9qo/gSdywrdxHobmkrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88323371"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88323371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:45:31 -0700
X-CSE-ConnectionGUID: 3SfB7m2XRAa587pNhoPUiA==
X-CSE-MsgGUID: uTxevvjGTvKS3Nvnzs1Bxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="306423562"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:45:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:45:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 09:45:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtrHAXM9YMH+wIGLq1zf5kSwnio726mRmZsvZfLkjIsL5anC7AbWVza5fdZ7JspoHfpAQT4cWdz+M/B8R2Y2zW5LZxV/0ihovYhohsmAwzgz7yhsDwlzQQ2QagWXfMc4ErAckhVa6FraYr3UxkURQCGtabU8evQ1r5oJb2xbyHLFHxYaQpPRMVsTQrkQNc3sKgZNhdK3jkVPNlTxGG5GhtItMUB2+AHNdZs1JGKIICOt6SqT5SgsWnJV3l274cN6xwDqvVIXLEbOyS98byMT+2yqC6452e91LJMk94jFKg6xe0AzaM+niLlXfecZIiHsS7K5lymuFIIO0QE9eZpXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2LnDdAeDaGdu6+qsRP/yBIlJqnf3F+vhxC4EA9qfzY=;
 b=GhFo58vxGHrxcFv/NarlLGAaUBEuZJ9lMYlThfS40UM310K8NF2dCTKttHE857tEEk/65KLWiouhE87CTMtst1WdDJAFzrgJSudpROUvWJGRwZb3jrddK+PpsCLophavedRm6WknbOmy62zE/AEr8fiC0xSTmBI7z+wvEoM8V/miPdm+PcuDJdANPQs41nUQR+OkD6CThV4PsWFZ4UYaFB9NOtCd7gawbRtK9v3y1FrSfgpwGh0WWHTBZMEFhzJgo4WTKY3cXSvnkyVLIgQqf3L/+KG3ll4xgio5TXEKa8SBBOUVgvQZClbB0poDIVCndzsDSzzRIL/F/4x+o06gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:45:21 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 16:45:21 +0000
Date: Fri, 28 Aug 2026 12:45:15 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Ranjan, Joshua Santhosh" <joshua.santosh.ranjan@intel.com>
CC: "Jadav, Raag" <raag.jadav@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
 "lijo.lazar@amd.com" <lijo.lazar@amd.com>, "Hawking.Zhang@amd.com"
 <Hawking.Zhang@amd.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "dev@lankhorst.se" <dev@lankhorst.se>,
 "zachary.mckevitt@oss.qualcomm.com" <zachary.mckevitt@oss.qualcomm.com>,
 "Tauro, Riana" <riana.tauro@intel.com>, "Wajdeczko, Michal"
 <michal.wajdeczko@intel.com>, "Roper, Matthew D" <matthew.d.roper@intel.com>, 
 "Koujalagi, Mallesh" <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v6 2/5] drm/ras: Introduce error threshold
Message-ID: <apG7Gx-GM-0mwOFu@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
 <20260818135304.497098-3-raag.jadav@intel.com>
 <IA1PR11MB7198552DE8DCE89CBE804A05A1AC2@IA1PR11MB7198.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB7198552DE8DCE89CBE804A05A1AC2@IA1PR11MB7198.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|BL3PR11MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: adbe96b6-3439-4c08-5a72-08df0523bfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: G+9r3D+j3bn8zn/NW50/HoFuXIZXTzsbscdLb5xj5nXo9swfHw8K05fq02mpLGF3pI1MREQn/p4PBcHe+HuQ4whx5aTRnzbTeJyzylr2GJKmdO/mioCmeN4mSPbMW9wvCEyYTHT0yztmgmydhMpDCHoxSJKMPLNbBzW0KcviUN3d4YNDToXEOJYMQIZneeoqcS1KEzh6mN9+sDreH7DuZhX52M7h600UDL6Ihnp3OYoSBX8LXBFVm813OeCWqN7FpWrP9r4PvsLudawYE3c/1RBxyve3NcbAfeoPA4gFZNkaHJ0kHPI28khHR2whqaPYdwYcTbdKafCUsPjNhSrkkQXOK1gVBb371z7KAJBDAR3RMYgHSkuoU7JcfdSF4PpmamTWFKAMqFDw06WquMsxQmnbDwhe07GtYDyDZ3xuEQx0amczYuJKJ0hzI08ftS2qeoBdILIhVQ+xNYQX8PXNQRA2oBuNuwtrC0H95uV3wPDOXAGrRO45m52/VtUxv4jfv/n0vF4OWhbTByyi714DH9gOKuTZinn/4UfhDs9kvcJn7/1BulBWtrZRjTWZOzlb5VUpLpZEwn/+U6q50hYeXK6Ah2Nn+/9bfuYpQUrZbyYUcN2yhYGxN6umXWr5Yw9UOFfNnH9ShMZkgv0rXupjj7brV/AUDxIw+lXBcBrJ5+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SsxEDLNzmCsZF7d84GnGPo1z2ffnO5A3AjLDDNQ10/Se5P39f8NyXNI5VoYF?=
 =?us-ascii?Q?Y7WYpQm+UByUq4yA2P3y3YEJE3l35o59HV3dCFvXCPwriyAQx99AUVWbnfk9?=
 =?us-ascii?Q?0TVc1cqZsaUxQoCw/FOkuv+f2q+cfux6GIPOPodEees6TTJe41ZxBVrmstyA?=
 =?us-ascii?Q?4ws6W5d7N5CCGreA5l5cfK64fNa5qmloTcTTnq6qVfGrdBaNTVMpLrtfEa1W?=
 =?us-ascii?Q?LFejXRAsii2l9iKOohl60IetpdG8RRYQAZh+fUuRWGxNCEdyKFdfYYj5skmD?=
 =?us-ascii?Q?x8PckmTw+dijYqXEC3IxrcbJO+EXeeHe0ACVbZ3SMJRRze3EQ2D8XbHTxEvq?=
 =?us-ascii?Q?U6lpceXS2/aJRj7xVeW+FAjWDYwbRDfINdypPR1P/yjJKazhoiMaML0w2PpQ?=
 =?us-ascii?Q?YeegN7mHlgi91ejytqV1YbaThHzknhqE5+3lgDv7/RNeQg/PHoyw5+LmTuE5?=
 =?us-ascii?Q?E7x5O7RDAEPm0Yx1LyK+LvySbshA/UPapv62VacKK1C8BhrlVcH6g/tw9+pz?=
 =?us-ascii?Q?DXiP2gHFVLhOtZABrQ3MlPsj7uYTKq1AJj3Hm4j9dGhzccRrLGHTNj+WIoke?=
 =?us-ascii?Q?vtLjmCEhEleCNDPhs53cOJ6qvMoenP3hEmq9JINGcpGTGoT9zuLAfGWum667?=
 =?us-ascii?Q?KYEX1BGYXW0I4lm+Rw0BHoiZVxrpV4r6mu1aK//rOGpNDyIG4BpAWRnK+faM?=
 =?us-ascii?Q?mFoXNeC+FRvCvvLBT2sacJYDOtiYtMsWdperkdePR16oqAl0SYfCtyaz4JpI?=
 =?us-ascii?Q?pQwjcXz1eQ9dqI+TYvUbTKwhaGwv2JTVQ2lSD/ZTrkTOleZ/O9Isk/us+pXK?=
 =?us-ascii?Q?4fjKeb3LKwuLgnmniOuAZyv2KBw5WvfGgLsfU9G7pv/1pL0VZATD9r3GB59u?=
 =?us-ascii?Q?8ggCevO+2qLQ7XJFw+yNLOwoYbTl18RK68XL1UrCnajyubGrZkXg8DJm5yqg?=
 =?us-ascii?Q?Ssx++zuDtXV3YlldqFt07BQO5GClbAP/n6sXlaskD5JiE+Xw2j9WH2TvvuMh?=
 =?us-ascii?Q?2iKeKhO0HSzK1sG3S8HLQveZlROCTuMim9puPG1h58i8yCTjHvN7p/SCPA+F?=
 =?us-ascii?Q?aqwWnSmTe97yXbDskph2Tbb1rMCRJAWcjzpqq/2gw+5x+GDwc/+BH7opkcby?=
 =?us-ascii?Q?ksktplvXGL8TYDeg5ZTl+NrOH75OAEO7tV5APL2ycecJICsF9YUwSwuTp/r4?=
 =?us-ascii?Q?XBytoIcACV2nyvRKUJhvm0wgXx9su4PHagT5GlXgUMG63gxKRMlJcMKLtoRW?=
 =?us-ascii?Q?D96k+rOlka7hUZiVKnblpe34OyL4Idx5p9Bmvi0RPvNAxht8dyCCU4Tp1ueF?=
 =?us-ascii?Q?6gzxx9V8K9UTJvxg9O9AzcZlkCcHTxf0bJrxFeayBMy46A7t3O0KDC4Hxk2e?=
 =?us-ascii?Q?tC5hA78/Ny9xa9KaIroHWW4fOMKm9yfrDRB04Jcx+Tu9sUH0R1WeOO3WW6bP?=
 =?us-ascii?Q?TfTnlKU8iJUXEI1uj0K4BB5bLk00rQSRbtHPu03gZnk0u73KRcUed12AUZdb?=
 =?us-ascii?Q?Fx/VEeSHZwAILM6n6r4WYnQGoSc44yMMbtYdqHZ58Pz7qUqIKI5ae35uwB+f?=
 =?us-ascii?Q?bJo/bXkPxAG4a7P9UWcsT4l9jHofpEAfXB5wsAJMSqskZYKpfAkcP6fclbEg?=
 =?us-ascii?Q?PrOoYl9hoiNCRx+DLi4TdiBoEA5QDxDdg6G9XcoOsaxsePF8W2/vdaeV53ML?=
 =?us-ascii?Q?iW8bz/QRQbIRvcWSBHF+A9LYXURRa9TZyiI76eHeoUyEytk1qyXfM1o4fumU?=
 =?us-ascii?Q?o7IMuCY09A=3D=3D?=
X-Exchange-RoutingPolicyChecked: UG+xl7pNBG0BoY+z/8T7ZCqaHX1cv+KRqD7XUhD/h+sJuRyJP13ibblVbKBlK20Af2EI+c1q2D3PwiyoWVIiOrXkjP81JhJqo9gxMpMlCP/X6vEmNO5mgIKjRiwQ1dzVxw6wQn/8B7lqtTVgPIBaubftDrHyki47hxkGptaPL5bd9wJIEVQTFS7ndZLh1JKgoKznR7G0De/v/664/xeZ95oSiS+PVeUf5DjWdIQ+wztEyXLYaHHgW+cMUOhxEIouC+n2bgxJy375oLIWMjInLI/OUqCFwNsbHIAlhiSYR19naDiGJ7RsSp7NRapYXx6gZBa2iKApF/vgo1GSRCyX4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: adbe96b6-3439-4c08-5a72-08df0523bfe9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:45:21.4480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4Xa4D8C6nTEPAgkc4V0z9XDstGPdpt5iy7mF2lKufBX/eMTN3jrvR0b4KSYBrmbUteSnUcOxzuqIdVzcXeg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
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

On Fri, Aug 28, 2026 at 09:40:38AM -0400, Ranjan, Joshua Santhosh wrote:
> > Add get-error-threshold and set-error-threshold command support which allows querying/setting error threshold of the counter. Threshold in RAS context means the number of errors the hardware is expected to accumulate before it raises them to software. This is to have a fine grained control over error notifications that are raised by the hardware.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> 
> Hi Raag,
> 
> The userspace consumer for this threshold UAPI is available here:
> 
> https://github.com/intel/compute-runtime/pull/978/
> 
> This has been validated with the Xe KMD.
> 
> Acked-by: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>

Thanks you so much for that.
I'm glad to see we are making progress on the right direction here.

It will still be a long journey until we consider this the right userspace
consumer, but I'm glad to see the progress towards that.

ynl continues to be the main and the generic consumer of the APIs, but
we could also add an IGT tool if needed.

Merged to drm-xe-next with offline ack from Maarten.

Thanks,
Rodrigo.

> 
> > ---
> > v2: Document threshold definition (Riana)
> >     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
> >     Cancel and free genlmsg on failure (Riana)
> >     Document threshold bounds checking responsibility (Riana)
> > v3: Move documentation from yaml to rst file (Riana)
> >     s/value/threshold (Riana)
> >     Use goto for error handling (Riana)
> > v4: Clarify 0 threshold expectations (Riana)
> >     Drop redundant wrapping (Riana)
> > v5: Drop redundant documentation (Riana)
> >     Aesthetic adjustment (Riana)
> > ---
> >  Documentation/gpu/drm-ras.rst            |  18 +++
> >  Documentation/netlink/specs/drm_ras.yaml |  32 +++++
> >  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
> >  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
> >  drivers/gpu/drm/drm_ras_nl.h             |   4 +
> >  include/drm/drm_ras.h                    |  29 +++++
> >  include/uapi/drm/drm_ras.h               |   3 +
> >  7 files changed, 271 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst index 406e4c49bac1..c4ce24067d4b 100644
> > --- a/Documentation/gpu/drm-ras.rst
> > +++ b/Documentation/gpu/drm-ras.rst
> > @@ -57,6 +57,10 @@ User space tools can:
> >  * Clear specific error counters with the ``clear-error-counter`` command, using both
> >    ``node-id`` and ``error-id`` as parameters.
> >  * Subscribe to the ``error-report`` multicast group to receive ``error-event``.
> > +* Query specific error counter threshold with the 
> > +``get-error-threshold`` command, using both
> > +  ``node-id`` and ``error-id`` as parameters.
> > +* Set specific error counter threshold with the ``set-error-threshold`` 
> > +command, using
> > +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
> >  
> >  YAML-based Interface
> >  --------------------
> > @@ -132,3 +136,17 @@ Example: Subscribe to ``error-report`` multicast group
> >              "error-value": 1
> >          }
> >      }
> > +
> > +Example: Query error threshold of a given counter
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> > +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> > +
> > +Example: Set error threshold of a given counter
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> > +    None
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 8aed3d4515e5..4c2ac9a1ba3f 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -69,6 +69,10 @@ attribute-sets:
> >          name: error-value
> >          type: u32
> >          doc: Current value of the requested error counter.
> > +      -
> > +        name: error-threshold
> > +        type: u32
> > +        doc: Error threshold of the counter.
> >    -
> >      name: error-event-attrs
> >      attributes:
> > @@ -167,6 +171,34 @@ operations:
> >            - error-id
> >            - error-name
> >            - error-value
> > +    -
> > +      name: get-error-threshold
> > +      doc: >-
> > +           Retrieve error threshold of a given counter.
> > +           The response includes the id, the name, and current threshold
> > +           of the counter.
> > +      attribute-set: error-counter-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes: *id-attrs
> > +        reply:
> > +          attributes:
> > +            - error-id
> > +            - error-name
> > +            - error-threshold
> > +    -
> > +      name: set-error-threshold
> > +      doc: >-
> > +           Set error threshold of a given counter.
> > +      attribute-set: error-counter-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +            - error-id
> > +            - error-threshold
> >  
> >  mcast-groups:
> >    list:
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c index 4fa1a257b0ed..b099eb67836e 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -46,6 +46,13 @@
> >   * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
> >   *    and error information that triggered the event.
> >   *
> > + * 6. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> > + *    Userspace must provide Node ID and Error ID.
> > + *    Returns the error threshold of a specific counter.
> > + *
> > + * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> > + *    Userspace must provide Node ID, Error ID and threshold to be set.
> > + *
> >   * Node registration:
> >   *
> >   * - drm_ras_node_register(): Registers a new node and assigns @@ -66,6 +73,13 @@
> >   *     + The error counters in the driver doesn't need to be contiguous, but the
> >   *       driver must return -ENOENT to the query_error_counter as an indication
> >   *       that the ID should be skipped and not listed in the netlink API.
> > + *     + The driver can optionally implement query_error_threshold() and
> > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > + *       threshold of the counter. Threshold in RAS context means the number of
> > + *       errors the hardware is expected to accumulate before it raises them to
> > + *       software. This is to have a fine grained control over error notifications
> > + *       that are raised by the hardware.
> > + *     + The driver is responsible for error threshold bounds checking.
> >   *
> >   * Netlink handlers:
> >   *
> > @@ -77,6 +91,10 @@
> >   *   operation, fetching a counter value from a specific node.
> >   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> >   *   operation, clearing a counter value from a specific node.
> > + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> > + *   operation, fetching the error threshold of a specific counter.
> > + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> > + *   operation, setting the error threshold of a specific counter.
> >   */
> >  
> >  static DEFINE_XARRAY_ALLOC(drm_ras_xa); @@ -173,6 +191,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
> >  	return node->query_error_counter(node, error_id, name, value);  }
> >  
> > +static int get_node_error_threshold(u32 node_id, u32 error_id, const 
> > +char **name, u32 *threshold) {
> > +	struct drm_ras_node *node;
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	if (!node->query_error_threshold)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > +		return -EINVAL;
> > +
> > +	return node->query_error_threshold(node, error_id, name, threshold); }
> > +
> > +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 
> > +threshold) {
> > +	struct drm_ras_node *node;
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	if (!node->set_error_threshold)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > +		return -EINVAL;
> > +
> > +	return node->set_error_threshold(node, error_id, threshold); }
> > +
> >  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> >  			   const char *error_name, u32 value)  { @@ -219,6 +271,22 @@ static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *n
> >  	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);  }
> >  
> > +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> > +			       u32 threshold)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, 
> > +threshold); }
> > +
> >  static int doit_reply_value(struct genl_info *info, u32 node_id,
> >  			    u32 error_id)
> >  {
> > @@ -258,6 +326,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> >  	return ret;
> >  }
> >  
> > +static int doit_reply_threshold(struct genl_info *info, u32 node_id, 
> > +u32 error_id) {
> > +	const char *error_name;
> > +	struct sk_buff *msg;
> > +	struct nlattr *hdr;
> > +	u32 threshold;
> > +	int ret;
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr) {
> > +		ret = -EMSGSIZE;
> > +		goto free_msg;
> > +	}
> > +
> > +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	genlmsg_end(msg, hdr);
> > +
> > +	return genlmsg_reply(msg, info);
> > +
> > +cancel_msg:
> > +	genlmsg_cancel(msg, hdr);
> > +free_msg:
> > +	nlmsg_free(msg);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * drm_ras_nl_error_event() - Report an error event
> >   * @node: Node structure
> > @@ -459,6 +564,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >  	return node->clear_error_counter(node, error_id);  }
> >  
> > +/**
> > + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a 
> > +counter
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Extracts the Node ID and Error ID from the netlink attributes and 
> > +retrieves
> > + * the error threshold of the corresponding counter. Sends the result 
> > +back to
> > + * the requesting user via the standard Genl reply.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct 
> > +genl_info *info) {
> > +	u32 node_id, error_id;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > +	error_id = 
> > +nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > +
> > +	return doit_reply_threshold(info, node_id, error_id); }
> > +
> > +/**
> > + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a 
> > +counter
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Extracts the Node ID, Error ID and threshold from the netlink 
> > +attributes and
> > + * sets the error threshold of the corresponding counter.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct 
> > +genl_info *info) {
> > +	u32 node_id, error_id, threshold;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > +	threshold = 
> > +nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD])
> > +;
> > +
> > +	return set_node_error_threshold(node_id, error_id, threshold); }
> > +
> >  /**
> >   * drm_ras_node_register() - Register a new RAS node
> >   * @node: Node structure to register
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c index 9d3123cc9f9c..c9f5e0ceb3b5 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
> >  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },  };
> >  
> > +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */ static const struct 
> > +nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, }, };
> > +
> > +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */ static const struct 
> > +nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, 
> > +}, };
> > +
> >  /* Ops table for drm_ras */
> >  static const struct genl_split_ops drm_ras_nl_ops[] = {
> >  	{
> > @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> >  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> >  	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > +		.doit		= drm_ras_nl_get_error_threshold_doit,
> > +		.policy		= drm_ras_get_error_threshold_nl_policy,
> > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > +		.doit		= drm_ras_nl_set_error_threshold_doit,
> > +		.policy		= drm_ras_set_error_threshold_nl_policy,
> > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> >  };
> >  
> >  static const struct genl_multicast_group drm_ras_nl_mcgrps[] = { diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h index 03ec275aca92..9aef097ea10f 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >  					struct netlink_callback *cb);
> >  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >  					struct genl_info *info);
> > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > +					struct genl_info *info);
> > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> > +					struct genl_info *info);
> >  
> >  enum {
> >  	DRM_RAS_NLGRP_ERROR_REPORT,
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h index ee2caa0edc6f..1765a3130b09 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -71,6 +71,35 @@ struct drm_ras_node {
> >  	 */
> >  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> >  
> > +	/**
> > +	 * @query_error_threshold:
> > +	 *
> > +	 * This callback is used by drm-ras to query error threshold of a
> > +	 * specific counter.
> > +	 *
> > +	 * Driver should expect query_error_threshold() to be called with
> > +	 * error_id from `error_counter_range.first` to
> > +	 * `error_counter_range.last`.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > +				     u32 *threshold);
> > +
> > +	/**
> > +	 * @set_error_threshold:
> > +	 *
> > +	 * This callback is used by drm-ras to set error threshold of a specific
> > +	 * counter.
> > +	 *
> > +	 * Driver should expect set_error_threshold() to be called with error_id
> > +	 * from `error_counter_range.first` to `error_counter_range.last`.
> > +	 * Driver is responsible for error threshold bounds checking.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, 
> > +u32 threshold);
> > +
> >  	/** @priv: Driver private data */
> >  	void *priv;
> >  };
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h index eab8231aa87c..2f832275ee6e 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -33,6 +33,7 @@ enum {
> >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> > +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> >  
> >  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
> >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1) @@ -55,6 +56,8 @@ enum {
> >  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> >  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> >  	DRM_RAS_CMD_ERROR_EVENT,
> > +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> >  
> >  	__DRM_RAS_CMD_MAX,
> >  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> > --
> > 2.43.0
