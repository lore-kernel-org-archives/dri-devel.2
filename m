Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F788606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wvr0tAyw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZW49bAlR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E4110F50A;
	Tue, 24 Nov 2026 11:54:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE8E10F504;
 Tue, 24 Nov 2026 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795521259; x=1827057259;
 h=content-transfer-encoding:date:message-id:from:to:cc:
 subject:references:in-reply-to:mime-version;
 bh=0UUIHAWCe5NscDJkhKnZmoLF7S7VtPaW7LCNzgHIMA8=;
 b=Wvr0tAywXWbrJDJdrFUY555x1Ajaq3ERpShC6iMUPSHpQh8rsD0YSL0Z
 LrpEC8wn0HHHMRvcn9ryy8HTJNj0EkxUmA6/jKrl5bLqIFC/hBaiwIqVB
 qqYZWSZT6JJy7nIS1iERLJ0VpQSHy1ryoDKu8ldJSd58Nt4Z8yseO7YIN
 tygYNqx9oZ+6F3ew7zQv/4Hpv9UzNmIm17CnIL8FPi5k10wXlXJ6T1rJZ
 S6Dkils692aYq1DhSKn6RW1bGuHonHQ6Bgg9NT1E1pWbJVhondgvUzOpY
 eficXPovLypOqE3hM1VClmb2ikgsHaBW+fvXCliy2ADDynlK4uT+K6xoB w==;
X-CSE-ConnectionGUID: X59JV14+SaisoPrTDEgJ3A==
X-CSE-MsgGUID: TA9PVQWPTbaxw9lHay91PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4251323"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4251323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:18 -0800
X-CSE-ConnectionGUID: nBvn83tTSf+x0XofFIZgwQ==
X-CSE-MsgGUID: AW84/kTsQ5ieaIwnBLd9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11863381"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:17 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:54:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu5AXl31NHCaB75hrWlhFKu1lL0/a6CMPRACij1c/DICYZ4PdlBReelevJIGzFyHaVBi45jSXp3Vl8KON1fljDzZDx+HSRzmUB45W10q4jo/MTsVyNxEABt8tPasJv9BRXRErFV9EbBtdFSdXIkzmG7AFLDDLVAx4VMAca+PGMu0bHGuncP9SwE/UGc6mk7XBB+O+dhzA0KqmVCb/JFMGDsmBx7KSsp3I97Blo7Ke0Ce/oOrYVgKPWjGnl4owc/zEM2fRzbyxPW/3RXbtcA7ZywBHehPApaSHobsJxagWu9nshsteh40qOPgJLXrfEiRQLjwT0Jrdld16P6fc9m/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UUIHAWCe5NscDJkhKnZmoLF7S7VtPaW7LCNzgHIMA8=;
 b=S9zFHWJZAADFwPfwC70xcjd95usjDzY5a4R7pmmgPn2vNkU6iVj/tqDteohmRMUBmAkcKfZKiafhXZ3WNDjoraZkcpfW4FX9o37Kjs9AM9g23dNox+X/EWZoxYBII49AIwr+e3yDyt63cj7EZEkQj5bId1swTjx4ov7VqEGuTMAQtteilb5QaK4hdjgRndN/8tC5wtZJ4RwuAOZX2U8d0PpRdMSPNJZj3zxOoISKMq6WjnCb0M15CdIea4ghDmwUeJzf1HBEhS4qayzaNPVaiZ7wXNLFPNcWmu3/VA00nezxmgQEOY3UjFQVvsXhYPO2HwSN+6UP5qyK+FsMZl/VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UUIHAWCe5NscDJkhKnZmoLF7S7VtPaW7LCNzgHIMA8=;
 b=ZW49bAlRV/SIO48KKICHUw0K3Y4x4gxYto5RsT4nGy/yWUdFqhjYBvO7Llhi+CyqMaBARGs0wLkYbbLm0rey9z9/3siYyoEoIH9c28LMxXc9qWTy3gx1iOodhnpTpXYqQf2+0jcdOGZU/X9fepKirtOubW0+ge124tm3BK2is/k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Tue, 24 Nov 2026 11:54:05 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:54:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:54:07 +0100
Message-Id: <DN3F5TYUV3XS.33TOBWJ7BWFIH@intel.com>
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v8 4/6] drm/i915/gem: Pull out size validation into a
 separate function
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-5-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-5-krzysztof.karas@intel.com>
X-ClientProxiedBy: AM6PR02CA0054.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::32) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fd1f81-9074-4309-dc7d-08df4a21a3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|261022075727099003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l14Ddc4InRCf4U48D8vXwgeswduS0377RLNeee0vPD4IfIfVtqNjMrhkRgWhnHJafZyXUyjW5eibB7NuH9MYEU9/UAdCZq2w05YsJKhY6kW2+HD8uf012kvxHDFkGG73Q5mF+GW5rpggZr858bUtSA461Pj6PrU6aEoJlBxxUfYdgPQKhRno7n6etp20h+bBsyYXtbMIeUySISnKvIXfXFPXYSFqcKd27m9Wa28jSMnOFgB6qQ4FDaDCgCzdjst8wXhWb3z10zfDaQKoeNqBdwlSI6f8V8kM2ItiJBBMuWoAtEXx2VVcOPYGU3/Gtk4vxXm/YrO/uaJ3LdYA6VN8lAfudPMz96yqu2SC11/yyr0gqISL9Np+j/XWWEbtBAm/4mE6Mik7qcJyCljG2ShXJpqEPmULk1r4jER2n5MG96MI637juObxdPSiqXtaYgHgwT2fohQex6LD4vRxeinM8OYLL86AlNANE03onoxU+XHaIweA87kJnG49RLDX+blVCoXheX+PjBo7yXeEKHFOenKQPWf0HvsUai7KLW9f2CC32DtOabk/7F6U7rRA45b7VuUt9wdwz9Mz4C9R7hvnF6D72+9jjVLytMUs7yhztL53awIRI/bPNA9JislBHTPMIto1tQoTpXszyWzicJoYhaC2+1Wsbf94XSgwFiPHuSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(261022075727099003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVF0V29rYlFwdE02OEN4K3NnNzNCejE0WUY0VFZvaElRM3A0bnlDNmF4bGVh?=
 =?utf-8?B?ZXZWbU8rVEVOT1c0MWd1Z2oxRFA2ZzVlMXdLdXlwdlp5THQvMVE5YlpSNm9h?=
 =?utf-8?B?T3o1WnIrZllNZkN1YnBGdlRBVVEyZ0YraUR0YlZTMEVvaGphcDdRdFJvdFFE?=
 =?utf-8?B?L3ZlMGVnbnRRSHBzL1BEUlJxM2dwMGJMTEIxUzRPNUI0dGJQTXBCSVJVUUlM?=
 =?utf-8?B?SStNR3QzQVp6Mk1KUTRUcFptT2I3V3N1WjBIR3lRamZ3Rm1zRk02OUVUNGJi?=
 =?utf-8?B?bm9tRTNEbkJtL29yY3ZzbVhPVDRUZEtmaE1OcHRhZStEWVJCNE5PQmVaOW8r?=
 =?utf-8?B?cEp2SlplNEJVdnJPeVllbTBIYmlPU2MwQjJBOFIrOFJVTVF6RnhOQWNMY29t?=
 =?utf-8?B?dHBRdTlHdWpOWDA1UUgxVVJIVGtUNWFHZEw0NThudER3aUozRkVrcG10a0tn?=
 =?utf-8?B?VjB5Qk1PQ05rTlRWc1MvQ0xhRDlvalpBTFRFTmF4OE9ZcWxiYURrUzdRRDBq?=
 =?utf-8?B?YzNTUWpsTUZDVmNxRXRoQ2FSdVkrNkk4L0h2T2JhSHUxT0JhQzVTSnZjWlUy?=
 =?utf-8?B?bW9zVWlzdTg4WHlubktUenBCKzVZM1ZjOHRidEI4QXdmKzNJMTZlM2tRNm1m?=
 =?utf-8?B?V2tHRnZUYVQybWxMQ1hraTBUSTZPOWxXWkFvNXVxRmY5cExzZEtnRmhEQ3hr?=
 =?utf-8?B?VFhKVkRkYWlJTVJsRElNMXhTRC9YRUVhTEhJaUxuUjhnNTlMRnZIM0dNTXlX?=
 =?utf-8?B?V2lrQUVpZUg5a0wzSklDakV6NlRUenIwb0F5a2h6ajY2aE9SZjVJL05JNS9E?=
 =?utf-8?B?ZXlnakV4c29mQkZZdFNtZ0d3Z2I4UEhoZ21hM2lJYWxUTWRVWFJCdXhoQURu?=
 =?utf-8?B?dUFaR3lwSVFsZkdCenhJenY0dzNYRTRzV0dmUnZNQU9kK0VjaWdVMTBOckxz?=
 =?utf-8?B?aTREMDBSUVd5ZmxEcDFjV2poSExhNndtVUhEQnZyOWhORlZib1gwZGpzZnE5?=
 =?utf-8?B?TE5iVUU0ZTlsWitVY0dQeVVQbTQ4b09nRTc1OGZ2YVZtWHZDN29JUlliR2Vn?=
 =?utf-8?B?bXFrWE0yUllVbngwekVSMS9LVFRBSTBmNERGV0JoQlBQS0phazc5RHdNK0Q4?=
 =?utf-8?B?SE5pekNlbFlUSlFWQzRDQ3lqb05JbkN2cjkrMFRQV2habmtpTFVKK1dhVW5O?=
 =?utf-8?B?R2dJWm5QVHdKbnJpZGY0OUZKZnRia21BYkJmYzhDRlhabXVWaDVTNEtrTUVX?=
 =?utf-8?B?Skx1MUw0YjdjVWpYOEJ5bm1ldXQ4N20wK2kxd2NaOS94QzZJWXBKVzkyWUM4?=
 =?utf-8?B?YnRIdnRwOGVaS3BZcEJJL3ZOMVVVanJyWGp1dVdjNFJLeGp5cVozclgrYVZy?=
 =?utf-8?B?RGxMY1h1OFVCZnV2VkV3bTZyWWwrR2tSVURZUDJ3NHUreDFoL1VCTDcyS250?=
 =?utf-8?B?ZGpqNmJ0T0pZSkRhcUsvbXZuZ0U1Wk5tdlRkcGl1QU0zcm5IblphM1hJNGFE?=
 =?utf-8?B?YWF4UTRtc1Vlb3ZIL1NPek85TFdkaVN2K2k3QXJlclNGU0Y1Yzd1TFMxT0FT?=
 =?utf-8?B?OVRMRjlCWGhiTzVmN3BtSURSL0VZUzdualBGd3JVTTBYdUpZTTB4SHJLSXQ2?=
 =?utf-8?B?Yk16WU4xcEhXVXRHSEF6THVaSDdtdUJidG5Gam5BSk4ybFBCN1hWT05NUkk3?=
 =?utf-8?B?YVVxVXd3YW9IVUFyM1NDbnRMRmVrZ0diQ3VoMWVOa3pwRHBJTER3MmVMOSth?=
 =?utf-8?B?NWVkVU85TUd3amFmaWxPTFpEbzBRV21lOTZvRFVmcCtBQmdxUVNWNEVocVN0?=
 =?utf-8?B?emgvUXUydksvTUQxUFJHVUhRK2tlS1hudmM3blQ0ZzhwQzczRW92elJTSmNn?=
 =?utf-8?B?L042Qjl1OFd0Um1YTCs3V0NOSnBsWnE5OWRwNlgrRVNkSnRCekwwd1VqTmxW?=
 =?utf-8?B?RlpENU1NM2FydGVnWHIrYzVuUkpMUVpPSkxseUgxVlN2Y0FuQ0dPR0J6eCtF?=
 =?utf-8?B?dGVlSDNYZlVMczRCOFVPNlFON2hXWE9hK3F1RklTMEN0SzE2Ulk3WDdLTXBD?=
 =?utf-8?B?TGRUZ2pra1RmSmVWeFNUTUV0S0lxUlJWajJneXBscC9rNm5kU1V4bWxYYjcv?=
 =?utf-8?B?L1RKMXBiN3V1c1pyVXM5R2pCWmtWTWdZbVRWakMvTGowZE80dU5lZ1lJYkxZ?=
 =?utf-8?B?Qkc0UXJWQ01DM2x6YWNYeThQNmVXQlJJT25FR2t5eGdsVmZJTVVVZ3ZXOVd6?=
 =?utf-8?B?MWUrdXdOblkxSWFTc0FSWVhkcnhIQ2ZURXpLUWtJYmlPZytGN25VVkdqdnZn?=
 =?utf-8?B?cHBiMzlNSzlMM0NXVU1kQ2lyQkFvdzBaY0xtVHU5amhPZWJHQm5DVXJ2eTVE?=
 =?utf-8?Q?3bARvNHQPWpXT+TA=3D?=
X-Exchange-RoutingPolicyChecked: CNKj5BSrvSkaUetU2aBxdid00FAg0W1i4P5y0g2RdlQ8SHZqxUlpXaGeM8OLLAiWCk8FH/ROLVU0OpOXK7/R06BUQSD7+7HTDKmxOPyjb7RKRvBV0K9NelqSYEthme6gl/KZf/hJPzwYP0yC6n8rQkQJJDbI/amHm63UbCUxFO/oI8A9kZNQ//duAX452tKW9yvrw4mEZ1qYnW42LdVy847uVERW2es4OteqhNRlj/Y5D+PEXdvLwhvdYN4O7Rk4iPn0X31VEzZGMjRyEfPTJ/qvT/807ybtEszbrODQEnYgYs0wZqR/Wey4bKW7qP+yufu1kKsnez2zqcExZLa+hQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd1f81-9074-4309-dc7d-08df4a21a3e8
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:54:05.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp01zPZl0hAg5TPv22c/0p8QgaKk/YQqsxNuaqFElk1HZdroxKYW4jej7dX5x9UDXBX0H6P2F+CQoYvuRdsqqDxtXX636eXZXBTk8m4AUwo=
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> shmem_sg_alloc_table is a very large and hard to read function,
> so reduce the number of operations it is responsible for by
> placing "size" validation and page_count assignment in a new
> helper.
>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
--=20
Best regards,
Sebastian

