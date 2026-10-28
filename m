Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800C606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G2/f6C1X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC1310E708;
	Wed, 28 Oct 2026 22:07:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8770210FE8E;
 Wed, 28 Oct 2026 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793225249; x=1824761249;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nms7+Rp5/x22HPOUSB8PJ9iPwGilg9yRVtfNy6JKxKQ=;
 b=G2/f6C1XpEII1zoRKJj53H2DY0mWDsDuOuyKibsDBfwghZq/7dWgUBjK
 ijS3s63hVkslk0+VFcsKeKiWSxA0Y1IAZY4+zrNqaTfVrDWwmLnFy0Ivz
 ZGNoAJmakHazzZVIypyAFBYWiJHrsCaUjFEF6+rEc45FdZHcALLQR25AY
 /OA6U4cO7ikWqOZw4FXkmEeF8484xfNa07y9T3YNvrfQch1Y6hoADGug0
 HZ2avQyn7cJCSVr0C1jHTfiulMOVXStAl3pCnU9CbHpTrH3T6K7qZSsyr
 r+FX+nlCxdHYrtwuCZDesEId/3Ou6CLxWBfSALZN9Rdgtssvf+GAeGCCx g==;
X-CSE-ConnectionGUID: 0MSm7d5pTq2S90LjKbTPXw==
X-CSE-MsgGUID: ridCfUqZRPSEk5GrNVZReg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1843926"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1843926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 15:07:28 -0700
X-CSE-ConnectionGUID: GTVaDU2HQOexVGaFfEvnUg==
X-CSE-MsgGUID: Ytc6LZTGT8qXaFdhu22ywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4873822"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 15:07:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 15:07:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 15:07:27 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 15:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dny6e7FzEvQarJcRerChoNDcIQdmdguess4harZvjz2c6ZQssz4lJBJNYko+ORiSQAB7LuXpFhI3V1gYSgX3qzOyzH86nuO8dW4Rj1q5Upr110m/SiJL25zjFrO1t66gc1ng6MtD+KKptPZgZCMBA7Ey5G+JtdLSR/cDHUPS1fnUohFaxi4GZoFzib7xeS7UwLePhp1g0ZofN4lcOcjYIcTzUkQd7d7Q21Alw6MOL4CnT8D/jHLJgkaFJnJDEz1flqfKm3FJoXinpCVS49uWY1/oaV9yFIpkDEZWDeMMr60qSl7rfcWJ5Nc1qiZuEUgJVT6Tqx2eC41oWOVG70ROhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMm/m5VKXOsu0x/qyIX4PkVyuIQHTVEqvKbjhq81oPw=;
 b=ow4pEKEfaJ8NVJUiSRUVoYUkU6txXC78317mdc0vgPjMgQwPmtthLSVekXcGdIvNgdxlvoankJfpj8mBKGvjz6qg5TdSvt/R3BZEHJxie+jRTPEK2pvBZdRV7/l+PC0qUO6PSsXxAP191ivCfy7ktrYrHmMyiRy1ul/L4c9McVpL3M4cOQlLQbP+eNI1ORoss9rpu4hvoKIh8Z0WpJ7Gnds2ERit/OJsO8emZqyf8Ltpq+2nMOSEJCzDHmjnexlW9JgIrlf6Q/F1v9n8U7eJHBMQrzmdHbbRG1njSxTnLHeLSt6CCrjfKPDejDnuqcXXtIhUSqqtK/xhdShTvPbU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS6PR11MB701697.namprd11.prod.outlook.com (2603:10b6:8:4c6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:07:18 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 22:07:17 +0000
Date: Wed, 28 Oct 2026 15:07:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Natalie Vock <nat@pixelcluster.dev>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 2/3] drm/ttm: Allow skipping to the next priority in
 the bo LRU cursor
Message-ID: <auJyEzVcU0/MwSrp@gsse-cloud1.jf.intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-3-matthew.brost@intel.com>
 <21c4abe0-7923-436f-b35c-6e07e6342930@pixelcluster.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21c4abe0-7923-436f-b35c-6e07e6342930@pixelcluster.dev>
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS6PR11MB701697:EE_
X-MS-Office365-Filtering-Correlation-Id: d989b0ed-3f95-471c-7cd7-08df353fd450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261026140227099003|261028144727099003|5023799004|11063799006|261009221227099003|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|10067099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6EJL94OzRhaIQEeC1L6oA9bFZ6FoSR0cpn0R7rm6GzNQOGxBn+vuf+ajo350QW1AEYFHDHpVDUzfYO8VynLLKKV3A2F0aMOxvhJzXRzRTFSHiVsYecQf7P0HeQWLkMCY5NKDL8CFPLOo1+57wA/sGzA0tRfbXksz5IDkjgA5fa1U0JhpbDzch7eDuxth6+DzQ9Ae832dGORianRkuZxV2TluaJtEzz2CrAcMazUz2gYkeMK0/DbptnYGEtbZ8n8ibuCdwP1JS6gr3bkUmcjKdiazMkwasJYO8e0JrX384Ryvb6JDDJ06aeQQ2moKclK2+LLvoIebs7+M3PIs4GL20aZvg5TZnEMNeJlDwQ4RyAeve5hDZemu5DjkKTRc0DlCMLYLV+c3DdiSKTADfNGBrYNz1jmbi2shHho+MSGquPQ6lgqJIS6DUc30spwzS7hWlviCpTwQDseoljlyyNVtfAeJUe+kU9VurGGIywsl13s6LzfkAAhQBxpd1n9v0Px8Riprr1iyuUEdiAvPE9iJtf0c0hslFCnTu67hWQEQ1PGHao4nu4pEMmzu9kO74nQl55YP4FH/JI3ksRkuInoca5QFjWUty46HOZK5NEKeEeCqkT3F5DnWJSoHpWY6bxWlZ3gTDyl3V15UayWK5BE+n1FpnVdOI24q8sevaIRwvHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026140227099003)(261028144727099003)(5023799004)(11063799006)(261009221227099003)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzQGmQSKU/4h/SeV9B6/4cV/lenS6ydkDR6lXJ/DjcKBisXLP0OgjSnyODXv?=
 =?us-ascii?Q?XsGFG7NXlVh642yiyWDOMs7xx7vi0HDD/G6SNk1dU/5XsyPg+HQykVd0l7aZ?=
 =?us-ascii?Q?kf+zG97jCCjpaXhJfmH9/CHikm2vdgqzziVgWbR6uGOzw0KhkwNurSgVxfij?=
 =?us-ascii?Q?ZGv9lkoCBnxENFZlI9zL2yf2/J9MKs/RpKJpnMSSPk/BN/tQvhmgUbxblDbp?=
 =?us-ascii?Q?pLNWz/+xWEx27fPz8aKXAfJZbFHU+d5bMj4byMGmf1cMo7ZfnVVIxJufabjs?=
 =?us-ascii?Q?OiDAI/8sAAozU7Gsmc5QZKTdDBCqUOtTtUvzIFxs+93juRFzstLaLvXfUTea?=
 =?us-ascii?Q?vM1xwNVUFlpXP+vkGJmZnk/QmBxDXTSiMe7Z6VxvnawVgqp7WSiMa3m+UoPd?=
 =?us-ascii?Q?l5Lt7MgHhWCVUNP0LJPlLLSCbm9Fkq3E0IP0k6T+XvN004/uCg1xA5P+cVO9?=
 =?us-ascii?Q?CeusAdI+GMR3TPJcWvlGJ7R/lPt/vjCqg10DELYpGRKCJtZIXvmw4JfPSMko?=
 =?us-ascii?Q?dE6HvqTWoOEKFx1BiBlJuDiEskPNGKdiYdwvgYOuUzseaA10UWLP7fE2QLI1?=
 =?us-ascii?Q?zvcpGfpv5UyguBbSlViEkDo3cqfhuPvdy4RzP8XZHb4/GTMXeCn+6kyFOenN?=
 =?us-ascii?Q?CS5TXnCRN+IqNYPDmFCVXEubAyVYLBbELDbwUimfZ6I4RVHeN3KcTedYrtMe?=
 =?us-ascii?Q?T4tgxxYyDkVrwDuktrK7u7y70OGNaE8DuxUA1CdQTz4VeZrfZJzjhAIFp5sF?=
 =?us-ascii?Q?tazXi9xNQOtvUA2yLqy22n7fv1LIFLmQ9I/nKnObsJ2OMCyxX88NcdB4ekDG?=
 =?us-ascii?Q?JIKOR3Afmp5iRivHYoM6fQ+s3R3UVJHFIbyWSEj9mUBlA8E24jHt7MIfwtLL?=
 =?us-ascii?Q?n5HJee9ipFoPDR4HtMqYE4ga6tHNyuv7FB+bEbkQDjzimk9knB8w0ffvNUSP?=
 =?us-ascii?Q?BvwbQQghNJyMVrqEjeU5/Frr6YU2+zGvIetdmnaIveYKhFS7vCSdyGASiEuz?=
 =?us-ascii?Q?ylUiqPIh4e/djwF6yinlBzf4KqgIRB6TsgjZOG4CZS1hQThcb2WNCEOPrHEE?=
 =?us-ascii?Q?UGn/fXI/iScWsP0q4x2ub2VArI9mJS8zdZQIMynBS40NWYbSOmPrdxGS97Nn?=
 =?us-ascii?Q?kD8vwDnRtFxbsbjGAqUigSxmFTJgsmm2nfHlJ04dR2DPtSCm6NpVXnerVUqM?=
 =?us-ascii?Q?XaKXssRiPZ2YITpVZqiKEOdZQcgBpBVc0om7n4jeGaQTaLtggzqvjvdKyZ25?=
 =?us-ascii?Q?yBN4GbUBpUretqtJbFiR3h8HYmrzOwsUISzoxoGMtLIxpAH5Q1/FVblZ6AQ7?=
 =?us-ascii?Q?XJo+l8chgjH8wshbE3bCmkU7f7exMOtDobTuhSwWsXpc3PSjsJigmOPGhX0H?=
 =?us-ascii?Q?nZi8OpTALjdpV6aYiEBs6VpHVmD0CzVydvTDhIWl3NwbhsikeTLyI25Ci625?=
 =?us-ascii?Q?ZjEqqLGbWGJzrVXY2xELlQXokgcj8APeWzkzaq/uRAv5FhpOZW6PIKMhV2pf?=
 =?us-ascii?Q?FCmBdN3vIARTx+jmi+IpxvsZjbjjjEFpJc555DNM1w35HkOjPafHwDCnt/L+?=
 =?us-ascii?Q?2bIncR0p/NJsCOZmN82h4R5M4ytFsIkFocHUkmAPCj8Bir2bDKASHGu8K3Hn?=
 =?us-ascii?Q?aYMESznE/DE+egeOLfDzqTBDIiiQiighi4QlPwh4XoyAnuHJ1PaiAOSVZd1L?=
 =?us-ascii?Q?PqmP3LvV1Xf9XrAU/6ZQVPCYRJOUIt9HFTqvqevx6zD0qba4K6NANrFlHXcq?=
 =?us-ascii?Q?1YknuRxftgBbF7MotxtgGNIjsolYPtA=3D?=
X-Exchange-RoutingPolicyChecked: dNN0JDgTW6rU7SMtQLu0Ph1qh5o/DSO5V5mnDObpih68VIvrF0d/qqOAdSF1N0EpffJoLT8ee/efQpCVO+5Xa7hCen+Fxk5/qytqofGLV7+IL03rlaeazLj1l7p/hvXzFyAUyU2WfEZs0AoQdjeSqZrJHEHM/Ckrq2hNGqCU1N3cgS5KXhxu69V+Ef6p4r0DVHA/jVqp2eWv7dRBorXTv/3PAeVRZezauzbQKFAsxHLXjlZm7s1S2DeHATLfwEpcHX1GLt0uMaAgFF9UsejkvTrL6c9PovbI9udjPPbpvp0KLY+r2kAfJINiIYL6TENvMrxXth972UFXeU9xVeR2CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d989b0ed-3f95-471c-7cd7-08df353fd450
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:07:17.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ1tAZz2kGaQx0w3lY0kJnLcBOT4FNr/KP9ntKzos/tKcD0hG619g2uOmu/e1lxv9i3eg1vLPdTcavg1qlbvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB701697
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 12:33:51PM +0100, Natalie Vock wrote:
> Hi,
> 
> On 10/27/26 23:49, Matthew Brost wrote:
> > Drivers walking a manager's LRU with ttm_bo_lru_for_each_reserved_guarded()
> > may decide that the rest of the current priority isn't worth walking,
> > for example when the priority is roughly age ordered and the walk hit
> > a BO that is still too hot to evict. Today the only option is to stop
> > the walk altogether, which also gives up on the remaining priorities.
> > 
> > Add ttm_resource_manager_next_priority() to move a resource cursor to
> > the start of the next priority, and ttm_bo_lru_cursor_skip_priority()
> > to make the next ttm_bo_lru_cursor_next() use it.
> > 
> > While at it, stop incrementing the cursor priority past the last valid
> > priority once the iteration is done.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/ttm/ttm_bo_util.c  |  3 +++
> >  drivers/gpu/drm/ttm/ttm_resource.c | 35 ++++++++++++++++++++++++++----
> >  include/drm/ttm/ttm_bo.h           | 19 ++++++++++++++++
> >  include/drm/ttm/ttm_resource.h     |  2 ++
> >  4 files changed, 55 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index f9458a4d5a09..d626f014e61f 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -997,6 +997,9 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
> >  		if (first) {
> >  			res = ttm_resource_manager_first(&curs->res_curs);
> >  			first = false;
> > +		} else if (curs->skip_priority) {
> > +			res = ttm_resource_manager_next_priority(&curs->res_curs);
> > +			curs->skip_priority = false;
> >  		} else {
> >  			res = ttm_resource_manager_next(&curs->res_curs);
> >  		}
> > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> > index 4e6d3d658d85..e631507d7aa1 100644
> > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> > @@ -674,6 +674,17 @@ ttm_resource_cursor_check_bulk(struct ttm_resource_cursor *cursor,
> >  	}
> >  }
> >  
> > +static bool ttm_resource_cursor_next_priority(struct ttm_resource_cursor *cursor)
> > +{
> > +	if (cursor->priority + 1 >= TTM_MAX_BO_PRIORITY)
> > +		return false;
> > +
> > +	list_move(&cursor->hitch.link, &cursor->man->lru[++cursor->priority]);
> > +	ttm_resource_cursor_clear_bulk(cursor);
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * ttm_resource_manager_first() - Start iterating over the resources
> >   * of a resource manager
> > @@ -723,16 +734,32 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
> >  			}
> >  		}
> >  
> > -		if (++cursor->priority >= TTM_MAX_BO_PRIORITY)
> > +		if (!ttm_resource_cursor_next_priority(cursor))
> >  			break;
> > -
> > -		list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
> > -		ttm_resource_cursor_clear_bulk(cursor);
> >  	}
> >  
> >  	return NULL;
> >  }
> >  
> > +/**
> > + * ttm_resource_manager_next_priority() - Skip the rest of the current
> > + * priority and continue iterating at the next one
> > + * @cursor: cursor to record the position
> > + *
> > + * Return: the first resource of the next non-empty priority, or NULL if
> > + * there is none.
> > + */
> > +struct ttm_resource *
> > +ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor)
> > +{
> > +	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> > +
> > +	if (!ttm_resource_cursor_next_priority(cursor))
> > +		return NULL;
> > +
> > +	return ttm_resource_manager_next(cursor);
> > +}
> > +
> >  /**
> >   * ttm_lru_first_res_or_null() - Return the first resource on an lru list
> >   * @head: The list head of the lru list.
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 32791c4db2a9..2fc517dbf03d 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -507,10 +507,29 @@ struct ttm_bo_lru_cursor {
> >  	 * unlock before the next iteration or after loop exit.
> >  	 */
> >  	bool needs_unlock;
> > +	/**
> > +	 * @skip_priority: Continue at the next LRU priority on the next
> > +	 * iteration. See ttm_bo_lru_cursor_skip_priority().
> > +	 */
> > +	bool skip_priority;
> >  	/** @arg: Pointer to common BO LRU walk arguments. */
> >  	struct ttm_lru_walk_arg *arg;
> >  };
> >  
> > +/**
> > + * ttm_bo_lru_cursor_skip_priority() - Skip the rest of the current priority
> > + * @curs: The cursor.
> > + *
> > + * Make the next ttm_bo_lru_cursor_next() skip the remaining buffer objects
> > + * of the current LRU priority and continue at the next priority, for
> > + * example when the caller decides the rest of the priority isn't worth
> > + * walking.
> > + */
> > +static inline void ttm_bo_lru_cursor_skip_priority(struct ttm_bo_lru_cursor *curs)
> > +{
> > +	curs->skip_priority = true;
> 
> Hm. I wonder if you could instead call ttm_bo_lru_cursor_cleanup_bo() here and
> then increment the priority (with proper checks). Then the normal LRU iteration
> should also select the first item on the proper priority's LRU.
> 

I don't think that quite works but agree getting ride of the bool should
be doable.

I think we need to grab the lru spin lock here and move the hitch to end
of the priority band and the next call to __ttm_bo_lru_cursor_next
figures everything out with any modification or an extra bool.

Let me try this out.

Matt

> It sort of conflicts the other refactoring you did, but doing things this way
> avoids adding more boolean flags and complexity in __ttm_bo_lru_cursor_next
> (which I'm not a huge fan of).
> 
> Best,
> Natalie
> 
> > +}
> > +
> >  void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs);
> >  
> >  struct ttm_bo_lru_cursor *
> > diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> > index 714c533622c2..8cd70d1e5481 100644
> > --- a/include/drm/ttm/ttm_resource.h
> > +++ b/include/drm/ttm/ttm_resource.h
> > @@ -499,6 +499,8 @@ struct ttm_resource *
> >  ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
> >  struct ttm_resource *
> >  ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
> > +struct ttm_resource *
> > +ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor);
> >  
> >  struct ttm_resource *
> >  ttm_lru_first_res_or_null(struct list_head *head);
> 
