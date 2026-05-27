Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867A5CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 06:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC29710E698;
	Wed, 27 May 2026 06:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k96GTGMv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C1710E668;
 Wed, 27 May 2026 06:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779863176; x=1811399176;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2zFW40isIvSW6LhWt0OkqNGsVHejsU4fj9duglmqRFo=;
 b=k96GTGMviOqD+RNtLmOMAIznvrM4kfywtxgDKG/mzxuS71Ke84aOVWVi
 BESDlV5mF+2tdwAaI5FHPdKKyutjHTaNm4FIjf22XQ4tQ6/Jh0K4beMkI
 eUu2Av8dSY9VBgguBwdSA9YNSkqkFPVI1xt7cFnkG69Du1bhUkzAwG7gW
 Pe2cZ35vPIrOBNR+QdSbmkQIemJJDTNZvSwxcwJkR0t6ffST93z7i5es4
 tWNCB80m1bgwnRuPGLJAK/wexw3w20a31tGySSHyjaAXol40WyMw/4jBp
 iJnHf/uTxJVaX9+3LEDLThGnduDlOov6xhJu/zfwcMNrD62VJGaTLMCWq Q==;
X-CSE-ConnectionGUID: wQRftdgXQuCbmntn+UD19g==
X-CSE-MsgGUID: XjpRWcvMT92Z9z9caUnqnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84541254"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="84541254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 23:26:15 -0700
X-CSE-ConnectionGUID: p6/Wl8HrQximtwp9hNEJGA==
X-CSE-MsgGUID: jMp8ZwOjRI6zcPuFW8AW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="241980491"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 23:26:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:26:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 23:26:13 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:26:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yml5w0pJ8AJi87kNpFz/BETVZagbezfWFI+S0VV8r9OXIIZMJQPq1nWCRM/+RSmQvqix1k7c+dIIrb13HLOz6MKYk8Q5JAiqAAaNWJVu1dmL2qP1tym7yebPZD5kxAettPZASa4HLiGa10EJmymj2lSy2rF2YnfJ0vkANsjhEhHksq/yxp7xfDUO3XgTqcXAdhXjswifGVLJ+WMRsDYSl2ZbhaM6mJ4sjzAfj/M/mbAzN8t4+XisxRLSR1Mz7B18pJR42GIiXFlWaTreqVyvoRgGyND4fVZtjxmz9DsKtfgm8oEpBM+WcWW6CQqE92sHbGmULQ+7gKAPN5aTi/emhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1hm7VsXG0uBNcHD76+CrP5TFmSWr/IvG07WxN9zutE=;
 b=Wo1ma9HnY4hyqhSaeZtxNTbCOua2DYIWks0MV92UwxGQNJwnzJ4ZIHeszHXVezOGldhFAf/+9IxmOV/FQM92wc3LdtZQSCeA3KrwVkNPfcZlHOvXcJVNuaXsA0c1zgjKdBpC+9uqJEtE4frqC2v+GljprQttd6/tSNCEwtmRL7KEzGTwRRyjCaOSNBh5fYPGNX1V0c4X1aVMJo1rrNPn8B729o7g5HmKjsnv2mExbhO1jx7ocK8DfVZruLMqld5s649IOswJTkGAjPY+WTCxiitIPZ3otCg95A4mY6f0ShrLcHBMbvGbfIhFA0xnvz9Zqb+hJTib/4zobUo5rSI0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 06:26:06 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:26:06 +0000
Message-ID: <0d93c0f4-4f2d-46a0-9076-4a6f63148c8a@intel.com>
Date: Wed, 27 May 2026 11:55:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] drm/ras: Introduce set-error-threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
 <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
 <zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
 <michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
 <umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
 <anoop.c.vijay@intel.com>, <aravind.iddamsetty@linux.intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
 <20260512191610.1817578-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512191610.1817578-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::18) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d803b13-1b5b-43ea-4180-08debbb8d552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|4143699003|3023799007|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DzRfsVYgBNk3YC34LYBdFjYSdmwhvGG5jOEfWEjm0jM9i6jy8o456+hnH8Tx67nDthnCfeIo5hshxR9JwjoIo1iJ+0h5CWfq7qhvjevnT5mExygIX2O2efhrllLAyzJf/u9+3nxBz21DaieTlzLsLtndLvQ3D5RWeK0Dn8/9xLu+W71fQLefT2cQVnFLi8dOrbsiowQMhI5FY8BHckQBtMTUntCWdDt65z4S31A/tZajU9FUVRNBIZAcy8f1EeW1tSkIIWotRsNCh8ngcWSwJn/xCXimIqU34JWtDfNjq6R1JkyaXYm4bZwLG+OTjk09+whDrCNOy8uJrLUDF6bYLisiuYQstnsAFX/S2z0Rov8GAKbIYgUtg1Y1z3XuJ1jukraonaEb4m3uSiZ5YforNMa4Rrcn4Hzi7yN5dD1kjgDKi/RbgfbP0qiBgXqIOCVcgnfJTx0LVo5Zn2+gt1FSxmEmP35W/9KGpSGU2CUnuvsJuU9pk6uczJlv+JPeiG32CtRZR0zma6eaY/Vxv6dsgICAmbjA7KOrTSWAElyN51cP3lsAUYJLq741CPO2ubRbTQVxMQFDSCzhqr8JX/3gELIyy1zt11YU0pJX4oiA0wtxgFI0LpTLyzagcjHTR6823knfPqIG1u9U9id6DJKSsmC/Hoe164qx7vUwCt0WPrAfsVxSaLRHZgK4q09mIgQ6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZLQ1ZqaVNycmNGaDkvZExwdmVqaXlXa1BvclhJUlNWZy91OG5DWHRtck4w?=
 =?utf-8?B?bXFCZ3BZb2MvZzFzZEVQTVNFZ1QzUkluQjhkYjVSSUNndXZLdzJvUjhaS0sv?=
 =?utf-8?B?RGd0cUxobkZpQU9aU0VLdG15N2ZQWmlUalE2akZoSzk1eUdrRjVrelBET280?=
 =?utf-8?B?Y3UrNC9UeCtmUDZla3Fod09YekhsQ0J6ZURDVUwzMVJTSU1KZzd5RlNBY0RS?=
 =?utf-8?B?ZHZxazU5cms5Y0hob1QwQkNxbzBLT1hsU09CN0JKbkc2NkV5TGtkYy9VcTZy?=
 =?utf-8?B?V0p5dzZSNjFLUmNSMk1ISVNkVm1KbDZIdkUyRjRuQlE0ZWZkckxNdTQvUmxS?=
 =?utf-8?B?aTNHaDlmUUE2d0JrQWhGOGdQTm5lbzVlNktpaDZIcDhjRUY3aWUwMFlJSHpx?=
 =?utf-8?B?eGdKWFRWM0ZOeGVSRUpCcFpZdUtobVZGYTJuUFkvSk1XT1hBbGExSjVXdS8y?=
 =?utf-8?B?UW5mNHdsalg2VWhOSEhZOEV5aGFEb0YrcW5ucmlxS3ZJelNwVzNlSkpvMG05?=
 =?utf-8?B?OUttQTlma3Y5ZFlkSmJXMVI2Y2NxZG1PV2w3V2xoWmx1MWcrZHBMRXFmOEkr?=
 =?utf-8?B?VWZJelcyZk54eDlDb3FFUDRGVm9nV0hubHJwZFhRWnFhem56ZXh6V0d1TFF0?=
 =?utf-8?B?bVBBUEd4eHZxTmhscEUrZk1jNTJUaXZsRzZ2Ky8vZjBvdVF2MFZEc3M4Z0FI?=
 =?utf-8?B?R1lQT2NGZGZFMFVWdVAvVzNBL0FCV0lTSGNubU1rdm1Tc1F6MWhiZGxqQmRo?=
 =?utf-8?B?K2l6RGttMG9BTnpBY1BCZTFoTEptc0Zjd2RMTXJUSURFVmJ0THdBOGFSN1hx?=
 =?utf-8?B?OGRTbFNBSnd1aHpTaEFCWHlBSExMSXN3RkNBMUVWMEJBbktQa3dQMDBxeFUw?=
 =?utf-8?B?QUVndXpSd1hndi9zbUtXRmxmUlAvYTlIWjl6V0JlbDR3VDFHKzhQa3FyblAx?=
 =?utf-8?B?a2grb2wxa0Z5OGVQQ0RmcTAxTUdYL0NoR2Y5bkpZTFZuRUx2b29WdWgyb1dS?=
 =?utf-8?B?VHgrWGtVM0RLQmg5N1N3TmNVUnJaTzc0S0tNYnYyUDV2Skt1Q2Z6RnZ4bzFp?=
 =?utf-8?B?amVCZlBITkd3R09DaGp0OHdBSHJnL3pYR0JqMmo1TTUrRmdTV28rL2E3c25n?=
 =?utf-8?B?NWFjcFBNZW9JNDFpbzR0NEF3aDUwNGxmamJ6bkpnbmY3amZkYm1BakFtNEFo?=
 =?utf-8?B?cU5kUzZSb29mMVNlbk5yY1JFb2lwQVAvQnlnY0lBcHEwM0h0V0RTNVNnR1BJ?=
 =?utf-8?B?Z0IyL2VjcjdmcVJaY0RTT3g4emR6bXJrQkVyV1BzbG9abVk4aHMxZUtMQkpR?=
 =?utf-8?B?Q1lSd3hQTWwyZVFISVlOaWxaeTVURXFQdXJpejZtTjNLenViQnhQeHlGWDdP?=
 =?utf-8?B?bnJNVHQvSXkrSkxvT3k4eTNhRWhDUUVwNWhQbXFhcUJYZXgrbzZtVUpGM3lB?=
 =?utf-8?B?SWV1MG9XSm5LNDlDZjhYdHRHaFQ5NDh1NEh5d2k1Z05zUElYUlhyMXE0RXdv?=
 =?utf-8?B?SWxneWlGODk3cVVmdnpIQ1IyVktFQy9OdXR1dEpaZ0VjQ1hqd3BSdnp3MFJ4?=
 =?utf-8?B?ODhFN3dyaGcwU2ZaSU9lOXZ5Rk5QVlpLODdKdkFkSmlGMFp5VzNCRVYxV0Zy?=
 =?utf-8?B?VDcvUXZteHVUTWsyNHJ5K2x5cTRKdTY3U1FwZFk5MHk0eE1xMFR3TjNTR3l3?=
 =?utf-8?B?cW4rQjJraDh0VXgzUnV4bTZlbVJ3K1lWcE56SUUxbjgwd3Vkd2xCTzZWUHhn?=
 =?utf-8?B?blBKcDJjbjliK0hyRG5VS3ZDaUcvZE02ZGNuZ0FEN2QzeGxsT0x5Ujk1ODBi?=
 =?utf-8?B?YTJITnlZcnlEaWhDUXc2dmxlZTJmWDZXTW4vQm90ZGNxak5ob0lXTnBZODY2?=
 =?utf-8?B?aW5TTmZ4UWhaNSttb09maERmdnU3K2t0OWF3N2RIZEdnR1RSb09GNy8xUDNQ?=
 =?utf-8?B?N2JVSGQ2VFg3WExuMVNJZkRKbzZCUEo3S20xNUJQTWdiTzNuQ2FTVmZJcENT?=
 =?utf-8?B?L1htVWV4Z3dmeXAvUUlEQ1FBcnVMT2Q0NWlXQy9iREhiK3JjWVdEZlMzUnhl?=
 =?utf-8?B?TFJ4VzF6Z2FSd2xLMFM3MDlpMUxNWFJRYVpHVGxFZ3V1clpyOVFLcXR6dU5a?=
 =?utf-8?B?c05jZkFYT2h3R0hkSWhxa21DZTFPRFM1Yzd2Sk9tcE12b1lBWjRLV3hHYWYx?=
 =?utf-8?B?RHV1OTcwU043cWl4K2RKVFlaZTRoNTJXdGdIcStIYkdKYXpNelRmUFVuSHhW?=
 =?utf-8?B?Y1hybm1qb1FjakdSSUFKdkxscDNDMjN5WlcvTDNxclBORURKTkxDUmU0L2Zs?=
 =?utf-8?B?OWk4VFRxMWdyVVptL1VEN2RnMmtKSUhDd1B1T2xKdUZoNThyOEhhdz09?=
X-Exchange-RoutingPolicyChecked: RwA+Xwpp4O/QhUf9qXcT9AkdNdAY597NKwLl+ejUdop6z0geZ5pGzTsI08le4UoWZO5pXxxYo23g4GaZNgzYCtA6Lmp3ZI+FL8/LM+KyHMarSid51YJn960+zRgCxDZ/5+cTikTprWNOl/Hr34HTPtpaOxNUwhUJEDTXPGs0TG4GRpdd7yF4eCpZQ3VADFcnx7O9QJiutRPM3RZM8vjMowNvuJ4qcmpCOPvcKYi8fo3ZPLnMeD7Q+b5zCLGD9xV69PQxfaUOE0f84QyhpSNvvBuhWmX5BDlmrSDaLlxXWFWgRXdDm6YiYQjpedy1ouhhJA2nP+fjOftTl4c8nXyBgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d803b13-1b5b-43ea-4180-08debbb8d552
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:26:06.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIR+P2vWCfMkc47+9wRDl7H9vvcIZPVcXqZShnEGfChv7mGuVPLjRHHmXMLrjNtSlpJISpvAjgGRyIJFrWRwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
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


On 5/13/2026 12:46 AM, Raag Jadav wrote:
> Add set-error-threshold command support which allows setting threshold
> value of the error. Threshold in RAS context means the number of errors
> the hardware is expected to accumulate before it raises them to software.
> This is to have a fine grained control over error notifications that are
> raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>      Document threshold value bounds checking responsibility (Riana)
> ---
>   Documentation/gpu/drm-ras.rst            |  9 +++++
>   Documentation/netlink/specs/drm_ras.yaml | 12 ++++++
>   drivers/gpu/drm/drm_ras.c                | 51 ++++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             | 14 +++++++
>   drivers/gpu/drm/drm_ras_nl.h             |  2 +
>   include/drm/drm_ras.h                    | 14 +++++++
>   include/uapi/drm/drm_ras.h               |  1 +
>   7 files changed, 103 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index dfa72e8becda..07a33d16bad9 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,8 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Query specific error threshold value with the ``get-error-threshold`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Set specific error threshold value with the ``set-error-threshold`` command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -118,3 +120,10 @@ Example: Query threshold value of a given error
>   
>       sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
>       {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> +
> +Example: Set threshold value of a given error
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 016d713069bb..ba7e0a944e7d 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -148,3 +148,15 @@ operations:
>               - error-id
>               - error-name
>               - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set threshold value of an error.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 87e57bd1e8ad..f351147489ca 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -45,6 +45,9 @@
>    *    Userspace must provide Node ID and Error ID.
>    *    Returns the threshold value of a specific error.
>    *
> + * 5. SET_ERROR_THRESHOLD: Set threshold value of an error.
> + *    Userspace must provide Node ID, Error ID and threshold value to be set.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -78,6 +81,8 @@
>    *   operation, clearing a counter value from a specific node.
>    * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
>    *   operation, fetching the threshold value of a specific error.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> + *   operation, setting the threshold value of a specific error.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -193,6 +198,24 @@ static int get_node_error_threshold(u32 node_id, u32 error_id,
>   	return node->query_error_threshold(node, error_id, name, value);
>   }
>   
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 value)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, value);
> +}
> +
>   static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   				   const char *error_name, u32 value)
>   {
> @@ -464,6 +487,34 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>   	return doit_reply_threshold_value(info, node_id, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set threshold value of an error
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID, Error ID and threshold value from the netlink attributes
> + * and sets the threshold of the corresponding error.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info)
> +{
> +	u32 node_id, error_id, value;

threshold

> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +	value = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> +
> +	return set_node_error_threshold(node_id, error_id, value);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index ecec2041c758..02e8e5054d05 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -34,6 +34,13 @@ static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_E
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -69,6 +76,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_set_error_threshold_doit,
> +		.policy		= drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 399280c2c6e1..57b1e647d833 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -22,6 +22,8 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
>   int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>   					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 7bb429d85f57..134e20a16abc 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -83,6 +83,20 @@ struct drm_ras_node {
>   	 */
>   	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
>   				     const char **name, u32 *val);
> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set threshold value of a specific
> +	 * error.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_id
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 * Driver is responsible for threshold value bounds checking.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				   u32 val);
Nit: threshold

Thanks
Riana

>   
>   	/** @priv: Driver private data */
>   	void *priv;
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 59530f987ba2..27c68956495f 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -44,6 +44,7 @@ enum {
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
