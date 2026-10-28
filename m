Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F7606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8egOf9M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0569510E68B;
	Wed, 28 Oct 2026 20:44:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2047610E4EB;
 Wed, 28 Oct 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793220287; x=1824756287;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xlUmiM+wjSrTYr3Zy0cHpHUITViD3jdMinVtS074yeU=;
 b=L8egOf9MUHqB0Z2tNontgopRsDVBd4yeXYGtXRCFB+H7o7aRffrj+RZW
 QIcJbRR1CAzHvr6e6bR3II78KQJAR/sBFL024XlqmDzSxhUF69nrGr5o4
 oaFVgQcPPpolj8JZBSTP96gDjxpksa4Xg9grJOKIbh5Sg0C5uUCtMmoJU
 Bg2Lau+oygyrOmHmtOVpCMkkBgzBVpYj/3CxnANMLTIgOUa1Uq1u9AcmZ
 eKmQgehq5S6UgeSQU3wM6cJvkxUwzy5QbuD662AXCNQ1kwBkhs7HBxaVa
 qSz1f2aN0EV2NfoLONSKhX0fR64rbg6azSyqpdPo9XyZpbwFHH/i4v4B5 g==;
X-CSE-ConnectionGUID: L1UtVDNxRMayvMsQ06/6ig==
X-CSE-MsgGUID: XBhr2cHbThKsjhrgrqsc/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1841732"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1841732"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 13:44:46 -0700
X-CSE-ConnectionGUID: yDShcA/wTeGLJ7n9nkUK7w==
X-CSE-MsgGUID: 3OFDaibrQ2Os5GSuOhPc8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4876856"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 13:44:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 13:44:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 13:44:45 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 13:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2VkTtWk+Nk4fEacA56tSug77QOC61px7Ou/cPSlzXGlEitodCMIIs2HnWscfVAP/nym8TfIWrn4zfvlnDuGiqqKigA47ngGb9t0XnJwBh6hiRcK/NNFlHvhRNBSWiUNjvez037EPYRrLzg20VERFxFj7pSwiWPeXtFllIX8ih+IUlE3cbjMG2t6TGh0lB9/MtJ/7NHC+JbId9gzsb/hxy7a09oIa2qVHDWTpm5oXtS3MCyfGj1TlJd06ZDK00wSrAFGo8ZCek/rUnYpM7xLHnENka+bhQ/elO0CcOUcxAu9SowHhwmaQkUbcZ+2nWfGJm2f8Pmhuch9hr9Earg6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blf/Lsx6pf0IN1a6GsxRebpC7yTk3CR0ZFbD2Wy1js=;
 b=lBbqzSRq1qJJAkd/BF5B6YGmsY+5vdBTdjoqGzyPXY23DqvdbI1PIHZUYIZKf7vvmiwtBxZ1Ea+fN5gqeZDbjP+elIjXcoJQN9ld0+uwoobxwqM/EA2e1H3FBlC9tBOaX9gYNC+YtkEOUta/oB90vz+xp8TnwAMqd+6lkjJI6Wnm8q2RcbodiS1GY8FqAU7PfHL9qubB4yH6T8Gnu6+mk9jb1GM03ZRHwvtD+fiKInpZed5WCXelhrNbKVrK3BzLP0hWqHQ4zNxcUa6cNKiAqVaxeWe2fIajrO7CbL8SFjQSUJQ3tPrQNoHGQU2608q4vghhcpDpcnO3CZOl96DBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by LV4PPF8ADF55A96.namprd11.prod.outlook.com
 (2603:10b6:40f:fc02::228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 20:44:38 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%7]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 20:44:38 +0000
Message-ID: <c6205641-0c08-4fa8-b247-1cde33f76b91@intel.com>
Date: Wed, 28 Oct 2026 13:44:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/guc: Add WA 14028709524 to disable PRL from VF
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Satyanarayana K V P
 <satyanarayana.k.v.p@intel.com>
References: <20261027225932.337738-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20261027225932.337738-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|LV4PPF8ADF55A96:EE_
X-MS-Office365-Filtering-Correlation-Id: 189cc829-c228-4fc5-6dc0-08df3534488a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|10067099003|261026140227099003|261028144727099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|260925021311599003|261026121527099003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: C+/V6OE/rz9gqRMLF8G+xx55pNsiqZFCYXS87lwNBiKz0V8QTWMm/oCtKbiqCZXXGwJK96GBNtw9UFW/3CKbuVZw9OEOtjytK4laEpic5mIhgZw8buuWRZ6aes1H5iEc3bHgB+nM2I2xIUnZ83awxEHFVief9CbXwORzv2KLpwtrs1A2OkB9RCjt1vQBsyIykZey9JNLhAhYv9TaBacHGoUO19/MyaQoc1E/JEgGlAy5ANBbEwf3uJ6oOgDu/WfMXtsUO2iEiWrZfB1vhdBo4q7n4d7fcC0avIHEhZqIGekg2eCEC6N0HkGMsaRTMEe6t7K4J+5cBgUoBbuJ3lpiMwMEr4FtwOFDRUNCyKKkQONvieokXZlor9b09x6vaqRu0/ZaMhi255pRmWlhTJ8kh82jiQabTNIMzoROiwZA1T+m+m5+iAiiKHYMgJr8Qq9xUnkI+A0vdySmpP1+YuFzOzcgNuopHJQ2EOA+NFhHyqLBlauEtzTAROgHGfB0+SSM6aKuN2XHneiTwv9hjJ04LGfcXnsCYxZbw095t2B4xQgGb5bDiI7El5c7oy5GrLe3UK4GT9lM3p4L5QZJwdlp+62gFYAU9m+KqBj01KuYYwOpytdZGN1++Zmyih6RccTt63s6FbxhfwPmKkqCHo/k3wS4iSIEzf8DafevK6EOyEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(260925021311599003)(261026121527099003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am41TEZETWhGakR5MTA5ZG5lalN2bklPLzY0RVZzNjhSMXhIWFVicWJZaGZN?=
 =?utf-8?B?STUrNjN6Mmk0anNEakl4U2VGTlYrNEszN2NnczVSTytJR09IekV2azd3d3dY?=
 =?utf-8?B?UWtIc1gyTGxFc2JFczlLT2V2NCtVSVFWOHVQL2RTRno3NFBYMS9CU3FBQ24w?=
 =?utf-8?B?MTllOVNjYUtMOEltdlNZcDFPVXA1N3BabmdKdnZxYWd5RmRsQkg2NCt5SHlC?=
 =?utf-8?B?NEZhaUY1eUNSN24zdkRjaCtRVndtZ0IyY0c4V25QeUowM1lmR21DMjFZSlp4?=
 =?utf-8?B?bXE2d3JabUswQ1Y2eEpIbjRJd1BVb20rcm1lcU1DazVZdDVONkFoazJTcXVj?=
 =?utf-8?B?MzVYWW5OdWNiZXIveVY5QUV6cEplZm1lemVvejhBa3RoNm9ickVocmUwd1lw?=
 =?utf-8?B?T3YwNU5BYUgzQkRlRVNZdXZRU0F3KzE0ZVhVOTlrd3Z5Y1ZQQTVsdEVKbW5m?=
 =?utf-8?B?VzkzVDJFTEdsSWdESVVtQVczdjhBRTYyaVN5dzVPUEtPcXEzeTNTbHlWVnQ2?=
 =?utf-8?B?b3c3UG5XSTcxeUt6TTlidGJvbUM5bWg4OUNrOXhiZWJFenlhd29uWFhqSlpi?=
 =?utf-8?B?WXp3UVpvSFVFTmtEWWJKanAydkx5ZEhrZDR6UGZrL0NJTWc2YWlTdm14c0Ri?=
 =?utf-8?B?dThraG0vYWhGK3c5bDU5OXRubmFkdGhsaW51WitVd210NHQ3ckRNWlNETjQ3?=
 =?utf-8?B?MHFULzJCRUVTSnVVU0J5UWJvem13MUoyUUN3NUJxeUVManhYeEVvbXJ0aFdm?=
 =?utf-8?B?UDlZOTIvRm40SGE4NE1ta29XenRHRTdzV0lMbW9mUVowS3gvdGJWaVc0MG91?=
 =?utf-8?B?QTBmNE9IQnk0Y1JQOEh5Y0IwV2pMcmNqRDQ1NHdjeFhWRE85NWxZekw0QUtk?=
 =?utf-8?B?ZzhsbWl4NjN2K3J2aUVUMVkwQ3dic3U0K0Vsb1c1ZmFDYTFvTUYzQURiMVdC?=
 =?utf-8?B?TTNVdWVrRzdCZ1hHbm1jUUNMZEtmcTJxNnVvdGVkNGxkUHJnVFNqR2JtcmRs?=
 =?utf-8?B?Ri9JY3Jvem9TVkpxYVVia0hNM0ExVmxpOEdlWHBsSlZRclRDSU43SWlVNjRh?=
 =?utf-8?B?R0xheXdob1F3L00rQnd6VjdEWnBTc3VqQUc0S0UrN1MrWmV2NElXbWM0amMz?=
 =?utf-8?B?NS9wWkNnT0gydVJSTUl4a3Y5MWdOMkw2T0puaWJDaVdPR01vRFhwVDJRMUM5?=
 =?utf-8?B?eGdYV0Rmamw4UUhUOWVTbVNRekJmKzk4RGRYbkwxNnNKa2hlck1Ka0VIZWRl?=
 =?utf-8?B?OGNXWWNVK1h1QW9lcldDZnhNUjh5N3dmK0lsSDB3NlQwbVF6UmRleUd2dGxO?=
 =?utf-8?B?UFJCNVRwb2ZCNjNZOWgranhPV0J1UU85UVNwc2N5NU1jUHJQNWdTTUhRTmsv?=
 =?utf-8?B?S1hndjFxdVdrUFJuMTNWRjlrRVlERzlUcFl4ZURWa2lxaUhkYmtGNzk0THQw?=
 =?utf-8?B?UzFFbU1hQ3ZHbVhSRGU3NUJjMURpbnk0alliYll4MG4ra3NCMnFXckdhVHhP?=
 =?utf-8?B?ZnZUcGZ0TzB3SWlKdm9semh1MllWMWE0RXo3c3M5RXlNeWtqUVFwYXNUZXk2?=
 =?utf-8?B?bjFwNDNOOWhjTHQ4OXFZNGlZWklYczBMM3BmdU9QbWFESXVZVmtGdHNRbDBz?=
 =?utf-8?B?eWRHQnZDNDNuQy9nUFE4WWcvUFgvUXJiRTNyQWlVLzRROTRwM0xqZ3JYWWhU?=
 =?utf-8?B?aUd2Ty9WZzhyUmNhVWhyUHE4dnJFN0R1eDlLcHlnK3UyUEhpTE9HbTNBRmJy?=
 =?utf-8?B?Um1sUDl6VEQvWTExcG9rVE5QN2N2MXU2UEI0RTNzUDBod2lQTXNlM1ZSdE9i?=
 =?utf-8?B?K1BldXJpUmdqN3ZzNFJaY1NWUldwaXdNZmo4ckpEYStXcFduNkRFcDlpbFVV?=
 =?utf-8?B?UUVkUVN1QXFpeXd4VnZFRllLQXdQaEVoTkJvMUNKRUVYS3dCa0x3eXk4dzNI?=
 =?utf-8?B?UWNURW9JcUxaZ2Y0aEV3ZTRJVUwxcE1LSldSMWxiRHJQdVMrdXJQTXdURUs2?=
 =?utf-8?B?Rk5qRGRNMTdFYlNTaU81dU5JNXliZXl0SVYxcFhLWGhRdXg0VFplSExVZmFx?=
 =?utf-8?B?TjRJQVBGM3VCYnpnWW9xMUlQckRyaE5pZVpZd3FHZlNHQ3RsU3M0THM5R0Iz?=
 =?utf-8?B?SDlmOURpK2pVRXlUUGJYZktiZUNPODc5QTg0UCtJNGR5akUzMWxyWFhnd2Ez?=
 =?utf-8?B?UU1TUjY5THpyMFNTaldtaG1ObVEySmJFd05SV21CRU1pVDIzY1lCYjdzMzZX?=
 =?utf-8?B?djdrN3l4V0FMTXVFdkdDbXh2WTExdE9GYnFqMGFtS2w5cThuU2FLbkJoZ1Rx?=
 =?utf-8?B?ZXVGMUJHdk00MDA4Y2Z1aVJZZ1RSblJVQks2SEVPZ1c0NFhpMURSaC9pVjdt?=
 =?utf-8?Q?btIVZxOOE7udQSeg=3D?=
X-Exchange-RoutingPolicyChecked: yXfGcyTF2g/0t9BkEKcvkN5UyhEgdfUx1HdwrvBhtKrqFKPIf8wSwu4It/i5B19g59U1jJyPEjGYaH1PSDAy5iGk9CO+MBRu6xfCh8Ws0a2qtk+YtC9moDBfk3GhuSL+w8F53Kx2mRRRSvueLIXvtS37IxMwSXGNMgyakBend8YHkcNAkk5PoO0NhCiRIV3tpAm7NVJDHe4+Uw63YgViIRAOgV46tBhUx/B2BY9kG6/aq2SEcqny5ESL8QCE+iKSQmSAc1DC5mRlyteM6QafKaMcxKDq/Qg0DgCdbTSUwFPRkZ4fbqFJEkGizgyl1MUllxBatKnAauJn0lENLwPnvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 189cc829-c228-4fc5-6dc0-08df3534488a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 20:44:38.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO6GRRc+vgHuyUZh7V/W/sxHXhvW+azMhFTdn8za/LXNVsMKJskGAi2mRrcaZ6rVA5wwSLLdyQl7q7TJWPafkSxvLfwArYS/trFMqbiAm+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF8ADF55A96
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


On 10/27/2026 3:59 PM, Alan Previn wrote:
> For NVL-P, hardware and firmware support for Page Reclaim
> List assistance is disabled when running in VF mode.
>
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

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
