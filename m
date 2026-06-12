Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C1ACD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F6B10F32F;
	Fri, 12 Jun 2026 08:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bVCCkn2R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C4310F32F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781252919; x=1812788919;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3N/4n0/+AovqMksAWPOCeB1gLL7QkQhhxt3moew4v/Y=;
 b=bVCCkn2RK5VSLTQXyu+q0TEjzhOohrCErBne3VSPWWn6zr8sNRIQhJ4J
 GaGKl2d5Srzvqj46UCJRnuwFvuuEo041uFaVxYZRLn6EVJgARvX6y4XSV
 51UlqPryEp1LPUyXWIxvVGwEQNvJSmjrNlkzNsRzK65uj+vKv4jpDx0Dm
 jd0JeLWkjPYB11vOuq+je8AcJoo3VOVticAhYYSIcVf7cj3eCDKpoOdyR
 FIMmQvjB0AHPQU2P60LIessgutffQt06qeZigmrzw2gd0YEZtnAOvHr8G
 0MJcJg1LfgCE1BVp+y1R3HoncHGM7KLVTaJQAxHBn6PAClLqUBFRTTCCF A==;
X-CSE-ConnectionGUID: lPZur8KKTaG9eNQgJZOw2w==
X-CSE-MsgGUID: xl8GH0ZiTB6R0Ohpejf06Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82086716"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82086716"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:28:35 -0700
X-CSE-ConnectionGUID: D92YfpmZRouUo9rbtMj1/Q==
X-CSE-MsgGUID: gKrfQWn9TuOAzatUwE2LYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245867578"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:28:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 01:28:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 01:28:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 01:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqk2yJJ1uGEhBY/29h8VhTo79+JtGdTYoEjaXqTT7YrKVRHgdkSH7Sb3sPC/GdJVkIqDc4Ch4X9OjpXKe/IpphawdW0tjIxCdhTHCG3CtH7uO+dRz59IijJksKP8OccrlAiqF8fnJCkwZbsJo4LtKwT7e2VcwzFdgUof/sm/tylfn9bfjCp3GBX8B6hFWyW7OBFYKvbjDMZBuGHE8MUFFjnu4B96vUy+7gol3Q1STKMD1YLlyXii8u3qYfIoN55S2c0kdo0afQkeL7b/jkQ2icg3VlCcEhBf22X6ze2ZtysHFWxJ1Q/vE8n4ZiBIOtO4FpTbYUg0vLUcRuG9KrXkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7zc0Bshjye7loupL4xr4LEXEeclQk953MTKQEOzIfo=;
 b=HLjBlgBT+NA3tFJyEC1Ez7blGtKN6RFP9A4eN5af8Bq2JZtrNkr72A+TgTW4R3HB4EwRLuTFXWD8RD1BznuWy8zXLuO2D74AmEwKglMthfylA7jN31PobP8EPMZkXuaFnGRg5hgtHTxXUqvOWeK7ipYvfJ9zfIVcSY9+3xMMn8bS64L7DDBCDdzxO2llamnHimPahFiMvZ7icxW0INNVwg6f/Utu6DDgxusCem0GU3wE7aVlZrgcVVxI+Vn8bdGd8bG313T7Mo+tHtI3dvkDpmu7axKDLSn9P415/+fY7pyRsIePsGt5PQB7dB0eXi8/34NTN75mjw7iYGqj9PweDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 12 Jun
 2026 08:28:28 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:28:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Matt Evans <mattev@meta.com>, Alex Williamson <alex@shazbot.org>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro
 <amastro@fb.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Logan
 Gunthorpe" <logang@deltatee.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Thread-Topic: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Thread-Index: AQHc7cLpPrmUMiCrVkOjL3tNnRL3pLY6r0EQ
Date: Fri, 12 Jun 2026 08:28:28 +0000
Message-ID: <DM6PR11MB3690E7BD62EACC361CDC20D78C182@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
In-Reply-To: <20260527102319.100128-2-mattev@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|DM4PR11MB8131:EE_
x-ms-office365-filtering-correlation-id: b27564a5-2aab-4626-4257-08dec85c9477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: SxUS5+V0oeYK3scdTs5EkhRwr8FS5ostuoCNvAFbunjOiVWaJ4zJgJ8gsCYOetWzWtUZ/kSJLYuWjK29ZrJlApxpIH2xWnGGieOZb6/CiyG3DHPAMAC4oSzID3pyrbdNzbMNdEPEBVzMHC86vnW6SRec1V4+T68PhR/ayot/MdUayWt/fWPfJj8u+L03Zssv8I5i/JOg6a3h8hsXqQf8Wu7u6UgAf09HAop5ZnxOwwzWv5UX2T3ico/JU7hpUzEDjvKpIg86ie5NZF6DAXWzLjkk2GtEbYmeBr0IPaT1eXjyc55GZv4NkfXMwJC7WlAHSMWXtXXYKuVhBNvWidPwLA8IYoXzGm8qOfShoCKFGroCt+EQj0UcdapTidL4PaEcGR1QNp+yAomIVO9yJc/ZCWRSIgsxDg77Z1jYDH96lt7mzsHkqKzy9rxfOaWpuLujL7/kc/sU0fNfnCCIlT84FP16N6GPDfUR+GXpBobHY59hXS6X9tLWWRjhCvu0U/0oEJ1sGT/L0IhZwAWwh6yaoOOFdzAYwKOGU4+j0LIeoC872tcuoE6/brqBjVyOnUOdfa+c0GScUs1/4LroFn4H3e0ex0EXCwuE5Zinrjt7wrl+lO2/SBmo0vk0SB1STD4B4fNLDebhCMs+PSaII2FvqGjd8YHysQx32xC6rL9GQJZKgU+0MvjTOfx/w1apLveJyiBhVN5EHkqAbWyJzWQiTtS/DDpLPxlTrglRD7d31k0cJa+r4CFStUmNv4s6DcXN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3690.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZsQFfAa2YT/P2VnhUR2gJ4cx1YWcAbXt5QeyhTWCQZ7UjHR9ZqO90grTgz?=
 =?iso-8859-1?Q?vuQgW8N491vKm0YgaxYMSRruA+zGOxyvUZdyvUeHdY9PJ7TF4TRYnqhhYv?=
 =?iso-8859-1?Q?3EpMkybqjwHSi8N0i0L3B9ZOJFxL8sLRLreZsuTMyjgCTWcj46SERdRpji?=
 =?iso-8859-1?Q?325OoTBNzrLEDyqHD2I++1llm29a6WPZLwxtBGgVl1ITr+cpE1FMnP9DI5?=
 =?iso-8859-1?Q?mo1H6gvcZuUVXSL9LQCcPg7sXMsSeQ7UtRidxjpkGoY4GqN+hRmKzZQQMw?=
 =?iso-8859-1?Q?h80MtqU+7V1pniXY/Hyt+KqUMRfiU/vLI66P+8QXwT5F/nOUa5LYV+Aw/4?=
 =?iso-8859-1?Q?I5DlTvKGCCw/aKQ8WHl+NOrfZEw6eVq1cZ9JJvDvBDp9aIjeuupvPLYmxj?=
 =?iso-8859-1?Q?RaHhJFUdwBTqRToPnmC1UjQi5sdAPDbKGnH674LvJQ6pUca5Ty8oJ7SZOo?=
 =?iso-8859-1?Q?GhIVTXZetkfGMpuY4QbvL8YojsOt/FJKNSH8pj/560IeEbZbdwLa3oszXo?=
 =?iso-8859-1?Q?xWRztl7pY0C9qA3dzynj5JwkkOB8s/fQffWjl2AIQvEC/zRD62nWxKMAY+?=
 =?iso-8859-1?Q?zTs1xBFW6Y0turgPVTRkj7MXgt9Pu3FhpCpaOx0Gh91OICb3isPknqGRSw?=
 =?iso-8859-1?Q?yxHJcjCnCm9yKsvBvASZJLhtqxqdhRbxsGF1zWxdAsYP2WqE/dyoYU9VHy?=
 =?iso-8859-1?Q?wUWFhDdLZVEuqld5egVj1YNctlDJ7s1g1mEeHQBOcsD1uFiqG5nckwVZW9?=
 =?iso-8859-1?Q?8YU2HUQ5OyWRwN5DKn6Xn3YOOJvOSpBv/WNnbvzLpaDYJYs5uKvJz7dRpf?=
 =?iso-8859-1?Q?fMxXpNtxhC3V5Ba8/3rF5NawXZWIJyQXRS3oj0Uh7j20/0Kn9ZzPXmxVrV?=
 =?iso-8859-1?Q?zUpnHNUdReL1mZZahLD2umysY5o/clXPDKQCD7B1yy9FRJAutrYrk4szwf?=
 =?iso-8859-1?Q?IL0oDEP8WfvL4BWDWIbdDJQUMPrFt4Hz+eEyGtTRm+l/CtSYuk2Ngs78tN?=
 =?iso-8859-1?Q?32UKvOv6m+o8QfumTJefBUaz6nFcHF346FGlvvY2HPTDHGoyK8BFos2cy5?=
 =?iso-8859-1?Q?sVsWrp/sjqDEPtz8Dnk0bFmc0GJ7yseroh5yC7OYheQMffkZvjAzXEqMG1?=
 =?iso-8859-1?Q?DcoEgocvEdwExbdS370qik0v7GzhVhDBZbyGiFkUSscu7XP0GliQcvguIp?=
 =?iso-8859-1?Q?k0IJVzIW7wOtVJLxRsZcFXLGKNGTF9AlTPiuQxAVMbbo1K5ghTvxnJN+wm?=
 =?iso-8859-1?Q?ZIMt7J+LSB9hGhJQ1roIUJpi4a3GNs4sKijtD4y0HgKQ8oJC+i/aAksXlu?=
 =?iso-8859-1?Q?hc64yDjGjESg+RhZ1V7B1Vh32gZbWQ+nyuHVuxROQqTzqE0VXEm68ADiKh?=
 =?iso-8859-1?Q?Q7qVOaUT5YoBaHV0cTyjvfRwY2aOCX5/unESO+5zeYnKGW3squ6NlQ9Gyi?=
 =?iso-8859-1?Q?hlPJFqcQd4BwBoRtbtS55KcDos3Ozq5tGOSbp5HoaFUiYnzYrDhNYAkXam?=
 =?iso-8859-1?Q?NdR3AdywIpironL3UeAI62KD2AE0MSjhH7PcEga227nJIEb7tSPCBjyu5Y?=
 =?iso-8859-1?Q?zuA+WvHdR8YF34dxi0oybLK7QPqW6SyBtlRM7QNS69lcGk+4AlvdnIUB5u?=
 =?iso-8859-1?Q?USlLjTkMcF9i0a3gkOb/Q6DT8DTW5EoUg9qBansINBKT032GsiLm67LyOn?=
 =?iso-8859-1?Q?Q2XWPCyYd9vxeSMwJHhWPL034fI5A5NqdX5rrC1V2a0Tm5/YqoXAA2rvDH?=
 =?iso-8859-1?Q?egMee+AIpFqKtPzOOM6f0vanOfIaS2AzSwb2G9WU11vVXe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: doWoGJpgqzrjmUeQ9CNunHuKUfrwOe3U7bjuyRWOisC3s0P7+csl0LXJNozOVt+d44OWVL2yk5EaDj/pOqCQi6tiAtQgaCfLh0oefiryyxIgOFUgM9e6DKJKC5okcm2VuK7U8I2A23WwgMkg294GBEh5CL0IFLdw9GXCAMwELmNPdPmaj7+OE75z0VL+l73gGI5ZL6zsvBrXRwlrnDbMCHBNxye/kqhiOM2c1HPkjP5IZk44J5A4TKbxKi9iOSUqwMwZPm9QKj3LlaqbOKlapfZ+E7XBOir5Qt+eujZBkfsBkHAJUmWWMY6COiKRTuj75pws0BWOAAGr4a1/CMnp2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27564a5-2aab-4626-4257-08dec85c9477
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 08:28:28.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc5khalV/oGw1wN4lJYrOLd1E/PvqDmNl8l+wZqsf6IFW24m4pK2WpeGqVzwr6rABuMb/w4YUzW0WZpdHHJ6dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
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

> From: Matt Evans <mattev@meta.com>
> Sent: Wednesday, May 27, 2026 6:23 PM
>=20
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
>=20
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
>=20
> Other code (such as vfio-pci) depends on 1, without having a hard
> dependency on 2.
>=20
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
>=20
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE which contains the
> basic provider functionality to make it available even if the
> CONFIG_PCI_P2PDMA feature is disabled or unavailable due to
> !CONFIG_ZONE_DEVICE.  Users such as vfio-pci can enable their own P2P
> features based off the original CONFIG_PCI_P2PDMA (available when
> CONFIG_ZONE_DEVICE is set).
>=20
> Signed-off-by: Matt Evans <mattev@meta.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
