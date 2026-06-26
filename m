Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88CDCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCAA10F4F0;
	Fri, 26 Jun 2026 08:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T1qWJNVn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D673510F4EF;
 Fri, 26 Jun 2026 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782462581; x=1813998581;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nJlh0lNEcy6K7MjtYIpEUTQOI/Qx/BeZahNGNxYK0LE=;
 b=T1qWJNVnmzz33kZx9t2w58fKmpKV8C3YLaCJf8lUajQrTj4S1uPc7MJC
 8it1SsAVn/3De84kqRnvlWrdM2BsvrS3uo67TFkmk0Gw4WAdX/6WG81QY
 NcbBNHUsgyiDR9wuAumSNL5DCcVMkiewkElZBkGUgDoJKcd6eY+NDklr1
 0SvF1IrijaFXkhPFNDlYFE8cx4Cr2viPbhev3LtDcmYcFyo1M08CkMJ4d
 bhDFpjhNKvXEKkz3oX960rOX4trzPdSVxeFHP+PbrHxS85GEnYEEtVSff
 L9Lhzyj4xCi6I7Ab/QWdVoSXIlQzOQeu2X3nwwBFS7gaa4g04HPCIhf/8 w==;
X-CSE-ConnectionGUID: KciqnsoBQYKudnVCdLqxbw==
X-CSE-MsgGUID: 1RR1pU8jSmSe00uPf5W7Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="82247215"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="82247215"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:29:40 -0700
X-CSE-ConnectionGUID: W6PdAB42QC261HFn6S6LyQ==
X-CSE-MsgGUID: CeSh5iGTQWGcneg2zxv2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="247907196"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:29:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:29:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:29:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It02gg0nSFa7WwKq2QF5MdnWZHYvJpSh5HkGGe226fZvAmIMkswVokmO6QVTA+QcbHBsfwqxeJUvG/oQE+uSCplIBKE9UK95bmaMg+boO6/1AkrfhWCz3skrROIMJfMG6O0fcfztk3TcvlzzIBijp8SggnCyf2hdtXan7sqEORgEboPuaZXw0grgOunlWID/bcfLUfMS0bMScl0i4PJ8wtXkh+noUXsLSUox5osu+nJ34Qj5iQtEbFk38ZCP9RcFf1LnlxCNMDMjRVuqo+K2Bklg/sm6rcvEtdq/+CIdx20tCllo/CPEMpR1eESigok7Ym+knQ8r4kEMceTteh6tOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gREKtPtv1P4JwffLMulnKCFm8ajuu4D749mlP74Xkm4=;
 b=drNhoIzWOUZoyDirxLv44vKDGb/gzsFNw+8vL8NxgridgppvKd+KbGqM9eaZgFv4kw5oTwa9w2ZWqjw4bxOfM9HIPI6G84TcNQ2HXj4kZIr7rKB9lSGJ/0+ZbhQFh6F5a2bwrqGwVM5PCT1PmrcQI12ZkxpwYg9xYZDX3ZrqANAP5+AaTtEjUyAxaNY17xKPs5FTTgf2eAsjPs1gTodWEflRvUnPrgoRFWObqutL2PoVEZ6jIqiirfMJ6KKpZe5IOmHO28EmU2yg5o6vYa2dNkID12pAGPRiEGaA/VKwIpOjI+W/44IB+QJX3JHabUnBdH9OltyZX5nsizKFPzMCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:29:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:29:05 +0000
Date: Fri, 26 Jun 2026 01:29:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: Re: [PATCH v3 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Message-ID: <aj44TkLKQIqrY9S9@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618080902.1527255-1-honglei1.huang@amd.com>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b30e72-7cb1-47bb-dbcb-08ded35cfbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|22122799003|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: vOJGgkpII91cawtTZ06QYimpcQdmloHFKhzD0PD0rLyqSYfIowNAtOzQuaS0Y/z82ROwpQvC13LxCyoO3w0gBrefxG9XGGP4vToHeOZ7WeMStEzWhIm9LXm+IKCqeuDVFqKKgTcIID7GOTlK5ZKAQ21YNZL0t+3XO48ig2i2kRg8jNb9XFBfusOogi3v3jGSZMwv7M7Ho3N930xZGB0QkHqad5Sf2iTP6opwurAK7tkBBGwfsFEV0SU6VJKCP7C2MzsZ6IUj7WHhGTkmyFHz/8VQzzlcxKUXbyWI8xXjAlcuMlXQqfkfyiV9AVZIUhsbGXSvGCWhy99NVYOl7+uJgaxulYWFJZD+jCoXN5T69wYiHz3m+k615dqreCcMFBdwwjgSfQzwJC21z4Au0c8t1tN7/YczFfuauNZcv0Q+aeIxYX+BvxkewfTjaLce1PDrWtHdtH+v1X8cOuqJrg3PIDMBPp/K4kMEnKWoL3fIH7i+7oh1B4WK6N5qHskOdQSMqIVRIb6NpnVj+aZ/lYirKbrmcYFAMQFcieJIwyQ9dJWImpxT3U3RwN5GMjCiMblUBAnmy0C3NV9/NWmv7ZGGTMsm8aegk7CLxjhVHUSmS8hWZ8QX80ur4q4i9NQ/eKet
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(22122799003)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFSTGJiWjVjVWNoMUhlRkxTZUZJVDhKY0pMRVluQndGWFRwelFGMHJtOWZa?=
 =?utf-8?B?REJLNDBEM2Nua0dJemVqQyt5YkxCUmdIUTQ0a2wrand2UGFPQmhpaEpiQ1Rp?=
 =?utf-8?B?VmdENHZNb2VPb1NtdzVaVERUaU1PNDdzb2NQQk41dXd6Mzk5WmhkazRaTXdo?=
 =?utf-8?B?b0UrSW4vSWhMaVpNb0FPS2ppS2dkcS9ya3Vic0VWVEdJYWh0SWdzaFMzUnJU?=
 =?utf-8?B?RFZJSlUxV09TMHBrQWlLa1JyWjE0bmlURmJDeHZYcU5ITWlXR2RBY2tYdnNF?=
 =?utf-8?B?SWxiZlJwbXg4cHUwbWZXakg1OGQ0dUpYQ0ZKUFlpK1VhaG03VTkzRWF6VGlO?=
 =?utf-8?B?Y2pWdllEb0xwZ1ZHWWNNaGQxWlVvemgvVzJiVUtuWmZNVS9aVy80dVh2MVVz?=
 =?utf-8?B?N01vVUlUQ2dsSzl4OC9seGc3dFhmbnBUY0RBdUxHUEgwVnphSmZEd2dpQm1x?=
 =?utf-8?B?TXU5bGlPWE4zRE5pb3NzbEZLeGJic3RvVHhMRVdIWUFyYmdLVUJwdGlFVU9L?=
 =?utf-8?B?eXB5d2lkWmtJWFRCSW5CK1dKb2I3M2M4SE9sWVdGUnQyaU9BWXdDYUpxZUF4?=
 =?utf-8?B?emJwL0VzQzdGaFRDUytjS1g5WFJmd05QbUpDQnI3MWxQN3MyS2JRU3ltOU1B?=
 =?utf-8?B?aEtuQVFDMzJTY2cyOGE3TlBPZWRvTytZRks0L0dhbFlPK0xkQWxIeWhFdjAw?=
 =?utf-8?B?UitXcEdZc05nSW45QlRLeDlVRTZOandNbGFHbHY4Qk45bHduMXhTeXNnNndt?=
 =?utf-8?B?TFVlRlJFNyt5Q1g1aUFEcGwwLy85OWFwRTJqeXEySHhCQ2RYTG1JRkNoakJo?=
 =?utf-8?B?MjNpUU1HOFVTYm5ZNm9nL1BBSTJ1Ti9XcVFEbllZamhQUldwNEFoQTN3ZG5Q?=
 =?utf-8?B?VFZqNWFyQXA3RlR6NVpTazV1RzI2MVRBTE4xdW03TVJURnNTVFFIRmtwRnBj?=
 =?utf-8?B?dXZoeUNEM3VJMVNNY05MZFgwSmRyeEdLS3dFSWpwMUkyVndEaWRjbmRiWGRZ?=
 =?utf-8?B?dXE2dUptbjhiYUh3NmpqcU9iTUlLZU1DNGRCMHRmWGh2NmFDZGpnTTk4WDVS?=
 =?utf-8?B?bWpCdUhrbjdlYU5OMnE3dnJFOGpKSWZpcDZBM3g5bzdIdUJYL0I5cjVON3ZZ?=
 =?utf-8?B?MVd0Vm1CSExwRUcxRkhJZFBsM0o0ZTRRajZTOWthREZJVG1temEyVHo5NTNV?=
 =?utf-8?B?U1FsL3RUWXpsZGNTbEdiSEVnUW9samFxQ3ZVR25ORlJORUdVUVIvN0dWSElK?=
 =?utf-8?B?ZFFzVmxNZFNUR2xFeTRPcG81aTdRTDVZbzNBRGFFdnhmL1l5V2NzYTJOMWNu?=
 =?utf-8?B?WU5xa01wUk1tMVdrNUVqSXFUZVFPdHBWSEI3NUNheStnNVJqWEZHMFRvVDV5?=
 =?utf-8?B?VW41Wmt4UGVZNFFMMUR6VXhUN29acE1BS3EwdWZJV3Nvait0a2lMNmlXTzRR?=
 =?utf-8?B?R3VUc245UEE3VnFGbnRPOGZNbnFGaklUZU10L1BSOXNHbThUZFdCUllERUVG?=
 =?utf-8?B?Rk1OcEVqd2Rzd1IxWXJYTlkycjRJS3VENGdVSXpkbXdpQTRHTmcvZHF3bEI1?=
 =?utf-8?B?Qy9JaFZXakUvVXd4WjJUbjV4WjJLRUJMbjFuODczZGRwWDUzVnpWQnFKWnJ3?=
 =?utf-8?B?RXJDSWdwL01Dc2hTSlZxc3dBOXZIY1IzaDMxNTBUYTM4dklBeUJPa1MzVzdV?=
 =?utf-8?B?N05GZ29NVFNXZE50d1VIb1pPcjhzdENaTHoweTlpb05IdnpiS0FkK21veXJS?=
 =?utf-8?B?dnlFcEx5MlEwYlkzWlVRY1JINWRxbEQ0eUtsQnZZNkpFS3ZoN3BrWmpGL2Q2?=
 =?utf-8?B?V1JBalpFZFNibWxLQngrcTRlamt1TUMxbFlWOEs0VGhMNktYQlYxejZvZlhV?=
 =?utf-8?B?cGllaExzQzZFQXZEZTRYbmxROXJzL0E0NlFqVndBVTJ5VjRWWGd4Y3dqRnVr?=
 =?utf-8?B?YTZtaFBGRVBHVWNESitVY2Y4V3pGTGNtUCs1UC9XakN3TUJVd3Q4Smp4QlJq?=
 =?utf-8?B?a1BIYWRZSFZHSktsYUUrbFZpL3F1UEYrNXN4WW8yN29Lc3pjQ1pXd2VRZWUr?=
 =?utf-8?B?TlFocStZWkJJWllNVkZRUGNBUEJPRkQ5WVErNzRaak5vOVhIZ0lJMkY5SFp2?=
 =?utf-8?B?WVVzdG5PYVRjakhxNEgrRHJWL3BoaGxzMExsRjI3MEhtWi81KytXa3hEaVg2?=
 =?utf-8?B?THMzeFltLzhoZUxrakFqYXZVRjNHSHNYSm1vcnptenkxcEYrV05Ia05QSGtr?=
 =?utf-8?B?OExyK2YwcWhHS2QrWEhRRDVDYWROSW1UOGhJK2NRVmtJL09taVY4QWs4bGl6?=
 =?utf-8?B?TzFHcHBSb2FncTVmWXNjU1dDVkdLcU9MZjZ2Rk9QdFBWOFdreHBqZz09?=
X-Exchange-RoutingPolicyChecked: TLZaQW8qjMJ94Gj34n+cdSrqJLVIZIvR8ppzsTYY265BgCvafwq7+XPoBG0NTSuZ7reawtzOFrNZT0eX8mNxO8F0bHWGRegPs9ZK5BjJBKM5+PSYAHsZzqWf5AbtT5bjKnEwuX6uf/MBDWM/MZc8/YG8GzJhqKr4YTS/AqsW3goHwA76quQHvkaQmC8e3QDD3Fw8X7kMgH+oy7cwE5Ead3/+RwoMMxHg59HRZPmhy1Eg+XlpF06jBppVhI+uthwKsFmq5BUHBfj1g2UAY2sNopDLCJBVz2S8xZptcuMjQH7HwPithz+PXSKOXLDnS4+fh2SVrMNIn9COpn1v/SBTcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b30e72-7cb1-47bb-dbcb-08ded35cfbf5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:29:05.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km+V0L3enJEspfU6Tz3Rt5ngM+d4rgOStwfSpx9QEYpoGX4N50WwqIBXTQeBOoTGyp+nvZHPoJ1rXVM8tvzrXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
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

On Thu, Jun 18, 2026 at 04:08:57PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> The intent of this series is to make drm_gpusvm more flexible and give
> drivers more freedom over how they assemble the MM related and device
> side operations. It implements the direction Matt suggested in [1]:
> Mirror MR in gitlab: [4]
> 
>   - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>   - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
>     DMA through it.
>   - Drop struct drm_device from struct drm_gpusvm.
>   - Have the driver's range structure embed one or more struct
>     drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>   - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
>     drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
>     drivers to use the drm_gpusvm_pages helpers instead.
> 
> In essence the series does only two abstractions, plus the xe
> adaptation that follows from them:
> 
>   - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>     drm_gpusvm_pages (device physical related), so the two sides can
>     have independent lifetimes and ownership.
>   - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>     the device side down onto drm_gpusvm_pages, which is where DMA
>     actually happens.
>   - xe is updated to fit the modifications, no functional change
>     intended.
> 
> V3:
>   - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
>     ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
>   - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
>     pages[i].flags.__flags word to pair with the lockless READ_ONCE()
>     readers and avoid a data race.
>   - xe_userptr_setup(): call drm_gpusvm_init_pages() before
>     mmu_interval_notifier_insert() to avoid exposing uninitialized
>     pages.drm to invalidation callbacks.
>   - Fix per commit build of the set_unmapped() pages.
> 
> V2:
>   - Followed in Matt's v0 review fixups [2]:
>      - keep unmapped flag in pages structures.
>      - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
>        unmapped flag, so the framework can check unmapped status in
>        drm_gpusvm_get_pages().
>   - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
>   - Remove drm_device from drm_gpusvm_get_pages() parameters.
>   - Reworked the DOC: overview and usage examples to describe the new
>     model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
>     examples that operate on a driver embedded pages object by the
>     drm_gpusvm_pages helpers and etc.
>   - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
>   - Dropped RFC.
> 
> Follow-up (not in this series):
> 
>   - modify drm_gpusvm_get_pages() to support one time hmm range fault
>     and multi drm device dma mapping.
>   - Add no dma device support for drm_gpusvm_get_pages().
> 
> tests:
> AMDGPU:
>   based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
>   1:n is on going needs many modifications and testings.
> 
>   Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>   - KFD test: 95%+ passed.
>   - ROCR test: all passed.
>   - HIP catch test: gfx943 (MI300X): 99% passed.
>                     gfx906 (MI60): 99% passed.
> INTEL XE:
>   Waiting for the xe driver git lab CI result: [4]

Sending to the Xe list (intel-xe@lists.freedesktop.org) is enough to
trigger CI, and the results will appear in the Patchwork link [5].
However, I am not seeing this series there, even though Xe was CC’d.

Perhaps the patch must be sent *to* the list, rather than just CC’d, to
trigger CI?

Anyways, I think you will need one more spin here, so hopefully you get
results in the next rev and then it will be good to merge. If not for
some reason I'll apply the patches and give it a quick test run.

Mastt

[5] https://patchwork.freedesktop.org/project/intel-xe/series/?ordering=-last_updated

> 
> links:
> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
> [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
> 
> Honglei Huang (5):
>   drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>   drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>   drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>   drm/gpusvm: move struct drm_gpusvm_pages out of struct
>     drm_gpusvm_range
>   drm/gpusvm: let the drm_gpusvm core context purely MM level
> 
>  drivers/gpu/drm/drm_gpusvm.c    | 230 ++++++++++++++++++--------------
>  drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>  drivers/gpu/drm/xe/xe_svm.c     |  37 +++--
>  drivers/gpu/drm/xe/xe_svm.h     |   8 +-
>  drivers/gpu/drm/xe/xe_userptr.c |   5 +-
>  include/drm/drm_gpusvm.h        |  66 ++++++---
>  6 files changed, 209 insertions(+), 139 deletions(-)
> 
> 
> base-commit: b9297d19d9df5d4b6c994648570c5dcd1cac68ff
> -- 
> 2.34.1
> 
