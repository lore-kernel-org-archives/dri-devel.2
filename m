Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E854CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F4710E8F9;
	Tue, 13 Oct 2026 18:37:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B706A10E8F9;
 Tue, 13 Oct 2026 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791916650; x=1823452650;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=l5HKQ23koOP7PkPGbsWmmkNOzOP1arbGSLf5sVbxW0o=;
 b=Uqi0yv5YZ0/XazS3xkY4FoFJs0ZNq/c2zcwYGKoE0kI4AvEhIRsjAB4P
 KK+zATNns9dRl/6dxJUXCO7iD35yL1L4MObrF1j64Eub4DqdiYZFNG50T
 RL+E8flH+1xubzEO0Z5VpzOLlbGk4wZr3Nba+EChr/IqoippjtUBdyTxH
 I09fAdAUcDJc1Dxjghfgbs0KUTrnBdZQhNTEamoeNtg0bfzsBcXOseHEV
 lFI55Xqk1iCZMzuVH+fATaD/VSqg5BaMhHdFSsmaRLZPnGyhIoU6euJLT
 T3oYqb1dt7ZLT1fw8m0XGJ9HDqtzl0rvO1YCDrOZD7llI1TN1AmN1cd2N A==;
X-CSE-ConnectionGUID: X+5zXMMuRUGLS7g0724Gvg==
X-CSE-MsgGUID: ZKzbQHi6QWOmjABtPvq3CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="662652"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="662652"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:37:30 -0700
X-CSE-ConnectionGUID: rAJnRCEJQg+M9lvA9e+QWg==
X-CSE-MsgGUID: fPYt6X9kS3eiwQxJyC5qCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2992848"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 11:37:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:37:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:37:29 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHu6DFlDlZ+Ha1CKVCg998k/CPqGvL/UUKJ3t4siDZMRwrp4Gd5memcA2anQgj3u4tzGz7qtELHgdClPES+XztB+0gYZBXt+PZ0CkDy2cTEG4CbPSLAisJ6X+Fe6wbk7mhepvM5yB8Pg/UCITHOn7Ud+N2hnaldGI+9PVM6LQxw916WTP8PM+nQcAVNeoZ23VDWwo1bvbUiTq4RA6E0tRYccYMxSd4G0A8aHZ1AT9cfa79iTyDoHuENeHfLEYQoj0Apd7TMRA8R3lCq4O8Nvil9p9hVE4Y+9396eylNhyUzgVDpGFv2pCK3zYWIB5SqhPFyZnErLiAjx/xp0H/LrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX9AfEOl4iBCKCQgQiVGNzUrHe4SVlH2ZfP+WowHPy0=;
 b=HEt8tlAOyedGYVoU5qk2I0mlEleZinFL0lGPr5hcrf9ib7G2ur3Tv9wRj4dvDZjbLY79Cnip+521Hl+vaC3q6i6yTrPIf6VoygTbP+tznWs8BdtZalUljGzitalc/qU8TgkEfgI0Z0XQyZHF0WuGo6xGi7b4Dsn4z5CoMiy+rNFvxPv0CEznV9q81NcpYqV3YfPr3VOt8l+PLpY54Gq6VphbqkkF3O9CBRK186Ww1py5fqzuC6pm25APOjYB5GNxfZ01YwMi7tEWfs+iY3tJqQFsNhy3OtDYiqyBywrjHpFXC49Otf9jwUYbZF/mqO8wWs2osZn4mwV16rY2cQ/XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:37:22 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:37:22 +0000
Date: Tue, 13 Oct 2026 11:37:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
Message-ID: <as56X/w+CLUE2kQI@gsse-cloud1.jf.intel.com>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
 <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
 <ff266a33-2729-47b4-8a1e-ff96bb456782@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff266a33-2729-47b4-8a1e-ff96bb456782@suse.de>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cbad97-a6fc-4021-9026-08df29590459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|56012099006|4143699003|11063799006|261009221227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: fi2IDli428pLrM5Q7Z507Bfnw6XUBqkuNERyUCYp+oqsXcC/e6PbrFYOxMytYFJl+plEnmTj2xi4uQ+e5wJPZ+RK/axF6iuwuxPk6ZNqek4bqPX+st+IAOMhbX3B6Mx8J/8KHxBLZ3UZS8/mXNnXfSwkWnRMIB5XCLCQF57CPkhMTL/xKT/VQ6nKkHqU/5cpFmWoyVgNiUoKAc6oIFXpTWbL3o8pOA8W/8T8okJ/ckfndO2QDfjjtEE0UqKOi+4Pa/TFI9+X/BaWRfaggPO7uknfCfdXWx3v4pg+ynvAv4AOhjOCQy6LQlBYOIIyedv/N9O62++KFd2lGpq+gYJ6fM7ZJQ2JFSft1RkOoPYGN9ZHenLDw++0xpZp9U4bqG9yGbfSvYhEslYsFQ8F1xqKac2DMLi0Ia9su28Cb9jbIXYhCmNIPt0qEnoJRZgkixKdwerlNCqsLXC321oHKHvtOzcfLtp6+l6HK5P4aJbg02KAxedzfSl3LJUJyjuHGQT6Elm/2vZ46KpbImdQzwP8xU6KpzMj24EpM/9T8eN4kaXKKExmOnxsYiEuiRoqQIN7I/+bLB+T97/ECKPjyHHPWAqvvmr3sA+vXDi2WAZrD4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261009221227099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XgEQXW/4scwtMrxV6eS+2BUDRYXDmLALk+RNAI2BCT138Ky5QdJ8HDwwIQ?=
 =?iso-8859-1?Q?YK8/eHsFKEk0ef26c6q1Q4VPm09xEYC8ul5l34YMFCDZ5D5jAXKh9Kxt41?=
 =?iso-8859-1?Q?lZ0mYZvnAn7lWseXJ4vM3GzVH0vlgQyQxne60tPRS0uOUBqudOMAPaJm4N?=
 =?iso-8859-1?Q?Gg5Kr5+kuqLxE6KrQ/S08L6bpOgQQyYEY1QYrLdhpEMcnKOPRfiwhBr7hj?=
 =?iso-8859-1?Q?fwoFEY6wLbj6aYYFKJeGE2jTzNvct2EzaHHuFsnUADzZwAdXx6kAQdgq+1?=
 =?iso-8859-1?Q?X26eXQqRcpakpIubbW0cv852lZCJzk9O1CVUYsZtRvVuUoZExSEkkI0Uq9?=
 =?iso-8859-1?Q?wOuwg4dNvTLL4PGdHnz/7K1eg1iErr6yI7ZyiFxM9TwjUNptF1an9m8KNH?=
 =?iso-8859-1?Q?6kJyhf4X+PbInRBHEiFLjCmlYW72YYWrYlUmmooRYZh69Em7BFtwQPLEcm?=
 =?iso-8859-1?Q?hnNoNQKa9qzcpQ25BpGbOk/4E+LYDf692raP/B5gG2iVZwPj8NrOUr+3Fv?=
 =?iso-8859-1?Q?kE0QGeGEBdV5N/iBWyMaOwAhg4xfFr3A5APlnAfhlV4y37u2awvCvUKynt?=
 =?iso-8859-1?Q?U9HKwoU10rvA7IRReH6KHyyNfBf5fk0XDGvIceLdHJFqhRSeeZfqaZ2Rva?=
 =?iso-8859-1?Q?hHtYtzilkxgRzU7dYVzufIlI9+7bej8ZA/bQn2HKJf44tH6ur9cMOniqB+?=
 =?iso-8859-1?Q?4h8rk4yhKCuV8I+RNceWdW5EKkUuMiGF7YbRiUslKTG/q7ADR7wP4TpkEn?=
 =?iso-8859-1?Q?DIW2wftDlPk5O3/Q+fjFPjaQG+xYDB5CjEMkmzbgXHxzNNR+trQ0CcrC1+?=
 =?iso-8859-1?Q?8yeYYYwMrCev6YxGrHmlKTAix9WMkVOK2AfVscYCrnhGFMem8NHBay+DU3?=
 =?iso-8859-1?Q?dPw07ImqbjVRc2pZfWDmPFGojVtaqNF9hN1O6rlbqekl+kof1jUVOhYsIn?=
 =?iso-8859-1?Q?yt8WrovaghGSlqiPG/6HR1I/joufnQWO/bEzVJTlaNSVcLy9PpwQTMfgZH?=
 =?iso-8859-1?Q?RtQMw6XPTQ5IRr6mqNNONKbvbWyKwvPUVsrusccojbhvCdY46JLN3EX/FB?=
 =?iso-8859-1?Q?Lkk+md1dRajId5pUwI8Ob5oI7COy7ULQdBdKnSpjmOPz+B5zjAVvpPQvB7?=
 =?iso-8859-1?Q?K01/aj0hRTcnZA0SxsN5sdCxPqgygF62JhPL+cr7C69IWjnBp3A61pKtgP?=
 =?iso-8859-1?Q?9nZcCsVufuQm8wVgoAiubtfB0J8Ihm8lRE1JvZX5mFiCSc+5JS5S4YZgQ9?=
 =?iso-8859-1?Q?/W0h7F5fp9SUM2PlonOcP5pX7939JcnObklhwmh6i2MaZEbtRhSHjtkJEu?=
 =?iso-8859-1?Q?Ci2JM+gwM3+MsixoA53gqBHLQQv+LppED4GE5ruji+bwoH5sgAp1gdIAOt?=
 =?iso-8859-1?Q?Quov3v7GfTbVz7wTlQh78whVd3h8CYtBUT4vjhcyn75QgMDfLilzYtfhhT?=
 =?iso-8859-1?Q?NiGqQGV9pgOqWW92VJPKZqljq3+RWdItk4stLv8FQAB9Ofk5tW9RL2Pq0a?=
 =?iso-8859-1?Q?uDu/GnFM0PVxFWbGeo6KK5MWzQ6XhnRLkYO7Ilm8vBCb3qcTSuLp9EWaKw?=
 =?iso-8859-1?Q?FMs7BRHIKhUIMcsiI3AMvSQgC9PVySpTyNSyv2YxhXtQrHL+Vt/W1ZeebW?=
 =?iso-8859-1?Q?kINclDBNm3bg06pP6oEi1TWRpfrri9otTD1vlVhyCCoN+20qLLCcq2/epF?=
 =?iso-8859-1?Q?DyycTdWvL9KHPGueczB4S8Za36nSi9ZJJIi0QPjnrIfMMv0VQwBLiSZlqt?=
 =?iso-8859-1?Q?53t6BjugV+9cMkHnHMGGpla8htnzKjyxACblEkT5Uq7qdRFJG/k8QH+2RV?=
 =?iso-8859-1?Q?EVAnbdx/8POTYcQyu8lvw7dqiDmDimE=3D?=
X-Exchange-RoutingPolicyChecked: E1m+Ll8tffwWolj6vh5gvvhtxVNyAJNYqR6/4HDk917+C9X97P1prGS/BYNE0EfdxxDeOFy+/fLF7ddackPXkVubnTeNXVBCyMKuM+QLCIqg2LTbX/Ir+VMxOuraEFw10Skuy3rRzxzDGefm/mbMUP88vyC1KhraQjO/qHU22gUjO9OpmVqrXRnVkPzF6Vr+R4auhbELZiYzWOc/vI+3ApNZu6YZ28zv+4RTMx6AlJkTwQtcH9DjLrO8Kr02yEopn2HUwK7l/lGKaJ83EkMWq//+7CGVVo24RWYZsSmVmQiAHWzrkIEcZu0e2CsZUrMETBi4SdeayhoFS+KYeKbIfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cbad97-a6fc-4021-9026-08df29590459
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:37:22.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdqrlznQ3GwMe0snh0/OivZV9Kx4urRh3cf+A9mh76zOW7aw/ENWV6PJzXdU+hMP9nftpDS5U0xp2yJB8nEdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
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

On Tue, Oct 13, 2026 at 09:17:53AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.10.26 um 03:36 schrieb Matthew Brost:
> > On Mon, Oct 12, 2026 at 06:06:15PM -0700, Niranjana Vishwanathapura wrote:
> > > drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
> > > the core PRIME self-import check. Its only caller, the shmem importer,
> > > then repeats the dma_buf->priv lookup and the reference get.
> > > 
> > > Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
> > > drm_gem_prime_self_import() that returns the backing GEM object -- with
> > > a reference taken -- for a core-PRIME self-export, or NULL otherwise.
> > > This consolidates self-import handling onto drm_gem_prime_self_import()
> > > and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.
> > > 
> > > Unlike the removed predicate, the helper takes a reference on the
> > > returned object; the sole caller already wanted the referenced object.
> > > 
> > > Assisted-by: GitHub-Copilot:claude-opus-4.8
> > Assisted-by: LLM
> > 
> > I was going to suggest this last rev too as I noticed
> > drm_gem_shmem_prime_import_no_map called
> > drm_gem_is_prime_exported_dma_buf which should prefer the new helper but
> > shmem couldn't look at drm_gem_prime_dmabuf_ops.
> > 
> > This is a good cleanup:
> 
> No it's not. Please see my reply to the cover letter.
> 

Ok, I can't say I agree, but I'm not going to die on this hill. Still,
here's my two cents.

I'm not sure I agree that comparing a vfunc is a hack, but let's assume
it is. Is it better to have four drivers plus two cases in DRM core all
open-coding this logic, or to consolidate it in a single place so that
if we find a better approach later, we have a central point where it can
be changed?

To me, the answer is obvious, but again, I'm fine with ignoring this.

Matt

> Best regards
> Thomas
> 
> > 
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > > Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> > > ---
> > >   drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
> > >   drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
> > >   include/drm/drm_prime.h                |  4 ++--
> > >   3 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > index d654a22a30de..a0e161f2333e 100644
> > > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > @@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
> > >   	size_t size;
> > >   	int ret;
> > > -	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
> > > -		/*
> > > -		 * Importing dmabuf exported from our own gem increases
> > > -		 * refcount on gem itself instead of f_count of dmabuf.
> > > -		 */
> > > -		obj = dma_buf->priv;
> > > -		drm_gem_object_get(obj);
> > > +	/*
> > > +	 * Importing a dmabuf exported from our own gem increases the refcount
> > > +	 * on the gem itself instead of the f_count of the dmabuf.
> > > +	 */
> > > +	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
> > > +	if (obj)
> > >   		return obj;
> > > -	}
> > >   	attach = dma_buf_attach(dma_buf, dev->dev);
> > >   	if (IS_ERR(attach))
> > > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > > index 588910c250b8..275c5661528d 100644
> > > --- a/drivers/gpu/drm/drm_prime.c
> > > +++ b/drivers/gpu/drm/drm_prime.c
> > > @@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
> > >   /**
> > > - * drm_gem_is_prime_exported_dma_buf -
> > > - * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
> > > + * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
> > >    * @dev: drm_device to check against
> > >    * @dma_buf: dma-buf object to import
> > >    *
> > > - * Return: true if the DMA-BUF was exported from a GEM object belonging
> > > - * to @dev, false otherwise.
> > > + * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
> > > + * the core PRIME dma-buf ops, return that GEM object with an extra reference
> > > + * taken, so a self-import reuses the GEM object instead of referencing the
> > > + * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
> > > + * ops; such drivers call drm_gem_prime_self_import() with their own ops.
> > > + *
> > > + * The returned object carries a reference the caller must drop with
> > > + * drm_gem_object_put().
> > > + *
> > > + * Return: the referenced GEM object on self-import, or NULL otherwise.
> > >    */
> > > -
> > > -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
> > > -				       struct dma_buf *dma_buf)
> > > +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
> > > +						    struct dma_buf *dma_buf)
> > >   {
> > > -	struct drm_gem_object *obj = dma_buf->priv;
> > > -
> > > -	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
> > > +	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
> > >   }
> > > -EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
> > > +EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
> > >   /**
> > >    * drm_gem_prime_import_dev - core implementation of the import callback
> > > diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> > > index d378404f8ab4..02665205aed1 100644
> > > --- a/include/drm/drm_prime.h
> > > +++ b/include/drm/drm_prime.h
> > > @@ -101,8 +101,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
> > >   unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
> > >   /* helper functions for importing */
> > > -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
> > > -				       struct dma_buf *dma_buf);
> > > +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
> > > +						    struct dma_buf *dma_buf);
> > >   struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
> > >   						struct dma_buf *dma_buf,
> > > -- 
> > > 2.43.0
> > > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
> 
> 
