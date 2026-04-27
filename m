Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB35AFF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F51210E996;
	Mon, 27 Apr 2026 22:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YhPQpl9S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED5610E996
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777330410; x=1808866410;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Hd00HnQQiFwaHZT6klG/7+tMjfh7JqWem2sgRYZuZww=;
 b=YhPQpl9SixTzSvdQ5E0LRGThkcdbWjXFD0cPFP2RHL6RC7Ze+nTyZbZg
 bJjRVg5XXG7DHUkayVrsTCbzmHC69wppIPOhvm0risqmnPHoSKIrG0zqL
 NIdubXcBQoO1EeeklJDi96swXD5oSiumTYGy+7F3vFzKcWjpZ5XIUKouM
 1hvxP1io1C4F0pxp+dHx5o/f4E+mBT2N6d85D+mrwZu6St9wfIZKxa1YU
 lJkwmqDngcsbnQa2yIEeqQoodknqR90uWcj6KmCRsIfbwDw0dLRtE2o5o
 ooZMJ4T8t6oadeyH80AS5g/q8cJ4vP+81nq3E37k4lD7KWT0gLU1nruTo A==;
X-CSE-ConnectionGUID: l5N/64SESOKoCnlIvHaX0Q==
X-CSE-MsgGUID: D/U97TmfSWSl25ZNsLdlbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88543492"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="88543492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 15:53:29 -0700
X-CSE-ConnectionGUID: GEhxaSbYRU6vnlCjLa7dPw==
X-CSE-MsgGUID: EOzcvJhVQk6nL6EpgSEnHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="264169716"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 15:53:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 15:53:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 15:53:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 15:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9ZJ4IMV+Dqppp2pip1l8o50p9Td96vskBqDyYoAzt83pMMxT85LoKMj4cNtVAhtWmo19v8VRPGdE+z8RkClDJsENDI1/FlYnm+Z5RfqWbezg8IswBsd8bi96e7NtkSuSqLoZhzr8VOk7+WdbrAQVSQZg/422u+FkeWFa0+NJkWufQ7dN1t8HI+6B2PW5lft55K/aQTvn6Wb+n+iJ7LqD73N7grBpW5X4BJaZoinKdFFnX74NIXSHiTqih2Uc7fJWk8OnBTe9Ge4HeB/RyDa7+AOsL3APiY9q1hnF9AD+bXhhI6S6tuaBDkCLTojLlsX5S50gqZPsryMcU5UQtV7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7WRZsHjSVYQwSz1sKW+08+Y0wDe3g6/1TdLusdpofI=;
 b=N8m/7WLnoINVRkDKA1KVVJMQ61LN1pIR+wQAY65UixuLsLf8nFAhZB2PCyqVChcbgbYhqibBy6HoJ5sHweashBHRkwDwjT4LzYwH5ZnHqnhzAAeATVM5tkYymwY3gDuMDBeeF6gCSIlhReGzLps7+saQj0ls3j5uWV0mRCKc/E0DsErn1Gu5vc4tf34OE9ozHel87AV4RfAN2TV5L6y729VB84yPTxDnV3CG+nyMKo+QT/JAq/OsHU0fRPMG/zcN3i8Wm38cyOM+zNR+RVilbBpTvduwNuM06pSBskRk1gjuKk0PPiaSBLpstH+Tjk7BUlvbdkivt+F6ZrqSSvi8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by PH3PPF7A88A980A.namprd11.prod.outlook.com (2603:10b6:518:1::d32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 22:53:18 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 22:53:18 +0000
Message-ID: <174f2602-ee3b-4cba-b757-47c44e0fb10a@intel.com>
Date: Mon, 27 Apr 2026 15:53:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Thomas Zimmermann <tzimmermann@suse.de>, Jocelyn Falempe
 <jfalempe@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
 <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|PH3PPF7A88A980A:EE_
X-MS-Office365-Filtering-Correlation-Id: b825442f-8586-42fd-7829-08dea4afc5c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|14066099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sN9Fyw5Bi5L3GEVhEQn+uwvJ0JID5djRN8CADVtwedgzS3FSXDacdlaTZ2Or9bPJpcLGK7+E+098/bY03RATlb9+Hor4NtYHLuBB/vm3GPxrPy/ITBpOySmRB3KchM9nEJo0zw2Lcy/lGsokmPWk17xqEiajWdHT9HPI0OvfG+nyHYTofEQ3nxCiI4hsAVKi5/lr5FaawbBE6gIj5zzjwo5myMOI++vXwPIuoCO1E2HgWIW9278QK4y5ratTOYkKJhiTVGDIfI4a6osCGBKIK0xmjgc5Mk0ighIafn6bHuSIhTkn5zENlIxRa7luE3dZDpFfuLPzkqNllublyiRJBOPNuDoNa4anXpkGeQZXzuZkPYce0E94pGhpuaqa4f84VetWX0jJLkNZUCjs07lesSCzi+beKUtbMWlenRYHDFr/SpkaTUfRnLL0Co+pi4l2cihv3gakbqFlvgA2KxSxxkPGNnFvzYRRAZltGgNvt/iWn2h09FZFTjwYbgscFPtb0nX0hQbAPUjmQ6js1VoXttNpg+ob4rkXRk48+Sub7y4h+UI1WatgmrQfZgmayWtdabNxoxWIJcWVnLC38H+I6ofQstAf54XxF3s4B2PHHK2ijsDFVoBhKLwayhzT7CXZwOFZzKgFeS/cKJMvivx+A8PlIrnaj9L51jsA36pMWs5RjRshDEHwEQwUMDpiDRvi5MyRJnbOiTxl6gflxUcoosmL2hupNHQlIaTE0rQpKwy3VJYmcJehXdWmInRVxBjQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7588.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(14066099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BwSFkwZm1sakR3QVBHbG9xV2s1R0JqalI5am04Tm1vVVJqbk1BUitKcmsy?=
 =?utf-8?B?Yk14bU5WWjd2QVZLYWZubkJRQ1RwYTJSdldjR1pIMzVMaDAyRE5oZ3dDUWU0?=
 =?utf-8?B?SnRuY2FSMXQzOFpFUlVhZkFSbVZqU3VkSFFLYlVsVVRyVzBYTHR2WUg5SGtM?=
 =?utf-8?B?SkdsVVdjUlZNS1B2WUYrQUJWQnNZUTF5dnEwMFpMMFc5QUNuS2xNQU9CZG14?=
 =?utf-8?B?Vng0cHVXM0ZVUmVkMmpOcnBpRm9oeld0dDVsYWFrUXlmWk5paVpMSVVINmd5?=
 =?utf-8?B?WU9VMk8yUnBJQ05WS01VOFpSTDExZXBzb3hvT3haaTF1Ym5SMWRMVCt6NzdN?=
 =?utf-8?B?Mzd1eGhYcGQ3d2ZyK2crMGxlMFB0alBDa2FRWCtrYjJDRloyeWNxRy9CUFd4?=
 =?utf-8?B?djlJWnpQd3lnaEJNWVBzUlVMajE2QkNVa01kNGoxSEJrc0xMVHBvSTRSTVVj?=
 =?utf-8?B?UU9ENCtlWFcvR28zZ0lRdkxLK1BvdkxFZHRLT3NZeldJM0ZWbVFpbUZBalNP?=
 =?utf-8?B?amdlN0RUaE9uOHlVUnZyOUZzdUF3cWkxQU1heVAzSWZXdzdmRHBSSXNxWHJ4?=
 =?utf-8?B?YnBGUGtCMVkrSExVdlBseDJJUVlvNnA1SmNmcGpmM05JN3V6L2k0OVlWRnd0?=
 =?utf-8?B?OFVPMXpjNFh0SW94YTZSNFFzNGRXRlFheWdkQzRVWjUxRWs5MUJqZTNqZTVs?=
 =?utf-8?B?N3duNldOQjkvUENFcWZjd09UK1gzbGVwdHJ4eHR4dGhvZ0luMUI5TUNkSksx?=
 =?utf-8?B?S3ZjRnlBYnJqSzlYSGM1TVY1cFFzbTF2M1JhYjd0Q21sTjhidTlFcGE2ZHN1?=
 =?utf-8?B?VWVrOFRYM0pkZ1VRVUFCK3JVQ3k1ZWpTcngzMkE0TTROTEZJdS9QS1Z6eGZ5?=
 =?utf-8?B?cDYzZmIyU0RFVkJhc0ovWWhkblNiWUlkRDVOSzFnYkdjRWtzZm1WeVRWVm1u?=
 =?utf-8?B?Yml3TFN6b01DZEhTY2ZLYVNqMnlOVUJlMnJVRWt0WXhoYlZMeU1WanNUUENQ?=
 =?utf-8?B?NlBMSTV3ZkRyM2xTNmdNc0lJYTUrdnpGUW9ubVpUT0dpM1BXM0xickpMYTg5?=
 =?utf-8?B?cGlmMktKTFpvd21ESHVoMnBCRmZGdjlRYUZ0aHU1MWN3Uk1xaDJCeUg2T2lp?=
 =?utf-8?B?NXVoeWJwUnVHNTZWTTlzdC9HWURKSVpPK3hPWnpiaG1KV2R6SHJLNTVhN1Iw?=
 =?utf-8?B?SzFIRlFkejhxV2pRVnhGS3RmVHlFRnk3UThqWHgycXdnRCtWY0JIR2RqekdF?=
 =?utf-8?B?M1RDeGt3eWcyYzQvV05LZzlzeWFvWTh0M0hmY2RJR0R2RUFjWHJVR2lqMUVD?=
 =?utf-8?B?aXVDTG43OUdYeFdxdS9sM2NTRzNhMmJWRnlkQ0xKSjlDMnVUckFza1luQmlZ?=
 =?utf-8?B?Mnp6Y2xOYXlUUjVaSENpSTFaWnM1NHlaRytNcDhBd3IyNGxOZlowOHlXMElS?=
 =?utf-8?B?ZUlvVFQ1aldlSUxGQUFLZVBmWGM5Zk5VcGJmVlZrdWV4L3o0dDBaK0NsaGRZ?=
 =?utf-8?B?SjFENURVMkk2YVRJQzd4RXNnR2orTjdKMXVDQnRVV05scHc0Mi9ia05zcC9G?=
 =?utf-8?B?RURVQVBqLzZrc1V3SFJ5Q1dBNXFOREw5bTd6dSs3aVN5aHFQSk5jSXZFczk3?=
 =?utf-8?B?eVFNNlNXL1Rib29nN3o0cmd3aUdXRTd2REdjNVZVSVBYRkdITDJJSncvRVVV?=
 =?utf-8?B?M0dOTkY1dXhrQlBUYS9HMFNqaCtnMUpiVTI5VGVmeVk2Wk9HWXRrZW9wUjFx?=
 =?utf-8?B?UVRualRuay9iQVJDNEVqZmV6L2N6cVhSbHMybk90cHVwNkRMY055dDBQbEEr?=
 =?utf-8?B?TmhvQVJib25YRWUvNFo2Q0Y2ZGhSY2tBR1NpSUh5cGh2VGc0Q3AyRnRsZ1BW?=
 =?utf-8?B?MmVZcHIvci9aTDBNR1ZsTmF5N09rYkkydVlqUTdzeDYzREZkRm01VWNoUytP?=
 =?utf-8?B?M0ZGK3RHWGxpdlp5citxQkRHTm1qTXhxVUJoelZMWHBlYlV3OHpKaGtDZGtl?=
 =?utf-8?B?emp5Y05uZUd1K25VM2FFckNTM2JuUjVmREg4MzVObkw4UFMyVy9GR2ZjelR5?=
 =?utf-8?B?QWhHRUFMVmlFZlVwQkoySVFoWDVzRXRRYkNmMmNiclBRMjNmMCtGWFRVL0wy?=
 =?utf-8?B?NmYvUGVXQTdZRWg4ODFqT3lhV1FCc1UzMlJnLzBQejlKNDJ6Um9JUGM5RzZk?=
 =?utf-8?B?WC95RTRybTNDTUVvUjhkQkdlVDM3azZpS1NLQUNnNFRRR2JYYThoY0VMR3Qy?=
 =?utf-8?B?UnRQWXhlbGV5ZUQvbzEySENHZmJRZXFDTjhLbnlEQllFV1NFc1Y1STdtR1Er?=
 =?utf-8?B?RVJUTFpwZGt3blJKRmhMMkhFSjdLZCtGZERFbU9ocHNrZitEZnpiZz09?=
X-Exchange-RoutingPolicyChecked: Zy9ZkCLyT+4SQm5cab2YpUAHfdb6qR0+2GNHxeI2MieN6HX4ft09m7SZij+eGMfpCGK3gWF7FFCxNHw5lszXA+fC+H71K89jWuryDjsQbnH0rUbXTe2nIupubC6OCeWplZjCvn4CM9yvZQbTy72tsZUYX//0R5mFrmsWOdlUnJZ5/L2hO/qjrcCyjbxTsXv6pxFCz3Hwao1WfzPbSEV6kgnhs5ooGy2LehajvrWOMms4Pkh8r+rSxTDdaGcnJ6k6bkL85NYdAwzU9T1sz8N5wyJX1j5JJU+Bj8ZdRDwZq3w+L4T8YSBv0mWzBcDCmRSkLVsYWK7eTpy9OPFG/8bqpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b825442f-8586-42fd-7829-08dea4afc5c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 22:53:17.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk/vMuc6C5FNWJ+uEyG0m9UCEDriB8LADo5vpbMLGUWsmvIMVRsPfAKOpPSTTFdGtHcFZ89YfOO2xl5f8vD9uwV1qo5txA19/zB1X1Q5aIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7A88A980A
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

On 4/27/2026 5:14 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.04.26 um 01:29 schrieb Jacob Keller:
> [...]
>>>
>>> So I suggest to pick Manufacturer, Product, Version as key. I'd be
>>> surprised if we find more than a hand full of systems with the issue. If
>>> we see a trend or common pattern, we can generalize later on.
>>>
>> I think this is the best solution. Keep it focused for now. I believe
>> Intel has two major platforms that we care about with respect to this
>> issue. I'll see if I can dig up the data. The systems install the MGA
>> G200 for BMC use but don't seem to expose the VGA connection.
>>
>> For the specific system I have that was faulty, we have the following:
>>
>> $ for t in system-manufacturer system-product-name system-version ; \
>>      do dmidecode -s ${t}; \
>> done
>> Dell Inc.
>> PowerEdge XR8720t
>> Not Specified
>>
>>
>>
>> I believe there was also some concern about HP systems which similarly
>> use this chipset, but I don't have the DMI data for that one off hand.
>> I've asked some colleagues to confirm the situation and obtain that
>> data. I'll get back early next week if we think there are any other
>> systems possibly affected.
>>
>> In the mean time, I'm happy to have our team test any patch to confirm
>> that it behaves as expected and resolves the service interruptions.
> 
> For now, I've modified the two places that have BMC support in the
> driver. Could you please also tell me your system's exact Matrox chipset
> or its PCI id?
> 

Here's the lspci output:

> 
> b5:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. Integrated Matrox G200eW3 Graphics Controller [102b:0536] (rev 08) (prog-if 00 [VGA controller])
>         DeviceName: Embedded Video
>         Subsystem: Dell Integrated Matrox G200eW3 Graphics Controller [1028:0d38]
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 16
>         NUMA node: 0
>         IOMMU group: 16
>         Region 0: Memory at e5000000 (32-bit, prefetchable) [size=16M]
>         Region 1: Memory at e6810000 (32-bit, non-prefetchable) [size=16K]
>         Region 2: Memory at e6000000 (32-bit, non-prefetchable) [size=8M]
>         Capabilities: [dc] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: mgag200
>         Kernel modules: mgag200

The device ID looks to be 0x0536, and the subdevice ID is Dell 0x0D38. I
don't see anything specifically related to mini display port. It is
plausible there is an encoder between that output and the G200eW3.

> The patch is attached for your testing. It would work against drm-tip or
> v7.1-rc1.
> 

I'll give it a shot.

> I've also found the page at [1], which claims that there's a Mini-DP
> port at the front. If so, I'd assume that there's also an extra encoder
> chip to replace the VGA. If we ever get specs for that, we could
> implement real support in the driver.
> 

There does appear to be a mini display port cable. I am not certain if
that is driven from the Matrox graphics or not, but looking at lspci
there doesn't appear to be any other graphics chipset on the system, so
you might be right, but I am not certain.

> In the meantime, the current fix should work. In the worst case, that
> Mini-DP port would give a lower default resolution.
> 

I can check the behavior of the mini-DP output too and see if this
changes anything for it.

> [1] https://www.dell.com/en-us/shop/ipovw/poweredge-xr8720t?
> hve=shop+now#techspecs_section
> 
> Best regards
> Thomas
> 
> 
> 
> 
>>
>> Appreciate all the feedback on this thread.
>>
>> Thanks,
>> Jake
> 

