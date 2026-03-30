Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D7910D14B7
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34F310E0A2;
	Mon, 30 Mar 2026 13:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jV1yA9zY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDABB10E033;
 Mon, 30 Mar 2026 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774878617; x=1806414617;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vrNOtirqhnt4CA5XXCQqJiCgnWX7jvhrI9OvnA5yTe0=;
 b=jV1yA9zYt+FjvI+Nt5hMI7nDhjfVYKl0dtX2MUr5rotg8Dwj8BHWyeTF
 wALEb4Nyj4je8EyLRuf9S3d8XksZnSWhT1YQn1kX8VVwR1Ft3H2enk/ka
 XAmcafgZ1ek8ysiCofV6IMrGrEh9p7ZlNN03iDj8MLeFLVJo3HvnfcSTa
 LhImWghwg7vtvH4nwcoLEScF6C/mbNpiPNmYpJPaGapgEYelrteecUzUb
 kqcPxKRWLMuDsJBDybZj3le8Khr9wT2KLYG+kmnqGw+tes4fAxqBD9OCG
 GFjIkmROCrIgAahzrVBbRrBg0or2/pm8PisbTWrJ4wogxbQFKRiHEHWOb Q==;
X-CSE-ConnectionGUID: 9QUbnBQYTo2g7i+nWKTztw==
X-CSE-MsgGUID: KbKaiUSaRFetTbXRDJV2Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79736280"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79736280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:50:17 -0700
X-CSE-ConnectionGUID: tRLi2L63S0+ZyQ7glCAagA==
X-CSE-MsgGUID: 110LOyrWQ/aIzMKLCktyGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="226318665"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:50:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:50:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:50:15 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlE7E38pJ+9TjQ4tRIQ2gtuv+qK2zbG276/4CCZj9Xd4lEM/SQvWioVGSA9N22b46rfEu3ocjKihvK+VLMF8r1VWBfw6SA1s7yNTUgNpogqm7iVhiCCw6ZL8my6krea51xBdD8xjUE2BmCi6zBnzrMtmwE3PgiwZCspXVGXsYmoi33wsv4ScHHSyRJlhqCEnWyBPYG+uQq4V0I2CaB0yfFqP+0p/2b1RfZEebh/8YLl9jL5L2iUp2/+0vt86sFfhi/7kam9YxB0Uh5Ga4HqezN8Q/w1Oplkd6gV5t7zgk0THacD4Fhwr1hrnPDWKRQozhOi3xQQzerAnD9TZR9ZwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjcSQf6rEg6pTFMiuA/7tSRfvdHD9mIROVgLm0cDwuM=;
 b=ABe/e0t9qGPAboP2J3wpEO2rxNktZ3NE8zsh37guPmoZXx42hXE0sYjy5jIZUyYQm/892RX+2M2fnvbRWF6PAXvVbIX0kIcIpvXbVRhWIKM2nSag4CZFBKrJ7A8c3csgNIG0XAEiFhtdA/3TGAEiT74SzCWjQOQpY9L2cyeXfGH4If7q0DmRDSPBS18ihfMP7a5T3LyAWnYnAStOs93+SwtClpeAWTG570cSPmbd0/13v8lFGjcrVWOf3YuDuoCkCB9h88Srz8zRuOSSdSz+jc+Brs4qZsw/qu6HiSXmpJrdHxN4YkrwTc9cPB2OL+WS2ZfoN43Y/HvSneZfEIeBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 13:50:12 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:50:12 +0000
Message-ID: <dd97f18e-2841-4bac-8e5c-7068d6555943@intel.com>
Date: Mon, 30 Mar 2026 19:20:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/xe: Add handler for power management unit
 errors which require cold-reset
To: "Tauro, Riana" <riana.tauro@intel.com>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-11-mallesh.koujalagi@intel.com>
 <e2847c9e-5550-474a-b0b5-19844787c200@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <e2847c9e-5550-474a-b0b5-19844787c200@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|DM6PR11MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e255f1-0883-4d1f-0d8f-08de8e6343a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: IDm5ttgVy/wy6tjwYzz6OsbRLmpEtCy8E1130cV5AqAqpUhDBDhD4/i9mk17Wcpl3ZfVURHmrx0Bb/t+0Mbaky9uYSKgp7++EQjErfUbCzKaiMmJFhPS2G+aFOficyKaxpgdjBZxCzpADQR7Yg4T99O0oATzYx6mMCjqw8rLEPfLIymlfHXemIWoX4RwNH0IBAbelLjnP84mpUMNqQzznz0dckjVozAklGR/87t2SMPfy5hiqZE+MCujEj0GUy9gwUikrHIDNc9ZPhNy7w+ao5Vijs680U9Hl65Mxb2nnqxddj3DnMU2qS1tumv41kkiGBpXhCeWEK1uhwFYuV44eUlVuEV73ehwYOOI+Fx3IfMqpmnrgxZ5Z/uCqlRO6qCRJdowgIyYiGb4jsN9EFtOaCS8n23ii44Vo9eaXu/yr+frnlN7Cu8j1wZIPX/kfIMhVSa6kpZ6oOv755JJNyyzWmWbEZ44DFUALvB2j1/r/uV9faq6mW+DlCMuQhXVPgfNmCRKCOV/wCb530t3SXKebDuVDxwq/4xD5/zm55YDG2TVbu3O79rpf1yoP+RLycKFVcIVS4zGj0YvFlrPwVCM/Pat48iTR+B64B6vcvkjdVcqHGyT+axk5PXA6t9N8Q+VLnulgB8O2cPeSQ8t7LkNEwiYZkz3GxReeOIjgzo6nPCC7L+uueS1zDZAtAe/8aFu+pGH0YDHrW0OPyvHOoB8u2ed3p/NERtEFS6mAsQhMVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJPOEtHNW9aZk5XNFgxVTQxUjF1aFdpYmp3UEhzNW1zeWNxWHNFSi85ZEZC?=
 =?utf-8?B?VW5vbEFoOEZ3c0h5eUsyOU9HVTFpUi93Mk5mTERzY2FJV3ovZXQ0dkpyOW93?=
 =?utf-8?B?TUNnTE9KREIvdVNwZFJ6eUM5RFQ1MFpJQ2NyaG1JV2dKNEwzbHU0Lzg3Z2hI?=
 =?utf-8?B?dGZlS2NWTXZlNUtLVU9DOFlzanl4OVliY2xCem4rL0JDUnh1N3JKSkFQcWR6?=
 =?utf-8?B?RVFqeVljOThGUG8yYnl3M090TnZ1Yms2SzNVYVVqa3MwZ3c2Ui80N1RLeG5V?=
 =?utf-8?B?Zis3UkZVeUVrdElPSWZiWVlKOXFjZkRnMDcvNGNoZFdnbG1ybGxQM1hTem5M?=
 =?utf-8?B?TWpqSUdIUEp1ZFJXK014ZzhSVmRLU0l6SU9yK2lFOTQxS21LVHE1a3ZSczYz?=
 =?utf-8?B?N2JBak95aWRlSGZ5b1M5blBCcWRRV2V6Ty9HOFFUd2NQS0V5Zmg3aVpFS09G?=
 =?utf-8?B?SDl2c0NwbG4yMVI5ejcxMm5SQVlxSXZINnlzZUJTT1gxdEw2TzRmVzB0UnNI?=
 =?utf-8?B?V0Q2NDVVTFpFbjRrMmNDM3VlY3U3N2dLV1lmdUF2NnN3cUtQaFZjNnlqTW9S?=
 =?utf-8?B?ZWdsdmwyR1hHeFlIV1U0WmtoUWY1dHZRMndycnJNTm53c3ltN3NERDc3aFpT?=
 =?utf-8?B?SzZ6MTkwSEgzLzBzZDY2RVdvbHRrSTZJVXB0cjNMUEhIbDJiVFNFU1pUSFh3?=
 =?utf-8?B?K3VINlpCTUJXdUU2ZkFxZW1jR2NRb2xFY1dIcXVEYUtIalphNldVUHdJYVcv?=
 =?utf-8?B?WnlJaGFkdzBrZzdwR2JORVpodmIweXJ6N2lEbCtoVko3WWJXczl4MmtFN0sy?=
 =?utf-8?B?MWs2VHNyK1ppYkMxL09vM3ozdmJyMGVDWUk5WG5MRDBxRFF4VXNKYWozTTJk?=
 =?utf-8?B?dXBIdmVaWVdsWmMvMytnVEdrSDB1Mi9acU4wL2hOQ0hibld5U0ljWnltMHdr?=
 =?utf-8?B?RmptV2NXSEJWMk0rc3Z6bzliNjdiTi8rZXVHY1grMndFRVBZbjR4cFp3ZmhV?=
 =?utf-8?B?UCsraUsyR1UzdGFTQ01OWEtVaU9Rd2lOS0JmU210WlB2TmV2clNNRmhjckhw?=
 =?utf-8?B?b0tmWGFkN3Y3VlFzYzlFVFZWd0ZrZFRFSlQwU244cEdqQzUvMU45RnlnOTJQ?=
 =?utf-8?B?MUJ4QUhMUHZ2TWFEMTFaQXdhNmFIOHBONHVHZVE2M1J3akcwK29lUm9yMWdw?=
 =?utf-8?B?MzAyZEZKUnhtRHUxSzFUUFRDY0dsZG4yeHpnU3IxZE1ISmdxKzNEeklkQjRw?=
 =?utf-8?B?NVl0b1k1SFNDUVpBNzZ5SmxncGN1WjlRY2cvN1NhQi9wd3phL2tkaUs0dmIr?=
 =?utf-8?B?UG9EVlI1RWwxcjVhRFhWcUlGUTU2eWNPekF3WG9GY3MzZ21CYnpsdWo1ZDdV?=
 =?utf-8?B?SDRhR1JDWllSRlAySXNVKzBGdXdjc3lkZkN0TnR1d0YvOUhzV3QwbUI1enVR?=
 =?utf-8?B?a21zaGdObEVzMVpRd01Bd05aMVhpblhyN0NYZ2F5aER0dlVsR0x1dnpsMmRi?=
 =?utf-8?B?TVlCQXJybXR2bVRjM2N1N2hFRnlpTGt5WjlhYThRK2Jid2lvRUJZWlIyeERt?=
 =?utf-8?B?TDh4aWV3Q3pRQ1Y3Zk1NRDR6Q253dnBDWStiaUtWZzlIY0RNRWRqek8rR2ZJ?=
 =?utf-8?B?bkhxSUorSVFiN0djVDdUZExrTnpZektiWUhrbmN2dktWMXo4aC9DcEVzV25k?=
 =?utf-8?B?OStleDl4cGJEeDVVSmlLS2JVQ1FlWlBHNDErUTZkSytjZGZERitmbFpteXpX?=
 =?utf-8?B?YlhoQ1lhMm5yMTdBWVRJc0JtYnhlNERBbXFJY0UvLzVPRlB0bG0yMnpoSC9R?=
 =?utf-8?B?VXBoYkZHeUlEZHA4cElmT2piZXBZUUkrODlmWmxXMWpXSGlhM1JwNEZZcEgx?=
 =?utf-8?B?S0trb1V0dW1XQmlvTzZ5dU5PajdWL0FJZzAvcjZ4aUhaWFJJaVg4Z1FWN3Zs?=
 =?utf-8?B?MTE1Zi9UVzN5Ri9MZFluM045cFROQndnalZ6bTVmd0d2TGVsTW41RThSOWxB?=
 =?utf-8?B?NmhPbkRDQUJ3cndoZDdGNXI3SzM0cWd2bXFVMDFKS3lJNHZzVlREYWc2disy?=
 =?utf-8?B?b01mcWMvcHl5aVZHVXB1T1YwRk10aWRKSGloLzdFUkI0NDQvTHRSMElvV0I0?=
 =?utf-8?B?ejh3dlhMcEZ2bVFxS0dPWldubXJpckdSMUZ0THM1MTJNa1YxWlgrSGcvVk5p?=
 =?utf-8?B?bS92L0w5eHlQeldlNkt6NDF4aEhaTHovNkNkaGVzMDNremxkcU1vTVZaazB6?=
 =?utf-8?B?SXVpQUlQbHpvZDNycHp3bzFRcU9sMi94RW5uS2dUaDlEbXNTUCtMT1I4bEFD?=
 =?utf-8?B?Z2VKY2UzYjVRWjhmdXc2eHh4QWdxdXJnVEFoUys4WDNRUXFKSVNHaUxELzZ5?=
 =?utf-8?Q?WrkQhFFent9ks5ec=3D?=
X-Exchange-RoutingPolicyChecked: r8rBIv8BvxgdTGAKnYzresHRuj3vC67/Ll5OSGbGAShYlSQ/hZdLRsAbiXAZJTb3h3h75ly6DcaSB/+xQAIkqtUd8BcuETmtD8ccRbeYO9xFDESGgGqRRawZ0wOc+ibF9hAI07l6EHDGrWAxSNgaQUWPG8AjoqOQBpH6LVeZf5bxWFGTN86ZnZky0xQWumR91bxDeuee8wd36Z1A//zkZbM+SDui1RwytX6Fs4UKaAKjNnSzN/jYIVpXbpcJSDt1dQpsrrfqsCFRUkohSYw7EtrOkd5UM4ese6zTnPrKo1QA5YoJJwsdzXnYBFU4Fn3732sJSl1NJ4Y6TcUjskTpcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e255f1-0883-4d1f-0d8f-08de8e6343a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:50:12.2349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kcn6y5E0f85YHB1InUdSEt5syr5M1qfl+YZ/abXOM0aZoCQXWCY4HlBBRSx5H9FqVIA1HIu1VfRuHx8Q51zEezhro2ruDwZPIXXuLgES3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
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

Hi Riana,

On 30-03-2026 10:24 am, Tauro, Riana wrote:
>
> On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
>> This handler is designed to be called when power management unit 
>> errors are
>> detected that affect device-level state persisting across warm resets.
> Commit message should be clear.
>>   The
>> cold reset recovery method signals to userspace that only a complete 
>> device
>> power cycle can restore normal operation.
>>
>> v2:
>> - Add use case: Handling errors from power management unit,
>>    which requires a complete power cycle (cold reset)
>>    to recover. (Christian)
> This is not an addition to the patch. Only add this in cover letter.
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_hw_error.c | 27 +++++++++++++++++++++++++++
>>   drivers/gpu/drm/xe/xe_hw_error.h |  1 +
>>   drivers/gpu/drm/xe/xe_ras.c      |  3 ++-
>>   3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c 
>> b/drivers/gpu/drm/xe/xe_hw_error.c
>> index 2a31b430570e..ca965a2b092c 100644
>> --- a/drivers/gpu/drm/xe/xe_hw_error.c
>> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
>> @@ -5,6 +5,7 @@
>>     #include <linux/bitmap.h>
>>   #include <linux/fault-inject.h>
>> +#include <drm/drm_drv.h>
>>     #include "regs/xe_gsc_regs.h"
>>   #include "regs/xe_hw_error_regs.h"
>> @@ -542,6 +543,32 @@ static void process_hw_errors(struct xe_device *xe)
>>       }
>>   }
>>   +/**
>> + * xe_punit_error_handler - Handler for power management unit errors
>> + * @xe: device instance
>> + *
>> + * Handles power management unit errors that affect the device and 
>> cannot
>> + * be recovered through driver reload, PCIe reset, etc.
>> + *
>> + * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
>> + * and notifies userspace that a complete device power cycle is 
>> required.
>> + */
>> +void xe_punit_error_handler(struct xe_device *xe)
>
> You can move this to xe_ras
Sure, will move to xe_ras.c in v3.
>
>> +{
>> +    drm_err(&xe->drm, "CRITICAL: PMU error detected\n");
>
> PMU? also means Performance monitoring unit. Please use Punit instead
> Keep this consistent in both commit message, kernel-doc and code
>
Good catch, will replace "PMU" reference with "Punit" across commit 
message, kernel-doc etc.
>> +    drm_err(&xe->drm, "Recovery: Device cold reset required\n");
> power-cycle/cold-reset. Use consistent wording

Sure, will use "cold reset " consistently in v3.

Thanks,

-/Mallesh

> Thanks
> Riana
>
>> +
>> +    /* Set cold reset recovery method */
>> +    xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>> +
>> +    if (xe_device_wedged(xe)) {
>> +        drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
>> +    } else {
>> +        /* Declare device wedged - will trigger uevent with cold 
>> reset method */
>> +        xe_device_declare_wedged(xe);
>> +    }
>> +}
>> +
>>   /**
>>    * xe_hw_error_init - Initialize hw errors
>>    * @xe: xe device instance
>> diff --git a/drivers/gpu/drm/xe/xe_hw_error.h 
>> b/drivers/gpu/drm/xe/xe_hw_error.h
>> index d86e28c5180c..f588320eb94d 100644
>> --- a/drivers/gpu/drm/xe/xe_hw_error.h
>> +++ b/drivers/gpu/drm/xe/xe_hw_error.h
>> @@ -11,5 +11,6 @@ struct xe_tile;
>>   struct xe_device;
>>     void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 
>> master_ctl);
>> +void xe_punit_error_handler(struct xe_device *xe);
>>   void xe_hw_error_init(struct xe_device *xe);
>>   #endif
>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>> index 777321021391..93257d0eaaa0 100644
>> --- a/drivers/gpu/drm/xe/xe_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> @@ -10,6 +10,7 @@
>>   #include "xe_survivability_mode.h"
>>   #include "xe_sysctrl_mailbox.h"
>>   #include "xe_sysctrl_mailbox_types.h"
>> +#include "xe_hw_error.h"
>>     #define COMPUTE_ERROR_SEVERITY_MASK        GENMASK(26, 25)
>>   #define GLOBAL_UNCORR_ERROR            2
>> @@ -148,7 +149,7 @@ static enum xe_ras_recovery_action 
>> handle_soc_internal_errors(struct xe_device *
>>               xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
>>                      severity_to_str(xe, common_info.severity),
>>                      ieh_error->error_sources_ieh0.punit);
>> -            /** TODO: Add PUNIT error handling */
>> +            xe_punit_error_handler(xe);
>>               action = XE_RAS_RECOVERY_ACTION_DISCONNECT;
>>           }
>>       }
