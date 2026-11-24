Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3823606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wt+KK1N6;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=inX1Pvfa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6119989E1A;
	Tue, 24 Nov 2026 00:47:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393D589E1A;
 Tue, 24 Nov 2026 00:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795481215; x=1827017215;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n6hKiIj8PJ2EgvgBknGZbMYCntl8lOirWTz9D3apQxc=;
 b=Wt+KK1N6sHm5P9etQwualAin23UxpTY89T+eu4fQAl8oWdFLY9/2+eiN
 B5WeqzD3agFtGITNZFKcz8eiRKW/bVkMgBXsfLoU7HLJOD+55MPKRIcGk
 b4OCmA2DMCqbMpGZZhXItNZfrzEPBCJt+JuFub67+/yv1pBZAOmqFat2m
 udMs+zaMtlB+LuRSIv6vtMWN9Cltgtv0Ths1hXjN/7QVh4qTc07+zGD8Z
 F5NkPyJ8d8QR8etsbJe5EYSagy6fCfsIVfts/XvAih9GX3o0p2u3cXB7B
 MQS+VkFzH8iOus/r9ks3vs/boUIT5ZvVHrgIPzpd4k1UULryz8cS0pFLZ A==;
X-CSE-ConnectionGUID: pK5NOCsZQ++sqsljc2Zrgg==
X-CSE-MsgGUID: Hl8wEmUVT3yN3qqAwFXUKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4304175"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4304175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:46:38 -0800
X-CSE-ConnectionGUID: 9YeHqUSnTyShs2DAVoOzKg==
X-CSE-MsgGUID: XvK1xrUZRGqp+nvn4vOorg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11640312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:46:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 16:46:33 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 16:46:33 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 16:46:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP+4jwFKIRchdhzrHAbg5ZRnb4LfFc/syJ3QxdW6CsjC9P7APtI/9XnIxO+hEHSanRdEcZCNguKXZD49YUcZT4vkxu3hhhbXo7SJ9XPabEToN6nRRZWwqBC+Xy/nCjS2sfGzAnQRh4teuvSUALfd/4PALAty+fb+W9YPtcyFUw2bak442XXQeB59GAyQ3RZsXWArIKOghj34LDxQuMVJpYBPl65R6gB3KZW7sCPdnnM+lyah2nAUmRM0mRa4cqaEU/7rTDx6VnJ/JHGX26g1EKEbVb5aUr7fzw0ASoFO1dxPuA3fiFPpTirdxKd7qwVJ2nEkc+dK9T6anEoZCbPFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYkN3ukWtJxO66Es/RTvfGxMJYkny7QUr+6UK878gq0=;
 b=fWFaCkCDzLOhyyVPBIMCbZelAvsZwnyullwGOEL0Sp5M4ibtb7mmPBxrwzUJodnrulUYAC+rsUbrnH/DC2yG3PTOaP4KNle9gFFqd+yJCvQvwxoTCO264fasoCIDzJ68y9WZMSu78gq8jImz1FhGxbx3ZNyYajXk2hhP6MDV9zN+qFVZbYL5XbXmx4QT5atLGGLraUpAo9cuuzCD/iAn5UBNDBb6/U/bVmGRJEaSnLqVs6Ir8AVxwAiIg6IKFbvBK1JakLh0UjPyLvOwgOjC/BxzoSGGN0hn0V2DVN/dJw2gujA2IjHRDe1k9nIbY3bBAfi2uyErH2h4ihPBVGULdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYkN3ukWtJxO66Es/RTvfGxMJYkny7QUr+6UK878gq0=;
 b=inX1PvfaK/KNuCUijuPvBztGiSyn+Owsz2vuwF8z+emj7D8/Ujn+TG5Mg9V0JILh1d4tOhaf0XR3GVgNzZ+4pQVcTfxKouHIjaSgGN0Xmk+rUajkj1h7ASrDyaf2nPJdIc/onkPlgQ73lgx1Z6LXUAvNfXuQbQNrFFVLRxFT8yk=
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 (2603:10b6:610:367::19) by DM6PR11MB4723.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:46:26 +0000
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823]) by CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:46:26 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi, 
 Rodrigo" <rodrigo.vivi@intel.com>
Subject: RE: [PATCH 1/3] drm/ras: Initialize ret in the list-nodes dump
Thread-Topic: [PATCH 1/3] drm/ras: Initialize ret in the list-nodes dump
Thread-Index: AQHde6Mw+foStIyebUq/x2GAM8Qb0rc8YxMw
Date: Tue, 24 Nov 2026 00:46:26 +0000
Message-ID: <CH3PR11MB046149776B5082ACF591BD4A70C1442@CH3PR11MB046149.namprd11.prod.outlook.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
 <20261123233326.2882114-6-rodrigo.vivi@intel.com>
In-Reply-To: <20261123233326.2882114-6-rodrigo.vivi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB046149:EE_|DM6PR11MB4723:EE_
x-ms-office365-filtering-correlation-id: 0996d827-6ec2-4224-6b2b-08df49c45eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026121527099003|261022075727099003|261021123027099003|4143699003|261021121427099003|38070700021|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: EGVF3dlr3kzbxeMoTi9BUFmehxwPJvaKxQbH4uf1Zbk+2qTdOCoYLLraWlfjxy9gMKPra+c6lOFOuxJSbYwo+AS3gDeM22ocv8a4cevelZ/yFa6zZbDJqLxZZ6tZrWRP/hthVWxvCboxy7KTQ1DrzZFbVFFeXUx0ERddmUfhtWJsfsdAsrtoP/TNPd355MorwLx0P9C1q5nOQm17beY8FD4IrovjOER+0YMdasRXNgG+ANIjgJdBOlR37A++ABlxJ48e4zpVrm9jOKtxfM9ZD+QUJ2tgox9AtZsAZn60GqD2thaeDIbQSE7rwwhsVS/psOLLM++oHQpQLA2pBFAXRLL6ESjW3eey1FFtkkcqDzPnxnalQ/sWBWr1G1pq+lXsuATyRXRHoccGw8z3v+81zFOdoVcFqVjnakWx7HzhvMkYM50PajB+cQ1p7Dr7Mfy9NAE3MA7VLrqo81Q7/s2efmndfmUJsRRuK18JsByB8xZLaesTyfJ5dy8hMI+sAMjraoo94vWAn++8x1u1YGuKlRax/fbBZxVNIXyVYpdy55ybxiVrH4U24gIbR6XSZNcEfOU1lhXZ8WrnywVZP9b9544dCOsMZPfoxQRzuDoPsaKsxayL8BCBfRVdGiWroFsL8fTgMZON0YjwUc595P+Hm1chz9612JvY41a4Pk5qIkHOyMXYlMGQO7hiClEcjNGyjKx+N6S/qOAq8XiedYeHPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB046149.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261022075727099003)(261021123027099003)(4143699003)(261021121427099003)(38070700021)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iwy7rissFMQxnCs9HKg4KspooBpj7N14sYYJzXqUHX/O7mk6/MOhXSjYlxdc?=
 =?us-ascii?Q?zeQrT+6yEqYMu2t3G/YBZhtZfNREWlxXmI9xUGL0bLG0XXKGFSBFDOK4lpUC?=
 =?us-ascii?Q?JOQeiHh3wyO5ljmC5jZP/ajomP5hD3+dGdBJbgD03KZl0+FGTLUfXxI1OywK?=
 =?us-ascii?Q?xIF0W5qBpYFyECmn+2Qpc/N1gZN0r+UtwEZZXGXEntb7JVye+TPe3T7TG3XZ?=
 =?us-ascii?Q?ka0tfITszJ05/WI8rXixgR8Wl5eH4p/Cu4hcqC/ELirPX+GbIH/VokD/fR81?=
 =?us-ascii?Q?nUkNcMT5OA3lIc40HOY/q3zewirQdYPXKSmiptk9EizxM9fkZX02YNJzbkr7?=
 =?us-ascii?Q?IIjmNEjO8oIGNqoEEQr8tOrnQP0uHmBzn1rRJsU5+ZL0PTCsaY1MTWqNJ/ub?=
 =?us-ascii?Q?DNXMUBF0R9w1cMxO1f/Yte+0dOsS8RRUKlbUgVui8iJ73SmTKV2bXsIOoUqv?=
 =?us-ascii?Q?Uwm4eWItjRUnYXyM8bYJj7KsRVxw6eEDYItA6i4EvUQPQK+WkH6IdamRSnH5?=
 =?us-ascii?Q?IcYxucZtvI4+9m1yqcstZ5AX6ifBs82PtiU3u2FaUO2Uw+MQlUeO7BYC1h6v?=
 =?us-ascii?Q?S1SaZDv5IuWwXnYI5E3vXnLvfJW9eiZ3iP+G4d43w2QRPbPKIarihCmuqVLq?=
 =?us-ascii?Q?kkeu+TTxjwN9v5blPZnuC0YXWuaXQWZ876dBSHSTdY6Hj9vPiOTwynWFtQfA?=
 =?us-ascii?Q?3ghIvHdzLKKCwIpyqGkBSARuYxhfMzUDIDT1NyfOX1D8JrrYKV6f8iV8BXeZ?=
 =?us-ascii?Q?fxbeESFjDcTe5jF9YhgcNdI8LQdk5cww8ANwL+kX1tGGQmBsSSkJI+L+UUY1?=
 =?us-ascii?Q?4vR7+3Oo5cnQfBeCDRTYNaEiEBy8y6ILgDGxWOnxsOjHyUeCYQyp19iEbHcU?=
 =?us-ascii?Q?Y2gWCg7Sj+cAp6vDf27RGCmmHYHzLt1eWPFjNMDBTSkBxTwe9svk/tNdGtDM?=
 =?us-ascii?Q?BAoMTBmbwPQPfp99IF3F8B9qjXlpOuB+kRKaYi0+z0RYmsTkxh1qfhObw3aj?=
 =?us-ascii?Q?Gjgmg23N7TvMQ7X1rOS2aUEoicml1cBEnKeiB6idxZj4mxicpF1KK86VyyFl?=
 =?us-ascii?Q?S8vGlASS//CIQoDJ3Ojy4PHIZNyGUkmZkdGo0Ctlk6NH3Oh+NVptN71ZdY0A?=
 =?us-ascii?Q?QFOG4Q3WS31gBw2FPtE49QY0EZF/QxDZ8EXTp+3l1ny64rtyf9I1AuMwb1xp?=
 =?us-ascii?Q?EhEvAq2l7/GEHP62enIaUugwZCl5fTB9q+FN/hmeGoC9BxT8rZDDsb8p8a1/?=
 =?us-ascii?Q?DBs+koXRjA+jNhorUtKZewmHVcNgOSWKEO/ru9pKBK6xdJww6VSVlMKzTJrU?=
 =?us-ascii?Q?Zr3RBpMDisMK3mXOW+DHp9OEH4m5g+QC7zS/xHkOisr9AJzGDvDT+n55U5Og?=
 =?us-ascii?Q?PYTSj/bNvuVGXrAkL/3v1Kjqq/0nivdEyzRx0rufIwEDzv51WGaLPKo5/t82?=
 =?us-ascii?Q?Ur3YuGwEqBqRnp07+NO60xkrVMtBV/1F/vyoMmKElmHFCXdZ4ALNyUkRpRHW?=
 =?us-ascii?Q?BqMwy/Et/pUB6natpEtIBiXGEsibIX5j/UntZ32e7Hbc6hzYekqtG5VkgCj2?=
 =?us-ascii?Q?mZPj0hUdJ501g26MpfgoSExY/gmdm3POIezC3w+KbdgXCzUo4EsJ1eAGkspw?=
 =?us-ascii?Q?CvJpjCcN7DzPs5jQPv/gIjxmUXUb7Eqtw4n4diFKeeCu24vTbxuB9qYi3bsC?=
 =?us-ascii?Q?kcMkHAXIVZYi4VlbZlCioaI3jx+q5Wn2i+MNln+mv7BjDguDTo7vivKIiGT/?=
 =?us-ascii?Q?x7L/xCuhyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZjwpZ8HgjrQuC4eaYr6tOk7jYEbw42ZmdZMomWEnshL/BWI9bIqLJWhqmH4wm/1Ig2+xRZbPrZh2Qy3kdydOyz5oH2D0PIGPZ/ErUuHkB0p5Lm33Ukpq15yK66nhs3lBnxK0pmdlNn1hjXRQHRB0yR8KpU+7O3VZcxq30OeTSdtaCmgOQG8RVSxpMwd+q9FaRj7UOTx6M3BlYNjofLpewjN0iwFj1+2cXDtcIEWJUDiQqSXyHwbpMjFC8RxTAkT+MxDvgnq5n1TwiKvmDh0hC9lu4hQ1s23qjdM6hgE8c3bUJMND7epf2ct6WghdTugCIyb4phht5L3PBGLC2YEUmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB046149.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0996d827-6ec2-4224-6b2b-08df49c45eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:46:26.0512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVRJnamw/j7pAHDfEDb6tu0vR6VsXOKHdWLw2Sq2ATtz8i3xSzf6NnDvLjlYW8L+dqEe6NGT0VnywOxgpX7Mar8Toog6P+mfRCfpOm6zUSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



>-----Original Message-----
>From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>Rodrigo Vivi
>Sent: Monday, November 23, 2026 6:33 PM
>To: dri-devel@lists.freedesktop.org
>Cc: intel-xe@lists.freedesktop.org; Vivi, Rodrigo <rodrigo.vivi@intel.com>
>Subject: [PATCH 1/3] drm/ras: Initialize ret in the list-nodes dump
>
>The drm-ras family is registered by the DRM core, so list-nodes can be
>requested while no node is registered. The loop then does not run and
>drm_ras_nl_list_nodes_dumpit() returns an uninitialized value.
>
>Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over
>generic netlink")
>Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>---
> drivers/gpu/drm/drm_ras.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>index b099eb67836e..4f4777060a4e 100644
>--- a/drivers/gpu/drm/drm_ras.c
>+++ b/drivers/gpu/drm/drm_ras.c
>@@ -130,7 +130,7 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff
>*skb,
> 	struct drm_ras_node *node;
> 	struct nlattr *hdr;
> 	unsigned long id;
>-	int ret;
>+	int ret =3D 0;

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

> 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
> 		hdr =3D genlmsg_iput(skb, info);
>--
>2.56.0

