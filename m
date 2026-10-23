Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D52606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MWPl36hs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F5E10E587;
	Fri, 23 Oct 2026 05:39:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830F310E580;
 Fri, 23 Oct 2026 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792733970; x=1824269970;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=enNhwIRYim6Df6edw+DRUOcVw9oqBHZi9q2yjufvdHM=;
 b=MWPl36hsP3L96jIOAS9I293xYt7BdvVK6a7aYCWPgxBfF7Yq+Zfmgs0u
 f6jsf/vEvL9oLn4f2zI6RO4XWvi48d7bCPp7WaANbptOkW5B2E129bJtv
 GX+/k/j9+VmDzz7E3qP6l+Q+vbTioMd25qnCl8K+HweEtBAfKASjHUgpy
 8jzG1c+Xv7wWZWy0+j/pALnxb+4hKT4NEwv4B9OGamwSLCB9xrStJae0U
 1+5O8xQooOpZ0ufcDQfaJ1EU+JQstVisPjbzNsAzM/UKj7PlAO4NtDuA8
 5d6QowvkAxxfk1Mu1SYwl0xSB/pH8AV8ubQGqiiZnrot2+BWR6UeEU9Ua A==;
X-CSE-ConnectionGUID: QbFlpokYTUm76SUJSzW02A==
X-CSE-MsgGUID: exXyV+wFSF2MQ0zAt9XP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1501463"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1501463"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 22:39:29 -0700
X-CSE-ConnectionGUID: VFMlJEVmRyKwWvfIBGGFiw==
X-CSE-MsgGUID: KFLySWElQ/mI/j6lu3h0FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="5396064"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 22:39:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 22:39:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 22:39:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 22:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6IfW9tzuXiBhFPM0JKbF0BX79jRGuPvRHah3cCYlBnccFSP/xeuW21LvPAni2Uf9YKroakfnfGPFs9rXc0EXToL0LaMyRAgQ8UgdSPgMYUt/olcwx3J8f3od183Kg934mT8OLfPZCATq8/Ejkn1XX3ZOeKVZ1SwTyfykXM6YjK+kTeyUpB4RHnYe+jpIa6wqutf0UcfeMrV2y1vh6R4UZ6hnZBDRcAk47/aeZOWBs0bSfAWVbpoE/X4rbAS7I0aNZCyoK6FyZfem0edKn8Zrl+jiP8taA3sHY/XjRS4gtsAhzCx2K930rZWudMp63vEMoMf26YtfJSBbTKQ3hgsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOuG7qLtpq6flqRNIGE4z4ZGDA/DotcaBmfBKZbziy0=;
 b=aP2G7UoPOGJvKiN6rC9kn4guITcDYhuZpKrzvPe713XRjDjsJZzSuVxOYW9iFKyuq1pgkry9NZ2Vnd4IigDF7eueWDmleNEw+U0Fw8+VGNg62mzJBNAS9ZJAh9nvKGPRIBrF+FcOGOnUzqudxseDnfXr8l2cXIWEc6T2UQyIidTgTTZ+c8y/X99kuLsXzir1aViFcFydyF3JkLa1o4mVC0kWPS+aQQF+OiuET6Z6rpstgipCXq6Cs91BdRipOEnQ3jcQp9ZC6AztFe50otEQUpuMp2Z+KAIj+WCYzXxhlM+n6wQl3SOKI2OdCz7UlWnVdrH5rUtS1cVw1vdDL2d1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 05:39:11 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 05:39:11 +0000
Message-ID: <af47e34d-95fa-47a1-967a-339b2ce9c71a@intel.com>
Date: Fri, 23 Oct 2026 11:09:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpu/tests/buddy: Add range-bias pruning and
 free-order tracking tests
To: Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Arun Pravin
 <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
 <20261022051518.486064-6-sanjay.kumar.yadav@intel.com>
 <cff7c9a5-b723-4936-bae0-574d5c42e24c@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <cff7c9a5-b723-4936-bae0-574d5c42e24c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a2f24d-37d1-4938-98d1-08df30c7f726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|10067099003|261021123027099003|22082099003|261022105027099003|261021121427099003|4143699003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: LOXWnkcAa853DspDC9tzBEQNEVSNlZnTXrpAiylxTSisK89Taj9n9t2emMPzFqLPCJV/1T2npY2kFs8u7GW0BnJ7Oeq9gQ/xroaHxU0y+fhp2CRmNAaa92ANtX15YBprZnjJipUNTWBizkJ02kzs1ZtVqfX+e+i/QFzxxT5nxCl7P/yYFEZjLHpCPnPLs36o1KNOzP4hUk2hEGvhuPGDbs0b1wzzKqJ58tMIP3ZePPlu4Ulfm+o9vJsZp6ARPbdpLzwS/0m9mkFj3+/FOv5PtFN/TiVBKYz/55SkHLJFCu6zMous4fDya0Wcm4Q2sm3jya9Jp9ic1bvMtMR7t/sFu7/CtyHlO4YOCNu3LqWMZSpGAlbHVhITTXhtNQPvfBO6t8xrQQz+PeIXfjdDcKNoYDQw08yJLN152pkG99k2XARX1dlA8pOSZgOxjxpA700vKFNfOHZdZc46a38MKKmja00XcXwG1EQVUadQbr32JVeIa0jDmTgcBR55lp9ExsJkuVXCHrJ6OR8IXQTuGg4bdawlU03uerEKNPLx+OzE12nu/2vc5GTj5k2uMEL80bi3D4sChkETVooDTnA5D0RDI+DtJX6LyRJ1/j0rYg6Rt2wPg2kSDBiql3JmWni8NuYymYgTAhTx7gzbe/Lj4YceDBq1BmIuUBXlC7N9TlVjxu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(10067099003)(261021123027099003)(22082099003)(261022105027099003)(261021121427099003)(4143699003)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNYQTk3VnRwQXZMUXpoYmU1dW1RNCs5K0lHd08ySkpKQ3JmR2IzTVU0bEVk?=
 =?utf-8?B?UGQ4SG9yV1JlT25XQ0ZpdWZZTFBJTFBZMk5LUkFYRFZGUmVmNkxDMXZwYXc4?=
 =?utf-8?B?eUNPcGxpK1RodXI5cGxOVEZsdG1EdXZOdVlmci9iZ3NVYVpITXdHZ2RkcGE5?=
 =?utf-8?B?L05UUHZ1T2U2VlkrRTdJVTBOZkdrSm9WR24veFhOejA1UjZBV0xscUVNWXhL?=
 =?utf-8?B?L2FsZ1BZUnF0YzVrQ1FuVzFXT2RxWU8yWXVsN2cvbTJQZkRMQ2ZJdEoyaHJO?=
 =?utf-8?B?NDBmWTV5T1gxUStNTXV1MjVBOUJ1MVlIWE9Sd3JGd1BPemNJSCtPQ2RYcWJu?=
 =?utf-8?B?V1ZVMTNoRlAyTm9OMHZDMTNDa1RTMTd2Vnd3aWJ4d0dPWEZiMEZxQk5STWFF?=
 =?utf-8?B?aXFGLzRaVEhRRm9Sdlh4RnZoVFNzNVgvN1pDbTJyMjBJOU1WbWN5OTJNUFBK?=
 =?utf-8?B?UGhCY2REVk9Eb1IvTEhXSXNhOEFieVp6TUZNNEwrb2NlcWFGS0tmOEczbFFM?=
 =?utf-8?B?Qm02bi8wRWZZS0Z4bXdSaitvTXpnOFl6K1ZPcVpsNDdKWlBaTUVQVUJ0WGFa?=
 =?utf-8?B?WVVBbUMwbER0emxaQWJTc0ZXUGxTU0d0WS9aTDkvWElQUmptMy82L3kzSkFt?=
 =?utf-8?B?ZUxVcExwNTRQK0pmcm1kYjg3VmgzbnN2K3d0NUZRSnpGVkszT1FndHB0ZFpI?=
 =?utf-8?B?dzZPcEwzdnh6K2J5QlJjc3NKZllOZ25xKzVuNEU5Q293YVFtQUV1UnNXRzR5?=
 =?utf-8?B?OGxjcjBhQkRiTzMrTFdxaU9pUVpJcDV4SHJIa1JmMWRkWkVzMWZOMWozQVcv?=
 =?utf-8?B?QStmWFVKaVRzYkExTlhNbGZTSXNpUDl2djZVN0Z4TmdLSG9pYVBMdzRBNWNk?=
 =?utf-8?B?WlE5aXp6NHkydVUzemM1QmVpbGd5ZzBoT0VObFoya0NNbTdkMmpEZ2FhTnRJ?=
 =?utf-8?B?Rm9sUE1ZSmlRUWVUYmxRemxhQlhzTXVkamZHZlBKSmExYnR5OWV1RWdJZDFU?=
 =?utf-8?B?K21LNkJ3NU1POTI2VzV2dHFXdEVyNkxCcXBTM1JaWXJ1NElRNUt0TGtPZkNX?=
 =?utf-8?B?VTdpejdGQ1RuQnltaUFFYU5zdEJIWjZycEFLWWNFQSt1eHhwWm1lSWd4MWxJ?=
 =?utf-8?B?RnNmZXFLOTRXd0lmK1AvUUlia3VpWnJmR2dvNjBESllCS3orWnczTEhwRGRE?=
 =?utf-8?B?UmpPVGdjVnJrN21aTkUrN3Z1Mk9jQ1MxTlpPYTFiaVBvaisvSjZwRENzRnQ5?=
 =?utf-8?B?RlBlV3NWb0pnU0o4Z1hHSHFVK1ZvN3VVZDV6TmNZT0NURGh4ZWJwZmRETzRX?=
 =?utf-8?B?Tmk0akt4dHhiaXdDbHVyOTF1RVVwdWd6Z2NiMUMveVNjZkdVNDB4RDFyRDR4?=
 =?utf-8?B?S0c0eHNrbkV1MWVWNHJhZDhuMzBiY00xK2pMNnNsMGhlMFhDNWhJSmNDbEpN?=
 =?utf-8?B?SG8wREN6WUp4cW4vcDBjcWZ6Z1dNeGtabUVTaDJDbXZaUmZRQ3RQaE5YbzlN?=
 =?utf-8?B?TE0zRXFFUEUxVUUvZjl0cGpTekNhQW9iWCszN3FscDVjdlZYaE9kemYxKzZH?=
 =?utf-8?B?UHpTemk5MzNLVnBiQ0JRWGs3K1ZydWNoOFVVRitWUnZEY2dlY0hHUWRFYnFJ?=
 =?utf-8?B?eXJEbzltTlU4SVhwYklrOHZyRDFOdHpoRTdRSmw3MlhHd24xeHFHdkw5RkNR?=
 =?utf-8?B?dFovTGVJYXpmRUdEVXFwenBrRmxzV29jYjUxNCtHcXliMm5pV2kwK1kxeFVm?=
 =?utf-8?B?UXFUYVpHeDdRWHl6Q0VaVHM4RCtLUGh0bnZBVytiYmhKYWhoWUlmdzB5U0hk?=
 =?utf-8?B?MktNNFpIWXBkM1l0aFJ2K1BncTdqWlowQjdWc0ZPL3JDamFocTRYdnB5bmtS?=
 =?utf-8?B?YXhVREhBdUsxV2U2VnUyTitTSUFhVEJscmdKYmxlV1JPT0JFTkFQSVpXc3Y2?=
 =?utf-8?B?U3Y1akg3cWh0NFBNMTNyenQ0Q05jS2ZlUEt3eXB0Z1pZUHF0UFVFK2Eyc2Jp?=
 =?utf-8?B?TllXbFRiVjhiVEQ0anArQUxEVWJVL1BVTmRBbndOM21kMUNueE1XOFF3TnJo?=
 =?utf-8?B?bFZUKzZFYndpc0VPNTNwTjQ4NmN5ckFqdmtPWmJqZ0YxKzZ4TnZzVDljSXhG?=
 =?utf-8?B?elVSZmpvZExsZWJUbU52eVlnZnU5T3FNSmlZTkVOei9qTm5CTnVYLzdvZVFZ?=
 =?utf-8?B?Y0drSE5CMzhPaEpKRE9zRjVXZ0ZyVHRUdHcxblJFSVdQanNIV1ZBTlkwR0Ez?=
 =?utf-8?B?ZkVKSlNDOEY1UmRaa2cvVjJsdGMrVlBMQ0x2MFQxOFN0RnlOMzR3YlhzSSt3?=
 =?utf-8?B?R0xYeDVQSDJXekdndjdPNnNobnIrcEoxZ2d6NVJmMWdZYkk1dDE4MllESjhN?=
 =?utf-8?Q?ueW5u+Fara5uItro=3D?=
X-Exchange-RoutingPolicyChecked: vg3qJh6czywJL1wPqW78B4SSt2+q8T2AJ4W+0dYkXvjE7Sr0hJqJoiYNQP5viyCAvEenxFQXCiF6+/p2T10xBb3vxWeuFzoU6DVBuP5Wfn+WwZxCRB6elPw+fS3xnFGEOpJ6Uw2cVSoLLC2udl3EKynvmEN7/xWDGmQg3Qpc9ffLV8U91FsO8ZM+TfM3gNU9e2yLwdWhuZ8LrprDnXgnGV0rXK9azk/HQioC6Cg7K9aUSi+yQe1sS7uELCtiXQ66ct0LanT9DNNfcmt6jMPiapIwxBQzBpcIA8d3/Q2urMTbDTvP6SHoxDJ0wdwpAdaiTL4MJR54LBpebD7idzJKUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2f24d-37d1-4938-98d1-08df30c7f726
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:39:11.4738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPZIwB8OgkRM4ncwZ8KQhLAmMgSSB7nXTh5bNKjp6izYESsXAbivYys9ygB7SxHVpYTlP0XHo5HUDNuMijTIxSMDkmaEsXynNlm4vlrsSME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 22-10-2026 15:15, Matthew Auld wrote:
> On 22/10/2026 06:15, Sanjay Yadav wrote:
>> gpu_test_buddy_range_bias_pruning fills a 128 MiB range of a 512 MiB
>> manager with 4K range allocations. It checks top-down placement, that
>> the exhausted range advertises GPU_BUDDY_NO_FREE_ORDER, -ENOSPC inside
>> the range while space outside stays usable, and that freed holes are
>> found again. To check pruning itself, it hides the only free block
>> behind an ancestor that advertises no free space and expects -ENOSPC;
>> without pruning the search would return that block. Allocation time is
>> reported but not asserted.
>>
>> gpu_test_buddy_free_order_tracking covers root creation, split,
>> allocation, partial and full coalescing (4K vs 64K), rollback of a
>> partially satisfied request, gpu_buddy_block_trim() with and without an
>> explicit start, exact-range, clear and top-down allocations, and
>> teardown.
>>
>> Both use a helper that checks every block's subtree_max_free_order
>> against its state and its children.
>>
>> v3: (Sashiko)
>> - Use div_u64() to avoid an __aeabi_uldivmod failure on 32-bit
>>    architectures.
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/tests/gpu_buddy_test.c | 308 +++++++++++++++++++++++++++++
>>   1 file changed, 308 insertions(+)
>
> +308, do we need all of this? IIUC we are optimising the range_bias to 
> short-circuit earlier, by now tracking the largest free order for a 
> subtree. Is it not enough to rely on the existing range_bias tests for 
> correctness? Could those not be extended, if we are missing something 
> in terms of coverage?
existing range_bias test already covers every case where the
patch could hand out the wrong block or fail spuriously. The extra
tests were mostly checking the bookkeeping itself.
>
> Also, ideally we don't want the kunit reaching too much into the gory 
> internals here, except maybe in special cases. For the most part it 
> should just use the exposed API.
Makes sense. For v4 I will replace them with a single
KUNIT_CASE_SLOW perf test in the style of the existing
fragmentation/dirty_tracker ones, using only the public API

  - fill a 128M window at the bottom of a 512M mm with 4K
     GPU_BUDDY_RANGE_ALLOCATION allocs
   - report the time via kunit_info() (not asserted)
   - check top-down placement and -ENOSPC once the window is full
at least shows the quadratic behaviour going away.

If you'd rather not carry a perf test at all?

Thanks,
Sanjay
>
>>
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index 2c6f1da1a6d1..76392329e9e2 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1595,6 +1595,312 @@ static void 
>> gpu_test_buddy_addr_to_block(struct kunit *test)
>>       gpu_buddy_fini(&mm);
>>   }
>>   +static bool gpu_test_block_is_split(struct gpu_buddy_block *block)
>> +{
>> +    return (block->header & GPU_BUDDY_HEADER_STATE) == GPU_BUDDY_SPLIT;
>> +}
>> +
>> +static void gpu_test_check_free_order(struct kunit *test, struct 
>> gpu_buddy *mm)
>> +{
>> +    struct gpu_buddy_block *block, *bad = NULL;
>> +    unsigned int nr_bad = 0;
>> +    s8 expected, bad_expected = 0;
>> +    LIST_HEAD(dfs);
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < mm->n_roots; i++)
>> +        list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>> +
>> +    while ((block = list_first_entry_or_null(&dfs, struct 
>> gpu_buddy_block,
>> +                         tmp_link))) {
>> +        list_del(&block->tmp_link);
>> +
>> +        if (gpu_buddy_block_is_free(block)) {
>> +            expected = gpu_buddy_block_order(block);
>> +        } else if (gpu_test_block_is_split(block)) {
>> +            expected = max(block->left->subtree_max_free_order,
>> + block->right->subtree_max_free_order);
>> +            list_add(&block->right->tmp_link, &dfs);
>> +            list_add(&block->left->tmp_link, &dfs);
>> +        } else {
>> +            expected = GPU_BUDDY_NO_FREE_ORDER;
>> +        }
>> +
>> +        if (block->subtree_max_free_order != expected && !nr_bad++) {
>> +            bad = block;
>> +            bad_expected = expected;
>> +        }
>> +    }
>> +
>> +    KUNIT_EXPECT_EQ_MSG(test, nr_bad, 0U,
>> +                "first stale block: offset=%#llx order=%u stored=%d 
>> expected=%d",
>> +                bad ? gpu_buddy_block_offset(bad) : 0,
>> +                bad ? gpu_buddy_block_order(bad) : 0,
>> +                bad ? bad->subtree_max_free_order : 0, bad_expected);
>> +}
>> +
>> +static struct gpu_buddy_block *
>> +gpu_test_find_block(struct gpu_buddy *mm, u64 offset, unsigned int 
>> order)
>> +{
>> +    struct gpu_buddy_block *block;
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < mm->n_roots; i++) {
>> +        u64 start;
>> +
>> +        block = mm->roots[i];
>> +        start = gpu_buddy_block_offset(block);
>> +        if (offset < start || offset >= start + 
>> gpu_buddy_block_size(mm, block))
>> +            continue;
>> +
>> +        while (gpu_buddy_block_order(block) > order) {
>> +            if (!gpu_test_block_is_split(block))
>> +                return NULL;
>> +            block = offset < gpu_buddy_block_offset(block->right) ?
>> +                block->left : block->right;
>> +        }
>> +        return block;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static struct gpu_buddy_block *
>> +gpu_test_take_block(struct list_head *blocks, u64 offset)
>> +{
>> +    struct gpu_buddy_block *block;
>> +
>> +    list_for_each_entry(block, blocks, link) {
>> +        if (gpu_buddy_block_offset(block) == offset) {
>> +            list_del(&block->link);
>> +            return block;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void gpu_test_buddy_range_bias_pruning(struct kunit *test)
>> +{
>> +    const u64 mm_size = SZ_512M, range_end = SZ_128M, chunk = SZ_4K;
>> +    const unsigned int nr = range_end / chunk, window = 1024;
>> +    const u64 holes[] = { 0, range_end / 2 + 3 * chunk };
>> +    struct gpu_buddy_block *block, *hidden;
>> +    u64 first_ns = 0, last_ns = 0;
>> +    unsigned int i, misplaced = 0;
>> +    LIST_HEAD(allocated);
>> +    struct gpu_buddy mm;
>> +    LIST_HEAD(tmp);
>> +    int err;
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>> +                   "buddy_init failed\n");
>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>> +
>> +    /*
>> +     * Small-BAR pattern: order-0 allocations confined to a low 
>> prefix of a
>> +     * larger manager. Top-down placement packs them right below 
>> range_end,
>> +     * so without pruning every allocation walks all previously 
>> allocated
>> +     * blocks and the total cost is quadratic.
>> +     */
>> +    for (i = 0; i < nr; i++) {
>> +        ktime_t start = ktime_get();
>> +        u64 elapsed;
>> +
>> +        err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
>> +                         &allocated, GPU_BUDDY_RANGE_ALLOCATION);
>> +        elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
>> +        KUNIT_ASSERT_EQ_MSG(test, err, 0, "range alloc %u failed\n", 
>> i);
>> +
>> +        if (i < window)
>> +            first_ns += elapsed;
>> +        else if (i >= nr - window)
>> +            last_ns += elapsed;
>> +
>> +        block = list_last_entry(&allocated, struct gpu_buddy_block, 
>> link);
>> +        if (gpu_buddy_block_offset(block) != range_end - (u64)(i + 
>> 1) * chunk)
>> +            misplaced++;
>> +    }
>> +
>> +    kunit_info(test, "first %u range allocs: %llu us, last %u: %llu 
>> us\n",
>> +           window, div_u64(first_ns, NSEC_PER_USEC),
>> +           window, div_u64(last_ns, NSEC_PER_USEC));
>> +
>> +    /* Top-down placement inside the range is unchanged */
>> +    KUNIT_EXPECT_EQ(test, misplaced, 0U);
>> +
>> +    /* The exhausted range advertises no free space, so it is pruned */
>> +    block = gpu_test_find_block(&mm, 0, ilog2(range_end / chunk));
>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>> +    KUNIT_EXPECT_EQ(test, block->subtree_max_free_order, 
>> GPU_BUDDY_NO_FREE_ORDER);
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, range_end, 
>> chunk, chunk,
>> +                             &tmp, GPU_BUDDY_RANGE_ALLOCATION),
>> +            -ENOSPC);
>> +
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, 
>> chunk, chunk,
>> +                            &tmp, 0));
>> +    block = list_first_entry(&tmp, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_GE(test, gpu_buddy_block_offset(block), range_end);
>> +    gpu_buddy_free_list(&mm, &tmp, 0);
>> +
>> +    /* A single hole, including the very last one in walk order, is 
>> found */
>> +    for (i = 0; i < ARRAY_SIZE(holes); i++) {
>> +        block = gpu_test_take_block(&allocated, holes[i]);
>> +        KUNIT_ASSERT_NOT_NULL(test, block);
>> +        gpu_buddy_free_block(&mm, block);
>> +        gpu_test_check_free_order(test, &mm);
>> +
>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>> range_end,
>> +                                chunk, chunk, &allocated,
>> +                                GPU_BUDDY_RANGE_ALLOCATION));
>> +        block = list_last_entry(&allocated, struct gpu_buddy_block, 
>> link);
>> +        KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), holes[i]);
>> +    }
>> +
>> +    /*
>> +     * Deterministic pruning check: hide the only free block in the 
>> range
>> +     * behind an ancestor that advertises no free space. Without 
>> pruning the
>> +     * search would walk into that subtree and return the block.
>> +     */
>> +    block = gpu_test_take_block(&allocated, holes[1]);
>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>> +    gpu_buddy_free_block(&mm, block);
>> +    hidden = gpu_test_find_block(&mm, holes[1], 4);
>> +    KUNIT_ASSERT_NOT_NULL(test, hidden);
>> +    KUNIT_ASSERT_EQ(test, hidden->subtree_max_free_order, (s8)0);
>> +
>> +    hidden->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>> +    err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk, &tmp,
>> +                     GPU_BUDDY_RANGE_ALLOCATION);
>> +    hidden->subtree_max_free_order = 0;
>> +    KUNIT_EXPECT_EQ(test, err, -ENOSPC);
>> +    gpu_buddy_free_list(&mm, &tmp, 0);
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>> +    gpu_test_check_free_order(test, &mm);
>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, 
>> (s8)mm.max_order);
>> +
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>> +static void gpu_test_buddy_free_order_tracking(struct kunit *test)
>> +{
>> +    const u64 chunk = SZ_4K;
>> +    struct gpu_buddy_block *block;
>> +    LIST_HEAD(allocated);
>> +    struct gpu_buddy mm;
>> +    u64 start, avail;
>> +    LIST_HEAD(big);
>> +    unsigned int i;
>> +
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_8M + SZ_2M + 
>> SZ_64K, chunk));
>> +    KUNIT_EXPECT_EQ(test, mm.n_roots, 3U);
>> +    for (i = 0; i < mm.n_roots; i++)
>> +        KUNIT_EXPECT_EQ(test, mm.roots[i]->subtree_max_free_order,
>> +                (s8)gpu_buddy_block_order(mm.roots[i]));
>> +    gpu_test_check_free_order(test, &mm);
>> +    gpu_buddy_fini(&mm);
>> +
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_16M, chunk));
>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>> +    for (i = 0; i < SZ_4M / chunk; i++)
>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>> SZ_4M, chunk, chunk,
>> +                                &allocated,
>> +                                GPU_BUDDY_RANGE_ALLOCATION));
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* Partial coalescing up to order 3 must not satisfy a 64K 
>> request */
>> +    for (i = 0; i < SZ_64K / chunk - 1; i++) {
>> +        block = gpu_test_take_block(&allocated, SZ_1M + i * chunk);
>> +        KUNIT_ASSERT_NOT_NULL(test, block);
>> +        gpu_buddy_free_block(&mm, block);
>> +    }
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* A partially satisfied request is rolled back on -ENOSPC */
>> +    avail = mm.avail;
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>> SZ_128K, chunk, &big,
>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>> +            -ENOSPC);
>> +    KUNIT_EXPECT_EQ(test, mm.avail, avail);
>> +    KUNIT_EXPECT_TRUE(test, list_empty(&big));
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>> SZ_64K, SZ_64K, &big,
>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>> +            -ENOSPC);
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* SPLIT -> FREE: the last buddy coalesces the window into a 64K 
>> block */
>> +    block = gpu_test_take_block(&allocated, SZ_1M + SZ_64K - chunk);
>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>> +    gpu_buddy_free_block(&mm, block);
>> +    gpu_test_check_free_order(test, &mm);
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>> SZ_64K, SZ_64K, &big,
>> +                            GPU_BUDDY_RANGE_ALLOCATION));
>> +    block = list_last_entry(&big, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)SZ_1M);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), 
>> (u64)SZ_64K);
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* Trim with an explicit start re-allocates inside the detached 
>> block */
>> +    start = SZ_1M + SZ_16K;
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_block_trim(&mm, &start, 
>> SZ_16K, &big));
>> +    KUNIT_ASSERT_TRUE(test, list_is_singular(&big));
>> +    block = list_first_entry(&big, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), start);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), 
>> (u64)SZ_16K);
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* Exact-range allocation */
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_8M, 
>> SZ_8M + SZ_256K,
>> +                            SZ_256K, chunk, &big, 0));
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    /* Cleared frees, clear range allocation and top-down allocation */
>> +    gpu_buddy_free_list(&mm, &big, GPU_BUDDY_CLEARED);
>> +    gpu_test_check_free_order(test, &mm);
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_4M, 
>> SZ_16M, SZ_128K, chunk,
>> +                            &big,
>> +                            GPU_BUDDY_RANGE_ALLOCATION |
>> +                            GPU_BUDDY_CLEAR_ALLOCATION));
>> +    gpu_test_check_free_order(test, &mm);
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_16M, 
>> SZ_1M, chunk, &big,
>> +                            GPU_BUDDY_TOPDOWN_ALLOCATION));
>> +    gpu_test_check_free_order(test, &mm);
>> +
>> +    gpu_buddy_free_list(&mm, &big, 0);
>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>> +    gpu_test_check_free_order(test, &mm);
>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, 
>> (s8)mm.max_order);
>> +    gpu_buddy_fini(&mm);
>> +
>> +    /*
>> +     * Contiguous non-power-of-two allocations are trimmed, which 
>> re-allocates
>> +     * inside a temporarily detached block. Ancestors must still be 
>> updated.
>> +     */
>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_32K, chunk));
>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>> +    for (i = 0; i < 2; i++) {
>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_32K,
>> +                                SZ_8K + SZ_4K, chunk,
>> +                                &allocated,
>> + GPU_BUDDY_CONTIGUOUS_ALLOCATION));
>> +        gpu_test_check_free_order(test, &mm);
>> +    }
>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, (s8)0);
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_32K, 
>> SZ_8K, SZ_8K, &big,
>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>> +            -ENOSPC);
>> +
>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>> +    gpu_test_check_free_order(test, &mm);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>   {
>>       while (!random_seed)
>> @@ -1621,6 +1927,8 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>> KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>>       KUNIT_CASE(gpu_test_buddy_addr_to_block),
>> +    KUNIT_CASE(gpu_test_buddy_range_bias_pruning),
>> +    KUNIT_CASE(gpu_test_buddy_free_order_tracking),
>>       {}
>>   };
>
