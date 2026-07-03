Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4FAC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC9010F695;
	Fri,  3 Jul 2026 07:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GeZChxWR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A8F10F695;
 Fri,  3 Jul 2026 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783063833; x=1814599833;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UGuPR1VVW3ZjU8rkGx87GeVoMk2E48fHzoyA6gLxUNY=;
 b=GeZChxWRHLkSGGDsHdkU4o6xk61J7OJpMgr1EybVuwt3SwbFKSdIvihO
 hF5ly5du1eiH++nFI5GZDzcT6xEVDcCYUNWLt8TSB+0rmcIBXyWVqqbGB
 TpSxdhLpvrJE2080VmtMxmQWUZLaGh8irnupHt89+MgxiP0i+38uEoChx
 Bkq/ImKUGSw3wOsgu9OWJH8IDDYMFEV2C4rf0zwIkpFZjVjcWbIyfXLxC
 CqyqPT3NC88FmfSQOEya+DhcR3m6OOUb2ek+QO7q6D06YBm/+ljkQqM+5
 iMKPb2UXlf1tmw0fM+kajNfNUg2URuP7FjVQz9bNcn1GqvhXb0XwLauzC Q==;
X-CSE-ConnectionGUID: Pf8UEc6WS+i+b+CB9lNkGQ==
X-CSE-MsgGUID: QhvWJD+xQdq7TiAmwgB60g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101352123"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101352123"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 00:30:33 -0700
X-CSE-ConnectionGUID: q/E1PI+NSG2e3E8LGsO8JQ==
X-CSE-MsgGUID: Grwi0Q6hR3ugxAP2j1eipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="277371772"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 00:30:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 00:30:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 00:30:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 00:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4wNEuJk8DlEzBjTmme3BdKlH7Lt+CIeO8GcLbL9Gq++1U4fEsbUAYIhertIW2DafXNNYn6WfnDjEcLnec7Swk4DfRX3E/0Umt9320xn891EZXOx35OQIkUnqLimZzBoOF6oIj7zzGPAztYRzLaluOPat96WDYBfvefVpOXiRruy/3Pu9PkP5ta+fEUJ3PqB7V+3154Up3UEgLWNL78722EyM7HSd/jNNBANBzFau3xYS3pOYRuYg0I3YqpwfMR5MkDXE+u9fe3/xEa5MfJeJQsGsZvP5cUnfFVWhmIboBq/cCWnlc6iXJSfefSjEfLp2Ep2GPNXFeexzNBqlv6GPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=164yM0u9oDXnO+BJ3JlqOgpgAZm5e+ROMlW2JFnpJfk=;
 b=iMlwgslA9KWbDPRkWRJE7iiWNhastJItb90fmf9q55a8NIa5/1hZ6m46yq/F4XvyMsQoqbTjULDsuLaIu1qKyAe0n6QtQ2RMFI0aEGT907Erd/aVHN8cdPUiBL+ia8qNmUpM8UfcoYu0fZ7umW5FrEfHNbxcVixgZhJR78XASx5pb2H8oaKuLrlDCgBV3RV8hzcb7kU29Hik5gLzJD2mEfNYmHwzw78MxSrdXTDrTckv89mePVADV3/CU95gwWl+ZLcFcDxBj7F6QdGx1ZqunjCJcE2rCk24Ho6ELvGSw8499Fe+Jwb6vn1XnqRq/vKPMjja76uYbifZAHRpQA76kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Fri, 3 Jul 2026 07:30:27 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 07:30:27 +0000
Message-ID: <09869e95-4526-428d-808e-74c6b1ebc207@intel.com>
Date: Fri, 3 Jul 2026 13:00:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] drm/xe/ras: Add support for error threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
 <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <dev@lankhorst.se>,
 <zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
 <michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
 <mallesh.koujalagi@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260623101043.255897-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::19) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7269c36e-0e7f-4363-7d78-08ded8d4f3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hKtbdrXXXmmmxICqTxEadRNdb0+Q4CH/46ZUNkM4CM/RtD5+00lONhxPWco+a6/cTg99sqDTcrD8K8ljEu+FYPnFM67PW+H3VJ16XBBvz3g7XY08dHH+o1OWNeEvkNd1s6xfmiUaHE+KPqEP2VL92hXsYDuDi83uDuN0qnhwUk+oXgLJBDubYACTE3wr+p9OImHWxH8IUMMqpB2st7HJsCjt4UXpCpENVGVn89npArWtfndi26BZ4hStLno+8/qmgapMh6CX9hQnPzUjKHvrqfDUigJ7VeLD+fHU95/wMZgA9d/CZoyG3zieqCUX02R4atvoMVY0V4sJUwqByVMf2FFIk7eR+50FdgLMuSiOHFJS3btiqioHvhseXudW0NxMGskBvNKA3toF9CgvZi0YcdgCkWoWfkejKws9LMnPd10+nU05+1hG8SwAr4rTRzWIgv02mnKeRj4ovvIyzQRfMF8wixi5apGhhP7x+YaTr7AK8Q/sdst1Uku1+leIYJjMhZiF8+82PfGaEtFQFM/J46ETJoF3kF6c0HwwQcW0Ax8IDbuHrZoE2iWqtNm7K5j/yVnZ5YOyUUPV2K94jKXZmAaOHaZANgdkAEy+tEuE+4zuhFZuA0eDWdK/jO6LvW0vyVAxsumXolZviiDdOzUt0HASEFPJLel/EiHdNdAqGdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJUM3lPTk9GeHhLMnpJd0o4bU1wOVl1SHprTGorbFBtODFya2M4N29zZDRm?=
 =?utf-8?B?amVLVGFEQ0xqQk8xNVhKMGpWbWFmekFYQzJhbTlBWklnRXVkRWJXa3Zja0Vq?=
 =?utf-8?B?SFhtUmJMSnVpWUhNLzJSMHRBR0d6U1J2WWYxd3c3VVNLbGQ2cUxhS1llcmZr?=
 =?utf-8?B?VUd5UjBUTytrL1Rnb3BZWmR1VDZPTXlPSkJCRHlYb0lwWjhUWnJnM0ZvUnpW?=
 =?utf-8?B?UFVzMFV6Wm5HY3Y4dDFFdzhvdDl5blYweTRocVIwcXpzcFhEWk5CdlpBU01q?=
 =?utf-8?B?K2R0bDh0eEMyTTBKYWNxMjNrSWpZdGxoSWhwMmFoRldCeU1qVjlpZXBtNG5r?=
 =?utf-8?B?ZnJ6ZHgzUWs5VEdTVVplZG5GQTRPdU9ZVm5PT0w2bXBJd1Z2Y1RnaFlyZ0R3?=
 =?utf-8?B?b1ZxeERQVmN5NkJ5ZEZwTmRES2x2TW9YVkdCbE5sdU5qRk9pc3Q5ZkRjdzdh?=
 =?utf-8?B?RUgxdFFMcmR5SU9BVDJaRExxZ1JmbVhuL01MMm9sbTFwNUs4aGZMVXJYQkJn?=
 =?utf-8?B?VGRnNkdZL2dlT3IrZmNQRFMyV2U3ZFNPVVZCZlIyK3RoWklBajMrZWgzbHFy?=
 =?utf-8?B?UFl0NnVLNk5WeGo0dnMveFRSMllZaUtLcWMvNHl3YVZyZFFYRHR3TmlVakMx?=
 =?utf-8?B?ekc1ZGtNYnc3TXdsUHpaZEg3Q21ESHp2T1RpSkpoTjlKVDNFMGQwSEY1Z1Fi?=
 =?utf-8?B?NVB1b0pBdVhhRmJKOHkvdzRzQkZ2NXJwZHM2aTJZeURaaS9WRkptdlJyTCts?=
 =?utf-8?B?SjNvYUtiT1NDRi9nTzFBcHNvN2FZQzhKWWRIRlNYdWtVd0VDUi9xanBZU1RX?=
 =?utf-8?B?Z1phbmZ6VElVRkhMakF4UXhMejhnZFlXSlZUQzU0cG5DMU8wdG0vNUlzYlJM?=
 =?utf-8?B?SHJuMU5KOUMrbXJSVEZlMk0xVzEvOXd2aEMxQkYxUy8rcGVLRmFac3lSQWdT?=
 =?utf-8?B?N2dvMHN1MzNScXlyZlowTURoRG13VlFacXJnQWdSWmZneDRyL0c3VEIrMDM1?=
 =?utf-8?B?eU5JMFNUUmJBL2ZSdmFrTGIza0RQQWtvdjBKQXBHTmM4dEdkZWdmcUExdXln?=
 =?utf-8?B?aUpMc3IvNmgwVEpqRTdOc29CWjRCeEpkS1BaQWJOZFd6Q1BWdm8zMmhlZnh6?=
 =?utf-8?B?N2NvdXYyWlVwYXUyTklCMVYrQlB1RjFGNW5hcU1JbGlDWUNGZmJsQmh4Y2No?=
 =?utf-8?B?eUp3T1F0U3haYXh0ZlFJUW9Uekxxbnk3ZDh2ZmJXN2NjRkNHZWhRd2JMbUVh?=
 =?utf-8?B?UFd2R09KdGUxOUdBMStvWmVTNThSbjhuU2tHT3pJSUl2d0o5VFJ4QzlFSjF4?=
 =?utf-8?B?Z2EyTUFMTzU4TU12SUw2K0NPZ2tmcTRZZmNkRWpUZlRHVzBGem9oQnIwVndR?=
 =?utf-8?B?Nkc1ZDdqcmNKTWpWT0ZpZVB3anBvZTJTaE5yZXlqcnE4ZUdaa2I1YVhoeFNV?=
 =?utf-8?B?WDZpcDBSNzIrRFB6WThRcXhwMDVpN3RzNFp4VWlrR2xqdTBsenFyWVgydHcr?=
 =?utf-8?B?eE5kbFdReHk0dFpjc1JOYkwyY2pOMVpKSW8yK1lENGxXNDJZT2tpa3MzUEly?=
 =?utf-8?B?M1V6SU95Q2NUMkE4WEhGYzJmMWxMa3Mxc1JFZ0o0TFhWQ2YvZzRUYXVWbVk1?=
 =?utf-8?B?aWE4NUFIendpcjdyYlRiUTg4M2V0eG9pQmVia3BhRzFSVXFDdmg2Ums0UzZL?=
 =?utf-8?B?anlzOXJoS0dzcjh2UGxJaXRSRThLSUhuT3k2ODdxKzhnZ05YUkZMUTZ3czk1?=
 =?utf-8?B?alQ5NmlZckNuMmlNajM0WHpXTVgxekE4S1J0Z0hyUkxWQ24rQzI2ZytQZStN?=
 =?utf-8?B?ZFMyNFRJb1FDNXFwQlRnSmVrbFZpalg4TGVCQUhYeWR4d1ZBaWNMNm0vRkVk?=
 =?utf-8?B?cWZTR1dPRUxsdlJEdnlmSkpCODQ1RHI3cHo4dU1Rd1RFWURSNXZac3RpNVhs?=
 =?utf-8?B?VDdkcURXYlRNYkJtc1ZQbkVGcm50RFhZMkZSdTh0c1krQWZHWElJUmtUVEti?=
 =?utf-8?B?bGxrRGluV1Y0S0R2UzNWeEVBY0UxSldlM0V6QmV4cVJDakdlWDZUb1p2RnZZ?=
 =?utf-8?B?MktSZktmdVNITkFtZ21sQ2U2QkV3T1Z4Nk12SXZ5bTh3WE5PZVB1UDh6akd6?=
 =?utf-8?B?aUpyRWRrQktOcHBvYWk1aWU5U2FVcVRTSjlhQjFGL1d3M041V29iMkk3dDlK?=
 =?utf-8?B?cmMzeFp4MXpLQmR2RUNMb0tYU05tZVVNY2ViZlQvdWNzV0wxa2xNSThuTFdx?=
 =?utf-8?B?SU1MRXJXVGRSN3BuVG1SbnZtMjJyWFE1TFNoUTJqNTVsOTNpdE1HZWpLdWlr?=
 =?utf-8?B?RUlicHFTSGpML2VRbDRURU9mZks0VVJXeGZISFhxRmpaeGhvRzVSUT09?=
X-Exchange-RoutingPolicyChecked: cZij+jdVoxz1V59RK9rGkKCVtJdP/wPOYpCcD51XGTkG3dZQ5lpdQ0uCClRISpEQnLvjV5UlQD8HC4qPGCPet2gYjxJeIEn22SSp6gSVlhuQ5t8lB7m/YyhX9gbDpXC2Ga+pLGELdfxaH+9S6tSVgZNuY2weLAQMKW8WB86PZE0qz9SXSBnz/SvD/zdJB62GKHOffPUlFJq0cQQRAPlbqIUC/qMkgkdFbgW+jf5lPy9RtXcMrW9DXOnxgt/c+eQdu+O7rz6zVPGMEc0nWCQPMOMVES0NnpBxjoztZeT+fRO3oa8T9dkgH/n9IbAuTtvmHJpadNvApYTorv09WAPgyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7269c36e-0e7f-4363-7d78-08ded8d4f3bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:30:26.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3XGXF9BV+SHCRenbtT9Ut0ufx4dFnEMWGljHjY4DZ3qW1F5nA7kPe4eGcSl26yIPvNpBg9hM4xqrAbd4TSszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
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


On 23-06-2026 15:39, Raag Jadav wrote:
> System controller allows getting/setting per counter threshold for
> correctable errors, which it uses to raise error events to the driver.
> Get/set it using the respective mailbox command.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>


Reviewed-by: Riana Tauro <riana.tauro@intel.com>

> ---
> v2: Add RAS operation status codes (Riana)
> v3: Reuse status codes and uapi mapping from counter series (Riana)
>      Access request/response counter using local pointer (Riana)
>      Mark unused field as reserved (Riana)
> v4: Make debug logs consistent (Riana)
>      Update kdoc (Riana)
> ---
>   drivers/gpu/drm/xe/xe_ras.c                   | 105 ++++++++++++++++++
>   drivers/gpu/drm/xe/xe_ras.h                   |   2 +
>   drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++++++
>   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
>   4 files changed, 162 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 44f4e1a3455b..afee8202d24e 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -270,6 +270,111 @@ int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
>   	return 0;
>   }
>   
> +/**
> + * xe_ras_get_threshold() - Get error counter threshold
> + * @xe: Xe device instance
> + * @severity: Error severity to be queried (&enum drm_xe_ras_error_severity)
> + * @component: Error component to be queried (&enum drm_xe_ras_error_component)
> + * @threshold: Counter threshold
> + *
> + * This function retrieves the error threshold of a specific counter based on
> + * severity and component.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold)
> +{
> +	struct xe_ras_get_threshold_response response = {};
> +	struct xe_ras_get_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class *counter;
> +	size_t len;
> +	int ret;
> +
> +	counter = &request.counter;
> +	counter->common.severity = drm_to_xe_ras_severity(severity);
> +	counter->common.component = drm_to_xe_ras_component(component);
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_THRESHOLD,
> +				  &request, sizeof(request), &response, sizeof(response));
> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	counter = &response.counter;
> +	*threshold = response.threshold;
> +
> +	xe_dbg(xe, "[RAS]: get threshold %u for %s %s\n", *threshold,
> +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
> +	return 0;
> +}
> +
> +/**
> + * xe_ras_set_threshold() - Set error counter threshold
> + * @xe: Xe device instance
> + * @severity: Error severity to be set (&enum drm_xe_ras_error_severity)
> + * @component: Error component to be set (&enum drm_xe_ras_error_component)
> + * @threshold: Counter threshold
> + *
> + * This function sets the error threshold of a specific counter based on
> + * severity and component.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold)
> +{
> +	struct xe_ras_set_threshold_response response = {};
> +	struct xe_ras_set_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class *counter;
> +	size_t len;
> +	int ret;
> +
> +	counter = &request.counter;
> +	counter->common.severity = drm_to_xe_ras_severity(severity);
> +	counter->common.component = drm_to_xe_ras_component(component);
> +	request.threshold = threshold;
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_SET_THRESHOLD,
> +				  &request, sizeof(request), &response, sizeof(response));
> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	ret = ras_status_to_errno(response.status);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: set threshold command failed with status %#x\n",
> +		       response.status);
> +		return ret;
> +	}
> +
> +	counter = &response.counter;
> +
> +	xe_dbg(xe, "[RAS]: set threshold %u for %s %s\n", response.threshold,
> +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
> +	return 0;
> +}
> +
>   /**
>    * xe_ras_init - Initialize Xe RAS
>    * @xe: xe device instance
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index ba0b0224df23..1aa43c54b710 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -15,6 +15,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   				      struct xe_sysctrl_event_response *response);
>   int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value);
>   int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component);
> +int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold);
> +int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold);
>   void xe_ras_init(struct xe_device *xe);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> index 6688e11f57a8..747b651880cd 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> @@ -121,4 +121,55 @@ struct xe_ras_clear_counter_response {
>   	/** @reserved1: Reserved for future use */
>   	u32 reserved1[3];
>   } __packed;
> +
> +/**
> + * struct xe_ras_get_threshold_request - Request structure for get threshold
> + */
> +struct xe_ras_get_threshold_request {
> +	/** @counter: Counter to get threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_get_threshold_response - Response structure for get threshold
> + */
> +struct xe_ras_get_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Current threshold of the counter */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[4];
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_request - Request structure for set threshold
> + */
> +struct xe_ras_set_threshold_request {
> +	/** @counter: Counter to set threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold to be set */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_response - Response structure for set threshold
> + */
> +struct xe_ras_set_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved */
> +	u32 reserved;
> +	/** @threshold: Updated threshold */
> +	u32 threshold;
> +	/** @status: Operation status */
> +	u32 status;
> +	/** @reserved1: Reserved for future use */
> +	u32 reserved1[2];
> +} __packed;
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> index 6e3753554510..10f06aa5c4b5 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> @@ -24,11 +24,15 @@ enum xe_sysctrl_group {
>    *
>    * @XE_SYSCTRL_CMD_GET_COUNTER: Get error counter value
>    * @XE_SYSCTRL_CMD_CLEAR_COUNTER: Clear error counter value
> + * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> + * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
>    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
>    */
>   enum xe_sysctrl_gfsp_cmd {
>   	XE_SYSCTRL_CMD_GET_COUNTER		= 0x03,
>   	XE_SYSCTRL_CMD_CLEAR_COUNTER		= 0x04,
> +	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> +	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
>   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
>   };
>   
