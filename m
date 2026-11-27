Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TJLNGgv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559DF112CC7;
	Fri, 27 Nov 2026 18:04:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80ED10E356;
 Fri, 27 Nov 2026 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802644; x=1827338644;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=U7Y169OGlbyrASJJ5XdbleuJbATF1PGf1aqKctI57Eg=;
 b=TJLNGgv/kRPzSko/aN4t7pks5GvGrnM5qkUIpk1AlxdzBVjAWMvdco0l
 TeZNpD+WshxjEW4VW2j8ULqXiwJ6clw00hdwmlAc/Fp55A3LExb6XsR22
 SNw58EaaNqleCkW9tJ3bkxS7RyiQmpisDlUGSjvVaQLtvNg67GnpRRGMx
 c4aS4Ya6kTs4GnmzR32ec3LyN2CmdBI7D+aVj8CGSFQafUsYkANlEzOHM
 XmRPWrlH/8pOz9XNnprvOhhzgY5c438MslSEM8fR0YS317eItuWSiWxEv
 NLKWTQPZa1CtxJz8gVuXbEOGuoeEpSzBP+7nj80g8jPZW6elaEi/DvLp/ Q==;
X-CSE-ConnectionGUID: 1Tf22oSnRNOjCvO8Um8tXA==
X-CSE-MsgGUID: D1F2aHD6RSeBFQROpaTTJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4715904"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4715904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:04:04 -0800
X-CSE-ConnectionGUID: UyEWrpGMQTC9Rh5ALlXzfg==
X-CSE-MsgGUID: uhI/Vau8RUuGEihJy4qkyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12356996"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:04:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:04:03 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:04:03 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:04:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1TAam6M8s3z2fx4q1pD9u4kNt+fCRlTuvaDH9ZgsE8bbqM8IAI2hdcK/uGmQKWeSxa5IBo9SDixu09ZqWyYI5/gLmmTmyGxgfLV0MzokBH85u5Bhcgh3lMSCxJFTkaMoWZuyioPgedmwaKG0RDLsjjI6FAGGyLaZPnfKSTwongGuSdeD3QKKFtFXxWoYYJjhd6RcjHM0jrfGga0wtEkd6xcHC8LSwxCVVnt5fdU/Msngw5IN/FSg3oyXnXVMf6CEhh61yXhZTwEPYY2a7KWEcVVNqS1TSxRjXlVBvXWaqMypnBDwlTE/wIfy0GtOIQUKp7/LpWE100S0JXhUMXh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9W9r5R54lQ5VOGkPXXk4GqLkFR0I/HCliNt41gZd3Q=;
 b=pifQMtrIxW502SWdmsNZmhL7T/oS7NkxrLFCe6er9M8CBA7zgzgqfQcU9TVjCUGWQ5/jKNShwxV+6s486yz9gsdcAZzGFT56V+xJNFw+h/ybqe+WBFJomaCxAFqQsv7WKoNgTBsFQEIHyE/I9kdSKMPifH660Qhwk0NEyYalhzWyA/TiwCu1NMTyWMNzL4Ewip0zcPUXsYgH20COdJ6iONWJa80E9469b1JFB8BfM4W1NNk0owPyBz+oHqyWKE5Z7ok3X66sFTW/wS2+yvDJcwYp/X9itgZICkCo7eXFJGBoQb5PWnvE/cH2kVbMnSXBpiGRk7c7gRFIFJr86ja8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:03:59 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:03:59 +0000
Date: Fri, 27 Nov 2026 13:03:55 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
Subject: Re: [PATCH v5 1/2] drm/ras: Add retired-pages node type
Message-ID: <awnGC-XJY8aDbsyf@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
 <20261125190249.156217-5-rodrigo.vivi@intel.com>
 <07c92fc2-7022-4bee-bb54-6b4d6019939d@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07c92fc2-7022-4bee-bb54-6b4d6019939d@intel.com>
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: a411f268-e56e-49e2-b7d9-08df4cb0cfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|10067099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|18002099003|22082099003|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Sr1xJhHaayXkMi/xA4AkStqfZTd1oEj8lKmqfujKLzAHE189wzj0Mm/n+ozihzuLGIV3ihisG/QEUthYOauXddXZ4op3rsDSZJeO0NNAUfKlE7mUFUpT/W1B/1WRH2cJX9tbRQw8prKZB/5+X9j0X+Zy+FNYeQDY+dpqwFXLM1XtceMx6CWI1zMsQ7lmcWLK/al3MWxsKErwHVTLSr/x6CER8oU1mTDkdM5TN71DwJVgZGJEd73Wl6pltKmnaQQpZUqUuAwGPy3hsKe1nl1byfywXZpFfZlNLgEA5V7sYZRVVQLL+cPAZzy8WORHn3+5xjotbNp6XkNK1JKDzCRki3hHDUHLoCc3fMkcXMU2rWUPhrtqn6uBfbdQIsXHOUD6MGPnChkw7TBcmMBZaz4v7cAhq6j3705rM6kKFn3qiotJTIp9l4PWSBuaf9kh48fyHHAOnbKxEkYT5u2xErc1RWjIXbGX8AN4Q5fLvV8BUixMcN1BkAnwz6kLfTKGx2yFyHdGw0yEwVx7ftfsIkzacMcUook/Xx/awbwl4x5krpjx/ksKAYZZ8iBodew1BoDVHTUC/If1qazU7dxi77poRuomMySok3EkS0yXrGaDbCt/7XIoyXjteM6jvE/N/cKKVaY3CuA5iw1CAfQCA+N7gcn8Be61k8dWZbqlYrfR2Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zA2YgGVPN3N789lNwpBBTD+o5rEvt/Ebahe7wo6HA0V6IPfK4XIr0M9a2h?=
 =?iso-8859-1?Q?lT2naDPBUNXPlFiZNpWdlaaJ0aOteF/fHfT2C/S0S/s3idrMTP0b3prW6g?=
 =?iso-8859-1?Q?eVkhVuMvgf06NIgae6TcaioMw/va9DgDGCSaBaXnMWu0G+W5d5hJ7C2ZW3?=
 =?iso-8859-1?Q?VsvQ4zHjCDQdCLM5raAx8OF2tqI6NOwhGCtyABotsRZvdsxNNNkFOo4t8J?=
 =?iso-8859-1?Q?g4L3JjqRYUOPjmiaIkchrZkWcX8fRjCIa0H9l5C8KyTHmlZMAbSkNiz2v0?=
 =?iso-8859-1?Q?W+De63qkIp5hY26dVPQjjEX4lKTXbANeevcSO+TkY/rZ2/56DiECyxjYVm?=
 =?iso-8859-1?Q?85hU6pKDQ97irEcAqD0TBhBQSF/yKyI4uzP1H68yjsfuqwh6E9VElDmoy+?=
 =?iso-8859-1?Q?sDwumlXz2gr5r3xFLFO8xIsFxfmR/SDHPX9Zt5dgYR9Ut0HX4wpYcVLTZ8?=
 =?iso-8859-1?Q?2ssavBC+i/wTRdvQfTC6QJRNb+kWE268aQpIUSqebY9CNIqWtT5DH+1NpN?=
 =?iso-8859-1?Q?AHsLR4nzgDTxHYi1VP8C9J++FKHH05D9l2ZImlh/zMUJEadadPem097N9B?=
 =?iso-8859-1?Q?N+nkGPWToocBZH+w95Z8T1l1xMLTX+6daWoUM70svhxf+xbVKtGyd0UzOp?=
 =?iso-8859-1?Q?1toMevkAMPbppV7WvrUGJCoL97XG5urMh3TAMQVATvoG4FAMha45UX+hEl?=
 =?iso-8859-1?Q?8I0tI2Z2rOR/vq0jQkkdg+DIUeSnxL+dIPPCNbjMRnsPZBDMiv6n9Li76u?=
 =?iso-8859-1?Q?vUg9buMCDec08XeDRbWRaEx8/0PdIRpYmKi8HIL/+2dXHjxKiCWInaGkO8?=
 =?iso-8859-1?Q?PcoQYvgytGGgdeIQQkBocxlHiKUFI086r82uJqsOJXUNiF3VLYEvABsL2Y?=
 =?iso-8859-1?Q?58rVgCVb9VBmTtfhdGpwnK75S4/plk+zIyUFOyUx5NcjASEpEycYs7e8f7?=
 =?iso-8859-1?Q?0MogP8aMMEQrGjkWxwqXiwR/ZMCwJMDtXti0JyPQUnVX3nyPjMnxT/e8Hc?=
 =?iso-8859-1?Q?Xe+8AUKP0mSdrSnDgvP/y1R9B80xH4xFlEOKT1hpbw7Humd4VWm6lwmslY?=
 =?iso-8859-1?Q?0Hw9kbZLsJqzccYUU9RuE5LbgRWazZQ8EdcOX0H6G/0wL2SaTNj1Q52QPz?=
 =?iso-8859-1?Q?l1c0/nGvEwk2O5FE0ytTZ9cIBJ5+RFyD9ZFcw3t2P/+wieUSNrh+x+cDKh?=
 =?iso-8859-1?Q?rvQFcvM0cUcC1OdA4gdM13SFDKrm+QMLQ2cE8XXUb9oANtt9Esk3inTadh?=
 =?iso-8859-1?Q?lWypXg7gSNGV6OKLYWnlDEmJXVUh9Kh5wYRRwQz9F1esJJcuaZ9kZCVIEW?=
 =?iso-8859-1?Q?+sdY+wam/7x8Re53VuFhJVHXTdlnG2X4wgxtOImGhKz2aWvHdbVc4d4+0R?=
 =?iso-8859-1?Q?RTmqkxq6SyK1jL6vcl9ez0MOzTlQkV/o2t7p+NxxL5UCeWu1fCMEnXxVgC?=
 =?iso-8859-1?Q?OhuYI9C3BMgL2rtC9HUjaQIWQl5VFkvUHsZIIdjbTnBNLqjCH1PciCrhrz?=
 =?iso-8859-1?Q?J33fYlMmOVoOwH97WhD2ibzbeFcbd4BIcrPxGv3L05ORA+qns0LNUsICOA?=
 =?iso-8859-1?Q?A8ni8P+bisvQ5txJIUaYpqsZOcZPFOT0yb7SjAxzqlh9E+lmWtHvrOo902?=
 =?iso-8859-1?Q?bzXxvrIC+oGCYMWCG2STbd7D9R9vCbPtl+YIGiDnBwQmZE8BU/Vbz0Umsq?=
 =?iso-8859-1?Q?i4ibVwXFJeli2Or8mMVywEvnIbA8cIPcRWaVyJxFwlxO/E3PNSWofaebQ+?=
 =?iso-8859-1?Q?xcQyszZj6m0x4DDh2Mw1zVF+auvxNuwMBAVOkeDzFxHQZODW6myDi3p5ys?=
 =?iso-8859-1?Q?ENudwleEFQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: f5czdi+SIHEABQBiXEljZF5mMRD1woZJqKjbdvi50QbQm2L/kJXK0W/WsxaeWiZyLooN4zIy5U9AK4mHOCdEBohAOIFt1N8AC6jfLRn3VPpc2lA0VNq8YJ2+BlWnMb4Yqidiogc2oJDL8Lvkwjwu+O8nYrtvTuPIcpVqk4XENw+ajMJns4ATFh/jRhT4UfniMeioDrZtzwkjQ+Z86xB/iVysmpC5dSQOwCYcOlbYwI3hpDUWWAulPPtNWxGcPEIp7il9LpJ6yOWbMQW/G6mo+VSymRZOyb/m/XbNjmPyux0a3TElIXY1jsX2cNYdu4WQlBxmaLxz5aiamozo9B76rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a411f268-e56e-49e2-b7d9-08df4cb0cfd3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:03:59.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaG5/ks0L/CBPa45GoWQOK455jK4HEaQKldudewUxTgS4RMhtrkM2g+ww47uEq0Zpq8adWc1dF1FNSbvg+CcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

On Fri, Nov 27, 2026 at 12:46:46PM +0530, Tauro, Riana wrote:
> 
> On 26-11-2026 00:32, Rodrigo Vivi wrote:
> > From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > 
> > Add a retired-pages node type to drm-ras so drivers can report the
> > memory pages they have taken out of service, with two operations:
> > 
> >   - get-retired-pages: dump one entry per page with its address, size
> >     and status (retired, pending or failed). The dump is flagged with
> >     NLM_F_DUMP_INTR if the list changes while it is read.
> >   - get-retired-pages-info: return the maximum number of pages that can
> >     be retired.
> > 
> > v3 (Rodrigo+LLM):
> >   - Split the drm-ras core from the xe user.
> >   - Flatten the page attributes and name the node type retired-pages
> >     instead of retired-resources, avoiding the over-wrapping
> >     anti-pattern pointed out by Jakub: the type-specific nest and the
> >     resource-type enum are gone.
> >   - Use uint for address, size and max-pages, no pad (Jakub).
> >   - Start the status enum at 1.
> >   - Move max-pages to its own do operation instead of a leading dump
> >     entry.
> >   - Set NLM_F_DUMP_INTR from a driver generation counter.
> >   - Report unknown node IDs with NL_SET_BAD_ATTR.
> >   - Removed deprecated Assisted-by tag.
> > 
> > v4 (Rodrigo+LLM):
> >   - Check the dump consistency once a page message is filled (Sashiko),
> >     and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
> >     not lost.
> >   - Make the error-counter operations reject other node types (Sashiko).
> >   - Hold a node reference in the new handlers (local Sashiko).
> >   - Rebase on the telemetry node type, moving the type check of its
> >     handlers into drm_ras_node_get().
> > 
> > v5 (Rodrigo+LLM):
> >   - Split the node and callback checks in the clear-error-counter doit,
> >     and write the new handlers like the error-counter ones, with
> >     put_node labels and an inline dump loop, for consistency (Riana).
> >   - Drop node-id from the dump entries (Riana).
> CC: Tejas
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Riana Tauro <riana.tauro@intel.com>
> > Cc: Raag Jadav <raag.jadav@intel.com>
> > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> > Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> >   Documentation/netlink/specs/drm_ras.yaml |  73 +++++++-
> >   drivers/gpu/drm/drm_ras.c                | 228 +++++++++++++++++++++--
> >   drivers/gpu/drm/drm_ras_nl.c             |  24 +++
> >   drivers/gpu/drm/drm_ras_nl.h             |   4 +
> >   include/drm/drm_ras.h                    |  49 +++++
> >   include/uapi/drm/drm_ras.h               |  31 ++-
> >   6 files changed, 385 insertions(+), 24 deletions(-)
> > 
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 0f1ceb705d3d..c217e52197e6 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -16,16 +16,28 @@ definitions:
> >       type: enum
> >       name: node-type
> >       value-start: 1
> > -    entries: [error-counter, telemetry]
> > +    entries: [error-counter, telemetry, retired-pages]
> >       doc: >-
> >            Type of the node. The error-counter nodes expose reliability counters
> > -         for a hardware/software component, and telemetry nodes expose an
> > -         interface for reading and writing telemetry values to a device.
> > +         for a hardware/software component, telemetry nodes expose an
> > +         interface for reading and writing telemetry values to a device, and
> > +         retired-pages nodes list the memory pages that have been taken out
> > +         of service.
> >     -
> >       type: flags
> >       name: telemetry-field-mode
> >       entries: [read, write]
> >       doc: Bitmask of access modes supported by a telemetry field.
> > +  -
> > +    type: enum
> > +    name: retired-page-status
> > +    value-start: 1
> > +    entries: [retired, pending, failed]
> > +    doc: >-
> > +         Status of a retired page. retired means the page is reserved and out
> > +         of service; pending means the retirement is queued but the
> > +         reservation is not complete yet; failed means the reservation failed
> > +         and the page may still be in use.
> 
> YNL allows per enum member description and would also put the description
> in the uapi header next to each member which would be cleaner
> 
> >   attribute-sets:
> >     -
> > @@ -140,6 +152,30 @@ attribute-sets:
> >           doc: >-
> >                Bitmask of access modes (read/write) supported by the
> >                telemetry field.
> > +  -
> > +    name: retired-page-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: Node ID targeted by this retired pages operation.
> > +      -
> > +        name: address
> > +        type: uint
> > +        doc: Device address of the retired page.
> > +      -
> > +        name: size
> > +        type: uint
> > +        doc: Size of the retired page in bytes.
> > +      -
> > +        name: status
> > +        type: u32
> > +        doc: Retirement status of the page.
> > +        enum: retired-page-status
> > +      -
> > +        name: max-pages
> > +        type: uint
> > +        doc: Maximum number of pages that can be retired on this node.
> 
> Nit: 'on this node' can be removed since it only defines attributes here.
> 
> >   operations:
> >     list:
> > @@ -287,6 +323,37 @@ operations:
> >               - field
> >               - field-name
> >               - mode
> > +    -
> > +      name: get-retired-pages
> > +      doc: >-
> > +           Retrieve the pages retired on a retired-pages node, one entry per
> > +           page. The dump is flagged as interrupted if the list changes while
> > +           it is being read.
> > +      attribute-set: retired-page-attrs
> > +      flags: [admin-perm]
> 
> Do we need admin permission for this?

Let's keep it for now. It exposes device addresses of faulty memory,
the error counters need it too, and vram_bad_pages is root only.
Dropping admin-perm later is backward compatible, adding it later is not.

everything else is addressed in the upcoming v6. Thanks for the diligence,
patience, and for paying attention to the details.

Thanks,
Rodrigo.

> 
> > +      dump:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes:
> > +            - address
> > +            - size
> > +            - status
> > +    -
> > +      name: get-retired-pages-info
> > +      doc: >-
> > +           Retrieve the retired page limits of a retired-pages node.
> 
> Nit: %s/limits/info. Would allow other drivers to add additional attributes
> if required.
> 
> > +      attribute-set: retired-page-attrs
> > +      flags: [admin-perm]
> 
> Same.
> 
> > +      do:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +        reply:
> > +          attributes:
> > +            - node-id
> 
> Why do we need node-id for this response?
> 
> > +            - max-pages
> >   mcast-groups:
> >     list:
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index 82fcc766b84b..26505a7e4f0f 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -69,6 +69,14 @@
> >    *     Each field contains the uAPI defined enum string, its numerical value,
> >    *     and its mode bitmask, which encodes read/write capabilities.
> >    *
> > + * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
> > + *     Userspace must provide Node ID.
> > + *     Returns one entry per page with its address, size and status.
> > + *
> > + * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
> > + *     Userspace must provide Node ID.
> > + *     Returns the maximum number of pages that can be retired.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -121,6 +129,13 @@
> >    *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> >    *       to enforce permissions checks on telemetry operations.
> >    *
> > + * - RETIRED_PAGES:
> > + *     + The driver must implement the query_retired_page() callback, returning
> > + *       the retired page with the lowest address at or above a cursor, and
> > + *       -ENOENT when there is none.
> > + *     + The driver can implement query_retired_pages_info() to report the
> > + *       maximum number of pages that can be retired.
> > + *
> >    * Netlink handlers:
> >    *
> >    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> > @@ -147,6 +162,10 @@
> >    * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
> >    *   dumpit operation, enumerating all telemetry fields and their supported
> >    *   access modes for a telemetry node.
> > + * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
> > + *   operation, listing the retired pages of a specific node.
> > + * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
> > + *   doit operation, fetching the retired page limits of a specific node.
> >    */
> >   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > @@ -162,6 +181,8 @@ struct drm_ras_ctx {
> >   	unsigned long restart;
> >   	/* Node targeted by a telemetry get/set doit */
> >   	struct drm_ras_node *node;
> > +	/* Which retired page address to restart the dump from */
> > +	u64 cursor;
> >   };
> >   static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> > @@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> >   /**
> >    * drm_ras_node_get() - Look up a RAS node by ID and take a reference
> >    * @node_id: ID of the node to look up
> > + * @type: Expected type of the node
> >    *
> >    * Looks the node up in the global xarray and, if found, takes a reference to
> >    * it so that it cannot be freed while the caller is using it. The lookup and
> > @@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> >    *
> >    * The caller must drop the returned reference with drm_ras_node_put().
> >    *
> > - * Return: the referenced node, or NULL if no node with @node_id is registered.
> > + * Return: the referenced node, or NULL if no node of @type with @node_id is
> > + * registered.
> >    */
> > -static struct drm_ras_node *drm_ras_node_get(u32 node_id)
> > +static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
> 
> Can you please split this into its own patch. Making the node-get type aware
> makes changes to existing code paths and is not specific to retired pages.
> We can have this part of the same series but as a different patch.
> 
> >   {
> >   	struct drm_ras_node *node;
> >   	xa_lock(&drm_ras_xa);
> >   	node = xa_load(&drm_ras_xa, node_id);
> > -	if (node)
> > +	if (node && node->type == type)
> >   		refcount_inc(&node->ref);
> > +	else
> > +		node = NULL;
> >   	xa_unlock(&drm_ras_xa);
> >   	return node;
> > @@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> >   	u32 value;
> >   	int ret;
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
> >   	u32 threshold;
> >   	int ret;
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -699,20 +724,24 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> >   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > -	node = drm_ras_node_get(node_id);
> > -	if (!node || !node->clear_error_counter) {
> > -		drm_ras_node_put(node);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > +	if (!node)
> >   		return -ENOENT;
> > +
> > +	if (!node->clear_error_counter) {
> > +		ret = -ENOENT;
> > +		goto put_node;
> >   	}
> >   	if (error_id < node->error_counter_range.first ||
> >   	    error_id > node->error_counter_range.last) {
> > -		drm_ras_node_put(node);
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		goto put_node;
> >   	}
> >   	ret = node->clear_error_counter(node, error_id);
> > +put_node:
> >   	drm_ras_node_put(node);
> >   	return ret;
> > @@ -770,7 +799,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> >   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> >   	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > -	node = drm_ras_node_get(node_id);
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> >   	if (!node)
> >   		return -ENOENT;
> > @@ -781,6 +810,166 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> >   	return ret;
> >   }
> > +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
> > +{
> > +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
> > +	struct drm_ras_node *node;
> > +
> > +	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
> > +	if (!node)
> > +		NL_SET_BAD_ATTR(info->extack, attr);
> > +
> > +	return node;
> > +}
> > +
> > +static int msg_put_retired_page(struct sk_buff *msg,
> > +				const struct drm_ras_retired_page *page)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
> > + * @skb: Netlink message buffer
> > + * @cb: Callback context for multi-part dumps
> > + *
> > + * Appends one message per retired page, in increasing address order. The
> > + * dump resumes from the next address after a buffer overflow, and is flagged
> > + * with %NLM_F_DUMP_INTR if the list changed between messages.
> > + *
> > + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> > + *         (requires multi-part continuation), or a negative error code on
> > + *         failure.
> > + */
> > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > +					struct netlink_callback *cb)
> 
> Since the function changes. Have reviewed the github.
> In v6, can you please make changes to this patch instead of a third patch
> since the entire
> implementation changes. Its tough to review the third patch only from
> github.
> 
> > +{
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> > +	struct drm_ras_retired_page page;
> > +	struct drm_ras_node *node;
> > +	void *hdr;
> > +	int ret;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node = get_retired_pages_node(info);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	for (;;) {
> > +		ret = node->query_retired_page(node, ctx->cursor, &page);
> > +		if (ret && ret != -ENOENT)
> > +			break;
> > +
> > +		/* Never zero, so the first message is checked as well */
> > +		cb->seq = page.generation + 1;
> > +		if (ret == -ENOENT) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +
> > +		hdr = genlmsg_iput(skb, info);
> > +		if (!hdr) {
> > +			ret = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		ret = msg_put_retired_page(skb, &page);
> > +		if (ret) {
> > +			genlmsg_cancel(skb, hdr);
> > +			break;
> > +		}
> > +
> > +		genl_dump_check_consistent(cb, hdr);
> > +
> > +		genlmsg_end(skb, hdr);
> > +		ctx->cursor = page.address + 1;
> > +	}
> > +
> > +	drm_ras_node_put(node);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > +					   struct genl_info *info)
> > +{
> > +	struct drm_ras_node *node;
> > +	struct sk_buff *msg;
> > +	u64 max_pages;
> > +	void *hdr;
> 
> Rest of the file uses nlattr
> 
> > +	int ret;
> > +
> > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > +		return -EINVAL;
> > +
> > +	node = get_retired_pages_node(info);
> > +	if (!node)
> > +		return -ENOENT;
> > +
> > +	if (!node->query_retired_pages_info) {
> > +		ret = -EOPNOTSUPP;
> > +		goto put_node;
> > +	}
> > +
> > +	ret = node->query_retired_pages_info(node, &max_pages);
> > +	if (ret)
> > +		goto put_node;
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg) {
> > +		ret = -ENOMEM;
> > +		goto put_node;
> > +	}
> > +
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr) {
> > +		ret = -EMSGSIZE;
> > +		goto free_msg;
> > +	}
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
> > +	if (ret)
> > +		goto cancel_msg;
> > +
> > +	genlmsg_end(msg, hdr);
> > +
> > +	drm_ras_node_put(node);
> > +
> > +	return genlmsg_reply(msg, info);
> > +
> > +cancel_msg:
> > +	genlmsg_cancel(msg, hdr);
> > +free_msg:
> > +	nlmsg_free(msg);
> > +put_node:
> > +	drm_ras_node_put(node);
> > +	return ret;
> > +}
> > +
> >   /**
> >    * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
> >    * @ops: Generic netlink operations
> > @@ -808,10 +997,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
> >   		return -EINVAL;
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > +	if (!node) {
> >   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -		drm_ras_node_put(node);
> >   		return -ENOENT;
> >   	}
> > @@ -892,10 +1080,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
> >   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -	node = drm_ras_node_get(node_id);
> > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > +	if (!node) {
> >   		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > -		drm_ras_node_put(node);
> >   		return -ENOENT;
> >   	}
> > @@ -1100,7 +1287,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >   	if (!node->device_name || !node->node_name)
> >   		return -EINVAL;
> > -	/* Currently, only Error Counter and Telemetry endpoints are supported */
> >   	switch (node->type) {
> >   	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> >   		/* Mandatory entries for Error Counter Node */
> > @@ -1112,6 +1298,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
> >   		if (!node->telemetry_get || !node->telemetry_fields)
> >   			return -EINVAL;
> >   		break;
> > +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> > +		if (!node->query_retired_page)
> > +			return -EINVAL;
> > +		break;
> >   	default:
> >   		return -EINVAL;
> >   	}
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index 589c6445eff7..c56220205876 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
> >   	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> >   };
> > +/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
> > +static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +};
> > +
> > +/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
> > +static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +};
> > +
> >   /* Ops table for drm_ras */
> >   static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	{
> > @@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
> >   		.flags		= GENL_CMD_CAP_DUMP,
> >   	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
> > +		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
> > +		.policy		= drm_ras_get_retired_pages_nl_policy,
> > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> > +	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> > +		.doit		= drm_ras_nl_get_retired_pages_info_doit,
> > +		.policy		= drm_ras_get_retired_pages_info_nl_policy,
> > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> >   };
> >   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index 7a1cba70fd50..880b0c2befe3 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
> >   int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
> >   int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
> >   					    struct netlink_callback *cb);
> > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > +					struct netlink_callback *cb);
> > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > +					   struct genl_info *info);
> >   enum {
> >   	DRM_RAS_NLGRP_ERROR_REPORT,
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 76bdcc6f96a5..5c3900a53278 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
> >   	u32 mode;
> >   };
> > +/**
> > + * struct drm_ras_retired_page - A retired page reported by a driver
> > + */
> > +struct drm_ras_retired_page {
> > +	/** @address: Device address of the page. */
> > +	u64 address;
> > +	/** @size: Size of the page in bytes. */
> > +	u64 size;
> > +	/** @status: Retirement status (enum drm_ras_retired_page_status). */
> > +	enum drm_ras_retired_page_status status;
> > +	/**
> > +	 * @generation: Generation of the retired page list, changed by the
> > +	 * driver whenever a page is added, removed or changes status.
> > +	 */
> > +	u32 generation;
> > +};
> > +
> >   /**
> >    * struct drm_ras_node - A DRM RAS Node
> >    */
> > @@ -184,6 +201,38 @@ struct drm_ras_node {
> >   	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
> >   			     s64 *status);
> > +	/* Retired-Pages Related Callbacks */
> > +
> > +	/**
> > +	 * @query_retired_page:
> > +	 *
> > +	 * This callback is used by drm-ras to list the retired pages of a node.
> > +	 * It must fill @page with the retired page that has the lowest address
> > +	 * greater than or equal to @cursor. @page->generation must be set even
> > +	 * when no page is found.
> > +	 *
> > +	 * The @query_retired_page is a mandatory callback for
> > +	 * retired_pages_node.
> > +	 *
> > +	 * Returns: 0 on success,
> > +	 *          -ENOENT when no page is at or above @cursor, which ends the
> > +	 *                  list.
> > +	 *          Other negative values on errors that should terminate the
> > +	 *          netlink query.
> > +	 */
> > +	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
> > +				  struct drm_ras_retired_page *page);
> > +
> > +	/**
> > +	 * @query_retired_pages_info:
> > +	 *
> > +	 * This callback is used by drm-ras to query the maximum number of pages
> 
> query the info.  The parameter also should be a generic struct instead of
> max pages if
> any other driver wants to add extra parameters.
> 
> Thanks
> Riana
> 
> 
> > +	 * that can be retired on a node.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
> > +
> >   	/** @priv: Driver private data */
> >   	void *priv;
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 56e0588af5d5..e7f2da18cc4c 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -12,12 +12,14 @@
> >   /*
> >    * Type of the node. The error-counter nodes expose reliability counters for a
> > - * hardware/software component, and telemetry nodes expose an interface for
> > - * reading and writing telemetry values to a device.
> > + * hardware/software component, telemetry nodes expose an interface for reading
> > + * and writing telemetry values to a device, and retired-pages nodes list the
> > + * memory pages that have been taken out of service.
> >    */
> >   enum drm_ras_node_type {
> >   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> >   	DRM_RAS_NODE_TYPE_TELEMETRY,
> > +	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
> >   };
> >   /*
> > @@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
> >   	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
> >   };
> > +/*
> > + * Status of a retired page. retired means the page is reserved and out of
> > + * service; pending means the retirement is queued but the reservation is not
> > + * complete yet; failed means the reservation failed and the page may still be
> > + * in use.
> > + */
> > +enum drm_ras_retired_page_status {
> > +	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
> > +	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
> > +	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
> > +};
> > +
> >   enum {
> >   	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
> >   	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
> > @@ -73,6 +87,17 @@ enum {
> >   	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> >   };
> > +enum {
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
> > +
> > +	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
> > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
> > +};
> > +
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > @@ -83,6 +108,8 @@ enum {
> >   	DRM_RAS_CMD_TELEMETRY_GET,
> >   	DRM_RAS_CMD_TELEMETRY_SET,
> >   	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
> > +	DRM_RAS_CMD_GET_RETIRED_PAGES,
> > +	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
