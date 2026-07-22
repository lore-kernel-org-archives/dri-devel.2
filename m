Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D0C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CF810E40A;
	Wed, 22 Jul 2026 12:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZDBzRwl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1A410E40A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9EdFKR2SAmZDeHLtRCWjsvkWJJKJJQxQKOY0QQCSPsl5yYz3b1nkIJCgT3Yp6GOyYpjYfZREaTyPjjOEVgEmou4O5l5McMzJAZQPIN+o5h1mLhv8bEJa8LWiRHdtq5WhcxVGJRMvYc3Y88/KvlVr5CwEu7JHjuhexbTkjEU9rieEh88+upr25mHatNgJFSewAurZd2E4vSzsjUhmop+mk/oN/egOR8F0SCFOVlE0AWJ1870d3hhKLMpB6JARbkhLSr0JnGRijKM/usj0F31HE1kJHw04zCh3W8E4SjNH9iV62fiU79pCbwWp87tq18qpIY2jkeJY3LJfZIY2YNnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zbe0Ix9gzhi3ruCLMHbzDLtAws/X+8aReFHaRWDh8Q=;
 b=UB8FeJZs3oyAyXQzmeraFkVyyKf2as6m7DNJZOEcLXIeL5ak5oI1f5oBbL6U8HzDp2EBFtyHOIRD6Yrr7a3W4quyW1hx7FlrlagauWtgbzRCzbFoyPnaisH8QQYLfC85LsRVk5WFdZD+oUTXaXmK7QtBuZPMd9AKRgFO4+vd+CY4nPlOkRJsATpANcKqIpLj7KgqeGz3wxvrQXo9UbEYV8cw0PIJHNfEpLgTcSaEoHT1O8p1i/acKIHIBBIPghf375+CBKs9g+kPg3CUX+aU9ZFoGQ9T36iMltwhDoablZ7xPwFkpCS3MRhmqgo+DLAU7uPqcYUMmpweh5TjTe4CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zbe0Ix9gzhi3ruCLMHbzDLtAws/X+8aReFHaRWDh8Q=;
 b=cZDBzRwlsReO6jpD5IBC6JWES0dRRyl3XBihvJ/uR8irlQJ2zQEawC+WlQNFVe/DusnNXmaZ70Z6vodWDpUuht+02fnSYaiwl8Xx2TwHyoMxkF6GpGIJTmMcqMBMkLvq/j4WPVSasyUH82ewJbURXirCk45u4+tgbcRdG1Ofe9UcrIZTwhtxn83+W3O5LD9scvpuO3CfBcuodg1WDm94Xq0WS1uEF49qK+q2dAYQkBTOhiN/txh+Tie2eArBKHBkGeghs68QxAcJSbd2Ij1c3RxPKXIXMa2gPefKY+bBtSJbVVVvkRUgoxDgF7CPW2WZCGVUILyA8xY+fY2tWwd8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:05:21 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:05:21 +0000
Message-ID: <126e8bdb-9c39-4fbd-ae8a-26a61dd4f3d6@nvidia.com>
Date: Wed, 22 Jul 2026 13:05:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm: ensure blend mode supported if pixel format
 with alpha exposed
To: Nathan Chancellor <nathan@kernel.org>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
 <20260526181700.25310-3-leandro.ribeiro@collabora.com>
 <20260721234802.GA439272@ax162>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260721234802.GA439272@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3bf703-62a8-4dbd-9502-08dee7e980dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|7416014|376014|366016|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YkrW58XBufZIy8H4TSDOexdPxQ3RzenjEeMRlRM4/nUg0zi8QJBNu/+01lwn16Ly30v5De/3aoM+OIfTXaRLsYuDCjT0Ra1PU1Hv/LH77GV2ZtpjzlvKBeX/3/DNKVadIaPPUb2MWnqDscJUhLcdug1DjvMwDCOsX8hIvabjsLGr6bnBbWDnO1MYndbBGK4lj4kIj/eQm+/RqnoCiqRIahIWp6ApsawvKZz66hJCb1/L069rqsZggvu9nGFVCkx0qhc31BLjZbqifWF438Cmzdv26Nn4VeIEbbhXXERRMWINQQV2RxkuTrBcXRYmXN0ltu8RFl/JLTO+j7xQmBKtnhKHuUkCLErDT2aIulSZmBUih2hEDCrBJLOsITG3YIQiCg1I6JrbsKrbuVnQwZpGkOYHfM5aSvnXaQcTheAkShfTTk+anSd8Tbn8y9kn5m0mnn0/2tLRO/N0sv90oKLrs5H8b1JG5XuCH7lk16LDf97U51JAtgzWlZCiJQBjpM8TY7vOSDTNZ4RTEHfNC9/73mFrvXY2gYHGHpEvIod4e6TxzKSi4CtquHicTWs9CkPRu3vVtwW73f7PMFItn5NiFBAyjz+vnVsG8BLrmluHuwzaOy5Yv4cotsh/jcKWYHPEA5SJ6Mdmdad3fx+xOnYebAZvYeuoy6ApPHX3iCvt1S4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6051.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(7416014)(376014)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RMaWpHNU4wa3VFU00yZ3VMZXZwbzJCbXBlbVd5OVFzZXVYTUxlQkxsS1No?=
 =?utf-8?B?Sll5MlQvRE1rUGt5T1I3MnNpaFlBNGs3U3h1WG9ZbWxXc0VTUktXamRsQ2ow?=
 =?utf-8?B?TFVXd1MxK3ZFTDM5NkZCWHFTWlE2US8yQ1pYY1QyVHdxeXJDNGxnY2s4SU5o?=
 =?utf-8?B?dno5T1pYTGhMSnhlQkN4dTlkMEl6T1hsZzY0NjFUZjhDQmlhSTVudTBib0ly?=
 =?utf-8?B?RmxNWnpvaFNKOVRDN2R0VGorMkNTSDhwU29LVVZNRlRsOFN6a2dPdjRyOTk5?=
 =?utf-8?B?SWVma28rYXM2THBOekdrNjNOYklSZXlCbEVqMnJJTVpZWTBpbG5WdTA4WGdZ?=
 =?utf-8?B?c0RZUzZkdEw2bWx1NVR3U1RUV1VqT0pLMi9vc1dnNmFKNjk3L2psUVI5K3dT?=
 =?utf-8?B?OFloQUE1OXE2YXdycmJBWlUxZkhXcVBkQloxQ3Qya2F0NjR5YVNOSUY3dlRO?=
 =?utf-8?B?ek9oYWx3Tml5TUM4V2xrZkJLK2VaVi9tYi9aVmdpSTAzSU5kaTR2S01EbG9F?=
 =?utf-8?B?b0VyWml5VlFIM3ZVZ3FuV01iVDVwbFpEZ1FzUGhXTjN3dFU0aThwZ0NXbmIx?=
 =?utf-8?B?SmdOU0RJNVRiejRqaEJ6QkliVHA1bTF1OGlHa0EvZnAyTjF5djU3bktqamIr?=
 =?utf-8?B?elYxOWRENlQzZERsTlcwWmliaGVNcGtZei9ONFdQa0I3ZjBGT003S21vMnhK?=
 =?utf-8?B?TTRYNW1CWmhnUTYxS1B6YzJrSlJ0Y0p0ZDhUOUVVQXJRQ2tRVEVEWU55cVZp?=
 =?utf-8?B?d2lMR1BLTU1NQXFScUNXWkJ2bXB2MUYySDNEOUpCaEVRTnBCa25FdUtNVmoy?=
 =?utf-8?B?UzVFZEMrd0pkbDRwTDlRTXVPbjdSOTNDelNMMG9JRDNhNmtvYXlVcTdQY2R0?=
 =?utf-8?B?VkFtenB5L2dMVFc4TWFCT28yMUxJV1FVZjZkRmFxMkdpOXgzaC8yT3NtWWtE?=
 =?utf-8?B?QVFObEZXT2VRUkVsY0sxV2pCekdzU0Y1eFRRNVlQb3czNUl3Ukl0V3lKUlhJ?=
 =?utf-8?B?QjhEUDlPanNVeFlUN2VrMVArUGYyeGZzaFJEVmluM1BpR1hHV003WExzU1dD?=
 =?utf-8?B?U1dOenY0dS9ZSlNCTzgwbWY4N283OU4xdzF0Z1Mrc0hyV3I0bUlQMjNtQW14?=
 =?utf-8?B?ZUpFRHpkNzlDWVpCVHBNaWRtZytiU1BNZGJuaU9NL255YnJhV01FV2RqSzlm?=
 =?utf-8?B?ZURtSUNaNGRVeUpIL3B2S2o1ZDJuUUFQTzlhM3hDdU1Zc2RJaGQ3SHM5Y3BZ?=
 =?utf-8?B?Y1duNmpXbkF0cGszUjE0RTRHeXlGN3BlSmI2Mit1NW5SZVYxN041ajdGS0w2?=
 =?utf-8?B?WVlMclUxNTlUMWNpRzNZdEF0Z1NrOURFYzFZd1FESTZpTStQMDgxZHNyNENF?=
 =?utf-8?B?eXBnTmFTVnJpdVB5Q1JMbmpILy9zSXNaZmF4Q1VyK2hZWUFlUXBaWXNqREV5?=
 =?utf-8?B?dXpHbUk3aXZGc2IxNUlYdkgwb0ZocEdlNDYvRHEwQWhqb1hQT3JLV0h0RTBy?=
 =?utf-8?B?eGNWdU91Q1hXUXU4UGNvNElQTU5EVlAyU2JVRjJXZU1OTWVQTldjbFZmd2lU?=
 =?utf-8?B?bmlhRERueTJqMjI2bGZOQkh0dzZxd3FzZmZrSGswS011ekxiSW4vVmJ1Nmlm?=
 =?utf-8?B?OHhNRGVwQWhNZStidy9BNTlJTlhWMnVkZ09uc2dOZ3J3RUt3c2t1cVBVRkVG?=
 =?utf-8?B?L0Rka09kVXd6QlczcEJqNzRxMWsvY0tzVm0rV28rQVBsREgzMkRubGE2Nnp2?=
 =?utf-8?B?SlRVNkgwMWNENE1yeWM5ajRHSDNHNjJwdGYvSDE5cW4vMG1oZDI2cVBRK0hm?=
 =?utf-8?B?VjFHWXhycTZ6UTNPTWZmbWtoU0J2bFVwMStaRkJhMjBjZDRORHhzb2V4ek54?=
 =?utf-8?B?cmszWkhsQnlpVTRWY0VTS0NwTEVObkVMaUJyWVdRQTBCTzJOcU5EWFo3Zm95?=
 =?utf-8?B?VUFVNkJXd2ppVDdPem1Delc4NFVXRG5SUjVERjYxWG9ISVcxMFFYc0RJaXg2?=
 =?utf-8?B?V1NKNnVkZlEybVdrU3VXZExuT3ZYV2hDTzBzUlg2WUZXZUUxMlFlWi9WTDZ3?=
 =?utf-8?B?MDh2QnZXS0swVmFSNEE2andrZ3lGU00rbnQ1OWdRQWFrOEpGeEIrUzEyeHNH?=
 =?utf-8?B?TkJDWnd5REFMbWdyZWVpcXpLQUd1eUtwOXNlb0R1Z2J4TDNtemZOUkZrYThy?=
 =?utf-8?B?c0VVVmd0RDBQME52ejhjSk1wTk5vOGdhbUF6Ukx5QnIxSnBaWW1MS0YwZjJK?=
 =?utf-8?B?UTdIK2ZuRzJyRkM0dXhqQ0UrWkR2R3hsdmlScU1BQ2V4L0RWRmp3Y2FNSnhY?=
 =?utf-8?B?QmNFT2twUUpzV0orejBoM2dlMHQrSU4zckFVNG85aURzREJEVmNTMXNlL1Nu?=
 =?utf-8?Q?GdEutmpvpzO/RP0yl3xjnWqv/q+qXYUxO6FNFdV8oK+Ne?=
X-MS-Exchange-AntiSpam-MessageData-1: Pj7g6oG3uT6zIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3bf703-62a8-4dbd-9502-08dee7e980dc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:05:21.1038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95fDMSOuxp4vGKVGEnMEoKzMEqrPFyEzq11wlfyJcnJTdEEcorBGwuydaHeOoXVSSVUKaD/urtdOjk0Pcc1rRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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


On 22/07/2026 00:48, Nathan Chancellor wrote:
> Hi Leandro,
> 
> + ast folks
> 
> On Tue, May 26, 2026 at 03:17:00PM -0300, Leandro Ribeiro wrote:
>> Before "drm/drm_blend: allow blend mode property without PREMULTI",
>> userspace would have to assume that only PREMULTI was supported by
>> drivers that didn't expose the blend mode property. But now userspace
>> shouldn't rely on that, as they can't count with drivers always
>> supporting PREMULTI.
>>
>> Warn if a driver exposes pixel formats with alpha but doesn't expose the
>> blend mode property. This way userspace doesn't have to guess. Drivers
>> triggering this warning must be fixed.
>>
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> ---
>>   drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 66f7dc37b597..8cca1dea3b3d 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -674,6 +674,25 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
>>   	     encoder->possible_crtcs, crtc_mask);
>>   }
>>   
>> +static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
>> +{
>> +	const struct drm_format_info *fmt;
>> +	u32 i;
>> +
>> +	/* blend mode property supported, no need to check anything */
>> +	if (plane->blend_mode_property)
>> +		return;
>> +
>> +	for (i = 0; i < plane->format_count; i++) {
>> +		fmt = drm_format_info(plane->format_types[i]);
>> +		if (fmt->has_alpha) {
>> +			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but "
>> +			     "blend mode not setup", plane->base.id, plane->name);
> 
> I am seeing this warning trigger on a few of my machines in -next. A
> couple of those use amdgpu, which I see has already been reported in a
> separate thread. Another one uses ast, which I do not see reported
> (apologies if I missed it).
> 
>    [  +0.000137] ------------[ cut here ]------------
>    [  +0.000004] [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
>    [  +0.000019] WARNING: drivers/gpu/drm/drm_mode_config.c:873 at drm_mode_config_validate+0xa24/0xad0, CPU#0: kworker/0:2/507
>    [  +0.000010] Modules linked in: ghash_ce gf128mul nvme ast(+) nvme_core sbsa_gwdt i2c_algo_bit nvme_keyring nvme_auth xgene_hwmon gpio_dwapb fuse scsi_dh_alua scsi_dh_rdac i2c_dev scsi_dh_emc
>    [  +0.000014] CPU: 0 UID: 0 PID: 507 Comm: kworker/0:2 Not tainted 7.2.0-rc4-next-20260721-00002-g17fa9b81f4c4 #1 PREEMPT(lazy)
>    [  +0.000003] Hardware name: To be filled by O.E.M Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.10.100.02 (SYS: 2.10.20
>    [  +0.000002] Workqueue: sync_wq local_pci_probe_callback
>    [  +0.000004] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    [  +0.000003] pc : drm_mode_config_validate+0xa24/0xad0
>    [  +0.000002] lr : drm_mode_config_validate+0xa24/0xad0
>    [  +0.000002] sp : ffff800082df3c30
>    [  +0.000001] x29: ffff800082df3c60 x28: ffffde7ac3633fc2 x27: 0000000000000001
>    [  +0.000004] x26: 0000000000000001 x25: 0000000000000002 x24: 0000000000000000
>    [  +0.000003] x23: ffff07ffb54b0290 x22: ffff07ffb54b0be0 x21: ffffde7ac36ebb13
>    [  +0.000003] x20: 0000000000000001 x19: ffff07ffb54b0000 x18: ffff800082dd5038
>    [  +0.000003] x17: 00000000d949c370 x16: 00000000d949c370 x15: ffffde7ac358f156
>    [  +0.000002] x14: 0000000000000386 x13: ffff081eeebf2850 x12: 0000000000000000
>    [  +0.000003] x11: 0000000000000000 x10: ffffde7ac44b5850 x9 : 738b2a5f3c615c00
>    [  +0.000003] x8 : 738b2a5f3c615c00 x7 : 0000000000000000 x6 : 206c65786970205d
>    [  +0.000003] x5 : ffff081f6fcc917b x4 : ffffde7ac36ebb59 x3 : ffffffffffff0a00
>    [  +0.000002] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 000000000000004b
>    [  +0.000003] Call trace:
>    [  +0.000001]  drm_mode_config_validate+0xa24/0xad0 (P)
>    [  +0.000003]  drm_dev_register+0x44/0x3d8
>    [  +0.000004]  ast_pci_probe+0x330/0x354 [ast]
>    [  +0.000016]  local_pci_probe_callback+0x68/0xc0
>    [  +0.000002]  process_scheduled_works+0x23c/0x668
>    [  +0.000003]  worker_thread+0x218/0x324
>    [  +0.000003]  kthread+0x130/0x180
>    [  +0.000002]  ret_from_fork+0x10/0x20
>    [  +0.000004] ---[ end trace 0000000000000000 ]---

I am also seeing the same warning on -next for Tegra194 based devices.

> If there is any other information I can provide or patches I can test, I
> am more than happy to do so.

Same. Happy to provide any more information or test any other changes.

Jon

-- 
nvpublic

