Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7EDCCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E240711299A;
	Fri, 16 Oct 2026 19:58:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073711299A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792180694; x=1823716694;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WnXUTx5hSZFBg69V7yenig5NyszMYUOJjLOGrygHSBA=;
 b=Xd1dOfZi/YhFFBgFl5ByWy1vVvc5ROhk0XxXTwrXF0UEsExp6+W0sta9
 b+B/91npTei6m21nIRMPe+JihykO9kMkeN9DF1Bw3D1inU4NbWkQ/ED1m
 Ph6OwelkcnFSlfGZl2Sdq8K4znaZopFUIb99Lfh9a+Pmb5F4ZoPgdhAbW
 Zpl8lg78emHy6fmrlDBAnfkd9mNbtTDgZsjZAvCxCCrvNNZ0m8xVzDFnM
 9mJjalVARbx8oEaz7Tlfb4fbzU5YzhPmV+B6c/5l+o4aEd5VmlYw0c4p3
 uVTrvKY7/w7jf+j9kT2QTkziJm1IO4oCXjh+zH2YkM4WncYInqnQ5SKQY g==;
X-CSE-ConnectionGUID: AsfInkdrR7G2M/Q44EA27w==
X-CSE-MsgGUID: I91B2ucrS3uYMz2q0I9Gqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="981919"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="981919"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 12:58:13 -0700
X-CSE-ConnectionGUID: 3v05q4chSyObgWCgLpcU1A==
X-CSE-MsgGUID: rPYQe3EjRJ+AhowCHbn+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="3865270"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 12:58:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:58:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 12:58:12 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE3bU7bDmMi5+NCTTvuRgAA7o0PxNA5czwsMbTZ1pQfaybMrb7JtKL9D0utnMMbi7sSE9nA9URbl3DU95ybEP72d4jkz57o3lgN2164axZDSxJC6+T2jw5S1/BXZbsjiW2YTM6yYf+0ZF85pdPBODUr81hrpR4hL82CD44YYCKsn51qbFrI2fqSfIVVoE0LqkaAE5JSksc9MFlmG682b9VMhbWbjErnhCFmLk0x45jTPuosY4p8YpWHmnADRkApEVZCsoH6qt2KJ8PCNsX+3eiMfPXD8BAT0uqAU08BrsEYfhVQkojLIuGPcDnaFuCv7jktFXWs3BJ902v9dxbMjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1/ASMlbyN6BErHRyf+l59sygegljwmfi1q9AnXhh2M=;
 b=fdGePfOY8Hhog3Q1bghCIkMLUHLLWuVNz3NiULGsNiqqwx76YxBWqfA+iqUPE0ADTke3h6JwF0vC5tN4PMP+iFV4BPfiBrLDFpVACv4ypRUXzOXDfRm/c7K51A4cUXOKrDqhplxVFx7iyHzr4k4J8soY51JU2iIu8vNlGBYOIAnyp7hDXDdG0D93+MuazExv8UbOFbk04xZ5vOQ0z4u4leXT5H0VyX7BzJIqJXSIIGJEyputNRz8XoyIzKfJphoNOT6Jel483M/YXwGlXakbPfeO7DgbRIbXHcrAW97yqrLNJPr5Ni6YTBBG3leqrCiNsg0q023uVFhRPMrxOulbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:58:04 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 19:58:04 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
CC: Sumit Semwal <sumit.semwal@linaro.org>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] udmabuf: respect the device's maximum segment size
Thread-Topic: [PATCH v2] udmabuf: respect the device's maximum segment size
Thread-Index: AQHdT9Y+gq5PFgUM/UqOgiAUt8KDQbb/tV2AgADdL8A=
Date: Fri, 16 Oct 2026 19:58:04 +0000
Message-ID: <IA0PR11MB7185DC07BC1327CB68EBD189F89B2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260929054835.94118-1-kmehltretter@gmail.com>
 <atGtwBE_zrIvU0ZF@gmail.com>
In-Reply-To: <atGtwBE_zrIvU0ZF@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA2PR11MB5068:EE_
x-ms-office365-filtering-correlation-id: 2dd4bc62-ab58-4183-a529-08df2bbfca81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|261009223027099003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: UFGLTa/iAZvx22rslISRHJrbI6BIgZEGkpY97D0eJ/ade8M6mvAYJQpSzyj9qnBEY3EdgtoGwTeG6v67FGrCPnxaN87POk/mUxqzEY4qQa5gkvGNQYzxMKKGoTdeUl5H97vBtChUnXkvqRZfdJGP9LRCHhqgnCtCVZDSIMzZwPjeFXaf8ylGYRguICqWdjQ3T0wW2VMPhuMeZSKzP8xP2JbSSFw3jFwNWNnk3soHBYEeLA+hGO/RBZeYbDFt4rEdQk3JzqXrDL18V9/u0RKLvnI51wSpi8nLRL+nypAzK8kY5Bq/wrbHvgGRzXchPYtsdkXXD6b1+nd8LS5LFmnteZFCjHydu6Uxk0xpiN/usIRKU8eRj6SxEU4NKXGZKIrtIlrpeWOwHBjQy4RpoTSsXhXedvVe2PMOtwkmpArzLIWIQw4OemBbPcWEVewfCMEsb/2SwDXjaEv7tUYIyqROje9ZVv0IHhLeB6CLtFF37+a6XAosab1C6TRMTtdjTn8CAnJQrnDv9mID6IrFyNjVtgl4iAbJk3TwB8EpUD6fz+7vBJ6KBxl7Jdk9BO25rfEn8gWYOLgUrWo//GcdLqPDaFf/DuqObyAsZpLRuiS6AzPpBfyZmy3m8IrmJ5Zg55C5mIxcpKfbxaH/ywwpv65P78iP3NgQEJQkFNQOr43KYJSD3JReJad13KEABle65mqJBoaQX0bswgTheJTPHkj+cH9qDI6WkqfTzW0VmgzqVUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YdPMDpIYn6d3t1u94XyawJHPt5p9CgucEQe9Z3gxtLjegKPpHHOd/o0s9Z?=
 =?iso-8859-1?Q?0NRnEfdsVJLD4kO5tpDbTxqsuJJmP1LLjr18wfqiq1tYxZC2APeci/2TRh?=
 =?iso-8859-1?Q?MKyzqjxfLiYBjeco95yyG/4MKxCEFVBWxl9XfDssE9nqW/T/HXHa/IFin5?=
 =?iso-8859-1?Q?94ZNOC9Gwpgb5AisZMCTIsbUvFTpkzEv5dlH0iszS8CWwhLie/nPyZcboK?=
 =?iso-8859-1?Q?YrQ8rXEUk0ZclMj7piN+IMVtSH0HciCFfmNQJXR/PsVKmgZ97neLXJECwG?=
 =?iso-8859-1?Q?0I0pjOAZfq3Fp5ip42amHuiNgTSRRimmnRcr5MP344xS9WarRiTpmvEH/y?=
 =?iso-8859-1?Q?aed54jxm6GHqCPeiwrLemRDY+l7VlrGAQo2F0ajVphwzmCzEHnHLY6+fQa?=
 =?iso-8859-1?Q?ft7Fxo3bE1EXprR3YgfAW/SPcNXq5xyyJ6ykaUnJtDtM9vlI+r5pPrPZB6?=
 =?iso-8859-1?Q?468dfcgqo0aOpsZUm6Zx+dKnyHL6SK+Zhb584pyy5/jJ6TeIjQIZMXhxzx?=
 =?iso-8859-1?Q?mKoMnl6n1R2oU93QlINYZyW0ZyrMdIIJuAsOAY75Y3WS9c13AytMW+/akq?=
 =?iso-8859-1?Q?yRdFzufTY8piA/gt9039wd5k/xtdGlGg+kAns4ANyhs4BnNUHQ2FfQU7qL?=
 =?iso-8859-1?Q?s/PO3gG9PpZAB7u9Bi08hHKxLtpfqpQ0YAhe7pIJf6NKWuo+dp8N1hH+Xb?=
 =?iso-8859-1?Q?37vECrhojSpAe8+xEkgHyOkjdfeantW7SMJLp6Hgd+NMZwAHO9shvtj8y2?=
 =?iso-8859-1?Q?4Y3ul7Mrqj6iyN6hhxmff9ZqRTFQfLW6u/SKXxbNOUPlxWy5gNV/7KoTZH?=
 =?iso-8859-1?Q?qnLpgQowkzAPkTEz4+S28RtTca0EAXMJ4BKKkcuqpcveEd4nA0+y5/Wg68?=
 =?iso-8859-1?Q?8Pyrp7B8AYy8aHtlQE15b106F5N9RAYJgXkN/MvQZfd3A9qxaxwYfOMlrg?=
 =?iso-8859-1?Q?8cR8ZdKZGWFt4YvYkjX4jBhYYFrv240YFFr0sSkvC4G0ZJ1tBcZxpc2lnd?=
 =?iso-8859-1?Q?odcy7AhavtMzcuJELN0nwHBhW5sG8VZvBnDl6nNmHl5Hx2rsXk5CFJNgc4?=
 =?iso-8859-1?Q?OhyAdje9Rn8qpUYof2rKthVNZKoxWSf8UJFtWIJjATytpy15Fuu7YGRpvT?=
 =?iso-8859-1?Q?ZD3gDqySeRWgWfsDn/TjWLToyGzSrOYl/PcpoU8nk7cpaVAm/QbgaDER5K?=
 =?iso-8859-1?Q?KugC1I4btuWRDM2SRn5Yr7IV7gZj64i7X7nny8sU0PP2gFbWHR1eDx6QT5?=
 =?iso-8859-1?Q?ngbrVdZofXrTElSc+ZTfgpVNlFH2ZMraEGlCtaKaYwWTMuZH22jwf2HoGa?=
 =?iso-8859-1?Q?XI/5ghCpfmPrAXxfp6HJiVbboYuhpegDxcoAfUBt8bELaqyrQ6mBeTVFky?=
 =?iso-8859-1?Q?1Ad/Gv7qKXDDQ/yAkdcNuyn7PhSWoZTf/A+0E1jrwzZCGlg34hAGyFXRyu?=
 =?iso-8859-1?Q?H26+gFqBeqPI6bpUpzJDTd4cTX6vDyxWNEHSWvY+F7dypxHUyH+nSDasUE?=
 =?iso-8859-1?Q?HMYh/olOyOksjaNLwf9jmOlrUIU+vGwO/5IxYYc8EmwHfc4u8MXo9DffAQ?=
 =?iso-8859-1?Q?yYuzos8RR23NCFKbAdZ115iQYgSIqeiPl/QPBVdCaIyGtZOc57Q/y411Zb?=
 =?iso-8859-1?Q?PzkqVDI/gaMDy4+zzdoczSM1eSp1pTj08SczhfAYQqrjZ/Gd/Ar9Qkn6ah?=
 =?iso-8859-1?Q?YSK2wAVst+44vAviKw63rGwyEOw14LR86nqIBaOWWj1Bw5nKr/E1y3DKdl?=
 =?iso-8859-1?Q?/dfECH7bIQOl09iUBQOK/CABe5J9vGW0pci2VFeYrbQjHqCUcHiMjIT3wz?=
 =?iso-8859-1?Q?5dzhArAZcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zbCh5/Y4eqbfrW5Ijv8ESVJsUYQ8WxktklP/idQ6sNVLyKWSoB/aoO09FVqCJiwIl/6LeDt3+TfXfO2trH0/O/HcWzJYUsd8P5t3Wq3O/GRiA1bce5ZPc1DYi4ScnsjFKUva1nq81z33LL7JC9OeWiZs8ec1iUZYhnAOWtTNpEgscyiUdVFZN9fkkCRqPymhIj9q1KytpIB1fvqlEL1cmParP1IqtxtdTOUum1PdmPnMRHcZ/VnqRdmpKtujGeBooEGcLfSEEqnCMAxhAxNKrJMO6Qz1is2q5KEJFLKvHrOXxn6juXhaonv4uPzmDrsFnfq4UjsPDuSTI3i4yx4waQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd4bc62-ab58-4183-a529-08df2bbfca81
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 19:58:04.5616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxUNjJM7QdhX7SJNENYNjU5cFPyD0pbjSX+9bR1HwZ69LyayJKK2xBHK4B2iwJpH9Uu3tl2GntwNVbef4M7vq/GdvmdlqB81WeYaa/uU9Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
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

Hi Karl,

> Subject: Re: [PATCH v2] udmabuf: respect the device's maximum
> segment size
>=20
> On Tue, Sep 29, 2026 at 07:48:35AM +0100, Karl Mehltretter wrote:
> > get_sg_table() merges physically contiguous pages without accounting
> > for the mapping device's maximum segment size. This affects both
> > importer mappings and the udmabuf misc device mapping used for
> CPU
> > access.
> >
> > With DMA_API_DEBUG enabled, DMA_BUF_IOCTL_SYNC on a 64 MiB
> udmabuf
> > reports:
> >
> >   DMA-API: misc udmabuf: mapping sg segment longer than device
> claims to
> >   support [len=3D65884160] [max=3D65536]
> >
> > Use sg_alloc_table_from_pages_segment() with the mapping device's
> > maximum segment size. Return -EINVAL if the limit is smaller than
> > PAGE_SIZE because the page-based allocator cannot honor it.
> >
> > Before commit 5bf888673e0d ("udmabuf: Do not create malformed
> > scatterlists"), each entry covered one page.
> >
> > Fixes: 5bf888673e0d ("udmabuf: Do not create malformed
> scatterlists")
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>=20
> Friendly ping on v2. It has Reviewed-by tags from Jason and Christian.
Will push this patch to drm-misc-next soon (in a day or two).

Thanks,
Vivek

>=20
> Thanks,
> Karl
