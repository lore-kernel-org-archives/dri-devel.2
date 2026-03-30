Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6211061B08
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027CC10E085;
	Mon, 30 Mar 2026 21:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RsbINhNf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B45D10E085;
 Mon, 30 Mar 2026 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774905410; x=1806441410;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LT+F/v01E/++PYgnLdiFmIKVrRpRzPQMdHRt4LM6I5E=;
 b=RsbINhNfp12oEq0siT921SbHs3DSuf2LKtDjVI0AuNDmQ6PG7ooTKbxI
 Fr+Eami8HUPX8m+TttrXnMXTFdqOM08MicbqgH8ycQnKW6jLPd7kyLvY1
 SZmgeCeC9uXw4j5nf2Az1/lr12Cvg9LEUycnEehndonHNfEuw810dFs88
 p710MvoXZDnoWp4KJrX5U5WGoagHo7v1T5/ZnHGu/m53PqgIJqu+gNx70
 UBud9BpNJOF8st0BSK5SuH3Gfn21HS/G5cxOWNvaQckAT10JS+N0LTfrC
 P6HidOSvhBiWsYZzi87s4W8pDSeHrp6L7W3V+ZyHLBZZRgTjV/gKPTXAr A==;
X-CSE-ConnectionGUID: wPyewZGJQKawXTAVyBw9ug==
X-CSE-MsgGUID: 5y5LNc9xSaeWTk3KwNJAog==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79810104"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79810104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 14:16:50 -0700
X-CSE-ConnectionGUID: 4w8TtrBbTwiN4xChMV6Wmg==
X-CSE-MsgGUID: 6k23tHf/QsGBFSgOQ/mTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="225181156"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 14:16:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 14:16:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 14:16:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 14:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz1Uhj0AyB4nZg2bQX4wXq2mHRmNlHE15JMIgw12eKEoiuWBPBdcogJai/sJctqb6qX+YBRU/PYq2MPBvWbcBisgm1MXm6pbWlR4VrIevgZ/BMEJ2Ew28kJdd0rxlQfkPrzS1yNv0kVBzkwYThNuw0LtwPS22vfvxan7r6R3yavSYnHMw77bdFqqf3CEhw/icsaaLzxKkPZvaRutmE9KFrIeMElbCaZagTsDq7x33YHJbyFY5ykwCJivY4MojdWIeR3QphdKqXH2j/Dt5vBznkhnrxMwjNpAeEFBHAaEwX6kOG1uiXV92DCoYMpvPlAaVrmUJ/K0fo2uSnX8K5S/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlCTVRfmeZjVrUJ5x10qFs4Rk25l6UbqYzElx14qDA0=;
 b=ldTHAwZIC79Jmjy3OvAebF9dlt5rCmFbusrAgLgbynrYCFVcEsWstnXW6e8nUBoXGl7iMhnyJ7+af7vrRrAnxLPgMoZElSlKJbdttkAsnCanpJD0nVulYhsjT3KafqpfE6uny8Tbco1WBvUTUU03tMH5VkL0jrE+JtSNINBhzxv8DBZBXuUBFcSScai/TdzjGZpxaQvt/fWBwl/Z/J+WDjfZCDQr2olzKhbmD7RCF2svJQK5jdykggh3/hV+29X8CNf/WW2ZDDTXAkN9+8wzlkRQ1l9gGGG/BNGFQEWgXPf98pBYCE5bIk6SKBUaxI0Ob1vGkDv5pfTD0wxsaWiCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 21:16:45 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 21:16:45 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>, "Brost, Matthew" <matthew.brost@intel.com>
CC: "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/xe/xe_vm: Convert comma to semicolon
Thread-Topic: [PATCH] drm/xe/xe_vm: Convert comma to semicolon
Thread-Index: AQHcvZpmrJAVvYbsvEWT1t78ibPR7bXHmO+g
Date: Mon, 30 Mar 2026 21:16:45 +0000
Message-ID: <DM4PR11MB545675CBDA15CE33979F9F58EA52A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260327032923.649869-1-nichen@iscas.ac.cn>
In-Reply-To: <20260327032923.649869-1-nichen@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|IA1PR11MB8221:EE_
x-ms-office365-filtering-correlation-id: a587d15b-6480-4d0e-bd96-08de8ea1a5e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NjrG7BjyHJfz+MVU8E25Qf4cA5LGTDoEB63lCZgAziLv4erOIW4Y9AvILaelJXa13nQH8r/SZnY9V9R+eMP0dYDGUVBT2V3ssDHxeSUCIGXkAANU45CkAriHn/UFrHc+pp1RqExjoH7/tJWy7s8EgncLLRRTx/k81VdzmbXqE6E/jf+UXO4mVPwcxsbXrfONasy1/V8vXnh1M3VskPfd2gZxo4qSZLOoqfa5NNM27XX3VEMRJuhdDwcl0HLTSEBbqq4ekBXQZt6gzFfiJ6FMXI8usi/ifYZCPJmpIs8UFzaR2VuG/xSEFg141pwcng/XX17xc/5fdXkr0tsxFqEc2UDlo2UOAPDp5XSSrJLDSwEIMnx2EVqglMwKZdBO0FqYCIVehqbEKBUb54YOLOd4J1ho52Mi8DPz1bHp4sr11gwtU11sob1Q7UOPaI20ve1xJ7Fr7IVyDMfCwHYOJuaAp7iNoGKxmUUxNUDAIoxhjkgMgdAkxkiryPxSVhahOLvG7SCiAuWDPwX3g9Kgr+ALQDZNvVwyRLA271dUgOyTNmJBk6c8vFoPx5Y/CmrOskN8NmiMyVXtugLcsA4qwutno2IJKjt3Lt3nRA1k0ITNb5HUIhwuZHfXfpTIbQnX1gOxGlTcmBBVKiHAcg75SDsVl2XT75cYLJ7PZJYfVXZGik9zeSlln818rZGwx0R2jvMcpVpd7Ju1kPXOgneR3zg7QE5vs5GZNruVXiPSZ9C45/vLir2fNWOVCDE4oDnqgYfVhZEufTa3+x2GW9OWIpoOS8BmXHkry1uM3EVXhHnIBow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5456.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oV/rhLWj/M6Fjfvw0V+jYBmOylAnQjycumAGYk8zTTAtcXd6kwbBKAtS3epi?=
 =?us-ascii?Q?bQ/6tJfxs4LiRtShRc2GxIvNChkWgqM+AWk+hd0pbjRWQ4cS72m+Q8OVEXr/?=
 =?us-ascii?Q?Jsq+OkJLG0PLXnW5t56Fk0Hhz8l+5lWgH/bNgH9oBdGt6ry3Nx4yhowAxpv+?=
 =?us-ascii?Q?x0L1uLAV1lT8o7DnrnWHVYiFu8Zc7zk+JBQg/Z8BRu958X4sF1kdQPRlU/5z?=
 =?us-ascii?Q?ksXrXax7PMbCZW1Zd/QDn46v6mOY/2hwaELJDDKvcICAtB6TNVVC8zn3sWq5?=
 =?us-ascii?Q?bAzvtPO7aYj4uMsdkga71QMaqEi5vOc8XKqsV8QhVXaaeQR/OQmpB3QA6SzJ?=
 =?us-ascii?Q?4DswnTcjBF4gcONy6l2GoeiR9LDOuLGyB/OZcx/HJzD3ZBL2qvtsd1LtdMif?=
 =?us-ascii?Q?5vqX4NKuPaJTiolBR1aJ9flu+6TPvTfpz/WxbqLSg0yEuKdPTZzsMVFJ5Un+?=
 =?us-ascii?Q?dc5LcJFanJEIytp8/mroVcHt8zzTiRikzhRLxKe25pbTH9SElYHMK7l4ikYC?=
 =?us-ascii?Q?wxZKs9uYSzPI/2kMjP5VjET97gjuT9JWx1M4YPqKOF03PUH2TJ5zxF3rFd8k?=
 =?us-ascii?Q?ojl8rxH3X9Cf+xRO5ulFL59z1Ri/dlr8P4t76pj9RUVlw70vBHR02D9tIuGT?=
 =?us-ascii?Q?5rhkrf2C5UjOb2FYM7eURkjxlRxX1p3xxh2mVI2P1YUe3ijez2Icd0jlPxlx?=
 =?us-ascii?Q?+Skz1gTihxSMqE+sPutGvCShgz8GV2REPF9rwTRCnEQah96GCM2FCFf6IAK1?=
 =?us-ascii?Q?3Zil9b2rEWSd3nmH9ZW1pd6djgTuKP2KgaSlSh/wE5/Mi6ZBifIrIvXKMyd1?=
 =?us-ascii?Q?OGMmeIoJldHjcjOy5Mm1S7xfHkwNZ9V4+ji5HJ/K8Yytt+INPIfamZ15stIw?=
 =?us-ascii?Q?OlIngb6zotOD9OMSf7buKzydjykqfDhctu89mV4UCv0v2WnLrtXzZrCTDdzD?=
 =?us-ascii?Q?Ley6UeeyldztyI6SCYbjHPY2lkIIv8WuD4A+S4usGpYP5PlVqKpJgii2ZXSL?=
 =?us-ascii?Q?31Fhp4Jzg8vrMdUiu2Ly4eYkCqCOcPK4WfpT0K1n3TXMRyYTZ9iy3zV3qqbH?=
 =?us-ascii?Q?bjNcmnrsYfQBuvOqXUf9qpOAVda8CLJBlE8Yrb3MkPn19+CcKFmejtD/Ufue?=
 =?us-ascii?Q?pzwcG1VKUzDZ+7C6ven8QgymPAIbyLSjX8GmXF0TNnchs4IZgjL8ma19lHPU?=
 =?us-ascii?Q?WKDwxkRL8Cb0fgKjj6Awvka1zubJS0q0+dgzypCCjdUAfMggjNdhsPO+6JVI?=
 =?us-ascii?Q?IDdbo0mknjpdQYMJqgcdnqbVBwQk7gxuGtMi7aE50uXOMThD71bizMbPJHvu?=
 =?us-ascii?Q?srIvZeLcf8Y/4lpnZAQlo4IpPnfkRybKanz4sQ1K5JupDoarOA/Gl5qsa7Er?=
 =?us-ascii?Q?8OLTHNBVSQQKCl32CzygJgAXEQZroP4u9cJaHd9zxQrxpiskomm+ik+boNjh?=
 =?us-ascii?Q?iIEAYcYEpzueWD25uhPVbiK7T1M+ADCUOHbK/ngKYAso1XvxQ0TZfrj6b0EO?=
 =?us-ascii?Q?jnmo4Ce+Z86oxn5EQpyT3cS0FXVd/AhIa2wnyZla6JEUrUbRY02HWSD+e7cZ?=
 =?us-ascii?Q?V8TPwdfae+qjv0cKaE1C/tjPlTteb8FpxQJN3eNQA/+cJ7/oYPTYyzvyT08b?=
 =?us-ascii?Q?Fzb3PxubBiaO1vQBIJYgKEU/RX8mv26lkK5hV65vl4AGIYEvKMysc8gHuL4o?=
 =?us-ascii?Q?11Ykyq6sm0lZUyjp2Q5/I9UqbCuFLGbUXbf0N4yJpsnJbKtNNNltlcXBuZex?=
 =?us-ascii?Q?lzq4i34psw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eyHE9N5yVaqDEbubzLF6G44KOPCb9effw5J8H665Gjgf2R2NF7NXfr7M333d0ee0bE5u1aQPannZAneGW897u6+BCAfWtTBEBGSxSyc9rE+m94T+VIJqsnYHDqzq3zthFMh5lE8z2XOLiH1OAbkCYVpNVi6YTwzVDxIaLxrCjmahbiNCIlWoCjYrnrTzeifRFQVWWADv/xa+j9x0nst/955dsVchG3/3eAyskd8WIFn+5IQg1mJ4blzg0OvOnxddIpQ8zFpucF05Vgxr4UVhEaaWtpFt/46//VEPzpzS4Z08ewAuBVQhFvWsCYqdfjG1cEFSaTEGQVW7K6hGHUyOTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a587d15b-6480-4d0e-bd96-08de8ea1a5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 21:16:45.6987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoeBpb9+leE1EfD7htNEfZEbgXr7wnYFlck+te+nfza5h6VaL2UTYK0ozvfcXthezotMdw2YnopZ52V9FVYmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
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

On Thu, Mar 26, 2026 8:29 PM Chen Ni wrote:
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it seems best to use ';'
> unless ',' is intended.
>=20
> Found by inspection.
> No functional change intended.
> Compile tested only.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

LGTM.
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>

BTW, it is blocked by the CI due to the mail address restriction. Let me re=
-send it for CI validation.
Thanks.=20

> ---
>  drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c inde=
x
> d96e0a0c5605..21844217dccd 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -626,9 +626,9 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm,
> struct xe_pagefault *pf)
>  	e->address_precision =3D SZ_4K;
>  	e->access_type =3D pf->consumer.access_type;
>  	e->fault_type =3D FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
> -				  pf->consumer.fault_type_level),
> +				  pf->consumer.fault_type_level);
>  	e->fault_level =3D FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
> -				   pf->consumer.fault_type_level),
> +				   pf->consumer.fault_type_level);
>=20
>  	list_add_tail(&e->list, &vm->faults.list);
>  	vm->faults.len++;
> --
> 2.25.1

