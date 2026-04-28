Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5900DFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A0010E13D;
	Tue, 28 Apr 2026 20:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VqOR8Qv4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1167B10E0DB;
 Tue, 28 Apr 2026 20:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777407699; x=1808943699;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8mZBG+k2Ysb+p1yjPMg7RV4df1K8ccsnuSnf979f3OI=;
 b=VqOR8Qv444USHMX3SLHWubSxdVzgtbVSndyvbFLykPPq/bhzSKN7oPUz
 eBw55PVqwnjUEo+vs9DDU+zz3UVEu/bexUMxre/hK6TwreHWE3LHZDPKq
 LyNdoZuZrO1Mf6UkLCECL/5ptmCRKeMGeYH19qRsJtchRXi0eFEhWiMJX
 chxBo92RWVxej7yR9vw803/3O1R317RByJHPYAiNIaq7B2yOBh1106caP
 2zqFlSKSAte9hxcF9cDtgmU8RfsnZhgxiRKxmxZtKxebt7mPDCpqoZ1Vm
 SRxKr6/6+xZbuZ9j+yBELQeDd2aTRBNBkAHba0VcXIimn4TLaGG0erp08 w==;
X-CSE-ConnectionGUID: lkEitICBTx2rJyOHf7wrtw==
X-CSE-MsgGUID: IkT8IHuPRAqc5VfaAjb/5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82185763"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="82185763"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 13:21:39 -0700
X-CSE-ConnectionGUID: FL1pMOVLTSq+EVaJvLCxZA==
X-CSE-MsgGUID: bnFZ/M+4S9S1tcB94RBiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="231410757"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 13:21:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:21:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 13:21:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD6m1rgeKw6Yvy2Kf8KQ8vPdoFt7IT6DpM5kiV06/q5T0q+wvGqRTheD8ZTLvhfluz3YD59fqQIGsCtxp9y+eckdaoVaTW51eTxXJETjSYt0PN+yw3z563iC0TyOr7M7w1pYpJsE35BC+a/nzxGdL6bve2kjUu1zzQ5dpUOaCecnYI1zGdiPBjLzrqlauR/d5dDXl9McBw8H3N2epL4MOHrvsLLJGe61OIdShLk1TC3QKFHD/0IGo5BADvnql1OVv59jt83PXa44sQrYfpyU9tp+wpaVB1WkiTcrCv1uJejmyZhs1rv7KGKUs/qeF2lNVmz4POiRnu5US+mB3wvfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1/WmZWMReRDlMtuyxeL8ReykPg5i340ceANO+VmCWE=;
 b=Ay8ohEeiQfkXYbNYVhQmc5NCN+3/6Iepk5XeU1eAf4BXi6w3hUpdTWMxQjn2kL3GGcx/+gNWq3HbfsitaL9gaUmYj7bNqtQWM61k4TVMhPLYc4g/+8VG9h7tMlYTfiXCUmssJzNgTMCPxu2YjrxQ2zzU6Awzp2N3wAzoROfpq7PAAuoy7yXUcyWhGI3ZzNODfo7T9BPA/BbQO5LBPO3XaIuabTWdQu0HqsaX7nDabn90VbuOZCelqgNWO7faKhL6rPEUVuu6vrmqjHawgeRS3kNbiFmEhZp0E1C8QTPNYrh1Gr8d/IBUO8tShtt5Xfmz5kn/bmVbbpO+/7N6LzVCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 20:21:35 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 20:21:34 +0000
Date: Tue, 28 Apr 2026 16:21:28 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Message-ID: <afEWyE8UIIWpixFU@intel.com>
References: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
 <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
 <afERYJuuvZmexQ4-@intel.com>
 <c039c23483b6b280806b8c7fa100f6de26e18ce0.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c039c23483b6b280806b8c7fa100f6de26e18ce0.camel@intel.com>
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1b0ff5-ab31-407b-474a-08dea563bdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: /kVrWVtoju6SMs4K6hU6Q1N9eZ74haesDwg1Ij3lghtmp9GxxlBv868rig0vQezIBROj+qfqeTW/OBpxTLkHduzncIgogVti3ivZS1F9Uisk9JMLQWPWLFkiPME5Bmg474++M7qihvP9HyRH7QrbO60Fp66m/rndEGectrheFtEfIBuFKoW5zsnovn/eKjdKVKxoMzdhqvDc3ANDCAkKf3l8jUzg7iq4Ncd6yff2mVXTbMcdDcmy4oRgO+DlamKojVyFdw82d7BTbp7EMhzKxwbqYy7S5IOwOl6GHBimqyrKBgm/MwxFXwiy4yYaEPgK/I4Gisy9w1WuFIUiX1X07CACacXxOOb2ODfNaaQ0P0QHhXwkGs+XyhdmpP2MatGobPvggnjc/nCmjBjVCsYEjnWTOvrCtKFnCkLqoPe0XoI9+0TQjmwkBTDU6y7DXdGT+ZI1zIXwK+OkpVnpP5uSD+KzJrnqxmyxIQhslePBUA53IWL1kRtGT6xmf3RWZ9j+MQbtCfcQH2iBogJoX1GwdWv+GtpW7k0B+ewwz69N1Yg8lvQX3a3YCGVdYmMk/aQxO/WB8rkoDqWtKSMWSPYO0vkxTe0uySwbq5XVxywe1xPXonlGcMJ0TcNsxBIkN5ncKsNLhndduVoV/9jXq5Hv7c5f8ablt9FyEsBwQraGpOMF79v+R1RtHOeGoyX5XZuS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QdCcxjXF1wPRSJ57/ibcQECpMUmEc0SMLq0UQDXvbqzgHDrLlYcVyakbnf?=
 =?iso-8859-1?Q?98Tab+iHqHFNaH9Yj648rByVv0HgGZU9JYniD7b+ceV3L3aQ57mFyvV2jV?=
 =?iso-8859-1?Q?7znHty66Gu3TY/pQh2vYK2WI9cgmhj0ZjdZ1CVfZ7XuRx7CmkkvYiQ8ccC?=
 =?iso-8859-1?Q?TV/taSBzQbSJH2olDR9pgmQWg/NL55x0HgQ0VpHWwOT1D2rn8IrvlHzd0K?=
 =?iso-8859-1?Q?ON0qadxb8xGarbnsT5lP/q7USKr7G6zcIFBQYBZt8kIi6kRk5SaxPrNmgP?=
 =?iso-8859-1?Q?JthbaMsZygbxAqTmmJAyw0tQimW/CrjjPt2Qb3dwut260Hi5be7tcVWcj8?=
 =?iso-8859-1?Q?oVGCrhksUz0E8na+eM+A++QFMNUPoAdjiLJFvRe5N646iVfJRusyhMr4Hi?=
 =?iso-8859-1?Q?RPsbsFTlXy6VY6YGCKAyvE8gPNo9DPCiFYMKpA1TmqDydHDcb+9W/dxFGz?=
 =?iso-8859-1?Q?XTp3g+wbEjJg5qRf5WFXZqzWSLEm9vH/n55bshjHACC/QcfrVlTudPUv+e?=
 =?iso-8859-1?Q?Nl50WdcFK8QozP1XgDkXKs2yx8J1BqeBZ8gLFSCLucvbptpI8bQ19DF0MR?=
 =?iso-8859-1?Q?GpRhLJ0yRicBE2dR+0JWDGkw79m4gXD8Lmw2Oa8m7kfdnIUFtk/DApm0tk?=
 =?iso-8859-1?Q?2sOh6e5j7WG9VaQp5ZylyoDa3c/zLI714r35AA+zlp2+dxXFb+2JUk26eR?=
 =?iso-8859-1?Q?Q5QZtre0P/H/fl0IdqvtYWMPOMTnwhIdjL0goAbZ52z2Zm+cVMP4/SkyLt?=
 =?iso-8859-1?Q?fvcRRgKXzQQ/pAnOgMPBeRODJK/h4F3rYZ7crwXnWjt8cF3M7LZs2YxGgA?=
 =?iso-8859-1?Q?rah9PQOQfKSqg23ZW2CC6sAVHERtccImpUDXi/eU3OiDiw2BLM0wBJYSyR?=
 =?iso-8859-1?Q?OhUWPcabzM4lhxAC2mBlg8WX0pGLPZQqrnuyTBFExgJHdvMhJhgbV4TXod?=
 =?iso-8859-1?Q?w5AAe0Z71e4nQT+ndy4XmH80goBjWY/wIcz5EQfolX+QsNms7oQWaSRUht?=
 =?iso-8859-1?Q?GT118y6DsuAODPywY76iL5+ruGzi9a6Wctl+6jtGTJuVcNhmQGJc9GdIgS?=
 =?iso-8859-1?Q?bGHHD5R4j/J1wQV7YR+KPFeL9Y62d609BUzhBiROYg4ZqlifW0n0bDysBT?=
 =?iso-8859-1?Q?plq+c1uodY0nQIq5+nxKuTxpM3xxk9Uwvy7rSCNigJb4DdXNUM802HvYJi?=
 =?iso-8859-1?Q?9uc0y8hr3LrTXUi2L5lL5i7B4Bfm5EPdGLtAqyr+xsnTohJWr0DXTF5rPp?=
 =?iso-8859-1?Q?kE+7jQaPfolNRtURZSffnTyp4IuFJkERDBxHByYvOhhalMPajOObHO/WkQ?=
 =?iso-8859-1?Q?Jjo0SMe82ecpl3RSLSx42HrF2w2RD+wpjwL9C/uthHuiRLIw0OYE4e74X2?=
 =?iso-8859-1?Q?1hjp/QmrJrwandpCfGc+HFj8PlcCbNpgwR1uIibIeDsit1OZKp8Zp8Xf59?=
 =?iso-8859-1?Q?pDJ2vJ52AFdldKntq76rvz1fU2rnR3TrPIp0EbEBt+rMZyZ5MMDh3DFYpZ?=
 =?iso-8859-1?Q?22/buT2es51DlsTRZ1D5fwhMgzuUVO8BnPTnusLTAtZ2s39EcLJz+U/ucu?=
 =?iso-8859-1?Q?FwrskVfR83/sJg4r1nlgNBl36IPSb4wc7n5HYP+gjNsGv6fEArxqQ6OpHf?=
 =?iso-8859-1?Q?n/GTDYUV3RUPJfilUibeRvFh7irvJHt+1a3yQucEG8JTllsrfv7cT2fe4h?=
 =?iso-8859-1?Q?wM/igDQegOSezDT9v4530aMi4zMHY/YfDD+PmHpGuWgaBIoBElPczBWN6d?=
 =?iso-8859-1?Q?yk45qlvqA0zGwYFPADJyZ9FxDpQbsnz3eT4BfPytDbvhzgp3GgZRjdxo6J?=
 =?iso-8859-1?Q?rXoEcGOUiQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: iPm3ibMX0P7lCYKPCZGfac0xQcq/h4uii2l1fbb0ARjbS5Gvpb3cm5ubYbFMevU+W8KDmQIwodlUDiYqcBCWKP5hZdWhbpPOhWP26slnI7nmqFv4bj1XMEmNeR7mO+u6behrJTOzN7naYxJtZMzt3H0nFEQwX60SUOvu9IwsYFjNQ/usuSKdqE/SM1le1Kj7bRfRjsohsU5X7ssOXEhLxfytk+Ya26yaBQ1wjiU5YyA+gzOf5KuUmf0Do3FrLAtAAWcPgIEqpkATFC3BWrfLx8QRoiM0LSqu4FOcI/l9J2DTkbVm3U4fLmkJwzNyh65OS9/XqGplsS96WS04eVNq4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b0ff5-ab31-407b-474a-08dea563bdc6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 20:21:34.0093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heLViiJGaUOPVpHEApPYaU4RxOG+kXLGGk9KymzNbWtHB9llZc1duKGBW/jYQEHNPX/RUH8Y4EJD8NjVxt9Tcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
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

On Tue, Apr 28, 2026 at 04:01:41PM -0400, Souza, Jose wrote:
> On Tue, 2026-04-28 at 15:58 -0400, Rodrigo Vivi wrote:
> > On Tue, Apr 28, 2026 at 02:09:31PM +0300, Jani Nikula wrote:
> > > On Tue, 28 Apr 2026, Uwe Kleine-König (The Capable Hub)
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > UTS_RELEASE evaluates to a static string and changes quite easily
> > > > (e.g.
> > > > uncommitted changes in the source tree or new commits). So when
> > > > checking
> > > > if a patch introduces changes to the resulting binary each usage
> > > > of
> > > > UTS_RELEASE is source of annoyance.
> > > > 
> > > > Instead of using UTS_RELEASE directly use init_utsname()->release
> > > > which
> > > > evaluates to the same string but with that a change of
> > > > UTS_RELEASE
> > > > doesn't affect xe_devcoredump.o.
> > > > 
> > > > Signed-off-by: Uwe Kleine-König (The Capable Hub)
> > > > <u.kleine-koenig@baylibre.com>
> > > 
> > > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > Cc: José Roberto de Souza <jose.souza@intel.com>
> > 
> > Jose, ack on this?!
> > 
> > I'm afraid this could break the current Mesa parser, so better
> > checking first...
> > 
> 
> It will not cause any problems.
> 
> Acked-by: José Roberto de Souza <jose.souza@intel.com>

Thank you all, pushed to drm-xe-next

> 
> > > 
> > > > ---
> > > > Hello,
> > > > 
> > > > (implicit) v1 of this patch is available at 
> > > > https://lore.kernel.org/20260427160902.1126027-2-u.kleine-koenig%40baylibre.com
> > > > .
> > > > 
> > > > The only changes since then is that instead of dropping the
> > > > kernel line,
> > > > init_utsname()->release is used, which is nearly what Jani Nikula
> > > > suggested.
> > > 
> > > Almost the same, but better. ;)
> > > 
> > > I wonder if most UTS_RELEASE uses in the kernel should be changed
> > > the
> > > same way?
> > > 
> > > 
> > > BR,
> > > Jani.
> > > 
> > > 
> > > > 
> > > > Best regards
> > > > Uwe
> > > > 
> > > >  drivers/gpu/drm/xe/xe_devcoredump.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c
> > > > b/drivers/gpu/drm/xe/xe_devcoredump.c
> > > > index 558a1a9841a0..07c7c89240d8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> > > > +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> > > > @@ -8,7 +8,7 @@
> > > >  
> > > >  #include <linux/ascii85.h>
> > > >  #include <linux/devcoredump.h>
> > > > -#include <generated/utsrelease.h>
> > > > +#include <linux/utsname.h>
> > > >  
> > > >  #include <drm/drm_managed.h>
> > > >  
> > > > @@ -101,7 +101,7 @@ static ssize_t __xe_devcoredump_read(char
> > > > *buffer, ssize_t count,
> > > >  
> > > >  	drm_puts(&p, "**** Xe Device Coredump ****\n");
> > > >  	drm_printf(&p, "Reason: %s\n", ss->reason);
> > > > -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
> > > > +	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
> > > >  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
> > > >  
> > > >  	ts = ktime_to_timespec64(ss->snapshot_time);
> > > > 
> > > > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> > > 
> > > -- 
> > > Jani Nikula, Intel
