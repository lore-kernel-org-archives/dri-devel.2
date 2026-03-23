Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3448F483D5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512CA10E04C;
	Mon, 23 Mar 2026 17:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GoSdkI9U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF6710E04C;
 Mon, 23 Mar 2026 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774285914; x=1805821914;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AtbAVhN38ktCrovK3AYUGvxOqEVzlOFidziVz1EbKN4=;
 b=GoSdkI9Ue8NLH/EPksLQYU5cc8C6kenPZ/oewmELO/paxi+gymtRiihs
 6LgCaw55e7i5jV1RtLlr4w04FAS9+481P4F+ZfrciSGyC3ZuG4NJ+F/o2
 2YHCjzJejSI04cF5MBZ9m4lv3nwWGWzPmgi7MjiGzX86B6Ji0LLmAKoSI
 zBGBGvU5Af6sYpCggDrdr6JicxX7wwIcHvhSa2hxnfrhuz2g3Zum/IHtp
 fGKN0GA5gC0pTSBe2PinIP2E716GVaWJEsrd1j05UW5OmOtyTF3EJRWwd
 kWQEylmFTKpaIbXLiOASD7K04wpKq9JvNdkEyHAjSa72CF13FR/UzRsKk w==;
X-CSE-ConnectionGUID: 4VWXExLdQLqiwXTd9JTwIw==
X-CSE-MsgGUID: moJYCyqTSNqZC3bI9HrkHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="97910692"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="97910692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:11:53 -0700
X-CSE-ConnectionGUID: GxGlvP6mQo2kQYe2n4Gwbw==
X-CSE-MsgGUID: c0IXqxKIQDa1NXYEUROy0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="223277332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:11:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:11:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:11:51 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7hHdAjqBdDjjXoohDQAENEP6rUAIXmvhHtgo1H4KXcgsMbHnTpDWbOgSHyHEWRxLrQuOjpegIG5GXo/0iipBLP/HTee/xf9VnI9GHQLGl6jOH8HuuGevIMpmI9kwtmO0Po3VftFkeQ8YlXA/cw7Zi54kyWWkv0cDKnD1T5zT16BBEmWDf1tQuG99YKcwlRjvh6oPqjrcaeBnUfiLOUxDqX1gmJa4O6IAuqQoWQTdXc2Io8Xd3zZHhOVdK77ZXAP122bszF3WJ/Mz3z+x0uzjCsM8tvo4KcJXm958InPFgeB6aord87lA3saXHjYvLT57yu5QmlypT2AOqj1WEkW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69pcBAwzLmgNP9RlzRgprh8+lC+/+rob/38fcgEGcYs=;
 b=RY/j3IKtMPMMUKFggI8ZDC7q0uILEEuFbjIH2hO7prKYj+B6TbVyTMesDK6lXicBKlMvACyXVGhmfqqhmQd2gMS5r3d8e4mFzqaL+DMWLn4gTiXfT931blKNMvgoCp0adY3HdcPvFjxuMOGROtLdMfUMt/Ij3kXxbnoVswkimPRnhsm7pw5bPNY3bdpEbN8edCGHi+u+qF2hwwL/Wk3hWWpvZuhHeDVqFf990AP3emwQe9Q33eOWMwE+Ybgzv6gGMnRpop6OrsNGOnOSr32uCAHJdENHiElOZJbqugNwSoVxWPGmG/80lkcE2jGIdDoyC1Sr94IEqBhzNZzvU3ouKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:11:48 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:11:48 +0000
Date: Mon, 23 Mar 2026 10:11:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Danilo
 Krummrich" <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Daniel Stone <daniels@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, John Hubbard
 <jhubbard@nvidia.com>, <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acF0Tr4Hzev8Paxy@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
 <20260317214320.74e6c130@fedora>
 <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
 <20260319105729.2c20116d@fedora>
 <ab+PgBzwJkhhj6dw@lstrano-desk.jf.intel.com>
 <acDyu5M7KY0qQ5aD@lstrano-desk.jf.intel.com>
 <20260323110613.6b153163@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323110613.6b153163@fedora>
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b682d2-46da-4148-5c66-08de88ff4455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KjAQ8K7qPBIiMtOszqLc1vQBVcrmP9xXkpZ7cV/iauhwOb6fylTssHEBrcrd+tWqgNZXAuoUH88wb7opRiaIxvROhMQfn0s2x7fBZ20hc3ezzj93xgUkudWv40S8ZVp+qNbJbnNM8kaccdqdgY7vZQ0Hkfo0lifv3Dl7lXre+Wx1zkfUwh3wWJSD4TcC0EzaXAnB2k4azowj4OjTGbyT1lqfc/JsHzI+He0KhslfVUhEeZg+qbKOg+xEQlwN1eaNAyFDLnqz7VLIqqTt44WytLaBDoaMrPFHpV/OIdf1Y9qLJW03YoMpn+e4FqJqogvN5Luh7YT1xqftXb7goaF0zFpF1JtuAq/lLgCQGb/SDE7PzC0tmny9JF1b5bshpK9jedL5p1Xds7uz+DMQIHMID+Snrn+0yC8tn23YvJjZgHlqBcCE4xvzIM3sctHRWGxClFTov+cUSKuC7H8+/0xPIGZi59wMs9X2Xa5mLs4iOaoDhkR8Bs/s+bxajQ1cVeBbfZtFTme9K0J/i+vE5cH0aoOgv1QPepFI7oPd9z122RPPSdWdm++MqNHCQvySYbOrOQSQdzzZGRcPPN/CScUXX/9bWMij96xPSr2m3EA2LJUWwIXJyXOkHwiqNfwPrAcb7/4jLHGIO0FcS8nw21Ch+bZ9/RBCeFkbeocPAMOKPxuSduNf7mKdHHxTL/CpcH8mJcIIjHLfG8gkvht/BrhlfUT8z2FP0QmwkNXAkRtRIR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRubVJDUXAxTkUxR1VpSEZhM0ZWcnFGa2hDa2pzSjFsQjB5MGxKQUxRRWtF?=
 =?utf-8?B?SkErRW5IM0QyR3Azc1M0Q0JqU0wyQ25URlJqVDhVQzRLaGN3Y3V1eDd0U29k?=
 =?utf-8?B?KzZkTFJSV3JCME0wMUlLNkU2MlNRL3FRazcwQ21oVmNmWWdLSjV2OSs0WnM1?=
 =?utf-8?B?WG53cUxjQTJLQmc1MUVUeEZLay9SOE13ZEtrWlg4cXhlRTZLUlBDbU40cUVQ?=
 =?utf-8?B?dmNocFZjcWZWbU5pVWVPYTdvUit4cy9iOUdUYjNoei96L3hrMHB5QjlHZGMr?=
 =?utf-8?B?Q1RadGhrK05zcGZHTllZcUQ1Uk4zYjBuTUkwcWJyd0JRbldYN0s0UTlqNjdF?=
 =?utf-8?B?cHpoSTlBWE9HWlFja0RoZmVtVWZRaUhMZzIrVTZrYkpXangzL1JZZTgya25n?=
 =?utf-8?B?dmtyeFpLazhFbXBXQ3lrN3R5dHdOazlNSWNHZTU0RUNpY0FSZHBFQmYrUXJk?=
 =?utf-8?B?VHVZYmVQbHJra2xEUEduQ2NqbXlLSGV2SW5LeWk3Vms5OXhseFRKczhzVi9T?=
 =?utf-8?B?bzN2NkoxczZid0dxRmozZW1EOE5aZXlDM0pOMEF3U2VvRDhKWnk4UzU1WmI1?=
 =?utf-8?B?UnF2MHFMSEtyR2NDQW1SSUI1clNlMkhHdkpPVEFpQmsrRExBQjZUN0hHb09Q?=
 =?utf-8?B?a2N5Z09uQ0wzbFRrYWFZbTNOa0tnTThMaitoOHczRTJlaitGWnptZmwwTjdC?=
 =?utf-8?B?b0RSQWQxOEdRSlJ3dmFHQ3FYaXQxbWE5VkNVbkZnMXVnSlZBSEZiWTJ0WWxG?=
 =?utf-8?B?MVJqSDNmcHJibDRlVGZUcGhGaVdIRkVSaGY1b1krQktKaWY1OTNta1J0RVF0?=
 =?utf-8?B?ZzVvdjhsZDVOdUhpeUdFbzZrajdkZXB5L3l6UFNNYWJlWlRtUHVCbGhCRWFn?=
 =?utf-8?B?cklsYjQrMWxJd0JWeklGYTV5TTIyVDZ1QmEyelJpczlDeWVkdW5ZNzBVTVVW?=
 =?utf-8?B?Y3NTdjkwbjljY0hMNGdiZkV4TzFRUkVLbVJRNVduLzEzL3RyWjE5a2MvRG5r?=
 =?utf-8?B?QkpTdGEwSjRnWG52UEtDNWJub1pwREpZd1hKYjZmVjU4YUU4VFlLZU83Smtq?=
 =?utf-8?B?MXdscExnNE9mTGtnMWFRV1l4YjRvOHA4WTBhZXpQcjR3ekY5b3BPbTQxSStZ?=
 =?utf-8?B?ejcxN2trVVFXSlordlU0R3YxTkVxbDJLdGhYRnlYdWZqTVA1MzFLWlVBb2Iy?=
 =?utf-8?B?dUQxTnpzZU9qSUxsZ0hDVGNINlA1ZnZ2bmQ2ZXNLS0JPelIzVTlmV0w4R1k3?=
 =?utf-8?B?eE9NckMxSzE5c2J1aEVuS3ZBZWtCY0dlMTZNRGtObFNXb1pWNFdlbnpUQWh2?=
 =?utf-8?B?bVNMZnYvSVphL3o0djJTa0IvaDY0UXFDN2RRRHFwTDFMdFZkb2pjVHNHWE5i?=
 =?utf-8?B?OUQvemZkUUZmRVIxdndUbGRVUjRCaUFvR2d2S3hqQ0RzTnpFRzhiSnNZY042?=
 =?utf-8?B?MGdUT1NxUkRHbi9BNGlrclVaTG90NlRNZ2pOcHg3K0hNbVQzM2FlOTVGMjdi?=
 =?utf-8?B?SFpRV0F1bkt1bFI5WkJnbCtscmdPV0NRc2FMTXBaV0tJL3YzK28wM3FYb09H?=
 =?utf-8?B?OVVlNnp4d2pBdnNMbkRsOGdEamVhWmdrWXByODM3cjVycXpYUVNxRy9Ca2NO?=
 =?utf-8?B?ckZzd1NCeVVUWmdlVDA4NDN6RGExNU8wQ1lvNkVMSnAwL3VWcU9Vbm1QZDFW?=
 =?utf-8?B?elF5Q2ZMd1FUMWNWVVdWcmd0aVh2djNHYzJsOFlwUUErZUowY0FMU296WU5L?=
 =?utf-8?B?N1BkR0plajk2ZFA5QzYrNW1JUzlxeXlxQnI5alFYVHJPVDNlOEthdHkyRktk?=
 =?utf-8?B?SWtDUWNwQmsvSDBaN2NsWlk1akpOQXBWSURPbmw0VU5JaGUwZDQ5SnBQbkgr?=
 =?utf-8?B?K2R5OWE2MjdmUng1ZEZJZkJQdWdyTVhiaUZiVjExaWJQcjhTL0FvV0lESXE0?=
 =?utf-8?B?YVk1a0JQM3ZtbysvaGRoWFBxZjhRNlBDUndmZTI3YWFSZG1IWWFJaWRFbEhu?=
 =?utf-8?B?RzAwVUxNekxaSVBEcXVDT0F3UXBJMDhSeTd5QWI1QXg1WDlwd3pzSG1lQ0U3?=
 =?utf-8?B?c1A4U0RBaEtCWm92ZjhoY1VHeitoZGFsRCtPNjJEcDhkR1AyeUo3L0g4Tmx5?=
 =?utf-8?B?a1lRSzdLQ3Z1VnBad0lPY0xsdE5iNjBQV1JPajBQVHdhbDNIeDBYYzJlK05z?=
 =?utf-8?B?OStXbUJ2VjlCcDcwQm45MUYxOG81SmxmUFd2VDl4bVlJa0tZdm02cGZaQk12?=
 =?utf-8?B?d1ZEWjQ2ZmJtWlZnQlpuUHhVcUpXMko2ajN5TldYSDZKb2NXb3IzeWtOZWsv?=
 =?utf-8?B?TjZzNVh3VEdzdnc0dFF3ZGtvRlpCZ2FoRElpVllkcFhkN1hHdjJWQT09?=
X-Exchange-RoutingPolicyChecked: kKgCr707G+RQTWcTWDn2TcFx71j8SUcDI6/qFF9AJ/X2wFGDWQD40jAN07X7fL2jeJP0WkeoimHgIA18lUTY73yVTBEjxMbqthfR4oUYBz1R18r2ez0icDoo+6XDGWPp0ximEkFLimMrr/qIgttRGx2gbtDLDnNNjemNYm31tKw6AWeNtc5za6B4oZQru6BxE+/OxhyHHXrv4EOdrtiwE4/1Z7t2fNRb6Lf3krY9fkOM+kdrAMNUMtXnw0ROGRpbfbiuzZzJNGdcjWBRi9jtJOnyMew40OabU6ZU/2dsd4l7X/gkuv7e+qVa5w/gqdiGR/XQ3RTRAMCwPFEuaO+Rrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b682d2-46da-4148-5c66-08de88ff4455
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:11:47.9640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFuPdMPP5SPAZ1sHqp5wCIXZWoHOz/HinZLSVtA9cEXieyyI/yjXu306a3wyP8eRH2Cb0XmXNQm0ip2im/1T+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
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

On Mon, Mar 23, 2026 at 11:06:13AM +0100, Boris Brezillon wrote:
> On Mon, 23 Mar 2026 00:58:51 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > > > It's not the refcount model I'm complaining about, it's the "part of it
> > > > is always freed immediately, part of it is deferred, but not always ..."
> > > > that happens in drm_dep_job_release() I'm questioning. I'd really
> > > > prefer something like:
> > > >   
> > > 
> > > You are completely missing the point here.
> > >   
> > 
> > Let me rephrase this — I realize this may come across as rude, which is
> > not my intent.
> 
> No offense taken ;-).
> 
> > I believe there is simply a disconnect in understanding
> > the constraints.
> > 
> > In my example below, the job release completes within bounded time
> > constraints, which makes it suitable for direct release in IRQ context,
> > bypassing the need for a work item that would otherwise incur a costly
> > CPU context switch.
> 
> In the other thread, I've explained in more details why I think
> deferred cleanup of jobs is not as bad as you make it sound (context
> switch amortized by the fact it's already there for queue progress
> checking). But let's assume it is, I'd prefer a model where we say
> "ops->job_release() has to be IRQ-safe" and have implementations defer
> their cleanup if they have to, than this mixed approach with a flag. Of
> course, I'd still like to have numbers proving that this job cleanup
> deferral actually makes a difference in practice :P.

Yes, I replied there will either drop this or have solid numbers showing
yes, the CPU utlization shows this is worth while.

Matt 
