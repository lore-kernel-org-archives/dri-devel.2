Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C2606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j130jgLn;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iCxBrLYe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAAE10E683;
	Thu, 19 Nov 2026 09:50:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDF510E683;
 Thu, 19 Nov 2026 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795081811; x=1826617811;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3msPGpA8raVOy2q+h8YFrDHvaC9mYD0rSVfVe8EuDJs=;
 b=j130jgLnHhi/WZivLmCJ+8DY4hf6hYI4Km/7STzc3H4t5ZlRm3yvxpZq
 RqeqXx8e5WWqhZBkOOu5aM9Y2acghdO3jRgCgo/hZoaWWwJR7LN/84Ofn
 UIrD94Vo/7XQStCGm7MB5dWZIBJgT6nqxHjf5SpImxD7byLfk2iYTj3Fl
 8vQqAqMz4AnGdIMFPyy+g+bjhmlo91hQrRAHnMkSCKkWNu2MgTRywusGL
 NG7YUhEopWWAwbF4WCBKbqGR6u2a9Egb/AFgmYP2pucyCzUsJQcfnA1oK
 aCSP3sJAYtJMpeSZMGxFzxqGzUgEjhWGYByxgbMab5x7XVBk+jaPU3VQ2 w==;
X-CSE-ConnectionGUID: HvBdfg1oRS6fiQxsZPCJdw==
X-CSE-MsgGUID: xjyxb7KDSd+se8qghk6QnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3943936"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3943936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 01:50:10 -0800
X-CSE-ConnectionGUID: OcQJ6WrnTpuDTEXyTKBESw==
X-CSE-MsgGUID: C/PrYDewT766kBbAz8af4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10637130"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 01:50:11 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 01:50:10 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 01:50:10 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 01:50:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5JZAaY1NPJCN0aGHOjdLHSvYq5qlUtw5XDWoNrglTKlZ+VySf16kOgziIAMTkQVqjJoJKRmLH3Mu+fxSJncI1YPj0/F9w8++HdAfRqxLzVgXVJ90757sC1SAGK94/aLl5MQ4BSBsv4iNXw0XlyUEGIfSsS5s7RT6BWXjUanPv4LG0PLNU/8z+ss0bcs5czvboghxvBz5AcSqxwrdf+IylEANJc2Ch4D3BfnAZavyuzRihh3C+BJfylk1sbphiuOR8PnQWL3s1KFgvI1fuyjnC3aYF6xo9TS70KMdD0upAMNpuESnFgADfAaP6iVeSNXWnjEMJr1EusKF/PV7EUDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpcU3iDiIjTlT5AU87lLaeOTlJiHhUkHSEldjUExgI0=;
 b=IicTQSfvQM1swzXT9+7vWPQwTDrOl9ExYRl2X81SgsNJ8dVSqFfHKhmPJRuLE89P892VtMcSaCBMvC1tMdmUWkP2KdBKXws+dnFEzectCGO+G4F7u//9g5j1NO9ku2rqTnH9kT2VkI/y0Evaf6VxGmDsCU7ZdpHjAz3sMurL59b8HFm5tBnj5dOH3h/cfoDwmbizQSIGXhQeS/9bTVmHY4nzIgJSVJo+hvTIRAZYOpkh3xodPTlHpKbDuNDYiyCgn+ysfDLz9NAXJtIfc+icIbgAZaHbbY0JSCKEvQHkiRl99YKaITFLbJwjGJbTixlvVdoTtwcW5JBElU933EEDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpcU3iDiIjTlT5AU87lLaeOTlJiHhUkHSEldjUExgI0=;
 b=iCxBrLYeF5EPsGjLQDbYCwGJlfGBRCe5DjiNKHmN7AczI0aPQdAFo6jR3NU0OcjIKcm9rXOMDUCsE0ZVo3lExeuCZ1QQ/NlOur4gks1fZHzqMtyDnArWptJtcH1WDl0105R/FEE7g/ZmAmEnFDA69DnPY4o/Az10dUjyKy4NpvM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:50:07 +0000
Received: from PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92]) by PH8PR11MB8039.namprd11.prod.outlook.com
 ([fe80::42df:f465:90a8:df92%3]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 09:50:07 +0000
Date: Thu, 19 Nov 2026 10:50:03 +0100
From: Piotr =?utf-8?Q?Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>
To: "Summers, Stuart" <stuart.summers@intel.com>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "yaolu@kylinos.cn"
 <yaolu@kylinos.cn>, "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "michal.wajdeczko@intel.com"
 <michal.wajdeczko@intel.com>
Subject: Re: [PATCH] drm/xe/gt: Abort GT init on LMTT initialization failure
Message-ID: <20261119095003.reakox5n3mhp5utx@intel.com>
References: <20261118085453.198348-1-yaolu@kylinos.cn>
 <54d0efa24a49e73880bdc4d6f2786b940f32fdf8.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54d0efa24a49e73880bdc4d6f2786b940f32fdf8.camel@intel.com>
X-ClientProxiedBy: AS9PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::13) To PH8PR11MB8039.namprd11.prod.outlook.com
 (2603:10b6:510:25f::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8039:EE_|DM6PR11MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: 123fb44f-6913-41ce-1f28-08df46227e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|261028144727099003|261022075727099003|11063799006|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261102123227099003|261026140227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ZFmI56AabYZCyqe7qj5enD0GOaJtH+2toNUxo0SAQoaaD/VDtDph9sr6qvdKOTZ0Qj0+zLGFDJ6buJ2FCrz3pyLh/m3sX8c+Khmffdm9xEQK912jaUjF9dwFr+ahDD+edLYO8rydzi4pdhoCq7v5CDys5Q0y/igx1v055fcdc2gGdKltWSqBwVrxXeUjuAdNPrBum40rsm+nBprwIu1LT4zr+UBLb07b/A5DALftohuvqNivJmlshzRrZCTUUwHvSYZOnlA74oemAIPatb2xgS5KBbkv1g2RqTtkSSKcCYAY2Z2tsh83i6VzTyG8ycXtA5Lc0PZzuuSFQ2IFScnrbU15u43J7z9bEi1MUemD1E+3LaEkqOwYfWrTH1M2OUIcv37wACy/A2tYmtJY/2SB7eQz50J6QR4QKuBMMREDSoL0RVoHg1m7UL0S+4RFLwp6L6t0pS7nQKg4BbIXmtMaHZx03nNfmoUgHx7QU91+wSszxBJOjwu4mnm4MKMAfgTys+9YU97SBWaBPWcYcM1yked41/uePeWm9//2ixFjubui8KNyLJlZmuuq1xHuWtFbtUV1LDGpCagH4Cl6OTAKQSc44Ll1ZuJR21zDbJ3CbkYt31NNtnGk0OjLYjp+V4Kk3jPwm7Obos7xeJE8/wNTirNToewaKd7dkXSWDMu/CVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8039.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(261028144727099003)(261022075727099003)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261102123227099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdSdHJMYmRybEdJNFVjYjZ5M3FBbWQ5Y1k4bjNwV1VvSStmQWRXdUxhcjRj?=
 =?utf-8?B?L3pubTUrUnZ4MzZDcER2Q2dMZlpmSEpTVGIvdmwveWhwaVVYaGhYeU4wYmds?=
 =?utf-8?B?Y3BCVmZpQnJtZ0w5OEJQWHM3bjdCMWR5S0JhSGNCUmtzYXhrOHo1VlpsYXhW?=
 =?utf-8?B?RUlmTExHMHZrejZaSUlza2R4R1NrZEhyY2NXQzdhL0NkVWRzVGNVM0FMMlZw?=
 =?utf-8?B?Unlyc2VicFZieTdhL1F3TTJnVmkvTjhFQktRaURsTWpqbHpXdjQrbmFmcTkw?=
 =?utf-8?B?MUM5UXVSR25LY3hOWSsxQ1RnSW5FNlRwZUdaaVNaTk95c1U3SENCYmt4Nkll?=
 =?utf-8?B?OFc1TmMrbWtBQ2htemF0ZUNWQkhod0pvbWJIY0RTMzBuZ0RreTNFcnRCcUhB?=
 =?utf-8?B?aG9SM1hzTzZEY2xMTTZZUWlJaWxCaDNtYnAwVGhFR2xkMTdGajVXbE03TGU4?=
 =?utf-8?B?TU9iV2NxRHJkWWlrTGRESElJSGdURWx2QlNUZkM3TVg4R0RzaUR5bFhqMWR4?=
 =?utf-8?B?b0ZVaFIwZkVjeWRwRHFWRmZPQWdNVitNZnZJb2NtSVB4N0NlMTRYeng3ZUlB?=
 =?utf-8?B?NmpsUlFPeHV5azhnYk5jbzRJM29Hc2JUa0F0T25zNlBsc2l6L2R4OUYxa3Ez?=
 =?utf-8?B?dS83OFFEV1VsZ3J3RUtEdGFBWjBiZGJJZ2JzNGNkMlY1YTg1WXFENHpPc1k4?=
 =?utf-8?B?VEV6bTVDWkNRdldhckNQRlAyV3I1M2w1UmtSKysxTUVPZnd3M3gyNTdRemth?=
 =?utf-8?B?aG9qWVdYWmZGUUNjMXZMQTNNT0pVdzlIMTUzRWlMQnk0R0lXRDFtU0JWTXJE?=
 =?utf-8?B?UmVmREoxN3h3U0I4Q0RjODEwdnAveEk3ckV3cklaTjY3TU1HV280LzYxZXM2?=
 =?utf-8?B?YU5LeXNxcDl4N01GUU9LcEI5QVBIN0RibW84RUtuQmd0RHdWUXA0bUEwZ2sz?=
 =?utf-8?B?cFRIREtxNkErVmhucUVaNU9xVTVOajZPUFh5WkhoSzhWVDJzcTNld0VPY2xx?=
 =?utf-8?B?K0Q3WjBWTDkveitwTmRjdURGQ1dlMU01SGtwaXYzZHpSbnJKS1o2MzRJek5h?=
 =?utf-8?B?TTRJUHdJYVRrOTExNDFUNzdmZlRob3U4eUNxN3FrVDRkbDNGS1piRjBwdUIz?=
 =?utf-8?B?NTcxTW4zdkd1WmRqNEZ1eXRkeEFsQTZpSjR2SUtkYi9jZ0FxNmlod3RYV2FR?=
 =?utf-8?B?a29CdG1ZdldQbDZRcUZ4U1dGWFZiaVVFWHFrMTV4RG1qNzY4ekh1S0ttWnVN?=
 =?utf-8?B?bGRhRk9wakpERnIrLzJqWnRudGdLR0ZlSGVRbVFRbWtFR1o1c3RDaU9BTjJh?=
 =?utf-8?B?MklEY2hUQVpMdDNFUHJKaUtDMVV3cU9nd1E4OGhsRnNiY1NVY1hZbDJvYVpU?=
 =?utf-8?B?R2MveFdoL1BVNCtCZlZIelJRSUNtbWsxbEpOaHV0TUNRb0ZwTDBjZHdQTU5o?=
 =?utf-8?B?VDdNMTJTVTh2UEdva0N1dTVjL203TEhVZERZVnY3M0pXYnlTLy83dlZxRDNB?=
 =?utf-8?B?cTdicFN3N0ZYZ1JYSnRhWUxtcktEeHJWMVdkZUVoWjI0K0dJS3hwYTFlRHBo?=
 =?utf-8?B?Tk9QZU1iRGQ1ZnFoT25mOXNlVUhaN242T1FONFExa21zZ0ZaUFVHNkVCdHdY?=
 =?utf-8?B?T2xJbDk0SWZoSEpBRmV0a2pGbVQ1K1VVNGZJUHpzUzlDdk4xZE1Zc0JLNUhk?=
 =?utf-8?B?OC95cUVWYi9CRGdaeWZoOGIvdnoxc1lDN05NQnpSM21DWWdlYm5ncDVUbXZF?=
 =?utf-8?B?akdlODJyYmdBT09MMjAyKzJQNUdNN0JOQ0xrQUw3WjJFdmd2WThQUm9qQjNv?=
 =?utf-8?B?TXFjb3Z5cS9MbVNoa01FK3E5K3VZL1FlNWRvMnZ0YlhJVllXOTROWjRsLzh1?=
 =?utf-8?B?MU9kUkVRWEpWSEJ4alVYeUlIakJFbTFac0N0WHc4VnBTRGpwQWxkbUpmTGRi?=
 =?utf-8?B?WlB5bHJLNmJjTUtaYUUxejFxRnh6ZzlVZ00xNzlmZ1dJTzVITEhtVFdiUmtR?=
 =?utf-8?B?ZzJDeVgzMERXbmdJVXc4eGc3eGE2ZkhoOGpPRDdaRnlPd3RqOVMrN1BRWGRZ?=
 =?utf-8?B?dFRMd09pdWNKbFlUNmdWVG9LTEN2VmpKM2lyS3V0L1RQdzh5V0FkTTdsL2V6?=
 =?utf-8?B?SkVYd3FIelI2ZExOUng1VzlOMFdqMkJrVVNKOE5aTzFEMDZ6dkk4RlRDZVhC?=
 =?utf-8?B?RTVpT0toZ0tFUm9rOTZOdmNGOUFnNmFPZ0ZVNWs4QlZKdjdWL295dlVlbG14?=
 =?utf-8?B?amYyeThVK2FjdDhhc3U3dXVrZ1BMUTM1bktHTEt1Si9BdVljak9MQUozWFVr?=
 =?utf-8?B?aDRoVzNJWHdDTjNRcnN4cXRSWXhWZm9QU1NCaytGdEVNaFpNZTdobnJSWER4?=
 =?utf-8?Q?cnxBf+K0FndKSSDc=3D?=
X-Exchange-RoutingPolicyChecked: rsJ4OpHQRBOY7ozG2N9GFHEwnlnnz7dgLiehkkRcJnZleDMkiMeESj4In+VvBOUCL+ebRuL07tLgj7WO576fWAGkq081HYgFdK8bWOh4pHXHD+nMRAOUKwORc7InVtOym5WJPJhsKAYbHC5W6olpYH6JlM1Ncb1+b7/2Wu0PLXdICu1I6w5Om7I/j71D95V6j6X+dK4Og8qM1FF2dl5Pz3UWPIPbkG/fkn6gUZ5BbR4QEs3OEFXUezcpUVmL1JziUJ43UZllCwtosSWLlK2tTgx1EdZCOdTg3PX7On39RHrp+yUfDVx09kZDRjN3T/NYQ386cXADfVYZdy1qaJuOlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 123fb44f-6913-41ce-1f28-08df46227e68
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:50:07.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twC0mECLroE3fKnnE2lCxOx9WIW1IPlaBOFixIwgpTrYQVQKA/jiWavceWj6GaSjh6lXBQME6Dk1a6rlGOf66PERAhfh79Oq2qu0f54oJFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
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

Summers, Stuart <stuart.summers@intel.com> wrote on śro [2026-lis-18 21:03:09 +0100]:
> On Wed, 2026-11-18 at 16:54 +0800, yaolu@kylinos.cn wrote:
> > From: Lu Yao <yaolu@kylinos.cn>
> > 
> > xe_lmtt_init() can fail, but gt_init_with_gt_forcewake() ignores its
> > return value. On a PF the probe then continues with a half-
> > initialized
> > LMTT: lmtt->pd is never set (and lmtt->ops is cleared), so
> > xe_lmtt_init_hw() returns early and the VF local memory is left
> > without
> > a translation directory while the driver still reports success.
> > 
> > Return the xe_lmtt_init() error and abort GT init instead, as
> > required
> > by the documented LMTT contract ("Any LMTT initialization failure
> > should block VFs enabling").
> > 
> > Fixes: b1d204058218 ("drm/xe/pf: Introduce Local Memory Translation
> > Table")
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> 
> I'm not an expert in this code, but it does look like if we tried to
> allocate memory here and that failed for some reason, causing the LMTT
> init to fail, it would cause downstream issues later in the PF's LMTT
> management. But the change as-is doesn't seem like the right approach
> here IMO. I don't think we want to kill the whole driver load because
> of this, it seems better to just log the error and not enumerate the
> VFs.
> 
> But it would be good to get feedback from Piotr/Satya here.

I agree with Stuart that, since LMTT is only necessary for creating VFs, we could simply
block the creation of VFs (and all operations related to SR-IOV).
It seems that switching back to native mode at this point is already too late.
Interrupting the driver's probe is definitely too radical an approach.

We could do something like this:

--- a/drivers/gpu/drm/xe/xe_lmtt.h
+++ b/drivers/gpu/drm/xe/xe_lmtt.h
@@
 #ifdef CONFIG_PCI_IOV
 int xe_lmtt_init(struct xe_lmtt *lmtt);
+bool xe_lmtt_is_ready(struct xe_lmtt *lmtt);
 void xe_lmtt_init_hw(struct xe_gt *gt);
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@
+/**
+ * xe_lmtt_is_ready() - Check if LMTT is ready to be used.
+ * @lmtt: the &xe_lmtt to check
+ *
+ * This function shall be called only by PF.
+ *
+ * Return: true if LMTT is not needed on this device or was successfully
+ *         initialized by xe_lmtt_init(), false otherwise.
+ */
+bool xe_lmtt_is_ready(struct xe_lmtt *lmtt)
+{
+	lmtt_assert(lmtt, IS_SRIOV_PF(lmtt_to_xe(lmtt)));
+
+	return !xe_device_has_lmtt(lmtt_to_xe(lmtt)) || lmtt->pd;
+}
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ static int gt_init_with_gt_forcewake(struct xe_gt *gt)
 	if (xe_gt_is_main_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
 		if (err)
 			return err;
-		if (IS_SRIOV_PF(gt_to_xe(gt)))
-			xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
+		if (IS_SRIOV_PF(gt_to_xe(gt))) {
+			err = xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
+			if (err)
+				xe_gt_sriov_err(gt, "Failed to initialize LMTT (%pe), VFs will be unavailable\n",
+						ERR_PTR(err));
+		}
 	}
--- a/drivers/gpu/drm/xe/xe_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
@@
+static int pf_check_lmtt(struct xe_device *xe)
+{
+	struct xe_tile *tile;
+	unsigned int id;
+
+	for_each_tile(tile, xe, id)
+		if (!xe_lmtt_is_ready(&tile->sriov.pf.lmtt))
+			return -ENODEV;
+
+	return 0;
+}
+
 int xe_sriov_pf_wait_ready(struct xe_device *xe)
 {
 	struct xe_gt *gt;
 	unsigned int id;
 	int err;
 
 	if (xe_wedged(xe))
 		return -ECANCELED;
 
+	err = pf_check_lmtt(xe);
+	if (err)
+		return err;
+
 	for_each_gt(gt, xe, id) {

Thanks
Piotr

> 
> Thanks,
> Stuart
> 
> > ---
> >  drivers/gpu/drm/xe/xe_gt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> > index 286aee5775c0..1239cbb7c84c 100644
> > --- a/drivers/gpu/drm/xe/xe_gt.c
> > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > @@ -582,10 +582,10 @@ static int gt_init_with_gt_forcewake(struct
> > xe_gt *gt)
> >  
> >         if (xe_gt_is_main_type(gt)) {
> >                 err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
> > +               if (!err && IS_SRIOV_PF(gt_to_xe(gt)))
> > +                       err = xe_lmtt_init(&gt_to_tile(gt)-
> > >sriov.pf.lmtt);
> >                 if (err)
> >                         return err;
> > -               if (IS_SRIOV_PF(gt_to_xe(gt)))
> > -                       xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
> >         }
> >  
> >         /* Enable per hw engine IRQs */
> 

-- 
