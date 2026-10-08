Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD91CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C7610FAA4;
	Thu,  8 Oct 2026 17:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7IS95bB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60D610FAA1
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iESBs8f0vEb02U+64K4a6gRRvhTXb94Aa2tA0hlzV41cbVGAvDiHVzO97+5ZjniUas4HE0e6n9CWn3eiHa15OlLcdeARvU2rTYcXqA4sj666yxz9+Ckt2YO20aympsmbzGn3RPdBSBgCz1/zeBjMM3Yb4Zgp40DWutlTIIgMMbKwrimc/idOJg8vXpttmYuNZfszFz6UwRq/ei72d8fuqFcgoSSx2pxplOF7QmSkidDA7qsU26SctDnxRGj5VtKjPmVDWvm4WCDkXq2OEEUEfjRq2R6mMt9AoDtehhHg4CZPzsWo2FVF+l9XscPTcj8pp4WeqrZNhXG7iZhIsgZLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyaxxgfMyOqDGdI45miw90v6VBFeW0braW+qDDOqiXk=;
 b=oAcliRruG9+LwSN7Dhj2Ku4P4ue5wYI7PiZXYiBXnvycxRi4XHasTbA4Y3NmPLiPPN++NXItvgguP/br+E1y0WlKvmfxtib2f66FDX5XZO+3QrfD6VVFypk9V43Fy3x2d5BLGbC/XR/WTADT6eSwDTaLfJrlXg+f01lYUHwyff1H0hi9hd5l/fwrRihb7G0b60UHzUgazRbtaVm2d444pxBYP3bsDBPy0WaN1PGQmlx/X+BuXSYOAPmb6hQd+QnXtMjH6z14drE0I1Wqq8mL10uORrXN4g8A4L1TU4A2299Pn62tR0T+ICnRJ2CbvjlopPcbaMwuUAQqft4mxhbznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyaxxgfMyOqDGdI45miw90v6VBFeW0braW+qDDOqiXk=;
 b=s7IS95bB76fs0wrmeFdHRcZprTdL7Qm5KoWTax+GpY3/bISjtESvKMXrYHwqPRkao90xJm133mysQ0/lJ/aQex5UlShX5wEyck+nOyeL6nhhjLk+cLoG9sjZ10ArjWMQbMl+pZf6+RMf9+Pki+EonU/BZhB3xGet5OO129odRIE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 17:26:09 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:26:09 +0000
Message-ID: <d3bc30ff-0dd0-46ac-9d92-444ff9b50fd9@amd.com>
Date: Thu, 8 Oct 2026 10:26:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/19] accel/amdxdna: Add CERT firmware version support
To: Lizhi Hou <lizhi.hou@amd.com>,
 "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
 "karol.wachowski@linux.intel.com" <karol.wachowski@linux.intel.com>,
 "Zhen, Max" <Max.Zhen@amd.com>, "ogabbay@kernel.org" <ogabbay@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Santan, Sonal" <sonal.santan@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-4-yidong.zhang@amd.com>
 <0e6284cc-e55f-e518-c61d-5e72ac50f45d@amd.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <0e6284cc-e55f-e518-c61d-5e72ac50f45d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffa44e6-af9d-4bcd-8493-08df25613e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: GRPP0QaLlcivwHcyANtN0ktFwg8rs0EM9j9KSkfEtLq8Xfv0Qi1pPEhnZ+VG1mHO0FKoe6jW7Z+QgKp3lmPPCa1kfVWL9JDJxTypMOmrjgo0nHKR8E77X+84+rHkpqGc72/hRtlq/LG88gPpnk1CWqcoWWwqwdbpju211r7ulbmG1a7Cm7RC1TyxhB96GbhD8m2/mmrWDP4saK4pXKvbOsSVGO28QfmTGWK4J1ltyTT3pI0mMjiGm+bFG84tVD8LXQaNM9a0ETcDmvn8EqbctpT+rzkoh9sFrUc4mVVWTZDSIwL/kD8goXVSFhaAWM7tgLM7PsUFwW7a3pH4+HFcWol8a4M92zOvv+4frWp1j7Ef1XZ+NhT0bsvRld+Ehzu6EqYaH9hBDzzmgk8ylaN8Xwh3J4gZYCYkmR95osub8Exp0fD+k8DlyAW0K2yEPB8/hK3kqxEAq6JqkxkDWrAm6R/36sPywbPBqIDCHccylSqBBEoTU32mpwWT50mMdIcJPHTFW5NgWVZj6LgHgWYoFmaPm39PpJH3VsxR1rcfsXh+K8Iu65+ITgVg4kTPQxr4+M9LZ9IHkRJQ0cLyGfbIpnuxtdYHS0RSSaoBqtjmpM3ymDopYJApKMzyyOat7OifpTI9Z5gnbE5oDdR56O6VFDo3q3s8TGJzr3YESLjjbeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZBb3BpaEdHeG5FMmVXS09SQXlYbUI2bnVwN2xpNGgxUEl1djNOSklOT1VQ?=
 =?utf-8?B?NmllUkFSc0RwWU51V25ENDROMit3L29JeXl2ZklXd1JWbkZPaEkyWXA0TkZZ?=
 =?utf-8?B?YWp0bEVYSEZGRFBMbU0zaFc5bDc4NGFVVi81WndxUzZVUGRabTVjaHdZUXUv?=
 =?utf-8?B?REtlRTV2V2Q0QS9xU0xkUFd6Y2N6T1dQVVBnYzNpSnpVSHdlYzRGQlVDQ3dY?=
 =?utf-8?B?STV3ZmJaVHBVZ1JhMDJMa1pJNkI0RE5VMjAzdmpyb0krWkh5bmpnVWJHU0gw?=
 =?utf-8?B?NW5mVHQwNllxQ0ZnMSt1MjlHVURZVklkYkVrTWFqN2s1U3BBY1dRSWFjZVM1?=
 =?utf-8?B?RGt6WEY3UzcvVGtuRFFaVnp5b1cvU0tnaFZNOXVsNGVYeDl1RjVvaGUvWW1V?=
 =?utf-8?B?UXJrOThrY1hyS2ZYaGRNcS9kdHlNcklBWVY1dGRyUVBQMERrL3htNkpIU0Fl?=
 =?utf-8?B?Mi8xOHVhaTJUMkRaQjlZTW1rVjJDNEcyalA1V1JjOVlaVXpMM0s2alAraXEw?=
 =?utf-8?B?dlBnYXZMQW44eEg1ak9SUWxoZWpSMm1FT2xuS3g5WEdUMEFsd255ejZIaVA2?=
 =?utf-8?B?dG04NWU1b3RZSDB3d2FOM1ljaTdhcGttTlVJZXZ1emNiay91SVcxdVdBYWVu?=
 =?utf-8?B?ZGhKQ0l6YzVOa21DUEthVDZEb0YxTU1tUHh1Z0hGMFFlcTI5KzlmTjNjcTlu?=
 =?utf-8?B?TzlRU3NyRGZjUG1LYVFRaE9Bb2R0U3lpZVkrTjFpQzZlMUp6REk5K0JPVzNk?=
 =?utf-8?B?ZlZZRThRRnRsZ2tIK2Z2VG04a0lUTVlKaHBsQ0licHZCWFJXOVZvZEx6TUtF?=
 =?utf-8?B?cVE4S0QvOXFkWll5VmxRcUsrQ0FlWFhtT1N3dG42MWJFVUV2R3ZvZUNYSnFr?=
 =?utf-8?B?WjlyajEydVRlOThXcUN5M2U2Z2hJMWw2dXlLZUN3cWhjb1c2SURHVkszMjNQ?=
 =?utf-8?B?NEFyd1hhbXZZNjhHVmpaN05RTlJmTDBpMTdjcE5aUVpNN010QVNmSkN2ZFJp?=
 =?utf-8?B?dnd2SEpIb2hKU1pmbEdZVG5nc29OVnRTR3h4VCs3Q05ySFIvN0Z3cUNQOU9M?=
 =?utf-8?B?TnNGRFBmMzlOZDV4VzNTZ3U3eWpDZjJvQ3piblNoUHV0K0g3eUh3OTNWVUpX?=
 =?utf-8?B?OEtvYWxQMmFhSjZZazdibmY3bjRZQzFlYjBsQUVUMEUwSy9yai9lWkVBUTdD?=
 =?utf-8?B?K2ZxVFZmR2diL0Y1V0J0UnIveVF6Z2g1dytkeHJFRmpHNTZ1VlM5K2puK1Vr?=
 =?utf-8?B?Wmw5TW9lMGc1TEp1RjdjdTlHUTdSQXp3andKdFJuQTE0QVFpY1BiRGRVc2Ny?=
 =?utf-8?B?SlV3dTUwYVhQay9pbXp5Y1JTY2J0anI4U0RSeUFYSTc5dHZBdnRGK1ZlSnFm?=
 =?utf-8?B?TWRDSDBuUjMyQnZ6L1BVeC9yWUFCTkh4MmVqTGlzc2pIQVZac1FDSDZvZjgv?=
 =?utf-8?B?QStYbUdWN2dwd014WFljWGRjckEvYVR1bURLS2RuSnlCVjB2cC9FWUtWTHpV?=
 =?utf-8?B?SUlxeGRENnB5bmt3UDFndDd4OVcva3hWaEg4V3VCTmZVVVE5Q0dvcFNYdmVt?=
 =?utf-8?B?Zjc2c1FKTmRGRi9hb1BQSHB3K2FlNzZWYmgyV2htV3JPckNGcE9TQ0hBU3pY?=
 =?utf-8?B?V1RLRmU5THBDQ2oxVGlweTFuQVA1WlhobHU1Rjl1OVRpL3FBMGlNQzlVYk55?=
 =?utf-8?B?WkRrR1FERnRwWnZkeXJiSys4N2dtNVU1cU5kcEdnTzJBRVBNOG1iUzZNeGhH?=
 =?utf-8?B?b1pOWUcreWdrNVlLWGhzdjBaVWhKeUhVMEE0VkNub3psczhFOHdPZlNVZWxi?=
 =?utf-8?B?UUR5K1AvVDJWbUNoV1p0bGc3akRtbUNIVUJiY2drKzIrc09mWENoSjJ3M1RV?=
 =?utf-8?B?N3hNSnVtbkNTcmEvaFdKMExST2svckpCMC9PRXdEd2dxaHdmdi9CQVNxYTQ0?=
 =?utf-8?B?Y2NEV0ErYUJ4WndLOWsxS08vVGVnaE1GRlhEL05weTJVT01Kd25tR0VKTFNt?=
 =?utf-8?B?OFkwSHR4ZzNPWjZMaHVwRkJ4MlgzWU02SlVnTUN6N2QvOU84RlJuVnhNNVB5?=
 =?utf-8?B?Y3FkWUFkVjdDdkN0bG94L1YzVEhCRzRUUjZoNDZwNUNhSHkwWVdSdDlWc0FX?=
 =?utf-8?B?M2lJcVJGRmRFQ1FBSmhBTXo1LzlSSWVWY0FmYmg2OExmWFJiL3dXbS9hdTNE?=
 =?utf-8?B?VUU1MEEzeExwVWhsWVU0cERaQzBzNG0wSWxMb29kL0t2Z09RLzVsMzdtSlIx?=
 =?utf-8?B?dnhNM0lJZCtMRThmZFU4WEVmQ045SVNUL214SG5WVnpvOUZET05NNTJmdHc5?=
 =?utf-8?B?eWJINlRXOHlzTzgxYmllYjkrbktlM1JvbGs1NWtsZHk1K25wV0NuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffa44e6-af9d-4bcd-8493-08df25613e1e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:26:09.5142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eJGMOdlzsqpUo0dsmVpjVkP47vHMM4wTjIbIWw6p51lQC68+6haejrjR3hxLuZXo1Kpfhk8W2RiAsPmw0kEew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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


On 10/8/2026 10:12 AM, Lizhi Hou wrote:
> On 10/7/26 20:23, David Zhang wrote:
>> Add support to query and validate CERT firmware version:
>> - Add mailbox opcodes and structs to query NPU firmware version (identify)
>>     and CERT firmware version.
>> - Unify firmware version storage by using struct
>>     amdxdna_drm_query_firmware_version across the driver.
>> - Introduce aie_check_cert_protocol() and cert_feature_tbl to validate
>>     CERT firmware host queue protocol compatibility against driver
>>     capabilities.
>> - Add helper functions amdxdna_get_firmware_version() and
>>     amdxdna_get_aie_version() to share version query handling across
>>     generations.
>>
>> Note on patch ordering:
>> Introducing CERT firmware protocol validation prior to the firmware 6.0
>> upgrade ensures host queue protocol compatibility (host_queue_major/minor)
>> is validated before the host queue layout restructure, preserving
>> bisectability.
> Please remove the patch ordering statement.
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> ---
>>    drivers/accel/amdxdna/aie.c             | 45 ++++++++++++++++++++---
>>    drivers/accel/amdxdna/aie.h             |  9 ++++-
>>    drivers/accel/amdxdna/aie2_message.c    |  4 +--
>>    drivers/accel/amdxdna/aie2_pci.c        | 47 +++----------------------
>>    drivers/accel/amdxdna/aie2_pci.h        |  4 +--
>>    drivers/accel/amdxdna/aie4_message.c    | 45 +++++++++++++++++++++++
>>    drivers/accel/amdxdna/aie4_msg_priv.h   | 30 ++++++++++++++++
>>    drivers/accel/amdxdna/aie4_pci.c        | 17 ++++++++-
>>    drivers/accel/amdxdna/aie4_pci.h        | 11 ++++++
>>    drivers/accel/amdxdna/amdxdna_pci_drv.h | 10 ++----
>>    drivers/accel/amdxdna/amdxdna_sysfs.c   |  2 +-
>>    drivers/accel/amdxdna/npu3_regs.c       |  7 ++++
>>    12 files changed, 169 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
>> index dd6f36f222c7..01a439c0ccf4 100644
>> --- a/drivers/accel/amdxdna/aie.c
>> +++ b/drivers/accel/amdxdna/aie.c
>> @@ -65,13 +65,12 @@ int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg)
>>    	return ret;
>>    }
>>    
>> -int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
>> +static int aie_check_protocol_impl(struct aie_device *aie, u32 fw_major, u32 fw_minor,
>> +				   const struct amdxdna_fw_feature_tbl *feature)
>>    {
>> -	const struct amdxdna_fw_feature_tbl *feature;
>>    	bool found = false;
>>    
>> -	for (feature = aie->xdna->dev_info->fw_feature_tbl;
>> -	     feature->major; feature++) {
>> +	for (; feature && feature->major; feature++) {
>>    		if (feature->major != fw_major)
>>    			continue;
>>    		if (fw_minor < feature->min_minor)
>> @@ -88,6 +87,44 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
>>    	return found ? 0 : -EOPNOTSUPP;
>>    }
>>    
>> +int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
>> +{
>> +	return aie_check_protocol_impl(aie, fw_major, fw_minor,
>> +				       aie->xdna->dev_info->fw_feature_tbl);
>> +}
>> +
>> +int aie_check_cert_protocol(struct aie_device *aie, u32 cert_major, u32 cert_minor)
>> +{
>> +	return aie_check_protocol_impl(aie, cert_major, cert_minor,
>> +				       aie->xdna->dev_info->cert_feature_tbl);
>> +}
> This seems duplicate with aie2_check_protocol().
>
>
> Thanks,
>
> Lizhi

Will fix these in next patch V4.

Thanks,

David

>
>> +
>> +int amdxdna_get_aie_version(struct amdxdna_client *client,
>> +			    struct amdxdna_drm_get_info *args,
>> +			    struct amdxdna_drm_query_aie_version *version)
>> +{
>> +	u32 buf_sz;
>> +
>> +	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
>> +	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +int amdxdna_get_firmware_version(struct amdxdna_client *client,
>> +				 struct amdxdna_drm_get_info *args,
>> +				 struct amdxdna_drm_query_firmware_version *version)
>> +{
>> +	u32 buf_sz;
>> +
>> +	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
>> +	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>    static void amdxdna_update_vbnv(struct amdxdna_dev *xdna,
>>    				const struct amdxdna_rev_vbnv *tbl,
>>    				u32 rev)
>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>> index 0483d582b7f8..899399756661 100644
>> --- a/drivers/accel/amdxdna/aie.h
>> +++ b/drivers/accel/amdxdna/aie.h
>> @@ -28,6 +28,7 @@ struct aie_device {
>>    	struct psp_device *psp_hdl;
>>    	struct smu_device *smu_hdl;
>>    
>> +	struct amdxdna_drm_query_aie_version version;
>>    	struct amdxdna_drm_query_aie_metadata metadata;
>>    };
>>    
>> @@ -96,6 +97,7 @@ void aie_dump_mgmt_chann_debug(struct aie_device *aie);
>>    void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
>>    int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
>>    int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>> +int aie_check_cert_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>>    void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>>    int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
>>    			 struct amdxdna_drm_get_info *args);
>> @@ -103,7 +105,12 @@ void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
>>    			       dma_addr_t *dma_addr);
>>    void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
>>    			     void *cpu_addr, dma_addr_t dma_addr);
>> -
>> +int amdxdna_get_aie_version(struct amdxdna_client *client,
>> +			    struct amdxdna_drm_get_info *args,
>> +			    struct amdxdna_drm_query_aie_version *version);
>> +int amdxdna_get_firmware_version(struct amdxdna_client *client,
>> +				 struct amdxdna_drm_get_info *args,
>> +				 struct amdxdna_drm_query_firmware_version *version);
>>    /* aie_psp.c */
>>    struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
>>    int aie_psp_start(struct psp_device *psp);
>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
>> index 56b919b350ac..d95a18af9b09 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -149,7 +149,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>>    }
>>    
>>    int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>> -				struct amdxdna_fw_ver *fw_ver)
>> +				struct amdxdna_drm_query_firmware_version *fw_ver)
>>    {
>>    	DECLARE_AIE_MSG(firmware_version, MSG_OP_GET_FIRMWARE_VERSION);
>>    	int ret;
>> @@ -160,7 +160,7 @@ int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>>    
>>    	fw_ver->major = resp.major;
>>    	fw_ver->minor = resp.minor;
>> -	fw_ver->sub = resp.sub;
>> +	fw_ver->patch = resp.sub;
>>    	fw_ver->build = resp.build;
>>    
>>    	return 0;
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
>> index d2fa46e4d3a4..62ee7deb6f92 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -206,15 +206,16 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
>>    
>>    static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
>>    {
>> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>>    	int ret;
>>    
>> -	ret = aie2_query_firmware_version(ndev, &ndev->aie.xdna->fw_ver);
>> +	ret = aie2_query_firmware_version(ndev, &xdna->fw_ver);
>>    	if (ret) {
>>    		XDNA_ERR(ndev->aie.xdna, "query firmware version failed");
>>    		return ret;
>>    	}
>>    
>> -	ret = aie2_query_aie_version(ndev, &ndev->version);
>> +	ret = aie2_query_aie_version(ndev, &ndev->aie.version);
>>    	if (ret) {
>>    		XDNA_ERR(ndev->aie.xdna, "Query AIE version failed");
>>    		return ret;
>> @@ -684,44 +685,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
>>    	return 0;
>>    }
>>    
>> -static int aie2_get_aie_version(struct amdxdna_client *client,
>> -				struct amdxdna_drm_get_info *args)
>> -{
>> -	struct amdxdna_drm_query_aie_version version;
>> -	struct amdxdna_dev *xdna = client->xdna;
>> -	struct amdxdna_dev_hdl *ndev;
>> -	u32 buf_sz;
>> -
>> -	ndev = xdna->dev_handle;
>> -	version.major = ndev->version.major;
>> -	version.minor = ndev->version.minor;
>> -
>> -	buf_sz = min(args->buffer_size, sizeof(version));
>> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>> -		return -EFAULT;
>> -
>> -	return 0;
>> -}
>> -
>> -static int aie2_get_firmware_version(struct amdxdna_client *client,
>> -				     struct amdxdna_drm_get_info *args)
>> -{
>> -	struct amdxdna_drm_query_firmware_version version;
>> -	struct amdxdna_dev *xdna = client->xdna;
>> -	u32 buf_sz;
>> -
>> -	version.major = xdna->fw_ver.major;
>> -	version.minor = xdna->fw_ver.minor;
>> -	version.patch = xdna->fw_ver.sub;
>> -	version.build = xdna->fw_ver.build;
>> -
>> -	buf_sz = min(args->buffer_size, sizeof(version));
>> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
>> -		return -EFAULT;
>> -
>> -	return 0;
>> -}
>> -
>>    static int aie2_get_power_mode(struct amdxdna_client *client,
>>    			       struct amdxdna_drm_get_info *args)
>>    {
>> @@ -1036,7 +999,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>>    		ret = amdxdna_get_metadata(&ndev->aie, client, args);
>>    		break;
>>    	case DRM_AMDXDNA_QUERY_AIE_VERSION:
>> -		ret = aie2_get_aie_version(client, args);
>> +		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
>>    		break;
>>    	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
>>    		ret = aie2_get_clock_metadata(client, args);
>> @@ -1048,7 +1011,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>>    		ret = aie2_get_hwctx_status(client, args);
>>    		break;
>>    	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>> -		ret = aie2_get_firmware_version(client, args);
>> +		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>>    		break;
>>    	case DRM_AMDXDNA_GET_POWER_MODE:
>>    		ret = aie2_get_power_mode(client, args);
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
>> index a5fd71329b93..b31f73082c17 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -74,7 +74,6 @@ enum aie2_sram_reg_idx {
>>    };
>>    
>>    struct amdxdna_client;
>> -struct amdxdna_fw_ver;
>>    struct amdxdna_hwctx;
>>    struct amdxdna_sched_job;
>>    
>> @@ -150,7 +149,6 @@ struct amdxdna_dev_hdl {
>>    	void			__iomem *mbox_base;
>>    
>>    	u32				total_col;
>> -	struct amdxdna_drm_query_aie_version version;
>>    	struct aie2_exec_msg_ops	*exec_msg_ops;
>>    	struct drm_gpu_scheduler	*hwctx_sched;
>>    	struct ida			hwctx_sched_ida;
>> @@ -263,7 +261,7 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
>>    int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>>    			    struct amdxdna_drm_query_aie_metadata *metadata);
>>    int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>> -				struct amdxdna_fw_ver *fw_ver);
>> +				struct amdxdna_drm_query_firmware_version *fw_ver);
>>    int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>>    			  struct app_health_report *report);
>>    int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *rev);
>> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
>> index 88037edbb02a..b137a2a40b34 100644
>> --- a/drivers/accel/amdxdna/aie4_message.c
>> +++ b/drivers/accel/amdxdna/aie4_message.c
>> @@ -64,6 +64,51 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>>    	return 0;
>>    }
>>    
>> +int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>> +				    struct amdxdna_drm_query_firmware_version *fw_version)
>> +{
>> +	DECLARE_AIE_MSG(aie4_msg_identify, AIE4_MSG_OP_IDENTIFY);
>> +	int ret;
>> +
>> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	fw_version->major = resp.fw_major;
>> +	fw_version->minor = resp.fw_minor;
>> +	fw_version->patch = resp.fw_patch;
>> +	fw_version->build = resp.fw_build;
>> +
>> +	return 0;
>> +}
>> +
>> +int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>> +				     struct amdxdna_drm_query_firmware_version *cert_version)
>> +{
>> +	DECLARE_AIE_MSG(aie4_msg_query_cert_firmware_version,
>> +			AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION);
>> +	int ret;
>> +
>> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = aie_check_cert_protocol(&ndev->aie,
>> +				      resp.host_queue_major, resp.host_queue_minor);
>> +	if (ret) {
>> +		XDNA_ERR(ndev->aie.xdna, "host queue %d.%d is not supported",
>> +			 resp.host_queue_major, resp.host_queue_minor);
>> +		return ret;
>> +	}
>> +
>> +	cert_version->major = resp.major_version;
>> +	cert_version->minor = resp.minor_version;
>> +	cert_version->patch = resp.hotfix;
>> +	cert_version->build = resp.build;
>> +
>> +	return 0;
>> +}
>> +
>>    int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>>    {
>>    	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
>> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
>> index af0866045b91..5b97c8057de0 100644
>> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
>> @@ -10,8 +10,10 @@
>>    #include <linux/types.h>
>>    
>>    enum aie4_msg_opcode {
>> +	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
>>    	AIE4_MSG_OP_SUSPEND                          = 0x10003,
>>    	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
>> +	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
>>    
>>    	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
>>    	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
>> @@ -30,6 +32,18 @@ enum aie4_msg_status {
>>    	MAX_AIE4_MSG_STATUS_CODE = 0x4,
>>    };
>>    
>> +struct aie4_msg_identify_req {
>> +	__u32 rsvd;
>> +} __packed;
>> +
>> +struct aie4_msg_identify_resp {
>> +	enum aie4_msg_status status;
>> +	__u32 fw_major;
>> +	__u32 fw_minor;
>> +	__u32 fw_patch;
>> +	__u32 fw_build;
>> +} __packed;
>> +
>>    struct aie4_msg_suspend_req {
>>    	__u32 rsvd;
>>    } __packed;
>> @@ -132,6 +146,22 @@ struct aie4_msg_aie4_tile_info_resp {
>>    	struct aie4_tile_info info;
>>    } __packed;
>>    
>> +struct aie4_msg_query_cert_firmware_version_req {
>> +	__u32 resvd;
>> +} __packed;
>> +
>> +struct aie4_msg_query_cert_firmware_version_resp {
>> +	enum aie4_msg_status status;
>> +	__u8 major_version;
>> +	__u8 minor_version;
>> +	__u8 git_hash[41];
>> +	__u8 date[11];
>> +	__u8 hotfix;
>> +	__u8 build;
>> +	__u16 host_queue_major;
>> +	__u16 host_queue_minor;
>> +} __packed;
>> +
>>    #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
>>    
>>    struct aie4_msg_attach_work_buffer_req {
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
>> index f81c43a1f884..dbaf90af620f 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -277,7 +277,22 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
>>    
>>    static int aie4_query(struct amdxdna_dev_hdl *ndev)
>>    {
>> -	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
>> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +	int ret;
>> +
>> +	ret = aie4_query_npu_firmware_version(ndev, &xdna->fw_ver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = aie4_query_cert_firmware_version(ndev, &ndev->cert_version);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>>    }
>>    
>>    static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
>> index c6219544dc0f..8c62ee6a9b23 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.h
>> +++ b/drivers/accel/amdxdna/aie4_pci.h
>> @@ -57,6 +57,13 @@ struct amdxdna_dev_hdl {
>>    	void				*work_buf;
>>    	dma_addr_t			work_buf_addr;
>>    	u32				work_buf_size;
>> +
>> +	struct amdxdna_drm_query_firmware_version cert_version;
>> +};
>> +
>> +enum aie4_fw_feature {
>> +	AIE4_HSA_COMMAND = 5,
>> +	AIE4_FEATURE_MAX
>>    };
>>    
>>    /* aie4_message.c */
>> @@ -64,6 +71,10 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>>    			    struct amdxdna_drm_query_aie_metadata *metadata);
>>    int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>>    int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
>> +int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>> +				    struct amdxdna_drm_query_firmware_version *fw_version);
>> +int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>> +				     struct amdxdna_drm_query_firmware_version *cert_version);
>>    
>>    /* aie4_ctx.c */
>>    int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 84c8973e9197..0002e6ef32ba 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -99,16 +99,10 @@ struct amdxdna_dev_info {
>>    	size_t				dev_heap_max_size;
>>    	const struct amdxdna_dev_priv	*dev_priv;
>>    	const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
>> +	const struct amdxdna_fw_feature_tbl *cert_feature_tbl;
>>    	const struct amdxdna_dev_ops	*ops;
>>    };
>>    
>> -struct amdxdna_fw_ver {
>> -	u32 major;
>> -	u32 minor;
>> -	u32 sub;
>> -	u32 build;
>> -};
>> -
>>    struct amdxdna_carveout;
>>    
>>    struct amdxdna_dev {
>> @@ -120,7 +114,7 @@ struct amdxdna_dev {
>>    	struct mutex			dev_lock; /* per device lock */
>>    	struct list_head		client_list;
>>    	struct mutex			client_lock; /* client_list */
>> -	struct amdxdna_fw_ver		fw_ver;
>> +	struct amdxdna_drm_query_firmware_version fw_ver;
>>    	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
>>    	struct workqueue_struct		*notifier_wq;
>>    
>> diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/amdxdna/amdxdna_sysfs.c
>> index d9e359ee8182..e20b7fb1e5d1 100644
>> --- a/drivers/accel/amdxdna/amdxdna_sysfs.c
>> +++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
>> @@ -37,7 +37,7 @@ static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr
>>    	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
>>    
>>    	return sprintf(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
>> -		       xdna->fw_ver.minor, xdna->fw_ver.sub,
>> +		       xdna->fw_ver.minor, xdna->fw_ver.patch,
>>    		       xdna->fw_ver.build);
>>    }
>>    static DEVICE_ATTR_RO(fw_version);
>> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
>> index 8d287ef32fff..e82bc0a4f597 100644
>> --- a/drivers/accel/amdxdna/npu3_regs.c
>> +++ b/drivers/accel/amdxdna/npu3_regs.c
>> @@ -42,6 +42,11 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>>    	{ 0 }
>>    };
>>    
>> +static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
>> +	{ .features = BIT_U64(AIE4_HSA_COMMAND), .major = 1, .min_minor = 0 },
>> +	{ 0 }
>> +};
>> +
>>    static const struct amdxdna_dev_priv npu3_dev_priv = {
>>    	.npufw_path             = "npu.sbin",
>>    	.certfw_path            = "cert.sbin",
>> @@ -85,6 +90,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>>    	.device_type		= AMDXDNA_DEV_TYPE_PF,
>>    	.dev_priv		= &npu3_dev_priv,
>>    	.fw_feature_tbl		= npu3_fw_feature_table,
>> +	.cert_feature_tbl	= npu3_cert_feature_table,
>>    	.ops			= &aie4_pf_ops,
>>    };
>>    
>> @@ -96,5 +102,6 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
>>    	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
>>    	.dev_priv		= &npu3_dev_vf_priv,
>>    	.fw_feature_tbl		= npu3_fw_feature_table,
>> +	.cert_feature_tbl	= npu3_cert_feature_table,
>>    	.ops			= &aie4_vf_ops,
>>    };
