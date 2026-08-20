Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D869C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF52910EBDE;
	Thu, 20 Aug 2026 18:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lyT52gqj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522E710EBDE;
 Thu, 20 Aug 2026 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787249734; x=1818785734;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m7Mklb3KdoTjYjbNW4dVzv+olUX/N9be9t/d4uNsqFE=;
 b=lyT52gqjlgrVFxk+yKmjKucGd33bpbizDU1jtzLCaZ1VFMcQwrRJ5lE4
 WAybAHk8Sn39mKc8VVcEPeJPwcTLoXhMvpaxKRBfl6D0HBUOlcnaMWZ/C
 MXhsCBNPBJILtSY/MFXSEYy9h0BXP3NhQQBj53LsQZ7edSNzX/B/Ahtv1
 989aDvOwQLcrb8aSxPIuRAgOzEjZalpg5wyBsKzYUank5IpnqBEyfIQMj
 PmTDKOkl68Jv3keRWHHrYNdYi8Dnsh76/ALpQ0dInQL0/YWuvROX3L9Nw
 2oKw8OcNPc/22UOLWBr35bf5HYdQWEy1L8UVgl6LXamJaJp+5WbRSK2pL A==;
X-CSE-ConnectionGUID: ODUmU4YDRc+Ctn6kKCTMBA==
X-CSE-MsgGUID: 5gY9w38vRra0qcX0HkO9lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87666282"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87666282"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 11:15:34 -0700
X-CSE-ConnectionGUID: xLRCV8bTTLGvi3HR6WC+Kg==
X-CSE-MsgGUID: Tzvu8fHgQhKmkjXO1JD7LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="296036204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 11:15:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 11:15:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 11:15:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 11:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg2mQHTtJvBJ+81gwpzPWr62agc1DcbI1Y2qMeemZR1llQT8Cw9wDjcBYK3tp1rxc1UEdpNx5Cs8O1+6fvE23u5KRyDIYiMpw8DiTyKQWKk9IAv2a8LMzRxo3EAioaq2xGMCHTKK6Ql8nAZRAltT3ybp3oP4T6a17va/F/iZ82gQ1NMGasjTriWG/t4VfL1XE8GHjqd0KBRxjPtm4v1t8xHDolX+FF+dI7HzP75+hwZH9wU7QKH5CNRELOeWQhUmzouS8s2bJkRtabwi1DTJaL+079aoMV8kTdwUJprTDkCiG4P23XWqguB+SdrT8Ag4g7/wgDIlMlpCiSe0TXwHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIEth2gfL4yQVwEZA+5kvqNKEL6ykY+PZWCmInlKd/E=;
 b=EFp7Rgf+kJjKA0Kw81kkrNcMy0ck54U0fIkW3oFahIW519EpN8+/Mv8IBdBQvmuyoAWXLzNYeHfF6WqBaCmUip44TWAhc3imEebcP4iz7yrk5ID258+rR2n0ObkjarQLzGA5+qchmwalRZb+6spz6PnsTmZ/hllf+oyrPNbLc3OBP99ysnPZEdv6CXUccH7dVwc106WF6FDed1Pt8yuObLMDf3UFbz6aDC5KZrANFnw52z13PNdiL9DAy1a1EkhgjVl/c5LoXwg9hBdBv0B0tGIKn9ZVQuc012xmvj86qysmfxwfDJ/HTMZ8imd3rCtS38em3SKR5OmtcwPOLZJHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 18:15:23 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::b831:13bc:a1c9:2628%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 18:15:22 +0000
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Topic: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Thread-Index: AQHdLSEDAM+rltzTuEeLf4YUWeJViLamsPeAgACTlpA=
Date: Thu, 20 Aug 2026 18:15:22 +0000
Message-ID: <IA1PR11MB64187411BF003EC4420161FFFAA42@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
In-Reply-To: <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|DS7PR11MB6245:EE_
x-ms-office365-filtering-correlation-id: 7a388c14-ef73-4e8c-aca6-08defee7003c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: CEJcSuq7BJetKAim0/GHyWbziP+NRqZ6iRlLsnV2Bs35LLXVF5WX2t1Upvr5q4H+wwNPdRkUNIMXw7gbH8tr6jkB5Osp0Cxe3mA4J4J8pPAPcqk+NVmqtBJAALbuq8wo392j4ew4eeCf0w3pkBDkRZ9o2W1DP8z3oMntXYTrVkXICeRWc1dluNW3FA6FCRUO7azNvbHwmEEuKNSWHyuhKRIqMsy4zkRftgn0Ck50p9Wi+LfYssN26Ue5sRNjSGOtnt5JCL706rCjuRDPesPKHZ6jUeKVgN7n218oVtWSSFxKYSf5pdo7yfwt0pI7Z4yTXAuvS1V40/wUSg78lpMf/777BZ1hgfc1dh/33psDKIbyomdQp/VGuAzDRasd02qy/swJvT4Wi1Bjmp6WcpWDhCOs8JAg9fllhL1VVKjMspAgGrZ5xS+4beCgFuOMwWm1PnFBM9S4iDFCdcRQUdls0ZIutb86VsCDv/GgI+ChiZGfdPkU7zoYxxpy1RjAu3uqpT/xIoF+QcyKGgesWLy7j5i9EXcq18csCU+pWIqmATYFBaUd8BTJuiFHa/gvuLzks0t2mR5T6bOKIgFO3nnWUlS/0dc99b4g/hM1QWdqntStWOKbMK65aIW0tEXO2H2gzeYPjiSQa905517TqeYVgrHSRPfRSu+frnrtYZbM6EI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6418.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9Z6sdyj+t8lpLMynLPnBhsMalxtT8GUHfvETNWyLPYkJ857j4jrkAICpwl?=
 =?iso-8859-1?Q?UD1/dhLDCe/YgN1dZ/XSwqYDt4L48zffavRvHyt3ORIFD87mNGOh/CbaB5?=
 =?iso-8859-1?Q?JL/KeE2hLP8F6BHT7zg/8md1XvwPB8lbFdlN4EoqYvYZQMYUysJWwWfVBj?=
 =?iso-8859-1?Q?NjuH6+OEFgqC2Bsz3l7zzqnzxECs8rEnCKBAZblazwttjV1yO3LmVOr4XM?=
 =?iso-8859-1?Q?PmIhMjIFSUJp3G5Pt/ATwLsGj64LW3KCSs7vT7smWQEZA3VnfJ98/Aiz1N?=
 =?iso-8859-1?Q?o0FR9FGN+2R8jR8C49EtDOIAuw6J4WodgT3z6YMSG7nbz7Nqxv3gPI8Lwn?=
 =?iso-8859-1?Q?qwEKg8JEnI+PpZD5nKLMK86bAUkLgeuqRmWTniWHn9EZfBb5qv/n7fDZ3L?=
 =?iso-8859-1?Q?cLHwd8VmeypUkDCgJQdh43uPQjGTmpceTwtlHM4v+hd49wG5IUMynV3Hgl?=
 =?iso-8859-1?Q?FnRNMqyjVg02ua6pci3LYepSnHvihIwQHQ0y3jO42ilMlYbhsIlgbLbQgp?=
 =?iso-8859-1?Q?Mp4Q/6UyhdgvNEeThNbcNpYDygOHt/PP6InyPSQQBLh9j22oPBl4oarRN9?=
 =?iso-8859-1?Q?X9W2ARbY0L5gVVHCYAnlHOBRCRng3O6DIC73RDrPgmjGOP9LW/rFrqYAQw?=
 =?iso-8859-1?Q?Gu0Ksay2rcKyJ2IZ+chE6rZU9SVOMZXvX/5cMiUjLq49SQRFaJHpnsfftM?=
 =?iso-8859-1?Q?GHT6hbnrYMso6qgOAFe9/0f0ksPUcFGxW3F9qQRRd5r3FCF3en9Qg1INQc?=
 =?iso-8859-1?Q?JrnEb3HkRAju8oG0ayHuVqoubAyvH0mAREtqUOYzM1y6T7zoGG27a9DBEP?=
 =?iso-8859-1?Q?ryKaZVEElMKM0pLx2MZqUY52gIhCGS0n/YLa5r/NVvOtyJxKTHpEwLJZh1?=
 =?iso-8859-1?Q?VQMPbLNYiyj8mDFR3cbWhWuw6H/kFiZUcV4hvwqWRNFXVsqciX6EY6MHkx?=
 =?iso-8859-1?Q?X7UHcG7RENSKdf13vxw4fNV/UXcZuUfZET20xvkPbL07DKUswxjMRylPtr?=
 =?iso-8859-1?Q?77c6470nHt+1WFp2t7blquvf5CQ8LxgAndvQI8DKL0UMXshvWGPmh9yKye?=
 =?iso-8859-1?Q?SrOESMSbzoDOxae05maA0/C1XkVOfqWjP9SqraD4qXHHeUm2ygPr6Uj26q?=
 =?iso-8859-1?Q?6qNCJsgqo0yC5/FE/HdbExm96kyaaXmCAW1nqe3lAkAZTjXPCPV6KngTZR?=
 =?iso-8859-1?Q?HBR0WaDptgPpUMbKWIy6gGBhRz7KwceBNHS02TI8UJO1F86eHZzTIwaYRm?=
 =?iso-8859-1?Q?Jnxg46dMIKoICT6OdPxzdbO16OqyMtLMmOaxVZvwGpzJ/EWve113x/2JX+?=
 =?iso-8859-1?Q?1aXe0yNHvft78gn2673jfyxN0t3iAQrs3Y727FBxixPFGYmBpIEnPMTgaa?=
 =?iso-8859-1?Q?8C+RN5PKMtW87T0WQUjciW9FyxjwlKVVxSiZEp+O3+drEP9Efb0L+zKdbO?=
 =?iso-8859-1?Q?IcX3j3AwEVoHwJ07hGOSOjxj3ahufSvEwkNx4anLatqzVyeXTQpijD21uD?=
 =?iso-8859-1?Q?fEm1ectnq0ghKkaMPF/Wh0jBCe5hSoAIhXow+E0oB9louoObQHNO7ypBGL?=
 =?iso-8859-1?Q?J1Pd3goCfTxN9fuxPCsXYUJV4FNGn3yacr83tLikD2goJ9/++IlSrpUYAh?=
 =?iso-8859-1?Q?Vo9b7Ae+jWnIq/p0OcUnjBxXbXKYXpSSIpDkYjUmJQ+fwOaroOPwg/+PGL?=
 =?iso-8859-1?Q?h+J/9fWtWU7iK+3Wf/l/P3kkBhJ/tIZx+zhxDtgW/YdnWrvMY0j8oop8yX?=
 =?iso-8859-1?Q?Afye9CDFsmKVMZQ97tw2f1PfiqY1vnBI2KthHYz75cUT5a2wJkm2w/pAmY?=
 =?iso-8859-1?Q?GUNd/WLFHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mPoUntLPTLA59IYwRO1GM0nnPyMzSj/4xtk9O3thhMAz7QX2h/cJtNijlLwFEC4Q/FONaf/anu45S/s5DV1m5l/qEK6WJcGpQfb0rUOcuLJlYh3PXzFaFt3qbkboh1TYBhBjbYn9jVkpuNOOGtvOyPeFZeaD/iIlnxLlAxfjmbgCV2rOriHyXBjO/XCpqkqRFORuyu0XsbHkU9XHX2Gm9OTqaxyv+KCpLUw36NEADYtkKT/QjfODnOwLl3WqvFmnlAqa53vTlJ5CjSraXQx0NAZlxqKpKyYEMtH9uwSGxZhY6VmUfQu/fwdpE3/+XxjIIdjEnuQVz7tN+cfrvT1VLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a388c14-ef73-4e8c-aca6-08defee7003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 18:15:22.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKdbMg1n8ppidrTNLVktHGTbWN0SlIIi72gmFmuB3gSknO1nFDPJBw+TYrSyrLFjgz5CQfB71RWhsysdrF356obu/qH31SR/YZQYjF6PKUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
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

=0A=
=0A=
________________________________________=0A=
From: Auld, Matthew <matthew.auld@intel.com>=0A=
Sent: Thursday, August 20, 2026 2:23 AM=0A=
To: Prabhakaran, Krishna <krishna.prabhakaran@intel.com>; intel-gfx@lists.f=
reedesktop.org <intel-gfx@lists.freedesktop.org>=0A=
Cc: jani.nikula@linux.intel.com <jani.nikula@linux.intel.com>; joonas.lahti=
nen@linux.intel.com <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodri=
go.vivi@intel.com>; tursulin@ursulin.net <tursulin@ursulin.net>; thomas.hel=
lstrom@linux.intel.com <thomas.hellstrom@linux.intel.com>; dri-devel@lists.=
freedesktop.org <dri-devel@lists.freedesktop.org>=0A=
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf imp=
ort=0A=
=A0=0A=
On 16/08/2026 02:45, Prabhakaran, Krishna wrote:=0A=
> From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>=0A=
>=0A=
> When i915 needs to make an imported dma-buf coherent for GPU access on=0A=
> non-LLC platforms, or for objects that bypass LLC, it currently calls=0A=
> wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer is=0A=
> pinned, so this triggers a whole-cache write-back and invalidate,=0A=
> broadcast by IPI to every CPU, on every execbuf submission involving an=
=0A=
> imported dma-buf. That stalls the entire machine for milliseconds and=0A=
> starves latency-sensitive work on unrelated cores (e.g. USB isochronous=
=0A=
> audio serviced on the VMM's main thread).=0A=
>=0A=
> Flush only the pages that actually need it instead:=0A=
>=0A=
>=A0=A0 - If we imported one of our own dma-bufs, the backing object is=0A=
>=A0=A0=A0=A0 struct-page backed once migrated to SMEM, so flush it directl=
y with=0A=
>=A0=A0=A0=A0 drm_clflush_sg(), exactly as we flush our other objects. This=
 also=0A=
>=A0=A0=A0=A0 avoids re-entering the exporter through dma_buf_vmap(), which=
 would=0A=
>=A0=A0=A0=A0 recurse into i915_gem_object_pin_map() on the source object w=
e=0A=
>=A0=A0=A0=A0 already hold locked (and fails the igt_dmabuf_import_same_dri=
ver=0A=
>=A0=A0=A0=A0 selftest with -EBUSY).=0A=
>=0A=
>=A0=A0 - For a foreign dma-buf the sg_table is not guaranteed to be backed=
 by=0A=
>=A0=A0=A0=A0 struct pages, and the importer has no way to tell, so drm_clf=
lush_sg()=0A=
>=A0=A0=A0=A0 cannot be used. vmap the buffer and flush that virtual range =
with=0A=
>=A0=A0=A0=A0 drm_clflush_virt_range() instead: x86 uses PIPT caches, so fl=
ushing=0A=
>=A0=A0=A0=A0 one virtual alias evicts the cache lines for every alias of t=
he same=0A=
>=A0=A0=A0=A0 physical pages. The dma_resv lock required by dma_buf_vmap() =
is=0A=
>=A0=A0=A0=A0 already held here via the imported object.=0A=
>=0A=
> Fall back to wbinvd only when the buffer cannot be vmapped or is backed=
=0A=
> by I/O memory, where there is no CPU-side range to clflush.=0A=
>=0A=
> Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")=0A=
> Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>=0A=
> ---=0A=
> v2:=0A=
>=A0=A0 - Flush our own imported dma-bufs directly with drm_clflush_sg() in=
stead of=0A=
>=A0=A0=A0=A0 dma_buf_vmap(), which re-entered i915_gem_object_pin_map() on=
 the source=0A=
>=A0=A0=A0=A0 object and failed igt_dmabuf_import_same_driver_smem with -EB=
USY (reported=0A=
>=A0=A0=A0=A0 by Intel CI on v1). Foreign dma-bufs still use dma_buf_vmap()=
 +=0A=
>=A0=A0=A0=A0 drm_clflush_virt_range(); wbinvd only as fallback.=0A=
>=A0=A0 - Link to v1: https://patchwork.freedesktop.org/patch/744955/?serie=
s=3D171760=0A=
>=0A=
>=A0=A0 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 55 ++++++++++++++++++-=
---=0A=
>=A0=A0 1 file changed, 47 insertions(+), 8 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm=
/i915/gem/i915_gem_dmabuf.c=0A=
> index b43d34c7d641..c798a90f1c0f 100644=0A=
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c=0A=
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c=0A=
> @@ -10,6 +10,8 @@=0A=
>=A0=A0=0A=
>=A0=A0 #include <asm/smp.h>=0A=
>=A0=A0=0A=
> +#include <drm/drm_cache.h>=0A=
> +=0A=
>=A0=A0 #include "gem/i915_gem_dmabuf.h"=0A=
>=A0=A0 #include "i915_drv.h"=0A=
>=A0=A0 #include "i915_gem_object.h"=0A=
> @@ -249,16 +251,53 @@ static int i915_gem_object_get_pages_dmabuf(struct =
drm_i915_gem_object *obj)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * DG1 is special here since it still snoops trans=
actions even with=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * CACHE_NONE. This is not the case with other HAS=
_SNOOP platforms. We=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * might need to revisit this as we add new discre=
te platforms.=0A=
> -=A0=A0=A0=A0=A0 *=0A=
> -=A0=A0=A0=A0=A0 * XXX: Consider doing a vmap flush or something, where p=
ossible.=0A=
> -=A0=A0=A0=A0=A0 * Currently we just do a heavy handed wbinvd_on_all_cpus=
() here since=0A=
> -=A0=A0=A0=A0=A0 * the underlying sg_table might not even point to struct=
 pages, so we=0A=
> -=A0=A0=A0=A0=A0 * can't just call drm_clflush_sg or similar, like we do =
elsewhere in=0A=
> -=A0=A0=A0=A0=A0 * the driver.=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (i915_gem_object_can_bypass_llc(obj) ||=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0 (!HAS_LLC(i915) && !IS_DG1(i915)))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 (!HAS_LLC(i915) && !IS_DG1(i915))) {=0A=
=0A=
I think we can bump this now for dg2? I think we treat dgfx as always=0A=
coherent with system memory. So maybe s/IS_DG1/IS_DGFX/ in a separate=0A=
patch? Pretty sure the rest of the driver is the same.=0A=
=0A=
Agreed. I've will send it as a separate patch, "drm/i915/dmabuf: skip=0A=
acquire flush on all discrete GPUs", with you as Suggested-by.=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_buf *dma_buf =3D obj->ba=
se.import_attach->dmabuf;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dma_buf->ops =3D=3D &i915_dmabu=
f_ops) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct drm_=
i915_gem_object *dma_obj =3D=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 dma_buf_to_obj(dma_buf);=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We imp=
orted one of our own dma-bufs. The backing=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * object=
 is struct-page backed once migrated to SMEM,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * so flu=
sh it directly, the same way we flush our=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * other =
objects. This also avoids re-entering the=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * export=
er through dma_buf_vmap(), which would recurse=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * into i=
915_gem_object_pin_map() on the source object=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * we alr=
eady hold locked.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i915_ge=
m_object_has_struct_page(dma_obj))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 drm_clflush_sg(dma_obj->mm.pages);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
=0A=
Do we need the flush under the else here? If it's not placed in system=0A=
memory what is this flushing, from i915 pov?=0A=
=0A=
Right. i915_gem_dmabuf_attach() migrates the exporter to SMEM=0A=
(INTEL_REGION_SMEM) before get_pages() runs, so dma_obj is always=0A=
struct-page backed here and the else was effectively dead code; a wbinvd=0A=
of device memory doesn't make sense from i915's point of view. Will drop=0A=
in v3 - the own-dma-buf branch is now just:=0A=
=0A=
	drm_clflush_sg(dma_obj->mm.pages);=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iosy=
s_map map;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * A fore=
ign sg_table is not guaranteed to be backed by=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * struct=
 pages, so we cannot use drm_clflush_sg(). vmap=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the bu=
ffer and flush the virtual range instead; x86=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * uses P=
IPT caches, so flushing one alias evicts the=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * lines =
for every alias of the same physical pages.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We alr=
eady hold the dma_resv lock via the imported=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * obj, s=
o use the locked dma_buf_vmap() variant.=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!dma_bu=
f_vmap(dma_buf, &map)) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (!map.is_iomem)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 drm_clflush_virt_range(map.vaddr,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 obj->base.size);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 dma_buf_vunmap(dma_buf, &map);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 wbinvd_on_all_cpus();=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 }=0A=
>=A0=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0 __i915_gem_object_set_pages(obj, sgt);=0A=
>=A0=A0=0A=
>=0A=
> base-commit: 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a=0A=
