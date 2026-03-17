Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBFCFD8740
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658DD10E57C;
	Tue, 17 Mar 2026 11:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ghTxv3pk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D443E10E4CE;
 Tue, 17 Mar 2026 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773746369; x=1805282369;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q9eLR6z5vIofgVXoRMhE55aWbGEEyFnfTGXBeS2g+hs=;
 b=ghTxv3pkZUd2EosPIMVkkuaShXNcOgG1JvsnsFS4NHb/iH8w/SZv2lcA
 ecJxJamuEwsUg6fjfQ6hg+DarYYFUuEf5PHzlHuMzjhf6j18/S0wvx8f4
 1hhrIEbHu+z4fFUpAsAhRaS1w4d50C5PMlAaWBxtoeuY/X2BcYWDbUZMC
 7q9uP2fWlPQbWVxsIwFvZ6PmorgwNXJ9xYg6QwEmFRXMPT8OpgyZewMzU
 rjNF5DMWaKqRcZ1hB3UGHsnhTgCi0RV+ecR1Qxjxmspc4E1cI52CzSpKn
 KiTV8uOfLbAtYR/8x9nDjMfJF/HePbk3bTcp5gsIyvb6XvjzoywfKYFQm w==;
X-CSE-ConnectionGUID: a4jii+4DSI+XjmkXOmdKnw==
X-CSE-MsgGUID: rxmCPNFYRhaO7Ny0bynjeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73794211"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="73794211"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 04:19:29 -0700
X-CSE-ConnectionGUID: znPiPnlcRX6JtPmw7jsJ7w==
X-CSE-MsgGUID: v929hJjlQpildFsiP7rzyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="222463187"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 04:19:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:19:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:19:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJdc2M6Skl6z5p/YwV/pRUDhYuV4/kyY5Asu7DXIMhiKAwR/NMLi1LeHhBgEwON9w+XUEYZEvscVNC9oML83No659nnsOUj9KPBQv4XpKhwU1YeEU+qxLcu2dnkI8OjEanUau5zubUImv1NbFZX+dRpjgzjldFRvgr80bJa4s7unKpg+4TWmWOwFYMIg3AeRLgJU4q/aYKWw1d9MEFOCBNt00lRhccyPR8n6mHIKUOOxCfs/CMzNO0yX0wUlWyWcH1qaelMEUiRTmi1HbUgaBYtFDHoB8pzM2zhzH+U3ArDPYm7eKwA/zGQ3M0TvaXVb5URc7QvxaeRPNvOMwAIVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1klFdhZtMWHo5N/xwkeS+wg7lqFoKtx7huHNBR3ZBo=;
 b=E94mrVyzZXcfuZ0hYEk/k1HravZuwKvgFb1tkGSuJmDK1Hih4/gG6/0/iLPqVwKMzpVH54FQPnMVMbwX90xcyGuPTa7cNtBiJkE7ftvrcTV4p3d3UMfkc9Dwvuc5hQ0fVnNQDqSYXDYRyLEZSfJdLycEqzpiqDOM/qi3NaNGziA0y0k6vqgTKzD2DkBni0x+TfDsq+VcSqxEM9Yxm94EZDwTiE66SHuPAOgxleKVVrZy5pXd+Zi3g5kqqlWlUiPepCgTN0lY7LmPOYdpyLn6Be5NRAPm1nAXt1Z/x1P76eVcLdXKP/HGP1CXQ3AKemWYsSxU8jNdlVruIbnpmjfgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by IA4PR11MB9250.namprd11.prod.outlook.com (2603:10b6:208:56e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 11:19:19 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 11:19:19 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: "Gupta, Varun" <varun.gupta@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "Auld, Matthew"
 <matthew.auld@intel.com>, "Yadav, Sanjay Kumar"
 <sanjay.kumar.yadav@intel.com>
Subject: RE: [PATCH] drm/ttm: Fix spelling mistakes and comment style in
 ttm_resource.c
Thread-Topic: [PATCH] drm/ttm: Fix spelling mistakes and comment style in
 ttm_resource.c
Thread-Index: AQHctPllvsK0wU84RkOsX9xhqT/zz7WylMfw
Date: Tue, 17 Mar 2026 11:19:19 +0000
Message-ID: <SA3PR11MB81183DA9015A190BF2B8EDD9D041A@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260316035915.1403424-1-varun.gupta@intel.com>
In-Reply-To: <20260316035915.1403424-1-varun.gupta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|IA4PR11MB9250:EE_
x-ms-office365-filtering-correlation-id: 5d3fe2ab-1a00-4739-93b2-08de84170880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: lC8wxSHaMcW+nZd5kwr0pnextFlYO8W4lJqljp7M+N/REcPS+ZddFICF8edStsgam7x1lhx4BAka3n8Kwz7WlMhu/0meQWmaEV/u+V19KRJhZHv0VvYw0zwNrvzJLwH0Za5Tj3WEYHynpJ7QNklWPSHfQr21WeR3qdSKk/CvMtQ67czpRQ+FNaP5puok7PRPbqTy2UWEALVdXkBEF39ux+EJRXtfDaAlrKwiT1Pxs893kUKS1ulY2JciouTbDSWFH3EqvxNrBuYahPZvvUXgTChhgox9SZXATRBsuQBW0EIWtKPXvWYM973eKEPMJ4jrSr68Os6SNZniORTNYj8NASStasX4xuUY7it8WSI5+yinoCRQpv5HsDI4lfkseJGM+0TiJFw7Be2go5KNAxwx7wmo9r4SqzYZcelNi7ad3frSkrOInwWHLHgzrMvSlA2chjKq2HBppJRd5NpNBg2PeC43RR02n39bSVu4l8Pg9p02Ec1NYYfQilClWQwMfuNYH4nl91WqOsVKbTSdGeOBYgjesNBKFyx8KPF9pIKM+JaWi0waouVbRE/oEpKIIFou0u+rvsEebned4SRcrklBFIL793Ed+O59eQaYjKMtal93hVP3IwIgDBfeu19In+tJCx0azAxjiWIwN6I9S3HxGO1U8BO8Fki2jD4/yrU3W3HGzp4DxeDRinl7ls98dQjMObuNBQkl0mubS760wM0J9Y+YIFekI/U4NB5rtU5S3oYdSG3/6EuPDIMiMleCG67HKV+cZXlNQcgAbDfeJCtUqCKc+oMbOeuJjIhV32KpWlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB8118.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4CA3ECFTQFk1lwqNc968015SlAEp3MwiV8sVwOLeedxYmw5aBaV+WR1L/ZcF?=
 =?us-ascii?Q?ALstDJtTU3ctj9yqU+XBYlJobhnHWG6GhTFG3gfXrWsL7jNhr1HJPHdSlW24?=
 =?us-ascii?Q?uLxQflfe7yk7Buu4F5igLtG1yH7+AO4Hvt6anZ3NWsiab510cjB0JRWXCDE6?=
 =?us-ascii?Q?BN5kBrFkUB4OTE+uIVHK7fH0+wpJ5BYJ1qFKOAockP5R7PZN2bvQ0vbLSKnj?=
 =?us-ascii?Q?LhhUFILbbiGJehgSndaWd3Ty4GlUBsCF7sX7u9GdnU+1IxMAiseo5ryTNYAK?=
 =?us-ascii?Q?6tlEqiYdOHn2SCGVjdw0q73g4TVg1yWE0zlBvNXhdrgfg7R3qJV8WAth+em8?=
 =?us-ascii?Q?rPbvxhlRgUtniAs/ZD6I1GJ3q3fPKjyWCl/f10qYcTX6m9Dwww+6CC6Y5B/E?=
 =?us-ascii?Q?OWCnADjb2Qht4d7uOGoZifY+9enjebDxPUsDLcTuvf5pjKs2Wo8YmTT5/br6?=
 =?us-ascii?Q?/r3mkT6/WQNZnOO2KKN+0qsYE9nnCDJIKzzfChqKOtFcbgul5bRmz9ePdF8m?=
 =?us-ascii?Q?X0f9Pb0/V0cTiELEgphoIBw6ICqI++S/A2Aty63syalhQi/8p+9NZyEDvzG7?=
 =?us-ascii?Q?S99rdriozKv8N2jDlNMXDOW27bTM5Vljy404hxsQtuotiWoTrmVJ0b2oZlt9?=
 =?us-ascii?Q?V1KVmJ1tHKpi6C8ngiPZpfvo9xVlrh3Do7KV+hZitZt4Bz2uWPkgmSwMzmUb?=
 =?us-ascii?Q?0XmRY84KXfIKitrqtmmd8r/zxQlXI7BmlGtnt3/+2YH1Y5VovXeaS/9igFqI?=
 =?us-ascii?Q?y8yNai0BiEmDcqkvca8Zd4X18JNb7OOzILgljSDvAYzMg4s4T9FFurpA89ex?=
 =?us-ascii?Q?n/3JUoG6h1Jwza4RG402ghlzZUFk+kPrB8/Rqt4MP3loKiy55p2k/KtFwdD9?=
 =?us-ascii?Q?P/mb6X+z0bhyrBaCDEjIpK18GZKT/vNAd7pnnFEl3x60qBwfCPC5+6SnN4T1?=
 =?us-ascii?Q?GDAxyv81cCk1ss9RCR8wT4lhHPEK+UAozW3LoWVwwKJwncd2syLjgccEdWtM?=
 =?us-ascii?Q?GYEo8IpBjpESl3lRZnK0bpOIZD0wBasagXpPy3DmXqJRToLPqKpTs+z9h/yk?=
 =?us-ascii?Q?2HwQHrVgtbWSaelAMOTaoxSMMUN0G0PbGnXkyJFUmXmk4UKgOpaNMI9GX4c5?=
 =?us-ascii?Q?abNvMIUyuDLh5B46a9ewl5jCwGr+dsNmOm/EPlrR62Fcx1L9c/Ivj9ZrRZQf?=
 =?us-ascii?Q?yziIi6iwHWqhKbP8j01I6N4j8Le7eay04Dcm19Ppo+lHPlwBJVGL06GYvxZI?=
 =?us-ascii?Q?jB2dNLcWKn6I90DT/K5ff7zbDLroEGf70pHtAoZgwgpiC8p6lXhcr48CRnB6?=
 =?us-ascii?Q?ZtbSi0Fw5+4O7R0THY1TxQgw40BmaYzNWZguyd0df4VqF0K+mgS/Zg7JcEof?=
 =?us-ascii?Q?ppbZdQT1AHO8AaLhnpdV7gH58CCyLtGUZ0rNOKU2hFgAhfJQ2pMbTWbus65l?=
 =?us-ascii?Q?QzJ2VG/JE7bM9vZbZwlQnkMTaywZB82UM9qpJlYfKxFsk5YYPsRMyjw3BuQo?=
 =?us-ascii?Q?su7EK9eL32kfYM/psTQkh4YnE5hnZlg0yvrF6YWtEEeyBv27rppRRJDGtHGJ?=
 =?us-ascii?Q?Pc7UObFzxAyAWWT7a++cfRpgCJlQdbkRJccH2ZJve2g3RjjP6WKjMCBMZG+0?=
 =?us-ascii?Q?h98UqmnZvrramUANQflgxxClP0wFVDHCgC7tnqU77Q5khwu1inmix0Bv1ah+?=
 =?us-ascii?Q?JQ1y6ntf2uCsKtQF13ndUG1KBWJu1NQuHhLxqTcyhrAdaoJd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NFuLzUsmPq6nGLMx416k+1syddmFQStfbo5ZK7mBmFuAHPz8SA9P6iA1i9fkVJT7lte563TCQdMkdRcriBmFSiMTgQ6gEur6PwZLFBdUFGyj3jxqmt737VzG9KvlgcAco8Lc/lHNCDrAwvTWu1kpH7KrjRDS8v3bO0FrYuuISG8n9dfJY7dz9hDRYZN9JqBcaV9WeAFdpHOIPsLei/r4kEx73LFBOLmq2AunZPbu56S9bNxc/E7ENH996YQLQ0tydFAOSHNQZAahWymkFyX267zJQbavLryl6xzyJdP2ak6bstacxVGWqKjoKbSiUbtO3BuYNej9O85rX40ebql+vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3fe2ab-1a00-4739-93b2-08de84170880
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 11:19:19.4379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JivWLDOVSwqJ+tFOzUiMxCpeOzCllwrwCj7rBVoCpFul4Q/k+qoPRr2o9yeBnuQgJ459i8dpmfnFUVk8Ca7P/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9250
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


> Correct several spelling mistakes and textual inconsistencies in kdoc com=
ments
> and inline comments.
>=20
> Suggested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> b/drivers/gpu/drm/ttm/ttm_resource.c
> index 192fca24f37e..9f36631d48b6 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -37,7 +37,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_util.h>
>=20
> -/* Detach the cursor from the bulk move list*/
> +/* Detach the cursor from the bulk move list */
>  static void
>  ttm_resource_cursor_clear_bulk(struct ttm_resource_cursor *cursor)  { @@=
 -
> 105,9 +105,9 @@ void ttm_resource_cursor_init(struct ttm_resource_cursor
> *cursor,
>   * ttm_resource_cursor_fini() - Finalize the LRU list cursor usage
>   * @cursor: The struct ttm_resource_cursor to finalize.
>   *
> - * The function pulls the LRU list cursor off any lists it was previusly
> + * The function pulls the LRU list cursor off any lists it was
> + previously
>   * attached to. Needs to be called with the LRU lock held. The function
> - * can be called multiple times after eachother.
> + * can be called multiple times after each other.
>   */
>  void ttm_resource_cursor_fini(struct ttm_resource_cursor *cursor)  { @@ =
-
> 317,10 +317,10 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource
> *res)  }
>=20
>  /**
> - * ttm_resource_init - resource object constructure
> - * @bo: buffer object this resources is allocated for
> + * ttm_resource_init - resource object constructor
> + * @bo: buffer object this resource is allocated for
>   * @place: placement of the resource
> - * @res: the resource object to inistilize
> + * @res: the resource object to initialize
>   *
>   * Initialize a new resource object. Counterpart of ttm_resource_fini().
>   */
> @@ -435,7 +435,7 @@ EXPORT_SYMBOL(ttm_resource_free);
>   * @size: How many bytes the new allocation needs.
>   *
>   * Test if @res intersects with @place and @size. Used for testing if ev=
ictions
> - * are valueable or not.
> + * are valuable or not.
>   *
>   * Returns true if the res placement intersects with @place and @size.
>   */
> @@ -513,7 +513,7 @@ void ttm_resource_set_bo(struct ttm_resource *res,
>   * @bdev: ttm device this manager belongs to
>   * @size: size of managed resources in arbitrary units
>   *
> - * Initialise core parts of a manager object.
> + * Initialize core parts of a manager object.
>   */
>  void ttm_resource_manager_init(struct ttm_resource_manager *man,
>  			       struct ttm_device *bdev,
> @@ -536,8 +536,8 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
>  /*
>   * ttm_resource_manager_evict_all
>   *
> - * @bdev - device to use
> - * @man - manager to use
> + * @bdev: device to use
> + * @man: manager to use
>   *
>   * Evict all the objects out of a memory manager until it is empty.
>   * Part of memory manager cleanup sequence.
> @@ -882,7 +882,7 @@ ttm_kmap_iter_linear_io_init(struct
> ttm_kmap_iter_linear_io *iter_io,
>=20
>  /**
>   * ttm_kmap_iter_linear_io_fini - Clean up an iterator for linear io mem=
ory
> - * @iter_io: The iterator to initialize
> + * @iter_io: The iterator to finalize
>   * @bdev: The TTM device
>   * @mem: The ttm resource representing the iomap.
>   *
> @@ -921,15 +921,15 @@ DEFINE_SHOW_ATTRIBUTE(ttm_resource_manager);
>  /**
>   * ttm_resource_manager_create_debugfs - Create debugfs entry for specif=
ied
>   * resource manager.
> - * @man: The TTM resource manager for which the debugfs stats file be cr=
eates
> + * @man: The TTM resource manager for which the debugfs stats file to
> + be created
>   * @parent: debugfs directory in which the file will reside
>   * @name: The filename to create.
>   *
> - * This function setups up a debugfs file that can be used to look
> + * This function sets up a debugfs file that can be used to look
>   * at debug statistics of the specified ttm_resource_manager.
>   */
>  void ttm_resource_manager_create_debugfs(struct ttm_resource_manager
> *man,
> -					 struct dentry * parent,
> +					 struct dentry *parent,

LGTM,
Reviewed-by: Nitin Gote <nitin.r.gote@intel.com>

>  					 const char *name)
>  {
>  #if defined(CONFIG_DEBUG_FS)
> --
> 2.43.0

