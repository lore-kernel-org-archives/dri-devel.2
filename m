Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EDEC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F99F10F85A;
	Fri, 25 Sep 2026 05:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="giv5mjn1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7F310E9ED;
 Fri, 25 Sep 2026 05:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790314135; x=1821850135;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MzbsUhPbA3u+ir26RweaN4XRbt8x+zVqcVelMfUadpM=;
 b=giv5mjn1cciAyhWq9XKh3eblUaCAwKqV5JF7OAznlRv1ocUnR2IfWB4E
 Gfoxq/86eThokYbNT/5tjcjaD7SorP0S+UOZWao6MlzD/D8we6EQKHmkm
 JskbhjPJHq4KnDykku24NcOHk8sU2Kil8peHo+G8GM/0FFwZQESDUPMkc
 Up+Rqb2UWCsHIGdHY5CruATeJgVdkXh9/aPfsRRTqEHIa9704T8fKHWU0
 gWJybzjhqjEg/DzpdTqwQu8u/LSrz/IiJHwsbqIh+ZuoRY3QoiwON9jOs
 aASf4FrrK2KeYW7MYYrzJtN6rKNqxXQl5tryO0S/CJ7ev0pJfdYJsZhPp w==;
X-CSE-ConnectionGUID: vlPgkAcZQQCZ6+ddylicmA==
X-CSE-MsgGUID: aliRpQ4jQLSD4s8NUtkBHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101675664"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="101675664"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 22:28:54 -0700
X-CSE-ConnectionGUID: 3ju5X3+uQuC1Ml3KcDnE3g==
X-CSE-MsgGUID: FlRd+M/XRXOaoLenOgq/gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="270716287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 22:28:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 22:28:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 22:28:54 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 22:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8li0uMcHPanMkqjXcwWNUYqNgjajRlVacbmbY8+Z/rcYqDRwNqocabwFj3Wzs3Q4d8KpQSwdi1igmJKkbTV/RUC4dpDYmtrqKlkQUlSlS14bwTHNX/XWD1nemiHJks4lKBD28bXteJUti25qBCn3CHw5MQmnC/BdHJkWg86FW/g6qzf6PvG9sgX1BZzjPEoSPsVtdqOchPuAOj+PkLe2wFpYdgvvTpkaD51evCkjmZ+jcswLQifO7F0KffXwkLYD46pGwVcWxdZZxTNAP184aqMiGYWVLg9L2GXmOvu+PbSQ7XTIkzZumgprDX1ECY1kRIpoWY30hWpKfak8H/OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVisR332qw6783wOt7cNwnuyRTn3U+07u/PhUU14t4Q=;
 b=IWg558JgFfAdcEI6a6ikLbCwI24x58HJYlLn9R55ZtsdcnYogxXfqsckLYCb3u6EXPaIgIZFw42ivc8IHDHkmajeMASPz0WSMeW6WSXm+Cg1GePnubkxS5fuHrIL6udZ9ABRiF+iUdTNUzhbeWaxNjF7oMoz6l2t7CbZmZwYGRd9+y3scmeN+yGPpAYPJfUZD203NcIty9RD51YIWMXpEceaa9O0p1Mfg3nW+AbSAWoQhpHO7wfuak3TvYQYNvRk00YUQZBrmpyDdqtbNySbC4WC+VAbR9DNCL9UPqO+Zjmjm+KGgidrZ5Wsnh6TCfqVLJKNjRzdq7BDKqJ2T2kKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by CH3PR11MB8362.namprd11.prod.outlook.com
 (2603:10b6:610:175::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 05:28:49 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 05:28:49 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Sworo, George D" <george.d.sworo@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>, "joonas.lahtinen@linux.intel.com"
 <joonas.lahtinen@linux.intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Sworo, George D"
 <george.d.sworo@intel.com>, "Kurmi, Suresh Kumar"
 <suresh.kumar.kurmi@intel.com>, "Nautiyal, Ankit K"
 <ankit.k.nautiyal@intel.com>
Subject: RE: [PATCH v3] drm/i915/hdcp: Fail fast when HDCP Type 1 is
 unsupported via MST
Thread-Topic: [PATCH v3] drm/i915/hdcp: Fail fast when HDCP Type 1 is
 unsupported via MST
Thread-Index: AQHdTK3mzBc70KNMqE6oFUOWFAfMc7bew9mg
Date: Fri, 25 Sep 2026 05:28:49 +0000
Message-ID: <DS4PPFE901A304F60485536DC4512108B87E3802@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260925035639.2034315-1-george.d.sworo@intel.com>
 <20260925052703.2068117-1-george.d.sworo@intel.com>
In-Reply-To: <20260925052703.2068117-1-george.d.sworo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|CH3PR11MB8362:EE_
x-ms-office365-filtering-correlation-id: 3e5c98e5-cab3-4ac2-4680-08df1ac5e0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|1800799024|38070700021|4143699003|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: jPZCTqCzI0fmufQfHOzMaHf7uJs/bmUYQsFgMSGmfmOB+Uv7HAbc2IjlycPNR5qUxcLK/okQvatexqlZYhK69+Dcqr2Wr1SLyHhMEinHc+dmb3jeGyJCb281wv/wdYhKPn/uk5beYTRNU/+mxiN2NB4zfGOYbJ2dLu7fIwOHknkkCd1H8Cd0NvuAS3qi3OOVeYIIl+45QRb9QLJrbudwm8aGsonliTLCu2Y7fY3TzynRIqBp4DUpXVr053B7X7xQN1G/LS6DoMnHVrNGxp9vQv9OeKwdZr5YpukE0GV4Dqa2hjCGdB8IjOvgRQUaLGbZhvonYCXdooJa1VZGocpcuZjrpZ7lVTnB7F43GqcLt8yJ0QBeOO3P5c05NAEA2N3Oi5RWEPDIUJvGbHBbC2L4ZlGmw9HcoonxmQ0XyIiXFshcyO9SVGUbZZLrEOoWWgCZoC+9jbUn3bCfDWOALCQC01dwl43yGhU7QULEoNByy9xjm5zKbcnhrWud2OJrYdQ7pvj8vFSOgRTYLcsfwxU0GwvVpKj8ZTrogCYWs6F2f2z/r3CAs6Rzv+4rRV4gj1zS1hifKRNTvfYUVqL2MpnrJNSarAr2SbBDYQXPNLpoKeIneSFHg24L5xZj8INJUzLGk2LEZi74One6qxMqR3lyRrq74W4TqSgJ4Y06edr5dlFdTPW4nSvLBSNOJP+Gl/zS0zP51MIeMLVFonxkw/4q3L9vCNBAip/F0IJqz6qjprA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wNhgENiOAwECY3s13Iytb7mUUTLZjHxAWe9CPBzoptDpB5NU0Y2xxBVMOU6s?=
 =?us-ascii?Q?+0sYMb0vFj6Pi3o/NJZXvzIvDQ2SylpPgrVXLMJP64BnDZwQ9ns7JZbMNUR7?=
 =?us-ascii?Q?Tx92MP07Ka3vUe+2mgnPa6Ol7PoJjPu5LCYB7l8QR1IKbS81LaPq/LIg7v2t?=
 =?us-ascii?Q?qDf/mSfol6/sqeBAkQBVUedVE73mMAliQvP6b0Hx0Gog7gVT/BgoqiMSxAmo?=
 =?us-ascii?Q?RrYoLJ0Klf+kSnmHmJNjYjm/aPsRExYmV5i5T65TCmss9SN+hNa47IebhGp4?=
 =?us-ascii?Q?qQeYbi7tYQ3ISIncCfGnvwO+ERWc+vGR05RYxLb0VkcERn2EhpW0/mUsfZhI?=
 =?us-ascii?Q?tq9tzGly3Y89T+Ppvx+7kEG0P2Uf6aYHA/Hp9d/PL1CqOmHjdjvtaEiDvWHC?=
 =?us-ascii?Q?y8cfSEHmBFEJuUNjyF+2XP5VOWK70/wzGhHSJ13Wcht5oNMbQQlPog77QRrx?=
 =?us-ascii?Q?q6X3xN/pQ5kJdDB1L2Patz8ybPRlGoN4EBsJGzwdx9rC5AgOJuwbfx728LqU?=
 =?us-ascii?Q?kUOGBs9pyozo1b7yznnLBYgvpiA+/ESjppE4gSPOryJa7LknZYJIgwqzNz/S?=
 =?us-ascii?Q?zm6LO/1ErLxkaKk5ID6hHBboeo+V2XscwNPxOdFSJd/iqQkVrfNG4h5up6rE?=
 =?us-ascii?Q?CD5mw5W2xmdZZmOgtcJzkHunNoCbgtKEXsYlGARcTBPXIYTt8EEYnpNZ1K6Q?=
 =?us-ascii?Q?v2Rb6CJ80AfhNQCMLLZMsEYwrYE/BI/VRf0hTMsqvop0JFZdabNaKVct3jtG?=
 =?us-ascii?Q?gjuSlOk8UxVeN2yhfxf4EjZrL6uMqmNfXBqkjyqOHOCaY279QW8ZVZKmu6Ce?=
 =?us-ascii?Q?dNwVYB+Jlydhz4pXDKkxnHJ5VKNRQTwJDCeTpU1rBHd0/2sBWAx9dW4Or6M/?=
 =?us-ascii?Q?mDh2DXBbeZ7nOhyVQ5O05MqPjvMlvQjFqAUwtjWnB5qWmTbVy2z39X2zmSEt?=
 =?us-ascii?Q?wfM3RgtDzmgqfZvbpc9Q4P+xhqw4NYRM1MZwSKL9Z8kjT8fwWx45O/0SB1EF?=
 =?us-ascii?Q?WGakWtLk2QVma0Bfp437+1h6byH1ohyuSDUzJ/qn+7+VJpEO2FSkkcTwpQ45?=
 =?us-ascii?Q?K0CHLdXowRS5hhhpd7E1Z59qZ8OVP7mo8kLDY1vli49QywftEUD11/7MUCfU?=
 =?us-ascii?Q?oGW43SGie4p7O07tcddLzkqydCXX8BIl8NtDiHwzi1J/1zBO2QCI++fvmLCu?=
 =?us-ascii?Q?9YSKN1vQh0qjeKIGqQTmSaimAZOmzVsvetwk/Gm+atHe0AtQQuX9uUpD5ZcC?=
 =?us-ascii?Q?l7zTacXzbXMboM18SGUUgJEdNV2sCrgytJF8SlC7ZjxewzExI/s8lFG39oxC?=
 =?us-ascii?Q?zK9X5wdZkwKYTkhme9FFJRfARuXLVfWYSsCVEGyrmtThUIp349vV+KzBx3T8?=
 =?us-ascii?Q?oErrKFte1JxFMhA06joI7v/D/fjlw+7P5YyhzMrxpGKysDyssU/9Ny/dKWb+?=
 =?us-ascii?Q?A+0298q1NNmAe73k2zw7ANots5IcPD07t3Ipyfsjht/V880bpjGOyLGDOMTQ?=
 =?us-ascii?Q?8JxxhJjzNRgLATx0jGu7JhISpHkILBeZAJ6aZ0s1+JangWwysvo3IV3XWfYw?=
 =?us-ascii?Q?8KAzIWC3CHqGr8dferob46O6Sgq08OKYu1d6zdDJl6ZTAIeTRFfTDu+0a9ee?=
 =?us-ascii?Q?OGlCbo6E5IO8bWDlLNFFiv9MPn8NWxA8B/gsdJQIHUsQHbUNDU3TTJDNfVId?=
 =?us-ascii?Q?kURw3MLfIIgdUHDTMl6+5Fk4z6hdneAEDiO9Yr8cJL/QMnSIpmmw7t3gDSy9?=
 =?us-ascii?Q?rtBNZbKnoaPDgVS4pIlxD9EMXrVvBSwHZ6r8y7ERpwXaBbrjj1/O71o6t7Pb?=
x-ms-exchange-antispam-messagedata-1: hXGCYbkw3UuOLQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HtGFX/ErI32YcMP+kZgAXf1AsXeLhjoGhWFUfxxvveM0lv3H2zEqqPwb7q8VwlBdiivHcuqMF9dVeqEgyh8ZWFN4DcQlyPgmqsBsmVihojxdx+mUqdtInJ+48pBl0u8CxE5SsSdihGWb063koTELPBcl9BJk36WVcKqg8ZWF7+p34EvPH0O+yUyYzRY/VD5mMqgrSwlICHAoDLpwIMDrP0Ab+H7sbDHD+1MOG/+B7ZoRepXfU9WvLf7XMDa5geeEEV4aNpLBRfEagrE3PdGJc4Xs76msGuo3ZKSmk/xWz2oOi+sdW1yRHvH3DeWdyJHRSHwm43hw5t46zwxi0EvqVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c98e5-cab3-4ac2-4680-08df1ac5e0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 05:28:49.0679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVwBQGCrJvLukzqcWCpesxxWD25+6oKkqchePQtG0ONlkdtXQvJnzp65NC5laQkBmAE1BIScWVCQSWv1u8tdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8362
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

> Subject: [PATCH v3] drm/i915/hdcp: Fail fast when HDCP Type 1 is unsuppor=
ted
> via MST


Do not update this fast comments given in v1 are still not addressed this w=
ay comments will end up getting lost

Regards,
Suraj Kandpal
>=20
> HDCP Content Type 1 requires HDCP 2.x support from both the source and th=
e
> downstream MST sink. A request for a sink that supports HDCP 1.x but cann=
ot use
> HDCP 2.x currently passes atomic validation and fails later in the HDCP e=
nable
> path.
>=20
> Query the downstream sink through its MST remote AUX channel during HDCP
> initialization. Cache the result only when the sink reports HDCP support =
and
> either the source or sink lacks HDCP 2.x. Treat a missing callback, probe=
 failure, or
> no reported HDCP support as unknown and non-fatal.
>=20
> Use the cached result to reject unsupported Content Type 1 requests with =
-
> EOPNOTSUPP in intel_hdcp_atomic_check(), and propagate the error through =
the
> digital connector atomic check. This keeps remote AUX transactions out of=
 the
> atomic check path.
>=20
> Signed-off-by: George D. Sworo <george.d.sworo@intel.com>
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c
> b/drivers/gpu/drm/i915/display/intel_atomic.c
> index b66c2d4ba2b3..c6383e27e62b 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -123,8 +123,12 @@ int intel_digital_connector_atomic_check(struct
> drm_connector *conn,
>  	struct intel_digital_connector_state *old_conn_state =3D
>  		to_intel_digital_connector_state(old_state);
>  	struct drm_crtc_state *crtc_state;
> +	/* Propagate HDCP capability failures during atomic validation. */
> +	int ret;
>=20
> -	intel_hdcp_atomic_check(conn, old_state, new_state);
> +	ret =3D intel_hdcp_atomic_check(conn, old_state, new_state);
> +	if (ret)
> +		return ret;
>=20
>  	if (!new_state->crtc)
>  		return 0;
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 79f30660c2b6..1c169849e502 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -605,6 +605,8 @@ struct intel_connector {
>  	struct {
>  		struct drm_dp_mst_port *port;
>  		struct intel_dp *dp;
> +		/* Used to reject unsupported HDCP Type1 requests during
> atomic check. */
> +		bool type1_unsupported;
>  	} mst;
>=20
>  	struct {
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 7023619aaaba..da54699fb121 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -1838,6 +1838,7 @@ mst_topology_add_connector(struct
> drm_dp_mst_topology_mgr *mgr,
>  	connector->sync_state =3D intel_dp_connector_sync_state;
>  	connector->mst.dp =3D intel_dp;
>  	connector->mst.port =3D port;
> +	connector->mst.type1_unsupported =3D false;
>  	drm_dp_mst_get_port_malloc(port);
>=20
>  	ret =3D drm_connector_dynamic_init(display->drm, &connector->base,
> &mst_connector_funcs, diff --git a/drivers/gpu/drm/i915/display/intel_hdc=
p.c
> b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index e56df337dc6d..b6f28dc3e5c4 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -312,6 +312,39 @@ static void intel_hdcp_get_remote_capability(struct
> intel_connector *connector,
>  		*hdcp2_capable =3D false;
>  }
>=20
> +/* Determine whether atomic check should reject Type1 for this MST
> +sink. */ static bool intel_hdcp_mst_type1_is_unsupported(struct
> +intel_connector *connector,
> +				    const struct intel_hdcp_shim *shim) {
> +	struct intel_hdcp *hdcp =3D &connector->hdcp;
> +	bool hdcp_capable =3D false, hdcp2_capable =3D false;
> +	int ret;
> +
> +	if (!shim->get_remote_hdcp_capability)
> +		return false;
> +
> +	ret =3D shim->get_remote_hdcp_capability(connector, &hdcp_capable,
> +						   &hdcp2_capable);
> +	if (ret)
> +		return false;
> +
> +	return hdcp_capable && (!hdcp->hdcp2_supported || !hdcp2_capable); }
> +
> +static void
> +intel_hdcp_mst_update_type1_capability(struct intel_connector *connector=
,
> +					       const struct intel_hdcp_shim *shim)
> {
> +	connector->mst.type1_unsupported =3D false;
> +
> +	if (!shim || !shim->get_remote_hdcp_capability)
> +		return;
> +
> +	connector->mst.type1_unsupported =3D
> +		intel_hdcp_mst_type1_is_unsupported(connector, shim); }
> +
>  static bool intel_hdcp_in_use(struct intel_display *display,
>  			      enum transcoder cpu_transcoder, enum port port)  {
> @@ -2421,6 +2454,9 @@ int intel_hdcp_init(struct intel_connector *connect=
or,
>  	if (is_hdcp2_supported(display))
>  		intel_hdcp2_init(connector, dig_port, shim);
>=20
> +	/* Cache the capability for the currently attached MST sink only. */
> +	intel_hdcp_mst_update_type1_capability(connector, shim);
> +
>  	ret =3D drm_connector_attach_content_protection_property(&connector-
> >base,
>  							       hdcp-
> >hdcp2_supported);
>  	if (ret) {
> @@ -2652,6 +2688,8 @@ void intel_hdcp_cleanup(struct intel_connector
> *connector)  {
>  	struct intel_hdcp *hdcp =3D &connector->hdcp;
>=20
> +	connector->mst.type1_unsupported =3D false;
> +
>  	if (!hdcp->shim)
>  		return;
>=20
> @@ -2684,10 +2722,11 @@ void intel_hdcp_cleanup(struct intel_connector
> *connector)
>  	mutex_unlock(&hdcp->mutex);
>  }
>=20
> -void intel_hdcp_atomic_check(struct drm_connector *connector,
> -			     struct drm_connector_state *old_state,
> -			     struct drm_connector_state *new_state)
> +int intel_hdcp_atomic_check(struct drm_connector *connector,
> +			    struct drm_connector_state *old_state,
> +			    struct drm_connector_state *new_state)
>  {
> +	struct intel_connector *intel_connector =3D
> +to_intel_connector(connector);
>  	u64 old_cp =3D old_state->content_protection;
>  	u64 new_cp =3D new_state->content_protection;
>  	struct drm_crtc_state *crtc_state;
> @@ -2700,7 +2739,20 @@ void intel_hdcp_atomic_check(struct drm_connector
> *connector,
>  		if (old_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)
>  			new_state->content_protection =3D
>=20
> 	DRM_MODE_CONTENT_PROTECTION_DESIRED;
> -		return;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Fail fast if userspace asks for Type1 but neither the platform nor
> +	 * the downstream sink can do HDCP 2.x, instead of only discovering
> +	 * this once intel_hdcp_enable() is reached.
> +	 */
> +	if (new_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> +	    new_state->hdcp_content_type =3D=3D
> DRM_MODE_HDCP_CONTENT_TYPE1 &&
> +	    intel_connector->mst.type1_unsupported) {
> +		drm_dbg_kms(connector->dev,
> +			    "HDCP Type1 requested without HDCP 2.x
> support\n");
> +		return -EOPNOTSUPP;
>  	}
>=20
>  	crtc_state =3D drm_atomic_get_new_crtc_state(new_state->state,
> @@ -2725,10 +2777,12 @@ void intel_hdcp_atomic_check(struct
> drm_connector *connector,
>  	     new_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)) {
>  		if (old_state->hdcp_content_type =3D=3D
>  				new_state->hdcp_content_type)
> -			return;
> +			return 0;
>  	}
>=20
>  	crtc_state->mode_changed =3D true;
> +
> +	return 0;
>  }
>=20
>  /* Handles the CP_IRQ raised from the DP HDCP sink */ diff --git
> a/drivers/gpu/drm/i915/display/intel_hdcp.h
> b/drivers/gpu/drm/i915/display/intel_hdcp.h
> index efe86808e17e..34661b074784 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.h
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.h
> @@ -22,9 +22,9 @@ struct intel_hdcp_shim;  struct seq_file;  enum port;
>=20
> -void intel_hdcp_atomic_check(struct drm_connector *connector,
> -			     struct drm_connector_state *old_state,
> -			     struct drm_connector_state *new_state);
> +int intel_hdcp_atomic_check(struct drm_connector *connector,
> +			    struct drm_connector_state *old_state,
> +			    struct drm_connector_state *new_state);
>  int intel_hdcp_init(struct intel_connector *connector,
>  		    struct intel_digital_port *dig_port,
>  		    const struct intel_hdcp_shim *hdcp_shim);
> --
> 2.43.0
>=20
>=20
> Thanks for the review.
>=20
> You are right: the cached Type1 capability is only valid for the current =
MST sink,
> and it must not outlive a hotplug or topology change. I've updated the pa=
tch to
> clear the cached value when a new MST connector is created and when it is=
 torn
> down, and to refresh it only for the active sink.
>=20
> This keeps the atomic check AUX-free while avoiding stale results across =
MST
> hotplug events.
