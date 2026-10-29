Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560F606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E1jLcERe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC9510FF41;
	Thu, 29 Oct 2026 03:50:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D1610FF40;
 Thu, 29 Oct 2026 03:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793245845; x=1824781845;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MYgg+RYYD6JWJt8yQ3hZgOrWNGJoDtabmkZlDnZaIcg=;
 b=E1jLcERe0wSLSj0sOMKkvdfHFhCCxInbe4lzMH5uzgOj3uOJILNr215m
 DkPXchS+9Ht53EwP9lGPHdTAVo3dPeFHicD4qXbVQc72BUrq5Us+s+vNP
 HOhYT3qSn1iw+XOHE7wrwZAMKhfWYv3asovSN1tvuhgCQOw5SWDZFG75n
 6ABXOPl/C1aRqWCP0Thw6GTgYc4XyfA+WHOAEwpfhtgz2Uz6lGbldmhyZ
 aJb2TqbqT8ZjIGpNqf2baW4GjELCkLAg4p4lBuBJPKraXITAdxseviMp9
 X6LUziJ/9zdIFpvdmwUE5T6N9mfhC8cx63mzMwpz6A0KRr/WeHO8c2NU5 A==;
X-CSE-ConnectionGUID: IIZag6ijRHOCSPm2dHX1WQ==
X-CSE-MsgGUID: guaohSs1Q+KPilwFExNaTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1863480"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1863480"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 20:50:44 -0700
X-CSE-ConnectionGUID: mnZdp6rARi+2IIPn645dEQ==
X-CSE-MsgGUID: 7GxIs5t6RtGyYKo/calGdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5545138"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 20:50:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 20:50:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 20:50:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 20:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxoSnupw2qgc/OF5LG86D90A8VksGUDD3T2V8OVW4GadaqP44nKOLcOSzHxRdgZj6bgVqmJ05blQVzOYncJOCg7GaM8g/OjCDZR+8BNv8yXMBUEG/GmV6clm3JqiIl6VFZfon7rJ2Nq40pMK77q7DHHaXPw4pKjGWKOy7zx1eE8W4CZa50W0p2yEeJRDVgMJfwt1PZZ06jIijyMguK0jgcczDgl+LMbWl7Ty366duqBLw5A1I5fpYkP1VlQ2OqjfKYhLNfvQzpynK2CA2apetQn2mNtB2jgssw4v3NXrmIdi8bD9O8NJzDMt2hrauEEUBnpFoBPZadfRR9ySPEkPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZO654ATqJc358vJgsbEJeUa0HELzG8+lVLTlQHTVRg=;
 b=nKSfgv0Kiv0go+qdZQLLQlprMZeMRrlPY3dvZe9YEDoLmktkTH0QoH/pnD/4abiZAQbr0ZuwF7wP7a/gN6NJrU1pJDX3Vvb+jmeHydzhWAbt0K8/dPhSvhfRi5woF3yWWEPriDxjxGimrrwPEnpPWSDuv98O/L3FIR5x8gjyinofZqinPf7SizCGYoTGJ8ANRKbJ4hWxt/URRd/RkXT5QHIZhyQFeUW8IKMNM3G3oyglQV1QiIPMP/jQ6A0WpLfPNP9zZ40JXeQXP3WpdstSQ0TLIyjwbWN0SUMhHiefpQnEJpxkycI0S+K02mgOs//39mpiTaCUPx+9u1EwyA5HVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB5698.namprd11.prod.outlook.com (2603:10b6:208:33d::8)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 03:50:40 +0000
Received: from BL3PR11MB5698.namprd11.prod.outlook.com
 ([fe80::fd06:443b:bd51:8e09]) by BL3PR11MB5698.namprd11.prod.outlook.com
 ([fe80::fd06:443b:bd51:8e09%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:50:40 +0000
Message-ID: <6b8b81b5-0da8-4f02-acc0-5de6a89ec88f@intel.com>
Date: Thu, 29 Oct 2026 09:20:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/svm: Take write access only for GC attribute resets
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20261026122045.2709500-1-arvind.yadav@intel.com>
 <auENFUKFEcjZorM6@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <auENFUKFEcjZorM6@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::15) To BL3PR11MB5698.namprd11.prod.outlook.com
 (2603:10b6:208:33d::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB5698:EE_|DM4PR11MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aafd1d-8557-416c-7da8-08df356fccc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Zlq1bCiqlN8ie4VOBk/O/b97ItWlUz30wxhVxFYL+oK6XN0bh4goTcJYmJOcDlsQ5NjKnSy9wNtnRZtf6fhxtDXUG2d+H6sfbJtzx2jK4UGEYCLHpGMw6OXn4oaxt23pfJPgSlPfvpv4zRWAy8euJibPOAcJcKdxLUPpYpwiqgOz3eqRCNu5PN2XhoYJuBuaGHZHKVHVX40ixHZIlElxFopFDKV/wq0cViYutUZlzxNe+lAnku5t9oZGMAUqCBKU6RnHHFkZjvGbM2zzzpc2GguB1QlmyEbGXIqA+F5zA4yVWpz9bnqTFppKU3gvVV3UFp0f20HMBRfC2rB4ZxPP8VsNi2/BPCRf/xbAC5B7DtmTS9as/m463iRibKO7FuLI2w7x0fzro6cHjGLbihPGFxB49RGbMm+PUzafUgY/FXbKccIRUmflHWAVoHUC8SbxUmoWc7wLGaLN42TLbDEGK2Vmek71PkPMKWqYWOBFX/ukUZCybVqGFYhNZPyfmlixGXj/zuK+iVlqrMhgIXfoS2xccS3292B07aQKN9CXjTjQPv8DY23mj8ysfSsOZIKUmTInxZJkO/GTWz++Qb+EJkBBFFpmx1lO/po5dK/KfFswL9Xe6UDTcHZRTxhcbVl58Al7gAVTxvD39I60ZsCvMam0MN0RkYqc7hCT2ot8UpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB5698.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVNNmJzNlllVHcwWTVjbjdtMDFudXAyRkQzYUpuMjdpdmFXeHhBb3IvOG1Z?=
 =?utf-8?B?UGs5N0FVSElCSE5YWVlLek9PNkNFN2IzRzdiNGR6UGtVd1kwTTBySnkydTMw?=
 =?utf-8?B?NVFrTGpUZjBnSE5sRVg4MW4wY0lrT2Z1RnVFOTZ3V0dXeFFFOWdiNmt5UU8z?=
 =?utf-8?B?U3hGb0h1WXFIT2Z2VU0rZlFJcnFKclE1K2pHdy9ZdzZYZVNPMm1JbTVmbVVZ?=
 =?utf-8?B?aEkydXgzWGR4OXVodHI0QzZkeXp0a0RuZFl4YnQ5OUp5L3AvYmVVNW5LZTZo?=
 =?utf-8?B?SU5Jc0pNUUE1bWkxSUE5eHhxV1FzaE5RaEk4eldjYndEYXlJS0JFV3hVZkUv?=
 =?utf-8?B?SFRCUUNPMHQwdWQ2RVhpSy9ZMUwvOGlDWnVqdVpYM2VselVZV3pFWjRiN3RL?=
 =?utf-8?B?eUsrNE8vWHZlNmpsR3gzS0l3SWJHc3Z2K1crREgvbHFOT09MeG5jOHpXZmFi?=
 =?utf-8?B?dUtVTTZyVksxVlgrN05pai9ob2djKzA4YUVsL3VDOGxwbWhwb1JvUlNiWGZi?=
 =?utf-8?B?Nmg3UmJ2ZGViNlNTZEdsZCtiQUVxWU40YXZpMGprNFZOUVlKODI5bFNnYUd3?=
 =?utf-8?B?T3hJUHB2TXFWSm5mZGVmbXUxTWxBUWRMVHd6dzVNRDM1MTdiQ1ZOdzJlRU9k?=
 =?utf-8?B?cWhic0UrWXRDTFZDSmtNMVp2YVZBTDY3RWd2dDY2TzlCQkdBN0lULzFPQUNi?=
 =?utf-8?B?YVd1TUx1Njgrd2QzTk5pNTV6bm82Tm03Tmh6b0NTbElHRXRacGhQcTZGbzk4?=
 =?utf-8?B?QjN5RTZydmVtOUxXTHJlQmxpNW9VMC9mdUJxbURGVG1CeGs2dE5rUjhPRmxN?=
 =?utf-8?B?WHIwWmdscmIxS0N0bS9od1NmVzBUZTBuS3AvQjFpelQxbk45RDZzcjF4VUJL?=
 =?utf-8?B?c3AzVW1xWElYYVVSckgvWVhoaXJPQ3BKQjdMNGZCYStpNzRUcmtBK2NreDVr?=
 =?utf-8?B?c0pYN0EybHJ3RldGa1hjS1dXR01TSVE4OVoxUTRMbnZDNUtvbUQ2L3pwN1Qv?=
 =?utf-8?B?Z3FkcTVGUkt5WjdTZnZ5cTBKVm1UWjhEbTNFNEZPUmtLd3pXdHczNVZ1U215?=
 =?utf-8?B?KzhmSFhJendiMmYvd0VCZmV1QWdiS1ltVFpuNXE5OE5nOU9FMWFocDF6b0lG?=
 =?utf-8?B?aXB5WTBHazlPOElTOTBTelcxTDVSVEdTT1prVDRyZ1dvdXg1c3Q2VGVJRW9p?=
 =?utf-8?B?alFibStiOFV5OFQrKzZ6eFVTeHJhQm54NU11K2hGeVQ1UzArUXZ2Yk5UWGpT?=
 =?utf-8?B?ZWN1aGxkajJhd29UWU1HekhuQVhPYXB1RHp6Y1Zyek5EWEJVVk5hRGZHazdH?=
 =?utf-8?B?cURsc0NnWW1BRzcwdWc2TDJFN1J6M3ZSNXNSNXJYQkNxaVFIelpIRUxjUVpW?=
 =?utf-8?B?NXVXMld0eTYxZzJtOXBzam9ybWR0dlRiM0ZMUjIySE11aXhyd0pyNEU2U3N4?=
 =?utf-8?B?SHA1UUZLaEJETWZCbGMvT2RrZGdZNzd2bjI5UFI0bWJCZmY4eUt1d2JYVnVr?=
 =?utf-8?B?WmFpNWViNjdhcUt2VUFlSDFqQ2I2bkFuZHRZSWZGUFcyM1VlQWJPSW1EYU9V?=
 =?utf-8?B?UjhnUDUxZUlBUmpQM1RKTUpscW9zd0pYR3JGMDVTSmFKSHVVbEo1UkRtSVo4?=
 =?utf-8?B?emFxcGxpVHdPUFJoYUk0L2lOSXBkdHMrK0toRW9sVG1pd3A0TVB0ZU1CNnR5?=
 =?utf-8?B?TFRWQUdVMmlKZy9JRmU0dXBCWG5udGF3dExGK2dzbWdESlJoRVpCbWo2NzNU?=
 =?utf-8?B?RFJ6K2pSejNTS3BTVFVvR1pqeGZLUE9jejh2V3dmOC9hTzVDNXFoc1dGcDUy?=
 =?utf-8?B?QkQyc3JnaDZ2ckE4dk5abDlTMkorWjlpaXFzU1g4UjloVnFTN3hzTDdSRE1o?=
 =?utf-8?B?SnVuTmRWak1KU2RudmN1RVBmdWhRQzdxUUx3SUZXOFNhK2huYVh5TURteXJE?=
 =?utf-8?B?SWZBYWcvRGVUYVlteCtHcy9EMnNXRGRid1FDYnRBWGRzcHFtUi9QcUhjNGpU?=
 =?utf-8?B?QXZPemx5bTZoQk54eUJwWlR1TWNITzN0dG0xU2tITkI3MEJ0QnZndENkQVAx?=
 =?utf-8?B?dFo2UzRDVG1jdnc4QnZjTkR6cjdOWWpCb1o4MkxOeGxYVk5XL1hHUytYR1FM?=
 =?utf-8?B?RTZEc1VlcmhCNWNKSmxobWdnYk5vOFFsbFZhdm1iMzMvQzZXR091M1gyOXRS?=
 =?utf-8?B?UkloSVgrVytkS0QxWGxRZ2EvRWFYNVdCc0dWY3MyRE95VmFuelhIcE1FUy9Y?=
 =?utf-8?B?MDVmNXNtVWtqbzJqbjVhZ3dabndwR2tqZ3U1RVRzVWRUMmZIMFFtcy9zUm9N?=
 =?utf-8?B?clBremk0OFllWUI4YmRML0tERElHQ1FOWGNzckUyems0OTVtcjNnUT09?=
X-Exchange-RoutingPolicyChecked: 4NvEsEXdWKJ5jv0iZqa+nDzuC4atFsdB2OPf7fqMQlvKULks3e1krEX9v6dUxtrD8o2GhvRok/qEZMLvlA9G4tMdPa8Sd6t4ZGSD4gX6mGwg1vjCt4mrU5SuG+yS0r9sdJV7k9jLfua2TQRb1BXkF+yBO0z4bx/XrIKTO+80vS/Hn+3xDiRWq6bMepvggEYgTeRf1EqPjntM+5urrk++T27srQY9RwTrFg3MwrzloWgE0Hn/b+4cdAZ0mzOnJIw4V+YlkonWUpJTguNaRRs+kOtbAdB6emwN1fgCw+CxNCQDImedb8i/5nZ8zJOPKc347WSzpZNzD7MwCnthtFuMhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aafd1d-8557-416c-7da8-08df356fccc4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB5698.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:50:40.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0De+Vo5LbVcSma720A7QQwkn8zp9QF8eGm6A3ZXaFtfM1BJaekI1KQanfCIGy5ZLeQGZkNN5S1YANpQaiRtbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 28-10-2026 02:14, Matthew Brost wrote:
> On Mon, Oct 26, 2026 at 05:50:45PM +0530, Arvind Yadav wrote:
>> Fault service holds vm->lock for read while using a VMA. SVM garbage
>> collection also runs under the read lock and can reset AUTORESET
>> attributes. The reset can split or merge VMAs and immediately free a
>> VMA that another fault worker is still using. The GC mutex serializes
> I'll have to think about this one for a bit but quick thought:
>
> Can we use some ref counting (e.g., add a VMA ref count) rather than
> changing the locking?


A VMA ref count would keep it alive while the fault worker uses it. But 
the reset also changes "vma->attr" which the fault worker reads. The ref 
count would not protect those updates.

I will check if we can avoid changing the attributes in place and retry 
the fault when the VMA is replaced, keeping the current locking. If You 
have any other suggestion please let me know.

Thanks,
Arvind

> Matt
>
>> collectors but does not protect VMA readers.
>>
>> Keep backing collection under read access when no attribute change is
>> needed. Defer ranges requiring a reset and return -EAGAIN so the caller
>> can release its read-side state and collect with write access.
>>
>> In fault service, discard the old VMA pointer before releasing the read
>> lock. After acquiring write access, recheck VM state and collect the
>> queued ranges. Downgrade to read and repeat VMA lookup, permission checks
>> and advice-dependent setup.
>>
>> Drain GC under the existing write lock before madvise, bind and attribute
>> query. Require write access for VMA changes while retaining parallel
>> fault service when no reset is needed.
>>
>> [ 2163.042338] ==================================================================
>> [ 2163.042353] BUG: KASAN: slab-use-after-free in __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>> [ 2163.042815] Read of size 8 at addr ffff88813f879b70 by task kworker/u65:3/3115
>>
>> [ 2163.042834] CPU: 0 UID: 0 PID: 3115 Comm: kworker/u65:3 Kdump: loaded Tainted: G S      W  O        7.3.0-lgci-xe-svm-22oct #16 PREEMPT(full)
>> [ 2163.042841] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
>> [ 2163.042842] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1002 03/31/2023
>> [ 2163.042845] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
>> [ 2163.043326] Call Trace:
>> [ 2163.043327]  <TASK>
>> [ 2163.043330]  dump_stack_lvl+0x91/0xf0
>> [ 2163.043336]  print_report+0xd1/0x610
>> [ 2163.043340]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>> [ 2163.043825]  ? __virt_addr_valid+0x1b2/0x350
>> [ 2163.043831]  ? kasan_complete_mode_report_info+0x6a/0x210
>> [ 2163.043836]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>> [ 2163.044340]  kasan_report+0xa3/0xe0
>> [ 2163.044344]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>> [ 2163.044881]  __asan_load8+0x8b/0xe0
>> [ 2163.044885]  __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>> [ 2163.045456]  ? lock_acquire+0x1b0/0x320
>> [ 2163.045461]  ? xe_vm_find_overlapping_vma+0x88/0x310 [xe]
>> [ 2163.046072]  ? __pfx___xe_svm_handle_pagefault+0x10/0x10 [xe]
>> [ 2163.046679]  ? rcu_is_watching+0x21/0x60
>> [ 2163.046684]  ? __mutex_lock+0x1172/0x18b0
>> [ 2163.046690]  ? find_held_lock+0x31/0x90
>> [ 2163.046696]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
>> [ 2163.047273]  ? __kasan_check_write+0x14/0x30
>> [ 2163.047278]  ? __mutex_unlock_slowpath+0x10f/0x660
>> [ 2163.047285]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>> [ 2163.047295]  ? mutex_unlock+0x12/0x20
>> [ 2163.047299]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
>> [ 2163.047844]  xe_svm_handle_pagefault+0x5c/0x140 [xe]
>> [ 2163.048355]  xe_pagefault_queue_work+0x19ad/0x2450 [xe]
>> [ 2163.048843]  process_one_work+0x5ae/0xdd0
>> [ 2163.048847]  ? __lock_acquire+0x58a/0x2820
>> [ 2163.048850]  ? __schedule+0x22a6/0x3670
>> [ 2163.048858]  ? __pfx_process_one_work+0x10/0x10
>> [ 2163.048866]  ? __pfx_xe_pagefault_queue_work+0x10/0x10 [xe]
>> [ 2163.049345]  ? assign_work+0xe4/0x1d0
>> [ 2163.049350]  worker_thread+0x3b4/0x6a0
>> [ 2163.049357]  ? __pfx_worker_thread+0x10/0x10
>> [ 2163.049361]  kthread+0x204/0x250
>> [ 2163.049364]  ? kthread+0xf1/0x250
>> [ 2163.049369]  ? __pfx_kthread+0x10/0x10
>> [ 2163.049372]  ret_from_fork+0x465/0x6a0
>> [ 2163.049377]  ? __pfx_ret_from_fork+0x10/0x10
>> [ 2163.049381]  ? __switch_to+0x26f/0x740
>> [ 2163.049386]  ? __pfx_kthread+0x10/0x10
>> [ 2163.049390]  ret_from_fork_asm+0x1a/0x30
>> [ 2163.049399]  </TASK>
>>
>> [ 2163.049654] Allocated by task 522570:
>> [ 2163.049662]  kasan_save_stack+0x26/0x60
>> [ 2163.049668]  kasan_save_track+0x14/0x40
>> [ 2163.049672]  kasan_save_alloc_info+0x37/0x60
>> [ 2163.049677]  __kasan_kmalloc+0xc3/0xd0
>> [ 2163.049681]  __kmalloc_cache_noprof+0x2b4/0x6c0
>> [ 2163.049686]  xe_vma_create+0xe3/0xe60 [xe]
>> [ 2163.050170]  new_vma+0x416/0x540 [xe]
>> [ 2163.050654]  vm_bind_ioctl_ops_parse+0xc3e/0x1110 [xe]
>> [ 2163.051139]  xe_vm_alloc_vma+0x243/0xd60 [xe]
>> [ 2163.051623]  xe_vm_alloc_madvise_vma+0x92/0xd0 [xe]
>> [ 2163.052107]  xe_vm_madvise_ioctl+0x783/0x14f0 [xe]
>> [ 2163.052591]  drm_ioctl_kernel+0x143/0x200
>> [ 2163.052597]  drm_ioctl+0x419/0x790
>> [ 2163.052600]  xe_drm_ioctl+0x9e/0xf0 [xe]
>> [ 2163.053074]  __x64_sys_ioctl+0xd5/0x130
>> [ 2163.053079]  x64_sys_call+0x2b5/0x27e0
>> [ 2163.053084]  do_syscall_64+0xef/0x6c0
>> [ 2163.053088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> [ 2163.053098] Freed by task 17929:
>> [ 2163.053105]  kasan_save_stack+0x26/0x60
>> [ 2163.053110]  kasan_save_track+0x14/0x40
>> [ 2163.053114]  kasan_save_free_info+0x3b/0x60
>> [ 2163.053118]  __kasan_slab_free+0x6f/0xa0
>> [ 2163.053123]  kfree+0x2bb/0x600
>> [ 2163.053127]  xe_vma_free+0x5a/0x70 [xe]
>> [ 2163.053610]  xe_vma_destroy_late+0xae/0xf0 [xe]
>> [ 2163.054093]  xe_vma_destroy+0xda/0xf20 [xe]
>> [ 2163.054576]  xe_vm_alloc_vma+0x304/0xd60 [xe]
>> [ 2163.055059]  xe_vm_alloc_cpu_addr_mirror_vma+0x8f/0xd0 [xe]
>> [ 2163.055543]  xe_svm_garbage_collector+0x388/0x5d0 [xe]
>> [ 2163.056028]  xe_svm_garbage_collector_work_func+0x2a/0x40 [xe]
>> [ 2163.056512]  process_one_work+0x5ae/0xdd0
>> [ 2163.056517]  worker_thread+0x3b4/0x6a0
>> [ 2163.056521]  kthread+0x204/0x250
>> [ 2163.056525]  ret_from_fork+0x465/0x6a0
>> [ 2163.056530]  ret_from_fork_asm+0x1a/0x30
>>
>> Fixes: 941bcc1a4bbf ("drm/xe: Fine grained page fault locking")
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Assisted-by: LLM
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_pagefault.c  |  37 +++++-
>>   drivers/gpu/drm/xe/xe_svm.c        | 179 ++++++++++++++++++++++-------
>>   drivers/gpu/drm/xe/xe_svm.h        |   8 ++
>>   drivers/gpu/drm/xe/xe_vm.c         |  54 +++++----
>>   drivers/gpu/drm/xe/xe_vm_madvise.c |   5 +
>>   5 files changed, 212 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
>> index 5247321c805e..9e1377df9d01 100644
>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>> @@ -270,8 +270,9 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>   	struct xe_device *xe = gt_to_xe(gt);
>>   	struct xe_vm *vm;
>>   	struct xe_vma *vma = NULL;
>> +	enum xe_pagefault_error error;
>>   	int err;
>> -	bool atomic;
>> +	bool atomic, svm_relookup = false;
>>   	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>>   
>>   	/* Producer flagged this fault to be nacked */
>> @@ -297,10 +298,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>   		goto unlock_vm;
>>   	}
>>   
>> +lookup_vma:
>>   	vma = xe_vm_find_vma_by_addr(vm, xe_pagefault_addr(pf));
>>   	if (!vma) {
>>   		err = -EINVAL;
>> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
>> +		xe_pagefault_set_error(pf, svm_relookup ?
>> +				       XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND :
>> +				       XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
>>   		goto unlock_vm;
>>   	}
>>   
>> @@ -313,11 +317,36 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>   
>>   	atomic = xe_pagefault_access_is_atomic(pf->consumer.access_type);
>>   
>> -	if (xe_vma_is_cpu_addr_mirror(vma))
>> +	if (xe_vma_is_cpu_addr_mirror(vma)) {
>>   		err = xe_svm_handle_pagefault(vm, vma, pf, gt,
>>   					      xe_pagefault_addr(pf), atomic);
>> -	else
>> +		if (err == -EAGAIN) {
>> +			/* GC needs to change VMAs. Drop all read-side state. */
>> +			vma = NULL;
>> +			up_read(&vm->lock);
>> +			down_write(&vm->lock);
>> +
>> +			if (xe_vm_is_closed(vm)) {
>> +				err = -ENOENT;
>> +				error = XE_PAGEFAULT_ERROR_VM_CLOSED;
>> +			} else {
>> +				err = xe_svm_garbage_collect(vm);
>> +				error = XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR;
>> +			}
>> +
>> +			downgrade_write(&vm->lock);
>> +			if (err) {
>> +				xe_pagefault_set_error(pf, error);
>> +				goto unlock_vm;
>> +			}
>> +
>> +			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
>> +			svm_relookup = true;
>> +			goto lookup_vma;
>> +		}
>> +	} else {
>>   		err = xe_pagefault_handle_vma(gt, vma, pf, atomic);
>> +	}
>>   
>>   unlock_vm:
>>   	if (err)
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index bc6902b5bf57..d19cb0c4b154 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -356,12 +356,36 @@ static void xe_vma_set_default_attributes(struct xe_vma *vma)
>>   	xe_vma_mem_attr_copy(&vma->attr, &default_attr);
>>   }
>>   
>> +/* vm->lock keeps the VMA and its attributes stable during this check. */
>> +static bool xe_svm_range_needs_attr_reset(struct xe_vm *vm, u64 start)
>> +{
>> +	struct xe_vma *vma;
>> +	u64 end;
>> +
>> +	lockdep_assert_held(&vm->lock);
>> +
>> +	vma = xe_vm_find_vma_by_addr(vm, start);
>> +	if (!vma || !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
>> +		return false;
>> +
>> +	if (!xe_vma_has_default_mem_attrs(vma))
>> +		return true;
>> +
>> +	start = xe_vma_start(vma);
>> +	end = xe_vma_end(vma);
>> +	xe_vm_find_cpu_addr_mirror_vma_range(vm, &start, &end);
>> +
>> +	return start != xe_vma_start(vma) || end != xe_vma_end(vma);
>> +}
>> +
>>   static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>>   {
>>   	struct xe_vma *vma;
>>   	bool has_default_attr;
>>   	int err;
>>   
>> +	lockdep_assert_held_write(&vm->lock);
>> +
>>   	vma = xe_vm_find_vma_by_addr(vm, start);
>>   	if (!vma)
>>   		return -EINVAL;
>> @@ -397,70 +421,134 @@ static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>>   		return err;
>>   	}
>>   
>> -	/*
>> -	 * On call from xe_svm_handle_pagefault original VMA might be changed
>> -	 * signal this to lookup for VMA again.
>> -	 */
>> -	return -EAGAIN;
>> +	return 0;
>>   }
>>   
>> -static int xe_svm_garbage_collector(struct xe_vm *vm)
>> +/*
>> + * With reset_attrs false, defer ranges requiring a VMA change and return
>> + * -EAGAIN after collecting the remaining ready ranges in the batch. The
>> + * caller must release all read-side state before collecting them with
>> + * vm->lock held for write.
>> + */
>> +static int xe_svm_garbage_collector(struct xe_vm *vm, bool reset_attrs)
>>   {
>>   	struct xe_svm_range *range;
>> -	u64 range_start;
>> -	u64 range_end;
>> -	int err, ret = 0;
>> +	LIST_HEAD(pending);
>> +	LIST_HEAD(deferred);
>> +	u64 range_start, range_end;
>> +	bool needs_reset;
>> +	int err = 0, ret = 0;
>>   
>>   	lockdep_assert_held(&vm->lock);
>> +	if (reset_attrs)
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   	if (xe_vm_is_closed_or_banned(vm))
>>   		return -ENOENT;
>>   
>>   	guard(mutex)(&vm->svm.garbage_collector.lock);
>>   
>> +	/* Process a finite batch, excluding events queued during this pass. */
>> +	spin_lock(&vm->svm.garbage_collector.list_lock);
>> +	if (list_empty(&vm->svm.garbage_collector.range_list)) {
>> +		spin_unlock(&vm->svm.garbage_collector.list_lock);
>> +		return 0;
>> +	}
>> +	list_splice_init(&vm->svm.garbage_collector.range_list, &pending);
>> +	spin_unlock(&vm->svm.garbage_collector.list_lock);
>> +
>>   	for (;;) {
>>   		spin_lock(&vm->svm.garbage_collector.list_lock);
>> -		range = list_first_entry_or_null(&vm->svm.garbage_collector.range_list,
>> -						 typeof(*range),
>> +		range = list_first_entry_or_null(&pending, typeof(*range),
>>   						 garbage_collector_link);
>> -		if (!range)
>> +		if (!range) {
>> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
>>   			break;
>> +		}
>>   
>>   		range_start = xe_svm_range_start(range);
>>   		range_end = xe_svm_range_end(range);
>> -
>>   		list_del(&range->garbage_collector_link);
>>   		spin_unlock(&vm->svm.garbage_collector.list_lock);
>>   
>> +		/*
>> +		 * Keep the backing range alive until its attributes can be
>> +		 * reset. The GC mutex excludes other collectors and explicit
>> +		 * range removal requires vm->lock for write.
>> +		 */
>> +		needs_reset = xe_svm_range_needs_attr_reset(vm, range_start);
>> +		if (needs_reset && !reset_attrs) {
>> +			spin_lock(&vm->svm.garbage_collector.list_lock);
>> +			list_add_tail(&range->garbage_collector_link, &deferred);
>> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
>> +			ret = -EAGAIN;
>> +			continue;
>> +		}
>> +
>>   		err = __xe_svm_garbage_collector(vm, range);
>>   		if (err) {
>>   			drm_warn(&vm->xe->drm,
>>   				 "Garbage collection failed: %pe\n",
>>   				 ERR_PTR(err));
>> +			/* Leave the failed range in the tree for VM teardown. */
>>   			xe_vm_kill(vm, true);
>> -			return err;
>> +			goto out;
>>   		}
>>   
>> -		err = xe_svm_range_set_default_attr(vm, range_start, range_end);
>> -		if (err) {
>> -			if (err == -EAGAIN)
>> -				ret = -EAGAIN;
>> -			else
>> -				return err;
>> +		if (needs_reset) {
>> +			err = xe_svm_range_set_default_attr(vm, range_start, range_end);
>> +			if (err)
>> +				goto out;
>>   		}
>>   	}
>> +
>> +out:
>> +	/* Restore ranges not yet processed, including deferred resets. */
>> +	spin_lock(&vm->svm.garbage_collector.list_lock);
>> +	list_splice_tail_init(&pending, &vm->svm.garbage_collector.range_list);
>> +	list_splice_tail_init(&deferred, &vm->svm.garbage_collector.range_list);
>>   	spin_unlock(&vm->svm.garbage_collector.list_lock);
>>   
>> -	return ret;
>> +	return err ?: ret;
>> +}
>> +
>> +/**
>> + * xe_svm_garbage_collect() - Collect SVM ranges and reset their attributes
>> + * @vm: The VM, with vm->lock held for write.
>> + *
>> + * Process one batch of queued ranges, including attribute resets. Ranges
>> + * queued during this pass are left for a later collection.
>> + *
>> + * Call before changing advice or bindings, or querying attributes, so the
>> + * batch is reset before applying new advice or reporting attributes.
>> + * No VMA pointer may be retained across this call.
>> + *
>> + * Return: 0 on success, negative error code on error.
>> + */
>> +int xe_svm_garbage_collect(struct xe_vm *vm)
>> +{
>> +	lockdep_assert_held_write(&vm->lock);
>> +
>> +	if (!xe_vm_in_fault_mode(vm))
>> +		return 0;
>> +
>> +	return xe_svm_garbage_collector(vm, true);
>>   }
>>   
>>   static void xe_svm_garbage_collector_work_func(struct work_struct *w)
>>   {
>>   	struct xe_vm *vm = container_of(w, struct xe_vm,
>>   					svm.garbage_collector.work);
>> +	int err = 0;
>>   
>> -	guard(rwsem_read)(&vm->lock);
>> -	xe_svm_garbage_collector(vm);
>> +	scoped_guard(rwsem_read, &vm->lock)
>> +		err = xe_svm_garbage_collector(vm, false);
>> +
>> +	if (err != -EAGAIN)
>> +		return;
>> +
>> +	guard(rwsem_write)(&vm->lock);
>> +	xe_svm_garbage_collect(vm);
>>   }
>>   
>>   #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
>> @@ -1302,13 +1390,15 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   	if (range) {
>>   		mutex_unlock(&range->lock);
>>   		drm_gpusvm_range_put(&range->base);
>> -	}
>>   
>> -	/* Always process UNMAPs first so view SVM ranges is current */
>> -	err = xe_svm_garbage_collector(vm);
>> -	if (err) {
>> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>> -		return err;
>> +		/* The caller collected before the initial service attempt. */
>> +		err = xe_svm_garbage_collector(vm, false);
>> +		if (err) {
>> +			if (err != -EAGAIN)
>> +				xe_pagefault_set_error(pf,
>> +						      XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>> +			return err;
>> +		}
>>   	}
>>   
>>   	dpagemap = ctx.devmem_only ? xe_tile_local_pagemap(tile) :
>> @@ -1468,14 +1558,28 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>    * Create GPU bindings for a SVM page fault. Optionally migrate to device
>>    * memory.
>>    *
>> - * Return: 0 on success, negative error code on error.
>> + * The caller must hold vm->lock for read. On -EAGAIN, discard @vma before
>> + * releasing that lock. Collect with write access, then repeat VMA lookup
>> + * and permission checks before retrying.
>> + *
>> + * Return: 0 on success, -EAGAIN if the caller must collect with write
>> + * access and repeat VMA lookup, or another negative error code on error.
>>    */
>>   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   			    struct xe_pagefault *pf, struct xe_gt *gt,
>>   			    u64 fault_addr, bool atomic)
>>   {
>>   	int need_vram, ret;
>> -retry:
>> +
>> +	/* Consume older UNMAPs before reading advice or building the context. */
>> +	ret = xe_svm_garbage_collector(vm, false);
>> +	if (ret) {
>> +		if (ret != -EAGAIN)
>> +			xe_pagefault_set_error(pf,
>> +					       XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>> +		return ret;
>> +	}
>> +
>>   	need_vram = xe_vma_need_vram_for_atomic(vm->xe, vma, atomic);
>>   	if (need_vram < 0) {
>>   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_NEEDS_VRAM_CHECK);
>> @@ -1485,18 +1589,9 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   	ret =  __xe_svm_handle_pagefault(vm, vma, pf, gt, fault_addr,
>>   					 need_vram ? true : false);
>>   	if (ret == -EAGAIN) {
>> -		/*
>> -		 * Retry once on -EAGAIN to re-lookup the VMA, as the original VMA
>> -		 * may have been split by xe_svm_range_set_default_attr.
>> -		 */
>> -		vma = xe_vm_find_vma_by_addr(vm, fault_addr);
>> -		if (!vma) {
>> -			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND);
>> -			return -EINVAL;
>> -		}
>> -
>> +		/* Retry from the caller after collecting with write access. */
>>   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
>> -		goto retry;
>> +		return ret;
>>   	}
>>   	if (ret && xe_pagefault_get_error(pf) == XE_PAGEFAULT_ERROR_NONE)
>>   		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_SERVICE_FAILED);
>> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>> index ffc1cc808102..523213a8cd26 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.h
>> +++ b/drivers/gpu/drm/xe/xe_svm.h
>> @@ -109,6 +109,8 @@ void xe_svm_fini(struct xe_vm *vm);
>>   
>>   void xe_svm_close(struct xe_vm *vm);
>>   
>> +int xe_svm_garbage_collect(struct xe_vm *vm);
>> +
>>   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   			    struct xe_pagefault *pf, struct xe_gt *gt,
>>   			    u64 fault_addr, bool atomic);
>> @@ -316,6 +318,12 @@ void xe_svm_close(struct xe_vm *vm)
>>   {
>>   }
>>   
>> +static inline
>> +int xe_svm_garbage_collect(struct xe_vm *vm)
>> +{
>> +	return 0;
>> +}
>> +
>>   static inline
>>   int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   			    struct xe_pagefault *pf, struct xe_gt *gt,
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index d12365b11186..6afe6f1be1d4 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -1308,19 +1308,12 @@ static void vma_destroy_cb(struct dma_fence *fence,
>>   	xe_destroy_wq_queue(&vma->destroy_work);
>>   }
>>   
>> -static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
>> -{
>> -	lockdep_assert(lockdep_is_held_type(&vm->lock, 0) ||
>> -		       (lockdep_is_held_type(&vm->lock, 1) &&
>> -			lockdep_is_held_type(&vm->svm.garbage_collector.lock, 0)));
>> -}
>> -
>>   static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
>>   {
>>   	struct xe_vm *vm = xe_vma_vm(vma);
>>   	struct xe_bo *bo = xe_vma_bo(vma);
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   	xe_assert(vm->xe, list_empty(&vma->combined_links.destroy));
>>   
>>   	if (xe_vma_is_userptr(vma)) {
>> @@ -1416,7 +1409,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>>   	int err;
>>   
>>   	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	mutex_lock(&vm->snap_mutex);
>>   	err = drm_gpuva_insert(&vm->gpuvm, &vma->gpuva);
>> @@ -1429,7 +1422,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>>   static void xe_vm_remove_vma(struct xe_vm *vm, struct xe_vma *vma)
>>   {
>>   	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	mutex_lock(&vm->snap_mutex);
>>   	drm_gpuva_remove(&vma->gpuva);
>> @@ -2267,7 +2260,7 @@ static int xe_vm_query_vmas(struct xe_vm *vm, u64 start, u64 end)
>>   	struct drm_gpuva *gpuva;
>>   	u32 num_vmas = 0;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held(&vm->lock);
>>   	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end)
>>   		num_vmas++;
>>   
>> @@ -2280,7 +2273,7 @@ static int get_mem_attrs(struct xe_vm *vm, u32 *num_vmas, u64 start,
>>   	struct drm_gpuva *gpuva;
>>   	int i = 0;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held(&vm->lock);
>>   
>>   	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end) {
>>   		struct xe_vma *vma = gpuva_to_vma(gpuva);
>> @@ -2330,6 +2323,12 @@ int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_
>>   	if (err)
>>   		goto put_vm;
>>   
>> +	if (!xe_vm_is_closed_or_banned(vm)) {
>> +		err = xe_svm_garbage_collect(vm);
>> +		if (err)
>> +			goto unlock_vm;
>> +	}
>> +
>>   	attrs_user = u64_to_user_ptr(args->vector_of_mem_attr);
>>   
>>   	if (args->num_mem_ranges == 0 && !attrs_user) {
>> @@ -2487,7 +2486,7 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
>>   	u64 range_end = addr + range;
>>   	int err;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	vm_dbg(&vm->xe->drm,
>>   	       "op=%d, addr=0x%016llx, range=0x%016llx, bo_offset_or_userptr=0x%016llx",
>> @@ -2694,7 +2693,7 @@ static struct xe_vma *new_vma(struct xe_vm *vm, struct drm_gpuva_op_map *op,
>>   	struct xe_vma *vma;
>>   	int err = 0;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	if (bo) {
>>   		err = 0;
>> @@ -2795,7 +2794,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>   
>>   	switch (op->base.op) {
>>   	case DRM_GPUVA_OP_MAP:
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		err |= xe_vm_insert_vma(vm, op->map.vma);
>>   		if (!err)
>> @@ -2806,7 +2805,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>   		u8 tile_present =
>>   			gpuva_to_vma(op->base.remap.unmap->va)->tile_present;
>>   
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		prep_vma_destroy(vm, gpuva_to_vma(op->base.remap.unmap->va),
>>   				 true);
>> @@ -2842,7 +2841,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>   		break;
>>   	}
>>   	case DRM_GPUVA_OP_UNMAP:
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		prep_vma_destroy(vm, gpuva_to_vma(op->base.unmap.va), true);
>>   		op->flags |= XE_VMA_OP_COMMITTED;
>> @@ -2889,7 +2888,7 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>>   	u8 id, tile_mask = 0;
>>   	int err = 0;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	for_each_tile(tile, vm->xe, id)
>>   		tile_mask |= 0x1 << id;
>> @@ -3072,7 +3071,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>   
>>   	switch (op->base.op) {
>>   	case DRM_GPUVA_OP_MAP:
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		if (op->map.vma) {
>>   			prep_vma_destroy(vm, op->map.vma, post_commit);
>> @@ -3083,7 +3082,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>   	{
>>   		struct xe_vma *vma = gpuva_to_vma(op->base.unmap.va);
>>   
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		if (vma) {
>>   			xe_svm_notifier_lock(vm);
>> @@ -3098,7 +3097,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>   	{
>>   		struct xe_vma *vma = gpuva_to_vma(op->base.remap.unmap->va);
>>   
>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +		lockdep_assert_held_write(&vm->lock);
>>   
>>   		if (op->remap.prev) {
>>   			prep_vma_destroy(vm, op->remap.prev, prev_post_commit);
>> @@ -4092,6 +4091,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>>   		goto release_vm_lock;
>>   	}
>>   
>> +	/* Consume queued resets before replacing VMAs. */
>> +	err = xe_svm_garbage_collect(vm);
>> +	if (err)
>> +		goto release_vm_lock;
>> +
>>   	for (i = 0; i < args->num_binds; ++i) {
>>   		u64 range = bind_ops[i].range;
>>   		u64 addr = bind_ops[i].addr;
>> @@ -4907,7 +4911,7 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
>>   	u16 default_pat;
>>   	int err;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	if (is_madvise)
>>   		ops = drm_gpuvm_madvise_ops_create(&vm->gpuvm, map_req);
>> @@ -5041,7 +5045,7 @@ int xe_vm_alloc_madvise_vma(struct xe_vm *vm, uint64_t start, uint64_t range)
>>   		.map.va.range = range,
>>   	};
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	vm_dbg(&vm->xe->drm, "MADVISE_OPS_CREATE: addr=0x%016llx, size=0x%016llx", start, range);
>>   
>> @@ -5073,7 +5077,7 @@ void xe_vm_find_cpu_addr_mirror_vma_range(struct xe_vm *vm, u64 *start, u64 *end
>>   {
>>   	struct xe_vma *prev, *next;
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held(&vm->lock);
>>   
>>   	if (*start >= SZ_4K) {
>>   		prev = xe_vm_find_vma_by_addr(vm, *start - SZ_4K);
>> @@ -5105,7 +5109,7 @@ int xe_vm_alloc_cpu_addr_mirror_vma(struct xe_vm *vm, uint64_t start, uint64_t r
>>   		.map.va.range = range,
>>   	};
>>   
>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>> +	lockdep_assert_held_write(&vm->lock);
>>   
>>   	vm_dbg(&vm->xe->drm, "CPU_ADDR_MIRROR_VMA_OPS_CREATE: addr=0x%016llx, size=0x%016llx",
>>   	       start, range);
>> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
>> index 5c7aefc641ee..1af5e79bbfd3 100644
>> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
>> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
>> @@ -638,6 +638,11 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>>   		goto unlock_vm;
>>   	}
>>   
>> +	/* Consume queued resets before publishing new advice. */
>> +	err = xe_svm_garbage_collect(vm);
>> +	if (err)
>> +		goto unlock_vm;
>> +
>>   	err = xe_madvise_details_init(vm, args, &details);
>>   	if (err)
>>   		goto unlock_vm;
>> -- 
>> 2.43.0
>>
