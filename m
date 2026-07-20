Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390CDC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 04:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CCE10E645;
	Mon, 20 Jul 2026 04:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R53fgp00";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CCD10E11E;
 Mon, 20 Jul 2026 04:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784521751; x=1816057751;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0XyyaWFlLkSrAMWCU2grcixS6ze5w/elrG+soR2dQpM=;
 b=R53fgp00ARUOBKFoIA+u8MTcjt+rSIxIwYN3LvZrYvODSnSjNgIzJV3r
 Xcz2cpooHjIdUKHSOVGFrTljlsetGKg60mIx3Id9QGHPKMBhFVomFf3rV
 OU69JJuehZ5wQMBbaVUEvfIzASdUG3tvZcZZHarLlvr2B6aalp0DW5KjV
 aVnYJQLLNk+wXLDcQgpTfhdAkRVzwDJnXLtMTnwo07pGh/63FZ66cgKy0
 NWYgr+j5HC+rPhDDLgkcl0kGzx2QFkQYjj7b4aNulgH9Wmk7pGa5MJjr+
 9q61aNqQUJ7sQapqYgMtLR2OSRT9Pcc7CXNtDMUaXDN4pUnCwthZaPDgy g==;
X-CSE-ConnectionGUID: CU05Q8OwTdSPWTMNyyQzWg==
X-CSE-MsgGUID: fckrK05DQlqwAQPjWxZiTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="72631402"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="72631402"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 21:29:11 -0700
X-CSE-ConnectionGUID: 4g1y8W0rS1KxqN4wF4dY4A==
X-CSE-MsgGUID: CENADFPRTeKhIBDY13v9FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="281813110"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 21:29:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 21:29:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 21:29:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 21:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxNEEhinUvGV/0qKv7Mae/E6j1bxASFVkgQOfnis3jLb3nkEhFw8g6xlHMlRWG7K45G5i1hWQhGioOCzzwE4QOEzM/+Qb8+rrbXcTgdurPGU+ZFXnbMoHNHM2LEGA47DHOU8CRxjVvej3ffsm5D5T6nbBpNPcjC5GOCqguj4PFNKwyeJcrl1XNerdjxLn6sSafu3ppMgJSmd2Ww17XR6tVfyttNxSn0NiEe2AVr7s6xbsPD7UpP43e+e622tTu7+EDSg+LgXpAMRMnlRrfTsiaoICvwSyJmnFeMDTQLVXUJT5GZa9hW0MuZqawxl7uZjgh34MWV90464oQpLXBMjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peVEnjCErokcXDGAFdrcd/echxNVhqRIdHUL0ZtP+K0=;
 b=XEPGpn22Jj2UkJ/jGHmkpgcHpqVCDGqzVlyRd1E74q878vBXuUxiKSjk6Ok0K1VmBvO5yWha30MpuK7sIgQaP48wuQow5BQuXRvRd6Jc4mSt/3yZ1Gd0raybp5VY7ciN5+Msi00+VzHQD0BirDXm5cnNqJ6/0ta7o4ICsSQMmO4GorIt4e8YFeGkqGF7NhDG6AB0uoBYl+LLhG34dIv3UljBiQJd7xtdpc3acMbs91QBr1Gz56Dw7jN4iS84rWe8o5vyMRFHjg9UO29SufHLrep1ZT2EbDmjI5IjB6Wd14cFrRLrwVTMAKA7ewBbTTe6CYfN5kySNcZhMm84qQpDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 04:29:07 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 04:29:07 +0000
Date: Sun, 19 Jul 2026 21:29:04 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Michal Mrozek <michal.mrozek@intel.com>, 
 John Falkowski <john.falkowski@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, LMKL <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/xe: Add watch_queue-based device event
 notification
Message-ID: <al2kEOXTybHlMhuR@gsse-cloud1.jf.intel.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
 <20260612135340.116100-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612135340.116100-5-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 943e72d6-593d-4c26-4b5a-08dee6176ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: LBQtHGtYbZh36o6C4z09QPp9tTWYVyUn7iT+F1wVNFzw6nQz2uhYqtHrTAGW3ANeTLq7/tAiG+5tehKcmQuNBzW0tbTHNugLaOke1pbskCUPxXRK33ql4L6Mh03B+CAVtw4FmzVJ4GBIN6xEswpGp/ukPhPa78dRIT4APPBIiLoFXOwFuHfNE15+ac3xsduJn9t5vIW9qsRDJ+D1XrHJJtXJunCqKLahAT+0RrMveB0AYb1BPf3kD4JGpqpVaaw+SAlM6vA2rXElncoXGpkv97xlGTiWcVeHaPPL+P021USXsQpgoW0dPMyj0tCPRZtK6ks5ohm1xquzzrDvDBG1d36yU56KCAbe7AOESilvRYHabmixhyQjr+ebPcCawubjKP7+L4tTtHnCA82+d8X+CNQ5sBx3vxFdpM1bKw7tH3lV8YDjxDkTTFHfbA7KRh8bz17l4+1b0NlZdRto+IUsTkaVK1lmB+gMyymXldEByF058s4bwaVjXfCHpQGgNLJSoVy/8kFljnPhdDG76eUr+yd9IB/cS0ISjC6C+PnJUgNNftiJR/1fREgEf81IRZOWEHaopE1g0eeiFsmTej20Lf8aiKrrzUbvo/SS2nqoPWRbscQggAXwkUmdPSLYedUhdYXT4xXKjLvOtTLzfbenrHy0Nu/lOsbu0Re7aWygIwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3YzanlsYkNhQy9zTXJ2WVBna0EyVEh6MXhJTXpvTGJqY1ZoMW9SeWRENXV2?=
 =?utf-8?B?WHNmTDkwNWd2QWRHeFVUTlgwZnFRRGtzc1hMSk9peW00c21xQXBlcHBUcldw?=
 =?utf-8?B?QTV6RHUxbmZyWmRXMlRMOERoaWVpY25ueDU1TXk2Qzc5QnplclhQdExqTHY1?=
 =?utf-8?B?R2xQTHRQZEFtZVREOG03SWlwYkFOYXRJWmIvYnZtMWJSTU16WVFyVXJsdVdl?=
 =?utf-8?B?T0lTMmJCY3pQRkttTDNjVWQ5aTg0MkM4cjJuWng3OHNnYXBVNkxoNW5YSU1j?=
 =?utf-8?B?ZHZ3Q1N4bmtYMU5ROWQrbWV0d0lrWnFVWkRXWmNzY2FVWkVuL0VOd3Q2THMv?=
 =?utf-8?B?cTE0bXo4amwxVTFXN1lBcS9FNG9NSmxxQSs0eStDNHo0TEQ5R29DNUF6dm5N?=
 =?utf-8?B?YnRwMi9vTzBNWkF1eG8yMjBKU3lMdStkcFd2ZGhFV0ZnZXZNb3Nna3dkUU1j?=
 =?utf-8?B?Wk9jT2FHR2o0UXBSeXA2RzZuQk81ekk3QmFhbWNyN284dDdPelZuRUxEbHE0?=
 =?utf-8?B?NG5Yc3dhQ1dBYXRuTVBiVENrNjVtNEUzdThFWlNhZnphNWxyczhUSC9wckdn?=
 =?utf-8?B?ZnBPcHd4ZG5lTHZmZm9WSnlIWm1IZ1VjWERzdWxpNDVVME9Bcmc0NkxnWjRO?=
 =?utf-8?B?d0cyMlBFVGd3QjkxNVl6OFJxV3daM01vb3NQdGJWa1V6TTl3S3A1K0tmejhH?=
 =?utf-8?B?UE5PN0JYWTZXc3lOa2VMaWRRaXhVcUl3bXRXQ0ZIVGhVYzhOS0NnSUl4ZTNx?=
 =?utf-8?B?Q3cvS2NyRStyTFd3dUNud0UzeWFxV0tRR1FsT1ErRmViRHVlbUNWVWltdTJH?=
 =?utf-8?B?U1hlaUxURWJISHo5YUswMUpvU3dMQ0lKYjlkSDdQcWt4TW1wK0pnK29vSllS?=
 =?utf-8?B?enJ4cTAwdSsvNlVCVGJkRG9lUnZDWFpzTDhOMnVEckZaajRGbHk3K3M4M3lP?=
 =?utf-8?B?bS9nQ09BZFNOTTN5bXdPZ3ZzL2E1U3pKTkdtdnJDU1hFWmNrRm5RakxJWEdi?=
 =?utf-8?B?Rjl3RHdVK0V2WEdwN3ZwbTBRV2JTaGRTTG9WY3Vrbk1NTmw3NEVVUWlPeWlS?=
 =?utf-8?B?RVFUZkpaOXZnNTNmTEdmay9EcW5EdlFZMkRkZEVMR1duTTdpdEU5SFl1Yk5Q?=
 =?utf-8?B?Rkd6VEpkcFlnZCtCUDRTVEljcndTRitJQ3U1RC84MGJmTjZMb0habXMvRC9z?=
 =?utf-8?B?Q0V5SmRBWVdqSysybE14ZEZhR1ZmQ3lNL3ZMV3ZNaTRpMi9MczJOM3dyZTZ0?=
 =?utf-8?B?aDlXY1VTcWZaK2hycHkwL2ZZQXZxMjM1Y2hzY1FmRHk3bWRwVkg4WlFvKzZs?=
 =?utf-8?B?N3dxUmNiVmJERElNS0FRN2Q1QTYrZFFoV1VYWk1sVW5VSnNhc0JlY0xRSEtk?=
 =?utf-8?B?TmpSUE1JdWV5TVh5ek5Eb3ZGQmNiSWVja2hySHRRdGg3ZERHZGx3SUJMNzls?=
 =?utf-8?B?Mm4zbVZCTGxaRFJVWGN3d1hyZUdjS2dBUkd3M1RhVElWU3k1cVFEenAwaFlj?=
 =?utf-8?B?S3JLdmZrMVJpTW5abXRPaXZFTmxLR0MxRjhZL1RrRjlLUGI2cVZVWG9QaHUx?=
 =?utf-8?B?ZWplZGR3RkZLaURCdXFBZldHM1AyYzZYZ0JGT1A4ZTNOZnE0UGtoNVRMYTNr?=
 =?utf-8?B?M1g3WUxJSnJXRjRUVUdIMnBVZzB4VThPQm4rWmtHcDZoRzZjUkJWNmdOaWtH?=
 =?utf-8?B?NUFKUWJnOFBMWHkrRGFmL0JTRWd2YldxWlBKcjhRaVQ1Z0xTSSsrdDZNbG9E?=
 =?utf-8?B?NGpOQWdtTWV6WkxybnlRZkVIdFlLUlVWYitBVUFLblpuZzdxVkhhc1VVd1dG?=
 =?utf-8?B?VE51UjlrQk4zZEw0OEY5ZUNZRHROVnhUYmFpK0x4WjdGWDVEMjJDNDhwSXpW?=
 =?utf-8?B?V3ZJYTh4RVFZWjRRMERsbW1QMkZnNWZXSXY0TU55VUJIMGFWb1ByWVFMNFNk?=
 =?utf-8?B?KzUyMVJXbUx5c2k4ZENDTHF2WlZnemI5bnV5WGEzM2pMSjFUUWdPUEtKM3pF?=
 =?utf-8?B?V0ZEdHhYeVI4cnFrN1Y0ZEVhUUtraDN4b3BmTkZBQUZYODV6SGxoWGs2NHNx?=
 =?utf-8?B?dHVjOXl0RWw1R3k4cTdkampRZEF3R1N0bndvaGNSc0xSYlJRSSt2YXhjUFBR?=
 =?utf-8?B?ZlZzb1Zaa0IzdVJxdEI0V0FaT3NwTHlzVEdjSjg1WjJhZ3ZGakIzdW96cnhK?=
 =?utf-8?B?UW5iYVJ3UnVEME0vSU5HSTdTbXR3SGxTK25FT09Xbk5kUHAxU1UxV1Bzb082?=
 =?utf-8?B?NkNKaWw0MWJwRGhpZFRhQXVnL3pYTnAxenNDUEhvZDlhS2tkTHVES1hXY2ZX?=
 =?utf-8?B?OS9PalhxQ2x5YkZNUWlBa05LZ0FkUGszZkxOVnl5VkV6eFo3eTJ2QT09?=
X-Exchange-RoutingPolicyChecked: Ejca6cesFAojiqNjU7GNP1OnWazdkwH8glJ0dy/5jLnqRFlEta1bN4F4yV1O7rXTiY3GQD9/nrF9LhrS64YkeZJ4p09Xhl91/BABEiXO+MyXncH2kF7a6FzNiBPMSg2EMYGLM/J0bw6dp4vQssbv4fTdHa+GvW6c2nwHgWAoNrZ0u4fuCAKs3rkT0RwSd/8XVX8UpAHKMAu1IlL6v6qajOujKRfMuwv6jVL5HNW2EG6vRuDYQB0lZVCNQ81ouLal4ABMWj16xPGT47EEdpNZT1yO7QlvLY3TygVdgfuTWIvzaCulEPOytNyHX96CIFPhrX+8I8alORMeabpLbWPnBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 943e72d6-593d-4c26-4b5a-08dee6176ff1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 04:29:07.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j+aYkG9v7EcVSXqZZ53PAK/Rx+sVNHlUiRpb+D6ZhaxdVGrUXcK+2UlH6clZKpFWdQ/IZTzkuvED3wR6yLT7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
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

On Fri, Jun 12, 2026 at 03:53:40PM +0200, Thomas Hellström wrote:
> Add a watch_queue notification channel tied to struct xe_file so that
> userspace can subscribe to asynchronous GPU device events via the
> general kernel notification mechanism.
> 
> Introduce DRM_IOCTL_XE_WATCH_QUEUE to let userspace subscribe a
> notification pipe (opened with pipe2(O_NOTIFICATION_PIPE)) to the device
> event stream.  Embed the watch_id field (0-255) in the WATCH_INFO_ID
> field of every notification, allowing multiple watches to share a single
> pipe and be told apart by the reader.
> 
> Deliver notifications as struct drm_xe_watch_notification records, with
> type always set to WATCH_TYPE_DRM_XE_NOTIFY and subtype drawn from enum
> drm_xe_watch_event.  Define DRM_XE_WATCH_EVENT_VM_ERR as the first
> event, posted by the preempt-rebind worker when a VM encounters an
> unrecoverable error.  Expose xe_watch_queue_post_vm_err_event() as the
> in-kernel posting API.
> 
> Add event definitions in a separate uapi header, <drm/xe_drm_events.h>.
> The main reason is that the header needs to include <linux/watch_queue.h>
> which in turn includes <linux/fcntl.h> which may conflict with the
> system <fcntl.h>. Hence user-space must pay special attention when
> including this file.
> 
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/gpu/drm/xe/Kconfig           |   1 +
>  drivers/gpu/drm/xe/Makefile          |   1 +
>  drivers/gpu/drm/xe/xe_device.c       |   7 ++
>  drivers/gpu/drm/xe/xe_device_types.h |   6 ++
>  drivers/gpu/drm/xe/xe_vm.c           |   4 +
>  drivers/gpu/drm/xe/xe_vm_types.h     |   2 +
>  drivers/gpu/drm/xe/xe_watch_queue.c  | 111 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_watch_queue.h  |  20 +++++
>  include/uapi/drm/xe_drm.h            |  45 +++++++++++
>  include/uapi/drm/xe_drm_events.h     |  62 +++++++++++++++
>  11 files changed, 260 insertions(+)
>  create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.c
>  create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.h
>  create mode 100644 include/uapi/drm/xe_drm_events.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c0d9965c636..b7e02cfa692b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12900,6 +12900,7 @@ F:	Documentation/gpu/xe/
>  F:	drivers/gpu/drm/xe/
>  F:	include/drm/intel/
>  F:	include/uapi/drm/xe_drm.h
> +F:	include/uapi/drm/xe_drm_events.h
>  
>  INTEL ELKHART LAKE PSE I/O DRIVER
>  M:	Raag Jadav <raag.jadav@intel.com>
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4d7dcaff2b91..dbdc2fb49c53 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -25,6 +25,7 @@ config DRM_XE
>  	select DRM_MIPI_DSI
>  	select RELAY
>  	select IRQ_WORK
> +	select WATCH_QUEUE
>  	# xe depends on ACPI_VIDEO when ACPI is enabled
>  	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
>  	select BACKLIGHT_CLASS_DEVICE if ACPI
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 8e7b146880f4..fc8b4023a044 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -150,6 +150,7 @@ xe-y += xe_bb.o \
>  	xe_vsec.o \
>  	xe_wa.o \
>  	xe_wait_user_fence.o \
> +	xe_watch_queue.o \
>  	xe_wopcm.o
>  
>  xe-$(CONFIG_I2C)	+= xe_i2c.o
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 867d7c55dc03..788ef2fbd6e5 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/fault-inject.h>
>  #include <linux/units.h>
> +#include <linux/watch_queue.h>
>  
>  #include <drm/drm_client.h>
>  #include <drm/drm_gem_ttm_helper.h>
> @@ -77,6 +78,7 @@
>  #include "xe_vsec.h"
>  #include "xe_wait_user_fence.h"
>  #include "xe_wa.h"
> +#include "xe_watch_queue.h"
>  
>  #include <generated/xe_device_wa_oob.h>
>  #include <generated/xe_wa_oob.h>
> @@ -112,6 +114,8 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
>  	file->driver_priv = xef;
>  	kref_init(&xef->refcount);
>  
> +	init_watch_list(&xef->watch_list, NULL);
> +
>  	task = get_pid_task(rcu_access_pointer(file->pid), PIDTYPE_PID);
>  	if (task) {
>  		xef->process_name = kstrdup(task->comm, GFP_KERNEL);
> @@ -126,6 +130,8 @@ static void xe_file_destroy(struct kref *ref)
>  {
>  	struct xe_file *xef = container_of(ref, struct xe_file, refcount);
>  
> +	remove_watch_from_object(&xef->watch_list, NULL, 0, true);
> +
>  	xa_destroy(&xef->exec_queue.xa);
>  	mutex_destroy(&xef->exec_queue.lock);
>  	xa_destroy(&xef->vm.xa);
> @@ -216,6 +222,7 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>  	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY, xe_vm_get_property_ioctl,
>  			  DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(XE_VM_RESTART, xe_vm_restart_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(XE_WATCH_QUEUE, xe_watch_queue_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 32dd2ffbc796..ca726ada30a7 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -11,6 +11,7 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_file.h>
>  #include <drm/ttm/ttm_device.h>
> +#include <linux/watch_queue.h>
>  
>  #include "xe_devcoredump_types.h"
>  #include "xe_drm_ras_types.h"
> @@ -632,6 +633,11 @@ struct xe_file {
>  
>  	/** @refcount: ref count of this xe file */
>  	struct kref refcount;
> +
> +#ifdef CONFIG_WATCH_QUEUE
> +	/** @watch_list: per-file notification source for device events */
> +	struct watch_list watch_list;
> +#endif
>  };
>  
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index b69a2e5bd9c9..232de0d948d2 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/ttm/ttm_tt.h>
>  #include <uapi/drm/xe_drm.h>
> +#include <uapi/drm/xe_drm_events.h>
>  #include <linux/ascii85.h>
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
> @@ -45,6 +46,7 @@
>  #include "xe_trace_bo.h"
>  #include "xe_vm_madvise.h"
>  #include "xe_wa.h"
> +#include "xe_watch_queue.h"
>  
>  #ifdef CONFIG_FAULT_INJECTION
>  static DECLARE_FAULT_ATTR(rebind_enospc);
> @@ -584,6 +586,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	}
>  
>  	if (err) {
> +		xe_watch_queue_post_vm_err_event(vm->xef, vm->id, err);
>  		if ((err == -ENOMEM || err == -ENOSPC) && xe_vm_is_restartable(vm)) {
>  			vm->preempt.rebind_deactivated = true;
>  			drm_dbg(&vm->xe->drm, "Rebind deactivated VM on error %pe\n",
> @@ -2229,6 +2232,7 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
>  	if (err)
>  		goto err_close_and_put;
>  
> +	vm->id = id;
>  	args->vm_id = id;
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 7d295c3b8456..19a673099588 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -407,6 +407,8 @@ struct xe_vm {
>  	bool batch_invalidate_tlb;
>  	/** @xef: Xe file handle for tracking this VM's drm client */
>  	struct xe_file *xef;
> +	/** @id: The id of the VM in the VM table of @xef. */
> +	u32 id;
>  };
>  
>  /** struct xe_vma_op_map - VMA map operation */
> diff --git a/drivers/gpu/drm/xe/xe_watch_queue.c b/drivers/gpu/drm/xe/xe_watch_queue.c
> new file mode 100644
> index 000000000000..32763591075b
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_watch_queue.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
> +#include <linux/watch_queue.h>
> +
> +#include <uapi/drm/xe_drm.h>
> +#include <uapi/drm/xe_drm_events.h>
> +
> +#include "xe_device.h"
> +#include "xe_device_types.h"
> +#include "xe_macros.h"
> +#include "xe_watch_queue.h"
> +
> +/**
> + * struct xe_watch_notification_vm_err - kernel-side VM error event notification
> + * @base: common watch notification header; type is %WATCH_TYPE_DRM_XE_NOTIFY,
> + *        subtype is %DRM_XE_WATCH_EVENT_VM_ERR
> + * @vm_id: ID of the VM that hit error
> + * @error_code: error code describing the error condition (negative errno)
> + * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds at the point the
> + *                error was detected
> + *
> + * Layout mirrors &struct drm_xe_watch_notification_vm_err.
> + */
> +struct xe_watch_notification_vm_err {
> +	struct watch_notification base;
> +	u32 vm_id;
> +	s32 error_code;
> +	u64 timestamp_ns;
> +};
> +
> +/**
> + * xe_watch_queue_ioctl() - Subscribe a pipe to per-file device event notifications
> + * @dev: DRM device
> + * @data: pointer to &struct drm_xe_watch_queue from userspace
> + * @file: DRM file handle of the subscribing process
> + *
> + * Subscribes a notification pipe to receive Xe device events for the calling
> + * process's file handle.  Only events scoped to this file (e.g. VM error on a
> + * VM owned by this file) are delivered.  The pipe must have been opened with
> + * O_NOTIFICATION_PIPE and sized with %IOC_WATCH_QUEUE_SET_SIZE before calling
> + * this IOCTL.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int xe_watch_queue_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +	struct xe_file *xef = file->driver_priv;
> +	struct xe_device *xe = to_xe_device(dev);
> +	struct drm_xe_watch_queue *args = data;
> +	struct watch_queue *wqueue;
> +	struct watch *watch;
> +	int ret;
> +
> +	if (XE_IOCTL_DBG(xe, args->flags || args->pad))
> +		return -EINVAL;
> +	if (XE_IOCTL_DBG(xe, args->watch_id > 0xff))
> +		return -EINVAL;
> +
> +	wqueue = get_watch_queue(args->fd);
> +	if (XE_IOCTL_DBG(xe, IS_ERR(wqueue)))
> +		return PTR_ERR(wqueue);
> +
> +	watch = kzalloc_obj(*watch, GFP_KERNEL | __GFP_ACCOUNT);
> +	if (XE_IOCTL_DBG(xe, !watch)) {
> +		ret = -ENOMEM;
> +		goto out_put_queue;
> +	}
> +
> +	init_watch(watch, wqueue);
> +	watch->id = 0;
> +	watch->info_id = (u32)args->watch_id << WATCH_INFO_ID__SHIFT;
> +
> +	ret = add_watch_to_object(watch, &xef->watch_list);
> +	if (XE_IOCTL_DBG(xe, ret))
> +		kfree(watch);
> +
> +out_put_queue:
> +	put_watch_queue(wqueue);
> +	return ret;
> +}
> +
> +/**
> + * xe_watch_queue_post_vm_err_event() - Post a VM error event
> + * @xef: xe file handle that owns the VM
> + * @vm_id: userspace ID of the VM that hit error
> + * @error_code: error code describing the error condition (negative errno)
> + *
> + * Posts a %DRM_XE_WATCH_EVENT_VM_ERR notification carrying @vm_id and
> + * @error_code to every pipe that @xef has subscribed via
> + * %DRM_IOCTL_XE_WATCH_QUEUE.  Only the owning process is notified,
> + * preventing information leaks to other clients.
> + */
> +void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32 vm_id,
> +				      int error_code)
> +{
> +	struct xe_watch_notification_vm_err n = {};
> +
> +	n.base.type    = WATCH_TYPE_DRM_XE_NOTIFY;
> +	n.base.subtype = DRM_XE_WATCH_EVENT_VM_ERR;
> +	n.base.info    = watch_sizeof(struct xe_watch_notification_vm_err);
> +	n.vm_id        = vm_id;
> +	n.error_code   = error_code;
> +	n.timestamp_ns = ktime_get_ns();
> +
> +	post_watch_notification(&xef->watch_list, &n.base, current_cred(), 0);

Is this reclaim safe (i.e., could we post a watch notification in direct
reclaim from our shrinker)? From my look, I think the answer is yes. I
ask because whatever we land here, I think the answer must be KMD->UMD
events are reclaim safe.

Matt 

> +}
> diff --git a/drivers/gpu/drm/xe/xe_watch_queue.h b/drivers/gpu/drm/xe/xe_watch_queue.h
> new file mode 100644
> index 000000000000..ad199ee68205
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_watch_queue.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _XE_WATCH_QUEUE_H_
> +#define _XE_WATCH_QUEUE_H_
> +
> +#include <linux/types.h>
> +
> +struct drm_device;
> +struct drm_file;
> +struct xe_file;
> +
> +int xe_watch_queue_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *file);
> +void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32 vm_id,
> +				      int error_code);
> +
> +#endif /* _XE_WATCH_QUEUE_H_ */
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 8d5e3f06b8d4..0083dd712f7e 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -86,6 +86,7 @@ extern "C" {
>   *  - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
>   *  - &DRM_IOCTL_XE_VM_GET_PROPERTY
>   *  - &DRM_IOCTL_XE_VM_RESTART
> + *  - &DRM_IOCTL_XE_WATCH_QUEUE
>   */
>  
>  /*
> @@ -112,6 +113,7 @@ extern "C" {
>  #define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
>  #define DRM_XE_VM_GET_PROPERTY		0x0f
>  #define DRM_XE_VM_RESTART		0x10
> +#define DRM_XE_WATCH_QUEUE		0x11
>  
>  /* Must be kept compact -- no holes */
>  
> @@ -132,6 +134,7 @@ extern "C" {
>  #define DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_EXEC_QUEUE_SET_PROPERTY, struct drm_xe_exec_queue_set_property)
>  #define DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET_PROPERTY, struct drm_xe_vm_get_property)
>  #define DRM_IOCTL_XE_VM_RESTART			DRM_IOW(DRM_COMMAND_BASE + DRM_XE_VM_RESTART, struct drm_xe_vm_restart)
> +#define DRM_IOCTL_XE_WATCH_QUEUE		DRM_IOW(DRM_COMMAND_BASE + DRM_XE_WATCH_QUEUE, struct drm_xe_watch_queue)
>  
>  /**
>   * DOC: Xe IOCTL Extensions
> @@ -2653,6 +2656,48 @@ enum drm_xe_ras_error_component {
>  	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL] = "soc-internal"		\
>  }
>  
> +/**
> + * DOC: DRM_XE_WATCH_QUEUE
> + *
> + * Subscribe a notification pipe to receive device events for the calling
> + * process's DRM file handle.  Events are scoped to the subscribing file:
> + * only events that belong to that file (for example, VM error on a VM created
> + * through the same file) are delivered, preventing information leaks between
> + * processes sharing the same GPU device.
> + *
> + * The pipe must first be opened with O_NOTIFICATION_PIPE (i.e. O_EXCL passed
> + * to pipe2()) and sized via %IOC_WATCH_QUEUE_SET_SIZE before subscribing.
> + *
> + * Events are delivered as notification records read from the pipe.  The
> + * @watch_id field is embedded in the notification info field and can be used
> + * to distinguish multiple watches sharing a pipe.
> + *
> + * Currently defined event subtypes:
> + *  - %DRM_XE_WATCH_EVENT_VM_ERR - a VM owned by this file has encountered an error
> + */
> +
> +/**
> + * struct drm_xe_watch_queue - subscribe to device event notifications
> + *
> + * Used with %DRM_IOCTL_XE_WATCH_QUEUE.  Notifications are scoped to the
> + * DRM file handle used to issue this IOCTL.
> + */
> +struct drm_xe_watch_queue {
> +	/** @fd: file descriptor of pipe opened with O_NOTIFICATION_PIPE */
> +	__u32 fd;
> +
> +	/**
> +	 * @watch_id: identifier (0–255) embedded in the watch notification
> +	 * info field; allows multiplexing several watches on one pipe
> +	 */
> +	__u32 watch_id;
> +
> +	/** @flags: must be zero */
> +	__u32 flags;
> +
> +	/** @pad: reserved, must be zero */
> +	__u32 pad;
> +};
>  #if defined(__cplusplus)
>  }
>  #endif
> diff --git a/include/uapi/drm/xe_drm_events.h b/include/uapi/drm/xe_drm_events.h
> new file mode 100644
> index 000000000000..6cc7528bfb9b
> --- /dev/null
> +++ b/include/uapi/drm/xe_drm_events.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _UAPI_XE_DRM_EVENTS_H_
> +#define _UAPI_XE_DRM_EVENTS_H_
> +
> +#include <linux/types.h>
> +#include <linux/watch_queue.h>
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +/**
> + * enum drm_xe_watch_event - Xe device watch event subtypes
> + *
> + * Subtypes for notifications delivered via %WATCH_TYPE_DRM_XE_NOTIFY when
> + * reading from a pipe subscribed with %DRM_IOCTL_XE_WATCH_QUEUE.
> + */
> +enum drm_xe_watch_event {
> +	/**
> +	 * @DRM_XE_WATCH_EVENT_VM_ERR: a VM has encountered an error.
> +	 *
> +	 * Indicates that a fatal or resource error occurred within the given
> +	 * VM.  The vm_id of the affected VM is carried in the
> +	 * @drm_xe_watch_notification_vm_err::vm_id field of the extended
> +	 * notification record.
> +	 */
> +	DRM_XE_WATCH_EVENT_VM_ERR = 0,
> +};
> +
> +/**
> + * struct drm_xe_watch_notification_vm_err - VM error event notification
> + *
> + * Notification record delivered for %DRM_XE_WATCH_EVENT_VM_ERR.
> + * The record type is always %WATCH_TYPE_DRM_XE_NOTIFY and the subtype is
> + * %DRM_XE_WATCH_EVENT_VM_ERR.
> + */
> +struct drm_xe_watch_notification_vm_err {
> +	/** @base: common watch notification header */
> +	struct watch_notification base;
> +
> +	/** @vm_id: ID of the VM that encountered an error */
> +	__u32 vm_id;
> +
> +	/** @error_code: error code describing the error condition (negative errno) */
> +	__s32 error_code;
> +
> +	/**
> +	 * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds at the
> +	 * point the error was detected
> +	 */
> +	__u64 timestamp_ns;
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* _UAPI_XE_DRM_EVENTS_H_ */
> -- 
> 2.54.0
> 
