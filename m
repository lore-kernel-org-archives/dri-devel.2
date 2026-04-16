Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693B0F8D762
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B0510E210;
	Thu, 16 Apr 2026 18:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IPCo9Dlc";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E6910E210
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 18:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNycrkIw6h7HA/IkHEFuwU9MjVmNKgeRrCH4wpxWg2lqUse2X0IXelSv6Q3Dq89t0DXjXrvZ0A2l/f7lA3wXmzIObRGnj+JTJZmGEpCR0KAQAz0eel1PhDu3isADvlG6eR2qxLaLLUdexFfjWwiAMJZSYIkB8tUsrPOmHoSHCO0c7a/Ul8UY0M8FGESSQAa3LXKNca5zWWOWbb/Pkx4c6YoV20Wi0SdLyDDSh5csOpAsRcVzae4yKMUuKW3BVKll3EPSXJOOT3b9wosMOC+Wq8lniC1j0++IILPtcbijwhFaewLCDxy2So0lAXv6LUvc1iGb3WPkcVk8FQAoAk5b1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpXGGGEZn7WXRFWFuMopw7NVOga49anPQW8A+0+1/q0=;
 b=LbDlByds5NEKvRZA2e7WlgqdFx+1svReW1OQ8Ne+bu+hOXecB94YS6eyVgi/IRvzs+aEiWXuHvEbIMyTtZ2GSLwuDaPrgHBGPVVn6W7CF7S/XypOO2udIVEDl8Jqc4LYjjXniBa2v9jdJBOpmkJw9P56p0n/+WLrhk8IQ09HOwNJIAL/9p+L/oGcTlztvjEyR/uoX192QQvbL9huvbujr8RLsR1XGwrdRRKFoM5nVdA0rUhZBD+vkRRAlRYzQzIC4EGg+dl0b1irrH0YJpGYRH4wP3VaeKwelApF9Nk9jS1qAHphRaIPQbOQt1ii1D2jbqD/vvs4ZlmaBpeFbuMd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpXGGGEZn7WXRFWFuMopw7NVOga49anPQW8A+0+1/q0=;
 b=IPCo9DlcNpujuuFnNC67sReAiUALyMlg7M4InldsP8DJ1gYW/7H79kAZM2+Rvz6hfLYADiFQtDtcTe9k8rARoCQl2FsK9AS2PIcL/gqsBpPRCAJfP9aaa4Wbh21XAs1HFgRw+uq4DxPH6jvi/goeZRUe7CBAJskSUfwGI4wEkKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 18:24:12 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 18:24:12 +0000
Message-ID: <a2f6ecb4-c38a-4eba-b582-3912e1bf5362@amd.com>
Date: Thu, 16 Apr 2026 13:24:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Get device revision to derive VBNV
 string
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260416174825.1032109-1-lizhi.hou@amd.com>
 <71b1a245-1e19-46b2-862c-11db6f920c00@amd.com>
 <dd0219f8-31ea-3904-a0b8-f88c1e2d729e@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dd0219f8-31ea-3904-a0b8-f88c1e2d729e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: f82caa7f-e958-4c54-1861-08de9be55b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 7gKqk24+ISxH8EFR7e21uY8SzP+ajBsCdYfzzzjlarGJ+n45H5VvSR6gEaudDb1ofijiiYb/JdmCKiL+mV5r73txKvqAZWXAp2LzzUihIOA4uAdhDNlE/mEotGz0jeuLdNF19r+SJ1ub2pkwwuVtThDYq1Hvzyf5ruZ9uXB3HTfy0fFgkfftI3KCLY3P9RHZW0rT+kwOkTwdzKR4G79qaEBe4OM1NBx6F1x5bw84F7ZNb0UEIpfFtvvZkvR1gkvaa7E7Jlw4S80P4YQY0/W8oqDa8/HyOUv/88GlMrxGO2WWltf3FxfNUpJXDnfMEX0c1/+VLlYcZDCoOpAUTc7C7oOMOZAgUqNwGe9PiYmwMuGAFlqNJ3JAAKVWvr/siq+VFU4SKgUx8hKHgCbJiV6opUuTMmBl/2lUQbguyH3/chDhrR9Hc5/7REhHKvh8qmTwLkVwOojHIotwYtM1vAriEzZ1dl1juYIMT0JhJC7HG4PgFOaS4ImDURngCPhlzAGio3krqS0+EkKGtAOqLQWGFVKWJBrUwEUe1RjVY3+ON8Xhe81xGbzohpGaRw6INC4LvWYsqzrow4GSHEXHnkHD+P4sw29ksDNzQQ7PHlg5Wx1KAlNy3/UDaOWUW/yhJ5lilDEE9dz6GFsVwL61IZVM9wN3LVc04RC6oNSSiEmIeNKIVyo60LaHqBcNmte44DVq/O36ipP3sRlFn37md06JPDPIQrlMHdGDFMxlytV/UdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2EyZ0tIVnY4ZlphRjNCNVpNV3BoSk43eFZhem5KRm0yR0NGQ0dVM3BIcFFW?=
 =?utf-8?B?cHdSSUFnQXdHNnRWNTFuTHJJbUkwb0FjMEVnUFVxcFBpNklJdUhtMUZ5bWNt?=
 =?utf-8?B?amxsTVVpaDhMend6eEhWb3pRa0s2Q3ZpOUh1eHlHK1hrNzNmMzZTajBEY1RG?=
 =?utf-8?B?b0hKVkVQdjQyazNYdnFFbVFSVTJJaHVBS2lTRlFOV2hFbXJKZlp3N0RJQ0ZE?=
 =?utf-8?B?VVd2NGVNMFBuTG1NaDFiUlhEMHlkNUdyYXBBdUd0MVRoUGVtN2E4clZTNzY0?=
 =?utf-8?B?Ty9WSmFzNE5hK3JiVjJJQmpkUlk2V0ErVzZyTnBFVjl5cnpGMnZaQlhOSEhM?=
 =?utf-8?B?ckFSSFRhUTRiek12bklESVdSU1ViZEZSTDVLOUhjays5UVluL00rb3BGZUFv?=
 =?utf-8?B?TnljNjF3dlhNZ3A5QjhpV2tCWGV5dHYrK1lvQy84MVBGajROeTBVa3FndnNr?=
 =?utf-8?B?anJHOTg1czVKRWtWNTVSWitoTUt0R3VGTUdSUEhXVnFFTVJGRVZtVGVVZndq?=
 =?utf-8?B?RzNMM3M1V28zNjgvOU5vaXRhU1kxLzlnT25UZk1wMWg2c1dPSW0xLzg4T2Vs?=
 =?utf-8?B?TVRaaU95QlMrOFNpeWhEY01veE1HWUhlMGJmMzgxRUlrMlhmazJFN0tuc3c0?=
 =?utf-8?B?RXhYWHp4YytMcU5CQWZUelFkU3ZGQytWZnIwcFdCU2U1RHo0N0JzRzRHVGVU?=
 =?utf-8?B?Smk1MWpKWEFMV2FDdzYwSk5DZEFabDN5eTJTVVVUZGdPYnVxVjF4bUJWNmJF?=
 =?utf-8?B?L3h3dklKQ1NBTmpFZk5COE83aSs2b1JUMjUydlFxMlMyVnpsRytNYllwak9W?=
 =?utf-8?B?Wk1XSnBTY1VWdVI2M2lLek9YWWozTFc3WDZaWit1SC8vay81QTR0aThlWkFG?=
 =?utf-8?B?Y2M1VnlYbjN0RlBDd0VCdGc3ZkhEenZ2SXl6aTRYWklVd0lRVTVMU1ZkRGYw?=
 =?utf-8?B?T2ZEWG9oWnpiZHRGMlpKL2w2OURhdFZOTlNwSWp0SllwU0ZCb0hpVEEvOU5G?=
 =?utf-8?B?aytaWEhER0ZUSGdabWZ4SFZ0UGpuRUJZNHpqc0dmbS9zZEtOUDczMVlNcnNl?=
 =?utf-8?B?d3dkbmV5Vkh4RE9ES3NJaDZEYzllQkJHNHp3U3FvNTgwUk1HRUYvVFl4LzJu?=
 =?utf-8?B?cEJUdzk4bEF3bzlleFFZVSs4MFBnVC9uMWozSmhSQUlzYWtETGtvdUNnQnFK?=
 =?utf-8?B?KzJNclIwYU4wVzVRVWNmYTc2YXpXYk5sRGJUb0RqekJQOXFXMEJkY3lFd25Z?=
 =?utf-8?B?WGk1b1pUbWNDWHVXRVdFRDUralJDeld2SEJ1cjIrdnRvK3FvRTlObGFxdnB3?=
 =?utf-8?B?bkdjT1B1SHNaOWx4WDNTRlFZQzFTaFdrNGJrWUlzdjBYSEUrOTMxSzJHR2My?=
 =?utf-8?B?U3hTd3BNdHhqekNzNEMvK3lnK0xpdmNsbDlGRjdXTUhHRXIrNThZaWFjdmxv?=
 =?utf-8?B?bE1VRG0rQzFuSmhwL3FLR2lLS3QxaFhvaytpRTRWYmkvVkVnRldjVys1aHRj?=
 =?utf-8?B?V3J0UTVlbmdUSWhLNUtFWW1ISHNIQmwyc0wvd3pnTjdMM2dJbkEzRjZpMWgy?=
 =?utf-8?B?TnFWOVkzL25TRUtsTEduQkJWVFpuN29xbXQ2Q2VGVXhWOXFuM1BmbzlZZXVt?=
 =?utf-8?B?b2sxWmdFWUhqUW8zNU9BRXorWjhXK1R6d3hBTWRYYUFlUTNvZzVqNnY0SmE0?=
 =?utf-8?B?TVhjMnVQbEI2emdGQzlINUxsUlQrY1dUVkp2ZkVVdGRISXNJSGpWVFNRbTF3?=
 =?utf-8?B?M05leWVxMGYyUUFyOUJhUk9NVlZEdXBhdS82UENZMEY0dmRJeVE2c3ZlbHF2?=
 =?utf-8?B?dG5jQS9jVXdDcXBWRnBTOUdsbGl4NUhwNTVNVC9ZZ0VURERXbUxRVFhBSE04?=
 =?utf-8?B?UitlUENEYllMUGdxdEpnTTNHVmZYTzJTM0crQTEvRXI3T3BQWjdSQTRtOW1I?=
 =?utf-8?B?MUZkZFp1S3lPaENJKytOSVA3bEU0cjAwb01XWWZ6c2NrNVo2T3dSRnVXdEFM?=
 =?utf-8?B?WHNJUjl1ZG5xT2xFOG5QZFlGUVpUMzB0TUpnUStxWklYenRyUXVoM1RQR3lZ?=
 =?utf-8?B?Q2ZkZk8vSGNOZVFlZ2Erd2FXdGlZMXFIMnhtNjJaVHdDT2sxVEExdW5XdVBm?=
 =?utf-8?B?aHBUbTlObDNJdkJZVUhhQVViSzNQdi9ieWJsd1Irem1yb3NKcHJ5bVdHbU4w?=
 =?utf-8?B?LzdoVUltNWdQTnRhc1A0QTljcTZhcGxoV2I1Y0c4VmloMlZ1c2NYQWtFT3Rz?=
 =?utf-8?B?MXFwSWVON2VHeW5DQ1g5RUNUZHpxZ3BZZFRhYnNxQWtxcURBcVVvd1NpcjVR?=
 =?utf-8?B?U3dsWStjRER0VUg1eGNhbGlJU1VkN1RZUGZ4by9sWG85NG5hMk9YQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82caa7f-e958-4c54-1861-08de9be55b88
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 18:24:11.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuFJhor63KgA9GFW9WePkvcq4atwIQHi/HZ49NpbyN1C3gYXHBnlKNGCNV6KBiQ8bVsKXa3vtJHpv4rRL11eGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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



On 4/16/26 13:18, Lizhi Hou wrote:
> 
> On 4/16/26 11:05, Mario Limonciello wrote:
>>
>>
>> On 4/16/26 12:48, Lizhi Hou wrote:
>>> From: Max Zhen <max.zhen@amd.com>
>>>
>>> Add support for querying the device revision from firmware.
>>>
>>> Use the returned revision to look up the VBNV string during device
>>> initialization, and fall back to the default VBNV when the revision
>>> query is not supported or no mapping is found.
>>>
>>> This allows the driver to report the accurate VBNV for devices that
>>> share the same vendor/device ID but differ by hardware revision.
>>>
>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie.c             | 32 +++++++++++++++++++++++++
>>>   drivers/accel/amdxdna/aie.h             |  7 ++++++
>>>   drivers/accel/amdxdna/aie2_message.c    | 25 +++++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_msg_priv.h   | 23 ++++++++++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.c        | 17 +++++++++++++
>>>   drivers/accel/amdxdna/aie2_pci.h        |  3 +++
>>>   drivers/accel/amdxdna/aie4_pci.c        |  1 +
>>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  6 ++++-
>>>   drivers/accel/amdxdna/amdxdna_sysfs.c   |  5 +++-
>>>   drivers/accel/amdxdna/npu1_regs.c       |  2 +-
>>>   drivers/accel/amdxdna/npu3_regs.c       |  2 +-
>>>   drivers/accel/amdxdna/npu4_regs.c       | 16 ++++++++++++-
>>>   drivers/accel/amdxdna/npu5_regs.c       |  3 ++-
>>>   drivers/accel/amdxdna/npu6_regs.c       |  3 ++-
>>>   14 files changed, 138 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
>>> index 4b3d4493128e..f4e07d90b8a0 100644
>>> --- a/drivers/accel/amdxdna/aie.c
>>> +++ b/drivers/accel/amdxdna/aie.c
>>> @@ -87,3 +87,35 @@ int aie_check_protocol(struct aie_device *aie, u32 
>>> fw_major, u32 fw_minor)
>>>         return found ? 0 : -EOPNOTSUPP;
>>>   }
>>> +
>>> +static const char *amdxdna_lookup_vbnv(const struct amdxdna_rev_vbnv 
>>> *tbl, u32 rev)
>>> +{
>>> +    int i;
>>> +
>>> +    if (!tbl)
>>> +        return NULL;
>>> +
>>> +    for (i = 0; tbl[i].vbnv; i++) {
>>> +        if (tbl[i].revision == rev)
>>> +            return tbl[i].vbnv;
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>> +void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>>> +{
>>> +    const struct amdxdna_dev_info *info = xdna->dev_info;
>>> +    u32 rev;
>>> +
>>> +    xdna->vbnv = info->default_vbnv;
>>> +
>>> +    if (!info->ops->get_dev_revision)
>>> +        return;
>>> +
>>> +    if (info->ops->get_dev_revision(xdna, &rev))
>>> +        return;
>>
>> When either of these two if blocks fail don't you still want to have 
>> the default value?
>>
>> I wonder if what you really want is something like this:
>>
>>     if (!info->ops->get_dev_revision)
>>         goto fallback;
>>
>>     if (info->ops->get_dev_revision(xdna, &rev))
>>         goto fallback;
>>
>>     xdna->vbnv = amdxdna_lookup_vbnv(info->rev_vbnv_tbl, rev);
>>
>> fallback:
>>     if (!xdna->vbnv)
>>         xdna->vbnv = info->default_vbnv;
> 
> vbnv string is set to default before the first check.
> 
> Lizhi
Oh thanks.  Then what you have works fine.

It's a little awkward though - why bother setting xdna->vbnv to NULL and 
then resetting it?

Maybe rename amdxdna_lookup_vbnv to amdxdna_update_vbnv and pass the 
pointer in?  Then you can set it only when you need to.

> 
>>
>>> +
>>> +    xdna->vbnv = amdxdna_lookup_vbnv(info->rev_vbnv_tbl, rev);
>>> +    if (!xdna->vbnv)
>>> +        xdna->vbnv = info->default_vbnv;
>>> +}
>>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>>> index ba4c9ee21823..7a68b114f235 100644
>>> --- a/drivers/accel/amdxdna/aie.h
>>> +++ b/drivers/accel/amdxdna/aie.h
>>> @@ -82,11 +82,18 @@ struct psp_config {
>>>       u32            notify_val;
>>>   };
>>>   +/* Device revision to VBNV string mapping table entry */
>>> +struct amdxdna_rev_vbnv {
>>> +    u32        revision;
>>> +    const char    *vbnv;
>>> +};
>>> +
>>>   /* aie.c */
>>>   void aie_dump_mgmt_chann_debug(struct aie_device *aie);
>>>   void aie_destroy_chann(struct aie_device *aie, struct 
>>> mailbox_channel **chann);
>>>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct 
>>> xdna_mailbox_msg *msg);
>>>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 
>>> fw_minor);
>>> +void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>>>     /* aie_psp.c */
>>>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct 
>>> psp_config *conf);
>>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/ 
>>> amdxdna/aie2_message.c
>>> index 976ad6281078..6e98af7b74db 100644
>>> --- a/drivers/accel/amdxdna/aie2_message.c
>>> +++ b/drivers/accel/amdxdna/aie2_message.c
>>> @@ -1244,3 +1244,28 @@ int aie2_update_prop_time_quota(struct 
>>> amdxdna_dev_hdl *ndev, u32 us)
>>>       }
>>>       return ret;
>>>   }
>>> +
>>> +int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum 
>>> aie2_dev_revision *rev)
>>> +{
>>> +    DECLARE_AIE_MSG(get_dev_revision, MSG_OP_GET_DEV_REVISION);
>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>> +    int ret;
>>> +
>>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_GET_DEV_REVISION))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    *rev = resp.rev;
>>> +
>>> +    if (*rev < AIE2_DEV_REVISION_STXA || *rev >= 
>>> AIE2_DEV_REVISION_UNKN) {
>>> +        XDNA_ERR(xdna, "Unknown device revision: %d (raw fuse: 0x%x)",
>>> +             *rev, resp.raw_fuse_data);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    XDNA_DBG(xdna, "Device revision: %d (raw fuse: 0x%x)", *rev, 
>>> resp.raw_fuse_data);
>>> +    return 0;
>>> +}
>>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/ 
>>> amdxdna/aie2_msg_priv.h
>>> index b10552c627ee..a41c9797e265 100644
>>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>>> @@ -33,6 +33,7 @@ enum aie2_msg_opcode {
>>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>>       MSG_OP_UPDATE_PROPERTY             = 0x113,
>>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>>> +    MSG_OP_GET_DEV_REVISION            = 0x117,
>>>       MSG_OP_MAX_DRV_OPCODE,
>>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>>       MSG_OP_MAX_OPCODE
>>> @@ -519,4 +520,26 @@ struct update_property_resp {
>>>       enum aie2_msg_status status;
>>>   } __packed;
>>>   +enum aie2_dev_revision {
>>> +    AIE2_DEV_REVISION_STXA = 1,
>>> +    AIE2_DEV_REVISION_STXB,
>>> +    AIE2_DEV_REVISION_KRK1,
>>> +    AIE2_DEV_REVISION_KRK2,
>>> +    AIE2_DEV_REVISION_HALO,
>>> +    AIE2_DEV_REVISION_GPT1,
>>> +    AIE2_DEV_REVISION_GPT2,
>>> +    AIE2_DEV_REVISION_GPT3,
>>> +    AIE2_DEV_REVISION_UNKN,
>>> +};
>>> +
>>> +struct get_dev_revision_req {
>>> +    __u32            place_holder;
>>> +} __packed;
>>> +
>>> +struct get_dev_revision_resp {
>>> +    enum aie2_msg_status    status;
>>> +    enum aie2_dev_revision    rev;
>>> +    __u32            raw_fuse_data;
>>> +} __packed;
>>> +
>>>   #endif /* _AIE2_MSG_PRIV_H_ */
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>> amdxdna/aie2_pci.c
>>> index afbe3f8f67ce..1d1fb012294a 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>> @@ -608,6 +608,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>>         release_firmware(fw);
>>>       aie2_msg_init(ndev);
>>> +    amdxdna_vbnv_init(xdna);
>>>       amdxdna_pm_init(xdna);
>>>       return 0;
>>>   @@ -1255,6 +1256,21 @@ static int aie2_set_state(struct 
>>> amdxdna_client *client,
>>>       return ret;
>>>   }
>>>   +static int aie2_get_dev_rev(struct amdxdna_dev *xdna, u32 *rev)
>>> +{
>>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>>> +    enum aie2_dev_revision aie2_rev;
>>> +    int ret;
>>> +
>>> +    drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>>> +    ret = aie2_get_dev_revision(ndev, &aie2_rev);
>>> +
>>> +    if (!ret)
>>> +        *rev = (u32)aie2_rev;
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   const struct amdxdna_dev_ops aie2_ops = {
>>>       .init = aie2_init,
>>>       .fini = aie2_fini,
>>> @@ -1269,4 +1285,5 @@ const struct amdxdna_dev_ops aie2_ops = {
>>>       .cmd_submit = aie2_cmd_submit,
>>>       .hmm_invalidate = aie2_hmm_invalidate,
>>>       .get_array = aie2_get_array,
>>> +    .get_dev_revision = aie2_get_dev_rev,
>>>   };
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/ 
>>> amdxdna/aie2_pci.h
>>> index 69b53c7bcb86..c44616065058 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.h
>>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>>> @@ -223,6 +223,7 @@ enum aie2_fw_feature {
>>>       AIE2_TEMPORAL_ONLY,
>>>       AIE2_APP_HEALTH,
>>>       AIE2_UPDATE_PROPERTY,
>>> +    AIE2_GET_DEV_REVISION,
>>>       AIE2_FEATURE_MAX
>>>   };
>>>   @@ -258,6 +259,7 @@ extern const struct dpm_clk_freq 
>>> npu4_dpm_clk_table[];
>>>   extern const struct rt_config npu1_default_rt_cfg[];
>>>   extern const struct rt_config npu4_default_rt_cfg[];
>>>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
>>> +extern const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[];
>>>   extern const struct aie2_hw_ops npu4_hw_ops;
>>>     /* aie2_pm.c */
>>> @@ -286,6 +288,7 @@ int aie2_query_firmware_version(struct 
>>> amdxdna_dev_hdl *ndev,
>>>                   struct amdxdna_fw_ver *fw_ver);
>>>   int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 
>>> context_id,
>>>                 struct app_health_report *report);
>>> +int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum 
>>> aie2_dev_revision *rev);
>>>   int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct 
>>> amdxdna_hwctx *hwctx);
>>>   int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct 
>>> amdxdna_hwctx *hwctx);
>>>   int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>>> u64 addr, u64 size);
>>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/ 
>>> amdxdna/aie4_pci.c
>>> index f50e0bc566e4..87f80f804f91 100644
>>> --- a/drivers/accel/amdxdna/aie4_pci.c
>>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>>> @@ -471,6 +471,7 @@ static int aie4_init(struct amdxdna_dev *xdna)
>>>           return ret;
>>>       }
>>>   +    amdxdna_vbnv_init(xdna);
>>>       XDNA_DBG(xdna, "aie4 init finished");
>>>       return 0;
>>>   }
>>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/ 
>>> amdxdna/amdxdna_pci_drv.h
>>> index eabbf57f2b38..bdd0dc83f92e 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>>> @@ -65,6 +65,7 @@ struct amdxdna_dev_ops {
>>>       int (*get_aie_info)(struct amdxdna_client *client, struct 
>>> amdxdna_drm_get_info *args);
>>>       int (*set_aie_state)(struct amdxdna_client *client, struct 
>>> amdxdna_drm_set_state *args);
>>>       int (*get_array)(struct amdxdna_client *client, struct 
>>> amdxdna_drm_get_array *args);
>>> +    int (*get_dev_revision)(struct amdxdna_dev *xdna, u32 *rev);
>>>   };
>>>     struct amdxdna_fw_feature_tbl {
>>> @@ -89,7 +90,8 @@ struct amdxdna_dev_info {
>>>       u32                dev_mem_buf_shift;
>>>       u64                dev_mem_base;
>>>       size_t                dev_mem_size;
>>> -    char                *vbnv;
>>> +    const char            *default_vbnv;
>>> +    const struct amdxdna_rev_vbnv    *rev_vbnv_tbl;
>>>       const struct amdxdna_dev_priv    *dev_priv;
>>>       const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
>>>       const struct amdxdna_dev_ops    *ops;
>>> @@ -117,6 +119,8 @@ struct amdxdna_dev {
>>>       struct iommu_group        *group;
>>>       struct iommu_domain        *domain;
>>>       struct iova_domain        iovad;
>>> +    /* Accurate board name queried from firmware, or default_vbnv as 
>>> fallback */
>>> +    const char            *vbnv;
>>>   };
>>>     /*
>>> diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/ 
>>> amdxdna/amdxdna_sysfs.c
>>> index f27e4ee960a0..d9e359ee8182 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_sysfs.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
>>> @@ -17,7 +17,10 @@ static ssize_t vbnv_show(struct device *dev, 
>>> struct device_attribute *attr, char
>>>   {
>>>       struct amdxdna_dev *xdna = dev_get_drvdata(dev);
>>>   -    return sprintf(buf, "%s\n", xdna->dev_info->vbnv);
>>> +    if (!xdna->vbnv)
>>> +        return sprintf(buf, "\n");
>>> +
>>> +    return sprintf(buf, "%s\n", xdna->vbnv);
>>>   }
>>>   static DEVICE_ATTR_RO(vbnv);
>>>   diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/ 
>>> amdxdna/npu1_regs.c
>>> index f1141a65e64d..d7e50c6b06ef 100644
>>> --- a/drivers/accel/amdxdna/npu1_regs.c
>>> +++ b/drivers/accel/amdxdna/npu1_regs.c
>>> @@ -137,7 +137,7 @@ const struct amdxdna_dev_info dev_npu1_info = {
>>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>> -    .vbnv              = "RyzenAI-npu1",
>>> +    .default_vbnv      = "RyzenAI-npu1",
>>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>>       .dev_priv          = &npu1_dev_priv,
>>>       .fw_feature_tbl    = npu1_fw_feature_table,
>>> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/ 
>>> amdxdna/npu3_regs.c
>>> index 5a0bbc916094..acece0faddf2 100644
>>> --- a/drivers/accel/amdxdna/npu3_regs.c
>>> +++ b/drivers/accel/amdxdna/npu3_regs.c
>>> @@ -69,7 +69,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>>>       .sram_bar        = NPU3_MBOX_BUFFER_BAR,
>>>       .psp_bar                = NPU3_PSP_BAR_INDEX,
>>>       .smu_bar        = NPU3_SMU_BAR_INDEX,
>>> -    .vbnv            = "RyzenAI-npu3-pf",
>>> +    .default_vbnv        = "RyzenAI-npu3-pf",
>>>       .device_type        = AMDXDNA_DEV_TYPE_PF,
>>>       .dev_priv        = &npu3_dev_priv,
>>>       .fw_feature_tbl        = npu3_fw_feature_table,
>>> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/ 
>>> amdxdna/npu4_regs.c
>>> index 6ebf75ad5fb4..935999ced70f 100644
>>> --- a/drivers/accel/amdxdna/npu4_regs.c
>>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>>> @@ -98,6 +98,7 @@ const struct amdxdna_fw_feature_tbl 
>>> npu4_fw_feature_table[] = {
>>>       { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>>> = 15 },
>>>       { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 
>>> 6, .min_minor = 15 },
>>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor 
>>> = 18 },
>>> +    { .features = BIT_U64(AIE2_GET_DEV_REVISION), .major = 
>>> 6, .min_minor = 24 },
>>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>>       { 0 }
>>>   };
>>> @@ -142,6 +143,18 @@ const struct aie2_hw_ops npu4_hw_ops = {
>>>       .update_counters = npu4_update_counters,
>>>   };
>>>   +const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[] = {
>>> +    { AIE2_DEV_REVISION_STXA, "NPU Strix" },
>>> +    { AIE2_DEV_REVISION_STXB, "NPU Strix" },
>>> +    { AIE2_DEV_REVISION_KRK1, "NPU Krackan 1" },
>>> +    { AIE2_DEV_REVISION_KRK2, "NPU Krackan 2" },
>>> +    { AIE2_DEV_REVISION_HALO, "NPU Strix Halo" },
>>> +    { AIE2_DEV_REVISION_GPT1, "NPU Gorgon Point 1" },
>>> +    { AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
>>> +    { AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
>>> +    { 0 }
>>> +};
>>> +
>>>   static const struct amdxdna_dev_priv npu4_dev_priv = {
>>>       .fw_path        = "amdnpu/17f0_10/",
>>>       .rt_config    = npu4_default_rt_cfg,
>>> @@ -185,8 +198,9 @@ const struct amdxdna_dev_info dev_npu4_info = {
>>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>> -    .vbnv              = "RyzenAI-npu4",
>>> +    .default_vbnv      = "RyzenAI-npu4",
>>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>>       .dev_priv          = &npu4_dev_priv,
>>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>>       .ops               = &aie2_ops, /* NPU4 can share NPU1's 
>>> callback */
>>> diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/ 
>>> amdxdna/npu5_regs.c
>>> index 6d4596b9e61e..795bd1996845 100644
>>> --- a/drivers/accel/amdxdna/npu5_regs.c
>>> +++ b/drivers/accel/amdxdna/npu5_regs.c
>>> @@ -105,8 +105,9 @@ const struct amdxdna_dev_info dev_npu5_info = {
>>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>> -    .vbnv              = "RyzenAI-npu5",
>>> +    .default_vbnv      = "RyzenAI-npu5",
>>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>>       .dev_priv          = &npu5_dev_priv,
>>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>>       .ops               = &aie2_ops,
>>> diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/ 
>>> amdxdna/npu6_regs.c
>>> index 76181345b6d1..3125d1ce45ab 100644
>>> --- a/drivers/accel/amdxdna/npu6_regs.c
>>> +++ b/drivers/accel/amdxdna/npu6_regs.c
>>> @@ -106,8 +106,9 @@ const struct amdxdna_dev_info dev_npu6_info = {
>>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>>> -    .vbnv              = "RyzenAI-npu6",
>>> +    .default_vbnv      = "RyzenAI-npu6",
>>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>>       .dev_priv          = &npu6_dev_priv,
>>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>>       .ops               = &aie2_ops,
>>

