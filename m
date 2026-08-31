Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABF0C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F41E10E869;
	Mon, 31 Aug 2026 13:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VOT2wlMo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FD810E862;
 Mon, 31 Aug 2026 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788183541; x=1819719541;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=LvZ0j5YPxLnZGt9p0hVWUMvlur7V2C9YpJPhz9py760=;
 b=VOT2wlMo/jQrd+Rr7/s13RcA34yYYz9jd1jHcoKJLXKgURGQX1haDEjm
 wEmP7dN1hvV+20l9T5jtZ3AZUq6i1gtYom7/BnH+bFnN+bMZizgkZr3xw
 BQ/YDCcI5YHqYowh/XRzS/+sIOkC4a4olwQiuCJ5pXkPVm7EEzFuvOvx7
 VKUJdeDDc95KMWRNBGn0HKRhR6wzPdfAqEPrCvLkfts5y5vI1rO6/G4tk
 StN18NtdKrLPq5ILe7LbgkAjj7N8KfJxMRFWzymesUkjw/K+y8mxVnSMH
 gX1mrBnODRAStyOkmCFQ2hjfpCb6lH8oXdj5pPQPsaLs/O/B/9n3tpqQB A==;
X-CSE-ConnectionGUID: bVOoILdMQ56/k/b0cGlpeg==
X-CSE-MsgGUID: CHy/fcU4TJqIHrQi/vi5kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99253919"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="99253919"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:39:00 -0700
X-CSE-ConnectionGUID: P6iQPOsTRweA+ubuWczIdw==
X-CSE-MsgGUID: VMIoCDKST5Or6CSn7eiJDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="298717313"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:39:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:38:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 06:38:59 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNdlUCFeu3gZVUFfLU/sNecTERw0UpnsONGlEfXZrPoefcE7FY93P/8SCX1FTkFnnWKR5OfhjtOOUacTD8KpDbW/QrK8uLNrxtnuovYIIxZy5AptrR04qbrmZTw2KicRyXc8AsejpX5MApGMerTBxgeoOjxd/jYG17AypZ3u1kgFbCbqlm17EZYLFZpnbNcGdaEvFTv9S4SX8iWwDRvaY46XqJJHsJaE+YgDKkAsHYPOhfQ210f8vsu2ElRHcns959Il+iB126oewL0mPHyfvrmly5j/PXXD9txiip8ZkfTIO3EmWllLii6FjkCLD4dqF6MNtyJER/rbMaJ8+2Yucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTyVGDdovtjBgqzjSNOsel7up4clvgV+0F33cuugyjk=;
 b=Syc+N0+1ikQz68TQPK3R0J8VIUc3W1oyfCIt2QWCine9l+vJmOC6AQM8NuaZV5a9EEcWseoupymZ1AZ02KIu2BTU2SMNdokvf51XmpoERxZ0cbThLUypbR5L4DTiRuwm1EYP2jG1E4twQokzYeFnvO9XChftRovJ9dSADxsoN2dudRdIwwjgZ/1HRicA3YxIFtNRpMRCTkPCxIfWMMELquNPdaFIlLXwWT6FzQswK5D/SDpctwYgE/QGtwUalGPFNmfTfONlBVjHPG8yqf+b4DceX0wWNKw+QbAlyTghfr0MkXUapwSMdlfiokjBJLaV3z2kdFO0xJrs8JerKRCw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:38:55 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:38:53 +0000
From: "Shankar, Uma" <uma.shankar@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Topic: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Thread-Index: AQHdJBCGi8jwRvuO10Sjj/hqyyXOq7a4T2pwgAAEM2A=
Date: Mon, 31 Aug 2026 13:38:53 +0000
Message-ID: <DM4PR11MB6360FEE47A37F9AB2941BCF8F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
 <DM4PR11MB63608596E790F45C24DD18C9F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB63608596E790F45C24DD18C9F4A92@DM4PR11MB6360.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|IA1PR11MB6537:EE_
x-ms-office365-filtering-correlation-id: c5fdaddf-690c-4f7c-ac3b-08df076532a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|38070700021|11063799006|10067099003|4143699003;
x-microsoft-antispam-message-info: HFb6Z7CPztUMmEkgNCl1bEjBzn4q56pvdy6z4xE7ZfZ1OptUIQhFBCIC1nRcY3ppVvClHQaGO+2u1FFvfHbn1Z99G+vP9APw6isW/dKvGIBQduSkhjFKy4k0YkTJ9YJU2Y2XfMUVTKISVRplUx1gIC+eLyqCt8tk4PduW5Kc6VYb9QHQV5dWYq0O2YdabNjXBskGulP+SMqkhFBV0BYKu+k4zjO8TBvESqHcvqPP8Ps3lVs209/8kX14RrNQTuPjQMb1t8kW4RsNXE8AAVanfMvaCRLYjPTFaFq7ANlJdbvk2VQA0oEaXo+q6T0cazQBANyHqI9KSiNmg65EiipO5GxdV4Mjzxz4x4Yfsgv4i5dTPhX5JNfKky08grN24w3IXWk6NMtH8mTgnBM80L60qj5OUie2WK1/ht7VWWn9akjns7I9RXboQYFCHsJa9HbTNH807OX/yfsDkh9Rb19IBxwKsHE5GDzwMt1/h1yvrLFO6Wj7SHe+zDGMdNsIu8zWcxe1Wa0ULs6hYU7/fFd+iGZ1EOzo0GLrf5YGZxNsBZopn9v7DYZ49dFGkH8MBodWEyPKQ5gdGnxRga9FsOqGNtre6TdT5xtfqLk9hlbfPxUbVV3Akwq57ACnYQJT3jLp27tUfMrAwQagfSUr3FgpkBFfVPD1PTfbUKgv8UVrFXk3+E7oDy34xTWiZ1CNE2JmKNYSl3MlVjFlN0CLmuzQAMvfGTyfzWk3sNJZO4f2WCA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EvFU79NQvf7LKDQsnnTR2gr2qOk5ntTe1/wT/xBFwkWYz9fnAHcJBV8T3DrX?=
 =?us-ascii?Q?b1Q/rJOACio2S3076TZu4+pSZB5qpcesDrba81UJz4WIrPu9LXRTMMlcUCxL?=
 =?us-ascii?Q?qMFX0p7tSejK3+s2Vv3rsjWmqpjhIvOYaENbffJDbBnsHtYVQYO8jyXF3A4b?=
 =?us-ascii?Q?70il5KSyhoQZEgzeii9nxp37y8N9hQOz5cN6SyJ2zCXzbJuOzIHOZo+trY7F?=
 =?us-ascii?Q?0urA98PmJoTxyp5YSFSrmuV0k4vLdQg8YH9JIL2GjQ2O4g9TsSboE7N+0tQw?=
 =?us-ascii?Q?n2VcD6OouKznPDlA2UWdd9IA6UWQzO7FgCWYNlh3CFhAE7YctUBqndsMcOAm?=
 =?us-ascii?Q?odloukt0gEwOYiwD0E1buVRVAPEDsfIXSlr+D7PRHY6WHJ40Ie5Iu60UXPoB?=
 =?us-ascii?Q?umz4dLF+2rsR7P43LU9FvLIc2+lB/QBCj/eC8HAxG8kR8OLnQMdhYjt1kopk?=
 =?us-ascii?Q?/b7lnaCuEhOl1yTW5rjNGyt2/J164K+XTZdOKZaYtyQs1cdvbbApFiCImjYY?=
 =?us-ascii?Q?vo4CUWnsAAUokD6FlFt32CSdz2qt4g2Eh/kGyZvH0/BPB3uuRPlvJdRHOEd/?=
 =?us-ascii?Q?r4UwaGYQSQ73IB5lOK94lRKl9sVxeZfwrKP21s2HnWYGx/+SEimxvzMuGSov?=
 =?us-ascii?Q?NCu6mcwb7kfx/pSG1g/Y7lFDijw4iJfEZ6uXtmXXFNwQLbspwlDxe/nJIJNI?=
 =?us-ascii?Q?rWpJJN9SAugj22Nvpv32Vtz3VMhIk2B1SExTU/m3jVrduMP/mWEzX1DC+uet?=
 =?us-ascii?Q?6s8+5BAjl1Ve8ZxeguBn8Slw9BJ9EpYyKprzYsB41toH69ZGlIIKP9UqbqTN?=
 =?us-ascii?Q?mZVI8BsxpFFSi06TZ6jGoDn9I/z5ewJZaMHEyFLCWzmGEGBX7NT7ZKIeRfrc?=
 =?us-ascii?Q?0bnvlNJ6+vvK8ZuOPdxnv2k7jphyYsk2z1qmi+m07pgL+gqX751w0+5Am5es?=
 =?us-ascii?Q?JPTpZhteId/G/OQAYgvQ5O6/gQosFIhmFTSm8aWCerObUZfMOCBxNZvXEp8h?=
 =?us-ascii?Q?fuBe/ZNzm9VrniTbupKyQDKfbLmgYqI8RI1OmVi2MJpe01Ik0yEcy0W5C53S?=
 =?us-ascii?Q?dzCbHeUXS+4NPmjKwoONHKFIsDHR+zEl4ni7zHalVegeFrDhYR5Wf5LRTIlD?=
 =?us-ascii?Q?D3tLi+bRMP7sHuXkC6nP/Rm11w7tv8XsqLPzpuHfaD4Z5+k/hsKWEEihCB7/?=
 =?us-ascii?Q?KCf+0DqEhRMuZQrG88L0Blp0NWVnOGBDVTHdFjbVTf6z1EF+zKoKFLp+K3tA?=
 =?us-ascii?Q?0hs4rJ7g9Zz868W7rPF/1z/B4TPajlAJHj058jJOk5iln01EQFUjGqldOqGG?=
 =?us-ascii?Q?KgfC5PLuRZMbYeu5Z1JEu0rJZP/BCFAtUxkYWSLi2wpzzoDehpAIrGz2TT4N?=
 =?us-ascii?Q?vyO5AxkGM8/gX5fgTeyozDsix/Av213xIvFR8//RHudU8URpchbn6ps4vrh2?=
 =?us-ascii?Q?3uKczWkrwg4KX1rQUd6qC1kwAIQ7WPmgtRUiAv71b+Nx7jA/fGgwrimnlCRJ?=
 =?us-ascii?Q?DNPzNYbmiztyHeNLv0ZVXebrLi74KS8nwUbJzeCB1FrOOdBZTYPrImB1HnV5?=
 =?us-ascii?Q?vzMtfFS1egM7p2BuL2Cer3Rvh8Y/SqCok0cklJHfN1+W/Wv2nlg+ou74rzL0?=
 =?us-ascii?Q?lso+r8wBvfvUIsCoU7ef9n7wMw8+/MB2Ml4qWTKE4ZTlg4/Lg0P4gohqjFhS?=
 =?us-ascii?Q?wA710wTz6VxU+/LnqlsCu7NzXi+c/GSvXgV4dOY0GCy1Z61U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vaAlJZM/NSk2yZAGrlxHScD1+dWuiQbUFnrZnmeliALOW78VmSRhGURVkrgpYnBJAWQxMX73EZgCVs3V8MnYiak5o68BRSmJejb67rurfKAtXqId9bCMMMnwJqzYmJGc9x8nf5blNlTOqb+NDC1nPbSd69dw6NW9YV1Srl1G+Vh7z4OVu3OW3FH8M1g/NS0mGT3iVNTJJg9RZwVzG2FbWc6pp8lTnvPGEqPPOqYaqeMEiKSoZKC3oH+drcizBqdP/H2fc54NOs/DXBLtsjmmGxn630jbUhBO1QnxVEh/400BixaikwyiJ1XbXjaQBrlzZ+GiMZbbCQuz9oyspJOk5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fdaddf-690c-4f7c-ac3b-08df076532a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 13:38:53.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LD4e2EOw/GaCee7bQAhN+jxXJjNdurysyAx+hs/Nxln0D1zNDQQhNdX8T4EEG+nSLnA9JU9BGi9t9v6H0DnGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
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
> From: Shankar, Uma
> Sent: Monday, August 31, 2026 6:54 PM
> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; intel-
> xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org
> Subject: RE: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR plane=
s
>=20
>=20
>=20
> > -----Original Message-----
> > From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> > Sent: Tuesday, August 4, 2026 6:01 PM
> > To: intel-xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org;
> > dri- devel@lists.freedesktop.org
> > Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Shankar,
> > Uma <uma.shankar@intel.com>
> > Subject: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
> >
> > Extend the SDR plane color pipeline to post-CSC 1D LUT block.
> >
> > v2:
> >  - In preparation of a simple pipeline
> > 	[YUV Full/Limited -> RGB] -> [1D LUT]
> >    Drop pre-CSC LUT from the pipeline as it has no use in a YUV -> RGB
> >    pipeline. This makes the pipeline simple since the block lies betwee=
n
> >    the YUV range correct block and Fixed function CSC. It can be added =
back
> >    when [RGB709 -> RGB2020] capability is added. Then it can be used fo=
r
> >    linearization.
> >
> > Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> > Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
> > ---
> >  drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> > b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> > index efd4375c4331..53e55ce0a5a3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> > +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> > @@ -45,6 +45,7 @@ static const enum intel_color_block
> > hdr_plane_pipeline[] =3D {
> >
> >  static const enum intel_color_block sdr_plane_yuv_pipeline[] =3D {
> >  	INTEL_PLANE_CB_CSC_FF,
> > +	INTEL_PLANE_CB_POST_CSC_LUT,
>=20
> With this we will expose support for post csc lut but corresponding handl=
ing in
> driver is added later in the series. Would be good to move this after pat=
ch 8.

Please ignore the earlier comment, enabling of SDR planes is done in last p=
atch
so this should be fine. We are good.

> >  };
> >
> >  static const u64 intel_plane_supported_csc_ff =3D
> > --
> > 2.50.1

