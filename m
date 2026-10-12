Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661C0CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE73110E4FB;
	Mon, 12 Oct 2026 08:11:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9017C10E4FB;
 Mon, 12 Oct 2026 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791792665; x=1823328665;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1S/ZmBFeoPhobycYNUUJreb6VeSSiIoUj/CuRCTLrWc=;
 b=Twae8RbNO85waahfptgN1Wmmnhwa0jCxOnDhGu5y/idpIo+h2KFxeCr1
 018qT80mTH9TtwP+dtzEZL087ZBc0O+Uf77hsEH6ynnM1pEPokbRuZ9XH
 3zr/wEG9ghIQXZj2sq6jE+6sZ97qEKcHs2Mwy16i11/wXHplZ7aY4QaHJ
 L41rjSFc+NWXggkJdNI5VY6F22E6N7gR0YDDTpzRXsATkQDyWNA1q/TFH
 CLjD8EdF7em3QxAgC8ag3tqTSYCctZRlJaAby7GigT4NG4dx0n3AzGYZk
 05vSIMcvwgdYxENExDc1/zzmOYCuEeDplPeXr/cJEcx+wBzt0Yi2BOT9t Q==;
X-CSE-ConnectionGUID: RFfOhqSvQpe71ZvzvqW6dg==
X-CSE-MsgGUID: TcBj2kdlTom3OQjgioiK2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="502361"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="502361"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:10:56 -0700
X-CSE-ConnectionGUID: ChK8IXYHT1K8MLs9M6obkw==
X-CSE-MsgGUID: 81DD8upDR7629IJOwps9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1139244"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:10:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:10:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 01:10:54 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nukxCfFD4H1o2BaMK7zGhJELT2zBwy9gaUFBSJuKT4HNbO5+detjIS/vvLvd8VhyBJu9xtuZjf2IoCfaKWm+ZNAhcDDP96+isrdQWaf8rVfQlQmTiJPk6/Zi812RBOVVbBTI3Fs8L+qeL9pnsscJHAV8E62B2ZW0frX+irNk7XHaiiIdrZQ+fYpnSNOOCJnP0WyOKkjq+Yu0+6WQ8ccIECkcIKgZdMbdUNgfmTkOr8o/XQDp2KS3beB9O4DNRIZwra+nGjLSNzV+iNmZFmtmRBaqswbSH0mIDcZegWOLAO37IGCvu8JLHvnNuuMDv0GpPHQXkG9Vpd5oGyx15WH/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWtc4rib/Xude3gDuyd2oaQShyeSq0WWBtTuG+7QsM0=;
 b=nrvoZPBmPOyErWliql2gEDfV/XeoBgcRi1GannMU8hPquk3bLaOLMntOaoY9YWnsV8bsRKTIg/CdaPSxt/AVoqKb34JfWxGqtwAFWhwe8kf4TbXHV7/XV5p6bw26F/5YJgHvM7Kb7NXCfo0JiCdD/h0pjy5IFGZ8JmSkKGmXKkfBkfb5lEdV4kKFYQ4hRttlrvSII5thh5TNSnR2s1Denq/p2YwVAu5X4jSquvv11IzWwHFZc1X9ZgsbU/GHDaLUjBfXHe1LGDbWo6i9+6RQAyPWQkqi35DnpRQiiXmpsloOkaB1oGPOr4A9h/OmgNrkXTQeQdtd0N0l2WYc7fwVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) by
 DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Mon, 12 Oct 2026 08:10:52 +0000
Received: from DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680]) by DM4PR11MB6360.namprd11.prod.outlook.com
 ([fe80::22d9:ae03:5db1:680%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:10:52 +0000
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
Thread-Index: AQHdWgArThbKQRrWdEWg2IfuIbuzK7b5aIWQgAAjx7A=
Date: Mon, 12 Oct 2026 08:10:52 +0000
Message-ID: <DM4PR11MB6360F63833370F161C739135F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
 <DM4PR11MB6360A316EEFBC2EEBB7EFA43F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB6360A316EEFBC2EEBB7EFA43F49F2@DM4PR11MB6360.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6360:EE_|DM4PR11MB6503:EE_
x-ms-office365-filtering-correlation-id: f87c31fd-b8f9-4a3f-e27a-08df28385536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|260925021311599003|260925022911599003|260925021911599003|10067099003|261009223027099003|38070700021|5023799004|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: qqf/7l4YTyvhWvIHLFnhZqE9unwmHqSBPtf4j0shpSXFIudBj8GuHFH0Q54IgB1ilVdHjLvgir+Zw9d9euZcK6a/aXCfkzdgGG/CiZP4x285xADwyB/XD7T1HaK60VQBVVryt9Vlu4zi25l3JeiEjAoEhLxenIagm7txWvFVy5VUz2kxXSqnFyUYD9sZI4qNwGaOffYk0XQF0SQXkz5cOylW2ta5duVt2+rSkHejPXSgkrF7HDo09hYz3sHhgyi/b1wwprFRoixcW2uT/JzXpJxf5e0goUVCZqz96tc74t68amUNoNncQ4R5YWfdlm7Q1oW7wefPzcR0nflBo3ce0cvfoI+5iRlRwYTEjB2UW0o5x7tb6T8ZjabGSTnLP+pg0uRLnH/0jf9bhZyw98AXsZNV3FpIRhQSmIaccY63mQs0P/DEXZvvT0S7QdCMH7FxydGQVYXedGYNIyCJBdwZu7zMuire9gkdbpjNoANd3iGs0p/oFKRjpes2uRmhquNehU6zeoo/vkRXwEFd6pWSzitAMp2uRahgNS5pO1q87fQThbFTMVgzoWeskBsoC73ZJwvOcGuCyIzo9TyvEThMqK0TggkokEc9a2+HSvzezBk14RwUKP5gPRly969RL2ulkDlgKgb8xJiNrnCu9G0u9SKeDAqsyAdAc+76I4KjP2AgJKXP2U/zmVUiqDZuBr4ngQaGHaILyRUeVntb0Q8cFac9z96qpfFnc/wqN072RnQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6360.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261009223027099003)(38070700021)(5023799004)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FjQ2EaLiVEuZULm74COxa9Arr4PUiYVOPLxtLQRAZ+hXJ/jab4D2EZ6VMa7b?=
 =?us-ascii?Q?BeaRPO3p22gl41T7m7C1A6aaNTfZpGV5/oV5nkDTt6zqSiQ2zTCKNNgYcI4T?=
 =?us-ascii?Q?wjQ2v/YzpzedBCwnDsO1zP6nBhHMt9k9D+7lUsGECcns+zzVjpOPpwpdXHVJ?=
 =?us-ascii?Q?TJrPsyd8bwfgORg/a+Ufhw8P6+D9qQf9T3JWdUg6Rsz2F9yFx6LfDKr4LGWR?=
 =?us-ascii?Q?t4xhnqrhcjuTdoU55tp+vWks1Hk1yIFelmuqfExVzme4Up3n0q3M5yrb5Flv?=
 =?us-ascii?Q?jbHN80DEIQxNLlKtSUnUS6nS2ctqTSWxnU8vbG5gY022lB5ckE2ByZ+lCP1G?=
 =?us-ascii?Q?GHAyvPfgzKupmzM8CbuWtDdXmlf0gI8qkHEEXfoEeRCaNBv84TIri99Pcc+s?=
 =?us-ascii?Q?j6QewsSe+gfi8hA8bsYVSQJvTDBwohx8opo2dN1aQk8A6kaW5es4fqgN4kYH?=
 =?us-ascii?Q?+P0kkA2gC3YayOjyOu5YnoJyGeQ2anKEzmsMHo67ajFalAHwhm+g3lYpWsNx?=
 =?us-ascii?Q?gKpdDfW1uvZexwtR8EOfqdaV/eZxddDq/Q7dLgoLVc5TtotHs3YItH3+FFMl?=
 =?us-ascii?Q?hhGmwAkgDU/VzrheWVvQpU+9ZPbe2558WuAt1N9yONha64tv/IjQYgExYX/B?=
 =?us-ascii?Q?k+h9iDLnBLAGAcY4u2Ox+4+Qh+X3DxiSjQEft+1Oy6zELBcSbnUTuN3cNTH/?=
 =?us-ascii?Q?ElW6+s338Fyqg6eZWef2KqTU5/5rGWv4C/Dw/rHm9++uJ1KPnYbpU0/pIL/N?=
 =?us-ascii?Q?oP55MHH/HFlTh3K/S+199uStVY2mL1SzZX6msAYxGoqPO+yRCAuF7Asq9SHG?=
 =?us-ascii?Q?ICOlkagWxWo7CGZuaWyHnOoaK50+qlqScoN2bjDs+S8PPljtelX1VzJFHkg1?=
 =?us-ascii?Q?Y20hiPt8gh+Hav0SyFFtyBXkW+zmyEIOYPu+grwQ46YX0FOnq5tF+ohEV5+l?=
 =?us-ascii?Q?IFmaVGLv3cY606qJPs2iMlTXrriWwb86Pwr+muFqoQa2Pvtp/LTLVLlYDrZP?=
 =?us-ascii?Q?OHuC7z7KFoQQMI1J3YY2isLo/pkK1RsVOwS1KMtEEgTTnX3XYaSOUG6XCfRP?=
 =?us-ascii?Q?gDLswtb+5hk+rrvJNxZh5SWotMnGWPGOtmkz8KD6li/Ygh2s3VmQILpcB4of?=
 =?us-ascii?Q?wTQMr5JAONxxXaK8lnj8tBvbH5LPRlhGGF2SRO57rHIz7OZcJRGUYRMitSFP?=
 =?us-ascii?Q?am8a+ZTdMKDZTEz9Yp+eSrTZUU+Sjvt+DnxTTqjDIur7PcK1HT2X11AC38jm?=
 =?us-ascii?Q?ZddxxlJLYMBMid+W1Vkxtw0APoJUjLuukmaCZ1S/yjeiakyPgMlLmnCGUpYO?=
 =?us-ascii?Q?VnpuaxXDY0pZbS+eSmdbsYmv/vWivkEUl1j9qDrH+5NvGYH3Jc7roWaGq5k3?=
 =?us-ascii?Q?r/L1gYYeag6Hb72e8qeMsKVV+hg5tcCrCfsRmOfi59MCPdUN+bFpTkbBvIAh?=
 =?us-ascii?Q?dZQqB+gdWPj26AqCWS70j4cKslyHvL4AU0EkHkYAP7znVbraYOXT5gtkD9Ij?=
 =?us-ascii?Q?kUkS2ii1zgsoifqk+R7oTtUWGJPOLSDiyLPAmmo6yCpRxfZ0GkxTKvN+rBPn?=
 =?us-ascii?Q?PB2sEWG45vAcXudPvCh5QOHEKIEwVia9cDn7eE6hDOV6oneqW6Yar/oqPB0O?=
 =?us-ascii?Q?XmN+1dO/IEn1Ua5/ixUIGUeCr7eufEDi6FbcdUBT6d5MqR+v/BRY7nfHl4UR?=
 =?us-ascii?Q?iArFEo0ZhpfVQ3lGCxdCKekmix2wG6mwKvX2LnKAuxvUrIJB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mY4WitbeLZNSWtyt6ZNQ9ZIVpS8p36V8ZD7ciWVqBQi+e+U5gK4/fDbNBbGgldCjrlF414ujzA84jFBPW/05L0uJ/1Cd+x1b31sLCLoz0yLI8boYifMQj68EyGqRAohYHLE+z2WH1t8CpIcbfYv3eDORy6smB84yLFJbVaBDzKx/grp3JseUxmbuyWEolGQKAjF8tgxA9rzPsRmt3AAEWgQdHNRAu/PYbVxkv3s6U4sI8gGjOWZ0a6qv4ToMXfwW8x/HsXLWvfOdm45vLWdBCzQh+M6VWino8W0r7MfTKLDb+OatjOdSNLuIZbyUGMR/dk62teN3QTVm7rApgMIWjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6360.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87c31fd-b8f9-4a3f-e27a-08df28385536
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:10:52.2536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5bSekLokz17jgQ4orQbMi6yUIsbPWfWEcBpls6X+YPl/4gKXpfpaBvA6TCpMF01iPeq5UtqhYwkan4JVmgAZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
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
> Sent: Monday, October 12, 2026 1:31 PM
> To: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>; intel-
> gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; jani.nikula@linux.intel.com;
> ville.syrjala@linux.intel.com; Kandpal, Suraj <suraj.kandpal@intel.com>
> Subject: RE: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from=
 VBT
>=20
>=20
>=20
> > -----Original Message-----
> > From: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>
> > Sent: Monday, October 12, 2026 9:27 AM
> > To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org; jani.nikula@linux.intel.com;
> > Shankar, Uma <uma.shankar@intel.com>; ville.syrjala@linux.intel.com;
> > Kandpal, Suraj <suraj.kandpal@intel.com>
> > Subject: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from
> > VBT
> >
> > From: Vandita Kulkarni <vandita.kulkarni@intel.com>
> >
> > Parse the maximum FRL link rate from VBT and store it for use during
> > FRL mode selection and link training.
>=20
> There is nothing getting stored here, maybe rephrase it to expose helper =
to get
> FRL max link rate.
>=20
> >
> > v3:
> > - Bail out early for VBT version < 237 and resolve the max FRL rate in =
a
> >   single switch, handling hdmi_max_frl_rate_valid =3D=3D 0 up front.
> > (Jani)
> > - Drop the intel_bios_hdmi_max_frl_rate() encoder wrapper and take the
> >   encoder devdata directly. (Jani)
> > - Use the standard VBT debug message format. (Jani)
> > - Spell FRL and VBT in caps in the subject and debug message. (Suraj,
> > Jani)
> > - Move the hdmi_max_frl_rate_valid =3D=3D 0 comment onto the check it
> >   describes. (Suraj)
> > - Add Bspec reference. (Suraj)
> >
> > Bspec: XXXXX
>=20
> Put a valid number here or drop it altogether.
>=20
> > Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
> > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_bios.c     | 39 +++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
> >  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 ++++
> >  3 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
> > b/drivers/gpu/drm/i915/display/intel_bios.c
> > index 7b6a6f8c3cf1..7181237508b3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_bios.c
> > +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> > @@ -2788,12 +2788,45 @@ static bool is_port_valid(struct intel_display
> > *display, enum port port)
> >  	return true;
> >  }
> >
> > +int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data
> > +*devdata) {
> > +	struct intel_display *display =3D devdata->display;
> > +
>=20
> Add a check for devdata as well to protect against any NULL pointer deref=
erence.
> Good to combine that with below check.
>=20
> > +	if (display->vbt.version < 237)
> > +		return 0;
> > +
> > +	/*
> > +	 * When hdmi_max_frl_rate_valid is 0 the VBT does not specify a
> > maximum
> > +	 * FRL rate, so don't use it to limit the FRL rate on FRL-capable
> > +	 * platforms.
> > +	 */
> > +	if (!devdata->child.hdmi_max_frl_rate_valid)
> > +		return display->platform.meteorlake ? 12000000 : 0;
> > +
>=20
> Why special casing for MTL, or update the comment.

One additional thing I missed, this will cause disable FRL on newer platfor=
ms
if this VBT setting is missed.

enable_frl =3D true is dependant on an AND condition with this expected to =
be
non zero.

>=20
> > +	switch (devdata->child.hdmi_max_frl_rate) {
> > +	default:
> > +	case HDMI_MAX_FRL_RATE_PLATFORM:
> > +		return 0;

Also as per VBT spec,=20
000 =3D Default (Software should choose the maximum data rate as supported =
by platform BSpec)

However if we return 0 here, it will disable FRL altogether. Please check o=
nce.

> > +	case HDMI_MAX_FRL_RATE_3G:
> > +		return 3000000;
> > +	case HDMI_MAX_FRL_RATE_6G:
> > +		return 6000000;
> > +	case HDMI_MAX_FRL_RATE_8G:
> > +		return 8000000;
> > +	case HDMI_MAX_FRL_RATE_10G:
> > +		return 10000000;
> > +	case HDMI_MAX_FRL_RATE_12G:
> > +		return 12000000;
> > +	}
> > +}
> > +
> >  static void print_ddi_port(const struct intel_bios_encoder_data *devda=
ta)  {
> >  	struct intel_display *display =3D devdata->display;
> >  	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt,
> > supports_typec_usb, supports_tbt;
> >  	int dp_boost_level, dp_max_link_rate, hdmi_boost_level,
> > hdmi_level_shift, max_tmds_clock;
> >  	enum port port;
> > +	int hdmi_max_frl_rate;
> >
> >  	port =3D intel_bios_encoder_port(devdata);
> >  	if (port =3D=3D PORT_NONE)
> > @@ -2863,6 +2896,12 @@ static void print_ddi_port(const struct
> > intel_bios_encoder_data *devdata)
> >  		drm_dbg_kms(display->drm,
> >  			    "Port %c VBT DP max link rate: %d\n",
> >  			    port_name(port), dp_max_link_rate);
> > +
> > +	hdmi_max_frl_rate =3D intel_bios_hdmi_max_frl_rate(devdata);
> > +	if (hdmi_max_frl_rate)
> > +		drm_dbg_kms(display->drm,
> > +			    "Port %c VBT HDMI max FRL rate: %d\n",
> > +			    port_name(port), hdmi_max_frl_rate);
> >  }
> >
> >  static void parse_ddi_port(struct intel_bios_encoder_data *devdata)
> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.h
> > b/drivers/gpu/drm/i915/display/intel_bios.h
> > index 196b8b3f434f..b89f72d90c1f 100644
> > --- a/drivers/gpu/drm/i915/display/intel_bios.h
> > +++ b/drivers/gpu/drm/i915/display/intel_bios.h
> > @@ -112,6 +112,7 @@ int intel_bios_hdmi_boost_level(const struct
> > intel_bios_encoder_data *devdata);  int intel_bios_hdmi_ddc_pin(const
> > struct intel_bios_encoder_data *devdata);  int
> > intel_bios_hdmi_level_shift(const struct intel_bios_encoder_data
> > *devdata);  int intel_bios_hdmi_max_tmds_clock(const
> > struct intel_bios_encoder_data *devdata);
> > +int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data
> > +*devdata);
> >
> >  void intel_bios_for_each_encoder(struct intel_display *display,
> >  				 void (*func)(struct intel_display *display, diff --git
> > a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> > b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> > index 0dc13d080e8a..db7484542dc0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> > +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> > @@ -381,6 +381,13 @@ struct bdb_general_features {
> >  #define HDMI_MAX_DATA_RATE_340		4			/*
> 249+ */
> >  #define HDMI_MAX_DATA_RATE_300		5			/*
> 249+ */
> >
> > +#define HDMI_MAX_FRL_RATE_PLATFORM	0			/*
> 237 */
>=20
> Use 237+ to remain consistent, do it for all.
>=20
> > +#define HDMI_MAX_FRL_RATE_3G		1			/* 237 */
> > +#define HDMI_MAX_FRL_RATE_6G		2			/* 237 */
> > +#define HDMI_MAX_FRL_RATE_8G		3			/* 237 */
> > +#define HDMI_MAX_FRL_RATE_10G		4			/*
> 237 */
> > +#define HDMI_MAX_FRL_RATE_12G		5			/*
> 237 */
> > +
> >  #define LEGACY_CHILD_DEVICE_CONFIG_SIZE		33
> >
> >  /* DDC Bus DDI Type 155+ */
> > --
> > 2.50.1

