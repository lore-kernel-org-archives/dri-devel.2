Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DB2C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D6010ED77;
	Wed, 26 Aug 2026 16:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g6NVQNwc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AC610ED77
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787762381; x=1819298381;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dSvJx/Hpz1DKf+kX/4R++mGLyW3yrhH24onAqUpW0Gs=;
 b=g6NVQNwcUK35cBA99uvUcQs/YOiOfjq15ez/4EvntWFJYLku6O1TFZjd
 kKM20Owc+EBT7FUC9wt00aatVBDYy4o6mzFr2Xa6wTb+mStPDtVjotcEL
 82Ug4S+DWUGvxALqtSeKkGTrL9nWbbiUC7KdKUOsyNspTVaWh3tI/RYpy
 I4gqxCgOaVhtU+T/gZoDIYmGz84KTdUIU/Dl3UASJDchjRFLw2cAEXx8g
 Pn/y0H7qCLc749G0MhqChjw1l5Ji1SdZNCw4cqmKdEJyTq33n3w4ftJMA
 TOW04BldqAhEhzoZgycw9C0VXy6tNUCsuxfky2k7i605a8bKHcKhupCYo w==;
X-CSE-ConnectionGUID: U5iJ/C04Tui7APiCX1XK0Q==
X-CSE-MsgGUID: vbU3Brd/Qyar6obciSDjMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88014976"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; d="scan'208";a="88014976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 09:39:40 -0700
X-CSE-ConnectionGUID: R+TUVoZuTXOkr5EYs6gsKQ==
X-CSE-MsgGUID: k5/PwMgyTCOBXMa5c2g1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; d="scan'208";a="272872479"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 09:39:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 09:39:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 09:39:39 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 09:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mz+pjI5llHgDoRfRkZ3bP2ewA83BvVZXmP+/PgYH/E2dNb0jorLMPMG9CdwOv6SzXWkd0kVtuKePazeIvyIAfFwCHiE9Wh2xkKKLDjCWN4Scage7mqqqcV5+KtXSH6rbVBldJokBj/UOEAr9LfIZAMubtGO9RcTLQ6/TM1t/5NaWEEp9vC2iWv6kQ/C6jlYpcMYG6dsie3tQH30KrNDZ9z/lfr+ZeFdOd1gOZ99BgOlLy/4RC7y8KiSc9on9WPni5PeRj+2tOhZGV+IAOIS5XdhPrSxf4qXKIDy1tdJFH519ZhebeSRDeMZecUO1w7O3DkYipDSK4a3ytc9QzV7wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5fyHR6q+Y4idtC45eSpq1Rx/tt0Nme084DysR+t3LE=;
 b=i92tde+9MSaXU2kBrvlgD0NlqyTV5f1jzkPgdiD81KYWVtM4/NwLut3FQdGtJvSYUNGtlWP0YsO0OMv16duhw5qyrm/Im83z+pBB1Mj23401fb1rQP1VBjf2+baHzafTfrSDcujAjRZq2ZX3dNch64cDttjYs18yKYYIvdb0FyYbWlf7mDLD7zjU8CzL5Gbu4cv5m/35g2C1JR8z8tHRy9meUVYzELV61Ob8+3I53Og21xC9onSfftEbznmBscBhJvbO4aaC+jhgSbgHKgDWk1mVySM4nLM3PDfh9/juIXFqRxt4GL1d3pdgcb5R9MOeOWlOXU1pQkzTBkF97tYbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 16:39:34 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 16:39:33 +0000
Date: Wed, 26 Aug 2026 18:39:25 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Maarten Lankhorst <dev@lankhorst.se>, "Andi
 Shyti" <andi.shyti@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: GPU_BUDDY_KUNIT_TEST should not select GPU_BUDDY
Message-ID: <ao8Fc8DWbsxMtSRu@kniemiec-mobl1>
References: <1e519fb24aa5521788d69cc7980665ccbc227b14.1787584184.git.geert@linux-m68k.org>
 <ao1hIejAdBPKUHFW@kniemiec-mobl1>
 <CAMuHMdWuG_s3Rm-gLc2KNw9Z0bptQjdDDGH+9YawEMEsFZZ6Nw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWuG_s3Rm-gLc2KNw9Z0bptQjdDDGH+9YawEMEsFZZ6Nw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0157.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::12) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e568c0-66d0-4e1b-14fe-08df03909be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: re6LHlilDShzZzu+TYJt+zrJuqh7odW6u2gLulemDzjX0r3rgDGkaJGozH0X6iXIpv5gEPsLxL6gElKNtAG1b98zOgJG45agdDsSPAOnFHUMZ3QEruvUTk+a+RWzFVNqKOBeLGv1EhyxQsm9P5D57n6WYgvAu3FZW2TPH3cb4zZJeevzbXu0S49Od1/nQJ8Woyfyd0UEb+MwApawtxgMiZFZiCVszwhSAIRr6CdLMceZzVzvaikF8/zaAvo3lzngpXUUKpvUAbyhAqAVfeEsQFNG7oOkeBgyF5ciKXGbNNO1FAFVAGKiSKJJWm3YvYsYQcuuFs0eSrSnQsXU8SwOlffLCSzJbPPgqIFyK9MHdBLaAZLjyv1IVSt8q9fEkmkDhagiaXRhQCAxSlLivy8ubZyWNtxTEUKCSO9+GxZ4isgV5owLAS00U7GeSpcuRV/f3GAfKSiuPsy23CQMs07OQWUUDcQ90h4WCiy9mXQRvTpkKJibaQ3BkycV8mM1ZlVbaIKOM45wLXJl4PjAAKfVH9ziOagWOxOzFALaSavXgEQlO3rv6IqKBB2hgVigAp3N6HpIWUHp9GIjs2aBst0liBq+64Jyzp1UeyQcH36JwxofJ3PZpZ4h0iEyjDaT/VOrUgnPYsh6VzZ7UNDQQpyDMzfu9rROZl6t13IwkLdFU7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdNdGhkaTd0TTBZM0ZKbW84b3BJNDMwQitjaStzdVBpQnc4SE9KMzFHUzFC?=
 =?utf-8?B?RGk3cGdPYTJxRGxodE9XZ28raHJSNVVPNCtUanhYR2F3QUY2TXJIZzdEa3VE?=
 =?utf-8?B?QWNodEdCNFZBb1JrSG13VUNKTXBkaHdjNUFCa3BDdTQrcW80L1ZHTjdiN3Z4?=
 =?utf-8?B?OXhtekR4UDZCSmlnNUU3S3AwWnRPMzZmNFZsZGdsR0dwbkNDL0RzOVpvRmln?=
 =?utf-8?B?N2xQR1dXSEY3VW1IVjE4Zk9uUjRpQThqOFd5T3VXV2MzR05iUElXamI0bHl2?=
 =?utf-8?B?N1VMcFNKeEhBUlBPRU9Xb09UVVpGZ0JOY1dINEJVcmJMNU9venE3ZkpTNk5L?=
 =?utf-8?B?MjhmcEFGMUJzWmtna1dtNllUM1k1WEtudnJNUllDQ1FSVjlId0I0V1U5U014?=
 =?utf-8?B?SXpBMDQwYUUwNnAxVEtTaTB1dzZmdndlME9VTDIybm1RVjJOK2QxTWk2Nm9a?=
 =?utf-8?B?TW0vL0xUT2U1WldXdDAwRWllalZEeXdHajgzL0p3aHpvc1RjTWtHc0c5WmZ1?=
 =?utf-8?B?UHMvajk2U1hZYTZodXdqYU0rKzBtalE1eVlkNlZyeXZSWEVucDlJbVo4OUlp?=
 =?utf-8?B?Tk1BSmdraXZUTDlJcTRyUkNQUVNDcHF1bnVDeFNacUxTbExUWlJ4WlUvM3Jk?=
 =?utf-8?B?QTNPZWt6cEgrQUQ4ejluTmVXR2l4eGVVYWpRSk1nMS9tVVl4SnlLdU5OOFpV?=
 =?utf-8?B?VzNSSWFLNE9hTC8xZm1ma1B0Zk9kdnlZemcyMm11bHBiR2NUd1R4YnBGTitR?=
 =?utf-8?B?R2xTWlZoNUdYeG1hZ3JhS2ZPOHVqM3ZscWNiaEhGamwzM3I1ZjN0RjEzVDhH?=
 =?utf-8?B?L3o1YkN1NmZPelFwNTZ0aTF4NGUyck42VjhwVGJONWEyYnc2MkIvZWZGdk8z?=
 =?utf-8?B?Ti95M2JJZU8rU2R4S3BhclN2T1ZseWJvMDhNTFBYMUNndEJVcEd2cFI3bHFu?=
 =?utf-8?B?Y2RDYkV3Y3h0QzJlZmFDcmNqOTNkMEhNMmc5bnl6dEltd080eC9rUGlRVFRt?=
 =?utf-8?B?NnBhcS9WWktFZkJzRjUrbmtPOXRaL2h4YmFzUFZwSzFkdzJReWtpcS9jZXFq?=
 =?utf-8?B?NldrVmNMRWU3YnRpVFRnZGRNMWk2Z0g1cTViVTBYMnd3UGV6N2JETWE5N3dz?=
 =?utf-8?B?UHFXdUZ3R3JZNGEwVlBRY1RGSENrSEJENXpaQm9JQkhsbHByUmt1d2FMTC82?=
 =?utf-8?B?WncrVW1xYUpUNXU4aE1FTFhyQm1Lak9WNlptOEJ3SW1xYkpkbDBQSFdXUC9B?=
 =?utf-8?B?Zk82Q0I2TUpINFl1bXc2QnA4bXJoQXZwb0hkN3hNSFd6VzBkNGFiTHFKckNp?=
 =?utf-8?B?SmhtL1RWTlR5NXpoMkpkWFh4c2JtbTZvMUdEWXV5N1o2ajFXQ1VyTkcwK1lt?=
 =?utf-8?B?VjVmcWg2RjM0T01HNzJCSDlqSC94RG1PSU9TZ3cxWFRmTkJQSHFLM1cxY2Mz?=
 =?utf-8?B?VTJtZVNjZTZsbHpyais3c09BUzFSeEtSMVJxYXNuYmM2ZFBpZzYxQnVCRW9k?=
 =?utf-8?B?cVlCdDY2YldhclJHeGIvRWFGbUJrS2ZXZVN3WVdYcXpLY00zTTdZTVA3TXVo?=
 =?utf-8?B?eVROQ0xvcHM0dngweEswa3dxOGlQaElzaW5kL05OUVo3cHA5VkRwTjh4VEZ3?=
 =?utf-8?B?UGJieDdWSkFFYUNveFBMOVJINk9hOXpGbE5VMEs4SmRDM2tqTVZ5dmVNcEZJ?=
 =?utf-8?B?dmJ3b2xBbUlVU000UDhFd0ovcW82UDRNVm00Z0h5OHBCWVpYOUgvdjZUbk9N?=
 =?utf-8?B?VVdGTUxSbTNZMUp1K3cvQkJ5OUlXZk5nTU0rbzRwQmF4S2hJLzQ5OGNJM3ps?=
 =?utf-8?B?THBtZUw5Q0dYWWxWVVVLTitQeHhBZkxOd1VOV29UQ2ZmSXZjY1lNY1FiTnZU?=
 =?utf-8?B?UjVpNXB1WVBnNEJGRGF4SE5XcHVPRnIwRTIweGxJVGw4NlhkQzhZa0Uzd252?=
 =?utf-8?B?eERhZ2FONlpsOXNZZVlhQUVXL0FUWFN4elg3RGdNZHVVcExWb004SFhNVWph?=
 =?utf-8?B?eDRzeFE5dUtnNEMzVFVNWjZvN0hEMTVNajkwODdlWDRHOHJHbCtPOVlmNlcx?=
 =?utf-8?B?U1NyNGN3cHEveTlGeEpFalVTQ1VLb0pNM2pHb3VDNUsrZXc4bStDMGZqTndp?=
 =?utf-8?B?eXovc0tHWUlGSkpjbW1hUUFVUlNTZHFPR0VlQTB2VVl4dDZVQStNRXJUaFhV?=
 =?utf-8?B?Zk9sM0FIc3U3MGJxVVc0THE0RHBsZVFpaS9UZ2dWYWlkKzBKbVZNOGlLQlI2?=
 =?utf-8?B?anlja3dPSjljRnpLV0FEV1NCbjY5MnljRmMzRmoxK0dML2ZUQmJrajk4dy9N?=
 =?utf-8?B?UmZtNFZRNzg4MTQxUWpnZUJxYUpLL1J1cTJxTmRiaXQ3ZTMrbDhhdHpaOHdm?=
 =?utf-8?Q?YhMBrXIOxa+OmWNY=3D?=
X-Exchange-RoutingPolicyChecked: kbO9LI/SMPKQFludd9zXCNV+wPp/bEFjZJnJl5mZPX5YPlVOqDCAIFi7loJR3QU81ksru/SRb9gbAnF1qsGMC8O8nESuOxj+NWL7jrDVAWtkI8Qn4jgabYlJdoUmHrc0Iy7zfFhQsmB4I8PfQ8MWtw32MExGz1VPU76HdR8ZAtfKbaDkNn0KQjM+L1aClqc9+qHWSSZtsUuRAW+Zvrs7GQLObSIvzAX+emWC82NADMyH08O3savceDFVuIQ5BccsYm+FrYIbdO495y2tkv9CiZ5MPWeZTQYfzQGUbiV+kVryO54Pxw9DcsrpfIJoqSV+Jr5TypdiA3xGDlAdMFSDXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e568c0-66d0-4e1b-14fe-08df03909be6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:39:33.8552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKBUX4Y7YolLX10VZybqZAUeYulM6aGfdiz7UHpUqgQVMkKhmf2Zxf37rIbceZ6DPZ4+GnLc1J+VTr854Og0uVIbDBSB0M+Q1APxsm0g7tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
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

Hi Geert,

I got unnecessarily annoyed/angry in my previous reply, I'm sorry for that.
It clouded my judgement a bit then but I still have some comments now

On 2026-08-25 at 14:15:34 +0200, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, 25 Aug 2026 at 13:39, Krzysztof Niemiec
> <krzysztof.niemiec@intel.com> wrote:
> > On 2026-08-24 at 17:12:30 +0200, Geert Uytterhoeven wrote:
> > > Enabling a (modular) test should not silently enable additional kernel
> > > functionality, as that may increase the attack vector for a product.
> >
> > What vector? What product, exactly? As far as I know buddy allocator code is
> 
> Any product that uses DRM and has CONFIG_KUNIT_ALL_TESTS=m, so
> developers can easily run any relevant test when the need arises.
> 
> > currently loaded when a) loading a drm driver (which would need that code
> 
> Not just "a drm driver": very few DRM drivers use it.
> Hence one can have a product with DRM that does not need the buddy
> allocator.
> 

And the buddy allocator was moved out of DRM in anticipation of a
possible non-DRM driver that wants the buddy allocator. So there's no
implication between DRM and buddy in either way anymore.

Currently it's only DRM drivers that actually use it, but there's already
scaffolding in rust for it that does not depend on DRM, and once
there's a non-DRM driver that wants to use the allocator it would have
to undo the dependency added in this patch anyway.

> > to function anyway) and/or b) loading the kunit test for the buddy allocator,
> > which would need that code to function anyway. And AFAIK neither are
> > built unconditionally into the kernel. So the amount of potential vuln
> > surface is not exposed beyond what is reasonably required for the system to
> > function as intended.
> >
> > If you've found a concrete bug/exploit/"attack vector" utilizing buddy code,
> > then please address that directly.
> 
> So let's include all available code in the kernel image anyway, unless
> you can point at a concrete bug/exploit/"attack vector"???
> 
> > > Fix this by reverting the select to a dependency.
> >
> > The way drm kunit tests do it is by select-ing the appropriate
> > functionality out of the available ones, with "broad" depends-ons for
> > DRM and such (say "depends on DRM\n\n select DRM_BUDDY"). DRM_BUDDY,
> > for example, is not directly selectable in .config, as it's meant to be
> > selected automatically if a module uses it.
> 
> In general, test code must not select the code to be tested, but depend
> on it, to avoid that enabling CONFIG_KUNIT_ALL_TESTS pulls in lots of
> unneeded code.
> 

Yeah and this didn't click for me when replying, of course this increases
available symbols in the kernel which increases attack surface. And the
DRM test case is different since I guess if DRM is selected it's an
implicit agreement from the user to pull in smaller DRM components as
needed?

I still think the statement about the attack vector in the commit log is
a bit broad and vague though, maybe just stating that "building with
KUNIT_ALL_TESTS unconditionally pulls in code from gpu buddy, hence
increasing the attack surface" would say that same thing but more to the
point?

> > This is also the case for drivers, with Xe having depends on DRM and
> > then like 40 lines of selects for specific functionality, same for i915,
> > amdgpu, so on.
> 
> For drivers, it is different: if you want the driver, you obviously
> need the helper or library code.
> 
> > > Make sure the GPU
> > > buddy allocator can be tested without enabling another driver that uses
> > > DRM_BUDDY by making GPU_BUDDY visible if KUNIT is enabled.
> >
> > This was the case even without your patch, and was the entire point of
> > 8fe3fc37564920ae mentioned in Fixes. The kunit test kernel can be built with
> 
> Yes, that was the intent of commit 8fe3fc37564920ae, but it used the
> wrong method.
> 
> It is customary to make library code that is only selected by its
> users, and cannot be enabled explicitly, visible for testing.
> See e.g. commit bf2d44d07de726b0 ("ASoC: wm_adsp: Add kunit test for
> firmware file search")
> 
> > a rather minimal .kunitconfig (included in the gpu/tests directory). So
> > it only loads whatever kunit_tool would load, plus CONFIG_KUNIT, plus
> > CONFIG_GPU_BUDDY_KUNIT_TEST, plus (implicitly, which I discussed above)
> > CONFIG_GPU_BUDDY. It doesn't load DRM_BUDDY at all (which was the bug
> > being fixed in that commit, you used to be forced to load it, now you
> > aren't)
> >
> > > The page based buddy allocator for GPU memory is only used by DRM.
> > > Hence add a dependency on DRM to GPU_BUDDY, to prevent asking the user
> > > about this code when configuring a kernel without DRM support.
> >
> > It seems to be *technically* true, however, the entire point of moving the
> > buddy allocator outside the DRM directory is to expose it to other non-DRM
> > drivers, so the lack of dependency is kind of by design.
> >
> > The change was rather anticipatory, but it was clearly well reviewed and
> > sent by a Joel, a nova-core dev, I assume it's gonna be needed at least
> > by them at one point or another.
> >
> > If, say, nova decides to use the "communal" buddy allocator (if it
> > doesn't do it already, I only briefly skimmed it looking for kernel::gpu)
> > then the DRM dependency from this patch would have to be reverted (yet
> > again). Maybe moving the buddy allocator up from DRM should have been done
> > along with the first non-DRM user and only then, but it just didn't go that
> > way.
> >
> > If the issue is that this option is too annoying during make or in
> > menuconfig, then I don't think this is the way to address it.
> 
> Once the symbol is visible, it needs a proper dependency, to avoid
> asking the user irrelevant questions.
> 

If it's visible and I understand now that it should be and how, then of
course.

> > > Fixes: 8fe3fc37564920ae ("gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST")
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > > --- a/drivers/gpu/Kconfig
> > > +++ b/drivers/gpu/Kconfig
> > > @@ -1,14 +1,15 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > >  config GPU_BUDDY
> > > -       bool
> > > +       bool "Page based buddy allocator for GPU memory" if KUNIT
> > > +       depends on DRM || COMPILE_TEST
> >
> > What's the justification for COMPILE_TEST here? It might be needed but
> > you didn't explain why or mention it in the patch description at all.
> 
> It is customary to add "|| COMPILE_TEST" when adding dependencies that
> are not strictly needed for a successful build.
> 

I can't tell if this is something so obvious it needs no comment; I feel
like it should be documented explicitly in the commit log.

If the DRM dependency would be dropped would the COMPILE_TEST have to
stay? Because then we're forcing a non-drm user to enable it if they want
to use the buddy alloc at all.

I think just leaving the "if KUNIT" part would check all the boxes,
since the tests are actually runnable with KUnit via .kunitconfig
without building an entire DRM driver, GPU_BUDDY also won't be randomly
enabled with KUNIT_ALL_TESTS on systems that don't care about it, and
we're not forcing anyone to enable DRM on a feature that was explictly
made independent from it.

Thanks
Krzysztof
