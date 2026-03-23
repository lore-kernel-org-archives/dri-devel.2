Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A4BD58CD1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EA610E3C2;
	Mon, 23 Mar 2026 04:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dQEJHDOV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4A210E3BF;
 Mon, 23 Mar 2026 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774241421; x=1805777421;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eY9w+49obhWPLPvnK16Cih1+NSviz/RSi1c+vmhKLPI=;
 b=dQEJHDOVrSE4CBGWuceCozsUKFX9ISQ2AyOyly6RFVB42coUGgUNVmXz
 v2WTBe/4w8v190EdTgO5kkuwI5vhbxhsfPngda0nGRU0r7cXVr1aeEQar
 u2dNv2N1LQ5gosxeRBPn0b5qv2MAgBAMkQkc5PnQ2aLgb4ePZAxxgd3rQ
 eZDycahRxcInCWDQK5rsIxGSE3Z4jxRaBsZdwGnqKrFffrhjUTW6MNOCq
 VZsqUjSIlkO69GD/CrZDjWXzRgEqrc2rSKSHMyPobuW9WDkHP1qPgCzrU
 Z7ozrsqtMUyifOOnOT604zVv25R61f1jO8OnPTxrlbRoayAW5IJ3cRAd0 w==;
X-CSE-ConnectionGUID: kCyqz1/2QN+ad2YqJyPeBg==
X-CSE-MsgGUID: 2+jThsuIQEiIroj5iz3jLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="92808865"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="92808865"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 21:50:20 -0700
X-CSE-ConnectionGUID: hEJNX+G5ToWHNkjRh62L5Q==
X-CSE-MsgGUID: 1O1XPYFfSgqe1SfezhxnnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="247739123"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 21:50:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 21:50:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 21:50:19 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 21:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn2jbge2ocW2X4+V4xHOHExQcuS4xS4sdO/wC/lPVYZb+fBebSx/U9VG/yeEF+T2TZrrAiO9g4Ne4kqPLSZZSdShQ0cQ3xx3Orm2WNpAEBfb1uMGVcLWczsTXtyyaf2F9AAq39z4IjpPJmu2gifoNPdorB3HYhTwpowSxOu2glMhNVj5BcpuueMoBFuBHck6agvn0HGsWsGU6jkIaho4+mj4fPobUZ/QEHIVLc5We3425Rg+OtFiH1uQ3fXj0piC3cuen75lNj8fB+hNdT0EKwILySK2MEjR7IgOTATkf7asLvZ+MpKwknHQr3xXt1wChXBnX1wufANCe48gkChM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j5vDbCKNTvNyDfW01yr01LVFItdbSn7yjfYNH++8WQ=;
 b=nP3LcvErKd5Gy1A4+BB+6z63MK8NE10Q7FC5mlMjVGor4/hXmRH3hnoDmRV3Nm12E9kSOXDKjC4Z/dGp1QxWFN3amJkYQdfo7g4S5TIio10oYidEHdudjoIwiECgb/LIMhNgQbpOrZ7uow1HtuLnnOEUnAs5VtFZQmXJBPnE/ysTqh74GKIA470ns/YfXFLFUmKz40gvzDT4hJ64k4L70VXRPufdiM2gF6OvTTC+NKAZ2yBfVPMaEgTwQqZRRkM8Y/tOU5TMBncr9wEXWLQVqoWFcy7Mt1clzS3GVA9lTaLjz1Nl/aOrE83vJd7nerscSo+/MSdkRW4MK/7QAOck1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 04:50:11 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 04:50:10 +0000
Date: Sun, 22 Mar 2026 21:50:07 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319101153.169c7f36@fedora>
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|PH0PR11MB4789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b9d6c-1fdb-4967-17a7-08de8897a9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gCcSqaHHsB5H3PtfgyiPADJgXnBqKPw7iqub0RMEIw6anGspjyTRXIbkaG1PIV4BAm9RHsu89xOHwFo2xlAMDqOldaRMCz4sB0rpEYSS/g1f0agaETszxeT+bb6b/k0JpXkmcknZG4H7XV035Jy36uoUXCtkXjBElgKJgIVn0aviDuVDmqMaW54hk3d2Rg6+EvnpnckbRCij8U/42g3IWIG7lyporKq6vNsT3wCTPPWjxGwwYFMEddP8e/SsYqBzY3rU5tx6XMY5zCwFsnpMR9NtjiYpWodSy1bz3Hh5T/DTb8JS+o9hD7faqJI9cOqaxyie9Fr0fdjxaK+RnmS4v35NyalAfheWB7Ol+ewA6pfVkcYLZ5837pes6hLrQNWO/+SyfFEDUD5xucIp55DlvO0WTRuhrlJulmcieUDVhQnrnlDMckQzFNaH3RnJyXgbfxe2wohGczM8T7KiHVcCEcDdmOTBu7ETXWKcBLfDcwgBb0EnmY6ZNymtTi+V7VHBy7VPkYkS9SM8OEK6V1VTLOd/D7orJI9nd2e/tpiVYqKtc5pOsQ6g3nmNdePcf3vyraVdfcr5D2F99IaJLbAcJ3cJBCFbolcf9pOni3qco/WQ55DctR+ui6YRcmft89Im0W/Hxljo6keouIIRt+a9ogXcxMV6kXCy5keIX+Aw6oEv/Y/QLKE12p7zjaU7gmuq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUg2Q1BXK2tBV1lDa1VUS1RqdzZEOUFBbzJwUVRwdVQzVFVmNGpLMTZ0Y28x?=
 =?utf-8?B?c3dLa0ZzS2pqZUIrcTJha3RLNjk0MTZybkZlemJ2TUtFamtzNkk1STF4a2xu?=
 =?utf-8?B?Qy94a0JQTHc5RUZJbDZIUk5hZmZua3pFVzdFLzF4Mk4zbEtZOGZoVDdqZSt1?=
 =?utf-8?B?SEN3TU9nWGRsb1BKaWwrMENjclM1WVRUdGVjMlJJRjlXQnlERXpZcy9SYzRP?=
 =?utf-8?B?dGtON3ZjMVEyZlFxd1ZDeGN5Um9pa1hyTDhwVjVtb002WVVSY3U1ZFB1TTFR?=
 =?utf-8?B?QzF6Q09sVyttNTd2bmRrOHJJQzJjZHQ0VUhMeE5Qd2JOTmI3enRxYzRnYWQx?=
 =?utf-8?B?UFovam5yaUhnMHVORm9YZVMvZmp0UERKRjd0QTljUnIyK29udnBjNGVabXMx?=
 =?utf-8?B?Rks2YmlqNDNFaS8wQVlFbUlYcXBCSFEyRTZwbDR5NDFiVVVYb3BtQWR1Mjkz?=
 =?utf-8?B?dUVHUHQ1YzZJRVJCbmpQdTZvc1VqVlljVkJBTEZvOFJsakVuL2EvYlVwOU5r?=
 =?utf-8?B?a3lINWdCemUzN1lsbDQrL2tKRFY4QW5pN1E4NDJ3RzFsV2c1R2pRTEg2N0NB?=
 =?utf-8?B?MHU0Nkl4OEFXYldKU1Vqd2c0NmxiV3lGQW1oQytObmd2WFo4SlRNUjVsVFcr?=
 =?utf-8?B?Y0pFZTAxNmRFbDNOUTNJUDVaT3BEeUsvaDFRWWNFQ1lYMTAwbFY2anJKYVVU?=
 =?utf-8?B?eTZIN0k1OVNGSWgwN01pY3A1MWhmR1J0WUc5QUF5VkY0TWY1QlNoY2RVdkNY?=
 =?utf-8?B?emtVV1NIT3d6ZEhOSzIzSTl3MzVQU0dZbzBJWENFK050L2NINWJ3L21ZQmox?=
 =?utf-8?B?UUxtWkhOcDE2aWhiRHNJclBmM2pSWXc5cU1UUEkyUFB3VTJZS25KZ0hkQUgx?=
 =?utf-8?B?ZlZxMldtN1J5SUJzN05MSFc2QlFsMkRDZGp2NUcxTUViM3lHdXVTM1pTRnZw?=
 =?utf-8?B?N3BIR0NVNm00MVJZck5DRnhNOXRubzlzMkk2Wjg4UHlxMk1jWmw1NzBQOTZ3?=
 =?utf-8?B?cDlNanlqN1hyMFRseldKbVp2Z0ZQNXErTXloODhWdkJUOUpKOWp3c0tEUmF5?=
 =?utf-8?B?dWlrUnVxb1NXbVh2Q3lwRUNXNHNFM3U2Qm9vQ0tYMnVaTHJKTk9tQnV1RUc2?=
 =?utf-8?B?Q2g2UklXbVI1YjNOTFc2T1U4clREc3RjUVF3dDVZNVNNcDlsdU10NW5hM2xn?=
 =?utf-8?B?WXN5U0Q2UWlOWEdrU2xaekFGQ2hteEVtSzBscU9ybGJJZi84U1AxL1JwUkZ4?=
 =?utf-8?B?V0pJRFpTOVkxb1diR1VmSE1vYlFZOGtoTFR3T3ZidTlGa1g2VFdpZUd3SFlV?=
 =?utf-8?B?WFdvQTk1VXR4aUhHc0t2aFdPZzB6NEhtNml0dGsra29PQlBuOUNkajlKUVVG?=
 =?utf-8?B?YnBmOFdTVXF0SHlhdXZlZGpDV3hTY05oSlpZVmJ5a1BRK3d6eG9iNFR2YkdK?=
 =?utf-8?B?Z1N0Q2lsZ3I0aTdJSVlPZmZUVFVzL3NrYkRaYWVzYmExZVNsUEpoTXNld0JQ?=
 =?utf-8?B?cWpseGJRSXdsVVZ5aEN5anpReVlxYS9VTE9HY0Z4V0ptVzFadFpWOFBBREc4?=
 =?utf-8?B?ZElmRHRrRnRoYVIvYy9CUXZNYktaaHBNQ1FnRXNGRFBWVXoxekhqS1hmdll6?=
 =?utf-8?B?T2hCNlo0U0o5NHdrazNiYVF4UlFaZ2lMN0pGN2Z3WEhuV3dJVTl3c2czRnRq?=
 =?utf-8?B?cnY3YVBYTDdnZkl1VzBKUW45OXFoMGgyNWxCamlkN3NIa1VETFpWTTNNT0g0?=
 =?utf-8?B?b1N3dDNPS0RVUXJ0NnlZdmNTR0paME1XODVMZkM2d2daVGhRcUczc213bVFT?=
 =?utf-8?B?eWJBZFUxRTRkai9WQVlVSU5oMW5YUnN5WnZmbHllZStuV2wyWlVkSVRTMWRr?=
 =?utf-8?B?c2Z1TkpKQWkxSVhkUUlNQi9vSVIrU0NMeW84aEc2d1dYcDlsdDRuWUFnc1Ny?=
 =?utf-8?B?UFdHZnNVWllLd3JxbGlGTjhRVmZpdFdvUEQ1UGpLM3JDWlFDVXBMQ0tObWNR?=
 =?utf-8?B?djF0WEhYajBvQkRlaUhLM1ZYWElzbWk3SUVaanVld2hJT2ZobXZsb01IN3E2?=
 =?utf-8?B?SFFMSEdWU1M2QWwyT0tFQ2doQVJEcXBFNldWTW02QzRYTytXclFoV1U4ZlY1?=
 =?utf-8?B?bHc5aEdTVDBVQ09RU0ZSTVVXWVZHcWNuS0E1bS9HSDhBLzYySVArNkJBdXRw?=
 =?utf-8?B?WnJvVmhCVGlIQVc5UENGTEI0ZTRVaW1iUnppcC9tUFBRdjI3RGxvVysyVTB1?=
 =?utf-8?B?Qll2ckFvampmcDRYZ2gvcjMyaUpyT0pkUndCeVl1eGYycjRtRGRWSXphNTkx?=
 =?utf-8?B?b25ySW9RWWFRaDZ1WmVLdjV3WVdrOVBxUjdldEVCbnUvZm1mWHAxQT09?=
X-Exchange-RoutingPolicyChecked: GYbY80SPpNA3pnyNiLm6lUqe6yI8A6YCgvc+WMLdwWckg81HzRQLNUo7cOBc2TLgq8fTO/ww5H5mMhD+vEeD2J9OB4TYe4lrfWxakFHNH1l3YaeVnlaOXT3bgBP6Xd1g6o40im9UESuGccHGgszvxyNknUL1Ru4eSmcfA3BZsrzhtVBdbr1JMbzOFokd+rSq3RR3MkaLSU0jIHc/yJLfjsYbhKjnD6nvJdlxIa2z0SG0SyJHvL6xC9B0dy5HJsShlVxI5kw47an/AxXXkUYeJA3F+Y21r9JEjaQ2dyHb8tgS8FxnwBCgvWvc5off6PwDVH+yMQs75VDb6Myrwpd7QA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b9d6c-1fdb-4967-17a7-08de8897a9f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 04:50:10.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOIJSvii3eg4GcFZwVA7GEkAhxUbAay+sK5/Yg1ufPh4jUG7V4QSCre5sY7BpYzI/Nd7gae2BlkfB2dKHmnLQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
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

On Thu, Mar 19, 2026 at 10:11:53AM +0100, Boris Brezillon wrote:
> Hi Matthew,
> 
> On Wed, 18 Mar 2026 16:28:13 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > > - fence must be signaled for dma_fence::ops to be set back to NULL
> > > - no .cleanup and no .wait implementation
> > > 
> > > There might be an interest in having HW submission fences reflecting
> > > when the job is passed to the FW/HW queue, but that can done as a
> > > separate fence implementation using a different fence timeline/context.
> > >   
> > 
> > Yes, I removed scheduled side of drm sched fence as I figured that could
> > be implemented driver side (or as an optional API in drm dep). Only
> > AMDGPU / PVR use these too for ganged submissions which I need to wrap
> > my head around. My initial thought is both of implementations likely
> > could be simplified.
> 
> IIRC, PVR was also relying on it to allow native FW waits: when we have
> a job that has deps that are backed by fences emitted by the same
> driver, they are detected and lowered to waits on the "scheduled"
> fence, the wait on the finished fence is done FW side.

Ah, ok. We can build in a scheduling concept if needed, but I’d likely
insist it be an opt-in feature. These are the types of driver-side
requirements I’d need help with.

> 
> > 
> > > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > new file mode 100644
> > > > index 000000000000..2d012b29a5fc
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > @@ -0,0 +1,675 @@
> > > > +// SPDX-License-Identifier: MIT
> > > > +/*
> > > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > > + *
> > > > + * Permission is hereby granted, free of charge, to any person obtaining a
> > > > + * copy of this software and associated documentation files (the "Software"),
> > > > + * to deal in the Software without restriction, including without limitation
> > > > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > > > + * and/or sell copies of the Software, and to permit persons to whom the
> > > > + * Software is furnished to do so, subject to the following conditions:
> > > > + *
> > > > + * The above copyright notice and this permission notice shall be included in
> > > > + * all copies or substantial portions of the Software.
> > > > + *
> > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > > + *
> > > > + * Copyright © 2026 Intel Corporation
> > > > + */
> > > > +
> > > > +/**
> > > > + * DOC: DRM dependency job
> > > > + *
> > > > + * A struct drm_dep_job represents a single unit of GPU work associated with
> > > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > > + *
> > > > + * 1. **Allocation**: the driver allocates memory for the job (typically by
> > > > + *    embedding struct drm_dep_job in a larger structure) and calls
> > > > + *    drm_dep_job_init() to initialise it. On success the job holds one
> > > > + *    kref reference and a reference to its queue.
> > > > + *
> > > > + * 2. **Dependency collection**: the driver calls drm_dep_job_add_dependency(),
> > > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dependencies(),
> > > > + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence objects
> > > > + *    that must be signalled before the job can run. Duplicate fences from the
> > > > + *    same fence context are deduplicated automatically.
> > > > + *
> > > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> > > > + *    consuming a sequence number from the queue. After arming,
> > > > + *    drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > > > + *    userspace or used as a dependency by other jobs.
> > > > + *
> > > > + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. The
> > > > + *    queue takes a reference that it holds until the job's finished fence
> > > > + *    signals and the job is freed by the put_job worker.
> > > > + *
> > > > + * 5. **Completion**: when the job's hardware work finishes its finished fence
> > > > + *    is signalled and drm_dep_job_put() is called by the queue. The driver
> > > > + *    must release any driver-private resources in &drm_dep_job_ops.release.
> > > > + *
> > > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> > > > + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> > > > + * objects before the driver's release callback is invoked.
> > > > + */
> > > > +
> > > > +#include <linux/dma-resv.h>
> > > > +#include <linux/kref.h>
> > > > +#include <linux/slab.h>
> > > > +#include <drm/drm_dep.h>
> > > > +#include <drm/drm_file.h>
> > > > +#include <drm/drm_gem.h>
> > > > +#include <drm/drm_syncobj.h>
> > > > +#include "drm_dep_fence.h"
> > > > +#include "drm_dep_job.h"
> > > > +#include "drm_dep_queue.h"
> > > > +
> > > > +/**
> > > > + * drm_dep_job_init() - initialise a dep job
> > > > + * @job: dep job to initialise
> > > > + * @args: initialisation arguments
> > > > + *
> > > > + * Initialises @job with the queue, ops and credit count from @args.  Acquires
> > > > + * a reference to @args->q via drm_dep_queue_get(); this reference is held for
> > > > + * the lifetime of the job and released by drm_dep_job_release() when the last
> > > > + * job reference is dropped.
> > > > + *
> > > > + * Resources are released automatically when the last reference is dropped
> > > > + * via drm_dep_job_put(), which must be called to release the job; drivers
> > > > + * must not free the job directly.
> > > > + *
> > > > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > > + *   -%ENOMEM on fence allocation failure.
> > > > + */
> > > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > > +		     const struct drm_dep_job_init_args *args)
> > > > +{
> > > > +	if (unlikely(!args->credits)) {
> > > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	memset(job, 0, sizeof(*job));
> > > > +
> > > > +	job->dfence = drm_dep_fence_alloc();
> > > > +	if (!job->dfence)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	job->ops = args->ops;
> > > > +	job->q = drm_dep_queue_get(args->q);
> > > > +	job->credits = args->credits;
> > > > +
> > > > +	kref_init(&job->refcount);
> > > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > > +	INIT_LIST_HEAD(&job->pending_link);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_drop_dependencies() - release all input dependency fences
> > > > + * @job: dep job whose dependency xarray to drain
> > > > + *
> > > > + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> > > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel —
> > > > + * i.e. slots that were pre-allocated but never replaced — are silently
> > > > + * skipped; the sentinel carries no reference.  Called from
> > > > + * drm_dep_queue_run_job() in process context immediately after
> > > > + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasing
> > > > + * dependencies here — while still in process context — avoids calling
> > > > + * xa_destroy() from IRQ context if the job's last reference is later
> > > > + * dropped from a dma_fence callback.
> > > > + *
> > > > + * Context: Process context.
> > > > + */
> > > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > > +{
> > > > +	struct dma_fence *fence;
> > > > +	unsigned long index;
> > > > +
> > > > +	xa_for_each(&job->dependencies, index, fence) {
> > > > +		if (unlikely(fence == DRM_DEP_JOB_FENCE_PREALLOC))
> > > > +			continue;
> > > > +		dma_fence_put(fence);
> > > > +	}
> > > > +	xa_destroy(&job->dependencies);
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_dep_job_fini() - clean up a dep job
> > > > + * @job: dep job to clean up
> > > > + *
> > > > + * Cleans up the dep fence and drops the queue reference held by @job.
> > > > + *
> > > > + * If the job was never armed (e.g. init failed before drm_dep_job_arm()),
> > > > + * the dependency xarray is also released here.  For armed jobs the xarray
> > > > + * has already been drained by drm_dep_job_drop_dependencies() in process
> > > > + * context immediately after run_job(), so it is left untouched to avoid
> > > > + * calling xa_destroy() from IRQ context.
> > > > + *
> > > > + * Warns if @job is still linked on the queue's pending list, which would
> > > > + * indicate a bug in the teardown ordering.
> > > > + *
> > > > + * Context: Any context.
> > > > + */
> > > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > > +{
> > > > +	bool armed = drm_dep_fence_is_armed(job->dfence);
> > > > +
> > > > +	WARN_ON(!list_empty(&job->pending_link));
> > > > +
> > > > +	drm_dep_fence_cleanup(job->dfence);
> > > > +	job->dfence = NULL;
> > > > +
> > > > +	/*
> > > > +	 * Armed jobs have their dependencies drained by
> > > > +	 * drm_dep_job_drop_dependencies() in process context after run_job().  
> > > 
> > > Just want to clear the confusion and make sure I get this right at the
> > > same time. To me, "process context" means a user thread entering some
> > > syscall(). What you call "process context" is more a "thread context" to
> > > me. I'm actually almost certain it's always a kernel thread (a workqueue
> > > worker thread to be accurate) that executes the drop_deps() after a
> > > run_job().  
> > 
> > Some of context comments likely could be cleaned up. 'process context'
> > here either in user context (bypass path) or run job work item.
> > 
> > >   
> > > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > > +	 */
> > > > +	if (!armed)
> > > > +		drm_dep_job_drop_dependencies(job);  
> > > 
> > > Why do we need to make a difference here. Can't we just assume that the
> > > hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> > > work item embedded in the job to defer its destruction when _put() is
> > > called in a context where the destruction is not allowed?
> > >   
> > 
> > We already touched on this, but the design currently allows the last job
> > put from dma-fence signaling path (IRQ).
> 
> It's not much about the last _put and more about what happens in the
> _release() you pass to kref_put(). My point being, if you assume
> something in _release() is not safe to be done in an atomic context,
> and _put() is assumed to be called from any context, you might as well

No. DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE indicates that the entire job
put (including release) is IRQ-safe. If the documentation isn’t clear, I
can clean that up. Some of my comments here [1] try to explain this
further.

Setting DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE makes a job analogous to a
dma-fence whose release must be IRQ-safe, so there is precedent for
this. I didn’t want to unilaterally require that all job releases be
IRQ-safe, as that would conflict with existing DRM scheduler jobs—hence
the flag.

The difference between non-IRQ-safe and IRQ-safe job release is only
about 12 lines of code. I figured that if we’re going to invest the time
and effort to replace DRM sched, we should aim for the best possible
implementation. Any driver can opt-in here and immediately get less CPU
ultization and power savings. I will try to figure out how to measure
this and get some number here.

[1] https://patchwork.freedesktop.org/patch/711933/?series=163245&rev=1#comment_1312648

> just defer the cleanup (AKA the stuff you currently have in _release())
> so everything is always cleaned up in a thread context. Yes, there's
> scheduling overhead and extra latency, but it's also simpler, because
> there's just one path. So, if the latency and the overhead is not

This isn’t bolted on—it’s a built-in feature throughout. I can assure
you that either mode works. I’ll likely add a debug Kconfig option to Xe
that toggles DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE on each queue creation
for CI runs, to ensure both paths work reliably and receive continuous
testing.

> proven to be a problem (and it rarely is for cleanup operations), I'm
> still convinced this makes for an easier design to just defer the
> cleanup all the time.
> 
> >  If we droppped that, then yes
> > this could change. The reason the if statement currently is user is
> > building a job and need to abort prior to calling arm() (e.g., a memory
> > allocation fails) via a drm_dep_job_put.
> 
> But even in that context, it could still be deferred and work just
> fine, no?
> 

A work item context switch is thousands, if not tens of thousands, of
cycles. If your job release is only ~20 instructions, this is a massive
imbalance and an overall huge waste. Jobs are lightweight objects—they
should really be thought of as an extension of fences. Fence release
must be IRQ-safe per the documentation, so it follows that jobs can opt
in to the same release rules.

In contrast, queues are heavyweight objects, typically with associated
memory that also needs to be released. Here, a work item absolutely
makes sense—hence the design in DRM dep.

> > 
> > Once arm() is called there is a guarnette the run_job path is called
> > either via bypass or run job work item.
> 
> Sure.
> 

Let’s not gloss over this—this is actually a huge difference from DRM
sched. One of the biggest problems I found with DRM sched is that if you
call arm(), run_job() may or may not be called. Without this guarantee,
you can’t do driver-side bookkeeping in arm() that is later released in
run_job(), which would otherwise simplify the driver design.

In Xe, we artificially enforce this rule through our own usage of DRM
sched, but in DRM dep this is now an API-level contract. That allows
drivers to embrace this semantic directly, simplifying their designs.

> > 
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_dep_job_get() - acquire a reference to a dep job
> > > > + * @job: dep job to acquire a reference on, or NULL
> > > > + *
> > > > + * Context: Any context.
> > > > + * Return: @job with an additional reference held, or NULL if @job is NULL.
> > > > + */
> > > > +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job)
> > > > +{
> > > > +	if (job)
> > > > +		kref_get(&job->refcount);
> > > > +	return job;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_get);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_release() - kref release callback for a dep job
> > > > + * @kref: kref embedded in the dep job
> > > > + *
> > > > + * Calls drm_dep_job_fini(), then invokes &drm_dep_job_ops.release if set,
> > > > + * otherwise frees @job with kfree().  Finally, releases the queue reference
> > > > + * that was acquired by drm_dep_job_init() via drm_dep_queue_put().  The
> > > > + * queue put is performed last to ensure no queue state is accessed after
> > > > + * the job memory is freed.
> > > > + *
> > > > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> > > > + *   job's queue; otherwise process context only, as the release callback may
> > > > + *   sleep.
> > > > + */
> > > > +static void drm_dep_job_release(struct kref *kref)
> > > > +{
> > > > +	struct drm_dep_job *job =
> > > > +		container_of(kref, struct drm_dep_job, refcount);
> > > > +	struct drm_dep_queue *q = job->q;
> > > > +
> > > > +	drm_dep_job_fini(job);
> > > > +
> > > > +	if (job->ops && job->ops->release)
> > > > +		job->ops->release(job);
> > > > +	else
> > > > +		kfree(job);
> > > > +
> > > > +	drm_dep_queue_put(q);
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_dep_job_put() - release a reference to a dep job
> > > > + * @job: dep job to release a reference on, or NULL
> > > > + *
> > > > + * When the last reference is dropped, calls &drm_dep_job_ops.release if set,
> > > > + * otherwise frees @job with kfree(). Does nothing if @job is NULL.
> > > > + *
> > > > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> > > > + *   job's queue; otherwise process context only, as the release callback may
> > > > + *   sleep.
> > > > + */
> > > > +void drm_dep_job_put(struct drm_dep_job *job)
> > > > +{
> > > > +	if (job)
> > > > +		kref_put(&job->refcount, drm_dep_job_release);
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_put);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_arm() - arm a dep job for submission
> > > > + * @job: dep job to arm
> > > > + *
> > > > + * Initialises the finished fence on @job->dfence, assigning
> > > > + * it a sequence number from the job's queue. Must be called after
> > > > + * drm_dep_job_init() and before drm_dep_job_push(). Once armed,
> > > > + * drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > > > + * userspace or used as a dependency by other jobs.
> > > > + *
> > > > + * Begins the DMA fence signalling path via dma_fence_begin_signalling().
> > > > + * After this point, memory allocations that could trigger reclaim are
> > > > + * forbidden; lockdep enforces this. arm() must always be paired with
> > > > + * drm_dep_job_push(); lockdep also enforces this pairing.
> > > > + *
> > > > + * Warns if the job has already been armed.
> > > > + *
> > > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> > > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> > > > + *   path.
> > > > + */
> > > > +void drm_dep_job_arm(struct drm_dep_job *job)
> > > > +{
> > > > +	drm_dep_queue_push_job_begin(job->q);
> > > > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > > > +	drm_dep_fence_init(job->dfence, job->q);
> > > > +	job->signalling_cookie = dma_fence_begin_signalling();  
> > > 
> > > I'd really like DMA-signalling-path annotation to be something that
> > > doesn't leak to the job object. The way I see it, in the submit path,
> > > it should be some sort of block initializing an opaque token, and
> > > drm_dep_job_arm() should expect a valid token to be passed, thus
> > > guaranteeing that anything between arm and push, and more generally
> > > anything in that section is safe.
> > >   
> > 
> > Yes. drm_dep_queue_push_job_begin internally creates a token (current)
> > that is paired drm_dep_queue_push_job_end. If you ever have imbalance
> > between arm() and push() you will get complaints.
> > 
> > > 	struct drm_job_submit_context submit_ctx;
> > > 
> > > 	// Do all the prep stuff, pre-alloc, resv setup, ...
> > > 
> > > 	// Non-faillible section of the submit starts here.
> > > 	// This is properly annotated with
> > > 	// dma_fence_{begin,end}_signalling() to ensure we're
> > > 	// not taking locks or doing allocations forbidden in
> > > 	// the signalling path
> > > 	drm_job_submit_non_faillible_section(&submit_ctx) {
> > > 		for_each_job() {
> > > 			drm_dep_job_arm(&submit_ctx, &job);
> > > 
> > > 			// pass the armed fence around, if needed
> > > 
> > > 			drm_dep_job_push(&submit_ctx, &job);
> > > 		}
> > > 	}
> > > 
> > > With the current solution, there's no control that
> > > drm_dep_job_{arm,push}() calls are balanced, with the risk of leaving a
> > > DMA-signalling annotation behind.  
> > 
> > See above, that is what drm_dep_queue_push_job_begin/end do.
> 
> That's still error-prone, and the kind of errors you only detect at
> runtime. Let alone the fact you might not even notice if the unbalanced

I agree that this is only detectable at runtime, but it would complain
immediately.

> symptoms are caused by error paths that are rarely tested. I'm

Yes, this an unfortunate truth.

> proposing something that's designed so you can't make those mistakes
> unless you really want to:
> 
> - drm_job_submit_non_faillible_section() is a block-like macro
>   with a clear scope before/after which the token is invalid
> - drm_job_submit_non_faillible_section() is the only place that can
>   produce a valid token (not enforceable in C, but with an
>   __drm_dep_queue_create_submit_token() and proper disclaimer, I guess
>   we can discourage people to inadvertently use it)
> - drm_dep_job_{arm,push}() calls requires a valid token to work, and
>   with the two points mentioned above, that means you can't call
>   drm_dep_job_{arm,push}() outside a
>   drm_job_submit_non_faillible_section() block

Ok, let me think about whether I can harden this semantic. I believe
what I have in place already enforces it quite well, but I’m a big
believer in using asserts to enforce behavior, and if we can do better,
let’s do it.

> 
> It's not quite the compile-time checks rust would enforce, but it's a
> model that forces people to do it the right way, with extra runtime
> checks for the case where they still got it wrong (like, putting the
> _arm() and _push() in two different
> drm_job_submit_non_faillible_section() blocks).
> 
> > 
> > >   
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_arm);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_push() - submit a job to its queue for execution
> > > > + * @job: dep job to push
> > > > + *
> > > > + * Submits @job to the queue it was initialised with. Must be called after
> > > > + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the queue,
> > > > + * held until the queue is fully done with it. The reference is released
> > > > + * directly in the finished-fence dma_fence callback for queues with
> > > > + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() may run
> > > > + * from hardirq context), or via the put_job work item on the submit
> > > > + * workqueue otherwise.
> > > > + *
> > > > + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> > > > + * dma_fence_end_signalling(). This must be paired with arm(); lockdep
> > > > + * enforces the pairing.
> > > > + *
> > > > + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be called for
> > > > + * @job exactly once, even if the queue is killed or torn down before the
> > > > + * job reaches the head of the queue. Drivers can use this guarantee to
> > > > + * perform bookkeeping cleanup; the actual backend operation should be
> > > > + * skipped when drm_dep_queue_is_killed() returns true.
> > > > + *
> > > > + * If the queue does not support the bypass path, the job is pushed directly
> > > > + * onto the SPSC submission queue via drm_dep_queue_push_job() without holding
> > > > + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is either
> > > > + * run immediately via drm_dep_queue_run_job() if it qualifies for bypass, or
> > > > + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job work item.
> > > > + *
> > > > + * Warns if the job has not been armed.
> > > > + *
> > > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> > > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> > > > + *   path.
> > > > + */
> > > > +void drm_dep_job_push(struct drm_dep_job *job)
> > > > +{
> > > > +	struct drm_dep_queue *q = job->q;
> > > > +
> > > > +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> > > > +
> > > > +	drm_dep_job_get(job);
> > > > +
> > > > +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> > > > +		drm_dep_queue_push_job(q, job);
> > > > +		dma_fence_end_signalling(job->signalling_cookie);
> > > > +		drm_dep_queue_push_job_end(job->q);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	scoped_guard(mutex, &q->sched.lock) {
> > > > +		if (drm_dep_queue_can_job_bypass(q, job))
> > > > +			drm_dep_queue_run_job(q, job);
> > > > +		else
> > > > +			drm_dep_queue_push_job(q, job);
> > > > +	}
> > > > +
> > > > +	dma_fence_end_signalling(job->signalling_cookie);
> > > > +	drm_dep_queue_push_job_end(job->q);
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_push);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> > > > + * @job: dep job to add the dependencies to
> > > > + * @fence: the dma_fence to add to the list of dependencies, or
> > > > + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> > > > + *
> > > > + * Note that @fence is consumed in both the success and error cases (except
> > > > + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no reference).
> > > > + *
> > > > + * Signalled fences and fences belonging to the same queue as @job (i.e. where
> > > > + * fence->context matches the queue's finished fence context) are silently
> > > > + * dropped; the job need not wait on its own queue's output.
> > > > + *
> > > > + * Warns if the job has already been armed (dependencies must be added before
> > > > + * drm_dep_job_arm()).
> > > > + *
> > > > + * **Pre-allocation pattern**
> > > > + *
> > > > + * When multiple jobs across different queues must be prepared and submitted
> > > > + * together in a single atomic commit — for example, where job A's finished
> > > > + * fence is an input dependency of job B — all jobs must be armed and pushed
> > > > + * within a single dma_fence_begin_signalling() / dma_fence_end_signalling()
> > > > + * region.  Once that region has started no memory allocation is permitted.
> > > > + *
> > > > + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the preparation
> > > > + * phase (before arming any job, while GFP_KERNEL allocation is still allowed)
> > > > + * to pre-allocate a slot in @job->dependencies.  The slot index assigned by
> > > > + * the underlying xarray must be tracked by the caller separately (e.g. it is
> > > > + * always index 0 when the dependency array is empty, as Xe relies on).
> > > > + * After all jobs have been armed and the finished fences are available, call
> > > > + * drm_dep_job_replace_dependency() with that index and the real fence.
> > > > + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and may be
> > > > + * called from atomic or signalling context.
> > > > + *
> > > > + * The sentinel slot is never skipped by the signalled-fence fast-path,
> > > > + * ensuring a slot is always allocated even when the real fence is not yet
> > > > + * known.
> > > > + *
> > > > + * **Example: bind job feeding TLB invalidation jobs**
> > > > + *
> > > > + * Consider a GPU with separate queues for page-table bind operations and for
> > > > + * TLB invalidation.  A single atomic commit must:
> > > > + *
> > > > + *  1. Run a bind job that modifies page tables.
> > > > + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> > > > + *     completing, so stale translations are flushed before the engines
> > > > + *     continue.
> > > > + *
> > > > + * Because all jobs must be armed and pushed inside a signalling region (where
> > > > + * GFP_KERNEL is forbidden), pre-allocate slots before entering the region::
> > > > + *
> > > > + *   // Phase 1 — process context, GFP_KERNEL allowed
> > > > + *   drm_dep_job_init(bind_job, bind_queue, ops);
> > > > + *   for_each_mmu(mmu) {
> > > > + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> > > > + *       // Pre-allocate slot at index 0; real fence not available yet
> > > > + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_PREALLOC);
> > > > + *   }
> > > > + *
> > > > + *   // Phase 2 — inside signalling region, no GFP_KERNEL
> > > > + *   dma_fence_begin_signalling();
> > > > + *   drm_dep_job_arm(bind_job);
> > > > + *   for_each_mmu(mmu) {
> > > > + *       // Swap sentinel for bind job's finished fence
> > > > + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> > > > + *                                      dma_fence_get(bind_job->finished));  
> > > 
> > > Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
> > > submit path. If we were to add it, it would be around the
> > > panthor_submit_ctx_push_jobs() call, which might seem broken. In  
> > 
> > Yes, I noticed that. I put XXX comment in my port [1] around this.
> > 
> > [1] https://patchwork.freedesktop.org/patch/711952/?series=163245&rev=1
> > 
> > > practice I don't think it is because we don't expose fences to the
> > > outside world until all jobs have been pushed. So what happens is that
> > > a job depending on a previous job in the same batch-submit has the
> > > armed-but-not-yet-pushed fence in its deps, and that's the only place
> > > where this fence is present. If something fails on a subsequent job
> > > preparation in the next batch submit, the rollback logic will just drop
> > > the jobs on the floor, and release the armed-but-not-pushed-fence,
> > > meaning we're not leaking a fence that will never be signalled. I'm in
> > > no way saying this design is sane, just trying to explain why it's
> > > currently safe and works fine.  
> > 
> > Yep, I think would be better have no failure points between arm and
> > push which again I do my best to enforce via lockdep/warnings.
> 
> I'm still not entirely convinced by that. To me _arm() is not quite the
> moment you make your fence public, and I'm not sure the extra complexity
> added for intra-batch dependencies (one job in a SUBMIT depending on a
> previous job in the same SUBMIT) is justified, because what really
> matters is not that we leave dangling/unsignalled dma_fence objects
> around, the problem is when you do so on an object that has been
> exposed publicly (syncobj, dma_resv, sync_file, ...).
> 

Let me give you an example of why a failure between arm() and push() is
a huge problem:

arm()
dma_resv_install(fence_from_arm)
fail

How does one unwind this? Signal the fence from arm()? What if the fence
from arm() is on a timeline currently being used by the device? The
memory can move, and the device then can corrupt memory.

In my opinion, it’s best and safest to enforce a no-failure policy
between arm() and push().

FWIW, this came up while I was reviewing AMDXDNA’s DRM scheduler usage,
which had the exact issue I described above. I pointed it out and got a
reply saying, “well, this is an API issue, right?”—and they were
correct, it is an API issue.

> > 
> > > 
> > > In general, I wonder if we should distinguish between "armed" and
> > > "publicly exposed" to help deal with this intra-batch dep thing without
> > > resorting to reservation and other tricks like that.
> > >   
> > 
> > I'm not exactly sure what you suggesting but always open to ideas.
> 
> Right now _arm() is what does the dma_fence_init(). But there's an
> extra step between initializing the fence object and making it
> visible to the outside world. In order for the dep to be added to the
> job, you need the fence to be initialized, but that's not quite
> external visibility, because the job is still very much a driver
> object, and if something fails, the rollback mechanism makes it so all
> the deps are dropped on the floor along the job that's being destroyed.
> So we won't really wait on this fence that's never going to be
> signalled.
> 
> I see what's appealing in pretending that _arm() == externally-visible,
> but it's also forcing us to do extra pre-alloc (or other pre-init)
> operations that would otherwise not be required in the submit path. Not
> a hill I'm willing to die on, but I just thought I'd mention the fact I
> find it weird that we put extra constraints on ourselves that are not
> strictly needed, just because we fail to properly flag the dma_fence
> visibility transitions.

See the dma-resv example above. I’m not willing to die on this hill
either, but again, in my opinion, for safety and as an API-level
contract, enforcing arm() as a no-failure point makes sense. It prevents
drivers from doing anything dangerous like the dma-resv example, which
is an extremely subtle bug.

> 
> On the rust side it would be directly described through the type
> system (see the Visibility attribute in Daniel's branch[1]). On C side,
> this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or whichever
> name you want to give it). Any operation pushing the fence to public
> container (dma_resv, syncobj, sync_file, ...) would be rejected when
> that flag is set. At _push() time, we'd clear that flag with a
> dma_fence_set_active() helper, which would reflect the fact the fence
> can now be observed and exposed to the outside world.
> 

Timeline squashing is problematic due to the DMA_FENCE_FLAG_INACTIVE
flag. When adding a fence to dma-resv, fences that belong to the same
timeline are immediately squashed. A later transition of the fence state
completely breaks this behavior.

287 void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
288                         enum dma_resv_usage usage)
289 {
290         struct dma_resv_list *fobj;
291         struct dma_fence *old;
292         unsigned int i, count;
293
294         dma_fence_get(fence);
295
296         dma_resv_assert_held(obj);
297
298         /* Drivers should not add containers here, instead add each fence
299          * individually.
300          */
301         WARN_ON(dma_fence_is_container(fence));
302
303         fobj = dma_resv_fences_list(obj);
304         count = fobj->num_fences;
305
306         for (i = 0; i < count; ++i) {
307                 enum dma_resv_usage old_usage;
308
309                 dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
310                 if ((old->context == fence->context && old_usage >= usage &&
311                      dma_fence_is_later_or_same(fence, old)) ||
312                     dma_fence_is_signaled(old)) {
313                         dma_resv_list_set(fobj, i, fence, usage);
314                         dma_fence_put(old);
315                         return;
316                 }
317         }

Imagine syncobjs have similar squashing, but I don't know that offhand.

> > 
> > > > + *       drm_dep_job_arm(tlb_job[mmu]);
> > > > + *   }
> > > > + *   drm_dep_job_push(bind_job);
> > > > + *   for_each_mmu(mmu)
> > > > + *       drm_dep_job_push(tlb_job[mmu]);
> > > > + *   dma_fence_end_signalling();
> > > > + *
> > > > + * Context: Process context. May allocate memory with GFP_KERNEL.
> > > > + * Return: If fence == DRM_DEP_JOB_FENCE_PREALLOC index of allocation on
> > > > + * success, else 0 on success, or a negative error code.
> > > > + */
> > > > +int drm_dep_job_add_dependency(struct drm_dep_job *job, struct dma_fence *fence)
> > > > +{
> > > > +	struct drm_dep_queue *q = job->q;
> > > > +	struct dma_fence *entry;
> > > > +	unsigned long index;
> > > > +	u32 id = 0;
> > > > +	int ret;
> > > > +
> > > > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > > > +	might_alloc(GFP_KERNEL);
> > > > +
> > > > +	if (!fence)
> > > > +		return 0;
> > > > +
> > > > +	if (fence == DRM_DEP_JOB_FENCE_PREALLOC)
> > > > +		goto add_fence;
> > > > +
> > > > +	/*
> > > > +	 * Ignore signalled fences or fences from our own queue — finished
> > > > +	 * fences use q->fence.context.
> > > > +	 */
> > > > +	if (dma_fence_test_signaled_flag(fence) ||
> > > > +	    fence->context == q->fence.context) {
> > > > +		dma_fence_put(fence);
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	/* Deduplicate if we already depend on a fence from the same context.
> > > > +	 * This lets the size of the array of deps scale with the number of
> > > > +	 * engines involved, rather than the number of BOs.
> > > > +	 */
> > > > +	xa_for_each(&job->dependencies, index, entry) {
> > > > +		if (entry == DRM_DEP_JOB_FENCE_PREALLOC ||
> > > > +		    entry->context != fence->context)
> > > > +			continue;
> > > > +
> > > > +		if (dma_fence_is_later(fence, entry)) {
> > > > +			dma_fence_put(entry);
> > > > +			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> > > > +		} else {
> > > > +			dma_fence_put(fence);
> > > > +		}
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +add_fence:
> > > > +	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,
> > > > +		       GFP_KERNEL);
> > > > +	if (ret != 0) {
> > > > +		if (fence != DRM_DEP_JOB_FENCE_PREALLOC)
> > > > +			dma_fence_put(fence);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return (fence == DRM_DEP_JOB_FENCE_PREALLOC) ? id : 0;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_dep_job_add_dependency);
> > > > +
> > > > +/**
> > > > + * drm_dep_job_replace_dependency() - replace a pre-allocated dependency slot
> > > > + * @job: dep job to update
> > > > + * @index: xarray index of the slot to replace, as returned when the sentinel
> > > > + *         was originally inserted via drm_dep_job_add_dependency()
> > > > + * @fence: the real dma_fence to store; its reference is always consumed
> > > > + *
> > > > + * Replaces the %DRM_DEP_JOB_FENCE_PREALLOC sentinel at @index in
> > > > + * @job->dependencies with @fence.  The slot must have been pre-allocated by
> > > > + * passing %DRM_DEP_JOB_FENCE_PREALLOC to drm_dep_job_add_dependency(); the
> > > > + * existing entry is asserted to be the sentinel.
> > > > + *
> > > > + * This is the second half of the pre-allocation pattern described in
> > > > + * drm_dep_job_add_dependency().  It is intended to be called inside a
> > > > + * dma_fence_begin_signalling() / dma_fence_end_signalling() region where
> > > > + * memory allocation with GFP_KERNEL is forbidden.  It uses GFP_NOWAIT
> > > > + * internally so it is safe to call from atomic or signalling context, but
> > > > + * since the slot has been pre-allocated no actual memory allocation occurs.
> > > > + *
> > > > + * If @fence is already signalled the slot is erased rather than storing a
> > > > + * redundant dependency.  The successful store is asserted — if the store
> > > > + * fails it indicates a programming error (slot index out of range or
> > > > + * concurrent modification).
> > > > + *
> > > > + * Must be called before drm_dep_job_arm(). @fence is consumed in all cases.
> > > > + *
> > > > + * Context: Any context. DMA fence signaling path.
> > > > + */
> > > > +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 index,
> > > > +				    struct dma_fence *fence)
> > > > +{
> > > > +	WARN_ON(xa_load(&job->dependencies, index) !=
> > > > +		DRM_DEP_JOB_FENCE_PREALLOC);
> > > > +
> > > > +	if (dma_fence_test_signaled_flag(fence)) {
> > > > +		xa_erase(&job->dependencies, index);
> > > > +		dma_fence_put(fence);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	if (WARN_ON(xa_is_err(xa_store(&job->dependencies, index, fence,
> > > > +				       GFP_NOWAIT)))) {
> > > > +		dma_fence_put(fence);
> > > > +		return;
> > > > +	}  
> > > 
> > > You don't seem to go for the
> > > replace-if-earlier-fence-on-same-context-exists optimization that we
> > > have in drm_dep_job_add_dependency(). Any reason not to?
> > >   
> > 
> > No, that could be added in. My reasoning for ommiting was if you are
> > pre-alloc a slot you likely know that the same timeline hasn't already
> > been added in but maybe that is bad assumption.
> 
> Hm, in Panthor that would mean extra checks driver side, because at the
> moment we don't check where deps come from. I'd be tempted to say, the
> more we can automate the better, dunno.
> 

In my example of TLB invalidations this is a non-issue. We can always
circle back to squashing here if needed or just do it now. Always open
to ideas.

Matt

> Regards,
> 
> Boris
> 
> [1]https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/61/diffs#a5a71f917ff65cfe4c1a341fa7e55ae149d22863_300_693
