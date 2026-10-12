Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C1CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E5010EF05;
	Mon, 12 Oct 2026 08:01:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877B310EC71;
 Mon, 12 Oct 2026 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791792081; x=1823328081;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4HiyCJj64lsVYPnlWvaiueSGwioZmFXK+8vY6Im4794=;
 b=CL3XrhjlTk1dlh9JQErgdByo0v/vSPNWwo9+9k3AWIKFRrpW2sf/Nb2i
 iKTcp4FxE46wq9OdISPUKnhx6d/Tx7nyVSNkdkcy96NecSrVbK6cY9V8G
 BowWGMWzTykRdJPnjNnChlQZRgTaQoZ8o752Z6Q44PrWk2Tt6SXQmV/Qk
 WcKBFolPUQjBTP8d2n4GbdPi3hkzNaXs5I2RRcY3r94HvD/Oj4XOacLZL
 CAwny4I/AbvIrbzk+hjMP200ecb3osqjp+EIJ47If8IByMjz8Y4BxrGnx
 y10ipCWqTjDZn+4DZ4fS6n+yjCnB+ONj1zY9xSqaGT6fuujeZ5bLonCRE Q==;
X-CSE-ConnectionGUID: v2MEGgMyQyKPW1H3Nv9yOg==
X-CSE-MsgGUID: vQSsM8ZkRDeP1HnFWZPBAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="370460"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="370460"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:01:20 -0700
X-CSE-ConnectionGUID: KyRc+Zu+SxqsNTFYEKYFBQ==
X-CSE-MsgGUID: Az3+TEIfTdKarntSv7eSyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="808112"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:01:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:01:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 01:01:18 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfXNvGIYeiKUFxEvqzRC7I35dQtYkUAXrthkHwedTCz47V3OS7//uzYIXjKpk/7GrLV1XB+x2t4bwk5VcQJqh6KxFa9suMJkhhdAPT7HPahsFtT6UA3Lhp6ab0HWZk8eNF4YXNSWNa9iGaTYK44vSAcCbYu8PxWT+DqAROj/7wQLlrDlZKfy1jNPZa/8+b7hSSw5i9HOFxNJmNwpD56Jvo1TYKn/7VPbRmoNIr1F6qpon1Fil/jAQ1oalDektT+ep8E66AENVNPY/kg4JS7e8CBYgw8UW2Xt6ncRBE1w1MVDeDMe4XQtKjc8zKXCJujjs7cSkBogfnVV7SnKbXxdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3BvvJ1d3J459XZJP8D67wCbK8mjKbRTJwWY6V26sSY=;
 b=ihi7B79JPP7KmzNFgNW5ZvvpcEIaRsklIuoS10ienHCmf6Lqd7k6pIUphSoWJki23f+4kZTobCe+8nGMJC7RSHOfCGsV9kEvZzi3NpwWdRCfFv7UMITN+6ptx7xuIVPkoelb5tD8Y/xQqZw83/8NW846eO8/s0Y8Riu0sSHjqcmvA6H5aXe3WGnqeZcR6ygmx7tcHHiWHWFjM/ej0d2TEVw0biXvAtQjmr/Fw7wdr26Fv7TvH/bRTkelBafAMRcugslUR/wq1oG95xnUwt6auZtQ1QTWpF8O4pf5bXWPt9Gt11+Ni11LJcoyUHImrzzRjjQ06V3LhOW4G6zp0LeKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 08:01:14 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:01:14 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Kandpal,
 Suraj" <suraj.kandpal@intel.com>
Subject: RE: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from VBT
Thread-Topic: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from VBT
Thread-Index: AQHdWgArThbKQRrWdEWg2IfuIbuzK7b5aIWQ
Date: Mon, 12 Oct 2026 08:01:14 +0000
Message-ID: <DM4PR11MB6360A316EEFBC2EEBB7EFA43F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: 2ffe36e5-f52a-4231-538a-08df2836fcf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|5023799004|4143699003|260925021311599003|260925022911599003|10067099003|260925021911599003|38070700021|261009223027099003;
x-microsoft-antispam-message-info: 9QJ6DVMXdfwiCdyHvnqZCe+KfgSwS+VLkfRcGeaaGWUCM1xyIRPHOZP8AXUUC0t4LrBcDwGRVtm3R79/ckUXbewvs3tx1VZd01zIwhGUBagDstyMitk7ezmfXU+UYKJn2H+pedObAw3byd/a2JIbAeoFXn9eSFVdkekC4ev+zrvICli033jRkjiPOa7sTVtggZDp+M9RTb9XozO+ug1fT9FG5NL9bk9UTsPSSZrMXnEaD1GF3/Y4qSVmYM6FIqnSySyEKzmtcfkmtn3ZdBh6YRXVVinSKZMy0fuwUQQyJ6hFGaMACTNdlSUlxwNwtJpQOKF/TST5wHYgIlnzUQCsWkPYAPIrwbu07zfdVjpk7yGxAUM8NQo+RxtmCr9qsA3LIlV8XRaI9Ak8cLpRj1qjcOeEuTUjX1irAVCbsC+OPMbhbPQRulXYKUvSKtyqs9Ryqw/oBSnTWNCchUa5mxH5bJM8iwhhF68nx9FLolbhSpwroDY7bStCOE316RdUB71OYf1Oa0ExgS2nM5sHkt+0aaA3kdIDvFir5OAX2L4rArDSC9QvFvKI25ftnc7Weqg4viKIyjhaQcwDDzRSVUQphxSqkhuoxyEvNq2A/+P+YdfYKenb2gWNG1tUeIkM/CI4n5YPimIgAsk75guyROkXIotwzSrdIQhPvjUDpaAhLBFivdLNM56S2AZv057B8UHZ4i3fczCxRxSLJhYZ7nWUrfunXSekhMB4cvFDU2kA9eU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(4143699003)(260925021311599003)(260925022911599003)(10067099003)(260925021911599003)(38070700021)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cftX35LsscYp1+pAcxmu6b93cXrupvtRi+eVrQfYJWAArv7YwEYQa1R5d3NI?=
 =?us-ascii?Q?aJRrdfVpevhzbVY2dmOC0gWszEno8aH3XhFdsxhZGiaBoybcip+H2bUPjnY8?=
 =?us-ascii?Q?qIPdzEvZrAw9HzIByiPT8ME4nBiw0ovyprdv/EBM8Y5c6oJq4dYOhAe85rlw?=
 =?us-ascii?Q?zh6dxZdWOw5Onf0ZhDsCCMRyZLDqYsWvfyQzNVsPnLy/98T+OOSkIf5jlQiT?=
 =?us-ascii?Q?9CArd4eX2Yz7DhYM/QPaduzVeO+aghW9hHJfkyN+CY0lUbzMhkyTnaZesics?=
 =?us-ascii?Q?MByqeC1twtA63o0sRcQbll/95iV/FgH817oNFq4sLQjYUQxddRNWvhYSBmsY?=
 =?us-ascii?Q?lVCcgtus13S/gjXGZzk9WnuHRWyMdl4COCpMPuz/eRULGWdmTedTPxLkmt05?=
 =?us-ascii?Q?DkYlB/4xAj/X7eOiUM3HhPsKrYiO85bCg7zP+ceoiga1uyq3ukY2UX2zTRVZ?=
 =?us-ascii?Q?FXvvzYFpeeYhkBykqhzuHHB11SPCIaYCMFN6S/JQ4B8JyTqajiACqWcTqm9B?=
 =?us-ascii?Q?ISP9zmAxLmzRkjwLKNsbXySymyWrZ+IdFbkDlT5dHyUC2WpRjUb1HXhPJyFl?=
 =?us-ascii?Q?ESB8Rs2/boPaWZsHu7Yo6Y1mIzuUx2VuCjiTHTrRz37P/6XzcM3Y1radFWQW?=
 =?us-ascii?Q?VyLhTkDefEKuCBmo2z9k9mDu4MY5VxUwCZsRzu6Md3KqV5rsFqqG+z91HZQI?=
 =?us-ascii?Q?p+Sxnw+a86qkVN7pI7cL3oTwUgJclJ/+Qj8LkXsrlVwmrAcqL7mKhMG7Kthj?=
 =?us-ascii?Q?KNNSyX1xmmar28aJs64i6Apzm9HBgM02IF7tMAPhqMFFOeG6v8tU5Y8d4ylc?=
 =?us-ascii?Q?avx7BawF2D5Rv/5e13WFnjRBIm38bXM4ac5jRAg9PD3ol8+I7ZMj+dI0De7o?=
 =?us-ascii?Q?vsFSPm+twPctDcbIga8/YO57pPbl31bQLYRt78J4i+s+Yfkoj6r6Old3ypQq?=
 =?us-ascii?Q?+mU6mo5ZodlMNvwxvCO/pMXZPCNTbuQKrFS0mBAg986OYTTDZVLkGwgAs72v?=
 =?us-ascii?Q?T/78sn3LYRmY52GlSy5WqKECOsb+QkKjN/881y7uuJSRmVuhpSAzwSXfCzAA?=
 =?us-ascii?Q?M1L1RWVVDmTGU8Ue274jxuvYJp+ufOZTbnDfPx6Z62ZqI6x0tuyEunLasq/z?=
 =?us-ascii?Q?DipB/MT6+HUM4xZns2aKRo5//XohXQerfu6dsbgm0oTMicOiwBAsw0FRyX10?=
 =?us-ascii?Q?uOneha4B1hb1ujRUB5s7fQN6c523eUAVjFeNnPKn0TcOpSTrlV6r1exfxrr3?=
 =?us-ascii?Q?ErWrZ0+GXNQzU8eSVY65PNbdIQkAgU5sGNGJMY1VRXAydfpmswGdVGlrQ1sg?=
 =?us-ascii?Q?JCS5rpNNo3F1CRVD1oHYt4P0U98WaMAR08WX7BBBqAamjy15+aerEc5tRcR6?=
 =?us-ascii?Q?3qACt8CvPY8pLSWg4VV6z/eNT6jChZSwowfKragnT1cgip7XAoXyrjAKwKTd?=
 =?us-ascii?Q?pT7AjDrsdUELPxd50mt2/VNoIRRKOs9wKwORutZSxWrn3WeeYevVWXBt7N1/?=
 =?us-ascii?Q?YLOS8ZtR+i5H3X+rAqYxkard558DKvCE4ixwmIUkEB0ptY0F5840pw0eoKko?=
 =?us-ascii?Q?AakLRZmrIMgBXNhsZt7deLPAFsI4MDprf1ZB3v3dfbeI5ImIF/xSMnFMDP84?=
 =?us-ascii?Q?YgKzp2QAAhlojHCel69rSwfLLh9UBBrDYC6OVrp6p6gPCLAmWg5DJq6M8HcF?=
 =?us-ascii?Q?EiaH9c3bw4RLSmLPdqsTjA7SqMKmBUoP6yNzBQ+L0wia+7ebpaRfO3sUlpqZ?=
 =?us-ascii?Q?HxhGerInSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vPWzkDd6SQr4OX6R3hwymvhmIGmPLCNciIgg8ATd8nVOdNMsh5WEep3lD/OfNpYfBAsXPtuiYHRMpt4uruAZNIDQP7AbfGSDgSQ3r79I50D3f6OIqpMuAYGyARb5Txg9mytguodEN3ugv0zUNKKVMKlxMGxCbLvOrxj9f/RSEKbD8cjjkkohJnvCCFnune0IQqpCYC2yNT1cXFLEhJgkO6X1Ntrk1MezQ3+QIWgbsQeD/8APQN5m3mhI+nvrmM+7moPZH3Kywex6BiH0nJTV1wQq7Z/X8F9fbZSn3Ao60icLZe70tudZJ7JIjkxlBUz8ImT65CTog5pIkNlD26KX6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffe36e5-f52a-4231-538a-08df2836fcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:01:14.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq2IBomVSGeLqyJi+CmLxxZlnfj7F/HdwTognjjrZs5tnkgMJIU5QkIxvSKCs3ZHKLhyTZXNVL5qrocDJ0HZJg==
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



> -----Original Message-----
> From: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>
> Sent: Monday, October 12, 2026 9:27 AM
> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; jani.nikula@linux.intel.com; Shankar=
, Uma
> <uma.shankar@intel.com>; ville.syrjala@linux.intel.com; Kandpal, Suraj
> <suraj.kandpal@intel.com>
> Subject: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from VBT
>=20
> From: Vandita Kulkarni <vandita.kulkarni@intel.com>
>=20
> Parse the maximum FRL link rate from VBT and store it for use during FRL =
mode
> selection and link training.

There is nothing getting stored here, maybe rephrase it to expose helper to=
 get
FRL max link rate.

>=20
> v3:
> - Bail out early for VBT version < 237 and resolve the max FRL rate in a
>   single switch, handling hdmi_max_frl_rate_valid =3D=3D 0 up front. (Jan=
i)
> - Drop the intel_bios_hdmi_max_frl_rate() encoder wrapper and take the
>   encoder devdata directly. (Jani)
> - Use the standard VBT debug message format. (Jani)
> - Spell FRL and VBT in caps in the subject and debug message. (Suraj, Jan=
i)
> - Move the hdmi_max_frl_rate_valid =3D=3D 0 comment onto the check it
>   describes. (Suraj)
> - Add Bspec reference. (Suraj)
>=20
> Bspec: XXXXX

Put a valid number here or drop it altogether.

> Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bios.c     | 39 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 ++++
>  3 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
> b/drivers/gpu/drm/i915/display/intel_bios.c
> index 7b6a6f8c3cf1..7181237508b3 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -2788,12 +2788,45 @@ static bool is_port_valid(struct intel_display *d=
isplay,
> enum port port)
>  	return true;
>  }
>=20
> +int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data
> +*devdata) {
> +	struct intel_display *display =3D devdata->display;
> +

Add a check for devdata as well to protect against any NULL pointer derefer=
ence.
Good to combine that with below check.

> +	if (display->vbt.version < 237)
> +		return 0;
> +
> +	/*
> +	 * When hdmi_max_frl_rate_valid is 0 the VBT does not specify a
> maximum
> +	 * FRL rate, so don't use it to limit the FRL rate on FRL-capable
> +	 * platforms.
> +	 */
> +	if (!devdata->child.hdmi_max_frl_rate_valid)
> +		return display->platform.meteorlake ? 12000000 : 0;
> +

Why special casing for MTL, or update the comment.

> +	switch (devdata->child.hdmi_max_frl_rate) {
> +	default:
> +	case HDMI_MAX_FRL_RATE_PLATFORM:
> +		return 0;
> +	case HDMI_MAX_FRL_RATE_3G:
> +		return 3000000;
> +	case HDMI_MAX_FRL_RATE_6G:
> +		return 6000000;
> +	case HDMI_MAX_FRL_RATE_8G:
> +		return 8000000;
> +	case HDMI_MAX_FRL_RATE_10G:
> +		return 10000000;
> +	case HDMI_MAX_FRL_RATE_12G:
> +		return 12000000;
> +	}
> +}
> +
>  static void print_ddi_port(const struct intel_bios_encoder_data *devdata=
)  {
>  	struct intel_display *display =3D devdata->display;
>  	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt, supports_typec_usb=
,
> supports_tbt;
>  	int dp_boost_level, dp_max_link_rate, hdmi_boost_level, hdmi_level_shif=
t,
> max_tmds_clock;
>  	enum port port;
> +	int hdmi_max_frl_rate;
>=20
>  	port =3D intel_bios_encoder_port(devdata);
>  	if (port =3D=3D PORT_NONE)
> @@ -2863,6 +2896,12 @@ static void print_ddi_port(const struct
> intel_bios_encoder_data *devdata)
>  		drm_dbg_kms(display->drm,
>  			    "Port %c VBT DP max link rate: %d\n",
>  			    port_name(port), dp_max_link_rate);
> +
> +	hdmi_max_frl_rate =3D intel_bios_hdmi_max_frl_rate(devdata);
> +	if (hdmi_max_frl_rate)
> +		drm_dbg_kms(display->drm,
> +			    "Port %c VBT HDMI max FRL rate: %d\n",
> +			    port_name(port), hdmi_max_frl_rate);
>  }
>=20
>  static void parse_ddi_port(struct intel_bios_encoder_data *devdata) diff=
 --git
> a/drivers/gpu/drm/i915/display/intel_bios.h
> b/drivers/gpu/drm/i915/display/intel_bios.h
> index 196b8b3f434f..b89f72d90c1f 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.h
> +++ b/drivers/gpu/drm/i915/display/intel_bios.h
> @@ -112,6 +112,7 @@ int intel_bios_hdmi_boost_level(const struct
> intel_bios_encoder_data *devdata);  int intel_bios_hdmi_ddc_pin(const str=
uct
> intel_bios_encoder_data *devdata);  int intel_bios_hdmi_level_shift(const=
 struct
> intel_bios_encoder_data *devdata);  int intel_bios_hdmi_max_tmds_clock(co=
nst
> struct intel_bios_encoder_data *devdata);
> +int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data
> +*devdata);
>=20
>  void intel_bios_for_each_encoder(struct intel_display *display,
>  				 void (*func)(struct intel_display *display, diff --git
> a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> index 0dc13d080e8a..db7484542dc0 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -381,6 +381,13 @@ struct bdb_general_features {
>  #define HDMI_MAX_DATA_RATE_340		4			/* 249+ */
>  #define HDMI_MAX_DATA_RATE_300		5			/* 249+ */
>=20
> +#define HDMI_MAX_FRL_RATE_PLATFORM	0			/* 237 */

Use 237+ to remain consistent, do it for all.

> +#define HDMI_MAX_FRL_RATE_3G		1			/* 237 */
> +#define HDMI_MAX_FRL_RATE_6G		2			/* 237 */
> +#define HDMI_MAX_FRL_RATE_8G		3			/* 237 */
> +#define HDMI_MAX_FRL_RATE_10G		4			/* 237 */
> +#define HDMI_MAX_FRL_RATE_12G		5			/* 237 */
> +
>  #define LEGACY_CHILD_DEVICE_CONFIG_SIZE		33
>=20
>  /* DDC Bus DDI Type 155+ */
> --
> 2.50.1

