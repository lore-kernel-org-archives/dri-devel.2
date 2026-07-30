Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32415C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 22:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA0C10F0C3;
	Thu, 30 Jul 2026 22:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d+IhiMpM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C1610F0BB;
 Thu, 30 Jul 2026 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785449149; x=1816985149;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nyCMd9suCIJWJBLQobclQ4hbQCdZXFrgwtUK3MHyb8E=;
 b=d+IhiMpMHp7OeN7YTb26KEUuAW8JMFAjfgtV5H2oPA26cs2FWSCdCFF6
 jnTFvxxnfQ3RoHp9JQlCBMSobmD/HrANqXAzs+kcodFskeOzIuiU4Gnql
 NWBvtkcyA7OVfaDXAODOcM/xmFHbvK0IkXYkiHnuB31gniv86Gqsy94rh
 GtR2re4gUv4qmiVncUkKHSUQnkIHzluvAmbJq2rZj0CLQQ1p1/wsJ+CGM
 dmm3p5XY7+Su0US69Aydx2iJ9rdlMZFXs8rfhNQtgcV4MNxaZpgqbOLYk
 CTsq3NL22+XcO7zKVX2+dtHa9X/epW/jSSVx8h91uPrLDqf9xvZ9wssW0 g==;
X-CSE-ConnectionGUID: 2/dSl14eTzCP7t8cp/k2Lg==
X-CSE-MsgGUID: tPUjnfSoSPu0I1goWTv0ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108869874"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="108869874"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 15:05:49 -0700
X-CSE-ConnectionGUID: 4v0NCDMoRG2pkzwLCwBGgA==
X-CSE-MsgGUID: yo4/89nXSGWdwBw+KkaExw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="283749637"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 15:05:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 15:05:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 15:05:47 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 15:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFuzGnzc5Mukhsg4drgqNDYJPQ3X2kVqQV8LM4KyhszrPHfe8dE+8YIoW/P/sl1h+YloYyL320pkvQWNWl6Q8Ajb594Vd5GmR6Bo1JinBzxqhrvVJGTNUP0em03kWvgLuBp1yhN/eAZBT1GeZvbRTeaIYHtvduvalpfEMm9jJvmAcTrKwSxBJO1nG3vBdnUubY2pJUfGikH2tLTs/HQia1HA7AnN+zYVgZYw8tt2WbL8bCHt/2YRtDGph4zot/viCNeD20MzNMmitB38x+Lkoo1qTuIlsSWXYzYOTu0EZjXPW8JM41VgjOtu38ItY399wPiBHEdqX1kDZnjRiBqzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAzuful1QOGfZS5BFlFirnuzhD4XdyHr9PXgP3BR03Y=;
 b=svL0/XKuELBX/WzHYs7mCeDUIxuttWHFrzCM/TTQ6B2Icf03yW7PW7SQ8WCEOWERnmTp0iH6UoVnS+6mzxdDauUGupaDpqrXcAWHZNNoMccZWeubp6iIxcPBzc7FiFKDgDgvGXmJi5fn2M5unX7q+HEGnkv491Z1ey5HyT3OOKCA0uD2aLZBjpEvCeMmC+ROmn1tYoUw1lTzvPhpYMbjbtnYzutp+GyPeM9L6q4UFKjk3bl8Iu0YVLirV3U0N2vto0JLfchH3wD6qMdGhxG6yQ3vbqKbhlp+T38Ogi0qiiwtB38KUuYhayYWBdzEDYAPRKRDPGGAFc4IDyl+fzz3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:05:45 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 22:05:44 +0000
Date: Thu, 30 Jul 2026 18:05:41 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jerome Tollet <jerome.tollet@gmail.com>
CC: <jani.nikula@linux.intel.com>, <ankit.k.nautiyal@intel.com>,
 <ville.syrjala@linux.intel.com>, <arun.r.murthy@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
Message-ID: <amvKtSAHUH2CBeCF@intel.com>
References: <20260730033607.17136-1-jerome.tollet@gmail.com>
 <20260730163123.32157-1-jerome.tollet@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260730163123.32157-1-jerome.tollet@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SJ0PR11MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 36358b41-16c7-48ce-3a6a-08deee86b415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fB7pyXkNiQci1BpIDgFr9luKR6EFj8d2S/jeAwT6XxvmYhFpvjHrJHML2ignbtIPnGstYCKVDdF9ZCe8WJyuBwwv4gy6iakHWEH2VQFhVmDnCBUUHwqmSwGgbROFp8QdBGItMchlsYWcUujQ1EIK93QDRr6nlFBxWnuX8FAZZ4KpR5P6W1mIBOL79dEOI/6pO413r2oNhpe5a1gQBE30wFMfbTjOnj6yyVt5iXDhxnlN8m9QyR+caIw8MQ8Y423XMgoOr0j1Lx3fFrBnJ0GeZ6tkrG4KcwnRZOWQZVl91xQKq5pRvGWwxS7H26pzmHwiA4NKXjKmnvZZvvSynBju/YhJ3NfVkzDDXifz5mlfu1Uio4l1HXYIyBxLb8O/S13w+gBgKFo1x+o6R2vC9yKsXEcDupmgXW62oLGCrM2tC5rD9mdb7DaHl+MOfzFy09TWbim9Z0Oq5adzIWK3ZbgKANCpzz598pBsKwEcjEQLjbpMTw7OWZpg4NPhyjzp9I/42FR814ECalSWhJMsx47wyurhtF/bVbt64rPr3Pq+Il5UdbAK4LE8d3vLKFWFKw+f+XzPXafDPVPNg3Z070XdltRh6hojMr9Aao+IP0+Hey94HgA1uib5tixcpAleBaL1QJpn87XuSNMdWJIIN9t8rGbwxInEfUt826VDbiHqRyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02ANurIEV7BeHL40zz+iOmNjmY5hsVK3ZXjWoVNzKQXMKfs7wIOsfz5E/yXG?=
 =?us-ascii?Q?gMgkcEHLBbQqJaY+OWbQO1xl0w4nvs1cbEt/1EcEW0A+jGkNZkDeLhTtz+Ss?=
 =?us-ascii?Q?qM9/KXqfx/Q1ScbG+zoVRXj0+tO95FC0o5Wqz3KF2Nd3W1P8H2Dwr05qJVsy?=
 =?us-ascii?Q?gCVAus+86gDWkm/H7h7G+N7vvaOovvVU7uUvmPyE5zOpdVKWp3r3ztKdFSrG?=
 =?us-ascii?Q?isOFEgzez89uY0zWVdArKBKzq29L0zfeN6Bkn0v+0iuFJeGtL641eI+xw9SO?=
 =?us-ascii?Q?2+yCh6ff4E1ChB2Ku7f5ec9z6nkqXPUcYrZLfcZyTQl3ioIoUo5Zwe9iREKL?=
 =?us-ascii?Q?C1wLONf9GWPGamykSJ9jJ5+KyWv56RyfqTA6D1byzaXaBuS8KlNHBDS7VkiI?=
 =?us-ascii?Q?+ZSMOa5g3pl+efP55ZgVaNOr91v8stgz8PyXBzyyqzz4D41eknRiBg/oz5Ap?=
 =?us-ascii?Q?99sKDeCDy16CX1p9yLid9aVjqxPZeZGL27o4/CO2ju65J/a820qxi6+AGER3?=
 =?us-ascii?Q?WfN3UheYFyDm2acF1wz0ZfpCDhXw7Z/nLgcRTvHEsYttVSutNj81bP0JxKM3?=
 =?us-ascii?Q?ROPCRrpRxi5xliDH0n0r8y9k+vB6akjFotjB4Rloz4VpoYDzVLmwi+GOV5Vc?=
 =?us-ascii?Q?C8uMo8invRUr83gG5UkVkBM+PcBpE+p2guxLl8ko7au3fytwJgtV8/26oJ3Z?=
 =?us-ascii?Q?7mQqCgut2c79b1am7zI2q/AUTYLkR/jQE2/j188SaJKkO7bnl8oE86UILeTm?=
 =?us-ascii?Q?JhGAaa4uU3JXl1yPL5QvsoRUC68JJH/3WS1/TibE0jHM/Vjq+VrjLZa+xMHE?=
 =?us-ascii?Q?EXeABq9X7N2CWakTm60KviP09wVHQX9ALS95ToAhzVIGd4jVUTeARr34LOnh?=
 =?us-ascii?Q?of/mMBFtZUvdq+iszvIIl56FdRRB7trbSLLyYw+JifKasdJPRx+QFCJfc20M?=
 =?us-ascii?Q?U+gPhd9zUJtaBHfkYm3yVIiKVwPAM1N/0g71wuvid5UhWVg43/PxOXMjGnes?=
 =?us-ascii?Q?0FSY8TmpXvM9g+89RL3uRGO7XPxuDRlEHYY9N58hfdrk6efK6ei/NtWZwcmM?=
 =?us-ascii?Q?CNWYwvZvZV08i91/KV+S6yQP7WTkCWC4EZ2qXsVDqsRN+RZtw+im9Ga5FBQb?=
 =?us-ascii?Q?ErEtuTW78t3GldXkRtki1s/aiBoFpCn6UH4Iy62gCJS/KlHs+IE00a5pFSsM?=
 =?us-ascii?Q?1lvIfoE3XwxVoBImzsYapJnRhVfsEOEdSWvPPkAHDm5lR59DUC/pxHieAapr?=
 =?us-ascii?Q?Q5r/e/WCdEj/9qpSpOem0WhFHZFwQExgAncGfmoujQmOmBkD7UvbZbdZCZx4?=
 =?us-ascii?Q?AHNMYwzX641MvemkMBBwXUEn1Tco80AMG3surPQWNSJxmlZ0YTJ0FhJbPWNj?=
 =?us-ascii?Q?Xse05WBAsyabsRvZsFFufq8/TTcLRbOO4LF8lWb3FRqJSf711GnfDQ/Pi6fZ?=
 =?us-ascii?Q?D79PmzD/mLSDJeOWrG5PZyczGjmGeNtiIEL5wCjEC/YFKUdfj0NA6MaWMpu3?=
 =?us-ascii?Q?SzsMStQAmPNnNflKRSl7b+7wtIluNSCpM2j/HvKeCTsBO0mJwnz6nqO6ZLOF?=
 =?us-ascii?Q?/NiUMza3e18LAYGhuCH3mERj3cJESsowMZS2R/WVWjQwJJbt5+4chFgj83Pi?=
 =?us-ascii?Q?iPw5i3cqY4Y7T+6EJl9+AcAwMbKLpjNlUj3VtX4btXrjMG0uuxHzz+vr5Xci?=
 =?us-ascii?Q?acn00IRniSB2DFqr3Zz1HegB6yRWuudUFoI3MULLQFuEFMWzADqWforpuAVF?=
 =?us-ascii?Q?f9qUcMkzGg=3D=3D?=
X-Exchange-RoutingPolicyChecked: W5Jjppx6p+9KDm3mcz1pCHILvoKqQ5V9aorvZa7CO3SB0d1pVBNT3RbBf8rLj0CbICmyCXA0piMQgjRRxYukrFmly6napnikGYxxRNP5SPD0piqJr4o+NTG6cadxKx9Mq5yM2nFzYIFqLo0LP7zv0XLld0rZiA93CSfPrGEKKCQU47HhBffk9CTc4oFbMbqfMLd0P+t+fGzeuubCrdaMHarRbgA74KPKGZ3YkcOsxSUnt+QMLuk6MpY4c8G2iBv+Fn7Ue3DSv3JtCHr2eFIF69r93GoyH+YcjDpsGzBt+gGLgcmAbbGPGNfyqy5knZL3ySw7LruoL6HkvvZI+o8AcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36358b41-16c7-48ce-3a6a-08deee86b415
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 22:05:44.9318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arZdZCwIg+wpreyApL20TFpKRUYdo1KKQaEjXGb2mEwPwOull+Gzg7ANycdcg2VDIwpOSEQjJ8ctPek2czNtzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
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

On Thu, Jul 30, 2026 at 06:31:23PM +0200, Jerome Tollet wrote:
> Hi Rodrigo,
> 
> Yes, I agree that this is the appropriate Fixes tag:
> 
> Fixes: 15953637886d ("drm/i915: enable scrambling")
> 
> Thank you very much for picking this up for v7.2.

Thank you for the patch and for the heads up.
It is already in today's pull request towards drm-fixes
for 7.2-rc6

Thanks,
Rodrigo.

> 
> Best regards,
> Jerome
