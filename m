Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EF606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a6ny0NO3;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=S2xxitp7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AB810F515;
	Tue, 24 Nov 2026 11:55:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A03510F50E;
 Tue, 24 Nov 2026 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795521300; x=1827057300;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=8kMyr+I+5ZIpE4WxQKN8jZoFzTH+yxjZNtPKl0BMpRI=;
 b=a6ny0NO3YRd6Zo7W3VJNTxdGX3YV48cRjyAaC1SYtSg/Fn2SURi6YGTL
 n9eXhucn2X3KqurKXYhAF73jVu6GE+AUmeELdFkeNYs5+56qQdSOnFzbc
 seZBOMnZ9JxKXBZf5FGiEBrGZ0yEkKwfuSpRw7fgL+62fGxhsoLyKxN5+
 uudJ1uv1TzKl1DEANFkQFnqUtmq0btAEYVmBvZFQA2kX9U+KO/VQUjjSE
 6QS9uCM2cuKQZcyKb9DC7EqP/LS4hlUmYbw2gDkffo32CHsTlJJydCeZP
 CPHkToGvo95A3q0dGEBW8FkmZsn/TPfdnWhRVSHkhPGDHzapXrAVQTPEh w==;
X-CSE-ConnectionGUID: ZlTOp3MDQOKJ3Oe55mH9Jg==
X-CSE-MsgGUID: pX8wOJQkS5e89abiKCnioQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4373091"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4373091"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:39 -0800
X-CSE-ConnectionGUID: Rifi5jVpRmqYaBjC3N1jvw==
X-CSE-MsgGUID: s1fjN8kFRzast35ZYktnfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11426696"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:38 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:54:38 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOpAqSC51DX1812kj1aTEY0MACLEW9bOYfOr4CTFcyqTgHJ7dIDlBXyBPKX7wqlUPosYyIZfTwDCuDgU8njIDv2dNpTAMxQH+0ZEn/KqjFi37b7USVTQNCtpuFVP2gBttLwPiuBd4yTpE7g7p8vuLJGxXMUmDqAMIr4XCWC1Xggrm+3Djg8PbYBNWZQQxp7eNIsTD3RFOctlz6N4k0eUOAcz+gsf3mnjgMNGJV9gLvvC+uumHzWFBOhlEv19/g/GTxU0Q4NjdAPMM+LMPmlYbSDasg6nnlogbMsdyeotdd3ILEa20NCVYAwKeQKaMKKdL5fOyW48J4Gj5KHhXKAsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kMyr+I+5ZIpE4WxQKN8jZoFzTH+yxjZNtPKl0BMpRI=;
 b=TnG+t/vmP+OTeWIr7mvg+rXEwIvWSF7YomiCnyg3MQDnBTyH/H2NSNyWOae6SOJZqECoOtPeZg7kxkLluhyuY62FCwkTCND8676nGXhJtz8ORehU15OfbCH6gb7DOAuMbqi8rn43b9HMYFFd1R1ifNno89gh+3U7J9L0rKLRyJ20dOattRPuUxYT+nAW4OG1hePM5C1cck8pfbgZ/c5uBCdQleLYW8nOdSvT3HHq171tn+x7Xn0bBzuw5RzdSaiiSVybg86Wqv18BCQ++PqE2F00nrEngcGRJcyQGqHB7D3soMi6P4Jn7AIr2vF4ojrMK1Yff2fJHveimnJF1X4+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kMyr+I+5ZIpE4WxQKN8jZoFzTH+yxjZNtPKl0BMpRI=;
 b=S2xxitp7ye4s5NrGBK3MRcvkP6TMkeFsgqXHf8+wu9LGj2yV2e1nrOweKMeEbuJvDGDiDJBj0w0TViKhjov3PvKIfYDt9NnOcuQz2lAn0b2IsnnNrSg++zqWymfx+92WcYoCkyPucvSoBcRe7DpsXaOAKTIwur0VfH6Qf32drSA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Tue, 24 Nov 2026 11:54:29 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:54:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:54:28 +0100
Message-Id: <DN3F63I6KSF5.OA3EQJO6YL1D@intel.com>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v8 5/6] drm/i915/gem: Read and shrink memory in a
 separate function
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-6-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-6-krzysztof.karas@intel.com>
X-ClientProxiedBy: AS9PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::9) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: b10fa38e-e2be-4d5a-1af8-08df4a21b26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|261022075727099003|10067099003|4143699003|56012099006|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: lS74IFE8ldINu6JjWBDIogYiVFkDtpb/qrXpsCwHiwTLMq/1Wm+IaDf7hwNy6vNCBdzal2cheZB75cz3+5AAFloN1X4DWDZxT9UubwHS6gc6oyTAtFrqQrhEYIa7Q630ZqygCvzZA7TQDKW1Vr78t8NqC+7JNIuTJ4jK2ir9WNZ/r6KwAe3RZoJWagQxBCevADcTPuY+fbi3CCDqKNgsjmQBJlE85H+JRB078lk7r68yRR4vOLpQ39GQv8CsO9dwu82LGaRmcZStrGzW2qk1KfSrrhveRY+oLahVyQ1+IQ1G2L5ZPzGiTpJHbyI9luFiA8MuUJdff7kmn7a2xTvj4Rm/+NOMXc7YwOhYtJlXzW600qwpHjCsc6mrTGbqqAOOT2F4jSonuCrv+XW002NGgh1wOBgq/WkbAd+FeIpcmnawZuhu5Ui6IUUrewUG6i7s/sF/8P3lsh5JX2OYu/ZbWFt+q4uNJmkzJCAteK2Oftagn0+C6HueXfMogbU5FZ6cNPo2XUMGGj0q5YTq2ibLh2slKvFSbEAgvqbT7IzXEBEB0h3I6pxJA8UbTkt/lX0tpWs3Yfx+ZzgNGBKjXkbEr0bXA8J3LSNpLS0rmXhZ7IvTWcJTJBRQlD0NwnImXulmEBvZmOnKKBjnB+9f+E6oSwTDBPz26q8CuR87iPAit5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(261022075727099003)(10067099003)(4143699003)(56012099006)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0p4Y3o3a2gzUW10ZkQ4NnU0N1c3ZFZXOHpuM3U5RlJFdWdTWFlHV2JLQ05P?=
 =?utf-8?B?UlliZUxERzBienpNMWozdk03SEwwZGh1SmU2U0hSY1YwTmFKRE8waFM4Nnpy?=
 =?utf-8?B?WDBMWUdtS0dRekNQM3UrZjlyS3ZnUzZ1Y1ROY041Y3h0OEtXazd6RWdvSng5?=
 =?utf-8?B?aDRZUVNFb2o1SDY5UEVCeEpkRDF5RDhPOUVCUkp0UEdLYWwzYUswSVZnaWQx?=
 =?utf-8?B?TmpwMHRmKy9pckdrN0N1ZVJiakMyQUpjQXlhblJJMlYxUW9LRUFTTHMxOTFW?=
 =?utf-8?B?akxJWG81eHpicUV4WGx4NGUwOCtzcjRCcUp6QXVRcWFaMTRXVzBMTFB0dXpz?=
 =?utf-8?B?WlpyTjVoTFpUYmZzYkRIZ1Y1bWdHSkRhY0orOTU5dnZWbWRJdUxxZ0R6Ym1r?=
 =?utf-8?B?dWhlQ3I3M3NSeFhlbU5VV3BKR29LcGliTjcwV3NMNUxNS1ZIa1htVndXNmox?=
 =?utf-8?B?bklRVG85dXBLdVJyY2hlUGhIN05iZEVoQ1dOaDVUV2Y3MkVKYlMzUGFyYW05?=
 =?utf-8?B?aks4b3JHTDFZRHJGK1c4UW8zR3J3empQejlZanZxelRBQ3RNVHFPdDlhSGw5?=
 =?utf-8?B?b0lhdFFycUo5VXRHNnAwQUlwem1zSWhxY1hyZmlyRXFYWk1sNkR4TkJsR2xt?=
 =?utf-8?B?YldDMHA1NVdFa2FIRGplMjdtWGxWL2hpb2g4VzRSVDJ2UXMyclR0cFBrN1hJ?=
 =?utf-8?B?aEk0V2lLMVM5RUxhRzFKTVl3N1FRaStpWG9JcTg4ak5CQ1l4UmZhRmNQL3N1?=
 =?utf-8?B?OC9Rd0xzMWlHSUc5WVRVWXVVajYxQTZQTUdjVUNRWVg5Z0NpZXhwUnYzUWNk?=
 =?utf-8?B?YVBxSzFYTE5JNkJjbWJiNWd1SVMvNkJSZVZoVmhoZEVEb2JCWUZrY2x5bUxo?=
 =?utf-8?B?STJNclg5WnA0YkhQUWlNK1lZVmhzRHZtZEczOUoyNjdoTW1JdisxZElGb2Vv?=
 =?utf-8?B?Y2JRQUY3Z1VLL200OEp2a3ZIb2dLQ0c1SFgyelA3Qk9jc0lrVDBLamtWbWpG?=
 =?utf-8?B?cFkwbDFHZHhsQTBReHZkbTdhU0RZak5XdENneTNKWWhka20wTEsxelNVZ29T?=
 =?utf-8?B?Yk5hL2JScktvNWpCaUUvZi9KZUVEc2kwSUNQSTRyKzlMU2U3WDRFOTMvZ2pt?=
 =?utf-8?B?SkFIbU5kdzFid204bmpnUGxCbjZhRVBSTmgzc3lNUm82YUo3WjY4TXJ1SjlI?=
 =?utf-8?B?NEs0UVY4bGdqamdzQkRDeHZ4WVVOY1luQklxRXlGUk9rc0ptNWFWaXFjQXVT?=
 =?utf-8?B?ZmU2Z1piR1RpWFc3RkxJWFNMWFFJay9vTWljbjlscDZmWEloMEozUzhMcThV?=
 =?utf-8?B?UGlsSUN5aGE2RmRHcnhaMURXOGFXamdaaVhuaStFZ0JNaTBXVXJ2NkN4bE9F?=
 =?utf-8?B?bzYyNW0wSWgwdTdzeFNSLzYwSENWbFE3SmdQVTYxZXR3a3VnWC9DYzhRR0l3?=
 =?utf-8?B?dG1ZNUFtN0FIb1VKTEJGaDBZNVJrQlNnUjdBN2FjUy8vWU9ETjVhM01qMU5G?=
 =?utf-8?B?TmFZemVvdmVGcmxCTnJNSkZscFBXbUdIN2RwYkZjNWFpQ09rSFA2ZWhma1RD?=
 =?utf-8?B?N0w3TVRMKytnWDNWQm04TktQT1lxTUw2aFB4Y3JLZndqZ1dLR3JhYkpOb2hr?=
 =?utf-8?B?L0pMZi9aRXZ4RTNrZ1JMY1Vlc241MkNJSjdSeGdLTWRpQk10M1VSTVYzMEx0?=
 =?utf-8?B?cXRjaHAzL2o3a0VvVy9rd0lLb1Fxa256WHhKMzRCUTgwaHBOMmVKZkpVN2Q1?=
 =?utf-8?B?WkxYL2JGMFRObHNSVElYNTBtZEpCcGdqZDJmNklUM1MwSXdIeWZ0dFM5T05D?=
 =?utf-8?B?K0lqN28va21EU3FxSG9adEpDUXJKa2s3ZVp3Slhsa1diMWw4a2ZBR1AwRlVC?=
 =?utf-8?B?VXU4Q3NaVjRVU1c2MCtNNnRWSlNRcCtjUHJGVnNxbnJpWXVPaVFOblJyU254?=
 =?utf-8?B?VmhWdW9lOW9TeXZ5ZkM4czdEbFhsMkIzbW5vc05uOTNwVlh6RUk5Y09KYkl3?=
 =?utf-8?B?TkhzRk83SjE0QUloNjJjUGdKVmNMcDRqTkE0bXYrRFlTS3hpNmMwODRBU1hi?=
 =?utf-8?B?ZStrdWtaUnlneWZzUktZd3BBbFJZem5ZcCsxVkJES2pxcUIwTkJwRnE2a3JU?=
 =?utf-8?B?SUhVdE9xU3FNRWJYVUdLeUZpejFHQWp5WW05UDRvcC9YVHpPdDV4RlhLa1l3?=
 =?utf-8?B?VDk1aWQ1TlhQaDlmRHFpVWFuTW1DUEFuMEM4T1RnY0cvL0cwL1FpWU13c0o2?=
 =?utf-8?B?ZGM0aithdkVoUlNaVlFDYk5PQXllckRvNHFUUkdETkd4ZlI1T080bVZzeFpv?=
 =?utf-8?B?dVlJOTBHbG15Z3JpbEI4cTZtNWpDS2F1a3VwUmJMcFBEZTlFbEVqNzlibThX?=
 =?utf-8?Q?37KtMEE4PEkuJbH0=3D?=
X-Exchange-RoutingPolicyChecked: PnWZS381TlCDWoXuGWd/pmK7XbKB6QTqfsnWhsQYHMhuStlX2qtg7eJop2d1sD9TT/8xpmmp2jI1/ZajdK7/d2X9+oNDkVB4gHrZYwsIQAZpKwKgRCe0qG+SLlHE7/VS6fJEAiyAwJlVYSqeN08LlcnD+RFox2RxIJP5W702rcUk/msza/fPTjJxTBogWftru5AMelpc5RH4wUwaC9jSelsLOwBQ7Y3rGcFuymY4VywO1SAa9BoguT6jMWvpzsz4eKJ3eok7AWGIy2ZBb/hq4A9M9icikKETwhqH8ODvt7DaZdYeG/uKALBHf2Tcy6KT3r/nh9cEPPVkdhl2H68XDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b10fa38e-e2be-4d5a-1af8-08df4a21b26c
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:54:29.8472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfTwYKsFb+ECMTHNC8k5kNCmgDzuzSFGs4TQFnCFof4YjQoC3cGsvhMHr3qquBwbvC7sNez3UjFrGL2B8QxGlxOAQl2kUrXemN2AZjzQG3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> Continue unloading shmem_sg_alloc_table by placing reading
> folios and shrink call into a new helper.
> Make the loop a bit more reader-friendly by removing iteration
> over a structure and replacing it with inlined instructions.
>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
--=20
Best regards,
Sebastian

