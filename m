Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D76CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F31F10E4F6;
	Mon, 12 Oct 2026 19:46:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990AA10E4F6;
 Mon, 12 Oct 2026 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791834389; x=1823370389;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Bp1cjQI2G2zGM6kJl8qVPW15Ho+NAWgc/ZZWzK6JTLo=;
 b=QSA9J+uOnDkdTtp4xG6yKI8Voc5oJMw8AZN0ozB6FiWYFKBWpuNltioR
 PN3SN/1joWvcw4B17gkUo3+HJHxq7o2uEXyTTzNDKQbdTotEsNWsFZ1v8
 QCHBr1g45H2SEIeFqLUpUUGQCkH+7LiIXN3xMvMUx+VTRTqppzFVreZlX
 dGDIhDjRywUoti1Sf6s7BLr1aAMnH+xt0Iv8CXYLL7aEC3QzFUPf3fVVA
 aKVCFzD1ZFUajzEMox01b41+4N67oDPY7eQDOW+7ceszy6RVt6ObqgKy9
 Mnl4gcoSYzqKeL9hR/XFkPGW4zQ4bzDd8wLbOa6Xg/NhIY99nSF5HRpok w==;
X-CSE-ConnectionGUID: x5Ys0UqVS/iVyKv+hQnvPw==
X-CSE-MsgGUID: SFdh8VnpSFOxIu47WVoSSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="435963"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="435963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 12:46:28 -0700
X-CSE-ConnectionGUID: eE49OXTQS5mhiVDV0Bl/dA==
X-CSE-MsgGUID: tETE5sHSRAewJEIzE79MyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1091479"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 12:46:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 12:46:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 12:46:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 12:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1lIjbVPim3LNANl9m//AxZn1LUH6CcJcjGxs9qqe35UsreSRsaOlbjE4akPziEi8L9EH9ke1K3C4LGizFm5kDIcbg/KQuSWizMhWl+8yFL1MdpNNwU0uJD4Hyjt2LpFsYjWFkSlSMg/Hu4vsJwR1RYisMRwwdJ7Ct1Ka9mWcgi8c0zxkPh7pNEkujQtgMYNUK1cPtFTWzUP8cg8p0q20+2aIOKfo03V9xnNhvlRSS1aTMkWh851yejAck3ElTUzsRBgzxdx2h00CS6Yi9S9CQ0RuELonpCvvWfmyJsSt4+jXAb3hd0LETE77c/TJn32uCIj0C49JqOsuUW2LP3HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXFLtctUL3rmj6wngyHxrs84N4+LP0xyHP299DzUD5k=;
 b=D3bf/3WNE/Ehh7qnpTs+9opG6hsOqF4nZYVxq2Ijp8aPnZFVWbz3YImjNRBBk2VBz6jgHIHTaf+MMpdRlo4t1ydRVcV6ISJBmwa6RnfBSW8sCzLbea7Oqg3/t/tKCq0f5lzmSgKohBMOf5AbKrKXsR2bJEZHlyv3yWSR78QCXVq3BfddwYZo/XdlGRt/5K+v2X6eKzPKoZuDz1uNjMcZsQhLnpdwEeqjME/71PD2gwcMvbzshHqHRs4JTdsPuDCt6/Kg5gKzfRgAw38h71rKjZxs2BlVfG5owhIZMs5m/spcc1745Pc4HS4wWgFcEkrxoJX1zWz5FEUYqsBcH5ejhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 19:46:25 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 19:46:24 +0000
Date: Mon, 12 Oct 2026 15:46:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Guillaume Tucker <gtucker@gtucker.io>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Mallesh
 Koujalagi" <mallesh.koujalagi@intel.com>, Badal Nilawar
 <badal.nilawar@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Riana Tauro <riana.tauro@intel.com>, Stuart Summers
 <stuart.summers@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/log: fix documentation title levels
Message-ID: <as05AF81CNjbCEas@intel.com>
References: <2320050536ca29afe69ecd163eb974a40df571fc.1791740369.git.gtucker@gtucker.io>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2320050536ca29afe69ecd163eb974a40df571fc.1791740369.git.gtucker@gtucker.io>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b21ef9-ebcc-45b8-b7f9-08df28997f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 5cWTBdK6aL0BnVje9ol5LI5Qpjt6qTH6K+lWH6BN/qROvIDBcOXUvMrkIjMBbXoIaT4V5T/hQ3hvUaGwbWZLUkY1MrucdhipvC9BA399BwsAZ16nso3iDjAbmN/PWj+7kPSkkkzLlRB/skvgWZnJf+IWncdzVAGXScsfTntUXsJOwla7dri2uL1x+MP6yQuTvcj45/Wfj1qRi3OP4rfFfmRVgK+F5UbEOKz9RAPA8eVKfQDKVfOKh3EY/PwTY3yeacu+xfoY8H9DMrquPShwjLu5ZYAYFMqBP38s5dbNC/aOYN348k+WC9j6NAvDIgVfr9hFGyt6jNnk0Sx/hxu/3i0KIl+zZVdqyMfaH1eZXlgWl3OtqJ3OQjImYPGU5OaQzkXf5xXMvZNqlJoi3KPcgm9ztb3Y31WGwQhqrB/+NCXZKu+/JHOTWe6nOFRjRRlLu604dYdlkYGqQ+pFp2uhkd7gn/+2rlgf2dFAQd/FUgm54EEXlY6G2YfbwzUC+5l/kkQpeQo9rlqbfushccFPtYzxTYQ1LyTuzdGWB66pvImjzGLnDnVPDLkOLm0EEVxQFuCDkYcngrqbobpwrTgLaNWmK6kUIGFkkzHtQqqyIzfmPued+AHqln9viv1blogPR7RdzRmUiOW6Qboh/hJEz+cxsmDwujHefIz4n/s+kCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2zIwTQOFRm70UU2aR9J9mwIDa9ImYL02wr+cn57+QmC7ozcS0tUeiufAKi1?=
 =?us-ascii?Q?0hDSuoE6fylWLBtw7lpain7eETiTKz0tXWp3maIhGh25US4S1ZLUx85NxuVs?=
 =?us-ascii?Q?qEMdL75QyN5YtpiZTfIaFybq9I6qxRZhotv2yAyzZzgc5JapurV8Esk7Zb2/?=
 =?us-ascii?Q?/Lv+1VyerDEAghuD3gpcODI/YXhxEcbnWyvB4RPdb6wF0pMYtkoFrdl7JrHl?=
 =?us-ascii?Q?J70K3t1gcYOUikR+kt1NemOd2QxN8dbhoCzYGoSOtaEMObt9+7+jGXafEs+U?=
 =?us-ascii?Q?HDUxT1Ja70GMHEplKwNZYCdVxowxJ4BfqjrrYj4b6m7o/8oN9FeFSA4bwtbf?=
 =?us-ascii?Q?ZU5xogDxP78Jy/6mnAzq/2ST173rGU/lEtKhgsvyfpbZeku++rSWCurGQWUd?=
 =?us-ascii?Q?ZGq84cj6GdP2aJfZ46se0RDc+L9fKTJ2SxJWJtFtgbFXg4FjLqjmz6UEkklR?=
 =?us-ascii?Q?U0diEH7rMRjTCNlGAATuvSbtSI0bO1NYfslgLquoxrkWzE1An8RJhYhoKE0s?=
 =?us-ascii?Q?KPWTyIAvDGJdJL/oI+Si0xj3yYhIJFypN5nNlcMyBRUgDZQl9pFZS1htd+OA?=
 =?us-ascii?Q?aTHvPnuY9/A5pHQBicqLt7H7wsTVqbzXOM0kq2xFCpLqQJrc8ZcyJ+i9FyQk?=
 =?us-ascii?Q?IDDlfDb12sw9v7eUC0OKArqa1g9EFuUqD3kIyQiLbxhikfUO4+Yciyr2gb56?=
 =?us-ascii?Q?O9WNMfKIa0ILwRxDEM9xX4qrVUs66wAOfBIgTLPvTxjLw+riJ7cs6o2IKlge?=
 =?us-ascii?Q?FReFth1uTGrT9/1uNJz7UyVtXl1O56cEQRhiJxjEI6HOYVQNlMQEn9tCUkLJ?=
 =?us-ascii?Q?E8m0OIqLus77SdPvRfVjMhvrvGBT8OBL+ve1k0CTIIrrTLquYyjWQVrvJOKM?=
 =?us-ascii?Q?AG4rSK1wYhSkVu0xrleXPwKOwV0InRDZGkpPUsDZhkWnPyBYCoN5XPNnUlH7?=
 =?us-ascii?Q?ncmbUbHoEm6gjn2WNPJjJziA9Nt1oVzTuZYo77mNW6s9r+9AEvG4yBzoviNQ?=
 =?us-ascii?Q?W6wt3ozp6zWkZm8PHqyGkUVZ1xBkoga7NWtCl9Xrp//ywvH43WDnMbJFR3IV?=
 =?us-ascii?Q?XdJ6VK0evAAEQFOWixJ2s0ZMfjtP30yqs2fHnZAAg41uPWT8+wSEOX0m5Unk?=
 =?us-ascii?Q?+VYcsLRAcccmWm7PHUGABKDUOVhB/GXb9DXgHh+aKjd8kTgwuTNIb5OBfAks?=
 =?us-ascii?Q?7jwQXgwhzf11p5X/hOeE2FWljyColM2XWRXDXE5iiZyk2UKb+tjSrb/6TUPO?=
 =?us-ascii?Q?XMMq0I95nrXUMtiPUKnNpYcx2SjjTmIR8x6xflsKJUREiyd3ijwLk59XqFhf?=
 =?us-ascii?Q?YiBJ2U1Q1LqQB5eukLry58AA1IGRDCpD2qjRwFg/ls9T2PQR3we81CXlCXFT?=
 =?us-ascii?Q?BgKwVRdW9yBM5xP3jXySWqh3RKLZMpf4m9oCRRasvrbjeMc7FCvPYtjrb6De?=
 =?us-ascii?Q?MybOrSpe813voM40EmGLKxgZAGsUMvD1v6b5rncp613+LKMyEgnSPjLguKr3?=
 =?us-ascii?Q?T4CN8TKn+OYaHZSjrq4Znkp37cMLgd/rx6kWJugLVw2Erth94NwkLeHnIeLs?=
 =?us-ascii?Q?v/7XF4gnfUExdGvPH+XkoMwgHSZIm+9x34Fmfr7e9oA+fwd4RwxG9we9WxAs?=
 =?us-ascii?Q?G3ffJtbfwDUebd0I3Fuis5TIfPzXrS0q+Y3+8JOArEy2Hss71MQTtwILra7m?=
 =?us-ascii?Q?w+JWnNA44S/8+ffZjMhNWC2leDemoogMblE+AKe9zdO4WlxPASPT3T/BZzgj?=
 =?us-ascii?Q?lnyTypxW0w=3D=3D?=
X-Exchange-RoutingPolicyChecked: GaCwEqM3sv6Pqo0lMmcUgftj6yYeAwWB5URDVAvFxj0L8CR6OidjISU8InWYj+GqAUsTElrhaaMhOryqI4+E0x0CX224lMt005dDUXK6AbKBy5CUPmtNM7dPXAkY1GjvHWMve0CBviUnrNlqVyN+0dSCxy0Hwq13XQsFx18nC/dICwIGqo4bzIvTiWZ5gc3SwXzpfvS8SzdnbkoK6Akp5s+y889fAiIZ7ZH7z9j23ZqvOBLn1fZaoXYte2e0Sdh0aN6wK8SUZnEE71y+TBez9DF7As9HkhxEQhdinKIszjempnQvtC5PykK9OKPKp4PG+aXO9gy2ZutQdFp93o2++w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b21ef9-ebcc-45b8-b7f9-08df28997f4c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:46:24.6060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OM+RMslPe57VULYGZ6LInWuyT0O0MoxR/iJzFoew1omWxj2xKejGDdskIt9gJ17d+SFaNUacMPhKdBKzjwrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
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

On Sun, Oct 11, 2026 at 07:46:53PM +0200, Guillaume Tucker wrote:
> Fix an htmldocs build error in the gpu/xe section by moving all the
> titles one level higher in the Xe SIGID page to keep a consistent
> hierarchy.  This is the error message:
> 
>     Documentation/gpu/xe/xe_sigid.rst:10: (SEVERE/4) Title level inconsistent:
> 
> All the other pages in the xe section use <h2> titles so follow the
> same convention here as well.

it looks like we have more stuff to fix in the xe_migrate.c still...

thanks for this patch.
pushed to drm-xe-next

> 
> Signed-off-by: Guillaume Tucker <gtucker@gtucker.io>
> ---
>  drivers/gpu/drm/xe/abi/xe_sigid_abi.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/abi/xe_sigid_abi.h b/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
> index 2f3440505f69..277b15fce9cc 100644
> --- a/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
> +++ b/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
> @@ -10,14 +10,14 @@
>   * DOC: Xe Error Signatures (SIGID)
>   *
>   * What SIGID stands for
> - * ---------------------
> + * =====================
>   *
>   * SIGID is short for *Signature Identifier*. It is a small, stable integer
>   * that names one of the *recognised fault sites* -- nothing more. It is the
>   * primary handle used for triage and maps directly to a specific report site.
>   *
>   * Numbering
> - * ---------
> + * =========
>   *
>   * SIGIDs are a single flat list numbered sequentially within the assigned range,
>   * in the order the fault sites were introduced. Values are stable: once assigned
> @@ -25,7 +25,7 @@
>   * SIGID value is deprecated in place, never re-purposed.
>   *
>   * Why this exists
> - * ---------------
> + * ===============
>   *
>   * Today the driver reports faults with ad-hoc ``xe_err()`` / ``xe_gt_err()``
>   * strings that have no stable shape. That is fine for a human reading dmesg,
> @@ -37,7 +37,7 @@
>   * firmware versions, and (eventually) across other Intel devices in a node.
>   *
>   * What a SIGID is not
> - * -------------------
> + * ===================
>   *
>   * SIGID deliberately does not encode the detailed reason or the outcome. Those
>   * are carried alongside it::
> @@ -51,7 +51,7 @@
>   * different severities depending on the instance and the recovery taken.
>   *
>   * When to use SIGID logging
> - * -------------------------
> + * =========================
>   *
>   * The xe_log_*() helpers are for these recognised fault sites only --
>   * important, operator-relevant faults and events. The driver's only job is to
> @@ -63,7 +63,7 @@
>   * those that correspond to a published fault site.
>   *
>   * SIGID log output (dmesg vs. the machine record)
> - * -----------------------------------------------
> + * ===============================================
>   *
>   * The dmesg line stays close to a normal xe error message so it remains
>   * readable for admins; the only stable, machine-matchable token on it is
> @@ -74,7 +74,7 @@
>   * carrying the same SIGID (generation is a planned follow-up).
>   *
>   * How to pick a SIGID (the uniqueness rule)
> - * -----------------------------------------
> + * =========================================
>   *
>   * Pick per *report site*, not per incident. Each site emits the single most
>   * specific recognised SIGID *for that site* -- so the question is never
> @@ -95,7 +95,7 @@
>   * after making significant changes to the site that emits this SIGID.
>   *
>   * Scope: software vs hardware emitted signatures
> - * ----------------------------------------------
> + * ==============================================
>   *
>   * Some SIGID represents fault sites that the *driver itself* detects and
>   * reports from the software POV: probe abort, wedged, survivability, driver-
> -- 
> 2.47.3
> 
