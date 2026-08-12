Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E2EC5CFC1
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F03B89A1F;
	Wed, 12 Aug 2026 00:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NnID7JlE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9471989A1F;
 Wed, 12 Aug 2026 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786495958; x=1818031958;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RU75DAt3Bmu+rPgGyhaxGd7lUFERzZb/0u9EUCuAOvw=;
 b=NnID7JlE34oHAQpq0jivSniyVQ2QPIwjemoZ67V7dq2jSXGUfQp18Lh0
 wZY0bE0Ui6lrJkoBEJyTs2QnLsutDCNtUOGR15NDxmdw+MX1YzIU0SWvv
 LtC+MSJW1a/emr3+6CZVl569JyP4aVxVmm67+UOl28YNLI9talMZNHg5b
 CcJUhLVcvw4cLfXZxWiDre+HSYq6ZTHIqi5Ae04bsJ0jB0HKyrWPvCT99
 AyyDullN9x1//Pa7lAqPTVk4rxyO7DES5ofxA63eK47szwALNayUJ4jIg
 ZB6EzH5qy8ZJFmmNjNIUeZP5cLrtk4cCpvXY+2KZuEN/rWcZWGKsEveAg Q==;
X-CSE-ConnectionGUID: qQrU+FDyTh+vsiv3aCHXag==
X-CSE-MsgGUID: nL113ynMSQCiSrcd+NsyNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87060876"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="87060876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 17:52:37 -0700
X-CSE-ConnectionGUID: JviXYEyEQ0e53jvxq90LZg==
X-CSE-MsgGUID: /AFTJEV7SRm074RlF+PVvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="286910533"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 17:52:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 17:52:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 17:52:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 17:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CctWen6XKxuRx4xPw4rvLfAye3bjNe/HcojXa1OfiBIgoJmxXrqXTnDpmezDLYqO2XSVY5Lir9DjZZyiSu0UJaQEFT+IPYYw4cVf/EqbkPe3cNWId/uzZtH4Gi6Yajxbx6BexwPPPNTBedUA3knMQQXEWy+2N2rwQqVmYJGA61WqcmNJ+TrNggRGCy7wkbQlG19ZnvUzQsxcU3Hk4RG9OPa6RS/6cmzl8Q+EyX9tBS7UpL+7FL0os62+4igo9VLabbAoXEKKE4w3NnyEQcN1tiZnba0u4cLFafsSsnQpA4tauFwwR5Fvj2r3jDaAtJcB6eG9/zEHaZ5vjden7URJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7yPvSTvaEbWcRA3gC24jp/CTMUl6D4IIP2BsgiahMw=;
 b=mEJgXi0ojPl+vV1mrgAPB/Y46m0Ld6rFQk4tLGNT4Oc9qjPkJrWXowUtPRVvWtFJQoxjL8lvNG7GzeYwjLsVBK/RGPxCE6WEShk3/4TRR2B51pxRgjHCOQtp8nzySAXwGnVdoCKvgNZqWV/7Zza7OtWOwbyU5kHf9vcBNeIx7PZIAElKZbY6UAt4fDqNI6KaESllLcVy03X9fI98+WPEalLius4JXRDZrKSik21FxvwEvU7FuYiM1DmRtVpr67pKJHhbtZn1R5ZNgZYf4ncHy9GZ1CYr6gDNv5YprCHdFDpaLk3qgtxku8CWGUOa4xiGYW17e8RPg1cdVgttSzJFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 00:52:31 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 00:52:31 +0000
Date: Tue, 11 Aug 2026 17:52:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, "Summers,
 Stuart" <stuart.summers@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Message-ID: <anvDzcPNwITTsZbu@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
 <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
 <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
 <49792f00-d8e3-41c7-ab2d-1d7efe4b5aca@intel.com>
 <CAHBRX4ELrBJcRj-8LLryKT_0Jnc-8R0ZFLc4N4fu6yDb6f=wDQ@mail.gmail.com>
 <3ee610ea-1707-4ab7-b0cf-20852b7c971f@intel.com>
 <CAHBRX4Eqx4WvHjv9-ByNmGiB-eE=GDGy1REZ8LhFKDwa=4Feqw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4Eqx4WvHjv9-ByNmGiB-eE=GDGy1REZ8LhFKDwa=4Feqw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f2fe9a-eba0-48c3-de63-08def80bfd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|13003099007|3023799007|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: njsRGP9Y6yESqCtKeCgMxdcxN7gsGRj0c5kdTF9ZBLXUWbjQ/NFg5m/kfiXKIez72HkM+LK/o8Ne61yvACEmjLu9bfDmWAa//3THaNAGr303SqZNYwJCVy1jY8+QZsUM8S5e5MbvVy/b5pNc511688q4oIkFdjQwPQ9jUBhmTa8lQcNrKydG4Q2NsD1W0x1jO7NMUluVyFFxXY2b7rD2pt4otW5SAGiAH5wqisGFvA2lAxxOmcoHYlf5k18N/gESO9G3/ljkukTg9lO3PfvlVvMLdz9V41wn7RuDpVn1z0xKar5tirGVTN5t9mIXm+WvyBblB63ohXWm9MtzEn+JpxqRVvZ6F+J3JLVhmARxEP4bPjSfcPJWgSR6Bbye+ekmOsYityWAWYlMOHNdzxX6wnoM7BWK2fATcGQwu4BnCVT8ZzjOHopG403qr1e8uqYO+BrY1RGKGfSuVlS9dbYFhwq6Wn18qTiIwENwqCHlGF8ZsPhNMO3ANtRqBX7p1PhyUwP1rK1ae/dZU9eWita0L97F4Qtgt5SkxV2E68wY47khjIAxTEP6g01OBleKxDwm06CWHwrbY0hVSo1rQJbVN3L+PzwtpUItTk6AcNBWCKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(13003099007)(3023799007)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8b4vV/fq5Yl+A1AFDaIlH37wYSTK740ffKY7d5lbwQdhPbed4L8T7V+bRm?=
 =?iso-8859-1?Q?mnVneAK/EkG6zHf1DdpLvgIDhfN9e0E7oeFVJ5ILwqJO81Gt4YF3lhxAtP?=
 =?iso-8859-1?Q?pD0Pm7OKIFHOyQyLUQbB4pUVNWRbKv+TTIAdpqFr37nX5rL3k3uwIMEDdX?=
 =?iso-8859-1?Q?jM+gMgQ2IUiNryPGrpX4QuYdDE7uMUtpfvzUIYxgepMdfzwXVesacF0nKc?=
 =?iso-8859-1?Q?SAbYMeVdXBhm1GVnIMtJwFYm5FzZ9tbgVJ5cUnmsIURXgl9NjoqsGIWHsR?=
 =?iso-8859-1?Q?xQvogKQ0Gh+BpoJdvPlsAexIbSHPdnLSODDcnAH9pHNf1xOVn13ZGrg1+R?=
 =?iso-8859-1?Q?zc5RQU1yJzKWc8uYTCIan7mbWwvkQ6vx5frMB0+dvC9+zkUIO9+wQTmRWe?=
 =?iso-8859-1?Q?4fdxUfDlsduebClHJTktD835d5iQ0zNzhkmnS19dw6bqUjE7MrzIm2Z7Vx?=
 =?iso-8859-1?Q?3n0fOHqtf3KNy2DkmSLKYPTYdJ05lkJRdx7ZsdFX81aNUeTCEBDS9RqZUI?=
 =?iso-8859-1?Q?6sm175ssVZ4GeDVEVCoqJFFuXHwD+S2PDM5TtgR/kOaKdFsMAkC9wOBD6Z?=
 =?iso-8859-1?Q?ZUcpbNWG6um+yK7/wKdtCI7QouJuE81iMdW6bCesiwP6N/0b0iw3XkqgGg?=
 =?iso-8859-1?Q?+hzvl8Wh/AhzodnRnlmZcN2hu3s01JCQC/QoXSl4afLO65uIa/N4bj9Ejr?=
 =?iso-8859-1?Q?uYRnvbzE+YGql7tUBvmpFLl5UC5qmrDiWe6tiQMvay7MWBLRbm7m0i0KtD?=
 =?iso-8859-1?Q?PzKgfF5R6dh8aEDJGzy49PU31Oc2sY1mD4ll9wRvV2hp57tLnXTBlXv3Jf?=
 =?iso-8859-1?Q?Yer4n88ZOp1zlRFk5Dpp6NQPP1IH+r4NC2AYVzhn+Ay99fRjkQOyUKEUL0?=
 =?iso-8859-1?Q?hs8IKnLjqeCqUx0t8N+RqO+MtFjJ5+fh+akZUNI6tDayNOVedK5NN2E5qk?=
 =?iso-8859-1?Q?Dlm1QTyuDIfKoGYjaMfi9U1NOZQGjS8KOgzGUsnkBxkFhCooYOLwTFj+6P?=
 =?iso-8859-1?Q?vaBM+NTjDHNkaAMwfRxKeORiswYwAev0pBRhrTu4n8klM0bu5dkNVgzkl1?=
 =?iso-8859-1?Q?Qn3m09NrbJEWTEXjE2JnMuPXS+E7DcW5aHgLJw3jUEd8XhjJZNiLDULPCO?=
 =?iso-8859-1?Q?VnE0pNodIuXUbMfyNGmpRlHMKpEOsRnC9t/Y1c8rwZ22/iTHcAK4iLlMal?=
 =?iso-8859-1?Q?D/sK0B49oxcNDHJ+EFBm2K/Lcx8s2aNsaMs0L9EpWwgs61vvtdID5YHq3D?=
 =?iso-8859-1?Q?5Jtsu1TETmcto1aRZbZk0zYrvI8FZYKvlNhROQcNzQNHtdT4UIGzpoTf1m?=
 =?iso-8859-1?Q?6O1s++gACLk1gMVOqwUQXrn/Y9nSmUhIHE9ebXrjTsGVORNgsPCwoVtMY2?=
 =?iso-8859-1?Q?e7wtgPpNXfKzGI9a25wQo98mfjskDsniL+b/OmyG79JEW/nMF1nXkFT2ma?=
 =?iso-8859-1?Q?i+udpBGBuWB55vuLqaxZtooB69+alOR/n9OG2HjCF31NNtvULH/rQ0wpxn?=
 =?iso-8859-1?Q?jrBCaY9zYcuZRWJPrMUPBT7nkko/tXUIs+jl1gmYsiTtnwrmls0gs83imJ?=
 =?iso-8859-1?Q?AnOphmy++QcgqHAjJILi50HQU444TOFfeUpVKqU5sLasubD3zTav4hMkKe?=
 =?iso-8859-1?Q?ERmuPkUalXMaV+OI4UkKFfuPE1Les0t3PWsu7c2pzp8X1OparsAMEKaHsT?=
 =?iso-8859-1?Q?MEpFU2lWSYWa/42l7sM3nOgDkY62XRbxHvgZuRBNIRFGei2IxhGPD4U7pt?=
 =?iso-8859-1?Q?6ssy0rfwSkdaNMDzJ4GTNl2j5G64SPcWAxW9Qrcvd9aPFnyaRax7TBurzb?=
 =?iso-8859-1?Q?ZQqibRnCsHAJ5szPpVRL1GtksAJOFw4=3D?=
X-Exchange-RoutingPolicyChecked: rpgM3ZBEXhe2ja5l+6WuLl1vPWJzej79F8WH589B3m3IxXQuwuzWhgUDrweLXKFafOzELchQkTfx2bYdAzvKYMlfyeURYbTT8KF8WxXPr4NmFAfDQ379lFyreDEpKdqkjHhMekzprw4nmO/qPqxxo75ajv0urrHNoLyDKu3yH0Y9XEW6Y33tEKzJNPUtCAk6q9YmKcWPrE0B/w89IYFgNilvntYLn4a03zsYIOO55TiU7eJwdajddBfVpx2OjIRvtIzIqCbRAwRD37Riug29Qh0BFmERXyPSNpOlp+LczQ+r/XQIdAgthaEQ+iMhukmrHsWM8jEtsy5uMknouqKOpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f2fe9a-eba0-48c3-de63-08def80bfd6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 00:52:31.5787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqVnWL2LgDg6qQ7fXsON5eWnSp+yOlE/qwJ7PVWCRM7MpOMJ7XGB8gMvpsiD8Fxh4oGcmLJs2+C8ik+fo6cUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
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

On Sat, Aug 08, 2026 at 06:04:25PM -0300, Tales A. Mendonça wrote:
> Results: the GT1 cache-line theory is confirmed.
> 
> With XE_BO_FLAG_NEEDS_UC added to both CTB allocations (blunt version,
> all GTs), firmware back to stock 70.53.0, same kernel otherwise:
> 
>   ~6h of my normal workload (sustained load 4-6), ~480k TLB
>   invalidations per GT processed (per gt stats), ZERO stall events,
>   ZERO fence timeouts.

Awesome.

> 
> For comparison, yesterday on the same workload (cached CTBs): 14 stalls
> in the first ~1h45 of use, 59 stalls / 20 timeouts over the day. Every
> previous kernel reproduced within the first hour, every day, for weeks.
> 
> So the GuC was replying in time all along - the CPU was reading a stale
> cache line of the G2H CTB, and the near-constant 2.3s "stall" was just
> how long the line took to get evicted naturally. That explains the
> whole signature: H2G direction fine, G2H CTB "empty" at timeout, H2G
> interrupt kicks unsticking only some episodes, firmware version
> irrelevant.
> 
> I am happy to send a proper Wa_22016122933 implementation for xe. Two
> questions on the preferred shape before I do:
> 
> 1. Scoping: mirror i915 (media GT only on the affected platforms), or
>    is there a reason to cover both GTs on MTL/ARL? My blunt test cannot
>    distinguish - Daniele's decode showed failures only on GT1, but I
>    applied UC everywhere.
> 

I'd scope this to mirror the i915 W/A.

> 2. Coverage: is the CTB buffer enough, or should the descriptor and/or
>    the GuC log buffer get the same treatment (wherever the CPU polls
>    GuC-written memory)?

I don't know enough about the W/A offhand so say, but again I'd just do
whatever we did on the i915 in Xe.

Matt

> 
> I will keep running the UC kernel and report the full-day numbers, but
> after weeks of daily reproduction, six hours at zero with ~960k
> invalidations processed is already a very strong signal.
> 
> Thanks,
> Tales
> 
> Em qui., 6 de ago. de 2026 às 18:13, Daniele Ceraolo Spurio
> <daniele.ceraolospurio@intel.com> escreveu:
> >
> >
> >
> > On 8/6/2026 10:36 AM, Tales A. Mendonça wrote:
> > >> That would definitely help, because if the issue does not happen on i915
> > >> it likely means that we're missing a WA or something like that in Xe.
> > > Two data points on that, pulling in different directions:
> > >
> > > * My second ARL machine (7dd1) has been running i915 for 7 days now,
> > >    with the same GuC 70.53.0, and there is not a single TLB invalidation
> > >    timeout or GuC error in its logs. Caveat: i915's TLB invalidation
> > >    timeout is longer than xe's 2.25s, so short stalls could be silent
> > >    there.
> > >
> > > * However, Matt just pointed at i915 MTL issue 14469, which looks like
> > >    the same problem on i915 - so it may not be xe-specific after all.
> > >
> > > If it helps I can also boot i915 on the primary machine (7d51), where I
> > > can compare against days of xe statistics on identical workloads.
> > >
> > >> Just a bit of a terminology update here, to make sure we're on the same
> > >> page: we usually refer to the notification you're sending to the GuC as
> > >> an H2G interrupt and not a doorbell.
> > > Thanks for the correction - I will use H2G interrupt from here on and
> > > fix the terminology in v2.
> > >
> > >> It feels like when the
> > >> issue occurs something is stuck in HW rather than GuC FW and triggering
> > >> the interrupt causes the HW to get unstuck.
> > > That fits a pattern I can now see clearly with more data. Since
> > > enabling the bigger GuC logs (~1.5 days, 35 stalls): 12 stalls were
> > > unstuck by one of the H2G interrupts within 0.3-1.5s, but 23 ignored
> > > 8-9 consecutive interrupts and ran to the end. And in those severe
> > > cases the request-to-ack time is nearly constant: 2.28-2.34s, every
> > > single time. It does not look like congestion - it looks like a fixed
> > > internal timeout expiring somewhere and releasing things.
> > >
> > > Related: an A/B experiment I ran earlier (holding forcewake across the
> > > whole GT, C6 residency pinned at 0ms for the whole window) still hit 9
> > > timeouts in a row, so GT-level RC6 avoidance alone does not prevent it.
> > >
> > >> Also, would you be able to capture the GuC logs when the issue occurs?
> > > Done. I rebuilt with the debug-sized log buffers (8M event data / 1M
> > > crash dump / 1M state capture) and xe.guc_log_level=3, and the series'
> > > patch 1 (devcoredump on TLB invalidation timeout) captures the GuC log
> > > at the exact moment the timeout fires. I attached three devcoredumps
> > > (4-8.7MB each, containing the full GuC log around severe stalls that
> > > ignored 8-9 H2G interrupts) to the gitlab issue:
> > >
> > >    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > >
> > > I have more captures if useful (9 so far).
> >
> > Do you happen to have the matching dmesg for those? I decoded the logs
> > but there are thousands of invalidation calls in them; I looked at the
> > last few but from the GuC POV they've all been handled quickly. Dmesg
> > error should log exactly which invalidations were delayed from the
> > driver POV so I can just look at what happens around those.
> > Also, I have noticed that the failures seems to all be on GT1. On MTL,
> > there is a caching bug on GT1 and we do not implement the WA for that in
> > Xe (Wa_22016122933). Not sure if this is the actual root cause, but the
> > fact that it only happens on GT1 makes me suspicious (i.e., it is
> > possible that the GuC is replying in time but CPU doesn't see the reply
> > because the cache-line is not correctly updated, or vice versa). Not
> > sure if there is an easy way to implement this in Xe to test, that's not
> > really my field of expertise; maybe adding XE_BO_FLAG_FORCE_WC or
> > XE_BO_FLAG_NEEDS_UC to the CTB allocation could work as a quick hack?
> > But I'd like either Matt or Thomas to confirm.
> >
> > Daniele
> >
> > >
> > >> I have pushed the latest GuC FW for MTL here in case you want to give it
> > >> a go:
> > > Downloaded and staged - I will switch to 70.72.1 via
> > > xe.guc_firmware_path today and report back with a few days of data
> > > (this machine currently reproduces 20-35 stalls/day under my normal
> > > workload, so the signal should be quick).
> > >
> > > Thanks,
> > > Tales
> > >
> > > Em ter., 4 de ago. de 2026 às 20:50, Daniele Ceraolo Spurio
> > > <daniele.ceraolospurio@intel.com> escreveu:
> > >>
> > >>
> > >> On 8/4/2026 4:00 PM, Tales A. Mendonça wrote:
> > >>>> Are we seeing this on i915?
> > >>> I have not tested i915 on the affected machines yet - the
> > >>> instrumentation that measured the stalls (late-ack logging, kick
> > >>> results) is xe-only, so I have no comparable i915 data. I can boot one
> > >>> of the ARL machines with i915 for a few days and watch for TLB
> > >>> invalidation timeouts there, if that data helps.
> > >> That would definitely help, because if the issue does not happen on i915
> > >> it likely means that we're missing a WA or something like that in Xe.
> > >>
> > >>> More generally: both machines here reproduce reliably (~1 stall/hour
> > >>> on a desktop workload, much more under memory pressure), so I am happy
> > >>> to test anything on them - including any GuC build the firmware team
> > >>> would like data on.
> > >>>
> > >>> On Stuart's masking concern: fully agreed, that is why patch 3 is
> > >>> marked RFC. Patches 1-2 are pure diagnostics and stand on their own; I
> > >>> am fine holding patch 3 until the firmware side has been looked at.
> > >>> The data point it adds is that a doorbell ring unblocks the ack in the
> > >>> majority of episodes, while the severe ones ignore 8-9 consecutive
> > >>> rings - hopefully that narrows where to look inside the GuC.
> > >> Just a bit of a terminology update here, to make sure we're on the same
> > >> page: we usually refer to the notification you're sending to the GuC as
> > >> an H2G interrupt and not a doorbell. I'm making this clarification
> > >> because the GuC supports a separate per-context notification mechanism
> > >> that is referred to as doorbell and which we currently do not implement
> > >> in neither i915 nor Xe.
> > >>
> > >> When receiving the H2G interrupt, the only thing that the GuC does is
> > >> look into the CTB and process anything in there; however, you've said
> > >> that the contents of the H2G CTB are processed immediately, so the
> > >> follow up interrupt should result in the GuC just bailing out and doing
> > >> nothing because there is no data to process. It feels like when the
> > >> issue occurs something is stuck in HW rather than GuC FW and triggering
> > >> the interrupt causes the HW to get unstuck.
> > >>
> > >> I have pushed the latest GuC FW for MTL here in case you want to give it
> > >> a go:
> > >> https://gitlab.com/dceraolo/drm-firmware/-/blob/f783b931555be057dafc2400b7eb4d445c953fec/i915/mtl_guc_70.72.1.bin
> > >> . You can override the GuC firmware used by the driver via the
> > >> xe.guc_firmware_path modparam; the path is relative to /lib/firmware/
> > >> and the firmware needs to be in initramfs for the driver to find it at
> > >> boot. Note that we haven't tested this image on MTL, so it might have
> > >> unexpected results.
> > >>
> > >> Also, would you be able to capture the GuC logs when the issue occurs?
> > >> The default guc log size is relatively small, so you'd have to capture
> > >> right when the issue happens. However, you can make them bigger by
> > >> building the kernel with CONFIG_DRM_XE_DEBUG or by simply modifying the
> > >> xe_guc_log.h file to pick the bigger size by default. If you go with the
> > >> latter, please also set xe.guc_log_level=3 on the command line (this is
> > >> automatically added by the kconfig).
> > >>
> > >> Thanks,
> > >> Daniele
> > >>
> > >>> I will send a v2 addressing Matt's review comments (the
> > >>> __xe_devcoredump unification and the fixes on patch 2).
> > >>>
> > >>> Thanks,
> > >>> Tales
> > >>>
> > >>> Em ter., 4 de ago. de 2026 às 19:08, Daniele Ceraolo Spurio
> > >>> <daniele.ceraolospurio@intel.com> escreveu:
> > >>>>
> > >>>> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
> > >>>>> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
> > >>>>>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
> > >>>>>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendonça wrote:
> > >>>>>>>> Hi,
> > >>>>>>>>
> > >>>>>>>> This series is a follow-up to the TLB invalidation ack stall I
> > >>>>>>>> have
> > >>>>>>>> been debugging on ARL, tracked in:
> > >>>>>>>>
> > >>>>>>>>      https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > >>>>>>>>
> > >>>>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51
> > >>>>>>>> and
> > >>>>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
> > >>>>>>>> the
> > >>>>>>>> issue above), TLB invalidation acks intermittently stall for
> > >>>>>>>> ~2.3s.
> > >>>>>>>> The H2G request is consumed from the CTB immediately and the G2H
> > >>>>>>>> CTB
> > >>>>>>>> is empty the whole time - the firmware simply does not send the
> > >>>>>>>> ack
> > >>>>>>>> until much later. The fence timeout fires at 2.25s and the ack
> > >>>>>>>> lands
> > >>>>>>>> tens of ms after it. Userspace blocked on the invalidation
> > >>>>>>>> (compositor
> > >>>>>>>> buffer unmaps etc.) hitches for the full window.
> > >>>>>>> Firstly, thanks for the patch!
> > >>>>>>>
> > >>>>>>> I haven't looked in to all the details of the sighting you were
> > >>>>>>> debugging, but we have had similar issues that were fixed in a
> > >>>>>>> later
> > >>>>>>> GuC version. I think around 70.60.0? It might be worth trying on
> > >>>>>>> something later than that to see if that helps... (+Daniele)
> > >>>>>>>
> > >>>>>> I think this would require an AR on our end to make a new firmware
> > >>>>>> version available.
> > >>>>>>
> > >>>>>> The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
> > >>>>>> aliases to MTL for firmware). (+Julia too).
> > >>>>>>
> > >>>>>> Presumably, the GuC changelogs should indicate whether an issue
> > >>>>>> related
> > >>>>>> this has been fixed. If so, we need to update all GuC versions across
> > >>>>>> both i915 and Xe.
> > >>>>> Right... I guess I'd still like to see if we can test this in GuC (or
> > >>>>> get confirmation we can't for some reason) before committing something.
> > >>>>> My worry is we will prevent bug reports like this by working around it
> > >>>>> and miss critical bugs that need to be fixed in the right component.
> > >>>>>
> > >>>>>> [1]
> > >>>>>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl_guc_70.bin?ref_type=heads
> > >>>>>>
> > >>>>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has
> > >>>>>>>> no
> > >>>>>>> Is there a reason we don't just re-use the main xe_devcoredump()?
> > >>>>>>>
> > >>>>>> This is my suggestion: the main devcoredump infrastructure is job-
> > >>>>>> based,
> > >>>>>> so it cannot be used for hangs that are not associated with a job.
> > >>>>>>
> > >>>>>> In my opinion, this is a gap on our end. Introducing something like
> > >>>>>> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
> > >>>>>> (e.g.,
> > >>>>>> TLB invalidation timeouts like those addressed in this series, or
> > >>>>>> more
> > >>>>>> generally any GuC protocol hang), makes sense to me.
> > >>>>> Ok makes sense. We can do that here. It would be nice to have a more
> > >>>>> inclusive implementation that lets us call this from anywhere so we
> > >>>>> aren't duplicating things around for different use cases. But not a
> > >>>>> blocker here.
> > >>>>>
> > >>>>>> I haven't looked at the patch yet, but at a high level, adding
> > >>>>>> `xe_devcoredump_gt()` seems like a reasonable approach.
> > >>>>>>
> > >>>>>>>> exec queue or job to blame - leaves a devcoredump with the GuC
> > >>>>>>>> log
> > >>>>>>>> and
> > >>>>>>>> CT state behind (Matt suggested capturing devcoredumps when we
> > >>>>>>>> discussed the issue; devcoredumps from both machines are attached
> > >>>>>>>> to
> > >>>>>>>> the issue above).
> > >>>>>>>>
> > >>>>>>>> Patch 2 logs when the ack for a timed out invalidation finally
> > >>>>>>>> arrives. This is what established that the acks are late rather
> > >>>>>>>> than
> > >>>>>>>> lost.
> > >>>>>>>>
> > >>>>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
> > >>>>>>>> (status
> > >>>>>>>> register read, CT flush, doorbell ring) every 250ms while an ack
> > >>>>>>>> is
> > >>>>>>>> overdue. On my machines this converts the guaranteed 2.3s stall
> > >>>>>>>> into
> > >>>>>>> I'm a little worried we're just papering over something here that
> > >>>>>>> needs
> > >>>>>>> to be addressed in GuC, particularly around GT going to sleep or
> > >>>>>>> something around the time we're expecting a response, so the pings
> > >>>>>>> on
> > >>>>>>> registers might be prematurely waking things up which is something
> > >>>>>>> we'd
> > >>>>>>> want to happen in GuC, not the KMD.
> > >>>>>>>
> > >>>>>> In general, I agree with this. We should avoid papering over the
> > >>>>>> issue
> > >>>>>> and instead fix it properly in the GuC. That said, this workaround
> > >>>>>> provides a pretty strong data point, since it appears to get the TLB
> > >>>>>> invalidation unstuck.
> > >>>>> So if we hit this issue I guess we're already going to have some
> > >>>>> performance degredation and the workaround makes that better. I need to
> > >>>>> look at the implementation, but we could be potentially introducing
> > >>>>> performance penalties in other areas doing these pings.
> > >>>>>
> > >>>>> Again, I'd like to see if we can fix this in the right place before
> > >>>>> implementing a workaround for it. Hopefully Daniele or Julia can give
> > >>>>> some direction there.
> > >>>> Are we seeing this on i915 at all? Given that Xe does not officially
> > >>>> support MTL/ARL and is missing several critical WAs for those platforms,
> > >>>> the approach so far has been to only update the GuC FW if it is required
> > >>>> for i915.
> > >>>> Looking at the GuC release notes, there have been a couple of
> > >>>> TLB-related fixes after 70.53, but they're both marked as only affecting
> > >>>> PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or at
> > >>>> least they're not listed in the release notes).
> > >>>>
> > >>>> Daniele
> > >>>>
> > >>>>> Thanks,
> > >>>>> Stuart
> > >>>>>
> > >>>>>> Matt
> > >>>>>>
> > >>>>>>> Thanks,
> > >>>>>>> Stuart
> > >>>>>>>
> > >>>>>>>> a
> > >>>>>>>> sub-500ms hiccup for the majority of occurrences; a minority of
> > >>>>>>>> severe
> > >>>>>>>> episodes ignore 8-9 consecutive doorbells, which points at the
> > >>>>>>>> GuC
> > >>>>>>>> firmware being internally blocked for the whole window. Full data
> > >>>>>>>> on
> > >>>>>>>> the issue. I am happy to rework the approach (different delay,
> > >>>>>>>> tying it to the G2H handler, dropping the status read, etc.) -
> > >>>>>>>> mainly
> > >>>>>>>> I would like the firmware side investigated, since no host-side
> > >>>>>>>> poke
> > >>>>>>>> can fix the severe cases.
> > >>>>>>>>
> > >>>>>>>> Based on drm-tip. Tested for several days on both ARL machines
> > >>>>>>>> under
> > >>>>>>>> desktop and VM-heavy workloads.
> > >>>>>>>>
> > >>>>>>>> Thanks,
> > >>>>>>>> Tales
> > >>>>>>>>
> > >>>>>>>> Tales A. Mendonça (3):
> > >>>>>>>>      drm/xe: Capture devcoredump on TLB invalidation timeout
> > >>>>>>>>      drm/xe: Log when a timed out TLB invalidation ack finally
> > >>>>>>>> arrives
> > >>>>>>>>      drm/xe: Kick GuC while TLB invalidation acks are overdue
> > >>>>>>>>
> > >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> > >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> > >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
> > >>>>>>>> +++++++++++++++++++++++-
> > >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> > >>>>>>>>     4 files changed, 243 insertions(+), 4 deletions(-)
> > >>>>>>>>
> > >
> >
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
