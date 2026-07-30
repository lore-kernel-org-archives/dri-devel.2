Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4EEC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D744D10EDFC;
	Thu, 30 Jul 2026 07:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OPQZX7zC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2883F10EDF7;
 Thu, 30 Jul 2026 07:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785396400; x=1816932400;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q4TFgLaCXtg9SayLj6mgajf4haoL2KoAZpBvwCovKm8=;
 b=OPQZX7zCJqCOTQn5rhuqylQciKXGs+XxY/SvmcYGVwjgCMbMvEEvdqVD
 xfJA2In9RG4zpvhiXu9K/DXO+2eX1UfKBFHGApbFfUBjmBbSJPIdpNqlH
 8P2xOaUsfziq3JDOGiAODv+POukfprxm3u/3rtoE4UHQF0WPjL2DgQOF1
 3LbriFD0xXJm4qlWe5uJdqPSWd3HMd37sW9Olw4B8qlFslMw4N2oKjW+R
 h8ZyyJesEVN70M5iJQJNcwtOCyqSsy8oKkPccwKhklYMUvt28WXnG23Hn
 zjQrWkz7iil9OK2mGF8BBdcBTY56a6OcipjSS+jiJmERxVu0/sBju4hVQ Q==;
X-CSE-ConnectionGUID: TLj0EDsPSwe8QsqN6Tlyhw==
X-CSE-MsgGUID: 37yxJ8WNQcS7+b8mx7iKfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97384683"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="97384683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:26:33 -0700
X-CSE-ConnectionGUID: 6qB+N5FrTymvto1W7GjicA==
X-CSE-MsgGUID: jkTwXEzOTHCWMJGOk+9EoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="284803541"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 00:26:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:26:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 00:26:32 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 00:26:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh7ZRwmJQNuLtHZ+7cqT+xOdGh7IV66ku7z4FU9tXum1JqP5RM7gZB7JJ6aAn5hXI6y2FIoTxiCgFdocgIva4a7TVAddUWDJOaASRuHVDH+b10IaFNbeZCXphlVALDg7n2ZBzoUi5jLPkhakLnSkWbpqBIlNqYLs6b6leexa7N/XJwRdj61r7NdYMdOuaJ78zebi/uU3m3mK0IwmX2LjUY9HR8gCGabnh+385nawM2FdbamKvn+i0P2RC45kOzteoG4GspNb72kqaClwFLYWfaQ6n3lqiUvfgTxO2tMXi4dnnOXg0SV+n5opDP2hOdB5kjaMwa+mXA3YJ9r0owq/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziBRpS23JmnSc/5XNrRHzcy5zzvVU6mUjGuoc3ugn78=;
 b=E3zkVE16YsJBKSbxMgS5wFRorIPMTyCyUXfmGZjrmwFAPevY6UHQA5A76VPrrKZ3pOlBo5mSgtXdA/COMe3bi9ej2eqO7LjiZcu1IIHFP9cosF1zZS/VNwJnIwIqKzaO0sghXeaUDk3HF7TloWhMc6gAXO3rVn1S5jM2L6rQ0BaGGlUWl9+VR340NRNPBmja4K5a5aMuSSzckQlRLSt1rhZcL9BLGTOkGfhDynjPIWV7nLgzHOGuTPSX/xiIJFpBuDGX5ARDWbo7hEADzZZTxNReY78GA4Q3CRabe9odqlxYUvMTrdcPO40EoHCK6vX3s7oL1CePxqXHUvjS/RvxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by IA3PR11MB9256.namprd11.prod.outlook.com (2603:10b6:208:57f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 07:26:24 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:26:24 +0000
Message-ID: <e1cb0cca-c1b6-4c95-b2dc-2f23535befe6@intel.com>
Date: Thu, 30 Jul 2026 12:56:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
 <amkCDzvNVZOXNz9N@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <amkCDzvNVZOXNz9N@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0350.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::18) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|IA3PR11MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: d018d77d-822f-4745-616c-08deee0bdc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: V7wF40870XnanV0qG5sLHEjcj1Tx72qAfhwXKceS7V6lFG1nr7WlWRH5q5yCyvybqwjL94y2l8bT7lN/i1jjhWzrpaTJQrfaSdcC2J6BXYuvRGtQ/yHH+hqyXbkFcXS18TgnrIDGcmYj562LIqLF0hSfTEJmpIvit1lcC4/7NbZBaG8ETijSTyhdYmkcnzhAJaYH35okgm9dZoOv0aRZ3KjUs50kApxyc0vPlyjaewQ8emURsw+PNVofXVl4zM1AyaE6UzsjTZuHPv7vhFxLb4KXNjf1uN5+leFQUDfDNV7SCoX8HustaNdttDoe802OzEWHUTHcvF9O0pLAcg0b+ZRhSoMY0ra24jXh0X31I5Zdb4eOitcU0evji/19igmwzbf1tYR6Wq9bwEQKbyq3kEnn1ai+9ot1AcJrUxClyseBAQFeGWcr6kZj1S+753Q2UDTbVyQ5F8uHI7eKyTOyD8U9NOS/bcfC+FOlcZXqQIhSFd4fJuMuWpfPCa0qpaaoyBKWPILtg/HRa7qFrfaVr+EDUVNejVasKm1byXCGwi6H9ByKLvdLWkT2xGJcMHpYI17ypsZFxyXwWYGKX8YmCdq2ry4SeQ+T1/4PW1D8zjysbPRdXt9R/1wZcyO29dUn81jWlDFmZAhPYihhWs7kSk3kt/bH7KLdW19X6w6D4XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFvUVI5KzhpSlZuUVJqZjRwVmNKNjFYazRRSVVBODgrelVSeDJsZDNzNDYw?=
 =?utf-8?B?UWRuMEFHTkFCYjBTTk9kblVqUzk3emQrTWkvUExDcHlZRm4zaFVncUJJdVBC?=
 =?utf-8?B?cGVWdllwekVndWRQWDFXWlU5R0E1SDVseEhSQ091eEcrc1ZIaVFMZVZ1TXIr?=
 =?utf-8?B?QmFMdHozUGhZRHRzUWVKeWZkRy8razBWeUUvM0NaS2puNkJyWU5jakViMnBB?=
 =?utf-8?B?MS9ObWdVYUQySUF6Z2VZSFdIRnlmUlpnNkpyRUNBTTBpWlNiVHVNUzR1MjdR?=
 =?utf-8?B?SWQranREeHdkQ1VmYXo3OHI5Um9IZnRXOElZOGo0SXJkTXNSWEJvOEVaUVM3?=
 =?utf-8?B?ODNBaFZDa3VXTmpKQ1dEV0M3S0E4UWhNSlllUTdHa0lDSVcwWlliU2ZIMTFQ?=
 =?utf-8?B?eWRrOTFFRytUYkN2RHJIbllUdFphV1BwOVAyVFo2Wm1vekpaUDVrL1I3ZUFJ?=
 =?utf-8?B?WHBnQkluTXI4dFB0V2Fqc1hlWllnVXNyczg3cGdQSE82UGNXQjlkVEh1bjdW?=
 =?utf-8?B?Y1czU3F3Wi9vRDhFN2hiUXdSUGYwMEwrUEtLUVpBa1JrbDdzZ3pRamRuSzZR?=
 =?utf-8?B?SEhrZkxTSGlEUmwwTXF0NGlOa1VsZDQreUJwdEpJUllaRDVPTVl4M1JVRmMr?=
 =?utf-8?B?QWhTSUZrNTdSUEkwYVYyY01ldEN5R3JNQ1U4SXo5b1MrMkJJcjZNNUpNWjVV?=
 =?utf-8?B?eVUzTGpxdmFLN1F1NW9tdDdMQlBuZzZuWEE0Um1SaWlyREs1dEE1dUNkejNT?=
 =?utf-8?B?ODdTcm8za0hCeDA1RW9ySWFxZjlvanRXNVVTK2pZRkxXY09nemNBSlJYdWpo?=
 =?utf-8?B?dEdwblE2UEhMY3A0WFI3OGVxdTlwWE50bnVMVHVTTldoaFdoUkszVVhpVEZs?=
 =?utf-8?B?Sk8vbHFDa01YVmVka3Z4bnZTSitXVHo1ekE5djhmLzNwZkFEU0UwaGRNR1Jy?=
 =?utf-8?B?eFQ0OHorQjN5WGViY3hSbUc0WGFoNjVpRUUyd0dZRWpxZ2xEaWIxZmxEd2U2?=
 =?utf-8?B?U2ZOUGJxT0tEQmQ4RGZIcFAvakEwa1E3UnAwMmpCNkRRSUhET0Z1aDRFZzN2?=
 =?utf-8?B?OGVtbnM0MEh0WkFOWXQzMm1UcEZqMnFyQmQ4NWkrZ1dDemU2OVlRVFdDRUo0?=
 =?utf-8?B?NWQ2aklYUmZRbFdlT3E3KzRCN3BpOXZRNFR1alYvQnJWb0M2WmRqd2pnb1dF?=
 =?utf-8?B?SVh6RkZpMDBTU052Y2JGNXBxT1p0TjNlK2pqL3c0L2lWN2dEZnp2T1hCTVhq?=
 =?utf-8?B?SXEvZ29uQkdkSHUwdmJpRnJldnhvem9ldVRXQlRXRWN2UXVYbHpCWG9KRnNI?=
 =?utf-8?B?T0xhN282QWlveHJ2eisrZHZIditnbVV4ejBPQVV4VUFJaENUTzlwWE5Ec0g5?=
 =?utf-8?B?L1BQbWpkTjl2blFJaENEVWpIL0ZrVnZyYW14VUJjMEhuN2F2WmhEZTlaRW41?=
 =?utf-8?B?TnExVWFsaGtaRGpKUVNsN0o1N01qNGJYdDM3N01nYUxFMmJjNEp3Nk15am9F?=
 =?utf-8?B?b3B0NkwzVUJPcEIzZXRKdGw4Y1ViekVEbXFFWDBLYmZIMUN6Y2EyLzhtSFY1?=
 =?utf-8?B?TjlBVlpkNndOaHVzbFY3Tzk4WWhmL1NkbzIycE5PdU9BZkMyckUwVk5yckVQ?=
 =?utf-8?B?QjByQVBVSmJsV2duZS9WbzZuN3BrNnZmYnhmcmdRdW9tS3JOblZsWmVSR1lF?=
 =?utf-8?B?QmFSMjZjTU1Xc2ExdnZBNG5XSzdDLzkwMkFnTmN0a0VXMHk5Q2paeDM2bjN6?=
 =?utf-8?B?Z1hRbHZOSVU3K1diS0ZYQ3ZKRGoyemZ3b3R2UisrUFRNd3QvRkgraC9XS3RT?=
 =?utf-8?B?eHZhM096M1BDcmZRNDlWZHYwb3ZDZk85aUlrT0NXRTJIVEpVWlNYc1BkaTJI?=
 =?utf-8?B?RnM0SDFzRGhFdHpObUFNNHRhbmdIM0d0aG9ydWFPbU80eW82elh3dDBZaTMy?=
 =?utf-8?B?dk5RSjJHbEV5TTJXalpoTFJCYUVxTnI5MXdmZ3gvTHBZeEU1ZjlHVEdES0VY?=
 =?utf-8?B?WC82Y3V5ZnpLYzgrT3ZDeDNLQlZ6NDYzbGFIKy91MFNPV1h3eDlTd3plMFln?=
 =?utf-8?B?UEhZODlRaHlKL3ltT3I4VTVDMnVlQU5ZS3JMYzNyVWYyMXc2MVdKMjd0V1hz?=
 =?utf-8?B?MnUrZXhhMjRMd25GS0FRQ0dpdnhlR1N4YThJMmV6MHdtZm1jZHlnWkR1THgv?=
 =?utf-8?B?WnJIaFZLTk96ZlhtUGtEeDI3Y0svcTlYb1hUNHV0ZDl2SERlcUNTUXB1UzB0?=
 =?utf-8?B?dkJHN3dkTms1K2o0a0RTL1VtaTJUNGRLVVZRYzludmdBam9ocU53Z3plVDFv?=
 =?utf-8?B?ZEF2Vi9FNzNLSHF6SDh0SUZqQityWjJXY0dKV29EYUx5TFkzcWo3MjJWWTV6?=
 =?utf-8?Q?09zSxHmKHvUOPUsI=3D?=
X-Exchange-RoutingPolicyChecked: sHsXw67kuMPLyXYYzb7CeKzx0zHIDgsK1qvK4pl/u1iek9VkggT7IgF3I3Mq0gcQunVHTVgVq+W1ffjs9ypNY8hvCqLIlpcIn9cR9v64KrW+SUWHa10B+lg3J1Z+/yB7NvriOsBlDDvpZ/c+DUx7K7aR/D5/Ld4o/ohQyDhAVXKEnpG+CLBH9HNJ1EFKc8w0AawGmc+yybSlpxraOmRt67MdWHnZUmdBi/NYSIt8KERqIafI4MHPE19BsVqvEA6QFeUaMOdnJ63c+uzwZAtGU+7PLH3QVUIVqLMYwjNZfHmTFA9dwIiJlc8pxUtjrQJd0nkcSOPu2guvEZmInFsP6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d018d77d-822f-4745-616c-08deee0bdc04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:26:24.2104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ8RO2JvZsVTpigphY9OV6te2VHi7Z2gQ79u3WWQPkJKxhn7KvuYhDIJ5NKza/NHm41fDpTHyr8ojDfrleuadzxAwARmMZ6FnpJXeUBiw9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9256
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


On 29-07-2026 12:55 am, Rodrigo Vivi wrote:
> On Fri, Jul 24, 2026 at 03:33:07PM +0530, Mallesh Koujalagi wrote:
>> Use fault-inject framework to trigger punit_error_handler()
>> for testing.
>>
>> Usage:
>>    echo 100 > .../inject_punit_error/probability
>>    echo 1   > .../inject_punit_error/times
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
>>   drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
>>   drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
>> index 5a3877fcb0f0..5599d493feca 100644
>> --- a/drivers/gpu/drm/xe/xe_debugfs.c
>> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
>> @@ -42,6 +42,7 @@
>>   
>>   DECLARE_FAULT_ATTR(gt_reset_failure);
>>   DECLARE_FAULT_ATTR(inject_csc_hw_error);
>> +DECLARE_FAULT_ATTR(inject_punit_error);
>>   
>>   static bool csc_hw_error_available(struct xe_device *xe)
>>   {
>> @@ -62,6 +63,8 @@ static struct {
>>   	{ .name = "inject_csc_hw_error",
>>   	  .attr = &inject_csc_hw_error,
>>   	  .is_visible = csc_hw_error_available },
>> +	{ .name = "inject_punit_error",
>> +	  .attr = &inject_punit_error },
>>   };
>>   
>>   /*
>> @@ -76,6 +79,7 @@ bool xe_fault_##name(void)				\
>>   
>>   FAULT_ACTION(gt_reset, gt_reset_failure)
>>   FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
>> +FAULT_ACTION(punit_error, inject_punit_error)
>>   
>>   static void xe_fault_inject_debugfs_register(struct xe_device *xe,
>>   					     struct dentry *root)
>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.h b/drivers/gpu/drm/xe/xe_debugfs.h
>> index cd56f7442b99..dd57914dd4f2 100644
>> --- a/drivers/gpu/drm/xe/xe_debugfs.h
>> +++ b/drivers/gpu/drm/xe/xe_debugfs.h
>> @@ -13,10 +13,12 @@ struct xe_device;
>>   #ifdef CONFIG_DEBUG_FS
>>   bool xe_fault_gt_reset(void);
>>   bool xe_fault_csc_hw_error(void);
>> +bool xe_fault_punit_error(void);
>>   void xe_debugfs_register(struct xe_device *xe);
>>   #else
>>   static inline bool xe_fault_gt_reset(void) { return false; }
>>   static inline bool xe_fault_csc_hw_error(void) { return false; }
>> +static inline bool xe_fault_punit_error(void) { return false; }
>>   static inline void xe_debugfs_register(struct xe_device *xe) { }
>>   #endif
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>> index 92b4181026cb..da06c16cf7ed 100644
>> --- a/drivers/gpu/drm/xe/xe_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> @@ -3,6 +3,7 @@
>>    * Copyright © 2026 Intel Corporation
>>    */
>>   
>> +#include "xe_debugfs.h"
>>   #include "xe_device.h"
>>   #include "xe_drm_ras.h"
>>   #include "xe_pm.h"
>> @@ -391,6 +392,22 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>>   	size_t rlen;
>>   	int ret;
>>   
>> +	/*
>> +	 * Only allow the injected PUNIT error once the DRM device is registered.
> That entirely defeats the purpose! :)
>
> Sashiko identified this corner case so I asked you to ensure that this is covered
> and to prove that you should provide a fault-inject with test case.
>
> But then you are skipping exactly the corner case. That makes absolutely no sense.

You are absolutely right!! Guarding the injection with 
xe->drm.registered was the wrong approach.

The correct fix is structural, we are splitting xe_ras_init function 
into xe_ras_init_early() (keep all bookkeeping) and

xe_ras_init() (called after  drm_dev_register in which 
xe_ras_process_errors now lives).


Thanks,

-/Mallesh

>> +	 * xe_ras_process_errors() also runs during probe (via xe_ras_init()), before
>> +	 * drm_dev_register() calls device_add() on the DRM minor's kdev. At that
>> +	 * point kdev->kobj.parent is not yet linked into the sysfs hierarchy, so
>> +	 * kobject_get_path() returns "/card0" instead of the real sysfs path.
>> +	 * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent with a wrong
>> +	 * DEVPATH that udev cannot resolve, silently dropping the event and leaving
>> +	 * the cold-reset recovery broken.
>> +	 */
>> +	if (xe->drm.registered && xe_fault_punit_error()) {
>> +		xe_err(xe, "[RAS]: PUNIT error injected\n");
>> +		punit_error_handler(xe);
>> +		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
>> +	}
>> +
>>   	if (!xe->info.has_sysctrl)
>>   		return XE_RAS_RECOVERY_ACTION_RESET;
>>   
>> -- 
>> 2.48.1
>>
