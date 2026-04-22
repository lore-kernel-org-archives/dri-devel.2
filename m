Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1092FA1FF0
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B927410E2C4;
	Wed, 22 Apr 2026 20:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nRMMDoWv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F38B10E07E;
 Wed, 22 Apr 2026 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776889688; x=1808425688;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=iXQ/+QBp0XwEt342kDMp6pkuyi6aXx/JIxXSteIjrhQ=;
 b=nRMMDoWvt5Vkpe1zb6MaCMgW+ucu3Ccq8fXMX3GQUNRzQ5jCg3HbAW7R
 42seTr59yFMUVJBruRImsOEFMd4S5wIJF4pqOJZKJL0kCTXlVKwGKiQvH
 JjkdzUHr+lslIT1ZQ1oW1LiIU05Fkpybu5QiFIt1HRYdbWRchbvDL07Xj
 5O4BQHP/KdnAZSAj8HOinl8l3AJ+eryaXK4vuZXtq68voJAp82wiWAdMi
 WWWy9JCVb1XzWBSW3LSR0iwdG1tDPpR8vph7meUDV02RLEMvpoyStXxOc
 jFjmIgaJU3SsklNRf7mVLwLCap8OigkuaIJnQSsNeQ98fMxLishR+BBoY w==;
X-CSE-ConnectionGUID: d9d2ucclSJOjns+qX2Pqmw==
X-CSE-MsgGUID: L/cvtd6TQDqaDU1DGsFyHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89317989"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="89317989"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 13:28:07 -0700
X-CSE-ConnectionGUID: elRtUlSDSXaAs2oOc+GvZg==
X-CSE-MsgGUID: mkjUM3ygSPmkmrXXvq9WRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="229791685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 13:28:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 13:28:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 13:28:07 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 13:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9tZ1L0IevkmbIrvSuio1EnVx4g5cbB33Zf/kfFrd1hynolGqEZ0GkfkvsA5s0C0ZB1DCS0+QK0U7/f5h3apaDyzQK727xkGH47znxJW/L2IT9gGCzh+8Dlt99NczctfMvFebZQzMn4OuArzWJBY4ZxTHPn6vxBvXPVZf9ROgyoGVUc2a2r+lcgzysT88nRPw4gEltIFjhPcpV8HY8sL0BVSsjm2B5F5RQiKENHQ9Ionvs9oECzSKol88RqQMSJgPEm38wFVMKi/RmMRX4a1lM0FUWyw44oQLRU2Y+AB9lguaYtW816VCHMhmNhxIhahn87mYTX5XT58D6PM1CESNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNpAG5ClnknaGV1Il5sCUwUWcE4zzxy+6m0J+kNAis4=;
 b=R8UAX3BQC3Hmu4tk+zUouD5ZKysBsCLgYiSDDDfNr/Sf6J2aiQ6ilgcoZxUK1HC9WR7+IYRPX3MuE41h+yQ9yt9p/zFifJWwl73EpSCRV7a93BNiYq78R+kZt0/+kZNNV3YR+oqjx7kTHFXVy1hQn+kB6DSMxnDQcY8/MTw0pimrlpfKYHzLr3to+gnvdhdH+cZwvYNhZdESLvPW4cDjiAhxpruEo0aNTjZmpcP56KMUXD+zynSnQpRXwf+pXjuBpdzTMzvp6OQ5+GaqzLPXLl8BzV+zerLX8aNmAXvN6FUKo8ecW3YsWAwpJij61B/WyHtqiTlyM7FJ0tLPNHmWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 20:27:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:27:57 +0000
Date: Wed, 22 Apr 2026 13:27:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH 3/3] drm/xe: Avoid shrinker reclaim from kswapd under
 fragmentation
Message-ID: <aekvSVIuRwRuHcXI@gsse-cloud1.jf.intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-4-matthew.brost@intel.com>
 <432e5ce12ab767bc88b2a0cec49de4fc48694b24.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <432e5ce12ab767bc88b2a0cec49de4fc48694b24.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: c206d668-5060-452a-983e-08dea0ada390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: t7qtFyXu+D7NHmn1HOYgFltsMfNhe4mNtfUS6KuWvYsVmJdH8npV6zYvo35EUM0saTFWm/vN+a3rxBPZT70zLenPxG2yyPZcmE3JKwuZfgYCBUQ7NC+kwrHQjnimd5d0wHKXVs+2KUptehB0NCMn2SrzaMhWH1Wdp1EOjMFwrhve2UqM+mmUm3GEklG73QZMzLp3/VfJCQzd9Z6D/b6gjCz/1cmJzAv/gzO50inoHe108sWO959gwvfsnNzvacEYUrEzdORBTAVA6gILdmOsYa34mF6fgomDLC3uDiFTCjbhuT28hkPdfdIvL3CcK6Svjb3SOkZiC7Tpq5cELAbJjUCS0kgeVRMZNKmRRJni8+ATjYWZ6M42fiHnZpQcoe38z5TlrSB+NwZj1uuNTpeNS/amGRpxnTdrxCW3pYusRrRbnU9JmPxPIiBcWrEj/K3GIClgZh3EbgDwGR6pHjIjPf3TXVmCGbvB+i8n5HQQdXycZ2u4Sj99TOjeVR5+zRV46Rhxc21eykFYUn8RKoEoVZE8Zb79rzit2JZ3CoDe2MGf2fRAz/ItqYoFKjopcsfLovzIn/jW4QjwofODpxo7GpTwAiaT+UBmefP4pV/fEXtcmRv5q0JWD96Te7KIkIJxAlVIgrhb8FV8m/4CfAgz+gPU68RWde/uj5uC5v52Swvyl7YKFO2beKQo84cNerbwIglXf4SKQkqLrEns/q+n4ZeX+/DtLQReX61JS42eEZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDIvdmVMbUFvcjFHU3lVbndkWDNoYUU3aXdrQ1dsdCtTcW5Ra3NEY0ZzZUNK?=
 =?utf-8?B?WHZVQ3lYMDc0MkM1NXhGMldtZDZWVTNMaVRVTFdBanBubFNjVGRVazNRYktV?=
 =?utf-8?B?SXBoODVoZ1RzV3liblptTXlUWGhDUDk3bisyWlRpQms3dFUvdHNXeHVXRE5a?=
 =?utf-8?B?ZGd2TGNkRTlmZHdyaHRoZi9hUU5HTXdQT243aEw0Tmd0LytYS29TR2s3a1FP?=
 =?utf-8?B?bTYrUVp2UXo4clhFeHBkbW5zaFpsbjAvZWppZmFmMmUyRmNmTnBVVEVERHJx?=
 =?utf-8?B?V0lPYlBrclJMRTJpUFpxSjdqVTNPWnFNRGdGMFgrMXhPS3EySVBHZStudkhL?=
 =?utf-8?B?ZFEvM2pNMkc2V3FuWTg4cXluUmUyc1FRRUtVejNCallrcWVlQ3N3ekRoc3BE?=
 =?utf-8?B?YXQzY2FKdGd6SHRhR2NGNGorWHJIcEZnNHM1SXVmam9rOHJsVnJidmxrVGpU?=
 =?utf-8?B?MDZwc3V5OFI2SGRFT2RZSXFYcHY2OXBmVkpmZ1R3UjhOQVVhRlNkalZsSG5J?=
 =?utf-8?B?M1dPTjZmcVVJMjl1WUNWZm84MGs2VmkxeUduWlpjTTVZSmZVWlpVNzNRMU53?=
 =?utf-8?B?UkcrRmhDVHIzZEFRZEMyaTdZQ0xRUkNlbnUxUGhRMGRHcGxKQUV6OVNpTXp3?=
 =?utf-8?B?Ty9LQzY0aDVzKzBlMGx6NlEzQ29rNk5NZ040bjE1ejMzUmxHY2tlQTB0WkJu?=
 =?utf-8?B?cjR6T3gxRmJ1MGtjUmhoYm41ZlRJTHJ0OE14OFFteUMrR2NrS1hIQ2RFK0JC?=
 =?utf-8?B?dmoyR3RWNjR5aEtyczlFS2ExWng1a3o4dWtlMXBFb3BKeER1Z3pZQ1Mvenhn?=
 =?utf-8?B?OU01b1dVRExlT0tremhzM0pHZ0EzSHZCbXFmb2JuOTQwWDkzNXZKbmcrZXdk?=
 =?utf-8?B?TFZxRDlTaUdndXlHenIvQVpyVVlKbS8ybGdyOUlsd0ljdlNpeTJHSm9pNlR6?=
 =?utf-8?B?b2FEWWF1ZTZYcWkwUVZFR1pPZ1hFTWQ0OVJGMFhPTTZBdUZHMU9tYjYzV1Fu?=
 =?utf-8?B?ajg3clY5cWI3OUNTQU5IaUl6T3BIb3RKanBOVW9QLzMwRnkwZnptSjJyQVNW?=
 =?utf-8?B?cExlTFJJUnkwNVRXYXhZbTRZNjhXYkhLK2ZxRkUxaFhyMGJNZ05OaFRkZmZl?=
 =?utf-8?B?TlVpRFJ0a2hnRENSRnBKZGpZazZWYUc4V0RDd2pWOTJFelJBUW9pMGFGSjkw?=
 =?utf-8?B?aHpMYTh5OHAyVmY4VEwvamlRSnZ2bERtK21UYTNkdGZvaVlrL1pFdWpEdjBR?=
 =?utf-8?B?WGhjRVIvcUgzZVEwdW5DSmdOTU1Nc09ndGNXVkdGWmVhTVlZWkR2aU1uMDM5?=
 =?utf-8?B?TitnOENCNnVYcjdtTGxqOUJPTHNkQi9KUzhtQmlGSDVZK0tnT3pZVFhVVGFh?=
 =?utf-8?B?a0F4SmZjK3hzYndkRkFsaW9XUE0weEh6SlVFdmJTb0lmL0ZVWkVxaGhQS2Zi?=
 =?utf-8?B?UzhCZnBDY0txYmo0TVl4dlRnUzVXTmQxQkljTDU2RG1FR01WVnRNaXdiSGsy?=
 =?utf-8?B?NlNJNjM1REdra3VkNlJYOU9QUmNsZ3dnTlU5SmtYdFVJd0s0a2lkVDdFZmtP?=
 =?utf-8?B?TS9UQ0VYVnJRZlEwTjJva2h6aHZ3TlhUT2k0Y0pHbTNGVTRvOGdldVh1MSsv?=
 =?utf-8?B?RUVzN21VcUFBK1VNRFJBSDYyOGhSTEZSVFBWWVZINms2dXkzTksyNEUrd0ov?=
 =?utf-8?B?bmxiVXB5cnhxSElrSFNaSU9aTS83QmE2QmdyYVFrZjZJOFpQbEhZaWNEd3Ns?=
 =?utf-8?B?TGRyWHV3ZTBKQU1nNUFMOGVsSHk0TFdITjd3TEgyZmxNbFpUZ0NnOFBkN2dK?=
 =?utf-8?B?YUJHL1UvbW9obHc3SXE3YThoTEMzbzNUdzcwM25PM3FSUWpVYll0cVVwcnFV?=
 =?utf-8?B?RHZoWjc0VGdJeERDUDJ3YU1ZRlFSQVVoV2NxeEo5by9Wd3d3SjVpU2lIbENL?=
 =?utf-8?B?Rm9NL1hwK2xZQkNJWFIwNy92SnFOejFrNWhaZ2g0OWRoak5MTWdWSEJqc0xv?=
 =?utf-8?B?MHQ4TzEvb2trVExWWERMRmJGejBaWmhVNC80djJFNzFKWmlmbEFFWmZFUkpB?=
 =?utf-8?B?bUJDSVNlN3Zoa2t6cSt5UEZzek51cjIzbEFXcE13RUQ2VWhpd3FqS2VTNDJW?=
 =?utf-8?B?c0U1NXpQUm9DMlFZbFVKYlAzRWcxQ2tNblJNamI1ajBkTXB4dHB1cW9UUXB6?=
 =?utf-8?B?dkJzaStadWZ1NXduWGYrcWRDNHhFbHY3MVNzVzJaQTI4VlFabkpRZnNVclMv?=
 =?utf-8?B?VTY3SXoxbUpJNlNOcitNUTBtdm5tK1hvcEdTbXJ0VmhYdVJ0ZEZOMWRVdVA0?=
 =?utf-8?B?SmZUVC9kYVFPdmpoSHVZYVpwZzVnbHFsRFZFR2laMjhXSnF2UVpvZz09?=
X-Exchange-RoutingPolicyChecked: DPxgUBTP4LOnlqEM5mjmSfdIdT9Qro+Y+BO0ag5ROqcdXp3ibhRwOQ0Oy5gSBxWi6salR5QSuhL9vjOFh2lZxF1NqDrwyR/1+PKx/DKnjNq2mTb02nlBURdr41z2FzVJr4YkEzFxZuHy15+7hhIG7VtYIfWugq2SdDa8ZzYkKzEdBmIj3+ONdeVeIryjcZiiVXJs2kk3IgwjWN33JaRtKRi6Gc2IWm1oLmb2raSecaakCs/WbO3RPkS5c0hJFpKKxdqpa/2c7FmsW+3m218gOmxbVnFj6XZ/Bsbu0rJERQZVOna+pZjP6xpAsj/HsPenEZZcstKD/6b5GWTYTR1YKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c206d668-5060-452a-983e-08dea0ada390
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:27:56.8589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGCdBkT5UlGSzV1GG8L2CJmmF2+c2POOXQizAm6obnx1yGT7ZZ3SSGbYbCNFgOGW1O22LNjr2DiRx3EdkcZVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
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

On Wed, Apr 22, 2026 at 10:22:56AM +0200, Thomas Hellström wrote:
> Hi,
> 
> On Mon, 2026-04-20 at 18:26 -0700, Matthew Brost wrote:
> > When the Xe shrinker is invoked from kswapd, a large amount of free
> > memory in ZONE_NORMAL relative to the high watermark is a strong
> > signal
> > that reclaim is being driven by fragmentation rather than true memory
> > pressure.
> > 
> > In this case, shrinking Xe memory is unlikely to help kswapd make
> > forward progress. Instead it can evict active GPU memory despite the
> > system still having substantial free memory, increasing residency
> > churn
> > and reducing GPU forward progress.
> > 
> > Detect this case and bail out early from the Xe shrinker when running
> > in
> > kswapd and ZONE_NORMAL has more than 2x its high watermark free.
> > 
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_shrinker.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> > b/drivers/gpu/drm/xe/xe_shrinker.c
> > index 83374cd57660..e56afde83de6 100644
> > --- a/drivers/gpu/drm/xe/xe_shrinker.c
> > +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> > @@ -236,6 +236,19 @@ static unsigned long xe_shrinker_scan(struct
> > shrinker *shrink, struct shrink_con
> >  	if (nr_scanned >= nr_to_scan || !can_backup)
> >  		goto out;
> >  
> > +	if (current_is_kswapd()) {
> > +		struct zone *zone = &NODE_DATA(sc->nid)-
> > >node_zones[ZONE_NORMAL];
> > +		unsigned long free_pages = zone_page_state(zone,
> > NR_FREE_PAGES);
> > +		unsigned long high_wmark = high_wmark_pages(zone);
> > +
> > +		/*
> > +		 * If we have 2x the high watermark free, this is
> > definitely
> > +		 * fragmentation
> > +		 */
> > +		if (free_pages > (high_wmark * 2))
> > +			goto out;
> > +	}
> > +
> 
> While this or a similar check might make sense, That should ideally be
> in the TTM shrinker helpers. And probably we should ask core mm for a
> proper indication whether this is indeed fragmentation-driven.
> 

Yes, moving this to a TTM shrinker helper—or even a core MM helper—makes
more sense. This is the best heuristic I could come up with based on
what is available in the core MM today. However, this is still not 100%
correct, as I don’t think ZONE_NORMAL is used on systems with less than
4GB of memory; instead, ZONE_DMA32 is used. This might get even worse
when considering Kconfig combonations. Asking the core MM via a helper
whether memory is fragmented is likely the best solution.

Matt

> Thanks,
> Thomas
> 
> 
> 
> >  	/* If we didn't wake before, try to do it now if needed. */
> >  	if (!runtime_pm)
> >  		runtime_pm = xe_shrinker_runtime_pm_get(shrinker,
> > true, 0, can_backup);
