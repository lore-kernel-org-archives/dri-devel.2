Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B7606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aA9xgn0x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBA210E383;
	Wed, 21 Oct 2026 14:28:23 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AEC10E185;
 Wed, 21 Oct 2026 14:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6XM4cdTdBm6TKssKvxGMHdAE1D1W8Q0vt7z+fgDXQkpBZZmzxAL8iSJRuOqtOyPr4tGrzzvYvv6ElOrwCBMhrc8irLG2RJpQkx2DNkBVlcWzKJUds7zXpan//+ceOUHw0kPAVFGTfOLD9HgYz/5Trq9/ZVhsD/QZPH8sf3RbGXgDCSzhweMT+juq8EcUv/NiQAcH4hEeCPSvbbjERGHW8hMvP6aUz2NjMNnJOnzKJ+gls6YHmU9B2okakwCKIquhaEMmu5O4ssAGUAg17s0Kp10lHYUmDjNKEGQ8DrE4ND1MKneGB93B9ShuXm6LDXUmaZ7tYpObgfRt1PPSvSKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQZptxXZxZCRI6Xg0wZ+s9Z19byAOUO/MCrqiMY2hNE=;
 b=y2+0g9MJaMOt1QSHG4VSVjNzNkRDDJ5MYqm2icw7m6a1wBEYdvoODev1HWGyOCxfuXH3jOio5+JfcGwxNsOMaxa8pUctVbRvgsNm8N7JU1SIrgIOiCx47IWCa6vRB7TafJepENt6k9ZpUY7J/hgZXd1/Cd3Dgdgj/YKI+cOxeAxDwL/na3s6miPipEjpd6huQIVtpKrLCekIRqA85A2UVyOHIUlyZ/JQY3qZzYxsMAPU7NY+yvmZ/6TdrDtphFTe2XxAy7lieti19vpkuckIYghUQC40YGmhhFvJC5lCshBY4wiWOCKShuSHu/xBRyninlW6TVmATF9utXD2f/s59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQZptxXZxZCRI6Xg0wZ+s9Z19byAOUO/MCrqiMY2hNE=;
 b=aA9xgn0xOTkTumkgyrimi7+fsJYfXQG2pX5W7lwOSOAzDpp7+KstbNkOGhTP5IqPmYjLkOUPCQIInggpcwuSQzTMmGccnvKUUZBj6sNjLT+9k3/9N1CjaH5vDLU82AJDLc2s1Q+17SJPMlwWI2lmD5LvjJ3JDbS5FFY57mdsnW4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 14:28:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:28:13 +0000
Message-ID: <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
Date: Wed, 21 Oct 2026 16:28:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: Alex Deucher <alexdeucher@gmail.com>, ukrainer8 <kolomiiec@gmail.com>,
 Leo Liu <leo.liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: dri-devel@lists.freedesktop.org
References: <20261019144916.108589-1-kolomiiec@gmail.com>
 <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8093a1a8-4bdd-4b74-af60-08df2f7f8a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RJlaB/jQ86CWV6RnR/E/B29/nhy9u1p09cUJA7wWBtlI95IuuIy164ra+lwZ1eMMO6vA/sL64F9IffWsqvlsXWATLMt60WPdhQbEVv1EHiRSXnHgLwuBUgFfUDw3uXy9pR7lTQ1LZddjQ233UI+ZJIMLG1jPowxoBl1CLSCvwpbeGv9/VBnS/CeYX+/QihdZHUFnfTmDfHeU106vB8SXBn3iBHeLgkscE1Fz679oqPviFe8f3m/YaB1bDQ8oJvv/SkczzTZO/qstVXDUqguqqbULOjE6MKFT36k/AuE4338Els3RcWmIuJu20R54tqHd5w/pCgwW8Y7zZRKVSpyata1ciKO4J4HPIMGPcpq+kARRoEj5GOZzBzR1T8m2DQM+vihJXDOmiR5JbSIrRNgffLWBEpWfxIh3xvUZc/ANUim4eQpL+87bg63okR/FiqXTn6e5NgDCYxAMHUj0t99lqA4n2KSz8qfpp7c4UaTRgujwNcRtcrrq03+kE6hCn3PTpo2ioWcsXxaA1vBUOv+sWczeqPcdmqYg8HLT5m94diYnp0K1iw+j6mxddSaIoztn8UYhN9m25eHUvqi+NvwNPiNTJ0/iuorhBg4n/5JTmyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pGR2VobGpGUWhXS2ZxRUZIcDJKQi9xVjJ1azIyRjdVMGJZVHcvcElMaEsr?=
 =?utf-8?B?clZRVENtTi9aNVZFalFzaW95YTZ4NGFuVGwzRFdKcTJRbE0rRy83MHE3SExl?=
 =?utf-8?B?TCtrN3hJWG5SeEUrZ0RZZjJnaUpIOHl0Vk9yTnJPVFQ2SlpTcXd1NVlEcy9J?=
 =?utf-8?B?SHhHb0RpdFRtdHJDRDJXcGRxb0ozTnJvTjdtREdpZzBWVWd0SHhIWVJPQ0N4?=
 =?utf-8?B?M0NSWitYYkRjRWY3Ym5ySXdOYWYySFNRd2JyRHFUWHVlTHhOb3RDdWVOL3lz?=
 =?utf-8?B?RmY2emtFYThMQk4vRWg5dFYyLy9pMzhwdWV3U2pPK3pDZVZXTzhPaXQ3S3cy?=
 =?utf-8?B?NHpZN2JxZlZiVHhRUHpTTnNVVUp4OTZ4Z3BtNDVkWkx2R0ZmZkZqNU1lN28y?=
 =?utf-8?B?Y2F3bmtKN3ZTUDNzVUtCaGxwN1VEaUtmVUxxdGVvTHNScnFFaVcvS2VuSnda?=
 =?utf-8?B?dS9CNjlGakVkNlF6SUQ5ZlVacjVuZnp5VWljMnF5bEp5SE1xczJCVzVhbE9W?=
 =?utf-8?B?RGVtekt2Y00vS0hnck5CdUVlQys4S1VPZ1FId0Ura3JRMVdva291YUp5c0l6?=
 =?utf-8?B?YVErOEgrM2xBQ0VNOTVVU2Z5TzlaNDliZGhGUnRGbEg0MUcrdG1pRXdnL3FN?=
 =?utf-8?B?cllPb1lERTV3QXNjQmU0bjE4V0xxcmg4RS9qWjdlaGhRNlVJR05Oa2pMS2ds?=
 =?utf-8?B?ekZXd2tLaVh3dStyQXV2enU5bWdLQW5kYVJDTExBakpzTTllM3VuZ1JuVTh6?=
 =?utf-8?B?VmxUdmJoTUZTZEhKSC8yQUE5amNiTUZtYlJrcEJBWWxFM1dHN2dKbmtVMkhr?=
 =?utf-8?B?UU13cGxzUC92ZVh4NjVTNTMyVGtxSTg0Sm4vWSt4a3d0RElWWGNwZTE2Y3NM?=
 =?utf-8?B?d3c1blV1NjVzL2VHNHUzaFR2d1d6YTdkVGNpc1JDR0l6RC9ST1FEc1kwVWo3?=
 =?utf-8?B?dkYweXpyRTdZamtVVW13N3c5SHU4dmo0dEVSdFZyOTNNVmF3eXUwTVBzRXky?=
 =?utf-8?B?cFZEWHIzMkJGeSt5bFpONkZoRTRBUC9qZDFMYmsycm1ObElISkFQdWpPbThi?=
 =?utf-8?B?dFlrVzVLcW1GMEpreHJUZURCeFQvYW03bW1lN0FFNzRhTTF4c1N0RjlMMWdi?=
 =?utf-8?B?OC9RM3hQbjEzOHdkeDA5K2x2TWcvRUJTcmtRYTdaT2Q2MmRuY1VGNWV0SXRx?=
 =?utf-8?B?TVFBcm0yUjVHTFFiVVEzeEp3ZWFqUUlxWjNpZDBzb2ErTTVKSTI4bHlNQWd5?=
 =?utf-8?B?NGhSWUQ3a1piYTg2cHdWUVBKS2hjOGEwOFZRV2JJTXI4MWtnVElzc1JUQWxa?=
 =?utf-8?B?Z3QzczQxUTdWL3lBSXhJMWpZYXNhRGlKdm9DYTEydFBWRGxUbldnUk1yQzBQ?=
 =?utf-8?B?WTNoclpsWWJmelFNNVY3QnRtQXQ0TU9DT3p4a3lFSklOWlBrUnpWVUxLRU1m?=
 =?utf-8?B?R0VRY1RoVGtzclFvUTJtcXp3aGhTRjZaMnZ0RzV6VmtPRk1ydlVCVzhxTjhZ?=
 =?utf-8?B?aUhOc1NRRm5CZkw4RUZuYWRrTVlDRmszM2hFZHh6SldrbUpudzJLODFhTUF3?=
 =?utf-8?B?ZEUvM3hFclZaMWZVVHlKTDBtN0JvODNCWHlsS3I0cTNlZVZBd3I3bUNyQ3U1?=
 =?utf-8?B?emNKWVhxNVhBTG1UWmlhMmJoWWcwcWlDcmZzWU1pdURSOE93azlkRXJEUjZ0?=
 =?utf-8?B?Y3dKQlhlT243NWhmMlovWnJReE5keTN6anpoWjBseU8wY2h5RDhKY1I3MVRS?=
 =?utf-8?B?NTYwa3B6ekR4YlR6S3orMXRCV2g1dkFmV09UMkRIalVVZEltSVZCUll1aDVy?=
 =?utf-8?B?eHVaWmRXQ2xUSzlsMkNMdHlTWU1lQXh6bFJnalFPcm5ldUsvMk12WFpaSjRh?=
 =?utf-8?B?R3hLMUMyeVZkR0ZTQkNLMFU4Q1d6Q0FvYmljS2Q0a28yUDhhNTdxK2hacE5z?=
 =?utf-8?B?a3Z4VkV0OGlBeEt5TWJ6SVNPY3hOUFl2Z0pkai9qdWMrVzNOemNQSStwWUpH?=
 =?utf-8?B?L2crTDQwNlJHQ1FwUkNnL2ZSR1Y3MmdhZXBmTHBGNmNjaC9Icml0cHgvcEpR?=
 =?utf-8?B?dmdKK1IzbnJrWkVPaktjMm1YVmhtT2R1Y2hNc2p1dTZZWHoveTI1TEloSkdB?=
 =?utf-8?B?ckc4RHFWamdkRlNmVExYRlc4NHMvNE93enhLaTJnR0FsMGI3N0pNU0NWK0pl?=
 =?utf-8?B?WXB2bzYvZEhWdWxicE5ZQk9RQzZQV0lUMXE2WU9vTnQ4NjZ3Y3UxYUkzYjcr?=
 =?utf-8?B?dE9hNnA3WklpMHkxOG92TnBBLzJkaEZNMWVVL01iVzNPek51cG1hcVp6Vnd6?=
 =?utf-8?Q?eC3Aua0ABgqnfoWjQz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8093a1a8-4bdd-4b74-af60-08df2f7f8a0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:28:13.5347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHyhIejFoADvcgSqYLme1n/uxLiXVX96GrUHK+otptrLJQczMueta/vgRIhfCmp9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

That HW is ancient!

The question is really if that works reliable or if that could break anything?

I mean when UVD doesn't work after resume is ugly, but when resume doesn't work at all any more then that would be really bad.

Regards,
Christian.

On 10/21/26 15:29, Alex Deucher wrote:
> + Leo, Christian
> 
> On Tue, Oct 20, 2026 at 3:46 AM ukrainer8 <kolomiiec@gmail.com> wrote:
>>
>> On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
>> suspend intermittently fails the UVD ring test:
>>
>>     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCAFEDEAD)
>>     radeon 0000:01:00.0: failed initializing UVD (-22).
>>
>> Cold boot always succeeds; resume succeeds only in about half of the cycles
>> (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
>> 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD stays
>> dead for the rest of the session and hardware video decode silently falls
>> back to CPU.
>>
>> The resume path runs the same full asic startup as cold boot
>> (evergreen_resume() -> evergreen_startup()), so the difference is the
>> hardware state at entry, not a skipped call. Field data shows the first
>> ring instance after resume is dead functionally, not by timeout: the ring
>> test fails fast and deterministically, and only a full stop+init cycle
>> revives the engine.
>>
>> Fix this the way the Windows driver effectively does it: silently cycle
>> the engine once (clocks up, start, stop, 20 ms settle) before testing,
>> then run the init sequence in a retry loop - on failure of clock setup,
>> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
>> try again (up to 3 attempts). Each retry logs the failing step and the
>> attempt number, which also makes future reports of this failure mode
>> self-diagnosing. The ring-test polling window is widened from 100 ms to
>> 2000 ms as spare capacity; the early-exit poll keeps healthy hardware on
>> the fast path.
>>
>> On the same machine the patched driver went 6/6 OK across repeated test
>> runs, with the warm-up absorbing the dead first instance and zero error
>> lines in dmesg.
>>
>> v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko AI
>> review - MMIO writes to an unclocked UVD block can cause a PCI bus master
>> abort and hard-hang the system.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
>> Link: https://bugs.launchpad.net/bugs/1865130
>> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.0.0
>> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
>> ---
>> v1 -> v2: keep the clock-setup result in a separate variable and only
>> call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI review).
>> Also folded in the silent warm-up cycle and the wider ring-test window
>> validated in field testing since v1.
>>  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++-------------
>> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
>> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
>> @@ -158,24 +158,58 @@
>>  {
>>         struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
>>         uint32_t tmp;
>> -       int r;
>> +       int r, retry, clk_err;
>>
>> -       /* raise clocks while booting up the VCPU */
>> +       /* warm-up: silently cycle the engine once (like the Windows driver),
>> +        * the first ring instance after resume is dead functionally */
>>         if (rdev->family < CHIP_RV740)
>>                 radeon_set_uvd_clocks(rdev, 10000, 10000);
>>         else
>>                 radeon_set_uvd_clocks(rdev, 53300, 40000);
>> +       uvd_v1_0_start(rdev);
>> +       uvd_v1_0_stop(rdev);
>> +       mdelay(20);
>>
>> -       r = uvd_v1_0_start(rdev);
>> -       if (r)
>> -               goto done;
>> +       /* after resume the first ring test can race with the hardware; retry */
>> +       for (retry = 0; retry < 3; retry++) {
>> +               /* raise clocks while booting up the VCPU */
>> +               if (rdev->family < CHIP_RV740)
>> +                       clk_err = radeon_set_uvd_clocks(rdev, 10000, 10000);
>> +               else
>> +                       clk_err = radeon_set_uvd_clocks(rdev, 53300, 40000);
>> +               r = clk_err;
>> +               if (r)
>> +                       drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attempt %d\n",
>> +                                r, retry + 1);
>> +
>> +               if (!r) {
>> +                       r = uvd_v1_0_start(rdev);
>> +                       if (r)
>> +                               drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\n",
>> +                                        r, retry + 1);
>> +               }
>>
>> -       ring->ready = true;
>> -       r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
>> -       if (r) {
>> -               ring->ready = false;
>> -               goto done;
>> +               if (!r) {
>> +                       ring->ready = true;
>> +                       r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
>> +                       if (r) {
>> +                               ring->ready = false;
>> +                               drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d\n",
>> +                                        r, retry + 1);
>> +                       }
>> +               }
>> +
>> +               if (!r)
>> +                       break;
>> +
>> +               /* MMIO is only safe when the block is actually clocked */
>> +               if (!clk_err)
>> +                       uvd_v1_0_stop(rdev);
>> +               if (retry < 2)
>> +                       mdelay(20);
>>         }
>> +       if (r)
>> +               goto done;
>>
>>         r = radeon_ring_lock(rdev, ring, 10);
>>         if (r) {
>> @@ -421,7 +455,8 @@
>>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
>>  {
>>         uint32_t tmp = 0;
>> -       unsigned i;
>> +       /* after resume the ring buffer controller needs ~1.5-2s to settle */
>> +       unsigned i, timeout = 2000000;
>>         int r;
>>
>>         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
>> @@ -434,14 +469,14 @@
>>         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
>>         radeon_ring_write(ring, 0xDEADBEEF);
>>         radeon_ring_unlock_commit(rdev, ring, false);
>> -       for (i = 0; i < rdev->usec_timeout; i++) {
>> +       for (i = 0; i < timeout; i++) {
>>                 tmp = RREG32(UVD_CONTEXT_ID);
>>                 if (tmp == 0xDEADBEEF)
>>                         break;
>>                 udelay(1);
>>         }
>>
>> -       if (i < rdev->usec_timeout) {
>> +       if (i < timeout) {
>>                 drm_info(&rdev->ddev, "ring test on %d succeeded in %d usecs\n",
>>                          ring->idx, i);
>>         } else {

