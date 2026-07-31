Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A262C55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8552210F2D3;
	Fri, 31 Jul 2026 15:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKhqzZX7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F178010F2D2;
 Fri, 31 Jul 2026 15:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbM0c4SD7btCKkmmwV+I3bH17PMlpm3vMFNAoCxrqZXtmHT731VM1cfft0g1XS/+9a9y74JWXsuassYtGqso4+G/i/FCKEw+5IbW/j+qk46Q4m8CBqdBLj6We1je+0hI4vehBH/f4QGmB5NMzbKMRqxch8BykojHumlq+dGdT5c+ygdTfSPgZjMSQBdZvpxcV1Ho//fyZ2VgysNbqU+Z8nmIZTQ1fY8Y3sS6BMRqDugFD5WWmxRM+qU25R97euxVmINZrZLc+VqWuPQx+wigryY3bcEwaohoAtMve5FCPu9E1Io4H7+JZUu2yJeg6mXDwb6VXZQZW2tUn1jICc6ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIpiOD5CItikmDS3smwf8SgG5w3RdUB0+mI94SSpXvk=;
 b=D/iIWgYmHOqz2ooPg2UGCWulOQgwWNuO63nRB/Z/QOc0TdUEEE3ZKqU16KQ8L4Zr+V636lqK/RE2y/WBEWn+t+e7ZSuUSX27llLBPdfM2cn7PsiFxzU6hRVtFkiwxpLXCexypnor9kxlkGS1j6mOrLIA27sHKlLKPRq+OJlxSFe5C1qHkz1WVkT8H3W/RwkWfEDk4rqFfKfoegctJgDJNJSJzNnVHDUICsKnJ63iig7fX02+wWfRYBvFDXRMPxB7tXZJVfPSjw7FFug6/qJziFt8ohVHVK02wAdgFSbRzf6O0Ufch9aAy2h06fzoSPb6bJ5rvAJFudQXMz42D4HJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIpiOD5CItikmDS3smwf8SgG5w3RdUB0+mI94SSpXvk=;
 b=dKhqzZX7oua2qwgq2xttNWSEACEEkDJ8ffqQq+3SE/QP+g6HhzVr0yZU5u3b7AID6XXIYp0SSaiXCL4QTybT1PColhuuaiobKOFMY4dfR3SO1a89Mek2ZDB5n+0KyaizBOXMIglHbHtAAcOrglON4bgooWbstm5A0gFL6uG+0Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:30:52 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:30:52 +0000
Message-ID: <380eac9c-69da-48d2-894c-d5b63ad7238e@amd.com>
Date: Fri, 31 Jul 2026 11:30:48 -0400
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v4 02/11] drm/vkms: Fix limited-range YCbCr to RGB
 conversion scaling
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-3-harry.wentland@amd.com>
 <20260730164615.2d3e8021@fluorite>
Content-Language: en-US
In-Reply-To: <20260730164615.2d3e8021@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::7) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4a6872-7bb8-4d31-5969-08deef18b47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|3023799007|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aFbKw2yNJH17bYNHuwNPUevbNMgCLm74r18YgV+CYKEr4Z6fIPg/7YXSoKHrRk5uhPVGRjTiIUGPrI0FT9ose5wYGbsoBC5zclAV/tzGlK1rAgUeGvRmJ7PHVoH09fqjpYozJgArn9P7eXrnF649ixeLBF6wBEHEpIhh9/JOZP6uw1Lx454tIbXTb+yay3L9C3bvtcLpeYmbM3fMw6OwqmbSIrpuQa6MCDJ1c+gydxV9eVcDkAeqX5tNB1Y21Vc8WFUAwmdOv7Q040ANMIsmPn8rcyU4izDECLRkh3366JXMxMNXmWl27RJVZMs3kBdV7CIloDaF08ssYBlUwzdJiDvs13EejO12dJvCIePPPrP4BECe+XUy7XmLl64GFoE7Hwz1PfLKlQJ7tXjpSIy4u/k+jdCiv2q/tq3pC+h+chV46MPzX7IpWHQ1cVaqCXP857fLQ+ExKRgLM1D1/FHwaG4cXAtTN4+8+F4S32qRtskmnH652IvncZEfj2PYNuUMuoFF3zE4OSBHkxKOdOXE9gq38SX/7SyFTb+UOKJHsHzf37XpR5hYBu8vqgwSrvzzQ/Y35DaOnu6RoOq1YgNruBW0KcobAOhjlzcecUHwgJ1KlD0+TJEBVV1kNXx6VjkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNxTUpCVVZva2h4NVltL0RxcTRCZ2RUR2hjZzRlU1pmZWNvT1A3MUlVYUdW?=
 =?utf-8?B?dG9uTFVlbmVnNGdwaGdJSjFiMndhN2N4b2Y5Zy9lU2pHN1I3cWtkWEdNcHRa?=
 =?utf-8?B?eVdRWGlzb2pyS0Ryc1ZNbTRaZVFpNGNRWmgvUTVGVTF6VzV1NkozUHNEZnRm?=
 =?utf-8?B?SGV6NUJDdlJPMkZBTGlrRlh1MkxTVEE0OWhDaGgwNjduLzRRc3Qxak93Z0Yy?=
 =?utf-8?B?V3pzbFJVeG1QY2t0b3RCUDBZdjAwUGk1YjlDUFZKVkFXT3JrZW11a0VKQy9m?=
 =?utf-8?B?RVBNdGpXdGVScVRyZEpBRUpKR29BRHY1cjBRdHVvS2llaXhNKzQ0SThTcXhu?=
 =?utf-8?B?T0pLdlQwQnQyeUJkSitydGFPU1dJMlNUdmQ3L0pwaDd2ZjJmNFk3WURaOWhv?=
 =?utf-8?B?SDluQmthbWwvZCtEMUNlaWNpcndTQlpPSldtNkk4UENZanZ0eXZWL3ZrQkRF?=
 =?utf-8?B?eG1DRUtiTUxWNmZzazZHUGtJck9jY2xmR3VDbnBuRElqWEs5TmNQQ04rdlQ4?=
 =?utf-8?B?d044RXNxd3BkNWtOMEc3TlNtRjdVVzR4UGp4d2gzV2M4Z3RCTWIvcG41dStH?=
 =?utf-8?B?eng1QlQrZUFCcDNxQmZEQ3gzS3QyWUtuWVRHb2I3OVhwWlM0ZVhIbmg1SWJm?=
 =?utf-8?B?cUtweC9INk9FWUtEU01ZMzk1bEFFQURpZHorTXpMQm8xL1R3ajQ1QXk5Z0No?=
 =?utf-8?B?UzlDa0g3K2VJcENaQ1VjSjk0UUovZVNzeVZidWN6YWpnWm9qczNlNml1emJs?=
 =?utf-8?B?R3prKzBUUzFmNElrLzBwd0w5SXFoVy93VG5Oa3RUd21sbUM0aTlJNlhTVW5G?=
 =?utf-8?B?RUtFTGtqSTFtSVl2TTQ0cTVPdkJmRHAxWldPTHZrZGc4dWhva2R1RGdwVThF?=
 =?utf-8?B?N2F6SGtneDRHVTdEWnFwMEthUVNuaFl1dDNGNWlkZ0JwakpNVVVBRklyVGly?=
 =?utf-8?B?aCtIUWxFbC9COTZQNWdFOFlXcjVkNndZc1RvWkQvTGY5eXlKSENYNndwUVFw?=
 =?utf-8?B?TjdBWG9HSFBoUEVWTzZpT1RGMnQ3UG9vUlRhK0Jsd0V6RDlWNjhDM1gvU3JV?=
 =?utf-8?B?ZlBOSEptN21BK01CTXcxenpTMWVRbXRhUXZZRUROOXBXQnd0NXlYTlhtRjBV?=
 =?utf-8?B?MzArNFVVejZmS3B4Z243RXBURWU4Z0hnQVhEOUhxaXBQd1g4aGg1Q3Q2djc4?=
 =?utf-8?B?bHNWbjlycTJoaE8xbWZ6clVlN3dmTXVYUi9BVUdWLzVPUS9ydndUR01KSjVp?=
 =?utf-8?B?dUF4eVdaVStydTFWMVAyMTUzWFhHK3FmVy9VODVFUTdiYXE1aWF5K1k1L04y?=
 =?utf-8?B?WmE2YjNTNFZzVzJla0t6VDZnQzB3Mi81SktuRW84WWFuQlpKd3RLWjlsMHk3?=
 =?utf-8?B?RFQvbTRIMEVVOEF1OTUxUGJXcGpOR0Y1b3FsaHRtME1JNmhuYnlMKy9lQ2F2?=
 =?utf-8?B?TC9KcUZFMTFxOWFVZDJXaC93NDhsZWMxNm1GV25weG0yaFBSR1IzeXJtUThT?=
 =?utf-8?B?bTRkUzBicThkOVdKQnNpdTFMZVJuclFCbThXS2tHVGlOZnRldUxPZVN1dGpm?=
 =?utf-8?B?WGJ2SWJMbDN4WmJLN0xYMFFQY1RxVFZueFQ5N3RYWkNwOWM5Z0lickF0ZW9S?=
 =?utf-8?B?MmYrcjAyWFdlTmluVi9LKzhJSk1abjhqdmhBSTBpdUhWa3BjQXJVUUhsQUJs?=
 =?utf-8?B?STlvNWRZZVUzRXc2ZlN5ejl5NWdOSFB1N0lOeWVTTWxZai8rVm8xN1BZcVhm?=
 =?utf-8?B?SUlzcGR1K3hIRGpwV0tpYXJpcUpBSWphMDRlV0xnOGJBRFp5SVhVM3F4Uzd0?=
 =?utf-8?B?dTJwMUpJcVg2UTNJaldZb2VzSHl3SjZjNDVEOTZtaG8wNlN5eHhVTXh4NmNX?=
 =?utf-8?B?M0grUWFSaUtkK0YvWldVQzhIU2F6aDZ6RG1pNXR4UUswbHllR3RGdTVFVjNi?=
 =?utf-8?B?elcwOEx5VjhQdDVRMjF2UHpyRFZjaWRSNmFZVUZmMUVBajJkZklhSC9RUXFK?=
 =?utf-8?B?NEdNa01ycFUxVlM0Ylp3OE1kQXVwNmFaL0xBQVdpNC96SW4wQ0JuOU1MM1gz?=
 =?utf-8?B?dzd0dHAxcW1ob3Vyb0xqUEc0Um9BNVgvdmxET1hBakJRUzREZFI5VDdBNXZz?=
 =?utf-8?B?T1lMQm94UWlTRzNsN3V5anFrTDlWZmhGeWRRWEhwU0k0bFRjRXVxMjhHM2xE?=
 =?utf-8?B?VDRNOFJERlMzRGFJUGM4NnlOYllFNXNBOG9UYlNaZWpoK3V3N0pJQ2ZNeVow?=
 =?utf-8?B?cEwvdlo1SjJ1Y0pDWDc1VGVzVVpDdWs5b0tlRUZrdjVrbDBGTFhJZGxtOXUz?=
 =?utf-8?B?UFdXaWRJdE1wdW1jMkRtZkpSSFY4d3FZUDV4YitRZTFNYktsejQvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a6872-7bb8-4d31-5969-08deef18b47c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:30:52.2386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2gPQu4BgrXMRvhuzCna181AWGI8n/lagHXb/vfZ/r+XiHEY+6GpsEAdnVk+AFyK5xodmqUedI4YniAucOR/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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



On 2026-07-30 09:46, Pekka Paalanen wrote:
> On Wed, 22 Jul 2026 09:45:58 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> The limited-/studio-range YCbCr to RGB conversion matrices were generated
>> with colour.matrix_YCbCr(is_legal=True, bits=8), which normalises the
>> narrow range by 2^bits (256 for 8-bit) rather than by the full-range
>> maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
>> chroma scale 256/224 instead of the correct 255/219 and 255/224.
> 
> Hi Harry,
> 
> this is an interesting find. For the previous patch "drm/colorop: Add
> DRM_COLOROP_FIXED_MATRIX" I verified that the matrices match
> colour.matrix_YCbCr(), but this here seems to say all the
> limited range cases are wrong? That patch would need the numbers
> corrected too.
> 

Interestingly this came out of asking Claude LLM to add documentation
to the fixed matrix enums. I asked it to confirm whether the matrix
documentation matches what amdgpu and VKMS do. It then pointed out
that VKMS scales luma against 256, not 255.

So the documented matrices in the "Add DRM_COLOROP_FIXED_MATRIX" patch
are correct, but VKMS's matrices didn't match. This patch fixes it up.

Before this patch I had to increase VKMS's 8 bpc bracket to [-1, 3] in
our IGT tests. Now a [-1, 2] bracket suffices.

>>
>> This over-scales every limited-range conversion by a factor of 256/255,
>> producing an error of up to ~3/255 (8-bit) and causing IGT tests that
>> compare software-computed surfaces against VKMS-processed ones to fail.
>>
>> Recompute the three limited-range matrices from first principles rather
>> than relying on colour's is_legal scaling:
>>
>>  1. Start from the standard ITU-R YCbCr -> RGB relations for the luma
>>     weights Kr, Kb (Kg = 1 - Kr - Kb) of each encoding (BT.601, BT.709
>>     and BT.2020 non-constant luminance). These are the same relations
>>     that produce the existing full-range matrices.
>>  2. Expand the studio input range to full range relative to a full-range
>>     maximum of 2^n - 1: the luma coefficient by 255/(235 - 16) and the
>>     chroma coefficients by 255/(240 - 16). This matches the DRM UAPI
>>     definition and IGT's igt_ycbcr_to_rgb_matrix().
>>  3. Convert each coefficient to S31.32 fixed point (round(coeff * 2^32)).
> 
> I verified the new matrix values assuming that
> colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
> is_legal=False) is correct, and the same with 601 and 2020.
> 

Thanks for verifying. These things are easy to get wrong and I really
appreciate the cross-check.

>>
>> The full-range matrices (is_legal=False) are unaffected as they use exact
>> 1.0/2.0 scaling.
> 
> A what scaling now?
> 

I should've done a better job checking the LLM output here.

This line is obvious nonsense and will be dropped in v5.

I think the LLM ended up confusing similar but unrelated concepts and
then came up with this nonsense.

>> Update the limited-range reference values in the vkms-format KUnit test
>> accordingly: the expected YCbCr inputs now use the studio-range encoding
>> consistent with the corrected matrices (8-bit value v placed at v * 257,
>> i.e. relative to a full-range maximum of 255).
> 
> H.273 describes how to expand the values to any bit size. It maintains
> full precision rather than scales up 8-bit values. The results are
> different than recorded in this patch.
> 

The tests are modified based on VKMS's YUV handling, not H.273. VKMS scales
any 8-bpc RGB and YUV value up to 16-bit unorm by multiplying it by 257 [1].

I'll submit the python script to generate the kunit test values with v5.

[1] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/vkms/vkms_formats.c?ref_type=heads#L280

Harry

> 
> Thanks,
> pq
> 
>> Fixes: fe22d21e9342 ("drm/vkms: Add YUV support")
>> Assisted-by: Copilot:claude-opus-4.8
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 36 ++++++------
>>  drivers/gpu/drm/vkms/vkms_formats.c           | 55 +++++++++++++------
>>  2 files changed, 55 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> index a7788fbc45dc..789c59d07ffb 100644
>> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> @@ -101,12 +101,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>>  		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>  		.n_colors = 6,
>>  		.colors = {
>> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> -			{ "red",   { 0x517b, 0x5a34, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> -			{ "green", { 0x908e, 0x35cc, 0x2237 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> -			{ "blue",  { 0x28f7, 0xf000, 0x6dc9 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> +			{ "red",   { 0x51cd, 0x5a8e, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> +			{ "green", { 0x911e, 0x3602, 0x2259 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> +			{ "blue",  { 0x2920, 0xf0f0, 0x6e37 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>>  		}
>>  	},
>>  	/*
>> @@ -151,12 +151,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>>  		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>  		.n_colors = 6,
>>  		.colors = {
>> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> -			{ "red",   { 0x3e8f, 0x6656, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> -			{ "green", { 0xaca1, 0x29aa, 0x1a45 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> -			{ "blue",  { 0x1fd0, 0xf000, 0x75bb }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> +			{ "red",   { 0x3ece, 0x66bc, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> +			{ "green", { 0xad4e, 0x29d4, 0x1a5f }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> +			{ "blue",  { 0x1ff0, 0xf0f0, 0x7631 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>>  		}
>>  	},
>>  	/*
>> @@ -201,12 +201,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>>  		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>  		.n_colors = 6,
>>  		.colors = {
>> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> -			{ "red",   { 0x4988, 0x60b9, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> -			{ "green", { 0xa47b, 0x2f47, 0x1902 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> -			{ "blue",  { 0x1cfd, 0xf000, 0x76fe }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
>> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
>> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
>> +			{ "red",   { 0x49d2, 0x611a, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
>> +			{ "green", { 0xa520, 0x2f76, 0x191b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
>> +			{ "blue",  { 0x1d1a, 0xf0f0, 0x7775 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>>  		}
>>  	},
>>  };
>> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
>> index dfb8e13cba87..4d5fcaeb82c5 100644
>> --- a/drivers/gpu/drm/vkms/vkms_formats.c
>> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
>> @@ -788,15 +788,36 @@ static const struct conversion_matrix yuv_bt601_full = {
>>  };
>>  
>>  /*
>> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
>> - *                                  is_legal = True,
>> - *                                  bits = 8) * 2**32).astype(int)
>> + * BT.601 limited-/studio-range YCbCr to full-range RGB.
>> + *
>> + * The coefficients are derived as follows:
>> + *
>> + *  1. Take the standard ITU-R YCbCr -> RGB relations for luma weights
>> + *     Kr, Kb (Kg = 1 - Kr - Kb), with Y in [0, 1] and Cb, Cr in
>> + *     [-0.5, 0.5]. For BT.601 Kr = 0.299 and Kb = 0.114:
>> + *
>> + *       R = Y                                + 2 * (1 - Kr)          * Cr
>> + *       G = Y - 2 * (1 - Kb) * Kb / Kg * Cb - 2 * (1 - Kr) * Kr / Kg * Cr
>> + *       B = Y + 2 * (1 - Kb)          * Cb
>> + *
>> + *     These are exactly the yuv_bt601_full coefficients above.
>> + *
>> + *  2. Expand the studio input range to full range, relative to a
>> + *     full-range maximum of 2^n - 1 (255 for 8-bit): the luma
>> + *     coefficient is scaled by 255/(235 - 16) and the chroma
>> + *     coefficients by 255/(240 - 16). This matches the DRM UAPI
>> + *     definition and IGT's igt_ycbcr_to_rgb_matrix(). Note this differs
>> + *     from colour.matrix_YCbCr(is_legal=True), which normalises by 2^n
>> + *     and is thus off by a factor of 256/255.
>> + *
>> + *  3. Convert each coefficient to S31.32 fixed point, i.e.
>> + *     round(coeff * 2^32).
>>   */
>>  static const struct conversion_matrix yuv_bt601_limited = {
>>  	.matrix = {
>> -		{ 5020601039, 0,           6881764740 },
>> -		{ 5020601039, -1689204679, -3505362278 },
>> -		{ 5020601039, 8697922339,  0 },
>> +		{ 5000989317, 0,           6854882848 },
>> +		{ 5000989317, -1682606224, -3491669458 },
>> +		{ 5000989317, 8663946082,  0 },
>>  	},
>>  	.y_offset = 16,
>>  };
>> @@ -816,15 +837,14 @@ static const struct conversion_matrix yuv_bt709_full = {
>>  };
>>  
>>  /*
>> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
>> - *                                  is_legal = True,
>> - *                                  bits = 8) * 2**32).astype(int)
>> + * BT.709 limited-range YCbCr to full-range RGB (Kr = 0.2126, Kb = 0.0722).
>> + * Derived as described for yuv_bt601_limited.
>>   */
>>  static const struct conversion_matrix yuv_bt709_limited = {
>>  	.matrix = {
>> -		{ 5020601039, 0,          7729959424 },
>> -		{ 5020601039, -919487572, -2297803934 },
>> -		{ 5020601039, 9108275786, 0 },
>> +		{ 5000989317, 0,          7699764272 },
>> +		{ 5000989317, -915895824, -2288828138 },
>> +		{ 5000989317, 9072696586, 0 },
>>  	},
>>  	.y_offset = 16,
>>  };
>> @@ -844,15 +864,14 @@ static const struct conversion_matrix yuv_bt2020_full = {
>>  };
>>  
>>  /*
>> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
>> - *                                  is_legal = True,
>> - *                                  bits = 8) * 2**32).astype(int)
>> + * BT.2020 non-constant-luminance limited-range YCbCr to full-range RGB
>> + * (Kr = 0.2627, Kb = 0.0593). Derived as described for yuv_bt601_limited.
>>   */
>>  static const struct conversion_matrix yuv_bt2020_limited = {
>>  	.matrix = {
>> -		{ 5020601039, 0,          7238124312 },
>> -		{ 5020601039, -807714626, -2804506279 },
>> -		{ 5020601039, 9234915964, 0 },
>> +		{ 5000989317, 0,          7209850391 },
>> +		{ 5000989317, -804559491, -2793551177 },
>> +		{ 5000989317, 9198842076, 0 },
>>  	},
>>  	.y_offset = 16,
>>  };
> 

