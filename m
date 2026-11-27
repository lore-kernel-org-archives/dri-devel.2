Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NM5AL3+S;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dwsJGys3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126DE1122AA;
	Fri, 27 Nov 2026 07:19:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43EB1122AA;
 Fri, 27 Nov 2026 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795763929; x=1827299929;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hs7e8RkoktkI0rMT3B++eBYdJsCXBzXo6947aqrE+Rg=;
 b=NM5AL3+Skq3RYexI/ssE507bOJeqYvVUqC0gjQx5hIUcolsSg5gelpwu
 9DrAbJZ88rv0iSU4UszEYP7irvP1HR5TgTfyq9HPrNv9nKI+DFX87M70j
 ZZshnquhMFPXDb1yijRVYFerzv2OcOpQ9e8iYMIPSaSE9RNE1eWBlc9lq
 myTu96KkkMMVeaBouRAHcoRTqEk6fxFS9ol0rIbDqIJf2XqILijsmX0e/
 Gg53HYQCVCTwQPHq0mNd9PdUbQMfHaC7C4mpLoEzK4VQARIaLkxkcjSXk
 vNs5zKI/TYPQLm6EZFAyrDNTy32qXjL/CO0nClcpsX7ALSUUKnxFcREXu w==;
X-CSE-ConnectionGUID: 5kEpt1xlTUacxFTTF2G6zQ==
X-CSE-MsgGUID: RFW5SNAvTBqcqhMiMl2b4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4553288"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4553288"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:18:49 -0800
X-CSE-ConnectionGUID: v73MSF+0SVSmanQ9QLfIjg==
X-CSE-MsgGUID: JYFpZyXTSa6FOdCKs3NWLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12193369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:18:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:18:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:18:47 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShDdoYzC4+PTK6jixmJvVivBUrvt035Vulp/ClrxzymkCa7vj+8tIX51YwiVkKKektGN8Xs1wLeL3egd2b6VpUcIlMBXTCJQe5TsbgulQVF1SNVETXq7t65Cr9+BayArGUkMavUH8KS4g5QBN7YT+2CUqSQ2zoTLhU1+iLBPy1eXfh4pw2BV1sJIwNXGEU+lV4aU0Nhzpyv6sK6sUz+FA5VJL7lv6vZ0wSm7mQOi+UQAEGO3AOL1nHcWj+S+8l56mbGIUgp9i2M6KyyzY1cGa21PN5Az4UMpz9jQ9nuejXhyNch/OeEkB9UQBx9DuGR1nnP150zIPa2p0CWr7YZbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWXnzbaOAT0uOuxKlK/1eQoXS/g6PKe5URVLpXLosKI=;
 b=i4x3nKrX6L1GLIoldhDjRUasxSB9S+NmOgqHNfXdCJ67coA4Bm4egApOQullJF2zQbqOCfG2/I61X6RNglt3ju4CdG9LJNGAn47OSy9qb0rS1WCpj1j8pQvRYsqUn8UPRPctH8iSbceMNuF1UI81D81xwqcjX/A6ndxT4aD5Y15qkf9G272O6cGYnObFxoAs52fz5Mh4N4a3T35rLMdbjhH04ux2zyQQ6QNu6KWLKnJq8ej56b5xjEiCk4cHjCWa6wOqtC7Zi2kbnPeuWqFSXkM0DMDY90dIF6HH0bs1aYkk5dGYS1HNmWXjfGCbRlkgtMuQN54Ei2ZLW25EDfgweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWXnzbaOAT0uOuxKlK/1eQoXS/g6PKe5URVLpXLosKI=;
 b=dwsJGys3E3/Px9moe8spdzUib9VnCTuOC9gBV97kLYCIO/n+RASIT6g1/G/KSizKqUlMUpOdHNZ/Y+6CmIeRPfru9cg0tOTC4GePGIZXAuFG2GWr0RUF7SKfu0xNVlUG7v976KCY523y50NMKQ5hL3vyySbPKzVXBaBmsw6mpuA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 07:18:45 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:18:45 +0000
Message-ID: <7800e7ac-fbba-4724-8170-a31043f9c62b@intel.com>
Date: Fri, 27 Nov 2026 12:48:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/xe: Expose retired VRAM pages via drm-ras
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
 <20261125190249.156217-6-rodrigo.vivi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20261125190249.156217-6-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ5PPF44E8B88DF:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c1a77c-28db-460d-e7e0-08df4c56ac2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003;
X-Microsoft-Antispam-Message-Info: duIXTp57nQdFa1SIyCD6PDq826ZfXe2Gks55/oc1lK75KCQsbYBSfRsVE5Yav0JZeF4HhFV95Fi+UGaraTV4hkigiGnbqvvQNMIExsZh6u2Xo1btFVF6/Csb9TjtyLaA0r78QrQm//rY87wYlXiPZDG1Z0+zrTsfyrMScIXrrzHY70waZ9HjyYg6LSsnw9ldiWpbF6iQWBZc1h5vDVi4DkY986aUpxBXSxmH9WsJbCj28i0c77nBPHX7Ar5JMK5TjUH/hjrpbKt2oy2+aVMshifaWkfoQE2byG7HLMXV5QDM+cvs8ep/1HUUyXReccjl0QvigHNDfqa+3TEiTivxUXxkqlp7z1F32vp5gFt7gKCnMShhj4mItFgCVUfMp0D7UXnpQExavNBAeSONxwUSZASEk7jKEAh8qFKQfPSzMtt37Nxk5FXjMzEPZNxqPPpt9pgjWWORoY4XsYDoVsrogWNIC0yIG532rmL8giNV1R2NhOxrMrrJ/M8XVjHM/bd5i60YymUgOtthHxaejTgCmTI5YkSnP4kl7R1btpdY0eCgQqEWsaSdj/pvqTaLZj0sOpLHF65JL5OM3sBdjvfuGml2Z3ZT6vEwFjhGx8cWZ4/GAiR2+poycNX6AlDGDXV0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTY2Z2s0WnJXQTZkQUNVVENHVEVTM3ZVU201bXpKMVBCZU81cktoS2lrN3BP?=
 =?utf-8?B?SzlzZmlHQnI0bERhRWc2ZWdkdlo0QWVVWFpaclZHSndpYUtEZnhUc2V0NXFG?=
 =?utf-8?B?azZTaUxQcDBhOGtxb1h3dmRtNSs2VndsVklSUFlCcFhNWVVJTjRoVy9RVUxU?=
 =?utf-8?B?aW9vYmJXU1d1MmhNRnB4cHdVbi9QeDRjbXY3S0RVUzcwMmt6NUpHSXYyQ1Zr?=
 =?utf-8?B?Qm1nUUdkR3BlYnFWRGwxeGZqdXZnQ2xwNnVrUjhFUng5ZUdXVDZUcklWejFU?=
 =?utf-8?B?THBybkVpZDh0dG9FR3lLcTl4S2lwL3dEUXJDbFpVUmtzbDlxMWs1N2tBM29Z?=
 =?utf-8?B?aUVqVmdEd1g0VlRhOUpPN2xYQ0FuWUhxc2pLUnZTWUZrZ2xCSzA1ZnJaU3lP?=
 =?utf-8?B?Z0xYUWpvY3N5cWppbmxqTnJra3ZoRUVidkt3Nmoxc0p1QmlJakdCSUlzMWhr?=
 =?utf-8?B?bDB0ZzRyNGFKUUdONCtSaXFlRXBvTzdRM04zdG9mTlBpM0FsWWJkOFZqQ3My?=
 =?utf-8?B?QjNCVUN0UUttMzEwY0FnUDlPbEVEVzlFLzY0TnM4aGFkWDFtc0M5NWNOSmFL?=
 =?utf-8?B?N0NXVkVrSFN1Ty9aQlVyVVRsaklyejFCYkZJZWM5WVVKTmZmN2ZBbHkvYjRh?=
 =?utf-8?B?MElEM0gxekRucjJ1N1FmOTZ6RXJySjEzMzZBd0lWT3gybGtPMUdXY1F0LzYy?=
 =?utf-8?B?ZllWYU0yaW5oQk95cmxTWWJQeTBZMXdVajB5b3VOeFUyY04zUXlLUWJleFpE?=
 =?utf-8?B?QmJUOEZZcXZNN1k4c21tZVlKNGVzNGVqR1JJelM0dVZFemp5WHdpeVV5SnBj?=
 =?utf-8?B?NU44czk3WHp0U0dvT2xreGtzVUZaWkRJZ29kME5pbXNybGdJTzNXU0loTHNQ?=
 =?utf-8?B?L0ZLeW9CSmd5V1YrZ0tYZ05KNmkyMFdvQ3oyUU1uVjdWd2tQdUNnbUNBOTJq?=
 =?utf-8?B?WnFoVWREaTlEVzNkLzRJdkVGcCtsN3dXUzdOWmJhZkxxN2VRMUFSQTROTTEr?=
 =?utf-8?B?V05NYk13UHNRNmZwV2czN0xkdzdvRzVsZGpQdjJMNVh0a3lKTjMyQzh4aU9C?=
 =?utf-8?B?Tkl0T2w0eUpmUkFjSDZxZ0RsMVpVeVU2dmJESHN2NklSd044THByNFg1VXd1?=
 =?utf-8?B?VXhCcXhDcmk2YnY3SDBDYWd3SXRHQktJL1hXM1gwaXNyTkZVcTYvOTNoKzRY?=
 =?utf-8?B?S09DeklYNkpwZ1d5TWxVOFB5TXFwUjYwNmplcjZvQm1LQlNibEFrQVdsaDc2?=
 =?utf-8?B?R1FJNGhJc05GdkFON2ppYnB0dnl0aFVtREh3azN1b2dtWjZkVGswTys4Z2F3?=
 =?utf-8?B?UEU5ZTBpY2NZTEhxNnNWSXliRDBTem1YTWgzc0QrdFBhSEdJT3RDN3kyeDRs?=
 =?utf-8?B?NHBKS0VuKzlORmI2bU1MWUR6aloyelE0cSt6eTYyYUVIK0dDcEo3aWtVaVhM?=
 =?utf-8?B?bERTSWNqUENYbktVRU1BdWFlU054bmZuN1QrZnhPVTV6SnBZRnFIYVg4RXVV?=
 =?utf-8?B?K1ZiWDZZK2l2SXc0d1BMVnpDRmFSYmFkdFlNWnZtZ1p4OUJWVE9qL3c3WWd2?=
 =?utf-8?B?N044WCtaVm5rMk8yMGJOWGJkNDFaWDZubXN6YnFPZ0VtSVpZWitxdDBjVTBw?=
 =?utf-8?B?NHltZWRSU1hpcFlqVjB2TTRBNXAxc0lidXMyZXZBWjFQQ3hFUjI1TkJ6dUxC?=
 =?utf-8?B?WmJqMFZtWkhDZWpKS05oS1Zjekd3dW51ZFQ1SEhvTEdDWUxjRUdmQktRazhN?=
 =?utf-8?B?QnNhNnY4SVJUclRyRVFXTVdGS3RleDROUThrYUtFb2syZmovVHBZTWZ0N1Bl?=
 =?utf-8?B?L2FNNnVyQ25DUjhoRDIybUh0dmpvazhEczk2ZDAwUFNYR3FyUlJ2b1djTVdy?=
 =?utf-8?B?clU5cjQ2eEV1OUovOGRpdTNiZmtuMitTVURaTHRuTmh6Z1crTHQrWTJxSFpY?=
 =?utf-8?B?bHFoS0hBcEl1QVNRbG1DNStCbzk0S0IvR0RydU94SWh6d0gyVmgzYlp2U3dm?=
 =?utf-8?B?Q0M2TUlGc2NBcWx4b0VjWUtSbmV3bjRaaUMwZWJkWnJFcDZTU21PdDlsdm5w?=
 =?utf-8?B?QzhLdi9ncUpoUkc2TlpBSG5VWWdsbWRJNUxvNTM0b09Vc1dpaU5SY3AxZXVZ?=
 =?utf-8?B?ckIxU3EwRjJxNDVYUXZLYXdnclVUaHVjOGJ5ZFlKSVpzS00rWUpaNU5kdVZN?=
 =?utf-8?B?VFZRMjRWejEzcWd2bW43eE04OXZycVVmTEFaTzAwelhnWldraVJHN1lZRVJl?=
 =?utf-8?B?bTlmMjZIVlR0cHJMYjg0NE44Q1pqL24wb0tSLzM1by9LN0VTT0oxbnNPZ0U4?=
 =?utf-8?B?Tm1DNTRMcUkxVm1QMmJQRVhKbjg3N3l3M1o3RS94V2loK2oyVXJDZz09?=
X-Exchange-RoutingPolicyChecked: VvXRn/jlePf09xPYG186LSOkZefMiXCVhk5Jojq7kgzC0vpB+nqKwYAcftfv4KFGprB6GJgqdo+ceCGSfeRhgyuFPv7H8dwQhYr9XpYZ5jzg6YILj9rzb7K1fq6crCh8eEn6lPeniFDFaQMhyhU2U0Yxcw0uonpV9mww4Z3Svz11Vl7Zp10zlQjB8+vxhiOl8Eqd1zMLmLwyIdgNIzIsQjM5NXQ771eNnpg2FgL91N0pipmE2BcGl3qxBCHZIB9J81LszndIzDYAosnPv7bGF9SArEqlmMLAZDe3ufaCP/G+6yDMhnbuE+pbeaSVaE3Dy93Tx6dTtLJc3cSHS6cWKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c1a77c-28db-460d-e7e0-08df4c56ac2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:18:45.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+LSmBqpSsLPdBa2JQ+CVQaR35saFv2svItNKw8wr763GpH3e69m/uesRXO1j3iJsSFqohm3nCTmXDEdXXcUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26-11-2026 00:32, Rodrigo Vivi wrote:
> From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
>
> Retired VRAM pages are only visible through the vram_bad_pages debugfs
> file today. Register a drm-ras retired-pages node so userspace gets
> them, and the maximum number of pages that can be retired, through a
> stable interface.
>
> The page lists are walked under the VRAM manager lock, and a generation
> counter on each manager lets drm-ras flag dumps that raced with a page
> being added, retired or failing its reservation.
>
> v3 (Rodrigo+LLM):
>   - Use the drm-ras retired-pages node type, which replaces the nested
>     retired-resources layout (Jakub).
>   - Walk the lists under mgr->lock instead of RCU, which they are not
>     protected by, and stop reading the buddy blocks (Sashiko).
>   - Add a generation counter for interrupted dumps.
>   - Keep the vram_bad_pages debugfs file for now.
>   - Remove deprecated Assisted-by tag.
>
> v4 (Rodrigo+LLM):
>   - Register the node at the end of xe_ras_init(), once the retired page
>     lists are fetched. That point is only reached with a system
>     controller, which replaces the XE_CRESCENTISLAND check and keeps the
>     node off VFs (local Sashiko).
>   - Report the list generation also when no page is left (local Sashiko).
>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Riana Tauro <riana.tauro@intel.com>
> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c            | 56 +++++++++++++++++
>   drivers/gpu/drm/xe/xe_drm_ras.h            |  1 +
>   drivers/gpu/drm/xe/xe_ras.c                |  4 ++
>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       | 72 +++++++++++++++++++++-
>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |  3 +
>   drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |  5 ++
>   6 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index 86c589437a9f..5382b60bb328 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -13,6 +13,7 @@
>   #include "xe_device_types.h"
>   #include "xe_drm_ras.h"
>   #include "xe_ras.h"
> +#include "xe_ttm_vram_mgr.h"
>   #include "xe_wedge.h"
>   
>   static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
> @@ -272,6 +273,61 @@ static int register_nodes(struct xe_device *xe)
>   	return ret;
>   }
>   
> +static int query_retired_page(struct drm_ras_node *node, u64 cursor,
> +			      struct drm_ras_retired_page *page)
> +{
> +	return xe_ttm_vram_get_retired_page(node->priv, cursor, page);
> +}

This patch [PATCH v4 0/2] Protect drm_ras against unplugged or wedged 
device - Raag Jadav
<https://lore.kernel.org/intel-xe/20261119102344.2053821-1-raag.jadav@intel.com/>adds 
protection against a dev unplug for error counter nodes due to a issue 
we saw while unbind.
The same needs to be added here.

> +
> +static int query_retired_pages_info(struct drm_ras_node *node, u64 *max_pages)
> +{
> +	*max_pages = xe_ras_get_max_pages(node->priv);

There could be an issue with firmware reporting incorrect max pages.
Can we return -EINVAL for max_pages if its 0.


> +
> +	return 0;
> +}
> +
> +/**
> + * xe_drm_ras_register_retired_pages() - Register the retired VRAM pages node
> + * @xe: xe device instance
> + *
> + * Called once the retired page lists are populated.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int xe_drm_ras_register_retired_pages(struct xe_device *xe)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct drm_ras_node *node;
> +	int ret;
> +
> +	if (!xe->info.has_drm_ras)
> +		return 0;
> +
> +	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> +				      pci_domain_nr(pdev->bus), pdev->bus->number,
> +				      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!node->device_name)
> +		return -ENOMEM;
> +
> +	node->node_name = "vram-retired-pages";
> +	node->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
> +	node->query_retired_page = query_retired_page;
> +	node->query_retired_pages_info = query_retired_pages_info;
> +	node->priv = xe;
> +
> +	ret = drm_ras_node_register(node);
> +	if (ret) {
> +		cleanup_node_param(node);
> +		return ret;
> +	}
> +
> +	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +}
> +
>   /**
>    * xe_drm_ras_event() - Report drm-ras error event to userspace
>    * @xe: xe device structure
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
> index 723229b2cffb..a6fc2255986d 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.h
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.h
> @@ -13,6 +13,7 @@ struct xe_device;
>   	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
>   
>   int xe_drm_ras_init(struct xe_device *xe);
> +int xe_drm_ras_register_retired_pages(struct xe_device *xe);
>   void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 9b04be3405ca..8e5e2df2c9f7 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -1508,6 +1508,10 @@ int xe_ras_init(struct xe_device *xe)
>   	get_offline_list(xe);
>   	get_offline_queue(xe);
>   
> +	ret = xe_drm_ras_register_retired_pages(xe);
> +	if (ret)
> +		return ret;

Could we move this into xe_drm_ras_init() and add the sysctrl check there
too? That way all the initialization stays in one init function.

We should also add a check to skip registering this node when page
offlining is disabled.

Do we really need to fail probe if drm_ras node fails to register?

Thanks
Riana


> +
>   	/*
>   	 * During probe, process and log any errors detected by firmware while the driver was not
>   	 * loaded. Critical errors such as Punit and CSC are reported through Pcode init failure,
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index 36d47de8b11b..4a7b9ea36211 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -10,6 +10,7 @@
>   #include <drm/drm_managed.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_buddy.h>
> +#include <drm/drm_ras.h>
>   #include <uapi/drm/xe_drm.h>
>   
>   #include <drm/ttm/ttm_placement.h>
> @@ -240,13 +241,17 @@ static void xe_ttm_vram_retry_queued_pages(struct xe_ttm_vram_mgr *mgr)
>   					    PAGE_SIZE, PAGE_SIZE, &pos->blocks,
>   					    GPU_BUDDY_RANGE_ALLOCATION, NULL,
>   					    &pos->used_visible_size)) {
> -			pos->status = XE_PAGE_RESERVE_FAIL;
> +			if (pos->status != XE_PAGE_RESERVE_FAIL) {
> +				pos->status = XE_PAGE_RESERVE_FAIL;
> +				mgr->retired_gen++;
> +			}
>   			continue;
>   		}
>   		--mgr->n_queued_pages;
>   		list_del(&pos->queued_link);
>   		++mgr->n_offlined_pages;
>   		list_add(&pos->offlined_link, &mgr->offlined_pages);
> +		mgr->retired_gen++;
>   	}
>   }
>   
> @@ -625,6 +630,68 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
>   	return avail;
>   }
>   
> +static void retired_page_update(struct drm_ras_retired_page *page, bool *found,
> +				u64 cursor, u64 addr, enum drm_ras_retired_page_status status)
> +{
> +	if (addr < cursor || (*found && addr >= page->address))
> +		return;
> +
> +	page->address = addr;
> +	page->status = status;
> +	*found = true;
> +}
> +
> +/**
> + * xe_ttm_vram_get_retired_page - Get the next retired VRAM page
> + * @xe: xe device instance
> + * @cursor: lowest device address to consider
> + * @page: filled with the retired page that has the lowest address >= @cursor
> + *
> + * Return: 0 on success, -ENOENT if no retired page is at or above @cursor.
> + */
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
> +				 struct drm_ras_retired_page *page)
> +{
> +	struct xe_ttm_vram_offline_resource *pos;
> +	struct xe_tile *tile;
> +	bool found = false;
> +	u32 gen = 0;
> +	u8 id;
> +
> +	for_each_tile(tile, xe, id) {
> +		struct xe_vram_region *vr = tile->mem.vram;
> +		struct ttm_resource_manager *man;
> +		struct xe_ttm_vram_mgr *mgr;
> +
> +		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> +		if (!man || !vr)
> +			continue;
> +		mgr = to_xe_ttm_vram_mgr(man);
> +
> +		guard(mutex)(&mgr->lock);
> +
> +		gen += mgr->retired_gen;
> +
> +		list_for_each_entry(pos, &mgr->offlined_pages, offlined_link)
> +			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
> +					    DRM_RAS_RETIRED_PAGE_STATUS_RETIRED);
> +
> +		list_for_each_entry(pos, &mgr->queued_pages, queued_link)
> +			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
> +					    pos->status == XE_PAGE_RESERVE_FAIL ?
> +					    DRM_RAS_RETIRED_PAGE_STATUS_FAILED :
> +					    DRM_RAS_RETIRED_PAGE_STATUS_PENDING);
> +	}
> +
> +	page->generation = gen;
> +	if (!found)
> +		return -ENOENT;
> +
> +	page->size = PAGE_SIZE;
> +
> +	return 0;
> +}
> +
>   static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
>   {
>   	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
> @@ -825,6 +892,7 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
>   			/* Queue free(to-be-purged) pages */
>   			++vram_mgr->n_queued_pages;
>   			list_add(&nentry->queued_link, &vram_mgr->queued_pages);
> +			vram_mgr->retired_gen++;
>   		} else {
>   			/* Immediately offline unoccupied pages */
>   			/* Queue free(to-be-reserved) pages */
> @@ -839,10 +907,12 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
>   					addr, ret);
>   				++vram_mgr->n_queued_pages;
>   				list_add(&nentry->queued_link, &vram_mgr->queued_pages);
> +				vram_mgr->retired_gen++;
>   				return 0;
>   			}
>   			++vram_mgr->n_offlined_pages;
>   			list_add(&nentry->offlined_link, &vram_mgr->offlined_pages);
> +			vram_mgr->retired_gen++;
>   			return ret;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> index d77f067d197b..91147385718c 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> @@ -9,6 +9,7 @@
>   #include "xe_ttm_vram_mgr_types.h"
>   
>   enum dma_data_direction;
> +struct drm_ras_retired_page;
>   struct xe_device;
>   struct xe_tile;
>   struct xe_vram_region;
> @@ -33,6 +34,8 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
>   			  u64 *used, u64 *used_visible);
>   int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
>   int xe_ttm_vram_inject_fault(struct xe_device *xe);
> +int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
> +				 struct drm_ras_retired_page *page);
>   
>   static inline struct xe_ttm_vram_mgr_resource *
>   to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> index 4a2cd27a5b61..6a49ee8b09ef 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
> @@ -27,6 +27,11 @@ struct xe_ttm_vram_mgr {
>   	struct list_head queued_pages;
>   	/** @n_queued_pages: Number of queued pages */
>   	u16 n_queued_pages;
> +	/**
> +	 * @retired_gen: Changed whenever @offlined_pages or @queued_pages
> +	 * change. Protected by @lock.
> +	 */
> +	u32 retired_gen;
>   	/** @visible_size: Probed size of the CPU visible portion */
>   	u64 visible_size;
>   	/** @visible_avail: CPU visible portion still unallocated */
