Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1D606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z5c4wguB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CD110F9C1;
	Wed, 28 Oct 2026 05:58:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC8410E587;
 Wed, 28 Oct 2026 05:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793167116; x=1824703116;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=6XH867qRgmeEYiYrqQXBhyc1bS2asaDZ5sj8S1+t+p0=;
 b=Z5c4wguBMtEwnYfqmB8UWzYXcO+yUxclgH6GNLTjsgJ1cIP7mWNQbl03
 Hn/Vgdaclh+5oXYq7bE6znNUIdlphEIBatA2uYh5u6bksYNXjPjy80Qd5
 Bl8/DS6gEIaEN3UWKHjJ+FMiFHteLTVfihvzZIBTYluxkikk4xap0FowU
 19gfhBSI25B/OwGGB17BVTcew7RsVOQNgKWRRZGOfvRyz3I6Wa05cSgwF
 S+91s0uCAMEPOz0wsmhUBW1LpGm2xMDPaQqndinaz2GvJTvxBPZs1Jc1J
 50ELQiO5orabIzg/pkjRh+vtRCeHNhJh7RBsa1RDOyErxkUiHhXOhqaGe Q==;
X-CSE-ConnectionGUID: fuyzoWS9ThWQEJ0wMb4hgw==
X-CSE-MsgGUID: QcMDdPpQQ72nFsy0M0H4BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1763409"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; d="scan'208,217";a="1763409"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 22:58:36 -0700
X-CSE-ConnectionGUID: +mBvJXygTnSfeuG/Hhbcyg==
X-CSE-MsgGUID: 171t956RTym6k+6lNONWYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; d="scan'208,217";a="4767218"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 22:58:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 27 Oct 2026 22:58:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 22:58:35 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 22:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXybYp9wSHTZCjsxFj8uo/1audCG7vst2RerIeaVO7tUR5dkZWAcMcf1BmWs0uj1Q4Bc3J7wVZen0y2C9oybLS+dPDkZDsDflFu9MXeXriJMak8QVt7IyWzub60EacY+7KqFbojTJ2uK1uQmQ08JrpK5yo4seFtrhtz0O1LqVuKWw1MbeRTswqpZ4x7jtYHMi3k6MKOAQhUejibDvKH9dpk/dl4IEJHNbmgOtimiU5XKwz1KQCx4/FDRxw79+1U+uu/Ic2sNHy6dJjBsUj2cMFWU8I1uVMslGCvDofYqVGoBDK3/QK0XvBUIeqojrkixVjsTRpgmXuYxujsvJmsASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb6BcIUe7lo2c5MRyNXuS2XZjuPoSp72FHURWzLXpkA=;
 b=nPyWh/zqyb+vXhpUIaFQyie6ITvd7wYm0gavSH8Fj71tsCIpIZXCS14QWArClwETj1YHfwBXk5u1YnHs3qxl+VMjQXnbGFtYQsrexsB/+/wi2jXoQybjtXLECoqJt6OFbhSC1I0DPPWt/oWyX7kpuJArvKC4a/yxv9eDo8jtaQf2AJcfXu4hghxWTqaFZD+UWHE3r5/1DutU7n3jewU8ZjL/OsUyHihnhtyOTtzaQ5xp51MQZY8LwsOgX217bbfD/o7t+AQ/1ieQJQAJ6QARRrspccD6VY7klafI/ShAFwKKypxoitpJID1sWdbAxyW/pto/AJFm1eCAO4HAcOsZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18)
 by CH3PR11MB403477.namprd11.prod.outlook.com (2603:10b6:610:366::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 05:58:31 +0000
Received: from IA1PR11MB6468.namprd11.prod.outlook.com
 ([fe80::c69b:dedf:a089:33e5]) by IA1PR11MB6468.namprd11.prod.outlook.com
 ([fe80::c69b:dedf:a089:33e5%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:58:31 +0000
Content-Type: multipart/alternative;
 boundary="------------1sa6Zxn7YjZZgWehqDCrtaRX"
Message-ID: <67d8f0f9-6800-4f2e-80a1-3450c58a61d3@intel.com>
Date: Wed, 28 Oct 2026 11:28:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/guc: Add WA 14028709524 to disable PRL from VF
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Daniele Ceraolo Spurio
 <daniele.ceraolospurio@intel.com>
References: <20261027225932.337738-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20261027225932.337738-2-alan.previn.teres.alexis@intel.com>
X-ClientProxiedBy: MA5P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::14) To IA1PR11MB6468.namprd11.prod.outlook.com
 (2603:10b6:208:3a4::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6468:EE_|CH3PR11MB403477:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3d081c-6498-445f-d2f8-08df34b87e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: uIQ7rn4uqqZpxl8G+uARpQNDX0aCKJK5w1+smBSm91rnUsQldSFlphGbiumwLwgOrOFZcuV8tniWgiXz2jrQc0dq6iwd7T17hR0A106DlQmNNYiqPVlO30DGHHG8qczcY6CdLB7Hy4SWe2bj5L+kzNyHH5M6niEVP4XikG5qRU/x9ymo19hB9JzjRaJ+odXQQCiV1E/Am9qK9NEb45X/SVPsWNYYelL1eyg0rqUCG+4JPbuEB4uK6/q4zMgVJYyPD2lVTZoP6Jyge6H/T2Y+2/O2ciX6HRWfH2zaL7VXhqxxPDERVQtVazjYU++eRHTgo12z9xlICsdHVZNWFVpwidAAXj+1ZDMLpIyKljqi1m05ekR4HzbRkEWR6kCsdm5rjKHivQuE2wKSBxGcQ8QYpAjs/kbN3PJ4rK9LwRu0+yBcw+EXOF/epjc21xvzCnrS9/dtkYW3IpCLGzIaK599pRQJGpDspW+fXwSOrkfnem5xuFjwsVqqjVxriUyh9/2mAnYYQDq1w9KPXA0tRT8a+0fIzZW1CESdg1qIMlD9wGG8yulnW/g1A3nUIk7NlMQ3OcxQijdpFdOZJ3MFSsMOZH+DmXM4jKlazgUI3b1CSYStxrSb454fI2NAYBotYGn36t39xBTgduiFxsMgpQt/bb9TNdhn0GnZjBfwv43tLBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6468.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUdwdGdLeVhPclh2YVh6QXR5RXExTDYzR0pIWDBZMDkxTnNqUDBOKzJJbUh4?=
 =?utf-8?B?cEJTRHd4cjlmVHlla1BGMzhOeGFwd0tSN1BUc0NHR1R1dUlFRXYrWXE3YTRn?=
 =?utf-8?B?eEltTHo1TnB3WWJ5Z1BieFphSTkxZWxzeTZWOUc5S1ZDYkYxT0pPbktwN0Uv?=
 =?utf-8?B?a01FUXo0Z1l5djhBMlJ1T1pPSGxJSGRqa0d0NTVraForc2VQc3pPQ1JhRzZR?=
 =?utf-8?B?c1FGdjhwRWs3MHRqVVNVdmtUQTRIdktXaXEreGdmempheU45eExLNGhPKzhh?=
 =?utf-8?B?ZWtxUSt6YkhCS3NsZ1RKeGE0YVY4MUxlVGhIM1JFekNVQWxQbGtDcC9iNFp2?=
 =?utf-8?B?ci9uNzl1aHkxRHNVejhPenFkalZYM0F4dDYyTTR0QisxWURuOVA2NXRQMHNk?=
 =?utf-8?B?dSt1WUE1WTh6R2tMOXBYVmc2SUtzTjBQR1FrSGNrb3NML1NvdFI2ZGV5YTI3?=
 =?utf-8?B?SHl4YUFVZXdFWWFQYWF2c0luOGk0NVdVY295eGQ3OXVuM0dCZTRoOXo1VS93?=
 =?utf-8?B?RzRBeXBYMXRHUUpobnM5UDR4ZDdmU0hyWG9iYjdoQVlwTzhCM1IvV1FmNWN2?=
 =?utf-8?B?bnJydGxtYitIZ3BEWnBBbWNVRWF4Y0s5Ym96Z3ExOVAwSnlaWnFPT1F6UjAv?=
 =?utf-8?B?ZVZwNXZrMDVEbHdNZUtYakJBMUQ3aStGa0RMdU5VUXFITGdDZmtxUlZIQXJh?=
 =?utf-8?B?d0NkS29nMkhOK1FXOXpKUFU2RlhYc213UXlzMnJVUGlkczNob0RGVVd6d2RK?=
 =?utf-8?B?NlZsQ1VGbmtiTUhoeTFMblVvNnorNHJqanA3YmhsNVN6aWJlQlIySUJaZ05J?=
 =?utf-8?B?aHBLMk5TY0szcHVCbzhVZ2s0bVBNT2tEYmdObDlPU011MlM0aUNuK1dVZlZJ?=
 =?utf-8?B?TUlRUmtWVEFFZzg1dlJvb29GR0NZN2NPbkpqLyt5b2tDU3hRNDRNVU5aN0p1?=
 =?utf-8?B?cUFkMGtZTW9XY1VxSGF3WHVVYWd2Q3NwOXlDZ0lTUUNaNHhLNXNwSlNTVUJT?=
 =?utf-8?B?czRxM2U2dGxwSFNuNkd3Ym1vZ3pPRmhHeS9sdGU5RUo2MkNZcjR0aXplQXJQ?=
 =?utf-8?B?K2dPSG5PdnhHWWV2QUFQSy82YjZiaTJDc1J6WS9HZE5NQklnZElEN3VoTnor?=
 =?utf-8?B?QktMdnlISW53aDI3d29sZW5Pb3AraDRJUGY3cHlzVnpsOW5rc1ZiQ3hNWkNT?=
 =?utf-8?B?eFRuNXBFR2hNb05YaE9LaGx3ZFhuRTNWNlQyTWhSSSsxT2RVZmhJSEZ5RGdN?=
 =?utf-8?B?NDYySm4xeDBYSUxJVlVaWkFBWWhtdVp0YW9LZVlsaWRPZmwzazk4UXcvMm5O?=
 =?utf-8?B?K1dqZlRNbVR6RFIvYlFxYjh4d2hwYWh1K1d5ODVHZ0RkbFZ2YjgraTgwL2hm?=
 =?utf-8?B?c1hXMC9STjNQamdXUDlyeWwwaEdkNnVOSWNZaW4vdUsrbm42RWQrUGd2RENV?=
 =?utf-8?B?QjNzR05rZXlwempYMkZaeklZbFlrSXdwNWhuTWt5K2Z3Q1JnemZyclFESjJp?=
 =?utf-8?B?TlVpSytrMmQ0bWpHMlFiUGlUV3hBbDhjanp3V1RURG1FR3YzdkZ0TEZIZmZ4?=
 =?utf-8?B?NmdmNHFNYjFPUk16RlhHTEN5MlFlVGVVZnFzUkk2MVZmcjkrYXJ5SHdRamtT?=
 =?utf-8?B?OEYzemthdmNlUEYxMTJkd1NkeHV1RFJhSWJwSnhjVW5yNHQrZW1CY2pyV24v?=
 =?utf-8?B?aUhaN2NsemNVRHA1QVFST0tjc2htTDN4eDZKNVBaRGh4dlRxYzBmeC90ckdX?=
 =?utf-8?B?M2FoUGN2WU1yWmhPMkF0RmZieXlpWTMwMWxnaXRSTVJ1V3FibWtxbE5vT2k3?=
 =?utf-8?B?TjdudFB0YTFmdTRIMXNqTExsYWdFd1ZNZ0ozSHR3SGVKVXJJVlpzdHFmYTRY?=
 =?utf-8?B?NFpWeDBVa1A0WVNaQy92MjVERXFQNXNDUjM0Nk9TTEVxSXdzbVo5ZDZPeG5W?=
 =?utf-8?B?OENFMExXN2NlMVhuRGo5ZUQ4SHA0R09jSFY2S0hzNHN4akF3QW5TNldiVkhS?=
 =?utf-8?B?cXovZzBFWlpEQlFycjhaOUhCc3ZSb0dCakFnem1WL1VuRXM4YURMdCt2S1BY?=
 =?utf-8?B?L20wVEZEbmhmRUZTaFNyNkdLdWE1ek5hcWdIQzY4OEo1L29xQ2w0dmRPTDV3?=
 =?utf-8?B?TUQ1TmJvSnk1NTh3WEhPUXZteGxWRndSRmVzVm1ITkl1dGFxVCtWbWJJdStx?=
 =?utf-8?B?RThraXNsa0E1SGppSlpNb1dtNnIzSFE4R2lmOWRSUGFQa2QrajdXcXBQdFZE?=
 =?utf-8?B?MjdKZVNsZk5lYm5ZZVkwQ1lhTUM4Zmtsc0hwTE5pcXVaMzFaYVpVMHBjQXNy?=
 =?utf-8?B?d1NFemtzT0pOR0tpeFpES0VQamxFemliNGRFMldPeDdwSlA4R2tyLzc0Qm9Y?=
 =?utf-8?Q?/aZyw2CVvivJM8Jo=3D?=
X-Exchange-RoutingPolicyChecked: wCSfTdnF4WJZpRL7WY8vExopHVAInuJfpvev/qZUuTzE8hjyrUDVdBjGk7X8u6cAlgXdpITD7NTvtw0ojcxhqUtInUvIWBvECBLzHx3iIS8n+0buXfw+u+7un1Hnivi3BAxXXcsTc9j9yj07LILaMebu2YYcW0dKZhA7m46IcJ4f9X9gp7PDjZGO5+Mr5NVO4wHRlUjfTwnfndIchRqMEgyyjhZUBv6ZMUf5VkzjVYoEHYFIe+VQqeM5L43gPz1uLcgQnWRp+knZ0xq6IeevFt8OpNsLzwhq0zZ0FIT6isThXbPqKa4QA2Dn2AidBkOdf9IJV+N1jEaf64nsGYViZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d081c-6498-445f-d2f8-08df34b87e8f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6468.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 05:58:31.5768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3ACkviUiXsHbbpM0ni5NE5JjEWP3D4HMKnwHw7iLem6H3Vmd3NzCMY1nrKDxLoC70CB+0BcDMidCfjP5wj2shg1JsTYKVar5mAyD3nGerE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB403477
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------1sa6Zxn7YjZZgWehqDCrtaRX
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 28-Oct-26 4:29 AM, Alan Previn wrote:
> For NVL-P, hardware and firmware support for Page Reclaim
> List assistance is disabled when running in VF mode.
>
> Signed-off-by: Alan Previn<alan.previn.teres.alexis@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_guc.c        | 8 ++++++--
>   drivers/gpu/drm/xe/xe_wa_oob.rules | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index b1f4e132fa0c..613ea9b073c8 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -795,8 +795,12 @@ int xe_guc_init(struct xe_guc *guc)
>   	if (!xe_uc_fw_is_enabled(&guc->fw))
>   		return 0;
>   
> -	/* Disable page reclaim if GuC FW does not support */
> -	if (GUC_SUBMIT_VER(guc) < MAKE_GUC_VER(1, 14, 0))
> +	/*
> +	 * Disable page reclaim hw assist if GuC FW does not support it
> +	 * yet or a hw WA requires disabling it in VF mode.
> +	 */
> +	if (GUC_SUBMIT_VER(guc) < MAKE_GUC_VER(1, 14, 0) ||
> +	    (IS_SRIOV_VF(xe) && XE_GT_WA(gt, 14028709524)))
>   		xe->info.has_page_reclaim_hw_assist = false;
>   
>   	/* Disable indirect_ring_state if missing GuC 70.53+ WA 14025515070. */
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index 63d695f40214..2971dd5b372c 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -76,3 +76,4 @@
>   14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
>   		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
>   16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
> +14028709524	GRAPHICS_VERSION(3510)
>
> base-commit: adaeb3881f12295309596acf2387c3f00b3050bb

LGTM.

Acked-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>

--------------1sa6Zxn7YjZZgWehqDCrtaRX
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 28-Oct-26 4:29 AM, Alan Previn
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261027225932.337738-2-alan.previn.teres.alexis@intel.com">
      <pre wrap="" class="moz-quote-pre">For NVL-P, hardware and firmware support for Page Reclaim
List assistance is disabled when running in VF mode.

Signed-off-by: Alan Previn <a class="moz-txt-link-rfc2396E" href="mailto:alan.previn.teres.alexis@intel.com">&lt;alan.previn.teres.alexis@intel.com&gt;</a>
---
 drivers/gpu/drm/xe/xe_guc.c        | 8 ++++++--
 drivers/gpu/drm/xe/xe_wa_oob.rules | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index b1f4e132fa0c..613ea9b073c8 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -795,8 +795,12 @@ int xe_guc_init(struct xe_guc *guc)
 	if (!xe_uc_fw_is_enabled(&amp;guc-&gt;fw))
 		return 0;
 
-	/* Disable page reclaim if GuC FW does not support */
-	if (GUC_SUBMIT_VER(guc) &lt; MAKE_GUC_VER(1, 14, 0))
+	/*
+	 * Disable page reclaim hw assist if GuC FW does not support it
+	 * yet or a hw WA requires disabling it in VF mode.
+	 */
+	if (GUC_SUBMIT_VER(guc) &lt; MAKE_GUC_VER(1, 14, 0) ||
+	    (IS_SRIOV_VF(xe) &amp;&amp; XE_GT_WA(gt, 14028709524)))
 		xe-&gt;info.has_page_reclaim_hw_assist = false;
 
 	/* Disable indirect_ring_state if missing GuC 70.53+ WA 14025515070. */
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 63d695f40214..2971dd5b372c 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -76,3 +76,4 @@
 14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
 		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
 16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
+14028709524	GRAPHICS_VERSION(3510)

base-commit: adaeb3881f12295309596acf2387c3f00b3050bb</pre>
    </blockquote>
    <p>LGTM.</p>
    <p><span style="color:black">Acked-by: Satyanarayana K V P
        <a class="moz-txt-link-rfc2396E" href="mailto:satyanarayana.k.v.p@intel.com">&lt;satyanarayana.k.v.p@intel.com&gt;</a></span></p>
    <blockquote type="cite" cite="mid:20261027225932.337738-2-alan.previn.teres.alexis@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------1sa6Zxn7YjZZgWehqDCrtaRX--
