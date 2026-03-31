Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1776BFF60F4
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630CD10E1FB;
	Tue, 31 Mar 2026 17:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AL4QQYcD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2132610E1FB;
 Tue, 31 Mar 2026 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774978417; x=1806514417;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CGqzcrhIUJF7YxNhb+zXkjzgdfU9byHqx/la9YsWWGM=;
 b=AL4QQYcDD1K3pw+TyMJsDH0BZ8emQOwEbj18RMmLmZluPgvjMfsUlGwF
 N/wJHoQhnxXRVxuO6lTLG8cVgAV0PoAZx8a1axbVEeCwro7jmA6K8Oq54
 VZl0uB3eq/sH9uhz1xgT11kikMR597u+R2dBcxrwSNn++QP7xCeQDet4w
 8X/0GQehmvmFnE3XVMfW5Q2d+pme6K3lx18LMcUKx5s4Cc29cMDeDARdj
 rr2H2ZTV8JW29j6S0YCH4vUv4n3q5KQ3vT0CRtjTrDHJv9s+esmiIU0ET
 ixv9+xuy9sCs5AyrNp2Uz9rg/+zMpvMfVJfTfN0D5yVBLCVrHEpPlX2Zb w==;
X-CSE-ConnectionGUID: u75OE7RTTiWhXo5/ZJ5V2Q==
X-CSE-MsgGUID: XvLUSJ4/TmObxgaG9X2BtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76115685"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="76115685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 10:33:36 -0700
X-CSE-ConnectionGUID: tE9kalocQJC072HityKwtQ==
X-CSE-MsgGUID: s7gjPTIURsyBfqLhN1j9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="264363951"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 10:32:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 10:32:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 10:32:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 10:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7YHtQ9zme7jytwZ+Xnee5wK15Fefk1BFAAGDM4Zwn+7OgG4FQAWYK4RrHfeMyLDwsCRdRMqTqii17H/pnF4XujRlFoolbWGZ3QdeEJ+9MS8HX15IvFy7Fm6edv9S/dvkorOJpev8llt1PjZyZ5Gjfx6Uwwr9oJiseQYc7TWNvUD9ynBgeVDtR3LldBkVY/r5L8VAF8pKepNONEaCQotIz+WvgwfeH09oNq8Cgg7SSlE6toZII9MUbAMoP2TfhGEw6lDRdueZLrCzmsSMYA0NxL+xKlzvAgVzZQiJZAKxj0ffDGEW1fxrF8uiwFi2kL3GaDL6THFuOj/VaAg92tvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlIwp/bMmjEyrq2jKTQ/3DUg8Vw0oA4CB0pDBDANdoc=;
 b=M97XCNTPSyVTT/yaBRJBM/aIOdvFKZt57wCls/bKUAAF6XHAQpZKduTLUXGTQDHFLyl4AHrm5zSOYKKfjUngdHrfZakbVjkpCPfChi3lkNS431hYlcfUPOx0vOG6KlsAJ/hfyZP1bQqsa46fHmCPAvmNE2rPG8cAG5l2bA9ZuxyJNNLjEHU2jJhk6MLjBjOaF+eSiU5bPDthPOERYdSNZgGtd07iJ75wFPbwcOg1/NCo9Q7yPQdLsmhGBp8yHvBsXXOICGuN8UY5JACF9lbVfGWZoCHF6SJALkIRMx3uGM+S4urcs3ivC+8p9iKyX2lP2gi2SoT49rWpbeeCPGLaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 31 Mar
 2026 17:32:03 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:32:02 +0000
Message-ID: <aaedf481-9e32-4061-b7c7-8d5425f20526@intel.com>
Date: Tue, 31 Mar 2026 23:01:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] CSC Colorop with COLOR_RANGE and COLOR_ENCODING
Content-Language: en-GB
To: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>, "Uma
 Shankar" <uma.shankar@intel.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>
References: <20260317160350.229028-1-harry.wentland@amd.com>
 <9fbdff81-f909-4baf-9560-1104acf36ff0@intel.com>
 <968daa97-55cb-4cc4-b6da-def2376ef57e@amd.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <968daa97-55cb-4cc4-b6da-def2376ef57e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::7) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|PH3PPF9E162731D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9a3a92-e8bf-4117-6aac-08de8f4b6bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6XFaJDAo96+l8uiWEuS47vOMeI5t+rmGYpsZlmk6tNrdt8mWfYgzHRaSnq53Pvm+HWjA/v8AEuQEjYyqw1WJ5fiLomQS4Hm4fMEk5Ji4eBYGKJr4hHcTmAzWduJazN9CT0/6DVjhUgHrXl8Yk03cX6wjkr9M0WCkNQ2Pq4VCxF3jHl80nc/wEOfSuTdjsuJESBa4ikhH8QIaxuRcZPlcE+qeN/+n8blplRoACQY1Jr+jokVJytJkrSpsGQYez31b6K9VjwIOi6Qp0TEIrOZQ8VKffYglSZ48XRtQdA8AtY995utvltdd3nSZq0OKySY6wopWwzlCaDxSAbyyMgQCmJrUY7ixAE0sIKFx9AyM9aGtdWvU5uDb8T47XzFa8Bq4Tpil4zrn90t95rEpMW4tbCgTm0FLQMJjD3JtZITOkHVvmfOMmhHcFnJUm840Rh6MG/SvASz6C6VlBTCMHXUXIya3ZtQNpol5WNe+QP+/+NyRujLYQG0eXRjlVjYq0CDHGnC+jCZATj0kOfc5dYi6PbSDzZW9aSU+NFFP3NzZipZ2F8Ws+bfsm4+qKJxYeCYq3Cu3InLuhDIiq9MTLkg4+0EfS1tTBwtxVAv/fKQnMX9G3qKn2NBXvcHSbSmcc7fvLWheNuTrRkSkgT7ZjIaAuDgj7JA1dHXL2kCXSQFFqVsDGoP8TPVdmNAYDtJKaFRUlI+beTg1WZ3IB+Ag0bkUsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZnbzVnRVIyRjBuVEhJVm1wS3hCNGVpaGdHQ1lNOHprL3pxTWhFeVYyWFgz?=
 =?utf-8?B?c0pSQklRZ3JGUVU0TllJNnVZYWdrUHBQeWowNGdCRC9vV0o2YWxlUkdBbkc4?=
 =?utf-8?B?SEZpR0NRblA1VDZqRjl5aXhuZDB6dWh1TFpHU2hjYjUvbk83RWtCZDc0QU9C?=
 =?utf-8?B?djlRRTVnVGx5VWNmU2g5Y0xMdWQwaGRKemJvcTlUWDlYNEtPYy9YbndBNC9K?=
 =?utf-8?B?dElnSFQvNzlUVFJOZVJXOTdQMU90TU5PdEo2RDl2Y3Z4aWF4MUQ3Uld0UEJx?=
 =?utf-8?B?eENQais2OWVzNUo5ZGJuaURuZ0NzOHQzQTZRcXNQV1FVMVRoZEtIdnYwYjF1?=
 =?utf-8?B?SjNPQ0J0d2s2bGUrS01USEkycC9ra1BjUlZSakIxM0FSb1BXWXlXRkhMWTl6?=
 =?utf-8?B?TEZGUGZZZ2w4ME40a2ErT3F0czBjQ3FJd2JBT0dtbE1nbnY2Y2N2bzMzTkFP?=
 =?utf-8?B?OUNWdnFRelR4VmxTa1pPV1F5ZXBHUGIrL2RiTEpqeU9KOXlkU0dwbElEMkxL?=
 =?utf-8?B?WENreHBRQ29IWVV2K0xSTGNOa0s3UXZjOGJHbDdWRGZPaUZZbmxPVmZndjVU?=
 =?utf-8?B?TldldXJLZEY5VDdSUThzRlNpdDRzaDZ0WnQ4V2pBNnNBYjRQQUk3UytRQThI?=
 =?utf-8?B?RnNZZ3NvSFM5elhhdnQ5dUo5bkw1SWc5TWdaWWRjdldhQlpwYmlpZVpzTWJD?=
 =?utf-8?B?eW5yWGRidXZydmhBS0VPd3BEMk1QVTdYeDdNRWRyWnFycDZORUxYTEVrd0Fm?=
 =?utf-8?B?RWhvWHVoYTdZb0h6dmNnNjZEc0NCODFFZS9lWmtKSWo1cFlaemVMOFNRaTRN?=
 =?utf-8?B?MlJsV2ppWEllNWY4TS9YUlp5dnZ2RXVYRS8xazRjQitTbHR3Y21mU3lkbHJ1?=
 =?utf-8?B?ZW1QcFV5NFZ2RnZhZGluK045TEUzV3hpVGRWOUk2V0htcWZsZzdxdFRnczVS?=
 =?utf-8?B?clRCeU1IbWsrdjU4dHFZWmpPaFBaNzBxR0hBbk4zOXRiT1J1WTFjQm0wMk0r?=
 =?utf-8?B?c2dKNmx5eS9LNnlldm4xYlM2bVJpN2FqOFBUb1EvZkRKQmMrZlJHdjYvTFA3?=
 =?utf-8?B?SC8zQTNmVUVscTJtaW1QOS9QaHJDSW9XR0pZeDFnc004SGNiUENQM0pQUHRF?=
 =?utf-8?B?QW9HMEZxbDBkT2NnUklyKzhYNytvQW1mb2tndjc5SXcwL3owdCtqcGpvSU04?=
 =?utf-8?B?SEU1T3lLNUlTYWMwamt2R3VUSXU5c2xEU1hhL1RhNG9IVVVFWWdDQUxzT2Zx?=
 =?utf-8?B?S0JYdGYxNm5Cckg5ZURYblZIUWJ6S1BYcDVQYmpyMFliS2JETkZZQVFZM0pV?=
 =?utf-8?B?Q2ZaYVIzendoMG5EVHNqbUNtOU1KSnZROUhPTTNLNFZuSWJLVGZUbklZM0Zs?=
 =?utf-8?B?YlNqWHo1cmxVR1YwaXU0N0ljMlowUnZZV1RmUEppazdkNXppMTBiV3A0U2do?=
 =?utf-8?B?U0o3aUw3NFQvWlFQVS9sVkhzZ1Fhd04rWEpWZUVSSDA1dkRObWZQazZlZFMr?=
 =?utf-8?B?c1BTNzNvSWVJZmZyMDFtbzNsV1dMQW9VckZHNWRnMlFqZDg2MWcrdWYzT0Ro?=
 =?utf-8?B?UTRiOE1sQmJiOFpCMWxMSllZaTlDWGYwTjZPdldiaVhJRkc5SGM4Wlp5UGFL?=
 =?utf-8?B?cmwrRklwZk1udG90WUw5WnRiL0IzMG9UdzZ5elNRQUtvMUc1a0kvWkNhR0hx?=
 =?utf-8?B?R09Lbkp2bXloK0xWbzVTNExsUk5tVUhQK0h3RkdlUGRrSW1qbFpSUnlRcUc5?=
 =?utf-8?B?d2hlL3IwV0IrTDR0M3hkMWRMUHE0L3F0QTIyRGN3MWZBM2FHTmhEckVmQ2ow?=
 =?utf-8?B?RFFiUDVkMjdudzZtVHVoOVlGdWN1WTVhTXU2dGwxZFZ4VHlCdVBnWUVYNmNV?=
 =?utf-8?B?S2pnNitCa2Z5K1JTQW9VSXdaZ0ZqbXMyUzdTU0p4b1NTRi9vZ1J5cjJjU1hN?=
 =?utf-8?B?OTVTUkpWZHAzOG52Z1RDNVZ4dGlrbHc2Si9QalNkREY1Vjl0dmRpeWZ6MUVI?=
 =?utf-8?B?SldhSHQvZVF5VkhaUEY4bGo1enlud1VscjhjVnpEaFpibUhPazFkbVVaaFdD?=
 =?utf-8?B?Y1BvSmU4SXZNT2Z0MVlheVBCMXY3eTU2eldnblVnQ2tCQllLZUdIbWduQ0t0?=
 =?utf-8?B?QkFtb2xVaFdjZjA1TmdWREhWQllmMzg5WUNuTUUySlNZMXdteCtqYXZkelkr?=
 =?utf-8?B?bHN5M3hKaTNZaWZFMjNQZFpXTEZFSTVRcFRFU2hZcVJOaGlpSTc2aWUrdDM4?=
 =?utf-8?B?WDRTRXBRR3hnK0phMEgwMTAzcU56eW4zS3NOYU9HRG1DSndGaEt5dzlWRXZF?=
 =?utf-8?B?UytJSlB6TTlNMXVJdWppYnYrOG1CQk1sOUo2Z3owSVlBOHRFUmtoSEZZUExM?=
 =?utf-8?Q?78RP6m6eCZ/6T2UmlO751gtLFb4FlS0WUgQ+w?=
X-Exchange-RoutingPolicyChecked: g7miviwpaFc2GS3qiSXutVyBHuMCR2PF+AP5qcu5xro1hVdVnx6+QQk/Tt7IaZttsjJGWZvY+0nQbbKtc7oN/NLpPedc4LdUl05Oth3EhoXSo9OjQZxGpGL6Zzq5Zs1t7Mh5vjkaYCjruTpluFga5G57I8iAJ1KgcpbwDLTkyS8N12LQIci2mCPtFmTBIDtZ3VfFIueg7zrNMTxvYhgx7RRg/8rBFaEoEqdFIYD+UsCPpCoI4USzPQvQT3jHw2YlYnLEPf34zvEngZmvXc8cZULzOT3mtxcR641w0iySnHC32cGJMZ2yYksXwmL4MUNTIRYMRCa69AG2VVqQiEAx0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a3a92-e8bf-4117-6aac-08de8f4b6bcb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:32:02.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s9bvxSvagHPoPJomETwuRSKXzyKbMCDNeY0+xVObFC416hpNfANmqXSTSngs8mebD2LYn9yT99o7Kj559n4wI7NSvbofXOI/pnD9jllRR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
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



On 3/25/2026 10:28 PM, Harry Wentland wrote:
> 
> 
> On 2026-03-24 13:01, Borah, Chaitanya Kumar wrote:
>> Hello Harry,
>>
>> Few thoughts on the series from Intel perspective.
>>
>> On 3/17/2026 9:33 PM, Harry Wentland wrote:
>>> When we merged the drm_plane color pipeline API the major gap
>>> that existed was the lack of a color-space conversion colorop.
>>> We deprecated any legacy drm_plane color properties, which
>>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>>> be used with the COLOR_PIPELINE property on a drm_plane. In
>>> practice this means that we can't use a COLOR_PIPELINE on
>>> YCbCr encoded framebuffers.
>>>
>>> This patchset adds a CSC colorop with the COLOR_RANGE and
>>> COLOR_ENCODING properties and implements support in VKMS and
>>> amdgpu.
>>>
>>
>> AFAIU, while COLOR_RANGE and COLOR_ENCODING were plane properties, they were more representative of how the framebuffer provided to the plane should be interpreted, rather than selecting a transformation. So using them to define CSC behavior is bit of a semantic drift.
>>
> 
> I guess CSC is misleading for this colorop. YUV conversion would
> describe it better.
> 
>> From, Intel's HW perspective we could re-use this CSC colorop but it would be
>> preferable to introduce new enums like "YCbCr709 to RGB", "YCbCr601 to RGB" as discussed in [1]. That way we can still represent the "RGB709 to RGB2020" conversion that Intel's fixed matrix CSC supports (instead of inventing a new colorop). We might need to change the name of colorop to something like Fixed Matrix to be inclusive of both YCbCr to RGB conversion and Primary conversion.
>>
> 
> At the core your CSC FF colorop and the one I'm trying to introduce are
> both backed by a fixed matrix. We could even express the range via the
> CSC FF colorop by introducing full and limited matrix variants for
> YCbCr to RGB conversion, like "YCbCr709 limited to RGB" (which is
> probably the norm for SDR/sRGB) and "YCbCr709 full to RGB" for full
> range YCbCr content.
> 
> For BT.601, BT.709, BT.2020 and full and limited range that would give
> us 6 enum entries, which is quite manageable.
> 
> Intel would then only advertise the full-range enums, plus the RGB-to-RGB
> CSC enums (like RGB709 to RGB2020) while AMD would advertise full and
> limited range YCbCr to RGB enums only, no RGB-to-RGB variants.
> 
> If this makes sense to you I'll be happy to rework my YUV conversion
> patches based on that. I think that'll work fine.
> 

I see you already have floated a new version of the series with this 
change. It should work in principle, I will have a look. Thank you for 
the changes.

>> Regarding the range property, we could re-use the COLOR_RANGE property as you have done. In the case of Intel, we would only expose DRM_COLOR_YCBCR_FULL_RANGE as supported for this CSC, and use a separate colorop to perform YUV range correction. This allows userspace to still pass limited-range framebuffers. I am assuming here that it matters for user-space if the conversion was done in limited or full range.
>>
> 
> It sounds like you'd need another colorop for range conversion. I wonder if
> it makes sense to also use the CSC FF block for that and introduce a
> "YUV limited to YUV full" range conversion enum. In that case naming the
> op named_matrix, might work better, as it can express range conversion,
> YUV conversion, and color space conversions.
> 

Even though limited to full conversion is not strictly a matrix 
operation, I guess it can be re-presented as one.

==
Chaitanya

> Harry
> 
>> [1] https://lore.kernel.org/dri-devel/20260306165307.3233194-2-chaitanya.kumar.borah@intel.com/
>>
>> ==
>> Chaitanya
>>
>>> An alternate way of possibly representing this has been proposed
>>> here:
>>> https://patchwork.freedesktop.org/patch/709860
>>>
>>> This code has been tested with IGT and an experimental KWin branch.
>>>
>>> IGT branch:
>>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-colorop
>>>
>>> KWin branch:
>>> https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut
>>>
>>> The kernel branch containing these changes, based on drm-misc-next
>>> can be found at:
>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop
>>>
>>> In order to successfully use this branch you might need a few
>>> bugfixes. The kernel tree containing those fixes plus these patches
>>> can be found at:
>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop-all
>>>
>>> Further background on this work can be found at:
>>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>>
>>> Cc: Alex Hung <alex.hung@amd.com>
>>> Cc: Daniel Stone <daniels@collabora.com>
>>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>>> Cc: Melissa Wen <mwen@igalia.com>
>>> Cc: Simon Ser <contact@emersion.fr>
>>>
>>> Harry Wentland (10):
>>>     drm/colorop: Add CSC colorop type
>>>     drm/colorop: Add CSC colorop initialization helper
>>>     drm/atomic: Add CSC colorop state handling
>>>     drm/vkms: Add CSC colorop support
>>>     drm/vkms: Add atomic check and matrix handling for CSC colorop
>>>     drm/amd/display: Implement CSC colorop support
>>>     drm/amd/display: Use GAMCOR for first TF if CSC is used
>>>     drm/amd/display: Check CSC colorop bypass before programming
>>>     drm/amd/display: Check actual state during commit_tail
>>>     drm/amd/display: Set color_space to plane_infos
>>>
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 115 +++++++++++++++++-
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  25 +++-
>>>    drivers/gpu/drm/drm_atomic.c                  |   6 +
>>>    drivers/gpu/drm/drm_atomic_uapi.c             |   8 ++
>>>    drivers/gpu/drm/drm_colorop.c                 |  91 ++++++++++++++
>>>    drivers/gpu/drm/vkms/vkms_colorop.c           |  64 +++++++---
>>>    drivers/gpu/drm/vkms/vkms_composer.c          |   5 +
>>>    drivers/gpu/drm/vkms/vkms_plane.c             |  50 +++++++-
>>>    include/drm/drm_colorop.h                     |  39 ++++++
>>>    include/uapi/drm/drm_mode.h                   |   1 +
>>>    11 files changed, 388 insertions(+), 30 deletions(-)
>>>
>>> -- 
>>> 2.53.0
>>>
>>
> 

